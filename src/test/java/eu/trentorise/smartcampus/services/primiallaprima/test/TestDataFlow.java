package eu.trentorise.smartcampus.services.primiallaprima.test;

import it.sayservice.platform.core.common.exception.ServiceException;
import it.sayservice.platform.servicebus.test.DataFlowTestHelper;

import java.util.HashMap;
import java.util.Map;

import eu.trentorise.smartcampus.services.primiallaprima.impl.GetEventsDataFlow;

public class TestDataFlow {

	public static void main(String[] args) throws ServiceException {
		DataFlowTestHelper helper = new DataFlowTestHelper();
		Map<String, Object> out = helper.executeDataFlow(
				"eu.trentorise.smartcampus.services.primiallaprima.PrimiallaprimaService", 
				"GetEvents", 
				new GetEventsDataFlow(), 
				new HashMap<String, Object>());
		System.err.println(out);
	}
}
