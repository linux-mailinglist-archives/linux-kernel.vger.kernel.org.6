Return-Path: <linux-kernel+bounces-552285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E5EA577E9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 04:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73C547A9029
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 03:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C193157E6B;
	Sat,  8 Mar 2025 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SybMq0BK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="BeZDNjbt"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9988415278E;
	Sat,  8 Mar 2025 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405183; cv=fail; b=ddsVlQpEKtgwhx+3p5uDrgEOxBN/rGJct1XJr6v7I2fX0GxSa1e8mfcgD5h8UKvu9Di63T44b8xyTAx7VtG51/ylBMKgFaVbmKann739cVcR6ShO7kvI8KHSzj4GzLIPl9Xw8swwIVWVi1BtPr2kmlECLKHG4VbR3dwEmU27oIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405183; c=relaxed/simple;
	bh=flRzKZf1Yfs61GDpku1v647cnXC3DpuNwUMgFQQU8Dc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7ILyoQf6Ask5JANESSoXFBCcGzQ9zqKALzP3GckUcxaiBCQEoh5zJD1aq1MhjVKRJbK6pjGs85QDIi27g1hqVjCw+E5Cug6AC+eOq3R40iEUjCn87nS0KSHKLAW0whyw0sQ7L+AGJkbDo9S4rZZZRobQBoZ2AJBcZZOzR1Ly5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SybMq0BK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=BeZDNjbt; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f49bac3efbce11efaae1fd9735fae912-20250308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=flRzKZf1Yfs61GDpku1v647cnXC3DpuNwUMgFQQU8Dc=;
	b=SybMq0BKeR3lWgYqex0dcrIengnk632NK60qe7hbwRRZcMd7zG9uEdgFysPlrLdUtZ9rSeFyFXIQPAjLUoCIBlP125EPZxEJa5FDU27GJ6D78Ex4DcrHQVVW62HtlhrJPkiidiKaAFAGgNrms58AxBDbtVgm2DUFiEgaEBESiZU=;
