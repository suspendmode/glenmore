package mediafabrique.test.lifecycle
{
	import flexunit.framework.Assert;
	
	public class LazyObjectTest
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
		public function testCallLater():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testDispatchLater():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testInvalidateProperties():void
		{
			Assert.fail("Test method Not yet implemented");
		}
	}
}