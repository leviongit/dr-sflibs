module Transitions
  module_function def wipe(t,
                           width,
                           height,
                           color: { r: 0, g: 0, b: 0, a: 255 },
                           easing_fn: ->(x) { x })
    {
      x: 0,
      y: 0,
      w: easing_fn[t] * width,
      h: height,
      **color,
      path: :pixel
    }
  end

  module_function def wipelr(
    t,
    width,
    height,
    color: { r: 0, g: 0, b: 0, a: 255 },
    easing_fn: ->(x) { x }
                      )
    hw = width / 2
    t1 = easing_fn[t]
    fw = hw * t1
    [
      {
        x: 0,
        y: 0,
        w: fw,
        h: height,
        **color,
        path: :pixel,
      },
      {
        x: width - fw,
        y: 0,
        w: fw,
        h: height,
        **color,
        path: :pixel
      }
    ]
  end
end
