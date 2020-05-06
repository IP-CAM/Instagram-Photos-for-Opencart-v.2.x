<?php
/**
 * This file is part of the "Instagram photos" extension
 *
 * @copyright Copyright © 2018 reDream <mail@redream.ru>
 * @author Ivan Grigorev <ig@redream.ru>
 * @license GNU/GPLv3 http://www.gnu.org/licenses/gpl-3.0.html
 */
class ControllerExtensionModuleInstagramRdr extends Controller {

	/** @var string */
	public $imageDir = 'instagram';

	private $error = array();

	public function index() {
		$this->load->language('extension/module/instagram_rdr');
        $this->load->model('extension/module');
        $this->load->model('localisation/language');

		$this->document->setTitle($this->language->get('heading_title'));

        $token = $this->session->data['token'];
        $module_id = isset($this->request->get['module_id']) ? $this->request->get['module_id'] : null;
        $languages = $this->model_localisation_language->getLanguages();
        $data['languages'] = $languages;
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate($languages)) {
            if (isset($module_id)) {
                $this->model_extension_module->editModule($module_id, $this->request->post);
            } else {
                $this->model_extension_module->addModule('instagram_rdr', $this->request->post);
            }

            $this->session->data['success'] = $this->language->get('text_success');
            $this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
        }

        if (isset($module_id) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
            $module_info = $this->model_extension_module->getModule($module_id);
        } else {
            $module_info = array();
        }

        $lang = array(
            'button_cache',
            'button_clear',
            'button_save',
            'button_cancel',
            'entry_account_info',
            'entry_amount',
            'entry_column_width',
            'entry_height',
            'entry_name',
            'entry_status',
            'entry_title',
            'entry_token',
            'entry_view_mode',
            'entry_width',
            'entry_slideshow_autoplay',
            'entry_slideshow_center',
            'entry_slideshow_dots',
            'entry_slideshow_effect',
            'entry_slideshow_items',
            'entry_slideshow_loop',
            'entry_slideshow_margin',
            'entry_slideshow_mouse_drag',
            'entry_slideshow_nav',
            'entry_slideshow_options',
            'entry_slideshow_speed',
            'entry_slideshow_timeout',
            'entry_slideshow_touch_drag',
            'entry_slideshow_width',
            'heading_title',
            'mode_grid',
            'mode_slideshow',
            'text_copyright',
            'text_disabled',
            'text_edit',
            'text_enabled',
            'text_general',
            'text_no',
            'text_responsive',
            'text_view',
            'text_yes',
            'text_log',
            'text_lg',
            'text_lg',
            'text_md',
            'text_sm',
            'text_xs',
        );
        foreach ($lang as $l) {
            $data[$l] = $this->language->get($l);
        }

		$errors = array(
		    'warning',
		    'name',
		    'title',
            'token',
            'amount',
            'width',
            'height',
            'slideshow_items',
            'slideshow_margin',
            'slideshow_speed',
            'slideshow_timeout',
        );

        foreach ($errors as $name) {
            $data['errors'][$name] = isset($this->error[$name]) ? $this->error[$name] : '';
        }

