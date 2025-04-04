//%attributes = {"invisible":true}
var $folder : 4D:C1709.Folder
$folder:=Folder:C1567("/SOURCES/")

var $scc : cs:C1710.scc
$data:=cs:C1710.scc.new($folder).count().data

ALERT:C41(JSON Stringify:C1217($data; *))