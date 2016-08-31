defmodule Screamer do
  @moduledoc """
  Module, if used, adds special function definition macro `def!`, which defines both raise and tuple error's functions.
  
  This is how it works:

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

  * The logics of this functions is based on the Elixir contracts: 
  screamed one raises error or return value, 
  clear one return `{:ok, value}` or `{:error, error}`:
  ```elixir
  iex> MyModule.foo
  {:error, %RuntimeError{message: "error"}}

  iex> MyModule.foo!
  ** (RuntimeError) error
  ```
  """

  @doc """
  Macro for importing screamer functionality to the module.

  ## Examples
  
      defmodule Foo do
        use Screamer

        def! bar, do: :bar
      end
  """
  defmacro __using__(_) do
    quote do: import Screamer
  end

  @doc """
  Macro to use instead of `def` keyword to generate screamer functions.
  """
  defmacro def!({name,env,params}, body) do
    sname = :"#{name}!"
    quote do
      def(unquote({sname, env,params}), unquote(body)) 

      def(unquote({name, env, params})) do
        try do
          {:ok,unquote({sname, env,params})}
        rescue
          error -> {:error, error}
        end
      end
    end
  end
end

