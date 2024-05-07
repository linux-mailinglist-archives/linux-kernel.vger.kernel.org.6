Return-Path: <linux-kernel+bounces-170781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7CE8BDBF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 08:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500231F23652
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 06:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107F578C9B;
	Tue,  7 May 2024 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XKYIG+1Z";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mR4b8Bs1"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9578C85;
	Tue,  7 May 2024 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715065159; cv=fail; b=orQAQY5wjeH6wS2jWVd73aoI+cTfJhsBa8abS6YSvXJJcf5xV2a+vDdFOzWt6jLjQ0hfJgkgvClwm9Zxv0Xz3ovEII4zlGL47x71z5jsosRbgi6Mq09EsMYw/h4pz/KoZPAO6x3oUXM67J1zINX9iu9N4b8Ot8HGlHxp1woZjSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715065159; c=relaxed/simple;
	bh=AuXq20dsZzG2StDM+33JaG4KffmbKwOZvBKUZlXtuGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/Ckdslc92SC1TgFQZUJp/2djdBD/TmG5j7g8QsvGBil/ohAYTwqTHXdi6E3VRMavBC+r2vNY2d2J46G1MfHnbhIP0zk1bforVDL6KRAoNTVlISBUCr677otAOaep40DfFJTNbvPkS7k3KlHUgDdcA8cAPBl1m2mYPfYjXSyVk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XKYIG+1Z; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mR4b8Bs1; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4bc2e17e0c3f11efb92737409a0e9459-20240507
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AuXq20dsZzG2StDM+33JaG4KffmbKwOZvBKUZlXtuGk=;
	b=XKYIG+1ZhZwGIaJXzO7FFbKuGtRt0J5OG8krc71uiwg+G2nBSPMjjeMVEd9pyFvdFK021I9lY9zbv2qYpyX6F2AX1PZW9YMOImg3PQquBr86enJBK8F/aiiJcmf8iuUvu06GXVhyvMf/r16nyccqdVPD1spyx+vjT7C3PibXCj0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1a61ec53-dac6-402d-88d4-ea61e3c5d106,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:06b68a83-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4bc2e17e0c3f11efb92737409a0e9459-20240507
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1081365709; Tue, 07 May 2024 14:59:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 May 2024 14:59:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 May 2024 14:59:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3zhkwsScwDcwexmINA9fEvdIeABPy3/LAfclkbx6AcXXv6WxPAZh2zLoesfpteayLs5V4Srw4s3h4imk1dViMPB5QUnAbCW/iivXz1xi7P4s+0yLI+fg+24uU9Lwkz3tmPdTOeTm4q4JV1WlOkg30kkfps42dB0Hn88yWS5kMmIoigJlVzsB7lySLQu4TgJH3hXC7LvcRtHtskA4Q0ySN0L29SgFOl1nVelYk+35jMY+Wz+rqzWuzZtWp8IZ8Sz7Yy4nnpGTM485yDwyPDdFVPosHR2V0Wfc9aUU8UTbT+cejewKryILc9gZz6hRE27UGjU0I09Z9XpsxGg/lb6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuXq20dsZzG2StDM+33JaG4KffmbKwOZvBKUZlXtuGk=;
 b=Diyy+R8Z4pBzDL1s+FxbOUlmmxP+i9yf/N4lK/+wvfigFt6F3TqX4cGQ0qzoS0xa6VM1G87IX9RfOx6z+a0uugkuvCqEXmNkqea/P5SOsBm6tZn/ZU3qBRpidsZ5NJ9HZ1ltn3jPXbEK7peNVhBfFLvzwaH5SkueFCuNPsels5uBKOxVVFVVFyh1Uoha5dOR4NcX/6DXCQj3MpMa7BTpNuSvpeSWhAACK6B33zHPaE1BKjdJOu0nbiqU8qKZIN4zTmuWJaXw+c6jQm2zhG4L/SXcEvbvwTDq0G3CsxKNg1hpSyW7Ypo116Z6DKk6usUS6xbrcyU1S/DMLz4AkiWhnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuXq20dsZzG2StDM+33JaG4KffmbKwOZvBKUZlXtuGk=;
 b=mR4b8Bs1PL5O8d4xKS3toY+wsdXnmBLwoaJT8ZU/4PTE5bgDQizMLj7bKW0gKFqC0tyRhhp05xCGSM5dN76ax5lw5iq/eM3b1GKK+iHmrUL8M4QegeOUu1l/2aA4sBdOnV05arGKHP/O5yDwQ3hx1TQm8ZL7pe+yyMIDsTxmMeQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8143.apcprd03.prod.outlook.com (2603:1096:820:100::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 7 May
 2024 06:59:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 06:59:02 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?=
	<Yu-chang.Lee@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Topic: [PATCH v2 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Index: AQHainXPkoeeapgKhkmHjjX1T7SS9LF4WlSAgAtsa4CAB7xpgA==
Date: Tue, 7 May 2024 06:59:02 +0000
Message-ID: <4dfb09b9c437ab2baa0898eca13a43fd7475047a.camel@mediatek.com>
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
	 <20240409120211.321153-3-angelogioacchino.delregno@collabora.com>
	 <aa7e3bcf70383e563a65919f924ec2e5e4cd778c.camel@mediatek.com>
	 <becdc2e5-4a1d-4280-b6f8-78d4903be283@collabora.com>
In-Reply-To: <becdc2e5-4a1d-4280-b6f8-78d4903be283@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8143:EE_
x-ms-office365-filtering-correlation-id: d79a06f7-f694-49c9-8a4c-08dc6e632d64
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OWxzSXl0azBaTDdVQU1COVVuYkIzaTF0dzkzMnhiVFVISjJHa09xclMxaVFh?=
 =?utf-8?B?RCtZZFVVdzdXdVJaTXdRVks5Wm1kajlvUUlMZkpZQ1diNldHYzN0TGpUV0g2?=
 =?utf-8?B?cUo1bkQ0WXlhaEJxZWtadVFHUnJDWkcvamRMeWJjMTl1ZjNQbkFxcTVYUUpW?=
 =?utf-8?B?eVc2TXFnajhPMngzUzVUYWplVldYRVNOM0ZRM1JIZll4OU9hT2lYanFPTytX?=
 =?utf-8?B?RU43NmR2OEp4QjA3dUsvL2hOT3dMNlpPa2JLL0wvZHdXVU5CRVRub2RMMmwv?=
 =?utf-8?B?SW5EQXRSSnEyYlR6SE4vYWZTNTRmNTFGeUIrUkFyRUNMem4wdDA5YWwrUUph?=
 =?utf-8?B?WkNkeW4xN0tzMG5FYjJ0ZlVLVksxU3VPVTRtODFPYkdCemZMUmh3QUxna0lG?=
 =?utf-8?B?ck5PMWdpc1JtekR2eEsxT1l0NGw3UjhxOVFIZlc5U0FST1drQW9jeThGQjFW?=
 =?utf-8?B?NFh6VmFsQXRra2tiaWY1RHhYdEs3MnJ2OUovSkZLTEZCYXFPYmJtbVczeWV4?=
 =?utf-8?B?dXh6WVdYTWtZWi9Eb2VqY2dXN1R4OWxnU3p0OHlsN1hDWDgrcy9zZVNjcUVi?=
 =?utf-8?B?QUt2WWo2bU51K2YrWWNFak9ZeEw2alp0WFpySTBiMVF2ejR6dFhUYm5XcG5U?=
 =?utf-8?B?M0wvQmpVaGlBa00yaCs1N21rNTR2RFhSS1BPaXl4MS9leWszT0k3SDEzdklS?=
 =?utf-8?B?TEdrN1g1YW9WZllNRUdzTjJlNGZydXlmc20vbU9sbndPM0orYld3SVVSbGpD?=
 =?utf-8?B?SmFXNDlhOHgrR20vT3NKcGNURlZtc3F3S1pEMjBBSUszY0RxM21HNWkyOWJr?=
 =?utf-8?B?QTlhbDFWenF4MjhkUGlTL3plNmxhKzVLMGx5bzhZNmtnWk5SZ3V6V1Z1aWRL?=
 =?utf-8?B?Y050L1dMbnAwd2JscktCM0lpM3JXTWtVMFZVQ2xZaGlmNDlFODVyN3J5a3ZX?=
 =?utf-8?B?R1FiNml5RVd2ZDlUYW13ci9xOGdiajY0UHdrK0l4TDF2dFVOZ2I5VWdXSWc1?=
 =?utf-8?B?VVRDRVFjcTVsSlFST1IranU2ZmZZU2lpdVdMY0JCZmF5ZHV6ZDc4T1FKTTVk?=
 =?utf-8?B?cUd1Z0ZMQTd1YUJuN3lMSExpK29EV0xJa1RRRzNhK3Z5bnUwak5TUk9LRVEw?=
 =?utf-8?B?NWd4MERiK25ONHZCanJVT3NnQkN1eWc5cUNadm9tLzJUTFcxYjdGOTNORnpn?=
 =?utf-8?B?d0MyVDlRU1pWc2h2cWwvRmdscUtvSWp6RmVrMHZOUk02NXh6a0xyaGljL2pj?=
 =?utf-8?B?Vlh6NlJYWk44dEVha0hYNlI2MFRjNWlwSmxCb3VMbGY2dlB5ZTErcVpZM0Fa?=
 =?utf-8?B?SzV3MDRRSEVaWjBlbjl1ODJoQVRMT2VLLzkwOHhWUHo2c0VMSk96MkQ1ODRS?=
 =?utf-8?B?NkNCMzRxejhNSTh1eXZ6SHZsOFNZYWhkNDlGSmF6QzRWQld1N3pTL3dJT1Zx?=
 =?utf-8?B?cmd2aVE1QVhza1lJR05pTUxIejRtWDhQZ2VrcmR0RzQybU83cW5IMTUvM1pI?=
 =?utf-8?B?VCtyazFDcVVhSlVYRTBURHRMQ1dvbng2YW9IYWZQRTEwVXBtcnVxYUhTQk5Y?=
 =?utf-8?B?cDFhV09nRnpkLzhFeGUyNmoyWk1PZmFkbEpXREdJN2dSSDV3SmZhZWwwMEcz?=
 =?utf-8?B?aGdtUGp6c0pMTVZzbHFnUTQ3Rjc0Z1lMWVdSOGhpZWU2dDVVNHR4bnQ0dzRl?=
 =?utf-8?B?YnM3MXFid00xYU5uM3g4QmFFWHg5YTF0QkFSbGZXTStKVHg4NERrbWNXenBD?=
 =?utf-8?B?WUxrQy9iaHRicWJ4MVlIU2JTWFZoSTU3Z3htbWEyVHpZTndFRU9TOUZkL0Q5?=
 =?utf-8?B?dUtJMDdDS2FHc3VJS2tMQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWUrRGFSaDh4azlYK1MwRjBjT2VTbTN5OU02eFY0N2gzWGV0OE9KcTYzQmZX?=
 =?utf-8?B?UEpyWU5pRDFXSVpkMHhNUzNENm9LQW01MHQxRVlDVEQyU2NFdmwrYkdjL0x2?=
 =?utf-8?B?RWZmZ2Y5MFhYQjI3OEl6U0lXRm9USzR3NE5LbVh6eEx6MEZqbHlCWjFieTZs?=
 =?utf-8?B?SFpsVEVmRWp5QmxHTGNxbWZBVGlqOFNXd295SWNoRm8xdXliNnFhaE1MZlI0?=
 =?utf-8?B?VmF3MlJJaW5nSW1rU1h6RXlXWWt3STkwNFJKeThZcThSZUlHMW8rN3hacWtU?=
 =?utf-8?B?YitxVG5iempSbWZYbEE0OFVyNzRPOG45Mk1mK2dKOFZYdkFSYTBONnZuR0d1?=
 =?utf-8?B?WVcyeWpaODNxY1VDbERGcHJVWGNISEZVdWxXdkJkNEVMaGFVUEUwOTBiWHlH?=
 =?utf-8?B?RW1LeGxCeTNpVVAwTkJ6MDQzSVh1T09JeisxalB0U1hEc1dxZDMwdTd0UnpS?=
 =?utf-8?B?WkViZG9uN3lralFIQklURXR2c0hmUUNwa1Q5cG9WaHFUNmx6eHV4Sk5veFFp?=
 =?utf-8?B?bWxkd1FHYW5XY2s4WWo1bUxTeEtPcDh1d2xVRklheG1GWUladGZLaVZjYlN6?=
 =?utf-8?B?c1JvazRYK25rb1lTL0ROdGgzejIxMWpzbzV3eEREbmlZT2RHVEF6d1B3TlE3?=
 =?utf-8?B?M3BPZkc4MlVqV01sVmc3dVNnTHViVkRvVGZaZVNEUnptOWRFam9sNU5OZ0ti?=
 =?utf-8?B?RktTUkhUaGtWWU5LRlZBSHhiNitmWWJBSWRTY2J0TlBqaENIU0NHamg5cEsy?=
 =?utf-8?B?aFBxdE1HcTliWjVHMm5Eamp1VXJFZGtydjNFM2pucnhiUlNzeHJLTFkyZFVX?=
 =?utf-8?B?SGp1QVE0SXFnK3FERldjay9vYVo0bDBjeDY2aEtJVG5waFZCTWpWenR5OWgz?=
 =?utf-8?B?VTg0TTZkQ0toUit2NEdlL2ZtblFTUWlydThIU0JYQWhMVlNGL3lOdElZZDVY?=
 =?utf-8?B?SmJJandWYkxwNjYzSjM1OHlqRGhsdVlKdGRmU1lxQTB2Q1B5bjhJMWl2NjU5?=
 =?utf-8?B?SCtWeDRKZVU1TisxYUZ6Q2NlK3B0ek9VajdvTW53MWtPMlZyOEQ5aTlNUU5F?=
 =?utf-8?B?MlpsRnlyRDY3T291eVRYVTQrSjFrWHpVL0o1bGcwWWZNSkRKZW9HazlSWFpT?=
 =?utf-8?B?NVhNYWFsOHNENVAwZWxmakJLRnBpd2dlb1I5NFU2WnZES0pwUmNVK2xZK3g1?=
 =?utf-8?B?cHBVaTlYM2ZOQVVGOGRINm5NVXZIZ0p0NGcySTNxRHI0SmV1VjY1cE1sMTEy?=
 =?utf-8?B?ckFKaS9sY3pyZlhtN3lZaG5QZ2x6QlBWNnBqOWwvNnJuOEtNNFFndUtGejlW?=
 =?utf-8?B?eEhGU1kwck1MTFpTOHpVaTUrYno0MTdEaUVmNFMrQ2RHK1BoL01YTHgybDN0?=
 =?utf-8?B?QVVXcnA5b0xRYTdaTGY5M0t4RXQrTldCN1Q3enpNUXI2My8rQmdaV3JrT2cw?=
 =?utf-8?B?TG8wTW9rZENHaFMwaFJSbWl4UWQ2ZHNpZTY5NlduUmV5YXR3dmI5WTNkTDBk?=
 =?utf-8?B?YXRrcGM4bVVDZUNrV212ZzBOaG5MM0w3eGw3VFNWaFZLMVArbnErV0FGelow?=
 =?utf-8?B?MlVqbDBpMEpTSXVGMnJPU0xZd3pBZlBlYng2em0wdDRZM1NQWUdEYzR0ZnMv?=
 =?utf-8?B?VVVUM0JLRWlBclZCL3dGdEFjMWJ1WjcraXpDTEFteHlEcVZVTFM4ZlkxbmxX?=
 =?utf-8?B?MjkyT1BBNXlFYXZ2NU5pT3A2dkpENEkwa29kQ1NoaklzZFQvUkJKYjlTOUpS?=
 =?utf-8?B?NTA1U3pjMUZzejdnRWt6Rituc2REN2tlVlpJMk5pSkk4aVgrd3ozL0xhVm1v?=
 =?utf-8?B?VTBYM2gxc2xaQ09FUGEzTmhvcU9DTC9sU0JrZytycTQ1dnBlRE5TUUQ1Q0R5?=
 =?utf-8?B?em1wOFl3SEg4alZKY2xJSUt5UE56OVE4TjB2OWZORytESTRRN285SnVTY2RR?=
 =?utf-8?B?ZWFSMVB0N2kydEZRaTB3Qy8wNzA0dnBzL2tJTldJN1dCY1NXVXRLTGd3OE9t?=
 =?utf-8?B?ZlpER1l2ODZwaERpS1VkZXAyOVlkcWtqOW9YenF1ZDJyWXJDTVE5SDV6VnFU?=
 =?utf-8?B?WW9WYnlQU2RmWnRWSUkxem40RUNmMVRNQy9hNy9LSTBrejkvQndGV3IrcmZp?=
 =?utf-8?Q?Jux6P/5fQie6FuT/lHSD5+g7h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F611EE2A5FD33745B81F33B802DAA126@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79a06f7-f694-49c9-8a4c-08dc6e632d64
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2024 06:59:02.1809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zS7vBhVKjJOF/EKUChAHp2s9jm/zSHKdxFAuynuGPIvj0vWfCNjJVyLQP6BghyfhAdodJ2e+zoXcvMYLyzZ+WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8143

T24gVGh1LCAyMDI0LTA1LTAyIGF0IDEwOjUwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjUvMDQvMjQgMDQ6MjMsIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNj
cml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjQtMDQtMDkgYXQg
MTQ6MDIgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gd3JvdGU6DQo+ID4g
PiBEb2N1bWVudCBPRiBncmFwaCBvbiBNTVNZUy9WRE9TWVM6IHRoaXMgc3VwcG9ydHMgdXAgdG8g
dGhyZWUgRERQDQo+ID4gPiBwYXRocw0KPiA+ID4gcGVyIEhXIGluc3RhbmNlIChzbyBwb3RlbnRp
YWxseSB1cCB0byBzaXggZGlzcGxheXMgZm9yIG11bHRpLXZkbw0KPiA+ID4gU29DcykuDQo+ID4g
PiANCj4gPiA+IFRoZSBNTVNZUyBvciBWRE9TWVMgaXMgYWx3YXlzIHRoZSBmaXJzdCBjb21wb25l
bnQgaW4gdGhlIEREUA0KPiA+ID4gcGlwZWxpbmUsDQo+ID4gPiBzbyBpdCBvbmx5IHN1cHBvcnRz
IGFuIG91dHB1dCBwb3J0IHdpdGggbXVsdGlwbGUgZW5kcG9pbnRzIC0NCj4gPiA+IHdoZXJlDQo+
ID4gPiBlYWNoDQo+ID4gPiBlbmRwb2ludCBkZWZpbmVzIHRoZSBzdGFydGluZyBwb2ludCBmb3Ig
b25lIG9mIHRoZSAoY3VycmVudGx5DQo+ID4gPiB0aHJlZSkNCj4gPiA+IHBvc3NpYmxlIGhhcmR3
YXJlIHBhdGhzLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8DQo+ID4gPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5j
b20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgLi4uL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRl
ayxtbXN5cy55YW1sIHwgMjMNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdA0K
PiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21l
ZGlhdGVrLG1tc3lzLnkNCj4gPiA+IGFtbA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnkNCj4gPiA+IGFtbA0KPiA+
ID4gaW5kZXggYjNjNjg4OGMxNDU3Li40ZTlhY2Q5NjZhYTUgMTAwNjQ0DQo+ID4gPiAtLS0NCj4g
PiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRp
YXRlayxtbXN5cy55DQo+ID4gPiBhbWwNCj4gPiA+ICsrKw0KPiA+ID4gYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tc3lzLnkNCj4gPiA+
IGFtbA0KPiA+ID4gQEAgLTkzLDYgKzkzLDI5IEBAIHByb3BlcnRpZXM6DQo+ID4gPiAgICAgJyNy
ZXNldC1jZWxscyc6DQo+ID4gPiAgICAgICBjb25zdDogMQ0KPiA+ID4gICANCj4gPiA+ICsgIHBv
cnQ6DQo+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvcG9y
dA0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiA+ICsgICAgICBPdXRwdXQgcG9ydCBub2Rl
LiBUaGlzIHBvcnQgY29ubmVjdHMgdGhlIE1NU1lTL1ZET1NZUw0KPiA+ID4gb3V0cHV0DQo+ID4g
PiB0bw0KPiA+ID4gKyAgICAgIHRoZSBmaXJzdCBjb21wb25lbnQgb2Ygb25lIGRpc3BsYXkgcGlw
ZWxpbmUsIGZvciBleGFtcGxlDQo+ID4gPiBvbmUNCj4gPiA+IG9mDQo+ID4gPiArICAgICAgdGhl
IGF2YWlsYWJsZSBPVkwgb3IgUkRNQSBibG9ja3MuDQo+ID4gPiArICAgICAgU29tZSBNZWRpYVRl
ayBTb0NzIHN1cHBvcnQgdXAgdG8gdGhyZWUgZGlzcGxheSBvdXRwdXRzIHBlcg0KPiA+ID4gTU1T
WVMuDQo+ID4gPiArICAgIHByb3BlcnRpZXM6DQo+ID4gPiArICAgICAgZW5kcG9pbnRAMDoNCj4g
PiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvZW5kcG9p
bnQNCj4gPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBPdXRwdXQgdG8gdGhlIHByaW1hcnkgZGlz
cGxheSBwaXBlbGluZQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgIGVuZHBvaW50QDE6DQo+ID4gPiAr
ICAgICAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL2VuZHBvaW50DQo+
ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogT3V0cHV0IHRvIHRoZSBzZWNvbmRhcnkgZGlzcGxh
eSBwaXBlbGluZQ0KPiA+ID4gKw0KPiA+ID4gKyAgICAgIGVuZHBvaW50QDI6DQo+ID4gPiArICAg
ICAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL2VuZHBvaW50DQo+ID4g
PiArICAgICAgICBkZXNjcmlwdGlvbjogT3V0cHV0IHRvIHRoZSB0ZXJ0aWFyeSBkaXNwbGF5IHBp
cGVsaW5lDQo+ID4gPiArDQo+ID4gPiArICAgIHJlcXVpcmVkOg0KPiA+ID4gKyAgICAgIC0gZW5k
cG9pbnRAMA0KPiA+ID4gKw0KPiA+IA0KPiA+IG1tc3lzL3Zkb3N5cyBkb2VzIG5vdCBvdXRwdXQg
ZGF0YSB0byB0aGUgZmlyc3QgY29tcG9uZW50IG9mIGRpc3BsYXkNCj4gPiBwaXBlbGluZSwgc28g
dGhpcyBjb25uZWN0aW9uIGxvb2tzICd2aXJ0dWFsJy4gU2hhbGwgd2UgYWRkDQo+ID4gc29tZXRo
aW5nDQo+ID4gdmlydHVhbCBpbiBkZXZpY2UgdHJlZT8gWW91IGFkZCB0aGlzIGluIG9yZGVyIHRv
IGRlY2lkZSB3aGljaA0KPiA+IHBpcGVsaW5lDQo+ID4gaXMgMXN0LCAybmQsIDNyZCwgYnV0IGZv
ciBkZXZpY2UgaXQgZG9uJ3QgY2FyZSB3aGljaCBvbmUgaXMgZmlyc3QuDQo+ID4gSW4NCj4gPiBj
b21wdXRlciwgc29mdHdhcmUgY291bGQgY2hhbmdlIHdoaWNoIGRpc3BsYXkgaXMgdGhlIHByaW1h
cnkNCj4gPiBkaXNwbGF5Lg0KPiA+IEknbSBub3Qgc3VyZSBpdCdzIGdvb2QgdG8gZGVjaWRlIGRp
c3BsYXkgb3JkZXIgaW4gZGV2aWNlIHRyZWU/DQo+ID4gDQo+IA0KPiBEZXZpY2V0cmVlIGRlc2Ny
aWJlcyBoYXJkd2FyZSwgc28gbm90aGluZyB2aXJ0dWFsIGNhbiBiZSBwcmVzZW50IC0NCj4gYW5k
IGluIGFueSBjYXNlLA0KPiB0aGUgcHJpbWFyeS9zZWNvbmRhcnkvdGVydGlhcnkgcGlwZWxpbmUg
aXMgaW4gcmVsYXRpb24gdG8gTU0vVkRPIFNZUywNCj4gbm90IHJlZmVycmVkDQo+IHRvIHNvZnR3
YXJlLg0KPiANCj4gQmV0dGVyIGV4cGxhaW5pbmcsIHRoZSBwcmltYXJ5IHBpcGVsaW5lIGlzIG5v
dCBuZWNlc3NhcmlseSB0aGUNCj4gcHJpbWFyeSBkaXNwbGF5IGluDQo+IERSTSB0ZXJtczogdGhh
dCdzIGEgY29uY2VwdCB0aGF0IGlzIGNvbXBsZXRlbHkgZGV0YWNoZWQgZnJvbSB0aGUNCj4gc2Nv
cGUgb2YgdGhpcw0KPiBzZXJpZXMgYW5kIHRoaXMgZ3JhcGggLSBhbmQgaXQncyBzb21ldGhpbmcg
dGhhdCBzaGFsbCBiZSBtYW5hZ2VkDQo+IHNvbGVseSBieSB0aGUNCj4gZHJpdmVyIChtZWRpYXRl
ay1kcm0gaW4gdGhpcyBjYXNlKS4NCj4gDQo+IENvbWluZyBiYWNrIHRvIHRoZSBjb25uZWN0aW9u
IGxvb2tpbmcsIGJ1dCAqbm90KiBiZWluZyB2aXJ0dWFsOiB0aGUNCj4gc2Vuc2UgaGVyZSBpcw0K
PiB0aGF0IHRoZSBNTS9WRE9TWVMgYmxvY2tzIGFyZSB1c2VkIGluIHRoZSBkaXNwbGF5IHBpcGVs
aW5lIHRvDQo+ICJzdGl0Y2giIHRvZ2V0aGVyDQo+IHRoZSB2YXJpb3VzIGRpc3BsYXkgcGlwZWxp
bmUgaGFyZHdhcmUgYmxvY2tzLCBvciwgc2FpZCBkaWZmZXJlbnRseSwNCj4gc2V0dGluZyB1cCB0
aGUNCj4gcm91dGluZyBiZXR3ZWVuIGFsbCBvZiB0aG9zZSAoUC5TLjogbW1zeXNfbXR4eHh4X3Jv
dXRpbmdfdGFibGUhKQ0KPiB0aHJvdWdoIHRoZSBWRE8NCj4gSW5wdXQgU2VsZWN0aW9uIChWRE94
X1NFTF9JTikgb3IgT3V0cHV0IFNlbGVjdGlvbiAoVkRPeF9TRUxfT1VUKSBhbmQNCj4gd2l0aCB0
aGUNCj4gYXNzaXN0YW5jZSBvZiB0aGUgVkRPIE11bHRpcGxlIE91dHB1dCBNYXNrIChWRE94X01P
VVQpIGZvciB0aGUNCj4gbXVsdGlwbGUgb3V0cHV0cw0KPiB1c2VjYXNlLCBib3RoIG9mIHdoaWNo
LCBhcmUgZGVzY3JpYmVkIGJ5IHRoaXMgZ3JhcGguDQoNCkkgYWdyZWUgdGhpcyBwYXJ0LCBidXQg
dGhpcyBpcyByZWxhdGVkIHRvIGRpc3BsYXkgZGV2aWNlIE9GIGdyYXBoLg0KVGhlc2UgZGlzcGxh
eSBkZXZpY2Ugd291bGQgb3V0cHV0IHZpZGVvIGRhdGEgZnJvbSBvbmUgZGV2aWNlIGFuZCBpbnB1
dA0KdG8gYW5vdGhlciB2aWRlbyBkZXZpY2UuIFRoZXNlIHZpZGVvIGRldmljZSB3b3VsZCBub3Qg
aW5wdXQgb3Igb3V0cHV0DQp2aWRlbyBkYXRhIHRvIG1tc3lzL3Zkb3N5cy4NCg0KPiANCj4gVGhp
cyBtZWFucyB0aGF0IHRoZSBWRE9TWVMgaXMgcmVhbGx5IHRoZSAibWFzdGVyIiBvZiB0aGUgZGlz
cGxheQ0KPiBwaXBlbGluZSBzaW5jZQ0KPiBldmVyeXRoaW5nIGdldHMgZW5hYmxlZCwgbWl4ZWQg
YW5kIG1hdGNoZWQgZnJvbSB0aGVyZSAtIGFuZCB0aGF0J3MgaW4NCj4gdGhlIHNlbnNlDQo+IG9m
IGhhcmR3YXJlIG9wZXJhdGlvbiwgc28gd2UgYXJlICpyZWFsbHkqIChhbmQgbm90IHZpcnR1YWxs
eSEpDQo+IGZsaXBwaW5nIHN3aXRjaGVzLg0KDQpJIGFncmVlIG1tc3lzL3Zkb3N5cyBpcyBtYXN0
ZXIgb2YgdmlkZW8gcGlwZWxpbmUsIHNvIGxldCdzIGRlZmluZSB3aGF0DQp0aGUgcG9ydCBpbiBt
bXN5cy92ZG9zeXMgaXMuIElmIHRoZSBwb3J0IG1lYW5zIHRoZSBtYXN0ZXIgcmVsYXRpb25zaGlw
LA0KbW1zeXMvdmRvc3lzIHNob3VsZCBvdXRwdXQgcG9ydCB0byBldmVyeSBkaXNwbGF5IGRldmlj
ZS4gT3IgdXNlIGENCnNpbXBseSB3YXkgdG8gc2hvdyB0aGUgbWFzdGVyIHJlbGF0aW9uIHNoaXAN
Cg0KbW1zeXMtc3ViZGV2ID0gPCZvdmwwLCAmcmRtYTAsICZjb2xvcjAsIC4uLj4sIDwmb3ZsMSwg
JnJkbWExLCAmY29sb3IxLA0KLi4uPjsNCg0KDQpBbm90aGVyIHByb2JsZW0gaXMgaG93IHRvIGdy
b3VwIGRpc3BsYXkgZGV2aWNlPyBJZiB0d28gcGlwZWxpbmUgY291bGQNCmJlIHJvdXRlIHRvIHRo
ZSBzYW1lIGRpc3BsYXkgaW50ZXJmYWNlLCBzdWNoIGFzDQoNCnJkbWEwIC0+IGRzaQ0KcmRtYTEg
LT4gZHNpDQoNCldvdWxkIHRoaXMgYmUgc2luZ2xlIGdyb3VwPw0KDQptbXN5cy1zdWJkZXYgPSA8
JnJkbWEwLCAmcmRtYTEsICZkc2k+Ow0KDQpPciB0d28gZ3JvdXA/DQoNCm1tc3lzLXN1YmRldiA9
IDwmcmRtYTAsICZkc2k+LCA8JnJkbWExLCAmZHNpPjsNCg0KSSB0aGluayB3ZSBzaG91bGQgY2xl
YXJseSBkZWZpbmUgdGhpcy4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IA0KPiBDaGVlcnMsDQo+
IEFuZ2Vsbw0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gDQo+ID4gPiAgIHJl
cXVpcmVkOg0KPiA+ID4gICAgIC0gY29tcGF0aWJsZQ0KPiA+ID4gICAgIC0gcmVnDQo+IA0KPiAN
Cg==

