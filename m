Return-Path: <linux-kernel+bounces-356220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DADB2995E13
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40309285662
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD37710C;
	Wed,  9 Oct 2024 03:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ToisgZjf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="W5bqOae+"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0A62119
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728444191; cv=fail; b=XzIzP1Cez/Q3wp8cgDxbt3MJjutlEo3Pw7l3f4siABSLJjKVN/alWjgmzZaB6IP8SjeA5OK+/1r38C8sjHsE2FU/7qLh0L9q2eI1y1cW6/YjU3l9nlHprWVTnwnaLjQ0fEVkQqDqTBT4gpi6H4RJbcou1oAmMMTdADtWiqk8H9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728444191; c=relaxed/simple;
	bh=7l6l8OgcE2eWHAGpRTrEHWmkiaXgv7KHDj3OQvsz7mU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DgRW86xWvCOFZlPY2/qwIG1htw+l4A9hXiAYANYOKW6D45ZCFJxktW+FwSEsSNmsN9XBTwU0G8jyuLJT3OgIIF24xo4uG7CYWTpt95EFkztF8Ak98EDbKLR6PXtzfPeyxytECn/YdezNWLnateS5AHdhGtvJSSTKICLoXVcycrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ToisgZjf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=W5bqOae+; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cadf3a2085ed11ef8b96093e013ec31c-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7l6l8OgcE2eWHAGpRTrEHWmkiaXgv7KHDj3OQvsz7mU=;
	b=ToisgZjfpgSE/CRMcHY3dbnxieArtyGsqM+O1IATDMp/2j3B3x8X8FJ2IZF4UpYJ5aX5Ib//jOVlDIypiB80+s1TwNHbhaqrcWwek7EsbN3Q25Zpd6QHSicvFQ7mocj4m26vUaCG8yY5TmO+qFiBoK8Kn4k2+z+i7/zjSMVenc0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:99c39a8e-90c5-4f8e-8c0c-6a5d21e703a5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:9e09f764-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cadf3a2085ed11ef8b96093e013ec31c-20241009
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1557480528; Wed, 09 Oct 2024 11:23:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 20:23:01 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 11:23:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHYMExKs/jMJNVwWItjeZjUu1DfEjcHcKOkG3Xx1mEYoVGfT6mlAhScKPbxFK86gjPddChvdPS1Ne0XVThygHuVcACJrmeV4RcnWM99MsxU0eL49owWw+uxG88vDQydtpZOK4pD0F+xOvXf8qCNnucn+4SN/Fh8Gp1hiTf0FTrWttXGO59YCG2atGTc0VJ4U2LbJI9NWbvnJf490juSeinZS/LmAT4VwI/avUrk7n9UkX/YllFMNlmbvX8VL473QmWXzrBneR74DJ7DmsDae20Oj5yNxne0xZ4OZ+SJemWDOLLl9OpzVRWWbGtUMxfDsCzwRDKvf8BGTbJB72NXbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7l6l8OgcE2eWHAGpRTrEHWmkiaXgv7KHDj3OQvsz7mU=;
 b=n6SVYWgb+T09WZ6mkfFftq3szbR2rJQeYzQtCzXInleGdb/Y5SUlXYSks58ceh/WrCTRyjiHB5tlVKQmXFRrmwEmEx4z7Gf9kcs6ONDVSuf6ZCf3mq2Tu3QLZzRPbfpU3LZLGzL4ohh/HfHT9J9q5NqxhpLMTjb17IEVXvW+GKgUQ1MGq3auabYYIYrj+ttDeybfklAoAnZyy2h0NmJotzO7rqDKt9pXTSWYIsNQaxplJSPPdh7Z2mkOQYwbseMrw1TakAERo75SLdqCrAxW2Al5guzi6qOoYKzaxPZVfQcUth6g4mFmykxrzdbPdhePS2yX/jYfyLNWLUWyGg0eCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7l6l8OgcE2eWHAGpRTrEHWmkiaXgv7KHDj3OQvsz7mU=;
 b=W5bqOae+380lthKfODpy3nWSaDuK6gmO6OMWd5//saAWm9EJ4jfp5uAY1pWXouxKG+1k2bTxeuVnqB3HRZTC1pboKVOrw9NycyPhQ4imJBhhrEqp6dMGWWt9isZlkzTcRLzVQT7mywjpHmagHfaggW8MTV4QdsMlEAXnyHw0EIg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB7233.apcprd03.prod.outlook.com (2603:1096:301:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 03:22:57 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 03:22:57 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"me@adamthiede.com" <me@adamthiede.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "yassine.oudjana@gmail.com"
	<yassine.oudjana@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
