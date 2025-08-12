#!/usr/bin/sh

configs=(
  "aliases:$HOME/dotfiles/aliases/.aliases/aliases"
  "alacritty:$HOME/dotfiles/alacritty/.config/alacritty/alacritty.toml"
  "wezterm:$HOME/dotfiles/wezterm/.config/wezterm/wezterm.lua"
  "awesome:$HOME/dotfiles/awesome/.config/awesome/rc.lua"
  "kitty:$HOME/dotfiles/kitty/.config/kitty/kitty.conf"
  "hyprland:$HOME/dotfiles/hypr/.config/hypr/hyprland.conf"
  "vim:$HOME/dotfiles/vim/.vimrc"
  "neovim:$HOME/dotfiles/nvim/.config/nvim/init.lua"
  "starship:$HOME/dotfiles/starship/.config/starship.toml"
  "tmux:$HOME/dotfiles/tmux/.tmux.conf"
  "zathura:$HOME/dotfiles/zathura/.config/zathura/zathurarc"
  "zsh:$HOME/dotfiles/zsh/.zshrc"
  "yazi:$HOME/dotfiles/yazi/.config/yazi/keymap.toml"
  "ghostty:$HOME/dotfiles/ghostty/.config/ghostty/config"
)

configs=$(printf '%s\n' "${configs[@]}")

# Detect whether we're in a Wayland or X11 session
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  # Wayland session - use rofi with theme override
  launcher=(rofi -dmenu -l 10 -theme-str "window { width: 45%; }")
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  # X11 session - use dmenu
  launcher=(dmenu -i -l 10 -p 'open config file')
else
  echo "Error: Could not detect display server (Wayland or X11)."
  exit 1
fi

program_names=$(echo "$configs" | cut -d':' -f1)

choice=$(echo "$program_names" | "${launcher[@]}")

# Exit silently if Escape was pressed or menu was closed
[ -z "$choice" ] && exit 0

file=$(echo "$configs" | grep -w "$choice" | cut -d':' -f2)

cwd=$(dirname "$file")
kitty -e nvim -c "cd $cwd" "$file"
