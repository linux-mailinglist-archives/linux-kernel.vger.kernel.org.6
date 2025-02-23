Return-Path: <linux-kernel+bounces-527862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52FA41093
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 18:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A457A9ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BA186359;
	Sun, 23 Feb 2025 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eGvaXm9Q";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="surJD/ag"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085612F50
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740333093; cv=fail; b=L0W1x0gZzjTIa5S2JDUtPh97nDRSwYvLiW52e0NMa1txMdIPOcUxQrRFC33GEOHuvW4gGX3paivKqB4BOEJ24AOyyPT+Ljr1p44Xz2WnM7ChSON+7UcHC3WlZZ3OAGLI4Yz0OOl27zDGKhaE4BVHnoEHX/u6BjscE3EhFegq2Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740333093; c=relaxed/simple;
	bh=QF5uje+Tr4NywTT3Dxz9E/hj3b+rpxSBXMGQ6VnXFwg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BrKIn7VyXrC1TlnDoohY+6Etz2LDenFmF8yftfCTHyWqm54n1eORva1YDV/BtwxRI6wmXmb6FhG17ye4YMBxKHX1kqvqzvqWvs7KaN0yP3h9sZzwgzzsofgVVLQnyaBEsh9KWmrEg1MsDwduX1WJPOOUr3XahBvd11e4ITW5MPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eGvaXm9Q; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=surJD/ag; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cde26200f20e11efaae1fd9735fae912-20250224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QF5uje+Tr4NywTT3Dxz9E/hj3b+rpxSBXMGQ6VnXFwg=;
	b=eGvaXm9QID04hOM4Bw4B45X+U+Jtl/qJs6JRGxcnQBZwvz3CYBrAXXKApObjwAaED/2Hme+5uDovYMt67LxxvfhOX64LBm8FDiBQ2lJf2syZWPrbNXDV3jF2LkmQw8WLX68RBaqgHEnI2v211M2iD4K5Su4b39688x3JUB4Zehs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b51f0387-549b-4e1e-b2b9-c62884a1b6e2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:bb9273a4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cde26200f20e11efaae1fd9735fae912-20250224
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <sunny.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1839264750; Mon, 24 Feb 2025 01:51:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 24 Feb 2025 01:51:25 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 24 Feb 2025 01:51:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJDq1jj/svLzcuh3o2DYhG46nb8h5O+oMl5a9cMJbuGR8pbu9ovOTyfKTRiaf5UDnvv3RtfMkus8/Hvi7LfLCHUxDldyiodmG9DCELYFLNDMpHEVELBzgbBRUKm++WKu98AUNkcW+JB+3TdrXbHMB1hWbP4KO5HPxgIJQdTV8Pjbf8E8W6uhOWSwNlkQlwDGZ/QQtS3L7zk4lWoghJSFQfDPRK3fWZ1m50xiaoyeuP5xhYaLeuApfxGhWLQrikRL3KcR68VqUuuP7Z4JouL8QkiTfyF069ry3dFbzzAUPF0agPf34oKZlmqulfuD51W+wP8jQOXKY6GQ76et3EZjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF5uje+Tr4NywTT3Dxz9E/hj3b+rpxSBXMGQ6VnXFwg=;
 b=ttlvMnseaEZdkm94BrUo9LCelFFxAS5WcixfOnqSETJtT8ze793ovQZsOj+P23mUy1DyLeOpsBn0h36h8nI6tBCMD9rzEyrsb7jt+Oum0Zq8+keXg/tAsYTW7MHvBFs1I04EhaEQS3N3N2YAO21mwYr45iHuoL3WGQRrteinpx9igXJMM235lIzTXeER4odlFC9+QQr+w6t6ZRA1613V8d/Ht2uLafIv4J2ygl/RucboPfcSkt/a7hjWBUK5OeMKrdM2KOZ8JrfShuyUaUWhWOdvEEm5vX9/Rojki7AY/p86V4o5VCq95zM8bKb2hHTQTQt8EduoegcPz9cCd6XfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF5uje+Tr4NywTT3Dxz9E/hj3b+rpxSBXMGQ6VnXFwg=;
 b=surJD/agvkzmfoFQCDf40EIQZe/3VTCgnnPXG/7AfIxuG5b0wjKNQ2Y8ZeH3ONHraQjrZoVlZkIQE5Eg9Acbg89fNBD/hU2TF4BFmwqbUBJN4e6s1cFqBkmp+yDRJKvVfy9DCdIxzUeWArmEmnXBxdF3seIBuEmKQ8DIZev0NpU=
