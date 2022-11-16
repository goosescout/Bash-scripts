import os
import stat


START = 1
END = 7

for i in range(START, END + 1):
    f = open(f"task{i}.sh", "w")
    f.write("#!/bin/bash\n")
    f.close()
    st = os.stat(f"task{i}.sh")
    os.chmod(f"task{i}.sh", st.st_mode | stat.S_IEXEC)
