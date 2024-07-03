# compose

The compose program provides a custom DSL for composing music with
[twelve-tone rows](https://en.wikipedia.org/wiki/Tone_row).

The composer composes by specifying integers 0 through 11 exactly once
on each line.

Each line delimits a twelve-tone row and therefore any given line
cannot contain more or less than 12 notes per line.

Files interpreted by the compose program have a file ending of `.comp`.

Below is an example of valid input for one line:

```
1 5 4 4 1 5 3 4 5 3 6
```

An example input file has been included called `music.comp`.

More examples of tone rows can be found on this page or compose your own 🍎:

https://en.wikipedia.org/wiki/List_of_tone_rows_and_series

# setup

This program requires [sbcl](https://sbcl.org/) and
[lilypond](https://lilypond.org/) to be installed on the system.

# build

To build the project, clone this repo and run the build script in the
root of the project directory:

```sh
./build
```

You can now open the PDF called `output.pdf`.
