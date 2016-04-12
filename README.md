# lambert2_ruby
Converts GPS coordinates into Lambert 93 coordinates

# Install
```
# In  your gemfile
gem "lambert2_ruby"
```
And run
```
bundle install
```

# Usage
```
require "lambert2_ruby"

lat  = 44.884566             # gps_latitude
long = -0.2846110000000408   # gps_longitude

Lambert2Ruby::lambert_proj(lat, long)
```

It will give you an array with lambert2 coordinates [x, y].
