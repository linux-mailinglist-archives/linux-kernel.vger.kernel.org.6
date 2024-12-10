Return-Path: <linux-kernel+bounces-438974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF269EA8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 07:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886921889FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 06:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9442D22ACFD;
	Tue, 10 Dec 2024 06:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KjDevBX8";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GeNKhlgT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE431D7E31
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 06:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813290; cv=fail; b=a+5oX3E0Ege0WqI3qFeIYXdhdH+E6cVWEkX1H1V+uzKbkiJoV6h4GYKKJxGw3V4GNcWZDRB/BRM5DSUNRiilTD9NPs8O9OcdDJh8eihMNMUQqJxTFFeq/K0WSlQLchG1gWlm1fAU0tPT3GmjFitbwvHQlLw3bg9fc5R5XXwcBeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813290; c=relaxed/simple;
	bh=ALa0RrSk7Yl2blLniqSDSxCzh+higEDHPGdVeO6N1hM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mq4Mb59zVhhvKq06vgVozVDUAk0e70far4cBZlZpfvRbJ4Y/pGjM7wefVWKByN12Mpefi1zux34qCMu9ytOKAoBn3TyTP0xkrTHEmDUJbxUEjMKdPavzSrBkDjlmvyG7PLiZRnprSDPsFVTZSfFdl366uel9ldFizoBdR+cvvz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KjDevBX8; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=GeNKhlgT; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: af62009cb6c211ef99858b75a2457dd9-20241210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ALa0RrSk7Yl2blLniqSDSxCzh+higEDHPGdVeO6N1hM=;
	b=KjDevBX8v77V8jlvYAkjHcTt2TdJiMD4bLTT15yZB05e+R3iQvTdS8ItHZQul+C2jmhbZCXyjpsTxD5kdHcsSMBASLuja+2UJR+ixGNYQhS02B3VR5LAvFeFV6k2T6Vu+8ywu5GwOck3CKMmbhqBvs+UCKvhT+PFMjsjouF+V+A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7581c4ff-556d-40f9-8446-64a394a05ab0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:f417a2a4-c699-437d-b877-50282f19c2c6,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: af62009cb6c211ef99858b75a2457dd9-20241210
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 278857014; Tue, 10 Dec 2024 14:47:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 10 Dec 2024 14:47:52 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 10 Dec 2024 14:47:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiBwc66DJoRBPpqCKkdJTA6OMhTtItbBpGjAJxk3ko+7AMV9tsEaXwhEaR3ny+/7JE9Nu9T6eE1+lghvCp/RsUEAaKDzZ2mpTgFMWs2pR8gLm149WrHV3pimHcmLMYcX/1NlvfsrAyscwGXOCHqlruvetSXVv+FKhji2xjsWI1ri0DJLwlxBO/lUuhhmYV5omjW4cs7L/Vjjv4kWFmFc5BMh/mwaJ2JnTv4CjZLTpdB2k4eMRjhz2ygucKuJ6vK8LprUIxJ8OMkcJlzYRG/4uMBC6imM2bjoeYatqVxwiHQ/fAtLBG9oVWH+3oL7GKrd4cIWJNybK8CC0Ll7wKtwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALa0RrSk7Yl2blLniqSDSxCzh+higEDHPGdVeO6N1hM=;
 b=Uxn37Mox8Yn8wth/kQigDxaKhYentdPvtqKQ0vW5WfOvEzRaGiAIjewbeFUMLCtFKfOJzuKNyJWiwet3HtM5GB0QmPUxkxs/AueTTs9mUyVnuq8YwdBQAG2XuPE272GB57M2XevIreC7z+KPLagSZbTp/AFaJL6+9rRSMoliFkQoMiIHoeDEgoyvrhGvn5gTgPBtVh28jBH2kNpaZEIiInbf8MdmHK14yGbjzd97JlgP7hJvl+gNCjYivRVXbGLhtMuDl4ZuU5p/WwZpn2VM8xO12iQbKUWDKCVXLc1AU9xKdEmhHEw2bW0QVrUQPceGiDqJ1K1hosPDu+8bK5VSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALa0RrSk7Yl2blLniqSDSxCzh+higEDHPGdVeO6N1hM=;
 b=GeNKhlgTHeSpXWWWYKhB5Se/taEUGipO1yPbY/WYXFQRQA89QZ97B9Ut25riW6XY8ojipd0R6zk9G7JToZIT/m5ff78CB2IgGPYYW1ZEDJYf+Xxc8vpUgVApoeYo/rmssRxiIMi5F6celOGGvcRd9OAVf6PvPNC26l2ylHW8Me0=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7248.apcprd03.prod.outlook.com (2603:1096:101:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.23; Tue, 10 Dec
 2024 06:47:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Tue, 10 Dec 2024
 06:47:48 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Topic: [PATCH v3] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Index: AQHbSrOp8dO0OkGpI0KRsv+8TKP4QbLfCXCA
Date: Tue, 10 Dec 2024 06:47:48 +0000
Message-ID: <1e953fb5a4e4965ba509a1bb45e7c8336102ff29.camel@mediatek.com>
References: <20241210032820.10958-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20241210032820.10958-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7248:EE_
x-ms-office365-filtering-correlation-id: 2c8dda22-e614-43f0-56f1-08dd18e68fb8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c1YzSjBVNzFZVHg4eG9ic2RBNE9EanNtc25DNFV2UnRNdkZGNzNnT0ZaaFo1?=
 =?utf-8?B?eG9oMVk4WCsvLzdTZldlSHkzQWlpOXhhaU5wRldNL1ZhR3BVdnhtaTkrelYz?=
 =?utf-8?B?Wm12QnZvL2Y4L3JBTW9tRTVGQWt5dndNcHJJVmxDNlk5NmRTYjdKaUpqaExX?=
 =?utf-8?B?dE0yUTdtRTdWK256WFNBcTBPTWo5NHBzL2g5OUZhQ1pzTjVub2x6S216ZE5Z?=
 =?utf-8?B?N0Z3RXB6OElQZGd0ekVXTFRhWjhiRFJFSERWYjVGeWRvWmhuNTl2UVh5emdm?=
 =?utf-8?B?SEF2Z3ZpdkpRZTlTdjJZN1o5RmhhK3FETkg5Mk8wbGxmamNOUTREcVI0R2tT?=
 =?utf-8?B?TVlPNnFvNjFqdk5Oc1hxKzgyVng0U0FtQ0VPK1dwNVhtMEtwYjBOUU1xTFZi?=
 =?utf-8?B?K0JNVEJGMGZlSWpXM0d6azBjTjh6N2J0RjZKTi9FWE1LaUExZVNvak9PNzlz?=
 =?utf-8?B?Qmd3ZFVYOWZXcnZzR1lrSkVPb2J1L1RYVTBVSlhtTVVyWXE0VVF0SUlhWHpC?=
 =?utf-8?B?OTRyd0EvcVJjZlhpK0lzRVJkaGZEdWtEZFVPWDhkWGpHTFM2NWRyUWV0NWx3?=
 =?utf-8?B?a2ltZHNjY0xsTytkZ3JFOTFSRUNwQzBSSUNqZ2lpeEhaMUt1cmU0aWZqU203?=
 =?utf-8?B?bUJSY1luQnFubXpxMXpzUk5XalpFaS94aU9veEZhQVh1b3VEcnZ5MzY0M1Rp?=
 =?utf-8?B?V1FlRFRiZXV4TzZpY0hXRG1TV2JVcElhQWptdkMzODZ1cTcrRnpKTFhKdnNF?=
 =?utf-8?B?N3ZoenhXS3IwZTNQQkhRSVllLzJEZ1h1ODJaNE1MV3BEV1ZEcWVaeVhrNGp4?=
 =?utf-8?B?Z1dlM0lrUGZBdmVpUzdhQ2ovYThYNXk2MVgyb3dFb2hNNW1zamtoVVpJYitE?=
 =?utf-8?B?KzNlM3BBWkNjYjcrbkhMcjVHV2xUc3VJd3JYQkIrU2Vzayt5b3AxSDJ3dE9X?=
 =?utf-8?B?S3ZsUkd2NVFRM3lreDN6N0tDQU9EU2xoSzdrM3dicmVObDRqT1U2S2gxSWFI?=
 =?utf-8?B?UkovcWF6cTBQOGt0WUpRZm5YV2NUVWpwNUk2Qnd0aW44RTVuMkNjVnh0VUZM?=
 =?utf-8?B?TWYyQkxiRDNLUzByZjcrbjVVbVdKZzJSUkV2Z0dsQmMvV3YwNnJtclV3bVY0?=
 =?utf-8?B?Sm4xSkxSVGJyOE9pcmtHdlp6TThjbjNBZkNBSUdkTHFvWEJXcXk0TkpsMTFF?=
 =?utf-8?B?Si9rN2dSQndzbkR3TStrN1RFdmRXZkZmQ3JOcVFWTGhjU25oakhxUW4xcm8z?=
 =?utf-8?B?bHFPdEdKY1pyakhxQ1ZJUlFUT0lHY25qZVV4ZkExaFpqdmF3MGM5NTRQam5U?=
 =?utf-8?B?anFLd25DMXZtVWZMY1ZkcFRQRzNNMnl2ZFJnblJkQVFyNVJCYm5GbFVzVnRk?=
 =?utf-8?B?M0thUGpQYk54NjF4OFo2VDJrSUhFN2hyUC93Nlduck5IUUIvRUhPR3NMT25J?=
 =?utf-8?B?SVo5bjZiMFJCRCtLREVKRVNPZDBNS1MvK0dIQzgyNExsaTlsZXZacERPZGJs?=
 =?utf-8?B?cG5EQ3hyU09zUWs4TmY4dlhvbFlsTXd5dFd4WnQxRkNsWVpGQVNjV0FiKytG?=
 =?utf-8?B?NEtPZmlIcGhXMnJnYmxsNTBucVJ3SWoxcHQ1TWF3ZUM3dk9rR2UrYURLZzYv?=
 =?utf-8?B?TnI1TUx2UjUxMWVZVytNQk05bEQwYnU1cU52ZTFOSTdnRWF0MENuSmlrOFdY?=
 =?utf-8?B?clc1dnpZd3diT055UmljeXpYMWw5emVQSTh0MFkxcnZHT2czbXFGNDd3QWV2?=
 =?utf-8?B?NTZ6NFdoYjRWMkIvU1o5cWRuQ0dMMld1azRFOVN3NXd2MUozYU4zZVlGTXFq?=
 =?utf-8?B?WGlkbDVQSjlZL2hqNlVkdktuTHdIVkdxZXZSWjg4LzhxVG90MHdoRUllb0lX?=
 =?utf-8?B?bVVwOG8xa0lMeHo2ak9maWtwckJZWHBSZmgrVm9vSHZzR2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qks0SFQyblRvR0FvWXpLUldqbXpVNytzbVhWZWxtdHo1aVJPR2gwQ2dWQzlw?=
 =?utf-8?B?YWVwblRjd0JxeklBMjdMMU1iZVYyK3dWRHBOdThJOEt5bHh1UHEzK1llMEtU?=
 =?utf-8?B?RkViOThtUXhpSzZYVE4rOG9XdTFnYmFMYUU5Y1MzeHpMNlBFUitmR2MzV0VX?=
 =?utf-8?B?aXJIekxiTlpDdkxXZ0pWMVlEY1dlNlpCZG1hbUVRZDI3SDk5TS9UQ0lUdXFO?=
 =?utf-8?B?aDdWNDZyZWRHUjVkQUJyemRIU0RlUmRyQTJRamM2ZGtPRVl0SG5JUDVIN2h3?=
 =?utf-8?B?SmxxM2RHK0JBSWRBTnNWRVdDSERMVDQ2d1V4Y1Y1aE0zSU9TOTdXdTRwejUy?=
 =?utf-8?B?SkxtdzkxVS9NTnoxVlVObnVISngvZGF2TDRsdEtTcHZvaTBxNysxQnpXYlpW?=
 =?utf-8?B?WGtpd2JQeWVBcTZzRVVYd2RBbXdZd0pnL2l4T0dRZVhwK3FiWEF0T3lLNFdj?=
 =?utf-8?B?eExlS2VvUy9ibG9DaEsyS21hTDhpRGNhb2ZnR2IxQlJlVENhRzBLZTI3cVpL?=
 =?utf-8?B?RzdpYmxSUVRWR3JYTFk2cU92ZThlMlI5QzQvci9jMkdqWEdOYTNNVTdsQkNx?=
 =?utf-8?B?VFhRam5maXJUM01panlxdVM3M1c2UUxiNHpzcVlEbFNIcjhnM25meXRLem5G?=
 =?utf-8?B?WVY4dU84VEZRSFJnckRWejlDVUtkalhOL09FSFZCNWpWN011c01OOVo0eFpG?=
 =?utf-8?B?MDZqYUUxeG01T2E1NllORTJ6TEkyT2dxNmVVZkN2a2krZDQxaXkzbGFFaktL?=
 =?utf-8?B?alA3TUZQVmdNdDR6U0UybnliVVJxdytYRHBUNTNNSnJPbEgwRXNLSWd5a2tF?=
 =?utf-8?B?ZGF4WUx6eWtUV2hkNUxiNDVYeWVwUTg4Ukluc2JqZjd5VlBUOXhYbGRPZFVV?=
 =?utf-8?B?Z0R3VEhESEhoZzhTb2oxeUxFdHJ4eWJtMmhhd3cxS2ZmOVZLMVY5NkxhVGxX?=
 =?utf-8?B?ZForK0V2cGQzdmE5NnVQZEk2NEYxMmppL1YvazhVL1A5c3FzNHRnL0pXOGZL?=
 =?utf-8?B?TVhIbWxnNUtCa0c4TnV6bThEYm5HaWtzRzRSNmIxQTVTdjYyaTlYN2xkUmpr?=
 =?utf-8?B?RHhvRkRCbjkveWhmdnJvY1o0RUpaMVdYTmFML2F4Y21NeVhZNEplTTFjVFJR?=
 =?utf-8?B?QjNEOWlaU0syMDZWbk5sZGRVQ2pOL1ZkaU50N0Jla3ZWVVl3VEh4d2t0b1Rt?=
 =?utf-8?B?UUdWMXcxeUM2ZGlIQlg5RDlzVWMxVndWR3ZWQlBIaHM5ejk5YVhwQ0l3V09j?=
 =?utf-8?B?Wm1lNWNHdlNhbVlMM1FrNU1pdENGbmQ1eEtYMzRhRy9icUdDYnl6RUdkTmdJ?=
 =?utf-8?B?VlU4UVFMbmZXUEhiU09QNGN6TFYrb210bnVzL09EY0dPTFlDN0lmWWlGK3J6?=
 =?utf-8?B?c0QyTWNoa0xSNzdSbXNEcjBxeWRzUUY3TGI0M3VyK09NSk5pZlVJU2x0eldM?=
 =?utf-8?B?SUhFb1ZsK2NWOWNXVUp0RG1pNEhUZDZHUFlHNk16RncxaFYzVnA1dXQ0cjVY?=
 =?utf-8?B?TzhsSml3NXdGdHI3L0NaZTJSV2s4Uk5YMUZuWG1XU3l2bTVHaXk4S3Vac1lz?=
 =?utf-8?B?aWdRQkMyQUEwOGFmQWJ4SEZqeHFpWmZGbEMwZzl4YTM0Skp2V2dMYlF2WmR1?=
 =?utf-8?B?NVFpQUp6SWF2NWNRc1BLYlR2ZFJwMEpnL0JSK3pMOU9VUG9YUnVSNlNkcjUw?=
 =?utf-8?B?ZS9SMlpsaDRWTHJBZTNKbEUwOEwvVG53ZWhmVGcvMGRiS1pmMzVQamRxZmpr?=
 =?utf-8?B?OU11Q0UzMGF6STN3TUpBVW1SRXUrM1hyNDUxeTd2MkJWT3RjRllZN284MlpD?=
 =?utf-8?B?djNXTzdmVENSUnVuK3FMYmpMNU8xOGpQQnAydFNQNkU5Z3oyOUcvdmljVGRE?=
 =?utf-8?B?WkdzU2pvb2NobzhVTXBtU0YwVU1oRk5yVW82aFo5OE5YU1hVbC95VzdId20x?=
 =?utf-8?B?MGxpRVlRRXgzTmsyVlBKNnV1VTFPWmFKbnVSMWNjWWdrZEJ6SDFzbTFRN1hY?=
 =?utf-8?B?bml1L2ZTbjVhcU9vekVPRkdraXpaVitnWEprQU5zWUc1V1EzTjZTM1pGeHJ6?=
 =?utf-8?B?dkFBUStPNjM3enRxQ2lzQlhiVG4yQUhWYVR4NG1YR3ptQk9QNEJZNFFxWnZ0?=
 =?utf-8?Q?FDfKIgdpu8qaMsVahfu5J2hMZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <467451D1E1D5A4439523AF3ABB449D11@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8dda22-e614-43f0-56f1-08dd18e68fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 06:47:48.9141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hgXYdfksF32eGwB926189AsNz7Yi1rYjRijoO0YKbERcGLhSLYryMHPrP/0ZVTpnh4x+S4cAhtTQDyz6HuXiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7248
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.764000-8.000000
X-TMASE-MatchedRID: +f/wAVSGjujoSitJVour/Sa1MaKuob8PC/ExpXrHizxXM6Z39sH1vu8f
	ad4FArWr+8wBSnZb3XOpLIWSTUWqjRFetKpHyMm5uQz4l+l24lat4laWdJbsDEw6MpTEJnCvayS
	mws0z/avSOf0h6ndGyM0qPZIzvkoNMH15eekLeUi3UCG/IQp2PhG8SlV3e9LV31GU/N5W5BA8nT
	lRES2M5S8YpJbLtuTodO/0Gy3rD8+AaBshbPhdTFu4M/xm4KZemX+W7bzPOQEJW4Re2U2pyyAOg
	9E37d4vpOWS3FjzARNMonkzlcFmh4bzTO6asfbjT7jCYv2QJPG/PqtexhSykZsoi2XrUn/J+ZL5
	o+vRV7yhMIDkR/KfwI2j49Ftap9EOwBXM346/+z+LBSUwOQ5BwaFjAayE9/5095AA7OwtTvDjDH
	5Jv9vsXb4CE7iv3ot
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.764000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5CA8B599352E701D4E883F98A9063EDFEE9C7F3B8FCF61E302B010E05CE2C73F2000:8

SGksIEphc29uOg0KDQpPbiBUdWUsIDIwMjQtMTItMTAgYXQgMTE6MjggKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gbXRrX2NydGNfZmluaXNoX3BhZ2VfZmxpcCgpIGlzIHVzZWQgdG8gbm90
aWZ5IHVzZXJzcGFjZSB0aGF0IGENCj4gcGFnZSBmbGlwIGhhcyBiZWVuIGNvbXBsZXRlZCwgYWxs
b3dpbmcgdXNlcnNwYWNlIHRvIGZyZWUgdGhlIGZyYW1lDQo+IGJ1ZmZlciBvZiB0aGUgbGFzdCBm
cmFtZSBhbmQgY29tbWl0IHRoZSBuZXh0IGZyYW1lLg0KPiANCj4gSW4gTWVkaWFUZWsncyBoYXJk
d2FyZSBkZXNpZ24gZm9yIGNvbmZpZ3VyaW5nIGRpc3BsYXkgaGFyZHdhcmUgYnkgdXNpbmcNCj4g
R0NFLCBgRFJNX0VWRU5UX0ZMSVBfQ09NUExFVEVgIHNob3VsZCBiZSBub3RpZmllZCB0byB1c2Vy
c3BhY2UgYWZ0ZXINCj4gR0NFIGhhcyBmaW5pc2hlZCBjb25maWd1cmluZyBhbGwgZGlzcGxheSBo
YXJkd2FyZSBzZXR0aW5ncyBmb3IgZWFjaA0KPiBhdG9taWNfY29tbWl0KCkuDQo+IA0KPiBDdXJy
ZW50bHksIG10a19jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAoKSBjYW5ub3QgZ3VhcmFudGVlIHRoYXQg
R0NFIGhhcw0KPiBjb25maWd1cmVkIGFsbCB0aGUgZGlzcGxheSBoYXJkd2FyZSBzZXR0aW5ncyBv
ZiB0aGUgbGFzdCBmcmFtZS4NCj4gVGhlcmVmb3JlLCB0byBpbmNyZWFzZSB0aGUgYWNjdXJhY3kg
b2YgdGhlIHRpbWluZyBmb3Igbm90aWZ5aW5nDQo+IGBEUk1fRVZFTlRfRkxJUF9DT01QTEVURWAg
dG8gdXNlcnNwYWNlLCBtdGtfY3J0Y19maW5pc2hfcGFnZV9mbGlwKCkNCj4gc2hvdWxkIGJlIG1v
dmVkIHRvIGRkcF9jbWRxX2NiKCkuDQo+IA0KPiBGaXhlczogN2Y4MmQ5YzQzODc5ICgiZHJtL21l
ZGlhdGVrOiBDbGVhciBwZW5kaW5nIGZsYWcgd2hlbiBjbWRxIHBhY2tldCBpcyBkb25lIikNCj4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfY3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19jcnRjLmMN
Cj4gaW5kZXggZWIwZTEyMzNhZDA0Li5kYWJjMmY4MDg2YjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfY3J0Yy5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfY3J0Yy5jDQo+IEBAIC0xMDksOSArMTA5LDE0IEBAIHN0YXRpYyB2b2lkIG10
a19jcnRjX2ZpbmlzaF9wYWdlX2ZsaXAoc3RydWN0IG10a19jcnRjICptdGtfY3J0YykNCj4gIHN0
YXRpYyB2b2lkIG10a19kcm1fZmluaXNoX3BhZ2VfZmxpcChzdHJ1Y3QgbXRrX2NydGMgKm10a19j
cnRjKQ0KPiAgew0KPiAgCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsJc3RydWN0IGRybV9jcnRj
ICpjcnRjID0gJm10a19jcnRjLT5iYXNlOw0KPiArCXN0cnVjdCBtdGtfZHJtX3ByaXZhdGUgKnBy
aXYgPSBjcnRjLT5kZXYtPmRldl9wcml2YXRlOw0KPiAgDQo+ICAJZHJtX2NydGNfaGFuZGxlX3Zi
bGFuaygmbXRrX2NydGMtPmJhc2UpOw0KPiAgDQo+ICsJaWYgKCFwcml2LT5kYXRhLT5zaGFkb3df
cmVnaXN0ZXIpDQo+ICsJCXJldHVybjsNCj4gKw0KDQpJIGZvcmdldCBvbmUgY2FzZS4NCkZvciB0
aGUgQ1BVIGNhc2UgKFNvQyBoYXMgbm8gc2hhZG93IHJlZ2lzdGVyIGFuZCBDT05GSUdfTVRLX0NN
RFEgaXMgbm90IGVuYWJsZSksDQp0aGlzIGRyaXZlciBzaG91bGQgc3RpbGwgd29yay4NCkNQVSBj
YXNlIGlzIG5vdCBhIHVzdWFsIGNhc2UsIGJ1dCBpdCBjb3VsZCBiZSB1c2VkIGluIHNvbWUgdmVy
aWZpY2F0aW9uIGNhc2UuDQpTbyB0aGUgY29uZGl0aW9uIG1heSBiZQ0KDQojaWYgSVNfUkVBQ0hB
QkxFKENPTkZJR19NVEtfQ01EUSkNCglpZiAobXRrX2NydGMtPmNtZHFfY2xpZW50LmNoYW4pDQoJ
CXJldHVybjsNCiNlbmRpZg0KDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJm10a19jcnRjLT5jb25m
aWdfbG9jaywgZmxhZ3MpOw0KPiAgCWlmICghbXRrX2NydGMtPmNvbmZpZ191cGRhdGluZyAmJiBt
dGtfY3J0Yy0+cGVuZGluZ19uZWVkc192YmxhbmspIHsNCj4gIAkJbXRrX2NydGNfZmluaXNoX3Bh
Z2VfZmxpcChtdGtfY3J0Yyk7DQo+IEBAIC0yODQsMTAgKzI4OSw4IEBAIHN0YXRpYyB2b2lkIGRk
cF9jbWRxX2NiKHN0cnVjdCBtYm94X2NsaWVudCAqY2wsIHZvaWQgKm1zc2cpDQo+ICAJc3RhdGUg
PSB0b19tdGtfY3J0Y19zdGF0ZShtdGtfY3J0Yy0+YmFzZS5zdGF0ZSk7DQo+ICANCj4gIAlzcGlu
X2xvY2tfaXJxc2F2ZSgmbXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+IC0JaWYgKG10
a19jcnRjLT5jb25maWdfdXBkYXRpbmcpIHsNCj4gLQkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
bXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+ICsJaWYgKG10a19jcnRjLT5jb25maWdf
dXBkYXRpbmcpDQo+ICAJCWdvdG8gZGRwX2NtZHFfY2Jfb3V0Ow0KPiAtCX0NCj4gIA0KPiAgCXN0
YXRlLT5wZW5kaW5nX2NvbmZpZyA9IGZhbHNlOw0KPiAgDQo+IEBAIC0zMTUsMTAgKzMxOCwxNSBA
QCBzdGF0aWMgdm9pZCBkZHBfY21kcV9jYihzdHJ1Y3QgbWJveF9jbGllbnQgKmNsLCB2b2lkICpt
c3NnKQ0KPiAgCQltdGtfY3J0Yy0+cGVuZGluZ19hc3luY19wbGFuZXMgPSBmYWxzZTsNCj4gIAl9
DQo+ICANCj4gLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2ss
IGZsYWdzKTsNCj4gLQ0KPiAgZGRwX2NtZHFfY2Jfb3V0Og0KPiAgDQo+ICsJaWYgKG10a19jcnRj
LT5wZW5kaW5nX25lZWRzX3ZibGFuaykgew0KPiArCQltdGtfY3J0Y19maW5pc2hfcGFnZV9mbGlw
KG10a19jcnRjKTsNCj4gKwkJbXRrX2NydGMtPnBlbmRpbmdfbmVlZHNfdmJsYW5rID0gZmFsc2U7
DQo+ICsJfQ0KPiArDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXRrX2NydGMtPmNvbmZp
Z19sb2NrLCBmbGFncyk7DQo+ICsNCj4gIAltdGtfY3J0Yy0+Y21kcV92YmxhbmtfY250ID0gMDsN
Cj4gIAl3YWtlX3VwKCZtdGtfY3J0Yy0+Y2JfYmxvY2tpbmdfcXVldWUpOw0KPiAgfQ0KPiBAQCAt
NTg0LDYgKzU5MiwxMCBAQCBzdGF0aWMgdm9pZCBtdGtfY3J0Y191cGRhdGVfY29uZmlnKHN0cnVj
dCBtdGtfY3J0YyAqbXRrX2NydGMsIGJvb2wgbmVlZHNfdmJsYW5rKQ0KPiAgCQltdGtfbXV0ZXhf
YWNxdWlyZShtdGtfY3J0Yy0+bXV0ZXgpOw0KPiAgCQltdGtfY3J0Y19kZHBfY29uZmlnKGNydGMs
IE5VTEwpOw0KPiAgCQltdGtfbXV0ZXhfcmVsZWFzZShtdGtfY3J0Yy0+bXV0ZXgpOw0KPiArDQo+
ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2ssIGZsYWdzKTsNCj4g
KwkJbXRrX2NydGMtPmNvbmZpZ191cGRhdGluZyA9IGZhbHNlOw0KPiArCQlzcGluX3VubG9ja19p
cnFyZXN0b3JlKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2ssIGZsYWdzKTsNCj4gIAl9DQo+ICAjaWYg
SVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gIAlpZiAobXRrX2NydGMtPmNtZHFfY2xp
ZW50LmNoYW4pIHsNCj4gQEAgLTYwNiwxMyArNjE4LDE0IEBAIHN0YXRpYyB2b2lkIG10a19jcnRj
X3VwZGF0ZV9jb25maWcoc3RydWN0IG10a19jcnRjICptdGtfY3J0YywgYm9vbCBuZWVkc192Ymxh
bmspDQo+ICAJCSAqLw0KPiAgCQltdGtfY3J0Yy0+Y21kcV92YmxhbmtfY250ID0gMzsNCj4gIA0K
PiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmbXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+
ICsJCW10a19jcnRjLT5jb25maWdfdXBkYXRpbmcgPSBmYWxzZTsNCj4gKwkJc3Bpbl91bmxvY2tf
aXJxcmVzdG9yZSgmbXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+ICsNCj4gIAkJbWJv
eF9zZW5kX21lc3NhZ2UobXRrX2NydGMtPmNtZHFfY2xpZW50LmNoYW4sIGNtZHFfaGFuZGxlKTsN
Cj4gIAkJbWJveF9jbGllbnRfdHhkb25lKG10a19jcnRjLT5jbWRxX2NsaWVudC5jaGFuLCAwKTsN
Cj4gIAl9DQo+ICAjZW5kaWYNCj4gLQlzcGluX2xvY2tfaXJxc2F2ZSgmbXRrX2NydGMtPmNvbmZp
Z19sb2NrLCBmbGFncyk7DQo+IC0JbXRrX2NydGMtPmNvbmZpZ191cGRhdGluZyA9IGZhbHNlOw0K
PiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3Mp
Ow0KDQpGb3IgdGhlIENQVSBjYXNlIChTb0MgaGFzIG5vIHNoYWRvdyByZWdpc3RlciBhbmQgQ09O
RklHX01US19DTURRIGlzIG5vdCBlbmFibGUpLA0KVGhpcyBjb2RlIGlzIG5lY2Vzc2FyeS4NCk1h
eWJlIGtlZXAgdGhlc2UgY29kZSBvciBzb21lIG1vZGlmaWNhdGlvbiBmb3IgQ1BVIGNhc2UuDQoN
ClJlZ2FyZHMsDQpDSw0KDQo+ICANCj4gIAltdXRleF91bmxvY2soJm10a19jcnRjLT5od19sb2Nr
KTsNCj4gIH0NCg0K

