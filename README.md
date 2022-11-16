
# Laptop Setup
An attempt at consolidating some of this stuff to reduce future google searches.

## Useful Links
- Homebrew: https://brew.sh/
- iTerm: https://www.iterm2.com/
- VSCode: https://code.visualstudio.com/
- Oh-my-zsh: https://ohmyz.sh/

## Install iTerm2
https://www.iterm2.com/

```shell
brew install iterm2 --cask
```  

*(Note: See below for installing homebrew)*

Iterm2 color schemes:   
https://github.com/mbadolato/iTerm2-Color-Schemes

## Install a Code Editor
### VSCode
https://code.visualstudio.com/

```shell
brew install visual-studio-code --cask
```  

**Shortcut For VSCode**  
Open the VSCode app and type in `command + shift P`, then type in `shell command` and click the search result. This will add a shortcut so that you can use `code` to open files and directories from your terminal in VSCode. For example, to open the directory you're currently in:

```shell
code .
```

## Install homebrew
```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"```

## Install git
```brew install git```


## Github
For getting set up with github, You may need to do the following:
- Generate a new key:  
  ```ssh-keygen -t rsa -b 4096 -C "your_email@example.com"```

- Copy the new rsa key:  
  ```pbcopy < ~/.ssh/id_rsa.pub```

- Add this key to your GitHub account

Additionally, you can configure your github user:  
```git config --global user.name ‘username’```  
```git config --global user.email ‘your_email@example.com’```

## Instal Zsh
https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH  
```brew install zsh```

## Install oh-my-zsh
```sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"```

## Fonts for iterm2(fix[?])
### Best font - Inconsolata for PowerShell
create folder
cd folder

git clone https://github.com/powerline/fonts.git

cd fonts

./install.sh

## Plugins that need additional installing

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting


## Set zsh as your default shell
If you don’t get prompted to do this when installing oh-my-zsh, try this:   
```chsh -s /usr/local/bin/zsh```

Additional reading for zsh config, covers themes, colors, fonts, etc:  
https://www.freecodecamp.org/news/how-to-configure-your-macos-terminal-with-zsh-like-a-pro-c0ab3f3c1156/

## Installing Ruby
ruby is probably already installed on your Macbook. You can check to confirm with:  
```ruby -v```

You can also install ruby with homebrew:  
```brew install ruby```

## XCode
You will probably need to install xcode at some point. Try this:
```shell
xcode-select --install
```  

## Postgres
To install:
```shell
brew install postgres
``` 

To start:
```shell
brew services start postgresql
```  


## Rails

```shell
sudo gem install rails
```

## Bundler

```shell
gem install bundler
```

## Python
```shell
brew install python
```  

## VIM
- [VIM links]

## Apps to use 
- Telegram
- Chrome
- CopyQ/Paste
- Caffeine
- flameShot 
- Discord
- SimpleRecord
- VsCode/RubyMine/Pycharm/Vim(+Pluggins)
- Docker Desktop
- 

 [VIM links]: <https://coderwall.com/p/1b5zcg/setup-vim-for-ruby-on-rails-osx>
