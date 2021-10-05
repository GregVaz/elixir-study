# Enums

The Enum module includes over 70 funtions for working with enumerables.
All the collections (list, keyword lists, maps) with exception of tuples, are enumerables.

For lazy enumerations use the "Stream" module.

## all?
When use `all/2`, we supply a function to applu to our collection's items. 
The entire collections mus evaluate to `true` otherwise `false` will be returned. 

`iex> Enum.all?(["foo", "bar", "hello"], fn(s) -> String.length(s) == 3 end)` false

`iex> Enum.all?(["foo", "bar", "hello"], fn(s) -> String.length(s) > 1 end)` true


## any?
Unlike the above, `any?/2` will return `true` if at least one item evaluates to `true`

`iex> Enum.any?(["foo", "bar", "hello"], fn(s) -> String.length(s) == 5 end)` true

### chunck_every
If you need to break your collection up into smaller groups

`iex> Enum.chunk_every([1, 2, 3, 4, 5, 6], 2)` [[1,2], [3,4], [5,6]]

### chunk_by
If we need to group our collection based on something other than size, we can use the chunk_by/2 function.

`iex> Enum.chunk_by(["one", "two", "three", "four", "five"], fn(x) -> String.length(x) end)` [["one", "two"], ["three"], ["four", "five"]]

### map_every
Sometimes chunking out a collections is not enough for exactly what we may need. 
If this is the case, `map_every/3` can hit ebery 'nth' items, always hitting the first one

`iex> Enum.map_every([1, 2, 3, 4, 5, 6, 7, 8], 3, fn x -> x + 1000 end)` [1001, 2, 3, 1004, 5, 6, 1007, 8]

## each
to iterate over a collection without producing a new value
`iex> Enum.each(["one", "two", "three"], fn(s) -> IO.puts(s) end)`
one
two
three
:ok

## map
To apply our function to each item and produce a new collection look to the `map/2` function
`iex> Enum.map([0, 1, 2, 3], fn(x) -> x - 1 end)` [-1, 0, 1, 2]

## min
`min/1` finds the minimal value in the collection
`iex> Enum.min([5, 3, 0, -1])` -1

`min/2` does the same, but in case the enumerable is empty, it allows us to specifi a function to produce the minimim value
`iex> Enum.min([], fn -> :foo end)` :foo

## max
`max/1` finds the maximal value in the collection
`iex> Enum.min([5, 3, 0, -1])` 5

`max/2` acts equal as `min/2`
`iex> Enum.max([], fn -> :foo end)` :foo

## filter
The `filter/2` function enables us to filter the collection to include only those elements that evaluate to `true` using the provided function

`iex> Enum.filter([1, 2, 3, 4], fn(x) -> rem(x, 2) == 0 end)` [2, 4]

## reduce
With `reduce/3` we can distill our collection down into a single value.
To do this we supply an optional accumulator (`10` in this example) ti ve oassed into our function;
if no accumulator is proviuded the first element in the enumerable is used:

`iex> Enum.reduce([1, 2, 3, 4], 10, fn(x, acc) -> x + acc end)` 16

`iex> Enum.reduce([1, 2, 3, 4], fn(x, acc) -> x + acc end)` 6

`iex> Enum.reduce(["a","b","c"], "1", fn(x,acc)-> x <> acc end)` "cba1"

## sort
`sort/1` uses Erlang's term ordering to determine the sorted order:

`iex> Enum.sort([5, 6, 1, 3, -1, 4])` [-1, 1, 3, 4, 5, 6]
`iex> Enum.sort([:foo, "bar", Enum, -1, 4])` [-1, 4, Enum, :foo, "bar"]

`sort/2` allows us to provide a sorting function of our own:

`iex> Enum.sort([%{:val => 4}, %{:val => 1}], fn(x, y) -> x[:val] > y[:val] end)` [%{val: 4}, %{val: 1}]
`iex> Enum.sort([%{:count => 4}, %{:count => 1}])` [%{count: 1}, %{count: 4}]

For convenience, `sort/2` allows us to pass `:asc` or `:desc` as the sorting function
`Enum.sort([2,3,1], :desc)`

## uniq
We can use `uniq/1` to remove duplicates from our enumerables
`iex> Enum.uniq([1, 2, 3, 2, 1, 1, 1, 1, 1])` [1, 2, 3]

### uniq_by
`uniq_by/2` also removes duplicates from enumerables, but it allows us to provide a function to do uniqueness comparison.

`iex> Enum.uniq_by([%{x: 1, y: 1}, %{x: 2, y: 1}, %{x: 3, y: 3}], fn coord -> coord.y end)` [%{x: 1, y: 1}, %{x: 3, y: 3}]

