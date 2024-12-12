// You will need to make a parameter called api_key
// Replace YOUR-INDICATOR-IDS with your own indicator IDs, with delimiter "%2C"
// You will need to replace "area", "AdministrativeWard" and "period" with relevant IDs
// "area" by default is Hartlepool | "AdminstrativeWard" by default is Hartlepool, North-East, and England | "period" by default is latest 5 years
#let
    data_obesity = let
        api_key = ApplicationKey,
    Source = Json.Document(Web.Contents("https://webservices.esd.org.uk/data.table?value.valueType=raw&metricType=YOUR-INDICATOR-IDS&area=E06000001%3AAdministrativeWard%2CE06000001%2CE12000001%2CE92000001&period=latest%3A5&columnGrouping=metricType&rowGrouping=area&ApplicationKey="&api_key)),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Expanded Column1" = Table.ExpandRecordColumn(#"Converted to Table", "Column1", {"metricTypeIdentifier", "metricTypeLabel", "metricTypeAltLabel", "metricTypeIsSummary", "areaIdentifier", "areaLabel", "areaAltLabel", "areaLongLabel", "areaIsSummary", "periodIdentifier", "periodLabel", "periodAltLabel", "periodIsSummary", "valueTypeIdentifier", "valueTypeLabel", "valueTypeIsSummary", "value", "source", "formatted", "format", "confidenceIntervalLower", "confidenceIntervalUpper", "publicationStatus"}, {"metricTypeIdentifier", "metricTypeLabel", "metricTypeAltLabel", "metricTypeIsSummary", "areaIdentifier", "areaLabel", "areaAltLabel", "areaLongLabel", "areaIsSummary", "periodIdentifier", "periodLabel", "periodAltLabel", "periodIsSummary", "valueTypeIdentifier", "valueTypeLabel", "valueTypeIsSummary", "value", "source", "formatted", "format", "confidenceIntervalLower", "confidenceIntervalUpper", "publicationStatus"}),
    #"Changed Type1" = Table.TransformColumnTypes(#"Expanded Column1",{{"periodLabel", type text}}),
    #"Renamed Columns" = Table.RenameColumns(#"Changed Type1",{{"periodLabel", "periodLabel1"}}),
    #"Added Custom" = Table.AddColumn(#"Renamed Columns", "periodLabel", each Text.Start([periodLabel1],4)),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom",{{"periodLabel", Int64.Type}}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Changed Type",{{"metricTypeIdentifier", Int64.Type}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type2",{"periodLabel"})
in
    #"Changed Type",
    #"Renamed Columns" = Table.RenameColumns(data_obesity,{{"periodLabel", "periodLabelOLD"}}),
    #"Filtered Rows" = Table.SelectRows(#"Renamed Columns", each ([value] <> "null")),
    #"Changed Type" = Table.TransformColumnTypes(#"Filtered Rows",{{"areaLabel", type text}}),
    #"Filtered Rows1" = Table.SelectRows(#"Changed Type", each true)
in
    #"Filtered Rows1"
