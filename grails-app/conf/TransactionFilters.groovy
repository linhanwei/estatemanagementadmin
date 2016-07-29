class TransactionFilters {

    def sessionFactory

    def filters = {
        all(controller: '*', action: '*') {
            before = {
//                sessionFactory.getCurrentSession().beginTransaction()
            }
            after = { Map model ->

            }
            afterView = { Exception e ->

            }
        }
    }
}
