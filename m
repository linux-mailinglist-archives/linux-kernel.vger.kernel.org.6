Return-Path: <linux-kernel+bounces-527860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31DAA41090
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB943B36CA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1311459F6;
	Sun, 23 Feb 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VMip7rax";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="qot/yl/T"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385E2F50
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740333002; cv=fail; b=WhEQ919YRrWhl5YP9y95ZzGdqg7tJwzEO3FT9jTtJY8lLb6hmXajJSrg4/UEDbq8d1GQz+qmcr1aRMD/1Adim00z5bg4CgO186qQ0SkEMEqUEY+GwcMAc7bWqnBj5Kzui56iWU0E4Svpkt7FI7tIad1ypeTGYMlEXleLQchiqQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740333002; c=relaxed/simple;
	bh=QLW8vbjxnwgRMfFPz4l3PYvXM6qU1u0vPK+gv59jqZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uNdBJvLTlP9X4Z222DqmQEOIMNtSFwn5EbKptp+/4p1VBnGfBc9ZSH1CJEqjLH0+6WZ2m1w+yIxIALY9LOHMmq8WCqWe/gXKm+29SndciD4DcR3BWDpIjChY9uDRR2wQXHX5cRUu6bkFh8HNInn2y0jI1lqku49fXcADYQI+Be0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VMip7rax; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=qot/yl/T; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 93d841f6f20e11ef8eb9c36241bbb6fb-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QLW8vbjxnwgRMfFPz4l3PYvXM6qU1u0vPK+gv59jqZw=;
	b=VMip7raxMDvF2sc6F92kztyJctSEFT61+iMUh3iqa5bX5Vo6mWtKxcBEI3ZyvlKAI4BB/SLjnfiUm1a5D2oGK7BXwItp9y/yvi9Jj1/wYiMZATCI+LDRvvlp7hIH3ho3qakPpipepDzI7WLaum+AW9gkac+BfIhKF6JkpeHQBNM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:c4ae6d30-d29d-4c1b-95a9-bf979a8fb4e8,IP:0,U
	RL:25,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:27
X-CID-META: VersionHash:60aa074,CLOUDID:909e3adc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 93d841f6f20e11ef8eb9c36241bbb6fb-20250224
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <sunny.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1610565766; Mon, 24 Feb 2025 01:49:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 01:49:48 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 01:49:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MpmmJJ8RZd3eRjd8BxxtA2lYoKmytk2Z52v5ImO6a4qWzdb6r36p8k4TuX79DrZR1g4BOQ7dQwo5g6XtnEOkExBWdm9QuwL4/S7A75X1Bu2MTf3lWFkbyhU9TvyZzM1Eo4YnomUEj9Bo0pRevzu9ELv3iv5Eqj3FfbSgXGSJXR1gXjiiHWOZ8Y4HR6f542PjQKC3A7/P+gAN1VSoxHrXQofnlhbh6CRCJigbAqbn2MJTgfxD0nPlMAYLfRM5lW52glMIhfTtJJ+Uz7mkxk9sndES9LS7UZ3QFka+2EG0QDfyTMGj89420oKGzB3erSRePk/40oIbYvVD8coPi2bXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLW8vbjxnwgRMfFPz4l3PYvXM6qU1u0vPK+gv59jqZw=;
 b=vMCfKwySKXdhZPm0c3LH6g2E8o85nNKHaJxr3fu71UIlG6N6orob7x50ypJPQCZ6LzOZI07qx3afQ7wTHk0gwtx+MBA7w0ehG+8/z6NBeojuxRGgUg7kIsOdox94Ju8xrZi6LX0Zo7EWLnBbZGp4zjusI2oQEFlopq/V5TZQWs7vr+h2b2lT1ZUDCDKYthFmYatF8jYGLVF+r3VU4ZOaYACfVaBwaM52JzJqA1/lVTGk2XUyVNQKWT3+fhBLmcPJfvluGxQDPM2Fm1vaX5EVXh8rPnKQsc5Sudodeo+0vj8/e7Iv6WRmphvu0xgTtvs3pOLgxkZbozv9N4az9Rp4dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLW8vbjxnwgRMfFPz4l3PYvXM6qU1u0vPK+gv59jqZw=;
 b=qot/yl/TglVNRdyHZcbScWSDdJMxIPFzsgWE3L2yiiJb1shkynII3pcsOZCbb0UiK5r0wyaY3ygEUkrTG++wyMZK/HF08tzRSFg6zejTdDt//jvuvhGAJwBQAxw9X/8Q7smGU4kNtKMAMqK/1jsYhsKIskCr0XZ70/hnOEBEXTo=
