Return-Path: <linux-kernel+bounces-188491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62798CE2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 10:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E144EB21927
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB1A129E7D;
	Fri, 24 May 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JwyLetC4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TyQV21tX"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E0129E7B;
	Fri, 24 May 2024 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541013; cv=fail; b=SQRQuTpAKk7T3huMGJdkw7a++Yp6eD4dEni4oc/cIiqB42lj4E3fzb1QktBTgtgGxauFbCzKkDhA01t0sFTQgvb4ZXyVBtORbpLCcMgz9F9kWZ9farChDdmPOhks+lXpc3wivWK3mN2tpXhAx/CYBX8jGpR6uB2PrGxn3KSuAO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541013; c=relaxed/simple;
	bh=AspmAakcC47Tce0yPuH1npRc/XOUXJs0PJvfAIPOPBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YRe5YZFHJ4C+sJkf+eIPRgsaSzcg83ht4zKFOGVbWVDDpsq8SWUurpTsV4DhZxOY6B0IvEK2SNkV2h/6WHd6vSVNYFjA+REysJRrIdyuNXotCUSB1l12UFq5cKFm9svyJNESuroG6BW0QDLzes1HuAYMhGhgtHFVVRy2o+OiWek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JwyLetC4; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TyQV21tX; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8dd19ca819ab11ef8c37dd7afa272265-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AspmAakcC47Tce0yPuH1npRc/XOUXJs0PJvfAIPOPBY=;
	b=JwyLetC4M1r0sqPCVsqUUPq/fO+kn/G9+Al4yIcn4HRrI4lHSLsCUXFn0DwfLnOY0QnowQFCBw9ZlYnr7Ww1+dUuuO7vweKyd0chcXqc7A+bbN2qtPc91ttmi5bCURLdxF4BPtWqhS4UTWIwpt0YxfckDaD+xzdGVqOEgpn7MEw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:47e4728d-ec78-4726-993d-98ff2173691f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:48614484-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 8dd19ca819ab11ef8c37dd7afa272265-20240524
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 127378006; Fri, 24 May 2024 16:56:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 16:56:46 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 16:56:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e9N4dI5vcBXymUQd+hWEvXcuPaeWWdCKA3f1C2bn6FMIxVtBpacvr24KcWTyi7mDZCG17CvGkY+Gr2d2u2+PBJ/0oecm9YJ0Lj2PSOfCJt/TDEBhb20MnWAu1RzwK+/YRTVVxaICB+QxKJIvsJP7vrrJDlbdj6t/dQb11Wdreaic0F9exDYT/PIfHNORhQG9GDViiWb/uu9WzoA4eEkoEU5YUqmvAXE0rGpBlpostpcC20JMFA4zaiB6k44O+OUZbWMEnhf03OViHUUkF99zZO/JeJbL5sPD5Med2WiM3GHgt9hh3dRI9tznroIjrQk5I0ydSpUvUZhOm7IFv+iOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AspmAakcC47Tce0yPuH1npRc/XOUXJs0PJvfAIPOPBY=;
 b=jGrEdnOzVStFZ/G3wZcETjzxcpUrgiF9KXwCxvcTXpbRZoJ0p2ZdUT+zt12I2nWEJmFh/nZVdS7cpGW5oMRzyEuUSfayekAThXwU2gpbT+ioQYG/f4ZRjB0OIGA0v/cgOvj8OyL9e4tyhKWRMzlRMnynU+6APEA2GjmkGgZjHa+UBZgyNkaq28YDWQC0px9iPsYfJlAHO90hHy3Ruy9gAs55HOc+B1pG4aCsiqf7xlWgjbAEH+5cpawEQVr31FAMeHNNLLKUkab8oPtMMXahmhoocsmkWkOKgFVpq8kCqmAbI7BXLQJlcASmAQ5/zc9O5FNbTJGXhs7+nQBKlugBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AspmAakcC47Tce0yPuH1npRc/XOUXJs0PJvfAIPOPBY=;
 b=TyQV21tX2ySmmoGFvSS2fLckL/XMshVcq7fyihxGpHkSL4/JWcM+VkTJm2Hd7eZjpNXYYrqChiy0drAi4O2P8ICeLpTfm+BvL40rkHXZKgCXrn7LDG7oOjSDTgyFzTnFLC8/ojevnk0vRGChraCC4bfODTw+zMsk8BLFs2yBUcI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7929.apcprd03.prod.outlook.com (2603:1096:400:458::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9; Fri, 24 May
 2024 08:56:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:56:44 +0000
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
	<linux-arm-kernel@lists.infradead.org>, "fparent@baylibre.com"
	<fparent@baylibre.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 06/15] dt-bindings: display: mediatek: dpi: add
 power-domains property
