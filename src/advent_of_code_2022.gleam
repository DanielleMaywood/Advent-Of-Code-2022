import gleam/io
import gleam/int
import gleam/list
import gleam/string
import gleam/erlang/file
import gleam/erlang.{start_arguments}
import glint

pub fn split_by_elve(in calories) {
  let #(elve, remaining) =
    calories
    |> list.split_while(fn(elem) { !string.is_empty(elem) })

  case list.rest(remaining) {
    Ok([]) | Error(Nil) -> [elve]
    Ok(rest) -> [elve, ..split_by_elve(rest)]
  }
}

pub fn day1(_) {
  assert Ok(contents) = file.read("data/day1/calories.txt")

  let calories_list =
    contents
    |> string.split(on: "\n")

  assert Ok(calories_per_elve) =
    calories_list
    |> split_by_elve
    |> list.try_map(fn(elve) {
      try parsed_calories =
        elve
        |> list.try_map(int.parse)

      parsed_calories
      |> list.reduce(int.add)
    })

  let sorted_calories =
    calories_per_elve
    |> list.sort(int.compare)
    |> list.reverse()

  // Top elve
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