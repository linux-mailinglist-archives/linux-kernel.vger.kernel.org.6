Return-Path: <linux-kernel+bounces-417815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8B29D5961
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB1D6B23074
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49B16BE01;
	Fri, 22 Nov 2024 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R0VUByKT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VdiTiIgV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D2315E5CA;
	Fri, 22 Nov 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732256636; cv=fail; b=Vr42gzTDxIH/gNNVNh+rr43c1hKhitpoAijej38Ih78zof4S4UHRFhwKm2OeI8YJTxjEpXjorG9YLpmBWnxt4iP3w4WxmFRIDbtpr+TpG7nX3nv5SKY6KyfZ9qKWf+hq7bwS25ZsacC4vhMYvP4utCO5CYJ+aepxNLU6s9zdu90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732256636; c=relaxed/simple;
	bh=Ag0UBY51W+tPag8NIYCQHY7lo7hvQd5UpkzLdja5voo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WqT85gcNI+UC/u66zVJ2HUWjb57igLBH3bTKrcSF8e5kon4JiJ9adYGffC25rBrz5hYaS3Cs912WlYvGvIuS2zD+XsIC1oaybiulF24DWevmU5GbLph1c/MQ2QJg5X6oixOG2pc8PHZo8eIpTbu9KIW7qIQ0HRAGeMV+Gpv8tyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R0VUByKT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VdiTiIgV; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 55c0633ea89a11ef99858b75a2457dd9-20241122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ag0UBY51W+tPag8NIYCQHY7lo7hvQd5UpkzLdja5voo=;
	b=R0VUByKTpE9t7LtP1GtDwgXMKK+BR860NsGRyvoDOLmBS7Ca0nPcddPW4DC3XOnxkwc0NWZZC+pdtSpQynp4r5YUn+YnMd6QfYTiNB1MLjMhdGzyV0cnD/iA+7UJON4lXCYfkI4ydb1SeTLA1VNgmGSIYiRE4x/naiPcWl9jxg4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:de5e0e83-eb12-4bdc-a0af-91d3033af6cb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:5e7ca0a0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 55c0633ea89a11ef99858b75a2457dd9-20241122
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 503818164; Fri, 22 Nov 2024 14:23:48 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Nov 2024 14:23:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Nov 2024 14:23:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxE1QpuC1IYftUWFD9HGNc+qR5o6geDalYiQVz3rp/r4rAXtMrlHG9UVWNhgLeu53CCG5OAfTHYmd2KvrIr6mqYlZ38ADqPwQl/AZYc7JlM8zNy9o287DMLOgfnxpiF+PSQWVIglETUf6kvbwMIlxhuZvmYgFuE6q6OpsQkPKKwEb9QKrKdH4P3sxKHoGJR8GWTbFzK2HhRswJBs3/Ee64mjkdUNGDevRjWVCe0CYU1d8OtdDwApBjkt8uWv8E3RQwEHUW/FEFfmKeNj/0Em/CyeUgxgH02N5z4Lr1OMToUCzl7LTvoVlWmkgyHPGbxjMn9DmrAgZx2Ap9HM7f1D/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ag0UBY51W+tPag8NIYCQHY7lo7hvQd5UpkzLdja5voo=;
 b=n9RW6irYsmIOXg0107VVerEYB48e5nSWAYApwvA+LvUW0iIwDjk6jtZnLoJecWOBKh5/Fx0SAOueGRenkm6aeHYbp1lPhu/fs78mlaMldi3eRoLF27gXeNZGyb+b0mcjutcEQAk8KqHvhU+V8ShHFITnGS74TuCepFnod1Ex1IKQvqqVNOIwKOodWBUaDBTZy32YS/H0T/uF3nGsdl1fiU/Np4QsesqZGzJa3bJuuh6u4P2+3Mof1584iWD2LglIjnflgDayWCZaGKeliKPUoIl2/tJcl9wJirJkQPcyUw2gfoKipRM039FogObMdtaJvuJhu3VePfcKjA789oUi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ag0UBY51W+tPag8NIYCQHY7lo7hvQd5UpkzLdja5voo=;
 b=VdiTiIgVpRk7FkzzmQwAjMQ1f4r8J910+krK6DKNf2LZof+v5SgClqlvzqcfl9L0qhC1r4Xs1X1OfHmc4dm1KbNgeiWnb2xjTdVk3OBHnn2M1zqNSRPOliMEvaKJtqUSN9MXg9HlNHjLapTuBSIKE3Hajjgo65zpjB2d9rwp/3s=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by OSQPR03MB8673.apcprd03.prod.outlook.com (2603:1096:604:298::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 06:23:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8158.017; Fri, 22 Nov 2024
 06:23:44 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"kernel@collabora.com" <kernel@collabora.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 3/6] drm/mediatek: mtk_dpi: Use an array for pixclk
 factor calculation
