Return-Path: <linux-kernel+bounces-240395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094B8926D2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B291F283992
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 01:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04DC13C;
	Thu,  4 Jul 2024 01:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UEurOwSf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="AxoLUZVK"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E18F5E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720057421; cv=fail; b=ZvAC1P2geVICt4l5HZzgpgWAXOoHNWacVaDwHzI2UCXwCFPR8CTTXidYPNo+wDdwhyAsiQMFSp6prbb4UGvRNlbMz3PSIGfbZce+/2DC97Xued/+Z5EsN644vNhOZlZaU97t1IHuchsPxV7RqplDYapwiFt7VUDpkH60khMOxXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720057421; c=relaxed/simple;
	bh=+xmXI/dzh5uWdNk2vDmCv1TYyEdH01/ceZKE1Wwwhfs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JZlLu+yDvO59Xe1jZh7zM9SkgXhBu2+k1p7njsLO2t79NPPLX5Kf//J2piMBc7ub2BIJzgkV9lLxKofUH8SD6h4ESLFJhqg0YZQ455212yHteNuni6kdTHKpKntOVJyNocqwtDWlp57ZAk0DQ+/8eV9J0idflHAqvqByaBXqTCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UEurOwSf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=AxoLUZVK; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d2fd52e839a611ef99dc3f8fac2c3230-20240704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+xmXI/dzh5uWdNk2vDmCv1TYyEdH01/ceZKE1Wwwhfs=;
	b=UEurOwSfjLkJPe6/MugYnR8Us+A01Ny8LrR4EIuXVICrfGaBHuCaeiOTnfJSF3mod6aeaB0mBJDgodMYZSV1cFFs8U+XZk3rJocWJcT7PKDPFCyZgN2E7PaXkqa+wQ/6UhWrGuqxKMNzVP3/FtEcaec4e1b/ovRHTFaEC8JtENU=;
