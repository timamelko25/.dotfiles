#!/bin/bash

echo "Installing tmux"
sudo pacman -S --noconfirm tmux


echo "Creating tmux config"

cat > ~/.tmux.conf << 'EOL'
# 1. Цветовая палитра Visual Studio Dark
set -g status-bg '#1e1e1e'
set -g status-fg '#d4d4d4'
set -g status-style bg='#1e1e1e',fg='#d4d4d4'

# 2. Цвет текущего окна (яркий синий акцент)
set-window-option -g window-status-current-style bg='#264f78',fg='#ffffff'
set-window-option -g window-status-current-format ' #I:#W '

# 3. Цвет неактивных окон (более тёмный)
set-window-option -g window-status-style bg='#1e1e1e',fg='#6a9955'
set-window-option -g window-status-format ' #I:#W '

# 4. Цвет имени сессии (слева)
set -g status-left '#[fg=#dcdcaa,bg=#1e1e1e] #S #[default]'
set -g status-left-length 20

# 5. Цвет времени (справа)
set -g status-right '#[fg=#dcdcaa,bg=#1e1e1e] %Y-%m-%d %H:%M #[default]'
set -g status-right-length 50

# 6. Границы панелей (тонкие, яркие при фокусе)
set -g pane-border-style fg='#3c3c3c'
set -g pane-active-border-style fg='#569cd6'

# 7. Цвет курсора в copy-mode (тёмный режим)
setw -g mode-style bg='#264f78',fg='#ffffff'

# 8. Мышь и прокрутка
set -g mouse on
bind -T root WheelUpPane if-shell -F -t= "#{mouse_any_flag}" "copy-mode -e" "send-keys -M"
bind -T root WheelUpPane if-shell -F -t= "#{mouse_any_flag}" "send-keys -M" "copy-mode -e"

# 9. Выделение в copy-mode
setw -g mode-keys vi
bind-key -T copy-mode-vi v send -X begin-selection
bind-key -T copy-mode-vi y send -X copy-selection

# 10. Удаляем лишние элементы
set -g status-interval 2
EOL

