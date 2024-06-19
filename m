Return-Path: <linux-kernel+bounces-220421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E690E17F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 04:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE331C22847
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85673481B8;
	Wed, 19 Jun 2024 02:02:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F6A7470;
	Wed, 19 Jun 2024 02:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762563; cv=fail; b=eSdUnrRmZxiUIg/pGZdEpgARWyjH5Xt7Fse7cEZJpgzd88gi5a9LLKN3HX/B/76vJeNMZcWuDRXs1vHmgr+wKDeDAlXH9/vjJGWfXMbws+04dHqjkb6HgUHwd0oojTToCO3rYz7EWor05Zxc5rL5g9JJLQeCUZS/aJg87cvP/ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762563; c=relaxed/simple;
	bh=k7EXbE0RcvcvZz2exbrsPGXaQKOQJaSo+fqAF2P++ho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WDv5d7UqGc7P1MKZkvVlDWGQsvQKvwIsYoXr1BU541kXEr2j7UMoCDHHbbRtvR8iQ0F/R9rWJcgT9oG3glK/Scj6A2Y8UDJoQuD0GYW1BCxVFcpQL4C5gtWxdOQfi7alnGHWe1SnsIazHV157Y8jBMYOEbTNls5iNujG0Q2pWvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1gB9C024586;
	Wed, 19 Jun 2024 02:02:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yujbdr4fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 02:02:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT9K8hzQEDqUjlyl9ImjzZohmrl8QZZ30iugL3hNRcfYQG/BPSt08j3LSsDQeGxbs8yUNa0bJKsNllU8yYxBqV74+fAEv+7MVUex/TEHCT5HIi87+hlsLQi9iGbU6BlKAjVDzcPQ89y1MlTapQwNDlV1CWMXO36n5oDlzK+ptX0O8YwJ9kGAOADfA6UHq1p09Pp2XXqro7wMAHwduFsteJ5BpfJCLqJt/SLvJovBsJSEhd6bCkR0IPYid0bpPgmV4zE+z72WnyKX0aQtDt2iloyUz+525B0VLjgPICfjLU7D/YaydBNqa33zkT/7w+0IS1sdHMXbXt45bx5uDkN/Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7EXbE0RcvcvZz2exbrsPGXaQKOQJaSo+fqAF2P++ho=;
 b=Bh4eJddU7YKkFF4qH7jR+KuHbezw5oCwX4p14lqhbPta9l/wT+ExxuJtg3+F/bFzfUuDG9VEzTYsdL2iamXc92RTpa2/l9PWm7W5eSmOpCLzfLfvigpoaV8DwFTDTTm8dK0K22BJ73KAeMH3VZm4xv581lYpcYWfe4XW6vOR0iX+QqTZ3iEHR3D3zV+GPikOvDa+rRm+EGmMq+p6zUJyt5RBOzul10LM3QOOMgQJq/6C3/WmVQZ2npfKxIrNg7ozMVTj1A7xS7w1UMS95djXPX+wFBsTbZYKxKqH17UxCFSuzMAlPUhvjefu3+SbVKsMFCogN3dvlRRC8TmxBmi5dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Wed, 19 Jun
 2024 02:02:29 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e9d7:7193:8b2b:f0b9%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 02:02:22 +0000
From: "Li, Meng" <Meng.Li@windriver.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "quic_uaggarwa@quicinc.com" <quic_uaggarwa@quicinc.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xu.yang_2@nxp.com" <xu.yang_2@nxp.com>
Subject: RE: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during gadget
 suspend/resume to avoid deadlock
Thread-Topic: [v2 PATCH] usb: dwc3: core: remove lock of otg mode during
 gadget suspend/resume to avoid deadlock
Thread-Index: AQHawS5aCFFqer72NUq3CfqcbCbWwLHOEbSAgABBTyCAAANxkA==
Date: Wed, 19 Jun 2024 02:02:19 +0000
Message-ID: 
 <PH0PR11MB519190ED0D42D88805122372F1CF2@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20240618031918.2585799-1-Meng.Li@windriver.com>
 <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
 <CO1PR11MB5188DA129618E46A1257F059F1CF2@CO1PR11MB5188.namprd11.prod.outlook.com>
