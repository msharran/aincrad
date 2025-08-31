# OrbStack + Kitty's magic. 
function centos
    kitten ssh -t centos@orb "cd $(pwd) && kitten run-shell"
end
