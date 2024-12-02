Return-Path: <linux-kernel+bounces-426820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BC9DF90E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 03:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6120A162A89
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 02:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C062AD13;
	Mon,  2 Dec 2024 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="iO4wK/Sl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="V5reEOCI"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C533CA;
	Mon,  2 Dec 2024 02:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733107942; cv=fail; b=d6GCi2uus974FWvZwsEvG7xax8gaS4xNGqmNsIIEPilcQ4haF0BE1YWg4AX/TCvdh8KadW4m6tXbAajFTcAIjLQuRkopFFTdQ6YmjF+DjnajjhES1DP0rgRErrGR7UKHRI7SbiQ8jrt/VcG5e13osXCsdDcmKfwdchzBxHTClJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733107942; c=relaxed/simple;
	bh=2slswlxIW/rYG3oDZAqTzCp+Ck2e0uFzBsHmmcBOTfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XKDZNDaXzeLWYNQoXTJ90zglqYw76e1jpGxfISx3R6r5s+nYXumB0phkTgMGuKwbgQzl5lSfQ9oQMKrSimjOgbaTDaYXXOL3/iY70izsPIV6nS4sHx0YDAmi6S09EviTKO73R3V3g8RTuJzRW06QseYibfWuegAgkpaKiuVeKfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=iO4wK/Sl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=V5reEOCI; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6ee9189ab05811efbd192953cf12861f-20241202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2slswlxIW/rYG3oDZAqTzCp+Ck2e0uFzBsHmmcBOTfo=;
	b=iO4wK/SlJ7kETW1TbLcuz7MD+gtfiOaqJF5f3/t0aEtnLYSJB5b4InhdlpNDJXqFTUWf6+9jJw3YV3RfVBlGeyviJ/Ij4gAzCelIxj2i8F2/ftC/2CrryVtnnJnBhv0hQqhmOxqRfdferRxrLAyv+5Z/9RHMnf5e5UsIdVqIk14=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:6e8ac29e-29aa-4fa6-aee3-d1f90cfec1aa,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:2447cd23-634f-4016-85ba-2d63e55c9400,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6ee9189ab05811efbd192953cf12861f-20241202
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1289758375; Mon, 02 Dec 2024 10:52:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 2 Dec 2024 10:52:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 2 Dec 2024 10:52:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNIeIPE2vPPDn5vrZa0ZLYpKzXFjNjxHKHu7LhFm/xK6b2v3Hvor+i3Eq9acH/3My4cUVPVMuD1S0x8WhZyTCqIPa0Jyt7hlSy5FPeKlBVcLwtMz4NqgtqgcdO08MhhT/ViZhGBpI50DW19l/p/Jd1rMTEoi/XZyQ9ZS2gB1BzlP6Zcq7DwaTpWpXKaR6CQbL2m8tfi5OaswGUDoXMj3sYOI3m0qdJ6z7Zy0gxEG1aSB6/FDmBuKc4rcgikHMnt37iBlnd2N3dRrqHi+KAHHtCWIFAAA8+mLNImil2r1m4xTQoortNAR3ceVu6rTlreGVZEY5s4eRt2stPWLGiX2Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2slswlxIW/rYG3oDZAqTzCp+Ck2e0uFzBsHmmcBOTfo=;
 b=NYovJ4T/YNMtmT2z7dyG6x4ezCCuPrrXoqkblvjhg7g4JkBzJ7dOg2Vg7wkCIWF81fqumCXxTCMymDSkd8YAvFeOAOInKGHQqZBDrHen40qRI5Aor5plMA7AFegRLKjjlBCSSmJL9p/Fru4WbtT/9UBVO4p26/wKT7m4AxAAf3R+tysgg+J4uJV4ocnAMcKTKXHNli8cDGU5ybh2u5uDDosVkuagF1WwBVW5C7/ViPbBtK3nTnWcRkDJ8XbQHUMv2pYLZ4lItIOc+L/ebRnv09gZszJHU8SRxzJ0U5sN8KOYN1L0Sdes1NxXfQBBsHh4fzPs5fM1KSRdlipArj5EAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2slswlxIW/rYG3oDZAqTzCp+Ck2e0uFzBsHmmcBOTfo=;
 b=V5reEOCImxjWylN7ixWIqHPrTZBx69paGGlBUyNPHW6CUFiGl8YlipSJlhpVg9q5+AED6lx6+pgD9uclnefZ3bJJq9/ZBVk2eK98y7JdY/w9No85UDXBfZopoH/NtFDz26U+1xDemUR6cd1WYEKE9AfqoSQN+uZwsgSYEMFLRxA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8636.apcprd03.prod.outlook.com (2603:1096:101:232::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 02:52:09 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 02:52:09 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "mripard@kernel.org" <mripard@kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 6/7] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Topic: [PATCH v1 6/7] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Index: AQHbO0pOdhPnCCfvPUeRqumGFBNh8LLSU8UA
