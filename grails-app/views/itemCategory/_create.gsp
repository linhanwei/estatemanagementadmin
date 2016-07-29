<g:form useToken="true" action="createOrUpdateCategory">
    <div class="box-body no-padding">
        <div style="margin-top: 15px"/>

        <div class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-3 control-label">父类目：</label>

                <div class="col-sm-8">
                    <input id="pId" name="pId" class="form-control" style="display: none;"/>
                    <input id="pName" class="form-control" value="一级类目无父类目" readonly/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">新类目名字：</label>

                <div class="col-sm-8">
                    <input name="name" class="form-control"/>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目属性:</label>

                <div class="col-sm-8">
                    <textarea id="pFeatures" name="features" class="form-control" rows="3"></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">新类目描述：</label>

                <div class="col-sm-8">
                    <textarea name="memo" class="form-control" rows="3"></textarea>
                </div>
            </div>

            <div class="form-group">
                <label class="col-sm-3 control-label">类目图片：</label>

                <div class="col-sm-8">
                    %{--<!--dom结构部分-->--}%
                    <div id="uploader" class="queueList">

                        <!--用来存放item-->

                        <ul id="fileList" class="filelist">

                        </ul>

                        <div id="filePicker" style="z-index: 999">选择图片</div>
                    </div>
                </div>
            </div>
        </div>
    </div><!-- /.box-body -->
    <div class="box-footer clearfix">
        <button type="submit" class="btn btn-primary" id="createBtn" >新增类目</button>
    </div>
</g:form>
<!-- jQuery 2.1.1 -->
<asset:javascript src="jquery-2.1.1.min.js"/>
<script type="text/javascript">
//    $(function(){
//        alert();
//    });

//    function showDemo(){
//        debugger;
//        return false;
//    }
//    $("#createBtn").on("click",function(){
//        debugger;
//        alert();
//        return false;
//    });
</script>



