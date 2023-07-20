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
<br/><br/>
## Sample Programs
<table>
<thead>
  <tr>
    <th>C++ Code</th>
    <th>Choon Code</th>
    <th>Music Played</th>
  </tr>
</thead>
<tbody>
<tr>
<td>
      
```C
int a=1,b=2;
a+=b;
cout<<a;
```
</td>
    <td>. C# + a C . D + b C . =b + a =a. =a + C</td>
    <td><a href="https://drive.google.com/file/d/1J8zS4RMy27HMR_0aCRrWcm4LdvUtG8Od/view?usp=sharing">Listen</a></td>
</tr><tr>
<td>
      
```C
int a;
a=20*30;
cout<<a;
```
</td>
    <td>. t0 C F#+D#+C + C ||: . F+C+C + t0 =t0 :|| . F#+D#+C + C - - C ||: . F+C+C - t0 =t0 :||. =t0 + a C  . =a + C</td>
    <td><a href="https://drive.google.com/file/d/1nBkXnamo_A9wyi3ucjmxAxVHff3O_Svv/view?usp=sharing">Listen</a></td>
</tr>
<tr>
<td>
      
```C
int a=0,i;
for(i=0;i<10;i++){
  a+=i;
}
cout<<a;
```
</td>
    <td>. C + a C . C + i C % ||:. F+C + t0 C. =i + C - - t0 =t0. =t0 - C ||: C ~ :|| ~. =i + a =a . =i + i C#:|| . =a + C</td>
    <td><a href="https://drive.google.com/file/d/1pY-C51fgXuvlLK51AjW6l7TIlMhrwvFo/view?usp=sharing">Listen</a></td>
</tr><tr>
<td>
      
```C
# Fibonacci
int a=0,b=1,c,i;
for(i=0;i<10;i++){
  cout<<a;
  c=a+b;
  a=b;
  b=c;
}
cout<<a
```
</td>
    <td>. C + a C . C# + b C . C + i C % ||:. F+C + t0 C. =i + C - - t0 =t0. =t0 - C ||: C ~ :|| ~ . =a + 0. =a + t1 C . =b + t1 =t1. =t1 + c C . =b + a C . =c + b C . =i + i C#:|| . =a + C</td>
    <td><a href="https://drive.google.com/file/d/16g8Q3fizUwiB93x_0Z24vmMFAtF9-c4k/view?usp=sharing">Listen</a></td>
</tr>
</tbody>
</table>

## Acknowledgements
Special thanks to Stephen Stykes, for creating the idea of Choon and providing the reference interpreter in Ruby.
