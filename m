Return-Path: <linux-kernel+bounces-412567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA859D0ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 09:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05D21F20F43
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A7615250F;
	Mon, 18 Nov 2024 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PpLIUNM/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mwCGmwhU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E3113D245
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731918030; cv=fail; b=EfK2be7msAyNdgV0v2mxDp4TXy1QqUSXk0efWFbw5Ix8UMXdVcDY09EjItWdNHuwcGnYnBwk/mxbAGwh0hbiOos0QbJq+VCqW1Sqc5hZdfLVBt+9WL7E6d6kVjXgJloQGYKmJnMZx0zsjSnazfJkNmX84FGWwrt4YVry7X9ArDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731918030; c=relaxed/simple;
	bh=JVVZ2tp0xeGuDrwzdTq5svrCAoUCFbOfp2Wdun884X4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vol2WfsCnfpBWG4UbkVDJodvJgsZnWeD1ZBIO7azG1t8RRIXWAo4VEgfFico9lHpTxSjH/ujpb681sXwGxUj1hV56pVNTSSvkEwJW2HDvjwQjSPS6StFVshJbQdyAUJoyz7872AO1xjJbN5tXw/VyM8XwlMKuvOCdBISKTvcTtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PpLIUNM/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mwCGmwhU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f1b97270a58511ef99858b75a2457dd9-20241118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JVVZ2tp0xeGuDrwzdTq5svrCAoUCFbOfp2Wdun884X4=;
	b=PpLIUNM/Tc30KtW3xTZCb1+390fxg0EbIw+3RTauB3o31+4J3GE+cJWEaBvN+fTGbqk+f1UDPA1yRyKqLIyS68U1E1JHNPHImihlTMXIpGYSjsykc7afXVFwh/6TbbnXYZRAlAl3CrQ48XzPIzFMW/RriNJ+oM5/Wlf1TzyJTZA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:5faecc26-c7a3-4450-9d28-6a5f070eb9ed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:dfb8394f-a2ae-4b53-acd4-c3dc8f449198,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f1b97270a58511ef99858b75a2457dd9-20241118
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 67347655; Mon, 18 Nov 2024 16:20:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Nov 2024 16:20:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Nov 2024 16:20:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meG9f1lkEvLwprFJGkKkC3HAs27ocn5dPhfuOyhXtAJb4tSFFEwxj4fuRKR7xcnKBekBtQOP9HlKRAY7/zLHIZe0CuzUSU/7xaBvTqmC9DPUlE+12CxeuVBroh9B6UAtfn0qlwOFTOT8MoGa8Yl/GPYOs60eNTTvcEMfiRttLqTGPl7YMQqvbQYxaC0fIJAkJQrKxJlD8OA+b+pa3rcGgs+rO/mO9cMg1CXKmA+haT68W74+h2IS4nVWDAde2P8Ehzo0vYvDMNEuG06XN6V0Yu0EAQY0yeW1fTX7oaV2x7cfwuHS8GuA9BcEqLrsDaapDt2YqrwAHxRZA4Mfky/SCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVVZ2tp0xeGuDrwzdTq5svrCAoUCFbOfp2Wdun884X4=;
 b=pgUqgDwJxk6WH0gsv1DGL4UGkYAkHafTrE0gRymwhj1YL5JLF81t1qZHBO1vHmamgv0alu+fmjRiepTEzf+7bo4y93lkgUnde2iBDnrnXD+zZuVYcLiD1b//1tFkHYtzFBSVDp2D0j3KbF3L5jwEKeXFE8Dwjd+EBXv8XzDwYMqCD+eZ/hAJIe3QDOQ2gbPy87G55ho2K4JgPWMyffwPXW/2civbXMF4kkUGS//u8Ii30RMQrRrNtB1a3lMKdhpJU3T46WBMt+ajPkowZI8RRhvpamIeT2iSM35O/Z4aIlO5zQxz8hkVbfbRvODkBuYMrDOXvvx7/rVM1M0zuYy9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVVZ2tp0xeGuDrwzdTq5svrCAoUCFbOfp2Wdun884X4=;
 b=mwCGmwhUcex9viq7Ta4a/sWOjhfjSFPKkj26i3v1n38NOrSAENgL0rWqBdFcpLWe2cYYmF+rQF8Xc55WKSDDG5+lyC7HLN3rDUalk7bbP6Nnv4NAYv0Tp1Vv2uzXlAybX+i6zLdZdZGGtG8JErTcEn84BaVK8KpfBUV0CrXwg+E=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEYPR03MB8328.apcprd03.prod.outlook.com (2603:1096:101:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 08:20:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8158.017; Mon, 18 Nov 2024
 08:20:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "fshao@chromium.org"
	<fshao@chromium.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/mediatek: Add no pending_planes flag checking for
 mtk_crtc_finish_page_flip()
Thread-Topic: [PATCH] drm/mediatek: Add no pending_planes flag checking for
 mtk_crtc_finish_page_flip()
Thread-Index: AQHbOWs1wXZ67HqCP0esrO+i6ErkpbK8socA
Date: Mon, 18 Nov 2024 08:20:13 +0000
Message-ID: <96b3576243f5c6880dd16d36020d2083a8508b44.camel@mediatek.com>
References: <20241118033646.31633-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20241118033646.31633-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEYPR03MB8328:EE_
x-ms-office365-filtering-correlation-id: d3126f11-c40f-4945-f2f4-08dd07a9d369
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MHBDVVZGUUJma2kvVytxYUdyMjRsajJIVXdKK1hlR0drK3FVd09sektDUmll?=
 =?utf-8?B?dWJtYzhjS1pUV3gyQ1FHUi92YTl0d0VwbDhJbGdnOTcrK0ROU040RW5hek41?=
 =?utf-8?B?UkFraWpCdDJFclkrcHF2eU5hS1JzeFBWQk1QWlpNYitvTnRwenNuckZzbUhl?=
 =?utf-8?B?anZkVXJOZFlaalFYNFRhb212TGdwNExMU09EbGZleFV6d3VuUnVHNWluK3hD?=
 =?utf-8?B?VXd3OVZCOFc4ek9VMW1VT3RmNVlvT1ZjUHB5MDU0RG9nYU51azk4SlZMMWk5?=
 =?utf-8?B?aFd3alZYak42T1VDZytqVGx0VnRiWXhiWjRFVWlkS3U2UStXNUlXY3RwUFRC?=
 =?utf-8?B?N29xUG1jaDR0SDRaNkVadE5TWG1lWnUvQll6OXJIYjh0NFMvTkFsQk1JdGJh?=
 =?utf-8?B?aTU4VFp1M0RtOXpOVTBBMjRWT3VXY0lqNUlYd0lWd2ZmVnF0aWgvdmxIenNE?=
 =?utf-8?B?OE9lMVlBWHpzS0hidzdSRVU3R3ljV1l5amNYRWhvakdVT0JqTnBJdnllS3RC?=
 =?utf-8?B?MEs2cDVZdHVjdnRycUZUZ1Y4NnYxUW5Sa1ljTzV6Yk10TU5rcnB0SWlEdFJF?=
 =?utf-8?B?YVdTcnlzd3hKUkxGQ0dzTTlOVTRUUGFvYVhkR2x4RmsyQzVSeVRWQVI2SDRK?=
 =?utf-8?B?NTlubk1HM1NFODhkUVhEYW5IRCtXYmtxdHkza2J1eHVDdEo3cEZBUmxqeFhp?=
 =?utf-8?B?aGhZeFpyU2p0VDU4djFkNG1HS3Q2MnR2WDNvdWJmMHYwOGNYVjBFaFFYV0l0?=
 =?utf-8?B?SHh3bGx4Yk5QdG1BZU9wWXJXUlJYUW5HZHR2REV5OFNHc29uZk4xc29hK2p3?=
 =?utf-8?B?alJSbVUwR09Tc2lsNTlxQ2xheXc2ZGxuZDZEYTF4UkpFWmpDNXJXWFBlM2NO?=
 =?utf-8?B?UnlCMDMzUnVaWU5MVWIva2phaCtib0NwRXhGTTBBVFhKS214WTZELzJzUmlz?=
 =?utf-8?B?UUVuU05VcnhNN3Bxek1qRkdyN3Zud2RaMTM2czUwL1QvcTI0VzJvMm9iNnJv?=
 =?utf-8?B?OWdXVWZZLzV2dldMa1B5OWVCSjI2dU14YkhLL214OWVmK2RGWFBjR0pqdzJw?=
 =?utf-8?B?MU9pUUc4amZBbFN0T0RYa3lRQ01Nby9ieWRxUVFnMjV2ZVVDU2pWY2NTb3dr?=
 =?utf-8?B?YURUWDJQanY2RkhNZVBYdnhUbDZzNk9ZZlJWNTYxOEVmd2Fab29NbytGRU15?=
 =?utf-8?B?eW03bWJZeW1CclhZbHY1aHVFdW1malEzVVZZb0hGQjM2VFlTdmtXZ2RWeUwr?=
 =?utf-8?B?Um92MGRGQlh2Z2EzcE5hTSt2MkR3cFU3RUN2QVRJSVRxYzFEcnpwajFPeWdG?=
 =?utf-8?B?cHl5Nk5tbnphbEhlanpSVXoyTWNGNm41SW1jV0VTRkRSaUFaOVhwa05NZm5D?=
 =?utf-8?B?TitMTnhzTms5ZzlMSmt4bUNVWU51bEpQODduNFBkRnNrc3JNNXlVZWthdDk1?=
 =?utf-8?B?Z3RmTm1RT3BGOUlhbmNmNDgydWNldU1hejRvdTg0TVlPZWdiOFhGMVp0OHg0?=
 =?utf-8?B?LzM0OEhXdUlGTTV2R2UxZUtsNHZVK2VqN2QxVTZMeDQ0c1ZoeURTTlN0Tjl4?=
 =?utf-8?B?UWc1aUNXRkt3MXNpd25iZkpieXU1ZERLeFk2VVViQzAxUDI5TTBRT2V4aUtI?=
 =?utf-8?B?R09hMWRyY1Z5bUQ1SG1ZNjFRTEFyMG1ZVS9xTGpSNWlxbFdoenkyTzd1bTBx?=
 =?utf-8?B?cVhiZVpQL0I4MnB2UUMzWWVtQUt3Ymdlbk1KN0NqYkxPV3JFTk9kY0J1TWlM?=
 =?utf-8?B?VURwVDdqYm84Q2hkeEZ3NTFSL2UyazJJVk5LWUF3bTMwQTRBWnZTVGw5ODg1?=
 =?utf-8?Q?Ba4lVtn9Eh3GSOggvzzwkPZW1m+VWrBZ83RqU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1RuaTdxQ2dqZWFFdVExaDc1K2JpVmZ3Zi9IbnlWSG5yOG9mM3BEb2JWRGJk?=
 =?utf-8?B?S3FrNVF3RWhEQ2c3T1ZTNjd5N2tVQm4rRUpyeW1aQkhjMFNZZVBMSTF4Y0pS?=
 =?utf-8?B?eVl2K3BBOFdyUER1VWtrdmRRMnUzUFVrR2d1SjlTYWZjS2RzaDlyQ2hEM1VT?=
 =?utf-8?B?MDdhTTlOdEtGZWdGbUY3WXpGVjg0d0xlRlBHTFpGK1BoRDIza2JrRjEwTmlO?=
 =?utf-8?B?NzNRalpqTFBTRC85QUhZd1dHS1YwcXAxdVRHZ24xcFJzRWEyNmRwU1BmYlJP?=
 =?utf-8?B?Wi9uZnFrZWpEN0VaWlBIUTNHQW11eVk5WVpwQnBKNnUxMXA0ZUZya3ZucHhW?=
 =?utf-8?B?V1YxaURWYVJqY3Z6OWYrcWYya2pabFM0c3hmbGRzYlp2c255aFppQ0tEc29C?=
 =?utf-8?B?WENXZ0s3Umd1TFpvQU5jWlNxNzdpNTlGSS9NYWw3cmtuSWpveUtBU3U0Nklt?=
 =?utf-8?B?dDFQZHRzZU9SalRsNUhuMjZVTmF6Smx1cjBncGQwdEFjNTJoQS9RNTdLV0JL?=
 =?utf-8?B?RzdCRTgwcGFCaVB0NWdTeW8vNFo2MjZkOERXR3B2b0k2eEdLbWZDNE92OU03?=
 =?utf-8?B?TnlGSXB6ejRxRVBaaDlJNWIrNDJGK3poNjlQVEc5R244QXhkcTFteXZFYUtL?=
 =?utf-8?B?aVN4RkNBeFFYZjViSzAxVVZLRDlKcUl5RlIxMDZORjR0alpPUkFVUkxTNU0r?=
 =?utf-8?B?dGFraUtTcWVHZTZ3NGZUTFNhOTE1OXpBN3N1TVp4ZFRvaFRqcHUxNm9kT2Nw?=
 =?utf-8?B?c0F4b1BLYmx4ZUdCSDczbGllcHBpa3dQVlNBTzIyeTRrekRNcXNFNXRiWWVD?=
 =?utf-8?B?QXMzV2RNa2ZBcEErQjl1bmVDZHY5MUFOeHl6cHZlZXFEekZERDE3dWhJUDVa?=
 =?utf-8?B?NzQ0dHJvWHRFOERmSS9UOXBPTnc4WkFyczFTWGJUUXNFR3NUejVMQVhnWldU?=
 =?utf-8?B?M0JVOHNoLzNzaE1hWWxPSXFjUVN6cmdFSGVNcm1LOFNQbnJaZzFVaXVMMDZ1?=
 =?utf-8?B?dVA2RzNPdFFHa21HVk1yakZpZUhDbE53UVNhekZoOFdFbGd3MEtQb21XQ3hJ?=
 =?utf-8?B?Yk5lUVk3alB1MUpZTmFyTnY5THpHRkFUQXZ3dktvWSs3d1RPYmFud3pia2ll?=
 =?utf-8?B?TEEyU3VFUmx4djhhL3Y0SE9yNTlXb2RGSy9wREVwd01OUVdhQkUvWktXbVpK?=
 =?utf-8?B?V0NrcERMSFlYT29RN0FUU2ZtSVEyZHhkYVl2R1ZraXB5RFd2NjFRc0ZtdW01?=
 =?utf-8?B?dXcvekU1TjNBVTB1MWVZQzRsdHppS0xEZzRJODQ5akNIbVpNT0h2aWpjOWlS?=
 =?utf-8?B?VURlYWpLMUE0SG9SQlJ0MUVhV2hXa1VvWmtxQVdVMDJLUjVZaFVrblZEdXFm?=
 =?utf-8?B?M3lnOXR4d0xDZUY4TW5IOWorTFlyRlhpZHdDYzRrV1JxaWMrdjVoTUQrVEV4?=
 =?utf-8?B?QjQyZVc0SkxrZVhlSUtyN09TZlFyYXcwYlRSZzFYNWdjQTF6bUZKcTExR2xK?=
 =?utf-8?B?RW53VVlGaHI1Nmsxb1FPZkp2U3BrM2FBQTNUSk94M0FuNDVDL3lldmtVT3pv?=
 =?utf-8?B?NGFTaXRqMkJJYmlLNjBORlNKVlcvOEZocUdmV0JNYjlYdm5TeUNMRjVmZFc2?=
 =?utf-8?B?cFJLa0hJRXZCVkFtWFU5UlY1OXlKZ29VUDVZSElpcFlzVWNTVHRSSGhzSUUw?=
 =?utf-8?B?cEdyTXF4M2ZzbUVTMngvOEd6YXMzWXRCSE1pRDBXQTBnMnpzYjlEcDgvdHRo?=
 =?utf-8?B?Y0Y3OVZFRERSTGdoSDVzejVQMXh5RjB4SGlSTlFSQWZJTXV2Zjh2YUVrVXdR?=
 =?utf-8?B?dGlDYmpZU1kxU05LeUM2a2pSbStqQ3B6SWpUeFNNRnE2NGJXb3N5dWxZSW9Q?=
 =?utf-8?B?OG9NTTg0dWJ4TkYxMFZmb0pVcTBBd3JZcE80Uk0wRXlFZUgwQUljb09TQzJS?=
 =?utf-8?B?SEN5c0RmWWVaV2RhcUxrT0NOYnpmQXVHSU0va1lBRFBRZHBJQXMyUHVCelhO?=
 =?utf-8?B?VnV0WCthWXVCT1prQm5EVVpmUHBwRC8xcVBDWWVoNEU0cFpFcjZET25PMlla?=
 =?utf-8?B?UGtwM1dsRGl0UmFUdzN6RVB1WkE5eUJ1QmFOVkYyYjVVTjRscE5nSFRCUjRZ?=
 =?utf-8?B?WHJvK1g1UWtFa0hKekthYzlJNWxZbTVHRWp4MWk1YkRhNVN3KzlOMmNWZHFw?=
 =?utf-8?B?ZUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F553659E29B9534E8E4C612C63C410DB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3126f11-c40f-4945-f2f4-08dd07a9d369
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 08:20:13.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: agaQxUGKfVvGB8XeYl69ieQJxe9UHxwPC0hcE6SH1CV9njWU37WrCG/aNZpMdYKzQ55cALlWOm6ZbLO+LWvrFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8328

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjQtMTEtMTggYXQgMTE6MzYgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gbXRrX2NydGNfZmluaXNoX3BhZ2VfZmxpcCgpIGlzIHVzZWQgdG8gbm90
aWZ5IHRoZSBwYWdlIGZsaXAgdGhhdCBoYXMNCj4gYmVlbiBjb21wbGV0ZWQgdG8gdGhlIHVzZXJz
cGFjZSwgc28gdXNlcnNwYWNlIGNhbiBmcmVlIHRoZSBmcmFtZSBidWZmZXINCj4gb2YgdGhlIGxh
c3QgZnJhbWUgYW5kIGNvbW1pdCB0aGUgbmV4dCBmcmFtZS4NCj4gDQo+IEhvd2V2ZXIsIG10a19j
cnRjX2ZpbmlzaF9wYWdlX2ZsaXAoKSBjYW5ub3QgZ3VhcmFudGVlIHRoZSBHQ0UgaGFzDQo+IGNv
bmZpZ3VyZWQgYWxsIHRoZSBkaXNwbGF5IGhhcmR3YXJlIHNldHRpbmdzIG9mIHRoZSBsYXN0IGZy
YW1lLg0KPiBUaGlzIG1heSBjYXVzZSB0aGUgZGlzcGxheSBoYXJkd2FyZSB0byBzdGlsbCBhY2Nl
c3MgdGhlIGxhc3QgZnJhbWUNCj4gYnVmZmVyIHJlbGVhc2VkIGJ5IHRoZSB1c2Vyc3BhY2UuDQo+
IA0KPiBTbyBhZGQgdGhlIGNoZWNraW5nIGNvbmRpdGlvbiBvZiBubyBwZW5kaW5nX3BsZW5zIGZs
YWdzIHRvIG1ha2Ugc3VyZQ0KPiBHQ0UgaGFzIGV4ZWN1dGVkIGFsbCB0aGUgcGVuZGluZyBwbGFu
ZXMgY29uZmlndXJhdGlvbi4NCg0KV2hhdCdzIHRoZSBwcm9iYWJpbGl0eT8NCklmIGl0J3MgbG93
IHByb2JhYmlsaXR5LCB3ZSBjb3VsZCBkcm9wIGNhbGxpbmcgbXRrX2NydGNfZmluaXNoX3BhZ2Vf
ZmxpcCgpLg0KSWYgaXQncyBub3QgbG93IHByb2JhYmlsaXR5LCBJIHRoaW5rIGRyb3AgY2FsbGlu
ZyBtdGtfY3J0Y19maW5pc2hfcGFnZV9mbGlwKCkgd291bGQgcmVkdWNlIHRoZSBmcHMgYW5kIHdl
IHNob3VsZCBmaW5kIGFub3RoZXIgd2F5Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gRml4ZXM6
IDdmODJkOWM0Mzg3OSAoImRybS9tZWRpYXRlazogQ2xlYXIgcGVuZGluZyBmbGFnIHdoZW4gY21k
cSBwYWNrZXQgaXMgZG9uZSIpDQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24t
amgubGluQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2NydGMuYyB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19jcnRjLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2NydGMuYw0KPiBpbmRl
eCBlYjBlMTIzM2FkMDQuLmIwM2I5MTAyZmY5MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19jcnRjLmMNCj4gQEAgLTExMyw3ICsxMTMsOCBAQCBzdGF0aWMgdm9pZCBtdGtfZHJtX2Zp
bmlzaF9wYWdlX2ZsaXAoc3RydWN0IG10a19jcnRjICptdGtfY3J0YykNCj4gIAlkcm1fY3J0Y19o
YW5kbGVfdmJsYW5rKCZtdGtfY3J0Yy0+YmFzZSk7DQo+ICANCj4gIAlzcGluX2xvY2tfaXJxc2F2
ZSgmbXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+IC0JaWYgKCFtdGtfY3J0Yy0+Y29u
ZmlnX3VwZGF0aW5nICYmIG10a19jcnRjLT5wZW5kaW5nX25lZWRzX3ZibGFuaykgew0KPiArCWlm
ICghbXRrX2NydGMtPmNvbmZpZ191cGRhdGluZyAmJiBtdGtfY3J0Yy0+cGVuZGluZ19uZWVkc192
YmxhbmsgJiYNCj4gKwkgICAgIW10a19jcnRjLT5wZW5kaW5nX3BsYW5lcykgew0KPiAgCQltdGtf
Y3J0Y19maW5pc2hfcGFnZV9mbGlwKG10a19jcnRjKTsNCj4gIAkJbXRrX2NydGMtPnBlbmRpbmdf
bmVlZHNfdmJsYW5rID0gZmFsc2U7DQo+ICAJfQ0K

