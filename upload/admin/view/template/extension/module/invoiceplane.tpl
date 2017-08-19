<?php header("Access-Control-Allow-Origin: *"); ?>
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
                            <a href="#tab-products" data-toggle="tab">
                               Products
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
                            <legend>Status</legend>
                            Check integration connection
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Check connection</label>
                                <div class="col-sm-10">
                                    <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                                    <button type="button" onclick="repair();" id="button-repair" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-success"><i class="fa fa-wrench"></i> Check Connection</button>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane" id="tab-products">
                            <fieldset>
                                <legend>Products sync</legend>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Options</label>
                                    <div class="col-sm-10">
                                        <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                                        <button type="button" id="button-pop-options" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-success"><i class="fa fa-wrench"></i> Populate Options</button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Product Family</label>
                                    <div class="col-sm-10">
                                        <select name="invoiceplane_product_family" id="invoiceplane_product_family" class="form-control">
                                          <?php if ($invoiceplane_product_family) { ?>
                                            <option value="<?php echo invoiceplane_product_family; ?>" selected="selected"><?php echo $invoiceplane_product_family; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Tax Rate</label>
                                    <div class="col-sm-10">
                                        <select name="invoiceplane_tax_rates" id="invoiceplane_tax_rates" class="form-control">
                                              <?php if ($invoiceplane_tax_rates) { ?>
                                            <option value="<?php echo invoiceplane_tax_rates; ?>" selected="selected"><?php echo $invoiceplane_tax_rates; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Unit</label>
                                    <div class="col-sm-10">
                                        <select name="invoiceplane_unit_id" id="invoiceplane_unit_id" class="form-control">
                                              <?php if ($invoiceplane_unit_id) { ?>
                                            <option value="<?php echo invoiceplane_unit_id; ?>" selected="selected"><?php echo $invoiceplane_unit_id; ?></option>
                                            <?php } ?>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Sync (one way)</label>
                                    <div class="col-sm-10">
                                        <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                                        <button type="button" id="button-sync-products" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-wrench"></i> Sync Products</button>
                                    </div>
                                </div>

                                <div class="form-group" id="product-sync-log">
                                    <label class="col-sm-2 control-label">Logs</label>
                                    <div class="col-sm-10">
                                        <textarea id="product-logs" rows="20" style="width:100%;" disabled></textarea>
                                    </div>
                                </div>

                            </fieldset>
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
                                <legend>Settings</legend>
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
                            </fieldset>
                        </div>
                        <div class="tab-pane" id="tab-repair">
                            <fieldset>
                                <legend>Warning - backup your databases first!</legend>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Repair integration tables</label>
                                    <div class="col-sm-10">
                                        <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                                        <button type="button" onclick="repair();" id="button-repair" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-primary"><i class="fa fa-wrench"></i> Repair</button>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Reset | Delete All settings</label>
                                    <div class="col-sm-10">
                                        <i class="fa fa-circle-o-notch fa-spin" id="image-repair" style="display:none;"> </i>
                                        <button type="button" id="button-reset" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-danger"><i class="fa fa-wrench"></i> Reset</button>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    <!--

    $('#product-sync-log').hide();

    // Populate options
    $('#button-pop-options').on('click', function() {
        var options = {
            type: 'GET',
            url: '<?php echo $invoiceplane_url; ?>' + '/api/products/options/',
            api_key: '<?php echo $invoiceplane_api_key; ?>'
        }

        $('#invoiceplane_product_family').empty();
        $('#invoiceplane_tax_rates').empty();
        $('#invoiceplane_unit_id').empty();

        $.ajax({
            type: options.type,
            url: options.url,
            headers: {
                'API-KEY': options.api_key
            },
            success: function(data) {
                // console.log(data);
                if (data.success) {
                    console.log(data);
                    // Populate Families
                    $.each(data.families, function(i, item) {
                        $('#invoiceplane_product_family').append('<option value="' + item.family_id + '">' + item.family_name + '</option>');
                    });

                    // Populate Tax Rates
                    $.each(data.tax_rates, function(i, item) {
                        $('#invoiceplane_tax_rates').append('<option value="' + item.tax_rate_id + '">' + item.tax_rate_name + ' - ' + item.tax_rate_percent + '%</option>');
                    });

                    // Populate Units
                    $.each(data.units, function(i, item) {
                        $('#invoiceplane_unit_id').append('<option value="' + item.unit_id + '">' + item.unit_name + '</option>');
                    });
                } else {
                    alert('Error\n' + data.message);
                }
            },
            failure: function() {
                alert('Error\n' + data.message);
            },
            error: function() {
                alert('Error\n' + data.message);
            }
        });


    });

    // Sync Products
    $('#button-sync-products').on('click', function() {
        var options = {
            type: 'POST',
            url: 'index.php?route=extension/module/invoiceplane/addip_product&token=<?php echo $session; ?>',
            api_key: '<?php echo $invoiceplane_api_key; ?>'
        }

        // Here we get all products from opencart and then loop to insert each time into IP
        // Change to Chained reponse!
        $.ajax({
                type: 'GET',
                url: 'index.php?route=extension/module/invoiceplane/getocproducts&token=<?php echo $session; ?>',
                dataType: 'json',
                cache: false,
                success: function(data) {
                    console.log(data);
                    $('#product-sync-log').show();
                    $.each(data, function(i, item) {
                        $('#product-logs').append('Updating: ' + item.name + '\r\n');
                        $.ajax({
                            type: options.type,
                            url: options.url,
                            data: item,
                            headers: {
                                'API-KEY': options.api_key
                            },
                            dataType: 'json',
                            cache: false,
                            success: function(data) {
                                console.log(data);
                                $('#product-logs').append(data.message + '\r\n');
                            },
                            error: function() {
                                console.log('error');
                            },
                            complete: function() {
                                // console.log("Complete");
                            }
                        })

                    })
                },
                error: function(e) {
                    console.log('error');
                }
            })
            /*
                    $.ajax({
                        type: options.type,
                        url: options.url,
                        headers: {
                            'API-KEY': api_key
                        },
                        // contentType: "application/json; charset=utf-8",
                        dataType: 'json',
                        cache: false,
                        success: function(data) {
                            console.log(data);
                            console.log("serialse", JSON.stringify(data));
                            $('#product-sync-log').show();
                            $.each(data, function(i, item) {
                                console.log(i);
                                console.log(item);
                                // $('#product-logs').append('Updating: ' + item[i].message + '\r\n');
                            })
                        },
                        failure: function() {
                            console.log("Failure");
                        },
                        error: function() {
                            console.log('error');
                        },
                        complete: function() {
                            console.log("Complete");
                        }
                    });
            */
    });

    // Reset
    $('#button-reset').on('click', function() {
        var options = {
            type: 'GET',
            url: 'http://localhost:4111/api/products/products/'
        }
        ajaxSend(options);


    });

    function ajaxSend(options) {
        console.log(options);
        $.ajax({
            type: options.type,
            url: options.url,
            crossDomain: true,
            success: function(data) {
                console.log(data);
                if (data.success) {

                } else {

                }
            },
            failure: function() {

            },
            error: function() {

            }
        });
    }
    //-->
</script>
<?php echo $footer; ?>