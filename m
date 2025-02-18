Return-Path: <linux-kernel+bounces-519399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A2A39C68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4E3A3137
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133DC24E4D0;
	Tue, 18 Feb 2025 12:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="f2aZ9BER";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kulVkc5M"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E342B238D25;
	Tue, 18 Feb 2025 12:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882694; cv=fail; b=QP2pvuysPRmzmqvjhSEYFwVte9zhrfgfz7XvS0ZentNzk+gyaYDA0Y2u9ELOJbrhXk8XCY+HV2KOXJ5xqkVhAheRW6DiNMPQT9lZ49k3/t7zFtIpFctyRQRcdm3q5YyGGsPB+KCIlRmQ6QJoiyWWeV65KNmqpHAykR3XM0JJ/VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882694; c=relaxed/simple;
	bh=mhmPI0StMZthEU5IINqGonEf4cBVQkwXzt4yEYWNIFo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NIl6GwMZMOvxBoFFbB1GxgH+/sax70lDNkKxIBlPz6zDM4saW6WqQNIlUrHPsPstyzPG4F+rwklvzb3Niqw2BFIsNbTLN4gGnIyO/UEN0YKFcaZ0hSlqit8Z58aY1Qw/SjR//AOPDb2D1H6VgXO1vClMD5y23OhtZjNAC8FBmVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=f2aZ9BER; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kulVkc5M; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2193e4a4edf611ef8eb9c36241bbb6fb-20250218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=mhmPI0StMZthEU5IINqGonEf4cBVQkwXzt4yEYWNIFo=;
	b=f2aZ9BERwxtt/4GFVyXiglwJNSKOCag5b0KgqPKb/Oq44pMTFmBJLNjld+wQnvzibQ+U3DyALdW748Bcg/3fcLdQCdlmbLqRuIkbHeTfIm38d92P3P0BhWA9MBKAC3dnG9Jl+jCjf5ksf0arYAzpgx7Edr05g8U1+w02sxSOJqI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:dfdd3e70-67d6-411d-a3df-9aae9f76a782,IP:0,U
	RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:3
X-CID-META: VersionHash:60aa074,CLOUDID:b3ff46b5-a2a1-4ef3-9ef9-e116773da0a7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:4|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 2193e4a4edf611ef8eb9c36241bbb6fb-20250218
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1529170732; Tue, 18 Feb 2025 20:44:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 18 Feb 2025 20:44:44 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Tue, 18 Feb 2025 20:44:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dC5KEwMhN24eqs6V+KRpwtmGhcoBXkt/FAFZ+AoVM4yjEJt7MlCqcU6pjZ2dmlS5zhypgkF8+ajuFVj3iAS6Ogwn2XnscRtVpIAg8Qrk2LqfGU/1BTDxEWWRE/N2VaxDoEn0sLupWX7vYtFvScFNuKemeASsBdBdXYw0tN3fCeJUjMniipV5QFsU8M3i57bAYi4+rXUlSxF5pN62dNIksVz+bhVgtxsVVfPI8LwPI1Bx4Mjgi1MpQU2DCJ441DfzZ/el28hLhUgfIKqGuA0FPVHRQXdXV4Zd83j6BiuPzpLswJEdFoRfaFinVSWWR9Di85uQnbYHAVI79sXkhwQVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhmPI0StMZthEU5IINqGonEf4cBVQkwXzt4yEYWNIFo=;
 b=UISLa6a4/5rA9h7z5LJGiQ4BSByhVsjarymVC+QHpiSKN8kg0b6T1DnshdCpoaQr+JnIqODnCc42IhngAEPwx44Y7gBs/lF4PA4ZY8eqjv4pnx5BfkcOKt4eSZt0J/Xr86/y3LdfZp1hDO0xqlwd9mTZqFAA+yvaUoIxwItxEXZ+Azfgy8ubd876pFiVIDJfqAQdzYki2wjqPw99jYvtWoS1/oc0W3XFS8zaoTsf1wwkBS+6nA+6rsMMH35jOgFItCwYlwdqkLEuUfpqhDvZ+qRybZSP5AzHaW/GG6vpCh+CoyXdUYAB//UNcdVtijzJBUOs0PgyUgUVr1z6GwnLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhmPI0StMZthEU5IINqGonEf4cBVQkwXzt4yEYWNIFo=;
 b=kulVkc5McsQFxubrucio/etCmPTG+GZ9FavktAsByJoBY0OuyeuB5CQkrTvsQisC46uxM9XGo/7bGSsK4WmXEtsEXPZaMRr4bWInCL2bU5KAlN74LQCVZvxBqL08S11CYNRhT3VYJwLJGazmmtotg5B+e9mXUCIkkzF5wqWHxAE=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by JH0PR03MB8601.apcprd03.prod.outlook.com (2603:1096:990:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 12:44:41 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%7]) with mapi id 15.20.8445.016; Tue, 18 Feb 2025
 12:44:41 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"mturquette@baylibre.com" <mturquette@baylibre.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?R2FybWluIENoYW5nICjlvLXlrrbpipgp?= <Garmin.Chang@mediatek.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: mediatek: Add SMI LARBs reset
 for MT8188
