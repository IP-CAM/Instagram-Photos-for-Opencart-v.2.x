<?php
/**
 * This file is part of the "Instagram photos" extension
 *
 * @copyright Copyright © 2018 reDream <mail@redream.ru>
 * @author Ivan Grigorev <ig@redream.ru>
 * @license GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */
class ModelExtensionModuleInstagramRdr extends Model {

    /** @var string */
    public $server = 'https://api.instagram.com/v1/';

    /** @var string */
    public $imageDir = 'instagram';

    /** @var Log */
    private $_log;

    /** @inheritdoc */
    public function __construct($registry) {
        parent::__construct($registry);
        $this->_log = new Log('instagram_rdr.log');

        if(!is_dir($dir = DIR_IMAGE . $this->imageDir)) {
            mkdir($dir, 0755);
        }
    }

    /**
     * @param string $token
     * @return mixed
     */
    public function getAccount($token) {
        $key = md5($token) . '.account';
        return $this->getOrSetCache($key, function() use ($token) {
        	$response = $this->request('users/self', array(
		        'access_token' => $token
	        ));

            $data = array();
            if($response['data']) {
                $data = array(
                    'id'                => $response['data']['id'],
                    'username'          => $response['data']['username'],
                    'fullName'          => $response['data']['full_name'],
                    'image'             => $this->downloadImage($response['data']['profile_picture']),
                    'biography'         => $response['data']['bio'],
                    'website'           => $response['data']['website'],
                    'url'               => 'https://www.instagram.com/' . $response['data']['username'] . '/',
                    'followsCount'      => $response['data']['counts']['follows'],
                    'followedByCount'   => $response['data']['counts']['followed_by'],
                    'mediaCount'        => $response['data']['counts']['media']
                );
            }
            return $data;
        });
    }

    /**
     * @param string $token
     * @param int $limit
     * @return array
     */
    public function getPhotos($token, $limit) {
	    $key = md5($token) . '.photos.' . $limit;
        return $this->getOrSetCache($key, function() use($token, $limit) {
	        return $this->photoRequest('users/self/media/recent', array(
		        'access_token' => $token,
		        'count' => $limit
	        ));
        });
	}

	/**
	 * @param string $url
	 * @param array $params
	 * @param array $photos
	 * @return array
	 */
	protected function photoRequest($url, $params, $photos = array()) {
		$response = $this->request($url, $params);
		if(!empty($response['data'])) {
			foreach ($response['data'] as $media) {
				$photos[] = array(
					'id' => $media['id'],
					'createdTime' => $media['created_time'],
					'type' => $media['type'],
					'link' => $media['link'],
					'image' => $this->downloadImage($media['images']['standard_resolution']['url']),
					'imageUrl' => $media['images']['standard_resolution']['url'],
					'caption' => isset($media['caption']['text']) ? $media['caption']['text'] : '',
					'likesCount' => isset($media['likes']['count']) ? $media['likes']['count'] : 0,
					'commentsCount' => isset($media['comments']['count']) ? $media['comments']['count'] : 0
				);
			}
		}
		if(isset($params['count'])) {
			$count = (int)$params['count'];
			if(count($photos) < $count && !empty($response['pagination']['next_max_id'])) {
				$params['max_id'] = $response['pagination']['next_max_id'];
				$photos = $this->photoRequest($url, $params, $photos);
			}
			$photos = array_splice($photos, 0, $count);
		}
		return $photos;
	}

	/**
	 * @param string $url
	 * @param array $params
	 * @return mixed
	 */
	protected function request($url, $params = array()) {
		$url = $this->server . $url . (!empty($params) ? '?' . http_build_query($params) : '');

		$crl = curl_init($url);
		curl_setopt($crl, CURLOPT_HTTPHEADER, array(
			'Accept: application/json'
		));
		curl_setopt($crl, CURLOPT_CONNECTTIMEOUT, 15);
		curl_setopt($crl, CURLOPT_RETURNTRANSFER, true);

		$response = curl_exec($crl);
		if ($response === false) {
			$this->_log->write(curl_error($crl));
		} else {
			$response = json_decode($response, true);
		}

		if(isset($response['meta']['error_type'], $response['meta']['error_message'])) {
			$this->_log->write($response['meta']['error_type'] . ': ' . $response['meta']['error_message']);
		}
		return $response;
	}

    /**
     * @param string $url
     * @return string
     */
	protected function downloadImage($url) {
        $dir = DIR_IMAGE . $this->imageDir;
		preg_match('/^[^?]+\.([a-zA-Z]{1,4})(?:\?.*)?$/', $url, $matches);
		$filename = md5($url) . '.' . (isset($matches[1]) ? $matches[1] : 'jpg');
        if(file_exists($dir . '/' . $filename) || copy($url,$dir . '/' . $filename)){
            return $this->imageDir . '/' . $filename;
        }
        return 'no_image.png';
    }

    /**
     * @param mixed $key
     * @param callable|\Closure $callable
     * @return mixed
     */
    private function getOrSetCache($key, $callable) {
        $key = 'instagram_rdr.' . $key;
        $value = $this->cache->get($key);
        if(!empty($value)) {
            return $value;
        }

        $value = call_user_func($callable, $this);
        $this->cache->set($key, $value);
        return $value;
    }
}
?>