<?php
$file = "./warez/domains";

$fp = fopen($file. "t", 'w');

$handle = fopen($file, "r");
if ($handle) {
    while (($line = fgets($handle)) !== false) {
	$isDNS = false;

	if(preg_match("/[a-zA-Z]/",$line))
		{
		$isDNS = true;
		
		if(substr($line,0,1) != ".")
			{$line = "." .$line; }
		}
	
	
	
	echo str_replace("\n","<br/>",$line);
        fwrite($fp,$line);

    }
} else {
    // error opening the file.
} 

fclose($fp);
fclose($handle);

unlink($file);
copy($file. "t",$file);
unlink($file. "t");

	//echo "<br />Done...";

?>
