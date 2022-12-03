import gleam/erlang/file
import gleam/io
import gleam/list
import gleam/string

fn part1(strategy: List(List(String))) {
  use total, round <- list.fold(strategy, 0)

  let [opponent, self] = round

  let shape_score = case self {
    "X" -> 1
    "Y" -> 2
    "Z" -> 3
  }

  let round_score = case opponent, self {
    "A", "Y" | "B", "Z" | "C", "X" -> 6
    "A", "X" | "B", "Y" | "C", "Z" -> 3
    "A", "Z" | "B", "X" | "C", "Y" -> 0
  }

  total + round_score + shape_score
}

fn part2(strategy: List(List(String))) {
  use total, round <- list.fold(strategy, 0)

  let [opponent, round_status] = round

  let self = case opponent, round_status {
    "A", "X" -> "C"
    "B", "X" -> "A"
    "C", "X" -> "B"
    shape, "Y" -> shape
    "A", "Z" -> "B"
    "B", "Z" -> "C"
    "C", "Z" -> "A"
  }

  let round_score = case round_status {
    "X" -> 0
    "Y" -> 3
    "Z" -> 6
  }

  let shape_score = case self {
    "A" -> 1
    "B" -> 2
    "C" -> 3
  }

  total + round_score + shape_score
}

pub fn solution(_) {
  assert Ok(strategy) = file.read("data/day2/input.txt")

  let strategy =
    strategy
    |> string.trim
    |> string.split(on: "\n")
    |> list.map(string.split(_, on: " "))

  io.debug(part1(strategy))
  io.debug(part2(strategy))

  Ok(0)
}