Thread-Topic: [PATCH v1 3/6] drm/mediatek: mtk_dpi: Use an array for pixclk
 factor calculation
Thread-Index: AQHbO0ovL6/Z3MShYU+XiLxJngQ4cbLCrdsAgAApuIA=
Date: Fri, 22 Nov 2024 06:23:44 +0000
Message-ID: <120c65e7c21821a72fa5165e578cc1c39cf0c864.camel@mediatek.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
	 <20241120124420.133914-4-angelogioacchino.delregno@collabora.com>
	 <6e07043e70111920848cc3d22e5c60371c0fb65d.camel@mediatek.com>
In-Reply-To: <6e07043e70111920848cc3d22e5c60371c0fb65d.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|OSQPR03MB8673:EE_
x-ms-office365-filtering-correlation-id: ef805277-c220-49e5-9d06-08dd0abe3723
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MjZYeUtKTGUra3lzL3hVdVo0VGgvV0Znd2hGVVhYM3g0UnlOZVhKbGtPYnpO?=
 =?utf-8?B?alBGNXcrQ25sQ3BjNkh5dDhjQVFmYlNRMEMvRURhQ0tKbm9uZGdFTDhsTm5I?=
 =?utf-8?B?RnhsbmZFTk5yQ1NUNTVVaWVob2ZVL3UzQ3JNREwxYnFFUVc0bmNNVmc5dE45?=
 =?utf-8?B?M3R0dlZnV3N0aUhWOUtGaVBvR3Z3cmkvSTN6dE9WdXRXbDFkdzJSWllXTXZC?=
 =?utf-8?B?ZWZKdnJGZnhDa1VyMDB6QUsxbkRuQVB6Nm9LaEZuajJWMEUvRGMwOHczdlQr?=
 =?utf-8?B?RlVKOFBwUGgySUNxVjRHdWxJQUE5akIzQTBNQll2L2RUaE9yaFhOWjQ5RXhP?=
 =?utf-8?B?ZGNtY0sxbjF4dGlzNjR2T2VNc1ZIMXBRWEY2czBhckVmM2F5RXlFV1F1UWZE?=
 =?utf-8?B?MnNCVTRndytMbWtycDEvLzFBOWhxRnFJQkQxRmxSZEZxQTZqNFlQYll0SW1i?=
 =?utf-8?B?VjFRMHhsYkg5eDVEYlM2REdlTVJXQUl6Y2dqTWVlZ1RsaEUvV1lnSzg3ektS?=
 =?utf-8?B?bFQ5cUJrS2ZjYVl2TmFleWNZVElqS01zUVpCMkNHVGZLRGFrM1NyWERVSE1J?=
 =?utf-8?B?RzZ0SXp2aDdtaS9ZeGQvU2lacnAzcDFnZ25uWmJDTGlFemlQak9ZNWwyckFE?=
 =?utf-8?B?Qk5mNzdadUthRTQrREtUS0Q1SHJONzM4R3ZoVUx1c3pOc1F3N3FBWFFYVEVJ?=
 =?utf-8?B?N1pwbnNvSmZxS1N5ZW5IT1B5TDFvdmorUWVvMVVmbVNwaXNFT1N0WjZjdmpQ?=
 =?utf-8?B?M2lLV2ZpZGtuRzRPTm8xLytCNlZ3OVF2RktmZkt5enNPbnZ3U0x0c3BuME1K?=
 =?utf-8?B?ZlJ2Q0YvRXZRSlNLV0M2VUdjaGFZdEp5YURZaCtaZUZpZnNlQW5KUlA0UFNI?=
 =?utf-8?B?SytkRjlMMm1UbWZSK0FOS0UzY2ZrRHlKMUxwcnZXY1VDZmU0aDVZTHVWZFI2?=
 =?utf-8?B?cGVMcnFSVlNMTDFHZEZYenFuYkQzaERHYnZOaHhIelowZko1enZwVzlVQlRI?=
 =?utf-8?B?K2pQdUxjbFFDQUVoeDdWSjlUaXhtZHFlUmtZNTRZb1ZzWVVBbTJKdTRCWHhB?=
 =?utf-8?B?di9wZTVLLzFXWkhOSHowQkY1Q0kyL2Y4SFVLZVBzVExlekl5OFhkdm5sbytV?=
 =?utf-8?B?a0RnUGxpekFZb2F1YVRuSmEzcXo0UnVBemZIOGEyd291UTdDUmgvbk1tU0ZJ?=
 =?utf-8?B?NWhKUDg5RGlzeE1XYnFEdG04dnljWHJMVGtpQ3J5UmhzdlI2WkEzZlhGSUxw?=
 =?utf-8?B?cDUxRUIwL0RsV2E2RTQvM1AySHFwTGIyUmowNVRVUWl1bkxPMlF4UnRHeFhz?=
 =?utf-8?B?UUlHT3RSZ0FCSEFpRkwxdFpibFBxUnh6d0pMbjVBUERYVWNqenVhWE9lK2x0?=
 =?utf-8?B?TDN3bldGTUVjekFPOVhPeHNKazg5bC84dXllVktBQjNuaEc4Z3p1QzZERCtM?=
 =?utf-8?B?QkNuUmN0K1QzbEYxb0VjVHZsOTdEN1ROZ1J4RUZsaTRHenl6K0UxbW1JcWc3?=
 =?utf-8?B?R1NibkIzT1FxcjFLRDJWeHFsM2NlQmtkOUpDNnJ6cENlUnJuc0RwRUpyd2ho?=
 =?utf-8?B?YXYvd2ZwT3FTbjFuWE5aRDlYdVg4V3M0T21paWo3UzdOV0IwUnZnb2FHd1B3?=
 =?utf-8?B?YmF0R1lNOUZtQ05yT2lTeWFHZWhWS0FNSG0zazlobnRFTjVqNTVXYmJQMFUv?=
 =?utf-8?B?VHErQzdaWHlHc2NRdTBuUmExWEJhMzgzNHFxQ0VtOFUzNVVQM1dqaHFmWEtn?=
 =?utf-8?B?WThkQktFMkY0UDJBRXFDTFRTc2FhK1ZUVTQxQUVDRlZGR2dvYVowUVFTSzlq?=
 =?utf-8?B?SDV6WGJONlo2bFJyUDRCbEJBeXMxeEp2UmdEQ0hTSHhnck0zKytPejRmc2Qw?=
 =?utf-8?B?S1pBTlM0WkErSGY3MnA1eVJzK0luMUVNT2NZYXdSMFlFYmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjhsWVhhVkJwRVBsSHRCeERLQ3MzVEVNVFBPV3RTdEN5dW1BVC9CSmFrWFVT?=
 =?utf-8?B?RGlKZlBpTGR0ZVVncUp0OGJBMXFPTVJUVFgxeUN2ZDdZb25CcUMzTDQ1anhT?=
 =?utf-8?B?eFhzWnpNa242dGJtUkZWQUwzcUpzMkJJMVd0WkdYTGNoMUlEejIvOHFHUkJG?=
 =?utf-8?B?UlJLSUFLemtmNkp4b3pKOWxTS3dIRWdXd0pueTErZWlybS9IZERDdy9FRGhC?=
 =?utf-8?B?QnB2RVZnTUx5Q1d2R0R4TnFGWFZKMkxtc0VINGUwdlh5NzJqS3ZlM2tjMEVP?=
 =?utf-8?B?TDRpMnIzN1lKSmE4RkcwWDZLMHZXODNLWWRsSUdJUEpxTWs4RElkWkFlN1VI?=
 =?utf-8?B?RmNXYjNkbVFnUFVuVEt2R0xmaEJvdGRCL293djBXUUwvaUdkYzYyVVJDRDdl?=
 =?utf-8?B?TmJIbFFadUZMK0NDVFZsRVEvcmQrUGx4NVhJcGJaZ3dkekdUNlRTVEpLVTc1?=
 =?utf-8?B?ZTNtZktRN1dBY3pLemdmQ0g5N25BMlV1ZjlTVFZWWHQrdVQxLzdmbzRLcXJY?=
 =?utf-8?B?eVlOYzBWN2UzNkdOWFZtN0FjUzhSbkNzV0JGV2VqVGlCK0lZMmF0ZFQyTFpi?=
 =?utf-8?B?aG5TNjEvMzJqZEFQcFRWemYyMi8zZTAwdytqS3VHT2ZTZTRyYVpORzlFWHlD?=
 =?utf-8?B?ajVzeWdMQi9BS0FGVGlsQjR1MktzUGwxYUJWMjNOVDdvRXJySFJOdkVpVXpq?=
 =?utf-8?B?WUdSTmFKaytIdTRJb1hNMHcvdjhFUTRucE5EM216bXRMYjBubTB2eklNU2Z3?=
 =?utf-8?B?eEVKMEw4Y1p0OVhFeDc5SU8xZytCanFSV2lLOXpiU1ZIWFdGWDc5dEtnczJm?=
 =?utf-8?B?RDRHUktoMFJ4ekFXUk9JNUJ5V1ZZZ0dyOHBMQUxyQ0haSWN2VWJqd1NWMURE?=
 =?utf-8?B?RkgvbU5TbEVlRlowN0xqdUYxTFpjcEw0NjBNMFNsWGJBNEQ0T20vdDhUNDFu?=
 =?utf-8?B?YTRuM0xocXd1Vk83TjNCdkd2bXJFLzRPdzRXL2JwSk9ScDJDTHlUYXFzUXR3?=
 =?utf-8?B?REFiQWEwd3VYSktNRDdPbXdacHlKUk9HSWZiakVzVEcvWkNCYzZYL3Q4bUgx?=
 =?utf-8?B?R0ZCZ1czZnBZWkNWSUxJYWVldklhU2QxTHY0NEdMTGJmSnVpTHU3Y0RzYW9O?=
 =?utf-8?B?NkhTUVBxWFNaaEw4ZHZsT2VsZlZTWHI3ZlU2T0x2eE1XWmEzRnBKRjdIUlNz?=
 =?utf-8?B?ZkxPU3BDT0J2OE5KMzlkL3lHVUVMckUvOUUwWHZIenRqMm42UEp3YUUrVTE4?=
 =?utf-8?B?SHRueDViaE1iMHh2bXZLN3ZSLzV6dm9qRUJSVUV2SFp3bGNqSDVNaFg3R2VF?=
 =?utf-8?B?cldDSWhabll4UWlTZUI3VnljWVlmdUhZL2lSckxMdVJ4VTNRR2lkWFJyL1Q2?=
 =?utf-8?B?ZThJRFdRdG1JS3kxQlhoUHBSLzRLTjV0SDgvMzNSNFlqVU95L0l4MnVLSGZv?=
 =?utf-8?B?OW1WTURNS1BmUDRwMEJXRlZ6Si9zeUJGY3RhbE4xa01HWnpwRG1hMyswQmR2?=
 =?utf-8?B?dUV4YmhtQS9wZXp6NjdmU0J4Um1OZTBNaUE0UWY1Wm1IUU5abDhUeTVONjVN?=
 =?utf-8?B?dVVwNlhIN3M4RUJmTzQwN1h6L1pJMzU1c2F0SlA5YUIySjAvUWpwbUc1eEJh?=
 =?utf-8?B?eDBGRzJIOHNPYy9oRWtSaGZYT0llVlV4Z2xXdzBoZ2hvVm5ybUhINFRzdzIr?=
 =?utf-8?B?cHM0cXJ2cHcrLytIU0pPWHlLMFRMR1BqTVdjdXR5L3Qzb09lbjdCOUNUMFFy?=
 =?utf-8?B?a2wxeUJHT2dTRWdQRGl3Y2kzRlZEM0VNQVdMdWlpVU9TdUhSbHpQTXorU2Rs?=
 =?utf-8?B?WEV6Z1EwZHY5NGdmUTFScTVVR2tqcW1jRTNOTVVKSUMxTzNwWEdPR3dEb3F0?=
 =?utf-8?B?VzJtaDlZamtXVThlOUZmcENPWVJVTU5zTWFaSnA5bWJhS0liUCsyd3EwVTBz?=
 =?utf-8?B?SUpxejlkMGhpL0h4UmhOcXRKSmdDbEFBZGxBdjNLOG15NFZXWlg5bmo1NVZk?=
 =?utf-8?B?VGkxRDQ2UzdVMVJMcXU5bDQzS0VoS2ppYXdRcno0WE5Dc01DRkJZNkxjSDkw?=
 =?utf-8?B?dVc4dXIrMkRHc0owVXhTcVZnV0I0TFZiVU1wM3haRnJsNnVDK2ZPRDROUzZR?=
 =?utf-8?Q?mjDjyRoJGTuuS3D005Fu+ndcP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C06D2C741F4E0E418E64A43BE697164B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef805277-c220-49e5-9d06-08dd0abe3723
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 06:23:44.1569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vrCNiONDna/hTcxRZGw6BhtZfdhvKF4nsY6GwFrTbwQrMLJkZTy7cm3mcTZfBjUZG8slPcD7yYFpN6QKCkp+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8673

