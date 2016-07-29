<!-- general form elements -->
<div class="box box-primary">

    <div class="box-header">
        <h2 class="page-header">
            公告 :${announce.title}
        </h2>
    </div><!-- /.box-header -->

    <div class="box-header">
        <div class="col-md-12">
            <div class="box box-primary" style="height: 200px;width: 800px">

                <input id="HiddenContent" value="${announce.content}" style="display: none"/>

                <div name="thisContent" id="thisContent">

                </div>
            </div><!-- /.box -->
        </div>
    </div><!-- /.box-header -->


    <div class="box-header">
        <h2 class="page-header">
            相关图片
            <small>${announce.announcePic}</small>
        </h2>
    </div><!-- /.box-header -->

    <div class="box-header">
        <h2 class="page-header">
            发布人:
            ${announce.publisher}
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            公告时间:
            ${announce.dateCreated}
        </h2>
    </div><!-- /.box-header -->

</div><!-- /.box -->

<script>
    $(document).ready(function () {
        var contentHtml = $("#HiddenContent").val()

        $("#thisContent").html(contentHtml.toString())

    });

</script>