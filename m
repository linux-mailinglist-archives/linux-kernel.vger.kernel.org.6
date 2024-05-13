Return-Path: <linux-kernel+bounces-177685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A406A8C4301
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AAC1C21636
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34215383E;
	Mon, 13 May 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kZgBHM2z";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fU+krX8J"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76950279;
	Mon, 13 May 2024 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715609770; cv=fail; b=A6vUf6mhN6dOjYEQFmRPE591AYIDUEJm2rQlgBOO31dGkXWviDficL2evcKT2bPKGHHlI4eRibAnWXbRsLGrYoHcGEQrhEn+LKpa9oaPBLAuC/f5o/hqDYSghyrY+5f9wamtigH/HNtqtgWNUPyEUWlwl088t6R0Y7+y3V/qKyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715609770; c=relaxed/simple;
	bh=NJZZVdq2dqh8Z/xPI57wG4hOFqC3hNertCAel+Dytso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kuANdXa0VgCqEncvQQbQoJJx4n11rhxFHFcEldaKzGB1EMXKpOfDDhdoRap9dwG9btQrcBZT//Cm05x8msHtsZFBA/T+gqpmSFFGchn0aR3wGfohvMy+Hs4Eve7RITLl4IRmrLopeldwm5cwjIdd9LCvfALVVSK32SnVgJhJ4gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kZgBHM2z; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fU+krX8J; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 54631800113311ef8065b7b53f7091ad-20240513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NJZZVdq2dqh8Z/xPI57wG4hOFqC3hNertCAel+Dytso=;
	b=kZgBHM2za72MIX9dJgnSLdMj7MjxQmQAF/RiSu79fj1BsGwx/HcyU4+aY6wLmA3UocPYBk6dn5hIa64yE88W/DKU0GRIUkhdjBcqH2ewRPgLWtWPO7P8Rb0F0Mk4BOZ20wn862F/2B7uNnvimb7B/SORkzr1Fe00uOV+waA/dRg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4a5626e4-1190-44cc-acf4-d86d8efccff4,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:09ceb292-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 54631800113311ef8065b7b53f7091ad-20240513
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 990356709; Mon, 13 May 2024 22:16:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 May 2024 22:16:00 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 May 2024 22:16:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTgymFVzD6isQWv825CofYMUshRjhuaLfvx0C8wnP8I+oAnVrT8Uzn5xOOzOcYffpqr39ZrLZfZmges56wK/xfQKJVfYhrH/A0S0+GwAU8JRTpKv+ZljSj+IZAWyIrHQJENpvA1M9fSVzS8FsbhmGczoszxwoVMTG3pTNIu+JhEF4Sjwue2zJMD4+jUOapuH8hD+iDbaE5lHwryDvFzgf+CSbtT+/q4dogXSB50IrXf6bDORfLF7wn380Sd91ebIDvC1j8E4d7GgFFB5VHS/kF9gTYqbqGJM2zAZYQNTHX94rAu7TMc4NGqc27OzxgV6jIcB7ITJ53kp/GyZtGnAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJZZVdq2dqh8Z/xPI57wG4hOFqC3hNertCAel+Dytso=;
 b=KdJ0XoceibTkiUxbk0ozzuyOg9IwoNZ+fIt2Zv7bv8FcLAkbIxTYcYu6lgND7vg822rtsccmDy253ojbBCF0S5UUHredj62nLVpaz5XuAndguGYNCwvKuF5jGFTIz4MPMPsPlVPgn7/+3BiH723cbzIBSDHLCUTtIuyDM78Gtj7emLgVC/eo8QwQr/mQoycJ/7ldGTIzOIpEVfX3DCA9GR4ALykdZjMArYtTjrIz3aVLYI6hNgyGSJXWmDPfabWvXlubInHytZ4d4fOFmOn4SCmJeQ5/YjDorgGQ9k3KaDYPVjyEPbucIh1z1cm4lJO4jL5EEWIpKLMYvYyL91GPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJZZVdq2dqh8Z/xPI57wG4hOFqC3hNertCAel+Dytso=;
 b=fU+krX8J7UWXCrvtaqa9HOSflNVudtQ059bK+bhOH4MqmnFUOiYPp+3utbOKNbUwYqEfRV7et65XdEY6yogTl3zYJhELn+6DYAjg8WUH4MtGleQfTfyLQjKcQw6fnd4cgyRBUJl2O2TolzwsEPbamQDihDHVL3vDi+LUVkmHDcw=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by JH0PR03MB7751.apcprd03.prod.outlook.com (2603:1096:990:9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.24; Mon, 13 May
 2024 14:15:57 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3%5]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 14:15:57 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
	<Chunfeng.Yun@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?=
	<Mac.Shen@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Add dp PHY dt-bindings
