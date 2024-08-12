Return-Path: <linux-kernel+bounces-282606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A84AB94E65A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD51E1C214B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCBE14D28B;
	Mon, 12 Aug 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="q6uFbayJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wPoItWX0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214DD2914
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723442565; cv=fail; b=US9QuCp2TdgXaa2PSuMaeoUrhmDfrtT6nPFq2p7icZLebaRb741jhG6cPB3nZkYlJSv1Bk7nJ8vMl1bdc5e2sX5MeQZrNH+3PVd29TL1J3QirzZECOBHviddABVigk8m+/+YTqlBOAd9xzYpmwJsJCg5AcQu8UeOqWhHT1Xp898=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723442565; c=relaxed/simple;
	bh=dYdyAtc/MyvCLSN3R26Bja966sRNFVQHSrHry7nJkUA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AiOZ1kXUmDpkLuOEQ9ILjj4s5WWK2MKLJDT/Z9OaTDkznQ9Tb/C3PYGRWrgOLAZylXzAe8/U4ta5GkN/WRo1Pt2KxkBvaWKmQcIx5zdJ0/XJX9ET9jHM8zQauHKuEnbYopwNYGyF2ooLri3u7RxASVJj77LI6UFSRde1R7ALraI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=q6uFbayJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wPoItWX0; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 74acc302587011ef87684b57767b52b1-20240812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=dYdyAtc/MyvCLSN3R26Bja966sRNFVQHSrHry7nJkUA=;
	b=q6uFbayJc2IHKI77slh4aHQTSzS/OjocuN+JBb0jLytDb8Zg43JJzfNMKnFeIIj0BcAcNCQnvXPZpBhDmAHlSnbQc+nWsBUh/75mAZ6WXQVisrayqdQbjfXSe/5XhSiCKKqlAuaMjwnWB3vX9yY6+NN/ZG/WzCYIW4AjjQlLgRI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:f688038b-6b4f-4f07-a35d-63003ab42970,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:5c250c3e-6aa5-4057-84d5-0e7d47251781,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 74acc302587011ef87684b57767b52b1-20240812
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 425026136; Mon, 12 Aug 2024 14:02:28 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Aug 2024 14:02:26 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Aug 2024 14:02:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW9OEJ1S8jUVS9esVn3imNJmQv5PyOq4TQ75gRDfPP+MybZI2P7lUmquWGekvZOZFWYiYojoRw7ho7bgE0fVDHYyPTSW19rdRFmcuL+crUryxRIRGaCUiAEXTBM+KZvA4JxXDcRob49kvRvtpH1QwOOgNn0UDJehMDjpsNajc2tMhreAIj1yUflyNDSNDX3afz8q3Xzu1k6XSTO32ZHPtrcmMat9h8xRJBMkDscI0HwUAFkqYVTuqjpnOpWS5NJuXGv65YWqxBOB2JXxi0eqCN28HIl/TsGk8qPfCE4DUjWa1xR2eVwZGvx8MEnXbzjEEtiubgDvwZcQCxtlTvLvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYdyAtc/MyvCLSN3R26Bja966sRNFVQHSrHry7nJkUA=;
 b=VN05UG6uqm21PTtcQln6jfY+Ug2Tn8JsAAFYgJ7u6G9O9CnqFaNfj4ZFoY7Fh8exPxghm6Q7aCHCWoCDxCWooVDKtinxh63jCcQBPKU1wz/MzG3BBRYF71e5lby5QNXRNwQUAG5Fb/0Hzz27XUqdSKWLVZpaENz01PGL1RdsGGkM0KC73Z6AykWzwnCa3gHrDwjbHcvVmOQmtjrJevmmsi3HQJxW0i0fvoNKZ1unJvNqw3QPhRoMv4gbjBla0Qz0KCBzqcKp9Vnh1tzdiIfRNsZf/9qpHjJqm7pJsUndTSlAAkiXDYo4Zha8iBvYv3Ubf2pH+4mdC83LQMPRbFCrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYdyAtc/MyvCLSN3R26Bja966sRNFVQHSrHry7nJkUA=;
 b=wPoItWX0JKymq0b29Vahs5GDn7YeVzaTEmfzyYaUsrG58uT34/KoRyd2AygBCXQxb/XpYg8oQp4eDHKLY2P5b8l8c3PDLeXL+tQMmMGL0ACMGQVVO67/GDZZwCBfbxtdUtV5u4VnAFRyVHPUqFcZo+0hwpr69MIPoBVo5ug6Iko=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB6672.apcprd03.prod.outlook.com (2603:1096:400:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 06:02:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 06:02:22 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] drm/mediatek: ovl_adaptor: use scoped variant of
 for_each_child_of_node()
