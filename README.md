# compose

This project provides a DSL for composing music with [twelve-tone-rows](https://en.wikipedia.org/wiki/Tone_row).

The composer writes an input file consisting of integers 0 through 11.

TODO: Add a list of rules here.

Each line delimits a twelve-tone row.

The composer can leave notes out and the program will complete the
[complement](https://en.wikipedia.org/wiki/Complement_(music)#Aggregate_complementation)
notes.

# setup

This program uses lilypond 2.25.12 as a backend for rendering music notation.

Clone the following dependencies into foo:

https://github.com/phoe/binding-arrows
https://git.sr.ht/~charje/loop/

# run

To run the project, call the following commands in order:

```sh
./build.sh
lilypond output.ly
open output.pdf
```
