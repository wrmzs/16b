import os, sys

programs = os.listdir("programs")
programs.sort()

for p in programs:
    ret = os.system("nasm -f bin programs/" + p +" -o " + p[:-3] + "bin")
    if ret:
        sys.exit(1)

f = open("filetable.bin", "wb")

for p in programs:
    s = p[:-4]
    s += "\0" * (8 - len(s))
    f.write(s.encode())

f.close()

size = os.path.getsize("filetable.bin")
ret = os.system("dd if=/dev/zero of=filetable.bin seek=" + str(size) + " bs=1 count=" + str(512 - size))
if ret:
    sys.exit(1)

for p in programs:
    size = os.path.getsize(p[:-3] + "bin")
    ret = os.system("dd if=/dev/zero of=" + p[:-3] + "bin seek=" + str(size) + " bs=1 count=" + str(512 - size))
    if ret:
        sys.exit(1)

for i in range(0, len(programs)):
    programs[i] = programs[i][:-3] + "bin"

list = " ".join(programs)

ret = os.system("cat " + list + " > programs.bin")
if ret:
    sys.exit(1)
        
    
