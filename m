Return-Path: <linux-kernel+bounces-448686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2389F444C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA1516C3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF2C1D88C4;
	Tue, 17 Dec 2024 06:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DOFzyFdf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QFuxr2ei"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3B4185E53;
	Tue, 17 Dec 2024 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417632; cv=fail; b=Fy7tM+/HaWKVSw+tCFj98l9Cd6MteYZk963U8i7WJpBuILNWVo1FXCTXqyFIsr0xHeRRNASIVouA2VyrVQQBPlgB+OGVcwBhCep5u4J6OQE+BoRiEQBZo7LMdsdzV7Bgdf5lHqmjdUI0eSkLHwwambgM9Xx1uTjall4lfiM4t6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417632; c=relaxed/simple;
	bh=eyQ/avYHFCCazaxKPc17EFYMoTjBecWtvqfo20xDDa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NVaIL7wq4Suy8K9K4gL07/bgrNVKDl8s7/9+AWi8tP0ni59/0tX6T5QI6CeD/MEmyx89BgOBGphwEAiv96NWgWSv77adzTgfhRVsQ8JghL+gRhjQQP8mpewNjHyGEx2bu0XWkIGIiIeI0aflm06nikZNHk2SoDIDSmmPRzt9bmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DOFzyFdf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QFuxr2ei; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c682bff8bc4111ef99858b75a2457dd9-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eyQ/avYHFCCazaxKPc17EFYMoTjBecWtvqfo20xDDa4=;
	b=DOFzyFdfAjCoucsGWF+MyGiJnQ1h4D+HMiqKkvTfuBsKhXBx8rju74f38iXXp1YU9qkSArTjrNu0sarcFPuKo0ouiOt4+OnqpWb5LwivUURfLQldXXEF9glNT0iuoDD2KITqf0S8kqQOrgtgEUb9keHsuSqi90jD26BF5US+YfI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7ef5000e-0bab-4ff4-a3f3-59d27911f908,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:bfa24113-8f5d-4ac6-9276-7b9691c7b8d6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c682bff8bc4111ef99858b75a2457dd9-20241217
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 125464463; Tue, 17 Dec 2024 14:40:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 14:40:14 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 14:40:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qrj9OMcj3sZ512vJz+fOhgjXvPWeBKvZMaqYMdFl4RmR3cILhZl9DLdEeO15PVZN0NTq0qiiJadoJgWia5rKl5ZQ5uSZrRN30Rp/QAuQZPBZaug9Tn3GocjWux0f9m0WQtsF5uL+52hbpp0ocPZr7pIQWjEuhUAmFcWgModjfd2/Al+xQ55WyHGmcSXeBiISQ7/YovOJA5LMUngEr2wHmwxLqPFzNKnAPckPWb7QKtYY00Nhi6stT8Yc0hrJKyEJ9nLfcS+yTczeTVYZE2kf+tvqRIVTwkJrJw97ha18cyZPUlVcstjzFQgTiOMXSHR0QPgIIUO89vSFBzUgCBqc+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyQ/avYHFCCazaxKPc17EFYMoTjBecWtvqfo20xDDa4=;
 b=hWoysEDduip8/Ej6JSK4EPPcujU7hIECS+zmV6BKp2JrL1s03spDJ3oYc22bYVlgr/lqrsSnvB8e+xh9Z0cVeKjCfZpjFWKRm7sb6QCtI51bQNgj8DJf7kAswZDzFpI8tUY9tMmO0dgGO0LBaoRm9qq0JlJXeBKmO+4xzjIBxsCFrAleONkLNtmFFeys5/MLrCW1hwvfANWZE8bRJJjs6woo8lADDqlX1k2NuSIRTD1nAg2h1FmP3jZAKeQnKdarw6SS3uBPIxv4kC1MA4x+KlUIh3u+LVNYyZr++AOml2X3vtaGTQClUlMt4TTQfnyCJpiVkN2zv/eV28qxOTV+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyQ/avYHFCCazaxKPc17EFYMoTjBecWtvqfo20xDDa4=;
 b=QFuxr2eioBEwd1vIcDMY2PEpbs1IJxpfr2YNJY40/Jvj56QNjbH5+74cEIUo97GfFZPQ+dQQR2gYSbjpHytE/fAf9Wq8vDhhwTg0GSHYwxeFcDEUfHpHRFMLZjEUn4NiEOHAmx3dMLRNB3byLJa17vKec4RN1UUrcYN0bD1W5WA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7830.apcprd03.prod.outlook.com (2603:1096:101:179::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 06:40:11 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:40:11 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "kernel@collabora.com" <kernel@collabora.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v2 15/15] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbRwuJJIpw1RNG4k2Br44bBPRYWbLoovUAgAAjZgCAAUiXAA==
