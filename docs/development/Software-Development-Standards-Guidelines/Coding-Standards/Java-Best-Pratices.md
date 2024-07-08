# Java Best Practices

The best practices are based on alibaba coding guide.

## 1. Naming Style

### 1.1 Don't start with or end with underscore or doolar sign when name variables

```
// Avoid
_name
$name
name_
name$
```

### 1.2 Using UpperCamelCase when naming classes

```
// Do
UserController
UserDTO

// Avoid
UserDto
userDto
userdto
```

### 1.3 Using lowerCamelCase when naming functions, parameters, member variables, local variables

```
// Do
localValue
getMessage(String userId)
```

### 1.4 Array definition

```
// Do
int[] userIds;
// Avoid
String name[];
```

### 1.5 Using lowercase and only one word between two period when naming package

```
com.henkel.project.name.util
```

### 1.6 Avoid same variable names in superclass and subclass and local variables in different code blocks

```
// Avoid
public class ConfusingName {
    public int stock;

    public void get(String value) {
        if (condition) {
            final int money = 666;
            // ...
        }

        for (int i = 0; i < 10; i++) {
            // Avoid
            final int money = 15978;
            // ...
        }
    }
}

class SubClass extends ConfusingName {
  // Avoid
  public int stock;
}
```

### 1.7 Using Enum as suffix when naming Enum Types, Using UPPER_SNAKE_CASE when naming the member names

```
enum ProcessStatusEnum {
    SUCCESS,
    UNKNOWN_REASON
}
```

## 2. Constant definition

### 2.1 Using uppercase L, avoid lowercase l when define long or Long variable

```
// Avoid
Long a = 2l;

// Do
long a = 2L;
```

### 2.2 Don't use a big constant class to maintain all constants, to seperate it by different functionality

Something like put cache constants to a class CacheConsts, put system configuration constants to a class ConfigConsts.

## 3. Code Style

### 3.1 If there's no content between braces, simplify it as {}, if not like bellow

i) don't add new line before left brace

ii) add new line after left brace

iii) add new line before right brace

iv) If it's a if-else block, don't add new line after right brace before else and add new line after the last right brace

### 3.2 Using 4 spaces, avoid tabs

```
public static void main(String[] args) {
    String sayHello = "hello";
}
```

### 3.3 Add a space when add comments

```
// Add a space after slash
String comment = new String();
```

### 3.4 Max line width as 120, if one line over 120 like bellow

```
StringBuilder sb = new StringBuilder();

// Add a new line with operater sign and add 4 space
sb.append("one").append("two").....
       .append("ten")....
       .append("twenty")....
       .append("thirty")....
```

## 4. Concurrency Handling

### 4.1 Clean custom ThreadLocal variables

```
objectThreadLocal.set(userInfo);
try {
    // ...
} finally {
    objectThreadLocal.remove();
}
```

### 4.2 When using lock

```
// Block waiting case
// Do
Lock lock = new XxxLock();
// ...
lock.lock();
try {
    doSomething();
    doOthers();
} finally {
    lock.unlock();
}

// Avoid
Lock lock = new XxxLock();
// ...
try {
    doSomething();
    lock.lock();
    doOthers();
} finally {
    lock.unlock();
}



// Trying case
Lock lock = new XxxLock();
// ...
boolean isLocked = lock.tryLock();
if (isLocked) {
    try {
        doSomething();
        doOthers();
    } finally {
        lock.unlock();
    }
}
```
