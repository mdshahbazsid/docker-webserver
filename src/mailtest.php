<?php
try {
	mail("sendermail@local.com", "subject", "message:TEST PASSED", "From: frommail@local.com");
	echo "Mail Sended : SUCCESS";
} catch(\Exception $e) {
	echo "Mail Sended : ERROR | Exception : " . $e->getMessage(); 
}
