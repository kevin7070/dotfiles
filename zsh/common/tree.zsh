# ============================================================================
# Tree and Git Tools
# ============================================================================

# tree aliases
alias t="tree -C"
alias ta="tree -a -C"
alias ts="tree -shC"
alias td="tree -d -C"
alias t2="tree -L 2 -C"
alias t3="tree -L 3 -C"
alias t4="tree -L 4 -C"
alias t5="tree -L 5 -C"
alias t6="tree -L 6 -C"
alias t7="tree -L 7 -C"
alias t8="tree -L 8 -C"
alias trepo="git ls-files --cached --others --exclude-standard | tree --fromfile"

# lazygit
alias lg="rm -rf .git/index.lock && lazygit"
