# Codewords solver

A simple ruby-based allgorithm for solving codewords (AKA [Cypher crosswords](https://en.wikipedia.org/wiki/Crossword#Cipher_crosswords)) - popular in many newspapers.

## Usage

```ruby
require "codewords_solver"

CodewordsSolver.solve! coded_words: grid, starting_letters: { 5 => "F", 7 => "L" }
```
or
```ruby
require "codewords_solver"

solver = CodewordsSolver.new grid, { 5 => "F", 7 => "L" }
solver.solve!
```
where
```ruby
grid = [
  [1, 13, 7, 11],
  [22, 5, 5, 13, 10, 17, 4, 15],
  [4, 13, 18, 3, 23],
  [16, 13, 7, 7, 13, 22, 26],
  [15, 10, 4, 12, 24, 25, 7, 17],
  [25, 13, 4, 22],
  [12, 24, 22, 9, 26, 23],
  [5, 13, 12, 26, 10, 17],
  [17, 26, 21, 14],
  [24, 12, 4, 23, 13, 12, 26, 15],
  [19, 4, 22, 8, 17, 10, 23],
  [4, 12, 13, 15, 17],
  [11, 13, 15, 10, 22, 9, 26, 23],
  [2, 9, 13, 19],
  [1, 22, 4, 20, 15, 19, 12, 10, 17],
  [19, 22, 11],
  [7, 12, 18, 17, 4],
  [22, 25, 21, 13, 22, 9, 15],
  [15, 23, 12, 24, 13, 26, 12],
  [7, 17, 18, 22],
  [5, 13, 16, 16, 7, 17],
  [23, 12, 4, 23, 12, 26],
  [13, 11, 7, 17],
  [24, 13, 6, 23, 9, 4, 17],
  [17, 11, 13, 23, 13, 22, 26],
  [12, 11, 13, 17, 9],
  [15, 22, 26],
  [22, 21, 17, 4, 15, 7, 17, 17, 19],
]
```

which is a machine-representation of a real-world grid that looks like this:

![IMG_2891](https://github.com/johansenja/codewords_solver/assets/43235608/27741a76-9a14-4dba-b25c-a59a89fcc51d)


**Note that while a codewords puzzle is typically formed into a grid with intersecting words, you do not need to mark such intersections here. A simple array of each of the numbered words will suffice!**

### Please note

A good codewords solver requires a good word list, and this one is far from perfect. If it isn't
solving a puzzle or it's making a mistake, it's quite likely that it's because there are words
missing from the list!
