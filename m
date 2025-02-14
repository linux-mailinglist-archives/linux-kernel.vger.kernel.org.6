Return-Path: <linux-kernel+bounces-514283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF912A35512
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269423A60CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839314D28C;
	Fri, 14 Feb 2025 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n3THGOT7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XxyAUcLA"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C693986333;
	Fri, 14 Feb 2025 02:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501568; cv=fail; b=d6pBEQWZNQg/C9eKTVFMt764xSIGsy0ery8yQxhvci8NicHVfNNzeuJAKSQGW4ELAFB6R66KGv+wFo5nBhOFL1JRWGHcpwICEDAw+J18Ln3sFKxk3qb3jVbOyZ9e9m9FF4a1PwHXsuAHaR6s1a5azl8pBZvonnKumxu4MKQsc9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501568; c=relaxed/simple;
	bh=Zz+ox3zC+b5aS5/1EElp6LsrjSxVIwzvVuvSrssyFgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=T2L2oaPABWh39zBdSJxr+VmUxvGCSaSQr8w+uUDmeLuv1Qowa2Xby1noe4sbctjzoUoEJnPv2X9LanY5FU+BDfEArWNJ14XlDoaTshR8uVbHxVaazNlcGKHhC9QMdNfKQ5oHF/zbosoZaGJqbFUJ+gkAhJPDes4QEdMPsRc5Dhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n3THGOT7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XxyAUcLA; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c0c57202ea7e11efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Zz+ox3zC+b5aS5/1EElp6LsrjSxVIwzvVuvSrssyFgw=;
	b=n3THGOT7s8/wyqOmgm3Rd/QBNQpw623s/2APd9IA29yNqme7Y1latPmTIsO/C1/fEUHRcCuYoVzhrkq1qprdRfrvIBLDWpS157Qb+hW21MorZstMwsGRqLmXWCL+GKL3BLufajVb/ddzotGHkLWbwegaWoV5PaeE2m9Dk0TfNcs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:d32490e5-2899-4fe9-b049-e379abfd6f81,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:eeaa72a1-97df-4c26-9c83-d31de0c9db26,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c0c57202ea7e11efb8f9918b5fc74e19-20250214
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1262859309; Fri, 14 Feb 2025 10:52:39 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 10:52:38 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 10:52:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aq64WP0Jh9/YqBL4PsVwrU700nAhPsGkoAqoUuZb45CGvuJL/cse0lCXZN9CAr30GyToZQfUs81juyRXasodArszJfS7k9YDcb8ZDYfYP0VH8vxNrwzwsBupwOp5q8H/mUYoNdW7YB5o6RSJRJV5b/psSpH7s/wRlEIK71tkIzN6sMS22mApOJmcRTt9HJgcTu0t5hY97C1Kldn8RrMOEsyyMDlfjpt9bS0UGvyL1ULQ2rQDwoFwPtDUWNBtJlobATa9yvfvKSYEcSySECt1YabFtS92957VQlMmBn+IAU6BhnI62Peeowya+gK42tGUbQQSC4U4lhxU1rvWijBLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zz+ox3zC+b5aS5/1EElp6LsrjSxVIwzvVuvSrssyFgw=;
 b=pvCbsfneFMUCbutDH6fL9wksaM53diZqvcqI5B7j2nhr/ByN46OH5Tfqf3hsnNFCytSE1p1t4siV+xvP+8qg638rmxUYFff96HMOsqf+/hPLYQjI6QPwF/5PdQGzx1d8HsfBBNsKgi4VxkLO/ov5Ec60d2m/S5cwHzV903Y6dUDntCq/Zur+JoKsiisYzFRSVdL62YbvjLdiyla+IoG629fKxV1lFPmrD6UHO9MhmrcLHQOReMqFFmPsLRjUmewlvHkk08QC6yxIKasGXRA5Y8V4DYN29F2uLNkZRIc1zKZJucezvdbZ5B5DfONzlFFhvEwfN9eGSnbCtpynhOmfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zz+ox3zC+b5aS5/1EElp6LsrjSxVIwzvVuvSrssyFgw=;
 b=XxyAUcLAptq1VeFUI+d7SQ/Dsw0OiNulAML5nOkI4BLnr+s1OAJBw3/jCjfyu2UfBW5zKnvjHeJYr4EcDP16QhcGoyiSKRPXEHNtdnfA8TDbpmttvw+76dWldnOOC5GhFgHgeZY1+CNyrTjk4cSaOcdnlEfdNA1yUM2PS1IUsoc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6958.apcprd03.prod.outlook.com (2603:1096:101:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 02:52:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 02:52:34 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?=
	<TommyYL.Chen@mediatek.com>, =?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?=
	<Ives.Chenjh@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
	<Jason-JH.Lin@mediatek.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>, Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v6 13/42] drm/mediatek: mtk_cec: Switch to register as
 module_platform_driver
