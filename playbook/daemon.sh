#!/bin/bash
LOG_FILE=/tmp/ansible-project.log
function daemon() {
    count=0
    chsum1=""
        while [[ true ]]
        do
            chsum2=`find ./ -type f \( ! -name "*.swp" \) -exec md5sum {} \;`
            if [[ $chsum1 != $chsum2 ]] ; then           
                # save latest execution logs
                START_TIME = $(date +%s)
                if [[ $count -gt 5 ]]; then
                  echo "Detect file changed at: $(date)" > $LOG_FILE
                  count=0
                else
                  echo "Detect file changed at: $(date)" >> $LOG_FILE
                fi
                ./run.sh >> /tmp/ansible-project.log
                chsum1=$chsum2
                ((count++))
                END_TIME = $(date +%s)
                echo "Process took $(( $END_TIME - $START_TIME)) seconds to complete..." >> $LOG_FILE
            fi
            sleep 2
        done
}
daemon &
