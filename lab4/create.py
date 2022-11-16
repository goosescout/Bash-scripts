import os
import stat


START = 1
END = 4
FILENAMES = ["rmtrash", "untrash", "backup", "upback"]

for file in FILENAMES:
    f = open(f"{file}.sh", "w")
    f.write("#!/bin/bash\n")
    f.close()
    st = os.stat(f"{file}.sh")
    os.chmod(f"{file}.sh", st.st_mode | stat.S_IEXEC)
