## Error Handling

Many code bases are completely dominated by error handling. Error handling is important, but if it obscures logic, it’s wrong.

## Use Exceptions Rather Than Return Codes

The problem with returning error codes is that they clutter the caller. The caller must check for errors immediately after the call. Unfortunately, it’s easy to forget. For this reason it is better to throw an exception when you encounter an error. The calling code is cleaner. Its logic is not obscured by error handling.

## Provide Context with Exceptions

Each exception that you throw should provide enough context to determine the source and location of an error.

Create informative error messages and pass them along with your exceptions. Mention the operation that failed and the type of failure. If you are logging in your application, pass along enough information to be able to log the error in your catch.


## Define Exception Classes in Terms of a Caller’s Needs

Often a single exception class is fine for a particular area of code. The information sent with the exception can distinguish the errors. Use different classes only if there are times when you want to catch one exception and allow the other one to pass through.


# Don’t Return Null

This invites an application where nearly every other line is a check for null.


```
public void registerItem(Item item) {
     if (item != null) {
       ItemRegistry registry = peristentStore.getItemRegistry();
       if (registry != null) {
         Item existing = registry.getItem(item.getID());
         if (existing.getBillingPeriod().hasRetailOwner()) {
           existing.register(item);
         }
       }
     }
   }
```


When we return null, we are essentially creating work for ourselves and foisting problems upon our callers. All it takes is one missing null check to send an application spinning out of control. It’s easy to say that the problem with the code above is that it is missing a null check, but in actuality, the problem is that it has too many.


## Don’t Pass Null

Returning null from methods is bad, but passing null into methods is worse. Unless you are working with an API which expects you to pass null, you should avoid passing null in your code whenever possible.

In most programming languages there is no good way to deal with a null that is passed by a caller accidentally. Because this is the case, the rational approach is to forbid passing null by default. When you do, you can code with the knowledge that a null in an argument list is an indication of a problem, and end up with far fewer careless mistakes.


## Conclusion

Clean code is readable, but it must also be robust. These are not conflicting goals. We can write robust clean code if we see error handling as a separate concern, something that is viewable independently of our main logic.