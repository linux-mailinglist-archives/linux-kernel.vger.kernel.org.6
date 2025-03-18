Return-Path: <linux-kernel+bounces-565513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A86A669E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 06:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A9C77A9DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991D1A316D;
	Tue, 18 Mar 2025 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="srxcAZTn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tXFL2qdw"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAE51922D3;
	Tue, 18 Mar 2025 05:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742277310; cv=fail; b=oBSTykFblQ1/A3/4WVXrR1rK9OVGf8dHkZfIz1Y8yhuqcermjIXDH5fZmhBz8lFFAbWyaW1lglgUMatWY2qBJ08vQACwNcheBglux9RFaj+UP3l35/wW1m9SYpTglOIk1eI6ATgTFyjD+IBgr6eBExH2Px34G6ktTMCEv/Al0H8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742277310; c=relaxed/simple;
	bh=edg2hI0dhzAtT4noXtZSJkac3OZnYRnVk17G0b2xp/I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sPLLc4Q/G5f4+xogd0fU80/6j7zcNyh4vRFV99lpkx/u2Kggalv2YSgAk2Zz+sq55NRnjeReMwgaGCbj4wpmuDYpzIb5jqZIk2rpy4kJWLxy7d2XkpddPrIeulFG0Z5RbPL2CbriHpvy3s8/B9lul6V65iw3XxSKO5OXVGHXbCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=srxcAZTn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tXFL2qdw; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 88e604c003bd11f0aae1fd9735fae912-20250318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=edg2hI0dhzAtT4noXtZSJkac3OZnYRnVk17G0b2xp/I=;
	b=srxcAZTnTAQ4fWQlGfRKcuCJ5UgqSAZ69Yf185TPxvuLx2MTOajlGG/3r21YiZGNfQB9JhBxsfspVq6s9k3UecR/j612ptiSill+AeZ8BCzjAhO/yDNUitL1fZEP5aUoJ/RGGNldMN3xQF9ENoidRayaC7bDwuREkOddUiqk6+w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:08edee91-789e-4d41-8d0f-3e9b1e7bfff2,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:4823828c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 88e604c003bd11f0aae1fd9735fae912-20250318
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1513428725; Tue, 18 Mar 2025 13:55:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 18 Mar 2025 13:55:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 18 Mar 2025 13:55:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bITrTXkWSM6pMXW6BTRJV8uMk3rMm6zgkByJKHUwPXItPlUcRmf2mLyOYshklk8Xbhs54/ORCCxL8xB+d6bgEu8GzWdXDB0BCWnYbPsmVXgoresd4FM5aEhtnfDef/CQ8RMfi+eK1k6j4FGp7Xdx3LygFziOzOmA33Ro9KrirpEVWRPaJn/+HAmxZYtuGs+KI34hivRly8nf9SIFrLIH45MJKJyCB5HQPgcGtgZAumeSvc+QOjqULdS0qjWNfiBPHxTnYq5/V3xKW8i8QLCTx6l/PgWCybPKENDa91KjzWqzwiFUfOchJ4TeofJGXO6M7PmywYeCnlauaNSC/Jqanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edg2hI0dhzAtT4noXtZSJkac3OZnYRnVk17G0b2xp/I=;
 b=C2JTmJNX5/MahHEtZl4y30pygUSz1UoOr02eRbKN099n8k9MJr8pWCX/5ii0CvLsMAosfPyMgT53uSC4NSsOqbuacOqfxmvYbKbxlJHddkwOeYyPoFxwqqwl3YN2qtcQr4EFNTTsRbgnG0hkMCjRhLMfb08fIhYgHYy15QZXVRBYyuh2DPTWwzVtQYp8014B8K7H/kAn25hPZHjWQV8f7Vqq8UF37B//6qo5zFxIN14FZMyjxI0Sx03Y1HGqDcVMHgEMl16KjECzA6OkK/EetIl3RmNV/npIOXbx1T5olANrRE8gzha3IB5/BdJGL7u8FjCFLCt7mCMfuSV3Z1oV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edg2hI0dhzAtT4noXtZSJkac3OZnYRnVk17G0b2xp/I=;
 b=tXFL2qdwD7CK1T2jliDRlG7luwYHGvsJLnS9eoUogzhYCyvIZaqKdvrginrRMDhoirG70q1H00Jsysdp2Ipo4uZnlDrKcAloNTKBtjzqGSUR6ecAIFMoY/MsPMtrTGaKFw/LGxryZmyWt/mc1QUU5c+PXE8sZ91K4rTNaMzbwzk=
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com (2603:1096:301:5f::10)
 by SEYPR03MB8108.apcprd03.prod.outlook.com (2603:1096:101:16d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 18 Mar
 2025 05:54:59 +0000
Received: from PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f]) by PSAPR03MB6363.apcprd03.prod.outlook.com
 ([fe80::eb73:91b9:5905:e89f%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 05:54:59 +0000
From: =?utf-8?B?SmppYW4gWmhvdSAo5ZGo5bu6KQ==?= <Jjian.Zhou@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH RFC v3 3/3] dt-bindings: mailbox: mtk,mt8196-vcp-mbox: add
 mtk vcp-mbox document
Thread-Topic: [PATCH RFC v3 3/3] dt-bindings: mailbox: mtk,mt8196-vcp-mbox:
 add mtk vcp-mbox document
Thread-Index: AQHblyxZ0NNly2/TqEq6DYJH/I2yn7N3hmoAgADfzAA=
Date: Tue, 18 Mar 2025 05:54:59 +0000
Message-ID: <9d930e1b8245e3e8f00f79a661cf7b9adf273986.camel@mediatek.com>
References: <20250317110331.2776-1-jjian.zhou@mediatek.com>
	 <20250317110331.2776-4-jjian.zhou@mediatek.com>
	 <20250317163358.GA178378-robh@kernel.org>
In-Reply-To: <20250317163358.GA178378-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB6363:EE_|SEYPR03MB8108:EE_
x-ms-office365-filtering-correlation-id: fad2fc1a-082a-4fea-5eab-08dd65e16b19
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dEZBUGtXcFhCUkdjTENqaXZzUzJhbFkwSUk1VXQybWtRUm5IajVKSTM5aVR5?=
 =?utf-8?B?MFZxc1NWaG53TForVCsvWktpNm44RDlKVFJoQUpWaTVZZVB0ZjVnZkhRbGU3?=
 =?utf-8?B?djkwUVJZMFRTQmsvMHRYajMvSktYRkR1cjZSdzlYdUUxdHhhWGNJMlpucGU0?=
 =?utf-8?B?L3JITFV0TEZET1pDeTA1TWVwaUowZ2pya3c0MS81bVZYVlV1eS9nUFhxMWI1?=
 =?utf-8?B?RVVCcnNNQk92NVYvVFRsVklBWU8wTkRmdU5ua2ltanFVdkpFVlJKYXJwZGVP?=
 =?utf-8?B?RHYzNnh4NDFSSG4zaUp3NlVZSmI1V2UwMm9yRlpGV2hhVUU4cEo2a2REaEth?=
 =?utf-8?B?dzA0dlBUbmdOUkhadXZwU0RzRkVOak12Nnp5UGgwelNhbGJ4bFdUVjJ6VW9T?=
 =?utf-8?B?TldGZDRYWFkwcHFtb252WXJSZThNb3BUZE96bGl1ZVo1bDBHV1V4VjNJSDRV?=
 =?utf-8?B?Zkgvd2w1RUhyUkJOMFdXaTB1V2NhRGVpb3p3SXRocm5GSTBlR3dzc3NHZXg2?=
 =?utf-8?B?N3FaOWo3aGgvWmM3T0RDdlVqdUdlSENMMUFNYnRoM1NMYTc2eEdOWnR5VWJP?=
 =?utf-8?B?ak9PMFRheWJzdGt5Nnhtb1BxZkkxSEFFcVBUWkR4VUdWaVIvWTNLS2xwTDM3?=
 =?utf-8?B?RWs2YUZwdDdTTVNZeGdxaVVBRGJnSUFaRHRWby81bElwWXhLTVE3TXBxNjNq?=
 =?utf-8?B?ZjhxZloxc0xFT2x5NGlmRW4rc1FqN2pHWGdLZXF6L0U2TTVadGpidGRPdWIr?=
 =?utf-8?B?VzJHU1lUWjhRNTNFQkdVemFrNDVlSDFnWm1tMStPM1JsM0FBWlpTbk9vRUhl?=
 =?utf-8?B?dmlhUzVOUjhlMHZ6M3BiR09FR3pjdHM2UXp4dXBVRnR5TGRrbERGUys2ZWN2?=
 =?utf-8?B?VVl6QWFETG04ZXkvclpxdFlUUmJxTStDL3AzZ1JHaUg4RTRYdjVrTng4VHZV?=
 =?utf-8?B?MjhnSU9vZ1p0YzVROC9nR1BMZm1MdFRuNmd3NURMb2NHSjVFTzhZeFZXbCti?=
 =?utf-8?B?Q3dDQkJiN2ZlWEs4Y3dMM3IxWExVRUQwYnprTFpPdC91RndjYTBtalZlaG5Z?=
 =?utf-8?B?aHd6MVNFaUJPUDlqU0JKeElNV2QvRXJPMEZyQzNBaEx0MTJBWE01U2k1VGU3?=
 =?utf-8?B?S3FBYU1nMngwelMwL3Z2RGpPcWNVY3EreXdobTNYTFBtdGtXaWRrZUhFSjgw?=
 =?utf-8?B?dkVGU2I4UVRhUHZjZnFKcDl6VmVJb2llK2FYSUVsaXFya3kwWkFoa0Ezc0lw?=
 =?utf-8?B?M3oveXNObWFmSVhqOHZicE1rd0tuMUR0ZkQ0Vi9yWlgvUERBQXBKSXBNS3dU?=
 =?utf-8?B?M0lJdVMvelBDejZhV1AwL2Z6MmJnZ2J6dzd0QWxzVGlLT1BvUUVGSUdZeWY0?=
 =?utf-8?B?WUJIaElta1BMNzRMN09PQktHN21UVnBlY2xHTkFzZHczUTdxbkhWbGNvdG5x?=
 =?utf-8?B?azA1bm5ZR2lCcjMrUExUWjQ0bkt5T296ZC9OamJLUlBqeTN1YUlvTExYMkpZ?=
 =?utf-8?B?eDBzWURDVG9Vc2FrYmh5SXpkQ0xrSmdxZndjbGNKREJPL0pFOFNhY2ZKQjBG?=
 =?utf-8?B?eVBvaFhXTlJocXdReGxILzVHK3oyckFLbUdXTmZJY05sQUNDMXZNZEtJQVNR?=
 =?utf-8?B?RHRETi91ZzIxZE9WaDBhZTZBMm5LRDBNSSsybVBRQkd4MWU5SUFhR3lOTm1z?=
 =?utf-8?B?QnplOTF0ZkkxcTlENFc2alNwajA1YUsrZ1ViM3JYaXliS0JtOFVURUJTZWdy?=
 =?utf-8?B?WTR6QktIM01SU0hvdmpOaDlHYVB3VDhETzRjRnZmU1cvOEZueE5zR2ZOOWtn?=
 =?utf-8?B?dGd5a0RuQk1MdkNuZmRFbHVNVFFBc2NMTDd2ejUwdng3NVR3eDQ4YlpvMHBM?=
 =?utf-8?B?VStwcm56YUhBMzRtZjhpbUNXY2lLQjJBNU1HMzBGNU9RUFBMbndQRTF6VTVu?=
 =?utf-8?Q?2Qjat30lGzeB5hcuvwcDV8eQmzZxGrn5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB6363.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qm1PUFZuY2dBZDNCM0h3QVVoRjBFQm52UmdTNVlrRUQ1SmRPN0ljWGdOYTVZ?=
 =?utf-8?B?KzJOcm1zbkQ3c05NbS9nYnpSbnUzZ1g3Tm9UcnF5N1Jwd0pYeUxkajl5UWRX?=
 =?utf-8?B?NStJOHc1K0lkSXQ0ZHhSNkRHbHdIc2FZcUlmelRMbWNRQjhqdENjL3M5M2gw?=
 =?utf-8?B?Q3U3WmhPVXYrK3FpQTVTZmtiZmg0ZFJBckFBZ25zWWllRkgvOUVhREZDUHcw?=
 =?utf-8?B?YTQ5N0J6OW9LR21sUTdvaGgvaXUxYVB3Z2tPcFBocjAzWGZmemxVbEFFMS84?=
 =?utf-8?B?UE1qUEhlYkFyQ0VPakZmS01RZ2tEZ3k1ZzhrRnZUVlZQTFUyTGdHODc4SU1N?=
 =?utf-8?B?Z2NEaC9jcHZXdE5sOHF3WGZiS2ZsZ24wOURCbU5MaEkvelZSQ2g4WCtKR2ZI?=
 =?utf-8?B?MWhZblJhSWJaNGs0NjhMSlROMUZPSVJqY0ZTbnVXVExEK0xHVXh2VGQxblJF?=
 =?utf-8?B?djV0WTlQTDB4eXdkdWpsS01UK005RHZJcnU1WGdqazJrcTFUazdzL09kOUxt?=
 =?utf-8?B?MHZKS3d6QWtXUGVyYkhUMFp2a3RUWXdkMW1UZW1WaDl3RndsaWluemgvUmdv?=
 =?utf-8?B?VWRJTmRlcWZQd3pIbENBRC9NK0xVZVJkWTVlT1ZkOUxIUXVwNVdpcVp3SHhl?=
 =?utf-8?B?RTVKY2FTWjZGdG1uU0JqVWtaRWQvWW1tMTRyUWwyd2dPelM4a3I1T0VrMDJM?=
 =?utf-8?B?WUxOVjRhd1J5R3FkdlU3VzQ4cVJmMVhiVCtIUnpBcGJ2Y2I2T0ZZalJPamNS?=
 =?utf-8?B?OGdha2wzb3FlempST0VNYUdjcUVsS3FoTi9NMk8vMS9SYkNWQlBaN2dBenY4?=
 =?utf-8?B?dVVrbURwZWpKTjE3cmNjZ0ZqVFZZTHhNQXJvNUJWK3VWTlZxYnJjY0hQWkZL?=
 =?utf-8?B?bkU0QWpEN1FJeFpFcFNTQzhPeU55OHo4azRWd3VETjZoWU5wYVpJV3ZTYTZk?=
 =?utf-8?B?TS8wN1R6cllCVGpaSE0xUW9oNFlBVUZJL1B2SHcyQXJXVFNIOWN1alNwQ2VN?=
 =?utf-8?B?YkFtSy9jdzNzSkZlaGtZcTFYMjBneVRQTCs0a3JkWjBOVDViSG91SnExdXhl?=
 =?utf-8?B?dzM1SFdJYmFOcEExbjdKU24zS1dsYWlKdHJUSjF2WXFrT21POEs3cUlCRi96?=
 =?utf-8?B?dSs3bmZYUlVhLzZQWGhVOTVzbmppM3F0c0lPM3dCb2dQZUZ3ZjdiWkg1VWRu?=
 =?utf-8?B?QTRMMWl0YnMxTmx1cUdnVmJyRE41QlB1cnJhVmFMbUZJQllUcnJkMGI2NFdh?=
 =?utf-8?B?MW5Fc1BSdUdIUzExRFkzQ0Y5S1NRc1F6TDRHV0ZiUHBaSVcvN040T3RJNDVF?=
 =?utf-8?B?UUpudUlnVUlFNCtVc3lGRGRMSWhKZytvUVIrQjFuSTlmY3V0UlB1dnM2anBE?=
 =?utf-8?B?VG1KVGdXNmFDdDBleEVZSStTY2duV0M3UlhUNXI1dlk0MHJkdmd4ZVN4dFBv?=
 =?utf-8?B?bXVVdkg4blExdUhsRExSdDJxS0dTRjc4TDZlMU9qaWMwSFRLaTlncmJZY2xj?=
 =?utf-8?B?UzJYNHFIRWl3bWgyZ09ndngwZHprZGZtdlNPYWRuVldKMS9hZ204cDN2Qjhq?=
 =?utf-8?B?STFIc2UrdkRubElhajRVbDNKdzVyYy80SkVNVTl2a0dpSjBWSXhYVlBjbEhq?=
 =?utf-8?B?SU5DTUZSMzNmNkdRTWVlVWxaaXY5UytJVlZjQXFialNjOGVYNS9xaDdVVE96?=
 =?utf-8?B?QVNuVTI1ZlMxbkNoZjNDOTdwcHJqUDNrY0pqV2Q2Mk5hK1BJYjhuN2V4NVRJ?=
 =?utf-8?B?NlJFTDRxcWVHZFlZNjlvbndFbUtNN1FVb0xlTVY0N2tGMlN6K1Arb0VUU09Z?=
 =?utf-8?B?dVBFcmd5R2l2UjBzM1c5clMrWnArZE1XeXdlWE9IWWRhMmFFSVA5Uzd4ZUxj?=
 =?utf-8?B?dG5JRVc1eUs1cjZzTDdSUzh3Q2g4RlJLYStnVVZHMmhBSG12MWhTQjVLaDc5?=
 =?utf-8?B?Q2IyVjVyTjUvdEdIN2lNdnpZRUo0ajVGOUdnaEJjKzh4TVVTTU9CYnRjcTlX?=
 =?utf-8?B?MktDSncyRDN4MWNCemtqM1ZNZWZVVFczTkhIZUdPTS96WWpxY1JBVSs4WXls?=
 =?utf-8?B?UnNKMDFSZzN5b281eFBNeDlONmh1SmM1ZlgyK0lpclB2empNUENHUUZIb0pq?=
 =?utf-8?B?KzhibCt0eDJ5UkNaTis4YzMyTkRIWlBWRTdrYnVpS2VZNGJPQ2huYnAzZi9R?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4138C4B286509248887E250F9AA13AAF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB6363.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad2fc1a-082a-4fea-5eab-08dd65e16b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 05:54:59.4878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 16fb4aWH4TlkZurZWFTxmaPSgbd6y3FLjPcF378A0GrWE8o6Q55+HHCKPMd6CUmPx8jXkGmo3U8uE2hk8RqSWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8108

T24gTW9uLCAyMDI1LTAzLTE3IGF0IDExOjMzIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVu
dC4NCj4gDQo+IA0KPiBPbiBNb24sIE1hciAxNywgMjAyNSBhdCAwNzowMzoyNVBNICswODAwLCBK
amlhbiBaaG91IHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBkb2N1bWVudCBmb3IgbWVkaWF0
ZWsgdmNwIG1ib3guDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmppYW4gWmhvdSA8amppYW4u
emhvdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9tYWlsYm94L210
ayxtdDgxOTYtdmNwLW1ib3gueWFtbCB8IDQ5DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tdGssbXQ4
MTk2LXZjcC1tYm94LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL21haWxib3gvbXRrLG10ODE5Ni0NCj4gPiB2Y3AtbWJveC55YW1s
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9tdGssbXQ4
MTk2LXZjcC0NCj4gPiBtYm94LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uYmQxYjAyNGUyMmYxDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L210ayxtdDgxOTYt
dmNwLQ0KPiA+IG1ib3gueWFtbA0KPiANCj4gU3RpbGwgd3JvbmcuLi4NCj4gDQo+ID4gKyAgY29t
cGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTk2LXZj
cC1tYm94DQo+IA0KPiBtZWRpYXRlayxtdDgxOTYtdmNwLW1ib3ggIT0gbXRrLG10ODE5Ni12Y3At
bWJveA0KPiANCkhpIFJvYiwNCg0KSSdtIHNvcnJ5IGZvciBteSBtaXN0YWtlLg0KSSB3aWxsIGNo
YW5nZSB0aGUgZmlsZSBuYW1lIHRvIG1lZGlhdGVrLG10ODE5Ni12Y3AtbWJveC55YW1sLg0K

