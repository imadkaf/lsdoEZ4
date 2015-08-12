<?php

// Operator autoloading

$eZTemplateOperatorArray = array();

$eZTemplateOperatorArray[] =
  array( 'script' => 'extension/ayaline/autoloads/ayalineutils.php',
         'class' => 'ayalineUtils',
         'operator_names' => array( 'ezxmltext_truncate', 'extract_email_contact', 'str_replace', 'server', 'name_for_menu', 'generation_code_video', 'save_variable_in_session', 'getFeedRSS', 'get_thematiques_array', 'clean_relation_list', 'show_captcha', 'evalphpcode', 'destroy_session' ) );

?>