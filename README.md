
# Shell Utilities #

This is a collection of (mostly) shell scripts aimed at simplifying various tasks, from development to networking, to procrastination.

### Installation ###

Clone the repo and run the `./install.sh` script to create appropriate links in your `bash` and `zsh` profiles. Then close the shell and open a new one.


### Usage ###

Each subfolder (core, desktop, dev, extra, etc.) represents a module, and loading a module will load all of the source files in that subfolder.  Modules are loaded by running `loadmod <module name>`, where hitting TAB after typing `loadmod` will show a list of availiable mods to load.

### Customization ###

The core, desktop, and network modules are loaded by default each time you spawn a shell, but these can be changed (and more added) by changing the `startup_hooks` file

Personal scripts can also be loaded by placing `__source_all </path/to/your/personal/scripts/>` in this `startup_hooks` file as given in the example.
