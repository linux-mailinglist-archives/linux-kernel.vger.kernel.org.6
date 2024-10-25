Return-Path: <linux-kernel+bounces-381377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD59AFE43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C7A1C22144
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE61D4350;
	Fri, 25 Oct 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p0Gsw85m";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PamW3+J2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45741D27A4;
	Fri, 25 Oct 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848829; cv=fail; b=W4/18fMpSwTlLCUaeCyBJ2e1LgiZc9T1t0AJT7zBsKlOZxcRxaqioAVk0Gei9J5d+PwkBBuwpGNwqhhDUWXWeniwjy1/8ObhuLfX1QtBjYDfwz1km0y/BqiMyxvoMQZYpv4Pghe2VoMXS0Oh3au5YthnAF0gT/jZZTLnuE91in4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848829; c=relaxed/simple;
	bh=nzLyxc7erUBoZEarIMZxYS7ECoRAkV3G0f54old15Qk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=laNqblrFguEIlrLhDr5uN2LHnoNtxIw22CsNKYKbt3a6gfn3dN+EJ6qfAUzxG7oK77wtbnSm+Iqu7tRHAY/hTw6+Xi2WWXio2fTbhChWLiZZPBI0Pi0ZUHwLrSPrdbX2JEVuYK+J4j/9SMdu3j2VR83q4qVZFH034y0yqX2GSYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=p0Gsw85m; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=PamW3+J2; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 36ef7c2a92b411efb88477ffae1fc7a5-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=nzLyxc7erUBoZEarIMZxYS7ECoRAkV3G0f54old15Qk=;
	b=p0Gsw85mAcTOeuSfZqVXZoMXlKpb7JwGZOAbOHhnlPpCO2fQuFXPVXNjx1sUDDeWy69pZr3MUbCyE9MFaeVpYtGA79LpxbkgIgVBdpU5K7r4rN5yTXU++sPbN/ryhKkF+C13QCOyfMnm/zek8q3A+y4jrmgzFr2Uqr0kbOuhISs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:30b8de89-1a93-4e86-9ef4-c1c5ba73bd9a,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:b0fcdc3,CLOUDID:5953dbcc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 36ef7c2a92b411efb88477ffae1fc7a5-20241025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1383087884; Fri, 25 Oct 2024 17:33:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 17:33:36 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 17:33:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIIfjnYsIDFClKbHUZ5doFEmFt7j7Rt1Akwp780yn58ru3bc4upICxRy4LKENSnUFCeUf4CttOlxlaYBMaV/mFh+53LlLocd6jHxl/Q7NIxHtBjxCJn1C7xEbLx372vvVmPc/1e42PO0tFd7IHsvVGi6vl2XXy1G7wkTfLDSk3bM+gAGHNfD541dHg28+MpG7iyvQBgmMOb6sBMVaAE5x0r/XD1YVLYyol+aI3VwViemYVBxAiJAS5GH8jKfoQa5WgNcPaLM4WkwIMrbaxOEpvSqJe8nAPLalQOm2nUwiVUQrH/1o8JshziXo0Smc0BpLk5z5Q5zaix2WS1kH+fUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzLyxc7erUBoZEarIMZxYS7ECoRAkV3G0f54old15Qk=;
 b=aURbVZPMlQ6665ICG6tGsDi0gjyLXa9BkZfYJhAVQzqbEQcPdMeD/ex7FFmKDE9vxWSRc2/FH88uf/2F3v+urgXJZhuUQJIieN4bmMGjkzDQxLmUgu0EowBNX8OIvrJRwFrcSaaNE1HF4ZrHwMp6kcjG7PTD+FLr+BEDVCFIwUt6FReqKIU9xakFtF9HnM6QlXgafVqerRyqoerKayua+B2g7sGXVrxcZZQ84pLs16KQLiB3rgxfZ8PB8OvVlHtY8r4wIpVPLFKWABz+VWJA/5fwSeisxvtQWb0jpnOHJBQqKveuhWstS99SHRJdjYOJ3PWNlQXoMgwt28ODf2lDhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzLyxc7erUBoZEarIMZxYS7ECoRAkV3G0f54old15Qk=;
 b=PamW3+J2V0MsZkVCrKuj3401BCnqhhRif7ke4Ox6oTuIekvqsuXM3Sq9H48nnpPF4SIAgfrpQGYiNTaNAcTSGZYdcbBAh6VKgkxBued0VixC+Tw8izLMusyubKA9KVhePZo2QkcRbnCC2VwefNGF5S5PA2u5I0HtsbJL2RFJoF0=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by KL1PR03MB8217.apcprd03.prod.outlook.com (2603:1096:820:10b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 09:33:32 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:33:32 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "krzk@kernel.org" <krzk@kernel.org>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/4] memory: mtk-smi: mt8188: Add SMI clamp function