Thread-Topic: [PATCH v6 13/42] drm/mediatek: mtk_cec: Switch to register as
 module_platform_driver
Thread-Index: AQHbfHkdksSjVfDi/EuolNlxo3yXWLNGHgwA
Date: Fri, 14 Feb 2025 02:52:34 +0000
Message-ID: <9c9756374264741e43eaacaa3477ec7afc9d4d3f.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-14-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-14-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6958:EE_
x-ms-office365-filtering-correlation-id: a439ae84-04f0-42be-2732-08dd4ca2a264
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RXQ4S3QyR05ISVhSVHpqdjZtN2hmRXFMaXI2MmFRNmhVODFES1F6ZmdOWUdT?=
 =?utf-8?B?VDJ1SGYyS0ExeFU2MUJFR2tLWHhCWVZ2TWt4YmQ0dy8zV1B6cG41M1I1WGRE?=
 =?utf-8?B?NjRvRGttK0pGVHVRT045TnFVaW1ORGNYd0YxRDZ3Y2kwQTJYUzBCQ2lxZUkv?=
 =?utf-8?B?Z2RmTlNYa3E4eHhod09ZVkJPVnlidGJHNnpFWHZBQ3hiMUJIZlRPc1lpTUlS?=
 =?utf-8?B?ZUo3RGROeHkyeHdXMU9iVGVwektjdmNNazNRbDB0TFluT3krUFNmU1Y3Vk1D?=
 =?utf-8?B?bHlZSFdxck5hSTVyZE1TOXpON3JzUUNHN1J1T2ZzdTZycXhjTTl2OUl5bkNB?=
 =?utf-8?B?THpBeGliMmRkakF1eXFubytZakJmcEdLckFPLzVsSWt3SmlUZXZOa1NXeGhF?=
 =?utf-8?B?M3pSdktNSXhUQjJrcVVPNWdlYkpCRk9iZXZJQWM5OFlmM1hFb3d5L3BsWkhs?=
 =?utf-8?B?dVhjMG9KZThMUDJZMmpmYjI0dURFeTlhYVAzU01uR0FLL1ZXRHBYTmU1Z09G?=
 =?utf-8?B?amIyMDlVNG1TWFZiUWI3a2lCcUlJL21WMS90R09QQ1creDFRWjFZRHZwVGJP?=
 =?utf-8?B?eDk2VDUwRFprUDZzamM0dnZlOU9wNG5KdWFYWG5tZnY3TFVhekV5ZWxTSWor?=
 =?utf-8?B?VUZXVE9DRkkwY2NWdDUvdG5IRlZKK0lQcUJzbGQwYVNnSXdTSStPY3I5QXpp?=
 =?utf-8?B?KzlUOTAyaXo1VE5zT3M0U2VHanluWFNobjR4N0tLMG03UXRzckY4SjVoRW41?=
 =?utf-8?B?T0xZcTBIdmNSWlBEOGxyYW5yNExoUWVkSDUwTUUwc2t0TTdtZzdWcExnMzVn?=
 =?utf-8?B?RXo5NXN4QzBIdXYrTW5nd1lQOWx0dm50QjRlNkRMMHJDOHllcVUyWFVXdzMx?=
 =?utf-8?B?SU44SlF3eE9SY1FkbDIwR2V1VU1zd2hmcnJWZVdKODJqTjZhUXZIZDE2WjE1?=
 =?utf-8?B?ZkQ2T2I0ZGYxNWNyQko0YncxaER4cG9WTStUZFZMdmRXRERpeDViZ2pmKzBS?=
 =?utf-8?B?dzRVckRSUjBEMjVjS2k1NVRmLzVoWVlxbHFzREFqeDRIL3FiWDdTZEFka1Y2?=
 =?utf-8?B?SE4vKzloL0Y0Q1BFdDJqSEQ0RnBUbTgzZjBZaVBTMFVPd1FyaGI0U3NyMzZE?=
 =?utf-8?B?QzhPd2hOTXBIclRpNkU0alg5REtZMkJFVjhRdWRkVVdmd2RJQWY2RldCNTlW?=
 =?utf-8?B?Qlo1OUl3WFdLdDI5dkFZUElFRnA2ZlQ5b2ZnSGQ3YUwvR0VUT0oxQUYrL0JX?=
 =?utf-8?B?OCtreWk4S3lWZ295L09NL1YxeDBNbnNtbGE0SGQ4ejIzU0duQ3hyejFEeTR1?=
 =?utf-8?B?V1dyOU5mRkVQc1Y5ZXh3Wi9XUFNOR3pNZzI0Z3A0cXRucXlqUUdnbElpUG9Z?=
 =?utf-8?B?d29RM3ZVS3pRckdoS0poVkRiN3RFd29hUGhaeFVBNW5uODM4QjhoVlA4UFY0?=
 =?utf-8?B?OWFxUnlzOENPM05FYXMxQUpndDlKRFhaNkhaQWh5N2RRVEpPUHR1emU3b3gv?=
 =?utf-8?B?TytYajFodHB0REhXS1NpVkkrNjd3RnFxbFVWNXRHaGwrNEVEOVd1U1RyWGVE?=
 =?utf-8?B?SVg3UzFnamMvUDVEQVpvOTVxN25Fek54aWhuUFc3SnRGVi8yZFFrbks0clJ0?=
 =?utf-8?B?WWVUZHRiWnFnbzZjeG95Q09OSjVYZmplbms0MkVPNmcveGVBbERzdUN2eXc5?=
 =?utf-8?B?MnI1U0JoeEFIWXVZcXJKK0Z5VWxIcWV6c0h0cUFwOUNqbGs4WmUxRWFnVFJn?=
 =?utf-8?B?cUpMMzZudDZKZ0E5MWgyeUhTRWNlMm0wUzBHSms2WHBMZC9oV081TGFvVTB0?=
 =?utf-8?B?WG00K2FQTStKUms2ajAwZFdpdDZ4T2NtM3Z1bkRZSDRqT0xHSzhnUHV5SHFH?=
 =?utf-8?B?RHBSbCtMQ1dONlhuN1dQTGV6VVo0K2p3SU5xaXZPSSsydlowRjZuK0xWRHYy?=
 =?utf-8?Q?89/bicAqacrFqRa50osFHPrizWQf2T9q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEM4QXc5MHZNWFg3bHJ2bWVETHh5aWlhTkx2aW12WGRoL0hGSkl0MnlkNytz?=
 =?utf-8?B?bUt3QXlpek1PN3BzSFAwS2hCQ3NzNnpGaDczdzVIMndsUnRlMEpOelZPSXlI?=
 =?utf-8?B?UkErdzBvbDVZVjY3UmlmaW5kaGxmWU8xK3FzWUJhYWVBVm0rQ0VFKzJyRktQ?=
 =?utf-8?B?eCtPTUM2S3ZqbVMwRUU1WUdWWGxHSDU5WHczVGkrL0ZUMXdVbFhIN3YxZ253?=
 =?utf-8?B?OHRRalppaXpVM2dQcStvM1ZFVmhuUlpTMnFGaVVwKzJJWFd3QjlWRmRQeDJQ?=
 =?utf-8?B?M2F2Sk5IeWdzUDNzMGtRcHM1NVNLYitJZXdlT3c1VmdKa0diczFCelB4V1hU?=
 =?utf-8?B?YlVNamxCbkpUT1E1YkpPU1FmaGM0UkQ1ZmltQyt6WUwySjZ1d2VSSTV3emIv?=
 =?utf-8?B?TW9qMjhJUHBGQ0llb04yTDFnbFVrdzBlckRFajlqU3piRzJxMVdYNEFMb3h6?=
 =?utf-8?B?bDF2WFNyamRGMFZHSVIvcHJuSTI5THFicU9BcnhmNXlLQjQ5eUdGRWQ4TUVQ?=
 =?utf-8?B?bitCZzV2TW1VaFRkN3ZEOVM5d09UV21XQlFIMW5NbXlZU1lKeFR4Zm52YzBu?=
 =?utf-8?B?OUh0K0t2UEdJSllFVTNIMWNuVDhqWUd2TUJnQkI3bG1LSi9Od2RRS1hRQWs0?=
 =?utf-8?B?dVNzb0xxeTU4N09DdmVsZE5vUUxlMTY1cEQrTXlxMjdLS1h6bDNQdG44amgx?=
 =?utf-8?B?MTNYMUNkbWdhWXRvaWk5VFc4czJZRC94VExFYnpCVkkyR2FXL1k4dU9GL3Y3?=
 =?utf-8?B?RjNtR0wrVm9tYWRwMjNGRlpsNXFjK04vaUt1NmUwU1NjL2QrMVN3b2ZWeDBM?=
 =?utf-8?B?TlpMb2lBMVZteFovZmJtY0piV2U2ZHMveE1FK2tZUTNGckVKU3NKSWF1a2t1?=
 =?utf-8?B?elVpMGRibm1kM3pxV1JWLzFBSHhmc3k1VllYQngxT1J6TVJaeGxoNlNLYXk0?=
 =?utf-8?B?TkNxdy8vUThxazJ3OVJDbmpPL3h6YWh3eWNibHFLdW9xNm5aNGVFd3dPQmV3?=
 =?utf-8?B?OUFEYVhYYXBGY0Y2SG1KYVpPNlhQUVBhK0ZSMDNTRmU4c1FtMDVhUjUvU0lN?=
 =?utf-8?B?SCtkOTBEenlVcjZScWQ3eG9NU3dsbzUvK1p5MDNjQ0Jzc1VTM1c2aGVaQnRS?=
 =?utf-8?B?eFhySk5pWFd2cVFqaEx3dit6MFUwdTF4V2hFaHIxVFFkdE9kZ3RXc25RY1ZE?=
 =?utf-8?B?YmNkTEtIWENpQVM0dHkxa05Xc3R3MytPWXZ4aXJmM2JERjdTWWgzNjRmQWlK?=
 =?utf-8?B?U3htTng0YXh4MVRabm83S29vMm4rL0U5Mm5OWFA1S1YzTkhvMHBQSHp1M3lk?=
 =?utf-8?B?Ui9HTmZNTXE5RWpLSFFyeFpNeVNwZHR1SWJPNXNJeGs3bElUVEpMMDU2Q1Bz?=
 =?utf-8?B?bFZSZnVpM3hmRHU5ZDhHcFBiVXhRVnRWK0tBRGM1RFNFZHFWRGFzQWlkMXVv?=
 =?utf-8?B?T0NHb242OWJ2R1FwNEo5OWh5UW5yMjBaV2F6cmZwT2NNMU9MLzJvbSs3L0h6?=
 =?utf-8?B?d29LWU9POTUzMmlRYUNBVEtiTHZIMVRwYUN5VU15SGVYU2xYa08zNjZpWjZP?=
 =?utf-8?B?dmlyWWRJelRQNUlBU21pT1o1MHloQ0NscDVRK25YYXhlVE5ZOU1HWmN5Yk5v?=
 =?utf-8?B?eXdkeG5WdTN2bGl6VW1QOEhSZFh2UkRxUk9mMzk2UXl6bTNSa1Y5ZTYvZXdi?=
 =?utf-8?B?ZDB3ejAxRng1K29jdVVQOWFQS0dWZFVWQ3kyazlQMjBGOThza0lueWd4MU9S?=
 =?utf-8?B?ZkxJUktwb0R6dlpNV0dmNkNOQnluc1RmdUtKT2ZDWWJxYXFDd1dCWmNJVFA3?=
 =?utf-8?B?V1FqVkpxM2VNeEZqTm14YTVJdm8zUEFBclRTWXg2b0dGRHhjOU96TUQvczVy?=
 =?utf-8?B?QTNOdmhRejJPeTFUZVpXc2ZWV2QxZnFsR05xaWlOQ1d0QlkrYU1QbkRVRG5I?=
 =?utf-8?B?SUE1MUp1MktkZVpCSTJ2azNDK2tmTXIySlI2WkZaUVM1c0wvVTZ2SkN6cC9J?=
 =?utf-8?B?b3JuY3RCK3Ryc0VGOElJcUxJSU9rMnB1SFlnS3VqKy9oNjhLY0dyUXBpN0px?=
 =?utf-8?B?N1BOc0hia3htZmxiWFp6d1pUa3RZRHdEOHByc29sVmdWSjZHMldRWlR2azUz?=
 =?utf-8?Q?RK2IgLguwxpfMESnCIAS3qKKo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E633929EB1A89E44ABA00B561361614E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a439ae84-04f0-42be-2732-08dd4ca2a264
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 02:52:34.8787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2fTP8SmvTjBt9COtMTqFubOXLiUm62irVnPlNfdJZoxI6ruh0ZqBztXOr4N3qnvO8OXjqzVmjLW/DYhoFE5Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6958

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBmb3IgYWRkaW5nIGEgZHJp
dmVyIGZvciB0aGUgbmV3IEhETUl2MiBJUCwgYW5kDQo+IGJlZm9yZSBzcGxpdHRpbmcgb3V0IHRo
ZSBjb21tb24gYml0cyBmcm9tIHRoZSBIRE1JIGRyaXZlciwgY2hhbmdlDQo+IHRoZSBtdGtfY2Vj
IGRyaXZlciBmcm9tIGJlaW5nIHJlZ2lzdGVyZWQgZnJvbSB0aGUgbXRrX2hkbWkgZHJpdmVyDQo+
IGl0c2VsZiB0byBiZSBhIG1vZHVsZV9wbGF0Zm9ybV9kcml2ZXIgb2YgaXRzIG93bi4NCj4gDQo+
IEJlc2lkZXMgYmVpbmcgYSBjbGVhbnVwLCB0aGlzIGFsc28gYWxsb3dzIGJ1aWxkIGZsZXhpYmls
aXR5IGJ5DQo+IGFsbG93aW5nIHRvIGNvbXBpbGUgdGhlIENFQ3YxIGRyaXZlciBvbmx5IHdoZW4g
bmVlZGVkIChmb3IgZXhhbXBsZSwNCj4gdGhpcyBpcyBub3QgbmVlZGVkIG5vciB1c2VkIGluIEhE
TUl2MiBjb25maWd1cmF0aW9ucykuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0
ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0
QGJheWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUgICB8IDQgKystLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19jZWMuYyAgfCA3ICsrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfaGRtaS5jIHwgMiArLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19oZG1pLmggfCAxIC0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9NYWtlZmlsZSBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleCAz
MmEyZWQ2YzBjZmUuLmJkZDNhMDYyZjc5NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9NYWtl
ZmlsZQ0KPiBAQCAtMjEsMTAgKzIxLDEwIEBAIG1lZGlhdGVrLWRybS15IDo9IG10a19jcnRjLm8g
XA0KPiANCj4gIG9iai0kKENPTkZJR19EUk1fTUVESUFURUspICs9IG1lZGlhdGVrLWRybS5vDQo+
IA0KPiAtbWVkaWF0ZWstZHJtLWhkbWktb2JqcyA6PSBtdGtfY2VjLm8gXA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgIG10a19oZG1pLm8gXA0KPiArbWVkaWF0ZWstZHJtLWhkbWktb2JqcyA6
PSBtdGtfaGRtaS5vIFwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBtdGtfaGRtaV9kZGMu
bw0KPiANCj4gK29iai0kKENPTkZJR19EUk1fTUVESUFURUtfSERNSSkgKz0gbXRrX2NlYy5vDQo+
ICBvYmotJChDT05GSUdfRFJNX01FRElBVEVLX0hETUkpICs9IG1lZGlhdGVrLWRybS1oZG1pLm8N
Cj4gDQo+ICBvYmotJChDT05GSUdfRFJNX01FRElBVEVLX0RQKSArPSBtdGtfZHAubw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jZWMuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfY2VjLmMNCj4gaW5kZXggYjQyYzBkODdlYmEzLi5jN2JlNTMwY2Ew
NDEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY2VjLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jZWMuYw0KPiBAQCAtMTIsNyArMTIs
NiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiANCj4gICNpbmNs
dWRlICJtdGtfY2VjLmgiDQo+IC0jaW5jbHVkZSAibXRrX2hkbWkuaCINCj4gICNpbmNsdWRlICJt
dGtfZHJtX2Rydi5oIg0KPiANCj4gICNkZWZpbmUgVFJfQ09ORklHICAgICAgICAgICAgICAweDAw
DQo+IEBAIC0xMDIsNiArMTAxLDcgQEAgdm9pZCBtdGtfY2VjX3NldF9ocGRfZXZlbnQoc3RydWN0
IGRldmljZSAqZGV2LA0KPiAgICAgICAgIGNlYy0+aHBkX2V2ZW50ID0gaHBkX2V2ZW50Ow0KPiAg
ICAgICAgIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmNlYy0+bG9jaywgZmxhZ3MpOw0KPiAgfQ0K
PiArRVhQT1JUX1NZTUJPTF9OU19HUEwobXRrX2NlY19zZXRfaHBkX2V2ZW50LCAiRFJNX01US19I
RE1JX1YxIik7DQo+IA0KPiAgYm9vbCBtdGtfY2VjX2hwZF9oaWdoKHN0cnVjdCBkZXZpY2UgKmRl
dikNCj4gIHsNCj4gQEAgLTExMiw2ICsxMTIsNyBAQCBib29sIG10a19jZWNfaHBkX2hpZ2goc3Ry
dWN0IGRldmljZSAqZGV2KQ0KPiANCj4gICAgICAgICByZXR1cm4gKHN0YXR1cyAmIChIRE1JX1BP
UkQgfCBIRE1JX0hUUExHKSkgPT0gKEhETUlfUE9SRCB8IEhETUlfSFRQTEcpOw0KPiAgfQ0KPiAr
RVhQT1JUX1NZTUJPTF9OU19HUEwobXRrX2NlY19ocGRfaGlnaCwgIkRSTV9NVEtfSERNSV9WMSIp
Ow0KPiANCj4gIHN0YXRpYyB2b2lkIG10a19jZWNfaHRwbGdfaXJxX2luaXQoc3RydWN0IG10a19j
ZWMgKmNlYykNCj4gIHsNCj4gQEAgLTI0NywzICsyNDgsNyBAQCBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIG10a19jZWNfZHJpdmVyID0gew0KPiAgICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxl
ID0gbXRrX2NlY19vZl9pZHMsDQo+ICAgICAgICAgfSwNCj4gIH07DQo+ICttb2R1bGVfcGxhdGZv
cm1fZHJpdmVyKG10a19jZWNfZHJpdmVyKTsNCj4gKw0KPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJN
ZWRpYVRlayBIRE1JIENFQyBEcml2ZXIiKTsNCj4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pLmMNCj4gaW5kZXggY2E4MmJjODI5Y2I5Li5kYTcy
NTE4MmYwZGIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRt
aS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaS5jDQo+IEBAIC0x
ODA1LDcgKzE4MDUsNiBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfaGRtaV9k
cml2ZXIgPSB7DQo+IA0KPiAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgKiBjb25zdCBt
dGtfaGRtaV9kcml2ZXJzW10gPSB7DQo+ICAgICAgICAgJm10a19oZG1pX2RkY19kcml2ZXIsDQo+
IC0gICAgICAgJm10a19jZWNfZHJpdmVyLA0KPiAgICAgICAgICZtdGtfaGRtaV9kcml2ZXIsDQo+
ICB9Ow0KPiANCj4gQEAgLTE4MjcsMyArMTgyNiw0IEBAIG1vZHVsZV9leGl0KG10a19oZG1pdHhf
ZXhpdCk7DQo+ICBNT0RVTEVfQVVUSE9SKCJKaWUgUWl1IDxqaWUucWl1QG1lZGlhdGVrLmNvbT4i
KTsNCj4gIE1PRFVMRV9ERVNDUklQVElPTigiTWVkaWFUZWsgSERNSSBEcml2ZXIiKTsNCj4gIE1P
RFVMRV9MSUNFTlNFKCJHUEwgdjIiKTsNCj4gK01PRFVMRV9JTVBPUlRfTlMoIkRSTV9NVEtfSERN
SV9WMSIpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1p
LmggYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2hkbWkuaA0KPiBpbmRleCA0NzJiZjE0
MWM5MmIuLmU0MGJjNDY1MTk5NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19oZG1pLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1p
LmgNCj4gQEAgLTgsNyArOCw2IEBADQo+IA0KPiAgc3RydWN0IHBsYXRmb3JtX2RyaXZlcjsNCj4g
DQo+IC1leHRlcm4gc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtdGtfY2VjX2RyaXZlcjsNCj4gIGV4
dGVybiBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19oZG1pX2RkY19kcml2ZXI7DQo+IA0KPiAg
I2VuZGlmIC8qIF9NVEtfSERNSV9DVFJMX0ggKi8NCj4gLS0NCj4gMi40OC4xDQo+IA0KDQo=

