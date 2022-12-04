import gleam/erlang/file
import gleam/string
import gleam/list
import gleam/bool
import gleam/int
import gleam/io

pub fn part1(pairs: List(String)) {
  pairs
  |> list.map(fn(pair) {
    assert [[Ok(lhs_lower), Ok(lhs_upper)], [Ok(rhs_lower), Ok(rhs_upper)]] =
      pair
      |> string.split(on: ",")
      |> list.map(fn(bounds) {
        bounds
        |> string.split(on: "-")
        |> list.map(int.parse)
      })

    case lhs_lower, rhs_lower, lhs_upper, rhs_upper {
      _, _, _, _ if lhs_lower >= rhs_lower && lhs_upper <= rhs_upper -> True
      _, _, _, _ if rhs_lower >= lhs_lower && rhs_upper <= lhs_upper -> True
      _, _, _, _ -> False
    }
  })
  |> list.filter(bool.and(_, True))
  |> list.length
}

pub fn part2(pairs: List(String)) {
  pairs
  |> list.map(fn(pair) {
    assert [[Ok(lhs_lower), Ok(lhs_upper)], [Ok(rhs_lower), Ok(rhs_upper)]] =
      pair
      |> string.split(on: ",")
      |> list.map(fn(bounds) {
        bounds
        |> string.split(on: "-")
        |> list.map(int.parse)
      })

    case lhs_lower, rhs_lower, lhs_upper, rhs_upper {
      _, _, _, _ if lhs_lower >= rhs_lower && lhs_upper <= rhs_upper -> True
      _, _, _, _ if rhs_lower >= lhs_lower && rhs_upper <= lhs_upper -> True
      _, _, _, _ if lhs_lower >= rhs_lower && lhs_lower <= rhs_upper -> True
      _, _, _, _ if rhs_lower >= lhs_lower && rhs_lower <= lhs_upper -> True
      _, _, _, _ if lhs_upper >= rhs_lower && lhs_upper <= rhs_upper -> True
      _, _, _, _ if rhs_upper >= lhs_lower && rhs_upper <= lhs_upper -> True
      _, _, _, _ -> False
    }
  })
  |> list.filter(bool.and(_, True))
  |> list.length
}

pub fn solution(_) {
  assert Ok(input) = file.read("data/day4/input.txt")

  let pairs =
    input
    |> string.trim
    |> string.split(on: "\n")

  io.debug(part1(pairs))
  io.debug(part2(pairs))

  Ok(0)
}
