Menu_Record_Wave = RageUI.CreateMenu(menu_wave["MenuRecordWave"].Name, menu_wave["MenuRecordWave"].Desc, 0, 0, 'bannereditor', 'interaction_bgd2', 0, 0, 0, 0)

Menu_Record_Wave.Closed = function()
    menu_isopen = false 
end

if not menu_wave["MenuRecordWave"].commande then 
    Keys.Register(menu_wave["MenuRecordWave"].touche, menu_wave["MenuRecordWave"].touche, "Menu Record", function()
        OpenMenuWaveRecord(true)
    end)
    RegisterCommand(menu_wave["MenuRecordWave"].NameCommand,function()
        OpenMenuWaveRecord(true)
    end)
else 
    RegisterCommand(menu_wave["MenuRecordWave"].NameCommand,function()
        OpenMenuWaveRecord(true)
    end)
end

local checkbox = false

function OpenMenuWaveRecord(args1)
    if menu_isopen then 
        return 
    else 
        menu_isopen = args1
        RageUI.Visible(Menu_Record_Wave, args1)
        
        Citizen.CreateThread(function()
            while menu_isopen do 
                Wait(1)
                RageUI.IsVisible(Menu_Record_Wave, function()

                    if checkbox then 
                        RageUI.Separator("Mode Editor : ~g~Activé")
                    else 
                        RageUI.Separator("Mode Editor : ~r~Désactivé")
                    end

                    RageUI.line()

                    RageUI.Checkbox(menu_wave ["checkbox"].Name, nil, checkbox, {}, { 
                        
                        onChecked = function()
                            checkbox = true 
                        end,
                        onUnChecked = function() 
                            checkbox = false
                        end,
                        onSelected = function(index) 
                            checkbox = index 
                        end
                    })

                    if checkbox then 
                        RageUI.Button(menu_wave["btn1"].Name, menu_wave["btn1"].Desc, {RightLabel = "→→"}, args1,{
                            onSelected = function()
                                StartRecording(1)
                            end
                        })
                        RageUI.Button(menu_wave["btn2"].Name, menu_wave["btn2"].Desc, {RightLabel = "→→"}, args1,{
                            onSelected = function()
                                StopRecording()
                            end
                        })
                        RageUI.Button(menu_wave["btn3"].Name, menu_wave["btn3"].Desc, {RightLabel = "→→"}, args1,{
                            onSelected = function()
                                NetworkSessionLeaveSinglePlayer()
                                ActivateRockstarEditor()
                            end
                        })
                    end
                end)
            end
        end)
    end
end
