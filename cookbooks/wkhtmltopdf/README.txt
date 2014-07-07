The version of wkhtmltopdf installed on EngineYard servers doesn't correctly
build PDFs. This is due to a problem with EngineYard/Gentoo packages.

EngineYard have recommended we build a custom chef recipe to install the
binary version from http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2

For reliability/performance reasons I'm including wkhtmltopdf in the
repository, so that if the googlecode url above is not accessible, we will
still be able to install the software.


Creation process:

* mkdir -p cookbooks/wkhtmltopdf/files/default cookbooks/wkhtmltopdf/recipes
* cd cookbooks/wkhtmltopdf/files/default
* curl http://wkhtmltopdf.googlecode.com/files/wkhtmltopdf-0.10.0_rc2-static-amd64.tar.bz2 | tar jxvf -
