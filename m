Return-Path: <linux-kernel+bounces-354455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 422CC993DAF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1BC285F11
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2224F8A0;
	Tue,  8 Oct 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k/XKaPbL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Icgk/tgV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73951DA5F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359526; cv=fail; b=gVDX1HnbiUUKJeKCKnp7jjI0EsOP35UvlMiDmYTDxvzis+QsIsqJAnFbdG/9PlpG9aIut8E0Bnp4xLguGoC7zciy5mRDo6ini3jO9FWVPoFSjBDEYHmGjRe+bTyNbFHPSGrFNHJtUsxzKhNLt3LIgylNdrXafUviPH845nDAFjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359526; c=relaxed/simple;
	bh=ulzSDTQQrgMpgoTEhRPlvypkugRVCUjGtzXZTp8aYoQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KzZwNTzXreHfq8XRLVWwaSvme/fU8dPg3H3DQkkAfP9PycDqG3mBhJulc9Sk61BRj9LYBSmKR796J15Iecd4oVfpagxJZOypZ90GNpHYnM+jb00sHyidtS4NW9EAwy6L1TmYCDieIUQRwGR1p5WKgh9Db7tH5BsLqCoQO2mStxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k/XKaPbL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Icgk/tgV; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a7b1eaea852811ef88ecadb115cee93b-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ulzSDTQQrgMpgoTEhRPlvypkugRVCUjGtzXZTp8aYoQ=;
	b=k/XKaPbLdVSS0WndQ610N685kVGQm76x2Re7rkxzbEwFwSYNoB5gD0tkLELPE04BeF6KLqv0t+XlUhQ0hJ5YlWo0cTwaCoa3YnAyrrV8PRTZbfcvvM96A54jThNT2UtHzsV9nqSXCukTddihgji3V5NUOVvNwuSffgRGhBUR/Kw=;
