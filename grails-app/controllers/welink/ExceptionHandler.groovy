package welink

import org.slf4j.Logger
import org.slf4j.LoggerFactory

/**
 * Created by saarixx on 26/3/15.
 */
class ExceptionHandler {

    static Logger logger = LoggerFactory.getLogger(ExceptionHandler)

    def handleSQLException(Exception e) {
        // handle SQLException
        logger.error(e.getMessage(), e)
    }
}
