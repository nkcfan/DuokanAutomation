# DuokanAutomation
This a web automation tool to collect Duokan daily sales using your own user name and password.

## Preparation
###QT
####Linux
    sudo apt-get install qt4-dev-tools libqt4-dev libqt4-core libqt4-gui
####OS X
    brew install qt

###MySQL2
####Linux
    sudo apt-get install libmysqlclient-dev
    sudo gem install mysql2
####OS X
    brew install mysql
    
###Bundler
    gem install bundler
    bundle install

## Usage Examples
    ./DuokanAutomation.rb 'username' 'password'
    
## Copyright
Copyright (c) 2014 nkcfan. See [LICENSE][] for details.

[license]: LICENSE.md
