Return-Path: <linux-kernel+bounces-425213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72749DBEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 05:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814D7164A18
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 04:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289481537AC;
	Fri, 29 Nov 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TBSc8wiR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OoJzcGpA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028B184F;
	Fri, 29 Nov 2024 04:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732852941; cv=fail; b=TZaV0iBo4FR7zqZSzE3aTFjNahZxtVYNNN6jmnHh/orPL0h7xq3qBGoQZMpErVImRcmOGe9TFY0oyV+Ymz/o4YZ6hyqerCXixTEIjyMzbsyPVZC9ntfVietGOLVLEsymynZXZyN2021d/JbGA5okmm7YahQvnh/6pa+lTEkbtXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732852941; c=relaxed/simple;
	bh=Kq5lIPoQcVg/xtqL8NRo5yXZrRUOPr9fzVfv0xIYvH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lNPnDfCqdKpac3l8wqcaG2x8d3JQM/3LFPMyaeznson4EsJXiCIvsJW1KLmqdWVx3d4odXMeTlL1nMVSyZxWzGf/GrQGhN8eZhbGGAK8H4VP4pT3olFhKcPk+IRatfk0fynO0/JMTNNkcvkZ7si8EBfvbpQE72Im2QeHAvujSV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=TBSc8wiR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OoJzcGpA; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b1c1c742ae0611efbd192953cf12861f-20241129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Kq5lIPoQcVg/xtqL8NRo5yXZrRUOPr9fzVfv0xIYvH0=;
	b=TBSc8wiRcbRml2R1FqjNnX9U2nGx4/uQA5/ta9a+pePYNKI/omJG3KEeD1F3SJyv8FAXdYuDeed+qLXgpmn/SCV9Wy5YKMEv1jJk53zPFbfQYHBlnKkgdF9Xu5zrbP8AgAqCDyqnufXg1E8ryPoA3VUpvgk4bvdkeb9bxCdP0IE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:8b819562-f668-40cd-be1d-73cd522907e4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:345a93b9-596a-4e31-81f2-cae532fa1b81,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b1c1c742ae0611efbd192953cf12861f-20241129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 546321859; Fri, 29 Nov 2024 12:02:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 29 Nov 2024 12:02:04 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 29 Nov 2024 12:02:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2eXDAUxUgu3BomhF+gyNdsvO8FNz2A6Ue/dHPS0MRyG+xDytxE1A/aswIt9khpjb7gBamObcnMprFMVZE95Azh4OWq3fS0YLa0ai7t4yykvJ7yhz6vjy2eYZmQhY458VYLYG8oBfntxBdGEJJndywIWtEXSb4OkN3J0VMkgr7EMjMT9IPxUDl8BYv0UU1GMhRkNmY/tmz+qXvz6piiJBMIlSV1XLR6fooiH9oFNYHhd9ptIcfJ0tsbp8TSRAd1ii5kmPSXtq3p5a2bnOeUbuBCDgkzsgGhqZg1T4eXwAuqMbNYmiwqwudpSQFoRCSrXvKt7CqkWXVLIHjtZvTLmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq5lIPoQcVg/xtqL8NRo5yXZrRUOPr9fzVfv0xIYvH0=;
 b=ELQQQXNES2QMF8Y5X7wMh1Wz2aEsAEtuKzfgQmzg/qr1KW7grSP5tk1OUa1RWKmbQtjDl2u8NZ6zD4crIYUDCo7FO6JSqw8u5cmBbYQLw/0eCvdabMI4AoerHrC2cELVCoxRX2Jid/Hk4HYMsDJ5yfjBynmnCJo97GGSwL4MNaBKIk/qNtDj3fRamoAObBgKTZ0tuFrHzhM5w6UJUDaz0TUAmBT3AH2bXHRkVwTkf9Ni2joT4f/LC3GCUxZ/SOVqjujFWoTasqa8OaVQurfE4rgSwJ6DBzLJmqlzORBWfhsypZBXZOAofdngd471jPm0PYtI//2lxTTS9hzWddkRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq5lIPoQcVg/xtqL8NRo5yXZrRUOPr9fzVfv0xIYvH0=;
 b=OoJzcGpAZSjbNxDjHy5l6Qi8sooUuOALoJhAFXetPdhhG/pnhSC3MINUVyug0V/fF7GvqcOgZJRoLa18RgZrItBtF7gxCG7wy/YcVmyCX4SxFCA+UYsiZ9H9fdDSuqT9Q2w4kCB07FqXFUmpxCNsiUaQO1dKteOBy/x1BsGLBHk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8424.apcprd03.prod.outlook.com (2603:1096:405:76::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Fri, 29 Nov
 2024 04:02:00 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8182.018; Fri, 29 Nov 2024
 04:02:00 +0000
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
Thread-Index: AQHbO0pOdhPnCCfvPUeRqumGFBNh8LLNsEuA
Date: Fri, 29 Nov 2024 04:02:00 +0000
Message-ID: <3d71a690f2a4b478120bdb854fb05be894bba35c.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8424:EE_
x-ms-office365-filtering-correlation-id: 2ba94093-5493-42fe-fd09-08dd102a9352
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M3VOTVhROEZ1M3dFeEp6S2FuM09HTExKYi8yWlZOMnpRb1JLdFoxN2JBSWRC?=
 =?utf-8?B?cC91ek01dkdpL2ZmK2ZqWXNQYVBUVVNIdzcvVlhtK2JXQ1ZuQ2pOckg0Tkhq?=
 =?utf-8?B?Wi84eHQxSTh2dFVUVWlqbTNtRVpscjZGbm03ejArNWxuY2RHM3djelZwNmsr?=
 =?utf-8?B?dmltWlJrVnJLVVhieFJ5V1lpeTd1ZzlFZnNDQzF4d1piRkw1ckJLT0E2MzJm?=
 =?utf-8?B?dTN0bjhGTThkdlY4VjF4T0RXYVp4UEkvSG9XY1FYLzAyUk9EdGhlRjYrZG5Q?=
 =?utf-8?B?WUhIUGx0OWJtMGh0YjZMNDA1b2t4VmtiL1Y1V1Y0TGpRSUtYblhMODVVNkpk?=
 =?utf-8?B?YjQ0dlFncHEzV3c5eGJxa2owUkNxMGlGZDNnQ09tc3hFRG9kNGhpaW9Iblly?=
 =?utf-8?B?OXFLQlRKM050Z0pST29jVmM3TUhwQnF3cTFsZGFaRXZkVEpqeWVPbFFHSGkw?=
 =?utf-8?B?dHVPdXdxQWpWazZWbk1reGlWQ3J5cGs5MmY0elVrVW52VDhqWWtYMHZ3d2lJ?=
 =?utf-8?B?ZWJSWmFHaTBjcGNVWFc4b2J6TG4wZXgyUUNFdExQWEtyK2I2S3dmbHdvbmc3?=
 =?utf-8?B?RDFMMlhiNWFOVXZaeGFJYkIreHRmUW9UNDI5a2dzQTdDMkNnaGF0UXRjSzlv?=
 =?utf-8?B?a0Zqa0Z6aGJ1MnUwa3VQdjRCdUtmR1B0SUxGWjBmQXo1emxRQ2N1aTBYNmFx?=
 =?utf-8?B?OEJJOG1mNGJSZWtrYk8zMDB6UXlneEUrZk5SNGNCRm9IWmNFL1FxRW5GSzNU?=
 =?utf-8?B?TkNQYXBuT1FtN0FSMHp1Y0s1RE5NbCt3WW1rbFA0T0F3cTBUUmxZWEtqYTh4?=
 =?utf-8?B?RnpaZGF4dmZzaDFWeGxZb1ZsVlB4dDBYSE5TcU9Cci9Eb0xDWTNSWS9zOGp1?=
 =?utf-8?B?V0VWbHBIR2o0aVg3cVY0MGJHQWVYd2NGMTJDUGthWTNDcTNaQ2JmeGZHbm5n?=
 =?utf-8?B?SXF2bm1ValdDSCtodWl4YVhzRnc1cFFUVFZPVnp5RTdZREZhalpGa0ViVWxG?=
 =?utf-8?B?QTgrdmk4UUFmM0Q1bUNRRWNjZ2dqdFhBQ0ZRNWVtUktLVTIxcG5iYStMbGI5?=
 =?utf-8?B?dTY4RXhiZTM3b0VmTnlyR3VCYk9yWHdCQVNQNDBSdzE5MVBmVHNJQ05xN2hS?=
 =?utf-8?B?aFFZQ202ZGw2cUx3OFU0R1RxeWZBVzRQUzc3ZXlua0lOYWxzaFFrZUtjYU12?=
 =?utf-8?B?Q3hRZkRFSjF1d01ncmZ0L05DWHJLY3BOY0loOWlCSjRocW9pZzZoSFlSTnBF?=
 =?utf-8?B?d1c4TXNYaWFSVEJZYnluYys0ZUU5UlJSSHNCL0pWTHFFcklIOGkreWpMcmJs?=
 =?utf-8?B?aDFxWWNrN0JQS2VjS0s5Yi94YW4waEUwL3JIQ2RQTytJcmRYNmVpR1NVOHMy?=
 =?utf-8?B?Q2VaZXpOL0dtY0JEbHlHZ2ZDMGYxdkxLeFY0Wjk1bXJPVGNLditJRUQyOFBq?=
 =?utf-8?B?U0hKTUY2NnZlelVyNWZOcHdSNzQ1ZmhGNlJZb1VYR01JV1dSQnlmTVhZblpM?=
 =?utf-8?B?dm9TTk9oTVdEZy9wd1JOTGZ5Q0wvWkl4Z0tTZS94WHk4RzZvcGRnMG9GdXdR?=
 =?utf-8?B?d2xyY3lRNHRMYjFFc0lMdTVFTDZtQVczTFcwZUtDazZ4SnV5UE42bTBkOUpl?=
 =?utf-8?B?SE1yKzB1RWNlL3ZxdDcxSUt3ajY0aFZURXVUTUlwb2dGbnk1Z1hwMTA1Wjhv?=
 =?utf-8?B?UHNzbERUOVNIaklUSTkxWUY4WGF5RHpQbEVuYlVoQzFWUjk0S1NQdzlteVBy?=
 =?utf-8?B?ZEJyelBVMldQWWw2M1NTUmZQdy8zdUx2RHRMUEwxVXJqaE1Tbzg0dEpjeW9j?=
 =?utf-8?B?cHhaYTNhcGlJa2pmNGQ3NWpXc3FPUXVBa1VKVHQrUFZLbDVsSWFYeVE3YjZn?=
 =?utf-8?B?eDVqTExhMW1lTFBiR1lEMTZKMUlHRTA1bjRQRTBGbEJDNnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUd6dFl6NWZEcHZJdzdyNWZPdGxrMldSdi9BajRaLzJGY2hTUGRZZXVzOWhi?=
 =?utf-8?B?TUlTM2tkNWdqemdQem9FdktkSVViN3BnSWw0L1ZSSHVCWUNnUVRNS2pnSE8v?=
 =?utf-8?B?NFBRczFYcEVWUCtoOWxWMWo5MGNZUXNMM2x1SUx2UGc0ZDdLYldtRCtYd3BE?=
 =?utf-8?B?bkFsVTg5cGl5V1JRN1VzTjM3ejBUcStkQUVLNXdmYVQ3WjJwQ1ZhNzUrZDUv?=
 =?utf-8?B?dzNyZzBpTGQrcEtJSmk3VVM0enZoMWNGTEw4bUxWNkgyKzduTHYyb1Nxek9B?=
 =?utf-8?B?dmFDYW5ZSVpwTmRVZFQyV3ZjaWVGQ2NlOVNVbEMxTjBBc0Nmb0pyRDlneGdM?=
 =?utf-8?B?cXl0a25pSkgxSHV4dFZ0NTJPQk93QTg3US85Y0ZqSGwrWHo3d3pHZ0FvU0Jr?=
 =?utf-8?B?NHJhNHkrR0duSEZhRTZqcUxQa2o3SWxvemJYdjZZUHI1dEhRSE1IT2JPMmZq?=
 =?utf-8?B?N1h6OTNXOWtaNFZMQWlOWFRHVVVRTnI5S2dUeFc1SXhnYmtqYklBTzZpZUh6?=
 =?utf-8?B?eU40Wk9RSTNqcTZpRmY3SCtKY1NkVWloSWtaeWFPYlZldS9LRlRMRERrODdM?=
 =?utf-8?B?SDZrOHQ5OGg1WWthRWoxQXhmSUROWU9mcUxVdm5sRTluTHFzclpoTlNXQ0ky?=
 =?utf-8?B?UDI1VkFiRXRPeXYvb0xoQUZyTC9DN01VTFZ2V3JycmhwQ1FEVE9GTm1aRTRy?=
 =?utf-8?B?WlA5U1Flcmk2cVl6V0Y3cE9naFNoQkx6ZDFWSEx5YVhOMHpXYmlCUDlHbWtz?=
 =?utf-8?B?aGZXRU5jWmMxTFRHb2NxR0F1R0lGYjhpVWNKR1R2cUczRmlTYW9SUmNSczFk?=
 =?utf-8?B?VmFxalJGQnpkenpTUXBmODFlcXdWLzVRWlFwZFAwNWFYVS8wKzBSTnhaVnRD?=
 =?utf-8?B?U2h3QlRPS21DT1V1QmdkR09oSWxzLzd1Y2VrVDIyZ2JwUmZFbFRrazZvL1Ni?=
 =?utf-8?B?SWdFaWhPRXhqQTc3c1NabkRxaDc2YkJSMVVTemQ1NXR1QTl1NHRoTTFISnBl?=
 =?utf-8?B?M0ZxVGhPVkpjdjJHQWFJcEZwL1ZkT05CY0pHZWNBbTdCc20yUk55dHR2eHB2?=
 =?utf-8?B?SERYM2lyWkZTU0s3YVhxUVZPbndyUDNzc3QrdHNDTTFaamtmWUxqaUZmczV3?=
 =?utf-8?B?a2M0bkluanorNmVMZnRzS0tyZmRWZGVpS3J4ZWxGa2F0ZHVSa3hUK3lyRkJW?=
 =?utf-8?B?NytTVG9ueHhEMTErL0VRbi9kZk51ak1FcDdpMnJnVkR1S0laUW5JS2VlR2o4?=
 =?utf-8?B?WTFkc29DaG16dCtzU2RSeWNlRUUyY3FSMDg5VXRnMkdSNiszUHQvMVgyVWt2?=
 =?utf-8?B?L09tTzVDZUg4VU14M1dIUHluYTY2TDhxbjZTRE9WSFUyOUhmRnRGRk5mYjJZ?=
 =?utf-8?B?ZDZjbkdteTNMSXkwaEd3TmQvNStGNFRCSFFFaDdIZFRoR05XUzZ4VjBCdHhq?=
 =?utf-8?B?WmFTellXLyt0QVRnYWdDb3dtRThvOWFVVUxJbFFwY0s5am5BcEtvSm5DWUZB?=
 =?utf-8?B?M3lPR1FzdFQxRXZvb29ieEUzSmlubFlYSkZsdWIzQTlIUXRLWE15VlVJNkVB?=
 =?utf-8?B?Z1VhVVgrWU1FYTQrWUZUWldPR0lLZEwzcEtZQ0F3bXd1MzJ2ektIbnFqRkdx?=
 =?utf-8?B?T3RvSGdiUmUvQlpISlpxbHRKVkowVFVFRXZ3czN2dWxPaXRmRVdsYXlLMDE3?=
 =?utf-8?B?U1pSVUc5anFXVGd1eEMybVdLZlNmR0Y2bHJGVFNEZmcxeEliNXlrU1k2dE43?=
 =?utf-8?B?QkgwdHpKMWNhc20rK2podUtVYzZVMWs3aTZXNVBkRnBzUDhKU24zQXJQV1I4?=
 =?utf-8?B?Vm1JSll3dHJPUlV2UTlYZGR2K29VUFIvanQrbU9HQ0xKZWhvaTJ0dlFFZGhK?=
 =?utf-8?B?TTJZQkN1UHJlQnBFVlhpWEcwNWIvL1FWWDJSaUhMMURER1FINnNVTWJnYmlT?=
 =?utf-8?B?UllKSGtHUUZWQkgvUlRMVXFzc2NpdG9mNVpLeFJHOUlrSHhCRlowZkRVTUtr?=
 =?utf-8?B?V29ROE5sdHRaWHF6MFVkZEhjNGpiK0I2TzZQQXBiRGduY0ZITGswWmlXaWds?=
 =?utf-8?B?L0NLSklBazFKSmtKemtpdW9pM3FaYllQTXhuNE9ucDhJMjQ2Yk9HUEhZbFlZ?=
 =?utf-8?Q?TmHPG2EryMxccIlKa3MPuq8QM?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E489D6EF650BAE45865B375B95D2BEB5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba94093-5493-42fe-fd09-08dd102a9352
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 04:02:00.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHO07dntAX75kt7wkMzq7a2L7PL+jLjZutPelAPu1+lUSnA7kNr0DEO7mIW+sGkTlOTCV37wUtIwqbwM44xn9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8424

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
aXN0ZXIgSERNSSBBdWRpbyBkcml2ZXJcbiIpOw0KPiArDQo+ICsgICAgICAgaGRtaS0+YnJpZGdl
LmZ1bmNzID0gdmVyX2NvbmYtPmJyaWRnZV9mdW5jczsNCj4gKyAgICAgICBoZG1pLT5icmlkZ2Uu
b3BzID0gRFJNX0JSSURHRV9PUF9ERVRFQ1QgfCBEUk1fQlJJREdFX09QX0VESUQgfCBEUk1fQlJJ
REdFX09QX0hQRDsNCj4gKyAgICAgICBoZG1pLT5icmlkZ2UudHlwZSA9IERSTV9NT0RFX0NPTk5F
Q1RPUl9IRE1JQTsNCj4gKyAgICAgICBoZG1pLT5icmlkZ2Uub2Zfbm9kZSA9IHBkZXYtPmRldi5v
Zl9ub2RlOw0KPiArICAgICAgIGhkbWktPmJyaWRnZS5kZGMgPSBoZG1pLT5kZGNfYWRwdDsNCg0K
SSB0aGluayB0aGlzIHBhdGNoIGlzIGp1c3QgdG8gbW92ZSBjb21tb24gcGFydCBvdXQgb2YgdjEg
ZHJpdmVyLg0KSW4gb3JpZ2luYWwgdjEgZHJpdmVyLCBpdCBkb2VzIG5vdCBzZXQgaGRtaS0+YnJp
ZGdlLmRkYy4NClNvIHRoaXMgcGF0Y2ggbGV0IHYxIGRyaXZlciB0byBzZXQgaGRtaS0+YnJpZGdl
LmRkYyBhbmQgdGhpcyBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mIHYxLg0KSSBkb24ndCBrbm93IGl0
J3MgbmVjZXNzYXJ5IG9yIG5vdC4NCklmIGl0J3MgbmVjZXNzYXJ5LCBzZXBhcmF0ZSB0aGlzIHRv
IGEgdjEgcmVmaW5lbWVudCBwYXRjaCBpbiBmcm9udCBvZiB0aGlzIHBhdGNoLg0KTGV0IHRoaXMg
cGF0Y2ggbm90IGNoYW5nZSBiZWhhdmlvciBvZiB2MS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKw0K
PiArICAgICAgIHJldCA9IGRldm1fZHJtX2JyaWRnZV9hZGQoZGV2LCAmaGRtaS0+YnJpZGdlKTsN
Cj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCByZXQsICJGYWlsZWQgdG8gYWRkIGJyaWRnZVxuIik7DQo+ICsNCj4gKyAgICAgICBy
ZXR1cm4gMDsNCj4gK30NCj4gKw0K

