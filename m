Return-Path: <linux-kernel+bounces-423214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC7E9DA470
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 10:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F67286446
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241C1917E7;
	Wed, 27 Nov 2024 09:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mZNvzNGW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QARkIsld"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D6D18E361;
	Wed, 27 Nov 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698293; cv=fail; b=Bz10S3sY+SgnJtSkO96iuPzdPZ3cNx0h0aVyWxmP8ic3XsSGL9DElXf25q1Mf48chH/pxYkmJjwFM8GRobW6VoxLbw6xI3Y1OHQ3feMjsfNvp6Rc24fcw8Fqw6fkUzZ2H2c7hKldk+CCHL+/a1EdDMTuUQ3g43ZH32+7VjsLURw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698293; c=relaxed/simple;
	bh=ZWQNAkI9pUaixGyz1aL8v5JZUQOsf25Ubo4vwdqfSjs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CD7MUKkwJgmpDs225GOpXGJP6weCFK5uYPN0Bw3qgHVeJST05Q8YMgVht2aDb3A97iyrjX7o6xAJ1nLeN6G31YlZZ/8av6mBX9Q4VMHolIvyhrU+bO+VolzHWeE+il5BzDjbCGW3QKlTwDLKJXL+L4PQuPDeq66+vw/XEmc8GLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mZNvzNGW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QARkIsld; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a41e75b8ac9e11efbd192953cf12861f-20241127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ZWQNAkI9pUaixGyz1aL8v5JZUQOsf25Ubo4vwdqfSjs=;
	b=mZNvzNGWUNrnMh6VGmoRnSAZBxNCeSI5k4fIGo4GTKi7iVnwZbc1PxKtnbVdko1tb2lrhxfyY1cxtbKjKw1DlchAYBAvhBttnFxGeJRhakdghU21U6W4fs616QpDHKGalNU43njyF90Wg5MM6isg7D6bV0qAfPR/Ph8/3uHzvu4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:562811c2-6be4-4046-b63e-1c42a2d0340e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:ee155be0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a41e75b8ac9e11efbd192953cf12861f-20241127
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 140770613; Wed, 27 Nov 2024 17:04:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Nov 2024 17:04:41 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Nov 2024 17:04:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5CoMRXH/b67H44L2ASGdaGWzF2oR9n9Los6wdw1wjZRtYqv+ZBDJpvOdZpG/rgzJ8H7Wy3RKT4tovPW35PY2jkhVb7Z1g+WUL8jTe8I0cePZtuttSsuTM942zhbSEuY9Xbt28VDCwnqNulZ7n2zt6ghbBFTsw63r1ny3RhlIsz1seozCGJ6WIAhgPaavz7+F/1VPMAOZS3Q4QDfLy5CfmhiyTzUrq+J1zmLqyQWbx0Bves5hwevksliojU2zod9ri8xKaUnkmngq2gOxnen9hodG8aCWzZOVA4hbvHcDlENdVPYztw39h2ZrCknlXXyjUD/CZ7ROFshE/oD8/L99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWQNAkI9pUaixGyz1aL8v5JZUQOsf25Ubo4vwdqfSjs=;
 b=m216uow834wLPFBIV55tajKqVNpAbfnnTi5H/l5roZoPgbf9dk+eyOxFHOln2uo6cK4gss/3u2+bxUvd6gAw9Ob2I1yLoIJ3H52SWBDSy1twl8gRzNx9PnH+AOZsniIhf7SnoJFIeljNOdGj/3GhpN/v497mjPyD7YAsY37t3dvPXRbFo5o2fviQFsQCN/W4rqgCSH6IItv0a8hOpH8tkrrMBIGdAW0JZMEUKwxbvRUzO4b3/JV38eJsSwzlP/paORJG1PI5YUNLk694/6nHTKTNC1FDbUxarMfSnlc1DVxksk5/Edb0H+Pq3GZNQutZIOn2erbk0JM4Gi+p4s0nGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWQNAkI9pUaixGyz1aL8v5JZUQOsf25Ubo4vwdqfSjs=;
 b=QARkIsldKa92Rl9HMgdt0MvuYOZ88+AGZkzNMofAmykrDUBRPcGd2OxqJnAxbS4fpuH80I+UGDRsNETbAlma8ymFCSuwORfNG9vyRkYqDCJHAODN/eAIpHTVWcLdb/DchTamOLD+ysAG0XeqYkuwYR5bgfBeeABZRxAZafHTGCo=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7322.apcprd03.prod.outlook.com (2603:1096:990:18::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Wed, 27 Nov
 2024 09:04:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8182.018; Wed, 27 Nov 2024
 09:04:39 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "kernel@collabora.com"
	<kernel@collabora.com>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "mripard@kernel.org" <mripard@kernel.org>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 6/6] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Topic: [PATCH v1 6/6] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Index: AQHbO0o2kTOzG2fD30avrRutQMN1rbLC6GCAgAVWuwCAAKrhAIAAaa0AgAFqXYCAABvBgIAABmoA
Date: Wed, 27 Nov 2024 09:04:38 +0000
Message-ID: <c46751894d01194d89da6c164b47a59cd1e86bb6.camel@mediatek.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
	 <20241120124420.133914-7-angelogioacchino.delregno@collabora.com>
	 <1b966a136f02b5586749a9c3d0bcec6c75224e49.camel@mediatek.com>
	 <33acccd3-e543-493e-a61c-282d894ef2b1@collabora.com>
	 <fd48c582e99d6c07be4b66919fb6c309379ad752.camel@mediatek.com>
	 <f1d16db0-a7e1-4cfd-85c6-8beef4385701@collabora.com>
	 <a8ca9d1314f12dbb95ac4e4b9e8929adab35eaba.camel@mediatek.com>
	 <8e70d921-1420-4a57-a994-dc28abda25b7@collabora.com>
