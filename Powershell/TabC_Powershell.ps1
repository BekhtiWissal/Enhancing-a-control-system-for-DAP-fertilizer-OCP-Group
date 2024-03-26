# Connection parameters
$serverName = "LAPTOP-CNIM3EMA\SQLEXPRESS"    
$databaseName = "master" 
$username = "WissalBekhti"         
$password = "--"        

# Connection string with credentials
$connectionString = "Server=$serverName;Database=$databaseName;User Id=$username;Password=$password;"

# SQL query
$storedProcedureCall = @"
    SELECT *
    FROM TabC
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

foreach($row in $data)
{
$endpoint = "https://api.powerbi.com/beta/93401443-f80a-4526-932b-487074bef423/datasets/478cdf9b-c8dd-4bad-b51b-fa0fdd033a6f/rows?experience=power-bi&clientSideAuth=0&key=KwjCv5U0KOA3YEB3dcobpP9lkE%2FWTCPR7YKtYItG7pcBtRizcXC0zPT2JZ%2FZwkWFJ59XU9kHzT1YAs9l%2Ff95NQ%3D%3D"

$payload = @{
"Sample" = $row.Sample
"C" =$row.C
"Q3" =$row.Q3
"Delta Q3" =$row.'Delta Q3'
"Q2" =$row.Q2
"N" =$row.N
}
Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload))

} 