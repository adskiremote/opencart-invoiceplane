<?php
//==============================================================================
// InvoicePlane Integration v0.1
// 
// Author: Adam Smith - Cortek Solutions
// E-mail: adam.smith@cortek-solutions.com
// Website: https://cortek-solutions.com
//
// Summary
// Sends and syncs Orders, Customers and Payments to InvoicePlane
// 
//==============================================================================

class ControllerExtensionModuleInvoiceplane extends Controller
{
    
    public function index()
    {
        $data = array();
        $data['ip_api_key'] = $this->config->get('ip_api_key');
        $data['ip_url'] = $this->config->get('ip_url');
        
        return $this->load->view('extension/module/invoiceplane', $data);
    }

    public function sendOrder($data)
    {
        $apiKey = $this->config->get('ip_api_key');
        $ipUrl = $this->config->get('ip_url');

        $response = array();

        $invoicePlane = new InvoicePlane($apikey, $ipUrl);
        $result = $invoicePlane->sendInvoice($data);

        if ($invoicePlane->success()) {
            return $response = [
                'success' => true,
                'result' =>  $result
            ];
        } else {
            return $response = [
                'success' => false,
                'result' => 'error'
            ];
        }
    }

    // One way only sync customers to InvoicePlane Clients
    // If customer exists - skip
    public function syncCustomers()
    {
        $invoicePlane = new InvoicePlane($apikey, $ipUrl);
        $result = $invoicePlane->syncCustomers();
        $this->log->write('Result:' . print_r($result, true));
    }

    // On successful payment - sends to InvoicePlane
    public function sendPayment($data)
    {
        $apiKey = $this->config->get('ip_api_key');
        $ipUrl = $this->config->get('ip_url');

        $response = array();
        $data = ['123', 'hello', 'adam'];

        $invoicePlane = new InvoicePlane($apikey, $ipUrl);
        $result = $invoicePlane->sendInvoice($data);
        
        $this->log->write('Result: ' . print_r($result, true));
    

        if ($invoicePlane->success()) {
            return $response = [
                'success' => true,
                'result' =>  $result
            ];
        } else {
            return $response = [
                'success' => false,
                'result' => 'error'
            ];
        }
    }
}
