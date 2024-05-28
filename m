Return-Path: <linux-kernel+bounces-192548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA908D1EFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1AD1C21E25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A3016FF27;
	Tue, 28 May 2024 14:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E2g4fuu8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rRkdJA3I"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126B73475;
	Tue, 28 May 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907137; cv=fail; b=Mg9j3gN9hfUuQqJWJhEMOP7o/t8ujz99Kq2t105LU2Mz0eGA+S6Ecr2AgWLrxSTYm9Uy1Le1gxV8NfvmeWJqTPhA/V8Ju4J/DA67u8ZIxmRFwIXuwCGUUlbaOVhMFmQX98faCLCr2kl+opgf+d4YYHti822ZY8JYz4gmZ/sXSeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907137; c=relaxed/simple;
	bh=tQ8bksS07ipaCe3p4buEn7YrkxgTooHTpnTK1JOM1Bo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m/NRepsyXCijB+jedm5r/3G2wArsBTAXfTn8HXw/tD9W9ObEkRyKfTV2amYtLIJi6GqNWm/vaYo8XO43geeuSkdRaRznAdm4FaMEyL5Tt9geSk9jvxfoWkZVde8ac8wiQwG6+uxHq68hdRVtkysvjtwAeKHZqPc55FmcYKe5G48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=E2g4fuu8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rRkdJA3I; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ff58a5681cff11efbfff99f2466cf0b4-20240528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tQ8bksS07ipaCe3p4buEn7YrkxgTooHTpnTK1JOM1Bo=;
	b=E2g4fuu8UHD9Ig8/Hb6qJveR2hnk+bDP66mPRF4F8kXmR0ZTpQY95VmIxj++6CY2D930vVk7j3s8F84HcwTa/R70QhE9EyuKdeDNBWfCoudypDqI8qNN25c3freAZP+2md9vms47/160DOkIMgaWm8ltqsSI4iFHzMo2M/3quPA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:d9bb38a2-de76-4715-843f-cf9f6c1c8bf5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:6a1de943-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ff58a5681cff11efbfff99f2466cf0b4-20240528
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 218871865; Tue, 28 May 2024 22:38:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 May 2024 22:38:48 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 May 2024 22:38:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QyBa/RbraaTBNMea2a/J73iLO5UOeW9z43a3bdom+VM7p2RykmXuQBUCJquRL4rJ3mJmo0/jKwmHER2NmS66lyBJqLI/vrSycit7QY4x1mfy4eXfobJaVke7dNylkTj2G8izI2tgcjV0HnDIvuM5JpmeFVCb6G0aG3pubW30nXGl7WsPd63P7KDhRp6z416jzuwURegVdfW/tBmUkJ8nLdGn+re29yDkO1ZT7wmmir3ew8WAJ6kEjn9yYvVrAvdLkYJN3NStgGkvBVnEaZiKkbE23Q6HGKfJjH6oDGOIuvvfgujf4oikxexJqcu8s2Q4w+6fO/+YR0MgxfF+V5ozkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ8bksS07ipaCe3p4buEn7YrkxgTooHTpnTK1JOM1Bo=;
 b=FUpQdaOE/ofMEX9kj3tTmuRs4Qu5kZoXnHHY0BjZ0kQDRggA/j+PkM/DSOAebTz4TJqzJ6JHtpRdEFWrEdMdJl0Et4N4oAaHjMSGbKQnSvsvxs/ebEpFq3598A8d/CD/MzoalutHqa8essIvEESzToVKxXSHwMsrfDpd9eI13gWSsD1MJNypCZGmt8c7owSmzTwHlqKHGSVoud1PvgBUALm8WehOvaKPkBhs40vXQPBlwSHBDTAUsp3Hi5FykZqEmcBZkStumM4xSDHWtUt4q4Q+51d/q40k3ASAwEG1/sbpPYFz5dgcDihByf18c+QBJ4dwu7lIU9XdBRJ8EnFomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ8bksS07ipaCe3p4buEn7YrkxgTooHTpnTK1JOM1Bo=;
 b=rRkdJA3IJv4WrRAA/9fZGWcrTON1F+9mEHajQvgge9WZhCjCJ+l8k1TLIFtdf07uo7l6vUHvAln7YNNgkieGDZeQIzYKWPp399BDoVtHnP2jtQXywsciKMEAb0/o3jPmbAxK3NTJP4qSrpT+vf8Lh6XkISOz31hxnX4jLh1nh9E=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7396.apcprd03.prod.outlook.com (2603:1096:400:426::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Tue, 28 May
 2024 14:38:46 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 14:38:46 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH RESEND,v6 2/8] dt-bindings: mailbox: Add property for CMDQ
 secure driver
