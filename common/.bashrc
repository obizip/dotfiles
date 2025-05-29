[ -z "$PS1" ] && return # if not interactive, then do nothing

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

CONFIG_DIR="${XDG_CONFIG_HOME}/bash/conf.d"
if [ -d ${CONFIG_DIR} ]; then
  configs=(`find $CONFIG_DIR -name "*.sh" | sort`)
  for config in ${configs[*]}; do
    source $config
  done
fi

