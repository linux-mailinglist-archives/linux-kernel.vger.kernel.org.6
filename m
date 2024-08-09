Return-Path: <linux-kernel+bounces-280546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA594CC02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC17281280
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C74C16D4D4;
	Fri,  9 Aug 2024 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FS1WO2dK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZJ+TGrj0"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F057234CC4
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191359; cv=fail; b=qRuaY3u90gXlo2K1DnhRXbuXdlxYxf445SnUb8SXdFtTwyIEYwQRnn0CXOPTSUDMzNsyVl+1Lvy3K3Ljllzc2TDIVdPHIy4fcAU8UcMcuuijwxeYT8fZUPJnedUIKcoir2Ja/N98lmnDLM91OT7mIk0263D2VuqO64U2J2fHKI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191359; c=relaxed/simple;
	bh=zQTmU14R3g+hm0SfXLio5BJK2Cr/KzBtK6v112xDMLo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJCvfFEk80ZgSiF/4LMH0+Jc8iO9pkW2N1awKBCc1SJA5HLzA8S1JC1XRYE2md9pOO73rJ65PnKA+K+WBiNbjLlHpmahl3EhDkWIZBVcrcqCKlkC+bUkjTq1JgBSai30EnF8W0l7G/92Ls1SB75ap4b/kCaN8WPO9+HZpLykLdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FS1WO2dK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZJ+TGrj0; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 951d672c562711ef87684b57767b52b1-20240809
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zQTmU14R3g+hm0SfXLio5BJK2Cr/KzBtK6v112xDMLo=;
	b=FS1WO2dK/87qXwCyoVd8IpbhA+aWsIT+xZitJmxVheTmPi5II2+3tTF1cGJ4LxWJ2WwGackWFygSnZKZ5pXfDLFeWtNhgn1NI4c99G/cTTMs5TY8jCUPsTyHfCrrYpS6q/rPZkOhj6zSqgocygKhVRsfdQR2NoDPPXwJUcQiFjA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ee97200f-5282-452e-87ff-bdfe254764a9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:eb79ed3e-6019-4002-9080-12f7f4711092,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 951d672c562711ef87684b57767b52b1-20240809
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1599120088; Fri, 09 Aug 2024 16:15:47 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Aug 2024 16:15:46 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Aug 2024 16:15:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGkukwkpLP84pd1ZY9Q0pPo2FixGCbUE9PPkTHMLueFGRDSKGXCBDt4Q8IpqWAUWw2F4GgmT6VY1D8NiMNzPFx13aQAj0NKgDZs7HmesMAASo7rXWh1iymnyNS8JnZaE7RlktDmVugkXxfeEZgAggiBc0VehuOP7/2BSnBTu+c3eY66VOcGDN0cABHLM5KyBMefSN1ekWMwW3j5sOMww10wyZ5EWVd7FSTwn1hNFromuDvPXzeU2orGLoDwHKNi6XdDW8CEIz7ixTXXw1D4yGz42KfHqPwHvnYg7Xtryqot0owfIj+enjqOM+JygpAS2KS0S01rO2Dv3gI5ZKNdZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQTmU14R3g+hm0SfXLio5BJK2Cr/KzBtK6v112xDMLo=;
 b=mF38UdA9UXeABdwvRVIPmzZZMcDQtpqrzC0G920mDAGBaDv/4SotmjBveWGZVQ9+xiBqq+rXAb6/7gUB1qu3hfx2NMmZPgyHiQu7BMNcbPS/FvHEfLehOng8TWCjVT/kFiZWO983jCPWCcAjIUA0WVldhWQp0PwHVRzkcJYzqL10YumykpAN5oETy1Dk5bstTh8hA/UrkLObks4ugRTi7HYUctDHsAgtQI/okxlr36PBTyGrAh7844c5KeWu7vV5teCjGbvkuGEZGkEStQb6snhc3wlldY157KxGwnHu25/ogKEHMWd90/EWMgRo1B98b6cF6QQcxuR6+bOU02V0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQTmU14R3g+hm0SfXLio5BJK2Cr/KzBtK6v112xDMLo=;
 b=ZJ+TGrj03UmAPVe3tIhHUQlUg+jLlHweol472kZbtEixF12izuUZaAKJdz12ohByf83IBKMXd8VlyNIpfNQWMko8BzxHIv1+pcYeUqBh70G/kJvwx1BLhQNwUmnnhwEiQMXebirj9xwPTDARTEEGxBm+H5GzDKNExIBeHGwk2+U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7455.apcprd03.prod.outlook.com (2603:1096:820:ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Fri, 9 Aug
 2024 08:15:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:15:44 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v4] drm/mediatek: dsi: Add dsi per-frame lp code for
 mt8188
