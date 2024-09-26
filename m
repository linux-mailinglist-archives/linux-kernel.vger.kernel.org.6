Return-Path: <linux-kernel+bounces-339820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC4986AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADF8B221A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BE158DD1;
	Thu, 26 Sep 2024 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y1yUEtYz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vnX9H9Yg"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3781D5AAD
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318095; cv=fail; b=smHm6qDnQb6ClNZw8dIcx1LePJl2NJ8g9yBepNQMiXbJS3bVsYz6sK8mgJ7My+V+cL7C/zmgtrUuE/u6Zb38arPRegNxQOfLfEkKgLD2OyQ2QkTKkNS7+e7htwORb8Wtzzm2lg5tBnBAnuAAXs0owBbyDb21pz7zteVdDgsJqls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318095; c=relaxed/simple;
	bh=iw3LLibOwA5EZU7Pyn5jY4HQDzWzHsa4mRV6j/+37Q4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R3ujGYiJZR+u4USxEZLunSY0JZno3o7BjeHLTL3cVFdvWznysawiBt9XPC+Lr8AE/egp14KYprhCMo03/4dupjvDUXR3I+x2+cHm1BizKzyrS1qGrvwdBZC27u8RACa3Yprj0XzL/eb7yXCnYnt72LYBqnYpH6SD1gOO2HYB7z8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Y1yUEtYz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vnX9H9Yg; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e49c371c7baf11efb66947d174671e26-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=iw3LLibOwA5EZU7Pyn5jY4HQDzWzHsa4mRV6j/+37Q4=;
	b=Y1yUEtYzV7HG5mAN9q7MFjMDbBXKMJ/xLuRNIOk4PbWgs82LZw7FzjuFP7MKRo5QlXec04rV/Ms1kN8DLrFwGyV0wE0s1EBYGFruXAUkvMcHrEEfXneFZ8rn7nWz1QLPuX4xKWBt0SvHM//MCQQdVBZAsyyq6hDUHyAsl0DMHlU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e10462c4-ebf2-4dd8-bf83-72988d34d9d6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:035dc7d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e49c371c7baf11efb66947d174671e26-20240926
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1031988433; Thu, 26 Sep 2024 10:34:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 10:34:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 10:34:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guo/c18zENMAsbslMtx7W982ThzSrKVHeXkQobRs6QdAdYwZ2TfTpdLBqPrBPsJMjUlMy819aWZTMq7/047saaCjaGTGOMh3AMIyScCwbJwZodn87v0uCV5J78ypUST65YRJtJhPbqtq36UujSMrpr4fOyKSPllVGmNYFsNEAh1UNcux0vtdSqjmnvuw58HKWUZlKsgdb5jPX/QDAmhqTE862dBhPAqwJyXlx1VX3O4++R883mQwo8JMZdW6jOp0ZTapVvvhynFwv1CUEDj+mgYCv7lQvZwYjzveOjgI/ZXDKVRbx504unqK+UsadIveShmCaCljq9zgFRHSAm3WcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw3LLibOwA5EZU7Pyn5jY4HQDzWzHsa4mRV6j/+37Q4=;
 b=BOeX86iarV+mF+atvwBPR8D6xOQCoUD0PDLCDx80H2pWvA1U9j6KuDSMSAaLi2wrccmuXxB1KBBkB9WotvdOlVTkAJulTZgXTJSNpIZFtOjrnrEKMhGymm7gtzIp71HSvSZvyRVqHSgNTgUoZ5cQFk5dDlW3u/5s9ysLVf2o2C7BSN5qRtbkaJrHzjm6f+rENb5Mtszm7/rhc/YE8FA67yipdkG85/YWZuvS6QCnPKkjesI/oRYSV2KPaemg3Wxv9UishVR+XUQ8UTNurpluYT+nAULugYwduKIeYvh0Fk/l14vvQrEi8v91HL/EvU0IXPevr31o1TJh9XVcasT8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw3LLibOwA5EZU7Pyn5jY4HQDzWzHsa4mRV6j/+37Q4=;
 b=vnX9H9Yg/wKIRsPnxAAjePoWmun52DrTBX/o5I87Lf8klTxShMXk2RCEnhIp2vw4iG01jypPy1tN9ze8nizTwyla51FSTKlAKoYkjjXu9xnbdT81OYXqrEQHkkX+jryRWBBtULqX7zKAfBocuTcHd+sjvTClKMX9t8i+OGpIGU0=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by SG2PR03MB6431.apcprd03.prod.outlook.com (2603:1096:4:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 02:34:41 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 02:34:41 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Thread-Topic: [PATCH v5 2/2] drm/mediatek: Add blend_modes to mtk_plane_init()
 for different SoCs
Thread-Index: AQHbDzSJHdif4aeUVUqaZW98bj+oHbJpWtuA
Date: Thu, 26 Sep 2024 02:34:40 +0000
Message-ID: <bcdabb15b002c47512358cfabdfb49bc12f42596.camel@mediatek.com>
References: <20240925101927.17042-1-jason-jh.lin@mediatek.com>
	 <20240925101927.17042-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20240925101927.17042-3-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|SG2PR03MB6431:EE_
x-ms-office365-filtering-correlation-id: ea3993ed-3b9f-43d1-8286-08dcddd3c600
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NUkxYXpvT2dyM1dSbVV6ZHB5Ym0vUGVERnRpQjlpazd1VkRhaU1hWGF4Rng4?=
 =?utf-8?B?aC9GYWNhUDZ2R20zbTlWMGtEbUxNQkRjbXFHM0c2b3FMaUZLNURtS1ArTk5X?=
 =?utf-8?B?N2cvbGs0UXU1MWd1K29pQmVpNEdjOHV4ZnN6NlQ3Si9mUDY0NVpxN1ZSMHNX?=
 =?utf-8?B?azBMVGlHbndjVXIySi9heUFva2V4bXRWeW82MU40QmdqbVZVbloyVUpjMnpF?=
 =?utf-8?B?cTNEanRGMjllVW0xdkQ1T3pXdVREYUkyMjVIOEQxUXN1eGQ5K1I0bjRBeFFs?=
 =?utf-8?B?OCtNVThnU1pFNldEZFNsM0lRRThabmtEbWN3dVdiQ1ZYZDZVKy9NUytwOCt5?=
 =?utf-8?B?dGtzMzFCTStOcmphVnZpU2grbWhDWThRcStQUTVuUWdXNVdEWWZkU0hyQ0sz?=
 =?utf-8?B?WEZIM2l5TlFOUGU1RlBVbTFSUFRSNHM5LytnMW5mUDdzTnVXM1UrdlFxOXFX?=
 =?utf-8?B?NXEzdWE1M1JzU3lnalp2TjQveUZma3Iwcy9aTEdaMTBZS2hzUlF0aTFkMWNm?=
 =?utf-8?B?ZGpwWEFuWHR5aFhVYVNsTHF0bHdSb25TRHF1aDdmSDdENk13ckdHWjV0bnUv?=
 =?utf-8?B?eWlONWU5ZHVxd3ZzYXNYbFJGM0pzUXRCUzFhc1VWbkJINEhhcTFnS0YxRWNS?=
 =?utf-8?B?TmlibWNVUGNNekVBS3I3OUo0WlliN1hxV0E1REFVckZTNTZ1ZVZYMkdVeFRy?=
 =?utf-8?B?NzNFOW9PZG1wNTVOc3BkbjhtNjFBelVYaStLaEFWU0lmaHJqRFpEb01nVW5q?=
 =?utf-8?B?d1VNVTlXcEd3K1NrakVQaWphTkxNMGU2Rllad3dxMy9mYnJsZHdjQVVpTGlu?=
 =?utf-8?B?NDN3MXVDeXBzcDYzaVdjdUFQTUEyckJWd3V5UDB2bFdzVTZNM0dtQ1RmakRx?=
 =?utf-8?B?dUU2dDM2djA2Rk1ndnYza2l2YVFVd01NMXd3VXBiUWd2aHFVODk4eTZJdXpC?=
 =?utf-8?B?V1FTQjV6TEtoUFdaYmxGVjRhejB3S2tGcEpjUGxQZ2NyUGVJVWdkNHA1eTV2?=
 =?utf-8?B?bkZuOE90WXB4bkZDekR5SmEwOTR6UFhmU3Z2UC83ZERLaTQ3YzFqS0dVV2xx?=
 =?utf-8?B?ZnpyWUduMHFVSXA1TEFWZzg2bG5KQVoydkQ0MGZUUTlBUkliV2tTckFlT1pV?=
 =?utf-8?B?MEY0MFljenlPYUJPeTBpL0dVcUJoMHZJbllHUGwzWk4reXZmVE8rNUU4cEM4?=
 =?utf-8?B?S3AybnNWdmtReThZTHUyMmRKT3RaZGZwajhDOW5aYTVKM2ZjS2tiU1g5MUJE?=
 =?utf-8?B?UGZqSVM0K2I0bjlyMjQ4b1g4dWJUdVBSTUFQYzNGeXdvc3lwMUZsYzJtWTUz?=
 =?utf-8?B?b3RxMzlxTmRlNDJaK0RKdWVBQ0tscTNERnhuQVpVTWNvbzRWYmtTZXpzREt3?=
 =?utf-8?B?aXI2UTBXUCthWHlIVXpFa1J5VVZMbUJNdEpVeDlQbVVHYSs5blBNdGNTb05h?=
 =?utf-8?B?NjErRFRWSzRUVGtUYWpuMGI3OTBld2xpVGptSHdYWWJHSnU4L21NSFFrNXVr?=
 =?utf-8?B?WG5zaVdlMG5kck9EM1lUbVJNN1FOcnVuS2RNdG9lQkp0VHczRktoVWloQ1k0?=
 =?utf-8?B?S3BKSHB2UGRkSUxJcjJFRFUxdDRhMy9YMXphbDRUaU53Qm9BRThRVzZMUlg5?=
 =?utf-8?B?a2hPdDJINmhOZmRtRmhWN2d3U0lkdklFbU14b04wQVhGQy9pM2hLY0QzaTRs?=
 =?utf-8?B?TitacEZtNlZHV3FqR2FhOVg5b3NwVkFXeFgyeVN4NjBsejdZaFRBMklOM09T?=
 =?utf-8?B?cVdXN0FjVm91dVpyNlgxb2IwZEdkdUtURG9LMWNpY0R0KzhXZ05pWmxmS2hB?=
 =?utf-8?B?VXZCeUdRdlVHVFJlQVpEdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEJpWVpuQnArY0ZvNEpxdVhyVndMSHlWbFhObXJBekpzdllIeTd0clg3VWNI?=
 =?utf-8?B?cmh3MUFLOXNKdHFKUkVPaWFSYnM0N0ZoNkVpUFk1cXBMQU1OV1gvSDlPLzlz?=
 =?utf-8?B?cUxvV2ZQZk9MakV2N1cxbWtQRTBwQ1ZEdzlyMElNMHhkKzk2dzRUM3B2TERW?=
 =?utf-8?B?cU8yVnFzSGlzOTVsMzV2dlpEcjZjaFhjY1RNVDNBTFgzMzQ4MnZHZU9rbkVp?=
 =?utf-8?B?WlJuNEJIeXphRm83dzVzYW53Vk5SNlR6bXVhY0lzeENDbCt5aTRPRFBPcnpD?=
 =?utf-8?B?MWhHS3R5bmpnTGF4djdlaHdiWlNCYjk0VVNtRmZXQytWUU45ZkJqRnVreUZI?=
 =?utf-8?B?OWI3TWU2amVLU3BRcEo5WDJ0RUJQWUIxdXAxMGJNNXVlaytqSkpZNkZEbWpX?=
 =?utf-8?B?Y0s1WEhGTGZvMStNSElobVA5VmtzYm5sdWMyNVR6akEwcndmcWdxMXJ4UWdG?=
 =?utf-8?B?S25WdytvM3h0ckpZaWpPZGRONDZ6SCs4MExXU2RhaEpUMTZrV2taTVBFSk9h?=
 =?utf-8?B?NEk3SHdZOVdxbitlOFVPY2FwcDN0cWRpUkhzRENDWms4YmFCZXVJQnpycjFR?=
 =?utf-8?B?ZjRmMGZEWGsrTUNsWmZTVmNhc1FhNTVxd3ZOS2NWRXhqdEZoK0MrQm1UQVJt?=
 =?utf-8?B?cjNrWWFjcjJGTC8rYWlEOW9kTStBOXpxUDBrNExHZGpuWVgxdTZ0ZDdnRkhs?=
 =?utf-8?B?ZGRDYzhoTE05U2hJM2M5Qm9BeUFqRG9id0RaYUp5Z08yMEYzQk5QUUY0MENr?=
 =?utf-8?B?SVRDNGQwSy96U01RRXhCZWFqZWYrQzYxNEhJcnB5TmNaZjJLZTB1Qk55UXpX?=
 =?utf-8?B?TGRKYzk4VVk1MWhmNitjQ096OG1UTGoxK0NJdXo1SU9TQ2QyK2Q4RGk3M0Np?=
 =?utf-8?B?dkpmdXNPWGxXVElUTWV2clRqa0RBZ1NMUkVyb01CcG4rczJuNXZ6TmF2ekJt?=
 =?utf-8?B?VytRZWdDc1FGRG5XaWxpRDg3bGdxU09mcnF6WHBmMHgxOHB3WWprTVhoL3ZE?=
 =?utf-8?B?WCtEZVFsejJVTXdaOTJVdmN6K3M4cXhUS2wvTUphOEREYXB1VUJNbGZvYWF3?=
 =?utf-8?B?OTFGNW1xWk5TYVdVUU9MRmg4bmk3aUtRZCtqVHBKcUh6amM2eEwzWFZlMXJj?=
 =?utf-8?B?WDNReitUaWkyY0YyZU5jL0lxR0xVcjdVNmI1cmJLbVRkTGRBZWxLL2huelNW?=
 =?utf-8?B?S3RCMVh5L1IrMkFZUXBGYlNTODExaTVsdVgzS2wzSlkwQmRvbmhoTm5PKzhn?=
 =?utf-8?B?dHBQVEpoY1hHY0xydWZCZFh2Rm1KTEVYLzRlbHk1ekJtaHFxOVI1Ni9qNFpk?=
 =?utf-8?B?L2NKTmdrd2VxRWxvemduc3NNWEVvcjdLZld4OFBjNU00YlZqWnYrTFBWSE5k?=
 =?utf-8?B?UTg4RjdhSElWYkFtZ3VENVZpbi9JVWNQaVdPeGtlb0RpM1g1TEhSRWI0WUd3?=
 =?utf-8?B?K0l3c05KVGxzNGJyTktQWFhRVzJzb2NjWFljNzl6Mm4vMEU3NnMvcTVzSkov?=
 =?utf-8?B?TjdMdkJXRlUyczRZVHRWV2NtQTNjdjNndklNemtCcitIa2d6cVVyVTZ2cGdZ?=
 =?utf-8?B?Q3E3MzYyZE8zU0tqMDgxMkxFNzJCcXQ5OWl5UDJYdXo2UnFvL1hPQ1NOODVw?=
 =?utf-8?B?VVFaT0syVm9zUjVBOXdiTld6blQ4Tyt3RUc1OHFldjBJaTg2TGlwZFVyYm5Z?=
 =?utf-8?B?anlUY0k1T2ZBWHpwRUk5eXF1ampOQ0VXMzlDKzBULzRUekxFeEx3aGQ1YWUw?=
 =?utf-8?B?QzR4b29pQTNLSi9NQVMrWUJZTFhaNHQzUHY3TWNZSGxWNDQ5ZTFETGJTaHpx?=
 =?utf-8?B?Z2VCNm5iUlJJL01wZjRWK3VJaGZMU3NkcnFpTnZQcXZsczdmODhTd1l4VVc1?=
 =?utf-8?B?dHZzWGs3enpnTCtlV0czQXA5VFp6RTNBMExhcVc2ZWZaelZESlo0akxwNGVQ?=
 =?utf-8?B?RHlWd0p6Z294NTBNdHQvalZCRng3UEY0UHQ5Q01TMjloR2dZQmh1QkRzT0gr?=
 =?utf-8?B?MVl2bkJmamE0aFB5MVJZc29WSVFacUgvTDk1dEJjNzB0bit2eHRxUzByZ1FX?=
 =?utf-8?B?a1VJUzk3cnVuU3MzYjN5V0VJQXNuak1qRG1aWWV5WldhbWdFMTBYSWx0VU9X?=
 =?utf-8?Q?6IPtnjdXlf9vCMYQkmPGSjrS9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA898D99CC6A3F44AF2BAA8654B53837@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3993ed-3b9f-43d1-8286-08dcddd3c600
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 02:34:40.9374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MRsg3AMdI3kOzNfBSev7vZmuVNtjoRIsXkABqQvqqZTpvQMPMKAscuznANBA9SZNUuOeowCj2L4+VxHNuVJ0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6431

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjQtMDktMjUgYXQgMTg6MTkgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gU2luY2Ugc29tZSBTb0NzIHN1cHBvcnQgcHJlbXVsdGlwbGllZCBwaXhl
bCBmb3JtYXRzIGJ1dCBzb21lIGRvIG5vdCwNCj4gdGhlIGJsZW5kX21vZGVzIHBhcmFtZXRlciBp
cyBhZGRlZCB0byBtdGtfcGxhbmVfaW5pdCgpLCB3aGljaCBpcw0KPiBvYnRhaW5lZCBmcm9tIHRo
ZSBtdGtfZGRwX2NvbXBfZ2V0X2JsZW5kX21vZGVzIGZ1bmN0aW9uIGltcGxlbWVudGVkDQo+IGlu
IGRpZmZlcmVudCBPVkwgY29tcG9uZW50cy4NCj4gDQo+IFRoZSBPVkwgY29tcG9uZW50IGNhbiB1
c2UgZHJpdmVyIGRhdGEgdG8gc2V0IHRoZSBibGVuZCBtb2RlDQo+IGNhcGFiaWxpdGllcyBmb3Ig
ZGlmZmVyZW50IFNvQ3MuDQo+IA0KPiBGaXhlczogNDIyNWQ1ZDVlNzc5ICgiZHJtL21lZGlhdGVr
OiBTdXBwb3J0IGFscGhhIGJsZW5kaW5nIGluIGRpc3BsYXkgZHJpdmVyIikNCj4gU2lnbmVkLW9m
Zi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0K
W3NuaXBdDQoNCj4gKw0KPiAgY29uc3QgdTMyICptdGtfb3ZsX2dldF9mb3JtYXRzKHN0cnVjdCBk
ZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gQEAgLTY3NCw2ICs2ODIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19kaXNwX292bF9kYXRhIG10MjcwMV9vdmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmxheWVy
X25yID0gNCwNCj4gIAkuZm10X2NvbnZlcnQgPSBtdGtfb3ZsX2ZtdF9jb252ZXJ0LA0KPiAgCS5m
bXRfcmdiNTY1X2lzXzAgPSBmYWxzZSwNCj4gKwkuYmxlbmRfbW9kZXMgPSBCSVQoRFJNX01PREVf
QkxFTkRfQ09WRVJBR0UpIHwNCj4gKwkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9QSVhFTF9O
T05FKSwNCg0KV2hlbiBibGVuZF9tb2RlcyBoYXMgbm8gcHJlLW11bHRpcGxpZWQsIGZtdF9jb252
ZXJ0IGlzIG10a19vdmxfZm10X2NvbnZlcnQoKS4NCldoZW4gYmxlbmRfbW9kZXMgcHJlLW11bHRp
cGxpZWQsIGZtdF9jb252ZXJ0IGlzIG10a19vdmxfZm10X2NvbnZlcnRfd2l0aF9ibGVuZCgpLg0K
DQpJIHRoaW5rIHdlIGNvdWxkIGtlZXAgYmxlbmRfbW9kZXMgYW5kIGRyb3AgZm10X2NvbnZlcnQu
DQoNCmlmIChkYXRhLT5ibGVuZF9tb2RlcyAmIEJJVChEUk1fTU9ERV9CTEVORF9QUkVNVUxUSSkp
DQoJbXRrX292bF9mbXRfY29udmVydF93aXRoX2JsZW5kKGZtdCwgYmxlbmRfbW9kZXMpOw0KZWxz
ZQ0KCW10a19vdmxfZm10X2NvbnZlcnQoZm10KTsNCg0KSW4gY3VycmVudCBwYXRjaCwgd2hlbiBT
b0MgZG9lcyBub3Qgc3VwcG9ydCBwcmUtbXVsdGlwbGllZCBidXQgdXNlciBzcGFjZSBzZXQgcHJl
LW11bHRpcGxpZWQgYnVmZmVyLA0KZHJpdmVyIHdvdWxkIGtlZXAgZ29pbmcgYW5kIHRyZWF0IGl0
IGFzIGNvdmVyYWdlIGJ1ZmZlci4NCg0KSSB0aGluayB0aGUgcmVzdWx0IGlzIHdyb25nIGJ1dCBp
dCdzIGVycm9yIGhhbmRsaW5nLg0KSWYgd2UgYWNjZXB0IHRoaXMgZXJyb3IsIHdoeSBub3Qga2Vl
cCBvbmx5IG10a19vdmxfZm10X2NvbnZlcnRfd2l0aF9ibGVuZCgpIGFuZCBkcm9wIG10a19vdmxf
Zm10X2NvbnZlcnQoKS4NCg0KaWYgKGRhdGEtPmJsZW5kX21vZGVzICYgQklUKERSTV9NT0RFX0JM
RU5EX1BSRU1VTFRJKSkNCgltdGtfb3ZsX2ZtdF9jb252ZXJ0X3dpdGhfYmxlbmQoZm10LCBibGVu
ZF9tb2Rlcyk7DQplbHNlDQoJbXRrX292bF9mbXRfY29udmVydF93aXRoX2JsZW5kKGZtdCwgYmxl
bmRfbW9kZXMpOw0KDQphbmQgdGhpcyB3b3VsZCByZXN1bHQgaW46DQoNCm10a19vdmxfZm10X2Nv
bnZlcnRfd2l0aF9ibGVuZChmbXQsIGJsZW5kX21vZGVzKTsNCg0KDQo+ICAJLmZvcm1hdHMgPSBt
dDgxNzNfZm9ybWF0cywNCj4gIAkubnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10ODE3M19mb3Jt
YXRzKSwNCj4gIH07DQoNCltzbmlwXQ0KDQo+IEBAIC03MTUsNiArNzMxLDkgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDgxOTJfb3ZsX2RyaXZlcl9kYXRhID0gew0K
PiAgCS5mbXRfY29udmVydCA9IG10a19vdmxfZm10X2NvbnZlcnRfd2l0aF9ibGVuZCwNCj4gIAku
Zm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gIAkuc21pX2lkX2VuID0gdHJ1ZSwNCj4gKwkuYmxl
bmRfbW9kZXMgPSBCSVQoRFJNX01PREVfQkxFTkRfUFJFTVVMVEkpIHwNCj4gKwkJICAgICAgIEJJ
VChEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkgfA0KPiArCQkgICAgICAgQklUKERSTV9NT0RFX0JM
RU5EX1BJWEVMX05PTkUpLA0KPiAgCS5mb3JtYXRzID0gbXQ4MTczX2Zvcm1hdHMsDQo+ICAJLm51
bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+ICB9Ow0KDQpbc25pcF0N
Cg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9h
ZGFwdG9yLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3Iu
Yw0KPiBpbmRleCBjNjc2ODIxMGIwOGIuLjJkNDdiNmViNGMxOSAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gQEAgLTQwMCw2
ICs0MDAsMTMgQEAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfZGlzYWJsZV92Ymxhbmsoc3RydWN0IGRl
dmljZSAqZGV2KQ0KPiAgCW10a19ldGhkcl9kaXNhYmxlX3ZibGFuayhvdmxfYWRhcHRvci0+b3Zs
X2FkYXB0b3JfY29tcFtPVkxfQURBUFRPUl9FVEhEUjBdKTsNCj4gIH0NCj4gIA0KPiArY29uc3Qg
dTMyIG10a19vdmxfYWRhcHRvcl9nZXRfYmxlbmRfbW9kZXMoc3RydWN0IGRldmljZSAqZGV2KQ0K
PiArew0KPiArCXN0cnVjdCBtdGtfZGlzcF9vdmxfYWRhcHRvciAqb3ZsX2FkYXB0b3IgPSBkZXZf
Z2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiArCXJldHVybiBtdGtfbWRwX3JkbWFfZ2V0X2JsZW5k
X21vZGVzKG92bF9hZGFwdG9yLT5vdmxfYWRhcHRvcl9jb21wW09WTF9BREFQVE9SX01EUF9SRE1B
MF0pOw0KDQpSRE1BIGhhcyBubyBhbHBoYSBibGVuZGluZyBmdW5jdGlvbi4NCkdldCBibGVuZCBt
b2RlIGZyb20gZXRoZHIuDQoNCj4gK30NCj4gKw0KPiAgDQoNCltzbmlwXQ0KDQo+ICANCj4gQEAg
LTM2NiwxMCArMzY2LDcgQEAgaW50IG10a19wbGFuZV9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpk
ZXYsIHN0cnVjdCBkcm1fcGxhbmUgKnBsYW5lLA0KPiAgCWlmIChlcnIpDQo+ICAJCURSTV9FUlJP
UigiZmFpbGVkIHRvIGNyZWF0ZSBwcm9wZXJ0eTogYWxwaGFcbiIpOw0KPiAgDQo+IC0JZXJyID0g
ZHJtX3BsYW5lX2NyZWF0ZV9ibGVuZF9tb2RlX3Byb3BlcnR5KHBsYW5lLA0KPiAtCQkJCQkJICAg
QklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSB8DQo+IC0JCQkJCQkgICBCSVQoRFJNX01PREVf
QkxFTkRfQ09WRVJBR0UpIHwNCj4gLQkJCQkJCSAgIEJJVChEUk1fTU9ERV9CTEVORF9QSVhFTF9O
T05FKSk7DQo+ICsJZXJyID0gZHJtX3BsYW5lX2NyZWF0ZV9ibGVuZF9tb2RlX3Byb3BlcnR5KHBs
YW5lLCBibGVuZF9tb2Rlcyk7DQoNCkZvciBkaXNwX3JkbWEsIGJsZW5kX21vZGVzIGlzIDAsIEkg
dGhpcyBpcyBub3QgbmVjZXNzYXJ5IHRvIGNyZWF0ZSBibGVuZCBtb2RlIHByb3BlcnR5Lg0KDQpS
ZWdhcmRzLA0KQ0sNCg0KPiAgCWlmIChlcnIpDQo+ICAJCURSTV9FUlJPUigiZmFpbGVkIHRvIGNy
ZWF0ZSBwcm9wZXJ0eTogYmxlbmRfbW9kZVxuIik7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfcGxhbmUuaA0KPiBpbmRleCA1YjE3N2VhYzY3YjcuLjNiMTNiODk5ODljNyAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19wbGFuZS5oDQo+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuaA0KPiBAQCAtNDgsNiArNDgsNiBAQCB0
b19tdGtfcGxhbmVfc3RhdGUoc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3RhdGUpDQo+ICANCj4g
IGludCBtdGtfcGxhbmVfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LCBzdHJ1Y3QgZHJtX3Bs
YW5lICpwbGFuZSwNCj4gIAkJICAgdW5zaWduZWQgbG9uZyBwb3NzaWJsZV9jcnRjcywgZW51bSBk
cm1fcGxhbmVfdHlwZSB0eXBlLA0KPiAtCQkgICB1bnNpZ25lZCBpbnQgc3VwcG9ydGVkX3JvdGF0
aW9ucywgY29uc3QgdTMyICpmb3JtYXRzLA0KPiAtCQkgICBzaXplX3QgbnVtX2Zvcm1hdHMsIHVu
c2lnbmVkIGludCBwbGFuZV9pZHgpOw0KPiArCQkgICB1bnNpZ25lZCBpbnQgc3VwcG9ydGVkX3Jv
dGF0aW9ucywgY29uc3QgdTMyIGJsZW5kX21vZGVzLA0KPiArCQkgICBjb25zdCB1MzIgKmZvcm1h
dHMsIHNpemVfdCBudW1fZm9ybWF0cywgdW5zaWduZWQgaW50IHBsYW5lX2lkeCk7DQo+ICAjZW5k
aWYNCg==

