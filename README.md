Ruby Virtualenv
===============

Inspired by Python's [virtualenv](http://pypi.python.org/pypi/virtualenv)
project, Ruby-Virtualenv is a utility to create sandboxed Ruby/Rubygems
environments.

It is meant to address the following issues:

* Conflicts with unspecified gem dependency versions.
* Applications can have their own gem repositories.
* Permissions for installing your own gems.
* Ability to try gems out without installing into your global repository.
* A Simple way to enable this.

Running from your own gem repositories is fairly straight-forward, but
managing the necessary environment is a pain. This utility will create
a new environment which may be activated by the script `bin/activate` in
your sandbox directory.

Run the script with the following to enable your new environment:

    $ source bin/activate

When you want to leave the environment:

    $ deactivate

Notes
-----

* It creates an environment that has its own installation directory for Gems.
* It doesn't share gems with other sandbox environments.
* It (optionally) doesn't use the globally installed gems either.
* It will use a local to the sandbox .gemrc file
* Activating your sandbox environment will change your HOME directory
  temporarily to the sandbox directory. Other environment variables are
  set to enable this funtionality, so if you may experience odd behavior.
  Everything should be reset when you deactivate the sandbox.

Usage
-----

Create a new virtualenv (verbose output by default):

    $ ruby-virtualenv ~/.ruby-virtualenvs/my-new-sandbox
    creating new sandbox in /home/nkryptic/ruby-projects/my-new-sandbox
    installing activation script
    installing .gemrc
    installing gems:
      nothing to do

Create a new sandbox with no output:

    $ ruby-virtualenv ~/.ruby-virtualenvs/my-new-sandbox -q

Create a new sandbox with specific gems:

    $ ruby-virtualenv ~/.ruby-virtualenvs/my-new-sandbox -g rake,rails
    creating new sandbox in /home/nkryptic/ruby-projects/my-new-sandbox
    installing activation script
    installing .gemrc
    installing gems:
      gem: rake
      gem: rails

Install
-------

    $ gem install ruby-virtualenv

License
-------

    (The MIT License)

    Copyright (c) 2011 Francesc Esplugas
    Copyright (c) 2008 Jacob Radford

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    'Software'), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
