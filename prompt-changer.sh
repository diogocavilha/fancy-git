FANCYGIT_PROMPT_MODE=$(cat ~/.fancy-git/mode)

if [ "$FANCYGIT_PROMPT_MODE" = "fancy-double-line" ]; then
    . ~/.fancy-git/prompt_styles/fancy-double-line.sh
fi

if [ "$FANCYGIT_PROMPT_MODE" = "default" ]; then
    . ~/.fancy-git/prompt_styles/fancy-original.sh
fi

if [ "$FANCYGIT_PROMPT_MODE" = "simple" ]; then
    . ~/.fancy-git/prompt_styles/simple.sh
fi