Received: from TY0PR03MB8330.apcprd03.prod.outlook.com (2603:1096:405:1a::6)
 by TYZPR03MB8092.apcprd03.prod.outlook.com (2603:1096:400:464::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sun, 23 Feb
 2025 17:49:45 +0000
Received: from TY0PR03MB8330.apcprd03.prod.outlook.com
 ([fe80::22a4:76d2:35ad:dadf]) by TY0PR03MB8330.apcprd03.prod.outlook.com
 ([fe80::22a4:76d2:35ad:dadf%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 17:49:45 +0000
From: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH 1/5] dt-bindings: display: mediatek: mdp-rsz: Add rules
 for MT8196
Thread-Topic: [PATCH 1/5] dt-bindings: display: mediatek: mdp-rsz: Add rules
 for MT8196
Thread-Index: AQHbfDA5jLoxTxf3wkWDuIJMLNCq1bNCY5mAgBLaqwA=
Date: Sun, 23 Feb 2025 17:49:45 +0000
Message-ID: <029f9fd7ab898769a7ae627b160e1dce446ccc9e.camel@mediatek.com>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
	 <20250211025317.399534-2-sunny.shen@mediatek.com>
	 <20250211-feed-shed-4b32f146cc54@spud>
In-Reply-To: <20250211-feed-shed-4b32f146cc54@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB8330:EE_|TYZPR03MB8092:EE_
x-ms-office365-filtering-correlation-id: cb369ff1-f500-4e98-eed7-08dd54327561
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TzR4TGhiVGYySmpKRW45c1VmbHVqQ0c3UzlISHIzV2o4aFgwMTNJMjA5aThE?=
 =?utf-8?B?eTlpVGhrbVlGRlpFSXo2L1lZYWRabWsvc2NCZjJYWnM2MDlsV2xONWYzbXlH?=
 =?utf-8?B?K3N2RG95WkFQVjV1NlloTCtEVSszRG9BT0xkSWVxRHYwcUVBNThLeE5ZOVAr?=
 =?utf-8?B?ajUxaTBIQksyN0NQMkxzVm5rdVptRSthNlBOeFBHSlRReWRjUFNRckpyVE5R?=
 =?utf-8?B?MHlMMHNnTWUwWFhqcGgvZFdXT3RXVi9pcFhzRTVPOS9kRWdITVl0Zmw5dmgr?=
 =?utf-8?B?Y0g1Tlh5Sk9GTHA3N1JOSDRZN2wzNmRWVE1JV2dXUjJmMzV5dVZMWlZqRHQr?=
 =?utf-8?B?eEIxYTVIdlM1L1MwQ0hKblFxQW1Vb3k2YUxlS0pGK28yQlQ5NzUxN1l1Vkgz?=
 =?utf-8?B?cXlka3FCVERRMkpyblNUL2EwMXl4Z2hSWktjOVIxLzMvQU12cEpuY0xud2Fa?=
 =?utf-8?B?SCtKNmFjRVZlYWMzbzJDUnJiclgvU3d5Sjh0SUdGd2tsaUhTcnMxdGlhV29h?=
 =?utf-8?B?VVVodE5oQlNSOVdlYjdCd08yM2JHak1uRkh5ZXl2WFJQMllPQjJDRmpMSlFY?=
 =?utf-8?B?ZEpZQVJBbE13Vm1EeXQ2SmxDc0hjVmFLQUtZeUJRdzAyNXdsZTZ0N0RBTWgx?=
 =?utf-8?B?dG9RQk5vNHlRaFV6a0hEek9UNEFKem9JZFhMYS9GaEJ0KzFLUWE1Z0prcVpi?=
 =?utf-8?B?N3c1UU5nNnMyRE15cFMrRGVmM1BvcjFaWHBpc1BMOUtYR0lqaFBmc2tvSlB1?=
 =?utf-8?B?SGFPWnNZRW1GTHVBNXNINlVPNWoyZGE2MVlOSzdYVXNLbVNyckdBS0I2T09r?=
 =?utf-8?B?cmt6dXYwdDJFOXNLbHVZRVlQVkZzV01WcXhrb1JvZXlSd0lNSkVFbVNUT3Mz?=
 =?utf-8?B?QWZYR3M1L2MwVFNlY1JhMkpVaFN1SFJqeFRPNnBuWWpQMnpJekZuUGg2TFQ1?=
 =?utf-8?B?OVpkaEQ5aXk2c1NNdTdtdlpkVnM1c2I1MWVkaEpWL0hCUG5rREZTTkloT1hy?=
 =?utf-8?B?dCtaeDQ0a3UyWURxRkdiVjVmQjd3ZnY1RGplbWtjUTNENE16VWRaMHA0VDdu?=
 =?utf-8?B?OW1RU2w3THJtaDlrY2tha0NKeUtmTTBZeFRRUUpEQTFzLzFwY0tmVEwwUnBJ?=
 =?utf-8?B?VlRSSkNmR3V0MmI0MGcyTENSNjNMeTBnakM0dFM1VW4wTUhWeXF4d3ZoejlG?=
 =?utf-8?B?VW42dXZDakdyK0thenEwYUYzZXVEdGc1RUVJT3p6R00zbUxBTVpVTE11dnNS?=
 =?utf-8?B?ckJMMHJRZnFLWXhvZnpuTkNTUjNkYTh6d0lieGNsKytGQnVXazIwcDNXTFoz?=
 =?utf-8?B?QjdYbTV2MWNVejdxQ2dLQUg2Um0zTHhzRWlpQlFFM3pLVENCL1hGNkNPUkFI?=
 =?utf-8?B?cTROS3owd2p0QmM5Y2lsZVVvOGl1U2d0UDdTUTdpOFNYbExpaStxQmhNMzNS?=
 =?utf-8?B?enBqQ0ZoT0tEVi9YRXE1Y0Y2bFBNTUNwYnp3T3IweGpGSTUrc1R2cm8vUFB6?=
 =?utf-8?B?R0J5emt5RWUrMFkzTy9vWHp3aDAyU21Dd3E5TENyb3RtSHJwZFhhZ2tnOFgr?=
 =?utf-8?B?YjNzUjl5NlN0ZFhxUW9wV0dlZnc4blBYOEFlN1U5RHk2YjBLUmhYK0Myck5y?=
 =?utf-8?B?d296R2h5VkVTK3BXMTFBWXR5QjVvQy94RTIzaWl1VTBna1g1NVJ6di9paWo4?=
 =?utf-8?B?NVV1amgrdjd1U2tEODRHa0RMTjZVNlNYdW1GRjlaS2JnTTh1amtXRUppUHNh?=
 =?utf-8?B?ZjBKWldDZWpkT2xUZmJkSnRNQ1FOeDl0YitZZldvVGcwelM4LzN5TzlCZERV?=
 =?utf-8?B?SHU3RjJCem8wYU80RnU2bHFIL25wMU0zeFRXUEk0WUdOWGxFNGxiY2xjdm02?=
 =?utf-8?B?WFJZQkN5b3R4aWxPdE0vSktJMGVNZ3lwRWVoRjlwenBUVmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB8330.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVNIN0tPek1jMmVOR04xTW5jdHVlNlM1bmdnOUt4YnFVSFZVSExWNHg0Q20r?=
 =?utf-8?B?SUtTVS9ZVHlUMUNMVGlhQ3Z5eHgrTEY2RjVVZ0dFbTJuMjFkcmJsNllPMkVM?=
 =?utf-8?B?YjZnRzVMdWFMVTdyZDFOWU8zajNaUmdHbU45dWJNRmJ3SEx3UE9TVnEwZjZU?=
 =?utf-8?B?RytMZU5ZanFHeldTVDhpa05DTEJ3aWFIdVFZZG1jT3N6dng0ODV0OTdqaW1F?=
 =?utf-8?B?WDRhMHNSUHd3UzJGazFJbHM2MlpsTU5KZmw2MTFEL0tobndmUGVYT2V3aTEw?=
 =?utf-8?B?Q1AxYlBYRDU2VTBqUVlQYVlVR3g5TjNtWWZNOXE5Vk1XY3lYNnR2NzNjQnMy?=
 =?utf-8?B?bWhraml1M0lXQ1g2TERHRzU1MHZPUGpaQmx0ZkhrZWNuMEt4dSt5UkFJdTRU?=
 =?utf-8?B?aUUrZEpCRWF4QXd0R2VPeVdtZ0d0MmtFMmdML0c0eGxXQUJxNFpRR0pKUEJS?=
 =?utf-8?B?SHh5UjN6YXgxWmdWRUdUQVEraFpPWFFtMHlMNHFGQUxBT2pEcVRzNktBSFNS?=
 =?utf-8?B?MGhaNmd6RlZpeno5R1JkdlZpeXRQUlludTZDMzlid205K3liOVpoQ3RVU0hJ?=
 =?utf-8?B?R1ZwOHpDeWdFcm4zdHUrUUdJc1NrSTBMS2U1alp1OUhhaHh2ZlBqeUdlMERR?=
 =?utf-8?B?Vmh6c1JWQmkvL3NZM3orTVN2MjBLKzU5bG5YSjlqTWkvSUQyMDc2WjhPdDVz?=
 =?utf-8?B?MzhwaTZyV1hXR3JYbUZ5R3dYa1RoVm5ZMmVlcExONXNET0dJc1FGdmNlWml5?=
 =?utf-8?B?R2h2YTJ1L3lGYmxkeHB4dFgxRmkxUlVEM1JsVFhoYzFxNVZpUlo1UXZ1OElP?=
 =?utf-8?B?dWF6dTBkb0NjenBIRi9WN2ZQZm5YNWJvaTN4aEorU2NPU3B0WmV6WXIvb1hJ?=
 =?utf-8?B?OTVNd2RlSnVmWm1WYVBZenN2QnZJOVJpd2pWWDhscjcxRFdzSlFDRHBGUXZ1?=
 =?utf-8?B?VjFYdmNQTFhVZWMzakxoSWFGUTJ6U29FNXJ3VFB3MVQxZFVPSHplViswNGNC?=
 =?utf-8?B?MHhManFPblgvVWZsQitaa1MvMEFnSjVCZFE1NTBtSHY0bUNPeXNDcmwzZ1gv?=
 =?utf-8?B?NnpqR3BReHlrd1BrL2Y4UTR1WGV1MTJBbWpaVW14bmExWHRnTTdNWGdZNXpB?=
 =?utf-8?B?Ty9uTm1tS05XMjQ0cEo5THFPQytDRkJRQmwvRDNBNEh0QkxiUlFYcXdrNmly?=
 =?utf-8?B?eEVmaFZKSTJHbUdWUmR1c1Z6T05qUzk5WkwzNkpyRmd6enNDTkFZMDZvVTEr?=
 =?utf-8?B?R25qcThHNWVwTnh5aXhEellFV0dFWWpBbmFRU1VPU3BIaEFVNDlhZ1RTcWY2?=
 =?utf-8?B?V1owYkc3SXNWY0dzMjhzNUx4WHZ2T1VHazBLTGFJT0tGbVdsaXVXQldieVNz?=
 =?utf-8?B?UWdUTm40TS9CWTBHUWhqRDVoVmVLN2hhZ0VDMkd2TW9vSHNLMEhZUk5RUllk?=
 =?utf-8?B?ekJHMGJKYkRvRVNpbjZvZm1wOTNBU1kzd2tjejZEMXhiUHJTemhZTTUzcnFK?=
 =?utf-8?B?RmlYb1hLZitKQXpGYm9IdjlNTUFPc1lpTGZwcGZlK2xvSWdaaGFYTFR5ME8y?=
 =?utf-8?B?dFZ4bzdvcjFIVS9EdzRuUTBWejJTZWZYbW5ZdUlrNUNDTkg4S2ttNFRqN1I3?=
 =?utf-8?B?QTNqSVI4RHNuZE8rMXhzU2FoTnhMM3hrc2Zqak4yZEVKOWNUWFZJcm1yamNQ?=
 =?utf-8?B?ci8yM0xaVjFRQThmQmxCODd5MytseFl4cHJXQkZ2eXZtUnFoWDRxSTlNcXgw?=
 =?utf-8?B?ZkVqK1lMbzIySTdOK3RSV1h2R1BqNFJacGFacXB4M2NZbzI3U3BCSytDdnJi?=
 =?utf-8?B?djBNZ3plVkZDZEIwQTJmK1E0MUN6OGxaRFlidVlsdUJ0TFh3Y2Y4Zm8vdUQ4?=
 =?utf-8?B?Y2w0bFV0RFdRUmh0dDZNZ1hveWFGUWsvOFRLRUhITkx3cWhzbnE0M2s1SFU1?=
 =?utf-8?B?cmpyazZPbGJ2YndWU3g3WW1lMk9RN2xwcmxtTWdRSU44bW5YcjVPZUpKRG95?=
 =?utf-8?B?c052UmsvdllrbU5hM1Q1T3I0R0x1aGI3VjVHWjVheFh1NGMwSGRBc05RTXJY?=
 =?utf-8?B?d0lHMUo5UXh1ZUpla3M1ejF6bDhTMnYzYWVBdE11Y0h0SFdQQTVOTGZUWTVL?=
 =?utf-8?B?Tk9tYklrUm45eTRVYlVmWjJyUTJjTjNkYnl1cnVtQmYrUm5CNUxTbzV4Zjhk?=
 =?utf-8?B?dmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <445D00FC33087E4CA3836610F4122933@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB8330.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb369ff1-f500-4e98-eed7-08dd54327561
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2025 17:49:45.0586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEvH882ag2dewua7rGQ3mggOfvN9JTHjbTo6dMVP1Pr9d4//pBGpwCceQdDfrYCQKkw+2pXcto8GC+rO1DxAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8092

T24gVHVlLCAyMDI1LTAyLTExIGF0IDE3OjU0ICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFR1ZSwgRmViIDExLCAyMDI1IGF0IDEwOjUyOjUwQU0gKzA4MDAsIFN1bm55IFNoZW4gd3Jv
dGU6DQo+ID4gQWRkIE1EUC1SU1ogaGFyZHdhcmUgZGVzY3JpcHRpb24gZm9yIE1lZGlhVGVrIE1U
ODE5NiBTb0MNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBTdW5ueSBTaGVuIDxzdW5ueS5zaGVu
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiDCoC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlh
dGVrLG1kcC1yc3oueWFtbMKgwqDCoCB8IDQ2DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+
IMKgMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEw
MDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLG1kcC0NCj4gPiByc3oueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQNCj4g
PiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21l
ZGlhdGVrLG1kcC0NCj4gPiByc3oueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssbWRwLQ0KPiA+IHJzei55YW1sDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLjY2NDJiOWFh
NjUxYQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG1kcC0NCj4gPiByc3ou
eWFtbA0KPiA+IEBAIC0wLDAgKzEsNDYgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICst
LS0NCj4gPiArJGlkOg0KPiA+IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2Rpc3BsYXkv
bWVkaWF0ZWsvbWVkaWF0ZWssbWRwLXJzei55YW1sIw0KPiANCj4gRmlsZW5hbWUgbWF0Y2hpbmcg
Y29tcGF0aWJsZSBwbGVhc2UNCg0KR290IGl0DQp3aWxsIG1vZGlmeSB0aGUgY29tcGF0aWJsZSB0
byAibWVkaWF0ZWssbXQ4MTk2LW1kcC1yc3oiDQoNCj4gDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6
IE1lZGlhVGVrIGRpc3BsYXkgbXVsdGltZWRpYSBkYXRhIHBhdGggcmVzaXplcg0KPiA+ICsNCj4g
PiArbWFpbnRhaW5lcnM6DQo+ID4gK8KgIC0gQ2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtl
cm5lbC5vcmc+DQo+ID4gK8KgIC0gUGhpbGlwcCBaYWJlbCA8cC56YWJlbEBwZW5ndXRyb25peC5k
ZT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gK8KgIE1lZGlhVGVrIGRpc3BsYXkg
bXVsdGltZWRpYSBkYXRhIHBhdGggcmVzaXplciwgbmFtZWx5IE1EUC1SU1osDQo+ID4gK8KgIGNh
biBkbyBzY2FsaW5nIHVwL2Rvd24gdG8gdGhlIHBpY3R1cmUuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0
aWVzOg0KPiA+ICvCoCBjb21wYXRpYmxlOg0KPiA+ICvCoMKgwqAgY29uc3Q6IG1lZGlhdGVrLG10
ODE5Ni1kaXNwLW1kcC1yc3oNCj4gPiArDQo+ID4gK8KgIHJlZzoNCj4gPiArwqDCoMKgIG1heEl0
ZW1zOiAxDQo+ID4gKw0KPiA+ICvCoCBjbG9ja3M6DQo+ID4gK8KgwqDCoCBpdGVtczoNCj4gPiAr
wqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBNRFAtUlNaIENsb2NrDQo+IA0KPiBUaGlzIGNhbiBq
dXN0IGJlICJtYXhJdGVtczogMSINCg0KT0ssIHdpbGwgbW9kaWZ5IHRoaXMNCg0KPiANCj4gPiAr
DQo+ID4gK3JlcXVpcmVkOg0KPiA+ICvCoCAtIGNvbXBhdGlibGUNCj4gPiArwqAgLSByZWcNCj4g
PiArwqAgLSBjbG9ja3MNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0K
PiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gK8KgIC0gfA0KPiA+ICvCoMKgwqAgc29jIHsNCj4g
PiArwqDCoMKgwqDCoMKgwqAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gK8KgwqDCoMKgwqDC
oMKgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqAgZGlzcF9t
ZHBfcnN6MDogZGlzcC1tZHAtcnN6MEAzMjFhMDAwMCB7DQo+IA0KPiBBbmQgImRpc3AtbWRwLXJz
ejAiIGlzbid0IGFueXRoaW5nIGNsb3NlIHRvIGEgZ2VuZXJpYyBub2RlIG5hbWUuDQoNCldpbGwg
bW9kaWZ5ICJkaXNwLW1kcC1yc3owQDMyMWEwMDAwIiB0byAibWRwLXJzekAzMjFhMDAwMCINCg0K
PiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE5Ni1kaXNwLW1kcC1yc3oiOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDww
IDB4MzIxYTAwMDAgMCAweDEwMDA+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNsb2Nr
cyA9IDwmZGlzcHN5c19jb25maWdfY2xrIDEwMT47DQo+IA0KPiBTdXJwcmlzZWQgdGhlcmUgYXJl
IHNvIGZldyBwcm9wZXJ0aWVzLCBubyBwb3J0cyBsaW5rIG9yIGFueXRoaW5nIGxpa2UNCj4gdGhh
dD8NCg0KQmVjYXVzZSB0aGUgbXQ4MTk2J3MgcGF0aCBtdXggZGVzaWduLCB3ZSB1c2UgbWRwLXJz
eiBhcyBhIGJ5cGFzcyBtb2RlDQpody4NClNvIG9ubHkgc2V0IHRoZSBiYXNpYyBwcm9wZXJ0aWVz
Lg0KDQo+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoCB9Ow0KPiA+ICvCoMKgwqAgfTsNCj4gPiAtLSAN
Cj4gPiAyLjM0LjENCj4gPiANCg0K

