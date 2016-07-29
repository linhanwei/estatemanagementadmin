import grails.test.AbstractCliTestCase

class ConsoleTests extends AbstractCliTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testConsole() {

        execute(["console"])

        assertEquals 0, waitForProcess()
        verifyHeader()
    }
}
