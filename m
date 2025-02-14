Return-Path: <linux-kernel+bounces-514378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0179A35623
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5418F16D641
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5186186E56;
	Fri, 14 Feb 2025 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Vne3jh5D";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZYoyni8s"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BA10E3;
	Fri, 14 Feb 2025 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510496; cv=fail; b=EmGhcRYkX89WuVR5el6HzbebRJO1IcPXCxCOhUSai8EVsna/q5Gb4cmTpkSDcPp3UJ76of3hkR75IL6ibMEZPTjUFaAAy9H9bEJad3Tv74733e9IMq4A2WcBpCK3xS1jfbERTQ/b3ntirgfAS7lSiFghFbNBvYg6CuJsVfFO1zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510496; c=relaxed/simple;
	bh=g5hWSdimPSbubu3uRtX19YP4GUKxZRZH2l4WcGSnBQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XhCuTMEkU2a/N7U99DD/AWNyoTaTEWFAfW7CRdlFd7jhcEL2cM41iNh4PSOSpwYlIJW9CniArxqmP95ySOwgqKLa0f5UeJmNcTcIpONZ1XhJN6b1OECMPFCbUKjuZyYlV4id7H6VccmaxZRd9y9HVKNhBbMzNYxURrfzjyI+/ms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Vne3jh5D; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZYoyni8s; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8ca1119cea9311efbd192953cf12861f-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=g5hWSdimPSbubu3uRtX19YP4GUKxZRZH2l4WcGSnBQc=;
	b=Vne3jh5De82kgKLpV7w1gSZKV6jJ/NgYnfQnLDfeHOd0/05eqPFl18FKh/fENYi18/tbGWegkuLYmoZzEbvpaftcLxuMeeQa4AVnHX4mYnz0L3WGr03wUxD43OzF157Qpg1oPzBFny5vaQey3ezOW7QBB04sqLYGDLIRtMRTzWQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:58e73508-fd55-428a-b50e-35dce7e6e130,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:0ca65b8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8ca1119cea9311efbd192953cf12861f-20250214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1313192526; Fri, 14 Feb 2025 13:21:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 13:21:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 13:21:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZqXzvHHf5ODDc0uLPWai6OjEw+y+DLrLMPAFZeNaSyXJ6CNbNrMLQgZbgr8pionB8Qf8urtdyg9syLgAN9yh4tGTNWptBwxgqq2IVbiXCBt0uiUEvUWkPcIcf9P1rqQ/78pvaueSlbdSf4bqWmSbaMF0NtL17urdYp5l1jlCK8hCCZmAtLjPieUKoIxkdeHsk4Rk8juBmt3ud37AwVabHjRSM6N1cfayuKr4IDQVhrX1/jwQ3DTfFdq4Dwi3dZS3Wbbkiv1JPGHgOyiNX0hx/b+mU2BsxF+B9ob+6BBAAj9mxsndBUjcOxD49IamoZdzg4kfNnFz9G/fJlC07e+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5hWSdimPSbubu3uRtX19YP4GUKxZRZH2l4WcGSnBQc=;
 b=AWiLv8WTbwX0lqjzpXSeK7P3jA9lUv/5UNvU0IxrAyE1dFQrUC4c4R9U/Mmkr8RYwBCP1rLT9efXfDkSg/ROQUJWPZDvc3E3o2ftO9V2/lP+egPpG2Z9xleJG6/MCmme9ZdV7RGzW1el8mLfW+rtgdwzaREP6oAnqDqFRLhDdz//e/hg63Lis4MCAz7bMsWvNNqXECHKN8tdCe5s6eAQAoPIv015UFKNV5PxSXpzjESioqdHi7hdIflcbDW1WrRaVSOejKYRsWUvrYvvShNDHImrSg3yxC3Qy1cQ17ccPGSQ0RAae5U7Ak4dbcLOqraRVEcRR1LzijY6nLFRKoLXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5hWSdimPSbubu3uRtX19YP4GUKxZRZH2l4WcGSnBQc=;
 b=ZYoyni8s+SX63zXz9wNPgLyz6IaO05wEbk8j3m0T36odwUNAR5aUzsTtXqA/093WYNX2kmEZKV4YdulHO5ZI2Xh+S1AWC2LpLyancYlRXxCChFLeeruVvQw0w8JsUk7/EhvgXg4dzurJBcFARgLtSGiuP9rWKL6Jvi/TWww3XT0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7570.apcprd03.prod.outlook.com (2603:1096:400:410::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.12; Fri, 14 Feb
 2025 05:21:27 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 05:21:27 +0000
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
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v6 41/42] drm/mediatek: mtk_hdmi_v2: Add debugfs ops and
 implement ABIST
