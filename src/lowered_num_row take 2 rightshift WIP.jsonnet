// two nearly-ident entries, b/c that's the only way to get an OR condition effect.  so 2 fxns.

//also, this is horribly clunky to add a lot of keys.  need a way to do this better - array comprehensions?   one-click thing in the karabiner interface.
//NOTE you can add an array to an array in jsonnet.  so, return an array of 2 objs and add that to the rules array?  //std.flattenArrays is a thing!
// also multi-D arrays are valid.  can also return an obj and prolly use std.objectValues
// there's also prolly some stuff for mapping and complex fxnal concepts to reduce the 2 fxns to one result?

//local foo(a) = {
//  name: 'jerk',
//   val: a[0]
// };
// [foo(x) for x in [["q","1"],["w","2"]]]

// local numRowKeyMap = [
//   {
//     result_key: "1",
//     typed_key: "q'"
//   },
//   {
//     result_key: "2",
//     typed_key: "w"
//   },
//   {
//     result_key: "3",
//     typed_key: "e"
//   },
// 
// ];
// [NumRowKeyPersistantRule(x.typed_key, x.result_key) for x in numRowKeyMap] is promising.  try..

local NumRowKeyPersistantRule(typed_key, transformed_to_key) = {
  "description": "num row starter entry? - persistent - (%s:%s)" % [typed_key, transformed_to_key],  
  "manipulators": [
    {
      "type": "basic",
      "from": {
        "key_code": typed_key,
      },
      "conditions": [
        {
          "type": "variable_if",
          "name": "numlayer persistent active",
          "value": 1
        }
        
      ],                    
      "to": [
        {
          "key_code": transformed_to_key
        }
      ]          
    }
  ]
};
  
local NumRowKeyLeaderRule(typed_key, transformed_to_key) = {  
  "description": "num row starter entry 2? - leader - (%s:%s)" % [typed_key, transformed_to_key],
  "manipulators": [
    {
      "type": "basic",
      "from": {  //important not to allow any modifiers, else shift+q = !  um, but then we can't move down the symbols, which is lousy.
        "key_code": typed_key,
      },
      "conditions": [
        {
          "type": "variable_if",
          "name": "numlayer leader active",
          "value": 1
        }
    
      ],                    
      "to": [
        {
          "key_code": transformed_to_key
        }
      ]          
    }
  ]
};



{
  "title": "Lowered Numeric Layer WIP 2",
  "rules": [
    
    //for some reason, this rule should be below the actual usage of it in other rules
    {
      "description": "right shift as leader for num keys?",
      "manipulators": [
        {
          "type": "basic",
          "from": {
            "key_code": "right_shift",
            "modifiers": {
              "optional": [
                "any"
              ]
            }
          },
          "conditions": [  //this is tmp to try to get double nd single click working
            {
              "type": "variable_unless",
              "name": "right_shift pressed",
              "value": 1              
            }
          ],
          "to": [
            {
              "set_variable": {
                "name": "right_shift pressed",
                "value": 1
              }
            },
            {
              "set_variable": {
                "name": "numlayer leader active",
                "value": 1
              }
            },
            {
              "key_code": "right_shift"
            }
          ],
          "to_delayed_action": {
            "to_if_invoked": [
              {
                "set_variable": {
                  "name": "right_shift pressed",
                  "value": 0
                }
              },
              {
                "set_variable": {
                  "name": "numlayer leader active",
                  "value": 0
                }
              }
            ],
            "to_if_canceled": [
              {
                "set_variable": {
                  "name": "right_shift pressed",
                  "value": 0
                }
              },
              {
                "set_variable": {
                  "name": "numlayer leader active",
                  "value": 0
                }
              }
              
            ]
          },
          "parameters": {
              "basic.to_delayed_action_delay_milliseconds": 1000
          }          
        }
      ]
    },
    

    NumRowKeyPersistantRule(typed_key='q', transformed_to_key='1'),
    NumRowKeyLeaderRule(typed_key='q', transformed_to_key='1'),
    NumRowKeyPersistantRule(typed_key='w', transformed_to_key='2'),
    NumRowKeyLeaderRule(typed_key='w', transformed_to_key='2'),

    {
      "description": "double right shift to toggle num layer mode",
      "manipulators": [
       {
          "type": "basic",
          "from": {
            "key_code": "right_shift",
            "modifiers": {
              "optional": [
                "any"
              ]
            }
          },
          "conditions": [
            {
              "type": "variable_if",
              "name": "right_shift pressed",
              "value": 1
            },
            {
              "type": "variable_if",
              "name": "numlayer persistent active",
              "value": 0
            }            
          ],          
          "to": [
            {
              "set_variable": {
                "name": "numlayer persistent active",
                "value": 1
              }
            },
            {"key_code": "right_shift",} //may be important for downstream events?
          ]
        },
        
       {
          "type": "basic",
          "from": {
            "key_code": "right_shift",
            "modifiers": {
              "optional": [
                "any"
              ]
            }
          },
          "conditions": [
            {
              "type": "variable_if",
              "name": "right_shift pressed",
              "value": 1
            },
            {
              "type": "variable_if",
              "name": "numlayer persistent active",
              "value": 1
            }            
          ],          
          "to": [
            {
              "set_variable": {
                "name": "numlayer persistent active",
                "value": 0
              }
            },
            {"key_code": "right_shift",} //may be important for downstream events?
          ]
        },        
        
        //below junk
        
       //  {
//           "type": "basic",
//           "from": {
//             "key_code": "right_shift",
//             "modifiers": {
//               "optional": [
//                 "any"
//               ]
//             }
//           },
//           "to": [
//             {
//               "set_variable": {
//                 "name": "right_shift pressed",
//                 "value": 1
//               }
//             },
//             {
//               "key_code": "right_shift"
//             }
//           ],
//           "to_delayed_action": {
//             "to_if_invoked": [
//               {
//                 "set_variable": {
//                   "name": "right_shift pressed",
//                   "value": 0
//                 }
//               }
//             ],
//             "to_if_canceled": [
//               {
//                 "set_variable": {
//                   "name": "right_shift pressed",
//                   "value": 0
//                 }
//               }
//             ],
//             "parameters": {
//               "basic.to_delayed_action_delay_milliseconds": 2000
//             } 
//           }
//         }


        
       //  {
//           "type": "basic",
//           "from": {
//             "key_code": "right_shift",
//             "modifiers": {
//               "optional": [
//                 "any"
//               ]
//             }
//           },
//           "to": [
//             {
//               "set_variable": {
//                 "name": "right_shift pressed",
//                 "value": 1
//               },
// 
//             },
//             {
//               "key_code": "right_shift"
//             }
//           ]
//         }
      ]
    },

   {
    "description": "temp clear vars on lcmd+a",
    "manipulators": [

   
    {
      "type": "basic",
      "from": {
        "key_code": "a",
        "modifiers": {
          "mandatory": [
            "left_command"
          ]
        }
      },
      "to": [
        {
          "set_variable": {
            "name": "right_shift pressed",
            "value": 0
          }
        },
        {
          "set_variable": {
            "name": "numlayer persistent active",
            "value": 0
          }
        },
       {
          "set_variable": {
            "name": "numlayer leader active",
            "value": 0
          }
        }
      ]
    }   
    ]
    }
   
  
  ]
}
