fancygit_prompt_mode=$(cat ~/.fancy-git/mode)
fancygit_fallback_style="default.sh"
fancygit_styles_dir="/home/$USER/.fancy-git/prompt_styles"
fancygit_style_path="$fancygit_styles_dir/$fancygit_prompt_mode.sh"
fancygit_prompt_command=". $fancygit_style_path"
fancygit_prompt_command_fallback=". $fancygit_styles_dir/$fancygit_fallback_style"

if [ -e "$fancygit_style_path" ]; then
    eval $fancygit_prompt_command
else
    eval $fancygit_prompt_command_fallback
fi
