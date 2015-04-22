package My::ModuleBuild;

use strict;
use warnings;
use base qw( Alien::Base::ModuleBuild );
use File::chdir;
use Capture::Tiny qw( capture_stderr );
use File::Spec;

our $quiet = 0;

my $patch = $^O eq 'MSWin32' ? 'patch --binary' : 'patch';

sub new
{
  my($class, %args) = @_;
  
  $args{alien_name} = 'flex';
  $args{alien_stage_install} = 1;
  $args{alien_build_commands} = [
    "$patch -p1 < ../../flex-2_5_39.patch",
    '%c --prefix=%s --disable-shared',
    'make',
  ];
  $args{alien_install_commands} = [
    'make install',
  ];
  $args{alien_repository} = {
    protocol       => 'http',
    host           => 'sourceforge.net',
    location       => '/projects/flex/files/',
    exact_filename => 'flex-2.5.39.tar.gz',
  };

  if($ENV{ALIEN_FORCE} || do { local $quiet = 1; ! $class->alien_check_installed_version })
  {
    $args{alien_bin_requires} = { 'Alien::m4' => 0, 'Alien::patch' => 0.03 };
  }
  
  my $self = $class->SUPER::new(%args);
  
  $self;
}

sub _short ($)
{
  $_[0] =~ /\s+/ ? Win32::GetShortPathName( $_[0] ) : $_[0];
}

sub alien_check_installed_version
{
  my($self) = @_;

  my @paths = ([]);

  if($^O eq 'MSWin32')
  {
    eval '# line '. __LINE__ . ' "' . __FILE__ . "\n" . q{
      use strict;
      use warnings;
      use Win32API::Registry 0.21 qw( :ALL );
      
      my @uninstall_key_names = qw(
        software\wow6432node\microsoft\windows\currentversion\uninstall
        software\microsoft\windows\currentversion\uninstall
      );
      
      foreach my $uninstall_key_name (@uninstall_key_names)
      {
        my $uninstall_key;
        RegOpenKeyEx( HKEY_LOCAL_MACHINE, $uninstall_key_name, 0, KEY_READ, $uninstall_key ) || next;
        
        my $pos = 0;
        my($subkey, $class, $time) = ('','','');
        my($namSiz, $clsSiz) = (1024,1024);
        while(RegEnumKeyEx( $uninstall_key, $pos++, $subkey, $namSiz, [], $class, $clsSiz, $time))
        {
          next unless $subkey =~ /^flex/i;
          my $flex_key;
          RegOpenKeyEx( $uninstall_key, $subkey, 0, KEY_READ, $flex_key ) || next;
          
          my $data;
          if(RegQueryValueEx($flex_key, "InstallLocation", [], REG_SZ, $data, [] ))
          {
            push @paths, [File::Spec->catdir(_short $data, "bin")];
          }
          
          RegCloseKey( $flex_key );
        }
        RegCloseKey($uninstall_key);
      }
    };
    warn $@ if $@;
    
    push @paths, map { [_short $ENV{$_}, qw( GnuWin32 bin )] } grep { defined $ENV{$_} } qw[ ProgramFiles ProgramFiles(x86) ];
    push @paths, ['C:\\GnuWin32\\bin'];
    
  }

  unless($quiet)
  {
    print "try system paths:\n";
    print "  - ", $_, "\n" for map { $_ eq '' ? 'PATH' : $_ } map { File::Spec->catdir(@$_) } @paths;
  }
  
  foreach my $path (@paths)
  {
    my @stdout;
    my $exe = File::Spec->catfile(@$path, 'flex');
    my $stderr = capture_stderr {
      @stdout = `$exe --version`;
    };
    if(defined $stdout[0] && $stdout[0] =~ /^flex/ && $stdout[0] =~ /([0-9\.]+)$/)
    {
      $self->config_data( flex_system_path => File::Spec->catdir(@$path) ) if ref($self) && @$path;
      return $1;
    }
  }
  return;
}

sub alien_check_built_version
{
  $CWD[-1] =~ /^flex-(.*)$/ ? $1 : 'unknown';
}

1;