Received: from TY0PR03MB8330.apcprd03.prod.outlook.com (2603:1096:405:1a::6)
 by TYZPR03MB8092.apcprd03.prod.outlook.com (2603:1096:400:464::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Sun, 23 Feb
 2025 17:51:22 +0000
Received: from TY0PR03MB8330.apcprd03.prod.outlook.com
 ([fe80::22a4:76d2:35ad:dadf]) by TY0PR03MB8330.apcprd03.prod.outlook.com
 ([fe80::22a4:76d2:35ad:dadf%5]) with mapi id 15.20.8466.016; Sun, 23 Feb 2025
 17:51:22 +0000
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
Subject: Re: [PATCH 2/5] dt-bindings: display: mediatek: postmask: Modify
 rules for MT8196
Thread-Topic: [PATCH 2/5] dt-bindings: display: mediatek: postmask: Modify
 rules for MT8196
Thread-Index: AQHbfDA9QaUDteGhNk+guDeZMIecn7NCYPIAgBLdxgA=
Date: Sun, 23 Feb 2025 17:51:22 +0000
Message-ID: <2c13ea74056695dc0c387d370c327ee5514daf31.camel@mediatek.com>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
	 <20250211025317.399534-3-sunny.shen@mediatek.com>
	 <20250211-darkened-justify-f559a0bf2a81@spud>
In-Reply-To: <20250211-darkened-justify-f559a0bf2a81@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB8330:EE_|TYZPR03MB8092:EE_
x-ms-office365-filtering-correlation-id: bf6f6a3b-b862-44d7-2e6a-08dd5432afb2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZGd5TmlDQnkwZDFSb1JEMVptdFBPM0JJNng5dHNTMW9NaExEVjMyalN6Z1FU?=
 =?utf-8?B?ekhPbTRFNEJjYXFsSWFRTVF1bEY2M1ZEdGhha1pkT2FEa0pjUysycFhzSnk3?=
 =?utf-8?B?NlFtcTJjUHZkQjNZNUdWV1VIRDdjQWMvWk5kOS9ISzNncUNaVkJzUXorMDla?=
 =?utf-8?B?WGtUaHF0TzArZ2MzdWIzd0dKeFE3NVdaMEwvbEFjYUZtKzVmdXl3TlpjRU1u?=
 =?utf-8?B?eUtUWEhDR3djOXo1SkpSbTMzTXBoYW81TTZXaUdqL0ZMSmRJY2s2SHEybG05?=
 =?utf-8?B?Z0JONmtyL0JyWWZYZUlJK2JTVDJzUEdpUkRvVlVBZ0FYTFljMk9jaDhuVVpT?=
 =?utf-8?B?VjUwZXM5MTl4RWF5OUlrS2tNNk1uTmc0MDZmZEtrb3pFbzQ2SVpNOVlSQkth?=
 =?utf-8?B?Y2NsVHgxbHpXQ0pJUUZaSVVSYjlFOHY3ZWVpZTdnMksyYVlvNlJzNHVENEFv?=
 =?utf-8?B?bGlFU2poMXpja050WXJpZ25ka2VBenpxZUxRYy9CWGVCcG1vbncxNGdYTmNL?=
 =?utf-8?B?bHpIWWRQUGhzV2duVmczTDhLMFVQTnQ0c2VGbS9FaVprdXV3c1ljNHp5QUhI?=
 =?utf-8?B?MDYvc2FUMjVhNGFGYkF6clJvTVA1VmE2QndYSzVSaTUzV0xybzFhdVJla0lG?=
 =?utf-8?B?clNFeWdxSlkxS3RiRVVzM0VOUFlxeGdkckNRcnppT3pwaW9DQWV3anA2WUZk?=
 =?utf-8?B?R0FmZTZGR09OZ0w3SlNsY3IySU0rMUdOZDJheXZZcXZieTZyWHRhRUxibVFL?=
 =?utf-8?B?YkNUZ0VubXpaSWVaalpRWm9GODV4THBEL2pIUG1raFFCMENlY3puVWxSN08z?=
 =?utf-8?B?S2JETDZOdTN1SEM2VTNRTFRFMkdZczhqSkYwdGdZWmdLd3ZWMjRsL05URW1D?=
 =?utf-8?B?b3NROWRrbDBwclhLYzg1cm15Vll2NHE0YTlyNlBrQzhFcW1wMVpLdTBHNm54?=
 =?utf-8?B?UzZKUy9Mc29Cd2pCaVZvV2ZJRjFLNTVxUUo3UTVGa1hVMmZwaitEZ1FCMXAz?=
 =?utf-8?B?THc5SnV4Zyt3SHg5Z3pMNXBqU2Q0aUpXZmpEeXo4ajRsYXlIUjBwOEVQSnVL?=
 =?utf-8?B?L2hqSkFDMUVtUXREbUFjVXF4aWRjeVMyVERNdlcrZzM2NmJwaE4yVHVZR05p?=
 =?utf-8?B?RmJvTzdBV0E2bEN3YkQ0K2pDbEF4WmJGZW14ZzZYbWpCVUQxUysrRmUrMFRn?=
 =?utf-8?B?bDNOUmttM1VPbk83T0MrOTVwUVJOZHZOT0V2Y3ZrZU1GVnhBR2tSMkZmL1dm?=
 =?utf-8?B?dUVveUQra1VWV0FQQ2xtT2N6R2FobmdBRmxjY3U5NlVjQStIVERxeGt0VkNR?=
 =?utf-8?B?Tk91ZDViQWNTNHVseThQUTdWdU9ZYXRVd0V1eHAzcmJCYVhBenpoWWM1ZXhY?=
 =?utf-8?B?Ly96cTFwUjU3RTl4bG5LazMwY0FxeWpsUGY0dTNuQ1FoRThCWFkyYTgweGFj?=
 =?utf-8?B?RjBYV0NOTktwdkM4REgrMjlPQ2N0NnRRZ0pEa0k3UTBPck1idHg2bzJ0c0tn?=
 =?utf-8?B?bnpZKzl3aG8rc1B0eUFwQnIrNmNkWnFKOEJtQWN6d2FJNk4ydzNNa1FySXlT?=
 =?utf-8?B?WGJzVGRqR3NWaVc0STV3SFFtNENsYkFLV3Vqb3MwRGZySmV6b1FaVGRZYlNT?=
 =?utf-8?B?c0c1Sjl3VE5uS0FTVkdrSGNoMzlDZWplWXhZYm0vRTBqc0w3dDBBRGIvWktx?=
 =?utf-8?B?WmVmWUlwdFNoMS9SamtXc3FOM0E1TklxbmM1VEpjL1NrVS85QUhDbmZUYVZM?=
 =?utf-8?B?dFdDcUdqaE9YaVpocFNqbE9pcGozMWxJaEFiYnI4bVZQdEREdkRyaXRsbG9y?=
 =?utf-8?B?U3M3ZU9sVkRJWjZZSjZUYkwxVzZ1T09uMHhwNjMyelRLSCtJdlZCU01uZGxX?=
 =?utf-8?B?cGZpZTd0WU9PV2J2UWlyUWhjSTZmRmt1V3R5c21GNVFEKysrUkxpcjd5K2Vy?=
 =?utf-8?Q?ZPW23uTlP41d3Z9YPNvwaWcVJIXUebKi?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB8330.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0IrT3lYdU52OE1aaG5hdmk0U0FBbGR4ZlpDZGZhQXZaa3NlMlRpRUtYakJV?=
 =?utf-8?B?WWU0Q0d5Vk1rOVNNWWFSVGYrc2pCYzFBMVdac2lqVjcvK3dCd3Nkai8wMXhX?=
 =?utf-8?B?TVlMYW5oUEpJRkZlZkhyWTA5NW1sWE5vbFZtVjlyL1JQb29pM2NFdXhZd2I2?=
 =?utf-8?B?VU1XQUR6cTVNNjZ1endpYWlWK3R2SytXMDEyQVFvUzFRdDVuV1lsZGYvbjhu?=
 =?utf-8?B?ZlorcUZ0R0srWkYwc0dyZnhha3Y3YlNvQkoxUllWdE8vTVA3QUFZYnNBZG5p?=
 =?utf-8?B?UnpYUHljK2Uybzd6QXhyS05VNjkrT3YzSkRTOGo1YkpncS9oWERiUlRWNGVT?=
 =?utf-8?B?T3JFNXhUV1kwRkdsOVNlNnhWZE5WMXBCcW9GcHlIVDdiK283K291RVB6NzZD?=
 =?utf-8?B?TDgycTBMRkRXRlc4NVNWT0VvVVFxNnlSdmF6aGJzWjZMME40L29wNEY4Q2Nu?=
 =?utf-8?B?WHY4YmVCU3dyZDdQY1VKMVp0UWNJMkk4SkE3QXB4bll0czl5eVc3a2tEakVu?=
 =?utf-8?B?aHR2akZvRDBiVjdhUlhDZ25DOEsxV25NL000cTVhNjd3R1kwR1lEYmFQVlM0?=
 =?utf-8?B?Z0xKNGhLQ2cwMWhFVG1QN2IzSllHQWJjWWNFSk05NzRpQ2hSTkVGZWZwcmVw?=
 =?utf-8?B?amEvTDArR1JJUDBWcmY5dnF1M2pPdnUrVHc1bU1nQWtEMkdaeDB6WFYxdE1K?=
 =?utf-8?B?WUNvYjc5djlWN05id0VGVDFzb2Y1dlhhWXQ4aWF6UEhLdUNkR1ZEb0YwVFJY?=
 =?utf-8?B?cFFKQkJyU0t0RUhBUmlRbk9yLzhCL21Hb1BEMGxDeVFtM1UwRFBkYjFTUnQ1?=
 =?utf-8?B?UGVwZElEL3dXV0xDY1ZlVDlUWWZKVkpPbHhGQnpjOEd0QU10cXVudEVJYm96?=
 =?utf-8?B?UUpEQ3l6OTFqakliOXcyVWI5K2FlTUxRWUhIazBMeFRETjFBYWVrd0JkUWxn?=
 =?utf-8?B?aG9uVFJ2ZXBJVEt1a1JMVnh1MHpjM0dTaUcwNGhSRWF3a2dvcHNoVTdMNDUr?=
 =?utf-8?B?T051cHoxRkYrUzBJUVJyMEpCWHFzZngyTXZ3UFdHMjg0VXQrZC9mU2FNa0Ro?=
 =?utf-8?B?VkZzSzhUSHIrSGVUL005L3F3ZW02Y3pZSW0zZ0d6MGdESEVTNmRRcjZhbXhL?=
 =?utf-8?B?KzNzU0VoZTBCMzVISHQzQzRWYTJpNzRBTWFwdnE0YnhlVXNVREVjTmtTRjhT?=
 =?utf-8?B?S1pmWHp3L3dZaUdXTGRSdTZxRzQ1NHZkSEFGSEtDeG9uNWhhTE9KVXNLL2RQ?=
 =?utf-8?B?ejdRV2tlL0xOSyt4aFg5aHpNMlUxczBRMFhFVk1VUzQrU0ZsL2tXUXF1d0p0?=
 =?utf-8?B?YStDbmN4UU5nZ0dPZG50VWlPTmFUMEdCR0w0WUQzOVhLaUgrY0NrbE51Wm1B?=
 =?utf-8?B?cDdLaEVqMTZ2V1VzQkhkR3hsemtLT28yOGNmVVRoOThNb2lKbTZ4MXpvdXhV?=
 =?utf-8?B?dTZjNUtERXhGM2g2QVRKQlV4dlRwU2c4T3VmSEtZK0I1SExkQmF3dk9tY2Mx?=
 =?utf-8?B?MEVlT2p3SENnY0dwTHkwMENpNFY5VG4vajhDb2huNkpXaXRVRklBdkN4Yklr?=
 =?utf-8?B?SHlrQ3BoVGkzbm1tQmw3ZXVMOG0zbmxvTkxjamFZY25oOTVEYWwxME1PUkdV?=
 =?utf-8?B?T1grY1NzYWF4bHd6dTB6eVdSZVV5M3Z2ckFpWVIxSngrekJTL2NVWDRiWWI1?=
 =?utf-8?B?Ti9ybCtMUlM0K2U4S0pTNkhvSlU3TFdhMnZXc0dpK2xEY25CTlNQWlord2Q5?=
 =?utf-8?B?UHZrVmh4NGlTTEkxQUttaS9vbTFHYU9PZ1Q1OWt2MGxsejdsMUFtOXk5MnNJ?=
 =?utf-8?B?eUVwdk9LNWZUcCtyazJKNHpXMndKU25nbjhYM3N2aXJVL1pIUEJHUEFCeTR5?=
 =?utf-8?B?RWRjLy9Gd2p3SUJ4bHhaektmT0N4dmE4eTZ6STZvZ0MzRjFBMWh0d0hISVVm?=
 =?utf-8?B?RUYvQUcwSklHSDArS2NDSkJjN3FWcG92MDQ4b0ZkajVtZWNOWHJJUFJmdW9m?=
 =?utf-8?B?N2lTeWpxeWJhR2FmdXVFekFmL3h0TGI3ZENVRWRzNE0xSEFXdHZHVWYySm56?=
 =?utf-8?B?ak0xbDNNMGVWNEROZzgwb1lnUy9LTEJUd1JLbTVpOUo0WmJrTDVvM0JCcVRv?=
 =?utf-8?B?ZG84VWpWTmV5T0x3ZjRnRWhiZWM0VmVEL3lDczVseXJlakVBYVFIeHZpYTJE?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C18BC2254AC07344B6963F2084E7AF48@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB8330.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6f6a3b-b862-44d7-2e6a-08dd5432afb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2025 17:51:22.8893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9LYVXESiNUtrqLwZO8xM96P3gvUehCI2AH7U96W+c7jxP8C/4KTiw78T64uf8rkot8KmtTkiR7i+5ryJWDJyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8092

T24gVHVlLCAyMDI1LTAyLTExIGF0IDE3OjQ0ICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFR1ZSwgRmViIDExLCAyMDI1IGF0IDEwOjUyOjUxQU0gKzA4MDAsIFN1bm55IFNoZW4gd3Jv
dGU6DQo+ID4gQWRkIGEgY29tcGF0aWJsZSBzdHJpbmcgZm9yIE1lZGlhVGVrIE1UODE5NiBTb0MN
Cj4gDQo+ICRzdWJqZWN0IGFuZCAkYm9keSBkb24ndCBtYXRjaCBoZXJlLg0KDQpPSywgd2lsbCBt
b2RpZnkgdGhpcyBtb3JlIHByZWNpc2VseQ0KDQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFN1bm55IFNoZW4gPHN1bm55LnNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IMKgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxwb3N0bWFzay55
YW1swqAgfA0KPiA+IDEgKw0KPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+
ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsscG9zdG0NCj4gPiBhc2sueWFtbA0KPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0
ZWsscG9zdG0NCj4gPiBhc2sueWFtbA0KPiA+IGluZGV4IGZiNmZlNDc0MjYyNC4uMjk2MjRhYzE5
MWUxIDEwMDY0NA0KPiA+IC0tLQ0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsscG9zdG0NCj4gPiBhc2sueWFtbA0KPiA+ICsr
Kw0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0
ZWsvbWVkaWF0ZWsscG9zdG0NCj4gPiBhc2sueWFtbA0KPiA+IEBAIC0yNyw2ICsyNyw3IEBAIHBy
b3BlcnRpZXM6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBlbnVtOg0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBtZWRpYXRlayxtdDgxODYtZGlzcC1wb3N0bWFzaw0KPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBtZWRpYXRlayxtdDgxODgtZGlzcC1wb3N0
bWFzaw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIG1lZGlhdGVrLG10ODE5Ni1k
aXNwLXBvc3RtYXNrDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogbWVkaWF0ZWss
bXQ4MTkyLWRpc3AtcG9zdG1hc2sNCj4gPiDCoA0KPiA+IMKgwqAgcmVnOg0KPiA+IC0tIA0KPiA+
IDIuMzQuMQ0KPiA+IA0KDQo=

