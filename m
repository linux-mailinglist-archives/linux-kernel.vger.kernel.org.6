Return-Path: <linux-kernel+bounces-441386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A261B9ECDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B240E1613D5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A527123369C;
	Wed, 11 Dec 2024 13:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hrXZh3fT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jdPI7h2G"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E37438DE9;
	Wed, 11 Dec 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924871; cv=fail; b=MKaVCWN+NJqSKIkkZy1QSoaWxMYdwMQ1fTW8vJ0FCwbe725LTBBSxeYzWJWge/aiHIdTbTBdH8AfxVTIzwbuqbYFYxGA7oZDgyhPPIrIrLkYmkZp1CQ3TXWwcsWfnf8FSZHGYRZJThQkMOufA9F3Q1ckWgFNDHhVvZdWmXAudAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924871; c=relaxed/simple;
	bh=KKrv6ch4togHHYdZE3GBiZ9+/qk4ihIw1MHi+6Oby/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ut6lMwKrScRdPzTtHtLEkDrIGFW0Dyt4tdYLhsD70w9ahujY41ZF2YFzOhhF/SeKFGf8rmFWAuMOhDvXBN560sUCbtGcYLb7ytRKWSCO3yW9aC+jAFWbVDIgYOLYSp54WmZQxaOM5xKzozSsmxbcJOoBeAEmQMxeAbncKhkMBoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hrXZh3fT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jdPI7h2G; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7bd13176b7c611ef99858b75a2457dd9-20241211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KKrv6ch4togHHYdZE3GBiZ9+/qk4ihIw1MHi+6Oby/4=;
	b=hrXZh3fTXEL/kc3yJks6+XYdRSlvZr17TyXazCTKPdEhpayrTL12l2tThKHWfk/iAQiW6A5XF0sp0vFkBhd1md2RJJooHrJYEiall8+CXC9a/Kpv/cSYUIK0OIPYY3NTA/FMzV9TQIqAVNB5TiuF02jVuCPoe1qg18Ri1At9qfI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e9a2b5b0-272d-42bb-8d4f-f2be3a2285dc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d1f3cd3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 7bd13176b7c611ef99858b75a2457dd9-20241211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 787296065; Wed, 11 Dec 2024 21:47:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Dec 2024 21:47:36 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Dec 2024 21:47:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwVPkDlWmbusQcxb5qxiz76L+WnYkpbxgh50RYKwoudI5M3qpOdHx2t1D1YLrxRS+UwmLVmtsX5ZV8jMy/FVhq42xEUoYlHsSQppz9GeB/b46SKeJE+T8R9gj1STHRJK9czoQq3sIpQgomV8v4aJ+kECDVUm66GFzyCfy1ZLp8UKX2OzxAAuB6B8tNqb4cpF92bCdbqB3RYtv7Jx517vrBolYAxsTqAXR5k7hwMWBtB5Br3SR6g2qVWlhn40fFNQv9nXrM4cg290Oc+KivE8geC+Ee2LxnMafw9JzHoU6MbXNTXP+iAwGu4Mhz6VrXoPw9XgRg7M+Lj1DXxMj8EuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKrv6ch4togHHYdZE3GBiZ9+/qk4ihIw1MHi+6Oby/4=;
 b=xktiRjzbdlJlX0p2Zf7TLhzLZqO57ttdrwuDpMQSEajuiudQ2yX0VW2DalMgpu5sI42XXAc9Ndq9WzKxAc5o4p5imDaHV971hIIvp02QYINcB+cU2axBAZ76EVsYUwxfTj5w6EqGhTSfqzSoQmPIfQ1beuO+G4iBqPwLG/C8MFOZRl1UHRkehsVubwMP/rGt3I3izAi6TfirDU6lHayVL3F7viXJ6PGMuP9W/MmAkYrDA5qjOBJ+h659VDwdFse7bicqu0rUCMHA4dfee2Vpr2Hh7tpBIQ4cA4jpCmZcjKWXl/F/39IibuqwxjYGcI8IjgBjo1J87Z81J+A8UnYu4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKrv6ch4togHHYdZE3GBiZ9+/qk4ihIw1MHi+6Oby/4=;
 b=jdPI7h2GYDmtZ+hDAbP+unRwt422aGjv/IkKSIzH8f2H2coPimHbPNcvG6zKrAyO4gKMPDyRIongjot89rGrjlzY6grLgjThybNSpCN2+HZ0efc/VFTxQpg9WudUVJi6mG0hrXtkJp4t4BVZsqk+kTAbHA56CQ9tQXPIOTMgOT8=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEYPR03MB7814.apcprd03.prod.outlook.com (2603:1096:101:178::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 13:47:33 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::e70d:eef9:eaf3:c45%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 13:47:33 +0000
From: =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To: Nicolas Prado <nfraprado@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "broonie@kernel.org" <broonie@kernel.org>,
	"tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "perex@perex.cz" <perex@perex.cz>, AngeloGioacchino
 Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Thread-Topic: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Thread-Index: AQHbRb9VohAiDdD8c0CabJesaGe9E7LWAVgAgAGcGICAAS8nAIAFk8KAgAK6nAA=
Date: Wed, 11 Dec 2024 13:47:32 +0000
Message-ID: <57cf1810250d922ee01b9eff096c945c5c3a1375.camel@mediatek.com>
References: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
	 <a10dbdf265194e77a69b6e40afa3df9636b3ab14.camel@mediatek.com>
	 <a70a0521-985d-43a4-a1fa-36eb733d5ca9@collabora.com>
	 <1d2ee55dde84bcab6f777525042c6789b9f2c1fc.camel@mediatek.com>
	 <108d4187-26af-43f6-8b1e-0e48516524a4@notapiano>
In-Reply-To: <108d4187-26af-43f6-8b1e-0e48516524a4@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEYPR03MB7814:EE_
x-ms-office365-filtering-correlation-id: 8dfb259b-0455-41fd-fe26-08dd19ea5d04
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dzRVRVZwZ2xVb2w0TEMwSy9TRUdCSm1nVWFYYmxjTXZkaS9xSEtYZDBIUXVX?=
 =?utf-8?B?ZkpueHhDaVVCNHZZeEdYS21mMVNPR3RxQXJCM1RtQ2NNUXV5eFBoMDhtV09O?=
 =?utf-8?B?ZXJ1cTVRSnJoRVovc1QvK09XSHZFbWJVNUVzeDl3ZjFab2ZVdXF1ZTkxSWRs?=
 =?utf-8?B?dE05cXFyR056eFdLM2pEb04rTFRmTVdQclcxN2t4OHdYZTZQRGwwZ1ZvczEx?=
 =?utf-8?B?MFVRNFQ3bWRKNmx2bUZNa0luZFZzOWNoZHlSNVRCS2U2S3JIRzc0MFV4YzN5?=
 =?utf-8?B?MlNhcFZsMHE5MlFmREFXYkZ5QldBTWxqRVA2R2F3TzNQVmptSDhWV0pQUEdy?=
 =?utf-8?B?dnBnNGRDZzRjSUxSQVU4Z29xL24wU2JSZGRFNVp5VlVYbFlFYW1DYkljSEFE?=
 =?utf-8?B?Z3REdVBHbFdoZnZEMGRGUm5UTHdqSnpZaTlPWVo4SXh6bWhQNGZOdnJMNDFk?=
 =?utf-8?B?L2NlU09jQjBkeERKZ01IUTArbzdEeHhCaDZJMVVic2cvU0NWcSt5aGtZVExk?=
 =?utf-8?B?Tm1PT1ZyT0NCREs1QmpNTU9VK2FnbFltMHhodG5pU3NET0s3eGhuUEZOK3A2?=
 =?utf-8?B?M3IwV1Vyc01Kd3NLN0kwdjFRSFdIQkhLcURtYlBkZSsxYU1JaHQ5ZzBXeTJm?=
 =?utf-8?B?YXNPeEsyYUZGeVkrclNBNG02MTJQNWZGdU5VaXNMZjJadHNmSk5kUERKUGx3?=
 =?utf-8?B?R1NIWnY2ZlRTQTlyNkJGU3NkMklzWW92d3pveG5oN3BMNE1tVmZ1VnppakRM?=
 =?utf-8?B?TGVnUGFtbEFxb09JdmlmSzlmM0R6L3oveFhqL2pRSjBpYk9YOEIrVW51UlRY?=
 =?utf-8?B?VEZQbnBRajVQbE9WZUwvdXlUL1hlcksyT25Kb0pQMkZrUG0wbEFpT1JnU05I?=
 =?utf-8?B?VEpDejF0V3hxNk1ybGVrcHZxS3hhNTZDQUZSaHJkZGhjMzdlaXNRV1ZLUE1M?=
 =?utf-8?B?aWRaRVJEcWk5TDNqa09LSERxbFN0MzhNVGtGMmZEQ0xKS2xTUzN6R2E4ZDVE?=
 =?utf-8?B?RWkyNUhNNWNBcFllWUdodFFnc3RpU3Y1Q01QQkIwb0prakNpMzBjNCtIdVRV?=
 =?utf-8?B?amRrYXZEdGN1V0NuTm13blFab3Y1WjAzbWlkc01NZDc4TUJLZmdZSGhkZDBS?=
 =?utf-8?B?dVk0dGJ6c21yQVF5UFc0UXB5RVJmQWhuaXVOa015SUlzVmpoeDQ1Qi9PZ1NM?=
 =?utf-8?B?MkVJdDFmOXJEb2gvc216VjJZcGhpdG5iK2VrdEQzOTNTcGc3R1l0M3JVb2Z6?=
 =?utf-8?B?cFRoSlVzS1A1OEdZeURJVzdJNVpVdVJvK3QvOWVRZ3FMV0t0bmFjb3lzSmF1?=
 =?utf-8?B?REdkb0xoNnhDd29TMDArTi9GcmFrSVJEUTZhREMwcXVHa3BlOWZ4M1F0NzE2?=
 =?utf-8?B?a3ZyUnZoamhvNVBtM2xqR3UrbGFxZ25xQVJ4WFZnRWpTdHVqSmprRngyQTBL?=
 =?utf-8?B?VEs2SnpvZjhSVUltdVNHbWp4ak14UFFVOGRKWDBib1l6aXJSTlIySGV2c0h6?=
 =?utf-8?B?TXh2ZHFIN0ZUaytXTVBhWGlsbStxMk5mUlNadzFGT0dhanhZOWdvakxNdy9h?=
 =?utf-8?B?ZzZnR1pUaHUvNEZNTXRQMHlWd2hZbjlCY0l6MnJROEhlaVNPa2pyRGQ3dnpI?=
 =?utf-8?B?ZjRYV3BjQy9JUnBqWVFoY0paeC9QYmduYVF2S0ZWSDB1R055bGNwdkpMSllD?=
 =?utf-8?B?RjRpVlNMRUtObGtJU1lpTCtNZ2t5amdlQkh2N0o3cHh1cFdTVGU4R3o4Y1Ba?=
 =?utf-8?B?L25adXVtaXZGZTJCc2prOEIvejZ0NFI5ZmR2MzFtUE9RbWdLd3FtSjkrTVRO?=
 =?utf-8?B?R3ZFWFovWVZ3cGJPaUdWa3pTT1lUTXZhOXRvQU91K0JDWkg3NDhPSW0yNFIr?=
 =?utf-8?B?eVhyeXVqN0ZEaExuVit3S0hiOUdzRFJaTEdMbmZRWWFwbmVNRGEzSEFtcWdI?=
 =?utf-8?Q?11NxHSrOECrMBNdq+njC6NIcG5hb0xUI?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUxDOFg0T1E5NmpjT3B3cit5emR2N3NZWDJWOXRNWlUrYys5b0RhMjliK0tC?=
 =?utf-8?B?ZVZIUi8wS0kxVlhSeDZxY1FGOVhBMTNrYVZMMStBV2w0ZGcwR2lUQ0xZZUVE?=
 =?utf-8?B?WE5YVHF3T3N0akQrak1hZEpiVG1PZVowc0d3STJEWVIvQmJVQW5Mb2wrSVRV?=
 =?utf-8?B?VGRFem5WSWk1amtHNnRxYk51Qmp0elBGcEhtenZFcmFFallnK3JKczl0djZF?=
 =?utf-8?B?TmNub3h0TDNsV0xXcEpJampzUUZRQm5GV1FOZU9PTzJqSzZ6V3dSNDc1U1Uy?=
 =?utf-8?B?TUxNa0ZvWkJVL0N6b2c2aGRPYTA0NzdGZmppN013ZVBPRGtKU096QzRQQVht?=
 =?utf-8?B?N1R1SThKWU9zYjI5ZlUyd3JvRmZvOHlHVEpzMWhSWlEyTG9HazArRVdlSzh0?=
 =?utf-8?B?cjBrMVZpcEM1T3BQb1YzYWg4OU5NMnpsVW53QVBRZ1U2dnlqTVdVSHRkc0Vr?=
 =?utf-8?B?UzNMeHVKdFlVekh0YUlha0ljdndhay85NUkxZWc2Q3plSFdNbWNXa0EvWjNK?=
 =?utf-8?B?TDBnUUhCWHNjeS8wZ0pEUkhjb1VPd09LNXRYSnBPNjVkSXlVNi9zc0Q0WHhS?=
 =?utf-8?B?RkI1WVhmdXVtZzBiR2thMzNRbkZHQWhneXgzbithQ2tYNStYeEdzdC9GeTlv?=
 =?utf-8?B?Z0NxUzNjbmNrR1h2QkNwMzdITDBCUVVuS0p3eHo5V1JYNitaOVhPL3d6WWlu?=
 =?utf-8?B?cmFzTjJOaTFqam4rRmUrSUZWRnJ0L0tUcUEyNkI4NzIyNDdHaEQ0VTlGYnRp?=
 =?utf-8?B?M2lQc2JQTHY1MlEyWGlya0crNE5yUk9Oelo2WEdQdTRyQUtuRVJsMjl4ZHdx?=
 =?utf-8?B?dzdTSWtTQ0MxRURFT1lPRmw4aktjNHBWWVd5cGdUcGt0d2doa1BqVEwwbGls?=
 =?utf-8?B?Qkh3emxGVUNrYktKVEkvWWxOTmVKM3ZIMDVPSzF6L0RRV0hYazVoS3Fod29i?=
 =?utf-8?B?dGpsUTRPR0FWUFRJNDg3SWFiRThRaXlmejlCSTF5cEVxV2tlTmIzNFFZWTNX?=
 =?utf-8?B?elVhcGN1dmRRZHFON0lkTWJabkNjNVVxeUhKNTJTeklOcHNEOGZzdkE2QU1O?=
 =?utf-8?B?MFJJN1p3Y3A2V29PU0pUL1pmdHV1S2lpSW5PSGtPTmplVFp5cm8yUXEyWURJ?=
 =?utf-8?B?WndaTWJvMDVZcG5mb2l3RFcxaXpZcGt3cjRCYVFRUVJObjFqNXVFZXpXS0Fa?=
 =?utf-8?B?Nkk4em1Lc0VCZkpuMWgzbzJ4MndubWJVcDdkblhuaEVYdGh6ZXlNeDZOdlUr?=
 =?utf-8?B?WWNWdW5McGF6cDlFYVhZem80SWlqcGdBZTBibkc1aTNhcVJnN0Jmek1wZ1p5?=
 =?utf-8?B?cW5pM0ZxRnZnK2ZLZ3l0dnYwdVhsNVRrSkhjcWNVck93M2FqZWRJZk1tRXNC?=
 =?utf-8?B?ZmFjS0RrMVFIdDB6YUN4TmIvSXRoTnVlK2RJL2I0emdQZGlaUFo0Y3JlWGhp?=
 =?utf-8?B?dXJPSnpjSDd1SEhBaHhSR0sxVWJGY3VNM3FCZ3B5dHEwdnptenRYWXVzRnBR?=
 =?utf-8?B?UXJoc2ZTUDc2ZGd2d25MTFBxVTNqOUNiTURpN2l4d1M1ZGZsdUVleGs1WVMr?=
 =?utf-8?B?VGdGbnJUSHdhVXU5WVNOazBhdEY1dThJV1BIT3Q3U0V6akQzbEY1enoxeFBy?=
 =?utf-8?B?UERjZEVvaW9obTJHZTBteFk2VldwR1ZnTGZkUG95Rkhiakd1a1psKzFXSEJP?=
 =?utf-8?B?bEtoM0lmVks5YTFpamlRZXlwN01jMEdWTnlkUmVVZlh3UjVwWVBHM05ZYnBV?=
 =?utf-8?B?WkdQS0dpNmhUQlRDYktLanMwbEdDajJISjRHa04vZDBEZEE3a0VCN0VzUWYy?=
 =?utf-8?B?Ukk4TjlYVThTajFGeXNQT3NYUXBQZ3NqM0tsTzRDOWJWeVZPajJuc0pWeWgr?=
 =?utf-8?B?ZDlTQnZEczBRWWIvQjk2MEJjKzFycGNtNXRWaXcwNzZUa3JoWVFaWklSVlhD?=
 =?utf-8?B?VW11aFk1QmlNZ3ZLOWMvUGZueitJaGowRG9uWjcvTDJjWnJJZHRlZG00RjFN?=
 =?utf-8?B?a2tWTEZobmowdVVmRkYwY1R6UFlFVUpQV084WmlqUW5uYVlJTHF1OUs3UllK?=
 =?utf-8?B?QWRjdHZIZktPNXUyeGw0dU9jZ1lhMzVuWENMdEdsNy9sRm9hVGdFclNycFlu?=
 =?utf-8?B?S2xTbDNuNUpoeGk4NXJKeHB6QlE1RTlva1dsTkpGRmRGcWorN0Q2SmNIbVpJ?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5399E103B3042B4989650F6EAF14E585@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfb259b-0455-41fd-fe26-08dd19ea5d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 13:47:32.9665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dyeJiuOVeW8GCk5K4RKoh0or43zPaQrlNzQ+bz1kYOqwNIZK5+08DvaFOkZ6/eZXaa93gq5+MwVjlvNgyroj3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7814
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--32.467100-8.000000
X-TMASE-MatchedRID: ediyJTvK8erUL3YCMmnG4t7SWiiWSV/1jLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP1ai3lnXr67vu36Q3o1HWpAvCS
	H3jFxsa+yB4IqjtpgyKluANRk8Y4nzmzAbkmfyS5CnGIuUMP0VVmLvTysL4PPHFSQk97VYGprdv
	1rDlsRW4pbZLyoDNEr8LtItXUH11YdWKRD1iYss0NTnAhL0/m3GK57kZ/2mal94c+e7fWIcCmuO
	0CFu4McwycajmHE0KJiWM9atbL23iowKSWrVbTyhsE+u3nnCfA3GofkGVB3jvHFoBcOsKez+bRh
	P5t1aq75Q0NPObp+7GztYZsMC19hkg6GA5mI8yyqEvbUNq/XjUrRgIJiqlrlh8BhJvgqWBlCcg1
	90NG0Lt7nIKRPK99u6C0KGiPQs329APXZcWoc06MVgdN9w+TCs1hEwUD1d/IsElh8RiHU9cB25C
	dwiNdGdnpHS836LGRIT4SOZxkibmResrHRY7dKFVfH7j3N9benCcVmef5UfIdfRwNmJj4NxUDTx
	L3vuSC18ig+ONtg92LP47+knfp2ZfHap3h8vRnAJnGRMfFxyfTcf8Av+QSAmyiLZetSf8n5kvmj
	69FXvKEwgORH8p/AjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--32.467100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2D13CA6B06673B4B8DD834E03C6191EC00B174820C562D07AFAB8121571700662000:8
X-MTK: N

T24gTW9uLCAyMDI0LTEyLTA5IGF0IDE3OjA3IC0wMzAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFk
byB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiBGcmksIERlYyAwNiwgMjAyNCBhdCAwNjo1Nzow
MEFNICswMDAwLCBUcmV2b3IgV3UgKOWQs+aWh+iJrykgd3JvdGU6DQo+ID4gT24gVGh1LCAyMDI0
LTEyLTA1IGF0IDEzOjUxICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdy
b3RlOg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IElsIDA0LzEyLzI0IDEzOjE3LCBUcmV2b3IgV3Ug
KOWQs+aWh+iJrykgaGEgc2NyaXR0bzoNCj4gPiA+ID4gT24gVHVlLCAyMDI0LTEyLTAzIGF0IDE3
OjA3IC0wMzAwLCBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbw0KPiA+ID4gPiB3cm90ZToNCj4gPiA+
ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gQ3VycmVudGx5LCBib290aW5nIHRoZSBHZW5pbyA3
MDAgRVZLIGJvYXJkIHdpdGggdGhlIE1UODE4OA0KPiA+ID4gPiA+IHNvdW5kDQo+ID4gPiA+ID4g
cGxhdGZvcm0gZHJpdmVyIGNvbmZpZ3VyZWQgYXMgYSBtb2R1bGUNCj4gPiA+ID4gPiAoQ09ORklH
X1NORF9TT0NfTVQ4MTg4PW0pDQo+ID4gPiA+ID4gcmVzdWx0cw0KPiA+ID4gPiA+IGluIGEgc3lz
dGVtIGhhbmcgcmlnaHQgd2hlbiB0aGUgSFcgcmVnaXN0ZXJzIGZvciB0aGUgYXVkaW8NCj4gPiA+
ID4gPiBjb250cm9sbGVyDQo+ID4gPiA+ID4gYXJlIHJlYWQ6DQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gICAgbXQ4MTg4LWF1ZGlvIDEwYjEwMDAwLmF1ZGlvLWNvbnRyb2xsZXI6IE5vIGNhY2hlIGRl
ZmF1bHRzLA0KPiA+ID4gPiA+IHJlYWRpbmcNCj4gPiA+ID4gPiBiYWNrIGZyb20gSFcNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBUaGUgaGFuZyBkb2Vzbid0IG9jY3VyIHdpdGggdGhlIGRyaXZlciBj
b25maWd1cmVkIGFzIGJ1aWx0aW4NCj4gPiA+ID4gPiBhcw0KPiA+ID4gPiA+IHRoZW4NCj4gPiA+
ID4gPiB0aGUNCj4gPiA+ID4gPiB1bnVzZWQgY2xvY2tzIGFyZSBzdGlsbCBlbmFibGVkLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IEVuYWJsZSB0aGUgYXBsbDEgY2xvY2sgZHVyaW5nIHJlZ2lzdGVy
IHJlYWQvd3JpdGUgdG8gcHJldmVudA0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+IGhhbmcuDQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTsOtY29sYXMgRi4gUi4gQS4gUHJh
ZG8gPA0KPiA+ID4gPiA+IG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gPiA+IC0tLQ0K
PiA+ID4gPiA+ICAgc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtYWZlLWNsay5jIHwg
NCArKysrDQo+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgv
bXQ4MTg4LWFmZS1jbGsuYw0KPiA+ID4gPiA+IGIvc291bmQvc29jL21lZGlhdGVrL210ODE4OC9t
dDgxODgtYWZlLWNsay5jDQo+ID4gPiA+ID4gaW5kZXgNCj4gPiA+ID4gPiBlNjljMWJiMmNiMjM5
NTk2ZGVlNTBiMTY2YzIwMTkyZDU0MDhiZTEwLi5mYjhjZjI4NmRmM2YwMmFjMDc2DQo+ID4gPiA+
ID4gNTI4Yg0KPiA+ID4gPiA+IDg5OGYNCj4gPiA+ID4gPiBkMGQ3YTcwOGVjMWVhIDEwMDY0NA0K
PiA+ID4gPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWFmZS1jbGsu
Yw0KPiA+ID4gPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWFmZS1j
bGsuYw0KPiA+ID4gPiA+IEBAIC01ODcsNiArNTg3LDggQEAgaW50IG10ODE4OF9hZmVfZW5hYmxl
X3JlZ19yd19jbGsoc3RydWN0DQo+ID4gPiA+ID4gbXRrX2Jhc2VfYWZlICphZmUpDQo+ID4gPiA+
ID4gICAgICAgICAgbXQ4MTg4X2FmZV9lbmFibGVfY2xrKGFmZSwgYWZlX3ByaXYtDQo+ID4gPiA+
ID4gPiBjbGtbTVQ4MTg4X0NMS19BVURfQTFTWVNfSFBdKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiAgICAgICAgICBtdDgxODhfYWZlX2VuYWJsZV9jbGsoYWZlLCBhZmVfcHJpdi0NCj4gPiA+ID4g
PiA+IGNsa1tNVDgxODhfQ0xLX0FVRF9BMVNZU10pOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICsg
ICAgICAgbXQ4MTg4X2FmZV9lbmFibGVfY2xrKGFmZSwgYWZlX3ByaXYtDQo+ID4gPiA+ID4gPiBj
bGtbTVQ4MTg4X0NMS19BUE1JWEVEX0FQTEwxXSk7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICAgICAgICAgIHJldHVybiAwOw0KPiA+ID4gPiA+ICAgfQ0KPiA+ID4gPiANCj4g
PiA+ID4gSGkgTmljb2xhcywNCj4gPiA+ID4gDQo+ID4gPiA+IElmIEkgdW5kZXJzdGFuZCBjb3Jy
ZWN0bHksIEFQTEwxIHNob3VsZCBiZSB0aGUgcGFyZW50IGNsb2NrIG9mDQo+ID4gPiA+IEFVRF9B
MVNZU19IUCBhbmQgQVVEX0ExU1lTLCBzbyBpdCBzaG91bGQgYmUgZW5hYmxlZA0KPiA+ID4gPiBh
dXRvbWF0aWNhbGx5DQo+ID4gPiA+IGJ5DQo+ID4gPiA+IENDRi4NCj4gPiA+ID4gDQo+ID4gPiA+
IEknbSBub3Qgc3VyZSB3aHkgeW91IHJlc29sdmVkIHRoZSBoYW5nIGlzc3VlIGFmdGVyIGVuYWJs
aW5nDQo+ID4gPiA+IEFQTEwxLg0KPiA+ID4gPiBDb3VsZCB5b3Ugc2hhcmUgbW9yZSBkZXRhaWxz
IGFib3V0IHRoZSBzb2x1dGlvbj8NCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IEhtbS4gTm93IEkg
c2VlIHdoYXQncyBoYXBwZW5pbmcgaGVyZS4uLg0KPiA+ID4gDQo+ID4gPiBOaWNvbGFzLCBUcmV2
b3IsDQo+ID4gPiANCj4gPiA+IFBvc3NpYmxlIHBhcmVudHMgZm9yIHRvcF9hMXN5c19ocCBhcmU6
DQo+ID4gPiAgIC0gY2xrMjZtDQo+ID4gPiAgIC0gYXBsbDFfZDQNCj4gPiA+IA0KPiA+ID4gLi4u
d2hhdCdzIGhhcHBlbmluZyBoZXJlIG1vc3QgcHJvYmFibHkgaXMgdGhhdCBhZnRlciB0aGUgY2xv
Y2sNCj4gPiA+IGdldHMNCj4gPiA+IGRpc2FibGVkIGFzDQo+ID4gPiB1bnVzZWQsIGl0IGdldHMg
cGFyZW50ZWQgdG8gY2xrMjZtIGJ5IGRlZmF1bHQgYXMgdGhhdCBpcyBwYXJlbnQNCj4gPiA+IGlu
ZGV4DQo+ID4gPiAwLi4uIGFuZA0KPiA+ID4gc29tZXRoaW5nIGVsc2UgaW4gQUZFIG5lZWRzIEFQ
TEwxIHRvIGZlZWQgYSBjbG9jayB0byAuLiBzb21ldGhpbmcNCj4gPiA+IC4uDQo+ID4gPiB0byBh
bGxvdw0KPiA+ID4gcmVnaXN0ZXIgYWNjZXNzLg0KPiA+ID4gDQo+ID4gPiBUcmV2b3IsIGRvIHlv
dSBrbm93IHdoeSBpcyB0aGlzIElQIHVuYWNjZXNzaWJsZSB3aGVuIEExU1lTIGlzDQo+ID4gPiBw
YXJlbnRlZCB0byBjbGsyNm0/DQo+ID4gDQo+ID4gSGkgQW5nZWxvLA0KPiA+IA0KPiA+IEFzIGZh
ciBhcyBJIGtub3csIGl0IHNob3VsZCB3b3JrIGV2ZW4gdGhvdWdoIHRoZSBjbG9jayBpcyBwYXJl
bnRlZA0KPiA+IHRvDQo+ID4gY2xrMjZtLg0KPiA+IA0KPiA+IFVuZm9ydHVuYXRlbHksIEkgaGF2
ZSBubyBpZGVhIGFib3V0IHdoeSBBUExMMSBlbmFibGluZyBjYW4gcmVzb2x2ZQ0KPiA+IHRoZQ0K
PiA+IGhhbmcgaXNzdWUuIEknbSBhbHNvIGN1cmlvdXMgYWJvdXQgaG93IE5pY29sYXMgZm91bmQg
dGhlIHNvbHV0aW9uDQo+ID4gdG8NCj4gPiByZXNvbHZlIHRoZSBwcm9ibGVtLg0KPiA+IA0KPiA+
IEZyb20gdGhlIGRlc2NyaXB0aW9uLCBpdCBzZWVtcyB0aGF0IHRoZSBwcm9ibGVtIGlzIHJlbGF0
ZWQgdG8NCj4gPiByZWdpc3Rlcg0KPiA+IHIvdyBoYW5nLiBJZiBJIHJlbWVtYmVyZWQgY29ycmVj
dGx5LCB3aGVuIHRoZSBtdGNtb3Mgb2YgQURTUF9JTkZSQQ0KPiA+IGlzDQo+ID4gT04sIHJlZ2lz
dGVyIHIvdyB3b24ndCBjYXVzZSB0aGUgY3B1IHRvIGhhbmcuIEhvd2V2ZXIsIEFEU1BfSU5GUkEN
Cj4gPiBoYXMNCj4gPiBiZWVuIGNvbmZpZ3VyZWQgYXMgQUxXQVlTX09OIGluIHRoZSBkcml2ZXIu
IEknbSBub3Qgc3VyZSBpZiBpdA0KPiA+IGRvZXNuJ3QNCj4gPiB3b3JrIGNvcnJlY3RseSB3aGVu
IHRoZSBkcml2ZXIgaXMgY29uZmlndXJlZCBhcyBhIG1vZHVsZS4gTWF5YmUNCj4gPiBOaWNvbGFz
DQo+ID4gY2FuIGFsc28gY2hlY2sgdGhpcy4NCj4gDQo+IEluZGVlZCwgYXMgc3VnZ2VzdGVkIGJ5
IEFuZ2VsbywgYWRkaW5nDQo+IA0KPiAgIGFzc2lnbmVkLWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xL
X1RPUF9BMVNZU19IUD47DQo+ICAgYXNzaWduZWQtY2xvY2stcGFyZW50cyA9IDwmdG9wY2tnZW4g
Q0xLX1RPUF9BUExMMV9END47DQo+IA0KPiB0byB0aGUgYWZlIG5vZGUgYWxzbyBmaXhlcyB0aGlz
IGlzc3VlLg0KPiANCj4gSW4gbXQ4MTg4LmR0c2ksIHdlIGN1cnJlbnRseSBoYXZlDQo+IA0KPiAg
IGFmZTogYXVkaW8tY29udHJvbGxlckAxMGIxMDAwMCB7DQo+ICAgICAgICAgLi4uDQo+ICAgICAg
ICAgYXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bja2dlbiBDTEtfVE9QX0ExU1lTX0hQPjsNCj4gICAg
ICAgICBhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0gIDwmY2xrMjZtPjsNCj4gDQo+IFNvIHRoZSBx
dWVzdGlvbiBpcywgZG8gb3RoZXIgTVQ4MTg4IHBsYXRmb3JtcyBuZWVkIGNsazI2bSB0byBiZSB0
aGUNCj4gcGFyZW50IG9mDQo+IGExc3lzX2hwPyBEZXBlbmRpbmcgb24gdGhhdCBJIGNhbiBlaXRo
ZXIgdXBkYXRlIHRoZSBwYXJlbnQgb24gdGhlDQo+IGNvbW1vbg0KPiBtdDgxODguZHRzaSBvciBv
biB0aGUgZ2VuaW83MDAtZXZrLmR0cywgd2hpY2ggaXMgd2hlcmUgSSBvYnNlcnZlZCB0aGUNCj4g
aXNzdWUuIEkNCj4gZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gb3RoZXIgbXQ4MTg4IHBsYXRmb3Jtcy4g
VHJldm9yLCBkbyB5b3Uga25vdz8NCg0KDQpJZiBJIHJlbWVtYmVyIGNvcnJlY3RseSwgdGhlIHJl
YXNvbiBmb3IgYXNzaWduaW5nIDI2bSBhcyB0aGUgcGFyZW50IG9mDQphMXN5c19ocCBpcyB0byBz
YXZlIHBvd2VyWzFdLCBhcyBBUExMIGlzIG5vdCBuZWNlc3NhcnkgaW4gYWxsIGNhc2VzLg0KDQpb
MV0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNTEwMDM1NTI2LjE4MTM3LTUtdHJl
dm9yLnd1QG1lZGlhdGVrLmNvbQ0KDQpUaGFua3MsDQpUcmV2b3INCg0KPiANCj4gQXMgZm9yIGhv
dyBJIGlkZW50aWZpZWQgdGhpcyBpc3N1ZSwgSSBub3RpY2VkIHRoYXQgd2hlbiBib290aW5nIHdp
dGgNCj4gdGhlDQo+IHBsYXRmb3JtIGRyaXZlciBhcyBhIG1vZHVsZSB0aGUgc3lzdGVtIHdvdWxk
IGhhbmcsIGFuZCB0aGF0IHBhc3NpbmcNCj4gY2xrX2lnbm9yZV91bnVzZWQgYXZvaWRlZCB0aGUg
aXNzdWUuIFRoZW4gSSBzZWxlY3RpdmVseSBpZ25vcmVkIHNvbWUNCj4gdW51c2VkDQo+IGNsb2Nr
cyB1bnRpbCBJIG5hcnJvd2VkIGRvd24gdG8gaWdub3JpbmcgdW51c2VkIG9ubHkgdGhlIGFwbGwx
IGNsb2NrLA0KPiBtZWFuaW5nDQo+IHRoZSBhcGxsMSBjbG9jayBuZWVkZWQgdG8gYmUgbGVmdCBv
biBkdXJpbmcgdGhlIHBsYXRmb3JtIGRyaXZlciBwcm9iZQ0KPiBmb3IgdGhlDQo+IHN5c3RlbSB0
byBub3QgaGFuZy4NCj4gDQo+IFRoYW5rcywNCj4gTsOtY29sYXMNCj4gDQo+ID4gDQo+ID4gVGhh
bmtzLA0KPiA+IFRyZXZvcg0KPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGF0IG1pZ2h0IGdpdmUgTmlj
b2xhcyBhIGRlZmluaXRpdmUgaGludCBhYm91dCBob3cgdG8gcmVzb2x2ZQ0KPiA+ID4gdGhpcw0K
PiA+ID4gaXNzdWUuDQo+ID4gPiANCj4gPiA+IENoZWVycywNCj4gPiA+IEFuZ2Vsbw0KPiA+ID4g
DQo+ID4gPiA+IFRoYW5rcywNCj4gPiA+ID4gVHJldm9yDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IEBAIC01OTQsNiArNTk2LDggQEAgaW50IG10ODE4OF9hZmVfZGlzYWJsZV9yZWdf
cndfY2xrKHN0cnVjdA0KPiA+ID4gPiA+IG10a19iYXNlX2FmZSAqYWZlKQ0KPiA+ID4gPiA+ICAg
ew0KPiA+ID4gPiA+ICAgICAgICAgIHN0cnVjdCBtdDgxODhfYWZlX3ByaXZhdGUgKmFmZV9wcml2
ID0gYWZlLQ0KPiA+ID4gPiA+ID4gcGxhdGZvcm1fcHJpdjsNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiArICAgICAgIG10ODE4OF9hZmVfZGlzYWJsZV9jbGsoYWZlLCBhZmVfcHJpdi0NCj4gPiA+ID4g
PiA+IGNsa1tNVDgxODhfQ0xLX0FQTUlYRURfQVBMTDFdKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gICAgICAgICAgbXQ4MTg4X2FmZV9kaXNhYmxlX2NsayhhZmUsIGFmZV9w
cml2LQ0KPiA+ID4gPiA+ID4gY2xrW01UODE4OF9DTEtfQVVEX0ExU1lTXSk7DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gICAgICAgICAgbXQ4MTg4X2FmZV9kaXNhYmxlX2NsayhhZmUsIGFmZV9wcml2
LQ0KPiA+ID4gPiA+ID4gY2xrW01UODE4OF9DTEtfQVVEX0ExU1lTX0hQXSk7DQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gICAgICAgICAgbXQ4MTg4X2FmZV9kaXNhYmxlX2NsayhhZmUsIGFmZV9wcml2
LQ0KPiA+ID4gPiA+ID4gY2xrW01UODE4OF9DTEtfQVVEX0FGRV0pOw0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IGJhc2UtY29tbWl0OiBiODUyZTFlN2EwMzg5ZWQ2MTY4ZWYx
ZDM4ZWIwYmFkNzFhNmIxMWU4DQo+ID4gPiA+ID4gY2hhbmdlLWlkOiAyMDI0MTIwMy1tdDgxODgt
YWZlLWZpeC1oYW5nLWRpc2FibGVkLWFwbGwxLWNsay0NCj4gPiA+ID4gPiBiM2MxMTc4MmNiYWYN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiA+ID4gLS0NCj4gPiA+
ID4gPiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0K

