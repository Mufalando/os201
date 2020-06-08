#!/bin/bash
filename1=$1
PREFIX="OS/>"
date="-1"
status="SEQOK"
waktu="-1"
statusSha="SUMOK"

USER=$2
TIME=$(date "+%y%m%d-%H%M%S")

if [[ $USER != "Mufalando" ]]; then
    temp2=$(head -n 1 $filename1 | cut -c 19-46);
else 
    temp2=$(head -n 1 $filename1 | cut -c 19-38);
fi
temp3=$(date -d "$temp2" "+%y%m%d-%H%M%S");
date=$(echo $temp3 | cut -c 1-6);
waktu=$(echo $temp3 | cut -c 8-14);

echo "Mufalando ZCZCSCRIPTSTART $TIME $USER\n"
for line in `cat $filename1`
do
    if [[ $line =~ ^[0-9]{6}-[0-9]{6} ]]; then
        IFS='-';
        read -a strarr <<< "$line";
        IFS='/';
        read -a lastarr <<< ${strarr[3]};
        
        if (( ${strarr[0]} >= $date )); then
            read date <<< ${strarr[0]};
        else
            read status <<< "SEQNO";
        fi

        if (( ${strarr[1]} >= $waktu )); then
            read waktu <<< ${strarr[1]};
        else
            read status <<< "SEQNO";
        fi

        shaC=$(echo "${strarr[0]}-${strarr[1]}-$USER-${lastarr[0]}" | sha1sum | cut -c 1-8)
        if [[ ${strarr[2]} != $(cut -c 1-4 <<< $shaC) ]]; then
            read statusSha <<< "SUMNO";
        fi

        IFS='>';
        read -a printarr <<< $line;
        echo "Mufalando $USER ${printarr[0]} ${strarr[0]}-${strarr[1]} $status $statusSha $shaC\n"
    fi
done

if [[ $USER != "Mufalando" ]]; then
    temp4=$(tail -n 1 $filename1 | cut -c 16-43);
else 
    temp4=$(tail -n 1 $filename1 | cut -c 16-35);
fi

temp5=$(date -d "$temp4" "+%y%m%d-%H%M%S");
if (( $(echo $temp5 | cut -c 1-6) >= $date )); then
    read date <<< ${strarr[0]};
else
    read status <<< "SEQNO";
fi

if (( $(echo $temp5 | cut -c 8-14) >= $waktu )); then
    read waktu <<< ${strarr[1]};
else
    read status <<< "SEQNO";
fi

TIME=$(date +"%y%m%d-%H%M%S");
echo "Mufalando ZCZCSCRIPTSTART $TIME $status\n";