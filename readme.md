kickass assembly syntax (http://www.theweb.dk/KickAssembler/Main.html)

use kickass to assemble:
```
java –jar ~/c64bin/KickAssembler/KickAss.jar digiplay.asm -o digiplay.prg
```

using sox to convert wav files:

get sox from source:
http://sox.sourceforge.net/
```
autoreconfig -i
configure script: remove warning definitions from 13540 3 lines
./configure
make
```
or
```
apt-get install sox libsox-fmt-all
```
convert sample to 8bit/4kHz:
```
sox -S jb.wav -r 4000 -b 8 -e unsigned-integer -t raw in.raw
```
finally convert sample to 4bit/4kHz (creates out.raw):
```
cat in.raw ./8to4bit 
```
