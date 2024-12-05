Return-Path: <linux-kernel+bounces-432531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F5D9E4C93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 04:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510011682BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4DC1898FC;
	Thu,  5 Dec 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pxzAmpLk";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PUtB+azO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857F38C;
	Thu,  5 Dec 2024 03:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368601; cv=fail; b=nh7LQKOOvCEFiSHevOmLQ5WxI81Heoi2Bx719hOR5II6RgoTJk+ARnQkAoI8dsJckeQwToGGqxbPZ57Q3c/BhOO7/bnbtuR3+uEcsZ8aWPfRGwxPstONCjxPOIwGe0Ox0p0asKD5VFa2VO4opWSDn8agmI3t3pDLXQ4OVVS2T8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368601; c=relaxed/simple;
	bh=+tRpGmfHpJDORNOvyb0EV2Y/CWYPEJcTRhZSkK6yoqc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=frdb5r1IUK8mO2Vpt3cdqdOOSGFxegnFvPqxhpE678vKQhBjT4YKvbsZQ5pvGkK37JB6QjDYSd2jDpcDBbD4PxJpVhDWoxfVKcutNrDEFn7fgS3W2HWBFfisnZPghmb/TFwWuNvUCOMul6DIiKnc1QyLMbAWySNcBjlqXgLgUT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pxzAmpLk; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PUtB+azO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55035100b2b711efbd192953cf12861f-20241205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+tRpGmfHpJDORNOvyb0EV2Y/CWYPEJcTRhZSkK6yoqc=;
	b=pxzAmpLk8eClPiYo5zKaGxMMk0N3+4W2WjRq/CAJzGwdZUBkoZ0+tz3VA0QsbM9D/2lBSJ7yXv4RHEiHSjPy7cg1l0kCYWcMl0bahjfRGV2yrK/njU71vlht6bd1mN6tlERJGEb+sXpXndv+3ab1J46SOEeNe3//gL+B9/mgvP8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:279a4a7a-30ac-456f-9451-1d91787ca4ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:4bcef3f5-e524-4511-b681-7d630745cb54,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 55035100b2b711efbd192953cf12861f-20241205
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1218759384; Thu, 05 Dec 2024 11:16:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Dec 2024 11:16:32 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Dec 2024 11:16:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNRFF0zExpw5ap+pzaqwPMwnFI6CyquAu+iTtSNNl9hgLBmVXJur0q6y5kaQ64VUdECLesoGrIu2bqrFFk/TyML0CyY+Qe9faTOt/ni2PVjKjp5cgEGUQA2SCbT6GSCepwynIZi/N/ecq/D/94lI6nCt+83GD05VEDzhLYn+NGiZMAfUpOWJRevXOmLZgOsOV+KExtqkjy5IbmjsN3XJNa5PHXjQ2qdf+Eqwmjy9OW1HvvAv2ZHwoYiHHLSwGZ5Hi0VM5QjYl4ZqUGtOxD1Zd5C90bsje6MPX/NXy54qE5W7IeffdVWclPGxpoiqhHosSuOhdUHhBJy8j8W1u4TW2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tRpGmfHpJDORNOvyb0EV2Y/CWYPEJcTRhZSkK6yoqc=;
 b=nQRfOVxh2zCqqj07XdyVYEyR3p5G9IK+QH9sZCEQLxi/4lbENDXIWDTjGp2rcXb/BI/gq+P/lj2LFjTJVWHE1MVNyj3rdHb3h6FPLzOW95VSZTylWNKf7WgcXXFP1O0KEjF/OHzQMP+FsIfxQBYjEspGuSZNirimcxC/2Wy+l2HOVsHAoPKxyVxfwGcU16QniEvbBMlg2y7fXk7ANfX4q22MLM72XhnuiSAcLni3OsciJdM6HFeRVBEgf5vR4wh9KJUhSPs7sw+Ir8Tq+3UMlLQyO3ac6yYDbNXyfpZDiShIIQuUBwewJtjD4vsYC+Bun4Fvmikd6trDbxASfhmK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tRpGmfHpJDORNOvyb0EV2Y/CWYPEJcTRhZSkK6yoqc=;
 b=PUtB+azOC4YkNmYRa2ymIhShVDMu9b3IO4Wdrsk63VkLB/6v+h3wHxT9j0PYdtnsmlBktVUgiN2Q19mGozu35jONQzY/ihxLwPo435vttsGMCm4GGPGLmY/xgpF6KsfXiw7x+RIEXFDPlOP5qvECuDMW737QrtaEPqIURFYFMUQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8382.apcprd03.prod.outlook.com (2603:1096:101:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Thu, 5 Dec
 2024 03:16:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Thu, 5 Dec 2024
 03:16:30 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"mripard@kernel.org" <mripard@kernel.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 6/7] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Topic: [PATCH v1 6/7] drm/mediatek: mtk_hdmi: Split driver and add
 common probe function
