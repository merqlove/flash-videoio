VERSION:=3.2
MXMLC45:=/Volumes/Data\ HD/SDK/Flex/flex_sdk_4.15.0_11.0/bin/mxmlc -define=CONFIG::version,${VERSION}



all:
	echo "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<custom:VideoIO xmlns:custom=\"*\" xmlns:fx=\"http://ns.adobe.com/mxml/2009\" xmlns:s=\"library://ns.adobe.com/flex/spark\" xmlns:mx=\"library://ns.adobe.com/flex/mx\" />\n" > src/Wrapper.mxml
	${MXMLC45} -output bin-debug/VideoIO11.swf   -compiler.debug=true  -define=CONFIG::sdk4,true  -define=CONFIG::player11,true  -target-player 11.0   -swf-version=13 -static-link-runtime-shared-libraries=true -- src/Wrapper.mxml
	${MXMLC45} -output bin-release/VideoIO11.swf -compiler.debug=false -define=CONFIG::sdk4,true  -define=CONFIG::player11,true  -target-player 11.0   -swf-version=13 -static-link-runtime-shared-libraries=true -- src/Wrapper.mxml
	cp bin-release/VideoIO11.swf bin-release/VideoIO11-${VERSION}.swf
	cd bin-release; zip VideoIO-${VERSION}.zip VideoIO11.swf

clean:
	rm -f bin-debug/VideoIO.swf  bin-debug/VideoIO11.swf  bin-release/VideoIO11.swf

dist:
	tar -zcvf flash-videoio.tgz Makefile bin-release/AC_OETags.js VideoIO.as src/VideoIO.as src/stageroom/JSAdapter.as