Thread-Topic: [PATCH RESEND,v6 2/8] dt-bindings: mailbox: Add property for
 CMDQ secure driver
Thread-Index: AQHar3tWR1mdbw1vHkCqbT1wS+K7DrGrWdoAgAFgqgA=
Date: Tue, 28 May 2024 14:38:46 +0000
Message-ID: <3541454c6f60b8a16f4930dd91173ed24c9b5fd5.camel@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
	 <20240526144443.14345-3-jason-jh.lin@mediatek.com>
	 <20240527-bullion-slapping-d35fcddb56d5@spud>
In-Reply-To: <20240527-bullion-slapping-d35fcddb56d5@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7396:EE_
x-ms-office365-filtering-correlation-id: bc9ccdae-62f6-4391-9173-08dc7f23e162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?a2ZEaDdqTEs5dUFGMEo5WWVXbEJhbjJIdDhnQXVQaFlTVXhaQUt6eDhEK3Ra?=
 =?utf-8?B?RDZkbno4cGVpcUJSZWpkYXg5Ujc5cDByRExYVzhjWnZXbVkxd3g4Sm1LSnVL?=
 =?utf-8?B?VEFmNjViaDRoYjRzZkJLR0N2ZUxmdVN4UTJCZ052UHNuZjFEc2kyQXVJY25T?=
 =?utf-8?B?UVNaR1FueUNXMUJQMVlSb2Eyc29hRTNuWS9tRFMzd3FvbENTeFYwQkFKeDlv?=
 =?utf-8?B?dkhzSjlFYkxheEs1ZUpzbEJjdGFWWk1SUDdoTG1KaWoxUThmOWdhMlFLenF0?=
 =?utf-8?B?aVJ3ZmZzWWJnSXhCQjIxWmJURVlVSnVHZWdIYWhPekU2WVoxalljak8rK0tN?=
 =?utf-8?B?dzhxNzNlSzVjbkFDRUt3dW5KM1hYWVo3VkFNL0QvbjFaVmxRREVndkh4WW5m?=
 =?utf-8?B?R0ljTUtPc284K0lyalRtREpmTVgwVVFIbE51czhrY1F2d2hWVS9wcXNKRUV3?=
 =?utf-8?B?TVJ6V292c3ZsNlN5a01TT01ENTlVS2M5blVJdHBhY2Q0STZmQlN6elMwL3Rm?=
 =?utf-8?B?Z0QwbmM3Q0wyZTE3elFsa2ZPaUlVNzlmVk9FWVgxd041Lzhqamx6Zk41T2Fv?=
 =?utf-8?B?YkxkMGtkWnR0blc1a0YrZFNnb0wxRFQzZlFNN0NTQ0JhTjJvcEhqeStRQWFB?=
 =?utf-8?B?R3RQMyswN2JtNm42WW80NXhNdFY3N3Rwb05tQWZaQlVFT0ZpQjFZa1NxNTdk?=
 =?utf-8?B?V21vQkU2RlNpaitoN2ZMMjhiOUtKWTJBN1hhdjQzcHY3WDVncmdkd2pKa2dB?=
 =?utf-8?B?MmpaQmpqb3pTT3hnTUgrZURERTVyTG5obVVFMWo1S3ZxMmMyZGI4dzhMR09q?=
 =?utf-8?B?aFRrUFVYeThhZmtQNklNVlBUM0pNQTZDZFlWaHdURUFSMzQyd05TVnpwdlpF?=
 =?utf-8?B?QUJrQ1d4ZnBjdk02Z1M0YnpIa1JDMVRhNWhOVU0zNUF2OVJnN205cHJWT1VG?=
 =?utf-8?B?R1hWaXBIbzYzR2JmZ1QzRWFkemxUejg5Y3kwbmI0YXM2QkVIRlJLNnYyR1A0?=
 =?utf-8?B?L0hmTUNSOXRndUFOSy92MmRLWG00cGdScG1aRWhyaU16NitSa0RMRURhRjV5?=
 =?utf-8?B?WDBCM0dmOTVZQVUxN2ZOcHRtZGRzcFVoUnBNMG9sQjNqaGdtNk56REVXVDJP?=
 =?utf-8?B?UmY4WmVSZTNVeW5qT1VxVWFZNjNOQnBkdk16RmVCOC9WVkV6d1lEOUR3aWtx?=
 =?utf-8?B?eTZHSVA2cW13d1dTWWs1bFE1VmpBMDBSS3dKM01WNWJMVTZNR3VMbGdHSlJP?=
 =?utf-8?B?Y2xGQlNySEVzWmZKK1hDNXRRM2lWSVpJQVRNYkM2Q3dBOFJmNFFOUXI1VzZm?=
 =?utf-8?B?WWZnZXZ3V3RCdUpjWGtrOHh6dUZCeWVYR1huVFBPVmwxeE1sMXBOTk9SUnB0?=
 =?utf-8?B?ZXNzZlc2T01EdXRMOGE2bVV3L3l3VFFwV1VRRlhmZ3lNUWF4SkdiWmJ3bEln?=
 =?utf-8?B?V1E3ZU1zSWZIQ1BKWk5wZ0VpS2s5VTYvS0Y4Q1JFMENiY3IyYmhiTDhZUFpC?=
 =?utf-8?B?dUI3ck5lTm9uY05Db2s4OXJveW9MS2l5dkEvT0VFVlhRL3hGYlVSdnpwcUtI?=
 =?utf-8?B?WERlZ1FOM0FtKzVqaUszSjhpOEFhRzVVeHhSSUJ4R3JyK2xnejlFMmFIYTRB?=
 =?utf-8?B?a2oyQUxmbzk5ZTNZMkE3NC9WRzZYWEF2UmtKWWxEM3RiUTZPVStlK1dZR0hE?=
 =?utf-8?B?VE1mTVdoVGgxeFViSXFwMzNITmg3ejNHb3cwaEpDV1Z0MzNuSEdlRmVaZVdL?=
 =?utf-8?B?bGIwb3NWUjB6eTNpU1pGcnpabjU1aHo5L3llVCtmZHo2SHJIYVdHbTZYbmNP?=
 =?utf-8?B?cjZtU2RJVEFaU0dHL1ZQUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDZGUTMydTROVmF2UURiZU5pQkU3bmVMTW1nODdpNG1hWTNjd1BYK3BQTmxG?=
 =?utf-8?B?YmVNditVSTZpcTArbGNXMDhXSVBLL0J4N2I3NGx2d3JwV2lJamlkbU85c3FY?=
 =?utf-8?B?RTJxbDRIaEJkVGh4a0F4eGM4Z0szdnVUSzkxZ2xvNHVEZGlZaVFZR25LTkVw?=
 =?utf-8?B?bUdYRUQ5Mlk0K0E4VlMwZzA5VHVUZVZpaGwxVnd2YjRkTTlhc3Rtd3VOVDN3?=
 =?utf-8?B?ZVBUOE5oMHVxTElJKzlTVjgzYlRSRmp3REpjaHYwSEhjNi9IQllTV2JaUnVL?=
 =?utf-8?B?NG9QZnBiUjRPbDFvR0RiNUgxQzAwdDFqeDdqamlDNUN0K0VzdXEyOTh6SWZP?=
 =?utf-8?B?TlVQUFZSL09kN3BiSU9uZW03cGpHcklmdy9RVkhkL0V0Wmk4NnRvVlNISVo4?=
 =?utf-8?B?WCtpT2Y4RkJ1cnE2ZkZyUWwrQTc5R21uYUZLeGNhaWVnZkNJS0J2WURycHQ3?=
 =?utf-8?B?SVg3UitRWitJNGhXckd2Qmpza0R0SGJBTEsyTGljblYzR2Z0MDdpVFJvTU5L?=
 =?utf-8?B?S1Vmd0RjdzZJS0g3cTJVSUU2Z3d6TExURXhFbDNpNG16bEE1bFpBNk9pZTFt?=
 =?utf-8?B?dW0xaDFQMlN3bURUMFlqOHJoa1huelVtWlVNTWRFcDJmK3NWcmdmSEtRaFVt?=
 =?utf-8?B?M2ZZNXJ3a0o0T0RXeDFoRXJtUU5nSXhrZ3ZHRmVmdjl1M20yRkZjeG5QT2dE?=
 =?utf-8?B?a2hHUldGbFZwTU4yQk54QVcvVHZBWjc3emhQSm9RWkhOeDBlOFJNY2UvVVZj?=
 =?utf-8?B?UngveXRXQVJEZENmdTd6QlpPZ3JtMVIvckF0ZndaLzl4Ym1ZTlBSSDBDNU9a?=
 =?utf-8?B?Z3kraUdRWW0rbCtUSU9DT0dLSFpoOW9kbUovS3BBWWxVMEpPajVpSXVGL3lu?=
 =?utf-8?B?WGd6WU8zbmMza1l2dHFWYlp5eGRQdXk3RDFhUEdSMnpUbjVIc0FJT0t3TUwz?=
 =?utf-8?B?RWtMRUVYcEFkbnNZUm90K3VNYmFUT2crNWJCcWIyaEtJVWt4dXgrMVA0Nk9R?=
 =?utf-8?B?cHE0NXh3ajRUU0cwYmFRV0NqeDUyaVdxR1ZxZGpDT2YyZmtZak9wNHp4K0Iz?=
 =?utf-8?B?VFZ6cVdscUhLSEZuMWJ5bWdFdjUzdnV6MTh1VjMxMVcyRjRMOS9NTmVhdU1S?=
 =?utf-8?B?Ujh5SkphVVFid0RVc294eGNrWVByTE9CVVA1UWlLbkZXRktuMXhqSmdXR1FI?=
 =?utf-8?B?b0JrVVRGdGZ0MDJIaG93Z08xMnJ0cWFkaHAwMFg0dkMwYUdHWENaRHRKWXo5?=
 =?utf-8?B?bE5hOU52RkNwMWNNU0VBQVFsa1ZlbTNkbDFjSnZYWlp1dVV0UlRHbDdrZCtO?=
 =?utf-8?B?cHA4aGlIdS95TkdmQnBiZFhZL2tZSjMvSnVaV0IxTWZYQjhUQWhvMTQzVHlO?=
 =?utf-8?B?eVRxVCsrclBQQUlTQmd5dVd4bGc0ZFJodHBBZUliU1UvUy9qMjg1OTBtNmZw?=
 =?utf-8?B?TFRaMzdueXNHYWgvVGg1djI5U1VsSk01RlZvL0pBNVpObTJLT1kyODVHNmNx?=
 =?utf-8?B?d3M4TXhwVXhmMDk0ZjJ2MkpIcWptU1IwZ3E2MlZ4Q21MTDdjSUJmZ1BJWHF3?=
 =?utf-8?B?RStCc0RqLzFMcExzZkRrM0VXNVh4SkxVb2Z1S0lFYUtHUnRhbFBrNEdlR0JJ?=
 =?utf-8?B?UGhleStNL3JBQnNVcGRzVzNVTDZVNWxCMFRaclZ3MERZTmltZ0RXQjNiK3ox?=
 =?utf-8?B?OUNXcXhhOG5sWGJyTWdrSG9walVDMnYwMWNmR29oQjhzWDFjMnNSMHUySEN0?=
 =?utf-8?B?TU8wOVN4V0g1OWNnWG0zNnV4U2NKZHR4QmUrTlZBSHF6elhqV1NzMWUyUzNS?=
 =?utf-8?B?NVMzZk0yTS82NUJud3JoZ0dYK3dzTHZ6dFBqUmdNSjZYR3dSQVZIbDNJL3Vl?=
 =?utf-8?B?aFdmdHpDRFdMRVowcHNtTkhkNjQ3TVB2ektPWGQwNERjdnZXU3dVQVBiYTI3?=
 =?utf-8?B?dlgydXIzZ29WaGNTbWRVem1MYWE4aE1kQTMrZ3BuUDE4MVhpWnNsenRNdE13?=
 =?utf-8?B?Z1hkaU03NTFUdEprc0x6b1Y4bVJjOXZ3VEt4UVZUdUh2SW5zbFVtVUVqVFdS?=
 =?utf-8?B?MkFRWjBGMHJsWmJUTWk4WUxzRVhqcDlFbkpYRjJkSUNyWWdWZmlNS3FrVXcx?=
 =?utf-8?B?V3VlUWNuL0pOVjduTGNmZmNJL0RNL1VyS0RSMWNabDZhSnZGNmVNTVp2amFT?=
 =?utf-8?B?S1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F4A2E45E56F3548B037E03782987920@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9ccdae-62f6-4391-9173-08dc7f23e162
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 14:38:46.1190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+4cRvmaHISESYz3Vfve2MZ0Idmd+MXgOBNuNs8e+OXoiOxGf2bHi7F/8neRSY640RoQIvRdvJ3+ebQl6KC2rX80chqcpXPZezIvEgStVI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7396

