# Screamer

Microlibrary, which adds special function definition macro `def!`, working like this:

* The body of the function should be defined to raise errors in case of exceptional situations.

```elixir
def MyModule
  use Screamer

  def! foo() do
    raise "error"
  end
end
```

* The macro would automaticaly create two functions: with and without screamer:
```bash
iex> MyModule.__info__ :functions
[foo: 0, foo!: 0]
```

* The logics of this functions is based on the Elixir contracts: screamed one raises error or return
value, clear one return `{:ok, value}` or `{:error, error}`:
```elixir
iex> MyModule.foo
{:error, %RuntimeError{message: "error"}}

iex> MyModule.foo!
** (RuntimeError) error
```

## Installation

The package is [available in Hex](https://hex.pm/packages/screamer), and can be installed as:

  1. Add `screamer` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:screamer, "~> 0.1.0"}]
    end
    ```

