# Alien::flex [![Build Status](https://secure.travis-ci.org/plicease/Alien-flex.png)](http://travis-ci.org/plicease/Alien-flex)

Find or build flex

# SYNOPSIS

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

# DESCRIPTION

This package can be used by other CPAN modules that require flex.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
