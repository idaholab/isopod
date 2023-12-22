##########################################
### THE STRUCTURE IS PRETTY MUCH FINAL ###
##########################################
### UNITS (LMTF) are mm, mg, ms, mN    ###
##########################################

id    = 1
frequencyKHz  = 1.400 # kHz
omega ='${fparse 2*3.14159265359*frequencyKHz}'

rho = 1 # mg/mm^3
omega_bar = '${fparse 1e13*omega}'
nu = 0.4                             # TODO - change this to 0.4999999
                                           # TODO - faciliate ABCs afterwards
#Gbr = 8.3333  # mg/mm/ms^2
#Gbi = ${fparse Gbr * omega/omega_bar}

#wave_ratio = ${fparse 1600/sqrt(Gbr)}
#Lbr = ${fparse Gbr * wave_ratio^2}
#Lbi = ${fparse Gbi * wave_ratio^2}
#
#Zsr = ${fparse -omega * sqrt(rho*Gbr)}
#Zsi = ${fparse -omega * sqrt(rho*Gbi)}
#Znr = ${fparse -omega * sqrt(rho*Lbr)}
#Zni = ${fparse -omega * sqrt(rho*Lbi)}
#
#_Znrr = ${fparse  Zni}
#_Znri = ${fparse -Znr}
#_Znir = ${fparse  Znr}
#_Znii = ${fparse  Zni}
#
#_Zsrr = ${fparse  Zsi}
#_Zsri = ${fparse -Zsr}
#_Zsir = ${fparse  Zsr}
#_Zsii = ${fparse  Zsi}

_rhow2 = '${fparse -rho*omega*omega}'
