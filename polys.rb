module PolyIntersec
  class << self
    def pi_line_intersec(
      v1x1, v1y1, v1x2, v1y2,
      v2x1, v2y1, v2x2, v2y2
    )
      a1 = v1y2 - v1y1
      b1 = v1x1 - v1x2
      c1 = (v1x2 * v1y1) - (v1x1 * v1y2)

      d1 = (a1 * v2x1) + (b1 * v2y1) + c1
      d2 = (a1 * v2x2) + (b1 * v2y2) + c1

      return false if d1 > 0 && d2 > 0
      return false if d1 < 0 && d2 < 0

      a2 = v2y2 - v2y1
      b2 = v2x1 - v2x2
      c2 = (v2x2 * v2y1) - (v2x1 * v2y2)

      d1 = (a2 * v1x1) + (b2 * v1y1) + c2
      d2 = (a2 * v1x2) + (b2 * v1y2) + c2

      return false if d1 > 0 && d2 > 0
      return false if d1 < 0 && d2 < 0

      return false if (a1 * b2) - (a2 * b1) == 0

      return true
    end

    def pi_test_point_rect_aabb_col(
      px, py,
      rx, ry, rex, rey
    )
      return (px >= rx) &&
             (py >= ry) &&
             (px <= rex) &&
             (py <= rey)
    end

    def in_poly?(point, poly)
      return false if poly.length < 3

      fst = poly[0]

      maxx = minx = fst.x
      maxy = miny = fst.y

      l = poly.length
      i = 1

      while i < l
        ce = poly[i]
        cx = ce.x
        cy = ce.y

        minx = cx if cx < minx
        maxx = cx if cx > maxx

        miny = cy if cy < miny
        maxy = cy if cy > maxy

        i += 1
      end

      ptx = point.x
      pty = point.y

      return false if !pi_test_point_rect_aabb_col(ptx, pty,
                                                   minx, miny,
                                                   maxx, maxy)

      ppx = minx - 1
      ppy = miny - 1

      collisions = 0

      i = 0

      lst = poly[-1]

      lx = lst.x
      ly = lst.y

      while i < l
        el = poly[i]
        nx = el.x
        ny = el.y

        collisions += 1 if pi_line_intersec(ppx, ppy, ptx, pty,
                                            lx, ly, nx, ny)

        lx = nx
        ly = ny
        i += 1
      end

      return collisions.odd?
    end
  end
end
