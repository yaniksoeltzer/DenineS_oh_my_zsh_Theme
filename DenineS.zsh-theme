
function get_pwd(){
  git_root=$PWD
  while [[ $git_root != / && ! -e $git_root/.git ]]; do
    git_root=$git_root:h
  done
  if [[ $git_root = / ]] || [[ $git_root = $HOME ]]; then
    unset git_root
    prompt_short_dir=%~
  else
    parent=${git_root%\/*}
    prompt_short_dir=${PWD#$parent/}
  fi
  echo $prompt_short_dir
}
function get_none_master_branch(){
  branch=$(git_current_branch)
  if [[ $branch != master ]] && [[ $branch != main ]] && [[ $branch != "" ]]; then
    echo "@$branch "
  fi
}

PROMPT='$(parse_git_dirty) %{$fg[white]%}${HOST:0:3}: $(get_pwd) %{$fg[cyan]%}$(get_none_master_branch)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%(?:%{$fg_bold[yellow]%}λ:%{$fg_bold[red]%}λ%s)"
ZSH_THEME_GIT_PROMPT_CLEAN="%(?:%{$fg_bold[green]%}λ:%{$fg_bold[red]%}λ%s)"
