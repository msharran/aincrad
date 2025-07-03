function flushdns
    sudo killall -HUP mDNSResponder
end

function killport
    # argv[1] port
    # argv[2] proto supported by /etc/protocols (Optional)

    if test -z $argv[2]
        set proto "tcp"
    else
        set proto $argv[2]
    end

    set pid (lsof -i $proto:$argv[1] -s $proto:LISTEN | tail -1 | awk '{print $2}')
    if test -z $pid
        echo "No process on port $argv[1]" >&2
    else
        echo "Killing process $pid on port $argv[1]"
        kill -9 $pid
    end
end

abbr --add l eza
