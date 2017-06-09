public  class SelectableAsset {
	
	public Asset asset {get; set;}
    public Boolean selected {get; set;}
    
    public SelectableAsset(Asset ast)
    {
       	
    	asset =ast;
    	selected = false;
    	
    }
	

}