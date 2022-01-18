# Comprehensions

List ocmprehensions are syntactic sugar for looping through enumerables in Elixir.

## Basics

Comprehensions can often be used to produce more concise statements for `Enum` and `Stream` iteration.

```elixir
list = [1, 2, 3, 4, 5]
for x <- list, do: x*x
[1, 4, 9, 16, 25]
```

What is a generator? Generator are the `x <- [1, 2, 3, 4]` expressions found in list comprehensions. They are responsible for generatin the next value.

Lucky for us, comprenhensions are not imited to lists; in fact they will work with any enumerable.

```elixir
# keybword lists
for {_key, val} <- [one: 1, two: 2, three: 3], do: val
[1, 2, 3]

# Maps
for {k, v} <- %{"a" => "A", "b" => "B"}, do: {k, v}
[{"a", "A"}, {"b", "B"}]

# Binaries
for <<c <- "hello">>, do: <<c>>
["h", "e", "l", "l", "o"]
```

Like many other things in Elixir, **generators rely on pattern matching** to comprare their input set to the left side variable.
In the event a math is not found, the value is ignored:

```elixir
for {:ok, val} <- [ok: "Hello", error: "Unknown", ok: "World"], do: val
["Hello", "World"]
```

It is possible to use multiple generators, _much like nested loops_:

```elixir
lst = [1, 2, 3, 4]
for n <- list, times <- 1..n do
  String.duplicate("*", times)
end
["*", "*", "**", "*", "**", "***", "*", "**", "***", "****"]

# Other way to see it
for n <- list, times <- 1..n, do: IO.puts "#{n} - #{times}"
1 - 1
2 - 1
2 - 2
3 - 1
3 - 2
3 - 3
4 - 1
4 - 2
4 - 3
4 - 4
```

You can think of filters as a sort of guard for comprehensions.
When a filteres value returns `false` or `nil` it is excluded from the final list.

```elixir
import Integer
for x <- 1..10, is_even(x), do: x
[2, 4, 6, 8, 10]
```

Like generators we can use multiple filters
let's explain our range and then filter only for values that are both even and evenly divisible by 3

```elixir
import Integer
for x <- 1..100,
  is_even(x),
  rem(x, 3) == 0, do: x
[6, 12, 18, 24, 30, 36, 42, ...]
```

## Using :into

What if we want to produce something other tan a list?
Given the `:into` option we can do just that!

`:into` accepts any structure that implements the `Collectable` protocol.

Using :into, let’s create a map from a keyword list:

```elixir
for {k, v} <- [one: 1, two: 2, three: 3], into: %{}, do: {k, v}
%{one: 1, three: 3, two: 2}
```