Thread-Topic: [PATCH v10 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
Thread-Index: AQHbGU4bDMD8PcY6F0SP3RFIMUYNjbJ9wnQA
Date: Wed, 9 Oct 2024 03:22:57 +0000
Message-ID: <f86b4ebdc80e2058a530cab6989d8f1a7c7a2094.camel@mediatek.com>
References: <20241008064716.14670-1-jason-jh.lin@mediatek.com>
	 <20241008064716.14670-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20241008064716.14670-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB7233:EE_
x-ms-office365-filtering-correlation-id: d6383a1f-f755-4296-07ac-08dce811aba0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RjJiNm4vdkxXa0phN3ZrVU0yT3VWZy9FUFgzekJzZ3RzZ05naExGSjJvRWVX?=
 =?utf-8?B?aVdCTmF4eTNLMW9wbEttUkorQW5XOGt1L1ZMYWxRK2k4UUhZQWF0Z1Q0akF6?=
 =?utf-8?B?cDVpYkZCbFNSTTRLN0RiNDNLUzZnU2tVWnlUd2w1ZzdjOEVvWWhuQmxLT0lU?=
 =?utf-8?B?OTkwZlVmanhRVlNkd1krNnNuMTZONE5PdE9ja3dpU0gxZFF6RGlwcGl4K3Bk?=
 =?utf-8?B?TnNReTN3NUx0TVQwRTQ5SUlrR0R4Z09BVWMwQWRCWmJpcTh0ZnNTdnUrbUtJ?=
 =?utf-8?B?WDVNOEd0V2FrUHYrdS94YXFUY2o5dEFNR0N1czdFMnhXdjA0eDkrdjQ2aXZQ?=
 =?utf-8?B?MS8vVWxVVjdRR2NGdTJOM3hDbVdkUlR0QVZQekRpY2tXaUNtdEVSR2RFRWgw?=
 =?utf-8?B?aEVyQVpIcVc2bkhsNUNCZ0o5OXk2elU1SGJmWTZDTk5odUk2cG5GTDJvdmJx?=
 =?utf-8?B?NS9wMzA1azJSY2ZIdkJ1eWhLNXptYkJUUll3K2FUMzltdUI4ajBEem5pVkli?=
 =?utf-8?B?R3JaZjlJWDRzUGpvenJkaFhXMDZ3OFlId0lJbldvcXlETzVyczc0TUhwOVBx?=
 =?utf-8?B?b2xVWTBtZEsrbE1yNzJPUkJTa2hmNFRyelB4UHR6QU1INGZicXRBbWU0R3Aw?=
 =?utf-8?B?QndMK1pOcjBkVm1RbXNBN3BucTlscmRxcFJ5a1RSa1pZczU4SStWSnlTb1dR?=
 =?utf-8?B?bkt6RmRJOUh4cERpZzhMOS9IREN5ZmRSNzNpM25LZnRnNUZDanpDaTg4YzVU?=
 =?utf-8?B?UXlEeFNGYjdzcmdFOFl2cFlxRkdCdTBERmlzdTE2cHVsRmlZbjVudFg4cjkr?=
 =?utf-8?B?Mzl0SjNYSEFSS0s4ZnBxcGE5MFJrWS9YYitUanlvZUVIME1GeitVNnVrR2ZS?=
 =?utf-8?B?L3g4ZmdkZWZjQ29mNDZHYlZTbkpib1JhMlZFdWp3T0Rtc2gwNjBtRnJJc0hI?=
 =?utf-8?B?YnZDUXJ2Uk9NY2lQcndweWROWERBTTFFU0JWaUEvd3B2SUVPeGN6cmJmOGNi?=
 =?utf-8?B?K1RRWUtSbTl5S2NvVnZYZWI1QkN3YjFKSmxuZFdjTDhFZENaUUNnRlBwTjBX?=
 =?utf-8?B?YXI3VGdvSzVKVWltNDdMUHJtemhxQ25DYkVwTXVKcHozSmZvSTBxTzAybjJH?=
 =?utf-8?B?RDdPRXhwMkFrUDlqcFJqeHQyY1BaMnFHUW5GbU5POTIwODVZM3hOZDBPSmhP?=
 =?utf-8?B?VHNyN2loTm9JWlhkdU9BQlQvTzBKNXJKV2Jpc1g3bG5pb2RiUVMvYXR6Uk5z?=
 =?utf-8?B?L0QvaHltMHJrUHNyQXI2UGgzVDZUajdmS2hLa2JoaFpBamw4Mk0wMXpOUTJS?=
 =?utf-8?B?Wm1ldGxXUlo4c3BDY1VFRzNha0NETTI1SW03VTBJekIxSWZFTWx5MUdOZFQr?=
 =?utf-8?B?MmZrMS9pbHhqdDZqKzBWYnpRWmNMWDlldGJGb2tCQy9WbkpBc3J3RE0wZlVB?=
 =?utf-8?B?TGJXSmVwdENiWHZETXJrcVNzcy9uaXZaRXV6NGx6MWVDSmk2SXlmOE00dXgx?=
 =?utf-8?B?VVJReHIvS041SGR2QkZ0S29UUmdxYUtGVjVuZUdKMUdiWTZUYlY3TUp3cUM5?=
 =?utf-8?B?dFRPSmYxdVcxNTExdFdTR1B1aW5CVkt5TkI0UVlRNC9tWFNVSXpqdFdERENQ?=
 =?utf-8?B?ZDhpUkNCUUZFVFNQSHJNVFV2UThIajRrOUVCa2NtZExielJ3cE16M3dGUEdv?=
 =?utf-8?B?V1h2bHBCK21TQjNRcnVQb0o2M3hnQWQ3ZXNTNFpKRisxZkhYdmswa05ZSnBK?=
 =?utf-8?B?c1lKK1VpZnBFbGVqZkdQZG1NdUdDV1VEbE50MUNTWGU3cmNoK3JqSWMxRGtn?=
 =?utf-8?B?OXNZM2JpakxUUU82OWorZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nk53ejJJTGlHK3FHWEh5NlhRUUIxRDFMZTB0cVV1Mmh1YUptMzkxMDNCYzRD?=
 =?utf-8?B?SUROQXB6WHJtcXMzMEZmRjhrTHlLSy9sREVmb3Y1Tlg1ZUlMd2g2U0ZSaE1M?=
 =?utf-8?B?dzRrOU1udUZxZjR5dnVoMElQakJGY1dmQjNnMlBjaDBtMmJNeWZURkhzYkkv?=
 =?utf-8?B?dmxieEFwRm1FclBqdGNmK0RvYmRKa05vbUhkN29wZGNmU0xNbFpEWXg4UjEw?=
 =?utf-8?B?WGZCdng2aVBvay96SlVHbU42S3laTFFyNTM0K0pYdlBxMnJNSEdCSTlrWHFT?=
 =?utf-8?B?RWUvOTRFTGRiTkk5QkhCcFlraDhta0Fhc0c0Z2h2S0ZqSS8vNmtzczBWd0wr?=
 =?utf-8?B?SGxlNHFCYWwrUklma3V2S3lYeUZ0eVl0VE9kam8yUUxUc1ZoWXJsVHZUWVds?=
 =?utf-8?B?WDhTMGNwZHY5R3ByWXFLaTV1RDU4dUxlbzdsT1VSdE41SXhvUlZ5bzFrNURa?=
 =?utf-8?B?ZUVWNG4yVDhMWWkyaTVYYWFQSGRjS1Z1bU1wOHN4aG5IQWdDU215WExnRDQ4?=
 =?utf-8?B?TGRGYkdWU1AxOFJzWGZHbjdDcEdreEpNNTFiQ0Nta29XbStxVWdxOC8vYjh1?=
 =?utf-8?B?c3U0ajBmdi9VNUtGYnBoUTRqU0Nlc3Rob2c1M3ZZR0J4UzhhcVR3Z3ZObDQ2?=
 =?utf-8?B?a1JIWHQ4SzJLWittTnJLVzJ1ejFwQ2R3WXJFZ1o0NGdSc2lQemZMbXV2VUxv?=
 =?utf-8?B?N0dYVjl5L1lDVGwxc0NDUFFnTW55R09jb2tKNU9TWGxqMHdzNmJFbFlFTE8z?=
 =?utf-8?B?TWhrd2dKbHA3SW1JN1hJSXRuUm4xM0o1U3NPcmJTR0JBVndJdEc3V0NFRlJN?=
 =?utf-8?B?R1ZyVG1ySXk3ZmFKZ2tCRGVuOGdMVWtudVdVZEkxamJiV1MxY1hXUGIzODJU?=
 =?utf-8?B?VXpmVVdpNGNHMzBZUjhFMmFYV0pDVmphS2pDRGt4RGhGZ2N5STgvTEJtL014?=
 =?utf-8?B?L2FPZFh0bjZ3cUNWaFBaUHZUSzJZQUZtY1ZGdUZiSHJKUXVHelFDcmpaUFhh?=
 =?utf-8?B?enowQ1NxNGw4YUhaQTBFZFhxRUpCWUVUQnc2RWV3RVYwb25vV0oyRVN0clgr?=
 =?utf-8?B?WkZsNVR4ZjlLQk5uMUYyYi9wMUQ4R0VYRzF6Q3lSSVhtOEN1VW5GcEY3UFpv?=
 =?utf-8?B?UHNQaGQwR3Z3YlRFV3pPaGZYWWxpbWtVbE1LSmdvWEpNemJ2b0l0T2V0VUhu?=
 =?utf-8?B?N3g3Rm9vVWxpdStmRlBUTHFrWmRqaWRuSGlkZFI2TTV3NnZhUWtsSHhhWTVL?=
 =?utf-8?B?TUNDVlhGZy8rMUpNMFlZNVlTZDlYN0FobmsyK0M0YlgxQk5PNFFuakhsa05r?=
 =?utf-8?B?cCtnTTFhNmZzN05wS3hURXNkNDd6eXFmeEVMVTllcWFvVmZIS1h0ZmEwdUdz?=
 =?utf-8?B?VnhYLzhjOThlZDF6OHRQM29TWHNQQkxtNzJLUmdsSHZZTldUZzNVbDFmTkhI?=
 =?utf-8?B?YnRVZ0Q3cWcwR2FXUzYxVDlMNW4vL1UzZy9Gbm5nM0I1WVpOUlJDdFdaMzFi?=
 =?utf-8?B?VE55OFhkeGxYNEVLRmp1WDJVdXVVdXQ5dndYcmMxWVNXZXVxY0ttRmcwL05D?=
 =?utf-8?B?NUMza3RZWDF3Y0NkQ1JPcnEva2YwUDdvNlN0MDJvOUY0SEVUL2JqY0hpV2p1?=
 =?utf-8?B?MHUvaVpUU1dPS1pnN2hxZEkxUFZVMGV4NEdNWDlxVDVsbVFDbWNRZEViQ0F2?=
 =?utf-8?B?QjJuOHBBN0VFckdxaWcwRS9qRVJBSEpyaDA4R2Z1Z0ZMRmdYRVR0Q012VVkr?=
 =?utf-8?B?djQyZlVYZ1h0dC8wNElhVjhiekYwTzZ5Nk1Lc1FtRkNkcUN2alFMS0xnUkNP?=
 =?utf-8?B?WFNwRWlYZUFhNmM3K3JMUXFkTnJEaFVKZlFpSmE4UHl1TCswWTBWTkxjOWJ6?=
 =?utf-8?B?RkdLMVpZaWJzRkdTM2tDampjcEhrYk9VcGNRUEtBOWtUb1hYanBsektHNUoy?=
 =?utf-8?B?bzUvNENMbzRpTEhTeXhmazN4aFU2b0FCdklIenUzMzF6VThWNjNZZll2Uis2?=
 =?utf-8?B?RTVtUWVXVWwwd1NpbmlkYlhjTjJUQ2hqUldJVjZlN1lzdm16MVc5OGFkaElN?=
 =?utf-8?B?VU5saUt0VFQ4YUhoakhXM3NjNzJ6bjFhV1RKSGtWTGVtT1hnRWlqNnQzbGYv?=
 =?utf-8?Q?GKeakjHmDdBLG6LiQ+MncmsiY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CA06D443F38754B8B1DD9CC402A348D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6383a1f-f755-4296-07ac-08dce811aba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 03:22:57.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CKIpwCkM5sGYsdu5B+eUscn4lo80wfQ8Nh+gXP5dlW3hXHcsN0pT0ctXN9CNG+Xan/vvnCOcK8HhfeXjezO4Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7233

SGksIEphc29uOg0KDQpPbiBUdWUsIDIwMjQtMTAtMDggYXQgMTQ6NDcgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gT1ZMX0NPTl9BRU4gaXMgZm9yIGFscGhhIGJsZW5kaW5nIGVuYWJsZS4N
Cj4gRm9yIHRoZSBTb0MgdGhhdCBpcyBzdXBwb3J0ZWQgdGhlIGJsZW5kX21vZGVzLCBPVkxfQ09O
X0FFTiB3aWxsIGFsd2F5cw0KPiBlbmFibGVkIHRvIHVzZSBjb25zdGFudCBhbHBoYSBhbmQgdGhl
biB1c2UgdGhlIGlnbm9yZV9waXhlbF9hbHBoYSBiaXQNCj4gdG8gZG8gdGhlIGFscGhhIGJsZW5k
aW5nIGZvciBYUkdCODg4OCBmb3JtYXQuDQo+IE5vdGUgdGhhdCBpZ25vcmUgcGl4ZWwgYWxwaGEg
Yml0IGlzIG5vdCBzdXBwb3J0ZWQgaWYgdGhlIFNvQyBpcyBub3QNCj4gc3VwcG9ydGVkIHRoZSBi
bGVuZF9tb2Rlcy4NCj4gU28gaXQgd2lsbCBicmVhayB0aGUgb3JpZ2luYWwgc2V0dGluZyBvZiBY
UkdCODg4OCBmb3JhbXQgZm9yIHRoZQ0KPiBibGVuZF9tb2RlcyB1bnN1cHBvcnRlZCBTb0NzLCBz
dWNoIGFzIE1UODE3My4NCj4gDQo+IFRvIGZpeCB0aGUgZG93bmdyYWRlIGlzc3VlLCBlbmFibGUg
YWxwaGEgYmxlbmRpbmcgb25seSB3aGVuIGEgdmFsaWQNCj4gYmxlbmRfbW9kZSBvciBoYXNfYWxw
aGEgaXMgc2V0Lg0KDQpBZnRlciBmaXhpbmcgdGhlIHR5cG8gbWVudGlvbmVkIGJ5IE1hcmt1cywN
Cg0KUmV2aWV3ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IEZpeGVz
OiBiYzQ2ZWI1ZDVkNzcgKCJkcm0vbWVkaWF0ZWs6IFN1cHBvcnQgRFJNIHBsYW5lIGFscGhhIGlu
IE9WTCIpDQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlh
dGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
LmMgfCA4ICsrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+
IGluZGV4IDg5YjQzOWRjZjNhNi4uMDQ3Y2QxNzk2YTUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IEBAIC00NzMsOCArNDczLDE0IEBAIHZvaWQgbXRr
X292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0K
PiAgDQo+ICAJY29uID0gb3ZsX2ZtdF9jb252ZXJ0KG92bCwgZm10LCBibGVuZF9tb2RlKTsNCj4g
IAlpZiAoc3RhdGUtPmJhc2UuZmIpIHsNCj4gLQkJY29uIHw9IE9WTF9DT05fQUVOOw0KPiAgCQlj
b24gfD0gc3RhdGUtPmJhc2UuYWxwaGEgJiBPVkxfQ09OX0FMUEhBOw0KPiArDQo+ICsJCS8qDQo+
ICsJCSAqIEZvciBibGVuZF9tb2RlcyBzdXBwb3J0ZWQgU29DcywgYWx3YXlzIGVuYWJsZSBhbHBo
YSBibGVuZGluZy4NCj4gKwkJICogRm9yIGJsZW5kX21vZGVzIHVuc3VwcG9ydGVkIFNvQ3MsIGVu
YWJsZSBhbHBoYSBibGVuZGluZyB3aGVuIGhhc19hbHBoYSBpcyBzZXQuDQo+ICsJCSAqLw0KPiAr
CQlpZiAoYmxlbmRfbW9kZSB8fCBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+
ICsJCQljb24gfD0gT1ZMX0NPTl9BRU47DQo+ICAJfQ0KPiAgDQo+ICAJLyogQ09OU1RfQkxEIG11
c3QgYmUgZW5hYmxlZCBmb3IgWFJHQiBmb3JtYXRzIGFsdGhvdWdoIHRoZSBhbHBoYSBjaGFubmVs
DQo=

