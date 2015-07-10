# Shell-config-files
Bash Profiles and other configs


#File List
```
.inputrc - Autocomplete ignores case. Search with up/down arrows. Visible bell instead of audible.
.profile - Heart of things... See below.
.shell_colors - Definitions for use by .profile.
.toprc - Tweak column arrangement.
.vimrc - Minor tweaks for colorizing, spaces instead of tabs (python friendly). 
```

#.profile
If the following files exist, they will be sourced/executed.
`~/Dropbox/shell/onload.sh`
`~/Dropbox/shell/aliases.sh`
`.home_aliases`

Note: For a while I put my configs in a Dropbox folder to sync them across multiple hosts and symlinked them in my home dir. `onload.sh` was used to set up the symlinks. This is **not** very safe. Another way is to build an alias to scp a list of files.

## Aliases

## Prompt
