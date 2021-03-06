# Objects

Mifiel data is structured around 3 main types of objects: Document, Certificate and Signature. You’ll find these objects in the format described below.

<aside class="info">
  The <b>Date</b> type is always in <b>Coordinated Universal Time (UTC)</b>.
</aside>

## Document

Contains information about the PDF file being signed

```json
{
  "id": "29f3cb01-744d-4eae-8718-213aec8a1678",
  "original_hash": "e1a580c27d22b4...c537bf90282a6889da",
  "file_file_name": "test-pdf.pdf",
  "signed_by_all": true,
  "signed": true,
  "signed_at": "2016-01-19T16:34:37.921Z",
  "status": [1, "Firmado"],
  "owner": {
    "email": "signer1@email.com",
    "name": "Jorge Morales"
  },
  "callback_url": "https://www.example.com/webhook/url",
  "file": "/api/v1/documents/.../file",
  "file_download": "/api/v1/documents/.../file?download=true",
  "file_signed": "/api/v1/documents/.../file_signed",
  "file_signed_download": "/api/v1/documents/.../file_signed?download=true",
  "file_zipped": "/api/v1/documents/.../zip",
  "signatures": [{
    "email": "signer1@email.com",
    "signed": true,
    "signed_at": "2016-01-19T16:34:37.887Z",
    "certificate_number": "20001000000200001410",
    "tax_id": "AAA010101AAA",
    "signature": "77cd5156779c..4e276ef1056c1de11b7f70bed28",
    "user": {
      "email": "signer1@email.com",
      "name": "Jorge Morales"
    }
  }],
  "widget_id": "ABCD1234"
}

```

