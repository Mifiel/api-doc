# Templates

## Create a Template

```ruby
require 'mifiel'

content = '<div>' \
            'Name <field name="name" type="text">NAME</field>' \
            'Date <field name="date" type="text">DATE</field>' \
          '</div>'

template = Mifiel::Template.create(
  name: 'my-company-nda', 
  description: 'Confidential disclosure agreement',
  header: '<div>some header html</div>', 
  content: content, 
  footer: '<div>some footer html</div>'
)
```

```shell
curl -X POST https://www.mifiel.com/api/v1/templates \
  -F "name=my-company-nda" \
  -F "description=Confidential disclosure agreement" \
  -F "content=<div>html content</div>" \
  -H "Authorization: APIAuth APP-ID:hmac-signature"
```

```php
<?php
require 'vendor/autoload.php';
use Mifiel\Template;

$content = '<div>' .
             'Name <field name="name" type="text">NAME</field>' .
             'Date <field name="date" type="text">DATE</field>' .
           '</div>'

$template = new Template([
  'name' => 'my-company-nda', 
  'description' => 'Confidential disclosure agreement',
  'header' => '<div>some header html</div>', 
  'content' => $content, 
  'footer' => '<div>some footer html</div>'
]);
$template->save();
?>
```

```python
from mifiel import Template, Client
client = Client(app_id='APP_ID', secret_key='APP_SECRET')

content = '<div>' +
             'Name <field name="name" type="text">NAME</field>' +
             'Date <field name="date" type="text">DATE</field>' +
           '</div>'
template = Template.create(
  client=client,
  name='my-company-nda', 
  description='Confidential disclosure agreement',
  header='<div>some header html</div>', 
  content=content, 
  footer='<div>some footer html</div>'
)
```

Templates are a tool that allows you to create templates that have a base format. You can define fields within the html so you can then create a custumized document.

<aside class="info">
  If you want the documents generated from the template to be endorsable, you must pass the attribute <b>track: true</b> and specify the type of endorsable document you'd like it to be. At the moment the only type available is promissory notes (pagarés), which you can specify by passing the attribute <b>type: 'promissory-note'</b>.
</aside>

### HTTP Request

`POST https://www.mifiel.com/api/v1/templates`

### Parameters

Field          | Type       |  Description
-------------- | ---------- | -----------
track          | Boolean    | __Optional__ true if you want your document to be endorsable
type           | String     | __Optional__ (Required if param track is true) For now, the only value is 'promissory-note' (pagaré)
name           | String     | The name of the template
description    | String     | __Optional__ Internal description of your template
header         | Text/HTML  | __Optional__ The Header of the PDF
content        | Text/HTML  | The Content of the PDF
footer         | Text/HTML  | __Optional__ The footer of the PDF

### Response

