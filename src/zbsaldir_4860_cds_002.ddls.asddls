@AbapCatalog.sqlViewName: 'ZBSALDIR_CDS_002'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Section 2 - CDS 1'
define view ZBSALDIR_4860_CDS_002 as select from vbrp
inner join vbrk on vbrp.mandt = vbrk.mandt
               and vbrp.vbeln = vbrk.vbeln
inner join mara on vbrp.mandt = mara.mandt
               and vbrp.matnr = mara.matnr
left outer join vbak on vbrp.mandt = vbak.mandt
                    and vbrp.aubel = vbak.vbeln
left outer join kna1 on vbrp.mandt = kna1.mandt
                    and vbak.kunnr = kna1.kunnr
left outer join makt on vbrp.mandt = makt.mandt
                    and mara.matnr = makt.matnr
                    and makt.spras = $session.system_language
                    
{
    vbrp.vbeln,
    vbrp.posnr,
    vbrp.aubel,
    vbrp.aupos,
    vbak.kunnr,
    concat_with_space( kna1.name1, kna1.name2, 1 ) as kunnrAd,
    currency_conversion(amount => vbrp.netwr, 
                        source_currency => vbrk.waerk, 
                        target_currency => cast('EUR' as abap.cuky), 
                        exchange_rate_date => vbrk.fkdat) as conversion_netwr,
    left(vbak.kunnr, 3) as left_kunnr,
    length(vbrp.matnr) as matnr_length,
    case vbrk.fkart when 'FAS' then 'Peşinat talebi iptali'
                    when 'FAZ' then 'Peşinat talebi'
                    else 'Fatura' end as faturalama_turu,
    vbrk.fkdat
}