X-CID-CACHE: Type:Local,Time:202410081151+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:fe235cd1-0131-4222-95d3-0fdd98b07ab8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:9496e940-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a7b1eaea852811ef88ecadb115cee93b-20241008
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1345075663; Tue, 08 Oct 2024 11:51:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 11:51:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Oct 2024 11:51:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xo8Fn5L0M8pVDID1Sp6qQ/sJWt2duJhyofAfrZrjaXu/+q6GCbLHXgl0LfGHQBFF+mPIxAI6h0drxwY5JYPxo+RXdKuokdyx1UxwO7txBpU9HTnlAtW65a/QVDAopYlwl1GsajPCe2G5V/HAdq5r1uCP0UvysL0h2rmrRVrUDQgBWn2D4JHsVXZmO8LXqiF7/+YgaDLV0wKhDmbtJ+CnTNLBieWsXk4XSuis+5ckhZP0OFuWOBcv12nm4ah91R+jlQM+/DKzBHL+alaDmZysZI75UsjYjd2f8Yfr2n5GSwkcdsU7G+KhPevNBTw7l0X7LEkvLHQljkJ0oDDwxQeieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulzSDTQQrgMpgoTEhRPlvypkugRVCUjGtzXZTp8aYoQ=;
 b=ItSrMUAnLvrK7jK0FtXRGQDymIDQVq9XguHjaQ1XhCjg8lrLgzhuP8FO9iCmO9G0EhWcsrP5B0ymfhJgZhgts/b4vRtL/9XDFU3s3ZkfPnVXxH+bC6NQMX2pZokHM+l47U9xzkJRhCLFxdxqBWRpiRhZD5ExSqaBB6WCqK/RWPupdkoF/snTDLlXzTP1cdO5x1mq6sVjy6we9wCKdR0IYOdEzV+57ZPtk/qbboxXdU2MA6fln9bHDCo+TV7d56Q+1ICufJlePEglv49pXn8q1fpicRYXidOSQx2lbx7hCYxHDlbFJP38vGWw3gSwzrHF3KPJitxYE9T3Zgar8w2UgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulzSDTQQrgMpgoTEhRPlvypkugRVCUjGtzXZTp8aYoQ=;
 b=Icgk/tgV0h9NvYMRITcTn/O3aL4v/6bof4lpvU59n8kp0Gu4V0rTVZ7pkiPZx2o4e5dMDCILwKNy0M9qYHHmdHx7yEQi/5mu8bznQpDcnqWOyJxyYI6Z46k6DQ8u1JWSj4ONYgYWqnZCTamD85uTPIP2+Ku16SrMM02UK0Gxg+U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8587.apcprd03.prod.outlook.com (2603:1096:405:b6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Tue, 8 Oct
 2024 03:51:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 03:51:45 +0000
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
Subject: Re: [PATCH v9 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
Thread-Topic: [PATCH v9 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
Thread-Index: AQHbGIb+dIsm+AMDP0ODssaFxzZfObJ8OboA
Date: Tue, 8 Oct 2024 03:51:45 +0000
Message-ID: <3b1c62caf4a80892071607ce944c151541a7c7d6.camel@mediatek.com>
References: <20241007070101.23263-1-jason-jh.lin@mediatek.com>
	 <20241007070101.23263-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20241007070101.23263-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8587:EE_
x-ms-office365-filtering-correlation-id: 9bc859ea-7f3e-4076-47e1-08dce74c872b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dndYS0RWYlAwVlo2Z0F5Y0dMSGZ6RnFZM09NUEFNSjBXelJ1cVdKQ1RKRmdt?=
 =?utf-8?B?NTg4VDlBbUh3K1A2NWtTdVVocFVEdDN5QkFnZElLYkJYTmtzamEvZXQvYjNE?=
 =?utf-8?B?UkpZUEYzVWlwSzdJcVlrUTBDdXZYd1BDclp0bzF2cG1XTkh6R3h4SFdZUkpW?=
 =?utf-8?B?dkliQ3FJandxM3ErMWJhb0lzUXZKZVBUUGhYTTdsZXpiVEU2K2d5eU8vbmk4?=
 =?utf-8?B?ZFVJV3QxRHRtcjZBMkZkVE0rLzIzZWsyOFB1dTNJcGZwL1pwT2N1TGxUY04y?=
 =?utf-8?B?YldZNnNlTTFZK3lneHZrU05UOTZmRWZJakJ2V0hKa0JsTUVrYU1iWDA5WHpk?=
 =?utf-8?B?THZyaEM2NHpuTUV6ZTUzZ1lYcHlmSTQwMDJURjJ0Y2g4QzNzSG9NUk5aNTE4?=
 =?utf-8?B?OWVxYUpkVWNUR094ZHhXMThIZy9Bdy9iVWNoSk9YeE5adjJkajl1Z3kwTGhG?=
 =?utf-8?B?d0hVY3c0Z0ZUM2NxVUszYzhXUVhuSnpaS1NIOXdvaVFORUgvZllKUHJjdXZp?=
 =?utf-8?B?WEozMkQ3dmREb3dJWmk5eUlvOUVsRnVCYmFEZSs3STBvR3FBVnFDN3RMQ1Ro?=
 =?utf-8?B?TWtaMWxmMUNWWThuNmtOT0lXYVhVZ3Y5OWFJM1F4N2Q0L3I0Sy81ZVlvQmlE?=
 =?utf-8?B?WmJuYitDbm4xc3pzbXYwcENjaVhCa0RiaG92S1A5aWt4aGR5TkxIbnlyemx3?=
 =?utf-8?B?Z1VNRWhvWnFEM3B6a0YxQkk1eTJ0UkttbWhjdkJxZjE1czNPbFp5eWkvdTVQ?=
 =?utf-8?B?RlVsWVBFWjR1bm5zY3dTWlZUN1Nwbms3elhzS2liSG5PNlc3VXJxME5Mc3Nv?=
 =?utf-8?B?S0tvdkNhUk9sR1luU3dvaG5vOHVTb244RVBSRXdnbDZ3MTl0dnU4UmczQi9O?=
 =?utf-8?B?am50TnBkSEtxc0hvN2xMUnNKcHZxY3JmQmZKb3RUVGg1b0RxNzF3dGM2N09D?=
 =?utf-8?B?K3B3M3lpYzBIaWRUZFA0MDAvOW94UTZ2OHliK3VuaTNZcjRmTnNoODVUTXdt?=
 =?utf-8?B?SStOQU1mOUlYWWFIcGNGN2Nnak5Lcmx6bUYwb2gxVFBCNnVPL2hoRU1ONVZj?=
 =?utf-8?B?cmo3emJoa2pBWEtoVXNRcWdJL2dpakVvcXRVQld6SnVRZlBCS0NGM1haWm1Z?=
 =?utf-8?B?QUxIR0VnWEJsTmFYUzVtTjdsTDNHSk9aQVdNSFZ6bGJTN2E2Nll5N2VOUFBL?=
 =?utf-8?B?NHFLRmNPOVQvUzFtcERHQnBjSWtNL2ozSmVxZnFWcTVkdGFqRTVQdlZIZVZs?=
 =?utf-8?B?ajFLRjFHaXA3dnVRcWk0STFyWXZ3YXhJWVh0V09aajRMUXNGbWk1alZzalpG?=
 =?utf-8?B?bWpYUWxvQm5JU1Zwa2QzMG1XeXgyVjJrME5qTnZNQk9WVUltVDVlWlkySWI4?=
 =?utf-8?B?V0dqUlJiMTBDMmdoUGdmVWJ5azIwUmNTQkhNaUQzTXRHdnVueHlPYXduKzd5?=
 =?utf-8?B?UklZekV3UExPNFNKVHY3WHM1QStWYUJERG1zazh4VURvemIxQ05JYlgrK1FT?=
 =?utf-8?B?VHZWQjVqczZBZHA1SW55U0d0ay9tTUVYSENuNzRkQk1NWFBobWMyMXJ5RjN2?=
 =?utf-8?B?U05tQWFtN0tiOGpGUW53aXd6S0Y4Ym5yN25USWFHeklCb1pzd21aTmxBUWVP?=
 =?utf-8?B?WHh2UnJaTnE4ZlpqWmQ5TnNWMlVBUStJOWUvUXd0bnpHNGNTanh2UUJZNHA5?=
 =?utf-8?B?b1pWbURIblJwR0k0MEthNnpNcEJVMlg1TnNmRldLWWZjQzZUNkR5T1Bnd0Jr?=
 =?utf-8?B?Rlp4dWFuQXhTR05BMUtGNUltOTBTUzg0M2JIWmRqd3FCaWRCM0FZTEhFYkxp?=
 =?utf-8?B?N3dVdWhERGUyM05JRDExdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZE1ESzA2c1E4MVRIajU5S0ZRM1lmMlMzc1R3WlBRaHJ6N1NDQy9kcy9iaEtV?=
 =?utf-8?B?dGl4Z05Ya0JTQWwzU1dIekpSa3ZBUXRQbzEzRmNYZHYyU09UT2VQQy9BWWlB?=
 =?utf-8?B?TExwS0ZwVzFyMkVsV1F0VEl3WGRkakhLR1MwZVBiSjFCbllGaWVtUURzWXpF?=
 =?utf-8?B?NVBUa0VDa01qekhaNVU1NGN1TjJlbWE1QjlqZVIxTUFsOTFCa3lXVjJCL1BP?=
 =?utf-8?B?L3pTdW82UzZjSTBRY2hyOUFQRXdLZU5wRVBRMlNNOWVNRU9oaGlFWEdnSHRW?=
 =?utf-8?B?L2trVk8wZWRJUVc3TDdlNXRIckZxMjV5emNXMmYzNXFGaEdGbDNUbFluMlk3?=
 =?utf-8?B?TnBkYzA4bndPTXAvSHRFNnJGbXJPS2xVTDhuYUZ6SU80YmxlSHErUkovdDFC?=
 =?utf-8?B?S0h4aml2WVJYbkhQRThGRXNKODJnRElTRjRPVFpERTZnU2M3b1lUditIQThs?=
 =?utf-8?B?clNZRHdjV2VvSFV4T3BNcFIwRTNQWjNqeVp5amlmUlZSOWN4MVgzdWZFL09E?=
 =?utf-8?B?dWRrbk1wRHVoZUF6WGxqcElUcDRDekdBZlFvbzhDNmJsZkFBS3FCZUNRMWtI?=
 =?utf-8?B?QXNVYVhVcXRXRmR2WVIrb0FpQ0Yxc2plbG0yM0IvK2hzSnRxKytaNTB3dTlJ?=
 =?utf-8?B?UzlQS3h6aDRRVmZHWFRib1NHbUhyTWM4OWhsMzhWQ0MxZldSWENKVXo4R3Fx?=
 =?utf-8?B?bGdwbGRCSjdjVlBCOWFOaWIwWFE2TlVBMVdWTmpOUnJNNTZZbUhzazFyNDlk?=
 =?utf-8?B?VC9BWWYzVjlTQjRlN2ZYMVpyQ0xXcTFyV1hUZkRkbEJURTlXdTI1d2VYSDhr?=
 =?utf-8?B?QXJSejNQd2ZqVEQzeG5YNW1DcXJvSmR6TFFkZE5KWFBGMGRWcVM4Wkx5aG54?=
 =?utf-8?B?bWVTT0o3QW01Ui8vU1pWUnMwZ1l1cTBjMDA3MDlBUDMwS0F5S2ZkcVg2OFZZ?=
 =?utf-8?B?NUpHalExaGVHdG5tTWtXcG83UCt6RXFCU0JlYm5idm5SVDBtak1zUmZnV0Y5?=
 =?utf-8?B?SnpBT2wySXRCMjVFc1NQZDhVNjF5UWxVWGc4N3VzYmVNUjFkeGhQUDdMWG14?=
 =?utf-8?B?aFRrTkRNZlRkenN2bGlodStKSmZkRlplUTR1MUM2d1hNZUQxS2U0Yzl1QkpQ?=
 =?utf-8?B?NjFvR3Y0OVRWU01XdnFIeGFVOHhJNzdWc3g2LzVKY1JDbTVBQ1loSzZGYWE1?=
 =?utf-8?B?VGY4NSs5WnU3aHFOMk8zcGJORjRXZGd4VDdQNkIycnlVUHR4NStncHAyOWkw?=
 =?utf-8?B?eGpQWVNQRE1sU2toaWNhZ0g2d3JnemJZVlNRSDFHQjZKWC9sejAzaG92SE53?=
 =?utf-8?B?N1VDdDhPSXdIOGI1aWVSN2o0ZlVOT3hvSjBpUVJhQlZjYVY3TzNqZTg3N3g1?=
 =?utf-8?B?WHkrd1R3OCttV1pITldZbGVOV05pQnhVUXdhZEt6RFA2V0t6K1NmVFJ5ejl1?=
 =?utf-8?B?N3F0cW9iSEMyUTBOdklyeVVHdXlEb3g0TjNibk9hbnRMbGw5UDlkNHVqcFB4?=
 =?utf-8?B?dTExTmhyMG9PTUV2bSs2ZTNsOGRZSGxrb0hvZC9YdytWNlhVWEhNSFFUck9a?=
 =?utf-8?B?NTZhVUw1SFhvS2pNR3BtWHhHMVBnOUFxV0VBNThUT0RYUkFoTUpOK0cvQ2cy?=
 =?utf-8?B?L09Sb1hGS0hXYUZvSjdCVndZUWNVWGl5NGwvb0xEeHdiWkFFd2tKV3lrNHpl?=
 =?utf-8?B?SGdsNmFSOFk0UUc3QWlWcnU2VngzZ2RQVExNc1FZR2RWSyswRWcrb2VFb1Z4?=
 =?utf-8?B?cS9ZaE5aanIxNVd4TkdoTUpuVlF1Q25ZMm5ZeWtVRjZnMFRLWWUwT2RCcXRw?=
 =?utf-8?B?ZGdzOGhhMlpRNVBMaEZ1a0ZvVloxV3A0UWRnV2NmZFVQQlhqaEtoVXE5U1dH?=
 =?utf-8?B?TUxsZFhWNmNvVjZISjBhUC8vY0FuV0JwOWNKQVZVQXlXS1liSzNyQnpNMWwr?=
 =?utf-8?B?b2JvM2FXOWc4ZDgrOFFsbWRFNzRCbjVOMFV4RWtUK2FvU2RrZXc0c2srL0pw?=
 =?utf-8?B?NDZYYWgrTGRjZnZUYVhFeFZ2U2lQTmFZVjJOYVI1SFJ0YWR2SkVaam9lWnFY?=
 =?utf-8?B?S0h4ZTBrVVlieEVuN0g4eFVudUU3M01WOHF3cnhFNzM2M0ZHSkNPbE9oVkhi?=
 =?utf-8?Q?vrS4qcxaznYVxikvOIfWXad0w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D19081351F3C7C4AADE1C65A243BED63@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc859ea-7f3e-4076-47e1-08dce74c872b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 03:51:45.0472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hy6N1fOJCRuKtQw6O/vhE8a3EWgj7gNN1KhswMJpxAufEBgZQobvKaUW4PySvvy+zfvDEGM5bJF2ByskNbVE7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8587
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.221400-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hf4OiVTWoD8RCa1MaKuob8PC/ExpXrHizwE6M1YtcX6vEJm
	fftVAWC9nqPz2h8mJXXdIiuGjs8pBkIjaJSsaV6ql1zsjZ1/6awF15s6prCIuw9Ki1Evn0W5vFf
	PytWHA2khXi7xgp14q/Osv2OU4IcBimxB5lXt796xNxaTG4Ot0hxlHnS3TyBRmyiLZetSf8n5kv
	mj69FXvKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7PdwZzz3KiZn+yfrwDw+EmQbSDtbtBuOZ17S8
	2Ep1KK697yzcce/Hx8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.221400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	12AC8755F4502B065C3F24C43E418443D01DBDDBDFE77D4BE70917AD12B2A3FC2000:8

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjQtMTAtMDcgYXQgMTU6MDAgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gSWYgdGhlIGNvbnN0YW50IGFscGhhIGFsd2F5cyBlbmFibGUsIHRoZSBT
b0NzIHRoYXQgaXMgbm90IHN1cHBvcnRlZCB0aGUNCj4gaWdub3JlIHBpeGVsIGFscGhhIGJpdCB3
aWxsIHN0aWxsIHVzZSBjb25zdGFudCBhbHBoYS4gVGhhdCB3aWxsIGJyZWFrDQo+IHRoZSBvcmln
aW5hbCBjb25zdGFudCBhbHBoYSBzZXR0aW5nIG9mIFhSR0IgZm9yYW10IGZvciBibGVuZF9tb2Rl
cw0KPiB1bnN1cHBvcnRlZCBTb0NzLCBzdWNoIGFzIE1UODE3My4NCj4gDQo+IE5vdGUgdGhhdCBp
Z25vcmUgcGl4ZWwgYWxwaGEgYml0IGlzIHN1cHBvcmVkIGlmIHRoZSBTb0Mgc3VwcG9ydCB0aGUN
Cj4gYmxlbmRfbW9kZXMuDQo+IE1ha2UgdGhlIGNvbnN0YXRudCBhbHBoYSBvbmx5IGVuYWJsZSB3
aGVuIGhhdmluZyBhIHZsaWFkIGJsZW5kX21vZGUgb3INCj4gc2V0dGluZyB0aGUgaGFzX2FscGhh
IHRvIGZpeCB0aGUgZG93bmdyYWRlIGlzc3VlLg0KDQpJdCdzIGFscGhhIGJsZW5kaW5nIGVuYWJs
ZSwgbm90IGNvbnN0YW50IGFscGhhIGVuYWJsZS4NCg0KPiANCj4gRml4ZXM6IGJjNDZlYjVkNWQ3
NyAoImRybS9tZWRpYXRlazogU3VwcG9ydCBEUk0gcGxhbmUgYWxwaGEgaW4gT1ZMIikNCj4gU2ln
bmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDggKysrKysr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggODliNDM5
ZGNmM2E2Li44NDUzYTcyZjllNTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gQEAgLTQ3Myw4ICs0NzMsMTQgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX2Nv
bmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICANCj4gIAljb24g
PSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQsIGJsZW5kX21vZGUpOw0KPiAgCWlmIChzdGF0ZS0+
YmFzZS5mYikgew0KPiAtCQljb24gfD0gT1ZMX0NPTl9BRU47DQo+ICAJCWNvbiB8PSBzdGF0ZS0+
YmFzZS5hbHBoYSAmIE9WTF9DT05fQUxQSEE7DQo+ICsNCj4gKwkJLyoNCj4gKwkJICogRm9yIGJs
ZW5kX21vZGVzIHN1cHBvcnRlZCBTb0NzLCBhbHdheXMgZW5hYmxlIGNvbnN0YW50IGFscGhhLg0K
PiArCQkgKiBGb3IgYmxlbmRfbW9kZXMgdW5zdXBwb3J0ZWQgU29DcywgZW5hYmxlIGNvbnN0YW50
IGFscGhhIHdoZW4gaGFzX2FscGhhIGlzIHNldC4NCg0KSXQncyBhbHBoYSBibGVuZGluZyBlbmFi
bGUsIG5vdCBjb25zdGFudCBhbHBoYSBlbmFibGUuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICsJCSAq
Lw0KPiArCQlpZiAoYmxlbmRfbW9kZSB8fCBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxw
aGEpDQo+ICsJCQljb24gfD0gT1ZMX0NPTl9BRU47DQo+ICAJfQ0KPiAgDQo+ICAJLyogQ09OU1Rf
QkxEIG11c3QgYmUgZW5hYmxlZCBmb3IgWFJHQiBmb3JtYXRzIGFsdGhvdWdoIHRoZSBhbHBoYSBj
aGFubmVsDQo=

