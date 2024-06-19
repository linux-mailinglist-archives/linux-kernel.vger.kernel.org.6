Return-Path: <linux-kernel+bounces-220451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AF590E1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 05:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4CA22858BC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 03:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AE54277;
	Wed, 19 Jun 2024 03:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aW4SLM3h";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YFYdXf3T"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903F21DFCB
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718767062; cv=fail; b=okSoztcSXkQwDX03XmR+YdU5PqLBwcytFDd1unz1RFP4era0h8rbVdXUlG1FiiUmawb8Dwna8z61GmOt22h5ajPibMuJf58EGw3di6E1ouAjxYDc6IwCKFRokYUGknNoyyuWU6Tt3QHSZS1tHMF7q/Wk52fUa4OGa7LJPB8Bs8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718767062; c=relaxed/simple;
	bh=VY0CMhYD3/2WDobvMKziEei+v6UHWcv625pNU5nE4Qk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yh2LVYMUqr2gyvpceKJ54g4tdqMZonDKJDzMuDBrlu00QKSjG+IRY0pJFnaE0SR/yRTqwjq1yVtsb+QxqtJ7u8dzNgGUwPyyxXgxJQFfv3FzQF7Rfp71Vz2gId2+kM6aTBMdEqNe+/1yMeT0w3ZmKKZcZgVqWxCyv8xhuT2YDC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aW4SLM3h; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YFYdXf3T; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 77f3c4ee2dea11efa22eafcdcd04c131-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VY0CMhYD3/2WDobvMKziEei+v6UHWcv625pNU5nE4Qk=;
	b=aW4SLM3hXKsyM7ev4V6I+gw7tq1TPGsmDF/N4BwwzxzmZ6Sls0UZtNe2yvgF/kvLCriKKmNWarDDnPvEKe8Bk+6Df9zakdb/9TAbA8RV+WqcWy6hO3CTI034CmaVHvbDmmZaI+56l3kOSY1dKTvRaH7iLTnYWr7gFm0NoRDIVoQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:d72d7a72-713e-4d1c-bb1b-3c1ddb241a26,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:ed37c288-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 77f3c4ee2dea11efa22eafcdcd04c131-20240619
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1629841918; Wed, 19 Jun 2024 11:17:32 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jun 2024 20:17:31 -0700
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 11:17:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDmxUpKPtRG6twpKedMQRLYQxnTDtL0ymR8XnO2HNoO00o7AkdiRHMF2IJt+rmz8sRnSdbO0NHCoG2jQ/lpvwAOQ5mmNA6oROo8ENfs92Mu1Qnw7YnldyVrdKimKIfs2yOTLhDSiLqLom2diCIey1QWuEtmlYchXHf9gnyDCqrtZrkelgzeW2+H4m9Ei8Efd+fbAS7oJRK0ZHXD/4um/FGi2uFb7U4Qxf2nj+ZjmqgRlJjn+eiVUCEtJHoIN2FbRPc6xDdNGwafAAXmQNT0VSjK/z/Y1q/uCtxVdewKZGO8v6kU763O66oEtx0nRi0KzLXJVUslKBbiVGMHhogQQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VY0CMhYD3/2WDobvMKziEei+v6UHWcv625pNU5nE4Qk=;
 b=W/viFyqTF7ENwhN5n9bdDnYutz4fOteKmtRnEKt4ZGCK3KiFQs+16o1UHWNOa9ITM6RErpvHvFo2KHFNYZuNxB2cBXrzDpabA9bQ5sfdtz+PAHusSNxoVIus5e1dz21FjusaOepvVyen6KttQy8/SzpgcyBlrkihJTJnEksoM2pTS4gY2C6E5uQgkWMdX65OCQRsOvCvAk8aQjPRmFDWLl9kbECCG7+QNTiy6xrSWn9MosctZAuNYHvCbHY8deHN6cQ/LixGinTbIl7aF7o3HiRhO0Ad5x0fvwhzuGBU10G0D0xIaXuc347psKGwpQR5x9KJUpFFvOeCIACPpQR4LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY0CMhYD3/2WDobvMKziEei+v6UHWcv625pNU5nE4Qk=;
 b=YFYdXf3TFppZxSnZk4//Lbt18TiIx9ema+APjeHEGWx5DmNkvb2XgQqk+5QwXzKkDmL8m49DMK5/IQyD35HySKGiIcn6TWaDT3BmQzPmjB3rYE0k6A+VN5Nsd5LQdPhiAJGlP+XE90dfF6qt4fGJ833dp8fkix2d/NPKML6niVA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8294.apcprd03.prod.outlook.com (2603:1096:405:23::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Wed, 19 Jun
 2024 03:17:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 03:17:29 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Topic: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Index: AQHavgUxkv27uBRE70eZOpVJTFpNt7HGvxoAgAcG4oCAAKxogA==
Date: Wed, 19 Jun 2024 03:17:29 +0000
Message-ID: <b72c5de49da23dbf7f8950c3af6c0a17c8e22554.camel@mediatek.com>
References: <20240614024620.19011-1-shawn.sung@mediatek.com>
	 <20240614024620.19011-17-shawn.sung@mediatek.com>
	 <a966988a520adc5aee5ee70657efd778d011ded0.camel@mediatek.com>
	 <ca5f0f155d9dec0b6c853128d9fd753042a5d25e.camel@mediatek.com>