Date: Tue, 17 Dec 2024 06:40:11 +0000
Message-ID: <d64ff9f1525fe3563502e470b2a31303de08a7c6.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-16-angelogioacchino.delregno@collabora.com>
	 <803bc2bd802506635dfa9ea9b26a6ca40a7f4912.camel@mediatek.com>
	 <e5788187-e894-4aab-a41e-a3d7a64762c6@collabora.com>
In-Reply-To: <e5788187-e894-4aab-a41e-a3d7a64762c6@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7830:EE_
x-ms-office365-filtering-correlation-id: f00c457d-1f2f-46fb-fb1b-08dd1e65a801
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R1V3TnFLQmZHY24vb3FBSHZ2QzFMK3Jick9PZk1FY0tPenpzNSs2UjYwRTcz?=
 =?utf-8?B?bTY1TG8vc2RTblNQSjNJN3luUXkwbkU5bmhGU1ozRkJRTWZJQ0hjaStXZ0RF?=
 =?utf-8?B?ZGtmSzBBWXFQdm1kMDVqS25HZ3NCemlBVlZ1cllNQnFyZzVnVHhlUDdOVnNs?=
 =?utf-8?B?WFZuTjdHaHp4UDV0RVg2T2RIRmgrSEJnSjZZMnNhT1lDMmhVSktzUlUyVXRx?=
 =?utf-8?B?YW9qdVpFSzVUWWtETWRrQnVvQ0ljWGxmRFU1R2tIaHZlYjQweVlBelh0Y3hO?=
 =?utf-8?B?Ym8vSHMySk5TTTR0R3FPNUJGWDFzVCs2cHRTZHQxUGRiOWRIbmRhTGJxdy9z?=
 =?utf-8?B?RTFUUWQzeEdmbEUxak8vTzBvbWpyTlhmTXRCWkVIUE93cjhZUDVpMXRYMkFC?=
 =?utf-8?B?YXl3T1NCYU1aSXJDVWxEblllSVgxekx3aTYwSGVZRTRRRVZ3SHJnSHF5NkRo?=
 =?utf-8?B?N2ZUR2NaZDYzUnpmVFVSYUE2L0RJNnNvbS9kVCtrS1U2WE1uSjdMRmdmdHRX?=
 =?utf-8?B?dG0xZEY1eVVZRUx6bDlWSHBJampidCs3cXQ3VmtwWDd6eVRYR0dzMDEwZHc0?=
 =?utf-8?B?NjRRbVdCTWJhdW9mRHBpRHBxM01nalc2eVVZbWJ4dVBUL2RLeFNOeVA2RFNn?=
 =?utf-8?B?dWVOR1Y2eHRMalJEUzlMd0FDSU1jTXAwYVFTOXJTOFZOVUc2Y0hlV0Y1OWtW?=
 =?utf-8?B?SWh1RGxmdVhmUGFNcnIzb08xQ1NzKzA1WHFMR0ZkMkF6bWR1bTNOcXk4WXlt?=
 =?utf-8?B?QjlYeS9YeFNYOWNMMkhvZXBpUzQ2Zm14bEtuMEd6VnRmdmNZNDhud3M4MU1R?=
 =?utf-8?B?Uk1Qdnp5WTNobVBTTUtoUzJPd3hNUmJnSk9qVDFsMzU0STN6QWs2N1RaYWNS?=
 =?utf-8?B?SDRiMEtrUWZ6TFJFYjlzK1lGdjM0Skt1NlMwS0hpYXNIcHo2b2dsaStzZ3oy?=
 =?utf-8?B?azVWdmhXcERoOHlFcnllMHNQcVRteE83ZUkxVWo5RnRsMzhQbU5Cd2VBWjdt?=
 =?utf-8?B?MzdmV05KM3M0V0ppOWpmdHZnTVBqWkF2VkI3bVNJWDFmV2ZGOWlCdTBLOU1o?=
 =?utf-8?B?c0I5UFJ6SGtlcWhQd1FWdHJiR3JucXowZEZXUHUyU1kvTjArZjZBWm5hKzRL?=
 =?utf-8?B?MmRieTJZc3pqb1Vrdk1BL1RKY0w2UUNqUUlDdWFHRjRsckxzK3czVTNmejZm?=
 =?utf-8?B?eXZkSUNhTUxXVzNKeUVYOHpBaW9vRUlkTjBxZ3NHNGg3U3NiRFNaUWF4TEFJ?=
 =?utf-8?B?eGpDaUhiV2tJSDE2cEZPYWtmRjg0VmhRZDgrenNnb2tlSHA3VDhielhUUHgx?=
 =?utf-8?B?azg4Wm02aDY5Z0txVGxyaEs0c3drb2VYQmoxKzNuTTRIQkJ2YkRDaFZXL2Yy?=
 =?utf-8?B?a2ViVUx5VHNuSCt4Wld0NWFvM28wQnorL3MxL3gxdmVXMWszbHpjL1ErUEps?=
 =?utf-8?B?cks4b3lnNnBBUEJoQ3M2NC9TQ1JWRGFaYzdKZDQyT2N5QkZrZThrYUV6dE9x?=
 =?utf-8?B?TUVwV0szYmFzUVRhK1BreDNlQW5kZXNWb2FBOWJEVU1CcjJVRXVPelJ3WHBn?=
 =?utf-8?B?R0RLN3VyRmRsaHJ3UnVPRnVWMjV6UlBHb2JyQk04LzRDS0pmd0VDbUc0eGVL?=
 =?utf-8?B?L1Jxb0x3OHZ6YzBrN2lKTVU2cUozTnhWREYybCtRVWdSTnhXZE5ValFkRmJU?=
 =?utf-8?B?b0wwOUUxeFpKWlhuOWNYaTNKRURGR2NreHJCN1lvTnBSamZ1Z0lOZGJwSS8r?=
 =?utf-8?B?RlNERmxVTVU2bGJ5VGF2WG5JU0t4bmltVGdBQi9ZUHA3RWptYXh3VlN6WXUr?=
 =?utf-8?B?ZFFaNWovZ0ZVVjNQcFRjUlMxeUIrZUQ5Z2V1cms4VEpKZDJtYXY4NE80OEww?=
 =?utf-8?B?K1NMSldoRTBjRE5pWmxoR2xNSy81VWRKL2tEK1BDSFBzanNnRTlQTmxCV1Z3?=
 =?utf-8?Q?d/Zq3PSdJLOwoH6Yvk/bMJu38zhNDoUG?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SitJQjh5cDFQWEx1Uno0K0kzeG1SdnZNTG5XV1I0QkxUZ0VvbGlWWE9Wam90?=
 =?utf-8?B?VUdNMjRUcnRIZnpiRjRMMGw3SG9pSFY4YXA5L21iNnZNOXNubkc1RHF3bi9Y?=
 =?utf-8?B?QlFRenc2OSszYUlDdGFYQ3J0M3l4T21CNkE3clo3SFFGL1llZ3BLaC9EbHIy?=
 =?utf-8?B?L1F4dUdadDl0bm0rZkpvaGJNU2pLWE9VMUk2NENtL2g5eE82KzVNaDhkYVdI?=
 =?utf-8?B?ZEVYZW5uZnVsdXMxcVptMzBBOWJnQlpVTmsvZC8xNkxZY2FKWFhBL2gxS2c1?=
 =?utf-8?B?cjN3Y2d4dWx1VmVFOTJENS9ML0dNTUtjYnhwakJzZE5zblB2bFdNTnFJUGsz?=
 =?utf-8?B?ZkdJVHV4cngxT1g1SVBKWkh0Q0pGMmxPa3hoNy8rUldSNGZWTDErdmdmRmZM?=
 =?utf-8?B?aG82bmhCTzFjRUdYTlg2aEFPR0UzbUgrZS8zYXZRZ0V0TFBQeVB5Tk5UVHN1?=
 =?utf-8?B?by9tbURKS2gzWTRqcU9WY3p1N0QyZlpQWnpzUHV3QmV3eUQ5RlNxajh3eVNM?=
 =?utf-8?B?VzdMOHhObmR4Mk14bWI5WXBvMGJRMEpCNFhpZjd4ZUtzb0YyeE05RjlpNFdX?=
 =?utf-8?B?ZHJuQkdEYlBHU2dZRWVzOGpHZnBNZ3pxNkIxTHpxRVdQMnpIdlhadXJvR0pa?=
 =?utf-8?B?SjJWSWFWSjMxUE9JOHZzcjg3L0Fuc1lBWHRrSjcyUWh4V1VMNjE5YzYwZWFR?=
 =?utf-8?B?c2lkYXRoMTZzZ0RmbHgrS1V2eWpFSnhEZnpCRmFnWVVzUEhwUGtGTktTVGdS?=
 =?utf-8?B?QWhyRWQ5SXgrVTRGcDVlZFlBeXI4VitNMUxvRElrS0xMVTJnaGZIMGRDc3Jh?=
 =?utf-8?B?UlNYQVYwd0lCZWlYVmdjLzZUN2wvZVVzbXNKU3k5bFhWMWR0Ky9vU2ZUR2NC?=
 =?utf-8?B?UHIxNjJzUjgvVkkrWUxHWGZVQ2wxL0NIMVdXWXBXQ1pqKzBQYjFZb2tMSmVL?=
 =?utf-8?B?R0ZZMlZ0dWVybi8zbGVFa0FTWEEzei93SThQQzZpeGRGOVZWWjhLWDB3KzJr?=
 =?utf-8?B?N3huYmd3WE9LTlgvc3d3ekhRVlN0Z0JJWXYxTjdGWTlsK0VOano0MTVZUHg1?=
 =?utf-8?B?RHV3MFZTUVdNMTFaK21iVDREMTNXd2kxR3FqeEd1b2l5MGQ0QzY2UjRtNk1Y?=
 =?utf-8?B?N1ZsTXY3ZlUyZ05ZNHFzNjRrT3FnL2pRTlJTWjluZWlYQVRjZWpXZXNqdEJm?=
 =?utf-8?B?TnlJYzAxN2gxd29VT3hXMzd4S2VxMkhIZlkxNUFKc0tBT1ZCZDVvOGs1T2lS?=
 =?utf-8?B?NG5PQ1YzRVJGTjg0TndMWE02RkFrSTZCK3B6S21McnVCNm1tZFVPbEh1VFIv?=
 =?utf-8?B?WnJINDZDb2xWWW9BMHlUbjhPUGlZSDlscnlGY0xPSktCWitaT2ZOZWsvY0hw?=
 =?utf-8?B?WGI2bEZjbkJrWUFkRE5zR2d3eENiL3NQNTJzUUl1eU1mcWlxSDRnME95T2tT?=
 =?utf-8?B?L1NvSDRZVkFwUWYzYmNtaEMrWDUybytEZGxHUnRvdStxR1pXTitPTUcxSnBl?=
 =?utf-8?B?NjVWVXh3dWVHRXQzSzZDQitZbDdra0w0TFgySmlnNFdzM1VQS2Q1QklwcS9T?=
 =?utf-8?B?ZWs1QUdQd2hqNFpHdlRSQTMwS0I4Zy82cTRJVlFkc1JGMDQwU3JHZTlKYWhK?=
 =?utf-8?B?Y0VDUkVNUUs5Q05NM0V0RktleWxHUG1pTkZ0ZmgzN1pGN3I4Um9rWFJuZkRZ?=
 =?utf-8?B?bW9IWnJubGhDYlY2Y2F3Q3FNR2F5NWJHampqZnVuUXIvTDZMSStNMVZoK2Rn?=
 =?utf-8?B?aUxPb0J1alJFdEk1Mi95MVlmLzA5TzA3aXFBSHFjRmRtSGJpZ3NTbWQ5T1F2?=
 =?utf-8?B?eWJHc1QrOEp3ZU50S0dRZldjbk41My9GRXVUcG0waHNBSTJyWjR3T29CalhU?=
 =?utf-8?B?WnduVldLOFpyZlVVbndaeVpLQlZmaCtQRFliZmhQYitIckVDNy9oT2ZCM000?=
 =?utf-8?B?dllsWXBwUDJ3NDVLSUJoUHlDcXgxczdGc3R1NjBrK1BWR0RsMm9WaHUybEZK?=
 =?utf-8?B?UXNLWjkxWFZ5UDhQVkE1Z05HZGRCclBBSGZEeDdjeS96TWpjblRIWU9WN01Z?=
 =?utf-8?B?bGxDcGFWNGsxOHFGMWxTSFUrRmdweDdrcW5UQ3RhTjJ2aFljNXowL0M0dm11?=
 =?utf-8?Q?WbqqZk+V218098hBTL4J+pdxC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE6593A5B811641848DC1F99A72A042@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f00c457d-1f2f-46fb-fb1b-08dd1e65a801
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 06:40:11.5532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTljPm1kyeuSGmv9L1u9Fb90dzlSI2VMaV7iyMs8P4VFnxzmSq0qjQngNpsLLqtt+uPI+F5sgyVXngrRymJ/2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7830

