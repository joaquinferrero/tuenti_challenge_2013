#!/usr/bin/perl
# Lost in Lost
# Challenge 3 Tuenti 2013
# Joaquín Ferrero, 2013.04.30
#
# Ordenar las escenas de 'Lost'
#

use Modern::Perl '2012';
use utf8::all;

### Proceso ###############################################################
my $n_scripts = 0+ readline;

SCRIPT:
while ($n_scripts--) {
    my $scriptline = readline;
    chomp $scriptline;

    my(undef, @scenes) = split /([.<>])/, $scriptline;

    for(my $i = 0; $i < @scenes; $i += 2) {
    	$scenes[$i/2] = [ $scenes[$i], $scenes[$i+1] ];
    }

    $#scenes = @scenes / 2 -1;

    ## Simplificar '>'
    POST:
    for my $i ( reverse 0 .. $#scenes ) {

	if ($scenes[$i][0] eq '>') {
	    ## Buscamos escena buena anterior
	    for my $j ( reverse 0 .. $i ) {
		if ($scenes[$j][0] eq '.') {
		    splice @scenes, $j+1, 0, splice @scenes, $i, 1;
		    $scenes[$j+1][0] = '»';
		    next POST;
		}
	    }
	    ## No encontramos ninguno, fallo
	    say "invalid";
	    next SCRIPT;
	}
    }

    ## Simplificar '<'
    PREV:
    for my $i (0 .. $#scenes) {

	if ($scenes[$i][0] eq '<') {
	    ## Buscamos escena buena anterior
	    for my $j ( reverse 0 .. $i ) {
		if ($scenes[$j][0] eq '.') {
		    splice @scenes, $j, 0, splice @scenes, $i, 1;
		    $scenes[$j][0] = '«';
		    next PREV;
		}
	    }
	    ## No encontramos ninguno, fallo
	    say "invalid";
	    next SCRIPT;
	}
    }

    ## Simplificación de escenas no cronológicas idénticas, pero ordenadas
    for my $i (reverse 0 .. $#scenes) {
	if ($scenes[$i][0] eq '«') {
	    # Buscamos escena complementaria y la eliminamos

	    if ($i == 0) {
		next;
	    }
	    if ($scenes[$i-1][1] eq $scenes[$i][1]
		    and $scenes[$i-1][0] eq '»') {
		splice @scenes, $i-1, 1;
	    }

	}
    }

    ## Comprobación de la lógica: escenas únicas
    my %escena_vista;
    for my $i (0 .. $#scenes) {
	if ($escena_vista{$scenes[$i][1]}++) {
	    if ($scenes[$i][0] ne '«') {
		say "invalid";
		next SCRIPT;
	    }
	    else {
		say "valid";
		next SCRIPT;
	    }
	}
    }

    ## Comprobar los inicios y finales
    my $inicios = 0;
    for my $i (0 .. 1) {
	$inicios++ if $scenes[$i][0] eq '«';
    }
    my $finales = 0;
    for my $i (-2 .. -2) {
	$finales++ if $scenes[$i][0] eq '»';
    }

    if ($inicios == 2 or $finales > 0) {
	say "invalid";
	next SCRIPT;
    }

    say join ',' => map { $_->[1] } @scenes;
}

__END__
