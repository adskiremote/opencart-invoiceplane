<?php

class ControllerExtensionModuleInvoiceplane extends Controller
{
    
    public function index()
    {
        $data = array();
        $data['ip_api_key'] = $this->config->get('ip_api_key');
        $data['ip_url'] = $this->config->get('ip_url');
        
        return $this->load->view('extension/module/invoiceplane', $data);
    }

    public function subscribe($data)
    {
        
        $apiKey = $this->config->get('ip_api_key');
        $ipUrl = $this->config->get('ip_url');

         $response = array();
         // Skip for localhost testing
        if ($this->whitelist()) {
            $response['status'] = 'error';
            $response['message'] = 'Running localhost';
            return $response;
        }

        

        if ($MailChimp->success()) {
            $response['status'] = 'success';
            $response['message'] = $mailchimp['message'];
            return true;
        } else {
            $response['status'] = 'error';
            $response['message'] = $MailChimp->getLastError();
            return false;
        }
    }

    public function unSubscribe($data)
    {
        $response = array();
        if ($this->whitelist()) {
            $response['status'] = 'error';
            $response['message'] = 'Running localhost';
            return $response;
        }

        $apiKey = $this->config->get('wocmailchimp_api_key');
        $listId = $this->config->get('wocmailchimp_list_id');

        $MailChimp = new MailChimp($apiKey);
        $subscriber_hash = $MailChimp->subscriberHash($data['email']);
        $result = $MailChimp->patch("lists/$listId/members/$subscriber_hash", [
                'status'    => 'unsubscribed'
            ]);
        if ($MailChimp->success()) {
            $response['status'] = 'success';
            $response['message'] = $result['message'];
        } else {
            $response['status'] = 'error';
            $response['message'] = $MailChimp->getLastError();
        }
              return $response;
    }

    public function update($data)
    {

        $apiKey = $this->config->get('wocmailchimp_api_key');
        $listId = $this->config->get('wocmailchimp_list_id');

        $MailChimp = new MailChimp($apiKey);
        $subscriber_hash = $MailChimp->subscriberHash($data['email']);
        $result = $MailChimp->patch("lists/$listId/members/$subscriber_hash", [
                'merge_fields' => ['FNAME'=>$data['firstname'], 'LNAME'=>$data['lastname']
                ]]);
        return $result;
    }

    public function delete($data)
    {
        if ($this->whitelist()) {
            $response['status'] = 'error';
            $response['message'] = 'Running localhost';
            return $response;
        }

        $apiKey = $this->config->get('wocmailchimp_api_key');
        $listId = $this->config->get('wocmailchimp_list_id');

        $MailChimp = new MailChimp($apiKey);
        $subscriber_hash = $MailChimp->subscriberHash($data['email']);
        $result = $MailChimp->delete("lists/$listId/members/$subscriber_hash");
        return $result;
    }

    public function whitelist()
    {
        $whitelist = array('127.0.0.1', '::1', 'localhost');
        // Skip for localhost testing
        if (in_array($_SERVER['REMOTE_ADDR'], $whitelist)) {
            return true;
        } else {
            return false;
        }
    }
}
