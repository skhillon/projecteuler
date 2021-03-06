#!/usr/bin/env perl

# PODNAME: 116.pl
# ABSTRACT: Red, green or blue tiles

## Author     : ian.sealy@sanger.ac.uk
## Maintainer : ian.sealy@sanger.ac.uk
## Created    : 2016-08-03

use warnings;
use strict;
use autodie;
use Getopt::Long;
use Pod::Usage;
use Carp;
use version; our $VERSION = qv('v0.1.0');

use Readonly;
use Memoize qw( memoize );

# Constants
Readonly our @BLOCK_SIZES => ( 2, 3, 4 );

# Default options
my $units = 50;    ## no critic (ProhibitMagicNumbers)
my ( $debug, $help, $man );

# Get and check command line options
get_and_check_options();

memoize('ways');

my $ways = 0;
foreach my $block_size (@BLOCK_SIZES) {
    $ways += ways( $units, $block_size ) - 1;
}

printf "%d\n", $ways;

# Count ways
sub ways {
    my ( $total_length, $block_size ) = @_;

    my $count = 1;    # All empty

    if ( $total_length < $block_size ) {
        return $count;
    }

    foreach my $start ( 0 .. $total_length - $block_size ) {
        $count += ways( $total_length - $start - $block_size, $block_size );
    }

    return $count;
}

# Get and check command line options
sub get_and_check_options {

    # Get options
    GetOptions(
        'units=i' => \$units,
        'debug'   => \$debug,
        'help'    => \$help,
        'man'     => \$man,
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

116.pl

Red, green or blue tiles

=head1 VERSION

version 0.1.0

=head1 DESCRIPTION

This script solves the Project Euler problem "Red, green or blue tiles". The
problem is: How many different ways can the black tiles in a row measuring fifty
units in length be replaced if colours cannot be mixed and at least one coloured
tile must be used?

=head1 EXAMPLES

    perl 116.pl

=head1 USAGE

    116.pl
        [--units INT]
        [--debug]
        [--help]
        [--man]

=head1 OPTIONS

=over 8

=item B<--units INT>

The length of the row.

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

This software is Copyright (c) 2016 by Genome Research Ltd.

This is free software, licensed under:

  The GNU General Public License, Version 3, June 2007

=cut
