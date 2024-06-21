Return-Path: <linux-kernel+bounces-223792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F90911836
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 03:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D0D1F23400
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809EC82C6C;
	Fri, 21 Jun 2024 01:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mbofLMAT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QN8+HswJ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EAA2904
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718934760; cv=fail; b=PGfJs4x5G2Ha0+WD+LzeS3DYCKvMQObtfzbUex0PliATFGg1HpoUXII3v3N7ytIF1C4v2QCQmhaExtOggVd5C60gS0Vtr+Pt1gm19+AxbN6XcA+CiT0jZPemkhFyVYSA2W6l8zGYOVF8eHUmTOCGsKTFnDoUBJlDhYW+gXAXuRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718934760; c=relaxed/simple;
	bh=uCGfI/pVf11MH4N3xAca3wZw0Q4mRPxOzdPfY2VYMLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U1Lux5Wc3zjBFNGjKQNLRMqaQZg3dKDBeagzzNVgFsg0PdtlJZk1k7nvxt2DKBZ8RfnuLy6xkhGpcf0NvrAsIKc0WHB1j5FQ4qwLt4pdlc9kJRcrf9A+XM247XlOjSycd8sbAfLaurvkNePISK23y8p6BhaGs5vJBff8v4CKy/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mbofLMAT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QN8+HswJ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e97d35322f7011ef99dc3f8fac2c3230-20240621
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uCGfI/pVf11MH4N3xAca3wZw0Q4mRPxOzdPfY2VYMLg=;
	b=mbofLMATAfIh34khbfz+hHiMQnBse6ZO0r/UD5jlVG0BwT4bxLanckagc+9fEoSMWJHRLmdh9jQZIq0Ggrmq4J4HnM6BxriSyY+zhWVPFhREv2G1q/tiFzDVp9PP/IAqDDcJpMYPTvgm9grGLBZY1AtH7+jY/q8v/Ev7adLBIGM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:e358299a-966d-42c4-9f33-7e3591a4214c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:315ad644-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: e97d35322f7011ef99dc3f8fac2c3230-20240621
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 79190906; Fri, 21 Jun 2024 09:52:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 21 Jun 2024 09:52:25 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 21 Jun 2024 09:52:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNui7Yt2/dXUwbBew2BwhpONhUNZSnhkIthvJdMvH3RS+T0nJZigcNqf0QhMzpgThY7u10cOADzMzxDOAImye93kQCdUs7T761fgJnKhyKmMlAjVz9iuaDrbvLMqJbNHfPGFbn+729h6t1XR2zKnXycYtDYgcAipTjmXe+ceHmtoRcTlLe2EMwzbiksRQ4qtgfwy87IGVSuQQK2jw4j7CTudC0dRtI7W7vxIVzZFxTlfcP9NpuKqRhFE5DEV3akodhG2yOGakCYA1mArgkPRImbqdqTKrVCRvIpdlEI9h9DF78BDOJCjBtIiTRAKUhaWim9jP50YUP9Gjrrb3o6mOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCGfI/pVf11MH4N3xAca3wZw0Q4mRPxOzdPfY2VYMLg=;
 b=IFuT037lpBdiYrUTwB040GJ2GKCsTqBE4uRw4l245Cdsm9KYFrI/8F4FqxDhnJnSzljUITKSmaFhqdvClDWDDevwIdcnCxZWz6AtgkgByTsqcm3je1nAXmNlhQfSI3c/TOksuevm2TNj9NsO5r2VscgwxJOsXi6uQ8T9vF/fe6srCeZQUU1e+deG/pE28pGAnBJ/Fayyw2ZvCnOWsqzcqOy6SiNbfpy+gZ5mf8Zt2/fHzX/lNyUQJJelcFwuxvMMyStbBTLrfABXhE8Sh64Sp3QXuSVMAJrWC24RQQjInYuCiXmKIbttWsR60LVsZXYtneGbRbasXu0ru8UUxJhoGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCGfI/pVf11MH4N3xAca3wZw0Q4mRPxOzdPfY2VYMLg=;
 b=QN8+HswJaL5nrU+qucDzk5rBjf0p4JhcFHLd4VsXBOnTNiTd30oc/f0rf1KSCeNtBb2+WSWCo3nwOGLxoX/Nyg8clKtlZ6gTBnp5Ibrgl2fKBRlhdo2hhWuVrtGI6fNhxNRzhnnRH2mmhKNpGIyxLBXpzdkHJy+400m8xpRntw4=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by JH0PR03MB7687.apcprd03.prod.outlook.com (2603:1096:990:e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Fri, 21 Jun
 2024 01:52:23 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 01:52:23 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?=
	<Bibby.Hsieh@mediatek.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	=?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "littlecvr@chromium.org"
	<littlecvr@chromium.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 00/14] This series fixes the errors of MediaTek display
 driver found by IGT.
