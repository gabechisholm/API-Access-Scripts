// You will need to make a parameter called api_key
#let
    data_obesity = let
        api_key = ApplicationKey,
    Source = Json.Document(Web.Contents("https://webservices.esd.org.uk/data.table?value.valueType=raw&metricType=10269%2C10270%2C10271%2C10272%2C10349%2C10350%2C10351%2C10352%2C10353%2C10354%2C10355%2C10356%2C10357%2C10358%2C10361%2C10362%2C10392%2C10393%2C10394%2C10395%2C10396%2C10397%2C15446%2C15447%2C17866%2C19595%2C19596%2C19598%2C19599%2C19600%2C19601%2C19602%2C19603%2C19604%2C19605%2C19606%2C19655%2C19656%2C19657%2C19658%2C19966%2C19967%2C19990%2C19991%2C19992%2C19993%2C19994%2C19995%2C21476%2C21477%2C22311%2C22312%2C22313%2C22314%2C22315%2C22316%2C22317%2C22318%2C22319%2C22320%2C22321%2C22322%2C22323%2C22324%2C22325%2C22326%2C22327%2C22328%2C22329%2C22330%2C3333%2C3334%2C5165%2C5166%2C5167%2C5168%2C5169%2C5170%2C5171%2C5172%2C5173%2C5174%2C5175%2C5176%2C888%2C889%2C5157%2C17145%2C17147%2C17146%2C11063%2C3179%2C3181%2C3177%2C3178%2C3180%2C10871%2C3347%2C3345%2C3344%2C3229%2C3197%2C3239%2C3200%2C3241%2C3199&area=E06000001%3AAdministrativeWard%2CE06000001%2CE12000001%2CE92000001&period=latest%3A5&columnGrouping=metricType&rowGrouping=area&ApplicationKey="&api_key)),
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
