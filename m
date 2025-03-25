Return-Path: <linux-kernel+bounces-574705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECECA6E8B9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A5C16A186
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE011A23BA;
	Tue, 25 Mar 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PYDsl9DV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hz6HUzLa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CE19F127;
	Tue, 25 Mar 2025 03:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742874309; cv=fail; b=KZgGsVNvpdCo7Gg6Aio9KssxRt8Sgg/y2cAjPijda1GQgaLUQcmLbJIO+kb+Lh6SyfliXM3kgwvTnv6xMhPcG3163SxeoLvHxlR+m5F9phH2ptZmuTJvmaWbBPq/0PzKdhfgayS2wb+pn7nzsJxJ3WVsBGWynb93bwzy64Npf4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742874309; c=relaxed/simple;
	bh=6QhqEuLKUttBh7A/w57jU+IrlNMIFAiC3qImyQnsNi8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FHlLVI7nELnZa29pCazg+lVvZ36SjPjd13sMREgTSv18w3C2tTP1MqPqmYXO0d+WjEiK9OCUbX4BP4Bs11RImkBGWSw6B0O7abbofDAbVbaNFq66JfgZBRxKBj801Jt1Smu0yOegxjHnZWtwuSo+yUv6+r9HHyOIoHQNMLCF2tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PYDsl9DV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hz6HUzLa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 885d05c6092b11f0aae1fd9735fae912-20250325
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=6QhqEuLKUttBh7A/w57jU+IrlNMIFAiC3qImyQnsNi8=;
	b=PYDsl9DVyAL4JdfcsQfYFckWUTvcrbNPbMzX8b/X3UgLdZfUJxfQpe2/jZqy9uMRZhIU8UhpX57Nv9yavwd7a+HqbsE7owvgZddLixBSiTBarlEQ+IE8RXmEHIO9sGDQefXfEugmgc5fh1IDrkBECxQ5z3G7NiVutoVKutLc3GU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:a8f475ae-0a50-4e6f-b56e-b7744d97fef3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:345b42a5-c619-47e3-a41b-90eedbf5b947,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 885d05c6092b11f0aae1fd9735fae912-20250325
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 539408014; Tue, 25 Mar 2025 11:45:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 25 Mar 2025 11:45:01 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 25 Mar 2025 11:45:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+gHu6yZq5LOxozveG6gljqlHpTePp24y8Rcmvhc9aL5ztMijUHIreErDH6/SvF+sKT3iKXGLMxjeY8NCWYYolY4Gr4XV5bcntbtLg/gY4i5J7H28uMw7S+NiaChbW3VzNAmdgV6ROCBBZyKuu50z/hnna6JfJuIZ0376e81MukMEblSGQUTBg22CviiVb0jPNsc1Ptu5WqYVU7H2xqMx1KyVK6nG3jMldus7AqWFGVzfthXxZtlGm97p+UH9kwCBSas1O0bKzsKuCCEXqbGJbWHusaBot94LQMKrRUIr3lYv8CJC4dMjGqmx242dlijVCaPxxWdH6e5EiA19avVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QhqEuLKUttBh7A/w57jU+IrlNMIFAiC3qImyQnsNi8=;
 b=svcnoSjzYV5kkT6V6AEGe7lVcIiRKOMAP65ZcSzq4F9def7Bspd32s4aOjk3CU0jRBxQUm6pBv7YWvMddSFaK+BR9raPxizjeUMbKFDOmB3iaAWzSAZ1C6ySQv5xh4h0zGAPgXLSkzBMrBB9+E0lRvdyNTLgDaaLOuMSNbx+cN3BWwkr5orTONSrKsaJyhKBN9HAEV2hEATvreXKKuAQF9vlVA8QUHbHdp2c9YQ7M9Mu3YmxSt0YlGkZHxeKZ3QbGkJhSYhnhkW74k92hD9ksbTo4BKDL9/iMHxIDiFr4JGACFJcKKXZQFgMZJIYem6ZW0meT69sCLY5c17xTXMKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QhqEuLKUttBh7A/w57jU+IrlNMIFAiC3qImyQnsNi8=;
 b=hz6HUzLaI4hhxLYXTr8ayHylQS3BrRA+H+GrFCsEl0M9D5l9Dq6g6t5oWIh4TTryYaUURI6xwXRmDiTdRMtW0sq1704bm9btYCwbX9Lm+zOUxgPcO1a9aTkbvmFWjJDzYASVHU7AIZrxvGEBM93MPCZo3UIwZ5fhDzD9xZ9eOWM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8114.apcprd03.prod.outlook.com (2603:1096:990:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 03:44:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%2]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 03:44:57 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, =?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?=
	<Paul-pl.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: =?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>,
	=?utf-8?B?U2lyaXVzIFdhbmcgKOeOi+eak+aYsSk=?= <Sirius.Wang@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?WGlhbmRvbmcgV2FuZyAo546L5YWI5YasKQ==?=
	<Xiandong.Wang@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"fshao@chromium.org" <fshao@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "treapking@chromium.org" <treapking@chromium.org>
