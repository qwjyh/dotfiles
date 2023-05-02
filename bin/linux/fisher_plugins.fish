#!/bin/fish

#==========================================================
# fisher plugin install
#==========================================================

# check fisher existence
if ! type fisher &>/dev/null
	echo "fisher does not exist."
	echo "Please install fisher from https://github.com/jorgebucaran/fisher"
	echo ""
	echo "==Automatic install=="
	echo "You can run `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher` right here"
	echo "be sure to check install command on the fisher project homepage."
	read -p "echo Install with the script above\?(default Y / N):\ " ans
	if [ $ans = 'N' ]
		return 1
	end
	# install script from github page
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
end

fisher update

# installing packages
fisher install edc/bass
fisher install jethrokuan/z
fisher install patrickf1/fzf.fish

