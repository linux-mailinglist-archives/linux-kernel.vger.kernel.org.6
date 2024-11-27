Return-Path: <linux-kernel+bounces-423037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F181E9DA1B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 06:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8A32853A9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8B13E03A;
	Wed, 27 Nov 2024 05:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="O65QOrKd";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UEPrH4Nd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1F529CF2;
	Wed, 27 Nov 2024 05:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732685353; cv=fail; b=SBqecH9g1uSKmKcPBHOgefY4H4hV0AWC0OVK7oxSBjF6pGWpNEGkFUGmItBznxThFXRU5HAN5NfweoPm80q30jn7+JuImbhXhadEif6Wo9qQXeW920EC17o10EeGudFik6eO3o2nOYpMRFT7TIRjPviGq2j9isP2VMfXgpwexvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732685353; c=relaxed/simple;
	bh=td4fZ6ZcvF3iDqh20jIzSnRc4v9nNCOeqR/I96RYLAY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KOsxQCt/LDtNirC9FFMK5kbgRLs9rQjQ9482CkBj/DERWlWW2iC1jmFxGHSEv5CO3PWJA83cbIUeMfiX+VgstfJraSERWwpVOfFSqEPYFnJLIea8bA7S2P8VIDttC1sMABLeutpJlZRB7YhwtMQkoAMkBWMnGwaurse6PWkS2es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=O65QOrKd; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=UEPrH4Nd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 83e7d654ac8011ef99858b75a2457dd9-20241127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=td4fZ6ZcvF3iDqh20jIzSnRc4v9nNCOeqR/I96RYLAY=;
	b=O65QOrKd7E2NUiH129+qh+vrm8jZCjZ+7NoPia5n2zTdK5Gg0hAAXjJVf6pBbsw+bf1Ckpd8uOTSfq58eM6Tl/YvW6qtAY++RoXQuVjTyBXNu2PfLtWxu//iIfJ8j4e8YzjBS+zSHDIFchk2PlK+hr9TFp8rrdBtXjYUsZqwh+A=;
X-CID-CACHE: Type:Local,Time:202411271329+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:5a1cf92b-8bb8-4a32-b1df-37f7eda0011f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:0f5b9123-634f-4016-85ba-2d63e55c9400,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 83e7d654ac8011ef99858b75a2457dd9-20241127
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 507151500; Wed, 27 Nov 2024 13:29:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Nov 2024 13:29:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Nov 2024 13:29:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU//c2cSh6VeE1//aF1V0cSISH8EtmbgCCcWxiF+n5KRAOjxTxFXgUnEnbi5v4VSGjULyIs0jxiI9GMTKZhvom06ISsivThs5qcFjSzp3UqAJ7GsddKabqQB6SGG2EeU3hLv7OHTNJVlV1jxzQ00Xd6lNtVPb/b1tDp8VJbfI6WciqZvVD/kkac3+lxN27aKEYXmzjxxqG46xxZQhgqTlZiVwLGyCI2BwF25sPoUl7utzvJnnnfUvq/7WVJkdbc9pG4sf/8BizP4sDkfSIdVe0k1c61JO5t6awHBaorREU1xLtcEb5GHDsR8iETjvfBR4p7gG/GzcaA9eZXlXNfxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=td4fZ6ZcvF3iDqh20jIzSnRc4v9nNCOeqR/I96RYLAY=;
 b=oUzWkZ2SS+Wp8YExyZy7Ub9PIC0t2OzNfagXRIzqPl8DJ9sKsngIJkbMvblFpxGYdECmjcshVYXdQehUWKc4kyWJagdwzBMdi8cq9+bP6igorraq5dqz0H5/5JYZsy2whSPmwQKMoDg7dtP4VGQj/w+G3rFvUJxWQxWGJYBSLoCcGPGdtN3qwsIQ2f0krHoRiy4p0R9iTC3TfNPvYCgcJE+ovJ7BkmasQ7ni+OnC+79amxn7zwcH+EfTNyglQpqUu1el9vFMF/01HzfSsShDrghZVBB3J+L2i52/qaXH/09FJzrHGrbEqyi43bjJJ0mpKUfsthwDV0T9G0TNjprVmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=td4fZ6ZcvF3iDqh20jIzSnRc4v9nNCOeqR/I96RYLAY=;
 b=UEPrH4NdAblImAeHbZcsyOxFSri7bE3xUcRZLDDa4MpRirozx3WWslO1Sj2Ow+e5nY6qXTydFlO74iqkKwfKe275dM9ZGEMHiRrfdFbUNV5d5ViArZv0hxg57Vkea+RA1yw8j36hW4qMhUrkDZrU5NRnue+tjb804dR01hsZb1E=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PUZPR03MB7209.apcprd03.prod.outlook.com (2603:1096:301:110::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Wed, 27 Nov
 2024 05:28:59 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45%3]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 05:28:59 +0000
