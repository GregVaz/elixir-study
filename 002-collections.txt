# Collections

## List

Lists are simple collections of values which may include multiple types; lists may also include non-unique values:

`iex> [3.14, :pie, "Apple"]`

> Elixir implements list collections as linked lists

`iex> list = [3.14, :pie, "Apple"]`

\# Preprending (fast) O(1)

`iex> ["pi" | list]` ["π", 3.14, :pie, "Apple"]

\# Appeninig (slow) O(N + 1)

`iex> list ++ ["Cherry"]` [3.14, :pie, "Apple", "Cherry"]

### List Concatenation

List concatenation uses the ++/2 operator:

`iex> [1, 2] ++ [3, 4, 1]` [1, 2, 3, 4, 1]

### List Subtraction

Support for subtraction is provided via the --/2 operator; it’s safe to subtract a missing value:

`iex> ["foo", :bar, 42] -- [42, "bar"]` ["foo", :bar]

Be mindful of duplicate values. For every element on the right, the first occurrence of it gets removed from the left:

`iex> [1,2,2,3,2,3] -- [1,2,3,2]` [2, 3]

Note: List subtraction uses strict comparison to match the values. For example:

`iex> [2] -- [2.0]` [2]

`iex> [2.0] -- [2.0] ` []

### Head / Tail

When using lists, it is common to work with a list’s head and tail. The head is the list’s first element, while the tail is a list containing the remaining elements. Elixir provides two helpful functions, hd and tl, for working with these parts:

`iex> hd [3.14, :pie, "Apple"]` 3.14

`iex> tl [3.14, :pie, "Apple"]` [:pie, "Apple"]


## Tuples
Tuples are similar to list, but are stored contiguously in memory (like a linkedlist?)-
This makes accessing their lenght fast but modification expensive. 
Tuples are defined with curly braces.

`iex> {3.14, :pie, "Apple"}`


## Keyword list
Keyword lists and maps are the associative collections of Elixir. A keyword list is a special list of two-element tuples whose first element is an atom

`iex> [foo: "bar", hello: "world"]`  [foo: "bar", hello: "world"]
`iex> [{:foo, "bar"}, {:hello, "world"}]`   [foo: "bar", hello: "world"]

The three characteristics of keyword lists:
- Keys are atoms
- Keys are ordered
- Keys do not have to be unique

> Note: For these reasons, keyword lists are most commonly used to pass options to functions.

## Maps
Maps are the "go-to" key-value store. Unlike keyword lists, they allow keys of any type and are un-ordered.
You can define a map with the `%{}` syntax

`iex> map = %{:foo => "bar", "hello" => :world}` %{:foo => "bar", "hello" => :world}

`iex> map[:foo]` "bar"

`iex> map["hello"]` :world

### Properties
Variables are allowed as map keys:

`iex> key = "hello"`

`iex> %{key => "world"}` %{"hello" => "world"}


If a duplicate is added to a map, it will replace the former value:

`iex> %{:foo => "bar", :foo => "hello world"}`  %{foo: "hello world"}


There is a special syntax for maps containig only atom keys:

`iex> %{foo: "bar", hello: "world"}`

`iex> %{foo: "bar", hello: "world"} == %{:foo => "bar", :hello => "world"}`


There is a syntax for maps for accessing atom keys:

`iex> map.hello`  "world"


They provide their own syntax for updates (this creates a new map)

`iex> map = %{foo: "bar", hello: "world"}` %{foo: "bar", hello: "world"}

`iex> %{map | foo: "baz"}`  %{foo: "baz", hello: "world"}
Note: this syntax only works for updating a key that already exists in the map!

The create a new key, instead use 'Map.put/3'

`iex> map = %{hello: "baz"}`  %{hello: "world"}

`iex> Map.put(map, :foo, "baz")` %{foo: "baz", hello: "world"}
