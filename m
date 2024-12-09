Return-Path: <linux-kernel+bounces-437046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9EB9E8E67
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1359E1885E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B9821571A;
	Mon,  9 Dec 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RTNHYc7Z";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="e7tciIeZ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC01EB3D;
	Mon,  9 Dec 2024 09:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733735383; cv=fail; b=N7diBln1bMHulgPlHB3t805isk9aOvSf2a2V/SjJEoYHHf1teNZaWffmF3snkLyVTuH4AYd4Q/xAO5djtKUQjF0WWVhshsw9ptp2GJu9hIHzr1U1qYzI6JDIX6DXnShvpRrJX43JsulBCPk28Vd+h26S5BX5uGop2u7Wf0gYRi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733735383; c=relaxed/simple;
	bh=bWfwm9Zgm/v0lrY39yo2HAO7uOpofyDvaSRtdn95hSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7AtLqh5TfMTzB5pTpiacx6H9Z3ET3j6CpCNTuP/RfVW7UT/GXGqk9JbSaPuHtWPZAxuHcMwhoBVwA2AXwyze2eBh8VSnvMpxDXY2NmHkKXubAj0UCRJwcLht0Aj50dU3JffHgnr+EgHhZGdydbbRFj3lWAi/8HeP03R/1bmKVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RTNHYc7Z; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=e7tciIeZ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4169b892b60d11efbd192953cf12861f-20241209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bWfwm9Zgm/v0lrY39yo2HAO7uOpofyDvaSRtdn95hSg=;
	b=RTNHYc7ZYcpeVbRiZZVtxTH79yGGNUzUFPqJ0TYdO7QVqanhcXTMXlrw7srDpYWH/LiGqX6gxQ//JqibH7+i5I6OHjAwq0FHmp28nSw6y5lx4+lol0nIacT7gtSZ//v0sgliR+W2xYjckbf7dsehNeEtoeWSmxopThc2wFY1R6c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7fb36d8e-2c07-4c20-9bba-909dba9b6e2a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:8260aa3b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4169b892b60d11efbd192953cf12861f-20241209
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1983328994; Mon, 09 Dec 2024 17:09:12 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 9 Dec 2024 17:09:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 9 Dec 2024 17:09:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ww9zWalflSRgRprMI3FYLVYKoe54AOPmNEV4uoxQSklJawMOofgJ8h+mWzlmbOLLGm/ZRGzp5CfGKopPvM7jkmeH4bURmw+x7svDT44zjzJUIo9O1S+IcVWa/lFAAWPxm7Yloi/L0rmDQiKCrTgb5oQV0HJj4KCMsOJzVHqOeJyBFSoxiCVX1v6bslTSmYFZXqJP7F4NstQ0+z+WALGxyTFwzLOvtU+qMMMStnkar7t1N+6Xcuj6x1qn4Zm1G3MUkUH0cymz0ozKJVh2YJjyNwPu/6kaneXkjT9AWYb1nacxaPw/veOGaEy0n2kKdotNyllqk3GEvFISJZNwp6BPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWfwm9Zgm/v0lrY39yo2HAO7uOpofyDvaSRtdn95hSg=;
 b=IF9IL4E333iid8LFyTQ2kMtLHAlKGBQmfq3IBXoRaGtIK5BwJyKQjLhalzAhdn4KfXp9WNJ48YpFZ3r4YfnzCID5+J8m8DJaoy1zh8nMmb2akPVf1+XVCaEzaVrZ6aaNe7BaoOsz+jexEtCSbeGn7w5kl3tHAaukyU/UAXtfdWqI3QzClqv3ekg8mUQrjnBc/MV1rrNragCXq+++1/XB2T9BUgyUoxAGMp6jkqhlNimjTTFpBzaA2i20sZdD+DTzR5NbbesKZghQvQZ06ijJgG3yY+VorjnAifgAf5PfICi8OEs9jAfvgE3G14YPujIQ7kDmm8G/P7POwu2f74sOrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWfwm9Zgm/v0lrY39yo2HAO7uOpofyDvaSRtdn95hSg=;
 b=e7tciIeZ63kr7cIPcUd8LRPMCaoMo9UQlu9lH0mCoqVnTeUb3biU0m+K0YPGEIiewkDj89kPqbvykFczSB0CGXGcGn5SSkNKkXDjXHkSFhtNhGCBTUaR3MCk+kSwOfkIadhDpbA9+Qy+SCnjla2vqJsSKczWxy10CTkD+PJ0THg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB6885.apcprd03.prod.outlook.com (2603:1096:301:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 9 Dec
 2024 09:09:06 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Mon, 9 Dec 2024
 09:09:06 +0000
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
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v2 14/15] drm/mediatek: mtk_hdmi_common: Add OP_HDMI,
 vendor and product strings
