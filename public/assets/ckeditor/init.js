function ck_load(){$(".ckeditor").each(function(){CKEDITOR.replace($(this).attr("name"))})}!function(){("undefined"==typeof window.CKEDITOR_BASEPATH||null===window.CKEDITOR_BASEPATH)&&(window.CKEDITOR_BASEPATH="/assets/ckeditor/")}.call(this),$(document).on("page:load",ck_load);