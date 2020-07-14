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


