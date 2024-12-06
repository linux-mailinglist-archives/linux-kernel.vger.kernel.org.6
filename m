Return-Path: <linux-kernel+bounces-434496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8A09E6780
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E1E1885F58
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 06:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2A1DA61E;
	Fri,  6 Dec 2024 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ckmJnj6j";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="agop9veE"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAD28684;
	Fri,  6 Dec 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468238; cv=fail; b=IIpRx/W+0ZC1IVIU3ybGm30MVOS3rcy1g5BL73A4GkFjxXjfcYOnGr9g1E+9CS4kj82rWhfgLMRBZdMTBT3qEIOA9MKGp90/+NMHwpLbxoNqK42jcgPtlMA0gaM0JRxh8tj/BvePibObRWDJr5sT83E57WkN3ntlHCtTc7hoHbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468238; c=relaxed/simple;
	bh=naSxPGS4jqBLlGD6i/2oV8dqJx0AWD+JHPdmpiM2Fag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7+RZZ8LASdXeLclWt+fzsWi2WOJX1BnNFjyTHZxg5PX/whKDTAYyN9QDNn7gXWIrR8sRB3t69lTmr+FdX65YB/qn9cH4VlCiPWvBpCsAqwzcdZzTsVVSI7NBwWaQmx49ZbJW4NzsPkMsdW0J8ah4a8YLfqnMSG0JjvJQP27/9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ckmJnj6j; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=agop9veE; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4d12bf4cb39f11efbd192953cf12861f-20241206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=naSxPGS4jqBLlGD6i/2oV8dqJx0AWD+JHPdmpiM2Fag=;
	b=ckmJnj6jAmAdANEJ2hxXKVGXyc4I6ivP/Lw3M/Osy7ILhnMInx4EeOOmpbmiptqUcBntDMlU6wM34Tvoi6xJjikM/sLBh8MXeq0YygYKdl7HwE6oqDPxyNI43C1O7Mo5Qll5p/wgf2bwDuOartFuiow96r1Hy+l+DWSx+ZM2/TY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:08f46120-d3ac-4b10-a052-549929bd2bdb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:d03b883b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4d12bf4cb39f11efbd192953cf12861f-20241206
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <trevor.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2076272862; Fri, 06 Dec 2024 14:57:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Dec 2024 14:57:02 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Dec 2024 14:57:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pK4gQhEWggs6YpcYWLQLmVslK5j/kZb1GQh8R+3HlOwSyJIZBHWqQIRpu/GxpzgW8f/fVO0tlc/TE5D2R4dPGDCZaRsd1rQ/Bp4bUlnIO0vlws7XW4pIop3MNAjUYEnMkTlvMsBF774NZ20uUuYGVesh849pj8HBfqh0XuPzqtaL9fYcmOtvrQGj52eL4UQCASfkNzDG0r4Jg3QU0ja/fKGNmJyjbQpTqKTItADutKq/1HB3dPzim4n33cupEcoHVulOfqOPFvKhRYo7UHroOd094ji3/tnkl5/NGxO3gCfOBCabqTF9JcsZ2Mx7zcR7vOa6WXiUdXe9aeNbPNAg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naSxPGS4jqBLlGD6i/2oV8dqJx0AWD+JHPdmpiM2Fag=;
 b=JInFWGWaWsCzEEMddbizxXtfqG7AdO5h4ZSis4GEO1kQ0bDCcy6HO0IIfwAXegO6BvAJGF5jLbyxWXumlmu5owI24VYPVDDL5tbAuL1PY/xB2lLsf0uZaoitYBcwu9Lo174ZSwy1cZBSmWs1sSr4zcRlaeRn1O91Thn/jnY4wVW9wWgP0CSbYaSGIfHWiBn6OOQeX4sOTTCPpAwSZtVoVuatDC9YjiPnGNg9Iqt/Md6XsfFsYH2fZAHVXeS6nYMf1R4ZC+//SD26z9sJRJt9xETNJnibpBRtGpUdMMAgHppXii9sHprOWvcmEjtx9G5UgZHey+U6fWxYEyp1EnKorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naSxPGS4jqBLlGD6i/2oV8dqJx0AWD+JHPdmpiM2Fag=;
 b=agop9veESGzINBUrFmA5pjbVHvXT/4V+896LUhhJPH12TL8pDAyYvjBDT1YQ7gL9LjIW6DAJRvDesL+PyNhqK2So22iAKXWZuzZrNKUXYhgBXRj5P+wOyoMvh9CwNfVG8Y4rYvPK36+OI60yoTjPzaXd20s1jVgrY/qJoPvrPoE=