Thread-Topic: [PATCH v4] drm/mediatek: dsi: Add dsi per-frame lp code for
 mt8188
Thread-Index: AQHa4+qWvSJl5Up3QEu6RU2Prg/rNbIeoNKA
Date: Fri, 9 Aug 2024 08:15:44 +0000
Message-ID: <ac28d576de8ef20ff0927fc1779c7ede57c8d251.camel@mediatek.com>
References: <20240801081144.22372-1-shuijing.li@mediatek.com>
In-Reply-To: <20240801081144.22372-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7455:EE_
x-ms-office365-filtering-correlation-id: cb02420d-82d8-459f-7626-08dcb84b7777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VzRxSDREM2w5bmlpVGVpUVlQVDJWS3llMWlrL0xqaWx3Z3pNbVZkQytUTXR6?=
 =?utf-8?B?QnRRVmhRaFdlS0V2YjRwdzRKSkZaS3M4NkFhek9SdmF4R2dJaHZMa3F0ckMr?=
 =?utf-8?B?SXZLSjM3N09SelhHSmUzR1N2c2JBN05aMWc4cXFZVytObkZkQUlIRGZMUFgy?=
 =?utf-8?B?aGRUQjhLanRCbERLeDY2eWVwbDI5SUdWNWJ0YVNpY2lEc2ZwbzIzZXRXWHZP?=
 =?utf-8?B?ZTl5b1liWC9nbHRweW84K1ZrOFREQ2hTTnNzQi9qL3RrLzEzSFRvTFcxeEdK?=
 =?utf-8?B?dlVZSHliUHduWU5MS2JIdjFBSmtvdXVuT3VFODF3S1lqeFBYWlNacnB5SzNJ?=
 =?utf-8?B?Q2hFWVkvSlViMnlReVErQTA3cllFYXBnS3lmWjVuK1BERDEzSE81TWlneTRY?=
 =?utf-8?B?elBQb1E3Y0JSbHlJUkZ6SnZrOTBQWXN1YlVSM2ZjOVdlTDIycWswUytGbk1O?=
 =?utf-8?B?Y0c0YnFJL3BGaU5sWU4ycEFpWmlPV29mYTV2Slo3eDBKck9va1puaHp1bElk?=
 =?utf-8?B?MUhIejI5Z3hnN1VVTGlXRVdpL2t5anBhRDk3Q04yY1hXbkNVeVVoc0E1aktF?=
 =?utf-8?B?T3FPNDFaSnlqV2Jkb3NUZHpjTk1ObXhobStyY1h3RENjWDNiRW9hMXFnWXhJ?=
 =?utf-8?B?MFFhSWo5akFyK1hqMFphcmhCbExGRDB3SnFLUzJFdmcxQnRIWndzSU1oQkRa?=
 =?utf-8?B?VnRsMUNMT2dxQzJmYUdWMTFKWW5hRXM1K1pvOFVOODRtTnFrbzRCZW01K3dK?=
 =?utf-8?B?d0dHTzRmRXQ4WGc0VnMvOW9KWHFLSlMxcUFPMU5yQ1N5QjJmYnNDcU8wY2VS?=
 =?utf-8?B?SERFM3d0ZWtYbUpiQ2xxT3hac0dOZFRzWUFvekVmc3lBYnhOUWViazY5UjRG?=
 =?utf-8?B?Mk1uc1U2SmVBZEREYlFpY01wdlJtMkliN2syQzZLbUdIRVVJOU85NlArRGZQ?=
 =?utf-8?B?QTJ0cmIxUldFMWRTWXlqajdjbU9wSDZXY2dpWCtHYVE0cWNab1F6c2lFUk1O?=
 =?utf-8?B?SVdlQ1gxN1FoUm1VWEk5bXU4amhHUmxObXBOazVzZzdhQzA4VktRalRKc05z?=
 =?utf-8?B?Zi9DbWVUMk04UjFKR3lPNVJJZUNTYzN5dGxhNlNkSGtsWVQwUzE5czN2ejAr?=
 =?utf-8?B?UTBpVDM0NWRJV2syT3A4a2REUDZhMEdMSlRNRmR1aEd0RFNvVlFhaWFjTmtu?=
 =?utf-8?B?Q0hPTkVtc2pWTlE2UjBqMDFnNjV2dEl4VE9sTlgrTXVhWllJbXVHeksvUDV1?=
 =?utf-8?B?N2ZMS2VBd1h0NkZFOG5senlONXAwSHc5T3BTMDJMZHNkZUhaMU5xZ3dJTjhN?=
 =?utf-8?B?d2VwVkJjV0pTZlFaTXdGQmF5QmU4bDd6MWRCRkgrZ1VWak9ZMTY4bS9KMG45?=
 =?utf-8?B?blNmOFdWSXc4cU9wNHNXcktKQ1E3ci9VNHJqdWxZTHRxNnprREhIRnJHUEp2?=
 =?utf-8?B?QVNtUXR3MFJuMGhxRUFhOHltSnVicW1aSkx4d2tVVnpGMVJxREFYeEs1QXNk?=
 =?utf-8?B?L0VVS2s3dXh2U1dWckg0aWR4ZDdHa1E4by9BejczWlpnTjExT3J3WVkzRWxT?=
 =?utf-8?B?bmx2c1FCVk53U29SaFZTaTU1Z3lnTFFOS3had1l5VW9jOTFHRlZXZ3prQXUw?=
 =?utf-8?B?MTRsem1EOGN2eFFoNUM2ajg1NTZKb1BZSkJQT0Q5eGFMRHlPa21JeDc5Ymhq?=
 =?utf-8?B?QWdjc3ZtQnRBMnh1ODNERUJZUWUzYmxBWTk2T2J0aXpsQjN4Y3F0ZzNlalJ0?=
 =?utf-8?B?MkN4dUlrNnN4ZjZuUHNZdUIvNU1IZ2JzamhiU21YUXRreXFMMVV0OGdDVGxP?=
 =?utf-8?B?MmV4K2RtWERDUXZHMWxUZ1g2MUxEOVBpR2lVY0J3L0J5UGtBWGxMRXg5cHQ2?=
 =?utf-8?B?ZU5ycHNIeGt0V3RrNDNlSjFlc0t0RDRlRGQrY3hBbVh3N3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3puSVJmQ1VXSUw2ckhKcWxEL2kwUklxQnNKTFZZRjJacUpidVNoUlFKUEJj?=
 =?utf-8?B?K2pudzVMcTJKNW1BakJGVWg0RFRobE1BZWNmYVJNRzVzTlhXcUZKYUR6bFp0?=
 =?utf-8?B?RklCSUZKMHRMS2htTkt6YUVibituQWxJK3ZkNjRGdFpLR1ArWmVDMjFITm1i?=
 =?utf-8?B?MnB1ZmlmazdJZ2xNcXk2NUNGandSYXcvd01VRllUV1FRNHVFMGMyRFBKWmtJ?=
 =?utf-8?B?VkRHcjdnSE12TEhDS2Z0NXE0dmJtZTZHTElMaTVmS2lNOUZGb3JIcDAvUllr?=
 =?utf-8?B?aU45ckhMMHFQT0QwN3Z3eXA3RG02YWp4V3llRDh1OU5mNCtHTVFHU1dHVHdR?=
 =?utf-8?B?Z2s0REFrQ2RQcFFPeWxWb0FJQlVWVzFUSHFXcjZhVm8xS3Btcm5kalBFa1hB?=
 =?utf-8?B?NlVSL1JPbENQMmJGMi96emNWSFBKdFdvQnRtRFgyK2JyQy9uRFNtUzRweThI?=
 =?utf-8?B?QzJEYlp3OTREai9rNDI0OGdVb1lvWkJwejhPVTFmbkpHMndaS2lCT2U1V2Zj?=
 =?utf-8?B?TlE0R2huMG1wOWVVcE1jWjNFb1J5RkRvTXhUaXdRY3JqdkJWUWEzMzRYU1R5?=
 =?utf-8?B?MlMvVVhxMjFDWU44ZWc1djh5Nk9rSFh2Z0pXRnVHQmpxNFREdlB1T2Nsc3NP?=
 =?utf-8?B?VXBTQTdCK3hpNnBFRVNoZHEvM0xiRWJhVE1nWHNYVHNZbllCcEJabitTclRp?=
 =?utf-8?B?cFBwc0doU1JxNkRmUHdIb1VmbG8xRU5nV1lqMEYwczBJaS9CMEVzS0RtSzJH?=
 =?utf-8?B?V0w0elRseExscFRCakMrNHhMM20xSUtvNUpzYWdaSTlXd2ZFSEZMVkIrN2Yy?=
 =?utf-8?B?ZVVIN3M4Q2RZc1hNRTBTd0pQMlFxUlpoOGJxUnlMTU1XcVg4MnZZall0TFJB?=
 =?utf-8?B?dzg1Tk1EOHlMZXBuQllHYmUweVc4OGNBd3gwdVRRWkpNNWh2TGJPejV1Q2Ju?=
 =?utf-8?B?aTd4RXZiZWJjZ3BFeXJ1U3IwcXl6YmlXcUdYbUVtdldIMXZST1JvMUpTQ2dI?=
 =?utf-8?B?VitaSVRoOHJJMVBaNzJCdW4zdDJzZDdDS2x5RWJNc09DUkd3a2dUckZLbndu?=
 =?utf-8?B?bm5kcmxqS1lhMEZpZGNEYmQzamdjd3dZSEpzRGYyc0JQWWdHNjQ0ODIzNi9o?=
 =?utf-8?B?aWpDUkl1YVdVaFZkZHV5ZFVvMUY0UUw5TVc5RTl2TWliYUhVV3FxUit0cFU3?=
 =?utf-8?B?YzlUd2lpK3p4UFJHeFgwN0pWWlkxTUZQZUs0UFJ5TjdsejRWTGZoT056bmQ3?=
 =?utf-8?B?YlphMmdYRlZHRnUvOThnckIvVGM3RTJCakxTbHprNjhPUGRTUU1MbExFREFa?=
 =?utf-8?B?OXVyajlDemFaYWgvS3kwR3BNZ3lMR2xqZ1ZHL3E5eis3L1MwUmZkZnBoQ1RN?=
 =?utf-8?B?NVVwNUgxUG1LcjNVZk1NQ1hPZ2pXdW1taGtPNjBqRFQreFNwSXNKNDBWUW1o?=
 =?utf-8?B?WmpVTVdpOGs0MVhoTVl2dDVoLzh5RUlCVVdGNUpQWDRjTkFtK3A0UWdVdTJU?=
 =?utf-8?B?NU5WTDdpbkdrMU0rdEloaFlCWEltYkd4cy9XUWNJQWx1N2pTRGZ4dC8xQnFp?=
 =?utf-8?B?LzBnQzZnc2xWWjY1NHBVdy9ESTh1eTFIaVdTbVRXNlFVdUZ6NGloMUlBcmUw?=
 =?utf-8?B?RXFocWczOGYxR1UzUXh2ZkFiMmgvNWEzMGpFL1Yxd2ozMlV6czI0bFRqVzJq?=
 =?utf-8?B?WEhSdjh3SEJhc1VwbGNyd0c5dG5CQmdQSnA4dTUzbFJBa0Q4Z2lPS211NWZI?=
 =?utf-8?B?ZWxYK0NRUDJLVStBMFd3RUlKeW9XdnRhck9FSDFVVkdVTjBhcHF4bU5xVndl?=
 =?utf-8?B?eVRmdzRjWXhFbXhpcmltWGZsVmd0R0pVRGhRYll6U3loZGFOYjVJaGgvQXcx?=
 =?utf-8?B?ZEswaDAzR3U1RWhqb3FhSlFueVFRMkl0VXI3blRuLzloaXpZL0Y0M1ZTNGNY?=
 =?utf-8?B?eko1bURvN2ZGVzJUVlNXSFplMEZlRGtrZDUxSnFyc09zWWVDQXRhZ3kwNUdm?=
 =?utf-8?B?VXB3VU5uWGZmNmYyazRKWVpzbFp3YkpFMTZSTGg4RXRsWUJMTlVqUmZ6UUpC?=
 =?utf-8?B?L3Uxa21ZZzM0aElYWHN3QkRtVXBPSVhmd1piUlhmMWdaQkVtOU5UbHhHUUN2?=
 =?utf-8?Q?52xCoZdiHlDCXNVDtarAL7+CL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00ECE2CA2EACF540B127C86280C382D5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb02420d-82d8-459f-7626-08dcb84b7777
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:15:44.5516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vAqWdb3urgalTCxcp3chulo7zeZxZi5Lr2pMwEEYTkKX7n0Qyhcdg1BMTETgzkhmDrbQHJyif3r7YtfqtuOC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7455
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.288800-8.000000
X-TMASE-MatchedRID: HXSqh3WYKfsOwH4pD14DsPHkpkyUphL9IR1rLBJm/M782ks92f+Gmgef
	5FoKtUGzZMI44OwacXNVpaMde16oQMl6p6KoPhJI4pdq9sdj8LWIrmqDVyayv/t592eq2xoTMCm
	LSFOvZt2TuTIXgx3qzJPJbwBiOizgtt90M/7M5GaiAZ3zAhQYglo1rFkFFs1apkUWHRtJ9JnLDO
	wJx4cAjyPbwndZ0NosfqGSKh5yGVlb2IrxDCpMMZ4CIKY/Hg3AwWulRtvvYxTUHQeTVDUrIuB8J
	9aWc1v/VymkLM+r7VQ7AFczfjr/7NgWuFYsnEIhz+UayHeCIaXUYNS9WMEt9WwkImb/drYLvrxV
	sjY9l2g=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.288800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5036F1FADD3F8C4D4562C8FAA835F1AC1D7E2F85E15F99CBEE7C1C0EC5138AA82000:8

