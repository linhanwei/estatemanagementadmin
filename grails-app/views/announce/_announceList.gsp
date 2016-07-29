<div class="box-body table-responsive no-padding">
    <table class="table table-hover" id="table">
        <tr>
            <th style="width: 190px">公告时间</th>
            <th>公告主题</th>
            <th>公告内容</th>
            <th>发布者</th>
            <th>操作</th>
        </tr>
        <g:if test="${total > 0}">
            <g:each status="i" in="${announceRecords}" var="record">
                <tr>
                    <td>${record.dateCreated.toString().substring(0, 16)}</td>
                    <td>${record.title}</td>
                    <td>
                        <span id="content">${record.contentTxt}</span>
                    </td>
                    <td>${record.publisher}</td>
                    <td><a href="#" class="btn-sm btn-primary"
                           onclick="lookAnnounceInfo('${record.id}', '${record.title}');
                           return false;">查看公告内容</a>
                        <a href="#" class="btn-sm btn-primary" onclick="deleteAnnounce(${record.id});
                        return false;" style="background-color: orangered">删除</a>
                    </td>
                </tr>
            </g:each>
        </g:if>
    </table>
</div><!-- /.box-body -->
<div class="box-footer clearfix">
    <g:if test="${total > 0}">
        <ul class="pagination pull-right">
            <util:remotePaginate total="${total}" action="queryCommunityAnnounce" params="${params}"
                                 update="announceList"
                                 next="下一页" prev="上一页"/>
        </ul>
    </g:if>
</div>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.min.js"/>

<script>

    $("#table tr:first-child").next('tr').css({
        "font-size": "16px"

    });

    $("#table tr:first-child").next('tr').css({
        "fontWeight": "600"

    });

    function deleteAnnounce(id) {

        if (!confirm("您确定要删除该公告吗？")) {
            return;
        }

        <g:remoteFunction action="deleteAnnounce" update="contentannounceList" params="{'announceId':id}"/>

    }

</script>