X-CID-CACHE: Type:Local,Time:202503081132+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ae29427b-5dcf-4c8a-9175-dec43b0bd10e,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:0ef645f,CLOUDID:ebed1a8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: f49bac3efbce11efaae1fd9735fae912-20250308
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 89579245; Sat, 08 Mar 2025 11:39:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 8 Mar 2025 11:39:34 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 8 Mar 2025 11:39:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRskAFt6ZxI8bLPmF76Xxm1TaYXUExCS46uEhDe53U1Hv28UfbQma2fKXRVpBxmJUsH0CWIXUl2U1NoDk3bE0hs/RoRMfN5esEumuGTXFhcGN/ZTv+W1Q6Ix1IL01lHWUc/ZI6OJz014/Uv+TpaQexPHqIAq9o0VvKwbh80ZcShXoX1buUpS24xSmaSjAyL4C0TEIH2K+Ev7nKayrvG5yjDp7HgDXZoxJRejQTgl5I6He9TQBjj+UWc7VZ3ohB/BzneJTNweOuezwpJA/s2tvj8hcI6m1n3B6jDWlOV1zwdmsqHLr7/SFdh8sU4TeQik0vhh6TaYg9tZuzppxobXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flRzKZf1Yfs61GDpku1v647cnXC3DpuNwUMgFQQU8Dc=;
 b=LJluDQqy+Clmat8ppbmL6LJZ8JZzdiMayjT87x51CoFulLGkpyAwtUqpka/7T97WAhBbb/FMt1RoILaj6Wqb4yE2yc2EwKnKoV8AQtQGOuyiml3Av924aix10bOzvZahfBY0YDDy2N8VF+7SMI5OXPlmOIPwFD7noW9xP1EFRSC2NfMgNikmH3+Hn84r/6k81NvhoLPuHPaSfquHkGqyPN82JHK30Vy5z7vL/jWYw23pwJb8xDC5xKM0rMB9JbYvf7+YVXpxhTQobo5yUZV+B7a00wTCyGdebD+mSGmAnzINtVyREjNVkREgihrR/kvfHGQzf1JNGLz/V486rcvlCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flRzKZf1Yfs61GDpku1v647cnXC3DpuNwUMgFQQU8Dc=;
 b=BeZDNjbtDTYffLAGGdcnOZTSR/Lx9OuBkUwxehXg1VYuWnf8GKB5l85P7o38CD/AQBySOaWSVkgygasjCNkXMaem6fYFspbEgm9uXSSg8/T9qMt8lw8LftG2HTFhW33dY93Nz92KqRGCRgyuzbQRognI+Pyma19T1d33bwve8uc=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by SEZPR03MB6713.apcprd03.prod.outlook.com (2603:1096:101:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Sat, 8 Mar
 2025 03:39:28 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.8511.020; Sat, 8 Mar 2025
 03:39:28 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH RFC 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk
 vcp-mbox document
Thread-Topic: [PATCH RFC 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk
 vcp-mbox document
Thread-Index: AQHbjaeHfEKKbx+Drk63d7IvlbhforNkwPeAgAPbHIA=
Date: Sat, 8 Mar 2025 03:39:28 +0000
Message-ID: <f1cc982deb9770f386b7320cfc75969daef09538.camel@mediatek.com>
References: <20250305082047.15746-1-jjian.zhou@mediatek.com>
	 <20250305082047.15746-4-jjian.zhou@mediatek.com>
	 <20250305164627.GA2117924-robh@kernel.org>
In-Reply-To: <20250305164627.GA2117924-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|SEZPR03MB6713:EE_
x-ms-office365-filtering-correlation-id: f6061c6c-0442-4e78-5abb-08dd5df2d473
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RDFkMVQ3Z09DY01tVWp6RkVVN0ZDSnd3Zmg5K0VHcVpVTk53NFR6S3gzcUlU?=
 =?utf-8?B?aWNuWmNNSEZDbE83NjQxbm5PUDB6UE8wZWNpMWRTbjI5b0hUVm9nbEV0QTVF?=
 =?utf-8?B?NFl3ZEg3aGFmQVJJWHNrbXlJZ2JlbEN4SC81VzFsdVU1bE9iTHNWVnZIekda?=
 =?utf-8?B?clgwR2lBQVRlSWpUak9XVTBNYm1GNTc3TGZzZm83cnhzbzljSU1TM0Y3a0Jz?=
 =?utf-8?B?YW5aUXFydDRqRzRzM29KWjZoOHpOQXhmQVQwdWlvOG9tcWttQVJrOW9OQXJL?=
 =?utf-8?B?WmVIVmk5alNSVzBkR0VZUWVLbTVzZldxVkFmTXZpbTFYd21uV1BFa1RWWmd5?=
 =?utf-8?B?V0ZpR3NnbEltNWZiWE9jVHpMd0Y5REt3elg5cG5RdTNqaW50Nkc1VC92SERS?=
 =?utf-8?B?anduT3p6cTlTMUVXZFhQMnFzZ3FZUFFXZ0ZMVUE2ZWFRbEt1QnU3Qi9uODZP?=
 =?utf-8?B?b2dXcWF6SDhRcVhLVjZWNC9YSk5acitDUk5ETmRpOGFuQlIrQWVGM1c2ejhs?=
 =?utf-8?B?RjNjR3N4M0hJbWZBTG5VN3lJQTg5QXZYMVhvYVdrUm1uUTk5NWhIZVVZcUR1?=
 =?utf-8?B?akdONHd1Q3hMVFExNnN1anVZOFc4N2pHbHduWDFYb29FbWwxK3UxUllkWjNI?=
 =?utf-8?B?MEJIZGx0Qit1OFowZklibnoyU2xSTUNMRmt2RldSS0dtKzZJeTVQQXlNRWEr?=
 =?utf-8?B?NnVJY2pGL21XMXpsY0c1Mk1vaGNJaC82dHBubGdCdnJnTkVGaVFtWVhMQkdC?=
 =?utf-8?B?N3M1Tmw0RS9zc0JNWFVZcmFySEYvRXZtc2phR21Rb0IwNTJXNndSWWxKY3Zr?=
 =?utf-8?B?US9KTkFobk9yaTEzNHAxS0xoQ1lCNEhXV3FFWDBqY0ZDdGNoWlBjaUY5VVBO?=
 =?utf-8?B?RytkY2RFNWhuamZVOXUxNWlzbFBMSnJ6VmZmVGtZbkJ1YzBwRHpKQzhqUlhz?=
 =?utf-8?B?UHd0NnFaazVMUGdDQTRCZU9GTkJJUXJjTjNMakV5SlFXZEdMdTZReExOY1Zv?=
 =?utf-8?B?NURPOTBKZUluamJJT0w2M1BUT2lWSHVXSlo2d3BtSVl0em0yYWFxYUNSUTlK?=
 =?utf-8?B?NVU4bUw1NHErM3NYUldPK0ZzM2xEOHNnbVFBcjIwM0laWWZhQm1KQ0Q1RmNQ?=
 =?utf-8?B?MHNkU3U5SlByaTJ4ZUtVNitHSjVnZ3FmWHQra0FkQnpONkQ3Ukl1cGFhR0U5?=
 =?utf-8?B?VGhENG5GZnlGVE5hQnVZVmpxdXVyamhQSWIxSVZhajdMQk1qVzFDUWNJUm5m?=
 =?utf-8?B?ajBiK1dDY0NyWDZzQmlPcUQ3R0RCenl6Q1kyWFk3QXZIak5nOEhVQmM3OWxV?=
 =?utf-8?B?TTdwTDNrb1k0Njdsc3cydnNVdEc0NnRyZzJjUzNNS2lLTnhqU1pKaHlFM2h4?=
 =?utf-8?B?Z0g1emJqWElRYU02WkNaWURhRDJJVlFtMHEvSncwc0tKektuZm5KYW9xbFlq?=
 =?utf-8?B?TUNQc05CODJWNnhLQnFNRncyNEV4QzZVWjRjQ0RqakVyMzNCSXE1SFBZbjM5?=
 =?utf-8?B?aGhjbFJhVng2T1ltQi9KcEYzLzhUZ01ybmR5cEIvUCttdWV5QTRQZjhUeUdK?=
 =?utf-8?B?VXBBdnJ0R1VmaHEyQTRqVWJVL2JPM0V1a2M1SnZIazRTMG9zVWdtRTBSWERs?=
 =?utf-8?B?SHlaNTRZQTdwQ2lrbXAxMzRXOGJZNEFBbnRBV2lFZGFWa0tPNWloWmFtS3l6?=
 =?utf-8?B?U3hoQjBrb0NDbFVmQjBNTnYzV0o5NzB0TVB3MmdMQlVGNkF6Z2tULzE5czBW?=
 =?utf-8?B?c1BUTWx0NGttOEN2M215UVlKSmg4c3paeERyamxzRk5XSnZjWGJ0d3RlQ0Jr?=
 =?utf-8?B?MGlhL29EWk5HQnFLN1FNLytMMkEzNzJmWk9YTzJPOEFEZjgvc2tiUzdwT3JV?=
 =?utf-8?B?SDRMNXdLWkxwQnlGbEVlVnhPWlV5L1Q1amFTL0YwSDUySlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1dTYzBrL2l5cXlBazMzZzBveUYrTlRqT2lDMlVuekRjN1ZxckVyWC9XMlVK?=
 =?utf-8?B?RzE2bksxKzk0MUpQVm8vWi9NQ2JCdUZTdHdkQkpuUjFicFE0amFXNjJDQnNV?=
 =?utf-8?B?WisyMXNESlA0YTZXZTlaQkVtVGZGcG1scnJsdjhha0tka2gxRGdBM1cvUDhT?=
 =?utf-8?B?bHpuWi9oMC9Gdnp6SjhWOU91UnBwM0dvNWtGMGNjMVoxQjJXc2V1SEJhTnNH?=
 =?utf-8?B?Z0lsU2R4Q3BOWTRESG81UlBUcHlmVm1qbUhPOGhVOGxWSHpvR0ZqbjkxZUpa?=
 =?utf-8?B?N3Iwd0pocXRqNTdPSGVRTVFxTkIxUmJ6eEl6RjYzSVJnQWJaTk4zTE5GeGxl?=
 =?utf-8?B?OEt5M2dheG13RUlHNGtjSnNJTHIzUy9yYlh3Q1crTTh0U1AvcWYyZHkxSnBk?=
 =?utf-8?B?TnA1Vk5aZUJadGtiUHFjZVFPd21qM1lvdGc4MEE4NEwzTHVtMEZ1VDhITTMr?=
 =?utf-8?B?Rk5rcnFTc3FMMm5kUk82SEEwbUVpZ2tsZkh0NDB4U1AraGovdzNEaFc1S0Zx?=
 =?utf-8?B?L3N5ZE1USk1xeEtwRlJ6Y3FBZGVFRldCTk1qY21ZN2x2eWhCMTJuWVAwTXpS?=
 =?utf-8?B?SkpjVTVxbnBqanl3bEJHMXVlTDY4NWNHMkZ6NmRIMFhCL1Rlbyt1YkpLSTJN?=
 =?utf-8?B?YmN1TGYzQzgwMWFsMUt2MTBCSUkyRFRKdDJUc1p4djlyR3doM2sxRUZDMUdt?=
 =?utf-8?B?bVRXNjNvV2lTcVFDc1dtdUpjdW83NTlYTlpJdUs0TlplbVUyRU00RVd4eTFi?=
 =?utf-8?B?VnNsVlBxbWRlNmV2OUhkdlc2K0prTmkreGl0NkVHTURGY01UMXZpRWFkQzRQ?=
 =?utf-8?B?d3JETUFkTUZOQ1RHRndPRlo4WmdRNG05b1JOb2lheFlSSDNpaGxVMXlNbHNu?=
 =?utf-8?B?bmZtUExId3BRdUZpdTRGSjg4bHhUeVlEWjI3Nk55WHVQdWNwYjZZYTI4WEt5?=
 =?utf-8?B?Tm1PRUpXcEhwaVN0cGxsa2liRDJrUWZnRS9VOEVYZXlpRzRXUnBSNGRNY2RT?=
 =?utf-8?B?bHdNNXZ1dit1dVdIUlpmZFpicHVCRUhzeUdrNHdlNkV3STVFMXZOTFgzaW5V?=
 =?utf-8?B?bUUzS3BxQjdyd2tyLzdoNmZaeEdCTTZndzZ2OW01WWlZUTBYTTFzdy91eUpl?=
 =?utf-8?B?R280QmtjZVpDaEp4R1VqbGJhSHpmME5HTlZhYkVIN1d2Sk4rbkEwZ0xkSWJa?=
 =?utf-8?B?aWpYR0xxbllHdEx4bjc1eVVZVVFxR3pOTEU1TXNod3B3L2EzQWZycGEyRXJq?=
 =?utf-8?B?VnBlWVNSTUZuZWwyL1YwTDJoaktKdDhCaDJ1TXJ0NjRwNkgvMWc2cmY0bmFh?=
 =?utf-8?B?MEplYkl4MEdYcFQwaGE4bmYvZ0NMWFVvNzFrSlZxNmpiVnlGc0c4Y0xkREV4?=
 =?utf-8?B?d1RndmdSNXVYbVoxcTlqSjV2b05KRkNWcmtoemcycmUxNDFsSFhaSkZMMWFV?=
 =?utf-8?B?TzBHRWZPa3dlR3FkWER3OThSRGtxanBXR1JXbHoyS0xaUzhwdXIvdnRyZDVz?=
 =?utf-8?B?eDJNNi9oYXpRTlMycGVreHBGOVNQUllTaW5FNm9JOGJqbEpPTThKb3lBUmwy?=
 =?utf-8?B?RmQyY3pLZTFJdGNRWElzTnlTditvSnFqQWl0WVM0bmQrRHNtZ2Q0MHpRZzUx?=
 =?utf-8?B?VGQyMWIwU3lNMzdYZjJEV2NRMVlFVzZqY3BJSzg0dHNqdUM0Vi9hbjZtamFM?=
 =?utf-8?B?NllaejdVK1p1UERzMGd5OUtIa2JGYlQ5ekJhb2xDcWVFVlNWRDRqWkVGNkN0?=
 =?utf-8?B?WXhyMXJwS2RJQ3MrWlI1UzQ1akpnRUNlNDJTb2tSbVA4aEtkZ0tCTXpVOXVO?=
 =?utf-8?B?NnQ2OFlCQjQ3Z1BDU3hqeVhpbkN0UDdrbUM2SU92SWxQU0pwQ0NKUXYyZFFy?=
 =?utf-8?B?K0drcVNSNmR6YXdZSm9rb3owcWhvUzFEQ1ltNnMvMzd6aGVmTVc2QlFnSmpL?=
 =?utf-8?B?a3BCYUtqYTVHSXdoT2FWcHd1ZFN6UzJjcDdTMWxJRmFRWkUyZUF6VnZCRGFZ?=
 =?utf-8?B?MzhRL08vM1JTS3Z2TlRQeGxLSXpHVDBPUUtXbmR4cDRJUGEyUmlGZHUydnpR?=
 =?utf-8?B?T2xvNWJVSU1odElzZXpLUUJhbllGVmR6NzZjVDQ4ck1aZ0l6dDdMSEZHMXR3?=
 =?utf-8?B?Kzh4Mkh5dERsSWJocHlVdVkrb09CK1U2RUZibThvdThEdWYyMFFDYjFvMXg5?=
 =?utf-8?B?R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <432B1BC4A58FEC4F9EF1AE62C0D5CB04@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6061c6c-0442-4e78-5abb-08dd5df2d473
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2025 03:39:28.3719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xNtxDcciVzkGq2U148KLc6Dzkzox65z83p3KSsxn78KwCZEerty8NuVRcE/7wgRskSUyH7Ytr0bcIA/CPwY26Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6713

T24gV2VkLCAyMDI1LTAzLTA1IGF0IDEwOjQ2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBXZWQsIE1hciAwNSwgMjAyNSBhdCAwNDoyMDo0MFBNICswODAwLCBK
amlhbiBaaG91IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBkb2N1bWVudCBmb3IgbWVkaWF0
ZWsgdmNwIG1ib3guDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmppYW4gWmhvdSA8amppYW4u
emhvdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9tYWlsYm94L210
ayx2Y3AtbWJveC55YW1sICAgICAgICB8IDQ5DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tdGssdmNw
LW1ib3gueWFtbA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWFpbGJveC9tdGssdmNwLQ0KPiA+IG1ib3gueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ayx2Y3AtDQo+ID4gbWJveC55YW1sDQo+
ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmQ1YWZlMjk1
YWYxNA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbWFpbGJveC9tdGssdmNwLW1ib3gueWFtbA0KPiA+IEBAIC0wLDAgKzEsNDkg
QEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0Qt
Mi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiANCj4gPiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWFp
bGJveC9tdGssdmNwLW1ib3gueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IWh0TlFVN3B2MnBy
Z1dzRXluV19mTktpQnpYRnN2dXpWcXEzcGxwaWxqLUk2bnRVRGNvclhUN2MtYVNoOHVscGZYWDRN
eUVhTUxhX05OdTE1JA0KPiA+ICskc2NoZW1hOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29t
L3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXch
IUNUUk5LQTl3TWcwQVJidyFodE5RVTdwdjJwcmdXc0V5bldfZk5LaUJ6WEZzdnV6VnFxM3BscGls
ai1JNm50VURjb3JYVDdjLWFTaDh1bHBmWFg0TXlFYU1MZk9TaXR0TiQNCj4gPiArDQo+ID4gK3Rp
dGxlOiBNZWRpYVRlayBWaWRlbyBDb21wYW5pb24gUHJvY2Vzc29yIChWQ1ApIG1haWxib3gNCj4g
PiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsgIC0gSmppYW4gWmhvdSA8SmppYW4uWmhvdUBt
ZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiANCj4gRG9uJ3QgbmVl
ZCAnfCcgaWYgbm8gZm9ybWF0dGluZw0KICBJIHdpbGwgcmVtb3ZlIGl0IGluIHZlcnNpb24tdHdv
LiBUaGFua3MgZm9yIHlvdXIgaGVscC4NCj4gDQo+ID4gKyAgVGhlIE1USyBWQ1AgbWFpbGJveCBl
bmFibGVzIHRoZSBTb0MgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgVkNQDQo+ID4gYnkgcGFzc2lu
Zw0KPiA+ICsgIG1lc3NhZ2VzIHRocm91Z2ggNjQgMzItYml0IHdpZGUgcmVnaXN0ZXJzLiBJdCBo
YXMgMzIgaW50ZXJydXB0DQo+ID4gdmVjdG9ycyBpbg0KPiA+ICsgIGVpdGhlciBkaXJlY3Rpb24g
Zm9yIHNpZ25hbGxpbmcgcHVycG9zZXMuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsg
IGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10ODE5
Ni12Y3AtbWJveA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+
ICsNCj4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4g
KyAgIiNtYm94LWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAwDQo+ID4gKw0KPiA+ICtyZXF1aXJl
ZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0
cw0KPiA+ICsgIC0gIiNtYm94LWNlbGxzIg0KPiA+ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4g
KyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+
ID4gKw0KPiA+ICsgICAgdmNwX21haWxib3gwOiBtYWlsYm94QDMxYjgwMDAwIHsNCj4gPiArICAg
ICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Ni12Y3AtbWJveCI7DQo+ID4gKyAgICAg
ICAgcmVnID0gPDB4MzFiODAwMDAgMHgxMDAwPjsNCj4gPiArICAgICAgICBpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgNzg5IElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQo+ID4gKyAgICAgICAgI21ib3gt
Y2VsbHMgPSA8MD47DQo+ID4gKyAgICB9Ow0KPiA+IC0tDQo+ID4gMi40NS4yDQo+ID4gDQo=

