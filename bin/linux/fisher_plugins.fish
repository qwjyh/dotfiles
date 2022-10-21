#!/bin/fish

#==========================================================
# fisher plugin install
#==========================================================

# check fisher existence
if ! type fisher &>/dev/null
	echo "fisher does not exist."
	echo "Please install fisher."
	return 1
end

fisher update

# installing packages
fisher install edc/bass
#fisher install jethrokuan/z
fisher install patrickf1/fzf.fish

