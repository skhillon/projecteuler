#!/usr/bin/env perl

# PODNAME: 44.pl
# ABSTRACT: Pentagon numbers

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2015-06-15

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

# Default options
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

my %is_pentagonal = ( 1 => 1 );
my @pentagons = (1);
my $diff;
my $n = 1;
while ( !defined $diff ) {
    $n++;
    my $next = $n * ( 3 * $n - 1 ) / 2;    ## no critic (ProhibitMagicNumbers)
    foreach my $pentagon (@pentagons) {
        my $candidate = $next - $pentagon;
        if (   $is_pentagonal{$candidate}
            && $is_pentagonal{ abs $pentagon - $candidate } )
        {
            $diff = abs $pentagon - $candidate;
        }
    }
    unshift @pentagons, $next;
    $is_pentagonal{$next} = 1;
}

printf "%d\n", $diff;

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'debug' => \$debug,
        'help'  => \$help,
        'man'   => \$man,
    ) or pod2usage(2);

    # Documentation
    if ($help) {
        pod2usage(1);
    }
    elsif ($man) {
        pod2usage( -verbose => 2 );
    }

    return;
}

__END__
=pod

=encoding UTF-8

=head1 NAME

44.pl

Pentagon numbers

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Pentagon numbers". The problem is:
Find the pair of pentagonal numbers, Pj and Pk, for which their sum and
difference are pentagonal and D = |Pk − Pj| is minimised; what is the value of
D?

=head1 EXAMPLES

    perl 44.pl

=head1 USAGE

    44.pl
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--debug>

Print debugging information.

=item B<--help>

Print a brief help message and exit.

=item B<--man>

Print this script's manual page and exit.

=back

=head1 DEPENDENCIES

None

=head1 AUTHOR

=over 4

=item *

Ian Sealy <ian.sealy@sanger.ac.uk>

=back

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