Thread-Topic: [PATCH v2 2/2] Add dp PHY dt-bindings
Thread-Index: AQHaosoq14tjS/hF8kyh32TtEXWXzLGUuniAgACAFwA=
Date: Mon, 13 May 2024 14:15:57 +0000
Message-ID: <3f387c9e8ac34ca25ec7b6bfb02536cd4ebbc508.camel@mediatek.com>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
	 <20240510110523.12524-3-liankun.yang@mediatek.com>
	 <e02c2f42-b5e4-4200-8131-3881b7034625@kernel.org>
In-Reply-To: <e02c2f42-b5e4-4200-8131-3881b7034625@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|JH0PR03MB7751:EE_
x-ms-office365-filtering-correlation-id: 5f241b24-3eae-49db-523b-08dc7357354f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?Z3FpZy90K3MwVTFpSE9QaWR1VWlZWGxvKzhWMTMzaGJ4SzE0cTVOK3pwc3cw?=
 =?utf-8?B?TkVFZVNReFNmYmZtKzJZUm1uQ1JWellheDlxdURhZ055Z05PVnRqbnBobkxR?=
 =?utf-8?B?OXNlZFNoNHBvV1dWYkxMby9SRnQ0TlA5N3FuVUhyVjZFbEFiMWFnYnVwUDBv?=
 =?utf-8?B?a0pGQm1kYXpJRkcwM2UvMm9mcFdvWTVkc0F3b2ZiR1lJU2NQK01kaEhYbGhm?=
 =?utf-8?B?ZnZUbDNYSm01VWZJMFRRZHNzeGJtMDBxeENtSWNjc2ZTck1RK1dhRzFnNzd5?=
 =?utf-8?B?OWlVa1JsQVFwNU9CcVhQeFhmSVZ4K3NzREVodTJMTVZwbFRmbkRUNE5aQm45?=
 =?utf-8?B?MUJIdzFEd0hQZXRyenN5amxDVzN3U2NxQzZRZE1INTFYR2FROGtVNVUyaTdY?=
 =?utf-8?B?eCtNNVdwQWNOTHh2UXU3cU9YVVluczRQVGJkQlgvSldNb3NGZDVjanNUK0xK?=
 =?utf-8?B?OHRlWWgvenVOejFYZ3hNeDYzWnl5TWtXQ3p0T1JkenNhWjEzZjFCQ2RJbUJS?=
 =?utf-8?B?Vkh1alNPaGo4bTB2Qjk3ZWRwb2FZWk01aEZFSEhtWXFRSi9MY0ZLOGFEL2xj?=
 =?utf-8?B?YnRwOU1VWnhyRnFJQW10RzNaZXFnem5lMVlWSk9DU21YYVBTam1BZEcvK3ky?=
 =?utf-8?B?M1p4R1pPSmRpeDQ4VlJCWmhGdXVweXZZd3ZxRHpua2dBWllQZ0owVXNDV1lZ?=
 =?utf-8?B?cnJFdDhkTS9wcXBjeFlUclFUdDJ5STBKU3BKL3c4emh2N3RlZUl4WFlhR29V?=
 =?utf-8?B?UGR0MzR1V3NIeGlXM1BZMVIwRks2Z0VLc1cwS1lZczh0aWhFR0Jlb1FrcTcz?=
 =?utf-8?B?NmFWazFOY25BQnZSZXZnZDdmYm9iV21EMkg3cm0rTTgreUVvSVpINGdWNEdP?=
 =?utf-8?B?WVdsbjVZVTFuaysvNGMvNFcwbFZMRzNITWMwQ3hQVGhKS2JuQTN4VThyN2xM?=
 =?utf-8?B?NStmeCtyU0JkZm15NE9iNWpxN2Z0ckFFZG5SMDBXNUUxUlc4c0ErU2JQdGxr?=
 =?utf-8?B?UC9SVGlvTDI2REViczhIaG9KK3VaZFRGZHpxWHIxREprVWZqcy9FMFhYV2N6?=
 =?utf-8?B?YlRUeHI5RkgydzBpQWc2dm5JWmpkd3lPVlk0dE92cXpCclk5WGh3Qm1qdjFl?=
 =?utf-8?B?Vkc2dWRkeWJkOFIvMGExNzUrVW56Yi9Xb21mb3RNK0dKcWhtKzJpbnVvU2Zw?=
 =?utf-8?B?RFZHTmpjSFAzTEk1TFlyRUxyQkg5dDZhZWhnNTg0OFRFQlN1MlVJM2dKNFRD?=
 =?utf-8?B?VXU0Uytwd09KaWZTMUlEM1M2eEE5WUU5cnV3K1ZYbkxRcjhIazJENENoalRz?=
 =?utf-8?B?WmNJSVJBYmEzZTd4dnRwVU1LRHFzQzByMEF1L3gyL3hvZ2VxemNQa3Y1b2tu?=
 =?utf-8?B?NXJ0b3E4UURkQzhyTlYvdXQyeitjZDdjWFFpay92c3BraExabFVDeStab2lx?=
 =?utf-8?B?UTMrdXd1Wk9sTlhKa2RQUzhkUnRrbkx6OCtMekFGR1ZnUTNRQVR4QWFKWGNo?=
 =?utf-8?B?elZ4S1poeE8zQVptTWswNWJqd2xzdkRpYXJBVzNKOHZ0V0l6cEMrNG8vR3hp?=
 =?utf-8?B?TXN4ZjR0a29mNmFnY1IwbkRKZUNnK0lhbVhHanpOTU9udFZJVFMxdjlHQkJa?=
 =?utf-8?B?R1pYRmJZK2lWYTBtL1BBNXhWY3YzbE9uSUNBYkJHaXlYZ0d3VFh4cHo2K3V5?=
 =?utf-8?B?UEpSM0F6M1VFRk4zUkxlMlpxMEtteWt1WW0ySi8wSnlzcjB0ZzFXK2lSaGVN?=
 =?utf-8?Q?uEql33n9vZl1qy/Od4LKzIHdFxvnH5+sEc4FvWg?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekJnWXNqUFhjaWxZbmZ4YnpHcmhKVmllK2RpWGR4cGRLTUpmVGZCczZBTnEz?=
 =?utf-8?B?R2NsVTYvazBGUW43V3lwS082bWhSL1haUUN0SzhzMXpvWHpBNm95L0grV2tz?=
 =?utf-8?B?Wlc3bWRVSzdqM09SYVlCM1BrS1NkNHJXZjRkbTJEK20xMTgzWDRvcnBwcERM?=
 =?utf-8?B?aS9CRHdPWUtxaklXN2lKSzI5cFB0S1A3bUNQQU5DUFFnZnhWMTFjOW1rZzYy?=
 =?utf-8?B?MGgyVUgrdFZXOFU0bFBFT0VRTjF1NTJsaHBvbzZHTHZPZEtXaWpCY2xzczBL?=
 =?utf-8?B?MUtYM1VlNFo0TzRYZ3gxR0dPT1I2Y0NjTkJhTlMwUmd2OTVmRGF5cW5HYnBQ?=
 =?utf-8?B?dTFFN3E5YWVzMzdnd0NuSjhGeGd5c1g4eUlEUUNRbnQxblNTTzM2K21UWE9v?=
 =?utf-8?B?YlhxcnZJUFFCZDAzb2ZiYkZ1U0JqWjk4V1NhajdCSnVHZTIwbU92bUhmNW1U?=
 =?utf-8?B?TlJLcUpSMU5vOHFvK0pJNXZjYnppWW42eTRIVis5QTN4ellRaFBGQjRwNWI5?=
 =?utf-8?B?OWFsRE1PYi9zTG5CYVpFSlhRYkRYeGtoUlIxUjhxdFFBUmQ2aUxQTFUwNGVY?=
 =?utf-8?B?R1pYNlVJa3NjM0ZLVVdKTE9FeHlFL1JJaW9NdlZhWGJ4VTFFVHZlOXIzN3hp?=
 =?utf-8?B?Yml6S0I4VG1YYVRRL2JEQVdjQTJCV0ViZERBUUQzdkdxM3QvcEZGWElJSmFC?=
 =?utf-8?B?dXp0WFFTRGVMaVpHcE1RYWlNMFY2RTFLMWVZNDhXQStveXFIK0lBM1FUa01Z?=
 =?utf-8?B?aTI5elZTUUFQMlUxOGd3WjdnRHYwTkY1d1dWSHZXNURnZWZaQmRSWEdlMmlD?=
 =?utf-8?B?SVhINVR5R3VsQmtpL0oxbElLTHdPek5UaURpVTU0YVAzOTRFTWtzem5hQTVG?=
 =?utf-8?B?Y2l6MzdUQkZmSTNnWnBaMEFLcGtUaXNQbHNSODBIV0ZUU0NobDVHajRxamJK?=
 =?utf-8?B?RnY0V2xuL3NaV1ltRmRSUFkyVmxoNUluSjFESWZqMHZBbG9ia1dHVm12aXN2?=
 =?utf-8?B?a0g2Q1VNYmFLcy9PaGM0UlVJYVJWU0d4cFcvL2kySld0Mys4Rm1ZRFBaTXpM?=
 =?utf-8?B?WW16ZVpyT2Z1YW1FYjF3TjIyb0NZbDZEUFF4MkRpdzBFRE80Tlg2MlBuL0ZM?=
 =?utf-8?B?eTh3K3NxempIUDRJYWNRS2dMemh1L3hZWTZ0dHZLdk92ckNLV256dnF5VFBK?=
 =?utf-8?B?Q0ZhM0FBMXJ3U0RJS0JXb0lMa0h3ZkZlZWZsNTBHSWd6RnRuMFY2K1A4UW44?=
 =?utf-8?B?bWZsdFd5WjZ3blBaMTR2TkVNbHNkbGtvNms5ZXRtenE1amlGOVlxLytRTlBj?=
 =?utf-8?B?a2lkdmZHVGJYZzhRZTZXSzJqZ05rV1c4RmpxTHlQeEFFRVFYYlVxR0JXbUxm?=
 =?utf-8?B?bWVMNkh3a3dHY3NhbEdnREdlQU82cFlnaTRxYjMvL1MxaEw4bllTdjdpSWpM?=
 =?utf-8?B?QVdFcWdEZlp1dGt6QVQ0SExJcE5WNUNCVldybzdRbVlyVG15aDUzVExQeHZX?=
 =?utf-8?B?QURGeXVHNS8xZm1LcTlBcjJRUjc0N1BXem96VFZhZDJxS2RpcERTNXg1YlBo?=
 =?utf-8?B?ZHRYd1A3Q0NSa3lkUGJyTTVtalJTWjYvTzZnOXJXL1ZzbVpjaStzTFpnZnZG?=
 =?utf-8?B?R2phN2xlSUM3OW1QUEtKNVVzQXFYWjdmcXdzU3VHUEpMT3NGR2ZESXhBWE1s?=
 =?utf-8?B?dGFuM0tFaW8wdVg1MkYzbmhYU1NHNkkxckRiNnIzUUl0VWpBUlpRallhRmZm?=
 =?utf-8?B?T2M5dmt2T3BDcnlQa2VhS0plVDZQbUIxNU5XeHcxaG1CbDVLeFZldnRXTGw4?=
 =?utf-8?B?T0cwYVl3S3AwM2lMSVFtTmhBK2hnSE9uQXBoZktPdXAvUCtodDV3dERwZ0dr?=
 =?utf-8?B?dWNWekYxenJrUUsrNURENnBWR3ZYei9DOVN6WVE0T1gySkxtYmJVbDF1NUNi?=
 =?utf-8?B?Q2F4c2p0R0ZFU3VQSTZOQ2ZFNnUxcS9iRUE3dW9xZFZkRmdFRlFXNCtjK3Jv?=
 =?utf-8?B?UDRnK0RvUXdKVmdEaUpSVW5lR3hhT0ZYMS9iQy9qeVhudTBSU1hNRk1aR05R?=
 =?utf-8?B?Wm1vMWpjeG9COEljRm9PS0RKS1FjNkxPZ21PTjUxa1YxTVVXKzV3OHNqMnBX?=
 =?utf-8?B?NENrWHhPR3Rpd2lXcmI4WXVqazBiTUJTanpUTVAxcnMybzJYbThtaXhQRkxz?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE0F71498D31F94894F5F5B20C32822D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f241b24-3eae-49db-523b-08dc7357354f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 14:15:57.3494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvpjChgG2soAtLBTfrjXgMm6kYmjnC0LsnANhvCqm01GGnnnKFwYAWfULlIciy3VlcxfEeb9DllRvpNM9UZI9DiPkOeeaZb9vaciFV8VBC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7751
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.195900-8.000000
X-TMASE-MatchedRID: CML2QBp/u5TUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP0xmbT6wQT2a+6yA0Abm8fymUD
	gikHuA07mRUAUxAZhUtt9i45mMISqsZoAfmv0SGSEryjhqiyzykyQ5fRSh265N15VVRl9DpE/q6
	CMJkNS1UxA6caKb6ne3oyCnprDLA3au9iF5mAFe3C+Q0h5+aC3Y6il1iqWy2JScXQMxepe+3Tv7
	ZA0xIMkr22hiNLwI+3U49ib7uT4dPrqG4cFc/YAXy2tkK+taSQO8njdTAEzFOouc5Rcf1B0v9+R
	vGSUdYBKc7RWw99gPGV1NRwRYZUmihIGp4gXrM0wmhCbeOj6aTQAp53S718Hu6qThyrnanOXQGs
	fwFBRhcL1MXSgRnEMEQOIcCJ9jA3PaACMPfZGhWwbuvhCHs3cCI3p+Ju8mqrhpE4kTKmv3KK6G9
	Czac5IOktzOOhXORy6Axu/YKiCX/QVlT07zIBdhaz6sxCNvh+7nrAU9KQxUbrtDe4+j0oj3J/Xn
	/tbYMEw3gBunj2FF5cZ0icLp7DqQv21zJNl0CyDGx/OQ1GV8mgVPcrOkeoT1GcRAJRT6POOhzOa
	6g8KrTn7+pOnTJf8nx3hPscxGMNH0F8fXi+VLaQ+moXyGkhIlSXoFm7rNm4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.195900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	FBD849F92A013EB5208E0517FE5D97C2BA2830403A96BBD2AD03B5E66ABB9F702000:8

