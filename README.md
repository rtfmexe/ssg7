# ssg7

Minimal static blog generator written in bash. You can see a demo [here](https://ertfm.github.io/ssg7/).

Write your posts in markdown, save them in a folder and run ssg7. An index will be generated with your
posts title sorted by date.

## dependencies

* bash
* [markdown](https://command-not-found.com/markdown)

Fedora: dnf -y install discount

## config

Edit ssg7.sh 

### general config

    sitename="sitename"
    baseurl="https://example.org"
    lang="en"

### color theme

    background_color="#f6f7fc"
    text_color="#343636"
    link_color="#006edc"
    quote_color="#f6d6d9"

## try it

    git clone https://github.com/ertfm/ssg7.git
    cd ssg7
    chmod +x ssg7.sh
    sed -i 's,https://example.org,http://127.0.0.1:8000,g' ssg7.sh 
    ./ssg7.sh example/ /tmp/out/ && python -m http.server --directory /tmp/out

It's important that you use the following syntax for the filename: **YYYY-MM-DD.something.md**


