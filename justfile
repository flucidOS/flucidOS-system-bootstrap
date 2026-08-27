bst := "bst --colors --no-interactive"

build:
    {{bst}} build all.bst

track:
    {{bst}} source track -d all all.bst

show TARGET:
    {{bst}} show {{TARGET}}
