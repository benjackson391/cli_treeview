use Test::More;
use Test::Output;
use lib './';
use Tree;

my $TreeObject = Tree->new();
my @arr = $TreeObject->read_dir('/var');
isa_ok($TreeObject, 'Tree');
stdout_is sub { $TreeObject->say_modify_name('/path/to/file') }, "        file\n", "should print with indent";
local *Tree::deep_read = sub { return 'success' };
local *Tree::printer = sub { return $_[0] };
ok(Tree->new->tree('/path/to1') eq 'success', 'should call deep_read if path is correct');
ok(Tree->new->tree() ne 'success', 'should do nothing if path is incorrect');

done_testing();
