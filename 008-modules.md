# Modules

Modules allow us to organize functions into a namespace. IN addition to grouping finctions, they allow us to defined named and private functions.

```elixir
defmodule Example do
  def greeting(name) do
    "Hello, ${name}."
  end
end

Example.freeting "San"
"Hello, San."
```

> It is possible to nest modules in Elixir, allowing you to further namespace your functionality:

```elixir
defmodule Example.Greetings do
  def morning(name) do
    "Good morning #{name}."
  end

  def evening(name) do
    "Good morning #{name}."
  end
end

Example.Greetings.morning "Sean"
"Good morning Sean."
```

## Module Attributes

Module attributes are most commonly used as constants in Elixir.

```elixir
defmodule Example do
  @greeting "Hello"

  def greeting(name) do
    ~s(#{@greeting} #{name}.)
  end
end
```

It is important to note there are reserved attributes in Elixir. THe tree most common are:

- `moduledoc` - Documents the current module.
- `doc` - Documentation for functions and macros.
- `behaviour` - Use an OTP or user-defined behaviour.

## Structs

Structs are special maps with a defined set of keys and default values.
A struct must be defined within a module, which it takes its name from.
it is common for a struct to be the only thing defined within a module.

To define a struct we use `defstruct` along with a keyword list of fields and default variables

```elixir
defmodule Example.User do
  defstruct name: "Sean", roles: []
end

%Example.User{}
%Example.User<name: "Sean", roles: [], ...>

%Example.User{name: "Steve"}
%Example.User<name: "Steve", roles: [], ...>

%Example.User{name: "Steve", roles: [:manager]}
%Example.User<name: "Sean", roles: [:manager] >
```

We can update our struct just like we would a map:

```elixir
steve = %Example.User{name: "Steve"}
%Example.User<name: "Steve", roles: [], ...>

sean = %{steve | name: "Sean"}
%Example.User<name: "Sean", roles: [], ...>
```

As of Elixir 1.8 structs include custom introspection. To understand what this meanns and how er are to use it let us inspect our `sean` capture

```elixir
inspect(sean)
"%Example.User<name: \"Sean\", roles: [...], ...>"
```

All our fields are present which is okay for this example but what if we had a protected field we did not want to include?
The new `@derive` feature let's us accomplish just this!

```elixir
defmodule Example.User do
  @derive {Inspect, only: [:name]}
  defstruct name: nil, roles: []
end

sean = %Example.User{name: "Sean"}
%Example.User<name: "Sean", ...>

inspect(sean)
"%Example.User<name: \"Sean\", ...>"

# The `roles` are exluded from output!
```

_Note: we could also use `@derive {Inspect, except: [:roles]}`_, they are equivalent

## Composition

How to add existing functionality to them via composition.
Elixir provides us vith a variety of different ways to interact with other modules.

### alias

Allows us to alias module names; used quite frequently in Elixir code:

```elixir
defmodule Sayings.Greetings do
  def basic(name), do: "Hi, #{name}"
end

defmodule Example do
  alias Sayings.Greetings

  def greeting(name), do: Greetings.basic(name)
end

# Whitout alias

defmodule Example do
  def greeting(name), do: Sayings.Greetings.basic(name)
end
```

If there’s a conflict between two aliases or we just wish to alias to a different name entirely, we can use the :as option:

```elixir
defmodule Example do
  alias Sayings.Greetings, as: Hi

  def print_message(name), do: Hi.basic(name)
end
```

Or it is even possible to alias multiple modules at once:

```elixir
defmodule Example do
  alias Sayings.{Greetings, Farewells}
end
```

### import

If we want to import functions rather than aliasing the module, we can use `import`

```elixir
last([1, 2, 3])
** (CompileError) iex:9: undefined function last/1

import List

last([1, 2, 3])
3
```

### Filtering

By default all functions and macros are imported but we can filter them using the `:only` and `:except` options.

To import specific functions and macros, we must provide the name/arity pairs to `:only` and `:except`.

```elixir
import List, only: [last: 1]

first([1, 2, 3])
** (CompileError) iex:9: undefined function first/1

last([1, 2, 3])
3

# The use of :macros or :functions, which import only functions and macros respectively
import List, only: :functions
import List, only: :macros
```

### require

We could use `require` to tell Elixir you're going to use macros from other module.
The slight difference with `import` is that it allows using macros, but not functions from the specified module:

```elixir
defmodule Example do
  require SuperMacros

  SuperMacros.do_stuff
end
```

> If we attempt to call a macro that is not yet loaded Elixir will raise an error.

### use

When the `use` macro we can enable another module to modify our current module's definition. When we call `use` in our code we're actually invoking the `__using__/1` callback defined by the provided module.
The result of the `__using__/1` macro becomes part of our module's definition.

```elixir
defmodule Hello do
  defmacro __using__(_opts) do
    quote do
      def hello(name), do: "Hi, ${name}"
    end
  end
end

defmodule Example do
  use Hello
end

Example.hello("Sean")
"Hi, Sean"
```

Now that we’ve demonstrated a basic example let’s update our code to look at how `__using__/1` supports options. We’ll do this by adding a greeting option:

```elixir
defmodule Hello do
  defmacro __using__(opts) do
    greeting = Keyword.get(opts, :greeting, "Hi")

    quote do
      def hello(name), do: unquote(greeting) <> ", " <> name
    end
  end
end
```

Let’s update our Example module to include the newly created greeting option:

```elixir
defmodule Example do
  use Hello, greeting: "Hola"
end
```

If we give it a try in IEx we should see that the greeting has been changed:

```elixir
Example.hello("Sean")
"Hola, Sean"
```

_Note: quote, alias, use, require are macros related to metaprogramming._
