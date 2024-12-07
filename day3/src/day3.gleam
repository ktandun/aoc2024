import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp
import gleam/string
import utils

pub fn main() {
  let day_input = utils.read_input()

  part_one(day_input)
  |> io.debug

  part_two(day_input)
  |> io.debug
}

fn part_one(input: List(String)) {
  let assert Ok(re) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")

  input
  |> string.join("")
  |> regexp.scan(with: re, content: _)
  |> list.map(fn(match) {
    match.submatches
    |> list.map(fn(submatch) {
      let assert Some(submatch) = submatch
      let assert Ok(submatch) = int.base_parse(submatch, 10)

      submatch
    })
  })
  |> list.map(fn(match) {
    let assert [item1, item2] = match

    item1 * item2
  })
  |> int.sum
}

fn part_two(input: List(String)) {
  let assert Ok(re_to_remove) = regexp.from_string("don\\'t\\(\\).*?do\\(\\)")
  let assert Ok(re_to_remove_from_end) = regexp.from_string("don\\'t\\(\\).*$")
  let assert Ok(re) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")

  regexp.replace(each: re_to_remove, in: string.join(input, ""), with: "")
  |> regexp.replace(each: re_to_remove_from_end, in: _, with: "")
  |> regexp.scan(with: re, content: _)
  |> list.map(fn(match) {
    match.submatches
    |> list.map(fn(submatch) {
      let assert Some(submatch) = submatch
      let assert Ok(submatch) = int.base_parse(submatch, 10)

      submatch
    })
  })
  |> list.map(fn(match) {
    let assert [item1, item2] = match

    item1 * item2
  })
  |> int.sum
}