Thread-Topic: [PATCH v4 06/15] dt-bindings: display: mediatek: dpi: add
 power-domains property
Thread-Index: AQHarQ/IT5M5oC/GXUa51Eht9nuoZbGmFnoA
Date: Fri, 24 May 2024 08:56:44 +0000
Message-ID: <75ff8973ca6a7f654a25089ef5fe7abe8cb0839d.camel@mediatek.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
	 <20231023-display-support-v4-6-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-6-ed82eb168fb1@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7929:EE_
x-ms-office365-filtering-correlation-id: cbdd197a-9189-4b5c-8bd1-08dc7bcf6fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?blJMNWY1dDJzM1BzZHh0SVFnQkN6V25qbHdqbzgvQUNISWJzUGJRVUtxSVpa?=
 =?utf-8?B?UXFOMDFlVXNYVit4RWxIMVZRRlhIVldWYkJGYjF4dEtZS0F1T0pBU0QxSEM4?=
 =?utf-8?B?cDJTeUlZVXZ5ZHoyajZ0SXJXdVcwb2Y2RFROOWVSREZlVWhCMWZTb05oa1FD?=
 =?utf-8?B?ZnpYMHhkdlBzcnM5TWVLQWtOdFZVbkJCcUlhTnhOd2RtcU9RcTF0cDk2aFNQ?=
 =?utf-8?B?SlNmZHhYc0VqajN2ZUhwY3Bzb2ZOZU1ub3NuS1ErTHpRbnBiMitQWER3enlY?=
 =?utf-8?B?SXFRYzRQazZlam1USTE1VmlZR0tXekpPKzVCS25DbU14Rld1ZG1SS2w1clFZ?=
 =?utf-8?B?amtwajJhMVh4TlJrMmZhWG1YNHg5QUFjS1FkZ2lTY2doOFQrbzZGcGxRNXpU?=
 =?utf-8?B?RW12RFc2SmZPbzZ6eldnUDQ2K3ptTTFneTFhSFBvNmxDeTZOWkdoNTlOTXF3?=
 =?utf-8?B?NGRhYXhnSzA2N0gwSElpdEV4OVlKQmFvU2NNVFZYUXkyR2pYRWl2ZWRZNmQ1?=
 =?utf-8?B?aUdJemlzQi9acFplcU8vZmtNRW9DdG9IUyt3MkxYeEI0K0dFVkJuMkRSdXp3?=
 =?utf-8?B?d3NoUjVtWTZpaDd0UE1pKzNmNHg3aXdhN3lNRUJmTi9BVDkzUVdPT3I2YlRP?=
 =?utf-8?B?bGJQVS93R3ZneldhcUhVS01Ud0NtbTNmSTRiMGFvZjN1WmNUeHFBSmtXT1FY?=
 =?utf-8?B?ZG1ZZUNvSng2K3ZUNUJRdTZ5NXJ4RVlIdzUzYW80ZUNwVUtzTW9YdHl5S3R3?=
 =?utf-8?B?OTRRYThOS2x5ampHNFZRNmJjcmpEVXpaMkdVMStCdFY1NS82Uk5OeUkwZnVH?=
 =?utf-8?B?bGhSTytrRjRHWC9LZUFuemVabzN0N1BMbXRaT0s2cnRCVkdXRFpDVXFBZzhI?=
 =?utf-8?B?aGU1ODlaMjlYeGx5T2g4Y0NYR2Jub0hsTzJXV1d3SThrbmkvNGo2V0UzMTIv?=
 =?utf-8?B?Q0lONkEzN3dOLzU0UCtJMk4rUmQ0cndma1F5MzVWSXQ1MU1EK0dQRnRzY0VO?=
 =?utf-8?B?N1FRQ0pCU3Rld2x5WWxTWGdENEkxM0x2emRTREoyVjRxTm01MFUxcXZYYVo2?=
 =?utf-8?B?RzA2bmlqdGtITkVPMUltSy9IQUZET0tsWW54a295bkNOT1VvSFd3SkJrU1NP?=
 =?utf-8?B?UDJZR0RnWGJUNnFnMWNWMm5CdnAvMG1hR25Cd2pVOTd5cnVuVWhhcnZBSFB3?=
 =?utf-8?B?amRSR25TNlNreTZJTVZzNEgrRzJWMGFrNVJ0UzVSRDZnNEc0ZTdYTDlqTXdx?=
 =?utf-8?B?UXdnb0hIM2haZXUways2N05FTjUzMXFiRE9vd3dMdlY3eTExL1FpRmdmVzFp?=
 =?utf-8?B?ZUVBTTFiQWVZVUVyOVgvdGFEaWluVTBZZG1nSjZnbE1oN3gwQVliakhTclpw?=
 =?utf-8?B?azhwTmY5OXpIb3VSV08xQll3eFdUUjhOS0c4N3ZmcUJUVmw3YkN5TjduU3lC?=
 =?utf-8?B?VDJtZzlramJkWng0OHFyalVwV2pXTnR2TEovN3ZmanpBUmpwK0VVVnBCaUZ0?=
 =?utf-8?B?eTlMV3Jrc1B0Y28yaThhU2tTcUYvRnVVK1NENUI5WG0yRE5UM3Z1T09RM1Ro?=
 =?utf-8?B?V253Sm96ZVh5ZkZlYjlNTStRL2QvL3d1R25JWEQydVB2Z1R0Wml6RDJaVWRV?=
 =?utf-8?B?TDhheURibkxTemQ4anRWalRtKzgzY0RuR0dnYVdqU2xPYXhRUnFVTjdoTWQr?=
 =?utf-8?B?dDAyVHVFai9PdEU0YVprS2d0ZTlIOXo4dzNaSU8yUnFDcUVlY3ZXdm5oK3Vp?=
 =?utf-8?B?b3RPdFZnQ2lVSStlU1Y0RTJSeXBEcWhEWGFjOG14cHkxdm1zSUtRWTFoWGFr?=
 =?utf-8?Q?VL0X9u4zkdc+7VYIgO8PrO1faWUTZYaLW+0ro=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGNuVlE4RUZKUlFRenpuYUt4czhhbjdkOXZHaG1ramlWazFpdi9Ed3NKczRq?=
 =?utf-8?B?ck9JNlZUZHhIUW1PWjRIbjZIbk54SnJmTEZINFNZRzZjOHlIRXZyQ1hTT2dU?=
 =?utf-8?B?M0FyZ3hSMXNNRSsxWElldThjbkFRMkc1aVZZNjMwa2hJL2xhdXhsZHFHNWtx?=
 =?utf-8?B?YTRmMlJ2TFliQUZqNHh6Szl5d0RyWjBxN1VKSzViNm1vYk9pNU9mbkJwYjVV?=
 =?utf-8?B?TWlOOUxLUHJ5VFk0UFFoSU5KVU1Jb2syYWdtV2kxTzlPR1gyRnRBeE5NWkVx?=
 =?utf-8?B?WWRjWjJQMTYvVjljUE8xWHE2T2FNQUszOWVNQm1uemwvWmo3MW9TdVZ4Mytl?=
 =?utf-8?B?MzRWNmxJOXpsWHVjKzFGS3lWNTN6cE5Edmh6MUVXNUZ6QWg1eUpzNnRiYmI2?=
 =?utf-8?B?MGs5MTJpelJsbXAwN3dhVEVRbUwxMm45ZmNlbzVTZGZTTzErL0trWkc5Skx1?=
 =?utf-8?B?NTBvZjdwL2hXZlJWbGNrZnFnRk1wREN5L1VETlR4eEJJdWtQQmdBemRVQWN0?=
 =?utf-8?B?TzF4MmFCdmFZaGpGL25NUWdxUlEvekNwc3B1aGRwK3pmbU53WXFoM2FPeHlq?=
 =?utf-8?B?ekdlbUNBTWV6OUFDakF6ZlBLUDdmRXZJcUlRZDNGeFJoUjRYdENxcUFOemFJ?=
 =?utf-8?B?a2k1QlJ2eitMbmRVTFBINDVYWTJ5bHFMWTJWYWZCUDFQU0FFaWNEY25GNzFB?=
 =?utf-8?B?YVVJZmZkTzMzZkdQWTNkdTRZZ1kxa2E2TWFFc3dKa01aVzBGQURrRU1QSjdB?=
 =?utf-8?B?RHh1dGFJTGdYTUF6T0ZsYjF2M1pYL0VUKzdIQWdldWNHOHhkeWM4ckd5Zmxo?=
 =?utf-8?B?VS9TaGpEMGlFQWhJRjlVRHJLZkRpM2RkTHZ2MHIyUDN3S0pJZEFYQ3kya3ps?=
 =?utf-8?B?cHhzcElrSis3TXp0NHc1dVQ4ZHVGVWRVS2VyaUkxa0Rzb0JoaElCLzM3dlls?=
 =?utf-8?B?TzJPaGp5OGhsVzFYS3M5U0RRUHIrZmZvOE9KWTB4SzNCejhGWUN6bjRFdXdU?=
 =?utf-8?B?eWVlZFdjdEM1K2hIdjVJeStrOXJhdU1OaEhTMURPT0ZUYlRqZ2xYUWZOWnBy?=
 =?utf-8?B?bmw0MkdubFBiR29FUHZxbjdlM2pnTDRrV2YzVkVQbVdyWjNjYjU4bEdBNXJX?=
 =?utf-8?B?Q0ticFpaTjJkdE9NOGYvM1p5OVpHZ1NOYWpoRmYweFRRcHlkWnZMeEZwMFpq?=
 =?utf-8?B?OWR6UDZTQmJBTTJOdG1xT3h6L0YvU3pRdDZmUGNrVVVaeW55enkvWE5iT3B5?=
 =?utf-8?B?dU5pamtOMCtuSnpUQ2JzcDNWcnhGV01HY29rVmhwUjhlSnhaUDZLOU9pc0hl?=
 =?utf-8?B?Nm5ZdFZEbkVHbW1Rc3FCUUdodldKRmRBeXZoMThGREQ3dWx0V3k5RGlqb1dY?=
 =?utf-8?B?L1AzMzVGd2VPZDAyQmY0WVFsMEd1MXFmVHViMDFLUXlPZDluck5RVkxUVkRo?=
 =?utf-8?B?YVd4dzl3YXpCcnp3elllbWp0MUxMNkxjekowYU1oRXFLMm9ROFhKVDJFRk5r?=
 =?utf-8?B?V21Ob0pXTURWNzMrYTIrRWxuVkFsZDF3QjJyZnExV2xvUlhRTHFPN1RxTEpD?=
 =?utf-8?B?WURaS3BqSzE1Y2hpQ1dJOG1wdktUNStraFo5TkRoWllreU04dnlXa1MxWEc1?=
 =?utf-8?B?RXZ4OHZaZ3dFZ2FNZVJMbGUrZXZod1IzdnIrNVdMTzkwaXQ2TW5VbjU0SUZn?=
 =?utf-8?B?ZUd1T05zSUdwZmtqd1VhRWZKekRIWGZtQ0svTmVUTFZCVnRlVTBWbHNBMnRK?=
 =?utf-8?B?ZlFMQk8zU1lwN25iT0VrY1ZNL29kNVRoc3V3V2ZqOExvS3hJYndFbFkzUFJm?=
 =?utf-8?B?bkNMLzE4SmRBWEV2OUo4MTRrajFBeDhUZ3dISlhYSDBwaVpMcUgrKzVOSE0v?=
 =?utf-8?B?ajl5V3JRbk5VbU9WVWhQOHNwQkFkWUJuckFLdnN5a2RwNUZCTnBCZGhhQW1j?=
 =?utf-8?B?RFdzWmR6cVdWWXJOMnRaTkxIZXA2SVpONzNBK24xYjV5QnE5OHRmcVR4Y1Ar?=
 =?utf-8?B?RnBSWWFrQ1VoNFRKYXBmbUQ4T3MvSEIydWNqRVBmYzdUZGZKUzVpT0gwamZI?=
 =?utf-8?B?SFRLYUhUaDFUUHlkSlNGTXZwbXRBbkgwc2JWQU5vc3FKMWNCYVYwcmVQcTM1?=
 =?utf-8?Q?uIyB9pKbwlEJs3gqqbN9myLZ9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88E78E369C7B0B41BC3DC08F1143B659@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdd197a-9189-4b5c-8bd1-08dc7bcf6fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 08:56:44.6795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b0N0GNEZxvGF2ebF3z7P/L4HMCK5mKpcUvceC8W++LD6T7yKIQpWtgaCzR0Ipp3BvdB8kxNIq0eaflXtSjL01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7929

