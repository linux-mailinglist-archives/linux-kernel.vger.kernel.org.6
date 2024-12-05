Return-Path: <linux-kernel+bounces-432517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176D79E4C64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF24D1642C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DA0187FE0;
	Thu,  5 Dec 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TwKG1dkF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="F+9wDdeW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2EBE49;
	Thu,  5 Dec 2024 02:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366540; cv=fail; b=T4WegxlgJ0N4RR62GrbZCydw3hHEgHJuDUalscIf5NlmP7OSpThbGJKFN42b1foxt2kmnI3Ve8lyeen/YBYQ7ALtkUZVS6tON9kIWbim0933ewQ2EcsEIApHGZd8YVUVc9I2Eu2VgPnFC7JcDoxQHs33SHQ8WdjAS1xQgIJtLrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366540; c=relaxed/simple;
	bh=B8SEHYFyqJj0zt33DLRFYsipfdnUpuZlUXgBF9npMjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TlUY5MhkOMoHAhWgVAKC+D9cxyjshIZEpTtZBTkMtYARYBydjLA4pcutHRGVqTQDmsbnUqusac9vVD6tsUQbpCtTNHF0/u3mA2SSUTo4Mv6U3vvyP61BP5gOAYAETzeIgssgf0cnyxcCe5jlJ8jkCSGDVmur1B9YDm+TFi6ZS6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TwKG1dkF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=F+9wDdeW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 839644e6b2b211ef99858b75a2457dd9-20241205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=B8SEHYFyqJj0zt33DLRFYsipfdnUpuZlUXgBF9npMjg=;
	b=TwKG1dkFYAzJT8tJDSbS4qiHWUtTcvk7f9mwNG+dDOvtFewl+Hg/MlscNqQIhzUjcCrtzEHPK2frdoA8hVdaRy86drGj9l1BiclpGbkCSwbnE3VtsjYQkM3I5QwHtiYNiUTTlRpyZ7wUA+pwm6fzcfDQfJc/JIOjC7vX844Qqs0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:ff6010a2-62f4-4a7b-ab27-40f592f182ac,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:c16b743b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 839644e6b2b211ef99858b75a2457dd9-20241205
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 598886497; Thu, 05 Dec 2024 10:42:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Dec 2024 10:42:04 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Dec 2024 10:42:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psP/83Pxe2gI6BidcQ3GlRTXlNRt3b1xnPUiUIynCtM3JmKl8XZg+6y34tWzBNhgAcjmAitkpeyZsnPoDyVeVztgd3+w6YiYpL3fzfCVTmwYu7zEpnJKUDqx+SJZnyXqFcqG7UujUtg/3+nIpbjNhkGW/h9v57Pia7xbuwqDe7e+UqbpvNRmjK5Xsa+PfYtBaTkwv9mJHpeqMeE4nmtFRi86glJKqNBjndyx3KczM8UV6HMr3TD6tgIw404rVctVbO7xZtpgCZAa8KrZhpneTsD5EIsc1YlILS7Sa1OQRjrD2lMb9clNVFXbbMiNeeGws5uE20PH7Wekz4b3Kf4YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8SEHYFyqJj0zt33DLRFYsipfdnUpuZlUXgBF9npMjg=;
 b=g2SOi2wpOhJaKDO6go2jWo5lIPax75wbd3ROKwbmH/qls/ZgjahhQ4JU93W5roClx4fu/4PpZJzNUv8Fv8Otegbrv+SKaAWcARlLiSSgvFBvuLhohe9T3GEdYhuciHJ7n6k0XV4CKw6Ic445xxi3Gzj0lI2QReGRkKntsryoOF6v7cn8dwSyngyMk2rVVNCWfySOqgevCJ8uQvL42j34FKhldzl9dsDSw6p3K+KQBu1tcCjRW7vAEm7xMPgHRdJn1eUkJprl0yTAfcdth5bmwfAo6vjHalgeo/ytAFzJPF7kfGgI+173mFEokRShqXzBBiU6+53i5wor3BoLz7msOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8SEHYFyqJj0zt33DLRFYsipfdnUpuZlUXgBF9npMjg=;
 b=F+9wDdeWfLp/OejXMuNITgMRC/SZaAigljf5XB/4I5RdMEdU34WmGf+xT1mHR0dfC5ainXernZ8dXsdgVV8VvTGEeAcQtvKLL9zMVluJk1FFQsKJvC8WgFcIKZjYRR4l3xU3s2B4IDzS54p6jSr+z8135h9RbKMWYcJHJxhuBUs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7777.apcprd03.prod.outlook.com (2603:1096:101:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 02:42:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Thu, 5 Dec 2024
 02:42:01 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "kernel@collabora.com" <kernel@collabora.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "mripard@kernel.org"
	<mripard@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbO0pF3Zp6UXdpSEmkHbI6wNkmT7LSoNaAgAOetwCAAMhiAA==
Date: Thu, 5 Dec 2024 02:42:01 +0000
Message-ID: <6bba26909f2fe0686c2584536f7a080451f768a1.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
	 <559ac08df6614e47c3e8d9d8160b35c9e683c503.camel@mediatek.com>
	 <716b8630-66ef-4497-8cba-d5d20da2382a@collabora.com>
In-Reply-To: <716b8630-66ef-4497-8cba-d5d20da2382a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7777:EE_
x-ms-office365-filtering-correlation-id: 7916eaef-ede4-4396-3b6c-08dd14d66548
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dDRoUzZyejdHTHRKNElXMmpHamdSWlZrNFBzWjEzQTc1cW9SQ0JpREN4YXp2?=
 =?utf-8?B?N2NwM3FEcmhQeExNenRDQ2xONVpsaThUOFh0ai9CazdpNGRPU2ZwVEQyUmF5?=
 =?utf-8?B?K1RmcUVCdjllTk4zUXE5V3N1NEJrSGNUTGNIeTIzbkpaejgzSjhySHdxZWl5?=
 =?utf-8?B?UkM0L2JhT3J6cHdEamVDVVVwVXBiL0J4RWxhQVVHTzMvcWt5SmJ2dGF2R3pG?=
 =?utf-8?B?SG5VekU2cE0vb0VqcE44azRLUmRkTEZWQkRyWStRQXYyMUM3d0dRQ2dmQ2p0?=
 =?utf-8?B?RmFQbEpFeEk1eFlLa0JIK01ESHlSMGVnTmtTTkthMExITVd0ek1naUtzZFlS?=
 =?utf-8?B?RWlHaHRFWW9ENlQwS3M5cnRSZzBzcjFKbmNLTGZscU9FVUZ4Z3VWdkpvTnBw?=
 =?utf-8?B?TUJxMU1NZVpaNU53ejNWejdVclFEak1md0RxNndxcmdpOUpYaGpIU3p1a3pD?=
 =?utf-8?B?SFJNN01UWW1raURwUlppYTFieHdmaGdLdlhHYlpUQmNyMEUwZU40Q21LNndC?=
 =?utf-8?B?TXF5eDI3WXVPbG1aNjgyakhqR0x3UWMzb0R0U05vWlgyRzRwOSs5TFc0SU5i?=
 =?utf-8?B?VHhmblZRckNWZ2hPSUZNeFBpM05IKzA3U1hmb0J3Rk9WK3pkMk9DdlgyNzQx?=
 =?utf-8?B?RWZCdXZURnhtZDlLYXVFSkNxSk05THBmanB0Q3BqKy9kNi9kUmE0UUdqZ05y?=
 =?utf-8?B?aU1kNldLQk5hZ21YU1pJY2ZjcUx3MVlRZys1VWplN2VxU0w1aVpEZkphNzlJ?=
 =?utf-8?B?dlVvQTI2SXlPWFZaOWp0QUNqQXBybDFOZWwvY3htVU16bHVwc2RxVWZsSmlL?=
 =?utf-8?B?L3MxbzUzNzZrRU9DY3JrTWdzRlV0QUFZSUtLVmkvaGNWS3g5d2UyR1o5QVcv?=
 =?utf-8?B?ckI1aEY1MlJxcEpSd05OQzRDR2FKUWhKM2xEcXRRem5QeEoydkxCR3FNQkNE?=
 =?utf-8?B?ZnA0S0IxcTNPU29qRTlITDFGVnQ2UEwwWlRWd1NROEVUcGVRWkIycFNuUW14?=
 =?utf-8?B?VkRxTkRmZEJ2RnkwdEpvd0ZYeXVGclF0UjRwNkR5QURrcjNKK0VFYkEyMm9v?=
 =?utf-8?B?V08zYjhwOFlEODk5b29DdGZZRjZ6LzYxbWwyMm9NM3FOakVHVHhyeC9ybGN3?=
 =?utf-8?B?WEh5blhNSGdsblNHcmEzNGdIS2lENHlBbThjd1lmOEhkMmFqaERIRWZBdm54?=
 =?utf-8?B?RHFvaGJ6NVUxL1VtSE9VTEl1bVdTblc1U3lqMDFnaWFoVzNGTXV3WDNyQVNq?=
 =?utf-8?B?ZE9RSC8yS3lkZXZNZjB5cFg1RlZUWXp5L3lrUXRIVlJXamljeXo4bFkwY0lX?=
 =?utf-8?B?RzhxT1dMaDdpRzV0MEZTYTE2Mm1xV2tHa0hUTXNvNTM1aElKelZ0UkNrcERS?=
 =?utf-8?B?KytWb0c3aEJlTFhxbVBMM1JwTVlSWFRkTWlWZTIvWkMweWF3TyszMjVvdDJo?=
 =?utf-8?B?VlFFcVN5VHA1VjloRXI3dUpJc1N0S0FkdjhzZmJjRDlZKzFhSDN1V0ZOdTgv?=
 =?utf-8?B?UllPRHprUC9uemtsdUhPdEppakFUK3NFWkhTQ0hPUEFtblJmMFJLVGg5dW9J?=
 =?utf-8?B?NU0vdnlIaTBOOUsyQkVSLzJuNXo2YkQxVkUzd2IrTHVkNFFCL2xNQ2hVK1FD?=
 =?utf-8?B?Z2hPOWlHMjVUd0RiaithVGZhMVZrVlpGVGR0TnJRNGxDRklZdWZtRGlmaGgr?=
 =?utf-8?B?WVN3cG1GOGJlQ2Ftd084TC9RcTlaaHl2Z2p4RG42NUlLMUhqamxKQVZRcElP?=
 =?utf-8?B?Qk42bGF1VDBhK2tXK1NLT3dycnJBUUd2STUyK095aktjcWpFQ01lM3dHdWxO?=
 =?utf-8?B?K3Q4c2gyTk9ac0Jab1B3MmZZNlF6SDFGQWV6bHdzMW1wcXUyTEg5alYzQmEx?=
 =?utf-8?B?KzJ1WmlBdS94SVdmSkNvaHQzMEEyYXJSLzZvMnkwNGdMamc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjRXQlEraU94UEJaV3liTytaQVlMZjNycmc2c3ZzUDJUeG1CZDVCL01VdHhM?=
 =?utf-8?B?cDFBVmVia05XOW8wWlBtd3RDVjZseEVVUzBRcVo1dU9vYXpCL1BBM0NZUmhY?=
 =?utf-8?B?NG9rSkR6UDhlc3RpdERia2VrOGc2UXZCZVVzT3hpVlFtTjdGbGdJekkva092?=
 =?utf-8?B?bHpjUGowRmt1aEpSc0EyME1aZ1pBWm9QT0NZUjUrNHFzdkwxMEZaSHpwWUY4?=
 =?utf-8?B?SUFTODlCdll3c2FXMmxqdXR3RzNRcnBOY2FRbFArdkp0L0VxbndkRWx3RUVE?=
 =?utf-8?B?M0R0clZkbktLakhJY2FsTEdualFPY3ZlbndGMVF1a3BvODFoaHJCU3FWaTZ6?=
 =?utf-8?B?RUtTa1lpQ0ZiKzE2dmI0T21JcS80NjRLL2EwQ1U2djZHYmZzN3U1ZFhTZE96?=
 =?utf-8?B?VStJWTFEQ1VUR1k2SytVeEtNWGVtNXJ3NTJ0OTVTdG4zY3pqd05Xa2QrVVdj?=
 =?utf-8?B?N2F5TmNkdTNZSkptOGFMRmNraks1bHhxODA4K3RpRWIvZWFPdDFKM2VqVlY2?=
 =?utf-8?B?NU5FNjNEOEFSVFdrWkRvM1kwWW5jRjF1N0JUaGdVUHRQajhBZVhzNVBwbzN0?=
 =?utf-8?B?K3BQc0V4WHhWSTh1ZkVCUEhIblN2LzlJbjBrV3VvcUJKRk01TkluLzRCM2xS?=
 =?utf-8?B?aWtCNkFsc2JGcXpJQzNvSWh3TzNIS0tqcXlaRHBhS000YVlKV0lYRUpVVU1Z?=
 =?utf-8?B?ZXpQOU8waDZXbEVLd1F0THU0N1prU1BDbXB2UjdtVndoazNtbU43aHM5S1Jz?=
 =?utf-8?B?am10c3JFTFVsazZEMjhIcE5tam9MVlJ6WGRxOForeE43TGdjbDBtcE9VZkRI?=
 =?utf-8?B?dzRWZ2UwV201Z0N5a3B0WjR2Rmw2enprTlV0N3FLY2xFMkY3MHpXYWdKSUtI?=
 =?utf-8?B?MnRoWHZwOHF6dENweW9YL2R0a1VkTlgyQ211aWl4T1JpRGkzNk91WU0xd2o5?=
 =?utf-8?B?ZnYzcnFTdHJzd0NSV2doeE1uLzdhQW5rZ3hnTUlVeUw0OEtyREFkZjloQjhW?=
 =?utf-8?B?akFHNlE4cklNb2ZvTU51d2wxcXRVTENJWndWUE8zZFlGVEI3VGNOT2VVR2hT?=
 =?utf-8?B?aldONmYrcWo0clpvclBHUjZEY05pRkdOVEJvSE9Ja2ladkZ5by9UVDVIOHpr?=
 =?utf-8?B?b2ZCSHVST3ZHTExiRVE4UVlJVXhQenVJRVZkcDkydDFXdWI5aTI4ZnpmRXYz?=
 =?utf-8?B?UzJBaGZMRlhQTC96VlFXQmY3N3hwUHgwL1M4OUpzbXhpeXpNQ1FYMFgyeXZs?=
 =?utf-8?B?TXN3WXB3YWtvV1VtL2RDYTJmOHIwaC9OYkpkSFRXNXlzek4zOS9OV2pjY0NO?=
 =?utf-8?B?Sm5aTHJrTHF4NlZ0SG0rdTNra1RaYWJwdUtHeVpseDhMQ3dyU2ZlWkpWTUds?=
 =?utf-8?B?YmRxOUM3cGlxTnc3aHFGaDFIck9MQ1hhMjBiNDVRUENsc0xZUXN1QzNmb1lo?=
 =?utf-8?B?TnFIQVVQUGRDUEtXNEdMOHcvWnpLTEprb0VaU0pYc00xZXhTaEkxS01VTWpx?=
 =?utf-8?B?RTRERXpXcksvM3hDZ2JEK1JYd3MydmJOVVJnVkQyZEFCTE90M0ZWRXczSGFB?=
 =?utf-8?B?eHZ3dk9wbzVyK00rbEtGWGdrOGw4b3hQTkFHM1FmRDVpcXpleHlxTEZuMlZs?=
 =?utf-8?B?RkdvM1lINHQ3THg0dDhpWDRyZE1PRTg5L3A1YWJIYmNHUzZTYjdZaUxoL041?=
 =?utf-8?B?K1d3TS9nWTF5bFo1bDBvWUlkZFd5cTZURm1mZXIyT2p1cStsbThTVGJhKzdF?=
 =?utf-8?B?M0ZsQjF6Ty9TNUhSdWd6aFI3bEM5VkI1RkhVTWxoelJpdXAxOXpFMDBRRTF3?=
 =?utf-8?B?VDRUN0FnUlVyZS8zTnNra2lnZDM1OFN1YUdteHp0d2tEeGxqV1B4NGtONHZa?=
 =?utf-8?B?RGNOOUlKSUpYakEydnplS2hwTEhHRnk4TGZCRzJCUHU5aGYyb1c1aXNqTEhp?=
 =?utf-8?B?WkdvRVpsRGp6SHl4MmVCR0x1c2I5dS9MbjhhTFVOSFRiUlM5aDVwK2ZFa3BH?=
 =?utf-8?B?Unl2WjdNNG1DSGNSVlZYbytnUERoRnYwTFIwdXVrai84czBGZDF4cGFVczd2?=
 =?utf-8?B?ZXJCcUNTd0RDaFNKczhXZUhHaFR2RXdieFFjUndMTHc2SHhRZXVEb2ZLUGZK?=
 =?utf-8?B?YUxBY2w1M29lN0ZQV2k0bjdCQnBoZ0k1S2h4ZWppRW1QclgzVzRuWS9mQXdT?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32C50BFEB82C04428918278C887DB962@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7916eaef-ede4-4396-3b6c-08dd14d66548
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 02:42:01.0980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlWXJGwg3Z8sHWuRIfFN4l/EPF+lbO1SL6uO8bxnJn/BCrU+dSq11roLhmYzUBPWokhPt6EKCnEGkb1rTwmQzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7777

T24gV2VkLCAyMDI0LTEyLTA0IGF0IDE1OjQ0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMi8xMi8yNCAwODoyNywgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBIaSwgQW5nZWxvOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAy
NC0xMS0yMCBhdCAxMzo0NSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6
DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgbmV3ZXIg
SERNSS1UWCAoRW5jb2RlcikgdjIgYW5kIEREQyB2MiBJUHMNCj4gPiA+IGZvdW5kIGluIE1lZGlh
VGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJpYW50cywgYW5kDQo+ID4gPiBp
bmNsdWRpbmcgc3VwcG9ydCBmb3IgZGlzcGxheSBtb2RlcyB1cCB0byA0azYwIGFuZCBmb3IgSERN
SQ0KPiA+ID4gQXVkaW8sIGFzIHBlciB0aGUgSERNSSAyLjAgc3BlYy4NCj4gPiA+IA0KPiA+ID4g
SERDUCBhbmQgQ0VDIGZ1bmN0aW9uYWxpdGllcyBhcmUgYWxzbyBzdXBwb3J0ZWQgYnkgdGhpcyBo
YXJkd2FyZSwNCj4gPiA+IGJ1dCBhcmUgbm90IGluY2x1ZGVkIGluIHRoaXMgY29tbWl0Lg0KPiA+
ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5n
ZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gLS0tDQo+ID4gDQo+
ID4gW3NuaXBdDQo+ID4gDQo+ID4gPiArc3RhdGljIGludCBtdGtfaGRtaV92Ml9lbmFibGUoc3Ry
dWN0IG10a19oZG1pICpoZG1pKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgICAgaW50IHJldDsNCj4g
PiA+ICsNCj4gPiA+ICsgICAgICAgcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChoZG1p
LT5kZXYpOw0KPiA+IA0KPiA+IFdoeSB0dXJuIG9uIHBvd2VyIHdoZW4gYXR0YWNoPw0KPiA+IFNo
b3VsZCBob3QtcGx1ZyBkZXRlY3Rpb24gYmUgYWx3YXlzIG9uIHNvIHBvd2VyIG9uIHdoZW4gYXR0
YWNoPw0KPiA+IElmIHNvLCBtYXliZSB3ZSBuZWVkIHRvIHVzZSBDRUMgdG8gZGV0ZWN0IGhvdC1w
bHVnIGJlY2F1c2UgQ0VDIGhhcyBsb3dlciBwb3dlciBhbmQgSERNSSBwb3dlciB3b3VsZCBub3Qg
YmUgYWx3YXlzIG9uLg0KPiA+IEFzIHlvdSBkZXNjcmliZSBwcmV2aW91c2x5LCBDRUMganVzdCBu
ZWVkIHNvbWUgaGFjayB0byBzdXBwb3J0IGJvdGggSERNSSBUeCBhbmQgSERNSSBSeC4NCj4gPiBT
byB0aGVyZSBpcyBhIHNvZnR3YXJlIHNvbHV0aW9uIHRvIHVzZSBDRUMgdG8gZGV0ZWN0IGhvdC1w
bHVnIGluIGEgbG93ZXIgcG93ZXIgbW9kZS4NCj4gPiBBbmQgdjEgdXNlIENFQyB0byBkZXRlY3Qg
aG90LXBsdWcsIHNvIGl0J3Mgd29ydGggdG8gbWFrZSB2MSBhbmQgdjIgaGFzIHRoZSBzYW1lIGJl
aGF2aW9yLg0KPiA+IA0KPiANCj4gQXMgSSBzYWlkLCB3ZSBjYW4ndCB1c2UgQ0VDIHRvIGRldGVj
dCBob3RwbHVnLCBiZWNhdXNlIHRoZSBzYW1lIENFQyBjb250cm9sbGVyDQo+IGNhbiBiZSB1c2Vk
IGZvciBib3RoIEhETUkgVFggYW5kIFJYIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KPiBJZiB5b3Ug
dXNlIENFQyB0byBkZXRlY3QgY2FibGUgYXR0YWNoIGFuZCB5b3UgaGF2ZSBib3RoIEhETUkgUlgg
YW5kIEhETUkgVFggZHJpdmVycw0KPiBwcm9iZWQgYW5kIHJlYWR5LCBpZiB5b3UgYXR0YWNoIHRo
ZSBjYWJsZSB0byBIRE1JIFJYIHBvcnQsIEhETUkgVFggd2lsbCB0cnkgdG8gZ2V0DQo+IGVuYWJs
ZWQgYW5kIHdpbGwgZXJyb3Igb3V0Lg0KPiBTYW1lIGhhcHBlbnMgaWYgeW91IGF0dGFjaCBhIGNh
YmxlIHRvIEhETUkgVFg6IEhETUkgUlggd2lsbCB0cnkgdG8gZ2V0IGVuYWJsZWQgYW5kDQo+IHdp
bGwgZXJyb3Igb3V0Lg0KPiANCj4gVGhlIG9ubHkgd2F5IHRvIHVzZSBDRUMgZm9yIGhvdHBsdWcg
ZGV0ZWN0aW9uIGlzIHRvIGRldGVjdCB0d2ljZTogQ0VDIGZvciBIRE1JDQo+IFRYL1JYIGNvbnRy
b2xsZXJzIHdha2V1cCwgdGhlbiByZXNldCBib3RoLCB3YWl0IGZvciBhdXRvZGV0ZWN0IGluIGJv
dGggY29udHJvbGxlcnMsDQo+IHN1cHByZXNzIGVycm9ycywgYW5kIHN0YXJ0IHNpZ25hbCB0cmFu
c21pdCBvciByZWNlaXZlLg0KPiANCj4gV2hpbGUgaXQgaXMgdGVjaG5pY2FsbHkgcG9zc2libGUg
dG8gZG8gc28sIGl0J3MgdmVyeSBjb21wbGljYXRlZCBhbmQgaGFja3kuDQo+IA0KPiBQbGVhc2Ug
a2VlcCBpbiBtaW5kIHRoYXQgb24gdGhlIG5ldyBTb0NzICg4MTg4LzgxOTUpIHRoZSBDRUMgYmxv
Y2sgaXMgZGlmZmVyZW50DQo+IGZyb20gdGhlIG9uZSBpbiB0aGUgb2xkIFNvQ3MgKDY3OTUsIDgx
NzMsIGV0YykgYW5kIHJlcXVpcmVzIGFuIGVudGlyZWx5IG5ldyBkcml2ZXINCj4gdG8gZ2V0IGl0
IHdvcmtpbmcuDQo+IA0KPiBVc2luZyBDRUMgZm9yIGhvdHBsdWcgZGV0ZWN0aW9uIHdvdWxkIG1l
YW4gdGhhdCB3ZSBuZWVkIDMgZnVsbCBkcml2ZXJzOg0KPiAxLiBIRE1JIFRYDQo+IDIuIEhETUkg
UlgNCj4gMy4gQ0VDDQo+IA0KPiBUaGlzIGlzIGJlY2F1c2UgdGhlIENFQyBpcyBzaGFyZWQsIHNv
IHdlIG5lZWQgdG8gaGF2ZSBhbGwgdGhyZWUgdG8gcHJvcGVybHkgdGVzdA0KPiB0aGUgZnVuY3Rp
b25hbGl0eSAtIGFuZCB0aGlzIGlzIG5vdCBwb3NzaWJsZSB0byBkbyBhbGwgYXQgb25jZS4NCj4g
DQo+IFRvIHNhdmUgc29tZSBwb3dlciAobm90IG11Y2gsIHRob3VnaCEpLCB3ZSBjYW4gZXZlbnR1
YWxseSBnbyBmb3IgeW91ciBwcm9wb3NlZA0KPiBDRUMgZGV0ZWN0aW9uICppbiB0aGUgZnV0dXJl
KiwgYnV0IHJlYWxseSBub3QgcmlnaHQgbm93IC0gYW5kIHdlIGNhbiBkbyB0aGF0IG9ubHkNCj4g
YWZ0ZXIgdXBzdHJlYW1pbmcgYm90aCBIRE1JIFRYIGFuZCBIRE1JIFJYIGRyaXZlcnMuDQo+IA0K
PiBUaGUgcGxhbiAodGltZS9lZmZvcnQgcGVtaXR0aW5nISkgd291bGQgbG9vayBsaWtlIHRoaXM6
DQo+IA0KPiBTZXJpZXMgMSAtIFVwc3RyZWFtIEhETUl2MiBUWCAoSFBEIHRocm91Z2ggSERNSXYy
IFRYIGNvbnRyb2xsZXIpIC0gZHJpdmVycy9ncHUvZHJtDQo+IFNlcmllcyAyIC0gVXBzdHJlYW0g
SERNSXYyIFJYIChIUEQgdGhyb3VnaCBIRE1JdjIgUlggY29udHJvbGxlcikgLSBkcml2ZXJzL21l
ZGlhDQo+IFNlcmllcyAzIC0gVXBzdHJlYW0gQ0VDIGRyaXZlciAoTm8gSFBEIGluIENFQykgICAg
ICAgICAgICAgICAgICAgLSBkcml2ZXJzL21lZGlhDQo+IFNlcmllcyA0IC0gSW1wbGVtZW50IEhQ
RCBpbiBDRUMgYW5kIHVzZSBpdCBpbiBIRE1JdjIgVFggYW5kIEhETUl2MiBSWCAtIG1lZGlhLGRy
bQ0KPiANCj4gWW91IGNhbiBzZWUgaG93IGNvbXBsaWNhdGVkIHRoaXMgaXMgLSBhbmQgSSdtIHN1
cmUgdGhhdCB5b3UgdW5kZXJzdGFuZCB3aHkgdGhhdA0KPiBjYW5ub3QgYmUgZG9uZSBhbGwgYXQg
b25jZS4NCj4gDQo+IEFkZGluZyB1cCBzb21lOiB0aGUgSERNSSBkcml2ZXIgaXMgdXNlZCBvbmx5
IG9uIElvVCBib2FyZHMgZm9yIG5vdywgd2hpY2ggdHlwaWNhbGx5DQo+IHJ1biBvZmYgQUMgYW5k
IG5vdCBiYXR0ZXJ5IC0gc28gdGhlIChhZ2FpbikgdmVyeSBsaXR0bGUgcG93ZXIgY29uc3VtcHRp
b24gcmFpc2UgaXMNCj4gbm90IGNyaXRpY2FsIGZvciBub3cuDQoNCklmIHlvdSBwbGFuIHRvIHVw
c3RyZWFtIEhETUkgUlggZHJpdmVyIHJlY2VudGx5LCBpdCdzIE9LIG5vdCB1c2luZyBDRUMgdG8g
ZGV0ZWN0IGhvdC1wbHVnLg0KQnV0IGZvciBhbnkgYmVoYXZpb3Igd2hpY2ggaXMgZGlmZmVyZW50
IHdpdGggdjEgYW5kIGl0J3MgcmVsYXRlZCB0byBDRUMsIGFkZCBjb21tZW50IGFib3V0IENFQy4N
Cg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KPiA+IFJlZ2Fy
ZHMsDQo+ID4gQ0sNCj4gPiANCj4gPiANCj4gPiA+ICsgICAgICAgaWYgKHJldCkgew0KPiA+ID4g
KyAgICAgICAgICAgICAgIGRldl9lcnIoaGRtaS0+ZGV2LCAiQ2Fubm90IHJlc3VtZSBIRE1JXG4i
KTsNCj4gPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gKyAgICAgICB9DQo+
ID4gPiArDQo+ID4gPiArICAgICAgIG10a19oZG1pX3YyX2Nsa19lbmFibGUoaGRtaSk7DQo+ID4g
PiArICAgICAgIG10a19oZG1pX2h3X3Jlc2V0KGhkbWkpOw0KPiA+ID4gKyAgICAgICBtdGtfaGRt
aV9zZXRfc3dfaHBkKGhkbWksIHRydWUpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgICByZXR1cm4g
MDsNCj4gPiA+ICt9DQo+ID4gPiArDQo=

