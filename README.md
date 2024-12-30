# rust-pre-commit-checks

Rust checks for <http://pre-commit.com/>

## Usage

Make sure `pre-commit` is [installed](https://pre-commit.com#install).

Create a blank configuration file at the root of your repo, if needed:

```console
touch .pre-commit-config.yaml
```

Add a new repo entry in your configuration file:

```yaml
repos:
  - repo: https://github.com/tobinjt/rust-pre-commit-checks
    rev: <git sha or tag>
    hooks:
      # See below for hook documentation, in particular dependencies.
      - id: cargo-check
      - id: cargo-clippy
      - id: cargo-fmt
      - id: cargo-llvm-cov
      - id: cargo-test
```

Install the `pre-commit` script:

```console
pre-commit install --install-hooks
```

## Dependencies

You need to install the tools used for each hook and ensure they're in `$PATH`
for the checks to work. The required tool and brief installation instructions,
if any, is documented below beside each check.

## Workspaces

I haven't used
[cargo workspaces](https://doc.rust-lang.org/book/ch14-03-cargo-workspaces.html)
so these hooks don't support them because I have no way to test the config. PRs
adding workspaces support are welcome.

## Hooks

### cargo-check

Runs [cargo check](https://doc.rust-lang.org/cargo/commands/cargo-check.html).
`cargo check` should be installed by default with your Rust installation.

### cargo-clippy

Runs [cargo clippy](https://doc.rust-lang.org/clippy/usage.html). Install with
`rustup component add clippy`. The default args passed are `--deny warnings` to
fail on warnings.

### cargo-fmt

Runs [cargo fmt](https://github.com/rust-lang/rustfmt). `cargo fmt` should be
installed by default with your Rust installation.

### cargo-llvm-cov

Runs [cargo llvm-cov test](https://github.com/taiki-e/cargo-llvm-cov). Install
with `cargo +stable install cargo-llvm-cov --locked` (see
<https://github.com/taiki-e/cargo-llvm-cov?tab=readme-ov-file#from-source>). The
default args passed are `--quiet` to reduce output; consider using
`--fail-uncovered-lines=X` and `--fail-uncovered-functions=X` to require high
test coverage.

### cargo-test

Runs [cargo test](https://doc.rust-lang.org/cargo/commands/cargo-test.html).
`cargo test` should be installed by default with your Rust installation.
