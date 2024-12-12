Return-Path: <linux-kernel+bounces-443703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CC9EFADC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903B1188A425
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2A4222D7D;
	Thu, 12 Dec 2024 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mlHjuo8Y";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bMoSjSz6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7402221D9F;
	Thu, 12 Dec 2024 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734027816; cv=fail; b=aX62nI77GW/V7tJjkdcspChLnWqo1k//Ai/b+ZmFuHKhFPtfc21axStutbJ/aWpIY3Arzm+lYEpVEp6MGTPIQwFbFq1WUKIVBdSxodCfk9GGDS1cRVOhWTEM5tgBuen785ed11ENZwvDdFmK142YRfJJJjipOjw14+NMPy9E4s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734027816; c=relaxed/simple;
	bh=EE+SgXlYeKP1UvnD6RZYO9Bt7zs8mBOAkwKgo7CCnAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KhyLNNz/Ibp/I0bDbZ/kMgk3IA7YyHDpdV+N2CN4HA3u85mwIIH7gQyd3DKho4OnFugygKG1iPECqNhTxw+hX1Puey16bCZ7D9WvCSyddV1DmwQhdSV/+95zaIcpD2PXmziGPs19dWifBQ6x0ypZjLM4I6a3lY5qwvi7l043p5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mlHjuo8Y; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bMoSjSz6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2f155132b8b611efbd192953cf12861f-20241213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=EE+SgXlYeKP1UvnD6RZYO9Bt7zs8mBOAkwKgo7CCnAM=;
	b=mlHjuo8YrnSy92shdVQiaT+nesNOUC4xh5315TMH5usNDVBf1AT64/drdRsagiy4RbZUWlSAH2eqVJtRnK2Lt1jZkwBBoEj8EwjmtCRPCk2ysw8kmEr477qMIrW0UcKEp0ML358cCBrMa6mfM21RMm/aw7+93tORIcayrCZBHgo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1b36358c-90bc-48e1-b571-b9ccf500d94d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:c27d6d28-d2eb-4de2-b5c9-495d1bc17256,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2f155132b8b611efbd192953cf12861f-20241213
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 706819037; Fri, 13 Dec 2024 02:23:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Dec 2024 02:23:26 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Dec 2024 02:23:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oe4Q5HDeAKYjFo9MTM80dQ2x7Wn2QPWsdFkDjmwCCNej1YKavxOHNuSQ/hXZ5XUyiyELkPsDyQ3kXOJ83BpRsuf6iynmutGZsdufSpAuK4FD1SYOqhNpHFD8ARDLVjxMwEwGHb3bPoOPQ1PCyhtO5d3QY+R2shegHhn80YoX0A6imzEBLZEt9ZWupQTzxbC119TW0KgsFMNqp/ee/O5Vwy2ZIrxkMzZhgiq8idlRPR5GKyvoAbH3ThqDfrf6BJWoQg5eBPa2c1KCHcacq36+5gVOMW+f5PXGERa+Jd7aOXNbDhnM622RKWCFEjSyPJnug0d1G5e0sOiMQu3sxKL3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE+SgXlYeKP1UvnD6RZYO9Bt7zs8mBOAkwKgo7CCnAM=;
 b=vB+wZYAMII6DImIGW4CdcjJTjOPIOZj2hsNhu57nVyzBhWeFXSxacCj/6G5Nq7OOCsHwA423ewUllGtJIXXEJ94pYaxvont8zFjA3O4IJMWZlaZM9WLdNt2kB5FxBIX5uhJSPTOqlmuSyg5yijEddPuEUv9S8QFb34xfV+G1wQblQW7Ja6BwVTn/ojeAHxfhKbo97WVbRuG6VhVQGVV6MsB0Eum8YNYiUQAR6B4Xw8R1c4+14SYQJOijQ0cqEeZiL5noXttfWpfgL9Y8jQFf+FgC7P3+Gu5yTximF5Dry2T5Hj4J/ZsAB9RNqdmwj5JI9S+UgqqrUQ717EaUwqthTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE+SgXlYeKP1UvnD6RZYO9Bt7zs8mBOAkwKgo7CCnAM=;
 b=bMoSjSz6+/WWLEIdUqbIv8wg2oCQpmlw3OwTMWPY9p0UQG1pp4JNrQuNAWBLEUFAiu/vJu0I+igpFfJ0hbMiY8ODp+oBuEOut/JahDXFcbTBGyxDtLGVeoPOrOF71hh69kAQVbPP6qbPg/wq08OTT6/s12uB/El/tUEkKVlcK1E=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by OSQPR03MB8398.apcprd03.prod.outlook.com (2603:1096:604:277::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 18:23:22 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 18:23:21 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>
Subject: Re: [PATCH 2/2] dts: arm64: mediatek: mt8188: Update OVL compatible
 from MT8183 to MT8195
Thread-Topic: [PATCH 2/2] dts: arm64: mediatek: mt8188: Update OVL compatible
 from MT8183 to MT8195
Thread-Index: AQHbTKtPbnmu4O4qiEy/9nzOUMyN3bLixgSAgAAme4A=
Date: Thu, 12 Dec 2024 18:23:20 +0000
Message-ID: <52d88608156c3ced97f3d6b3d5722ab7f1747ea3.camel@mediatek.com>
References: <20241212153344.27408-1-jason-jh.lin@mediatek.com>
	 <20241212153344.27408-3-jason-jh.lin@mediatek.com>
	 <6710abd1-128d-48ff-84a1-880053fd9e84@collabora.com>
In-Reply-To: <6710abd1-128d-48ff-84a1-880053fd9e84@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|OSQPR03MB8398:EE_
x-ms-office365-filtering-correlation-id: aa9c41e8-99d8-4601-2d64-08dd1ada0eb0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bTVEbEZNSTAyU1o3NURGb3pWR04xNWpoNGJuQTlibDlUQ3dqUmk5UVdHTWtv?=
 =?utf-8?B?cmZVd1lJK2todVl1N01QbkxLTUZGTXEzTGJyMjlqYnhRZ2FUaTM1NTFVN3l4?=
 =?utf-8?B?dVowWDFKK2daZnFOMmxHK2k0Ukx2RjVBL3A1RTAvb0p0MkFYRlVMb0ZoZ2JI?=
 =?utf-8?B?L0tTc3dPeCs3c3ZMbWZNaU1MdWpxa2svQnM3VlJ4dlRSb3pUcCsxOFpsN3Ns?=
 =?utf-8?B?TXo2V3RFYkFCVlBCSlVjdFRPdVEwMEJDUlU5dnZBelFCRTQ4YmFYcXJkNStv?=
 =?utf-8?B?b3B0QkF4SmR3QUxpMHIxcGlXOHh2by8ybkRHWkhITmFacDVWL09ZN2l1MTR6?=
 =?utf-8?B?ZnQrOUxZVHdkbkc0RFNZUGtXRzJyMDdFWitBakRwL3RTeVdEL0RCT0tGUDUr?=
 =?utf-8?B?VHFWVnNXOFJrcmZpK3ZHYld2OGhlczVwKzhMQklGTmRtVUI2cWxBUW5BVlJT?=
 =?utf-8?B?Q1kwUHhGUWpsU0NkeFV4eEROTFN4WWljTWdqT25weGdlbHFmWTRHaXViNS9o?=
 =?utf-8?B?QW9mZkJDMStQN0xBQkFwN0lVdUc0VFM5TERnaitiMGplVTY4YXBnVEdCMzJm?=
 =?utf-8?B?MDlUaXVzSnJXdi9XVnNzYWRzaDlOSEdoMEE4QmpjTURIZy94d1YzM3U1MW9l?=
 =?utf-8?B?N0pZZXQ0bjJrQ2pZWGhqaUpBbUc3V25IeUFSWXBXYnNEZHpVUzVEc3RUV3JU?=
 =?utf-8?B?b1BHaFpUNlpkYkY2endTR3JhbHNjREhHYTZwY0pPZG5qS2drOEJCRHd0TS9P?=
 =?utf-8?B?M1pKWDNXNUh6cThZb1RsRGJQNmxXT1FZSksrMVMyeEUwMDlCd3gxUHRoZzRL?=
 =?utf-8?B?eEI0bnJzbjZ5VEFDV0dlMlhUZHlWaWpCSm5RK0lrSEltQ05hSnltVGF6d3RS?=
 =?utf-8?B?eXpFQnc0cjR2aDYyQ0ZoTVNsMFlRcG0rZU5mNjBQT0cxbW02ZEdGTVlkUW9W?=
 =?utf-8?B?TlRPMkM1bjk4MUNhZjJhVVpZMmV3eW5xNjl2V1kzYzFxL2RUWTAraWpqWHJh?=
 =?utf-8?B?TTR1RlY3eHFBOGVRQklqSU1udkhybXI1OG1JV3hGZDgxZm5SKzJ4NWlpYjRn?=
 =?utf-8?B?R21hbnR6VUs5Ynk5VFUwMk1Hbk1wT3l5SldlaUduTENKbXh6K1l1OS9ZMC9T?=
 =?utf-8?B?dXBwMXF1aHp3Y3AydWpudkJsM2xxWEs5TWUvSjZlUGJNMkdEK0ZuNmJPenpk?=
 =?utf-8?B?L2JYK1JXdFRLV0xOcG1JaW1zYzNxRVYzbVZlNHd0c1JZZzQyM2drS296S3Zp?=
 =?utf-8?B?S2M4NE5UQzJhVzMyTnZuWkxBak05VUdoRENGR3VUT3RZVXNMVUNzMTB0cVV2?=
 =?utf-8?B?T0FndHdITDB5UUpjRktsT0hoanMyR0ZSa3hOY1dwQXI1SUNnTWtoeHk2M3lM?=
 =?utf-8?B?a2NuVjFaV2pzMWZsQ0Z5clo0enExV0tyWlBTekljb0RuSms1bEU3Y0lUc3VE?=
 =?utf-8?B?VW5NQTFQTlUzYVFmeW9tZURocWg2VWJ2aXF1ZlEwa05Xczc3WFpZdDBGd1RK?=
 =?utf-8?B?RkU4S1o4VVkyY0QwS1JvcWFlNlJQWXBRcERVVEh4SUNjTkF6WFB3RERXME40?=
 =?utf-8?B?WWxEWjA1dTFsRHY2TkhRd0NFOHk1b3FzT0dKaVJzR25WdXAzVFJ1NGVWYjVQ?=
 =?utf-8?B?OFk3aVVvZ3gwWHc1MXFRQk5LWDg5UUxkKy8vODVlNUVpQ0hHc0NSSmtSRzQz?=
 =?utf-8?B?L1Y5VU1UaGw0OHNHM1ZyWmxiUEtGaVpuU0lSeUl1eHVVbW4wSWcrRkdUWkl3?=
 =?utf-8?B?WnoyOHQzRnB1ajM0V1Z6OXc2SFMwdnF5VFhCcmRsUnUzYU5Gb1RzWE9KZjR3?=
 =?utf-8?B?Qm1PcHNUVWFaZFlkd1QzWStiZ3NSaFM1WDU5dndVTzdEYlYwdy9Oa0MxU25G?=
 =?utf-8?B?LyszT0hQZ0VUNG5QTUR6bHpTdTdPQ1pBa3lITWVpdjhBck1EL0d6SGRTRHl3?=
 =?utf-8?Q?vcfqSeS++kv5eN1AdOiGNESROH6J0mjP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1MxeXVYbkh3U1V0SXk3MGtXem1BZnRKWGRIUUlqUDloSHpuNkpraDdjYklS?=
 =?utf-8?B?SnN0bkhDOGFOcVVTT01DaE9CaE1JQmlRd2VEa2hOTjdTWUxnUW05L1pDb1NY?=
 =?utf-8?B?TEVwOFA4dmVoWHhNTzVNbHFIV2tTa0dHbGFzSUVLU2hEZmJEZElNOVY4NXdK?=
 =?utf-8?B?UzU3Smd6UUNZNkx0bHRyUDViNjEySEdGcXZ1dDdsRTQyb2V5ZzVLQkM0THNh?=
 =?utf-8?B?alpsTGpCYnhnd1NHcnNkTVRMS0tJaFZzM0FxODEyL0xqT1ZLZ3ZkVDR0bmtk?=
 =?utf-8?B?V0FsRVRiOU1qa0gzZW1tdTNjUk1DRkFKU0dxdmJDMFdweG9leXNSTWdyV01o?=
 =?utf-8?B?bUZSdUk1cGN4eDlSUmFFQWprTW5uR0VHRXZrWGJydk5FUlBieU8xamlpVWdY?=
 =?utf-8?B?SE1HZTl2TjVvTHZWcTVNcytlTlkzTWpBbDZNVTRwNFF5VklVcWRRZ28wem4y?=
 =?utf-8?B?ZTlHdXJCQklCZWZsQllmR0NnZDNsVmJGbjJ2RjM4Qm9lQmgvSmRYa1ZNaWJs?=
 =?utf-8?B?V25hZ1pKbFRxVGhJeTdXY0JiZ1hxZ3VvUXpUSXhjRmxURnJBYW1wQzk1Y1ox?=
 =?utf-8?B?MitDR2lLR2I1S0tYTE04cGtxU0NQWDlITjk4ODNrY1ZmbkdkcG0yWmVITW1U?=
 =?utf-8?B?VnV2ZngvNDZKYzNmc2xHcDRaODk5S1R0L0h2V05lRnEyZmFEZ0JRWU1aT2l3?=
 =?utf-8?B?eDZFQ0RDTHdIQjg0dVhlTjBjdHZGaHZwSHQ3Ti9zWGtWRlNZb3gzaTQ5aHlz?=
 =?utf-8?B?R1dkcE1YQm9YVFdnTE1ndXU1c2xLUUU1dkZjeTJCYnhBTHhHWnBFWkR6OHht?=
 =?utf-8?B?cEp5eDFMcW1RMzBrY21rNnhQOW41UDE1QjVkanVQYVBaVWZMTEhENXNCYzZT?=
 =?utf-8?B?aVROUHF4T1N5RW5GVFhWdVhPMFdoQjlhNVJZTFFySTBNRnc5ZHVOV2psTUdy?=
 =?utf-8?B?TVVhVlBkYnJiWjd1YzU2Tk1HcWU3anl6R3FrdmVObmZWQ21FTTBOVXhRMWVt?=
 =?utf-8?B?em1FSUttT2NVTmdFSkdvVmRGbzFsSkhyUDRwMy9CRmcvR1pDY2RLWE9UM01s?=
 =?utf-8?B?L3V3aGo3dmJTNm84MGg1Tk5HbWV3ZXFVSXZqZjdZSlBUaWhuOGJVZDZqdDdj?=
 =?utf-8?B?UG16bGphV0wyQmUrZ2FJM3pTZEdybDduRWNnTFFzN2RISmwreFJpWnUwOWpX?=
 =?utf-8?B?UEZvSStjTkxQYWM3NEhOdUZaSE1SZW81RU1OMC84SEhhOWpUVElheXJMN2o2?=
 =?utf-8?B?NlBWZmxqZkcvNnFOczNrNmpNTHFaSWdhR3dBWU9HWGFMZlJGQk9Fd1hSWkM0?=
 =?utf-8?B?ZFl3bm9KTC9TVFdwbFJwdzkwMnpBNUNvb1R5K1k5Q2c2OHQ1alNHVm9qOTIy?=
 =?utf-8?B?WUdmQzhVM3h4RDB3N2tkRURqWWl1ZUVNQkErbEVrdVB6cUdNSWZkQkpPSi9p?=
 =?utf-8?B?VnlaOHhxM29rNGJFMnZYZXZ1dlAvVWlsNkpScUJCNHJqS3JvOW50ZTd1UDFo?=
 =?utf-8?B?Z0s3eEMrc0dld0lqQTZNRUlWZ0tMZkxhdGFvV3Qrd2ZUZzM4MXFBemNlQTlo?=
 =?utf-8?B?ZWtDL21HQVcxdEplYnh0TVRONEZaTWlVWHl6cGk4aUdFZi9qQjlVdXJQTmlo?=
 =?utf-8?B?ZFoyTXUxQ1FuTTh4S1ZyYy9jZGJCSllRYnVWZUNScGpDWWZKMnkydTRZUHMr?=
 =?utf-8?B?MFAvWHg3bWJuR1NtVnlNZUxPQVZDUUVmcnZkZXVkVUdwUExtYzRNQ1JOOUpK?=
 =?utf-8?B?bTJTOWtWcW05QXV6K1lOZ0lPQ0I2cFA2ZHpQUGhTb3pGdzBLazlCWEJCYzBQ?=
 =?utf-8?B?OVlvbkdBSEdkR2hzY2U3WGdrVlIxdVZlZHkwUUxWanpBLzdKMWc3UnlHZjl6?=
 =?utf-8?B?ZEphT1c0OEhLN1JoZS9uWmViREVmNyszbWtHM0Z0U0FqVFgwT3JCWit2SFFa?=
 =?utf-8?B?RmU0TFlxMkFSc25KWDgyci8rdWNmWHJvNEZJS0xDK1Y3U1JQMmduMFhvQlFy?=
 =?utf-8?B?L2RtTmpPU2JDNWtlbTdIYlRmS2xaUDhtZTB2ekNlV21QTzFHOUlBQXF6dENx?=
 =?utf-8?B?NVJaYmdOMkhXU0hpelNmQXZjbUJlMnBZb2thRkFtWEhuTmE3R1Mrdzlvbjgr?=
 =?utf-8?B?OW8yL3ZMd1NucWk0dDBJTVZTR3kzbUVmbjZ4NmVINTRlYitmUnErODd0UURC?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8849ECF32AF4D54BBCC486C802386353@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9c41e8-99d8-4601-2d64-08dd1ada0eb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 18:23:20.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpkYTOGBkvmwUN5roF4pCw6ZJSic4hxDAuslSOkvCqIyO+BfO+DHlqVtzqQPQK8Kh54iZDV1dg9N0G4sItS0mSksP+JLPfcbHTVg0zMA200=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8398
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.371200-8.000000
X-TMASE-MatchedRID: QfHZjzml1E8NtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCopoEWlZvizRmlaAItiONP2gD0t7xcmlukAUhps0BUS5a0J
	xLB6uDia0gSfyR/0zX8G1D0L4Gl+6Hr5GF+LCVZ0zw5Ejs3g1ltF9F+XaXgXeOGCgDN6EbfaoBf
	Cx2HzmBvYTKxShsZm5RseL//cvWrjaQe5JMuXOhSmjEOrcO6AyTJDl9FKHbrlyTn0y32aE/6PFj
	JEFr+olFUew0Fl/1pEBi3kqJOK62QtuKBGekqUpPjKoPgsq7cA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.371200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	23CED3F84D1F7DB0FCB7EF20F32804549BC3847D39C5A045BE0328D6084445322000:8

T24gVGh1LCAyMDI0LTEyLTEyIGF0IDE3OjA1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxMi8xMi8yNCAxNjozMywgSmFzb24tSkgu
TGluIGhhIHNjcml0dG86DQo+ID4gVGhlIE9WTCBoYXJkd2FyZSBjYXBhYmlsaXRpZXMgaGF2ZSBj
aGFuZ2VkIHN0YXJ0aW5nIGZyb20gTVQ4MTk1LA0KPiA+IG1ha2luZyB0aGUgTVQ4MTgzIGNvbXBh
dGlibGUgbm8gbG9uZ2VyIGFwcGxpY2FibGUuDQo+ID4gVGhlcmVmb3JlLCBpdCBpcyBuZWNlc3Nh
cnkgdG8gdXBkYXRlIHRoZSBPVkwgY29tcGF0aWJsZSBmcm9tIE1UODE4Mw0KPiA+IHRvDQo+ID4g
TVQ4MTk1Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgu
bGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IEphc29uLCBqdXN0IHNvIHlvdSBrbm93IC0gSSBoYXZl
IHBhdGNoZXMgaGVyZSBhZGRpbmcgRFNDIGFuZCBtZXJnZQ0KPiBjb21wb25lbnRzIG9mDQo+IFZE
TzAsIG90aGVyIHRoYW4gYWxsIE1EUDMgY29tcG9uZW50cy4NCj4gDQo+IFRob3NlIGFyZSBhbG1v
c3QgcmVhZHkgdG8gc2VuZCwgSSBvbmx5IG5lZWQgdG8gZmluaXNoIHNvbWUgdGVzdGluZw0KPiBi
ZWZvcmUgOy0pDQo+IA0KPiBGb3IgdGhpcyBvbmUsIGFueXdheToNCj4gDQo+IFJldmlld2VkLWJ5
OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVn
bm9AY29sbGFib3JhLmNvbT4NCj4gDQo+IA0KDQpIaSBBbmdlbG8sDQoNClRoYW5rcyBmb3IgdGhl
IG5vdGlmaWNhdGlvbiBhbmQgcmV2aWV3Lg0KSXQncyBva2F5IGZvciBtZSB0byByZWJhc2Ugb24g
eW91ciBwYXRjaGVzLg0KDQpKdXN0IGxldCBtZSBrbm93IGlmIEkgbmVlZCB0byBhZGp1c3QgdGhp
cyBwYXRjaCBhZnRlciB5b3Ugc2VuZGluZyBpdC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0K
DQo+ID4gLS0tDQo+ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4OC5kdHNp
IHwgMiArLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTg4LmR0c2kNCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTg4LmR0
c2kNCj4gPiBpbmRleCBmYWNjYzdmMTYyNTkuLjIzZWMzZmY2Y2FkOSAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4OC5kdHNpDQo+ID4gKysrIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODguZHRzaQ0KPiA+IEBAIC0yNDg4LDcgKzI0
ODgsNyBAQCBqcGVnX2RlY29kZXI6IGpwZWctZGVjb2RlckAxYTA0MDAwMCB7DQo+ID4gICAgICAg
ICAgICAgICB9Ow0KPiA+IA0KPiA+ICAgICAgICAgICAgICAgb3ZsMDogb3ZsQDFjMDAwMDAwIHsN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODgt
ZGlzcC1vdmwiLA0KPiA+ICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OC1kaXNwLW92bCIsDQo+
ID4gIm1lZGlhdGVrLG10ODE5NS1kaXNwLW92bCI7DQo+ID4gICAgICAgICAgICAgICAgICAgICAg
IHJlZyA9IDwwIDB4MWMwMDAwMDAgMCAweDEwMDA+Ow0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICBjbG9ja3MgPSA8JnZkb3N5czAgQ0xLX1ZETzBfRElTUF9PVkwwPjsNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDYzNiBJUlFfVFlQRV9MRVZFTF9ISUdI
DQo+ID4gMD47DQo+IA0KPiANCg==

