Return-Path: <linux-kernel+bounces-432615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2E29E4DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C47028529E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6C5194137;
	Thu,  5 Dec 2024 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iw3o5N46";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Mh8ErwoD"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F4117C208
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 06:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381408; cv=fail; b=mpEx/fEmvNB3oOxDpJgyroEIVcyCucNkLJkydz22rJI10GDJ6WXUDeGjCZWywps0HEZ7XVQ6Pw2NHp1zHb6kH/+jbMLA1eo3dGMHAfwza9qmY2fAINtuQqJZWde++Fn7V6jfqnee//gQbF7bgDoSOllKgAMROlN8hq05XB6lwh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381408; c=relaxed/simple;
	bh=8jhvdmt6+UZYmIF/OIApmaC7D9Def/LS6FLQMIMp2LU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QM5zgkNpdKHbXds5fzkpKhp0Be0/+Sy0tFq1gCkq+gd3psIYFeUPiZDSSyS7cH42C/h8aVLwotZ4EXL/+6ZWLB8ofGb8wzmbzhjlGiDpgM3cMCB+1W9uLmDBDT/v60aRv/1+Soe9f2Oc8SEI+hrjAgiGov9p60d9R+aODRtShKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iw3o5N46; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Mh8ErwoD; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 24e48ba6b2d511ef99858b75a2457dd9-20241205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8jhvdmt6+UZYmIF/OIApmaC7D9Def/LS6FLQMIMp2LU=;
	b=iw3o5N46om0aTwfC9RiKw+k6+Rvc+kTb2h+E/x7EyHK8Lsmu48/2tByV2WMJc2NP3Wgp6esMYBj61zS+kPC21cIIZL+lHNZxS6+KJX846YhL8dbZ2VRp5hLzXf91kp7SwXYRd9AZ1o2tQGtG44mwCRh/oMJaYxrNi4S1BuIVPQ8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:b12e5fb3-870e-4568-a9b5-e1add3412756,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:8ff1f6f5-e524-4511-b681-7d630745cb54,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 24e48ba6b2d511ef99858b75a2457dd9-20241205
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1782319705; Thu, 05 Dec 2024 14:49:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Dec 2024 14:49:57 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Dec 2024 14:49:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwIDF3UkB5iSy3pBSkD0auOVx78gSYQvYzWO8Su5RcQc6UCi/ZN3LoR514NBNTPt9USE8PiMqoqxFf6T4qCONcvxl3pW1trqe2JfaIggohJWCpjM+JxkViwdCRemy7iKN4+35sIc9GvvAuOefCNSvrPSHWQPGkjom0ALD1CMGExfMCUdhc1cmNkqkmXhni2ycyNLfXkhg+OTS/JnlD433lW4gHreU2vMilva3JA2InDw3MdNotJoCcYoO6Q3LJckmIItxR8gwY/2Ba130Mw/6fT3kCZNJ2oXVLJsAfdizNwUokBay6s2J14i6tBb370m6aADsaBEdB/dV6OCmAzdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jhvdmt6+UZYmIF/OIApmaC7D9Def/LS6FLQMIMp2LU=;
 b=eoIWTskbMBijN+N0zL39K9nSDm4KMKFHSbuDLYRNQs3vB+nM+fTWqIZosncdQHEMEirjY5kUWx2EfyylGdR0j8PK9kybLni566bg2KAxmX707AVkwjPsTRB1ojvpht8x/wqUTPOqG9yT4ZFgJxvWwGDmnX85xIK4kVpceBtpZKqbCyNlAhftmKMu2H40ylW83pirYtYNlYZi5hVMm0ue21/tcybD0ofnzvDIcF+0u28HU7+uTwiBOB+nFdnNxX3EOZfgkP0z1aaPaJLKG9588LhR9Ss6fPRCUL7ojrdr1vhbitsZX0AqpSoc81175kYQY0DX+O4QzOqi0Mlre6h1Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jhvdmt6+UZYmIF/OIApmaC7D9Def/LS6FLQMIMp2LU=;
 b=Mh8ErwoDtgaz38P1CinCxocPxib9rkLGaoe6ZdXNMr2rZ7kqZ1edELa10mBgEbFXdUM9OPjPLlhIBMIxCpAOeAo41AT+SeP+yxHXyjQNUFJMSSEkAZQhN0fXyy0tujmFZzde/bPMy4ls0ybpzrzIWT2gQ9soa3nlBhVnlcvYFyI=
