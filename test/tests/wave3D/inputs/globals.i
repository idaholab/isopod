# Non-SI units: mm, mg, ms, mN

push_id         = 1
freq_id         = 4
frequencyKHz    = 0.400
relaxation_time = 0.3


elemtype3D = HEX8
elemorder3D = FIRST

# TODO - push is frequency dependent, so maybe we should have weights based on freq
ARFx =  -6
ARFy =  0
ARFz =  0
ARFxw = 0.5
ARFyw = 0.5
ARFzw = 0.5

rho           = 1

nu            = 0.499
locking       = true
# quad_order    = fifth # This is not the number of Gauss points by the order of function to be integrated


nelem         = 40 # CAUTION: requires more than 1 element for grad check for coarsest parametrization
                   # may require even finer meshes for finer parametrization

omega         = ${fparse 2*3.14159265359*frequencyKHz}
_rhow2        = ${fparse -rho*omega*omega}
ve_factor     = ${fparse relaxation_time * omega}

Gbr = 1  # kPa = mg/mm/ms^2
Gbi = ${fparse Gbr*ve_factor}

wave_ratio = ${fparse sqrt((2-2*nu)/(1-2*nu))}
Lbr = ${fparse Gbr * wave_ratio^2}
Lbi = ${fparse Gbi * wave_ratio^2}

Zsr = ${fparse -omega * sqrt(rho*Gbr)}
Zsi = ${fparse -omega * sqrt(rho*Gbi)}
Znr = ${fparse -omega * sqrt(rho*Lbr)}
Zni = ${fparse -omega * sqrt(rho*Lbi)}

_Znrr = ${fparse  Zni}
_Znri = ${fparse -Znr}
_Znir = ${fparse  Znr}
_Znii = ${fparse  Zni}

_Zsrr = ${fparse  Zsi}
_Zsri = ${fparse -Zsr}
_Zsir = ${fparse  Zsr}
_Zsii = ${fparse  Zsi}
