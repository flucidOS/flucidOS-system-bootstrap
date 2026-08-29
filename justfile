# justfile for flucidOS-system-bootstrap

build:
	bst build all.bst

unadjusted:
	bst build unadjusted.bst

adjusted:
	bst build adjusted.bst

track:
	bst track --all

shell pkg:
	bst shell --build pkgs/{{pkg}}.bst
