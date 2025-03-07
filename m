Return-Path: <linux-kernel+bounces-550548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0CA560FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F833B1B7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61B19DFAB;
	Fri,  7 Mar 2025 06:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Avhg0bl4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lwTzCEIJ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2636B19CC0E;
	Fri,  7 Mar 2025 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741329495; cv=fail; b=HN/rBDRyaatjgeJ7Nd8u0x9CCWE/J5rR/jxxtVds3DRJ6Ir9gaE3Fr7jwa4xkxwj4Brr5B1HE1Vr7deWX9ElhTRstzsTchUA2ONp/53iPWL9kdCB7fK7tiz9nkI/vr7/BDJfKGRYCaEnloPhIkzyhYm0SIWG7gRCzrCusJhqglA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741329495; c=relaxed/simple;
	bh=F5ujODxZlljhGK2TpohT0aL91hjJVaMp9lVvY6FivkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uv5EId/iaTNQ17UbmCcAK+Vh/KIP7dGgUuvXUCOziqag2LnDYT0W8PPiKLtaaWjntdGSDV2fPi65Y6Gzbwh3CkCfZh+dPueOzl4caqsv9G+aINVEF3NZpnI5oATq6CNaW8ZRWUFUiRj6cbVGIQh0yZOeakorQBDBtT6m+0NvjSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Avhg0bl4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=lwTzCEIJ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bb0a5c50fb1e11efaae1fd9735fae912-20250307
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=F5ujODxZlljhGK2TpohT0aL91hjJVaMp9lVvY6FivkY=;
	b=Avhg0bl4JSkgwXBKCVsvVEAH5jLf9/i74jF+baQRumTREWRednt7y4W2SRUftBUN1eXAQ+GrIHswgAygh5DdleFl6ikYVEInrRWSNHDazn5dr1mdDUpBltdjqw4rUUF72zxPKmCvDjat71D0Xjo1PV+TfMQl+V0VGAyJc3l7EUA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0eb5c7fa-d67e-4db5-a16f-0bd7bf1e244b,IP:0,UR
	L:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:12
