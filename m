Return-Path: <linux-kernel+bounces-220412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC7E90E167
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267C3284A72
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39252F9E8;
	Wed, 19 Jun 2024 01:49:12 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23196FC7;
	Wed, 19 Jun 2024 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718761751; cv=fail; b=HBfgjhEFGlxvVwQQHMFUFHVcAcAqZDWm4GGcxtLlTw8vXmRBM4s4Uy2GD660pCWT+RX1S/Bi0uebM3x8QiDH/DW738DDS+ZZmIearajdj+tkFfZ0vv810lQh4EIKgW1ZYzIxxFagGMkEeLwqusyfMSrIx43MoMJyxJlaeig1L2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718761751; c=relaxed/simple;
	bh=hF8Em8AlmHjIM7lYRxiVtp117JPyWpCBWKnF0vkNKfE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OorlJ51HqA4SqV7PePWnFGQsvNXRpxReecjsAB2DrNByfpa7+NqWVlBnPr+QytiUh+WXhvO9PK7hKEe2aZx3gSU2Uj5rovX+tRLDmqOd/7KePpEeHKhEjveyKuArTpj39IZJsgj6av7FNquoWq37+aHksv75X3ntPuktALbArhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1eONS023508;
	Wed, 19 Jun 2024 01:49:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yujb704cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 01:49:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bslpnum2vpLA0Ut+DKOm6Twz48FI50QwOjhYhjZvP/cj9eprwZiNHSXhr7UPiLvzRiH+mSEKXU3Yq1s4ApSzm8jlXZZNJS+yCsbmE8t5tBBdTb4fXKetVpWUTSnAgNogvngKfd2Rd05L4AW6hFMS0rMb04sCBNEWNVXiT6AtqkXF6RBIMtfDjycsxw5whWo6VCQDKvVDQhUEQjVkbAo6292THBUyfw6kzRlJhvjcA7b5EhVx44+YXOk3m22bWXXLeLUynnTVAp8CDVCWdDSOfQEXIV8V7Xbfj0BdsdOMeRyssNN0jxdvuvTnVswBVNS6cx3YhwgNe2ntZZW0gG2mTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF8Em8AlmHjIM7lYRxiVtp117JPyWpCBWKnF0vkNKfE=;
 b=Lh2WUh3Mkg/uiCbzAnUc5vUMUbV0SRK+fEvASLGoS68tgb2YXLVs6I3CFEy2uSPfKR5+U/lPA0TzfqIYTc+rllDkb2N4Iyhm++MK06lNx3M1939RRE/1LKakCTV3oEeTzw/0jejkGikR/xBjMKBPxCSqeETQonb309chDybIop+dwiQ+pAde7+DMb6n0ANkasL+gdWAYrz4DZQXQhdRFRKhdffJ444rZe8GqtLLu5Rw/Lmvlfjb0Ej3Zl2GvJXcwtZ65iB730EbPdFQ3bBfsn1F/a02fy8RgXsau4yGlVgULqweRw/yDZ6aaWXEj1yPB6Zh8ScxR1qXR4Dvnnrc3XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16)
 by PH8PR11MB7070.namprd11.prod.outlook.com (2603:10b6:510:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 01:48:56 +0000
Received: from CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::e104:97a:236a:1403]) by CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::e104:97a:236a:1403%3]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 01:48:55 +0000
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
Thread-Index: AQHawS5aCFFqer72NUq3CfqcbCbWwLHOEbSAgABBTyA=
Date: Wed, 19 Jun 2024 01:48:55 +0000
Message-ID: 
 <CO1PR11MB5188DA129618E46A1257F059F1CF2@CO1PR11MB5188.namprd11.prod.outlook.com>
References: <20240618031918.2585799-1-Meng.Li@windriver.com>
 <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