In-Reply-To: <8e70d921-1420-4a57-a994-dc28abda25b7@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7322:EE_
x-ms-office365-filtering-correlation-id: 382b0436-c0ab-4f2b-8231-08dd0ec285e7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T212V1BsZm1vK3FxV2MzelB4U3dyRXcxYUM2YnRCbzlkOUlmMGlWWnNQdGpx?=
 =?utf-8?B?eG8rZmtWSW1hRzF2b29VWStvZ0E1YTVvbVNJelY1cnZ6cmlVaC9RYmV5cjNY?=
 =?utf-8?B?MXg0bitiOXZ2UmxaaVhnK2owaFNVOGxYZjJkU3EyUUI1bmFaZ1VndGVhMlpn?=
 =?utf-8?B?MG1pVkJva3h0N1B6ZytIT1RPbzdnUGZEQ1pnc3FGOTdkVTVGelF6M0FMSnpG?=
 =?utf-8?B?dGlNVzVQM2RTMGxkd0RmVHdobVNEUE9PdDBjZkFjY0dPRlBoUHNjNnhsU2Rj?=
 =?utf-8?B?UTRjazVVMklwaWQrb2lFVnM4YUJTU2RZL3NsUVZ0UFNPRTBPa3VPSVhIUVRa?=
 =?utf-8?B?Wk9hWVBHZ3hSTnRFNDBLNnlybTVXN3dUMG44VXpWT1MzOUNFbmZQdU1sTml1?=
 =?utf-8?B?bDRqUkU2b1NJM1V1LzEvbDk1Q01ITEVQK280ZFB5S0crMlBVSFNhZ0xUMUhq?=
 =?utf-8?B?TnJucVZzckoxdHFyN3pWVkxmUWptMkFyMFZLVmdQUW43ZzRSblVWL2hOZjhL?=
 =?utf-8?B?d1BWczFRcDFHZzJVVEMzNlduK2RvSG1TY3JzdDJyMUI3T2RTNDdSY0FjSkFR?=
 =?utf-8?B?Vk1yZzJWVW9zZzVDa1pPaS84a0pMeWM4Q21FUEN6eE9RTTk3czlmbGh0UnFP?=
 =?utf-8?B?S2JZQnFNTTZZSHpXRlJMc2FVWDVUYlNMYnVwbDFLTXNTektUZFcrTjlJWFgx?=
 =?utf-8?B?ei93NWxvUzZQSkRoNkNnb0RkV21lNFZDVTdKdGtuZ0RweXA2QkJKVlMzRWRG?=
 =?utf-8?B?NTUrdkw4NEJObHk3a2NCaWp1QTNXY0pPZzRFc1RuQ1pEV2dkWTJ0UlF3RGJN?=
 =?utf-8?B?Y05RelRwbkJwaitSNWhXT1h6ZWE2dWc4QkFsL1lkWkp3NEVSbjJrbTBTZFg2?=
 =?utf-8?B?MlZtK2lmSmJhL3lramgwb0VJM2ZvaEtDYlRFTDNseUZhaTA1QTlJT0FPNEYr?=
 =?utf-8?B?S2lYYlVNZnluQ2FQdU45MUFoYmpHaWcvV3Fva1lGTXlrbm41elpqY1hTdHBl?=
 =?utf-8?B?VFY5TzI5RXlyMGFaYXZKMCtydSs2dmFWNC9VSGUybWJPL2x0Q2ZwSGNweklM?=
 =?utf-8?B?M3NMd0J2UHd1TjdjQ2hETmJPQjZLa2xjTHJaQ2RkbE93Z2RVR1MwSWlnMVVr?=
 =?utf-8?B?ejdLcGtCaWxaYjFsaE1SSmRNb0pic1FFdWYrRVZhYS85UU5ydjFlN1BEdjZ3?=
 =?utf-8?B?Q2JaQVg0dTFDRWF4Q3FzWmU0S0ZzaTV4Y1NQbCtrSmdteFZwZit2SFdrdzBX?=
 =?utf-8?B?dTFiaFNNT09aeDVnbGtxL2QxY0VJL1ZXamZSZEgxTDhBVFI4a0ZVSmVlT0dz?=
 =?utf-8?B?Y2xtWXFXdG9NenBjVCtscDZXd3F4THh3OXdqekg0VEc5YlhmcVdDRFdxcjlX?=
 =?utf-8?B?WCswdDNJRGRUMWtIa0cxdTFPTFVEZzVraWhzWjZSeFZOQlRIUktSbXJNbTdN?=
 =?utf-8?B?SzJxWlNKMmI1aS96NTMwM1M2UVc4RXo0V2RHc2tTWS9CWVh4WUxFSGg5d3c1?=
 =?utf-8?B?cnNGb0lDK0JaQWpiYjF0WEpPK2V4RDBTK1RtMEMvRDgyWFI0TmJObTZIbWNF?=
 =?utf-8?B?bHVnWEgrdnh6a3lZNVR2M3FpbUNNMkdUdFUrRmdzcVBsc2ZsTndzSnhqREps?=
 =?utf-8?B?Z0VndThYK1RZdkJOTWtLZTIxSHROZUw0d0N3RW9oRDNudVg0VW02eDFoZUth?=
 =?utf-8?B?NHFDb3czbFMvdDNIZmlST2pJbEpHYnBTa29zWXI4Q2hMQUpXSUVGdnlFaDFX?=
 =?utf-8?B?YlVNanU5UWhaSEg5Rzdsc09sV1RqS0lRWlRjVzJtek5RcjR5NjJyMEhaZlkv?=
 =?utf-8?B?d1haNng4T2lFcG9IKzRyZE5QN1ljbVFaWEk0Sm1BalpVY2tJNVFxbThGRExl?=
 =?utf-8?B?cWNUVVp1dmV2UXE3MTdLQ0VjNWhxR09lSkcvMklkcW85R1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXpaQ3JxVDg3NW14anRaMG04aXI5V3QrVVNuQVYyVnFYejZuZnlQaWIvTHh3?=
 =?utf-8?B?ZUcvZ2EwQmltRW9PcEZsU3hsQlV0eS92cW5DNXdVTjVzUEVrVmZIcDJZNTZh?=
 =?utf-8?B?NWcwVlluOXNWY0FPb1A4aXl6Z3FYOWg4VXUzVDViNElLSTM3OWlyVjFWbmpk?=
 =?utf-8?B?SDRPcCtmVnM5Skh4TUk1RVBMdlFSWW1jc3lXeGtacXRLU3ZTK2kxTnNpQktZ?=
 =?utf-8?B?R1pSYXhHZCtaZnhRMnZPRWJteDVFQ0FjMHh1Q0hTS1c4enJvL01ueENvVXRH?=
 =?utf-8?B?dGF3SzFvYXFrbmphNFV6Z2NBM21lMU5MRTRiN3d4c0VORWN4ZUdLWkVuM3Nl?=
 =?utf-8?B?dzl4b2ZOS1V2L0pLYnNEUlBjUk1LZEI3OFdXRWY4ZUhXM1I3R2ovMmdWeFBI?=
 =?utf-8?B?LzhoWUJDelRHdVcrcm9kdTFKOGhpZFpaWHQzV1h4VzhsM1lrbUxLQlJXVktm?=
 =?utf-8?B?TU9VdkgzUGlkN3UwYUpBNkJobmF4S1hDL2ZzVWRTQ3V3Yk5pY3JxSk5rdnZ0?=
 =?utf-8?B?R2t5MjdJRm02cXV1M2tsN2YvRzAzZkMzdEVOZ2tncWlndzQyZU5Oc00xNXU5?=
 =?utf-8?B?NmV4NkFxZDAwS0xxK0gxUkxGaFkxSDFqUSt1UTNHQmpseG1oOXhiN3RRNGRv?=
 =?utf-8?B?T3Q5bU9EcnlBcnRPS3VMdFdXc1Y5QzNGcGFNMGhmTTJ3VEF4QWNmU2pHY0h5?=
 =?utf-8?B?bi8wT3lQeWgrWGllYkZwRUJhSG83M2Y1K3hyT0NpeEZYL0RLNzF6MHhVRUth?=
 =?utf-8?B?QkNzcW1Qam9mMEdmS2JORGpRcjBXR0ZMQW5UZUdMRGpvOHlyT2Y3ek5CNlZ3?=
 =?utf-8?B?SWcyaXp1SUJEbllXOS9KYjBpYzRhWS9QTzdtTXVoM21MRXViQXYxOW83dGpS?=
 =?utf-8?B?RWltMWlTNUNYVkhHdlZ4ZzVyVXVwVjAveG5xMTNXdkd1ZGY3cXgvTTVZZDNU?=
 =?utf-8?B?aFo4eDk0L2wxRWRha20zSmxGdlJYblpYRDRlTVpnSGJsbjI3RVJRTE9FZ2E3?=
 =?utf-8?B?azRRQUI3L25xRFA4VmRPVXI0d1RVeDFZTG8zT2h3cnlSclIwdlhXankwcVVP?=
 =?utf-8?B?K1VySFJtNXN0dzV3NlJqTmEvaXdqU1hQc1BuWFZkTnZ0NjRHNy96akMyQVhx?=
 =?utf-8?B?eU9jOEpuVnBrR2srWjhXVmNOd0NaNGt3WmRRN3JmbnFFZE5SNWhEQWh0blZw?=
 =?utf-8?B?SDg4ZHR2cG9wamhhMHU4RjVaYk5vaE1sMnZnR0JVcjRCQUhpSy83d0xFaHUx?=
 =?utf-8?B?UXZyRHZ5V2ZSYjFLKzhMSGZqQlo3Tkd0Z295bWNaZXNkd04zbVJJK0JMR3Zv?=
 =?utf-8?B?cjl1SVMzblVwZkFENllCb1JHbUZJaFF5bU9HVUhHMXphRDJXdjcrTGFqM1lW?=
 =?utf-8?B?QzA1bktNS0xHM0E3SjRPNU4yWXA2d2N2Szcxb3JsalJBb2o3bXk0STFiQnpW?=
 =?utf-8?B?d0xGZGQ0TWJTYitXRVhTa3pxVFlqOGxWVXhVSWdPeW16ZWdRNXU4QTdmWUcw?=
 =?utf-8?B?bi8xNDh5UTB0YXNGZmNDQm1HRmM3WXd0Nm1hRHdYSzB1ZFZjREJIK28yb3h5?=
 =?utf-8?B?YUJsVE9NSDRkbDZOeXpsc1lhTitkTGZLSDdBVEUraHRZNU5kYU90dTBQYTFX?=
 =?utf-8?B?NlFoNzhvNlJRZlQyajFsVHJXNmhyTCswU1p0eXkzc0dDZXVJc3hEalpSZXpP?=
 =?utf-8?B?ZnZ0SXpHR0xyc1RrMU1ScXJ3cDhITkRub1FXQnRNMEhRbDNOOHhlWHNuTlNV?=
 =?utf-8?B?b0QwTjUrTXB4dEV4dDRjSm8xc0lONlZQbnRmZmJ2RmVzQVkvVDBJb1RiMlhs?=
 =?utf-8?B?WnNQc0ZLMlhKY0JrRWNmczNBZUNYZlBnRkhLQjl2bXJuempOWEVDbWMzamU1?=
 =?utf-8?B?WkhqZVEzbE5ZWVpDOXZPb1p1aFB2M3RIZmFXSGpjbGd6NGRaaXpzeUFwV3I3?=
 =?utf-8?B?YUM0NzFzOW02QWh3aU16bVRvTGo3eVNKS3ZHakx1dzJId1NDZzZpNGpqWGlF?=
 =?utf-8?B?bDVNa1dYWFVSL081N29VSDNhQ21MZ0xtWWU5dFZuZllvNVBEUUJoZDk4WHcx?=
 =?utf-8?B?b1JEVjk2YjRuSWs0OFRuMVpQdTdHZFlDRFZBK2laS3E5V1ZjYktOb3hIeXI4?=
 =?utf-8?Q?i6rxJ1yzdIPZ7BTLIEmPttZA8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71BEE1B87BEDF54288A355D657B85C66@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382b0436-c0ab-4f2b-8231-08dd0ec285e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 09:04:38.9271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iXhY/luT/d/NBXMP5xoiOJsQVcSSroPKaQ4w3vULyQAUP4YK1GJ6sRnmPs46gI77//L4OBa5mXfdZqQ/A6iYlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7322
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.764500-8.000000
X-TMASE-MatchedRID: x2HXvaraFokNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCopoEWlZvizRmlaAItiONP35bNUY+JJjyFwpnAAvAwazxxE
	lGvP0lfjcjxfCJ/GHhhgY0ztehnm8D7+f/jfUYxK4jAucHcCqnRZO94uK1VSBKQU/vx3G/tFYLm
	JBTCeWS9/nCRCiwBYcO2RzUwv/GzdJ+HTEll5bHf28T9BUNXkhkos2tunL8DQs7eP5cPCWQ/4ZA
	Usty2ENDdtqlAQ6fUZoBua9UxitOnsRVu35DItMF6z9HGHKwNuSeMExjuIoEjg89vVcMJkhZfpd
	LFb2h+N9ix0TOFVSi7zzS1wmGiDmbqSoMCXyNc9H+PTjR9EWkm2siTY6Sb7GT7S4ZU4XTxD23ei
	pp00x0Q/EORUPdwthbINZznOfBoZL5MYokMFn1MHtxyc5sQTFmyqQJWNsukmtj24Xqh0yXBYk3a
	LMVxcqm796qhSRMEj7HDlJh6q7gmTyYonm6tRP7TLIvnWov9H64i5lgawyBFc/Cedjlcvkt/UjW
	tGA+cFRHAmS2Xmh5wI0mW3vzqeQ5UcZtwNsCrrSBVVc2BozSlkMvWAuahr8+gD2vYtOFhgqtq5d
	3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.764500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	49F052E58280AF82FE6755CDBED5B862375A6DC69ECCEBAE8EB6361A1DEB14A72000:8

