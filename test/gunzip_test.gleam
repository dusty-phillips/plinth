import gleam/bit_array
import gleam/javascript/promise
import gleeunit/should
import plinth/javascript/compression_stream.{compress}
import plinth/javascript/decompression_stream.{decompress}

pub fn gzip_round_trip_test() {
  use compressed <- promise.await(compress(hello(), "gzip"))
  compressed
  |> should.not_equal(hello())
  use decompressed <- promise.await(decompress(compressed, "gzip"))
  decompressed
  |> should.equal(hello())

  promise.resolve(Ok(Nil))
}

fn hello() {
  bit_array.from_string("Hello")
}
