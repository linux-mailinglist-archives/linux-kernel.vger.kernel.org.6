Return-Path: <linux-kernel+bounces-412370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC8C9D082A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 04:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2396FB217E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 03:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82AA6A8D2;
	Mon, 18 Nov 2024 03:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bi1p7sf/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dzZ7Fv85"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59E38FAD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731900498; cv=fail; b=YVCkaVlFL86olWOM1B9poFniQ8FApF8XAZ7a5a5tFkyUSKOQd/pP4CxWC0ZSrOm7ri0xx8SBPXjKRgqJl1UXRJt+/PiZHqBVQdPxasjAGjhPuGmxoAO4ICJjU25AXZmilAT/G8s/A1k6cmp3hPmsC+YMGlEho4886APNvK8iawg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731900498; c=relaxed/simple;
	bh=9kmjKfAS6UaMlnEHIr9LjbjG3jay/39M6ALv7lb1e0U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bMH0M+fRONxyT5OdOYXNWvWn65bs+bRRHKDJ98vEUTpj94HqjMW630fNhcPNDummy5HchwAAOXx+tKT162ZqJaJMw/uKoMoQAQBdtTEi0Vn1dapGLCg+e9RqdEfCou+nu6jggA/QJGz6xqNgXQvD4CfNI8nZVOhoM0h3weGLhwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bi1p7sf/; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dzZ7Fv85; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 068eaa1aa55b11ef99858b75a2457dd9-20241118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9kmjKfAS6UaMlnEHIr9LjbjG3jay/39M6ALv7lb1e0U=;
	b=bi1p7sf/psS7kk1MTPLgYv//7QB4kx/Ve7x6hAS8JfrQ7+VuLd9xRhZIvxRZvQW5uRK6PX4egGgFmLScVZsda1sj63nQearLassIt9/FoF2KfgQemcMAufMOSXgw50T72S+P6T3rdQBzvp6vcARid5/lokR7LHV32KayufzFQo4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.43,REQID:9585a5bb-0c0f-4655-9862-2a598baa480a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ce19b8a,CLOUDID:66e33b07-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 068eaa1aa55b11ef99858b75a2457dd9-20241118
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <qun-wei.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 661430902; Mon, 18 Nov 2024 11:13:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Nov 2024 11:13:03 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Nov 2024 11:13:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU98wZhxfFs4g+eN9N0V2xr44/e/pb1j6MPnfjQ30EqwOM2p2ys/PzI+bRjq+WFuGfN5H9YnGsFQL+Tv/OIkjygCfy0QFngwbhjh2iux/r04Gl8PTuFzK4H+in6AgNVujRdL1f/hwQo8nVV98axHf5/WS1flLdOr4Zaj7Sv8aCL9mPIiaz+T/phV1WJUTwupw2ou9tKrjI6C17vcDXIOOjcLKKzHQCtnbdM/qqQnresQgeDlpks3gbQQBSHndTFilEvJX9VWKM4caP993RFjEswPDoSwTFuTnQQhyf8Npk5ooa788L9sfPCUpB8AOAChqqVSMZH0JK5CRmdxffCQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kmjKfAS6UaMlnEHIr9LjbjG3jay/39M6ALv7lb1e0U=;
 b=vKyH9dIpNTfwiIipegGPtbeVvfMmguADDrzk3ot8as+XYlj1Yi/CytRcq5fF6tXcmIqO1go40g+Ne6iRXF74UHEcYZzlUt4PLHySVSH+PKhNdbp1OgZLJ5vnQNaB9CbLhv8W7Qrcrl1zKHVwhowRZA4y0zDnIlYFazR/871aSDSsXY2q+1u+iTujaUquW0kLHSCVdRv7p3Toa/AHQKY6ag/WGAVQ0bdO4torSNBWOUCHDUqHAa2580wkIkCyKhNxwCAdrqurRmvqTuBR0qQCgeNIVpi9B3CNbJx1fp80ZxWc25NIn0CNMOm6RQuYI+TbGFRmZLX7nbmc2M/QmJAkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kmjKfAS6UaMlnEHIr9LjbjG3jay/39M6ALv7lb1e0U=;
 b=dzZ7Fv85qoWZr6B2AdAVl2BNwidICQB8PlR2T7lvszHX3KpvNj2E7UpTv9KeCg7E4GfwR/X1M7+KE3DGkhCTOFsRWbljeP5qhx2FWrlvTHzBeJHZ7xTMlJ/jbptPMbbWOXjXUtFvTv2Z6fNZZmjTvtcMPdJtAXyiWvv1DBSIosE=
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com (2603:1096:301:4e::12)
 by TYZPR03MB7893.apcprd03.prod.outlook.com (2603:1096:400:452::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 03:12:59 +0000
Received: from PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02]) by PSAPR03MB5542.apcprd03.prod.outlook.com
 ([fe80::a323:3128:209c:f02%6]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 03:12:59 +0000
From: =?utf-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= <Qun-wei.Lin@mediatek.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: =?utf-8?B?QW5kcmV3IFlhbmcgKOaliuaZuuW8tyk=?= <Andrew.Yang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?RWxlbmEgWXUgKOS9meWto+iKuCk=?= <Elena.Yu@mediatek.com>,
	"pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
	"shakeel.butt@linux.dev" <shakeel.butt@linux.dev>, wsd_upstream
	<wsd_upstream@mediatek.com>, =?utf-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?=
	<chinwen.chang@mediatek.com>, =?utf-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?=
	<casper.li@mediatek.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "kent.overstreet@linux.dev"
	<kent.overstreet@linux.dev>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] sched/task_stack: Fix object_is_on_stack() for KASAN
 tagged pointers
