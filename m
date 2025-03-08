Return-Path: <linux-kernel+bounces-552298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3D9A5780D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056A73B669E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEB3155C83;
	Sat,  8 Mar 2025 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZKVAVf7r";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="RH0l693m"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7316F8E5;
	Sat,  8 Mar 2025 03:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405607; cv=fail; b=hLeYYhxIqwQUFMSgDzyoBfv9ocoldUiVxCeV+MUv1VXyx1tGyPbfBvDXx+aEM7YIM+LTojGkzEARpCPJP70KTAZRri2Jv0gb32TqbllXX2wqhrVHXl6NnSeatzyYD0gITfZfTdmpany1xWBUESAeYp8Cc8cO6oG8xlLBmMc7wXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405607; c=relaxed/simple;
	bh=4uzSGaF4Z6JGGorzblwlZGxT067GqCQMuCF3HCab+HI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NkEhyiDnc6TvQ0bH8xkml4L6XH0/Ij2itWJ0VpYfseBWtz3SI4y8bD4AVBrXbTnDZj+0EtWW3di5KDn0A23yyIHE+opkN5C+5GZaczs946z8zjR0enIoLHQ4h/kAhi9BMQsdFjWUzazmyVtNbeWYSDxERi3dlTthKSxCRzMI/xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZKVAVf7r; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=RH0l693m; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ee1d1f54fbcf11ef8eb9c36241bbb6fb-20250308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4uzSGaF4Z6JGGorzblwlZGxT067GqCQMuCF3HCab+HI=;
	b=ZKVAVf7rhagNShkM4ji5HiHDgrHIb2zB7NZQJv59indrbWay1bu0buThp3asFivvedq1aD8vYlz9cY5MRwP9y4/Zicsv7TPeh5kOo/v6EZ0qbWfwyOAl+JOgpE1/U2T/aw+TocEkPvkkhGtYfKKn+P8c8dmKLWsUZvJSwTe0K8I=;
