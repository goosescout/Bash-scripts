import os
import stat


for i in range(2, 11):
    f = open(f"task{i}.sh", "w")
    f.write("#!/bin/bash\n")
    f.close()
    st = os.stat(f"task{i}.sh")
    os.chmod(f"task{i}.sh", st.st_mode | stat.S_IEXEC)
