Return-Path: <linux-kernel+bounces-172793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF698BF6E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EC8282C1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F11028383;
	Wed,  8 May 2024 07:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="G4idUu2T";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pqvzjj5H"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67001F937;
	Wed,  8 May 2024 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715152785; cv=fail; b=hzZNKIKub+ZyEO3mlnEGNwaG+tvdzybpYMvL3FBitdEPkTgQ1ZIsVYbrbRLq87Eg3LwwJKfzl08R6k2/jaY+1HT3n8ersHRxh8lWwOVvaVaXoX3rBenstTCTzCSkX6oGppMA85cYzv4bMrSYzm769rymH7/2qAoU+htQJsbA6Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715152785; c=relaxed/simple;
	bh=4IrnkAzPDee2fEASQ9oA53+P43YrDaSMOUPX9kPf7Xs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ir6eY8hiYn4gsYCz2c8ji/AZSZf22w9poMxpx6drdKIVvxgJyIonHMkViXhRXaZQunbZ+tB/ensBHEzaP29CgMx+FYEo9SXLtX7BNKwreOfOZER7X+2hX9KNF27m1D8JSt6B27/bkfdvrlV1kH1tFdqJZQjWWYZ9c4xb0k44byk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=G4idUu2T; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pqvzjj5H; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f73412a0d0b11efb92737409a0e9459-20240508
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=4IrnkAzPDee2fEASQ9oA53+P43YrDaSMOUPX9kPf7Xs=;
	b=G4idUu2TL+lLbX5MrGny6eDeIB7GoT2OyKzsus3HOGRrdi+joW3t/WbcLQrrpXFDLNTSNy4xm6nPi6nPqR2O/J/7t+RT/EGmdhMZyUL653pBx51A1Pju/nKxbG9VKNzrmDJd3GPjsKP0E9cwpj5SZY1fiALi+rsQwCLdm1aO9nM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:6b458523-623f-4e3d-a270-4f3ce40031f8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:9eb37e92-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4f73412a0d0b11efb92737409a0e9459-20240508
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1091848565; Wed, 08 May 2024 15:19:30 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 May 2024 15:19:28 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 May 2024 15:19:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1L0yFMKpfRiKfBxR7av78J8QEv3GaynzpmgDV348kyMMIsz0ad12BmXtU647qVd9jecUcNzytBM8ZsybS+SUwmwXOQL9ICCjHwROH6qfoLXj9QYZYDg1/bYkMJ+brZaG6ltr65CrI8bPnZmvDpYOya8VADpxNNOJhMnXXBx/O+ivLeP+Q2ADCRusIlMRTM5HBTf2YWsy9U5fvF7WmqfKqkuIYi12bRsz6v7UiNaDW3OoNDHrjBEbzuuyd0BKG5rWyUdMQcU0diaGbirRlGBY65RWmhAYX5aVuA3WmDGX6PphVvqHaPsEWepI9W4MFcub49dYbPDpquotCg6gzSKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IrnkAzPDee2fEASQ9oA53+P43YrDaSMOUPX9kPf7Xs=;
 b=SeFNDrfQfWEj+x/lseG0MK9KlPb2WnaxkNhkD/ooRYKd5F8yIZrca05T+ZR/cyQjmLhnCL7Tmuo3kGjzI+MevX1Bg7Qw3xBfEb3sSIcrqUewZFT1a/eTiIk9DjYwGHm5jy50o/gJyUtDV8E7tJYUmnc2tH4YxtATeRgFZpSarNT+mrOAQxKC2jqZ2cLVBIN/MESS2CO+EolJCR0LtYplj1Yj0n1+12/zkZaPGPyD8StkhTnGAp0f6rsV53rgNsIUjkvfVR8LH61gnAXrv6kLPeEvT34qCYu9MAoffIrQa12ELzrGYV9lYId8dmXIE04wlnoKzjFiT57kk9JpliMsVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IrnkAzPDee2fEASQ9oA53+P43YrDaSMOUPX9kPf7Xs=;
 b=pqvzjj5H6wtM//7PCFsdb1HVW43NYqiQT3jQxt/gZiAcKoYSzLpk2l5lzP/N167hXolx1MKw6fYwDWmbKngNhpGs51FVRfhONcH/iB/ColWdbGgnLYxfx74py3KIt8qRuQqRvJnx0Mqq8UHn/zV6KuJUwPx2s6VLJNp0wtByqEg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7431.apcprd03.prod.outlook.com (2603:1096:820:ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 07:19:26 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 07:19:26 +0000
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
Thread-Index: AQHainXPkoeeapgKhkmHjjX1T7SS9LF4WlSAgAtsa4CAB7xpgIAAd5qAgAEgaYA=
Date: Wed, 8 May 2024 07:19:26 +0000
Message-ID: <847e1a84b532956f697d24014d684c86f0b76f03.camel@mediatek.com>
References: <20240409120211.321153-1-angelogioacchino.delregno@collabora.com>
	 <20240409120211.321153-3-angelogioacchino.delregno@collabora.com>
	 <aa7e3bcf70383e563a65919f924ec2e5e4cd778c.camel@mediatek.com>
	 <becdc2e5-4a1d-4280-b6f8-78d4903be283@collabora.com>
	 <4dfb09b9c437ab2baa0898eca13a43fd7475047a.camel@mediatek.com>
	 <46347f5d-e09b-4e83-a5a2-e12407f442a4@collabora.com>
