Return-Path: <linux-kernel+bounces-225539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141C9131E7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 06:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04CD11C21109
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E8BB674;
	Sat, 22 Jun 2024 04:16:04 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E97FD;
	Sat, 22 Jun 2024 04:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719029763; cv=fail; b=h97AuX9Q2dmiP1w/QHatG615otw6dIOoEogz38FbZoV8BU65Y91IyJ/yYwUC2XLv7WdnZQHzR7DYNXU/DfnAjbUbWpyOl32NVytKsIaqsjDv+iq3pEkK2Wgem7O+K9PAx35bt1274jFkwpKhP99dBuWOJTqG/wFaOeUXIl6bqs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719029763; c=relaxed/simple;
	bh=daTePkZM6kENE/lyG3xSGVZ8MKDrZj/cRURWuiCqB0E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rb57FIN1tlK/+7UkdhjHD0uIlcAqcP/ePuc4JkFsF/E24fddH+Fj30JOKGfgisZTGdtImfkPIslAmv8hyf1VtxRWJli9rYwRqpxSMugJTSyx3Biy3EHEGnRCCm/cQtPhD962JHR2mgaD3ypbmdAG31UP+W8Ds5+ZEa5MGP9iWcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45M3olCp013246;
	Fri, 21 Jun 2024 21:14:53 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3yvrmq9dtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 21:14:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZPksKOcoaSWC1QzQ04j7cG1oCsFx17OuHBYtw0bXV5/tE/PZ26oVC4hqBDpXrsnqNzmtNgUy7LRxc/+Crd1HH0pcBAynb5Z8i0rAZRWrZlLUQBzX+p1RgdkdLp7xsZosX452AxGLW2A04JDI9FXPF78Ix/CdlPFNrL8c7KgYXGpkAAdIgBmRmNwn+T1blB3JO6YJpSc4Ah+NEag+eDj+TLWn8k4qEzkuWRn5R9klQTbyz5tukojqZPQlSu2X5HvMLiZ9aIxuAfLlcxw54j9v8YWzpv5RCb4mbyAWvLHQUuaTrbJLCesxMgTaX3rdWsVjCv7FF/SJscWxRtOh7YHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daTePkZM6kENE/lyG3xSGVZ8MKDrZj/cRURWuiCqB0E=;
 b=fS7aVJH1jKGox1fttfoiNKoPMGYNU/BqzT6wyaLZ9CryJRY6g1evH00Z9KtCRO9vSZHXpORzpoJPnIj54F6zHaixc6Q4//ADrHStTF5KnM9NXpYElewv6SlfFiApc5UvKEa911rXDZVsmNaDn24W5MRoZSwaNnqzVEH/MOnFhkEWmZ5HNI+p651gKOCKGCg5gSmPt5m4FUvAW3WgUT2GWI9qf3GJG4VnbB8w1S7U89cOl7fZ8k08dUkmqvLTDaLRng8uMvBSAv0/y3wAPGvO08Av3Ok3xVYnmxeacwQx1hGW70LzWaz2cnUDkpWTe68acpggZFNRqgdYOTxnfwLC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16)
 by MN2PR11MB4647.namprd11.prod.outlook.com (2603:10b6:208:262::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Sat, 22 Jun
 2024 04:14:47 +0000
Received: from CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::e104:97a:236a:1403]) by CO1PR11MB5188.namprd11.prod.outlook.com
 ([fe80::e104:97a:236a:1403%3]) with mapi id 15.20.7698.024; Sat, 22 Jun 2024
 04:14:46 +0000
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
Thread-Index: AQHawS5aCFFqer72NUq3CfqcbCbWwLHOEbSAgABBTyCAAANxkIAEiMcAgABTePA=
Date: Sat, 22 Jun 2024 04:14:46 +0000
Message-ID: 
 <CO1PR11MB51887F1AE3B57A1FFEEE79AFF1CA2@CO1PR11MB5188.namprd11.prod.outlook.com>
