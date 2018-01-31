requires 'perl', '5.008005';

requires 'Cpanel::JSON::XS', '0';
requires 'File::Share', '0';
requires 'File::Slurper', '0';
requires 'Getopt::Long', '0';
requires 'MARC::Parser::RAW', '0';
requires 'MARC::Parser::XML', '0';
requires 'Scalar::Util', '0';

on test => sub {
    requires 'Test::More', '0.96';
};
