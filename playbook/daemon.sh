#!/bin/bash
function daemon() {
    count=0
    chsum1=""
        while [[ true ]]
        do
            chsum2=`find ./ -type f \( ! -name "*.swp" \) -exec md5sum {} \;`
            if [[ $chsum1 != $chsum2 ]] ; then           
                # save 10 latest execution logs
                if [[ $count -gt 10 ]]; then
                  echo "Detect file changed at: $(date)" > /tmp/ansible-project.log
                  count=0
                else
                  echo "Detect file changed at: $(date)" >> /tmp/ansible-project.log
                fi
                ./run.sh >> /tmp/ansible-project.log
                chsum1=$chsum2
                ((count++))
            fi
            sleep 2
        done
}
daemon &
