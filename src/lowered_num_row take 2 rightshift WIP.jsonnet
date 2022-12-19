
{
  "title": "Lowered Numeric Layer WIP 2",
  "rules": [
    
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
    // two nearly-ident entries, b/c that's the only way to get an OR condition effect.
    {
      "description": "num row srarter entry? - persistent",
      "manipulators": [
        {
          "type": "basic",
          "from": {
            "key_code": "q",
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
              "key_code": "1"
            }
          ]          
        }
      ]
    },
    
        {
      "description": "num row srarter entry 2? - leader",
      "manipulators": [
        {
          "type": "basic",
          "from": {  //important not to allow any modifiers, else shift+q = !  um, but then we can't move down the symbols, which is lousy.
            "key_code": "q",
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
              "key_code": "1"
            }
          ]          
        }
      ]
    },
    
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
