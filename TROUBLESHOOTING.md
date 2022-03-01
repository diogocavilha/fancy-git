# :pick: Troubleshooting

### :bug: Double line problem and general weird behavior  
**System:** Linux/MAC OS - [reported issue](https://github.com/diogocavilha/fancy-git/issues/63).  
If you have a few more changes in your `.bashrc` file, be aware that `. ~/.fancy-git/prompt.sh` must be the last line of it.

### :bug: Problems with Konsole Terminal  
**System:** Linux (with KDE) - [reported issue](https://bugs.kde.org/show_bug.cgi?id=272443).  
Maybe you could face an issue related to icons rendering when using **Konsole** on version **18.12.1**.  
An idea here is to update the **Konsole** to its latest version. So the problem might be solved ;)

### :bug: Problems with `grep` command  
**System:** MAC OS - [reported issue](https://github.com/diogocavilha/fancy-git/issues/47).  
As you can read there, the solution found is to `brew install grep` and adding `/usr/local/opt/grep/libexec/gnubin` to the PATH ahead of `/usr/bin`.

### :bug: Problems with `sed` command  
**System:** MAC OS - [reported issue](https://github.com/diogocavilha/fancy-git/issues/47).  
You can follow the steps as you did for `grep`, but this time, installing `gnu-sed` by running `brew install gnu-sed`.

### :bug: Problems upgrading from v6.0.5 to a newest version  
If you've just upgraded it from v6.0.5 to a newest version, you might have seeing an error, because FancyGit can't find its configuration file.  
You can fix that just by running `fancygit --reset`. It'll create a default configuration file and reset the FancyGit state.

### :bug: Icons rendering  
**System:** Windows (WSL) - [reported issue](https://github.com/diogocavilha/fancy-git/issues/70).  
If you use Windows terminal, under WSL system, Fancy Git will not render icons and symbols properly.  
In this case, you can use [this font](https://github.com/microsoft/cascadia-code). This might solve the problem.
