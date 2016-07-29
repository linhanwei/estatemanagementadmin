<div>
    <div class="box box-solid ">
        <div class="box-header">
            <h3 class="box-title"><i class="fa fa-bookmark"></i>标题:${currentComplain?.title}</h3>
        </div>

        <div class="box-body">

            <div class="row">
                <label class="col-sm-2 control-label"><i class="fa fa-file-text-o"></i>投诉内容:</label>

                <div class="col-sm-8">
                    <textarea rows="3" name="dealcontent" class="form-control"
                              id="dealcontent">${currentComplain?.content}</textarea>
                </div>
            </div>

        </div><!-- /.box-body -->
    </div>
    <g:if test="${total <= 0}">
        <div style="">
            <code>暂无处理记录</code>
        </div>
    </g:if>

    <g:if test="${total > 0}">
        <table class="table table-hover table-striped table-bordered text-center">
            <thead>
            <tr>
                <th style="width: 80px">处理记录</th>
                <th style="width: 180px">处理时间</th>
                <th style="width: 80px">处理人</th>
                <th style="width: 80px">手机</th>
                <th>处理情况</th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${notes}" var="record" status="i">
                <tr class="info">
                    <td>编号${i + 1}</td>
                    <td>${record.dateCreate.toString().substring(0, 16)}</td>
                    <g:if test="${record.replyerType == 2}">
                        <td>${replayerMap.get(record.id).get(0)}</td>
                        <td>${replayerMap.get(record.id).get(1)}</td>
                    </g:if>
                    <g:if test="${record.replyerType == 1}">
                        <td>${replayerMap.get(record.id).get(0)}</td>
                        <td>${replayerMap.get(record.id).get(1)}</td>
                    </g:if>
                    <td>${record.dealContent}</td>
                </tr>
            </g:each>
            </tbody>
        </table>
    </g:if>
</div>