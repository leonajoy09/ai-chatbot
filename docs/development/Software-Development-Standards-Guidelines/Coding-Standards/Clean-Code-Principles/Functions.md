## Small!

The first rule of functions is that they should be small. The second rule of functions is that they should be smaller than that.

Nowadays with a cranked-down font and a nice big monitor, you can fit 150 characters on a line and a 100 lines or more on a screen. Lines should not be 150 characters long. Functions should not be 100 lines long. Functions should hardly ever be 20 lines long.

badExample1:

```
public static String testableHtml(
     PageData pageData,
     boolean includeSuiteSetup
   ) throws Exception {
     WikiPage wikiPage = pageData.getWikiPage();
     StringBuffer buffer = new StringBuffer();
     if (pageData.hasAttribute("Test")) {
       if (includeSuiteSetup) {
         WikiPage suiteSetup =
          PageCrawlerImpl.getInheritedPage(
                  SuiteResponder.SUITE_SETUP_NAME, wikiPage
          );
         if (suiteSetup != null) {
          WikiPagePath pagePath =
            suiteSetup.getPageCrawler().getFullPath(suiteSetup);
          String pagePathName = PathParser.render(pagePath);
          buffer.append("!include -setup .")
                .append(pagePathName)
                .append("\n");
         }
       }
       WikiPage setup = 
         PageCrawlerImpl.getInheritedPage("SetUp", wikiPage);
       if (setup != null) {
       WikiPagePath setupPath =
           wikiPage.getPageCrawler().getFullPath(setup);
         String setupPathName = PathParser.render(setupPath);
         buffer.append("!include -setup .")
               .append(setupPathName)
               .append("\n");
       }
     }
     buffer.append(pageData.getContent());
     if (pageData.hasAttribute("Test")) {
       WikiPage teardown = 
         PageCrawlerImpl.getInheritedPage("TearDown", wikiPage);
       if (teardown != null) {
         WikiPagePath tearDownPath =
           wikiPage.getPageCrawler().getFullPath(teardown);
         String tearDownPathName = PathParser.render(tearDownPath);
         buffer.append("\n")
               .append("!include -teardown .")
               .append(tearDownPathName)
               .append("\n");
       }
       if (includeSuiteSetup) {
         WikiPage suiteTeardown =
           PageCrawlerImpl.getInheritedPage(
                   SuiteResponder.SUITE_TEARDOWN_NAME,
                   wikiPage
           );
         if (suiteTeardown != null) {
           WikiPagePath pagePath =
             suiteTeardown.getPageCrawler().getFullPath (suiteTeardown);
           String pagePathName = PathParser.render(pagePath);
           buffer.append("!include -teardown .")
                 .append(pagePathName)
                 .append("\n");
         }
       }
     }
     pageData.setContent(buffer.toString());
     return pageData.getHtml();
  }
```


betterExample1:

```
public static String renderPageWithSetupsAndTeardowns(
     PageData pageData, boolean isSuite
   ) throws Exception {
     boolean isTestPage = pageData.hasAttribute("Test");
     if (isTestPage) {
       WikiPage testPage = pageData.getWikiPage();
       StringBuffer newPageContent = new StringBuffer();
       includeSetupPages(testPage, newPageContent, isSuite);
       newPageContent.append(pageData.getContent());
       includeTeardownPages(testPage, newPageContent, isSuite);
       pageData.setContent(newPageContent.toString());
     }
     return pageData.getHtml();
   }
```


bestExample1:
   
```
public static String renderPageWithSetupsAndTeardowns(
     PageData pageData, boolean isSuite) throws Exception {
     if (isTestPage(pageData))
       includeSetupAndTeardownPages(pageData, isSuite);
     return pageData.getHtml();
   }
```


This implies that the blocks within if statements, else statements, while statements, and so on should be one line long. Probably that line should be a function call. Not only does this keep the enclosing function small, but it also adds documentary value because the function called within the block can have a nicely descriptive name. 

This also implies that functions should not be large enough to hold nested structures. Therefore, the indent level of a function should not be greater than one or two. This, of course, makes the functions easier to read and understand.


## Do One Thing

It's clear that the code in badExample1 is doing lots more than one thing. It’s creating buffers, fetching pages, searching for inherited pages, rendering paths, appending arcane strings, and generating HTML, among other things.

On the other hand, the code in bestExample1 is doing one simple thing. It’s including setups and teardowns into test pages.

FUNCTIONS SHOULD DO ONE THING. THEY SHOULD DO IT WELL. THEY SHOULD DO IT ONLY.


## One Level of Abstraction per Function

In order to make sure our functions are doing “one thing,” we need to make sure that the statements within our function are all at the same level of abstraction. It is easy to see how the code in badExample1 violates this rule. There are concepts in there that are at a very high level of abstraction, such as getHtml(); others that are at an intermediate level of abstraction, such as: String pagePathName = PathParser.render(pagePath); and still others that are remarkably low level, such as: .append(”\n”).