Received: from KL1PR03MB5861.apcprd03.prod.outlook.com (2603:1096:820:92::6)
 by SEZPR03MB7171.apcprd03.prod.outlook.com (2603:1096:101:e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Thu, 5 Dec
 2024 06:49:54 +0000
Received: from KL1PR03MB5861.apcprd03.prod.outlook.com
 ([fe80::db90:295a:45d0:8831]) by KL1PR03MB5861.apcprd03.prod.outlook.com
 ([fe80::db90:295a:45d0:8831%2]) with mapi id 15.20.8230.008; Thu, 5 Dec 2024
 06:49:54 +0000
From: =?utf-8?B?S2FybCBMaSAo5p2O5pm65ZiJKQ==?= <Karl.Li@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Q2h1bmd5aW5nIEx1ICjlkYLlv6DnqY4p?= <Chungying.Lu@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QW5keSBUZW5nICjphKflpoLlro8p?= <Andy.Teng@mediatek.com>,
	=?utf-8?B?Q2hpZW4tQ2hpaCBUc2VuZyAo5pu+5bu65pm6KQ==?=
	<Chien-Chih.Tseng@mediatek.com>
Subject: Re: [PATCH v2 1/1] soc: mediatek: Add command for APU SMC call
Thread-Topic: [PATCH v2 1/1] soc: mediatek: Add command for APU SMC call
Thread-Index: AQHbKmxKqyxLtS50ckyGmVfpOQ/CsrLXbu2A
Date: Thu, 5 Dec 2024 06:49:54 +0000
Message-ID: <b8de718de8d5b5357f67183c1d283180aff33f62.camel@mediatek.com>
References: <20241030013533.855696-1-karl.li@mediatek.com>
	 <20241030013533.855696-2-karl.li@mediatek.com>
In-Reply-To: <20241030013533.855696-2-karl.li@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5861:EE_|SEZPR03MB7171:EE_
x-ms-office365-filtering-correlation-id: 3c1b8d6b-bf79-47c8-4571-08dd14f90654
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWZEVEpuV3FSNUJQNXRobHZvM1lJbmNQNktWZ0ZUQzgwQXh4OVJwWk5nUkZk?=
 =?utf-8?B?MDR3dndSM0Vrd3pGNHZHOEc0YnZ0MXBZRE5Cai8zMGszVTJvd1E5Sit0bXh1?=
 =?utf-8?B?K2h4eFg1c2ZvUFltNWpaN3l0RFVQYnUwb1RxTVkySmRXSGN6UTdsYjd2anZt?=
 =?utf-8?B?VXVLa3RBNDVKQVVvY3FGa0xhdHVKczZ3OElMOWJjRW5IbU9pTktybnZvZERr?=
 =?utf-8?B?YWt1OUJvNlNwMEhhazVpQ0pDVmQ0QmFnMDJaZ05ma1NjZWNyc1ZmRDRYNk54?=
 =?utf-8?B?bGxqMFJINFdjL1hma2JjWTN0SXBFRUhJSDZKM0JtekF0dzVSY2hvWGpubDht?=
 =?utf-8?B?ZjlGV2hhR2dzYWRvN3VNMHZwZlhiZG4yYnJ6UTB1SjltVlRCMVFwRDEzcVpk?=
 =?utf-8?B?bUx2alNiSm9LVmV2S21ZMERlR3QwdElnK25qQnRWaGNpMFNUcXVUVHplZ3BK?=
 =?utf-8?B?NUVKZjJsUEpZdWR2REIwT2tETUcxaTc4N1I2cEVoQW02QnZrRW0wcnhpeWdE?=
 =?utf-8?B?c2FMTElrZ2VCUzlLazFYdk1ubkNGdHBDRFV0bUlMUVZnaG1TYnFGZ1lrV20w?=
 =?utf-8?B?WTJId3RLNm5iZ1VJajc0WDJEUmFmM1kvZzNPYTJRNFVoZW5iUW1WZThJRTVY?=
 =?utf-8?B?eDcrWm5jajFlWFY2aXp2OCt3TytISUs2VDd0QTlERXNBODdZV3VrN3hvekNN?=
 =?utf-8?B?RlNvVElXMkhRWnB2cElNejVtWk5NZ1ZlWVRDWkZVd0l2d0J1blpkam83bC80?=
 =?utf-8?B?WnRwVE9Cci9YSFhZVjM3Zzhaa1JKdXEySTd0NktKcXRnVEN1b3B4NjZvQjRn?=
 =?utf-8?B?bDI3TTFQZFlGQmFsT0tST1NsOUhQdEs4ZUw4Z0NDcWVzM016RUcyeXhoUXRZ?=
 =?utf-8?B?VDFwOUtSZDd6VVZSdWExNjM1dFVlZnlHYVlqTDNiZnN6c0Q3T1d4eVBUSDY3?=
 =?utf-8?B?c1hOTHE1eGRNTjFFdWl2TWZFUnhHcXJqdlNFM1pkYlhNc2dCS3lwVFdJWTlz?=
 =?utf-8?B?SGF3NWxmR3h4Z21qOFdQbFRkSk9qaFVOTEdJYWJHYmk3M1ViMXhoaFlsTFl5?=
 =?utf-8?B?SktVU01tUk9aZU5BMS9Rd1NFVTMxcEVqRGZVaGJOekFLcUhJUFU0L2tSMkhV?=
 =?utf-8?B?aXQ0cS90a1FNTEdBVnZPcTgxTEgvTlVFWW9qcVJMSm9iRTVFYWhqWUYrOUVM?=
 =?utf-8?B?eHQrMndoTitPbzVkUS9rc1kyT0tLMjcvbFhUZUJFS21kdXk3N04wWDFhU00w?=
 =?utf-8?B?OTA4RHd3SmU3c0JyVGIxNFVlSHNKYVp5UWIwU2w2Tkp0bG5DZzE5d3ZBbEt4?=
 =?utf-8?B?N3A4WndMb2ZMaUF0dXlCTE0wY0Q0eGhYV0ZSQ3c4THJGb1NpSVMrZitYOU5E?=
 =?utf-8?B?bGJmbUdKME5FRTV5OVdlalU2dHBHd3FCQ0dYZzlHdlBRTzdGRHBJaHdNTmxr?=
 =?utf-8?B?YnRjQWJyZWhqK3JnQVg2ZDE4djZTK0JpbmovY25BUXN3NHdLdm9hODVRK21Q?=
 =?utf-8?B?aEVTMS8vbnJQTWhvWGszL3cyd0c5dW42eDFqendNTkZyRWZ4bm1QM2l5M1lx?=
 =?utf-8?B?bjhrV2VDbGJKNGZOcWdJRmZnSTltYXZ3clVrUmVSQ25OMEd5OWF0dnNwUEt0?=
 =?utf-8?B?UW9ObEdtR1ljR2NWdTBQM1d2Y2xFYzN2bkllMUZETWpJYTVqTFlMSkZDTjJX?=
 =?utf-8?B?Y3Y1RzBtL2VZdzFyWVYrRnpiVzdybEJGU0xoQVpZSzhxaGovWUVKTWJjeURN?=
 =?utf-8?B?VVluSktsTk0vdEtFSXRGR1E4U2xZWVJhNGVXQ2s4ZENuZGtxT0k5bS9RdnFJ?=
 =?utf-8?B?REJ5MXUwTXVBV210VWY2OTBkWTMxYkZCUUpjUkpjbTVWZWJjZjI3M1hwYmpJ?=
 =?utf-8?B?RFRYUGtqQ3Z3YXFWQjdzeDhoSmltTkFjSTIvZlQzNnNkekE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5861.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEVBMkI0Y3g5aS9FSXpFTnVtRE5wNnNVbXBuSG9HR0ZTV1RoMUFmdkJDS1hM?=
 =?utf-8?B?YXVYSElZQlJvM0NBTlR2OGptUTQ1UkEvY281eXRGR3h4NGo0WmRCaXZXaW5K?=
 =?utf-8?B?dE8rWlpSWkRNU2N6Vk1sUTVlc3J1NlFjM3VidzVQallPQ1h4RnRUOTlQUkVi?=
 =?utf-8?B?a1FRdE5sZjFRU1YreExlK2RWM2hLbmhCT0djei9SQW1YbHVvWVFBendSNTlm?=
 =?utf-8?B?WDY4ZXJHelBRUVM1MW9YYUdKcDlJTVJyZWhJckRmVjd5YkE5T2J6Tkc0Z3NZ?=
 =?utf-8?B?SmNuWVgrcmI0TXp3R2RBdk16YU5jQ2ZidW53SExTY2ZlcWJSbkZPdDR2RXg3?=
 =?utf-8?B?ckIyNUV3WEc0U24rd3psN3BBSk90K05uMUY2QXdXdjZIVE9rMEtMNTEzb1Z6?=
 =?utf-8?B?SjlwZTZNSExtTWp5Skw5Ry9HZ3pSZnpoWHIrSG5NbDZTMzJyRzY2RjZrNmdl?=
 =?utf-8?B?YlBGSTlFWUJBcDkrdnZUdUJGQ052ci9Pc2R2SUUxRWpaUU1uMXAySkVLWGtj?=
 =?utf-8?B?Wk9IZFJLNC9QZWtVYWxXRlB3SlRVcTNMdlBIZGI4ZGVXamY0TWhQR3haOHkx?=
 =?utf-8?B?c24wejZ6M1RyS0pxT1p5ZUNyak1GSGRrZ2dKMDlGYkErRU00bW9XT3plMmhE?=
 =?utf-8?B?cHozTG9XenZIM29pR0pra09yOUdIYnhha0pWVW5YeWdzdndXa2ZMM3g5TkN3?=
 =?utf-8?B?OUh2MmcwWVc0akFURm5KdmxmWFhNQ3ZvZXUwUlYrbGtRQ3FpNTZrYmQzSUFq?=
 =?utf-8?B?Y2ZQUkprVkJubGtibGIrd1pBY1lSY2d2MCswVkdBSnZvcVFETDRpVXE4U1Vq?=
 =?utf-8?B?ODE3WngyTUpZNzZ1L1pDUFJqd0JDeDRheW1adFlwdVliV0hVQit3S0JDTUpw?=
 =?utf-8?B?QWFuT1FXMGV6QjV6VTBzNkFnRzlvdVhmUHJQL3ZJS0hQVHhyUEJlSEVvRWx0?=
 =?utf-8?B?WGFVbk4reUZPL1psZEY2ZEM3aVhJdzdjU3h4VGxsSnBhMzFVdWNhc3VmcHRI?=
 =?utf-8?B?WVJxdEgrY0lxck5NSUxzNjF4SGl1ckpWa0x5ZjV6aG9yTnNnYjYxbFAwOVpK?=
 =?utf-8?B?SDVORkdkVnBuWmJPOUtoTGE0dEF2UXovMWRTbWp2T1Z4eDVxQXRrdFlIblpw?=
 =?utf-8?B?RUszbko4elg0cURVcWZ2QVg1cWJLLzlsUm56cUJ1R2x2VmE4YlFIYm9kSkpn?=
 =?utf-8?B?NUdJN1djS3kwQkFPRWJMOFNreUcxS2htczA2SWlWN0FCSDVuUDlmUVdxcjdE?=
 =?utf-8?B?NTFQbWRvYTJZbjVkRlVoSWRSWFRPWEQ4L0w0Zjh6a21GOTc1TnZ3SldUTzM4?=
 =?utf-8?B?aHUreDVTUHhyWHh0RU92NmhmaENHQzlYWkNZZDh6WWdrSTFTaDdJbzdRb2Uw?=
 =?utf-8?B?akZ2SXVEWWxXSVJIaXc5RXIyaWRKdG1ybGxLT3hyd1FJUmJpWVM1TUNGRDRX?=
 =?utf-8?B?WEJRWGhGVGo5ZmducW9kUld6OXA1QStxR29USnVoVGVpcWhzT0R3eVp3dU1w?=
 =?utf-8?B?TVFUc0QyTW5SQ2RGTHZhYWRZOXhiMkVPdStaWUxUcno3RUdsb241TThlNXMz?=
 =?utf-8?B?TVZTY05UWVZJUDkxWTVFdXcrNEN0SVhsMUVEMHZGNnhmdVkzc1ROQW1icGF0?=
 =?utf-8?B?L0hGWTdVZVZ0SnFtWVQvMEU3TzBRbDZudDIwbmYzK3dXNlUzMUJFT3hiSC9J?=
 =?utf-8?B?N0o0L1VxYURhUlBFOXdyWWIrL0I2SUdkRUIvd1hoaFV1dUhyY0hqbk9ONjlz?=
 =?utf-8?B?K3F0UEpFNDdJcnFMcGRmekpyV1FmaXVDOC85Qmw0RzV6bUpvUFhQaHRBR20x?=
 =?utf-8?B?eEhvWHNFTUhDejZaZHQ2VWRXMXRFWGE3eE91NXcvTFUrcmZlaVR3aXQ4YWZT?=
 =?utf-8?B?amtMMkN3VmxsMElOTE9lTXh3SFMwdGtUcjVQUFE5UXk1RW1vN2lrbFV4WExo?=
 =?utf-8?B?RDNsUmRKVEdWcUdrcnFTVWdwZmo1dUI1N3p5YTZVa2pzc1RHN0w1ajlIMkpz?=
 =?utf-8?B?bHRPRE94MUtuTlArNCtMZzNPTnEwcGlSZkd0RWRRMmtrQmxEdXZLbmUxbGpW?=
 =?utf-8?B?VUNHL3o4UVBCSlU2K1V6c1dzS25UMW5PZEFpUyswb0Y4Z3ZIazVpVG5mRWs3?=
 =?utf-8?Q?NoLCDTWUMHeTwgs1crvgWpgpK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C891B596B36094183DDDE68672075B7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5861.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1b8d6b-bf79-47c8-4571-08dd14f90654
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 06:49:54.2048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMcByy8qLdLugyDTjuS1qF9RlcJknfzZYxhzgyHYjpfAnGCu/6IVAXgfcirDCAcGTQuhyBf2KgaL7eFE44ue5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7171

RGVhZCBtYWludGFpbmVycywNCg0KSSBob3BlIHlvdSdyZSBkb2luZyB3ZWxsLiBKdXN0IGEgd2Fy
bSByZW1pbmRlciB0aGF0IHdlJ3JlIGZvbGxvd2luZyB1cA0Kb24gdGhpcyBwYXRjaCBhbmQgcmVh
bGx5IGFwcHJlY2lhdGUgYW55IGZlZWRiYWNrIHlvdSBtaWdodCBoYXZlLg0KDQpUaGFua3MgeW91
IGluIGFkdmFuY2UgZm9yIHlvdXIgcmV2aWV3Lg0KDQpSZWdhcmRzLA0KS2FybA0KDQpPbiBXZWQs
IDIwMjQtMTAtMzAgYXQgMDk6MzUgKzA4MDAsIEthcmwuTGkgd3JvdGU6DQo+IEZyb206IEthcmwg
TGkgPGthcmwubGlAbWVkaWF0ZWsuY29tPg0KPiANCj4gQWRkIGNvbW1hbmQgZm9yIEFQVSBTTUMg
Y2FsbC4NCj4gVGhlIEFQVSBtaWNyb3Byb2Nlc3MncyBzdGFydCBhbmQgc3RvcCBzZXF1ZW5jZSB3
aWxsIHByb2Nlc3MgaW4gQVRGLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2FybCBMaSA8a2FybC5s
aUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiDCoGluY2x1ZGUvbGludXgvZmlybXdhcmUvbWVkaWF0
ZWsvbXRrLWFwdS5oIHwgMzINCj4gKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAxIGZpbGUg
Y2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2xpbnV4L2Zpcm13YXJlL21lZGlhdGVrL210ay1hcHUuaA0KPiANCj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvZmlybXdhcmUvbWVkaWF0ZWsvbXRrLWFwdS5oDQo+IGIvaW5jbHVkZS9saW51
eC9maXJtd2FyZS9tZWRpYXRlay9tdGstYXB1LmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
aW5kZXggMDAwMDAwMDAwMDAwLi5hMzI3ZTMxZDQwZmENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysg
Yi9pbmNsdWRlL2xpbnV4L2Zpcm13YXJlL21lZGlhdGVrL210ay1hcHUuaA0KPiBAQCAtMCwwICsx
LDMyIEBADQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPiArLyoN
Cj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBNZWRpYVRlayBJbmMuDQo+ICsgKi8NCj4gKw0KPiAr
I2lmbmRlZiBfX01FRElBVEVLX0FQVV9IX18NCj4gKyNkZWZpbmUgX19NRURJQVRFS19BUFVfSF9f
DQo+ICsNCj4gK2VudW0gbXRrX2FwdXN5c19rZXJuZWxfb3Agew0KPiArCU1US19BUFVTWVNfS0VS
TkVMX09QX0FQVVNZU19QV1JfVE9QX09OLAkJDQo+IAkvKsKgIDAgKi8NCj4gKwlNVEtfQVBVU1lT
X0tFUk5FTF9PUF9BUFVTWVNfUFdSX1RPUF9PRkYsCQkvKsKgDQo+IDEgKi8NCj4gKwlNVEtfQVBV
U1lTX0tFUk5FTF9PUF9BUFVTWVNfUlZfU0VUVVBfUkVWSVNFUiwJCS8qwqANCj4gMiAqLw0KPiAr
CU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19SVl9SRVNFVF9NUCwJCS8qwqANCj4gMyAqLw0K
PiArCU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19SVl9TRVRVUF9CT09ULAkJLyrCoA0KPiA0
ICovDQo+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX1JWX1NUQVJUX01QLAkJLyrCoA0K
PiA1ICovDQo+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX1JWX1NUT1BfTVAsCQkNCj4g
CS8qwqAgNiAqLw0KPiArCU1US19BUFVTWVNfS0VSTkVMX09QX0RFVkFQQ19JTklUX1JDWCwJCQkv
KsKgDQo+IDcgKi8NCj4gKwlNVEtfQVBVU1lTX0tFUk5FTF9PUF9BUFVTWVNfUlZfU0VUVVBfU0VD
X01FTSwJCS8qwqANCj4gOCAqLw0KPiArCU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19SVl9E
SVNBQkxFX1dEVF9JU1IsCQ0KPiAJLyrCoCA5ICovDQo+ICsJTVRLX0FQVVNZU19LRVJORUxfT1Bf
QVBVU1lTX1JWX0NMRUFSX1dEVF9JU1IsCQkvKg0KPiAxMCAqLw0KPiArCU1US19BUFVTWVNfS0VS
TkVMX09QX0FQVVNZU19SVl9DR19HQVRJTkcsCQkvKg0KPiAxMSAqLw0KPiArCU1US19BUFVTWVNf
S0VSTkVMX09QX0FQVVNZU19SVl9DR19VTkdBVElORywJCS8qDQo+IDEyICovDQo+ICsJTVRLX0FQ
VVNZU19LRVJORUxfT1BfQVBVU1lTX1JWX1NFVFVQX0FQVU1NVSwJCS8qDQo+IDEzICovDQo+ICsJ
TVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX0xPR1RPUF9SRUdfRFVNUCwJCS8qDQo+IDE0ICov
DQo+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX0xPR1RPUF9SRUdfV1JJVEUsCQkvKg0K
PiAxNSAqLw0KPiArCU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19MT0dUT1BfUkVHX1cxQywJ
CS8qDQo+IDE2ICovDQo+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX0NPTERfQk9PVF9D
TFJfTUJPWF9EVU1NWSwJLyoNCj4gMTcgKi8NCj4gKwlNVEtfQVBVU1lTX0tFUk5FTF9PUF9BUFVT
WVNfU0VUVVBfQ0VfQklOLAkJLyoNCj4gMTggKi8NCj4gKwlNVEtfQVBVU1lTX0tFUk5FTF9PUF9O
VU0sDQo+ICt9Ow0KPiArDQo+ICsjZW5kaWYNCg0K

