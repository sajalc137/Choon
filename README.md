# Choon
A translator from C++ to the esoteric programming language Choon, based musical notation for syntax.

## Choon Instruction Set

### Full Set
|Symbol|Name|Purpose|
|------|----|-------|
|[A-G]|Notes|Numbers|
|+|Up|Transpose up|
|-|Down|Transpose down|
|.|Cancel|Reset transpose|
|[a-z]|Markers|Variables|
|=|Play from output|Reference|
|%|John Cage|No-op|
|&#124;&#124;::&#124;&#124;|Repeat Bars|Loop|
|~|Tuning Fork|Break|


### Note Values
There are 12 notes in the western musical scale, and they are notated like this:
|Choon Instruction|Value|
|-----------------|-----|
|G|-5|
|G#|-4|
|A|-3|
|A#|-2|
|B|-1|
|C|0|
|C#|1|
|D|2|
|D#|3|
|E|4|
|F|5|
|F#|6|

### Transpositions
|Symbol|Name|Description|
|------|----|-----------|
|+|up|Transposes (Increases) all subsequent notes played by the amount of the last note played|
|-|down|Transposes (Decreases) all subsequent notes played by the amount of the last note played|
|.|cancel|Sets the transposition back to 0|

Transpositions are cumulative, so the Choon code `D+` transposes all future notes up by 2 and `D++` by 4.

Also, the value used for transposition is the last value **played** which includes any exisiting transposition. Hence the code `D+D+` transposes future notes by 6 and not 4.

### Markers
A marker is a lower case letter/word that remembers a point in the output stream. Referring to a marker (see below) will cause the note played just after the Marker to be played again. Note that transpositions will affect this newly played note.

### Play From Output
The Play From Output instruction `=` allows you to play notes that have already been played in the output stream.
|Reference Type|Example|Result|
|--------------|-------|------|
|Absolute|`=3`|Plays the 3rd note played since the program began|
|Relative|`=-3`|Plays the 3rd most recent note played|
|Marker|`=x`|Plays the note played just after the marker `x`|
>It is common to immediately re-use a marker for eg: `x =x`.
>This is equivalent to saying `x=x+y` in a conventional language (where `y` is the current transpose value).

### John Cage
The John Cage instruction `%` causes a one note silence in the output stream. The transposition value of a 
John Cage is zero - '%-' and '%+' are no-ops (except that a single silence is added to the output).

### Repeat Bars
Repeat Bars (`||:` and `:||`) create loops. The loop repeats based on the last note played before encountering `||:`. Zero or negative values jump to the matching `:||` to start playing from there. 

John Cage indicates an infinite loop: `%||: :||` creates an infinite loop.

### Tuning Fork
The Tuning Fork instruction `~` is used to break out of loops. If the note played just before `~` is `C` (ie. 0), then immediately jump to the next `:||` instruction. If there is no further `:||` instruction, then the piece will terminate.