In-Reply-To: <46347f5d-e09b-4e83-a5a2-e12407f442a4@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7431:EE_
x-ms-office365-filtering-correlation-id: ca06e286-d0fb-4174-a199-08dc6f2f3186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OGtnT2NVbXdsY2M2Qllrb1ptSk5aSTNFM0hWR1EwQUlEVkRscXRFUWRjcjUx?=
 =?utf-8?B?ZlhLblB1bXJlc2ppYnJsZlRhS1FGQXNIZ0ZiTTNJVzVGb1BORVpTeG9FRnhp?=
 =?utf-8?B?emtZbndxMmJQSm85NTBLSUd3ZEhBUnpIL29YbkNBSG02R04zTHpnZXBFK2Ux?=
 =?utf-8?B?ZTZoQTJIQmxPT1MzdTdVRHFRQlhBOExhTmwvYnlzbnFzN0N4N2hwN3NRTVlL?=
 =?utf-8?B?aEJpamZkQ1BTa2plSk0zUmlvdnd3QjBVUzEwZWpyL1JVNVFaVWVmQUNyNFV1?=
 =?utf-8?B?S3B6SDlrUEVOR0VtUk8xRVczUFJad2FMRGN5TnFpQ1RQNXp5TjZ2Uy9JbTJr?=
 =?utf-8?B?ODNFTDBGL0RhSTRMZXRWRVpPUEpFUW0vSXFxdnF3bXg4eFNLS1hDNDREVFFV?=
 =?utf-8?B?dThBck1wVkVvVnZ5dDhsRzl4ZkhIRUNOWlpGT1FuUG03UjBxNmR6RWY2S1Ex?=
 =?utf-8?B?QVAveDIxeVRuak1JRlFjSkxKcFVpLzdxZGxmTllKUWJmc0xvWTR1cGtOemlr?=
 =?utf-8?B?V0VxYkR5RVNkaHk0M2Y1WGJtWGxWM0RXZXBzWExuZklJSlRZVUN5TWhSV1pH?=
 =?utf-8?B?Z1UyTGpDTFpLbDBOOXUxTGI5SG90SGlHOWVpMzZnd2ZwVjVnM2oxa2ZoMFZm?=
 =?utf-8?B?ZTV4RGdWbGJJV1Q4VEg4SVBxa1FVdEt6OUkrQm00RXdOUkIwT2hHdXJuYWpt?=
 =?utf-8?B?SnAzTW04OHAvY01ZUUxrRE1sczcwWnhqdWRlQUs2K3JiekdsMFNsU1R3VzFq?=
 =?utf-8?B?Sjk3SW51djR2OCtBWWdhcHFQMytuaEtUbjNoKzIxYTRZcnpnL1JJUno1b0lq?=
 =?utf-8?B?VGhrMTRua1JJZkxiUC9zaWFGdUwxLzdsTVk2L0ZKek91aXd0ay9MT1JVL2lY?=
 =?utf-8?B?QXZBazJRcWhtMStaYnFUTHBSTVEycWI1dG56UW9hc0NJRU1xNW91QWN0TWRR?=
 =?utf-8?B?c3EyYzhyZEhrVncrWGRHRXNSTTlTbGtWNEZWWnFXdXlibmVaMlhEY05YZnJq?=
 =?utf-8?B?cFRtTmQ5T0pxR1F6amZUenc3UmhGY3ZjWGo5RWp5eFVnU2JBa1RWMlhQbHVR?=
 =?utf-8?B?TldDMDBiUjlxbXNLSmZ2eUt3Y0NHSU1HcVpTREQ0SVRnanNVSjB2V3llMDFU?=
 =?utf-8?B?Yll5QjNGS2ZlTS9lcWRpNDRyRnNPaTJWT2ltandvZTVGYkE0UFNOcks0d0VB?=
 =?utf-8?B?cTljNmx0d0tod3pxYTVkc09PMHh0cGprUE5xUGhXT2RXMG5zM2cxRUJWa1VO?=
 =?utf-8?B?MUNWRkFwMjRPTGlYRnhBSis5VFlFWXZFSkszc3crUW5SRHBNNGJXSWxScElX?=
 =?utf-8?B?MEsybjJQc1FvVk9yNVhvUnVFb3pwMjdoRk1iUkd1UGZhY1lHL0tJajBSLzhl?=
 =?utf-8?B?RXRrMCtoZ2lXR2s5WVBndXZNb3YyUU1PanlZRDk2eHNhTm9IRTl5VWNGWjJh?=
 =?utf-8?B?N21JKzlyNHZiUDFYajVyaUxBbkJmKzlqaWduNk9NaDdHdUVvbWFWNStLUWdw?=
 =?utf-8?B?U2l5QXJycmdjUHFxckRQeWwxZ0R1VldYVm5lR1pWUlFyWnd0RzFydE5NaVkw?=
 =?utf-8?B?S1ZSUUlNY25wUUtFWGFiSEkyMW5GRFVqYmJBcmV0THY0cCtQR0UzaFdDTDBj?=
 =?utf-8?B?YThwcTZYeWtMSndkcGpTa1hKa1RkNVVHRWQrR2RoYzJnd3U3RUhjOStRRWRP?=
 =?utf-8?B?MllCS0IrWU1tbi9jdGZ2MVplU2R1OVBSc3d5NVN6RENrMWYwUGdVUG9ndDRm?=
 =?utf-8?B?RzBZWmxoMW82cHFaRVdBSkhFSCtmcTZJbHp5TmgrZE55UFllTytBMWdFMU9S?=
 =?utf-8?B?U09Sc1lBMEd1YWRFanZiQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGFIK0ZZOFdwNUNPRU5PQTdoK1piNlcxaDZQdzMxc2ppNndYd2twL0ZNYkNY?=
 =?utf-8?B?QVhuWFdDODkrcnNDZU1nV3MxWEY2VUNmMEg0SHNkTmM4ei9oMTNDK2wxZmRE?=
 =?utf-8?B?WGVKSHI0OElvbkFuM29USTFlNkNwQllsRHZ5Y21DTHpDMkZabGhPY0VZNmpo?=
 =?utf-8?B?cXA0NFdZZnZwVk9ZWE4ySzZGRjExemplVmorSlpYbFJsdVRmNFphNkl1amQ5?=
 =?utf-8?B?Sm1hY0NOa3hXTldPVzdHZXd1RlNoenhkbnIxNHY0NGNPZmFpWnhNVThoZWxG?=
 =?utf-8?B?KzNYNXplc2h0cDNQbVhjRlZSWVZVM0RjVXJhS2Fzakk5NkxIQWFWbVlYb3hy?=
 =?utf-8?B?Wm5XZkVSK2lnVG95VDFndkI4SG5LZENFYmZoa1VseVZuczQ2THVEKzVrSWFx?=
 =?utf-8?B?QXNRUkdZVmhqSzA3aDhNV0VueXBabjRHdEdlNG5Fc2VoamFIWFZ1ckh5RVE1?=
 =?utf-8?B?OFo1YWlpQlJhWkJ3emphdHZSbXZyQzR3aUg2bTFlaDRzdkh2L0NOYy9oemsw?=
 =?utf-8?B?dE93YnZneU5EVFlwWjNSa0ViOUtVaVMxN0pXQk1xMHd3bXBMNVYxMGpRTkti?=
 =?utf-8?B?ZWN5V2Fva1V1V3VBUkJWRkNKSXN3VzI3MGlSSVpTS3ovK3QxYnNib3JGK1Vw?=
 =?utf-8?B?azUwY0krSlIwb3lKLzZYam4vRkdTemNEOTcxeFpZcDI2YTNDMjhEZjRPWUk2?=
 =?utf-8?B?YWRQY3I2Z1BXOHB0c1ZXWlpqYlhicTV5THUxbWJYNGlXZmg1Rkd2QndYVUZ2?=
 =?utf-8?B?TlNYcHBQMWw3TVdsY1JteDRkc3JEQVBMaGVDQjZQRnZvWEIrQVJtc1BpR296?=
 =?utf-8?B?dDdPYjhkaFN5ZUtQc09ubFhUYlh1YzZXa2Q4M1lqMkZBei80dFRwRHhxR0VO?=
 =?utf-8?B?alUrTklIbnJ4QjFFblQ3UVRFWStXdWlnR2VEY3U4VFhtRjJkWVVpOXRsZ2FV?=
 =?utf-8?B?RzFpZzBnbTBxMXlySXFZdWxJaWtIRGE4M1Uzc0RyQmpXajkySHVVQUZFQ0t1?=
 =?utf-8?B?YkFQSlNRaEtKb0NyeUlCZFhlNXFPRlF6NVRVa2tCVktrd2hDMVVxUkgyeTRi?=
 =?utf-8?B?VDh5dE1nanB2bW9WUzNJbHpDRHpSSUoxVjQ2Q2V0bkFLN2dBOUdhOG9OeHJ6?=
 =?utf-8?B?ckhYRHREREE4aCtnbUpiL1ZkSmt6VVZ2QXpHMnRMSkpLOHFGOFJVcHdhSVZl?=
 =?utf-8?B?b0hlUUhsR2VZRXUzWXJScDJweDRXZE1qcTdiQk53TmppcEhLMGxVN3JHQnlZ?=
 =?utf-8?B?TFgwWmdJVGFIdE8xVDUxNVUzb0UwR2Fxamp2WWkyWDE3Y1k0bzJKL3ZudTFw?=
 =?utf-8?B?NC9uWklyaTA1bVp5MmtjWklxcEVQOWFRVGJ5QkdrQkluaWo3YU94YkxGMW02?=
 =?utf-8?B?WHU0M0hzQmlPbE9JVWxvKzU5cHI2QlB3WHVUM2JibExwZGNuQ0lDeTk1T3Fu?=
 =?utf-8?B?dlIrZ1lqeTVpNzNYbzQ2R2R3cDNBZnZwOUhhUGxMYjZyUGJHck5SRzYvdWE1?=
 =?utf-8?B?VGtzYUFrMlh6QnRWdmZzR290b1c0MnF3NlV3cGpqYTNQSGRCY3IyaGNGakMy?=
 =?utf-8?B?SzFrUHdKZzVyQ3dvclFiVythUVg2YVFMVVhTdXg2RTJrZ2crY1pjV0hsSFJ4?=
 =?utf-8?B?RkJLUkYyNmZseEpXV1JuazFqRTJZT0ZEYTF5SnlWWVl5TS9FVkMxY1ZQUjBW?=
 =?utf-8?B?RzNwRlBzaDl1Z0lJYzVpMThNUlVSV3hKVk9UNUQzMHAxazJrVXdGNDg3czFw?=
 =?utf-8?B?SWswekpZK0xBTER3a3ZKSk5TWGM3bk12Yk5wM2FvU2NwZ3NjdGFpOGFVVXA2?=
 =?utf-8?B?Qk4vT1o2OXFqNm05M0xsWUpvaGJtUzV6QTVmVjQ1NnFOSzhWQTY0SDJmWmFu?=
 =?utf-8?B?M0VKSFNIVXorbEVjZDNjV21yMTloZW5LTlhUdVdhTDRIV1c3T09uMGNHdXZ1?=
 =?utf-8?B?RVlYdFZraEFIOXVHbzNkK1RzdGR2aTZWS2cwOWY4UlRCb3B2Y3ByWW9QT1FT?=
 =?utf-8?B?VkUrQktDZ3R2cGJDc2o2TE1hMUlrQjhUaDVtVXNDcXZUZVFiWk01R2dhZndI?=
 =?utf-8?B?VFlLR1pjL3pOOTg1ekZjc2VkbitYbDhmcVVwNVpyd1orKzYyaTNUWVovc0s4?=
 =?utf-8?Q?pBFfo9Qzp/IEqG1DLd55oloBK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C129A1506D71F41B05098E5145511C1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca06e286-d0fb-4174-a199-08dc6f2f3186
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2024 07:19:26.4453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSMc7CYKVi5r72VZzxpph4JaipbTRUYcLd54o3YIPc2jGaO7QN/2xODzCyW+JqD7G2zN2dvRzRNAAkRLyBYrnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7431

