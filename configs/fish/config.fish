if status is-interactive
    # Commands to run in interactive sessions can go here
    alias cfg="cd ~/dotfiles/configs"
    alias scr="cd ~/dotfiles/configs/my-scripts/"
    alias lis="cd ~/dotfiles/configs/my-lists/"
    alias home="cd ~/"
    starship init fish | source
end

# pnpm
set -gx PNPM_HOME "/home/subzcuber/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
