import gleam/io
import gleam/int
import gleam/list
import gleam/string
import gleam/erlang/file
import gleam/erlang.{start_arguments}
import glint

pub fn day1(_) {
  assert Ok(contents) = file.read("data/day1/calories.txt")

  let calories_list =
    contents
    |> string.split(on: "\n\n")

  assert Ok(calories_per_elf) =
    calories_list
    |> list.try_map(fn(elf) {
      try parsed_calories =
        elf
        |> string.split(on: "\n")
        |> list.try_map(int.parse)

      parsed_calories
      |> list.reduce(int.add)
    })

  let sorted_calories =
    calories_per_elf
    |> list.sort(int.compare)
    |> list.reverse()

  // Top elf
  assert Ok(top) = list.at(sorted_calories, 0)

  io.debug(top)

  // Top three
  assert Ok(top3) =
    list.take(sorted_calories, 3)
    |> list.reduce(int.add)

  io.debug(top3)
}

pub fn main() {
  glint.new()
  |> glint.with_pretty_help(glint.default_pretty_help)
  |> glint.add_command(
    at: ["day1"],
    do: day1,
    with: [],
    described: "Day 1 Challenge",
  )
  |> glint.run(start_arguments())
}