T24gTW9uLCAyMDI0LTA1LTEzIGF0IDA4OjM3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDEwLzA1LzIwMjQgMTM6MDQsIExpYW5rdW4gWWFuZyB3
cm90ZToNCj4gPiBBZGQgZHAgUEhZIGR0LWJpbmRpbmdzLg0KPiANCj4gVGhpcyB0ZWxscyBtZSBu
b3RoaW5nLiBSZWFkIHN1Ym1pdHRpbmcgcGF0Y2hlcy4NCj4gDQo+ID4gDQo+ID4gQ2hhbmdlZHMg
aW4gdjI6DQo+IA0KPiBUaGlzIGRvZXMgZ29lcyB0byBjaGFuZ2Vsb2csIG5vdCBjb21taXQgbG9n
Lg0KPiANCj4gPiAtIEFkZCBkcCBQSFkgZHQtYmluZGluZ3MuDQo+ID4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLw0KPiA+IDIwMjQwNDAz
MDQwNTE3LjMyNzktMS1saWFua3VuLnlhbmdAbWVkaWF0ZWsuY29tLw0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IExpYW5rdW4gWWFuZyA8bGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IFRoaXMgcGF0Y2ggbG9va3MgdGVycmlibGUuLi4gdGhlcmUncyBzbyBtYW55IHdyb25nIHRoaW5n
cyBJIGRvbid0DQo+IGV2ZW4NCj4ga25vdyB3aGVyZSB0byBzdGFydC4NCj4gDQo+IFBsZWFzZSB1
c2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vic3lzdGVtLiBZb3UgY2FuIGdldCB0
aGVtDQo+IGZvcg0KPiBleGFtcGxlIHdpdGggYGdpdCBsb2cgLS1vbmVsaW5lIC0tIERJUkVDVE9S
WV9PUl9GSUxFYCBvbiB0aGUNCj4gZGlyZWN0b3J5DQo+IHlvdXIgcGF0Y2ggaXMgdG91Y2hpbmcu
IEZvciBiaW5kaW5ncywgdGhlIHByZWZlcnJlZCBzdWJqZWN0cyBhcmUNCj4gZXhwbGFpbmVkIGhl
cmU6DQo+IA0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZGV2aWNldHJl
ZS9iaW5kaW5ncy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbCNpLWZvci1wYXRjaC1zdWJtaXR0ZXJz
DQo+IA0KPiBQbGVhc2UgcnVuIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBhbmQgZml4IHJlcG9ydGVk
IHdhcm5pbmdzLiBUaGVuDQo+IHBsZWFzZQ0KPiBydW4gYHNjcmlwdHMvY2hlY2twYXRjaC5wbCAt
LXN0cmljdGAgYW5kIChwcm9iYWJseSkgZml4IG1vcmUNCj4gd2FybmluZ3MuDQo+IFNvbWUgd2Fy
bmluZ3MgY2FuIGJlIGlnbm9yZWQsIGVzcGVjaWFsbHkgZnJvbSAtLXN0cmljdCBydW4sIGJ1dCB0
aGUNCj4gY29kZQ0KPiBoZXJlIGxvb2tzIGxpa2UgaXQgbmVlZHMgYSBmaXguIEZlZWwgZnJlZSB0
byBnZXQgaW4gdG91Y2ggaWYgdGhlDQo+IHdhcm5pbmcNCj4gaXMgbm90IGNsZWFyLg0KPiANCj4g
DQo+ID4gLS0tDQo+ID4gIC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLnBoeS1kcC55YW1s
ICAgICB8IDQ1DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQ1
IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLnBoeS0NCj4gZHAu
eWFtbA0KPiANCj4gV3JvbmcgZmlsZW5hbWUNCj4gDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLnBoeS0NCj4gZHAueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLnBoeS0NCj4gZHAueWFtbA0KPiA+IGluZGV4IDAw
MDAwMDAwMDAwMC4uNDc2YmMzMjkzNjNmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKw0KPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLnBoeS0NCj4gZHAueWFtbA0KPiA+IEBAIC0wLDAgKzEsNDUgQEANCj4gPiArIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZ
QU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gaHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxwaHktZHAueWFtbCMNCj4gPiArJHNjaGVt
YTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0K
PiA+ICt0aXRsZTogTWVkaWFUZWsgRGlzcGxheSBQb3J0IENvbnRyb2xsZXINCj4gPiArDQo+ID4g
K21haW50YWluZXJzOg0KPiA+ICsgIC0gTWFjIHNoZW4gPG1hYy5zaGVuQG1lZGlhdGVrLmNvbT4N
Cj4gPiArICAtIExpYW5rdW4geWFuZyA8TGlhbmt1bi55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAr
DQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgU3BlY2lhbCBzZXR0aW5ncyBuZWVkIHRvIGJl
IGNvbmZpZ3VyZWQgYnkgTWVkaWFUZWsgRFAgYmFzZWQgb24NCj4gdGhlIGFjdHVhbA0KPiA+ICsg
IGhhcmR3YXJlIHNpdHVhdGlvbi4gRm9yIGV4YW1wbGUsIHdoZW4gdXNpbmcgYSBjZXJ0YWluIGJy
YW5kJ3MNCj4gZG9ja2luZw0KPiA+ICsgIHN0YXRpb24gZm9yIGRpc3BsYXkgcHJvamVjdGlvbiwg
Z2FyYmFnZSBtYXkgYXBwZWFyLiBBZGp1c3RpbmcNCj4gdGhlIHNwZWNpZmljDQo+ID4gKyAgc3Nj
IHZhbHVlIGNhbiByZXNvbHZlIHRoaXMgaXNzdWUuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0K
PiA+ICsgIHN0YXR1czogZGlzYWJsZWQNCj4gDQo+IEkgdGhpbmsgeW91IG5pY2VseSBzaG9ja2Vk
IFJvYiBhbHJlYWR5Lg0KPiANCj4gUGxlYXNlIHJlYWNoIGludGVybmFsbHkgdG8gTWVkaWF0ZWsg
b3IgY29sbGFib3JhdGluZyBjb21wYW5pZXMgdG8gZ2V0DQo+IGJhc2ljIHRyYWluaW5nIGFuZCBp
bnN0cnVjdGlvbnMgaG93IHRvIHdyaXRlIHBhdGNoZXMgYW5kIGJpbmRpbmdzLg0KPiANCj4gT3Ro
ZXJ3aXNlIGl0IGlzIHdhc3RlIG9mIG91ciB0aW1lLiBNZWRpYXRlayBpcyBub3QgYSBzbWFsbCBj
b21wYW55IHNvDQo+IHRoZXJlIGlzIG5vIGV4Y3VzZSBpbiBzZW5kaW5nIHN1Y2ggcG9vciBxdWFs
aXR5IHBhdGNoZXMsIHdoaWNoIHdvdWxkDQo+IGJlDQo+IEVBU0lMWSBzcG90dGVkIGJ5IHRoZSBN
T1NUIEJBU0lDIHJldmlldy4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K
DQpJIHVzZWQgc2NyaXB0cy9jaGVja3BhdGNoLnBsIGFuZCBmaXggcmVwb3J0ZWQgZXJyb3IgYW5k
IHdhcm5pbmdzLg0KSSBhbSByZXN1bWJtaXR0aW5nIGJpbmRpbmdzIGJ5IHRoZSBNT1NUIEJBU0lD
IHJldmlldy4NCg0KQmVzdCByZWdhcmRzLA0KTGlhbmt1biBZYW5nDQo=

