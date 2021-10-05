# Control Structures

## if and unless

`if/2`, In Elixir they work much the same way but they are defined as macros, not language constructs.
You can find their implementation in the Kernel module.

it should be noted that in Elixir, the only falsey values are `nil` and the boolean `false`.

```
iex> if "a string value" do
...>  "Truthy"
...> end
"Truthy"
```

Using `unless/2` is like `if/2` only it works on the negative:

```
iex> unless is_integer("hello") do
...>  "Not an Int"
...> end
"Not an Int"
```

## case

If it's necessary to match agains multiple patterns we can use `case/2`:

```
iex> case {:ok, "Hello World"} do
...>  {:ok, result} -> result
...>  {:error} -> "Uh oh!"
...>  _ -> "Catch all"
...> end
"Hello World"
```

The `_` variable is an important inclusion in `case/2` statements. Whitout it, gailure to find a match will raise an error:

```
iex> case :even do
...>  :odd -> "Odd"
...> end
** (CaseClauseError) no case clause matching: :even

iex> case :even do
...>  :odd -> "Odd"
...>  _ -> "Not Odd"
...> end
"Not Odd"
```

Consider the `_` as the `else` that will match **"everything else"**

Since case/2 relies on pattern matching, all of the same rules and restrictions apply. If you intend to match against existing variables you must use the pin ^/1 operator:

```
iex> pie = 3.14
3.14

case "cherry pie" do
  ^pie -> "Not so tasty"
  pie -> "I bet #{pie} is tasty"
end
"I bet cherry pie is tasty"
```

Another net feature of `case/2` is its support for guard clauses:

```
case {1, 2, 3} do
  {1, x, 3} when x > 0 ->
    "Will match"
  _ ->
    "Won't match"
end
"Will match"
```

## cond ^

When we need to match conditions eather than values we can turn to `cond/1`l this is akin to `else if` or `elsif` from other languages

```
cond do
  2 + 2 == 5 ->
    "This will not be true"
  2 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
end
"But this will"
```

Like case/2, cond/1 will raise an error if there is no match. To handle this, we can define a condition set to true:

```
case do
  7 + 1 == 0 -> "Incorrect"
  true -> "Catch all"
end
"Catch all"
```

## with

The special form `with/1` is useful when you might use a nested `case/2` stateent or situations that cannot cleanly be piped together.
The `with/1` expression is composed of the keyworkds, the generators, and finally an expression.

We only need to know at the moment that they use pattern matching to compare the right side of the `<-` to the left.

```
user = %{first: "Sean", last: "Callan"}
%{first: "Sean", last: "Callan"}

with {:ok, first} <- Map.fetch(user, :first),
     {:ok, last} <- Map.fetch(user, :last),
     do: last <> ", " <> first
"Callan, Sean"
```

In the event that an expression fails to match, the non-matching value will be returned: {:error}

Let's see a larger example without `with/1` and then see how we can refactor it:

```
case Repo.insert(changeset) do
  {:ok, user} ->
    case Guardian.encode_and_sign(user, :token, claims) do
      {:ok, token, full_claims} ->
        important_stuff(token, full_claims)

      error ->
        error
    end

  error ->
    error
end
```

```
with {:ok, user} <- Repo.insert(changeset),
     {:ok, token, full_claims} <- Guardian.encode_and_sign(user, :token, claims) do
  important_stuff(token, full_claims)
end
```

Finally, as of Elixir 1.3, `with/1` statements support `else`:

```
import Integer

m = %{a: 1, c: 3}

a =
  with {:ok, number} <- Map.fetch(m, :a),
    true <- is_even(number) do
      IO.puts "#{number} divided by 2 is #{div(number, 2)}"
      :even
  else
    :error ->
      IO.puts("We don't have this item in map")
      :error

    _ ->
      IO.puts("It is odd")
      :odd
  end
```