Thread-Topic: [PATCH] sched/task_stack: Fix object_is_on_stack() for KASAN
 tagged pointers
Thread-Index: AQHbNYQvh1efvUnKqEudqUv1Jmos1bK0yigAgAeaV4A=
Date: Mon, 18 Nov 2024 03:12:59 +0000
Message-ID: <bfc6291c4fadd5b7720945e6242a2f59f8f2dae3.camel@mediatek.com>
References: <20241113042544.19095-1-qun-wei.lin@mediatek.com>
	 <20241112230644.cfe24aa5e863112de04b16c0@linux-foundation.org>
In-Reply-To: <20241112230644.cfe24aa5e863112de04b16c0@linux-foundation.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5542:EE_|TYZPR03MB7893:EE_
x-ms-office365-filtering-correlation-id: 2ac09996-2d94-44a2-47e6-08dd077ee7b2
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cWlTaytFbS9jZzFyM0JoZWwzT0R5SS9BZ1ozbVkra2t3ck1vYUt3dE84eFFH?=
 =?utf-8?B?TGFFUFVBRnRMYWczUTNDY1ZDRTI3bmhWd0hhMS8zM2c2MGFIVVVNK1VYcE5i?=
 =?utf-8?B?My9XdENBRzFTMEw3OHV6cEprZHMwOUFYbU53L05SbWhBR1kzOWZwWXJWYWpr?=
 =?utf-8?B?V3QzRVBWbytwMzVXaVEvUFhCbDM0WC9CaUR2Tm1kME9NTng0YVNBVWZlcFZv?=
 =?utf-8?B?UTlTaU1FcjhSNjY4SmpiZU1NREZjbEJKaVZEZVpvMTlOUCtZQmpEUFJIL2xX?=
 =?utf-8?B?YzVtNGR5a0kxRUFxVjlEbWhSL3pIWTRUUTMrMVBmbFIvN0V1aTY5YW1UWHNQ?=
 =?utf-8?B?ek8yd2pHZVVWRGw5YmkvRzEzVk1UbzhIYVdvUmVLaXJ0bEpBcXhOcU1YY2dP?=
 =?utf-8?B?djJaVU9PejJFZU9jZ013RnpOUml2SElHUGlSMStnSGRZM1QyeFZIcDJkR1B0?=
 =?utf-8?B?aDVzT3g2em9zcTdRSmE0R1hhbEphSGhKZnBldG8vUHhWckh0THoxT3hZaDh0?=
 =?utf-8?B?QThwRUxWMitjSzJtcWxTckwxdE1BbEZ4NUNaYXQzbEhLSVpEWHlyaXNCdklt?=
 =?utf-8?B?Y1RSMm9Yd3BVcU15bktGcXVpYkJpWi8vMXlnUURDcmk0anVGQlFSYkF6SC9G?=
 =?utf-8?B?K0ZUVm5IR2EveGlCNG5KNHlQLy9IcjU5b1IvSTBXS0RhTGRWZzhvRTBVSkZF?=
 =?utf-8?B?VS9lQjdlM1ErTmQ3NXFvWjVPTlZmRzVUVlZSclJDT3lvSXZXVnNwTGNiOGtP?=
 =?utf-8?B?SHkzQjh5UjBSSDE3bEthcWtPQUU1a2ErZWJPb2tUdlA5MnNiQ0N4ZmY4ZS80?=
 =?utf-8?B?UVdQNVJBWmhnVUNON3lqS0xCMUFuOHBPVFJ4NkRuVlhZakxuU3E4eWtuZGZO?=
 =?utf-8?B?bTNjWkJIMnlGZVl2NmlYUkFVODBWa1k0TUZqdUt6SDNuZTI1YUtNUm9xeEJa?=
 =?utf-8?B?akQyS2tWVVVOQ1Qwc25oL3grN045TXBhb3lHNWZuYXcyK3NxOFo3MmMwbWtJ?=
 =?utf-8?B?MDhhaTFHaG5yWXV5ckRSSlpZUXJxWFZWcHc0dzkzTFZ2Y1AweTFkb2xQL29R?=
 =?utf-8?B?SEsxWWwxSWk1UUVZdlpQc0RWaSsrZUI5eWhVa3ZxTFR3dTlHcHd2bXB1eEE0?=
 =?utf-8?B?eE1TSHl5WHRXczhmdVBTT084a2poVzhJcHZ3R1VTM3pxTTFDYWx1dXV1YXN3?=
 =?utf-8?B?UlU4ZlFvcVY5enRpVW5VRElQL1l5cHZzczNDYXdGbEM2VHNiengxZzAzeWhZ?=
 =?utf-8?B?Z1RlTnRSVmExRVUzTk10MjFJQ0s2U0cvWjZLR1Y3aW8rR0RRWXhpbFA0V2dy?=
 =?utf-8?B?UlhNVEhVbDFuMW0rb3l0cjFYZERLVXFSRVBFQ3c0Z01FODlGbDRTcGFKK1do?=
 =?utf-8?B?bVRCTG13SGNDcFBscmtlZ0pibS8wZlpER3VyNmd2VmVGVmpCNzk1QXo0V1Fi?=
 =?utf-8?B?Rlpaajhld25jK0FqWnZrRVEvRm9Ia2tmdWlGRXhBRlpObDBEVVAxRGpveGtX?=
 =?utf-8?B?clpnbDdDU29Na1lvT0xCUFJWNUZhRExrcGFZeTVWS2svcEFrZjZDVWVKY1Vh?=
 =?utf-8?B?MFNMdktQaHlqcXgyYkhVamFRUmMzRWcyQ281Z0FpdHgvcjJtZWc3Zlhmdi8v?=
 =?utf-8?B?UlpJd29aOXhTajl3b2VQdjgySkt6Vm95aVhBWXJVNlBwTksvTXRQcUUySFJ4?=
 =?utf-8?B?TzBSemI1cTFOMlREWFMzYzFNYUY2TXZZSFdxZlZLOTR0ZU5BYU4yd2NLMS8y?=
 =?utf-8?B?bW83bENVbFdsZzZFR0h1WWYvSWxMNjltUE81cVVSWGRya1B3dmRiRXkwUVhs?=
 =?utf-8?Q?rbOhnwSWbZ7z/a+4hPnwa9G5JVyssuDb9JbJs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5542.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUtKM2EwNkZIWlljMXRiQ3o5ZkZ3VzNKS2JEUlZ0T1FqRVQwWmZWUEpHazNS?=
 =?utf-8?B?ZGhQc0xmeFExbTN2a3NENytwWWlqcG9oZTR6cDdvZC91alNFa0UwNWhEWm5L?=
 =?utf-8?B?Vlg1Q2V6V2xXV0RnZm1vbEU4czF6dnY4WjB6RkY0a1VlLzcycE5xMzBJY2l5?=
 =?utf-8?B?U2pNK1JKdEpVN2ZoaWFDaTNqeXlKbWZSSDc5VzBaNGhEUlNaK2FYNml4RTAz?=
 =?utf-8?B?dWs4aU1VdmhLcy9SR0xYMjR5K3FOb1l3cFpnWFlNWDUvVkEvZkZ1c003enE2?=
 =?utf-8?B?RHBTSlMyRHk2NDZNTVdIQlJoMkxSVGVXL0dhRUZITXYxTGRueFNDYmkySGR2?=
 =?utf-8?B?YnVnc0ZHUGgvTDJvcWplMjdFY2JpQ0lpaUNJS3JkdFNWOW9iajgvMkRZSlg1?=
 =?utf-8?B?L09jRUFRVjRieC9JWW1xUnlqMHpiNWRKSFB1b1F5OVNCeTkrOFdhSUQ5c2M2?=
 =?utf-8?B?QTNTVWlITktYaW83UlRPMFYwS1U4azF1amVVM1ZSZzBaU01mYjBZQURaZ1NW?=
 =?utf-8?B?M0g2NE5BdS8rNlNUZk9mb01MTEU2YUIrY3lUY2VMU3dPN0pYNlhNOTcycm5l?=
 =?utf-8?B?Z2J6cVN6QURnbmtnR1dtYjhwSkdiMzQwTHRmblIrVVNpVW8wdHRPRGpNaStN?=
 =?utf-8?B?ZEhQbWRQSGpGR1RMa0pwT0pmemxBWEw2QlpncUNIRkZDWjZocFZ6cHI1aEg5?=
 =?utf-8?B?ZlhnWC94SmhDYzJYRXNJbHNVZXcvSnVHcFZyRVZ0Z1ROS3FlcDJaUXBUUzg0?=
 =?utf-8?B?T2JMdnlwU3BDUWV1emxFUE9sVzgzbXBuMXFsLzBtdUUrM1hqQVNrUitKYXJm?=
 =?utf-8?B?L3RKZXVTU05ncnhkYmpaV2lYTEhqNXBra0szTzBmTUxKSm93cUdQdmN5cWdX?=
 =?utf-8?B?Ry82ZG5iRjRGL29JRFNzUW5tVHJURFpBSHhucGJJbGlNNzhydTJLSEFMem1k?=
 =?utf-8?B?M3BCTVI4Vk53RGZLU3ZXRXdTSE8zYjFqQ1NsUENtWGlYZTRzVHhwMEY3bjZG?=
 =?utf-8?B?cVBwVUREeTE3SW50WUxpdHdnYUY1SlVyUVhWVW5HMjVjcTZPVWcyak9Na0l6?=
 =?utf-8?B?VmRIUjJocXZXYUNLeXl3ZXJ4WEUwenkvMWM3ZzloUW5VcjkwOTNJYlVxSW5R?=
 =?utf-8?B?b2FZMEM0am5DcXhGOUJ5eE1yYkw2N1dsR1dRclFFREQrd08yVVE4N21tMUR3?=
 =?utf-8?B?c0hPNkdxVkF3UlBpMTM5SFlPbjZBcVRhdU1kK2lhTG1oYzE3VS91T0s5NFVi?=
 =?utf-8?B?MjlETGZSY0dVYmRZY2wvaGt3dlBjRGlXNFBqMEZBQ3ZwU0NVZVJIRGtOdUtk?=
 =?utf-8?B?K2xIZTJjWlBINzJwRUpOWmxya0crVmErbGZYeUhQRlBKK0orTm84MjdmK3hB?=
 =?utf-8?B?ZXYvcG83b0dUMDBWSVFqZjR3eDl6bVhFTHdER1AzMzVoM1pkdEkvdUtpV0dm?=
 =?utf-8?B?UmJUb2VlL2pFS2V5S3FHTjFyNnVJOHZFZ0Z4Rk5TOVlsR0RvZ1k0YXJBeTBk?=
 =?utf-8?B?WWl5d1paczZ0cUg5NFk3LzdIenQvWkVWbm9SUk9aZjVBZFY5T2lDVnpqUGZ0?=
 =?utf-8?B?R1hvdzVqcC9rTUovZXRMMXdpa1RITUx5M0RqVlN5Z1psRjdiMnJSQStSSlpY?=
 =?utf-8?B?Yy9pUlozQnBRVzZhVFUyS0g4R0ZNUEVUeWxiRkJnb2RORXE4WkdIRktDQy9S?=
 =?utf-8?B?djJWYkJuSEZSUW1RanRhUXducjFkK09sdkhCUGxKdWVSakxXWG1DdE1XcHY5?=
 =?utf-8?B?KzNaODZVOEdramZsTW1uN3RoSDBuZ1EyNzJ4ajZjOVhLbkxaUFI3aDV4ejd3?=
 =?utf-8?B?bER3SEw4Z1lXZ3VtclJHMmw4RW5wYzJNeDlOODNLNUYwbHROZFZCVUZTOUpn?=
 =?utf-8?B?RU1vSDJQSlg1dHFYN0hJOE1wdjhUN0FUZDRqMXZBZDYvZFpqZitCNmZ2OXIx?=
 =?utf-8?B?TmVoYVBUNGFrZnBRNk9WOXI4Tkp2Q01FdkpQSHpuY21RckphZy8xNllCVElB?=
 =?utf-8?B?TjZybmNjZ2ZVenlwR0l1cE5UbnBaeUpYb1gwOTZBcjhRZHp2SDM5MmNSaUlN?=
 =?utf-8?B?ZFJzRTh4NHB6QUM3TnhKR2tqL0RXNHl6MnVkcmhQVlZmdDZjaFQ0S3RKN2Nx?=
 =?utf-8?B?NjJreWxGa0N3WThyYk1XbURycW5kK29tWUVFK3g4R2dBVklxamFiQ2syVFp0?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACA3AB07706F1C418F859084FAEE6729@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5542.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac09996-2d94-44a2-47e6-08dd077ee7b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 03:12:59.0840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GZ2no9g9SIyl9UptgNEL/xpZlsP5db2FYEGMqu9z78uCbVEpWQiCB/+E0pzWyPQW4r4O7dO3EcoOhc6lUWvATvHG4s1scrjAi/nN5315yDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7893

