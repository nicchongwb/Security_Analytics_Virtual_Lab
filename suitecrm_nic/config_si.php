<?php

$sugar_config_si = array(
'setup_db_host_name' => 'localhost',
#'setup_db_sugarsales_user' => 'sugarcrm', //comment to use existing user
#'setup_db_sugarsales_password' => 'DB_USER_PASSWORD', //comment to use existing user
'setup_db_database_name' => 'suitecrm',
'setup_db_type' => 'mysql',
'setup_db_pop_demo_data' => false,
// create the database
'setup_db_create_database' => 0,
// create the user
'setup_db_create_sugarsales_user' => 0,
// if db user has to be created or is same as admin db user
'dbUSRData' => 'same', // create, provide
'setup_db_drop_tables' => 0,
'setup_db_username_is_privileged' => true,

'setup_db_admin_user_name' => 'Admin',
'setup_db_admin_password' => 'Admin',

'setup_site_url' => 'http://127.0.0.1/suitecrm',
'setup_site_admin_user_name'=>'Admin',
'setup_site_admin_password' => 'Admin',
'setup_license_key' => 'LICENSE_KEY',

'setup_site_sugarbeet_automatic_checks' => true,

'default_currency_iso4217' => 'USD',
'default_currency_name' => 'US Dollar',
'default_currency_significant_digits' => '2',
'default_currency_symbol' => '$',
'default_date_format' => 'Y-m-d',
'default_time_format' => 'H:i',
'default_decimal_seperator' => '.',
'default_export_charset' => 'ISO-8859-1',
'default_language' => 'en_us',
'default_locale_name_format' => 's f l',
'default_number_grouping_seperator' => ',',
'export_delimiter' => ',',

'setup_system_name' => 'SuiteCRM - Commercial Open Source CRM',
);

?>