Thread-Index: AQHbO0pOdhPnCCfvPUeRqumGFBNh8LLXEZKA
Date: Thu, 5 Dec 2024 03:16:30 +0000
Message-ID: <b032782b60db4c3cf86ab9a50c18e1c0a315f68b.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124512.134278-7-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8382:EE_
x-ms-office365-filtering-correlation-id: 5c378ea0-585a-489e-b1e5-08dd14db3699
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZXJkNDJGVEpBL2MvaW9jcmgvOWx0MTc3U0E0cjFxazgxaDdxSHAzSWQySXlU?=
 =?utf-8?B?YWpqaVZEWkRUR05oR2pqQisxOE5ZalhFQUc2NXVobFRrT2oySy8yTkhEMlZn?=
 =?utf-8?B?bHJqOEI0aVZrY25za1Q0RTJaQUpPMElSNW13eXFXWUN2cEpQcnJ4MVNUWXN5?=
 =?utf-8?B?YzJQMElXSmFzTk5qem8wVTlXWTBuRWNkYWpERDlvVFJSczkxNjRHUDJtSzhr?=
 =?utf-8?B?aTErZUkzd2p5K204bm90YlJ5b1hDdWdJUHBJY0prTTlDV2c5SUdaUnpFSU82?=
 =?utf-8?B?b1dNRXZVeStyYzdjVXNYdTJmRW0xRURFd0l6bU1MdzU3MmRjSjhkSGhrbW1H?=
 =?utf-8?B?bzAyeU11QloyMVB6RFh6dWh4M0xOdlNPazYwYTg2cnZDYWljREhBTzlVWjJU?=
 =?utf-8?B?bkZlK00rdFJzSU1PRnpjSzBEZTk5SjliOXgwaHZORWRsTTd0RDVEVjVnZ3Nx?=
 =?utf-8?B?cWdvOE0xTldrSUNleHk0cE5WaXdyeVJHV2Z1YVVBZnQrckFoN01xbncrL09V?=
 =?utf-8?B?Qk44djlaQXF0T0xYWlEzd1F5N0RKRHgyT2hkZnhXTnhGQ1pDcm5hSk53bkNp?=
 =?utf-8?B?MWRRT2MveVMrZmJ3MTZLOW9OMEFkd0xYajZCQWtMdVJSZDFtWDVNVFJuMlhi?=
 =?utf-8?B?Z0tUU2VaN1ZWU3M1cXY4SEhDV2dZSDdralBHUjRyV1lWNExCTkE1R2RpaW1X?=
 =?utf-8?B?SWlrR0Frb2djcERmbTNHTm5JTEoyTzZBdEtrQ0sxcWpOd2Y0UHNEZm9MeXJj?=
 =?utf-8?B?NytTK29Mck80RnVmV3VkZzJvOFArMFpkMGttVWdsVmVVQ0V6UVNxQlBtdTV5?=
 =?utf-8?B?NnJuWVJhYnpNck1ML0RvUEJWVjByZlVkYUZsN0JibXJ4NjN2VWVrTEIvSnF5?=
 =?utf-8?B?blROeTM1bHZ3bS82TWNRNDAzdS9pdVdzODNSY0c4OUxBTkl4cXpvK0lBczNF?=
 =?utf-8?B?Q0cybDFBSXU1Nm9IZC9wQkorMjd5Q2pvamIzaTdLbGNhL2c2UE80Y0U4ZjJU?=
 =?utf-8?B?VForREtIWXBqYkRUVjYwQTlMb1lyWmRydUxWNzVmSy9HR2ZwdlFmYlBLdkxx?=
 =?utf-8?B?dFFvdTJwbHBwUDdOTDNZTXBDNGdaZFhnZ1pwdkIxK1hNWVl1TVZNQW9ZUVAv?=
 =?utf-8?B?V3BsYTI4QlZiQnZxVzUvd0l0TmxReXBydElhOHdpTkZuWnFqY2Z2d1B0cDd1?=
 =?utf-8?B?NWdMYjlCb3prOWVkYTU2L0daK2t2L0F3WldaZHhjODlsV3FRdGtpV0x3RmZq?=
 =?utf-8?B?bjEvdkJrNDFibDRINXd6NWdUQm0vSmpJUENhLzRJNGxObys3L1dLRk95cDV0?=
 =?utf-8?B?eHE3UUJGOGtpeE1kb1FHTURXaG9zaW1QeUMyZ3BJT0ZaSWNqSFBrMGFoMW94?=
 =?utf-8?B?YXk2Zko1STdFd3pPSXB1cWV1UmlyQVhDMkkydjlDOFEyTURhYXdOU1NvcnJr?=
 =?utf-8?B?ZGxmVXdzS3phWjk2WmdIVXM2eFgxdDNqYkJ5WU42ZG1RcVJFa0tFUWhGeE9I?=
 =?utf-8?B?RElSMXA0TDkrM0c4dlZiVU5TSE5rdXNaMlZ5RGNtaFRNYjJOMmpXbnBUQWtk?=
 =?utf-8?B?cjlnWTFOT1VjZmhpS3lNUGtvQ2ZoRzhtaEVKT3pydE5meWJDRW5WRHNNNllr?=
 =?utf-8?B?VytUZDF2SkFtWWMvTjRyNVJqbzhYUVVZZlY1dUVvZ0hnZnk3a0tTYWkvelBY?=
 =?utf-8?B?ODBRYTJ1by8zbTI3a04xOE9FTG5iLy9lVWI2QnlsbENrQkhEcjg5djBCU1p2?=
 =?utf-8?B?dm1UaG5PekQ4OWxNY0NpTzRwdXMrM1NibHhzdjhDSU5QM3Y5Nkx0d0dGOHZT?=
 =?utf-8?B?WUhnMTFodjJvSlJYSVpSaWVDMjJFVEJ0b0tTRjBvSHU1dkRXRThmWkhuekE5?=
 =?utf-8?B?VW1QYzNtVlRmMGpwUmhHTjd5YUI0WGgvQ0Y0RHdLdXhtRkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkVkOFVUOURqTmkrTDR2RGFtc29Ya3duTjJWMll0UWJ3N2J3MUJWN1ZPbDRz?=
 =?utf-8?B?OE5OekZpRzR3a1hZOGx6WG1UelpHRS9sbVF6R3FTbUlWQVcvS2pXOGJ6Smth?=
 =?utf-8?B?NGt6MDZsdklxZWxXNllHU2pIR2NobjBKKzhHWGNzeVJCSVdCVS9zQmJhdDJM?=
 =?utf-8?B?eHNIaWV5UXNxcnJBaVNwdnc0YTJWM0IzSEo2WHF4L0lGbisrVG80Y3ZFNW9E?=
 =?utf-8?B?aStNV3lHajNBTlErZnU5bGo2WFd2R1oxVDFjVFZiRWVMaDZ2S1ZjMEpmL2w5?=
 =?utf-8?B?YnZFeVlVMXVZMlpDTjhIRmhjc2ZGRk5NRTdzQWRkam4wTERhbWxkY1NOY3A2?=
 =?utf-8?B?Nnh6OHJwemxxQmEwbWZ1RmRqWUY0c2FZMzBTdjh3dlMyODY0c1dCZVJjUXhP?=
 =?utf-8?B?bmZXaTdqTUIvZHdJRXRPZXRSWWtUY0hOelBIN1NiUE94VWMzaitxeUJZUEx6?=
 =?utf-8?B?aytyVjlYUGFKMjB4YU5TUFd6MXRaWWh2RXk1TUN4Qllick5wUUNpbTBKVit2?=
 =?utf-8?B?OEhvUWI4am9tR28xWU9HVWxFSUdiaG4zRVNWWGpXVXdDbmVQMzhpT1RBSUZl?=
 =?utf-8?B?c2dtM2k1VWY0VXVadEdEcUhYbGJKQXUzUXZ0Y2o3c2VrQkJrb04rWEZVTWNl?=
 =?utf-8?B?UVo1Q1ZaYzY2b2RleURhcHFBZExZejNIaTdSdVhzTElZS3M0REZJQitwclpT?=
 =?utf-8?B?N3lOWDhLZEpkQmxHNTlyek5nTWZ4TG9RWEhteXU1N3RJWlRXVG9DbVJ4aVVs?=
 =?utf-8?B?b3MyZzlDdFdmQnBZWG93M1EydThlR0EvZVVuaDBWR3k2bDA5OGduakhtVWw0?=
 =?utf-8?B?QXAzcFJOS3FhL0NEU21LYmFGWVdsVjQ1eU9VaC83enhuZnpCUEJoeWVSaUhz?=
 =?utf-8?B?MVNTTjhGSFhCV2lhU3ZHY2QvM0cwOHJIeEU0eERrZjdGTC9EZHBYb1FPWlU2?=
 =?utf-8?B?cG9udWNGMVFmYmlTQnU4Q21kb0E2SDJXRHVOdDlySHh3eC9yWTlPSnRzVC93?=
 =?utf-8?B?RGVtemFoZnNEZDU2WDV2c0hHbnJBaHN0QUY0cGE1b3RkSXlrM1J2YWlsRDI0?=
 =?utf-8?B?VkdIejFpcDlJNkRqTVY0RjQ5YUI3eEVydEVNTGg3UVBuLzZKMVdEWHgxYjlr?=
 =?utf-8?B?ajBHZ0xWeGpYUStZVkNvcXJ2c1lnbllsakQ5Rksvc0doR2dNb2FHemZmNzla?=
 =?utf-8?B?RjI3UUEzOSs4UmJXbCs4UkE2UFRyS09meHhSZzhHcXNPNkJUaDFIVUdLTHNT?=
 =?utf-8?B?NGd5MW1lWlZOTzFOdTVKRk1QaW1HRUdWbFhrNWxkajlhVlpSQXpJbWlWdk1S?=
 =?utf-8?B?N1dLRUZiZ25vZEl4SFVDZ1RqVklSYUg0a2pOTTZ0eWdQY2YrTm1TcjBOVzVJ?=
 =?utf-8?B?NkhGZ2ljMXQzc3IxajMzQlpBRDdEQXJjSWZIbmdsamhGcnhzVEtuNjF3WlhP?=
 =?utf-8?B?RU03cW5Vb0FaZjlqQ1hNNEVCSHBHdE8vS1RiVUszejNId1RtdkE4TWdFMmxt?=
 =?utf-8?B?c0U1RVFCUjVuelUxTUF3b3ZHSFVTeGRMT1kwWTlzRW5XTGEwMDMwc0NEZjkw?=
 =?utf-8?B?MUJjZGtsWkVtK25tWTcyUC8yWFVNQW5KWW5mRkxMdXg5L05BaDlaZmEySnpS?=
 =?utf-8?B?U085ei9penBWQklWT3YrT04wdEd6WDhQaGZjWTYyNnJDMGNRc2tyN0pWTGRF?=
 =?utf-8?B?WVNuRU82WG5BUWprOFp4UGxubmtScXZCU0lOYUcrejJYbElLYjFYVjYzT29R?=
 =?utf-8?B?R2FjQVhhbjdwRDVpTytmYjdWd0ZTdzl4dFlKaWNJb3RuUjVMVGs3TmNvMEZU?=
 =?utf-8?B?aFJ4TWVMcTA5SHhITy9ZdkVmRmZIeWttUEdTZnI0dFZBUGV5cGtRa2ZUZEZ3?=
 =?utf-8?B?MzZnNDhCTm5tVlVwWjZnMjRJUGZKbncvNGtsT1J5QkRSeElhKzFaeU9oekNJ?=
 =?utf-8?B?NVBzTGdkUCtsRzhPbUtERzIxcWJhTWN4b2JiTHhjdWhBdjczWE9BVjVNbzJs?=
 =?utf-8?B?YUhsOVdKNWRLSW5qT01VWFVRUDE5N0VIclFxaFZOWnNjT3hGUmpSRWlvZFpo?=
 =?utf-8?B?OTlNTkd0a3dVaEh4Sk55d2VwblRwYjNMYUZ5cmdJN0pFZitsaGlKTzFjbDEx?=
 =?utf-8?B?TEFXd0krcTRZWko0WEVqOWh6dmtUY041UHVBeDZCVTNUTm5EMXo2SWVhZEt1?=
 =?utf-8?B?WFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C551FB822FE2F4BB3D2A93FDD26AD6D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c378ea0-585a-489e-b1e5-08dd14db3699
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 03:16:30.2664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLxZgs1jERNt2MBHbMijLffOmICRttEwSz6u8RYjKik1xdnfHaUoFpCEyTfMtoEgE2fOA5FgrrpbrTI+k5k9wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8382
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.244000-8.000000
X-TMASE-MatchedRID: QW5G6BKkLToNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCrfUboIp1QbVuIwLnB3Aqp24vBuE2X0HlVwpnAAvAwazkaC
	qYviih52NKaasnxJAFjDDWg3cV0z4m0qYZR+CUBLil2r2x2PwtQrefVId6fzVLzNBnatH86l8yt
	0Pc0hS+ySNsvbDyWzxhqVQcGwtQOUyVnV3QQcwse7KTDtx8CggbSE5tsEh8ODJrP9MePs1nKPFj
	JEFr+olFUew0Fl/1pH1MHKyrhxIFlZ0V5tYhzdWxEHRux+uk8jpP8tMOyYmaA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.244000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1B0C56E0259F191025DE8595346E82FCC0F169F2A15390CA71EE8EDB695BD8A32000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIGEgbmV3IGRyaXZlciBmb3IgdGhlIEhETUkgVFggdjIgSVAsDQo+IHNwbGl0IG91
