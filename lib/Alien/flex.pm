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

From Alien::Base Build.PL

 use Alien:Base::ModuleBuild;
 my $builder = Module::Build->new(
   ...
   alien_bin_requires => [ 'Alien::flex' ],
   ...
 );
 $builder->create_build_script;

=head1 DESCRIPTION

This package can be used by other CPAN modules that require flex.

=cut

sub bin_dir
{
  my($class) = @_;
  if($class->install_type('system'))
  {
    my $path = $class->config('flex_system_path');
    return ($path) if $path;
  }

  return $class->SUPER::bin_dir;
}

1;
