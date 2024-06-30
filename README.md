# compose

This project provides a DSL for composing music with [twelve-tone-rows](https://en.wikipedia.org/wiki/Tone_row).

The composer writes an input file consisting of integers 0 through 11.

TODO: Add a list of rules here.

Each line delimits a twelve-tone row.

The composer can leave notes out and the program will complete the
[complement](https://en.wikipedia.org/wiki/Complement_(music)#Aggregate_complementation)
notes.

# setup

This program requires [lilypond](https://lilypond.org/) 2.25.12 to be
installed as a backend for rendering music notation.

# build

To build the project, call the following commands in order:

```sh
git clone --recurse-submodules https://git.sr.ht/~whereiseveryone/compose
cd compose
./build
```

You can now open the PDF called `output.pdf`.

# todo

move modules to `src` folder
