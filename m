Return-Path: <linux-kernel+bounces-188509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BFA8CE2D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 749661C20F74
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD14129E8F;
	Fri, 24 May 2024 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qTDtnbAE";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="n9WwgqDY"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB60129A93;
	Fri, 24 May 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541355; cv=fail; b=f8OJA5wjvj3oTg7Jz+sBuBbPXQrBshmsFJccnB9WF+V1vvDT2MUnqI9r0+xVPd9O7DjOddMNHU07IoP5xsTknJp1KbM/WeFijEmhXrCxA9f14htblxGOiZNO8Z/Dlwrjk1YDCFkrt4F1KazndjlZgzKDglk3aVw7CBI2nevCihM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541355; c=relaxed/simple;
	bh=/HdSAjTj8prAQkdxDjV55wU2g9z8tXr33eIQwQpac5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c4MyY8wj/1k3pEXyrgcz4j9uiAk3BfWLTnjd/YJy6u/pUlC01uY462dzdBAt9RcDf3A6ee7SNEZ6SfyM3oUBrNV0KUJmT75jPvh9hu6VoRDkZRE3uGTj+VCjEvtFaDsMCAqbt6k2sj3EPTPDz1iXlaRhcrc5237/8uBVZ4bOC4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qTDtnbAE; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=n9WwgqDY; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5786414819ac11efbfff99f2466cf0b4-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/HdSAjTj8prAQkdxDjV55wU2g9z8tXr33eIQwQpac5Q=;
	b=qTDtnbAEoR5iIZawnUYlutISQMjMTfaSUJeKuP4Oxb2e0D/xqm3PgdN62JDg5Yd8HwU2GaHIRwuEhrexY5Bd/MZpRrKONhaEQh/VaviKmgTk9GHJRVflAkiujuP3ow/1qy9eOU4rc+dEN+iehFtaN3fIBdXN20QLT2S5kAL/goE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:ca24190a-e3b7-46fb-8f19-9dddfd7a0da3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:ef774484-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5786414819ac11efbfff99f2466cf0b4-20240524
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 30735448; Fri, 24 May 2024 17:02:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 17:02:24 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 17:02:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggQBlzWh5DI9w6fi6KybLyMTMLXFrcStch1UOpM2yzVA6vyKv2MEuPwB3PUHK01R6rdRPd+f6biyokX4YBsl5xJmvIC7cJ+s3ZS2rIpAcPimmIUnNy5Pn/Afp1Uap3PVfxqBzUd3+GPE+6zzAZZQAyCg8IppefL9ZMLu9VcRbRQLgBz+tyD0aOKpqKBPqLzO/8lp4hY9Kf7Ap/KAP5HHNCcL66I/qsge3tj55Rdlf8Uyrl+uMxOOZmolcWmjmXiWRjyMIH2JMP65Z2EOUbfgaO8Xnug2QRe+hfjKOevJSQDjEUgwvpwF5Vq159HJXF3DJB8uTA2dBDoqaSphjKnqMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HdSAjTj8prAQkdxDjV55wU2g9z8tXr33eIQwQpac5Q=;
 b=U6G8vttUMxDbCUNO1mAazudKjt8kP6wI+oPP5PNlWHFs5t6Fu5gIfWeDsA9+WSl7AvZ+CFG0zN79+CUbdVDLzths0/b3pXW640gjlg9V1nZFZebdWpscOKltKp64sfSU0FHPyQ0ljKcJmLBJHpcbOstnGaGoZfmNNNDx3BrCDc53AYaodxYJC/d7dheMIF5dqANxqR9txCDVgQkSEA553TzqhQV8BQ+lfP+RB3u60cSmNH17f4033JUv5lhZ6ZFzk6C84ZbK+5dCVXNwAwoOuqQNSWtd/XVL1VH/Xp2VRZQaUqGmpndRFvsvZM61cGxIQbjmFadZviKWOPpJbwTN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HdSAjTj8prAQkdxDjV55wU2g9z8tXr33eIQwQpac5Q=;
 b=n9WwgqDYmbLTvY3qrivhZ1jEEApGWzCpsbV7zybdAbYgv2T8mQzUGvC0jJUUCx9wQQv0B6IHFksaCLQOTMgRPOXccBIekDOgO7NCRpCpmiu3EFta0atnyAVGsTWxiDmTVzJ1tG3RK1GH6vPX0OYVHGQVEuKZwhEmY7AZ7NVVCFI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7610.apcprd03.prod.outlook.com (2603:1096:990:18::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 24 May
 2024 09:02:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:02:22 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "amergnat@baylibre.com" <amergnat@baylibre.com>,
	"robh@kernel.org" <robh@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 07/15] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
