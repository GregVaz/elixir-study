# Functions

## Anonymous functions

Just as the names implies, an anonymous function has no name.
To defnine an anonymous function in Elixir we neeed the `fn` and `end` keyworkds.
Within these we can define any number of parameters and function body separated by `->`

```
sum = fn (a, b) -> a + b end
sum.(2, 3)
5
```

### The & Shorthand

```
sum = $(&1 + &1)
sum.(2, 3)
5
```

## Pattern Matching

Pattern matching is not limited to just variables in Elixir, it can be applied to function signatures as we will see in this section.

Elixir uses pattern matching to check through all possible match options and select the firs matching option to run:

```
handle_result = fn
  {:ok, result} -> IO.puts "Handling result..."
  {:ok, _} -> IO.puts "This would be never run as previous will be matched beforehand."
  {:error} -> IO.puts "An error has ocurred! "
end

some_result = 1

handle_result.({:ok, some_result})
"Handlig result...."
:ok

handle_result.({:error})
"An error has ocurred!"
```

## Named Functions

We can define functions with names so we can easily refer to them later.
Named functions are defined within a module using the `def` keyword.

Functions defined within a module are available to other modules for use.

```
defmodule Greeter do
  def hello(name) do
    "Hello, " <> name
  end
end

Greeter.hello("Sean")
"Hello, Sean"
```

If our function body only spans one line, we can shorten it further with `do:`:

```
defmodule Greeter do
  def hello(name), do: "Hello, " <> name
end
```

Armed with our knowledge of pattern matching, let's explore recursion using named functions:

```
defmodule Length do
  def of([]), do: 0
  def of([_ | tail], do: 1 + of(tail))
end

Length.of []
0

Length.of [1, 2, 3]
3
```

## Function Naming with Arity

Functions are named by the combination of given name and arity (number of arguments).
This means you can do things like this:

```
defmodule Greeter do
  def hello(), do: "Hello, anonymous person!" # hello/0
  def hello(name), do: "Hello, " <> name # hello/1
  def hello(name, lastname), do: "Hello, {name} {lastname}"  # hello/2
end
```

## Functions and Patter Matching

Behind the scenes, functions are pattern-matching the arguments that they're called with.

Say we needed a function to accept a map but we're only interested in using a particular key.
We can pattern-match the argument on the presence of that key

```
defmodule Greeter do
  def hello(%{name: person_name}) do
    IO.puts "Hello, " <> person_name
  end
end

fred = %{
  name: "Freed",
  age: 25,
  favorite_color: "Purple"
}

Greeter.hello(fred)
"Hello, Freed"
```

In order to retiain and use all the data we are passing, we need to assign that entire map to its own variable for us to be able to use it.

```
defmodule Greeter do
  def hello(%{name: person_name} = person) do
    IO.puts "Hello, " <> person_name
    IO.inspect person
  end
end
```

> person, referring to %{name: "Fred", age: "95", favorite_color: "Taupe"}

> person_name, referring to "Fred"

## Private Functions

Private functions can only be called from within their own Module. We define them in Elixir with `depf`

```
defmodule Greeter do
  def hello(name), do: phrase() <> name
  defp phrase, do: "Hello, "
end

Greeter.hello("Sean")
"Hello, Sean"

Greeter.phrase
** (UndefinedFunctionError) function Greeter.phrase/0 is undefined or private
    Greeter.phrase()
```

## Guards

Once Elixir has matched a function any existing guardas will be tested.

We rely on guards to determine which to use based on the argument's type

```
defmodule Greeter do
  def hello(names) when is_list(names) do
    names
    |> Enum.join(", ")
    |> hello
  end

  def hello(name) when is_binary(name) do
    phrase() <> name
  end

  defp phrase, do: "Hello, "
end

Greeter.hello ["Sean", "Steve"]
"Hello, Sean, Steve"
```

## Default arguments

If we want a default value for an argument we use the `argument \\ value` syntax:

```
defmodule Greeter do
  def hello(name, langauge_code \\ "en") do
    phrase(language_code) <> name
  end

  defp phrase("en"), do: "Hello, "
  defp phrase("es"), do: "Hola, "
end

Greeter.hello("Sean", "en")
"Hello, Sean"

Greeter.hello("Sean")
"Hello, Sean"

Greeter.hello("Sean"m "es")
"Hola, Sean"
```

Elixir does not like default arguments in multiple matching functions, it can be confusing. To handle this we add a function head with our default arguments:

```
defmodule Greeter do
  def hello(names, langauge_code \\ "en")

  def hello(names, language_code) when is_list(names) do
    names
    |> Enum.koin(", ")
    |> hello(language_code)
  end

  defp phrase("en"), do: "Hello, "
  defp phrase("es"), do: "Hola, "
end

Greeter.hello ["Seam", "Steve"]
"Hello, Sean, Steve"

Greeter.hello ["Sean", "Steve"], "es"
"Hola, Sean, Steve"
```
