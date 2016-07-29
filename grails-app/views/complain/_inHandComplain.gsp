<div class="box">
    <div class="box-header">
        <div class="box-tools">
            <div class="row">
                <div class="col-xs-6">
                    <h5>以下投诉处理中</h5>
                </div><!-- /.col-lg-6 -->
                <div class="col-xs-6">
                    <div class="input-group">
                        <input type="text" class="form-control"
                               value="${(params.query == null || (params.query == 'null')) ? '' : params.query}"
                               placeholder="投诉人号码" id="ComplainInHandText"/>
                        <span class="input-group-btn">
                            <button class="btn btn-primary" type="button" id="ComplainInHandSearch">搜索</button>
                        </span>
                    </div><!-- /input-group -->
                </div><!-- /.col-lg-6 -->
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-xs-12">

        <table class="table table-bordered tableheadingcolor text-center">
            <thead>
            <tr>
                <th>投诉人</th>
                <th>投诉类目</th>
                <th>投诉内容</th>
                <th>投诉时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <g:if test="${total > 0}">
                <g:each in="${complainList}" var="record" status="i">
                    <tr>
                        <td>${profileMobileMap.get(record.id)}</td>
                        <td>${record.title}</td>
                        <td>${record.content}</td>
                        <td>${record.dateCreated.toString().substring(0, 16)}</td>
                        <td class=".warning">
                            <button type="button" class="btn btn-primary" data-toggle="modal"
                                    data-target="#myModal"
                                    onclick="dealInHand('${record.id}')">跟进</button>
                            <button type="button" class="btn btn-success "
                                    onclick="finishInHand('${record.id}')">完结</button>
                        </td>
                    </tr>
                </g:each>
            </g:if>
            </tbody>
        </table>
    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div class="box-footer clearfix">
            <g:if test="${total > 0}">
                <ul class="pagination pagination-sm pull-right">
                    <util:remotePaginate total="${total}" onSuccess="InHandLoadSuccess()"
                                         action="queryInHandComplain"
                                         params="${[query: params.query]}"
                                         update="ComplaininHand"
                                         next="下一页" prev="上一页"/>
                </ul>
            </g:if>
        </div>
    </div>
</div>


<div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <g:form name="dealComplain">
                <div class="modal-header bg-maroon-gradient">
                    <button type="button" class="close" data-dismiss="modal"><span
                            aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">处理意见</h4>
                </div>

                <div class="modal-body">
                    <div class="row">
                        <div id="inHandNotes">
                            <g:render template="complainDetails"/>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-sm-3 control-label">我的建议:</label>

                        <div class="col-sm-9">
                            <input id="currentComplainInHand" name="currentComplain" style="display: none"/>
                            <textarea rows="5" name="dealcontent" class="form-control" id="dealcontent"
                                      placeholder=""></textarea>
                        </div>

                    </div>
                </div>

                <div class="modal-footer">
                    <g:submitToRemote url="[controller: 'complain', action: 'dealComplain']" asynchronous="false"
                                      onSuccess="dealInHandSuccess()" class="btn btn-primary" value="确定"/>
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close">关闭</button>
                </div>
            </g:form>
        </div>
    </div>
</div>

