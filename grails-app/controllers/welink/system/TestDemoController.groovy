package welink.system

import welink.estate.Community
import welink.user.Employee

class TestDemoController {

    def index() {
        LinkedList<Community> communityList = Community.createCriteria().list {
            order("id", "asc")
        }

        LinkedList<Employee> courierList = Employee.createCriteria().list {
            eq('status', 1 as byte)
            order("id", "asc")
        }

        return [
                communityList:communityList,
                courierList:courierList
        ]
    }
}
