#!/usr/bin/perl
# Missing numbers
# Challenge 4 Tuenti 2013
# Joaquín Ferrero, 2013.05.01
#
# Phase 1. Extract missing numbers from binary file
#

use v5.14; 
use utf8::all;

my $b = '';

open my $NUMBERS, '<', 'integers';
binmode $NUMBERS;
while (my $c = read $NUMBERS, my $cache, 134217728) {

    vec($b, $_, 1) = 1 for unpack "L*", $cache;
}
close $NUMBERS;

open my $RESULTADO, '>', 'integers.txt';
for my $i (0..2147483647) {

    if (not vec $b, $i, 1) {
	say $RESULTADO $i;
    }
}
close $RESULTADO;

__END__