Mixing levels of abstraction within a function is always confusing. Readers may not be able to tell whether a particular expression is an essential concept or a detail.

## Reading Code from Top to Bottom: The Stepdown Rule

We want the code to read like a top-down narrative. We want every function to be followed by those at the next level of abstraction so that we can read the program, descending one level of abstraction at a time as we read down the list of functions.

It turns out to be very difficult for programmers to learn to follow this rule and write functions that stay at a single level of abstraction. But learning this trick is also very important. It is the key to keeping functions short and making sure they do “one thing.”


## Switch Statements

It’s hard to make a small switch statement. By their nature, switch statements always do N things. Unfortunately we can’t always avoid switch statements, but we can make sure that each switch statement is buried in a low-level class and is never repeated. We do this, of course, with polymorphism.

bad:
    
```
public Money calculatePay(Employee e) throws InvalidEmployeeType {
       switch (e.type) {
         case COMMISSIONED:
           return calculateCommissionedPay(e);
         case HOURLY:
           return calculateHourlyPay(e);
         case SALARIED:
           return calculateSalariedPay(e);
         default:
           throw new InvalidEmployeeType(e.type);
         }
     }
```


There are several problems with this function. First, it’s large, and when new employee types are added, it will grow. Second, it very clearly does more than one thing. Third, it violates the Single Responsibility Principle (SRP) because there is more than one reason for it to change. Fourth, it violates the Open Closed Principle (OCP) because it must change whenever new types are added. But possibly the worst problem with this function is that there will probably be an unlimited number of other functions that will have the same structure.

Switch statements can be used if they appear only once, are used to create polymorphic objects, and are hidden behind an inheritance relationship so that the rest of the system can’t see them.

good:

```
public abstract class Employee {
     public abstract boolean isPayday();
     public abstract Money calculatePay();
     public abstract void deliverPay(Money pay);
   }
   -----------------
   public interface EmployeeFactory {
     public Employee makeEmployee(EmployeeRecord r) throws InvalidEmployeeType;
   }
   -----------------
   public class EmployeeFactoryImpl implements EmployeeFactory {
     public Employee makeEmployee(EmployeeRecord r) throws InvalidEmployeeType {
       switch (r.type) {
         case COMMISSIONED:
           return new CommissionedEmployee(r) ;
         case HOURLY:
           return new HourlyEmployee(r);
         case SALARIED:
           return new SalariedEmploye(r);
         default:
           throw new InvalidEmployeeType(r.type);
       }
     }
   }
```



## Use Descriptive Names

The smaller and more focused a function is, the easier it is to choose a descriptive name.

Don’t be afraid to make a name long. A long descriptive name is better than a short enigmatic name. A long descriptive name is better than a long descriptive comment.

Choosing descriptive names will clarify the design of the module in your mind and help you to improve it.


## Function Arguments

The ideal number of arguments for a function is zero (niladic). Next comes one (monadic), followed closely by two (dyadic). Three arguments (triadic) should be avoided where possible. More than three (polyadic) requires very special justification—and then shouldn’t be used anyway.

Arguments are even harder from a testing point of view. Imagine the difficulty of writing all the test cases to ensure that all the various combinations of arguments work properly. If there are no arguments, this is trivial. If there’s one argument, it’s not too hard. With two arguments the problem gets a bit more challenging.

## Common Monadic Forms

There are two very common reasons to pass a single argument into a function. You may be asking a question about that argument, as in boolean fileExists(“MyFile”). Or you may be operating on that argument, transforming it into something else and returning it.

## Flag Arguments

Flag arguments are ugly. Passing a boolean into a function is a truly terrible practice. It immediately complicates the signature of the method, loudly proclaiming that this function does more than one thing. It does one thing if the flag is true and another if the flag is false!

## Dyadic Functions

A function with two arguments is harder to understand than a monadic function. For example, writeField(name) is easier to understand than writeField(output-Stream, name). Though the meaning of both is clear, the first glides past the eye, easily depositing its meaning. The second requires a short pause until we learn to ignore the first parameter. And that, of course, eventually results in problems because we should never ignore any part of code. The parts we ignore are where the bugs will hide.

## Triads

Functions that take three arguments are significantly harder to understand than dyads. The issues of ordering, pausing, and ignoring are more than doubled.

## Argument Objects

When a function seems to need more than two or three arguments, it is likely that some of those arguments ought to be wrapped into a class of their own.

Circle makeCircle(double x, double y, double radius);

could be better written as:

Circle makeCircle(Point center, double radius);

Reducing the number of arguments by creating objects out of them may seem like cheating, but it’s not. When groups of variables are passed together, the way x and y are in the example above, they are likely part of a concept that deserves a name of its own.

## Argument Lists