Thread-Topic: [PATCH v3 00/14] This series fixes the errors of MediaTek
 display driver found by IGT.
Thread-Index: AQHawxxu+6P/3QtCHk+kI+wngyft77HRdRaA
Date: Fri, 21 Jun 2024 01:52:22 +0000
Message-ID: <c30b7837a3d4e20a05169f56e0c8447bcc5cefe9.camel@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
	 <CAAOTY_9w2j9pMQAkE7mVR1Rcjw8QgrSvEqjk=db2imf6kBTNBA@mail.gmail.com>
In-Reply-To: <CAAOTY_9w2j9pMQAkE7mVR1Rcjw8QgrSvEqjk=db2imf6kBTNBA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|JH0PR03MB7687:EE_
x-ms-office365-filtering-correlation-id: 338f33db-d701-41df-3904-08dc9194cb29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?ekF6S2Q0V2dGL2NnZmd4cVRYQklKaUdzbmdXU1Z3UC9SOUpjWURZVnhMVlNp?=
 =?utf-8?B?ZGU5MHBkVDR3cDhmUlZXYnRkaWV4WjZaRzExRlRKK2VyWEx6aDI2RzVIblNN?=
 =?utf-8?B?MG0yWmRQV3lMTk51aVJXdnNkRTdRZHczT0xWMDY2YkJ5RFRrZE1FS1IvS1du?=
 =?utf-8?B?dFQ1WG53R3oydExFQ093Qjg3TmdIS2NUZlFRNlRFTTBZelpHdnVtTVVHTlRB?=
 =?utf-8?B?b3R1VGtVZ0xXb1h6cmkxVExWT0R0UjJOOEYzLzZLbXhlWlQvMmcxcHFUN0pU?=
 =?utf-8?B?dTBXTGM1OG1IaEk0VnQrVENLVDJidStoRXUxblBOMjRURlhCQndSajJxaWto?=
 =?utf-8?B?MzNhdm9kYndXNWlCazRpN0VUT3d3UXRYcWI4ZEhmR29TcWtJMUdKdXBwRnE4?=
 =?utf-8?B?MjhsRUl3ZUpLY0E1L2RLYzFWMjA1T2Nvb1NHZ215cjE2WXUvUWZ3K2xyalFy?=
 =?utf-8?B?OXMzajV6SmFxY2gwS3Q5bldYVHJucGtFdlhlZVFmZGV2U09GeENjR2FJc21s?=
 =?utf-8?B?TytjKzNCZlR3eGs5QVlmMGtabjVHZVJ0MFlvSDY1eWRUdU54L2JyZGdXOHVY?=
 =?utf-8?B?YUZKYVJrZG1KRGptUXhLNjNWU01jWnlXR2ZzY28wRExDY3JtRWFaSmZvbGR0?=
 =?utf-8?B?SjFsOGJXejBMa3hWZkR6NlhtWi9VOEdiZG11dndyVzNkL1RRQjEvSGxhMHRU?=
 =?utf-8?B?dlVLNkxnQmlMKzVaVlZndkZlWW94NjRDVEo0d2FaWjVyd0VmVjNlbEY3VWd4?=
 =?utf-8?B?YVd5blNKQVpjSnRWRFJhRG5jb1hhc25PNSsvazNid3NrcmFYTGdiUXpaWm1a?=
 =?utf-8?B?TWlweE9NMzhaSnVvaEZuZ2JXd3FxNlVMZEJRTmdHK0ZiWnlQY3RxeGk3WHZ1?=
 =?utf-8?B?TkdiSlBEcVQ0czdNRS8vNTJLUDZCaE5FYXhhK0ZkL3JQRjlMbVI1R2hOV3Z0?=
 =?utf-8?B?cEoyR2hlOExSVThYTHFrc2pZOVorTUtBR2k1SmoycXVjSHpzZkI3MTAxYW5i?=
 =?utf-8?B?Nm93VE9BbEY1VVZaL3lZZVRGWnpjSXplaXNMYUdyVEQxL1V4cEdrWWlraldm?=
 =?utf-8?B?bzR4cnBWU0o4NmRGKzZ5NkNOVzJ3YWJNUTY1V1F3ekF1dW44azZxcEFoWjA3?=
 =?utf-8?B?RWZ4NG1tVXBHem1xYVhNNGt0emFxTFZPSDRhRUpDVEdaZHkxWlJ1QVpDeklV?=
 =?utf-8?B?UnVlZE4wRG1JanVLSkRkenc1ZTJ6N2UzUnNURnBhb0hxOEx6T2w3dTRsT2FZ?=
 =?utf-8?B?KzRtUi9oZ0NITEp0QkE4NlRlcVQ4V21XSkJ6b3k4TmQ3b1FCYXJUNzVXUmtO?=
 =?utf-8?B?eGV4STFqOWlVK3JXNlhyem5pUlB1Yk5md2JGSWVSbnY4cG1zU0ZQQU96TzlX?=
 =?utf-8?B?UG1wcFlWSHFZWG9vMEE2cGFuRExPcXJvUkVmMlErY3Z4VzNoRlpjVG5Lb1lG?=
 =?utf-8?B?WU1LdE4rTERFM1BEUkJVSTJhSXVXbkVXVUllUm9GMElhVkFaeEkvNTIrWEtS?=
 =?utf-8?B?SHRsMDN0czB6R1djVlNuMS9KaWJaTmczM1JJZDUxVjI2VktwSEFRSHNXcjZP?=
 =?utf-8?B?N2RRZHVlNVcwaVNpVTRvS2U2UWwyOFNzR2JRMG9xNmpSOS96M1lwcWFza2Ex?=
 =?utf-8?B?TUhianhWMG0xQ28xUDlxaTg5UmFEcWFEQklWYktMUHdvNW5oZC9DZDZwbng2?=
 =?utf-8?B?am9oYmlkWU5KN01VYk81cWF4YUVWeU9oajhWaUtSZHVEc2x3d2d5NWJCa0hE?=
 =?utf-8?Q?RbLclv/gi4kJEb+eu4U0IPhYaBQR2ZMVJC9ZZxP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG1adHhMbnc1Q0JGb3QwOVRFdXltNlpKeU9BbVk5cVhPOEN1QjBGNTFzYU4x?=
 =?utf-8?B?NUxTRDA0OGVma2Rkb0p2VGRGNUVXUDVwN2Z6cWg5czU5dGJWSUhyNWMvN3V0?=
 =?utf-8?B?ekN5N2ExZXF2ZjJDNTV6L0xJcGN6VEZoVVdFMERDMkxiTUpRdnVkb1F6Z0Vi?=
 =?utf-8?B?a09NdGtDZlE4WXVxeFR1MytrVmFvM0NyR2pjS1NjU1ZoRnptRUhhS2Vmbmlt?=
 =?utf-8?B?RW1RT2NOL0w2NG5qQS9ma0owY0ZTY2s0T0ZtT0hOOWpqcWZCa05rd3phNWJJ?=
 =?utf-8?B?UG5tSk1QVjBmVVBkdjhKYzUxdzJuM3ZVTUlhV0Q5amJpZHprbHc3Zks3STFB?=
 =?utf-8?B?ZlJVS25jOFBQb3BqS01ROWFsL2VNbEdLVXJJcGt4VEtYcEczUy92ejFBWGl6?=
 =?utf-8?B?aWhCY1hKd3UrRWlEUzFXam1FbCtrcUs2dmdnV0tvdnliSXMveERaY3NMeEpt?=
 =?utf-8?B?ektwUlgyTkE1MmF0VXJEQzdDWTFiNm1MVzNxYVljYnZzSW9qeVBRazdEaEZV?=
 =?utf-8?B?S3JQVUpNcEtwcXJJZFNPZW9FeS96T0pST251djh6b0QrYktlelVIMlVxeFNR?=
 =?utf-8?B?WWRnT2E4Qk5wZVJUekdjZ2hTSEhYSitoTWdwYWVjUUNxbXNpZ25pOVRhYTJ0?=
 =?utf-8?B?NS9KVkdoVEMybXVhWU1pY3hiS2V5TlZFUVZBZC9pY1h6NG8rb1Izb081aDhn?=
 =?utf-8?B?eEh2cm1KYlg2N0NGWmg2UkdlTTJDTHo3WFJKdkxkRFVRNHY5K24wQzNsM24w?=
 =?utf-8?B?c1FyclBxNHVBcFFGNTU2YU1oMi84Um1LMit2MVVnbTlhaXlYa2U0aXpLK3FZ?=
 =?utf-8?B?NUdmYUNZMFVkelJjcXpESVg3ckl3TGlJM2hrd0JTSFZnRlhsdzBMV0kreHZx?=
 =?utf-8?B?M0M4NFcxaXNCazhXNEhmM2duZitiTDhuOTEvRjc1cGtjTnkyNTJhaW1iaGUw?=
 =?utf-8?B?eWpIb0JLOHlHYlgrS1psMFlvY0d1ZDRvODFRaTZBb0Z2MXlEZ21MVE9kTnYv?=
 =?utf-8?B?cTJuaWdUelllbXJwYXFUNlMwaUozTkI4bEZIODYwRzFvN001bHpTL25SSFFi?=
 =?utf-8?B?QW4yWTdRa0wzYlZ6emhHYWl1S3JIV25Zb20ycEZ0b2VBM3h3UHRqeVUyQXZ1?=
 =?utf-8?B?ei96MEJPeFNjb2JYeVZXeVJqZVRnZnh2cWhkL2VPUy9vRWhqNEZMODc3VXBp?=
 =?utf-8?B?YjlCaEoyeGh0TlkraEI5WTA2dUQ3VjhPV0NmMno3QzNqTnoxSks0ZXY2T0dL?=
 =?utf-8?B?TTcybkZIY0JzTEw4K1A1VVJkMFQ3ZWJlaFNNMW5EbVhyMXJJZElqUk40dVdI?=
 =?utf-8?B?Ly95dmtTNlh2VTdhUkxPNERtaVBsTERPZkZZQU5qNzlTaUNlVWRPN3ZFZitv?=
 =?utf-8?B?WmFFMkdTaDVKOXhsWmV0SWJGVm4vSUJXb1AyNTVhU1d3YU1sZ1o3Q3pDeVVq?=
 =?utf-8?B?dWl2eXJzN1VrOHlqSkpLUDNtSXluL2xTaGpibU1PQUI2OFBWOGxudkpvbDFI?=
 =?utf-8?B?clRqMFh5MFRmMHlpWHkzNzcvTUZNcmRWM2FzMUxOdW1reDlSUWdiWEZtbEx2?=
 =?utf-8?B?NG1jZXByR24rSXM4S2x1MEk3SU5vTmViOEpuT1VMY1hDRmk1dkVKZm0rWmJn?=
 =?utf-8?B?QXozNTg1Z0JHRWs3VktoZWJpK2l2SUJFMUgzUTQ0cWUvdFYrQjd3QXdpMGZh?=
 =?utf-8?B?Zm05c2VkeGlpa1RWZnQ4KzF6RjBCZzVjUWp4ejU1WXlQbURxTkozYU8xeTAz?=
 =?utf-8?B?V1FkZGtDZXB2NWk5eEZCczhKZUJzenplUDF1YnMzdVY4TlBCaTNYbU9KZXAw?=
 =?utf-8?B?NUZMWG1URnZQUGd0a2NlNTNyUEE4bHk3d2JPaENmMUhOamFLS0crcWhTa3hq?=
 =?utf-8?B?QTEwVDR3RFpyTFlSQlZGbkMxNDZoU1JRT1dTYlhaVWxpWVZlZGRLbFN4Y09p?=
 =?utf-8?B?SWdaVVgyQVlCMEw4SHdST3J2RDZWOWt4T1cvM3Q0UkYvajFhaFZnUjVCazIz?=
 =?utf-8?B?YytYeUVJb2E4RHd1bW5oWTRQek5ZUThMeTdTam1nL2dpMmdmdzFYeGFsS245?=
 =?utf-8?B?VGczZk9IUTZmQ29wT2N6OUR6d2NidmUxRHdYVVRnWkJKem0wQkFsOFl0TlJo?=
 =?utf-8?B?amE5bkdPRnNMTTczU2I5UGlXS0FYNWh2d2FQeXgzaGVlRFl3dmNwazY5VXBj?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <183B7EA9ECA0D4409C2629243F65375B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 338f33db-d701-41df-3904-08dc9194cb29
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 01:52:22.8754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE7av1zg0f17159RfGQLQ/dHuEcHcv8ty74YoOlID/P8gL09/+LBFthcjbZId5+yFaCVqmUHd61+7pYxn1kx0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7687
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--32.278000-8.000000
X-TMASE-MatchedRID: oMBNC5/fKrXUL3YCMmnG4vAIXMEsERIdjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2kkBrUL/4Vy4wCmrLlx+SdZ722hDqHosTf/b
	TCoZRptKp+po932P8HuYrizU0dnPMoRIL3xWcnX4TDJnK4xDjXYB84MMvKleaXCmcAC8DBrOezt
	9uZJJJrWRt1iy4sQZPECgYxgm6LJAy9zgULewwZm3NvezwBrVmKx5ICGp/WtGdCqKtxM6bh/bFC
	xAQ6srCmEKJdb67xSulpbc5//gVQs9tfSEZlKTRl2fRVpVyo6TDHSNFHFxB849osn8JrdJPADRM
	oifoBflsMMavja2AE0TPGwUzV65mR4Gl8zbWV9OzI1v7J4hECn0tCKdnhB58pTwPRvSoXL2y5/t
	FZu9S3N7f/25JKIC+C24oEZ6SpSk+Mqg+CyrtwA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--32.278000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A69EC3CB66AD88E7E9C1FD607B93C705FEEC9AE17180E5EDD3D8C1D20CC107422000:8