In-Reply-To: 
 <CO1PR11MB5188DA129618E46A1257F059F1CF2@CO1PR11MB5188.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|SJ1PR11MB6153:EE_
x-ms-office365-filtering-correlation-id: 04599171-9a2b-4d29-730c-08dc9003d9fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZlN0U1J1R1dTYjh5VEZGdEN4Um5YbHdzRDk0VGRXZC9TSGtiUUR0KzZKeEgz?=
 =?utf-8?B?REhvN0FhMjR0QnlJQmtiQW84Z2MvdVZGTWwxOGo2TDFkeXRUc1F5ZjliUVlv?=
 =?utf-8?B?cm1wenZ0Z2p1QWdqN3I5OUwvTTRXTHoyM3pUNXdWT2pNSHU2OTdXaEtVSEcr?=
 =?utf-8?B?aDZHempZUnFHQUZvZVF5cUhzZ3ZTQnBjR3RUUWRzWVlTUnpEODYrcTA0Vzgv?=
 =?utf-8?B?ZkxQbGtJcW5tYTcyYm9yV1FuMGNtM3MwOFlKVjJKRnkxYzhyUnZOUVpmeWl3?=
 =?utf-8?B?NjhMamtsVnltd0Vhd0tXK2VyUDVzdVF0MXQzSHc4OWdGQm1JRW1yNGRRZ0xP?=
 =?utf-8?B?eEZpNmY1c0o2NmY5ZlBYaE1RVHFGTGd2UVlaenptTUhTd0daWDB5c3dyeVhl?=
 =?utf-8?B?Y3hLY1RoWURBeldiekdYRmt1b0RiaTV1NGNrd045REhBdUtWT0Jza3NlRm1t?=
 =?utf-8?B?ZjJ5cU9HSnVtbnQ2a3IveEk4T01HMFBrbUJJdzhYbDRUU1l4bTRhVDVIbzVj?=
 =?utf-8?B?Q2dvN2hTUUpPNTNTd1VOYzZqaElzSnBnYm5wUTlYS1l1cFUxWVFkTCtwRHlx?=
 =?utf-8?B?clFyZDV4M1FOR2lWYk5wV1Z4aU9TODBseGlGemZiektqeG92eTRlclM0TnlD?=
 =?utf-8?B?cXk3K0xsSlorYjduTmlLVGp0SVljQlVJZUtjSVplYm5ndUhnZ09sWDEzVytn?=
 =?utf-8?B?UlZwY1lqaWJEY3pFR0xRZUFQTGQ4ZEMxRENsSHgvUkwxbHBIYVM1dkhLbTFK?=
 =?utf-8?B?aGFFYXp0Um13MmZ2NXQ2bTlCSk1jTXQ0NTVTSlBYMmdaSG16bWoxMUVuMk5H?=
 =?utf-8?B?MXJLRmJnc2d2TWpYUXJ0VkRBa29yNHQ0d1o0enpiYjNYY3dhRzNJRXBoaFZJ?=
 =?utf-8?B?ODBmNm0zLzhOdEFBYTdienFGY211QUFKMzFpUzBzSVJDRURvbVZwY3p3YXAv?=
 =?utf-8?B?UjVWemh5UDNDOE5RbVQyZGdiM1VIdUVqZTErdHFHclNaeVdtZ05VQkIwNEo4?=
 =?utf-8?B?Ny83L3FMWG40cGtsS3hsZHpMTzhUUHhlUXMxZVFVWmI5aWRrSXpScGlSY04x?=
 =?utf-8?B?UW1EcVJ0YlZXTHpFSHFaT2cxZS96SXpPU283bFZaY1RnSFYvdkRGbXRMelNP?=
 =?utf-8?B?M3dHaXl4NWNFMjRsQURKZFBrWGhMaFQzbjdFdGsxVUFCQlZyR05JVjFYdW84?=
 =?utf-8?B?WjcrbGY1WTBKSWlZeDJOcFBNM1hyQk1Sb2ppTTJnWTdCd1RBWE5ibFBWa1Fh?=
 =?utf-8?B?VFVLemQ1YzhsbVU0N2lhdDVYRGNSVEFBN1Ixdjl4RVhldUNBYitHbjZ5NXFo?=
 =?utf-8?B?L0xlT3NsRTZCVkVNSjdEdWJNVkhsNUdoRFFJZUtvVWttVVFrUFB5aTFmVTli?=
 =?utf-8?B?SzIwNmt1U2RlN0t4eVpEQlY2QVZZdVM2VUZCV2p0c0wvRDFtMW1IcmVwbFg4?=
 =?utf-8?B?ODJYbWhsUElXeGJLOVpuejRzdkp5amErNy8zZWJnRHFPK2diQnRzQVVVcDZC?=
 =?utf-8?B?RVJEWXQ1Y1REekJ1bXcxY1VGNjUrRkUySzNSd3J3VXNHSE91VjgxRDU1UThG?=
 =?utf-8?B?MGUrL1pYWE02WWxaWTVWVnREVWo5OGw0c3VOTHpKemthRDJCUTFGMWZvYmlJ?=
 =?utf-8?B?MmoxR1N0aDhZZEpRWlQwdDdtQ3pjL1lvWStKLzJwMnMvRVhRRXhYNFJhWVdq?=
 =?utf-8?B?YWI2TnZkV2N6L2RIVVdlQ2M0cVA4cTIxbnlkbmcvaTNHd2VhRzBHRHVUdUpp?=
 =?utf-8?B?ODBpQVlrVWlxZ2k5QUIzR0laQUVDNXU3TjBMbVEwNkt0NG9EcU1aUThmR20z?=
 =?utf-8?Q?yLeTuZeOTeBYIQOOgNznndPGpESa8G0XlztpU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cy9RWXVxcmpYRlZNdGV4SW13d2xiOEl6NStZdnMrMlRycGw4dUwrbHYwQTgr?=
 =?utf-8?B?KzZxa3lFMURMM1o3cmg5QSs1VWFjalFESFlUMEV5M3kzWllwQ1RTeTdrSnhx?=
 =?utf-8?B?K1c3MVFiTlZJV1M2Z0ZIeWFVZ1VpdndwV3d3TVNmcTg1WGM2eTJCR0RXOGRB?=
 =?utf-8?B?cHQ2ejBHeC9qc081OUNpOFNwSHd6WHNBc2VUcTJNdjZnamlmKzJ4Z0R6L2Z0?=
 =?utf-8?B?eFkxdmw1ZXB4ajJEcGNORSsrTktBUE9OcVpvU3E0UlhldUdzUEF0ZkhVZ1dO?=
 =?utf-8?B?TFZjNWExUG1pSXRTVVU5czMxVkdFblp2TFFQcFhUcGlEazVtMnBtRkhRZWZo?=
 =?utf-8?B?SHdZOXRMbDBONEtOU3NBNVpmTmMwVVpIamU0eHVTM2drcnlhdlBzSkEzU1Vw?=
 =?utf-8?B?cElyeE5sUjErUjF5NW1WOUplYTdldGR2MEk0Rm80UzgyRlRRTmQrV1Q4Qk0x?=
 =?utf-8?B?cTIvNE5PVytsVWkyVkNsRFZpRDZxR3ZZY2V4cnAvWlRnTzh0bFBpeEYzMkdU?=
 =?utf-8?B?Z09qUVhWK1RYNlpUZXd3UVU4TkZCeFBWemJhUzU3amF0MGxxT3M2UGtvbUJw?=
 =?utf-8?B?UXl6ejFWcnhBVE40SkNMSnpJT3AwWVRvT0labGhOU2tTM1hyYk5jZmN0R1N2?=
 =?utf-8?B?UlpOUEExY3dzOTVQek9qNk5IUkRZU1pDS1RkM25wY1I4ZkFCMkt3cTRUOW9B?=
 =?utf-8?B?QzRSd3hsZzZxU2E5NEE2ZGc4WW1XV0NzYkRDTExzanhqdzFzRVdYZ04reTdJ?=
 =?utf-8?B?VlkxTmpvNDJocnhwVVJhZVZpV3hhRXFVQkVveDV3T0didU8xOHBES0F6bGFH?=
 =?utf-8?B?eHJ2SXJvYkNkVmFqWC9FYVJPQUhGcGV2WXFQdjBKaWIvOGEwNUxZOFVPUGdw?=
 =?utf-8?B?Q0ZKNmhBeDdHeFp4bjJYcGdSLzk1ekZ3SW1NUHQxeTFHKzZnV3oyNDJVUGY3?=
 =?utf-8?B?WUhQaFdvYlhjcVZTL3BYWS9vS1gzY25oV3A3bnJTRTJ1TVVyTVJIRXRTSXRx?=
 =?utf-8?B?UStYVWRiazVsWFhsSlVaZWh4cEg4TWJYQWlPQkxrNCt3VzdOSTluT0ZhV2Z0?=
 =?utf-8?B?anB1S1FHM3ZxdVdxWUo3SWwzTjg3aFF0TnB6bkdLSERnem41SDF4dFhOa3ho?=
 =?utf-8?B?SkZnbzV0M2RlM0QyNHNsQjRacEthQ2FGaXJMWnJYSWdaSFNJelNyUmpXVjJu?=
 =?utf-8?B?cXNOOUJnNXc3Q29xK0wwSUxJUms3N1BIaTdydTFBSmwxK1laRThUaDA3em4y?=
 =?utf-8?B?NURWOVdNR1E1L0ZMSnZvcWtvZGhmSnRJVnNXd1Y0L2VRSTN4MXVJd2tMOUw0?=
 =?utf-8?B?UEY3VGdTbjUydG1VOUZ4UXd4dzIxK2hTUVFkUVMrcitBVkhxa1Z6ellzQmlq?=
 =?utf-8?B?NnlFZ2xLRmg4Y0RzTmZrQTRrbnRobGluTW5DSnVrQm1TR2hzeUpXYnZFSWdp?=
 =?utf-8?B?VldkdHRVRVJkU3BUMXhFb21rbmlUWXU3dGlWejlKWURXZWZGRmEzeCtBUFox?=
 =?utf-8?B?cWY3RDV2S0hRZ282cHpxbUhleHJxcms3UkRtVG43MHVsME0xWVowTzZvSzh0?=
 =?utf-8?B?RFVkd005Y1F0UmZhY1JHd0lhYlVWZUluOTVsaGVzamgrNVlyRStMTWg2cm5o?=
 =?utf-8?B?WWlWSGtrbXJJUDVHWWhxMkwvMzgwV3VsNFdCK0JnTU1SN2g4elFYRzl5V3Js?=
 =?utf-8?B?MGI0aUwvNGFNR2lDRmpWcy9mTEZPQkxzR0hhdzdRSE9qQlZheGRRRUlsbDM0?=
 =?utf-8?B?bFN2alFSUnRmbE92U1h0bWViYzNJRGNjVDdkWmo5QnhJczlVZDZsYWdQOTRx?=
 =?utf-8?B?QlB1VUliYm5Id0gyb1FRRHM2UXVPSlF0K2lMZzFTM3p4a0IrZkJwR3dDUWM0?=
 =?utf-8?B?UVpUQ2VlbFYrY1RUNXpva2w0b0dBMEhFdzd4Kzh6QUluQVE5TzQvaitkK25k?=
 =?utf-8?B?ZEdqeUY3c1JaVlZJTTJyU1d2NEF0Q1pTa1hXS0NkUUppZ0ltMlF0blNVVXBL?=
 =?utf-8?B?aGFONGVCVDIxNS85NzVibjJFVUx2TGlRRG5kay9ic01JK0JTV21IS3B3VTdh?=
 =?utf-8?B?ODZiSTZwWXRORjIvT3p0TVVGMkxRRmZmeXo1YnZ6S3QxdXF0M1FMK1ZiL1Fu?=
 =?utf-8?Q?1EaDLEjHLQNdkqTd1MSbxRl11?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04599171-9a2b-4d29-730c-08dc9003d9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 02:02:19.5532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dL8+QwFMhl6jdLceObeGJJbvffK5w7erL8LlVrRJVLCq7YXvh4Wuuagqh6K4JP60qrZe1XNTXFyOObgZuTARpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6153
