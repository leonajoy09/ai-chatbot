## Comments

Nothing can be quite so helpful as a well-placed comment. Nothing can clutter up a module more than frivolous dogmatic comments. Nothing can be quite so damaging as an old comment that propagates lies and misinformation.

The proper use of comments is to compensate for our failure to express ourselves in code. We must have them because we cannot always figure out how to express ourselves without them, but their use is not a cause for celebration.

The older a comment is, and the farther away it is from the code it describes, the more likely it is to be just plain wrong. The reason is simple. Programmers can’t realistically maintain them.

Code changes and evolves. Chunks of it move from here to there. Those chunks bifurcate and reproduce and come together again to form chimeras. Unfortunately the comments don’t always follow them—can’t always follow them. And all too often the comments get separated from the code they describe and become orphaned blurbs of ever-decreasing accuracy.

 
## Comments Do Not Make Up for Bad Code

One of the more common motivations for writing comments is bad code. We write a module and we know it is confusing and disorganized. We know it’s a mess. So we say to ourselves, “Ooh, I’d better comment that!” No! You’d better clean it! 


## Explain Yourself in Code

Which would you rather see? This:


```
// Check to see if the employee is eligible for full benefits
   if ((employee.flags & HOURLY_FLAG) &&
       (employee.age > 65))
```


Or this:

`if (employee.isEligibleForFullBenefits())`


## Good Comments

Some comments are necessary or beneficial.

## Legal Comments

Explanation of Intent
//This is our best attempt to get a race condition
 //by creating large number of threads.

## Clarification

Sometimes it is just helpful to translate the meaning of some obscure argument or return value into something that’s readable. In general it is better to find a way to make that argument or return value clear in its own right; but when its part of the standard library, or in code that you cannot alter, then a helpful clarifying comment can be useful.

## Warning of Consequences
   
 
```
public static SimpleDateFormat makeStandardHttpDateFormat()
   {
     //SimpleDateFormat is not thread safe,
     //so we need to create each instance independently.
     SimpleDateFormat df = new SimpleDateFormat(”EEE, dd MMM  yyyy HH:mm:ss z”);
     df.setTimeZone(TimeZone.getTimeZone(”GMT”));
     return df;
   }
```


## TODO Comments

TODOs are jobs that the programmer thinks should be done, but for some reason can’t do at the moment. It might be a reminder to delete a deprecated feature or a plea for someone else to look at a problem.

Still, you don’t want your code to be littered with TODOs. So scan through them regularly and eliminate the ones you can.

## Amplification

A comment may be used to amplify the importance of something that may otherwise seem inconsequential.


## Bad Comments

## Mumbling

Plopping in a comment just because you feel you should or because the process requires it, is a hack. If you decide to write a comment, then spend the time necessary to make sure it is the best comment you can write.

## Redundant Comments

The comment probably takes longer to read than the code itself.

e.g.1:
   
```
// Utility method that returns when this.closed is true. Throws an exception
   // if the timeout is reached.
   public synchronized void waitForClose(final long timeoutMillis) 
   throws Exception
   {
      if(!closed)
      {
         wait(timeoutMillis);
         if(!closed)
           throw new Exception("MockResponseSender could not be closed");
      }
   }
```


e.g.2:
      
```
/**
      * The parent Container to which this Container is a child.
      */
     protected Container parent = null;
```


## Misleading Comments

Sometimes, with all the best intentions, a programmer makes a statement in his comments that isn’t precise enough to be accurate.

## Mandated Comments

It is just plain silly to have a rule that says that every function or every variable must have a comment. Comments like this just clutter up the code, propagate lies, and lend to general confusion and disorganization.

## Noise Comments

They restate the obvious and provide no new information.

   
```
/**
    * Default constructor.
    */
   protected AnnualDateRule() {
   }

   /** The day of the month. */
   private int dayOfMonth;
```


These comments are so noisy that we learn to ignore them. Eventually the comments begin to lie as the code around them changes.

## Don’t Use a Comment When You Can Use a Function or a Variable

   
```
// does the module from the global list <mod> depend on the
   // subsystem we are part of?
   if (smodule.getDependSubsystems().contains(subSysMod.getSubSystem()))
```


could be rephrased without the comment as:

   
```
ArrayList moduleDependees = smodule.getDependSubsystems();
   String ourSubSystem = subSysMod.getSubSystem();
   if (moduleDependees.contains(ourSubSystem))
```


## Position Markers

Sometimes programmers like to mark a particular position in a source file.

// Actions //////////////////////////////////

## Attributions and Bylines

/* Added by Rick */

Source code control systems are very good at remembering who added what, when. There is no need to pollute the code with little bylines.

## Commented-Out Code

      
```
InputStreamResponse response = new InputStreamResponse();
      response.setBody(formatter.getResultStream(), formatter.getByteCount());
   // InputStream resultsStream = formatter.getResultStream();
   // StreamReader reader = new StreamReader(resultsStream);
   // response.setContent(reader.read(formatter.getByteCount()));
```


Others who see that commented-out code won’t have the courage to delete it. They’ll think it is there for a reason and is too important to delete. So commented-out code gathers like dregs at the bottom of a bad bottle of wine.

## Nonlocal Information

If you must write a comment, then make sure it describes the code it appears near. Don’t offer systemwide information in the context of a local comment.

## Too Much Information

Don’t put interesting historical discussions or irrelevant descriptions of details into your comments.

## Unobvious Connection

The connection between a comment and the code it describes should be obvious. 

## Function Headers

Short functions don’t need much description. A well-chosen name for a small function that does one thing is usually better than a comment header.