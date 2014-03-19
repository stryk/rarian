/*
 Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function (config) {
  // Define changes to default configuration here. For example:
  //config.language = 'en';
  // config.uiColor = '#AADC6E';
  /* Filebrowser routes */
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

  // The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  //remove advanced tab from image properties
  config.removeDialogTabs = 'image:advanced;image:Link;link:advanced;link:upload';

  config.removePlugins = 'elementspath';
  
  config.extraPlugins = 'wordcount,autogrow,imagepaste';

  config.scayt_autoStartup = true;

  config.allowedContent = true;

  // Rails CSRF token
  config.filebrowserParams = function () {
    var csrf_token, csrf_param, meta,
      metas = document.getElementsByTagName('meta'),
      params = new Object();

    for (var i = 0; i < metas.length; i++) {
      meta = metas[i];

      switch (meta.name) {
        case "csrf-token":
          csrf_token = meta.content;
          break;
        case "csrf-param":
          csrf_param = meta.content;
          break;
        default:
          continue;
      }
    }

    if (csrf_param !== undefined && csrf_token !== undefined) {
      params[csrf_param] = csrf_token;
    }

    return params;
  };

  config.addQueryString = function (url, params) {
    var queryString = [];

    if (!params) {
      return url;
    } else {
      for (var i in params)
        queryString.push(i + "=" + encodeURIComponent(params[ i ]));
    }

    return url + ( ( url.indexOf("?") != -1 ) ? "&" : "?" ) + queryString.join("&");
  };

  config.toolbar = [
    { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', '-', 'TextColor','NumberedList', 'BulletedList'] },
    { name: 'insert', items: [ 'Image'] }
  ];

// //Toolbar groups configuration.
//   config.toolbarGroups = [
//     { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
//     { name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ] },
//     { name: 'links' },
//     { name: 'insert' },
//     { name: 'forms' },
//     { name: 'tools' },
//     { name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
//     { name: 'others' },
//     '/',
//     { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
//     { name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
//     { name: 'styles' },
//     { name: 'colors' },
//     { name: 'about' }
//   ];



  // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
  CKEDITOR.on('dialogDefinition', function (ev) {
    // Take the dialog name and its definition from the event data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;
    var dialog = ev.data.definition.dialog;
    var content, upload;

    if(dialogName == 'link') {

      dialogDefinition.onShow = function () {
        var dialog = CKEDITOR.dialog.getCurrent();
        //dialog.hidePage( 'target' ); // now via config
        //dialog.hidePage( 'advanced' ); // now via config
        elem = dialog.getContentElement('info','anchorOptions');
        elem.getElement().hide();
        elem = dialog.getContentElement('info','emailOptions');
        elem.getElement().hide();
        var elem = dialog.getContentElement('info','linkType');
        elem.getElement().hide();
        elem = dialog.getContentElement('info','protocol');
        elem.disable();
      };

    }
    /* if you have any plugin of your own and need to remove ok button
     else if(dialogName == 'my_own_plugin') {
     // remove ok button (this was hard to find!)
     dialogDefinition.onShow = function () {
     // this is a hack
     document.getElementById(this.getButton('ok').domId).style.display='none';
     };
     }*/
    else if(dialogName == 'image') {
      var infoTab = dialogDefinition.getContents('info');

      // Remove unnecessary widgets
      infoTab.remove( 'ratioLock' );
      infoTab.remove( 'txtHeight' );
      infoTab.remove( 'txtWidth' );
      infoTab.remove( 'txtBorder');
      infoTab.remove( 'txtHSpace');
      infoTab.remove( 'txtVSpace');
      infoTab.remove( 'cmbAlign' );

      dialog.on('show', function () {

        var dialog = CKEDITOR.dialog.getCurrent();

        var elem = dialog.getContentElement('info','htmlPreview');
        elem.getElement().hide();



        dialog.hidePage( 'advanced' );
        dialog.hidePage( 'info' );

        // show upload tab
        this.selectPage('Upload');
//                this.disableButton('ok'); //not working so used following
        document.getElementById(dialog.getButton('ok').domId).style.display = "none";

        $(".cke_dialog_ui_fileButton span").html("Upload");
        $(".cke_dialog_title").html("Image Upload");
        $(".cke_dialog_footer").hide();
        // optional:


        var uploadTab = dialogDefinition.getContents('Upload');
        var uploadButton = uploadTab.get('uploadButton');
        uploadButton['filebrowser']['onSelect'] = function( fileUrl, errorMessage ) {
          dialog.getContentElement('info', 'txtUrl').setValue(fileUrl);
          $(".cke_dialog_ui_button_ok span").click();
        }
      });

    }
    else if(dialogName == 'table') {
      dialogDefinition.removeContents('advanced');
    }


    if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
      content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
      upload = (content == null ? null : content.get('upload'));

      if (upload && upload.filebrowser && upload.filebrowser['params'] === undefined) {
        upload.filebrowser['params'] = config.filebrowserParams();
        upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
      }
    }
  });

};
