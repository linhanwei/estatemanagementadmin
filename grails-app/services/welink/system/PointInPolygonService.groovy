package welink.system

import com.google.common.collect.Lists
import com.vividsolutions.jts.geom.*
import com.vividsolutions.jts.geom.impl.CoordinateArraySequence
import org.apache.commons.lang3.StringUtils

import static com.google.common.base.Preconditions.checkArgument
import static org.apache.commons.lang3.StringUtils.isNotBlank

class PointInPolygonService {

    public boolean isIn(String point, String polygon) {
        checkArgument(isNotBlank(polygon));
        checkArgument(isNotBlank(point));

        final GeometryFactory gf = new GeometryFactory();

        final List<Coordinate> points = Lists.newArrayList();

        String[] split = StringUtils.split(polygon, ',');

        checkArgument(split.length >= 6);
        checkArgument(split.length % 2 == 0);

        for (int i = 0; i < split.length / 2; i++) {
            double e = Double.parseDouble(split[2 * i]);
            double n = Double.parseDouble(split[2 * i + 1]);
            points.add(new Coordinate(n, e));
        }

        // points of linear ring do not form a closed linestring
        points.add(points.get(0));

        final Polygon gfPolygon = gf.createPolygon(new LinearRing(new CoordinateArraySequence(points.toArray(new Coordinate[points.size()])), gf), null);

        String[] lbs = StringUtils.split(point, ',');
        checkArgument(lbs.length == 2);
        double e = Double.parseDouble(lbs[0]);
        double n = Double.parseDouble(lbs[1]);
        final Coordinate coord = new Coordinate(n, e);
        final Point p = gf.createPoint(coord);

        return p.within(gfPolygon);
    }
}
