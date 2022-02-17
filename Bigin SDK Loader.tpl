___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Bigin SDK Loader",
  "brand": {
    "id": "brand_dummy",
    "displayName": "Biginsight",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAEgAAABgCAMAAACJzMQuAAAABGdBTUEAALGPC/xhBQAAAAFzUkdCAK7OHOkAAAAzUExURUdwTC1l/yFO/x9K/yhh/ypj/zRz/x9M/yli/ylj/x5L/yhi/yZq/yJb/yBS/x1H/xk6/wmdH8IAAAALdFJOUwAsxdPnWAl08r7u+pjeFwAAAgJJREFUWMPtmNuugyAQRa1Ci0XA///ag4hcVFrmkvPUSfrUZGUJgjN7mJdlmXV/CTncl+csGkLSsgnyfzKQlqCkR0Ul7UYMpGhk9EQk7UbGF5EUjTbUJCikbGSMoJAKI2sppMLIWvvGk7KRDaQJS6qNCKSTkbPvEUc6GzlncaQNlHbNCzlfKFI8ISY+WgChSLVRVMKQstGxRs6t6wonZaPt0aKQQ5CCkdG1EcYpGpn0HmFI6pnWSF+MIKS5MjJ5+3fQ2nvVzc9qjZKQx4BIgbODlmO1XUL1k3bOIPJhK5USSXRyhsdLvj6W6ON8r4fg4XwmQTifSDBOmwTltEhwzj0Jw7kj4ThXEpZzJuE5NYnCKUk0TiZROQeJzvGkrWVn4AySCcT1aFyLzbX9XC8k1xHhOrRc1wjXxcZ11XJd/lyfI64PZO8n+/H6UqqziVDVwHZta1RvW3PqIUMzumIarVNXG42wrV/u2Cqj3rb2aEavRsj2uLFG8Ib96LNtZYQYIcpZZDfySrihJvTZ1XQEeS5ZpjWn6Qg5+BWzCHioVbKesnUUog3H9XT0xviURgcHGUUURuBIQ8lrNpJCFnRcUxtBQi0l7/KjfY0mWhCVdo3gUxnRYr9sBOEo2cohtRnpgWZAjTSfZESPjxdwoK1kO8/mCMZnpdT2661mVP+rX/3qX+oPORys52hm83IAAAAASUVORK5CYII\u003d"
  },
  "description": "Initialize script and create the event queue",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "projectID",
    "displayName": "Project ID",
    "simpleValueType": true,
    "notSetText": "Project ID is require field"
  },
  {
    "type": "TEXT",
    "name": "currencyCode",
    "displayName": "Currency Code",
    "simpleValueType": true,
    "notSetText": "Currency Code is require field"
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const createQueue = require('createQueue');
const getTimeStamp = require('getTimestamp');
const copyFromWindow = require('copyFromWindow');
const setInWindow = require('setInWindow');
const injectScript = require('injectScript');
const callInWindow = require('callInWindow');

const bigin = copyFromWindow('bigin') ? copyFromWindow('bigin') : {};

bigin.user = function (command, data) {
  const biginQeueuFromWindow = createQueue('_b_g_e_b_f');
  biginQeueuFromWindow({type: 'user', command: command, data: data});
};

bigin.event = function (command, data, timestamp) {
  const biginQeueuFromWindow = createQueue('_b_g_e_b_f');
  biginQeueuFromWindow({
    type: 'event',
    command: command,
    data: data,
    timestamp: timestamp ? timestamp : getTimeStamp()
  });
};

bigin.track = function (command, data) {
  const biginQeueuFromWindow = createQueue('_b_g_e_b_f');
  biginQeueuFromWindow({
    type: 'track',
    command: command,
    data: data
  });
};

setInWindow('bigin', bigin, true);

const onInjectScriptSuccess = function () {
  const biginFromWindow = copyFromWindow('bigin');
  const biginQeueuFromWindow = copyFromWindow('_b_g_e_b_f');
  
  if (biginFromWindow) {
    biginFromWindow.config({
      projectID: data.projectID,
      currencyCode: data.currencyCode
    });
  }
  
  if (biginQeueuFromWindow && biginQeueuFromWindow.length > 0) {
    biginQeueuFromWindow.forEach(function (event) {
      callInWindow('bigin.'+event.type, event.command, event.data, event.timestamp);
    });
  }
  
  setInWindow('bigin', biginFromWindow, true);   
  data.gtmOnSuccess();
};

const onInjectScriptFailure = function () {
  data.gtmOnFailure();
};

injectScript('https://sdk.bigin.io/v1/bigin.sdk.js', onInjectScriptSuccess, onInjectScriptFailure);


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_b_g_e_b_f"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin.user"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin.event"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "bigin.track"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://sdk.bigin.io/"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 2022. 2. 17. 오후 2:16:13


