# find most frequently mentioned pages
# usage: cat export.json | sh anchors.sh

text='.[].story[]|select((.type == "paragraph") or (.type="markdown"))|.text'
link='print "$1\n" for (/(\[\[.+?\]\])/)'
jq -r "$text" | perl -ne "$link" | sort | uniq -c | sort -nr