In-Reply-To: <ca5f0f155d9dec0b6c853128d9fd753042a5d25e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8294:EE_
x-ms-office365-filtering-correlation-id: d79ef6c7-dd4e-477c-f328-08dc900e5a4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?dk55Y3lVcVZlU0N1UmFuRHJIN1BDTnoyakQzKzlybUN3TWFlSDMvdFVTNlpm?=
 =?utf-8?B?SFE2cE5MaktTQU1Ick1md3MzVTdhY3J0c1V2d1hoVGJKQmh5NmNDclpHbnJ1?=
 =?utf-8?B?bFphYngxWDV3eks0SEVzODg5VzJjdHVJSUxmMzdTc3NueGFaZ1dORmR3aTg2?=
 =?utf-8?B?YWVFQzFtbnNZVElMMTlZWndUM0t0Qnp2eE1WVWJlS1FSS3dOUlVRMU1NNFNu?=
 =?utf-8?B?ejJpRlBMVmVuanBKblJ4RG8rYm9MVS9EQmNzVWxrRzduMGx0UUZsUXJQS0pz?=
 =?utf-8?B?ZnEzNEhYWlhNRWxLUHl6L25rcFJGLzBDMjNJUm9jQmxEY05YbGpSZTlZRE9P?=
 =?utf-8?B?UGVnY01GeDMwMFVSTDRIUDBYb093c2crUjZXUG9pK0hITDg3TG5SMGhvb1hT?=
 =?utf-8?B?VkNyWWlKTkV4VVNqenl4bXVVQ0JsMGVwK3cyU3BXYWdsNmVkeDZhOFJJRkw3?=
 =?utf-8?B?WWZHN1hjNHd5VnEvalRJaDhRWmVDMUF0Rk4wSlFYcUEza2RiY3VlVUsvQmwv?=
 =?utf-8?B?VTlCenFjRm1ZcUlQU3ZsMHFuMDEzOWwxSGFKbVdMdTFDRTh5MEZGMjdkOUJl?=
 =?utf-8?B?UnpXdWxLQi8rMnpma2R1UEMyZlZGRU5sWHRpVmwzLzIxTElEV0UzY0RmUUV1?=
 =?utf-8?B?aXNFZkZVK3lJYzBGMFRJSkVUWUVwUlF5U0RBZ1duV0V5MHFKZFU2RFR3Rk5C?=
 =?utf-8?B?T2pNTGJDb1JTT3hvdTY5Q1BwMnBGNHZiRElyVlIySmo0ZFVaMXByczlkTmVT?=
 =?utf-8?B?WFZFaGJBVUFvYzdqL1NtQzhxemhtZGdobExYUGl0aWFUWGpyanJRNlVtQ3Vn?=
 =?utf-8?B?ZzZYMGJEWHdJMlp4OWYxMUFGM2RDWTZHNXpyS2pLMGp6anNwNkpqalAyUTVD?=
 =?utf-8?B?L0E3MXh1a04xMDloYTg5bExQM1VLMmRjeU5mQUErbEhUR3FzV29TSEI3VkNR?=
 =?utf-8?B?dmhjY3grWFgrcjI1cHltMm1wdVc3ZUNUcngremdMbHNMY1Bia29kOCswczBq?=
 =?utf-8?B?SVN0dHJoN1hSQVR5eTN2M1paY25yaVQ5SWtBUnZHbmZWdGtzTmVGWXVRTlNi?=
 =?utf-8?B?S3RBZDVHM014WUIzU3JaandGV01GditlWGNyQVFXLzIvcDFRU3JrUmtLdlMv?=
 =?utf-8?B?eHpzL01uK0MxV21tMnNjc0dWclNoYitLaW1KWlVweUZvOEZXUkVyOGVkdHI2?=
 =?utf-8?B?U2g5Q0dxU2hjeHNKZ1hDb2ZGMitLQUsyRjYzMXZlSkFLMFRSNUZZV1RSWjNl?=
 =?utf-8?B?UTVRQWdEVitzVUQxbVorZjBaUlhZQzZ2elRoVkorekFLNjUxc1F6SExyZjVO?=
 =?utf-8?B?aTArYWViMWx4cVdNT1UzQjFnT1VmcXp5a3V1b1BNSklhZGxRMkVwWVhGLzQz?=
 =?utf-8?B?S0hIUlJvVlNndmdzZjRUVkM0TTMxVCtaaTZmNHNCVDFJb1l1K1BOYjRjeklC?=
 =?utf-8?B?UkRrR0R2endIWGgzdWZWVTE4WXAzT2ZTVURoVW5PN2pXUW1PMWNwNmNDSVlY?=
 =?utf-8?B?MFh0TWRHVk9jOHhzczBRbi82cTNvNFJqV1lyNEswaDBvNHhXb0FMWkVtRlVS?=
 =?utf-8?B?N1d1bXpnK1YzdGFsbTdIWldGaE5mNXM4MXBLc1NJUFRBblQ4aXZyZFd2N3dF?=
 =?utf-8?B?cHZxQldCNTMxTjNCWm9TVklrdUVON3VabkhPTzNXUWlWZWhSODBtNTV0MnZD?=
 =?utf-8?B?aktGYzJkL0gxMEplZ1V2M0lkM1YvZ2w3MXZwTk80YmxFUUpETGhwa3R6T0RX?=
 =?utf-8?Q?xrk3uM44LY/LdAl/pcxDLjEuc+NCe8B0ygC7Xbl?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHRkSnRIT2VTZkNQOTZOSm54S2JYcy90d0RnMlVxbXR2ZnRGbGYwelR1bi9a?=
 =?utf-8?B?bUcxWkxpTzBJMGczRWFPMitCSmNGcjEwWG9wbFlhUlJaVjV5TXcxVldsbjlm?=
 =?utf-8?B?Y0Z0b0UyMU40UDRwOWNEVGVhbzhjM3Bqd3hQUWNpMVNrNDFmdWZFN00ydm9n?=
 =?utf-8?B?SVhLZ01DUHc3REZBaWpNTVNzVDFIYkpDOXFBSDRueGg1WXlKbkdOY0NIc0J6?=
 =?utf-8?B?bUoyV2pTdFlRUXpKeUUvN2lEWFZZMTBacjlGbXYzTFZ2U2U5bTVMSTZiY1Fa?=
 =?utf-8?B?RUtFcFYzQnVmRkhEb0lXRTFNVHBRZnNiZ3RxMkhKaWtYQVQ3bVhOWVRhMVRi?=
 =?utf-8?B?b1BYM0pxZFpZV2hPM2JibDlGbjRQYy9SR2RhNFlnNDBGYjVHWHVNbTZQZitH?=
 =?utf-8?B?R2NvOEJDbEdEczNSSGNTSzdra2ZISmkrQzlpNzJFSXJEVG9FN210cFRtV3FT?=
 =?utf-8?B?M1FESUVYZXNlRTRoR1R2K3B3ekRyeU9iQXlSckY4LzEzU3luTTZLRWhMb056?=
 =?utf-8?B?M0hqTG1VTXVOTTJBMm9PVVZRb1ZmYTZra2xZeXF4Y1JPOEY4SVF6WjRpbXBQ?=
 =?utf-8?B?OUxiZ0xsZjhZdkgyY295SkJLU0RCUnRtdlg5dE1FSis5Z3F6YnQvNHlWNER0?=
 =?utf-8?B?YjQ5RTd5NEZSV056T0pEUmhvRkd2aFBIc0lnMkNhM1dmNmxhTjU3ci9hQ05i?=
 =?utf-8?B?WHlIY1pTd0cwZE9XMFc5bDJmKzUweTFZNUxmVk85T2xLWGNRMHFOcXNCeitn?=
 =?utf-8?B?NGxYT1RtSjBUYUZuYUJZWXpTUmpNRnltMldnN2VHMFd5T1VUQU9MT0JBTms5?=
 =?utf-8?B?OUlXb0M3Zi9nV3FBY1NsbXNpdHJLWmhjUlRCaTZoTUVWMVcrQWJWQmNtZVFw?=
 =?utf-8?B?ckZqaWpnRXhtbjhCRFpqeExBb0VzQlJNZnBueTZkWTdIOFh5a2pTQndGQU9y?=
 =?utf-8?B?UFJIcHBueEZDOFY3VWtNbkpCOUJLaC82aHNUU3JudWltZ3RtRVNsOHhzamhZ?=
 =?utf-8?B?ODdkWDFxRnV0K2p4L2lNM1lXdEo4b2FGd1FzV2k1MmUreWlmZnd2aEk2U3VY?=
 =?utf-8?B?UURKUkFNbHpSTnMyY2tvMDFZSmhadVZRU1RjUUhpRWJOaGxvUHk1NDdnL2dR?=
 =?utf-8?B?YndOcWdqdEtIeHlmVkZVNTBmemRJdjdBOUtiMTF0U3hJVk10RDdKSEtxRjBS?=
 =?utf-8?B?eElxcmdranY1SzY3TG1venNGVFdsM1JNeWZ4T1cvY2dSUFBzQ0NmbERhWVZy?=
 =?utf-8?B?RmVZWm9mZHJtZ251Q3pmdWkyWFk1S0V2UDFreXRxcytDTTRmK2JRbkwwUVRP?=
 =?utf-8?B?WDN3MVBabTJVSHJmVU4yQ0xiT0pjS1RNMHNqRDFqTUg0RlJpdi9xUzNkUy9E?=
 =?utf-8?B?cmZ1MWJ0SVVaNVE0d05IUDlZeURIQ0Q2ekVBUmdIRngzMExkKzFNVVlMbzcz?=
 =?utf-8?B?NDZaelBBNUovalZIbzlKeEdjZzJrSEw1V2Vna0RYMDNrQVlkQjd1S25uVmlK?=
 =?utf-8?B?SHBzNElUZWYwcTRPS3Y4UmJraUNOUXdtbHdzV0QxWUhEQ0tjc0FYbndwL1lr?=
 =?utf-8?B?VkRzaDVEazZ2c2twd2xDM0dLNi9LZ2RlSkU5YzNVdUZYcWVlQWkxa0pPZXhQ?=
 =?utf-8?B?bnZITGYveDFkc1lRSFp4YkY1SzR0TFRqUkFDcWJPd2xaVHQzanpid3dxM0JY?=
 =?utf-8?B?NWxrcEd3L3JFTFNQTDg0bW54SkpEQ2JoMGJ5K1hiZDhjamdJM3lQQTVpTVJy?=
 =?utf-8?B?amF5aW52TFg1WnBMYTZ3TGp0WGJiZjlKTytoT2Rsa2paYjNHcUpFaXBrNE4x?=
 =?utf-8?B?MDcra2t5YytmUjVqdzVyN1dTMlZIQnBZWWR1RjJYZ0gwakZzNzR0cFZid1dx?=
 =?utf-8?B?YktFWUFIbmVVL2xNV3g2UndqWE8zMWtsbUx5OUhCaC9Ub2ZsdTF1SXVLVTFJ?=
 =?utf-8?B?SmR3MGZBcng5dURXcFZSMkNNbDdFbXFxYVM2K3VPRkVxbUhvZXpCVHBST0pv?=
 =?utf-8?B?KzViK0xkY1BBZ2JOVC9pQ3BVU0thOTZueHdQWEVmY2pBRnh1Tkt2Ui9hbnQ5?=
 =?utf-8?B?RWlHS1ZmVE9lZ2lMTTVSMEpsdTN3emtEdWtkZXNTVWI2RUtxS05hbnVZVjV6?=
 =?utf-8?Q?IzjaGTkr9QDotVbdIhomHT1Ym?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F692BFCA8EFC61439579941F9ABA77EA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79ef6c7-dd4e-477c-f328-08dc900e5a4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 03:17:29.8550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NEuyg1klscROcDzyX5taja/Dc4HV6ojeIrDL9sGekN5Q6PCjdqWnE6DYf0WBPlhzO4sX/sOgBxvfNEdD+KjKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8294

