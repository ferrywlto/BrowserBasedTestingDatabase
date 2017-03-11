class Testcase_tmpForm extends ATDB_Form
{
	var rec:Object;
	public function Testcase_tmpForm(rec:Object)
	{
		super();
		_winLink_str = "Testcase_tmpForm";
		_winTitle_str = "Details:";	
		this.rec = rec;
	}
	public function init()
	{
		var mc = win_mc.content;
		mc.id_lbl.text = rec.ID;
		mc.sv_lbl.text = rec.Version;
		mc.sc_lbl.text = rec.Creator;
		mc.cat_lbl.text = rec.Category;
		mc.subcat_lbl.text = rec.Sub_Category;
		mc.tt_lbl.text = rec.Test_Type;
		mc.san_lbl.text = rec.Sanity;
		mc.mtc_lbl.text = rec.Mandatory_Test_Count;
		mc.date_lbl.text = rec.Creation_Date;
		mc.desc_txt.text = rec.Description;
		mc.proc_txt.text = rec.Procedure;
		mc.expt_txt.text = rec.Expected_Result;

		centerWindow();
		win_mc.visible = true;
	}
}
