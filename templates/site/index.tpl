<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link rel="stylesheet" type="text/css" href="[% burl %]resources/css/ext-all.css" />
    <link rel="stylesheet" type="text/css" href="[% burl %]resources/css/xtheme-[% Catalyst.config.extjs.theme %].css" />
    <script type="text/javascript" src="[% burl %]ext/yui-utilities.js" charset="utf-8"></script>
    <script type="text/javascript" src="[% burl %]ext/ext-yui-adapter.js" charset="utf-8"></script>
    <script type="text/javascript" src="[% burl %]ext/ext-all.js" charset="utf-8"></script>
    <title>[% Catalyst.config.name %]</title>
</head>

<body>
<script type="text/javascript">
Ext.BLANK_IMAGE_URL = '[% burl %]resources/images/[% Catalyst.config.extjs.theme %]/s.gif';
Ext.onReady(function() {
    Ext.QuickTips.init();

    var win = new Ext.Window({
        title:'[% Catalyst.config.name %]'
        ,layout:'fit'
        ,width:350
        ,minWidth:350
        ,height:190
        ,minHeight:190
        ,closable: false
        ,items:[
            new Ext.FormPanel({
                id:'fp'
                ,labelWidth: 75
                ,url:'[% Catalyst.uri_for('/save') %]'
                ,frame:true
                ,defaultType: 'textfield'
                ,deferredRender:false

                ,items: [{
                        fieldLabel: 'First name',
                        name: 'first',
                        anchor:'100%'
                    },{
                        fieldLabel: 'Last name',
                        name: 'last',
                        anchor:'100%'
                    },{
                        fieldLabel: 'Company',
                        name: 'company',
                        anchor:'100%'
                    },{
                        fieldLabel: 'eMail',
                        name: 'email',
                        anchor:'100%'
                    }
                ]

                ,buttons: [{
                    text: 'Save',
                    handler: function() {
                        win.findById('fp').getForm().submit();
                    }
                }]
            })
        ]
    });

    var fp = win.findById('fp');
    fp.on('actioncomplete', function(a, fp) {
        var r = fp.result;
        for (var field in r.error) {
            fp.form.findField(field).markInvalid(r.error[field].join("<br/>"));
        }
    });
    
    win.render(document.body);
    win.show();
});
</script>
</body>
</html>
