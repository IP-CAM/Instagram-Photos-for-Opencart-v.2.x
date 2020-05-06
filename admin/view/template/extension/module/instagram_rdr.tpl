<?= $header; ?><?= $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-banner" data-toggle="tooltip" class="btn btn-primary">
                    <i class="fa fa-save"></i>
                </button>
                <a href="<?= $cache_btn ?>" id="cache-btn" data-toggle="tooltip" class="btn btn-info" title="<?= $button_cache; ?>">
                    <i class="fa fa-eraser"></i>
                </a>
                <a href="<?= $cancel; ?>" data-toggle="tooltip" title="<?= $button_cancel; ?>" class="btn btn-default">
                    <i class="fa fa-reply"></i>
                </a>
            </div>
            <h1><?= $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><a href="<?= $breadcrumb['href']; ?>"><?= $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
	<div class="container-fluid">
		<?php if ($errors['warning']) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?= $errors['warning']; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
		<?php } ?>
		<div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?= $text_edit; ?></h3>
            </div>
			<div class="panel-body">
				<form action="<?= $action ?>" method="post" enctype="multipart/form-data" id="form-redream-instagram" class="form-horizontal">
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for="input-name"><?= $entry_name; ?></label>
                        <div class="col-sm-10">
                            <input type="text" name="name" value="<?= $name; ?>" placeholder="<?= $entry_name; ?>" id="input-name" class="form-control"/>
                            <?php if ($errors['name']) { ?>
                                <div class="text-danger"><?= $errors['name']; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-title"><?= $entry_title; ?></label>
                        <div class="col-sm-10">
                            <?php foreach ($languages as $language) { ?>
                                <div class="input-group pull-left">
                                    <span class="input-group-addon">
                                        <img src="language/<?= $language['code'] . '/' . $language['code']; ?>.png"
                                             title="<?= $language['name']; ?>"/>
                                    </span>
                                    <input type="text" name="title[<?= $language['language_id']; ?>]" value="<?= $title[$language['language_id']] ?>" placeholder="<?= $entry_title; ?>" class="form-control"/>
                                </div>
                            <?php } ?>
                            <?php if ($errors['title']) { ?>
                                <div class="text-danger"><?= $errors['title']; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-status"><?= $entry_status; ?></label>
                        <div class="col-sm-10">
                            <select name="status" id="input-status" class="form-control">
                                <option value="1" <?= $status ? 'selected="selected"' : '' ?>><?= $text_enabled; ?></option>
                                <option value="0" <?= $status ? '' : 'selected="selected"' ?>><?= $text_disabled; ?></option>
                            </select>
                        </div>
                    </div>
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#general" data-toggle="tab"><?= $text_general; ?></a></li>
                        <li><a href="#view" data-toggle="tab"><?= $text_view; ?></a></li>
	                    <?php if($log) { ?>
		                    <li><a href="#log" data-toggle="tab"><?= $text_log; ?></a></li>
	                    <?php } ?>
                    </ul>
                    <div class="tab-content" id="tab-content">
                        <div class="tab-pane fade in active" id="general">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-token"><?= $entry_token; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="token" value="<?= $token; ?>" placeholder="<?= $entry_token; ?>" id="input-token" class="form-control"/>
                                    <?php if ($errors['token']) { ?>
                                        <div class="text-danger"><?= $errors['token']; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label"><?= $entry_account_info; ?></label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="account_info" value="1" <?= $account_info ? 'checked="checked"' : '' ?>/>
                                        <?= $text_yes; ?>
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="account_info" value="0" <?= $account_info ? '' : 'checked="checked"' ?>/>
                                        <?= $text_no; ?>
                                    </label>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-amount"><?= $entry_amount; ?></label>
                                <div class="col-sm-10">
                                    <input type="number" name="amount" value="<?= $amount; ?>" placeholder="<?= $entry_amount; ?>" id="input-amount" class="form-control"/>
                                    <?php if ($errors['amount']) { ?>
                                        <div class="text-danger"><?= $errors['amount']; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="view">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-width"><?= $entry_width; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="width" value="<?= $width; ?>" placeholder="<?= $entry_width; ?>" id="input-width" class="form-control"/>
                                    <?php if ($errors['width']) { ?>
                                        <div class="text-danger"><?= $errors['width']; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="input-height"><?= $entry_height; ?></label>
                                <div class="col-sm-10">
                                    <input type="text" name="height" value="<?= $height; ?>" placeholder="<?= $entry_height; ?>" id="input-height" class="form-control"/>
                                    <?php if ($errors['height']) { ?>
                                        <div class="text-danger"><?= $errors['height']; ?></div>
                                    <?php } ?>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="input-view-mode"><?= $entry_view_mode; ?></label>
                                <div class="col-sm-10">
                                    <select name="view_mode" id="input-view-mode" class="form-control">
                                        <option value="slideshow" <?= $view_mode == 'slideshow' ? 'selected="selected"' : '' ?>><?= $mode_slideshow; ?></option>
                                        <option value="grid" <?= $view_mode == 'grid' ? 'selected="selected"' : '' ?>><?= $mode_grid; ?></option>
                                    </select>
                                </div>
                            </div>
                            <div id="mode-slideshow" class="collapse <?= $view_mode == 'slideshow' ? 'in' : '' ?>">
                                <fieldset>
                                    <legend class="text-uppercase"><?= $mode_slideshow; ?></legend>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label" for="input-slideshow-items"><?= $entry_slideshow_items; ?></label>
                                        <div class="col-sm-10">
                                            <input type="number" name="slideshow_items" value="<?= $slideshow_items; ?>" placeholder="<?= $entry_slideshow_items; ?>" id="input-slideshow-items" class="form-control"/>
                                            <?php if ($errors['slideshow_items']) { ?>
                                                <div class="text-danger"><?= $errors['slideshow_items']; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label" for="input-slideshow-margin"><?= $entry_slideshow_margin; ?></label>
                                        <div class="col-sm-10">
                                            <input type="number" name="slideshow_margin" value="<?= $slideshow_margin; ?>" placeholder="<?= $entry_slideshow_margin; ?>" id="input-slideshow-margin" class="form-control"/>
                                            <?php if ($errors['slideshow_margin']) { ?>
                                                <div class="text-danger"><?= $errors['slideshow_margin']; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label" for="input-slideshow-speed"><?= $entry_slideshow_speed; ?></label>
                                        <div class="col-sm-10">
                                            <input type="number" name="slideshow_speed" value="<?= $slideshow_speed; ?>" placeholder="<?= $entry_slideshow_speed; ?>" id="input-slideshow-speed" class="form-control"/>
                                            <?php if ($errors['slideshow_speed']) { ?>
                                                <div class="text-danger"><?= $errors['slideshow_speed']; ?></div>
                                            <?php } ?>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label" for="input-slideshow-effect"><?= $entry_slideshow_effect; ?></label>
                                        <div class="col-sm-10">
                                            <select name="slideshow_effect" id="input-slideshow-effect" class="form-control">
                                                <?php foreach ($slideshow_effects as $effect => $effect_name) { ?>
                                                    <option value="<?= $effect ?>"<?= ($effect == $slideshow_effect) ? ' selected' : ''; ?>>
                                                        <?= $effect_name; ?>
                                                    </option>
                                                <?php } ?>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><?= $entry_slideshow_autoplay; ?></label>
                                        <div class="col-sm-10">
                                            <label class="checkbox-inline">
                                                <input name="slideshow_autoplay" type="hidden" value="0"/>
                                                <input name="slideshow_autoplay" type="checkbox" value="1" <?= $slideshow_autoplay ? 'checked="checked"' : '' ?>/> <?= $text_enabled ?>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><?= $entry_slideshow_timeout; ?></label>
                                        <div class="col-sm-10">
                                            <input type="number" name="slideshow_timeout" value="<?= $slideshow_timeout; ?>" placeholder="<?= $entry_slideshow_timeout; ?>" class="form-control"/>
                                        </div>
                                        <?php if ($errors['slideshow_timeout']) { ?>
                                            <div class="text-danger"><?= $errors['slideshow_timeout']; ?></div>
                                        <?php } ?>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label"><?= $entry_slideshow_options; ?></label>
                                        <div class="col-sm-10">
                                            <label class="checkbox-inline">
                                                <input type="hidden" name="slideshow_loop" value="0"/>
                                                <input type="checkbox" name="slideshow_loop" value="1" <?= $slideshow_loop ? 'checked="checked"' : '' ?>/> <?= $entry_slideshow_loop ?>
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="hidden" name="slideshow_nav" value="0"/>
                                                <input type="checkbox" name="slideshow_nav" value="1" <?= $slideshow_nav ? 'checked="checked"' : '' ?>/> <?= $entry_slideshow_nav ?>
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="hidden" name="slideshow_dots" value="0"/>
                                                <input type="checkbox" name="slideshow_dots" value="1" <?= $slideshow_dots ? 'checked="checked"' : '' ?>/> <?= $entry_slideshow_dots ?>
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="hidden" name="slideshow_center" value="0"/>
                                                <input type="checkbox" name="slideshow_center" value="1" <?= $slideshow_center ? 'checked="checked"' : '' ?>/> <?= $entry_slideshow_center ?>
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="hidden" name="slideshow_mouse_drag" value="0"/>
                                                <input type="checkbox" name="slideshow_mouse_drag" value="1" <?= $slideshow_mouse_drag ? 'checked="checked"' : '' ?>/> <?= $entry_slideshow_mouse_drag ?>
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="hidden" name="slideshow_touch_drag" value="0"/>
                                                <input type="checkbox" name="slideshow_touch_drag" value="1" <?= $slideshow_touch_drag ? 'checked="checked"' : '' ?>/> <?= $entry_slideshow_touch_drag ?>
                                            </label>
                                        </div>
                                    </div>
                                </fieldset>
                                <fieldset>
                                    <legend class="text-uppercase"><?= $text_responsive ?></legend>
                                    <table id="slideshow-responsive" class="table table-striped table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th width="200px"><?= $entry_slideshow_width ?></th>
                                                <th><?= $entry_slideshow_items; ?></th>
                                                <th><?= $entry_slideshow_margin; ?></th>
                                                <th width="50px"></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php
                                            $row = 0;
                                            if(!empty($slideshow_responsive)) {
                                                foreach ($slideshow_responsive as $responsive) { ?>
                                                    <tr id="row-<?= $row ?>">
                                                        <td>
                                                            <input type="number" name="slideshow_responsive[<?= $row ?>][width]" value="<?= $responsive['width']; ?>" placeholder="<?= $entry_slideshow_width; ?>" id="input-slideshow-responsive-<?= $row ?>-width" class="form-control"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" name="slideshow_responsive[<?= $row ?>][items]" value="<?= $responsive['items']; ?>" placeholder="<?= $entry_slideshow_items; ?>" id="input-slideshow-responsive-<?= $row ?>-items" class="form-control"/>
                                                        </td>
                                                        <td>
                                                            <input type="number" name="slideshow_responsive[<?= $row ?>][margin]" value="<?= $responsive['margin']; ?>" placeholder="<?= $entry_slideshow_margin; ?>" id="input-slideshow-responsive-<?= $row ?>-margin" class="form-control"/>
                                                        </td>
                                                        <td>
                                                            <button type="button" onclick="$('#row-<?= $row ?>').remove();" class="btn btn-danger">
                                                                <i class="fa fa-minus-circle"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <?php
                                                    $row++;
                                                }
                                            } ?>
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td colspan="3">
                                                </td>
                                                <td>
                                                    <button type="button" onclick="addRow();" class="btn btn-primary">
                                                        <i class="fa fa-plus-circle"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tfoot>
                                    </table>
                                </fieldset>
                            </div>
                            <div id="mode-grid" class="collapse <?= $view_mode == 'grid' ? 'in' : '' ?>">
                                <fieldset>
                                    <legend class="text-uppercase"><?= $mode_grid; ?></legend>
                                    <div class="row">
                                        <div class="col-sm-offset-2 col-sm-10">
                                            <div class="row">
                                                <div class="col-sm-6 col-md-3">
                                                    <label class="control-label" for="input-grid-lg"><?= $text_lg; ?></label>
                                                </div>
                                                <div class="col-sm-6 col-md-3">
                                                    <label class="control-label" for="input-grid-md"><?= $text_md; ?></label>
                                                </div>
                                                <div class="col-sm-6 col-md-3">
                                                    <label class="control-label" for="input-grid-sm"><?= $text_sm; ?></label>
                                                </div>
                                                <div class="col-sm-6 col-md-3">
                                                    <label class="control-label" for="input-grid-xs"><?= $text_xs; ?></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-2 control-label">
                                            <?= $entry_column_width; ?>
                                        </label>
                                        <div class="col-sm-10">
                                            <div class="row">
                                                <div class="col-sm-6 col-md-3">
                                                    <select name="grid_class_lg" id="input-grid-lg" class="form-control">
                                                        <?php foreach ($columns['lg'] as $class => $class_name) { ?>
                                                            <option value="<?= $class ?>"<?= ($class == $grid_class_lg) ? ' selected' : ''; ?>>
                                                                <?= $class_name; ?>
                                                            </option>
                                                        <?php } ?>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6 col-md-3">
                                                    <select name="grid_class_md" id="input-grid-md" class="form-control">
                                                        <?php foreach ($columns['md'] as $class => $class_name) { ?>
                                                            <option value="<?= $class ?>"<?= ($class == $grid_class_md) ? ' selected' : ''; ?>>
                                                                <?= $class_name; ?>
                                                            </option>
                                                        <?php } ?>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6 col-md-3">
                                                    <select name="grid_class_sm" id="input-grid-sm" class="form-control">
                                                        <?php foreach ($columns['sm'] as $class => $class_name) { ?>
                                                            <option value="<?= $class ?>"<?= ($class == $grid_class_sm) ? ' selected' : ''; ?>>
                                                                <?= $class_name; ?>
                                                            </option>
                                                        <?php } ?>
                                                    </select>
                                                </div>
                                                <div class="col-sm-6 col-md-3">
                                                    <select name="grid_class_xs" id="input-grid-xs" class="form-control">
                                                        <?php foreach ($columns['xs'] as $class => $class_name) { ?>
                                                            <option value="<?= $class ?>"<?= ($class == $grid_class_xs) ? ' selected' : ''; ?>>
                                                                <?= $class_name; ?>
                                                            </option>
                                                        <?php } ?>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </div>
	                    <?php if($log) { ?>
		                    <div class="tab-pane fade" id="log">
			                    <p>
				                    <textarea wrap="off" rows="15" class="form-control" readonly><?= $log; ?></textarea>
			                    </p>
			                    <div class="text-right">
				                    <a href="<?= $log_btn; ?>" class="btn btn-danger"><i class="fa fa-eraser"></i> <?= $button_clear; ?></a>
			                    </div>
		                    </div>
	                    <?php } ?>
                    </div>
                    <div class="text-center" style="padding: 40px 0">
                        <?= $text_copyright ?>
                    </div>
				</form>
			</div>
		</div>
    </div>
</div>
<script type="text/javascript"><!--
var row = <?= $row; ?>;

function addRow() {
    var html = '<tr id="row-' + row + '">';
    html += '    <td>';
    html += '        <input type="number" name="slideshow_responsive[' + row + '][width]" value="" placeholder="<?= $entry_slideshow_width; ?>" id="input-slideshow-responsive-' + row + '-width" class="form-control"/>';
    html += '    </td>';
    html += '    <td>';
    html += '        <input type="number" name="slideshow_responsive[' + row + '][items]" value="" placeholder="<?= $entry_slideshow_items; ?>" id="input-slideshow-responsive-' + row + '-items" class="form-control"/>';
    html += '    </td>';
    html += '    <td>';
    html += '        <input type="number" name="slideshow_responsive[' + row + '][margin]" value="" placeholder="<?= $entry_slideshow_margin; ?>" id="input-slideshow-responsive-' + row + '-margin" class="form-control"/>';
    html += '    </td>';
    html += '    <td>';
    html += '       <button type="button" onclick="$(\'#row-' + row + '\').remove();" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>';
    html += '    </td>';
    html += '</tr>';

    $('#slideshow-responsive > tbody').append(html);

    row++;
}
$(document).on('change', '#input-view-mode', function() {
    if($(this).val() == 'grid') {
        $('#mode-grid').collapse('show');
        $('#mode-slideshow').collapse('hide');
    } else {
        $('#mode-grid').collapse('hide');
        $('#mode-slideshow').collapse('show');
    }
});
$(document).on('click', '#cache-btn', function(e) {
    e.preventDefault();
    var btn = $(this);

    $.ajax({
        url: btn.attr("href"),
        dataType: 'json',
        processData: false,
        beforeSend : function() {
            btn.button('loading');
        },
        success: function (data) {
            if(data.success) {
                $('.page-header .container-fluid').append('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' +
                    data.success +
                    '<button type="button" class="close" data-dismiss="alert">&times; </button></div>'
                );
            }
            $('.page-header .container-fluid > .alert').each(function(i) {
                var alert = $(this);
                setTimeout(function() {
                    alert.fadeOut(function(){$(this).remove()})
                }, i*300 + 10000);
            });
        },
        complete : function() {
            btn.button('reset');
        }
    });
    return false;
});
//--></script>
<?= $footer; ?>