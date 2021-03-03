#!/usr/bin/perl

use strict;
use warnings;
use DDP;
use lib './';
use Tree;
use 5.010;

my $directory = $ARGV[0] or die "usage: $0 <directory>";
my $with_hidden = $ARGV[1] ? '' : '$';
$directory =~ s/\/+$//;

Tree->new(':')->tree($directory);
