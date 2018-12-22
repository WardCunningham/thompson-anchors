# retrieve wiki site in export.json format
# usage: sh export.sh

curl https://thompson.wiki.innovateoregon.org/system/export.json | jq . > export.json
