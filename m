Return-Path: <linux-kernel+bounces-570750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB39A6B425
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5CB19C3398
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072AF1E9B1C;
	Fri, 21 Mar 2025 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r/ouY+An";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HcRsSR21"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611728BE7;
	Fri, 21 Mar 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742536299; cv=fail; b=Dxi8/RXdjeSdOnkc4iUFTICBQPSme763YCe0GMWZSVcBSmDcy24uPdbUoYaacBv4EleT0/hffmuumfScSJPponU7dlF+f34M0g6LrNZIDx3jeE2FPTXaL1QB/pRijRRJui88QEVKrpY7vSFxsg8+wQhMfA57b2W5Uc2p44wGhRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742536299; c=relaxed/simple;
	bh=wy5kw+/CyA+ScIaKyM7uap9nn7T3T6vDKZlQkRTAdpc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nKYWiJocaDHfEOCT3w1rYqdbXIeMvpPT1yDOwt1DQCXNc8Yl5rwcsERNQOMYMcf2tJlGFv4S/tbIpLNmMwlWnaB6SLW1JyUpiypDEVeFgPdsmAucq/Ft4fO/tcCVxDQvFDhJg07Ovxyhz4BQvPccdWQMdiIG009cyLzd6OHkRlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=r/ouY+An; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HcRsSR21; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 86d67770061811f0aae1fd9735fae912-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=wy5kw+/CyA+ScIaKyM7uap9nn7T3T6vDKZlQkRTAdpc=;
	b=r/ouY+AnHeERK981ltkvHedy4qPQvQjf9fNw4bCLcV1j4b57ws4yN0+ngLBlA/fqn/Ed/2m2M1gYB5mkXuP4AvMgjGpl9HO7IaBOMvdrqYfMIzF3ukHWDPgPjjcUrLhwlh1K1mApZjwKbkOdRLR7F3wEMasnTGoT54jyyNh/1js=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ecef3fa4-895c-40b4-825e-cf281a37d1d4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:8352634a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 86d67770061811f0aae1fd9735fae912-20250321
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 567018757; Fri, 21 Mar 2025 13:51:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 13:51:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 13:51:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lGZnn7YVDtqPNB+Ggab+MRfvLf7Jnp6Ygu+wOQHx7IpWV6HuAydCrXiaKtJVzR3+tFn9oS56dkiJrxuFsFhQHpnde8MWyIYfMq4SFKkCVzgszPgnLH0wuwo1vuYViIPINjBr/sOdhYsryYrzA+2X+YVNxQWt3vKOsf48tK2Q1+lWk9anHATcFav9XhAsSCHpHUHbRyU5sDcSyuiJQPFBUlN2FJ9Zly3Zp5R/mOeIo1LAQ9iG5Yr9lKsecrrhmQoB8Mvrc1U0lb8anrfZIkzzOB7WAgjAtYRy5YwHcr1zYZDWMxYzZPnibFbqhIKQM8WHqhvm6PAu1MRkw7w7+1hb3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy5kw+/CyA+ScIaKyM7uap9nn7T3T6vDKZlQkRTAdpc=;
 b=RetxrYiQJJwgq60mP+Pj3UzE5PLeHqhBM7FUFeoW1uUI9B/PKC9ch1s+vm0CJvT3s81crtYub5OZhGbqi1toOsChneyiV6WJAzch06jiI246D4+XwMhqo3oKrT1JUERrXLYwRDs2gu8KYT2AsB76HygAeYzBacJPEWuqkTtRDxqFCGVjqt5rftZAGR0b1Ue7YBOWW4wN05QkypgzxcDwYIZrDNa4APdloua4FZC2hHlQml4NfC3Vo+0iHFXzYraE8PtJyAIq6J8OhxLywPyCVZL7Lwm3qzfRxLx/E9PR5jgvuWNGUSG/Z3fAkJHLrRzEJm8akdOlJFWrTlnxMprxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy5kw+/CyA+ScIaKyM7uap9nn7T3T6vDKZlQkRTAdpc=;
 b=HcRsSR21U1Qg33G8wBzrj5vrhLr/jcub3E9zDvBuSAsn/856jC8zEemFHwzDwbNAW1T63gBG6O/VBfSIRZkeGpVpOZG4lRj7Gi0RCf3xNEQJxkdk7J3un5T3+99/ct0mXtp2opPOHOni0TEaiwBVaL8SAi+CmdoYuy9/+JOEQSs=
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5)
 by PS1PPF5DE123533.apcprd03.prod.outlook.com (2603:1096:308::2d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 05:51:22 +0000
Received: from KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d]) by KL1PR03MB6002.apcprd03.prod.outlook.com
 ([fe80::f1f:1fbf:e323:1c3d%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 05:51:22 +0000
From: =?utf-8?B?SGFpbG9uZyBGYW4gKOiMg+a1t+m+mSk=?= <Hailong.Fan@mediatek.com>
To: "krzk@kernel.org" <krzk@kernel.org>
CC: "perex@perex.cz" <perex@perex.cz>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?=
	<Jjian.Zhou@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "pierre-louis.bossart@linux.dev"
	<pierre-louis.bossart@linux.dev>, "kai.vehmanen@linux.intel.com"
	<kai.vehmanen@linux.intel.com>,
	=?utf-8?B?WGlhbmd6aGkgVGFuZyAo5ZSQ55u45b+XKQ==?=
	<Xiangzhi.Tang@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "tiwai@suse.com"
	<tiwai@suse.com>, "robh@kernel.org" <robh@kernel.org>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "yung-chuan.liao@linux.intel.com"
	<yung-chuan.liao@linux.intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "peter.ujfalusi@linux.intel.com"
	<peter.ujfalusi@linux.intel.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"daniel.baluta@nxp.com" <daniel.baluta@nxp.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"ranjani.sridharan@linux.intel.com" <ranjani.sridharan@linux.intel.com>,
	"sound-open-firmware@alsa-project.org" <sound-open-firmware@alsa-project.org>
Subject: Re: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
Thread-Topic: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
Thread-Index: AQHbmUbnZKLzS9bHIU6bGASslhev2rN7p14AgAFwn4A=
Date: Fri, 21 Mar 2025 05:51:22 +0000
Message-ID: <e369f6ec539454ad7d4f30389fec4ae58d1482ae.camel@mediatek.com>
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
	 <20250320031753.13669-2-hailong.fan@mediatek.com>
	 <20250320-cocky-adventurous-rooster-be2abd@krzk-bin>
In-Reply-To: <20250320-cocky-adventurous-rooster-be2abd@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6002:EE_|PS1PPF5DE123533:EE_
x-ms-office365-filtering-correlation-id: c354b075-3eeb-478a-3a23-08dd683c6906
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RUdQMlJsai9KUWV4V0VvRkNLT25PVkY0N1JiZi8zZjc2VEFaTHBTWEpFT1ho?=
 =?utf-8?B?ajJzRGdiUmRhVHU1amVncmF3T1BXUnZCMHUyNkJ2ZUx0ZzAzYnZhRDNwRjVV?=
 =?utf-8?B?OVMrd2pkYkdoNzFoMFd0RXBnamZXTzZSaW9oZGkyQlhvVDM3L1VocXBCV2JO?=
 =?utf-8?B?b0xsR3ZaTjZuS3dMMTNtWWkvbit3YTlrYnRQOFFYWjIrODRlcU1UdUcxbWRR?=
 =?utf-8?B?QjZjTHZNUGcvYisrSFRIOWtzQmJpL0ZOWS9CL21FdGpkd0tUeDlRWWdITFZM?=
 =?utf-8?B?eHRWWHdXTUpscXhCL1hFQjMrbmpRaWFXVksrVUJxL0x4dmpudmV1eWs5eHdS?=
 =?utf-8?B?SzhPWnBYL2tVMWhsZU9wRGpQaTdZRnRNam8wQ1I5S3dJSW4xb2RrRFl0clVl?=
 =?utf-8?B?V29YcEZIOGFKMXBJREtNT2diekUwaWx0eHNOSWpEeHJWakQ3RThtRHZmTXRz?=
 =?utf-8?B?R0RlM2N5akNXdVgxdnJ3Snp5Z25DVEVTZ2lzOGtjWm15OXAzVmZBT09xejZu?=
 =?utf-8?B?Tm5udTJHWW9ySUVFN253TkU0Q01jOUVPSTJlZHF1WVB0aG5oQkxKa1UycUsz?=
 =?utf-8?B?WXlUS0tpSnBoWVkxZDA2UUZpaC9EbnhJSDZXdVRqMXpGUi9JOWFsZmRJUHFy?=
 =?utf-8?B?Sm1ydWEvMHdqT1NYbTdNelMwU1BqNDd1WkpZSnNzSVVWNFhJVlhDNjNmZnlT?=
 =?utf-8?B?NmM0Sm1aR050NzB1WUlhV2hGaVBNV2hNYkFhNVNUaUtxWFkzcThJT1NmSDdM?=
 =?utf-8?B?aFBQUVBRQlFXWE96SWJZOTZySXVhZGFjbms1SXUvNkZKMW44a29QUWkvOFA4?=
 =?utf-8?B?TjBmc0pnR09TZFRobHBUalU2N1VxK29xdTg2cmZrWEJMcVhRYm9TK3ZtY3ps?=
 =?utf-8?B?Tk83MTdIOS9yMVdnQW1DckdOLysycDFKRGsrS1B5eUpmU0d2ZVVOdk5KVTFv?=
 =?utf-8?B?bWR3dTA3anBySFZ6cnRwNUFNM0U4K3BCS1VCWHhGZ29yNVYvcDVucmRrNGZF?=
 =?utf-8?B?ekJDUFZNZFV6Z3dCQ0pmNGlPUjdwYUFUNTA5UytwS0JqMnZDN2ovRHhqOXdv?=
 =?utf-8?B?Szk4bGRqcVBnUTdaZUxDRkd4a2Jnck1UbGZXQ2h5SGhiNllmdzlPVUQxckFQ?=
 =?utf-8?B?VEZiRmpXMWtobEFXNjhyTmpZTTEvK0ZtZVJHMC9ELytmeTYwUkU0QzJkUGYw?=
 =?utf-8?B?UU9sSm85ZzJBRmhmR1BEdENmQStIQk5rZ3BqVlMzTlc3bUJGUWRaK3JkSGF4?=
 =?utf-8?B?VXVjYzNQRytPeFJNMlZ3T0hHdHg4YWMyQm01MU50cXVmWERxSjRWN1JSS0FT?=
 =?utf-8?B?OGcwZHJuOUFvNCszUWdOb3Q4UDlHUWY3VTFrcSthQWsxb3daaWdJc2RTZ1Ji?=
 =?utf-8?B?ZlZHWXhCbWVRZ01hVTRzeUR1VFB6RHNuc3JRZzdpbFV2cTJMSFJLc1hDNmNn?=
 =?utf-8?B?UG5UU1NTYklaTGExMnNYZ1dodUtrS2ttM2lqYzZtMTQ1NUdmanpNOFF4Qjg5?=
 =?utf-8?B?OFdFR2pBZ1BLV1ljV2ZtT2R0WjBxeEFkcXZZY1h3NDROcFpzbytZMDN5YzNP?=
 =?utf-8?B?eXJFa3VDQnFMdUVVU3JxV3Y1ditBTnY1VmpWVmVmWGkrUi8xOUg5TXFqTzZM?=
 =?utf-8?B?azY1ejhmaUxwdWRYZGwvMUIxNXAzcmYzRitocksrVWtmN2RranNoL3lwUnQr?=
 =?utf-8?B?cXcyNGlVY0RINGsvalNhUlBrR282WmVDTVo4YU9wNlhMbFNlS09ZUlFwUjRO?=
 =?utf-8?B?emxid2NBTzl0T2hrdG1ua0l1aUlIaTJKajVwVyt6UFhQOTNmSENxc2dhSzdU?=
 =?utf-8?B?cUlSN0NORjBkdE84Q0FnRE5Pb3Q5WGg3dys3TVBKRFIrNEIwM2FuTjR2cDFS?=
 =?utf-8?B?akswWDJ3Nm5nUXFPTFlFTnl0OTNvSVFDQzE5azZLdXRKK0Y2aWVna09xUHlz?=
 =?utf-8?B?WVhoeVJHSERMQVJhdWRNa3FESm1HMFhxKzJXd0UxaERUYWowdlhtdm9lMnor?=
 =?utf-8?B?ZFBPTmJsalBRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6002.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vnd6d3l0ZTk1d3lVZnhTUnIxMVpaREFienJGaUtsTnFYZC9HT1F1UTFTdVdP?=
 =?utf-8?B?aVIyYlIvbm1tVjJmUTZrUEdFNlVsNjlUUjVNT3loZFA3V1ZIMWQwTVlwbmxa?=
 =?utf-8?B?TStvcmxrekZ2SjlCRlBjNVRsRWRDTVgvdDZ5VmVHTmw4MVRpWTZ3bWxkN0hB?=
 =?utf-8?B?aGJ1SnpsclF2V1lNbmlDc2RoczlueWhTS0tTUG9oZnYvUEU3b1hlWkVHL2Rn?=
 =?utf-8?B?OWVST2VpTzJwek9BUmZhZUd1WlZmSDRHZEdsK1k3WGtlREdMWlZBK0ZkSTl4?=
 =?utf-8?B?OG5DNGdEL1dRNWxERHFiWW9DMzVaWktWbC9wTlJ4SU5oOGdrekc1b2tBeUx2?=
 =?utf-8?B?REtJSjZoTHlFelhrQkl0ekpBZm5zK0lwU25hOWdObjV0dlh2dk1RZTNHMnZn?=
 =?utf-8?B?S20rY3NFaUpRM3NmV1B5SFo0UnhsUnZtUlg0OCs3ZjlhUHFWWUE5OFl5MTRT?=
 =?utf-8?B?VUo2Y2h4ZFo3ZzYrMnBocFdadDdkQS9OMWNRYkNSZE9xVjlDK3pHZEdyeGFZ?=
 =?utf-8?B?MWt3aVdDcy9WVWVyNXllTHN3SzM4OFg5Z0ZxNVhrNXV0cmZkUnM3aTRDN0s0?=
 =?utf-8?B?MDFrVmpSYnE1Q3NyTUVCajJ5SDQwZWFWaGlPMnNDbUZsMlZndEVweEpyTUx6?=
 =?utf-8?B?QmdjZFREeFo5d3BnWXVCYk1mREV0TkhKVmtlOWYxczBjZjgyVy9BMDNiQXZQ?=
 =?utf-8?B?VVd1NU5lNzdUSlJjazNnQjJqN1hKNTdsaUI3aUI3TituenVmNG9GV0JjV2R0?=
 =?utf-8?B?b3dCV3ZMdmpmZFlybm5mcm44dC9GN1ZsdVpzK3QyWTRwcGF2Mml3bDVkOU9Z?=
 =?utf-8?B?U3ZEd1d6ZmxPTWpzZFRQcHRRQUNzbjBpdjFjQzhDQzhwZ0xtYjlPeWpFRHVP?=
 =?utf-8?B?TGZwSXArUVYrVXdKL3pDMDg2d1dDMzdrNkdkOGc0QVBCbTZOVGxqcHJZLzd1?=
 =?utf-8?B?QVM2N3ZIMGJQKzJ2ZTk4elZEM3hFbG41bDExbFU1VGhCVW1jY3Axek9FMnYr?=
 =?utf-8?B?QitheHhWUktTTy9GMTk0RmhhenBlSVplNExmcTllb2o2U1l1WWRKdmpEVktC?=
 =?utf-8?B?aHdNRkYrZzg4OHBPMHN4eU1mVXMxZ0xRbGxXUm45RFE3aXJTR2p3YmlyNlVI?=
 =?utf-8?B?K0lUUG93Vng1RkRrcjI3NHp5aHZ5aUlubDN2RmNWZW01YnE4Ulhmdk9EMmQ2?=
 =?utf-8?B?RWx6cE5xaG5CNUx1U3ZpZ2ZvQVFZODBuWlpLSnZUOE5pcWI2SXoyQnUrRk03?=
 =?utf-8?B?WEc2YmJBUnNhb01uSkdoOHVyd2poRkJGU1V4c3g2dlNWOC84ZUJOZm5uQlpP?=
 =?utf-8?B?R21rdEM3Y29FYy85UEFjQVUyaDVCOHZEYXZqRHZnbXoyRU5MVi8wVWVVUXhk?=
 =?utf-8?B?U2RRRG1zSEo2Y1pxVmxMK0kremtQYkN1cWJHdmxSMlp1NmZtT1ppeWQvYmN6?=
 =?utf-8?B?UllGMkJTNytRVWRGSnN3UVlNQ0NQekpxTU1TQUNaakdZSFZQTThyY0VubFc3?=
 =?utf-8?B?UU4vZ1FPL0g4MXJnVkxGV2VBa0hpYkYvR1Q1RkJRcWZJblpjcjEzUDN4YWR0?=
 =?utf-8?B?Qk9xdU9Wc1hLWmNFS3JLN0dYUmZvM29jOGE5VU1KMTRkS1BMVlE1WUdZNzRw?=
 =?utf-8?B?RWVjUDZpVFdYTXhnL2ZiSkx2RnJZdVRuOVdxMlc5Y2tYTk1Ycy9HbHlPbnpq?=
 =?utf-8?B?eHIwVVYwemVQRTQxTXpRUW9kQVEwMnFIQ3dBYU1qaEYycEQ5Y1V6TW1kVElv?=
 =?utf-8?B?bVFpMGlpSFIyWlBad1RLS0lJK1p0b3pkQ0h4TUpNVFBlaXhodmQxbk43b08r?=
 =?utf-8?B?WnJJN3VMaFRtOWtOclVtU2lObUJHUmloVlpMSWRHQnJEZ2dvQStLeGtmZEFN?=
 =?utf-8?B?bWxjcW9zeGJJcTJpMnZYRUZpU2k2dnUvS2FKRFJjYkp6MFVBTDdDZWtoeThO?=
 =?utf-8?B?MjFLNkp2UVBVU0owY21QdjI1dTIzMDNTVEI3TVJUT0pYbkxYK2tBRmJXNWc2?=
 =?utf-8?B?dVBLaDJ2L21EUDJWRGV3cXNlR2tmY1liYXArT1RFTE03ZGZ4Z1hSVW8wOWZG?=
 =?utf-8?B?OEZ5KzVySi9IWDFUOWxTbTVMWVhqRVQxQlhKQ0twNXkycCtpT0kxdXAyS3Zi?=
 =?utf-8?B?SzVveTljL2hUU1JBWEM3N3VLYXhwK0MvaWhldzF2dGsvUzhKSmwxUFlUc05x?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B098D7C0B39054EA7FD8AE598019A38@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6002.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c354b075-3eeb-478a-3a23-08dd683c6906
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 05:51:22.5648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oKF4Q61XcwgpJvcLRrOjIKEXujYxMES7rWQYDQ2Sx5jTD+eymZiIP4J4LZD6G+2gWeSXnYeHZ9bLh499suu93ueKBOSblo/FkXqEr1jTQfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF5DE123533

T24gVGh1LCAyMDI1LTAzLTIwIGF0IDA4OjUyICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIFRodSwgTWFyIDIwLCAyMDI1IGF0IDExOjE3OjI0QU0g
KzA4MDAsIGhhaWxvbmcuZmFuIHdyb3RlOg0KPiA+ICsNCj4gPiArdm9pZCBtdDgxOTZfc29mX2hp
Zml4ZHNwX3NodXRkb3duKHN0cnVjdCBzbmRfc29mX2RldiAqc2RldikNCj4gPiArew0KPiA+ICsg
ICAgIC8qIHNldCBSVU5TVEFMTCB0byBzdG9wIGNvcmUgKi8NCj4gPiArICAgICBzbmRfc29mX2Rz
cF91cGRhdGVfYml0cyhzZGV2LCBEU1BfUkVHX0JBUiwNCj4gPiBBRFNQX0hJRklfUlVOU1RBTEws
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUlVOU1RBTEwsIFJVTlNUQUxMKTsN
Cj4gPiArDQo+ID4gKyAgICAgLyogYXNzZXJ0IGNvcmUgcmVzZXQgKi8NCj4gPiArICAgICBzbmRf
c29mX2RzcF91cGRhdGVfYml0cyhzZGV2LCBEU1BfUkVHX0JBUiwNCj4gPiBBRFNQX0NGR1JFR19T
V19SU1ROLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNXX1JTVE5fQzAgfCBT
V19EQkdfUlNUTl9DMCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTV19SU1RO
X0MwIHwgU1dfREJHX1JTVE5fQzApOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gRHJvcCBzdHJheSBi
bGFuayBsaW5lLg0KT0ssIHdpbGwgZml4IGluIHYyLCB0aHguDQo+IA0KPiA+IGRpZmYgLS1naXQg
YS9zb3VuZC9zb2Mvc29mL21lZGlhdGVrL210ODE5Ni9tdDgxOTYuYw0KPiA+IGIvc291bmQvc29j
L3NvZi9tZWRpYXRlay9tdDgxOTYvbXQ4MTk2LmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0K
PiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzY0MDY5Y2U5OTU0DQo+ID4gLS0tIC9kZXYvbnVsbA0K
PiA+ICsrKyBiL3NvdW5kL3NvYy9zb2YvbWVkaWF0ZWsvbXQ4MTk2L210ODE5Ni5jDQo+ID4gQEAg
LTAsMCArMSw2NTAgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gDQo+IExvb2sgaGVyZQ0KT0ssIHdpbGwgZml4IGluIHYyLCB0aHguDQovKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMy1DbGF1c2UpICovDQo+IA0KPiA+
ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUgTWVkaWFUZWsgSW5jLg0KPiA+ICsgKiBB
dXRob3I6IEhhaWxvbmcgRmFuIDxoYWlsb25nLmZhbkBtZWRpYXRlay5jb20+DQo+ID4gKyAqLw0K
PiANCj4gLi4uDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2Vf
aWQgc29mX29mX210ODE5Nl9pZHNbXSA9IHsNCj4gPiArICAgICB7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE5Ni1kc3AiLCAuZGF0YSA9DQo+ID4gJnNvZl9vZl9tdDgxOTZfZGVzY30sDQo+
IA0KPiBCaW5kaW5ncyBhcmUgYmVmb3JlIHVzZXJzLg0KV2lsbCBjaGFuZ2UgcGF0Y2ggb3JkZXIg
aW4gdjIsIHRoeC4NCj4gDQo+ID4gKyAgICAgeyB9DQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJ
Q0VfVEFCTEUob2YsIHNvZl9vZl9tdDgxOTZfaWRzKTsNCj4gPiArDQo+ID4gKy8qIERUIGRyaXZl
ciBkZWZpbml0aW9uICovDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIHNuZF9z
b2Zfb2ZfbXQ4MTk2X2RyaXZlciA9IHsNCj4gPiArICAgICAucHJvYmUgPSBzb2Zfb2ZfcHJvYmUs
DQo+ID4gKyAgICAgLnJlbW92ZSA9IHNvZl9vZl9yZW1vdmUsDQo+ID4gKyAgICAgLnNodXRkb3du
ID0gc29mX29mX3NodXRkb3duLA0KPiA+ICsgICAgIC5kcml2ZXIgPSB7DQo+ID4gKyAgICAgLm5h
bWUgPSAic29mLWF1ZGlvLW9mLW10ODE5NiIsDQo+ID4gKyAgICAgICAgICAgICAucG0gPSAmc29m
X29mX3BtLA0KPiA+ICsgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0gc29mX29mX210ODE5
Nl9pZHMsDQo+ID4gKyAgICAgfSwNCj4gPiArfTsNCj4gPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZl
cihzbmRfc29mX29mX210ODE5Nl9kcml2ZXIpOw0KPiA+ICsNCj4gPiArTU9EVUxFX0xJQ0VOU0Uo
IkR1YWwgQlNEL0dQTCIpOw0KPiANCj4gQW5kIGhlcmUgSG0/IERvbid0IGZha2UgdGhlIGxpY2Vu
c2luZy4NCldpbGwgZml4IGluIHYyLCB0aHguDQovKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjAtb25seSBPUiBCU0QtMy0NCkNsYXVzZSkgKi8NCj4gDQo+ID4gK01PRFVMRV9ERVND
UklQVElPTigiU09GIHN1cHBvcnQgZm9yIE1UODE5NiBwbGF0Zm9ybXMiKTsNCj4gPiArTU9EVUxF
X0lNUE9SVF9OUygiU05EX1NPQ19TT0ZfWFRFTlNBIik7DQo+IA0KPiBJcyB0aGlzIGNvcnJlY3Q/
DQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

