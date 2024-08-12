Return-Path: <linux-kernel+bounces-282538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB13794E585
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 05:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB5A1C21497
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 03:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DACC1494B8;
	Mon, 12 Aug 2024 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="skqmuBed";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gLiZr91g"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765D914884E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723432729; cv=fail; b=gwsNDSiMY0v66fhY9aYwiRBHN0X2DRiEKwCyQgU0d0+Zk2X9dfFyqjwZdzX+EeV197l7Ngp9Oe5Vjfsezgc2HgVhFqW/ts/XViMYw+f2O/8MAfJkXlqH3DlyA7Oat1kgu3alm7uiSfYav6Kq2ZWAHQHyj9A4Y1t0RaCXKSA0DTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723432729; c=relaxed/simple;
	bh=yiXPIXqu909nXo0bAMovEn5Jug/zQbt3zuO8nOdDh5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lnXc4OITIP0V5gmUbwPh+JX/fZi4sWjFqxibJhuj3Imr0VoPpFiJ1rjB546XXV/pb1qFFpe9An8GXdryapMdE1CcMxn+iZtpd8hm3vTZ87BURRuzoE9huJOfwhQZCAOCcsoiDXMR7CvvU75KeLf9pM5nm94iP6prhFb7Wlckg14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=skqmuBed; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gLiZr91g; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 92549fea585911ef9a4e6796c666300c-20240812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=yiXPIXqu909nXo0bAMovEn5Jug/zQbt3zuO8nOdDh5U=;
	b=skqmuBedTTUVDPZjCGxGzC2ML2CHJ1DrI+718zt9ckqFo8Wn18RFMEA8u3+o+ef717C1Lmt0D//RQf6MybXDWWePDUPZAygZEPfKgR/nSewhmpTK8/CC79AK9B46ubj83tARv0T68XCQwqJwT5V2lia4JruPaqmRE6JrOVNlMxs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0efd48e9-072d-4811-be92-2a83ba77c245,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:486272fe-77bb-433c-b174-ffb8012693b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 92549fea585911ef9a4e6796c666300c-20240812
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 981265484; Mon, 12 Aug 2024 11:18:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Aug 2024 11:18:40 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Aug 2024 11:18:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gfXajGkCXUyKOns6eNS9am/a5gj0V5Ljtlin6yKZrn4/KtdDhHV0/EkFklH2LHjL9QmbA1W1Cpzty98ZS8z+QzqAQbt7Fvce8GBPvFj6GgUYLBGLLDLnvqO7iutEHQWZsy3y18fb2VfYhbqSgqgsWlP9tAqcKJ6E+KsvNMWsNXSnAKXtPZk8hs7jo8NQelnUix8UKlldj4IK7xKZx1rx+XoWYEa109iD+Agzcj0iQ+iNUefq1OjwkpilVlDaqQ8r0b4gjAbXfNI9d6xTaUlM542O5waRv/tMffy+VkBrlabwrkJy8vACQnDaVCKYqWLm3pnSpI2KjIt/qMm8ulBHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiXPIXqu909nXo0bAMovEn5Jug/zQbt3zuO8nOdDh5U=;
 b=ozdVeARc3e4BmhhBd3dtUGqPLGqV4HqtYFCHlnrqID76PDI2+qSdW/IUWOKaq7kVPJPwVocWPQJnxS6nbSWc6UOjeGgUvxk82oEjex1O8Lvf2HOtO3t1k9A9eoGxHstaK0uidf/BLdUr9gtPrewhxIWmcpqcJUVFverEHDC5pkhWLyoIZ/9e6WJ5Wtf4VeDwoTfdHOLmrpIfrm0Gh4HyR7cqxvLi0xwZWGXYsZ+81A+plzPFvxK6azCMtFgzpCIjTEdN/4SmyHDdEArl3aFdEkQhdWhl1zei5tPneap8MwsSKcCNQi+qCg9r/Jd7b1rTxFgAIcCk8Yb8Q7JzOe2n7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiXPIXqu909nXo0bAMovEn5Jug/zQbt3zuO8nOdDh5U=;
 b=gLiZr91gdNGkzL3JmdMhiYI6oGfk+g68utfy8koD2Y7L5d7wbrs4T+6UlRgu8jPlRG0LxsG7wCLIsSLn6O0x1gci1VIdGXODt4D/++e+81Q4b+KCFlUAUQhYobItJhNowz3LWW2gyDXv4okcVUAXhO7BblLuKpMaMs/IrR3oGEI=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7707.apcprd03.prod.outlook.com (2603:1096:400:410::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 03:18:38 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7849.019; Mon, 12 Aug 2024
 03:18:38 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] drm/mediatek: ovl_adaptor: drop unused mtk_crtc.h
 header
