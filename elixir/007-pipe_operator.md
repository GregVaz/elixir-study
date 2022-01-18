# Pipe Operator

> The pipe operator `|>` passes the result of an expression as the first parameter of another expression

Programming can get messy. So messy in fact that functions calls can get so embeded that they become difficult to follow.

`foo(bar(baz(new_function(other_function()))))`

Here, we are passing the value other_function/0 to new_function/1, and new_function/1 to baz/1, baz/1 to bar/1, and finally the result of bar/1 to foo/1

The pipe operator which looks like |> takes the result of one expression, and passes it on. Let’s take another look at the code snippet above rewritten using the pipe operator.

`other_function() |> new_function() |> baz() |> bar() |> foo()`

The pipe takes the result on the left, and asses it to the right hand side.

## Examples

- Tokenize String

  `"Elixir rocks" |> String.split()`
  ["Elixir", "rocks"]

- Uppercase all the tokens

  `"Elixir rocks" |> String.uppercase() |> String.split()`
  ["ELIXIR", "ROCKS"]

- Check ending

  `"elixir" |> String.ends_with?("ixir")`
  true