Date: Mon, 2 Dec 2024 02:52:09 +0000
Message-ID: <0fe707761a3a5a432a191f5afb07df7831e03c22.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124512.134278-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8636:EE_
x-ms-office365-filtering-correlation-id: fc10c645-af1a-44d7-fcad-08dd127c5081
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y2xob3BFUjhwSVEwYWl0ek5kSitibWJBem9FcFBRdGNoVHM3WWRlK2QyTndv?=
 =?utf-8?B?WXBteWhzUjBwVSs0VGlvcmZZUUYzYzdzT1lIN2VTREROWXBsWEtoLzZDaCsz?=
 =?utf-8?B?V2JlQ3BHYnkxYVh0eTdrQlRoWnJaN24zTVJsYnExeVNqeEtWdGFPNFU5MW9p?=
 =?utf-8?B?Z0lqbTVqT3RUL2ZzUVNnN1k2bTdyZThYdi9TcnFHSmNPaFlLZTFpTkxHZlFy?=
 =?utf-8?B?WWlSRjBESkdONFc3dDlhTVZQYlFkZjcvTG5Sd09OLzdya1Jrdkp6N2VZUzRV?=
 =?utf-8?B?cCt6T3VpUjVTQVNKaEhxbU1nNFRYRU82Tit0TjV1RHZmZzJXQ3FoWnl0Zzl1?=
 =?utf-8?B?c2pOM1IvV2ZqbHBqZzBIejUzdlR5ZGphNElKWGJnQ1ZwWldWRUpKdE9UdHor?=
 =?utf-8?B?MytjQjBHRG1obittT0ozV0V3Wi9Sc3dKajBvM2VXeDJCdFZNTmI3RWZCakNk?=
 =?utf-8?B?WEJCcXhBVVZOMWRraDZmOEFvcGxaTHlncm03TjlMeEZKenpIVEQ1WUNBTEVv?=
 =?utf-8?B?VXZmRlFWYjY2MkMreWhyYUtUdGZKWDBOOGZlb0p5V3ZBdlJ2c0FtTTZ2OFJm?=
 =?utf-8?B?Q1lZYUJ1VTBIT1VoWUlFYlpQNUg3SXhzMi93dy93TnpmMmVQR1FnZzlOZDlo?=
 =?utf-8?B?UnVjd1JCcnl0NDNVN2ZmUEROZ25ITk1MMDdqcEhnclJueWFIcnMvZWUzYkZO?=
 =?utf-8?B?SlhEZmRaSGZESW02UUcrVi9LYlp0cnhGdnk5SndMOUlRLzhZQm5iSGhVT0lZ?=
 =?utf-8?B?ZjJOdDFHM3lZdlJoaXc4TUVpd0g0NGZ4R0Nhd3p5cDhDSzVhVGFOQjRESGd5?=
 =?utf-8?B?NjZzQnFRUG9JYlN5RWR0bDlmTWZ1UzlrRWwvSUEyNFJrZDBlOEtPUHhGSmpN?=
 =?utf-8?B?YmpCY00yNEFabERwVzJmd09WN1NoczhTV1YwSk1ENjJjNE1pMU5vWkZXTmxo?=
 =?utf-8?B?bUgrb3dRU2xtRm1nMGgrVHdDcFdGUUh0eXBNcFRsZXVvb24vQnBTemxkMTlD?=
 =?utf-8?B?SEExMm9sYUlQUWVrNU9tZWUxNyt3eGxGL0VRa2RUaUZMS2N1N1V0SFkrUlVZ?=
 =?utf-8?B?Mnc2OUtvZ3F5dWE5cFlQdUFoQU9SS2VFWWY0Q294MWx2Z0pkdjhUUUsxLzR0?=
 =?utf-8?B?b0hXc0tZN1MzTXBLL0YxSkdTdkxQUFVuajRBakd6UlpsRzd4cWV0bmpJVHhN?=
 =?utf-8?B?aWppdGdOaXpaL2FkcHlkWmkvK05iWm9NR2F4MExmZWo1aGFXaUVKa09zeVlV?=
 =?utf-8?B?WnBIbzlmQnJjdFo5ZElxRys0dUw4eWl2VWwwSSs4RlF5QzdIOURqaVZxVXds?=
 =?utf-8?B?V1RFazkxamN3ZTlGaUVQT1NiNEw1WGRUaVJQeDZtUmdNK2ExNWRBWlVvMzZ0?=
 =?utf-8?B?cURseWRtUDl5Wkt3NWRFSXBEOThxRE5iUHB3RU9hTmNTR25zeFlWbG5wWllS?=
 =?utf-8?B?WTE0NlNpSm1Ja1NvbVE5dEk4c3NHYXI0OWx6VDRaU0pMY2QwT2tVWWNLMHJp?=
 =?utf-8?B?UFMyTkpQejRYYWNrR1ZvWTRrNkRZMy9VaDJqbTFBRk9Nck1CUWR5dmh5K1o3?=
 =?utf-8?B?ZUZIZnM0S0RkOVFubkNDR05TN1dCOWxZRGR0OHQ3SnFhOWlKMzF4ZGdKZXQ2?=
 =?utf-8?B?aDZZWHprOFBBU1lBam1aY1RDekxHdE5TTDBQVzVjL1JLWW5LSUt1Rnk3OWZP?=
 =?utf-8?B?aWxkZlRrNWoyTDNFTlJQblluY29SU2NkMS9VRG5LUGxYMlNMZmZ5SXRnYmh4?=
 =?utf-8?B?b1NIdjBOK29VRXdwRUpiMXc3OWY0M0FCamRwNk5pSlBIb29vVkY1aHR5VVBw?=
 =?utf-8?B?N2c3ZlhrYUNFVWU4bDhpd2h4QjE1RXhpUUtkbDhqZWhYZGlBQ0JZeHhycFFp?=
 =?utf-8?B?TmtKcmRrcWFFWXhPa0xZQ1RPK05JS0VEeDIwZFR6eHF3Ymc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEppWmFkTXJ2Z1k3amI0WDMwalZ4Ry9YUk8yV0R4V2laTUFsbnNaNDdHQUx3?=
 =?utf-8?B?ci82L21HUTcwa283K3pRVloyeTVldVY5M1Y2cFhOeTB6RHlFczZJU3M4Vkto?=
 =?utf-8?B?dG4yY2Q5Wjh2MXdteHdMMXdvVW8xVm5TakV2QmUyV0tCejZmOS9BWWhiL1Fx?=
 =?utf-8?B?aHJpZTRlYkEvb3RTTjQxT0dTNlpIMFdLWXdmYzZCSXQ2RFNCa1VaRTJnZEhV?=
 =?utf-8?B?VzlGb1h5WDhPYUpEYVJYNVJmWmg2ZUZvT0FoeXpHZDUzTDc3YVpETERucW9m?=
 =?utf-8?B?dklqRjNWbmlOTzNMZkpIME1WT1BGU2paZjhLMWh5d3dxS0ZJcmczMGdkYkpW?=
 =?utf-8?B?Z1BjelluZTRjcGhsMVg0VTd4bEI0OG42UWQrYk5qSWVQV3pIVEZYQXlvcncz?=
 =?utf-8?B?Vm9pZUpWTzFmd2ZtekFOd3FWTXYyd1hqbDhaUVU4VjhKL0RMaVppK05yQ3Fo?=
 =?utf-8?B?bmdabkh2WkttT3pWallXQVlFdHA3RUl3amlNZXV3ODZFM1JDemdMRmxraTNP?=
 =?utf-8?B?czIwV0NoWUxwZ0ZEZjArQzlTeFBWQ3QrcUhtVHBqdUI1V08rWUpIbG5kRjN4?=
 =?utf-8?B?UXhpek9Wek1PYUpzdlloUWQ5Q2hUcjlxbjExNUlkUVBhVElzWjF0a1pGaGxI?=
 =?utf-8?B?SjQzdGlaSzJOTVFrbXloT25kMHQwREFmcXdoVlVQazNqUFFtc2NwVEVuOERt?=
 =?utf-8?B?L1Zhb0txR0N6TjQrYzFFZTUvNTBHaUVwNTlUaFIxcjYwRTJKVkR0dFNrSTRY?=
 =?utf-8?B?OWY2S2p4dTAydFNpYk1RVlRLWTIveUs0MFZVbDFwVEpJL1NnZkJDRFNPMUw0?=
 =?utf-8?B?blh4N3h2bk81SWd0VDdIamJEWllRZk5UcnFxVGhOOU1zZHBLT1ZBRTdXU0lw?=
 =?utf-8?B?ekpJVHdWMDhRTi9JSkIwdU03ZlRvcHI4SWJBcWZBV0hVTWpwV1hDWWRuTVBX?=
 =?utf-8?B?anBjbERpU1dMWFI2cXFyb1lTbkQrYzFrOHorTXpld3h2ZVZDWUt6RW1tYjVM?=
 =?utf-8?B?N01vUERudk5yQklCeWpnME83TzduMFIxVllDWVVqQXZsYVh2dkVUR3ErNzJB?=
 =?utf-8?B?VStzeWlFdmwydkpubXh0aExkcXBFQW5OZjROYUliZThoNWl6TXNDTktoOXFR?=
 =?utf-8?B?UUFRU1RSTE4vODcwOGkxeHdCTVNSVndIaTdUWFF6T0VTalljdEZodSs1Qmli?=
 =?utf-8?B?aTlrUExtbkRiN2RoSTlRRE9ONm5aM2ZnOWFzU2gyL2FiVUhnaXoyMlVBTFFX?=
 =?utf-8?B?WE1QTThiYk9RSk5BdC9kOG9nN3hub3ZwdGxkUzZneStYcDNIRE5keVlocy8w?=
 =?utf-8?B?cTl6cWlsdDVQSEgvWmpUOG5iRGgxNTlMd3ZVa2NUU1dkQ3d2a2VRbEZwcDlY?=
 =?utf-8?B?ZGQ0SlRNZ2FQeDdlVEQzY2JCRHhEOUlST2tlKytWRkdXbU5QbnFBcmNVVTVJ?=
 =?utf-8?B?Mlpua3R0MWlFMjdVTDVMV3BXV0JEejVibUloVUlqNTUrTzlFTEplSHpTeS9a?=
 =?utf-8?B?R29GcGtFMWxZU3l2dnhOOXVKaVorc1ZrWlJSeHpGTk5keVJwQlV3THZHTkJ4?=
 =?utf-8?B?SzIrYVV4ekxXNlBqNFJhQTkvNGxCZUlFMzhKaG1lb2I0Rzd5WU53eElkN2Zk?=
 =?utf-8?B?SFpGVkVwM09rZnVua1dYMHc5eW5MSnlidnVZS04yTE0wZkllbjR1QXdjT2E3?=
 =?utf-8?B?RjZxMnBXbHRmOTY3cUZwQXU1UzVQV0lYaXZnaW1CZ3JpYXY0QkFORitpUWc2?=
 =?utf-8?B?d3JvQUk3MlpZYS8rYUJkY3pyR0t1TFgwcjNvSkxkQ05RTGhKOW5OcURoQ3M4?=
 =?utf-8?B?SkxpK3lEYzdES3k3RXBrRVp2ZWovTnFMUitPWGs4UGlrbHoxNzJnRVE4bmNK?=
 =?utf-8?B?L21mZmhZMGNrdkYwVmhHSWRpb04yVzc4VDQ3bXJnaWExOEFSbmY4NExwYTlw?=
 =?utf-8?B?K0JSNDA4QVVIQ2Rpb1RCalM5Szc3Q05sY3lLUHZUbXBQbkQ3K1YwS3ZjMWRR?=
 =?utf-8?B?Tkx5L2tDVU12UlJyck5WK21KeGFRTWJQdVhiNjhqb0lTZXR0c2o1TmpQWmVa?=
 =?utf-8?B?UlJUT09tZ1paSkZMNkxqcEhLdFRlWk4xZ3h4d1BQQzRzMlZQbWJ4OHJxQ2dB?=
 =?utf-8?Q?TkbNMylmJx9w1b6l+37EhhGZP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <130738BF16CBD54393B549420D53DCE8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc10c645-af1a-44d7-fcad-08dd127c5081
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 02:52:09.2011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmvafqkysOg29OU0M8+YDMZbm7AN7p0ttWgLJDw7zKfn5pXYOFmiU95y+xtCzCtX3F5u8CeNyVuDxcfGG9yE+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8636

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ1ICswMTAwLCBBbmdlbG9H
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
XQ0KDQo+ICtpbnQgbXRrX2hkbWlfY29tbW9uX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYsIHN0cnVjdCBtdGtfaGRtaSAqaGRtaSkNCj4gK3sNCj4gKyAgICAgICBjb25zdCBzdHJ1
Y3QgbXRrX2hkbWlfdmVyX2NvbmYgKnZlcl9jb25mOw0KPiArICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKw0KPiArICAgICAgIGhk
bWktPmRldiA9IGRldjsNCj4gKyAgICAgICBoZG1pLT5jb25mID0gb2ZfZGV2aWNlX2dldF9tYXRj
aF9kYXRhKGRldik7DQo+ICsgICAgICAgdmVyX2NvbmYgPSBoZG1pLT5jb25mLT52ZXJfY29uZjsN
Cj4gKw0KPiArICAgICAgIGhkbWktPmNsayA9IGRldm1fa2NhbGxvYyhkZXYsIHZlcl9jb25mLT5u
dW1fY2xvY2tzLCBzaXplb2YoKmhkbWktPmNsayksIEdGUF9LRVJORUwpOw0KPiArICAgICAgIGlm
ICghaGRtaS0+Y2xrKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4g
KyAgICAgICBoZG1pLT5waHkgPSBkZXZtX3BoeV9nZXQoZGV2LCAiaGRtaSIpOw0KPiArICAgICAg
IGlmIChJU19FUlIoaGRtaS0+cGh5KSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiBkZXZfZXJy
X3Byb2JlKGRldiwgUFRSX0VSUihoZG1pLT5waHkpLCAiRmFpbGVkIHRvIGdldCBIRE1JIFBIWVxu
Iik7DQo+ICsNCj4gKyAgICAgICByZXQgPSBtdGtfaGRtaV9kdF9wYXJzZV9wZGF0YShoZG1pLCBw
ZGV2LCB2ZXJfY29uZi0+bXRrX2hkbWlfY2xvY2tfbmFtZXMsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdmVyX2NvbmYtPm51bV9jbG9ja3MpOw0KPiArICAgICAgIGlm
IChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICsgICAgICAgcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgaGRtaSk7DQo+ICsNCj4gKyAgICAgICByZXQgPSBtdGtf
aGRtaV9yZWdpc3Rlcl9hdWRpb19kcml2ZXIoZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiAr
ICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJDYW5ub3QgcmVn
aXN0ZXIgSERNSSBBdWRpbyBkcml2ZXJcbiIpOw0KDQpZb3UgY2hhbmdlIHRoZSBlcnJvciBtZXNz
YWdlIGhlcmUuIElmIHRoaXMgaXMgbmVjZXNzYXJ5LCBzZXBhcmF0ZSB0aGlzIHRvIGEgcmVmaW5l
bWVudCBwYXRjaC4NCg0KPiArDQo+ICsgICAgICAgaGRtaS0+YnJpZGdlLmZ1bmNzID0gdmVyX2Nv
bmYtPmJyaWRnZV9mdW5jczsNCj4gKyAgICAgICBoZG1pLT5icmlkZ2Uub3BzID0gRFJNX0JSSURH
RV9PUF9ERVRFQ1QgfCBEUk1fQlJJREdFX09QX0VESUQgfCBEUk1fQlJJREdFX09QX0hQRDsNCj4g
KyAgICAgICBoZG1pLT5icmlkZ2UudHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9IRE1JQTsNCj4g
KyAgICAgICBoZG1pLT5icmlkZ2Uub2Zfbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiArICAg
ICAgIGhkbWktPmJyaWRnZS5kZGMgPSBoZG1pLT5kZGNfYWRwdDsNCj4gKw0KPiArICAgICAgIHJl
dCA9IGRldm1fZHJtX2JyaWRnZV9hZGQoZGV2LCAmaGRtaS0+YnJpZGdlKTsNCg0KWW91IGNoYW5n
ZSBkcm1fYnJpZGdlX2FkZCgpIHRvIGRldm1fZHJtX2JyaWRnZV9hZGQoKS4gSWYgdGhpcyBpcyBu
ZWNlc3NhcnksIHNlcGFyYXRlIHRoaXMgdG8gYSByZWZpbmVtZW50IHBhdGNoLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZGV2
X2Vycl9wcm9iZShkZXYsIHJldCwgIkZhaWxlZCB0byBhZGQgYnJpZGdlXG4iKTsNCj4gKw0KPiAr
ICAgICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo=