Thread-Topic: [PATCH v6 41/42] drm/mediatek: mtk_hdmi_v2: Add debugfs ops and
 implement ABIST
Thread-Index: AQHbfHk36Ey5QHli3UWfMsUULjt/RbNGR6WA
Date: Fri, 14 Feb 2025 05:21:27 +0000
Message-ID: <0541a9bedef16763cc0279127ab258015b9a8a82.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-42-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-42-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7570:EE_
x-ms-office365-filtering-correlation-id: d9b76cb7-d0af-4777-d54b-08dd4cb76eb5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aVJ6Y3pvaDk3WCtBbWZaSjJsMHUwcXpqUGRFRHhhU21XSEI5ckNlQWVBclZ4?=
 =?utf-8?B?emFQaTlLdmk5bVJmMERWYTBvOUFHcDM5Qng4OUxqaEx5TE40bEpCOWNxeG1t?=
 =?utf-8?B?ZzIwQ255cGpzcEU2RGtLbGhLZ0w5b2NEZCswTSthQ3ZPTGdOZlhqM3VDVmYz?=
 =?utf-8?B?dHBIYkZIdDFPVndrRjVmdzN4SFE5a3hVT29odGgzRys2cHBuRTd0YmFkR2g4?=
 =?utf-8?B?ZGlYdk9GeXZQS296bWwxZm92dWVkNDRDd2pObDAreDYxNU85Z0N2bnUzNTUv?=
 =?utf-8?B?Z1pVTW5kM09YbFlhdnBCcDVGczNreS9OZDBlSlRhL29nbEsvMzgyNDlMcTM1?=
 =?utf-8?B?eUJtOUt1WVZmUXhaajNyR0FwRmZ2QWdSUXNQSlYrRERISk5xdnlHVXF4LzVq?=
 =?utf-8?B?TE9YUFppUnQyTjdBSi9uaXFVTmYrc0RKLzFoTjExaitId3lROTM3YmxKM0ti?=
 =?utf-8?B?QjZ0UmVKbE1SdzlhK3VGR1NvNjhUakhMbndCRTFPRnRsKy96UDdCdVh2em0v?=
 =?utf-8?B?cGpCZ1VhQmVxZ2liMVVzMjBBTkErc0hoRXhLV0t1R1o2RHFjT0hLb3FTdmFD?=
 =?utf-8?B?TW1iMVdXYTZQRVlsRE5zMVdORGxsdmgzNGdWcnBsaGZoYWdwYm1YSjhEeW9E?=
 =?utf-8?B?VGFDVzZOd1E2OVpQeXdMNndYQkxxTFFHU0JVT1ZwK2xWYzZCOE1vQ0JJRTBV?=
 =?utf-8?B?eS9mUFliaUVsSVBRVGtCbEJWYWJ6c09pMDhqR200VVlWdEVLQWtlNjdsOVR5?=
 =?utf-8?B?MXB4b1VydmY2Y00yTnNhbmV5ZVV4aktjWkxBNURWYkhTQ1VSUkhkSG1rZHk1?=
 =?utf-8?B?SG9uRnlzaEUzWlc3TWpFbElZZnZiV0ExN3l0cFVmNFhXZFlhUjVCWUs4QVFu?=
 =?utf-8?B?VUlDY2paRThDNzB1WTdGUlRtTitPNTNkNWhyNXhSWWU3SFBYSzdBaUdpUkpL?=
 =?utf-8?B?TXZJQ3o2NktDVTZTUnhxUysyRXZLWTh2d3pVNTBvSUp0UXZQSkV0TUV5T2Q1?=
 =?utf-8?B?R25NNVFtMFlxVnV3ZUo5SUxyZ1ViRXorOGRGaXd3NnZlNzNneE4rNW0xQTdt?=
 =?utf-8?B?cXVJNzRKbDlNZU5hZmM4dW1qM1gyanVBZjRZWVd1djJNTitlekgxVWhIbzNW?=
 =?utf-8?B?SEFkbVlYT2hiYXF4b2Y0LzFJQjJrMjluRjN5MW00UEMrL1BYNDBJWTFXN05l?=
 =?utf-8?B?QjdJTGhJMlRmanVKS0F5SnVWOEJEZTlaYytaRlB1L2taRmsybUpONVdGSndw?=
 =?utf-8?B?cTVKZEdJMXlPYXB4Yk9ld3pZOC85WENVOE53T3MwMjVwNE0rNVkxUnRxVElD?=
 =?utf-8?B?bHJuaWpMRTJEWUxEVUxUeUVhMmRtNTVEZkh1dmJYdnZCRnM0TDNzaThjbDVn?=
 =?utf-8?B?cWkyVk1JSlBsV241NjhvUERkWGJyS0VDL1Zlc1hOVUp5c0pTZGVlOHBWUFNW?=
 =?utf-8?B?VEJXcEdmbWZ4TlQxVHhiYUNrcjZ3ODhxU2huUGdOakdYeHZidjJJTXZSQklK?=
 =?utf-8?B?UTMxZ0xQSmdqdHJmdHhVQWVyaHpaRWw3QWZtZ3Z6dlJEenhxdTRyclJKZzIw?=
 =?utf-8?B?NlJVaUhFMUw5aUtrR0lwcm9IeHg2L1I1cTdVcWt5YTFKQkdHTzVBbW1kVkJZ?=
 =?utf-8?B?WGxWbk0xL3ByS2dnelB3ajlzQThPUU43RTVnOEtCUzExRG0vKzN5cXNMMG5K?=
 =?utf-8?B?Vi90VmREMk85YmJVVExSZkJmbWdhVDRPaE1kcUQ5alpGbTZlZm9rNXRtNGVl?=
 =?utf-8?B?RjRaR0pLRkJMSm95ejFReEpvdDVQeVZlV0drc3MwNGUvc0tsWUVhYXZPR2FB?=
 =?utf-8?B?OEY0VVI5Z2xMeTd2RUsxQnVWL3Zzc0NFWjc3OTJUdVdmbVBkako0cVlYNUYv?=
 =?utf-8?B?bE1nWFBJWGw0NWhRTEJnZmxEczdVVmdSZ21TNks2STdwTjhoVHlHeXhQbm53?=
 =?utf-8?Q?4D3OM5ZiFfvgAp0N1ADqr4+u/tylJphL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlRDcDA5cjcxNFZRVVVueE1UNkVuakhlc3hFVFd4aWhidXpSNmRvUjVkQ0tB?=
 =?utf-8?B?YmVXUFgraE16VmxVRFVlSmNDM29qaDBpMG1tYmVOYVNLQzV1NkQ4Y1hsWFpv?=
 =?utf-8?B?RVRhT2ZUN3BHQ0pIMklzMHBpZzZaOENyUWdPVDZtQ1Z4ZWsxK1ZCQS9vanNl?=
 =?utf-8?B?NVMrSHVCTTAwOFhDdkxzeXc5UnJ2RGh1K1ZWNFNCUmhzMHpYUWdPWmVvWTJa?=
 =?utf-8?B?b3hjeXAxb0FOcnRCWW5PTTA4bEQ1eVVGYjZxbFhTdzNaNmw4VE1QYmgyYVBr?=
 =?utf-8?B?clYwTUlVM0RHblhtcUpwRnd3NTVVZ2VXdTZhT2RkYkhrWlFPd1BhT2Z5dzQw?=
 =?utf-8?B?Tk4zUE5qc1U4NXorbnNZQ0hnUXRGWHRKR3F5QTZqMnpJL2lCM1BYcm01OVZh?=
 =?utf-8?B?WTFUeVp0YlZYMW9GUll1Qy90UlZTREhjSk1UU3cxRjJ4Y3dsYlpNaTdmbDhZ?=
 =?utf-8?B?VVFRMlhaakQ1eXUxZEgvREF6L0pXcFNQc1pGaTk1bTBnVzVvTkVBUTZyNXJs?=
 =?utf-8?B?NmRzYWo1V2lVREtnbzZVOTNoSWlEY28rOURNa3ZBc3Z0SmxyQ1NvWWN2Wm4w?=
 =?utf-8?B?TUxLMzJKR1BwK0RlcnR0ZVdjUlYzNHE2VFRsb0hTWlJ6YTBueGdDaytsSXFl?=
 =?utf-8?B?a2VodTlzMHlDeWxlWGkwTXVsWDhRTVQ2c1Blelk1TmQxb1U2VFIxSmJJR1dl?=
 =?utf-8?B?Wjd0VFpTNHdnTnRXQWlFNzhieUJvZTVOSjEwa2ltMkFRZzlQdllCRGJQbG5E?=
 =?utf-8?B?bEx1YVRCQXEyOWpKblVWaEU3UkE2RE5WaUhQUWp1Qlg5SXZ4aHUwbS91N2tw?=
 =?utf-8?B?VmxURFhvbFZVbXB6SGV5SU10QmpsWW1KQmNubXJIOGNpUEhkOE5PNm44bVF4?=
 =?utf-8?B?eVJ3aE9Xc0kvdExHb1hnVFlFMGlqK25QUFlrNGc2Snl2cXgwZ2YvQVluamZW?=
 =?utf-8?B?Mi85M084MWxyVFJyN2RTb2hRM3ZyVm8rcXRidTB2L3N4TUQ2ZUgxTWZ0ZlJ3?=
 =?utf-8?B?SjNBTDZWdzZnU3pDWW9hbENaWHJJRjZVaTBSRmN2YUI4SUtLdFp2MEtBcXFH?=
 =?utf-8?B?c3Y3OXpHZEx3RldzU1dGSEx3cnVsV2RJcDh0N3hncDlnNHNnZkZudnJZZG5J?=
 =?utf-8?B?RUdaL3NxZ3dMamFVeS8vemFUVTZNeVVxYkNNU1QySDRzdkY4aituNzFQcGZW?=
 =?utf-8?B?bUdnMHRnQzlOZTBUbU4xRThVTmxjMDRnWU1aMzJKOW9zeTNVUCs4ejR3WVNT?=
 =?utf-8?B?Q2Zlci9VYTkvcW8vdk0xZ3hKL0Fab0NtQkkrTHhDSERzd1l3ZTEwTm4zQmhK?=
 =?utf-8?B?L3dPWW5NUmVEWDZjNTdVbmEySTNJSmpVdU9TdnJBSkRvSGNpeUh4MTdFT3Uw?=
 =?utf-8?B?Y28zU3hVQXI4WUpyK1RoY0NURnJNcncvRzZtWkNyMjFxUUF1ZzNxQTFtelgy?=
 =?utf-8?B?RHhyd3FrZHUzVXlDZkxxaXpGUzZnY290akVBL0g1NExTMW5lbFBrbGk1TUtk?=
 =?utf-8?B?cEVadTl0c01RNWJ1OVJnNkFITklCdGI3R1JIUTBhS2ZYblJRakxOTkc5eVND?=
 =?utf-8?B?dG9zV2k1SzIveDBuTnh0alZiaWg1L2hRWkhLOXZnOWE1OEJkdXBYRENyT3Zy?=
 =?utf-8?B?MDF0YkpGSHhNVlY5Zy9KZ01FSXZlMlZ4RHNrOXFOKy9CTklZbUMrRlhRTnlq?=
 =?utf-8?B?NmtjdHp2VngwLzBINkhQTVdtWVhlSThWM3hGK1JWeGszVGlTSDY3RlVVcEdX?=
 =?utf-8?B?Z09xc0JrcnlraHZ6bFdiYjlCZVhXcUlHYVpJbUJRZHV1SmFXWndwU2tOSk51?=
 =?utf-8?B?WjliWXMySW9CbWd4OUJ6bmtaWE9EdmxydS82RnV4cWNlQnI4Qjl0aTlFOFZU?=
 =?utf-8?B?WHlYWUl2U0twWngxd3FocmkzZ0wxNTFmT0RKQm9jYnhOYkdRMkFlcVVpend5?=
 =?utf-8?B?NE5ScGxUa3Bwc1ZuNUJBQ0dyVU1OT09iUWwrZnprR0tDUHdNR01OelBSdS9J?=
 =?utf-8?B?Mm5xOWtOOXFRVXBQb3pjNStxMUpwd2Z6ckl2MnRIVmV5bG9FemhEY08rVFgy?=
 =?utf-8?B?dWFqN1p0MExPWnlaWFB4Sm1rNGVtUVl6ZWtTbGMxdG8vSlIxN1pLQ1d0eUpX?=
 =?utf-8?Q?oTYg8WEU0XRuiuxr7HCmZoCPw?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A26579066892FB479961CCEF11664E99@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b76cb7-d0af-4777-d54b-08dd4cb76eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 05:21:27.6224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HxIeHG8cIRIox/4bum0l18+1TtNEtWw42eoRPiWkVXMNjWvUCcHSvnGCp/E0QCquDOO4xDpwEe42XJupvsP1xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7570

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjM0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbXBsZW1lbnQgdGhlIEF1dG9tYXRlZCBCdWlsdC1J
biBTZWxmLVRlc3QgQUJJU1QgZnVuY3Rpb25hbGl0eQ0KPiBwcm92aWRlZCBieSB0aGUgSERNSXYy
IElQIGFuZCBleHBvc2UgaXQgdGhyb3VnaCB0aGUgImhkbWlfYWJpc3QiDQo+IGRlYnVnZnMgZmls
ZS4NCj4gDQo+IFdyaXRlICIxIiB0byB0aGlzIGZpbGUgdG8gYWN0aXZhdGUgQUJJU1QsIG9yICIw
IiB0byBkZWFjdGl2YXRlLg0KDQpEZXNjcmliZSB3aGF0IHdlIHdvdWxkIHNlZSB3aGVuIGFjdGl2
YXRlIEFCSVNULg0KR2l2ZSBzb21lIGV4YW1wbGUgb2Ygd2hlbiB0byB1c2UgaXQuDQoNCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19oZG1pX3YyLmMgfCAxMjMgKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX3YyLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2hkbWlfdjIuYw0KPiBpbmRleCAzNmI3ZjhkOGQyMTguLmY0YTA4NmI5MmRhZSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX3YyLmMNCj4g
KysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19oZG1pX3YyLmMNCj4gQEAgLTExNzAs
NiArMTE3MCwxMjggQEAgc3RhdGljIGludCBtdGtfaGRtaV92Ml9oZG1pX3dyaXRlX2luZm9mcmFt
ZShzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0K
PiANCj4gK3N0YXRpYyBpbnQgbXRrX2hkbWlfdjJfc2V0X2FiaXN0KHN0cnVjdCBtdGtfaGRtaSAq
aGRtaSwgYm9vbCBlbmFibGUpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IGRybV9kaXNwbGF5X21v
ZGUgKm1vZGUgPSAmaGRtaS0+bW9kZTsNCj4gKyAgICAgICBpbnQgYWJpc3RfZm9ybWF0ID0gLUVJ
TlZBTDsNCj4gKyAgICAgICBib29sIGludGVybGFjZWQ7DQo+ICsNCj4gKyAgICAgICBpZiAoIWVu
YWJsZSkgew0KPiArICAgICAgICAgICAgICAgcmVnbWFwX2NsZWFyX2JpdHMoaGRtaS0+cmVncywg
VE9QX0NGRzAwLCBIRE1JX0FCSVNUX0VOQUJMRSk7DQo+ICsgICAgICAgICAgICAgICByZXR1cm4g
MDsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBpZiAoIW1vZGUtPmhkaXNwbGF5IHx8ICFt
b2RlLT52ZGlzcGxheSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+
ICsgICAgICAgaW50ZXJsYWNlZCA9IG1vZGUtPmZsYWdzICYgRFJNX01PREVfRkxBR19JTlRFUkxB
Q0U7DQo+ICsNCj4gKyAgICAgICBzd2l0Y2ggKG1vZGUtPmhkaXNwbGF5KSB7DQo+ICsgICAgICAg
Y2FzZSA3MjA6DQo+ICsgICAgICAgICAgICAgICBpZiAobW9kZS0+dmRpc3BsYXkgPT0gNDgwKQ0K
PiArICAgICAgICAgICAgICAgICAgICAgICBhYmlzdF9mb3JtYXQgPSAyOw0KPiArICAgICAgICAg
ICAgICAgZWxzZSBpZiAobW9kZS0+dmRpc3BsYXkgPT0gNTc2KQ0KPiArICAgICAgICAgICAgICAg
ICAgICAgICBhYmlzdF9mb3JtYXQgPSAxMTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiAr
ICAgICAgIGNhc2UgMTI4MDoNCj4gKyAgICAgICAgICAgICAgIGlmIChtb2RlLT52ZGlzcGxheSA9
PSA3MjApDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGFiaXN0X2Zvcm1hdCA9IDM7DQo+ICsg
ICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICBjYXNlIDE0NDA6DQo+ICsgICAgICAgICAg
ICAgICBpZiAobW9kZS0+dmRpc3BsYXkgPT0gNDgwKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBhYmlzdF9mb3JtYXQgPSBpbnRlcmxhY2VkID8gNSA6IDk7DQo+ICsgICAgICAgICAgICAgICBl
bHNlIGlmIChtb2RlLT52ZGlzcGxheSA9PSA1NzYpDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
IGFiaXN0X2Zvcm1hdCA9IGludGVybGFjZWQgPyAxNCA6IDE4Ow0KPiArICAgICAgICAgICAgICAg
YnJlYWs7DQo+ICsgICAgICAgY2FzZSAxOTIwOg0KPiArICAgICAgICAgICAgICAgaWYgKG1vZGUt
PnZkaXNwbGF5ID09IDEwODApDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGFiaXN0X2Zvcm1h
dCA9IGludGVybGFjZWQgPyA0IDogMTA7DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gKyAg
ICAgICBjYXNlIDM4NDA6DQo+ICsgICAgICAgICAgICAgICBpZiAobW9kZS0+dmRpc3BsYXkgPT0g
MjE2MCkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYWJpc3RfZm9ybWF0ID0gMjU7DQo+ICsg
ICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICBjYXNlIDQwOTY6DQo+ICsgICAgICAgICAg
ICAgICBpZiAobW9kZS0+dmRpc3BsYXkgPT0gMjE2MCkNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgYWJpc3RfZm9ybWF0ID0gMjY7DQo+ICsgICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAg
ICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgfQ0KPiArICAg
ICAgIGlmICghYWJpc3RfZm9ybWF0KQ0KDQphYmlzdF9mb3JtYXQncyBpbml0aWFsIHZhbHVlIGlz
IC1FSU5WQUwsIHNvIHRoaXMgY2hlY2tpbmcgd291bGQgbmV2ZXIgYmUgdHJ1ZS4NCkxldCBhYmlz
dF9mb3JtYXQncyBpbml0aWFsIHZhbHVlIGJlIHplcm8uDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArICAgICAgIHJlZ21hcF91cGRh
dGVfYml0cyhoZG1pLT5yZWdzLCBUT1BfQ0ZHMDAsIEhETUlfQUJJU1RfVklERU9fRk9STUFULA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICBGSUVMRF9QUkVQKEhETUlfQUJJU1RfVklERU9f
Rk9STUFULCBhYmlzdF9mb3JtYXQpKTsNCj4gKyAgICAgICByZWdtYXBfc2V0X2JpdHMoaGRtaS0+
cmVncywgVE9QX0NGRzAwLCBIRE1JX0FCSVNUX0VOQUJMRSk7DQo+ICsgICAgICAgcmV0dXJuIDA7
DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbXRrX2hkbWlfdjJfZGVidWdfYWJpc3Rfc2hvdyhz
dHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKmFyZykNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgbXRr
X2hkbWkgKmhkbWkgPSBtLT5wcml2YXRlOw0KPiArICAgICAgIGJvb2wgZW47DQo+ICsgICAgICAg
dTMyIHZhbDsNCj4gKyAgICAgICBpbnQgcmV0Ow0KPiArDQo+ICsgICAgICAgaWYgKCFoZG1pKQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKyAgICAgICByZXQgPSBy
ZWdtYXBfcmVhZChoZG1pLT5yZWdzLCBUT1BfQ0ZHMDAsICZ2YWwpOw0KPiArICAgICAgIGlmIChy
ZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+ICsgICAgICAgZW4gPSBG
SUVMRF9HRVQoSERNSV9BQklTVF9FTkFCTEUsIHZhbCk7DQo+ICsNCj4gKyAgICAgICBzZXFfcHJp
bnRmKG0sICJIRE1JIEF1dG9tYXRlZCBCdWlsdC1JbiBTZWxmIFRlc3Q6ICVzXG4iLA0KPiArICAg
ICAgICAgICAgICAgICAgZW4gPyAiRW5hYmxlZCIgOiAiRGlzYWJsZWQiKTsNCj4gKw0KPiArICAg
ICAgIHJldHVybiAwOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3NpemVfdCBtdGtfaGRtaV92Ml9k
ZWJ1Z19hYmlzdF93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciBfX3VzZXIgKnVidWYsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBsZW4sIGxv
ZmZfdCAqb2ZmcCkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3Qgc2VxX2ZpbGUgKm0gPSBmaWxlLT5w
cml2YXRlX2RhdGE7DQo+ICsgICAgICAgaW50IHJldDsNCj4gKyAgICAgICB1MzIgZW47DQo+ICsN
Cj4gKyAgICAgICBpZiAoIW0gfHwgIW0tPnByaXZhdGUgfHwgKm9mZnApDQo+ICsgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArICAgICAgIHJldCA9IGtzdHJ0b3VpbnRfZnJv
bV91c2VyKHVidWYsIGxlbiwgMCwgJmVuKTsNCj4gKyAgICAgICBpZiAocmV0KQ0KPiArICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gKw0KPiArICAgICAgIGlmIChlbiA8IDAgfHwgZW4gPiAx
KQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKyAgICAgICBtdGtf
aGRtaV92Ml9zZXRfYWJpc3QoKHN0cnVjdCBtdGtfaGRtaSAqKW0tPnByaXZhdGUsIGVuKTsNCj4g
KyAgICAgICByZXR1cm4gbGVuOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IG10a19oZG1pX3Yy
X2RlYnVnX2FiaXN0X29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKmZpbGUp
DQo+ICt7DQo+ICsgICAgICAgcmV0dXJuIHNpbmdsZV9vcGVuKGZpbGUsIG10a19oZG1pX3YyX2Rl
YnVnX2FiaXN0X3Nob3csIGlub2RlLT5pX3ByaXZhdGUpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMg
Y29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9ucyBtdGtfaGRtaV9kZWJ1Z19hYmlzdF9mb3BzID0g
ew0KPiArICAgICAgIC5vd25lciA9IFRISVNfTU9EVUxFLA0KPiArICAgICAgIC5vcGVuID0gbXRr
X2hkbWlfdjJfZGVidWdfYWJpc3Rfb3BlbiwNCj4gKyAgICAgICAucmVhZCA9IHNlcV9yZWFkLA0K
PiArICAgICAgIC53cml0ZSA9IG10a19oZG1pX3YyX2RlYnVnX2FiaXN0X3dyaXRlLA0KPiArICAg
ICAgIC5sbHNlZWsgPSBzZXFfbHNlZWssDQo+ICsgICAgICAgLnJlbGVhc2UgPSBzaW5nbGVfcmVs
ZWFzZSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10a19oZG1pX3YyX2RlYnVnZnNfaW5p
dChzdHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLCBzdHJ1Y3QgZGVudHJ5ICpyb290KQ0KPiArew0K
PiArICAgICAgIHN0cnVjdCBtdGtfaGRtaSAqZHBpID0gaGRtaV9jdHhfZnJvbV9icmlkZ2UoYnJp
ZGdlKTsNCj4gKw0KPiArICAgICAgIGRlYnVnZnNfY3JlYXRlX2ZpbGUoImhkbWlfYWJpc3QiLCAw
NjQwLCByb290LCBkcGksICZtdGtfaGRtaV9kZWJ1Z19hYmlzdF9mb3BzKTsNCj4gK30NCj4gKw0K
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBkcm1fYnJpZGdlX2Z1bmNzIG10a192Ml9oZG1pX2JyaWRn
ZV9mdW5jcyA9IHsNCj4gICAgICAgICAuYXR0YWNoID0gbXRrX2hkbWlfdjJfYnJpZGdlX2F0dGFj
aCwNCj4gICAgICAgICAuZGV0YWNoID0gbXRrX2hkbWlfdjJfYnJpZGdlX2RldGFjaCwNCj4gQEAg
LTExODksNiArMTMxMSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBt
dGtfdjJfaGRtaV9icmlkZ2VfZnVuY3MgPSB7DQo+ICAgICAgICAgLmhkbWlfdG1kc19jaGFyX3Jh
dGVfdmFsaWQgPSBtdGtfaGRtaV92Ml9oZG1pX3RtZHNfY2hhcl9yYXRlX3ZhbGlkLA0KPiAgICAg
ICAgIC5oZG1pX2NsZWFyX2luZm9mcmFtZSA9IG10a19oZG1pX3YyX2hkbWlfY2xlYXJfaW5mb2Zy
YW1lLA0KPiAgICAgICAgIC5oZG1pX3dyaXRlX2luZm9mcmFtZSA9IG10a19oZG1pX3YyX2hkbWlf
d3JpdGVfaW5mb2ZyYW1lLA0KPiArICAgICAgIC5kZWJ1Z2ZzX2luaXQgPSBtdGtfaGRtaV92Ml9k
ZWJ1Z2ZzX2luaXQsDQo+ICB9Ow0KPiANCj4gIC8qDQo+IC0tDQo+IDIuNDguMQ0KPiANCg0K

