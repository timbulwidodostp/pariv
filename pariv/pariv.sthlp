{smcl}
{* *! version 1.0.0 19July2022}{...}
{cmd:help pariv}{right: ({browse "https://doi.org/10.1177/1536867X241233668":SJ24-1: st0741})}
{hline}

{title:Title}

{p2colset 5 14 16 2}{...}
{p2col :{cmd:pariv} {hline 2}}Nearly collinear robust instrumental-variables regression{p_end}


{title:Syntax}

{p 8 13 2}
{cmd:pariv} {depvar} {cmd:(}{it:{help varlist:endovars}} {cmd:=} 
{it:{help varlist:excludedinst}}{cmd:)} [{it:{help varlist:includedinst}}]
{ifin} {weight}
[{cmd:,} {it:options}]

{synoptset 20}{...}
{synopthdr}
{synoptline}
{synopt:{opt nocons:tant}}suppress constant term{p_end}
{synopt:{opth absorb(varname)}}fixed effects for {it:varname}{p_end}
{synopt:{opt small}}finite-sample adjustment of standard errors and degrees-of-freedom adjustments of {it:p}-values{p_end}
{synopt:{opt robust}}heteroskedasticity-robust conventional standard errors{p_end}
{synopt:{opth cluster(varname)}}clustered conventional standard errors{p_end}
{synopt:{opt reps(#)}}number of permutations of data and variable order; default is {cmd:reps(0)}{p_end}
{synopt:{opt seed(#)}}set random-number seed to {it:#}; default is {cmd:seed(1)}{p_end}
{synoptline}


{title:Description}

{pstd}
{cmd:pariv} fits a partitioned two-stage least-squares (2SLS) regression of
{depvar} on {it:{help varlist:endovars}}, {it:{help varlist:includedinst}}, and
(if specified) fixed effects for {it:varname} using
{it:{help varlist:excludedinst}} (as well as {it:{help varlist:includedinst}}
and any fixed effects) as instruments for {it:{help varlist:endovars}}.  The
partitioned regression is more robust to near collinearity among the
instruments than the procedures used by Stata commands such as
{cmd:ivregress}.  For details, see Young (2024).

{pstd}
{cmd:pariv} reports the maximum R-squared found in regressing any one
instrument on the others.  In Stata's built-in 2SLS commands {cmd:ivregress}
and {cmd:xtivreg}, maximum R-squared values in excess of 0.99999 may generate
substantive sensitivity to econometrically irrelevant procedures such as the
reordering of the data and variables.  {cmd:pariv} is much less sensitive to
near collinearity, but to check that reported results are robust to this
issue, the user can call for {opt reps()} > 0 random permutations of data and
variable order.  {cmd:pariv} will report the minimum to maximum range of the
coefficient and standard error estimates of the partitioned 2SLS regression
across these permutations.  If the minimum and maximum are the same, the user
can be confident that the reported results are not sensitive to near
collinearity.  If the user does not provide a random number {cmd:seed()}, the
seed is set to 1.  Regardless, the seed is restored to its preprogram value on
termination.


{title:Stored results}

{pstd}
{cmd:pariv} stores the following in {cmd:e()}:

{synoptset 10 tabbed}{...}
{p2col 5 10 12 2: Matrices}{p_end}
{synopt:{cmd:e(Res)}}results table in matrix form{p_end}
{synopt:{cmd:e(ResB)}}coefficient estimates for each random permutation of data and variable order{p_end}
{synopt:{cmd:e(ResSE)}}standard error estimates for each random permutation of data and variable order{p_end}
{synopt:{cmd:e(R2max)}}maximum R-squared found in regressing one instrument on the others{p_end}

{title:Example}

{pstd}
import excel "https://raw.githubusercontent.com/timbulwidodostp/pariv/main/pariv/pariv.xlsx", sheet("Sheet1") firstrow clear{break}
qui ivregress 2sls y (t = z) age age2 age3 age4, robust{break}
qui ivregress 2sls y (t = z) age4 age age2 age3, robust{break}
pariv y (t = z) age4 age age2 age3, robust reps(100)

{title:Reference}

{phang}
Young, A. 2024. Nearly collinear robust procedures for 2SLS estimation.
{it:Stata Journal} 24: 93-112.
{browse "https://doi.org/10.1177/1536867X241233668"}.


{title:Author}
	
{pstd}
Alwyn Young{break}
London School of Economics{break}
London, U.K.{break}
a.young@lse.ac.uk

{pstd}
Timbul Widodo{break}
Olah Data Semarang{break}
https://www.youtube.com/@amalsedekah

{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 24, number 1: {browse "https://doi.org/10.1177/1536867X241233668":st0741}{p_end}
