#!/usr/bin/env ruby

add = -> x, y { x + y }    # TODO: find similar pattern like proc(&:+).curry
add3 = add.curry[3]

compose = -> f, g { -> *x { g.(f.(*x)) } }
twice = -> f { compose.(f, f) }

main1 = -> { puts compose.(add3, add3).(100) }
main1.call

main2 = -> { puts compose.curry.(add3).(add3).(200)}
main2.call

main3 = -> { puts twice.(add3).(300)}
main3.call
