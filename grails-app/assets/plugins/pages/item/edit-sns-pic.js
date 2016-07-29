/**
 * Created by saarixx on 12/11/14.
 */
(function ($) {
    // ��domReady��ʱ��ʼ��ʼ��
    $(function () {
        // ��ʼ��Web Uploader
        var uploader = WebUploader.create({

            // ѡ���ļ����Ƿ��Զ��ϴ���
            auto: true,

            // swf�ļ�·��
            swf: "assets/ueditor-1.4.3/third-party/webuploader/Uploader.swf",

            // �ļ����շ���ˡ�
            server: '/itemPublish/handle?action=uploadImage',

            // ѡ���ļ��İ�ť����ѡ��
            // �ڲ����ݵ�ǰ�����Ǵ�����������inputԪ�أ�Ҳ������flash.
            pick: '#filePicker4',

            // ֻ����ѡ��ͼƬ�ļ���
            accept: {
                title: 'Images',
                extensions: 'gif,jpg,jpeg,bmp,png',
                mimeTypes: 'image/*'
            }
        });

        var $ = jQuery,
            $list = $('#fileList4'),
        // �Ż�retina, ��retina�����ֵ��2
            ratio = window.devicePixelRatio || 1,

        // ����ͼ��С
            thumbnailWidth = 100 * ratio,
            thumbnailHeight = 100 * ratio,

        // Web Uploaderʵ��
            uploader;

        // �����ļ���ӽ�����ʱ��
        uploader.on('fileQueued', function (file) {
            addFile(file)
        });


        // �ļ��ϴ��ɹ�����item��ӳɹ�class, ����ʽ����ϴ��ɹ���
        uploader.on('uploadSuccess', function (file) {
            $('#' + file.id).addClass('state-complete');
            $('#' + file.id).append('<span class="success"></span>');
        });

        uploader.on('uploadAccept', function (file, response) {
            console.log($('#' + file.file.id).find('p.imgWrap'))
            $('#' + file.file.id).find('p.imgWrap').html('<img src="' + response.url + '"><input name="sns-pic" value="' + response.url + '" style="display: none">');
        });

        // �ļ��ϴ�ʧ�ܣ���ʾ�ϴ�����
        uploader.on('uploadError', function (file) {
            var $li = $('#' + file.id),
                $error = $li.find('div.error');

            // �����ظ�����
            if (!$error.length) {
                $error = $('<div class="error"></div>').appendTo($li);
            }

            $error.text('�ϴ�ʧ��');
        });

        // ����ϴ����ˣ��ɹ�����ʧ�ܣ���ɾ����������
        uploader.on('uploadComplete', function (file) {
            $('#' + file.id).find('.progress').remove();
        });

        // �����ļ���ӽ���ʱִ�У�����view�Ĵ���
        function addFile(file) {
            var $li = $('<li id="' + file.id + '">' +
                    '<p class="title">' + file.name + '</p>' +
                    '<p class="imgWrap"></p>' +
                    '</li>'),

                $btns = $('<div class="file-panel">' +
                    '<span class="cancel">ɾ��</span>' +
                    '<span class="rotateLeft">�����ƶ�</span>' +
                    '<span class="rotateRight">�����ƶ�</span>' +
                    '</div>').appendTo($li),

                $wrap = $li.find('p.imgWrap'),
                $info = $('<p class="error"></p>')


            // @todo lazyload
            $wrap.text('Ԥ����');
            uploader.makeThumb(file, function (error, src) {
                var img;
                if (error) {
                    $wrap.text('����Ԥ��');
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

            // $listΪ����jQueryʵ��
            $list.append($li);
        }

        // ����view������
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

})(jQuery);