From: =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To: "broonie@kernel.org" <broonie@kernel.org>,
	"kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
	"tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"perex@perex.cz" <perex@perex.cz>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Nicolas Prado
	<nfraprado@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ASoC: mediatek: Check num_codecs is not zero to avoid
 panic during probe
Thread-Topic: [PATCH] ASoC: mediatek: Check num_codecs is not zero to avoid
 panic during probe
Thread-Index: AQHbQD9jxi5RGmij0U+kLG8n3GWEeLLKmgSA
Date: Wed, 27 Nov 2024 05:28:58 +0000
Message-ID: <ca99047569fe34f84cdf83cacb49cb047d5dc389.camel@mediatek.com>
References: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
In-Reply-To: <20241126-asoc-mtk-dummy-panic-v1-1-42d53e168d2e@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PUZPR03MB7209:EE_
x-ms-office365-filtering-correlation-id: 988d7fa9-b09b-4c4a-93f0-08dd0ea4651e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bEtOa2lBeEdiaklqaGhMY09Sd3NWRHlWRGhqZlE2dyt1WTZxdzk1QlpMVHpx?=
 =?utf-8?B?MkY4VnExQW5CMUVBeVNxOUlKWTBQL0ZVOWxYV0tsVnc2TVBxemZwNndtUTl0?=
 =?utf-8?B?eG1zSGFuMFp2R1NqVlQ3d0JXd3NOTHAzSDdJdUplYUdFdlVPRDNscUtpRUhU?=
 =?utf-8?B?TVowS0xld0FCY3FTcFJHOXkwcnhURHFldUZZcW1PemtUcTArUEhPNHREOHNo?=
 =?utf-8?B?a01NRzY1ZFNpUUZOWmNMd1RrUWVleE5xejl6cVNBZHlPRGVYcDFGVUxkN2JO?=
 =?utf-8?B?YUIxaEszelV0QTZEeVpCWHp3TVZ3enlXWTIyNUF2UzNYb3k5cDhrazNxM29k?=
 =?utf-8?B?WjRaT3BkdTd4VFoyY2lsL0pWM2lpR1FGTW5hbUlFQUZnVHladkdiSFV4ZkFC?=
 =?utf-8?B?S1hYbG5uZW01TWgxM0Z5M2JUKzJyaFRZai9EWGRPazBzMjY5eE1QV0JrMzJp?=
 =?utf-8?B?bDMwL1JYM2E0SzNjNTExZG9uZ3dOYkpqdU9aTE5WdVNjVHJFMUhhVTQ1N1Fx?=
 =?utf-8?B?TXRTQkFBWHFTQjVhMVVLbENncTUyTjFiL0ZKR0ZreENTV0duVnh5aVlxeEJi?=
 =?utf-8?B?QXVaR1dnUzBraTBFTWY4a05SSjlKVENQQithZ2ZkYWJmOGg4MUIyeW5kT1JB?=
 =?utf-8?B?MUxqcnBxZkVucE9FSytVcldpMmtmc1ZJSGpmUDVBbGswM1ZyTTByZTlFNUpR?=
 =?utf-8?B?aW1sVTQ0TFBFUklpaytvR0lDUUZNT1k4cGh3WTFoQzkvOGE2TjR5SlNhcGxS?=
 =?utf-8?B?WUZxZjBVSEVHTVcwNFRWYjM0Z3Mrdk1kU0w0TEtNZUtPVi91TFJGelRJUU5i?=
 =?utf-8?B?OTcrSkVGR1NSN3RKdmp6VkZhelNmTmZTZ1NMYzNaamJMcy9WeTg1RVFoYkRs?=
 =?utf-8?B?QU8yM2E1eU9RcE5YV1J6N2U3N3FoSStEUWxTbHlDb2pMNEVuQ3BSc1pzakxv?=
 =?utf-8?B?K3gxckcremh5U2JZMjdSakh2TzZua0haRTYzNnFUYUhFK29MKzdtY2FpUEQ5?=
 =?utf-8?B?T01UbTBiS0ZTckhlSTBwaUE0NElsT0laODhXQ05IQVJsS0ozMWUvV2pOZThL?=
 =?utf-8?B?dm1LQWh6RXVRaVNyQ0tlekpUQytDUzNkMHFOTW9EYWZDSVlNZ0NsbUp0S3F2?=
 =?utf-8?B?M083YVh2OEkycFFpdXEwMnNPVlZZZjNsS01vNTdVR3hyUnlWcnVLSkpsKzhW?=
 =?utf-8?B?cDMzVU1obkdRamlQM2RIbHlreHhHclBCL1NqV1JlalFDVUtLZEI5c2hKL2pv?=
 =?utf-8?B?VDd1N3VDU3d5bzcxcm5WLzZjVm1HL0FKcnBmZklmOGFWMGVmL3NaY0RHNmg1?=
 =?utf-8?B?UDBqd2FTc3hFUkRSWGFZdW9ybXVyaWxaUk5lYkY1cDlwS0FYOUQvWDhBczA0?=
 =?utf-8?B?VjE1bG5lakZMWk95ODdIdEhVZDEzVDhrOXFNYlJHS1F1VUFhNTIrcUg0WW9i?=
 =?utf-8?B?YXV4dVRidExJMEZZenBEVmlnNWFlUFcxK1M3aGZCUEdRc0E0TlkvSDFkT3Vm?=
 =?utf-8?B?aWRtZWhURitlN2E1QWs5VlVBMTVmTHA4QUFvV2xTRzNwQllLcWxZNDltSjdY?=
 =?utf-8?B?Y1gyelg5NDFHNDlRandYRWkvazZZTFRXcXQvamtaZEhoTzI4aEl1S2gzd2Np?=
 =?utf-8?B?QTRlZUNpZ3hEaHFuRklqV0tiN0VTcXlCYXlpS2tQVk1yanVkbzY2Sk9SL2RP?=
 =?utf-8?B?RlNuWVZuTEtFM1NFT2tOSXdsb1duSzRDN0ZJWUNwNGt1aWxINkFNNlp3YTky?=
 =?utf-8?B?NEczMGJ1bTlGMGpqV3diRVFBSmJMTXlqQzlPZWVPNzFSZXpGZ1N0bjM2eWFk?=
 =?utf-8?B?TXQ4QzFnSEJITDR5UCtPcm5zOVZUTEc5ZFBCZ0ZVU09pVDdEN3pCbXp6aVkr?=
 =?utf-8?B?KzJheUMwS25WbW5HNjVHUElwaVYybUtEc3IvSWpKU1F1clE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eng5bXhKeUFYRkpnWlNxTnJNRzYycXo3Ti9PaUYxWU1ERjFMdnBRSjJtRUsw?=
 =?utf-8?B?M0cwN0wwVUpHSlhEcmVGK0w4MGYrSk54WHZQMWtJeWFkcVRVSEpwc0xKWkEz?=
 =?utf-8?B?N1ZZSlAwWVJjZDJPTTRjWk5zRi9NTWYxazJIVkZyWGQ1TUUrbVBuendYR243?=
 =?utf-8?B?Tk1xeDJveDFBK0JGUTJZT2RyOEM5SFlBdm1OTmVVSEIzT3hzak5GMzYwZ3Vr?=
 =?utf-8?B?a01PY25EMFd6MmlHcG5DM0ttU21kcGR4NWZqR3phTnBMc21WTzU1ajZxaXpy?=
 =?utf-8?B?TndyY0VUd0RQcGtkckJqY3lrSk5MbVo3R2pJN1FyaUxiM09zL2FDN0dNelNS?=
 =?utf-8?B?SkxKZHpvN2d2WTVsVUs4eUQrNVVSYktRREI2ZGRudGxnN0RVMkp6VCtnRGZt?=
 =?utf-8?B?akVFWjE3TWdsQXNPc3RvMVhPdnBLZ0FmUlBQcGRkQXhScUlLL2ErT2hRbGJ1?=
 =?utf-8?B?T25BUk84Sng5ejhJMmxVRU1GVXl1YkFmcFdNYW5lWmZPaWlCbk55L1l2eXor?=
 =?utf-8?B?QktKNWN6Z2ppS3E5UU9vSTZtU1BIanlWU2dBdy95Wm1NUEx0S3BEaDE0OG1V?=
 =?utf-8?B?aGJOTTkvSDAwdjBSVW5kVjVVVHVrTlVrOTZ6YU5waE9UZDNua0pKamlaeUJG?=
 =?utf-8?B?Um5kbzBQcThMdEpjK3M3MmFGWlovcUVHa0JuRU1BS2lqM3JzN1YwOWZqMm1L?=
 =?utf-8?B?aFdYZ1RLZGxCd3grdXh6cUFsR1FtRUNFMUJ5d1ZFUDFtZnV1cUVQNHp5bmp1?=
 =?utf-8?B?VlIxQW5KeXU5QTdSbWE0Z3U2VWN3SW5HU00vRGJBbnpyRXUyTW4vS2pXaG0z?=
 =?utf-8?B?U1BhU2ozd3d1MC9LOVk0N0VSNlo3VVZhRDhQNVdtbk05WDNHbFVkYTVKWkVr?=
 =?utf-8?B?VnZCOHpGUGxNVWV4bDlURmp5VlJiUkUrRVZBeGowMHlwWjNtRmJadWxJdWlK?=
 =?utf-8?B?bUdWckJDUFJVTUtwRmhVQmE0U0tNRVM1ZGdyeGRldXY0cXRkbnB4aG92Njht?=
 =?utf-8?B?dHM3RkpUZnZZR0NxcENDb2tBVlVCbnhLWWxKNUViMjRwRDhLM3RBS2dlUkFO?=
 =?utf-8?B?RmlhMHhHNU5ZeDBkWkRWUUs5Y1hQdGs0VUI5YUJIRWxaTmszd0gzeDIxcDJ2?=
 =?utf-8?B?SHZHWjlNM0YwRXhJck1ibFlqbEFLbkZHRWtOSGJjSUlSWWpjWDZxU0toRmwy?=
 =?utf-8?B?ZkU4ZVgzeE9Yc0MxbEh3d2FReElYcVU0c3FjcHRUSjN0b1BzYkMrMEx0TjB2?=
 =?utf-8?B?NFNTZHBCK1VIcG9PczB4Vk94UDQvTi9vMUtsWnB2Y0JZblZkcnQzbXVQSlZW?=
 =?utf-8?B?RGkyblE3elA3Uk13aVdDcTdpV1lOckIwS1JqcmZaVXliM2xMb1EzSkRrVVVy?=
 =?utf-8?B?TXRIeDh1bEtNaVZSNEw2d3VNWFdDTE5zR0tId1BxY1VXZTZESGdHaGlydHBS?=
 =?utf-8?B?czRsZXV6enVKYVRBVEdVMXduYlIrQzd2VlRVNWh5eUgrUzRCN0xhZXJwQlk1?=
 =?utf-8?B?VHBJWG5pNjRRV0pqdDdYaDJFWitxUUFuanpqMktPMzZKclBTNEZCZFF0SHhF?=
 =?utf-8?B?d1FKajk0RGJmbitnV0MwbU9CZ3J6VDdWT3RPZTBMMTc1WTZ4dldmdFdRMy95?=
 =?utf-8?B?d3NpOU9VS3AzcjczdHJJcTdId0NEOEVmTUhWTXQzYkt5aDRhNHdFTExzL3RC?=
 =?utf-8?B?Yk54cmJBNnFJR0hHdTdKYVhwMjB3SW1QWGUxMHFRaXluZFdCM1BtUUJRQU5i?=
 =?utf-8?B?dE5zOHRHOU95QnNqTU9xRVd5cDVGUC9KSVZsMUw2bXkzUE12Z0ZWUUlCU1VG?=
 =?utf-8?B?THVKdzg4VFRJdU82NWc0WjZ2RS9hcm4zZFlwSzJ3bWJWcnlNckFYWE1jQ0lp?=
 =?utf-8?B?a2pFSitXMWNlcmFVdzFrTlF0b2xzckNDK3JZTk11eTdJRDhXVlRrbHZrZWRj?=
 =?utf-8?B?endvRS94TFRLOTY4cU55dzZWZWxjUnI2aW1tT3hZWjA4TDJGdzBWL2owd2ZZ?=
 =?utf-8?B?U29abDJHeHRvZzU5K1Y3RDladW85VDRJOXNQdUVWWTU2bkN5cWxlUHVLUnVZ?=
 =?utf-8?B?YXVpK3dLcmU4QWdkcDh2WWl4ZENjbGdCRzVUZlRJNS9XWFhXWXBVY3YzOWRh?=
 =?utf-8?B?WDY1TVcrMll5ZkhWYzk0cXRBdWQ1c0c4eEU0d0tkWHowNEZTZG9tL3VLVkhE?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68652EB80D58DD4FA61790BB6787AEDB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 988d7fa9-b09b-4c4a-93f0-08dd0ea4651e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 05:28:58.9916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m9B7KqevWnoz2E6deA2tokcAtkVrYlpX6pIGobUclShAPduC6pi2Ra4ZwrGaQLxJV74QJhGNPWNXFwakahMD5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7209
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--10.269100-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4ia1MaKuob8PofZV/2Xa0cIIterBLifhMqLm
	LbzRUpVMVfdTZSxs6z8nFy5SLMvpg6uoPPwoczeXVHX1qbz1ZDVWjiXAsVR2K2w5MzY8NEdNTi/
	uoCPIud3OFmdnvCTbarZw9vnTcI8gzmzAbkmfyS7J5W6OZe5hhTAKasuXH5J1Bm9f7S94IJyg+J
	Q+OUb09wrAUSpEyXmTSr5xfaOZ+q/IfDCeda5aa0hwlOfYeSqx4+ZcrqvCDkEPvK4rRmOPuZ6KJ
	FezorzrE9f6QQApgVp3EG58Ar3aQhgHZ8655DOP0gVVXNgaM0pZDL1gLmoa/PoA9r2LThYYKrau
	Xd3MZDWXf5sC39gVVDgGDDVHNfoxVJbxIWFviaGrXK72VRJuhkoYOq5ukC9dS4W/MRhJ1X4=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.269100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	067DCC38958F1F7CF3C35AE0071C3EF0BD62C6E26169BED5ACD66134C21ABCD22000:8
