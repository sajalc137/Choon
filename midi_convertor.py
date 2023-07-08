import sys
from mingus.containers import Bar
from mingus.containers import Composition
from mingus.containers import Track
from mingus.containers import NoteContainer
from mingus.midi.midi_file_out import write_Composition

song = ["C-0","C-1","C-2","C-3","C-4","C-5","C-6","C-7","C-8","C-9"]
# song = ["C", "D", "E", "F", "G", "A", "B", "C-5"]

b = Bar() # creates new bar element for Mingus = has limit of 4/4 timing by default
b.set_meter((4,4))

c = Composition()
t = Track()
t.add_bar(b)
c.add_track(t)

def to_note(inp):
    num = int(inp)
    num = (num+48)%121-48 # Keep it to take modulo into within audible range
    arr = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    name = arr[num%12]
    octave = ((num//12)+4)
    return name+'-'+str(octave)

for inp in sys.stdin:
    inp=inp.strip()
    if(inp=='R'):
        c.add_note(['C',{'volume':0}])
    else:
        c.add_note(to_note(inp))

write_Composition("music.mid", c,240)