Thread-Topic: [PATCH 1/3] drm/mediatek: ovl_adaptor: drop unused mtk_crtc.h
 header
Thread-Index: AQHaxlXQwolv/QLcJkKP+vIUgV4c+LIjP/iA
Date: Mon, 12 Aug 2024 03:18:38 +0000
Message-ID: <1f2dd567abc8b22336dad3892bd91616d214bc5a.camel@mediatek.com>
References: <20240624-mtk_disp_ovl_adaptor_scoped-v1-0-9fa1e074d881@gmail.com>
	 <20240624-mtk_disp_ovl_adaptor_scoped-v1-1-9fa1e074d881@gmail.com>
In-Reply-To: <20240624-mtk_disp_ovl_adaptor_scoped-v1-1-9fa1e074d881@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7707:EE_
x-ms-office365-filtering-correlation-id: 4e1f418a-0fe4-4f74-380b-08dcba7d7552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T1ZIMEJyWGd4ZGNKNXArY1EyQmRrUURrZGRrVU1JT0JUZEtja3V1aDFlaW84?=
 =?utf-8?B?Z25hMEhWZHNmc29ob2dabXhWc1J0MFZqL3Qzc0VCV3BIc1IrVjUrVmxqTlZU?=
 =?utf-8?B?b2JwMGlYYU5waWIzYzRUSUJpWmU2RHZQSTlkRWRkT2wrTW13bDVyajZsWUJw?=
 =?utf-8?B?N1R2WDAxUWh6ajk2Wkg2V0RONWN3MGdiR0lNMkNCWHJMeEZkRno0UXpWaEx2?=
 =?utf-8?B?bzJVbGVoTW01cmR4N2tqWEg4NG5kN2MxRjhKTWVERXdpbVFyMGQ0U0gxWHMy?=
 =?utf-8?B?Ryt5RkdBbFpIZWJneDVRejRGZkVjY251cmlsSWNucWE3cVdZTUpvU0pmR2Zy?=
 =?utf-8?B?QW1wOUNSUFVyQ0pzK2xzWUlzYkRaTytBdVNKVllWSzhtT0ltd1VWZnVSRmtF?=
 =?utf-8?B?UU5qSzFacU5SNThQSUdWTDM3Nnk4aUpPc1EzSHQ2b1NYOGxYMmRoNUNIWlFX?=
 =?utf-8?B?YVA5KzFrd2h5bEhWYm1qMDRPOFdlcStuMUIrbCsvY0VUOHZUVzlIaDVGcUNU?=
 =?utf-8?B?TzBSMHNSby9tenBueGdpUk5GSk5GTTE3MlQrUCtrY3UxckZqamdhdW9SYUxp?=
 =?utf-8?B?LzZlNEZpYk5xQmM0YWNGdHdQamJpRDBEd2UvbzlqblUxaHhjcjJWMXdIREVn?=
 =?utf-8?B?WXBEN1cyazdMSWVRVzd6THhlbkduVXMwaXBqOCtPWjJlL0E0WVh1SXh0THhw?=
 =?utf-8?B?RFpuckFNbTJjRGRaRmsvd1E3VkI0aEJMN09ZaTJiWitrbnhDK1p4UkFNc3pH?=
 =?utf-8?B?T3FHdEdRc3pZbko2K0k3T0Z3MEFEcEROUXYycnBnNXlnVWRDcFQ0eUVTR3Vt?=
 =?utf-8?B?NWpaQzVUK243dlJpakpTUzFlWE5IYzRBZkE4ZXZnQ3h4NmFBY2Q1U1BuOFJL?=
 =?utf-8?B?RFVZdkxBemNlaktGYlByZ2VnUjBjMUZGL1U1aXhMbEF6amlUZHBiVHB0WUlZ?=
 =?utf-8?B?eUVsN3lXOVBWb3p1WjF5VHA0STV6OURHQm8xVC8vSW5Qc2pBTDMxbUNMSTVN?=
 =?utf-8?B?bDhaaXQ5M1cxdWNZMndHOUNyNmJUVzRPRkVlcDdmM0hHanB5YnlYWEw4V1la?=
 =?utf-8?B?aHkrcTMzTlpsMjVZWFozM3FzQUU2dkJ5bnpQK1hNZmpaUmVadW9ZbU5mZS9E?=
 =?utf-8?B?SHE5cjZ0V1FzZHNtMlp4Y1ZIOHhVS1NoUUFva0JjUEtVUEM3R2t2ZGgra1JJ?=
 =?utf-8?B?SllqZWw4OTNwbTdzY2YxU1FEUlN4WDB1a2JwMThNMGlTSnFZWjBDZGlmYWRp?=
 =?utf-8?B?YUM3allaT0hHOEFjNHVGamFIekdmelNVL3d0MittS3I3NG1wcFBhcS9ZVXNS?=
 =?utf-8?B?SzNpRm5kd0lhanZ6N2M3U20wemd6MVJxUDR3aWozZHRlYWw4VDFNNlM1bis1?=
 =?utf-8?B?QWs0cHBrUFJ0MEw0V2pDaUk1b1A0N0tGU3lwbCtZZDVZRmZwZU9tVHhXbmtO?=
 =?utf-8?B?RlZpcTJUSmNJL3RMTSswYVlQbzhvVHN2TWx0MEtiejJPT2o4K1NUN01nbEM4?=
 =?utf-8?B?MGMzWjgxZWlYZnJTRVNhVGFxQzNpQ0tlWnhQTy92d2pUQXRwang1RlpNRjZK?=
 =?utf-8?B?NXJBdExrb201Nk5XbmFGcHQzTnIvMjBtajlqdktxYWF1SVRGTlJaQXdZM0sv?=
 =?utf-8?B?MGI4VEdZRmVOdXpheGFZTGNKbHM1K0tFQ3pYS3J3QkEyUnJ2VElHaWc1bWdr?=
 =?utf-8?B?Z0FFM1dld1cwaE8vTUcvUVZhWHJPZkV4UTRYS3BjSFhZbmFBcXlEcVMrcWhM?=
 =?utf-8?B?TFFOc2tUdjhDZnBCVUVFRU5RbnVtZ3lQNTFvU2lHRGJOb004d2pzeVlDdVFO?=
 =?utf-8?Q?DmEPrQOxZSbD/29NznFjQQu3Lw6HwwevrQ1Qc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUxmbFhHdjR4bXpXRDBrYVJoVTcwYlpvcEt0RUVuYU5QWE80QWxlMnVrb3hO?=
 =?utf-8?B?YVgwaFVsRHhLVG5tU0MyMDJjVWpHaGNybXMrSDN2TzR2WUxPY0lVblB5ZXJD?=
 =?utf-8?B?bHdXbCtFTDJ1VUFqdEd2SEFDMUZ5RWRUTXRUckkySlhhVXViRlg4R3RFbmZ5?=
 =?utf-8?B?TTZ6WHhJbWx1YTRNZkRLMTVKVmVsQUg3aWgwWG5xRFh5RDBoR2pGWW45MnZK?=
 =?utf-8?B?ckJPREdKUTc0YTJMK1U3L0VMWTZJcnFuNk5DcmFJN1JJSkJkK3o1UE1WV1Ew?=
 =?utf-8?B?SStDMVRSTFVhaUs2by9pZ3FuT1BuN0tXZjJvbWlQT01LUjF5cDRCekdhVi9y?=
 =?utf-8?B?dlJuaE9aTDZEd2VlQ2tic2JSTzliRkw0dm4zWEZmSS9LUExaVktIcU42YkFG?=
 =?utf-8?B?RlE0L2o1L0tia3ZJNFQ2K0NWaEZTaWxDUkh1K0hQcG1UYkVZNUVteUZocVVh?=
 =?utf-8?B?NnF4bTdyRExLN3VNWE5BdjI4dk1hNXpLdWIxeG9BNEZRQ2lUc2w1V2Y0QmFM?=
 =?utf-8?B?OGxGQnc0cXVmdTlIMkdscFl5WUFxMTQ1bDRsMnpjY294cFlxWS93Y0EwSGlS?=
 =?utf-8?B?OG40RHEzOG4rUVJkZFpNN0VUUTJXTm5yUTZLcDVvWE8vS3JZc0pwcksvRVJJ?=
 =?utf-8?B?bDViNW13bGk1ZUtyOWJOcDBVTm03WDBjVFFzTCsrMmRWZTRtYjJmQ0hJZVh5?=
 =?utf-8?B?MXBOMXIxOUVqVUxnNlg2c3R2SFZHQXpmcC9EQTRoMDBzWTRxMng2QnEwY2E4?=
 =?utf-8?B?dXRqS3VObktKeTlSYXBxYW4xR041aCtMWUNndHVxRGovYkxPRkJMdHdkNmNQ?=
 =?utf-8?B?aGhBK0FscVpSVU03emI4OVU5K1JmTEthbytrc1JCSXU2SGRaT0tPdDN5djhP?=
 =?utf-8?B?clB2UElnc2tvNWN5dzNEcko4bW41MHpSZmxxSUdHV2FhQnVuWnlPdUdwbGVh?=
 =?utf-8?B?NXhLRFhWUW9BeDhuUzljbXdBbURGVXIwenFNKzZLdTlOdmVtR2FVNTJoU3J4?=
 =?utf-8?B?cWJqRTZVTEZyS1BzOWtYNlM1QkxMdWhGbk9aZkR0ejd0QkFDTGs4bmwzQStI?=
 =?utf-8?B?aWtpQjBaQWZwZnlsUEwzSkRKL1MwSi9qaVZiWDJPaTVmL1pBNzBteURrTmU2?=
 =?utf-8?B?R2JPU2FESG92N0E1c2k3RGNOdnh5OUtSYkxndEEvbjEvd2pUN3hGajRLc0F2?=
 =?utf-8?B?d0pUUGNCZ2ZnVXNKUVRINTZCU2RvVTI5Y1BaNC9PWkVFTzF1U1k5TXVhSDZ5?=
 =?utf-8?B?QjBpblJBMW1xa0FyTWg3MnVwc2JnZ3hGOWFyRTJiV25MTXM3dEhSVUdnV2l4?=
 =?utf-8?B?UDFNL1V2UUI0d2JyNmRFbWxwZ2tZRFF4K3ZRbUIzRy8rL2V6ZkNrWndXam5B?=
 =?utf-8?B?T3pMcTVySDFZQU45TUtGYU1SWGxqWnltNkplSDZMMklIdXVxc3ZEQmRWZVNm?=
 =?utf-8?B?blVidEZNRjJzd0xHV2Q1S1FaeFY5dllRRnkxMy9ZcWM3dkxaME5sWENxTjlm?=
 =?utf-8?B?Z3NCZHkvbHYvdXZKZ0IxU1oxaERxWmNQYXV4ekJxWGNON1RFcWtHMFlUYVQv?=
 =?utf-8?B?UDQ2aDVDR2h2Njd4emlVbHdtUFhHWEZ1NU1QMHVQZk56QUQ4RC9POGdwc3VB?=
 =?utf-8?B?cXJhOXFiYy9aLzFLdjc4cmhJSkdKeSttWkJub0RvZjFOWC92V0JKdExIekMw?=
 =?utf-8?B?akVGUlhqVGhvQ1hKOVdocEtseURlZXVaUStweDltaU9QaTN3YWxuNVF2NmNE?=
 =?utf-8?B?WnA1amVIK3JrVldrVUFsOU5KNDJsZXozcEFnZjZKYUxaYjg5UDZxM3pPa3BG?=
 =?utf-8?B?Rys0eVFwS1VpdldTOUdOaGxPVVdwSWdWVzNqVllIbllyMW0zb01PMWJTcjVO?=
 =?utf-8?B?RDA5RUVzVWVscm01ZjNYNllDMUV5bnpoZmN4UCtVY0pza29lTXpKeG5CMmhU?=
 =?utf-8?B?Z1FoMkhCTDl0M3FIeXE1TENTNVhrQXk0YnZ5bWVrQ1AyYUpnS24yYlpyTDhO?=
 =?utf-8?B?aG9DV1ZPdGdsalNNR1Y2Vzd5K2h0bitlTVRSQ1BQazFsMkV2eGpxcU1lUFJ4?=
 =?utf-8?B?T0laRS9HaEx4T2t1b2d0NVkraW1YZVlNY3FVb1J3K3ZCenJnMkwxM2RqQ0ty?=
 =?utf-8?Q?qbEIq5R2+csT+d+kXDmxSYxvl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <842D63F5B86C624B8A483C9608F99B7B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1f418a-0fe4-4f74-380b-08dcba7d7552
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2024 03:18:38.1649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hklEbQZfuthhf9yOc5bQ3d5FKe8JxGfeaRJXMXsquFdY4K8BGiWeaQxgZJAmvcqOhZW/SZnyUdHgK/HFJyCQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7707

