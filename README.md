# Word Hunt

Word Hunt is a word search game which I wrote in ActionScript 3 / Flex
back in late 2007 - early 2008 (when Flash RIAs were all the rage).

Although I never finished the project, the game did work pretty well.
I feel that is a good representation of my work from that period,
and the code has some interesting pieces which I sometimes refer back to.


## Comments About the Code

At the heart of the game lies a custom [radix tree](http://en.wikipedia.org/wiki/Radix_tree);
a really fun data structure which turned out to be very effective for this game.
I chose it mostly because I recalled it being interesting from my college days.
I also took some ideas from a letter-frequency-analysis project I did in a cryptography class
to generate the random letters for each board.

The game itself was written in a MVC structure.
The models do the real work of the game (as they should) so they are very testable.
I was learning how to unit test at the time, so the coverage is not great.
But I quickly learned the value of the red-green-refactor loop,
especially when testing tricky recursion edge cases.


## Building the Game

Unfortunately, I don't remember the details for building the source code.
I know that I used the `mxmlc` compiler from the Flex SDK, but I'm not sure what version.
The unit tests required the FlexUnit version 0.9 swc file.


## Running the Game

Once the `wordhunt.swf` file is generated, you must provide a `wordlist.txt` file to run the game.
This text file should contain one word per line; ideally from an English dictionary.

When I originally wrote the game, I found a big word list (1.8 MB, 173528 words) from some site,
but since I can't recall the origin to give credit here, I've omitted it from source control.
