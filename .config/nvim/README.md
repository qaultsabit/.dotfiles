# Neovim configuration

Requires Neovim 0.12 or newer. Treesitter parser installation also requires
`tree-sitter` CLI 0.26.1 or newer, a C compiler, `curl`, and `tar` on `PATH`.
Install the CLI through your system package manager or an upstream release.

After updating this configuration, run `:Lazy restore` to install the versions
in `lazy-lock.json`, then `:TSUpdate` to rebuild parsers for the new Treesitter
API. Parser installation is asynchronous; reopen a buffer after its parser
finishes installing to enable highlighting and indentation.

Syntax selection uses Neovim's built-in Treesitter support: Enter starts or
expands a selection, and Backspace selects a child node in Visual mode.
The existing function, class, loop, block, and parameter text objects remain
available in Visual and operator-pending modes.
