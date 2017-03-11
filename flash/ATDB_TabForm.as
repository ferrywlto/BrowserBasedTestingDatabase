class ATDB_TabForm extends ATDB_Form
{
	private var _tabPane:TabPane;
	private var _createForm:MovieClip;
	private var _searchForm:MovieClip;
	
	public function ATDB_TabForm()
	{
		super();
	}
	// Work with checkForInvaildChar, this function check for blank fields
	public function vaildateCreateForm():Boolean{return true;}
}