X-Proofpoint-ORIG-GUID: L48ecHODr60-oVOLzFyeS_eSKEHI3CJ5
X-Proofpoint-GUID: L48ecHODr60-oVOLzFyeS_eSKEHI3CJ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2405170001 definitions=main-2406190014

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGksIE1lbmcNCj4gU2Vu
dDogV2VkbmVzZGF5LCBKdW5lIDE5LCAyMDI0IDk6NDkgQU0NCj4gVG86IFRoaW5oIE5ndXllbiA8
VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gQ2M6IGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnOyBxdWljX3VhZ2dhcndhQHF1aWNpbmMuY29tOyBsaW51eC0NCj4gdXNiQHZnZXIua2VybmVs
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeHUueWFuZ18yQG54cC5jb20NCj4g
U3ViamVjdDogUkU6IFt2MiBQQVRDSF0gdXNiOiBkd2MzOiBjb3JlOiByZW1vdmUgbG9jayBvZiBv
dGcgbW9kZSBkdXJpbmcNCj4gZ2FkZ2V0IHN1c3BlbmQvcmVzdW1lIHRvIGF2b2lkIGRlYWRsb2Nr
DQo+IA0KPiANCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBU
aGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb20+DQo+ID4gU2VudDogV2VkbmVz
ZGF5LCBKdW5lIDE5LCAyMDI0IDU6NTQgQU0NCj4gPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2lu
ZHJpdmVyLmNvbT4NCj4gPiBDYzogVGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMu
Y29tPjsNCj4gPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgcXVpY191YWdnYXJ3YUBxdWlj
aW5jLmNvbTsgbGludXgtDQo+ID4gdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgeHUueWFuZ18yQG54cC5jb20NCj4gPiBTdWJqZWN0OiBSZTogW3YyIFBB
VENIXSB1c2I6IGR3YzM6IGNvcmU6IHJlbW92ZSBsb2NrIG9mIG90ZyBtb2RlDQo+ID4gZHVyaW5n
IGdhZGdldCBzdXNwZW5kL3Jlc3VtZSB0byBhdm9pZCBkZWFkbG9jaw0KPiA+DQo+ID4gQ0FVVElP
TjogVGhpcyBlbWFpbCBjb21lcyBmcm9tIGEgbm9uIFdpbmQgUml2ZXIgZW1haWwgYWNjb3VudCEN
Cj4gPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJl
Y29nbml6ZSB0aGUgc2VuZGVyDQo+ID4gYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4g
Pg0KPiA+IE9uIFR1ZSwgSnVuIDE4LCAyMDI0LCBNZW5nIExpIHdyb3RlOg0KPiA+ID4gV2hlbiBj
b25maWcgQ09ORklHX1VTQl9EV0MzX0RVQUxfUk9MRSBpcyBzZWxlY3RlZCwgYW5kIHRyaWdnZXIN
Cj4gPiBzeXN0ZW0NCj4gPiA+IHRvIGVudGVyIHN1c3BlbmQgc3RhdHVzIHdpdGggYmVsb3cgY29t
bWFuZDoNCj4gPiA+IGVjaG8gbWVtID4gL3N5cy9wb3dlci9zdGF0ZQ0KPiA+ID4gVGhlcmUgd2ls
bCBiZSBhIGRlYWRsb2NrIGlzc3VlIG9jY3VycmluZy4gRGV0YWlsZWQgaW52b2tpbmcgcGF0aCBh
cw0KPiA+ID4gYmVsb3c6DQo+ID4gPiBkd2MzX3N1c3BlbmRfY29tbW9uKCkNCj4gPiA+ICAgICBz
cGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7ICAgICAgICAgICAgICA8LS0gMXN0
DQo+ID4gPiAgICAgZHdjM19nYWRnZXRfc3VzcGVuZChkd2MpOw0KPiA+ID4gICAgICAgICBkd2Mz
X2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoZHdjKTsNCj4gPiA+ICAgICAgICAgICAgIHNwaW5fbG9j
a19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsgICAgICA8LS0gMm5kDQo+ID4gPiBUaGlzIGlz
c3VlIGlzIGV4cG9zZWQgYnkgY29tbWl0IGM3ZWJkODE0OWVlNSAoInVzYjogZHdjMzogZ2FkZ2V0
Og0KPiA+ID4gRml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBkd2MzX2dhZGdldF9zdXNw
ZW5kIikgdGhhdCByZW1vdmVzDQo+ID4gPiB0aGUgY29kZSBvZiBjaGVja2luZyB3aGV0aGVyIGR3
Yy0+Z2FkZ2V0X2RyaXZlciBpcyBOVUxMIG9yIG5vdC4gSXQNCj4gPiA+IGNhdXNlcyB0aGUgZm9s
bG93aW5nIGNvZGUgaXMgZXhlY3V0ZWQgYW5kIGRlYWRsb2NrIG9jY3VycyB3aGVuDQo+ID4gPiB0
cnlpbmcgdG8gZ2V0IHRoZSBzcGlubG9jay4gSW4gZmFjdCwgdGhlIHJvb3QgY2F1c2UgaXMgdGhl
IGNvbW1pdA0KPiA1MjY1Mzk3Zjk0NDIoInVzYjoNCj4gPiBkd2MzOg0KPiA+ID4gUmVtb3ZlIERX
QzMgbG9ja2luZyBkdXJpbmcgZ2FkZ2V0IHN1c3BlbmQvcmVzdW1lIikgdGhhdCBmb3Jnb3QgdG8N
Cj4gPiA+IHJlbW92ZSB0aGUgbG9jayBvZiBvdGcgbW9kZS4gU28sIHJlbW92ZSB0aGUgcmVkdW5k
YW50IGxvY2sgb2Ygb3RnDQo+ID4gPiBtb2RlIGR1cmluZyBnYWRnZXQgc3VzcGVuZC9yZXN1bWUu
DQo+ID4gPg0KPiA+ID4gRml4ZXM6IDUyNjUzOTdmOTQ0MiAoInVzYjogZHdjMzogUmVtb3ZlIERX
QzMgbG9ja2luZyBkdXJpbmcgZ2FkZ2V0DQo+ID4gPiBzdXNwZW5kL3Jlc3VtZSIpDQo+ID4gPiBD
YzogWHUgWWFuZyA8eHUueWFuZ18yQG54cC5jb20+DQo+ID4gPiBDYzogc3RhYmxlQHZnZXIua2Vy
bmVsLm9yZw0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWVuZyBMaSA8TWVuZy5MaUB3aW5kcml2ZXIu
Y29tPg0KPiA+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gdjEtPnYyOg0KPiA+ID4gIC0gaW1wcm92ZSBj
b21taXQgbG9nLCBjb3JyZWN0IHRoZSBGaXhlcyBjb21taXQgaWQuDQo+ID4gPg0KPiA+ID4gLS0t
DQo+ID4gPiAgZHJpdmVycy91c2IvZHdjMy9jb3JlLmMgfCA2IC0tLS0tLQ0KPiA+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MzL2NvcmUuYyBiL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGluZGV4DQo+ID4g
PiA3ZWU2MWE4OTUyMGIuLjlkNDdjM2FhNTc3NyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
dXNiL2R3YzMvY29yZS5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYw0KPiA+
ID4gQEAgLTIyNTAsNyArMjI1MCw2IEBAIHN0YXRpYyBpbnQgZHdjM19jb3JlX2luaXRfZm9yX3Jl
c3VtZShzdHJ1Y3QNCj4gPiBkd2MzDQo+ID4gPiAqZHdjKQ0KPiA+ID4NCj4gPiA+ICBzdGF0aWMg
aW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90DQo+
IG1zZykNCj4gPiB7DQo+ID4gPiAtICAgICB1bnNpZ25lZCBsb25nICAgZmxhZ3M7DQo+ID4gPiAg
ICAgICB1MzIgcmVnOw0KPiA+ID4gICAgICAgaW50IGk7DQo+ID4gPg0KPiA+ID4gQEAgLTIyOTMs
OSArMjI5Miw3IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMw0K
PiA+ICpkd2MsIHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAgICBpZiAoZHdjLT5jdXJyZW50X290Z19y
b2xlID09IERXQzNfT1RHX1JPTEVfREVWSUNFKSB7DQo+ID4gPiAtICAgICAgICAgICAgICAgICAg
ICAgc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gPiA+IC0gICAgICAgICAg
ICAgICAgICAgICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4g
PiA+ICAgICAgICAgICAgICAgICAgICAgICBzeW5jaHJvbml6ZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0
KTsNCj4gPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+IEBAIC0yMzEyLDcgKzIzMDks
NiBAQCBzdGF0aWMgaW50IGR3YzNfc3VzcGVuZF9jb21tb24oc3RydWN0IGR3YzMNCj4gPiAqZHdj
LA0KPiA+ID4gcG1fbWVzc2FnZV90IG1zZykNCj4gPiA+DQo+ID4gPiAgc3RhdGljIGludCBkd2Mz
X3Jlc3VtZV9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gew0K
PiA+ID4gLSAgICAgdW5zaWduZWQgbG9uZyAgIGZsYWdzOw0KPiA+ID4gICAgICAgaW50ICAgICAg
ICAgICAgIHJldDsNCj4gPiA+ICAgICAgIHUzMiAgICAgICAgICAgICByZWc7DQo+ID4gPiAgICAg
ICBpbnQgICAgICAgICAgICAgaTsNCj4gPiA+IEBAIC0yMzY2LDkgKzIzNjIsNyBAQCBzdGF0aWMg
aW50IGR3YzNfcmVzdW1lX2NvbW1vbihzdHJ1Y3QgZHdjMw0KPiA+ICpkd2MsIHBtX21lc3NhZ2Vf
dCBtc2cpDQo+ID4gPiAgICAgICAgICAgICAgIGlmIChkd2MtPmN1cnJlbnRfb3RnX3JvbGUgPT0g
RFdDM19PVEdfUk9MRV9IT1NUKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgZHdjM19v
dGdfaG9zdF9pbml0KGR3Yyk7DQo+ID4gPiAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoZHdjLT5j
dXJyZW50X290Z19yb2xlID09IERXQzNfT1RHX1JPTEVfREVWSUNFKSB7DQo+ID4gPiAtICAgICAg
ICAgICAgICAgICAgICAgc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiA+
ID4gICAgICAgICAgICAgICAgICAgICAgIGR3YzNfZ2FkZ2V0X3Jlc3VtZShkd2MpOw0KPiA+ID4g
LSAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywg
ZmxhZ3MpOw0KPiA+ID4gICAgICAgICAgICAgICB9DQo+ID4gPg0KPiA+ID4gICAgICAgICAgICAg
ICBicmVhazsNCj4gPiA+IC0tDQo+ID4gPiAyLjM0LjENCj4gPiA+DQo+ID4NCj4gPiBEaWQgeW91
IHVzZSAiZ2l0IGZvcm1hdC1wYXRjaCAtdiI/IFRoZSAkc3ViamVjdCB2ZXJzaW9uIHByZWZpeCBv
cmRlcg0KPiA+IGlzIGRpZmZlcmVudC4gSW4gYW55IGNhc2UsDQo+ID4NCj4gDQo+IFNvcnJ5ISBJ
IHVzZSAtLXN1YmplY3QtcHJlZml4PSJ2MiBQQVRDSCIuDQo+IEkgd2lsbCBjb3JyZWN0IGl0IGlu
IG5leHQgcGF0Y2ggcHVsbCByZXF1ZXN0Lg0KPiANCj4gVGhhbmtzLA0KPiBMaW1lbmcNCj4gDQoN
CkRvIEkgbmVlZCB0byBzZW5kIGFub3RoZXIgdjMgcHVsbCByZXF1ZXN0Pw0KDQpUaGFua3MsDQpM
SW1lbmcNCg0KPiA+IEFja2VkLWJ5OiBUaGluaCBOZ3V5ZW4gPFRoaW5oLk5ndXllbkBzeW5vcHN5
cy5jb20+DQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gVGhpbmgNCg==

