## Use Intention-Revealing Names

The name of a variable, function, or class, should answer all the big questions. It should tell you why it exists, what it does, and how it is used. If a name requires a comment, then the name does not reveal its intent.

bad:
int d; // elapsed time in days 

The name d reveals nothing. It does not evoke a sense of elapsed time, nor of days. We should choose a name that specifies what is being measured and the unit of that measurement:

good:
int elapsedTimeInDays;

Choosing names that reveal intent can make it much easier to understand and change code.

bad:
    
```
public List<int[]> getThem() {
     List<int[]> list1 = new ArrayList<int[]>();
     for (int[] x : theList)
       if (x[0] == 4)
         list1.add(x);
     return list1;
    }
```


good:

    
```
public List<int[]> getFlaggedCells() {
     List<int[]> flaggedCells = new ArrayList<int[]>();
     for (int[] cell : gameBoard)
       if (cell[STATUS_VALUE] == FLAGGED)
         flaggedCells.add(cell);
      return flaggedCells;
   }
```



## Avoid Disinformation

Do not refer to a grouping of accounts as an accountList unless it’s actually a List. The word list means something specific to programmers. If the container holding the accounts is not actually a List, it may lead to false conclusions.

Beware of using names which vary in small ways. How long does it take to spot the subtle difference between a XYZControllerForEfficientHandlingOfStrings in one module and, somewhere a little more distant, XYZControllerForEfficientStorageOfStrings?


## Make Meaningful Distinctions

The problem comes in when you decide to call a variable theZork because you already have another variable named zork.

Noise words are redundant. The word variable should never appear in a variable name. The word table should never appear in a table name. How is NameString better than Name?

bad:
   getActiveAccount();
   getActiveAccounts();
   getActiveAccountInfo();

How are the programmers in this project supposed to know which of these functions to call? The names should be changed in such a way that you don't need to look at the code in the method to find out what it does.


## Use Pronounceable Names

If you can’t pronounce it, you can’t discuss it without sounding like an idiot. “Well, over here on the bee cee arr three cee enn tee we have a pee ess zee kyew int, see?” This matters because programming is a social activity.

bad:
   
```
class DtaRcrd102 {
     private Date genymdhms;
     private Date modymdhms;
     private final String pszqint = ”102”;
     /* … */
   };
```


good:
   
```
class Customer {
     private Date generationTimestamp;
     private Date modificationTimestamp;;
     private final String recordId = ”102”;
     /* … */
   };
```



## Use Searchable Names

Single-letter names and numeric constants have a particular problem in that they are not easy to locate across a body of text.

Single-letter names can ONLY be used as local variables inside short methods. The length of a name should correspond to the size of its scope. If a variable or constant might be seen or used in multiple places in a body of code, it is imperative to give it a search-friendly name.

bad:
   
```
for (int j=0; j<34; j++) {
     s += (t[j]*4)/5;
   }
```


good:
   
```
int realDaysPerIdealDay = 4;
   const int WORK_DAYS_PER_WEEK = 5;
   int sum = 0;
   for (int j=0; j < NUMBER_OF_TASKS; j++) {
     int realTaskDays = taskEstimate[j] * realDaysPerIdealDay;
     int realTaskWeeks = (realdays / WORK_DAYS_PER_WEEK);
     sum += realTaskWeeks;
   }
```



## Avoid Mental Mapping

Readers shouldn’t have to mentally translate your names into other names they already know. This problem generally arises from a choice to use neither problem domain terms nor solution domain terms.


## Class Names

Classes and objects should have noun or noun phrase names like Customer, WikiPage, Account, and AddressParser. Avoid words like Manager, Processor, Data, or Info in the name of a class. A class name should not be a verb.


## Method Names

Methods should have verb or verb phrase names like postPayment, deletePage, or save. Accessors, mutators, and predicates should be named for their value and prefixed with get, set,


## Don’t Be Cute

If names are too clever, they will be memorable only to people who share the author’s sense of humor, and only as long as these people remember the joke. Will they know what the function named HolyHandGrenade is supposed to do? Sure, it’s cute, but maybe in this case DeleteItems might be a better name. Choose clarity over entertainment value.


## Pick One Word per Concept

Pick one word for one abstract concept and stick with it. For instance, it’s confusing to have fetch, retrieve, and get as equivalent methods of different classes.

Likewise, it’s confusing to have a controller and a manager in the same code base. What is the essential difference between a DeviceManager and a Protocol-Controller? Why are both not controllers or both not managers?


## Use Solution Domain Names

Remember that the people who read your code will be programmers. So go ahead and use computer science (CS) terms, algorithm names, pattern names, math terms, and so forth. It is not wise to draw every name from the problem domain because we don’t want our coworkers to have to run back and forth to the customer asking what every name means when they already know the concept by a different name. The name AccountVisitor means a great deal to a programmer who is familiar with the VISITOR pattern.


## Use Problem Domain Names

When there is no good solution domain name for what you’re doing, use the name from the problem domain. At least the programmer who maintains your code can ask a domain expert what it means. Separating solution and problem domain concepts is part of the job of a good programmer and designer. The code that has more to do with problem domain concepts should have names drawn from the problem domain.


## Add Meaningful Context

Imagine that you have variables named firstName, lastName, street, houseNumber, city, state, and zipcode. Taken together it’s pretty clear that they form an address. But what if you just saw the state variable being used alone in a method? Would you automatically infer that it was part of an address? 

You could add context by using prefixes: addrFirstName, addrLastName, addrState, and so on. At least readers will understand that these variables are part of a larger structure. Of course, a better solution is to create a class named Address. Then, even the compiler knows that the variables belong to a bigger concept.


## Don’t Add Gratuitous Context

In an imaginary application called “Gas Station Deluxe,” it is a bad idea to prefix every class with GSD. Frankly, you are working against your tools. You type G and press the completion key and are rewarded with a mile-long list of every class in the system. Is that wise? Why make it hard for the IDE to help you?

Shorter names are generally better than longer ones, so long as they are clear. Add no more context to a name than is necessary.


## Conclusion

The hardest thing about choosing good names is that it requires good descriptive skills and a shared cultural background.

People are also afraid of renaming things for fear that some other developers will object. We should not share that fear and find that we will actually be grateful when names change (for the better). You will probably end up surprising someone when you rename, just like you might with any other code improvement. Don’t let it stop you in your tracks.