ProjectDir=/home/dbhosal/FinalProject/code
HomeDir=/home/jabaraho
cd $ProjectDir
for i in {1..12}
do
    if pgrep -x python >/dev/null
    then
        echo "Computer Still in Use"
        sleep 3600
    else
        echo "Ready for 5 epoch run"
        python ./train.py -c config.json || exit 1
        break
    fi
done
echo "Giving up"