SGkgQ29ub3IsDQoNCk9uIE1vbiwgMjAyNC0wNS0yNyBhdCAxODozNiArMDEwMCwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPiBPbiBTdW4sIE1heSAyNiwgMjAyNCBhdCAxMDo0NDozN1BNICswODAwLCBK
YXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gMS4gQWRkIG1ib3hlcyBwcm9wZXJ0eSB0byBkZWZpbmUg
YSBHQ0UgbG9vcHBpbmcgdGhyZWFkIGFzIGEgc2VjdXJlDQo+ID4gSVJRDQo+ID4gaGFuZGxlci4N
Cj4gPiBUaGUgQ01EUSBzZWN1cmUgZHJpdmVyIHJlcXVlc3RzIGEgbWJveCBjaGFubmVsIGFuZCBz
ZW5kcyBhIGxvb3BpbmcNCj4gPiBjb21tYW5kIHRvIHRoZSBHQ0UgdGhyZWFkLiBUaGUgbG9vcGlu
ZyBjb21tYW5kIHdpbGwgd2FpdCBmb3IgYQ0KPiA+IHNlY3VyZQ0KPiA+IHBhY2tldCBkb25lIGV2
ZW50IHNpZ25hbCBmcm9tIHNlY3VyZSB3b3JsZCBhbmQgdGhlbiBqdW1wIGJhY2sgdG8NCj4gPiB0
aGUNCj4gPiBmaXJzdCBpbnN0dWN0aW9uLiBFYWNoIHRpbWUgaXQgd2FpdHMgZm9yIGFuIGV2ZW50
LCBpdCBub3RpZmllcyB0aGUNCj4gPiBDTURRIGRyaXZlciB0byBwZXJmb3JtIHRoZSBzYW1lIGFj
dGlvbiBhcyB0aGUgSVJRIGhhbmRsZXIuDQo+ID4gDQo+ID4gMi4gQWRkIGdjZS1ldmVudHMgcHJv
cGVydHkgZnJvbSBnY2UtcHJvcHMueWFtbCB0byBkZWZpbmUgYQ0KPiA+IHNlY3VyZSBwYWNrZXQg
ZG9uZSBzaWduYWwgaW4gc2VjdXJlIHdvcmxkLg0KPiA+IFRoZXJlIGFyZSAxMDI0IGV2ZW50cyBJ
RHMgZm9yIEdDRSB0byB1c2UgdG8gZXhlY3V0ZSBpbnN0cnVjdGlvbnMgaW4NCj4gPiB0aGUgc3Bl
Y2lmaWMgZXZlbnQgaGFwcGVuZWQuIFRoZXNlIGV2ZW50cyBjb3VsZCBiZSBzaWduYWxlZCBieSBI
Vw0KPiA+IG9yIFNXDQo+ID4gYW5kIHRoZWlyIHZhbHVlIHdvdWxkIGJlIGRpZmZlcmVudCBpbiBk
aWZmZXJlbnQgU29DIGJlY2F1c2Ugb2YgSFcNCj4gPiBldmVudA0KPiA+IElEcyBkaXN0cmlidXRp
b24gcmFuZ2UgZnJvbSAwIHRvIDEwMjMuDQo+ID4gSWYgd2Ugc2V0IGEgc3RhdGljIGV2ZW50IElE
OiA4NTUgZm9yIG10ODE4OCwgaXQgbWlnaHQgYmUgY29uZmxpY3QNCj4gPiB0aGUNCj4gPiBldmVu
dCBJRCBvcmlnaW5hbCBzZXQgaW4gbXQ4MTk1Lg0KPiANCj4gVHdvIGRpZmZlcmVudCBTb0NzLCB0
d28gZGlmZmVyZW50IGNvbXBhdGlibGVzLCBubyBwcm9ibGVtLg0KPiBJJ20gYWxtb3N0IGNlcnRh
aW4geW91IHByZXZpb3VzbHkgdG9sZCBtZSB0aGF0IHRoZSBmaXJtd2FyZSBjaGFuZ2luZw0KPiBj
b3VsZCByZXN1bHQgaW4gYSBkaWZmZXJlbnQgZXZlbnQgSUQsIGJ1dCBJIHNlZSBubyBtZW50aW9u
IG9mIHRoYXQNCj4gaGVyZS4NCg0KWWVzLCBpdCBjb3VsZCBiZSwgYnV0IHdlIGRvbid0IHVzZSBp
dCB0aGF0IHdheS4NCg0KPiBUaGUgY29tbWl0IG1lc3NhZ2VzIG1ha2VzIGl0IHNlZW0gbGlrZSB0
aGlzIGNhbiBiZSBkZXRlcm1pbmVkIGJ5IHRoZQ0KPiBjb21wYXRpYmxlLCBzbyBlaXRoZXIgZ2l2
ZSBtZSBhIGNvbW1pdCBtZXNzYWdlIHRoYXQgZXhwbGFpbnMgd2h5IHRoZQ0KPiBjb21wYXRpYmxl
IGlzIG5vdCBzdWZmaWNpZW50IG9yIGRyb3AgdGhlIHBhdGNoLg0KPiANCg0KWWVzLCB0aGlzIGNh
biBiZSBkZXRlcm1pbmVkIGJ5IGNvbXBhdGlibGUgaW4gQ01EUSBtYWlsYm94IGRyaXZlciwNCnNv
IEkgdGhpbmsgaXQncyBwb3NzaWJsZSB0byBwdXQgdGhpcyBpbiB0aGUgQ01EUSBtYWlsYm94IGRy
aXZlciBkYXRhDQphbmQgY29uZmlndXJlIGJ5IGRpZmZlcmVudCBTb0MuDQoNClRoZSBwcm9ibGVt
IGlzIHRoZXNlIGV2ZW50cyBhcmUgZGVmaW5lZCBpbiBpbmNsdWRlL2R0LQ0KYmluZGluZ3MvbWFp
bGJveC9tZWRpYXRlayxtdDgxODgtZ2NlLmggYW5kIGluY2x1ZGUvZHQtDQpiaW5kaW5ncy9nY2Uv
bXQ4MTk1LWdjZS5oLg0KSSBjYW4gb25seSB1c2UgdGhlbSBpbiB0aGVpciBtdDgxODguZHRzIG9y
IG10ODE5NS5kdHMuDQoNCklmIEkgd2FudCB0byB1c2UgdGhlIHNhbWUgZXZlbnQgZGVmaW5lIGlu
IDIgZGlmZmVyZW50IGhlYWRlcnMgaW4gdGhlDQpzYW1lIENNRFEgbWFpbGJveCBkcml2ZXIsIEkg
dGhpbmsgSSBqdXN0IGNhbiBwYXJzZSB0aGVpciBkdHMgdG8gZ2V0IHRoZQ0KY29ycmVzcG9uZGlu
ZyBvbmUuDQpEbyB5b3Uga25vdyBob3cgdG8gZ2VuZXJhbGx5IGRlYWwgd2l0aCB0aGlzIHByb2Js
ZW0/DQpPciBJIGNhbiBqdXN0IHVzZSB0aGUgbnVtYmVyIG9mIGV2ZW50IElEIGluIGRyaXZlciBk
YXRhIHdpdGhvdXQgdGhlDQpldmVudCBkZWZpbmUgaW4gZHQtYmluZGluZ3MgaGVhZGVyLg0KDQo+
ID4gU28gd2UgZGVmaW5lIGFuIGV2ZW50IElEIHRoYXQgd2lsbCBiZSBzZXQgd2hlbiBHQ0UgcnVu
cyB0byB0aGUgZW5kDQo+ID4gb2YNCj4gPiBzZWN1cmUgY21kcSBwYWNrZXQgaW4gdGhlIHNlY3Vy
ZSB3b3JsZC4NCj4gPiANCj4gPiBUaGlzIGNhbiByZWR1Y2UgdGhlIGxhdGVuY3kgb2Ygc29mdHdh
cmUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuDQo+ID4gbm9ybWFsDQo+ID4gd29ybGQgYW5kIHNlY3Vy
ZSB3b3JsZC4gSW4gYWRkaXRpb24sIHdlIGNhbiBhbHNvIHJlbW92ZSB0aGUgY29tcGxleA0KPiA+
IGxvZ2ljIGFmdGVyIHRoZSBzZWN1cmUgcGFja2V0IGRvbmUgaW4gdGhlIHNlY3VyZSB3b3JsZC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRp
YXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3Vu
Z0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21h
aWxib3gvbWVkaWF0ZWssZ2NlLW1haWxib3gueWFtbCB8IDgNCj4gPiArKysrKysrLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21haWxi
b3gvbWVkaWF0ZWssZ2NlLQ0KPiA+IG1haWxib3gueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssZ2NlLQ0KPiA+IG1haWxib3gueWFt
bA0KPiA+IGluZGV4IGNlZjlkNzYwMTM5OC4uNmU1ZTg0OGQ2MWQ5IDEwMDY0NA0KPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21lZGlhdGVrLGdjZS0N
Cj4gPiBtYWlsYm94LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWFpbGJveC9tZWRpYXRlayxnY2UtDQo+ID4gbWFpbGJveC55YW1sDQo+ID4gQEAgLTQ5
LDYgKzQ5LDEwIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBj
b25zdDogZ2NlDQo+ID4gIA0KPiA+ICsgIG1ib3hlczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBHQ0UgbG9vcGluZyB0aHJlYWQgYXMgYSBzZWN1cmUgSVJRIGhh
bmRsZXINCj4gDQo+IFdoeSBpcyB0aGlzIG5lZWRlZD8gSXQncyBnb2luZyB0byBiZSBhIHJlZmVy
ZW5jZSB0byBpdHNlbGYsIHJpZ2h0Pw0KPiBXaHkgY2FuJ3QgeW91IGp1c3QgcmVzZXJ2ZSBhIGNo
YW5uZWwgaW4gdGhlIGRyaXZlcj8NCj4gDQpJIHRoaW5rIHlvdSdyZSByaWdodC4NCkNNRFEgbWFp
bGJveCBkcml2ZXIgY2FuIHJlc2VydmVkIGEgY2hhbm5lbCBpdHNlbGYgYW5kIGl0IHdpbGwga25v
dw0Kd2hpY2ggY2hhbm5lbCBoYXMgb2NjdXBpZWQuDQpDTURRIHVzZXJzIHdpbGwgcmVxdWVzdCBm
YWlsIGlmIHRoZXkgd2FudCB0byB1c2UgdGhlIHJlc2VydmVkIGNoYW5uZWwuDQoNCkknbGwgZHJv
cCB0aGlzIGFuZCBtb3ZlIGl0IGludG8gQ01EUSBtYWlsYm94IGRyaXZlciBkYXRhIGZvciBtdDgx
ODggYW5kDQptdDgxOTUuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBUaGFua3MsDQo+
IENvbm9yLg0KPiANCj4gPiArDQo+ID4gIHJlcXVpcmVkOg0KPiA+ICAgIC0gY29tcGF0aWJsZQ0K
PiA+ICAgIC0gIiNtYm94LWNlbGxzIg0KPiA+IEBAIC01Nyw2ICs2MSw4IEBAIHJlcXVpcmVkOg0K
PiA+ICAgIC0gY2xvY2tzDQo+ID4gIA0KPiA+ICBhbGxPZjoNCj4gPiArICAtICRyZWY6IC9zY2hl
bWFzL21haWxib3gvbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwjDQo+ID4gKw0KPiA+ICAgIC0gaWY6
DQo+ID4gICAgICAgIG5vdDoNCj4gPiAgICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+IEBAIC02Nyw3
ICs3Myw3IEBAIGFsbE9mOg0KPiA+ICAgICAgICByZXF1aXJlZDoNCj4gPiAgICAgICAgICAtIGNs
b2NrLW5hbWVzDQo+ID4gIA0KPiA+IC1hZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiAr
dW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICANCj4gPiAgZXhhbXBsZXM6DQo+ID4g
ICAgLSB8DQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4gDQo=