Thread-Topic: [PATCH 3/3] drm/mediatek: ovl_adaptor: use scoped variant of
 for_each_child_of_node()
Thread-Index: AQHaxlXJ3QTpO0d/4UWp7aZGW8/ODLIjbbkA
Date: Mon, 12 Aug 2024 06:02:22 +0000
Message-ID: <d00fe6d1b49caf86949afe4b849dd1b4af3a287b.camel@mediatek.com>
References: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
	 <20240624-mtk_disp_ovl_adaptor_scoped-v1-3-9fa1e074d881@gmail.com>
In-Reply-To: <20240624-mtk_disp_ovl_adaptor_scoped-v1-3-9fa1e074d881@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB6672:EE_
x-ms-office365-filtering-correlation-id: 1bf5dd2e-3997-4687-d68f-08dcba94552f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N2FvcnExSExXYzg4YWhsaVFtcTUwRGV5Y2FRU0Q4THlsVWx4L1ZSSzdtNXF3?=
 =?utf-8?B?T05laEI4YWNqajZGS2pBTDVVOTV5cStFZkRJOS9MYnJoT1dMUnpEYkFuam1I?=
 =?utf-8?B?aXhvSk11TFE2elNCc3A2MXJBME5Pc1EwNjRELzc1enhGOUtxMEhoNlVhR3lh?=
 =?utf-8?B?Tk9yTHA1aGhwdlIxdnkrOHU3ajVjT0hJdFVXT0pZSWp3eDdHTWhwaENwVVIr?=
 =?utf-8?B?Q2NNeDZ6S3gxcFVwWE13dDZnNUFCdmxrSTVNakdGdm1SK1FvYnR5MzdWVEda?=
 =?utf-8?B?YktQdVVkcUFCWkJ0emxFd0FZcDFCeEY2U3hWK01wMWlVM0JWdHJaRWFCQkdl?=
 =?utf-8?B?ZWpzeFlBZUhYK0RjZ1RsdkJ3M3A3SkU3SEZ5c29rU2ZSLzdBMDRiaUlLQllj?=
 =?utf-8?B?aG9iYXJlekVzSzQ3dzFHRGsxRzlGYjR5OHYxZ2EyUmZyMlRyNTdVSUhwTWRx?=
 =?utf-8?B?QUxGVlZhM1Q4TFJmQ0xYZmFMWDlUUm9iMm5uQjQwSWVMczBlKzBIb1ZnMjZD?=
 =?utf-8?B?cExtbWpBZEM2aFRPOGMzNU4yMitHOFBWNzRRZEc3Uk0ydjhyT2ZrMzJ1OEg2?=
 =?utf-8?B?UUN5RDZHR2dUVjhKZHRzS1hXMThwbnluS2YwZkJsdmlnQzY4MFVrU2l2THdp?=
 =?utf-8?B?cFRtU0Q5SkVEaDJCMitJdGZIQTNxN1lXd2tYeUNCb0tIYjJUUWFwNmxnbTVF?=
 =?utf-8?B?K3RSQUxXaDFOcUh5MW44Wk11WGpuWWg5d2I3VlkxT0RQSjBRNXVoTGFrbEY5?=
 =?utf-8?B?alRMQ21sVzd0YTNPeVlBMXR1SnNyV3F0Nmg3NGJYRFR5NVVkZHhwbGliaDhH?=
 =?utf-8?B?cVpodFhQYzdIQnZjL2xaOFBnb2lnTVNzWCtNSUNYc3ZpWHc3b0dMR2VWT3BL?=
 =?utf-8?B?Ym82WmtRV2pJbFY5U2V5czRZWUZ5cGp3RGxzK2VHdWNHSWtpaUFMZ2hPY1Ez?=
 =?utf-8?B?QWF6eFNwZS9pdENHSzRrZ3JSZ3ZzV3ZCU2Fxdit0VW1RRlhJVWwraE5CZXBs?=
 =?utf-8?B?YXhMYWY2bmhtaXFITGdRRWMxRGFLUGM4VnNaUkM4enZmZktzVk9LbW1sekM4?=
 =?utf-8?B?YWVLN1BWV2o3c0lDRGszNjdUQU4zTE1vYlQvUUg5QTUwekIzcFB6M2tRR3FD?=
 =?utf-8?B?TjdrTHZYZ05rTDIyR3hMeTBjQlcrWmRUcUxsbG1tZ1hqTWNxa2pwMWVhNVAr?=
 =?utf-8?B?QnlBY0p2Z2pxb1k1U1BaQ0tYYitXSmpHaDczK1VuUFE4eWVQaWdvOTdlTkxo?=
 =?utf-8?B?MXhDNTFiTnNhSUN6UmJsR21MeFBWam0rb1QwbG85NW10TXN6dnNOeDlaWndx?=
 =?utf-8?B?MTNXYnRMREpKMUYySVJUa2pMMXloMjdDMlhwZDNWU2x6S2pPYXdwTVMzVmlU?=
 =?utf-8?B?aHJ0ZW9LMERPNllTTWhmU0paL1lJS3A4czFuTjJqdHdTVGk1aVhFaVVPUUZa?=
 =?utf-8?B?VzhlYTQ5MXFVRGRkSllodGkyMmk2ZjVuQ1o5VzlaaFk2L0swMGF3VjB0dEhE?=
 =?utf-8?B?V0RSUHRXcHplUXdINkhVZUJNYTVOWHRlTDljVHVKSHVoS0RJZll5N3kzeDhR?=
 =?utf-8?B?a1dnZ2hyTFFtU2svVUJ2cy9HSERHUjY2NXFCY1hSdHNONnNyM2xvQ2VHTU1N?=
 =?utf-8?B?NmIrZml4K1REQTY1bDcyL0FnRG9DRXVHMDFLWVFsVllicUJsL2J4KzltWHVD?=
 =?utf-8?B?bXBOTm91TXJJbEVsVFRsS0lZdUhBTkprWnFPWUJxUXpta1VyZzdNZUdqakhx?=
 =?utf-8?B?ZHlaOHBheFVBL1dLc0ViRjlKclNUbzNSblJWSUY0bWppZE9uT3RIQ3Z5d3RS?=
 =?utf-8?Q?ocaytoHsyWHDsvVPKBR3RjiRf2Gw0vzmamSzA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dE1FVm1WMEVpemVYTXM5MXRHdUxjbDF6c01xT295WWppU1lOejlLQ0ljN3hD?=
 =?utf-8?B?U0psUy9wNFNMaE1WdzdlNHhpTEZBNEVKTlMzaUI3V2FiWTlIK1lsNm94TVZS?=
 =?utf-8?B?RTdqZTExTytDcktoL3lOYUNSWWlrZnpsM2lWRWV5cUo3Z2w0emhVbkJ3MEFo?=
 =?utf-8?B?RDZHa0dzUmROYlRlUlY1aTVPZHRDbElGZHRZV21VdlBLZDRHb3lEeTI3dVdR?=
 =?utf-8?B?ZmZIaisxWmVKcVZoUXhWbEgrVUowNitVaStLYS9WRUlrMU9sZEVPckt0TkFE?=
 =?utf-8?B?UklLOUNMKyt4dzAyYWhZNDJnYllHOUxrVVdKU1VlRTFiSEVrUVc0SGlrZEZ6?=
 =?utf-8?B?Qjdncmk1SGhSaWdueXJObCswWHhqNHNJdzRFZUoxeXZ6UlhLY2Zjcy9qc3Iz?=
 =?utf-8?B?NFgybWVTK1BZRmJNakQ3WUZ3K2RHc3pZOVd1Ykl1dU5kUzc4N3R5NlZTWW1V?=
 =?utf-8?B?enAxM1FSQ1k3Z1FxbG03SWNhYitkOFUra3NKbkQ2SVNXcEZGMmNVZlFKRFdv?=
 =?utf-8?B?d05McGJlMFUyTmZmUk1sRkUrM05ZQ2wrdFlZdlJLcG56Z05VWlo1eCtwQjBl?=
 =?utf-8?B?N0tQQS9qWmVUYklOMEJKM2JaWHpoRExiUXVMampDNFBHbGFqek9GaUpwekVX?=
 =?utf-8?B?OXAxa05lY0NMcEhQbEY1RnhNeXRTSjFlSlBNVTdYRGwzSHQzbDMyTTREcUJ5?=
 =?utf-8?B?cDVoYkZsSDU0citJS0pLSFlQQldBOU1CTUN6cGxMVk9KS0NqYjFQakU1UXRF?=
 =?utf-8?B?QjAxY1YwZXpZN3BDUUJmR0ZBUTVPMXVka1BMNkZPS2pmQVBsK1I5b284MDZG?=
 =?utf-8?B?dGlwL25GMEw0bmhON0VGK2UvYVUxV3Jjci9vQy9uUi9sT1hCRUYza1M3R0dV?=
 =?utf-8?B?em5sY0FOZis2TG9TY2d6enpSa2FQUmQxd1pnZCtiZkxpTjV1L1Y1WWhSMXdy?=
 =?utf-8?B?WWZOMzA2Wi9xYStjOHM5Y3A2aE0vMUZKREE0OGhWb1BZYlh1Szdpa1lnVXRX?=
 =?utf-8?B?QkRza2t4ZWRSN3hpa3VidUlaRFV6cmhJTUpqKzlwMzdaU0xEdU1zU0I5M1pk?=
 =?utf-8?B?d24rNm80bm52UHB4VnMwQW1kY3gzTndpOWVMdzlxVkF6MlRtY2l0SFZBcERw?=
 =?utf-8?B?NE5ubkFnS0E4cXhnUXN0cXEwVnNiSzJoWGhKQkVzQ3lpRFNONmtGTHp4SVY4?=
 =?utf-8?B?VWtLeXNWSU9PQzQyQ2pVM2Z3UlhqVVY3RGNGSENJUmRvZjVQU3Nidi9XcG5m?=
 =?utf-8?B?TW54T0lDWEZqZjlsRmxBbFM4MXIvZFBaMUZkYmpEUVBiUUpWcTNJK0NtUmxp?=
 =?utf-8?B?dFd5L09YSnRBQU90cjBXajc3TEIvVkJkdVdlRUdPelI2cVJwVW90TUJVOC82?=
 =?utf-8?B?TEZMWHFDcjdlS2xPeEdTWUFNZUV4cHJ1cVJMdE9RSTFXSDdCYVVmWkV6cFZ5?=
 =?utf-8?B?MlMvV0I2azd6M2RaeUQrN0xIZWhEelg5TDduaFFVOUlhSUxkNEdQUlFOV3ZM?=
 =?utf-8?B?TkZoNUlGbEozNC9NQTJaT3RCMC9lU1M3M1JNb3ZjU2JRSlNGcmlDZlBWWEVW?=
 =?utf-8?B?ekpaOU5MWmczQVBwd2RpY1oyQ28xdGwzdWh5QVQrcm5sV3ZUaUd5UEkwQzVQ?=
 =?utf-8?B?dWlwRkVTWk9MNFl6M2xOcUxxWUFsa3pPbEFLdTlJVmRLWUxZMVlRN05yVFg5?=
 =?utf-8?B?TWNsclNKZXh2YVFLL1Q5dVJOTmJ6UFJ0UExhQ0oveWlFSXNqUDQ3c0RrSC9L?=
 =?utf-8?B?VE9waDhuRUFuWmVEZnFWc3B6aEZqWVR5NzRWbUphODh5YnRmYzN6bE9kK2Fi?=
 =?utf-8?B?YVhEdS9BR1FZNWZTcXpQVUV5VSs3dDBHOVo0KzRyWkxaVEVJL3F0MlZ3Vkhm?=
 =?utf-8?B?UldhV1lzTVd5NDNiS1V0VTdJQVBOQUo2VlJsaXBjT2VydVl4dUlhZlM3clFk?=
 =?utf-8?B?c0lTemkyb2s1bFNSanZDVlNwM20vMnU4S2dwSUxKWWJ2STV0TEhNd0ZIdmtS?=
 =?utf-8?B?cVFiNGtvd0lJN2xsc0Q4eEUvbUZRTDBKdUtJS1JQMTJ5bkxPaE9HVE93ZS80?=
 =?utf-8?B?WGNldmJKV0QzKzBaRUVoOFpBaFVaRDFBNWlkaVpBeFhFeUtVa1p5YTdvQzlk?=
 =?utf-8?Q?+FJE2F3bFFmiTAGK9FJES9vWs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD3722133B3C634585F74724326081F3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf5dd2e-3997-4687-d68f-08dcba94552f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 06:02:22.6834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pVBVxCn2DSJOS8b6ZhXdgFMWbGVIGad4BcO4a9cULPVBdYBmTYPrlr0ZDeoHy5SQx+lYjijbyNLCxpzz7FnR6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6672
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.594100-8.000000
X-TMASE-MatchedRID: VPleTT1nwdT4OiVTWoD8RAO6RQiVjr6mjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2RsqQuQlRTh/DHSNFHFxB88UmcSma304TFER
	dnCEO4XEwUXvzn8RoTGp8RlREs2NnPCKP9KRK0eZDiyuN5FvFNkyQ5fRSh265CqIJhrrDy29ynC
	+RoYX/O+LzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7bkV4e2xSge5BOW7VJmfrcz7bV
	hI/9cpOFE+6S0CCVZb5xKQwACwUq2gGZNLBHGNe
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.594100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	CE9C3F4204581B653534381A74DAAF31E766F9B155409BEC22299EF2AC794D032000:8