SGksIEphdmllcjoNCg0KT24gTW9uLCAyMDI0LTA2LTI0IGF0IDE4OjQzICswMjAwLCBKYXZpZXIg
Q2FycmFzY28gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgTm9uZSBvZiB0aGUgZWxlbWVudHMgZnJvbSB0
aGF0IGhlYWRlciBpcyB1c2VkIGluIHRoaXMgZmlsZS4NCg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxj
ay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBDYXJyYXNj
byA8amF2aWVyLmNhcnJhc2NvLmNydXpAZ21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jIHwgMSAtDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gaW5kZXggMDJkZDdkY2RmZWRiLi4xNDE4OTkyMzEx
YzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxf
YWRhcHRvci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmxf
YWRhcHRvci5jDQo+IEBAIC0xNyw3ICsxNyw2IEBADQo+ICAjaW5jbHVkZSA8bGludXgvc29jL21l
ZGlhdGVrL210ay1tbXN5cy5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9tZWRpYXRlay9tdGst
bXV0ZXguaD4NCj4gIA0KPiAtI2luY2x1ZGUgIm10a19jcnRjLmgiDQo+ICAjaW5jbHVkZSAibXRr
X2RkcF9jb21wLmgiDQo+ICAjaW5jbHVkZSAibXRrX2Rpc3BfZHJ2LmgiDQo+ICAjaW5jbHVkZSAi
bXRrX2RybV9kcnYuaCINCj4gDQo+IC0tIA0KPiAyLjQwLjENCj4gDQo=