SGksIEFuZ2VsbzoNCg0KT24gRnJpLCAyMDI0LTExLTIyIGF0IDExOjU0ICswODAwLCBDSyBIdSB3
cm90ZToNCj4gSGksIEFuZ2VsbzoNCj4gDQo+IE9uIFdlZCwgMjAyNC0xMS0yMCBhdCAxMzo0NCAr
MDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+ID4gRXh0ZXJuYWwgZW1h
aWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwg
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiANCj4gPiAN
Cj4gPiBTZXR0aW5nIHRoZSBUVkQgUExMIGNsb2NrIHJlcXVpcmVzIHRvIG11bHRpcGx5IHRoZSB0
YXJnZXQgcGl4ZWwNCj4gPiBjbG9jayBieSBhIHNwZWNpZmljIGNvbnN0YW50IGZhY3RvciB0byBh
Y2hpZXZlIHRoZSB0YXJnZXQgUExMDQo+ID4gZnJlcXVlbmN5LCBhbmQgdGhpcyBpcyBkb25lIHRv
IHJlZHVjZSBqaXR0ZXIgdG8gYWNjZXB0YWJsZSBsZXZlbHMuDQo+ID4gDQo+ID4gT24gYWxsIE1l
ZGlhVGVrIFNvQ3MsIHRoZSBmYWN0b3IgaXMgbm90IHJldHJpZXZlZCBieSBhbnkgcmVhbCBraW5k
DQo+ID4gb2YgY2FsY3VsYXRpb24gYnV0IHJhdGhlciBieSBjaGVja2luZyBpZiB0aGUgdGFyZ2V0
IHBpeGVsIGNsb2NrDQo+ID4gaXMgbGVzcyB0aGFuIGEgc3BlY2lmaWVkIGZyZXF1ZW5jeSwgaGVu
Y2UgYXNzaWduaW5nIGEgZnVuY3Rpb24NCj4gPiBwb2ludGVyIGZvciBqdXN0IGEgYnVuY2ggb2Yg
aWYgYnJhbmNoZXMgZG9lcyBlbmxhcmdlIHRoZSBjb2RlDQo+ID4gc2l6ZSBmb3IgbGl0dGxlIHJl
YXNvbi4NCj4gPiANCj4gPiBSZW1vdmUgYWxsIFNvQy1zcGVjaWZpYyBmdW5jdGlvbnMsIGFkZCBh
IHN0cnVjdHVyZSBgbXRrX2RwaV9mYWN0b3JgDQo+ID4gdGhhdCBob2xkcyBhIGNsb2NrIGZyZXF1
ZW5jeSBhbmQgY29ycmVzcG9uZGluZyBQTEwgZmFjdG9yLCBhbmQNCj4gPiBkZWNsYXJlIHRoZSBj
b25zdHJhaW50cyBmb3IgZWFjaCBTb0MgaW4gZm9ybSBvZiBhbiBhcnJheSBvZiBzYWlkDQo+ID4g
c3RydWN0dXJlLg0KPiA+IEluc3RlYWQgb2YgZnVuY3Rpb24gcG9pbnRlcnMsIHRoaXMgc3RydWN0
dXJlIChhbmQgaXRzIHNpemUpIGlzIHRoZW4NCj4gPiBhc3NpZ25lZCB0byBlYWNoIFNvQydzIHBs
YXRmb3JtIGRhdGEuDQo+ID4gDQo+ID4gVGhlICJjYWxjdWxhdGlvbiIgaXMgdGhlbiBwZXJmb3Jt
ZWQgd2l0aCBhIG5ldyBzdGF0aWMgZnVuY3Rpb24NCj4gPiBtdGtfZHBpX2NhbGN1bGF0ZV9mYWN0
b3IoZHBpLCBtb2RlX2NsaykgdGhhdCBpdGVyYXRlcyB0aHJvdWdoIGFsbA0KPiA+IG9mIHRoZSBl
bnRyaWVzIG9mIHRoZSBhZm9yZW1lbnRpb25lZCBhcnJheSBhbmQgcmV0dXJucyB0aGUgcmlnaHQN
Cj4gPiBmYWN0b3IuDQo+ID4gDQo+ID4gSWYgbm8gZmFjdG9yIGlzIGZvdW5kLCB0aGUgbG93ZXN0
IHBvc3NpYmxlIGZhY3RvciBpcyByZXR1cm5lZCwNCj4gPiBtaW1pY2tpbmcgdGhlIHNhbWUgZmxv
dyBhcyBhbGwgb2YgdGhlIG9sZCBwZXItU29DIGNhbGN1bGF0aW9uDQo+ID4gZnVuY3Rpb25zLg0K
PiA+IA0KPiA+IFRoaXMgY29tbWl0IGJyaW5ncyBubyBmdW5jdGlvbmFsIGNoYW5nZS4NCj4gDQoN
CltzbmlwXQ0KDQo+ID4gIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVj
dCBtdGtfZHBpICpkcGksDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGRybV9kaXNwbGF5X21vZGUgKm1vZGUpDQo+ID4gIHsNCj4gPiBAQCAtNTI5LDcgKzU1
MCw3IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2RlKHN0cnVjdCBtdGtfZHBp
ICpkcGksDQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgZmFjdG9yOw0KPiA+IA0KPiA+ICAgICAg
ICAgLyogbGV0IHBsbF9yYXRlIGNhbiBmaXggdGhlIHZhbGlkIHJhbmdlIG9mIHR2ZHBsbCAoMUd+
MkdIeikgKi8NCj4gPiAtICAgICAgIGZhY3RvciA9IGRwaS0+Y29uZi0+Y2FsX2ZhY3Rvcihtb2Rl
LT5jbG9jayk7DQo+ID4gKyAgICAgICBmYWN0b3IgPSBtdGtfZHBpX2NhbGN1bGF0ZV9mYWN0b3Io
ZHBpLCBtb2RlX2Nsayk7DQoNCm1vZGVfY2xrIGlzIGRlZmluZWQgaW4gbmV4dCBwYXRjaC4NCmtl
ZXAgbW9kZS0+Y2xvY2sgaW4gdGhpcyBwYXRjaCB0byBrZWVwIG15IHJldmlld2VkLWJ5IHRhZy4N
Cg0KUmVnYXJkcywNCkNLDQoNCj4gPiAgICAgICAgIGRybV9kaXNwbGF5X21vZGVfdG9fdmlkZW9t
b2RlKG1vZGUsICZ2bSk7DQo+ID4gICAgICAgICBwbGxfcmF0ZSA9IHZtLnBpeGVsY2xvY2sgKiBm
YWN0b3I7DQo+ID4gDQo+ID4gQEAgLTk2NCw0OCArOTg1LDYgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBjb21wb25lbnRfb3BzIG10a19kcGlfY29tcG9uZW50X29wcyA9IHsNCj4gPiAgICAgICAgIC51
bmJpbmQgPSBtdGtfZHBpX3VuYmluZCwNCj4gPiAgfTsNCj4gPiANCg0KDQo=

