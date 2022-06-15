Sample player code for playing digis on the volume register of the Commodore 64 SID chip SID6581, in klickass assembly syntax.  
Works only on the old C64, not the C64C, which has the newer SID8580 builtin.  

This small demo code plays a high energy beat loop from the song "L.A. Style - James Brown is dead" (https://www.youtube.com/watch?v=dN8e9b2ON8s).

I use this occasionally to record "C64 distorted" samples, I love the crunchyness :)  

Wav-samples must be prepared first: converted to 4bit/4kHz, and the raw data extracted (no file header). This is done in 2 steps: using sox to convert sample- and bit-rate. sox can not convert to 4bit well, so the 2nd step uses a quick'n'dirty c executable to do so from 8-bit encoding.  
The output ("out.raw") is uncompressed and does not pack 2 4-bit digis into a byte. 

The assembly code sources the binary file "out.raw".

---

kickass assembler (http://www.theweb.dk/KickAssembler/Main.html)

use kickass to assemble:
```
java –jar /your/path/to/KickAss.jar digiplay.asm -o digiplay.prg
```

---
convert sample to 8bit/4kHz:
```
sox -S jb.wav -r 4000 -b 8 -e unsigned-integer -t raw in.raw
```
finally convert sample to 4bit/4kHz (creates out.raw):
```
cat in.raw ./8to4bit 
```

---

get sox from source:
http://sox.sourceforge.net/
```bash
git clone git://git.code.sf.net/p/sox/code sox
cd sox
autoreconfig -i
# configure script: remove warning definitions from 13540, 3 lines
./configure
make
```
or
```
apt-get install sox libsox-fmt-all
```


