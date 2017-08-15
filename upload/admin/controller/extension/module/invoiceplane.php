<?php

class ControllerExtensionModuleInvoicePlane extends Controller {
	
	private $error 						= array();
	private $version 					= '0.0.1';
	private $extension 					= 'invoiceplane';
	private $type 						= 'module';
	private $db_table					= 'lp_invoiceplane';
	private $oc_extension				= '';
	
	public function index() { 
		 $this->load->language('extension/module/invoiceplane'); 
		 $this->load->model('setting/setting'); 

		//Set title from language file
		$this->document->setTitle($this->language->get('heading_title'));

		// $this->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		
		$data = array();
		
		//Save settings
		if (isset($this->request->post['invoiceplane_api_key'])) {
			 $data = $this->request->post;
			 $this->model_setting_setting->editSetting('invoiceplane', $this->request->post);
					
			$this->session->data['success'] = $this->language->get('text_success');
			$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'] . '&type=module', true));
		} else {
			 $data['invoiceplane_api_key'] = $this->config->get('invoiceplane_api_key');
			 $data['invoiceplane_url'] = $this->config->get('invoiceplane_url');
			 $data['invoiceplane_on_order'] = $this->config->get('invoiceplane_on_order');
			 $data['invoiceplane_product_family'] = $this->config->get('invoiceplane_product_family');
			// $this->log->write($data);
		}
		
		$text_strings = array(
				'heading_title',
				'button_save',
				'button_cancel',
				'button_add_module',
				'button_remove',
				'placeholder',
				'text_yes',
				'text_no',
				'text_loading'
		);
		
		foreach ($text_strings as $text) {
			$data[$text] = $this->language->get($text);
		}
		
		 // This Block returns the warning if any
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
     
        // This Block returns the error code if any
        if (isset($this->error['code'])) {
            $data['error_code'] = $this->error['code'];
        } else {
            $data['error_code'] = '';
        }     
		
  		$data['breadcrumbs'] = array();

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/invoiceplane', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$data['action'] = $this->url->link('extension/module/invoiceplane', 'token=' . $this->session->data['token'], 'SSL');
		
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');

		$data['session'] = $this->session->data['token'];

		// This block parses the status (enabled / disabled)
        if (isset($this->request->post['invoiceplane_status'])) {
            $data['invoiceplane_status'] = $this->request->post['invoiceplane_status'];
        } else {
            $data['invoiceplane_status'] = $this->config->get('invoiceplane_status');
        }

		// This block parses InvoicePlane APIKEY
        if (isset($this->request->post['invoiceplane_api_key'])) {
            $data['invoiceplane_api_key'] = $this->request->post['invoiceplane_api_key'];
        } else {
            $data['invoiceplane_api_key'] = $this->config->get('invoiceplane_api_key');
        }

		// This block parses InvoicePlane server url
        if (isset($this->request->post['invoiceplane_url'])) {
            $data['invoiceplane_url'] = $this->request->post['invoiceplane_url'];
        } else {
            $data['invoiceplane_url'] = $this->config->get('invoiceplane_url');
        }

		// This block parses InvoicePlane OnOrder disable | enable
        if (isset($this->request->post['invoiceplane_on_order'])) {
            $data['invoiceplane_on_order'] = $this->request->post['invoiceplane_on_order'];
        } else {
            $data['invoiceplane_on_order'] = $this->config->get('invoiceplane_on_order');
        }

		// This block parses InvoicePlane Product Family
        if (isset($this->request->post['invoiceplane_product_family'])) {
            $data['invoiceplane_product_family'] = $this->request->post['invoiceplane_product_family'];
        } else {
            $data['invoiceplane_product_family'] = $this->config->get('invoiceplane_product_family');
        }

		

		//Prepare for display
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		//Send the output
		$this->response->setOutput($this->load->view('extension/module/invoiceplane.tpl', $data));
	}

    public function uninstall() {
   	$this->load->model('setting/setting');
	$this->model_setting_setting->deleteSetting('invoiceplane');
   }

   public function syncproducts() {
		$this->load->model('catalog/product');
		$filter_data = array('limit' => 10);
		$results = $this->model_catalog_product->getProducts($filter_data);
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($results));

   }

	private function validate() {
		if (!$this->user->hasPermission('modify', 'extension/module/invoiceplane')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return TRUE;
		} else {
			return FALSE;
		}	
	}

}
?>