SGksIEphdmllcjoNCg0KT24gTW9uLCAyMDI0LTA2LTI0IGF0IDE4OjQzICswMjAwLCBKYXZpZXIg
Q2FycmFzY28gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSW4gb3JkZXIgdG8gYXZvaWQgcG90ZW50aWFs
IG1lbW9yeSBsZWFrcyBpZiBuZXcgZXJyb3IgcGF0aHMgYXJlIGFkZGVkDQo+IHdpdGhvdXQgYSBj
YWxsIHRvIG9mX25vZGVfcHV0KCksIHVzZSBmb3JfZWFjaF9jaGlsZF9vZl9ub2RlX3Njb3BlZCgp
DQo+IGluc3RlYWQgb2YgZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZSgpLiBUaGUgZm9ybWVyIGF1dG9t
YXRpY2FsbHkgZGVjcmVtZW50cw0KPiB0aGUgcmVmY291bnQgd2hlbiB0aGUgY2hpbGQgZ29lcyBv
dXQgb2Ygc2NvcGUsIHdoaWNoIHJlbW92ZXMgdGhlIG5lZWQNCj4gZm9yIGV4cGxpY2l0IGNhbGxz
IHRvIG9mX25vZGVfcHV0KCkuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsu
Y29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgQ2FycmFzY28gPGphdmllci5jYXJy
YXNjby5jcnV6QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyB8IDggKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiBpbmRleCAzZmFmMjZhNTVlNzcu
LmFlYzkyN2NjZTQ2OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bF9hZGFwdG9yLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bF9hZGFwdG9yLmMNCj4gQEAgLTQ5MywxMiArNDkzLDEyIEBAIHN0YXRpYyBpbnQg
Y29tcGFyZV9vZihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEpDQo+ICBzdGF0aWMgaW50
IG92bF9hZGFwdG9yX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBjb21wb25l
bnRfbWF0Y2ggKiptYXRjaCkNCj4gIHsNCj4gIHN0cnVjdCBtdGtfZGlzcF9vdmxfYWRhcHRvciAq
cHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiAtc3RydWN0IGRldmljZV9ub2RlICpub2Rl
LCAqcGFyZW50Ow0KPiArc3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQ7DQo+ICBzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpjb21wX3BkZXY7DQo+ICANCj4gIHBhcmVudCA9IGRldi0+cGFyZW50LT5w
YXJlbnQtPm9mX25vZGUtPnBhcmVudDsNCj4gIA0KPiAtZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShw
YXJlbnQsIG5vZGUpIHsNCj4gK2Zvcl9lYWNoX2NoaWxkX29mX25vZGVfc2NvcGVkKHBhcmVudCwg
bm9kZSkgew0KPiAgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCAqb2ZfaWQ7DQo+ICBlbnVtIG10
a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgdHlwZTsNCj4gIGludCBpZDsNCj4gQEAgLTUyMiwxMCAr
NTIyLDggQEAgc3RhdGljIGludCBvdmxfYWRhcHRvcl9jb21wX2luaXQoc3RydWN0IGRldmljZSAq
ZGV2LCBzdHJ1Y3QgY29tcG9uZW50X21hdGNoICoqbWENCj4gIH0NCj4gIA0KPiAgY29tcF9wZGV2
ID0gb2ZfZmluZF9kZXZpY2VfYnlfbm9kZShub2RlKTsNCj4gLWlmICghY29tcF9wZGV2KSB7DQo+
IC1vZl9ub2RlX3B1dChub2RlKTsNCj4gK2lmICghY29tcF9wZGV2KQ0KPiAgcmV0dXJuIC1FUFJP
QkVfREVGRVI7DQo+IC19DQo+ICANCj4gIHByaXYtPm92bF9hZGFwdG9yX2NvbXBbaWRdID0gJmNv
bXBfcGRldi0+ZGV2Ow0KPiAgDQo+IA0KPiAtLSANCj4gMi40MC4xDQo+IA0K

