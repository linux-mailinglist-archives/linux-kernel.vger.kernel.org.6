Return-Path: <linux-kernel+bounces-444432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FB39F06A8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883DD169CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292671ABEA0;
	Fri, 13 Dec 2024 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="B2YvXWnT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bTi4jZO9"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC46EB4C;
	Fri, 13 Dec 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079449; cv=fail; b=UNnAkwZakip4P1NZmEPhW1/RxYe4Cv4PRb8Me2Qh7wB1YEHmTXAwhpK7nC1QuEMGpl1TCJpICoHrf1j5UwbP0SVXkW2T10aMpLv5C92egkFwPsoU6IQOvzkwNHpC6HQin+t5uuFxddf3ROIO5Qox/nkd9vtJzx3Lpj6atcD0ZEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079449; c=relaxed/simple;
	bh=zqBQ9tHTGO0dzOGEr2mOzrEe/7d3IhJ5FIt0yr562MM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlWXF9oZKNDgwgRhf0ntxZLeRuVOmcZDU8m8t7bahXmbo4yVgAp2ypwq1kjjJhlEJo1Ap4RC9tFP2R9sIFHVmcq51M7Tx3pspMX+8cZx1yo0NZ1jSDvnGiKQtzv1X2vQmQR0RtFjZovmLV/jIbFIDtEuaIDosNiMEjo0tdfid6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=B2YvXWnT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bTi4jZO9; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 669f3604b92e11efbd192953cf12861f-20241213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zqBQ9tHTGO0dzOGEr2mOzrEe/7d3IhJ5FIt0yr562MM=;
	b=B2YvXWnTYg75Ahn9NZKZ98IIxRYgnfwq/HRY6gqG8YZN6ZlehbF1UkXrB4y4a0fCdNC4vEYYXZEcAOUpZjdl9y3jBY8JCsqyUarXDmF8KzzwgHC8M2NUXVMDTLxVlX6pupm92/1aERKs/aCTR2rMgZbDMfcJrF1dzhWc/AlnQBQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:517de425-17ab-4170-8ac8-51091aaff8bc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:e06c1413-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 669f3604b92e11efbd192953cf12861f-20241213
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 337666289; Fri, 13 Dec 2024 16:44:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Dec 2024 16:44:00 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Dec 2024 16:44:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abhVGLKyQS3tlM3UDv0q/lGKF4+W87fy76A10ZQVb/8NJtywmm7scdl6JS4ycX3aB9Fcvf6EfanuuV/jMsGyfDt8V6wmyMuF9z0C6dBlvavTO8uVSEwJ1Cvm/PkiLeybknLtyE+mMwr77b1EVWfVb3CENxd1QnGzrCc95KXY+Jiv57lzAmCIPOmAjIH+tFG3AL5df2GPWWit/Mo+CQzzmbz1du2QH8AxFn+lblmtJL/LNIxiMgWWhYLIyXKWpjUdBlb+MVn2oM3Fp5VnD75Oxr/WAhl9baVTDSS0Jo8str2lcXmLgvXNjVOg+vKdlLWcpLoNI5J4Kgs4iG8IFyvLFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqBQ9tHTGO0dzOGEr2mOzrEe/7d3IhJ5FIt0yr562MM=;
 b=oMweXgaW9PLQRDrm4HnHH/czlDWDVYaeKSRRYlhvoHrxY3pMtR+QnesSkSR/+9VXxaUtHpfSJ3CE5DwaGdV/ha9PfrMLqybZ2dmjUDIiPA8+1AjxdcKtFOD3vlorarJrNMqOMNmCUOw9I2nKkfsWWKvD6r3+RkWXL6SexjUjwFek50M6Qb5hCYZkX6fp8lMwOHjVZGtj/6UEJ3iHYPSjLXprVpzk+3UrxAvhlo3A2uZZ9Xlvn2e1M61JDLeIbcjhFcdY9FRikH9pA/AecZThey77cxk7gh9aO1rXQsQgtiFU8Y4dOhNp4Xj6rXYLWlt8JGUGNXbnH1Vhz9Rkugl24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqBQ9tHTGO0dzOGEr2mOzrEe/7d3IhJ5FIt0yr562MM=;
 b=bTi4jZO9yAYvOJIV9T7egpOmwoDJ6x27frf3XhCa6qT6F9tUn+q/I9xnWPXjCLSkSYwayMsvFQs+xjZkgnbUngNtHweR2btYdoqT7rCkWZBHDzOHvb6tEYXFjQ2wnUzhFOYG1XuwpN+Y1eTQTD1jbNzeCT4USzUOhzfa+SXk0mk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7855.apcprd03.prod.outlook.com (2603:1096:990:2d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 08:43:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 08:43:57 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Topic: [PATCH v2 12/15] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Index: AQHbRwuDKzLMLP8gmEqSnf1CFqiN77Lj6DSA
Date: Fri, 13 Dec 2024 08:43:57 +0000
Message-ID: <47a462d2fe848d3d23811a554516bec1b0424821.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-13-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7855:EE_
x-ms-office365-filtering-correlation-id: 061a2f9b-a58c-43e8-ae83-08dd1b5248b3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qmt0ZzU4ZFRVWmRwd1FDdXZMcTgxamNXdkpLU0prSHlGUk9FRWhNV3l1RFNt?=
 =?utf-8?B?cGVTTkU3UDkvWGUrYUxTR2ppT0FCTmpKbFJ0MlVmZFlTMHNoZWgxMkY2NEZM?=
 =?utf-8?B?aEF6bFphM3kwWGE0WjNTVTFySHlOOFp2anRUeE5DOUVoWjkxUWJGbXU4eWRa?=
 =?utf-8?B?STlJTTRuaFlhbEo4OU4yck5CMU5mMk9Ha2JBa2ZNYXNEZy9DSHRMdW11NGdJ?=
 =?utf-8?B?RVdjM1hzN2UvRVVaai9mY3E4TGRjUkhnQkZPeVNWZVdQRE5URWxpK29jMUFW?=
 =?utf-8?B?K3MxcUtOU2d4WDE0bU1mZFBiMjlaNys0MXp5TWpVN2Z3U3M5RjlUZDF6WDlz?=
 =?utf-8?B?MGVsbTFPZEhmR2pNVlJtV25GWlFCSmFBWmdDOFBmZjBEU21aT3NyVTdsWWwr?=
 =?utf-8?B?V1I3RnphZmpmZDBKRkxBTzQrZmY5Qjg2bDE0QmZlTkRUWDVqR1hRR0pXZ0pa?=
 =?utf-8?B?TGNBenNndWt0a3kzVXhGZk03UHRiNmZNTzhvR3I1Z1ZyU0sxcU0xbWpWZ3Fl?=
 =?utf-8?B?cWY4RDZ1aUtsSkt1VDZucGR1eHhmRW9YTTlmTEdpTkQ1ZWcyeEpJekR3ZU8v?=
 =?utf-8?B?d0hLMzdTY0JDc3ZLenhFanhRVUhRUjdLV0tnWnc5aHdYMWl5S0d5S2czUUhK?=
 =?utf-8?B?bEFiUTdxYkE2K0Y4M1JsTlNJMGZEblNLN0F3UmVCOWZxdlNyT3hPYmJKSnpt?=
 =?utf-8?B?VTNwbHVtVWlzWDJBOHlML1k5NVZCZ1V3S3F0Mllrb1YrdkdZbmo3R0Q2a3I1?=
 =?utf-8?B?WWhJbTZWT094VHJSVVBTeW15eFB0ZnpFdDhBWTBLMlhnb1pNRG8waDZHc3pF?=
 =?utf-8?B?ZzZQZlVsVTl5WnFNY05xZm8yTGF6ZGo2YVNIaUM4bm1oOVd5UXhyVXlMRytV?=
 =?utf-8?B?bTN0dmJQdnNyd2JXOHlZejlvRmE1VUh1enRWNE41NlcvZjhvS3FHM2JmQWJN?=
 =?utf-8?B?aVQwMjVTM1VnMk9CajM4NEpxRW5PNktxR3dIN3hOOVloYW1TNEVkVWhOVVl2?=
 =?utf-8?B?cnZUeXdNeFlQUHEzRHlZbjF4K1JmVWplWVZtNVZnZEtBcVFTZmF0bytHQnQr?=
 =?utf-8?B?TDcxTzNDeGU2cTJVaVprUENPQlVMWG5HY0JnVjREbGc1NStZMUdTb0NhYlI1?=
 =?utf-8?B?MGtIMXk5VE5KeUJEU09OUFdYOFhUSzVVMW5CMTNaTXhSVXJwZkpqbDJpRzZq?=
 =?utf-8?B?alNoSS96eGFibXFtVmJJOGdEWTZzQzl3K1Vqa3N6RVk4cTA2RlJpRUEvUi95?=
 =?utf-8?B?UUsyd2dTUFM2NXNUdzVoV2xYL1N3WFY1S2RyMmZuRjVreVVQYjY3NEdMMXFD?=
 =?utf-8?B?Z1E5YkJCZUxxMG9QYmpuWm40TVBUcm91R1lhMUVOZklDSjFMaWR2Rk1hMytj?=
 =?utf-8?B?L2ZkRmpFak9YV3BQU3JLWDd2ZitrS2hEYTFzSmxhVnh0enBycGRrOEc4OGV1?=
 =?utf-8?B?MzFSdVhsV1JpcFB1YXZLeDBGQTVBVVc2d0dVamVEWW9SbGxpdXE3eFE5STNx?=
 =?utf-8?B?STgzd0xPcWJNRjFqUk1EZndualhkZjh4TTVubEoxZ2U4T0NMWi9UeXlMMXNv?=
 =?utf-8?B?UTNqbVdFbm53WjZNYUZjR1lldk9adFNmSGNZWVZGbE5NMDUrTXRpcFpqTXhK?=
 =?utf-8?B?dThHcHBMRzlreWcrUlZvY05pOTVPTFhBVTUvb21RcGxYcjFxQldEa1VuUVph?=
 =?utf-8?B?VjFRWnF0OWptanpzNkNlYUpKOUovWnYvRGVKTGxWd3lucmNiajV0Z2N4cjRC?=
 =?utf-8?B?Tk83ZlFmdGVjVE5jSklJamVQaUROc0ZKTm5xTTRzZVkyNjlncmMxQ3hwNWo5?=
 =?utf-8?B?czVUNlFnRTNlU0I2VldVZmFEUzJJWlMrbjNDYkFoVVZWN3VrMXU4Sm1IWmVy?=
 =?utf-8?B?LzBnekdaditPZXZUNjRqTVBsbDhCc2h4SDlva1Q5b0gvSWNYcjhqQ2crVEsy?=
 =?utf-8?Q?L3rZbvvTrZ5fmszio4cqiTdMZnquDp6Y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3lFRkg1andUY09mUTd2RmpENjJFa1NLRlVONloyeG5rdS9QSlAxOHlXTzVs?=
 =?utf-8?B?OStFNzBjeUlNZ3QySnE3WkVYeE5yZmdjRzNEVDI5UVY2OVN4TVFyVlpsd3VV?=
 =?utf-8?B?MERNWVRCTjV4MG1XOHY0TlEyR3B0bUpMa2JWaktVRWR1MmptRHBVaEJiN2dx?=
 =?utf-8?B?MVQ1R0p0OFFCL1d2dmV4YjN6L0xNeENoS21vdXpwMGp5ZldCZVZuOHR2VWZ2?=
 =?utf-8?B?QWJqMXg0SDdlbTZCZHVzVG1CcEVUTVVhSVJrTlJyYjJja3VtS1lUT3NuMVp6?=
 =?utf-8?B?ajBYK2NlN1NOYlBVWFJWS1IwMUR4bUdiQy9IbDYxRnZFU1FvYUJuQ0VGYmcr?=
 =?utf-8?B?aHFJazFrejM5ckJHMk5pNEMzUmhwYXhYanVCSVhtRzhpZ3RlU3M0VThaOUZn?=
 =?utf-8?B?NDc5aldicHZ6THVtK3lsdzhQeHdvTXNtb01qYjJJcmNmcHFPeG5zSDB6OHVL?=
 =?utf-8?B?Q3ZER0IxMjNXV0pDMGphRyt0YjhmdmdnQjZ5dWxWa2lCOXRYQnJ3SW4vQmRz?=
 =?utf-8?B?MXMyeFdoUDA4QkRKTWUvZnFqQjcrZUdKcXZ1M3F2WElwOUVBOGFyQ2hwcldX?=
 =?utf-8?B?RjFvYS8yNFZQYkM0WERBdUllcVcyTVg1cVRwK0tyc3h5TmZKWEEyZzBrTnBG?=
 =?utf-8?B?V2lyNEZXVzRJTEJBOGxCTGNnVXdHOHlrV3plNlcrQUtLZk4wNDNBZGNYUHBG?=
 =?utf-8?B?N0prUzc0ak9RMEt3TEVyUW15QmpkbzEzb2NQUFo2VGFFaGgraHIvRGEvREVU?=
 =?utf-8?B?Y3VWeW5lM3YxSSs2R3RmYUdEZ2ZZWGZXTTVDR0kycWhGR0lVUi8wK09ER3NT?=
 =?utf-8?B?Q0NjeTNKSHVSZ2RqbXNTdTBPcFl0SmNFc3ZLTEhTWUd4MnVMNWlyVGJySTFR?=
 =?utf-8?B?bVFDM3VjTDc4eVNvN1NoTnZJdmlTRzJlTUNvNkVFQTJFa2t1L0xCOCtqU1pP?=
 =?utf-8?B?eXNTUzY3Q3ZxTlhNYUlwRXAybHJ2RkhzekJVZExmWERNRERPM3BQZGVjblcv?=
 =?utf-8?B?MytjS280QTB0RlZKYzJMb2I3dDBWSkl5SityTkhISzJ1YVoxbTZBSlNQTEo3?=
 =?utf-8?B?cmJPVmdjczNPeXkxd3U1Qk82allqOWV3Y1psQm53MXJ5R1FxWDd6WEtJY2JD?=
 =?utf-8?B?VlJRWHVneFR5OUo3Nm1DVG8xRUJzaE5tNnpNTkU1aHBHTHBQOWFKY28xVTVv?=
 =?utf-8?B?SnZTYWhnUEhmL09EaFlJdm5DQkVrVlp3ZmZURFp0b0tEZFhLT0o2bTVwekwv?=
 =?utf-8?B?ZW5JeEMrdTVFazdSRVFjREljTko3THFWRVFQNG9uenVMY0RRczRzcUoxSjE4?=
 =?utf-8?B?OUNMZlFpV2xrYWNoVFFWd0dSbTVDdmdreENMb1hBcnVZNitieEVOekc2NzlP?=
 =?utf-8?B?eVBnaTVDOVhMK2JjaWVHdWJNODZIWEtTVHZnYytRSERSZG83ZDQ4ZHd2VE5J?=
 =?utf-8?B?U3NxOTVPZjcyUGM5eFpyaXN5K2h1REViQm54aUR5aTRvbW50dDBFUXlOVkcr?=
 =?utf-8?B?N2dkMklNUnlER1BQMHY2SlJCYnpBMXMwM0E1dGlFTm93eG1VQVBicTVxVUpV?=
 =?utf-8?B?a1pIeVJEYW5oSzE5VFNTNmRuS0FzeHBST24rZTBzUzdoMGh5TE1TS1hNQWhj?=
 =?utf-8?B?RTRvQm5Uam5GWEpsMjRuQ3hZNnpxS0VzeEJKRkhKY0lIK2srcSsrNHZYRjhR?=
 =?utf-8?B?c2R0OFdDdm9BQjdsZlNNc3I1dDFQYTVtaWw1SzBXcXlVN3dwRjM3c0p2UzJM?=
 =?utf-8?B?K05qdFo0VmJRKzRLR2U0bE93ZncyT3BwcGpTelFjZzBqTFRqWTFjMktCY1Ro?=
 =?utf-8?B?dGpacDlOSHI0cVVoVzNhcm5TVnhFNTVxOUMrakViM1ZwWjlRcVBwQXZ2UHVa?=
 =?utf-8?B?ZkkzNzZTTGd0dmFGUUI4MU1JZUpQQ3p6anJ5dm1oVFhQZWZaUUkrRG16Y1Ji?=
 =?utf-8?B?RHUyY1ZqeCtmMGNudGpwVXlrZzM4OVJDR2xzbm5DcE1UYjdOeWNWYlNqTVVa?=
 =?utf-8?B?ZUtyNldQRDZUSzlsVktsdmREZ0RyalZpRW1MREpmUXk1bHpkWUFpa1dMTjY1?=
 =?utf-8?B?Z3FRejhzV2xVUDRPZ1MzZ0FucUR1VFNNeGJKK205TkhYNlo5a2MzK2k2cjFw?=
 =?utf-8?B?anQyNUc3eEFsOHhiYTdqcUxtT1RNL1UxcWpuZ21QV0tYK0JQbloxcHBnOEJx?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C89DFDEFD7CAB4B8A5542DC5C490A68@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 061a2f9b-a58c-43e8-ae83-08dd1b5248b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 08:43:57.7099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqUne15fZZsqgCtZGIjbIIAZdMT1v4v+ZOsaaOHsjuZQ94FxBxdEySqnL3nRaT7MXDPT6rgCEoFopoFxNimPog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7855

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIGEgbmV3IGRyaXZlciBmb3IgdGhlIEhETUkgVFggdjIgSVAsDQo+IHNwbGl0IG91
dCB0aGUgZnVuY3Rpb25zIHRoYXQgd2lsbCBiZSBjb21tb24gYmV0d2VlbiB0aGUgYWxyZWFkeQ0K
PiBwcmVzZW50IG10a19oZG1pICh2MSkgZHJpdmVyIGFuZCB0aGUgbmV3IG9uZS4NCj4gDQo+IFNp
bmNlIHRoZSBwcm9iZSBmbG93IGZvciBib3RoIGRyaXZlcnMgaXMgOTAlIHNpbWlsYXIsIGFkZCBh
IGNvbW1vbg0KPiBwcm9iZSBmdW5jdGlvbiB0aGF0IHdpbGwgYmUgY2FsbGVkIGZyb20gZWFjaCBk
cml2ZXIncyAucHJvYmUoKQ0KPiBjYWxsYmFjaywgYXZvaWRpbmcgbG90cyBvZiBjb2RlIGR1cGxp
Y2F0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlw
XQ0KDQo+ICtzdGF0aWMgaW50IG10a19oZG1pX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG10a19oZG1pICpoZG1pOw0KPiANCj4gLSAg
ICAgICByZXQgPSBtdGtfaGRtaV9jbGtfZW5hYmxlX2F1ZGlvKGhkbWkpOw0KPiAtICAgICAgIGlm
IChyZXQpIHsNCj4gLSAgICAgICAgICAgICAgIGRybV9icmlkZ2VfcmVtb3ZlKCZoZG1pLT5icmlk
Z2UpOw0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRmFpbGVkIHRvIGVuYWJsZSBh
dWRpbyBjbG9ja3NcbiIpOw0KPiAtICAgICAgIH0NCj4gKyAgICAgICBoZG1pID0gbXRrX2hkbWlf
Y29tbW9uX3Byb2JlKHBkZXYpOw0KPiArICAgICAgIGlmIChJU19FUlIoaGRtaSkpDQo+ICsgICAg
ICAgICAgICAgICByZXR1cm4gUFRSX0VSUihoZG1pKTsNCg0KSW4gb3JpZ2luYWwgdjEgZHJpdmVy
LCB1cGRhdGVfcGx1Z2dlZF9zdGF0dXNfbG9jayBpcyBpbml0IGluIHByb2JlLg0KSSBjYW4gbm90
IGZpbmQgdGhlIGluaXQgaW4gdGhpcyBwYXRjaC4NCkl0J3MgYmV0dGVyIHRoYXQgbW92aW5nIGNv
bW1vbiBjb2RlIHNlbGRvbSBjaGFuZ2UgdGhlIG9yZGVyIGluIGEgZnVuY3Rpb24sDQpzbyB5b3Ug
Y291bGQgZWFzaWx5IHRvIGNvbXBhcmUgdGhhdCBtb3ZpbmcgZG9lcyBub3QgY2hhbmdlIGFueSB0
aGluZy4NCkluIHRoaXMgcGF0Y2gsIHlvdSBub3Qgb25seSBtb3ZpbmcgY29kZSwgYnV0IGFsc28g
Y2hhbmdlIHRoZSBvcmRlciBpbiBhIGZ1bmN0aW9uLA0Kc28gaXQncyBub3QgZWFzeSB0byBmaW5k
IHNvbWV0aGluZyBsb3N0Lg0KDQpUaGF0J3Mgd2h5IEkgbGlrZSB5b3UgdG8gc2VwYXJhdGUgdGhp
cyBwYXRjaCBpbnRvIHR3byBwYXRjaGVzLiBPbmUgaXMgYWRkaW5nIHZlcnNpb24gY29uZmlnIGFu
ZCB0aGUgb3RoZXIgb25lIGlzIG1vdmluZyBjb21tb24gY29kZS4NCldoZW4gSSByZXZpZXcgdGhl
IG1vdmluZyBjb21tb24gY29kZSBwYXJ0LCBJIHdvdWxkIGxpa2UgYSBmdW5jdGlvbiBiZWZvcmUg
bW92aW5nIGlzIGFsbW9zdCBzYW1lIGFzIGFmdGVyIG1vdmluZywNCnNvIGl0J3MgZWFzeSB0byBm
aW5kIG91dCBzb21ldGhpbmcgbG9zdC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IC0gICAgICAg
cmV0dXJuIDA7DQo+ICsgICAgICAgcmV0dXJuIG10a19oZG1pX2Nsa19lbmFibGVfYXVkaW8oaGRt
aSk7DQo+ICB9DQo+IA0KDQpbc25pcF0NCg0KPiArc3RydWN0IG10a19oZG1pICptdGtfaGRtaV9j
b21tb25fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gK3sNCj4gKyAgICAg
ICBjb25zdCBzdHJ1Y3QgbXRrX2hkbWlfdmVyX2NvbmYgKnZlcl9jb25mOw0KPiArICAgICAgIHN0
cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ICsgICAgICAgc3RydWN0IG10a19oZG1p
ICpoZG1pOw0KPiArICAgICAgIGludCByZXQ7DQo+ICsNCj4gKyAgICAgICBoZG1pID0gZGV2bV9r
emFsbG9jKCZwZGV2LT5kZXYsIHNpemVvZigqaGRtaSksIEdGUF9LRVJORUwpOw0KPiArICAgICAg
IGlmICghaGRtaSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0K
PiArDQo+ICsgICAgICAgaGRtaS0+ZGV2ID0gZGV2Ow0KPiArICAgICAgIGhkbWktPmNvbmYgPSBv
Zl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4gKyAgICAgICB2ZXJfY29uZiA9IGhkbWkt
PmNvbmYtPnZlcl9jb25mOw0KPiArDQo+ICsgICAgICAgaGRtaS0+Y2xrID0gZGV2bV9rY2FsbG9j
KGRldiwgdmVyX2NvbmYtPm51bV9jbG9ja3MsIHNpemVvZigqaGRtaS0+Y2xrKSwgR0ZQX0tFUk5F
TCk7DQo+ICsgICAgICAgaWYgKCFoZG1pLT5jbGspDQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
RVJSX1BUUigtRU5PTUVNKTsNCj4gKw0KPiArICAgICAgIGhkbWktPnBoeSA9IGRldm1fcGh5X2dl
dChkZXYsICJoZG1pIik7DQo+ICsgICAgICAgaWYgKElTX0VSUihoZG1pLT5waHkpKQ0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfY2FzdF9wcm9iZShkZXYsIGhkbWktPnBoeSwgIkZh
aWxlZCB0byBnZXQgSERNSSBQSFlcbiIpOw0KPiArDQo+ICsgICAgICAgcmV0ID0gbXRrX2hkbWlf
ZHRfcGFyc2VfcGRhdGEoaGRtaSwgcGRldiwgdmVyX2NvbmYtPm10a19oZG1pX2Nsb2NrX25hbWVz
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZlcl9jb25mLT5udW1f
Y2xvY2tzKTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIEVS
Ul9QVFIocmV0KTsNCj4gKw0KPiArICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGhk
bWkpOw0KPiArDQo+ICsgICAgICAgcmV0ID0gbXRrX2hkbWlfcmVnaXN0ZXJfYXVkaW9fZHJpdmVy
KGRldik7DQo+ICsgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZf
ZXJyX3B0cl9wcm9iZShkZXYsIHJldCwgIkNhbm5vdCByZWdpc3RlciBIRE1JIEF1ZGlvIGRyaXZl
clxuIik7DQo+ICsNCj4gKyAgICAgICBoZG1pLT5icmlkZ2UuZnVuY3MgPSB2ZXJfY29uZi0+YnJp
ZGdlX2Z1bmNzOw0KPiArICAgICAgIGhkbWktPmJyaWRnZS5vcHMgPSBEUk1fQlJJREdFX09QX0RF
VEVDVCB8IERSTV9CUklER0VfT1BfRURJRCB8IERSTV9CUklER0VfT1BfSFBEOw0KPiArICAgICAg
IGhkbWktPmJyaWRnZS50eXBlID0gRFJNX01PREVfQ09OTkVDVE9SX0hETUlBOw0KPiArICAgICAg
IGhkbWktPmJyaWRnZS5vZl9ub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQo+ICsNCj4gKyAgICAg
ICByZXQgPSBkZXZtX2RybV9icmlkZ2VfYWRkKGRldiwgJmhkbWktPmJyaWRnZSk7DQo+ICsgICAg
ICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3B0cl9wcm9iZShk
ZXYsIHJldCwgIkZhaWxlZCB0byBhZGQgYnJpZGdlXG4iKTsNCj4gKw0KPiArICAgICAgIHJldHVy
biBoZG1pOw0KPiArfQ0KPiArDQoNCg0K

