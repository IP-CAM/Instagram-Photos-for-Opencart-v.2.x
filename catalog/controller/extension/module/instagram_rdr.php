<?php
/**
 * This file is part of the "Instagram photos" extension
 *
 * @copyright Copyright © 2018 reDream <mail@redream.ru>
 * @author Ivan Grigorev <ig@redream.ru>
 * @license GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */
class ControllerExtensionModuleInstagramRdr extends Controller {

	public function index($setting) {
        static $module = 0;

        $this->load->language('extension/module/instagram_rdr');
		$this->load->model('tool/image');
		$this->load->model('extension/module/instagram_rdr');

        $this->document->addStyle('catalog/view/javascript/jquery/instagram-rdr/instagram.css');

        $data['text_follow'] = $this->language->get('text_follow');
        $data['text_posts'] = $this->language->get('text_posts');
        $data['text_followed'] = $this->language->get('text_followed');
        $data['text_follows'] = $this->language->get('text_follows');

        $photos = $this->model_extension_module_instagram_rdr->getPhotos($setting['token'], $setting['amount']);

		if(!empty($photos)) {
            $data['title'] = isset($setting['title'][$this->config->get('config_language_id')]) ? $setting['title'][$this->config->get('config_language_id')] : '';

            $width = intval($setting['width']);
            $height = intval($setting['height']);

		    $data['photos'] = array();
		    foreach ($photos as $photo) {
                $image = $this->model_tool_image->resize($photo['image'], $width, $height);
                $data['photos'][] = array(
                    'createdDate' => date($this->language->get('date_format_short'), strtotime($photo['createdTime'])),
                    'type' => $photo['type'],
                    'link' => $photo['link'],
                    'image' => $image,
                    'alt' => strip_tags($photo['caption']),
                    'imageUrl' => $photo['imageUrl'],
                    'caption' => nl2br($photo['caption']),
                    'likesCount' => intval($photo['likesCount']),
                    'commentsCount' => intval($photo['commentsCount'])
                );
            }

            $data['account'] = null;
            if($setting['account_info']) {
                $account = $this->model_extension_module_instagram_rdr->getAccount($setting['token']);
                if(!empty($account)) {
                    $image = $this->model_tool_image->resize($account['image'], 70, 70);
                    $data['account'] = array(
                        'username' => $account['username'],
                        'fullName' => $account['fullName'],
                        'link' => $account['url'],
                        'image' => $image,
                        'alt' => strip_tags($account['biography']),
                        'biography' => nl2br($account['biography']),
                        'followsCount' => intval($account['followsCount']),
                        'followedByCount' => intval($account['followedByCount']),
                        'mediaCount' => intval($account['mediaCount'])
                    );
                }
            }

            $data['module'] = $module++;

            if($setting['view_mode'] == 'slideshow') {
                $this->document->addStyle('catalog/view/javascript/jquery/instagram-rdr/swiper/css/swiper.min.css');
                $this->document->addScript('catalog/view/javascript/jquery/instagram-rdr/swiper/js/swiper.min.js');

                $data['plugin_id'] = $plugin_id = 'rdr-insta' . $data['module'];

                $data['pluginOptions'] = array(
                    'slidesPerView' => intval($setting['slideshow_items']),
                    'spaceBetween' => intval($setting['slideshow_margin']),
                    'speed' => intval($setting['slideshow_speed']),
                    'effect' => $setting['slideshow_effect'],
                    'loop' => (bool)$setting['slideshow_loop'],
                    'centeredSlides' => (bool)$setting['slideshow_center'],
                    'simulateTouch' => (bool)$setting['slideshow_mouse_drag'],
                    'allowTouchMove' => (bool)$setting['slideshow_touch_drag']
                );
                if($setting['slideshow_autoplay']) {
                    $data['pluginOptions']['autoplay'] = array(
                        'delay' => 5000
                    );
                }
                if($setting['slideshow_nav']) {
                    $data['pluginOptions']['navigation'] = array(
                        'nextEl' => '#' . $plugin_id . ' .swiper-button-next',
                        'prevEl' => '#' . $plugin_id . ' .swiper-button-prev'
                    );
                }
                if($setting['slideshow_dots']) {
                    $data['pluginOptions']['pagination'] = array(
                        'el' => '#' . $plugin_id . ' .swiper-pagination',
	                    'clickable' => true
                    );
                }
                if(!empty($setting['slideshow_responsive'])) {
                    foreach ($setting['slideshow_responsive'] as $breakpoint) {
                        $data['pluginOptions']['breakpoints'][intval($breakpoint['width'])] = array(
                            'slidesPerView' => intval($breakpoint['items']),
                            'spaceBetween' => intval($breakpoint['margin'])
                        );
                    }
                }
                return $this->load->view('extension/module/instagram_rdr_slideshow', $data);
            } else {
                $data['item_class'] = implode(' ', array($setting['grid_class_lg'], $setting['grid_class_md'], $setting['grid_class_sm'], $setting['grid_class_xs']));

                return $this->load->view('extension/module/instagram_rdr_grid.tpl', $data);
            }
        }
		return '';
	}
}