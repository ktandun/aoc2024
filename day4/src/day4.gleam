import gleam/int
import gleam/io
import gleam/list
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
  let assert Ok(xmas_re) = regexp.from_string("XMAS")

  let separator = ""

  let vert_input = input
  let horiz_input =
    utils.get_input_vertically(input, separator)
    |> list.map(string.join(_, separator))
  let diag_tl_br_input =
    utils.get_input_diagonally_tl_to_br(input, separator)
    |> list.map(string.join(_, separator))
  let diag_bl_tr_input =
    utils.get_input_diagonally_bl_to_tr(input, separator)
    |> list.map(string.join(_, separator))

  list.flatten([vert_input, horiz_input, diag_bl_tr_input, diag_tl_br_input])
  |> list.map(fn(line) {
    let xmas_matches =
      line
      |> regexp.scan(with: xmas_re, content: _)
      |> list.length

    let samx_matches =
      line
      |> string.reverse
      |> regexp.scan(with: xmas_re, content: _)
      |> list.length

    xmas_matches + samx_matches
  })
  |> int.sum
}

fn part_two(input: List(String)) {
  "todo"
}