X-CID-META: VersionHash:0ef645f,CLOUDID:ec7923ce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: bb0a5c50fb1e11efaae1fd9735fae912-20250307
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 691546208; Fri, 07 Mar 2025 14:38:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 7 Mar 2025 14:38:06 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 7 Mar 2025 14:38:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wih6Yi7C4TthecCGYcI6Da3c6gTr6fmODkzbbjF7SpVrVtjrNnQyQSTU3fesSxbx01UPamqeS8bSAWwFywKFZRKEfnn9oXjBy/Gi6Lm5TBqUKwd8yyhJYkzfyDVle2ZZtn9bVqMtKyTo1e9ZQStL0LlBR/ZVI0FNoiSGvd0erliY6I52PWW2HGJNA5Ujugwd8yLv0mdNYuWD2xPIMqkiV886Kpdku9AkqryEdUSmRK8h+KhZTQqVf2pnetJsQ7lRddcaKCj+sNW1Sf5sLerrKXIhofZUQu2WDZJKI3dHy2sAck0yKkVynovvLld/WjfrtFnvE7ZK+Dx/bDz5lda5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F5ujODxZlljhGK2TpohT0aL91hjJVaMp9lVvY6FivkY=;
 b=eSNou1sZjpsfn+d6xmjco/pMfUavtjs6G7ShLXyGhtVwMrycWNtfGv7RaaG9RvCJJdEOyuc9CFILsogxj38Td7ymsdL8DmL/QgyJnDnU73klk6RVFtF6VXl3EwvcLrA+o9r+uxgGbbdHL4TBng2KNPv8zFmJ0/3nPl4Tr2dvhxZkswldkNOdngBkIjEgXJKQjuSjZ3in5Hp17fWqleNMW6k0SzpxFWoNVonoKMxekPBXXXHwzJloc0jERxmmNPrlzBT7GGTpfrblZMzFgOquyDtesumqKtIfOKjoiL/8W54J6oofyh3BD5JRe9G1bkRZGpZJ7rbQ4O7J4DB0ENrYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5ujODxZlljhGK2TpohT0aL91hjJVaMp9lVvY6FivkY=;
 b=lwTzCEIJoyEHafYiembrzN7AVTQapwYN4lJrMzpAJX5y6SjpCEKhigJpnNHUqOrEEMZgyE9ske15Qt5qgPGQ+gInum+1U2nfZl3tF8tNPfO6FhHRi0n8lD6cfMeMnRD7qyCgeZ2WLbE52navHnKc6W4tMsBLcnJXtcT8d+pRTl4=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by SEYPR03MB7507.apcprd03.prod.outlook.com (2603:1096:101:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Fri, 7 Mar
 2025 06:38:02 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 06:38:02 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"krzk@kernel.org" <krzk@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Topic: [PATCH v4 1/2] dt-bindings: memory: mediatek: Add SMI reset and
 clamp for MT8188
Thread-Index: AQHbhDU04J68TaDqUUGrlWTkL0+oIbNWJ1CAgA/7o4CAAACugIABKuaA
Date: Fri, 7 Mar 2025 06:38:02 +0000
Message-ID: <9305a4fd6829e5e2ae6c3247d11b9f47ed277f8b.camel@mediatek.com>
References: <20250221074846.14105-1-friday.yang@mediatek.com>
	 <20250221074846.14105-2-friday.yang@mediatek.com>
	 <0dcb2efd-6bbb-4701-960a-74930eb457e4@collabora.com>
	 <264f78c1067e363c69e146543ebb77dbedfbd181.camel@mediatek.com>
	 <463ca2df-a0ee-4b9e-a988-12f316ae7d1a@kernel.org>
In-Reply-To: <463ca2df-a0ee-4b9e-a988-12f316ae7d1a@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|SEYPR03MB7507:EE_
x-ms-office365-filtering-correlation-id: f6892531-77a4-4db7-cd81-08dd5d429be4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018|13003099007;
x-microsoft-antispam-message-info: =?utf-8?B?b2hpazdKODRab1gxNXNMMUZ3Q0hxL3IvY2ZTUWFFbnhqV3dOUE1adVVRMDY4?=
 =?utf-8?B?QkgzLzVNV2ZvQVFoK0pJVlpxRmhiOGE5VjhNUXlSTWw4WmNRb0RBYXNoQlB4?=
 =?utf-8?B?QTZRM0dJUXVtSEJMdmRUZjNlakVsQURmN2tma1JWSmx5Wll5dDJJZElyZ1Rz?=
 =?utf-8?B?MHNrNTRvazFwNzJYaXV4UzZWeEtINk00bTI3TGk4MjZSd2RBMnMyQ0JJWVU3?=
 =?utf-8?B?dHNzYmdObVJJejBQcm01aW1MYjByVlR5ekdnT2sxajhmK2FtcEF3ei8vZVhz?=
 =?utf-8?B?LzgramMrUFVHdVVTSUlyeUdaaHV3V2hmeTlqRWpidCtuTFo1amx3L2luKzJE?=
 =?utf-8?B?OEkxY1VKNTk4UVVNcWNRV3paTGtNUE1BMEZ2NTJVNTMvRmlIby8wMXQwU255?=
 =?utf-8?B?ZlR6d09MdVBrWEdOc2FVRVFPdXJIQS9PaHB2cnpYM3hvZXVCSGpNWFB0dkNX?=
 =?utf-8?B?bVhyekhCbEVBMTRBblYrVnZ5a1FwZUZ1eVJ2L2Q5N1lxN0VFYlZOOURLd0Q1?=
 =?utf-8?B?dElXZUJtRmRuZmJ2VWtLU2lhZEg0d0oyZUZlcnJabndyRUxCUVFWdUZWZEd2?=
 =?utf-8?B?VXVhblBTMmoweXBLSCtlR0paTE1JYlZhSHhIQmdwUDMwVDYyUXpvemRPQ203?=
 =?utf-8?B?eE1Qdk9qOEtQci9HTkZ1OEtNVGNNckJQdGQ4RGRTYjA5R1BaWUhFSWdtK3ow?=
 =?utf-8?B?dXZtTWpzTWNlZ1lGd3dlQWhPTWxSaW1KbFN2UFZEZ0hkSXIxYnVaMnJML3Fo?=
 =?utf-8?B?NDdSU0o1UFBqSVZSb0xJVUFSaEYvaFZDd2pDNGhoeWxpS1h6S2xHanhWbzlD?=
 =?utf-8?B?NDRqK00xR240QzRTZjNJR25CSmxRRExJMXBXWlptZWVYcEE4WjBZc1M2K1gr?=
 =?utf-8?B?RSs5M0M4ejRndjA1N1hFQ2VodnlucTl2ZHBiU2IyRjNZcFF0ajArN2pmeVZk?=
 =?utf-8?B?ZjdSQU1Xd252N1JoRWlWSUhOdmFCMEFRdTNISFRKODByTEJLN3Y4WDJvWSsy?=
 =?utf-8?B?czJsbHRYOC9wamZrejg0ZUoxajlPNFhnUjFIL3I1Y1BOZ1pUdFdEWDU2OS84?=
 =?utf-8?B?Q3JIZmpxZ3pUcngzdFNFQ1VSYUVXTE9lazFCL00vZ2RjSFIzeGZlM2FXYXlS?=
 =?utf-8?B?YllVL2JQV0xPamhDZitROTVLVXl0MmwyQjRFOHVDekNVbDhuT0k3K3ZXVHRZ?=
 =?utf-8?B?ZGw3STRlY3NnU0d2V0ZmS3RCMDZqRm44bkcyWjgzcTdSblZ4cVo4Zjg0THNw?=
 =?utf-8?B?TGN6RnMzdHFzL2JERkNBdHZQYjlqcWtzcWl5ekZaQXRYOUtXVTh0cjZpY3E3?=
 =?utf-8?B?aElZK2JQZTl1cjRKOERNNnRpb2IzTTVJamNTeGVIaXAxZkt1UytGTzJlMDFm?=
 =?utf-8?B?QnhFT25BakZPYk95RituV0gzdFUweXVsaW1HeWwvdTVoYWl5NnpYYktIdHZo?=
 =?utf-8?B?emxOMS9BY1BaQWFSVlREMCt5cUtVclFlVG16N1A2c0o3aHBQSG41K2hKbFV5?=
 =?utf-8?B?UTY5Sm95K3VheE1pRVJvRHNSNDRRN3FYdUFwNnZxRzhQRmhnbjdDaldiK2xY?=
 =?utf-8?B?WHBpWVNpRmQrd2dxSkIrVFo0UUU3UHh6L3d2clNHNExPeVc3YU5VbWVlWnI3?=
 =?utf-8?B?em51Z2JadmxSUHplSDhuZVhLZ0lKeVR4SzQyTVoyejE4T2NkVHhZM2s0MS9p?=
 =?utf-8?B?dzl0Q3Z2VWlLR2Y4elpUWm9yVXArVC9qaWpoZEpvNHJFSml1OUdIOVRzUXFB?=
 =?utf-8?B?SWMrdG9rVUo2MmRWUjZLenloOHd0OHdSNFYvM1g0dUNmU0hBUGFZSVNpTjhR?=
 =?utf-8?B?ZDhKTVRRWG9ReklhcHFhZVlMRTdQc0NqSWxqay85TzJ3VkdneDhCU3I0UHFL?=
 =?utf-8?B?Z2V2UHdKTk1laG82T0ZzWWVSQWg3VjFpWVVTcGRHWDF3Q0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OThCcHptVDZEbEpEaXdZYjJOYjc2cllCanZYczYzeFN3OHFwSWNpNWdjeTdX?=
 =?utf-8?B?V3BTbG5rVmJETnB5NXFxY2IzcnlWVXNCWG5pbFlMSVlTTTN3cEFEUnpJNFI0?=
 =?utf-8?B?VDRUdFBaaXlSR2pZc1lQTHhkWjgxbUtiVGwxWVNCYUR5NnNqNTZyMms4MGxI?=
 =?utf-8?B?S2Fyb0NaNm5wazRQOHozR00vdFl0cndDUklFL1ZkU2JnVjNmL2taK3krenV5?=
 =?utf-8?B?RjVaYU9UQ0pUZ2Z6eElVcjh4TXlDSFpDTWVodDNuU0VGYmhhaU8rZUlzeHdN?=
 =?utf-8?B?ZzFFWXNKRThHZzZDN25uL0MybzQrZHBNbVBiNk1MU3M1WFQvL1pLM1g3cVI2?=
 =?utf-8?B?eTVkRUsraUE0blRGdjY3NndtSXUyandMNU44cURHb0tSa1luWTFqQk10aW12?=
 =?utf-8?B?TkVrQjhrOUxZVWhENjFING1TbEc4MlYzck5pL09ONWFoSFlLbkhYUHo2MDlh?=
 =?utf-8?B?SUIyS1JQT1Y0NTgrK1Q1NTd0Rk53Uzl6WjNtQThzV2lpeG45Y0cyaVVqcDVO?=
 =?utf-8?B?L29icnpGR2lrSTl6NnVwZFVzeEZ6UDFyY1BPUE1YODI5NklpbUhqcmFZeE1m?=
 =?utf-8?B?eVpsenEzai8wRU1uUnI3cWdyUmZsbFBpSFIrUE5RU3c4ZFFzT2IzcFhVbkw4?=
 =?utf-8?B?UVhPNnViRDFvMmFzUnFXZTJlYk55Y01tTkczYkRxbERSS3p5aTJvVXZqbGlL?=
 =?utf-8?B?NUxCYTVHOGZwMld6VFIvQTgvRnFoZG1SM1hKeUdnZHpsdDVBbUxWRHI3QTlM?=
 =?utf-8?B?UEdLWWQ5VGVSeDRNc1l2YzljVjJTd3loQkt4QWRiSENhNWlsOWdGWEM2M2R1?=
 =?utf-8?B?MFBBQnRPSVk4TGNhb2pJVTVJZjA3K01iR1RvdFg5ZmtzOWVWczVNTTVHdnJr?=
 =?utf-8?B?aGF6ZERRcG9FM3phekhXSnZXaHl4eU9OMHJIU2FUMTZuWGcwZENFakp3cnA4?=
 =?utf-8?B?dGhDZFRUa0VmNTBibEdRTkxXYUZtK2hYWWxkb25lS0dCbmdXRGt0a1JhYzNr?=
 =?utf-8?B?eUdjd3lNUWNiMnZLMmR1R05lUHFjck5kT1lVcFdxdGRySVdIOU1NcFZmRVQ4?=
 =?utf-8?B?UmpOSDAyWjAyOEQvSEdFdlBoVkpJRXpZck5Qb0N4NE5yalRQU3NiK3cyQ3Fp?=
 =?utf-8?B?bXV5MXgzaUV6N3NsRmd2ZVNjOVFGU0FZMEtzclFSSk9RUHJuVWJHSUZqNCs5?=
 =?utf-8?B?aUpaUVh1Z0NjQU5kZ2Z0S0tMTHJqQVVkRTVFNi9TeHBzQlhnVzNhekd3alJo?=
 =?utf-8?B?cDZVdnBmdFlOa3dqSkM0cFBXKzZUeURzT0RkZUlQSFBMYUh6TkNwbWFOcGU5?=
 =?utf-8?B?cm5vZC81V2xEcEZ3R3VqMGcvaFAxV2xVMnlEVVRZNG9LY05QNXBXU3Erc1Q4?=
 =?utf-8?B?bFRYYzZlZzA5OGJlMFE3UHN0a1ozem1sN0F5Rnc2cE53N3FqUXFVNHphK0Yv?=
 =?utf-8?B?TlY0TzJ5Vk9QQWdRODEyZWdqUzVhV3BMa3hEa3BDNUhQODdpU1BwNURxQTlx?=
 =?utf-8?B?ZnVWZHZFa21SYW9ldFRiSlI5ME5NNUJuTnVSdjhKKzYzYVAwS0ZzK2FUZjE0?=
 =?utf-8?B?SEM4UzNKc1dkdXc1aGUvUGtwOVcrR3RFRFAwRHV6YmdHc0ExVlBWMU1CVUdw?=
 =?utf-8?B?UW9MdzZDY3B5OUowYTFPQmw3MWp0N3lDSysyclBwSENZR2JMZ1dnbzZpOG82?=
 =?utf-8?B?eDBMaEdWYUtuRzhBS09ndDN6V0tBR3BqTlUwVkJUSEYwbk5nb2dhMno2RmNa?=
 =?utf-8?B?NW9ENmx1VVp1Z1BDUXhCcXpHSC9WUkZnVzl5NVI5cjJISmJHaW5SWit1VnlP?=
 =?utf-8?B?eStaY1cyZ3NMVFFwMUxuZm9wN1RMZ2JyaE5laC9RUHBDRnBkTFVuVlJHUkFE?=
 =?utf-8?B?citvcktYRGxXMURXa1pEeVlCSHV6cU9jaDFUV2kvSUNZTFJVVUlTdXA2c3lG?=
 =?utf-8?B?K0Q5dUVreFNyUzNSeFlLMFlXUGc4akZyL2NGTkJYdG5pcW1hY09BZExucU1Z?=
 =?utf-8?B?NWJFc0pDcTFRUDdKelc1QXZGU05yb3BYeVNEQWthTnh3UnhKeDFNU3p1K3Fp?=
 =?utf-8?B?eUN2ZVg2RXNxWFhtcGJUa1loT1Y4RDBHVWlRM1R1WXNoRWdWSzJidVRDZU5W?=
 =?utf-8?B?UVhyajNObHFpNUdxb3puTCttWXR1SnJ5WWlnYnROaG9uVlJneDdZcVRZZGgz?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F755911B7034243992A629B4F386D23@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6892531-77a4-4db7-cd81-08dd5d429be4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2025 06:38:02.0555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFgfrZlrgXKtO1PMIEElmMqwDpMI+eE7B510nvS7w+AOnVTfKrlG21fztF6niILvwVA1x9CAYZsgkhyG5NYkTQMqNFO8/Dyj6WnvuyvrAII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7507

T24gVGh1LCAyMDI1LTAzLTA2IGF0IDEzOjQ4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDA2LzAzLzIwMjUgMTM6NDUsIEZyaWRheSBZYW5nICjm
najpmLMpIHdyb3RlOg0KPiA+ID4gPiArICAgICAgICAgIGNvbnN0OiBtZWRpYXRlayxtdDgxODgt
c21pLWxhcmINCj4gPiA+ID4gKyAgICAgICAgbWVkaWF0ZWssbGFyYi1pZDoNCj4gPiA+ID4gKyAg
ICAgICAgICBvbmVPZjoNCj4gPiA+IA0KPiA+ID4gQXJlIHlvdSByZWFsbHkgc3VyZSB0aGF0IHlv
dSBuZWVkICdvbmVPZicgaGVyZT8gOi0pDQo+ID4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBB
bmdlbG8NCj4gPiANCj4gPiBZZXMsIEkgaGF2ZSB0ZXN0ZWQgaXQuIElmIEkgdHJ5IHRvIG1vZGlm
eSB0aGUgJ2V4YW1wbGVzJw0KPiA+IGxpa2UgdGhpcy4gVGhhdCBpczoNCj4gPiAgIGNoYW5nZSB0
aGUgY29tcGF0aWJsZSB0byAibWVkaWF0ZWssbXQ4MTg4LXNtaS1sYXJiIiwNCj4gPiAgIGFkZCAn
bWVkaWF0ZWssbGFyYi1pZCA9IDwxMD47Jw0KPiA+IA0KPiA+IGV4YW1wbGVzOg0KPiA+ICAgLSB8
Kw0KPiA+ICAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTczLWNsay5oPg0KPiA+
ICAgICAjaW5jbHVkDQo+ID4gZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTczLXBvd2VyLmg+DQo+
ID4gDQo+ID4gICAgIGxhcmIxOiBsYXJiQDE2MDEwMDAwIHsNCj4gPiAgICAgICBjb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4OC1zbWktbGFyYiI7DQo+ID4gICAgICAgcmVnID0gPDB4MTYwMTAw
MDAgMHgxMDAwPjsNCj4gPiAgICAgICBtZWRpYXRlayxzbWkgPSA8JnNtaV9jb21tb24+Ow0KPiA+
ICAgICAgIG1lZGlhdGVrLGxhcmItaWQgPSA8MTA+Ow0KPiA+ICAgICAgIHBvd2VyLWRvbWFpbnMg
PSA8JnNjcHN5cyBNVDgxODhfUE9XRVJfRE9NQUlOX1ZERUM+Ow0KPiA+ICAgICAgIGNsb2NrcyA9
IDwmdmRlY3N5cyBDTEtfVkRFQ19DS0VOPiwNCj4gPiAgICAgICAgICAgICAgICA8JnZkZWNzeXMg
Q0xLX1ZERUNfTEFSQl9DS0VOPjsNCj4gPiAgICAgICBjbG9jay1uYW1lcyA9ICJhcGIiLCAic21p
IjsNCj4gPiAgICAgfTsNCj4gPiANCj4gPiBUaGUgJ2R0X2JpbmRpbmdfY2hlY2snIGNvdWxkIGdp
dmUgdGhlIGZvbGxvd2luZw0KPiA+IGVycm9yczoNCj4gPiANCj4gPiBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS0NCj4gPiBs
YXJiLmV4YW1wbGUuZHRiOiBsYXJiQDE2MDEwMDAwOiAncmVzZXRzJyBpcyBhIHJlcXVpcmVkIHBy
b3BlcnR5DQo+ID4gZnJvbSBzY2hlbWEgJGlkOg0KPiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNv
bS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL21lbW9yeS1jb250cm9sbGVycy9t
ZWRpYXRlayxzbWktbGFyYi55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYncha0V3V2h4eWZqVnR1
SEtCSGF6WkdSYUZkbG1yVTJiY0lzaVZEY3NVRHpFSU1hbk13MlhJRzlSZ096cTc3M3Z0bXFsUjlf
c1daREZoVTA5U1YkDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21lbW9y
eS1jb250cm9sbGVycy9tZWRpYXRlayxzbWktDQo+ID4gbGFyYi5leGFtcGxlLmR0YjogbGFyYkAx
NjAxMDAwMDogJ3Jlc2V0LW5hbWVzJyBpcyBhIHJlcXVpcmVkDQo+ID4gcHJvcGVydHkNCj4gPiBm
cm9tIHNjaGVtYSAkaWQ6DQo+ID4gDQpodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlhdGVrLHNtaS1s
YXJiLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFrRXdXaHh5ZmpWdHVIS0JIYXpaR1JhRmRs
bXJVMmJjSXNpVkRjc1VEekVJTWFuTXcyWElHOVJnT3pxNzczdnRtcWxSOV9zV1pERmhVMDlTViQN
Cj4gPiANCj4gPiBBbmQgdGhpcyBpcyB3aGF0IEkgd2FudCB0byBhY2hpZXZlLiBPbiB0aGUgTWVk
aWFUZWsgTVQ4MTg4IFNvQw0KPiA+IHBsYXRmb3JtLCAncmVzZXRzJyBhbmQgJ3Jlc2V0LW5hbWVz
JyBhcmUgb25seSByZXF1aXJlZCBmb3IgU01JDQo+ID4gTEFSQnMNCj4gPiBsb2NhdGVkIGluIGlt
YWdlLCBjYW1lcmEgYW5kIGlwZSBzdWJzeXMuIE90aGVycyBjYW4gYmUgaWdub3JlZC4gQW5kDQo+
ID4gdGhlDQo+ID4gJ2xhcmItaWQnIG9mIHRoZXNlIFNNSSBMQVJCcyBhcmUgc2hvd24gaW4gdGhp
cyBhcnJheTogWyA5LCAxMCwgMTEsDQo+ID4gMTIsDQo+ID4gMTMsIDE2LCAxNywgMTgsIDE5LCAy
MCBdLg0KPiA+IA0KPiA+IFBsZWFzZSBmZWVsIGZyZWUgdG8gbGV0IG1lIGtub3cgaWYgeW91IGhh
dmUgYW55IGRvdWJ0cy4NCj4gDQo+IFlvdSBkaWQgbm90IHJlYWxseSBhbnN3ZXIgdGhlIHF1ZXN0
aW9uLiBXaGVyZSBpcyBhbnl0aGluZyBhYm91dCBvbmVPZg0KPiBpbg0KPiB5b3VyIHJlcGx5Pw0K
PiANCj4gSSBhbSBkcm9wcGluZyB0aGlzIHBhdGNoc2V0IGZyb20gbXkgcXVldWUuDQo+IA0KDQpJ
biB0aGlzIFNvQywgd2UgZW5jb3VudGVyZWQgcG93ZXItb2ZmIGZhaWx1cmVzIGFuZCBTTUkgYnVz
IGhhbmcgaXNzdWVzDQpkdXJpbmcgY2FtZXJhIHN0cmVzcyB0ZXN0cy4gU01JIExBUkJzIGxvY2F0
ZWQgaW4gdGhlIGltYWdlLCBJUEUsIGFuZA0KY2FtZXJhIHN1YnN5c3RlbXMgbmVlZCB0byBpbXBs
ZW1lbnQgYSByZXNldCwgd2hpbGUgb3RoZXIgTEFSQnMgZG8gbm90DQpyZXF1aXJlIGl0Lg0KDQpU
aGUgJ21lZGlhdGVrLGxhcmItaWQnIGZvciBTTUkgTEFSQnMgaW4gdGhlIGltYWdlLCBJUEUsIGFu
ZCBjYW1lcmENCnN1YnN5c3RlbXMgYXJlIGFzIGZvbGxvd3M6DQotIGltYWdlIHN1YnN5c3RlbTog
OSwgMTAsIDExLCAxMiwgMTYNCi0gSVBFIHN1YnN5c3RlbTogMTMNCi0gY2FtZXJhIHN1YnN5c3Rl
bTogMTcsIDE4LCAxOSwgMjANCg0KVGhlcmVmb3JlLCB3ZSBiZWxpZXZlIHRoYXQgJ21lZGlhdGVr
LGxhcmItaWQnIHNob3VsZCBiZSAnb25lT2YnIHRoZQ0KdmFsdWVzIGluIHRoZSBhcnJheS4gQ291
bGQgdGhpcyBhbnN3ZXIgdGhlIHF1ZXN0aW9uLCBvciBpcyB0aGVyZQ0KYW5vdGhlciBwcm9wZXJ0
eSBJIHNob3VsZCB1c2UgaW4gdGhpcyBzaXR1YXRpb24/DQoNCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCg==

