SHELL := /bin/bash

push:
	@read -p "Reason? " msg; git commit -am "$$msg"; git push; git status

ghReset:
	git remote set-url origin https://timmenzies@github.com/timmenzies/xai.git
