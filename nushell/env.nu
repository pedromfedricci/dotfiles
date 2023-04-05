# Nushell Environment Config File
#
# version = 0.78.1

def create_left_prompt [] {
    mut home = ""
    try {
        if $nu.os-info.name == "windows" {
            $home = $env.USERPROFILE
        } else {
            $home = $env.HOME
        }
    }

    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace -s $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let path_segment = if (is-admin) {
        $"(ansi red_bold)($dir)"
    } else {
        $"(ansi green_bold)($dir)"
    }

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | date format '%m/%d/%Y %r')
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = {|| create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = {|| "> " }
let-env PROMPT_INDICATOR_VI_INSERT = {|| ": " }
let-env PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
let-env PROMPT_MULTILINE_INDICATOR = {|| "... " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# Set session level environment variables.
load-env {
    CARGO_HOME: $"($env.HOME)/.cargo",
    WASMTIME_HOME: $"($env.HOME)/.wasmtime",
    ZIG_HOME: $"($env.HOME)/.zig",
    WASMER_DIR: $"($env.HOME)/.wasmer",
    WASMER_CACHE_DIR: $"($env.HOME)/.wasmer/cache",
    HELIX_RUNTIME: $"($env.HOME)/.config/helix/runtime",
    DENO_INSTALL: $"($env.HOME)/.deno",
    EDITOR: $"($env.HOME)/.cargo/bin/hx",
}

# Bin paths. You can also appended them to `$env.PATH` below.
# Note: some expect other environment variables to be set previously.
load-env {
    LOCAL_BIN: $"($env.HOME)/.local/bin",
    CARGO_BIN: $"($env.CARGO_HOME)/bin",
    WASMTIME_BIN: $"($env.WASMTIME_HOME)/bin",
    WASMER_BIN: $"($env.WASMER_DIR)/bin",
    WAPM_BIN: $"($env.WASMER_DIR)/globals/wapm_packages/.bin",
    # A default path for js global tools. 
    # For anything else, start a POSIX shell with nvm.
    NODE_BIN: $"($env.HOME)/.nvm/versions/node/v18.8.0/bin",
    DENO_BIN: $"($env.DENO_INSTALL)/bin",
    ZIG_BIN: $"($env.ZIG_HOME)",
}

# Prepend new entries to $env.PATH if they are not present already.
def-env path-extend [entries: list] {
    let-env PATH = (
        $env.PATH
        | split row (char esep)
        | prepend $entries
        | uniq
        | str join (char esep)
    )
}

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
path-extend [
    $env.LOCAL_BIN
    $env.CARGO_BIN,
    $env.WASMTIME_BIN,
    $env.WASMER_BIN,
    $env.WAPM_BIN,
    $env.NODE_BIN,
    $env.DENO_BIN,
    $env.ZIG_BIN,
]

# Use completions for cargo.
use ~/.config/nushell/completions/cargo-completions.nu *

# Starship hook.
# mkdir ~/.cache/starship
# starship init nu | save --force ~/.cache/starship/init.nu