Subject: Re: [PATCH v2 14/15] drm/mediatek: Add support for multiple mmsys in
 the one mediatek-drm driver
Thread-Topic: [PATCH v2 14/15] drm/mediatek: Add support for multiple mmsys in
 the one mediatek-drm driver
Thread-Index: AQHbmkTnuu+CU41xcEO57FT6lx/4Y7ODPAIA
Date: Tue, 25 Mar 2025 03:44:57 +0000
Message-ID: <6bf9d4b3e060461ec491a3703d7ba952f9c5dceb.camel@mediatek.com>
References: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
	 <20250321093435.94835-15-paul-pl.chen@mediatek.com>
In-Reply-To: <20250321093435.94835-15-paul-pl.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8114:EE_
x-ms-office365-filtering-correlation-id: 69f01f65-eb57-4e83-0c59-08dd6b4f6971
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?T2ZVZGFObzhVeC9NaGxjUndPTFpHU1FRWVdjUGlBY1hwcTZxemdxS0Z4YXcr?=
 =?utf-8?B?NTBQSSsybnM3cVQrZDNvc0wwY2FmcVZDL3BNT0FVS1RsZWNEbUk2WjZIcW9U?=
 =?utf-8?B?cjNaQUw2ODZWakNiaG5IQ1FZUm9GSEx5YlYvMHhTWVI0Q2FONXFrOGJkZVlT?=
 =?utf-8?B?Q3hST3psUXhMZ1Fib0t4aUU4enJwSjBxWkVFYTEvV2FjUEFWYmFQcis3Q2tE?=
 =?utf-8?B?RWVuR2VnR2ZuNUtSbzJvRUx3WHZZb0ZGS3VXV2xIR2xJcTdxcCtDZWtmenc3?=
 =?utf-8?B?U2pMTytUYnovYlFtWG0wUkJIaHhYemxpaVZuWjRrdjQ0dXNTcGRxN1hpS2pw?=
 =?utf-8?B?VHBXelg0VjRBSkRGOEM3dCtLL3V0d3c2cm5IdjB2akxSd1ZNZTc5SkxoeHh1?=
 =?utf-8?B?bnRsTlpPejRERmtscXJya28vd0x0R05YK3NGb0sxL2VkM1Z1WmdUeDVwNG51?=
 =?utf-8?B?NW9JNkNqWlpLY3hVQW5kVVM5YnIxWUlrcTlsbjVhK21zWjlrY3RBV1lSbTBH?=
 =?utf-8?B?NmhDYzBKbjNvdXpLMUE4dm4xUmVzcWtNL3BuVTZjekJKRnZ6YllqcjNmRHUw?=
 =?utf-8?B?NEpBU0h1MlM0dFBCL280UHpKOHBNbXRiM3I2N2tKd044anhrWnk4V3BvUEFM?=
 =?utf-8?B?TlZkYzhuZTNNL2NJNEtuNjlxbVlaUDRhYVdkTkg3SlFGSm9BRUE0KzNGSms2?=
 =?utf-8?B?YVZwWXZxNGh1TzcvSXlycEZnYTN4RUNhRXo1VGZ0Wmw0djJKM0wyYUpNZkFv?=
 =?utf-8?B?bFhmc29tSnFGcUJ4ZElIWGsyRTExbVdiTVI4MFdEUnhsNEJjNnVYZk9jY3ZO?=
 =?utf-8?B?dDVJV1RFSW16c1RlMEhqMmtVcTBMcnI4Skk0ZGNHTjY4N2hIaDR6QXB3dVg4?=
 =?utf-8?B?eFh0RDdsc1pTZEIydVNUWkRaZUJ3K2pnRllTYVg3bHRYbXpXZmZlU1BtNXQ4?=
 =?utf-8?B?ckJkTDk4UThwSTB6V2Y2K0o4ZktZWThSNjdYeDNLWHViS1RDeEV1b2h3NUFC?=
 =?utf-8?B?emwxUDZiL1hJd0R2QWF6ZjdmQktoRUl0WTZydC8rTC9KL2Y5Ly9HSUZ4M3RI?=
 =?utf-8?B?N2tIb3QyWTJLUUNsY2tKM2grRFM0cGVtbXRkaEZhMzBuL0lSK0g2UngvRTJl?=
 =?utf-8?B?TlcxNWR6REthNW1ZdFkxL09EUFZ3UVF1VktGb3lydmoxV1FOL2MwL1duS1ZV?=
 =?utf-8?B?ZzUxbTlKdkZxeHhiL1AxZnlWRmNXRGJoQTYzQ0VOeGJJTjJGeDQvQzVGWjhP?=
 =?utf-8?B?c05Pb2drTVRyY1BxSlZRR1g3cTRmcW1ZNTgyZGZoRTAyTVNwLy9WclJIbFhY?=
 =?utf-8?B?SFg5dVdQbE8wZDFtOWVQaXV2cjJTczZDNFBIUHRTVmpocElLUmxZNDdKaWli?=
 =?utf-8?B?dWZvZ3NEOHZwTHluQzJYZU02RXh0UUxCK1BtVnZTRXBWdC9mUDZseThLNGRh?=
 =?utf-8?B?UHQvWFB4OThRaFRpRDErNy9pd1d4NisrNk5hZHRSNlpRL3VCUlB3UFozY2N2?=
 =?utf-8?B?ZkFQV1hILzdqUEtDQzRnMTFYaXdGZldJNHhhMEIxVUlxUEZoQ3JiTEZBVFY0?=
 =?utf-8?B?Wit1emx2TmppaHJEV1ZkT2pNZXdRdmM1d3hlTHhuR29YYUVkcVFMN2FFdjNi?=
 =?utf-8?B?TWt4RzFRZER4TTZqV2pVMUo0dy9kS3ZSLzliTmtqRTIyRmpvV2VIeVhQY2hC?=
 =?utf-8?B?SXFCcVVHNTRDZHk1djJ5c0hKVVRJcW1hSWF2bEp4V1BtREhEYTMzMmhiTE5u?=
 =?utf-8?B?RW85ZDlNbGFMMlBSZ0NTcTlGeEhPQjlIbVZ3cWVLNFdZQUkxTWdDc2RLcDNV?=
 =?utf-8?B?akIvSE1wTUt0SmRzbFhXMFl3QnBGZFVxUGUvVXdkcDN4Tmg1c2pKVGMvU3V3?=
 =?utf-8?B?ODQydFhMLyt6NEdlSnNwbE9HZDM4ZEpQN1NkTlNpVVR1QTZwWGN6WnNJMXBR?=
 =?utf-8?B?QlpESHhtWXl4RUJ4T05tOURCellkYmhwc0JGUVRpTmNHQXJ6VlFlbWZ1Zmk5?=
 =?utf-8?B?Tm9tWXRwVEp3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjR2b2lSYTlvQS9XZUdjWFBDUWxGUXk1Mk5vYU5NR1BDTTdFMm14ZlBaT2pj?=
 =?utf-8?B?REUxWmk0ZkhzNlBuOHNGMUo4dVp0aUpiNWx1aEpwVUVxTXI3YnhEcnowSGhU?=
 =?utf-8?B?blpDQUEvaXdqNEFVaVhGY2NqUmtpOFdBZ2NwR1FXY2VuMTlSSVBmVDN3Z2pD?=
 =?utf-8?B?SVJSNVQxeDQ4NktLa0J6eSttendkaUU3b0EvV2FjL1dOR2c1WmxDSU5sREZC?=
 =?utf-8?B?OElLVTJuS1VkV05BZG1PYnU0MmtiZHdYcS8ySk1WOW01dS9hc2lrSVdpNUhX?=
 =?utf-8?B?b0lqaVk4QUtsanlLSXUrVENYVHZJalRVVXhoeCtHQ3BIVzMyeSt4RG96ZWNw?=
 =?utf-8?B?VWx5R3pVdVplZkJpODQ0V2p5WFphWjg2WjBjMVJnamU0MFB5Nm1vTzJ1WlpV?=
 =?utf-8?B?KzVOVy9nb2QwMGpGa2pPTW1pcDI4K0RLMkUrNXpLN3Z5T2hmUTY2UWRkN1or?=
 =?utf-8?B?b3RZRWxtQldMMVdaNm5ZTkxYNzhZcUZJVGJFTHNTekhUSEZwSFAwM0xWUHdS?=
 =?utf-8?B?NzBXc3VMY1Y5dlkrV0VoMmgzVEpuWk9ZUUl1QXFzT2QraURFNFlpU0ZuM1JO?=
 =?utf-8?B?YjRPRXMzQXY5MEdOdkhGYWZhZTRNZXVwY1VLYlpiUlhBUk5WOGdibEtvWTFQ?=
 =?utf-8?B?aERyV2VFdkljblZ2UHMzN252RmVPd3FoZHVYNFNHRFBmKy9US2k4cHVLWVZQ?=
 =?utf-8?B?TEg2L3V5QXlYWWI4MmZnU1ZscEVDL1ZqVVczVHJMazFOd2UzRTcvSW9VbURq?=
 =?utf-8?B?WUtNWjhoRzZkUUZoVnlEeVFOKzByaVBzcnZ3YlFoS2NlL2EvK2l4clNheVpS?=
 =?utf-8?B?K01kL0JFc1NoY3l0azVrNS9PV3AzRUo1Q3gyM1lLaFdySUxLOFkvTUVLRGwx?=
 =?utf-8?B?R015eGZrUndpMU5WZ21yVSs1Sm9odUhJUml0S3V3OWgrTjRNdzBta2dyL2oz?=
 =?utf-8?B?M3dZdDl4QlR6S25PM2JENkNKQlFVMFA1bHNlWVE4L05UaU85UjdNOGJDR1RK?=
 =?utf-8?B?eFdkN3NPWHhnMjVrR3V1dng4VVhzSmVWb1ZidEhQUngxY3FMV21zUTdhOHJ5?=
 =?utf-8?B?SUJldlFSd2Y0aGNscXpyYTBvbDFDeUl1MWJwMHpKU0daVmtzQkZaN05OZk1q?=
 =?utf-8?B?SjJCcDl1ZFRNSlR6WVY2bEdza3ZaUktRTDMxZkN6OS9jeVFHdWIycDh3Tnlz?=
 =?utf-8?B?YnJGamJEQTJ3WTVDQnhvckU4NWFBdHFTOVIvc3hxSklkb1hJZEt1VThxa2Rk?=
 =?utf-8?B?VG90T3hmc0hNTytIdklCY3hteVJ0WHNEelBaUzR0bUlQR3JVcmV5ZlBHVWVU?=
 =?utf-8?B?OE50VXhYMDBabnZqRnVadGJLMkxmRVpkSHorU3JPZG5JVDUyYWFZdGV3TjBp?=
 =?utf-8?B?T1gwbm44TG5MVTR3eFZrSUQ5a252K3h3ei9TaEliaFRxemhQcE43ZlloYS9s?=
 =?utf-8?B?OW1Kb0M4aFdnT3c1ZmZjNHpYdWhMdmUzSDdVa0NwbkVIK1BaRSsvcjQyU05v?=
 =?utf-8?B?ZUdyM3M3cDhzemFsRnVjQ0RKQjBZa2UyZTFIY1FjanFQajRDaGVxQVNoNEZt?=
 =?utf-8?B?dzZKd1J2cDBLTlJEbm5pdEhKbFhTTWdmcWNzVHRtNUdTdVJ1K1lkdURKVCtD?=
 =?utf-8?B?bXBXTTZjNG9sdFZFQnFKSHIrUjBKNU0zVmdTS3hrcHdyWkMxMjc5ME1tVU9M?=
 =?utf-8?B?cDZkbG9aWVdHVjZSNWgrZlRFb1RCTkxGVTk3MUQwMit2Z05ORDlueEVreW9Q?=
 =?utf-8?B?TG1ZaXpFR3EyVFJuWGxteUZpd0pteUZXbjg1Vk8zbDZIdW81S3ZvNjIyRHZ1?=
 =?utf-8?B?NkRES0VBT28zK3B4cXI5bTQ2N2ViK3RabzhSNTg1NVZBSHhqd3A1YzNtc1Nr?=
 =?utf-8?B?M0paSWpFeXkxNFRTc1VZTktmN2I0WVBRcE9rVEgzMVNqZGJQdEN1OG0ra3dR?=
 =?utf-8?B?R1BWdEc1SWZoYjUyK2V4MURuUE1kZVJiaU52YmV2elA0SFcrWkYxK1hxU1ZG?=
 =?utf-8?B?K245SUthdi9uOFV1S213MUVQSjVlVVc2SE9jNHZ5cTRNclF3NjMxVjRVTHNK?=
 =?utf-8?B?VUpBWGU0NnlpQWNQQ3hxcUpLRXVTbTlVbzZrNEUyWGU0am9tUjczdlFiaUNY?=
 =?utf-8?Q?tq0h6+sfwdRmgKT/ledoi+BBp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEA13BBA6F2EF140B4E1C9AD7F26DF72@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f01f65-eb57-4e83-0c59-08dd6b4f6971
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2025 03:44:57.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXOjdbHd7rytpj5Zj2v5FDumOrRCdcqyMg0XLhxH5/QFiPoRt62dEdSfFYWlu1EQl2jCGo1sqqLMyibZF+FUkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8114

