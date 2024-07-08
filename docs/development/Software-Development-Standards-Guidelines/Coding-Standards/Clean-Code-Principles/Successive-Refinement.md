If we have learned anything over the last couple of decades, it is that programming is a craft more than it is a science. To write clean code, you must first write dirty code and then clean it.

Most programmers don't follow this advice particularly well. They believe the primary goal is to get the program working. Once it's working, they move on to the next task, leaving the working program in whatever state they finally got it to work. 

When starting refining a draft, we first need a suite of automated tests that can be run after each change and verifies that the behavior of the system is unchanged. Then we can safely apply the principles until we are satisfied with the code quality.

Nothing has a more profound and long-term degrading effect upon a development project than bad code. Of course bad code can be cleaned up, but it's very expensive. As code rots, the modules insinuate themselves into each other, creating lots of hidden and tangled dependencies. Finding an breaking old dependencies is a long and arduous task. 

On the other hand, keeping code clean is relatively easy. If you made a mess in a module in the morning, it is easy to clean it up in the afternoon. Better yet, if you made a mess five minutes ago, it's very easy to clean it up right now.

The solution is to continuously keep your code as clean and simple as it can be.  Never let the code start to rot in the first place.
