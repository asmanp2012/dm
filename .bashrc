export DM_BIN="${DEV_TOOLS}/dm/bin"
export PATH="${PATH}:${DM_BIN}"

_dm_complete() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    opts="clean lsdc lsnet lsi lsn rmi renameimg sshc rmc stop start commit save load export import run ps images menu --help --menu --version"
    
    # دستور اول
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
        return 0
    fi
    
    # بر اساس دستور اول
    case "${COMP_WORDS[1]}" in
        rmi|renameimg|save|import)
            # ایمیج‌ها برای آرگومان دوم
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                local images=$(sudo docker images --format "{{.Repository}}:{{.Tag}}" 2>/dev/null)
                COMPREPLY=($(compgen -W "${images}" -- "${cur}"))
            fi
            ;;
        sshc|rmc|stop|start|commit|clean|export)
            # کانتینرها برای آرگومان دوم
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                local containers=$(sudo docker ps -a --format "{{.Names}}" 2>/dev/null)
                COMPREPLY=($(compgen -W "${containers}" -- "${cur}"))
            fi
            ;;
        load|import)
            # فایل‌های tar
            if [[ ${COMP_CWORD} -eq 2 ]]; then
                COMPREPLY=($(compgen -f -X '!*.tar' -- "${cur}"))
            fi
            ;;
        run)
            case ${COMP_CWORD} in
                2)
                    # نام کانتینر
                    local containers=$(sudo docker ps -a --format "{{.Names}}" 2>/dev/null)
                    local suggestions="app web db api redis"
                    COMPREPLY=($(compgen -W "${containers} ${suggestions}" -- "${cur}"))
                    ;;
                3)
                    # پورت‌ها
                    COMPREPLY=($(compgen -W "8080:80 3000:3000 5432:5432 6379:6379 80:80 443:443 222:22 8081:80" -- "${cur}"))
                    ;;
                4)
                    # ایمیج
                    local images=$(sudo docker images --format "{{.Repository}}:{{.Tag}}" 2>/dev/null)
                    COMPREPLY=($(compgen -W "${images}" -- "${cur}"))
                    ;;
                5)
                    # CMD اختیاری
                    COMPREPLY=($(compgen -W "'/usr/bin/supervisord -n' '/bin/bash' '/bin/sh'" -- "${cur}"))
                    ;;
            esac
            ;;
        export)
            case ${COMP_CWORD} in
                2)
                    # کانتینرها
                    local containers=$(sudo docker ps -a --format "{{.Names}}" 2>/dev/null)
                    COMPREPLY=($(compgen -W "${containers}" -- "${cur}"))
                    ;;
                3)
                    # فایل‌های tar
                    COMPREPLY=($(compgen -f -X '!*.tar' -- "${cur}"))
                    ;;
            esac
            ;;
        ps|images)
            # آپشن‌های docker
            if [[ ${cur} == -* ]]; then
                local docker_opts="-a -q --filter --format --no-trunc --size -s"
                COMPREPLY=($(compgen -W "${docker_opts}" -- "${cur}"))
            fi
            ;;
    esac
}

complete -F _dm_complete dm