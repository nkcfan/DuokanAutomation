#!/usr/bin/env ruby

class Fib
  include Enumerable
  def each
    f1 = f2 = 1
    loop {
      yield f1
      f1, f2 = f2, f1 + f2
    }
  end
end

print_pair_format = lambda {|a,b,c| printf a, b, c}
print_pair = print_pair_format.curry.("[%d] %d\n")

fib = Fib.new
fib.lazy.take(10).each_with_index {|x, i| print_pair.(i, x) }