dCB0aGUgZnVuY3Rpb25zIHRoYXQgd2lsbCBiZSBjb21tb24gYmV0d2VlbiB0aGUgYWxyZWFkeQ0K
PiBwcmVzZW50IG10a19oZG1pICh2MSkgZHJpdmVyIGFuZCB0aGUgbmV3IG9uZS4NCj4gDQo+IFNp
bmNlIHRoZSBwcm9iZSBmbG93IGZvciBib3RoIGRyaXZlcnMgaXMgOTAlIHNpbWlsYXIsIGFkZCBh
IGNvbW1vbg0KPiBwcm9iZSBmdW5jdGlvbiB0aGF0IHdpbGwgYmUgY2FsbGVkIGZyb20gZWFjaCBk
cml2ZXIncyAucHJvYmUoKQ0KPiBjYWxsYmFjaywgYXZvaWRpbmcgbG90cyBvZiBjb2RlIGR1cGxp
Y2F0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
PGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQoNCltzbmlw
XQ0KDQo+ICAvKg0KPiAgICogSERNSSBhdWRpbyBjb2RlYyBjYWxsYmFja3MNCj4gICAqLw0KPiBA
QCAtMTUyOCwxNCArMTEwNCwxNCBAQCBzdGF0aWMgaW50IG10a19oZG1pX2F1ZGlvX2h3X3BhcmFt
cyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsDQo+ICAgICAgICAgc3dpdGNoIChkYWlm
bXQtPmZtdCkgew0KPiAgICAgICAgIGNhc2UgSERNSV9JMlM6DQo+ICAgICAgICAgICAgICAgICBo
ZG1pX3BhcmFtcy5hdWRfY29kZWMgPSBIRE1JX0FVRElPX0NPRElOR19UWVBFX1BDTTsNCj4gLSAg
ICAgICAgICAgICAgIGhkbWlfcGFyYW1zLmF1ZF9zYW1wZV9zaXplID0gSERNSV9BVURJT19TQU1Q
TEVfU0laRV8xNjsNCj4gKyAgICAgICAgICAgICAgIGhkbWlfcGFyYW1zLmF1ZF9zYW1wbGVfc2l6
ZSA9IEhETUlfQVVESU9fU0FNUExFX1NJWkVfMTY7DQoNCllvdSBjaGFuZ2UgdGhlIG5hbWUgZnJv
bSBhdWRfc2FtcGVfc2l6ZSB0byBhdWRfc2FtcGxlX3NpemUuDQpTbyB0aGlzIGlzIGEgcmVmaW5l
bWVudC4gU2VwYXJhdGUgdGhpcyB0byBhIHJlZmluZW1lbnQgcGF0Y2guDQoNClJlZ2FyZHMsDQpD
Sw0KDQo+ICAgICAgICAgICAgICAgICBoZG1pX3BhcmFtcy5hdWRfaW5wdXRfdHlwZSA9IEhETUlf
QVVEX0lOUFVUX0kyUzsNCj4gICAgICAgICAgICAgICAgIGhkbWlfcGFyYW1zLmF1ZF9pMnNfZm10
ID0gSERNSV9JMlNfTU9ERV9JMlNfMjRCSVQ7DQo+ICAgICAgICAgICAgICAgICBoZG1pX3BhcmFt
cy5hdWRfbWNsayA9IEhETUlfQVVEX01DTEtfMTI4RlM7DQo+ICAgICAgICAgICAgICAgICBicmVh
azsNCj4gICAgICAgICBjYXNlIEhETUlfU1BESUY6DQo+ICAgICAgICAgICAgICAgICBoZG1pX3Bh
cmFtcy5hdWRfY29kZWMgPSBIRE1JX0FVRElPX0NPRElOR19UWVBFX1BDTTsNCj4gLSAgICAgICAg
ICAgICAgIGhkbWlfcGFyYW1zLmF1ZF9zYW1wZV9zaXplID0gSERNSV9BVURJT19TQU1QTEVfU0la
RV8xNjsNCj4gKyAgICAgICAgICAgICAgIGhkbWlfcGFyYW1zLmF1ZF9zYW1wbGVfc2l6ZSA9IEhE
TUlfQVVESU9fU0FNUExFX1NJWkVfMTY7DQo+ICAgICAgICAgICAgICAgICBoZG1pX3BhcmFtcy5h
dWRfaW5wdXRfdHlwZSA9IEhETUlfQVVEX0lOUFVUX1NQRElGOw0KPiAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+ICAgICAgICAgZGVmYXVsdDoNCj4gQEAgLTE1OTAsNiArMTE2Niw3IEBAIHN0YXRp
YyBpbnQgbXRrX2hkbWlfYXVkaW9fZ2V0X2VsZChzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRh
dGEsIHVpbnQ4X3QgKmJ1ZiwNCj4gICAgICAgICAgICAgICAgIG1lbWNweShidWYsIGhkbWktPmN1
cnJfY29ubi0+ZWxkLCBtaW4oc2l6ZW9mKGhkbWktPmN1cnJfY29ubi0+ZWxkKSwgbGVuKSk7DQo+
ICAgICAgICAgZWxzZQ0KPiAgICAgICAgICAgICAgICAgbWVtc2V0KGJ1ZiwgMCwgbGVuKTsNCj4g
Kw0KPiAgICAgICAgIHJldHVybiAwOw0KPiAgfQ0KPiANCg0K

