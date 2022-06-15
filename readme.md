Sample player code for playing digis on the volume register of the Commodore 64 SID chip SID6581.  
Works only on the old C64, not the C64C, which has the newer SID8580 builtin.

kickass assembly syntax (http://www.theweb.dk/KickAssembler/Main.html)

use kickass to assemble:
```
java –jar /your/path/to/KickAss.jar digiplay.asm -o digiplay.prg
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
