#!/bin/bash
HASHED_PASSWORD=`cat /etc/notebook/pwd.txt`
jupyter nbextension enable codefolding/main
jupyter nbextension enable notify/notify
jupyter nbextension enable scratchpad/main
jupyter nbextension enable collapsible_headings/main
jupyter nbextension enable execute_time/ExecuteTime
jupyter notebook --allow-root --no-browser --notebook-dir="$(pwd)/notebooks" --NotebookApp.password="$HASHED_PASSWORD"