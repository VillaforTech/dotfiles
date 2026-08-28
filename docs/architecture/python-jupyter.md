# Python and Jupyter

Homebrew owns the `uv` executable. uv owns Python command-line tools and project
environments; Conda, pyenv, pipx, and mise are not Jupyter owners.

The shared interface is one uv tool environment named `jupyterlab`, built with
uv-managed Python 3.13.11. Its direct pins live in
`python/jupyter-tool.in`, and `python/jupyter-tool.lock` pins the complete
resolved package set. Recreate it with:

```bash
./scripts/install-jupyter-tool
```

That command exposes `jupyter`, `jupyter-lab`, `jupytext`, `nbdime`, and the
nbdime helper commands from the same environment. It does not create, replace,
or remove user or project kernels.

Experiments keep dependencies in their own uv project environment and register
that interpreter as a named kernel. The shared tool environment is only the
Jupyter user interface and conversion/diff toolchain; it is not the dependency
source for a project notebook.

Before changing a pin, preserve the current uv receipt, package freeze, command
links, and user kernels. Build and smoke-test the replacement in isolated
`UV_TOOL_DIR` and `UV_TOOL_BIN_DIR` paths before replacing the live environment.
Regenerate the lock deliberately with the pinned Python version, then verify a
disposable executed notebook, a Jupytext percent-script round trip, an nbdime
diff, and `jupyter kernelspec list`.
