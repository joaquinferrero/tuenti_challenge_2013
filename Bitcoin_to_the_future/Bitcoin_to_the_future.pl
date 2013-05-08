#!/usr/bin/perl
# Bitcoin to the future
# Challenge 1 Tuenti 2013
# Joaquín Ferrero, 2013.04.29
#
# Dada una serie de cambios Bitcoins/euros, indicar la ganancia máxima al final del periodo
#
# La entrada es:
# * un número de test a realizar. Cada test:
#   + una cantidad de euros inicial
#   + una lista de números que indican la contización Bitcoins/euro, separados por espacios
#

use Modern::Perl '2012';
use List::Util qw(min max);

### Proceso ###############################################################
my $número_test = 0+ readline;

while ($número_test--) {

    my $budget         = 0+         readline;
    my @Bitcoins_rates = split " ", readline;

    if ($budget  and  @Bitcoins_rates > 1) {

	my($minimo, $maximo);
	my @rates;

	for (my $i = 0; $i < @Bitcoins_rates; $i++) {

	    my $valor = $Bitcoins_rates[$i];

	    if (not defined $minimo  or  $minimo > $valor) {
		$minimo = $valor;
		undef $maximo;
	    }
	    if (not defined $maximo  or  $maximo < $valor) {
		$maximo = $valor;

		if ($i == $#Bitcoins_rates  or  $Bitcoins_rates[$i+1] < $maximo ) {		# máximo local
		    next if $maximo == $minimo;
		    push @rates, [ $minimo, $maximo ];
		    undef $minimo;
		    undef $maximo;
		}
	    }
	}

	for (@rates) {
	    my($minimo, $maximo) = @$_;

	    my $resto = $budget % $minimo;

	    $budget   = ($budget-$resto) / $minimo * $maximo + $resto;
	}
    }

    say $budget;
}

__END__
