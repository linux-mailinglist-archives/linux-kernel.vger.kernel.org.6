Return-Path: <linux-kernel+bounces-434649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5661C9E695D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082C32834A8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A3D1DF978;
	Fri,  6 Dec 2024 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E2s+fh8e";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vaNf4ajX"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546511B4122
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733475285; cv=fail; b=TjWVXjoHVCGMskFdFpAbOpYI4oqGN/edykPk08XttkI06NXIhplUyAQHsAMvc/uaGPOBZFSxbqK0xZ8Jm88CRQw2MfnKaj8r2TtvM2I+wKlLR8v6nphfOF82LPgS60jxtk5G7WPbo2OcNv0Yys4QKpNfIFDYs8nUSWLL3cSFPGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733475285; c=relaxed/simple;
	bh=FxLeD2W4BAtyDQOECfAoso7DXQvnKjL43mlDLF8VzrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ho8wESffPfcV2c5PiJHn2cQGbf90FLJyvhAHhAFS7WM4kvOv4mOBDpsEnFSQZq9d6idn6YFYofxgrPTdXDa1kqQLosM9X/30goaqRU2W7UNfvQcUk/whQxoHd6rQPqB8LURA4dRmTxHXt2eBBeJi/RHAG8dMo8n2AGQ9hqxHCIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E2s+fh8e; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vaNf4ajX; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b97f2a48b3af11efbd192953cf12861f-20241206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=FxLeD2W4BAtyDQOECfAoso7DXQvnKjL43mlDLF8VzrQ=;
	b=E2s+fh8eq/56+y4a+M5MsLDIVGnOgC4jzxwEaLeJ7Qj9AeW9XuA++V5EBXrcDV2foUNSY3QegaWJc73jb5G5BF1RbMySkkwPzHTjiS3b1scIRoYu2VVSpiF0ABZxV3lOykIIOAevS28vDnickoLYd/zUCooFlU6Crga3Y21fb1g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:019e4db0-056f-488a-85c7-f70d3591f749,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:5cd54d04-b3ca-4202-ba41-09fe265db19f,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b97f2a48b3af11efbd192953cf12861f-20241206
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 634966724; Fri, 06 Dec 2024 16:54:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Dec 2024 16:54:37 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Dec 2024 16:54:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LexVkHZbs3qpAtCH9jMu7bt++gZk6orZARXeqB+0K0rJq2P4sNU2vGnkmXnxWMZQSveHMguwQeplOa3Ro5tKP0XTmVeGk4AjPuN/Ow4xIBAB4FH/jkLCTen4d0vbVcmB9tZ56mamRFT/ItG+AeMQYd2GywleL5qx/pawVEzNi3ovSvtSG/6C3kW3V9ux+Xg7gWreAbfuQSwNkRYl4XeN5DSi2QsDku92bCPAL9GBfyoiCbLQQ0Q0datycf3KpzL5phkEAOfX6skzjv0d1c3qiVYMY/3kXh1Nj3afdbbZrIstyFTnp0CGULqvHF7gBk44ZtWbMtfwEtF+g0VFJvFfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxLeD2W4BAtyDQOECfAoso7DXQvnKjL43mlDLF8VzrQ=;
 b=t0bM1cMjLkQPs/sx+nSQm1t27gCSgxV26w4z7tqLXxXmpcxoBc1ArekF3WbVpqqVwgzlCdKxZWcOY28sBfVyv/wlwb4VQtlQBPMp4fV7HpSoABmNm90nn8Z4gxrRiqoTF4/TvWQBNgvt6CAaA3eAodv/Eg7NkatF2sz+St73PiYjiS55Kqf/QazRwlmvarOZJpHm1hp7DDqzqrg7LaLwh/IcMnUrQqsGfaJ0r/iu0nTwaTX+QoIxZCsLKX+5VPaTxGuahVnrUVqtjALHtadBo+kfkUKkpRx3iqSVnBN+jFGOr3+VXTk2v5P/Wog7me1XJwD6LvAXMukr6igXEKP6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxLeD2W4BAtyDQOECfAoso7DXQvnKjL43mlDLF8VzrQ=;
 b=vaNf4ajXtnQpW56aJr5CdH+up1nIHx8JP0i0qWJJV+2XJ61j3RetNcm15v6OjFZlG+VFB393bm9Z+lrHJf69RcVFPacwrW9jI3EP8ZNAFlf+te5aQAqR0sDS+Nre282yihATnEqKlONPFxGDOdTN3fXdD2rO/guKWMdaQLjEYEE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB7271.apcprd03.prod.outlook.com (2603:1096:101:89::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 08:54:34 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Fri, 6 Dec 2024
 08:54:34 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "sashal@kernel.org" <sashal@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "javier.carrasco.cruz@gmail.com"
	<javier.carrasco.cruz@gmail.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"wenst@chromium.org" <wenst@chromium.org>
CC: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"sima@ffwll.ch" <sima@ffwll.ch>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 6.13-rc1
Thread-Topic: [git pull] drm for 6.13-rc1
Thread-Index: AQHbO/ENP7Z0QqLQyU2f/PVYOiutsLLGp5WAgABpRYCAABsGgIAR1S2A
Date: Fri, 6 Dec 2024 08:54:33 +0000
Message-ID: <17d4fac0db55a8f9835b53d55463ed9c4331950d.camel@mediatek.com>
References: <CAPM=9txbfH8vf-YjwTXEYL729a6r2eeLBxCJc3MSD-t5jXVA-w@mail.gmail.com>
	 <Z0NXQ6iRK43x6WbG@sashalap>
	 <CAPM=9tw5eTBCDn93GyrMjF3r_kDbr2-v1GgKdZECFNupqakDFw@mail.gmail.com>
	 <95f01caa-0f32-4c5c-b262-435f839c81aa@gmail.com>
In-Reply-To: <95f01caa-0f32-4c5c-b262-435f839c81aa@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB7271:EE_
x-ms-office365-filtering-correlation-id: 270316dd-d2c3-42e3-684e-08dd15d39b0c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d1dHd2ZiUWlUN3RpYlpPeVJiQW5TMTJ4bzg2SWVPR3hqZllzYlZYbllwOVND?=
 =?utf-8?B?TTNsYXNFcHFLV1RnRUE2WEdwaEdEMmdwTm5ZWStrdC83WERrMDgyTFdQK1pP?=
 =?utf-8?B?TFk1bUdFcHU1M0ZUYlozcFJEcHloV1pUTEN4U2ovWVE1ZVBaTFdpVzlRa0Uv?=
 =?utf-8?B?RDN2K2NPNGNBSXFiMmJxd2s2V2lpM3BKR1BCRU1ZQkRYTDFxTzFLc2lsek9Z?=
 =?utf-8?B?YTVaWHEwYzFVdGcrSUd5L0NzRWgrZ1FZazhGVGk3aVZKTS9FbjJ6VUxRZXNn?=
 =?utf-8?B?c2o0RDJPTEpvUUtnSEJhalhuVmowa1M3V2Ywbk5xcDBBcTBKdWN5L09lR2Vh?=
 =?utf-8?B?bnMzR0ZiQTBrSitMOEY1RTJrZTl3bmJzNjMvWHZtcWkwWmpEWW4xKzdpSHF6?=
 =?utf-8?B?Tkd3ZFJsSlNJQlRuVXphRzI3c0tSc1J5R2dQdWNTY0VtNHZaR2hJY2ZIWFZ2?=
 =?utf-8?B?cEN0NURDTWxXR2E2MUh5TmcvT3p1T1RBSktOb1hOUFBpMXByZlR0ak1vZUg2?=
 =?utf-8?B?RGFiY1d0M1JNcXl4NjhieEFTakV4L1Q0Znc2R3ZQa1BkVTJzSmsweG5VYkhQ?=
 =?utf-8?B?Snd2UFZmUk52anVxTXFsTnN0T1B2anpYNERZZ2liWU40WnhabFZ1VnZUZjMz?=
 =?utf-8?B?VmhnZHNOUlIvQTRZYms1ajVoV1NuemNIQWl6d0xka243aXJVT05ZNjVGdTIw?=
 =?utf-8?B?d3krSmp4WEFoNmNlRTdRaHJpT0pISHdKU0hlbEtTMnowK0VHbHIzY1EyMmtQ?=
 =?utf-8?B?Z2YwaldnS2JDSU9GVlRrRW9rSitSRFYvL3FaSndodm9nMkJPMDdER2p5NzBE?=
 =?utf-8?B?Q202dTQ5VGgzd0xyNi9ES05taC9tZldYc0xCUlNOYjVvditIcFVWeGR6RVBY?=
 =?utf-8?B?UU12c3dIQWpoY1JEd1h1L0VEVExyTC90bXAzcmFKTG90MWdqZUVGdHptVG9p?=
 =?utf-8?B?dGpIQmhtaWExTURYeDNaVFlMMzNnYktPU2xnaWpxNjlSM0xQQnVTeFZrb1Fp?=
 =?utf-8?B?NDdJV1ZNWGJjOXVJaGc0eUE3OWwwN2VOKzdpd2JsYmttdGR2UWNWdlFkSkVL?=
 =?utf-8?B?Yk5Zd0hYTHNobVFoM2xzOFJ1RGl4ZmRuQjZKMmdLc0R2UjRBaGpmOGVDeWhq?=
 =?utf-8?B?RVlYcGNLU1NhNUhaT1lwY2pCdlYzQVRkdHgvbytTRytNeFEzNUM0Mm5BdEZn?=
 =?utf-8?B?YU1UdEhDWkRtQ0FNNVVaelNyZUVLYi9mRTJnM2gwaklCL0ZpM0dyTTZqSlU0?=
 =?utf-8?B?RW94c3dFaEs1SVNrTlJyV2ZMNGcxV1hNM0N2QU5SZHR5YVl2R1BrSVJGZmFy?=
 =?utf-8?B?Zk9hTVpvRUtERnFhR3RDallzOG5rTDBYblcwQkJpZTdqS2VPRkIwUjVzeXFS?=
 =?utf-8?B?M05TZCt3aEpLYUpZUENKbFhuOXpBZERWci8rWG5VY2VoRVhIWTNmVGNLdDdi?=
 =?utf-8?B?U2F2RWZCRjA1bklTaEVOWmVBQkVRa0NxUkZ4Y2IrNGoyVVhnUmNZUTFEM1pu?=
 =?utf-8?B?djBXQXdVUnc2b1MrZE1TSUpWaWdSS1pmaU5uZ29va3gwaEJadlFSb01tRGpw?=
 =?utf-8?B?T005cVcxbXpCSXBkMStZUm1DcEpwRjE5cldvWmJNK1YvRWJoYm1kZXdhVW81?=
 =?utf-8?B?YTJ0b21NYk5kcnhJSm5oWWRZRWhydjBpd09rK0FGVUFBRS9JcTZZNUJta08w?=
 =?utf-8?B?RStOc2hGM1N6L2xjTU41RUQ3NGlCNkRZeHRMdEUrbVR5dVRJWnIwZmMyUmFn?=
 =?utf-8?B?L1VReHhXM1FNdEpSbWlZcGs0ODhPN3N2d2NWSDRORUZDeHlNam5hM1p3bWMr?=
 =?utf-8?B?S1BRZW9Ga3JrU1NTSnJHYzFFamJBblo5L2JvdmlJYytiQnNueThBbUpxWjQr?=
 =?utf-8?B?T2gxd2JUdlhjaVRrVythT1FtT0o4V3RYWVI0VndOWmRkNUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjB1bmx2NjRuV3BUcTZod2NLQ3RCeUYvaTlCU0ZZRjRUeFdTNlJpbjVJSEdi?=
 =?utf-8?B?MVVSa1RKMXg4Ukt6SUM1SmhUS1R0blVPYit4aitjTjN5S2RiMlZ3WGEzRWFt?=
 =?utf-8?B?RUxrb2ZlMnY5bjd1Vkt5MjgzSkVQeEZtQjhtYkc0MFR6YVJtWXVXRXZCci9y?=
 =?utf-8?B?TnJ4Zmtvd2ZHckt6L2R2ZkwyNDl5Y2xGODZaZEIyeEFSQ0FuNmdJSVFTcW5x?=
 =?utf-8?B?U1djVlh4OFpGQSt5NEIrVWNuQURnQVpBRW1YeUd1UCtITDFXK3RnWFVWNTZk?=
 =?utf-8?B?WXNrMlBCR3FDQlNtR2gwVjhTUHErTDRnbTR1WHpxQkFlSk9OVWRhSjF3K2M1?=
 =?utf-8?B?QkJQT3hTZmxNcnpwSVpVZUdzNE5jYS90b1lGcTQ3YzZSRytaaXNGSmY2bnJ0?=
 =?utf-8?B?VFIwVVJ0K0JpdTZrV1NBWlNUM0FzVmtTalBPVm4zbndtbmxYeVFPRVI5eHEr?=
 =?utf-8?B?MU8vbjM1WDhJc2NObmk2RG81OEpoVnkwcThjZUw2bER1N1dPMEYrZnQzVTRK?=
 =?utf-8?B?dnZrZDNUbzdMWWlJYWN4b2w0bDFDU2h5TlRPSWN5YTFBTllLUWluaGF0Nm5S?=
 =?utf-8?B?cGZSSnljY0JLSjZSMnBXR1p5Zjl6eFhoMW96S1JEdjBKT09wQTl3Z0NFa2lW?=
 =?utf-8?B?ZmRrTDlVcUswSUtlN0lVbGNIZlh3VXhFOHczZFNxK01rWCtvOEE0TjNtUG9Q?=
 =?utf-8?B?Q3NOR1RJZ0EvcGpFZ1FKU0hCUTRxNlNFdTJUV3hVMzFpeUtMVzJNWExpM3d6?=
 =?utf-8?B?eGh0TVNqZVp1NDI0Nkg2aGtNOWIzMGdHb1VlS0plalFmMTV1aDFCQ1FvSjVn?=
 =?utf-8?B?dnc3Ni9yUnRrR0V6OVVFSGpqZ2wvNW9FNHplb2NmOTI5dHRZODhUWlVFNmdu?=
 =?utf-8?B?MGkwMzFtZFo4MVl4YjdUZ1Buc015TFV4RDd6R2ltbXlYUkdBcWJjL0FkZ3Fr?=
 =?utf-8?B?VjZWU0FRN1VVdHVBUEdSTGdIekFqaVd2dEQ1V1dCUUluM0tDaGZIRGxVN1lp?=
 =?utf-8?B?WmlKbHRhV1UvMjlVUG5DOHA1eE0vOUFtVW9XS21EZi82VEtzR3NsVldBS0J0?=
 =?utf-8?B?UDBveU5tN3ZTblgyK3lNSHVGczNUU2VnV2pIVDIveUkyN1Q1RHBIZTk0T3Rj?=
 =?utf-8?B?KzBnRHhhNTlSV040NGgvdFJ6d2YxRmZKYnZZSXU4VHlCWUFmR2JjQlA1dm9m?=
 =?utf-8?B?ckluMGEwYWJ4TE1nbXRxakxGMzgvYldhdjRvMnRUdS9Ub1BWUHM5Z2oyd3Mv?=
 =?utf-8?B?emh2UG5NTWZtL21naFhxdFVwb1BlNVUwL3psWUFGWE5BdVVndWtYbXpWWW5D?=
 =?utf-8?B?OE5SdGdGWHNDN1hJTzR6a3VqeG9YS2N5NUpoWVN4WkxGcVFpcGxSZUlUVHFE?=
 =?utf-8?B?cjQzMHYrVmYvNU94MFF6QjM5NGQ0cDhDVktzeE4vQWc1ODNqa3h4eTVJSFlN?=
 =?utf-8?B?bUxIRGVtOHN6WWM2dENyekw3VDNJMTRnMkFMWkFQMHFza21tU3VGQ2xmaTZt?=
 =?utf-8?B?S3ZzNW5kakprWkR6NHdDbGRvc0RKU0hsNUE2N3cwdDhQZjc5VHFkZ1FPZHdU?=
 =?utf-8?B?T2VpbU9KTTZzOWZvOVFRdzVIcFpKZlRWejcySjJMVkNGVndBYmRrVVQwNkEx?=
 =?utf-8?B?aVQrV3JWUzBOZVpXOFcxTVg4ZXRySyt6WGF1MDZnTTROK1grNk5GOVlMT3lu?=
 =?utf-8?B?cHhVK2ZkMDdhRGJQMENPTWVNQ2JyS0lhZWdiWVIraGt5dEZ4TVo4OTMxVDZR?=
 =?utf-8?B?UzVBcHl3OVVydkxodVQ5NHVRSW1aRXpjVFYzMExUdEs0VXdzdWh1dTFxb0di?=
 =?utf-8?B?YVlIcWxDcXFNbTZ3WERvOC9NNk5XS2tzbkpEaWZ2eVB5ak9PM0JTdzA3T1JE?=
 =?utf-8?B?eG5yVFhtakVSK1BCN05NTm5Ccml3ZGJ3Mm5hNGtiZVNrYUhibHUxVUlzY0R2?=
 =?utf-8?B?MzdvUHFhTEc4VGVTQ3dqRFd5T1llYy9FdVhreVpkZzg1enlZWnQxVUhuRE5H?=
 =?utf-8?B?cFlwa2c1RnFYZDJMc2tjN0lHVkdNWlF0a3lHa3UvZktrN0cweE1LVlg2TGhM?=
 =?utf-8?B?bDNjY3pOZVVVb0VzcU5QZjJOcVptM1VxQXR3a3ZzRXI5T1JKV3VlZHR1c0lq?=
 =?utf-8?Q?o/KxUZU9a5EF54f317T47dI08?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35373F5A3273EC479E6C7DAE11161B04@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270316dd-d2c3-42e3-684e-08dd15d39b0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 08:54:33.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6wJAOXNN3rKNKaYjXsLpvRxTCfHb4i88eY4AFG2X+WPxtfnGuWwOkvKXwKILIKJQUKinEm+KNN5PkttRMEuRYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7271

SGksIFNhc2hhOg0KDQpPbiBNb24sIDIwMjQtMTEtMjUgYXQgMDE6MzUgKzAxMDAsIEphdmllciBD
YXJyYXNjbyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiAyNC8xMS8yMDI0IDIzOjU4LCBEYXZlIEFp
cmxpZSB3cm90ZToNCj4gPiBPbiBNb24sIDI1IE5vdiAyMDI0IGF0IDAyOjQxLCBTYXNoYSBMZXZp
biA8c2FzaGFsQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBPbiBUaHUsIE5vdiAy
MSwgMjAyNCBhdCAxMDoyNTo0NUFNICsxMDAwLCBEYXZlIEFpcmxpZSB3cm90ZToNCj4gPiA+ID4g
SGkgTGludXMsDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGlzIHRoZSBtYWluIGRybSBwdWxsIHJl
cXVlc3QgZm9yIDYuMTMuDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ3ZlIGRvbmUgYSB0ZXN0IG1lcmdl
IGludG8geW91ciB0cmVlLCB0aGVyZSB3ZXJlIHR3byBjb25mbGljdHMgYm90aA0KPiA+ID4gPiBv
ZiB3aGljaCBzZWVtIGVhc3kgZW5vdWdoIHRvIHJlc29sdmUgZm9yIHlvdS4NCj4gPiA+ID4gDQo+
ID4gPiA+IFRoZXJlJ3MgYSBsb3Qgb2YgcmV3b3JrLCB0aGUgcGFuaWMgaGVscGVyIHN1cHBvcnQg
aXMgYmVpbmcgYWRkZWQgdG8NCj4gPiA+ID4gbW9yZSBkcml2ZXJzLCB2M2QgZ2V0cyBzdXBwb3J0
IGZvciBIVyBzdXBlcnBhZ2VzLCBzY2hlZHVsZXINCj4gPiA+ID4gZG9jdW1lbnRhdGlvbiwgZHJt
IGNsaWVudCBhbmQgdmlkZW8gYXBlcnR1cmUgcmV3b3Jrcywgc29tZSBuZXcNCj4gPiA+ID4gTUFJ
TlRBSU5FUlMgYWRkZWQsIGFtZGdwdSBoYXMgdGhlIHVzdWFsIGxvdHMgb2YgSVAgcmVmYWN0b3Jz
LCBJbnRlbA0KPiA+ID4gPiBoYXMgc29tZSBQYW50aGVybGFrZSBlbmFibGVtZW50IGFuZCB4ZSBp
cyBnZXR0aW5nIHNvbWUgU1JJT1YgYml0cywgYnV0DQo+ID4gPiA+IGp1c3QgbG90cyBvZiBzdHVm
ZiBldmVyeXdoZXJlLg0KPiA+ID4gPiANCj4gPiA+ID4gTGV0IG1lIGtub3cgaWYgdGhlcmUgYXJl
IGFueSBpc3N1ZXMsDQo+ID4gPiANCj4gPiA+IEhleSBEYXZlLA0KPiA+ID4gDQo+ID4gPiBBZnRl
ciB0aGUgUFIgd2FzIG1lcmdlZCwgSSd2ZSBzdGFydGVkIHNlZWluZyBib290IGZhaWx1cmVzIHJl
cG9ydGVkIGJ5DQo+ID4gPiBLZXJuZWxDSToNCj4gPiANCj4gPiBJJ2xsIGFkZCB0aGUgbWVkaWF0
ZWsgbmFtZXMgSSBzZWUgd2hvIHRvdWNoZWQgYW55dGhpbmcgaW4gdGhlIGFyZWEgcmVjZW50bHku
DQo+ID4gDQo+ID4gRGF2ZS4NCj4gPiA+IA0KPiA+ID4gWyAgICA0LjM5NTQwMF0gbWVkaWF0ZWst
ZHJtIG1lZGlhdGVrLWRybS41LmF1dG86IGJvdW5kIDFjMDE0MDAwLm1lcmdlIChvcHMgMHhmZmZm
ZDM1ZmQxMjk3NWY4KQ0KPiA+ID4gWyAgICA0LjM5NjE1NV0gbWVkaWF0ZWstZHJtIG1lZGlhdGVr
LWRybS41LmF1dG86IGJvdW5kIDFjMDAwMDAwLm92bCAob3BzIDB4ZmZmZmQzNWZkMTI5NzdiOCkN
Cj4gPiA+IFsgICAgNC40MTE5NTFdIG1lZGlhdGVrLWRybSBtZWRpYXRlay1kcm0uNS5hdXRvOiBi
b3VuZCAxYzAwMjAwMC5yZG1hIChvcHMgMHhmZmZmZDM1ZmQxMjk4OWMwKQ0KPiA+ID4gWyAgICA0
LjUzNjgzN10gbWVkaWF0ZWstZHJtIG1lZGlhdGVrLWRybS41LmF1dG86IGJvdW5kIDFjMDA0MDAw
LmNjb3JyIChvcHMgMHhmZmZmZDM1ZmQxMjk2Y2YwKQ0KPiA+ID4gWyAgICA0LjU0NTE4MV0gbWVk
aWF0ZWstZHJtIG1lZGlhdGVrLWRybS41LmF1dG86IGJvdW5kIDFjMDA1MDAwLmFhbCAob3BzIDB4
ZmZmZmQzNWZkMTI5NmE4MCkNCj4gPiA+IFsgICAgNC41NTMzNDRdIG1lZGlhdGVrLWRybSBtZWRp
YXRlay1kcm0uNS5hdXRvOiBib3VuZCAxYzAwNjAwMC5nYW1tYSAob3BzIDB4ZmZmZmQzNWZkMTI5
NzJiMCkNCj4gPiA+IFsgICAgNC41NjE2ODBdIG1lZGlhdGVrLWRybSBtZWRpYXRlay1kcm0uNS5h
dXRvOiBib3VuZCAxYzAxNDAwMC5tZXJnZSAob3BzIDB4ZmZmZmQzNWZkMTI5NzVmOCkNCj4gPiA+
IFsgICAgNC41NzAwMjVdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KPiA+
ID4gWyAgICA0LjU3NDYzMF0gcmVmY291bnRfdDogdW5kZXJmbG93OyB1c2UtYWZ0ZXItZnJlZS4N
Cj4gPiA+IFsgICAgNC41Nzk0MTZdIFdBUk5JTkc6IENQVTogNiBQSUQ6IDgxIGF0IGxpYi9yZWZj
b3VudC5jOjI4IHJlZmNvdW50X3dhcm5fc2F0dXJhdGUrMHhmNC8weDE0OA0KPiA+ID4gWyAgICA0
LjU4NzY3MF0gTW9kdWxlcyBsaW5rZWQgaW46DQo+ID4gPiBbICAgIDQuNTkwNzE0XSBDUFU6IDYg
VUlEOiAwIFBJRDogODEgQ29tbToga3dvcmtlci91MzI6MyBUYWludGVkOiBHICAgICAgICBXICAg
ICAgICAgIDYuMTIuMCAjMSBjYWI1OGUyZTU5MDIwZWJkNGJlOGFkYTg5YTY1ZjQ2NWEzMTZjNzQy
DQo+ID4gPiBbICAgIDQuNjAyNjk1XSBUYWludGVkOiBbV109V0FSTg0KPiA+ID4gWyAgICA0LjYw
NTY0OV0gSGFyZHdhcmUgbmFtZTogQWNlciBUb21hdG8gKHJldjIpIGJvYXJkIChEVCkNCj4gPiA+
IFsgICAgNC42MTA5NDddIFdvcmtxdWV1ZTogZXZlbnRzX3VuYm91bmQgZGVmZXJyZWRfcHJvYmVf
d29ya19mdW5jDQo+ID4gPiBbICAgIDQuNjE2NzY4XSBwc3RhdGU6IDYwNDAwMDA5IChuWkN2IGRh
aWYgK1BBTiAtVUFPIC1UQ08gLURJVCAtU1NCUyBCVFlQRT0tLSkNCj4gPiA+IFsgICAgNC42MjM3
MTVdIHBjIDogcmVmY291bnRfd2Fybl9zYXR1cmF0ZSsweGY0LzB4MTQ4DQo+ID4gPiBbICAgIDQu
NjI4NDkzXSBsciA6IHJlZmNvdW50X3dhcm5fc2F0dXJhdGUrMHhmNC8weDE0OA0KPiA+ID4gWyAg
ICA0LjYzMzI3MF0gc3AgOiBmZmZmODAwMDgwNzYzOWMwDQo+ID4gPiBbICAgIDQuNjM2NTcxXSB4
Mjk6IGZmZmY4MDAwODA3NjM5YzAgeDI4OiBmZmZmMzRmZjQxMTZjNjQwIHgyNzogZmZmZjM0ZmY0
MzY4ZTA4MA0KPiA+ID4gWyAgICA0LjY0MzY5M10geDI2OiBmZmZmZDM1ZmQxMjk5YWM4IHgyNTog
ZmZmZjM0ZmY0NmM4YzQxMCB4MjQ6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiA+IFsgICAgNC42NTA4
MTRdIHgyMzogZmZmZjM0ZmY0MzY4ZTA4MCB4MjI6IDAwMDAwMDAwZmZmZmZkZmIgeDIxOiAwMDAw
MDAwMDAwMDAwMDAyDQo+ID4gPiBbICAgIDQuNjU3OTM0XSB4MjA6IGZmZmYzNGZmNDcwYzYwMDAg
eDE5OiBmZmZmMzRmZjQxMGM3YzEwIHgxODogMDAwMDAwMDAwMDAwMDAwNg0KPiA+ID4gWyAgICA0
LjY2NTA1NV0geDE3OiA2NjY2NzgzMDIwNzM3MDZmIHgxNjogMjgyMDY1Njc3MjY1NmQyZSB4MTU6
IGZmZmY4MDAwODA3NjM0NDANCj4gPiA+IFsgICAgNC42NzIxNzZdIHgxNDogMDAwMDAwMDAwMDAw
MDAwMCB4MTM6IDJlNjU2NTcyNjYyZDcyNjUgeDEyOiBmZmZmZDM1ZmQyZWQxNGYwDQo+ID4gPiBb
ICAgIDQuNjc5Mjk3XSB4MTE6IDAwMDAwMDAwMDAwMDAwMDEgeDEwOiAwMDAwMDAwMDAwMDAwMDAx
IHg5IDogZmZmZmQzNWZkMDM0MjE1MA0KPiA+ID4gWyAgICA0LjY4NjQxOF0geDggOiBjMDAwMDAw
MGZmZmZkZmZmIHg3IDogZmZmZmQzNWZkMmUyMTQ1MCB4NiA6IDAwMDAwMDAwMDAwYWZmYTgNCj4g
PiA+IFsgICAgNC42OTM1MzldIHg1IDogZmZmZmQzNWZkMmVkMTQ5OCB4NCA6IDAwMDAwMDAwMDAw
MDAwMDAgeDMgOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gPiBbICAgIDQuNzAwNjYwXSB4MiA6IDAw
MDAwMDAwMDAwMDAwMDAgeDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgwIDogZmZmZjM0ZmY0MDkzMjU4
MA0KPiA+ID4gWyAgICA0LjcwNzc4MV0gQ2FsbCB0cmFjZToNCj4gPiA+IFsgICAgNC43MTAyMTZd
ICByZWZjb3VudF93YXJuX3NhdHVyYXRlKzB4ZjQvMHgxNDggKFApDQo+ID4gPiBbICAgIDQuNzE0
OTkzXSAgcmVmY291bnRfd2Fybl9zYXR1cmF0ZSsweGY0LzB4MTQ4IChMKQ0KPiA+ID4gWyAgICA0
LjcxOTc3Ml0gIGtvYmplY3RfcHV0KzB4MTEwLzB4MTE4DQo+ID4gPiBbICAgIDQuNzIzMzM1XSAg
cHV0X2RldmljZSsweDFjLzB4MzgNCj4gPiA+IFsgICAgNC43MjY2MzhdICBtdGtfZHJtX2JpbmQr
MHgyOTQvMHg1YzANCj4gPiA+IFsgICAgNC43MzAyODldICB0cnlfdG9fYnJpbmdfdXBfYWdncmVn
YXRlX2RldmljZSsweDE2Yy8weDFlMA0KPiA+ID4gWyAgICA0LjczNTY3M10gIF9fY29tcG9uZW50
X2FkZCsweGJjLzB4MWMwDQo+ID4gPiBbICAgIDQuNzM5NDk1XSAgY29tcG9uZW50X2FkZCsweDFj
LzB4MzANCj4gPiA+IFsgICAgNC43NDMwNThdICBtdGtfZGlzcF9yZG1hX3Byb2JlKzB4MTQwLzB4
MjEwDQo+ID4gPiBbICAgIDQuNzQ3MzE0XSAgcGxhdGZvcm1fcHJvYmUrMHg3MC8weGQwDQo+ID4g
PiBbICAgIDQuNzUwOTY0XSAgcmVhbGx5X3Byb2JlKzB4YzQvMHgyYTgNCj4gPiA+IFsgICAgNC43
NTQ1MjddICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4MC8weDE0MA0KPiA+ID4gWyAgICA0Ljc1
ODg3MF0gIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg0NC8weDEyMA0KPiA+ID4gWyAgICA0Ljc2MzA0
MF0gIF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHhjMC8weDEwOA0KPiA+ID4gWyAgICA0Ljc2NzQ3
MF0gIGJ1c19mb3JfZWFjaF9kcnYrMHg4Yy8weGYwDQo+ID4gPiBbICAgIDQuNzcxMjk0XSAgX19k
ZXZpY2VfYXR0YWNoKzB4YTQvMHgxOTgNCj4gPiA+IFsgICAgNC43NzUxMTddICBkZXZpY2VfaW5p
dGlhbF9wcm9iZSsweDFjLzB4MzANCj4gPiA+IFsgICAgNC43NzkyODZdICBidXNfcHJvYmVfZGV2
aWNlKzB4YjQvMHhjMA0KPiA+ID4gWyAgICA0Ljc4MzEwOV0gIGRlZmVycmVkX3Byb2JlX3dvcmtf
ZnVuYysweGIwLzB4MTAwDQo+ID4gPiBbICAgIDQuNzg3NzE0XSAgcHJvY2Vzc19vbmVfd29yaysw
eDE4Yy8weDQyMA0KPiA+ID4gWyAgICA0Ljc5MTcxMl0gIHdvcmtlcl90aHJlYWQrMHgzMGMvMHg0
MTgNCj4gPiA+IFsgICAgNC43OTU0NDldICBrdGhyZWFkKzB4MTI4LzB4MTM4DQo+ID4gPiBbICAg
IDQuNzk4NjY1XSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4gPiA+IFsgICAgNC44MDIyMjld
IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA+ID4gDQo+ID4gPiBJIGRv
bid0IHRoaW5rIHRoYXQgSSdsbCBiZSBhYmxlIHRvIGJpc2VjdCBmdXJ0aGVyIGFzIEkgZG9uJ3Qg
aGF2ZSB0aGUNCj4gPiA+IHJlbGV2YW50IGhhcmR3YXJlIGF2YWlsYWJsZS4NCj4gPiA+IA0KPiA+
ID4gLS0NCj4gPiA+IFRoYW5rcywNCj4gPiA+IFNhc2hhDQo+IA0KPiANCj4gSGVsbG8sIEkgYW0g
b25lIG9mIHRob3NlIHdobyB0b3VjaGVkIHNvbWV0aGluZyBpbiB0aGUgYXJlYS4NCj4gDQo+IFRv
IGNoZWNrIGlmIG15IGNoYW5nZXMgYXJlIHRoZSBjYXVzZSBvZiB0aGUgYm9vdCBmYWlsdXJlcywg
cGxlYXNlIGFwcGx5DQo+IHRoaXMgcGF0Y2g6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kcnYuYw0KPiBpbmRleCA5YThlZjg1NThkYTkuLjg1YmUwMzVhMjA5YSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTM3MywxMSAr
MzczLDEyIEBAIHN0YXRpYyBib29sIG10a19kcm1fZ2V0X2FsbF9kcm1fcHJpdihzdHJ1Y3QgZGV2
aWNlDQo+ICpkZXYpDQo+ICAgICAgICAgc3RydWN0IG10a19kcm1fcHJpdmF0ZSAqdGVtcF9kcm1f
cHJpdjsNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKnBoYW5kbGUgPSBkZXYtPnBhcmVu
dC0+b2Zfbm9kZTsNCj4gICAgICAgICBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICpvZl9pZDsN
Cj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGU7DQo+ICAgICAgICAgc3RydWN0IGRl
dmljZSAqZHJtX2RldjsNCj4gICAgICAgICB1bnNpZ25lZCBpbnQgY250ID0gMDsNCj4gICAgICAg
ICBpbnQgaSwgajsNCj4gDQo+IC0gICAgICAgZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZV9zY29wZWQo
cGhhbmRsZS0+cGFyZW50LCBub2RlKSB7DQo+ICsgICAgICAgZm9yX2VhY2hfY2hpbGRfb2Zfbm9k
ZShwaGFuZGxlLT5wYXJlbnQsIG5vZGUpIHsNCj4gICAgICAgICAgICAgICAgIHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXY7DQo+IA0KPiAgICAgICAgICAgICAgICAgb2ZfaWQgPSBvZl9tYXRj
aF9ub2RlKG10a19kcm1fb2ZfaWRzLCBub2RlKTsNCj4gDQoNCkRvZXMgSmF2aWVyJ3MgcGF0Y2gg
Zml4IHRoZSBwcm9ibGVtPw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gLS0tDQo+IA0KPiANCj4g
VGhpcyBjaHVuayBjYW4gYmUgZm91bmQgaW4gbXRrX2RybV9nZXRfYWxsX2RybV9wcml2KCksIHdo
aWNoIGlzIG5vdA0KPiBsaXN0ZWQgaW4gdGhlIHRyYWNlLCBidXQgaXQgaXMgY2FsbGVkIGZyb20g
bXRrX2RybV9iaW5kKCkuDQo+IA0KPiBUaGUgbG9vcCBkaWQgbm90IHJlbGVhc2UgdGhlIGNoaWxk
X25vZGUgaWYgY250ID09IE1BWF9DUlRDIChieSBtZWFucyBvZg0KPiBhIGJyZWFrKSwgd2hpY2gg
Z29lcyBhZ2FpbnN0IGhvdyBmb3JfZWFjaF9jaGlsZF9vZl9ub2RlKCkgc2hvdWxkIGJlDQo+IGhh
bmRsZWQuIElmIHRoZSBjaGlsZF9ub2RlIGlzIGluZGVlZCByZXF1aXJlZCBhZnRlcndhcmRzIChp
dCBpcyBub3QNCj4gcmVmZXJlbmNlZCBhbnl3aGVyZSBhZnRlciB0aGUgbG9vcCksIGl0IHNob3Vs
ZCBiZSBhY3F1aXJlZCB2aWENCj4gb2Zfbm9kZV9nZXQoKSBhbmQgc3RvcmVkIHNvbWV3aGVyZSB0
byBiZSBhYmxlIHRvIHB1dCBpdCBsYXRlci4NCj4gDQo+IFRoZW4gYW5vdGhlciBpc3N1ZSB3b3Vs
ZCBsaWUgdW5kZXJuZWF0aCBhcyB0aGUgcmVmZXJlbmNlIHRvIHRoZQ0KPiBjaGlsZF9ub2RlIGlz
IG5vdCBzdG9yZWQgaW4gYW55IHdheS4gQnV0IGlmIHRoaXMgcGF0Y2ggZml4ZXMgdGhlIGlzc3Vl
LA0KPiB0aGVuIEkgc3VwcG9zZSBpdCBzaG91bGQgYmUgYXBwbGllZCBpbW1lZGlhdGVseSwgYW5k
IHRoZSByZXN0IHNob3VsZCBiZQ0KPiBkaXNjdXNzZWQgbGF0ZXIgb24uDQo+IA0KPiBCeSB0aGUg
d2F5LCBhcmUgdGhlcmUgYW55IGxvZ3Mgd2l0aCBkZWJ1Zy9lcnJvciBtZXNzYWdlcyB0byBhbmFs
eXplDQo+IGZ1cnRoZXIgaXMgdGhlIGlzc3VlIGlzIHNvbWV0aGluZyBkaWZmZXJlbnQ/DQo+IA0K
PiBUaGFua3MgYW5kIGJlc3QgcmVnYXJkcywNCj4gSmF2aWVyIENhcnJhc2NvDQoNCg==

