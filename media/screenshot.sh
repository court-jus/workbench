#!/bin/bash

SHOTSDIR=${HOME}

cd ${SHOTSDIR}

if [ $1 == "-l" ]; then

    ls ${SHOTSDIR}/*scrot.png || exit

    scrot=$(ls -rt ${SHOTSDIR}/*scrot.png | tail -n1)

    ans=$(cat ~/bin/scrot/actions.lst | zenity \
        --title="Screenshot $scrot" \
        --text="Action ?" \
        --width=800 \
        --height=600 \
        --list \
        --ok-label="Run" \
        --cancel-label="Cancel" \
        --column=Action \
        --column=Description \
        --print-column=1 \
    )

    case $ans in
        move )
            if newname=$(zenity \
                --title="New name" \
                --width=800 \
                --height=600 \
                --file-selection \
                --save \
                --confirm-overwrite
            ); then
                echo $newname | xclip -i -selection clipboard
                mv -v "$scrot" "$newname"
            else
                echo "Abandon"
            fi
            ;;
        display )
            eog $scrot
            ;;
        gimp )
            gimp $scrot
            ;;
        copypath )
            echo $scrot | xclip -i -selection clipboard
            ;;
        mail )
            icedove -compose "attachment=file://$scrot"
            ;;
        remove )
            rm "$scrot"
            ;;
    esac
else
    scrot $@ -e 'eog $f'
fi
