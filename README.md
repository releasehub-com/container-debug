# container-debug

```
/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/releaseapp-io/container-debug/main/install.sh)"
```


# grab header from service listening on port 8000
```
tcpdump -A -s 10240 'tcp port 8000 and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)' | egrep --line-buffered "^........(GET |HTTP\/|POST |HEAD )|^[A-Za-z0-9-]+: " | sed -r 's/^........(GET |HTTP\/|POST |HEAD )/\n\1/g'
```
