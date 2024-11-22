Return-Path: <linux-kernel+bounces-418035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EF49D5C16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EABB9B21A58
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B981D63FC;
	Fri, 22 Nov 2024 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IVvSXaFo";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c6Aqt6bU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973418A6D3;
	Fri, 22 Nov 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268485; cv=fail; b=dTmEyI+5FC4A8YOVMSB21EfpLSluYJU2BRN2zUublkMZa20Umx5rAk4XbGZJ+jTCFrRJ1fO/vF8dcQ7pkR+FTT/YWttpkbZVSxN5WtFkMwb1Isnc1ukFj7eUFGF9TMY9znwwdoSEmintM3HQ0DFwwNa8Kyp+OtewpzYEJmPpbk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268485; c=relaxed/simple;
	bh=xaOTMDyiVJiRg5NyoDIx6JNFaZw1tcTNh3qipKcWM6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R6YnPc6FHRTJ91BAyLTLg441Z8TF3KK3rGSF10ACHU3kOTANln5Z7CEubgdnJmgVWLb1OCgI0E86oTGs1m6NiMbt5HCE+BQnYJySVkijcXhGdZUPIIBUrxGcSGdS0ikeDlw+SQfvze5qt27k3ibkSHLbMPHhfz4GjD7KX9azgeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IVvSXaFo; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=c6Aqt6bU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ec709fe0a8b511ef99858b75a2457dd9-20241122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xaOTMDyiVJiRg5NyoDIx6JNFaZw1tcTNh3qipKcWM6E=;
	b=IVvSXaFocio8xvftIR1tZsr941Rt0B2cnC7EvPH5HxxqF1pCOjA9mBNNWAAjI5yo3Q0bf4/3acW8XVkOYBexp34owVor7SappD+uSV1YwdHsqYonp0n56OX8PpETqPJjEnsf3yp6Ay1ExHLmVHC7X22pJxvUJeHfkWyIE/Okh4k=;
X-CID-CACHE: Type:Local,Time:202411221738+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:0a486d2b-5e50-45e4-b0b3-0ec3d2d62969,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:5aa3a3a0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ec709fe0a8b511ef99858b75a2457dd9-20241122
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1443583896; Fri, 22 Nov 2024 17:41:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Nov 2024 17:41:16 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Nov 2024 17:41:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3OQ7fX8zoILhcWX5PC6duRVSl1luYa22S7k4dDmwafdc2Q09jnXqVVy9rehOGkUJ5cQlFXJBo11i+Bnr0zybESZ243EPuueUn1gH/4x4FSENOZUnKoVFHQbBHyGU9E/wSgjvg6pwxatEcD4PGdPMvEsBsPYW5hkPml2LqJgUWfGrdVWbki6ILZyvLHuxd9PLY5Z79vACZz7AwLQx3OoezdfraCLohSFARu4tIrKxbbpvA/QWD0v+WprBONXTDFU5P0fcl7ZKv6i67/tOz1WW/ukPROdOYRm1MxnPw4SjhZSij5W8/1M6eV2kpEdKnXxGOG5Noc/NsLc9edlTR9QNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaOTMDyiVJiRg5NyoDIx6JNFaZw1tcTNh3qipKcWM6E=;
 b=e4zUUTwiarTubGeS7XyfS0/8jVnCNq0SrQPUS6DI2+yvgEfImgvIarfiqFESgaLuD7DA7bxt2sz935kd8+I95bvNlByNPU7xkK0zN6t4TfjbRLTYAdil4wQScyA1PZshXyn/iiuU/SZ80Va/udj3YBcmLXTrBHaDpWO/ueJeMCga5sO0FnXAjKTybdv2si3X0SIddpPgmHMNX4xp2YZf7T9ZrbSYCTZkxDIALDIRWq2uhWMcE+70KGsu4adX1g7X2VOoV/boCFeTMzjvFmqOf5XDZVTTvErxZmlzowGw+2bAUXY6EQ4f3WJHONqiYWlKZZDfsEk2EDZASKTpAyCviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaOTMDyiVJiRg5NyoDIx6JNFaZw1tcTNh3qipKcWM6E=;
 b=c6Aqt6bUAjP0dN/p50WMVos6sWq520d4iOwh028vjCc47rHnSPbRNojIQtUZj9yRirfzK41LrvgwzAQY7pylwLIewx+80D62sdQ5pNT593Vj61ufrwEq/dBbh1d0PcnYVXmf1OJ675QyoHE5mTKu8D789C24VxxoPS5gCsFnCdg=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by OSQPR03MB8435.apcprd03.prod.outlook.com (2603:1096:604:271::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Fri, 22 Nov
 2024 09:41:13 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 09:41:13 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 2/2] memory: mtk-smi: mt8188: Add SMI clamp function
