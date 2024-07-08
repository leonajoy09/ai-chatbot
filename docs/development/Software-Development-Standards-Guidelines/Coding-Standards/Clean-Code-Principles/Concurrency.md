## Why Concurrency?

Consider a system that handles one user at a time and requires only one second of time per user. This system is fairly responsive for a few users, but as the number of users increases, the system’s response time increases. No user wants to get in line behind 150 others! We could improve the response time of this system by handling many users concurrently.


## Myths and Misconceptions

Concurrency always improves performance. - Concurrency can sometimes improve performance, but only when there is a lot of wait time that can be shared between multiple threads or multiple processors. Neither situation is trivial.

Design does not change when writing concurrent programs. - In fact, the design of a concurrent algorithm can be remarkably different from the design of a single-threaded system. The decoupling of what from when usually has a huge effect on the structure of the system.

Here are a few more balanced sound bites regarding writing concurrent software:

• Concurrency incurs some overhead, both in performance as well as writing additional code.
• Correct concurrency is complex, even for simple problems. 
• Concurrency bugs aren’t usually repeatable, so they are often ignored as one-offs instead of the true defects they are.   
• Concurrency often requires a fundamental change in design strategy.


## Concurrency Defense Principles

## Single Responsibility Principle

• Concurrency-related code has its own life cycle of development, change, and tuning.
• Concurrency-related code has its own challenges, which are different from and often more difficult than nonconcurrency-related code. 
• The number of ways in which miswritten concurrency-based code can fail makes it challenging enough without the added burden of surrounding application code.

Recommendation: Keep your concurrency-related code separate from other code.

## Corollary: Limit the Scope of Data

Recommendation: Take data encapsulation to heart; severely limit the access of any data that may be shared.

## Corollary: Use Copies of Data 

A good way to avoid shared data is to avoid sharing the data in the first place. In some situations it is possible to copy objects and treat them as read-only. In other cases it might be possible to copy objects, collect results from multiple threads in these copies and then merge the results in a single thread.

## Corollary: Threads Should Be as Independent as Possible

Consider writing your threaded code such that each thread exists in its own world, sharing no data with any other thread. Each thread processes one client request, with all of its required data coming from an unshared source and stored as local variables.

## Know Your Library

Recommendation: Review the classes available to you. In the case of Java, become familiar with java.util.concurrent, java.util.concurrent.atomic, java.util.concurrent.locks.


## Know Your Execution Models

| Bound Resources  | Resources of a fixed size or number used in a concurrent environ- ment. Examples include database connections and fixed-size read/ write buffers. |
| ---------------- | :----------------------------------------------------------- |
| Mutual Exclusion | Only one thread can access shared data or a shared resource at a time. |
| Starvation       | One thread or a group of threads is prohibited from proceeding for an excessively long time or forever. For example, always let- ting fast-running threads through first could starve out longer run- ning threads if there is no end to the fast-running threads. |
| Deadlock         | Two or more threads waiting for each other to finish. Each thread has a resource that the other thread requires and neither can finish until it gets the other resource. |
| Livelock         | Threads in lockstep, each trying to do work but finding another “in the way.” Due to resonance, threads continue trying to make progress but are unable to for an excessively long time— or forever. |

## Beware Dependencies Between Synchronized Methods

Recommendation: Avoid using more than one method on a shared object. 
There will be times when you must use more than one method on a shared object. When this is the case, there are three ways to make the code correct: 

• Client-Based Locking—Have the client lock the server before calling the first method and make sure the lock’s extent includes code calling the last method. 
• Server-Based Locking—Within the server create a method that locks the server, calls all the methods, and then unlocks. Have the client call the new method. 
• Adapted Server—create an intermediary that performs the locking. This is an example of server-based locking, where the original server cannot be changed.

Recommendation: Keep your synchronized sections as small as possible.


## Testing Threaded Code

Recommendations:

• Write tests that have the potential to expose problems and then run them frequently, with different programmatic configurations and system configurations and load. If tests ever fail, track down the failure. Don’t ignore a failure just because the tests pass on a subsequent run.
• Do not ignore system failures as one-offs.
• Do not try to chase down nonthreading bugs and threading bugs at the same time. Make sure your code works outside of threads.
• Run your threaded code on all target platforms early and often.
	

## Conclusion

Concurrent code is difficult to get right. Code that is simple to follow can become nightmarish when multiple threads and shared data get into the mix. If you are faced with writing concurrent code, you need to write clean code with rigor or else face subtle and infrequent failures.
	
	
	