Sometimes we want to pass a variable number of arguments into a function. If the variable arguments are all treated identically, then they are equivalent to a single argument of type List.

void monad(Integer… args);
void dyad(String name, Integer… args);

Verbs and Keywords

Choosing good names for a function can go a long way toward explaining the intent of the function and the order and intent of the arguments. In the case of a monad, the function and argument should form a very nice verb/noun pair. For example, write(name) is very evocative. Whatever this “name” thing is, it is being “written.” An even better name might be writeField(name), which tells us that the “name” thing is a “field”. This is an example of the keyword form of a function name. For example, assertEquals might be better written as assertExpectedEqualsActual(expected, actual). This strongly mitigates the problem of having to remember the ordering of the arguments.


## Have No Side Effects

Side effects are lies. Your function promises to do one thing, but it also does other hidden things. Sometimes it will make unexpected changes to the variables of its own class. Sometimes it will make them to the parameters passed into the function or to system globals. In either case they are devious and damaging mistruths that often result in strange temporal couplings and order dependencies.

Consider the following code:


```
public class UserValidator {
     private Cryptographer cryptographer;
 public boolean checkPassword(String userName, String password) {
       User user = UserGateway.findByName(userName);
       if (user != User.NULL) {
         String codedPhrase = user.
         getPhraseEncodedByPassword();
         String phrase = cryptographer.decrypt(codedPhrase, password);
         if ("Valid Password".equals(phrase)) {
           Session.initialize();
           return true;
         }
       }
       return false;
     }
   }
```


The side effect is the call to Session.initialize(). The checkPassword function, by its name, says that it checks the password. The name does not imply that it initializes the session. So a caller who believes what the name of the function says runs the risk of erasing the existing session data when he or she decides to check the validity of the user.

## Output Arguments

Arguments are most naturally interpreted as inputs to a function. In general output arguments should be avoided. If your function must change the state of something, have it change the state of its owning object.

public void appendFooter(StringBuffer report)

should be rewritten as:

report.appendFooter();

## Command Query Separation

Functions should either do something or answer something, but not both. Either your function should change the state of an object, or it should return some information about that object. Doing both often leads to confusion.

## Prefer Exceptions to Returning Error Codes

Returning error codes from command functions is a subtle violation of command query separation. It promotes commands being used as expressions in the predicates of if statements:

if (deletePage(page) == E_OK) 

This does not suffer from verb/adjective confusion but does lead to deeply nested structures. When you return an error code, you create the problem that the caller must deal with the error immediately.

bad:
   
```
if (deletePage(page) == E_OK) {
     if (registry.deleteReference(page.name) == E_OK) {
       if (configKeys.deleteKey(page.name.makeKey()) == E_OK){
         logger.log("page deleted");
       } else {
         logger.log("configKey not deleted");
       }
     } else {
       logger.log("deleteReference from registry failed");
     }
   } else {
     logger.log("delete failed");
     return E_ERROR;
   }
```


On the other hand, if you use exceptions instead of returned error codes, then the error processing code can be separated from the happy path code and can be simplified:

   
```
try {
     deletePage(page);
     registry.deleteReference(page.name);
     configKeys.deleteKey(page.name.makeKey());
   }
   catch (Exception e) {
     logger.log(e.getMessage());
   }
```


## Extract Try/Catch Blocks

Try/catch blocks are ugly in their own right. They confuse the structure of the code and mix error processing with normal processing. So it is better to extract the bodies of the try and catch blocks out into functions of their own.

Functions should do one thing. Error handling is one thing. Thus, a function that handles errors should do nothing else.

When you use exceptions rather than error codes, then new exceptions are derivatives of the exception class. They can be added without forcing any recompilation or redeployment. (OCP)


## Don’t Repeat Yourself (DRY)

Duplication may be the root of all evil in software. Many principles and practices have been created for the purpose of controlling or eliminating it. Structured programming, Aspect Oriented Programming, Component Oriented Programming, are all, in part, strategies for eliminating duplication.


## How Do You Write Functions Like This?

Writing software is like any other kind of writing. When you write a paper or an article, you get your thoughts down first, then you massage it until it reads well. The first draft might be clumsy and disorganized, so you wordsmith it and restructure it and refine it until it reads the way you want it to read. 

The first version of functions come out long and complicated. They have lots of indenting and nested loops. They have long argument lists. The names are arbitrary, and there is duplicated code. Having a suite of unit tests that cover every one of those clumsy lines of code will greatly improve and encourage refactoring. You can refine that code, splitting out functions, changing names, eliminating duplication. Then, shrink the methods and reorder them, or even break out whole classes, all the while keeping the tests passing. In the end, you wind up with functions that follow the rules in this chapter. 


## Conclusion

Master programmers think of systems as stories to be told rather than programs to be written. They use the facilities of their chosen programming language to construct a much richer and more expressive language that can be used to tell that story.