SGksIFNodWlqaW5nOg0KDQpPbiBUaHUsIDIwMjQtMDgtMDEgYXQgMTY6MTEgKzA4MDAsIFNodWlq
aW5nIExpIHdyb3RlOg0KPiBBZGRpbmcgdGhlIHBlci1mcmFtZSBscCBmdW5jdGlvbiBvZiBtdDgx
ODgsIHdoaWNoIGNhbiBrZWVwIEhGUCBpbiBIUyBhbmQNCj4gcmVkdWNlIHRoZSB0aW1lIHJlcXVp
cmVkIGZvciBlYWNoIGxpbmUgdG8gZW50ZXIgYW5kIGV4aXQgbG93IHBvd2VyLg0KPiBQZXIgRnJh
bWUgTFA6DQo+ICAgfDwtLS0tLS0tLS0tT25lIEFjdGl2ZSBGcmFtZS0tLS0tLS0tPnwNCj4gLS1f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXy0tLS1fX19fX19fX19fX19fX19f
X19fDQo+ICAgXkhTQStIQlBeXlJHQl5eSEZQXl5IU0ErSEJQXl5SR0JeXkhGUF4gICAgXkhTQStI
QlBeXlJHQl5eSEZQXg0KPiANCj4gUGVyIExpbmUgTFA6DQo+ICAgfDwtLS0tLS0tLS0tLS0tLS1P
bmUgQWN0aXZlIEZyYW1lLS0tLS0tLS0tLS0+fA0KPiAtLV9fX19fX19fX19fX19fLS1fX19fX19f
X19fX19fXy0tX19fX19fX19fX19fX18tLS0tX19fX19fX19fX19fX18NCj4gICBeSFNBK0hCUF5e
UkdCXiAgXkhTQStIQlBeXlJHQl4gIF5IU0ErSEJQXl5SR0JeICAgIF5IU0ErSEJQXl5SR0JeDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHVpamluZyBMaSA8c2h1aWppbmcubGlAbWVkaWF0ZWsuY29t
Pg0KPiAtLS0NCg0KW3NuaXBdDQoNCj4gKw0KPiAgc3RhdGljIHZvaWQgbXRrX2RzaV9jb25maWdf
dmRvX3RpbWluZyhzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KPiAgew0KPiAgCXUzMiBob3Jpem9udGFs
X3N5bmNfYWN0aXZlX2J5dGU7DQo+IEBAIC00NDksNTcgKzU2MCw2MSBAQCBzdGF0aWMgdm9pZCBt
dGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICAJd3JpdGVs
KHZtLT52ZnJvbnRfcG9yY2gsIGRzaS0+cmVncyArIERTSV9WRlBfTkwpOw0KPiAgCXdyaXRlbCh2
bS0+dmFjdGl2ZSwgZHNpLT5yZWdzICsgRFNJX1ZBQ1RfTkwpOw0KPiAgDQo+IC0JaWYgKGRzaS0+
ZHJpdmVyX2RhdGEtPmhhc19zaXplX2N0bCkNCj4gLQkJd3JpdGVsKEZJRUxEX1BSRVAoRFNJX0hF
SUdIVCwgdm0tPnZhY3RpdmUpIHwNCj4gLQkJICAgICAgIEZJRUxEX1BSRVAoRFNJX1dJRFRILCB2
bS0+aGFjdGl2ZSksDQo+IC0JCSAgICAgICBkc2ktPnJlZ3MgKyBEU0lfU0laRV9DT04pOw0KDQpJ
ZiBzdXBwb3J0X3Blcl9mcmFtZV9scCBpcyB0cnVlLCB0aGlzIGNvZGUgd291bGQgbm90IGJlIGV4
ZWN1dGUsDQpidXQgaGFzX3NpemVfY3RsIGlzIHRydWUgaW4gbXQ4MTg4Lg0KRG9lcyB0aGlzIG1l
YW4gd2hlbiBzdXBwb3J0X3Blcl9mcmFtZV9scCBpcyB0cnVlLCBoYXNfc2l6ZV9jdGwgc2hvdWxk
IGJlIGZhbHNlPw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAtDQo+IC0JaG9yaXpvbnRhbF9zeW5jX2Fj
dGl2ZV9ieXRlID0gKHZtLT5oc3luY19sZW4gKiBkc2lfdG1wX2J1Zl9icHAgLSAxMCk7DQo+IC0N
Cj4gLQlpZiAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9WSURFT19TWU5DX1BVTFNF
KQ0KPiAtCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0gdm0tPmhiYWNrX3BvcmNoICogZHNp
X3RtcF9idWZfYnBwIC0gMTA7DQo+IC0JZWxzZQ0KPiAtCQlob3Jpem9udGFsX2JhY2twb3JjaF9i
eXRlID0gKHZtLT5oYmFja19wb3JjaCArIHZtLT5oc3luY19sZW4pICoNCj4gLQkJCQkJICAgIGRz
aV90bXBfYnVmX2JwcCAtIDEwOw0KPiAtDQo+IC0JZGF0YV9waHlfY3ljbGVzID0gdGltaW5nLT5s
cHggKyB0aW1pbmctPmRhX2hzX3ByZXBhcmUgKw0KPiAtCQkJICB0aW1pbmctPmRhX2hzX3plcm8g
KyB0aW1pbmctPmRhX2hzX2V4aXQgKyAzOw0KPiAtDQo+IC0JZGVsdGEgPSBkc2ktPm1vZGVfZmxh
Z3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX0JVUlNUID8gMTggOiAxMjsNCj4gLQlkZWx0YSArPSBk
c2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX05PX0VPVF9QQUNLRVQgPyAwIDogMjsNCj4g
KwlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+c3VwcG9ydF9wZXJfZnJhbWVfbHApDQo+ICsJCW10a19k
c2lfY29uZmlnX3Zkb190aW1pbmdfcGVyX2ZyYW1lX2xwKGRzaSk7DQo+ICsJZWxzZSB7DQo+ICsJ
CWlmIChkc2ktPmRyaXZlcl9kYXRhLT5oYXNfc2l6ZV9jdGwpDQo+ICsJCQl3cml0ZWwoRklFTERf
UFJFUChEU0lfSEVJR0hULCB2bS0+dmFjdGl2ZSkgfA0KPiArCQkJCUZJRUxEX1BSRVAoRFNJX1dJ
RFRILCB2bS0+aGFjdGl2ZSksDQo+ICsJCQkJZHNpLT5yZWdzICsgRFNJX1NJWkVfQ09OKTsNCj4g
IA0KPiAtCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlID0gdm0tPmhmcm9udF9wb3JjaCAqIGRz
aV90bXBfYnVmX2JwcDsNCj4gLQlob3Jpem9udGFsX2Zyb250X2JhY2tfYnl0ZSA9IGhvcml6b250
YWxfZnJvbnRwb3JjaF9ieXRlICsgaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZTsNCj4gLQlkYXRh
X3BoeV9jeWNsZXNfYnl0ZSA9IGRhdGFfcGh5X2N5Y2xlcyAqIGRzaS0+bGFuZXMgKyBkZWx0YTsN
Cj4gKwkJaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlID0gKHZtLT5oc3luY19sZW4gKiBkc2lf
dG1wX2J1Zl9icHAgLSAxMCk7DQo+ICANCj4gLQlpZiAoaG9yaXpvbnRhbF9mcm9udF9iYWNrX2J5
dGUgPiBkYXRhX3BoeV9jeWNsZXNfYnl0ZSkgew0KPiAtCQlob3Jpem9udGFsX2Zyb250cG9yY2hf
Ynl0ZSAtPSBkYXRhX3BoeV9jeWNsZXNfYnl0ZSAqDQo+IC0JCQkJCSAgICAgIGhvcml6b250YWxf
ZnJvbnRwb3JjaF9ieXRlIC8NCj4gLQkJCQkJICAgICAgaG9yaXpvbnRhbF9mcm9udF9iYWNrX2J5
dGU7DQo+IC0NCj4gLQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSAtPSBkYXRhX3BoeV9jeWNs
ZXNfYnl0ZSAqDQo+IC0JCQkJCSAgICAgaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSAvDQo+IC0J
CQkJCSAgICAgaG9yaXpvbnRhbF9mcm9udF9iYWNrX2J5dGU7DQo+IC0JfSBlbHNlIHsNCj4gLQkJ
RFJNX1dBUk4oIkhGUCArIEhCUCBsZXNzIHRoYW4gZC1waHksIEZQUyB3aWxsIHVuZGVyIDYwSHpc
biIpOw0KPiAtCX0NCj4gLQ0KPiAtCWlmICgoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfSFNf
UEtUX0VORF9BTElHTkVEKSAmJg0KPiAtCSAgICAoZHNpLT5sYW5lcyA9PSA0KSkgew0KPiAtCQlo
b3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGUgPQ0KPiAtCQkJcm91bmR1cChob3Jpem9udGFsX3N5
bmNfYWN0aXZlX2J5dGUsIGRzaS0+bGFuZXMpIC0gMjsNCj4gLQkJaG9yaXpvbnRhbF9mcm9udHBv
cmNoX2J5dGUgPQ0KPiAtCQkJcm91bmR1cChob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSwgZHNp
LT5sYW5lcykgLSAyOw0KPiAtCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0NCj4gLQkJCXJv
dW5kdXAoaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSwgZHNpLT5sYW5lcykgLSAyOw0KPiAtCQlo
b3Jpem9udGFsX2JhY2twb3JjaF9ieXRlIC09DQo+IC0JCQkodm0tPmhhY3RpdmUgKiBkc2lfdG1w
X2J1Zl9icHAgKyAyKSAlIGRzaS0+bGFuZXM7DQo+ICsJCWlmIChkc2ktPm1vZGVfZmxhZ3MgJiBN
SVBJX0RTSV9NT0RFX1ZJREVPX1NZTkNfUFVMU0UpDQo+ICsJCQlob3Jpem9udGFsX2JhY2twb3Jj
aF9ieXRlID0gdm0tPmhiYWNrX3BvcmNoICogZHNpX3RtcF9idWZfYnBwIC0gMTA7DQo+ICsJCWVs
c2UNCj4gKwkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgPSAodm0tPmhiYWNrX3BvcmNoICsg
dm0tPmhzeW5jX2xlbikgKg0KPiArCQkJCQkJCWRzaV90bXBfYnVmX2JwcCAtIDEwOw0KPiArDQo+
ICsJCWRhdGFfcGh5X2N5Y2xlcyA9IHRpbWluZy0+bHB4ICsgdGltaW5nLT5kYV9oc19wcmVwYXJl
ICsNCj4gKwkJCQl0aW1pbmctPmRhX2hzX3plcm8gKyB0aW1pbmctPmRhX2hzX2V4aXQgKyAzOw0K
PiArDQo+ICsJCWRlbHRhID0gZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9WSURFT19C
VVJTVCA/IDE4IDogMTI7DQo+ICsJCWRlbHRhICs9IGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJ
X01PREVfTk9fRU9UX1BBQ0tFVCA/IDAgOiAyOw0KPiArDQo+ICsJCWhvcml6b250YWxfZnJvbnRw
b3JjaF9ieXRlID0gdm0tPmhmcm9udF9wb3JjaCAqIGRzaV90bXBfYnVmX2JwcDsNCj4gKwkJaG9y
aXpvbnRhbF9mcm9udF9iYWNrX2J5dGUgPSBob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSArIGhv
cml6b250YWxfYmFja3BvcmNoX2J5dGU7DQo+ICsJCWRhdGFfcGh5X2N5Y2xlc19ieXRlID0gZGF0
YV9waHlfY3ljbGVzICogZHNpLT5sYW5lcyArIGRlbHRhOw0KPiArDQo+ICsJCWlmIChob3Jpem9u
dGFsX2Zyb250X2JhY2tfYnl0ZSA+IGRhdGFfcGh5X2N5Y2xlc19ieXRlKSB7DQo+ICsJCQlob3Jp
em9udGFsX2Zyb250cG9yY2hfYnl0ZSAtPSBkYXRhX3BoeV9jeWNsZXNfYnl0ZSAqDQo+ICsJCQkJ
CQkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgLw0KPiArCQkJCQkJCWhvcml6b250YWxfZnJv
bnRfYmFja19ieXRlOw0KPiArDQo+ICsJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlIC09IGRh
dGFfcGh5X2N5Y2xlc19ieXRlICoNCj4gKwkJCQkJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRl
IC8NCj4gKwkJCQkJCQlob3Jpem9udGFsX2Zyb250X2JhY2tfYnl0ZTsNCj4gKwkJfSBlbHNlIHsN
Cj4gKwkJCURSTV9XQVJOKCJIRlAgKyBIQlAgbGVzcyB0aGFuIGQtcGh5LCBGUFMgd2lsbCB1bmRl
ciA2MEh6XG4iKTsNCj4gKwkJfQ0KPiArDQo+ICsJCWlmICgoZHNpLT5tb2RlX2ZsYWdzICYgTUlQ
SV9EU0lfSFNfUEtUX0VORF9BTElHTkVEKSAmJg0KPiArCQkJKGRzaS0+bGFuZXMgPT0gNCkpIHsN
Cj4gKwkJCWhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZSA9DQo+ICsJCQkJcm91bmR1cChob3Jp
em9udGFsX3N5bmNfYWN0aXZlX2J5dGUsIGRzaS0+bGFuZXMpIC0gMjsNCj4gKwkJCWhvcml6b250
YWxfZnJvbnRwb3JjaF9ieXRlID0NCj4gKwkJCQlyb3VuZHVwKGhvcml6b250YWxfZnJvbnRwb3Jj
aF9ieXRlLCBkc2ktPmxhbmVzKSAtIDI7DQo+ICsJCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRl
ID0NCj4gKwkJCQlyb3VuZHVwKGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+bGFuZXMp
IC0gMjsNCj4gKwkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgLT0NCj4gKwkJCQkodm0tPmhh
Y3RpdmUgKiBkc2lfdG1wX2J1Zl9icHAgKyAyKSAlIGRzaS0+bGFuZXM7DQo+ICsJCX0NCj4gKw0K
PiArCQl3cml0ZWwoaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlLCBkc2ktPnJlZ3MgKyBEU0lf
SFNBX1dDKTsNCj4gKwkJd3JpdGVsKGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+cmVn
cyArIERTSV9IQlBfV0MpOw0KPiArCQl3cml0ZWwoaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUs
IGRzaS0+cmVncyArIERTSV9IRlBfV0MpOw0KPiAgCX0NCj4gIA0KPiAtCXdyaXRlbChob3Jpem9u
dGFsX3N5bmNfYWN0aXZlX2J5dGUsIGRzaS0+cmVncyArIERTSV9IU0FfV0MpOw0KPiAtCXdyaXRl
bChob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlLCBkc2ktPnJlZ3MgKyBEU0lfSEJQX1dDKTsNCj4g
LQl3cml0ZWwoaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUsIGRzaS0+cmVncyArIERTSV9IRlBf
V0MpOw0KPiAtDQo+ICAJbXRrX2RzaV9wc19jb250cm9sKGRzaSwgZmFsc2UpOw0KPiAgfQ0KPiAg
DQo+IEBAIC0xMTk3LDYgKzEzMTIsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kc2lfZHJp
dmVyX2RhdGEgbXQ4MTg4X2RzaV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuaGFzX3NoYWRvd19jdGwg
PSB0cnVlLA0KPiAgCS5oYXNfc2l6ZV9jdGwgPSB0cnVlLA0KPiAgCS5jbWRxX2xvbmdfcGFja2V0
X2N0bCA9IHRydWUsDQo+ICsJLnN1cHBvcnRfcGVyX2ZyYW1lX2xwID0gdHJ1ZSwNCj4gIH07DQo+
ICANCg==

