#/usr/bin/env bash

# general
sitename="sitename"
baseurl="https://example.org"
lang="en"

# color theme
background_color="#f6f7fc"
text_color="#343636"
link_color="#006edc"

render_template(){
local title=$1
local content=$2

local html="<!DOCTYPE html>
<html lang=\"${lang:=en}\">
<head>
<meta charset=\"utf-8\">
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
<title>$title</title>
<style>
body {max-width:650px;margin:20px auto;background-color:$background_color;color:$text_color;font-size:1.125em;font-family: Helvetica Neue,Helvetica,Arial,sans-serif;}
a {color:$link_color;text-decoration:none;}
p, ul li, ol li {margin-bottom: 1em; line-height: 1.5em;}
date {font-size: 0.9em;}
</style>
</head>
<body>
<main>
$content
</main>
<hr>
<footer>
<small>Built with <a href=https://github.com/ertfm/ssg7>ssg7.</a></small>
</footer>
</html>
"

printf "$html"
}

wrap_index_content(){
local content=$1

local index_content="

<h1>$sitename</h1>
<ul>
$content
</ul>
"

printf "$index_content"
}

usage() {
  printf "usage: $0 SRC_DIR DST_DIR\n"
  exit 1
}

[[ -d $1 ]] && source_dir=$1 || usage
[[ ! -z $2 ]] && dest_dir=$2 || usage

# remove trailing slash from baseurl
baseurl=${baseurl%/}

posts_dir="$dest_dir/posts"
posts_url="$baseurl/posts"

mkdir -p $posts_dir

mdfiles=($source_dir/*.md)
for ((i=${#mdfiles[@]}-1;i>=0;i--)); do
  filename="${mdfiles[$i]##*/}"
  read -r pubdate name ext <<< ${filename//./ }
  post=$(markdown $source_dir/$filename)
  [[ $post =~ \<h1\>(.*)\</h1\> ]] && post_title=${BASH_REMATCH[1]}
  render_template "$post_title" "$post" > $posts_dir/${filename%%.md}.html

  # generate posts list for index
  posts_list+="
  <li> 
  <a href=\"$posts_url/${filename%%.md}.html\">$post_title</a>
  -
  <date>$pubdate</date>
  </li>
  "
done

index_content=$(wrap_index_content "$posts_list")
render_template "$sitename" "$index_content" > $dest_dir/index.html
