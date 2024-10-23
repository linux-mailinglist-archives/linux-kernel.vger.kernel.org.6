Return-Path: <linux-kernel+bounces-377243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075719ABBDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 04:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73F6284D70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 02:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E563152F88;
	Wed, 23 Oct 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PWjXzWgy";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WF9ttm11"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B017F7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651843; cv=fail; b=o9obJD7KFnS+Gcu4g0e3INmg4sJKKlEAocXDxSdlmfq0twzDP/dPm4dg129wkcufduR7OJbevYavIYrJEoK0dNtA3n+qw3CUK/41/RTs2v8UtaDkpHsMPU6FeCDc0rjcQdlBXU0OU6y8DfW/hUj5cZ1RlUQJ8VRqfSHOSBpOO7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651843; c=relaxed/simple;
	bh=C0l4sQlwxW2Igmi8j+XjM+lPcqSno9gF14clJxQ80g8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aQ3J+unsEUr7d3Qo6WxhVcWFSo41YwvfWqTpwqevGp+gLtX35ikQnOGXxWqlpKnZtomC3HOVDEGXmYyGgLEC+WsSPB+GOlX1lVEWv/MxcOurm7tJByAtftd27AsTWosbSwUrPOpJ80JyrJVu/hX18k0gHEk22kzg0CeFd965wSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PWjXzWgy; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=WF9ttm11; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 927ed36490e911efbd192953cf12861f-20241023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C0l4sQlwxW2Igmi8j+XjM+lPcqSno9gF14clJxQ80g8=;
	b=PWjXzWgy3kqNNRUISks6iWztODGxhXtfoC1kyh9SZlbPdH1l3ifjXURu8CQ4IPtyNLV9U8FkLsrN3sJSFU154K2c5HSwmO8DE+BZA9YC2G1kL6kkVgufKqQ1q6aD9qhX4DjAAKwugntn58X/WxCqmYjjmGqDueNBF4RaJScCRjw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:7041b5ff-011a-481c-9c46-edb62bd48653,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:9730f62d-a7a0-4b06-8464-80be82133975,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 927ed36490e911efbd192953cf12861f-20241023
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 145929689; Wed, 23 Oct 2024 10:50:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 10:50:31 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 23 Oct 2024 10:50:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0c5ValcHz6kZWJ0ZqjSnZZAYJhpu/EgPhR01ztVknQK1+0Ro5uTuWK0WhKj4lZeM5EguEzdLL8tMiD2i/ARtJJA+ACgTVJCYC7w7WIVIuk4bwl6HVn8Sc5CPXqLRePS51yzZSgk5iRuAL/l4OPkfFIiF6OtxaNTRVNUj/GUta0xmEQ0ypBrzB+gM18/mxuS/ZCfergGcgYCs4vnBIvSmTFNycOcT7yI+h01V+/hZwR/z/onGyPoQG04UoVw2u6+tUD+hJlTCrWp6VZ0VUxaz8FP+RcMaA2GiM6pY5eUMYfjmqaH8GdbDjsr9CoPzlvmLF9g5IvSt+zEtJeKLegLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0l4sQlwxW2Igmi8j+XjM+lPcqSno9gF14clJxQ80g8=;
 b=cy3gGPslcgMnXvMI7dAnNyc1B105Emcmrkk1xOB4nPqVh63fLQPEdTAHaEBOrMTi7QHZfOUQmuw4JFyYahJ/nLBUYxZstzCjTZGC6gqm9h2T8i4iwiFUuBHV+MnPytSjfL1kCVe1ztQmoPo0QGrv3aIn7+ecshVjYVnqd309BnvnSOmsL79PCU+vdLyQlydKfq3+qh9P9XdHhbHtkimaLo5st0Sxr8TwVJR7HVTMt42hGxxj1dhrQM8VJI8Yomi00j9aB+0J8Og2iaG3VBjNVQ8wCBAo34N64/mgFj4kmjExx0SUGe738GXwcLaUD1xFJXHbsPWRJmh1FeFoli38yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0l4sQlwxW2Igmi8j+XjM+lPcqSno9gF14clJxQ80g8=;
 b=WF9ttm11zWSl4mjZQ3TU766E4j68j+/zTfzmH/33idT2MjjC7KnJlnBF7plZCAsHqzUaTOqN4MLaxOx51fXcvEp1o/h8OeaEuErTneIpvsNPRnaK/GGM+jyIzv5zpb5+cLVRcmiXSIhlfzcrMCGtaQQWvMbWQdlXiJKJGhdbpDQ=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6595.apcprd03.prod.outlook.com (2603:1096:101:77::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 02:50:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 02:50:29 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "javier.carrasco.cruz@gmail.com" <javier.carrasco.cruz@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Alexandre Mergnat <amergnat@baylibre.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] drm/mediatek: Switch to
 for_each_child_of_node_scoped()
