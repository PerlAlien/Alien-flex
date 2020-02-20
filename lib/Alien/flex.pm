package Alien::flex;

use strict;
use warnings;
use base qw( Alien::Base );

# ABSTRACT: Find or build flex
# VERSION

=head1 SYNOPSIS

From a Perl script

 use Alien::flex;
 use Env qw( @PATH );
 unshift @PATH, Alien::flex->bin_dir;  # flex is now in your path

In an L<Alien::Build> L<alienfile>:

 use alienfile;
 
 share {
   ...
   requires 'Alien::flex';
   build [ '%{flex} ...' ];
   ...
 };

From Build.PL / L<Alien::Base::ModuleBuild>:

 use Alien:Base::ModuleBuild;
 my $builder = Module::Build->new(
   ...
   alien_bin_requires => [ 'Alien::flex' ],
   ...
 );
 $builder->create_build_script;

=head1 DESCRIPTION

This package can be used by other CPAN modules that require flex.

=head1 HELPERS

=head2 flex

 %{flex}

Returns the name of the flex command.  Usually just C<flex>.

=cut

sub alien_helper
{
  return {
    flex => sub { 'flex' },
  };
}

1;
