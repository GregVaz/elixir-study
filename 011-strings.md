# Strings

Strings, Char Lists, Graphemes and Codepoints

## Strings

Elixir strings are nothing but a sequence of bytes. Let's look at an example:

```elixir
string = <<104,101,108,108,111>>
"hello"

string <> <<0>>
<<104,101,108,108,111>>
```

> Note: using << >> syntax we are saying to the compiler that the elements inside those symbols are bytes.

## Charlists

Elixir strings are represented with a sequence of bytes rather than an array of characters.
Elixir also has a char list type (character list).
**Elixir strings are enclosed with double quotes, while char lists are enclosed with single quotes.**

What is the difference? Each value in a charlist is the Unicode code point of a haracter whereas in a binary, the codepoints are encoded as UTF-8

```elixir
'hełło'
[104, 101, 322, 322, 111]
"hełło" <> <<0>>
<<104, 101, 197, 130, 197, 130, 111, 0>>
```

322 is the Unicode codepoint for `ł` but it is encoded in UTF-8 as the two bytes `197`, `130`.

You can get a character's code point by using `?`

```elixir
?Z
# 90
```

## Craphemes and Codepoints

Codepoints are just simple Unicode characters whiwch are repsented by one or more bytes, depending on the UTF-8 encodeing.
For example, Latin characters with a tilde or accents are typically encoded as two bytes.

The String module already provides two functions to obtain them, `graphemes/1` and `codepoints/1`.

```elixir
string = "\u0061\u0301"
"á"

String.codepoints string
["a", "´"]

String.graphemes string
["á"]
```

## String functions

Some of the most important and useful functions of the String module.
More information [String module](https://hexdocs.pm/elixir/String.html)

### length/1

Returns the number of Graphemes in a string

```elixir
String.length "Hello"
5
```

### replace/3

Returns a new string replacing a current pattern in a stringwit some new replacement string

```elixir
String.replace("Hello", "e", "a")
"Hallo"
```

### duplicate/2

Returns a new strning repeated n times

```elixir
String.duplicate("Oh my ", 3)
"Oh my Oh my Oh my "
```

### split/2

Returns a list of strings split by a pattern

```elixir
String.split("Hello Worlds", " ")
["Hello", "World"]
```

## Example

Anagrams

A and B are considered anagram if there's a way to rearrange A or B making them equal.

```elixir
defmodule Anagram do
  def anagrams?(a, b) when is_binary(a) and is_binary(b) do
    sort_string(a) == sort_string(b)
  end

  def sort_string(string) do
    string
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end
```
