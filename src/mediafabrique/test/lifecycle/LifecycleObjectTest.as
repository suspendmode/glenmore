package mediafabrique.test.lifecycle
{
	import flexunit.framework.Assert;
	
	public class LifecycleObjectTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testDispose():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testInitialize():void
		{
			Assert.fail("Test method Not yet implemented");
		}
	}
}