Field           | Type |  Description
--------------- | ---- | -----------
id              | String | 
original_hash   | String | Hash of the original (unsigned) document
file_file_name  | String | Name of the uploaded file
signed_by_all   | Boolean | `true` if all signers have signed the document
signed_at       | Date | Timestamp of date signed (when all signatures have been collected)
already_signed  | String[] | People that have signed
has_not_signed  | String[] | People that have not signed
status          | Array | [code, code_message] `0: not signed, 1: signed`
owner           | Object | The owner of the document. The user who created the document.
callback_url    | String | The callback URL to be `POST`ed when everybody signs
file            | String | Path where the original document can be downloaded
file_signed     | String | Path where the signed file can be downloaded
file_zipped     | String | Path where the file and signed file in a zip file can be downloaded 
signatures      | Object[] | Array of a [Signature Model](#signature)
external_id     | String   | A unique id for you to identify the document in the response or fetch it

## Endorsable Document

```json
{
  "tracked": true,
  "type": "promissory-note",
  "transferable": true,
  "asset": {
      "id": "f48732f18l67612427c889ae08789032",
      "address": "2N2o6xjB1K5uhjg4Zaj8z9EbnGyrqQazpwX"
  }
}
```

An endorsable document is a specific type of document whose ownership can be transferred from one person or party to another. Some examples are promissory notes (pagarés), titles (títulos), or invoices (facturas).

You can know if a document is endorsable by checking the <b>tracked</b> parameter. It will be <b>true</b> if a document pertains to this category.

Contains the same information as the [Document Model](#document) with the following extra attributes: 

Field           | Type |  Description
--------------- | ---- | -----------
tracked         | boolean | Always set to true for endorsable documents.   
type            | String | The document type that was specified when the endorsable document was created (currently <b>promissory note</b> is the only supported type)
transferable    | boolean | True if the document is able to be endorsed
asset           | Object | Information about the asset

### Asset Object

The asset object has the following attributes

Field           | Type |  Description
--------------- | ---- | -----------
id              | String | ID of the asset that is assigned to the document
address         | String | The cryptocurrency address that holds the endorsable document

## Certificate

Contains information regarding the advanced electronic signatures (e.g. FIEL) used to sign the document

```json
{
  "id": "07320f00-f504-47e0-8ff6-78378d2faca4",
  "type_of": "FIEL",
  "cer_hex": "308204cf30...1303030303030323",
  "owner": "JORGE MORALES MENDEZ",
  "tax_id": "MOMJ811012643",
  "expires_at": "2017-04-28T19:43:23.000Z",
  "expired": false
}
```

Field           | Type |  Description
--------------- | ---- | -----------
id              | String | The ID of the Certificate
type_of         | String | Type of certificate used (e.g. FIEL)
owner           | String | Name of the owner as defined in the certificate
tax_id          | String | RFC (tax ID) or other identifier of owner as defined in the certificate
cer_hex         | String | Certificate in hexadecimal
expires_at      | Date | Expiration date of the Certificate
expired         | Boolean | `true` if the Certificate is expired

## Signature

Contains information regarding the signers that have successfully signed the document

```json
{
  "email": "signer1@email.com",
  "signed": true,
  "signed_at": "2016-01-19T16:34:37.887Z",
  "certificate_id": "20001000000200001410",
  "tax_id": "AAA010101AAA",
  "signature": "77cd5156779c..4e276ef1056c1de11b7f70bed28",
  "user": {
    "email": "signer1@email.com",
    "name": "Signer 1"
  }
}
```

Field           | Type |  Description
--------------- | ---- | -----------
id              | String | The ID of the Certificate used to sign
email           | String | Email of the signer
signed          | Boolean | `true` if signed
signed_at       | Date   | Timestamp of the date signed
certificate_number | String | Certificate number assigned by the certificate authority (e.g. SAT)
tax_id          | String | RFC of the signer
signature       | String | Electronic signature on the document (in hexadecimal)

## Template

```json
{
  "id": "446e56c9-6df3-444b-ad2b-c582f1fd0dd0",
  "name": "NDA",
  "description": "Confidential disclosure agreement between two parties",
  "has_documents": false,
  "header": "The HTML header",
  "content": "The HTML content",
  "footer": "The HTML footer",
  "csv": "https://www.mifiel.com/api/v1/templates/446e56c9-6df3-444b-ad2b-c582f1fd0dd0/generate_populated_csv"
}
```

```json
{
  "id": "446e56c9-6df3-444b-ad2b-c582f1fd0dd0",
  "name": "Pagaré",
  "description": "Pagaré between two parties",
  "has_documents": false,
  "header": "The HTML header",
  "content": "The HTML content",
  "footer": "The HTML footer",
  "csv": "https://www.mifiel.com/api/v1/templates/446e56c9-6df3-444b-ad2b-c582f1fd0dd0/generate_populated_csv",
  "tracked": true,
  "type": "promissory-note"
}
```

Field           | Type |  Description
--------------- | ---- | -----------
id              | String | The ID of the Template
name            | String | The name of the Template
description     | String | The description
hash_documents  | Boolean| Whether the template has documents or not
header          | Text   | The Header of the template
content         | Text   | The Content of the template
footer          | Text   | The Footer of the template
tracked         | Boolean| Whether the template is used to create endorsable (tracked) documents or non-endorsable documents
type            | String | Type of the template if it is tracked. For now, the only value is 'promissory-note' (pagaré)

## Signatory

```json
{
  "email": "signatory@email.com",
  "name": "Signatory Name",
  "tax_id": "AAA010101AAA",
  "field": "beneficiary"
}
```

Field           | Type |  Description
--------------- | ---- | -----------
email           | String | The email of the signatory
name            | String | __Optional__ The name of the signatory
tax_id          | String | __Optional__ The tax_id (RFC) of the signatory
field           | String | __Optional__ The type of signatory.

The _field_ param is required in endorsable documents. For example in a promissory note document (created with params `track: true, type: 'promissory-note'`) possible values are __beneficiary__ and __subscriber__ for issuing and __holder__ and __receiver__ for transfering.