References: <20240618031918.2585799-1-Meng.Li@windriver.com>
 <20240618215356.hw6ar6guxbhlf5y7@synopsys.com>
 <CO1PR11MB5188DA129618E46A1257F059F1CF2@CO1PR11MB5188.namprd11.prod.outlook.com>
 <PH0PR11MB519190ED0D42D88805122372F1CF2@PH0PR11MB5191.namprd11.prod.outlook.com>
 <20240621231439.ii4j4bkuanbpgxgb@synopsys.com>
In-Reply-To: <20240621231439.ii4j4bkuanbpgxgb@synopsys.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB5188:EE_|MN2PR11MB4647:EE_
x-ms-office365-filtering-correlation-id: f6761c6f-0cb9-47f8-735e-08dc9271da2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RzlvM2tsTGtxV2FoWmM3NTI5cE4weXFYS0ZLei96eG1RdHJleERVNkEyR1JO?=
 =?utf-8?B?Q2VwL1JlTUx4bGV0NCtqZlRDY0ROaWJkWEJjYTJpREMzMTBHOE1nZzFnRWZU?=
 =?utf-8?B?Y2NHaGp4TVIrdzV5czhPZlN5MUV5VjBOQjlZRzh4RnJ5Nk9uTjN4cjQ1SVFz?=
 =?utf-8?B?MG1NOTB4U3RibjlkcWdOeWVuM3dWQTNnUlh1Q1RUV3RRekpKbHdrWXJhVEhC?=
 =?utf-8?B?YXpxT1hFV2lNcDhiQWtRYXRHYXFIaGhDNU5zSFF1OWovNXNhZG1wOFJDc0ZS?=
 =?utf-8?B?QlVaWnQrc0RDK3Z0KzZhdEpUY1JDWDB4eGx5cm5DOXhZTGNTaGxYNHFSV0ZN?=
 =?utf-8?B?Vk4ycTNoU1ZYeXVoRjlXWUE2ZnNHM2xORUt3VTVWaWdLVkdEOHRrYkRWMWto?=
 =?utf-8?B?UXZ3Y0pMNlBNY0hrTUU0cmlNWEV5UFg3ZGFvYmc1eC9kOWdrZ2x0Sm9YWnJr?=
 =?utf-8?B?bDZEOGxOYUI1Uk5KemluR1RiV2xGdFZqL1BzRzZUdEk1Q0ZNM3VLa0FkVFZk?=
 =?utf-8?B?aUpCR2NiTDRGS0FVR2pUMHlJV2p3ZjlXdWtTMUVEQ0dSUEY1UnYzNGRpb0w5?=
 =?utf-8?B?b3B0dEdpL1h4amZGdXdpWmQrVGpLYTcrYTBLdklvUms2TzVsVVQ2MWNMbFEz?=
 =?utf-8?B?V2tyTmNJN2JNZEl0VGVxNkc4cXJSbW0wL21ySytRVnQxSHdwWWdDZVVpYkpl?=
 =?utf-8?B?eThCNnRwcW5od3Jod2dDQzhaelFKYTVMcHNTUHJsdXFWRnhsKzEvVWY5TnBa?=
 =?utf-8?B?dUFQSmgwYk5jQ20wa2hEMnBZL3NTQzhuOEFweU9jMElUb2tCSEpSdHpJQWxD?=
 =?utf-8?B?VmZRVEpsT2hFWWhOY2RsSHNUcUxlajIrV1UxejFraWVIZ242ZElmSHA4QmJV?=
 =?utf-8?B?bnFhcFYzeWxTRFhOUnFWd0NtTTdrTDJhcURzOUdVUVNvTG5lVVNlUFVHZStI?=
 =?utf-8?B?L2Y0M0xTYmt6UjVNMjBZb1REYTFUM0U3NUw5cEVDbGgwekw5d012dUFPY09J?=
 =?utf-8?B?eEtwYkRzSHdSQitWbVg2RVZWNlpPanY0Q3lwWEkvK2laTkZZYWx5TkVWMXJh?=
 =?utf-8?B?Q213cG1oeTJXWnlWS3FVenhkYmpBc3J0MHNjenhWWUgxRFFtQXBORmJxb0Zh?=
 =?utf-8?B?ZVFKUGt1cTI1aHNob0ZqdC9vMkszMGhlZmdzemFoL05CQXBpSFpzeFFKK2sw?=
 =?utf-8?B?QlhKMDFlcjZESCtTemI4dFBjWFJWRnRtYWZxR0czaEUyaUl2V0VxVVh5QmJr?=
 =?utf-8?B?M05LOHNZRCt1cWhXZGlTcGl1T1BvWEIvemVqRW94dE5ZL2R5bUszS1JibURy?=
 =?utf-8?B?VjkzZmFFUjI0VDRWRHg0NWtxTWdvdi9MaFhCTFozaENLVno0NUl1YU9tckx5?=
 =?utf-8?B?SlMwOHFwdDlrRHhDZXRyQ2dhMk1FSFd0Z1ZCbDZJMnZMY0tPMFdJbTVFdUpU?=
 =?utf-8?B?S2U0MnIxMnpYOGVGdVRTQlhMTXJBdjBHT2laTStCZ0RZbGFsdWdjNG9tSWRh?=
 =?utf-8?B?bEdlY0hoRVpOWDR6UFl0clRaTlRlTzNnSGdLTU1VU0lCbktWeEtzeTg0MGtW?=
 =?utf-8?B?VUtkcXFIOHpMQjdnbmxBUkk1cnJibDZiMitLMTI2U1lEZW9UcXJkdHNObXJa?=
 =?utf-8?B?U1g1eFJLNnd5NTdWTFhMK015VXRsTHVHUzNjMGE5RFhuNDU0WnNETTdWbEtP?=
 =?utf-8?B?cnBRV0dZYWNCaFVwNmJZZ2ZwTnVxeGJjOWJOMGNnSml3ZXJSVnpCOWpLSXJ0?=
 =?utf-8?B?YnM1RmJmZFljd0pHdWRNRVgwR2lZZ3dpcGhsNStWV1hKR1l4MFRJbEJFdDZP?=
 =?utf-8?Q?QMxp1EDL966X6xEP8PY4L6oLKOwGJZyzvK8HY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5188.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bVphTjlvaitXMWJpYkdZYUVUY1A2VXQrNDV1WFJWbFVzbjk2UldKWGZtajBZ?=
 =?utf-8?B?U1BOank5NmQwTlI2c3lWVExkTGNWSDRHZGdHR1JSMXlNSVVvUm9wamlwS3NX?=
 =?utf-8?B?WkxtYzU3bHl5aG1IUmpCWmliV3h0a3JnTGhvdDA5bDdWVmdmMDhKcHkwMWsr?=
 =?utf-8?B?ZndFZTIzNXlDZ2tGdHFEQjNYTnVmYmE0SXA4T0FMaHRRSXFkaWhVMXlFSnJZ?=
 =?utf-8?B?eVJBbjVWVlNybTdLRGFUVnFWemUvSTgwTlN0TnFDUzJEMmVjVGZmbWVoaFpY?=
 =?utf-8?B?RmdWWWNHa2FkSE1wcDRRbDE3OEg0U0hxREg5eFRRTysyRjVVcFlwWGJQd2k2?=
 =?utf-8?B?MCtXYXBuRTd0NkRHZTQrTFVQT0VYRktwWFhlNHZXT2NGZG9tdmZhaGJvUmlK?=
 =?utf-8?B?SlE5WnBvbEhUa3ZDY2E3eVYrMUZ1TFZ5MkZUalgvaFgvcWp1VjVTVzF0N2xL?=
 =?utf-8?B?cytkQTJ5d2E5bWJGUVBJRlhnMFR4MDhYUmtWaldOdUoxd0x0R3lWRENxaXEv?=
 =?utf-8?B?R3pCdTZjb1N0NDRYRHpMQXovWGwwejZrcCt6TE1ZbW9kbkxxSnI2TEU2OWJS?=
 =?utf-8?B?NFFSdnRXVDlUWkVPZlpGYXo4TzJSTmcxSFZtcjJPYWpSa1dTS2dURURjdEJi?=
 =?utf-8?B?RVZRRlRodUN2ZnlONlI4eE1pNHRiWFYxRFFCSmFvcWh0QXpSUVJtTW5vSk53?=
 =?utf-8?B?aXdsRGtuaXh2NUV1VXI3ODJRdG9DOTNlbjZTYjNPVXNWdmN3Z3pLUHBwc2lH?=
 =?utf-8?B?QlB6c1hEbW9ESkRJZUNmaFUwTi8rM3JFanhGZTBQUVI5U1Jwd2l4TFRrM0w4?=
 =?utf-8?B?ZDU0VXVYTGZMc0cySkhTVzZGNFY1L2R1cVVka20yY3BhcjRNL0FHOEIzeGFm?=
 =?utf-8?B?RUpyK2ltaUwwc3FrM0ZZQU5UTDhwdjl6dXR4ZHNsTHRlay9wOHRtejJGRXVz?=
 =?utf-8?B?bnR5MVlwZUwybjR5YmhMdk4zdkVCWWhJblZmdlpSKzIza3BkZFE1OFJhVEZV?=
 =?utf-8?B?U3FNM1hoOTVKUU1Dbkxwb05KaWo2cFVNSzdtendndUx4NmhxVExNZWRXSUNB?=
 =?utf-8?B?RFhyVUxKWEhtSjIwUzZHNm5Rc0xubjZUQmdyYkxPa2ZpZGlaNmVhNUx3M0Rs?=
 =?utf-8?B?SEorcEE0UUR5VVhwYXRRdGxKSUZpdVA4Q2xIS0JITWRRSHNHS1ZaT2d3T3NB?=
 =?utf-8?B?YTE2NWRyaFE3eVh1SGlXU1BYL1poYm94N2d1OGNQQ1ptYjJpTFd0dlNXTTBk?=
 =?utf-8?B?NVRBL1JtQ3BiMjYyZGlaaUh4Ty8xUCthbmEwdTNrV2JCN1M3WE1rbk1BVFV2?=
 =?utf-8?B?VWV4cUREaExQQkI1dWErd3lxUzR4akVuUFJNYTN0T0FhbVJMZzdLMXJRKzhD?=
 =?utf-8?B?TXpadGFqcFVPTEN1T0RGQ08wb1NXWkEreEp2TW9hU2EzNzJGNXFTaXE2MkpX?=
 =?utf-8?B?Q1I2NmJNMUhlM24rWHc3OXNQNjNjaWdYMldMdGRqamUyMkkvc3lpVkJXTHEz?=
 =?utf-8?B?QjVsbk01N2o2L2NTZkZUNTBpK3d1MXFralNtV0lreVB4SGhDeXBTSEsvZVdy?=
 =?utf-8?B?dGVvRnBWZTk0b0dmRXl0YUxjYmhyZlA0eThxNUhQQ1dJV29RdFREYWs5Y1BZ?=
 =?utf-8?B?SEgvUmp3YUpoclNWOVJVVHVXdkJ0a1lneFhXVU5tR3ZtT0hRc0Q0blIwQ2t6?=
 =?utf-8?B?YmNCNitVOURlamNaVW13dlRyZUJiZk5aQzZQcmpFaU0zQjYrQ2FVaFNpd3hx?=
 =?utf-8?B?R1FERDZEUFJ4Ry9ETnVJZzhyQ0RBbWxLQ1VYVEFsMFRlbHc1N3hPRWV3Y1Bp?=
 =?utf-8?B?ckY5c2ExVGZRWjBnTXlPQ2crK2FYejMyQ0RqSWkvVnprYjVybFpkNnBuUUlN?=
 =?utf-8?B?SG1LYUw1bHhpcEh1V001NUNpSlNzWmRDaFpCQlFocy9YQ1FRU1hLYnlvdkFB?=
 =?utf-8?B?YUZvSEVRK1AvUE1hYzJpWlkwWDdpVFpnWlhYSVpuandCanBSQWVuN0RlQmNk?=
 =?utf-8?B?NmJzZlNEaVZhRDRyd2dJS2tZbUgzQkdPNWxmdWMyVFdwN21TVWlYNEZZSlhJ?=
 =?utf-8?B?UlJrblcwZFlnTm5RMCtBM3MrWWcwWVNDYjBrK1c1bHRKZk5qSUY3bGVidUpF?=
 =?utf-8?Q?NPitOvmZlLXUXZmDHYMR6mb8k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6761c6f-0cb9-47f8-735e-08dc9271da2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2024 04:14:46.8652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWuLia0/5z+p8OdJplqSDSXGnKLloqGTcmlYqVjenxA2oDzyFUBSpQXa8EaxLnpqDFMmmQuZKTcLFfXTpbX/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4647