T24gVHVlLCAyMDI0LTA1LTA3IGF0IDE2OjA3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDcvMDUvMjQgMDg6NTksIENLIEh1ICjog6Hkv4rlhYkpIGhhIHNj
cml0dG86DQo+ID4gT24gVGh1LCAyMDI0LTA1LTAyIGF0IDEwOjUwICswMjAwLCBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gSWwgMjUvMDQvMjQgMDQ6MjMsIENL
IEh1ICjog6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gPiA+IEhpLCBBbmdlbG86DQo+ID4gPiA+
IA0KPiA+ID4gPiBPbiBUdWUsIDIwMjQtMDQtMDkgYXQgMTQ6MDIgKzAyMDAsIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsIFJlZ25vDQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPiA+IERvY3VtZW50IE9GIGdy
YXBoIG9uIE1NU1lTL1ZET1NZUzogdGhpcyBzdXBwb3J0cyB1cCB0byB0aHJlZQ0KPiA+ID4gPiA+
IEREUA0KPiA+ID4gPiA+IHBhdGhzDQo+ID4gPiA+ID4gcGVyIEhXIGluc3RhbmNlIChzbyBwb3Rl
bnRpYWxseSB1cCB0byBzaXggZGlzcGxheXMgZm9yIG11bHRpLQ0KPiA+ID4gPiA+IHZkbw0KPiA+
ID4gPiA+IFNvQ3MpLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBNTVNZUyBvciBWRE9TWVMg
aXMgYWx3YXlzIHRoZSBmaXJzdCBjb21wb25lbnQgaW4gdGhlIEREUA0KPiA+ID4gPiA+IHBpcGVs
aW5lLA0KPiA+ID4gPiA+IHNvIGl0IG9ubHkgc3VwcG9ydHMgYW4gb3V0cHV0IHBvcnQgd2l0aCBt
dWx0aXBsZSBlbmRwb2ludHMgLQ0KPiA+ID4gPiA+IHdoZXJlDQo+ID4gPiA+ID4gZWFjaA0KPiA+
ID4gPiA+IGVuZHBvaW50IGRlZmluZXMgdGhlIHN0YXJ0aW5nIHBvaW50IGZvciBvbmUgb2YgdGhl
IChjdXJyZW50bHkNCj4gPiA+ID4gPiB0aHJlZSkNCj4gPiA+ID4gPiBwb3NzaWJsZSBoYXJkd2Fy
ZSBwYXRocy4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9h
Y2NoaW5vIERlbCBSZWdubyA8DQo+ID4gPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bj
b2xsYWJvcmEuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ICAgIC4uLi9iaW5kaW5ncy9h
cm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtbCB8IDIzDQo+ID4gPiA+ID4gKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCsp
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiA+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXMNCj4gPiA+
ID4gPiB5cy55DQo+ID4gPiA+ID4gYW1sDQo+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLG1tcw0KPiA+ID4gPiA+IHlzLnkN
Cj4gPiA+ID4gPiBhbWwNCj4gPiA+ID4gPiBpbmRleCBiM2M2ODg4YzE0NTcuLjRlOWFjZDk2NmFh
NSAxMDA2NDQNCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zDQo+ID4gPiA+ID4geXMueQ0K
PiA+ID4gPiA+IGFtbA0KPiA+ID4gPiA+ICsrKw0KPiA+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXMNCj4gPiA+ID4gPiB5
cy55DQo+ID4gPiA+ID4gYW1sDQo+ID4gPiA+ID4gQEAgLTkzLDYgKzkzLDI5IEBAIHByb3BlcnRp
ZXM6DQo+ID4gPiA+ID4gICAgICAnI3Jlc2V0LWNlbGxzJzoNCj4gPiA+ID4gPiAgICAgICAgY29u
c3Q6IDENCj4gPiA+ID4gPiAgICANCj4gPiA+ID4gPiArICBwb3J0Og0KPiA+ID4gPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9wb3J0DQo+ID4gPiA+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiA+ID4gPiArICAgICAgT3V0cHV0IHBvcnQgbm9kZS4gVGhpcyBw
b3J0IGNvbm5lY3RzIHRoZSBNTVNZUy9WRE9TWVMNCj4gPiA+ID4gPiBvdXRwdXQNCj4gPiA+ID4g
PiB0bw0KPiA+ID4gPiA+ICsgICAgICB0aGUgZmlyc3QgY29tcG9uZW50IG9mIG9uZSBkaXNwbGF5
IHBpcGVsaW5lLCBmb3INCj4gPiA+ID4gPiBleGFtcGxlDQo+ID4gPiA+ID4gb25lDQo+ID4gPiA+
ID4gb2YNCj4gPiA+ID4gPiArICAgICAgdGhlIGF2YWlsYWJsZSBPVkwgb3IgUkRNQSBibG9ja3Mu
DQo+ID4gPiA+ID4gKyAgICAgIFNvbWUgTWVkaWFUZWsgU29DcyBzdXBwb3J0IHVwIHRvIHRocmVl
IGRpc3BsYXkgb3V0cHV0cw0KPiA+ID4gPiA+IHBlcg0KPiA+ID4gPiA+IE1NU1lTLg0KPiA+ID4g
PiA+ICsgICAgcHJvcGVydGllczoNCj4gPiA+ID4gPiArICAgICAgZW5kcG9pbnRAMDoNCj4gPiA+
ID4gPiArICAgICAgICAkcmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL2VuZHBv
aW50DQo+ID4gPiA+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IE91dHB1dCB0byB0aGUgcHJpbWFy
eSBkaXNwbGF5IHBpcGVsaW5lDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICBlbmRwb2lu
dEAxOg0KPiA+ID4gPiA+ICsgICAgICAgICRyZWY6IC9zY2hlbWFzL2dyYXBoLnlhbWwjL3Byb3Bl
cnRpZXMvZW5kcG9pbnQNCj4gPiA+ID4gPiArICAgICAgICBkZXNjcmlwdGlvbjogT3V0cHV0IHRv
IHRoZSBzZWNvbmRhcnkgZGlzcGxheQ0KPiA+ID4gPiA+IHBpcGVsaW5lDQo+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ICsgICAgICBlbmRwb2ludEAyOg0KPiA+ID4gPiA+ICsgICAgICAgICRyZWY6IC9z
Y2hlbWFzL2dyYXBoLnlhbWwjL3Byb3BlcnRpZXMvZW5kcG9pbnQNCj4gPiA+ID4gPiArICAgICAg
ICBkZXNjcmlwdGlvbjogT3V0cHV0IHRvIHRoZSB0ZXJ0aWFyeSBkaXNwbGF5IHBpcGVsaW5lDQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgcmVxdWlyZWQ6DQo+ID4gPiA+ID4gKyAgICAgIC0g
ZW5kcG9pbnRAMA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gDQo+ID4gPiA+IG1tc3lzL3Zkb3N5cyBk
b2VzIG5vdCBvdXRwdXQgZGF0YSB0byB0aGUgZmlyc3QgY29tcG9uZW50IG9mDQo+ID4gPiA+IGRp
c3BsYXkNCj4gPiA+ID4gcGlwZWxpbmUsIHNvIHRoaXMgY29ubmVjdGlvbiBsb29rcyAndmlydHVh
bCcuIFNoYWxsIHdlIGFkZA0KPiA+ID4gPiBzb21ldGhpbmcNCj4gPiA+ID4gdmlydHVhbCBpbiBk
ZXZpY2UgdHJlZT8gWW91IGFkZCB0aGlzIGluIG9yZGVyIHRvIGRlY2lkZSB3aGljaA0KPiA+ID4g
PiBwaXBlbGluZQ0KPiA+ID4gPiBpcyAxc3QsIDJuZCwgM3JkLCBidXQgZm9yIGRldmljZSBpdCBk
b24ndCBjYXJlIHdoaWNoIG9uZSBpcw0KPiA+ID4gPiBmaXJzdC4NCj4gPiA+ID4gSW4NCj4gPiA+
ID4gY29tcHV0ZXIsIHNvZnR3YXJlIGNvdWxkIGNoYW5nZSB3aGljaCBkaXNwbGF5IGlzIHRoZSBw
cmltYXJ5DQo+ID4gPiA+IGRpc3BsYXkuDQo+ID4gPiA+IEknbSBub3Qgc3VyZSBpdCdzIGdvb2Qg
dG8gZGVjaWRlIGRpc3BsYXkgb3JkZXIgaW4gZGV2aWNlIHRyZWU/DQo+ID4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBEZXZpY2V0cmVlIGRlc2NyaWJlcyBoYXJkd2FyZSwgc28gbm90aGluZyB2aXJ0dWFs
IGNhbiBiZSBwcmVzZW50DQo+ID4gPiAtDQo+ID4gPiBhbmQgaW4gYW55IGNhc2UsDQo+ID4gPiB0
aGUgcHJpbWFyeS9zZWNvbmRhcnkvdGVydGlhcnkgcGlwZWxpbmUgaXMgaW4gcmVsYXRpb24gdG8g
TU0vVkRPDQo+ID4gPiBTWVMsDQo+ID4gPiBub3QgcmVmZXJyZWQNCj4gPiA+IHRvIHNvZnR3YXJl
Lg0KPiA+ID4gDQo+ID4gPiBCZXR0ZXIgZXhwbGFpbmluZywgdGhlIHByaW1hcnkgcGlwZWxpbmUg
aXMgbm90IG5lY2Vzc2FyaWx5IHRoZQ0KPiA+ID4gcHJpbWFyeSBkaXNwbGF5IGluDQo+ID4gPiBE
Uk0gdGVybXM6IHRoYXQncyBhIGNvbmNlcHQgdGhhdCBpcyBjb21wbGV0ZWx5IGRldGFjaGVkIGZy
b20gdGhlDQo+ID4gPiBzY29wZSBvZiB0aGlzDQo+ID4gPiBzZXJpZXMgYW5kIHRoaXMgZ3JhcGgg
LSBhbmQgaXQncyBzb21ldGhpbmcgdGhhdCBzaGFsbCBiZSBtYW5hZ2VkDQo+ID4gPiBzb2xlbHkg
YnkgdGhlDQo+ID4gPiBkcml2ZXIgKG1lZGlhdGVrLWRybSBpbiB0aGlzIGNhc2UpLg0KPiA+ID4g
DQo+ID4gPiBDb21pbmcgYmFjayB0byB0aGUgY29ubmVjdGlvbiBsb29raW5nLCBidXQgKm5vdCog
YmVpbmcgdmlydHVhbDoNCj4gPiA+IHRoZQ0KPiA+ID4gc2Vuc2UgaGVyZSBpcw0KPiA+ID4gdGhh
dCB0aGUgTU0vVkRPU1lTIGJsb2NrcyBhcmUgdXNlZCBpbiB0aGUgZGlzcGxheSBwaXBlbGluZSB0
bw0KPiA+ID4gInN0aXRjaCIgdG9nZXRoZXINCj4gPiA+IHRoZSB2YXJpb3VzIGRpc3BsYXkgcGlw
ZWxpbmUgaGFyZHdhcmUgYmxvY2tzLCBvciwgc2FpZA0KPiA+ID4gZGlmZmVyZW50bHksDQo+ID4g
PiBzZXR0aW5nIHVwIHRoZQ0KPiA+ID4gcm91dGluZyBiZXR3ZWVuIGFsbCBvZiB0aG9zZSAoUC5T
LjogbW1zeXNfbXR4eHh4X3JvdXRpbmdfdGFibGUhKQ0KPiA+ID4gdGhyb3VnaCB0aGUgVkRPDQo+
ID4gPiBJbnB1dCBTZWxlY3Rpb24gKFZET3hfU0VMX0lOKSBvciBPdXRwdXQgU2VsZWN0aW9uIChW
RE94X1NFTF9PVVQpDQo+ID4gPiBhbmQNCj4gPiA+IHdpdGggdGhlDQo+ID4gPiBhc3Npc3RhbmNl
IG9mIHRoZSBWRE8gTXVsdGlwbGUgT3V0cHV0IE1hc2sgKFZET3hfTU9VVCkgZm9yIHRoZQ0KPiA+
ID4gbXVsdGlwbGUgb3V0cHV0cw0KPiA+ID4gdXNlY2FzZSwgYm90aCBvZiB3aGljaCwgYXJlIGRl
c2NyaWJlZCBieSB0aGlzIGdyYXBoLg0KPiA+IA0KPiA+IEkgYWdyZWUgdGhpcyBwYXJ0LCBidXQg
dGhpcyBpcyByZWxhdGVkIHRvIGRpc3BsYXkgZGV2aWNlIE9GIGdyYXBoLg0KPiA+IFRoZXNlIGRp
c3BsYXkgZGV2aWNlIHdvdWxkIG91dHB1dCB2aWRlbyBkYXRhIGZyb20gb25lIGRldmljZSBhbmQN
Cj4gPiBpbnB1dA0KPiA+IHRvIGFub3RoZXIgdmlkZW8gZGV2aWNlLiBUaGVzZSB2aWRlbyBkZXZp
Y2Ugd291bGQgbm90IGlucHV0IG9yDQo+ID4gb3V0cHV0DQo+ID4gdmlkZW8gZGF0YSB0byBtbXN5
cy92ZG9zeXMuDQo+ID4gDQo+ID4gPiANCj4gPiA+IFRoaXMgbWVhbnMgdGhhdCB0aGUgVkRPU1lT
IGlzIHJlYWxseSB0aGUgIm1hc3RlciIgb2YgdGhlIGRpc3BsYXkNCj4gPiA+IHBpcGVsaW5lIHNp
bmNlDQo+ID4gPiBldmVyeXRoaW5nIGdldHMgZW5hYmxlZCwgbWl4ZWQgYW5kIG1hdGNoZWQgZnJv
bSB0aGVyZSAtIGFuZA0KPiA+ID4gdGhhdCdzIGluDQo+ID4gPiB0aGUgc2Vuc2UNCj4gPiA+IG9m
IGhhcmR3YXJlIG9wZXJhdGlvbiwgc28gd2UgYXJlICpyZWFsbHkqIChhbmQgbm90IHZpcnR1YWxs
eSEpDQo+ID4gPiBmbGlwcGluZyBzd2l0Y2hlcy4NCj4gPiANCj4gPiBJIGFncmVlIG1tc3lzL3Zk
b3N5cyBpcyBtYXN0ZXIgb2YgdmlkZW8gcGlwZWxpbmUsIHNvIGxldCdzIGRlZmluZQ0KPiA+IHdo
YXQNCj4gPiB0aGUgcG9ydCBpbiBtbXN5cy92ZG9zeXMgaXMuIElmIHRoZSBwb3J0IG1lYW5zIHRo
ZSBtYXN0ZXINCj4gPiByZWxhdGlvbnNoaXAsDQo+ID4gbW1zeXMvdmRvc3lzIHNob3VsZCBvdXRw
dXQgcG9ydCB0byBldmVyeSBkaXNwbGF5IGRldmljZS4gT3IgdXNlIGENCj4gPiBzaW1wbHkgd2F5
IHRvIHNob3cgdGhlIG1hc3RlciByZWxhdGlvbiBzaGlwDQo+ID4gDQo+ID4gbW1zeXMtc3ViZGV2
ID0gPCZvdmwwLCAmcmRtYTAsICZjb2xvcjAsIC4uLj4sIDwmb3ZsMSwgJnJkbWExLA0KPiA+ICZj
b2xvcjEsDQo+ID4gLi4uPjsNCj4gPiANCj4gDQo+IFRoZXJlJ3Mgbm8gbmVlZCB0byBsaXN0IGFs
bCBvZiB0aGUgVkRPMC9WRE8xL21tc3lzIGRldmljZXMgaW4gb25lIGJpZw0KPiBhcnJheQ0KPiBw
cm9wZXJ0eSwgYmVjYXVzZSB0aGUgYWN0dWFsIHBvc3NpYmxlIGRldmljZXMgY2FuIGJlIGRlZmlu
ZWQ6DQo+ICAgIDEuIEluIHRoZSBiaW5kaW5nczsgYW5kDQo+ICAgIDIuIEluIHRoZSBhY3R1YWwg
T0YgZ3JhcGggdGhhdCB3ZSB3cml0ZSBmb3IgZWFjaCBTb0MrYm9hcmQNCj4gY29tYmluYXRpb24u
DQo+IA0KPiBBIGdyYXBoIGNhbm5vdCBjb250YWluIGEgY29ubmVjdGlvbiB0byBhIGRldmljZSB0
aGF0IGNhbm5vdCBiZQ0KPiBjb25uZWN0ZWQgdG8NCj4gdGhlIHByZXZpb3VzLCBzbywgeW91ciAi
bW1zeXMtc3ViZGV2IiBsaXN0IGNhbiBiZSByZXRyaWV2ZWQgYnkNCj4gbG9va2luZyBhdCB0aGUN
Cj4gZ3JhcGg6DQo+ICAgLSBTdGFydCBmcm9tIFZETzAvMSBvciBNTVNZUw0KPiAgIC0gV2FsayB0
aHJvdWdoICh2aXN1YWxseSwgZXZlbikgT1VUUFVUIHBvcnRzDQo+ICAgICAtIFZETzAgKHJlYWQg
b3V0cHV0IGVwKSAtPiBvdmwwIChyZWFkIG91dHB1dCBlcCkgLT4gcmRtYTAgKHJlYWQNCj4gb3V0
cHV0IGVwKSAtPg0KPiAgICAgICBjb2xvcjAgKC4uLikgLT4gZXRjDQo+ICAgLSBOb3RoaW5nIG1v
cmUgLSBpdCdzIGFsbCBkZWZpbmVkIHRoZXJlLg0KPiANCj4gPiANCj4gPiBBbm90aGVyIHByb2Js
ZW0gaXMgaG93IHRvIGdyb3VwIGRpc3BsYXkgZGV2aWNlPyBJZiB0d28gcGlwZWxpbmUNCj4gPiBj
b3VsZA0KPiA+IGJlIHJvdXRlIHRvIHRoZSBzYW1lIGRpc3BsYXkgaW50ZXJmYWNlLCBzdWNoIGFz
DQo+ID4gDQo+ID4gcmRtYTAgLT4gZHNpDQo+ID4gcmRtYTEgLT4gZHNpDQo+ID4gDQo+ID4gV291
bGQgdGhpcyBiZSBzaW5nbGUgZ3JvdXA/DQo+IA0KPiBUaGVyZSBhcmUgbXVsdGlwbGUgd2F5cyBv
ZiBkb2luZyB0aGlzLCBidXQgb25lIHRoYXQgY29tZXMgdG8gbXkgbWluZA0KPiByaWdodCBub3cg
YW5kDQo+IHRoYXQgbG9va3MgY2xlYW4gYXMgd2VsbCBpcyB0aGUgZm9sbG93aW5nOg0KPiANCj4g
b3ZsMEBlZjAxIHsNCj4gICAgIC4uLi4uDQo+ICAgIHBvcnRzIHsNCj4gICAgICBwb3J0QDAgew0K
PiAgICAgICAgcmVnID0gPDA+Ow0KPiAgICAgICAgb3ZsMF9pbjogZW5kcG9pbnQgew0KPiAgICAg
ICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JnZkb3N5czBfb3V0PjsNCj4gICAgICAgIH07DQo+ICAg
ICAgfTsNCg0KSSdtIG5vdCBzdXJlIGhvdyBkbyB5b3UgZGVmaW5lIHRoaXMgcG9ydCBmcm9tIE9W
TCB0byB2ZG9zeXMuIElmIHRoaXMNCnBvcnQgbWVhbnMgJ21hc3RlciByZWxhdGlvbnNoaXAnLCBv
dGhlcnMgY291bGQgYWRkIHBvcnQgaW4gQ09MT1IgdG8NCnBvaW50IHRvIHZkb3N5cyBiZWNhdXNl
IENPTE9SIGFuZCB2ZG9zeXMgaGFzIHRoZSAnbWFzdGVyIHJlbGF0aW9uc2hpcCcNCmFuZCBJIGNv
dWxkIG5vdCByZWplY3QgdGhpcy4gU28gd2UgbmVlZCBtb3JlIHNwZWNpZmljIGRlZmluaXRpb24g
b2YNCnRoaXMgcG9ydC4gT25seSB0aGUgJ2ZpcnN0JyBkZXZpY2UgaW4gcGlwZWxpbmUgY291bGQg
aGF2ZSB0aGlzIHBvcnQ/IEluDQptdDgxNzMsIG9uZSBwaXBlbGluZSBpcyANCg0Kb3ZsIC0+IGNv
bG9yIC0+IGFhbCAtPiBvZCAtPiByZG1hIC0+IHVmbyAtPiBkc2kNCg0KQnV0IHJkbWEgaGFzIGFu
IG9wdGlvbiB0byByZWFkIGRhdGEgZnJvbSBvZCBvciBkaXJlY3RseSBmcm9tIERSQU0uIElmDQpm
cm9tIERSQU0sIHRoZSBwaXBlbGluZSB3b3VsZCBiZSBjaGFuZ2VkIHRvIA0KDQpyZG1hIC0+IHVm
byAtPiBkc2kNCg0KDQpTbyBpdCdzIGNvbmZ1c2VkIHdoaWNoIG9uZSBpcyAnZmlyc3QnLg0KSSBk
b24ndCBrbm93IGhvdyB0byBkZWNpZGUgd2hpY2ggZGV2aWNlIGNvdWxkIHBvaW50IHRvIG1tc3lz
L3Zkb3N5cy4gU28NCnBsZWFzZSBnaXZlIGEgc3BlY2lmaWMgZGVmaW5pdGlvbi4NCg0KUmVnYXJk
cywNCkNLDQoNCj4gDQo+ICAgICAgcG9ydEAxIHsNCj4gICAgICAgIHJlZyA9IDwxPjsNCj4gICAg
ICAgIG92bDBfb3V0MDogZW5kcG9pbnRAMCB7DQo+ICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9
IDwmcmRtYTBfaW4+Ow0KPiAgICAgICAgfTsNCj4gICAgICAgIG92bDBfb3V0MTogZW5kcG9pbnRA
MSB7DQo+ICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmcmRtYTFfaW4+Ow0KPiAgICAgICAg
fTsNCj4gICAgICB9Ow0KPiAgICB9Ow0KPiB9Ow0KPiANCj4gcmRtYTBAMTIzNCB7DQo+ICAgICAu
Li4uLg0KPiAgICBwb3J0cyB7DQo+ICAgICAgcG9ydEAwIHsNCj4gICAgICAgIHJlZyA9IDwwPjsN
Cj4gICAgICAgIHJkbWEwX2luOiBlbmRwb2ludCB7DQo+ICAgICAgICAgIHJlbW90ZS1lbmRwb2lu
dCA9IDwmb3ZsMF9vdXQwPjsgLyogYXNzdW1pbmcgb3ZsMCBvdXRwdXRzIHRvDQo+IHJkbWEwLi4u
Ki8NCj4gICAgICAgIH07DQo+ICAgICAgfTsNCj4gICAgICBwb3J0QDEgew0KPiAgICAgICAgcmVn
ID0gPDE+Ow0KPiAgICAgICAgcmRtYTBfb3V0OiBlbmRwb2ludEAxIHsNCj4gICAgICAgICAgcmVt
b3RlLWVuZHBvaW50ID0gPCZkc2lfZHVhbF9pbnRmMF9pbj47DQo+ICAgICAgICB9Ow0KPiAgICAg
IH07DQo+ICAgIH07DQo+IH07DQo+IA0KPiANCj4gcmRtYTFANTY3OCB7DQo+ICAgICAuLi4uLg0K
PiAgICBwb3J0cyB7DQo+ICAgICAgcG9ydEAwIHsNCj4gICAgICAgIHJlZyA9IDwwPjsNCj4gICAg
ICAgIHJkbWExX2luOiBlbmRwb2ludCB7DQo+ICAgICAgICAgIC8qIGFzc3VtaW5nIG92bDAgb3V0
cHV0cyB0byByZG1hMSBhcyB3ZWxsLi4uIGNhbiBiZQ0KPiBzb21ldGhpbmcgZWxzZS4gKi8NCj4g
ICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZvdmwwX291dDE+Ow0KPiAgICAgICAgfTsNCj4g
ICAgICB9Ow0KPiAgICAgIHBvcnRAMSB7DQo+ICAgICAgICByZWcgPSA8MT47DQo+ICAgICAgICBy
ZG1hMV9vdXQ6IGVuZHBvaW50IHsNCj4gICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkc2lf
ZHVhbF9pbnRmMV9pbj47DQo+ICAgICAgICB9Ow0KPiAgICAgIH07DQo+ICAgIH07DQo+IH07DQo+
IA0KPiANCj4gZHNpQDlhYmNkIHsNCj4gICAgIC4uLi4uDQo+ICAgIHBvcnRzIHsNCj4gICAgICBw
b3J0QDAgew0KPiAgICAgICAgcmVnID0gPDA+Ow0KPiAgICAgICAgLyogV2hlcmUgZW5kcG9pbnRA
MCBjb3VsZCBiZSBhbHdheXMgRFNJIExFRlQgQ1RSTCAqLw0KPiAgICAgICAgZHNpX2R1YWxfaW50
ZjBfaW46IGVuZHBvaW50QDAgew0KPiAgICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JnJkbWEw
X291dD47DQo+ICAgICAgICB9Ow0KPiAgICAgICAgLyogLi4uYW5kIEAxIGNvdWxkIGJlIGFsd2F5
cyBEU0kgUklHSFQgQ1RSTCAqLw0KPiAgICAgICAgZHNpX2R1YWxfaW50ZjFfaW46IGVuZHBvaW50
QDEgew0KPiAgICAgICAgICByZW1vdGUtZW5kcG9pbnQgPSA8JnJkbWExX291dD47DQo+ICAgICAg
ICB9Ow0KPiAgICAgIH07DQo+IA0KPiAgICAgIHBvcnRAMSB7DQo+ICAgICAgICByZWcgPSA8MT47
DQo+ICAgICAgICBkc2kwX291dDogZW5kcG9pbnQgew0KPiAgICAgICAgICByZW1vdGUtZW5kcG9p
bnQgPSA8JmRzaV9wYW5lbF9pbj47DQo+ICAgICAgICB9Ow0KPiAgICAgIH07DQo+ICAgIH07DQo+
IH07DQo+IA0KPiAuLi5mb3IgYSBkdWFsLWRzaSBwYW5lbCwgaXQnZCBiZSBhIHNpbWlsYXIgZ3Jh
cGguDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiANCj4gPiBtbXN5cy1zdWJkZXYg
PSA8JnJkbWEwLCAmcmRtYTEsICZkc2k+Ow0KPiA+IA0KPiA+IE9yIHR3byBncm91cD8NCj4gPiAN
Cj4gPiBtbXN5cy1zdWJkZXYgPSA8JnJkbWEwLCAmZHNpPiwgPCZyZG1hMSwgJmRzaT47DQo+ID4g
DQo+ID4gSSB0aGluayB3ZSBzaG91bGQgY2xlYXJseSBkZWZpbmUgdGhpcy4NCj4gPiANCj4gPiBS
ZWdhcmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gQ2hlZXJzLA0KPiA+
ID4gQW5nZWxvDQo+ID4gPiANCj4gPiA+ID4gUmVnYXJkcywNCj4gPiA+ID4gQ0sNCj4gPiA+ID4g
DQo+ID4gPiA+IA0KPiA+ID4gPiA+ICAgIHJlcXVpcmVkOg0KPiA+ID4gPiA+ICAgICAgLSBjb21w
YXRpYmxlDQo+ID4gPiA+ID4gICAgICAtIHJlZw0KPiA+ID4gDQo+ID4gPiANCj4gDQo+IA0KPiAN
Cg==

