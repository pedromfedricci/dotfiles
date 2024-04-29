# My dotfiles

Personal configuration files, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Usage

You can clone this repository and select any configuration package as the following example:

```shell
git clone https://github.com/pedromfedricci/dotfiles.git ~/projects/dotfiles
cd ~/projects/dotfiles/config
stow --target $HOME --verbose helix zellij # or select all with: */
```

To remove a package configuration use `--delete`:

```shell
cd ~/projects/dotfiles/config
stow --target $HOME --verbose --delete helix zellij # or select all with: */
```

No existing files or directory paths will be overwritten, _Stow will never delete anything that
it doesn’t own_, see [conflicts](https://www.gnu.org/software/stow/manual/stow.html#Conflicts).

See the [Stow manual](https://www.gnu.org/software/stow/manual/stow.html) for more information.
