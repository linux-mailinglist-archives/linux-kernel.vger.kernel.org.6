Return-Path: <linux-kernel+bounces-510887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947BBA3233D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B21167337
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB76120896D;
	Wed, 12 Feb 2025 10:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pB2+uQ0E";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Jdm2mfGd"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459EB2080EB;
	Wed, 12 Feb 2025 10:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354880; cv=fail; b=LM7krj0+DCyxv4/Um9EPZHWgsxyYHpH/cQiJQGLWUfx6wdFP3Xhr5hTZCp+pQgw4GsqD/pifG6z1IYfDSWYrYJGNUVKr8+SDY83+bZukTgKNUy0X27XZP3Zpch+RRh8bIVnItSKBvTeC2EEytRx/eqMfPS+2PQ19B8ZSGc1ioM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354880; c=relaxed/simple;
	bh=5gXMKt75/xZdcjF4rw09pSjUFtl/BQqogNk6HiRuw6M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u+UJQFFXLMTOKzIyB0dbgy+t1eEzZgh+KLRe0CkPOHflvnJ2e5gecwBZ+qv8SPJyjT6qfOoEOfVyBVJzSN2WL/xRmAiLZq6tKaZaqpJmTW/yVgQRDBizEqdBFdyetrsTYcEjrrWbjik12HMaCoJlDzmINZUYBgT5qm8S+NQoF+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pB2+uQ0E; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Jdm2mfGd; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 37caf1d0e92911efbd192953cf12861f-20250212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5gXMKt75/xZdcjF4rw09pSjUFtl/BQqogNk6HiRuw6M=;
	b=pB2+uQ0E0GrGye1e4T6pC3UDSEurMHw72YNVZGbRSJkHw6qMvsnsG90SKvCpI4psKygiowzJbEs1aQdp+iFjrOR4w1bEQIB1Lg/LL65RF/Xj6w8GP3eDVPnSm0bRvrqSTlSvvFMmN9QbpQU5JM1hte5YC0boB8UFHYcedc9x+D0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:24d9fe4d-fd1f-4c96-b73d-64ac11eab8ca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:38bd5aa1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 37caf1d0e92911efbd192953cf12861f-20250212
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <crystal.guo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 666329589; Wed, 12 Feb 2025 18:07:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 12 Feb 2025 18:07:49 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 12 Feb 2025 18:07:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJV4sXSBDJInLnYkqG/TrDwyy3I/rt/jUB2QW0RMpZEED0sWkP7srnAggXZjOTAlqCPPIw2xUi02Hfs8XWvquO+EqFySantM32q5VyKQxvz4+kUK5c7He0pvjrn07+uTZoVOo/SSKoEVQa7EpiO7pfNpKjGSBPFprFn2jMpOP3XR2fwaue9NHPcmxFaE+T3c5fJ13Zkx7IRLapHOaJS/cvdRI2AaOmnzfA9lBBFaoX/lqsOgYwQvG11KBtIwjk42ZDzlc9Ax1R577hJZ13jJB4Xhciie5tclNsxvAYN3JiNjLeDtQe9dkCudjZklfjY3dynIT63gk01CE223CIJRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gXMKt75/xZdcjF4rw09pSjUFtl/BQqogNk6HiRuw6M=;
 b=EYoxCDzaP5fHWxNZiokVEjexJUDvRr+RjnW+uJuFn0t5V0H7mDYAhJzZFKWGzS7LIh1dCsMJbgBeZIpy965EhR+dxOgmlc1lH/vHv0/mRbgQkWPJQrlLnGEwAzVeH2MSIXjH8vLq6QOkaoWwaEXhRplKbticEuwRi9jbNEzGIMRZrkxIq70iU7RBKf+rqHios0WlwXukSgi5qI4azpDR+E3SpYXb8YsoCerYqE6MNj7YCS89/uBkw4xdIwoQShCY0CQPixmD0GIeX/l8Sap19Hw8QWNlH0odR0c8qMmsUk8oAKUY9BxJKPrfEPvbR7op2masnYiBOWZjoxQhf3ZaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gXMKt75/xZdcjF4rw09pSjUFtl/BQqogNk6HiRuw6M=;
 b=Jdm2mfGdKvt6KmLvhYNyjxfXvcWuHJcOtn7a6fZ1N4Xf1bXz8gTeWYdbkPzs39qBufPNqO+OCHGWlWimU/EKPz0IsLBDgAATEaoxF1398SwTxXCz9IXVi0AgdmLeXYkmlL12iXKqHTjPTx2nN34phmI2QVVczxhyXgbipFnliK4=