SGkgQ0ssDQoNCk9uIFRodSwgMjAyNC0wNi0yMCBhdCAyMjoxNiArMDgwMCwgQ2h1bi1LdWFuZyBI
dSB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBs
aW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBz
ZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBIaSBTaGF3bjoNCj4gDQo+IEhzaWFvIENoaWVuIFN1
bmcgdmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK3NoYXduLnN1bmcubWVkaWF0ZWsuY29tQGtlcm5l
bC5vcmc+IOaWvCAyMDI05bm0NuaciDIw5pelIOmAseWbmw0KPiDkuIrljYgxMjozOOWvq+mBk++8
mg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0Bt
ZWRpYXRlay5jb20+DQo+IA0KPiBGb3IgdGhlIHNlcmllcywgYXBwbGllZCB0byBtZWRpYXRlay1k
cm0tbmV4dCBbMV0sIHRoYW5rcy4NCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvY2h1bmt1YW5nLmh1L2xpbnV4LmdpdC9sb2cvP2g9
bWVkaWF0ZWstZHJtLW5leHQNCj4gDQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQoNClRoYW5r
IHlvdSBmb3IgdGhlIG5vdGlmaWNhdGlvbi4NCg0KQmVzdCByZWdhcmRzLA0KU2hhd24NCg0KPiAN
Cj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gTW9kaWZ5IHRoZSBjb21taXQgbWVz
c2FnZQ0KPiA+IC0gQWRkIGEgcGF0Y2ggdG8gZml4IGRlc3RpbmF0aW9uIGFscGhhIGVycm9yIGlu
IE9WTA0KPiA+IC0gTGluayB0byB2MjogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI0MDYxOS1tZWRpYXRlay1kcm0tbmV4dC12Mi0wLWFiZjY4ZjQ2ZjhkMkBtZWRpYXRlay5jb20N
Cj4gPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gLSBTZXBlcmF0ZSB0aGUgY2hh
bmdlcyB0aGF0IGJlbG9uZyB0byBhbm90aGVyIHJlcG8NCj4gKGRyaXZlci9zb2MvbWVkaWF0ZWsp
DQo+ID4gLSBNb3ZlIHRoZSBmaXggcGF0Y2hlcyB0byB0aGUgZnJvbnQgb2YgdGhlIHNlcmllcw0K
PiA+IC0gTGluayB0byB2MTogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA2MTYt
bWVkaWF0ZWstZHJtLW5leHQtdjEtMC03ZThmOWNmNzg1ZDhAbWVkaWF0ZWsuY29tDQo+ID4NCj4g
PiAtLS0NCj4gPiBIc2lhbyBDaGllbiBTdW5nICgxNCk6DQo+ID4gICAgICAgZHJtL21lZGlhdGVr
OiBBZGQgbWlzc2luZyBwbGFuZSBzZXR0aW5ncyB3aGVuIGFzeW5jIHVwZGF0ZQ0KPiA+ICAgICAg
IGRybS9tZWRpYXRlazogRGlzYWJsZSA5LWJpdCBhbHBoYSBpbiBFVEhEUg0KPiA+ICAgICAgIGRy
bS9tZWRpYXRlazogRml4IFhSR0Igc2V0dGluZyBlcnJvciBpbiBPVkwNCj4gPiAgICAgICBkcm0v
bWVkaWF0ZWs6IEZpeCBYUkdCIHNldHRpbmcgZXJyb3IgaW4gTWl4ZXINCj4gPiAgICAgICBkcm0v
bWVkaWF0ZWs6IFR1cm4gb2ZmIHRoZSBsYXllcnMgd2l0aCB6ZXJvIHdpZHRoIG9yIGhlaWdodA0K
PiA+ICAgICAgIGRybS9tZWRpYXRlazogQWRkIE9WTCBjb21wYXRpYmxlIG5hbWUgZm9yIE1UODE5
NQ0KPiA+ICAgICAgIGRybS9tZWRpYXRlazogQWRkIERSTV9NT0RFX1JPVEFURV8wIHRvIHJvdGF0
aW9uIHByb3BlcnR5DQo+ID4gICAgICAgZHJtL21lZGlhdGVrOiBBZGQgbmV3IGNvbG9yIGZvcm1h
dCBNQUNST3MgaW4gT1ZMDQo+ID4gICAgICAgZHJtL21lZGlhdGVrOiBTZXQgRFJNIG1vZGUgY29u
ZmlncyBhY2NvcmRpbmdseQ0KPiA+ICAgICAgIGRybS9tZWRpYXRlazogU3VwcG9ydCBtb3JlIDEw
Yml0IGZvcm1hdHMgaW4gT1ZMDQo+ID4gICAgICAgZHJtL21lZGlhdGVrOiBTdXBwb3J0IFJHQkE4
ODg4IGFuZCBSR0JYODg4OCBpbiBPVkwgb24gTVQ4MTk1DQo+ID4gICAgICAgZHJtL21lZGlhdGVr
OiBTdXBwb3J0IERSTSBwbGFuZSBhbHBoYSBpbiBPVkwNCj4gPiAgICAgICBkcm0vbWVkaWF0ZWs6
IFN1cHBvcnQgRFJNIHBsYW5lIGFscGhhIGluIE1peGVyDQo+ID4gICAgICAgZHJtL21lZGlhdGVr
OiBGaXggWFJHQiBzZXR0aW5nIGVycm9yIGluIE9WTA0KPiA+DQo+ID4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuaCAgICAgICAgIHwgIDYgKy0NCj4gPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICAgICAgfCA5Mw0KPiArKysrKysrKysr
KysrKysrKystLS0tLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmxfYWRhcHRvci5jIHwgIDIgKy0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmMgICAgICAgICAgfCAyNCArKysrKysrDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2Rydi5oICAgICAgICAgIHwgIDQgKysNCj4gPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19ldGhkci5jICAgICAgICAgICAgfCAyNyArKysrKy0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfcGxhbmUuYyAgICAgICAgICAgIHwgIDQgKy0NCj4gPiAg
NyBmaWxlcyBjaGFuZ2VkLCAxMjYgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pDQo+ID4g
LS0tDQo+ID4gYmFzZS1jb21taXQ6IDYyZmU0YjA2NzU4MWQ0ODBlODYzMTkxMzA1ZjEwOGJlYmZm
YmMwZTkNCj4gPiBjaGFuZ2UtaWQ6IDIwMjQwNjE1LW1lZGlhdGVrLWRybS1uZXh0LWFkNjAxYjM0
OWYyMw0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+DQo+ID4gLS0tDQo+ID4gSHNpYW8gQ2hp
ZW4gU3VuZyAoMTQpOg0KPiA+ICAgICAgIGRybS9tZWRpYXRlazogQWRkIG1pc3NpbmcgcGxhbmUg
c2V0dGluZ3Mgd2hlbiBhc3luYyB1cGRhdGUNCj4gPiAgICAgICBkcm0vbWVkaWF0ZWs6IFVzZSA4
LWJpdCBhbHBoYSBpbiBFVEhEUg0KPiA+ICAgICAgIGRybS9tZWRpYXRlazogRml4IFhSR0Igc2V0
dGluZyBlcnJvciBpbiBPVkwNCj4gPiAgICAgICBkcm0vbWVkaWF0ZWs6IEZpeCBYUkdCIHNldHRp
bmcgZXJyb3IgaW4gTWl4ZXINCj4gPiAgICAgICBkcm0vbWVkaWF0ZWs6IEZpeCBkZXN0aW5hdGlv
biBhbHBoYSBlcnJvciBpbiBPVkwNCj4gPiAgICAgICBkcm0vbWVkaWF0ZWs6IFR1cm4gb2ZmIHRo
ZSBsYXllcnMgd2l0aCB6ZXJvIHdpZHRoIG9yIGhlaWdodA0KPiA+ICAgICAgIGRybS9tZWRpYXRl
azogQWRkIE9WTCBjb21wYXRpYmxlIG5hbWUgZm9yIE1UODE5NQ0KPiA+ICAgICAgIGRybS9tZWRp
YXRlazogQWRkIERSTV9NT0RFX1JPVEFURV8wIHRvIHJvdGF0aW9uIHByb3BlcnR5DQo+ID4gICAg
ICAgZHJtL21lZGlhdGVrOiBBZGQgbmV3IGNvbG9yIGZvcm1hdCBNQUNST3MgaW4gT1ZMDQo+ID4g
ICAgICAgZHJtL21lZGlhdGVrOiBTZXQgRFJNIG1vZGUgY29uZmlncyBhY2NvcmRpbmdseQ0KPiA+
ICAgICAgIGRybS9tZWRpYXRlazogU3VwcG9ydCBtb3JlIDEwYml0IGZvcm1hdHMgaW4gT1ZMDQo+
ID4gICAgICAgZHJtL21lZGlhdGVrOiBTdXBwb3J0IFJHQkE4ODg4IGFuZCBSR0JYODg4OCBpbiBP
Vkwgb24gTVQ4MTk1DQo+ID4gICAgICAgZHJtL21lZGlhdGVrOiBTdXBwb3J0IERSTSBwbGFuZSBh
bHBoYSBpbiBPVkwNCj4gPiAgICAgICBkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgRFJNIHBsYW5lIGFs
cGhhIGluIE1peGVyDQo+ID4NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBf
Y29tcC5oICAgICAgICAgfCAgNiArLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMgICAgICAgICB8IDk1DQo+ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4g
PiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgfCAgMiAr
LQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgICAgICB8
IDI0ICsrKysrKysNCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2Lmgg
ICAgICAgICAgfCAgNCArKw0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2V0aGRy
LmMgICAgICAgICAgICB8IDI3ICsrKysrLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19wbGFuZS5jICAgICAgICAgICAgfCAgNCArLQ0KPiA+ICA3IGZpbGVzIGNoYW5nZWQsIDEy
NyBpbnNlcnRpb25zKCspLCAzNSBkZWxldGlvbnMoLSkNCj4gPiAtLS0NCj4gPiBiYXNlLWNvbW1p
dDogNjJmZTRiMDY3NTgxZDQ4MGU4NjMxOTEzMDVmMTA4YmViZmZiYzBlOQ0KPiA+IGNoYW5nZS1p
ZDogMjAyNDA2MTktaWd0LTQ5MTk1ZTIxNDA0ZA0KPiA+DQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+
IC0tDQo+ID4gSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4N
Cj4gPg0K

