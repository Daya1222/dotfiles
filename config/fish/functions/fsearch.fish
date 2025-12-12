# Quick search in files
function fsearch
    if test (count $argv) -lt 2
        echo "Usage: fsearch <pattern> <directory>"
        return
    end
    grep -rnw $argv[2] -e $argv[1]
end
