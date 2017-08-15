<?php
//==============================================================================
// InvoicePlane Integration v0.1
// 
// Author: Adam Smith - Cortek Solutions
// E-mail: adam.smith@cortek-solutions.com
// Website: https://cortek-solutions.com
// 
//==============================================================================

class Invoiceplane
{
    private $type = 'module';
    private $name = 'invoiceplane_integration';
    private $apiKey;
    private $apiUrl;
    
    public function __construct($apiKey, $apiUrl)
    {
        $this->apiKey = $apiKey;
        $this->apiUrl = $apiUrl;
    }

    public function sendInvoice($data)
    {
        $curl_request = 'GET';
        $curl_api = $this->apiKey;
        $curl_url = $this->apiUrl;
        $curl_data = [1,2,3,4,5];
        $response = $this->curlRequest($curl_request, $curl_api, $curl_url, $curl_data);
        return $response;
    }

    public function addProduct($data)
    {
        // $curl_api = $this->apiKey;
        // $curl_url = $this->apiUrl . '/api/products/products/';
        $fields = http_build_query($data);

        $curl = curl_init();

        curl_setopt_array($curl, array(
        // CURLOPT_PORT => "4111",
        CURLOPT_URL => $this->apiUrl . '/api/products/products/',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "PUT",
        CURLOPT_POSTFIELDS => $fields,
        CURLOPT_HTTPHEADER => array(
        "api-key: " . $this->apiKey,
        "content-type: application/x-www-form-urlencoded"
        ),
        ));

        $response = curl_exec($curl);
        $err = curl_error($curl);

        curl_close($curl);

        if ($err) {
                  return "cURL Error #:" . $err;
        } else {
                  return $response;
        }

        // $response = $this->curlRequest($curl_request, $curl_api, $curl_url, $curl_data);
        // return $response;
    }

    // cURL Request
    private function curlRequest($request, $api, $url, $data = array())
    {
        if ($request == 'GET') {
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_HTTPHEADER, array('api-key: ' . $api));
        } else {
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $url);
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($data));
            curl_setopt($curl, CURLOPT_HTTPHEADER, array('Content-Type: application/json', 'api-key: ' . $api));
            if ($request != 'POST') {
                curl_setopt($curl, CURLOPT_CUSTOMREQUEST, $request);
            }
            /*
			if ($request == 'PUT') {
				curl_setopt($curl, CURLOPT_CUSTOMREQUEST, $request);
				curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
			}
			*/
        }
        
        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 10);
        curl_setopt($curl, CURLOPT_FORBID_REUSE, true);
        curl_setopt($curl, CURLOPT_FRESH_CONNECT, true);
        curl_setopt($curl, CURLOPT_HEADER, false);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
        curl_setopt($curl, CURLOPT_TIMEOUT, 300);
        $response = json_decode(curl_exec($curl), true);
        return $response;
        
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
