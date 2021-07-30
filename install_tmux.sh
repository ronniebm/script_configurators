# sudo apt update 
# sudo apt install -y tmux

# installing tmux config file.
curl -L https://raw.githubusercontent.com/ronniebm/script_configurators/master/config_files/.tmux.conf > ~/.tmux.conf

# applying changes from config file.
tmux source-file ~/.tmux.conf
