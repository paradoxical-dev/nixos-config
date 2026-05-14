{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.userSettings.fzf;
in
{
  options = {
    userSettings.fzf = {
      enable = lib.mkEnableOption "Enable fzf";
    };
  };
  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
    };
    # custom fzf scripts
    home.packages = [
      # git log viewer
      (pkgs.writeScriptBin "fzf-git-log" ''
        git log --oneline --color=never | ${pkgs.fzf}/bin/fzf --style full \
            --border --padding 1,2 \
            --border-label ' Git Log ' --input-label ' Search ' --header-label ' Commit Info ' \
            --preview '${pkgs.git}/bin/git show --stat --color=always {1}' \
            --bind 'result:transform-list-label:
                if [[ -z $FZF_QUERY ]]; then
                  echo " $FZF_MATCH_COUNT commits "
                else
                  echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
                fi
                ' \
            --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {1}' \
            --bind 'focus:+transform-header:
                hash={1}
                if [[ -n "$hash" ]]; then
                  ${pkgs.git}/bin/git log -1 --format="Hash: %H%nDate: %cd" --date=format:"%Y-%m-%d %H:%M:%S" "$hash"
                else
                  echo "No commit selected"
                fi
                ' \
            --bind 'ctrl-r:change-list-label( Reloading the list )+reload(${pkgs.git}/bin/git log --oneline --color=never)' \
            --color 'input-border:#d08770,input-label:#d79784' \
      '')
      # git diff
      (pkgs.writeScriptBin "fzf-git-diff" ''
        { ${pkgs.git}/bin/git diff --name-only; ${pkgs.git}/bin/git diff --name-only --cached; } | \
            ${pkgs.coreutils}/bin/sort -u | ${pkgs.fzf}/bin/fzf --style full \
            --border --padding 1,2 \
            --border-label ' Git Diff ' --input-label ' Search ' --header-label ' File Info ' \
            --preview '
                if ${pkgs.git}/bin/git diff --name-only --cached | grep -q "^{}$"; then
                  ${pkgs.git}/bin/git diff --cached --color=always {}
                else
                  ${pkgs.git}/bin/git diff --color=always {}
                fi
                ' \
            --bind 'result:transform-list-label:
                if [[ -z $FZF_QUERY ]]; then
                  echo " $FZF_MATCH_COUNT changed files "
                else
                  echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
                fi
                ' \
            --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Diff for [%s] " {}' \
            --bind 'focus:+transform-header:
                file={}
                if [[ -n "$file" ]]; then
                  staged=$(${pkgs.git}/bin/git diff --name-only --cached | grep -q "^$file$" && echo "Yes" || echo "No")
                  additions=$(${pkgs.git}/bin/git diff --stat "$file" 2>/dev/null | grep -oP "\d+ insertion" | grep -oP "\d+")
                  deletions=$(${pkgs.git}/bin/git diff --stat "$file" 2>/dev/null | grep -oP "\d+ deletion" | grep -oP "\d+")
                  echo "File:      $file"
                  echo "Staged:    $staged"
                  echo "Additions: ''${"additions:-0"}"
                  echo "Deletions: ''${"deletions:-0"}"
                else
                  echo "No file selected"
                fi
                ' \
            --bind 'ctrl-s:execute(${pkgs.git}/bin/git add {})+reload({ ${pkgs.git}/bin/git diff --name-only; ${pkgs.git}/bin/git diff --name-only --cached; } | ${pkgs.coreutils}/bin/sort -u)' \
            --bind 'ctrl-u:execute(${pkgs.git}/bin/git restore --staged {})+reload({ ${pkgs.git}/bin/git diff --name-only; ${pkgs.git}/bin/git diff --name-only --cached; } | ${pkgs.coreutils}/bin/sort -u)' \
            --bind 'ctrl-r:change-list-label( Reloading the list )+reload({ ${pkgs.git}/bin/git diff --name-only; ${pkgs.git}/bin/git diff --name-only --cached; } | ${pkgs.coreutils}/bin/sort -u)' \
            --color 'input-border:#d08770,input-label:#d79784' \
      '')
      # man pages
      (pkgs.writeScriptBin "fzf-man" ''
        ${pkgs.man}/bin/man -k . | ${pkgs.fzf}/bin/fzf --style full \
            --border --padding 1,2 \
            --border-label ' Man Pages ' --input-label ' Search ' --header-label ' Section ' \
            --preview '${pkgs.man}/bin/man {1} 2>/dev/null | ${pkgs.coreutils}/bin/head -100' \
            --bind 'result:transform-list-label:
                if [[ -z $FZF_QUERY ]]; then
                  echo " $FZF_MATCH_COUNT pages "
                else
                  echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
                fi
                ' \
            --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {1}' \
            --bind 'focus:+transform-header:
                page={1}
                if [[ -n "$page" ]]; then
                  echo {} | ${pkgs.gnused}/bin/sed "s/.*(\(.*\)).*/Section: \1/"
                else
                  echo "No page selected"
                fi
                ' \
            --bind 'enter:execute(${pkgs.man}/bin/man {1})' \
            --bind 'ctrl-r:change-list-label( Reloading the list )+reload(${pkgs.man}/bin/man -k .)' \
            --color 'input-border:#d08770,input-label:#d79784' \
      '')
      # kill process
      (pkgs.writeScriptBin "fzf-kill" ''
        ${pkgs.procps}/bin/ps aux | tail -n +2 | ${pkgs.fzf}/bin/fzf --style full \
            --border --padding 1,2 \
            --border-label ' Processes ' --input-label ' Search ' --header-label ' Process Info ' \
            --preview '
                pid={2}
                if [[ -n "$pid" ]]; then
                  ${pkgs.procps}/bin/ps -p "$pid" -o user=,pid=,ppid=,%cpu=,%mem=,vsz=,rss=,stat=,start=,time=,command= 2>/dev/null | \
                  ${pkgs.gawk}/bin/awk "{
                    printf \"USER:    %s\n\", \$1
                    printf \"PID:     %s\n\", \$2
                    printf \"PPID:    %s\n\", \$3
                    printf \"%%CPU:    %s\n\", \$4
                    printf \"%%MEM:    %s\n\", \$5
                    printf \"VSZ:     %s KB\n\", \$6
                    printf \"RSS:     %s KB\n\", \$7
                    printf \"STAT:    %s\n\", \$8
                    printf \"START:   %s\n\", \$9
                    printf \"TIME:    %s\n\", \$10
                    printf \"COMMAND: \"
                    for(i=11;i<=NF;i++) printf \"%s \", \$i
                    printf \"\n\"
                  }"
                fi
                ' \
            --bind 'result:transform-list-label:
                if [[ -z $FZF_QUERY ]]; then
                  echo " $FZF_MATCH_COUNT processes "
                else
                  echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
                fi
                ' \
            --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " PID [%s] " {2}' \
            --bind 'focus:+transform-header:
                pid={2}
                if [[ -n "$pid" ]]; then
                  echo "PID:     $pid"
                  echo "USER:    {1}"
                  echo "%CPU:    {3}%"
                  echo "%MEM:    {4}%"
                  echo "COMMAND: {11}"
                else
                  echo "No process selected"
                fi
                ' \
            --bind 'enter:execute(kill -15 {2})+reload(${pkgs.procps}/bin/ps aux | tail -n +2)' \
            --bind 'ctrl-r:change-list-label( Reloading the list )+reload(${pkgs.procps}/bin/ps aux | tail -n +2)' \
            --color 'input-border:#d08770,input-label:#d79784' \
      '')
      # ssh hosts
      (pkgs.writeScriptBin "fzf-ssh" ''
        grep -E "^Host " ~/.ssh/config | ${pkgs.gawk}/bin/awk '{print $2}' | grep -v '\*' | \
            ${pkgs.fzf}/bin/fzf --style full \
            --border --padding 1,2 \
            --border-label ' SSH Hosts ' --input-label ' Search ' --header-label ' Host Info ' \
            --preview '${pkgs.gnused}/bin/sed -n "/^Host {}/,/^Host /p" ~/.ssh/config | head -20' \
            --bind 'result:transform-list-label:
                if [[ -z $FZF_QUERY ]]; then
                  echo " $FZF_MATCH_COUNT hosts "
                else
                  echo " $FZF_MATCH_COUNT matches for [$FZF_QUERY] "
                fi
                ' \
            --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Config for [%s] " {}' \
            --bind 'focus:+transform-header:
                host={}
                if [[ -n "$host" ]]; then
                  hostname=$(${pkgs.gnused}/bin/sed -n "/^Host $host$/,/^Host /p" ~/.ssh/config | grep -i "HostName" | ${pkgs.gawk}/bin/awk "{print \$2}")
                  user=$(${pkgs.gnused}/bin/sed -n "/^Host $host$/,/^Host /p" ~/.ssh/config | grep -i "User" | ${pkgs.gawk}/bin/awk "{print \$2}")
                  port=$(${pkgs.gnused}/bin/sed -n "/^Host $host$/,/^Host /p" ~/.ssh/config | grep -i "Port" | ${pkgs.gawk}/bin/awk "{print \$2}")
                  echo "Alias:    $host"
                  echo "Hostname: ''${hostname:-N/A}"
                  echo "User:     ''${user:-N/A}"
                  echo "Port:     ''${port:-22}"
                else
                  echo "No host selected"
                fi
                ' \
            --bind 'enter:execute(${pkgs.openssh}/bin/ssh {})' \
            --bind 'ctrl-r:change-list-label( Reloading the list )+reload(grep -E "^Host " ~/.ssh/config | ${pkgs.gawk}/bin/awk "{print \$2}" | grep -v "*")' \
            --color 'input-border:#d08770,input-label:#d79784' \
      '')
    ];
  };
}
