Return-Path: <linux-kernel+bounces-293507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A369580AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C98284462
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B13189916;
	Tue, 20 Aug 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bLl4pncN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="J21t7S5l"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46918E347
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141807; cv=fail; b=N460B8LZhIVC5g8h6I6n6E5dNIX5qLa0nL22sLWLyH6vnrIgNpD7K/NaJ6k26RXX8VztQLv/ULpS/2VI7k3gcmExN6eKACCoiL+a78Vb/Qy0tnJCmaOYFpr54VeaOFWwi1VrDYy9jjsWZE9uqLu40KeYl2C/8tUPdnnK5ccwJ2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141807; c=relaxed/simple;
	bh=YI/AYCaJtBGRiYE78SOVUvtAEl4txShOAKoQet1/xBA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tq7bTfqzW8DpvGirZMGyfYle9lQBDlSSqCI6n5yHx4xT1MuDsm7Ca7S47mPDVbMGa6LTpTLpYvSD+pUlWxANM47KgPgSa9w63CdlEz/dyIjseXP5Am+RhJERyylNQxmL6xnlIi2DYYzEpGgnwgEmb7bP5YQBDxTMbax9uR2iMqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bLl4pncN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=J21t7S5l; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 841547805ecc11ef8593d301e5c8a9c0-20240820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YI/AYCaJtBGRiYE78SOVUvtAEl4txShOAKoQet1/xBA=;
	b=bLl4pncN8sK/hmHl75RfR1yV1GGour8ZL7UfkZMQaIAP0GTo4F/Z1aTIWu9Ep03aFsCIoWDyY/BNSiWbmEcHjUgghEB6sl/DGThN7ErQcz6WU9y15beZh/1swha+MwWGjgNJ0/dscM6z468ik0YcTGxnF/RIMtHfin4T/T92UKY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:e4b41d74-094b-4d80-9e73-85c32ae59bac,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:ee30bb5b-248b-45cb-bde8-d789f49f4e1e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 841547805ecc11ef8593d301e5c8a9c0-20240820
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1157644383; Tue, 20 Aug 2024 16:16:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 20 Aug 2024 16:16:36 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 20 Aug 2024 16:16:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UB1/H1Gsx1hYDCf8BgJf/K5JnNF9cJuID386o3yws19UV3Mo0NzXkqlii05O3/YHIs8WPacocaNKVYWHbI16devMolnjjuIkLGirsPki6U8rS0bKKx7VTDNputyycsrYe7BYUa0eKdrNDTUW00c3gFJoMfpc4WmqHpaJ3GKBz0BnldSJgDN0Pq9QYbVX901MCx3MGmvTS7XpITmb1KXA5BcjnGuerIGmxqTPSFmszuJcPDlwpSC0MN5IW6zVq4dkLyGjnhjzBktt+e3aGgze5Z/SFT8qVmJyPRXLwLYkhadP9kjQCIBK8MLBcn8PZCztcZgMV2HsQayuCDsS5eMtqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI/AYCaJtBGRiYE78SOVUvtAEl4txShOAKoQet1/xBA=;
 b=BjhjWvYejxCrX3ULDZk8F/T2m4KW1bnXvV1ZUtlpyxU0bI2RH8PXKOEtl5ogInapch7fS0HXcQvCQodYk319kpiCIdW4n00RshroDeJFNIIu8wRpUzYZQxPzXLF9NdUqQ16lvAmVl8Lr36MntDYMT3aXRk1EGL9t7jy9UdTvJH25izI7GkSm6Wg2+8tA/eCT7ZYdg+3CqzpQT+53LF+16gAOmxNU+ZiPOYQvYqGGcljylkzXsPKHc6CytYzN0OF3ZotGQRw5VUt/uPaoBxGD2sBtPKguV/dIoPKs3G5ikcoJh9km/5OXQzAaIkaqpk0MpRKM0pbgSELChE3Kh4nYLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI/AYCaJtBGRiYE78SOVUvtAEl4txShOAKoQet1/xBA=;
 b=J21t7S5le+tQuiPYz2bxR6w6ZSiYaMhvKdakP8Jooj4bIA9lp8qB6+BeJtTvCX6rm+gND85m6f5BKODyfWhKFD0pExym2nxptsQE1a1Zn0tFjiHJCpmg8sJig3iCd7N2OtbselBmPvKSpis6rJjU9MaUJAGdY/qfg1iKus4LnvI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6631.apcprd03.prod.outlook.com (2603:1096:400:210::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 08:16:34 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 08:16:33 +0000
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
Subject: Re: [PATCH v7] drm/mediatek: dsi: Add dsi per-frame lp code for
 mt8188
Thread-Topic: [PATCH v7] drm/mediatek: dsi: Add dsi per-frame lp code for
 mt8188
Thread-Index: AQHa8f8wtfVzKseX6E6psjwQxwcMW7IvzokA
Date: Tue, 20 Aug 2024 08:16:33 +0000
Message-ID: <2aad3b8457b59610b5de193a4173bf7b82278aa7.camel@mediatek.com>
References: <20240819061333.26069-1-shuijing.li@mediatek.com>
In-Reply-To: <20240819061333.26069-1-shuijing.li@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6631:EE_
x-ms-office365-filtering-correlation-id: 28561c85-49f0-47f1-60be-08dcc0f06760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?azZWTTZXcjNYbk1rWlNlRFpVWmMvT2cza01qbzZ4WFVrS0NISXhHVnRia0pT?=
 =?utf-8?B?a21sdEdPRHF4QVdjbDM5emlCbENkdVYvWEtGaDRJZ2dLQWV0b0h0OC8vUnAy?=
 =?utf-8?B?Y0Nsbnpiam16UzRpZnJGZzAwTVlvV0lBQkswOWc1T0M1TGVWSjEzUnhBUDkr?=
 =?utf-8?B?dVFUTXQ1N3kwbXZndlBOTGE1U2ZObDcrV0tyMm9jUWdxQ1p0cEpMNitsNWhp?=
 =?utf-8?B?TVh6YVU4QzRzUkpRN3UxK2dBT0V2Y2xlNTM4dnBDYVpsWGwwbVhjSWRHTEsy?=
 =?utf-8?B?SnJxK3ovbEI3WVArSnlnSTZESllJVUhyeW5SKzliZ1VIeUpWVmJXekM5dVlu?=
 =?utf-8?B?bDd3Z2wyL3g3WHM3WENhcEZ2MmZvZkM0M093QlJRS2xXaUsybmg0dkpsTWI4?=
 =?utf-8?B?OTZKWDlSUnMySktjVVZPYUJPcUx6bGNLQjJNZkVGUEV1SnlFbVNsRVBrZ2Ey?=
 =?utf-8?B?bGN6R0dLMmxvdjU2aUx0Y2JFd1pxcS9jOXdyKzd2SFFrK2NXSWJPdW5FalRJ?=
 =?utf-8?B?aWtzc1Fkd3g0WmdFSlNWdElhNmhjOW9qTHFHQU5oNmowb1VrS1JabEp4WG5F?=
 =?utf-8?B?OHErQlRVZitIdVRFUFpQa1o5M05LWlVJVHZHcDJBTHlBMC9UYXJFRlU2a1Y2?=
 =?utf-8?B?QkpnVTFCelVaOVJZUE5WeWhzR3lvdU01d2FRKzZwQ2lYanZYbFN1T0UrUXQ1?=
 =?utf-8?B?cmhyL2Jxd3o3NFZSc3JGWHRCZ3o0aU1RRHloYlA0OVFaUCswWHBIdVdLSzgz?=
 =?utf-8?B?SUgxWVY2czlPNUxCdE1MMG9FVjBWMy9xU0NSUnpPbGZ1QzE3Q05TU0ZjZmtF?=
 =?utf-8?B?dzZjdXNOMWhZdnljcVUvM214aEtWdWVZVEZmdGkxdE1ONHZwOURxdDdLTTJK?=
 =?utf-8?B?cDRLWW5UNlE2cE1mMFdRb0JVeEtNbS9TK0w0aXAzZHV4QUxvVVhDenZkcVJJ?=
 =?utf-8?B?UnpsRy9VRS9DWndOTUJXUjJ0cmpyUmhOWHpqTFUwTWNDcldLRGhkbGdUdzNL?=
 =?utf-8?B?ODJEbGQzMjJRWlVyRmJ2L0t1dzR1ZWltZDhLeHMwNkZZb3NJYitWNWQzUnhU?=
 =?utf-8?B?aXFpcUtiUkFmQ3laRk0yNlhjaUtzWVNldnpZbG5hYitpMWMvRlpGSlo1aytD?=
 =?utf-8?B?MWc4bFNsZWZWMHRVai9KakVPa1BQaC9DUW5mSkJHNGFjb0VOZlJsNUN5Ymdq?=
 =?utf-8?B?aGU0Z245SEZKK3NNOTNnMW1PRFh1aHZTMkhkbElWck9td21tR1J1ZUZOQjdS?=
 =?utf-8?B?aVpJcGpRcEZzdCt1SGhVZ3gyQjhDRXA5SEpFdmlxRTM1U1NHQ01qUmdoUjRQ?=
 =?utf-8?B?SndYRWg3RnZUdmE3bG1rSi8vV3NFV1Jvcis5SHIwOVZNR1NUTUk5eFNIVHZ6?=
 =?utf-8?B?c0tQYjdyT2taWnViZVdmTEo3L2o0c2tGcWhnT2xZQjNGNU5qVGNFd25PUEQr?=
 =?utf-8?B?R2ltYjFHMndvRXEyb21QNW1xUm1TckFiZ290WGNrcC83TmFuREY4WmI1VDJq?=
 =?utf-8?B?bjZXT3ZqZmhEdWlNTHhSakQyRWZMSlR6KzllVzJoTDJiSFc4eTFKZXJmMGJp?=
 =?utf-8?B?MU5Bbk9zWFBmR3o1amxnclAzWUVOTlJxeC9kd3RUVHJUajFHTG1vaGlGYTNa?=
 =?utf-8?B?UjYvNjI5V1hzUDVUcjNLWGxKTS9tR2Z2UmkxVWlNMGw3eDVPOERaZ3gwVmdy?=
 =?utf-8?B?VDhCZVhpRWJHY1dUeVBBbGlIWHhNK094VmNTUFVvQmdMMTczMEpxbTh1RjhK?=
 =?utf-8?B?a0JybGdlRms1dUdoREhjSjdTN0t2U002eEN2OG9DZmV1Qk0relVEelppTzNu?=
 =?utf-8?Q?wU4pACQDsUYvNmJc9W69a19+ECcJwmYAM3GG8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VnJVMkRGa29SeCsxYzdCMWw1cVpweUFLUkNjdE54aE1yeE9qOFQvdi9PWlV5?=
 =?utf-8?B?RnRZbk1LR3Yzb2xYdkJHclVrOEl5Z2ZiOVJqc01CYU9ta2FDall2WEEyb0dl?=
 =?utf-8?B?RjVMYUdsSzZPVk12TEJNVEwzV09halh4eE5iZlgyV3VXV3dwZFZHYm9yMWZQ?=
 =?utf-8?B?a2QxUElORGE3ajJlSi9IYk9ZWStlSHZ3YjNDcFZRRUZscXhuSEZRMjF6eHkz?=
 =?utf-8?B?VFJnRUdUNFdZN0FKVmtyNjhEOFlzdnIyY3NXR01TVlpta05RSUxZOXd2RFcx?=
 =?utf-8?B?NUJlZHV4eGtIZTluQyttd2RwbE14SUVEK2ZPWXVIQlVjTTlqY3NKNFV0Uzcw?=
 =?utf-8?B?UmdXZ25sS1hnWURocFZvOXdBQTdzSXYwcTBUbWtrNzFobjlVa09FYnIwVUtU?=
 =?utf-8?B?SzY2L1NmQzBtUVdrSTRQZ0RoNjBob2dmQ0RFMWNVV05OM0JhUzJNd3dhaG0w?=
 =?utf-8?B?NHBYN2NiSjZWSEQvUEFKVTBqU2hDaVYwMXhZMHhBSm9FdlIwR2dlR2FhdDRo?=
 =?utf-8?B?Qm4zbHEyVGNmSFJrK29zMFdJRUxNSituaG96OEo3aktKL2VDVkQvVkJ0Y0dL?=
 =?utf-8?B?NkFzZ3dEaVhKSkM5OE00V0pBRFA0cFZ1M1VkU3lHMWQvcGV4ek9COEIxVm1y?=
 =?utf-8?B?TDBLNmRGM2NNTmxOQnBoUmRxUXY3V1ZnYzMyY054ZDJjV3FhL3cxNE1aeWV1?=
 =?utf-8?B?cmpITEQweW5pd25wdUtNUTExV3lmV1hJdFFwTEEyd1ZSTVcrUVdMTmR1TDN6?=
 =?utf-8?B?SGhBLy9IbHV4K0h1WGR2cldIUEFFc3hkRXNwQ0Mxb1o4VkNaRFpaeTlLcE5Z?=
 =?utf-8?B?Wm5LTldhNFFVOVhNcG5MWnhLTDhOTXFTL1FhKzZxUTA1K2hYenlTa3pSY1Br?=
 =?utf-8?B?Tnc4QitmRkl0Snl2bjNORHh6UWo3S0MrK3dMY2o5bnZpaThmYmlxVVhTUWZt?=
 =?utf-8?B?TXE4ZHR3dG9xa0szb0hxNU5XcXdNdUlSZmtpMHlMSXFVaXlHSXlTNGJhOEJl?=
 =?utf-8?B?b05xMDRCdHUzdXhrZW0wdXJsWFQrd2RFNU1HY3lXSEhCeGhpOEcrUTR0Z2VC?=
 =?utf-8?B?VmgxazdMWE10eVAraDVJS0pRRzVRUUZGVWNwK0ZHb0EvVS9TdDVzMFc1eHRL?=
 =?utf-8?B?QlBFakt4U2V2eDZXb3BmRXNqdlducjA3bXIydk5rV0FTWStkcGY0aTl2dGlv?=
 =?utf-8?B?LzZ1VDhaK2FuSG0zd01VWVZKT1UyMGFkbXN2S2ZTWllBNXdUUXIwMzVMeGV1?=
 =?utf-8?B?VGhlSkR3OTc2WHYrRXZmbXE4cGtvNWFkSW5SL25rNFdIZTI3NWJOcGM3akhS?=
 =?utf-8?B?VUVUSFNBRXhNTWhhMkpYaVFOano1aHNFNkFIUmVrWCt2a0dMVlBJb2hDZXky?=
 =?utf-8?B?ZWpweHhkeC9TRUtQM0Q3bjFYWXJCeElSTkVLd2VmZHprL0RYRGRST1orNVdH?=
 =?utf-8?B?bitKYktBNUZxL0xxMG9Nd05IZ0RIaEVQYmFFaHhPOTVJL2d0L3o2ZTRmNEJ3?=
 =?utf-8?B?TlVITnBtRzVvSnQ4dDRZZVB3SEZCRmFTZDQ3UHNrODd5SlJ4dWNOOXlvdGZ2?=
 =?utf-8?B?bUI2NVhUcktrMnRzUmoxQkVJajdvTWd2SXEzczlKVGlRQ1ppTGRDQXhmbkh6?=
 =?utf-8?B?U2Q4ZjF3eHRMUGNPaW5VbE1JZitOeVYwZ1JLdVhIOUROMlJHUWNRc0hiS0Ey?=
 =?utf-8?B?c0ppaThkekVpSkFiN2h3ZytNRjNtRzZjUkQzVW8vdnF4MTczWU9xVmhIRTFT?=
 =?utf-8?B?d0NMTzBmSjdKUzVKcGVVaVR2Vy9vajlxdVY1SFRVTVlpQyswYnAvTEtDeVpR?=
 =?utf-8?B?VnVwT1hqUjQxaHRkQkxpaEIwMkVTQ2pVR1hiNHkvaUJ3Tng1bWMzeXVLWk0x?=
 =?utf-8?B?blBLekhwQmUrRkdXV1U0VGhEQ0ZldzBMK21xdVZwUldXVGRuSTdzbzk1M0V2?=
 =?utf-8?B?UUs2cXdqSjFuT1ZJYjh4WVhCVlJXYm85NSs0MlJwNU5kS3ZuMGJkMXJmak1z?=
 =?utf-8?B?eGtaS1l0UEc1dks0V292dXErMjdGTzN2RlJCUjgzZE1HTzdIR3ZLZHA0YmNH?=
 =?utf-8?B?Zy8zZXBtczltakp2RDVhUlE4RU1TajNXUWlxR1ZJSkUwT0lMaUpCUHl3UjFn?=
 =?utf-8?Q?fKsi0la99QKaPChcpzschSHUq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C669E3DC10123445919845570F3A810C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28561c85-49f0-47f1-60be-08dcc0f06760
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 08:16:33.8325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dsw9onj9PPDp0r23DwJs/b918WGC3i/IB5gG+z+EjVtMAMtAlF8yv+j6rdIYu0rw52uZD13gWpG7XqCgstJwxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6631
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.658800-8.000000
X-TMASE-MatchedRID: 6lay9u8oTUP4OiVTWoD8RCa1MaKuob8PC/ExpXrHizxEv26FkhjLXeV8
	LPcEXtiPjsBcM2F2TRSZ5n4hM5k0ap1OGPOtOV85l1zsjZ1/6axzd7C7BtJobkYEesEnx9CcYyz
	kaNcuq8brCObItrgydK5Vf30gK3qOIDV2A6Nq0YZc/msUC5wFQQJ+D+xbilRQ+Cckfm+bb6A9CU
	on0NTGeSFZ3JyEu+QIEqqN2VH6x4ctVrIvuTuiXEf49ONH0RaSuLwbhNl9B5UKogmGusPLb0bbW
	GO0926T5w0QFqEJvEn9ucjG71be1sbuRySLCCtPogGd8wIUGIJOGffsUU/kDXyKcwQTdriqyfcK
	xGqFmq/dvO9TrNr2cCU8+kfVnvjCXnJwiKaI+/qO0rt0LpQGebn7V+KB+3cumyiLZetSf8n5kvm
	j69FXvEpZ1N/CwmPL9BIhiTDfOc2tIWznhjjBtfoLR4+zsDTtFAQvQYa7pINKOPI2zqVUoMggk5
	H23+1oa1vjkNlo+reszP6KrvVaFw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.658800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9F85EBB7AE23680AB7BB9B4CE8D8D7CE57EA20A8EA3E9D70C982553B24049CB62000:8

SGksIFNodWlqaW5nOg0KDQpPbiBNb24sIDIwMjQtMDgtMTkgYXQgMTQ6MTIgKzA4MDAsIFNodWlq
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
Pg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2NzoNCj4gRml4IGNvZGUgc3R5bGUgYW5kIHNpbXBsaWZ5
IHRoZSBjb2RlIHBlciBzdWdnZXN0aW9uIGZyb20gcHJldmlvdXMgdGhyZWFkOg0KPiBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0
L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjQwODEzMDIyMzE1LjE4NTAyLTEtc2h1aWppbmcubGlA
bWVkaWF0ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IWxUSFk5enItaXhwM0NVbGdWbXBTWXpo
X3RrN19QSFhmeFRKZ3Y1NmVQWjhFekJsTDJLOVdBMzN1WDVuU1RRclVwcVh0UElMNTRzeVRSMWpo
blAwX3FBJCANCj4gQ2hhbmdlcyBpbiB2NjoNCj4gU2ltcGxpZnkgdGhlIGNvZGUgcGVyIHN1Z2dl
c3Rpb24gZnJvbSBwcmV2aW91cyB0aHJlYWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMv
X19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0
Y2gvMjAyNDA4MTIwNzAzNDEuMjYwNTMtMS1zaHVpamluZy5saUBtZWRpYXRlay5jb20vX187ISFD
VFJOS0E5d01nMEFSYnchbFRIWTl6ci1peHAzQ1VsZ1ZtcFNZemhfdGs3X1BIWGZ4VEpndjU2ZVBa
OEV6QmxMMks5V0EzM3VYNW5TVFFyVXBxWHRQSUw1NHN5VFIxajQ1Skd5N2ckIA0KPiBDaGFuZ2Vz
IGluIHY1Og0KPiBGaXggY29kZSBzdHlsZSBpc3N1ZSBhbmQgYWRkIHBlci1saW5lLWxwIGZ1bmN0
aW9uIHRvIGJlIHN5bW1ldHJpY2FsIHdpdGggcGVyLWZyYW1lLWxwLg0KPiBwZXIgc3VnZ2VzdGlv
biBmcm9tIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8y
MDI0MDgwMTA4MTE0NC4yMjM3Mi0xLXNodWlqaW5nLmxpQG1lZGlhdGVrLmNvbS9fXzshIUNUUk5L
QTl3TWcwQVJidyFsVEhZOXpyLWl4cDNDVWxnVm1wU1l6aF90azdfUEhYZnhUSmd2NTZlUFo4RXpC
bEwySzlXQTMzdVg1blNUUXJVcHFYdFBJTDU0c3lUUjFpeDFLWi1idyQgDQo+IENoYW5nZXMgaW4g
djQ6DQo+IERyb3AgdGhlIGNvZGUgcmVsYXRlZCB0byBibGxwX2VuIGFuZCBibGxwX3djLCBhZGp1
c3QgcHNfd2MgdG8gZHNpLT52bS5oYWN0aXZlICoNCj4gZHNpX2J1Zl9icHAuDQo+IENoYW5nZXMg
aW4gdjM6DQo+IFVzZSBmdW5jdGlvbiBpbiBiaXRmaWVsZC5oIGFuZCBnZXQgdmFsdWUgZnJvbSBw
aHkgdGltaW5nLCBwZXIgc3VnZ2VzdGlvbg0KPiBmcm9tIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJv
amVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDI0MDQyNDA5MTYzOS4yMjc1OS0xLXNodWlqaW5n
LmxpQG1lZGlhdGVrLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyFsVEhZOXpyLWl4cDNDVWxnVm1w
U1l6aF90azdfUEhYZnhUSmd2NTZlUFo4RXpCbEwySzlXQTMzdVg1blNUUXJVcHFYdFBJTDU0c3lU
UjFna0tiZndLUSQgDQo+IENoYW5nZXMgaW4gdjI6DQo+IFVzZSBiaXRmaWVsZCBtYWNyb3MgYW5k
IGFkZCBuZXcgZnVuY3Rpb24gZm9yIHBlciBwcmFtZSBscCBhbmQgaW1wcm92ZQ0KPiB0aGUgZm9y
bWF0LCBwZXIgc3VnZ2VzdGlvbiBmcm9tIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxk
ZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51
eC1tZWRpYXRlay9wYXRjaC8yMDI0MDMxNDA5NDIzOC4zMzE1LTEtc2h1aWppbmcubGlAbWVkaWF0
ZWsuY29tL19fOyEhQ1RSTktBOXdNZzBBUmJ3IWxUSFk5enItaXhwM0NVbGdWbXBTWXpoX3RrN19Q
SFhmeFRKZ3Y1NmVQWjhFekJsTDJLOVdBMzN1WDVuU1RRclVwcVh0UElMNTRzeVRSMWdRRlNJQU5n
JCANCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgMTEwICsr
KysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOTggaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMNCj4gaW5kZXggYjZlM2MwMTFhMTJkLi41ODUxOGYzMjU3YTggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYw0KPiBAQCAtODgsMTIgKzg4LDE1IEBADQo+ICAjZGVmaW5lIERT
SV9IU0FfV0MJCTB4NTANCj4gICNkZWZpbmUgRFNJX0hCUF9XQwkJMHg1NA0KPiAgI2RlZmluZSBE
U0lfSEZQX1dDCQkweDU4DQo+ICsjZGVmaW5lIEhGUF9IU19WQl9QU19XQwkJR0VOTUFTSygzMCwg
MTYpDQo+ICsjZGVmaW5lIEhGUF9IU19FTgkJCUJJVCgzMSkNCj4gIA0KPiAgI2RlZmluZSBEU0lf
Q01EUV9TSVpFCQkweDYwDQo+ICAjZGVmaW5lIENNRFFfU0laRQkJCTB4M2YNCj4gICNkZWZpbmUg
Q01EUV9TSVpFX1NFTAkJQklUKDE1KQ0KPiAgDQo+ICAjZGVmaW5lIERTSV9IU1RYX0NLTF9XQwkJ
MHg2NA0KPiArI2RlZmluZSBIU1RYX0NLTF9XQwkJCUdFTk1BU0soMTUsIDIpDQo+ICANCj4gICNk
ZWZpbmUgRFNJX1JYX0RBVEEwCQkweDc0DQo+ICAjZGVmaW5lIERTSV9SWF9EQVRBMQkJMHg3OA0K
PiBAQCAtMTg3LDYgKzE5MCw3IEBAIHN0cnVjdCBtdGtfZHNpX2RyaXZlcl9kYXRhIHsNCj4gIAli
b29sIGhhc19zaGFkb3dfY3RsOw0KPiAgCWJvb2wgaGFzX3NpemVfY3RsOw0KPiAgCWJvb2wgY21k
cV9sb25nX3BhY2tldF9jdGw7DQo+ICsJYm9vbCBzdXBwb3J0X3Blcl9mcmFtZV9scDsNCj4gIH07
DQo+ICANCj4gIHN0cnVjdCBtdGtfZHNpIHsNCj4gQEAgLTQyNiw3ICs0MzAsNzkgQEAgc3RhdGlj
IHZvaWQgbXRrX2RzaV9wc19jb250cm9sKHN0cnVjdCBtdGtfZHNpICpkc2ksIGJvb2wgY29uZmln
X3ZhY3QpDQo+ICAJd3JpdGVsKHBzX3ZhbCwgZHNpLT5yZWdzICsgRFNJX1BTQ1RSTCk7DQo+ICB9
DQo+ICANCj4gLXN0YXRpYyB2b2lkIG10a19kc2lfY29uZmlnX3Zkb190aW1pbmcoc3RydWN0IG10
a19kc2kgKmRzaSkNCj4gK3N0YXRpYyB2b2lkIG10a19kc2lfY29uZmlnX3Zkb190aW1pbmdfcGVy
X2ZyYW1lX2xwKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICt7DQo+ICsJdTMyIGhvcml6b250YWxf
c3luY19hY3RpdmVfYnl0ZTsNCj4gKwl1MzIgaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZTsNCj4g
Kwl1MzIgaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGU7DQo+ICsJdTMyIGhmcF9ieXRlX2FkanVz
dCwgdl9hY3RpdmVfYWRqdXN0Ow0KPiArCXUzMiBja2xwX3djX21pbl9hZGp1c3QsIGNrbHBfd2Nf
bWF4X2FkanVzdDsNCj4gKwl1MzIgZHNpX3RtcF9idWZfYnBwOw0KPiArCXVuc2lnbmVkIGludCBk
YV9oc190cmFpbDsNCj4gKwl1bnNpZ25lZCBpbnQgcHNfd2MsIGhzX3ZiX3BzX3djOw0KPiArCXUz
MiB2X2FjdGl2ZV9yb3VuZHVwLCBoc3R4X2NrbHBfd2M7DQo+ICsJdTMyIGhzdHhfY2tscF93Y19t
YXgsIGhzdHhfY2tscF93Y19taW47DQo+ICsJc3RydWN0IHZpZGVvbW9kZSAqdm0gPSAmZHNpLT52
bTsNCj4gKw0KPiArCWlmIChkc2ktPmZvcm1hdCA9PSBNSVBJX0RTSV9GTVRfUkdCNTY1KQ0KPiAr
CQlkc2lfdG1wX2J1Zl9icHAgPSAyOw0KPiArCWVsc2UNCj4gKwkJZHNpX3RtcF9idWZfYnBwID0g
MzsNCj4gKw0KPiArCWRhX2hzX3RyYWlsID0gZHNpLT5waHlfdGltaW5nLmRhX2hzX3RyYWlsOw0K
PiArCXBzX3djID0gdm0tPmhhY3RpdmUgKiBkc2lfdG1wX2J1Zl9icHA7DQo+ICsNCj4gKwlpZiAo
ZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9WSURFT19TWU5DX1BVTFNFKSB7DQo+ICsJ
CWhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZSA9DQo+ICsJCQl2bS0+aHN5bmNfbGVuICogZHNp
X3RtcF9idWZfYnBwIC0gMTA7DQo+ICsJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgPQ0KPiAr
CQkJdm0tPmhiYWNrX3BvcmNoICogZHNpX3RtcF9idWZfYnBwIC0gMTA7DQo+ICsJCWhmcF9ieXRl
X2FkanVzdCA9IDEyOw0KPiArCQl2X2FjdGl2ZV9hZGp1c3QgPSAzMiArIGhvcml6b250YWxfc3lu
Y19hY3RpdmVfYnl0ZTsNCj4gKwkJY2tscF93Y19taW5fYWRqdXN0ID0gMTIgKyAyICsgNCArIGhv
cml6b250YWxfc3luY19hY3RpdmVfYnl0ZTsNCj4gKwkJY2tscF93Y19tYXhfYWRqdXN0ID0gMjAg
KyA2ICsgNCArIGhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZTsNCj4gKwl9IGVsc2Ugew0KPiAr
CQlob3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGUgPSB2bS0+aHN5bmNfbGVuICogZHNpX3RtcF9i
dWZfYnBwIC0gNDsNCj4gKwkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9ICh2bS0+aGJhY2tf
cG9yY2ggKyB2bS0+aHN5bmNfbGVuKSAqDQo+ICsJCQlkc2lfdG1wX2J1Zl9icHAgLSAxMDsNCj4g
KwkJY2tscF93Y19taW5fYWRqdXN0ID0gNDsNCj4gKwkJY2tscF93Y19tYXhfYWRqdXN0ID0gMTIg
KyA0ICsgNDsNCj4gKwkJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX01PREVfVklERU9f
QlVSU1QpIHsNCj4gKwkJCWhmcF9ieXRlX2FkanVzdCA9IDE4Ow0KPiArCQkJdl9hY3RpdmVfYWRq
dXN0ID0gMjg7DQo+ICsJCX0gZWxzZSB7DQo+ICsJCQloZnBfYnl0ZV9hZGp1c3QgPSAxMjsNCj4g
KwkJCXZfYWN0aXZlX2FkanVzdCA9IDIyOw0KPiArCQl9DQo+ICsJfQ0KPiArCWhvcml6b250YWxf
ZnJvbnRwb3JjaF9ieXRlID0gdm0tPmhmcm9udF9wb3JjaCAqIGRzaV90bXBfYnVmX2JwcCAtIGhm
cF9ieXRlX2FkanVzdDsNCj4gKwl2X2FjdGl2ZV9yb3VuZHVwID0gKHZfYWN0aXZlX2FkanVzdCAr
IGhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgKyBwc193YyArDQo+ICsJCQkgICBob3Jpem9udGFs
X2Zyb250cG9yY2hfYnl0ZSkgJSBkc2ktPmxhbmVzOw0KPiArCWlmICh2X2FjdGl2ZV9yb3VuZHVw
KQ0KPiArCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlICs9IGRzaS0+bGFuZXMgLSB2X2FjdGl2
ZV9yb3VuZHVwOw0KPiArCWhzdHhfY2tscF93Y19taW4gPSAoRElWX1JPVU5EX1VQKGNrbHBfd2Nf
bWluX2FkanVzdCwgZHNpLT5sYW5lcykgKyBkYV9oc190cmFpbCArIDEpDQo+ICsJCQkgICAqIGRz
aS0+bGFuZXMgLyA2IC0gMTsNCj4gKwloc3R4X2NrbHBfd2NfbWF4ID0gKERJVl9ST1VORF9VUCgo
Y2tscF93Y19tYXhfYWRqdXN0ICsgaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSArDQo+ICsJCQkg
ICBwc193YyksIGRzaS0+bGFuZXMpICsgZGFfaHNfdHJhaWwgKyAxKSAqIGRzaS0+bGFuZXMgLyA2
IC0gMTsNCj4gKw0KPiArCWhzdHhfY2tscF93YyA9IEZJRUxEX0dFVChIU1RYX0NLTF9XQywgcmVh
ZGwoZHNpLT5yZWdzICsgRFNJX0hTVFhfQ0tMX1dDKSk7DQo+ICsNCj4gKwlpZiAoaHN0eF9ja2xw
X3djIDw9IGhzdHhfY2tscF93Y19taW4gfHwgaHN0eF9ja2xwX3djID49IGhzdHhfY2tscF93Y19t
YXgpIHsNCj4gKwkJaHN0eF9ja2xwX3djID0gRklFTERfUFJFUChIU1RYX0NLTF9XQywgKGhzdHhf
Y2tscF93Y19taW4gKyBoc3R4X2NrbHBfd2NfbWF4KSAvIDIpOw0KPiArCQl3cml0ZWwoaHN0eF9j
a2xwX3djLCBkc2ktPnJlZ3MgKyBEU0lfSFNUWF9DS0xfV0MpOw0KPiArCX0NCg0KSWYgKGhzdHhf
Y2tscF93Y19taW4gKyBoc3R4X2NrbHBfd2NfbWF4KSAvIDIgaXMgYW4gYWNjZXB0YWJsZSB2YWx1
ZSwNCldoeSBub3QgZGlyZWN0bHkgd3JpdGUgaXQgaW50byBEU0lfSFNUWF9DS0xfV0Mgd2l0aG91
dCBjaGVjayAiaHN0eF9ja2xwX3djIDw9IGhzdHhfY2tscF93Y19taW4gfHwgaHN0eF9ja2xwX3dj
ID49IGhzdHhfY2tscF93Y19tYXgiLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICsJaHNfdmJf
cHNfd2MgPSBwc193YyAtIChkc2ktPnBoeV90aW1pbmcubHB4ICsgZHNpLT5waHlfdGltaW5nLmRh
X2hzX2V4aXQgKw0KPiArCQkgICAgICBkc2ktPnBoeV90aW1pbmcuZGFfaHNfcHJlcGFyZSArIGRz
aS0+cGh5X3RpbWluZy5kYV9oc196ZXJvICsgMikgKiBkc2ktPmxhbmVzOw0KPiArCWhvcml6b250
YWxfZnJvbnRwb3JjaF9ieXRlIHw9IEZJRUxEX1BSRVAoSEZQX0hTX0VOLCAxKSB8DQo+ICsJCQkJ
ICAgICAgRklFTERfUFJFUChIRlBfSFNfVkJfUFNfV0MsIGhzX3ZiX3BzX3djKTsNCj4gKw0KPiAr
CXdyaXRlbChob3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGUsIGRzaS0+cmVncyArIERTSV9IU0Ff
V0MpOw0KPiArCXdyaXRlbChob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlLCBkc2ktPnJlZ3MgKyBE
U0lfSEJQX1dDKTsNCj4gKwl3cml0ZWwoaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUsIGRzaS0+
cmVncyArIERTSV9IRlBfV0MpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBtdGtfZHNpX2Nv
bmZpZ192ZG9fdGltaW5nX3Blcl9saW5lX2xwKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICB7DQo+
ICAJdTMyIGhvcml6b250YWxfc3luY19hY3RpdmVfYnl0ZTsNCj4gIAl1MzIgaG9yaXpvbnRhbF9i
YWNrcG9yY2hfYnl0ZTsNCj4gQEAgLTQzNiw3ICs1MTIsNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHNp
X2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICAJdTMyIGRzaV90bXBf
YnVmX2JwcCwgZGF0YV9waHlfY3ljbGVzOw0KPiAgCXUzMiBkZWx0YTsNCj4gIAlzdHJ1Y3QgbXRr
X3BoeV90aW1pbmcgKnRpbWluZyA9ICZkc2ktPnBoeV90aW1pbmc7DQo+IC0NCj4gIAlzdHJ1Y3Qg
dmlkZW9tb2RlICp2bSA9ICZkc2ktPnZtOw0KPiAgDQo+ICAJaWYgKGRzaS0+Zm9ybWF0ID09IE1J
UElfRFNJX0ZNVF9SR0I1NjUpDQo+IEBAIC00NDQsMTYgKzUxOSw2IEBAIHN0YXRpYyB2b2lkIG10
a19kc2lfY29uZmlnX3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gIAllbHNlDQo+
ICAJCWRzaV90bXBfYnVmX2JwcCA9IDM7DQo+ICANCj4gLQl3cml0ZWwodm0tPnZzeW5jX2xlbiwg
ZHNpLT5yZWdzICsgRFNJX1ZTQV9OTCk7DQo+IC0Jd3JpdGVsKHZtLT52YmFja19wb3JjaCwgZHNp
LT5yZWdzICsgRFNJX1ZCUF9OTCk7DQo+IC0Jd3JpdGVsKHZtLT52ZnJvbnRfcG9yY2gsIGRzaS0+
cmVncyArIERTSV9WRlBfTkwpOw0KPiAtCXdyaXRlbCh2bS0+dmFjdGl2ZSwgZHNpLT5yZWdzICsg
RFNJX1ZBQ1RfTkwpOw0KPiAtDQo+IC0JaWYgKGRzaS0+ZHJpdmVyX2RhdGEtPmhhc19zaXplX2N0
bCkNCj4gLQkJd3JpdGVsKEZJRUxEX1BSRVAoRFNJX0hFSUdIVCwgdm0tPnZhY3RpdmUpIHwNCj4g
LQkJICAgICAgIEZJRUxEX1BSRVAoRFNJX1dJRFRILCB2bS0+aGFjdGl2ZSksDQo+IC0JCSAgICAg
ICBkc2ktPnJlZ3MgKyBEU0lfU0laRV9DT04pOw0KPiAtDQo+ICAJaG9yaXpvbnRhbF9zeW5jX2Fj
dGl2ZV9ieXRlID0gKHZtLT5oc3luY19sZW4gKiBkc2lfdG1wX2J1Zl9icHAgLSAxMCk7DQo+ICAN
Cj4gIAlpZiAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9WSURFT19TWU5DX1BVTFNF
KQ0KPiBAQCAtNDk5LDYgKzU2NCwyNiBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9f
dGltaW5nKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+ICAJd3JpdGVsKGhvcml6b250YWxfc3luY19h
Y3RpdmVfYnl0ZSwgZHNpLT5yZWdzICsgRFNJX0hTQV9XQyk7DQo+ICAJd3JpdGVsKGhvcml6b250
YWxfYmFja3BvcmNoX2J5dGUsIGRzaS0+cmVncyArIERTSV9IQlBfV0MpOw0KPiAgCXdyaXRlbCho
b3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSwgZHNpLT5yZWdzICsgRFNJX0hGUF9XQyk7DQo+ICt9
DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10a19kc2lfY29uZmlnX3Zkb190aW1pbmcoc3RydWN0IG10
a19kc2kgKmRzaSkNCj4gK3sNCj4gKwlzdHJ1Y3QgdmlkZW9tb2RlICp2bSA9ICZkc2ktPnZtOw0K
PiArDQo+ICsJd3JpdGVsKHZtLT52c3luY19sZW4sIGRzaS0+cmVncyArIERTSV9WU0FfTkwpOw0K
PiArCXdyaXRlbCh2bS0+dmJhY2tfcG9yY2gsIGRzaS0+cmVncyArIERTSV9WQlBfTkwpOw0KPiAr
CXdyaXRlbCh2bS0+dmZyb250X3BvcmNoLCBkc2ktPnJlZ3MgKyBEU0lfVkZQX05MKTsNCj4gKwl3
cml0ZWwodm0tPnZhY3RpdmUsIGRzaS0+cmVncyArIERTSV9WQUNUX05MKTsNCj4gKw0KPiArCWlm
IChkc2ktPmRyaXZlcl9kYXRhLT5oYXNfc2l6ZV9jdGwpDQo+ICsJCXdyaXRlbChGSUVMRF9QUkVQ
KERTSV9IRUlHSFQsIHZtLT52YWN0aXZlKSB8DQo+ICsJCQlGSUVMRF9QUkVQKERTSV9XSURUSCwg
dm0tPmhhY3RpdmUpLA0KPiArCQkJZHNpLT5yZWdzICsgRFNJX1NJWkVfQ09OKTsNCj4gKw0KPiAr
CWlmIChkc2ktPmRyaXZlcl9kYXRhLT5zdXBwb3J0X3Blcl9mcmFtZV9scCkNCj4gKwkJbXRrX2Rz
aV9jb25maWdfdmRvX3RpbWluZ19wZXJfZnJhbWVfbHAoZHNpKTsNCj4gKwllbHNlDQo+ICsJCW10
a19kc2lfY29uZmlnX3Zkb190aW1pbmdfcGVyX2xpbmVfbHAoZHNpKTsNCj4gIA0KPiAgCW10a19k
c2lfcHNfY29udHJvbChkc2ksIGZhbHNlKTsNCj4gIH0NCj4gQEAgLTExOTcsNiArMTI4Miw3IEBA
IHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSBtdDgxODhfZHNpX2RyaXZl
cl9kYXRhID0gew0KPiAgCS5oYXNfc2hhZG93X2N0bCA9IHRydWUsDQo+ICAJLmhhc19zaXplX2N0
bCA9IHRydWUsDQo+ICAJLmNtZHFfbG9uZ19wYWNrZXRfY3RsID0gdHJ1ZSwNCj4gKwkuc3VwcG9y
dF9wZXJfZnJhbWVfbHAgPSB0cnVlLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgbXRrX2RzaV9vZl9tYXRjaFtdID0gew0K

