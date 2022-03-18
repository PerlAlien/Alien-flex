# Alien::flex ![static](https://github.com/PerlAlien/Alien-flex/workflows/static/badge.svg) ![linux](https://github.com/PerlAlien/Alien-flex/workflows/linux/badge.svg)

Find or build flex

# SYNOPSIS

From a Perl script

```perl
use Alien::flex;
use Env qw( @PATH );
unshift @PATH, Alien::flex->bin_dir;  # flex is now in your path
```

In an [Alien::Build](https://metacpan.org/pod/Alien::Build) [alienfile](https://metacpan.org/pod/alienfile):

```perl
use alienfile;

share {
  ...
  requires 'Alien::flex';
  build [ '%{flex} ...' ];
  ...
};
```

From Build.PL / [Alien::Base::ModuleBuild](https://metacpan.org/pod/Alien::Base::ModuleBuild):

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

# SEE ALSO

- [Alien](https://metacpan.org/pod/Alien)
- [Alien::bison](https://metacpan.org/pod/Alien::bison)

# AUTHOR

Author: Graham Ollis <plicease@cpan.org>

Contributors:

Diab Jerius (DJERIUS)

# COPYRIGHT AND LICENSE

This software is copyright (c) 2014-2022 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
