defmodule Screamer do
  defmacro __using__(_) do
    quote do: import Screamer
  end

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