SGksIEFsZXhhbmRyZToNCg0KT24gVGh1LCAyMDI0LTA1LTIzIGF0IDE0OjQ5ICswMjAwLCBhbWVy
Z25hdEBiYXlsaWJyZS5jb20gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFz
ZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2
ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgRnJvbTogRmFiaWVuIFBhcmVu
dCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IA0KPiBEUEkgaXMgcGFydCBvZiB0aGUgZGlzcGxh
eSAvIG11bHRpbWVkaWEgYmxvY2sgaW4gTWVkaWFUZWsgU29DcywgYW5kDQo+IGFsd2F5cyBoYXZl
IGEgcG93ZXItZG9tYWluIChhdCBsZWFzdCBpbiB0aGUgdXBzdHJlYW0gZGV2aWNlLXRyZWVzKS4N
Cj4gQWRkIHRoZSBwb3dlci1kb21haW5zIHByb3BlcnR5IHRvIHRoZSBiaW5kaW5nIGRvY3VtZW50
YXRpb24uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0K
PiBGaXhlczogOTI3M2NmN2QzOTQyICgiZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVrOiBj
b252ZXJ0IHRoZSBkcGkgYmluZGluZ3MgdG8geWFtbCIpDQo+IFNpZ25lZC1vZmYtYnk6IEZhYmll
biBQYXJlbnQgPGZwYXJlbnRAYmF5bGlicmUuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNv
bT4NCj4gQWNrZWQtYnk6IFJvYiBIZXJyaW5nIChBcm0pIDxyb2JoQGtlcm5lbC5vcmc+DQo+IFNp
Z25lZC1vZmYtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+
IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWssZHBpLnlhbWwgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxkcGkueWFtbA0K
PiBpbmRleCA2NjA3Y2IxYzZlMGEuLjE2OWQwNTRkODFmZiAxMDA2NDQNCj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBp
LnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
bWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwNCj4gQEAgLTgwLDYgKzgwLDkgQEAgcHJvcGVydGll
czoNCj4gICAgICAgIC0gcG9ydEAwDQo+ICAgICAgICAtIHBvcnRAMQ0KPiAgDQo+ICsgIHBvd2Vy
LWRvbWFpbnM6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiAgcmVxdWlyZWQ6DQo+ICAgIC0g
Y29tcGF0aWJsZQ0KPiAgICAtIHJlZw0KPiBAQCAtOTksMTEgKzEwMiwxMyBAQCBleGFtcGxlczoN
Cj4gICAgLSB8DQo+ICAgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9s
bGVyL2FybS1naWMuaD4NCj4gICAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTcz
LWNsay5oPg0KPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9tdDgxNzMtcG93ZXIu
aD4NCj4gIA0KPiAgICAgIGRwaTogZHBpQDE0MDFkMDAwIHsNCj4gICAgICAgICAgY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxNzMtZHBpIjsNCj4gICAgICAgICAgcmVnID0gPDB4MTQwMWQwMDAg
MHgxMDAwPjsNCj4gICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE5NCBJUlFfVFlQRV9M
RVZFTF9MT1c+Ow0KPiArICAgICAgICBwb3dlci1kb21haW5zID0gPCZzcG0gTVQ4MTczX1BPV0VS
X0RPTUFJTl9NTT47DQo+ICAgICAgICAgIGNsb2NrcyA9IDwmbW1zeXMgQ0xLX01NX0RQSV9QSVhF
TD4sDQo+ICAgICAgICAgICAgICAgPCZtbXN5cyBDTEtfTU1fRFBJX0VOR0lORT4sDQo+ICAgICAg
ICAgICAgICAgPCZhcG1peGVkc3lzIENMS19BUE1JWEVEX1RWRFBMTD47DQo+IA0KPiAtLSANCj4g
Mi4yNS4xDQo+IA0K

