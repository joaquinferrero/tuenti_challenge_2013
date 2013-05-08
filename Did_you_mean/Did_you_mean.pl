#!/usr/bin/perl
# Did you mean...?
# Challenge 2 Tuenti 2013
# Joaquín Ferrero, 2013.04.30
#
# Ofrecer alternativas a palabras, a partir de un diccionario
#

use Modern::Perl '2012';
use utf8::all;
use List::AllUtils 'uniq';

### Variables #############################################################
my %dictionary_word;
my $n_words;
my $line;

### Proceso ###############################################################
1 while defined($line = readline)  and  $line =~ m/^#/;			# not comment!

chomp $line;
open my $DICT, '<', $line;
while (my $word = <$DICT>) {
    chomp $word;
    my $word_sorted = join '' => sort split //, $word;
    push @{$dictionary_word{$word_sorted}}, $word;
}
close $DICT;

## Filter: unique words
while (my($word_sorted, $words_ref) = each %dictionary_word) {
    $dictionary_word{$word_sorted} = [ uniq sort @$words_ref ];
}

1 while defined($line = readline)  and $line =~ m/^#/;			# not comment!

$n_words = 0+ $line;

1 while defined($line = readline)  and $line =~ m/^#/;			# not comment!

my $word = $line;

while (1) {
    chomp $word;
    
    print "$word ->";
    
    my $word_sorted = join '' => sort split //, $word;
    
    if ($dictionary_word{$word_sorted}) {
	print join ' ' => '', grep { $_ ne $word } @{$dictionary_word{$word_sorted}};
    }
    
    print "\n";

    1 while defined($word = readline)  and $word =~ m/^#/;		# not comment!

    last if not --$n_words;
}

__END__
