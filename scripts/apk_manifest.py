import struct, sys, zipfile

def u16(b, o): return struct.unpack_from('<H', b, o)[0]
def u32(b, o): return struct.unpack_from('<I', b, o)[0]

def pool(b, off):
    n = u32(b, off + 8)
    start = u32(b, off + 20)
    utf8 = bool(u32(b, off + 16) & 0x100)
    out = []
    for i in range(n):
        p = off + start + u32(b, off + 28 + 4 * i)
        if utf8:
            l = b[p]; p += 1
            if l & 0x80: l = ((l & 0x7f) << 8) | b[p]; p += 1
            bl = b[p]; p += 1
            if bl & 0x80: bl = ((bl & 0x7f) << 8) | b[p]; p += 1
            out.append(b[p:p+bl].decode('utf-8', 'replace'))
        else:
            l = u16(b, p); p += 2
            if l & 0x8000: l = ((l & 0x7fff) << 16) | u16(b, p); p += 2
            out.append(b[p:p+l*2].decode('utf-16le', 'replace'))
    return out

b = zipfile.ZipFile(sys.argv[1]).read('AndroidManifest.xml')
off = 8
strings = []
count = 0
while off + 8 <= len(b):
    typ, hs, sz = u16(b, off), u16(b, off + 2), u32(b, off + 4)
    if sz < 8:
        break
    if typ == 0x0001:
        strings = pool(b, off)
    elif typ == 0x0102:
        name = strings[u32(b, off + 20)] if u32(b, off + 20) < len(strings) else '?'
        if count < 12:
            print('element', off, repr(name))
        count += 1
        if name == 'manifest':
            astart = u16(b, off + 24)
            asize = u16(b, off + 26)
            acount = u16(b, off + 28)
            for i in range(acount):
                ao = off + 16 + astart + i * asize
                an = strings[u32(b, ao + 4)] if u32(b, ao + 4) < len(strings) else '?'
                raw = u32(b, ao + 8)
                val = strings[raw] if raw < len(strings) and raw != 0xffffffff else '(typed)'
                if an == 'versionCode' and val == '(typed)':
                    val = u32(b, ao + 16)  # typed value data field
                if an in ('package', 'versionName', 'versionCode'):
                    print('  ATTR', an, '=', val)
            break
    off += sz
