$serverName = "LAPTOP-CNIM3EMA\SQLEXPRESS"    
$databaseName = "master"  # Replace with your actual database name
$username = "WissalBekhti"          # Replace with your SQL Server username
$password = "--"          # Replace with your SQL Server password

# Connection string with credentials
$connectionString = "Server=$serverName;Database=$databaseName;User Id=$username;Password=$password;"

# SQL query
$storedProcedureCall = @"
    SELECT *
    FROM TableX
"@

# Create SqlConnection
$sqlConnection = new-object System.Data.SqlClient.SqlConnection
$sqlConnection.ConnectionString = $connectionString

# Create SqlCommand
$sqlCommand = New-Object System.Data.SqlClient.SqlCommand
$sqlCommand.Connection = $sqlConnection
$sqlCommand.CommandText = $storedProcedureCall
$sqlCommand.CommandTimeout = 0; 
# Create SqlDataAdapter
$sqlAdapter = new-object System.Data.SqlClient.SqlDataAdapter
$sqlAdapter.SelectCommand = $sqlCommand

# Create DataSet
$dataSet = new-object System.Data.DataSet

# Execute query and fill DataSet
$recordCount = $sqlAdapter.Fill($dataSet)

# Close connection
$sqlConnection.Close()

# Retrieve data
$data = $dataSet.Tables[0]

# Create an array to store information
$payloadArray = @()

foreach ($row in $data) {
    $endpoint = "https://api.powerbi.com/beta/93401443-f80a-4526-932b-487074bef423/datasets/d845aea7-8a93-49b2-9a87-d8a18b03f8f9/rows?experience=power-bi&clientSideAuth=0&key=jxtZVtnZdOaiLEnOexo%2FbUfaWTFmqZMXokszNUkxx9r6CTHi9xNnepofT2JLT6EJ0jdQzw45u4x4URowLBOEOQ%3D%3D"
    
    # Create payload for each row
    $payload = @{
        "Sample"   = $row.Sample
        "x"        = $row.x
        "1-Q1"     = $row.'1-Q1'
        "1-Q3"    = $row.'1-Q3'
        "Delta Q0" = $row.'Delta Q0'
        "N"        = $row.N
    }

    # Add payload to the array
    $payloadArray += $payload

    # Send the current payload to the API
    Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload))
}