Thread-Topic: [PATCH 2/2] drm/mediatek: Switch to
 for_each_child_of_node_scoped()
Thread-Index: AQHbHBL5atdcAYWc3k6xq8+k/nopfbKTtHwA
Date: Wed, 23 Oct 2024 02:50:28 +0000
Message-ID: <9bf479c8faa0b26f89e479c970841c814eca06f5.camel@mediatek.com>
References: <20241011-mtk_drm_drv_memleak-v1-0-2b40c74c8d75@gmail.com>
	 <20241011-mtk_drm_drv_memleak-v1-2-2b40c74c8d75@gmail.com>
In-Reply-To: <20241011-mtk_drm_drv_memleak-v1-2-2b40c74c8d75@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6595:EE_
x-ms-office365-filtering-correlation-id: 7c6fb3f9-aea9-4cef-3878-08dcf30d7438
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VWZCM2xjN1lCYlVsb2s1ZHZWNGVkam0wbjFvZVlrV2NuTU9oVEdpZGYyUDZ1?=
 =?utf-8?B?d21UY0MvbXZxNmU5eFpPbU8rUXZxNXQvRG0wa2VmSHBkelRuWWxmUHY5UUJ1?=
 =?utf-8?B?LzNnWkJGYTNsUE51eG1wRHFuWGQrVDBkWGhmeGJ1MzhSbGRFdlZGeDVkbjRH?=
 =?utf-8?B?K2JTdTJmQzNmMGVTMSt4L3lud3l6cDlsR3ZNVDJIM2pWTlZwTTlWR014WFVI?=
 =?utf-8?B?TDdNR2kyQlVnUk5leWxqd0h6dmlTbmhNcmFlTjQ1UXZFUnBNRGg1M1ZPUThm?=
 =?utf-8?B?cm02TU5CaHkycjV3Qi9TZEVBN0VuWDNobEdNWFdRZ1hSM2xqNWRWcjlwOHh1?=
 =?utf-8?B?alYyYmpqdHp5VGhjblMram81SlBEQkVBMHd0R0FjdnE1LzZrVjliTW1rbVRx?=
 =?utf-8?B?a0RmdEJBVk9CZzI4WjBIWVBQVi9MUktzVjlxNktOWFpqUldSZHZQWEg3d3dk?=
 =?utf-8?B?ZkJwTTJMNkQ2b0Jsbzl6SXJZbmIrTVRqVm8rUTlBcHFJMEJZWkNkakE1UzZq?=
 =?utf-8?B?akNlWWFOaVhuVnVISHhnQ0VlcjltSmVwL2xtNStnUk8yLzJYdUpZSm9ocERO?=
 =?utf-8?B?S2NqLzhSR2pTNnAxaUdsSkZNOWJUeGZySXB2UkJIYStncmVuZkVoTGJCOUlW?=
 =?utf-8?B?VUkzZnpQOE5RdnN1NGJ2YTNYOXBVejBmL2FybUZpV1NjSEZrYUVVQ1BVbFBY?=
 =?utf-8?B?MnZYc3YwcXFTZnF3QjNXQkJOZDZaeEpnQnpGdGhBMmdkdFBMRnc0N1Rld1l0?=
 =?utf-8?B?dFErSFhkaTVXdEtDdi9rMkhJVFJiL0psY3h1Rzl6RWM5VmZiN1Z3eFJGcG1F?=
 =?utf-8?B?clEwcTViOEpZWnp0VFFNZllpMTRwTjU5VGdGSWNSQXh6WCtsR1pHRFp5cyt1?=
 =?utf-8?B?NGhweFpkeWpCaGNXUURlaWZ3elRrdG5WUVNiMHFDaXRwOE0vZCtYZndMd3VN?=
 =?utf-8?B?TlE5QTE4Mm15aHA3Mk1QOGNQRzBWaVdHekh1UStNTWMzS1lnY2g2QzlDTnZt?=
 =?utf-8?B?ajdqUFhDV1VYbE5EZ0VOZ05vc0NYS0JTbms3U0xqUGdnRzFQazRZT01xYkJH?=
 =?utf-8?B?cW5oaGR2UkRQUlJocFlOVkwwQjNEcmw1RDFPcVdqV3FxOS9zY3FQZWFIa1hN?=
 =?utf-8?B?VnhpcGt6TFVabUdhdGU2b2YzZkd3emRsN3lkL3VBang2ZjU2bU4yTkxicE9a?=
 =?utf-8?B?ZU45enRickMwZzdGSGIzZ0VXdERVcVh1d3VBUXBSWWtyRnRFbVlLeEg5L3ZL?=
 =?utf-8?B?bDR4M0dLTXNQZS94ejVsa1FpR3Q4UmtSOGtKY3ZtRnAwTHd5ZHlHMDZJWHhm?=
 =?utf-8?B?b3p2c1h1aGlScTZZc0V1eEI4c1JxTVA2clh3R05waE5YSHlTcWxwRTlSOXVB?=
 =?utf-8?B?b0J0QWRqK1VMT2FVdjhuQkdlaEcyN1VpbXBaTEt1WDBRVktLdnAwVm5WS0l4?=
 =?utf-8?B?eDMzd1cvcDNHc0pON1Y4UDFJYllISEhLY0wzZnovSE93NS82eEtuQlRwbHhQ?=
 =?utf-8?B?YTEyNi9nTlZrcUZTdzRVbXFmZ0hpdjFnZ0pmdTJOK1c1L09sMEVCT2RVOXZj?=
 =?utf-8?B?TXFia1hDVllabXNsbCtJcGt0OWhoT2tvU2tjeWpHMWtTNGFYZTcwTEFuODBw?=
 =?utf-8?B?d2dsTkI1MXZkYnNmekg3OGcvc1dxUENPSjJha1ZhUGFSUlVXZU9RVHBORThO?=
 =?utf-8?B?Q1hwSWc1dEVNenNPV0VKd1BNSmQ2NU1vREhnQzhCdlRCT1A1bThxSUdzbVlk?=
 =?utf-8?B?bzdJMFJnVHI1MFArc1BkNG1ERlViemFVZUtpeXpHdG55aFoxWEtuMkpqR2J0?=
 =?utf-8?Q?FxkFtO8LW9ddK6LB684ybBJbRpHMooSFwDTfY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW8vUTZRZjRhbVJuL3lWS2pYQVZ3MkFSa1Y2MDRSaC9SSlhIWDJ4U3BPS1Vu?=
 =?utf-8?B?VUZKWWppM2xlKyt4M2dpanVoaE9tOUd1NlVDMUVXTnVRYmc2a29uMTlRUkVD?=
 =?utf-8?B?dlFrY0dUN3luNitUNjRUK0M0RVdJOXYzQ2k0TGxSejRQcU1TckRPMU5vcDQz?=
 =?utf-8?B?TW9tUG5tTnZCZE9tb29uY3YvOWlnWXdTNHpiRGQ1ODE2enBrZndxOVBTb0hB?=
 =?utf-8?B?WC83WkVlUGNaY0NKRTIxamFPSG1adkkveEJ1QkpJSGNTcGwrVWNycG1jUU9s?=
 =?utf-8?B?TXAyclVWNE04U05OQ1Mvc3dtWlVBT3BQRTVUb3B2bWNOUkpXVGJiWERvTkZy?=
 =?utf-8?B?UGw0dVhyclZBcDBkMmNlYkg3SnV6aHR1dlc0Q2lMYTFlUXIzeVRqWFBiSmow?=
 =?utf-8?B?M0R5akcvZTA1QzQ2UmlnNDhZZncrcHUvYXVSK2h2Q3hFVzBWSndUMm03Q2ll?=
 =?utf-8?B?SWxObTljM0RzaTJ2RWVlWWl2emFDN1NnRGpGcFRTOTFaQzFtUFkzY1BGYkJz?=
 =?utf-8?B?Sjc4OEVuOVBPLzJoUkUySjFGZjVhN1NNbXlsbE9nS3JlUmJGWWZjbS9kR2Mz?=
 =?utf-8?B?OXZHSnRXYlN5L3VtdEVqdUNPNUlBZFpxRzU4NlRiaGdEb3FKU25OeWZNdVBV?=
 =?utf-8?B?MkRHRlBrUitCUEhXcmtidnI0SWt3RVM3WGF3N3JoNFV6MW9ZenFkTE9HaDR2?=
 =?utf-8?B?L3RVSDVSRERpWWloRStSOXFaYUd3ZU5XSkJxQjBHY0w3a1Z4RElUemU4aWt0?=
 =?utf-8?B?RVRoNnFSRnpVeG9KQ3pENGVzUU8zUi9SaVlLK2h4S1VWb3kzTE81UkYrT0VV?=
 =?utf-8?B?ZCtvWUthdUh0UFZBUnV1R2tDZXdWUWczRDRYbkhZSXhOM1R1dHp2aDZ4Z0Yr?=
 =?utf-8?B?SnJJc0QzR1Z1MDVUWjhOcmVFWGZpb3Y1aktsYXFHSXVhUERiSlFoUm9lMkJZ?=
 =?utf-8?B?TmNuQ1FBT0ppTWtITXJEZkIrWWZNeU12U1RNbTFqaUZTMmZQQlNaZWFwdEhG?=
 =?utf-8?B?UU9UdE0wdDlLWTJLQ1BCZC9LWWhRODFIZzRPSUJyMmp2dW1FR2FiL2p1OW1E?=
 =?utf-8?B?VlNrQXBTaHFpQXJudUxRaFVYcXNBaUZrcE00U3VRY3prbE8vMXQzOGV2Q1B1?=
 =?utf-8?B?cy9yN2k5N2ZFQlc5M243MGdqWDV4b3poWTJENnNKKzRwSmVqaHh1eHFwWC9U?=
 =?utf-8?B?SDNkWVk2Z3Nva2NiV21RVUpyQnY0RVovOGpoVWNacjRnUDMyeGFObWpuRlZ4?=
 =?utf-8?B?Mk13akYwV2MrTjZWVDFhVVlTeDZ3bFBQUmhnU0QrK1NsbUhOT2xFK2Q2ei9M?=
 =?utf-8?B?RUNrUTV1WFFqalA5U1g5Yllob0VUWkRCTzY4VEhkd1lSbVF2UzJsSi9lVFl5?=
 =?utf-8?B?anN4cUJRRGRyMW8xb3dqYXQ3cWs2K3BWTmVHdUp3aGttZm9LcFh1aDM1dzFO?=
 =?utf-8?B?b0V3RXRWM1luRFhGWmRPYW1jckJvUGphcHNoL1FuOUFWMThnVlg5N3QybWZU?=
 =?utf-8?B?bTFnQklNMGJ5MTlNS2xUMjlrMDRMejFMOVQyMGJDOEFsQ2FoeVpjR2o3NVRa?=
 =?utf-8?B?c2FhN3E5Ni9tVlVjUU9TT014QktnK0hoRVVpVWZVNGcxNmtxVk9mWHB1MXVu?=
 =?utf-8?B?eEVKeWJYQWZvdlhlKzd6OEoxckxvTHZnZWdvNnhTZmJzcFNqenlLekdZM1A5?=
 =?utf-8?B?T0pXbEtFOEl0ZkpDUDNCeDJySytIdkQybWtKaE5CWDBoOHFiV2NnZnNuc2Fm?=
 =?utf-8?B?cThBeW9mVEJIM1MxOGphUEUyMkNaUXB5L09EVmhKWmNDVkg3VTNaZVllZEZv?=
 =?utf-8?B?djJ2VWl3bE1KMmpNbFFBQW9MK05GTTNYYVZmODdaYU9VTDkwS1BicndhaHlQ?=
 =?utf-8?B?NWRmY3kyVkdOTWxzdVlmbE9ybldwUVJSSVJJTTIxUU44NGZZYzd3THd2RWtZ?=
 =?utf-8?B?cGtQdW4vWm1ZblBYS2RURDJ3c0tYcjNjTGp6bHBKQ2NzWDc3bW5DNzZnc3Q0?=
 =?utf-8?B?YmRpRlU4Uk5KNEhBQnNpWnI3Tk51Z0F6b3VIblRsWFlNQUdZMDdxY3RYUHhk?=
 =?utf-8?B?Z1BHVEduQ2krNndXU0FqNHhybmd2S3U3eXV6aWJjcWUvVWFFbmJMcFdwVWZS?=
 =?utf-8?B?RnhxQUJXOXg1cG1PL0tvT21UNGV5b1F3RFVLR3psZzVKZnAzRTdGTFYydG1U?=
 =?utf-8?B?N1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <471710B0CCDECE488E2CF3C030D8E41F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6fb3f9-aea9-4cef-3878-08dcf30d7438
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 02:50:28.9325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bACzlXp7aO4Vsy4RwTQ6Tw8TgX3ml9QLvRP22oUP4FKoZDEF9t06LA4sWy2gX4NRYc3LuMpUIeSXFuYlGmE9Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6595

