Return-Path: <linux-kernel+bounces-570606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA42A6B276
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 02:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC667B020B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D6B26AE4;
	Fri, 21 Mar 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mU0BhHdU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SOMlOz0V"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B3C13B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518797; cv=fail; b=aOpuyGNcOhpRX6nyUHPU5GTJeNGUWVUByumPl6zUP25rTv+T1lwY8K57PykuB2Hxfh+wq1RzULuhPsXJXXTA+j8HiZodfGPfUCeax2WLHM8KS2WBLYOe8EREXYBR4Q2Z5I/G57MHe2fivJVCkg3XYftz7OEj+Iq0zjGSvqQEKjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518797; c=relaxed/simple;
	bh=6Lw9Di5QkZcLVGY5sOXNgmZTLuIdzwp7jkgMPBsFobo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lYrktXoYzFN1PGGDvJhcnS8BVz9OJgJmF3xMnROngfBoan2MqXqdOaHvrHCT8ef+/yEZVecb5LGPEJ11fXIhw5Fz9nKRhgAAFvVsG9NUHwOE/Q7K2IYza2ZQ2BzIdSLDXgxYSj966Jti1OLMY5VbzQYaJ47ou4ZM5io0PjavQEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mU0BhHdU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SOMlOz0V; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ca784a5e05ef11f0aae1fd9735fae912-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6Lw9Di5QkZcLVGY5sOXNgmZTLuIdzwp7jkgMPBsFobo=;
	b=mU0BhHdUsLv/CdAphLHNU3aqLIJ6dhCmyTK7xLi4S3rCIWq7mNc+8EuzkCu2q08p8quABt2IUCza1J/OpBJx+b1cdf25YewM/7NHSXScIx3zZ9H0e5yw99KSqsYW5V25eSlChlowx1WxGthLJmg4o5y5q8hj5BvvnSZf1zQEihk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:fffadbf5-ed9b-468a-a1da-d697209954e5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:a8ea5f4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ca784a5e05ef11f0aae1fd9735fae912-20250321
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1015579925; Fri, 21 Mar 2025 08:59:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 08:59:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 08:59:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBGPxSxbOt3uFT7TyzYvbJmMl2ty1M0LTc+CcDe0UlmFYxAID+VpnEkPD9U1jjW/HwqjjGwHSrJZuoL9yTIKydpKnMK8JC7ADMqJ7H74b4FSGnCPCDGfp4XjzcQUUrzPQdJKH2KCyDPEGNdOIUa4gEkxHqAjcCs3tnlCfJ3jcAAEeZE+pWoWFEg11tDFLR67G/g3zFUPF1/YeRlBdcjU8g2WGbb05slOVZZzTbkzz9zWdxwwNEYbglFh24DLqC8f/aUyGpkndFIBaYDdJAtGo3xtT8wALgUsZ1OVijpPLlegPEjFKXnGQIaM+slXmuokP9DK6M6aL1VH8rrykMQwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Lw9Di5QkZcLVGY5sOXNgmZTLuIdzwp7jkgMPBsFobo=;
 b=o0VRxCSo/njA6NM6XxDjFeRWGGm3y19WJ6Kye40TqOTbzwRCFpGRNciKAa+DkLY8NMWI9JCrvVXrNPp+7uySxONBUpgC+PKW1Sf68UHeDBlZwjhxLtfA8bYWqW6pbe9DHMOdJfGaI6wBTUlPmv9HI6R8PhAk1oaC7WZ1kXnjV3VD6ydoFvrUHdKcxq6C4mI8umB4BBZ2a4CWU+jpYf3k5xpnD1nUPW3IZlq1Y552uFG6hHA+kwv0qzDMPja/Qi0hXsemks3CKK8dNlmW8tNeFI+gZtaYSVAT+0s4yrUez7eFHhRViULZpCYEJd70jhcVMQnNjRqvJxwlxrM/s5TDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Lw9Di5QkZcLVGY5sOXNgmZTLuIdzwp7jkgMPBsFobo=;
 b=SOMlOz0Vkfy2rey0CWFt25oWIZJRZXdg3J8nEsNe6wkgkFrSjpMjFVqx4zV6d4snl3czSSezhtT9Kj1STt/sxy6NcosKaus6djrsaea9ncrYYS1P9f/U/HXQrbK6ZVj7MuzVwW1LEU62vbh+j5oktzA3yomlWps1UJrVIXJgf5A=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8468.apcprd03.prod.outlook.com (2603:1096:405:5e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Fri, 21 Mar
 2025 00:59:47 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%2]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 00:59:46 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "simona@ffwll.ch" <simona@ffwll.ch>, "Alexandre
 Mergnat" <amergnat@baylibre.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"quic_jesszhan@quicinc.com" <quic_jesszhan@quicinc.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "mripard@kernel.org"
	<mripard@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"will@kernel.org" <will@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 3/3] drm/mediatek: dsi: remove custom init part