X-CID-CACHE: Type:Local,Time:202503081139+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:3bf4f488-8f29-4ed8-afa0-b4cea65a2644,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:0ef645f,CLOUDID:866912c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ee1d1f54fbcf11ef8eb9c36241bbb6fb-20250308
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 889574005; Sat, 08 Mar 2025 11:46:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 8 Mar 2025 11:46:33 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 8 Mar 2025 11:46:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOw2/S5ggzYCHoJekwYFZ7Gxi9YU0V7dXdXtXcAodysd6BCS3i5G0ziZ7Ggi7tfzWYKMJ7TAx9uSJyVHYzUqlAQAOnEONesoMCNJzjLIAt3mw6FWdjFHnZhp8AqQp6dapwOZHcLji2+5KwQTHrbUl/FphDbmRGjYjX02s1lfMp4YdvroinqOW3ftFWasBKj5vluKGhvYuCnLh0glg7KBp/8YcQdwJd1zvG3F7szuH7aaJS5JC62ufbX5FP38iAIVi9Lswoaofgv0MgVvo3w2+CWnEASYrMIMMwLBfcZ453nebaeuRXtJh1QDh9paXFfDn96V+f6+fL7cR7OS1aSL4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uzSGaF4Z6JGGorzblwlZGxT067GqCQMuCF3HCab+HI=;
 b=ebdMEvPt9tKenbwwcOJUNag57HuIF2EXgtq0gqc4RXScAzUDCvuoenfILPVCGpvHDWA+w3Wyz3EnlYI3J2EtZSEXpVsZqJA/f6aCREkZj4Pytl5djoGehcAw4LOWDRmiMK2KZF0GfCqT8l83XXtI10YlQvuqjyeH77X9XFH1uQkcb+Mcg9/VybydgMb/ILQJb+V/fQUtVh/IPh7f+q6VtgUUx6BQjFG/DjlbOPXNVpMPerZ6jrjSXX3DGB6fJmKL4O/+AtMONBjK0CWiKCCffgA3S384Wrbjbt7BMVd37WPAmaA6rrmUWFamPGiIdyJ2gQ4lYB0oqvTFQUx0X6Trmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uzSGaF4Z6JGGorzblwlZGxT067GqCQMuCF3HCab+HI=;
 b=RH0l693mFMrrdpIoxsp/8aRqVR/jxYIsNHaxdPwNT6sRgMFpUnMgqx17R+bnP/8GZUrN3uNIiAsCpjXEWGA3uGxc+b/wIcnkir4wKTLqyo1sFrARIVDS0pd8sngAknowNp86vNjP8hZzKMz31rLQQDZFGyF5ukhwGlM6xpL2V0I=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by TY0PR03MB7237.apcprd03.prod.outlook.com (2603:1096:400:279::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.24; Sat, 8 Mar
 2025 03:46:30 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.8511.020; Sat, 8 Mar 2025
 03:46:30 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH RFC 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk
 vcp-mbox document
Thread-Topic: [PATCH RFC 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk
 vcp-mbox document
Thread-Index: AQHbjaeHfEKKbx+Drk63d7IvlbhforNkvMGAgAPhSYA=
Date: Sat, 8 Mar 2025 03:46:30 +0000
Message-ID: <a37826597bd6e7889d191163865e49a06f70fca4.camel@mediatek.com>
References: <20250305082047.15746-1-jjian.zhou@mediatek.com>
	 <20250305082047.15746-4-jjian.zhou@mediatek.com>
	 <20250305-chewing-henchman-aea98c18b412@spud>
In-Reply-To: <20250305-chewing-henchman-aea98c18b412@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|TY0PR03MB7237:EE_
x-ms-office365-filtering-correlation-id: bc9aa70a-bbda-43e5-d4bd-08dd5df3d011
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UWRHRHhRMGg1WE5WT1JGR2xOR095c2FoQ2pTdnJqUHQ3RTdQYmttVVk1QXYz?=
 =?utf-8?B?STJMcU1UUEc1NTRNaW1aRGNNVFl4WlpyanB4REZRZnVOQy8waW00OHhrQ09k?=
 =?utf-8?B?alVZYU5MeXl4Smk0a05RZ0Irc2lVOGZCMXBKbXdQODlKSE5QU1pDeXM1eHpk?=
 =?utf-8?B?TTgyakswVkFSb0cwbDNwQVZITktCcm9LUUI1MWxDUFQzNnRRYjlZTDJPN3Zx?=
 =?utf-8?B?OWxOQ2NHYUZZSWpBYnZ3OXl4a2tJK2tpN0VTMStyVUJiZTM2NDBuSDdRWFo5?=
 =?utf-8?B?N1ZDZThtSjE2ZnRWeEZDRE9wWUZjT2lwUkwzSU4yRlh0ZGxSUGFNOHAwVXBR?=
 =?utf-8?B?bHpKc29YSjduZjRJU3VhaXVPbG1RajdldWE5VUR3dkR4VWpXT2lJUDQrOUZ0?=
 =?utf-8?B?RFBhN0kyRzJScXhKUTlrNjVZeVB0dFRlR1NraDVLN2hSMXBEUldFMzEwUnFh?=
 =?utf-8?B?WnJOTTFTNXdwcnJuRnVOOTc5cURwVGtldE5JNWtCOVYrek96M0N6K0xVSHdF?=
 =?utf-8?B?bElPYlNwY2d3YW92Vjd3OTJCM1FVRTBUUXhUczlDVnJLY1JpZGhPcXlsbWtZ?=
 =?utf-8?B?QTBDUTFzOTVBRlV3Um1XUkJqZnZBRDZZSXV6SDVIWjJxZ0lBUTlPSUI4bmo3?=
 =?utf-8?B?QzdzSGE5NUJUWnlyZ1RYUjRIeGxlMFI1THZHaDFsM3hmTjMyK01MWjBqVTBo?=
 =?utf-8?B?N09mYmlSSnNYMEl3TE5BZzZzaWdWZmZ3elY2QVE2WGF5NkwzM1BveE9nakVq?=
 =?utf-8?B?WG8vVDcrbXhXbEYwK3NpSm5BbDF0VFN2Y2I1REdzSzFWNTZqV3VSZWM3TzdQ?=
 =?utf-8?B?UTJvMkFteVk1eVRObkdBejRlQ2dwdmpTamtrUGk5Skp0eG00WVNUQjl2YW40?=
 =?utf-8?B?cGI1K0IzdHQ5ZExWZlovM0ZKTGk0MlI5S3NQanZvLzl4WnB1RXBWRHpia0V6?=
 =?utf-8?B?T1J3VFdqaERMeHZkMjBMTnRCakJYUEIvVG84bktZeWlMamorRnBiZ2JjdmpT?=
 =?utf-8?B?Q0dYWGR3OVVtVTk1MlhlNGo1NlBFdy81SzV1M09wcjBYOEZYSi93S3RGRi9N?=
 =?utf-8?B?cTJ0MXBNd1hZWXRkQWlnZkFVSitVbUZIdXFsS0JZTFFNb1l2cE1wSXEvTmlu?=
 =?utf-8?B?Y2RhUWtRTTdCMyt1em5WdmtKRmhvbFd4dE5hbmI0bHVMbGJzREkrWGpRRmln?=
 =?utf-8?B?TmFpWmpENzA5U2VZL0U5VWhQY1I5VmVtMTRVUE1na2dPWk42Y2JqUVpsaEZq?=
 =?utf-8?B?dHpQMHZTWXRtKzIrN2ZDVjhKcEpySE5vZWg2L0Y2K2dDRFhDYTYrRENROXpv?=
 =?utf-8?B?dVg0V2E5K3dEOHplU0EvVUJxVDEwbTFSWXQ0dHkva2Y3aFIrd0ZSbnRQSVZJ?=
 =?utf-8?B?T1FUTzBKWXJSeUFFYmJJQWIvZUcrV3dKYUlvWUlZSDhnM0kzekZOZjRueHFl?=
 =?utf-8?B?K2kvQ1ZZTTlpWG1RKytWaXF5dzFvcXBvb29Wcld2bW5Uc3NzTGJNdWRELy9X?=
 =?utf-8?B?WEJBQ0s5R3BsTnVCUzd2WG4xV2o0MEtZVkk4ZzlTeVZWemt1NnZrZDI5NUx1?=
 =?utf-8?B?SGNmZ0t3cHMvbjdMaFZVWkJrZlE0d1lPd3J4YU5JaXBCVnJ6UzB6THhiaU10?=
 =?utf-8?B?MGZvMmk3eXBxUmNKQlBEbnl1TFJTNHRjK2FyeWVzUGVDQ1lMN1Z3Mkc5OXE0?=
 =?utf-8?B?TFRidVVla0RJSjBIbjFmVW9MQ0xEUit0VHI2bSsrR2Z2eDFleVFxVFdPNzQw?=
 =?utf-8?B?WG5FT2Z2dyt2cGdUME0rMFN2WExpeHFSMHhETDlDOW9CdUlEbXNFNHBrYmJz?=
 =?utf-8?B?Z3AxbjlGY20wM1pVTlp6SG9TR3RZcG5JMjBYOWZ4THJzMUFlSGZCM2FFbUY1?=
 =?utf-8?B?bGovZ2xJdC9LU0QrZ3pENytRNlE0R1BLTnA3a1Z6aTlqbGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXlXbDVFTzlpanpKYi9CVTNTSEJ5VXRscld0Y0loUHUxNFF0Snd5dGNxbEdU?=
 =?utf-8?B?WStBTjE0RjYwbkYxUktKNExxLzRBdFZqZlZ1YURpM2tUTUlMeWJsQXY4UWtI?=
 =?utf-8?B?RHVHbWZIMVJCWHVJczRNQVdzb3d4NXBBV2cveUtTL2xSMjdUZVVVSm96R28r?=
 =?utf-8?B?OVhOVmhyRk5COFVLUnFST3Z4WERaell1OVd3cDN4Y0hhOUsvL28xdHZ2WkJj?=
 =?utf-8?B?UkUrK3Zzem4xdTQ2R1hxNWpZUlBMZldDaXRldU94WWozTTVLblYzN1lXOUZm?=
 =?utf-8?B?ZFlodmtUbHlwTXY0WVFNWkxTS2dyNmc3VnlZSy92aVEwTUpDcXZ2MndBeEE2?=
 =?utf-8?B?Q1lmVHJrL3ZlcFJoUVEzV1JUUXpsdC9RaVRBMk9GYmNpOVhFNFlDY0g1biti?=
 =?utf-8?B?NkxHRjlFbWdaM0JQSVFUckM4T25qTEJNanBHNERQV04wZnJFb2xPU2dyZ0xC?=
 =?utf-8?B?bjdXMzVkcFlMOXlQWlRqL0tpTFdkY3NWMWVIWTJnUHN1eWZodkVLRE1CRWwv?=
 =?utf-8?B?WE9GeER3bkZJaEVKTnQySkFBUkoxbEdyMGN3ME9oZ3ladElsWFljTUhYYXhV?=
 =?utf-8?B?cGU5b1A1am1BZXlHQko5MFFqSWJCZDhEMGVtQk1oMm4vS3dTYWY5R24yUnRy?=
 =?utf-8?B?NGd2aWp2M3pIOG9SZWJRTUtFT0lYMnUxYkZYbmtRUS9BUnpKYkFmU3NLd0FP?=
 =?utf-8?B?UVN4bjk2ZW9lQUtpWFJFRWFLWGx4R3ZtNDlKZlZOek11VTFtRVBnUUIzODBi?=
 =?utf-8?B?VDBLR2IyL1poSW01RkpkYUJmWS84ZGc5aG5SWVFnTzE3N3BGeXZkYmNLOTlH?=
 =?utf-8?B?ZDd3Ymt6L2VjNXU5bWhSRTdHeTNOMDNjZlRYL3pMbjkwclVnRGY5TU52K1V6?=
 =?utf-8?B?RHY2Z0NnQlVSTStiMldEMmg5aGdjSUlaUXAwM3l6SE5iRDZ6L2pPUEdRK25z?=
 =?utf-8?B?ZUpHcGtjenBuL014L3VMaHBwSGoyOWNRRkZFR0s5aDJTQkc1RzA4U2dwVWR0?=
 =?utf-8?B?S3U5RGE5Y2RvdlVKTW11ZkJYME5UaVVoK1J2N3A3U01rVjhYVlJ0L1UzYmZU?=
 =?utf-8?B?bUFOTnZuaG9GblFOeksrUWt0N0o4NWNvOEJZb2U3WE5zOVZaZ2F6cmpJOUln?=
 =?utf-8?B?YU1jZFBoUEJuaSsyRXkvWkYwTWNPYkdCTzIwVG9TdXBxeTh1WkVDYlZmVmx3?=
 =?utf-8?B?eExtSGpxVnZqQlZINEF1dlYxaFZORTRHNTVnV1FwYlBEdmRKU1BXc1ZsTkdU?=
 =?utf-8?B?K2g3SHBkRldpUk5YbFB2T1oxcFhRZnNSellnOHlFR0NYOTNybzVVck1JU2o4?=
 =?utf-8?B?bjMrT0FCbERESFM3MVB1blliUk4zRFJpUy9sMGtHRzdZRzRCOVdjUEdKTkJZ?=
 =?utf-8?B?M0dQY0VJNUxnMnQva3ZDODRnZWt5Q0Z3WGVpdC9MSVJFVVVHNTdvV0F6cFJ4?=
 =?utf-8?B?aGVzeW9KVmphU0NsY0ZUR0ZWeUFYOG5zSmNCL2Fua2RydXZHY0pFSnc3eWsr?=
 =?utf-8?B?OWRzSnNoaENubk5pek0zZ0taSzhndE9sNndNb3MweUNiRnBpK3lHOFVhdW9V?=
 =?utf-8?B?c2ZaMTBzQm5DUS96bDhqemsybnZ5YkZJSnhINzRxTXBycjNGUzhIZ3MyYUJJ?=
 =?utf-8?B?SEw5aG02dFlCMkpTaDhvSVVDeGVPa0NKTm9heDhBYitPcVk4NWU1SGpPbTVB?=
 =?utf-8?B?akVDVVVTUDM1eUdzV0w2SzVHV2g5Mk5BOHpRVmNLZnNMTWZwak5nV1dqelRY?=
 =?utf-8?B?ek1QTVZ5UzhXUy9UbTRRSGEzU2VFZ0l1QXhXclkwa0wvVWFEMnR2Y2VQYTJT?=
 =?utf-8?B?KzQyK25sYnpLZTdZWFhqYlQxeDMwblB0RzlYWnY4amtOZERLSGhLTFdHbW5T?=
 =?utf-8?B?SFhOMEF1N1RsVDhncC9KZDRLamtCTWo2Rng3eW9Xem5yWjdlMUhqdm5uODRZ?=
 =?utf-8?B?dFBiSkRSSURVQ2JmL2dJS3J0SHA1cllDcS9hbDRFdDcyWUNGdS85dGhKTUtC?=
 =?utf-8?B?bXM0NW8xdUliQ2pKeUhOanVJRmF1VHc3VzZqK3B3dlNrUElLOWhCWHJZdEE1?=
 =?utf-8?B?Tlh2ZEtYSnJvU1pDNzlPaVNWMUY1RVBlK3hFam5IbmxSVCtlVEhSVUtKNlFp?=
 =?utf-8?B?andnN2FMWUcvTE1FK0VUbk1rNjA4bDlTdlZuTFMrQ0VIYmEyMERpNi9rSHVL?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D801CF2E6ECD64EA832CFEEA32E7F74@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9aa70a-bbda-43e5-d4bd-08dd5df3d011
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 03:46:30.5213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qNn2nIIff3MtgTj5fCvApeiyHSCbJaN0i05YpINTzruYnV04JIJrJv88WjjJrfz1Cfv+pirRbJPpxxZ1D+dqLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB7237

T24gV2VkLCAyMDI1LTAzLTA1IGF0IDE2OjMxICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFdlZCwgTWFyIDA1LCAyMDI1IGF0IDA0OjIwOjQwUE0gKzA4MDAsIEpqaWFuIFpob3Ugd3Jv
dGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGRvY3VtZW50IGZvciBtZWRpYXRlayB2Y3AgbWJveC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKamlhbiBaaG91IDxqamlhbi56aG91QG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL21haWxib3gvbXRrLHZjcC1tYm94Lnlh
bWwgICAgICAgIHwgNDkNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0OSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ayx2Y3AtbWJveC55YW1sDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
YWlsYm94L210ayx2Y3AtDQo+ID4gbWJveC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21haWxib3gvbXRrLHZjcC0NCj4gPiBtYm94LnlhbWwNCj4gPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uZDVhZmUyOTVhZjE0DQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
YWlsYm94L210ayx2Y3AtbWJveC55YW1sDQo+IA0KPiBXaGVuIHlvdSBnbyAhUkZDLCBmaWxlbmFt
ZSBtYXRjaGluZyBjb21wYXRpYmxlIHBsZWFzZS4NCiAgSSB3aWxsIHJlbmFtZSB0aGUgeWFtbCBm
aWxlIHRvIG10ayxtdDgxOTYtdmNwLW1ib3gueWFtbC4NCiAgVGhhbmtzIGZvciB5b3VyIHJldmll
dy4NCj4gDQo+ID4gQEAgLTAsMCArMSw0OSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4g
Ky0tLQ0KPiA+ICskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21haWxib3gvbXRr
LHZjcC1tYm94LnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIFZpZGVvIENv
bXBhbmlvbiBQcm9jZXNzb3IgKFZDUCkgbWFpbGJveA0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6
DQo+ID4gKyAgLSBKamlhbiBaaG91IDxKamlhbi5aaG91QG1lZGlhdGVrLmNvbT4NCj4gPiArDQo+
ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhlIE1USyBWQ1AgbWFpbGJveCBlbmFibGVzIHRo
ZSBTb0MgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgVkNQDQo+ID4gYnkgcGFzc2luZw0KPiA+ICsg
IG1lc3NhZ2VzIHRocm91Z2ggNjQgMzItYml0IHdpZGUgcmVnaXN0ZXJzLiBJdCBoYXMgMzIgaW50
ZXJydXB0DQo+ID4gdmVjdG9ycyBpbg0KPiA+ICsgIGVpdGhlciBkaXJlY3Rpb24gZm9yIHNpZ25h
bGxpbmcgcHVycG9zZXMuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGli
bGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5Ni12Y3AtbWJv
eA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiAr
ICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgIiNtYm94
LWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiAr
ICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsg
IC0gIiNtYm94LWNlbGxzIg0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNl
DQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKw0KPiA+
ICsgICAgdmNwX21haWxib3gwOiBtYWlsYm94QDMxYjgwMDAwIHsNCj4gDQo+IGxhYmVsIGhlcmUg
aXMgdW51c2VkLCBwbGVhc2UgZHJvcCBpdC4NCj4gDQo+IENoZWVycywNCj4gQ29ub3IuDQoNCiAg
IE9LLiBJIHdpbGwgZHJvcCBpdCBpbiB2ZXJzaW9uLXR3by4NCj4gDQo+ID4gKyAgICAgICAgY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTYtdmNwLW1ib3giOw0KPiA+ICsgICAgICAgIHJlZyA9
IDwweDMxYjgwMDAwIDB4MTAwMD47DQo+ID4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJ
IDc4OSBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiA+ICsgICAgICAgICNtYm94LWNlbGxzID0g
PDA+Ow0KPiA+ICsgICAgfTsNCj4gPiAtLSANCj4gPiAyLjQ1LjINCj4gPiANCg==

