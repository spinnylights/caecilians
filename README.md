# Caecilians

A [Ruby](https://www.ruby-lang.org/) program for generating and drawing [totalistic cellular
automata](https://en.wikipedia.org/wiki/Cellular_automaton#Totalistic).

## Usage

There's not really a UI yet, so if you want to generate pictures,
you'll have to do it "manually". Luckily, the example.rb file
should be easy to edit even if you don't know Ruby. Here's some
instructions on how to do that.

### Setup

If you don't already have them, you'll need to install
[Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
and
[Ruby](https://www.ruby-lang.org/en/documentation/installation/).
Even if you already have it installed, make sure to get the
latest version (2.5.3) if yours is older.  You'll also need to
know how to access the command line on your operating system and
be proficient in its basic usage, like entering commands and
navigating the filesystem. In Windows, Powershell is probably the
best applcation to use. Use Terminal in macOS. If you're on a
Linux distro, one of the BSDs, etc., how you access the command
line will depend on your environment; if you're using a very
graphical Linux distro and you're not sure, search about it based
on your distro's name.

Once you've taken care of these things, run `git clone
https://github.com/spinnylights/caecilians` on the command line
in the directory where you'd like to store the program. Enter the
`caecilians` directory. Run `gem install bundler`, then `bundle
install`. Now if you run `bundle exec ruby example.rb`, an image
called `example.png` should appear in the directory. Open it and
you should see a pretty picture.

### `example.rb`

If you open `example.rb` in a text editor, you'll see some places
you can change the behavior of the program.

#### `rule`

The line that says `rule: [1, 0, 2, 0, 1, 0, 1],` is the most
important part. This specifies the distinctive behavior of the
cellular automaton.

You don't have to worry too much about how it works if you don't
want to. You can just change the numbers in the rule and you'll
get different results, and you can keep trying different sets of
numbers until you get a result you like.

One thing to note is that, with the default rule, you should only
use numbers (specifically integers) from -2–2, and negative
numbers may not give results you find intuitive (they work
because of the way Ruby arrays behave). If you want to use larger
numbers, you will have to increase the number of numbers in the
rule to the largest number you want to use times three plus one; so, if you
want to be able to use 4 in the rule, the rule will need to have
13 (4\*3+1) numbers. Right now it has 7, because 2 is the largest
number and 2\*3+1 is 7. Numbers in the rule are separated by
commas, as you can see.

If you're curious, the way the rule works is that, for each
iteration, each cell in the new row looks at the cell directly
above it and to the left and right of that, adds the values in
all three of those cells together, and gets a new value. Then,
that value is matched to its spot in the rule, which gives the
ultimate value for the cell.

That might be confusing, so here's an example. Let's say we're
trying to determine the value of a new cell. The cells above it
and to the left and right on the previous row contain 2, 0, and
1\. We add those together and get 3. Then we count along the
numbers in the row starting from 0, so we go 0 (which has 1), 1 (which has
0), 2 (which has 2), and 3, which has 0. So the new cell gets the
value 0.

In Ruby, negative numbers used an an index to an array start
counting from the back of an array, which is what makes their
usage possible here. As such, their behavior is
implementation-dependent and I'm not going to make any promises
about it. You can get some cool-looking effects with them though.
:D

### `rows`

This is the number of rows (i.e. iterations) in the result.

### `first\_row`

You can use this to manually specify the values of the cells in
the first row, which will be used as the initial conditions for
the automaton. Any value that can be used in the rule can also be
used here.

If `first_row` is not supplied, the first row is generated at
random based on the rule.

### `borders`

This specifies how the borders of the rows are accounted for. You
may have wondered about this if you read about how the rule works
above; for cells at the edges, a value up and to the right or
left may not be present.

Possible values are `:toroidal` and `:unconnected`. Toroidal
means that values checked at the outside left of the row loop
around to the last value on the right, and vice versa for the
outside right and the first value on the left; in other words,
the row is treated like a torus. Unconnected means that values
outside the row are always treated as being the same value.
Toroidal is the default.

If you want to use this option, you will need to delete the `#`
at the beginning of the line. "#" in Ruby marks a comment, so
everything after it on the line is ignored.

### `unconnected\_value`

If `borders` is `:unconnected`, this is the value used for
"cells" outside the rows. It must be a value that can be used in
the rule. If `borders` is `:toroidal` it is ignored. The default
value is 0.

You will also need to uncomment this if you want to use it.

### `columns`

This specifies the number of columns in the randomly-generated
first row if `first_row` is not supplied. If `first_row` is
supplied, `columns` is ignored.

To use it, you will both need to uncomment the line it's on and
comment out or delete all of the `first_row` argument (so, lines
7–23).

### `colors`

These are the colors used to render the output of the automaton.
They're specified in RGB format from 0–255. The number of colors needed is
equal to the largest number by absolute value in the rule plus one.

You can have the values specified scaled by a factor, for
instance if you'd like to specify them from 0–1 instead of 0–255,
or if you'd like to make all the colors darker or brighter. If
you'd like to do this, look at the arguments to `RuleDrawer.new`
where you'll see `factor: 1`. Change `1` to whatever you'd like
the factor to be.

### `scale`

The other relevant part of the arguments to `RuleDrawer.new` is
the part that says `scale: 3`. That means that each cell is
rendered as a 3x3 square of pixels. You can increase or decrease
the scale if you'd like the squares to be bigger or smaller.

### filename

On the last line, you can change `example.png` to something else
if you'd like the generated image file to have a different name.
