Return-Path: <linux-kernel+bounces-527025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DAFA40660
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A6F19C1F58
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548E2066D4;
	Sat, 22 Feb 2025 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mNivcsqr";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="W+Z/ehSY"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453372AF04;
	Sat, 22 Feb 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740213237; cv=fail; b=uQZ/eLALMIPkYnWUqSN46KNgfKixqQrgjluMn1MtRbA/LjMagj2arWoW8psloiyoQefkRQDDqVUtXRkYB3Br3daPVgTTLSxS/h5YaO5KIP+QtQMPraMsFmWOW0KGnwL9NN8QAVNtBgd9mknFUTCz0NnEm/ogyrDSL4YxeeAf3jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740213237; c=relaxed/simple;
	bh=XX0aKa2KsPV6Xk8oEYmaaJAtzujSNFwXHBvXnUh64OU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K7e6t3+2Xn/5JfLIwD2olYVuf95+wG0arVUbzm/y5/Ja+Mh9p/lbQvaTjEFG9y1tSt0RqKux7Gf/I6ZTdG60ZjY3T3DZcHDKnwekJPooaD0exUmAZTVlikjVJeasQqSBxgUBvBcoo2vS6MjGohBKD/uMcwtG/GNTnvpHzj9TwqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mNivcsqr; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=W+Z/ehSY; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bb9ee7e8f0f711ef8eb9c36241bbb6fb-20250222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XX0aKa2KsPV6Xk8oEYmaaJAtzujSNFwXHBvXnUh64OU=;
	b=mNivcsqrsvtClhDjxRHpm423QlwFOPraYzbN+fPZ0NQ97NI0W1e5SdFfdoz10NA678A4RpuIXpLyjxotfO00J/pPQnNVfwPiOeuENaLi8SoZ/14zlGvKY2Z+9VytlDJvROJ4Xgsr1Qi8d22rh6CLGYQE+jZDN9nQ+IHktUhkP/I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:f31d87ed-61f0-443d-bea0-cadac0c4723e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:f2621e29-e0f8-414e-b8c3-b75c08217be8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bb9ee7e8f0f711ef8eb9c36241bbb6fb-20250222
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 353459117; Sat, 22 Feb 2025 16:33:46 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 22 Feb 2025 16:33:46 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 22 Feb 2025 16:33:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6gIUXKq3x8V0pnL5nfayG44asO9RNq9NEnwUvZcHIPmnmc6GGkkMt1QEa81ZBdurQAKPGpGpucm7cBz651l1Hl9wv5arJ8G9m3G/bSJILkpBKmgYy+DS1oRx06K8dCJTWy3P6v2CBPanJzA/TBhp3I6icL57p4uZDcUpc3oSiqytsICCRLq6K06k+RqIRvBwWDg7SPpEoMNBoPLkmMQxz8tOD60FhejUx04Ro4hB9FjdR0we7ziuWHvoHMr0CHN76ER0G3sWywQC8NvFTzl6TjbDW8Dfak3hm+kf1V6/Jp+pRz2ItcZHZwORqZfd6Vm0e5t0tFJiTKo1P8SzqbAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XX0aKa2KsPV6Xk8oEYmaaJAtzujSNFwXHBvXnUh64OU=;
 b=Pc4uV0oeTrocyFvbHcq9YraD5iCiGXmxT3tfcAZ5obv9nXywOcNbUHRSpWM45cmLs5DKUpiS56DsiWkS2UojLmiQiYdltSI/sNOHzTrZTxhGxfBSlmCKNX11ujobgxElXzT8nxgxXg8uIB4QBOFrjlhx20OI6B5RKRISC/uLdG4ZEwrz7yIpGBEf+E/gNm9kxhPQVtF2Ut5P7hCwMf8z9kbXfGFY7taLgzwnykDJQweCtMgUbRd+EYLFw/lch9cR2NxcUuDu+wXNgOWSYnCWHFFX4Df0+JGCXvhda7dWBff1nF1AqBIInuqI2V/THwVQC9o9869OsXd0fsnNyiVJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XX0aKa2KsPV6Xk8oEYmaaJAtzujSNFwXHBvXnUh64OU=;
 b=W+Z/ehSYfDSwbq/QIQ7Uic+PS9OZ3RdEtoTUxJh/ALKTLMl/XV2neOics8djrHKogbITbx+6qv+G1a65Z6jtKygr29DY+XyEed4KZd+bbveXqire0D4VrZVsxEm1EdcW740GAaKjf3uNrhnj8FtzR6uMCGn/WSFaGbwBiebkxdw=
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com (2603:1096:301:9d::13)
 by TYZPR03MB7345.apcprd03.prod.outlook.com (2603:1096:400:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Sat, 22 Feb
 2025 08:33:44 +0000
Received: from PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6]) by PSAPR03MB6236.apcprd03.prod.outlook.com
 ([fe80::2b28:30c4:61a8:20f6%7]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 08:33:44 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 3/4] usb: mtk-xhci: add support remote wakeup of mt8196
