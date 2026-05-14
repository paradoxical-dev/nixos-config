# INFO: Taken from this github issue - https://github.com/junegunn/fzf/issues/4122
# Adds the default fzf bindings to nushell with custom commands

# Dependencies: `fd`, `bat`, `rg`, `nufmt`, `tree`.

# Directories - Alt+C
const alt_c = {
    name: fzf_dirs
    modifier: alt
    keycode: char_c
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand
        cmd: "
          let result = (fd --type directory --hidden | fzf --height=20 --preview 'eza --icons=always --color=always --tree --level=2 {} | head -n 200' | str trim);
          if ($result | is-not-empty) { cd $result }
        "
      }
    ]
}

# History - Ctrl+R
const ctrl_r = {
  name: history_menu
  modifier: control
  keycode: char_r
  mode: [emacs, vi_insert, vi_normal]
  event: [
    {
      send: executehostcommand
      cmd: "
        let result = (history
          | get command
          | str replace --all (char newline) ' '
          | to text
          | fzf --height=20);
        commandline edit --replace $result;
        commandline set-cursor --end
      "
    }
  ]
}

# Files - Ctrl+T
const ctrl_t = {
    name: fzf_files
    modifier: control
    keycode: char_t
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: executehostcommand
        cmd: "
          let result = (fd --type file --hidden | fzf --height=50% --preview 'bat --color=always --style=full --line-range=:500 {}' | str trim);
          if ($result | is-not-empty) {
            commandline edit --append $result;
            commandline set-cursor --end
          }
        "
      }
    ]
}

# Update the $env.config
export-env {
  if not ($env.__keybindings_loaded? | default false) {
    $env.__keybindings_loaded = true
    $env.config.keybindings = $env.config.keybindings | append [
      $alt_c
      $ctrl_r
      $ctrl_t
    ]
  }
}