T24gV2VkLCAyMDI0LTExLTI3IGF0IDA5OjQxICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyNy8xMS8yNCAwODowMiwgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBPbiBUdWUsIDIwMjQtMTEtMjYgYXQgMTA6MjUgKzAxMDAs
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBJbCAyNi8xMS8yNCAwNDowNywgQ0sgSHUgKOiDoeS/iuWFiSkgaGEgc2NyaXR0bzoN
Cj4gPiA+ID4gT24gTW9uLCAyMDI0LTExLTI1IGF0IDE3OjU1ICswMTAwLCBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyB3cm90ZToNCj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IElsIDIyLzExLzI0IDA4OjIzLCBDSyBIdSAo6IOh5L+K5YWJKSBoYSBzY3JpdHRv
Og0KPiA+ID4gPiA+ID4gSGksIEFuZ2VsbzoNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24g
V2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNs
aWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhl
IHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gPiBBZGQgc3VwcG9ydCBmb3IgdGhlIERQSSBibG9jayBmb3VuZCBpbiB0aGUg
TVQ4MTk1IGFuZCBNVDgxODggU29Dcy4NCj4gPiA+ID4gPiA+ID4gSW5zaWRlIG9mIHRoZSBTb0Ms
IHRoaXMgYmxvY2sgaXMgZGlyZWN0bHkgY29ubmVjdGVkIHRvIHRoZSBIRE1JIElQLg0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBJbiBNVDgxNzMsIERQSTAgaXMgZGlyZWN0bHkgY29ubmVjdGVk
IHRvIEhETUkuDQo+ID4gPiA+ID4gPiBUaGUgZmlyc3QgdmVyc2lvbiBvZiB0aGlzIGRyaXZlciBp
cyBqdXN0IGZvciBNVDgxNzMgRFBJMC4NCj4gPiA+ID4gPiA+IERvZXMgTVQ4MTczIERQSTAgbmVl
ZCB0aGlzIG1vZGlmaWNhdGlvbj8NCj4gPiA+ID4gPiA+IE9yIHRoaXMgbW9kaWZpY2F0aW9uIGlz
IGp1c3QgZm9yIE1UODE4OCBhbmQgTVQ4MTk1LCB0aGVuIHRoZSBkZXNjcmlwdGlvbiBzaG91bGQg
YmUgbW9yZSB0aGFuICdkaXJlY3RseSBjb25uZWN0ZWQnLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gVGhpcyBpcyBvbmx5IGZvciBNVDgxODggYW5kIE1UODE5NSwgYW5kIE1U
ODE3MyBkb2VzICpub3QqIG5lZWQgYW55IG1vZGlmaWNhdGlvbi4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBQbGVhc2UsIHdoYXQgd291bGQgeW91IGxpa2UgdG8gc2VlIGluIHRoZSBkZXNjcmlwdGlv
biBvZiB0aGlzIGNvbW1pdD8NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcGF0Y2ggZG9lcyBmb3Vy
IGpvYnMuDQo+ID4gPiA+IA0KPiA+ID4gPiAxLiBFbmFibGUvZGlzYWJsZSB0dmRfY2xrIGZvciBN
VDgxOTUvTVQ4MTg4IERQSS4NCj4gPiA+ID4gMi4gRG8gbm90IHNldCBwaXhlbCBjbG9jayBmb3Ig
TVQ4MTk1L01UODE4OCBEUEkuDQo+ID4gPiA+IDMuIE5ldyBEUElfSU5QVVRfWFhYIGFuZCBEUElf
T1VUUFVUX1hYWCBjb250cm9sIGZvciBNVDgxOTUvTVQ4MTg4IERQSS4NCj4gPiA+ID4gNC4gRG8g
bm90IHBvd2VyIG9uL29mZiBmb3IgTVQ4MTk1L01UODE4OCBEUEkuDQo+ID4gPiA+IA0KPiA+ID4g
PiBNYXliZSB5b3Ugc2hvdWxkIGJyZWFrIGludG8gNCBwYXRjaGVzIGFuZCBlYWNoIG9uZSBoYXMg
ZGlmZmVyZW50IHJlYXNvbi4NCj4gPiA+IA0KPiA+ID4gWWVhaCBJIHRob3VnaHQgYWJvdXQgdGhh
dCBhcyB3ZWxsLCBidXQgdGhlcmUncyBhIGZ1bmRhbWVudGFsIGlzc3VlIHdpdGggc3BsaXR0aW5n
DQo+ID4gPiB0aGUgdGhpbmcgaW4gbXVsdGlwbGUgcGF0Y2hlcy4uLg0KPiA+ID4gDQo+ID4gPiBG
b3IgZW5hYmxpbmcgdGhlIHR2ZF9jbGsgaW4gYSBzZXBhcmF0ZSBwYXRjaCwgdGhlcmUncyBubyBw
cm9ibGVtIC0gaG93ZXZlciwgZm9yIHRoZQ0KPiA+ID4gb3RoZXJzLi4uLg0KPiA+ID4gDQo+ID4g
PiAxLiBXZSBuZWVkIHRvIGludHJvZHVjZSBzdXBwb3J0IGZvciBNVDgxOTUvODggRFBJLUhETUks
IG9yIHRoZSBvdGhlciBwYXRjaGVzIHdvdWxkDQo+ID4gPiAgICAgIG5vdCBtYWtlIHNlbnNlIChu
b3IgYXBwbHksIGFueXdheSk7IHRoZW4NCj4gPiA+IDIuIFdlIHN0b3Agc2V0dGluZyBwaXhlbCBj
bG9jayB3aXRoIGFub3RoZXIgcGF0Y2g7IHRoZW4NCj4gPiA+IDMuIHdlIGRvbid0IHBvd2VyIG9u
L29mZiwgZXRjIGV0Yw0KPiA+ID4gDQo+ID4gPiBUaGUgcHJvYmxlbSB3aXRoIGRvaW5nIGl0IGxp
a2Ugc28gaXMgdGhhdCB0aGUgcGF0Y2ggIzEgdGhhdCBJIGRlc2NyaWJlZCB3b3VsZCBiZQ0KPiA+
ID4gaW50cm9kdWNpbmcgKmZhdWx0eSBjb2RlKiwgYmVjYXVzZSB0aGUgc3VwcG9ydCBmb3IgdGhh
dCByZWFsbHkgZGVwZW5kcyBvbiBhbGwgb2YNCj4gPiA+IHRoZSBvdGhlcnMgYmVpbmcgcHJlc2Vu
dCAob3RoZXJ3aXNlIHRoZSBibG9jayB3b24ndCB3b3JrIGNvcnJlY3RseSkuDQo+ID4gPiANCj4g
PiA+IFNvLi4uIGlmIHlvdSB3YW50LCBJIGNhbiBlYXNpbHkgc3BsaXQgb3V0IHRoZSB0dmRfY2xr
IGVuYWJsZS9kaXNhYmxlLCBidXQgc3BsaXR0aW5nDQo+ID4gPiB0aGUgcmVzdCB3b3VsZG4ndCBi
ZSBjbGVhbi4NCj4gPiA+IA0KPiA+ID4gQmVzaWRlcywga2VlcCBpbiBtaW5kIHRoYXQuLi4gYWN0
dWFsbHkuLi4gZm9yIGFueXRoaW5nIGVsc2UgdGhhdCBpcyBub3QgTVQ4MTk1Lzg4DQo+ID4gPiBE
UEkwIChzbywgZm9yIG90aGVyIFNvQ3MnIERQSSBhbmQgZm9yIDk1Lzg4IERQSU5URikgdGhlIHR2
ZF9jbGsgaXMgYWxyZWFkeSBnZXR0aW5nDQo+ID4gPiBlbmFibGVkIGJ5IGl0cyBjaGlsZC4uIHNv
LCBmb3IgdGhvc2Ugb25lcywgYSBjYWxsIHRvIGVuYWJsZSB0dmRfY2xrIGRvZXMgZXhhY3RseQ0K
PiA+ID4gbm90aGluZyBhcGFydCBmcm9tIGluY3JlbWVudGluZyAoZW5hYmxlKSBvciBkZWNyZW1l
bnRpbmcgKGRpc2FibGUpIHRoZSByZWZjb3VudCBmb3INCj4gPiA+IHRoaXMgY2xvY2sgYnkgMS4N
Cj4gPiA+IA0KPiA+ID4gVGhpcyBtZWFucyB0aGF0IHRoZSBlbmFibGVtZW50L2Rpc2FibGVtZW50
IG9mIHR2ZF9jbGsgaXMgYWN0dWFsbHkgaW1wb3J0YW50IG9ubHkNCj4gPiA+IGZvciB0aGUgTVQ4
MTk1Lzg4IERQSSBhbmQgaGFzIGxpdGVyYWxseSBubyBlZmZlY3Qgb24gYW55dGhpbmcgZWxzZSB0
aGF0IGlzDQo+ID4gPiBjdXJyZW50bHkgc3VwcG9ydGVkIGJ5IHRoZSBtdGtfZHBpIGRyaXZlciBh
bnl3YXkuDQo+ID4gPiANCj4gPiA+IFN0aWxsIC0gaWYgeW91IHdhbnQgbWUgdG8gc3BsaXQgb3V0
IHRoZSB0dmRfY2xrIGVuL2RpcyBwYXRjaCwganVzdCBjb25maXJtIGFuZCBJDQo+ID4gPiB3aWxs
IHNwbGl0IHRoYXQgb25lIG91dC4uLg0KPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBGb3IgIzEg
YW5kICMyLCBJJ3ZlIG5vdCByZXZpZXdlZCB0aGUgSERNSSBkcml2ZXIuIElzIHRoZSBjbG9jayBj
b250cm9sIGluZmx1ZW5jZWQgYnkgbmV3IEhETUkgZHJpdmVyLg0KPiA+ID4gDQo+ID4gPiBJdCBr
aW5kYSBpcyAtIHRoZSBIRE1JLVRYIGJsb2NrIGdldHMgaXRzIGNsb2NrIGZyb20gdGhlIEhETUkg
UEhZJ3MgY2xvY2sgZ2VuLA0KPiA+ID4gYnV0IGV2ZW50dWFsbHkgaXQgaXMgdGhlIEhETUkgZHJp
dmVyIHRoYXQgdGVsbHMgdG8gdGhlIFBIWSBkcml2ZXIgd2hhdCBjbG9jayBpdA0KPiA+ID4gYWN0
dWFsbHkgd2FudHMuDQo+ID4gPiANCj4gPiA+IEZvciAjMSwgY2xrX3ByZXBhcmVfZW5hYmxlKCkg
aXMgdW5nYXRpbmcgdGhlIGNsb2NrIHRoYXQgd291bGQgb3RoZXJ3aXNlIGdhdGUgdGhlDQo+ID4g
PiBQSFkncyBQTEwgb3V0cHV0IHRvIHRoZSBIRE1JIGJsb2NrLg0KPiA+ID4gDQo+ID4gPiA+IElm
IGl0IGlzIHNvZnR3YXJlIHJlYXNvbiwgbWF5YmUgd2UgY2FuIG1vZGlmeSB0aGUgbmV3IEhETUkg
ZHJpdmVyIGFuZCBtYWtlIERQSSBkcml2ZXIgY29uc2lzdGVudCB3aXRoIE1UODE3My4NCj4gPiA+
ID4gSWYgaXQgaXMgaGFyZHdhcmUgcmVhc29uLiBqdXN0IGRlc2NyaWJlIHRoZSBoYXJkd2FyZSBy
ZWFzb24uDQo+ID4gPiANCj4gPiA+IEFscmlnaHQgLSB0aGUgaGFyZHdhcmUgcmVhc29uIGlzIHRo
YXQgdGhlIEhETUlQSFkgZ2VuZXJhdGVzIHRoZSBjbG9jayBmb3IgdGhlIEhETUkNCj4gPiA+IFRY
IGJsb2NrLCBhbmQgdGhhdCBlbmFibGluZyB0aGUgY2xvY2sgYXNzaWduZWQgdG8gdHZkX2NsayBp
cyBuZWNlc3NhcnkgdG8gdW5nYXRlDQo+ID4gPiB0aGUgUEhZJ3MgY2tnZW4gb3V0cHV0IHRvIHRo
ZSBIRE1JLVRYIChhbmQgSSB0aGluayAtIGJ1dCBub3Qgc3VyZSBhcyBJIGhhdmVuJ3QNCj4gPiA+
IGFuYWx5emVkIHRoYXQgeWV0IC0gdGhhdCBIRE1JLVJYIHNob3VsZCBoYXZlIHRoZSBzYW1lIGdh
dGluZyB0ZWNobmlxdWUsIGJ1dCB0aGF0J3MNCj4gPiA+IGRlZmluaXRlbHkgb3V0IG9mIHNjb3Bl
IGZvciB0aGlzIHN1Ym1pc3Npb24pLg0KPiA+IA0KPiA+IEkgdGhpbmsgdHZkX2NsayBpcyB0aGUg
Y2xvY2sgc291cmNlIG9mIERQSSwgSERNSSwgYW5kIEhETUktUEhZLCBzbyB0aGVzZSBoYXJkd2Fy
ZSBjb3VsZCB3b3JrIGluIHRoZSBzYW1lIGZyZXF1ZW5jeS4NCj4gPiBUaGF0IG1lYW5zIGRyaXZl
cnMgb2YgRFBJLCBIRE1JLCBhbmQgSERNSS1QSFkgYXJlIGVxdWFsIHRvIGNvbnRyb2wgdHZkX2Ns
ay4NCj4gPiBJbiBNVDgxNzMuIHNvZnR3YXJlIGNob29zZSBEUEkgZHJpdmVyIHRvIGNvbnRyb2wg
dHZkX2Nsay4NCj4gPiBJbiBNVDgxOTUsIHNvZnR3YXJlIGNob29zZSBIRE1JLVBIWSBkcml2ZXIg
dG8gY29udHJvbCB0dmRfY2xrLg0KPiANCj4gWWVzLCBidXQgaW4gTVQ4MTk1IHRoZSB0dmQgaXMg
Z2F0ZWQgYnkgYSBjbG9jayB0aGF0IGlzIGNvbnRyb2xsZXIgYnkgdGhlIEhETUkNCj4gZHJpdmVy
IG9ubHksIGFuZCBub3QgYnkgdGhlIFBIWSAtIHNvLCBQSFkgc2V0cyB0aGUgZnJlcXVlbmN5LCBt
dGtfaGRtaV92MiB1bmdhdGVzDQo+IHRoYXQgdG8gdGhlIEhETUlUWCBibG9jayAod2l0aCBjbGtf
cHJlcGFyZV9lbmFibGUodHZkX2NsaykpLg0KPiANCj4gPiANCj4gPiBJIHdvdWxkIGxpa2UgdG8g
aGF2ZSB0aGUgc2FtZSBjb250cm9sIGZsb3cuDQo+ID4gSWYgIkhETUktUEhZIGRyaXZlciB0byBj
b250cm9sIHR2ZF9jbGsiIGlzIGJldHRlciwgd2UgY291bGQgdGVtcG9yYXJpbHkgbGV0IE1UODE5
NSBoYXMgZGlmZmVyZW50IGZsb3cgd2l0aCBNVDgxNzMuDQo+ID4gU28sIGlzICJIRE1JLVBIWSBk
cml2ZXIgdG8gY29udHJvbCB0dmRfY2xrIiBiZXR0ZXI/DQo+ID4gDQo+IA0KPiBJJ20gbm90IHN1
cmUgSSB1bmRlcnN0YW5kIHRoaXMgbGFzdCBwYXJ0LCBjYW4geW91IHBsZWFzZSByZXBocmFzZT8N
Cg0KSSB3b3VsZCBsaWtlIE1UODE3MyBhbmQgTVQ4MTk1IGhhcyB0aGUgc2FtZSBjb250cm9sIGZs
b3csIHNvIGtlZXAgRFBJIGRyaXZlciB0byBjb250cm9sIHR2ZF9jbGsgaW4gTVQ4MTk1Lg0KSWYg
aXQncyBiZXR0ZXIgdG8gY29udHJvbCB0dmRfY2xrIGJ5IEhETUktUEhZIGRyaXZlciwgYm90aCBN
VDgxNzMgYW5kIE1UODE5NSBjb250cm9sIHR2ZF9jbGsgYnkgSERNSS1QSFkgZHJpdmVyLg0KQnV0
IHdlIGFyZSBub3QgYWJsZSB0byB0ZXN0IE1UODE3My4gU28gTVQ4MTczIGtlZXAgY29udHJvbCB0
dmRfY2xrIGJ5IERQSSBkcml2ZXIuDQpTbyBjb250cm9sIHR2ZF9jbGsgYnkgSERNSS1QSFkgZHJp
dmVyIGlzIGJldHRlcj8NCg0KPiANCj4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gRm9yICM0LCBJ
IGRvbid0IGtub3cgd2h5IERQSSBkbyBub3QgY29udHJvbCBwb3dlciBieSBpdHMgc2VsZj8NCj4g
PiA+ID4gRXZlbiB0aG91Z2ggb3RoZXIgZHJpdmVyIG1heSBjb250cm9sIHRoZSBzYW1lIHBvd2Vy
LCBwb3dlciBtYW5hZ2VyIGhhcyByZWZlcmVuY2UgY291bnQsDQo+ID4gPiA+IHNvIGVhY2ggZHJp
dmVyIGNvdWxkIGNvbnRyb2wgdGhlIHNhbWUgcG93ZXIgYnkgaXRzIHNlbGYuDQo+ID4gPiANCj4g
PiA+ICM0IGlzIHRoZXJlIGJvdGggZm9yIGEgU1cgYW5kIGZvciBhIEhXIHJlYXNvbi4NCj4gPiA+
IA0KPiA+ID4gVGhlIEhXIHJlYXNvbiBpcyB0aGF0IHRoZSBEUEkgc2hhbGwgYmUgcG93ZXJlZCBv
biBpbiBhIHNwZWNpZmljIHNlcXVlbmNlIGluIHJlZ2FyZA0KPiA+ID4gdG8gSERNSS1UWCwgZHVl
IHRvIHRoZSBzZXR1cCB0aGF0IGlzIHJlcXVpcmVkIGJ5IGJvdGggKGFuZCB1bmdhdGluZyBjbG9j
a3MgYmVmb3JlDQo+ID4gPiBmdWxsIGNvbmZpZ3VyYXRpb24gaGFwcGVucyB3b3VsZCBsb2NrIHVw
IHRoZSBodyBibG9jaykuDQo+ID4gPiANCj4gPiA+IFRoZSBTVyByZWFzb24gaXMgdGhhdCBtdGtf
Y3J0Yy5jIGNhbGxzIG10a19jcnRjX2RkcF9od19pbml0KCktPm10a19kZHBfY29tcF9zdGFydCgp
DQo+ID4gPiBpbiBpdHMgLmF0b21pY19lbmFibGUoKSBjYWxsYmFjaywgd2hpY2ggaGFwcGVucyBp
biB0aGUgd3Jvbmcgc2VxdWVuY2UgaW4gcmVnYXJkIHRvDQo+ID4gPiBIRE1JIGJlY2F1c2Ugb2Yg
dGhlICJuYXR1cmFsIiBjb21wb25lbnRzIG9yZGVyIGluIHRoZSBEUk0gZnJhbWV3b3JrIChmb3Ig
TVQ4MTk1Lzg4IQ0KPiA+ID4gYmVjYXVzZSBmb3IgdGhlIG90aGVycyBpdCBlaXRoZXIgaXMgdGhl
IGludmVyc2Ugb3IgaXQgZG9lcyBub3QgbWF0dGVyIC0gc28gZm9yDQo+ID4gPiBwZXJmb3JtYW5j
ZSBpdCdzIG9rYXkgZm9yIGl0IHRvIGJlIGxpa2UgdGhhdCBib3RoIG9uIG9sZGVyIFNvQ3MgYW5k
IG9uIERQSU5URiBmb3INCj4gPiA+IDk1Lzg4KSBhbmQgdGhpcyBtZWFucyB0aGF0IHdlICptdXN0
IG5vdCogY2FsbCBkcGlfcG93ZXJfb24oKSBhdCB0aGF0IHRpbWUgYnV0DQo+ID4gPiB3ZSBtdXN0
IHJhdGhlciBmb2xsb3cgdGhlIGF0b21pY19lbmFibGUoKS9icmlkZ2VfZW5hYmxlKCkgb3JkZXIg
aW1wb3NlZCBieSBEUk0NCj4gPiA+ICphbHNvKiBmb3IgdGhlIGNsb2NrIGVuL2RpcyBjYWxscyBp
biBEUEkuDQo+ID4gDQo+ID4gSXQgbG9va3MgbGlrZSB0aGUgIzQgY291bGQgYmUgYSBzZXBhcmF0
ZSBwYXRjaC4NCj4gPiBUaGUgY29tbWl0IG1lc3NhZ2UgaXMgd2hhdCB5b3UgZGVzY3JpYmUgaGVy
ZS4NCj4gPiBBbmQNCj4gPiANCj4gPiBpZiAoIWRwaS0+Y29uZi0+c3VwcG9ydF9oZG1pX3Bvd2Vy
X3NlcXVlbmNlKQ0KPiA+ICAgICAgIG10a19kcGlfcG93ZXJfb24oKTsNCj4gPiANCj4gDQo+IFRo
aXMgbWVhbnMgdGhhdCBJJ2QgaGF2ZSB0byBpbnRyb2R1Y2UgdGhlICJoZG1pIHBvd2VyIHNlcXVl
bmNlIiBiZWZvcmUgYWN0dWFsbHkNCj4gaW50cm9kdWNpbmcgdGhlIHJlYWwgc3VwcG9ydCBmb3Ig
TVQ4MTk1IEhETUkuLi4uDQo+IEkgaG9uZXN0bHkgZG9uJ3QgbGlrZSB0aGF0ICJ0b28gbXVjaCIs
IGJ1dCBpdCdzIGZpbmUsIEkgZG9uJ3QgaGF2ZSAqdG9vIHN0cm9uZyoNCj4gb3BpbmlvbnMgYWJv
dXQgdGhhdCwgc28gSSB3aWxsIHNlcGFyYXRlICM0IGFzIHlvdSBzdWdnZXN0ZWQgZm9yIHYyLg0K
DQpUaGlzIERQSSBzZXJpZXMgbW9kaWZpY2F0aW9uIGlzIGFsbCBhYm91dCBIRE1JLg0KTWF5YmUg
bWVyZ2UgdGhpcyBzZXJpZXMgd2l0aCBIRE1JIHNlcmllcyBhbmQgbGV0IHRoZSBIRE1JIHBhcnQg
aW4gZnJvbnQgb2YgRFBJIHBhcnQgYW5kIGl0J3MgbW9yZSByZWFzb25hYmxlLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiANCj4gQ2hlZXJzLA0KPiBBbmdlbG8NCj4gDQo+ID4gUmVnYXJkcywNCj4gPiBD
Sw0KPiA+IA0KPiA+ID4gDQo+ID4gPiBDaGVlcnMsDQo+ID4gPiBBbmdlbG8NCj4gPiA+IA0KPiA+
ID4gPiANCj4gPiA+ID4gUmVnYXJkcywNCj4gPiA+ID4gQ0sNCj4gPiA+ID4gDQo+ID4gPiA+IA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IENoZWVycywNCj4gPiA+ID4gPiBBbmdlbG8NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+ID4gPiBDSw0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiANCj4gDQo+IA0KPiANCg==

