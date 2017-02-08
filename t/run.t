use strict;
use warnings;
use Test2::Bundle::Extended;
use Test::Alien;
use Alien::flex;

alien_ok 'Alien::flex';
my $run = run_ok(['flex', '--version'])
  ->exit_is(0);

$run->success ? $run->note : $run->diag;
  
done_testing;
