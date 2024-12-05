Return-Path: <linux-kernel+bounces-432685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 891739E4EBA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527C21881A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2191B2194;
	Thu,  5 Dec 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="M5bAffNj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qGYFJxQ+"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E821B219E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733384062; cv=fail; b=Axc/JrqGAwymhaMScSjcsZMlT0TPH2TA1SmKp/Uunsw0wXoifAKQhT1Fp3wx3ITaJiumCgd18OT02RBq/OZUVFFf3JTBhRX5lkuhHzGjISbGZ0qgz0NDGM5QKmmLPPch2b39b0Qxa0ybaQShN3++7IkEdPQBh7giXPIMQtYhU7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733384062; c=relaxed/simple;
	bh=J/pGHpdQMBWU1Fuqaiuf7ChtAFmtNV9HtwChaEF3ff4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qg4Zf3SyP0M8F3bKlpVfF1zL3nTTMVffV/O14d6s1IhDhO0h/jnv830pWn7WEqsoNqN2AWy2qk00yeeo3z+YJYgxzFJoRUygn+OCJtq7QOqWeO7ii1xROxGP/xKHG1vkjj2wxadf4yKxZot7T9xegf0sD5jygfjGQF02Dd0Sgpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=M5bAffNj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qGYFJxQ+; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 53ae7aa4b2db11efbd192953cf12861f-20241205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=J/pGHpdQMBWU1Fuqaiuf7ChtAFmtNV9HtwChaEF3ff4=;
	b=M5bAffNjuXBtjgqMAodA5L0pXOS5bSA4kRBruIvQ6TJOenTkBw4YQXjfiDviTOy+vQKzr6dCoWISCvb8jMyLfLH+/QIbrXW0RyS4tIiacgGZNI4K7WD+VZbTRiI+CwkfqvbkQRdmMwKzL7WYdWfa3UZxT6Mmchsh9gqGCdR5VkY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f6bb9afc-c9d3-4dbd-a93c-fd2bf72a737c,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:1cb8f7f5-e524-4511-b681-7d630745cb54,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 53ae7aa4b2db11efbd192953cf12861f-20241205
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1098757677; Thu, 05 Dec 2024 15:34:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Dec 2024 15:34:11 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Dec 2024 15:34:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhzsKsbbY76Q1d1KtOaVRJkM5kjMAB9FEJxEKjGMMY2yqGsZh8wr0Cg4AZWKYFtshciYUFRxlD/zQAEzBHEechKpjpqeWR8DEoMOdvBOWIBee+ocQNVcRXWGTtMJIBUecULnsQEMUPkivo191opAyxVDqymP7Ucy5DoKXAAUGXv1UMhNsiiOrGLHNAv4TbCLXiKdAznVQoDINFXxHVFWaoh8akUhaXsDanlMyyTNSNLBBqK0+ViHWGzt1W4fsSEB6J49c1+I3AwCQ4lwKnZ2DjXjmt8Sy2rRDsaiQFT0fFvI4royzLjkXHF+FUyz/pAM8hKcqmFfLdYaAP8F3+IbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/pGHpdQMBWU1Fuqaiuf7ChtAFmtNV9HtwChaEF3ff4=;
 b=Qjp37aNnOb0AgwGuzX/1etDjb68hQ70K/xq4gx+HvNkadjQlfY1xc2E3g4iHqAveDssg0e3MtkHzveKY8u0Y8kWmN+sSTMojpIuJmvmNjmq6M36NEQKpXNN31rJ/teQGovh4TRSpvoSYphvIOZZ5bXhi9OR0tvQB9nOQkFs95Y5+OYqfpSctm/9wRBrSSoAd/l0/BICsr7ZvAEl/Xy7jKVg5XLXhcY8K+LxZvhQOVz3yoZDR8ZQB2Xt29336tXESDA4e/eoHOJfBqpVQQuAHHHV90Y3wuKhXuUaG6onF23bk0vXQ7sTCGP9/fcC2VOOmXv1Cy0CEyAvVDGPFaVGaow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/pGHpdQMBWU1Fuqaiuf7ChtAFmtNV9HtwChaEF3ff4=;
 b=qGYFJxQ+UUTDwwBn3xrOMZEskwmoyNMjkwusC1OD6tzZoUlwTj023HZexHQtKyHcDea/9MzeAvvHGRwFMozOhEs0Wz1s2nx5wpULC2YiIePlWhE9wSEkZdJGplhr8JyhQ//ySI9Pw0IOpegn9BX8xrRcT7FSDDvf0lbe37QNxAs=