Received: from SI2PR03MB5468.apcprd03.prod.outlook.com (2603:1096:4:104::5) by
 SI6PR03MB8651.apcprd03.prod.outlook.com (2603:1096:4:251::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Wed, 12 Feb 2025 10:07:48 +0000
Received: from SI2PR03MB5468.apcprd03.prod.outlook.com
 ([fe80::28b5:41ba:aefd:a96f]) by SI2PR03MB5468.apcprd03.prod.outlook.com
 ([fe80::28b5:41ba:aefd:a96f%7]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 10:07:47 +0000
From: =?utf-8?B?Q3J5c3RhbCBHdW8gKOmDreaZtik=?= <Crystal.Guo@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [v2,2/2] dt-bindings: memory-controllers: Add MediaTek DRAM
 controller interface
Thread-Topic: [v2,2/2] dt-bindings: memory-controllers: Add MediaTek DRAM
 controller interface
Thread-Index: AQHbeQHh852dOXgO/k6/Tc8X/FZWJ7M+zx+AgARBfACAABzrAIAATGMA
Date: Wed, 12 Feb 2025 10:07:47 +0000
Message-ID: <468d079e89a5459dfe894402af10605c62676412.camel@mediatek.com>
References: <20250207014437.17920-1-crystal.guo@mediatek.com>
	 <20250207014437.17920-3-crystal.guo@mediatek.com>
	 <2942fbc2-55c5-4789-89d4-e4bf3158a34b@kernel.org>
	 <eb63bd2c9e5e31ff189d2c957bfcb4bd222ec778.camel@mediatek.com>
	 <43c6bc3b-5dac-4925-99de-76764ea77424@kernel.org>
In-Reply-To: <43c6bc3b-5dac-4925-99de-76764ea77424@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5468:EE_|SI6PR03MB8651:EE_
x-ms-office365-filtering-correlation-id: 7e8ca302-5ae6-4f4d-8bfd-08dd4b4d19fd
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?STQ4ZDRsbU96b1FwQmRjYlhNZWsrbkxIMFlZbjlvMXluRDdMaUQrVXN6elNv?=
 =?utf-8?B?YllMMnA5S0RJaVFXQ1Y3c3QyRjJHMkJSc3dsbzFMcXZNZGdUb0c4UVYrMXJP?=
 =?utf-8?B?ejg1RDNUWHlJcjRpRlIxSjFtbmlhSE44V0htUFp2NlJXK0RLZ1RURy92SUNq?=
 =?utf-8?B?MUFjcVVFNEpEZVcvaGQwS01NeTdGZGJQZThwbmdHU1RlTDlCMlhrUXNZbFdE?=
 =?utf-8?B?VDBzV0hIQ3pWNGk4Wm9BV0t0L29QWktJWWJBaWxJbEV3V29NS1d1ODlMZW1W?=
 =?utf-8?B?UUx6RzhKQXRJaXNtbVE1SHcrb1lHMWFoN3kwdVBtS2NBRmxSUWwrL1pROHNx?=
 =?utf-8?B?Vkh6SDdjWnZkMFR3SFpEWCs5NWhJNXdDeDhpY29xSDA3L3BjdjdsNDZYYzlK?=
 =?utf-8?B?emN3aXk3Q3RFaUY4RDI5bnZ4YXFmcFEwWDRyaVNESE5rcmNYWE1iTXF6Y1I1?=
 =?utf-8?B?TWRkOWovNGlGRU0xK253NGhjVm9xKzBhekpWOE1CZkt1QUJYdDluS2duSWtY?=
 =?utf-8?B?S2pGTjFraXVHalRGdUt6WHdSTE90NE44bkhMUlI4NVdFZHpKS2lnQ0FFNGhW?=
 =?utf-8?B?U3lFQ0Ywa2x4MUNxdjAzQm55RzlrZms2Y3RBYlU5NzVVYW1hVDg1aHBRWHFD?=
 =?utf-8?B?NzJxSTJtTG9lTTJGMXdGNGRPYndSVGQ2RmE4QUU4UmhobmhmaHM2OFVPbnU3?=
 =?utf-8?B?c3JhRlV6TFFYWlZpdG5uYW1ZNUVZWi9GMEdnL3JkTDBzSUJDZzFLU1kyQXd4?=
 =?utf-8?B?RmhWUGw0R1Jld1BoUFVZQnoxL2RwWjN3am1xc2taNTliS0QzQlZPSDJMWFFo?=
 =?utf-8?B?SE8zZWtKMzZFSWVhV1dQNnJpZGk3dmF4b0JUcENEQkcxWEZwNXpvN2l3MDY5?=
 =?utf-8?B?OHRYM29pRDE2M2FtdTJJNmEza3pkcTc1MjJUeFlscnRRWnBzUVRneFpwN1JB?=
 =?utf-8?B?WlhRSWk3VUpLekNFUlpzc0JPSGdkWG10LzN5bmJWRzhGL203QVV3UW9Qd2x5?=
 =?utf-8?B?WnJNRDl4Njg5a3VMQmlrbHVWeng4VU4rL0wwenR6ck5HaHh2eEFWWlZkVnVw?=
 =?utf-8?B?Q28wSi9nMkNNVEN3UTlHdVhuajFWQVVLZG4xa1ZsYWgxSXp4aEtTS1B5MUt1?=
 =?utf-8?B?TnlCejNLTXg4dEpjUDJjeGxOZzhLL0c2VU5QL1o2VWovRDN6cnN3TmI3ZFBQ?=
 =?utf-8?B?WmhYWXE3UzJzZWZNRktnWThQTmRjMEVnL3U5TUk5dnVDS1IwRWN4eFdTREw4?=
 =?utf-8?B?amZtSEYvRU5tR3BuUExUTzV1Wk90L0h4S2EwMU5oNFlpaUMzWDBYYmJ3MFAz?=
 =?utf-8?B?K2V2Qit5UjZrSzl2ZTBpdE50WW5EZVRuZlVQNXBBbjd2Yzk4c3pFb2x5a0s2?=
 =?utf-8?B?UndwWDhNenpKTVRYMzVtcVFXUEE0bk1BZGpTK2p3VWxFOUJEb2xmY09paEN6?=
 =?utf-8?B?RkdRSmw3am1YRmIxRlpHeVhDamZMZEJzQlFJQVJCWXo2cUZYaVlVZTBLSmhD?=
 =?utf-8?B?dE5KeG9udEhIVTBTcGNsM1Y1TTZQbFhXZDM4WGl3dVE5cUZ1R0Zlakp4NjRn?=
 =?utf-8?B?Z1N1OXVQdmFacWdRRXdmN1VCMDlZY1Iwd1hqTWFLS3QzVVU1U2Jpd3E1WVZy?=
 =?utf-8?B?ZTJoSjVuR09nQjJQaGxYWjlaWmJZMzJvMVFSak9tTDBOc21abGxjbTlaQWNr?=
 =?utf-8?B?YXBYMDZUMlNTL24xRnRWWlB3RFltcWtmeWI0VTlCMWxvVHp5K3hyaVRldStS?=
 =?utf-8?B?a3dRQ3hyVjdMWnNUaHpFZ0RBL2hJYnExamJINkVyZnJIazdtWGh6cHd2K25q?=
 =?utf-8?B?bEdzUTRGT0hIQjdqOTY4STNFY21XNjlrV1dOdUx4TmFiR21QaE82VjhGdTJD?=
 =?utf-8?Q?NSw455nG9udSG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXI0TEszT3B0czArc2Rxa0RMcHdBK0RhbnE4dHdDN0pDRzlBTUpGTkhWMEly?=
 =?utf-8?B?eXdvdkNwUHdFdlJ6L2JOT2oyMFhNYWdEUlpmSlYrcGNFUy93TDd6dHNDYzNQ?=
 =?utf-8?B?U1VmY1EwbUZsdzRwT3czbFRBYUlBQWJMb3ZNeUw2UnZmMkEyV0NzM0VlWDFk?=
 =?utf-8?B?VGlSVTZzem9ncXF2ZFJieVRCRUQ5VU16MDlPanFOdkc4Y2NNdUZ4b1hoL3h6?=
 =?utf-8?B?b3NOWWxDeDZUTGdudlFMaEhUUmFldzA0NWxkd1R2cUhJaG80MGdVZ1RvRDlv?=
 =?utf-8?B?Z0hTWHZwenM4dTluMHZrSU5NSHFiUEFITGpOZ0szUmdqdDNOMDRqSyt4YXFk?=
 =?utf-8?B?dTVzTURMcVlrejYwYTQxeU9RWG50SWhxWXVteDc5bklYVTdwbnRhM0k1b0xY?=
 =?utf-8?B?ZHFFbk5XK2twOFpMUnBRNnl1RWp1c0FVZ1FObDloekx6UDR3RktJNmRCRVVS?=
 =?utf-8?B?Tk5uRWU2UDI0YUhwZUdiRVUwRDk3Yk94UURhRGd2YmtkTjRVMFBrdGd3UFJY?=
 =?utf-8?B?MzhubS94U3JjcHRnR1FRT3ExT2FuVk9BbHNmMTJkdVl1WS9WaW4zSWxKOTRY?=
 =?utf-8?B?eGUxNnBpUmtHMmh6dExTVENITXpuUExRNkRCKzhlZ0pqcjlINTFNRWpUNC9I?=
 =?utf-8?B?Q2k4S3dBOGhwaTlaRWQ0VEhkVjR2OG5HVSszdGh0cjQ0cEViVDNZVkpqdkFk?=
 =?utf-8?B?c1BuaFU5RWNEbDJkeThLTm1SK3FyNVdwdmhEZWtGelVLcGVJM1JEeHFFQmsy?=
 =?utf-8?B?czRYRm5GRTRkd0RMTHVnNllyR2RhOTF0Q1RYcTdKR2l6eGIrczZ6TmlyRnhF?=
 =?utf-8?B?NHNKZjJ4aGZwei9TSTcyMU1jWDRGc1dNelQ5REl4T1Z4d2JUeE5qRHRod0JM?=
 =?utf-8?B?clZmcXZTU010T1p3SHFldkk3U016Ym50VjNISXVQZUgvaFo0V0ZHMTNiYzRy?=
 =?utf-8?B?L3B4QVRzb0R2Nk12cEk0Z3VnSzRWVzU0Y0VTYy8vMS9wNG9lamxLVzVVSWVM?=
 =?utf-8?B?eUZjaXpXb3lxem90blRMSHlXWktOdFlDei9TR1VzQmdEV0ZxM0NXdnQvWkxp?=
 =?utf-8?B?cklOZVVzclJHS0NCUmJ3UVQ1UWsveGdmWmFqUU5oL3lwZHRWeis0Rk9TUStS?=
 =?utf-8?B?Y1NCVWtZU1VYclNud0c1UU52c01oa1VLMFozWXRxeHJ5V1Rvd2dqdVlPVGxU?=
 =?utf-8?B?Y1BMTW5xeVJieTkvb3FLcFAzQTB2T1hWcjJGUC9VRUoxZld4RW5ZblFTWE96?=
 =?utf-8?B?K0pOMFV3bEJ4bjZnZnJyd0ZLNER5Rm9SRlRmMzRVYWJtak5nRUhwazByRDVM?=
 =?utf-8?B?dUJZd3hmMXlvN0IrVmo4Z2VoOFBVUlVDQ2VzanlYd0gwYktsV24rY2pHL2t3?=
 =?utf-8?B?QTUrWU9YQ3hERkpnRzdGQWI1NXJiejlnNThkdldjOVFlSHdXcm45cm85R05V?=
 =?utf-8?B?anV1ZEhrKys0MXhvTTFqNDlNSlhvaUJQeC85blI5S2J6TEJlbGFjZUlXT0hx?=
 =?utf-8?B?SW91R2xIVlkvdXVJVDRVd3BPQkhqeWVoM3RFM3RXRCtjdnF1UWRTYmg4a1ZP?=
 =?utf-8?B?N0JRZ1V4OEVrWDllWkNDTnlNWStWZ1hYdHY5eSt6Vm5xdGI3TmxwZS9JeHZF?=
 =?utf-8?B?Z28xZUNxVGtXUGJpTkVCNzQ0Vk9tSkY3UE1QbXNVVGdBVkRzUEFvOGJFUEpy?=
 =?utf-8?B?cGo4bG5UNmYzeFZWOUdDQmkvbzIrcmtPbmVKcEVEMDgrUzJ1VlhrN3NSZEhy?=
 =?utf-8?B?cmRPVWQ0eFlBWDhVUk5RODhITmZsWDlrR21CTlpYZVE5cHlENE0vM0R5VHQ2?=
 =?utf-8?B?UTJWWjhZMVc4ajhuSkg4QkN5U3VhVUE1VEo4OHgxNzgwc2lRSlkwcmRCeWF5?=
 =?utf-8?B?M1IyNmV0VU4vVVhNSXpwOWRMR25laUV0dnk4WWUvN1RrR0ZZTDdHUWIzanZv?=
 =?utf-8?B?OXBxc3ByT3pIMFJlNXdKMHJOak50RDhYUWF3blZuOFJWOGszYWxTVGFiTC9R?=
 =?utf-8?B?WnJiem1QT2ZpQ2t6SHhDMEt2SkRVQ0xHbGVmckN5b08yQ1VpYkdNQ0VzM2N6?=
 =?utf-8?B?TEZ5UDRSWjVIKzFRZ2dpS3Fqdkl5am9NUmFwWnFTWGJqc2psSS8wN1c5S0gv?=
 =?utf-8?B?RFM5VUQ3QTgxL0FSekd4SVcwZHBDbHVSTDBNZldGNCtDQXMrOEJVckZ5dUNU?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8E28D52BE8C264086695B90FB68C079@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8ca302-5ae6-4f4d-8bfd-08dd4b4d19fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 10:07:47.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an+Gf94RvVahRoL6ZbhMvC/Y4zuuSCmcz+B/9LxJctTPIcylLFWi4UCeNkZmQeTSGD35HbIkb9Xt6mqWZGEhwj8uWWO1XTfHmDHvyG4SRac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR03MB8651

T24gV2VkLCAyMDI1LTAyLTEyIGF0IDA2OjM0ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDEyLzAyLzIwMjUgMDQ6NTAsIENyeXN0YWwgR3VvICjp
g63mmbYpIHdyb3RlOg0KPiA+IE9uIFN1biwgMjAyNS0wMi0wOSBhdCAxMTo1MSArMDEwMCwgS3J6
eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzDQo+ID4gPiB1bnRpbA0KPiA+ID4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBPbiAwNy8wMi8yMDI1IDAyOjQyLCBDcnlzdGFsIEd1byB3cm90ZToNCj4gPiA+
ID4gQSBNZWRpYVRlayBEUkFNIGNvbnRyb2xsZXIgaW50ZXJmYWNlIHRvIHByb3ZpZGUgdGhlIGN1
cnJlbnQgRERSDQo+ID4gPiA+IGRhdGEgcmF0ZS4NCj4gPiANCj4gPiBIaSBLcnp5c3p0b2YsDQo+
ID4gDQo+ID4gUmVnYXJkaW5nIHRoaXMgY29tbWl0IG1lc3NhZ2UsIHlvdSBwcmV2aW91c2x5IGNv
bW1lbnRlZCBhcyBmb2xsb3dzOg0KPiA+ICJQbGVhc2Ugd3JhcCBjb21taXQgbWVzc2FnZSBhY2Nv
cmRpbmcgdG8gTGludXggY29kaW5nIHN0eWxlIC8NCj4gPiBzdWJtaXNzaW9uIHByb2Nlc3MgKG5l
aXRoZXIgdG9vIGVhcmx5IG5vciBvdmVyIHRoZSBsaW1pdCk6DQo+ID4gDQpodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuNC1yYzEv
c291cmNlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0Kkw1X187
SXchIUNUUk5LQTl3TWcwQVJidyFqWTBpM21SWTBtQTN5TGh2eG00Mk5aaUZuaGVZNkw1UTlkS1ZK
a3Y5MTFlUTlaMDNTQmkzLU1nc2xnX2ZPemt3QWZrSkpPRGNqRDZLYTVfSSQNCj4gPiAiDQo+ID4g
DQo+ID4gTWF5IEkgYXNrIGlmIHRoaXMgbWVhbnMgdGhhdCB0aGUgZGVzY3JpcHRpb24gIkEgTWVk
aWFUZWsgRFJBTQ0KPiA+IGNvbnRyb2xsZXIgaW50ZXJmYWNlIHRvIHByb3ZpZGUgdGhlIGN1cnJl
bnQgRERSIGRhdGEgcmF0ZS4iIG5lZWRzDQo+ID4gdG8gYmUNCj4gPiBzcGxpdCBpbnRvIHR3byBs
aW5lcz8gVGhlIHRvdGFsIG51bWJlciBvZiBjaGFyYWN0ZXJzIGluIHRoaXMNCj4gPiBkZXNjcmlw
dGlvbiBpcyA3NC4NCj4gDQo+IEFuZCB3aGF0IGlzIHRoZSB3cmFwcGluZyBsaW1pdD8NCj4gDQo+
IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpUaGUgd3JhcHBpbmcgbGltaXQgZm9y
IHRoZSBjb21taXQgbWVzc2FnZSBib2R5IGlzIDc1IGNvbHVtbnMuDQpJIHdpbGwgdXBkYXRlIHRo
ZSBjb21taXQgbWVzc2FnZSBib2R5IGluIG5leHQgdmVyc2lvbjoNCkEgTWVkaWFUZWsgRFJBTSBj
b250cm9sbGVyIGludGVyZmFjZSB0byBwcm92aWRlIHRoZSBjdXJyZW50IEREUg0KZGF0YSByYXRl
Lg0KSXMgdGhpcyBPa2F5Pw0KDQpCZXN0IHJlZ2FyZHMsDQpDcnlzdGFsDQo=

