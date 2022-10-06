# This is a initialisation script for nix single-user installation.
# See nix installation: https://nixos.org/download.html.
#
# You may source this script at your config file ($nu.config-path).
# By sourcing this script:
#   * NIX_SSL_CERT_FILE and NIX_PROFILES environment variables will be set,
#   * MANPATH and PATH environment variables will be updated with nix entries.
#
# References:
#   * https://github.com/NixOS/nix/blob/master/scripts/nix-profile.sh.in.
#
# Limitations:
#   * Requires nushell version >= 0.68.
#
# Usage:
#   * source-env nix-profile.nu

# Return user's `.nix-profile` path, if it exists, `$nothing` otherwise.
def nix-profile () {
    let envs = (env).name
    if "HOME" in $envs && "USER" in $envs {
        $"($env.HOME)/.nix-profile"
    } # Else `nothing`.
}

# Return `true` if user's `.nix-profile` path exists, `false` otherwise.
def is-nix-profile () {
    not (nix-profile | is-empty)
}

# Prepend `path` to string of paths (colon separated), removing `path` duplicates.
def paths-str (path: path) {
    let paths = ($in | str replace $"($path):?" "" --all)
    if ($paths | is-empty) {
        $path
    } else {
        build-string $path ":" $paths
    }
}

# Prepend `path` to list of paths, removing `path` duplicates.
def paths-list (path: path) {
    where -b { |it| $it != $path } | prepend $path
}

# Prepend `path` to source, removing `path` duplicates. If source is not a `string`,
# `list<string>` or `nothing`, then return the original value.
def nix-path (path: path) {
    let input = $in
    let paths = if is-nix-profile {
        let type = ($input | describe)
        let path = build-string (nix-profile) $path
        if $type == "string" {
            $input | paths-str $path
        } else if $type == "list<string>" {
            $input | paths-list $path
        } else if $type == "nothing" {
            $path
        }
    }
    if ($paths | is-empty) { $input } else { $paths }
}

def nix-manpath (path: path) {
    let input = $in
    let paths = if (not ($input | is-empty)) && is-nix-profile {
        let type = ($input | describe)
        let path = build-string (nix-profile) $path
        if $type == "string" {
            $input | paths-str $path
        } else if $type == "list<string>" {
            $input | paths-list $path
        }
    }
    if ($paths | is-empty) { $input } else { $paths }
}

export-env {
    # Set a cert path to `$env.NIX_SSL_CERT_FILE` so that Nixpkgs applications like
    # curl will work. If no cert file is found, then set it to `$nothing`.
    let-env NIX_SSL_CERT_FILE = do {
        # System path candidates for `$env.NIX_SSL_CERT_FILE`.
        let system_paths = [
            # NixOS, Ubuntu, Debian, Gentoo, Arch.
            "/etc/ssl/certs/ca-certificates.crt",
            # openSUSE Tumbleweed.
            "/etc/ssl/ca-bundle.pem",
            # Old NixOS.
            "/etc/ssl/certs/ca-bundle.crt",
            # Fedora, CentOS.
            "/etc/pki/tls/certs/ca-bundle.crt",
        ]

        # User path candidates for `$env.NIX_SSL_CERT_FILE`.
        let user_paths = if is-nix-profile {[
            # Fall back to cacert in Nix profile.
            $"(nix-profile)/etc/ssl/certs/ca-bundle.crt",
            # Old cacert in Nix profile.
            $"(nix-profile)/etc/ca-bundle.crt"
        ]}

        # All path candidates for `$env.NIX_SSL_CERT_FILE`.
        let all_paths = ($system_paths | append $user_paths)

        # Find the first existing path and select it for `$env.NIX_SSL_CERT_FILE`.
        # If none exists, returns `nothing`.
        let matches = ($all_paths | find -p { |path| $path | path exists })
        if not ($matches | is-empty) { $matches | first }
    }

    # Set `$env.NIX_PROFILES` with nix profile paths (default and user).
    let-env NIX_PROFILES = do {
        let default = "/nix/var/nix/profiles/default"
        if is-nix-profile {
            $"($default) (nix-profile)"
        } else {
            $default
        }
    }

    # Prepend user's `.nix-profile/share/man` to `$env.MANPATH`, removing duplicates.
    let-env MANPATH = do {
        if "MANPATH" in (env).name {
            $env.MANPATH | nix-manpath "/share/man"
        } else {
            ""
        }
    }

    # Prepend user's `.nix-profile/bin` to `$env.PATH`, removing duplicates.
    let-env PATH = do {
        if "PATH" in (env).name {
            $env.PATH | nix-path "/bin"
        } else {
            ""
        }
    }
}
