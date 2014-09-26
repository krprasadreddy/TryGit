public class RadarChartController{

	public List<RadarData> data {get;set;}
	
	public RadarChartController() {
	
		data = new List<RadarData>();
		
		data.add(new RadarData('A',1,1,1));
		data.add(new RadarData('A',2,3,4));
		data.add(new RadarData('A',5,6,7));
		
		data.add(new RadarData('B',2,5,6));
		data.add(new RadarData('B',1,7,9));
		data.add(new RadarData('B',7,2,7));
		
		data.add(new RadarData('C',1,6,1));
		data.add(new RadarData('C',2,3,4));
		data.add(new RadarData('C',9,6,7));
		
		data.add(new RadarData('D',3,2,1));
		data.add(new RadarData('D',5,3,4));
		data.add(new RadarData('D',1,6,7));
	
	}
	
	
	public class RadarData {
        String memName {get;set;}
        List<Decimal> value1{get;set;}{value1 = new List<Decimal>();}
        List<Decimal> value2{get;set;}{value2 = new List<Decimal>();}
        List<Decimal> value3 {get;set;} {value3 = new List<Decimal>();}
        /**
         * Constructor of the inner class
        **/
        public RadarData(String memName, Decimal value1, Decimal value2 , Decimal value3) {
            this.memName = memName;
            this.value1.add(value1);
            this.value2.add(value2) ;
            this.value3.add(value3) ;
        }
   }
}