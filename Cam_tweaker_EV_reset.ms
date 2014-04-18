lightCA = attributes lightSystem version:1
(
	fn viewportChange =
	(
		cam=getActiveCamera()
		if cam != undefined AND cam.modifiers["scene lighting"]!= undefined then
		(
			cam.modifiers["scene lighting"].calc_light cam
		)
	)
	parameters main rollout:params
	(
		sun type:#node
		dome type:#node
		sky type:#node
	)
	rollout params "Light System"
	(
		pickbutton sunUI "pick a sun"
		pickbutton domeUI "pick a dome" enabled:false 
		pickbutton skyUI "pick a sky" enabled:false 
		
		on sunUI picked obj do
		(
			sun = obj
			sunUI.text= obj.name
			domeUI.enabled=true
		)
		on domeUI picked obj do
		(
			dome = obj
			domeUI.text= obj.name
			skyUI.enabled=true
		)
		on skyUI picked obj do
		(
			sky = obj
			skyUI.text= obj.name
			DestroyDialog params
		)
	)
)


fn resetLightSystem =
(
	CAs = custAttributes.getDefs rootNode
	ID = undefined
	for i=1 to CAs.count do
	(
		if CAs[i].name == #lightSystem then
		ID = i
	)
	if ID != undefined then
	(
		custAttributes.delete rootNode CAs[ID]
	)
	if queryBox "Set new light system?" beep:false then
	(
		if (rootNode.custAttributes["lightSystem"] == undefined ) then
		(
			custAttributes.add rootNode lightCA
			createDialog rootNode.custAttributes["lightSystem"].params
		)
	)
)

resetLightSystem()