SGksIEphdmllcjoNCg0KT24gRnJpLCAyMDI0LTEwLTExIGF0IDIxOjIxICswMjAwLCBKYXZpZXIg
Q2FycmFzY28gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSW50cm9kdWNlIHRoZSBzY29wZWQgdmFyaWFu
dCBvZiB0aGUgbG9vcCB0byBhdXRvbWF0aWNhbGx5IHJlbGVhc2UgdGhlDQo+IGNoaWxkIG5vZGUg
d2hlbiBpdCBnb2VzIG91dCBvZiBzY29wZSwgd2hpY2ggaXMgbW9yZSByb2J1c3QgdGhhbiB0aGUN
Cj4gbm9uLXNjb3BlZCB2YXJpYW50LCBhbmQgYWNjb3VudHMgZm9yIG5ldyBlYXJseSBleGl0cyB0
aGF0IGNvdWxkIGJlIGFkZGVkDQo+IGluIHRoZSBmdXR1cmUuDQoNClJldmlld2VkLWJ5OiBDSyBI
dSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXZpZXIgQ2Fy
cmFzY28gPGphdmllci5jYXJyYXNjby5jcnV6QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDcgKystLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGluZGV4IDA4NzhkZjgzMjg1OS4uOWFiNjU2YjEw
YTQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYu
Yw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBAQCAt
MzcyLDEyICszNzIsMTEgQEAgc3RhdGljIGJvb2wgbXRrX2RybV9nZXRfYWxsX2RybV9wcml2KHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gIHN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnRlbXBfZHJtX3By
aXY7DQo+ICBzdHJ1Y3QgZGV2aWNlX25vZGUgKnBoYW5kbGUgPSBkZXYtPnBhcmVudC0+b2Zfbm9k
ZTsNCj4gIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm9mX2lkOw0KPiAtc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlOw0KPiAgc3RydWN0IGRldmljZSAqZHJtX2RldjsNCj4gIHVuc2lnbmVkIGlu
dCBjbnQgPSAwOw0KPiAgaW50IGksIGo7DQo+ICANCj4gLWZvcl9lYWNoX2NoaWxkX29mX25vZGUo
cGhhbmRsZS0+cGFyZW50LCBub2RlKSB7DQo+ICtmb3JfZWFjaF9jaGlsZF9vZl9ub2RlX3Njb3Bl
ZChwaGFuZGxlLT5wYXJlbnQsIG5vZGUpIHsNCj4gIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXY7DQo+ICANCj4gIG9mX2lkID0gb2ZfbWF0Y2hfbm9kZShtdGtfZHJtX29mX2lkcywgbm9kZSk7
DQo+IEBAIC00MDYsMTAgKzQwNSw4IEBAIHN0YXRpYyBib29sIG10a19kcm1fZ2V0X2FsbF9kcm1f
cHJpdihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICBpZiAodGVtcF9kcm1fcHJpdi0+bXRrX2RybV9i
b3VuZCkNCj4gIGNudCsrOw0KPiAgDQo+IC1pZiAoY250ID09IE1BWF9DUlRDKSB7DQo+IC1vZl9u
b2RlX3B1dChub2RlKTsNCj4gK2lmIChjbnQgPT0gTUFYX0NSVEMpDQo+ICBicmVhazsNCj4gLX0N
Cj4gIH0NCj4gIA0KPiAgaWYgKGRybV9wcml2LT5kYXRhLT5tbXN5c19kZXZfbnVtID09IGNudCkg
ew0KPiANCj4gLS0gDQo+IDIuNDMuMA0KPiANCg==

