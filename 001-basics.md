## Basics

Elixir comex with IEx, an interactive shell, which allows is to evaluate Elixir expressions as we go.
`$ iex`

- > 2+3
- > 2+3 == 4
- > 2+3 == 5
- > String.length("The quick brown fox")

### Basic data types

#### Integers

`iex> 255`

Support for binary, octal, and hexadecimal numbers
`iex> 0b0110`
`iex> 0o644`
`iex> 0x1F`

#### Floats

In elixir, floating point numbers require a decimal after at least one digit;
They have 64-bit double precision and support `e` for exponent values

`iex> 3.14`
`iex> .14` \*\* (SyntaxError) iex:2: syntax error before: '.'
`iex> 1.0e-10`

#### Booleans

Elixir supports `true` and `false`; everything is trythy expect for `false` and `nil`

#### Atoms

An atom is a constant whose name is its value. These are synonymous to Ruby Symbols

`iex> :foo`
`iex> :foo == :bar` \*\* false

The booleans true and false are also the atoms :true and :false, respectively.

`iex> is_atom(true)` true

`iex> is_boolean(:true)` true

`iex> :true === true` true

Names of modules in Elixir are also atoms. MyApp.MyModule is a valid atom, even if no such module has been declared yet.

`iex> is_atom(MyApp.MyModule)` true

Atom are also used to reference modules from Erlang libraries, including built in ones.

`iex> :crypto.strong_rand_bytes 3` <<23, 104, 108>>

#### Strings

String in Elixir are UTF-8 enconded and are wrapped in double quotes

`iex> "Hello"`

### Basic Operations

#### Arithmetic

Elixir supports the baisc operator `+`, `-`, `*`, `/`. It is important to remember that `/` will always return a float.

`iex> 2 + 2`
`iex> 2 - 2`
`iex> 2 * 2`
`iex> 2 / 2`

If you need a integer division or the division remainder(modulo). Elixi comes with two funcionts to achieve this:

`iex> div(10, 5)` 2
`iex> rem(10, 3)` 1

#### Boolean

Elixir provides the `||`, `&&`, `!` boolean operators.

`iex> -20 || true` -20
`iex> false || 42` 42

`iex> 42 && true` true
`iex> 42 && nil` nil

`iex> !42` false
`iex> !false` true

#### Comparision

Elixir comes with all the comparison operators we’re used to: `==`, `!=`, `===`, `!==`, `<=`, `>=`, `<`, and `>`.

For string comparision of integers and floats, use `===`

An important feature of Elixir is that any two types can be compared; this is particularly useful in sorting. We don’t need to memorize the sort order, but it is important to be aware of it:

`number < atom < reference < function < port < pid < tuple < map < list < bitstring`

This can lead to some interesting, yet valid comparisons you may not find in other languages:

`iex> :hello > 999` true
`iex> {:hello, :world} > [1, 2, 3]` false

#### String interpolation

`iex> name = "Sean"`
`iex> "Hello #{name}"`