Thread-Topic: [PATCH v3 3/4] usb: mtk-xhci: add support remote wakeup of
 mt8196
Thread-Index: AQHbf5FODIPLI9TKeUmeOfVo1d4u27NMxxGAgAZCwoA=
Date: Sat, 22 Feb 2025 08:33:44 +0000
Message-ID: <91de8a46de1f41462ea8aab138e47d75f11e17b9.camel@mediatek.com>
References: <20250215100615.808-1-chunfeng.yun@mediatek.com>
	 <20250215100615.808-3-chunfeng.yun@mediatek.com>
	 <7804ef70-efe7-476b-ae5e-bf665bfb4a47@collabora.com>
In-Reply-To: <7804ef70-efe7-476b-ae5e-bf665bfb4a47@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6236:EE_|TYZPR03MB7345:EE_
x-ms-office365-filtering-correlation-id: ab3da345-ba31-46b1-090a-08dd531b9e97
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MTF0aHhFRDJYcUpxeEFReHVaNU9IUXJ2d3VaY1pxUmFRbm9GZzNVOUxLSUFI?=
 =?utf-8?B?SWRSSEFocmxsZ29ZNGJZeU50YklEZGw3STlTUGxISGJRa0lTYnk2Z3JKeUE1?=
 =?utf-8?B?MGErMnFJMDhSRXdOOWJyeVVKdHVPVlNnaEt5Ri9zZEE5aTh4TVdDRlVQeVVU?=
 =?utf-8?B?MUxNcnVkRU5ncFdTUi9qYU8rUWdLUVJnMU42ZlpnbUNrZHVJSCt1a2tZR2I0?=
 =?utf-8?B?R3FFRFFVVmZoOWVOb0lwSlVqTTBJWWlMTlFwM3hBMFdxa2x0aGQyaWtRUWpV?=
 =?utf-8?B?MFc5QWJhSmVzZ2RmMVJvTVJXcXE3Z1ZkdlRyTmJrUW02M2szM0FlSzh1dWE1?=
 =?utf-8?B?SHhVY3AralFZN1E5NHp6NnR1TzFrUGRFZHBJclR1TmJ2UnhOYlVhenZjNGp1?=
 =?utf-8?B?M0NBaE5wMFhYdHRRRS8xK2dmOC9mNzJzNXNwcjlHbVJFNnJaTUNvSEFmRi8x?=
 =?utf-8?B?VXc0MlZZallLVjZaREdQQnAvN2VodUhCb0RRdU9ub0Y2djRhdkplbTJDWjdS?=
 =?utf-8?B?MkFtcCtXNWlRY3R1TlFuUWMxRFJHNDE4Z1g4VHpLYnA3b1N2UE8xVGlRQUhE?=
 =?utf-8?B?RTd3ZDh4OUVsNEFLR243eStFZUEwN2d0SWI0NC9mNHY4Yzgwc3BxdWZTVFFw?=
 =?utf-8?B?Z0JFTjh3UWw2MElScC9JWHIwRytEV1JKbkFiSmhpWUdKZDJ5L0R3QTFQdUp0?=
 =?utf-8?B?Y25SbGtmWXQyYTVVNGo0bGpWcjJyNSt0L3NqaXdyeUpnRWlXakxUUENVS3pr?=
 =?utf-8?B?M1dzd2FsdmVkbk84bDVaQkJXMjFXZmo5TjBtZjR1MTVqRU5ZenFLLzlDdXA3?=
 =?utf-8?B?MmlpaGNNeFg5ZWhDcElSdlFIR2tPQk5pNG12Wkgyb1RJc3RjRTNxZnQvZVBZ?=
 =?utf-8?B?OStJZkVnNTdJQlFTY2gwNnZDTVY0bWRzdGlFOEhHdEZTa2I0R2doK2lLT2s2?=
 =?utf-8?B?U0xJYjZSYXdETUZ1TWt0ZEsrbitOdi9tak5OVjhoOUwxVXFUQkd6azk5aUJW?=
 =?utf-8?B?NnRVT0I1dG0yRVg1aks2eWYvRXNCRVM4U0xobkFiV2lIV0ZjZUc2aUtMTGRC?=
 =?utf-8?B?VndtazViMTF3REhqcU5XcjNpZnM3dWN3ZGVlUmVyOG1lTzd0M05sQTRnM0V3?=
 =?utf-8?B?NUUxcWp2UDhXK1hLSG5XRXd6L2wwdTl1NEpIK1lqZUFHUFErSWhaVHhFOXJE?=
 =?utf-8?B?YUwremJHWUR1YlRCNVhOdVUxMkZRRjlySUxWK1N0cXdDa0ZURUI0UjI5aUQw?=
 =?utf-8?B?TDJXNG5CdHhzQ0dWblFiOG0rbWNNY0tyeStnZ1ZvSmVoSC9NRXRPK3NTbith?=
 =?utf-8?B?OGlFbmQvc0lRVTBueXJrZWF1Q1ByWXZmWC9QMVo5QnRZazdqODNmRDVOcmhZ?=
 =?utf-8?B?dEpROHcvVFB4VFBYZHBQa2xiZ3cyUVcwVjIxam5RZ25VNjVaZ3FaMWowOXJx?=
 =?utf-8?B?YzVYVzVpbTluaHJvVG5lUXZ1MzI2OWRnd1owUUY1c1N5aWZVcTdXVXArY1oz?=
 =?utf-8?B?czhpRFBpU0lZcVZkMVg5aDBDRDJHTFFXak94YW5xRjJjSnpiNFptODdVNUlW?=
 =?utf-8?B?SE5XbFpQRk1RZFkwbXpRMlJick9xRlp5U1lmQ0RyQis4TlJQbktlZ2VJVFNT?=
 =?utf-8?B?Mk91Q1A0RWwveHNhdWo5ZWhldnRjcWswZGJnZEhTdENUM2dUNUZIVFpNVVpW?=
 =?utf-8?B?TG1CbWI2N2tUbWJMaVBJdWhRMEhHcnJYVC9IZlUvRSsyOVNmTDhCZ25UUEJE?=
 =?utf-8?B?OENNckFrbUdkbnYyajFnVTBheGN0cEY5ekhUUUlIeEo2WkNtdjQ0Y0lDejJH?=
 =?utf-8?B?SFZzblo2bXJ2M0hqUkhla1BoU3FoK2s2S0pkOGxvMDlsWEwwSHE0Rnp4UmdW?=
 =?utf-8?B?d2JtS2xocFdoNmdWMmtFa2ZZZGpmdFgwQUJ0Z2NiY1d0ekRVQ3Jpc3Z0WFJT?=
 =?utf-8?Q?xlZvbEUiDZWeEG6onADSl+53og7ZRDRK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6236.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b255ak9JeVJ2bGdBbFR2bk1KdzVWSDgxcGNWTFpkQjBubCttcjQyOXFwbC94?=
 =?utf-8?B?M21nS1N0dk9XOU9sb09KUmtXUXJ2ZlVBL2lNNzVqV1RUM3ppU1dmUC9VWjRp?=
 =?utf-8?B?ZFdEM1RkYVV0UWxuSHJLaW5MNVdCemtWeWpYbDdDRmYyUUNncERjK1NIUGp0?=
 =?utf-8?B?WE82UGd3eE9VOWtkbm5odjFPOTZSczZJUlZlUkk1NnNMb2wxczQ1ODlQTVl1?=
 =?utf-8?B?YWdhbm5yWXdtQ2p2NnpBREpIOTJwcFdqQzFPMlM0UWc1TFNycFEwUUpCU1pE?=
 =?utf-8?B?d3cwNktIVUF4R1h4LyttTU1uV2xqMzR0VDFUdWJ3RlE4RVdUNmZYb1JqeEpB?=
 =?utf-8?B?MmtncXRFR0lqbnVmNldIWGV4aWFuSWxJQjJEM1pSZ1BiWDByZlFjYzg0WDhU?=
 =?utf-8?B?NXdJVTAwYlhETnBKM1h5OHQ1RjlFNnk2eDk2czBGU0Vqb0Z4S0xpeXZqNkgv?=
 =?utf-8?B?SVRhYk83UVVoNEp2YjJua0hjcW51NzY3cTFmY09WdlZocUx5eFZBamR0WkdF?=
 =?utf-8?B?cTgvN0ZIWUE3RnpaaUpKM1VvN3BZanpHZEFISEJxZkRDbEhiU2xuU3dNMmpy?=
 =?utf-8?B?OXNVUTB5S1RBUmlXc2VtYkdHenJqN0lYeEhvakJ2dUsxT2x5cXN5MUNuUlhy?=
 =?utf-8?B?TlJxcHJtMFFYYTRYa1Y4bU0wRnNSWlJobnBBc1dqRTN2bmNrYTU4eDRESGhR?=
 =?utf-8?B?WGpGKzdaMTZrcVpmK21qZVVQNU9INzAxUGt5RXZjZTAwanpNWUNCNlNNbzJC?=
 =?utf-8?B?cDU4UVZXQzN3Y1ZROFVpWjJ6NUZMQmZxdC8zYUVDdHdiSVZPWDU3Y0FXbGxt?=
 =?utf-8?B?d2hxa0taZzRMZzlvdDI2QTBEZEhPL1lTcHZ0dVo0bFZsZ1MwbkN1QVJpODVV?=
 =?utf-8?B?ZUZ2T2ZycDlNNDBLakRtZEc5QmpSeXVyY1duZTJTclFxNVMvRzJZdXc0Q2Nh?=
 =?utf-8?B?bnpTTE1FTEtBU0tQc3c4Nno5K1g3NUpqWnBBcUlxSnZXNXpIR2pKc0Rsc05u?=
 =?utf-8?B?V0ZSRE85cmZTTWVlQUFaeXpRaFd0S2oyNEtOZEVhcXpyZVZwRXk1b3ZaTkdN?=
 =?utf-8?B?UmRxYlh2ZzRocWRWU2VmVjQ3WjgzK25hbGMzaVpremtxNW5LNDc3aHp6QWtC?=
 =?utf-8?B?eXIrOWJqTjZlaWNoMmtFQ3lRd0hOdWdqM05rUFJLRUdVVVBuR1pnWXYySnY1?=
 =?utf-8?B?Y1E5OGkxaTlpeXB2UUU5blprMUQ1Wi92MVhwWG42NnhTYlQ4YnRsOS9CNEdh?=
 =?utf-8?B?MS9BeUtEVzFmOTNwQTR5V2NYeXNIOHhGQTVDUXpHenVCb2hVREdzVU1POTA5?=
 =?utf-8?B?UndmQ2FRRkJkVlcyNjFHcHplWVc3SEVVVHdLN3BIVzJnSkFsQzRiSHBGT2M1?=
 =?utf-8?B?cnZITGhvRFNGZGhpOEk3YmUzQlhlWFV3RjVHd0gyQVYySndGcXM1TzdzTlo3?=
 =?utf-8?B?a25LdG4xa2RGTXZjaTFzVXpaWGxoa0tpQlExWU4wS3ZxdXY1SEcwdjQxdEJq?=
 =?utf-8?B?azl5SEtCSHM4Z2VOb3VYMUNTOGlMVDZrRlJzZ1htSkhHRmRKY05qLzFSV3hR?=
 =?utf-8?B?KzZpV3BpYmZ3TzYvdk8wY05sVlFtS3l1Q3hYTzNhaW5KcFlZOUw2SFoyWTcv?=
 =?utf-8?B?UWlYcnF3K1V0RDBkNjFnSWtyZURTZW8rOVR0aGkyc0ErbDlMc0FhTmJUbnJz?=
 =?utf-8?B?SDhSdmZpSVFSZ0FmeVM0aXlVZm9XblI3QjNzMG41UkVzckdoQ3FjUzJ5ajFt?=
 =?utf-8?B?Zmw0TFJKeTJrVy8yVVZJU3o5UTFRRU5hN3NTSGRYbFBhakVubVlUVUhwUFZq?=
 =?utf-8?B?Qk1hUFFjMXowcXM4YzVQRXAzdnhrdmJSNHl5SHBoK1dvUXprT0pqQVl0SDhX?=
 =?utf-8?B?VlVMNG5OTFdCand3TXZydFhkVXF5SlJSL1l1bjVmOVBQYXBHRjM5U2V2bXgx?=
 =?utf-8?B?RDdBUUtUNlR6NjcrWFBOdXdjRHB0Rml4Z1Ewb2JIamxhd2ZwWjBYV2tZR2VK?=
 =?utf-8?B?UlZ3TC9PdDlEblJJVVE1cUxnZVpGbWJSdkZtendlUXMyT05wb1BnU1RxUUgz?=
 =?utf-8?B?L1ltSWdPcTJ1MVFFS3p5aXpHa1lRc3BoSGhOQlVnZ1hFNkVPL0FpZS9xem12?=
 =?utf-8?B?bVd2cmlKMFJyZUM3QVg2NmJrcmxySit4RjR2aTUwaFNMMHA2RGRuUmp1Mm5a?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B8137A3CC5DD141A8FFB80820CF2A95@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6236.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab3da345-ba31-46b1-090a-08dd531b9e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 08:33:44.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7saa2eEivKKcRzAGImdfkIcLgwrk/NZxEOvEVsMKFEooD/1a2SYi6Lt8a78vWyf3nSRGKEN77BdOGoxoNdcO7mLgLSB7Xe0vgu8mVarEcfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7345
