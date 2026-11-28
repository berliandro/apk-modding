import hashlib
import struct
import sys

def lp(buf, off):
    n = struct.unpack_from('<I', buf, off)[0]
    return buf[off + 4:off + 4 + n], off + 4 + n

def seq_lp(buf):
    out, off = [], 0
    while off < len(buf):
        item, off = lp(buf, off)
        out.append(item)
    return out

path = sys.argv[1]
data = open(path, 'rb').read()
for ident, name in ((b'\x1a\x87\x09\x71', 'v2'), (b'\xc0\x68\x53\xf0', 'v3')):
    start = 0
    while True:
        idx = data.find(ident, start)
        if idx < 0:
            break
        start = idx + 1
        pair_len = struct.unpack_from('<Q', data, idx - 8)[0]
        value = data[idx + 4:idx - 8 + pair_len]
        try:
            signers, _ = lp(value, 0)
            for signer in seq_lp(signers):
                signed_data, _ = lp(signer, 0)
                _, off = lp(signed_data, 0)             # digests
                certs_seq, off = lp(signed_data, off)
                for cert in seq_lp(certs_seq):
                    print(name, 'cert SHA-256:', hashlib.sha256(cert).hexdigest())
                    print(name, 'cert SHA-1:', hashlib.sha1(cert).hexdigest())
        except Exception as exc:
            print(name, 'parse error at', idx, exc)
