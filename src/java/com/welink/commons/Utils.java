package com.welink.commons;

import com.google.common.base.Charsets;
import com.google.common.collect.Iterators;
import com.google.common.collect.Lists;
import com.google.common.hash.HashCode;
import com.google.common.hash.HashFunction;
import com.google.common.hash.Hashing;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import javax.annotation.Nonnegative;
import javax.annotation.Nonnull;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

/**
 * Created by saarixx on 25/3/15.
 */
public class Utils {

    public static DateTimeFormatter DAY_FORMATTER = DateTimeFormat.forPattern("yyyy-MM-dd");

    public static DateTimeFormatter SECOND_FORMATTER = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss");

    public static DateTimeFormatter Minute_FORMATTER = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm");

    public static <T> List<T> subList(@Nonnull List<T> list,
                                      @Nonnegative int offset,
                                      @Nonnegative int limit) {
        Iterator<T> iterator = list.iterator();
        if (offset == Iterators.advance(iterator, offset)) {
            return Lists.newArrayList(Iterators.limit(iterator, limit));
        }
        return Collections.emptyList();
    }


    public static String DEFAULT_REST_TOKEN_SEED = "keep it real";

    public static String generateToken() {

        HashFunction hf = Hashing.md5();
        HashCode hc = hf.newHasher()
                .putLong(new Date().getTime() / 1000)
                .putString(DEFAULT_REST_TOKEN_SEED, Charsets.UTF_8)
                .hash();

        return hc.toString();
    }


    public static boolean validate(String token) {

        if (StringUtils.isBlank(token)) {
            return false;
        }

        for (int i = -2; i <= 2; i++) {

            HashFunction hf = Hashing.md5();
            HashCode hc = hf.newHasher()
                    .putLong(i + new Date().getTime() / 1000)
                    .putString(DEFAULT_REST_TOKEN_SEED, Charsets.UTF_8)
                    .hash();

            if (token.equals(hc.toString())) {
                return true;
            }
        }

        return false;
    }
}