In-Reply-To: <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5188:EE_|PH8PR11MB7070:EE_
x-ms-office365-filtering-correlation-id: 24e3dbe5-3465-4519-dc8d-08dc9001fa76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?YmkzbnpBVWRqTXZZRU5Ua0YvbHZINlVRVm9zMFkzaHRIeXVNVmpDaXRIN3dK?=
 =?utf-8?B?ZGxuZFZjb1QzWStaa3RoQytCSkdXUXlma3ZWV1VzOWZVeHZQYXVMajduQWhm?=
 =?utf-8?B?THA4TlB1VER6cUFwRTBWN3pKY09Ob3dXWWhzSW5vbWhmeUR6UTAxdlJjTEph?=
 =?utf-8?B?SDdSTzdsMDFDeDdxQXJRcVRxVUR4NnNpeHZ5Z1hEU29naGQ4M1RYVm8xMjZY?=
 =?utf-8?B?Z0pJQWJpTWgyOWF5Z2czeWlZWDE3WGZuK0N5Qjk3UXJ1UEJ2RTdacERvYWky?=
 =?utf-8?B?MmNkYllNT1R0Tzh4MEVmNVRlc0ZmWGlPNGYxcW1jZGo4d0hVSi9XdEZwc3Bm?=
 =?utf-8?B?K3oxTHRCdjlaQjlkdkRYVHI4WGZKeGVicjcyV25ITGhWQ1htczdpakErME9N?=
 =?utf-8?B?ckg4eE9sUDl2WGtxdGdWaklWWW54TEk4U0xjWWJRbVVZb2F1OXFva3RHNklt?=
 =?utf-8?B?VjNDaDhoMmZuQXNqeEhZUUpQRm8yN3BpSjhWeVBOa0d3T2FaL0tYa1BJQXRB?=
 =?utf-8?B?OXpHQXBRVXROQjhva3FHRnBjL2FFSjZxbVl6RjNOd2MyL3l5R0tPT3VDNVYw?=
 =?utf-8?B?T0c2alBZVDhzSGQvbWFJeGFkUmp1SCtYNE1aN25LK2dLcmlvaEVpWGd4cWhy?=
 =?utf-8?B?R01KWlZDczNXTTNLa2Z5TzI5YmlNQ0VHRUlvVWZIZ0xCWjMrR2wvNXU1SHYz?=
 =?utf-8?B?aEtvQ2VsUlphQjlGMmtwVGw3SUVnejhmSVI3SjQvSkpNWGR2ekZ0NjM3RzV1?=
 =?utf-8?B?dy8vMTF0MGptbWVDY3RDT251MWw0NmRXRVhLWEJxZzhKZ1BNWGg5eDd4YnNN?=
 =?utf-8?B?dXBwUDF4SDhhdUd6bXJZa2Rkc2tuY0w1S3NwY0I3a1ZDRWF2TmxnVWtSNnVq?=
 =?utf-8?B?RGJDVENtbzhtSnp3RVpHU2pnYlZNU2kwa0NwVVBCT0R5OGo5RlBBcVV3dHBL?=
 =?utf-8?B?b21UZXNrQTJQakF4TEFGdjdyaHFVTzcxWlhjTG94dlpjdkRkdWNpRGQwVnlT?=
 =?utf-8?B?d21HNTFQd1RLdDZ3SVpFS2FNZ3gxRzhubUdzRmZNaWpQaCt1OHhBN1RQeFNH?=
 =?utf-8?B?L2hYWVR5SDNwdHRKWkQ4aWpxQ3dKaHB5N1l5OG1LaUx2Mk1uQ2ZCRmtGdWlG?=
 =?utf-8?B?TXhTc1lZL0VOUFNIOFNZZE53cTVFWWRrYUxkZ1JZM2ZXdFJ5ckNUTlhlem0z?=
 =?utf-8?B?ZGdCMTQwRUlYeCtlbmpVRC9GZXZsRmFnUGhITW1vNHdSSjVRa0E2TEE2WWFQ?=
 =?utf-8?B?Q25KVVZtQy80UkdKUmNISTJHVndVbzZFVHRXVGIvNlhrM2MraFFqamo5ZVkz?=
 =?utf-8?B?K2dzMmlWMDhBa2xkaTdxT0Nia0c1ZmlvYTlNaktOMm03QVpFcE8vamxEOHlW?=
 =?utf-8?B?WXhQR3dGWHo0elV0ZTN2dzRwUEoyeW5nendpVGNrV253TFF4U2J4N290OWtt?=
 =?utf-8?B?UC9wUHZncnJmWFhreCtrb0ZXWFg0L1g3eCtjNFc0Y1NCQk1icU5iV1lpdm1M?=
 =?utf-8?B?SXpIVHhGVUlTU2NmdkhsZ2pIVjJ2TzFxT2c5QTBLUlg0UkJ5SmhRQVVTWVQy?=
 =?utf-8?B?SDlidStGdE94TkRMK0FKTHNBWUhOYkNac29aWWFOUDNKaUZJU1h1S2them1o?=
 =?utf-8?B?bHcrUFNvamFOY2QzSGkvQmVpUzdLa011UnUwWnROZ2c5WmQ4Q1hZRDNjL1Yz?=
 =?utf-8?B?enYzRG5zL1BZQm5nZituU3VvSEp6dVB5cHI5OEJMZDNzTXJUemZuVFMvUm5r?=
 =?utf-8?B?bWhGNUZCT3JCQXROSkpLYS9lU1JMUEY2QnFHdVBuRUM0WERUc0R0NCtsd25H?=
 =?utf-8?Q?Sv5LK7+0AFWPJpq/ZfC4v2wRajfL4rpGLpFVE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5188.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ZVErQXE2K2xETG1pNDRXZWhaSmZqNlIvRXI2WmhhME0rblVrT3o1NkpuQjJk?=
 =?utf-8?B?bUwyai9mTS9SSHZCK3ZxbUVWSE1tTThUMVhLc3lLSE9zRlVmVVA0VGFDTWsw?=
 =?utf-8?B?U09GbnFVSEdQOFNxeUFlZTdiREFjRmFaSndEdzhxdU1BQ3ZEVEhHd3RHTEdN?=
 =?utf-8?B?QXc1RXFLUklmcHVxVWF2TmY5TmZRNVpWdUl4eEp5QVFmQWFhTVhYcW1DQmFo?=
 =?utf-8?B?emtpd3lQdnpmaGxRZUpuM3IycXZHMWs2N25OL3JjS1hKTDNuWTduMDYwYVEr?=
 =?utf-8?B?RDdsN0lESDhnNW90K1N3d0ZhV2d1NlRzR1ZWNkhxcnFHTllhaW5EM0tmeXdO?=
 =?utf-8?B?TVFJYVY3NFkzYzJkN2RXSVBvdkRQcXBpdFhqY0hxeUpCczBRdGNIaytJSFJB?=
 =?utf-8?B?VmR5UVVsSElxSVBHUElQQ0tBRURpdEpQTEh1bEFBOENwQjl4SXVvRVBmckMr?=
 =?utf-8?B?SWJtSTV0QkVRazIwUjU4ZXdTZGd6aG5PYklEMUJhcFFtM2hEWFhoczdRRGZv?=
 =?utf-8?B?VWdGRDhoMzdOU1ZQN0ZHaktZTHVqVVJiUzJNTWpBd1RtN3lsTWRFWUpFdG1o?=
 =?utf-8?B?SVY4Z3R0QnMrdGkvcGRiZndWeHRTcVlsUklqbTk3aGVPV1FqYytuekE1TGJG?=
 =?utf-8?B?cmpyZTVZWUJ3dHN5YWtMajRYZ0FWZy9PMWRvaSt6VkVkWDFWZk9oaVhmbjdz?=
 =?utf-8?B?cnpPOGRnSUtiTTFSWEdDOVJZYzYyTElvNnorYTc3aC80VFBVVU5oV1FTbGpP?=
 =?utf-8?B?enNCNmovVGVOUVV0QlZqZjBCYVYvR2FESFRLNDJPNFFocElRTnVmTG5uZnBU?=
 =?utf-8?B?V1lVc1hBZkNxVnpiVmorY3FiMTVPOS9LdjhwTkRRcGM3MEFGRUk1ZWJWbEtH?=
 =?utf-8?B?Y2tla1FPQmxZS2RxMDhzc0xESit4N2hDZE4wRVpvT0tRaEV2QmNQUm1wNjRv?=
 =?utf-8?B?UlBjUU91ZHlrMllSS25oNllhTEdkeFJxZHIzU3hXQ0dVVnpic1A2VE5UQ2Fn?=
 =?utf-8?B?eTQ3KzU1NHp1YnNnenRVT0JRQm1SNDFBK01GZTVNdGI4UXVLTkJjRHhqMGE1?=
 =?utf-8?B?bTJDSm5KUUxFYjI4VVl6TnZCekF6T2FST3VOZWJIR1RZdVhaajl2bVVVVUJE?=
 =?utf-8?B?bElpVVZhUlBCdnBnM2x3MTM3ZVpMQSt5WTB6Z3JqTE9QMHhaV1Z3RnZGM2VF?=
 =?utf-8?B?Y1o3UXBEMW1MVEIzQjZ0cVNTdWxPNEFOUlZobGFjZFlvMmhHU3FDTHllVHpQ?=
 =?utf-8?B?L3JQOU9jSWpoUm01Vng0RUVFektVRFlabXE0RnZmOXhvQ1VRa2duSkpVQ2Y4?=
 =?utf-8?B?MjM5azBjUm5xR0VUSmRGUzFxMDBIVWRaUngyZXhValJGb0hHdkZHSzRNMkJF?=
 =?utf-8?B?SXFlNzJySlhyRG93R2Z5UDgxa1diUUt5azg1RnE4cUV6eHZicm1YYzJrNzNH?=
 =?utf-8?B?eVhja3JsMGxua29ubmFmNDQ2S3hTR3gvVUpmck5qQktSbUVoenN4WTJKdnMz?=
 =?utf-8?B?TTRCVW02elZtTWlIMHFsMHJ0ZnJwZGNUbDFUY2prckFHKy80OXVQT0QwdGd5?=
 =?utf-8?B?RkQyUTVwaXJ1YjllQU1qT2tiZWVHL3AzWkU5SGRHcWVqWDN5RG1zNVJWd1pS?=
 =?utf-8?B?SHdzWW5wRDc3MGk2R1ppdXIzTFk3T1oyRVRWZjE2a0wrWlNHdVZoRGR6dmR3?=
 =?utf-8?B?NkRHZkVQMUEyUVJxQ0FtZ2pUNEgrWHVIdUNEYmlQQUdlbm5pQ1ZVMnFXdkw1?=
 =?utf-8?B?SVp4QXBaRHFuakFXSHRWeFZ3ZnhYcXZ0SHNEbmYrRGRzSVVZZE9OdHBML0RG?=
 =?utf-8?B?RWpMZDQzQitEYkx1TVNmUTBvWG11dXlkckt4SkdNaXdSOEdVTjhQbkR0ek9B?=
 =?utf-8?B?alZtLzNQUGdRMUpvQU9aM0dCMEs3OU1jNTBhM0dRRjIxTnUrQkUwQVdlMmJC?=
 =?utf-8?B?UG5NSHk1NXlRZ3VIamhDSWJtMG13YllYVk1wM3p0TzYxVFFGc3c5RVY0a1No?=
 =?utf-8?B?eldyeFg3U0xhNGtVdmp5RWxLWUMvNThvSzlkVjN3dWZPK3NlZmUwUFZoU3Nn?=
 =?utf-8?B?K0NFeWZoTE5JOFF1UitMU0oxN2JzcGQzVlQzQk83QzNDUzB3TjZZYkFZMG8w?=
 =?utf-8?Q?yL5BnHl5s8tDGEWEgahYuO3HA?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5188.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e3dbe5-3465-4519-dc8d-08dc9001fa76
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 01:48:55.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXMbQpQ80J+6/CpoR5FgBicYy83SKSe9ttHChfNdFbM5Zm1sBSB5BtbRWaCLDnXKdwWzRKhCmPphP8nSWWoLYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7070
X-Proofpoint-GUID: xFUIq18JkTFSJeu6UFKdrQ5wYVzrWapn
X-Proofpoint-ORIG-GUID: xFUIq18JkTFSJeu6UFKdrQ5wYVzrWapn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_08,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2405170001
 definitions=main-2406190013

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMTksIDIw
MjQgNTo1NCBBTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNvbT4NCj4gQ2M6
IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT47DQo+IGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnOyBxdWljX3VhZ2dhcndhQHF1aWNpbmMuY29tOyBsaW51eC0NCj4gdXNi
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgeHUueWFuZ18y
QG54cC5jb20NCj4gU3ViamVjdDogUmU6IFt2MiBQQVRDSF0gdXNiOiBkd2MzOiBjb3JlOiByZW1v
dmUgbG9jayBvZiBvdGcgbW9kZSBkdXJpbmcNCj4gZ2FkZ2V0IHN1c3BlbmQvcmVzdW1lIHRvIGF2
b2lkIGRlYWRsb2NrDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIGNvbWVzIGZyb20gYSBub24g
V2luZCBSaXZlciBlbWFpbCBhY2NvdW50IQ0KPiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZA0KPiBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiBPbiBUdWUsIEp1biAxOCwgMjAyNCwgTWVuZyBMaSB3
cm90ZToNCj4gPiBXaGVuIGNvbmZpZyBDT05GSUdfVVNCX0RXQzNfRFVBTF9ST0xFIGlzIHNlbGVj
dGVkLCBhbmQgdHJpZ2dlcg0KPiBzeXN0ZW0NCj4gPiB0byBlbnRlciBzdXNwZW5kIHN0YXR1cyB3
aXRoIGJlbG93IGNvbW1hbmQ6DQo+ID4gZWNobyBtZW0gPiAvc3lzL3Bvd2VyL3N0YXRlDQo+ID4g
VGhlcmUgd2lsbCBiZSBhIGRlYWRsb2NrIGlzc3VlIG9jY3VycmluZy4gRGV0YWlsZWQgaW52b2tp
bmcgcGF0aCBhcw0KPiA+IGJlbG93Og0KPiA+IGR3YzNfc3VzcGVuZF9jb21tb24oKQ0KPiA+ICAg
ICBzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7ICAgICAgICAgICAgICA8LS0g
MXN0DQo+ID4gICAgIGR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4gPiAgICAgICAgIGR3YzNf
Z2FkZ2V0X3NvZnRfZGlzY29ubmVjdChkd2MpOw0KPiA+ICAgICAgICAgICAgIHNwaW5fbG9ja19p
cnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsgICAgICA8LS0gMm5kDQo+ID4gVGhpcyBpc3N1ZSBp
cyBleHBvc2VkIGJ5IGNvbW1pdCBjN2ViZDgxNDllZTUgKCJ1c2I6IGR3YzM6IGdhZGdldDogRml4
DQo+ID4gTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGluIGR3YzNfZ2FkZ2V0X3N1c3BlbmQiKSB0
aGF0IHJlbW92ZXMgdGhlDQo+ID4gY29kZSBvZiBjaGVja2luZyB3aGV0aGVyIGR3Yy0+Z2FkZ2V0
X2RyaXZlciBpcyBOVUxMIG9yIG5vdC4gSXQgY2F1c2VzDQo+ID4gdGhlIGZvbGxvd2luZyBjb2Rl
IGlzIGV4ZWN1dGVkIGFuZCBkZWFkbG9jayBvY2N1cnMgd2hlbiB0cnlpbmcgdG8gZ2V0DQo+ID4g
dGhlIHNwaW5sb2NrLiBJbiBmYWN0LCB0aGUgcm9vdCBjYXVzZSBpcyB0aGUgY29tbWl0IDUyNjUz
OTdmOTQ0MigidXNiOg0KPiBkd2MzOg0KPiA+IFJlbW92ZSBEV0MzIGxvY2tpbmcgZHVyaW5nIGdh
ZGdldCBzdXNwZW5kL3Jlc3VtZSIpIHRoYXQgZm9yZ290IHRvDQo+ID4gcmVtb3ZlIHRoZSBsb2Nr
IG9mIG90ZyBtb2RlLiBTbywgcmVtb3ZlIHRoZSByZWR1bmRhbnQgbG9jayBvZiBvdGcgbW9kZQ0K
PiA+IGR1cmluZyBnYWRnZXQgc3VzcGVuZC9yZXN1bWUuDQo+ID4NCj4gPiBGaXhlczogNTI2NTM5
N2Y5NDQyICgidXNiOiBkd2MzOiBSZW1vdmUgRFdDMyBsb2NraW5nIGR1cmluZyBnYWRnZXQNCj4g
PiBzdXNwZW5kL3Jlc3VtZSIpDQo+ID4gQ2M6IFh1IFlhbmcgPHh1LnlhbmdfMkBueHAuY29tPg0K
PiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4gU2lnbmVkLW9mZi1ieTogTWVuZyBM
aSA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPg0KPiA+DQo+ID4gLS0tDQo+ID4gdjEtPnYyOg0KPiA+
ICAtIGltcHJvdmUgY29tbWl0IGxvZywgY29ycmVjdCB0aGUgRml4ZXMgY29tbWl0IGlkLg0KPiA+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2R3YzMvY29yZS5jIHwgNiAtLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvZHdjMy9jb3JlLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2NvcmUuYyBpbmRleA0KPiA+
IDdlZTYxYTg5NTIwYi4uOWQ0N2MzYWE1Nzc3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvY29yZS5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9jb3JlLmMNCj4gPiBAQCAt
MjI1MCw3ICsyMjUwLDYgQEAgc3RhdGljIGludCBkd2MzX2NvcmVfaW5pdF9mb3JfcmVzdW1lKHN0
cnVjdA0KPiBkd2MzDQo+ID4gKmR3YykNCj4gPg0KPiA+ICBzdGF0aWMgaW50IGR3YzNfc3VzcGVu
ZF9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykNCj4gew0KPiA+IC0g
ICAgIHVuc2lnbmVkIGxvbmcgICBmbGFnczsNCj4gPiAgICAgICB1MzIgcmVnOw0KPiA+ICAgICAg
IGludCBpOw0KPiA+DQo+ID4gQEAgLTIyOTMsOSArMjI5Miw3IEBAIHN0YXRpYyBpbnQgZHdjM19z
dXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMw0KPiAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gPg0KPiA+ICAgICAgICAgICAgICAgaWYg
KGR3Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0MzX09UR19ST0xFX0RFVklDRSkgew0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGR3YzNfZ2FkZ2V0X3N1c3BlbmQoZHdjKTsNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZHdjLT5sb2Nr
LCBmbGFncyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHN5bmNocm9uaXplX2lycShkd2Mt
PmlycV9nYWRnZXQpOw0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+DQo+ID4gQEAgLTIzMTIsNyAr
MjMwOSw2IEBAIHN0YXRpYyBpbnQgZHdjM19zdXNwZW5kX2NvbW1vbihzdHJ1Y3QgZHdjMw0KPiAq
ZHdjLA0KPiA+IHBtX21lc3NhZ2VfdCBtc2cpDQo+ID4NCj4gPiAgc3RhdGljIGludCBkd2MzX3Jl
c3VtZV9jb21tb24oc3RydWN0IGR3YzMgKmR3YywgcG1fbWVzc2FnZV90IG1zZykgIHsNCj4gPiAt
ICAgICB1bnNpZ25lZCBsb25nICAgZmxhZ3M7DQo+ID4gICAgICAgaW50ICAgICAgICAgICAgIHJl
dDsNCj4gPiAgICAgICB1MzIgICAgICAgICAgICAgcmVnOw0KPiA+ICAgICAgIGludCAgICAgICAg
ICAgICBpOw0KPiA+IEBAIC0yMzY2LDkgKzIzNjIsNyBAQCBzdGF0aWMgaW50IGR3YzNfcmVzdW1l
X2NvbW1vbihzdHJ1Y3QgZHdjMw0KPiAqZHdjLCBwbV9tZXNzYWdlX3QgbXNnKQ0KPiA+ICAgICAg
ICAgICAgICAgaWYgKGR3Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0MzX09UR19ST0xFX0hPU1Qp
IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZHdjM19vdGdfaG9zdF9pbml0KGR3Yyk7DQo+
ID4gICAgICAgICAgICAgICB9IGVsc2UgaWYgKGR3Yy0+Y3VycmVudF9vdGdfcm9sZSA9PSBEV0Mz
X09UR19ST0xFX0RFVklDRSkgew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBzcGluX2xvY2tf
aXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIGR3
YzNfZ2FkZ2V0X3Jlc3VtZShkd2MpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gPiAgICAgICAgICAgICAgIH0N
Cj4gPg0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4gPg0K
PiANCj4gRGlkIHlvdSB1c2UgImdpdCBmb3JtYXQtcGF0Y2ggLXYiPyBUaGUgJHN1YmplY3QgdmVy
c2lvbiBwcmVmaXggb3JkZXIgaXMNCj4gZGlmZmVyZW50LiBJbiBhbnkgY2FzZSwNCj4gDQoNClNv
cnJ5ISBJIHVzZSAtLXN1YmplY3QtcHJlZml4PSJ2MiBQQVRDSCIuDQpJIHdpbGwgY29ycmVjdCBp
dCBpbiBuZXh0IHBhdGNoIHB1bGwgcmVxdWVzdC4NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gQWNr
ZWQtYnk6IFRoaW5oIE5ndXllbiA8VGhpbmguTmd1eWVuQHN5bm9wc3lzLmNvbT4NCj4gDQo+IFRo
YW5rcywNCj4gVGhpbmgNCg==

