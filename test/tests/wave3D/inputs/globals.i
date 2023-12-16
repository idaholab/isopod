id = 1
freq = 600
omega = '${fparse 2*3.14159265359*freq}'

rho = 1

omega_bar = 150000 # Gcomplex = G*(1+i*omega/omega_bar)
wave_ratio = ${fparse 1600/2}

Gbr = 16.0
Gbi = ${fparse Gbr * omega/omega_bar}
Lbr = ${fparse Gbr * wave_ratio^2}
Lbi = ${fparse Gbi * wave_ratio^2}

Zsr = ${fparse -omega * sqrt(rho*Gbr)}
Zsi = ${fparse  omega * sqrt(rho*Gbi)}
Znr = ${fparse -omega * sqrt(rho*Lbr)}
Zni = ${fparse  omega * sqrt(rho*Lbi)}

_Znrr = ${fparse  Znr}
_Znri = ${fparse -Zni}
_Znir = ${fparse  Zni}
_Znii = ${fparse  Znr}

_Zsrr = ${fparse  Zsr}
_Zsri = ${fparse -Zsi}
_Zsir = ${fparse  Zsi}
_Zsii = ${fparse  Zsr}

_rhow2 = '${fparse -rho*omega*omega}'
