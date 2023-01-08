unit googlecompute;
{$MODE objfpc}
{$H+}

interface

uses sysutils, classes, googleservice, restbase, googlebase;

type
  
  //Top-level schema types
  TAccessConfig = Class;
  TAddress = Class;
  TAddressAggregatedList = Class;
  TAddressList = Class;
  TAddressesScopedList = Class;
  TAttachedDisk = Class;
  TAttachedDiskInitializeParams = Class;
  TAutoscaler = Class;
  TAutoscalerAggregatedList = Class;
  TAutoscalerList = Class;
  TAutoscalersScopedList = Class;
  TAutoscalingPolicy = Class;
  TAutoscalingPolicyCpuUtilization = Class;
  TAutoscalingPolicyCustomMetricUtilization = Class;
  TAutoscalingPolicyLoadBalancingUtilization = Class;
  TBackend = Class;
  TBackendService = Class;
  TBackendServiceGroupHealth = Class;
  TBackendServiceList = Class;
  TDeprecationStatus = Class;
  TDisk = Class;
  TDiskAggregatedList = Class;
  TDiskList = Class;
  TDiskMoveRequest = Class;
  TDiskType = Class;
  TDiskTypeAggregatedList = Class;
  TDiskTypeList = Class;
  TDiskTypesScopedList = Class;
  TDisksResizeRequest = Class;
  TDisksScopedList = Class;
  TFirewall = Class;
  TFirewallList = Class;
  TForwardingRule = Class;
  TForwardingRuleAggregatedList = Class;
  TForwardingRuleList = Class;
  TForwardingRulesScopedList = Class;
  THealthCheckReference = Class;
  THealthStatus = Class;
  THostRule = Class;
  THttpHealthCheck = Class;
  THttpHealthCheckList = Class;
  THttpsHealthCheck = Class;
  THttpsHealthCheckList = Class;
  TImage = Class;
  TImageList = Class;
  TInstance = Class;
  TInstanceAggregatedList = Class;
  TInstanceGroup = Class;
  TInstanceGroupAggregatedList = Class;
  TInstanceGroupList = Class;
  TInstanceGroupManager = Class;
  TInstanceGroupManagerActionsSummary = Class;
  TInstanceGroupManagerAggregatedList = Class;
  TInstanceGroupManagerList = Class;
  TInstanceGroupManagersAbandonInstancesRequest = Class;
  TInstanceGroupManagersDeleteInstancesRequest = Class;
  TInstanceGroupManagersListManagedInstancesResponse = Class;
  TInstanceGroupManagersRecreateInstancesRequest = Class;
  TInstanceGroupManagersScopedList = Class;
  TInstanceGroupManagersSetInstanceTemplateRequest = Class;
  TInstanceGroupManagersSetTargetPoolsRequest = Class;
  TInstanceGroupsAddInstancesRequest = Class;
  TInstanceGroupsListInstances = Class;
  TInstanceGroupsListInstancesRequest = Class;
  TInstanceGroupsRemoveInstancesRequest = Class;
  TInstanceGroupsScopedList = Class;
  TInstanceGroupsSetNamedPortsRequest = Class;
  TInstanceList = Class;
  TInstanceMoveRequest = Class;
  TInstanceProperties = Class;
  TInstanceReference = Class;
  TInstanceTemplate = Class;
  TInstanceTemplateList = Class;
  TInstanceWithNamedPorts = Class;
  TInstancesScopedList = Class;
  TInstancesSetMachineTypeRequest = Class;
  TLicense = Class;
  TMachineType = Class;
  TMachineTypeAggregatedList = Class;
  TMachineTypeList = Class;
  TMachineTypesScopedList = Class;
  TManagedInstance = Class;
  TManagedInstanceLastAttempt = Class;
  TMetadata = Class;
  TNamedPort = Class;
  TNetwork = Class;
  TNetworkInterface = Class;
  TNetworkList = Class;
  TOperation = Class;
  TOperationAggregatedList = Class;
  TOperationList = Class;
  TOperationsScopedList = Class;
  TPathMatcher = Class;
  TPathRule = Class;
  TProject = Class;
  TQuota = Class;
  TRegion = Class;
  TRegionList = Class;
  TResourceGroupReference = Class;
  TRoute = Class;
  TRouteList = Class;
  TScheduling = Class;
  TSerialPortOutput = Class;
  TServiceAccount = Class;
  TSnapshot = Class;
  TSnapshotList = Class;
  TSslCertificate = Class;
  TSslCertificateList = Class;
  TSubnetwork = Class;
  TSubnetworkAggregatedList = Class;
  TSubnetworkList = Class;
  TSubnetworksScopedList = Class;
  TTags = Class;
  TTargetHttpProxy = Class;
  TTargetHttpProxyList = Class;
  TTargetHttpsProxiesSetSslCertificatesRequest = Class;
  TTargetHttpsProxy = Class;
  TTargetHttpsProxyList = Class;
  TTargetInstance = Class;
  TTargetInstanceAggregatedList = Class;
  TTargetInstanceList = Class;
  TTargetInstancesScopedList = Class;
  TTargetPool = Class;
  TTargetPoolAggregatedList = Class;
  TTargetPoolInstanceHealth = Class;
  TTargetPoolList = Class;
  TTargetPoolsAddHealthCheckRequest = Class;
  TTargetPoolsAddInstanceRequest = Class;
  TTargetPoolsRemoveHealthCheckRequest = Class;
  TTargetPoolsRemoveInstanceRequest = Class;
  TTargetPoolsScopedList = Class;
  TTargetReference = Class;
  TTargetVpnGateway = Class;
  TTargetVpnGatewayAggregatedList = Class;
  TTargetVpnGatewayList = Class;
  TTargetVpnGatewaysScopedList = Class;
  TTestFailure = Class;
  TUrlMap = Class;
  TUrlMapList = Class;
  TUrlMapReference = Class;
  TUrlMapTest = Class;
  TUrlMapValidationResult = Class;
  TUrlMapsValidateRequest = Class;
  TUrlMapsValidateResponse = Class;
  TUsageExportLocation = Class;
  TVpnTunnel = Class;
  TVpnTunnelAggregatedList = Class;
  TVpnTunnelList = Class;
  TVpnTunnelsScopedList = Class;
  TZone = Class;
  TZoneList = Class;
  TAccessConfigArray = Array of TAccessConfig;
  TAddressArray = Array of TAddress;
  TAddressAggregatedListArray = Array of TAddressAggregatedList;
  TAddressListArray = Array of TAddressList;
  TAddressesScopedListArray = Array of TAddressesScopedList;
  TAttachedDiskArray = Array of TAttachedDisk;
  TAttachedDiskInitializeParamsArray = Array of TAttachedDiskInitializeParams;
  TAutoscalerArray = Array of TAutoscaler;
  TAutoscalerAggregatedListArray = Array of TAutoscalerAggregatedList;
  TAutoscalerListArray = Array of TAutoscalerList;
  TAutoscalersScopedListArray = Array of TAutoscalersScopedList;
  TAutoscalingPolicyArray = Array of TAutoscalingPolicy;
  TAutoscalingPolicyCpuUtilizationArray = Array of TAutoscalingPolicyCpuUtilization;
  TAutoscalingPolicyCustomMetricUtilizationArray = Array of TAutoscalingPolicyCustomMetricUtilization;
  TAutoscalingPolicyLoadBalancingUtilizationArray = Array of TAutoscalingPolicyLoadBalancingUtilization;
  TBackendArray = Array of TBackend;
  TBackendServiceArray = Array of TBackendService;
  TBackendServiceGroupHealthArray = Array of TBackendServiceGroupHealth;
  TBackendServiceListArray = Array of TBackendServiceList;
  TDeprecationStatusArray = Array of TDeprecationStatus;
  TDiskArray = Array of TDisk;
  TDiskAggregatedListArray = Array of TDiskAggregatedList;
  TDiskListArray = Array of TDiskList;
  TDiskMoveRequestArray = Array of TDiskMoveRequest;
  TDiskTypeArray = Array of TDiskType;
  TDiskTypeAggregatedListArray = Array of TDiskTypeAggregatedList;
  TDiskTypeListArray = Array of TDiskTypeList;
  TDiskTypesScopedListArray = Array of TDiskTypesScopedList;
  TDisksResizeRequestArray = Array of TDisksResizeRequest;
  TDisksScopedListArray = Array of TDisksScopedList;
  TFirewallArray = Array of TFirewall;
  TFirewallListArray = Array of TFirewallList;
  TForwardingRuleArray = Array of TForwardingRule;
  TForwardingRuleAggregatedListArray = Array of TForwardingRuleAggregatedList;
  TForwardingRuleListArray = Array of TForwardingRuleList;
  TForwardingRulesScopedListArray = Array of TForwardingRulesScopedList;
  THealthCheckReferenceArray = Array of THealthCheckReference;
  THealthStatusArray = Array of THealthStatus;
  THostRuleArray = Array of THostRule;
  THttpHealthCheckArray = Array of THttpHealthCheck;
  THttpHealthCheckListArray = Array of THttpHealthCheckList;
  THttpsHealthCheckArray = Array of THttpsHealthCheck;
  THttpsHealthCheckListArray = Array of THttpsHealthCheckList;
  TImageArray = Array of TImage;
  TImageListArray = Array of TImageList;
  TInstanceArray = Array of TInstance;
  TInstanceAggregatedListArray = Array of TInstanceAggregatedList;
  TInstanceGroupArray = Array of TInstanceGroup;
  TInstanceGroupAggregatedListArray = Array of TInstanceGroupAggregatedList;
  TInstanceGroupListArray = Array of TInstanceGroupList;
  TInstanceGroupManagerArray = Array of TInstanceGroupManager;
  TInstanceGroupManagerActionsSummaryArray = Array of TInstanceGroupManagerActionsSummary;
  TInstanceGroupManagerAggregatedListArray = Array of TInstanceGroupManagerAggregatedList;
  TInstanceGroupManagerListArray = Array of TInstanceGroupManagerList;
  TInstanceGroupManagersAbandonInstancesRequestArray = Array of TInstanceGroupManagersAbandonInstancesRequest;
  TInstanceGroupManagersDeleteInstancesRequestArray = Array of TInstanceGroupManagersDeleteInstancesRequest;
  TInstanceGroupManagersListManagedInstancesResponseArray = Array of TInstanceGroupManagersListManagedInstancesResponse;
  TInstanceGroupManagersRecreateInstancesRequestArray = Array of TInstanceGroupManagersRecreateInstancesRequest;
  TInstanceGroupManagersScopedListArray = Array of TInstanceGroupManagersScopedList;
  TInstanceGroupManagersSetInstanceTemplateRequestArray = Array of TInstanceGroupManagersSetInstanceTemplateRequest;
  TInstanceGroupManagersSetTargetPoolsRequestArray = Array of TInstanceGroupManagersSetTargetPoolsRequest;
  TInstanceGroupsAddInstancesRequestArray = Array of TInstanceGroupsAddInstancesRequest;
  TInstanceGroupsListInstancesArray = Array of TInstanceGroupsListInstances;
  TInstanceGroupsListInstancesRequestArray = Array of TInstanceGroupsListInstancesRequest;
  TInstanceGroupsRemoveInstancesRequestArray = Array of TInstanceGroupsRemoveInstancesRequest;
  TInstanceGroupsScopedListArray = Array of TInstanceGroupsScopedList;
  TInstanceGroupsSetNamedPortsRequestArray = Array of TInstanceGroupsSetNamedPortsRequest;
  TInstanceListArray = Array of TInstanceList;
  TInstanceMoveRequestArray = Array of TInstanceMoveRequest;
  TInstancePropertiesArray = Array of TInstanceProperties;
  TInstanceReferenceArray = Array of TInstanceReference;
  TInstanceTemplateArray = Array of TInstanceTemplate;
  TInstanceTemplateListArray = Array of TInstanceTemplateList;
  TInstanceWithNamedPortsArray = Array of TInstanceWithNamedPorts;
  TInstancesScopedListArray = Array of TInstancesScopedList;
  TInstancesSetMachineTypeRequestArray = Array of TInstancesSetMachineTypeRequest;
  TLicenseArray = Array of TLicense;
  TMachineTypeArray = Array of TMachineType;
  TMachineTypeAggregatedListArray = Array of TMachineTypeAggregatedList;
  TMachineTypeListArray = Array of TMachineTypeList;
  TMachineTypesScopedListArray = Array of TMachineTypesScopedList;
  TManagedInstanceArray = Array of TManagedInstance;
  TManagedInstanceLastAttemptArray = Array of TManagedInstanceLastAttempt;
  TMetadataArray = Array of TMetadata;
  TNamedPortArray = Array of TNamedPort;
  TNetworkArray = Array of TNetwork;
  TNetworkInterfaceArray = Array of TNetworkInterface;
  TNetworkListArray = Array of TNetworkList;
  TOperationArray = Array of TOperation;
  TOperationAggregatedListArray = Array of TOperationAggregatedList;
  TOperationListArray = Array of TOperationList;
  TOperationsScopedListArray = Array of TOperationsScopedList;
  TPathMatcherArray = Array of TPathMatcher;
  TPathRuleArray = Array of TPathRule;
  TProjectArray = Array of TProject;
  TQuotaArray = Array of TQuota;
  TRegionArray = Array of TRegion;
  TRegionListArray = Array of TRegionList;
  TResourceGroupReferenceArray = Array of TResourceGroupReference;
  TRouteArray = Array of TRoute;
  TRouteListArray = Array of TRouteList;
  TSchedulingArray = Array of TScheduling;
  TSerialPortOutputArray = Array of TSerialPortOutput;
  TServiceAccountArray = Array of TServiceAccount;
  TSnapshotArray = Array of TSnapshot;
  TSnapshotListArray = Array of TSnapshotList;
  TSslCertificateArray = Array of TSslCertificate;
  TSslCertificateListArray = Array of TSslCertificateList;
  TSubnetworkArray = Array of TSubnetwork;
  TSubnetworkAggregatedListArray = Array of TSubnetworkAggregatedList;
  TSubnetworkListArray = Array of TSubnetworkList;
  TSubnetworksScopedListArray = Array of TSubnetworksScopedList;
  TTagsArray = Array of TTags;
  TTargetHttpProxyArray = Array of TTargetHttpProxy;
  TTargetHttpProxyListArray = Array of TTargetHttpProxyList;
  TTargetHttpsProxiesSetSslCertificatesRequestArray = Array of TTargetHttpsProxiesSetSslCertificatesRequest;
  TTargetHttpsProxyArray = Array of TTargetHttpsProxy;
  TTargetHttpsProxyListArray = Array of TTargetHttpsProxyList;
  TTargetInstanceArray = Array of TTargetInstance;
  TTargetInstanceAggregatedListArray = Array of TTargetInstanceAggregatedList;
  TTargetInstanceListArray = Array of TTargetInstanceList;
  TTargetInstancesScopedListArray = Array of TTargetInstancesScopedList;
  TTargetPoolArray = Array of TTargetPool;
  TTargetPoolAggregatedListArray = Array of TTargetPoolAggregatedList;
  TTargetPoolInstanceHealthArray = Array of TTargetPoolInstanceHealth;
  TTargetPoolListArray = Array of TTargetPoolList;
  TTargetPoolsAddHealthCheckRequestArray = Array of TTargetPoolsAddHealthCheckRequest;
  TTargetPoolsAddInstanceRequestArray = Array of TTargetPoolsAddInstanceRequest;
  TTargetPoolsRemoveHealthCheckRequestArray = Array of TTargetPoolsRemoveHealthCheckRequest;
  TTargetPoolsRemoveInstanceRequestArray = Array of TTargetPoolsRemoveInstanceRequest;
  TTargetPoolsScopedListArray = Array of TTargetPoolsScopedList;
  TTargetReferenceArray = Array of TTargetReference;
  TTargetVpnGatewayArray = Array of TTargetVpnGateway;
  TTargetVpnGatewayAggregatedListArray = Array of TTargetVpnGatewayAggregatedList;
  TTargetVpnGatewayListArray = Array of TTargetVpnGatewayList;
  TTargetVpnGatewaysScopedListArray = Array of TTargetVpnGatewaysScopedList;
  TTestFailureArray = Array of TTestFailure;
  TUrlMapArray = Array of TUrlMap;
  TUrlMapListArray = Array of TUrlMapList;
  TUrlMapReferenceArray = Array of TUrlMapReference;
  TUrlMapTestArray = Array of TUrlMapTest;
  TUrlMapValidationResultArray = Array of TUrlMapValidationResult;
  TUrlMapsValidateRequestArray = Array of TUrlMapsValidateRequest;
  TUrlMapsValidateResponseArray = Array of TUrlMapsValidateResponse;
  TUsageExportLocationArray = Array of TUsageExportLocation;
  TVpnTunnelArray = Array of TVpnTunnel;
  TVpnTunnelAggregatedListArray = Array of TVpnTunnelAggregatedList;
  TVpnTunnelListArray = Array of TVpnTunnelList;
  TVpnTunnelsScopedListArray = Array of TVpnTunnelsScopedList;
  TZoneArray = Array of TZone;
  TZoneListArray = Array of TZoneList;
  //Anonymous types, using auto-generated names
  TAddressAggregatedListTypeitems = Class;
  TAddressesScopedListTypewarningTypedataItem = Class;
  TAddressesScopedListTypewarning = Class;
  TAutoscalerAggregatedListTypeitems = Class;
  TAutoscalersScopedListTypewarningTypedataItem = Class;
  TAutoscalersScopedListTypewarning = Class;
  TDiskAggregatedListTypeitems = Class;
  TDiskTypeAggregatedListTypeitems = Class;
  TDiskTypesScopedListTypewarningTypedataItem = Class;
  TDiskTypesScopedListTypewarning = Class;
  TDisksScopedListTypewarningTypedataItem = Class;
  TDisksScopedListTypewarning = Class;
  TFirewallTypeallowedItem = Class;
  TForwardingRuleAggregatedListTypeitems = Class;
  TForwardingRulesScopedListTypewarningTypedataItem = Class;
  TForwardingRulesScopedListTypewarning = Class;
  TImageTyperawDisk = Class;
  TInstanceAggregatedListTypeitems = Class;
  TInstanceGroupAggregatedListTypeitems = Class;
  TInstanceGroupManagerAggregatedListTypeitems = Class;
  TInstanceGroupManagersScopedListTypewarningTypedataItem = Class;
  TInstanceGroupManagersScopedListTypewarning = Class;
  TInstanceGroupsScopedListTypewarningTypedataItem = Class;
  TInstanceGroupsScopedListTypewarning = Class;
  TInstancesScopedListTypewarningTypedataItem = Class;
  TInstancesScopedListTypewarning = Class;
  TMachineTypeTypescratchDisksItem = Class;
  TMachineTypeAggregatedListTypeitems = Class;
  TMachineTypesScopedListTypewarningTypedataItem = Class;
  TMachineTypesScopedListTypewarning = Class;
  TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem = Class;
  TManagedInstanceLastAttemptTypeerrors = Class;
  TMetadataTypeitemsItem = Class;
  TOperationTypeerrorTypeerrorsItem = Class;
  TOperationTypeerror = Class;
  TOperationTypewarningsItemTypedataItem = Class;
  TOperationTypewarningsItem = Class;
  TOperationAggregatedListTypeitems = Class;
  TOperationsScopedListTypewarningTypedataItem = Class;
  TOperationsScopedListTypewarning = Class;
  TRouteTypewarningsItemTypedataItem = Class;
  TRouteTypewarningsItem = Class;
  TSubnetworkAggregatedListTypeitems = Class;
  TSubnetworksScopedListTypewarningTypedataItem = Class;
  TSubnetworksScopedListTypewarning = Class;
  TTargetInstanceAggregatedListTypeitems = Class;
  TTargetInstancesScopedListTypewarningTypedataItem = Class;
  TTargetInstancesScopedListTypewarning = Class;
  TTargetPoolAggregatedListTypeitems = Class;
  TTargetPoolsScopedListTypewarningTypedataItem = Class;
  TTargetPoolsScopedListTypewarning = Class;
  TTargetVpnGatewayAggregatedListTypeitems = Class;
  TTargetVpnGatewaysScopedListTypewarningTypedataItem = Class;
  TTargetVpnGatewaysScopedListTypewarning = Class;
  TVpnTunnelAggregatedListTypeitems = Class;
  TVpnTunnelsScopedListTypewarningTypedataItem = Class;
  TVpnTunnelsScopedListTypewarning = Class;
  TAddressListTypeitemsArray = Array of TAddress;
  TAddressesScopedListTypeaddressesArray = Array of TAddress;
  TAddressesScopedListTypewarningTypedataArray = Array of TAddressesScopedListTypewarningTypedataItem;
  TAutoscalerListTypeitemsArray = Array of TAutoscaler;
  TAutoscalersScopedListTypeautoscalersArray = Array of TAutoscaler;
  TAutoscalersScopedListTypewarningTypedataArray = Array of TAutoscalersScopedListTypewarningTypedataItem;
  TAutoscalingPolicyTypecustomMetricUtilizationsArray = Array of TAutoscalingPolicyCustomMetricUtilization;
  TBackendServiceTypebackendsArray = Array of TBackend;
  TBackendServiceGroupHealthTypehealthStatusArray = Array of THealthStatus;
  TBackendServiceListTypeitemsArray = Array of TBackendService;
  TDiskListTypeitemsArray = Array of TDisk;
  TDiskTypeListTypeitemsArray = Array of TDiskType;
  TDiskTypesScopedListTypediskTypesArray = Array of TDiskType;
  TDiskTypesScopedListTypewarningTypedataArray = Array of TDiskTypesScopedListTypewarningTypedataItem;
  TDisksScopedListTypedisksArray = Array of TDisk;
  TDisksScopedListTypewarningTypedataArray = Array of TDisksScopedListTypewarningTypedataItem;
  TFirewallTypeallowedArray = Array of TFirewallTypeallowedItem;
  TFirewallListTypeitemsArray = Array of TFirewall;
  TForwardingRuleListTypeitemsArray = Array of TForwardingRule;
  TForwardingRulesScopedListTypeforwardingRulesArray = Array of TForwardingRule;
  TForwardingRulesScopedListTypewarningTypedataArray = Array of TForwardingRulesScopedListTypewarningTypedataItem;
  THttpHealthCheckListTypeitemsArray = Array of THttpHealthCheck;
  THttpsHealthCheckListTypeitemsArray = Array of THttpsHealthCheck;
  TImageListTypeitemsArray = Array of TImage;
  TInstanceTypedisksArray = Array of TAttachedDisk;
  TInstanceTypenetworkInterfacesArray = Array of TNetworkInterface;
  TInstanceTypeserviceAccountsArray = Array of TServiceAccount;
  TInstanceGroupTypenamedPortsArray = Array of TNamedPort;
  TInstanceGroupListTypeitemsArray = Array of TInstanceGroup;
  TInstanceGroupManagerTypenamedPortsArray = Array of TNamedPort;
  TInstanceGroupManagerListTypeitemsArray = Array of TInstanceGroupManager;
  TInstanceGroupManagersListManagedInstancesResponseTypemanagedInstancesArray = Array of TManagedInstance;
  TInstanceGroupManagersScopedListTypeinstanceGroupManagersArray = Array of TInstanceGroupManager;
  TInstanceGroupManagersScopedListTypewarningTypedataArray = Array of TInstanceGroupManagersScopedListTypewarningTypedataItem;
  TInstanceGroupsAddInstancesRequestTypeinstancesArray = Array of TInstanceReference;
  TInstanceGroupsListInstancesTypeitemsArray = Array of TInstanceWithNamedPorts;
  TInstanceGroupsRemoveInstancesRequestTypeinstancesArray = Array of TInstanceReference;
  TInstanceGroupsScopedListTypeinstanceGroupsArray = Array of TInstanceGroup;
  TInstanceGroupsScopedListTypewarningTypedataArray = Array of TInstanceGroupsScopedListTypewarningTypedataItem;
  TInstanceGroupsSetNamedPortsRequestTypenamedPortsArray = Array of TNamedPort;
  TInstanceListTypeitemsArray = Array of TInstance;
  TInstancePropertiesTypedisksArray = Array of TAttachedDisk;
  TInstancePropertiesTypenetworkInterfacesArray = Array of TNetworkInterface;
  TInstancePropertiesTypeserviceAccountsArray = Array of TServiceAccount;
  TInstanceTemplateListTypeitemsArray = Array of TInstanceTemplate;
  TInstanceWithNamedPortsTypenamedPortsArray = Array of TNamedPort;
  TInstancesScopedListTypeinstancesArray = Array of TInstance;
  TInstancesScopedListTypewarningTypedataArray = Array of TInstancesScopedListTypewarningTypedataItem;
  TMachineTypeTypescratchDisksArray = Array of TMachineTypeTypescratchDisksItem;
  TMachineTypeListTypeitemsArray = Array of TMachineType;
  TMachineTypesScopedListTypemachineTypesArray = Array of TMachineType;
  TMachineTypesScopedListTypewarningTypedataArray = Array of TMachineTypesScopedListTypewarningTypedataItem;
  TManagedInstanceLastAttemptTypeerrorsTypeerrorsArray = Array of TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem;
  TMetadataTypeitemsArray = Array of TMetadataTypeitemsItem;
  TNetworkInterfaceTypeaccessConfigsArray = Array of TAccessConfig;
  TNetworkListTypeitemsArray = Array of TNetwork;
  TOperationTypeerrorTypeerrorsArray = Array of TOperationTypeerrorTypeerrorsItem;
  TOperationTypewarningsItemTypedataArray = Array of TOperationTypewarningsItemTypedataItem;
  TOperationTypewarningsArray = Array of TOperationTypewarningsItem;
  TOperationListTypeitemsArray = Array of TOperation;
  TOperationsScopedListTypeoperationsArray = Array of TOperation;
  TOperationsScopedListTypewarningTypedataArray = Array of TOperationsScopedListTypewarningTypedataItem;
  TPathMatcherTypepathRulesArray = Array of TPathRule;
  TProjectTypequotasArray = Array of TQuota;
  TRegionTypequotasArray = Array of TQuota;
  TRegionListTypeitemsArray = Array of TRegion;
  TRouteTypewarningsItemTypedataArray = Array of TRouteTypewarningsItemTypedataItem;
  TRouteTypewarningsArray = Array of TRouteTypewarningsItem;
  TRouteListTypeitemsArray = Array of TRoute;
  TSnapshotListTypeitemsArray = Array of TSnapshot;
  TSslCertificateListTypeitemsArray = Array of TSslCertificate;
  TSubnetworkListTypeitemsArray = Array of TSubnetwork;
  TSubnetworksScopedListTypesubnetworksArray = Array of TSubnetwork;
  TSubnetworksScopedListTypewarningTypedataArray = Array of TSubnetworksScopedListTypewarningTypedataItem;
  TTargetHttpProxyListTypeitemsArray = Array of TTargetHttpProxy;
  TTargetHttpsProxyListTypeitemsArray = Array of TTargetHttpsProxy;
  TTargetInstanceListTypeitemsArray = Array of TTargetInstance;
  TTargetInstancesScopedListTypetargetInstancesArray = Array of TTargetInstance;
  TTargetInstancesScopedListTypewarningTypedataArray = Array of TTargetInstancesScopedListTypewarningTypedataItem;
  TTargetPoolInstanceHealthTypehealthStatusArray = Array of THealthStatus;
  TTargetPoolListTypeitemsArray = Array of TTargetPool;
  TTargetPoolsAddHealthCheckRequestTypehealthChecksArray = Array of THealthCheckReference;
  TTargetPoolsAddInstanceRequestTypeinstancesArray = Array of TInstanceReference;
  TTargetPoolsRemoveHealthCheckRequestTypehealthChecksArray = Array of THealthCheckReference;
  TTargetPoolsRemoveInstanceRequestTypeinstancesArray = Array of TInstanceReference;
  TTargetPoolsScopedListTypetargetPoolsArray = Array of TTargetPool;
  TTargetPoolsScopedListTypewarningTypedataArray = Array of TTargetPoolsScopedListTypewarningTypedataItem;
  TTargetVpnGatewayListTypeitemsArray = Array of TTargetVpnGateway;
  TTargetVpnGatewaysScopedListTypetargetVpnGatewaysArray = Array of TTargetVpnGateway;
  TTargetVpnGatewaysScopedListTypewarningTypedataArray = Array of TTargetVpnGatewaysScopedListTypewarningTypedataItem;
  TUrlMapTypehostRulesArray = Array of THostRule;
  TUrlMapTypepathMatchersArray = Array of TPathMatcher;
  TUrlMapTypetestsArray = Array of TUrlMapTest;
  TUrlMapListTypeitemsArray = Array of TUrlMap;
  TUrlMapValidationResultTypetestFailuresArray = Array of TTestFailure;
  TVpnTunnelListTypeitemsArray = Array of TVpnTunnel;
  TVpnTunnelsScopedListTypevpnTunnelsArray = Array of TVpnTunnel;
  TVpnTunnelsScopedListTypewarningTypedataArray = Array of TVpnTunnelsScopedListTypewarningTypedataItem;
  TZoneListTypeitemsArray = Array of TZone;
  
  { --------------------------------------------------------------------
    TAccessConfig
    --------------------------------------------------------------------}
  
  TAccessConfig = Class(TGoogleBaseObject)
  Private
    Fkind : String;
    Fname : String;
    FnatIP : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnatIP(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property kind : String Index 0 Read Fkind Write Setkind;
    Property name : String Index 8 Read Fname Write Setname;
    Property natIP : String Index 16 Read FnatIP Write SetnatIP;
    Property _type : String Index 24 Read F_type Write Set_type;
  end;
  TAccessConfigClass = Class of TAccessConfig;
  
  { --------------------------------------------------------------------
    TAddress
    --------------------------------------------------------------------}
  
  TAddress = Class(TGoogleBaseObject)
  Private
    Faddress : String;
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fregion : String;
    FselfLink : String;
    Fstatus : String;
    Fusers : TStringArray;
  Protected
    //Property setters
    Procedure Setaddress(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure Setusers(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property address : String Index 0 Read Faddress Write Setaddress;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property region : String Index 48 Read Fregion Write Setregion;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property status : String Index 64 Read Fstatus Write Setstatus;
    Property users : TStringArray Index 72 Read Fusers Write Setusers;
  end;
  TAddressClass = Class of TAddress;
  
  { --------------------------------------------------------------------
    TAddressAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TAddressAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TAddressAggregatedListTypeitemsClass = Class of TAddressAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TAddressAggregatedList
    --------------------------------------------------------------------}
  
  TAddressAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TAddressAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAddressAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TAddressAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TAddressAggregatedListClass = Class of TAddressAggregatedList;
  
  { --------------------------------------------------------------------
    TAddressList
    --------------------------------------------------------------------}
  
  TAddressList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TAddressListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAddressListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TAddressListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TAddressListClass = Class of TAddressList;
  
  { --------------------------------------------------------------------
    TAddressesScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TAddressesScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TAddressesScopedListTypewarningTypedataItemClass = Class of TAddressesScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TAddressesScopedListTypewarning
    --------------------------------------------------------------------}
  
  TAddressesScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TAddressesScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TAddressesScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TAddressesScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TAddressesScopedListTypewarningClass = Class of TAddressesScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TAddressesScopedList
    --------------------------------------------------------------------}
  
  TAddressesScopedList = Class(TGoogleBaseObject)
  Private
    Faddresses : TAddressesScopedListTypeaddressesArray;
    Fwarning : TAddressesScopedListTypewarning;
  Protected
    //Property setters
    Procedure Setaddresses(AIndex : Integer; const AValue : TAddressesScopedListTypeaddressesArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TAddressesScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property addresses : TAddressesScopedListTypeaddressesArray Index 0 Read Faddresses Write Setaddresses;
    Property warning : TAddressesScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TAddressesScopedListClass = Class of TAddressesScopedList;
  
  { --------------------------------------------------------------------
    TAttachedDisk
    --------------------------------------------------------------------}
  
  TAttachedDisk = Class(TGoogleBaseObject)
  Private
    FautoDelete : boolean;
    Fboot : boolean;
    FdeviceName : String;
    Findex : integer;
    FinitializeParams : TAttachedDiskInitializeParams;
    F_interface : String;
    Fkind : String;
    Flicenses : TStringArray;
    Fmode : String;
    Fsource : String;
    F_type : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetautoDelete(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setboot(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetdeviceName(AIndex : Integer; const AValue : String); virtual;
    Procedure Setindex(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetinitializeParams(AIndex : Integer; const AValue : TAttachedDiskInitializeParams); virtual;
    Procedure Set_interface(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlicenses(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setmode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsource(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property autoDelete : boolean Index 0 Read FautoDelete Write SetautoDelete;
    Property boot : boolean Index 8 Read Fboot Write Setboot;
    Property deviceName : String Index 16 Read FdeviceName Write SetdeviceName;
    Property index : integer Index 24 Read Findex Write Setindex;
    Property initializeParams : TAttachedDiskInitializeParams Index 32 Read FinitializeParams Write SetinitializeParams;
    Property _interface : String Index 40 Read F_interface Write Set_interface;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property licenses : TStringArray Index 56 Read Flicenses Write Setlicenses;
    Property mode : String Index 64 Read Fmode Write Setmode;
    Property source : String Index 72 Read Fsource Write Setsource;
    Property _type : String Index 80 Read F_type Write Set_type;
  end;
  TAttachedDiskClass = Class of TAttachedDisk;
  
  { --------------------------------------------------------------------
    TAttachedDiskInitializeParams
    --------------------------------------------------------------------}
  
  TAttachedDiskInitializeParams = Class(TGoogleBaseObject)
  Private
    FdiskName : String;
    FdiskSizeGb : String;
    FdiskType : String;
    FsourceImage : String;
  Protected
    //Property setters
    Procedure SetdiskName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdiskSizeGb(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdiskType(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceImage(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property diskName : String Index 0 Read FdiskName Write SetdiskName;
    Property diskSizeGb : String Index 8 Read FdiskSizeGb Write SetdiskSizeGb;
    Property diskType : String Index 16 Read FdiskType Write SetdiskType;
    Property sourceImage : String Index 24 Read FsourceImage Write SetsourceImage;
  end;
  TAttachedDiskInitializeParamsClass = Class of TAttachedDiskInitializeParams;
  
  { --------------------------------------------------------------------
    TAutoscaler
    --------------------------------------------------------------------}
  
  TAutoscaler = Class(TGoogleBaseObject)
  Private
    FautoscalingPolicy : TAutoscalingPolicy;
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FselfLink : String;
    Ftarget : String;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetautoscalingPolicy(AIndex : Integer; const AValue : TAutoscalingPolicy); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Settarget(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property autoscalingPolicy : TAutoscalingPolicy Index 0 Read FautoscalingPolicy Write SetautoscalingPolicy;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property selfLink : String Index 48 Read FselfLink Write SetselfLink;
    Property target : String Index 56 Read Ftarget Write Settarget;
    Property zone : String Index 64 Read Fzone Write Setzone;
  end;
  TAutoscalerClass = Class of TAutoscaler;
  
  { --------------------------------------------------------------------
    TAutoscalerAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TAutoscalerAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TAutoscalerAggregatedListTypeitemsClass = Class of TAutoscalerAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TAutoscalerAggregatedList
    --------------------------------------------------------------------}
  
  TAutoscalerAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TAutoscalerAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAutoscalerAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TAutoscalerAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TAutoscalerAggregatedListClass = Class of TAutoscalerAggregatedList;
  
  { --------------------------------------------------------------------
    TAutoscalerList
    --------------------------------------------------------------------}
  
  TAutoscalerList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TAutoscalerListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TAutoscalerListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TAutoscalerListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TAutoscalerListClass = Class of TAutoscalerList;
  
  { --------------------------------------------------------------------
    TAutoscalersScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TAutoscalersScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TAutoscalersScopedListTypewarningTypedataItemClass = Class of TAutoscalersScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TAutoscalersScopedListTypewarning
    --------------------------------------------------------------------}
  
  TAutoscalersScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TAutoscalersScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TAutoscalersScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TAutoscalersScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TAutoscalersScopedListTypewarningClass = Class of TAutoscalersScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TAutoscalersScopedList
    --------------------------------------------------------------------}
  
  TAutoscalersScopedList = Class(TGoogleBaseObject)
  Private
    Fautoscalers : TAutoscalersScopedListTypeautoscalersArray;
    Fwarning : TAutoscalersScopedListTypewarning;
  Protected
    //Property setters
    Procedure Setautoscalers(AIndex : Integer; const AValue : TAutoscalersScopedListTypeautoscalersArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TAutoscalersScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property autoscalers : TAutoscalersScopedListTypeautoscalersArray Index 0 Read Fautoscalers Write Setautoscalers;
    Property warning : TAutoscalersScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TAutoscalersScopedListClass = Class of TAutoscalersScopedList;
  
  { --------------------------------------------------------------------
    TAutoscalingPolicy
    --------------------------------------------------------------------}
  
  TAutoscalingPolicy = Class(TGoogleBaseObject)
  Private
    FcoolDownPeriodSec : integer;
    FcpuUtilization : TAutoscalingPolicyCpuUtilization;
    FcustomMetricUtilizations : TAutoscalingPolicyTypecustomMetricUtilizationsArray;
    FloadBalancingUtilization : TAutoscalingPolicyLoadBalancingUtilization;
    FmaxNumReplicas : integer;
    FminNumReplicas : integer;
  Protected
    //Property setters
    Procedure SetcoolDownPeriodSec(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetcpuUtilization(AIndex : Integer; const AValue : TAutoscalingPolicyCpuUtilization); virtual;
    Procedure SetcustomMetricUtilizations(AIndex : Integer; const AValue : TAutoscalingPolicyTypecustomMetricUtilizationsArray); virtual;
    Procedure SetloadBalancingUtilization(AIndex : Integer; const AValue : TAutoscalingPolicyLoadBalancingUtilization); virtual;
    Procedure SetmaxNumReplicas(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetminNumReplicas(AIndex : Integer; const AValue : integer); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property coolDownPeriodSec : integer Index 0 Read FcoolDownPeriodSec Write SetcoolDownPeriodSec;
    Property cpuUtilization : TAutoscalingPolicyCpuUtilization Index 8 Read FcpuUtilization Write SetcpuUtilization;
    Property customMetricUtilizations : TAutoscalingPolicyTypecustomMetricUtilizationsArray Index 16 Read FcustomMetricUtilizations Write SetcustomMetricUtilizations;
    Property loadBalancingUtilization : TAutoscalingPolicyLoadBalancingUtilization Index 24 Read FloadBalancingUtilization Write SetloadBalancingUtilization;
    Property maxNumReplicas : integer Index 32 Read FmaxNumReplicas Write SetmaxNumReplicas;
    Property minNumReplicas : integer Index 40 Read FminNumReplicas Write SetminNumReplicas;
  end;
  TAutoscalingPolicyClass = Class of TAutoscalingPolicy;
  
  { --------------------------------------------------------------------
    TAutoscalingPolicyCpuUtilization
    --------------------------------------------------------------------}
  
  TAutoscalingPolicyCpuUtilization = Class(TGoogleBaseObject)
  Private
    FutilizationTarget : double;
  Protected
    //Property setters
    Procedure SetutilizationTarget(AIndex : Integer; const AValue : double); virtual;
  Public
  Published
    Property utilizationTarget : double Index 0 Read FutilizationTarget Write SetutilizationTarget;
  end;
  TAutoscalingPolicyCpuUtilizationClass = Class of TAutoscalingPolicyCpuUtilization;
  
  { --------------------------------------------------------------------
    TAutoscalingPolicyCustomMetricUtilization
    --------------------------------------------------------------------}
  
  TAutoscalingPolicyCustomMetricUtilization = Class(TGoogleBaseObject)
  Private
    Fmetric : String;
    FutilizationTarget : double;
    FutilizationTargetType : String;
  Protected
    //Property setters
    Procedure Setmetric(AIndex : Integer; const AValue : String); virtual;
    Procedure SetutilizationTarget(AIndex : Integer; const AValue : double); virtual;
    Procedure SetutilizationTargetType(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property metric : String Index 0 Read Fmetric Write Setmetric;
    Property utilizationTarget : double Index 8 Read FutilizationTarget Write SetutilizationTarget;
    Property utilizationTargetType : String Index 16 Read FutilizationTargetType Write SetutilizationTargetType;
  end;
  TAutoscalingPolicyCustomMetricUtilizationClass = Class of TAutoscalingPolicyCustomMetricUtilization;
  
  { --------------------------------------------------------------------
    TAutoscalingPolicyLoadBalancingUtilization
    --------------------------------------------------------------------}
  
  TAutoscalingPolicyLoadBalancingUtilization = Class(TGoogleBaseObject)
  Private
    FutilizationTarget : double;
  Protected
    //Property setters
    Procedure SetutilizationTarget(AIndex : Integer; const AValue : double); virtual;
  Public
  Published
    Property utilizationTarget : double Index 0 Read FutilizationTarget Write SetutilizationTarget;
  end;
  TAutoscalingPolicyLoadBalancingUtilizationClass = Class of TAutoscalingPolicyLoadBalancingUtilization;
  
  { --------------------------------------------------------------------
    TBackend
    --------------------------------------------------------------------}
  
  TBackend = Class(TGoogleBaseObject)
  Private
    FbalancingMode : String;
    FcapacityScaler : integer;
    Fdescription : String;
    Fgroup : String;
    FmaxRate : integer;
    FmaxRatePerInstance : integer;
    FmaxUtilization : integer;
  Protected
    //Property setters
    Procedure SetbalancingMode(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcapacityScaler(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setgroup(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmaxRate(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetmaxRatePerInstance(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetmaxUtilization(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property balancingMode : String Index 0 Read FbalancingMode Write SetbalancingMode;
    Property capacityScaler : integer Index 8 Read FcapacityScaler Write SetcapacityScaler;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property group : String Index 24 Read Fgroup Write Setgroup;
    Property maxRate : integer Index 32 Read FmaxRate Write SetmaxRate;
    Property maxRatePerInstance : integer Index 40 Read FmaxRatePerInstance Write SetmaxRatePerInstance;
    Property maxUtilization : integer Index 48 Read FmaxUtilization Write SetmaxUtilization;
  end;
  TBackendClass = Class of TBackend;
  
  { --------------------------------------------------------------------
    TBackendService
    --------------------------------------------------------------------}
  
  TBackendService = Class(TGoogleBaseObject)
  Private
    Fbackends : TBackendServiceTypebackendsArray;
    FcreationTimestamp : String;
    Fdescription : String;
    Ffingerprint : String;
    FhealthChecks : TStringArray;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fport : integer;
    FportName : String;
    Fprotocol : String;
    Fregion : String;
    FselfLink : String;
    FtimeoutSec : integer;
  Protected
    //Property setters
    Procedure Setbackends(AIndex : Integer; const AValue : TBackendServiceTypebackendsArray); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure SethealthChecks(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setport(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetportName(AIndex : Integer; const AValue : String); virtual;
    Procedure Setprotocol(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeoutSec(AIndex : Integer; const AValue : integer); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property backends : TBackendServiceTypebackendsArray Index 0 Read Fbackends Write Setbackends;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property fingerprint : String Index 24 Read Ffingerprint Write Setfingerprint;
    Property healthChecks : TStringArray Index 32 Read FhealthChecks Write SethealthChecks;
    Property id : String Index 40 Read Fid Write Setid;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property name : String Index 56 Read Fname Write Setname;
    Property port : integer Index 64 Read Fport Write Setport;
    Property portName : String Index 72 Read FportName Write SetportName;
    Property protocol : String Index 80 Read Fprotocol Write Setprotocol;
    Property region : String Index 88 Read Fregion Write Setregion;
    Property selfLink : String Index 96 Read FselfLink Write SetselfLink;
    Property timeoutSec : integer Index 104 Read FtimeoutSec Write SettimeoutSec;
  end;
  TBackendServiceClass = Class of TBackendService;
  
  { --------------------------------------------------------------------
    TBackendServiceGroupHealth
    --------------------------------------------------------------------}
  
  TBackendServiceGroupHealth = Class(TGoogleBaseObject)
  Private
    FhealthStatus : TBackendServiceGroupHealthTypehealthStatusArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure SethealthStatus(AIndex : Integer; const AValue : TBackendServiceGroupHealthTypehealthStatusArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property healthStatus : TBackendServiceGroupHealthTypehealthStatusArray Index 0 Read FhealthStatus Write SethealthStatus;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TBackendServiceGroupHealthClass = Class of TBackendServiceGroupHealth;
  
  { --------------------------------------------------------------------
    TBackendServiceList
    --------------------------------------------------------------------}
  
  TBackendServiceList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TBackendServiceListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TBackendServiceListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TBackendServiceListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TBackendServiceListClass = Class of TBackendServiceList;
  
  { --------------------------------------------------------------------
    TDeprecationStatus
    --------------------------------------------------------------------}
  
  TDeprecationStatus = Class(TGoogleBaseObject)
  Private
    Fdeleted : String;
    Fdeprecated : String;
    Fobsolete : String;
    Freplacement : String;
    Fstate : String;
  Protected
    //Property setters
    Procedure Setdeleted(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdeprecated(AIndex : Integer; const AValue : String); virtual;
    Procedure Setobsolete(AIndex : Integer; const AValue : String); virtual;
    Procedure Setreplacement(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstate(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property deleted : String Index 0 Read Fdeleted Write Setdeleted;
    Property deprecated : String Index 8 Read Fdeprecated Write Setdeprecated;
    Property obsolete : String Index 16 Read Fobsolete Write Setobsolete;
    Property replacement : String Index 24 Read Freplacement Write Setreplacement;
    Property state : String Index 32 Read Fstate Write Setstate;
  end;
  TDeprecationStatusClass = Class of TDeprecationStatus;
  
  { --------------------------------------------------------------------
    TDisk
    --------------------------------------------------------------------}
  
  TDisk = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    FlastAttachTimestamp : String;
    FlastDetachTimestamp : String;
    Flicenses : TStringArray;
    Fname : String;
    Foptions : String;
    FselfLink : String;
    FsizeGb : String;
    FsourceImage : String;
    FsourceImageId : String;
    FsourceSnapshot : String;
    FsourceSnapshotId : String;
    Fstatus : String;
    F_type : String;
    Fusers : TStringArray;
    Fzone : String;
  Protected
    Class Function ExportPropertyName(Const AName : String) : string; override;
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetlastAttachTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure SetlastDetachTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlicenses(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setoptions(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsizeGb(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceImage(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceImageId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceSnapshot(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceSnapshotId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure Set_type(AIndex : Integer; const AValue : String); virtual;
    Procedure Setusers(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property id : String Index 16 Read Fid Write Setid;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property lastAttachTimestamp : String Index 32 Read FlastAttachTimestamp Write SetlastAttachTimestamp;
    Property lastDetachTimestamp : String Index 40 Read FlastDetachTimestamp Write SetlastDetachTimestamp;
    Property licenses : TStringArray Index 48 Read Flicenses Write Setlicenses;
    Property name : String Index 56 Read Fname Write Setname;
    Property options : String Index 64 Read Foptions Write Setoptions;
    Property selfLink : String Index 72 Read FselfLink Write SetselfLink;
    Property sizeGb : String Index 80 Read FsizeGb Write SetsizeGb;
    Property sourceImage : String Index 88 Read FsourceImage Write SetsourceImage;
    Property sourceImageId : String Index 96 Read FsourceImageId Write SetsourceImageId;
    Property sourceSnapshot : String Index 104 Read FsourceSnapshot Write SetsourceSnapshot;
    Property sourceSnapshotId : String Index 112 Read FsourceSnapshotId Write SetsourceSnapshotId;
    Property status : String Index 120 Read Fstatus Write Setstatus;
    Property _type : String Index 128 Read F_type Write Set_type;
    Property users : TStringArray Index 136 Read Fusers Write Setusers;
    Property zone : String Index 144 Read Fzone Write Setzone;
  end;
  TDiskClass = Class of TDisk;
  
  { --------------------------------------------------------------------
    TDiskAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TDiskAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TDiskAggregatedListTypeitemsClass = Class of TDiskAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TDiskAggregatedList
    --------------------------------------------------------------------}
  
  TDiskAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TDiskAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TDiskAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TDiskAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TDiskAggregatedListClass = Class of TDiskAggregatedList;
  
  { --------------------------------------------------------------------
    TDiskList
    --------------------------------------------------------------------}
  
  TDiskList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TDiskListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TDiskListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TDiskListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TDiskListClass = Class of TDiskList;
  
  { --------------------------------------------------------------------
    TDiskMoveRequest
    --------------------------------------------------------------------}
  
  TDiskMoveRequest = Class(TGoogleBaseObject)
  Private
    FdestinationZone : String;
    FtargetDisk : String;
  Protected
    //Property setters
    Procedure SetdestinationZone(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetDisk(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property destinationZone : String Index 0 Read FdestinationZone Write SetdestinationZone;
    Property targetDisk : String Index 8 Read FtargetDisk Write SettargetDisk;
  end;
  TDiskMoveRequestClass = Class of TDiskMoveRequest;
  
  { --------------------------------------------------------------------
    TDiskType
    --------------------------------------------------------------------}
  
  TDiskType = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    FdefaultDiskSizeGb : String;
    Fdeprecated : TDeprecationStatus;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FselfLink : String;
    FvalidDiskSize : String;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdefaultDiskSizeGb(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetvalidDiskSize(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property defaultDiskSizeGb : String Index 8 Read FdefaultDiskSizeGb Write SetdefaultDiskSizeGb;
    Property deprecated : TDeprecationStatus Index 16 Read Fdeprecated Write Setdeprecated;
    Property description : String Index 24 Read Fdescription Write Setdescription;
    Property id : String Index 32 Read Fid Write Setid;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property name : String Index 48 Read Fname Write Setname;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property validDiskSize : String Index 64 Read FvalidDiskSize Write SetvalidDiskSize;
    Property zone : String Index 72 Read Fzone Write Setzone;
  end;
  TDiskTypeClass = Class of TDiskType;
  
  { --------------------------------------------------------------------
    TDiskTypeAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TDiskTypeAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TDiskTypeAggregatedListTypeitemsClass = Class of TDiskTypeAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TDiskTypeAggregatedList
    --------------------------------------------------------------------}
  
  TDiskTypeAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TDiskTypeAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TDiskTypeAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TDiskTypeAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TDiskTypeAggregatedListClass = Class of TDiskTypeAggregatedList;
  
  { --------------------------------------------------------------------
    TDiskTypeList
    --------------------------------------------------------------------}
  
  TDiskTypeList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TDiskTypeListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TDiskTypeListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TDiskTypeListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TDiskTypeListClass = Class of TDiskTypeList;
  
  { --------------------------------------------------------------------
    TDiskTypesScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TDiskTypesScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TDiskTypesScopedListTypewarningTypedataItemClass = Class of TDiskTypesScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TDiskTypesScopedListTypewarning
    --------------------------------------------------------------------}
  
  TDiskTypesScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TDiskTypesScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TDiskTypesScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TDiskTypesScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TDiskTypesScopedListTypewarningClass = Class of TDiskTypesScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TDiskTypesScopedList
    --------------------------------------------------------------------}
  
  TDiskTypesScopedList = Class(TGoogleBaseObject)
  Private
    FdiskTypes : TDiskTypesScopedListTypediskTypesArray;
    Fwarning : TDiskTypesScopedListTypewarning;
  Protected
    //Property setters
    Procedure SetdiskTypes(AIndex : Integer; const AValue : TDiskTypesScopedListTypediskTypesArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TDiskTypesScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property diskTypes : TDiskTypesScopedListTypediskTypesArray Index 0 Read FdiskTypes Write SetdiskTypes;
    Property warning : TDiskTypesScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TDiskTypesScopedListClass = Class of TDiskTypesScopedList;
  
  { --------------------------------------------------------------------
    TDisksResizeRequest
    --------------------------------------------------------------------}
  
  TDisksResizeRequest = Class(TGoogleBaseObject)
  Private
    FsizeGb : String;
  Protected
    //Property setters
    Procedure SetsizeGb(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property sizeGb : String Index 0 Read FsizeGb Write SetsizeGb;
  end;
  TDisksResizeRequestClass = Class of TDisksResizeRequest;
  
  { --------------------------------------------------------------------
    TDisksScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TDisksScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TDisksScopedListTypewarningTypedataItemClass = Class of TDisksScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TDisksScopedListTypewarning
    --------------------------------------------------------------------}
  
  TDisksScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TDisksScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TDisksScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TDisksScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TDisksScopedListTypewarningClass = Class of TDisksScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TDisksScopedList
    --------------------------------------------------------------------}
  
  TDisksScopedList = Class(TGoogleBaseObject)
  Private
    Fdisks : TDisksScopedListTypedisksArray;
    Fwarning : TDisksScopedListTypewarning;
  Protected
    //Property setters
    Procedure Setdisks(AIndex : Integer; const AValue : TDisksScopedListTypedisksArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TDisksScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property disks : TDisksScopedListTypedisksArray Index 0 Read Fdisks Write Setdisks;
    Property warning : TDisksScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TDisksScopedListClass = Class of TDisksScopedList;
  
  { --------------------------------------------------------------------
    TFirewallTypeallowedItem
    --------------------------------------------------------------------}
  
  TFirewallTypeallowedItem = Class(TGoogleBaseObject)
  Private
    FIPProtocol : String;
    Fports : TStringArray;
  Protected
    //Property setters
    Procedure SetIPProtocol(AIndex : Integer; const AValue : String); virtual;
    Procedure Setports(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property IPProtocol : String Index 0 Read FIPProtocol Write SetIPProtocol;
    Property ports : TStringArray Index 8 Read Fports Write Setports;
  end;
  TFirewallTypeallowedItemClass = Class of TFirewallTypeallowedItem;
  
  { --------------------------------------------------------------------
    TFirewall
    --------------------------------------------------------------------}
  
  TFirewall = Class(TGoogleBaseObject)
  Private
    Fallowed : TFirewallTypeallowedArray;
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fnetwork : String;
    FselfLink : String;
    FsourceRanges : TStringArray;
    FsourceTags : TStringArray;
    FtargetTags : TStringArray;
  Protected
    //Property setters
    Procedure Setallowed(AIndex : Integer; const AValue : TFirewallTypeallowedArray); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setnetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceRanges(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetsourceTags(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SettargetTags(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property allowed : TFirewallTypeallowedArray Index 0 Read Fallowed Write Setallowed;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property network : String Index 48 Read Fnetwork Write Setnetwork;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property sourceRanges : TStringArray Index 64 Read FsourceRanges Write SetsourceRanges;
    Property sourceTags : TStringArray Index 72 Read FsourceTags Write SetsourceTags;
    Property targetTags : TStringArray Index 80 Read FtargetTags Write SettargetTags;
  end;
  TFirewallClass = Class of TFirewall;
  
  { --------------------------------------------------------------------
    TFirewallList
    --------------------------------------------------------------------}
  
  TFirewallList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TFirewallListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TFirewallListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TFirewallListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TFirewallListClass = Class of TFirewallList;
  
  { --------------------------------------------------------------------
    TForwardingRule
    --------------------------------------------------------------------}
  
  TForwardingRule = Class(TGoogleBaseObject)
  Private
    FIPAddress : String;
    FIPProtocol : String;
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FportRange : String;
    Fregion : String;
    FselfLink : String;
    Ftarget : String;
  Protected
    //Property setters
    Procedure SetIPAddress(AIndex : Integer; const AValue : String); virtual;
    Procedure SetIPProtocol(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetportRange(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Settarget(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property IPAddress : String Index 0 Read FIPAddress Write SetIPAddress;
    Property IPProtocol : String Index 8 Read FIPProtocol Write SetIPProtocol;
    Property creationTimestamp : String Index 16 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 24 Read Fdescription Write Setdescription;
    Property id : String Index 32 Read Fid Write Setid;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property name : String Index 48 Read Fname Write Setname;
    Property portRange : String Index 56 Read FportRange Write SetportRange;
    Property region : String Index 64 Read Fregion Write Setregion;
    Property selfLink : String Index 72 Read FselfLink Write SetselfLink;
    Property target : String Index 80 Read Ftarget Write Settarget;
  end;
  TForwardingRuleClass = Class of TForwardingRule;
  
  { --------------------------------------------------------------------
    TForwardingRuleAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TForwardingRuleAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TForwardingRuleAggregatedListTypeitemsClass = Class of TForwardingRuleAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TForwardingRuleAggregatedList
    --------------------------------------------------------------------}
  
  TForwardingRuleAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TForwardingRuleAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TForwardingRuleAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TForwardingRuleAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TForwardingRuleAggregatedListClass = Class of TForwardingRuleAggregatedList;
  
  { --------------------------------------------------------------------
    TForwardingRuleList
    --------------------------------------------------------------------}
  
  TForwardingRuleList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TForwardingRuleListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TForwardingRuleListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TForwardingRuleListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TForwardingRuleListClass = Class of TForwardingRuleList;
  
  { --------------------------------------------------------------------
    TForwardingRulesScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TForwardingRulesScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TForwardingRulesScopedListTypewarningTypedataItemClass = Class of TForwardingRulesScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TForwardingRulesScopedListTypewarning
    --------------------------------------------------------------------}
  
  TForwardingRulesScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TForwardingRulesScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TForwardingRulesScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TForwardingRulesScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TForwardingRulesScopedListTypewarningClass = Class of TForwardingRulesScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TForwardingRulesScopedList
    --------------------------------------------------------------------}
  
  TForwardingRulesScopedList = Class(TGoogleBaseObject)
  Private
    FforwardingRules : TForwardingRulesScopedListTypeforwardingRulesArray;
    Fwarning : TForwardingRulesScopedListTypewarning;
  Protected
    //Property setters
    Procedure SetforwardingRules(AIndex : Integer; const AValue : TForwardingRulesScopedListTypeforwardingRulesArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TForwardingRulesScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property forwardingRules : TForwardingRulesScopedListTypeforwardingRulesArray Index 0 Read FforwardingRules Write SetforwardingRules;
    Property warning : TForwardingRulesScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TForwardingRulesScopedListClass = Class of TForwardingRulesScopedList;
  
  { --------------------------------------------------------------------
    THealthCheckReference
    --------------------------------------------------------------------}
  
  THealthCheckReference = Class(TGoogleBaseObject)
  Private
    FhealthCheck : String;
  Protected
    //Property setters
    Procedure SethealthCheck(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property healthCheck : String Index 0 Read FhealthCheck Write SethealthCheck;
  end;
  THealthCheckReferenceClass = Class of THealthCheckReference;
  
  { --------------------------------------------------------------------
    THealthStatus
    --------------------------------------------------------------------}
  
  THealthStatus = Class(TGoogleBaseObject)
  Private
    FhealthState : String;
    Finstance : String;
    FipAddress : String;
    Fport : integer;
  Protected
    //Property setters
    Procedure SethealthState(AIndex : Integer; const AValue : String); virtual;
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure SetipAddress(AIndex : Integer; const AValue : String); virtual;
    Procedure Setport(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property healthState : String Index 0 Read FhealthState Write SethealthState;
    Property instance : String Index 8 Read Finstance Write Setinstance;
    Property ipAddress : String Index 16 Read FipAddress Write SetipAddress;
    Property port : integer Index 24 Read Fport Write Setport;
  end;
  THealthStatusClass = Class of THealthStatus;
  
  { --------------------------------------------------------------------
    THostRule
    --------------------------------------------------------------------}
  
  THostRule = Class(TGoogleBaseObject)
  Private
    Fdescription : String;
    Fhosts : TStringArray;
    FpathMatcher : String;
  Protected
    //Property setters
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Sethosts(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetpathMatcher(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property description : String Index 0 Read Fdescription Write Setdescription;
    Property hosts : TStringArray Index 8 Read Fhosts Write Sethosts;
    Property pathMatcher : String Index 16 Read FpathMatcher Write SetpathMatcher;
  end;
  THostRuleClass = Class of THostRule;
  
  { --------------------------------------------------------------------
    THttpHealthCheck
    --------------------------------------------------------------------}
  
  THttpHealthCheck = Class(TGoogleBaseObject)
  Private
    FcheckIntervalSec : integer;
    FcreationTimestamp : String;
    Fdescription : String;
    FhealthyThreshold : integer;
    Fhost : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fport : integer;
    FrequestPath : String;
    FselfLink : String;
    FtimeoutSec : integer;
    FunhealthyThreshold : integer;
  Protected
    //Property setters
    Procedure SetcheckIntervalSec(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SethealthyThreshold(AIndex : Integer; const AValue : integer); virtual;
    Procedure Sethost(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setport(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetrequestPath(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeoutSec(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetunhealthyThreshold(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property checkIntervalSec : integer Index 0 Read FcheckIntervalSec Write SetcheckIntervalSec;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property healthyThreshold : integer Index 24 Read FhealthyThreshold Write SethealthyThreshold;
    Property host : String Index 32 Read Fhost Write Sethost;
    Property id : String Index 40 Read Fid Write Setid;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property name : String Index 56 Read Fname Write Setname;
    Property port : integer Index 64 Read Fport Write Setport;
    Property requestPath : String Index 72 Read FrequestPath Write SetrequestPath;
    Property selfLink : String Index 80 Read FselfLink Write SetselfLink;
    Property timeoutSec : integer Index 88 Read FtimeoutSec Write SettimeoutSec;
    Property unhealthyThreshold : integer Index 96 Read FunhealthyThreshold Write SetunhealthyThreshold;
  end;
  THttpHealthCheckClass = Class of THttpHealthCheck;
  
  { --------------------------------------------------------------------
    THttpHealthCheckList
    --------------------------------------------------------------------}
  
  THttpHealthCheckList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : THttpHealthCheckListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : THttpHealthCheckListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : THttpHealthCheckListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  THttpHealthCheckListClass = Class of THttpHealthCheckList;
  
  { --------------------------------------------------------------------
    THttpsHealthCheck
    --------------------------------------------------------------------}
  
  THttpsHealthCheck = Class(TGoogleBaseObject)
  Private
    FcheckIntervalSec : integer;
    FcreationTimestamp : String;
    Fdescription : String;
    FhealthyThreshold : integer;
    Fhost : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fport : integer;
    FrequestPath : String;
    FselfLink : String;
    FtimeoutSec : integer;
    FunhealthyThreshold : integer;
  Protected
    //Property setters
    Procedure SetcheckIntervalSec(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SethealthyThreshold(AIndex : Integer; const AValue : integer); virtual;
    Procedure Sethost(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setport(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetrequestPath(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SettimeoutSec(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetunhealthyThreshold(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property checkIntervalSec : integer Index 0 Read FcheckIntervalSec Write SetcheckIntervalSec;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property healthyThreshold : integer Index 24 Read FhealthyThreshold Write SethealthyThreshold;
    Property host : String Index 32 Read Fhost Write Sethost;
    Property id : String Index 40 Read Fid Write Setid;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property name : String Index 56 Read Fname Write Setname;
    Property port : integer Index 64 Read Fport Write Setport;
    Property requestPath : String Index 72 Read FrequestPath Write SetrequestPath;
    Property selfLink : String Index 80 Read FselfLink Write SetselfLink;
    Property timeoutSec : integer Index 88 Read FtimeoutSec Write SettimeoutSec;
    Property unhealthyThreshold : integer Index 96 Read FunhealthyThreshold Write SetunhealthyThreshold;
  end;
  THttpsHealthCheckClass = Class of THttpsHealthCheck;
  
  { --------------------------------------------------------------------
    THttpsHealthCheckList
    --------------------------------------------------------------------}
  
  THttpsHealthCheckList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : THttpsHealthCheckListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : THttpsHealthCheckListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : THttpsHealthCheckListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  THttpsHealthCheckListClass = Class of THttpsHealthCheckList;
  
  { --------------------------------------------------------------------
    TImageTyperawDisk
    --------------------------------------------------------------------}
  
  TImageTyperawDisk = Class(TGoogleBaseObject)
  Private
    FcontainerType : String;
    Fsha1Checksum : String;
    Fsource : String;
  Protected
    //Property setters
    Procedure SetcontainerType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsha1Checksum(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsource(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property containerType : String Index 0 Read FcontainerType Write SetcontainerType;
    Property sha1Checksum : String Index 8 Read Fsha1Checksum Write Setsha1Checksum;
    Property source : String Index 16 Read Fsource Write Setsource;
  end;
  TImageTyperawDiskClass = Class of TImageTyperawDisk;
  
  { --------------------------------------------------------------------
    TImage
    --------------------------------------------------------------------}
  
  TImage = Class(TGoogleBaseObject)
  Private
    FarchiveSizeBytes : String;
    FcreationTimestamp : String;
    Fdeprecated : TDeprecationStatus;
    Fdescription : String;
    FdiskSizeGb : String;
    Ffamily : String;
    Fid : String;
    Fkind : String;
    Flicenses : TStringArray;
    Fname : String;
    FrawDisk : TImageTyperawDisk;
    FselfLink : String;
    FsourceDisk : String;
    FsourceDiskId : String;
    FsourceType : String;
    Fstatus : String;
  Protected
    //Property setters
    Procedure SetarchiveSizeBytes(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdiskSizeGb(AIndex : Integer; const AValue : String); virtual;
    Procedure Setfamily(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlicenses(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetrawDisk(AIndex : Integer; const AValue : TImageTyperawDisk); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceDisk(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceDiskId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property archiveSizeBytes : String Index 0 Read FarchiveSizeBytes Write SetarchiveSizeBytes;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property deprecated : TDeprecationStatus Index 16 Read Fdeprecated Write Setdeprecated;
    Property description : String Index 24 Read Fdescription Write Setdescription;
    Property diskSizeGb : String Index 32 Read FdiskSizeGb Write SetdiskSizeGb;
    Property family : String Index 40 Read Ffamily Write Setfamily;
    Property id : String Index 48 Read Fid Write Setid;
    Property kind : String Index 56 Read Fkind Write Setkind;
    Property licenses : TStringArray Index 64 Read Flicenses Write Setlicenses;
    Property name : String Index 72 Read Fname Write Setname;
    Property rawDisk : TImageTyperawDisk Index 80 Read FrawDisk Write SetrawDisk;
    Property selfLink : String Index 88 Read FselfLink Write SetselfLink;
    Property sourceDisk : String Index 96 Read FsourceDisk Write SetsourceDisk;
    Property sourceDiskId : String Index 104 Read FsourceDiskId Write SetsourceDiskId;
    Property sourceType : String Index 112 Read FsourceType Write SetsourceType;
    Property status : String Index 120 Read Fstatus Write Setstatus;
  end;
  TImageClass = Class of TImage;
  
  { --------------------------------------------------------------------
    TImageList
    --------------------------------------------------------------------}
  
  TImageList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TImageListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TImageListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TImageListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TImageListClass = Class of TImageList;
  
  { --------------------------------------------------------------------
    TInstance
    --------------------------------------------------------------------}
  
  TInstance = Class(TGoogleBaseObject)
  Private
    FcanIpForward : boolean;
    FcpuPlatform : String;
    FcreationTimestamp : String;
    Fdescription : String;
    Fdisks : TInstanceTypedisksArray;
    Fid : String;
    Fkind : String;
    FmachineType : String;
    Fmetadata : TMetadata;
    Fname : String;
    FnetworkInterfaces : TInstanceTypenetworkInterfacesArray;
    Fscheduling : TScheduling;
    FselfLink : String;
    FserviceAccounts : TInstanceTypeserviceAccountsArray;
    Fstatus : String;
    FstatusMessage : String;
    Ftags : TTags;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetcanIpForward(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetcpuPlatform(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdisks(AIndex : Integer; const AValue : TInstanceTypedisksArray); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmachineType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setmetadata(AIndex : Integer; const AValue : TMetadata); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnetworkInterfaces(AIndex : Integer; const AValue : TInstanceTypenetworkInterfacesArray); virtual;
    Procedure Setscheduling(AIndex : Integer; const AValue : TScheduling); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetserviceAccounts(AIndex : Integer; const AValue : TInstanceTypeserviceAccountsArray); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstatusMessage(AIndex : Integer; const AValue : String); virtual;
    Procedure Settags(AIndex : Integer; const AValue : TTags); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property canIpForward : boolean Index 0 Read FcanIpForward Write SetcanIpForward;
    Property cpuPlatform : String Index 8 Read FcpuPlatform Write SetcpuPlatform;
    Property creationTimestamp : String Index 16 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 24 Read Fdescription Write Setdescription;
    Property disks : TInstanceTypedisksArray Index 32 Read Fdisks Write Setdisks;
    Property id : String Index 40 Read Fid Write Setid;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property machineType : String Index 56 Read FmachineType Write SetmachineType;
    Property metadata : TMetadata Index 64 Read Fmetadata Write Setmetadata;
    Property name : String Index 72 Read Fname Write Setname;
    Property networkInterfaces : TInstanceTypenetworkInterfacesArray Index 80 Read FnetworkInterfaces Write SetnetworkInterfaces;
    Property scheduling : TScheduling Index 88 Read Fscheduling Write Setscheduling;
    Property selfLink : String Index 96 Read FselfLink Write SetselfLink;
    Property serviceAccounts : TInstanceTypeserviceAccountsArray Index 104 Read FserviceAccounts Write SetserviceAccounts;
    Property status : String Index 112 Read Fstatus Write Setstatus;
    Property statusMessage : String Index 120 Read FstatusMessage Write SetstatusMessage;
    Property tags : TTags Index 128 Read Ftags Write Settags;
    Property zone : String Index 136 Read Fzone Write Setzone;
  end;
  TInstanceClass = Class of TInstance;
  
  { --------------------------------------------------------------------
    TInstanceAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TInstanceAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TInstanceAggregatedListTypeitemsClass = Class of TInstanceAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TInstanceAggregatedList
    --------------------------------------------------------------------}
  
  TInstanceAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceAggregatedListClass = Class of TInstanceAggregatedList;
  
  { --------------------------------------------------------------------
    TInstanceGroup
    --------------------------------------------------------------------}
  
  TInstanceGroup = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    Ffingerprint : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FnamedPorts : TInstanceGroupTypenamedPortsArray;
    Fnetwork : String;
    FselfLink : String;
    Fsize : integer;
    Fsubnetwork : String;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnamedPorts(AIndex : Integer; const AValue : TInstanceGroupTypenamedPortsArray); virtual;
    Procedure Setnetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsize(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setsubnetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property fingerprint : String Index 16 Read Ffingerprint Write Setfingerprint;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property namedPorts : TInstanceGroupTypenamedPortsArray Index 48 Read FnamedPorts Write SetnamedPorts;
    Property network : String Index 56 Read Fnetwork Write Setnetwork;
    Property selfLink : String Index 64 Read FselfLink Write SetselfLink;
    Property size : integer Index 72 Read Fsize Write Setsize;
    Property subnetwork : String Index 80 Read Fsubnetwork Write Setsubnetwork;
    Property zone : String Index 88 Read Fzone Write Setzone;
  end;
  TInstanceGroupClass = Class of TInstanceGroup;
  
  { --------------------------------------------------------------------
    TInstanceGroupAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TInstanceGroupAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TInstanceGroupAggregatedListTypeitemsClass = Class of TInstanceGroupAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TInstanceGroupAggregatedList
    --------------------------------------------------------------------}
  
  TInstanceGroupAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceGroupAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceGroupAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceGroupAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceGroupAggregatedListClass = Class of TInstanceGroupAggregatedList;
  
  { --------------------------------------------------------------------
    TInstanceGroupList
    --------------------------------------------------------------------}
  
  TInstanceGroupList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceGroupListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceGroupListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceGroupListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceGroupListClass = Class of TInstanceGroupList;
  
  { --------------------------------------------------------------------
    TInstanceGroupManager
    --------------------------------------------------------------------}
  
  TInstanceGroupManager = Class(TGoogleBaseObject)
  Private
    FbaseInstanceName : String;
    FcreationTimestamp : String;
    FcurrentActions : TInstanceGroupManagerActionsSummary;
    Fdescription : String;
    Ffingerprint : String;
    Fid : String;
    FinstanceGroup : String;
    FinstanceTemplate : String;
    Fkind : String;
    Fname : String;
    FnamedPorts : TInstanceGroupManagerTypenamedPortsArray;
    FselfLink : String;
    FtargetPools : TStringArray;
    FtargetSize : integer;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetbaseInstanceName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcurrentActions(AIndex : Integer; const AValue : TInstanceGroupManagerActionsSummary); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure SetinstanceGroup(AIndex : Integer; const AValue : String); virtual;
    Procedure SetinstanceTemplate(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnamedPorts(AIndex : Integer; const AValue : TInstanceGroupManagerTypenamedPortsArray); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetPools(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SettargetSize(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property baseInstanceName : String Index 0 Read FbaseInstanceName Write SetbaseInstanceName;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property currentActions : TInstanceGroupManagerActionsSummary Index 16 Read FcurrentActions Write SetcurrentActions;
    Property description : String Index 24 Read Fdescription Write Setdescription;
    Property fingerprint : String Index 32 Read Ffingerprint Write Setfingerprint;
    Property id : String Index 40 Read Fid Write Setid;
    Property instanceGroup : String Index 48 Read FinstanceGroup Write SetinstanceGroup;
    Property instanceTemplate : String Index 56 Read FinstanceTemplate Write SetinstanceTemplate;
    Property kind : String Index 64 Read Fkind Write Setkind;
    Property name : String Index 72 Read Fname Write Setname;
    Property namedPorts : TInstanceGroupManagerTypenamedPortsArray Index 80 Read FnamedPorts Write SetnamedPorts;
    Property selfLink : String Index 88 Read FselfLink Write SetselfLink;
    Property targetPools : TStringArray Index 96 Read FtargetPools Write SettargetPools;
    Property targetSize : integer Index 104 Read FtargetSize Write SettargetSize;
    Property zone : String Index 112 Read Fzone Write Setzone;
  end;
  TInstanceGroupManagerClass = Class of TInstanceGroupManager;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagerActionsSummary
    --------------------------------------------------------------------}
  
  TInstanceGroupManagerActionsSummary = Class(TGoogleBaseObject)
  Private
    Fabandoning : integer;
    Fcreating : integer;
    Fdeleting : integer;
    Fnone : integer;
    Frecreating : integer;
    Frefreshing : integer;
    Frestarting : integer;
  Protected
    //Property setters
    Procedure Setabandoning(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setcreating(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setdeleting(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setnone(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setrecreating(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setrefreshing(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setrestarting(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property abandoning : integer Index 0 Read Fabandoning Write Setabandoning;
    Property creating : integer Index 8 Read Fcreating Write Setcreating;
    Property deleting : integer Index 16 Read Fdeleting Write Setdeleting;
    Property none : integer Index 24 Read Fnone Write Setnone;
    Property recreating : integer Index 32 Read Frecreating Write Setrecreating;
    Property refreshing : integer Index 40 Read Frefreshing Write Setrefreshing;
    Property restarting : integer Index 48 Read Frestarting Write Setrestarting;
  end;
  TInstanceGroupManagerActionsSummaryClass = Class of TInstanceGroupManagerActionsSummary;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagerAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TInstanceGroupManagerAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TInstanceGroupManagerAggregatedListTypeitemsClass = Class of TInstanceGroupManagerAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagerAggregatedList
    --------------------------------------------------------------------}
  
  TInstanceGroupManagerAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceGroupManagerAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceGroupManagerAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceGroupManagerAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceGroupManagerAggregatedListClass = Class of TInstanceGroupManagerAggregatedList;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagerList
    --------------------------------------------------------------------}
  
  TInstanceGroupManagerList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceGroupManagerListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceGroupManagerListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceGroupManagerListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceGroupManagerListClass = Class of TInstanceGroupManagerList;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersAbandonInstancesRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersAbandonInstancesRequest = Class(TGoogleBaseObject)
  Private
    Finstances : TStringArray;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TStringArray Index 0 Read Finstances Write Setinstances;
  end;
  TInstanceGroupManagersAbandonInstancesRequestClass = Class of TInstanceGroupManagersAbandonInstancesRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersDeleteInstancesRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersDeleteInstancesRequest = Class(TGoogleBaseObject)
  Private
    Finstances : TStringArray;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TStringArray Index 0 Read Finstances Write Setinstances;
  end;
  TInstanceGroupManagersDeleteInstancesRequestClass = Class of TInstanceGroupManagersDeleteInstancesRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersListManagedInstancesResponse
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersListManagedInstancesResponse = Class(TGoogleBaseObject)
  Private
    FmanagedInstances : TInstanceGroupManagersListManagedInstancesResponseTypemanagedInstancesArray;
  Protected
    //Property setters
    Procedure SetmanagedInstances(AIndex : Integer; const AValue : TInstanceGroupManagersListManagedInstancesResponseTypemanagedInstancesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property managedInstances : TInstanceGroupManagersListManagedInstancesResponseTypemanagedInstancesArray Index 0 Read FmanagedInstances Write SetmanagedInstances;
  end;
  TInstanceGroupManagersListManagedInstancesResponseClass = Class of TInstanceGroupManagersListManagedInstancesResponse;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersRecreateInstancesRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersRecreateInstancesRequest = Class(TGoogleBaseObject)
  Private
    Finstances : TStringArray;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TStringArray Index 0 Read Finstances Write Setinstances;
  end;
  TInstanceGroupManagersRecreateInstancesRequestClass = Class of TInstanceGroupManagersRecreateInstancesRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TInstanceGroupManagersScopedListTypewarningTypedataItemClass = Class of TInstanceGroupManagersScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersScopedListTypewarning
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TInstanceGroupManagersScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TInstanceGroupManagersScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TInstanceGroupManagersScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TInstanceGroupManagersScopedListTypewarningClass = Class of TInstanceGroupManagersScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersScopedList
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersScopedList = Class(TGoogleBaseObject)
  Private
    FinstanceGroupManagers : TInstanceGroupManagersScopedListTypeinstanceGroupManagersArray;
    Fwarning : TInstanceGroupManagersScopedListTypewarning;
  Protected
    //Property setters
    Procedure SetinstanceGroupManagers(AIndex : Integer; const AValue : TInstanceGroupManagersScopedListTypeinstanceGroupManagersArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TInstanceGroupManagersScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instanceGroupManagers : TInstanceGroupManagersScopedListTypeinstanceGroupManagersArray Index 0 Read FinstanceGroupManagers Write SetinstanceGroupManagers;
    Property warning : TInstanceGroupManagersScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TInstanceGroupManagersScopedListClass = Class of TInstanceGroupManagersScopedList;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersSetInstanceTemplateRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersSetInstanceTemplateRequest = Class(TGoogleBaseObject)
  Private
    FinstanceTemplate : String;
  Protected
    //Property setters
    Procedure SetinstanceTemplate(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property instanceTemplate : String Index 0 Read FinstanceTemplate Write SetinstanceTemplate;
  end;
  TInstanceGroupManagersSetInstanceTemplateRequestClass = Class of TInstanceGroupManagersSetInstanceTemplateRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersSetTargetPoolsRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupManagersSetTargetPoolsRequest = Class(TGoogleBaseObject)
  Private
    Ffingerprint : String;
    FtargetPools : TStringArray;
  Protected
    //Property setters
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetPools(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property fingerprint : String Index 0 Read Ffingerprint Write Setfingerprint;
    Property targetPools : TStringArray Index 8 Read FtargetPools Write SettargetPools;
  end;
  TInstanceGroupManagersSetTargetPoolsRequestClass = Class of TInstanceGroupManagersSetTargetPoolsRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupsAddInstancesRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupsAddInstancesRequest = Class(TGoogleBaseObject)
  Private
    Finstances : TInstanceGroupsAddInstancesRequestTypeinstancesArray;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TInstanceGroupsAddInstancesRequestTypeinstancesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TInstanceGroupsAddInstancesRequestTypeinstancesArray Index 0 Read Finstances Write Setinstances;
  end;
  TInstanceGroupsAddInstancesRequestClass = Class of TInstanceGroupsAddInstancesRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupsListInstances
    --------------------------------------------------------------------}
  
  TInstanceGroupsListInstances = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceGroupsListInstancesTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceGroupsListInstancesTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceGroupsListInstancesTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceGroupsListInstancesClass = Class of TInstanceGroupsListInstances;
  
  { --------------------------------------------------------------------
    TInstanceGroupsListInstancesRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupsListInstancesRequest = Class(TGoogleBaseObject)
  Private
    FinstanceState : String;
  Protected
    //Property setters
    Procedure SetinstanceState(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property instanceState : String Index 0 Read FinstanceState Write SetinstanceState;
  end;
  TInstanceGroupsListInstancesRequestClass = Class of TInstanceGroupsListInstancesRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupsRemoveInstancesRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupsRemoveInstancesRequest = Class(TGoogleBaseObject)
  Private
    Finstances : TInstanceGroupsRemoveInstancesRequestTypeinstancesArray;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TInstanceGroupsRemoveInstancesRequestTypeinstancesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TInstanceGroupsRemoveInstancesRequestTypeinstancesArray Index 0 Read Finstances Write Setinstances;
  end;
  TInstanceGroupsRemoveInstancesRequestClass = Class of TInstanceGroupsRemoveInstancesRequest;
  
  { --------------------------------------------------------------------
    TInstanceGroupsScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TInstanceGroupsScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TInstanceGroupsScopedListTypewarningTypedataItemClass = Class of TInstanceGroupsScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TInstanceGroupsScopedListTypewarning
    --------------------------------------------------------------------}
  
  TInstanceGroupsScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TInstanceGroupsScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TInstanceGroupsScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TInstanceGroupsScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TInstanceGroupsScopedListTypewarningClass = Class of TInstanceGroupsScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TInstanceGroupsScopedList
    --------------------------------------------------------------------}
  
  TInstanceGroupsScopedList = Class(TGoogleBaseObject)
  Private
    FinstanceGroups : TInstanceGroupsScopedListTypeinstanceGroupsArray;
    Fwarning : TInstanceGroupsScopedListTypewarning;
  Protected
    //Property setters
    Procedure SetinstanceGroups(AIndex : Integer; const AValue : TInstanceGroupsScopedListTypeinstanceGroupsArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TInstanceGroupsScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instanceGroups : TInstanceGroupsScopedListTypeinstanceGroupsArray Index 0 Read FinstanceGroups Write SetinstanceGroups;
    Property warning : TInstanceGroupsScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TInstanceGroupsScopedListClass = Class of TInstanceGroupsScopedList;
  
  { --------------------------------------------------------------------
    TInstanceGroupsSetNamedPortsRequest
    --------------------------------------------------------------------}
  
  TInstanceGroupsSetNamedPortsRequest = Class(TGoogleBaseObject)
  Private
    Ffingerprint : String;
    FnamedPorts : TInstanceGroupsSetNamedPortsRequestTypenamedPortsArray;
  Protected
    //Property setters
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnamedPorts(AIndex : Integer; const AValue : TInstanceGroupsSetNamedPortsRequestTypenamedPortsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property fingerprint : String Index 0 Read Ffingerprint Write Setfingerprint;
    Property namedPorts : TInstanceGroupsSetNamedPortsRequestTypenamedPortsArray Index 8 Read FnamedPorts Write SetnamedPorts;
  end;
  TInstanceGroupsSetNamedPortsRequestClass = Class of TInstanceGroupsSetNamedPortsRequest;
  
  { --------------------------------------------------------------------
    TInstanceList
    --------------------------------------------------------------------}
  
  TInstanceList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceListClass = Class of TInstanceList;
  
  { --------------------------------------------------------------------
    TInstanceMoveRequest
    --------------------------------------------------------------------}
  
  TInstanceMoveRequest = Class(TGoogleBaseObject)
  Private
    FdestinationZone : String;
    FtargetInstance : String;
  Protected
    //Property setters
    Procedure SetdestinationZone(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetInstance(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property destinationZone : String Index 0 Read FdestinationZone Write SetdestinationZone;
    Property targetInstance : String Index 8 Read FtargetInstance Write SettargetInstance;
  end;
  TInstanceMoveRequestClass = Class of TInstanceMoveRequest;
  
  { --------------------------------------------------------------------
    TInstanceProperties
    --------------------------------------------------------------------}
  
  TInstanceProperties = Class(TGoogleBaseObject)
  Private
    FcanIpForward : boolean;
    Fdescription : String;
    Fdisks : TInstancePropertiesTypedisksArray;
    FmachineType : String;
    Fmetadata : TMetadata;
    FnetworkInterfaces : TInstancePropertiesTypenetworkInterfacesArray;
    Fscheduling : TScheduling;
    FserviceAccounts : TInstancePropertiesTypeserviceAccountsArray;
    Ftags : TTags;
  Protected
    //Property setters
    Procedure SetcanIpForward(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdisks(AIndex : Integer; const AValue : TInstancePropertiesTypedisksArray); virtual;
    Procedure SetmachineType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setmetadata(AIndex : Integer; const AValue : TMetadata); virtual;
    Procedure SetnetworkInterfaces(AIndex : Integer; const AValue : TInstancePropertiesTypenetworkInterfacesArray); virtual;
    Procedure Setscheduling(AIndex : Integer; const AValue : TScheduling); virtual;
    Procedure SetserviceAccounts(AIndex : Integer; const AValue : TInstancePropertiesTypeserviceAccountsArray); virtual;
    Procedure Settags(AIndex : Integer; const AValue : TTags); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property canIpForward : boolean Index 0 Read FcanIpForward Write SetcanIpForward;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property disks : TInstancePropertiesTypedisksArray Index 16 Read Fdisks Write Setdisks;
    Property machineType : String Index 24 Read FmachineType Write SetmachineType;
    Property metadata : TMetadata Index 32 Read Fmetadata Write Setmetadata;
    Property networkInterfaces : TInstancePropertiesTypenetworkInterfacesArray Index 40 Read FnetworkInterfaces Write SetnetworkInterfaces;
    Property scheduling : TScheduling Index 48 Read Fscheduling Write Setscheduling;
    Property serviceAccounts : TInstancePropertiesTypeserviceAccountsArray Index 56 Read FserviceAccounts Write SetserviceAccounts;
    Property tags : TTags Index 64 Read Ftags Write Settags;
  end;
  TInstancePropertiesClass = Class of TInstanceProperties;
  
  { --------------------------------------------------------------------
    TInstanceReference
    --------------------------------------------------------------------}
  
  TInstanceReference = Class(TGoogleBaseObject)
  Private
    Finstance : String;
  Protected
    //Property setters
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property instance : String Index 0 Read Finstance Write Setinstance;
  end;
  TInstanceReferenceClass = Class of TInstanceReference;
  
  { --------------------------------------------------------------------
    TInstanceTemplate
    --------------------------------------------------------------------}
  
  TInstanceTemplate = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fproperties : TInstanceProperties;
    FselfLink : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setproperties(AIndex : Integer; const AValue : TInstanceProperties); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property id : String Index 16 Read Fid Write Setid;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property name : String Index 32 Read Fname Write Setname;
    Property properties : TInstanceProperties Index 40 Read Fproperties Write Setproperties;
    Property selfLink : String Index 48 Read FselfLink Write SetselfLink;
  end;
  TInstanceTemplateClass = Class of TInstanceTemplate;
  
  { --------------------------------------------------------------------
    TInstanceTemplateList
    --------------------------------------------------------------------}
  
  TInstanceTemplateList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TInstanceTemplateListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TInstanceTemplateListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TInstanceTemplateListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TInstanceTemplateListClass = Class of TInstanceTemplateList;
  
  { --------------------------------------------------------------------
    TInstanceWithNamedPorts
    --------------------------------------------------------------------}
  
  TInstanceWithNamedPorts = Class(TGoogleBaseObject)
  Private
    Finstance : String;
    FnamedPorts : TInstanceWithNamedPortsTypenamedPortsArray;
    Fstatus : String;
  Protected
    //Property setters
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnamedPorts(AIndex : Integer; const AValue : TInstanceWithNamedPortsTypenamedPortsArray); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instance : String Index 0 Read Finstance Write Setinstance;
    Property namedPorts : TInstanceWithNamedPortsTypenamedPortsArray Index 8 Read FnamedPorts Write SetnamedPorts;
    Property status : String Index 16 Read Fstatus Write Setstatus;
  end;
  TInstanceWithNamedPortsClass = Class of TInstanceWithNamedPorts;
  
  { --------------------------------------------------------------------
    TInstancesScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TInstancesScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TInstancesScopedListTypewarningTypedataItemClass = Class of TInstancesScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TInstancesScopedListTypewarning
    --------------------------------------------------------------------}
  
  TInstancesScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TInstancesScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TInstancesScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TInstancesScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TInstancesScopedListTypewarningClass = Class of TInstancesScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TInstancesScopedList
    --------------------------------------------------------------------}
  
  TInstancesScopedList = Class(TGoogleBaseObject)
  Private
    Finstances : TInstancesScopedListTypeinstancesArray;
    Fwarning : TInstancesScopedListTypewarning;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TInstancesScopedListTypeinstancesArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TInstancesScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TInstancesScopedListTypeinstancesArray Index 0 Read Finstances Write Setinstances;
    Property warning : TInstancesScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TInstancesScopedListClass = Class of TInstancesScopedList;
  
  { --------------------------------------------------------------------
    TInstancesSetMachineTypeRequest
    --------------------------------------------------------------------}
  
  TInstancesSetMachineTypeRequest = Class(TGoogleBaseObject)
  Private
    FmachineType : String;
  Protected
    //Property setters
    Procedure SetmachineType(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property machineType : String Index 0 Read FmachineType Write SetmachineType;
  end;
  TInstancesSetMachineTypeRequestClass = Class of TInstancesSetMachineTypeRequest;
  
  { --------------------------------------------------------------------
    TLicense
    --------------------------------------------------------------------}
  
  TLicense = Class(TGoogleBaseObject)
  Private
    FchargesUseFee : boolean;
    Fkind : String;
    Fname : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure SetchargesUseFee(AIndex : Integer; const AValue : boolean); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property chargesUseFee : boolean Index 0 Read FchargesUseFee Write SetchargesUseFee;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property name : String Index 16 Read Fname Write Setname;
    Property selfLink : String Index 24 Read FselfLink Write SetselfLink;
  end;
  TLicenseClass = Class of TLicense;
  
  { --------------------------------------------------------------------
    TMachineTypeTypescratchDisksItem
    --------------------------------------------------------------------}
  
  TMachineTypeTypescratchDisksItem = Class(TGoogleBaseObject)
  Private
    FdiskGb : integer;
  Protected
    //Property setters
    Procedure SetdiskGb(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property diskGb : integer Index 0 Read FdiskGb Write SetdiskGb;
  end;
  TMachineTypeTypescratchDisksItemClass = Class of TMachineTypeTypescratchDisksItem;
  
  { --------------------------------------------------------------------
    TMachineType
    --------------------------------------------------------------------}
  
  TMachineType = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdeprecated : TDeprecationStatus;
    Fdescription : String;
    FguestCpus : integer;
    Fid : String;
    FimageSpaceGb : integer;
    Fkind : String;
    FmaximumPersistentDisks : integer;
    FmaximumPersistentDisksSizeGb : String;
    FmemoryMb : integer;
    Fname : String;
    FscratchDisks : TMachineTypeTypescratchDisksArray;
    FselfLink : String;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetguestCpus(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure SetimageSpaceGb(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmaximumPersistentDisks(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetmaximumPersistentDisksSizeGb(AIndex : Integer; const AValue : String); virtual;
    Procedure SetmemoryMb(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetscratchDisks(AIndex : Integer; const AValue : TMachineTypeTypescratchDisksArray); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property deprecated : TDeprecationStatus Index 8 Read Fdeprecated Write Setdeprecated;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property guestCpus : integer Index 24 Read FguestCpus Write SetguestCpus;
    Property id : String Index 32 Read Fid Write Setid;
    Property imageSpaceGb : integer Index 40 Read FimageSpaceGb Write SetimageSpaceGb;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property maximumPersistentDisks : integer Index 56 Read FmaximumPersistentDisks Write SetmaximumPersistentDisks;
    Property maximumPersistentDisksSizeGb : String Index 64 Read FmaximumPersistentDisksSizeGb Write SetmaximumPersistentDisksSizeGb;
    Property memoryMb : integer Index 72 Read FmemoryMb Write SetmemoryMb;
    Property name : String Index 80 Read Fname Write Setname;
    Property scratchDisks : TMachineTypeTypescratchDisksArray Index 88 Read FscratchDisks Write SetscratchDisks;
    Property selfLink : String Index 96 Read FselfLink Write SetselfLink;
    Property zone : String Index 104 Read Fzone Write Setzone;
  end;
  TMachineTypeClass = Class of TMachineType;
  
  { --------------------------------------------------------------------
    TMachineTypeAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TMachineTypeAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TMachineTypeAggregatedListTypeitemsClass = Class of TMachineTypeAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TMachineTypeAggregatedList
    --------------------------------------------------------------------}
  
  TMachineTypeAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TMachineTypeAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TMachineTypeAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TMachineTypeAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TMachineTypeAggregatedListClass = Class of TMachineTypeAggregatedList;
  
  { --------------------------------------------------------------------
    TMachineTypeList
    --------------------------------------------------------------------}
  
  TMachineTypeList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TMachineTypeListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TMachineTypeListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TMachineTypeListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TMachineTypeListClass = Class of TMachineTypeList;
  
  { --------------------------------------------------------------------
    TMachineTypesScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TMachineTypesScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TMachineTypesScopedListTypewarningTypedataItemClass = Class of TMachineTypesScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TMachineTypesScopedListTypewarning
    --------------------------------------------------------------------}
  
  TMachineTypesScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TMachineTypesScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TMachineTypesScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TMachineTypesScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TMachineTypesScopedListTypewarningClass = Class of TMachineTypesScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TMachineTypesScopedList
    --------------------------------------------------------------------}
  
  TMachineTypesScopedList = Class(TGoogleBaseObject)
  Private
    FmachineTypes : TMachineTypesScopedListTypemachineTypesArray;
    Fwarning : TMachineTypesScopedListTypewarning;
  Protected
    //Property setters
    Procedure SetmachineTypes(AIndex : Integer; const AValue : TMachineTypesScopedListTypemachineTypesArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TMachineTypesScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property machineTypes : TMachineTypesScopedListTypemachineTypesArray Index 0 Read FmachineTypes Write SetmachineTypes;
    Property warning : TMachineTypesScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TMachineTypesScopedListClass = Class of TMachineTypesScopedList;
  
  { --------------------------------------------------------------------
    TManagedInstance
    --------------------------------------------------------------------}
  
  TManagedInstance = Class(TGoogleBaseObject)
  Private
    FcurrentAction : String;
    Fid : String;
    Finstance : String;
    FinstanceStatus : String;
    FlastAttempt : TManagedInstanceLastAttempt;
  Protected
    //Property setters
    Procedure SetcurrentAction(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure SetinstanceStatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SetlastAttempt(AIndex : Integer; const AValue : TManagedInstanceLastAttempt); virtual;
  Public
  Published
    Property currentAction : String Index 0 Read FcurrentAction Write SetcurrentAction;
    Property id : String Index 8 Read Fid Write Setid;
    Property instance : String Index 16 Read Finstance Write Setinstance;
    Property instanceStatus : String Index 24 Read FinstanceStatus Write SetinstanceStatus;
    Property lastAttempt : TManagedInstanceLastAttempt Index 32 Read FlastAttempt Write SetlastAttempt;
  end;
  TManagedInstanceClass = Class of TManagedInstance;
  
  { --------------------------------------------------------------------
    TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem
    --------------------------------------------------------------------}
  
  TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Flocation : String;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocation(AIndex : Integer; const AValue : String); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property location : String Index 8 Read Flocation Write Setlocation;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TManagedInstanceLastAttemptTypeerrorsTypeerrorsItemClass = Class of TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem;
  
  { --------------------------------------------------------------------
    TManagedInstanceLastAttemptTypeerrors
    --------------------------------------------------------------------}
  
  TManagedInstanceLastAttemptTypeerrors = Class(TGoogleBaseObject)
  Private
    Ferrors : TManagedInstanceLastAttemptTypeerrorsTypeerrorsArray;
  Protected
    //Property setters
    Procedure Seterrors(AIndex : Integer; const AValue : TManagedInstanceLastAttemptTypeerrorsTypeerrorsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property errors : TManagedInstanceLastAttemptTypeerrorsTypeerrorsArray Index 0 Read Ferrors Write Seterrors;
  end;
  TManagedInstanceLastAttemptTypeerrorsClass = Class of TManagedInstanceLastAttemptTypeerrors;
  
  { --------------------------------------------------------------------
    TManagedInstanceLastAttempt
    --------------------------------------------------------------------}
  
  TManagedInstanceLastAttempt = Class(TGoogleBaseObject)
  Private
    Ferrors : TManagedInstanceLastAttemptTypeerrors;
  Protected
    //Property setters
    Procedure Seterrors(AIndex : Integer; const AValue : TManagedInstanceLastAttemptTypeerrors); virtual;
  Public
  Published
    Property errors : TManagedInstanceLastAttemptTypeerrors Index 0 Read Ferrors Write Seterrors;
  end;
  TManagedInstanceLastAttemptClass = Class of TManagedInstanceLastAttempt;
  
  { --------------------------------------------------------------------
    TMetadataTypeitemsItem
    --------------------------------------------------------------------}
  
  TMetadataTypeitemsItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TMetadataTypeitemsItemClass = Class of TMetadataTypeitemsItem;
  
  { --------------------------------------------------------------------
    TMetadata
    --------------------------------------------------------------------}
  
  TMetadata = Class(TGoogleBaseObject)
  Private
    Ffingerprint : String;
    Fitems : TMetadataTypeitemsArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TMetadataTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property fingerprint : String Index 0 Read Ffingerprint Write Setfingerprint;
    Property items : TMetadataTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
  end;
  TMetadataClass = Class of TMetadata;
  
  { --------------------------------------------------------------------
    TNamedPort
    --------------------------------------------------------------------}
  
  TNamedPort = Class(TGoogleBaseObject)
  Private
    Fname : String;
    Fport : integer;
  Protected
    //Property setters
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setport(AIndex : Integer; const AValue : integer); virtual;
  Public
  Published
    Property name : String Index 0 Read Fname Write Setname;
    Property port : integer Index 8 Read Fport Write Setport;
  end;
  TNamedPortClass = Class of TNamedPort;
  
  { --------------------------------------------------------------------
    TNetwork
    --------------------------------------------------------------------}
  
  TNetwork = Class(TGoogleBaseObject)
  Private
    FIPv4Range : String;
    FautoCreateSubnetworks : boolean;
    FcreationTimestamp : String;
    Fdescription : String;
    FgatewayIPv4 : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FselfLink : String;
    Fsubnetworks : TStringArray;
  Protected
    //Property setters
    Procedure SetIPv4Range(AIndex : Integer; const AValue : String); virtual;
    Procedure SetautoCreateSubnetworks(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetgatewayIPv4(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsubnetworks(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property IPv4Range : String Index 0 Read FIPv4Range Write SetIPv4Range;
    Property autoCreateSubnetworks : boolean Index 8 Read FautoCreateSubnetworks Write SetautoCreateSubnetworks;
    Property creationTimestamp : String Index 16 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 24 Read Fdescription Write Setdescription;
    Property gatewayIPv4 : String Index 32 Read FgatewayIPv4 Write SetgatewayIPv4;
    Property id : String Index 40 Read Fid Write Setid;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property name : String Index 56 Read Fname Write Setname;
    Property selfLink : String Index 64 Read FselfLink Write SetselfLink;
    Property subnetworks : TStringArray Index 72 Read Fsubnetworks Write Setsubnetworks;
  end;
  TNetworkClass = Class of TNetwork;
  
  { --------------------------------------------------------------------
    TNetworkInterface
    --------------------------------------------------------------------}
  
  TNetworkInterface = Class(TGoogleBaseObject)
  Private
    FaccessConfigs : TNetworkInterfaceTypeaccessConfigsArray;
    Fname : String;
    Fnetwork : String;
    FnetworkIP : String;
    Fsubnetwork : String;
  Protected
    //Property setters
    Procedure SetaccessConfigs(AIndex : Integer; const AValue : TNetworkInterfaceTypeaccessConfigsArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setnetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnetworkIP(AIndex : Integer; const AValue : String); virtual;
    Procedure Setsubnetwork(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property accessConfigs : TNetworkInterfaceTypeaccessConfigsArray Index 0 Read FaccessConfigs Write SetaccessConfigs;
    Property name : String Index 8 Read Fname Write Setname;
    Property network : String Index 16 Read Fnetwork Write Setnetwork;
    Property networkIP : String Index 24 Read FnetworkIP Write SetnetworkIP;
    Property subnetwork : String Index 32 Read Fsubnetwork Write Setsubnetwork;
  end;
  TNetworkInterfaceClass = Class of TNetworkInterface;
  
  { --------------------------------------------------------------------
    TNetworkList
    --------------------------------------------------------------------}
  
  TNetworkList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TNetworkListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TNetworkListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TNetworkListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TNetworkListClass = Class of TNetworkList;
  
  { --------------------------------------------------------------------
    TOperationTypeerrorTypeerrorsItem
    --------------------------------------------------------------------}
  
  TOperationTypeerrorTypeerrorsItem = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Flocation : String;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlocation(AIndex : Integer; const AValue : String); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property location : String Index 8 Read Flocation Write Setlocation;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TOperationTypeerrorTypeerrorsItemClass = Class of TOperationTypeerrorTypeerrorsItem;
  
  { --------------------------------------------------------------------
    TOperationTypeerror
    --------------------------------------------------------------------}
  
  TOperationTypeerror = Class(TGoogleBaseObject)
  Private
    Ferrors : TOperationTypeerrorTypeerrorsArray;
  Protected
    //Property setters
    Procedure Seterrors(AIndex : Integer; const AValue : TOperationTypeerrorTypeerrorsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property errors : TOperationTypeerrorTypeerrorsArray Index 0 Read Ferrors Write Seterrors;
  end;
  TOperationTypeerrorClass = Class of TOperationTypeerror;
  
  { --------------------------------------------------------------------
    TOperationTypewarningsItemTypedataItem
    --------------------------------------------------------------------}
  
  TOperationTypewarningsItemTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TOperationTypewarningsItemTypedataItemClass = Class of TOperationTypewarningsItemTypedataItem;
  
  { --------------------------------------------------------------------
    TOperationTypewarningsItem
    --------------------------------------------------------------------}
  
  TOperationTypewarningsItem = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TOperationTypewarningsItemTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TOperationTypewarningsItemTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TOperationTypewarningsItemTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TOperationTypewarningsItemClass = Class of TOperationTypewarningsItem;
  
  { --------------------------------------------------------------------
    TOperation
    --------------------------------------------------------------------}
  
  TOperation = Class(TGoogleBaseObject)
  Private
    FclientOperationId : String;
    FcreationTimestamp : String;
    Fdescription : String;
    FendTime : String;
    Ferror : TOperationTypeerror;
    FhttpErrorMessage : String;
    FhttpErrorStatusCode : integer;
    Fid : String;
    FinsertTime : String;
    Fkind : String;
    Fname : String;
    FoperationType : String;
    Fprogress : integer;
    Fregion : String;
    FselfLink : String;
    FstartTime : String;
    Fstatus : String;
    FstatusMessage : String;
    FtargetId : String;
    FtargetLink : String;
    Fuser : String;
    Fwarnings : TOperationTypewarningsArray;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetclientOperationId(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetendTime(AIndex : Integer; const AValue : String); virtual;
    Procedure Seterror(AIndex : Integer; const AValue : TOperationTypeerror); virtual;
    Procedure SethttpErrorMessage(AIndex : Integer; const AValue : String); virtual;
    Procedure SethttpErrorStatusCode(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure SetinsertTime(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetoperationType(AIndex : Integer; const AValue : String); virtual;
    Procedure Setprogress(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstartTime(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstatusMessage(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetId(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setuser(AIndex : Integer; const AValue : String); virtual;
    Procedure Setwarnings(AIndex : Integer; const AValue : TOperationTypewarningsArray); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property clientOperationId : String Index 0 Read FclientOperationId Write SetclientOperationId;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property endTime : String Index 24 Read FendTime Write SetendTime;
    Property error : TOperationTypeerror Index 32 Read Ferror Write Seterror;
    Property httpErrorMessage : String Index 40 Read FhttpErrorMessage Write SethttpErrorMessage;
    Property httpErrorStatusCode : integer Index 48 Read FhttpErrorStatusCode Write SethttpErrorStatusCode;
    Property id : String Index 56 Read Fid Write Setid;
    Property insertTime : String Index 64 Read FinsertTime Write SetinsertTime;
    Property kind : String Index 72 Read Fkind Write Setkind;
    Property name : String Index 80 Read Fname Write Setname;
    Property operationType : String Index 88 Read FoperationType Write SetoperationType;
    Property progress : integer Index 96 Read Fprogress Write Setprogress;
    Property region : String Index 104 Read Fregion Write Setregion;
    Property selfLink : String Index 112 Read FselfLink Write SetselfLink;
    Property startTime : String Index 120 Read FstartTime Write SetstartTime;
    Property status : String Index 128 Read Fstatus Write Setstatus;
    Property statusMessage : String Index 136 Read FstatusMessage Write SetstatusMessage;
    Property targetId : String Index 144 Read FtargetId Write SettargetId;
    Property targetLink : String Index 152 Read FtargetLink Write SettargetLink;
    Property user : String Index 160 Read Fuser Write Setuser;
    Property warnings : TOperationTypewarningsArray Index 168 Read Fwarnings Write Setwarnings;
    Property zone : String Index 176 Read Fzone Write Setzone;
  end;
  TOperationClass = Class of TOperation;
  
  { --------------------------------------------------------------------
    TOperationAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TOperationAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TOperationAggregatedListTypeitemsClass = Class of TOperationAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TOperationAggregatedList
    --------------------------------------------------------------------}
  
  TOperationAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TOperationAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TOperationAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TOperationAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TOperationAggregatedListClass = Class of TOperationAggregatedList;
  
  { --------------------------------------------------------------------
    TOperationList
    --------------------------------------------------------------------}
  
  TOperationList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TOperationListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TOperationListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TOperationListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TOperationListClass = Class of TOperationList;
  
  { --------------------------------------------------------------------
    TOperationsScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TOperationsScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TOperationsScopedListTypewarningTypedataItemClass = Class of TOperationsScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TOperationsScopedListTypewarning
    --------------------------------------------------------------------}
  
  TOperationsScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TOperationsScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TOperationsScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TOperationsScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TOperationsScopedListTypewarningClass = Class of TOperationsScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TOperationsScopedList
    --------------------------------------------------------------------}
  
  TOperationsScopedList = Class(TGoogleBaseObject)
  Private
    Foperations : TOperationsScopedListTypeoperationsArray;
    Fwarning : TOperationsScopedListTypewarning;
  Protected
    //Property setters
    Procedure Setoperations(AIndex : Integer; const AValue : TOperationsScopedListTypeoperationsArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TOperationsScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property operations : TOperationsScopedListTypeoperationsArray Index 0 Read Foperations Write Setoperations;
    Property warning : TOperationsScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TOperationsScopedListClass = Class of TOperationsScopedList;
  
  { --------------------------------------------------------------------
    TPathMatcher
    --------------------------------------------------------------------}
  
  TPathMatcher = Class(TGoogleBaseObject)
  Private
    FdefaultService : String;
    Fdescription : String;
    Fname : String;
    FpathRules : TPathMatcherTypepathRulesArray;
  Protected
    //Property setters
    Procedure SetdefaultService(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetpathRules(AIndex : Integer; const AValue : TPathMatcherTypepathRulesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property defaultService : String Index 0 Read FdefaultService Write SetdefaultService;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property name : String Index 16 Read Fname Write Setname;
    Property pathRules : TPathMatcherTypepathRulesArray Index 24 Read FpathRules Write SetpathRules;
  end;
  TPathMatcherClass = Class of TPathMatcher;
  
  { --------------------------------------------------------------------
    TPathRule
    --------------------------------------------------------------------}
  
  TPathRule = Class(TGoogleBaseObject)
  Private
    Fpaths : TStringArray;
    Fservice : String;
  Protected
    //Property setters
    Procedure Setpaths(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setservice(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property paths : TStringArray Index 0 Read Fpaths Write Setpaths;
    Property service : String Index 8 Read Fservice Write Setservice;
  end;
  TPathRuleClass = Class of TPathRule;
  
  { --------------------------------------------------------------------
    TProject
    --------------------------------------------------------------------}
  
  TProject = Class(TGoogleBaseObject)
  Private
    FcommonInstanceMetadata : TMetadata;
    FcreationTimestamp : String;
    Fdescription : String;
    FenabledFeatures : TStringArray;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fquotas : TProjectTypequotasArray;
    FselfLink : String;
    FusageExportLocation : TUsageExportLocation;
  Protected
    //Property setters
    Procedure SetcommonInstanceMetadata(AIndex : Integer; const AValue : TMetadata); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetenabledFeatures(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setquotas(AIndex : Integer; const AValue : TProjectTypequotasArray); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetusageExportLocation(AIndex : Integer; const AValue : TUsageExportLocation); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property commonInstanceMetadata : TMetadata Index 0 Read FcommonInstanceMetadata Write SetcommonInstanceMetadata;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property enabledFeatures : TStringArray Index 24 Read FenabledFeatures Write SetenabledFeatures;
    Property id : String Index 32 Read Fid Write Setid;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property name : String Index 48 Read Fname Write Setname;
    Property quotas : TProjectTypequotasArray Index 56 Read Fquotas Write Setquotas;
    Property selfLink : String Index 64 Read FselfLink Write SetselfLink;
    Property usageExportLocation : TUsageExportLocation Index 72 Read FusageExportLocation Write SetusageExportLocation;
  end;
  TProjectClass = Class of TProject;
  
  { --------------------------------------------------------------------
    TQuota
    --------------------------------------------------------------------}
  
  TQuota = Class(TGoogleBaseObject)
  Private
    Flimit : double;
    Fmetric : String;
    Fusage : double;
  Protected
    //Property setters
    Procedure Setlimit(AIndex : Integer; const AValue : double); virtual;
    Procedure Setmetric(AIndex : Integer; const AValue : String); virtual;
    Procedure Setusage(AIndex : Integer; const AValue : double); virtual;
  Public
  Published
    Property limit : double Index 0 Read Flimit Write Setlimit;
    Property metric : String Index 8 Read Fmetric Write Setmetric;
    Property usage : double Index 16 Read Fusage Write Setusage;
  end;
  TQuotaClass = Class of TQuota;
  
  { --------------------------------------------------------------------
    TRegion
    --------------------------------------------------------------------}
  
  TRegion = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdeprecated : TDeprecationStatus;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fquotas : TRegionTypequotasArray;
    FselfLink : String;
    Fstatus : String;
    Fzones : TStringArray;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setquotas(AIndex : Integer; const AValue : TRegionTypequotasArray); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzones(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property deprecated : TDeprecationStatus Index 8 Read Fdeprecated Write Setdeprecated;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property quotas : TRegionTypequotasArray Index 48 Read Fquotas Write Setquotas;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property status : String Index 64 Read Fstatus Write Setstatus;
    Property zones : TStringArray Index 72 Read Fzones Write Setzones;
  end;
  TRegionClass = Class of TRegion;
  
  { --------------------------------------------------------------------
    TRegionList
    --------------------------------------------------------------------}
  
  TRegionList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TRegionListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TRegionListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TRegionListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TRegionListClass = Class of TRegionList;
  
  { --------------------------------------------------------------------
    TResourceGroupReference
    --------------------------------------------------------------------}
  
  TResourceGroupReference = Class(TGoogleBaseObject)
  Private
    Fgroup : String;
  Protected
    //Property setters
    Procedure Setgroup(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property group : String Index 0 Read Fgroup Write Setgroup;
  end;
  TResourceGroupReferenceClass = Class of TResourceGroupReference;
  
  { --------------------------------------------------------------------
    TRouteTypewarningsItemTypedataItem
    --------------------------------------------------------------------}
  
  TRouteTypewarningsItemTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TRouteTypewarningsItemTypedataItemClass = Class of TRouteTypewarningsItemTypedataItem;
  
  { --------------------------------------------------------------------
    TRouteTypewarningsItem
    --------------------------------------------------------------------}
  
  TRouteTypewarningsItem = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TRouteTypewarningsItemTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TRouteTypewarningsItemTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TRouteTypewarningsItemTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TRouteTypewarningsItemClass = Class of TRouteTypewarningsItem;
  
  { --------------------------------------------------------------------
    TRoute
    --------------------------------------------------------------------}
  
  TRoute = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    FdestRange : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fnetwork : String;
    FnextHopGateway : String;
    FnextHopInstance : String;
    FnextHopIp : String;
    FnextHopNetwork : String;
    FnextHopVpnTunnel : String;
    Fpriority : integer;
    FselfLink : String;
    Ftags : TStringArray;
    Fwarnings : TRouteTypewarningsArray;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdestRange(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setnetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextHopGateway(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextHopInstance(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextHopIp(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextHopNetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextHopVpnTunnel(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpriority(AIndex : Integer; const AValue : integer); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Settags(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setwarnings(AIndex : Integer; const AValue : TRouteTypewarningsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property destRange : String Index 16 Read FdestRange Write SetdestRange;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property network : String Index 48 Read Fnetwork Write Setnetwork;
    Property nextHopGateway : String Index 56 Read FnextHopGateway Write SetnextHopGateway;
    Property nextHopInstance : String Index 64 Read FnextHopInstance Write SetnextHopInstance;
    Property nextHopIp : String Index 72 Read FnextHopIp Write SetnextHopIp;
    Property nextHopNetwork : String Index 80 Read FnextHopNetwork Write SetnextHopNetwork;
    Property nextHopVpnTunnel : String Index 88 Read FnextHopVpnTunnel Write SetnextHopVpnTunnel;
    Property priority : integer Index 96 Read Fpriority Write Setpriority;
    Property selfLink : String Index 104 Read FselfLink Write SetselfLink;
    Property tags : TStringArray Index 112 Read Ftags Write Settags;
    Property warnings : TRouteTypewarningsArray Index 120 Read Fwarnings Write Setwarnings;
  end;
  TRouteClass = Class of TRoute;
  
  { --------------------------------------------------------------------
    TRouteList
    --------------------------------------------------------------------}
  
  TRouteList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TRouteListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TRouteListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TRouteListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TRouteListClass = Class of TRouteList;
  
  { --------------------------------------------------------------------
    TScheduling
    --------------------------------------------------------------------}
  
  TScheduling = Class(TGoogleBaseObject)
  Private
    FautomaticRestart : boolean;
    FonHostMaintenance : String;
    Fpreemptible : boolean;
  Protected
    //Property setters
    Procedure SetautomaticRestart(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SetonHostMaintenance(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpreemptible(AIndex : Integer; const AValue : boolean); virtual;
  Public
  Published
    Property automaticRestart : boolean Index 0 Read FautomaticRestart Write SetautomaticRestart;
    Property onHostMaintenance : String Index 8 Read FonHostMaintenance Write SetonHostMaintenance;
    Property preemptible : boolean Index 16 Read Fpreemptible Write Setpreemptible;
  end;
  TSchedulingClass = Class of TScheduling;
  
  { --------------------------------------------------------------------
    TSerialPortOutput
    --------------------------------------------------------------------}
  
  TSerialPortOutput = Class(TGoogleBaseObject)
  Private
    Fcontents : String;
    Fkind : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setcontents(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property contents : String Index 0 Read Fcontents Write Setcontents;
    Property kind : String Index 8 Read Fkind Write Setkind;
    Property selfLink : String Index 16 Read FselfLink Write SetselfLink;
  end;
  TSerialPortOutputClass = Class of TSerialPortOutput;
  
  { --------------------------------------------------------------------
    TServiceAccount
    --------------------------------------------------------------------}
  
  TServiceAccount = Class(TGoogleBaseObject)
  Private
    Femail : String;
    Fscopes : TStringArray;
  Protected
    //Property setters
    Procedure Setemail(AIndex : Integer; const AValue : String); virtual;
    Procedure Setscopes(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property email : String Index 0 Read Femail Write Setemail;
    Property scopes : TStringArray Index 8 Read Fscopes Write Setscopes;
  end;
  TServiceAccountClass = Class of TServiceAccount;
  
  { --------------------------------------------------------------------
    TSnapshot
    --------------------------------------------------------------------}
  
  TSnapshot = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    FdiskSizeGb : String;
    Fid : String;
    Fkind : String;
    Flicenses : TStringArray;
    Fname : String;
    FselfLink : String;
    FsourceDisk : String;
    FsourceDiskId : String;
    Fstatus : String;
    FstorageBytes : String;
    FstorageBytesStatus : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdiskSizeGb(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setlicenses(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceDisk(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsourceDiskId(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstorageBytes(AIndex : Integer; const AValue : String); virtual;
    Procedure SetstorageBytesStatus(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property diskSizeGb : String Index 16 Read FdiskSizeGb Write SetdiskSizeGb;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property licenses : TStringArray Index 40 Read Flicenses Write Setlicenses;
    Property name : String Index 48 Read Fname Write Setname;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property sourceDisk : String Index 64 Read FsourceDisk Write SetsourceDisk;
    Property sourceDiskId : String Index 72 Read FsourceDiskId Write SetsourceDiskId;
    Property status : String Index 80 Read Fstatus Write Setstatus;
    Property storageBytes : String Index 88 Read FstorageBytes Write SetstorageBytes;
    Property storageBytesStatus : String Index 96 Read FstorageBytesStatus Write SetstorageBytesStatus;
  end;
  TSnapshotClass = Class of TSnapshot;
  
  { --------------------------------------------------------------------
    TSnapshotList
    --------------------------------------------------------------------}
  
  TSnapshotList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TSnapshotListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TSnapshotListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TSnapshotListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TSnapshotListClass = Class of TSnapshotList;
  
  { --------------------------------------------------------------------
    TSslCertificate
    --------------------------------------------------------------------}
  
  TSslCertificate = Class(TGoogleBaseObject)
  Private
    Fcertificate : String;
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FprivateKey : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setcertificate(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetprivateKey(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property certificate : String Index 0 Read Fcertificate Write Setcertificate;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property privateKey : String Index 48 Read FprivateKey Write SetprivateKey;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
  end;
  TSslCertificateClass = Class of TSslCertificate;
  
  { --------------------------------------------------------------------
    TSslCertificateList
    --------------------------------------------------------------------}
  
  TSslCertificateList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TSslCertificateListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TSslCertificateListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TSslCertificateListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TSslCertificateListClass = Class of TSslCertificateList;
  
  { --------------------------------------------------------------------
    TSubnetwork
    --------------------------------------------------------------------}
  
  TSubnetwork = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    FgatewayAddress : String;
    Fid : String;
    FipCidrRange : String;
    Fkind : String;
    Fname : String;
    Fnetwork : String;
    Fregion : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetgatewayAddress(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure SetipCidrRange(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setnetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property gatewayAddress : String Index 16 Read FgatewayAddress Write SetgatewayAddress;
    Property id : String Index 24 Read Fid Write Setid;
    Property ipCidrRange : String Index 32 Read FipCidrRange Write SetipCidrRange;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property name : String Index 48 Read Fname Write Setname;
    Property network : String Index 56 Read Fnetwork Write Setnetwork;
    Property region : String Index 64 Read Fregion Write Setregion;
    Property selfLink : String Index 72 Read FselfLink Write SetselfLink;
  end;
  TSubnetworkClass = Class of TSubnetwork;
  
  { --------------------------------------------------------------------
    TSubnetworkAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TSubnetworkAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TSubnetworkAggregatedListTypeitemsClass = Class of TSubnetworkAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TSubnetworkAggregatedList
    --------------------------------------------------------------------}
  
  TSubnetworkAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TSubnetworkAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TSubnetworkAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TSubnetworkAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TSubnetworkAggregatedListClass = Class of TSubnetworkAggregatedList;
  
  { --------------------------------------------------------------------
    TSubnetworkList
    --------------------------------------------------------------------}
  
  TSubnetworkList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TSubnetworkListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TSubnetworkListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TSubnetworkListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TSubnetworkListClass = Class of TSubnetworkList;
  
  { --------------------------------------------------------------------
    TSubnetworksScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TSubnetworksScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TSubnetworksScopedListTypewarningTypedataItemClass = Class of TSubnetworksScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TSubnetworksScopedListTypewarning
    --------------------------------------------------------------------}
  
  TSubnetworksScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TSubnetworksScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TSubnetworksScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TSubnetworksScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TSubnetworksScopedListTypewarningClass = Class of TSubnetworksScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TSubnetworksScopedList
    --------------------------------------------------------------------}
  
  TSubnetworksScopedList = Class(TGoogleBaseObject)
  Private
    Fsubnetworks : TSubnetworksScopedListTypesubnetworksArray;
    Fwarning : TSubnetworksScopedListTypewarning;
  Protected
    //Property setters
    Procedure Setsubnetworks(AIndex : Integer; const AValue : TSubnetworksScopedListTypesubnetworksArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TSubnetworksScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property subnetworks : TSubnetworksScopedListTypesubnetworksArray Index 0 Read Fsubnetworks Write Setsubnetworks;
    Property warning : TSubnetworksScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TSubnetworksScopedListClass = Class of TSubnetworksScopedList;
  
  { --------------------------------------------------------------------
    TTags
    --------------------------------------------------------------------}
  
  TTags = Class(TGoogleBaseObject)
  Private
    Ffingerprint : String;
    Fitems : TStringArray;
  Protected
    //Property setters
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property fingerprint : String Index 0 Read Ffingerprint Write Setfingerprint;
    Property items : TStringArray Index 8 Read Fitems Write Setitems;
  end;
  TTagsClass = Class of TTags;
  
  { --------------------------------------------------------------------
    TTargetHttpProxy
    --------------------------------------------------------------------}
  
  TTargetHttpProxy = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FselfLink : String;
    FurlMap : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SeturlMap(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property id : String Index 16 Read Fid Write Setid;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property name : String Index 32 Read Fname Write Setname;
    Property selfLink : String Index 40 Read FselfLink Write SetselfLink;
    Property urlMap : String Index 48 Read FurlMap Write SeturlMap;
  end;
  TTargetHttpProxyClass = Class of TTargetHttpProxy;
  
  { --------------------------------------------------------------------
    TTargetHttpProxyList
    --------------------------------------------------------------------}
  
  TTargetHttpProxyList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetHttpProxyListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetHttpProxyListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetHttpProxyListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetHttpProxyListClass = Class of TTargetHttpProxyList;
  
  { --------------------------------------------------------------------
    TTargetHttpsProxiesSetSslCertificatesRequest
    --------------------------------------------------------------------}
  
  TTargetHttpsProxiesSetSslCertificatesRequest = Class(TGoogleBaseObject)
  Private
    FsslCertificates : TStringArray;
  Protected
    //Property setters
    Procedure SetsslCertificates(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property sslCertificates : TStringArray Index 0 Read FsslCertificates Write SetsslCertificates;
  end;
  TTargetHttpsProxiesSetSslCertificatesRequestClass = Class of TTargetHttpsProxiesSetSslCertificatesRequest;
  
  { --------------------------------------------------------------------
    TTargetHttpsProxy
    --------------------------------------------------------------------}
  
  TTargetHttpsProxy = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    FselfLink : String;
    FsslCertificates : TStringArray;
    FurlMap : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsslCertificates(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SeturlMap(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property id : String Index 16 Read Fid Write Setid;
    Property kind : String Index 24 Read Fkind Write Setkind;
    Property name : String Index 32 Read Fname Write Setname;
    Property selfLink : String Index 40 Read FselfLink Write SetselfLink;
    Property sslCertificates : TStringArray Index 48 Read FsslCertificates Write SetsslCertificates;
    Property urlMap : String Index 56 Read FurlMap Write SeturlMap;
  end;
  TTargetHttpsProxyClass = Class of TTargetHttpsProxy;
  
  { --------------------------------------------------------------------
    TTargetHttpsProxyList
    --------------------------------------------------------------------}
  
  TTargetHttpsProxyList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetHttpsProxyListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetHttpsProxyListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetHttpsProxyListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetHttpsProxyListClass = Class of TTargetHttpsProxyList;
  
  { --------------------------------------------------------------------
    TTargetInstance
    --------------------------------------------------------------------}
  
  TTargetInstance = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    Fid : String;
    Finstance : String;
    Fkind : String;
    Fname : String;
    FnatPolicy : String;
    FselfLink : String;
    Fzone : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setinstance(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnatPolicy(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setzone(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property id : String Index 16 Read Fid Write Setid;
    Property instance : String Index 24 Read Finstance Write Setinstance;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property natPolicy : String Index 48 Read FnatPolicy Write SetnatPolicy;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property zone : String Index 64 Read Fzone Write Setzone;
  end;
  TTargetInstanceClass = Class of TTargetInstance;
  
  { --------------------------------------------------------------------
    TTargetInstanceAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TTargetInstanceAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TTargetInstanceAggregatedListTypeitemsClass = Class of TTargetInstanceAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TTargetInstanceAggregatedList
    --------------------------------------------------------------------}
  
  TTargetInstanceAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetInstanceAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetInstanceAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetInstanceAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetInstanceAggregatedListClass = Class of TTargetInstanceAggregatedList;
  
  { --------------------------------------------------------------------
    TTargetInstanceList
    --------------------------------------------------------------------}
  
  TTargetInstanceList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetInstanceListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetInstanceListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetInstanceListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetInstanceListClass = Class of TTargetInstanceList;
  
  { --------------------------------------------------------------------
    TTargetInstancesScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TTargetInstancesScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TTargetInstancesScopedListTypewarningTypedataItemClass = Class of TTargetInstancesScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TTargetInstancesScopedListTypewarning
    --------------------------------------------------------------------}
  
  TTargetInstancesScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TTargetInstancesScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TTargetInstancesScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TTargetInstancesScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TTargetInstancesScopedListTypewarningClass = Class of TTargetInstancesScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TTargetInstancesScopedList
    --------------------------------------------------------------------}
  
  TTargetInstancesScopedList = Class(TGoogleBaseObject)
  Private
    FtargetInstances : TTargetInstancesScopedListTypetargetInstancesArray;
    Fwarning : TTargetInstancesScopedListTypewarning;
  Protected
    //Property setters
    Procedure SettargetInstances(AIndex : Integer; const AValue : TTargetInstancesScopedListTypetargetInstancesArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TTargetInstancesScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property targetInstances : TTargetInstancesScopedListTypetargetInstancesArray Index 0 Read FtargetInstances Write SettargetInstances;
    Property warning : TTargetInstancesScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TTargetInstancesScopedListClass = Class of TTargetInstancesScopedList;
  
  { --------------------------------------------------------------------
    TTargetPool
    --------------------------------------------------------------------}
  
  TTargetPool = Class(TGoogleBaseObject)
  Private
    FbackupPool : String;
    FcreationTimestamp : String;
    Fdescription : String;
    FfailoverRatio : integer;
    FhealthChecks : TStringArray;
    Fid : String;
    Finstances : TStringArray;
    Fkind : String;
    Fname : String;
    Fregion : String;
    FselfLink : String;
    FsessionAffinity : String;
  Protected
    //Property setters
    Procedure SetbackupPool(AIndex : Integer; const AValue : String); virtual;
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetfailoverRatio(AIndex : Integer; const AValue : integer); virtual;
    Procedure SethealthChecks(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setinstances(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsessionAffinity(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property backupPool : String Index 0 Read FbackupPool Write SetbackupPool;
    Property creationTimestamp : String Index 8 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property failoverRatio : integer Index 24 Read FfailoverRatio Write SetfailoverRatio;
    Property healthChecks : TStringArray Index 32 Read FhealthChecks Write SethealthChecks;
    Property id : String Index 40 Read Fid Write Setid;
    Property instances : TStringArray Index 48 Read Finstances Write Setinstances;
    Property kind : String Index 56 Read Fkind Write Setkind;
    Property name : String Index 64 Read Fname Write Setname;
    Property region : String Index 72 Read Fregion Write Setregion;
    Property selfLink : String Index 80 Read FselfLink Write SetselfLink;
    Property sessionAffinity : String Index 88 Read FsessionAffinity Write SetsessionAffinity;
  end;
  TTargetPoolClass = Class of TTargetPool;
  
  { --------------------------------------------------------------------
    TTargetPoolAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TTargetPoolAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TTargetPoolAggregatedListTypeitemsClass = Class of TTargetPoolAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TTargetPoolAggregatedList
    --------------------------------------------------------------------}
  
  TTargetPoolAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetPoolAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetPoolAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetPoolAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetPoolAggregatedListClass = Class of TTargetPoolAggregatedList;
  
  { --------------------------------------------------------------------
    TTargetPoolInstanceHealth
    --------------------------------------------------------------------}
  
  TTargetPoolInstanceHealth = Class(TGoogleBaseObject)
  Private
    FhealthStatus : TTargetPoolInstanceHealthTypehealthStatusArray;
    Fkind : String;
  Protected
    //Property setters
    Procedure SethealthStatus(AIndex : Integer; const AValue : TTargetPoolInstanceHealthTypehealthStatusArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property healthStatus : TTargetPoolInstanceHealthTypehealthStatusArray Index 0 Read FhealthStatus Write SethealthStatus;
    Property kind : String Index 8 Read Fkind Write Setkind;
  end;
  TTargetPoolInstanceHealthClass = Class of TTargetPoolInstanceHealth;
  
  { --------------------------------------------------------------------
    TTargetPoolList
    --------------------------------------------------------------------}
  
  TTargetPoolList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetPoolListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetPoolListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetPoolListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetPoolListClass = Class of TTargetPoolList;
  
  { --------------------------------------------------------------------
    TTargetPoolsAddHealthCheckRequest
    --------------------------------------------------------------------}
  
  TTargetPoolsAddHealthCheckRequest = Class(TGoogleBaseObject)
  Private
    FhealthChecks : TTargetPoolsAddHealthCheckRequestTypehealthChecksArray;
  Protected
    //Property setters
    Procedure SethealthChecks(AIndex : Integer; const AValue : TTargetPoolsAddHealthCheckRequestTypehealthChecksArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property healthChecks : TTargetPoolsAddHealthCheckRequestTypehealthChecksArray Index 0 Read FhealthChecks Write SethealthChecks;
  end;
  TTargetPoolsAddHealthCheckRequestClass = Class of TTargetPoolsAddHealthCheckRequest;
  
  { --------------------------------------------------------------------
    TTargetPoolsAddInstanceRequest
    --------------------------------------------------------------------}
  
  TTargetPoolsAddInstanceRequest = Class(TGoogleBaseObject)
  Private
    Finstances : TTargetPoolsAddInstanceRequestTypeinstancesArray;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TTargetPoolsAddInstanceRequestTypeinstancesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TTargetPoolsAddInstanceRequestTypeinstancesArray Index 0 Read Finstances Write Setinstances;
  end;
  TTargetPoolsAddInstanceRequestClass = Class of TTargetPoolsAddInstanceRequest;
  
  { --------------------------------------------------------------------
    TTargetPoolsRemoveHealthCheckRequest
    --------------------------------------------------------------------}
  
  TTargetPoolsRemoveHealthCheckRequest = Class(TGoogleBaseObject)
  Private
    FhealthChecks : TTargetPoolsRemoveHealthCheckRequestTypehealthChecksArray;
  Protected
    //Property setters
    Procedure SethealthChecks(AIndex : Integer; const AValue : TTargetPoolsRemoveHealthCheckRequestTypehealthChecksArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property healthChecks : TTargetPoolsRemoveHealthCheckRequestTypehealthChecksArray Index 0 Read FhealthChecks Write SethealthChecks;
  end;
  TTargetPoolsRemoveHealthCheckRequestClass = Class of TTargetPoolsRemoveHealthCheckRequest;
  
  { --------------------------------------------------------------------
    TTargetPoolsRemoveInstanceRequest
    --------------------------------------------------------------------}
  
  TTargetPoolsRemoveInstanceRequest = Class(TGoogleBaseObject)
  Private
    Finstances : TTargetPoolsRemoveInstanceRequestTypeinstancesArray;
  Protected
    //Property setters
    Procedure Setinstances(AIndex : Integer; const AValue : TTargetPoolsRemoveInstanceRequestTypeinstancesArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property instances : TTargetPoolsRemoveInstanceRequestTypeinstancesArray Index 0 Read Finstances Write Setinstances;
  end;
  TTargetPoolsRemoveInstanceRequestClass = Class of TTargetPoolsRemoveInstanceRequest;
  
  { --------------------------------------------------------------------
    TTargetPoolsScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TTargetPoolsScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TTargetPoolsScopedListTypewarningTypedataItemClass = Class of TTargetPoolsScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TTargetPoolsScopedListTypewarning
    --------------------------------------------------------------------}
  
  TTargetPoolsScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TTargetPoolsScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TTargetPoolsScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TTargetPoolsScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TTargetPoolsScopedListTypewarningClass = Class of TTargetPoolsScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TTargetPoolsScopedList
    --------------------------------------------------------------------}
  
  TTargetPoolsScopedList = Class(TGoogleBaseObject)
  Private
    FtargetPools : TTargetPoolsScopedListTypetargetPoolsArray;
    Fwarning : TTargetPoolsScopedListTypewarning;
  Protected
    //Property setters
    Procedure SettargetPools(AIndex : Integer; const AValue : TTargetPoolsScopedListTypetargetPoolsArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TTargetPoolsScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property targetPools : TTargetPoolsScopedListTypetargetPoolsArray Index 0 Read FtargetPools Write SettargetPools;
    Property warning : TTargetPoolsScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TTargetPoolsScopedListClass = Class of TTargetPoolsScopedList;
  
  { --------------------------------------------------------------------
    TTargetReference
    --------------------------------------------------------------------}
  
  TTargetReference = Class(TGoogleBaseObject)
  Private
    Ftarget : String;
  Protected
    //Property setters
    Procedure Settarget(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property target : String Index 0 Read Ftarget Write Settarget;
  end;
  TTargetReferenceClass = Class of TTargetReference;
  
  { --------------------------------------------------------------------
    TTargetVpnGateway
    --------------------------------------------------------------------}
  
  TTargetVpnGateway = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    FforwardingRules : TStringArray;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fnetwork : String;
    Fregion : String;
    FselfLink : String;
    Fstatus : String;
    Ftunnels : TStringArray;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetforwardingRules(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setnetwork(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure Settunnels(AIndex : Integer; const AValue : TStringArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property forwardingRules : TStringArray Index 16 Read FforwardingRules Write SetforwardingRules;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property network : String Index 48 Read Fnetwork Write Setnetwork;
    Property region : String Index 56 Read Fregion Write Setregion;
    Property selfLink : String Index 64 Read FselfLink Write SetselfLink;
    Property status : String Index 72 Read Fstatus Write Setstatus;
    Property tunnels : TStringArray Index 80 Read Ftunnels Write Settunnels;
  end;
  TTargetVpnGatewayClass = Class of TTargetVpnGateway;
  
  { --------------------------------------------------------------------
    TTargetVpnGatewayAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TTargetVpnGatewayAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TTargetVpnGatewayAggregatedListTypeitemsClass = Class of TTargetVpnGatewayAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TTargetVpnGatewayAggregatedList
    --------------------------------------------------------------------}
  
  TTargetVpnGatewayAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetVpnGatewayAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetVpnGatewayAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetVpnGatewayAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetVpnGatewayAggregatedListClass = Class of TTargetVpnGatewayAggregatedList;
  
  { --------------------------------------------------------------------
    TTargetVpnGatewayList
    --------------------------------------------------------------------}
  
  TTargetVpnGatewayList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TTargetVpnGatewayListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TTargetVpnGatewayListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TTargetVpnGatewayListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TTargetVpnGatewayListClass = Class of TTargetVpnGatewayList;
  
  { --------------------------------------------------------------------
    TTargetVpnGatewaysScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TTargetVpnGatewaysScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TTargetVpnGatewaysScopedListTypewarningTypedataItemClass = Class of TTargetVpnGatewaysScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TTargetVpnGatewaysScopedListTypewarning
    --------------------------------------------------------------------}
  
  TTargetVpnGatewaysScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TTargetVpnGatewaysScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TTargetVpnGatewaysScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TTargetVpnGatewaysScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TTargetVpnGatewaysScopedListTypewarningClass = Class of TTargetVpnGatewaysScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TTargetVpnGatewaysScopedList
    --------------------------------------------------------------------}
  
  TTargetVpnGatewaysScopedList = Class(TGoogleBaseObject)
  Private
    FtargetVpnGateways : TTargetVpnGatewaysScopedListTypetargetVpnGatewaysArray;
    Fwarning : TTargetVpnGatewaysScopedListTypewarning;
  Protected
    //Property setters
    Procedure SettargetVpnGateways(AIndex : Integer; const AValue : TTargetVpnGatewaysScopedListTypetargetVpnGatewaysArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TTargetVpnGatewaysScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property targetVpnGateways : TTargetVpnGatewaysScopedListTypetargetVpnGatewaysArray Index 0 Read FtargetVpnGateways Write SettargetVpnGateways;
    Property warning : TTargetVpnGatewaysScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TTargetVpnGatewaysScopedListClass = Class of TTargetVpnGatewaysScopedList;
  
  { --------------------------------------------------------------------
    TTestFailure
    --------------------------------------------------------------------}
  
  TTestFailure = Class(TGoogleBaseObject)
  Private
    FactualService : String;
    FexpectedService : String;
    Fhost : String;
    Fpath : String;
  Protected
    //Property setters
    Procedure SetactualService(AIndex : Integer; const AValue : String); virtual;
    Procedure SetexpectedService(AIndex : Integer; const AValue : String); virtual;
    Procedure Sethost(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpath(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property actualService : String Index 0 Read FactualService Write SetactualService;
    Property expectedService : String Index 8 Read FexpectedService Write SetexpectedService;
    Property host : String Index 16 Read Fhost Write Sethost;
    Property path : String Index 24 Read Fpath Write Setpath;
  end;
  TTestFailureClass = Class of TTestFailure;
  
  { --------------------------------------------------------------------
    TUrlMap
    --------------------------------------------------------------------}
  
  TUrlMap = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    FdefaultService : String;
    Fdescription : String;
    Ffingerprint : String;
    FhostRules : TUrlMapTypehostRulesArray;
    Fid : String;
    Fkind : String;
    Fname : String;
    FpathMatchers : TUrlMapTypepathMatchersArray;
    FselfLink : String;
    Ftests : TUrlMapTypetestsArray;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdefaultService(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setfingerprint(AIndex : Integer; const AValue : String); virtual;
    Procedure SethostRules(AIndex : Integer; const AValue : TUrlMapTypehostRulesArray); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetpathMatchers(AIndex : Integer; const AValue : TUrlMapTypepathMatchersArray); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Settests(AIndex : Integer; const AValue : TUrlMapTypetestsArray); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property defaultService : String Index 8 Read FdefaultService Write SetdefaultService;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property fingerprint : String Index 24 Read Ffingerprint Write Setfingerprint;
    Property hostRules : TUrlMapTypehostRulesArray Index 32 Read FhostRules Write SethostRules;
    Property id : String Index 40 Read Fid Write Setid;
    Property kind : String Index 48 Read Fkind Write Setkind;
    Property name : String Index 56 Read Fname Write Setname;
    Property pathMatchers : TUrlMapTypepathMatchersArray Index 64 Read FpathMatchers Write SetpathMatchers;
    Property selfLink : String Index 72 Read FselfLink Write SetselfLink;
    Property tests : TUrlMapTypetestsArray Index 80 Read Ftests Write Settests;
  end;
  TUrlMapClass = Class of TUrlMap;
  
  { --------------------------------------------------------------------
    TUrlMapList
    --------------------------------------------------------------------}
  
  TUrlMapList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TUrlMapListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TUrlMapListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TUrlMapListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TUrlMapListClass = Class of TUrlMapList;
  
  { --------------------------------------------------------------------
    TUrlMapReference
    --------------------------------------------------------------------}
  
  TUrlMapReference = Class(TGoogleBaseObject)
  Private
    FurlMap : String;
  Protected
    //Property setters
    Procedure SeturlMap(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property urlMap : String Index 0 Read FurlMap Write SeturlMap;
  end;
  TUrlMapReferenceClass = Class of TUrlMapReference;
  
  { --------------------------------------------------------------------
    TUrlMapTest
    --------------------------------------------------------------------}
  
  TUrlMapTest = Class(TGoogleBaseObject)
  Private
    Fdescription : String;
    Fhost : String;
    Fpath : String;
    Fservice : String;
  Protected
    //Property setters
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Sethost(AIndex : Integer; const AValue : String); virtual;
    Procedure Setpath(AIndex : Integer; const AValue : String); virtual;
    Procedure Setservice(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property description : String Index 0 Read Fdescription Write Setdescription;
    Property host : String Index 8 Read Fhost Write Sethost;
    Property path : String Index 16 Read Fpath Write Setpath;
    Property service : String Index 24 Read Fservice Write Setservice;
  end;
  TUrlMapTestClass = Class of TUrlMapTest;
  
  { --------------------------------------------------------------------
    TUrlMapValidationResult
    --------------------------------------------------------------------}
  
  TUrlMapValidationResult = Class(TGoogleBaseObject)
  Private
    FloadErrors : TStringArray;
    FloadSucceeded : boolean;
    FtestFailures : TUrlMapValidationResultTypetestFailuresArray;
    FtestPassed : boolean;
  Protected
    //Property setters
    Procedure SetloadErrors(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure SetloadSucceeded(AIndex : Integer; const AValue : boolean); virtual;
    Procedure SettestFailures(AIndex : Integer; const AValue : TUrlMapValidationResultTypetestFailuresArray); virtual;
    Procedure SettestPassed(AIndex : Integer; const AValue : boolean); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property loadErrors : TStringArray Index 0 Read FloadErrors Write SetloadErrors;
    Property loadSucceeded : boolean Index 8 Read FloadSucceeded Write SetloadSucceeded;
    Property testFailures : TUrlMapValidationResultTypetestFailuresArray Index 16 Read FtestFailures Write SettestFailures;
    Property testPassed : boolean Index 24 Read FtestPassed Write SettestPassed;
  end;
  TUrlMapValidationResultClass = Class of TUrlMapValidationResult;
  
  { --------------------------------------------------------------------
    TUrlMapsValidateRequest
    --------------------------------------------------------------------}
  
  TUrlMapsValidateRequest = Class(TGoogleBaseObject)
  Private
    Fresource : TUrlMap;
  Protected
    //Property setters
    Procedure Setresource(AIndex : Integer; const AValue : TUrlMap); virtual;
  Public
  Published
    Property resource : TUrlMap Index 0 Read Fresource Write Setresource;
  end;
  TUrlMapsValidateRequestClass = Class of TUrlMapsValidateRequest;
  
  { --------------------------------------------------------------------
    TUrlMapsValidateResponse
    --------------------------------------------------------------------}
  
  TUrlMapsValidateResponse = Class(TGoogleBaseObject)
  Private
    Fresult : TUrlMapValidationResult;
  Protected
    //Property setters
    Procedure Setresult(AIndex : Integer; const AValue : TUrlMapValidationResult); virtual;
  Public
  Published
    Property result : TUrlMapValidationResult Index 0 Read Fresult Write Setresult;
  end;
  TUrlMapsValidateResponseClass = Class of TUrlMapsValidateResponse;
  
  { --------------------------------------------------------------------
    TUsageExportLocation
    --------------------------------------------------------------------}
  
  TUsageExportLocation = Class(TGoogleBaseObject)
  Private
    FbucketName : String;
    FreportNamePrefix : String;
  Protected
    //Property setters
    Procedure SetbucketName(AIndex : Integer; const AValue : String); virtual;
    Procedure SetreportNamePrefix(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property bucketName : String Index 0 Read FbucketName Write SetbucketName;
    Property reportNamePrefix : String Index 8 Read FreportNamePrefix Write SetreportNamePrefix;
  end;
  TUsageExportLocationClass = Class of TUsageExportLocation;
  
  { --------------------------------------------------------------------
    TVpnTunnel
    --------------------------------------------------------------------}
  
  TVpnTunnel = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdescription : String;
    FdetailedStatus : String;
    Fid : String;
    FikeVersion : integer;
    Fkind : String;
    FlocalTrafficSelector : TStringArray;
    Fname : String;
    FpeerIp : String;
    Fregion : String;
    FselfLink : String;
    FsharedSecret : String;
    FsharedSecretHash : String;
    Fstatus : String;
    FtargetVpnGateway : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure SetdetailedStatus(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure SetikeVersion(AIndex : Integer; const AValue : integer); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetlocalTrafficSelector(AIndex : Integer; const AValue : TStringArray); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure SetpeerIp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsharedSecret(AIndex : Integer; const AValue : String); virtual;
    Procedure SetsharedSecretHash(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
    Procedure SettargetVpnGateway(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property description : String Index 8 Read Fdescription Write Setdescription;
    Property detailedStatus : String Index 16 Read FdetailedStatus Write SetdetailedStatus;
    Property id : String Index 24 Read Fid Write Setid;
    Property ikeVersion : integer Index 32 Read FikeVersion Write SetikeVersion;
    Property kind : String Index 40 Read Fkind Write Setkind;
    Property localTrafficSelector : TStringArray Index 48 Read FlocalTrafficSelector Write SetlocalTrafficSelector;
    Property name : String Index 56 Read Fname Write Setname;
    Property peerIp : String Index 64 Read FpeerIp Write SetpeerIp;
    Property region : String Index 72 Read Fregion Write Setregion;
    Property selfLink : String Index 80 Read FselfLink Write SetselfLink;
    Property sharedSecret : String Index 88 Read FsharedSecret Write SetsharedSecret;
    Property sharedSecretHash : String Index 96 Read FsharedSecretHash Write SetsharedSecretHash;
    Property status : String Index 104 Read Fstatus Write Setstatus;
    Property targetVpnGateway : String Index 112 Read FtargetVpnGateway Write SettargetVpnGateway;
  end;
  TVpnTunnelClass = Class of TVpnTunnel;
  
  { --------------------------------------------------------------------
    TVpnTunnelAggregatedListTypeitems
    --------------------------------------------------------------------}
  
  TVpnTunnelAggregatedListTypeitems = Class(TGoogleBaseObject)
  Private
  Protected
    //Property setters
  Public
    Class Function AllowAdditionalProperties : Boolean; override;
  Published
  end;
  TVpnTunnelAggregatedListTypeitemsClass = Class of TVpnTunnelAggregatedListTypeitems;
  
  { --------------------------------------------------------------------
    TVpnTunnelAggregatedList
    --------------------------------------------------------------------}
  
  TVpnTunnelAggregatedList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TVpnTunnelAggregatedListTypeitems;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TVpnTunnelAggregatedListTypeitems); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TVpnTunnelAggregatedListTypeitems Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TVpnTunnelAggregatedListClass = Class of TVpnTunnelAggregatedList;
  
  { --------------------------------------------------------------------
    TVpnTunnelList
    --------------------------------------------------------------------}
  
  TVpnTunnelList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TVpnTunnelListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TVpnTunnelListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TVpnTunnelListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TVpnTunnelListClass = Class of TVpnTunnelList;
  
  { --------------------------------------------------------------------
    TVpnTunnelsScopedListTypewarningTypedataItem
    --------------------------------------------------------------------}
  
  TVpnTunnelsScopedListTypewarningTypedataItem = Class(TGoogleBaseObject)
  Private
    Fkey : String;
    Fvalue : String;
  Protected
    //Property setters
    Procedure Setkey(AIndex : Integer; const AValue : String); virtual;
    Procedure Setvalue(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property key : String Index 0 Read Fkey Write Setkey;
    Property value : String Index 8 Read Fvalue Write Setvalue;
  end;
  TVpnTunnelsScopedListTypewarningTypedataItemClass = Class of TVpnTunnelsScopedListTypewarningTypedataItem;
  
  { --------------------------------------------------------------------
    TVpnTunnelsScopedListTypewarning
    --------------------------------------------------------------------}
  
  TVpnTunnelsScopedListTypewarning = Class(TGoogleBaseObject)
  Private
    Fcode : String;
    Fdata : TVpnTunnelsScopedListTypewarningTypedataArray;
    Fmessage : String;
  Protected
    //Property setters
    Procedure Setcode(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdata(AIndex : Integer; const AValue : TVpnTunnelsScopedListTypewarningTypedataArray); virtual;
    Procedure Setmessage(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property code : String Index 0 Read Fcode Write Setcode;
    Property data : TVpnTunnelsScopedListTypewarningTypedataArray Index 8 Read Fdata Write Setdata;
    Property message : String Index 16 Read Fmessage Write Setmessage;
  end;
  TVpnTunnelsScopedListTypewarningClass = Class of TVpnTunnelsScopedListTypewarning;
  
  { --------------------------------------------------------------------
    TVpnTunnelsScopedList
    --------------------------------------------------------------------}
  
  TVpnTunnelsScopedList = Class(TGoogleBaseObject)
  Private
    FvpnTunnels : TVpnTunnelsScopedListTypevpnTunnelsArray;
    Fwarning : TVpnTunnelsScopedListTypewarning;
  Protected
    //Property setters
    Procedure SetvpnTunnels(AIndex : Integer; const AValue : TVpnTunnelsScopedListTypevpnTunnelsArray); virtual;
    Procedure Setwarning(AIndex : Integer; const AValue : TVpnTunnelsScopedListTypewarning); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property vpnTunnels : TVpnTunnelsScopedListTypevpnTunnelsArray Index 0 Read FvpnTunnels Write SetvpnTunnels;
    Property warning : TVpnTunnelsScopedListTypewarning Index 8 Read Fwarning Write Setwarning;
  end;
  TVpnTunnelsScopedListClass = Class of TVpnTunnelsScopedList;
  
  { --------------------------------------------------------------------
    TZone
    --------------------------------------------------------------------}
  
  TZone = Class(TGoogleBaseObject)
  Private
    FcreationTimestamp : String;
    Fdeprecated : TDeprecationStatus;
    Fdescription : String;
    Fid : String;
    Fkind : String;
    Fname : String;
    Fregion : String;
    FselfLink : String;
    Fstatus : String;
  Protected
    //Property setters
    Procedure SetcreationTimestamp(AIndex : Integer; const AValue : String); virtual;
    Procedure Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); virtual;
    Procedure Setdescription(AIndex : Integer; const AValue : String); virtual;
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure Setname(AIndex : Integer; const AValue : String); virtual;
    Procedure Setregion(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    Procedure Setstatus(AIndex : Integer; const AValue : String); virtual;
  Public
  Published
    Property creationTimestamp : String Index 0 Read FcreationTimestamp Write SetcreationTimestamp;
    Property deprecated : TDeprecationStatus Index 8 Read Fdeprecated Write Setdeprecated;
    Property description : String Index 16 Read Fdescription Write Setdescription;
    Property id : String Index 24 Read Fid Write Setid;
    Property kind : String Index 32 Read Fkind Write Setkind;
    Property name : String Index 40 Read Fname Write Setname;
    Property region : String Index 48 Read Fregion Write Setregion;
    Property selfLink : String Index 56 Read FselfLink Write SetselfLink;
    Property status : String Index 64 Read Fstatus Write Setstatus;
  end;
  TZoneClass = Class of TZone;
  
  { --------------------------------------------------------------------
    TZoneList
    --------------------------------------------------------------------}
  
  TZoneList = Class(TGoogleBaseObject)
  Private
    Fid : String;
    Fitems : TZoneListTypeitemsArray;
    Fkind : String;
    FnextPageToken : String;
    FselfLink : String;
  Protected
    //Property setters
    Procedure Setid(AIndex : Integer; const AValue : String); virtual;
    Procedure Setitems(AIndex : Integer; const AValue : TZoneListTypeitemsArray); virtual;
    Procedure Setkind(AIndex : Integer; const AValue : String); virtual;
    Procedure SetnextPageToken(AIndex : Integer; const AValue : String); virtual;
    Procedure SetselfLink(AIndex : Integer; const AValue : String); virtual;
    //2.6.4. bug workaround
    {$IFDEF VER2_6}
    Procedure SetArrayLength(Const AName : String; ALength : Longint); override;
    {$ENDIF VER2_6}
  Public
  Published
    Property id : String Index 0 Read Fid Write Setid;
    Property items : TZoneListTypeitemsArray Index 8 Read Fitems Write Setitems;
    Property kind : String Index 16 Read Fkind Write Setkind;
    Property nextPageToken : String Index 24 Read FnextPageToken Write SetnextPageToken;
    Property selfLink : String Index 32 Read FselfLink Write SetselfLink;
  end;
  TZoneListClass = Class of TZoneList;
  
  { --------------------------------------------------------------------
    TAddressesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAddressesResource, method AggregatedList
  
  TAddressesAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TAddressesResource, method List
  
  TAddressesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TAddressesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TAddressAggregatedList;
    Function AggregatedList(project: string; AQuery : TAddressesaggregatedListOptions) : TAddressAggregatedList;
    Function Delete(address: string; project: string; region: string) : TOperation;
    Function Get(address: string; project: string; region: string) : TAddress;
    Function Insert(project: string; region: string; aAddress : TAddress) : TOperation;
    Function List(project: string; region: string; AQuery : string  = '') : TAddressList;
    Function List(project: string; region: string; AQuery : TAddresseslistOptions) : TAddressList;
  end;
  
  
  { --------------------------------------------------------------------
    TAutoscalersResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TAutoscalersResource, method AggregatedList
  
  TAutoscalersAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TAutoscalersResource, method List
  
  TAutoscalersListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TAutoscalersResource, method Patch
  
  TAutoscalersPatchOptions = Record
    autoscaler : String;
  end;
  
  
  //Optional query Options for TAutoscalersResource, method Update
  
  TAutoscalersUpdateOptions = Record
    autoscaler : String;
  end;
  
  TAutoscalersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TAutoscalerAggregatedList;
    Function AggregatedList(project: string; AQuery : TAutoscalersaggregatedListOptions) : TAutoscalerAggregatedList;
    Function Delete(autoscaler: string; project: string; zone: string) : TOperation;
    Function Get(autoscaler: string; project: string; zone: string) : TAutoscaler;
    Function Insert(project: string; zone: string; aAutoscaler : TAutoscaler) : TOperation;
    Function List(project: string; zone: string; AQuery : string  = '') : TAutoscalerList;
    Function List(project: string; zone: string; AQuery : TAutoscalerslistOptions) : TAutoscalerList;
    Function Patch(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : string  = '') : TOperation;
    Function Patch(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : TAutoscalerspatchOptions) : TOperation;
    Function Update(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : string  = '') : TOperation;
    Function Update(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : TAutoscalersupdateOptions) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TBackendServicesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TBackendServicesResource, method List
  
  TBackendServicesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TBackendServicesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(backendService: string; project: string) : TOperation;
    Function Get(backendService: string; project: string) : TBackendService;
    Function GetHealth(backendService: string; project: string; aResourceGroupReference : TResourceGroupReference) : TBackendServiceGroupHealth;
    Function Insert(project: string; aBackendService : TBackendService) : TOperation;
    Function List(project: string; AQuery : string  = '') : TBackendServiceList;
    Function List(project: string; AQuery : TBackendServiceslistOptions) : TBackendServiceList;
    Function Patch(backendService: string; project: string; aBackendService : TBackendService) : TOperation;
    Function Update(backendService: string; project: string; aBackendService : TBackendService) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TDiskTypesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TDiskTypesResource, method AggregatedList
  
  TDiskTypesAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TDiskTypesResource, method List
  
  TDiskTypesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TDiskTypesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TDiskTypeAggregatedList;
    Function AggregatedList(project: string; AQuery : TDiskTypesaggregatedListOptions) : TDiskTypeAggregatedList;
    Function Get(diskType: string; project: string; zone: string) : TDiskType;
    Function List(project: string; zone: string; AQuery : string  = '') : TDiskTypeList;
    Function List(project: string; zone: string; AQuery : TDiskTypeslistOptions) : TDiskTypeList;
  end;
  
  
  { --------------------------------------------------------------------
    TDisksResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TDisksResource, method AggregatedList
  
  TDisksAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TDisksResource, method Insert
  
  TDisksInsertOptions = Record
    sourceImage : String;
  end;
  
  
  //Optional query Options for TDisksResource, method List
  
  TDisksListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TDisksResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TDiskAggregatedList;
    Function AggregatedList(project: string; AQuery : TDisksaggregatedListOptions) : TDiskAggregatedList;
    Function CreateSnapshot(disk: string; project: string; zone: string; aSnapshot : TSnapshot) : TOperation;
    Function Delete(disk: string; project: string; zone: string) : TOperation;
    Function Get(disk: string; project: string; zone: string) : TDisk;
    Function Insert(project: string; zone: string; aDisk : TDisk; AQuery : string  = '') : TOperation;
    Function Insert(project: string; zone: string; aDisk : TDisk; AQuery : TDisksinsertOptions) : TOperation;
    Function List(project: string; zone: string; AQuery : string  = '') : TDiskList;
    Function List(project: string; zone: string; AQuery : TDiskslistOptions) : TDiskList;
    Function Resize(disk: string; project: string; zone: string; aDisksResizeRequest : TDisksResizeRequest) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TFirewallsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TFirewallsResource, method List
  
  TFirewallsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TFirewallsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(firewall: string; project: string) : TOperation;
    Function Get(firewall: string; project: string) : TFirewall;
    Function Insert(project: string; aFirewall : TFirewall) : TOperation;
    Function List(project: string; AQuery : string  = '') : TFirewallList;
    Function List(project: string; AQuery : TFirewallslistOptions) : TFirewallList;
    Function Patch(firewall: string; project: string; aFirewall : TFirewall) : TOperation;
    Function Update(firewall: string; project: string; aFirewall : TFirewall) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TForwardingRulesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TForwardingRulesResource, method AggregatedList
  
  TForwardingRulesAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TForwardingRulesResource, method List
  
  TForwardingRulesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TForwardingRulesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TForwardingRuleAggregatedList;
    Function AggregatedList(project: string; AQuery : TForwardingRulesaggregatedListOptions) : TForwardingRuleAggregatedList;
    Function Delete(forwardingRule: string; project: string; region: string) : TOperation;
    Function Get(forwardingRule: string; project: string; region: string) : TForwardingRule;
    Function Insert(project: string; region: string; aForwardingRule : TForwardingRule) : TOperation;
    Function List(project: string; region: string; AQuery : string  = '') : TForwardingRuleList;
    Function List(project: string; region: string; AQuery : TForwardingRuleslistOptions) : TForwardingRuleList;
    Function SetTarget(forwardingRule: string; project: string; region: string; aTargetReference : TTargetReference) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TGlobalAddressesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TGlobalAddressesResource, method List
  
  TGlobalAddressesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TGlobalAddressesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(address: string; project: string) : TOperation;
    Function Get(address: string; project: string) : TAddress;
    Function Insert(project: string; aAddress : TAddress) : TOperation;
    Function List(project: string; AQuery : string  = '') : TAddressList;
    Function List(project: string; AQuery : TGlobalAddresseslistOptions) : TAddressList;
  end;
  
  
  { --------------------------------------------------------------------
    TGlobalForwardingRulesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TGlobalForwardingRulesResource, method List
  
  TGlobalForwardingRulesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TGlobalForwardingRulesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(forwardingRule: string; project: string) : TOperation;
    Function Get(forwardingRule: string; project: string) : TForwardingRule;
    Function Insert(project: string; aForwardingRule : TForwardingRule) : TOperation;
    Function List(project: string; AQuery : string  = '') : TForwardingRuleList;
    Function List(project: string; AQuery : TGlobalForwardingRuleslistOptions) : TForwardingRuleList;
    Function SetTarget(forwardingRule: string; project: string; aTargetReference : TTargetReference) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TGlobalOperationsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TGlobalOperationsResource, method AggregatedList
  
  TGlobalOperationsAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TGlobalOperationsResource, method List
  
  TGlobalOperationsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TGlobalOperationsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TOperationAggregatedList;
    Function AggregatedList(project: string; AQuery : TGlobalOperationsaggregatedListOptions) : TOperationAggregatedList;
    Procedure Delete(operation: string; project: string);
    Function Get(operation: string; project: string) : TOperation;
    Function List(project: string; AQuery : string  = '') : TOperationList;
    Function List(project: string; AQuery : TGlobalOperationslistOptions) : TOperationList;
  end;
  
  
  { --------------------------------------------------------------------
    THttpHealthChecksResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for THttpHealthChecksResource, method List
  
  THttpHealthChecksListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  THttpHealthChecksResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(httpHealthCheck: string; project: string) : TOperation;
    Function Get(httpHealthCheck: string; project: string) : THttpHealthCheck;
    Function Insert(project: string; aHttpHealthCheck : THttpHealthCheck) : TOperation;
    Function List(project: string; AQuery : string  = '') : THttpHealthCheckList;
    Function List(project: string; AQuery : THttpHealthCheckslistOptions) : THttpHealthCheckList;
    Function Patch(httpHealthCheck: string; project: string; aHttpHealthCheck : THttpHealthCheck) : TOperation;
    Function Update(httpHealthCheck: string; project: string; aHttpHealthCheck : THttpHealthCheck) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    THttpsHealthChecksResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for THttpsHealthChecksResource, method List
  
  THttpsHealthChecksListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  THttpsHealthChecksResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(httpsHealthCheck: string; project: string) : TOperation;
    Function Get(httpsHealthCheck: string; project: string) : THttpsHealthCheck;
    Function Insert(project: string; aHttpsHealthCheck : THttpsHealthCheck) : TOperation;
    Function List(project: string; AQuery : string  = '') : THttpsHealthCheckList;
    Function List(project: string; AQuery : THttpsHealthCheckslistOptions) : THttpsHealthCheckList;
    Function Patch(httpsHealthCheck: string; project: string; aHttpsHealthCheck : THttpsHealthCheck) : TOperation;
    Function Update(httpsHealthCheck: string; project: string; aHttpsHealthCheck : THttpsHealthCheck) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TImagesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TImagesResource, method List
  
  TImagesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TImagesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(image: string; project: string) : TOperation;
    Function Deprecate(image: string; project: string; aDeprecationStatus : TDeprecationStatus) : TOperation;
    Function Get(image: string; project: string) : TImage;
    Function GetFromFamily(family: string; project: string) : TImage;
    Function Insert(project: string; aImage : TImage) : TOperation;
    Function List(project: string; AQuery : string  = '') : TImageList;
    Function List(project: string; AQuery : TImageslistOptions) : TImageList;
  end;
  
  
  { --------------------------------------------------------------------
    TInstanceGroupManagersResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TInstanceGroupManagersResource, method AggregatedList
  
  TInstanceGroupManagersAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TInstanceGroupManagersResource, method List
  
  TInstanceGroupManagersListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TInstanceGroupManagersResource, method Resize
  
  TInstanceGroupManagersResizeOptions = Record
    size : integer;
  end;
  
  TInstanceGroupManagersResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AbandonInstances(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersAbandonInstancesRequest : TInstanceGroupManagersAbandonInstancesRequest) : TOperation;
    Function AggregatedList(project: string; AQuery : string  = '') : TInstanceGroupManagerAggregatedList;
    Function AggregatedList(project: string; AQuery : TInstanceGroupManagersaggregatedListOptions) : TInstanceGroupManagerAggregatedList;
    Function Delete(instanceGroupManager: string; project: string; zone: string) : TOperation;
    Function DeleteInstances(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersDeleteInstancesRequest : TInstanceGroupManagersDeleteInstancesRequest) : TOperation;
    Function Get(instanceGroupManager: string; project: string; zone: string) : TInstanceGroupManager;
    Function Insert(project: string; zone: string; aInstanceGroupManager : TInstanceGroupManager) : TOperation;
    Function List(project: string; zone: string; AQuery : string  = '') : TInstanceGroupManagerList;
    Function List(project: string; zone: string; AQuery : TInstanceGroupManagerslistOptions) : TInstanceGroupManagerList;
    Function ListManagedInstances(instanceGroupManager: string; project: string; zone: string) : TInstanceGroupManagersListManagedInstancesResponse;
    Function RecreateInstances(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersRecreateInstancesRequest : TInstanceGroupManagersRecreateInstancesRequest) : TOperation;
    Function Resize(instanceGroupManager: string; project: string; zone: string; AQuery : string  = '') : TOperation;
    Function Resize(instanceGroupManager: string; project: string; zone: string; AQuery : TInstanceGroupManagersresizeOptions) : TOperation;
    Function SetInstanceTemplate(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersSetInstanceTemplateRequest : TInstanceGroupManagersSetInstanceTemplateRequest) : TOperation;
    Function SetTargetPools(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersSetTargetPoolsRequest : TInstanceGroupManagersSetTargetPoolsRequest) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TInstanceGroupsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TInstanceGroupsResource, method AggregatedList
  
  TInstanceGroupsAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TInstanceGroupsResource, method List
  
  TInstanceGroupsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TInstanceGroupsResource, method ListInstances
  
  TInstanceGroupsListInstancesOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TInstanceGroupsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AddInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsAddInstancesRequest : TInstanceGroupsAddInstancesRequest) : TOperation;
    Function AggregatedList(project: string; AQuery : string  = '') : TInstanceGroupAggregatedList;
    Function AggregatedList(project: string; AQuery : TInstanceGroupsaggregatedListOptions) : TInstanceGroupAggregatedList;
    Function Delete(instanceGroup: string; project: string; zone: string) : TOperation;
    Function Get(instanceGroup: string; project: string; zone: string) : TInstanceGroup;
    Function Insert(project: string; zone: string; aInstanceGroup : TInstanceGroup) : TOperation;
    Function List(project: string; zone: string; AQuery : string  = '') : TInstanceGroupList;
    Function List(project: string; zone: string; AQuery : TInstanceGroupslistOptions) : TInstanceGroupList;
    Function ListInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsListInstancesRequest : TInstanceGroupsListInstancesRequest; AQuery : string  = '') : TInstanceGroupsListInstances;
    Function ListInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsListInstancesRequest : TInstanceGroupsListInstancesRequest; AQuery : TInstanceGroupslistInstancesOptions) : TInstanceGroupsListInstances;
    Function RemoveInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsRemoveInstancesRequest : TInstanceGroupsRemoveInstancesRequest) : TOperation;
    Function SetNamedPorts(instanceGroup: string; project: string; zone: string; aInstanceGroupsSetNamedPortsRequest : TInstanceGroupsSetNamedPortsRequest) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TInstanceTemplatesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TInstanceTemplatesResource, method List
  
  TInstanceTemplatesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TInstanceTemplatesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(instanceTemplate: string; project: string) : TOperation;
    Function Get(instanceTemplate: string; project: string) : TInstanceTemplate;
    Function Insert(project: string; aInstanceTemplate : TInstanceTemplate) : TOperation;
    Function List(project: string; AQuery : string  = '') : TInstanceTemplateList;
    Function List(project: string; AQuery : TInstanceTemplateslistOptions) : TInstanceTemplateList;
  end;
  
  
  { --------------------------------------------------------------------
    TInstancesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TInstancesResource, method AddAccessConfig
  
  TInstancesAddAccessConfigOptions = Record
    networkInterface : String;
  end;
  
  
  //Optional query Options for TInstancesResource, method AggregatedList
  
  TInstancesAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TInstancesResource, method DeleteAccessConfig
  
  TInstancesDeleteAccessConfigOptions = Record
    accessConfig : String;
    networkInterface : String;
  end;
  
  
  //Optional query Options for TInstancesResource, method DetachDisk
  
  TInstancesDetachDiskOptions = Record
    deviceName : String;
  end;
  
  
  //Optional query Options for TInstancesResource, method GetSerialPortOutput
  
  TInstancesGetSerialPortOutputOptions = Record
    port : integer;
  end;
  
  
  //Optional query Options for TInstancesResource, method List
  
  TInstancesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TInstancesResource, method SetDiskAutoDelete
  
  TInstancesSetDiskAutoDeleteOptions = Record
    autoDelete : boolean;
    deviceName : String;
  end;
  
  TInstancesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AddAccessConfig(instance: string; project: string; zone: string; aAccessConfig : TAccessConfig; AQuery : string  = '') : TOperation;
    Function AddAccessConfig(instance: string; project: string; zone: string; aAccessConfig : TAccessConfig; AQuery : TInstancesaddAccessConfigOptions) : TOperation;
    Function AggregatedList(project: string; AQuery : string  = '') : TInstanceAggregatedList;
    Function AggregatedList(project: string; AQuery : TInstancesaggregatedListOptions) : TInstanceAggregatedList;
    Function AttachDisk(instance: string; project: string; zone: string; aAttachedDisk : TAttachedDisk) : TOperation;
    Function Delete(instance: string; project: string; zone: string) : TOperation;
    Function DeleteAccessConfig(instance: string; project: string; zone: string; AQuery : string  = '') : TOperation;
    Function DeleteAccessConfig(instance: string; project: string; zone: string; AQuery : TInstancesdeleteAccessConfigOptions) : TOperation;
    Function DetachDisk(instance: string; project: string; zone: string; AQuery : string  = '') : TOperation;
    Function DetachDisk(instance: string; project: string; zone: string; AQuery : TInstancesdetachDiskOptions) : TOperation;
    Function Get(instance: string; project: string; zone: string) : TInstance;
    Function GetSerialPortOutput(instance: string; project: string; zone: string; AQuery : string  = '') : TSerialPortOutput;
    Function GetSerialPortOutput(instance: string; project: string; zone: string; AQuery : TInstancesgetSerialPortOutputOptions) : TSerialPortOutput;
    Function Insert(project: string; zone: string; aInstance : TInstance) : TOperation;
    Function List(project: string; zone: string; AQuery : string  = '') : TInstanceList;
    Function List(project: string; zone: string; AQuery : TInstanceslistOptions) : TInstanceList;
    Function Reset(instance: string; project: string; zone: string) : TOperation;
    Function SetDiskAutoDelete(instance: string; project: string; zone: string; AQuery : string  = '') : TOperation;
    Function SetDiskAutoDelete(instance: string; project: string; zone: string; AQuery : TInstancessetDiskAutoDeleteOptions) : TOperation;
    Function SetMachineType(instance: string; project: string; zone: string; aInstancesSetMachineTypeRequest : TInstancesSetMachineTypeRequest) : TOperation;
    Function SetMetadata(instance: string; project: string; zone: string; aMetadata : TMetadata) : TOperation;
    Function SetScheduling(instance: string; project: string; zone: string; aScheduling : TScheduling) : TOperation;
    Function SetTags(instance: string; project: string; zone: string; aTags : TTags) : TOperation;
    Function Start(instance: string; project: string; zone: string) : TOperation;
    Function Stop(instance: string; project: string; zone: string) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TLicensesResource
    --------------------------------------------------------------------}
  
  TLicensesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(license: string; project: string) : TLicense;
  end;
  
  
  { --------------------------------------------------------------------
    TMachineTypesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TMachineTypesResource, method AggregatedList
  
  TMachineTypesAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TMachineTypesResource, method List
  
  TMachineTypesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TMachineTypesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TMachineTypeAggregatedList;
    Function AggregatedList(project: string; AQuery : TMachineTypesaggregatedListOptions) : TMachineTypeAggregatedList;
    Function Get(machineType: string; project: string; zone: string) : TMachineType;
    Function List(project: string; zone: string; AQuery : string  = '') : TMachineTypeList;
    Function List(project: string; zone: string; AQuery : TMachineTypeslistOptions) : TMachineTypeList;
  end;
  
  
  { --------------------------------------------------------------------
    TNetworksResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TNetworksResource, method List
  
  TNetworksListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TNetworksResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(network: string; project: string) : TOperation;
    Function Get(network: string; project: string) : TNetwork;
    Function Insert(project: string; aNetwork : TNetwork) : TOperation;
    Function List(project: string; AQuery : string  = '') : TNetworkList;
    Function List(project: string; AQuery : TNetworkslistOptions) : TNetworkList;
  end;
  
  
  { --------------------------------------------------------------------
    TProjectsResource
    --------------------------------------------------------------------}
  
  TProjectsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(project: string) : TProject;
    Function MoveDisk(project: string; aDiskMoveRequest : TDiskMoveRequest) : TOperation;
    Function MoveInstance(project: string; aInstanceMoveRequest : TInstanceMoveRequest) : TOperation;
    Function SetCommonInstanceMetadata(project: string; aMetadata : TMetadata) : TOperation;
    Function SetUsageExportBucket(project: string; aUsageExportLocation : TUsageExportLocation) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TRegionOperationsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TRegionOperationsResource, method List
  
  TRegionOperationsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TRegionOperationsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(operation: string; project: string; region: string);
    Function Get(operation: string; project: string; region: string) : TOperation;
    Function List(project: string; region: string; AQuery : string  = '') : TOperationList;
    Function List(project: string; region: string; AQuery : TRegionOperationslistOptions) : TOperationList;
  end;
  
  
  { --------------------------------------------------------------------
    TRegionsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TRegionsResource, method List
  
  TRegionsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TRegionsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(project: string; region: string) : TRegion;
    Function List(project: string; AQuery : string  = '') : TRegionList;
    Function List(project: string; AQuery : TRegionslistOptions) : TRegionList;
  end;
  
  
  { --------------------------------------------------------------------
    TRoutesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TRoutesResource, method List
  
  TRoutesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TRoutesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(project: string; route: string) : TOperation;
    Function Get(project: string; route: string) : TRoute;
    Function Insert(project: string; aRoute : TRoute) : TOperation;
    Function List(project: string; AQuery : string  = '') : TRouteList;
    Function List(project: string; AQuery : TRouteslistOptions) : TRouteList;
  end;
  
  
  { --------------------------------------------------------------------
    TSnapshotsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TSnapshotsResource, method List
  
  TSnapshotsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TSnapshotsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(project: string; snapshot: string) : TOperation;
    Function Get(project: string; snapshot: string) : TSnapshot;
    Function List(project: string; AQuery : string  = '') : TSnapshotList;
    Function List(project: string; AQuery : TSnapshotslistOptions) : TSnapshotList;
  end;
  
  
  { --------------------------------------------------------------------
    TSslCertificatesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TSslCertificatesResource, method List
  
  TSslCertificatesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TSslCertificatesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(project: string; sslCertificate: string) : TOperation;
    Function Get(project: string; sslCertificate: string) : TSslCertificate;
    Function Insert(project: string; aSslCertificate : TSslCertificate) : TOperation;
    Function List(project: string; AQuery : string  = '') : TSslCertificateList;
    Function List(project: string; AQuery : TSslCertificateslistOptions) : TSslCertificateList;
  end;
  
  
  { --------------------------------------------------------------------
    TSubnetworksResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TSubnetworksResource, method AggregatedList
  
  TSubnetworksAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TSubnetworksResource, method List
  
  TSubnetworksListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TSubnetworksResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TSubnetworkAggregatedList;
    Function AggregatedList(project: string; AQuery : TSubnetworksaggregatedListOptions) : TSubnetworkAggregatedList;
    Function Delete(project: string; region: string; subnetwork: string) : TOperation;
    Function Get(project: string; region: string; subnetwork: string) : TSubnetwork;
    Function Insert(project: string; region: string; aSubnetwork : TSubnetwork) : TOperation;
    Function List(project: string; region: string; AQuery : string  = '') : TSubnetworkList;
    Function List(project: string; region: string; AQuery : TSubnetworkslistOptions) : TSubnetworkList;
  end;
  
  
  { --------------------------------------------------------------------
    TTargetHttpProxiesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TTargetHttpProxiesResource, method List
  
  TTargetHttpProxiesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TTargetHttpProxiesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(project: string; targetHttpProxy: string) : TOperation;
    Function Get(project: string; targetHttpProxy: string) : TTargetHttpProxy;
    Function Insert(project: string; aTargetHttpProxy : TTargetHttpProxy) : TOperation;
    Function List(project: string; AQuery : string  = '') : TTargetHttpProxyList;
    Function List(project: string; AQuery : TTargetHttpProxieslistOptions) : TTargetHttpProxyList;
    Function SetUrlMap(project: string; targetHttpProxy: string; aUrlMapReference : TUrlMapReference) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TTargetHttpsProxiesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TTargetHttpsProxiesResource, method List
  
  TTargetHttpsProxiesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TTargetHttpsProxiesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(project: string; targetHttpsProxy: string) : TOperation;
    Function Get(project: string; targetHttpsProxy: string) : TTargetHttpsProxy;
    Function Insert(project: string; aTargetHttpsProxy : TTargetHttpsProxy) : TOperation;
    Function List(project: string; AQuery : string  = '') : TTargetHttpsProxyList;
    Function List(project: string; AQuery : TTargetHttpsProxieslistOptions) : TTargetHttpsProxyList;
    Function SetSslCertificates(project: string; targetHttpsProxy: string; aTargetHttpsProxiesSetSslCertificatesRequest : TTargetHttpsProxiesSetSslCertificatesRequest) : TOperation;
    Function SetUrlMap(project: string; targetHttpsProxy: string; aUrlMapReference : TUrlMapReference) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TTargetInstancesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TTargetInstancesResource, method AggregatedList
  
  TTargetInstancesAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TTargetInstancesResource, method List
  
  TTargetInstancesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TTargetInstancesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TTargetInstanceAggregatedList;
    Function AggregatedList(project: string; AQuery : TTargetInstancesaggregatedListOptions) : TTargetInstanceAggregatedList;
    Function Delete(project: string; targetInstance: string; zone: string) : TOperation;
    Function Get(project: string; targetInstance: string; zone: string) : TTargetInstance;
    Function Insert(project: string; zone: string; aTargetInstance : TTargetInstance) : TOperation;
    Function List(project: string; zone: string; AQuery : string  = '') : TTargetInstanceList;
    Function List(project: string; zone: string; AQuery : TTargetInstanceslistOptions) : TTargetInstanceList;
  end;
  
  
  { --------------------------------------------------------------------
    TTargetPoolsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TTargetPoolsResource, method AggregatedList
  
  TTargetPoolsAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TTargetPoolsResource, method List
  
  TTargetPoolsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TTargetPoolsResource, method SetBackup
  
  TTargetPoolsSetBackupOptions = Record
    failoverRatio : integer;
  end;
  
  TTargetPoolsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AddHealthCheck(project: string; region: string; targetPool: string; aTargetPoolsAddHealthCheckRequest : TTargetPoolsAddHealthCheckRequest) : TOperation;
    Function AddInstance(project: string; region: string; targetPool: string; aTargetPoolsAddInstanceRequest : TTargetPoolsAddInstanceRequest) : TOperation;
    Function AggregatedList(project: string; AQuery : string  = '') : TTargetPoolAggregatedList;
    Function AggregatedList(project: string; AQuery : TTargetPoolsaggregatedListOptions) : TTargetPoolAggregatedList;
    Function Delete(project: string; region: string; targetPool: string) : TOperation;
    Function Get(project: string; region: string; targetPool: string) : TTargetPool;
    Function GetHealth(project: string; region: string; targetPool: string; aInstanceReference : TInstanceReference) : TTargetPoolInstanceHealth;
    Function Insert(project: string; region: string; aTargetPool : TTargetPool) : TOperation;
    Function List(project: string; region: string; AQuery : string  = '') : TTargetPoolList;
    Function List(project: string; region: string; AQuery : TTargetPoolslistOptions) : TTargetPoolList;
    Function RemoveHealthCheck(project: string; region: string; targetPool: string; aTargetPoolsRemoveHealthCheckRequest : TTargetPoolsRemoveHealthCheckRequest) : TOperation;
    Function RemoveInstance(project: string; region: string; targetPool: string; aTargetPoolsRemoveInstanceRequest : TTargetPoolsRemoveInstanceRequest) : TOperation;
    Function SetBackup(project: string; region: string; targetPool: string; aTargetReference : TTargetReference; AQuery : string  = '') : TOperation;
    Function SetBackup(project: string; region: string; targetPool: string; aTargetReference : TTargetReference; AQuery : TTargetPoolssetBackupOptions) : TOperation;
  end;
  
  
  { --------------------------------------------------------------------
    TTargetVpnGatewaysResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TTargetVpnGatewaysResource, method AggregatedList
  
  TTargetVpnGatewaysAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TTargetVpnGatewaysResource, method List
  
  TTargetVpnGatewaysListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TTargetVpnGatewaysResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TTargetVpnGatewayAggregatedList;
    Function AggregatedList(project: string; AQuery : TTargetVpnGatewaysaggregatedListOptions) : TTargetVpnGatewayAggregatedList;
    Function Delete(project: string; region: string; targetVpnGateway: string) : TOperation;
    Function Get(project: string; region: string; targetVpnGateway: string) : TTargetVpnGateway;
    Function Insert(project: string; region: string; aTargetVpnGateway : TTargetVpnGateway) : TOperation;
    Function List(project: string; region: string; AQuery : string  = '') : TTargetVpnGatewayList;
    Function List(project: string; region: string; AQuery : TTargetVpnGatewayslistOptions) : TTargetVpnGatewayList;
  end;
  
  
  { --------------------------------------------------------------------
    TUrlMapsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TUrlMapsResource, method List
  
  TUrlMapsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TUrlMapsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Delete(project: string; urlMap: string) : TOperation;
    Function Get(project: string; urlMap: string) : TUrlMap;
    Function Insert(project: string; aUrlMap : TUrlMap) : TOperation;
    Function List(project: string; AQuery : string  = '') : TUrlMapList;
    Function List(project: string; AQuery : TUrlMapslistOptions) : TUrlMapList;
    Function Patch(project: string; urlMap: string; aUrlMap : TUrlMap) : TOperation;
    Function Update(project: string; urlMap: string; aUrlMap : TUrlMap) : TOperation;
    Function Validate(project: string; urlMap: string; aUrlMapsValidateRequest : TUrlMapsValidateRequest) : TUrlMapsValidateResponse;
  end;
  
  
  { --------------------------------------------------------------------
    TVpnTunnelsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TVpnTunnelsResource, method AggregatedList
  
  TVpnTunnelsAggregatedListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  
  //Optional query Options for TVpnTunnelsResource, method List
  
  TVpnTunnelsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TVpnTunnelsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function AggregatedList(project: string; AQuery : string  = '') : TVpnTunnelAggregatedList;
    Function AggregatedList(project: string; AQuery : TVpnTunnelsaggregatedListOptions) : TVpnTunnelAggregatedList;
    Function Delete(project: string; region: string; vpnTunnel: string) : TOperation;
    Function Get(project: string; region: string; vpnTunnel: string) : TVpnTunnel;
    Function Insert(project: string; region: string; aVpnTunnel : TVpnTunnel) : TOperation;
    Function List(project: string; region: string; AQuery : string  = '') : TVpnTunnelList;
    Function List(project: string; region: string; AQuery : TVpnTunnelslistOptions) : TVpnTunnelList;
  end;
  
  
  { --------------------------------------------------------------------
    TZoneOperationsResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TZoneOperationsResource, method List
  
  TZoneOperationsListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TZoneOperationsResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Procedure Delete(operation: string; project: string; zone: string);
    Function Get(operation: string; project: string; zone: string) : TOperation;
    Function List(project: string; zone: string; AQuery : string  = '') : TOperationList;
    Function List(project: string; zone: string; AQuery : TZoneOperationslistOptions) : TOperationList;
  end;
  
  
  { --------------------------------------------------------------------
    TZonesResource
    --------------------------------------------------------------------}
  
  
  //Optional query Options for TZonesResource, method List
  
  TZonesListOptions = Record
    filter : String;
    maxResults : integer;
    pageToken : String;
  end;
  
  TZonesResource = Class(TGoogleResource)
  Public
    Class Function ResourceName : String; override;
    Class Function DefaultAPI : TGoogleAPIClass; override;
    Function Get(project: string; zone: string) : TZone;
    Function List(project: string; AQuery : string  = '') : TZoneList;
    Function List(project: string; AQuery : TZoneslistOptions) : TZoneList;
  end;
  
  
  { --------------------------------------------------------------------
    TComputeAPI
    --------------------------------------------------------------------}
  
  TComputeAPI = Class(TGoogleAPI)
  Private
    FAddressesInstance : TAddressesResource;
    FAutoscalersInstance : TAutoscalersResource;
    FBackendServicesInstance : TBackendServicesResource;
    FDiskTypesInstance : TDiskTypesResource;
    FDisksInstance : TDisksResource;
    FFirewallsInstance : TFirewallsResource;
    FForwardingRulesInstance : TForwardingRulesResource;
    FGlobalAddressesInstance : TGlobalAddressesResource;
    FGlobalForwardingRulesInstance : TGlobalForwardingRulesResource;
    FGlobalOperationsInstance : TGlobalOperationsResource;
    FHttpHealthChecksInstance : THttpHealthChecksResource;
    FHttpsHealthChecksInstance : THttpsHealthChecksResource;
    FImagesInstance : TImagesResource;
    FInstanceGroupManagersInstance : TInstanceGroupManagersResource;
    FInstanceGroupsInstance : TInstanceGroupsResource;
    FInstanceTemplatesInstance : TInstanceTemplatesResource;
    FInstancesInstance : TInstancesResource;
    FLicensesInstance : TLicensesResource;
    FMachineTypesInstance : TMachineTypesResource;
    FNetworksInstance : TNetworksResource;
    FProjectsInstance : TProjectsResource;
    FRegionOperationsInstance : TRegionOperationsResource;
    FRegionsInstance : TRegionsResource;
    FRoutesInstance : TRoutesResource;
    FSnapshotsInstance : TSnapshotsResource;
    FSslCertificatesInstance : TSslCertificatesResource;
    FSubnetworksInstance : TSubnetworksResource;
    FTargetHttpProxiesInstance : TTargetHttpProxiesResource;
    FTargetHttpsProxiesInstance : TTargetHttpsProxiesResource;
    FTargetInstancesInstance : TTargetInstancesResource;
    FTargetPoolsInstance : TTargetPoolsResource;
    FTargetVpnGatewaysInstance : TTargetVpnGatewaysResource;
    FUrlMapsInstance : TUrlMapsResource;
    FVpnTunnelsInstance : TVpnTunnelsResource;
    FZoneOperationsInstance : TZoneOperationsResource;
    FZonesInstance : TZonesResource;
    Function GetAddressesInstance : TAddressesResource;virtual;
    Function GetAutoscalersInstance : TAutoscalersResource;virtual;
    Function GetBackendServicesInstance : TBackendServicesResource;virtual;
    Function GetDiskTypesInstance : TDiskTypesResource;virtual;
    Function GetDisksInstance : TDisksResource;virtual;
    Function GetFirewallsInstance : TFirewallsResource;virtual;
    Function GetForwardingRulesInstance : TForwardingRulesResource;virtual;
    Function GetGlobalAddressesInstance : TGlobalAddressesResource;virtual;
    Function GetGlobalForwardingRulesInstance : TGlobalForwardingRulesResource;virtual;
    Function GetGlobalOperationsInstance : TGlobalOperationsResource;virtual;
    Function GetHttpHealthChecksInstance : THttpHealthChecksResource;virtual;
    Function GetHttpsHealthChecksInstance : THttpsHealthChecksResource;virtual;
    Function GetImagesInstance : TImagesResource;virtual;
    Function GetInstanceGroupManagersInstance : TInstanceGroupManagersResource;virtual;
    Function GetInstanceGroupsInstance : TInstanceGroupsResource;virtual;
    Function GetInstanceTemplatesInstance : TInstanceTemplatesResource;virtual;
    Function GetInstancesInstance : TInstancesResource;virtual;
    Function GetLicensesInstance : TLicensesResource;virtual;
    Function GetMachineTypesInstance : TMachineTypesResource;virtual;
    Function GetNetworksInstance : TNetworksResource;virtual;
    Function GetProjectsInstance : TProjectsResource;virtual;
    Function GetRegionOperationsInstance : TRegionOperationsResource;virtual;
    Function GetRegionsInstance : TRegionsResource;virtual;
    Function GetRoutesInstance : TRoutesResource;virtual;
    Function GetSnapshotsInstance : TSnapshotsResource;virtual;
    Function GetSslCertificatesInstance : TSslCertificatesResource;virtual;
    Function GetSubnetworksInstance : TSubnetworksResource;virtual;
    Function GetTargetHttpProxiesInstance : TTargetHttpProxiesResource;virtual;
    Function GetTargetHttpsProxiesInstance : TTargetHttpsProxiesResource;virtual;
    Function GetTargetInstancesInstance : TTargetInstancesResource;virtual;
    Function GetTargetPoolsInstance : TTargetPoolsResource;virtual;
    Function GetTargetVpnGatewaysInstance : TTargetVpnGatewaysResource;virtual;
    Function GetUrlMapsInstance : TUrlMapsResource;virtual;
    Function GetVpnTunnelsInstance : TVpnTunnelsResource;virtual;
    Function GetZoneOperationsInstance : TZoneOperationsResource;virtual;
    Function GetZonesInstance : TZonesResource;virtual;
  Public
    //Override class functions with API info
    Class Function APIName : String; override;
    Class Function APIVersion : String; override;
    Class Function APIRevision : String; override;
    Class Function APIID : String; override;
    Class Function APITitle : String; override;
    Class Function APIDescription : String; override;
    Class Function APIOwnerDomain : String; override;
    Class Function APIOwnerName : String; override;
    Class Function APIIcon16 : String; override;
    Class Function APIIcon32 : String; override;
    Class Function APIdocumentationLink : String; override;
    Class Function APIrootUrl : string; override;
    Class Function APIbasePath : string;override;
    Class Function APIbaseURL : String;override;
    Class Function APIProtocol : string;override;
    Class Function APIservicePath : string;override;
    Class Function APIbatchPath : String;override;
    Class Function APIAuthScopes : TScopeInfoArray;override;
    Class Function APINeedsAuth : Boolean;override;
    Class Procedure RegisterAPIResources; override;
    //Add create function for resources
    Function CreateAddressesResource(AOwner : TComponent) : TAddressesResource;virtual;overload;
    Function CreateAddressesResource : TAddressesResource;virtual;overload;
    Function CreateAutoscalersResource(AOwner : TComponent) : TAutoscalersResource;virtual;overload;
    Function CreateAutoscalersResource : TAutoscalersResource;virtual;overload;
    Function CreateBackendServicesResource(AOwner : TComponent) : TBackendServicesResource;virtual;overload;
    Function CreateBackendServicesResource : TBackendServicesResource;virtual;overload;
    Function CreateDiskTypesResource(AOwner : TComponent) : TDiskTypesResource;virtual;overload;
    Function CreateDiskTypesResource : TDiskTypesResource;virtual;overload;
    Function CreateDisksResource(AOwner : TComponent) : TDisksResource;virtual;overload;
    Function CreateDisksResource : TDisksResource;virtual;overload;
    Function CreateFirewallsResource(AOwner : TComponent) : TFirewallsResource;virtual;overload;
    Function CreateFirewallsResource : TFirewallsResource;virtual;overload;
    Function CreateForwardingRulesResource(AOwner : TComponent) : TForwardingRulesResource;virtual;overload;
    Function CreateForwardingRulesResource : TForwardingRulesResource;virtual;overload;
    Function CreateGlobalAddressesResource(AOwner : TComponent) : TGlobalAddressesResource;virtual;overload;
    Function CreateGlobalAddressesResource : TGlobalAddressesResource;virtual;overload;
    Function CreateGlobalForwardingRulesResource(AOwner : TComponent) : TGlobalForwardingRulesResource;virtual;overload;
    Function CreateGlobalForwardingRulesResource : TGlobalForwardingRulesResource;virtual;overload;
    Function CreateGlobalOperationsResource(AOwner : TComponent) : TGlobalOperationsResource;virtual;overload;
    Function CreateGlobalOperationsResource : TGlobalOperationsResource;virtual;overload;
    Function CreateHttpHealthChecksResource(AOwner : TComponent) : THttpHealthChecksResource;virtual;overload;
    Function CreateHttpHealthChecksResource : THttpHealthChecksResource;virtual;overload;
    Function CreateHttpsHealthChecksResource(AOwner : TComponent) : THttpsHealthChecksResource;virtual;overload;
    Function CreateHttpsHealthChecksResource : THttpsHealthChecksResource;virtual;overload;
    Function CreateImagesResource(AOwner : TComponent) : TImagesResource;virtual;overload;
    Function CreateImagesResource : TImagesResource;virtual;overload;
    Function CreateInstanceGroupManagersResource(AOwner : TComponent) : TInstanceGroupManagersResource;virtual;overload;
    Function CreateInstanceGroupManagersResource : TInstanceGroupManagersResource;virtual;overload;
    Function CreateInstanceGroupsResource(AOwner : TComponent) : TInstanceGroupsResource;virtual;overload;
    Function CreateInstanceGroupsResource : TInstanceGroupsResource;virtual;overload;
    Function CreateInstanceTemplatesResource(AOwner : TComponent) : TInstanceTemplatesResource;virtual;overload;
    Function CreateInstanceTemplatesResource : TInstanceTemplatesResource;virtual;overload;
    Function CreateInstancesResource(AOwner : TComponent) : TInstancesResource;virtual;overload;
    Function CreateInstancesResource : TInstancesResource;virtual;overload;
    Function CreateLicensesResource(AOwner : TComponent) : TLicensesResource;virtual;overload;
    Function CreateLicensesResource : TLicensesResource;virtual;overload;
    Function CreateMachineTypesResource(AOwner : TComponent) : TMachineTypesResource;virtual;overload;
    Function CreateMachineTypesResource : TMachineTypesResource;virtual;overload;
    Function CreateNetworksResource(AOwner : TComponent) : TNetworksResource;virtual;overload;
    Function CreateNetworksResource : TNetworksResource;virtual;overload;
    Function CreateProjectsResource(AOwner : TComponent) : TProjectsResource;virtual;overload;
    Function CreateProjectsResource : TProjectsResource;virtual;overload;
    Function CreateRegionOperationsResource(AOwner : TComponent) : TRegionOperationsResource;virtual;overload;
    Function CreateRegionOperationsResource : TRegionOperationsResource;virtual;overload;
    Function CreateRegionsResource(AOwner : TComponent) : TRegionsResource;virtual;overload;
    Function CreateRegionsResource : TRegionsResource;virtual;overload;
    Function CreateRoutesResource(AOwner : TComponent) : TRoutesResource;virtual;overload;
    Function CreateRoutesResource : TRoutesResource;virtual;overload;
    Function CreateSnapshotsResource(AOwner : TComponent) : TSnapshotsResource;virtual;overload;
    Function CreateSnapshotsResource : TSnapshotsResource;virtual;overload;
    Function CreateSslCertificatesResource(AOwner : TComponent) : TSslCertificatesResource;virtual;overload;
    Function CreateSslCertificatesResource : TSslCertificatesResource;virtual;overload;
    Function CreateSubnetworksResource(AOwner : TComponent) : TSubnetworksResource;virtual;overload;
    Function CreateSubnetworksResource : TSubnetworksResource;virtual;overload;
    Function CreateTargetHttpProxiesResource(AOwner : TComponent) : TTargetHttpProxiesResource;virtual;overload;
    Function CreateTargetHttpProxiesResource : TTargetHttpProxiesResource;virtual;overload;
    Function CreateTargetHttpsProxiesResource(AOwner : TComponent) : TTargetHttpsProxiesResource;virtual;overload;
    Function CreateTargetHttpsProxiesResource : TTargetHttpsProxiesResource;virtual;overload;
    Function CreateTargetInstancesResource(AOwner : TComponent) : TTargetInstancesResource;virtual;overload;
    Function CreateTargetInstancesResource : TTargetInstancesResource;virtual;overload;
    Function CreateTargetPoolsResource(AOwner : TComponent) : TTargetPoolsResource;virtual;overload;
    Function CreateTargetPoolsResource : TTargetPoolsResource;virtual;overload;
    Function CreateTargetVpnGatewaysResource(AOwner : TComponent) : TTargetVpnGatewaysResource;virtual;overload;
    Function CreateTargetVpnGatewaysResource : TTargetVpnGatewaysResource;virtual;overload;
    Function CreateUrlMapsResource(AOwner : TComponent) : TUrlMapsResource;virtual;overload;
    Function CreateUrlMapsResource : TUrlMapsResource;virtual;overload;
    Function CreateVpnTunnelsResource(AOwner : TComponent) : TVpnTunnelsResource;virtual;overload;
    Function CreateVpnTunnelsResource : TVpnTunnelsResource;virtual;overload;
    Function CreateZoneOperationsResource(AOwner : TComponent) : TZoneOperationsResource;virtual;overload;
    Function CreateZoneOperationsResource : TZoneOperationsResource;virtual;overload;
    Function CreateZonesResource(AOwner : TComponent) : TZonesResource;virtual;overload;
    Function CreateZonesResource : TZonesResource;virtual;overload;
    //Add default on-demand instances for resources
    Property AddressesResource : TAddressesResource Read GetAddressesInstance;
    Property AutoscalersResource : TAutoscalersResource Read GetAutoscalersInstance;
    Property BackendServicesResource : TBackendServicesResource Read GetBackendServicesInstance;
    Property DiskTypesResource : TDiskTypesResource Read GetDiskTypesInstance;
    Property DisksResource : TDisksResource Read GetDisksInstance;
    Property FirewallsResource : TFirewallsResource Read GetFirewallsInstance;
    Property ForwardingRulesResource : TForwardingRulesResource Read GetForwardingRulesInstance;
    Property GlobalAddressesResource : TGlobalAddressesResource Read GetGlobalAddressesInstance;
    Property GlobalForwardingRulesResource : TGlobalForwardingRulesResource Read GetGlobalForwardingRulesInstance;
    Property GlobalOperationsResource : TGlobalOperationsResource Read GetGlobalOperationsInstance;
    Property HttpHealthChecksResource : THttpHealthChecksResource Read GetHttpHealthChecksInstance;
    Property HttpsHealthChecksResource : THttpsHealthChecksResource Read GetHttpsHealthChecksInstance;
    Property ImagesResource : TImagesResource Read GetImagesInstance;
    Property InstanceGroupManagersResource : TInstanceGroupManagersResource Read GetInstanceGroupManagersInstance;
    Property InstanceGroupsResource : TInstanceGroupsResource Read GetInstanceGroupsInstance;
    Property InstanceTemplatesResource : TInstanceTemplatesResource Read GetInstanceTemplatesInstance;
    Property InstancesResource : TInstancesResource Read GetInstancesInstance;
    Property LicensesResource : TLicensesResource Read GetLicensesInstance;
    Property MachineTypesResource : TMachineTypesResource Read GetMachineTypesInstance;
    Property NetworksResource : TNetworksResource Read GetNetworksInstance;
    Property ProjectsResource : TProjectsResource Read GetProjectsInstance;
    Property RegionOperationsResource : TRegionOperationsResource Read GetRegionOperationsInstance;
    Property RegionsResource : TRegionsResource Read GetRegionsInstance;
    Property RoutesResource : TRoutesResource Read GetRoutesInstance;
    Property SnapshotsResource : TSnapshotsResource Read GetSnapshotsInstance;
    Property SslCertificatesResource : TSslCertificatesResource Read GetSslCertificatesInstance;
    Property SubnetworksResource : TSubnetworksResource Read GetSubnetworksInstance;
    Property TargetHttpProxiesResource : TTargetHttpProxiesResource Read GetTargetHttpProxiesInstance;
    Property TargetHttpsProxiesResource : TTargetHttpsProxiesResource Read GetTargetHttpsProxiesInstance;
    Property TargetInstancesResource : TTargetInstancesResource Read GetTargetInstancesInstance;
    Property TargetPoolsResource : TTargetPoolsResource Read GetTargetPoolsInstance;
    Property TargetVpnGatewaysResource : TTargetVpnGatewaysResource Read GetTargetVpnGatewaysInstance;
    Property UrlMapsResource : TUrlMapsResource Read GetUrlMapsInstance;
    Property VpnTunnelsResource : TVpnTunnelsResource Read GetVpnTunnelsInstance;
    Property ZoneOperationsResource : TZoneOperationsResource Read GetZoneOperationsInstance;
    Property ZonesResource : TZonesResource Read GetZonesInstance;
  end;

implementation


{ --------------------------------------------------------------------
  TAccessConfig
  --------------------------------------------------------------------}


Procedure TAccessConfig.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccessConfig.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccessConfig.SetnatIP(AIndex : Integer; const AValue : String); 

begin
  If (FnatIP=AValue) then exit;
  FnatIP:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAccessConfig.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAccessConfig.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;




{ --------------------------------------------------------------------
  TAddress
  --------------------------------------------------------------------}


Procedure TAddress.Setaddress(AIndex : Integer; const AValue : String); 

begin
  If (Faddress=AValue) then exit;
  Faddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddress.Setusers(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fusers=AValue) then exit;
  Fusers:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAddress.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'users' : SetLength(Fusers,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAddressAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TAddressAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TAddressAggregatedList
  --------------------------------------------------------------------}


Procedure TAddressAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressAggregatedList.Setitems(AIndex : Integer; const AValue : TAddressAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAddressList
  --------------------------------------------------------------------}


Procedure TAddressList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressList.Setitems(AIndex : Integer; const AValue : TAddressListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAddressList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAddressesScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TAddressesScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressesScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAddressesScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TAddressesScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressesScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TAddressesScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressesScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAddressesScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAddressesScopedList
  --------------------------------------------------------------------}


Procedure TAddressesScopedList.Setaddresses(AIndex : Integer; const AValue : TAddressesScopedListTypeaddressesArray); 

begin
  If (Faddresses=AValue) then exit;
  Faddresses:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAddressesScopedList.Setwarning(AIndex : Integer; const AValue : TAddressesScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAddressesScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'addresses' : SetLength(Faddresses,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAttachedDisk
  --------------------------------------------------------------------}


Procedure TAttachedDisk.SetautoDelete(AIndex : Integer; const AValue : boolean); 

begin
  If (FautoDelete=AValue) then exit;
  FautoDelete:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Setboot(AIndex : Integer; const AValue : boolean); 

begin
  If (Fboot=AValue) then exit;
  Fboot:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.SetdeviceName(AIndex : Integer; const AValue : String); 

begin
  If (FdeviceName=AValue) then exit;
  FdeviceName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Setindex(AIndex : Integer; const AValue : integer); 

begin
  If (Findex=AValue) then exit;
  Findex:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.SetinitializeParams(AIndex : Integer; const AValue : TAttachedDiskInitializeParams); 

begin
  If (FinitializeParams=AValue) then exit;
  FinitializeParams:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Set_interface(AIndex : Integer; const AValue : String); 

begin
  If (F_interface=AValue) then exit;
  F_interface:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Setlicenses(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Flicenses=AValue) then exit;
  Flicenses:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Setmode(AIndex : Integer; const AValue : String); 

begin
  If (Fmode=AValue) then exit;
  Fmode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Setsource(AIndex : Integer; const AValue : String); 

begin
  If (Fsource=AValue) then exit;
  Fsource:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDisk.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TAttachedDisk.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_interface' : Result:='interface';
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;

//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAttachedDisk.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'licenses' : SetLength(Flicenses,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAttachedDiskInitializeParams
  --------------------------------------------------------------------}


Procedure TAttachedDiskInitializeParams.SetdiskName(AIndex : Integer; const AValue : String); 

begin
  If (FdiskName=AValue) then exit;
  FdiskName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDiskInitializeParams.SetdiskSizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FdiskSizeGb=AValue) then exit;
  FdiskSizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDiskInitializeParams.SetdiskType(AIndex : Integer; const AValue : String); 

begin
  If (FdiskType=AValue) then exit;
  FdiskType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAttachedDiskInitializeParams.SetsourceImage(AIndex : Integer; const AValue : String); 

begin
  If (FsourceImage=AValue) then exit;
  FsourceImage:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAutoscaler
  --------------------------------------------------------------------}


Procedure TAutoscaler.SetautoscalingPolicy(AIndex : Integer; const AValue : TAutoscalingPolicy); 

begin
  If (FautoscalingPolicy=AValue) then exit;
  FautoscalingPolicy:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.Settarget(AIndex : Integer; const AValue : String); 

begin
  If (Ftarget=AValue) then exit;
  Ftarget:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscaler.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAutoscalerAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TAutoscalerAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TAutoscalerAggregatedList
  --------------------------------------------------------------------}


Procedure TAutoscalerAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerAggregatedList.Setitems(AIndex : Integer; const AValue : TAutoscalerAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAutoscalerList
  --------------------------------------------------------------------}


Procedure TAutoscalerList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerList.Setitems(AIndex : Integer; const AValue : TAutoscalerListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalerList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAutoscalerList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAutoscalersScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TAutoscalersScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalersScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAutoscalersScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TAutoscalersScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalersScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TAutoscalersScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalersScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAutoscalersScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAutoscalersScopedList
  --------------------------------------------------------------------}


Procedure TAutoscalersScopedList.Setautoscalers(AIndex : Integer; const AValue : TAutoscalersScopedListTypeautoscalersArray); 

begin
  If (Fautoscalers=AValue) then exit;
  Fautoscalers:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalersScopedList.Setwarning(AIndex : Integer; const AValue : TAutoscalersScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAutoscalersScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'autoscalers' : SetLength(Fautoscalers,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAutoscalingPolicy
  --------------------------------------------------------------------}


Procedure TAutoscalingPolicy.SetcoolDownPeriodSec(AIndex : Integer; const AValue : integer); 

begin
  If (FcoolDownPeriodSec=AValue) then exit;
  FcoolDownPeriodSec:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalingPolicy.SetcpuUtilization(AIndex : Integer; const AValue : TAutoscalingPolicyCpuUtilization); 

begin
  If (FcpuUtilization=AValue) then exit;
  FcpuUtilization:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalingPolicy.SetcustomMetricUtilizations(AIndex : Integer; const AValue : TAutoscalingPolicyTypecustomMetricUtilizationsArray); 

begin
  If (FcustomMetricUtilizations=AValue) then exit;
  FcustomMetricUtilizations:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalingPolicy.SetloadBalancingUtilization(AIndex : Integer; const AValue : TAutoscalingPolicyLoadBalancingUtilization); 

begin
  If (FloadBalancingUtilization=AValue) then exit;
  FloadBalancingUtilization:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalingPolicy.SetmaxNumReplicas(AIndex : Integer; const AValue : integer); 

begin
  If (FmaxNumReplicas=AValue) then exit;
  FmaxNumReplicas:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalingPolicy.SetminNumReplicas(AIndex : Integer; const AValue : integer); 

begin
  If (FminNumReplicas=AValue) then exit;
  FminNumReplicas:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TAutoscalingPolicy.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'custommetricutilizations' : SetLength(FcustomMetricUtilizations,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAutoscalingPolicyCpuUtilization
  --------------------------------------------------------------------}


Procedure TAutoscalingPolicyCpuUtilization.SetutilizationTarget(AIndex : Integer; const AValue : double); 

begin
  If (FutilizationTarget=AValue) then exit;
  FutilizationTarget:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAutoscalingPolicyCustomMetricUtilization
  --------------------------------------------------------------------}


Procedure TAutoscalingPolicyCustomMetricUtilization.Setmetric(AIndex : Integer; const AValue : String); 

begin
  If (Fmetric=AValue) then exit;
  Fmetric:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalingPolicyCustomMetricUtilization.SetutilizationTarget(AIndex : Integer; const AValue : double); 

begin
  If (FutilizationTarget=AValue) then exit;
  FutilizationTarget:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TAutoscalingPolicyCustomMetricUtilization.SetutilizationTargetType(AIndex : Integer; const AValue : String); 

begin
  If (FutilizationTargetType=AValue) then exit;
  FutilizationTargetType:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TAutoscalingPolicyLoadBalancingUtilization
  --------------------------------------------------------------------}


Procedure TAutoscalingPolicyLoadBalancingUtilization.SetutilizationTarget(AIndex : Integer; const AValue : double); 

begin
  If (FutilizationTarget=AValue) then exit;
  FutilizationTarget:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TBackend
  --------------------------------------------------------------------}


Procedure TBackend.SetbalancingMode(AIndex : Integer; const AValue : String); 

begin
  If (FbalancingMode=AValue) then exit;
  FbalancingMode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackend.SetcapacityScaler(AIndex : Integer; const AValue : integer); 

begin
  If (FcapacityScaler=AValue) then exit;
  FcapacityScaler:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackend.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackend.Setgroup(AIndex : Integer; const AValue : String); 

begin
  If (Fgroup=AValue) then exit;
  Fgroup:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackend.SetmaxRate(AIndex : Integer; const AValue : integer); 

begin
  If (FmaxRate=AValue) then exit;
  FmaxRate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackend.SetmaxRatePerInstance(AIndex : Integer; const AValue : integer); 

begin
  If (FmaxRatePerInstance=AValue) then exit;
  FmaxRatePerInstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackend.SetmaxUtilization(AIndex : Integer; const AValue : integer); 

begin
  If (FmaxUtilization=AValue) then exit;
  FmaxUtilization:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TBackendService
  --------------------------------------------------------------------}


Procedure TBackendService.Setbackends(AIndex : Integer; const AValue : TBackendServiceTypebackendsArray); 

begin
  If (Fbackends=AValue) then exit;
  Fbackends:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.SethealthChecks(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FhealthChecks=AValue) then exit;
  FhealthChecks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setport(AIndex : Integer; const AValue : integer); 

begin
  If (Fport=AValue) then exit;
  Fport:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.SetportName(AIndex : Integer; const AValue : String); 

begin
  If (FportName=AValue) then exit;
  FportName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setprotocol(AIndex : Integer; const AValue : String); 

begin
  If (Fprotocol=AValue) then exit;
  Fprotocol:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendService.SettimeoutSec(AIndex : Integer; const AValue : integer); 

begin
  If (FtimeoutSec=AValue) then exit;
  FtimeoutSec:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TBackendService.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'backends' : SetLength(Fbackends,ALength);
  'healthchecks' : SetLength(FhealthChecks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TBackendServiceGroupHealth
  --------------------------------------------------------------------}


Procedure TBackendServiceGroupHealth.SethealthStatus(AIndex : Integer; const AValue : TBackendServiceGroupHealthTypehealthStatusArray); 

begin
  If (FhealthStatus=AValue) then exit;
  FhealthStatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendServiceGroupHealth.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TBackendServiceGroupHealth.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'healthstatus' : SetLength(FhealthStatus,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TBackendServiceList
  --------------------------------------------------------------------}


Procedure TBackendServiceList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendServiceList.Setitems(AIndex : Integer; const AValue : TBackendServiceListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendServiceList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendServiceList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TBackendServiceList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TBackendServiceList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDeprecationStatus
  --------------------------------------------------------------------}


Procedure TDeprecationStatus.Setdeleted(AIndex : Integer; const AValue : String); 

begin
  If (Fdeleted=AValue) then exit;
  Fdeleted:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDeprecationStatus.Setdeprecated(AIndex : Integer; const AValue : String); 

begin
  If (Fdeprecated=AValue) then exit;
  Fdeprecated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDeprecationStatus.Setobsolete(AIndex : Integer; const AValue : String); 

begin
  If (Fobsolete=AValue) then exit;
  Fobsolete:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDeprecationStatus.Setreplacement(AIndex : Integer; const AValue : String); 

begin
  If (Freplacement=AValue) then exit;
  Freplacement:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDeprecationStatus.Setstate(AIndex : Integer; const AValue : String); 

begin
  If (Fstate=AValue) then exit;
  Fstate:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDisk
  --------------------------------------------------------------------}


Procedure TDisk.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetlastAttachTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FlastAttachTimestamp=AValue) then exit;
  FlastAttachTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetlastDetachTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FlastDetachTimestamp=AValue) then exit;
  FlastDetachTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setlicenses(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Flicenses=AValue) then exit;
  Flicenses:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setoptions(AIndex : Integer; const AValue : String); 

begin
  If (Foptions=AValue) then exit;
  Foptions:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetsizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FsizeGb=AValue) then exit;
  FsizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetsourceImage(AIndex : Integer; const AValue : String); 

begin
  If (FsourceImage=AValue) then exit;
  FsourceImage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetsourceImageId(AIndex : Integer; const AValue : String); 

begin
  If (FsourceImageId=AValue) then exit;
  FsourceImageId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetsourceSnapshot(AIndex : Integer; const AValue : String); 

begin
  If (FsourceSnapshot=AValue) then exit;
  FsourceSnapshot:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.SetsourceSnapshotId(AIndex : Integer; const AValue : String); 

begin
  If (FsourceSnapshotId=AValue) then exit;
  FsourceSnapshotId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Set_type(AIndex : Integer; const AValue : String); 

begin
  If (F_type=AValue) then exit;
  F_type:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setusers(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fusers=AValue) then exit;
  Fusers:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisk.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;



Class Function TDisk.ExportPropertyName(Const AName : String) :String;

begin
  Case AName of
  '_type' : Result:='type';
  else
    Result:=Inherited ExportPropertyName(AName);
  end;
end;

//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDisk.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'licenses' : SetLength(Flicenses,ALength);
  'users' : SetLength(Fusers,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDiskAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TDiskAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TDiskAggregatedList
  --------------------------------------------------------------------}


Procedure TDiskAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskAggregatedList.Setitems(AIndex : Integer; const AValue : TDiskAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDiskList
  --------------------------------------------------------------------}


Procedure TDiskList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskList.Setitems(AIndex : Integer; const AValue : TDiskListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDiskList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDiskMoveRequest
  --------------------------------------------------------------------}


Procedure TDiskMoveRequest.SetdestinationZone(AIndex : Integer; const AValue : String); 

begin
  If (FdestinationZone=AValue) then exit;
  FdestinationZone:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskMoveRequest.SettargetDisk(AIndex : Integer; const AValue : String); 

begin
  If (FtargetDisk=AValue) then exit;
  FtargetDisk:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDiskType
  --------------------------------------------------------------------}


Procedure TDiskType.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.SetdefaultDiskSizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FdefaultDiskSizeGb=AValue) then exit;
  FdefaultDiskSizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); 

begin
  If (Fdeprecated=AValue) then exit;
  Fdeprecated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.SetvalidDiskSize(AIndex : Integer; const AValue : String); 

begin
  If (FvalidDiskSize=AValue) then exit;
  FvalidDiskSize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskType.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDiskTypeAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TDiskTypeAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TDiskTypeAggregatedList
  --------------------------------------------------------------------}


Procedure TDiskTypeAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeAggregatedList.Setitems(AIndex : Integer; const AValue : TDiskTypeAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDiskTypeList
  --------------------------------------------------------------------}


Procedure TDiskTypeList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeList.Setitems(AIndex : Integer; const AValue : TDiskTypeListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypeList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDiskTypeList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDiskTypesScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TDiskTypesScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypesScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDiskTypesScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TDiskTypesScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypesScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TDiskTypesScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypesScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDiskTypesScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDiskTypesScopedList
  --------------------------------------------------------------------}


Procedure TDiskTypesScopedList.SetdiskTypes(AIndex : Integer; const AValue : TDiskTypesScopedListTypediskTypesArray); 

begin
  If (FdiskTypes=AValue) then exit;
  FdiskTypes:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDiskTypesScopedList.Setwarning(AIndex : Integer; const AValue : TDiskTypesScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDiskTypesScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'disktypes' : SetLength(FdiskTypes,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDisksResizeRequest
  --------------------------------------------------------------------}


Procedure TDisksResizeRequest.SetsizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FsizeGb=AValue) then exit;
  FsizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDisksScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TDisksScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisksScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TDisksScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TDisksScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisksScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TDisksScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisksScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDisksScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TDisksScopedList
  --------------------------------------------------------------------}


Procedure TDisksScopedList.Setdisks(AIndex : Integer; const AValue : TDisksScopedListTypedisksArray); 

begin
  If (Fdisks=AValue) then exit;
  Fdisks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TDisksScopedList.Setwarning(AIndex : Integer; const AValue : TDisksScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TDisksScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'disks' : SetLength(Fdisks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFirewallTypeallowedItem
  --------------------------------------------------------------------}


Procedure TFirewallTypeallowedItem.SetIPProtocol(AIndex : Integer; const AValue : String); 

begin
  If (FIPProtocol=AValue) then exit;
  FIPProtocol:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewallTypeallowedItem.Setports(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fports=AValue) then exit;
  Fports:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFirewallTypeallowedItem.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'ports' : SetLength(Fports,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFirewall
  --------------------------------------------------------------------}


Procedure TFirewall.Setallowed(AIndex : Integer; const AValue : TFirewallTypeallowedArray); 

begin
  If (Fallowed=AValue) then exit;
  Fallowed:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.Setnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fnetwork=AValue) then exit;
  Fnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.SetsourceRanges(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FsourceRanges=AValue) then exit;
  FsourceRanges:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.SetsourceTags(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FsourceTags=AValue) then exit;
  FsourceTags:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewall.SettargetTags(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FtargetTags=AValue) then exit;
  FtargetTags:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFirewall.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'allowed' : SetLength(Fallowed,ALength);
  'sourceranges' : SetLength(FsourceRanges,ALength);
  'sourcetags' : SetLength(FsourceTags,ALength);
  'targettags' : SetLength(FtargetTags,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TFirewallList
  --------------------------------------------------------------------}


Procedure TFirewallList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewallList.Setitems(AIndex : Integer; const AValue : TFirewallListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewallList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewallList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TFirewallList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TFirewallList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TForwardingRule
  --------------------------------------------------------------------}


Procedure TForwardingRule.SetIPAddress(AIndex : Integer; const AValue : String); 

begin
  If (FIPAddress=AValue) then exit;
  FIPAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.SetIPProtocol(AIndex : Integer; const AValue : String); 

begin
  If (FIPProtocol=AValue) then exit;
  FIPProtocol:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.SetportRange(AIndex : Integer; const AValue : String); 

begin
  If (FportRange=AValue) then exit;
  FportRange:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRule.Settarget(AIndex : Integer; const AValue : String); 

begin
  If (Ftarget=AValue) then exit;
  Ftarget:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TForwardingRuleAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TForwardingRuleAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TForwardingRuleAggregatedList
  --------------------------------------------------------------------}


Procedure TForwardingRuleAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleAggregatedList.Setitems(AIndex : Integer; const AValue : TForwardingRuleAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TForwardingRuleList
  --------------------------------------------------------------------}


Procedure TForwardingRuleList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleList.Setitems(AIndex : Integer; const AValue : TForwardingRuleListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRuleList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TForwardingRuleList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TForwardingRulesScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TForwardingRulesScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRulesScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TForwardingRulesScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TForwardingRulesScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRulesScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TForwardingRulesScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRulesScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TForwardingRulesScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TForwardingRulesScopedList
  --------------------------------------------------------------------}


Procedure TForwardingRulesScopedList.SetforwardingRules(AIndex : Integer; const AValue : TForwardingRulesScopedListTypeforwardingRulesArray); 

begin
  If (FforwardingRules=AValue) then exit;
  FforwardingRules:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TForwardingRulesScopedList.Setwarning(AIndex : Integer; const AValue : TForwardingRulesScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TForwardingRulesScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'forwardingrules' : SetLength(FforwardingRules,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  THealthCheckReference
  --------------------------------------------------------------------}


Procedure THealthCheckReference.SethealthCheck(AIndex : Integer; const AValue : String); 

begin
  If (FhealthCheck=AValue) then exit;
  FhealthCheck:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  THealthStatus
  --------------------------------------------------------------------}


Procedure THealthStatus.SethealthState(AIndex : Integer; const AValue : String); 

begin
  If (FhealthState=AValue) then exit;
  FhealthState:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THealthStatus.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THealthStatus.SetipAddress(AIndex : Integer; const AValue : String); 

begin
  If (FipAddress=AValue) then exit;
  FipAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THealthStatus.Setport(AIndex : Integer; const AValue : integer); 

begin
  If (Fport=AValue) then exit;
  Fport:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  THostRule
  --------------------------------------------------------------------}


Procedure THostRule.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THostRule.Sethosts(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fhosts=AValue) then exit;
  Fhosts:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THostRule.SetpathMatcher(AIndex : Integer; const AValue : String); 

begin
  If (FpathMatcher=AValue) then exit;
  FpathMatcher:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure THostRule.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'hosts' : SetLength(Fhosts,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  THttpHealthCheck
  --------------------------------------------------------------------}


Procedure THttpHealthCheck.SetcheckIntervalSec(AIndex : Integer; const AValue : integer); 

begin
  If (FcheckIntervalSec=AValue) then exit;
  FcheckIntervalSec:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.SethealthyThreshold(AIndex : Integer; const AValue : integer); 

begin
  If (FhealthyThreshold=AValue) then exit;
  FhealthyThreshold:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.Sethost(AIndex : Integer; const AValue : String); 

begin
  If (Fhost=AValue) then exit;
  Fhost:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.Setport(AIndex : Integer; const AValue : integer); 

begin
  If (Fport=AValue) then exit;
  Fport:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.SetrequestPath(AIndex : Integer; const AValue : String); 

begin
  If (FrequestPath=AValue) then exit;
  FrequestPath:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.SettimeoutSec(AIndex : Integer; const AValue : integer); 

begin
  If (FtimeoutSec=AValue) then exit;
  FtimeoutSec:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheck.SetunhealthyThreshold(AIndex : Integer; const AValue : integer); 

begin
  If (FunhealthyThreshold=AValue) then exit;
  FunhealthyThreshold:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  THttpHealthCheckList
  --------------------------------------------------------------------}


Procedure THttpHealthCheckList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheckList.Setitems(AIndex : Integer; const AValue : THttpHealthCheckListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheckList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheckList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpHealthCheckList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure THttpHealthCheckList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  THttpsHealthCheck
  --------------------------------------------------------------------}


Procedure THttpsHealthCheck.SetcheckIntervalSec(AIndex : Integer; const AValue : integer); 

begin
  If (FcheckIntervalSec=AValue) then exit;
  FcheckIntervalSec:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.SethealthyThreshold(AIndex : Integer; const AValue : integer); 

begin
  If (FhealthyThreshold=AValue) then exit;
  FhealthyThreshold:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.Sethost(AIndex : Integer; const AValue : String); 

begin
  If (Fhost=AValue) then exit;
  Fhost:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.Setport(AIndex : Integer; const AValue : integer); 

begin
  If (Fport=AValue) then exit;
  Fport:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.SetrequestPath(AIndex : Integer; const AValue : String); 

begin
  If (FrequestPath=AValue) then exit;
  FrequestPath:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.SettimeoutSec(AIndex : Integer; const AValue : integer); 

begin
  If (FtimeoutSec=AValue) then exit;
  FtimeoutSec:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheck.SetunhealthyThreshold(AIndex : Integer; const AValue : integer); 

begin
  If (FunhealthyThreshold=AValue) then exit;
  FunhealthyThreshold:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  THttpsHealthCheckList
  --------------------------------------------------------------------}


Procedure THttpsHealthCheckList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheckList.Setitems(AIndex : Integer; const AValue : THttpsHealthCheckListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheckList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheckList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure THttpsHealthCheckList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure THttpsHealthCheckList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TImageTyperawDisk
  --------------------------------------------------------------------}


Procedure TImageTyperawDisk.SetcontainerType(AIndex : Integer; const AValue : String); 

begin
  If (FcontainerType=AValue) then exit;
  FcontainerType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageTyperawDisk.Setsha1Checksum(AIndex : Integer; const AValue : String); 

begin
  If (Fsha1Checksum=AValue) then exit;
  Fsha1Checksum:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageTyperawDisk.Setsource(AIndex : Integer; const AValue : String); 

begin
  If (Fsource=AValue) then exit;
  Fsource:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TImage
  --------------------------------------------------------------------}


Procedure TImage.SetarchiveSizeBytes(AIndex : Integer; const AValue : String); 

begin
  If (FarchiveSizeBytes=AValue) then exit;
  FarchiveSizeBytes:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); 

begin
  If (Fdeprecated=AValue) then exit;
  Fdeprecated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.SetdiskSizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FdiskSizeGb=AValue) then exit;
  FdiskSizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setfamily(AIndex : Integer; const AValue : String); 

begin
  If (Ffamily=AValue) then exit;
  Ffamily:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setlicenses(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Flicenses=AValue) then exit;
  Flicenses:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.SetrawDisk(AIndex : Integer; const AValue : TImageTyperawDisk); 

begin
  If (FrawDisk=AValue) then exit;
  FrawDisk:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.SetsourceDisk(AIndex : Integer; const AValue : String); 

begin
  If (FsourceDisk=AValue) then exit;
  FsourceDisk:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.SetsourceDiskId(AIndex : Integer; const AValue : String); 

begin
  If (FsourceDiskId=AValue) then exit;
  FsourceDiskId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.SetsourceType(AIndex : Integer; const AValue : String); 

begin
  If (FsourceType=AValue) then exit;
  FsourceType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImage.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TImage.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'licenses' : SetLength(Flicenses,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TImageList
  --------------------------------------------------------------------}


Procedure TImageList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageList.Setitems(AIndex : Integer; const AValue : TImageListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TImageList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TImageList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstance
  --------------------------------------------------------------------}


Procedure TInstance.SetcanIpForward(AIndex : Integer; const AValue : boolean); 

begin
  If (FcanIpForward=AValue) then exit;
  FcanIpForward:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.SetcpuPlatform(AIndex : Integer; const AValue : String); 

begin
  If (FcpuPlatform=AValue) then exit;
  FcpuPlatform:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setdisks(AIndex : Integer; const AValue : TInstanceTypedisksArray); 

begin
  If (Fdisks=AValue) then exit;
  Fdisks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.SetmachineType(AIndex : Integer; const AValue : String); 

begin
  If (FmachineType=AValue) then exit;
  FmachineType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setmetadata(AIndex : Integer; const AValue : TMetadata); 

begin
  If (Fmetadata=AValue) then exit;
  Fmetadata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.SetnetworkInterfaces(AIndex : Integer; const AValue : TInstanceTypenetworkInterfacesArray); 

begin
  If (FnetworkInterfaces=AValue) then exit;
  FnetworkInterfaces:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setscheduling(AIndex : Integer; const AValue : TScheduling); 

begin
  If (Fscheduling=AValue) then exit;
  Fscheduling:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.SetserviceAccounts(AIndex : Integer; const AValue : TInstanceTypeserviceAccountsArray); 

begin
  If (FserviceAccounts=AValue) then exit;
  FserviceAccounts:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.SetstatusMessage(AIndex : Integer; const AValue : String); 

begin
  If (FstatusMessage=AValue) then exit;
  FstatusMessage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Settags(AIndex : Integer; const AValue : TTags); 

begin
  If (Ftags=AValue) then exit;
  Ftags:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstance.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstance.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'disks' : SetLength(Fdisks,ALength);
  'networkinterfaces' : SetLength(FnetworkInterfaces,ALength);
  'serviceaccounts' : SetLength(FserviceAccounts,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TInstanceAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TInstanceAggregatedList
  --------------------------------------------------------------------}


Procedure TInstanceAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceAggregatedList.Setitems(AIndex : Integer; const AValue : TInstanceAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroup
  --------------------------------------------------------------------}


Procedure TInstanceGroup.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.SetnamedPorts(AIndex : Integer; const AValue : TInstanceGroupTypenamedPortsArray); 

begin
  If (FnamedPorts=AValue) then exit;
  FnamedPorts:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fnetwork=AValue) then exit;
  Fnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setsize(AIndex : Integer; const AValue : integer); 

begin
  If (Fsize=AValue) then exit;
  Fsize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setsubnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fsubnetwork=AValue) then exit;
  Fsubnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroup.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroup.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'namedports' : SetLength(FnamedPorts,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TInstanceGroupAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TInstanceGroupAggregatedList
  --------------------------------------------------------------------}


Procedure TInstanceGroupAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupAggregatedList.Setitems(AIndex : Integer; const AValue : TInstanceGroupAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroupList
  --------------------------------------------------------------------}


Procedure TInstanceGroupList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupList.Setitems(AIndex : Integer; const AValue : TInstanceGroupListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManager
  --------------------------------------------------------------------}


Procedure TInstanceGroupManager.SetbaseInstanceName(AIndex : Integer; const AValue : String); 

begin
  If (FbaseInstanceName=AValue) then exit;
  FbaseInstanceName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SetcurrentActions(AIndex : Integer; const AValue : TInstanceGroupManagerActionsSummary); 

begin
  If (FcurrentActions=AValue) then exit;
  FcurrentActions:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SetinstanceGroup(AIndex : Integer; const AValue : String); 

begin
  If (FinstanceGroup=AValue) then exit;
  FinstanceGroup:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SetinstanceTemplate(AIndex : Integer; const AValue : String); 

begin
  If (FinstanceTemplate=AValue) then exit;
  FinstanceTemplate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SetnamedPorts(AIndex : Integer; const AValue : TInstanceGroupManagerTypenamedPortsArray); 

begin
  If (FnamedPorts=AValue) then exit;
  FnamedPorts:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SettargetPools(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FtargetPools=AValue) then exit;
  FtargetPools:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.SettargetSize(AIndex : Integer; const AValue : integer); 

begin
  If (FtargetSize=AValue) then exit;
  FtargetSize:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManager.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManager.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'namedports' : SetLength(FnamedPorts,ALength);
  'targetpools' : SetLength(FtargetPools,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagerActionsSummary
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagerActionsSummary.Setabandoning(AIndex : Integer; const AValue : integer); 

begin
  If (Fabandoning=AValue) then exit;
  Fabandoning:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerActionsSummary.Setcreating(AIndex : Integer; const AValue : integer); 

begin
  If (Fcreating=AValue) then exit;
  Fcreating:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerActionsSummary.Setdeleting(AIndex : Integer; const AValue : integer); 

begin
  If (Fdeleting=AValue) then exit;
  Fdeleting:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerActionsSummary.Setnone(AIndex : Integer; const AValue : integer); 

begin
  If (Fnone=AValue) then exit;
  Fnone:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerActionsSummary.Setrecreating(AIndex : Integer; const AValue : integer); 

begin
  If (Frecreating=AValue) then exit;
  Frecreating:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerActionsSummary.Setrefreshing(AIndex : Integer; const AValue : integer); 

begin
  If (Frefreshing=AValue) then exit;
  Frefreshing:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerActionsSummary.Setrestarting(AIndex : Integer; const AValue : integer); 

begin
  If (Frestarting=AValue) then exit;
  Frestarting:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroupManagerAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TInstanceGroupManagerAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TInstanceGroupManagerAggregatedList
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagerAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerAggregatedList.Setitems(AIndex : Integer; const AValue : TInstanceGroupManagerAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroupManagerList
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagerList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerList.Setitems(AIndex : Integer; const AValue : TInstanceGroupManagerListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagerList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagerList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagersAbandonInstancesRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersAbandonInstancesRequest.Setinstances(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagersAbandonInstancesRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagersDeleteInstancesRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersDeleteInstancesRequest.Setinstances(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagersDeleteInstancesRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagersListManagedInstancesResponse
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersListManagedInstancesResponse.SetmanagedInstances(AIndex : Integer; const AValue : TInstanceGroupManagersListManagedInstancesResponseTypemanagedInstancesArray); 

begin
  If (FmanagedInstances=AValue) then exit;
  FmanagedInstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagersListManagedInstancesResponse.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'managedinstances' : SetLength(FmanagedInstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagersRecreateInstancesRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersRecreateInstancesRequest.Setinstances(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagersRecreateInstancesRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagersScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagersScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroupManagersScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagersScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TInstanceGroupManagersScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagersScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagersScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagersScopedList
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersScopedList.SetinstanceGroupManagers(AIndex : Integer; const AValue : TInstanceGroupManagersScopedListTypeinstanceGroupManagersArray); 

begin
  If (FinstanceGroupManagers=AValue) then exit;
  FinstanceGroupManagers:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagersScopedList.Setwarning(AIndex : Integer; const AValue : TInstanceGroupManagersScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagersScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instancegroupmanagers' : SetLength(FinstanceGroupManagers,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupManagersSetInstanceTemplateRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersSetInstanceTemplateRequest.SetinstanceTemplate(AIndex : Integer; const AValue : String); 

begin
  If (FinstanceTemplate=AValue) then exit;
  FinstanceTemplate:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroupManagersSetTargetPoolsRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupManagersSetTargetPoolsRequest.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupManagersSetTargetPoolsRequest.SettargetPools(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FtargetPools=AValue) then exit;
  FtargetPools:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupManagersSetTargetPoolsRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'targetpools' : SetLength(FtargetPools,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupsAddInstancesRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupsAddInstancesRequest.Setinstances(AIndex : Integer; const AValue : TInstanceGroupsAddInstancesRequestTypeinstancesArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupsAddInstancesRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupsListInstances
  --------------------------------------------------------------------}


Procedure TInstanceGroupsListInstances.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsListInstances.Setitems(AIndex : Integer; const AValue : TInstanceGroupsListInstancesTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsListInstances.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsListInstances.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsListInstances.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupsListInstances.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupsListInstancesRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupsListInstancesRequest.SetinstanceState(AIndex : Integer; const AValue : String); 

begin
  If (FinstanceState=AValue) then exit;
  FinstanceState:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroupsRemoveInstancesRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupsRemoveInstancesRequest.Setinstances(AIndex : Integer; const AValue : TInstanceGroupsRemoveInstancesRequestTypeinstancesArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupsRemoveInstancesRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupsScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TInstanceGroupsScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceGroupsScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TInstanceGroupsScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TInstanceGroupsScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupsScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupsScopedList
  --------------------------------------------------------------------}


Procedure TInstanceGroupsScopedList.SetinstanceGroups(AIndex : Integer; const AValue : TInstanceGroupsScopedListTypeinstanceGroupsArray); 

begin
  If (FinstanceGroups=AValue) then exit;
  FinstanceGroups:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsScopedList.Setwarning(AIndex : Integer; const AValue : TInstanceGroupsScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupsScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instancegroups' : SetLength(FinstanceGroups,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceGroupsSetNamedPortsRequest
  --------------------------------------------------------------------}


Procedure TInstanceGroupsSetNamedPortsRequest.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceGroupsSetNamedPortsRequest.SetnamedPorts(AIndex : Integer; const AValue : TInstanceGroupsSetNamedPortsRequestTypenamedPortsArray); 

begin
  If (FnamedPorts=AValue) then exit;
  FnamedPorts:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceGroupsSetNamedPortsRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'namedports' : SetLength(FnamedPorts,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceList
  --------------------------------------------------------------------}


Procedure TInstanceList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceList.Setitems(AIndex : Integer; const AValue : TInstanceListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceMoveRequest
  --------------------------------------------------------------------}


Procedure TInstanceMoveRequest.SetdestinationZone(AIndex : Integer; const AValue : String); 

begin
  If (FdestinationZone=AValue) then exit;
  FdestinationZone:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceMoveRequest.SettargetInstance(AIndex : Integer; const AValue : String); 

begin
  If (FtargetInstance=AValue) then exit;
  FtargetInstance:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceProperties
  --------------------------------------------------------------------}


Procedure TInstanceProperties.SetcanIpForward(AIndex : Integer; const AValue : boolean); 

begin
  If (FcanIpForward=AValue) then exit;
  FcanIpForward:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.Setdisks(AIndex : Integer; const AValue : TInstancePropertiesTypedisksArray); 

begin
  If (Fdisks=AValue) then exit;
  Fdisks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.SetmachineType(AIndex : Integer; const AValue : String); 

begin
  If (FmachineType=AValue) then exit;
  FmachineType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.Setmetadata(AIndex : Integer; const AValue : TMetadata); 

begin
  If (Fmetadata=AValue) then exit;
  Fmetadata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.SetnetworkInterfaces(AIndex : Integer; const AValue : TInstancePropertiesTypenetworkInterfacesArray); 

begin
  If (FnetworkInterfaces=AValue) then exit;
  FnetworkInterfaces:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.Setscheduling(AIndex : Integer; const AValue : TScheduling); 

begin
  If (Fscheduling=AValue) then exit;
  Fscheduling:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.SetserviceAccounts(AIndex : Integer; const AValue : TInstancePropertiesTypeserviceAccountsArray); 

begin
  If (FserviceAccounts=AValue) then exit;
  FserviceAccounts:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceProperties.Settags(AIndex : Integer; const AValue : TTags); 

begin
  If (Ftags=AValue) then exit;
  Ftags:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceProperties.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'disks' : SetLength(Fdisks,ALength);
  'networkinterfaces' : SetLength(FnetworkInterfaces,ALength);
  'serviceaccounts' : SetLength(FserviceAccounts,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceReference
  --------------------------------------------------------------------}


Procedure TInstanceReference.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceTemplate
  --------------------------------------------------------------------}


Procedure TInstanceTemplate.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplate.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplate.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplate.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplate.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplate.Setproperties(AIndex : Integer; const AValue : TInstanceProperties); 

begin
  If (Fproperties=AValue) then exit;
  Fproperties:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplate.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstanceTemplateList
  --------------------------------------------------------------------}


Procedure TInstanceTemplateList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplateList.Setitems(AIndex : Integer; const AValue : TInstanceTemplateListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplateList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplateList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceTemplateList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceTemplateList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstanceWithNamedPorts
  --------------------------------------------------------------------}


Procedure TInstanceWithNamedPorts.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceWithNamedPorts.SetnamedPorts(AIndex : Integer; const AValue : TInstanceWithNamedPortsTypenamedPortsArray); 

begin
  If (FnamedPorts=AValue) then exit;
  FnamedPorts:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstanceWithNamedPorts.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstanceWithNamedPorts.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'namedports' : SetLength(FnamedPorts,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstancesScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TInstancesScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstancesScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TInstancesScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TInstancesScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstancesScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TInstancesScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstancesScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstancesScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstancesScopedList
  --------------------------------------------------------------------}


Procedure TInstancesScopedList.Setinstances(AIndex : Integer; const AValue : TInstancesScopedListTypeinstancesArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TInstancesScopedList.Setwarning(AIndex : Integer; const AValue : TInstancesScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TInstancesScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TInstancesSetMachineTypeRequest
  --------------------------------------------------------------------}


Procedure TInstancesSetMachineTypeRequest.SetmachineType(AIndex : Integer; const AValue : String); 

begin
  If (FmachineType=AValue) then exit;
  FmachineType:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TLicense
  --------------------------------------------------------------------}


Procedure TLicense.SetchargesUseFee(AIndex : Integer; const AValue : boolean); 

begin
  If (FchargesUseFee=AValue) then exit;
  FchargesUseFee:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLicense.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLicense.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TLicense.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMachineTypeTypescratchDisksItem
  --------------------------------------------------------------------}


Procedure TMachineTypeTypescratchDisksItem.SetdiskGb(AIndex : Integer; const AValue : integer); 

begin
  If (FdiskGb=AValue) then exit;
  FdiskGb:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMachineType
  --------------------------------------------------------------------}


Procedure TMachineType.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); 

begin
  If (Fdeprecated=AValue) then exit;
  Fdeprecated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.SetguestCpus(AIndex : Integer; const AValue : integer); 

begin
  If (FguestCpus=AValue) then exit;
  FguestCpus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.SetimageSpaceGb(AIndex : Integer; const AValue : integer); 

begin
  If (FimageSpaceGb=AValue) then exit;
  FimageSpaceGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.SetmaximumPersistentDisks(AIndex : Integer; const AValue : integer); 

begin
  If (FmaximumPersistentDisks=AValue) then exit;
  FmaximumPersistentDisks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.SetmaximumPersistentDisksSizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FmaximumPersistentDisksSizeGb=AValue) then exit;
  FmaximumPersistentDisksSizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.SetmemoryMb(AIndex : Integer; const AValue : integer); 

begin
  If (FmemoryMb=AValue) then exit;
  FmemoryMb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.SetscratchDisks(AIndex : Integer; const AValue : TMachineTypeTypescratchDisksArray); 

begin
  If (FscratchDisks=AValue) then exit;
  FscratchDisks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineType.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TMachineType.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'scratchdisks' : SetLength(FscratchDisks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TMachineTypeAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TMachineTypeAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TMachineTypeAggregatedList
  --------------------------------------------------------------------}


Procedure TMachineTypeAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeAggregatedList.Setitems(AIndex : Integer; const AValue : TMachineTypeAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMachineTypeList
  --------------------------------------------------------------------}


Procedure TMachineTypeList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeList.Setitems(AIndex : Integer; const AValue : TMachineTypeListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypeList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TMachineTypeList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TMachineTypesScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TMachineTypesScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypesScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMachineTypesScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TMachineTypesScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypesScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TMachineTypesScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypesScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TMachineTypesScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TMachineTypesScopedList
  --------------------------------------------------------------------}


Procedure TMachineTypesScopedList.SetmachineTypes(AIndex : Integer; const AValue : TMachineTypesScopedListTypemachineTypesArray); 

begin
  If (FmachineTypes=AValue) then exit;
  FmachineTypes:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMachineTypesScopedList.Setwarning(AIndex : Integer; const AValue : TMachineTypesScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TMachineTypesScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'machinetypes' : SetLength(FmachineTypes,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TManagedInstance
  --------------------------------------------------------------------}


Procedure TManagedInstance.SetcurrentAction(AIndex : Integer; const AValue : String); 

begin
  If (FcurrentAction=AValue) then exit;
  FcurrentAction:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TManagedInstance.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TManagedInstance.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TManagedInstance.SetinstanceStatus(AIndex : Integer; const AValue : String); 

begin
  If (FinstanceStatus=AValue) then exit;
  FinstanceStatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TManagedInstance.SetlastAttempt(AIndex : Integer; const AValue : TManagedInstanceLastAttempt); 

begin
  If (FlastAttempt=AValue) then exit;
  FlastAttempt:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem
  --------------------------------------------------------------------}


Procedure TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem.Setlocation(AIndex : Integer; const AValue : String); 

begin
  If (Flocation=AValue) then exit;
  Flocation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TManagedInstanceLastAttemptTypeerrors
  --------------------------------------------------------------------}


Procedure TManagedInstanceLastAttemptTypeerrors.Seterrors(AIndex : Integer; const AValue : TManagedInstanceLastAttemptTypeerrorsTypeerrorsArray); 

begin
  If (Ferrors=AValue) then exit;
  Ferrors:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TManagedInstanceLastAttemptTypeerrors.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'errors' : SetLength(Ferrors,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TManagedInstanceLastAttempt
  --------------------------------------------------------------------}


Procedure TManagedInstanceLastAttempt.Seterrors(AIndex : Integer; const AValue : TManagedInstanceLastAttemptTypeerrors); 

begin
  If (Ferrors=AValue) then exit;
  Ferrors:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMetadataTypeitemsItem
  --------------------------------------------------------------------}


Procedure TMetadataTypeitemsItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMetadataTypeitemsItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TMetadata
  --------------------------------------------------------------------}


Procedure TMetadata.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMetadata.Setitems(AIndex : Integer; const AValue : TMetadataTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TMetadata.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TMetadata.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TNamedPort
  --------------------------------------------------------------------}


Procedure TNamedPort.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNamedPort.Setport(AIndex : Integer; const AValue : integer); 

begin
  If (Fport=AValue) then exit;
  Fport:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TNetwork
  --------------------------------------------------------------------}


Procedure TNetwork.SetIPv4Range(AIndex : Integer; const AValue : String); 

begin
  If (FIPv4Range=AValue) then exit;
  FIPv4Range:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.SetautoCreateSubnetworks(AIndex : Integer; const AValue : boolean); 

begin
  If (FautoCreateSubnetworks=AValue) then exit;
  FautoCreateSubnetworks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.SetgatewayIPv4(AIndex : Integer; const AValue : String); 

begin
  If (FgatewayIPv4=AValue) then exit;
  FgatewayIPv4:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetwork.Setsubnetworks(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fsubnetworks=AValue) then exit;
  Fsubnetworks:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TNetwork.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'subnetworks' : SetLength(Fsubnetworks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TNetworkInterface
  --------------------------------------------------------------------}


Procedure TNetworkInterface.SetaccessConfigs(AIndex : Integer; const AValue : TNetworkInterfaceTypeaccessConfigsArray); 

begin
  If (FaccessConfigs=AValue) then exit;
  FaccessConfigs:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkInterface.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkInterface.Setnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fnetwork=AValue) then exit;
  Fnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkInterface.SetnetworkIP(AIndex : Integer; const AValue : String); 

begin
  If (FnetworkIP=AValue) then exit;
  FnetworkIP:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkInterface.Setsubnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fsubnetwork=AValue) then exit;
  Fsubnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TNetworkInterface.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'accessconfigs' : SetLength(FaccessConfigs,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TNetworkList
  --------------------------------------------------------------------}


Procedure TNetworkList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkList.Setitems(AIndex : Integer; const AValue : TNetworkListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TNetworkList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TNetworkList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOperationTypeerrorTypeerrorsItem
  --------------------------------------------------------------------}


Procedure TOperationTypeerrorTypeerrorsItem.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationTypeerrorTypeerrorsItem.Setlocation(AIndex : Integer; const AValue : String); 

begin
  If (Flocation=AValue) then exit;
  Flocation:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationTypeerrorTypeerrorsItem.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOperationTypeerror
  --------------------------------------------------------------------}


Procedure TOperationTypeerror.Seterrors(AIndex : Integer; const AValue : TOperationTypeerrorTypeerrorsArray); 

begin
  If (Ferrors=AValue) then exit;
  Ferrors:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperationTypeerror.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'errors' : SetLength(Ferrors,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOperationTypewarningsItemTypedataItem
  --------------------------------------------------------------------}


Procedure TOperationTypewarningsItemTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationTypewarningsItemTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOperationTypewarningsItem
  --------------------------------------------------------------------}


Procedure TOperationTypewarningsItem.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationTypewarningsItem.Setdata(AIndex : Integer; const AValue : TOperationTypewarningsItemTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationTypewarningsItem.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperationTypewarningsItem.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOperation
  --------------------------------------------------------------------}


Procedure TOperation.SetclientOperationId(AIndex : Integer; const AValue : String); 

begin
  If (FclientOperationId=AValue) then exit;
  FclientOperationId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetendTime(AIndex : Integer; const AValue : String); 

begin
  If (FendTime=AValue) then exit;
  FendTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Seterror(AIndex : Integer; const AValue : TOperationTypeerror); 

begin
  If (Ferror=AValue) then exit;
  Ferror:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SethttpErrorMessage(AIndex : Integer; const AValue : String); 

begin
  If (FhttpErrorMessage=AValue) then exit;
  FhttpErrorMessage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SethttpErrorStatusCode(AIndex : Integer; const AValue : integer); 

begin
  If (FhttpErrorStatusCode=AValue) then exit;
  FhttpErrorStatusCode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetinsertTime(AIndex : Integer; const AValue : String); 

begin
  If (FinsertTime=AValue) then exit;
  FinsertTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetoperationType(AIndex : Integer; const AValue : String); 

begin
  If (FoperationType=AValue) then exit;
  FoperationType:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setprogress(AIndex : Integer; const AValue : integer); 

begin
  If (Fprogress=AValue) then exit;
  Fprogress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetstartTime(AIndex : Integer; const AValue : String); 

begin
  If (FstartTime=AValue) then exit;
  FstartTime:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SetstatusMessage(AIndex : Integer; const AValue : String); 

begin
  If (FstatusMessage=AValue) then exit;
  FstatusMessage:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SettargetId(AIndex : Integer; const AValue : String); 

begin
  If (FtargetId=AValue) then exit;
  FtargetId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.SettargetLink(AIndex : Integer; const AValue : String); 

begin
  If (FtargetLink=AValue) then exit;
  FtargetLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setuser(AIndex : Integer; const AValue : String); 

begin
  If (Fuser=AValue) then exit;
  Fuser:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setwarnings(AIndex : Integer; const AValue : TOperationTypewarningsArray); 

begin
  If (Fwarnings=AValue) then exit;
  Fwarnings:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperation.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperation.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'warnings' : SetLength(Fwarnings,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOperationAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TOperationAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TOperationAggregatedList
  --------------------------------------------------------------------}


Procedure TOperationAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationAggregatedList.Setitems(AIndex : Integer; const AValue : TOperationAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOperationList
  --------------------------------------------------------------------}


Procedure TOperationList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationList.Setitems(AIndex : Integer; const AValue : TOperationListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperationList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOperationsScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TOperationsScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationsScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TOperationsScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TOperationsScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationsScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TOperationsScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationsScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperationsScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TOperationsScopedList
  --------------------------------------------------------------------}


Procedure TOperationsScopedList.Setoperations(AIndex : Integer; const AValue : TOperationsScopedListTypeoperationsArray); 

begin
  If (Foperations=AValue) then exit;
  Foperations:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TOperationsScopedList.Setwarning(AIndex : Integer; const AValue : TOperationsScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TOperationsScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'operations' : SetLength(Foperations,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TPathMatcher
  --------------------------------------------------------------------}


Procedure TPathMatcher.SetdefaultService(AIndex : Integer; const AValue : String); 

begin
  If (FdefaultService=AValue) then exit;
  FdefaultService:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPathMatcher.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPathMatcher.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPathMatcher.SetpathRules(AIndex : Integer; const AValue : TPathMatcherTypepathRulesArray); 

begin
  If (FpathRules=AValue) then exit;
  FpathRules:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TPathMatcher.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'pathrules' : SetLength(FpathRules,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TPathRule
  --------------------------------------------------------------------}


Procedure TPathRule.Setpaths(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fpaths=AValue) then exit;
  Fpaths:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TPathRule.Setservice(AIndex : Integer; const AValue : String); 

begin
  If (Fservice=AValue) then exit;
  Fservice:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TPathRule.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'paths' : SetLength(Fpaths,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TProject
  --------------------------------------------------------------------}


Procedure TProject.SetcommonInstanceMetadata(AIndex : Integer; const AValue : TMetadata); 

begin
  If (FcommonInstanceMetadata=AValue) then exit;
  FcommonInstanceMetadata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.SetenabledFeatures(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FenabledFeatures=AValue) then exit;
  FenabledFeatures:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.Setquotas(AIndex : Integer; const AValue : TProjectTypequotasArray); 

begin
  If (Fquotas=AValue) then exit;
  Fquotas:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TProject.SetusageExportLocation(AIndex : Integer; const AValue : TUsageExportLocation); 

begin
  If (FusageExportLocation=AValue) then exit;
  FusageExportLocation:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TProject.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'enabledfeatures' : SetLength(FenabledFeatures,ALength);
  'quotas' : SetLength(Fquotas,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TQuota
  --------------------------------------------------------------------}


Procedure TQuota.Setlimit(AIndex : Integer; const AValue : double); 

begin
  If (Flimit=AValue) then exit;
  Flimit:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TQuota.Setmetric(AIndex : Integer; const AValue : String); 

begin
  If (Fmetric=AValue) then exit;
  Fmetric:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TQuota.Setusage(AIndex : Integer; const AValue : double); 

begin
  If (Fusage=AValue) then exit;
  Fusage:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TRegion
  --------------------------------------------------------------------}


Procedure TRegion.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); 

begin
  If (Fdeprecated=AValue) then exit;
  Fdeprecated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setquotas(AIndex : Integer; const AValue : TRegionTypequotasArray); 

begin
  If (Fquotas=AValue) then exit;
  Fquotas:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegion.Setzones(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fzones=AValue) then exit;
  Fzones:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TRegion.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'quotas' : SetLength(Fquotas,ALength);
  'zones' : SetLength(Fzones,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TRegionList
  --------------------------------------------------------------------}


Procedure TRegionList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegionList.Setitems(AIndex : Integer; const AValue : TRegionListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegionList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegionList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRegionList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TRegionList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TResourceGroupReference
  --------------------------------------------------------------------}


Procedure TResourceGroupReference.Setgroup(AIndex : Integer; const AValue : String); 

begin
  If (Fgroup=AValue) then exit;
  Fgroup:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TRouteTypewarningsItemTypedataItem
  --------------------------------------------------------------------}


Procedure TRouteTypewarningsItemTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRouteTypewarningsItemTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TRouteTypewarningsItem
  --------------------------------------------------------------------}


Procedure TRouteTypewarningsItem.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRouteTypewarningsItem.Setdata(AIndex : Integer; const AValue : TRouteTypewarningsItemTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRouteTypewarningsItem.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TRouteTypewarningsItem.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TRoute
  --------------------------------------------------------------------}


Procedure TRoute.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.SetdestRange(AIndex : Integer; const AValue : String); 

begin
  If (FdestRange=AValue) then exit;
  FdestRange:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Setnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fnetwork=AValue) then exit;
  Fnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.SetnextHopGateway(AIndex : Integer; const AValue : String); 

begin
  If (FnextHopGateway=AValue) then exit;
  FnextHopGateway:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.SetnextHopInstance(AIndex : Integer; const AValue : String); 

begin
  If (FnextHopInstance=AValue) then exit;
  FnextHopInstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.SetnextHopIp(AIndex : Integer; const AValue : String); 

begin
  If (FnextHopIp=AValue) then exit;
  FnextHopIp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.SetnextHopNetwork(AIndex : Integer; const AValue : String); 

begin
  If (FnextHopNetwork=AValue) then exit;
  FnextHopNetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.SetnextHopVpnTunnel(AIndex : Integer; const AValue : String); 

begin
  If (FnextHopVpnTunnel=AValue) then exit;
  FnextHopVpnTunnel:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Setpriority(AIndex : Integer; const AValue : integer); 

begin
  If (Fpriority=AValue) then exit;
  Fpriority:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Settags(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Ftags=AValue) then exit;
  Ftags:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRoute.Setwarnings(AIndex : Integer; const AValue : TRouteTypewarningsArray); 

begin
  If (Fwarnings=AValue) then exit;
  Fwarnings:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TRoute.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'tags' : SetLength(Ftags,ALength);
  'warnings' : SetLength(Fwarnings,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TRouteList
  --------------------------------------------------------------------}


Procedure TRouteList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRouteList.Setitems(AIndex : Integer; const AValue : TRouteListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRouteList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRouteList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TRouteList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TRouteList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TScheduling
  --------------------------------------------------------------------}


Procedure TScheduling.SetautomaticRestart(AIndex : Integer; const AValue : boolean); 

begin
  If (FautomaticRestart=AValue) then exit;
  FautomaticRestart:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TScheduling.SetonHostMaintenance(AIndex : Integer; const AValue : String); 

begin
  If (FonHostMaintenance=AValue) then exit;
  FonHostMaintenance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TScheduling.Setpreemptible(AIndex : Integer; const AValue : boolean); 

begin
  If (Fpreemptible=AValue) then exit;
  Fpreemptible:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSerialPortOutput
  --------------------------------------------------------------------}


Procedure TSerialPortOutput.Setcontents(AIndex : Integer; const AValue : String); 

begin
  If (Fcontents=AValue) then exit;
  Fcontents:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSerialPortOutput.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSerialPortOutput.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TServiceAccount
  --------------------------------------------------------------------}


Procedure TServiceAccount.Setemail(AIndex : Integer; const AValue : String); 

begin
  If (Femail=AValue) then exit;
  Femail:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TServiceAccount.Setscopes(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fscopes=AValue) then exit;
  Fscopes:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TServiceAccount.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'scopes' : SetLength(Fscopes,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSnapshot
  --------------------------------------------------------------------}


Procedure TSnapshot.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.SetdiskSizeGb(AIndex : Integer; const AValue : String); 

begin
  If (FdiskSizeGb=AValue) then exit;
  FdiskSizeGb:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.Setlicenses(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Flicenses=AValue) then exit;
  Flicenses:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.SetsourceDisk(AIndex : Integer; const AValue : String); 

begin
  If (FsourceDisk=AValue) then exit;
  FsourceDisk:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.SetsourceDiskId(AIndex : Integer; const AValue : String); 

begin
  If (FsourceDiskId=AValue) then exit;
  FsourceDiskId:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.SetstorageBytes(AIndex : Integer; const AValue : String); 

begin
  If (FstorageBytes=AValue) then exit;
  FstorageBytes:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshot.SetstorageBytesStatus(AIndex : Integer; const AValue : String); 

begin
  If (FstorageBytesStatus=AValue) then exit;
  FstorageBytesStatus:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSnapshot.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'licenses' : SetLength(Flicenses,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSnapshotList
  --------------------------------------------------------------------}


Procedure TSnapshotList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshotList.Setitems(AIndex : Integer; const AValue : TSnapshotListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshotList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshotList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSnapshotList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSnapshotList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSslCertificate
  --------------------------------------------------------------------}


Procedure TSslCertificate.Setcertificate(AIndex : Integer; const AValue : String); 

begin
  If (Fcertificate=AValue) then exit;
  Fcertificate:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificate.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificate.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificate.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificate.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificate.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificate.SetprivateKey(AIndex : Integer; const AValue : String); 

begin
  If (FprivateKey=AValue) then exit;
  FprivateKey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificate.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSslCertificateList
  --------------------------------------------------------------------}


Procedure TSslCertificateList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificateList.Setitems(AIndex : Integer; const AValue : TSslCertificateListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificateList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificateList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSslCertificateList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSslCertificateList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSubnetwork
  --------------------------------------------------------------------}


Procedure TSubnetwork.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.SetgatewayAddress(AIndex : Integer; const AValue : String); 

begin
  If (FgatewayAddress=AValue) then exit;
  FgatewayAddress:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.SetipCidrRange(AIndex : Integer; const AValue : String); 

begin
  If (FipCidrRange=AValue) then exit;
  FipCidrRange:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.Setnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fnetwork=AValue) then exit;
  Fnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetwork.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSubnetworkAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TSubnetworkAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TSubnetworkAggregatedList
  --------------------------------------------------------------------}


Procedure TSubnetworkAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkAggregatedList.Setitems(AIndex : Integer; const AValue : TSubnetworkAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSubnetworkList
  --------------------------------------------------------------------}


Procedure TSubnetworkList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkList.Setitems(AIndex : Integer; const AValue : TSubnetworkListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworkList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSubnetworkList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSubnetworksScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TSubnetworksScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworksScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TSubnetworksScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TSubnetworksScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworksScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TSubnetworksScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworksScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSubnetworksScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TSubnetworksScopedList
  --------------------------------------------------------------------}


Procedure TSubnetworksScopedList.Setsubnetworks(AIndex : Integer; const AValue : TSubnetworksScopedListTypesubnetworksArray); 

begin
  If (Fsubnetworks=AValue) then exit;
  Fsubnetworks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TSubnetworksScopedList.Setwarning(AIndex : Integer; const AValue : TSubnetworksScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TSubnetworksScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'subnetworks' : SetLength(Fsubnetworks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTags
  --------------------------------------------------------------------}


Procedure TTags.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTags.Setitems(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTags.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetHttpProxy
  --------------------------------------------------------------------}


Procedure TTargetHttpProxy.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxy.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxy.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxy.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxy.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxy.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxy.SeturlMap(AIndex : Integer; const AValue : String); 

begin
  If (FurlMap=AValue) then exit;
  FurlMap:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetHttpProxyList
  --------------------------------------------------------------------}


Procedure TTargetHttpProxyList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxyList.Setitems(AIndex : Integer; const AValue : TTargetHttpProxyListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxyList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxyList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpProxyList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetHttpProxyList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetHttpsProxiesSetSslCertificatesRequest
  --------------------------------------------------------------------}


Procedure TTargetHttpsProxiesSetSslCertificatesRequest.SetsslCertificates(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FsslCertificates=AValue) then exit;
  FsslCertificates:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetHttpsProxiesSetSslCertificatesRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'sslcertificates' : SetLength(FsslCertificates,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetHttpsProxy
  --------------------------------------------------------------------}


Procedure TTargetHttpsProxy.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxy.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxy.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxy.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxy.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxy.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxy.SetsslCertificates(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FsslCertificates=AValue) then exit;
  FsslCertificates:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxy.SeturlMap(AIndex : Integer; const AValue : String); 

begin
  If (FurlMap=AValue) then exit;
  FurlMap:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetHttpsProxy.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'sslcertificates' : SetLength(FsslCertificates,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetHttpsProxyList
  --------------------------------------------------------------------}


Procedure TTargetHttpsProxyList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxyList.Setitems(AIndex : Integer; const AValue : TTargetHttpsProxyListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxyList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxyList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetHttpsProxyList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetHttpsProxyList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetInstance
  --------------------------------------------------------------------}


Procedure TTargetInstance.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.Setinstance(AIndex : Integer; const AValue : String); 

begin
  If (Finstance=AValue) then exit;
  Finstance:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.SetnatPolicy(AIndex : Integer; const AValue : String); 

begin
  If (FnatPolicy=AValue) then exit;
  FnatPolicy:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstance.Setzone(AIndex : Integer; const AValue : String); 

begin
  If (Fzone=AValue) then exit;
  Fzone:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetInstanceAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TTargetInstanceAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TTargetInstanceAggregatedList
  --------------------------------------------------------------------}


Procedure TTargetInstanceAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceAggregatedList.Setitems(AIndex : Integer; const AValue : TTargetInstanceAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetInstanceList
  --------------------------------------------------------------------}


Procedure TTargetInstanceList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceList.Setitems(AIndex : Integer; const AValue : TTargetInstanceListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstanceList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetInstanceList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetInstancesScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TTargetInstancesScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstancesScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetInstancesScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TTargetInstancesScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstancesScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TTargetInstancesScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstancesScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetInstancesScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetInstancesScopedList
  --------------------------------------------------------------------}


Procedure TTargetInstancesScopedList.SettargetInstances(AIndex : Integer; const AValue : TTargetInstancesScopedListTypetargetInstancesArray); 

begin
  If (FtargetInstances=AValue) then exit;
  FtargetInstances:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetInstancesScopedList.Setwarning(AIndex : Integer; const AValue : TTargetInstancesScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetInstancesScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'targetinstances' : SetLength(FtargetInstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPool
  --------------------------------------------------------------------}


Procedure TTargetPool.SetbackupPool(AIndex : Integer; const AValue : String); 

begin
  If (FbackupPool=AValue) then exit;
  FbackupPool:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.SetfailoverRatio(AIndex : Integer; const AValue : integer); 

begin
  If (FfailoverRatio=AValue) then exit;
  FfailoverRatio:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.SethealthChecks(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FhealthChecks=AValue) then exit;
  FhealthChecks:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.Setinstances(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPool.SetsessionAffinity(AIndex : Integer; const AValue : String); 

begin
  If (FsessionAffinity=AValue) then exit;
  FsessionAffinity:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPool.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'healthchecks' : SetLength(FhealthChecks,ALength);
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TTargetPoolAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TTargetPoolAggregatedList
  --------------------------------------------------------------------}


Procedure TTargetPoolAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolAggregatedList.Setitems(AIndex : Integer; const AValue : TTargetPoolAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetPoolInstanceHealth
  --------------------------------------------------------------------}


Procedure TTargetPoolInstanceHealth.SethealthStatus(AIndex : Integer; const AValue : TTargetPoolInstanceHealthTypehealthStatusArray); 

begin
  If (FhealthStatus=AValue) then exit;
  FhealthStatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolInstanceHealth.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolInstanceHealth.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'healthstatus' : SetLength(FhealthStatus,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolList
  --------------------------------------------------------------------}


Procedure TTargetPoolList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolList.Setitems(AIndex : Integer; const AValue : TTargetPoolListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolsAddHealthCheckRequest
  --------------------------------------------------------------------}


Procedure TTargetPoolsAddHealthCheckRequest.SethealthChecks(AIndex : Integer; const AValue : TTargetPoolsAddHealthCheckRequestTypehealthChecksArray); 

begin
  If (FhealthChecks=AValue) then exit;
  FhealthChecks:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolsAddHealthCheckRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'healthchecks' : SetLength(FhealthChecks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolsAddInstanceRequest
  --------------------------------------------------------------------}


Procedure TTargetPoolsAddInstanceRequest.Setinstances(AIndex : Integer; const AValue : TTargetPoolsAddInstanceRequestTypeinstancesArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolsAddInstanceRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolsRemoveHealthCheckRequest
  --------------------------------------------------------------------}


Procedure TTargetPoolsRemoveHealthCheckRequest.SethealthChecks(AIndex : Integer; const AValue : TTargetPoolsRemoveHealthCheckRequestTypehealthChecksArray); 

begin
  If (FhealthChecks=AValue) then exit;
  FhealthChecks:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolsRemoveHealthCheckRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'healthchecks' : SetLength(FhealthChecks,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolsRemoveInstanceRequest
  --------------------------------------------------------------------}


Procedure TTargetPoolsRemoveInstanceRequest.Setinstances(AIndex : Integer; const AValue : TTargetPoolsRemoveInstanceRequestTypeinstancesArray); 

begin
  If (Finstances=AValue) then exit;
  Finstances:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolsRemoveInstanceRequest.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'instances' : SetLength(Finstances,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolsScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TTargetPoolsScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolsScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetPoolsScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TTargetPoolsScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolsScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TTargetPoolsScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolsScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolsScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetPoolsScopedList
  --------------------------------------------------------------------}


Procedure TTargetPoolsScopedList.SettargetPools(AIndex : Integer; const AValue : TTargetPoolsScopedListTypetargetPoolsArray); 

begin
  If (FtargetPools=AValue) then exit;
  FtargetPools:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetPoolsScopedList.Setwarning(AIndex : Integer; const AValue : TTargetPoolsScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetPoolsScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'targetpools' : SetLength(FtargetPools,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetReference
  --------------------------------------------------------------------}


Procedure TTargetReference.Settarget(AIndex : Integer; const AValue : String); 

begin
  If (Ftarget=AValue) then exit;
  Ftarget:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetVpnGateway
  --------------------------------------------------------------------}


Procedure TTargetVpnGateway.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.SetforwardingRules(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FforwardingRules=AValue) then exit;
  FforwardingRules:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Setnetwork(AIndex : Integer; const AValue : String); 

begin
  If (Fnetwork=AValue) then exit;
  Fnetwork:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGateway.Settunnels(AIndex : Integer; const AValue : TStringArray); 

begin
  If (Ftunnels=AValue) then exit;
  Ftunnels:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetVpnGateway.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'forwardingrules' : SetLength(FforwardingRules,ALength);
  'tunnels' : SetLength(Ftunnels,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetVpnGatewayAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TTargetVpnGatewayAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TTargetVpnGatewayAggregatedList
  --------------------------------------------------------------------}


Procedure TTargetVpnGatewayAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayAggregatedList.Setitems(AIndex : Integer; const AValue : TTargetVpnGatewayAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetVpnGatewayList
  --------------------------------------------------------------------}


Procedure TTargetVpnGatewayList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayList.Setitems(AIndex : Integer; const AValue : TTargetVpnGatewayListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewayList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetVpnGatewayList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetVpnGatewaysScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TTargetVpnGatewaysScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewaysScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TTargetVpnGatewaysScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TTargetVpnGatewaysScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewaysScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TTargetVpnGatewaysScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewaysScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetVpnGatewaysScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTargetVpnGatewaysScopedList
  --------------------------------------------------------------------}


Procedure TTargetVpnGatewaysScopedList.SettargetVpnGateways(AIndex : Integer; const AValue : TTargetVpnGatewaysScopedListTypetargetVpnGatewaysArray); 

begin
  If (FtargetVpnGateways=AValue) then exit;
  FtargetVpnGateways:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTargetVpnGatewaysScopedList.Setwarning(AIndex : Integer; const AValue : TTargetVpnGatewaysScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TTargetVpnGatewaysScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'targetvpngateways' : SetLength(FtargetVpnGateways,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TTestFailure
  --------------------------------------------------------------------}


Procedure TTestFailure.SetactualService(AIndex : Integer; const AValue : String); 

begin
  If (FactualService=AValue) then exit;
  FactualService:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTestFailure.SetexpectedService(AIndex : Integer; const AValue : String); 

begin
  If (FexpectedService=AValue) then exit;
  FexpectedService:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTestFailure.Sethost(AIndex : Integer; const AValue : String); 

begin
  If (Fhost=AValue) then exit;
  Fhost:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TTestFailure.Setpath(AIndex : Integer; const AValue : String); 

begin
  If (Fpath=AValue) then exit;
  Fpath:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUrlMap
  --------------------------------------------------------------------}


Procedure TUrlMap.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.SetdefaultService(AIndex : Integer; const AValue : String); 

begin
  If (FdefaultService=AValue) then exit;
  FdefaultService:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.Setfingerprint(AIndex : Integer; const AValue : String); 

begin
  If (Ffingerprint=AValue) then exit;
  Ffingerprint:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.SethostRules(AIndex : Integer; const AValue : TUrlMapTypehostRulesArray); 

begin
  If (FhostRules=AValue) then exit;
  FhostRules:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.SetpathMatchers(AIndex : Integer; const AValue : TUrlMapTypepathMatchersArray); 

begin
  If (FpathMatchers=AValue) then exit;
  FpathMatchers:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMap.Settests(AIndex : Integer; const AValue : TUrlMapTypetestsArray); 

begin
  If (Ftests=AValue) then exit;
  Ftests:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUrlMap.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'hostrules' : SetLength(FhostRules,ALength);
  'pathmatchers' : SetLength(FpathMatchers,ALength);
  'tests' : SetLength(Ftests,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUrlMapList
  --------------------------------------------------------------------}


Procedure TUrlMapList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapList.Setitems(AIndex : Integer; const AValue : TUrlMapListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUrlMapList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUrlMapReference
  --------------------------------------------------------------------}


Procedure TUrlMapReference.SeturlMap(AIndex : Integer; const AValue : String); 

begin
  If (FurlMap=AValue) then exit;
  FurlMap:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUrlMapTest
  --------------------------------------------------------------------}


Procedure TUrlMapTest.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapTest.Sethost(AIndex : Integer; const AValue : String); 

begin
  If (Fhost=AValue) then exit;
  Fhost:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapTest.Setpath(AIndex : Integer; const AValue : String); 

begin
  If (Fpath=AValue) then exit;
  Fpath:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapTest.Setservice(AIndex : Integer; const AValue : String); 

begin
  If (Fservice=AValue) then exit;
  Fservice:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUrlMapValidationResult
  --------------------------------------------------------------------}


Procedure TUrlMapValidationResult.SetloadErrors(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FloadErrors=AValue) then exit;
  FloadErrors:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapValidationResult.SetloadSucceeded(AIndex : Integer; const AValue : boolean); 

begin
  If (FloadSucceeded=AValue) then exit;
  FloadSucceeded:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapValidationResult.SettestFailures(AIndex : Integer; const AValue : TUrlMapValidationResultTypetestFailuresArray); 

begin
  If (FtestFailures=AValue) then exit;
  FtestFailures:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUrlMapValidationResult.SettestPassed(AIndex : Integer; const AValue : boolean); 

begin
  If (FtestPassed=AValue) then exit;
  FtestPassed:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TUrlMapValidationResult.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'loaderrors' : SetLength(FloadErrors,ALength);
  'testfailures' : SetLength(FtestFailures,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TUrlMapsValidateRequest
  --------------------------------------------------------------------}


Procedure TUrlMapsValidateRequest.Setresource(AIndex : Integer; const AValue : TUrlMap); 

begin
  If (Fresource=AValue) then exit;
  Fresource:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUrlMapsValidateResponse
  --------------------------------------------------------------------}


Procedure TUrlMapsValidateResponse.Setresult(AIndex : Integer; const AValue : TUrlMapValidationResult); 

begin
  If (Fresult=AValue) then exit;
  Fresult:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TUsageExportLocation
  --------------------------------------------------------------------}


Procedure TUsageExportLocation.SetbucketName(AIndex : Integer; const AValue : String); 

begin
  If (FbucketName=AValue) then exit;
  FbucketName:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TUsageExportLocation.SetreportNamePrefix(AIndex : Integer; const AValue : String); 

begin
  If (FreportNamePrefix=AValue) then exit;
  FreportNamePrefix:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TVpnTunnel
  --------------------------------------------------------------------}


Procedure TVpnTunnel.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SetdetailedStatus(AIndex : Integer; const AValue : String); 

begin
  If (FdetailedStatus=AValue) then exit;
  FdetailedStatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SetikeVersion(AIndex : Integer; const AValue : integer); 

begin
  If (FikeVersion=AValue) then exit;
  FikeVersion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SetlocalTrafficSelector(AIndex : Integer; const AValue : TStringArray); 

begin
  If (FlocalTrafficSelector=AValue) then exit;
  FlocalTrafficSelector:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SetpeerIp(AIndex : Integer; const AValue : String); 

begin
  If (FpeerIp=AValue) then exit;
  FpeerIp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SetsharedSecret(AIndex : Integer; const AValue : String); 

begin
  If (FsharedSecret=AValue) then exit;
  FsharedSecret:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SetsharedSecretHash(AIndex : Integer; const AValue : String); 

begin
  If (FsharedSecretHash=AValue) then exit;
  FsharedSecretHash:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnel.SettargetVpnGateway(AIndex : Integer; const AValue : String); 

begin
  If (FtargetVpnGateway=AValue) then exit;
  FtargetVpnGateway:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TVpnTunnel.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'localtrafficselector' : SetLength(FlocalTrafficSelector,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TVpnTunnelAggregatedListTypeitems
  --------------------------------------------------------------------}


Class Function TVpnTunnelAggregatedListTypeitems.AllowAdditionalProperties : Boolean;

begin
  Result:=True;
end;



{ --------------------------------------------------------------------
  TVpnTunnelAggregatedList
  --------------------------------------------------------------------}


Procedure TVpnTunnelAggregatedList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelAggregatedList.Setitems(AIndex : Integer; const AValue : TVpnTunnelAggregatedListTypeitems); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelAggregatedList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelAggregatedList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelAggregatedList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TVpnTunnelList
  --------------------------------------------------------------------}


Procedure TVpnTunnelList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelList.Setitems(AIndex : Integer; const AValue : TVpnTunnelListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TVpnTunnelList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TVpnTunnelsScopedListTypewarningTypedataItem
  --------------------------------------------------------------------}


Procedure TVpnTunnelsScopedListTypewarningTypedataItem.Setkey(AIndex : Integer; const AValue : String); 

begin
  If (Fkey=AValue) then exit;
  Fkey:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelsScopedListTypewarningTypedataItem.Setvalue(AIndex : Integer; const AValue : String); 

begin
  If (Fvalue=AValue) then exit;
  Fvalue:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TVpnTunnelsScopedListTypewarning
  --------------------------------------------------------------------}


Procedure TVpnTunnelsScopedListTypewarning.Setcode(AIndex : Integer; const AValue : String); 

begin
  If (Fcode=AValue) then exit;
  Fcode:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelsScopedListTypewarning.Setdata(AIndex : Integer; const AValue : TVpnTunnelsScopedListTypewarningTypedataArray); 

begin
  If (Fdata=AValue) then exit;
  Fdata:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelsScopedListTypewarning.Setmessage(AIndex : Integer; const AValue : String); 

begin
  If (Fmessage=AValue) then exit;
  Fmessage:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TVpnTunnelsScopedListTypewarning.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'data' : SetLength(Fdata,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TVpnTunnelsScopedList
  --------------------------------------------------------------------}


Procedure TVpnTunnelsScopedList.SetvpnTunnels(AIndex : Integer; const AValue : TVpnTunnelsScopedListTypevpnTunnelsArray); 

begin
  If (FvpnTunnels=AValue) then exit;
  FvpnTunnels:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TVpnTunnelsScopedList.Setwarning(AIndex : Integer; const AValue : TVpnTunnelsScopedListTypewarning); 

begin
  If (Fwarning=AValue) then exit;
  Fwarning:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TVpnTunnelsScopedList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'vpntunnels' : SetLength(FvpnTunnels,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TZone
  --------------------------------------------------------------------}


Procedure TZone.SetcreationTimestamp(AIndex : Integer; const AValue : String); 

begin
  If (FcreationTimestamp=AValue) then exit;
  FcreationTimestamp:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.Setdeprecated(AIndex : Integer; const AValue : TDeprecationStatus); 

begin
  If (Fdeprecated=AValue) then exit;
  Fdeprecated:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.Setdescription(AIndex : Integer; const AValue : String); 

begin
  If (Fdescription=AValue) then exit;
  Fdescription:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.Setname(AIndex : Integer; const AValue : String); 

begin
  If (Fname=AValue) then exit;
  Fname:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.Setregion(AIndex : Integer; const AValue : String); 

begin
  If (Fregion=AValue) then exit;
  Fregion:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZone.Setstatus(AIndex : Integer; const AValue : String); 

begin
  If (Fstatus=AValue) then exit;
  Fstatus:=AValue;
  MarkPropertyChanged(AIndex);
end;





{ --------------------------------------------------------------------
  TZoneList
  --------------------------------------------------------------------}


Procedure TZoneList.Setid(AIndex : Integer; const AValue : String); 

begin
  If (Fid=AValue) then exit;
  Fid:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZoneList.Setitems(AIndex : Integer; const AValue : TZoneListTypeitemsArray); 

begin
  If (Fitems=AValue) then exit;
  Fitems:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZoneList.Setkind(AIndex : Integer; const AValue : String); 

begin
  If (Fkind=AValue) then exit;
  Fkind:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZoneList.SetnextPageToken(AIndex : Integer; const AValue : String); 

begin
  If (FnextPageToken=AValue) then exit;
  FnextPageToken:=AValue;
  MarkPropertyChanged(AIndex);
end;



Procedure TZoneList.SetselfLink(AIndex : Integer; const AValue : String); 

begin
  If (FselfLink=AValue) then exit;
  FselfLink:=AValue;
  MarkPropertyChanged(AIndex);
end;


//2.6.4. bug workaround
{$IFDEF VER2_6}
Procedure TZoneList.SetArrayLength(Const AName : String; ALength : Longint); 

begin
  Case AName of
  'items' : SetLength(Fitems,ALength);
  else
    Inherited SetArrayLength(AName,ALength);
  end;
end;
{$ENDIF VER2_6}




{ --------------------------------------------------------------------
  TAddressesResource
  --------------------------------------------------------------------}


Class Function TAddressesResource.ResourceName : String;

begin
  Result:='addresses';
end;

Class Function TAddressesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TAddressesResource.AggregatedList(project: string; AQuery : string = '') : TAddressAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/addresses';
  _Methodid   = 'compute.addresses.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAddressAggregatedList) as TAddressAggregatedList;
end;


Function TAddressesResource.AggregatedList(project: string; AQuery : TAddressesaggregatedListOptions) : TAddressAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TAddressesResource.Delete(address: string; project: string; region: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/regions/{region}/addresses/{address}';
  _Methodid   = 'compute.addresses.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['address',address,'project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TAddressesResource.Get(address: string; project: string; region: string) : TAddress;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/addresses/{address}';
  _Methodid   = 'compute.addresses.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['address',address,'project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAddress) as TAddress;
end;

Function TAddressesResource.Insert(project: string; region: string; aAddress : TAddress) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/addresses';
  _Methodid   = 'compute.addresses.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAddress,TOperation) as TOperation;
end;

Function TAddressesResource.List(project: string; region: string; AQuery : string = '') : TAddressList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/addresses';
  _Methodid   = 'compute.addresses.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAddressList) as TAddressList;
end;


Function TAddressesResource.List(project: string; region: string; AQuery : TAddresseslistOptions) : TAddressList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,region,_Q);
end;



{ --------------------------------------------------------------------
  TAutoscalersResource
  --------------------------------------------------------------------}


Class Function TAutoscalersResource.ResourceName : String;

begin
  Result:='autoscalers';
end;

Class Function TAutoscalersResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TAutoscalersResource.AggregatedList(project: string; AQuery : string = '') : TAutoscalerAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/autoscalers';
  _Methodid   = 'compute.autoscalers.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAutoscalerAggregatedList) as TAutoscalerAggregatedList;
end;


Function TAutoscalersResource.AggregatedList(project: string; AQuery : TAutoscalersaggregatedListOptions) : TAutoscalerAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TAutoscalersResource.Delete(autoscaler: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/zones/{zone}/autoscalers/{autoscaler}';
  _Methodid   = 'compute.autoscalers.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['autoscaler',autoscaler,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TAutoscalersResource.Get(autoscaler: string; project: string; zone: string) : TAutoscaler;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/autoscalers/{autoscaler}';
  _Methodid   = 'compute.autoscalers.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['autoscaler',autoscaler,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAutoscaler) as TAutoscaler;
end;

Function TAutoscalersResource.Insert(project: string; zone: string; aAutoscaler : TAutoscaler) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/autoscalers';
  _Methodid   = 'compute.autoscalers.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAutoscaler,TOperation) as TOperation;
end;

Function TAutoscalersResource.List(project: string; zone: string; AQuery : string = '') : TAutoscalerList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/autoscalers';
  _Methodid   = 'compute.autoscalers.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAutoscalerList) as TAutoscalerList;
end;


Function TAutoscalersResource.List(project: string; zone: string; AQuery : TAutoscalerslistOptions) : TAutoscalerList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;

Function TAutoscalersResource.Patch(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = '{project}/zones/{zone}/autoscalers';
  _Methodid   = 'compute.autoscalers.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aAutoscaler,TOperation) as TOperation;
end;


Function TAutoscalersResource.Patch(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : TAutoscalerspatchOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'autoscaler',AQuery.autoscaler);
  Result:=Patch(project,zone,aAutoscaler,_Q);
end;

Function TAutoscalersResource.Update(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = '{project}/zones/{zone}/autoscalers';
  _Methodid   = 'compute.autoscalers.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aAutoscaler,TOperation) as TOperation;
end;


Function TAutoscalersResource.Update(project: string; zone: string; aAutoscaler : TAutoscaler; AQuery : TAutoscalersupdateOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'autoscaler',AQuery.autoscaler);
  Result:=Update(project,zone,aAutoscaler,_Q);
end;



{ --------------------------------------------------------------------
  TBackendServicesResource
  --------------------------------------------------------------------}


Class Function TBackendServicesResource.ResourceName : String;

begin
  Result:='backendServices';
end;

Class Function TBackendServicesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TBackendServicesResource.Delete(backendService: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/backendServices/{backendService}';
  _Methodid   = 'compute.backendServices.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['backendService',backendService,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TBackendServicesResource.Get(backendService: string; project: string) : TBackendService;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/backendServices/{backendService}';
  _Methodid   = 'compute.backendServices.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['backendService',backendService,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TBackendService) as TBackendService;
end;

Function TBackendServicesResource.GetHealth(backendService: string; project: string; aResourceGroupReference : TResourceGroupReference) : TBackendServiceGroupHealth;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/backendServices/{backendService}/getHealth';
  _Methodid   = 'compute.backendServices.getHealth';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['backendService',backendService,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aResourceGroupReference,TBackendServiceGroupHealth) as TBackendServiceGroupHealth;
end;

Function TBackendServicesResource.Insert(project: string; aBackendService : TBackendService) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/backendServices';
  _Methodid   = 'compute.backendServices.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aBackendService,TOperation) as TOperation;
end;

Function TBackendServicesResource.List(project: string; AQuery : string = '') : TBackendServiceList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/backendServices';
  _Methodid   = 'compute.backendServices.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TBackendServiceList) as TBackendServiceList;
end;


Function TBackendServicesResource.List(project: string; AQuery : TBackendServiceslistOptions) : TBackendServiceList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function TBackendServicesResource.Patch(backendService: string; project: string; aBackendService : TBackendService) : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = '{project}/global/backendServices/{backendService}';
  _Methodid   = 'compute.backendServices.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['backendService',backendService,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aBackendService,TOperation) as TOperation;
end;

Function TBackendServicesResource.Update(backendService: string; project: string; aBackendService : TBackendService) : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = '{project}/global/backendServices/{backendService}';
  _Methodid   = 'compute.backendServices.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['backendService',backendService,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aBackendService,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TDiskTypesResource
  --------------------------------------------------------------------}


Class Function TDiskTypesResource.ResourceName : String;

begin
  Result:='diskTypes';
end;

Class Function TDiskTypesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TDiskTypesResource.AggregatedList(project: string; AQuery : string = '') : TDiskTypeAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/diskTypes';
  _Methodid   = 'compute.diskTypes.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TDiskTypeAggregatedList) as TDiskTypeAggregatedList;
end;


Function TDiskTypesResource.AggregatedList(project: string; AQuery : TDiskTypesaggregatedListOptions) : TDiskTypeAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TDiskTypesResource.Get(diskType: string; project: string; zone: string) : TDiskType;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/diskTypes/{diskType}';
  _Methodid   = 'compute.diskTypes.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['diskType',diskType,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDiskType) as TDiskType;
end;

Function TDiskTypesResource.List(project: string; zone: string; AQuery : string = '') : TDiskTypeList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/diskTypes';
  _Methodid   = 'compute.diskTypes.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TDiskTypeList) as TDiskTypeList;
end;


Function TDiskTypesResource.List(project: string; zone: string; AQuery : TDiskTypeslistOptions) : TDiskTypeList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;



{ --------------------------------------------------------------------
  TDisksResource
  --------------------------------------------------------------------}


Class Function TDisksResource.ResourceName : String;

begin
  Result:='disks';
end;

Class Function TDisksResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TDisksResource.AggregatedList(project: string; AQuery : string = '') : TDiskAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/disks';
  _Methodid   = 'compute.disks.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TDiskAggregatedList) as TDiskAggregatedList;
end;


Function TDisksResource.AggregatedList(project: string; AQuery : TDisksaggregatedListOptions) : TDiskAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TDisksResource.CreateSnapshot(disk: string; project: string; zone: string; aSnapshot : TSnapshot) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/disks/{disk}/createSnapshot';
  _Methodid   = 'compute.disks.createSnapshot';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['disk',disk,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aSnapshot,TOperation) as TOperation;
end;

Function TDisksResource.Delete(disk: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/zones/{zone}/disks/{disk}';
  _Methodid   = 'compute.disks.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['disk',disk,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TDisksResource.Get(disk: string; project: string; zone: string) : TDisk;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/disks/{disk}';
  _Methodid   = 'compute.disks.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['disk',disk,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TDisk) as TDisk;
end;

Function TDisksResource.Insert(project: string; zone: string; aDisk : TDisk; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/disks';
  _Methodid   = 'compute.disks.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aDisk,TOperation) as TOperation;
end;


Function TDisksResource.Insert(project: string; zone: string; aDisk : TDisk; AQuery : TDisksinsertOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'sourceImage',AQuery.sourceImage);
  Result:=Insert(project,zone,aDisk,_Q);
end;

Function TDisksResource.List(project: string; zone: string; AQuery : string = '') : TDiskList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/disks';
  _Methodid   = 'compute.disks.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TDiskList) as TDiskList;
end;


Function TDisksResource.List(project: string; zone: string; AQuery : TDiskslistOptions) : TDiskList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;

Function TDisksResource.Resize(disk: string; project: string; zone: string; aDisksResizeRequest : TDisksResizeRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/disks/{disk}/resize';
  _Methodid   = 'compute.disks.resize';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['disk',disk,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDisksResizeRequest,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TFirewallsResource
  --------------------------------------------------------------------}


Class Function TFirewallsResource.ResourceName : String;

begin
  Result:='firewalls';
end;

Class Function TFirewallsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TFirewallsResource.Delete(firewall: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/firewalls/{firewall}';
  _Methodid   = 'compute.firewalls.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['firewall',firewall,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TFirewallsResource.Get(firewall: string; project: string) : TFirewall;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/firewalls/{firewall}';
  _Methodid   = 'compute.firewalls.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['firewall',firewall,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TFirewall) as TFirewall;
end;

Function TFirewallsResource.Insert(project: string; aFirewall : TFirewall) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/firewalls';
  _Methodid   = 'compute.firewalls.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aFirewall,TOperation) as TOperation;
end;

Function TFirewallsResource.List(project: string; AQuery : string = '') : TFirewallList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/firewalls';
  _Methodid   = 'compute.firewalls.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TFirewallList) as TFirewallList;
end;


Function TFirewallsResource.List(project: string; AQuery : TFirewallslistOptions) : TFirewallList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function TFirewallsResource.Patch(firewall: string; project: string; aFirewall : TFirewall) : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = '{project}/global/firewalls/{firewall}';
  _Methodid   = 'compute.firewalls.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['firewall',firewall,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aFirewall,TOperation) as TOperation;
end;

Function TFirewallsResource.Update(firewall: string; project: string; aFirewall : TFirewall) : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = '{project}/global/firewalls/{firewall}';
  _Methodid   = 'compute.firewalls.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['firewall',firewall,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aFirewall,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TForwardingRulesResource
  --------------------------------------------------------------------}


Class Function TForwardingRulesResource.ResourceName : String;

begin
  Result:='forwardingRules';
end;

Class Function TForwardingRulesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TForwardingRulesResource.AggregatedList(project: string; AQuery : string = '') : TForwardingRuleAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/forwardingRules';
  _Methodid   = 'compute.forwardingRules.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TForwardingRuleAggregatedList) as TForwardingRuleAggregatedList;
end;


Function TForwardingRulesResource.AggregatedList(project: string; AQuery : TForwardingRulesaggregatedListOptions) : TForwardingRuleAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TForwardingRulesResource.Delete(forwardingRule: string; project: string; region: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/regions/{region}/forwardingRules/{forwardingRule}';
  _Methodid   = 'compute.forwardingRules.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['forwardingRule',forwardingRule,'project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TForwardingRulesResource.Get(forwardingRule: string; project: string; region: string) : TForwardingRule;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/forwardingRules/{forwardingRule}';
  _Methodid   = 'compute.forwardingRules.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['forwardingRule',forwardingRule,'project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TForwardingRule) as TForwardingRule;
end;

Function TForwardingRulesResource.Insert(project: string; region: string; aForwardingRule : TForwardingRule) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/forwardingRules';
  _Methodid   = 'compute.forwardingRules.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aForwardingRule,TOperation) as TOperation;
end;

Function TForwardingRulesResource.List(project: string; region: string; AQuery : string = '') : TForwardingRuleList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/forwardingRules';
  _Methodid   = 'compute.forwardingRules.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TForwardingRuleList) as TForwardingRuleList;
end;


Function TForwardingRulesResource.List(project: string; region: string; AQuery : TForwardingRuleslistOptions) : TForwardingRuleList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,region,_Q);
end;

Function TForwardingRulesResource.SetTarget(forwardingRule: string; project: string; region: string; aTargetReference : TTargetReference) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/forwardingRules/{forwardingRule}/setTarget';
  _Methodid   = 'compute.forwardingRules.setTarget';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['forwardingRule',forwardingRule,'project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetReference,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TGlobalAddressesResource
  --------------------------------------------------------------------}


Class Function TGlobalAddressesResource.ResourceName : String;

begin
  Result:='globalAddresses';
end;

Class Function TGlobalAddressesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TGlobalAddressesResource.Delete(address: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/addresses/{address}';
  _Methodid   = 'compute.globalAddresses.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['address',address,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TGlobalAddressesResource.Get(address: string; project: string) : TAddress;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/addresses/{address}';
  _Methodid   = 'compute.globalAddresses.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['address',address,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TAddress) as TAddress;
end;

Function TGlobalAddressesResource.Insert(project: string; aAddress : TAddress) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/addresses';
  _Methodid   = 'compute.globalAddresses.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAddress,TOperation) as TOperation;
end;

Function TGlobalAddressesResource.List(project: string; AQuery : string = '') : TAddressList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/addresses';
  _Methodid   = 'compute.globalAddresses.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TAddressList) as TAddressList;
end;


Function TGlobalAddressesResource.List(project: string; AQuery : TGlobalAddresseslistOptions) : TAddressList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TGlobalForwardingRulesResource
  --------------------------------------------------------------------}


Class Function TGlobalForwardingRulesResource.ResourceName : String;

begin
  Result:='globalForwardingRules';
end;

Class Function TGlobalForwardingRulesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TGlobalForwardingRulesResource.Delete(forwardingRule: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/forwardingRules/{forwardingRule}';
  _Methodid   = 'compute.globalForwardingRules.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['forwardingRule',forwardingRule,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TGlobalForwardingRulesResource.Get(forwardingRule: string; project: string) : TForwardingRule;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/forwardingRules/{forwardingRule}';
  _Methodid   = 'compute.globalForwardingRules.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['forwardingRule',forwardingRule,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TForwardingRule) as TForwardingRule;
end;

Function TGlobalForwardingRulesResource.Insert(project: string; aForwardingRule : TForwardingRule) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/forwardingRules';
  _Methodid   = 'compute.globalForwardingRules.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aForwardingRule,TOperation) as TOperation;
end;

Function TGlobalForwardingRulesResource.List(project: string; AQuery : string = '') : TForwardingRuleList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/forwardingRules';
  _Methodid   = 'compute.globalForwardingRules.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TForwardingRuleList) as TForwardingRuleList;
end;


Function TGlobalForwardingRulesResource.List(project: string; AQuery : TGlobalForwardingRuleslistOptions) : TForwardingRuleList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function TGlobalForwardingRulesResource.SetTarget(forwardingRule: string; project: string; aTargetReference : TTargetReference) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/forwardingRules/{forwardingRule}/setTarget';
  _Methodid   = 'compute.globalForwardingRules.setTarget';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['forwardingRule',forwardingRule,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetReference,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TGlobalOperationsResource
  --------------------------------------------------------------------}


Class Function TGlobalOperationsResource.ResourceName : String;

begin
  Result:='globalOperations';
end;

Class Function TGlobalOperationsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TGlobalOperationsResource.AggregatedList(project: string; AQuery : string = '') : TOperationAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/operations';
  _Methodid   = 'compute.globalOperations.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperationAggregatedList) as TOperationAggregatedList;
end;


Function TGlobalOperationsResource.AggregatedList(project: string; AQuery : TGlobalOperationsaggregatedListOptions) : TOperationAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Procedure TGlobalOperationsResource.Delete(operation: string; project: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/operations/{operation}';
  _Methodid   = 'compute.globalOperations.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['operation',operation,'project',project]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TGlobalOperationsResource.Get(operation: string; project: string) : TOperation;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/operations/{operation}';
  _Methodid   = 'compute.globalOperations.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['operation',operation,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TGlobalOperationsResource.List(project: string; AQuery : string = '') : TOperationList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/operations';
  _Methodid   = 'compute.globalOperations.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperationList) as TOperationList;
end;


Function TGlobalOperationsResource.List(project: string; AQuery : TGlobalOperationslistOptions) : TOperationList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  THttpHealthChecksResource
  --------------------------------------------------------------------}


Class Function THttpHealthChecksResource.ResourceName : String;

begin
  Result:='httpHealthChecks';
end;

Class Function THttpHealthChecksResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function THttpHealthChecksResource.Delete(httpHealthCheck: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/httpHealthChecks/{httpHealthCheck}';
  _Methodid   = 'compute.httpHealthChecks.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpHealthCheck',httpHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function THttpHealthChecksResource.Get(httpHealthCheck: string; project: string) : THttpHealthCheck;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/httpHealthChecks/{httpHealthCheck}';
  _Methodid   = 'compute.httpHealthChecks.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpHealthCheck',httpHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,THttpHealthCheck) as THttpHealthCheck;
end;

Function THttpHealthChecksResource.Insert(project: string; aHttpHealthCheck : THttpHealthCheck) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/httpHealthChecks';
  _Methodid   = 'compute.httpHealthChecks.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aHttpHealthCheck,TOperation) as TOperation;
end;

Function THttpHealthChecksResource.List(project: string; AQuery : string = '') : THttpHealthCheckList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/httpHealthChecks';
  _Methodid   = 'compute.httpHealthChecks.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,THttpHealthCheckList) as THttpHealthCheckList;
end;


Function THttpHealthChecksResource.List(project: string; AQuery : THttpHealthCheckslistOptions) : THttpHealthCheckList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function THttpHealthChecksResource.Patch(httpHealthCheck: string; project: string; aHttpHealthCheck : THttpHealthCheck) : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = '{project}/global/httpHealthChecks/{httpHealthCheck}';
  _Methodid   = 'compute.httpHealthChecks.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpHealthCheck',httpHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aHttpHealthCheck,TOperation) as TOperation;
end;

Function THttpHealthChecksResource.Update(httpHealthCheck: string; project: string; aHttpHealthCheck : THttpHealthCheck) : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = '{project}/global/httpHealthChecks/{httpHealthCheck}';
  _Methodid   = 'compute.httpHealthChecks.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpHealthCheck',httpHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aHttpHealthCheck,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  THttpsHealthChecksResource
  --------------------------------------------------------------------}


Class Function THttpsHealthChecksResource.ResourceName : String;

begin
  Result:='httpsHealthChecks';
end;

Class Function THttpsHealthChecksResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function THttpsHealthChecksResource.Delete(httpsHealthCheck: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/httpsHealthChecks/{httpsHealthCheck}';
  _Methodid   = 'compute.httpsHealthChecks.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpsHealthCheck',httpsHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function THttpsHealthChecksResource.Get(httpsHealthCheck: string; project: string) : THttpsHealthCheck;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/httpsHealthChecks/{httpsHealthCheck}';
  _Methodid   = 'compute.httpsHealthChecks.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpsHealthCheck',httpsHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,THttpsHealthCheck) as THttpsHealthCheck;
end;

Function THttpsHealthChecksResource.Insert(project: string; aHttpsHealthCheck : THttpsHealthCheck) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/httpsHealthChecks';
  _Methodid   = 'compute.httpsHealthChecks.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aHttpsHealthCheck,TOperation) as TOperation;
end;

Function THttpsHealthChecksResource.List(project: string; AQuery : string = '') : THttpsHealthCheckList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/httpsHealthChecks';
  _Methodid   = 'compute.httpsHealthChecks.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,THttpsHealthCheckList) as THttpsHealthCheckList;
end;


Function THttpsHealthChecksResource.List(project: string; AQuery : THttpsHealthCheckslistOptions) : THttpsHealthCheckList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function THttpsHealthChecksResource.Patch(httpsHealthCheck: string; project: string; aHttpsHealthCheck : THttpsHealthCheck) : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = '{project}/global/httpsHealthChecks/{httpsHealthCheck}';
  _Methodid   = 'compute.httpsHealthChecks.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpsHealthCheck',httpsHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aHttpsHealthCheck,TOperation) as TOperation;
end;

Function THttpsHealthChecksResource.Update(httpsHealthCheck: string; project: string; aHttpsHealthCheck : THttpsHealthCheck) : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = '{project}/global/httpsHealthChecks/{httpsHealthCheck}';
  _Methodid   = 'compute.httpsHealthChecks.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['httpsHealthCheck',httpsHealthCheck,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aHttpsHealthCheck,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TImagesResource
  --------------------------------------------------------------------}


Class Function TImagesResource.ResourceName : String;

begin
  Result:='images';
end;

Class Function TImagesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TImagesResource.Delete(image: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/images/{image}';
  _Methodid   = 'compute.images.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['image',image,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TImagesResource.Deprecate(image: string; project: string; aDeprecationStatus : TDeprecationStatus) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/images/{image}/deprecate';
  _Methodid   = 'compute.images.deprecate';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['image',image,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDeprecationStatus,TOperation) as TOperation;
end;

Function TImagesResource.Get(image: string; project: string) : TImage;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/images/{image}';
  _Methodid   = 'compute.images.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['image',image,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TImage) as TImage;
end;

Function TImagesResource.GetFromFamily(family: string; project: string) : TImage;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/images/family/{family}';
  _Methodid   = 'compute.images.getFromFamily';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['family',family,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TImage) as TImage;
end;

Function TImagesResource.Insert(project: string; aImage : TImage) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/images';
  _Methodid   = 'compute.images.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aImage,TOperation) as TOperation;
end;

Function TImagesResource.List(project: string; AQuery : string = '') : TImageList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/images';
  _Methodid   = 'compute.images.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TImageList) as TImageList;
end;


Function TImagesResource.List(project: string; AQuery : TImageslistOptions) : TImageList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TInstanceGroupManagersResource
  --------------------------------------------------------------------}


Class Function TInstanceGroupManagersResource.ResourceName : String;

begin
  Result:='instanceGroupManagers';
end;

Class Function TInstanceGroupManagersResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TInstanceGroupManagersResource.AbandonInstances(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersAbandonInstancesRequest : TInstanceGroupManagersAbandonInstancesRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}/abandonInstances';
  _Methodid   = 'compute.instanceGroupManagers.abandonInstances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupManagersAbandonInstancesRequest,TOperation) as TOperation;
end;

Function TInstanceGroupManagersResource.AggregatedList(project: string; AQuery : string = '') : TInstanceGroupManagerAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/instanceGroupManagers';
  _Methodid   = 'compute.instanceGroupManagers.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstanceGroupManagerAggregatedList) as TInstanceGroupManagerAggregatedList;
end;


Function TInstanceGroupManagersResource.AggregatedList(project: string; AQuery : TInstanceGroupManagersaggregatedListOptions) : TInstanceGroupManagerAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TInstanceGroupManagersResource.Delete(instanceGroupManager: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}';
  _Methodid   = 'compute.instanceGroupManagers.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstanceGroupManagersResource.DeleteInstances(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersDeleteInstancesRequest : TInstanceGroupManagersDeleteInstancesRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}/deleteInstances';
  _Methodid   = 'compute.instanceGroupManagers.deleteInstances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupManagersDeleteInstancesRequest,TOperation) as TOperation;
end;

Function TInstanceGroupManagersResource.Get(instanceGroupManager: string; project: string; zone: string) : TInstanceGroupManager;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}';
  _Methodid   = 'compute.instanceGroupManagers.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TInstanceGroupManager) as TInstanceGroupManager;
end;

Function TInstanceGroupManagersResource.Insert(project: string; zone: string; aInstanceGroupManager : TInstanceGroupManager) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers';
  _Methodid   = 'compute.instanceGroupManagers.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupManager,TOperation) as TOperation;
end;

Function TInstanceGroupManagersResource.List(project: string; zone: string; AQuery : string = '') : TInstanceGroupManagerList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers';
  _Methodid   = 'compute.instanceGroupManagers.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstanceGroupManagerList) as TInstanceGroupManagerList;
end;


Function TInstanceGroupManagersResource.List(project: string; zone: string; AQuery : TInstanceGroupManagerslistOptions) : TInstanceGroupManagerList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;

Function TInstanceGroupManagersResource.ListManagedInstances(instanceGroupManager: string; project: string; zone: string) : TInstanceGroupManagersListManagedInstancesResponse;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}/listManagedInstances';
  _Methodid   = 'compute.instanceGroupManagers.listManagedInstances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TInstanceGroupManagersListManagedInstancesResponse) as TInstanceGroupManagersListManagedInstancesResponse;
end;

Function TInstanceGroupManagersResource.RecreateInstances(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersRecreateInstancesRequest : TInstanceGroupManagersRecreateInstancesRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}/recreateInstances';
  _Methodid   = 'compute.instanceGroupManagers.recreateInstances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupManagersRecreateInstancesRequest,TOperation) as TOperation;
end;

Function TInstanceGroupManagersResource.Resize(instanceGroupManager: string; project: string; zone: string; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}/resize';
  _Methodid   = 'compute.instanceGroupManagers.resize';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperation) as TOperation;
end;


Function TInstanceGroupManagersResource.Resize(instanceGroupManager: string; project: string; zone: string; AQuery : TInstanceGroupManagersresizeOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'size',AQuery.size);
  Result:=Resize(instanceGroupManager,project,zone,_Q);
end;

Function TInstanceGroupManagersResource.SetInstanceTemplate(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersSetInstanceTemplateRequest : TInstanceGroupManagersSetInstanceTemplateRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}/setInstanceTemplate';
  _Methodid   = 'compute.instanceGroupManagers.setInstanceTemplate';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupManagersSetInstanceTemplateRequest,TOperation) as TOperation;
end;

Function TInstanceGroupManagersResource.SetTargetPools(instanceGroupManager: string; project: string; zone: string; aInstanceGroupManagersSetTargetPoolsRequest : TInstanceGroupManagersSetTargetPoolsRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroupManagers/{instanceGroupManager}/setTargetPools';
  _Methodid   = 'compute.instanceGroupManagers.setTargetPools';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroupManager',instanceGroupManager,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupManagersSetTargetPoolsRequest,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TInstanceGroupsResource
  --------------------------------------------------------------------}


Class Function TInstanceGroupsResource.ResourceName : String;

begin
  Result:='instanceGroups';
end;

Class Function TInstanceGroupsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TInstanceGroupsResource.AddInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsAddInstancesRequest : TInstanceGroupsAddInstancesRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroups/{instanceGroup}/addInstances';
  _Methodid   = 'compute.instanceGroups.addInstances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroup',instanceGroup,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupsAddInstancesRequest,TOperation) as TOperation;
end;

Function TInstanceGroupsResource.AggregatedList(project: string; AQuery : string = '') : TInstanceGroupAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/instanceGroups';
  _Methodid   = 'compute.instanceGroups.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstanceGroupAggregatedList) as TInstanceGroupAggregatedList;
end;


Function TInstanceGroupsResource.AggregatedList(project: string; AQuery : TInstanceGroupsaggregatedListOptions) : TInstanceGroupAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TInstanceGroupsResource.Delete(instanceGroup: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/zones/{zone}/instanceGroups/{instanceGroup}';
  _Methodid   = 'compute.instanceGroups.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroup',instanceGroup,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstanceGroupsResource.Get(instanceGroup: string; project: string; zone: string) : TInstanceGroup;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/instanceGroups/{instanceGroup}';
  _Methodid   = 'compute.instanceGroups.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroup',instanceGroup,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TInstanceGroup) as TInstanceGroup;
end;

Function TInstanceGroupsResource.Insert(project: string; zone: string; aInstanceGroup : TInstanceGroup) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroups';
  _Methodid   = 'compute.instanceGroups.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroup,TOperation) as TOperation;
end;

Function TInstanceGroupsResource.List(project: string; zone: string; AQuery : string = '') : TInstanceGroupList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/instanceGroups';
  _Methodid   = 'compute.instanceGroups.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstanceGroupList) as TInstanceGroupList;
end;


Function TInstanceGroupsResource.List(project: string; zone: string; AQuery : TInstanceGroupslistOptions) : TInstanceGroupList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;

Function TInstanceGroupsResource.ListInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsListInstancesRequest : TInstanceGroupsListInstancesRequest; AQuery : string = '') : TInstanceGroupsListInstances;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroups/{instanceGroup}/listInstances';
  _Methodid   = 'compute.instanceGroups.listInstances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroup',instanceGroup,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aInstanceGroupsListInstancesRequest,TInstanceGroupsListInstances) as TInstanceGroupsListInstances;
end;


Function TInstanceGroupsResource.ListInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsListInstancesRequest : TInstanceGroupsListInstancesRequest; AQuery : TInstanceGroupslistInstancesOptions) : TInstanceGroupsListInstances;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=ListInstances(instanceGroup,project,zone,aInstanceGroupsListInstancesRequest,_Q);
end;

Function TInstanceGroupsResource.RemoveInstances(instanceGroup: string; project: string; zone: string; aInstanceGroupsRemoveInstancesRequest : TInstanceGroupsRemoveInstancesRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroups/{instanceGroup}/removeInstances';
  _Methodid   = 'compute.instanceGroups.removeInstances';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroup',instanceGroup,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupsRemoveInstancesRequest,TOperation) as TOperation;
end;

Function TInstanceGroupsResource.SetNamedPorts(instanceGroup: string; project: string; zone: string; aInstanceGroupsSetNamedPortsRequest : TInstanceGroupsSetNamedPortsRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instanceGroups/{instanceGroup}/setNamedPorts';
  _Methodid   = 'compute.instanceGroups.setNamedPorts';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceGroup',instanceGroup,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceGroupsSetNamedPortsRequest,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TInstanceTemplatesResource
  --------------------------------------------------------------------}


Class Function TInstanceTemplatesResource.ResourceName : String;

begin
  Result:='instanceTemplates';
end;

Class Function TInstanceTemplatesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TInstanceTemplatesResource.Delete(instanceTemplate: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/instanceTemplates/{instanceTemplate}';
  _Methodid   = 'compute.instanceTemplates.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceTemplate',instanceTemplate,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstanceTemplatesResource.Get(instanceTemplate: string; project: string) : TInstanceTemplate;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/instanceTemplates/{instanceTemplate}';
  _Methodid   = 'compute.instanceTemplates.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instanceTemplate',instanceTemplate,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TInstanceTemplate) as TInstanceTemplate;
end;

Function TInstanceTemplatesResource.Insert(project: string; aInstanceTemplate : TInstanceTemplate) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/instanceTemplates';
  _Methodid   = 'compute.instanceTemplates.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceTemplate,TOperation) as TOperation;
end;

Function TInstanceTemplatesResource.List(project: string; AQuery : string = '') : TInstanceTemplateList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/instanceTemplates';
  _Methodid   = 'compute.instanceTemplates.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstanceTemplateList) as TInstanceTemplateList;
end;


Function TInstanceTemplatesResource.List(project: string; AQuery : TInstanceTemplateslistOptions) : TInstanceTemplateList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TInstancesResource
  --------------------------------------------------------------------}


Class Function TInstancesResource.ResourceName : String;

begin
  Result:='instances';
end;

Class Function TInstancesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TInstancesResource.AddAccessConfig(instance: string; project: string; zone: string; aAccessConfig : TAccessConfig; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/addAccessConfig';
  _Methodid   = 'compute.instances.addAccessConfig';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aAccessConfig,TOperation) as TOperation;
end;


Function TInstancesResource.AddAccessConfig(instance: string; project: string; zone: string; aAccessConfig : TAccessConfig; AQuery : TInstancesaddAccessConfigOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'networkInterface',AQuery.networkInterface);
  Result:=AddAccessConfig(instance,project,zone,aAccessConfig,_Q);
end;

Function TInstancesResource.AggregatedList(project: string; AQuery : string = '') : TInstanceAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/instances';
  _Methodid   = 'compute.instances.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstanceAggregatedList) as TInstanceAggregatedList;
end;


Function TInstancesResource.AggregatedList(project: string; AQuery : TInstancesaggregatedListOptions) : TInstanceAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TInstancesResource.AttachDisk(instance: string; project: string; zone: string; aAttachedDisk : TAttachedDisk) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/attachDisk';
  _Methodid   = 'compute.instances.attachDisk';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aAttachedDisk,TOperation) as TOperation;
end;

Function TInstancesResource.Delete(instance: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/zones/{zone}/instances/{instance}';
  _Methodid   = 'compute.instances.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.DeleteAccessConfig(instance: string; project: string; zone: string; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/deleteAccessConfig';
  _Methodid   = 'compute.instances.deleteAccessConfig';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperation) as TOperation;
end;


Function TInstancesResource.DeleteAccessConfig(instance: string; project: string; zone: string; AQuery : TInstancesdeleteAccessConfigOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'accessConfig',AQuery.accessConfig);
  AddToQuery(_Q,'networkInterface',AQuery.networkInterface);
  Result:=DeleteAccessConfig(instance,project,zone,_Q);
end;

Function TInstancesResource.DetachDisk(instance: string; project: string; zone: string; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/detachDisk';
  _Methodid   = 'compute.instances.detachDisk';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperation) as TOperation;
end;


Function TInstancesResource.DetachDisk(instance: string; project: string; zone: string; AQuery : TInstancesdetachDiskOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'deviceName',AQuery.deviceName);
  Result:=DetachDisk(instance,project,zone,_Q);
end;

Function TInstancesResource.Get(instance: string; project: string; zone: string) : TInstance;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/instances/{instance}';
  _Methodid   = 'compute.instances.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TInstance) as TInstance;
end;

Function TInstancesResource.GetSerialPortOutput(instance: string; project: string; zone: string; AQuery : string = '') : TSerialPortOutput;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/instances/{instance}/serialPort';
  _Methodid   = 'compute.instances.getSerialPortOutput';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TSerialPortOutput) as TSerialPortOutput;
end;


Function TInstancesResource.GetSerialPortOutput(instance: string; project: string; zone: string; AQuery : TInstancesgetSerialPortOutputOptions) : TSerialPortOutput;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'port',AQuery.port);
  Result:=GetSerialPortOutput(instance,project,zone,_Q);
end;

Function TInstancesResource.Insert(project: string; zone: string; aInstance : TInstance) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances';
  _Methodid   = 'compute.instances.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstance,TOperation) as TOperation;
end;

Function TInstancesResource.List(project: string; zone: string; AQuery : string = '') : TInstanceList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/instances';
  _Methodid   = 'compute.instances.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TInstanceList) as TInstanceList;
end;


Function TInstancesResource.List(project: string; zone: string; AQuery : TInstanceslistOptions) : TInstanceList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;

Function TInstancesResource.Reset(instance: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/reset';
  _Methodid   = 'compute.instances.reset';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.SetDiskAutoDelete(instance: string; project: string; zone: string; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/setDiskAutoDelete';
  _Methodid   = 'compute.instances.setDiskAutoDelete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperation) as TOperation;
end;


Function TInstancesResource.SetDiskAutoDelete(instance: string; project: string; zone: string; AQuery : TInstancessetDiskAutoDeleteOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'autoDelete',AQuery.autoDelete);
  AddToQuery(_Q,'deviceName',AQuery.deviceName);
  Result:=SetDiskAutoDelete(instance,project,zone,_Q);
end;

Function TInstancesResource.SetMachineType(instance: string; project: string; zone: string; aInstancesSetMachineTypeRequest : TInstancesSetMachineTypeRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/setMachineType';
  _Methodid   = 'compute.instances.setMachineType';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstancesSetMachineTypeRequest,TOperation) as TOperation;
end;

Function TInstancesResource.SetMetadata(instance: string; project: string; zone: string; aMetadata : TMetadata) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/setMetadata';
  _Methodid   = 'compute.instances.setMetadata';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aMetadata,TOperation) as TOperation;
end;

Function TInstancesResource.SetScheduling(instance: string; project: string; zone: string; aScheduling : TScheduling) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/setScheduling';
  _Methodid   = 'compute.instances.setScheduling';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aScheduling,TOperation) as TOperation;
end;

Function TInstancesResource.SetTags(instance: string; project: string; zone: string; aTags : TTags) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/setTags';
  _Methodid   = 'compute.instances.setTags';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTags,TOperation) as TOperation;
end;

Function TInstancesResource.Start(instance: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/start';
  _Methodid   = 'compute.instances.start';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TInstancesResource.Stop(instance: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/instances/{instance}/stop';
  _Methodid   = 'compute.instances.stop';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['instance',instance,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TLicensesResource
  --------------------------------------------------------------------}


Class Function TLicensesResource.ResourceName : String;

begin
  Result:='licenses';
end;

Class Function TLicensesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TLicensesResource.Get(license: string; project: string) : TLicense;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/licenses/{license}';
  _Methodid   = 'compute.licenses.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['license',license,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TLicense) as TLicense;
end;



{ --------------------------------------------------------------------
  TMachineTypesResource
  --------------------------------------------------------------------}


Class Function TMachineTypesResource.ResourceName : String;

begin
  Result:='machineTypes';
end;

Class Function TMachineTypesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TMachineTypesResource.AggregatedList(project: string; AQuery : string = '') : TMachineTypeAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/machineTypes';
  _Methodid   = 'compute.machineTypes.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TMachineTypeAggregatedList) as TMachineTypeAggregatedList;
end;


Function TMachineTypesResource.AggregatedList(project: string; AQuery : TMachineTypesaggregatedListOptions) : TMachineTypeAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TMachineTypesResource.Get(machineType: string; project: string; zone: string) : TMachineType;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/machineTypes/{machineType}';
  _Methodid   = 'compute.machineTypes.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['machineType',machineType,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TMachineType) as TMachineType;
end;

Function TMachineTypesResource.List(project: string; zone: string; AQuery : string = '') : TMachineTypeList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/machineTypes';
  _Methodid   = 'compute.machineTypes.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TMachineTypeList) as TMachineTypeList;
end;


Function TMachineTypesResource.List(project: string; zone: string; AQuery : TMachineTypeslistOptions) : TMachineTypeList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;



{ --------------------------------------------------------------------
  TNetworksResource
  --------------------------------------------------------------------}


Class Function TNetworksResource.ResourceName : String;

begin
  Result:='networks';
end;

Class Function TNetworksResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TNetworksResource.Delete(network: string; project: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/networks/{network}';
  _Methodid   = 'compute.networks.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['network',network,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TNetworksResource.Get(network: string; project: string) : TNetwork;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/networks/{network}';
  _Methodid   = 'compute.networks.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['network',network,'project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TNetwork) as TNetwork;
end;

Function TNetworksResource.Insert(project: string; aNetwork : TNetwork) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/networks';
  _Methodid   = 'compute.networks.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aNetwork,TOperation) as TOperation;
end;

Function TNetworksResource.List(project: string; AQuery : string = '') : TNetworkList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/networks';
  _Methodid   = 'compute.networks.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TNetworkList) as TNetworkList;
end;


Function TNetworksResource.List(project: string; AQuery : TNetworkslistOptions) : TNetworkList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TProjectsResource
  --------------------------------------------------------------------}


Class Function TProjectsResource.ResourceName : String;

begin
  Result:='projects';
end;

Class Function TProjectsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TProjectsResource.Get(project: string) : TProject;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}';
  _Methodid   = 'compute.projects.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TProject) as TProject;
end;

Function TProjectsResource.MoveDisk(project: string; aDiskMoveRequest : TDiskMoveRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/moveDisk';
  _Methodid   = 'compute.projects.moveDisk';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aDiskMoveRequest,TOperation) as TOperation;
end;

Function TProjectsResource.MoveInstance(project: string; aInstanceMoveRequest : TInstanceMoveRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/moveInstance';
  _Methodid   = 'compute.projects.moveInstance';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceMoveRequest,TOperation) as TOperation;
end;

Function TProjectsResource.SetCommonInstanceMetadata(project: string; aMetadata : TMetadata) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/setCommonInstanceMetadata';
  _Methodid   = 'compute.projects.setCommonInstanceMetadata';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aMetadata,TOperation) as TOperation;
end;

Function TProjectsResource.SetUsageExportBucket(project: string; aUsageExportLocation : TUsageExportLocation) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/setUsageExportBucket';
  _Methodid   = 'compute.projects.setUsageExportBucket';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUsageExportLocation,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TRegionOperationsResource
  --------------------------------------------------------------------}


Class Function TRegionOperationsResource.ResourceName : String;

begin
  Result:='regionOperations';
end;

Class Function TRegionOperationsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Procedure TRegionOperationsResource.Delete(operation: string; project: string; region: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/regions/{region}/operations/{operation}';
  _Methodid   = 'compute.regionOperations.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['operation',operation,'project',project,'region',region]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TRegionOperationsResource.Get(operation: string; project: string; region: string) : TOperation;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/operations/{operation}';
  _Methodid   = 'compute.regionOperations.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['operation',operation,'project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TRegionOperationsResource.List(project: string; region: string; AQuery : string = '') : TOperationList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/operations';
  _Methodid   = 'compute.regionOperations.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperationList) as TOperationList;
end;


Function TRegionOperationsResource.List(project: string; region: string; AQuery : TRegionOperationslistOptions) : TOperationList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,region,_Q);
end;



{ --------------------------------------------------------------------
  TRegionsResource
  --------------------------------------------------------------------}


Class Function TRegionsResource.ResourceName : String;

begin
  Result:='regions';
end;

Class Function TRegionsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TRegionsResource.Get(project: string; region: string) : TRegion;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}';
  _Methodid   = 'compute.regions.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TRegion) as TRegion;
end;

Function TRegionsResource.List(project: string; AQuery : string = '') : TRegionList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions';
  _Methodid   = 'compute.regions.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TRegionList) as TRegionList;
end;


Function TRegionsResource.List(project: string; AQuery : TRegionslistOptions) : TRegionList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TRoutesResource
  --------------------------------------------------------------------}


Class Function TRoutesResource.ResourceName : String;

begin
  Result:='routes';
end;

Class Function TRoutesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TRoutesResource.Delete(project: string; route: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/routes/{route}';
  _Methodid   = 'compute.routes.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'route',route]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TRoutesResource.Get(project: string; route: string) : TRoute;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/routes/{route}';
  _Methodid   = 'compute.routes.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'route',route]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TRoute) as TRoute;
end;

Function TRoutesResource.Insert(project: string; aRoute : TRoute) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/routes';
  _Methodid   = 'compute.routes.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aRoute,TOperation) as TOperation;
end;

Function TRoutesResource.List(project: string; AQuery : string = '') : TRouteList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/routes';
  _Methodid   = 'compute.routes.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TRouteList) as TRouteList;
end;


Function TRoutesResource.List(project: string; AQuery : TRouteslistOptions) : TRouteList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TSnapshotsResource
  --------------------------------------------------------------------}


Class Function TSnapshotsResource.ResourceName : String;

begin
  Result:='snapshots';
end;

Class Function TSnapshotsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TSnapshotsResource.Delete(project: string; snapshot: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/snapshots/{snapshot}';
  _Methodid   = 'compute.snapshots.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'snapshot',snapshot]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TSnapshotsResource.Get(project: string; snapshot: string) : TSnapshot;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/snapshots/{snapshot}';
  _Methodid   = 'compute.snapshots.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'snapshot',snapshot]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TSnapshot) as TSnapshot;
end;

Function TSnapshotsResource.List(project: string; AQuery : string = '') : TSnapshotList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/snapshots';
  _Methodid   = 'compute.snapshots.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TSnapshotList) as TSnapshotList;
end;


Function TSnapshotsResource.List(project: string; AQuery : TSnapshotslistOptions) : TSnapshotList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TSslCertificatesResource
  --------------------------------------------------------------------}


Class Function TSslCertificatesResource.ResourceName : String;

begin
  Result:='sslCertificates';
end;

Class Function TSslCertificatesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TSslCertificatesResource.Delete(project: string; sslCertificate: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/sslCertificates/{sslCertificate}';
  _Methodid   = 'compute.sslCertificates.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'sslCertificate',sslCertificate]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TSslCertificatesResource.Get(project: string; sslCertificate: string) : TSslCertificate;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/sslCertificates/{sslCertificate}';
  _Methodid   = 'compute.sslCertificates.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'sslCertificate',sslCertificate]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TSslCertificate) as TSslCertificate;
end;

Function TSslCertificatesResource.Insert(project: string; aSslCertificate : TSslCertificate) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/sslCertificates';
  _Methodid   = 'compute.sslCertificates.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aSslCertificate,TOperation) as TOperation;
end;

Function TSslCertificatesResource.List(project: string; AQuery : string = '') : TSslCertificateList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/sslCertificates';
  _Methodid   = 'compute.sslCertificates.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TSslCertificateList) as TSslCertificateList;
end;


Function TSslCertificatesResource.List(project: string; AQuery : TSslCertificateslistOptions) : TSslCertificateList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TSubnetworksResource
  --------------------------------------------------------------------}


Class Function TSubnetworksResource.ResourceName : String;

begin
  Result:='subnetworks';
end;

Class Function TSubnetworksResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TSubnetworksResource.AggregatedList(project: string; AQuery : string = '') : TSubnetworkAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/subnetworks';
  _Methodid   = 'compute.subnetworks.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TSubnetworkAggregatedList) as TSubnetworkAggregatedList;
end;


Function TSubnetworksResource.AggregatedList(project: string; AQuery : TSubnetworksaggregatedListOptions) : TSubnetworkAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TSubnetworksResource.Delete(project: string; region: string; subnetwork: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/regions/{region}/subnetworks/{subnetwork}';
  _Methodid   = 'compute.subnetworks.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'subnetwork',subnetwork]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TSubnetworksResource.Get(project: string; region: string; subnetwork: string) : TSubnetwork;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/subnetworks/{subnetwork}';
  _Methodid   = 'compute.subnetworks.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'subnetwork',subnetwork]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TSubnetwork) as TSubnetwork;
end;

Function TSubnetworksResource.Insert(project: string; region: string; aSubnetwork : TSubnetwork) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/subnetworks';
  _Methodid   = 'compute.subnetworks.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aSubnetwork,TOperation) as TOperation;
end;

Function TSubnetworksResource.List(project: string; region: string; AQuery : string = '') : TSubnetworkList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/subnetworks';
  _Methodid   = 'compute.subnetworks.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TSubnetworkList) as TSubnetworkList;
end;


Function TSubnetworksResource.List(project: string; region: string; AQuery : TSubnetworkslistOptions) : TSubnetworkList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,region,_Q);
end;



{ --------------------------------------------------------------------
  TTargetHttpProxiesResource
  --------------------------------------------------------------------}


Class Function TTargetHttpProxiesResource.ResourceName : String;

begin
  Result:='targetHttpProxies';
end;

Class Function TTargetHttpProxiesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TTargetHttpProxiesResource.Delete(project: string; targetHttpProxy: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/targetHttpProxies/{targetHttpProxy}';
  _Methodid   = 'compute.targetHttpProxies.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetHttpProxy',targetHttpProxy]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TTargetHttpProxiesResource.Get(project: string; targetHttpProxy: string) : TTargetHttpProxy;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/targetHttpProxies/{targetHttpProxy}';
  _Methodid   = 'compute.targetHttpProxies.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetHttpProxy',targetHttpProxy]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TTargetHttpProxy) as TTargetHttpProxy;
end;

Function TTargetHttpProxiesResource.Insert(project: string; aTargetHttpProxy : TTargetHttpProxy) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/targetHttpProxies';
  _Methodid   = 'compute.targetHttpProxies.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetHttpProxy,TOperation) as TOperation;
end;

Function TTargetHttpProxiesResource.List(project: string; AQuery : string = '') : TTargetHttpProxyList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/targetHttpProxies';
  _Methodid   = 'compute.targetHttpProxies.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetHttpProxyList) as TTargetHttpProxyList;
end;


Function TTargetHttpProxiesResource.List(project: string; AQuery : TTargetHttpProxieslistOptions) : TTargetHttpProxyList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function TTargetHttpProxiesResource.SetUrlMap(project: string; targetHttpProxy: string; aUrlMapReference : TUrlMapReference) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/targetHttpProxies/{targetHttpProxy}/setUrlMap';
  _Methodid   = 'compute.targetHttpProxies.setUrlMap';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetHttpProxy',targetHttpProxy]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUrlMapReference,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TTargetHttpsProxiesResource
  --------------------------------------------------------------------}


Class Function TTargetHttpsProxiesResource.ResourceName : String;

begin
  Result:='targetHttpsProxies';
end;

Class Function TTargetHttpsProxiesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TTargetHttpsProxiesResource.Delete(project: string; targetHttpsProxy: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/targetHttpsProxies/{targetHttpsProxy}';
  _Methodid   = 'compute.targetHttpsProxies.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetHttpsProxy',targetHttpsProxy]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TTargetHttpsProxiesResource.Get(project: string; targetHttpsProxy: string) : TTargetHttpsProxy;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/targetHttpsProxies/{targetHttpsProxy}';
  _Methodid   = 'compute.targetHttpsProxies.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetHttpsProxy',targetHttpsProxy]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TTargetHttpsProxy) as TTargetHttpsProxy;
end;

Function TTargetHttpsProxiesResource.Insert(project: string; aTargetHttpsProxy : TTargetHttpsProxy) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/targetHttpsProxies';
  _Methodid   = 'compute.targetHttpsProxies.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetHttpsProxy,TOperation) as TOperation;
end;

Function TTargetHttpsProxiesResource.List(project: string; AQuery : string = '') : TTargetHttpsProxyList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/targetHttpsProxies';
  _Methodid   = 'compute.targetHttpsProxies.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetHttpsProxyList) as TTargetHttpsProxyList;
end;


Function TTargetHttpsProxiesResource.List(project: string; AQuery : TTargetHttpsProxieslistOptions) : TTargetHttpsProxyList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function TTargetHttpsProxiesResource.SetSslCertificates(project: string; targetHttpsProxy: string; aTargetHttpsProxiesSetSslCertificatesRequest : TTargetHttpsProxiesSetSslCertificatesRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/targetHttpsProxies/{targetHttpsProxy}/setSslCertificates';
  _Methodid   = 'compute.targetHttpsProxies.setSslCertificates';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetHttpsProxy',targetHttpsProxy]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetHttpsProxiesSetSslCertificatesRequest,TOperation) as TOperation;
end;

Function TTargetHttpsProxiesResource.SetUrlMap(project: string; targetHttpsProxy: string; aUrlMapReference : TUrlMapReference) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/targetHttpsProxies/{targetHttpsProxy}/setUrlMap';
  _Methodid   = 'compute.targetHttpsProxies.setUrlMap';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetHttpsProxy',targetHttpsProxy]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUrlMapReference,TOperation) as TOperation;
end;



{ --------------------------------------------------------------------
  TTargetInstancesResource
  --------------------------------------------------------------------}


Class Function TTargetInstancesResource.ResourceName : String;

begin
  Result:='targetInstances';
end;

Class Function TTargetInstancesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TTargetInstancesResource.AggregatedList(project: string; AQuery : string = '') : TTargetInstanceAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/targetInstances';
  _Methodid   = 'compute.targetInstances.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetInstanceAggregatedList) as TTargetInstanceAggregatedList;
end;


Function TTargetInstancesResource.AggregatedList(project: string; AQuery : TTargetInstancesaggregatedListOptions) : TTargetInstanceAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TTargetInstancesResource.Delete(project: string; targetInstance: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/zones/{zone}/targetInstances/{targetInstance}';
  _Methodid   = 'compute.targetInstances.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetInstance',targetInstance,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TTargetInstancesResource.Get(project: string; targetInstance: string; zone: string) : TTargetInstance;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/targetInstances/{targetInstance}';
  _Methodid   = 'compute.targetInstances.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'targetInstance',targetInstance,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TTargetInstance) as TTargetInstance;
end;

Function TTargetInstancesResource.Insert(project: string; zone: string; aTargetInstance : TTargetInstance) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/zones/{zone}/targetInstances';
  _Methodid   = 'compute.targetInstances.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetInstance,TOperation) as TOperation;
end;

Function TTargetInstancesResource.List(project: string; zone: string; AQuery : string = '') : TTargetInstanceList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/targetInstances';
  _Methodid   = 'compute.targetInstances.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetInstanceList) as TTargetInstanceList;
end;


Function TTargetInstancesResource.List(project: string; zone: string; AQuery : TTargetInstanceslistOptions) : TTargetInstanceList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;



{ --------------------------------------------------------------------
  TTargetPoolsResource
  --------------------------------------------------------------------}


Class Function TTargetPoolsResource.ResourceName : String;

begin
  Result:='targetPools';
end;

Class Function TTargetPoolsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TTargetPoolsResource.AddHealthCheck(project: string; region: string; targetPool: string; aTargetPoolsAddHealthCheckRequest : TTargetPoolsAddHealthCheckRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}/addHealthCheck';
  _Methodid   = 'compute.targetPools.addHealthCheck';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetPoolsAddHealthCheckRequest,TOperation) as TOperation;
end;

Function TTargetPoolsResource.AddInstance(project: string; region: string; targetPool: string; aTargetPoolsAddInstanceRequest : TTargetPoolsAddInstanceRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}/addInstance';
  _Methodid   = 'compute.targetPools.addInstance';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetPoolsAddInstanceRequest,TOperation) as TOperation;
end;

Function TTargetPoolsResource.AggregatedList(project: string; AQuery : string = '') : TTargetPoolAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/targetPools';
  _Methodid   = 'compute.targetPools.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetPoolAggregatedList) as TTargetPoolAggregatedList;
end;


Function TTargetPoolsResource.AggregatedList(project: string; AQuery : TTargetPoolsaggregatedListOptions) : TTargetPoolAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TTargetPoolsResource.Delete(project: string; region: string; targetPool: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}';
  _Methodid   = 'compute.targetPools.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TTargetPoolsResource.Get(project: string; region: string; targetPool: string) : TTargetPool;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}';
  _Methodid   = 'compute.targetPools.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TTargetPool) as TTargetPool;
end;

Function TTargetPoolsResource.GetHealth(project: string; region: string; targetPool: string; aInstanceReference : TInstanceReference) : TTargetPoolInstanceHealth;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}/getHealth';
  _Methodid   = 'compute.targetPools.getHealth';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aInstanceReference,TTargetPoolInstanceHealth) as TTargetPoolInstanceHealth;
end;

Function TTargetPoolsResource.Insert(project: string; region: string; aTargetPool : TTargetPool) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetPools';
  _Methodid   = 'compute.targetPools.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetPool,TOperation) as TOperation;
end;

Function TTargetPoolsResource.List(project: string; region: string; AQuery : string = '') : TTargetPoolList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/targetPools';
  _Methodid   = 'compute.targetPools.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetPoolList) as TTargetPoolList;
end;


Function TTargetPoolsResource.List(project: string; region: string; AQuery : TTargetPoolslistOptions) : TTargetPoolList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,region,_Q);
end;

Function TTargetPoolsResource.RemoveHealthCheck(project: string; region: string; targetPool: string; aTargetPoolsRemoveHealthCheckRequest : TTargetPoolsRemoveHealthCheckRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}/removeHealthCheck';
  _Methodid   = 'compute.targetPools.removeHealthCheck';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetPoolsRemoveHealthCheckRequest,TOperation) as TOperation;
end;

Function TTargetPoolsResource.RemoveInstance(project: string; region: string; targetPool: string; aTargetPoolsRemoveInstanceRequest : TTargetPoolsRemoveInstanceRequest) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}/removeInstance';
  _Methodid   = 'compute.targetPools.removeInstance';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetPoolsRemoveInstanceRequest,TOperation) as TOperation;
end;

Function TTargetPoolsResource.SetBackup(project: string; region: string; targetPool: string; aTargetReference : TTargetReference; AQuery : string = '') : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetPools/{targetPool}/setBackup';
  _Methodid   = 'compute.targetPools.setBackup';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetPool',targetPool]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,aTargetReference,TOperation) as TOperation;
end;


Function TTargetPoolsResource.SetBackup(project: string; region: string; targetPool: string; aTargetReference : TTargetReference; AQuery : TTargetPoolssetBackupOptions) : TOperation;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'failoverRatio',AQuery.failoverRatio);
  Result:=SetBackup(project,region,targetPool,aTargetReference,_Q);
end;



{ --------------------------------------------------------------------
  TTargetVpnGatewaysResource
  --------------------------------------------------------------------}


Class Function TTargetVpnGatewaysResource.ResourceName : String;

begin
  Result:='targetVpnGateways';
end;

Class Function TTargetVpnGatewaysResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TTargetVpnGatewaysResource.AggregatedList(project: string; AQuery : string = '') : TTargetVpnGatewayAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/targetVpnGateways';
  _Methodid   = 'compute.targetVpnGateways.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetVpnGatewayAggregatedList) as TTargetVpnGatewayAggregatedList;
end;


Function TTargetVpnGatewaysResource.AggregatedList(project: string; AQuery : TTargetVpnGatewaysaggregatedListOptions) : TTargetVpnGatewayAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TTargetVpnGatewaysResource.Delete(project: string; region: string; targetVpnGateway: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/regions/{region}/targetVpnGateways/{targetVpnGateway}';
  _Methodid   = 'compute.targetVpnGateways.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetVpnGateway',targetVpnGateway]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TTargetVpnGatewaysResource.Get(project: string; region: string; targetVpnGateway: string) : TTargetVpnGateway;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/targetVpnGateways/{targetVpnGateway}';
  _Methodid   = 'compute.targetVpnGateways.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'targetVpnGateway',targetVpnGateway]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TTargetVpnGateway) as TTargetVpnGateway;
end;

Function TTargetVpnGatewaysResource.Insert(project: string; region: string; aTargetVpnGateway : TTargetVpnGateway) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/targetVpnGateways';
  _Methodid   = 'compute.targetVpnGateways.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aTargetVpnGateway,TOperation) as TOperation;
end;

Function TTargetVpnGatewaysResource.List(project: string; region: string; AQuery : string = '') : TTargetVpnGatewayList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/targetVpnGateways';
  _Methodid   = 'compute.targetVpnGateways.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TTargetVpnGatewayList) as TTargetVpnGatewayList;
end;


Function TTargetVpnGatewaysResource.List(project: string; region: string; AQuery : TTargetVpnGatewayslistOptions) : TTargetVpnGatewayList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,region,_Q);
end;



{ --------------------------------------------------------------------
  TUrlMapsResource
  --------------------------------------------------------------------}


Class Function TUrlMapsResource.ResourceName : String;

begin
  Result:='urlMaps';
end;

Class Function TUrlMapsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TUrlMapsResource.Delete(project: string; urlMap: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/global/urlMaps/{urlMap}';
  _Methodid   = 'compute.urlMaps.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'urlMap',urlMap]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TUrlMapsResource.Get(project: string; urlMap: string) : TUrlMap;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/urlMaps/{urlMap}';
  _Methodid   = 'compute.urlMaps.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'urlMap',urlMap]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TUrlMap) as TUrlMap;
end;

Function TUrlMapsResource.Insert(project: string; aUrlMap : TUrlMap) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/urlMaps';
  _Methodid   = 'compute.urlMaps.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUrlMap,TOperation) as TOperation;
end;

Function TUrlMapsResource.List(project: string; AQuery : string = '') : TUrlMapList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/global/urlMaps';
  _Methodid   = 'compute.urlMaps.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TUrlMapList) as TUrlMapList;
end;


Function TUrlMapsResource.List(project: string; AQuery : TUrlMapslistOptions) : TUrlMapList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;

Function TUrlMapsResource.Patch(project: string; urlMap: string; aUrlMap : TUrlMap) : TOperation;

Const
  _HTTPMethod = 'PATCH';
  _Path       = '{project}/global/urlMaps/{urlMap}';
  _Methodid   = 'compute.urlMaps.patch';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'urlMap',urlMap]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUrlMap,TOperation) as TOperation;
end;

Function TUrlMapsResource.Update(project: string; urlMap: string; aUrlMap : TUrlMap) : TOperation;

Const
  _HTTPMethod = 'PUT';
  _Path       = '{project}/global/urlMaps/{urlMap}';
  _Methodid   = 'compute.urlMaps.update';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'urlMap',urlMap]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUrlMap,TOperation) as TOperation;
end;

Function TUrlMapsResource.Validate(project: string; urlMap: string; aUrlMapsValidateRequest : TUrlMapsValidateRequest) : TUrlMapsValidateResponse;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/global/urlMaps/{urlMap}/validate';
  _Methodid   = 'compute.urlMaps.validate';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'urlMap',urlMap]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aUrlMapsValidateRequest,TUrlMapsValidateResponse) as TUrlMapsValidateResponse;
end;



{ --------------------------------------------------------------------
  TVpnTunnelsResource
  --------------------------------------------------------------------}


Class Function TVpnTunnelsResource.ResourceName : String;

begin
  Result:='vpnTunnels';
end;

Class Function TVpnTunnelsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TVpnTunnelsResource.AggregatedList(project: string; AQuery : string = '') : TVpnTunnelAggregatedList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/aggregated/vpnTunnels';
  _Methodid   = 'compute.vpnTunnels.aggregatedList';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TVpnTunnelAggregatedList) as TVpnTunnelAggregatedList;
end;


Function TVpnTunnelsResource.AggregatedList(project: string; AQuery : TVpnTunnelsaggregatedListOptions) : TVpnTunnelAggregatedList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=AggregatedList(project,_Q);
end;

Function TVpnTunnelsResource.Delete(project: string; region: string; vpnTunnel: string) : TOperation;

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/regions/{region}/vpnTunnels/{vpnTunnel}';
  _Methodid   = 'compute.vpnTunnels.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'vpnTunnel',vpnTunnel]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TVpnTunnelsResource.Get(project: string; region: string; vpnTunnel: string) : TVpnTunnel;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/vpnTunnels/{vpnTunnel}';
  _Methodid   = 'compute.vpnTunnels.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region,'vpnTunnel',vpnTunnel]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TVpnTunnel) as TVpnTunnel;
end;

Function TVpnTunnelsResource.Insert(project: string; region: string; aVpnTunnel : TVpnTunnel) : TOperation;

Const
  _HTTPMethod = 'POST';
  _Path       = '{project}/regions/{region}/vpnTunnels';
  _Methodid   = 'compute.vpnTunnels.insert';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,'',aVpnTunnel,TOperation) as TOperation;
end;

Function TVpnTunnelsResource.List(project: string; region: string; AQuery : string = '') : TVpnTunnelList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/regions/{region}/vpnTunnels';
  _Methodid   = 'compute.vpnTunnels.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'region',region]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TVpnTunnelList) as TVpnTunnelList;
end;


Function TVpnTunnelsResource.List(project: string; region: string; AQuery : TVpnTunnelslistOptions) : TVpnTunnelList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,region,_Q);
end;



{ --------------------------------------------------------------------
  TZoneOperationsResource
  --------------------------------------------------------------------}


Class Function TZoneOperationsResource.ResourceName : String;

begin
  Result:='zoneOperations';
end;

Class Function TZoneOperationsResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Procedure TZoneOperationsResource.Delete(operation: string; project: string; zone: string);

Const
  _HTTPMethod = 'DELETE';
  _Path       = '{project}/zones/{zone}/operations/{operation}';
  _Methodid   = 'compute.zoneOperations.delete';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['operation',operation,'project',project,'zone',zone]);
  ServiceCall(_HTTPMethod,_P,'',Nil,Nil);
end;

Function TZoneOperationsResource.Get(operation: string; project: string; zone: string) : TOperation;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/operations/{operation}';
  _Methodid   = 'compute.zoneOperations.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['operation',operation,'project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TOperation) as TOperation;
end;

Function TZoneOperationsResource.List(project: string; zone: string; AQuery : string = '') : TOperationList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}/operations';
  _Methodid   = 'compute.zoneOperations.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TOperationList) as TOperationList;
end;


Function TZoneOperationsResource.List(project: string; zone: string; AQuery : TZoneOperationslistOptions) : TOperationList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,zone,_Q);
end;



{ --------------------------------------------------------------------
  TZonesResource
  --------------------------------------------------------------------}


Class Function TZonesResource.ResourceName : String;

begin
  Result:='zones';
end;

Class Function TZonesResource.DefaultAPI : TGoogleAPIClass;

begin
  Result:=TcomputeAPI;
end;

Function TZonesResource.Get(project: string; zone: string) : TZone;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones/{zone}';
  _Methodid   = 'compute.zones.get';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project,'zone',zone]);
  Result:=ServiceCall(_HTTPMethod,_P,'',Nil,TZone) as TZone;
end;

Function TZonesResource.List(project: string; AQuery : string = '') : TZoneList;

Const
  _HTTPMethod = 'GET';
  _Path       = '{project}/zones';
  _Methodid   = 'compute.zones.list';

Var
  _P : String;

begin
  _P:=SubstitutePath(_Path,['project',project]);
  Result:=ServiceCall(_HTTPMethod,_P,AQuery,Nil,TZoneList) as TZoneList;
end;


Function TZonesResource.List(project: string; AQuery : TZoneslistOptions) : TZoneList;

Var
  _Q : String;

begin
  _Q:='';
  AddToQuery(_Q,'filter',AQuery.filter);
  AddToQuery(_Q,'maxResults',AQuery.maxResults);
  AddToQuery(_Q,'pageToken',AQuery.pageToken);
  Result:=List(project,_Q);
end;



{ --------------------------------------------------------------------
  TComputeAPI
  --------------------------------------------------------------------}

Class Function TComputeAPI.APIName : String;

begin
  Result:='compute';
end;

Class Function TComputeAPI.APIVersion : String;

begin
  Result:='v1';
end;

Class Function TComputeAPI.APIRevision : String;

begin
  Result:='20160509';
end;

Class Function TComputeAPI.APIID : String;

begin
  Result:='compute:v1';
end;

Class Function TComputeAPI.APITitle : String;

begin
  Result:='Compute Engine API';
end;

Class Function TComputeAPI.APIDescription : String;

begin
  Result:='Creates and runs virtual machines on Google Cloud Platform.';
end;

Class Function TComputeAPI.APIOwnerDomain : String;

begin
  Result:='google.com';
end;

Class Function TComputeAPI.APIOwnerName : String;

begin
  Result:='Google';
end;

Class Function TComputeAPI.APIIcon16 : String;

begin
  Result:='https://www.google.com/images/icons/product/compute_engine-16.png';
end;

Class Function TComputeAPI.APIIcon32 : String;

begin
  Result:='https://www.google.com/images/icons/product/compute_engine-32.png';
end;

Class Function TComputeAPI.APIdocumentationLink : String;

begin
  Result:='https://developers.google.com/compute/docs/reference/latest/';
end;

Class Function TComputeAPI.APIrootUrl : string;

begin
  Result:='https://www.googleapis.com/';
end;

Class Function TComputeAPI.APIbasePath : string;

begin
  Result:='/compute/v1/projects/';
end;

Class Function TComputeAPI.APIbaseURL : String;

begin
  Result:='https://www.googleapis.com/compute/v1/projects/';
end;

Class Function TComputeAPI.APIProtocol : string;

begin
  Result:='rest';
end;

Class Function TComputeAPI.APIservicePath : string;

begin
  Result:='compute/v1/projects/';
end;

Class Function TComputeAPI.APIbatchPath : String;

begin
  Result:='batch';
end;

Class Function TComputeAPI.APIAuthScopes : TScopeInfoArray;

begin
  SetLength(Result,6);
  Result[0].Name:='https://www.googleapis.com/auth/cloud-platform';
  Result[0].Description:='View and manage your data across Google Cloud Platform services';
  Result[1].Name:='https://www.googleapis.com/auth/compute';
  Result[1].Description:='View and manage your Google Compute Engine resources';
  Result[2].Name:='https://www.googleapis.com/auth/compute.readonly';
  Result[2].Description:='View your Google Compute Engine resources';
  Result[3].Name:='https://www.googleapis.com/auth/devstorage.full_control';
  Result[3].Description:='Manage your data and permissions in Google Cloud Storage';
  Result[4].Name:='https://www.googleapis.com/auth/devstorage.read_only';
  Result[4].Description:='View your data in Google Cloud Storage';
  Result[5].Name:='https://www.googleapis.com/auth/devstorage.read_write';
  Result[5].Description:='Manage your data in Google Cloud Storage';
  
end;

Class Function TComputeAPI.APINeedsAuth : Boolean;

begin
  Result:=True;
end;

Class Procedure TComputeAPI.RegisterAPIResources;

begin
  TAccessConfig.RegisterObject;
  TAddress.RegisterObject;
  TAddressAggregatedListTypeitems.RegisterObject;
  TAddressAggregatedList.RegisterObject;
  TAddressList.RegisterObject;
  TAddressesScopedListTypewarningTypedataItem.RegisterObject;
  TAddressesScopedListTypewarning.RegisterObject;
  TAddressesScopedList.RegisterObject;
  TAttachedDisk.RegisterObject;
  TAttachedDiskInitializeParams.RegisterObject;
  TAutoscaler.RegisterObject;
  TAutoscalerAggregatedListTypeitems.RegisterObject;
  TAutoscalerAggregatedList.RegisterObject;
  TAutoscalerList.RegisterObject;
  TAutoscalersScopedListTypewarningTypedataItem.RegisterObject;
  TAutoscalersScopedListTypewarning.RegisterObject;
  TAutoscalersScopedList.RegisterObject;
  TAutoscalingPolicy.RegisterObject;
  TAutoscalingPolicyCpuUtilization.RegisterObject;
  TAutoscalingPolicyCustomMetricUtilization.RegisterObject;
  TAutoscalingPolicyLoadBalancingUtilization.RegisterObject;
  TBackend.RegisterObject;
  TBackendService.RegisterObject;
  TBackendServiceGroupHealth.RegisterObject;
  TBackendServiceList.RegisterObject;
  TDeprecationStatus.RegisterObject;
  TDisk.RegisterObject;
  TDiskAggregatedListTypeitems.RegisterObject;
  TDiskAggregatedList.RegisterObject;
  TDiskList.RegisterObject;
  TDiskMoveRequest.RegisterObject;
  TDiskType.RegisterObject;
  TDiskTypeAggregatedListTypeitems.RegisterObject;
  TDiskTypeAggregatedList.RegisterObject;
  TDiskTypeList.RegisterObject;
  TDiskTypesScopedListTypewarningTypedataItem.RegisterObject;
  TDiskTypesScopedListTypewarning.RegisterObject;
  TDiskTypesScopedList.RegisterObject;
  TDisksResizeRequest.RegisterObject;
  TDisksScopedListTypewarningTypedataItem.RegisterObject;
  TDisksScopedListTypewarning.RegisterObject;
  TDisksScopedList.RegisterObject;
  TFirewallTypeallowedItem.RegisterObject;
  TFirewall.RegisterObject;
  TFirewallList.RegisterObject;
  TForwardingRule.RegisterObject;
  TForwardingRuleAggregatedListTypeitems.RegisterObject;
  TForwardingRuleAggregatedList.RegisterObject;
  TForwardingRuleList.RegisterObject;
  TForwardingRulesScopedListTypewarningTypedataItem.RegisterObject;
  TForwardingRulesScopedListTypewarning.RegisterObject;
  TForwardingRulesScopedList.RegisterObject;
  THealthCheckReference.RegisterObject;
  THealthStatus.RegisterObject;
  THostRule.RegisterObject;
  THttpHealthCheck.RegisterObject;
  THttpHealthCheckList.RegisterObject;
  THttpsHealthCheck.RegisterObject;
  THttpsHealthCheckList.RegisterObject;
  TImageTyperawDisk.RegisterObject;
  TImage.RegisterObject;
  TImageList.RegisterObject;
  TInstance.RegisterObject;
  TInstanceAggregatedListTypeitems.RegisterObject;
  TInstanceAggregatedList.RegisterObject;
  TInstanceGroup.RegisterObject;
  TInstanceGroupAggregatedListTypeitems.RegisterObject;
  TInstanceGroupAggregatedList.RegisterObject;
  TInstanceGroupList.RegisterObject;
  TInstanceGroupManager.RegisterObject;
  TInstanceGroupManagerActionsSummary.RegisterObject;
  TInstanceGroupManagerAggregatedListTypeitems.RegisterObject;
  TInstanceGroupManagerAggregatedList.RegisterObject;
  TInstanceGroupManagerList.RegisterObject;
  TInstanceGroupManagersAbandonInstancesRequest.RegisterObject;
  TInstanceGroupManagersDeleteInstancesRequest.RegisterObject;
  TInstanceGroupManagersListManagedInstancesResponse.RegisterObject;
  TInstanceGroupManagersRecreateInstancesRequest.RegisterObject;
  TInstanceGroupManagersScopedListTypewarningTypedataItem.RegisterObject;
  TInstanceGroupManagersScopedListTypewarning.RegisterObject;
  TInstanceGroupManagersScopedList.RegisterObject;
  TInstanceGroupManagersSetInstanceTemplateRequest.RegisterObject;
  TInstanceGroupManagersSetTargetPoolsRequest.RegisterObject;
  TInstanceGroupsAddInstancesRequest.RegisterObject;
  TInstanceGroupsListInstances.RegisterObject;
  TInstanceGroupsListInstancesRequest.RegisterObject;
  TInstanceGroupsRemoveInstancesRequest.RegisterObject;
  TInstanceGroupsScopedListTypewarningTypedataItem.RegisterObject;
  TInstanceGroupsScopedListTypewarning.RegisterObject;
  TInstanceGroupsScopedList.RegisterObject;
  TInstanceGroupsSetNamedPortsRequest.RegisterObject;
  TInstanceList.RegisterObject;
  TInstanceMoveRequest.RegisterObject;
  TInstanceProperties.RegisterObject;
  TInstanceReference.RegisterObject;
  TInstanceTemplate.RegisterObject;
  TInstanceTemplateList.RegisterObject;
  TInstanceWithNamedPorts.RegisterObject;
  TInstancesScopedListTypewarningTypedataItem.RegisterObject;
  TInstancesScopedListTypewarning.RegisterObject;
  TInstancesScopedList.RegisterObject;
  TInstancesSetMachineTypeRequest.RegisterObject;
  TLicense.RegisterObject;
  TMachineTypeTypescratchDisksItem.RegisterObject;
  TMachineType.RegisterObject;
  TMachineTypeAggregatedListTypeitems.RegisterObject;
  TMachineTypeAggregatedList.RegisterObject;
  TMachineTypeList.RegisterObject;
  TMachineTypesScopedListTypewarningTypedataItem.RegisterObject;
  TMachineTypesScopedListTypewarning.RegisterObject;
  TMachineTypesScopedList.RegisterObject;
  TManagedInstance.RegisterObject;
  TManagedInstanceLastAttemptTypeerrorsTypeerrorsItem.RegisterObject;
  TManagedInstanceLastAttemptTypeerrors.RegisterObject;
  TManagedInstanceLastAttempt.RegisterObject;
  TMetadataTypeitemsItem.RegisterObject;
  TMetadata.RegisterObject;
  TNamedPort.RegisterObject;
  TNetwork.RegisterObject;
  TNetworkInterface.RegisterObject;
  TNetworkList.RegisterObject;
  TOperationTypeerrorTypeerrorsItem.RegisterObject;
  TOperationTypeerror.RegisterObject;
  TOperationTypewarningsItemTypedataItem.RegisterObject;
  TOperationTypewarningsItem.RegisterObject;
  TOperation.RegisterObject;
  TOperationAggregatedListTypeitems.RegisterObject;
  TOperationAggregatedList.RegisterObject;
  TOperationList.RegisterObject;
  TOperationsScopedListTypewarningTypedataItem.RegisterObject;
  TOperationsScopedListTypewarning.RegisterObject;
  TOperationsScopedList.RegisterObject;
  TPathMatcher.RegisterObject;
  TPathRule.RegisterObject;
  TProject.RegisterObject;
  TQuota.RegisterObject;
  TRegion.RegisterObject;
  TRegionList.RegisterObject;
  TResourceGroupReference.RegisterObject;
  TRouteTypewarningsItemTypedataItem.RegisterObject;
  TRouteTypewarningsItem.RegisterObject;
  TRoute.RegisterObject;
  TRouteList.RegisterObject;
  TScheduling.RegisterObject;
  TSerialPortOutput.RegisterObject;
  TServiceAccount.RegisterObject;
  TSnapshot.RegisterObject;
  TSnapshotList.RegisterObject;
  TSslCertificate.RegisterObject;
  TSslCertificateList.RegisterObject;
  TSubnetwork.RegisterObject;
  TSubnetworkAggregatedListTypeitems.RegisterObject;
  TSubnetworkAggregatedList.RegisterObject;
  TSubnetworkList.RegisterObject;
  TSubnetworksScopedListTypewarningTypedataItem.RegisterObject;
  TSubnetworksScopedListTypewarning.RegisterObject;
  TSubnetworksScopedList.RegisterObject;
  TTags.RegisterObject;
  TTargetHttpProxy.RegisterObject;
  TTargetHttpProxyList.RegisterObject;
  TTargetHttpsProxiesSetSslCertificatesRequest.RegisterObject;
  TTargetHttpsProxy.RegisterObject;
  TTargetHttpsProxyList.RegisterObject;
  TTargetInstance.RegisterObject;
  TTargetInstanceAggregatedListTypeitems.RegisterObject;
  TTargetInstanceAggregatedList.RegisterObject;
  TTargetInstanceList.RegisterObject;
  TTargetInstancesScopedListTypewarningTypedataItem.RegisterObject;
  TTargetInstancesScopedListTypewarning.RegisterObject;
  TTargetInstancesScopedList.RegisterObject;
  TTargetPool.RegisterObject;
  TTargetPoolAggregatedListTypeitems.RegisterObject;
  TTargetPoolAggregatedList.RegisterObject;
  TTargetPoolInstanceHealth.RegisterObject;
  TTargetPoolList.RegisterObject;
  TTargetPoolsAddHealthCheckRequest.RegisterObject;
  TTargetPoolsAddInstanceRequest.RegisterObject;
  TTargetPoolsRemoveHealthCheckRequest.RegisterObject;
  TTargetPoolsRemoveInstanceRequest.RegisterObject;
  TTargetPoolsScopedListTypewarningTypedataItem.RegisterObject;
  TTargetPoolsScopedListTypewarning.RegisterObject;
  TTargetPoolsScopedList.RegisterObject;
  TTargetReference.RegisterObject;
  TTargetVpnGateway.RegisterObject;
  TTargetVpnGatewayAggregatedListTypeitems.RegisterObject;
  TTargetVpnGatewayAggregatedList.RegisterObject;
  TTargetVpnGatewayList.RegisterObject;
  TTargetVpnGatewaysScopedListTypewarningTypedataItem.RegisterObject;
  TTargetVpnGatewaysScopedListTypewarning.RegisterObject;
  TTargetVpnGatewaysScopedList.RegisterObject;
  TTestFailure.RegisterObject;
  TUrlMap.RegisterObject;
  TUrlMapList.RegisterObject;
  TUrlMapReference.RegisterObject;
  TUrlMapTest.RegisterObject;
  TUrlMapValidationResult.RegisterObject;
  TUrlMapsValidateRequest.RegisterObject;
  TUrlMapsValidateResponse.RegisterObject;
  TUsageExportLocation.RegisterObject;
  TVpnTunnel.RegisterObject;
  TVpnTunnelAggregatedListTypeitems.RegisterObject;
  TVpnTunnelAggregatedList.RegisterObject;
  TVpnTunnelList.RegisterObject;
  TVpnTunnelsScopedListTypewarningTypedataItem.RegisterObject;
  TVpnTunnelsScopedListTypewarning.RegisterObject;
  TVpnTunnelsScopedList.RegisterObject;
  TZone.RegisterObject;
  TZoneList.RegisterObject;
end;


Function TComputeAPI.GetAddressesInstance : TAddressesResource;

begin
  if (FAddressesInstance=Nil) then
    FAddressesInstance:=CreateAddressesResource;
  Result:=FAddressesInstance;
end;

Function TComputeAPI.CreateAddressesResource : TAddressesResource;

begin
  Result:=CreateAddressesResource(Self);
end;


Function TComputeAPI.CreateAddressesResource(AOwner : TComponent) : TAddressesResource;

begin
  Result:=TAddressesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetAutoscalersInstance : TAutoscalersResource;

begin
  if (FAutoscalersInstance=Nil) then
    FAutoscalersInstance:=CreateAutoscalersResource;
  Result:=FAutoscalersInstance;
end;

Function TComputeAPI.CreateAutoscalersResource : TAutoscalersResource;

begin
  Result:=CreateAutoscalersResource(Self);
end;


Function TComputeAPI.CreateAutoscalersResource(AOwner : TComponent) : TAutoscalersResource;

begin
  Result:=TAutoscalersResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetBackendServicesInstance : TBackendServicesResource;

begin
  if (FBackendServicesInstance=Nil) then
    FBackendServicesInstance:=CreateBackendServicesResource;
  Result:=FBackendServicesInstance;
end;

Function TComputeAPI.CreateBackendServicesResource : TBackendServicesResource;

begin
  Result:=CreateBackendServicesResource(Self);
end;


Function TComputeAPI.CreateBackendServicesResource(AOwner : TComponent) : TBackendServicesResource;

begin
  Result:=TBackendServicesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetDiskTypesInstance : TDiskTypesResource;

begin
  if (FDiskTypesInstance=Nil) then
    FDiskTypesInstance:=CreateDiskTypesResource;
  Result:=FDiskTypesInstance;
end;

Function TComputeAPI.CreateDiskTypesResource : TDiskTypesResource;

begin
  Result:=CreateDiskTypesResource(Self);
end;


Function TComputeAPI.CreateDiskTypesResource(AOwner : TComponent) : TDiskTypesResource;

begin
  Result:=TDiskTypesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetDisksInstance : TDisksResource;

begin
  if (FDisksInstance=Nil) then
    FDisksInstance:=CreateDisksResource;
  Result:=FDisksInstance;
end;

Function TComputeAPI.CreateDisksResource : TDisksResource;

begin
  Result:=CreateDisksResource(Self);
end;


Function TComputeAPI.CreateDisksResource(AOwner : TComponent) : TDisksResource;

begin
  Result:=TDisksResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetFirewallsInstance : TFirewallsResource;

begin
  if (FFirewallsInstance=Nil) then
    FFirewallsInstance:=CreateFirewallsResource;
  Result:=FFirewallsInstance;
end;

Function TComputeAPI.CreateFirewallsResource : TFirewallsResource;

begin
  Result:=CreateFirewallsResource(Self);
end;


Function TComputeAPI.CreateFirewallsResource(AOwner : TComponent) : TFirewallsResource;

begin
  Result:=TFirewallsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetForwardingRulesInstance : TForwardingRulesResource;

begin
  if (FForwardingRulesInstance=Nil) then
    FForwardingRulesInstance:=CreateForwardingRulesResource;
  Result:=FForwardingRulesInstance;
end;

Function TComputeAPI.CreateForwardingRulesResource : TForwardingRulesResource;

begin
  Result:=CreateForwardingRulesResource(Self);
end;


Function TComputeAPI.CreateForwardingRulesResource(AOwner : TComponent) : TForwardingRulesResource;

begin
  Result:=TForwardingRulesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetGlobalAddressesInstance : TGlobalAddressesResource;

begin
  if (FGlobalAddressesInstance=Nil) then
    FGlobalAddressesInstance:=CreateGlobalAddressesResource;
  Result:=FGlobalAddressesInstance;
end;

Function TComputeAPI.CreateGlobalAddressesResource : TGlobalAddressesResource;

begin
  Result:=CreateGlobalAddressesResource(Self);
end;


Function TComputeAPI.CreateGlobalAddressesResource(AOwner : TComponent) : TGlobalAddressesResource;

begin
  Result:=TGlobalAddressesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetGlobalForwardingRulesInstance : TGlobalForwardingRulesResource;

begin
  if (FGlobalForwardingRulesInstance=Nil) then
    FGlobalForwardingRulesInstance:=CreateGlobalForwardingRulesResource;
  Result:=FGlobalForwardingRulesInstance;
end;

Function TComputeAPI.CreateGlobalForwardingRulesResource : TGlobalForwardingRulesResource;

begin
  Result:=CreateGlobalForwardingRulesResource(Self);
end;


Function TComputeAPI.CreateGlobalForwardingRulesResource(AOwner : TComponent) : TGlobalForwardingRulesResource;

begin
  Result:=TGlobalForwardingRulesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetGlobalOperationsInstance : TGlobalOperationsResource;

begin
  if (FGlobalOperationsInstance=Nil) then
    FGlobalOperationsInstance:=CreateGlobalOperationsResource;
  Result:=FGlobalOperationsInstance;
end;

Function TComputeAPI.CreateGlobalOperationsResource : TGlobalOperationsResource;

begin
  Result:=CreateGlobalOperationsResource(Self);
end;


Function TComputeAPI.CreateGlobalOperationsResource(AOwner : TComponent) : TGlobalOperationsResource;

begin
  Result:=TGlobalOperationsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetHttpHealthChecksInstance : THttpHealthChecksResource;

begin
  if (FHttpHealthChecksInstance=Nil) then
    FHttpHealthChecksInstance:=CreateHttpHealthChecksResource;
  Result:=FHttpHealthChecksInstance;
end;

Function TComputeAPI.CreateHttpHealthChecksResource : THttpHealthChecksResource;

begin
  Result:=CreateHttpHealthChecksResource(Self);
end;


Function TComputeAPI.CreateHttpHealthChecksResource(AOwner : TComponent) : THttpHealthChecksResource;

begin
  Result:=THttpHealthChecksResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetHttpsHealthChecksInstance : THttpsHealthChecksResource;

begin
  if (FHttpsHealthChecksInstance=Nil) then
    FHttpsHealthChecksInstance:=CreateHttpsHealthChecksResource;
  Result:=FHttpsHealthChecksInstance;
end;

Function TComputeAPI.CreateHttpsHealthChecksResource : THttpsHealthChecksResource;

begin
  Result:=CreateHttpsHealthChecksResource(Self);
end;


Function TComputeAPI.CreateHttpsHealthChecksResource(AOwner : TComponent) : THttpsHealthChecksResource;

begin
  Result:=THttpsHealthChecksResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetImagesInstance : TImagesResource;

begin
  if (FImagesInstance=Nil) then
    FImagesInstance:=CreateImagesResource;
  Result:=FImagesInstance;
end;

Function TComputeAPI.CreateImagesResource : TImagesResource;

begin
  Result:=CreateImagesResource(Self);
end;


Function TComputeAPI.CreateImagesResource(AOwner : TComponent) : TImagesResource;

begin
  Result:=TImagesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetInstanceGroupManagersInstance : TInstanceGroupManagersResource;

begin
  if (FInstanceGroupManagersInstance=Nil) then
    FInstanceGroupManagersInstance:=CreateInstanceGroupManagersResource;
  Result:=FInstanceGroupManagersInstance;
end;

Function TComputeAPI.CreateInstanceGroupManagersResource : TInstanceGroupManagersResource;

begin
  Result:=CreateInstanceGroupManagersResource(Self);
end;


Function TComputeAPI.CreateInstanceGroupManagersResource(AOwner : TComponent) : TInstanceGroupManagersResource;

begin
  Result:=TInstanceGroupManagersResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetInstanceGroupsInstance : TInstanceGroupsResource;

begin
  if (FInstanceGroupsInstance=Nil) then
    FInstanceGroupsInstance:=CreateInstanceGroupsResource;
  Result:=FInstanceGroupsInstance;
end;

Function TComputeAPI.CreateInstanceGroupsResource : TInstanceGroupsResource;

begin
  Result:=CreateInstanceGroupsResource(Self);
end;


Function TComputeAPI.CreateInstanceGroupsResource(AOwner : TComponent) : TInstanceGroupsResource;

begin
  Result:=TInstanceGroupsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetInstanceTemplatesInstance : TInstanceTemplatesResource;

begin
  if (FInstanceTemplatesInstance=Nil) then
    FInstanceTemplatesInstance:=CreateInstanceTemplatesResource;
  Result:=FInstanceTemplatesInstance;
end;

Function TComputeAPI.CreateInstanceTemplatesResource : TInstanceTemplatesResource;

begin
  Result:=CreateInstanceTemplatesResource(Self);
end;


Function TComputeAPI.CreateInstanceTemplatesResource(AOwner : TComponent) : TInstanceTemplatesResource;

begin
  Result:=TInstanceTemplatesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetInstancesInstance : TInstancesResource;

begin
  if (FInstancesInstance=Nil) then
    FInstancesInstance:=CreateInstancesResource;
  Result:=FInstancesInstance;
end;

Function TComputeAPI.CreateInstancesResource : TInstancesResource;

begin
  Result:=CreateInstancesResource(Self);
end;


Function TComputeAPI.CreateInstancesResource(AOwner : TComponent) : TInstancesResource;

begin
  Result:=TInstancesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetLicensesInstance : TLicensesResource;

begin
  if (FLicensesInstance=Nil) then
    FLicensesInstance:=CreateLicensesResource;
  Result:=FLicensesInstance;
end;

Function TComputeAPI.CreateLicensesResource : TLicensesResource;

begin
  Result:=CreateLicensesResource(Self);
end;


Function TComputeAPI.CreateLicensesResource(AOwner : TComponent) : TLicensesResource;

begin
  Result:=TLicensesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetMachineTypesInstance : TMachineTypesResource;

begin
  if (FMachineTypesInstance=Nil) then
    FMachineTypesInstance:=CreateMachineTypesResource;
  Result:=FMachineTypesInstance;
end;

Function TComputeAPI.CreateMachineTypesResource : TMachineTypesResource;

begin
  Result:=CreateMachineTypesResource(Self);
end;


Function TComputeAPI.CreateMachineTypesResource(AOwner : TComponent) : TMachineTypesResource;

begin
  Result:=TMachineTypesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetNetworksInstance : TNetworksResource;

begin
  if (FNetworksInstance=Nil) then
    FNetworksInstance:=CreateNetworksResource;
  Result:=FNetworksInstance;
end;

Function TComputeAPI.CreateNetworksResource : TNetworksResource;

begin
  Result:=CreateNetworksResource(Self);
end;


Function TComputeAPI.CreateNetworksResource(AOwner : TComponent) : TNetworksResource;

begin
  Result:=TNetworksResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetProjectsInstance : TProjectsResource;

begin
  if (FProjectsInstance=Nil) then
    FProjectsInstance:=CreateProjectsResource;
  Result:=FProjectsInstance;
end;

Function TComputeAPI.CreateProjectsResource : TProjectsResource;

begin
  Result:=CreateProjectsResource(Self);
end;


Function TComputeAPI.CreateProjectsResource(AOwner : TComponent) : TProjectsResource;

begin
  Result:=TProjectsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetRegionOperationsInstance : TRegionOperationsResource;

begin
  if (FRegionOperationsInstance=Nil) then
    FRegionOperationsInstance:=CreateRegionOperationsResource;
  Result:=FRegionOperationsInstance;
end;

Function TComputeAPI.CreateRegionOperationsResource : TRegionOperationsResource;

begin
  Result:=CreateRegionOperationsResource(Self);
end;


Function TComputeAPI.CreateRegionOperationsResource(AOwner : TComponent) : TRegionOperationsResource;

begin
  Result:=TRegionOperationsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetRegionsInstance : TRegionsResource;

begin
  if (FRegionsInstance=Nil) then
    FRegionsInstance:=CreateRegionsResource;
  Result:=FRegionsInstance;
end;

Function TComputeAPI.CreateRegionsResource : TRegionsResource;

begin
  Result:=CreateRegionsResource(Self);
end;


Function TComputeAPI.CreateRegionsResource(AOwner : TComponent) : TRegionsResource;

begin
  Result:=TRegionsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetRoutesInstance : TRoutesResource;

begin
  if (FRoutesInstance=Nil) then
    FRoutesInstance:=CreateRoutesResource;
  Result:=FRoutesInstance;
end;

Function TComputeAPI.CreateRoutesResource : TRoutesResource;

begin
  Result:=CreateRoutesResource(Self);
end;


Function TComputeAPI.CreateRoutesResource(AOwner : TComponent) : TRoutesResource;

begin
  Result:=TRoutesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetSnapshotsInstance : TSnapshotsResource;

begin
  if (FSnapshotsInstance=Nil) then
    FSnapshotsInstance:=CreateSnapshotsResource;
  Result:=FSnapshotsInstance;
end;

Function TComputeAPI.CreateSnapshotsResource : TSnapshotsResource;

begin
  Result:=CreateSnapshotsResource(Self);
end;


Function TComputeAPI.CreateSnapshotsResource(AOwner : TComponent) : TSnapshotsResource;

begin
  Result:=TSnapshotsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetSslCertificatesInstance : TSslCertificatesResource;

begin
  if (FSslCertificatesInstance=Nil) then
    FSslCertificatesInstance:=CreateSslCertificatesResource;
  Result:=FSslCertificatesInstance;
end;

Function TComputeAPI.CreateSslCertificatesResource : TSslCertificatesResource;

begin
  Result:=CreateSslCertificatesResource(Self);
end;


Function TComputeAPI.CreateSslCertificatesResource(AOwner : TComponent) : TSslCertificatesResource;

begin
  Result:=TSslCertificatesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetSubnetworksInstance : TSubnetworksResource;

begin
  if (FSubnetworksInstance=Nil) then
    FSubnetworksInstance:=CreateSubnetworksResource;
  Result:=FSubnetworksInstance;
end;

Function TComputeAPI.CreateSubnetworksResource : TSubnetworksResource;

begin
  Result:=CreateSubnetworksResource(Self);
end;


Function TComputeAPI.CreateSubnetworksResource(AOwner : TComponent) : TSubnetworksResource;

begin
  Result:=TSubnetworksResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetTargetHttpProxiesInstance : TTargetHttpProxiesResource;

begin
  if (FTargetHttpProxiesInstance=Nil) then
    FTargetHttpProxiesInstance:=CreateTargetHttpProxiesResource;
  Result:=FTargetHttpProxiesInstance;
end;

Function TComputeAPI.CreateTargetHttpProxiesResource : TTargetHttpProxiesResource;

begin
  Result:=CreateTargetHttpProxiesResource(Self);
end;


Function TComputeAPI.CreateTargetHttpProxiesResource(AOwner : TComponent) : TTargetHttpProxiesResource;

begin
  Result:=TTargetHttpProxiesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetTargetHttpsProxiesInstance : TTargetHttpsProxiesResource;

begin
  if (FTargetHttpsProxiesInstance=Nil) then
    FTargetHttpsProxiesInstance:=CreateTargetHttpsProxiesResource;
  Result:=FTargetHttpsProxiesInstance;
end;

Function TComputeAPI.CreateTargetHttpsProxiesResource : TTargetHttpsProxiesResource;

begin
  Result:=CreateTargetHttpsProxiesResource(Self);
end;


Function TComputeAPI.CreateTargetHttpsProxiesResource(AOwner : TComponent) : TTargetHttpsProxiesResource;

begin
  Result:=TTargetHttpsProxiesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetTargetInstancesInstance : TTargetInstancesResource;

begin
  if (FTargetInstancesInstance=Nil) then
    FTargetInstancesInstance:=CreateTargetInstancesResource;
  Result:=FTargetInstancesInstance;
end;

Function TComputeAPI.CreateTargetInstancesResource : TTargetInstancesResource;

begin
  Result:=CreateTargetInstancesResource(Self);
end;


Function TComputeAPI.CreateTargetInstancesResource(AOwner : TComponent) : TTargetInstancesResource;

begin
  Result:=TTargetInstancesResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetTargetPoolsInstance : TTargetPoolsResource;

begin
  if (FTargetPoolsInstance=Nil) then
    FTargetPoolsInstance:=CreateTargetPoolsResource;
  Result:=FTargetPoolsInstance;
end;

Function TComputeAPI.CreateTargetPoolsResource : TTargetPoolsResource;

begin
  Result:=CreateTargetPoolsResource(Self);
end;


Function TComputeAPI.CreateTargetPoolsResource(AOwner : TComponent) : TTargetPoolsResource;

begin
  Result:=TTargetPoolsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetTargetVpnGatewaysInstance : TTargetVpnGatewaysResource;

begin
  if (FTargetVpnGatewaysInstance=Nil) then
    FTargetVpnGatewaysInstance:=CreateTargetVpnGatewaysResource;
  Result:=FTargetVpnGatewaysInstance;
end;

Function TComputeAPI.CreateTargetVpnGatewaysResource : TTargetVpnGatewaysResource;

begin
  Result:=CreateTargetVpnGatewaysResource(Self);
end;


Function TComputeAPI.CreateTargetVpnGatewaysResource(AOwner : TComponent) : TTargetVpnGatewaysResource;

begin
  Result:=TTargetVpnGatewaysResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetUrlMapsInstance : TUrlMapsResource;

begin
  if (FUrlMapsInstance=Nil) then
    FUrlMapsInstance:=CreateUrlMapsResource;
  Result:=FUrlMapsInstance;
end;

Function TComputeAPI.CreateUrlMapsResource : TUrlMapsResource;

begin
  Result:=CreateUrlMapsResource(Self);
end;


Function TComputeAPI.CreateUrlMapsResource(AOwner : TComponent) : TUrlMapsResource;

begin
  Result:=TUrlMapsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetVpnTunnelsInstance : TVpnTunnelsResource;

begin
  if (FVpnTunnelsInstance=Nil) then
    FVpnTunnelsInstance:=CreateVpnTunnelsResource;
  Result:=FVpnTunnelsInstance;
end;

Function TComputeAPI.CreateVpnTunnelsResource : TVpnTunnelsResource;

begin
  Result:=CreateVpnTunnelsResource(Self);
end;


Function TComputeAPI.CreateVpnTunnelsResource(AOwner : TComponent) : TVpnTunnelsResource;

begin
  Result:=TVpnTunnelsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetZoneOperationsInstance : TZoneOperationsResource;

begin
  if (FZoneOperationsInstance=Nil) then
    FZoneOperationsInstance:=CreateZoneOperationsResource;
  Result:=FZoneOperationsInstance;
end;

Function TComputeAPI.CreateZoneOperationsResource : TZoneOperationsResource;

begin
  Result:=CreateZoneOperationsResource(Self);
end;


Function TComputeAPI.CreateZoneOperationsResource(AOwner : TComponent) : TZoneOperationsResource;

begin
  Result:=TZoneOperationsResource.Create(AOwner);
  Result.API:=Self.API;
end;



Function TComputeAPI.GetZonesInstance : TZonesResource;

begin
  if (FZonesInstance=Nil) then
    FZonesInstance:=CreateZonesResource;
  Result:=FZonesInstance;
end;

Function TComputeAPI.CreateZonesResource : TZonesResource;

begin
  Result:=CreateZonesResource(Self);
end;


Function TComputeAPI.CreateZonesResource(AOwner : TComponent) : TZonesResource;

begin
  Result:=TZonesResource.Create(AOwner);
  Result.API:=Self.API;
end;



initialization
  TComputeAPI.RegisterAPI;
end.