Thread-Topic: [PATCH v2 14/15] drm/mediatek: mtk_hdmi_common: Add OP_HDMI,
 vendor and product strings
Thread-Index: AQHbRwt4xV/d1hvrLUKjHjxK6fEG0rLdpeeA
Date: Mon, 9 Dec 2024 09:09:06 +0000
Message-ID: <6697eef88677950d36fbfbd6676f82f291621159.camel@mediatek.com>
References: <20241205114518.53527-1-angelogioacchino.delregno@collabora.com>
	 <20241205114518.53527-15-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241205114518.53527-15-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB6885:EE_
x-ms-office365-filtering-correlation-id: 116573e2-3b21-48ec-1184-08dd1831224b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T0NJdW9kWmxpTmpCUEJWT0d4a0hXd0MvS0RNMjZ6RTlzcmorQkpHdVE4cXFI?=
 =?utf-8?B?VVJhSmxZNnhpV3lhLy9iY2tXRXAyREFkb1Blc2VVNGx4dENINUtmQ0xXOWlJ?=
 =?utf-8?B?SGl4dXYvYWRwa2p5YmI0aVpSTldvUitNeG5oTU00SzRtbVBhVVNMdFVDZkdu?=
 =?utf-8?B?c0REYTFxdGFiaTBNU010WWpWTkdKQzYzWjJiTkRtdUM5Um1taTh5RzVzWDgy?=
 =?utf-8?B?TW51YjFFRWJPb1pIZU5MM1JGNldNM2NqZzJPZTcxT3VOQUFwU2pzenZlZWR3?=
 =?utf-8?B?cktJWG9CaEMySFdLaG1KY3krS3pxamVWMDdwTXc0a0xEWVNQWWRnd0RjeXM1?=
 =?utf-8?B?aWI1emlHUjg0Wi8rcnNqOXZNUjlqTnJQVGtPVlVBT1FzbnpHWGhrOWtVdVhx?=
 =?utf-8?B?MDJkNTkrSGEydXhyWktNbnNybGxJcjNOZitNVzNqWlh2aHFYd2p2d1BqVjZR?=
 =?utf-8?B?b2U2K1FLU1YwdENEUmxFMVhRNGpQODhVcTNFZDN3WmVwTkYxUDhiWGVBNFBZ?=
 =?utf-8?B?RGNQRUhwbytxMzM5RmpLMEtXVXhWNUptMVM0b0oxY1RrT254cjdFdDVIMW9G?=
 =?utf-8?B?K0daYm9WRzlESkwrd1dxT0xPcW10eHdjRVpzTktIOURkV25vaXpwa0VIWkt4?=
 =?utf-8?B?R3dRR2NDbEJNMmhsQlcvY05iN2p2UVRTWUFwMlNreVlyUno5Vy9tcUozVmZG?=
 =?utf-8?B?RVllT0E5dXFhUXFLNjVXcGp0UG15dFBoSGloRjJ3UXlIM05kWHFUdXFDSXoz?=
 =?utf-8?B?a1pSLytDNzNpT0NmaWxEeGwrcHRWSUM5RHdxbDJqWGtLcFJGZm1neWQrc05C?=
 =?utf-8?B?R0V3Y3FvdElwVVk5ZXVyaGtKNUg2ay9qaHYybjQ4Z3VyMndUTnh3Q0c4QkVV?=
 =?utf-8?B?NkJrRUg5aVZhM2gyajhtVzROWUtKM2pvZWNsQmVNWjEvN2R3TFJSYzM0M1FM?=
 =?utf-8?B?Zk4vZFFLZzBnOW9tZkRVUVFBNG5IMmVIU2NxL0xBMFp2TDVVdjQ3M2pNbTE2?=
 =?utf-8?B?d041VENJU0RFamd4MHRSRzQ1a0FaSGxId0ZYTUhiNWwyR1JhRm05OE5BUWNl?=
 =?utf-8?B?VWlVWHErVHJZVXhrZXJBbWErQ055OHFyaWhJbHprVFJRZ1JLN1Z4eXJZb3VG?=
 =?utf-8?B?U2NKUnRBY1RuWXA0RlhZekZhc1VpdW5UbWIyMDY0dnFrU3ozRTRHZ215THFV?=
 =?utf-8?B?cXpzUkxlZk5hTVNzQzRjNk5EazBHeFU2MHpIcUIvZUJtdzZ5QnRCb082NlEz?=
 =?utf-8?B?Tzh2dXFwc3B3SVkrcGVJU3ZvaFVta0kweFdpU2dDaWZWTHY5RXErUlQ5Q3hG?=
 =?utf-8?B?dzRSM1hEdGFCazJCQTZrSEJhdTA0Z3ZYNjFYUitKajgvYmNwRDdUTEk1N1ov?=
 =?utf-8?B?aWgwcDFKSVhwTHJmaFdMN0R5bE50TFhwR2NWY21rKzk4UmNMcWxXRmxLRkpF?=
 =?utf-8?B?WHdBUGJaTlJ6NGVaZFZaVFcwM2RPVWwzMWU2RDlKU3hjbHBhR203ZlpBN2x1?=
 =?utf-8?B?SEx2Rzd3NnZVU0drdG9GSklwTzhnK25uWG9ybXJkYU01UVBZWTRucCtVV0JG?=
 =?utf-8?B?MTBycHUrV3VFaiszcE1BV1F2bVFPbVZNWHJ6V1hoWXU0N1puMVdZQ2dMY2Fz?=
 =?utf-8?B?Q0ZaeG5IVStzWHVwTm5jelZzZzVMU3FPMEpQZEFhb0Rjd1BjdVFWbzF6MG1O?=
 =?utf-8?B?Sk1oeHJ1bmhvTlBCalFrT05QdzhtVTA4OERoYm1BdjlWa3FBbllyYm5qeWVv?=
 =?utf-8?B?Z0ZwNkNyR2JiRFVBSzZwaFpLSnA2SE5XOGZBRllVemNLaWpGSEN1VTNMVEFu?=
 =?utf-8?B?cTdqNmdFcFVDcXhFaGpxSnJwaUhqYXJsOWlldzJQYzhJMFMxTjgwdmJKNmds?=
 =?utf-8?B?U0ZXVHF0eUtqd0kxa056TFcvN3E3Ylc2aFRndmVmTFNOOWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUlEamI5QmNpZ2Y3cmV0SFhPZnRNVTlGWEVFQXdUdHE3WTdrM3BzV0dVTzlt?=
 =?utf-8?B?ZVJvWlFVaVhFa3JiWkJ2aEU1dis1RDNiVFBCdFJCZ1lhaG1kRGN1Q2EzaG5u?=
 =?utf-8?B?M05QSDB5cmo1elpHK0UyWnNzYmRnZUxnMlU4a0RsRWg3b0Y4T1FNSkluNDFQ?=
 =?utf-8?B?S1VHaHpORDJNQ2kvZ2N6Rk10RXBqT2UyTGt5aHRva3Y2UUNwcm1YanFCYnZP?=
 =?utf-8?B?REVpVUFBa0JicTQzdjUrZDdhaE9PRldrYUZlTUJxSW9ueVBtcVFPTWxJcVVF?=
 =?utf-8?B?ekpxMkowOWVHYU5DT29rSlF1Q3BGYmRMNk00dG5ORnVmWVB1eWRBMXFoV3Ev?=
 =?utf-8?B?TjNtUHBDVFREbUFqbzBMSzdhTkMzbDVBUnkzNTEyeisrZWsrUmg0QkZkSXNP?=
 =?utf-8?B?K3VhbzJqRmZ2ZTVTM1dmc2dyTTA0RzU4bFk2a25FLytjMjVtMnYzaHlabjda?=
 =?utf-8?B?S0FIeXAxeCtzZVh6WHdPMjNsNU5INUlsclRrUUJPRUFCaUIwakZ4bVdTTUVE?=
 =?utf-8?B?ZFdEaC91djdLemZyblNONEorUm0wc1VmYW83cklSSFk4YTNQZTZBRXd0SnVJ?=
 =?utf-8?B?TkZ6U05jNUJMeStaYVRrVEdydncxKys5c2JFKzU5ZVdSK1lRQTh1Rm5oWXJH?=
 =?utf-8?B?Y3VjY254clY2T1U3eGV2TW4vSjg4clhVbklKbWExNzNuVkFnbCs5S0lPd0pP?=
 =?utf-8?B?ejVWVVFBaDFqbkFhZDRjMmd2YzlCZDR0RW9JM0pLYVBjWGJ2SG94MUY3QXZ3?=
 =?utf-8?B?QzUwakE4c3JZQkoxakQ1TFpqQlpJZnJyOXhBTjJ6WGVWU0h4b2VaWTZEdHF5?=
 =?utf-8?B?Z25DR2xrK0hhWmJyVGRpbWFhenFUUzFXWTZGOTBSUnBQcFNJMVRNbCswWWxW?=
 =?utf-8?B?ZWdqYUF0MzhDZ2Q1QSs1NFNhc1lOdEVXVWZ5WTdoNWVURkJmQSt4SDBHTTNN?=
 =?utf-8?B?ZkJsS2tzMzRtaVJyZzlIM2N3Smhtamxua2hwWTZSUUtjNjFKQytPMEJtNmdM?=
 =?utf-8?B?V2tjQzRjdkozNlBKRXZibUgxbllxNHcvV3BTVVdrV3pqdFBnYmlpT2NTNTNj?=
 =?utf-8?B?RWQ0ZG5JMFRaQkFObUFmbkp6bEd1aUU2UlNvbnZ2SmEwNGsrSld5NktyNFJF?=
 =?utf-8?B?dmhXcGhWQWZocHNMZGpvSzEzdVZXLzNuOWpZY0tUM292d0loQ0tPNXlJUzlo?=
 =?utf-8?B?L1E0aEtNbThlT2l3QzQrbVpXQzNROXlLUXJxNkZlYUpldVI5bDdnY21PZDFN?=
 =?utf-8?B?NlgyRFcrTitBejltMTZZdEo1NXZSMVVFZWF4MlJjRUQyRXAyWWlNdTdsbzM1?=
 =?utf-8?B?N2k5NVhOVDNDNjZRME05T1gwdnJDTkc1N1ZjZGJ1Q0FOemNIQnU2Zm5LS1BD?=
 =?utf-8?B?YkVJYjRiRVhjcVVYTS9INGgrYnBUbEdST1k0R3ZNYjBlOTYrOUttYWw1NEtK?=
 =?utf-8?B?WUYrbkFoZUU3WFRJclMzaFRNYjFPUTJidGZFQmZaK1FieXBSREVPT2h0NGh5?=
 =?utf-8?B?cnpvTkRxZzBrRHNFd3BJZG4yQm5IWnU0SDVMSkQvUWtMZS92NlVhYi95THFH?=
 =?utf-8?B?YktJYkpnL1lKRGFnUDNmLzgyb01KU1hzaDBVS2hMTk42QlBIRE1YL0IydFFK?=
 =?utf-8?B?N0ZteVRaQ0RqY2NCdkticVNKK01tQlNUWWJVNklqbFovZjhtN2FqWmFZNkxI?=
 =?utf-8?B?UWdVRGg0Y2ttaHZydjZUQlFjUVdJemRGaHc1cWtlbTUvOWlBc3NMclU1V1hH?=
 =?utf-8?B?UlN4bDNKdThxWnpVRG9nSWlqNW1pdjBzZ1IwdzRMSjNRbldLV05wRzZBQnlI?=
 =?utf-8?B?dDI1cm45NEVvMVZwV1FlU1hrakdEanBGV0cyL1dCUzBzWlluM1RDY0hLN2Jn?=
 =?utf-8?B?a0puN0s1Z3pFNFZJT1B2dmJqZ1FJSEh1MytXb3IwQXJDc3h3NkVqZUdkakds?=
 =?utf-8?B?UEZwS2hBTFlWeTNEL09iL3hjaWdzNzI2ekt6RHBaWUJ5QUFSR2ZjZENBM2xM?=
 =?utf-8?B?WG1BaUtERDJSZERRRnZpNjNHNnNPYnFGeGFZTkQ1YmdlVFVMUlRrQk1Odlc2?=
 =?utf-8?B?OTM4ZXZwckRrMGs4dC9wZUY1Q1pmaXBrQmJ5bzVJRytVOG53cElXR2NPSisy?=
 =?utf-8?Q?LsofDUjvGnOuzQntK8ZLlq3lu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A47F07249782B14F9E7E18BE421BC440@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116573e2-3b21-48ec-1184-08dd1831224b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 09:09:06.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuwTsCWWDcuUUO0ndZMDOE10jzDM+OmikUmE14Er7umvXMKrDNHC5ND0/rE58uX5t1L9fKUDfUwwVlcAj1cUGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6885

