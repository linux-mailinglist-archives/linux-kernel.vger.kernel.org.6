Return-Path: <linux-kernel+bounces-218603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A8B90C278
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73B16B22341
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 03:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D8133DF;
	Tue, 18 Jun 2024 03:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EK1l3yKi";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="V6xfAwWd"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19419B3F9
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 03:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681323; cv=fail; b=UA9YVoX3tN0a1oiPA7VWMN4uiqiZyfQOlK0W6bGNyypbkVgcCdsakXXMz0JTj0kHEU1s2da2+f7OyJ2AMDDCH9mEbtvjsMHV7nOzSfTZTQw0PPbFahK4fso96Q+GZ8lzDwmD6MoyXxcshgLYa/rKgU4GWrFSL79QNWy/aqdvG0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681323; c=relaxed/simple;
	bh=7T/QDQXV8EKd9rXBD1iPrZ2aCsPbZJuhnn+4Du4YRMc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gVoHEnXM0XyJeHPSPrVgpZpY11s/0nFGwrvjz1G5XfdCfEsyEFrLaCnVaxbOji5GoLt9r8xmAao4S6LAWgOrL5XN8S+skwBqXhwuJdVLR6xRfflVyCKnk/EOEbvE5pDhW/U3v3nmHoDmWvicg54F0DN820K3FXM+RMcQfQgEys4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EK1l3yKi; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=V6xfAwWd; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d4deab2e2d2211efa22eafcdcd04c131-20240618
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7T/QDQXV8EKd9rXBD1iPrZ2aCsPbZJuhnn+4Du4YRMc=;
	b=EK1l3yKigF352OtK4gyN6+4rO/qC2u6DhtsQuz3ZaRl7PxzWEzIwqGs2XHhwZXOwvkeW5TSGFqZeaJ+gro57gV0LruVQxnSf2S0MVf+88OmHrmbqIK5uFAeTtY2HEiPexWm4Ckq2oL98ngtGdWWXzD9bO/F3Ooxy2QRppZjY5ek=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:0a6f6e94-3b88-4d98-b805-7d144f34b03e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:6e57b688-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-UUID: d4deab2e2d2211efa22eafcdcd04c131-20240618
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1679409072; Tue, 18 Jun 2024 11:28:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 18 Jun 2024 11:28:28 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 18 Jun 2024 11:28:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSlHcf76S1T0Io2n4ABxgGi0iJqfDYaDLkHtoQPRgy8L+hubFbnE18gsobNf5PB/Krv7IQB+Cx24ZkO6DWV4njOzJZprzJgxxr0erLY10e3iFb0Wzem2/KHzENExV/if/XVNV/OXk6sW/CJznHpNTexVcqw9oQJGGau+8cAbXnu+8bpkttv1dcoDHyyUcoWZF8/SH9tou8+4NAwJLnSgyPJJufb620kxAIb8Jn0KWv3Uxu0Yr7E5593whq44QtLxOpRvJLD1rZyYzH6k/sWFsGomY0mY3rLClCEUTxbxej7oqewdOuAcn9mwgcM7UM5QLBIrmRDaWEaNj01Sk+CKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T/QDQXV8EKd9rXBD1iPrZ2aCsPbZJuhnn+4Du4YRMc=;
 b=IR05hczR+QGJw+i+F0U8wstukZcAPe8iou2EnrFn2sIO18Wfb01I4hR7NcYVumPm6Uju1KRy8XP90XN3n/aq2mjJg4Txfhn8PqEG1w+MtBQP3kDuLsahlYvPGV1T8MvyQsqfq7nkyVWjlCVfywVqUzdSIY4INUHAeIAo3r7U6IELOXG9tfO+cAxdgw/bvOmmEKUtXgZQ7Z5OySug4+t1DA+lmQhvX2NeHoEpVlAY62kVTv7wSp5Gu0qpDsiBcTVIdBlYdhc/ss9U3H+dcm1GrEvi7pkVkluAVt7oyvajctk2p9rYK8YGgZH4cubeQ8XO8yNN2MIpkdUh9GKJXF9NQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7T/QDQXV8EKd9rXBD1iPrZ2aCsPbZJuhnn+4Du4YRMc=;
 b=V6xfAwWd6kRS92eJbJ+oDi7bpkn02gBPdRirFcloGpVeaMNZQ4ba4vIQeBQA0hrObx5xoBe9em+2c/BaRvCQCzFKQzfirxSGI9VAjC6odC+eenInU3FlozN6BmWlGgvJhVGp3XWQlLnGRVhXcYWPI/ZQDT0cAYAl8luWsy9Pnrg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7777.apcprd03.prod.outlook.com (2603:1096:101:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 03:28:25 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 03:28:25 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
Thread-Topic: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
Thread-Index: AQHavaNGmeIQnKWVzkKgT+U+XkKGsbHFzHUAgAAcj4CABvrcAA==
Date: Tue, 18 Jun 2024 03:28:25 +0000
Message-ID: <47f1c2c79ad03094ebf411e13516cca47054c962.camel@mediatek.com>
References: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
	 <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
	 <44f6308379a8b6c834df6ff0604c652bf1f7a4b7.camel@mediatek.com>
In-Reply-To: <44f6308379a8b6c834df6ff0604c652bf1f7a4b7.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7777:EE_
x-ms-office365-filtering-correlation-id: e4b169af-65bf-4003-6d99-08dc8f46b6d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?aWN2aVpvQ3FqbGE3TElJTWk0NmNPbTJPOXZiM2s4ZTZRUTZNb1FjS3E0WDFq?=
 =?utf-8?B?WHNNVHlkR1ZXcmxnVHZUNGRkN2pCek5pd053RE41SEEvYmphalhQMGg3SVhW?=
 =?utf-8?B?cEVScFJSQkFWRjlZVXFJdjVDcnU5TXpGV1RBNUNFM0NPMzI0WmZTaWFLSDRY?=
 =?utf-8?B?RGJlTnBOZGh5SWQ4b0Y2ZVl2K0RJc01HaVc3TjlTYXNEOVU4cTFHNDB1RVVU?=
 =?utf-8?B?NWZrTFhHM3BYUytob1N4ZERJSTRXbWo3QW84dTRURnRZbCt1Njk3bGFVOHFE?=
 =?utf-8?B?aWU3TE9ac2NGMEJlZ0p5SXFIT2gxdWJDQjVyRDhETzg2bURHUzlKQnZhSmhi?=
 =?utf-8?B?SWhGWWVrMW8yeCsvOTVqMWZPUHJqbFNpck5mSGIrV1F4N1BSMFZZRG9hQU9v?=
 =?utf-8?B?bkFwWGNzcDcxMENEWW81ajRiSXJxZWpzckdCZS92MGhTS2pSOVFVbTlwa09l?=
 =?utf-8?B?bldvdUhJemMwQytNelNkTTkzQkh5Q2RHcjZQYkRJMnlVNWM3RkEvQkNGb0J4?=
 =?utf-8?B?RlNRNVNqalo2V3NqRTRHMUJiejl5MVdLWjl4MDhEN2ZVdjFnZ00vSDFYNEhh?=
 =?utf-8?B?V0M2cElCSi9zR2hqRzNmQVU1Ti92NHpuOGtOMmJOekV4OE9nWm8rdFRKM3A2?=
 =?utf-8?B?L3ZPbUhqaFkzYi9HYTd2d2tCbGZXYWQwcUNvNmVBUWdFdHI0QlFJMU9mR01u?=
 =?utf-8?B?eS9xRGxqWkZ4OFFaVFltcGcrS2pTNS9GcFlaZ0VuZkZINTFBRXV3MkhLTHFL?=
 =?utf-8?B?eTJXbUNDanBrN0NsNG94Y0JQZjlRNm5jRmk3dmdMbjdOYXRPK0pYeHNoa1FM?=
 =?utf-8?B?RWNWcTd1cW9NM21FUnZ2N1grdk5FZVhpMldZSUJ5OVJqWHk1R3h5aUplYWlo?=
 =?utf-8?B?ZXJTYWJiSjhJYzY0ODFDdVh3Q0dOSWsyb2pCM3MzMFlXR2cvdTBUZkVYODkz?=
 =?utf-8?B?Kyt0TGRqTmQ2UFdRK3BGbzAwaTBmbXU4ZkZUZytMSlNuT1NIazYxdXpCMkVI?=
 =?utf-8?B?WUZBd0VmLzhxRi9oNUI0M0JzMDJ2b29FWHNPaWtGR2JONmlJMmFrblptcWlC?=
 =?utf-8?B?dEFROG1KVytFL3ZRK25JVWZiU0lBdHpERXdwVVNhR0tYNEpTUFlGV2FhWmtn?=
 =?utf-8?B?WVhUNnF4aXN0a3U3K3dFdHhBRjlLQTJKVzNST3BjOWtUbGhRYm9vQk1SK3BX?=
 =?utf-8?B?RTFkWW9sTmZieEpaQVQwNG5iWWVVUUpESERMazBueUZ5YjF4WlNjWThuQ3NJ?=
 =?utf-8?B?NXdqV21GRm5RczYxaHlDSlJMNFZBSEt0aGQwMzd5YkZLbDZubW82d3ZXczZz?=
 =?utf-8?B?TTdQeURLbGk0eXdXbGV5NjBMMjdJNnFrR20zQ3dqRGVCdnM3eWlYNnZVLzkr?=
 =?utf-8?B?aUt4cWJWOXI1WDJqYkpmUGViVWh3a0VLOHN4TElwWDl5TVZ0U08rc1ZwY3ht?=
 =?utf-8?B?OG5URmVxRkNpallvU1IvYk95dGZkVGdCM1hWb1lLbm5menYrRWV0NkxKbnNN?=
 =?utf-8?B?a2hvdGtYMXJQME04VERLYkhmYU4xK0hUelpTN3JmYWpJY3AyajRENHJiTUhl?=
 =?utf-8?B?QVdzOTBiWkdNRVZkNGNQdjJQVE41SldubG9qL3dLK0txZUVQSUdhNGlYbVEv?=
 =?utf-8?B?ZnZUckF4elE4aTR1dUw3bDlXYlZoeHdHQjNaMnFQMlpOQUwvSUNicThLbWFB?=
 =?utf-8?B?VGVUcTNpTXhVbjUvTEI1aTJYL1VKTllZS1NWU0lPN2I0Mkx0aWRNRHNOdmha?=
 =?utf-8?Q?MJCqezbk3en6FWznnhKnpSbzqcAT26ZWzvOX/cU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1kxWmU0N204YjF5NmRGRHF3ekVZcUJ6N21GNUN0aHBvWFJFYXNEQlNmMGo4?=
 =?utf-8?B?b254VnU0QTI4SHo2U1Zsc0tWbGJ6ZTcvdFR0R0JpS0t1SnVPS2JOeG5TZTJh?=
 =?utf-8?B?SHlRT1VHZ3RWSS9pOXFBSU1qY3d2MWJHYkQ4cHFNOVcrMWNaSG5YL3pRczNS?=
 =?utf-8?B?WmlyTXo2bW1Wd2JEUUlaTTBuODhOQit0VUcrTVhmcHZGN0lSalNDUlNnMW93?=
 =?utf-8?B?TUNkNEp3akdKWDZYRXhEWDlFaTR4MjAyMXNHYW1iZHRiNHN0Y1VoWWxNZHRh?=
 =?utf-8?B?bWQ4Ynl1MDR3TzBJNVArUHNjS0ljajNYVXZHbkFQTkc0eXF6NXd2Rkdxb2xu?=
 =?utf-8?B?c1RiU1B5Wit2aXRQa0h4SW9XNlBJNytpRGk2U1ZoOVBmTXVRdVBESEdjOE5z?=
 =?utf-8?B?NkEyQXRTOTBTQ1hBLytscDZhU213bm14MW03WTV4WFBheGk5eFJaSkducjhn?=
 =?utf-8?B?dDNIMGlHMDZWeExxR0tiSkp3b3dBVCtQNkt5M2lFdzB0ZkIrNXc3UDQ4cXVv?=
 =?utf-8?B?SE9LMVUvcEg3eXlSUkI4SFhabXIxeGJWak9Tc1QxOTdGSzVONXYwVFZGdGhm?=
 =?utf-8?B?RDVNb0g5dnVaTkVHWjVJUGRlaDkrRDkxbkFCVWRIWUttUFR5dTRmOS9MSSs2?=
 =?utf-8?B?UkRsdEozVExWWG1qWExVV2lhblI1WmZYam8rT0RjRDZsRDNIdk5VRVU4WU54?=
 =?utf-8?B?RndjTjJhODhIY0hZalQrYmJZSFp3c0NjVmxJakJWb2VVT01zZElXaDZYTk9Q?=
 =?utf-8?B?VnNvTjJPUmRSb0RFb0R1YVZXVmE0NloyNlZJSG5RY1VTdUQ2SHNoUmtNdEJE?=
 =?utf-8?B?VTA2RS9MMmpnbmc4SmZSZEluZlIrYklnVlVmOUVadWgrYkxFNEJmVkMwSDJL?=
 =?utf-8?B?QU1wRzZyemtZc1d4UEdMeHJpRHc4UXRHS1VsTFFFVUs4ZjlQSWpiQ2JZT0sy?=
 =?utf-8?B?Q2ovZFlDa3RlMXpKOEs5UTkzZ25DTDd3SFBESkJoWVUxUXNOUkxseW9JUWt3?=
 =?utf-8?B?WUdkekNoWHViQmpRNFBnMWc4eXB2MEV3TytDZmZLMFJNcFcyU2FnTFhmNFRM?=
 =?utf-8?B?S3puK000WHJWbGdDcG16RDBtUWVLZThOdUxvSnZzOXJaTGp0WlcxUHo1Y3Jk?=
 =?utf-8?B?ellwdWI2Kzlxd0tTZkpZczNPK0JKY1VxRlF0VkcrZ251NjZXUVdkYURmNGxT?=
 =?utf-8?B?QU1mdFpaRHdTYWpkcE43YVFXNTgxSXVRc0ZrNGEwTCtQYk04OWRQdDBEcUJG?=
 =?utf-8?B?cHc5TEZ5RzVVdVFVc2ZmdmJ4ano3ZE9WdTZDOFR2dHNyQThXT2gvOGpxR0RB?=
 =?utf-8?B?MXFCNDJoQ1FIaVRxMEtpcjZXbW5kYTExYkNxLzZsblVyZkZtQzdjeGYwaW50?=
 =?utf-8?B?ZW5DRkRxYW5ZcXhRSVJ6VnFXeFpWYkdVNlNqTEg4ZkxFYWpaQ1JHNGFKRW1L?=
 =?utf-8?B?Y29yYVBWS1FwV1BBclg1Mlc1VGtXZXMwK096MHM0dEJ0NXNsT0pmUzN2TEJC?=
 =?utf-8?B?bDAvTThWZnVzVnhJMlpJVyt5WWJOT1RYT3ZDU3Zyd01WSVhlOFJiV2E2cVhq?=
 =?utf-8?B?d09NRWhYUmloOGkzSmo1elRHcWhVcjgvZ2RwWjhwYStNaGVIVWFjTUNSNHJw?=
 =?utf-8?B?Wnc2MFJWSGRGNlp1NEIzQzBRUWQvU2c0ZUU2YlhMQTROdU5BTHhTbkpMSVYw?=
 =?utf-8?B?Umxoakt6VHlaT3dUcFNPZHV1aUNvMTFtSlZtMmQrek1GUTkrb2NhZUR3UWpT?=
 =?utf-8?B?NlJrQXdvYStVY2FlNDBPMHFib0ZmcmI0NFBacmdUWVkwWDQzRWtYT3JJdzBF?=
 =?utf-8?B?L29hU2xmMml5cm9nZ0NDZjJmTitqRG5MeHo1ZWFaaEVLTDRuZzVYem1sSVd3?=
 =?utf-8?B?dEVtaVZNc1JTcUpxVUxmY2xocGpOOENPRHRlWlJVQktONlhLSitjdlZiLzdQ?=
 =?utf-8?B?SWI3SW9PenQ3YTNnVjNxb1pTQ3ZJZWg1T3VXQWo4Zi9PL2s1bXp5ejBtWTFF?=
 =?utf-8?B?VmJudXhYYXB0V3hzNmdqMzFtZmFOamxWM1NSWklwQll3MERrblR6UTdLZWpn?=
 =?utf-8?B?M285aUdmUHVOVkhGWURKekgwMTZNTHlnaHRra3FsNWU3bEN4dlcxdjczdFI4?=
 =?utf-8?B?SGUyVGkyU0M3dFRXY0lFdjBqUHNoVmxoRHJsVmU2SHZmdE9FNHN0dXYxVEl4?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47F6E52CBBDFD4469359D2C467E44DFA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b169af-65bf-4003-6d99-08dc8f46b6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 03:28:25.7594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wIIEPslgsneXmaMUGiveAjmm48fcV7FBauI/sDzifYwrZgnc63lGCA8mUD7/Usifb31cskrX8nQZv/PTr9p1X+csvYo2VrUgpkuKQ4Megw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7777

SGkgQW5nZWxvLA0KDQpPbiBGcmksIDIwMjQtMDYtMTQgYXQgMDA6NTIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gSGkgQW5nZWxvLA0KPiANCj4gT24gVGh1LCAyMDI0LTA2LTEzIGF0IDE3
OjEwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gPiBJbCAxMy8w
Ni8yNCAxNzowNiwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4gPiBBZGQgdW5yZWdpc3Rl
ciBtYWlsYm94IGNvbnRyb2xsZXIgaW4gY21kcV9yZW1vdmUgdG8gZml4IGNtZHENCj4gPiA+IHVu
YmluZA0KPiA+ID4gV0FSTl9PTiBtZXNzYWdlIGZyb20gcG1fcnVudGltZV9nZXRfc3luYygpIGlu
DQo+ID4gPiBjbWRxX21ib3hfc2h1dGRvd24oKS4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IDYyM2E2
MTQzYTg0NSAoIm1haWxib3g6IG1lZGlhdGVrOiBBZGQgTWVkaWF0ZWsgQ01EUQ0KPiA+ID4gZHJp
dmVyIikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1l
ZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBIZWxsbywNCj4gPiANCj4gPiBJIHRoaW5rIHlvdSBmb3Jn
b3QgYWJvdXQuLi4NCj4gPiANCj4gPiANCj4gDQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzZmY2Q0OGIxNGU4NjVjMjVlNmRiNzU1OWZlNmI5NDY1MzdiZmEwY2UuY2FtZWxAbWVkaWF0
ZWsuY29tLw0KPiA+IA0KPiANCj4gSSdsbCBzZW5kIHRoaXMgc2VyaWVzIG5leHQgd2VlayBhZnRl
ciB0ZXN0aW5nIGl0Lg0KPiANCj4gDQo+ID4gLi4uYXMgdGhhdCB3b3VsZCBhbHNvIHJlc29sdmUg
dGhpcyBvbmUgd2l0aG91dCBhbnkgaGFja3MuDQo+IA0KPiBJIHRob3VnaHQgaXQgd2FzIGFub3Ro
ZXIgcHJvYmxlbSwgc28gSSBzZW50IHRoaXMgcGF0Y2guDQo+IA0KPiBBZnRlciBsb29raW5nIHRv
IHRoZSBrZXJuZWxkb2Mgb2YgZGV2bV9tYm94X2NvbnRyb2xsZXJfdW5yZWdpc3RlcigpLA0KPiBJ
DQo+IGZvdW5kIHRoYXQgaXQncyBub3QgbmVjZXNzYXJ5IHRvIGNhbGwgdGhpcyBhbnl3aGVyZS4N
Cj4gDQo+IEknbGwgZHJvcCB0aGlzIHBhdGNoLiBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCkkg
Zm91bmQgdGhhdCB0aGUgc2VyaWVzIG9mICJNb3ZlIHBtX3J1bmltdGVfZ2V0IGFuZCBwdXQgdG8N
Cm1ib3hfY2hhbl9vcHMgQVBJIiBjYW4gbm90IGZpeCB0aGlzIHVuYmluZCBjcmFzaCBpc3N1ZS4N
Cg0KSXQgc2VlbXMgdGhleSBhcmUgMiBkaWZmZXJlbnQgaXNzdWVzLg0KDQpTbyBJIHRoaW5rIGNh
bGxpbmcgZGV2bV9tYm94X2NvbnRyb2xsZXJfdW5yZWdpc3RlcigpIGluIGNtZHFfcmVtb3ZlKCkN
CmNhbiBlbnN1cmUgdGhlIENNRFEgZGV2aWNlIGlzIG5vdCByZW1vdmVkIGFuZCBiZSBwYWlyZWQg
dG8NCmNtZHFfcHJvYmUoKS4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IA0KPiBSZWdh
cmRzLA0KPiBKYXNvbi1KSC5MaW4NCj4gDQo+ID4gDQo+ID4gQ2hlZXJzLA0KPiA+IEFuZ2Vsbw0K
PiA+IA0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94
LmMgfCAyICsrDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiA+
IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMN
Cj4gPiA+IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ID4gaW5kZXgg
NGFhMzk0ZTkxMTA5Li4xMzk5ZTE4YTM5YTQgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5jDQo+ID4gPiBAQCAtMzcxLDYgKzM3MSw4IEBAIHN0YXRpYyB2b2lkIGNt
ZHFfcmVtb3ZlKHN0cnVjdA0KPiA+ID4gcGxhdGZvcm1fZGV2aWNlDQo+ID4gPiAqcGRldikNCj4g
PiA+ICAgew0KPiA+ID4gICAJc3RydWN0IGNtZHEgKmNtZHEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0
YShwZGV2KTsNCj4gPiA+ICAgDQo+ID4gPiArCWRldm1fbWJveF9jb250cm9sbGVyX3VucmVnaXN0
ZXIoJnBkZXYtPmRldiwgJmNtZHEtPm1ib3gpOw0KPiA+ID4gKw0KPiA+ID4gICAJaWYgKGNtZHEt
PnBkYXRhLT5zd19kZHJfZW4pDQo+ID4gPiAgIAkJY21kcV9zd19kZHJfZW5hYmxlKGNtZHEsIGZh
bHNlKTsNCj4gPiA+ICAgDQo+ID4gDQo+ID4gDQo=

