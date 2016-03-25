# -*- encoding : utf-8 -*-
module Lambert2Ruby

  def self.lambert_proj(lat, long)
    if lat.nil? || long.nil?
      return ['', '']
    else
      lat = deg_to_rad(lat.to_f)
      long = deg_to_rad(long.to_f)
      teta = n_lambert * (long - lambert_parameters[:lng_0])
      rho_lat = rho(lat)
      rho_lat_0 = rho(lambert_parameters[:lat_0])
      x = lambert_parameters[:x_0] + rho_lat * Math.sin(teta)
      y = lambert_parameters[:y_0] + rho_lat_0 - rho_lat * Math.cos(teta)
      return [x, y]
    end
  end

  private

    def self.lambert_parameters
      return @lambert_parameters if @lambert_parameters
      a = 6378137
      f = 1.0 / 298.257222101
      b = a * (1.0 - f)
      e = Math.sqrt(a**2 - b**2) / a
      @lambert_parameters = {
        # Lambert 93 consMath.tants:
        a: a,
        f: f,
        b: b,
        e: e,
        e_2: (e / 2),
        lng_0: deg_to_rad(3),
        lat_0: deg_to_rad(46.5), #deg_to_rad(52)
        x_0: 700000,
        y_0: 6600000,

        phi_1: deg_to_rad(44), #deg_to_rad(45.89888888888889)
        phi_2: deg_to_rad(49) #deg_to_rad(47.69583333333333)
      }
    end

    def self.deg_to_rad(deg)
      deg * Math::PI / 180.0
    end

    def self.rho(phi)
      first_part = 1.0 / Math.tan( phi / 2.0 + Math::PI / 4.0 )
      second_part = ( ( 1 + lambert_parameters[:e] * Math.sin(phi) ) / ( 1 - lambert_parameters[:e] * Math.sin(phi) ) )**lambert_parameters[:e_2]
      rho_phi = rho_0 * ( first_part * second_part )**n_lambert
      return rho_phi
    end

    def self.n_lambert
      return @n_lambert if @n_lambert
      n_numerator = Math.log(Math.cos(lambert_parameters[:phi_2]) / Math.cos(lambert_parameters[:phi_1]))  +  0.5 * Math.log( (1.0 - (lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_1]))**2.0 ) / (1.0 - (lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_2]))**2.0  )  )

      n_denominator_numerator = Math.tan(lambert_parameters[:phi_1] / 2.0 + Math::PI / 4.0) * (1.0 - lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_1]))**lambert_parameters[:e_2] * (1.0 + lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_2]))**lambert_parameters[:e_2]
      n_denominator_denominator = Math.tan(lambert_parameters[:phi_2] / 2.0 + Math::PI / 4.0) * (1.0 + lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_1]))**lambert_parameters[:e_2] * (1.0 - lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_2]))**lambert_parameters[:e_2]

      n_denominator = Math.log(n_denominator_numerator / n_denominator_denominator)

      @n_lambert = n_numerator / n_denominator

      return @n_lambert
    end

    def self.rho_0
      return @rho_0 if @rho_0
      rho_0_part_1 = (lambert_parameters[:a] * Math.cos(lambert_parameters[:phi_1])) / (n_lambert * Math.sqrt(1.0 - (lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_1]))**2.0 ))
      rho_0_part_2 = (Math.tan(lambert_parameters[:phi_1] / 2.0 + Math::PI / 4.0) * ((1.0 - lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_1])) / (1.0 + lambert_parameters[:e] * Math.sin(lambert_parameters[:phi_1])) )**lambert_parameters[:e_2] )**n_lambert

      @rho_0 = rho_0_part_1 * rho_0_part_2

      return @rho_0
    end
end
