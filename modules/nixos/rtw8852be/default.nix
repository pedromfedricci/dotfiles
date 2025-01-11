# The RTL8852BE works erratically under 5Ghz WiFi:
# https://github.com/lwfinger/rtw89/issues/214
# rtw89_8852be network card ejects randomly:
# https://github.com/lwfinger/rtw89/issues/240
# lwfinger comments:
# https://github.com/lwfinger/rtw89/issues/214#issuecomment-1406732718
# https://github.com/lwfinger/rtw89/issues/240#issuecomment-1519118474
{...}: {
  boot.extraModprobeConfig = ''
    options rtw89_pci disable_clkreq=y disable_aspm_l1=y disable_aspm_l1ss=y
    options rtw89pci disable_clkreq=y disable_aspm_l1=y disable_aspm_l1ss=y
    options rtw89_core disable_ps_mode=y
    options rtw89core disable_ps_mode=y
  '';
}