Thread-Topic: [PATCH 3/4] memory: mtk-smi: mt8188: Add SMI clamp function
Thread-Index: AQHa86RVJj9SPFvyWUOGEGKoNBEA6rIxafsAgGQXEQCAAK8OAIABapuA
Date: Fri, 25 Oct 2024 09:33:32 +0000
Message-ID: <72c8d4b0bfdce89328ee1c99363441f1a3bbf5b2.camel@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
	 <20240821082845.11792-4-friday.yang@mediatek.com>
	 <25b487b7-63e0-402d-a0a2-ed9d03e82630@kernel.org>
	 <cdbac20d7a49ff2fbd3e6d4f24ae441ffbe87f05.camel@mediatek.com>
	 <566e4de8-b8bb-466c-83c4-217dad8ace63@collabora.com>
In-Reply-To: <566e4de8-b8bb-466c-83c4-217dad8ace63@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|KL1PR03MB8217:EE_
x-ms-office365-filtering-correlation-id: 8434b2a9-1099-4377-5751-08dcf4d817a3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MWpxdTFxWTNSajNUMFkvL2ZQc21XMll0dWFlNVFXMjErMXpJZ2lJcVJEK0dS?=
 =?utf-8?B?azRTeUNuMFVnd1VzUi9oUXlOdmF6cGVoVGJremJPSjBoaDRLMWpuMGJFLzVz?=
 =?utf-8?B?ZVZHcGN2OGNmMDNkbkcyWkpTVTU3Q0s1bHI4NStJOEFMc0JlVDA1YkJTWmFD?=
 =?utf-8?B?SUJsUGprMEYwVlNmeUIwYXBYNjdEVE5sOEg2SnNGK1VpdEtGbE0zNm54cmFZ?=
 =?utf-8?B?TFFaREx4eEJweVI0N2x6WW1aRWFjay9nUHNYM2huMmNLWjdPK0hrQ3ZDenZu?=
 =?utf-8?B?VExkUVJXbW5aSTFFcUFka1dZYXdsbkN4TXY1b1g4YUIvWU9zU1U4aitFUjBq?=
 =?utf-8?B?NVpSSEhIR3pGbjZxR3VDVFppM1cvdUdpb2d6QWMwSnBNdXlsa3JUTnErcFNG?=
 =?utf-8?B?cXN6UloyYzE3R3dBNUdzWDRtb29MMlBwZFdLUVV3TWhXL0VISk9maHdBdUdW?=
 =?utf-8?B?MDlHVTdkc2RSREs5UFJlTUE4a1RNVEY1L2JSWVN3MXVYQWJmUWFoTng3Z2NU?=
 =?utf-8?B?TlprS0RZeXdmb1NnUkRDSVNFRGxTR3FTU2Y3QlBuWEt5WG1GVE9odHlxV0Zn?=
 =?utf-8?B?UGJobWV1dC9WUUdjSWpaZXZVYXRQLzlpdXlCNDhKZmEzTWswOUUxZ2JnbUNX?=
 =?utf-8?B?QURaMkQxbXZxeWRIelhmamJFK1R2MmNJS095cGNtUXFXL0NDdGc1SWtkOHpB?=
 =?utf-8?B?NEc4c3lZS250QW5Hb3NNdWVXUDg3eTA5dGg0bUMxdmgra080bGU2TjlReFBR?=
 =?utf-8?B?NlVUSEdWR3ltVzQ1alNzWmN1NW9ZQldjNjlKTnBhcFhjM2Y3QnRMYjdES0dF?=
 =?utf-8?B?VGFuZ1NvZGJiMFFXbzU2MWRYaDZTSGNwNHBwWXJsT0k1UE5QTmlpZDdKbldB?=
 =?utf-8?B?ZmhvVkpNVzFaWEJ2djF0QWhpZkJUaDFJODcvdW53SFhWK0hWdUlmUXk4RW0v?=
 =?utf-8?B?M3hSV2dRNjNzQThhS2NUVWM4RDBVWG92L25mT2VMZHNWYkNiSG5vSk9EQkZh?=
 =?utf-8?B?NENucjR6MWFRczVaRWVrK2FGWDRXR01ROWdZclpkSmV3eUw3alZFSDhLTjF3?=
 =?utf-8?B?TGV2TnlacFV0Vm1EeWhYUHhxTU1XcGRUdnprWnEvYnRjaSt1emtScVpqWGVY?=
 =?utf-8?B?V0FPWERJdzVEdkJwQWlqVFZNZW1VTkptY0FoU2lKT3prTi90R05nM2JydG4z?=
 =?utf-8?B?akVyRTc3NDcwQ1RUVW1qQUhrdUdhS3Y5RnlWOWR1MGFkS0xnTnVLV3NJRURM?=
 =?utf-8?B?Z3Q5UDBNR1AzNjE1SUU3UTc2c3VxLzhWMTFxeXZGNVFBMHN3M1pteERGeTNX?=
 =?utf-8?B?Rm1uVVJ2MnMvZWxFZWNaR1l5MFdTeTlzblBDZ3p5ZjNoeWVjbUMvZlNjeFJn?=
 =?utf-8?B?REt5U2xRTXYvUy9WVFNZcFJCWCtJNVA1OUVNUDJUQlJNK1hRNzMrNjRpbmRa?=
 =?utf-8?B?QnVpcFk0S0ZZMDJmMjBreXVCSGxOaU1taC9LZkNBVVZCTXVTZ3pScmJJTVU5?=
 =?utf-8?B?LzhLdVp6NWwxNW4zR2lSWnh4QUF6a0pSNkc3b1RETForZGJ3UlFMN0JsU0gz?=
 =?utf-8?B?b0p1MmVmaitXSjdGLzAySXF4UEZ4VFdGZ2RyQzBDZFJnNjJXNm5RdWJBdEpp?=
 =?utf-8?B?SjZEYkp6V2pucmU4Z1hXYUxlYTVhM2dDTlBwUzN1cG83NmkwWXRRb25VRXBn?=
 =?utf-8?B?dm8xbk5hSDExZHBVTXlqVWY3UDZMQ2lhV05xYSswWk1tTkRXQlNzUTlVN2lR?=
 =?utf-8?B?TXFBMVovSDNYdkQyRGFaeFY2YlN4LzZBbG1wUXhkRzU3YUZHd3ZjL0VuSFpQ?=
 =?utf-8?Q?RbG5AxtEksq5bNaATQC0TlJ6eDpgKerIbObGs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHNMazZRUG5Jc2JDTmlDRHRiOW1tSnVQc3l2K0ZSczN1WWgyblZ5WWV4RkdI?=
 =?utf-8?B?TnRocE9pUmlLNXlIZk9ycUJ3RDYrekdkbnk0YkUybUNVeS85cFVvNEF5cTdI?=
 =?utf-8?B?bEo0M1hxL1JsWVZ3akxueDFCMkpQNThBQ3JpaDhEcWpudmFXZmtZWi93ZGpJ?=
 =?utf-8?B?WmRGdDMxQU5qUFg1dy8xY0tGYlp2UE5yWWdTQ3o4VENsTFIrYmt4NDM4NE9M?=
 =?utf-8?B?TUJUK3VUeDI0MS9uRkxVTnBYRTlxMFh6RjFkRHVBbjlqaWE5Z01LMXNxdFps?=
 =?utf-8?B?SEtqTUhRbHJZT29ZQ1J0dDZENFRQbzYvcUFSOTZyVEE5RnVhSEVHcFBhcXVE?=
 =?utf-8?B?dEhMT294QytzeldITW9wV0pUdkE1UUNDTVVEWTZkNUxuVXZlQXVRRTFVaGYv?=
 =?utf-8?B?Uk5PUEtKa0kwL1FOUDl5anpTNGhvTm8xYzhUNjNBTm1TbXZGL09uNXkzVEMz?=
 =?utf-8?B?Y1ZaS3U3N1RTSDZQVnkxUWVnUmIrd1NhMnVUSzJabzVCbVR0c1Z5MzF6dGNo?=
 =?utf-8?B?SU5XR0lhb1hkZldic1BjUXUvQ1c5UUhrT2o0N1VnQTZ0elZzVEloTW5HM1NQ?=
 =?utf-8?B?MjRUaWJFbXJYRzdxYjRTOWhOWlRWOTJUSHF6MjZmQ1NnOXc5d3U2Z3hQYWow?=
 =?utf-8?B?VEdzNktNZU1keWQzTkQzSFBYSzdlWGY0YVdyOE1WOUpTSWpGblI2eXh5UEl6?=
 =?utf-8?B?dnFtWlhBNUxFNXNvMnNWS1UyRDR6ZmhBaTk4M2tPa2xPdEFqZ2sxa1NPMjBK?=
 =?utf-8?B?Y2N5dEdibkloWTh6WWMrSmFVZFJMUFZFckVkcDc3QVlaaXNFamdGQVZjMktU?=
 =?utf-8?B?REhZRmdKYTRhSUNsaUw2bmxKbC9DT21iTUwyT3pzOFpiVm81dWNrVEVtbnZs?=
 =?utf-8?B?WmY3MDE3alhhL2Q4cDlxWnQzVEVVclpXZE9weGZha3laazZ5aCtVVDNMODNs?=
 =?utf-8?B?R3dobUxxWk9wWlhDL2M0Q0NpQi9tOFg2TXFyY1BtWE5KYjZJUWV2MkdsYzI0?=
 =?utf-8?B?S3hjTHVkWHljUFdBRDFtNVVQeDdzRkF1S1NPNG53eWxMTEs1OGdPQXdrdHRN?=
 =?utf-8?B?cHpueHhNVjdhVTFIeFdLRXBsOXQ0bkpCRDhBNXRxZ01TaHJySHBJZVorTi93?=
 =?utf-8?B?dUNnOURPdUREbHkrdXJuNmRWRHF1NWRjS1dVOVJMZnc4Y0Zvbzgrc1J0Nzhj?=
 =?utf-8?B?TnBiZ0MwTUR4TjFvNGk0Y2VFVWV0cFJkdmlicHdBQkZrRXB5a1A0bmlwa2xy?=
 =?utf-8?B?S244a3hXZkxHa2NUVDJ1c2FnR09RVzc1ejhYcDIyS2grZ0h5a0czUFJHeXNv?=
 =?utf-8?B?UldLZ1EwaGpWL2xiN05oUWpwTGZuU2tlR3NMVDBiaHBJRlBVSUt1VEFTWGhB?=
 =?utf-8?B?dUxwSXZXb1cyNUhnMUlvWkgwZ0dwVXc0dUZJMVorS1MvZUxBTmtuL3VvenN3?=
 =?utf-8?B?eDhmRWZVaEpMcE1uYVRFQUU5dElBOHJVMDlnTXVqTlh3dThPalpLN2pDNDNH?=
 =?utf-8?B?OWF4NmpiQkN5dzJIdUNsMm12QmMzWjlvZUZnbU84MGUzUThQOTlWMWlxK0k2?=
 =?utf-8?B?VHVCN1hpM1pvc1FSa2UwWEpzVFpCU0dnd29YMk9IbEhaR3V5YjhmWE5CL1E1?=
 =?utf-8?B?ZWZWUDFDRW5WUXV0bG1OZVVpeW9aa1RyQTFRWWE2T0xjVEtNR1VmVzR2anJi?=
 =?utf-8?B?dlI3YzlQUG5La3hqdGxPbDdQZ2tGanNjdDcrYm1OVE5QTjRtTFBtKzZkQVhp?=
 =?utf-8?B?bjg2VmxraklXMUlzZ0hYN2FIeFRvWHVCK3p3Y09JVVdkSnZRazdDcS9yMncr?=
 =?utf-8?B?WUJGdFo4K3JmN3RHQXFyTE5JSm40aEx6TE1XSGUyNzFrWEY1VU81U2Z4cExS?=
 =?utf-8?B?Y29nWllsVmJxTUU4cVdpMnBWWGRFQjhQVVVadUdIVG01REYvMk9UVjg1Wlll?=
 =?utf-8?B?MkVEVDVOa3N1TEdUaER2bXZLUUJGSFFXekpwVmt4UTl1S0tsb09nNGk4bmRG?=
 =?utf-8?B?SzVjbXBFS3V5Z2JNUWtoSHhEeURWaFR6Qm1wSTVmZ2F6NGhvVHg2VDRyOTdG?=
 =?utf-8?B?ZVVycWFlWjdFWjMxWXM3TFFwUEJ3V0MyT0VGWHRFZjNjOHFrUThPcXVUNU1G?=
 =?utf-8?B?cE1BY2RSdk1uN1ptUm54WG9RejFYUzBpNWdLZDNzaTFmenIvdU8xeFpyd3hz?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A23449543BECAB419DBF9EF2C1A9E333@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8434b2a9-1099-4377-5751-08dcf4d817a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 09:33:32.6101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOWiAitodeHehrDJJhgDYqjj/69dO5jyXhzs+Oi07uSLJk0Mr7ua1+0bsHdAb38SevdCXIfVt6y+BFbGNCZX0k6Gb1OIv1Myw5IzmfuJ6mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8217
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.282600-8.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGgNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDznde+1
	giXGd3Eefdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CxaeGF3HGG+AIKwF4K/wIz9dE7
	ABQfxM9cXIsYpyY5FcAG2ORx9EyapIaVPgU+koVEVglQa/gMvfFAI6wCVrE3vRi9INZ1ZpGFvej
	7JBlVmXWH0zriTV1i7vDnGPWiblRRVwN06hip8qlVN8laWo90MNACnndLvXweNTnqOMBIJ4cvDQ
	qEdbf1NldfHsj3+ZpRG77nj4gxZpCWvhQBtQUwTbBu6+EIezdxwG8b5skjkoMUmcSma304T+xjx
	s2OXeAZEjuFxhpbJiyvCnIHAg2cw2rvYheZgBXueAiCmPx4NwMFrpUbb72MU1kTfEkyaZdz6C0e
	Ps7A07YFInLyeDAoZB827tBOYc3J07cI4GIXjvqJMNtQWMTca/rYmEuzdQdrJNpPjNk/eQw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.282600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DCA1EC0BDC816948CB642E414276C3A130597103F6616931EAB3A3313D1D7F542000:8