X-MTK: N

T24gVHVlLCAyMDI0LTExLTI2IGF0IDE1OjA5IC0wNTAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFk
byB3cm90ZToNCg0KPiANCj4gRm9sbG93aW5nIGNvbW1pdCAxM2Y1ODI2N2NkYTMgKCJBU29DOiBz
b2MuaDogZG9uJ3QgY3JlYXRlIGR1bW15DQo+IENvbXBvbmVudCB2aWEgQ09NUF9EVU1NWSgpIiks
IENPTVBfRFVNTVkoKSBiZWNhbWUgYW4gYXJyYXkgd2l0aCB6ZXJvDQo+IGxlbmd0aCwgYW5kIG9u
bHkgZ2V0cyBwb3B1bGF0ZWQgd2l0aCB0aGUgZHVtbXkgc3RydWN0IGFmdGVyIHRoZSBjYXJkDQo+
IGlzDQo+IHJlZ2lzdGVyZWQuIFNpbmNlIHRoZSBzb3VuZCBjYXJkIGRyaXZlcidzIHByb2JlIGhh
cHBlbnMgYmVmb3JlIHRoZQ0KPiBjYXJkDQo+IHJlZ2lzdHJhdGlvbiwgYWNjZXNzaW5nIGFueSBv
ZiB0aGUgbWVtYmVycyBvZiBhIGR1bW15IGNvbXBvbmVudA0KPiBkdXJpbmcNCj4gcHJvYmUgd2ls
bCByZXN1bHQgaW4gdW5kZWZpbmVkIGJlaGF2aW9yLg0KPiANCj4gVGhpcyBjYW4gYmUgb2JzZXJ2
ZWQgaW4gdGhlIG10ODE4OCBhbmQgbXQ4MTk1IG1hY2hpbmUgc291bmQgZHJpdmVycy4NCj4gQnkN
Cj4gb21pdHRpbmcgYSBkYWkgbGluayBzdWJub2RlIGluIHRoZSBzb3VuZCBjYXJkJ3Mgbm9kZSBp
biB0aGUNCj4gRGV2aWNldHJlZSwNCj4gdGhlIGRlZmF1bHQgdW5pbml0aWFsaXplZCBkdW1teSBj
b2RlYyBpcyB1c2VkLCBhbmQgd2hlbiBpdHMgZGFpX25hbWUNCj4gcG9pbnRlciBnZXRzIHBhc3Nl
ZCB0byBzdHJjbXAoKSBpdCByZXN1bHRzIGluIGEgbnVsbCBwb2ludGVyDQo+IGRlcmVmZXJlbmNl
DQo+IGFuZCBhIGtlcm5lbCBwYW5pYy4NCj4gDQo+IEluIGFkZGl0aW9uIHRvIHRoYXQsIHNldF9j
YXJkX2NvZGVjX2luZm8oKSBpbiB0aGUgZ2VuZXJpYyBoZWxwZXJzDQo+IGZpbGUsDQo+IG10ay1z
b3VuZGNhcmQtZHJpdmVyLmMsIHdpbGwgcG9wdWxhdGUgYSBkYWkgbGluayB3aXRoIGEgZHVtbXkg
Y29kZWMNCj4gd2hlbg0KPiBhIGRhaSBsaW5rIG5vZGUgaXMgcHJlc2VudCBpbiBEVCBidXQgd2l0
aCBubyBjb2RlYyBwcm9wZXJ0eS4NCj4gDQo+IFRoZSByZXN1bHQgaXMgdGhhdCBhdCBwcm9iZSB0
aW1lLCBhIGR1bW15IGNvZGVjIGNhbiBlaXRoZXIgYmUNCj4gdW5pbml0aWFsaXplZCB3aXRoIG51
bV9jb2RlY3MgPSAwLCBvciBiZSBhbiBpbml0aWFsaXplZCBkdW1teSBjb2RlYywNCj4gd2l0aCBu
dW1fY29kZWNzID0gMSBhbmQgZGFpX25hbWUgPSAic25kLXNvYy1kdW1teS1kYWkiLiBJbiBvcmRl
ciB0bw0KPiBhY2NvbW1vZGF0ZSBmb3IgYm90aCBzaXR1YXRpb25zLCBjaGVjayB0aGF0IG51bV9j
b2RlY3MgaXMgbm90IHplcm8NCj4gYmVmb3JlIGFjY2Vzc2luZyB0aGUgY29kZWNzJyBmaWVsZHMg
YnV0IHN0aWxsIGNoZWNrIGZvciB0aGUgY29kZWMncw0KPiBkYWkNCj4gbmFtZSBhZ2FpbnN0ICJz
bmQtc29jLWR1bW15LWRhaSIgYXMgbmVlZGVkLg0KPiANCj4gV2hpbGUgYXQgaXQsIGFsc28gZHJv
cCB0aGUgY2hlY2sgdGhhdCBkYWlfbmFtZSBpcyBub3QgbnVsbCBpbiB0aGUNCj4gbXQ4MTkyDQo+
IGRyaXZlciwgaW50cm9kdWNlZCBpbiBjb21taXQgNGQ0ZTFiNjMxOWU1ICgiQVNvQzogbWVkaWF0
ZWs6IG10ODE5MjoNCj4gQ2hlY2sgZXhpc3RlbmNlIG9mIGRhaV9uYW1lIGJlZm9yZSBkZXJlZmVy
ZW5jaW5nIiksIGFzIGl0IGlzIGFjdHVhbGx5DQo+IHJlZHVuZGFudCBnaXZlbiB0aGUgcHJlY2Vk
aW5nIG51bV9jb2RlY3MgIT0gMCBjaGVjay4NCj4gDQo+IEZpeGVzOiAxM2Y1ODI2N2NkYTMgKCJB
U29DOiBzb2MuaDogZG9uJ3QgY3JlYXRlIGR1bW15IENvbXBvbmVudCB2aWENCj4gQ09NUF9EVU1N
WSgpIikNCj4gU2lnbmVkLW9mZi1ieTogTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gPG5mcmFwcmFk
b0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gDQoNCkFja2VkLWJ5OiBUcmV2b3IgV3UgPHRyZXZv
ci53dUBtZWRpYXRlay5jb20+DQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLg0KDQoNClRoYW5r
cywNClRyZXZvcg0K

