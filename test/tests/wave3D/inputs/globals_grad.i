# Non-SI units: mm, mg, ms, mN

#######################
### Check modulus.i ###
#######################
 
id            = 1
frequencyKHz  = 0.100

rho           = 1
nu            = 0.3
dlambda_dmu   = ${fparse 2*nu/(1-2*nu)}
locking       = False  # Locking true works fine as well
# Something else seems to be imprecise for incompressibility
#nu            = 0.49999 # INCOMPRESSIBLE
#dlambda_dmu   = -3
#locking       = True

nelem         = 2
ve_factor     = 2e-10

omega         = ${fparse 2*3.14159265359*frequencyKHz}
_rhow2        = ${fparse -rho*omega*omega}

Gbr = 1  # kPa = mg/mm/ms^2
Gbi = ${fparse Gbr * ve_factor}

wave_ratio = ${fparse 1600/sqrt(Gbr)}
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