Thread-Topic: [PATCH v2 2/2] memory: mtk-smi: mt8188: Add SMI clamp function
Thread-Index: AQHbOxbOaOb7mU6EPkaU11bG3DJgRLK/y00AgAND2gA=
Date: Fri, 22 Nov 2024 09:41:13 +0000
Message-ID: <e18bf1ba05c86b26fb4f18c444a19b391df29c55.camel@mediatek.com>
References: <20241120063701.8194-1-friday.yang@mediatek.com>
	 <20241120063701.8194-3-friday.yang@mediatek.com>
	 <5bf3bdab-8614-4024-a9da-f7f58414c0af@kernel.org>
In-Reply-To: <5bf3bdab-8614-4024-a9da-f7f58414c0af@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|OSQPR03MB8435:EE_
x-ms-office365-filtering-correlation-id: 56728c96-5055-4600-8f4a-08dd0ad9cdc7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWN6R0RMVWNreWdJL1YvLy9ZM0Z1R0xSSzJGVi9oS1QyUGZSYndaOUQ5ckpE?=
 =?utf-8?B?bjZUS0pTazl1cy91REY2L2swMnlvZGNUSmIzd1ZHUUlVOE0xWkYweW1id1JB?=
 =?utf-8?B?RHhkcGgzVVFyVWxsOHlMZ1JYOVFPN1pka1VEOWN5LzVVSTJibzZRZXIxdFhQ?=
 =?utf-8?B?K3pWV2Z4V1hBNDZGUXNuQVVzY1VUMHV2ZExweVRobEJiZ0dpZlFoNjJ0VG1Q?=
 =?utf-8?B?ckp5R0F6ZEVVQjMrWkVWckxjdDF1cE5pcVZOZkZOaldPRDdTdHdqcU4reUtH?=
 =?utf-8?B?YTNDeEkxNkJvcmxnQWRMSUNqalpnVDFHbHEyaitLaGEwVW1vKy9xY2QweGRa?=
 =?utf-8?B?dXRxZVBoREtOQnJPeGxhcXdUVEQwZnU3L0V0VXppTUtXR3RaVUtwVW5kM1NK?=
 =?utf-8?B?cnNCbkZ1aTUvZEtqNFYreEwxb0o0Wkdub0VhZmRsUEptUXdKa3Z3VTR4NUR5?=
 =?utf-8?B?Z0h3N0txRHo1WnJCV2VJYmlFUS9JWnRjend4UU9BVzdHd2JNR3o3SGpKVHdo?=
 =?utf-8?B?V3BMSC9RUmZuTUZaU1MzQUc0Qk1VTENDUnhQZXoxZ0tQcGs0TzMvRkgvSXdK?=
 =?utf-8?B?bHlOZXpiUWJRNVlLMkovalJ0dGd1ckdrTUF1eEFOQ0FxMmNPV1B2blRKRXMr?=
 =?utf-8?B?dERjd1IwV0thNUhlM2t1VU5IMXcwcUZDdFZyZG11QmszRTN0UHRMclAyV3N3?=
 =?utf-8?B?YmxLUDNtU0MyaERjdU9YdE92dlA5Q0t3Y0dXNC9kOG1nK2dxN3psMjdmVk9m?=
 =?utf-8?B?WDkxRDlXdjRYbEVlSXFidWQvM1k4S1NGN2JIRk9wUEw2dnF1Zm0zVVBXMUNs?=
 =?utf-8?B?cGtVSXErUzF2VWVibXA2RmVFdEtxTEU3bXZhRVNqc0ZRcDFDaW4zKzVubHZR?=
 =?utf-8?B?OGZxazdROGp4MWIzY2pHVUxxenZBcStIQ2JLSG1pVFJObGxGV09rOVh3eEYv?=
 =?utf-8?B?MEsyaS9YVzI0ZEVlb1NaZUdnTVlVNzNiR29Od2l3Z3RzL0VWYjdONndpT2pj?=
 =?utf-8?B?Y3VRTnlhTk5FdUdNeFBzNUljMFRUbjBLenl4cVZlZWpPOVNibkE1bmd5b0d4?=
 =?utf-8?B?cGtiRHdPNk9aWnA4Rk1WMWJSdmZwekhnTnlXc0drcHgvQi9CNmIxdGZEc3Qr?=
 =?utf-8?B?bnZvalZxQlY0L05adVlpWDQwbUFwYnVFa2NxeUZKdCt1OW5Dd0Y0QlEyeHEx?=
 =?utf-8?B?L0FyVnJyeWxDSjdSWGwvT3d2a3JyNTNaVkxyTlZLNHRLYjN2MFVqV2VWOU9x?=
 =?utf-8?B?d3NjRGoxYXFXUkxjVkFYUUxwRkdWZjFtZ0RLaUhTcjA2NkIyVDJFSlVtYXpa?=
 =?utf-8?B?VGpOU2xISm04Y2FwUzZIKzlRZWVOaVB6aU56UWFVOFVacmNYOFRVUThHL2N1?=
 =?utf-8?B?TFNJS2g3U3RUOS9rcnVFOEJjUVZDTTR6SjZpSDc1NG9uZUVkS2ZjNDZLM29S?=
 =?utf-8?B?aUcvYytGSHRpdGpFRVF6U1I1eUdMVkR4TUxPK2VSdGZmanYxajhMRC9INzl3?=
 =?utf-8?B?NndwRFBDaWp1VWxlVDFkODdVNHU0STluYkI5WWN2bnk0U2VkM3dSOXhBZmNt?=
 =?utf-8?B?TDRrVzRVdHMxaHNZUE02dWVMdllBcjh6SFN4bmVJRVlkaWFaWVpDWDAzMFpC?=
 =?utf-8?B?NDd6QTZBeFkrRUc4ajNaek5IOFAvNnc1YnNsUmllZXBndDhOcUhXZkZ1c0x4?=
 =?utf-8?B?eUVyVXlvci9MWVZxeElScGpCY1V1ZlZZcUhFUURWVFZqQ2dYazNUMEVneG9u?=
 =?utf-8?B?MURBbmJoZ1ZwUU91SEIzbXdZdmxxaVMxZm1JQnlaUCtlT1dCWkorWXpmdDFw?=
 =?utf-8?B?bGJQSFBpcEZGbHRiVy9VV1RMcjg4ZTh5TS9zbzRmSjFqRFFFZCtwMG1xZjRz?=
 =?utf-8?B?aWRLRE1lRVVWZ2pwMlNVQ24rTllMVlFVMU5zczN0bFVhZkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXY5cVZkdEFaYW1HbTg3K2Y3UVd3OUR1ZzhZN3NQcWZTNVRXeXlMSGRmYVI2?=
 =?utf-8?B?R3NGbHQ2YjBBcnZUTHo2UFcwNVlTVFlUNXFxSlJLRi9WT2FVdnJPZm1BNWlL?=
 =?utf-8?B?bkpQZmgxQ1BHK1RTbm9BZXVYQll0SCtBZU5KNDlic2VkckFQUCszcGpERmpn?=
 =?utf-8?B?TVZyaDJUeENUU2FvRm9qR09ndGxBRjFUOS9jbjFyTENubEg2VlR2bWU4WUVG?=
 =?utf-8?B?a3BBU1BidlFmaGFnOXZBc1U1RlFWU3g1Ti8va1p3UldHREVkOWd0aVpVYUFT?=
 =?utf-8?B?cHBtL0tPdWZubERZRldwQ2luZC9ZUWdyWFhxNzVNVXhlMzBXY2VBWWdaY21I?=
 =?utf-8?B?RVVCT2Q3NXRBS2xwUWttRDNma3cyUlV6eEhaOHdaa1kyd3IxL3RuMlRlMnly?=
 =?utf-8?B?aDdIVzB6emMzclVDQ3NCZlhrUEFEMXdvWUVnRldJZTcrdzNkR1FIRUxTc0tt?=
 =?utf-8?B?S3UzSDF2ZDlkZXNUZXVlOW1teG5hUTFLeDlaQ0c5b1p1bW1OeS8zZ3M2cjZp?=
 =?utf-8?B?UkVtMWVUV2VMU2JCUHNMSTJiS0NET3lFVGl3MFFNR1lqY3Jkdm9xTVptZXdJ?=
 =?utf-8?B?Vmo2YWQ5cENTUGlmOGJ4dEEvMVFrU2srQUFLaDJqRG8rM0U1QWdNSkNTQU1y?=
 =?utf-8?B?V3NocmdjdzlpeGNWUW5yUElEc2dUU2ZrdDlZN1FxQUhZVDQ2c2ttM2tvVzZZ?=
 =?utf-8?B?MEk4b3ZnVGlXRGdITUNZd0g3TkxUeExKZEEwaUNpNTVWK1VZZmlPdjAvc1Zr?=
 =?utf-8?B?MXkwekl2T3hLVjFMaEtGZzR4NEoyNTA0TitLcGRKOEdEWjBuNTQrRm9RRHl5?=
 =?utf-8?B?ZXUra2JYdzFaSE9IcmlJM3Vhd3RmbmdTbWU5VVdpcHlpcnNSR3l4NnE2bmlv?=
 =?utf-8?B?emc0ZHJDL1o4a2FTS1dxV3FpV3dDL3FaYXQ5cU5yMHBpQ25tVU5TSkdSdjAx?=
 =?utf-8?B?OUZZS3pUWFNiMjI0amM2b3l5RU5GV1J1ZlFxRWhaWDRkTXlrdUNKYnFxT3A3?=
 =?utf-8?B?Ti9UbVhOVGRaMjIxSnFOOHVzZFFPV3ZqdkNWaHJ3RndGMnFJaTl3blhjU3NV?=
 =?utf-8?B?Rm5RZlMzc2k5cyttb3VEVUJoNkhZUXo4WGdMWm1URE9ubFMyZmJTelpBNEpH?=
 =?utf-8?B?cURQK0NqandiSjJYck9TWWdySjFIaVVncXIrODc3ejk2V0pjUUFQVW9FSDFn?=
 =?utf-8?B?UVpNNzZTZUlkQXk5SkJJYzhzamtwVERVakhVQ2NrdlBpQzJMa3ZSVGJqUU1H?=
 =?utf-8?B?dENwaVVndkkyRjJGWkZLaVArV2FPUEJPUE1jcFc4QmxmdDhETVZoa2dtL291?=
 =?utf-8?B?aTE4L1pzaUl6a0VDdUVSeW9McGJ3anN3SUV0dWNqOFF0QTUrZ2hVSWZZSUFL?=
 =?utf-8?B?b2dBbmgrSm9WZkZHVmtRWHRQYVNuY2tSMlJEOGtaY083V3RCbEhUZTJDSGV5?=
 =?utf-8?B?SlNmckdSb3p5VUZ3WHRybnl2VHdQQkVsRG1wbEhEVDZkNUdYTjk0K29VWCtT?=
 =?utf-8?B?Yk9TYlNTbEFxTFB6RWdLREdtc2EvcWVsdVA3NkdRUFVDbzRXZXZtVU1relJs?=
 =?utf-8?B?dDJXcmdDc1d1N0lJcFVvaTlXN3Z3cHFaOWxlY0hNVk5yb2h0QzkrZDlKWUNl?=
 =?utf-8?B?UzQxYVkwNVJPNXh3NHN4ckJPeGJmeVBZblRWcHFlbjROaU9FME1VTVJmSUFV?=
 =?utf-8?B?dmJxK2dBZE5JSHJ6dVprckxUTWQ3cnQ3RzJRMUdIRldZcEtSdytNQ1pnVGFj?=
 =?utf-8?B?Q0FzU3BNMkxSUFNIZTNJZEIvR1JGdWlTTno1TXU0aFMzaHNBeDNaanFMUktW?=
 =?utf-8?B?V3oza01CM3hoMjNZb1FUaWo4ZWFUVWJkckZLUm1EenlyV1NmdGpoSzJ2a1hX?=
 =?utf-8?B?T01uK1JWWG1TVXIwVkdReFB6SDljZUMzbnRPWTVJMlVjVlk1MTZtMXQ0TG1G?=
 =?utf-8?B?eGxxaXkyR1QxTExPdlh3aDdISmJXcXhmdEVXV0RVS0E0ZTNzQmRPUzhiZDFs?=
 =?utf-8?B?RUx1cVJESUVVUW90RkxtR29YS1hneWFpL3FyYWtBQ1ZBSCttTEpZRVRBMkxS?=
 =?utf-8?B?a3N2akM5K1NIaFNWWkwwY3FyOFpNNEZOVWFhNnowQUpLVWhrWkVNVlQ4Wk4z?=
 =?utf-8?B?dFdIYzBIV0s3WkE2RkFJY0JoYnRLQXp5ZU5jQlE5c21uT0VDUzZ2WDhWZkM4?=
 =?utf-8?B?NWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64EE35600CDC2E49B7967935C5263C99@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56728c96-5055-4600-8f4a-08dd0ad9cdc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 09:41:13.2623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7mCyXfmhMvotoW3286eXSZSxQ6zzojqNmBhQ6xKSDLJuJHWjB3Pys+uoC9pXHN+FRXr6bfI0SV1ItueVHWkdjRbDbJSCxsBhvWcMD0jkGEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8435
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.185500-8.000000
X-TMASE-MatchedRID: byfwvk+IcRkOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rbaVyalxbpdChFZ+EwhjzAQpxiLlDD9FVo3Yq5PCwLAkX/lfMG/d5yZvo
	+mFW19mBx7H5wEf5GN1rpZ2UgV/eSnVzTgrSv7smgx+na8dyT1TGZtPrBBPZrfIpzBBN2uKqHb2
	R1n4nFd4VZhfZM9sMShhGzml3op53deQjqNZdjdM2OxZNQk6zxvtVce6w5+K8wxiS02+dfZlOS9
	5hWV5LTXBOv0Lb+vegSxvYi+d4ZGTpI0A0aNTmUk3ewifG2MNOeimGtNywjtsJ3vzMzuod4oMjA
	F9gVd0poGTIeWGTYEPGRkd2hld99AjPI/s9IvI8OSj4RiINDEX0tCKdnhB58pTwPRvSoXL2y5/t
	FZu9S3Ku6xVHLhqfxIAcCikR3vq/vuvfsBZBHdkBGo7NxtKCtoZR7vXNEQdZAtR7DjbhSN4HvpI
	xf2PAH
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.185500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	676681B0EA8FF8A73D849F53545D9FA2F0029B61EEA610A6FBD497B9E3A2E4D32000:8

