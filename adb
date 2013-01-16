#list emulators

_adbs()
{
    local prev cur dev cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    preprev="${COMP_WORDS[COMP_CWORD-2]}"
    dev=`adb devices | sed -n '2,$p' | awk '{print $1}'`
    cmds=`adb help 2>&1 | sed -n '/^[ ]\{1,\}adb/p' | awk '{print $2}'`

    case "$prev" in
        -s)
            COMPREPLY=( $(compgen -W "${dev}" ${cur}) )
            return 0
            ;;
        *)
            ;;
    esac

    case "$preprev" in
        -s)
            export ANDROID_SERIAL="${prev}"
            ;;
    esac

    COMPREPLY=( $(compgen -W "${cmds} devices connect disconnect" ${cur}) )
}

complete -o bashdefault -o default -F _adbs adb
