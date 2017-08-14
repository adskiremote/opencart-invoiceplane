<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-invoiceplane" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1>
                <?php echo $heading_title; ?>
            </h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li>
                    <a href="<?php echo $breadcrumb['href']; ?>">
                        <?php echo $breadcrumb['text']; ?>
                    </a>
                </li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
            <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-cogs"></i>
                    <?php echo $heading_title; ?>
                </h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-invoiceplane" class="form-horizontal">
                    <ul class="nav nav-tabs">
                        <li class="active">
                            <a href="#tab-status" data-toggle="tab">
                               Status
                            </a>
                        </li>
                        <li>
                            <a href="#tab-customers" data-toggle="tab">
                               Customers
                            </a>
                        </li>
                        <li>
                            <a href="#tab-orders" data-toggle="tab">
                               Orders
                            </a>
                        </li>
                        <li>
                            <a href="#tab-payments" data-toggle="tab">
                               Payments
                            </a>
                        </li>
                        <li>
                            <a href="#tab-settings" data-toggle="tab">
                               Settings
                            </a>
                        </li>
                        <li>
                            <a href="#tab-repair" data-toggle="tab">
                             Repair
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane active" id="tab-status">
                            <legend>InvoicePlane Status</legend>
                            Check your InvoicePlane is correctly synced with OpenCart<br />Click on repair to fix any issues.
                            <div class="form-group">
                                <label class="col-sm-2 control-label">On order</label>
                                <div class="col-sm-10">
                                    <select name="invoiceplane_on_order" class="form-control">
                            <?php if ($invoiceplane_on_order) { ?>
                            <option value="1" selected="selected"><?php echo $text_yes; ?></option>
                            <option value="0"><?php echo $text_no; ?></option>
                            <?php } else { ?>
                            <option value="1"><?php echo $text_yes; ?></option>
                            <option value="0" selected="selected"><?php echo $text_no; ?></option>
                            <?php } ?>
                        </select>
                                </div>
                            </div>
                        </div>
                        <!-- End Tab Status -->
                        <div class="tab-pane" id="tab-customers">
                            <fieldset>
                                <legend>Customers to Clients</legend>
                                Here you can recheck Customers and Clients are synced correctly.<br /> You should not need to run this again if On Sale and On Customer events are enabled.
                                <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                                <button type="button" onclick="repair();" id="button-repair" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-wrench"></i> Some button</button>

                            </fieldset>
                        </div>

                        <div class="tab-pane" id="tab-orders">
                            <legend>Sync Orders</legend>
                            Here you can recheck Orders to Invoices are synced correctly.<br /> You should not need to run this again if On Sale event is enabled.
                            <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                            <button type="button" onclick="repair();" id="button-repair" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-wrench"></i> Some button</button>
                            </fieldset>
                        </div>

                        <div class="tab-pane" id="tab-payments">
                            <legend>Sync Payments</legend>
                            Here you can recheck Order Payments are synced correctly.<br /> You should not need to run this again if On Sale event is enabled.
                            <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                            <button type="button" onclick="repair();" id="button-repair" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-wrench"></i> Some button</button>
                            </fieldset>
                        </div>

                        <div class="tab-pane" id="tab-settings">
                            <fieldset>
                                <legend>This is tiutle 12</legend>
                                And tyhe description
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">API Key</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="invoiceplane_api_key" id="input-api-key" class="form-control" value="<?php echo $invoiceplane_api_key; ?>" data-toggle="tooltip" data-placement="bottom" title="InvoicePlane API Key" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">InvoicePlane Url</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="invoiceplane_url" id="input-list-id" class="form-control" value="<?php echo $invoiceplane_url; ?>" data-toggle="tooltip" data-placement="bottom" title="InvoicePlane Url" />
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                        <div class="tab-pane" id="tab-repair">
                            <fieldset>
                                <legend>This is tiutle 12</legend>
                                And tyhe description
                                <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                                <button type="button" onclick="repair();" id="button-repair" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-wrench"></i> Some button</button>
                            </fieldset>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>