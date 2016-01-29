use strict;
use warnings;
use Test::Stream -V1;
use Test::Alien;
use Alien::flex;

plan 4;

alien_ok 'Alien::flex';
my $run = run_ok(['flex', '--version'])
  ->exit_is(0);

$run->success ? $run->note : $run->diag;
  
