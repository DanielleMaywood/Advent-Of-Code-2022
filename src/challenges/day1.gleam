import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn solution(_) {
  assert Ok(calories) = file.read("data/day1/calories.txt")

  assert Ok(calories_per_elf) =
    calories
    |> string.split(on: "\n\n")
    |> list.try_map(fn(elf) {
      elf
      |> string.split(on: "\n")
      |> list.try_map(int.parse)
      |> result.map(int.sum)
    })

  let sorted_calories =
    calories_per_elf
    |> list.sort(fn(lhs, rhs) { int.compare(rhs, lhs) })

  // Top elf
  assert Ok(top) = list.at(sorted_calories, 0)

  io.debug(top)

  // Top three
  let top3 =
    sorted_calories
    |> list.take(3)
    |> int.sum

  io.debug(top3)

  Ok(0)
}