Thread-Topic: [PATCH v3 1/2] dt-bindings: clock: mediatek: Add SMI LARBs reset
 for MT8188
Thread-Index: AQHba9Dh6ozL/EN8bUaPBva6nm3iOLMhfKuAgADtcACAA8nigIAm+iEA
Date: Tue, 18 Feb 2025 12:44:41 +0000
Message-ID: <85c616dd195da26313cab552b24f514b539193c1.camel@mediatek.com>
References: <20250121065045.13514-1-friday.yang@mediatek.com>
	 <20250121065045.13514-2-friday.yang@mediatek.com>
	 <20250121-violet-widely-df3567b085a4@spud>
	 <2bfb6c05a3471e54f51c06895709853661e82c9a.camel@mediatek.com>
	 <20250124-aide-feisty-821cf9cf1382@spud>
In-Reply-To: <20250124-aide-feisty-821cf9cf1382@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|JH0PR03MB8601:EE_
x-ms-office365-filtering-correlation-id: 10514541-8815-4dd7-c43c-08dd501a037d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Wk9KQS82bDlGRXdZeHZSekR0K0hKbDRuWE1IWmFLOUZuaHQvdXZGcGZFSEtP?=
 =?utf-8?B?ZDV2YzRvS0IxRFNKL3AzR3NPQnJqRGFSZ3BmVmdNbFBYT1loVUNJSEU2ajNJ?=
 =?utf-8?B?ZkV0NCtFdGJPWGlFNEpDOEN1TVBHOWdkSU9hV3Q4S1lUWXUvN293OW1tNkU3?=
 =?utf-8?B?YVl6UzArL0VualZRRFJmYjNhdFRESk9FdVhSTllpWW1rZ1Q1YjRyblpjVWkw?=
 =?utf-8?B?MkloQ2xqb0pidUJyM2tneVVJQU9tT1VPKzNydU9paG9TdCtWZEs5ZXZoRVBI?=
 =?utf-8?B?ZDdxKzR3RzROeUNDZDd3Ykl5QkhHM2JpOEpJNC9ZeW9QUWNxaDU3SWRsOTVo?=
 =?utf-8?B?VEZYN05WUnZEWXRFSnQzS05lalhoUVZsblNGYzN6TkozeEJsL3hDb0J5dTgv?=
 =?utf-8?B?b0psUHo4TSs4dUVSZTV1cXkxQm85R2JmNEVLSk9sRWpNcEUxa2hVMDFQSVVR?=
 =?utf-8?B?K2JPUldvN2R5OXR2OG9IQnpnOEtNcjZvNjNOSC95QVBKTHFOcXZYdHV6M1oy?=
 =?utf-8?B?TG5iNzJ3M29kNm5td25uTVQzRFIxMVc2bUZPNTU5bm1ET1p0SHBKcjNOazNv?=
 =?utf-8?B?cjduT2tqa3NMQUJqei96SU1WcFZNaktwandGZmYrQ1p2VXZTQkZyVVdIN3Np?=
 =?utf-8?B?S0hWTWtnY25heTNGc3dVZi9kbGhhaGw0UTZlK3paam15eDZoekxqbC9aU1dQ?=
 =?utf-8?B?N0VYaE0vV1kxTjUralhaNlZvZTQ1NWl0RWZqN2dzVEZxNUx3TlVyQXE5bVNm?=
 =?utf-8?B?Y1RVWFo4NkpZdExhZkdBWkE0TFV4TjF6VU5yVkM2SFJnM3M0OWFNQWtrK2NU?=
 =?utf-8?B?TVBjenRENlIxZXlZbVpRK3JWaGk3cXV0MGdwekp1OGlpeEY5enltemZmTEt4?=
 =?utf-8?B?azBSQmREMUhoSUNWRUNvSFZ6cTVzaHBhdG5CTUV5Ulp1NlFPMitOTDhqUnZF?=
 =?utf-8?B?NUp4bkxVMVg5cFZES3o0V1BVWGNTenkxOXkyM0p4RWpUQitIZ2t0TW5IWGFm?=
 =?utf-8?B?SUVvV3VsYjlvdlZlNG5CZnFXRlF3eHRvMnJhUFAvUjBhajhBTWdORnp2M1VQ?=
 =?utf-8?B?cE9SMGQxYUtWb055ZmszUWVyc0hoSkJabUNiSGlwRHVZNVJoSmltKzBXN1Nk?=
 =?utf-8?B?YzJDOVNWOXNyNW5DUmRqUkdLOURaQ1YzWW42RUtFd0hTUWpSV01KclJ5WU0r?=
 =?utf-8?B?ajdQdEMzbG1VLzV0N29uai94T21XL1NqSEUxWVpubk9pUWhORnczKzQyMUQ1?=
 =?utf-8?B?Nzd3cFU3NkQ1MXg2N1NoMjVzTEZzYlpJNm5DNlR6ZlI5bE9mY0hjSWhBQ3Nu?=
 =?utf-8?B?dmNiK29aRm4xUmZDdk5mL0tqWWQ3Ujh6Yy8rSmhJZElwQ3orVzJQa3UwYzM2?=
 =?utf-8?B?MlRXUkg2QTV2a3ZOekh5TFBwQTJ0aHJvMzR6VlJrNnAza1MyamNITnl0bkNS?=
 =?utf-8?B?MldhWEx4S0ZlVzF1OUF6S0NJUXFxZE9zQ29UdHllY3ZKY2NSbEdiSkowMFk3?=
 =?utf-8?B?UlkxS2tXMmpTSFk0RVpCME5pWkxvRmRaa3drMlMxdU90RUlvMU5pRXdyMDF1?=
 =?utf-8?B?ZXlmQ1duWkJlYS9SVlAyQmp5bkN5bkRHSnZWWWVoRGNISm1nU2lXN3BLNm5R?=
 =?utf-8?B?T2VWNDdWRlBpVXRFckw5bmNTaVdHNEU0NFpvZ3E2NkVNQlJlTU5rbGtMVm4x?=
 =?utf-8?B?djhJZ2l6SXRQQWJIZUp3UDdkY1hTbmhpRmhoL1NuTE5XcHlGbTRPS01OcGMx?=
 =?utf-8?B?MkthRU1vT2MyQnhwdWN4YldVbk1NaXZFem1maWtvKzlwcW84cllGTDR0OVlH?=
 =?utf-8?B?MHptWVl5T0JOakUzSFN1K3R1T1VtVlp3ZXhUanlQRVFwR3FyVlZzeDAvSWU4?=
 =?utf-8?B?U2RiVFlkdXFINk9VUHczTUdJM0xQdVlMR00ybkNWWGYzU3dWKzlZdWMxSSth?=
 =?utf-8?Q?DSTP2mTjNzJizxgPWpE3u7jw+zp76gcn?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDNZa1ppSGJNQkx5TjhULzlnVlVkdEROUGMxL25SUUYxbzhGQ3RKSGxrTzNV?=
 =?utf-8?B?M1dadng4R2RJVHZkbDJrTDNmVHhZUEtxY3I3c2dNUGpJRkdUbGlTNVhpTWxR?=
 =?utf-8?B?d29KSTFiZDdLWDVzcE1iWGRWeUttZmoxeDNXTnVTSnFzS3NSMTdnOXBKS3Ro?=
 =?utf-8?B?SGpaaktJODM0dU1DamhNSFBRZkphMWZZVzUwaTJUV0Ird2VlL0lML2lFdWRy?=
 =?utf-8?B?SEd4clVlMytVNDdoSjkvNXpJVXJGeExNYmpTcFlOeWNMRVNaT1NHTVN0SjUy?=
 =?utf-8?B?VmhHNEJkK0JYTVlNVE0rZW1CTWZkVFV4ejhFblNPTisyY3dLUjQyQUZCR1p0?=
 =?utf-8?B?enpuVFVtTmZERzVnTHVBRlJGblhLTGtlbHlDamF6MTNqaGhoeUFsckozd3FP?=
 =?utf-8?B?SjU0U3Jna01iTWZuZEloRzJoM29HNXA4NVp2eW5BRHdLYWhNVUV2djZjY1V4?=
 =?utf-8?B?c082ZUM3MUJzZHJnQ1RvN1pRMndBdEpSNEVONnFGVlQvQmJNbFNDMm96TzIz?=
 =?utf-8?B?VFkyOXpCaVlJVDV3aVpIeDJndlRqMGw3WTM5Q3BNQmdTVE4wMUdiRXgxNHMw?=
 =?utf-8?B?ek5UMzBvZXZZb29FMTNJNTFoaXhha0NDWFNUdUNYL3pjRmowY25oZko0ci80?=
 =?utf-8?B?VTBvTCthY1haVVlOTklpOG1PODdNM0pMM0cyNE9FZGphQ1J2TmRneGRoZlBV?=
 =?utf-8?B?bkxTVld4bW93aEVlaThaWCtpL2pYNTAzVGQwSktHRXVIR3RNUERTUktNN2Z3?=
 =?utf-8?B?QjY4cWVaQXRWUmN6V0UreTkvWVhid1ZjOFFBV0ZEUTh0RnF2TW5Ic0MrQmlL?=
 =?utf-8?B?cjJzWXFVendMYlNBRE5ZTVkxNlFvWldQZnhSeHBqREZTVkt5YUdLZmh1Ny8z?=
 =?utf-8?B?dDZHOWI4aktGWWZOazBhdWprNlNKc0sxcTNiNWcrODdLcktJaGkxL1hYNTJY?=
 =?utf-8?B?bUVqaE1ldUs3OEtZYjFvRVJ5Q1pxd0EyT1J1cGNBWjJFQXhaQzFEWGViTEVI?=
 =?utf-8?B?aTRkZjZ1bWpaekpjdjZ3dGwxZXp2N0c5ZWNnSkd2RUdGUUlJMzFRYWFCZzFT?=
 =?utf-8?B?aUlqeStweTJmbnduRHZacWlJMDN6U0Z5dFB6Tml5QUV2TGtYbUFHbGFES2FZ?=
 =?utf-8?B?cWxjSVdGZHBqNHRVVVdSaUVuemRpL2ZkcGN2ZUUvd2E0T2JES2tPN2E2OGZM?=
 =?utf-8?B?ZzB6U3A0MFQ5b2MxbXhkTTNoeFZJUitWREZxaDRxTU82elI3MzNoUHFsVE9p?=
 =?utf-8?B?WnN4SExBTnpCbmZHdDNCaTE2WTREdXppZ0ZPY2RrdXZYbGlPL2xmcElnVGxj?=
 =?utf-8?B?T2tobHF6d0QrS0VVaENVQlRFMkREWDBGaW9BMFJyYkhzMkVQdHdVQ2RSY2Rl?=
 =?utf-8?B?VTlCZmdNRzhmM2grMEVGV2h4RkhqNlZxclYvcm9SeTdQVVVBaDQ5R3RlOVpt?=
 =?utf-8?B?SG1IS2VJSXZWamFqWXhidWZEWDA0SlJPbkpvOEJkbytmd2ZnMjZIcXhBbDZU?=
 =?utf-8?B?WG14WXNnR0U2eU1tMCs3ak90R3R6Q1BiSmZmNHVJVmZqWEx0YndMWVdvU1dz?=
 =?utf-8?B?by9BZU9ZTE45VzVaSGgzaFVaOUhTbmVVRHZRWklkQzlldzcxSjlsSm1ieWNX?=
 =?utf-8?B?VTRDc0YvWHdUakNBK3JBcUJHa0NRZ0phODBVYWxRTXJNdW1sS3BjVTkxRHdH?=
 =?utf-8?B?Y1d3M0VYd01oQ2F2SlZDOWNBbi9Qa3ZsYWVrRjdtQTROSnBaMWdtelU5eDFl?=
 =?utf-8?B?K09YOWU5YUdScXNXNGdlQ0RLSWNsb3hkQ0UvcDVsQWR3U0FzNHVvOVlQMis3?=
 =?utf-8?B?RHZOMUJEalllZlMwS1hXVWsvSWZTTmdEVTBYMjAyVE9LZ2VWMHFHRHZoZG14?=
 =?utf-8?B?WUFqU2R0VU5hdVdUOFF3VGx5dzdXTlJzTkIxcWFuc0pXQUhLUDcxTXljU2ZF?=
 =?utf-8?B?WVBYamkzb1FORC91ejByNnhUemV3OHdsSmMrVnFIWFA2RVNzZEEzbU94MUlX?=
 =?utf-8?B?aG9yQmpwSEtWQVRZYzJJUjBlUzJ3dUhJbTBseUpnVHVZb2dnMlpTZHY4WFBv?=
 =?utf-8?B?elg1bmxFWXU5K2lESDM2Z0NqL2E2OTVFbFg4TWpaVFoxL25vWlQweFNDa2VH?=
 =?utf-8?B?bitGVU5ERFh3aWRRaFhyQ3Y5dGpzSFgzQVg4M0RmTWt6ZHdBaklLRUg4NWNa?=
 =?utf-8?B?bnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B9A0DB155925D49BD429F5158D99488@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10514541-8815-4dd7-c43c-08dd501a037d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2025 12:44:41.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIeDuD2Jf4EzLt3/bjmy6aR26my57mZ1/O6Ks0CWQaW6KMZXpckgIXxCDMtnfPjVz8gnm776w8exhJE5BgB9gZ7Ja9eU1c0z4mne/ajHWO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8601