T24gVHVlLCAyMDI0LTExLTEyIGF0IDIzOjA2IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIFdlZCwgMTMgTm92IDIwMjQgMTI6MjU6NDMgKzA4MDAgUXVuLVdl
aSBMaW4gPA0KPiBxdW4td2VpLmxpbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPiBXaGVu
IENPTkZJR19LQVNBTl9TV19UQUdTIGFuZCBDT05GSUdfS0FTQU5fU1RBQ0sgYXJlIGVuYWJsZWQs
IHRoZQ0KPiA+IG9iamVjdF9pc19vbl9zdGFjaygpIGZ1bmN0aW9uIG1heSBwcm9kdWNlIGluY29y
cmVjdCByZXN1bHRzIGR1ZSB0bw0KPiA+IHRoZQ0KPiA+IHByZXNlbmNlIG9mIHRhZ3MgaW4gdGhl
IG9iaiBwb2ludGVyLCB3aGlsZSB0aGUgc3RhY2sgcG9pbnRlciBkb2VzDQo+ID4gbm90DQo+ID4g
aGF2ZSB0YWdzLiBUaGlzIGRpc2NyZXBhbmN5IGNhbiBsZWFkIHRvIGluY29ycmVjdCBzdGFjayBv
YmplY3QNCj4gPiBkZXRlY3Rpb24NCj4gPiBhbmQgc3Vic2VxdWVudGx5IHRyaWdnZXIgd2Fybmlu
Z3MgaWYgQ09ORklHX0RFQlVHX09CSkVDVFMgaXMgYWxzbw0KPiA+IGVuYWJsZWQuDQo+ID4gDQo+
ID4gRXhhbXBsZSBvZiB0aGUgd2FybmluZzoNCj4gDQo+IFRoYW5rcy4NCj4gDQo+IEFyZSB3ZSBh
YmxlIHRvIGlkZW50aWZ5IHdoZW4gdGhpcyBzdGFydGVkIGhhcHBlbmluZz8gIGllLCBhIHN1aXRh
YmxlDQo+IEZpeGVzOiB0YXJldD8NCj4gDQoNClRoZSBpc3N1ZSBoYXMgYmVlbiBwcmVzZW50IHNp
bmNlIHRoZSBpbnRyb2R1Y3Rpb24gb2YNCkNPTkZJR19LQVNBTl9TVEFDSy4gVGhlIHN0YWNrIGlu
c3RydW1lbnRhdGlvbiB3YXMgbm90IGFjY291bnRlZCBmb3IgaW4NCnRoZSBvYmplY3RfaXNfb25f
c3RhY2soKSBmdW5jdGlvbiBmcm9tIHRoZSBiZWdpbm5pbmcuDQoNClRoYW5rcyENCg==