Received: from KL1PR03MB5861.apcprd03.prod.outlook.com (2603:1096:820:92::6)
 by SEZPR03MB8315.apcprd03.prod.outlook.com (2603:1096:101:197::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 07:34:08 +0000
Received: from KL1PR03MB5861.apcprd03.prod.outlook.com
 ([fe80::db90:295a:45d0:8831]) by KL1PR03MB5861.apcprd03.prod.outlook.com
 ([fe80::db90:295a:45d0:8831%2]) with mapi id 15.20.8230.008; Thu, 5 Dec 2024
 07:34:08 +0000
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
Thread-Index: AQHbKmxKqyxLtS50ckyGmVfpOQ/CsrLXbu2AgAAMXQA=
Date: Thu, 5 Dec 2024 07:34:08 +0000
Message-ID: <94480dcb145fba89c41045cde374e1dd71a1e6af.camel@mediatek.com>
References: <20241030013533.855696-1-karl.li@mediatek.com>
	 <20241030013533.855696-2-karl.li@mediatek.com>
	 <b8de718de8d5b5357f67183c1d283180aff33f62.camel@mediatek.com>
In-Reply-To: <b8de718de8d5b5357f67183c1d283180aff33f62.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5861:EE_|SEZPR03MB8315:EE_
x-ms-office365-filtering-correlation-id: d1f6f6ff-1a4b-4361-2825-08dd14ff34a4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?U1Y3VnZNZis0VGdBZkJvbldHM0l4VWJhcUZ0ZnFHOExCU24wNHdtcy9DQ0hV?=
 =?utf-8?B?bGhNRThHaENWWTFsbVZaUVlEcDVmZnkxTWhzZUc0WEdxcXdWdnYraVVDd2RN?=
 =?utf-8?B?REE5QzlPaU5yOWxhTzc4TmdOMjVlM0tBNGdkZkpSWWk1dkw1M3dIM0NwbnJj?=
 =?utf-8?B?em1IdU9WL1NHUnh2LzhPQVB0SXBielhzR1I2VWVDVi9pcGxnOWp1b0pBS1N5?=
 =?utf-8?B?UVJXT0s1QkhiMFVRNmZCZStnNFlabjRKNHk1Q1Z5TnFJa2hGMjNiVktLYmVP?=
 =?utf-8?B?c1kwTmxDdy9CN2pOVXlBL01tSUxnQzMyVzlaNk1xaDdtanlFRTJ3WG1UZHVr?=
 =?utf-8?B?KzlqdGliTEZuZGRoZWhGMmRKYzdmQkY0UUlEY1Y5dEt4My81aTQzR0l4Q1Mx?=
 =?utf-8?B?ZGd0NVFWckI5ZWh2ejlRbHh2VFlXWVpjVkpTTjN6aU5kdHlwMUdsa2YrMjNV?=
 =?utf-8?B?RTFXY2RjYmZLQ3dwU2lKWEgvV0pXQTZaMzhaNFZWM09VSmU4Qk5NcE8zVG82?=
 =?utf-8?B?eVFKOFU2V2ZPZWlMaFVRRlZTaVhsQnJwcHB4clhLTUgvWXhQVDFDYkwxTnVj?=
 =?utf-8?B?OXlnVlVLMzBTbmlpTjE2Y0FLQ3VjcXB6ZGZ4d29NdVlDa1Joa2J5b1ZGWXJB?=
 =?utf-8?B?WnB6RC9GZ1E1d01kclR3ZnNQNjd4amdqYkZ5Nkg3d3NUelF1TzR4UHBBcW1M?=
 =?utf-8?B?T0dCbGtpVWRnR1gyd243bE85NC93Y3EveUE1Ky9YL1plTzBnUUNDUUJMZFBQ?=
 =?utf-8?B?UDMvK2RCUnlJcHJMQUdlUVNyaWdXVzltbVgvRURIcE8vUDU4bkcvc0crZVls?=
 =?utf-8?B?K3lkWmtPYlAwQ1VHQk1HSUZtRVB3ZW9WZlg0Qms1VDFYQittSFNrTWtLeDhD?=
 =?utf-8?B?cy9CMTdjQTNoUnJxUXlkcFhyRzI4S1l0YnYrME1tdEtPSmhRWndNV1lIb0h5?=
 =?utf-8?B?ak1qaFVVZWg2YmREMDVXYUdMMWFPZnZrZUNVOEFDOThZVGZZaXplMFZNVC9v?=
 =?utf-8?B?MjRDd3NsTFVOYTJqTDZ3TUZ2aThxdkYvdjNXd1V4b3VLMENTQ09vTjFaWmpn?=
 =?utf-8?B?YlBUQjNCcHEyWFVlQWxYUkRqMmRFbE5pUUJiakZDMm50TklIRGEwZ1JmRUd3?=
 =?utf-8?B?RjFOMzZmUWMvbUk3UTJQUEFFbGdORUhHdHgydjlFSHpmR2xJKyswTlFzd0JN?=
 =?utf-8?B?Y1Vmd2h3eTZDMy9tL0hMU0l3Y1NhSVVHN3F4UGRBblhmNkxpekZQd1BSeTh3?=
 =?utf-8?B?alBmTmhrV0tVdlNma0xrREp0R1ZieVppMEQ1TnBhTG9qeVNaRitzaUc0U2s0?=
 =?utf-8?B?Z01TenVYZ1U1L3JuWXlqc2YreXgzTGtQTXQ1REpFeW5MbVgwU2pqNHRkQ2Va?=
 =?utf-8?B?bEhSOVFESTdLd0F4NStZYmt5ZExnU0o4bHU1YkRwazA5K2JDSnJtS0JQV0tX?=
 =?utf-8?B?TlY2emZRYWVXRko2czZMM1F4UnBLVnRqYXpFTmNSVUdDckhWMkdXalc2UTZJ?=
 =?utf-8?B?ZFdYdzJxZWNVRnp2cG03TkorejhVbmI4emtGV01GU1pvMXZhY0JiOWlDZmwx?=
 =?utf-8?B?dXIrbXpzTTU4MlFvNlEwSGZrUGxNeFFiZitJSk9BRzNNRHM1cnVEekw1a0Zv?=
 =?utf-8?B?bUsyWDU2bnIxc0taZVRxckl3QjBHR0R2bU9XdFh1NytTSkN2cWlYQld4ZWNB?=
 =?utf-8?B?SnFZdHZvci9Ka24rT1FlaHdYY08zVXgwWDhhZlR4enZvNk5YRWdxZ3d5bUpT?=
 =?utf-8?B?ZnU2TjZ3cVh1V1h1WTZEYzNQUHlvTTJYMFJvWlhtaDltT3Jxbk9ZL3VZME5P?=
 =?utf-8?B?MVZONkhwNVZNa3doY29SYW4yZEhmektjT2FWUUVjNXc1WXNZN1p2NUJZMDQ1?=
 =?utf-8?B?eWpHNXZlbVRrZTQ4TVNiUWhzS0JrM3JDQ0RxZ25kSDJzTEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5861.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTR2NzhNTGdmV0NkSUJCaUxXUDNRT0RxVkVrMTJ4UmNPSTh4c1hpOENOZkxG?=
 =?utf-8?B?cGtTU0dhNVdiZS9NRVBtL3MrWEgxUmpxeE8vOStJcWdWRWFGRm5RbFB2SVFY?=
 =?utf-8?B?ZHdWVnQ4L1UzcEUxTUgwc0pLZUczazA1Q0pDZGdHMlRwcWdBaCtmOURVVFNm?=
 =?utf-8?B?TUpYM1drWUVhSTM2OE5BN0tURERrT0tUbXdWb280eGQvaVo0VWtaYlJJNFdl?=
 =?utf-8?B?TStHL3RrMU1lZXZXZlpvV1FSa0k1RDdXcEpJUjMrNlZlbjVTbS95VnZiWkJF?=
 =?utf-8?B?ckpzUFhidVkwcW9ZWWlMWWswQS9RVnllVTJ2eDhzam15bHBoNDRiREdBL2VT?=
 =?utf-8?B?TENOODl6S2kzSFBIYzY0YU82MGpXVWNxUWhuamJQdWtFUXRXM3lzc2Y1aTNk?=
 =?utf-8?B?MTZXTjRaZkcxVkplNGtjZnRlVlhYK3U4SGdWQ1pOZmRydGF1RmVFdGc0WEZ6?=
 =?utf-8?B?SVZPYVRVbWE2N0xOMnBSWVZqYVNUcnIyUzd2VTlid3lGQXU1Rk1ZeWlpRFZs?=
 =?utf-8?B?cDRjdXQrckpqYys0MHFFUFVPQ0crQXZIb0xhbjI0bEdwYUMvb2VzVFU2R01J?=
 =?utf-8?B?aitmMW53Vm8wTnZYcy9Fdkd3UGE4UTZBMzJCUGliRGF4MmN6R3Z5Tjl3UXBH?=
 =?utf-8?B?NDJSeEJVUUhZd3NVZURDTGJvNE1RY2VOZ3ZvTDNUUGFuT1hmSzBZWkZndHd4?=
 =?utf-8?B?TmpGd0p2Y01uOVE0bFJ3QW1TT0FoV2Q2ck41ZTRxaFlUSGk0dkdGNThwaG5p?=
 =?utf-8?B?N28vRU5ISk83Y3RYUVVjWnJHUUczMnEycFR0S0pNdm84NHl3QzM1NEVDZHBo?=
 =?utf-8?B?L1RuLzQrRXlpZHFZakpWNzN0VTd0L1JRVVVRclZUeC8vTTV0UStOTllCMFc5?=
 =?utf-8?B?VW9ia3ZmV2lrRGJWZ1pibDlFYVZEd0pvOFFoQ0lRWHF1RU52a2RqY1NKVUxW?=
 =?utf-8?B?TjBMenozTG43OS9IclplOUxLcTFYZ0dVenpGenlXYU04eUhqaktQZ1EzZEd6?=
 =?utf-8?B?a3AvVnk3Zk0zQkl2WUNLVWt6T3VNM29UUG1QcXIzVldyUEFpdGVkWUN1TkQy?=
 =?utf-8?B?c3g0K1U0dDd3bmN4WW5xdlBnYmJ2RWY2M2ZYL0lVVEtpMXBDTmpYVGNoUlFv?=
 =?utf-8?B?VDBNd2ZkYW5Sb2VrYlA2WWZFU3c3QVY1NW1pZ3YvWHFzZXF2ZjRsSEQzVTI3?=
 =?utf-8?B?UTZ2bE5zNkwvejdVUWdUZVdKT3JxSlNwYnRDUnFWb0t4OWZFRmhFc2RSSy9F?=
 =?utf-8?B?ditMWkh0R3JoM1ZWc3VpemVBSHJFelZBSE9PLzcyZDFIZGh5algrMkNiQ1dY?=
 =?utf-8?B?YjNNWVhLTi9NclVSM254Tm5CbmprUnJxNjdMVlJVWHcyS3o1eUVoY2ZnVm5i?=
 =?utf-8?B?eHFibWRXNlJwK094TjFMZllOUHB3Y1VtaFVZZHo4NXdiUHJIZDJNSXlYOGJU?=
 =?utf-8?B?eUhpeGI2a1A0TWhiTjdIK0UvRTlKL2l4VlFFaCtUb1RuUStjZGYyMUQwWXNZ?=
 =?utf-8?B?YVRnY0h2L1N0YUk1SmVIOWMzRlVybjdkeVhqeXBNTnZaNUI4VlR2NDhUeEYv?=
 =?utf-8?B?OWR2TXFIRmtzNy9JMTRESThmZWlWZmdoSkFNQS9PZUZVSXN2VW9QM1hxZERJ?=
 =?utf-8?B?ZzdFdHFLNGY0NTM2dVlFcnpUdFd0TUpvMUs4ZFJsc1AwVElyK3czRHVwSmRz?=
 =?utf-8?B?U2VKSHh0K3BQWEQ5aEdKc2dyanozUHg1cnNWczAwS25sNTl3bzdwRldkMkZa?=
 =?utf-8?B?KysyejVIdlhLYS9MMWVPbmtBSTJhWUV3OUdNZUIvWjRWV05GT0xNUUkyd0tl?=
 =?utf-8?B?dDUwSVBqbjhhR3dyYVdsR1BpcVF1Q0c2eTBuNnJ6U0RkRk9LbXJoU09HenAz?=
 =?utf-8?B?QitjZU1qa3NYZSsyY0FtVzZaT2tJU2t3SjhXNlJKYWd2bVMxUTk5Y2JEUE0x?=
 =?utf-8?B?UmVudERYTU45c1BCMkZCUWpQbWZyam1hSk4ycmkyQmxLai9QVXRtTUorN0FK?=
 =?utf-8?B?T25ucmRhQ245MWlvd2tIQk5UR3FpR1JCOTJLZWw3ZGlUekk3c1NUVzhnRHBY?=
 =?utf-8?B?MTdRK2kyV3NMckNGa1NocktQMUIweE5PWFIvWGh1WmQvdGxDN1V0dUFzTzRR?=
 =?utf-8?B?MDhDNDJjSkgzcFZhdGxKemdGTFZlZkJEbEVLMXBjZmNIdW1EbTBvWGNkeVFY?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EA952056BF6814E9B68AA3B3924E39F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5861.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f6f6ff-1a4b-4361-2825-08dd14ff34a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 07:34:08.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 18n7RCxh1ZqOVMRJTup/c19rlrrpEhkvbcLPSxPE2j1OonvOn8DNzYQH0t3tLmMXQ+vaazRgb6A3a1QUvdM6Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8315
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.365800-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4jYTypjB3iDVjLOy13Cgb4/n0eNPmPPe5H0N
	vE+7HpScni9BHs7QTk3p2UbXSgw3I+xC82MtS3V5qJSK+HSPY+8CXDWUkMEy1sDyFv55sQyoTHB
	hhRXBeAsk/TQmrPGEgGuQ7Ro4lHrcRpYY54qZBhAbmaDSnOqZfuj86Ng8AayKnp9KgXcu34xqrA
	ihoh2+kS0hw0Iv7WVPsvQLAMZPkyUAMBiAKN0oWxlckvO1m+JcX6IRwqkp2m68NrbzjPvzJ3WPj
	hlgTD/hymye0fT8BqL/x1ZWXc8q3XkXYHF7PdsXngIgpj8eDcDBa6VG2+9jFNZE3xJMmmXc+gtH
	j7OwNO2BSJy8ngwKGbd9zIhHaV+7+KHatTmUH/YP4QfNHfRkcOrMC75re7LITEZhajF/mms=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.365800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E0A0F2FE2951BA2895D46A2C209A52899F23DD6E6DEC8BEE3BA0D52FFF199B352000:8

T24gVGh1LCAyMDI0LTEyLTA1IGF0IDE0OjQ5ICswODAwLCBLYXJsIExpIHdyb3RlOg0KPiBEZWFk
IG1haW50YWluZXJzLA0KIkRlYXIiIG1haW50YWluZXJzLiBSZWFsbHkgc29ycnkgZm9yIHRoZSB0
eXBvLi4uDQo+IA0KPiBJIGhvcGUgeW91J3JlIGRvaW5nIHdlbGwuIEp1c3QgYSB3YXJtIHJlbWlu
ZGVyIHRoYXQgd2UncmUgZm9sbG93aW5nDQo+IHVwDQo+IG9uIHRoaXMgcGF0Y2ggYW5kIHJlYWxs
eSBhcHByZWNpYXRlIGFueSBmZWVkYmFjayB5b3UgbWlnaHQgaGF2ZS4NCj4gDQo+IFRoYW5rcyB5
b3UgaW4gYWR2YW5jZSBmb3IgeW91ciByZXZpZXcuDQo+IA0KPiBSZWdhcmRzLA0KPiBLYXJsDQo+
IA0KPiBPbiBXZWQsIDIwMjQtMTAtMzAgYXQgMDk6MzUgKzA4MDAsIEthcmwuTGkgd3JvdGU6DQo+
ID4gRnJvbTogS2FybCBMaSA8a2FybC5saUBtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gQWRkIGNv
bW1hbmQgZm9yIEFQVSBTTUMgY2FsbC4NCj4gPiBUaGUgQVBVIG1pY3JvcHJvY2VzcydzIHN0YXJ0
IGFuZCBzdG9wIHNlcXVlbmNlIHdpbGwgcHJvY2VzcyBpbiBBVEYuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogS2FybCBMaSA8a2FybC5saUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gwqBp
bmNsdWRlL2xpbnV4L2Zpcm13YXJlL21lZGlhdGVrL210ay1hcHUuaCB8IDMyDQo+ID4gKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCsp
DQo+ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9maXJtd2FyZS9tZWRpYXRl
ay9tdGstYXB1LmgNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maXJtd2Fy
ZS9tZWRpYXRlay9tdGstYXB1LmgNCj4gPiBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvbWVkaWF0
ZWsvbXRrLWFwdS5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAw
MDAwMDAuLmEzMjdlMzFkNDBmYQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L2Zpcm13YXJlL21lZGlhdGVrL210ay1hcHUuaA0KPiA+IEBAIC0wLDAgKzEsMzIgQEAN
Cj4gPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiArLyoNCj4g
PiArICogQ29weXJpZ2h0IChjKSAyMDI0IE1lZGlhVGVrIEluYy4NCj4gPiArICovDQo+ID4gKw0K
PiA+ICsjaWZuZGVmIF9fTUVESUFURUtfQVBVX0hfXw0KPiA+ICsjZGVmaW5lIF9fTUVESUFURUtf
QVBVX0hfXw0KPiA+ICsNCj4gPiArZW51bSBtdGtfYXB1c3lzX2tlcm5lbF9vcCB7DQo+ID4gKwlN
VEtfQVBVU1lTX0tFUk5FTF9PUF9BUFVTWVNfUFdSX1RPUF9PTiwJCQ0KPiA+IAkvKsKgIDAgKi8N
Cj4gPiArCU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19QV1JfVE9QX09GRiwJCS8qDQo+ID4g
wqANCj4gPiAxICovDQo+ID4gKwlNVEtfQVBVU1lTX0tFUk5FTF9PUF9BUFVTWVNfUlZfU0VUVVBf
UkVWSVNFUiwJCS8qDQo+ID4gwqANCj4gPiAyICovDQo+ID4gKwlNVEtfQVBVU1lTX0tFUk5FTF9P
UF9BUFVTWVNfUlZfUkVTRVRfTVAsCQkvKg0KPiA+IMKgDQo+ID4gMyAqLw0KPiA+ICsJTVRLX0FQ
VVNZU19LRVJORUxfT1BfQVBVU1lTX1JWX1NFVFVQX0JPT1QsCQkvKg0KPiA+IMKgDQo+ID4gNCAq
Lw0KPiA+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX1JWX1NUQVJUX01QLAkJLyoNCj4g
PiDCoA0KPiA+IDUgKi8NCj4gPiArCU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19SVl9TVE9Q
X01QLAkJDQo+ID4gCS8qwqAgNiAqLw0KPiA+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfREVWQVBD
X0lOSVRfUkNYLAkJCS8qDQo+ID4gwqANCj4gPiA3ICovDQo+ID4gKwlNVEtfQVBVU1lTX0tFUk5F
TF9PUF9BUFVTWVNfUlZfU0VUVVBfU0VDX01FTSwJCS8qDQo+ID4gwqANCj4gPiA4ICovDQo+ID4g
KwlNVEtfQVBVU1lTX0tFUk5FTF9PUF9BUFVTWVNfUlZfRElTQUJMRV9XRFRfSVNSLAkNCj4gPiAJ
LyrCoCA5ICovDQo+ID4gKwlNVEtfQVBVU1lTX0tFUk5FTF9PUF9BUFVTWVNfUlZfQ0xFQVJfV0RU
X0lTUiwJCS8qDQo+ID4gMTAgKi8NCj4gPiArCU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19S
Vl9DR19HQVRJTkcsCQkvKg0KPiA+IDExICovDQo+ID4gKwlNVEtfQVBVU1lTX0tFUk5FTF9PUF9B
UFVTWVNfUlZfQ0dfVU5HQVRJTkcsCQkvKg0KPiA+IDEyICovDQo+ID4gKwlNVEtfQVBVU1lTX0tF
Uk5FTF9PUF9BUFVTWVNfUlZfU0VUVVBfQVBVTU1VLAkJLyoNCj4gPiAxMyAqLw0KPiA+ICsJTVRL
X0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX0xPR1RPUF9SRUdfRFVNUCwJCS8qDQo+ID4gMTQgKi8N
Cj4gPiArCU1US19BUFVTWVNfS0VSTkVMX09QX0FQVVNZU19MT0dUT1BfUkVHX1dSSVRFLAkJLyoN
Cj4gPiAxNSAqLw0KPiA+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX0xPR1RPUF9SRUdf
VzFDLAkJLyoNCj4gPiAxNiAqLw0KPiA+ICsJTVRLX0FQVVNZU19LRVJORUxfT1BfQVBVU1lTX0NP
TERfQk9PVF9DTFJfTUJPWF9EVU1NWSwJLyoNCj4gPiAxNyAqLw0KPiA+ICsJTVRLX0FQVVNZU19L
RVJORUxfT1BfQVBVU1lTX1NFVFVQX0NFX0JJTiwJCS8qDQo+ID4gMTggKi8NCj4gPiArCU1US19B
UFVTWVNfS0VSTkVMX09QX05VTSwNCj4gPiArfTsNCj4gPiArDQo+ID4gKyNlbmRpZg0KPiANCg0K

