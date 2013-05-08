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
use utf8::all;
use List::Util qw(min max);

### Proceso ###############################################################
my $número_test = 0+ readline;

while ($número_test--) {

    my $budget         = 0+         readline;
    my @Bitcoins_rates = split " ", readline;

    if ($budget  and  @Bitcoins_rates > 1) {

	my($mínimo, $máximo);
	my @rates;

	for (my $i = 0; $i < @Bitcoins_rates; $i++) {

	    my $valor = $Bitcoins_rates[$i];

	    if (not defined $mínimo  or  $mínimo > $valor) {
		$mínimo = $valor;
		undef $máximo;
	    }
	    if (not defined $máximo  or  $máximo < $valor) {
		$máximo = $valor;

		if ($i == $#Bitcoins_rates  or  $Bitcoins_rates[$i+1] < $máximo ) {
		    next if $máximo == $mínimo;
		    push @rates, [ $mínimo, $máximo ];		# encontrado un máximo local
		    undef $mínimo;
		    undef $máximo;
		}
	    }
	}

	for (@rates) {
	    my($mínimo, $máximo) = @$_;

	    my $resto = $budget % $mínimo;			# solo podemos hacer cambios con enteros

	    $budget   = ($budget-$resto) / $mínimo * $máximo + $resto;
	}
    }

    say $budget;
}

__END__