SGksIEphc29uOg0KDQpPbiBUdWUsIDIwMjQtMDYtMTggYXQgMTc6MDAgKzAwMDAsIEphc29uLUpI
IExpbiAo5p6X552/56WlKSB3cm90ZToNCj4gSGkgQ0ssDQo+IA0KPiBPbiBGcmksIDIwMjQtMDYt
MTQgYXQgMDU6NDIgKzAwMDAsIENLIEh1ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+IE9uIEZyaSwg
MjAyNC0wNi0xNCBhdCAxMDo0NiArMDgwMCwgU2hhd24gU3VuZyB3cm90ZToNCj4gPiA+IEZyb206
IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+ID4gDQo+ID4g
PiBTdXBwb3J0ICJQcmUtbXVsdGlwbGllZCIgYWxwaGEgYmxlbmRpbmcgbW9kZSBvbiBpbiBPVkwu
DQo+ID4gPiBCZWZvcmUgdGhpcyBwYXRjaCwgb25seSB0aGUgImNvdmVyYWdlIiBtb2RlIGlzIHN1
cHBvcnRlZC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8
c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCA0MiArKysrKysrKysrKysrKysrKysrKy0NCj4g
PiA+IC0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gPiA+IGluZGV4IDY1Njc4MDZjZjRlMi4uNDdkMGIwMzlhNjE2IDEwMDY0
NA0KPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+
ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiA+
IEBAIC01Miw4ICs1MiwxMiBAQA0KPiA+ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgo
MSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gNCkNCj4gPiA+ICAjZGVmaW5lIEdNQ19USFJFU0hP
TERfTE9XCSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMpIC8gOCkNCj4gPiA+ICANCj4gPiA+ICsj
ZGVmaW5lIE9WTF9DT05fQ0xSRk1UX01BTglCSVQoMjMpDQo+ID4gPiAgI2RlZmluZSBPVkxfQ09O
X0JZVEVfU1dBUAlCSVQoMjQpDQo+ID4gPiAtI2RlZmluZSBPVkxfQ09OX01UWF9ZVVZfVE9fUkdC
CSg2IDw8IDE2KQ0KPiA+ID4gKw0KPiA+ID4gKy8qIE9WTF9DT05fUkdCX1NXQVAgd29ya3Mgb25s
eSBpZiBPVkxfQ09OX0NMUkZNVF9NQU4gaXMgZW5hYmxlZCAqLw0KPiA+ID4gKyNkZWZpbmUgT1ZM
X0NPTl9SR0JfU1dBUAlCSVQoMjUpDQo+ID4gPiArDQo+ID4gPiAgI2RlZmluZSBPVkxfQ09OX0NM
UkZNVF9SR0IJKDEgPDwgMTIpDQo+ID4gPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9BUkdCODg4
OAkoMiA8PCAxMikNCj4gPiA+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQkE4ODg4CSgzIDw8
IDEyKQ0KPiA+ID4gQEAgLTYxLDYgKzY1LDExIEBADQo+ID4gPiAgI2RlZmluZSBPVkxfQ09OX0NM
UkZNVF9CR1JBODg4OAkoT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggfA0KPiA+ID4gT1ZMX0NPTl9C
WVRFX1NXQVApDQo+ID4gPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9VWVZZCSg0IDw8IDEyKQ0K
PiA+ID4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfWVVZVgkoNSA8PCAxMikNCj4gPiA+ICsjZGVm
aW5lIE9WTF9DT05fTVRYX1lVVl9UT19SR0IJKDYgPDwgMTYpDQo+ID4gPiArI2RlZmluZSBPVkxf
Q09OX0NMUkZNVF9QQVJHQjg4ODggKCgzIDw8IDEyKSB8IE9WTF9DT05fQ0xSRk1UX01BTikNCj4g
PiANCj4gPiAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCAoT1ZMX0NPTl9DTFJGTVRf
UkdCQTg4ODggfA0KPiA+IE9WTF9DT05fQ0xSRk1UX01BTikNCj4gPiANCj4gPiBCdXQgSSdtIGNv
bmZ1c2VkIHdpdGggdGhlIG5hbWluZy4NCj4gPiANCj4gDQo+IFdlIGZvdW5kIHRoYXQgb3JpZ2lu
YWwgbmFtaW5nIGlzIG5vdCBjb3JyZWN0LCBzbyB3ZSBmaXggaXQgd2l0aCB0aGUNCj4gcGF0Y2g6
DQo+IA0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0
ZWsvcGF0Y2gvMjAyNDA2MTYtbWVkaWF0ZWstZHJtLW5leHQtdjEtMTEtN2U4ZjljZjc4NWQ4QG1l
ZGlhdGVrLmNvbS8NCj4gDQo+IFBBUkdCODg4OCBpcyBub3QgQVJHQjg4ODggKyBNQU4uDQo+IA0K
PiBJZiBESVNQX1JFR19PVkxfQ09OIG9wZW4gdGhlIE1BTiBiaXQsIHNvbWUgb3JpZ2luYWwgY29s
b3IgZm9ybWF0DQo+IHNldHRpbmdzIHdpbGwgYmUgY2hhbmdlZCwgZm9yIGV4YW1wbGU6DQo+IA0K
PiBXaGVuIE1BTiA9IDA6DQo+IFJHQjU2NSA9IDAwMDAgaW4gYml0WzE1OjEyXQ0KPiBSR0I4ODgg
PSAwMDAxIGluIGJpdFsxNToxMl0NCj4gQVJHQjg4ODggPSAwMDEwIGluIGJpdFsxNToxMl0NCj4g
UkdCQTg4ODggPSAwMDExIGluIGJpdFsxNToxMl0NCj4gVVlWWSA9IDAxMDAgaW4gYml0WzE1OjEy
XQ0KPiBZVVlWID0gMDEwMSBpbiBiaXRbMTU6MTJdDQo+IA0KPiBXaGVuIE1BTiA9IDE6DQo+IFJH
Qjg4OCA9IDAwMDAgaW4gYml0WzE1OjEyXQ0KPiBSR0I1NjUgPSAwMDAxIGluIGJpdFsxNToxMl0N
Cj4gQkdSQQ0KPiA4ODg4ID0gMDAxMCBpbiBiaXRbMTU6MTJdDQo+IFBBUkdCODg4OCA9IDAwMTEg
aW4gYml0WzE1OjEyXUJHUkE0NDQ0ID0gMDEwMA0KPiBpbiBiaXRbMTU6MTJdDQo+IEJHUkE1NTUx
ID0gMDEwMSBpbiBiaXRbMTU6MTJdDQo+IFlVWVYgPSAxMDAwIGluIGJpdFsxNToxMl0NCj4gVVlW
WQ0KPiA9IDEwMDEgaW4gYml0WzE1OjEyXQ0KPiBZVllVID0gMTAxMCBpbiBiaXRbMTU6MTJdDQo+
IFZZVVkgPSAxMDExIGluIGJpdFsxNToxMl0NCg0KSSB0aGluayB5b3UgY291bGQgZGVmaW5lIHBy
ZW11bHRpcGxpZWQgZm9ybWF0IGFzOg0KDQojZGVmaW5lIFBSR0I4ODgJCSgwIDw8IDEyKSB8IE9W
TF9DT05fQ0xSRk1UX01BTg0KI2RlZmluZSBQUkdCNTY1CQkoMSA8PCAxMikgfCBPVkxfQ09OX0NM
UkZNVF9NQU4NCiNkZWZpbmUgUEJHUkE4ODg4CSgyIDw8IDEyKSB8IE9WTF9DT05fQ0xSRk1UX01B
Tg0KI2RlZmluZSBQQVJHQjg4ODgJKDMgPDwgMTIpIHwgT1ZMX0NPTl9DTFJGTVRfTUFODQojZGVm
aW5lIFBCR1JBNDQ0NAkoNCA8PCAxMikgfCBPVkxfQ09OX0NMUkZNVF9NQU4NCiNkZWZpbmUgUEJH
UkE1NTUxCSg1IDw8IDEyKSB8IE9WTF9DT05fQ0xSRk1UX01BTg0KI2RlZmluZSBQWVVZVgkJKDgg
PDwgMTIpIHwgT1ZMX0NPTl9DTFJGTVRfTUFODQojZGVmaW5lIFBWWVVZCQkoOSA8PCAxMikgfCBP
VkxfQ09OX0NMUkZNVF9NQU4NCg0KPiANCj4gPiANCj4gPiA+ICsjZGVmaW5lIE9WTF9DT05fQ0xS
Rk1UX1BBQkdSODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4IHwNCj4gPiA+IE9WTF9DT05f
UkdCX1NXQVApDQo+ID4gDQo+ID4gI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQUJHUjg4ODggKE9W
TF9DT05fQ0xSRk1UX0FCR1I4ODg4IHwNCj4gPiBPVkxfQ09OX0NMUkZNVF9NQU4pDQo+ID4gDQo+
ID4gPiArI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQkdSQTg4ODggKE9WTF9DT05fQ0xSRk1UX1BB
UkdCODg4OCB8DQo+ID4gPiBPVkxfQ09OX0JZVEVfU1dBUCkNCj4gPiANCj4gPiAjZGVmaW5lIE9W
TF9DT05fQ0xSRk1UX1BCR1JBODg4OCAoT1ZMX0NPTl9DTFJGTVRfQkdSQTg4ODggfA0KPiA+IE9W
TF9DT05fQ0xSRk1UX01BTikNCj4gPiANCj4gPiA+ICsjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BS
R0JBODg4OCAoT1ZMX0NPTl9DTFJGTVRfUEFCR1I4ODg4IHwNCj4gPiA+IE9WTF9DT05fQllURV9T
V0FQKQ0KPiA+ID4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdCNTY1KG92bCkJKChvdmwpLT5k
YXRhLT5mbXRfcmdiNTY1X2lzXzAgPw0KPiA+ID4gXA0KPiA+ID4gIAkJCQkJMCA6IE9WTF9DT05f
Q0xSRk1UX1JHQikNCj4gPiA+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQjg4OChvdmwpCSgo
b3ZsKS0+ZGF0YS0+Zm10X3JnYjU2NV9pc18wID8NCj4gPiA+IFwNCj4gPiA+IEBAIC03NCw2ICs4
Myw4IEBADQo+ID4gPiAgI2RlZmluZQlPVkxfQ09OX1ZJUlRfRkxJUAlCSVQoOSkNCj4gPiA+ICAj
ZGVmaW5lCU9WTF9DT05fSE9SWl9GTElQCUJJVCgxMCkNCj4gPiA+ICANCj4gPiA+ICsjZGVmaW5l
IE9WTF9DT0xPUl9BTFBIQQkJR0VOTUFTSygzMSwgMjQpDQo+ID4gPiArDQo+ID4gPiAgc3RhdGlj
IGlubGluZSBib29sIGlzXzEwYml0X3JnYih1MzIgZm10KQ0KPiA+ID4gIHsNCj4gPiA+ICAJc3dp
dGNoIChmbXQpIHsNCj4gPiA+IEBAIC0yOTgsNyArMzA5LDEzIEBAIHZvaWQgbXRrX292bF9jb25m
aWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4gdW5zaWduZWQgaW50IHcsDQo+ID4gPiAgCWlm
ICh3ICE9IDAgJiYgaCAhPSAwKQ0KPiA+ID4gIAkJbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFf
cGt0LCBoIDw8IDE2IHwgdywgJm92bC0NCj4gPiA+ID4gY21kcV9yZWcsIG92bC0+cmVncywNCj4g
PiA+IA0KPiA+ID4gIAkJCQkgICAgICBESVNQX1JFR19PVkxfUk9JX1NJWkUpOw0KPiA+ID4gLQlt
dGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIDB4MCwgJm92bC0+Y21kcV9yZWcsIG92bC0+
cmVncywgDQo+ID4gPiBESVNQX1JFR19PVkxfUk9JX0JHQ0xSKTsNCj4gPiA+ICsNCj4gPiA+ICsJ
LyoNCj4gPiA+ICsJICogVGhlIGJhY2tncm91bmQgY29sb3IgbXVzdCBiZSBvcGFxdWUgYmxhY2sg
KEFSR0IpLA0KPiA+ID4gKwkgKiBvdGhlcndpc2UgdGhlIGFscGhhIGJsZW5kaW5nIHdpbGwgaGF2
ZSBubyBlZmZlY3QNCj4gPiA+ICsJICovDQo+ID4gPiArCW10a19kZHBfd3JpdGVfcmVsYXhlZChj
bWRxX3BrdCwgT1ZMX0NPTE9SX0FMUEhBLCAmb3ZsLQ0KPiA+ID4gPiBjbWRxX3JlZywNCj4gPiA+
IA0KPiA+ID4gKwkJCSAgICAgIG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1JPSV9CR0NMUik7DQo+
ID4gDQo+ID4gVGhlIGNvdmVyYWdlIG1vZGUgZm9ybXVsYSBpczoNCj4gPiBkc3QuUkdCID0gc3Jj
LlJHQiAqIHNyYy5BICsgZHN0LlJHQiAqICgxIC0gc3JjLkEpDQo+ID4gDQo+ID4gVGhlIHByZS1t
dWx0aXBsaWVkIG1vZGUgZm9ybXVsYSBpczoNCj4gPiBkc3QuUkdCID0gc3JjLlJHQiArIGRzdC5S
R0IgKiAoMSAtIHNyYy5BKQ0KPiA+IA0KPiA+IEJvdGggZm9ybXVsYSBoYXMgbm8gZGVzdGluYXRp
b24gYWxwaGEgKEkgdGhpbmsgYmFja2dyb3VuZCBjb2xvciBpcw0KPiA+IGxhc3QgZGVzdGluYXRp
b24pLA0KPiA+IHdoeSBjb3ZlcmFnZSBtb2RlIHdvcmsgZmluZSBidXQgcHJlLW11bHRpcGxpZWQg
bW9kZSBoYXMgc29tZXRoaW5nDQo+ID4gd3Jvbmc/DQo+ID4gDQo+IA0KPiBhbHBoYSBvZiBjb3Zl
cmFnZSBtb2RlIGZvcm11bGEgaXM6DQo+IGRzdC5hID0gZHN0LmEgeCAoMHhmZiAtIHNyYy5hIHgg
U0NBLzB4ZmYpLzB4ZmYgKyBzcmMuYSB4IFNDQS8weGZmOw0KPiANCj4gYWxwaGEgb2YgcHJlLW11
bHRpcGxpZWQgbW9kZSBpczoNCj4gZHN0LmEgPSByb3VuZCgge3tkc3QuYSB4IFsweGZmIC0gcm91
bmQoKHNyYy5hIHggU0NBKS8weGZmKV19IC8gMHhmZn0gKw0KPiByb3VuZCgoc3JjLmEgeCBTQ0Ep
LzB4ZmYpICk7DQo+IA0KPiAqIFNDQSBpcyBjb25zdGFudCBhbHBoYQ0KPiANCj4gSWYgU0NBID0g
MHhmZiwgdGhlbiB0aGUgZm9ybXVsYSB3aWxsIGJlOg0KPiBkc3QuYSA9IGRzdC5hIHggKDB4ZmYg
LSBzcmMuYSkgKyBzcmMuYQ0KPiANCj4gSWYgZHN0LmEgaXMgMCwgdGhlbiBkc3QuYSB3aWxsIGJl
IHNyYy5hDQo+IElmIGRzdC5hIGlzIDB4ZmYsIHRoZW4gZHN0LmEgd2lsbCBiZSAweGZmDQoNCkkn
bSBjb25mdXNlZCB0aGF0IGRzdC5hIGV4aXN0IGluIGJvdGggc2lkZSBvZiAnPScuIExldCBtZSBu
YW1lIHRoZW0gYXMgZHN0LmEubmV3IGFuZCBkc3QuYS5vbGQuDQpTbyBjYWxjdWxhdGUgZHN0LmEu
bmV3IGZpcnN0LCB0aGVuIGNhbGN1bGF0ZSBkc3QuUkdCIGFjY29yZGluZyB0byBkc3QuYS5uZXcg
bm90IGRzdC5hLm9sZD8NCg0KSWYgc28sIGRzdC5hLm5ldyBpcyBpbmZsdWVuY2VkIGJ5IFNDQSBl
aXRoZXIgaW4gY292ZXJhZ2UgbW9kZSBhbmQgcHJlbXVsdGlwbGllZCBtb2RlLg0KVGhpcyBpcyB0
byBmaXggdGhlIGJ1ZyBhbHJlYWR5IGV4aXN0IGluIGNvdmVyYWdlIG1vZGUuDQoNClJlZ2FyZHMs
DQpDSw0KDQo+IA0KPiANCj4gUmVnYXJkcywNCj4gSmFzb24tSkggTGluDQo+IA0KPiA+IFJlZ2Fy
ZHMsDQo+ID4gQ0sNCj4gPiANCj4gPiA+ICANCj4gPiA+ICAJbXRrX2RkcF93cml0ZShjbWRxX3Br
dCwgMHgxLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiA+ID4gRElTUF9SRUdfT1ZMX1JT
VCk7DQo+ID4gPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDB4MCwgJm92bC0+Y21kcV9yZWcs
IG92bC0+cmVncywNCj4gPiA+IERJU1BfUkVHX09WTF9SU1QpOw0KPiA+ID4gQEAgLTM3NCw3ICsz
OTEsOCBAQCB2b2lkIG10a19vdmxfbGF5ZXJfb2ZmKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4gPiA+
IHVuc2lnbmVkIGludCBpZHgsDQo+ID4gPiAgCQkgICAgICBESVNQX1JFR19PVkxfUkRNQV9DVFJM
KGlkeCkpOw0KPiA+ID4gIH0NCj4gPiA+ICANCj4gPiA+IC1zdGF0aWMgdW5zaWduZWQgaW50IG92
bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+ID4gPiB1bnNpZ25lZCBp
bnQgZm10KQ0KPiA+ID4gK3N0YXRpYyB1bnNpZ25lZCBpbnQgb3ZsX2ZtdF9jb252ZXJ0KHN0cnVj
dCBtdGtfZGlzcF9vdmwgKm92bCwNCj4gPiA+IHVuc2lnbmVkIGludCBmbXQsDQo+ID4gPiArCQkJ
CSAgICB1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSkNCj4gPiA+ICB7DQo+ID4gPiAgCS8qIFRoZSBy
ZXR1cm4gdmFsdWUgaW4gc3dpdGNoICJNRU1fTU9ERV9JTlBVVF9GT1JNQVRfWFhYIg0KPiA+ID4g
IAkgKiBpcyBkZWZpbmVkIGluIG1lZGlhdGVrIEhXIGRhdGEgc2hlZXQuDQo+ID4gPiBAQCAtMzk1
LDIyICs0MTMsMzAgQEAgc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQoc3RydWN0
DQo+ID4gPiBtdGtfZGlzcF9vdmwgKm92bCwgdW5zaWduZWQgaW50IGZtdCkNCj4gPiA+ICAJY2Fz
ZSBEUk1fRk9STUFUX1JHQkE4ODg4Og0KPiA+ID4gIAljYXNlIERSTV9GT1JNQVRfUkdCWDEwMTAx
MDI6DQo+ID4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JBMTAxMDEwMjoNCj4gPiA+IC0JCXJldHVy
biBPVkxfQ09OX0NMUkZNVF9SR0JBODg4ODsNCj4gPiA+ICsJCXJldHVybiBibGVuZF9tb2RlID09
IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFID8NCj4gPiA+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZN
VF9SR0JBODg4OCA6DQo+ID4gPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfUFJHQkE4ODg4Ow0K
PiA+ID4gIAljYXNlIERSTV9GT1JNQVRfQkdSWDg4ODg6DQo+ID4gPiAgCWNhc2UgRFJNX0ZPUk1B
VF9CR1JBODg4ODoNCj4gPiA+ICAJY2FzZSBEUk1fRk9STUFUX0JHUlgxMDEwMTAyOg0KPiA+ID4g
IAljYXNlIERSTV9GT1JNQVRfQkdSQTEwMTAxMDI6DQo+ID4gPiAtCQlyZXR1cm4gT1ZMX0NPTl9D
TFJGTVRfQkdSQTg4ODg7DQo+ID4gPiArCQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9C
TEVORF9DT1ZFUkFHRSA/DQo+ID4gPiArCQkgICAgICAgT1ZMX0NPTl9DTFJGTVRfQkdSQTg4ODgg
Og0KPiA+ID4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BCR1JBODg4ODsNCj4gPiA+ICAJY2Fz
ZSBEUk1fRk9STUFUX1hSR0I4ODg4Og0KPiA+ID4gIAljYXNlIERSTV9GT1JNQVRfQVJHQjg4ODg6
DQo+ID4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMDoNCj4gPiA+ICAJY2FzZSBEUk1f
Rk9STUFUX0FSR0IyMTAxMDEwOg0KPiA+ID4gLQkJcmV0dXJuIE9WTF9DT05fQ0xSRk1UX0FSR0I4
ODg4Ow0KPiA+ID4gKwkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJB
R0UgPw0KPiA+ID4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IDoNCj4gPiA+ICsJ
CSAgICAgICBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODg7DQo+ID4gPiAgCWNhc2UgRFJNX0ZPUk1B
VF9YQkdSODg4ODoNCj4gPiA+ICAJY2FzZSBEUk1fRk9STUFUX0FCR1I4ODg4Og0KPiA+ID4gIAlj
YXNlIERSTV9GT1JNQVRfWEJHUjIxMDEwMTA6DQo+ID4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9BQkdS
MjEwMTAxMDoNCj4gPiA+IC0JCXJldHVybiBPVkxfQ09OX0NMUkZNVF9BQkdSODg4ODsNCj4gPiA+
ICsJCXJldHVybiBibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFID8NCj4gPiA+
ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9BQkdSODg4OCA6DQo+ID4gPiArCQkgICAgICAgT1ZM
X0NPTl9DTFJGTVRfUEFCR1I4ODg4Ow0KPiA+ID4gIAljYXNlIERSTV9GT1JNQVRfVVlWWToNCj4g
PiA+ICAJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9VWVZZIHwgT1ZMX0NPTl9NVFhfWVVWX1RPX1JH
QjsNCj4gPiA+ICAJY2FzZSBEUk1fRk9STUFUX1lVWVY6DQo+ID4gPiBAQCAtNDUwLDcgKzQ3Niw3
IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+ID4g
dW5zaWduZWQgaW50IGlkeCwNCj4gPiA+ICAJCXJldHVybjsNCj4gPiA+ICAJfQ0KPiA+ID4gIA0K
PiA+ID4gLQljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0KPiA+ID4gKwljb24gPSBv
dmxfZm10X2NvbnZlcnQob3ZsLCBmbXQsIGJsZW5kX21vZGUpOw0KPiA+ID4gIAlpZiAoc3RhdGUt
PmJhc2UuZmIpIHsNCj4gPiA+ICAJCWNvbiB8PSBPVkxfQ09OX0FFTjsNCj4gPiA+ICAJCWNvbiB8
PSBzdGF0ZS0+YmFzZS5hbHBoYSAmIE9WTF9DT05fQUxQSEE7DQo=

