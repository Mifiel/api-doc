# Endorsables setup

## User account setup

Every user (issuer or receiver) of an endorsable document must set up his account. During this setup process, we will use the user's FIEL/e.firma to derive a set of cryptocurrency addresses where the assets (the endorsable documents) will be stored.

The widget is an embedded tool to setup the required private keys that generate the addresses. By embedding this tool, your users can setup their account without having to leave the flow of your website.

The flow to embed this tool into your site is:
1. Create a Setup widget_id on our server for your user.
2. Save the widget_id in your database so you can access it later.
3. Use the widget_id in the setup-snippet. An iframe will be placed within your site where your user would drag his FIEL and a backup certificate.
4. When the setup is complete, the iframe will trigger an event so you can redirect the user to the next step in your flow.

## Require a setup widget id

### HTTP Request

`POST https://www.mifiel.com/api/v1/users/setup-widget`

### Parameters

Field        | Type   |  Description
------------ | ------ | -----------
email        | String |  Email of the user
tax_id       | String |  __Optional__ Tax Id (RFC) of the user
callback_url | String |  __Optional__ URL where we will POST when the user completes the process

### Response

Field        | Type   |  Description
------------ | ------ | -----------
widget_id    | String |  Widget Id to be used on the snippet

<aside class="info">
  <b>Important:</b> Save the widget_id in your database. If the user does not complete the setup, you should use the same widget_id when the user comes back to the setup flow.
</aside>

## User account setup widget

### Options

Field     | Type    | Default |  Description
--------- | ------- | ------- | ------------
widgetId  | String  |         | Widget ID.
appendTo  | String  | body    | ID of the element in the page
successBtnText | String | 'OK' | Text of the button at the end of the setup flow. When the user clicks, will trigger an event so you can cach it.
color     | String  | 37BC9B  | __Optional__ Custom color in hexadecimal (e.g. 555555) to personalize the look and feel of your widget. Typically the primary color of your app.
width     | String  | 100%    | __Optional__ Width of the widget __[px or %]__
height    | String  | 1100    | __Optional__ Height of the widget __[px]__

### Events

> Listen for Mifiel events:

```html
<script type="text/javascript">
window.addEventListener('message', function (e) {
  console.log(e);
  // accept messages from known hosts only
  // change to https://app-stageex.mifiel.com if necessary
  if (e.origin !== 'https://app.mifiel.com') {
    return;
  }
  // We will always send an object
  if (typeof e.data !== 'object') {
    return;
  }
  // setup completed
  if (e.data.eventType === 'mifiel.setup-widget.success') {
    var data = e.data,
        doc = data.document
  }
  // Event errors
  if (e.data.eventType === 'mifiel.setup-widget.error') {
    var error = e.data.error;
    // error.code
    // error.message
  }
}, false);
</script>
```

We will send a [postMessage](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage) to your page to notify any of the events listed below.

In order to secure the events sent by the widget you **must** verify that the event is coming from our servers. 

You can identify the events by *e.data.eventType*. The success event will have **"mifiel.setup-widget.success"** and the error events will have **"mifiel.setup-widget.error"**.

### Success event 

We will send the document json object and the signature of the user.

### Error events

Error events have the property *eventType* set as **"mifiel.setup-widget.error"** and a error object *(e.data.error)* with *code* and *message* properties:

#### User error events

Event               | Code | Message
------------------- | ---- | -------
Invalid Certificate | 2001 | Certificate is not valid
Invalid Private Key | 2002 | Invalid Private Key
Invalid Pasword     | 2003 | Invalid password
Files do not match  | 2004 | .key file does not belong to the .cer file

#### Server error events

Event               | Code | Message
------------------- | ---- | -------
Setup failure       | 3002 | Fail to setup user