X-Proofpoint-ORIG-GUID: sLtaU_iDw5C9iKbTNKS4NkqaZAgRnpr1
X-Proofpoint-GUID: sLtaU_iDw5C9iKbTNKS4NkqaZAgRnpr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-22_02,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=754 suspectscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2406220024

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhpbmggTmd1eWVuIDxU
aGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgSnVuZSAyMiwgMjAy
NCA3OjE1IEFNDQo+IFRvOiBMaSwgTWVuZyA8TWVuZy5MaUB3aW5kcml2ZXIuY29tPg0KPiBDYzog
VGhpbmggTmd1eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPjsNCj4gZ3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc7IHF1aWNfdWFnZ2Fyd2FAcXVpY2luYy5jb207IGxpbnV4LQ0KPiB1c2JA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB4dS55YW5nXzJA
bnhwLmNvbQ0KPiBTdWJqZWN0OiBSZTogW3YyIFBBVENIXSB1c2I6IGR3YzM6IGNvcmU6IHJlbW92
ZSBsb2NrIG9mIG90ZyBtb2RlIGR1cmluZw0KPiBnYWRnZXQgc3VzcGVuZC9yZXN1bWUgdG8gYXZv
aWQgZGVhZGxvY2sNCj4gDQo+IENBVVRJT046IFRoaXMgZW1haWwgY29tZXMgZnJvbSBhIG5vbiBX
aW5kIFJpdmVyIGVtYWlsIGFjY291bnQhDQo+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kDQo+IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IE9uIFdlZCwgSnVuIDE5LCAyMDI0LCBMaSwgTWVuZyB3
cm90ZToNCj4gPg0KPiA+IERvIEkgbmVlZCB0byBzZW5kIGFub3RoZXIgdjMgcHVsbCByZXF1ZXN0
Pw0KPiA+DQo+IA0KPiBOby4gR3JlZyBhbHJlYWR5IHBpY2tlZCB0aGlzIHVwLg0KPiANCg0KVGhh
bmtzIGZvciByZXZpZXdpbmcgYW5kIGFjY2VwdGluZyBteSBwYXRjaC4NCllvdSBoYXZlIGdpdmVu
IG1lIGdyZWF0IGVudGh1c2lhc20gdG8gY29udHJpYnV0ZSB0byB0aGUgY29tbXVuaXR5DQoNCnJl
Z2FyZHMsDQpMaW1lbmcNCg0KPiBUaGFua3MsDQo+IFRoaW5oDQo=

