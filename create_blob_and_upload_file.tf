# Create a blob and uploade a file in it
# This code creates a blob in the specified storage account and container, and uploads a local file to it. The blob is named "my-awesome-content.zip" and is of type "Block". The source file to be uploaded is "some-local-file.zip". The storage account and container are referenced from the previously created resources.
# The blob will be private by default, meaning it won't be publicly accessible. The "Block" type indicates that the blob is a block blob, which is suitable for storing large amounts of unstructured data, such as text or binary data.


resource "azurerm_storage_blob" "peter_blob" {
  name                   = "my_awesome_content.jpg"
  storage_account_name   = azurerm_storage_account.storageaccount.name
  storage_container_name = azurerm_storage_container.sa_container.name
  type                   = "Block"
  source                 = "test_image.jpg"
}
