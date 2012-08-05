package DDG::Goodie::IsValid::XML;
# ABSTRACT: Check whether the submitted data is valid XML.

use DDG::Goodie;

use Try::Tiny;
use XML::Simple;

attribution github  => ['https://github.com/AlexBio', 'AlexBio'  ],
            web     => ['http://ghedini.me', 'Alessandro Ghedini'];

zci answer_type => 'isvalid';
zci is_cached   => 1;

triggers any => 'xml';

handle remainder => sub {
	return unless $_ =~ /valid\s*(.*)$/;

	my $result = try {
		XMLin($1);
		return 'valid!';
	} catch {
		$_ =~ /^\n(.* at line \d+, column \d+, byte \d+) at/;

		if ($1) {
			my $css = "font-size:12px;display:inline;";
			return "invalid: <pre style=\"$css\">$1</pre>"
		} else {
			return "invalid"
		}
	};

	return "Your XML is $result"
};

1;
