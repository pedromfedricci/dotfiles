# set PATH so it includes user's private /bin if it exists.
if [ -d "$HOME/.local/bin" ] ; then
    . "$HOME/.local/env"
fi

# Add elixir-ls shell script dir to path. Note that Helix expects
# the script to be executable and named "elixir-ls" as opose to
# the original name "language_server.sh".
. "$HOME/.elixir-ls/env"

# add cargo bin to PATH if it's not present already.
. "$HOME/.cargo/env"

# add go bin to PATH if it's not present already.
. "$HOME/.go/env"

# add zig bin to PATH if it's no present already.
. "$HOME/.zig/env"

# add wasmtime bin to PATH if it's not present already.
. "$HOME/.wasmtime/env"

# add deno bin to PATH if it's not present already.
. "$HOME/.deno/env"

# add rebar3 to path.
export PATH=/home/pdmfed/.cache/rebar3/bin:$PATH

# Helix runtime files.
export HELIX_RUNTIME="$HOME/.config/helix/runtime"

# set nix environment, adds bin to PATH if it's not already.
if [ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ]; then 
    . "$HOME/.nix-profile/etc/profile.d/nix.sh";
fi
