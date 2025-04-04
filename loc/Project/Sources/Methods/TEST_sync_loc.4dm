//%attributes = {"invisible":true}
var $folder : 4D:C1709.Folder
$folder:=Folder:C1567("/SOURCES/")

var $loc : cs:C1710.loc
$data:=cs:C1710.loc.new($folder).count().data

ALERT:C41([JSON Stringify:C1217($data; *); "-"*36; $data.sum("count")].join("\r"))