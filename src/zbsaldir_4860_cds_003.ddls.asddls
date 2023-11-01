@AbapCatalog.sqlViewName: 'ZBSALDIR_CDS_003'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Section 2 - CDS 2'
define view ZBSALDIR_4860_CDS_003
  as select from ZBSALDIR_4860_CDS_002 as zbs
    inner join   vbrk on zbs.vbeln = vbrk.vbeln
{
  zbs.vbeln,
  sum( zbs.conversion_netwr )                                                                            as toplam_net_deger,
  zbs.kunnrAd                                                                                            as musteri_ad_soyad,
  count( * )                                                                                             as toplam_fatura_adedi,
  division( cast( sum( zbs.conversion_netwr ) as abap.curr( 20, 3 )), cast( count( * ) as abap.int4), 3) as ortalama_miktar,
  substring(zbs.fkdat, 1, 4)                                                                             as faturalama_yili,
  substring(zbs.fkdat, 5, 2)                                                                             as faturalama_ayi,
  substring(zbs.fkdat, 7, 2)                                                                             as faturalama_gunu,
  substring(vbrk.inco2_l, 1, 3)                                                                          as incoterm_yeri

}
group by
  zbs.vbeln,
  zbs.kunnrAd,
  zbs.fkdat,
  vbrk.inco2_l
