# NAME

MARC::Schema - Specification of the MARC21 format

[![Linux build status](https://github.com/jorol/MARC-Schema/actions/workflows/linux.yml/badge.svg)](https://github.com/jorol/MARC-Schema/actions/workflows/linux.yml)
[![Coverage Status](https://coveralls.io/repos/jorol/MARC-Schema/badge.png?branch=master)](https://coveralls.io/r/jorol/MARC-Schema?branch=master)
[![Kwalitee Score](http://cpants.cpanauthors.org/dist/MARC-Schema.png)](http://cpants.cpanauthors.org/dist/MARC-Schema)
[![CPAN version](https://badge.fury.io/pl/MARC-Schema.png)](http://badge.fury.io/pl/MARC-Schema)

# SYNOPSIS

    # in Perl
    use MARC::Schema;

    my $record = {
        _id    => 'fol05865967',
        record => [
            [ 'LDR', undef, undef, '_', '00661nam  22002538a 4500' ],
            [ '001', undef, undef, '_', 'fol05865967' ],
            [ '001', undef, undef, '_', 'field is not repeatable' ],
            [   '245', '1', '0', 'a', 'Programming Perl /',
                'c', 'Larry Wall, Tom Christiansen & Jon Orwant.',
                'a', 'subfield is not repeatable',
                'x', 'unknown subfield',
            ],
            [ '999', undef, undef, '_', 'not a standard field']
        ]
    };

    # load default schema
    my $schema = MARC::Schema->new();

    # load custom schema from file
    my $schema = MARC::Schema->new({ file => share/marc-schema.json });


    # load custom schema
    my $schema = MARC::Schema->new(
        {   fields => {
                '001' => { label => 'Control Number', repetable => 0 }
            }
        }
    );
    my @check = $schema->check($record);

    # via the command line
    $ marcvalidate t/camel.mrc
    $ marcvalidate --schema marc_schema.json t/camel.mrc
    $ marcvalidate --type XML marc.xml

# DESCRIPTION

MARC::Schema defines a set of MARC21 fields and subfields to validate Catmandu::MARC records. A schema is given as hash reference such as:

    {   fields => {
            LDR => {
                positions =>
                    [ { position => '00-04', label => 'Record length' } ],
                repeatable => 0,
            },
            '001' => { label => 'Control Number', repeatable => 0 }
        }
    }

For a more detailed description of the (default) schema see [MARC21 structure in JSON](https://pkiraly.github.io/2018/01/28/marc21-in-json/).

# METHODS

## check( $record \[, %options \] )

Check whether a given ["Catmandu::Importer::MARC"](https://metacpan.org/pod/Catmandu%3A%3AImporter%3A%3AMARC#EXAMPLE-ITEM) or ["MARC::Parser::\*"](https://metacpan.org/search?q=%22MARC%3A%3AParser%22) record confirms to the schema and return a list of detected violations. Possible options include:

- ignore\_unknown\_fields

    Don't report fields not included in the schema.

- ignore\_unknown\_subfields

    Don't report subfields not included in the schema.

Errors are given as list of hash references with keys `error`, `tag`, 
`type` and `value` of the violated field. `error` contains a 
human-readable error message for each violated field and/or subfield.

## check\_field( $field \[, %options \] )

Check whether a MARC21 field confirms to the schema. Use same options as method `check`.

# AUTHOR

Johann Rolschewski <jorol@cpan.org>

# CONTRIBUTORS

Patrick Hochstenbach &lt;patrick.hochstenbach@ugent.be&lt;gt>

# COPYRIGHT

Copyright 2018- Johann Rolschewski

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

[Catmandu::Validator](https://metacpan.org/pod/Catmandu%3A%3AValidator)

[JSON::Schema](https://metacpan.org/pod/JSON%3A%3ASchema)

[PICA::Schema](https://metacpan.org/pod/PICA%3A%3ASchema)

[MARC::Lint](https://metacpan.org/pod/MARC%3A%3ALint)

# ACKNOWLEDGEMENT

MARC::Schema uses the MARC21 schema developed by [Péter Király](https://github.com/pkiraly) as default. For more information see ["Metadata assessment for MARC records"](https://github.com/pkiraly/metadata-qa-marc) and ["MARC21 structure in JSON"](https://pkiraly.github.io/2018/01/28/marc21-in-json/).
