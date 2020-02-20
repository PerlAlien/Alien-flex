# Alien::flex [![Build Status](https://secure.travis-ci.org/Perl5-Alien/Alien-flex.png)](http://travis-ci.org/Perl5-Alien/Alien-flex) ![macos-system](https://github.com/Perl5-Alien/Alien-flex/workflows/macos-system/badge.svg) ![macos-share](https://github.com/Perl5-Alien/Alien-flex/workflows/macos-share/badge.svg)

Find or build flex

# SYNOPSIS

From a Perl script

```perl
use Alien::flex;
use Env qw( @PATH );
unshift @PATH, Alien::flex->bin_dir;  # flex is now in your path
```

From Alien::Base Build.PL

```perl
use Alien:Base::ModuleBuild;
my $builder = Module::Build->new(
  ...
  alien_bin_requires => [ 'Alien::flex' ],
  ...
);
$builder->create_build_script;
```

# DESCRIPTION

This package can be used by other CPAN modules that require flex.

# HELPERS

## flex

```
%{flex}
```

Returns the name of the flex command.  Usually just `flex`.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