X-CID-CACHE: Type:Local,Time:202407040935+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:3b93be78-2fc3-462e-8806-9ad70f8de821,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:946c10d1-436f-4604-ad9d-558fa44a3bbe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d2fd52e839a611ef99dc3f8fac2c3230-20240704
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 497471600; Thu, 04 Jul 2024 09:43:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jul 2024 09:43:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jul 2024 09:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWAqLCW9PsXxeVKF6m/Juo4WLlNEs6U8nVtzb6u0PtF0xXYM3x7bb/XQkBHbBtyfUxxO/jPFAaPi9thGomQYrhN31OUO5P4U3VRtIqof/H4YIU0ewUjBZ3NdPhaFcWOL4Gwe7QUyREwPtcgoVxxLlBeA7PN9ONUyCQfHjNtt0kI9L4gN31kgPa8R8HxKbnORwIk4hC+nLUR2veT7CqEMOvI9TrjrEb0IStol1DCxEvsg9pueHdx//ZxQkeWbfwlh6h1KE50qGxmYPxIpTbnhoRYB9gyyWGLgueuAqTxXO8FEo4pzCURbGvYXSow8VPRRK5V2aSxy4233/OX8EblFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xmXI/dzh5uWdNk2vDmCv1TYyEdH01/ceZKE1Wwwhfs=;
 b=Ov0snhDkcXvnWEAAFjiBXVR30WW3k1i0K6WuiLF+ea0PxehFZ2wGZFEcor1LfwN7o+BGWBVtp/pe95MU0fsBN7FUbbFu7D6prpnhUzF8MZaJevPzhOYlYkXybdHXp5dcDj3Pgmj/BFvVHaSHMGwwhsNEOm7VIuK4VeJpLrPlCO/j63S+4YI0v8eCOC2725wqaGY8tpvX1U0AJA6ue7fJVZxBku7br6Ojgbqx7YtPAWRPRA2KHKlJC4TJ+prbC36uDMGW6SIIypeS6rkh1oKZFtOtDTLx9dipjwRy1T+aVHl4gbQxLXstU5QJOWOl/nc/cQQardQnPyB6pE7tmcFLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xmXI/dzh5uWdNk2vDmCv1TYyEdH01/ceZKE1Wwwhfs=;
 b=AxoLUZVK9Hf/soyzdMbPvWvXbVvABtgWL0iujGPslLOJQ5bFDzrXLOPPBEIDtSBOOaKww/o+/fZ06PbCCsZ09Z5FZyYxASc6K4WPfOPG8vlbuGVnBvdhQXsxJaHuIskHptn7a3Uha598iWrdvjQD4ySdaeK6Tcx+kBky0y116tI=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by SEYPR03MB7414.apcprd03.prod.outlook.com (2603:1096:101:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 01:43:30 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::8212:6c81:8e8d:1f7a%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 01:43:30 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "airlied@gmail.com"
	<airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Topic: [PATCH 2/5] drm/mediatek: Support "None" blending in Mixer
Thread-Index: AQHawm4CehGZ7j4H80uVSodFizERF7HhNh2AgASsKoA=
Date: Thu, 4 Jul 2024 01:43:30 +0000
Message-ID: <278a57fc81fb803ffc65d4805c321cce4b6952d2.camel@mediatek.com>
References: <20240620-blend-v1-0-72670072ca20@mediatek.com>
	 <20240620-blend-v1-2-72670072ca20@mediatek.com>
	 <5374029c58dbb4e2c23f86e74eabbde7b2ae7b78.camel@mediatek.com>
In-Reply-To: <5374029c58dbb4e2c23f86e74eabbde7b2ae7b78.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|SEYPR03MB7414:EE_
x-ms-office365-filtering-correlation-id: 5b261704-2865-4dd3-fa60-08dc9bcab54d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Zmdvcm1Xa0pGalRTWWcxU0daU0xHM1g0STNtQkI0Y28zaE1mcllTMEJ0YU9q?=
 =?utf-8?B?d0QyamdINmxqY3d6NWc1UXN4bmlyL3lqeVc1Y2Rvay9HK2piTHlTZVBvVnM3?=
 =?utf-8?B?cTdkZWQzdmVRR0lTRWZuQjBralFqMVpwaG81dGJxSVU2c2NOeTAwTkd6TlBi?=
 =?utf-8?B?NDBjNmNCTjEyVEhyMWpKcXV3N0t2OXl4Q1pYRU1DcmNiVFlNNzdNaFlYSmph?=
 =?utf-8?B?VEZ5aGdOTkh6akdsZURhTGU1czdTRFlGTXRlSGZZUkVWTWd1bWpMTFFzbkN1?=
 =?utf-8?B?RWNiQ05uNVB2dzMvbXU1c2hsN3RVSlV1ZVlybkF2d3QvTWlCY1dVT3UxSENJ?=
 =?utf-8?B?RGlQTCttdGhISGlXZG0zNGJJdUtEbFRteHV2N1pURWRhMGY4WnJTN0hXcEQ0?=
 =?utf-8?B?eituaGhrVGhvNkZ5dHY4ZUlCVVhwSlo5d1htNHMrakp5TGV6aFRWaWU3aGtH?=
 =?utf-8?B?MzE3Zlg5ckVaTEZ1cDNrZExDcTVmd05zZmhXbks2TllOTCsrL0QzeGFZZXJF?=
 =?utf-8?B?NWk4RnNlbGVNZDJxSVZ2cjg0bDdrVnFVRWxNQVdFK3B6UVNVL2VFMTArWTJp?=
 =?utf-8?B?cHVqNzVBMU1TUXRZcHE4NDVPTmp4bXhjUTNVa3VpM0E2R21DWmFMVDZEL0hw?=
 =?utf-8?B?WElwSHN1VGVPQlg1WmxkbzRLa2Z1SmU4clRzNU9mOUtEd05sUk95NlViRVpH?=
 =?utf-8?B?Sk5qNktXYlB0TlBhaDRRcEROamp5Y2ZrZXNxeEgyR0ZHbkFOOFJLalVNUDZZ?=
 =?utf-8?B?ekdZN05TZlpSK3FOK0xHRW5udHU4RkJIQmVTVUtmcks5Nkl3bXVkSzJvSVpa?=
 =?utf-8?B?K1BWVkJhMzY3bHE1NWFpcTNJQWxpZmRxUm5lTVM4UlFsUm53dHdGYkxqZkl1?=
 =?utf-8?B?WVlreGxUZ1JicC84Z2xpenczU2kxME5hckJ5eTdNR280NE81elFLaVVscG56?=
 =?utf-8?B?MVROSHQ0QUtFVkZOYmkxNURDekxsbmtITHFZU2tkYkhJemF6NVFZcWdZVlJ1?=
 =?utf-8?B?WEFCUUlmbGZRenVoZmRrREE3OUpkc2tnTkFsT3BkRHFiRXZFcVVuWjQ1dU1z?=
 =?utf-8?B?RWdzNG1TN2QzQjM2ZGExQ2JQZkt6ZjE3bjQxdFFOY3hKQk8wNHJuam1Sb1NC?=
 =?utf-8?B?NUxJeERreDRXMmorVDI4NXIvQWNJK2JwSzVDY2V6K0hXQ1pDNDQ1UXVLcGtO?=
 =?utf-8?B?Zm1oK2ZJTnE1TXN0Wm5jZzZady9JWTdxM2FiSldRMmJhYXJqUFhJeWZ2b3Rp?=
 =?utf-8?B?S1grd0tiWm9FcFhvQTY0bjRuZDV0UURtK1J0bkNWY016K0dmNHVZd0pNWUpE?=
 =?utf-8?B?SjA0Ri83NU1CQnhSNndiV1JEUGtmWUZ2ejNUZGRLNDN3SkFVaE96NmliQ3hx?=
 =?utf-8?B?NHhtNTZUcFpOR0JMNEJ6V0d0WFdoZ0Z4TEJjcnZrRDhwVzdFREdwdjNpOEZ4?=
 =?utf-8?B?YmlPdzFYdnluZ20rMk11QVdKZU1hWHlJTkdTSGlOSDQrc2ZReGNQWEhERFkr?=
 =?utf-8?B?eTZWbTUyVW5hbjdvaVRwdVM5RG5NcXZ2OW9hd0lOSWx0VlRFWVJOT01TeUNl?=
 =?utf-8?B?NVo2UEozQ3M4dFBjeGZKL0h3NEN0ZnhISmVTSVJ5NGx6cEdLUDJBQWVRTmVX?=
 =?utf-8?B?T2wyRENlOEgxUHpEcmI0SGRVTFNzZFdHUHIva2ZLcGFLSUVlVHJxS2hDQkdY?=
 =?utf-8?B?Qk1LNzhHWlNoVzN0MVZKNkcwYjJDRWJvbnBRVDJPRGoxbDFqdFUvQklkZUt4?=
 =?utf-8?B?MEZNQlZMZDhLa3lDZ1ZJRGNPdmJodURlMEZRRnhWVGNMeUo1ZWcwSDR0OGs3?=
 =?utf-8?B?emNYMzhZVHRpbDNEaUtVZFBwT29YRTFFRlFrYnVJQlhscVFCNldVa3NMSURr?=
 =?utf-8?B?QW9vMXJ0c1p2OWFQd29vK3RJWlYyWnNydjlBSVpHWUpDaGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXc3UndxU1RFWXFaNjYzdXVBWUZQOVhqY29LQmN5U1c0ZUZ6VjUrRFhTQ21E?=
 =?utf-8?B?WTQ0NFlQVitxM2MwSEdveDhXNUZVaVFLYS9ZbDh6MzZ3cnpndS8xRWNpNFBa?=
 =?utf-8?B?TS9uaXFQdmVoNFV3clFCMnVOUXpXUmdUK3JVWXZRUUFHZllGUVBJSTRrRGox?=
 =?utf-8?B?K1lhbSt0ZElaQTlZWVl3am9aTG1seU5SR3h6anhHSDJOOTEvWDcxZ1pzRnpC?=
 =?utf-8?B?SFBBYitITFZJTVBNNis3Q1NLM0ViK2ZDWWo3UWcvSitocDBMYUpiQ1pqZnlH?=
 =?utf-8?B?VTNucGFuYUsxWFBvTjJKSHhNbzhvdGMyYWwyNlNhdlpMLzRKK211QmpFUDIz?=
 =?utf-8?B?UWZqN0hNRC9WZWhFSXZXbVNuenV4d2xzQnR4SXR6MGsvcC9aTHhZS0hDMStK?=
 =?utf-8?B?bWhpRXVLZnVhZS9PWkk1Tm4zWUlrWnZ5N0pZRHhYa2FFWTlpL2VIemlQN1N6?=
 =?utf-8?B?ZU9rVXJySld0WVRJZDN6WDN3SmVZVFBtS3NVODJHVkdEbGNqSTV4M3k2T1RV?=
 =?utf-8?B?a0dtNEpmOHNmaE1obk14K0xoaThGN09ES1BSSXd2NTAwV1lxYzI1SWtZRXZI?=
 =?utf-8?B?SmYyV3g5QloySlBXejFFaVB1NmhPUVM5TldKNjBqbTBpeEgzbnBLNGUySmhU?=
 =?utf-8?B?VUdlZVhkOXB4VmtETDc1dldTZWtZcVRYTVBuRXp6Ykc5OTdCNktUV3V6cVRF?=
 =?utf-8?B?bUJwZnE1R1U4akVHaWFRckl6ZzQybTNjdGowQzdJWXhkUkt2cVlqTHc5dkEy?=
 =?utf-8?B?VzhnU25NQndYQzNQMCtoZ0RLcFU4R2NUdHYyZThYaFExVUJ1eWtiUFRKVjRS?=
 =?utf-8?B?R1FSNWgwVHp5cnhlZmlLU1BtMU5PemFrTGZTRkxsRi9MNVZPd255UjA2U2E3?=
 =?utf-8?B?L3UxeHdqWU0yTi9ZZDlhN2hJQXQvbWR3N1hQY3hNbmdEcUV0UTlNelYwT1Iw?=
 =?utf-8?B?UVRoMHFqVm54dzdiZjk3OFZ5K2VrVFZzY1ByT0pLWGQwMlhnQWVzMmpUZ2Nr?=
 =?utf-8?B?MGVPUThrSmt2R05NakUyT1RHajgzdFN1Q2hiSUlIcVFnZVRQVjdNSURhL0g1?=
 =?utf-8?B?SjhQeHd0b3BLbTVCbk1YZk1vMWZIQ0ZKUzNpYW5KL1NBUTJBU0YvSmxRQ1dz?=
 =?utf-8?B?bFR3THBZVkljbThYVUxhc1VTbUdYaVB5ZjdLRW96NE00bDcvaTBtdk5QVVZG?=
 =?utf-8?B?Y3FpRmlGYmJuQy9BL0dBbS9NREpEdHE3c1R2elZtaHlvZGZiSCtVR2VsRjBy?=
 =?utf-8?B?VFZDRW5MQ0tHckx6UVJSK2pzRHlOSVJLZlpjZnpJTUpQd25ubEF6WFNsRldo?=
 =?utf-8?B?Mk8zdEppOEpsdnc3cFJNL1dpbGZUZllaVU1Fc0h4RVZaWW9oazY1SzRpOHF2?=
 =?utf-8?B?dEZadnRtWG4vMlNGMmlYYVBERmw2bS9xdzZEek9kaDNUTno3aHEwc1lSVGxk?=
 =?utf-8?B?MGxIekFsbW13b3g1c203MWFlUk5qSFZPc2NpVlRIeCtId1VLYlluMTNxWEhW?=
 =?utf-8?B?ZkVqejA5WGtHcXlsVGhKZEN5ODNUb3NCRVlkTkFYM3V6bHdwZ3daakJJSjNz?=
 =?utf-8?B?R3hIcDNROVNqS2c0dk1pZVRCeGh2VkVUTW1MaHcwYWhTbDBpSGpzZHNsandz?=
 =?utf-8?B?Y2x2WXJPRXlocTVtSkYrQlBKVXlZUnRUMnFsdHd3QkErZHVnVlFSOVJaWm56?=
 =?utf-8?B?SitYSFVzcUtqeE9nQzRYbTh0anNKTXpSN0Z5MnFHVlBBc2dyVUpnbWxhdElZ?=
 =?utf-8?B?c3k3NzUvdWU1cnc0dW9EcWxXeFJNaTVuL3JFOGNSY2dBcXFlVUx6dGtNUUVM?=
 =?utf-8?B?b3JoL0YvZ0w3eDBOSHNuRVJubkE2NlRIQTMzb3Z1VW1UeTRNeWRSSzlpZlov?=
 =?utf-8?B?dStiZWxvVDhSR0dCVU9COC9Zc3JuMy9wSVNNS0tHRGNwbERmc3V0dVUzNzdE?=
 =?utf-8?B?aUUvOWNwcmpzblUwRmI0eWEwajZ1OWZrbGZUUHVxbzQ3WXVZcEx3b3RXQVE5?=
 =?utf-8?B?eW5mUm4zVm82alR5UGpaV0VzWFBvQk9lS0FWd0FWekhiT3l3KzNEdGJFNSty?=
 =?utf-8?B?Wjg2UWdSbHpISGIrTkdPTGVSSGk0VW9COVYxdHVlL3FPRUtmeXR3S1ZzZTlq?=
 =?utf-8?B?VXlQZkpuU3pvV0gwaXQrK1FLNWlIQWYvZGJsWXVZSFUvcFRJeVByQzlzQmJa?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BF4A307905CE640939AA32DA516A8F2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b261704-2865-4dd3-fa60-08dc9bcab54d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 01:43:30.7109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W5dzhgN/unJfo6oyAA3rpIcL5/zF1kUEKRpSoF6jcjOjZWx5b6epdeevg7USiLAyrPSqxkst49L3GN4EMumGfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7414

SGkgQ0ssDQoNCk9uIE1vbiwgMjAyNC0wNy0wMSBhdCAwMjoyMiArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBTaGF3bjoNCj4gDQo+IE9uIFRodSwgMjAyNC0wNi0yMCBhdCAw
MToyNyArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB2aWEgQjQgUmVsYXkNCj4gd3JvdGU6DQo+ID4g
IAkgDQo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMNCj4gPiB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiA+ICBGcm9tOiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBTdXBwb3J0ICJOb25lIiBhbHBoYSBibGVuZGluZyBtb2Rl
IG9uIE1lZGlhVGVrJ3MgY2hpcHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hp
ZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYyB8IDEzICsrKysrKysrKystLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZXRoZHIuYw0KPiA+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+ID4gaW5kZXggMzYwMjFjYjhk
ZjYyLi40OGI3MTQ5OTQ0OTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19ldGhkci5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19l
dGhkci5jDQo+ID4gQEAgLTMsNiArMyw3IEBADQo+ID4gICAqIENvcHlyaWdodCAoYykgMjAyMSBN
ZWRpYVRlayBJbmMuDQo+ID4gICAqLw0KPiA+ICANCj4gPiArI2luY2x1ZGUgPGRybS9kcm1fYmxl
bmQuaD4NCj4gPiAgI2luY2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+DQo+ID4gICNpbmNsdWRlIDxk
cm0vZHJtX2ZyYW1lYnVmZmVyLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9jbGsuaD4NCj4gPiBA
QCAtMzUsNiArMzYsNyBAQA0KPiA+ICAjZGVmaW5lIE1JWF9TUkNfTDBfRU5CSVQoMCkNCj4gPiAg
I2RlZmluZSBNSVhfTF9TUkNfQ09OKG4pKDB4MjggKyAweDE4ICogKG4pKQ0KPiA+ICAjZGVmaW5l
IE5PTl9QUkVNVUxUSV9TT1VSQ0UoMiA8PCAxMikNCj4gPiArI2RlZmluZSBQUkVNVUxUSV9TT1VS
Q0UoMyA8PCAxMikNCj4gPiAgI2RlZmluZSBNSVhfTF9TUkNfU0laRShuKSgweDMwICsgMHgxOCAq
IChuKSkNCj4gPiAgI2RlZmluZSBNSVhfTF9TUkNfT0ZGU0VUKG4pKDB4MzQgKyAweDE4ICogKG4p
KQ0KPiA+ICAjZGVmaW5lIE1JWF9GVU5DX0RDTTAweDEyMA0KPiA+IEBAIC0xNzUsNyArMTc3LDEz
IEBAIHZvaWQgbXRrX2V0aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlDQo+ID4gKmRldiwg
dW5zaWduZWQgaW50IGlkeCwNCj4gPiAgYWxwaGFfY29uIHw9IHN0YXRlLT5iYXNlLmFscGhhICYg
TUlYRVJfQUxQSEE7DQo+ID4gIH0NCj4gPiAgDQo+ID4gLWlmIChzdGF0ZS0+YmFzZS5mYiAmJiAh
c3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSB7DQo+ID4gK2lmIChzdGF0ZS0+YmFz
ZS5waXhlbF9ibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpDQo+ID4gK2Fs
cGhhX2NvbiB8PSBQUkVNVUxUSV9TT1VSQ0U7DQo+ID4gK2Vsc2UNCj4gPiArYWxwaGFfY29uIHw9
IE5PTl9QUkVNVUxUSV9TT1VSQ0U7DQo+IA0KPiBDb3ZlcmFnZSBtb2RlIGlzIGFuIGFscmVhZHkg
c3VwcG9ydCBtb2RlLCBidXQgdGhpcyBwYXRjaCBtb2RpZnkNCj4gYWxwaGFfY29uIGZvciBjb3Zl
cmFnZSBtb2RlLg0KPiBTbyB0aGlzIGlzIGEgYnVnIGZpeD8NCg0KSW4gb3JlZGVyIHRvIHJlcGxh
Y2UgdGhlIGRlZmF1bHQgc2V0dGluZyB0aGF0IGlzIHNldCBpbg0KbXRrX2V0aGRyX2NvbmZpZygp
LCB3ZSBjaGFuZ2UgbXRrX2RkcF93cml0ZV9tYXNrKCkgdG8gbXRrX2RkcF93cml0ZSgpLA0KYW5k
IHRoaXMgY2hhbmdlIHdpbGwgYWxzbyByZXNldCBOT05fUFJFTVVMVElfU09VUkNFIGJpdCB0aGF0
IHdhcw0KYXNzaWduZWQgaW4gbXRrX2V0aGRyX2NvbmZpZygpLiBUaGVyZWZvcmUsIHdlIG11c3Qg
c3RpbGwgc2V0DQpOT05fUFJFTVVMVElfU09VUkNFIGJpdCBpZiB0aGUgYmxlbmQgbW9kZSBpcyBu
b3QNCkRSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUuDQoNClJlZ2FyZHMsDQpTaGF3bg0KDQo+IA0K
PiBSZWdhcmRzLA0KPiBDSw0KPiANCj4gPiArDQo+ID4gK2lmICgoc3RhdGUtPmJhc2UuZmIgJiYg
IXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkgfHwNCj4gPiArICAgIHN0YXRlLT5i
YXNlLnBpeGVsX2JsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfUElYRUxfTk9ORSkgew0KPiA+
ICAvKg0KPiA+ICAgKiBNaXhlciBkb2Vzbid0IHN1cHBvcnQgQ09OU1RfQkxEIG1vZGUsDQo+ID4g
ICAqIHVzZSBhIHRyaWNrIHRvIG1ha2UgdGhlIG91dHB1dCBlcXVpdmFsZW50DQo+ID4gQEAgLTE5
MSw4ICsxOTksNyBAQCB2b2lkIG10a19ldGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAq
ZGV2LA0KPiA+IHVuc2lnbmVkIGludCBpZHgsDQo+ID4gIG10a19kZHBfd3JpdGUoY21kcV9wa3Qs
IHBlbmRpbmctPmhlaWdodCA8PCAxNiB8IGFsaWduX3dpZHRoLA0KPiA+ICZtaXhlci0+Y21kcV9i
YXNlLA0KPiA+ICAgICAgICBtaXhlci0+cmVncywgTUlYX0xfU1JDX1NJWkUoaWR4KSk7DQo+ID4g
IG10a19kZHBfd3JpdGUoY21kcV9wa3QsIG9mZnNldCwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVy
LT5yZWdzLA0KPiA+IE1JWF9MX1NSQ19PRkZTRVQoaWR4KSk7DQo+ID4gLW10a19kZHBfd3JpdGVf
bWFzayhjbWRxX3BrdCwgYWxwaGFfY29uLCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4ZXItDQo+ID4g
PnJlZ3MsIE1JWF9MX1NSQ19DT04oaWR4KSwNCj4gPiAtICAgMHgxZmYpOw0KPiA+ICttdGtfZGRw
X3dyaXRlKGNtZHFfcGt0LCBhbHBoYV9jb24sICZtaXhlci0+Y21kcV9iYXNlLCBtaXhlci0+cmVn
cywgDQo+ID4gTUlYX0xfU1JDX0NPTihpZHgpKTsNCj4gPiAgbXRrX2RkcF93cml0ZV9tYXNrKGNt
ZHFfcGt0LCBCSVQoaWR4KSwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLQ0KPiA+ID5yZWdzLCBN
SVhfU1JDX0NPTiwNCj4gPiAgICAgQklUKGlkeCkpOw0KPiA+ICB9DQo+ID4gDQo+ID4gLS0gDQo+
ID4gR2l0LTE0NikNCj4gPiANCj4gPiANCj4gPiANCg==

