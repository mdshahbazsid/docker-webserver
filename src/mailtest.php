<?php
try {
	mail("sendermail@admin.com", "subject", "message:TEST PASSED", "From: localsystem@admin.com");
	echo "Mail Sended : SUCCESS";
} catch(\Exception $e) {
	echo "Mail Sended : ERROR | Exception : " . $e->getMessage(); 
}
