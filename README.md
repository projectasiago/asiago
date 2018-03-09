# Project Asiago

Please see the Project Asiago [website](http://asiago.io) for an explanation of what Project Asiago is. Or alternativly, view the website's source under /docs.

Consisting of these primary components:

 - [Mish](./mish) - programming language
 - [Aura](./aura) - operating system
 - [Mish Aura](./mish-aura) - interface that allows Mish to run on the Aura operating system
 - [Feta](./feta) - Rust shared library utilized by all Asiago components

You can also run Mish under an existing OS like you would any other language (e.g. Python).

 - [Mish Linux](./mish-linux) - allows Mish to run your Linux device
 - [Mish Windows](./mish-windows) - allows Mish to run on your Windows devices
 - [Mish Android](./mish-android) - allows Mish to run on your Android device
 - [Mish Web](./mish-web) - allows Mish to run inside your browser

There are also a few substitutes for using Aura as the hardware abstraction layer. These should be used when Aura's hardware support isn't good enough.

 - [Motal](./motal) - uses Linux as the hardware abstraction layer for Mish
 - [Rotal](./mish-redox) - uses Redox as the hardware abstraction layer for Mish