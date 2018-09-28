---
title: Asiago
---

View the source on [GitHub](https://github.com/projectasiago/asiago)!
 
Project Asiago's goal is to scrap much of the modern broken system and rebuild it from the ground up. Why? Because it allows us to forget about all the backwards compatiblity with existing hardware and software and design a more thought-out system.

## Examples of #BrokenSystem

Now you may not believe me that the system is "broken", but bear with me. At this point, you have always known a system like it is now, security issues being discovered every day and fixed the next, a system where APIs are defined by documentation and abided by by developers. You've always lived a life where "this is just the way things are".

But I don't believe that. I belive that with a fresh start, we could redesign everything to fix all these issues.

Take native code for example. How many issues could be fixed by sandboxing your code? A lot. Think of it like an app. An app should have a specific set of priviliges its allowed to use. The user grants the app these privileges and the app *must* comply. In fact, with Asiago, we don't even need to enforce runtime enforcement of these privileges because the app wouldn't be able to start in the first place if it doesn't comply with the privilege restrictions. If you allow native code to run on your system, it's *very* difficult to enforce these privilege restrictions because the program is running on hardware. There is little inbetween to audit the code automatically.

Another example: runtime exceptions (think Java). How many issues could be fixed by removing runtime exceptions? Ha! But you're probally thinking: "requiring exceptions to always be caught will make it very annoying for the developer". Well yes, of course. But why are these exceptions being thrown in the first place? Because there's some exception to the interface. Say you call the function: `root()` and you pass a `-1` to it. Before doing anything, your `root()` implementation probally checks if the number is less than 0. If it is, it throws a runtime exception. You wouldn't want the developer to always catch these exceptions if they never pass a -1, right? So what we do instead, is enforce constraints on the variable which the compiler checks to be sure these constraints are met. Then there's also the infamous null pointer exception. Some modern languages are starting to take the hint and remove these (Rust and Kotlin come to mind), and that's great! Asiago will prevent the same thing, and much more!

Files. Ugh, files! The unsafe tree of objects that anyone can edit. Junk! Say you want to save your app's state or settings. What you've got to do is take your app's nice structured state objects and convert them into plain text. Sometimes, your language supports reflection and then this becomes really easy. But if it doesn't, you've got to maintain a subroutine that goes through each element in your object and handles it. But bad stuff can happen once you try to load this state back in. Say a user goes and modifies this saved file. They could delete a property, or move it elsewhere. They could replace a text field with a number. And when your app tries to load this, corrupted! To fix this, we don't have files, we have persistent data. Wouldn't it be great if you could just know that the variable you're accessing is always going to be persisted and not have to worry about saving it first? JavaScript does this with the `localStorage` variable. It allows you to directly write your objects to it without having to marshall it first and you don't have to unmarshall it later, either! Asiago will do the same thing, but on a much more comprehensive level.

A worse situation exists with networking. Say you have a REST API. Your clients give you some data, but first, you must validate it. And if it doesn't pass validation, you're suppose to construct a reasonable error message and send it back to the client. Everytime you want to add a new feature, you've got to define this interface, add checks to everything, add documentation, marshall and unmarshall the data, and add nice error messages. It's just a pain and is deterrant to progress. Imagine if you could just define a regular function on the server with a bunch of constraints and be able to be done with it? That would be AWESOME and is exactly what works by default with Asiago. Note that this does currently exist with various things like Google's Protocol Buffers and Apache Thrift.

Now a lot of these points I'm trying to make do have workarounds or libraries that fix or make it easier to deal with. But that's just it, a "workaround". Asiago will be an entire system where all this functionality built in. Syntactical sugar and everything. Developers won't have to discover these fixes, but rather be presented with them from the start. Software will just work.

## But won't this constrain what developers can do?

Yes. Java and Python don't allow direct memory access, is this such a bad thing? No, because 95% of software doesn't need direct memory access. The same philosophy could be applied to any number of things. Files? 95% of software doesn't need to use files and is OK with just persisted state. Native code? 95% of software doesn't need to run at the speed of the processor.

If you really want to do things that Asiago doesn't allow, then go right ahead in your programming language of choice. Don't use Asiago for this particular project because it isn't the right tool for the job. You don't use a hammer to push in a nail just because hammers go bang bang. No, you use hammers because they have a large portion of their mass right above where the nail would be, rendering them an efficient tool for the job. But you wouldn't use a hammer to screw in a screw. If your project falls into the 95% category I'm taking about, you should use Asiago. If it doesn't, then don't.

Asiago does plan on offering a native platform access API for those super-inclined to access the native system. However, this is *highly* suggested against because not all platforms support these native features.

## Philosophy

 - Secure by default.
 - Principle of least privilege.
 - Compile time safety.
 - Sensible defaults.
