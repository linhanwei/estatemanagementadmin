<%@ page import="org.apache.commons.lang3.StringUtils" %>
<g:form useToken="true" action="createOrUpdateCategory">
    <div class="box-body no-padding">
        <div style="margin-top: 15px"/>

        <div class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label">父类目：</label>

                <div class="col-sm-8">
                    <input class="form-control" value="${(parent?.name) ?: '无'}" readonly/>
                </div>
            </div>

            <input name="id" value="${(node?.id)}" style="display: none;"/>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目id：</label>

                <div class="col-sm-8">
                    <input class="form-control" value="${node?.id}" name="onenidid" readonly/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目名字：</label>

                <div class="col-sm-8">
                    <input name="name" class="form-control" value="${node?.name}"/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目描述：</label>

                <div class="col-sm-8">
                    <textarea name="memo" class="form-control" rows="3">${node?.memo}</textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目层级：</label>

                <div class="col-sm-8">
                    <input  id="lmcjNum" class="form-control" value="${node?.level}" readonly/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目属性:</label>

                <div class="col-sm-8">
                    <textarea name="features" class="form-control" rows="3">${node?.features}</textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">包含子类目：</label>

                <div class="col-sm-8">
                    <input class="form-control" value="${hasChild ? '有' : '无'}" readonly/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目图片：</label>

                <div class="col-sm-8">
                    <div id="uploader2" class="queueList">
                        <!--用来存放item-->
                        <ul id="fileList2" class="filelist">
                            <g:if test="${node.picture}">
                                <li id="WU_FILE_991" class="state-complete">
                                    <p class="title"></p>

                                    <p class="imgWrap">
                                        <img src="${node.picture}">
                                        <input name="detail-pic" value="${node.picture}" style="display: none">
                                    </p>

                                    <div class="file-panel">
                                        <span class="cancel">删除</span>
                                        <span class="rotateLeft">向左移动</span>
                                        <span class="rotateRight">向右移动</span>
                                    </div>
                                    <span class="success"/>
                                </li>
                            </g:if>
                        </ul>

                        <div id="filePicker2" style="z-index: 999">选择图片</div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- /.box-body -->
    <div class="box-footer clearfix">
        <button type="submit" class="btn btn-success" id="updateBtn">保存更新</button>
        <button class="btn btn-danger" onclick="deleteCategory(${node?.id})">删除节点</button>
        <g:if test="${node.status == 1 as byte}">
            <button class="btn btn-warning" onclick="hideCategory(${node?.id})">隐藏节点</button>
        </g:if>
        <g:elseif test="${node.status == 2 as byte}">
            <button class="btn btn-info" onclick="showCategory(${node?.id})">显示节点</button>
        </g:elseif>

    </div>
</g:form>
<script>

    $("#updateBtn").on('click',function(){
        var size= $("input[name=detail-pic]").length;
        if(size>1)
        {
            alert("只能上传一张图片作为类目的图片...");
            return false;
        }
    });

    $("[id^='WU_FILE_']").each(function () {

        var id = this.id
        var $btn = $(this).find('.file-panel')

        $(this).on('mouseenter', function () {
            $btn.stop().animate({height: 30});
        });

        $(this).on('mouseleave', function () {
            $btn.stop().animate({height: 0});
        });

        $btn.on('click', 'span', function () {

            var index = $(this).index(),
                    deg;

            switch (index) {
                case 0:
                    $('#' + id).remove()
                    return;
                case 1:
                    console.log(id)
                    moveDown($('#' + id))
                    break;
                case 2:
                    moveUp($('#' + id))
                    break;

            }

        });

        function moveUp($item) {
            $before = $item.prev();
            $item.insertBefore($before);
        }

        function moveDown($item) {
            $after = $item.next();
            $item.insertAfter($after);
        }
    });
</script>
