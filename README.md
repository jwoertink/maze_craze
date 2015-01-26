# MazeCraze
dynamic maze game built with [jMonkeyEngine](http://jmonkeyengine.org) and [JRuby](http://jruby.org)

## Installation & Requirements
Currently only tested on Mac OSX 10.6+
* Open up your terminal on OSX
* Install JRuby (1.7+)

  ```rvm install jruby-head```

* Download MazeCraze

  ```git clone git://github.com/jwoertink/maze_craze.git```

* cd into the directory

  ```cd maze_craze```

* Install bundler

  ```gem install bundler```

* Bundle the gems

  ```bundle```

You should be good at this point.

## Running MazeCraze
Just run this command from the terminal
  ```jruby bin/maze_craze```

## Game Play
The object of the game is to find your way through the maze. There are some targets hidden within the maze. You must find them all, and destroy them before completing the maze.

## Road Map
* Add a working timer
* Add more levels
* Add a better generated maze
* Add Monsters
* Add a HUD GUI

## Structure (WIP)
*Actors* - The objects that interact within the game. Could be characters and props
*Scenes* - The views and layouts.
*Controllers* - The logic behind the views and layouts
*App* - Structure for the stage

## Development
* jme jar is pulled from [stable engine build](http://updates.jmonkeyengine.org/stable/3.0/engine/)

## Copyright
Copyright (c) 2012 Jeremy Woertink. You can download the game, and change the source code all you want. If you sell it, and make money, you have to give me credit :)