Thread-Topic: [PATCH v8 3/3] drm/mediatek: dsi: remove custom init part
Thread-Index: AQHbmXUMZc0GgT5T6ECKxZWIeMyAiLN8xiiA
Date: Fri, 21 Mar 2025 00:59:46 +0000
Message-ID: <c0f31248f8ea936147445d92f7e39d93f5d47c35.camel@mediatek.com>
References: <20231023-display-support-v8-0-c2dd7b0fb2bd@baylibre.com>
	 <20231023-display-support-v8-3-c2dd7b0fb2bd@baylibre.com>
In-Reply-To: <20231023-display-support-v8-3-c2dd7b0fb2bd@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8468:EE_
x-ms-office365-filtering-correlation-id: 3d6347a8-13fb-4482-b993-08dd6813acc1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2tBRnk5aVZET3hEQnNURm5xOXpqYVBsWVJiOHNjVC90UXBMNFZxS2VLQTBk?=
 =?utf-8?B?NjJRWU9PbXIvOE1EallIZHY5aGFYRUNhZGkxbzMwcnpHb1JhMWtQWjR5ZDNj?=
 =?utf-8?B?R2JNVjRDVE9pZkVGVjRDZ3MyQzVkdXMvZjhKbHN0L0gxWEQ4WFJydTNhb1pG?=
 =?utf-8?B?R3NvaWxtOEZQQ1lZM3dUajZRcjQ0Y0QyeFJQWUlBZUh5WC9kYkFpeUJtS1Jh?=
 =?utf-8?B?QzRmQi9KOFNJN0FGTHltaG9PL1BZd1U3UmhBcEp2UFpvdGVXaEFtUWFLV3Zt?=
 =?utf-8?B?d2QvbnFoZTZ1M0J5OVFlUyt4RGJhMEs3WUJpckNLUXh2TlY0dXp0cEdlWTVu?=
 =?utf-8?B?cC81ZHdlaUF6RGRkWkNXbDJyQ0NaeUVPeGFmSU5YQS9pSFZRQXUwOXFMK3dx?=
 =?utf-8?B?RnltTG12U29hRVpHdlA4T214WWs3K01IMlZJdy9PN293V3BzTFV0YUxxeHlV?=
 =?utf-8?B?V1BJU3dvamw2UGhTekY4TTB2L0d5Z2NqRFNTb2pMSlU2VW44ZXRBTmRpa3dK?=
 =?utf-8?B?RnlHdVhlTEQ4V2FsVG9EMWRqeGg4OTVuKzhYQlcvNjVId2p6T0VhVTNodzhC?=
 =?utf-8?B?OGk0ZUlhU2F3Z28zY1lnY0RudDdoL0NuU3dqK0tYVkNwa2ZnZnFmRVNCMUl1?=
 =?utf-8?B?TEhVUEd4Vlgrd1B0L01lSEg4NjBKb2RJV1BSM3gxeUNIOXpEajZVSVFUTWVw?=
 =?utf-8?B?MmNiNDZSN0lQL3MwSkwxbWR0UitCNGlkZ1Z0UG9ON0tSVWRnaW9STWZMZjZZ?=
 =?utf-8?B?WnV5aDEvOVl6RWVLdWhURlZGNUNldWdoZUxSdnJMVFIwanV0RER0Wml4cGFu?=
 =?utf-8?B?amQ5cis1S1lCcFByL1UvdXpRd09nVm5OWU5HTU16Umt4ZWxNeHFaNXJCa2hL?=
 =?utf-8?B?NCsrM3BrTVp6Ynp3aDdPMEMrZkVBQkdCenpEOGxXUDUrckREdEFNQy96bk1I?=
 =?utf-8?B?TS9Za3VMY3dRL1hDVVAvYUN1dXZ2ekJEbWh6KzhqZ043ZWd3bXpsaXFQNi95?=
 =?utf-8?B?eGJ1NEl1cm5OZE9hc001MlExRXh4aWF1Nkkva2JLVXhOUVd6RTN1ZnhCUzRn?=
 =?utf-8?B?a2ViR0lRT09UMmkrS1BXeDdjYlFGMjFmcGNadXp3WGFEOEIwK0tFVHJYcjBM?=
 =?utf-8?B?SlcxMXhNWTJqS2IyT291Ym83aS9NQ0QrdHhVc0pZc1VFbGczcnNtMzBJeTBS?=
 =?utf-8?B?aHhmQ21OQlkyMHFSdUUzaHZEVUpxV0YyUFphZCtNMWRtZXZOellEeEcwSmN6?=
 =?utf-8?B?ZmhGK3kzUDVoU054OHdvL2RsVWFSa2Vla0lQNFYwR3EyWHB0NEpTV2FYZkRq?=
 =?utf-8?B?Vmh1T3E4bFFzQVliUUg3WjZYaTlpakMrYi9UWVRiOWhMbGVVci9FSHM3U1V4?=
 =?utf-8?B?aEpZLy9wZUdiWVQ5VjZZYnMrYjllb0d5aFY1a3dsTGszeXgvNStUeTZSdHdi?=
 =?utf-8?B?NEw2RTY1SGF2enNjSFBaeWVVVFZ5KzV5VHp6cFhUY2Vwc2h2eVQ5MFJpaW9p?=
 =?utf-8?B?SThqOFc2cEhsbkpnL1MySk1YdkpmbTJmdkRDY3Rwbys3Wld5cnYrUFVxVDhN?=
 =?utf-8?B?M0NTcmNGbitRNHFiQnl4c0I2THdJK0RLbTc1anJ3ZjFCS3ZCVmtuZ0wzUTBz?=
 =?utf-8?B?REt0aytOYmRvbzJyNUJNNjdJMndYSS9mRVhtU3VkdlNNd0lHMENZQUYxU1JD?=
 =?utf-8?B?VkJDQTFCSThuaXo5Wk0yclNacytZbm81NEhTWTlkbEl0UW05c3p3c285M05R?=
 =?utf-8?B?Q0M1cnU5bWc1TnhQYkZUTktGZzV1bmtqZU53KytwMVNCaHpZSUJkZmFRT0RJ?=
 =?utf-8?B?bnQ3MzRKODB6UldCeG1SNmVscDRDK3phaWpZK2djaUM5UnNUMHpMOEtXR1Bl?=
 =?utf-8?B?R2RVNDZOV2VZdXk1YmhlREl5Nm1ETWJaUXRrRFRMNnFZYUxPUlVOcXl5RHVP?=
 =?utf-8?B?VXV3czZ6UUhWRjhTd2oxR1VBcHhrR1d3Z1NKbC8xQ3owMTFyU2U2ZWRRY1BM?=
 =?utf-8?Q?WX+4Uw6WbCvU2T2af6TNt6zpfS089I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3UzRFVTNGk5YXpST0F5QmVKdGV4c0xHL2xTdnB1eEc5UnNHb0s0UGYzUXVP?=
 =?utf-8?B?YkZrbVdhOU9rK0ozUFo4UkEzQmxjZ25hTVFwcHZidzhBQU1mL2hwSktzOWow?=
 =?utf-8?B?ajNNeW5QNFhReDNCSFM2VXJNVnptQzZtVmtWamRtdzJ2Z25kVlZ5ZXpUb2NS?=
 =?utf-8?B?NjY1ZmxCTHNDRHZLRnlUQisrcFpFVmQ3LzlSK2gyYUhFZnBOWVlHbm5OOEE0?=
 =?utf-8?B?djluakNtV0x0dit6NDk2OVB0VzZ3Zi9va3g5d3JjcDVnWnJPcFduWVM1THVR?=
 =?utf-8?B?dDVlVGk0TGRlOHN3M3hwZEpGN0lHTnlmblFETks1OXdnY1dmRWRCbi9pazVF?=
 =?utf-8?B?M240ZEphanQ4UkY2aFZ1ZzQrSEhJejZVNEJwMlVMcDBBaUdvYmFDMWwxWXNQ?=
 =?utf-8?B?cy9ra2VsajRHTUZaQksrOVJoM0Qyamw5d2VvQ2Y3OWUzaHZqOUF3WWs4KzVT?=
 =?utf-8?B?Ump5MmlZckVvV2hYaDlORmkzUUVhVUYzYnFyS3NGV1dKWkQ5c1hRempuMk9t?=
 =?utf-8?B?anAxOWVQbmtYMGRVaC8xYTRmRWkzMGdBMFZVRXh5L0lTbTkrb2hQc2p1b2du?=
 =?utf-8?B?bWtGTHVFVGxJM2oyU1ZUNFlFU01uc1hva1A3Y0FPOWhIMFYxempXUy94MnAz?=
 =?utf-8?B?emcyVmNsUHpOaWtoa1Nzd3RIN1ozZ21ZbVBDSWZDSlBETmg0K3NUS0ZtQmdm?=
 =?utf-8?B?VnJqOHNmM1p4MHJTb1BxMC82NnZVMWtGMCtYWXVLak9EODJVZmphOU5xZmJk?=
 =?utf-8?B?NzZJbFdaYWJuTlM2RXluSzhrbVI0SEpjV0NQeGZqY0g4eHJqYkNuMmlrTVZ3?=
 =?utf-8?B?OXA0R3RkeFdDd3IxMGJ3blAxS1I3WGU2T0JPOVBHd1JsVE1WbnFTZHMyNDkz?=
 =?utf-8?B?VHV1cXdDR1ZkTFdNSU1xMzdaRENWa3Jab2xOSW5HL2J6T080ZjBhdlE1SXpF?=
 =?utf-8?B?OGtHcnlUb2lFYkNKbDRVQSttZVNDejVsYnR6NS94TlIvd3JGREliWWZoT3RI?=
 =?utf-8?B?WFFKUkt6QnoxZzc4WUdHaWMzaXBncEtWbUs1YmVOalNhckVvdWcwVmM0eDRH?=
 =?utf-8?B?ZVNwSHZoeitlVWVzZHFWNlByRzk0dDN1Z21kazh6RFZqSXlhVzdET29ib29U?=
 =?utf-8?B?eVBpL3FGRFhZTzFjWERhVHNlR0tyRitXMTZhSU1lTzRmU2Q2cVNXZjNnU3FO?=
 =?utf-8?B?R2dJcnF0TVNpcjR6WU11K0ZFR1NnTkMxYzFPMGVHWFAzMUtqWFZvR253cHFU?=
 =?utf-8?B?WDhQK2I0SHNoRVh3eTBDTmhmWW9aS2ljYW5uN2xoWjBqZVdydUR5Q1pMeEdS?=
 =?utf-8?B?KzhOUkh4R1RNbDBBbEVxTTBuYURpVVJDYW4xbmtNMkFORXJub2JyU1d1ZUdw?=
 =?utf-8?B?S0pxV21ySWRjckZhYXlKRHFoOXVDaEtjTFd0aE84c0tBSmJNUlVPb2NrZGIr?=
 =?utf-8?B?T2k2dzIydkU5MDBKdWFQZGRVdk9NMU5HTmdTMXg4OFZqcDlrWVdGRFErMEti?=
 =?utf-8?B?RVdMZk1tYVhVMlZBYUttL0hJV1h3ays5MnNZUGVXZnhaNUxxbnplc2NraDIr?=
 =?utf-8?B?MEJXT1VWZFo0ejhHZk50bjRFRlhqOEVjazZlMDNSZTF3b3pyRW84Q0xRRVp6?=
 =?utf-8?B?QnJpY0ZreTRmRDRUT2J5N2NJbGl6Zzc4QmsxaWVoU2hsakNJcXVGRnZHdzZ2?=
 =?utf-8?B?QW4zdlRVaUp5QTR1S0pBRkFMUk81TjcrakEvenlnMkNhTDBVSy9HSW43bHQ0?=
 =?utf-8?B?ZDg3TTcvMllOTWtpMkRBeTIvaGNYaTN2TVZ4Q2U1QXVDQXpxTVNLbm80YzI1?=
 =?utf-8?B?L0ZPM2hpaXpuN2NscWtSNkhCTW1qb20rM3J6TkE0RVpHdWxOT2FKa3JDNzU3?=
 =?utf-8?B?VnZIUlZyWnFMbWFDWUN3Ri85bzJNMnczSHVocGFkaU5WNE5ITnFPaERyTGRx?=
 =?utf-8?B?MkQxVGNweHhxZG91cGVSdVk4aTZlUm5ySVB2OVNPMDZIY0lOMWw4WTJBbXNk?=
 =?utf-8?B?QVdDWkFUMlJLdEo1OUVSTisvbjg4WWtSMUhTUEgyaFlFRWNKcUpsTVNGM21x?=
 =?utf-8?B?ZXpQV1NKcTc5Q0lpeDMxbXgxa0l6Vmx4VDRVNmhVdVJERHBUczY3QlBYejgw?=
 =?utf-8?Q?nf/MtbhbdHnyvxE7rTK7tGKI9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <210B9A67559D0946A432295530085F81@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6347a8-13fb-4482-b993-08dd6813acc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 00:59:46.8253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DUwV5+VGD3CjJTiYE7R851N63C0QTJn5TyQF0NJJ84p3YOoXeyu4kkfEWMa4Feu8yVEXIKl7goEJmNjH232ZAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8468