Returns a [Template Model](#template)

## Get a Specific Template

```ruby
require 'mifiel'

template = Mifiel::Template.find('29f3cb01-744d-4eae-8718-213aec8a1678')
template.name
template.header
template.content
# ...
```

```shell
curl "https://www.mfiel.com.mx/api/v1/templates/29f3cb01-744d-4eae-8718-213aec8a1678"
  -H "Authorization: APIAuth APP-ID:hmac-signature"
```

```php
<?php
require 'vendor/autoload.php';
use Mifiel\Template;

$template = Template::find('29f3cb01-744d-4eae-8718-213aec8a1678');
$template->name;
$template->header;
$template->content;
# ...
?>
```

```python
from mifiel import Template, Client
client = Client(app_id='APP_ID', secret_key='APP_SECRET')

template = Template.find(client, 'id')
template.name
template.header
template.content
# ...
```

Allows you to retrieve a specific template.

### HTTP Request

`GET https://www.mifiel.com/api/v1/templates/:id`

### Response

Returns a [Template Model](#template)

## Get All Templates

```ruby
require 'mifiel'

templates = Mifiel::Template.all
```

```shell
curl "https://www.mifiel.com/api/v1/templates"
  -H "Authorization: APIAuth APP-ID:hmac-signature"
```

```php
<?php
require 'vendor/autoload.php';
use Mifiel\Template;

$templates = Template::all();
?>
```

```python
from mifiel import Template, Client
client = Client(app_id='APP_ID', secret_key='APP_SECRET')

templates = Template.all(client)
```

Allows you to retrieve all templates in your account.

### HTTP Request

`GET https://www.mifiel.com/api/v1/templates`

### Response

Returns an Array of [Template Models](#template)

## Delete a Template

```ruby
require 'mifiel'

Mifiel::Template.delete('29f3cb01-744d-4eae-8718-213aec8a1678')
```

```shell
curl -X DELETE "https://www.mifiel.com/api/v1/templates/29f3cb01-744d-4eae-8718-213aec8a1678"
  -H "Authorization: APIAuth APP-ID:hmac-signature"
```

```php
<?php
require 'vendor/autoload.php';
use Mifiel\Template;

Template::delete('29f3cb01-744d-4eae-8718-213aec8a1678');
?>
```

```python
from mifiel import Template, Client
client = Client(app_id='APP_ID', secret_key='APP_SECRET')

Template.delete(client, '29f3cb01-744d-4eae-8718-213aec8a1678')
```

Allows you to delete a specific template in your account.

### HTTP Request

`DELETE https://www.mifiel.com/api/v1/templates/:id`

## Template fields

Get the fields of a specific template. Use it to know what to send to generate documents with this template.

```ruby
require 'mifiel'

fields = Mifiel::Template.fields('29f3cb01-744d-4eae-8718-213aec8a1678')
```

```shell
curl "https://www.mifiel.com/api/v1/templates/29f3cb01-744d-4eae-8718-213aec8a1678/fields" \
  -H "Authorization: APIAuth APP-ID:hmac-signature"
```

```php
<?php
require 'vendor/autoload.php';
use Mifiel\Template;

Template::fields('29f3cb01-744d-4eae-8718-213aec8a1678');
?>
```

```python
from mifiel import Template, Client
client = Client(app_id='APP_ID', secret_key='APP_SECRET')

fields = Template.fields(client, '29f3cb01-744d-4eae-8718-213aec8a1678')
```

> Response from Mifiel:

```json
[{
  "type": "text", 
  "name": "name",
  "value": "Miguel Rodriguez" 
}, {
  "type": "text", 
  "name": "date",
  "value": "15/8/2018"
}]
```

### HTTP Request

`GET https://www.mifiel.com/api/v1/templates/:id/fields`

### Response

Returns an array of the template fields (parsed from the HTML) where each field has the following information:

Field           | Type |  Description
--------------- | ---- | -----------
type            | String | HTML type attribute of the field
name            | String | HTML name attribute of the field
value           | String | Value which was placed between the field tag in the HTML

## Template documents

Get all the active (non deleted) documents generated from a specific template.

```ruby
require 'mifiel'

documents = Mifiel::Template.documents('29f3cb01-744d-4eae-8718-213aec8a1678')
document = documents.first
# Mifiel::Document
document.id
# "abcd1234"
document.status
# [0, "Pending"]
```

```shell
curl "https://www.mifiel.com/api/v1/templates/29f3cb01-744d-4eae-8718-213aec8a1678/documents" \
  -H "Authorization: APIAuth APP-ID:hmac-signature"
```

```python
from mifiel import Template, Client
client = Client(app_id='APP_ID', secret_key='APP_SECRET')

documents = Template.documents(client, '29f3cb01-744d-4eae-8718-213aec8a1678')
```

> Response from Mifiel:

```json
[{
  "id": "document-id",
  "file_name": "file-name.pdf",
  "status": [0, "Pending"],
  "owner": {
    "email": "signer1@email.com",
    "name": "Jorge Morales"
  },
  "file": "/api/v1/documents/.../file"
}]
```

### HTTP Request

`GET https://www.mifiel.com/api/v1/templates/:id/documents`

### Response 

Returns an array with the following information about each document: 

Field           | Type |  Description
--------------- | ---- | -----------
id              | String | ID of the document
file_name       | String | Name of the template file created
status          | Array  | [code, code_message] `0: not signed, 1: signed`
owner           | Object | The owner of the document. The user who created the document.
file            | String | Path where the original document can be downloaded

## Generate a document from a template

```ruby
require 'mifiel'

template_id = '29f3cb01-744d-4eae-8718-213aec8a1678'
name = 'My NDA'
callback_url = 'https://mypage.com'
doc = {
  fields: {
    name: 'My Client Name',
    date: 'Sep 27 2017'
  },
  signatories: [{
    name: 'Some name',
    email: 'some@email.com',
    tax_id: 'AAA010101AAA'
  }],
  callback_url: 'https://www.example.com/webhook/url',
  external_id: 'unique-id'
}
template = Mifiel::Template.create_document(template_id, name, doc, callback_url)
```

```shell
curl -X POST "https://www.mifiel.com/api/v1/templates/29f3cb01-744d-4eae-8718-213aec8a1678/generate_document" \
  -F "namme='My Client Name'" \
  -F "fields[name]=My Client Name" \
  -F "fields[date]=Sep 27 2017" \
  -F "signatories[0][name]=Some name" \
  -F "signatories[0][email]=some@email.com" \
  -F "signatories[0][tax_id]=AAA010101AAA" \
  -H "Authorization: APIAuth APP-ID:hmac-signature"
```

```python
from mifiel import Template, Client
client = Client(app_id='APP_ID', secret_key='APP_SECRET')

template_id = '29f3cb01-744d-4eae-8718-213aec8a1678'
name = 'My NDA'
doc = {
  'fields': {
    'name': 'My Client Name',
    'date': 'Sep 27 2017'
  },
  'signatories': [{
    'name': 'Some name',
    'email': 'some@email.com',
    'tax_id': 'AAA010101AAA'
  }],
  'callback_url': 'https://www.example.com/webhook/url',
  'external_id': 'unique-id'
}
document = Template.create_document(client, template_id, name, doc)
```

```php
<?php
require 'vendor/autoload.php';
use Mifiel\Template;

$template_id = '29f3cb01-744d-4eae-8718-213aec8a1678'
$name = 'My NDA'
$doc = [
  'fields': [
    'name': 'My Client Name',
    'date': 'Sep 27 2017'
  ],
  'signatories': [[
    'name': 'Some name',
    'email': 'some@email.com',
    'tax_id': 'AAA010101AAA'
  ]],
  'callback_url': 'https://www.example.com/webhook/url',
  'external_id': 'unique-id'
]

$document = Template.create_document($template_id, $name, $doc)
?>
```

### HTTP Request

`POST https://www.mifiel.com/api/v1/templates/:id/generate_document`

### Parameters

Field          | Type       |  Description
-------------- | ---------- | -----------
name           | String     | The name of the document
fields         | JSON [Hash]| A hash with the fields `{name: value}`
signatories    | Array[Signatory] | A list of [Signatory Object](#signatory)
callback_url   | String     | __Optional__ A Callback URL to post when the document gets signed
external_id    | String     | __Optional__ A unique id for you to identify the document in the response or fetch it

### Response

Returns a [Document Model](#document), if the template was created with the `tracked` param set to true, then it returns a [Tracked Document Model](#tracked-document).

## Generate several documents from a template

```ruby
require 'mifiel'

template = Mifiel::Template.new(id: '29f3cb01-744d-4eae-8718-213aec8a1678')
identifier = 'name'
callback_url = 'https://somecallback.com'
docs = [{
  fields: {
    name: 'My Client Name',
    date: 'Sep 27 2017'
  },
  signatories: [{
    name: 'Some Name',
    email: 'some@email.com',
    tax_id: 'AAA010101AAA'
  }],
  callback_url: 'https://www.my-site.com/webhook',
  external_id: 'unique-id'
}]
documents = template.create_documents(identifier: identifier, documents: docs, callback_url: callback_url)
```

The generation of documents runs in the background. We will respond with 200 (OK) and start generate the documents. When our server finishes we will POST you to the provided `callback_url` with a list of the created documents.

### HTTP Request

`POST https://www.mifiel.com/api/v1/templates/:id/generate_documents`

> Response from Mifiel:

```json
{ "status": "success" }
```

> When the documents are ready, we will send you a POST to the __callback_url__ with the following params:

```json
[{
  "id": "d6793b57-9101-4ce3-ae0d-e51868f3fdf9",
  "folio": "{asset_id}|{address}",
  "signers": [{
    "name": "Some Name",
    "email": "some@email.com",
    "tax_id": "AAA010101AAA",
    "widget_id": "d6793b57-9101-4ce3-ae0d-e51868f3fdf9"
  }],
  "file_name": "NDA-My-Client-Name.pdf",
  "callback_url": "https://www.my-site.com/webhook",
  "external_id": "unique-id"
}]
```

### Parameters

Field          | Type         |  Description
-------------- | ------------ | -----------
identifier     | String       | A field name to use in the document name e.g "name" will append the field "name" to the document name "My-NDA-My-Client-Name.pdf"
callback_url   | String       | A Callback URL to POST when all documents have been created
documents      | Array[Document] | Array of documents to create

### Documents Param

Field          | Type         |  Description
-------------- | ------------ | -----------
fields         | Hash         | Hash of key, value of each field <br>`{field_name: 'Field Content'}`
signatories    | Array[Signatory] | A list of [Signatory Object](#signatory)
callback_url   | String       | __Optional__ A Callback URL to post when the document gets signed
external_id    | String       | __Optional__ A unique id for you to identify the document in the response or fetch it
