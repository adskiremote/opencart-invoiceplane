<?php
//==============================================================================
// InvoicePlane Integration v0.1
// 
// Author: Adam Smith - Cortek Solutions
// E-mail: adam.smith@cortek-solutions.com
// Website: https://cortek-solutions.com
// 
//==============================================================================

class Invoiceplane {
	private $type = 'module';
	private $name = 'invoiceplane_integration';
	private $settings;
	
	public function __construct() {
		// $this->config = $config;
		// $this->db = $db;
		// $this->log = $log;
		// $this->session = $session;
		// $this->url = $url;
	}

    public function sendInvoice($data) {
        $curl_request = 'GET';
        $curl_api = '123';
        $curl_url = 'http://localhost:4111/api/quotes/quotes/';
        $curl_data = [1,2,3,4,5];
        $response = $this->curlRequest($curl_request, $curl_api, $curl_url, $curl_data);
        return $response;
    }

	public function syncContacts() {

	}



    // cURL Request
    private function curlRequest($request, $api, $url, $data = array()) {
		//$apikey = $this->config->get($this->name . '_apikey');
		//$data_center = explode('-', $apikey);
		
		if ($request == 'GET') {
			// $curl = curl_init($url . $api . '?' . http_build_query($data));
            $curl = curl_init('http://localhost:4111/api/quotes/quotes/'); // Testing
		} else {
			$curl = curl_init($url . $api);
			curl_setopt($curl, CURLOPT_POST, true);
			curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
			curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-type: application/json'));
			if ($request != 'POST') {
				curl_setopt($curl, CURLOPT_CUSTOMREQUEST, $request);
			}
		}
		
		curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 10);
		curl_setopt($curl, CURLOPT_FORBID_REUSE, true);
		curl_setopt($curl, CURLOPT_FRESH_CONNECT, true);
		curl_setopt($curl, CURLOPT_HEADER, false);
		curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
		curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
		curl_setopt($curl, CURLOPT_TIMEOUT, 300);
		// curl_setopt($curl, CURLOPT_USERPWD, ' :' . $this->config->get($this->name . '_apikey'));
		$response = json_decode(curl_exec($curl), true);
		
		
		// if ($this->config->get($this->name . '_testing_mode') == 'debug') {
		//	$this->log->write($request . ' ' . $url . $api);
		//	$this->log->write('Data Sent: ' . print_r($data, true));
		
		// }
		
		
		if (curl_error($curl)) {
			$response['error'] = 'CURL ERROR #' . curl_errno($curl) . ' - ' . curl_error($curl);
		} elseif (empty($response) && $request != 'DELETE') {
			$response['error'] = 'Empty CURL gateway response';
		} elseif (!empty($response['detail'])) {
			$response['error'] = $response['detail'];
			if (isset($response['errors'])) {
				foreach ($response['errors'] as $error) {
					$response['error'] .= ' '. $error['message'];
				}
			}
		}
		curl_close($curl);
		
		if (!empty($response['error']) && $this->config->get($this->name . '_testing_mode')) {
			$this->log->write(strtoupper($this->name) . ' ERROR: ' . $response['error']);
		}
		return $response;
	}
	
}