T24gRnJpLCAyMDI1LTAxLTI0IGF0IDE3OjMxICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFdlZCwgSmFuIDIyLCAyMDI1IGF0IDA3OjQwOjEyQU0gKzAwMDAsIEZyaWRheSBZYW5nICjm
najpmLMpIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAyNS0wMS0yMSBhdCAxNzozMCArMDAwMCwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gT24gVHVlLCBKYW4gMjEsIDIwMjUgYXQgMDI6NTA6NDBQ
TSArMDgwMCwgRnJpZGF5IFlhbmcgd3JvdGU6DQo+ID4gPiA+IFNNSSBMQVJCcyByZXF1aXJlIHJl
c2V0IGZ1bmN0aW9ucyB3aGVuIGFwcGx5aW5nIGNsYW1wDQo+ID4gPiA+IG9wZXJhdGlvbnMuDQo+
ID4gPiA+IEFkZCAnI3Jlc2V0LWNlbGxzJyBmb3IgdGhlIGNsb2NrIGNvbnRyb2xsZXIgbG9jYXRl
ZCBpbiBpbWFnZSwNCj4gPiA+ID4gY2FtZXJhDQo+ID4gPiA+IGFuZCBJUEUgc3Vic3lzdGVtcy4N
Cj4gPiA+IA0KPiA+ID4gQSBuZXcgcmVxdWlyZWQgcHJvcGVydHkgaXMgYW4gYWJpIGJyZWFrLCBw
bGVhc2UgZXhwbGFpbiB3aHkgdGhpcw0KPiA+ID4gaXMNCj4gPiA+IHJlcXVpcmVkLg0KPiANCj4g
WW91IG5ldmVyIGFuc3dlcmVkIHRoaXMgcGFydC4gRnJvbSBhIHF1aWNrIGNoZWNrLCBsb29rcyBs
aWtlIHRoZQ0KPiBjaGFuZ2UNCj4geW91IG1hZGUgd2lsbCBjYXVzZSBwcm9iZSBmYWlsdXJlcyBp
ZiB0aGUgcmVzZXRzIGFyZSBub3QgcHJlc2VudD8NCj4gTWF5YmUNCj4gSSBtaXNyZWFkIHRoZSBk
cml2ZXIgY29kZSBpbiBteSBxdWljayBza2ltIC0gYnV0IHRoYXQgaXMgdGhlDQo+IGltcGxpY2F0
aW9uDQo+IG9mIGEgbmV3IHJlcXVpcmVkIHByb3BlcnR5LCBzbyBJIGRpZG4ndCBkaWcgc3VwZXIg
ZmFyLg0KPiANCj4gQWRkaW5nIG5ldyBwcm9wZXJ0aWVzIHRoYXQgYnJlYWsgYSBkcml2ZXIgaXMg
bm90IHJlYWxseSBhY2NlcHRhYmxlLA0KPiBzbyBJDQo+IGhvcGUgSSBtYWRlIGEgbWlzdGFrZSB0
aGVyZS4NCj4gDQoNClNvcnJ5IHRvIHJlcGx5IGxhdGUuDQpUaGlzIGlzIGEga25vd24gYnVzIGds
aXRjaCBpc3N1ZS4gSXQgd29ya2VkIGJlY2F1c2UgTWVkaWFUZWsgaGFzDQpwcm92aWRlZCBwYXRj
aGVzIDEsIDIgYW5kIDMuIEluIG90aGVyIHdvcmQsIGl0IGNhbiBub3Qgd29yaw0Kd2l0aG91dCBw
YXRjaGVzIDEsIDIgYW5kIDMuDQoNCjEuDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
NDAzMjcwNTU3MzIuMjgxOTgtMS15dS1jaGFuZy5sZWVAbWVkaWF0ZWsuY29tLw0KMi4NCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDMyNzA1NTczMi4yODE5OC0yLXl1LWNoYW5nLmxl
ZUBtZWRpYXRlay5jb20vDQozLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMzI3
MDU1NzMyLjI4MTk4LTMteXUtY2hhbmcubGVlQG1lZGlhdGVrLmNvbS8NCg0KUGF0Y2hlcyAxLCAy
IGFuZCAzIGhhdmUgYmVlbiBwcmV2aW91c2x5IHJldmlld2VkLCBhbmQgdGhlIHJldmlld2Vycw0K
cHJvdmlkZWQgdGhlIGZvbGxvd2luZyBjb21tZW50czoNCjQuDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvQ0FGR3JkOXFaaE9iUVh2bTJfYWJxYVg4M3hNTHF4alFFVEIyPXdYcG9iRFdVMUNu
dmtBQG1haWwuZ21haWwuY29tLw0KNS4NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQVBE
eUtGcG9rWFYyZ0pEZ293Yml4VHZPSF81VkwzQjVIOGV5aFArS0o1RmFzbTJyRmdAbWFpbC5nbWFp
bC5jb20vDQpBcyBJIG1lbnRpb25lZCBlYXJsaWVyLCBTTUkgY2xhbXAgYW5kIHJlc2V0IG9wZXJh
dGlvbnMgc2hvdWxkIGJlDQppbXBsZW1lbnRlZCBpbiBTTUkgZHJpdmVyIHJhdGhlciB0aGFuIHRo
ZSBQTSBkcml2ZXIuIEFkZGl0aW9uYWxseSwgdGhlDQpyZXNldCBvcGVyYXRpb25zIGhhdmUgYWxy
ZWFkeSBiZWVuIGltcGxlbWVudGVkIGluIHRoZSBjbG9jayBjb250cm9sDQpkcml2ZXIuIFRoZXJl
IGlzIG5vIG5lZWQgdG8gc3VibWl0IGR1cGxpY2F0ZSBjb2RlLiANCg0KVG8gYWRkcmVzcyB0aGlz
LCBJIGhhdmUgcHJvdmlkZWQgcGF0Y2hlcyA2LCA3IHRvIHJlcGxhY2UgcGF0Y2hlcyAxLCAyLA0K
YW5kIDMsIGFzIEkgYmVsaWV2ZSB0aGlzIGFwcHJvYWNoIGFsaWducyBtb3JlIGNsb3NlbHkgd2l0
aCB0aGUNCnJldmlld2VycycgcmVxdWlyZW1lbnRzLg0KNi4NCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xrbWwvMjAyNTAxMjEwNjUwNDUuMTM1MTQtMS1mcmlkYXkueWFuZ0BtZWRpYXRlay5jb20v
DQo3Lg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDI1MDEyMTA2NDkzNC4xMzQ4Mi0x
LWZyaWRheS55YW5nQG1lZGlhdGVrLmNvbS8NCg0KV2hhdCdzIG1vcmUsIEkgaGF2ZSB0ZXN0ZWQg
dGhlIHBhdGNoIDYsIDcgaW4gTWVkaWFUZWsgTVQ4MTg4IFNvQy4NCkl0IGNvdWxkIHdvcmsgd2Vs
bC4gSWYgeW91IGhhdmUgYW55IHF1ZXN0aW9ucywgcGxlYXNlIGZlZWwgZnJlZSB0bw0KY29udGFj
dCBtZS4NCg0KPiA+IFdoYXQgYXJlICJTTUkgTEFSQnMiPyBXaHkgZGlkIHRoaW5ncyBwcmV2aW91
c2x5IHdvcmsNCj4gPiA+IHdpdGhvdXQNCj4gPiA+IGFjdGluZyBhcyBhIHJlc2V0IGNvbnRyb2xs
ZXI/DQo+ID4gPiANCj4gPiANCj4gPiBUaGUgYmFja2dyb3VuZCBjYW4gcmVmZXIgdG8gdGhlIGRp
c2N1c3Npb24gaW4gdGhlIGZvbGxvd2luZyBsaW5rOg0KPiA+IA0KPiA+IA0KaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsL0NBRkdyZDlxWmhPYlFYdm0yX2FicWFYODN4TUxxeGpRRVRCMj13WHBv
YkRXVTFDbnZrQUBtYWlsLmdtYWlsLmNvbS8NCj4gPiANCj4gPiANCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2FsbC9DQVBEeUtGcG9rWFYyZ0pEZ293Yml4VHZPSF81VkwzQjVIOGV5aFArS0o1RmFz
bTJyRmdAbWFpbC5nbWFpbC5jb20vDQo+ID4gU01JIGNsYW1wIGFuZCByZXNldCBvcGVyYXRpb25z
IHNob3VsZCBiZSBpbXBsZW1lbnRlZCBpbiBTTUkgZHJpdmVyDQo+ID4gaW5zdGVhZCBvZiBQTSBk
cml2ZXIuDQo+IA0KPiBTbyB0aGUgYW5zd2VyIHRvIGhvdyBpdCB3b3JrZWQgcHJldmlvdXNseSB3
YXMgdGhhdCBub3RoaW5nIGFjdHVhbGx5DQo+IHVzZWQNCj4gdGhpcyBtdWx0aW1lZGlhIGludGVy
ZmFjZT8NCj4gDQo+IFlvdXIgY29tbWl0IG1lc3NhZ2UgbmVlZHMgdG8gZXhwbGFpbiB3aHkgYSBu
ZXcgcmVxdWlyZWQgcHJvcGVydHkgaXMNCj4gb2theQ0KPiBhbmQgd2h5IGl0IHdhcyBub3QgdGhl
cmUgYmVmb3JlLg0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+ID4gDQo+ID4gSSBwcmV2
aW91c2x5IGFkZGVkIHRoZSBTTUkgcmVzZXQgY29udHJvbCBkcml2ZXIuIEhvd2V2ZXIsIHRoZQ0K
PiA+IHJldmlld2VyJ3MgY29tbWVudHMgYXJlIGNvcnJlY3QsIHRoZXNlIGZ1bmN0aW9ucyBoYXZl
IGFscmVhZHkNCj4gPiBiZWVuIGltcGxlbWVudGVkIGluIHRoZSBjbG9jayBjb250cm9sIGRyaXZl
ci4gVGhlcmUgaXMgbm8gbmVlZA0KPiA+IHRvIHN1Ym1pdCBkdXBsaWNhdGUgY29kZS4gDQo+ID4g
DQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQxMTIwMDYzMzA1LjgxMzUt
Mi1mcmlkYXkueWFuZ0BtZWRpYXRlay5jb20vDQo+ID4gDQo+ID4gDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjQxMTIwMDYzMzA1LjgxMzUtMy1mcmlkYXkueWFuZ0BtZWRpYXRlay5j
b20vDQo+ID4gDQo+ID4gDQo+ID4gT24gdGhlIE1lZGlhVGVrIHBsYXRmb3JtLCB0aGUgU01JIGJs
b2NrIGRpYWdyYW0gbGlrZSB0aGlzOg0KPiA+IA0KPiA+ICAgICAgICAgICAgICAgICBEUkFNDQo+
ID4gICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgRU1JKEV4dGVybmFsIE1lbW9y
eSBJbnRlcmZhY2UpDQo+ID4gICAgICAgICAgICAgICAgICB8ICB8DQo+ID4gICAgICAgICAgIE1l
ZGlhVGVrIElPTU1VKElucHV0IE91dHB1dCBNZW1vcnkgTWFuYWdlbWVudCBVbml0KQ0KPiA+ICAg
ICAgICAgICAgICAgICAgfCAgfA0KPiA+ICAgICAgICAgICAgICBTTUktQ29tbW9uKFNtYXJ0IE11
bHRpbWVkaWEgSW50ZXJmYWNlIENvbW1vbikNCj4gPiAgICAgICAgICAgICAgICAgIHwNCj4gPiAg
ICAgICAgICArLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0rDQo+ID4gICAgICAg
ICAgfCAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgIHwg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICB8ICAgICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgfCAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgIHwgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgbGFyYjAgICAgICAgU01JLVN1Yi1Db21t
b24wICAgICBTTUktU3ViLUNvbW1vbjENCj4gPiAgICAgICAgICAgICAgICAgICAgfCAgICAgIHwg
ICAgIHwgICAgICB8ICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICBsYXJiMSAg
bGFyYjIgbGFyYjMgIGxhcmI3ICAgICAgIGxhcmI5DQo+ID4gDQo+ID4gVGhlIFNNSS1Db21tb24g
Y29ubmVjdHMgd2l0aCBTTUkgTEFSQnMgYW5kIElPTU1VLiBUaGUgbWF4aW11bSBMQVJCcw0KPiA+
IG51bWJlciB0aGF0IGNvbm5lY3RzIHdpdGggYSBTTUktQ29tbW9uIGlzIDguIElmIHRoZSBlbmdp
bmVzIG51bWJlcg0KPiA+IGlzDQo+ID4gb3ZlciA4LCBzb21ldGltZXMgd2UgdXNlIGEgU01JLVN1
Yi1Db21tb24gd2hpY2ggaXMgbmVhcmx5IHNhbWUgd2l0aA0KPiA+IFNNSS1Db21tb24uIEl0IHN1
cHBvcnRzIHVwIHRvIDggaW5wdXQgYW5kIDEgb3V0cHV0KFNNSS1Db21tb24gaGFzIDINCj4gPiBv
dXRwdXQpLg0KPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRnJpZGF5IFlh
bmcgPGZyaWRheS55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4v
YmluZGluZ3MvY2xvY2svbWVkaWF0ZWssbXQ4MTg4LWNsb2NrLnlhbWwgfCAyMQ0KPiA+ID4gPiAr
KysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9tZWRpYXRlayxtdDgxODgtDQo+ID4gPiA+IGNs
b2NrLnlhbWwNCj4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xv
Y2svbWVkaWF0ZWssbXQ4MTg4LQ0KPiA+ID4gPiBjbG9jay55YW1sDQo+ID4gPiA+IGluZGV4IDg2
MDU3MDMyMDU0NS4uMjk4NWM4YzcxN2Q3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svbWVkaWF0ZWssbXQ4MTg4LQ0KPiA+ID4gPiBj
bG9jay55YW1sDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9jbG9jay9tZWRpYXRlayxtdDgxODgtDQo+ID4gPiA+IGNsb2NrLnlhbWwNCj4gPiA+ID4gQEAg
LTU3LDYgKzU3LDI3IEBAIHJlcXVpcmVkOg0KPiA+ID4gPiAgICAtIHJlZw0KPiA+ID4gPiAgICAt
ICcjY2xvY2stY2VsbHMnDQo+ID4gPiA+IA0KPiA+ID4gPiArYWxsT2Y6DQo+ID4gPiA+ICsgIC0g
aWY6DQo+ID4gPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ID4gPiArICAgICAgICBjb21wYXRp
YmxlOg0KPiA+ID4gPiArICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ID4gPiArICAgICAgICAgICAg
ZW51bToNCj4gPiA+ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtY2Ftc3lzLXJh
d2ENCj4gPiA+ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtY2Ftc3lzLXJhd2IN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtY2Ftc3lzLXl1dmENCj4g
PiA+ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtY2Ftc3lzLXl1dmINCj4gPiA+
ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtaW1nc3lzLXdwZTENCj4gPiA+ID4g
KyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtaW1nc3lzLXdwZTINCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtaW1nc3lzLXdwZTMNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtaW1nc3lzMS1kaXAtbnINCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtaW1nc3lzMS1kaXAtdG9wDQo+ID4gPiA+ICsgICAg
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LWlwZXN5cw0KPiA+ID4gPiArDQo+ID4gPiA+ICsg
ICAgdGhlbjoNCj4gPiA+ID4gKyAgICAgIHJlcXVpcmVkOg0KPiA+ID4gPiArICAgICAgICAtICcj
cmVzZXQtY2VsbHMnDQo+ID4gPiA+ICsNCj4gPiA+ID4gIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBm
YWxzZQ0KPiA+ID4gPiANCj4gPiA+ID4gIGV4YW1wbGVzOg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAy
LjQ2LjANCj4gPiA+ID4gDQo=

