import gleam/erlang/file
import gleam/string
import gleam/list
import gleam/io

fn index(data: List(List(String)), idx: Int) -> Int {
  assert Ok(group) = list.at(data, idx)

  case list.length(group) == list.length(list.unique(group)) {
    True -> idx
    False -> index(data, idx + 1)
  }
}

fn solve(input: String, window_size: Int) -> Int {
  let data =
    input
    |> string.to_graphemes
    |> list.window(window_size)

  index(data, 0) + window_size
}

pub fn solution(_) {
  assert Ok(input) = file.read("data/day6/input.txt")

  io.debug(solve(input, 4))
  io.debug(solve(input, 14))

  Ok(0)
}