T24gRnJpLCAyMDI1LTAzLTIxIGF0IDE3OjMzICswODAwLCBwYXVsLXBsLmNoZW4gd3JvdGU6DQo+
IEZyb206IE5hbmN5IExpbiA8bmFuY3kubGluQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFRvIHN1cHBv
cnQgbXVsdGlwbGUgbW1zeXMgaW5zdGFuY2VzIGluIHRoZSBvbmUgbWVkaWF0ZWstZHJtIGluc3Rh
bmNlLA0KPiBwcm92aWRpbmcgaW1wcm92ZWQgZmxleGliaWxpdHkgYW5kIHNjYWxhYmlsaXR5IGJ5
IHRoZSBmb2xsb3dpbmcgY2hhbmdlczoNCj4gDQo+IDEuIEFkZCBERFBfQ09NUE9ORU5UX0RSTV9P
VkxTWVNfQURBUFRPUiogdG8gcHJvYmUgdGhlDQo+ICAgb3Zsc3lzX2FkYXB0b3IgZHJpdmVycyBh
bmQgc3VwcG9ydCBkaWZmZXJlbnQgbW1zeXMgY29tcG9zaXRpb24uDQo+IDIuIEFkZGVkIG5ldyBj
b21wb25lbnQgdHlwZXMgTVRLX0RJU1BfVklSVFVBTCB0byBzdXBwb3J0IHRoZQ0KPiAgIHJvdXRp
bmcgdG8gdmlydHVhbCBkaXNwbGF5IGNvbXBvbmVudHMuDQo+IDMuIEFkZGVkIGFuZCBhZGp1c3Rl
ZCB0aGUgZXhpc3RlZCBzdHJ1Y3R1cmUgb3IgaW50ZXJmYWNlIHRvIGV4dGVuZA0KPiAgIHRoZSBz
dXBwb3J0IG9mIG11bHRpcGxlIG1tc3lzIGluc3RhbmNlcy4NCj4gNC4gTW9kaWZpZWQgdGhlIGNv
bXBvbmVudCBtYXRjaGluZyBhbmQgYmluZGluZyBsb2dpYyB0byBzdXBwb3J0DQo+ICAgbXVsdGlw
bGUgbW1zeXMgaW5zdGFuY2VzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmFuY3kgTGluIDxuYW5j
eS5saW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYXVsLXBsIENoZW4gPHBhdWwt
cGwuY2hlbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiAgDQo+ICtlbnVtIG10
a19kcm1fbW1zeXMgew0KPiArCURJU1BTWVMwLA0KPiArCURJU1BTWVMxLA0KPiArCU9WTFNZUzAs
DQo+ICsJT1ZMU1lTMSwNCj4gKwlNQVhfTU1TWVMsDQo+ICt9Ow0KDQpMZXQgb3Zsc3lzIHN1YiBk
cml2ZXIgY29udHJvbCBPVkxTWVMwIGFuZCBPVkxTWVMxLCBzbyBtZWRpYXRlayBkcm0gZHJpdmVy
IHdvdWxkIG5vdCBzZWUgdGhlbSBhbmQgdGhpcyBwYXRjaCBpcyBub3QgbmVjZXNzYXJ5Lg0KDQpS
ZWdhcmRzLA0KQ0sNCg0KDQo=

