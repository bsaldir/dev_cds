@AbapCatalog.sqlViewName: 'ZBSALDIR_CDS_001'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS-1'
define view ZBSALDIR_4860_CDS_001
  as select from    ekko
    inner join      ekpo on ekko.ebeln = ekpo.ebeln
    inner join      mara on ekpo.matnr = mara.matnr
    left outer join makt on  mara.matnr = makt.matnr
                         and makt.spras = $session.system_language
    inner join      lfa1 on ekko.lifnr = lfa1.lifnr
{
  ekpo.ebeln,
  ekpo.ebelp,
  ekpo.matnr,
  makt.maktx,
  ekpo.werks,
  ekpo.lgort,
  ekpo.meins,
  lfa1.lifnr,
  lfa1.name1,
  concat( lfa1.stras, lfa1.mcod3 ) as satici_adresi
}