Received: from SEZPR03MB6690.apcprd03.prod.outlook.com (2603:1096:101:7d::13)
 by TYZPR03MB7996.apcprd03.prod.outlook.com (2603:1096:400:44c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Fri, 6 Dec
 2024 06:57:00 +0000
Received: from SEZPR03MB6690.apcprd03.prod.outlook.com
 ([fe80::6074:c8a5:f307:8672]) by SEZPR03MB6690.apcprd03.prod.outlook.com
 ([fe80::6074:c8a5:f307:8672%3]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 06:57:00 +0000
From: =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, Nicolas Prado <nfraprado@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>,
	"perex@perex.cz" <perex@perex.cz>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Thread-Topic: [PATCH] ASoC: mediatek: mt8188: Enable apll1 clock during reg rw
 to prevent hang
Thread-Index: AQHbRb9VohAiDdD8c0CabJesaGe9E7LWAVgAgAGcGICAAS8nAA==
Date: Fri, 6 Dec 2024 06:57:00 +0000
Message-ID: <1d2ee55dde84bcab6f777525042c6789b9f2c1fc.camel@mediatek.com>
References: <20241203-mt8188-afe-fix-hang-disabled-apll1-clk-v1-1-07cdd7760834@collabora.com>
	 <a10dbdf265194e77a69b6e40afa3df9636b3ab14.camel@mediatek.com>
	 <a70a0521-985d-43a4-a1fa-36eb733d5ca9@collabora.com>
In-Reply-To: <a70a0521-985d-43a4-a1fa-36eb733d5ca9@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6690:EE_|TYZPR03MB7996:EE_
x-ms-office365-filtering-correlation-id: f82cc5e5-ae48-4ccd-4ec3-08dd15c32ed8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QWcrL1ExaGNxRGFIcDhUakxKZG51TWw0VHhyOHdyUjZhU3VpRUNBZTZlMHRO?=
 =?utf-8?B?L3E4TWNFOEZYc0J4TWJQWlBwVHkyMG85MkwzNHNJVHd1NHJSWUNsVmVudWdE?=
 =?utf-8?B?M1BJWjNjUFVlbDlSSFRodk5zZmxaMVdOZzZuWVR3NEJsaktvVXJsTTd2VUU4?=
 =?utf-8?B?S3lwaUlzMGVwL3RLd1Y4T1hKRE5YVWJPQ0lSZDkwLzBmcUlPTjlTcmNXYnZK?=
 =?utf-8?B?WkFFaDgxMDdPRjFjV0dLb0FIUFBxT0JoMytNc1ZNZXdGWFhnbks3TExKL2k1?=
 =?utf-8?B?dzJSUE9FajErVGVua0t0Nlg3cVpYVE1MYWUvSGIwT0pWd09CMXdWMDZiRU50?=
 =?utf-8?B?aEZUazJJcGRGcnY3WkdydW9hUW1NRW1oc0M0bEFKTmVNakdwbmE3SnIwTGQ2?=
 =?utf-8?B?elRneCtLa2haQkFONSsyckNBRVZwRmcvSGhiY1NESWlybUVZbHFkQWlZMWg5?=
 =?utf-8?B?L0hZeHJxVS84OEtHWTRNdmpvb0k3VHIrYlNoL2hQYXBhZ0UvdWxrWGExekVv?=
 =?utf-8?B?RWQrQ1FBNzFBOVlsZTZSNWhRVy9YaVdNV2V4YlJlNGJiUkYyOEM1bmhtODhl?=
 =?utf-8?B?SHNtTzNDa1Zkcm1TTlBaZC81Qnc0bWV5bTRXUC9NSC92YVFsTUpvVjFYL2l0?=
 =?utf-8?B?amJEY3RsTkJRQlJSdE42ZU82dzROU2JETXdTYWMrRThUcm9tQjB1TDFtdTNK?=
 =?utf-8?B?aDIzQWo4KzJwZ1pPNy9KcDZ2cmNWblBxU0ZFb1R1T3RaOW42dHlsQjdPNUZh?=
 =?utf-8?B?elYxK1V1YzgwbU9JZTRlSlFZWUh4Nk1Gam10RHZaUEtZTGtRdVRldEZMWWcy?=
 =?utf-8?B?Uk5NTFF2Z0lidlJGNkpuS3UyZ3dFbTlZM2NpM2FUT1RSeWpVZXFDQXVBZk51?=
 =?utf-8?B?ZGkyMGxTdFJoeGdUTk5xWlhlUlpsZzJ2anV0dmpSYWM2aFRaZGV6TWdTdnNV?=
 =?utf-8?B?RXFMNDg5dm9FZ09VSWEySVMwWjR2UjhmdmdPVWU5bXNiK001ZGliOXJnQlBv?=
 =?utf-8?B?aUJOSUUzY3pWdEhuUm5CSjhlRTdJNmQ3K3phKzNScG1ZREFoSGx0MklReDlK?=
 =?utf-8?B?M1dJT1g2aEVsY0ZrcEM1bXR0VjE5S0tCSml3aldzTldRNFB4ZHN1VzR1VkpK?=
 =?utf-8?B?aStyRkcvajRTYUlXbG1GK0xsOFpQSUNmeEVadHVWbm9Valg0WWRCaGpTVGdM?=
 =?utf-8?B?SWR4c0ZaQmMwaDBVbTduQjJPU2phQ1dYRjRhNzBIVVpzRWZvMitQakp6cktH?=
 =?utf-8?B?WUNiek81K3lSSmNqVUMzMlkwU0luayt1aUtJU0MwcnZqR1VtOFFKV2dGTXhW?=
 =?utf-8?B?RzBRR0hrTjc5RmdGS0hrL3pNdVZ4dm9aMC8vVWtobmtvampxaHlDbDhVZUNH?=
 =?utf-8?B?Rlh6THY4ZlUvLzZ3SW1JdUxKMzZaRVNFdmcvOEZjSlg2Q1lJSGJwVzFhbWdQ?=
 =?utf-8?B?bnNSazk3V3YvS1hJd21TZ0IwemMxekhtVFdtNXFGQkdzdDVMaUtxUkorK1dI?=
 =?utf-8?B?Ri9ralJBNmJ5dG5GSWR2ZTRMRk9qSjJCNzg2OG9qR29PR1VrQ1UvaC9wNys3?=
 =?utf-8?B?RlhFTUNNaHpwUlE0Z1BnZEZnc0NHNFp2STBVVHB6cjFvL2ZoWitzTDZtWS81?=
 =?utf-8?B?UTY3dmxGRm9rYlpabkF3eHJqZTA5TUtZaHo1UDNPTkJkWWNNeUFkd0VFeXNx?=
 =?utf-8?B?bGs3d3hxVTlQVHpvaTlrM0l4NWNjZGVuRnNxRG1CenZ5b0NXbDR4VzloeG9q?=
 =?utf-8?B?UTZObEc4ZXZIamFvN1BZQ1Q2R21BNWhsak1oWDVoK2FNOVNXSUcydXM3RGpD?=
 =?utf-8?B?OWZtenV3VG1acXJSUDZ5K2NXWFl0WnNrWmI3RUhQOHdidHhXaE03dDNuUTBD?=
 =?utf-8?B?azlPdVdIeVRWUnpqTWlpN0huVUViZ2ZQLytFQkdjTTVCMVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6690.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU02WllkeW1HV0c3ajR5YVdqczEyaTdEM2wyV1J2TGtVREdrVVhWdy9BMUgz?=
 =?utf-8?B?SVhmUTZwcDdQcnp0alJRYnhORytUZWU5QVFVVTRUdFRLbzY0dnlEV01kRHJJ?=
 =?utf-8?B?TzNQWkZob29mNjJvRnhBdzkrZkkwOVVtZ0N0N0d2MFhIUnM2Z2kxWllLUXZ6?=
 =?utf-8?B?aHNRR2FvNjdxcWtSK25sd2NxS2luc3RUbCtmajlrRVVmOExRMHA2RHp3TURw?=
 =?utf-8?B?STJQV294aU9tZWJwckh2MmR3VXB0RzJXM2c1aXE4ZVZFNU9QQjJ5MEMzRUc4?=
 =?utf-8?B?Q3d5RmVQMmdzTkNSZWRNaUhLVVFmNlQwc204Zk05QUp4RGY4aVljRk0xY2M5?=
 =?utf-8?B?M0xzeVIxbUExQWpabjgwM3ppVlBiZTJJYkxCMy9qUHcwNFJXMU1sZUZ0RHBj?=
 =?utf-8?B?eFFjNEdLUFo2aGoyc0gzcExpR2VOU29PNEVzWXVTeG50YVVtQVNCR3owUnF2?=
 =?utf-8?B?TnRUYUk2QWw1MVUyUWxONXluTmVnRERkUitKeEowUjVLU1FvZ2xGMjlIOERy?=
 =?utf-8?B?WEFSYlo5cm5lWmdNaGxDV2twa0F1RFVnKzNpZnRkY2FpdExLaUw2a21yc2xq?=
 =?utf-8?B?K21HSHZaUlFQd0w3bkJnTjJDUEN0OG9HbnZ0SVMwRGFtTmxEN0VnUjJrTFdw?=
 =?utf-8?B?WkdkVVJYNXhGSk1mOS9xYnRibzVOUTZZN2pUUVQ5NWxlZkljNTdEVk0zQzJu?=
 =?utf-8?B?LzNFZ1dyVjJFQXdXSTdSTFI2Sk41eUJMNXNVcFhWQ1YybjlkMjhNc1F6eXNl?=
 =?utf-8?B?czlEbWxOYkk5enFJUGZ5ZUI3aUhBc2NzUWhJZE04KzUxM0ZucFArRXVJUHdN?=
 =?utf-8?B?M05DeDJQcU01S005RE1TT2Q1U0d1ZUgxOGtCWUJhQzl1VWJsTksvTnl1ZUxT?=
 =?utf-8?B?N3lmVFFIMTJGVHFYMDgxcXdiM0ZJNW9FaDVxZEo4dkVJVXRkZVJENFA3VWg0?=
 =?utf-8?B?cGM4TmlDd0pPREprSlVXOHdwcE1UNXR3UU1lKzRVWHJROEZXT0RnUjNZZG1X?=
 =?utf-8?B?NVkxQ3V1bExZWC9nQ1pnc29YU2dtYlVPSWw4Zy9JdlZzbGNNeEpyODhuNWts?=
 =?utf-8?B?RjVsNGZkOUZNdTB6cHczbXN2L3dOOXkrN1RNWnllT2JDTnE1ZDNjOW1xQ3Zi?=
 =?utf-8?B?R2tKNEFFWCs0dS9WSjNnZTBobWRZSitZcUZtLzEraFpYZG0zK3E4RnI3WU8x?=
 =?utf-8?B?RWF0ZWZsc1pZdk5qUHZIM2EyV0Vna2VFM2Q1TTV2L0dTWGg1ZTRxU2dJdmM3?=
 =?utf-8?B?RTEvTi9vZVVRdHNrcStwaHcvZjZUNlgwTUlaME8vdGNHKzBhem5VdGl3SHJB?=
 =?utf-8?B?c2txTGtPTU5DV1RZaTNLZVYzV2hnaXhrV2VOT1JKMHViMXZoR3B5bXl0Q0ZL?=
 =?utf-8?B?eFpsTklrYUJUdmhRUkJBSjBhanpIeXhJVjhVYk5aWSswamMxOThJY3B5VXhF?=
 =?utf-8?B?NmpacEcwUHZ5UitCWTc1UEVKdXBDWkZhSmhoZ05Db2paOG96RnlTWmFsRVZW?=
 =?utf-8?B?YzR6NjNKejhSTFhFaFFYRGVpQVgzR1pEZ1d2RWNvMEZPaFdPdDBCakFQeWR1?=
 =?utf-8?B?YURab1RkSll2QjhTbE9LVGVETjZzMGJkTWRkdnZpeEJmSmowOC9wNWl4cFlZ?=
 =?utf-8?B?N21Xakg4aEdZNnJRVzJYTHFSWE9vOGdhMkVZa3lEYy9ydUxBOEZ2WWJSdXR3?=
 =?utf-8?B?dXhlTmZpblFoZ3h2dDB5NHYya2t1NjdzRmcybTJEbmQzNURxbmxWRTN3Vk5Y?=
 =?utf-8?B?YmhGM3lmc2hNdDU0N1ozSGZDU0JaeFBYYmgrczVRVVd4OGpkUzhpT0I2aEFR?=
 =?utf-8?B?NE5FSmUwSGdkMzF2SWt2bkhrU3FnQVYyVm5wMGplM0p2eDdocTA3dXg5RExy?=
 =?utf-8?B?b2dxUEY4VU9lT3ptTm53eFN6WXVHdXd5dUdZdWdPK0crYXVENVRTUGpSUGwy?=
 =?utf-8?B?NXc4YjNxWHVid002aXpvWFRKMDlDc2g3MmZOYUpISUFwTFJLRURhWXBMR3Q1?=
 =?utf-8?B?WUMwMUQ1Vm5kMERsSCtWQnZMUWI3eDZwS0c0V0xISlR6SmpVWkovaUJkR0l1?=
 =?utf-8?B?VFVWbWxiSnlTaGs3K0o5eVI3VllwTlpESWk3cVhDcVJYanBrNWZQUWo4ZzIz?=
 =?utf-8?B?akRVaC8zSUZ6bjNkL2J3L3NvNGRobEVIaWFpV2t6V09LcWxUd1BnNHNpT0dC?=
 =?utf-8?B?RlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB6D8DD36D644946B8466F2168582EFC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6690.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f82cc5e5-ae48-4ccd-4ec3-08dd15c32ed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 06:57:00.5076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cd0LlX9wHKmpPx66ml/fWXtpkxnF71cQa/XppGbfNeEkTB8JtrqYnxko7IjBe8rEf+hz3Ff4p3fl9SiO8iBbqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7996
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.818000-8.000000
X-TMASE-MatchedRID: F3kdXSFZYkfUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXYO+yaWLFz41pF4PKxG2U/chKz3vhHKFOLoMfp2vHck9UZj1j4BNp7XCcCsPLicEbU+q8
	dY5zmcPoXIgNxs0hTvj2+qVno7r3yoXYTq/8UnCHd+fuf9kcapkyQ5fRSh265kzE2kM4b6Hrr4w
	XBEliVISV9wi76zscCATmOwPZCJ0E/IWyiTc50IPSG/+sPtZVkX6IRwqkp2m7qLnOUXH9QdHI6n
	o+L1QSBzk91rvv9A+5rTasPN+jEkw8LKInWUps8dAg4yd14qAQZKp0SZ4P+da6v3T2Rq6dCTBVQ
	QAgPmRPe/MFReb/LLDzQU58iBxTMj64zP5bTFPlIcJTn2HkqsRLXa2P1m93zSYPLE090cxf2xQs
	QEOrKwrp5xPnJAVHglmFfhS7G6DRC/bXMk2XQLIMbH85DUZXyseWplitmp0j6C0ePs7A07QKmAR
	N5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.818000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4F44555DAA5A3E17748B30832576BDBA3070025BA006322377ED34F5574FC43D2000:8
X-MTK: N

T24gVGh1LCAyMDI0LTEyLTA1IGF0IDEzOjUxICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IA0KPiBJbCAwNC8xMi8yNCAxMzoxNywgVHJldm9yIFd1ICjlkLPm
lofoia8pIGhhIHNjcml0dG86DQo+ID4gT24gVHVlLCAyMDI0LTEyLTAzIGF0IDE3OjA3IC0wMzAw
LCBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyB3cm90ZToNCj4gPiANCj4gPiA+IA0KPiA+ID4gQ3Vy
cmVudGx5LCBib290aW5nIHRoZSBHZW5pbyA3MDAgRVZLIGJvYXJkIHdpdGggdGhlIE1UODE4OCBz
b3VuZA0KPiA+ID4gcGxhdGZvcm0gZHJpdmVyIGNvbmZpZ3VyZWQgYXMgYSBtb2R1bGUgKENPTkZJ
R19TTkRfU09DX01UODE4OD1tKQ0KPiA+ID4gcmVzdWx0cw0KPiA+ID4gaW4gYSBzeXN0ZW0gaGFu
ZyByaWdodCB3aGVuIHRoZSBIVyByZWdpc3RlcnMgZm9yIHRoZSBhdWRpbw0KPiA+ID4gY29udHJv
bGxlcg0KPiA+ID4gYXJlIHJlYWQ6DQo+ID4gPiANCj4gPiA+ICAgIG10ODE4OC1hdWRpbyAxMGIx
MDAwMC5hdWRpby1jb250cm9sbGVyOiBObyBjYWNoZSBkZWZhdWx0cywNCj4gPiA+IHJlYWRpbmcN
Cj4gPiA+IGJhY2sgZnJvbSBIVw0KPiA+ID4gDQo+ID4gPiBUaGUgaGFuZyBkb2Vzbid0IG9jY3Vy
IHdpdGggdGhlIGRyaXZlciBjb25maWd1cmVkIGFzIGJ1aWx0aW4gYXMNCj4gPiA+IHRoZW4NCj4g
PiA+IHRoZQ0KPiA+ID4gdW51c2VkIGNsb2NrcyBhcmUgc3RpbGwgZW5hYmxlZC4NCj4gPiA+IA0K
PiA+ID4gRW5hYmxlIHRoZSBhcGxsMSBjbG9jayBkdXJpbmcgcmVnaXN0ZXIgcmVhZC93cml0ZSB0
byBwcmV2ZW50IHRoZQ0KPiA+ID4gaGFuZy4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTog
TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gPG5mcmFwcmFkb0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgIHNvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LWFmZS1jbGsuYyB8
IDQgKysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gPiAN
Cj4gPiA+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4OC1hZmUt
Y2xrLmMNCj4gPiA+IGIvc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtYWZlLWNsay5j
DQo+ID4gPiBpbmRleA0KPiA+ID4gZTY5YzFiYjJjYjIzOTU5NmRlZTUwYjE2NmMyMDE5MmQ1NDA4
YmUxMC4uZmI4Y2YyODZkZjNmMDJhYzA3NjUyOGINCj4gPiA+IDg5OGYNCj4gPiA+IGQwZDdhNzA4
ZWMxZWEgMTAwNjQ0DQo+ID4gPiAtLS0gYS9zb3VuZC9zb2MvbWVkaWF0ZWsvbXQ4MTg4L210ODE4
OC1hZmUtY2xrLmMNCj4gPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4
LWFmZS1jbGsuYw0KPiA+ID4gQEAgLTU4Nyw2ICs1ODcsOCBAQCBpbnQgbXQ4MTg4X2FmZV9lbmFi
bGVfcmVnX3J3X2NsayhzdHJ1Y3QNCj4gPiA+IG10a19iYXNlX2FmZSAqYWZlKQ0KPiA+ID4gICAg
ICAgICAgbXQ4MTg4X2FmZV9lbmFibGVfY2xrKGFmZSwgYWZlX3ByaXYtDQo+ID4gPiA+IGNsa1tN
VDgxODhfQ0xLX0FVRF9BMVNZU19IUF0pOw0KPiA+ID4gDQo+ID4gPiAgICAgICAgICBtdDgxODhf
YWZlX2VuYWJsZV9jbGsoYWZlLCBhZmVfcHJpdi0NCj4gPiA+ID4gY2xrW01UODE4OF9DTEtfQVVE
X0ExU1lTXSk7DQo+ID4gPiANCj4gPiA+ICsgICAgICAgbXQ4MTg4X2FmZV9lbmFibGVfY2xrKGFm
ZSwgYWZlX3ByaXYtDQo+ID4gPiA+IGNsa1tNVDgxODhfQ0xLX0FQTUlYRURfQVBMTDFdKTsNCj4g
PiA+IA0KPiA+ID4gKw0KPiA+ID4gICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPiAgIH0NCj4gPiAN
Cj4gPiBIaSBOaWNvbGFzLA0KPiA+IA0KPiA+IElmIEkgdW5kZXJzdGFuZCBjb3JyZWN0bHksIEFQ
TEwxIHNob3VsZCBiZSB0aGUgcGFyZW50IGNsb2NrIG9mDQo+ID4gQVVEX0ExU1lTX0hQIGFuZCBB
VURfQTFTWVMsIHNvIGl0IHNob3VsZCBiZSBlbmFibGVkIGF1dG9tYXRpY2FsbHkNCj4gPiBieQ0K
PiA+IENDRi4NCj4gPiANCj4gPiBJJ20gbm90IHN1cmUgd2h5IHlvdSByZXNvbHZlZCB0aGUgaGFu
ZyBpc3N1ZSBhZnRlciBlbmFibGluZyBBUExMMS4NCj4gPiBDb3VsZCB5b3Ugc2hhcmUgbW9yZSBk
ZXRhaWxzIGFib3V0IHRoZSBzb2x1dGlvbj8NCj4gPiANCj4gDQo+IEhtbS4gTm93IEkgc2VlIHdo
YXQncyBoYXBwZW5pbmcgaGVyZS4uLg0KPiANCj4gTmljb2xhcywgVHJldm9yLA0KPiANCj4gUG9z
c2libGUgcGFyZW50cyBmb3IgdG9wX2Exc3lzX2hwIGFyZToNCj4gICAtIGNsazI2bQ0KPiAgIC0g
YXBsbDFfZDQNCj4gDQo+IC4uLndoYXQncyBoYXBwZW5pbmcgaGVyZSBtb3N0IHByb2JhYmx5IGlz
IHRoYXQgYWZ0ZXIgdGhlIGNsb2NrIGdldHMNCj4gZGlzYWJsZWQgYXMNCj4gdW51c2VkLCBpdCBn
ZXRzIHBhcmVudGVkIHRvIGNsazI2bSBieSBkZWZhdWx0IGFzIHRoYXQgaXMgcGFyZW50IGluZGV4
DQo+IDAuLi4gYW5kDQo+IHNvbWV0aGluZyBlbHNlIGluIEFGRSBuZWVkcyBBUExMMSB0byBmZWVk
IGEgY2xvY2sgdG8gLi4gc29tZXRoaW5nIC4uDQo+IHRvIGFsbG93DQo+IHJlZ2lzdGVyIGFjY2Vz
cy4NCj4gDQo+IFRyZXZvciwgZG8geW91IGtub3cgd2h5IGlzIHRoaXMgSVAgdW5hY2Nlc3NpYmxl
IHdoZW4gQTFTWVMgaXMNCj4gcGFyZW50ZWQgdG8gY2xrMjZtPw0KDQpIaSBBbmdlbG8sDQoNCkFz
IGZhciBhcyBJIGtub3csIGl0IHNob3VsZCB3b3JrIGV2ZW4gdGhvdWdoIHRoZSBjbG9jayBpcyBw
YXJlbnRlZCB0bw0KY2xrMjZtLg0KDQpVbmZvcnR1bmF0ZWx5LCBJIGhhdmUgbm8gaWRlYSBhYm91
dCB3aHkgQVBMTDEgZW5hYmxpbmcgY2FuIHJlc29sdmUgdGhlDQpoYW5nIGlzc3VlLiBJJ20gYWxz
byBjdXJpb3VzIGFib3V0IGhvdyBOaWNvbGFzIGZvdW5kIHRoZSBzb2x1dGlvbiB0bw0KcmVzb2x2
ZSB0aGUgcHJvYmxlbS4NCg0KRnJvbSB0aGUgZGVzY3JpcHRpb24sIGl0IHNlZW1zIHRoYXQgdGhl
IHByb2JsZW0gaXMgcmVsYXRlZCB0byByZWdpc3Rlcg0Kci93IGhhbmcuIElmIEkgcmVtZW1iZXJl
ZCBjb3JyZWN0bHksIHdoZW4gdGhlIG10Y21vcyBvZiBBRFNQX0lORlJBIGlzDQpPTiwgcmVnaXN0
ZXIgci93IHdvbid0IGNhdXNlIHRoZSBjcHUgdG8gaGFuZy4gSG93ZXZlciwgQURTUF9JTkZSQSBo
YXMNCmJlZW4gY29uZmlndXJlZCBhcyBBTFdBWVNfT04gaW4gdGhlIGRyaXZlci4gSSdtIG5vdCBz
dXJlIGlmIGl0IGRvZXNuJ3QNCndvcmsgY29ycmVjdGx5IHdoZW4gdGhlIGRyaXZlciBpcyBjb25m
aWd1cmVkIGFzIGEgbW9kdWxlLiBNYXliZSBOaWNvbGFzDQpjYW4gYWxzbyBjaGVjayB0aGlzLg0K
DQpUaGFua3MsDQpUcmV2b3INCg0KPiANCj4gVGhhdCBtaWdodCBnaXZlIE5pY29sYXMgYSBkZWZp
bml0aXZlIGhpbnQgYWJvdXQgaG93IHRvIHJlc29sdmUgdGhpcw0KPiBpc3N1ZS4NCj4gDQo+IENo
ZWVycywNCj4gQW5nZWxvDQo+IA0KPiA+IFRoYW5rcywNCj4gPiBUcmV2b3INCj4gPiANCj4gPiA+
IA0KPiA+ID4gQEAgLTU5NCw2ICs1OTYsOCBAQCBpbnQgbXQ4MTg4X2FmZV9kaXNhYmxlX3JlZ19y
d19jbGsoc3RydWN0DQo+ID4gPiBtdGtfYmFzZV9hZmUgKmFmZSkNCj4gPiA+ICAgew0KPiA+ID4g
ICAgICAgICAgc3RydWN0IG10ODE4OF9hZmVfcHJpdmF0ZSAqYWZlX3ByaXYgPSBhZmUtDQo+ID4g
PiA+cGxhdGZvcm1fcHJpdjsNCj4gPiA+IA0KPiA+ID4gKyAgICAgICBtdDgxODhfYWZlX2Rpc2Fi
bGVfY2xrKGFmZSwgYWZlX3ByaXYtDQo+ID4gPiA+IGNsa1tNVDgxODhfQ0xLX0FQTUlYRURfQVBM
TDFdKTsNCj4gPiA+IA0KPiA+ID4gKw0KPiA+ID4gICAgICAgICAgbXQ4MTg4X2FmZV9kaXNhYmxl
X2NsayhhZmUsIGFmZV9wcml2LQ0KPiA+ID4gPiBjbGtbTVQ4MTg4X0NMS19BVURfQTFTWVNdKTsN
Cj4gPiA+IA0KPiA+ID4gICAgICAgICAgbXQ4MTg4X2FmZV9kaXNhYmxlX2NsayhhZmUsIGFmZV9w
cml2LQ0KPiA+ID4gPiBjbGtbTVQ4MTg4X0NMS19BVURfQTFTWVNfSFBdKTsNCj4gPiA+IA0KPiA+
ID4gICAgICAgICAgbXQ4MTg4X2FmZV9kaXNhYmxlX2NsayhhZmUsIGFmZV9wcml2LQ0KPiA+ID4g
PiBjbGtbTVQ4MTg4X0NMS19BVURfQUZFXSk7DQo+ID4gPiANCj4gPiA+IC0tLQ0KPiA+ID4gYmFz
ZS1jb21taXQ6IGI4NTJlMWU3YTAzODllZDYxNjhlZjFkMzhlYjBiYWQ3MWE2YjExZTgNCj4gPiA+
IGNoYW5nZS1pZDogMjAyNDEyMDMtbXQ4MTg4LWFmZS1maXgtaGFuZy1kaXNhYmxlZC1hcGxsMS1j
bGstDQo+ID4gPiBiM2MxMTc4MmNiYWYNCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+
ID4gLS0NCj4gPiA+IE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIDxuZnJhcHJhZG9AY29sbGFib3Jh
LmNvbT4NCj4gPiA+IA0KPiA+ID4gDQo+IA0KPiANCg==

