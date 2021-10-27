#!/usr/local/bin/perl -w
use Net::SMTP;

$servername="172.16.15.151";

$smtp=Net::SMTP->new($servername);
die "cant connect" unless $smtp;

my $mailfrom="bcarpena\@fcpp.fujitsu.com";
my $mailto="bcarpena\@fcpp.fujitsu.com";

$smtp->mail($mailfrom);
$smtp->to($mailto);

$smtp->data();
$smtp->datasend("Subject:test\n");
$smtp->datasend("\n");
$smtp->datasend("hello");
$smtp->dataend();
$smtp->quit();
