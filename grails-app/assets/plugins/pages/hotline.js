/*
 * Author: Abdullah A Almsaeed
 * Date: 4 Jan 2014
 * Description:
 *      This is a demo file used only for the main dashboard (index.html)
 **/

$(function() {
    "use strict";

    //Make the dashboard widgets sortable Using jquery UI
    $(".connectedSortable").sortable({
        placeholder: "sort-highlight",
        connectWith: ".connectedSortable",
        handle: ".box-header, .nav-tabs",
        forcePlaceholderSize: true,
        zIndex: 999999
    }).disableSelection();
    $(".connectedSortable .box-header, .connectedSortable .nav-tabs-custom").css("cursor", "move");
});

function bindingNewItemValidation() {
    $('div[id^="new-item-"]').each(function(){
        $(this).bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                name: {
                    trigger: 'blur',
                    message: '请输入名称',
                    validators: {
                        notEmpty: {
                            message: '名称必须填写'
                        },
                        stringLength: {
                            min: 2,
                            max: 8,
                            message: '为适应手机显示，标题长度最少长度是2，最大长度是8'
                        }
                    }
                },
                mobile: {
                    trigger: 'blur',
                    validators: {
                        notEmpty: {
                            message: '请输入手机或者固话'
                        },
                        regexp: {
                            regexp: /^[0-9-]{8,13}$/,
                            message: "固话格式为0571-56785678，手机格式为13856785678"
                        }
                    }
                },
                note: {
                    trigger: 'blur',
                    message: '请输入备注，可以选填写',
                    validators: {
                        stringLength: {
                            max: 15,
                            message: '为适应手机显示，备注信息最大长度为15'
                        }
                    }
                }
            }
        });
    });
}

function bindingAddTitleValidation() {
    binding()
    bindingNewItemValidation()
    $('#createHotLine').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            newtitle: {
                trigger: 'blur',
                message: '请输入标题',
                validators: {
                    notEmpty: {
                        message: '标题必须填写'
                    },
                    stringLength: {
                        min: 2,
                        max: 8,
                        message: '为适应手机显示，标题长度最少是2，最大是8'
                    }
                }
            },
            newname1: {
                trigger: 'blur',
                message: '请输入名称',
                validators: {
                    notEmpty: {
                        message: '名称必须填写'
                    },
                    stringLength: {
                        min: 2,
                        max: 8,
                        message: '为适应手机显示，标题长度最少长度是2，最大长度是8'
                    }
                }
            },
            newmobile1: {
                trigger: 'blur',
                validators: {
                    notEmpty: {
                        message: '请输入手机或者固话'
                    },
                    regexp: {
                        regexp: /^[0-9-]{8,13}$/,
                        message: "固话格式为0571-56785678，手机格式为13856785678"
                    }
                }
            },
            newnote1: {
                trigger: 'blur',
                message: '请输入备注，可以选填写',
                validators: {
                    stringLength: {
                        max: 15,
                        message: '为适应手机显示，备注信息最大长度为15'
                    }
                }
            }
        }
    });
}

