<%@ page import="com.alibaba.fastjson.JSON; com.alibaba.fastjson.TypeReference; org.apache.commons.lang3.StringUtils" %>

<div>
    <table class="table table-bordered text-center" style="table-layout: fixed">
        <thead>
        <tr>
            <th><i class="fa fa-bookmark"></i>标题:</th>
            <th>${item?.title}</th>
            <th><i class="fa fa-flask"></i>规格:</th>
            <th>${item?.specification}</th>
        </tr>

        <tr>
            <th><i class="fa fa-gavel"></i>销售价:</th>
            <th><span style="color: #ff0000">${(item?.price ?: 0) / 100f}</span></th>
        </tr>
        </thead>
    </table>
    <g:form action="changeTag" name="changeTag_Form" params="${params}">
        <input value="${item?.id}" style="display: none" name="itemId">
        <table class="table table-bordered">
            <thead>
        <tr>
        <th>当前标:(点击删除)</th>
        <th>
        <g:if test="${currentTags != null}">
            <g:each in="${currentTags}" var="tag" status="i">
                <input id="${tag?.id}" type="button" name="newMainTag" value="${tag?.name}"
                       onclick="deleteItemTag(${tag?.id})"
                       style="background-color: dodgerblue;color: #ffffff"
                       class="btn tagBtn">
            </g:each>
        </g:if>
        </th>
        </tr>

        <tr>
            <th>
                <g:if test="${allTags != null}">
                    <g:each in="${allTags}" var="tag" status="i">
                        <label><input type="radio" name="newTags" value="${tag?.id}">${tag?.name}</label>
                    </g:each>
                </g:if>
            </th>
            <th>
                <button type="submit" class="btn btn-primary pull-right">打标</button>
            </th>
        </tr>
    </g:form>
</thead>
</table>
    <div id="selectAttributes">
    </div>
</div>

<!-- Jquery -->
<asset:javascript src="jquery-2.1.3.js"/>
<!-- Bootstrap -->
<asset:javascript src="bootstrap.js"/>
<!-- AdminLTE App -->
<asset:javascript src="app.js"/>
<script>

    function deleteItemTag(id) {

        if (!confirm("您真的要删除这个标签么？")) {
            return;
        }
        var itemId = $("input[name='itemId']").val()

        $.ajax({
            url: '/ShopItemManager/deleteItemTag',
            data: {'tagId': id, 'itemId': itemId},
            type: "POST",
            dataType: "json",
            success: function (data) {
                $("#" + id).remove()
            },
            error: function (data) {
                alert('对不起，您没有权限删除该标签')
            }
        });
    }

    $(document).ready(function () {
        var oldValue

        $('.tagBtn').mouseover(function () {
            $(this).css({
                'backgroundColor': '#df0001',
                'color': '#fff'
            });
            oldValue = $(this).val()
            $(this).val('删除该标')
        });

        $('.tagBtn').mouseout(function () {
            $(this).css({
                'backgroundColor': 'dodgerblue',
                'color': '#fff'
            });
            $(this).val(oldValue)

        });

        $("#add").click(function () {

            $("#select1 option:selected").appendTo("#select2");

        });

        $("#add_all").click(function () {

            $("#select1 option").appendTo("#select2");

        });

        $("#remove").click(function () {

            $("#select2 option:selected").appendTo("#select1");

        });

        $("#remove_all").click(function () {

            $("#select2 option").appendTo("#select1");

        });

        $("#select1").dblclick(function () {

            $("#select1 option:selected").appendTo("#select2");

        });

        $("#select2").dblclick(function () {

            $("#select2 option:selected").appendTo("#select1");

        });


    });
</script>

