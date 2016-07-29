package com.welink.commons;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static com.welink.commons.Utils.generateToken;
import static com.welink.commons.Utils.validate;
import static org.hamcrest.core.Is.is;
import static org.junit.Assert.*;

/**
 * Created by saarixx on 28/4/15.
 */
public class UtilsTest {

    @Before
    public void setUp() throws Exception {

    }

    @After
    public void tearDown() throws Exception {

    }

    @Test
    public void testSubList() throws Exception {

    }

    @Test
    public void testGenerateToken() throws Exception {
        assertThat(generateToken(), is(generateToken()));
        assertThat(validate(generateToken()), is(true));
        String s = generateToken();
        Thread.sleep(5000);
        assertThat(validate(s), is(false));
    }

    @Test
    public void testValidate() throws Exception {

    }
}