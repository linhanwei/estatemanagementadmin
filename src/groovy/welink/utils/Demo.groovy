package welink.utils

import groovy.xml.MarkupBuilder

/**
 * Created by saarixx on 23/9/14.
 */

PrintWriter writer = new PrintWriter(System.out)

def xml = new MarkupBuilder(writer)
xml.'rec:records'('xmlns:rec': 'http://groovy.codehaus.org') {
    car(name: 'HSV Maloo', make: 'Holden', year: 2006) {
        country('Australia')
        record(type: 'speed', ' Truck with speed of 271kph')
        fuck()
    }
}


