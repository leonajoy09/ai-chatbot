## Objects and Data Structures

There is a reason that we keep our variables private. We don’t want anyone else to depend on them. We want to keep the freedom to change their type or implementation on a whim or an impulse. 


## Data Abstraction

Hiding implementation is not just a matter of putting a layer of functions between the variables. Hiding implementation is about abstractions! A class does not simply push its variables out through getters and setters. Rather it exposes abstract interfaces that allow its users to manipulate the essence of the data, without having to know its implementation.

   
```
public interface Vehicle {
     double getFuelTankCapacityInGallons();
     double getGallonsOfGasoline();
   }
```


versus

   
```
public interface Vehicle {
     double getPercentFuelRemaining();
   }
```


We do not want to expose the details of our data. Rather we want to express our data in abstract terms.


## Data/Object Anti-Symmetry

Objects hide their data behind abstractions and expose functions that operate on that data. Data structure expose their data and have no meaningful functions.

Consider the following code:

 
```
public class Square {
     public Point topLeft;
     public double side;
   }
 public class Rectangle {
     public Point topLeft;
     public double height;
     public double width;
   }
 public class Circle {
     public Point center;
 public double radius;
   }
 public class Geometry {
     public final double PI = 3.141592653589793;
 public double area(Object shape) throws NoSuchShapeException 
     {
       if (shape instanceof Square) {
         Square s = (Square)shape;
         return s.side * s.side;
       }
 else if (shape instanceof Rectangle) {
         Rectangle r = (Rectangle)shape;
         return r.height * r.width;
       }
       else if (shape instanceof Circle) {
         Circle c = (Circle)shape;
         return PI * c.radius * c.radius;
       }
       throw new NoSuchShapeException();
     }
   }
```


Consider what would happen if a perimeter() function were added to Geometry. The shape classes would be unaffected! Any other classes that depended upon the shapes would also be unaffected! On the other hand, if I add a new shape, I must change all the functions in Geometry to deal with it.

Now consider the object-oriented solution below. Here the area() method is polymorphic. No Geometry class is necessary. So if I add a new shape, none of the existing functions are affected, but if I add a new function all of the shapes must be changed!


```
public class Square implements Shape {
     private Point topLeft;
     private double side;
 public double area() {
       return side*side;
     }
   }
 public class Rectangle implements Shape {
     private Point topLeft;
     private double height;
     private double width;
   public double area() {
       return height * width;
 }
   }
 public class Circle implements Shape {
       private Point center;
       private double radius;
       public final double PI = 3.141592653589793;
 public double area() {
         return PI * radius * radius;
       }
   }
```


Procedural code (code using data structures) makes it easy to add new functions without changing the existing data structures. OO code, on the other hand, makes it easy to add new classes without changing existing functions.


## The Law of Demeter

The Law of Demeter says a module should not know about the innards of the objects it manipulates.

More precisely, the Law of Demeter says that a method f of a class C should only call the methods of these: 
	• C 
	• An object created by f 
	• An object passed as an argument to f
	• An object held in an instance variable of C 

The method should not invoke methods on objects that are returned by any of the allowed functions.


## Data Transfer Objects

The quintessential form of a data structure is a class with public variables and no functions. This is sometimes called a data transfer object, or DTO.


## Conclusion

Objects expose behavior and hide data. This makes it easy to add new kinds of objects without changing existing behaviors. It also makes it hard to add new behaviors to existing objects. Data structures expose data and have no significant behavior. This makes it easy to add new behaviors to existing data structures but makes it hard to add new data structures to existing functions.

In any given system we will sometimes want the flexibility to add new data types, and so we prefer objects for that part of the system. Other times we will want the flexibility to add new behaviors, and so in that part of the system we prefer data types and procedures.