T24gVGh1LCAyMDI0LTEwLTI0IGF0IDEzOjU2ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjQvMTAvMjQgMDM6MjksIEZyaWRheSBZYW5nICjmnajpmLMpIGhh
IHNjcml0dG86DQo+ID4gT24gV2VkLCAyMDI0LTA4LTIxIGF0IDExOjAwICswMjAwLCBLcnp5c3p0
b2YgS296bG93c2tpIHdyb3RlOg0KPiA+ID4gICAJDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwN
Cj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4g
PiAgIE9uIDIxLzA4LzIwMjQgMTA6MjYsIGZyaWRheS55YW5nIHdyb3RlOg0KPiA+ID4gPiBJbiBv
cmRlciB0byBhdm9pZCBoYW5kbGluZyBnbGl0Y2ggc2lnbmFsIHdoZW4gTVRDTU9TIG9uL29mZiwN
Cj4gPiA+ID4gU01JDQo+ID4gPiANCj4gPiA+IG5lZWQNCj4gPiA+ID4gY2xhbXAgYW5kIHJlc2V0
IG9wZXJhdGlvbi4gUGFyc2UgcG93ZXIgcmVzZXQgc2V0dGluZ3MgZm9yIExBUkJzDQo+ID4gPiAN
Cj4gPiA+IHdoaWNoDQo+ID4gPiA+IG5lZWQgdG8gcmVzZXQuIFJlZ2lzdGVyIGdlbnBkIGNhbGxi
YWNrIGZvciBTTUkgTEFSQnMgYW5kIGFwcGx5DQo+ID4gPiANCj4gPiA+IHJlc2V0DQo+ID4gPiA+
IG9wZXJhdGlvbnMgaW4gdGhlIGNhbGxiYWNrLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogZnJpZGF5LnlhbmcgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPiA+ICAgZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIHwgMTQ4DQo+ID4gPiANCj4gPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ID4gPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxNDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+ID4gDQo+
ID4gPiANCj4gPiA+IC4uLg0KPiA+ID4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyBpbnQg
bXRrX3NtaV9sYXJiX3BhcnNlX3Jlc2V0X2luZm8oc3RydWN0IG10a19zbWlfbGFyYg0KPiA+ID4g
DQo+ID4gPiAqbGFyYikNCj4gPiA+ID4gK3sNCj4gPiA+ID4gK3N0cnVjdCBkZXZpY2Vfbm9kZSAq
cmVzZXRfbm9kZTsNCj4gPiA+ID4gK3N0cnVjdCBkZXZpY2UgKmRldiA9IGxhcmItPmRldjsNCj4g
PiA+ID4gK2ludCByZXQ7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKy8qIG9ubHkgbGFyYiB3aXRoICJy
ZXNldHMiIG5lZWQgdG8gZ2V0IHJlc2V0IHNldHRpbmcgKi8NCj4gPiA+ID4gK3Jlc2V0X25vZGUg
PSBvZl9wYXJzZV9waGFuZGxlKGRldi0+b2Zfbm9kZSwgInJlc2V0cyIsIDApOw0KPiA+ID4gDQo+
ID4gPiBOb3BlLCB5b3UgZG8gbm90IHBhcnNlIHJhc2V0cy4NCj4gPiANCj4gPiAxLklmIEkgbmVl
ZCB0byB1c2UgdGhlIExpbnV4IHJlc2V0IGNvbnRyb2wgZnJhbWV3b3JrLCAncmVzZXRzJyBpcw0K
PiA+IHRoZQ0KPiA+IHJlcXVpcmVkIHByb3BlcnR5Lg0KPiANCj4gTGVhdmUgdGhhdCB0byB0aGUg
cmVzZXQgQVBJLCBkb24ndCBtYW51YWxseSBwYXJzZSB0aGUgcmVzZXRzIHBoYW5kbGUNCj4gaGVy
ZSwNCj4gdGhhdCdzIHdoYXQgS3J6eXN6dG9mIHdhcyBtZWFuaW5nLg0KDQpPSywgSSB3aWxsIGp1
c3QgdXNlICdsYXJiLT5yc3RfY29uJyB0byBqdWRnZSB3aGV0aGVyIHRoaXMgbGFyYiBuZWVkDQpy
ZXNldCBvciBub3QsIG5vdCBwYXJzZSAncmVzZXRzJyBoZXJlLg0KDQo+IA0KPiA+IDIuJ3Jlc2V0
LW5hbWVzJyBnaXZlIHRoZSBsaXN0IG9mIHJlc2V0IHNpZ25hbCBuYW1lIHN0cmluZ3Mgc29ydGVk
DQo+ID4gaW4NCj4gPiB0aGUgc2FtZSBvcmRlciBhcyB0aGUgJ3Jlc2V0cycgcHJvcGVydHkuIFNN
SSBkcml2ZXIgd2lsbCB1c2UNCj4gPiAncmVzZXQtDQo+ID4gbmFtZXMnIHRvIG1hdGNoIHJlc2V0
IHNpZ25hbCBuYW1lcyB3aXRoIHJlc2V0IHNwZWNpZmllcnMuDQo+ID4gMy5Ob3QgYWxsIFNNSSBs
YXJicyBuZWVkIHRvIGFwcGx5IHJlc2V0IG9wZXJhdGlvbnMsIG9ubHkgU01JIGxhcmJzDQo+ID4g
d2hpY2ggbWF5IGhhdmUgYnVzIGdsaXRjaCBpc3N1ZXMgbmVlZCB0aGlzLiBKdXN0IHRvIGNvbmZp
cm0gaWYgdGhpcw0KPiA+IGxhcmIgc3VwcG9ydCByZXNldCBmdW5jdGlvbi4NCj4gPiANCj4gPiA+
IA0KPiA+ID4gPiAraWYgKCFyZXNldF9ub2RlKQ0KPiA+ID4gPiArcmV0dXJuIDA7DQo+ID4gPiA+
ICtvZl9ub2RlX3B1dChyZXNldF9ub2RlKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArbGFyYi0+cnN0
X2NvbiA9IGRldm1fcmVzZXRfY29udHJvbF9nZXQoZGV2LCAibGFyYl9yc3QiKTsNCj4gDQo+ICJs
YXJiIiBpcyBqdXN0IGZpbmUgYXMgYSBuYW1lOiBpdCdzIGNsZWFyIHRoYXQgdGhpcyBpcyBhIHJl
c2V0LCBhcw0KPiBpdCdzIHNwZWNpZmllZCBhcyBgcmVzZXQtbmFtZXMgPSAibmFtZSJgLg0KDQpU
aGFua3MsIEkgd2lsbCBmaXggaXQgdG8gJ2xhcmInLg0KDQo+IA0KPiA+ID4gDQo+ID4gPiBXaGVy
ZSBhcmUgdGhlIGJpbmRpbmdzPyBXaHkgZG8geW91IGFkZCB1bmRvY3VtZW50ZWQgcHJvcGVydGll
cz8NCj4gPiA+IEhvdw0KPiA+ID4gcG9zc2libGUgdGhpcyBwYXNzZXMgZHRic19jaGVjaz8/Pw0K
PiA+ID4gDQo+ID4gDQo+ID4gVGhpcyBpcyBub3QgdGhlIG5ldyBhZGRlZCBwcm9wZXJ0eSBpbiBT
TUkgbGFyYiBEVCBub2RlLg0KPiA+IEl0IGlzIHRoZSByZXNldCBzaWduYWwgbmFtZSB3aGljaCBp
cyBpbmNsdWVkIGluICdyZXNldC1uYW1lcycuDQo+ID4gSnVzdCBsaWtlIHRoaXM6DQo+ID4gDQo+
ID4gcmVzZXRzID0gPCZpbWdzeXMxX2RpcF9ucl9yc3QgTVQ4MTg4X1NJTV9SU1RfTEFSQjE1PjsN
Cj4gPiByZXNldC1uYW1lID0gJ2xhcmJfcnN0JzsNCj4gPiANCj4gPiBNYXliZSBJIGNhbiBhZGQg
dGhpcyBuYW1lIHRvIHRoZSAncmVzZXQtbmFtZScgcHJvcGVydHkgYmluZGluZw0KPiA+IGRlc2Ny
aXB0aW9uLCBsaWtlIHRoaXMsIGlzIHRoaXMgY2xlYXIgZm9yIHlvdT8NCj4gPiANCj4gPiByZXNl
dC1uYW1lOg0KPiANCj4gSXQncyAicmVzZXQtbmFtZXMiIGJ0dy4NCg0KWWVzLCB5b3UgYXJlIHJp
Z2h0Lg0KDQo+IA0KPiA+ICAgICAgY29uc3Q6IGxhcmJfcnN0DQo+ID4gICAgICBkZXNjcmlwdGlv
bjogdGhlIG5hbWUgb2YgcmVzZXQgc2lnbmFsLiBTTUkgZHJpdmVyIG5lZWQgdG8NCj4gPiBvYnRh
aW4gCQkNCj4gPiAgIHRoZSByZXNldCBjb250cm9sbGVyIGJhc2VkIG9uIHRoaXMuDQo+ID4gDQo+
ID4gPiANCj4gPiA+ID4gK2lmIChJU19FUlIobGFyYi0+cnN0X2NvbikpDQo+ID4gPiA+ICtyZXR1
cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIobGFyYi0+cnN0X2NvbiksDQo+ID4gPiA+ICsg
ICAgICJjYW5ub3QgZ2V0IGxhcmIgcmVzZXQgY29udHJvbGxlclxuIik7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gK2xhcmItPm5iLm5vdGlmaWVyX2NhbGwgPSBtdGtfc21pX2dlbnBkX2NhbGxiYWNrOw0K
PiA+ID4gPiArcmV0ID0gZGV2X3BtX2dlbnBkX2FkZF9ub3RpZmllcihkZXYsICZsYXJiLT5uYik7
DQo+ID4gPiA+ICtpZiAocmV0KSB7DQo+ID4gPiA+ICtkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBh
ZGQgZ2VucGQgY2FsbGJhY2sgJWRcbiIsIHJldCk7DQo+ID4gPiA+ICtyZXR1cm4gLUVJTlZBTDsN
Cj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiArcmV0dXJuIDA7DQo+ID4gPiA+ICt9DQo+
ID4gPiA+ICsNCj4gPiA+ID4gICBzdGF0aWMgaW50IG10a19zbWlfbGFyYl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiAgIHsNCj4gPiA+ID4gICBzdHJ1Y3QgbXRr
X3NtaV9sYXJiICpsYXJiOw0KPiA+ID4gPiBAQCAtNTM4LDYgKzY2Miw3IEBAIHN0YXRpYyBpbnQg
bXRrX3NtaV9sYXJiX3Byb2JlKHN0cnVjdA0KPiA+ID4gDQo+ID4gPiBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gPiA+ICAgaWYgKCFsYXJiKQ0KPiA+ID4gPiAgIHJldHVybiAtRU5PTUVNOw0K
PiA+ID4gPiAgIA0KPiA+ID4gPiArbGFyYi0+ZGV2ID0gZGV2Ow0KPiA+ID4gPiAgIGxhcmItPmxh
cmJfZ2VuID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ID4gPiA+ICAgbGFyYi0+
YmFzZSA9IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPiA+ID4g
ICBpZiAoSVNfRVJSKGxhcmItPmJhc2UpKQ0KPiA+ID4gPiBAQCAtNTU0LDE1ICs2NzksMjkgQEAg
c3RhdGljIGludCBtdGtfc21pX2xhcmJfcHJvYmUoc3RydWN0DQo+ID4gPiANCj4gPiA+IHBsYXRm
b3JtX2RldmljZSAqcGRldikNCj4gPiA+ID4gICBpZiAocmV0IDwgMCkNCj4gPiA+ID4gICByZXR1
cm4gcmV0Ow0KPiA+ID4gPiAgIA0KPiA+ID4gPiAtcG1fcnVudGltZV9lbmFibGUoZGV2KTsNCj4g
PiA+ID4gKy8qIGZpbmQgc3ViIGNvbW1vbiB0byBjbGFtcCBsYXJiIGZvciBJU1Agc29mdHdhcmUg
cmVzZXQgKi8NCj4gPiA+ID4gK3JldCA9IG10a19zbWlfbGFyYl9wYXJzZV9jbGFtcF9pbmZvKGxh
cmIpOw0KPiA+ID4gPiAraWYgKHJldCkgew0KPiA+ID4gPiArZGV2X2VycihkZXYsICJGYWlsZWQg
dG8gZ2V0IGNsYW1wIHNldHRpbmcgZm9yIGxhcmJcbiIpOw0KPiA+ID4gPiArZ290byBlcnJfcG1f
ZGlzYWJsZTsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiArcmV0ID0gbXRrX3NtaV9s
YXJiX3BhcnNlX3Jlc2V0X2luZm8obGFyYik7DQo+ID4gPiA+ICtpZiAocmV0KSB7DQo+ID4gPiA+
ICtkZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgcG93ZXIgc2V0dGluZyBmb3IgbGFyYlxuIik7
DQo+ID4gPiA+ICtnb3RvIGVycl9wbV9kaXNhYmxlOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+
ID4gPiA+ICAgcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbGFyYik7DQo+ID4gPiA+ICAgcmV0
ID0gY29tcG9uZW50X2FkZChkZXYsICZtdGtfc21pX2xhcmJfY29tcG9uZW50X29wcyk7DQo+ID4g
PiA+ICAgaWYgKHJldCkNCj4gPiA+ID4gICBnb3RvIGVycl9wbV9kaXNhYmxlOw0KPiA+ID4gPiAr
DQo+ID4gPiA+ICtwbV9ydW50aW1lX2VuYWJsZShkZXYpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAg
cmV0dXJuIDA7DQo+ID4gPiA+ICAgDQo+ID4gPiA+ICAgZXJyX3BtX2Rpc2FibGU6DQo+ID4gPiA+
IC1wbV9ydW50aW1lX2Rpc2FibGUoZGV2KTsNCj4gPiA+ID4gICBkZXZpY2VfbGlua19yZW1vdmUo
ZGV2LCBsYXJiLT5zbWlfY29tbW9uX2Rldik7DQo+ID4gPiANCj4gPiA+IExhYmVsIGFzbHMgcG0g
ZGlzYWJsZS4gV2hlcmUgaXMgdGhlIHBtIGRpc2FibGU/DQo+ID4gPiANCj4gPiANCj4gPiBUaGFu
a3MsIEkgd2lsbCBmaXggaXQgdG8gJ2Vycl9saW5rX3JlbW92ZScuDQo+ID4gDQo+IA0KPiAuLi5v
ciB5b3UgY2FuIGp1c3QgdXNlIGRldm1fcG1fcnVudGltZV9lbmFibGUoKSBpbnN0ZWFkLCBhbmQg
bm90DQo+IHdvcnJ5DQo+IGFib3V0IGRpc2FibGluZyBpdCBvbiB5b3VyIG93bi4NCj4gDQoNClRo
aXMgaXMgYSBnb29kIGNob2ljZSwgYnV0IGluIHRoaXMgc21pIGNsYW1wIHBhdGNoc2V0LCBJIHdp
bGwganVzdA0KbW9kaWZ5IHRoZSBsYWJlbCBhcyAnZXJyX2xpbmtfcmVtb3ZlJy4NCg0KPiBSZWdh
cmRzLA0KPiBBbmdlbG8NCg==

