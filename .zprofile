export JAVA_HOME=/Users/cy/.sdkman/candidates/java/current
export KOTLIN_HOME=/Users/cy/.sdkman/candidates/kotlin/current
export GRADLE_HOME=/Users/cy/.sdkman/candidates/gradle/current
export ANDROID_SDK_ROOT=/Users/cy/Library/Android/sdk/
export ANDROID_HOME=/Users/cy/Library/Android/sdk/
export FLUTTER_HOME=/opt/homebrew/Caskroom/flutter/3.24.0/flutter/bin

# JetBrains IDE scripts
export PATH="$PATH:/Users/cy/Library/Application Support/JetBrains/Toolbox/scripts"
# Homebrew binaries
export PATH="$PATH:/opt/homebrew/bin/"
# Android tools
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
# Flutter tools
export PATH="$PATH:$FLUTTER_HOME"

eval "$(/opt/homebrew/bin/brew shellenv)"

alias ls="ls -G"
alias ll="ls -alG"

###-begin-flutter-completion-###

if type complete &>/dev/null; then
  __flutter_completion() {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           flutter completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F __flutter_completion flutter
elif type compdef &>/dev/null; then
  __flutter_completion() {
    si=$IFS
    compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                 COMP_LINE=$BUFFER \
                 COMP_POINT=0 \
                 flutter completion -- "${words[@]}" \
                 2>/dev/null)
    IFS=$si
  }
  compdef __flutter_completion flutter
elif type compctl &>/dev/null; then
  __flutter_completion() {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       flutter completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K __flutter_completion flutter
fi

###-end-flutter-completion-###
