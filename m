Return-Path: <linux-kernel+bounces-529095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DAFA41FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42183A8C37
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A58623373E;
	Mon, 24 Feb 2025 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f2XEarYF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WJ93vs8M"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AFE163;
	Mon, 24 Feb 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740401355; cv=fail; b=skdDMm9Jh25idWwjAec8gAUd9pUX6D9GPBRuFmVodzSHsMKHobeDb6vd2D7ZMExPNEf1jlf+ot8LPBxYXUueVYPG7C92shnjy1OafNjrymQJ40Cz5s08cAeYnrNTWTwa00qxNsp+cS9KT3b+PHtXQlOt20TEEdV7lHlOUQd3b6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740401355; c=relaxed/simple;
	bh=9y8DrlhrQ2a+3jCqybbw41y/X2XkrOs7cywJ5JDonG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aF/qHsvQhek6GsVWg2SiFeNzrJG4wM7Z09UHZpjIV9p4E4Lhmg+hMa0v0uRMB0PxwKTCzPhSheU50xXG1rUcoYdMk5J6R0/jAJmBnF78JZxl9g69Pb9PDsBu72QFgSMn4F7hhoXoAdrclxf5040AZ7aW7HFrYb5tSAKzFm0nl6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f2XEarYF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WJ93vs8M; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bd4c4abaf2ad11ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9y8DrlhrQ2a+3jCqybbw41y/X2XkrOs7cywJ5JDonG4=;
	b=f2XEarYF0/lEpcyjR54/3RK5B51gB3XlH8whnQSLlyy5Qc19EolfLpg6SMpSH5Dj9OGnNv+ttaqXAvohvTeze1IVwZKnCpBDXG/qKccjxU/lzV6NeM/7iPREWxDoq/z3OeQP5++hqvSHQEk7VA/5X/zNUaHoGLKjv0IorzjfrNw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:61ac1f23-f3b4-4a3e-a4e1-cdf3940ee767,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:51d444dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bd4c4abaf2ad11ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1969470313; Mon, 24 Feb 2025 20:49:09 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 20:49:07 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 20:49:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtLB6wTWGwoMFi0KancYryAOi34GWyPO2XbaFhXrr7YU2LZDmP0m37nh2Dk/eGqnllMa2BzpnaA+3zwbVluraNDaXF/nPFuT+/wp4GBMqdWDK93djLCBmGIj6SZHe9hocmT5sAB6nPS4odr3JTnwbIdxIuUqhH1sjxnPnRQS6pTmB8Sb0Qpgxs3u009Rs7O65ThRPh3h1mQ1HVNexNSIq1Zm7UzdpQoEA4Ih+EgD+c/LOagbNf/DZWOLz788QrvE6htU8M3vUFeH49mc/LNSuI3uUwFzig5qhWtPn0Wk94XA8hbyRFSgjzbMYnth4BqczR2LWwfBruacMmvQxZzcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y8DrlhrQ2a+3jCqybbw41y/X2XkrOs7cywJ5JDonG4=;
 b=SVlAp1w1tRvipnCrxULxJgL+fTb+Fk9vqqQO4eqOSAHUWEaZwNEy6EEue7cDfjkFsjfU+IB8Nr+E8NGzpzgs50px9UCGK2b10z4CnycvZFHzgSbPpGyB9iP38BAMME2j99k8XImmYeu/QiezugUVOq3lxASuoZt49qM1/epCWpCTl2ltaslh0NcaL48ePQWD3Ah61GRR8dbbwYx50DZJDXFGs6kllPDyAQgRQ8H708AC40YLteBhaztwhtIchx5sgxw51QKwlCLRYRA69y0Lm8R70BHl4rySpL5N/LUVs+lssRTzgl2uH5ymnzZc9g/PH52thyCmGJOeSPKF28esXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y8DrlhrQ2a+3jCqybbw41y/X2XkrOs7cywJ5JDonG4=;
 b=WJ93vs8M7XuIjbSYoEyIVzHnO8LL4lyKSynUeh+iLWrLFKyNGwx4UHaeGA+P9wffFtDe84sy99i2+jlgCuSGgRfvLL/MLrlaQ8tO9Qu3kPIYYWZAVvR4I5aC7eemqsuQPOhQyAe+0tRoCVVwTyj85NhTTJIMPLQpyGtZTgd0gsE=
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com (2603:1096:400:459::6)
 by TY0PR03MB6499.apcprd03.prod.outlook.com (2603:1096:400:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:49:05 +0000
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939]) by TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:49:05 +0000
From: =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>
To: =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "mripard@kernel.org"
	<mripard@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "hsinyi@chromium.org" <hsinyi@chromium.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 1/7] drm/mediatek: Add CCORR component support for MT8196
