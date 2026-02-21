### LX : The small ls like tool

lx: A small, lightweight ls like tool writen in the Odin programing language.
The name comes from a very simple place: `x` is close to `s` on the keyboard; thus `lx` was born

The

I made this tool a long while ago as a way to learn more Odin, but ended up liking it. I stopped using it after a resintall of my OS, I decided to bring it back after missing how it displayed information.

While there were plans to make this like grep as well, I have since abandond that idea. I like the though of `lx` being simple and straight to the point

I'm updating the code to use `core:os/os2` and remove the `navi` dependency.

## How to run

Build the executable by running `odin build .`, add the exectable to your path. Restart your terminal so it can pick up the updated path. Then run any of the following:

Below are a list of working things `lx` can do.

|Argument|Description|
|--------|-----------|
| Empty  | Shows all folders and files in current directory
| path   | Shows all folders and files in provided directory
