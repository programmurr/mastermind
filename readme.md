13th July 2020

Initialization of github repository. Just pseudocode and planning today.
___
13th July 2020

Welp, looks like I jumped ahead a bit. Anyway, here's what's accomplished so far:

COMPLETED:
- Introduction is functional
- Skip instruction/play instruction option is functional
- Computer and human player objects are being generated
- Computer and human player objects are being successfully passed in to gameplay
- The computer player is successfully generating a random array of 4 colors
- Successfully obtaining and verifying user input for answer.
- The player must enter exactly 4 of PBROGY or the answer will not be accepted and it will tell them to try again
- That guess is being stored as a variable

Comment - so far generally successful in keeping most of the code inside the module. Let's keep this up!

TODO:
- General gameplay loop
- Create answer comparison method (and sub-methods when necessary)
- Create output method for UI
- Create win/loss checks and logic

___
14th July 2020
COMPLETED:
- Introduction is functional
- Skip instruction/play instruction option is functional
- Computer and human player objects are being generated
- Computer and human player objects are being successfully passed in to gameplay
- The computer player is successfully generating a random array of 4 colors
- Successfully obtaining and verifying user input for answer.
- The player must enter exactly 4 of PBROGY or the answer will not be accepted and it will tell them to try again
- That guess is being stored as a variable
- General gameplay loop
- Create output method for UI
- Create win/loss checks and logic

TODO:
- Create answer comparison method (and sub-methods when necessary)
- Save as a 'version' (refer to git instructions book) when this is complete.

So the game is pretty much complete, except for the fact that the most crucial part is not working and I haven't figured it out yet. Which I will.
The UI is all complete, the game loop is tested, the win/loss checks and logic work.

After banging my head against the answer comparison logic for a few hours, I chucked everything and can see promise in using hashes. I tried arrays and regexp, doesn't seem like they can handle it. So I've got it pseudocoded in a test code file for now and can see promise in it. See if I can find some way of whittling down the detections to produce the appropriate Ws and Bs. Check the exercises folder to see if there are any useful hash methods or solutions in there.

___
15th July 2020

Still haven't been able to solve it today. After about 6 hours. I WILL SOLVE IT, just need to clear my head after today. Maybe get back to writing it down. Just get off the computer for now.
Deep in the hash rabbit hole lol. I've made progress, but keep getting stuck on the same point 'only push 1 B if the color is detected more than once but the indexes don't match'
Maybe try a whole new approach next time. Even the hashes might not be enough.

___
16th July 2020

Version one is complete! W00t!

I can't take credit though. I reached out to the kind people at the odin project discord and they helped a LOT!

The lesson learned is:
- If it looks needlessly complicated, it probably is

I'm just glad that I didn't give in and look at any solutions this time, just kept trying different ways, and wasn't *totally* afraid to delete code and start over. However, I talked myself into a hash method and didn't talk myself out of it, when a simple array comparison was indeed all that was needed. I was initially right! Just didn't know how to do what I wanted. But now, I do!

On to version 2... building the AI.

___
16th July additional - 

Found a bug lol. If the user had HHHH at 0 guesses remaining, the game continued into negative guesses remaining. Caught it! Also, now the user can choose their difficulty. V 1.1 complete. Moving on to the AI now. 

___
17th July 2020

Step 3 - Refactor your code to allow the human player to choose whether he or she wants to be the creator of the code or the guesser - COMPLETE!
- The user can now choose if they want to make or break the code, as well as set the difficulty level for themselves and the computer
- Instructions/win/loss messages all adapted

Step 4 - Build it so the computer will guess the colors the user inputs. Start by having the computer guess randomly, but keeping the ones that match exactly - IN PROGRESS
- Computer successfully generating random guesses with win/loss logic being successfully applied (mostly, see TODO below)

Make good steps forward today. Refactored a lot of the code so that most of the Player::Human specific methods are now in the player superclass. So are the guess counter, feedback string and color array (no more class variables yay!)

TODO:
- Fix the bug that causes a false-detection if the same letter is used twice by the computer (copy the Fensus code and refactor it to suit)
- Make it so that if the computer gets an exact hit, it keeps that letter in all future guesses (will require detailed thought and planning)

___
18th July 2020

- Fixed false-detection bug, but cheated a little. I fixed it by stopping the color array repeating RBGOYP four times. If the computer could put two letters of the same kind in the code, the bug appeared, so I removed that possibility. Now it can only put in each color once (but I won't tell the user that)

- Taking it easy today. Just did some pseudo-code for the random-detection remembrance. Will implement tomorrow and see if it works, then begin researching the 'AI' of sorts

___
19th July 2020

Some more things to do!
- Add colorizer, so when people type their color in it shows up as a color in the output
- Will need to make a method that possibly uses a case statement to check the user answer array, convert the appropriate character into a color, then join and push as the color string
- Create difficulty levels for computer - 'dumb' (random guesses) and 'smart' (will remember hits and close-calls), and remove amount of guesses so it's cleaner to use

When these are done, v2.0 will be complete


