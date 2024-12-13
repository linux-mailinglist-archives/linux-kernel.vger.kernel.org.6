Return-Path: <linux-kernel+bounces-444323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C96D9F04BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47AEA28135B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0880318C91F;
	Fri, 13 Dec 2024 06:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="k13780k2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="R7hXByuQ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB7718A92F;
	Fri, 13 Dec 2024 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734070981; cv=fail; b=R+1V2w3t7NmUYEI7oXNY3IG7+chDiyFb/8KuaLtOp6DOECGC+9YxLZZlf6mRopvDtY2ozwCrhqfaHG7nHek2940YyuoHvOc5XJXQojAg5iVMSw3Gef7U2X4Xlm4WIk+mKw6vbaHN8Y5lHHovJfbbdN41cCQzMiyzZ5RSTwuLFro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734070981; c=relaxed/simple;
	bh=rD/vmkxm4rgL5fs+2SenlgZmTHmac9TJQ0vMlkW7woU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ng9t1dc5VYOV+CZBLN1RBBtHvFVISPz+7mwNUK5c4sKNYEHzU2Vg87tvqqps0HkW17EYo9fSzOj+n6b6Yuv9qJfRdH7dkDQFeUj2m8R1iGgUe1NfYgBxbvQQteaZUUV7ESSsEhwOXdZW0o8TCPHg7pa6Y6ucMcQs/5wCY0tvUto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=k13780k2; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=R7hXByuQ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ae643cdcb91a11ef99858b75a2457dd9-20241213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=rD/vmkxm4rgL5fs+2SenlgZmTHmac9TJQ0vMlkW7woU=;
	b=k13780k2PpunzYZu8SSiaYIbbVg/R1LTIYmApKoyyyPM56Ye5ts+hosovyMK9wXIfVOyu44fdOPepXh+f0K62pCHxF71f5wfsRCPVJqrSCTrZwfyzSW0tXGa/zQOmBQTbFRH/20CkJkaAWz4GGe5jP5VvNsnbgFemkgw6p9uuW0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:5b6adbaa-c750-4536-abe4-08dbfef3c58b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:7c317528-d2eb-4de2-b5c9-495d1bc17256,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ae643cdcb91a11ef99858b75a2457dd9-20241213
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 971740180; Fri, 13 Dec 2024 14:22:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 13 Dec 2024 14:22:50 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 13 Dec 2024 14:22:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAJ+RLKctwGrY+E3QZ51g6edlK96Z1Izj+3DjCTUlotlskEPxdEIS4K1a4S7GCURQieKcq3+u76dZXhTXjd+D1uyHLppX8D9Y4D6zKn3Dtzq0PHJfhB0PqxbjnaI7FS+/F2UTx3zubbMcnzClBDFbj+fLEh6V1Ejlq7lojmTfHziFljlBmYU7zjnus8e8A7dD3Qk9hBfPqWLnTtVXEfx++QTDrJzUbhWFkSZ7GHQNSF19fxjKIRg38ZvPQf9T/ULWyBeYaeSSO22clU0+6SF5FdLH9q1FisGwEgwyDpsZj5IgABCCdqCey8z2TtTQgXPVQx1AV43kLiOQdMrxWIsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD/vmkxm4rgL5fs+2SenlgZmTHmac9TJQ0vMlkW7woU=;
 b=RAnSRUtwA7HrmND8dCcl5Y+OtOpbBVmqkCWgjXUhLvJiRG/2LYQtyK3i3ARk6IsK36qfflf+XG43r1zhjiAHGjUr88qz7O1IRk3tST1FJDesr4q8i7r/Ky7Vc/XZsyWl8MckL9t5xG+urGETEs2Xv30zYb67mnq2PZb48FvgHBv5VLN0EGjLkfzWetg5o/pSXj57BHh1CC0Hvfw7GYv9pgzgtrmeT1qHuUiav34b41ZjlEyK2sued/aFFbLCxfFCDANZjAwCEz+msmyKuO9dPhKUSuFtIFM/z614JItHv869VeCaZ7ImQZovh8/+0shhR9FKlyhr5vOF3U239z/fOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD/vmkxm4rgL5fs+2SenlgZmTHmac9TJQ0vMlkW7woU=;
 b=R7hXByuQEtP/ksXdt2myi30eMLtIfAj0MSd1UE/lx61JDtlj2ohta/tI8Tjc5UoflBqzjHianCP90a4gITVymf4hwnC4NiZmd95iri3CZeVQfc+WwwF3I9aYVOxKuO7N9hC2chno7bxm3agK8ls3rVEPF7Xd7EPIVqGAxK1Xvk4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB6496.apcprd03.prod.outlook.com (2603:1096:400:1c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 13 Dec
 2024 06:22:48 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 06:22:47 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "treapking@chromium.org" <treapking@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"robh@kernel.org" <robh@kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: display: mediatek: ovl: Modify rules for
 MT8195/MT8188
Thread-Topic: [PATCH 1/2] dt-bindings: display: mediatek: ovl: Modify rules
 for MT8195/MT8188
Thread-Index: AQHbTKtRjzmjrpxEt0K8y9+Eqrb4FbLjiIGAgAAtAQA=
Date: Fri, 13 Dec 2024 06:22:47 +0000
Message-ID: <8b010e16175217d0668b97e206c5059c59e6e414.camel@mediatek.com>
References: <20241212153344.27408-1-jason-jh.lin@mediatek.com>
	 <20241212153344.27408-2-jason-jh.lin@mediatek.com>
	 <CAEXTbpfc0ybrvMCuJkKAUwXXTtpZ=vU9MLfU=4CzgdTd-ck4qw@mail.gmail.com>
In-Reply-To: <CAEXTbpfc0ybrvMCuJkKAUwXXTtpZ=vU9MLfU=4CzgdTd-ck4qw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB6496:EE_
x-ms-office365-filtering-correlation-id: a0c1eac1-c0ac-4d37-02fe-08dd1b3e9000
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K1h0RnZDa2VRT2x4OGRGSWVwVGM5anZPcmdzNk0weDM4SVJqK2c4eXpacWpi?=
 =?utf-8?B?OU1tTHlVcldPbEU4dFhCZC9SS0xPNU91ZzJLcWV1elQ5NUM2cXFzSkRQWjdW?=
 =?utf-8?B?Y0xEa2I2Vm5DN0FNaC85WFRpYnNzZVFiNWc4LzdpRCsxWDI1RVNXYmhIdDJS?=
 =?utf-8?B?N0d4T24yYkhFTEJSdHJ6MzlzT05GWkZtdk5IMmpNdUFmbG1ocU9lWmdRZ2VK?=
 =?utf-8?B?cGpmRi9CaFhBQUtpekpOSkw1dFJydTdpWFdXVVpHbTZ1TEJISW9jSzk2Z2pX?=
 =?utf-8?B?cm9oZWJZMDEra011SUY2TUI4V3dqUnhiS2FXUDZWdXNrWHlnOVJCazlJajJG?=
 =?utf-8?B?MnE5STlZdU51QlE1VE9QUzhJeUtSR0VDay9NUTlRWFhvV1E4WHBhcnlJR3pF?=
 =?utf-8?B?K0MxaFpKUUY1OEkraWZEdXIyZHdpZTAwc3hROGJGdlpvb25LNWM3Z3pqS2Uv?=
 =?utf-8?B?TWJnamhVTjNuaGxHMjZ6TDhDMUJKRURZRnpVam55SXM5UzErN0FQYzVsemdO?=
 =?utf-8?B?Y2NOdkpaaGlOZUZJMGlEWnllTlNkUDMwUTFiaCtYYm1zeTBnQ2NCSGIxekRm?=
 =?utf-8?B?V2k5clFWcWJaci9UVzRwOUhGOE01SU1nRmNuWlJGZUVRQjZsMTVtdDkrUU9h?=
 =?utf-8?B?VStQZCtnRUtTMWE5NnpGNXR1Q3Vwd0xCcUtiZlo4YmV0SEdQeWk3NHRlWUUr?=
 =?utf-8?B?S1lJRXpuZTNXcjIwQlBrSnFuR2pBTm9xeWUzQ0dDQnBGeTgrUVVPc3ZmWnBK?=
 =?utf-8?B?d1ZLVHJmbEVLdEtRZnpXZE1IWFRNVEVpUE9PTkQxR3dwc0t4bEl2TXV6OG1p?=
 =?utf-8?B?NmhhTjJQR1dYSlQ4elFXbVVvdVRSQlAzMVMrcDRqZnFWQ0lzcUJiamR4Unh6?=
 =?utf-8?B?R2RRRVZtNk1RWUlYc01lUlptMWFTQjRpNFFkSG5CcVFOUDNUdVUwR2ZhSWoz?=
 =?utf-8?B?Q0JDdkRXeUNNampUeHJsV3hVcDZCSElSNW9EalVjUFBqNUhZcnhQTUZlSG1x?=
 =?utf-8?B?Z2xFSHBORDN4ME1xRS85blE3N1ZBdWs0ekRkUXRYSXI1L2gwS0Y1SDhkNVJO?=
 =?utf-8?B?eFdyaXRuU2tOT2sxaE1NeDN5Q21sbkExd2ZVdzhZejVtTkVIdjVwbUdWcTJi?=
 =?utf-8?B?ZVpOSVNKQ05pQWV2VXBZeGtBWUp1UjZNVmFuSDlmMTBDd0RpVS90cUczendC?=
 =?utf-8?B?dm9pSnc2NkJMUDFLaTlZWnJla1JTQkwvL0tQeHZaaEp0eTA1MktHS3lyT0Ni?=
 =?utf-8?B?NGwydVBsNDZLMzA0YnorRWZLcmlOc2VJdFE1SXB6UktrdE1ZSUszYyttdmww?=
 =?utf-8?B?aG5xUVRkY1Rka0x0TC93KzhTVUIvSkRKMzdENXNyL1NKQVQrOUxZdTVsejBZ?=
 =?utf-8?B?RHprdjhRbTZWWi9JcUhwamk0MTJvMDNtYm1MTVJ5bjcxaHBtMEc5MGFmVVlE?=
 =?utf-8?B?b1pQTTY5cWR2c1U3aWtxZXpCLzFQMHVVTXJxbERIaE9UVjMxN2toTG1TNFJR?=
 =?utf-8?B?OGhxTUZySGdOeGVkcHVOa040eWo1cVhTeVoxaDlXbmZON3NBTmRWUWhuLzRW?=
 =?utf-8?B?a2VJTEpkQ1VaaDZHd1hwbll6VnRac2I4ZkM5SWViMU5UU01Lb0tlOUtwaG9P?=
 =?utf-8?B?dm96WmRzdUdiWkNGcVM0UVRUeWRDNkRPQ0hDaVlENWsrcmMvWW1aWElpTEI3?=
 =?utf-8?B?SGYrdDVNRFE0UkdyTTR0N3BMdjlQYnJzTnVZQlhyZlNEelNHc1FEUlUxY0dR?=
 =?utf-8?B?ZGVINlhtSUFzMUl4bzFwcEoyZTV3WDE2aFhmU2FqVjBhQnJGOTFvU2FGUVJB?=
 =?utf-8?B?S1AwU1h5cm9xY0RQeXZtb2MzbTFXMDBubHpUWWcxWmlxY2p5TzFiUlhkOVB3?=
 =?utf-8?B?ZTVMUDh0UnduQ01IaDBiMzJ5QWJkcEQ2NlNMdEhTL2k1cEJFc0laSnpBZFVY?=
 =?utf-8?Q?e3nofnUOvCERmuQoo9fIyyudGyA1knpq?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?REt4OGRJUGVDTThldkpKQ29Yakx5ZE4zaVdwRjVPUHZXSFJXNXBTelc0czJy?=
 =?utf-8?B?QnJjSEd5Ukc3aUhob3RqTktqdEhUdGdEbnJVREN5dHNmaXhjajJ4bUMwL1Jh?=
 =?utf-8?B?dk5oMnFnTUhVRi9JOGdiNFJXVVlSYXdtS2pWeXdxTFVhNG5YdFZMSHEzNWgv?=
 =?utf-8?B?b3ZwS3NmZFdiUTk5aEpJYkZjb3ZsYnZycSttWVBxbFJtbmhKOXpMNzF6NnV6?=
 =?utf-8?B?by9NMzRTbHV4Rms4a2xETjdYUkdReFRRcU0vT2lHTks5a0l1TzRpSm1MdmN0?=
 =?utf-8?B?YUZiTlZNSjZtNjJtUU1oWVRLa3p0N3cwaHVOcm9XYzBJRjdnNUhWS05nczM2?=
 =?utf-8?B?UFZGN0VMNUZEQjY1MGJCRHgrdFEwSTZ3bFpiTVNRV0o2VTc1MnlRMzVYeFpE?=
 =?utf-8?B?a1FTbnB0c2d6UjlCbEdybjFDUzVTOG94ZnNtZSt6SEc5WDhib1E0R1hVR29O?=
 =?utf-8?B?bXNjSXovd3BaTWVjSmtXVUVWRkxXaUF3b2IrVHRhWU90Z1d2QUw2MGpnZnFw?=
 =?utf-8?B?MnplVHlOMHNlVlRISFhydHBLWDJROElYeVpzUmpXQk1STXlFdGwrV1pYSE42?=
 =?utf-8?B?WVc0bmNXd3Y4eFpnREQ0NktNZEVkZnRXeUhTOFo2UStxRW12SE1CZTdSWkNm?=
 =?utf-8?B?aUc5ZkowT0Q2Rk5KZFA0eDQzck1IY20zR0l3WEgvWWxMdExHMTZjRURXSnFY?=
 =?utf-8?B?eGxQaXhjRUt2UThNMjMybmNPcjIyQXRpcFd5V2Z1c2xBT05DVFUwdlZrWHFr?=
 =?utf-8?B?TUI5ZWkyV2tyN0gvN2dzUDhkU2NTVENqdG1iMVYzMXRCQ0ppR3NtNk50L1Na?=
 =?utf-8?B?Yi9sY2I2NHA0UUJPa0J4TEVkSVlHNmFaUGdMSGVqdCtMV0E0RkdiRGcydUxB?=
 =?utf-8?B?SkIyV2RpRXBUQmhWZmd3Sng3cWlpOHRBeUpzK2JhRFZuYlpEODJSVXdYYy92?=
 =?utf-8?B?eFMzMzRkcFEwMWl0WlJyTVhJdmM5cmtCck11NXpBT21KUC9mVWVzakJYTW1q?=
 =?utf-8?B?L3RhR3VmNzQ1bVVwL0dJVVMyVExOc00xQ0NLQklxTGxXUUM0bjc4aXJITjR4?=
 =?utf-8?B?QzVjcDNwbjZQd0UrR1BXNER1S0JSaWxJREpzMnFBUC90cXFqZEdYUEVSTUFO?=
 =?utf-8?B?Vmo0Qjh6YnhZSlRwa05EY2Zudm03bkJLUmRMd2V5aGFFRkF5RnZsblE4SnZy?=
 =?utf-8?B?UlhwelhhVSszR25jQjMvUkEwQkxKYzY3MDR2Z0VHNDFuSmlVbmxxNXBlU1dj?=
 =?utf-8?B?dUs1OURRbVdodnY1Ykw3R0xQU1h0Z0QvS25kdXFQVWNOZXQrODNSZWdpRncz?=
 =?utf-8?B?NmdMOGkwcVljenpTUFlwRWtRMExTZnhONTV5ckhzMlVFeExGZkkyb1M4UnJq?=
 =?utf-8?B?aldISFAvVGljcGRWNjBvYmg1cHFlakxhakNBQ1JoM1Q2YnRuV2NtYm9EbE56?=
 =?utf-8?B?RjhGWGdENXEzOGFSOGhkeW8vVTQ1amVpaUdpS1V3WkdUY3ZHRGhqZVVmNGRU?=
 =?utf-8?B?ZlZlOTlodjQrUWxUdEE5TFAyS0RwSzYwZjNRQktHTHVoUW5RNUFPM3ZpU0pQ?=
 =?utf-8?B?Z1diMzhrc2xPTkpMOXE5VEIxaFhabi9ucXVnc3U1QlFVbFY5eEZoOWZkRVBr?=
 =?utf-8?B?empDcFpGb1F4VGFCN2JOcHhrcG1iTEk4amVJMTYyME5VcWp6Uk8zdUwwYWpk?=
 =?utf-8?B?TnpjKzV5ZmUzclhHWG1QWXFFUWxQNmpvcG9pRDVmUVNkMms4QmlUOUZHL1VV?=
 =?utf-8?B?WFhKYXBZM1lKUXZCM0hGTnUrOW80QjYvMFE5dXQyclVieWZVTnJPanhoMTlH?=
 =?utf-8?B?U2RGTW1seXAxcXFDNkEvL1ROQWhPb1VwWWxwc05BNEJkOFg5eTlxZlkzczZz?=
 =?utf-8?B?YWRsRXpML2w0b0hCZ0YwbXVEVjllYnJjdkk1QjdLUnhRRjcwVzRYb0hoNkN1?=
 =?utf-8?B?L2ZWNFhNY1V1ZFJpcElpenliOHVBNDM2b2c5ZnhBYy9DZ25iTEZVYWlpQ2N3?=
 =?utf-8?B?V3lDc2RMZUNnVFJwZUswMXRnZE9WQXdmQmliRGUyZXNVWnErcG5sUGdOMGxa?=
 =?utf-8?B?dnhkdkV6cFhtcjVxZE15L1Z2NVVyZDJJNnhiMS9mZ1VyTW5XaFVVMUtXbzFW?=
 =?utf-8?B?d0hJMzlYbzZEcXRHMllRQVZ2RW9mUkMvdm42dWpVZGVlUVhsOWhXdU5NKzNE?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E3A5B4C5F32464592A284BD392C5948@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c1eac1-c0ac-4d37-02fe-08dd1b3e9000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 06:22:47.4162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ziLwHL6oC4vRNptdO+AZe8oEfIvhJjxl2GiwjqEFTHtEF5dmAeHXGKlK68WPab8D4zCTUKR9K/gjmD4g5l9kL35kKkCjY23v68eLFDMaUCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6496

SGkgUGluLXllbiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCg0KT24gRnJpLCAyMDI0LTEy
LTEzIGF0IDExOjQxICswODAwLCBQaW4teWVuIExpbiB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4g
eW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBI
aSBKYXNvbiwNCj4gDQo+IE9uIFRodSwgRGVjIDEyLCAyMDI0IGF0IDExOjMz4oCvUE0gSmFzb24t
SkguTGluIDwNCj4gamFzb24tamgubGluQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4g
RnJvbTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gDQo+
ID4gTW9kaWZ5IHJ1bGVzIGZvciBib3RoIE1UODE5NSBhbmQgTVQ4MTg4Lg0KPiA+IEhhcmR3YXJl
IGNhcGFiaWxpdGllcyBpbmNsdWRlIGNvbG9yIGZvcm1hdHMgYW5kIEFGQkMgYXJlDQo+ID4gY2hh
bmdlZCBzaW5jZSBNVDgxOTUsIHN0b3AgdXNpbmcgdGhlIHNldHRpbmdzIG9mIE1UODE4My4NCj4g
PiANCj4gPiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCj4gPiBSZXZp
ZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiA+IGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGll
biBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLG92bC55YW1sICAgICAgICAgICB8IDggKysrLQ0KPiA+IC0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxvdmwueQ0KPiA+IGFtbA0KPiA+IGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWss
b3ZsLnkNCj4gPiBhbWwNCj4gPiBpbmRleCA5ZWE3OTZhMDMzYjIuLjBhY2UxMmJiYjYyMyAxMDA2
NDQNCj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLG92bC55DQo+ID4gYW1sDQo+ID4gKysrDQo+ID4gYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxv
dmwueQ0KPiA+IGFtbA0KPiA+IEBAIC0zNiwxNiArMzYsMTQgQEAgcHJvcGVydGllczoNCj4gPiAg
ICAgICAgICAgIC0gZW51bToNCj4gPiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10Njc5NS1k
aXNwLW92bA0KPiA+ICAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTczLWRpc3Atb3Zs
DQo+ID4gLSAgICAgIC0gaXRlbXM6DQo+ID4gLSAgICAgICAgICAtIGVudW06DQo+ID4gLSAgICAg
ICAgICAgICAgLSBtZWRpYXRlayxtdDgxODgtZGlzcC1vdmwNCj4gPiAtICAgICAgICAgICAgICAt
IG1lZGlhdGVrLG10ODE5NS1kaXNwLW92bA0KPiA+IC0gICAgICAgICAgLSBjb25zdDogbWVkaWF0
ZWssbXQ4MTgzLWRpc3Atb3ZsDQo+IA0KPiBUaGlzIGJyZWFrcyB0aGUgc2NoZW1hIGNoZWNrIGZv
ciBtdDgxOTUuZHRzaSwgd2hpY2ggaXMgY3VycmVudGx5DQo+IHVzaW5nDQo+IGBjb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5NS1kaXNwLW92bCIsICJtZWRpYXRlayxtdDgxODMtZGlzcC0NCj4g
b3ZsIjtgDQo+IA0KPiBJSVVDIHRoaXMgaXMgc3VwcG9zZWQgdG8gYmUgYSBSRVNFTkQgb2YgWzFd
LCB3aGljaCBhY3R1YWxseSBhZGRlZCBhDQo+IGJpbmRpbmcgZm9yICJtZWRpYXRlayxtdDgxOTUt
ZGlzcC1vdmwiLiBIb3dldmVyIFsxXSBzdGlsbCBicmVha3MNCj4gbXQ4MTk1LmR0c2kgYmVjYXVz
ZSBpdCBvbmx5IGFsbG93cyBgY29tcGF0aWJsZSA9DQo+ICJtZWRpYXRlayxtdDgxOTUtZGlzcC1v
dmwiYCBCdXQgbm90IGBjb21wYXRpYmxlID0NCj4gIm1lZGlhdGVrLG10ODE5NS1kaXNwLW92bCIs
ICJtZWRpYXRlayxtdDgxODMtZGlzcC1vdmwiYC4NCj4gDQoNClllcywgSSBsb3N0IHRoZSAibWVk
aWF0ZWssbXQ4MTk1LWRpc3Atb3ZsIiBpbiBbMV0gYXQgdGhlIGJlZ2lubmluZyBvZg0KY29tcGF0
aWJsZSBwcm9wZXJ0eS4NCkknbGwgYWRkIGl0IHRvIHRoZSBuZXh0IHZlcnNpb24uDQoNCj4gSWYg
Im1lZGlhdGVrLG10ODE4My1kaXNwLW92bCIgaXMgYSByZWFzb25hYmxlIGZhbGxiYWNrIGZvcg0K
PiAibWVkaWF0ZWssbXQ4MTk1LWRpc3Atb3ZsIiwgcGxlYXNlIGtlZXAgYSBiaW5kaW5nIGxpa2U6
DQo+IA0KPiAgICAgICAtIGl0ZW1zOg0KPiAgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4
MTk1LWRpc3Atb3ZsDQo+ICAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxODMtZGlzcC1v
dmwNCj4gDQo+IE9yLCBmaXggbXQ4MTk1LmR0c2kgaW5zdGVhZCBpbiB0aGUgc2FtZSBzZXJpZXMu
DQoNClllcywgSSB0aGluayB0aGUgT1ZMIGluIG10ODE5NS5kdHNpIHNob3VsZCByZW1vdmUgdGhl
ICJtZWRpYXRlayxtdDgxODMtDQpkaXNwLW92bCIgYmVjYXVzZSBpdCdzIG5vdCBjb21wYXRpYmxl
IGFueW1vcmUuDQoNCkknbGwgYWRkIHRoYXQgcGF0aCBpbiB0aGUgc2FtZSBzZXJpZXMuDQoNClJl
Z2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0K

