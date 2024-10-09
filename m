Return-Path: <linux-kernel+bounces-356151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB34995D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435BF1C20D8F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 01:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22962208AD;
	Wed,  9 Oct 2024 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ObYczITl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QeKPXEmG"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0B1D545
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437683; cv=fail; b=iZ0pfjcx4ZcczmKvx9e3LtNk55ukf58pG/IZcpb2gS9V/WF2oUli9WWYfSaS7jnJ/FQoc1XYvroOfidwwQH2kYcpRFMIfVSunKo+d5VmDmrZ1MByMMAAOkeHXV0Mz7XenRhr7BA8qi2Tg5lbUZk+OKkm9n0YxFchcEyDLgwnVZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437683; c=relaxed/simple;
	bh=1/KOU6j2dhsIrdfjAeOvy/RidFDcpwYdkwXT+s3yvDc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=C4ejnJEiGDLM4FqBFy0tKLJXWvxlMm99T5n57zGYTBjZiJh8CRjcuKKgJH5q85scEyLVCOqlqd9CAWjRsd1NPCqScGOXY3/enKszy0tJOOA+d7/HPB5tnA7XmpBmrKcDifdIBBss188iYssJSjMWqjnOc0LH/eiB5/vo9GA9HeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ObYczITl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=QeKPXEmG; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a40d7b8285de11ef8b96093e013ec31c-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1/KOU6j2dhsIrdfjAeOvy/RidFDcpwYdkwXT+s3yvDc=;
	b=ObYczITlmjh0QUPMM+dJd6ohW8jM71JNNUBznjwIDyCCI5z32ius0NmryIrpo+27gbIuRTIDdtZvg7ycu4f9fVZanh8YRZdLXH8VYmBQnqMxDiS9ICscSQAlWQDEb9ZOHOlUBhoUCMBR0hrus7k8yXpXzHgZJAodu2Qrp6PHAD4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:60917310-66c9-47b6-9e0e-4ffadff53d66,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:7043f740-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a40d7b8285de11ef8b96093e013ec31c-20241009
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 877427285; Wed, 09 Oct 2024 09:34:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 09:34:34 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 09:34:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkdpLg5Gxo+HlNtufp0aBh3teL8JUao5Q4HyakvW5UoLT/1CutQh1s1mGAEmoIfe+YAPReNFkkSf/m1TWpBsesh/rI0DscbL2xgqm7R3wcKTOnKa86n5/GWZX6i7+Ar5bULlrJto7BQO34uPKtFe3+Lj3/mvcnv1entxmaOg6BD6pjLhEs6onbJypUxlc7+29aChkK2AZovOIuzaIXaPnr+5Hd6pniO6ZEgRP1Wvolauwbe9WOaEpcywFpgBs2ziAy7WYzSiru2e1kXG7BnQ/nhup+QWq/cqyBXijnBHiEBdRqyzHTNTemC+y3xDjpDr0Y/owzpd0sXXQVdHU/nYkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/KOU6j2dhsIrdfjAeOvy/RidFDcpwYdkwXT+s3yvDc=;
 b=EjxHlyNcOTNwj4uCijvUGrYGxUJpG9n9sZ/c/ip4TQxhZyvOqTxBc2egeIanGBJz/oWWyYNxVd1MW1fJKrbNv5bCVAqBid8TPqLtnX45fL+SuonzLp60wUIEWpjcP3d8n/MEW2AMaxppmXHCYz4MK6V3g4P5XHXrpqvuC0AYepBHq3vcvqIOfF7sTzoL7BVC8sAK5LpfpZQf9jh4jiwNW2JRvWioSGG9bDjtWXd2zUREbbW2pG0faWHIlf3ebxKWRBtpcl8w7Q9zBDhFdbRXTeyQY9Y2E6aT8+LlxtmOQK7Re3YL4UmWOra0xbfy8Jq6TUVMuKQ3Y+1y09NIg0gu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/KOU6j2dhsIrdfjAeOvy/RidFDcpwYdkwXT+s3yvDc=;
 b=QeKPXEmGlz7Fev86iJ+uVjAtBFbR6CV7TO46mqgwhxDB3Zp9kudKNEQci8cuF2GBVMaVatLVCZvyLKTNfz9zNvMwKQOUT+eeV7koGaetcqT3v+fpilh1pV2X/XM6316pqripCm9AYeauoEONgkZlawjFMKvbrjVEsnykdArwCAs=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB7704.apcprd03.prod.outlook.com (2603:1096:101:12b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 01:34:31 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 01:34:31 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "Markus.Elfring@web.de"
	<Markus.Elfring@web.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "me@adamthiede.com"
	<me@adamthiede.com>, "yassine.oudjana@gmail.com" <yassine.oudjana@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
Subject: Re: [PATCH v10 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
Thread-Topic: [PATCH v10 1/5] drm/mediatek: ovl: Fix XRGB format breakage for
 blend_modes unsupported SoCs
Thread-Index: AQHbGU3tYeBUpEn3jkWobKemisPSHLJ8fEAAgAEn5YA=
Date: Wed, 9 Oct 2024 01:34:31 +0000
Message-ID: <5fbb9241fd127306b6d8761348fd4efd6269beb8.camel@mediatek.com>
References: <20241008064716.14670-2-jason-jh.lin@mediatek.com>
	 <a95532b6-381b-4b06-8f4e-9b3a6c727a60@web.de>
In-Reply-To: <a95532b6-381b-4b06-8f4e-9b3a6c727a60@web.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB7704:EE_
x-ms-office365-filtering-correlation-id: 94090909-154e-41fa-c2ec-08dce8028600
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ajRjUnhwR0ZlMXV1TWJ2ZW9uS0xDa2hkeFl0dnZOb0IwQUlSYm84MjZzSGhK?=
 =?utf-8?B?RlhXTW91VHhkdmQ3bHZrTTFGSU1yQjgya01Wdk8velFJM0ZsYksreFFXdld3?=
 =?utf-8?B?YzFaZTQ4bmhsOHFIdVEzZm5RTytUazlRR1Zxc1BLTEQ4OWtlelJUOEE1VUhx?=
 =?utf-8?B?Ym84bVNsNkpMK1RwUXE4WVVoaEdJd1RaMDlTa2kwVVZEQU5XcEM5RXc3cE81?=
 =?utf-8?B?SC9HN0dJci9YbU5lUFFHUy9jaVhmNER3K2xqQ0k3YklrQldhTW5WUUlDSlgv?=
 =?utf-8?B?S0dNUUVuejlWNkxIQTMvRUNBTi9RaTFvYW1IVFEwVGgwMTZBMS9Wb3QvM2tZ?=
 =?utf-8?B?VXVPY0x0VHkyWHNxSk03OGs2T3JCbUxQUkh2ZWpEdlQyQzJvYVdRaTJBODVS?=
 =?utf-8?B?NjNEbWVXQ1NHVHFzbmc2Tk43SXFhNjFnajlScTJGaUwxZy84cjFQeFJQd2kz?=
 =?utf-8?B?T3NGdzNBa09ON0UwUUYrWkQzTHB2UkhhSWdxdWVrQllyK2lvQ1EvLzN5MXh4?=
 =?utf-8?B?b24rbnp3Z0pRQ1lrRGFLZmR2Y3Myd2FEa2x6c3daK1Y1dElrTFE0cnNFOHRT?=
 =?utf-8?B?cE1qSlJEK0xHdzBYZ1RLTWVIQW5hdGc0L3cvOUZ3YlJXRVhYQklrbVVsVmJU?=
 =?utf-8?B?UWdCWThSWVhZQkxobURhVjhjTGtBcmpMYkVBTExJc2J0cVVsKzNUdFlWZmd3?=
 =?utf-8?B?d3pLQ2tjelhPelQzS0NOL1VXTnU4dG83Q21mU1JQeU45L09teDFLR01QQmdR?=
 =?utf-8?B?TitHQUZyNGpkTUViNlFlV2F4MWQxZkNOMWZyWVRJSjc0K09Fdk56Wk5HcmQz?=
 =?utf-8?B?YnNDMGREUmRaL1FQODZQVXZPU0R5emtjaUZFWXdETzVqd01BdWV5Kzg3Y1lM?=
 =?utf-8?B?UUc2STZMTi9nQzZUQ1pYTEkwUTErTG9namRodUMwRlN1RlFHY3g2aGxIaUN6?=
 =?utf-8?B?bDZ6QU1LV3E5WDZwQkZoOUhicFFwVGZTeWR5eDBUd21mbnBiT0NRSDI4ZmFG?=
 =?utf-8?B?bUc4VElNbkFWSE9QRXoydFd2VkVoVWhjNjZoendJWHBzUm05SnJqMVRnS2V6?=
 =?utf-8?B?MVVPbHVLd3BselRJbll6NHhQeTdnNGMzeDN3ZFdmbjFXTjlBV3BTSjVReWhl?=
 =?utf-8?B?VDl6Ui9URkVLemw1UXJGYUpnME9EZTZWV0ozV0NSd3RpeFh2N0VuQmYrdWsz?=
 =?utf-8?B?N0V5bGJJY3NycjNFV1UwK0YrRWtveldqQ1FJV1JJb3pRQjcvQUtHT1lzWEwx?=
 =?utf-8?B?ZEVyRDZRMStSb1VPbSt3Ym5QNmZ1Z0dpR2hCYXFQQ1p6VkVZeEFVVGtCd01q?=
 =?utf-8?B?MEJEcmNNTCt5Ly9nbVY0c3Jkc3hQOHlCUUtIMDVna29NRHdyaUxiSGdIUk5C?=
 =?utf-8?B?Vy9PN1JOYzRZMlhCRVpTTkJlWlY3YU9PaksxdlhNbHZ0WDdqbk1rWWxQWklX?=
 =?utf-8?B?VDQ4Nng3UCtUbDBHZjFGTjNvd3UwcWJONkp3Nm5MMnQvU3dtb3M2dC9EeVU1?=
 =?utf-8?B?RVNoVmU0TGxPMTJzOUpnTlVkRG1uWDNOakVVcEJyYy9XdkNmbVQ4UTk1Tkdn?=
 =?utf-8?B?cDFNUDZXaDM2aStPV0hMZXdyZ1JBanBFMFZ5TmdMRUx3Q1A4L0c3NTlOQWM4?=
 =?utf-8?B?YzBuZ1dNZ0d5Rk9vbVVwbWVJaUEwbjJHM2dGOUYwOEUrcmhCeHpnNncvMnIx?=
 =?utf-8?B?WkZxakdjMzNtTDVMKzYwRXRaanFsY3o1N0JReFY2cFBUR3NRL1l3WUVOTGhx?=
 =?utf-8?B?NHZYS1dhOUhJUlgzK3dheEIySU0wQi9DL2JKRHZqbjFmdWNkbVhwdnh0akhl?=
 =?utf-8?B?QU5NVlE5OUdwUkxMK29uUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTZWalA1cW9jaHduNGo1S3g0NE0za1R6dTdVbW1lRjNSRmkxRnlhaTJLOW55?=
 =?utf-8?B?d3oyTTM3dXl0M21BQi94TVNnRUJNRFB6a2g3Y3BvdUt5anVZVHJlYkFGc0px?=
 =?utf-8?B?Skg1cUhPUGtOZTBRNFdISkd1enNoZ2QyZE03alFJSTBmbTZIK1phUEpHenB3?=
 =?utf-8?B?K202S2tBNXphTGtqbmpjYUZRcEF4YnRZQkxWQktZTlVySkhma3Q4QWxwVXhL?=
 =?utf-8?B?UWJKZzFVZ2V2VSt5QURMVklIVUJ1amw3bWFYVW84bmFwWEgvTTdza3E0L1lH?=
 =?utf-8?B?eFRxTWY1TmhPOGRpcVlLNk1qMWY5SnJxaVZvaFFxVE01bjRKc3paQ0hmYjlP?=
 =?utf-8?B?dUVvM0ZDZGJDbHlTU3hncGwxK21kV0JiYjNKZHA5M002OGphL1hxUDFUQjJI?=
 =?utf-8?B?SGlqcnFycktlQ1pjVU12bGlPajVvNVBkS25VL3BIc1lDL2FMcE83ZkNPdFVI?=
 =?utf-8?B?ZkdKMWlaTDZCOE0wU0lta3dEeXVTbGs2QjNiNFlHY1hDdTVUdG5CNEdiM1Vv?=
 =?utf-8?B?Wkw0andlbWFBL2J4Y2FqTTJUUktZaXlIQ0dNd3RkRVRpTTc2bDFrQmhWMytn?=
 =?utf-8?B?ckZYeWNqaFYyU1JEVEppSkpjZDI1WHpRTlRSOHJOZHBBdFM4R3BnQ2JUamg4?=
 =?utf-8?B?cWZnaWI1UUdjSDBTN1F1djZSTFFqTzJXSmlaOEN6V1Y4MWVVOE5Ea1JpRE1x?=
 =?utf-8?B?RXhKZm1xNFQ3SlMya1pBUlMzaDNyRzJobXB5aFBBeVRpbWo5eEt0VmNpZlVV?=
 =?utf-8?B?MmFTZy9TN21ZT2xwTUhyc3h2Q1VvTlNaaURtOFloVTFlcXlLNFJiemFmdHNL?=
 =?utf-8?B?ZjN5OFRjeEV0TXUrdkM5enVyNEZEVkZ4TDAxQlNnRnZCLzFyUzNuR0crU2dO?=
 =?utf-8?B?Wm43UG1FRTlNK0JCMVRwOG95TG83WnZIQTN6NlE3WndXK0dqVFNNZTlhMHI1?=
 =?utf-8?B?cW9QMlFZVnpwZjNMWkRjKzI2VXdqRXMzalBBcFJ1YWF0SjhWLzVqanJnSm02?=
 =?utf-8?B?OTRyMXZOSVdYWXVBWEFKRlVZWXN4RXJKOXBjRjhUTHFzWXJIK1Z6a205MElt?=
 =?utf-8?B?cUdtUDlLbCtQQTVNZ04xa210bHZ3ZkczZ1RnR1A0amJyZ3IzUUJBVkIyakw4?=
 =?utf-8?B?Z1Y3QXRscXJKbUFRQmZ5dzBsZ2VadUo3R284bTRpNjI0aVhhbVJ0WkhXYStx?=
 =?utf-8?B?U2xaVUtnWUxZUHo2TkkxVy95Wm1DZHNBb2dMNUg3WjBTVW5yeFhTN1RlWWJy?=
 =?utf-8?B?SEJwVzRCYkxSeHNrYkZVSDBlRVc4cGZiamx6eFdvTU9HQzZzSmJmQm9mdHlR?=
 =?utf-8?B?cjF4cGhPdlhkMHBaWHN2ZURaVFMyOXpqcER3c0ozSUNPRnJHbWFQT2tKMFh0?=
 =?utf-8?B?YktvS2RCYnk2ZU1OM2lESzhEVzhkWFlDZFp0QzFiS1AyMjVETXBlSlAxWm5C?=
 =?utf-8?B?ZVV3Q2lOd0ZHOWRkUGZtWHNka1U2a2pQT1RYb1AwV3F0ME9MQnpwVGJuZjAw?=
 =?utf-8?B?aDFsVmJEOS9XbkVQSGU1TzhZUkZOTGdIdVpVWE92amZCdFc3WlByK2JVaGZ1?=
 =?utf-8?B?Q2JzTEFIZTRkb0wzcWpJaENBbEFOa28wSktwK0NXdmNpUzZXYTVQMXhxcS96?=
 =?utf-8?B?NlI3MFhsRGxLMG9ValJJN3dwRVF1eitZV1UzcGlnRDRUUlViajRIV3hwZG5Y?=
 =?utf-8?B?S3BpRDNxeDlCNzFBZVFoNXlIbUlVbWtwcWFiVnVyWjBSWXp0U0p6MnpNcmhm?=
 =?utf-8?B?RW1vQUZZVnN0QTM3V1lub3BSMzJNM1hxaDFEd3RRNFF6Y01jRFVUU1R3emZC?=
 =?utf-8?B?T1U2bXI4cEZURnFocjJsZFhrb3pSK0RwNTcxbHpTZWV1NitoblRRYUFuU1p0?=
 =?utf-8?B?NW1ObnJ2ajNhbXdvVG5weE8xcEpGWmZjYWg0dnpFK2N3NEVGKzlTemsrelpm?=
 =?utf-8?B?SGxyQUdZdUdnU0Z1VU82bHU4cnBGaGp5amNqNVJnd055cExGaGI5QVNiaCtE?=
 =?utf-8?B?OWJFemdWYVVyc0czU1hMd3Q1QldXaVVrM3E5N21nQ1VvNUFmelQ5U1l2RVBu?=
 =?utf-8?B?ZllPUndCdzdqdG9pTDMvdUNIMGE0R2VocUlhNytSTVM4SUQrRm8vZVVJTGsx?=
 =?utf-8?B?ZUNCWWc1cjZNcDBzTUlZQXNKNnl3bnlkZWhaaktHbVJsME1rdEo5V1hJbU9H?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <493A06FC198D8145A8B9B73FCA276640@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94090909-154e-41fa-c2ec-08dce8028600
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 01:34:31.5123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4UScP7wesEfQNg09yletWBwrQcrIDw7fVgVGaZcWjbhc0fOqL0bGHmKpziTKHZxnLb0f8CrIOZGmUXDrkhkn58H2TXbXDxyfa53SlTsKbcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7704
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.471200-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rbaVyalxbpdBvVxZLseBRp3y1ZMjVHx6my+WUX/nOlPeO53bHtM9W3y8N
	CoR1t/U1ElOUf2Qb7W9iJAt+0ecgvQI03HHVogFW1PiMh4ZF39ShRWQHuJ8meRi9INZ1ZpGENBQ
	8xS9RhKOLzNWBegCW2PZex/kxUIHUTEC0P9PvYRt0H8LFZNFG7JQhrLH5KSJ0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.471200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DCAEDC07F13201A4CBA350F33EF95D2790D6B54CC19672EC4B9F8063F024D5012000:8

T24gVHVlLCAyMDI0LTEwLTA4IGF0IDA5OjU1ICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+ICDigKYNCj4gPiBOb3RlIHRoYXQgaWdub3JlIHBpeGVsIGFscGhhIGJp
dCBpcyBub3Qgc3VwcG9ydGVkIGlmIHRoZSBTb0MgaXMgbm90DQo+ID4gc3VwcG9ydGVkIHRoZSBi
bGVuZF9tb2Rlcy4NCj4gDQo+ICAgc3VwcG9ydGluZyB0aGUgYmxlbmRpbmcgbW9kZXM/DQo+IA0K
PiANCj4gPiBTbyBpdCB3aWxsIGJyZWFrIHRoZSBvcmlnaW5hbCBzZXR0aW5nIG9mIFhSR0I4ODg4
IGZvcmFtdCBmb3IgdGhlDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgZm9ybWF0Pw0KDQpUaGFua3MhIEknbGwgZml4IHRoaXMgdHlwbyBh
dCB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNv
bT4NCj4gDQo+IFdvdWxkIGEgcGVyc29uYWwgbmFtZSB3aXRob3V0IGEgZG90IGJlIHByZWZlcnJl
ZA0KPiBhY2NvcmRpbmcgdG8gdGhlIERldmVsb3BlcidzIENlcnRpZmljYXRlIG9mIE9yaWdpbj8N
Cj4gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRj
aGVzLnJzdD9oPXY2LjEyLXJjMiNuMzk2DQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg==