T24gTW9uLCAyMDI0LTEyLTE2IGF0IDEyOjA0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNi8xMi8yNCAwOTo1NywgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBIaSwgQW5nZWxvOg0KPiA+IA0KPiA+IE9uIFRodSwgMjAy
NC0xMi0wNSBhdCAxMjo0NSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6
DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgbmV3ZXIg
SERNSS1UWCAoRW5jb2RlcikgdjIgYW5kIEREQyB2MiBJUHMNCj4gPiA+IGZvdW5kIGluIE1lZGlh
VGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+ID4gPiBp
bmNsdWRpbmcgc3VwcG9ydCBmb3IgZGlzcGxheSBtb2RlcyB1cCB0byA0azYwIGFuZCBmb3IgSERN
SQ0KPiA+ID4gQXVkaW8sIGFzIHBlciB0aGUgSERNSSAyLjAgc3BlYy4NCj4gPiA+IA0KPiA+ID4g
SERDUCBhbmQgQ0VDIGZ1bmN0aW9uYWxpdGllcyBhcmUgYWxzbyBzdXBwb3J0ZWQgYnkgdGhpcyBo
YXJkd2FyZSwNCj4gPiA+IGJ1dCBhcmUgbm90IGluY2x1ZGVkIGluIHRoaXMgY29tbWl0IGFuZCB0
aGF0IGFsc28gcG9zZXMgYSBzbGlnaHQNCj4gPiA+IGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgVjIg
YW5kIFYxIGNvbnRyb2xsZXJzIGluIGhvdyB0aGV5IGhhbmRsZQ0KPiA+ID4gSG90cGx1ZyBEZXRl
Y3Rpb24gKEhQRCkuDQo+ID4gPiANCj4gPiA+IFdoaWxlIHRoZSB2MSBjb250cm9sbGVyIHdhcyB1
c2luZyB0aGUgQ0VDIGNvbnRyb2xsZXIgdG8gY2hlY2sNCj4gPiA+IEhETUkgY2FibGUgY29ubmVj
dGlvbiBhbmQgZGlzY29ubmVjdGlvbiwgaW4gdGhpcyBkcml2ZXIgdGhlIHYyDQo+ID4gPiBvbmUg
ZG9lcyBub3QuDQo+ID4gPiANCj4gPiA+IFRoaXMgaXMgZHVlIHRvIHRoZSBmYWN0IHRoYXQgb24g
cGFydHMgd2l0aCB2MiBkZXNpZ25zLCBsaWtlIHRoZQ0KPiA+ID4gTVQ4MTk1IFNvQywgdGhlcmUg
aXMgb25lIENFQyBjb250cm9sbGVyIHNoYXJlZCBiZXR3ZWVuIHRoZSBIRE1JDQo+ID4gPiBUcmFu
c21pdHRlciAoSERNSS1UWCkgYW5kIFJlY2VpdmVyIChIRE1JLVJYKTogYmVmb3JlIGV2ZW50dWFs
bHkNCj4gPiA+IGFkZGluZyBzdXBwb3J0IHRvIHVzZSB0aGUgQ0VDIEhXIHRvIHdha2UgdXAgdGhl
IEhETUkgY29udHJvbGxlcnMNCj4gPiA+IGl0IGlzIG5lY2Vzc2FyeSB0byBoYXZlIHN1cHBvcnQg
Zm9yIG9uZSBUWCwgb25lIFJYICphbmQqIGZvciBib3RoDQo+ID4gPiBhdCB0aGUgc2FtZSB0aW1l
Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gLS0tDQo+
ID4gDQo+ID4gW3NuaXBdDQo+ID4gDQo+ID4gPiArc3RhdGljIGludCBtdGtfaGRtaV92Ml9icmlk
Z2VfYXRvbWljX2NoZWNrKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ID4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9icmlkZ2Vfc3Rh
dGUgKmJyaWRnZV9zdGF0ZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKmNydGNfc3RhdGUsDQo+ID4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGRybV9jb25uZWN0
b3Jfc3RhdGUgKmNvbm5fc3RhdGUpDQo+ID4gPiArew0KPiA+IA0KPiA+IEkgd291bGQgbGlrZSB2
MSBhbmQgdjIgaGFzIHRoZSBzYW1lIGJlaGF2aW9yLg0KPiA+IFdoeSB2MiBoYXMgYXRvbWljIGNo
ZWNrIGJ1dCB2MSBoYXMgbm8/DQo+ID4gSWYgdGhpcyBpcyBiZXR0ZXIgdG8gaGF2ZSwgYWRkIGF0
b21pYyBjaGVjayB0byB2MSwgYW5kIHRoaXMgZnVuY3Rpb24gd291bGQgYmUgY29tbW9uIGZ1bmN0
aW9uLg0KPiA+IA0KPiANCj4gVGhhdCdzIGJlY2F1c2UgdjIgdXNlcyB0aGUgbmV3IGhlbHBlcnMs
IHdoaWxlIHYxIGRvZXMgbm90Lg0KPiBUaGUgdjEgbXVzdCBiZSBjb252ZXJ0ZWQgdG8gdGhlIG5l
dyBoZWxwZXJzIGluIG9yZGVyIHRvIHVzZSBhdG9taWNfY2hlY2soKSBsaWtlIHYyLg0KDQpJIGp1
c3QgZmluZCB0aGUgZGVzY3JpcHRpb24gaGVyZSwgYW5kIEkgZG9uJ3Qga25vdyB3aHkgbmV3IGhl
bHBlciBuZWVkIGF0b21pY19jaGVjaygpLg0KV291bGQgeW91IHByb3ZpZGUgbW9yZSBpbmZvcm1h
dGlvbiBob3cgbmV3IGhlbHBlciBuZWVkIGF0b21pY19jaGVjaygpPw0KRm9yIGV4YW1wbGUsIHRo
ZSBjYWxsIHN0YWNrIHRvIGF0b21pY19jaGVjaygpLiAoWW91IGNvdWxkIHVzZSBkdW1wX3N0YWNr
KCkgdG8gc2hvdyBpdCkNCg0KICAgICAgICAvKioNCiAgICAgICAgKiBAYXRvbWljX2NoZWNrOg0K
ICAgICAgICAqDQogICAgICAgICogVGhpcyBtZXRob2QgaXMgcmVzcG9uc2libGUgZm9yIGNoZWNr
aW5nIGJyaWRnZSBzdGF0ZSBjb3JyZWN0bmVzcy4NCiAgICAgICAgKiBJdCBjYW4gYWxzbyBjaGVj
ayB0aGUgc3RhdGUgb2YgdGhlIHN1cnJvdW5kaW5nIGNvbXBvbmVudHMgaW4gY2hhaW4NCiAgICAg
ICAgKiB0byBtYWtlIHN1cmUgdGhlIHdob2xlIHBpcGVsaW5lIGNhbiB3b3JrIHByb3Blcmx5Lg0K
ICAgICAgICAqDQogICAgICAgICogJmRybV9icmlkZ2VfZnVuY3MuYXRvbWljX2NoZWNrKCkgaG9v
a3MgYXJlIGNhbGxlZCBpbiByZXZlcnNlDQogICAgICAgICogb3JkZXIgKGZyb20gdGhlIGxhc3Qg
dG8gdGhlIGZpcnN0IGJyaWRnZSkuDQogICAgICAgICoNCiAgICAgICAgKiBUaGlzIG1ldGhvZCBp
cyBvcHRpb25hbC4gJmRybV9icmlkZ2VfZnVuY3MubW9kZV9maXh1cCgpIGlzIG5vdA0KICAgICAg
ICAqIGNhbGxlZCB3aGVuICZkcm1fYnJpZGdlX2Z1bmNzLmF0b21pY19jaGVjaygpIGlzIGltcGxl
bWVudGVkLCBzbyBvbmx5DQogICAgICAgICogb25lIG9mIHRoZW0gc2hvdWxkIGJlIHByb3ZpZGVk
Lg0KICAgICAgICAqDQogICAgICAgICogSWYgZHJpdmVycyBuZWVkIHRvIHR3ZWFrICZkcm1fYnJp
ZGdlX3N0YXRlLmlucHV0X2J1c19jZmcuZmxhZ3Mgb3INCiAgICAgICAgKiAmZHJtX2JyaWRnZV9z
dGF0ZS5vdXRwdXRfYnVzX2NmZy5mbGFncyBpdCBzaG91bGQgaGFwcGVuIGluDQogICAgICAgICog
dGhpcyBmdW5jdGlvbi4gQnkgZGVmYXVsdCB0aGUgJmRybV9icmlkZ2Vfc3RhdGUub3V0cHV0X2J1
c19jZmcuZmxhZ3MNCiAgICAgICAgKiBmaWVsZCBpcyBzZXQgdG8gdGhlIG5leHQgYnJpZGdlDQog
ICAgICAgICogJmRybV9icmlkZ2Vfc3RhdGUuaW5wdXRfYnVzX2NmZy5mbGFncyB2YWx1ZSBvcg0K
ICAgICAgICAqICZkcm1fY29ubmVjdG9yLmRpc3BsYXlfaW5mby5idXNfZmxhZ3MgaWYgdGhlIGJy
aWRnZSBpcyB0aGUgbGFzdA0KICAgICAgICAqIGVsZW1lbnQgaW4gdGhlIGNoYWluLg0KICAgICAg
ICAqDQogICAgICAgICogUkVUVVJOUzoNCiAgICAgICAgKiB6ZXJvIGlmIHRoZSBjaGVjayBwYXNz
ZWQsIGEgbmVnYXRpdmUgZXJyb3IgY29kZSBvdGhlcndpc2UuDQogICAgICAgICovDQoNClJlZ2Fy
ZHMsDQpDSw0KDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiBSZWdhcmRzLA0KPiA+
IENLDQo+ID4gDQo+ID4gPiArICAgICAgIHJldHVybiBkcm1fYXRvbWljX2hlbHBlcl9jb25uZWN0
b3JfaGRtaV9jaGVjayhjb25uX3N0YXRlLT5jb25uZWN0b3IsDQo+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25uX3N0YXRlLT5zdGF0
ZSk7DQo+ID4gPiArfQ0KPiA+ID4gKw0KPiA+IA0KPiA+IA0KPiANCj4gDQo+IA0KDQo=