Thread-Topic: [PATCH v4 07/15] dt-bindings: display: mediatek: dpi: add
 compatible for MT8365
Thread-Index: AQHarQ/IYNDozH0Rm0a6uOkzB4InUbGmGA0A
Date: Fri, 24 May 2024 09:02:22 +0000
Message-ID: <4348c01cdf3737d1dabdc22263aaee9f30469fab.camel@mediatek.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
	 <20231023-display-support-v4-7-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-7-ed82eb168fb1@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7610:EE_
x-ms-office365-filtering-correlation-id: fa9933e5-6ae6-44de-9ca4-08dc7bd0395c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?YmMxTzR4eTFmZERRUGFsblkxeUsraExNMjVCY0xmd3dobGMrUUVVNE9sbWtN?=
 =?utf-8?B?Z3QxUW5YanpmdjRhamJ5MGxESXlNYXNGR0w4WFJkWlUwdS9tZDRXMW5GaXdS?=
 =?utf-8?B?ZHJZMFdCQmM0TW1LM0pYWUM3MURMK0lQR2dyempoNEdhdVozdERObDk1OW5K?=
 =?utf-8?B?cFdSR3FQbVFaTnZUbTBlLy9HemNCd2dGSjhHa3ZrQUJFMlZpeW9hQTlXWTB4?=
 =?utf-8?B?M3gralFVY3FXcXRDY1h2OUJWOEZWME1rN1VwbXlnaklTTDVRdVZhSmhYSW1D?=
 =?utf-8?B?ZkhyUGY0blViL1kzZXJtUWpNUis0cEZXKzZtZitpOHBreVp1d2dMTGlsZGQz?=
 =?utf-8?B?QTF2bDZhbWZZVm4vVWg5MlZpK01ML0F4eW9WOHJORGlWT3FvZkNsMnBIV0Fr?=
 =?utf-8?B?NkpydnNsWnhHb2k3bjgxVlVMa0daQUhnMU4xV2pybUlxbmkvMThISWhMcXpw?=
 =?utf-8?B?YXJOM0Frd3ZXeHZoYWNtME8yOFV4c3pLUWJJajA1d2VrSlVyYkJhTzhFdmJX?=
 =?utf-8?B?R1ZPanN3T1pIbHpxSVozV0p0TlErdmxZV1NzWFJaQXZRaDNUU0hraTNDSFhP?=
 =?utf-8?B?YVFjM2kxbnIwdXlJUXhXRDcvUWFDQXMxNnJOeFp3Mkd3VGl1SkhmNUhrVmpq?=
 =?utf-8?B?TW9LSEZDVGxRMGxhS3U3dFNzeFdxSHZpK0xHZjFWQmJzalg4VDJCekNPK29P?=
 =?utf-8?B?K0M0b25WWHUwU1RIV0RvWTB4SXJMbitXMVB2Q21yTHR1QWpLNnFEcEhVZWI2?=
 =?utf-8?B?VUZwV0tGME42RTkrZ0VoR2JqTGNNZGNPbmpWMUNWdkdDTTBuMkRQbnpPcXhK?=
 =?utf-8?B?RytGS050VFdwcVdCRCt1eW14ckd3YUZBZEZQTS9RdDVhQ0p0d01mQ1A3S2lE?=
 =?utf-8?B?WHlJWDM1QUh0QjhYYkk0U1NmRTh3bTBMUWdnSmNjRXY5WnNTd29NcUdHTVds?=
 =?utf-8?B?UlVMM29GWkNxeHYyL2JyeU9OQ1ZjNEF0WXdpb1QrSk5BeERYc0lhaU1CVXFF?=
 =?utf-8?B?bGs3WmFDbnlDUmRmSWl5ZDd1UG40WUNhTUM5VVZzTzRqUndqNy9GRnVBNmRa?=
 =?utf-8?B?SjVrTE5OMU1kL2ZrTGIxL0xUYlF5YVVsUlEzVXNtTC9WYVBxZFhJUkZ0amow?=
 =?utf-8?B?REU3aWVxNXZGUlUxWDUySmZrdFZlS3ZBbWovaVdMRHVwenZTejlZQlJzay9G?=
 =?utf-8?B?R2t2VlhEL0IzbzU5QVJ3K3R5SE1uejB0RERNM3NXVXpUUTJvY21xd2JYeldk?=
 =?utf-8?B?VENjalhKWXpVUEFvN1JmM2lkR2NmRGdTb3hzalovVXVEK2xDZU1tMGlwTlly?=
 =?utf-8?B?Y3pRQTg0OEkzaHJFUWR4TEY1TWFud005amVFYXV1WGpvTkphVlkvWGE3TU5K?=
 =?utf-8?B?MUdpN2thYW1GR2x3L2g0TkxzV2ZQMDhMNVcvb2l2RnR3WCtwQ1A3T3ZKRk93?=
 =?utf-8?B?OG0rdmYrNmNWaEpPYWpHSlN2QVF1Q1JKUnBVL3BvZlZmNGJwSHJlTkVmeEFG?=
 =?utf-8?B?dCtPbksrU1JobGlUZG0rdzFGamtiUnlvUjlqZHZlTFFtV0pmOStCSzlVRlVt?=
 =?utf-8?B?d010TCtZMEE4TjZTK0NBQlVZTzhiM2E5MVdMRUNKcXA0ZERCNVFGSTJ1TXlP?=
 =?utf-8?B?d0hzQldvcXBEMVlEYWdNclhmSG9FSHFhUHB5aTlZUnJob1BNblBoVlNQTVgx?=
 =?utf-8?B?NUNWN0N6ZVNqSkpXd1J4S1EzMGE2dE1jRm9UZktEbnFZRjBKWUo4emJxd3dM?=
 =?utf-8?B?L1p0cnNOUS9jM2d3TDRML1JnMUtNbjBBNUFzS2l5MWljUWRhWjJySFNJbVlW?=
 =?utf-8?Q?fP3ciU3lkXriNPammHuZcE89GBwvcezXZ8Dcs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU9STnJWN3k2WkhKSmlNakZRYkVEa01YUHA4aGx0R2pZT3d6TXI0R0dVTVI4?=
 =?utf-8?B?M1RUQ01FNzhmRVVqOVpsMDhkbXpERURKZ0Z4Q3lmb2puOFVjalEvRWdhWDJz?=
 =?utf-8?B?UzRBSHBkeWFlVitGSFZ6L2tNTXNyaWQyaHhpcHJEbDBXSHJzMkJCRk9JM0FJ?=
 =?utf-8?B?Zzg1eVh5cXFKN1VsYkFteEFkZEtvMUQwZzFWb09XM2xRNHZxaVZwelAwMGJk?=
 =?utf-8?B?UFBjS09NSFYyemhMeXEyYmthU3N2VkxZMzh4T2UvWkRENkhITzF3VkovZUxh?=
 =?utf-8?B?MkdQci9YdUZIM1dpNk9kNnN5YTNKKzVHN2NJT0c4WHI3VW5ETW5BeUlQSUZY?=
 =?utf-8?B?VWFSbDA0blMybHRRUEtjMjVuM0xPa0RNRDhvWEo5bms2aHRYWkt2ZmgzRDlm?=
 =?utf-8?B?dEVqQi9DaDBzdytrRFhQcDNueWEyS3VMVnNwbVRlSDh5UWpHRThwWjhpSlY3?=
 =?utf-8?B?clRIZG5pdW5KZ0tBOUZ6VFJVb25HOUR0V0xORUN4Y0YzSVpsamIweFBuZEla?=
 =?utf-8?B?MHVHQ0MvQzNjUG83dS93RkZxNHVKb0NnR1BJdFdSdmptM242TXhVR1hQS0Jx?=
 =?utf-8?B?bk5ZL0ZSN2dETnFJN28rWHlTWDZBZ0dSVHRFVnJXOHdxNlUxbnUxaUl5bm5I?=
 =?utf-8?B?RzVEa2RxV0UyK3dyVnA4ZC9DS1MvWEFZR21NOGdBZXFPVnl5T09tZTF0ZFh0?=
 =?utf-8?B?ekhuZE9KUGUvbk9OcnF3Mk9DMGNCcWFPdkUwYWxST0J3RWJlWFFNTy9qcXlt?=
 =?utf-8?B?T1gveEV5S2ZEVjErR09vWG1uODFUa0NwU1Rxc0hleXQwNUxicUd4ckNCTFNY?=
 =?utf-8?B?dHJHMmt1cUtLb2Q2aUlZUUZMV0NzUGVWaGZVckNWT3pqU0h4b0FQZGFiT3hQ?=
 =?utf-8?B?V2J2bVQvUFVaVk5Rd09SZ1NkNEVXcTBOTUFZTXo3OUVYcHdmUk44azBoRlZ3?=
 =?utf-8?B?L2oySGtxYnovM2NEa0YvTFVhaDNSRzUvWXltdFpMTWFvbGJqYlhtQlJUeTBZ?=
 =?utf-8?B?TUhrNmo2M3FIT1F4RzN5RFBnL3drcGVhOVNHWVowalFEWFB2SjJtZmg5TVdx?=
 =?utf-8?B?OHVMcjh1Y0lIbnNpdXQ4bG54VWNvejNMZnJYZUU0VXZvTUpHbS9hWklWbFBa?=
 =?utf-8?B?eW8xU1pGSmU2ZVdwenBTTmpBZlBHZDJUbHdPZS9JdUd4WnZFeFJJUGdLcCt0?=
 =?utf-8?B?U0VYandGdlAzaklFTVo2NFNrZkZ4TE02UWlGRDRnNTlrZ3A0eXcxL2RvUExs?=
 =?utf-8?B?dUw2Z3F1VlRDY21YdENkNEdnK0tsV0V4TXlRSFVnaDc0Y1FEMHo2VERDUGll?=
 =?utf-8?B?VG5SNldQTkdVU0djWEZkVng4K0dIWklIcGVERkU3WFM3dTl3OGhNdk9TRkhM?=
 =?utf-8?B?UEcxVUxvVW1yNml0dkhaTmtGQXhvRWlKVHc1TFpSYVY1c0dQR3NZakg4Q3JK?=
 =?utf-8?B?L3c3RWwwWDNvUDBsK1dFZHB5SEVxSzFQV2dBTmlnK0g3dThnTGg0RXVBd0lP?=
 =?utf-8?B?a0FrUWhuc2FyU1pmY0lKZDl4bCt1Wk9pOW1hZUJUODUyRXZmU2tEeGVrVUdx?=
 =?utf-8?B?eFM3SFh2N2JVeitMd1czRTZyRytOZWZwaXIySVFrcUlVd054WGdMS1Frc24r?=
 =?utf-8?B?SUxRRmcwWk54bUFZOHd1OER4NlJoUGFpeU1ZQXVnN2VrY0N4Zkc2Y2wxZ29R?=
 =?utf-8?B?K0tmZ3A1NnJ1eEJ0L3NpcTQ5YUJ5YW5YRURsRzdKLzBQbEZOdTdLYXZsejEw?=
 =?utf-8?B?dzRBOUU0V29TZW11U1RpSjNBZDA5blU5SDI2KzJ1YXBGS1RiT2d5WEV2YjN6?=
 =?utf-8?B?ek9naGhxNm56bnJvaUJzYm1YckdtY3NzZ2ZxaGViT1ZsOGRTaDB5bHJuTXZR?=
 =?utf-8?B?ZWhJTjNMcWliK3FPUkYrelV2b1hXMGZvVkdsS2dZV2hkdzl2MzBkSEpWaENl?=
 =?utf-8?B?eWc2NjFLdnBEME1WcTFOVWdoMk11eGNqaUxKNEtYY3FublBuUDE2ZjlpSG9o?=
 =?utf-8?B?WEpxUUhtUEpaUHg0VlpZcGlGTE8vSVhXN25xdzJuSlFRRDdDNkxGUTZ6Q293?=
 =?utf-8?B?TXBla3M2NjNLOXY3dlRKcmxPSyt3cEhDTGhxa3VlVm1aM3NVZjc2akk4Y0N5?=
 =?utf-8?Q?asvnjBkQWzLNA5NTCGoJN2LU9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EC841F2571942428A3001D12213515A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9933e5-6ae6-44de-9ca4-08dc7bd0395c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 09:02:22.5221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v500EteHcpTj3ulgKK09nbMBbdvTNQiGBvBKofQGbwoZAsrK8L5rHMJ2mCUo1LnjXBtWkN9//pZPDnA5ZtL6WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7610
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.378200-8.000000
X-TMASE-MatchedRID: pBwXUM+nCwsOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0qbqzDH9G7eTMcIKE0FtlOFY1bQMCMvmn5h59nsX2QuC1iPAfsxl1xU6BX
	hOTEsTTHi8zVgXoAltj2Xsf5MVCB1t7DW3B48kkHdB/CxWTRRu25FeHtsUoHutV89kSreZKOfFo
	U1WwfdOTgIiIYZ2hfGl5AgUYVE601fCOKFKuVYGg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.378200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	33B948889D532D65F0B92AFEDA682F8BC9E4DBD55855210E15B329A282D3954B2000:8

