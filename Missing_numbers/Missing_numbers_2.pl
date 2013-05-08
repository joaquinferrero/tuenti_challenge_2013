#!/usr/bin/perl
# Missing numbers
# Challenge 4 Tuenti 2013
# Joaquín Ferrero, 2013.05.01
#
# Phase 2. Read results and play the contest
#

use v5.14; 
use utf8::all;

open my $NUMBERS, '<', 'integers.txt';
my @missing = <$NUMBERS>;
close $NUMBERS;
chomp @missing;

my $n_test = readline;

while ($n_test--) {

    my $pos = readline;

    say $missing[$pos-1];
}

__END__