SGksIEFuZ2VsbzoNCg0KT24gVGh1LCAyMDI0LTEyLTA1IGF0IDEyOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIHRoZSBIRE1JIFRYIHYyIGRyaXZlciwgYW5kIHRvIGFsbG93DQo+IGEgZnV0dXJl
IG1vZGVybml6YXRpb24gb2YgdGhlIEhETUkgdjEgb25lLCBwZXJmb3JtIGNoYW5nZXMNCj4gdGhh
dCBlbmFibGUgdGhlIHVzYWdlIG9mIHRoZSBIRE1JIEhlbHBlcnMgcHJvdmlkZWQgYnkgRFJNLg0K
PiANCj4gQ2hlY2sgaWYgdGhlIEhETUkgZHJpdmVyIHByb3ZpZGVzIHRoZSBmdW5jdGlvbiBwb2lu
dGVycyB0bw0KPiBoZG1pX3tjbGVhcix3cml0ZX1faW5mb2ZyYW1lIHVzZWQgYnkgdGhlIEhETUkg
SGVscGVyIEFQSSBhbmQsDQo+IGlmIHByZXNlbnQsIGFkZCBEUk1fQlJJREdFX09QX0hETUkgdG8g
dGhlIGRybV9icmlkZ2Ugb3BzLA0KPiBlbmFibGluZyB0aGUgZHJtIEFQSSB0byByZWdpc3RlciB0
aGUgYnJpZGdlIGFzIEhETUkgYW5kIHRvIHVzZQ0KPiB0aGUgSERNSSBIZWxwZXIgZnVuY3Rpb25z
Lg0KPiANCj4gTW9yZW92ZXIsIGFzIHBhcnQgb2YgZGF0YSBleGNsdXNpdmVseSB1c2VkIChpbiB0
aGUgY29udGV4dCBvZg0KPiBIRE1JIGJyaWRnZXMpIGJ5IHRoZSBoZWxwZXJzLCBhc3NpZ24gdGhl
IHZlbmRvciAiTWVkaWFUZWsiIGFuZA0KPiBwcm9kdWN0ICJPbi1DaGlwIEhETUkiIHN0cmluZ3Mg
dG8gdGhlIGRybV9icmlkZ2Ugc3RydWN0Lg0KPiANCj4gSWYgdGhlIGhkbWlfe3dyaXRlLGNsZWFy
fV9pbmZvZnJhbWUgcG9pbnRlcnMgYXJlIG5vdCBhc3NpZ25lZCwNCj4gdmVuZG9yIGFuZCBwcm9k
dWN0IHN0cmluZ3MgYW5kIEhETUkgaGVscGVycyB3aWxsIG5vdCBiZSB1c2VkLA0KPiBoZW5jZSB0
aGlzIGNvbW1pdCBicmluZ3Mgbm8gZnVuY3Rpb25hbCBjaGFuZ2VzIHRvIGRyaXZlcnMgdGhhdA0K
PiBoYXZlIG5vdCBiZWVuIHJlZmFjdG9yZWQgdG8gdXNlIHRoZSBuZXcgaGVscGVycy4NCj4gDQo+
IFRoaXMgYWxzbyBtZWFucyB0aGF0LCBpbiB0aGUgY3VycmVudCBzdGF0ZSwgdGhlcmUgaXMgZWZm
ZWN0aXZlbHkNCj4gbm8gZnVuY3Rpb25hbCBjaGFuZ2UgdG8gbXRrX2hkbWkgYW5kIGl0cyBvdGhl
ciBjb21wb25lbnRzLg0KDQpPUF9IRE1JIGlzIGZvciB2Mi4NCnZlbmRvciBhbmQgcHJvZHVjdCBz
dHJpbmdzIGlzIGZvciBib3RoIHYxIGFuZCB2Mi4NClNvIHNlcGFyYXRlIHRoaXMgcGF0Y2ggdG8g
dHdvIHBhdGNoZXMuDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdl
bG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJv
cmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21t
b24uYyB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24u
YyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfaGRtaV9jb21tb24uYw0KPiBpbmRleCA0
ZjcwOGIwNGY1ZTguLjBmNjA4NDI0NjJiMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19oZG1pX2NvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfaGRtaV9jb21tb24uYw0KPiBAQCAtNDA4LDkgKzQwOCwxNiBAQCBzdHJ1Y3QgbXRr
X2hkbWkgKm10a19oZG1pX2NvbW1vbl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiANCj4gICAgICAgICBoZG1pLT5icmlkZ2UuZnVuY3MgPSB2ZXJfY29uZi0+YnJpZGdlX2Z1
bmNzOw0KPiAgICAgICAgIGhkbWktPmJyaWRnZS5vcHMgPSBEUk1fQlJJREdFX09QX0RFVEVDVCB8
IERSTV9CUklER0VfT1BfRURJRCB8IERSTV9CUklER0VfT1BfSFBEOw0KPiArDQo+ICsgICAgICAg
aWYgKHZlcl9jb25mLT5icmlkZ2VfZnVuY3MtPmhkbWlfd3JpdGVfaW5mb2ZyYW1lICYmDQo+ICsg
ICAgICAgICAgIHZlcl9jb25mLT5icmlkZ2VfZnVuY3MtPmhkbWlfY2xlYXJfaW5mb2ZyYW1lKQ0K
PiArICAgICAgICAgICAgICAgaGRtaS0+YnJpZGdlLm9wcyB8PSBEUk1fQlJJREdFX09QX0hETUk7
DQo+ICsNCj4gICAgICAgICBoZG1pLT5icmlkZ2UudHlwZSA9IERSTV9NT0RFX0NPTk5FQ1RPUl9I
RE1JQTsNCj4gICAgICAgICBoZG1pLT5icmlkZ2Uub2Zfbm9kZSA9IHBkZXYtPmRldi5vZl9ub2Rl
Ow0KPiAgICAgICAgIGhkbWktPmJyaWRnZS5kZGMgPSBoZG1pLT5kZGNfYWRwdDsNCj4gKyAgICAg
ICBoZG1pLT5icmlkZ2UudmVuZG9yID0gIk1lZGlhVGVrIjsNCj4gKyAgICAgICBoZG1pLT5icmlk
Z2UucHJvZHVjdCA9ICJPbi1DaGlwIEhETUkiOw0KPiANCj4gICAgICAgICByZXQgPSBkZXZtX2Ry
bV9icmlkZ2VfYWRkKGRldiwgJmhkbWktPmJyaWRnZSk7DQo+ICAgICAgICAgaWYgKHJldCkNCj4g
LS0NCj4gMi40Ny4wDQo+IA0KDQo=

