sub getLibraryPath {
    if (@ARGV == 0) {
	"data/iTunes Music Library.xml";
    } else {
	$ARGV[0];
    }
}
1;
