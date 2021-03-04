use strict;
use warnings;
use 5.010;

package Tree;

sub new {
  my $class = shift;
  my $self = {open_dir_symbol => shift || ''};
  bless $self, $class;
  return $self;
}

sub tree {
  my ($self, $path) = @_;

  return $self unless $path;
  $self->printer($path)
       ->deep_read($path);
}

sub deep_read {
  my ($self, $directory) = @_;

  my @files = $self->read_dir($directory);
  while (my $file = shift @files) {
    next if $file =~ /^(.+)[\.]{1,2}$/;
    $self->say_modify_name($file, -d $file);
    unshift @files, $self->read_dir($file) if -e $file && -d $file;
  }
}

sub say_modify_name {
  my ($self, $name) = @_;

  $name =~ /^(.+)\/((?:.(?!\/))+$)/;
  $self->printer(' ' x length($1) . $2);
  return $self;
}

sub read_dir {
  my ($self, $prev_path) = @_;

  opendir(my $handle, $prev_path);
  return map { "$prev_path/$_" } grep { $_ !~ /^(.+)?[\.]{1,2}$/ } sort readdir $handle;
}

sub printer {
  my ($self, $msg) = @_;
  say $msg . $self->{open_dir_symbol};
  return $self;
}

1;
