## Formatting

When people look under the hood, we want them to be impressed with the neatness, consistency, and attention to detail that they perceive. We want them to be struck by the orderliness. We want their eyebrows to rise as they scroll through the modules. We want them to perceive that professionals have been at work. If instead they see a scrambled mass of code that looks like it was written by a bevy of drunken sailors, then they are likely to conclude that the same inattention to detail pervades every other aspect of the project.

You should take care that your code is nicely formatted. You should choose a set of simple rules that govern the format of your code, and then you should consistently apply those rules. If you are working on a team, then the team should agree to a single set of formatting rules and all members should comply. It helps to have an automated tool that can apply those formatting rules for you.


## The Purpose of Formatting

Perhaps you thought that “getting it working” was the first order of business for a professional developer. The functionality that you create today has a good chance of changing in the next release, but the readability of your code will have a profound effect on all the changes that will ever be made. The coding style and readability set precedents that continue to affect maintainability and extensibility long after the original code has been changed beyond recognition.


## Vertical Formatting

## Vertical Openness Between Concepts

Nearly all code is read left to right and top to bottom. Each line represents an expression or a clause, and each group of lines represents a complete thought. Those thoughts should be separated from each other with blank lines.

## Vertical Density

If openness separates concepts, then vertical density implies close association. So lines of code that are tightly related should appear vertically dense.

## Vertical Distance

Have you ever chased your tail through a class, hopping from one function to the next, scrolling up and down the source file, trying to divine how the functions relate and operate, only to get lost in a rat’s nest of confusion? Concepts that are closely related should be kept vertically close to each other

For those concepts that are so closely related that they belong in the same source file, their vertical separation should be a measure of how important each is to the understandability of the other. We want to avoid forcing our readers to hop around through our source files and classes.

## Variable Declarations

Local Variables should be declared as close to their usage as possible.

Instance variables, on the other hand, should be declared at the top of the class. This should not increase the vertical distance of these variables, because in a well-designed class, they are used by many, if not all, of the methods of the class.

## Vertical Ordering

In general we want function call dependencies to point in the downward direction. That is, a function that is called should be below a function that does the calling. This creates a nice flow down the source code module from high level to low level.


# Horizontal Formatting

## Horizontal Openness and Density

We use horizontal white space to associate things that are strongly related and disassociate things that are more weakly related. Consider the following function:


```
private void measureLine(String line) {
     lineCount++;
     int lineSize = line.length();
     totalChars += lineSize;
     lineWidthHistogram.addLine(lineSize, lineCount);
     recordWidestLine(lineSize);
   }
```


Assignment statements have two distinct and major elements: the left side and the right side. The spaces make that separation obvious.

On the other hand, we don't have spaces between the function names and the opening parenthesis. This is because the function and its arguments are closely related.

## Indentation

A source file is a hierarchy rather like an outline. There is information that pertains to the file as a whole, to the individual classes within the file, to the methods within the classes, to the blocks within the methods, and recursively to the blocks within the blocks. Each level of this hierarchy is a scope into which names can be declared and in which declarations and executable statements are interpreted. To make this hierarchy of scopes visible, we indent the lines of source code in proportion to their position in the hierarchy.

## Team Rules

A team of developers should agree upon a single formatting style, and then every member of that team should use that style. We want the software to have a consistent style. The last thing we want to do is add more complexity to the source code by writing it in a jumble of different individual styles.