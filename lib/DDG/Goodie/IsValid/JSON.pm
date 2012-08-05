package DDG::Goodie::IsValid::JSON;
# ABSTRACT: Check whether the submitted data is valid JSON.

use DDG::Goodie;

use Try::Tiny;
use JSON qw(from_json);

attribution github  => ['https://github.com/AlexBio', 'AlexBio'  ],
            web     => ['http://ghedini.me', 'Alessandro Ghedini'];

zci answer_type => 'isvalid';
zci is_cached   => 1;

triggers any => 'json';

handle remainder => sub {
	return unless $_ =~ /valid\s*(.*)$/;

	my $result = try {
		from_json($1);
		return 'valid!';
	} catch {
		$_ =~ /^(.* at character offset \d+ .*) at/;

		if ($1) {
			my $css = "font-size:12px;display:inline;";
			return "invalid: <pre style=\"$css\">$1</pre>"
		} else {
			return "invalid"
		}
	};

	return "Your JSON is $result"
};

1;