T24gVGh1LCAyMDI1LTAzLTIwIGF0IDA5OjQ4ICswMTAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29u
dGVudC4NCj4gDQo+IA0KPiBUbyBiZSBhbGlnbmVkIHdpdGggdGhlIERSTSBmcmFtZXdvcmsgYW5k
IGF2b2lkIERTSSBwb3dlciBiZWluZyBkcml2ZW4NCj4gYnkgdHdvIGRpZmZlcmVudCBlbnRpdGll
cywgcmVtb3ZlIHRoZSBjdXN0b20gZnVuY3Rpb24gYW5kIGtlZXAgdGhlIERSTQ0KPiBBUEkgdG8g
aW5pdGlhbGl6ZSB0aGUgRFNJLg0KDQpJbiBNVDgxNzMsIG5lZWQgdGhpcyBjdXN0b20gaW5pdCBz
byBkc2kgY291bGQgd29yayBjb3JyZWN0bHkuDQpJJ20gbm90IHN1cmUgaXQncyBzb2Z0d2FyZSBw
cm9ibGVtIG9yIGhhcmR3YXJlIHByb2JsZW0uDQpJZiBpdCdzIGhhcmR3YXJlIHByb2JsZW0sIHRo
aXMgY3VzdG9tIGluaXQgY291bGQgbm90IGJlIHJlbW92ZWQuDQpJZiBpdCdzIHNvZnR3YXJlIHBy
b2JsZW0sIGl0IG1heSBiZSBmaXhlZCBpbiBjdXJyZW50IHZlcnNpb24uDQpCdXQgSSBkb24ndCBr
bm93IGl0J3MgZml4ZWQgb3Igbm90Lg0KU28gSSBuZWVkIHNvbWVvbmUgdG8gdGVzdCB0aGlzIHBh
dGNoIGluIE1UODE3MyBwbGF0Zm9ybS4NCk90aGVyd2lzZSwgSSBjb3VsZCBub3QgYXBwbHkgdGhp
cyBwYXRjaC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRy
ZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jIHwgIDIgLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9kcnYuaCB8ICAyIC0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RzaS5jICAgICAgfCAxNiAtLS0tLS0tLS0tLS0tLS0tDQo+ICAzIGZpbGVzIGNoYW5n
ZWQsIDIwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRw
X2NvbXAuYw0KPiBpbmRleCBlZGM2NDE3NjM5ZTY0Li5kODZlZWQwZDI3OWQzIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+IEBAIC0zMTcsOCArMzE3LDYg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX2RzYyA9IHsNCj4g
IH07DQo+IA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX2Rz
aSA9IHsNCj4gLSAgICAgICAuc3RhcnQgPSBtdGtfZHNpX2RkcF9zdGFydCwNCj4gLSAgICAgICAu
c3RvcCA9IG10a19kc2lfZGRwX3N0b3AsDQo+ICAgICAgICAgLmVuY29kZXJfaW5kZXggPSBtdGtf
ZHNpX2VuY29kZXJfaW5kZXgsDQo+ICB9Ow0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9kcnYuaA0KPiBpbmRleCAwNDIxN2EzNjkzOWNkLi41NjU3ODU0ZmEyZjllIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC00Nyw4ICs0
Nyw2IEBAIHZvaWQgbXRrX2RwaV9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdm9pZCBt
dGtfZHBpX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHVuc2lnbmVkIGludCBtdGtfZHBp
X2VuY29kZXJfaW5kZXgoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gDQo+IC12b2lkIG10a19kc2lf
ZGRwX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldik7DQo+IC12b2lkIG10a19kc2lfZGRwX3N0b3Ao
c3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHVuc2lnbmVkIGludCBtdGtfZHNpX2VuY29kZXJfaW5k
ZXgoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gDQo+ICBpbnQgbXRrX2dhbW1hX2Nsa19lbmFibGUo
c3RydWN0IGRldmljZSAqZGV2KTsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+IGlu
ZGV4IGU2MWI5YmM2OGU5YTMuLmI4MTNiNDkzNDA0MjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kc2kuYw0KPiBAQCAtNzg3LDcgKzc4Nyw2IEBAIHN0YXRpYyB2b2lkIG10a19vdXRw
dXRfZHNpX2VuYWJsZShzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgew0KPiAgICAgICAgIGlmIChk
c2ktPmVuYWJsZWQpDQo+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+IC0NCj4gICAgICAgICBt
dGtfZHNpX2xhbmVfcmVhZHkoZHNpKTsNCj4gICAgICAgICBtdGtfZHNpX3NldF9tb2RlKGRzaSk7
DQo+ICAgICAgICAgbXRrX2RzaV9jbGtfaHNfbW9kZShkc2ksIDEpOw0KPiBAQCAtODkzLDIwICs4
OTIsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgbXRrX2RzaV9icmlk
Z2VfZnVuY3MgPSB7DQo+ICAgICAgICAgLm1vZGVfc2V0ID0gbXRrX2RzaV9icmlkZ2VfbW9kZV9z
ZXQsDQo+ICB9Ow0KPiANCj4gLXZvaWQgbXRrX2RzaV9kZHBfc3RhcnQoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiAtew0KPiAtICAgICAgIHN0cnVjdCBtdGtfZHNpICpkc2kgPSBkZXZfZ2V0X2RydmRh
dGEoZGV2KTsNCj4gLQ0KPiAtICAgICAgIG10a19kc2lfcG93ZXJvbihkc2kpOw0KPiAtfQ0KPiAt
DQo+IC12b2lkIG10a19kc2lfZGRwX3N0b3Aoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAtew0KPiAt
ICAgICAgIHN0cnVjdCBtdGtfZHNpICpkc2kgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gLQ0K
PiAtICAgICAgIG10a19kc2lfcG93ZXJvZmYoZHNpKTsNCj4gLX0NCj4gLQ0KPiAgc3RhdGljIGlu
dCBtdGtfZHNpX2VuY29kZXJfaW5pdChzdHJ1Y3QgZHJtX2RldmljZSAqZHJtLCBzdHJ1Y3QgbXRr
X2RzaSAqZHNpKQ0KPiAgew0KPiAgICAgICAgIGludCByZXQ7DQo+IEBAIC0xMjQzLDcgKzEyMjgs
NiBAQCBzdGF0aWMgaW50IG10a19kc2lfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gICAgICAgICB9DQo+IA0KPiAgICAgICAgIGluaXRfd2FpdHF1ZXVlX2hlYWQoJmRzaS0+
aXJxX3dhaXRfcXVldWUpOw0KPiAtDQo+ICAgICAgICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRl
diwgZHNpKTsNCj4gDQo+ICAgICAgICAgZHNpLT5icmlkZ2UuZnVuY3MgPSAmbXRrX2RzaV9icmlk
Z2VfZnVuY3M7DQo+IA0KPiAtLQ0KPiAyLjI1LjENCj4gDQoNCg==

