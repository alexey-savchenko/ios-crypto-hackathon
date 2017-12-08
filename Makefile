

update-dependencies:
	if [ -a Cartfile ] ; \
	then \
	    carthage update --cache-builds --no-use-binaries --platform iOS ; \
	fi;

install-dependencies:
	if [ -a Cartfile ] ; \
	then \
		carthage bootstrap --cache-builds --no-use-binaries --platform iOS ; \
	fi;	
