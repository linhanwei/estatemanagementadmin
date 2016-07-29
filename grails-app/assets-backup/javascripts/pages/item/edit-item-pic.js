/**
 * Created by saarixx on 12/11/14.
 */
(function ($) {
    // 当domReady的时候开始初始化
    $(function () {

        // 初始化Web Uploader
        var uploader = WebUploader.create({

            // 选完文件后，是否自动上传。
            auto: true,

            // swf文件路径
            swf: "assets/ueditor-1.4.3/third-party/webuploader/Uploader.swf",

            // 文件接收服务端。
            server: '/itemPublish/handle?action=uploadImage',

            // 选择文件的按钮。可选。
            // 内部根据当前运行是创建，可能是input元素，也可能是flash.
            pick: '#filePicker',

            // 只允许选择图片文件。
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });

        var $ = jQuery,
            $list = $('#fileList'),
        // 优化retina, 在retina下这个值是2
            ratio = window.devicePixelRatio || 1,

        // 缩略图大小
            thumbnailWidth = 100 * ratio,
            thumbnailHeight = 100 * ratio,

        // Web Uploader实例
            uploader;

        // 当有文件添加进来的时候
        uploader.on('fileQueued', function (file) {
            addFile(file)
        });


        // 文件上传成功，给item添加成功class, 用样式标记上传成功。
        uploader.on('uploadSuccess', function (file) {
            $('#' + file.id).addClass('state-complete');
            $('#' + file.id).append('<span class="success"></span>');
        });

        uploader.on('uploadAccept', function (file, response) {
            console.log($('#' + file.file.id).find('p.imgWrap'))
            $('#' + file.file.id).find('p.imgWrap').html('<img src="' + response.url + '"><input name="item-pic" value="' + response.url + '" style="display: none">');
        });

        // 文件上传失败，显示上传出错。
        uploader.on('uploadError', function (file) {
            var $li = $('#' + file.id),
                $error = $li.find('div.error');

            // 避免重复创建
            if (!$error.length) {
                $error = $('<div class="error"></div>').appendTo($li);
            }

            $error.text('上传失败');
        });

        // 完成上传完了，成功或者失败，先删除进度条。
        uploader.on('uploadComplete', function (file) {
            $('#' + file.id).find('.progress').remove();
        });

        // 当有文件添加进来时执行，负责view的创建
        function addFile(file) {
            var $li = $('<li id="' + file.id + '">' +
                '<p class="title">' + file.name + '</p>' +
                '<p class="imgWrap"></p>' +
                '</li>'),

                $btns = $('<div class="file-panel">' +
                '<span class="cancel">删除</span>' +
                '<span class="rotateLeft">向左移动</span>' +
                '<span class="rotateRight">向右移动</span>' +
                '</div>').appendTo($li),

                $wrap = $li.find('p.imgWrap'),
                $info = $('<p class="error"></p>')


            // @todo lazyload
            $wrap.text('预览中');
            uploader.makeThumb(file, function (error, src) {
                var img;
                if (error) {
                    $wrap.text('不能预览');
                    return;
                }
                img = $('<img src="' + src + '">');
                $wrap.empty().append(img);
            }, thumbnailWidth, thumbnailHeight);

            $li.on('mouseenter', function () {
                $btns.stop().animate({height: 30});
            });

            $li.on('mouseleave', function () {
                $btns.stop().animate({height: 0});
            });

            $btns.on('click', 'span', function () {

                var index = $(this).index(),
                    deg;

                switch (index) {
                    case 0:
                        removeFile(file);
                        return;
                    case 1:
                        moveDown($('#' + file.id))
                        break;
                    case 2:
                        moveUp($('#' + file.id))
                        break;

                }

            });

            // $list为容器jQuery实例
            $list.append($li);
        }

        // 负责view的销毁
        function removeFile(file) {
            var $li = $('#' + file.id);
            $li.off().find('.file-panel').off().end().remove();
        }


        function moveUp($item) {
            $before = $item.prev();
            $item.insertBefore($before);
        }

        function moveDown($item) {
            $after = $item.next();
            $item.insertAfter($after);
        }

    });

    function addWithoutUpload(src) {
        var $li = $('<li>' +
            '<p class="title"></p>' +
            '<p class="imgWrap">' +
                '<img src="' + src + '">' +
                '<input name="item-pic" value="' + src + '" style="display: none">' +
            '</p>' +
            '</li>'),

            $btns = $('<div class="file-panel">' +
            '<span class="cancel">删除</span>' +
            '<span class="rotateLeft">向左移动</span>' +
            '<span class="rotateRight">向右移动</span>' +
            '</div>').appendTo($li),

            $wrap = $li.find('p.imgWrap'),
            $info = $('<p class="error"></p>')


        $li.on('mouseenter', function () {
            $btns.stop().animate({height: 30});
        });

        $li.on('mouseleave', function () {
            $btns.stop().animate({height: 0});
        });

        $btns.on('click', 'span', function () {

            var index = $(this).index(),
                deg;

            switch (index) {
                case 0:
                    removeFile(file);
                    return;
                case 1:
                    moveDown($('#' + file.id))
                    break;
                case 2:
                    moveUp($('#' + file.id))
                    break;

            }

        });

        // $list为容器jQuery实例
        $list.append($li);

        addWithoutUpload('http://karsatest.b0.upaiyun.com/1/MTk5/SVRFTS1QVUJMSVNI/MA==/20141112/vNTT-0-1415779570540.jpg')
    }

})(jQuery);