T24gV2VkLCAyMDI0LTExLTIwIGF0IDA4OjQ5ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDIwLzExLzIwMjQgMDc6MzYsIEZyaWRheSBZYW5nIHdy
b3RlOg0KPiA+IEluIG9yZGVyIHRvIGF2b2lkIGhhbmRsaW5nIGdsaXRjaCBzaWduYWwgd2hlbiBN
VENNT1Mgb24vb2ZmLCBTTUkNCj4gPiBuZWVkDQo+ID4gY2xhbXAgYW5kIHJlc2V0IG9wZXJhdGlv
bi4gUGFyc2UgcG93ZXIgcmVzZXQgc2V0dGluZ3MgZm9yIExBUkJzDQo+ID4gd2hpY2gNCj4gPiBu
ZWVkIHRvIHJlc2V0LiBSZWdpc3RlciBnZW5wZCBjYWxsYmFjayBmb3IgU01JIExBUkJzIGFuZCBh
cHBseQ0KPiA+IHJlc2V0DQo+ID4gb3BlcmF0aW9ucyBpbiB0aGUgY2FsbGJhY2suDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogRnJpZGF5IFlhbmcgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIHwgMTc1DQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAx
NzEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4g
aW5kZXggMmJjMDM0ZGZmNjkxLi5jNzExOWY2NTUzNTAgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+
ID4gQEAgLTEwLDE1ICsxMCwyMSBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvZXJyLmg+DQo+ID4g
ICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+
ID4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+IA0KPiBXaGVyZSBkbyB5b3UgdXNl
IGl0Pw0KDQpkZXZpY2Vfbm9kZV90b19yZWdtYXAgbmVlZCB0aGlzIGhlYWRlciBmaWxlLg0KDQo+
IA0KPiA+ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9v
Zi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4NCj4gPiAgI2luY2x1ZGUg
PGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcG1fZG9tYWlu
Lmg+DQo+IA0KPiBXaGVyZSBkbyB5b3UgdXNlIGl0Pw0KDQpkZXZfcG1fZ2VucGRfYWRkX25vdGlm
aWVyIG5lZWQgdGhpcyBoZWFkZXIgZmlsZS4NCg0KPiANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Bt
X3J1bnRpbWUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPiANCj4gV2hlcmUg
ZG8geW91IHVzZSBpdD8NCg0KcmVnbWFwX3dyaXRlIG5lZWQgdGhpcyBoZWFkZXIgZmlsZS4NCg0K
PiANCj4gPiArI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9y
ZXNldC1jb250cm9sbGVyLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRr
X3NpcF9zdmMuaD4NCj4gPiAgI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gPiAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL21lbW9yeS9tdDI3MDEtbGFyYi1wb3J0Lmg+DQo+ID4gICNpbmNs
dWRlIDxkdC1iaW5kaW5ncy9tZW1vcnkvbXRrLW1lbW9yeS1wb3J0Lmg+DQo+ID4gKyNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9yZXNldC9tdDgxODgtcmVzZXRzLmg+DQo+ID4gDQo+IA0KPiAuLi4NCg0K
cmVzZXRfY29udHJvbF9yZXNldC9kZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0IG5lZWQgcmVzZXQuaA0K
QnV0IHJlc2V0LWNvbnRyb2xsZXIuaCBjb3VsZCBiZSByZW1vdmVkLg0KTVQ4MTg4X1NNSV9SU1Rf
TEFSQjEwIGFuZCBvdGhlciBpbmRleCBuZWVkIG10ODE4OC1yZXNldHMuaCANCg0KPiANCj4gPiAN
Cj4gPiArc3RhdGljIGludCBtdGtfc21pX2xhcmJfcGFyc2VfY2xhbXBfaW5mbyhzdHJ1Y3QgbXRr
X3NtaV9sYXJiDQo+ID4gKmxhcmIpDQo+ID4gK3sNCj4gPiArICAgICBzdHJ1Y3QgZGV2aWNlICpk
ZXYgPSBsYXJiLT5kZXY7DQo+ID4gKyAgICAgY29uc3Qgc3RydWN0IG10a19zbWlfbGFyYl9nZW4g
KmxhcmJfZ2VuID0gbGFyYi0+bGFyYl9nZW47DQo+ID4gKyAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICpzbWlfbm9kZTsNCj4gPiArICAgICBzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIGFyZ3M7DQo+ID4g
KyAgICAgaW50IHJldCwgaW5kZXg7DQo+ID4gKw0KPiA+ICsgICAgIC8qIE9ubHkgU01JIExBUkJz
IGxvY2F0ZWQgaW4gY2FtZXJhIGFuZCBpbWFnZSBzdWJzeXMgbmVlZCB0bw0KPiANCj4gVXNlIExp
bnV4IGNvZGluZyBzdHlsZS4NCg0KU29ycnkgZm9yIHRoZSBtaXN0YWtlLCBJIHdpbGwgZml4IGl0
Lg0KDQo+IA0KPiA+ICsgICAgICAqIGFwcGx5IGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb24sIG90
aGVycyBjYW4gYmUgc2tpcHBlZC4NCj4gPiArICAgICAgKi8NCj4gPiArICAgICByZXQgPSBvZl9w
YXJzZV9waGFuZGxlX3dpdGhfZml4ZWRfYXJncyhkZXYtPm9mX25vZGUsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJlc2V0cyIsIDEsIDAsDQo+ID4g
JmFyZ3MpOw0KPiANCj4gTkFLDQo+IA0KPiA+ICsgICAgIGlmIChyZXQpDQo+ID4gKyAgICAgICAg
ICAgICByZXR1cm4gMDsNCj4gPiArDQo+ID4gKyAgICAgc21pX25vZGUgPSBvZl9wYXJzZV9waGFu
ZGxlKGRldi0+b2Zfbm9kZSwgIm1lZGlhdGVrLHNtaSIsIDApOw0KPiA+ICsgICAgIGlmICghc21p
X25vZGUpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAg
ICAgaW5kZXggPSBhcmdzLmFyZ3NbMF07DQo+IA0KPiBUaGF0J3MgcmVzZXQsIG5vdCBjbGFtcCBw
b3J0LiBOQUsuDQoNCkkgY291bGQgY2hhbmdlIGZyb20gJ2NsYW1wX3BvcnQnIHRvICdyZXNldF9w
b3J0Jy4NClRoaXMgaW5kZXggaXMgdXNlZCBmb3IgZ2V0dGluZyB0aGUgcG9ydCBpZCBmcm9tIHRo
ZSBhcnJheQ0KJ210a19zbWlfbGFyYl9jbGFtcF9wb3J0X210ODE4OCAnIGluIFNNSSBkcml2ZXIu
DQpJdCBjb3VsZCBhbHNvIGJlIHVzZWQgZm9yIGdldHRpbmcgdGhlIHJlc2V0IHNpZ25hbCBpbg0K
U01JIHJlc2V0IGNvbnRyb2xsZXIgZHJpdmVyLg0KDQoNCj4gDQo+ID4gKyAgICAgbGFyYi0+c3Vi
X2NvbW1faW5wb3J0ID0gbGFyYl9nZW4tPmNsYW1wX3BvcnRbaW5kZXhdOw0KPiA+ICsgICAgIGxh
cmItPnN1Yl9jb21tX3N5c2NvbiA9IGRldmljZV9ub2RlX3RvX3JlZ21hcChzbWlfbm9kZSk7DQo+
ID4gKyAgICAgb2Zfbm9kZV9wdXQoc21pX25vZGUpOw0KPiA+ICsNCj4gPiArICAgICBpZiAoSVNf
RVJSKGxhcmItPnN1Yl9jb21tX3N5c2NvbikgfHwNCj4gPiArICAgICAgICAgbGFyYi0+c3ViX2Nv
bW1faW5wb3J0ID49IFNNSV9TVUJfQ09NTV9JTlBPUlRfTlIpIHsNCj4gPiArICAgICAgICAgICAg
IGxhcmItPnN1Yl9jb21tX3N5c2NvbiA9IE5VTEw7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4g
LUVJTlZBTDsNCj4gPiArICAgICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wYXJzZV9yZXNldF9pbmZvKHN0
cnVjdCBtdGtfc21pX2xhcmINCj4gPiAqbGFyYikNCj4gPiArew0KPiA+ICsgICAgIHN0cnVjdCBk
ZXZpY2UgKmRldiA9IGxhcmItPmRldjsNCj4gPiArICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiAr
ICAgICAvKiBPbmx5IFNNSSBMQVJCcyBsb2NhdGVkIGluIGNhbWVyYSBhbmQgaW1hZ2Ugc3Vic3lz
IG5lZWQgdG8NCj4gDQo+IFVzZSBMaW51eCBjb2Rpbmcgc3R5bGUuIFRoaXMgYXBwbGllcyB0byBh
bGwgeW91ciBwYXRjaGVzIGFuZCBhbGwNCj4gcGxhY2VzDQo+IGluIHRoaXMgcGF0Y2guDQoNCk9L
LCBJIHdpbGwgZml4IGl0Lg0KDQo+IA0KPiA+ICsgICAgICAqIGFwcGx5IGNsYW1wIGFuZCByZXNl
dCBvcGVyYXRpb24sIG90aGVycyBjYW4gYmUgc2tpcHBlZC4NCj4gPiArICAgICAgKi8NCj4gPiAr
ICAgICBpZiAoIW9mX2ZpbmRfcHJvcGVydHkoZGV2LT5vZl9ub2RlLCAicmVzZXRzIiwgTlVMTCkp
DQo+IA0KPiBUaGF0J3Mgbm90IGhvdyB5b3UgdXNlIHJlc2V0IGZyYW1ld29yayBBUEkuIFVzZSBw
cm9wZXIgb3B0aW9uYWwgQVBJLg0KDQpUaGFua3MsIEkgd2lsbCBjaGVjayB0aGUgcmV0dXJuIHZh
bHVlIGZvciBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0DQppbnN0ZWFkIG9mIHBhcnNpbmcgJ3Jlc2V0
cycgaGVyZS4NCg0KPiANCj4gPiArICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+ICsNCj4gPiAr
ICAgICBsYXJiLT5yc3RfY29uID0gZGV2bV9yZXNldF9jb250cm9sX2dldChkZXYsICJsYXJiIik7
DQo+ID4gKyAgICAgaWYgKElTX0VSUihsYXJiLT5yc3RfY29uKSkNCj4gPiArICAgICAgICAgICAg
IHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgUFRSX0VSUihsYXJiLT5yc3RfY29uKSwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJDYW4gbm90IGdldCBsYXJiIHJlc2V0
DQo+ID4gY29udHJvbGxlclxuIik7DQo+ID4gKw0KPiA+ICsgICAgIGxhcmItPm5iLm5vdGlmaWVy
X2NhbGwgPSBtdGtfc21pX2dlbnBkX2NhbGxiYWNrOw0KPiA+ICsgICAgIHJldCA9IGRldl9wbV9n
ZW5wZF9hZGRfbm90aWZpZXIoZGV2LCAmbGFyYi0+bmIpOw0KPiA+ICsgICAgIGlmIChyZXQpIHsN
Cj4gPiArICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGFkZCBnZW5wZCBjYWxs
YmFjayAlZFxuIiwNCj4gPiByZXQpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7
DQo+ID4gKyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiAgc3RhdGljIGludCBtdGtfc21pX2xhcmJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gPiAgew0KPiA+ICAgICAgIHN0cnVjdCBtdGtfc21pX2xhcmIgKmxhcmI7DQo+
ID4gQEAgLTUzOCw2ICs2ODUsNyBAQCBzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShzdHJ1
Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgaWYgKCFsYXJiKQ0KPiA+
ICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ID4gDQo+ID4gKyAgICAgbGFyYi0+ZGV2
ID0gZGV2Ow0KPiA+ICAgICAgIGxhcmItPmxhcmJfZ2VuID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9k
YXRhKGRldik7DQo+ID4gICAgICAgbGFyYi0+YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9y
ZXNvdXJjZShwZGV2LCAwKTsNCj4gPiAgICAgICBpZiAoSVNfRVJSKGxhcmItPmJhc2UpKQ0KPiA+
IEBAIC01NTQsMTUgKzcwMiwyOSBAQCBzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShzdHJ1
Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAgICAgaWYgKHJldCA8IDApDQo+
ID4gICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+IA0KPiA+IC0gICAgIHBtX3J1bnRpbWVf
ZW5hYmxlKGRldik7DQo+ID4gKyAgICAgLyogZmluZCBzdWIgY29tbW9uIHRvIGNsYW1wIGxhcmIg
Zm9yIElTUCBzb2Z0d2FyZSByZXNldCAqLw0KPiA+ICsgICAgIHJldCA9IG10a19zbWlfbGFyYl9w
YXJzZV9jbGFtcF9pbmZvKGxhcmIpOw0KPiA+ICsgICAgIGlmIChyZXQpIHsNCj4gPiArICAgICAg
ICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBjbGFtcCBzZXR0aW5nIGZvcg0KPiA+
IGxhcmJcbiIpOw0KPiA+ICsgICAgICAgICAgICAgZ290byBlcnJfbGlua19yZW1vdmU7DQo+ID4g
KyAgICAgfQ0KPiA+ICsNCj4gPiArICAgICByZXQgPSBtdGtfc21pX2xhcmJfcGFyc2VfcmVzZXRf
aW5mbyhsYXJiKTsNCj4gPiArICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICBkZXZf
ZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgcG93ZXIgc2V0dGluZyBmb3INCj4gPiBsYXJiXG4iKTsN
Cj4gPiArICAgICAgICAgICAgIGdvdG8gZXJyX2xpbmtfcmVtb3ZlOw0KPiA+ICsgICAgIH0NCj4g
PiArDQo+ID4gICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbGFyYik7DQo+ID4gICAg
ICAgcmV0ID0gY29tcG9uZW50X2FkZChkZXYsICZtdGtfc21pX2xhcmJfY29tcG9uZW50X29wcyk7
DQo+ID4gICAgICAgaWYgKHJldCkNCj4gPiAtICAgICAgICAgICAgIGdvdG8gZXJyX3BtX2Rpc2Fi
bGU7DQo+ID4gKyAgICAgICAgICAgICBnb3RvIGVycl9saW5rX3JlbW92ZTsNCj4gPiArDQo+ID4g
KyAgICAgcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4gPiArDQo+ID4gICAgICAgcmV0dXJuIDA7
DQo+ID4gDQo+ID4gLWVycl9wbV9kaXNhYmxlOg0KPiA+IC0gICAgIHBtX3J1bnRpbWVfZGlzYWJs
ZShkZXYpOw0KPiA+ICtlcnJfbGlua19yZW1vdmU6DQo+ID4gICAgICAgZGV2aWNlX2xpbmtfcmVt
b3ZlKGRldiwgbGFyYi0+c21pX2NvbW1vbl9kZXYpOw0KPiA+ICAgICAgIHJldHVybiByZXQ7DQo+
ID4gIH0NCj4gPiBAQCAtNjg2LDYgKzg0OCwxMCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19z
bWlfY29tbW9uX3BsYXQNCj4gPiBtdGtfc21pX2NvbW1vbl9tdDgxODhfdnBwID0gew0KPiA+ICAg
ICAgIC5pbml0ICAgICA9IG10a19zbWlfY29tbW9uX210ODE5NV9pbml0LA0KPiA+ICB9Ow0KPiA+
IA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlfY29tbW9uX3BsYXQgbXRrX3NtaV9z
dWJfY29tbW9uX210ODE4OA0KPiA+ID0gew0KPiA+ICsgICAgIC50eXBlICAgICA9IE1US19TTUlf
R0VOMl9TVUJfQ09NTSwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bXRrX3NtaV9jb21tb25fcGxhdCBtdGtfc21pX2NvbW1vbl9tdDgxOTIgPSB7DQo+ID4gICAgICAg
LnR5cGUgICAgID0gTVRLX1NNSV9HRU4yLA0KPiA+ICAgICAgIC5oYXNfZ2FscyA9IHRydWUsDQo+
ID4gQEAgLTcyOSw2ICs4OTUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZA0K
PiA+IG10a19zbWlfY29tbW9uX29mX2lkc1tdID0gew0KPiA+ICAgICAgIHsuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODYtc21pLWNvbW1vbiIsIC5kYXRhID0NCj4gPiAmbXRrX3NtaV9jb21t
b25fbXQ4MTg2fSwNCj4gPiAgICAgICB7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNt
aS1jb21tb24tdmRvIiwgLmRhdGEgPQ0KPiA+ICZtdGtfc21pX2NvbW1vbl9tdDgxODhfdmRvfSwN
Cj4gPiAgICAgICB7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNtaS1jb21tb24tdnBw
IiwgLmRhdGEgPQ0KPiA+ICZtdGtfc21pX2NvbW1vbl9tdDgxODhfdnBwfSwNCj4gPiArICAgICB7
LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LXNtaS1zdWItY29tbW9uIiwgLmRhdGEgPQ0K
PiA+ICZtdGtfc21pX3N1Yl9jb21tb25fbXQ4MTg4fSwNCj4gPiAgICAgICB7LmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTkyLXNtaS1jb21tb24iLCAuZGF0YSA9DQo+ID4gJm10a19zbWlfY29t
bW9uX210ODE5Mn0sDQo+ID4gICAgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1z
bWktY29tbW9uLXZkbyIsIC5kYXRhID0NCj4gPiAmbXRrX3NtaV9jb21tb25fbXQ4MTk1X3Zkb30s
DQo+ID4gICAgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1zbWktY29tbW9uLXZw
cCIsIC5kYXRhID0NCj4gPiAmbXRrX3NtaV9jb21tb25fbXQ4MTk1X3ZwcH0sDQo+IA0KPiANCj4g
QmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==