		$data['breadcrumbs'] = array(
		    array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/dashboard', 'token=' . $token, true)
            ),
            array(
                'text' => $this->language->get('text_extension'),
                'href' => $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true)
            )
        );

        if (isset($module_id)) {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/instagram_rdr', 'token=' . $token . '&module_id=' . $module_id, true)
            );
            $data['action'] = $this->url->link('extension/module/instagram_rdr', 'token=' . $token . '&module_id=' . $module_id, true);
        } else {
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('heading_title'),
                'href' => $this->url->link('extension/module/instagram_rdr', 'token=' . $token, true)
            );
            $data['action'] = $this->url->link('extension/module/instagram_rdr', 'token=' . $token, true);
        }

		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true);
        $data['cache_btn'] = $this->url->link('extension/module/instagram_rdr/cache', 'token=' . $token, true);
		$data['log_btn'] = $this->url->link('extension/module/instagram_rdr/clearlog', 'token=' . $token, true);

		// Log
		$file = DIR_LOGS . 'instagram_rdr.log';

		if (file_exists($file)) {
			$data['log'] = htmlentities(file_get_contents($file, FILE_USE_INCLUDE_PATH, null));
		} else {
			$data['log'] = '';
		}

		$default = array(
		    'name' => $this->language->get('text_instagram'),
		    'status' => 1,
            'token' => '',
            'account_info' => 0,
            'amount' => 10,
            'width' => 400,
            'height' => 400,
            'view_mode' => 'slideshow',
            'grid_class_lg' => 'col-lg-3',
            'grid_class_md' => 'col-md-4',
            'grid_class_sm' => 'col-sm-6',
            'grid_class_xs' => 'col-xs-12',
            'slideshow_items' => 4,
            'slideshow_margin' => 15,
            'slideshow_speed' => 300,
            'slideshow_effect' => 'slide',
            'slideshow_loop' => 0,
            'slideshow_nav' => 0,
            'slideshow_dots' => 1,
            'slideshow_center' => 0,
            'slideshow_autoplay' => 0,
            'slideshow_timeout' => 5000,
            'slideshow_mouse_drag' => 1,
            'slideshow_touch_drag' => 1,
            'slideshow_responsive' => array()
        );

		foreach ($default as $name => $value) {
		    if(isset($this->request->post[$name])) {
		        $data[$name] = $this->request->post[$name];
            } elseif(isset($module_info[$name])) {
                $data[$name] = $module_info[$name];
            } else {
                $data[$name] = $value;
            }
        }

        foreach ($languages as $lang) {
            if(isset($this->request->post['title'][$lang['language_id']])) {
                $data['title'][$lang['language_id']] = $this->request->post['title'][$lang['language_id']];
            } elseif(isset($module_info['title'][$lang['language_id']])) {
                $data['title'][$lang['language_id']] = $module_info['title'][$lang['language_id']];
            } else {
                $data['title'][$lang['language_id']] = $this->language->get('text_instagram');
            }
        }

        $data['grid_class'] = array(
            'lg',
            'md',
            'sm',
            'xs'
        );

        foreach($data['grid_class'] as $val) {
            $data['columns'][$val] = array(
                'col-' . $val . '-12' => '1',
                'col-' . $val . '-11' => '11/12',
                'col-' . $val . '-10' => '5/6',
                'col-' . $val . '-9' => '3/4',
                'col-' . $val . '-8' => '2/3',
                'col-' . $val . '-7' => '7/12',
                'col-' . $val . '-6' => '1/2',
                'col-' . $val . '-5' => '5/12',
                'col-' . $val . '-4' => '1/3',
                'col-' . $val . '-3' => '1/4',
                'col-' . $val . '-2' => '1/6',
                'col-' . $val . '-1' => '1/12'
            );
        }

        $data['slideshow_effects'] = array(
            'slide' => 'Slide',
            'fade' => 'Fade',
            'cube' => 'Cube',
            'coverflow' => 'Coverflow',
            'flip' => 'Flip'
        );

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/module/instagram_rdr', $data));
	}

	public function clearlog() {
		$this->load->language('extension/module/instagram_rdr');

		$file = DIR_LOGS . 'instagram_rdr.log';
		if(file_exists($file)) {
			$handle = fopen($file, 'w+');
			fclose($handle);

			$this->session->data['success'] = $this->language->get('text_success');
		}
		$this->response->redirect($this->url->link('extension/module/instagram_rdr', 'token=' . $this->session->data['token'], true));
	}

	public function cache() {
        $this->load->language('extension/module/instagram_rdr');

        $this->cache->delete('instagram_rdr');
		$this->removeCacheDir(DIR_IMAGE . $this->imageDir . '/');

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode(array(
            'success' => $this->language->get('text_cache_cleared')
        )));
    }

	/**
	 * @param string $dir
	 */
	protected function removeCacheDir($dir) {
		if (!is_dir($dir)) {
			return;
		}
		if (!is_link($dir)) {
			if (!($handle = opendir($dir))) {
				return;
			}
			while (($file = readdir($handle)) !== false) {
				if ($file === '.' || $file === '..') {
					continue;
				}
				$path = $dir . DIRECTORY_SEPARATOR . $file;
				if (is_dir($path)) {
					$this->removeCacheDir($path);
				} else {
					unlink($path);
				}
			}
			closedir($handle);
		}
		if (is_link($dir)) {
			unlink($dir);
		} else {
			rmdir($dir);
		}
	}

    /**
     * @param array $languages
     * @return bool
     */
	protected function validate($languages) {
		if (!$this->user->hasPermission('modify', 'extension/module/instagram_rdr')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 64)) {
            $this->error['name'] = $this->language->get('error_name');
        }

        if (empty($this->request->post['token'])) {
            $this->error['token'] = $this->language->get('error_token');
        }

        if (empty($this->request->post['amount']) || !is_numeric($this->request->post['amount'])) {
            $this->error['amount'] = $this->language->get('error_number');
        }

        if (empty($this->request->post['width']) || !is_numeric($this->request->post['width'])) {
            $this->error['width'] = $this->language->get('error_number');
        }

        if (empty($this->request->post['height']) || !is_numeric($this->request->post['height'])) {
            $this->error['height'] = $this->language->get('error_number');
        }

        if (empty($this->request->post['slideshow_speed']) || !is_numeric($this->request->post['slideshow_speed'])) {
            $this->error['slideshow_speed'] = $this->language->get('error_number');
        }

        if (empty($this->request->post['slideshow_items']) || !is_numeric($this->request->post['slideshow_items'])) {
            $this->error['slideshow_items'] = $this->language->get('error_number');
        }

        if (!is_numeric($this->request->post['slideshow_margin'])) {
            $this->error['slideshow_margin'] = $this->language->get('error_number');
        }

        if (empty($this->request->post['slideshow_timeout']) || !is_numeric($this->request->post['slideshow_timeout'])) {
            $this->error['slideshow_timeout'] = $this->language->get('error_number');
        }

        foreach ($languages as $lang) {
            if (utf8_strlen($this->request->post['title'][$lang['language_id']]) > 64) {
                $this->error['title'] = $this->language->get('error_title');
            }
        }
		return !$this->error;
	}
}