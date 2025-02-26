Return-Path: <linux-kernel+bounces-533656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 646A5A45D4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D8E3AA564
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41972153D3;
	Wed, 26 Feb 2025 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qi8j3knF";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="cCa9gCUT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC28322A;
	Wed, 26 Feb 2025 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569871; cv=fail; b=XBUHkxpkYde00X018U/rRsLydf7T9aru1EkMS8U/ny8S5wrX1b7DnzCkFOuN9pRVBuqd2XegA/tO9zoxzLsn10gHpbvA+iYhKhtLFM+Yzd1DTajK9318Uh1h9Ow9iXFl+MtHdg/tcG8WmYWOt/mdtSqDhBtI+6uMh4P6izJzmsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569871; c=relaxed/simple;
	bh=MRgLmgEQAHTiH1rpIZsuyTAzN00daw5ynvemq3/dNxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GhnE++DPfBgHJRTBsQJjJER4L7B6ghmSSwnuO/oU72IBxgoFVM2EtMtr9xyhz53Vtllj7IhqCpHUapxZPjpoK2ci7mlbPY9pp7rxgSoCbcmMAfWAW3gsCzrQvQ+4vwoES5IgLFUi6Fw42l1IhAoYRzYpb/DU+Gb5lguEnavdVnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qi8j3knF; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=cCa9gCUT; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 17065102f43611efaae1fd9735fae912-20250226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MRgLmgEQAHTiH1rpIZsuyTAzN00daw5ynvemq3/dNxw=;
	b=Qi8j3knF+hWnIiQx9Wzr4IElqGj0fxhEWEBCd1/xNxIvFfmusqV6s1pnEHjO1HFqgtGTQX7eCwPOrBQIICh1JijXMKqGd6kdbI13n4xFQNiLiAaMYpGI5/K6uW33MTd/u4PNoUdWD7H5FaWG/od6JCg2HHcEXQ4KIhfQNkVi9uE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:2373c1da-88ff-4811-92a4-ad1332a438c5,IP:0,U
	RL:12,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:12
X-CID-META: VersionHash:60aa074,CLOUDID:8067f3d9-654e-41f2-8a8e-a96c1e834c64,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|80|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
	I:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 17065102f43611efaae1fd9735fae912-20250226
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1659608605; Wed, 26 Feb 2025 19:37:42 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 26 Feb 2025 19:37:41 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 26 Feb 2025 19:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQPVlJSSGBaRyI82kV3BAVXBCWd4laUy3SB7tQ46xXmgUw0f4jaZrOA7yETGBOXio+grxkXC24BoTLH7YYz7ul44L4pO7aNsiEAOsjIpG4U/lsaCO2eeLfU2aYQsgCjFCcODauTwuB+KaXhQmEKy60V+JlkEI7TGJ4tWinqD9UC57zsKKiGK0EIL9ZkE+c1xRwhNYkZ1CJne/PyM0/cFE2pDBJE6RdrfrJw/PDo87JvFxVlqqWBSiLemKQ+pn+oWbqZLB8+/e8arr2k3HaWuhqWxxPLClQhaaGZa7vrsgNWC4ZF/ZcfAbE0evcSi4wHB0aciVaGnXrGTYiIxHgJdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRgLmgEQAHTiH1rpIZsuyTAzN00daw5ynvemq3/dNxw=;
 b=pa4IbOckJUQnjYrSpZTLicevL1ziqW5U2IbE6eaxrztIJ00DLX1lHs7N3b/NaDAitiShHQfy9UAIz93heJaXW0mqvy/PNYuz5dIiQHC1Zq1c1ARcPO0KTRd6i9AoMF3ZDbUX4rk7XqX68u604cAnC3ZDimDRMsVwasY3QschPMj63hGUNyD2r4NJkake6iG9rSBtjUpMtgGKUe28wR/UTYSpCL5yUuwNBZ6JIlqnV5+N024lBGVKv+ti7ut/ff3hdiC170N9OL1dHeHrDfsD/1eXeizBS0quRWhbVlistWdRX39P8wfHSpajLUGfz0TtfgXLGGSC30Bl8Q7gEFdNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRgLmgEQAHTiH1rpIZsuyTAzN00daw5ynvemq3/dNxw=;
 b=cCa9gCUT0NqRjX09U9LaWtHx5VzT4LBBgFS8t3TtG/dPRLVc+XE1YidVIgwH43VbEcSAkgvLR5cCTRCX6HvkMEh8foqGhBE85cw8OHOcGwrjMPFh1B76cDl4+RKdyJKdWp5DiNj6j7AIQmZI0p15+d4ovqK+0CRpPu4EfwKXARE=
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com (2603:1096:400:459::6)
 by KL1PR03MB8260.apcprd03.prod.outlook.com (2603:1096:820:106::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 11:37:37 +0000
Received: from TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939]) by TYZPR03MB8136.apcprd03.prod.outlook.com
 ([fe80::c1dc:a4af:10cc:b939%6]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 11:37:37 +0000
From: =?utf-8?B?SmF5IExpdSAo5YiY5Y2aKQ==?= <Jay.Liu@mediatek.com>
To: =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?=
	<yongqiang.niu@mediatek.com>, "krzk@kernel.org" <krzk@kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"mripard@kernel.org" <mripard@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"hsinyi@chromium.org" <hsinyi@chromium.org>, "airlied@gmail.com"
	<airlied@gmail.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 7/7] dt-bindings: display: mediatek: tdshp: Add support
 for MT8196
