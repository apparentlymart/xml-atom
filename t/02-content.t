# $Id: 02-content.t,v 1.3 2004/05/08 18:33:46 btrott Exp $

use strict;

use Test;
use XML::Atom::Content;

BEGIN { plan tests => 22 };

my $content;

$content = XML::Atom::Content->new;
ok($content->elem);
$content->type('image/jpeg');
ok($content->type, 'image/jpeg');
$content->type('application/gzip');
ok($content->type, 'application/gzip');

$content = XML::Atom::Content->new('This is a test.');
ok($content->body);
ok($content->body, 'This is a test.');
ok($content->mode, 'xml');

$content = XML::Atom::Content->new(Body => 'This is a test.');
ok($content->body);
ok($content->body, 'This is a test.');
ok($content->mode, 'xml');

$content = XML::Atom::Content->new(Body => 'This is a test.', Type => 'foo/bar');
ok($content->body);
ok($content->body, 'This is a test.');
ok($content->mode, 'xml');
ok($content->type, 'foo/bar');

$content = XML::Atom::Content->new;
$content->body('This is a test.');
ok($content->body, 'This is a test.');
ok($content->mode, 'xml');
$content->type('foo/bar');
ok($content->type, 'foo/bar');

$content = XML::Atom::Content->new;
$content->body('<p>This is a test with XHTML.</p>');
ok($content->body, '<p>This is a test with XHTML.</p>');
ok($content->mode, 'xml');

$content = XML::Atom::Content->new;
$content->body('<p>This is a test with invalid XHTML.');
ok($content->body, '<p>This is a test with invalid XHTML.');
ok($content->mode, 'escaped');

$content = XML::Atom::Content->new;
$content->body("This is a test that should use base64\0.");
ok($content->mode, 'base64');
ok($content->body, "This is a test that should use base64\0.");