---
title: "Javascript: Remove Duplicates From Arrays — A Simple Way"
date: 2023-06-24T21:45:00+05:30
excerpt: Learn a simple and elegant way to remove duplicate values from JavaScript arrays using the Set object.
category: Web Programming
tags: ["javascript", "arrays", "set"]
---

Let us dive right away with an example.

```js
const urls = [
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg",
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg",
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg",
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg",
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg",
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg",
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg",
    "https://example.com/premade/wp-content/uploads/sites/4/2023/11/800x800.jpg"
];

const uniqueUrls = [...new Set(urls)];

console.log(uniqueUrls);
```

Now the question is — how does a Set object remove duplicates? Set objects are collections of values. A value in the set may only occur once; it is unique in the set's collection.

Note that our array urls must be converted to set and then back to array. The conversion is very simple.

```js
const myArray = ["value1", "value2", "value3"];

// Use the regular Set constructor to transform an Array into a Set
const mySet = new Set(myArray);

mySet.has("value1"); // returns true

// Use the spread syntax to transform a set into an Array.
console.log([...mySet]); // Will show you exactly the same Array as myArray
```