Thread-Topic: [PATCH 1/7] drm/mediatek: Add CCORR component support for MT8196
Thread-Index: AQHbgq+qLKI/DkYu8ESkQ59zNHyvBLNOlASAgAfbk4A=
Date: Mon, 24 Feb 2025 12:49:04 +0000
Message-ID: <03164cb32445f1054f8a3f04b846aa97b5cffa95.camel@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
	 <20250219092040.11227-2-jay.liu@mediatek.com>
	 <779b0915-f0fa-46b6-8c5b-57745114252f@collabora.com>
In-Reply-To: <779b0915-f0fa-46b6-8c5b-57745114252f@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB8136:EE_|TY0PR03MB6499:EE_
x-ms-office365-filtering-correlation-id: 5f417eec-dd96-45ea-2f23-08dd54d19f0e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?YUR1UEtqakpaeTEyWXdlcE50ZkljenpDTEFUbUJYSWlFV3huR2xZeWVRYlRI?=
 =?utf-8?B?Snp2MVJOeEJnTkJXQVRxVlpBRENDNjBwVEI4TGUzRmlFVTZPUmlXTmg2dDNz?=
 =?utf-8?B?WGJCN2k4enY4VUZValNrT08ySVo1U3RnT1NldldFZ3FuUGlZcmhFbFB3SU1S?=
 =?utf-8?B?VVdDdUFodzFKMUZpdDZpdTVraDNXS3FmVUFQTnFlbWlsakVKTHhNUEN4Z0Fa?=
 =?utf-8?B?THNVdm1DVXFoUmtITmREdlFlK3lOMHVPWnN2TWQxWjM3QVpYaXQxT3BlTjRL?=
 =?utf-8?B?WU5qTlFXUnBvMjdueHVwTzJnQzZoOWhxam5LcDBsdTJuQlpIelhmQkJjV2JP?=
 =?utf-8?B?MHBOUzZBazR3RS9FTllBdUw1Y0VoQ0gyT1dMTFN5amEycXZFc1lJblpESXpJ?=
 =?utf-8?B?TmpOTFo2NTNwdHlNQzJKYitmRndzbng1ZVMyeVZ3b2M2VHJmS1NMaGJ2aFpK?=
 =?utf-8?B?Y0JrZitpbk9rOTZxOXQ2V3VyT2FRQ3lNTjZKRlpJcmRnVlpGRjY0aUxVZVN2?=
 =?utf-8?B?ZEtmUjkxUGJSdXdZTGpic2h5K2pMT3JBcTM3YVlrenJDN0I3dnFPS3JsN2JR?=
 =?utf-8?B?QTFCLzhJTnFGSm13eGFVMjEzUkZITzlxZ0NrSmlEWjY2TWgwdWJVV05wRTlN?=
 =?utf-8?B?cXF2SS8zQ0REUmxMT3dTbFpVMUNsZzl5WGNQUHdVREVOQm9Bd0RHbkxyMFc2?=
 =?utf-8?B?aGdCK2FnbUw0MGh6bFFDLzRjNEQwdFZheHd6QlJVSjRFdTN4VUpoaXpwRkpK?=
 =?utf-8?B?WmtoTkpGaXFGSmE4MXFENzZuSyt3YlU0ZzlRczRQejBTWCt5dEYzeFpFVTMr?=
 =?utf-8?B?ektqekR4REVCcktlR1V1czlQWFl1NzROYmVNeVpRUW5DTzgwK01ueDJ4em9M?=
 =?utf-8?B?YU42WmhIRkZ6TnZiMDV0UCtyM2JRUTNEWjlVbUdCV1gvbUZ5WDM5YWluVDNs?=
 =?utf-8?B?UTB3OHV4d1FTbXcyWkZPbjdtYWZyenRDaFJVVThNNFFmMkl2eEtMSE9NSjNv?=
 =?utf-8?B?cFJLTkduSW90eTY4dlRFUW1mcUd4Q0dpWGtpbFJ2ak5GOFhER3Z2b1BQcE50?=
 =?utf-8?B?U1VPamFkRWZlOGQ2Rk5BZ0p4Q05seG1EdERQaFdqT1hlSXRJNXUxbWpaK0Jy?=
 =?utf-8?B?QThGYlZmM3FneGc1bVRtaVp6Zk1hbWI1aU96aG9ITkJzZCthRkpScGR6WkhF?=
 =?utf-8?B?S2dsU3B1cmhvYTVxYTBPYVh0amFYUG9LenBEcUorMDFqdC9DT2VuSjN5cU9Q?=
 =?utf-8?B?Tk53S3lmOUVpY0k4Z253UTVHZisxa2NpRGhsTWl4NXJDRnBoNzRiT1lqdGQx?=
 =?utf-8?B?S1JqYXBOSWptbkFEa2hjT0JESUNkRFQ2Y0t4Ty9HcHlqYS9zYm1nYzVyT25D?=
 =?utf-8?B?b3RnNkNTTEpIdHZkTEhLT2E5RHcyb2crTWVsZkJqKzZqRFZ0VUpSbXRkK2VG?=
 =?utf-8?B?dWlpcFlCMGhKM2ZVS2FyOVpGbjJrdWhzZkR3d25rRkloakhuYU9EamlIandT?=
 =?utf-8?B?azNTWkoxeTNpb3Vmbys4M21ZanVyOHhpWWo1UUdUWUpsdVVwc0FwZDZLM3Zq?=
 =?utf-8?B?ZU9kNGRvNWNWYUhCcWRzYXV6T3NCbmVpVmVGaWErelkzalJJOFQrckVzdWhh?=
 =?utf-8?B?ZlZVY3NMc08xaHpEVWhKaytLMGtkdjFmbzQrWXdSREJYWDBIcFdzdCtJaDd4?=
 =?utf-8?B?YXNOZHdYS0xXcVVEa2JRdEVIVXFYOHI0dGtnTlF2d0xGL25nSW9RTER1UkQy?=
 =?utf-8?B?R1VzMnpaTHZwcEpMR1NJQmR0U2ZoSUNBM0xJV3o2RFZZSEd0SG9OVFg3bzlr?=
 =?utf-8?B?aUdxVmxLTlFiLzQzeklFd1c5dlZxcnF3SVYrS3RPT2IxSDhQZkhWWXc1YWZo?=
 =?utf-8?B?bElnRVgwTktKako2QThrVWJRbThxUU1jbE53OGcvMG8zOEp5QWRQWjZqMU9P?=
 =?utf-8?B?NUtBUzI2OEcyN1VLbVJDeFpqdXgxckllb2VXVW1iK2VmUUhSVHRwU3ZjcW1Q?=
 =?utf-8?B?ZjEvMDBjQzZ3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB8136.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmNEVm9ORGR2MVQrbkFWckhrQVZZbUpjMzRPTDZGOGZDWU81WnBscGZjWkZu?=
 =?utf-8?B?aGdVcUs4RGpETlFwVzlrbitpS2tPa09NWlRqMEhRRlo4dUNJSEVHUk80QmZn?=
 =?utf-8?B?VkhsRkZHZERjR0tMdTk4VEViYWtHSTJodmNTTFZVVEdYTmxOVkdWUmZaak5v?=
 =?utf-8?B?NVFoU014R0ErVHpxL3BNZ1pueHJETmV5dnV4OWhkcW9FQ3NLU3VGbnVFTlk5?=
 =?utf-8?B?TTgxR2o2SDNFZEhQQk5EK3lGeEpSUDRkc0tZeThjVmxoeWdlOUdsNHE5RG5X?=
 =?utf-8?B?TlRBYnNBWjVBbnFoZlE0YjNBUzIxNDg5SCszTGd6TFVQOVBqQXNCUWhMWjF0?=
 =?utf-8?B?WnpKcC9tQmpLaTJqNXFoUWRPVll4UzY5eWtvemhic0xIWHNKR2tKRXNRQlo5?=
 =?utf-8?B?NHhqMWY4WWdqNjhHb3dtZStNdnRKTEhVREUyYlBteHE0QW9RMUZmWEhHYlRh?=
 =?utf-8?B?dDRCMnZORkZrd0VuNy9idHZKTm9nQVNzWFVaVS8rMXdmc3NpcnlxVmlsNERB?=
 =?utf-8?B?ZFdyN1YxT3gxNjIwVFBjN0IxRXRpeE9MbFgvSlVsdExXZXM4WisyUjZ4eVpj?=
 =?utf-8?B?UVI2ZW5yaGRMeTRoeGgwUkFDYW95aXhaM21oS3FXcitpa1BDZEEzam1wWEZG?=
 =?utf-8?B?a0N2Z3RzdENpTnhKb1IwYmtmNStsc2EyMmJQMFh6MThaU0ZwNWJ3b25yY25W?=
 =?utf-8?B?bmtaNjlKWXlpd3J5d2M2QUUzRi9Ta1VFTlhGL1lZOU5nUlZ3SWtDcmFpRWc2?=
 =?utf-8?B?WThQb29wall0ZnBOVGwrOGt3QWN6dWFOTjhMM3pHbzRlTEtyd2J4TnR1RHh0?=
 =?utf-8?B?TmRaeDc4TkZzWXF5WUhOK1AySG4vN3pDc04zV2pKSmJpUzN3Vzc4U1I3ZHBE?=
 =?utf-8?B?TUVvdFJHUDlIMGhDM0hxNng1dmdjNlhMbitIbnlDQnl2UGVjUzdXMlZJN2ZE?=
 =?utf-8?B?eGNhdEIxQUhYcVlyNDEvdVBtOExUYXRwQTVBT09Za2NNN3ZuazF1ZDIxNmxG?=
 =?utf-8?B?OUJEeERRRzlJdUVDb0ZKQ1FudHRWMTNKYjVGZDFMNG1NT1lVYk90eFNZSUk3?=
 =?utf-8?B?Qmg3SHJzdWpQSHk2dDZ2VWhWeE9yZGxRQjV1blVpTGwrb1dEZkQ5aG9MUXd5?=
 =?utf-8?B?c2FTRGJwLzBaRi84cS9kVGhuWEpLVUdXcWJwYysyanFwVnZ6TnViRkpTNlBk?=
 =?utf-8?B?MHNub1RCVXg4dUY1K3kwajJnZ3BtU1FQWExMc2wwWWFqZUJSejlZNjQxY2hL?=
 =?utf-8?B?cUJLTnovRFNpQkdBYlVCMkxHRXZpcGcvcmpQeFZjYlh4L2dXZnp5YzJhYXpN?=
 =?utf-8?B?czd3Mk9HZXY1SnlLS3VtNVVFaGpISHlCR3Q4VDFEYnJaN3JUak1kbnZOT2NB?=
 =?utf-8?B?VkRpVDBDem42MytJYXdSMlBySW0xOXpxVVhOWlJEZUZUSENkSG9STlROWXpw?=
 =?utf-8?B?dGJUYTB1OUxxQm5rMHZYUmdxMkhzTXhRRkYvZ2dOMUZIYjlBQ3hkeVhmbWxn?=
 =?utf-8?B?TENmS2QyQXFLeW1OVE9sQ3VWRVBHejJ2RCtXT0NERkErQm1wTy9zdmpESjNn?=
 =?utf-8?B?M3ZxR081b21OZ2p0YlArK0FwL0dhUTd5bnd5aExWU09kV1pWTjFwMzRrdEFW?=
 =?utf-8?B?NlBTWjk1eVdhNys2QkVRckZYQ0FZK0dwR0FLZG0zZTNldC91dmxhTXU3dHQw?=
 =?utf-8?B?VTl5K1RLWndLSUlVMTVyWllCTDVvK3JkaWorN1p1Rk02cWdUVFhsTGxNNE5S?=
 =?utf-8?B?S3lqN1dWcDA2d05udy9wQlJTaE9NN0owZDhhb3BJWWIzRGRRUTlEUzdrQXZR?=
 =?utf-8?B?Y2JpV0hjZlFhVU5nTGV5VERnQTRoMG1nbzVLaC9lRWMzZmR6bUtCQ1Mwb2JN?=
 =?utf-8?B?LzZFRDk0SUp1L1JkK0gvQkk1UEUvajVMQU9sK3N6eTkvdzdURndiQStOME4x?=
 =?utf-8?B?c25XMTBMN0xMOGhGK1Y1Uk05UzkraUo2bkNkL0VCUXBMdk9sb2d4blpwUWZh?=
 =?utf-8?B?eG1rSTk1cGJzRGdOQnNPM08yaWhsTG0zT0xySzM1RGNIc0l6cHVBajB5cVgr?=
 =?utf-8?B?dkQzb3p2RGZKc0dxeHBVb09YSXAxd0RmUFJ0QkNVTlRJRFlONW50bEVRNWFD?=
 =?utf-8?Q?Fb3vUcfVtJlLQZ07hjdqgRPGb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC43BD18BA25C044804200FAA5568682@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8136.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f417eec-dd96-45ea-2f23-08dd54d19f0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 12:49:04.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v7GyktWnrZ27Wmb2amIjZQaG7/N3aoNwDRgpgBw3DaMkq8gIx0PqyYnJOEQUmhjV2PNEPs0tkVhR7Qx+E0ohag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6499

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDEzOjQ5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxOS8wMi8yNSAxMDoyMCwgSmF5IExpdSBo
YSBzY3JpdHRvOg0KPiA+IEFkZCBDQ09SUiBjb21wb25lbnQgc3VwcG9ydCBmb3IgTVQ4MTk2Lg0K
PiA+IA0KPiA+IENDT1JSIGlzIGEgaGFyZHdhcmUgbW9kdWxlIHRoYXQgb3B0aW1pemVzIHRoZSB2
aXN1YWwgZWZmZWN0cyBvZg0KPiA+IGltYWdlcyBieSBhZGp1c3RpbmcgdGhlIGNvbG9yIG1hdHJp
eCwgZW5hYmxpbmcgZmVhdHVyZXMgc3VjaCBhcw0KPiA+IG5pZ2h0IGxpZ2h0Lg0KPiA+IA0KPiA+
IFRoZSA4MTk2IGhhcmR3YXJlIHBsYXRmb3JtIGluY2x1ZGVzIHR3byBDQ09SUiAoQ29sb3IgQ29y
cmVjdGlvbikNCj4gPiB1bml0cy4NCj4gPiBIb3dldmVyLCB0aGUgYG10a19jY29ycl9jdG1fc2V0
YCBBUEkgb25seSB1dGlsaXplcyBvbmUgb2YgdGhlc2UNCj4gPiB1bml0cy4NCj4gPiBUbyBwcmV2
ZW50IHRoZSB1bnVzZWQgQ0NPUlIgdW5pdCBmcm9tIGluYWR2ZXJ0ZW50bHkgdGFraW5nIGVmZmVj
dCwNCj4gPiB3ZSBuZWVkIHRvIGJsb2NrIGl0IGJ5IGFkZGluZyBtYW5kYXRvcnlfY2NvcnIgZmxh
ZyBpbiB0aGUNCj4gPiBkcml2ZXJfZGF0YS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXkg
TGl1IDxqYXkubGl1QG1lZGlhdGVrLmNvbT4NCj4gDQo+IFRoaXMgaXMgeWV0IGFub3RoZXIgdGhp
bmcgdGhhdCBjYW4gYmUgcmVzb2x2ZWQgYnkgdXNpbmcgT0YgR3JhcGggZm9yDQo+IGRlZmluaW5n
IHRoZQ0KPiBkaXNwbGF5IHBpcGVsaW5lOiBieSB1c2luZyB0aGF0LCBJIGRvbid0IHNlZSBob3cg
Y2FuIENDT1JSMSBiZSB1c2VkDQo+IGluc3RlYWQgb2YNCj4gQ0NPUlIwLCBpZiB0aGUgbGF0dGVy
IGlzIGluIHRoZSBwaXBlbGluZSwgYnV0IG5vdCB0aGUgZm9ybWVyLg0KPiANCj4gTkFDSy4NCj4g
DQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KDQo+IGhpIEFuZ2VsbywgVGhhbmsgeW91IHZlcnkgbXVj
aCBmb3IgeW91ciBmZWVkYmFjay4gDQoNCj4gVGhlIDgxOTYgU29DIGhhcyB0d28gQ0NPUlIgaGFy
ZHdhcmUgdW5pdHMsIHdoaWNoIG11c3QgYmUgY2hhaW5lZA0KPiB0b2dldGhlciBpbiBhIGZpeGVk
IG9yZGVyIGluIHRoZSBkaXNwbGF5IHBhdGggdG8gZGlzcGxheSB0aGUgaW1hZ2UNCj4gY29ycmVj
dGx5LiBJbiB0aGUgY3VycmVudCBwcm9qZWN0LCB0aGUgY3RtX3NldCBpbnRlcmZhY2Ugd2lsbA0K
PiB0cmF2ZXJzZSBhbGwgQ0NPUlJzIGFuZCBzZXQgcGFyYW1ldGVycywgYnV0IGluIGZhY3QsIG9u
bHkgb25lIG5lZWRzDQo+IHRvIGJlIHNldC4gVGhlcmVmb3JlLCBzZXR0aW5nIG1hbmRhdG9yeV9j
Y29yciBlbnN1cmVzIHRoYXQgb25seSB0aGlzDQo+IENDT1JSIGlzIHVzZWQuDQoNCg0KPiBSZWdh
cmRzLA0KPiBKYXkNCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGRwX2NvbXAuYyAgIHwgIDMgKystDQo+ID4gICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3BfY2NvcnIuYyB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmMNCj4gPiBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGRwX2NvbXAuYw0KPiA+IGluZGV4IGVkYzY0MTc2MzllNi4u
ZDdlMjMwYmFjNTNlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGRwX2NvbXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGRw
X2NvbXAuYw0KPiA+IEBAIC00NTcsNyArNDU3LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZGRwX2NvbXBfbWF0Y2gNCj4gPiBtdGtfZGRwX21hdGNoZXNbRERQX0NPTVBPTkVOVF9EUk1fSURf
TUFYXQ0KPiA+ICAgICAgIFtERFBfQ09NUE9ORU5UX0FBTDBdICAgICAgICAgICAgPSB7DQo+ID4g
TVRLX0RJU1BfQUFMLCAgICAgICAgICAgICAgIDAsICZkZHBfYWFsIH0sDQo+ID4gICAgICAgW0RE
UF9DT01QT05FTlRfQUFMMV0gICAgICAgICAgICA9IHsNCj4gPiBNVEtfRElTUF9BQUwsICAgICAg
ICAgICAgICAgMSwgJmRkcF9hYWwgfSwNCj4gPiAgICAgICBbRERQX0NPTVBPTkVOVF9CTFNdICAg
ICAgICAgICAgID0gew0KPiA+IE1US19ESVNQX0JMUywgICAgICAgICAgICAgICAwLCBOVUxMIH0s
DQo+ID4gLSAgICAgW0REUF9DT01QT05FTlRfQ0NPUlJdICAgICAgICAgICA9IHsNCj4gPiBNVEtf
RElTUF9DQ09SUiwgICAgICAgICAgICAgMCwgJmRkcF9jY29yciB9LA0KPiA+ICsgICAgIFtERFBf
Q09NUE9ORU5UX0NDT1JSMF0gICAgICAgICAgPSB7DQo+ID4gTVRLX0RJU1BfQ0NPUlIsICAgICAg
ICAgICAgIDAsICZkZHBfY2NvcnIgfSwNCj4gPiArICAgICBbRERQX0NPTVBPTkVOVF9DQ09SUjFd
ICAgICAgICAgID0gew0KPiA+IE1US19ESVNQX0NDT1JSLCAgICAgICAgICAgICAxLCAmZGRwX2Nj
b3JyIH0sDQo+ID4gICAgICAgW0REUF9DT01QT05FTlRfQ09MT1IwXSAgICAgICAgICA9IHsNCj4g
PiBNVEtfRElTUF9DT0xPUiwgICAgICAgICAgICAgMCwgJmRkcF9jb2xvciB9LA0KPiA+ICAgICAg
IFtERFBfQ09NUE9ORU5UX0NPTE9SMV0gICAgICAgICAgPSB7DQo+ID4gTVRLX0RJU1BfQ09MT1Is
ICAgICAgICAgICAgIDEsICZkZHBfY29sb3IgfSwNCj4gPiAgICAgICBbRERQX0NPTVBPTkVOVF9E
SVRIRVIwXSAgICAgICAgID0gew0KPiA+IE1US19ESVNQX0RJVEhFUiwgICAgICAgICAgICAwLCAm
ZGRwX2RpdGhlciB9LA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfY2NvcnIuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X2Njb3JyLmMNCj4gPiBpbmRleCAxMGQ2MGQyYzJhNTYuLjk0ZTgyYjNmYTJkOCAxMDA2NDQNCj4g
PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfY2NvcnIuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9jY29yci5jDQo+ID4gQEAgLTMx
LDExICszMSwxMyBAQA0KPiA+IA0KPiA+ICAgc3RydWN0IG10a19kaXNwX2Njb3JyX2RhdGEgew0K
PiA+ICAgICAgIHUzMiBtYXRyaXhfYml0czsNCj4gPiArICAgICBlbnVtIG10a19kZHBfY29tcF9p
ZCBtYW5kYXRvcnlfY2NvcnI7DQo+ID4gICB9Ow0KPiA+IA0KPiA+ICAgc3RydWN0IG10a19kaXNw
X2Njb3JyIHsNCj4gPiAgICAgICBzdHJ1Y3QgY2xrICpjbGs7DQo+ID4gICAgICAgdm9pZCBfX2lv
bWVtICpyZWdzOw0KPiA+ICsgICAgIGVudW0gbXRrX2RkcF9jb21wX2lkIGNvbXBfaWQ7DQo+ID4g
ICAgICAgc3RydWN0IGNtZHFfY2xpZW50X3JlZyBjbWRxX3JlZzsNCj4gPiAgICAgICBjb25zdCBz
dHJ1Y3QgbXRrX2Rpc3BfY2NvcnJfZGF0YSAgICAgICAgKmRhdGE7DQo+ID4gICB9Ow0KPiA+IEBA
IC0xMTUsNiArMTE3LDkgQEAgdm9pZCBtdGtfY2NvcnJfY3RtX3NldChzdHJ1Y3QgZGV2aWNlICpk
ZXYsDQo+ID4gc3RydWN0IGRybV9jcnRjX3N0YXRlICpzdGF0ZSkNCj4gPiAgICAgICBpZiAoIWJs
b2IpDQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4gDQo+ID4gKyAgICAgaWYgKGNjb3Jy
LT5jb21wX2lkICE9IGNjb3JyLT5kYXRhLT5tYW5kYXRvcnlfY2NvcnIpDQo+ID4gKyAgICAgICAg
ICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICAgICAgIGN0bSA9IChzdHJ1Y3QgZHJtX2NvbG9yX2N0
bSAqKWJsb2ItPmRhdGE7DQo+ID4gICAgICAgaW5wdXQgPSBjdG0tPm1hdHJpeDsNCj4gPiANCj4g
PiBAQCAtMTU0LDYgKzE1OSw3IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfY2NvcnJfcHJvYmUoc3Ry
dWN0DQo+ID4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgIHN0cnVjdCBkZXZpY2Ug
KmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gICAgICAgc3RydWN0IG10a19kaXNwX2Njb3JyICpwcml2
Ow0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4gKyAgICAgZW51bSBtdGtfZGRwX2NvbXBfaWQgY29t
cF9pZDsNCj4gPiANCj4gPiAgICAgICBwcml2ID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpw
cml2KSwgR0ZQX0tFUk5FTCk7DQo+ID4gICAgICAgaWYgKCFwcml2KQ0KPiA+IEBAIC0xNjksNiAr
MTc1LDE0IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfY2NvcnJfcHJvYmUoc3RydWN0DQo+ID4gcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCBQVFJfRVJSKHByaXYtPnJlZ3MpLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgImZhaWxlZCB0byBpb3JlbWFwIGNjb3JyXG4iKTsNCj4gPiANCj4gPiArICAg
ICBjb21wX2lkID0gbXRrX2RkcF9jb21wX2dldF9pZChkZXYtPm9mX25vZGUsIE1US19ESVNQX0ND
T1JSKTsNCj4gPiArICAgICBpZiAoY29tcF9pZCA8IDApIHsNCj4gPiArICAgICAgICAgICAgIGRl
dl9lcnIoZGV2LCAiRmFpbGVkIHRvIGlkZW50aWZ5IGJ5IGFsaWFzOiAlZFxuIiwNCj4gPiBjb21w
X2lkKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBjb21wX2lkOw0KPiA+ICsgICAgIH0NCj4g
PiArDQo+ID4gKyAgICAgcHJpdi0+Y29tcF9pZCA9IGNvbXBfaWQ7DQo+ID4gKw0KPiA+ICAgI2lm
IElTX1JFQUNIQUJMRShDT05GSUdfTVRLX0NNRFEpDQo+ID4gICAgICAgcmV0ID0gY21kcV9kZXZf
Z2V0X2NsaWVudF9yZWcoZGV2LCAmcHJpdi0+Y21kcV9yZWcsIDApOw0KPiA+ICAgICAgIGlmIChy
ZXQpDQo+ID4gQEAgLTE5MiwxMCArMjA2LDEyIEBAIHN0YXRpYyB2b2lkIG10a19kaXNwX2Njb3Jy
X3JlbW92ZShzdHJ1Y3QNCj4gPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gDQo+ID4gICBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX2Njb3JyX2RhdGEgbXQ4MTgzX2Njb3JyX2RyaXZl
cl9kYXRhDQo+ID4gPSB7DQo+ID4gICAgICAgLm1hdHJpeF9iaXRzID0gMTAsDQo+ID4gKyAgICAg
Lm1hbmRhdG9yeV9jY29yciA9IEREUF9DT01QT05FTlRfQ0NPUlIwLA0KPiA+ICAgfTsNCj4gPiAN
Cj4gPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3BfY2NvcnJfZGF0YSBtdDgxOTJfY2Nv
cnJfZHJpdmVyX2RhdGENCj4gPiA9IHsNCj4gPiAgICAgICAubWF0cml4X2JpdHMgPSAxMSwNCj4g
PiArICAgICAubWFuZGF0b3J5X2Njb3JyID0gRERQX0NPTVBPTkVOVF9DQ09SUjAsDQo+ID4gICB9
Ow0KPiA+IA0KPiA+ICAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX2Rpc3Bf
Y2NvcnJfZHJpdmVyX2R0X21hdGNoW10NCj4gPiA9IHsNCj4gDQo+IA0K

