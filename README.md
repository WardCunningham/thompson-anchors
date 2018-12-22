# thompson-anchors
Plot Thompson's Anchor Pages and Pages they Cite

# build

Find anchor pages

```
sh export.sh
sh anchors.sh
```

Plot starting from seed anchors

```
ruby map.rb
```

View results

```
open -a graphviz map.dot
open -a safari map.svg
```

# sample

![diagram](https://raw.githubusercontent.com/WardCunningham/thompson-anchors/master/map.svg?sanitize=true)

