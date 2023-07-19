<?php
// 监听捕获的错误级别
error_reporting(E_ALL);

// 是否开启错误信息回显 将错误输出至标准输出（浏览器/命令行）
ini_set('display_errors', true);

// 死否开启错误日志记录 将错误记录至 ini：error_log 指定文件
ini_set('log_errors', true);
ini_set('error_log', __DIR__ . './logs/php-errors.log');

echo '<h1 style="text-align: center;">Docker-Dnmp</h1>';
echo '<h2>Services</h2>';

echo '<ul>';
echo '<li>【PHP】 ', PHP_VERSION, '</li>';
echo '<li>【Nginx】 ', $_SERVER['SERVER_SOFTWARE'], '</li>';
echo '<li>【Mysql】',  getMysqlVersion(), '</li>';
echo '<li>【Redis】 ', getRedisVersion(), '</li>';
echo '<li>【MongoDB】', getMongoVersion(), '</li>';
echo '</ul>';

echo '<h2>PHP Extension Checklist </h2>';
printExtensions();


/**
 * 获取MySQL版本
 */
function getMysqlVersion()
{
    if (extension_loaded('PDO_MYSQL')) {
        try {
            $conn  = new PDO('mysql:host=mysql;dbname=mysql', 'root', '123456');
            $query = $conn->query('SELECT VERSION() as version');
            $info  = $query->fetch();
        } catch (Throwable $e) {
            return $e->getMessage();
        }
        return $info['version'];
    } else {
        return 'PDO_MYSQL Extension not installed ×';
    }
}

/**
 * 获取Redis版本
 */
function getRedisVersion()
{
    if (extension_loaded('redis')) {
        try {
            $redis = new Redis();
            $redis->connect('redis', 6379);
            $info = $redis->info();
            return $info['redis_version'];
        } catch (Throwable $e) {
            return $e->getMessage();
        }
    } else {
        return 'Redis Extension not installed ×';
    }
}

/**
 * 获取MongoDB版本
 */
function getMongoVersion()
{
    if (extension_loaded('mongodb')) {
        try {
            $manager = new MongoDB\Driver\Manager('mongodb://root:123456@mongodb:27017');
            $command = new MongoDB\Driver\Command(array('serverStatus'=>true));

            $cursor = $manager->executeCommand('admin', $command);

            return $cursor->toArray()[0]->version;
        } catch (Throwable $e) {
            return $e->getMessage();
        }
    } else {
        return 'MongoDB Extension not installed ×';
    }
}

/**
 * 获取已安装扩展列表
 */
function printExtensions()
{
    $all = get_loaded_extensions();
    asort($all);
    $list = 'bcmath,pdo_mysql,mysqli,opcache,sockets,pcntl,event,shmop,sysvmsg,sysvsem,sysvshm,gd,curl,mbstring,redis,mongodb,rdkafka,psr,yaf,yaml';
    $inArr = explode(',', $list);
    $noArr = [];

    $map = [
        'opcache' => 'Zend OPcache',
    ];
    foreach($inArr as $item) {
        if(!in_array($item, $all)) {
            
            if(isset($map[$item])) {
                if(!in_array($map[$item], $all)) {
                    $noArr[] = $item;
                }
            } else {
                $noArr[] = $item;
            }
        }
    }

    foreach ($all as $i => $name) {
        echo   $name, '=', phpversion($name) . "<br>";
    }

    foreach ($noArr as $i => $name) {
        echo   $name, ' Extension not installed x' . "<br>";
    }

}