SGksIEFsZXhhbmRyZToNCg0KT24gVGh1LCAyMDI0LTA1LTIzIGF0IDE0OjQ5ICswMjAwLCBBbGV4
YW5kcmUgTWVyZ25hdCB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBBZGQgZHQtYmluZGluZyBkb2N1bWVu
dGF0aW9uIG9mIGRwaSBmb3IgTWVkaWFUZWsgTVQ4MzY1IFNvQy4NCg0KUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gU2ln
bmVkLW9mZi1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4g
LS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRl
ay9tZWRpYXRlayxkcGkueWFtbCB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwNCj4g
aW5kZXggMTY5ZDA1NGQ4MWZmLi4yMWI5M2YzNTY5MDEgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRwaS55
YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLGRwaS55YW1sDQo+IEBAIC0zMSw2ICszMSwxMCBAQCBwcm9wZXJ0aWVz
Og0KPiAgICAgICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDY3
OTUtZHBpDQo+ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTgzLWRwaQ0KPiArICAg
ICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4MzY1LWRwaQ0KPiArICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5Mi1k
cGkNCj4gIA0KPiAgICByZWc6DQo+ICAgICAgbWF4SXRlbXM6IDENCj4gDQo+IC0tIA0KPiAyLjI1
LjENCj4gDQo=