X-MTK: N

T24gVHVlLCAyMDI1LTAyLTE4IGF0IDA5OjU3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNS8wMi8yNSAxMTowNiwgQ2h1bmZlbmcg
WXVuIGhhIHNjcml0dG86DQo+ID4gVGhlcmUgYXJlIHRocmVlIFVTQiBjb250cm9sbGVycyBvbiBt
dDgxOTYsIGVhY2ggY29udHJvbGxlcidzIHdha2V1cA0KPiA+IGNvbnRyb2wgaXMgZGlmZmVyZW50
LCBhZGQgc29tZSBzcGVjaWZpYyB2ZXJzaW9ucyBmb3IgdGhlbS4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IA0KPiBT
aW5jZSBhbGwgb2YgdGhlIFVTQiBjb250cm9sbGVycyBvZiB0aGUgTVQ4MTk2IFNvQyBhcmUgYmVo
aW5kIE1UVTMsDQo+IGFuZA0KPiBzaW5jZSB0aGUgd2FrZXVwIGNvbnRyb2wgZm9yIGFsbCBvZiB0
aGVtIHdpbGwgYmUgaGFuZGxlZCBieSB0aGUgTVRVMw0KPiBkcml2ZXINCj4gYW5kICpub3QqIGJ5
IHRoZSB4aGNpLW10ayBkcml2ZXIuLi4uDQo+IA0KPiBOQUNLIQ0KPiANCj4gUGxlYXNlIGRyb3Ag
dGhpcyBjb21taXQuDQpQbGVhc2UgaGVscCB0byBwaWNrIHVwIHRoZXNlIHBhdGNoZXMsIEkgYWxz
byBoYXRlIHRvIGFkZCB0aGVzZSBzcGVjaWZpYw0Kd2FrZXVwIHdheXMsIGJ1dCBvdXIgaGFyZWR3
YXJlIGRlc2lnbmVyIGRvIG5vdCBmb2xsb3cgdGhlIGh3aXAgcnVsZXMNCnNvbWV0aW1lcy4NCg0K
VGhhbmsgeW91Lg0KDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiAtLS0NCj4gPiB2
Mzogbm8gY2hhbmdlcw0KPiA+IHYyOiBtb2RpZnkgbWFyY29zIG5hbWUNCj4gPiAtLS0NCj4gPiAg
IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsuYyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgYi9kcml2ZXJzL3VzYi9ob3N0
L3hoY2ktDQo+ID4gbXRrLmMNCj4gPiBpbmRleCA5MDQ4MzEzNDQ0NDAuLjNmOGUzN2IyNTMyMiAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiArKysgYi9k
cml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCj4gPiBAQCAtMTEzLDYgKzExMywxNCBAQA0KPiA+
ICAgI2RlZmluZSBXQzFfSVNfUF85NSAgICAgICAgIEJJVCgxMikNCj4gPiAgICNkZWZpbmUgV0Mx
X0lTX0VOX1AwXzk1ICAgICAgICAgICAgIEJJVCg2KQ0KPiA+IA0KPiA+ICsvKiBtdDgxOTYgKi8N
Cj4gPiArI2RlZmluZSBQRVJJX1dLX0NUUkwwXzgxOTYgICAweDA4DQo+ID4gKyNkZWZpbmUgV0Mw
X0lTX0VOX1AwXzk2ICAgICAgICAgICAgICBCSVQoMCkNCj4gPiArI2RlZmluZSBXQzBfSVNfRU5f
UDFfOTYgICAgICAgICAgICAgIEJJVCg3KQ0KPiA+ICsNCj4gPiArI2RlZmluZSBQRVJJX1dLX0NU
UkwxXzgxOTYgICAweDEwDQo+ID4gKyNkZWZpbmUgV0MxX0lTX0VOX1AyXzk2ICAgICAgICAgICAg
ICBCSVQoMCkNCj4gPiArDQo+ID4gICAvKiBtdDI3MTIgZXRjICovDQo+ID4gICAjZGVmaW5lIFBF
UklfU1NVU0JfU1BNX0NUUkwgMHgwDQo+ID4gICAjZGVmaW5lIFNTQ19JUF9TTEVFUF9FTiAgICAg
QklUKDQpDQo+ID4gQEAgLTEyOSw2ICsxMzcsOSBAQCBlbnVtIHNzdXNiX3V3a192ZXJzIHsNCj4g
PiAgICAgICBTU1VTQl9VV0tfVjFfNCwgICAgICAgICAvKiBtdDgxOTUgSVAxICovDQo+ID4gICAg
ICAgU1NVU0JfVVdLX1YxXzUsICAgICAgICAgLyogbXQ4MTk1IElQMiAqLw0KPiA+ICAgICAgIFNT
VVNCX1VXS19WMV82LCAgICAgICAgIC8qIG10ODE5NSBJUDMgKi8NCj4gPiArICAgICBTU1VTQl9V
V0tfVjFfNywgICAgICAgICAvKiBtdDgxOTYgSVAwICovDQo+ID4gKyAgICAgU1NVU0JfVVdLX1Yx
XzgsICAgICAgICAgLyogbXQ4MTk2IElQMSAqLw0KPiA+ICsgICAgIFNTVVNCX1VXS19WMV85LCAg
ICAgICAgIC8qIG10ODE5NiBJUDIgKi8NCj4gPiAgIH07DQo+ID4gDQo+ID4gICAvKg0KPiA+IEBA
IC0zODEsNiArMzkyLDIxIEBAIHN0YXRpYyB2b2lkIHVzYl93YWtldXBfaXBfc2xlZXBfc2V0KHN0
cnVjdA0KPiA+IHhoY2lfaGNkX210ayAqbXRrLCBib29sIGVuYWJsZSkNCj4gPiAgICAgICAgICAg
ICAgIG1zayA9IFdDMF9JU19FTl9QM185NSB8IFdDMF9JU19DXzk1KDB4NykgfA0KPiA+IFdDMF9J
U19QXzk1Ow0KPiA+ICAgICAgICAgICAgICAgdmFsID0gZW5hYmxlID8gKFdDMF9JU19FTl9QM185
NSB8IFdDMF9JU19DXzk1KDB4MSkpIDoNCj4gPiAwOw0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7
DQo+ID4gKyAgICAgY2FzZSBTU1VTQl9VV0tfVjFfNzoNCj4gPiArICAgICAgICAgICAgIHJlZyA9
IG10ay0+dXdrX3JlZ19iYXNlICsgUEVSSV9XS19DVFJMMF84MTk2Ow0KPiA+ICsgICAgICAgICAg
ICAgbXNrID0gV0MwX0lTX0VOX1AwXzk2Ow0KPiA+ICsgICAgICAgICAgICAgdmFsID0gZW5hYmxl
ID8gbXNrIDogMDsNCj4gPiArICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgIGNhc2UgU1NV
U0JfVVdLX1YxXzg6DQo+ID4gKyAgICAgICAgICAgICByZWcgPSBtdGstPnV3a19yZWdfYmFzZSAr
IFBFUklfV0tfQ1RSTDBfODE5NjsNCj4gPiArICAgICAgICAgICAgIG1zayA9IFdDMF9JU19FTl9Q
MV85NjsNCj4gPiArICAgICAgICAgICAgIHZhbCA9IGVuYWJsZSA/IG1zayA6IDA7DQo+ID4gKyAg
ICAgICAgICAgICBicmVhazsNCj4gPiArICAgICBjYXNlIFNTVVNCX1VXS19WMV85Og0KPiA+ICsg
ICAgICAgICAgICAgcmVnID0gbXRrLT51d2tfcmVnX2Jhc2UgKyBQRVJJX1dLX0NUUkwxXzgxOTY7
DQo+ID4gKyAgICAgICAgICAgICBtc2sgPSBXQzFfSVNfRU5fUDJfOTY7DQo+ID4gKyAgICAgICAg
ICAgICB2YWwgPSBlbmFibGUgPyBtc2sgOiAwOw0KPiA+ICsgICAgICAgICAgICAgYnJlYWs7DQo+
ID4gICAgICAgY2FzZSBTU1VTQl9VV0tfVjI6DQo+ID4gICAgICAgICAgICAgICByZWcgPSBtdGst
PnV3a19yZWdfYmFzZSArIFBFUklfU1NVU0JfU1BNX0NUUkw7DQo+ID4gICAgICAgICAgICAgICBt
c2sgPSBTU0NfSVBfU0xFRVBfRU4gfCBTU0NfU1BNX0lOVF9FTjsNCj4gDQo+IA0KPiANCg==

