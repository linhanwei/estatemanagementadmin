package api

import com.welink.commons.Utils
import grails.converters.JSON
import org.joda.time.DateTime
import welink.user.Employee

class OpenUserController {

    static lazyInit = false

    def userLogin = {
        response.setContentType("application/json;charset=UTF-8")

        def ret = [:]

        if (!Utils.validate(params.token)) {
            ret.code = 0
            ret.message = "token 校验失败"

            render ret as JSON
            return
        }

        Employee employee = Employee.findByMobile(params.phone)


        if (employee) {

            def data = [:]
            data.name = employee.name
            data.mobile = employee.mobile
            switch (employee.role[0].id) {
                case 13:
                    data.role = 1;
                    break;
                case 18:
                    data.role = 2;
                    break;
                case 19:
                    data.role = 3;
                    break;
                case 17:
                    data.role = 4;
                    break;
                default:
                    data.role = -1;
                    break;
            }

            data.dateCreated = new DateTime(employee.dateCreated).toString(Utils.SECOND_FORMATTER)
            ret.code = 1
            ret.message = ""
            ret.data = data
            render ret as JSON
        } else {
            ret.code = 0
            ret.message = "用户不存在"

            render ret as JSON
        }
    }
}
