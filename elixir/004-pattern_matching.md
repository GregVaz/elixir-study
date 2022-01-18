# Pattern Matching

It allows us to match simple values, dat strcutres, and even functions

## Match Operator ^

In Elixir, the `=` operator is actually a match operator, comparable to the equals sign in algebra.
Writing it turns the whole expressinos into an equation and makes Elixir match the values on the left hand with the values on the right hand.
If the match succeeds, it returns the value of the equation. Otherwise, it throws an error.

`iex> x = 1`

1

Now, let's try some simple matching

`iex> 1 = x`

1

`iex> 2 = x`

\*\* (MatchError) no match of right hand side value: 1

With some of the collections we know:

### Lists

`iex> list = [1, 2, 3]`

[1,2,3]

`iex> [1, 2, 3] = list`

[1, 2, 3]

`iex> [] = list`

\*\* (MatchError) no match of right hand side value: 1

### Tuples

`iex> {:ok, value} = {:ok, "Successful!"}`

{:ok, "Successful!"}

`iex> value`

"Successful!"

`iex> {:ok, value} = {:error}`

\*\* (MatchError) no match of right hand side value: {:error}

## Pin operator

The match operator performs assignment when the left side of the match includes a varibale. In some cases this variable rebinding behaviour is undesireable.
For these situations we have the pin operator: `^`

> When we pin a variable we match on the existing value rather than rebinding to a new one.

`iex> x = 1`

`iex> ^x = 2`
\*\* (MatchError) no match of right hand side value: 2

`iex> {x, ^x} = {2, 1}` {2, 1}

`iex> x` 2

Elixir 1.2 introduced support for pints in map keys and functions clauses:

```
iex> key = "hello"
"hello"

iex> %{^key => value} = %{"hello" => "world"}
%{"hello" => "world"}

iex> value
"world"

iex> %{^key => value} = %{:hello => "world"}
** (MatchError) no match of right hand side value: %{hello: "world"}
```

An example of pinning in a function clause:

```
iex> geeting = "Hello"
"Hello"

iex> greet = fn
...>  (^greeting, name) -> "Hi #{name}"
...>  (greeting, name) -> "#{greeting}, #{name}"
...> end
#Function<>

iex> greet.("Hello", "Sean")
"Hi Sean"

iex> greet.("Mornin'", "Sean")
"Mornin', Sean"

iex> greeting
"Hello"
```
