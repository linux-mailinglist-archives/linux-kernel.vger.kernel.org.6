Return-Path: <linux-kernel+bounces-517033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B840A37B26
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C9D16B066
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFED155322;
	Mon, 17 Feb 2025 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m+e4fxxc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="diw3gb3i"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAD372
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772287; cv=fail; b=I3mN8aUvALY/HJyi2KOtaF4lk+0b5+I/+XssQ5TzpvQ60PEkOG5E2H1bvAYI1sB2U92vv4thZZJG+MyWBZTsMO3SzzuOpK1Etix+DymiENbmJ4iMNdtlmzEYztQitLgIIBVHO/tJ7HJqpXLpH/huC6Izk0iBbmcJzSfzYZ84U9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772287; c=relaxed/simple;
	bh=Ku5tnvh5Ff/RtwIYb0kdF/MiDxRp9LqNoKU9mdJfTTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y+WBeUJ9+xM0y1H8vViYg3hJbUkzbDJvGm8kMhqE9L8ULV+sNKA8zHtgA6m5hTnFG//eZNZ4bPcG8+3OWWTnGqFjDkdM9SPrR3cSIs7usj4R/4bhzyzSDDqAGsyzvc/DXb6TGxjJgj4d7YTCUosJt12pE9kggOHXF3vDK4gg1tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m+e4fxxc; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=diw3gb3i; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0ee9fab6ecf511efaae1fd9735fae912-20250217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ku5tnvh5Ff/RtwIYb0kdF/MiDxRp9LqNoKU9mdJfTTU=;
	b=m+e4fxxc71AETXzGOkOraHPevlnj+Hr1a0HBC3+CttGpMrm31StFCAAtLPjvhjpnU1M44E9yy+vcs0WoagBIf1VTZvSpktwzqF0WxH4MHrkm7JfxxnTU8fzzM1MIJaxJuriFI8J3sp1GD6Ms+pkhVHXedg7Bsm9yuk+Tztv/lHU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:6c48f3ec-394e-47e3-bd9a-93acf3e13cd7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:05b675fc-7800-43c5-b97b-ddbe32561a5b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0ee9fab6ecf511efaae1fd9735fae912-20250217
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1537194068; Mon, 17 Feb 2025 14:04:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 17 Feb 2025 14:04:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 17 Feb 2025 14:04:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6803Xh91UpgbDZFoSAu7ImP7th+X2/ouobKPl+9YW4cezOwReWS4ONMSH0d24V2W3aJNpXRSivVgFd6UITp7QZfAjI8RGUw1RnoJsLt8RrPPt1D0a29s0aLERLnzsml5iznQE0FMccWKDCrlC+wdRd0sAhlk5D4GDIRBr+p9TnYGh9GBuoHmb7OzdTht6xeKQ03CryYC/qsj1I6T2zPjTDISVEYKW2ZEH42bJrvI+WBDohOn0cUm1F0eLfEF3ZgUCI7piop/briqh89WEJmXLWCiTgJKSxOf+Klckff0Wb9wYciTxksz+x4mYK/9CK8p16VB55kv3Z61JOXKTsJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku5tnvh5Ff/RtwIYb0kdF/MiDxRp9LqNoKU9mdJfTTU=;
 b=QAprj+OhzpItQtUsvFNYRA5NBoUq2EbvoOSoCxYPaT6NOgk36OfMd0mm/+jQgHy9111KmM3UbV0/nfVCBPdSZp9tlz55mbyc4znacWPJDziwqO9RjaZ4x2UHs/b2V+fxCdeKBNO3wZwvPqrbsPo2PluA+xKfwxqRDcTssCxLvaghGc44EFqReOa21zjMfCD5z+/8PUSDNeKP88WTm8iBZPcddamzeBmzdziB52AEhBXSh47Cna4fsMcfq6+716PdoCZsJgv2UXPWn80/QX/PtxIF/UahnCd7uNu0imvC17EIjNBKaoTJ6ocKvbxasp30rrzxlTlPq6o/dgUmz/Cmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku5tnvh5Ff/RtwIYb0kdF/MiDxRp9LqNoKU9mdJfTTU=;
 b=diw3gb3ixom0oEhwrnqqjVsOQNfrzW1LQnxlyXVACCYbr/AczY0slse4s0hasVMxF1omMv1RQ3KUZent3Jeqv7iNwhVigtChPu1Vl3snPbT0xrgHzyh+dQ4AgZWCipQWqIXAOPEbL5cqAAHwJA5vGlt+/gdTajOaLGt6AzDvh2k=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSQPR03MB8459.apcprd03.prod.outlook.com (2603:1096:604:271::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 06:04:29 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8445.013; Mon, 17 Feb 2025
 06:04:29 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?U3VubnkgU2hlbiAo5rKI5aeN5aeNKQ==?= <Sunny.Shen@mediatek.com>
CC: =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"treapking@chromium.org" <treapking@chromium.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?UGF1bC1wbCBDaGVuICjpmbPmn4/pnJYp?= <Paul-pl.Chen@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>
Subject: Re: [PATCH 4/5] drm/mediatek: Add MDP-RSZ component support for
 MT8196
Thread-Topic: [PATCH 4/5] drm/mediatek: Add MDP-RSZ component support for
 MT8196
Thread-Index: AQHbfDEQZ/cUZFoXjUibKpIU1qXg7LNLCzgA
Date: Mon, 17 Feb 2025 06:04:29 +0000
Message-ID: <58905e28726bb87e20bdfdef6fa78784656ba1c3.camel@mediatek.com>
References: <20250211025317.399534-1-sunny.shen@mediatek.com>
	 <20250211025317.399534-5-sunny.shen@mediatek.com>
In-Reply-To: <20250211025317.399534-5-sunny.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSQPR03MB8459:EE_
x-ms-office365-filtering-correlation-id: d34de4a0-a70e-4c60-6c06-08dd4f18f0a0
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y25KM3hXZU83V2N6ekRrTngxQ3dUUlpqcUIwZkRMT2tkMmdqMDR3V1ROWDBh?=
 =?utf-8?B?Q0R3TUx6aUp6VUxqSitLKzlpVkU2dHBmdjFFbmt5eVZrdmZkaERGT1lJS1dn?=
 =?utf-8?B?WWFMR2h6YmQvRXBkdXZqbENoakxOM3hYUnFPVjcyUjI2d3F3Qk5NU2hZRjN2?=
 =?utf-8?B?QnJTT3BCVUdMYmlwUmwwUVNjMDZMUGJQbnlHeGQvVDlkZVhNTG80N3I2L0k1?=
 =?utf-8?B?bFZjaGJLQmZ1UmprVjNoVzl6UlZtQnozSzVlMEsrdlJrOHV3SnVxWHllRlVh?=
 =?utf-8?B?cHJURmRXd1ozSk5EcUhoTmsyZ1J1SkU1MkRrYnYyT3I5M1RVNzI4SlI4RWNm?=
 =?utf-8?B?aDlObTNGZmFiZjZvbE1nRXIrQ0JydVhGbUJaSEtmU05rOHFsWFhWeGk0MGNJ?=
 =?utf-8?B?TWc1K24wWTBpMU1leWlHVDFGNkJLcmIyci9OTy9oZFNzd29WdVR4VnJEOEM1?=
 =?utf-8?B?RHpFRXY1WFcwc0pCeVdmamxpaUZlWU91Q0FMZDFjbS9zMHRHNEN3a1RHQTZi?=
 =?utf-8?B?cjU0TUIzNzlYa2puaEdKN082a0JGWmJHNVpRdjF5VVJKRHNlVkVKeTVXbCsx?=
 =?utf-8?B?WkxZeld6YkliMG9kbmVyTVFsRmhUS3pOYnh3V3lCS1ZhRGQvUEl4QkRKQ0VP?=
 =?utf-8?B?eDJXUllWbStTNzlTWkJnbkg5d1RlNHltRUYzSnFTY0lGU0J2RTZGeWxyUlpN?=
 =?utf-8?B?WW0xUTIyV1VWWU1DTmxqeENnS1NrUWFjWmxvOTNoNklJeEVxN29LVjU2Z3pj?=
 =?utf-8?B?TU5ab1ZIVTlHOTRpSFBFaGtoUVhIcG5LdW9YVVppeFRLMk1CTVFUK0RPbHUr?=
 =?utf-8?B?NVZNeFEyQmVsS0huNUJyMXVVaHFOeW9ZNDVNZnJKQUN5WWwyQ0g0a05FSmpK?=
 =?utf-8?B?RlFsdVdRU1YxZjhsSDhpTVYyU3dxLzk3ZmRlQ2dxVFoxQWU3VFI5K3o1WURm?=
 =?utf-8?B?b014WHpjeXFZTlZQWW95Z09pWVJwZ0tpcHQ2NzZNSlFFd2luVmxXM1ZobFZi?=
 =?utf-8?B?N2dxNE95ajN2cG13alZiWWRkOVA0UjVGNnN2Ym1BSzY5R2prOVIzaDVLWmJh?=
 =?utf-8?B?bEkwcjdibE5QeXk3RDd4bUNTb2pJb2s1dkpCVGFvSEk5TE53WWIrV1E3QTh4?=
 =?utf-8?B?cjE3MHFJak9sS0dRQjIySUg2QkloNVAvL2Npc2MzbkhiaVh4Mi9acDBhVjlB?=
 =?utf-8?B?aW1OWVJWanREMlZ0d0JFK0tJRXdpektNb2ZVRGdNS21pWnlvWmY5dEp3Y1Bs?=
 =?utf-8?B?ekRRQnErM3l1WFdabWZMdFRkeWtHQmNlb3hqaWE2OUhSNmdvM0F4Zy81WU9Z?=
 =?utf-8?B?OHNwcWdOSlhWNnNteEVyYjFneXhvTVhqMTRhZUZjdG5EUTJJaWQ0ZVc4U2RK?=
 =?utf-8?B?ZG1URXp4UGFROGNrTG5xdUlPMUtGZWV2cUkrTjVmeVVlUC91T0hkdDE2M3o1?=
 =?utf-8?B?cEg1M3JmdFBiSTZiVXE2aXBXb0tnL1dZNkpGYUh0c1R5T3IwS3luMkV4UTgx?=
 =?utf-8?B?dEM4RjdNNUpPdFVKcjN3T1E3eHZDajNKQ2krd0FrNjFyL0ljdTFEazVSMjRp?=
 =?utf-8?B?YVlyV25SbktLSFhheW9hTEU0YUdIVjBFVk1ZUXlaLzBpWHphcUJmc0FrT09s?=
 =?utf-8?B?cEpTNU5qdnlyWVQ0dmVBakxqanlJQnFXc3lYY1JYOENxTnNRQXpMaDlrTFhn?=
 =?utf-8?B?RHBIMk1PWjdVOUYvVkprc2dxTUxUOFpyaDcxc2VxRWFYTVVIRmhtN05CWUJ1?=
 =?utf-8?B?ZDBZYnhWandDTVhhTEUyaHFLdkhjN3BxaUx4Z1VmU1A1N3M2dTNsRjh4TXAz?=
 =?utf-8?B?aXNJTUJFeHFVYUdwYjVvMEFBQjVoS3NCa3JPSUlZVW1hYlZGTmVGLzNrWUFZ?=
 =?utf-8?B?dm9oWTN3Wm5QOFh6Z295SjZya0x1ZG1DNFljWElGRlZGUjJvR3RGL0ZXY2c5?=
 =?utf-8?Q?M7RBiF8VvUKwPR/KbKST5TXJTGaCS1pV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emtjVTN0NFc0VlZwWnRjY3dsOHRMalF1Y1VGaW1YQXZrcThsaElWaUs1N1Qy?=
 =?utf-8?B?dmFjV2lxdmFua254VFdZUklhQmZoSFM1c1V0Mnk0RXNlVEZ0TzZBaWlTTDJJ?=
 =?utf-8?B?RUk3ZDYxUUFlekppOERTMGtNVTZtS0JQdDZkSVhjRnpPZzc2RnBqTDExNFhQ?=
 =?utf-8?B?RTN6RUpMQm1TcTYvaURqSjRZUmMzcHZOazM0azRCR2hsK0Ezc2NzSmhVL0JK?=
 =?utf-8?B?WW5tYjQvWS8ya2ZCeSs3NGY1alQ2dW5NUXFUUi9pWC9rNWwvdERkdHFhcHUy?=
 =?utf-8?B?ajU5TU96dmEzQnYzQlpYVXFiL1BPRFBVL1g4WTdjUGVTTk11UnFDQkhYNWlS?=
 =?utf-8?B?cjk0a2tVSmpWdlhHVFQ5N0FzMlUwSzUrMndZV2wxR1pjaEJuMzNYY1M1cVZC?=
 =?utf-8?B?RGtic1owVkFvTTh2VkpvMDNGTjNJVnRKUDBlSHl1ZzRrUjB4SGJaL3c1TXN3?=
 =?utf-8?B?MXdnY0xITTljZU1iVWsxT3BlTmdLK1VqMWZOSjJMd3kvR0pJM2wxK3dnOXNE?=
 =?utf-8?B?TFB3TDltYXRPWm9RRERCa21iQWZ1QWFWUEgrbUphS1J6Y29HMUpoZWQ1SU5J?=
 =?utf-8?B?U3ZvVXM5OHp3V1FKV2ozV1FYd0lXREhqVXZseTg5NWN4aFdVT2w3MFdZRVRa?=
 =?utf-8?B?UTNJNWFzNXJZSERDdEtLTFBmWVNHSkJVSHB4QWducHhtMGFLQThNQ21scG9O?=
 =?utf-8?B?NjZJZ2hCWllSazNhWmlpRjhFdEdOZk5BNVdEZHd3ejRwVVBlNERUV0haUHZq?=
 =?utf-8?B?Wk9VUHF0VWluaEUyV1VuUFUvRy9Sb3Vlc3FzVW56UklzK2hKMXNkK1hkNDR4?=
 =?utf-8?B?d3BrSjlVeWYzNzBsNWpqZUJBMHYvaHRBaHIwSi9GNmFTTEgySVZFWUlIZE5O?=
 =?utf-8?B?TUcxMzl6ai9TVzkvelFBYThkNWxoU2plSi9jektLOElnOC9QQ1FtSi9KNnB1?=
 =?utf-8?B?cTVLcXlrNnQxRVM0SFcvcUNPRldrcExmYmtDUjltM08xTExvejBIbkVjMUpD?=
 =?utf-8?B?eG5MeHQyL0dHRW91bmVIVEZzd3NLMmVyQm5XRk9ubUY2YTMxTGNxTDlSWUJs?=
 =?utf-8?B?QXZZVXhrWDd3dEpKTUEvdmttL0k0b3ZGM2YwbXRTOU5IN09mdXY2bUtncFFo?=
 =?utf-8?B?dThGVjdacnd2RDZEcFVMRHhtUis1MGpWOEtQUGdlUTZIRjVueEQvMDgzTm1P?=
 =?utf-8?B?eGRlSC9tY000dkRLdGM0UGl2Mk8ra0ZMQ0tMNDZKeWlNemdiS2Zldmp1Nzc4?=
 =?utf-8?B?RXpHYVhxMW40emlsSFFTVEZGemlQa2lYT3pjeDRxWitGZ2dsYXkxOTFPZ3hW?=
 =?utf-8?B?a2F2a0RCVGVsQ2ZudmJjQnFEa21NNXNaVTl1TExXU1JEWkNvY0hFSm9JaWJN?=
 =?utf-8?B?VW9NV082TlpzN2hwTGpwZW5KQlRJbXh3TSt5ZEVDSkJ1dWMvR2c4cXFSRjhP?=
 =?utf-8?B?ZkVOUGxZUFB4UUdwQVNLRFFRWVhQMytWeU9IeEpiVm1zazJ5S0lhNzAzZWtR?=
 =?utf-8?B?cDFLSU9HQmhNRVUxUm5wazNtcERjeE9BUlZQMGZWbnJsTlJ4ZWNvMGR6d2l3?=
 =?utf-8?B?anVhUnUzSTNHWklkc2NXSGJZYm5LVGRNc0ZzbFY4azliZUN4UVJ6VEltVUdP?=
 =?utf-8?B?SlcwS0t4VE9WV01abC9pV1UxTzdxczZZWEthL0dZODMvT3JYbkxaYWk2c215?=
 =?utf-8?B?U1MyOExxOHVNNXJXMUlCd3RLdFdrcTdzWVJEaWFFWjAxdUF2TExMNW1LWkNQ?=
 =?utf-8?B?ajNwU2RydHhsaHhiK0Z4cDhiZUQ1L1VsV1Y0SmovblBJRlZMRmRIQk1BNVBp?=
 =?utf-8?B?QTNYOHIvVW5RRmxTcjkxOHZ6SGtPSklMV2tRMVF3ZDQrQ09uK2VEaU95NkZM?=
 =?utf-8?B?aENURTd0a1JwZVlwdFRmT3JhVThrWkZrOWZaREd2TjB6YVNiOHpUaFZsRVVt?=
 =?utf-8?B?SWR5c2tJSEZjbFJCT1FFYUFXRzlCTVAxdlBHWDNoSmV6MlMzOW03RXhmY1BH?=
 =?utf-8?B?WlBVeEhlcGp2Ti9XNU5wWExTcWkzNmFxRnhXNFhkRnNNSXlBZ2d5SG1YY3N3?=
 =?utf-8?B?a2dHRHQrcjZ1a01CMHZZbXo4MGo5NVNqVUpyblUvNzhBczVEYWJoSUFZcEQ1?=
 =?utf-8?Q?ioOA/GVqF36jRzA1qYaw9TKg7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B5E2746F47B1E428D791EB687F9511D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d34de4a0-a70e-4c60-6c06-08dd4f18f0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 06:04:29.0921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LVGJiE8cs2Je+InDW95gwusjJf1DtGV9sS9CAqx5DbmuDDDTIOpWQuhzsNiQ3RS//j17gy+rZ74Uo2yWbYzrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8459

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEwOjUyICswODAwLCBTdW5ueSBTaGVuIHdyb3RlOg0KPiBB
ZGQgTURQLVJTWiBjb21wb25lbnQgc3VwcG9ydCBmb3IgTVQ4MTk2Lg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogU3VubnkgU2hlbiA8c3Vubnkuc2hlbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jIHwgMjQgKysrKysrKysrKysrKysr
KysrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmggfCAg
MSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgfCAgMiArKw0K
PiAgMyBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+IGluZGV4IDdmMDlhODk3Nzk2NS4uNjU4NzhkM2Zl
OGE5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21w
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5jDQo+IEBA
IC00Niw2ICs0NiwxMCBAQA0KPiAgI2RlZmluZSBEU0NfQllQQVNTCQkJCUJJVCg0KQ0KPiAgI2Rl
ZmluZSBEU0NfVUZPRV9TRUwJCQkJQklUKDE2KQ0KPiAgDQo+ICsjZGVmaW5lIERJU1BfUkVHX01E
UF9SU1pfRU4JCQkweDAwMDANCg0KRG8geW91IGNvbmZpZyByZXNpemVyIGluIGJ5cGFzcyBtb2Rl
IHNvIHlvdSBuZWVkIG5vdCB0byBlbmFibGUgaXQ/DQoNCj4gKyNkZWZpbmUgRElTUF9SRUdfTURQ
X1JTWl9JTlBVVF9TSVpFCQkweDAwMTANCj4gKyNkZWZpbmUgRElTUF9SRUdfTURQX1JTWl9PVVRQ
VVRfU0laRQkJMHgwMDE0DQo+ICsNCj4gICNkZWZpbmUgRElTUF9SRUdfT0RfRU4JCQkJMHgwMDAw
DQo+ICAjZGVmaW5lIERJU1BfUkVHX09EX0NGRwkJCQkweDAwMjANCj4gICNkZWZpbmUgT0RfUkVM
QVlNT0RFCQkJCUJJVCgwKQ0KPiBAQCAtMjM1LDYgKzIzOSwxOCBAQCBzdGF0aWMgdm9pZCBtdGtf
b2Rfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgCXdyaXRlbCgxLCBwcml2LT5yZWdzICsg
RElTUF9SRUdfT0RfRU4pOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9pZCBtdGtfbWRwX3Jzel9j
b25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gKwkJCSAgICAgICB1
bnNpZ25lZCBpbnQgaCwgdW5zaWduZWQgaW50IHZyZWZyZXNoLA0KPiArCQkJICAgICAgIHVuc2ln
bmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQo+ICt7DQo+ICsJc3RydWN0
IG10a19kZHBfY29tcF9kZXYgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKw0KPiAr
CW10a19kZHBfd3JpdGUoY21kcV9wa3QsIDAsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywN
Cj4gKwkJICAgICAgRElTUF9SRUdfTURQX1JTWl9JTlBVVF9TSVpFKTsNCj4gKwltdGtfZGRwX3dy
aXRlKGNtZHFfcGt0LCAwLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCSAgICAg
IERJU1BfUkVHX01EUF9SU1pfT1VUUFVUX1NJWkUpOw0KDQpEbyB5b3UgY29uZmlnIHJlc2l6ZXIg
aW4gYnlwYXNzIG1vZGUgc28gd2lkdGggYW5kIGhlaWdodCBpcyBzZXQgdG8gemVybz8NCg0KUmVn
YXJkcywNCkNLDQoNCj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgbXRrX3Bvc3RtYXNrX2NvbmZp
ZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCB3LA0KPiAgCQkJCXVuc2lnbmVkIGlu
dCBoLCB1bnNpZ25lZCBpbnQgdnJlZnJlc2gsDQo+ICAJCQkJdW5zaWduZWQgaW50IGJwYywgc3Ry
dWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCj4gQEAgLTM5MSw2ICs0MDcsMTIgQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRwX292bHN5c19hZGFwdG9yID0gew0KPiAg
CS5nZXRfbnVtX2Zvcm1hdHMgPSBtdGtfb3Zsc3lzX2FkYXB0b3JfZ2V0X251bV9mb3JtYXRzLA0K
PiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfZnVuY3MgZGRw
X21kcF9yc3ogPSB7DQo+ICsJLmNsa19lbmFibGUgPSBtdGtfZGRwX2Nsa19lbmFibGUsDQo+ICsJ
LmNsa19kaXNhYmxlID0gbXRrX2RkcF9jbGtfZGlzYWJsZSwNCj4gKwkuY29uZmlnID0gbXRrX21k
cF9yc3pfY29uZmlnLA0KPiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGRw
X2NvbXBfZnVuY3MgZGRwX3Bvc3RtYXNrID0gew0KPiAgCS5jbGtfZW5hYmxlID0gbXRrX2RkcF9j
bGtfZW5hYmxlLA0KPiAgCS5jbGtfZGlzYWJsZSA9IG10a19kZHBfY2xrX2Rpc2FibGUsDQo+IEBA
IC00NTQsNiArNDc2LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdCBtdGtfZGRwX2NvbXBf
c3RlbVtNVEtfRERQX0NPTVBfVFlQRV9NQVhdID0gew0KPiAgCVtNVEtfRElTUF9ESVRIRVJdID0g
ImRpdGhlciIsDQo+ICAJW01US19ESVNQX0RTQ10gPSAiZHNjIiwNCj4gIAlbTVRLX0RJU1BfR0FN
TUFdID0gImdhbW1hIiwNCj4gKwlbTVRLX0RJU1BfTURQX1JTWl0gPSAibWRwLXJzeiIsDQo+ICAJ
W01US19ESVNQX01FUkdFXSA9ICJtZXJnZSIsDQo+ICAJW01US19ESVNQX01VVEVYXSA9ICJtdXRl
eCIsDQo+ICAJW01US19ESVNQX09EXSA9ICJvZCIsDQo+IEBAIC01MTUsNiArNTM4LDcgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZGRwX2NvbXBfbWF0Y2ggbXRrX2RkcF9tYXRjaGVzW0REUF9D
T01QT05FTlRfRFJNX0lEX01BWF0NCj4gIAlbRERQX0NPTVBPTkVOVF9EU0kyXQkJPSB7IE1US19E
U0ksCQkJMiwgJmRkcF9kc2kgfSwNCj4gIAlbRERQX0NPTVBPTkVOVF9EU0kzXQkJPSB7IE1US19E
U0ksCQkJMywgJmRkcF9kc2kgfSwNCj4gIAlbRERQX0NPTVBPTkVOVF9HQU1NQV0JCT0geyBNVEtf
RElTUF9HQU1NQSwJCTAsICZkZHBfZ2FtbWEgfSwNCj4gKwlbRERQX0NPTVBPTkVOVF9NRFBfUlNa
MF0JPSB7IE1US19ESVNQX01EUF9SU1osCQkwLCAmZGRwX21kcF9yc3p9LA0KPiAgCVtERFBfQ09N
UE9ORU5UX01FUkdFMF0JCT0geyBNVEtfRElTUF9NRVJHRSwJCTAsICZkZHBfbWVyZ2UgfSwNCj4g
IAlbRERQX0NPTVBPTkVOVF9NRVJHRTFdCQk9IHsgTVRLX0RJU1BfTUVSR0UsCQkxLCAmZGRwX21l
cmdlIH0sDQo+ICAJW0REUF9DT01QT05FTlRfTUVSR0UyXQkJPSB7IE1US19ESVNQX01FUkdFLAkJ
MiwgJmRkcF9tZXJnZSB9LA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kZHBfY29tcC5oIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5o
DQo+IGluZGV4IGJhZGI0MmJkNGY3Yy4uODdmNTczZmNjOTAzIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RkcF9jb21wLmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kZHBfY29tcC5oDQo+IEBAIC0zNiw2ICszNiw3IEBAIGVudW0gbXRr
X2RkcF9jb21wX3R5cGUgew0KPiAgCU1US19ESVNQX09WTFNZU19BREFQVE9SLA0KPiAgCU1US19E
SVNQX09WTF8yTCwNCj4gIAlNVEtfRElTUF9PVkxfQURBUFRPUiwNCj4gKwlNVEtfRElTUF9NRFBf
UlNaLA0KPiAgCU1US19ESVNQX1BPU1RNQVNLLA0KPiAgCU1US19ESVNQX1BXTSwNCj4gIAlNVEtf
RElTUF9SRE1BLA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYw0KPiBpbmRl
eCA1MGY1ZjgxYTdkYTEuLmI4MTBhMTk3ZjU4YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTg4NSw2ICs4ODUsOCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBtdGtfZGRwX2NvbXBfZHRfaWRzW10gPSB7DQo+ICAJICAuZGF0YSA9
ICh2b2lkICopTVRLX0RJU1BfR0FNTUEsIH0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxOTUtZGlzcC1nYW1tYSIsDQo+ICAJICAuZGF0YSA9ICh2b2lkICopTVRLX0RJU1BfR0FN
TUEsIH0sDQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTYtZGlzcC1tZHAtcnN6
IiwNCj4gKwkgIC5kYXRhID0gKHZvaWQgKilNVEtfRElTUF9NRFBfUlNaIH0sDQo+ICAJeyAuY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZGlzcC1tZXJnZSIsDQo+ICAJICAuZGF0YSA9ICh2
b2lkICopTVRLX0RJU1BfTUVSR0UgfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
MjcwMS1kaXNwLW11dGV4IiwNCg0K

