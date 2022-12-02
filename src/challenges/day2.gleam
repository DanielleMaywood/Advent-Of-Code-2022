import gleam/erlang/file
import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn solution(_) {
  assert Ok(strategy) = file.read("data/day2/input.txt")

  let strategy =
    strategy
    |> string.split(on: "\n")
    |> list.filter(fn(round) { !string.is_empty(round) })
    |> list.map(string.split(_, on: " "))

  let score =
    strategy
    |> list.map(fn(round) {
      let [opponent, self] = round

      let shape_score = case self {
        "X" -> 1
        "Y" -> 2
        "Z" -> 3
      }

      case #(opponent, self) {
        #("A", "Y") | #("B", "Z") | #("C", "X") -> 6 + shape_score
        #("A", "X") | #("B", "Y") | #("C", "Z") -> 3 + shape_score
        #("A", "Z") | #("B", "X") | #("C", "Y") -> 0 + shape_score
      }
    })
    |> int.sum

  io.debug(score)

  let score =
    strategy
    |> list.map(fn(round) {
      let [opponent, round_status] = round

      let self = case #(opponent, round_status) {
        #("A", "X") -> "C"
        #("B", "X") -> "A"
        #("C", "X") -> "B"
        #(shape, "Y") -> shape
        #("A", "Z") -> "B"
        #("B", "Z") -> "C"
        #("C", "Z") -> "A"
      }

      let game_score = case round_status {
        "X" -> 0
        "Y" -> 3
        "Z" -> 6
      }

      let shape_score = case self {
        "A" -> 1
        "B" -> 2
        "C" -> 3
      }

      game_score + shape_score
    })
    |> int.sum

  io.debug(score)

  Ok(0)
}
