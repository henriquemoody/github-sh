#!/usr/bin/env php
<?php
if (PHP_SAPI !== 'cli')
{
    die("It's a CLI application");
}
function createOptionDialog($menu, $options = array())
{
	$optionsString = "";
	foreach($options as $value=>$label)
	{
		$value = $value;
		$label = "'{$label}'";
		$optionsString .= " {$value} {$label}";
	}
    $CMD = "echo $( dialog --stdout --menu '{$menu}:' 0 0 0   {$optionsString} );\n";
    exec($CMD,$return);
    return $return[0];
}

function createTextDialog($menu)
{
    $CMD = "echo $( dialog --stdout --inputbox '{$menu}:' 0 0 );\n";
    exec($CMD,$return);
    return $return[0];
}

function createMessageDialog($menu, $message)
{
	$message = str_replace(array('<br />','\n',"\n"),' ',nl2br($message));
    $CMD = " dialog --title '{$menu}' --msgbox '{$message}' 20 60 ";
    exec($CMD,$return);
    return $CMD;
}

$tmpConf = sys_get_temp_dir().'/gitphp.ini';
if (!file_exists($tmpConf)) {
    $return = array();
    $return['Username'] = createTextDialog('Type your username');
    $return['Password'] = createTextDialog('Type your password');
    $return = base64_encode(json_encode($return));
    file_put_contents($tmpConf, "[user]\nuserdata = \"{$return}\"");
}
$userData = parse_ini_file($tmpConf);
$userData = json_decode((base64_decode($userData['userdata'])));

define('USER_NAME', $userData->Username);

function menu()
{
	switch(createOptionDialog("What do you want to do?", array('list repositories',
																'list organizations',
																))){
		case '0':
			$response = listRepos();
		break;
		case '1':
			$response = listOrgs();
		break;
	}
	return $response;
}

menuChecker(menu());

function menuChecker($menu)
{
	if ($menu == "") {
		menuChecker(menu());
	} else {
		$type = array_keys($menu);
		$type = $type[0];
		$repos = $menu;
		if ($type == 'orgs') {
			$return = listRepos($type, $menu[$type]);
			if (isset($return[0]) && $return[0] == "") {
				menuChecker("");
			} else {
				$repos = $return;
			}
		} else {
			if (isset($menu[0]) && $menu[0] == "") {
				menuChecker("");
			}
		}
		var_dump(listRepo($repos[$type], $repos[0]));
	}
}
function listRepos($type='users', $userName = USER_NAME)
{
	$resource = json_decode(file_get_contents("https://api.github.com/{$type}/{$userName}/repos"));
	$repositories = array();
	foreach($resource as $repository)
	{
		$repositories[$repository->name] = $repository->full_name;
	}
	$menu = array($type=>$userName,createOptionDialog("Select your repository", $repositories));
	return $menu;
}

function listRepo($userName = USER_NAME, $repo)
{
	$resource = json_decode(file_get_contents("https://api.github.com/repos/{$userName}/{$repo}"));

	return repoOptions($userName, $repo, $resource);
}

function repoOptions($userName, $repo, $informations)
{
	$options = array('repoIssues'=>'List issues',
					 'repoClone'=>'Clone Repo');
	// var_dump($informations);exit;
	$option = array('repo'=>"{$userName}/{$repo}", createOptionDialog("Select an option",$options));
	switch ($option[0]) {
		case 'repoClone':
			$directory = createTextDialog('Type the path where project will be cloned');
			exec("git clone {$informations->git_url} {$directory}");
			echo "Clonning....";
			sleep(6);
			menu();
			break;
		
		default:
			$issuesObject = json_decode(file_get_contents($informations->url.'/issues'));
			$issues = array();
			foreach($issuesObject as $id=>$content){
				$issues[++$id] = "{$content->title} - {$content->body}";
			}
			$issue = createOptionDialog('Issues', $issues);
			// $issueObject = json_decode(file_get_contents($informations->url.'/issues/'.$issue));
			// $a = createMessageDialog("Issue posted by {$issueObject->user->login}", "{$issueObject->body}");
			// die($a);
			menu();
			break;
	}
	return $menu;
}

function listOrgs()
{
	$resource = json_decode(file_get_contents("https://api.github.com/users/".USER_NAME."/orgs"));
	$repositories = array();
	foreach($resource as $repository)
	{
		$repositories["{$repository->login}"] = $repository->login;
	}
	$menu = array('orgs'=>createOptionDialog("Select your organization", $repositories));
	return $menu;
}