Thread-Topic: [PATCH 7/7] dt-bindings: display: mediatek: tdshp: Add support
 for MT8196
Thread-Index: AQHbgq+5sxwOgnlvgEGophLUPTvB8bNOWu2AgAslXQA=
Date: Wed, 26 Feb 2025 11:37:37 +0000
Message-ID: <559fb0d86a25b7ad283eb71921128e8e11c507a4.camel@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
	 <20250219092040.11227-8-jay.liu@mediatek.com>
	 <4d8abd3f-c39b-49ea-8a43-b6ad0cf6fb15@kernel.org>
In-Reply-To: <4d8abd3f-c39b-49ea-8a43-b6ad0cf6fb15@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB8136:EE_|KL1PR03MB8260:EE_
x-ms-office365-filtering-correlation-id: 6665ae6a-e9f9-4970-3c2d-08dd5659f849
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?Y3N3WllGZXgwTDVsUVpDcEMyc0VJaElld1FsbFc4YUpGb0xKMG9ma0xpSmY4?=
 =?utf-8?B?WlpoOGs3UG5BL3FCQkI3TWtNV1ZkeVVHY0xFMk5YL2ZtL0QwZitkb21wYU0r?=
 =?utf-8?B?NGlHNk55WnRick9VTWo0WW1wb09SYUMvRms0TWJpSDZOcnZTY0M5MTFUb1RP?=
 =?utf-8?B?ZzJzM2JqUTBjWVJKRkJ2RE5iQ0ozbEEvbHZ6aE5na1k2TCtQMFM5dUUyQ3pL?=
 =?utf-8?B?N2ZrTUZrSzRPZ0lmSTIveXhzalYzTFlJSGVyMDExWHYzR3VyNTFzMjJqSUtp?=
 =?utf-8?B?aHhSck5SRVFGOVo3NU53d0cyUFBrMVVnSFpjbUU2OEZyTkZwVDEzejQ1SFRI?=
 =?utf-8?B?c3lpMkhnTkoxUWQ2aTNUa0orbWhYMmdFRXRoeFlVT283QzBQTUx3Q1RNbWdI?=
 =?utf-8?B?enljUWRtYmI1RnUvSWdGcnRtTWxzajBFYzIwOUVxeS9aMjdMTEpEQ1d3U0Iz?=
 =?utf-8?B?S0I4ajNhS0R4N0wydXJlZE1xR0hqbVJqVUx4N0k4bmJ3VEVpT2lOa0VyNFhC?=
 =?utf-8?B?OHhWRlR2OXZlKytpZkxDalJ5SGpoQldEMDYwMndHa1V1TWc3Zk4veW5VUnJi?=
 =?utf-8?B?WWZXQnVCZnA1M2dvNnFyblNsc2RqTHQxc1lkR0orTnVNS0Q1bGozcFcrMkpl?=
 =?utf-8?B?RW5BVUlNaEhkSE8rZ2ludStQRUxFMDhXREdlNXdlN1VZQWNtUDErZDBnbzQw?=
 =?utf-8?B?Q0NvbjR5MGlNcjQxUk9BQnYzT2h1ZklGTms4SlYrOHlKM2I1eHlxVmJCZlkz?=
 =?utf-8?B?MG9iaS9XTUtzQ2IySmZyWFdzckc4eWtZYVJzUFhJTGNUbjNDSzhlT09tSXoy?=
 =?utf-8?B?WlIxajJQRkczOWJvcmo4QkhKSkRhaVVVb1NnWG9EWTJkUzFvMURwNDFiWUxY?=
 =?utf-8?B?RVY0Szd5dWhxczgvNElXSXM3elRoS0NGSDl6UmlUbXBOUEc2cXF6TnRqVWhR?=
 =?utf-8?B?K0V5dDFJbDd6VnVWR1FXamhQZGNRY0t6clBmUSt3eDh6VXVueitXMkNZSm81?=
 =?utf-8?B?cVUyY3VXdGYxMWQwOXJaZ2JFQlRRVHEwTXdORGxaOERUeTFsVjdTMXp2Sm1Z?=
 =?utf-8?B?bjRITHRvTUw0RVQ1QVVOMW9vQUJrcEtiUXhJKytuZTNRTHpMSUpqTndrZlo0?=
 =?utf-8?B?OUFIOWovNWVPYVpvbzhRRkthSm9ITHByVlFlZHo2QU4rMzRlcXJaNU1CTHR4?=
 =?utf-8?B?Tk1Jc0ErVWc5QXhldkxNTVBYUTlDaklqSzJDWkM5U0F3TDUvS1QzL1p3bkV2?=
 =?utf-8?B?cndrWE9BTG9xR0xVZHVBUkRTOGUzYjdlQVhaMmNSZWJZdTByenRlczN6TUVk?=
 =?utf-8?B?VFRNTW1qT2NTL2JJWmdOdmNzYU5SdUpJOVQwOUhZVE9MemYvSm0zakwwZ2dK?=
 =?utf-8?B?emtFV0JEMURyWDVHcVNNNTE3RGZzSEZYblNSMzNJTVRZelpMZk1KZG1GUkxD?=
 =?utf-8?B?MC91bWtjQ0dRa0k2anJCK0Evcm8wZlJxK1V4SHlGRWFFeWdyZWlGdTlKWDdy?=
 =?utf-8?B?KzlwSnBqU2ZHRDZXUVM3bzZZTVlVSXdWS3F3NHlVbHlnMFE3cWZITk5XYWhU?=
 =?utf-8?B?eCtlUjJUazk1ZVgzOXZYMUtvdjd1VmNjbWlaaTJDbjM2M3FTNlZhN2R2cHJt?=
 =?utf-8?B?VzdrVDlsVGUxOVh0Skl1cEU5THAxUFcwUmhkYys5VkxseldZbWVlQUxacTg0?=
 =?utf-8?B?bnVlSENDbkdtazl1b3RCYXJlTnY4cnNkTGZha0JONHBiZlZBd0lpZ21MV0Jo?=
 =?utf-8?B?OVNzcnhXNEJEclNKUXgyVVlFb3BCa0RMbllVT1Fkai80MUcvQzYwRXJQS1Nq?=
 =?utf-8?B?SVBaekRwazFkSjlIMnphQWtHNGQ3QTRsYy8valVVWTJCK05oNGt2cDVsRnN0?=
 =?utf-8?B?QlU1N3I4QTVQaUFXT1daVGZvVThzdjAyT3ZibUNVV2puV1VyTjFnS1lSb0s5?=
 =?utf-8?Q?Io4V/8HTbs0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB8136.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1ZicU42RkxnTDFvUGs3NmZ3WDg0bTFKSko1UXFFOVpLdmJXeVdQc0QyamdJ?=
 =?utf-8?B?WjRQNHVyUkFTelNhWTJCcXc5eVJSa1JEZWFUYzhDU2ppUkpZUUQzbUUzVGZi?=
 =?utf-8?B?WkRYV0FVYVlCNE9hR1BIbVZSWUZPYitpbEk0UUlKbUcxQzVhc1hZY1A4R1RR?=
 =?utf-8?B?Q3JHQmdmOUJvZ0NQN0JLU3B3aHFWWnlvVTRRY3pBQ2tqS2RWaEQ2NG1aN2wr?=
 =?utf-8?B?UjhwWGFFYlVkKytYOUErZ1EyNkpFYW5xdDlTZzI5V0ZOQWMvNk41cWMvOEZn?=
 =?utf-8?B?em5JQzg3V2wwUUM4ZHFqZGJ0d1VGanFWYjE5RGVWYkw3RHpnYTRqaEVjdVEx?=
 =?utf-8?B?Q2J0YlNYQWtlaUcyVFdHNHVYekpDUlFqRFFCTkRlN3VOQnd6WXZlNzYySWJJ?=
 =?utf-8?B?ZCtvRGsyYjNmRTN1eGF4Z0lTRWlZMzdQd3diSXF0YWJPaThOWVowbW5ZVG1X?=
 =?utf-8?B?MURHc3plc1FSMzNIUjY4WVhZdEZteVBpbXVuUDJWeVBIMHpubVl2V2VINW9y?=
 =?utf-8?B?YXgxR0c0ZHFpcE5wT3VmRmlaRVNCbUZ2dTBjSkl3aHpGWVYwNEFCYy9WcnND?=
 =?utf-8?B?UFVXZzFxOW9wanVNZ2hPR3I1Qmt2QmdCb1Q5SXdjSnpkS1hiVEZWTW11N0l4?=
 =?utf-8?B?L21zdzhiWndYczRHeHozcWRidzBId1JEM2VQY3dpMDNwVlFMYmhoQlE4aWxt?=
 =?utf-8?B?aEx6WEFWdmN4M1ovQkVNUmRwRkpBL05qeGlWN3R4T1ZqOGUyeWU5N3hsMDNi?=
 =?utf-8?B?emYyYytnUkpIY21VT1pYOG0zL1FFR01mU3N6ZXJtSENDMHp6T3FvOTBsdlpE?=
 =?utf-8?B?UXJpSGZVazdXaWhNMkpLREdiQXVLaDYzam5YMG42V0hDMXAwNXhKSkJ6ZWdm?=
 =?utf-8?B?RzhSRGR6R2lYZmQxMTk1TEI2Q2VIK1BXaXdjdmhFaGZ2cUJST0hYK3BSOUZ1?=
 =?utf-8?B?UFZqNTJzTkJ6UmltRXpmdWs4dUIwcGVoZjZUWjdCbHNwMGlzYkJINHo0THdM?=
 =?utf-8?B?SmFYTGxvWjlXdXdXeW4zSXFRUzJuYXdZaG5KWUZ2anNDRzNmdVZiMDRMTnQy?=
 =?utf-8?B?dGREWnM4VjZPWDRDNGJlNzgwaEhIRnFmalVzZWJ2REM4ci80dmkzcm1RSExD?=
 =?utf-8?B?MjY5R1NKb014ejgxSmJmM2FYaEI0M3RFaTUrTmFUME82SHVZT1Iwb0Fqd1E5?=
 =?utf-8?B?Z3djbU51MXZ5NXM2T01la2RMV1BOWnJYcS90cFkwZHM5SEwxYklBQk5FWmlD?=
 =?utf-8?B?VTgzUE80amNFRStaYTNkYlNMYlI0aHJtRXBZZFNyd0E0ZXNPcjJVL1o0OHFv?=
 =?utf-8?B?WlJVYXZ5TWRiNElYYXdxRE4yWWo1OWRJTW9LU0RFUUJ4NVpHK2hQTjJZQUNt?=
 =?utf-8?B?QVlaNTNoTC8xWWlGaUlpUTExU2N5ZnJwYXNwdjdUMldXQjJUQWpoM3hlaHVO?=
 =?utf-8?B?d0JmQUcraHBTdzBKSGJ0YVk3OC9DYzNCeUM4MGtYS3NKRXdpYmVHMy9DRG9x?=
 =?utf-8?B?MWhtd0lJTmFqZEh2QmgxZHp2dldNR05ucVVISEhZbkRKVDhWVjd1OUxQQkdV?=
 =?utf-8?B?cVpIekRZK1ZCRVNicTlaLy9aSkQwS1ViQWZ4TnlwVVpzUi9oS0I4NElxamlz?=
 =?utf-8?B?c29EbFhFYW4rTHRGZkFQQ2xEbEM1WlJrdjhpOWhsZFZvckhOV1hyamNuYmJj?=
 =?utf-8?B?eFRzMk9RQUhjK3lyUjJNMllTN0piakQ3OFppNGpqVFZOTXQ1TWt6dTF6dHlO?=
 =?utf-8?B?R2NFTENOckpEdzE1Q2JJbG1UTi9zRjA1TzJBQklFSm9sZ3FIeXNucXlzSGJH?=
 =?utf-8?B?cTRjNUpCcGR0U1Q2ZWM5SmRqK1hudnU5SXd6VUtkeEh5UE4raENTeHNFTzd2?=
 =?utf-8?B?MEJpNGo1bGozY1RrSTJnR3o4RW5VblllUG83UE81RC9rOE4wOWpZVkxqY1o3?=
 =?utf-8?B?K0ZYYU9kNmlFaTFLTGlQQmVrb2d6WDhKTm9mT2JvaUpiWXY0bVhRN3dWT0tG?=
 =?utf-8?B?TTlIcE1uNENObTNRRFNxaTZPblMvQjZ3clBXRi9BSHlrcldITFcveEkxZ3pF?=
 =?utf-8?B?anFhZTZmTFF6QVFpaXh2dnNyL1VVTnVBZnB2Tzh0dnRGdkdlYTFlcTFWSURK?=
 =?utf-8?Q?uqRYrnXx4zUE8yfQE6RCoHwM0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1039F0C2E06AD64B833C3255020A6084@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB8136.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6665ae6a-e9f9-4970-3c2d-08dd5659f849
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 11:37:37.3655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ++c/t21ENLAcrVjLVoyemui7Njyu0MnwUTkq/khmOYDORHpL4uLxRvSaHtRp6NOKiC1I3+vpLaisORpux/y1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8260

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDEwOjI1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDE5LzAyLzIwMjUgMTA6MjAsIEpheSBMaXUgd3JvdGU6
DQo+ID4gQWRkIGEgY29tcGF0aWJsZSBzdHJpbmcgZm9yIE1lZGlhVGVrIE1UODE5NiBTb0MNCj4g
DQo+IE5vLCB0aGlzIGlzIGp1c3QgYm9ndXMgY29tbWl0IG1zZy4NCj4gDQo+IFlvdSBkaWQgbm90
IHRyeSBlbm91Z2gsIGp1c3QgcGFzdGVkIHNhbWUgdXNlbGVzcyBhbmQgaW5jb3JyZWN0DQo+IG1l
c3NhZ2UNCj4gdG8gZXZlcnkgcGF0Y2guDQo+IA0KDQpoaSBLcnp5c3p0b2YgLEkgd2lsbCB0cnkg
Zml4IHRob3NlIGlzc3VlIGluIG5leHQgdmVyc2lvbg0KDQpUaGFua3MgYSBsb3QNCkpBWQ0KDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmF5IExpdSA8amF5LmxpdUBtZWRpYXRlay5jb20+DQo+
ID4gLS0tDQo+ID4gIC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLHRkc2hwLnlhbWwgICAg
ICB8IDUxDQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTEg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayx0ZHNocC55DQo+
ID4gYW1sDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssdGRzaHANCj4gPiAueWFtbA0K
PiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsv
bWVkaWF0ZWssdGRzaHANCj4gPiAueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4g
aW5kZXggMDAwMDAwMDAwMDAwLi41ZWQ3YmRkNTNkMGUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRp
YXRlay9tZWRpYXRlayx0ZHNocA0KPiA+IC55YW1sDQo+IA0KPiBGaWxlbmFtZSBtYXRjaGluZyBl
eGFjdGx5IGNvbXBhdGlibGUuDQo+IA0KPiA+IEBAIC0wLDAgKzEsNTEgQEANCj4gPiArIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4g
KyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gPiBodHRwczovL3VybGRlZmVuc2Uu
Y29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRpYXRlay9t
ZWRpYXRlayx0ZHNocC55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbnI1ejN4TVRCVWZiTmZt
emtQMlA0X2dzMGhIanY4T1hlbUg1MmlwZ3EtWU5PVzRJVkhJTWExY1lZblltWVdkYW5GRmFpZ0hU
d2xvWCQNCj4gPiArJHNjaGVtYTogDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5
d01nMEFSYnchbnI1ejN4TVRCVWZiTmZtemtQMlA0X2dzMGhIanY4T1hlbUg1MmlwZ3EtWU5PVzRJ
VkhJTWExY1lZblltWVdkYW5GRmFpcldDdUpfNCQNCj4gPiArDQo+ID4gK3RpdGxlOiBNZWRpYVRl
ayBkaXNwbGF5IGNsYXJpdHkgY29ycmVjdGlvbg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+
ID4gKyAgLSBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCj4gPiArICAt
IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4gKw0KPiA+ICtkZXNj
cmlwdGlvbjogfA0KPiANCj4gRG8gbm90IG5lZWQgJ3wnIHVubGVzcyB5b3UgbmVlZCB0byBwcmVz
ZXJ2ZSBmb3JtYXR0aW5nLg0KPiANCj4gPiArICBNZWRpYVRlayBkaXNwbGF5IGNsYXJpdHkgY29y
cmVjdGlvbiwgbmFtZWx5IFREU0hQLCBwcm92aWRlcyBhDQo+ID4gKyAgb3BlcmF0aW9uIHVzZWQg
dG8gYWRqdXN0IHNoYXJwbmVzcyBpbiBkaXNwbGF5IHN5c3RlbS4NCj4gPiArICBURFNIUCBkZXZp
Y2Ugbm9kZSBtdXN0IGJlIHNpYmxpbmdzIHRvIHRoZSBjZW50cmFsIE1NU1lTX0NPTkZJRw0KPiA+
IG5vZGUuDQo+ID4gKyAgRm9yIGEgZGVzY3JpcHRpb24gb2YgdGhlIE1NU1lTX0NPTkZJRyBiaW5k
aW5nLCBzZWUNCj4gPiArICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21l
ZGlhdGVrL21lZGlhdGVrLG1tc3lzLnlhDQo+ID4gbWwNCj4gPiArICBmb3IgZGV0YWlscy4NCj4g
DQo+IE1pc3NpbmcgYmxhbmsgbGluZS4gRG8gbm90IGludHJvZHVjZSBvd24gc3R5bGUuDQo+IA0K
PiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4g
DQo+IERyb3AsIHVubGVzcyB0aGlzIGlzIGFscmVhZHkgZ29pbmcgdG8gZ3Jvdz8NCj4gDQo+IA0K
PiA+ICsgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5Ni1kaXNw
LXRkc2hwDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0K
PiA+ICsgIGNsb2NrczoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJl
ZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gY2xvY2tzDQo+
ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1w
bGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsNCj4gDQo+IERyb3ANCj4gDQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0K

