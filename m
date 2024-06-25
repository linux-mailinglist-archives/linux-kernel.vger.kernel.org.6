Return-Path: <linux-kernel+bounces-228348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7B915E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159B21C210CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BEB145B29;
	Tue, 25 Jun 2024 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Qx4F9rob";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dhEnAZ7j"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814276A325;
	Tue, 25 Jun 2024 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719295192; cv=fail; b=T3v3nj/Wtjg/j/Mt4uyflPZcYjucZrd9TBzkLQVpgQNzzDHagRR1W8QoTAlPIOK1+SMyKC2uBcQ/gt2cy9UCYVo5C20OplLbPFmLRgLBy9kc+zRoWvyOLZM40zZYJ4qISBggVMWyTtLXdEpCBf61VgddhGEOyLCQsAVc6oVxfo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719295192; c=relaxed/simple;
	bh=9kRKiIZxE7zfYxdKtPE2LeHdQBR/d8GQP/YtgtN0KH4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kSxDfBn6x+S2fAK2+MxLJBZDdFkaFIyGYH1ym9UBiJsmCOtaJzOme8RNZ5adrmIBcPTcVD8g9gJagsgikqEmsm58oB0Dcy9bdVCXSfjilUEwSMvZjVOvzu129akrd8sbQQP9IJl1EciO/Cz1YGjTNJ2PPYrFkIfFYybF21B9g6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Qx4F9rob; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dhEnAZ7j; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1d930c4e32b811ef99dc3f8fac2c3230-20240625
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9kRKiIZxE7zfYxdKtPE2LeHdQBR/d8GQP/YtgtN0KH4=;
	b=Qx4F9robzxBzOdCMywnISq95sAdZ/9HdQp1ZS3DAXXsused6kcyqgsxmbwNh8UlOnOi6dDnKhAhFqQnWNETGjCVlKAvyT5jtpPGAdACblUwDWCCejxLSnGg6uz7PQ/OZSLw4cTRKOoOK4gzhmEyj/OLxnSb2W9pFd2vLYmCw7VQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:839dd737-dadd-4ddb-92f2-82d0268a3875,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:1a84ff88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1d930c4e32b811ef99dc3f8fac2c3230-20240625
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1852721353; Tue, 25 Jun 2024 13:59:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Jun 2024 22:59:41 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 25 Jun 2024 13:59:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FM2iJnVlHHht26WVGpg9S3oVrPKdhyFecdIyGrL4AA/4eBzChNGqK9N5uOYRferpYZAYWFyLK93805caGawS0aj+bwVfQbbwqMFLLuTq5If0IQwPsZc3Gu2tFICAvAKSTHJeCy/2y5CEk0Ftj1B70MHeSDF1mwYFcR+LWhxcuhh41ZXW3F9gOnibzxMzslbMygiWhi4aLh8vHNpm2kDimyGP6G/6OAlo8FtRnOlFX8MYqQTv7bN0AMR6WhJ8Nh/+ac3daJepw2oX+MhEe6GQIV2yxN9++3SodonHeOR2z5J/rVMIH62GqU+dfrWw2gm9nSGkNsqcUleTq3iN5CQiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kRKiIZxE7zfYxdKtPE2LeHdQBR/d8GQP/YtgtN0KH4=;
 b=Ys2VmLNQUroEh+MWaLZeSSO8lxwsj0CxWHOMmR2wNWa5thWk8CmjPRQVSHIXQoJyahAu6lLpfRTqlZWxqMKJ9NHBkdaWNLBleQHnYPqPpK7HoFwaZu1ZdR8obx6VLM9inKjwd3r/frmVbEtvb2ufvF2Do9OWSFsU5RUwjpcFeYcO96Gr3USVNssFmymd6MfyaPUhostJtIkMDOYwtjzGjd/0pq06HsLV/0UBxre5tNEsjgVUC2NS1agBIpwqsMqQBnc8fSGx2wJWzwK+SwUe81DjwDVhkFvyU6iXatIckmvfHVEsSvYEJH96uVDzHZHM8UaRWzPvprIOcVb1lVS3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kRKiIZxE7zfYxdKtPE2LeHdQBR/d8GQP/YtgtN0KH4=;
 b=dhEnAZ7j4ETyQB7xf3xCARDZTZZC58Zt7YVHlZDZO+zkkGHqSQrGeUx4Rc2I8l/OKnQDMhxYhsE59cR53SCnomUgXltmYrlMC75LdvnPFVnyrCYATbUN8kR5xypbGkyRQKggtG61JnsfjmdOY9jwcdHFBrb9yb75Ct0dn+pcv+4=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB6435.apcprd03.prod.outlook.com (2603:1096:101:3f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 05:59:38 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 05:59:37 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 3/8] soc: mediatek: cmdq: Add cmdq_pkt_logic_command to
 support math operation
Thread-Topic: [PATCH v6 3/8] soc: mediatek: cmdq: Add cmdq_pkt_logic_command
 to support math operation
Thread-Index: AQHarvhxTRgC47+tMk2FaVMuM7C7h7GsdJaAgABbiICAKihIAIABM2AA
Date: Tue, 25 Jun 2024 05:59:37 +0000
Message-ID: <68d32f591d504fca3e9720bd6de75dfd04a40157.camel@mediatek.com>
References: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
	 <20240525230810.24623-4-jason-jh.lin@mediatek.com>
	 <cd15d9c5-f7a8-45fd-b0e1-011a9832d023@collabora.com>
	 <f26efcca21b9954a0137d391ca78ba9870afd2f9.camel@mediatek.com>
	 <5eda88da-ec50-48ff-8ed0-f4d3b8df5a3d@collabora.com>
In-Reply-To: <5eda88da-ec50-48ff-8ed0-f4d3b8df5a3d@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB6435:EE_
x-ms-office365-filtering-correlation-id: 0e5f64a9-0cf5-4d0c-f0be-08dc94dbff1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|7416011|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?c2FWOXdDUEo3b0Q4dWlqTHNsTDQzbUlGYW9uLzIwN3lXZy83dHZnZ2VncXQx?=
 =?utf-8?B?eEFWMFQyU0I2clBkR3JpSmFoSCs1UXZ6d1dVakQzTnE5ci90TUtTbFpiU2RC?=
 =?utf-8?B?amVyYnJUbXlLZ1RCeEZobkdZeFdBZFBnQUFuTEszR1ZyYll2QkpndWtVUkdD?=
 =?utf-8?B?eTlKZEtBL21YQ09laTR4TDRaODdhdEdDbVk1U3Q1NlFPelBFK1plQzFMVDBK?=
 =?utf-8?B?SXVRRU96NVJWZ3dWbG5QbGk0bFQ5cStxQnIzcEN1VXEzQ05YcmszRWphWVYy?=
 =?utf-8?B?b0hVa0JEZFZOalp2Wlp3NjJ2WG5vbWJaVXdVMGlkZnhQK3N3ZDAySzl4eGZ0?=
 =?utf-8?B?OW9IeDlyMThmdkM2eE9nbFhHaG14cG1qVGVKckJYbnpLbXhLZmVzei9uSVhn?=
 =?utf-8?B?UVZvN1g5SEVSTGJZbTk0RjZob1BUdVlxVmhDVU5DeGNOczMrSS93WWloOGJZ?=
 =?utf-8?B?NTB3aDQ1YVFPRitwMkZleG44OVJVcTArVlVqMlB4a1M4QXEwbnFNOGF6M2xO?=
 =?utf-8?B?YWlNb0crSUJYQ3QzaEdxbkg0RzRxMDhUNlI3V3VMRjVPMHJ6QjVBUXpHRjU1?=
 =?utf-8?B?NHhiN0hBWCtFcFdyNG5OZVVYR3NGblJ2cjB2TEkya2NqbDdmVDZmWGxGdy96?=
 =?utf-8?B?SWt3RmRuTFE3R2tVNU1LT0o5by9JZEZjMGNacW9VYVB0Y2t6dnlFdG9rb1Jj?=
 =?utf-8?B?eDZyeG1QZis1TEtrTFEyOURacHVhOXVCSm9yVmpPcW41cE1XbG05UU4vdXRi?=
 =?utf-8?B?MVZrT0ZpUWFWN2NQVDZ1WGJzMVlKdXdodHRxMWZRYkdOR21sRU1Za0QwbVVu?=
 =?utf-8?B?U0NKaHZTaVV0RnFYc2M1SkcyTnFlNXhWM2theXBwL3k0dVZtSFZ4c21aL2pZ?=
 =?utf-8?B?aEhobDlwM0FnZ3Q2cy9ESTgrTEN2ZFFKc0VMUGNMNDlxQ0dpL3Y2UGZYNktJ?=
 =?utf-8?B?NEJ3S0NOanJuS0JSSjdwYlhiY0EvdjdEMGkvcUhaTEl2UkhKMWRnTHJ1bHdk?=
 =?utf-8?B?cmo5d1lXc0l3aG9JYWN2U016cFF1ZGtYemc0dkNFS3M3RkpJVVlDdVRFRWJV?=
 =?utf-8?B?Qi9QRWU2eVl0SkhqODZtY2hTcHRvWjdEVGRjRTNld2lxTC9tSTNpVDNra1Nz?=
 =?utf-8?B?Q3Y3dXdHTjhORm1aTU9tR1BzTU5iTDV3V1NGVU1jaUk1NEVxNHpOY1dDa2ZN?=
 =?utf-8?B?djd5Z3RHMWFqRmlBZUp4dGs5SnNXTVBLcHJpaDNsWGtkb0dBZUxyRGlHWGQ3?=
 =?utf-8?B?MUJmQ0pWd1RrcHNzK054emhKeE5rcWdEYlpJbjk3blFJblRtT3ZlRFpWbFhH?=
 =?utf-8?B?VnhsMEtsMzRFTHYvVDdSWmpkaUVWaTh3QzNUVG91Z3orNGFQa1VvdW54RFNi?=
 =?utf-8?B?MWd2MnZ4ZHMwTWtwdm42Q21mNjVQaDdtMkErUFU2SlNKaEtqQWgyL3pza2lz?=
 =?utf-8?B?RUY3eUxzZzVVdGNlb3NTQnl0SldWR3ZjS3lEd20yUnVVdk9SN1h3cEQzM2Vu?=
 =?utf-8?B?Y0Z5YUtEVXRYcjJPYjFOQ2tBTzBBR1oxUlh5TlhtU0RJZHBYYzhZR2hDeVlp?=
 =?utf-8?B?UVl3NXNPNSs0U2RBVkU0ek5uLy9objRtUmRzUlpJd0pFbk5FSEVWYlMrMTlO?=
 =?utf-8?B?ZTZKSkc5QUxGaFYwbTJXWFJpTDl1cjVHdEw3SWh3UktjLzM4YVJHUUJnT29o?=
 =?utf-8?B?dkVxMHBwWnhEVHZYYlJ3c2JRRFlDVDBtVHI4dmc0UlZxYVlMNHFpSkloaWZB?=
 =?utf-8?B?VCtHZ0xjLzg4V2gyUUdkanp1aFRTODFpcVEvZDdXcEthdWdqd09XdVFWYTNT?=
 =?utf-8?B?TWd0alRSVXF3RUxOUDZQUXJNbFV5RU1TWGd1a0Z3L3ZhTjdaR1ZYNE9DVWZL?=
 =?utf-8?B?TjFIbnhFWGFOZkU0a2s5ZlZMT3Z2aWFTMWZORUVkaEwxc1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(7416011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THdtSlBKK0N1SEg4QVhBYXEwenliUFVsc2k0TnlGdElKalNjbkNXQUpqRzQy?=
 =?utf-8?B?cHBHb1VuaTM4enE0RUdnVGRnanpCLzU2MUk0SXFMTmsyUFVkOFF4U3RuY1lx?=
 =?utf-8?B?a3Y2UmQrajNlamhmMTdzZU9LVW1Ycjk3N1dVNkpBUEFtdy9ETlR4ZW9lMTJY?=
 =?utf-8?B?bWlMNFhFNG5kZWk1ZDRZRklrckYxa2Q2bUpEK3pxTzZWSzdFNVl1WXc4RjhE?=
 =?utf-8?B?S29rRDNNY3FVeHl5KzFXQXViV21zSWlXT0g4RmxhK0hXakN4alJBQVU0aDhS?=
 =?utf-8?B?V3lJN2F4WnRBYkR2VTI2YW15MEsyR0QwdVhLbHJVeXhOR3lHWS84UmtOYUNF?=
 =?utf-8?B?WkZ3V2w0Z2ZPSFJqa3d0K01zYmdrZTJCMHliaUpRd2RDeW1JMmdXU2RNMEw0?=
 =?utf-8?B?b29SSGUvWTVXanVsdWMyMld1cGthb1JoM0NVZW9JVHo4emNoTmd6TjVrV292?=
 =?utf-8?B?NHlIZitOZ1ZZK3djVkxVMzlTQ3dPZ280d3RqY2Q1V1VCZTVQeWNXSWFVVWRK?=
 =?utf-8?B?Q0RMckc4dDZHQVFZQ3hHVTZSK2I3QkF1SjRXa05yQVA4RVNycmx5R1hVc2Mx?=
 =?utf-8?B?Yy8yQzAzMFpzWCtlc2FTRmxJcDJVT05TVXRxQjFxcXE5R3ZJcW1yTlpLOUhI?=
 =?utf-8?B?STRid0VRU0dzZGF3czJsTEgzek14Rk8zVzhpNDdNbXRSbmtNSk9RRFd3Z3Yx?=
 =?utf-8?B?TzVONFFWQTFSR09JZmk1aHdUd0QxVzY5QWZwV3JFcUxtWDUzSmwrY1dTbGNw?=
 =?utf-8?B?TEVDcDhpRm9XbWZjSnpBcWphSkFuMjdvQko2cVltOTE5bEdtU2cwM0JCUy9r?=
 =?utf-8?B?ZTBpbW9XazJ2MTQzR29uaFU0ZEVKZ09ZS0lSMHJMM24wMlBNS1dLQlp2alNT?=
 =?utf-8?B?a2RpUUQzbTA3d3RXNzVXb3k4OGx6S1IvMExIV0dNd3hjTkI1R0lyeUQvNW9s?=
 =?utf-8?B?VEY4VjhDWEFnVGZkeE1PelhTeldmYWdtSUNKR0RzaEx2UXpVY1JlVVlXZnMr?=
 =?utf-8?B?amhjV1RpS3kzTDVWaHBBY2xtemk0N2N5VS83cDg0UlcvNkNONnRqdVJjYmVC?=
 =?utf-8?B?S0xLSERNTTB1dE52Tk5nQmhqQ0FQcjU0Y3JIend3RXhXZmtiOHJrd3V4T0pi?=
 =?utf-8?B?V3dNdFlJSXZDV2hLSlRzWkxnL3g5SzgzTldnTnNlYS9jWDd1amxiZ0F3bkM1?=
 =?utf-8?B?WGdWVkRQY1REYnBFMExQN2RleFFCY05yTG1wdGFCcHNBWDBtbklqRFdVVkhM?=
 =?utf-8?B?dTJyNmxaZlVoendlcUxHQmRGeStsY2U5alViS2t1bndVOUgzK3ZIbGFFUnZN?=
 =?utf-8?B?dVZ2Ky9Qb29OUEdCTktmK2pFellROTJaTGEzUm9ja09FM2dvK2EzdjdBY0Yy?=
 =?utf-8?B?aVJGVDcwZnArMVlvZkVvWVRiUFNBeTZWYzVRWTIwaFJ5cWRiOXYxaFJrMGVK?=
 =?utf-8?B?bHRzanpzZ3FoWlhZTnhIVkhMVjU4YktjdVY4bGxxQURiZmdYa21mMlV5VkZa?=
 =?utf-8?B?WWZSYUpvekpXVXNOMUJjNFdRcjIwbE5OdGpScjE4NDlydFNRbG1LMG5LNXBW?=
 =?utf-8?B?Unp3bmxVMVB1VjNxcWZVZ29rQ1B2eW5aVDFuOXpRVFYrR1g2TElnUDdzOFA3?=
 =?utf-8?B?dFQwTndCc2VxNm12em1xSGxLeGRUeVlhZW0xTEZ0OGhLNnFIWjI1alpCK3NV?=
 =?utf-8?B?dHFiSFM5Qk42NXNCYmpMazZGUHhyL3ptbEdhWXdaNTFkL3cxSERSWUpYd3lI?=
 =?utf-8?B?cTN2WEIzZ09RQXdhb3Y2SzNySWREQWxKU28vYjk0SzdOSHJqOWxBRUhZbjFZ?=
 =?utf-8?B?UmkvdS9KVnVFTW01Umo2ZzRia2JuSGJkOFk3R0lMT2hxTHBaMXNINGxwVU9N?=
 =?utf-8?B?eXhEQUtEMDd1N2lvaXRpWU1BVWNtazhWd1NQYlZRVXpYQ1RhNG9PUWlWRWUr?=
 =?utf-8?B?RWR3LzJYcVI0dyt5REEySmlCQlJ4d3YxRzFXSHlTeUkrTHRtL3dYb2IxdkZL?=
 =?utf-8?B?bGRGVWFYd3gyYlltS1hZMEFtOUIyUWRxZTAxajBuUXhaUEt4V292UGpkZXFs?=
 =?utf-8?B?YzdWWVEwUS9LbXorNHRUdTdMeGN0bGxOSHNSOWY4dFJlUWpkSFRyL2JJaHFh?=
 =?utf-8?B?R1VoWnlkcFkrMUFkWVllOGFYWUthOWdiVi9wOCs5ZTM2RDBSaWQvSlhHb25O?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D281B9FF1A95145A4630D35E94DE920@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5f64a9-0cf5-4d0c-f0be-08dc94dbff1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 05:59:37.7993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VzypYUlG2sg5iJEe2J7BJuB641JhyeQBF/oMaaIa9q8gefOCx3ZeVJhRtq4bluTFobtogy8JJiShFV/bzpFWveeVxWKtbHZVYH1oDqGVBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6435

T24gTW9uLCAyMDI0LTA2LTI0IGF0IDEzOjM5ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjgvMDUvMjQgMTc6NTIsIEphc29uLUpIIExpbiAo5p6X552/56Wl
KSBoYSBzY3JpdHRvOg0KPiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjQtMDUt
MjggYXQgMTI6MjQgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+ID4gd3JvdGU6
DQo+ID4gPiBJbCAyNi8wNS8yNCAwMTowOCwgSmFzb24tSkguTGluIGhhIHNjcml0dG86DQo+ID4g
PiA+IEFkZCBjbWRxX3BrdF9sb2dpY19jb21tYW5kIHRvIHN1cHBvcnQgbWF0aCBvcGVyYXRpb24u
DQo+ID4gPiA+IA0KPiA+ID4gPiBjbWRxX3BrdF9sb2dpY19jb21tYW5kIGNhbiBhcHBlbmQgbG9n
aWMgY29tbWFuZCB0byB0aGUgQ01EUQ0KPiA+ID4gPiBwYWNrZXQsDQo+ID4gPiA+IGFzayBHQ0Ug
dG8gZXhlY3V0ZSBhIGFyaXRobWV0aWMgY2FsY3VsYXRlIGluc3RydWN0aW9uLA0KPiA+ID4gPiBz
dWNoIGFzIGFkZCwgc3VidHJhY3QsIG11bHRpcGx5LCBBTkQsIE9SIGFuZCBOT1QsIGV0Yy4NCj4g
PiA+ID4gDQo+ID4gPiA+IE5vdGUgdGhhdCBhbGwgYXJpdGhtZXRpYyBpbnN0cnVjdGlvbnMgYXJl
IHVuc2lnbmVkDQo+ID4gPiA+IGNhbGN1bGF0aW9ucy4NCj4gPiA+ID4gSWYgdGhlcmUgYXJlIGFu
eSBvdmVyZmxvd3MsIEdDRSB3aWxsIHNlbnQgdGhlIGludmFsaWQgSVJRIHRvDQo+ID4gPiA+IG5v
dGlmeQ0KPiA+ID4gPiBDTURRIGRyaXZlci4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+
ID4gPiA+IC0tLQ0KPiA+ID4gPiAgICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYyB8IDM2DQo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gICAgaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgfCA0Mg0KPiA+ID4gPiArKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgICAyIGZpbGVzIGNoYW5nZWQsIDc4IGluc2Vy
dGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRp
YXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ID4gPiBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+ID4gPiA+IGluZGV4IDA0NjUyMjY2NGRjMS4uNDJmYWUwNWY2MWE4
IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIu
Yw0KPiA+ID4gPiBAQCAtMTUsMTAgKzE1LDE5IEBADQo+ID4gPiA+ICAgIC8qIGRlZGljYXRlIHRo
ZSBsYXN0IEdQUl9SMTUgdG8gYXNzaWduIHRoZSByZWdpc3RlciBhZGRyZXNzDQo+ID4gPiA+IHRv
IGJlDQo+ID4gPiA+IHBvbGwgKi8NCj4gPiA+ID4gICAgI2RlZmluZSBDTURRX1BPTExfQUREUl9H
UFIJKDE1KQ0KPiA+ID4gPiAgICAjZGVmaW5lIENNRFFfRU9DX0lSUV9FTgkJQklUKDApDQo+ID4g
PiA+ICsjZGVmaW5lIENNRFFfSU1NRURJQVRFX1ZBTFVFCTANCj4gPiA+ID4gICAgI2RlZmluZSBD
TURRX1JFR19UWVBFCQkxDQo+ID4gPiA+ICAgICNkZWZpbmUgQ01EUV9KVU1QX1JFTEFUSVZFCTAN
Cj4gPiA+ID4gICAgI2RlZmluZSBDTURRX0pVTVBfQUJTT0xVVEUJMQ0KPiA+ID4gPiAgICANCj4g
PiA+ID4gKyNkZWZpbmUgQ01EUV9PUEVSQU5EX0dFVF9JRFhfVkFMVUUob3BlcmFuZCkgXA0KPiA+
ID4gPiArCSh7IFwNCj4gPiA+ID4gKwkJc3RydWN0IGNtZHFfb3BlcmFuZCAqb3AgPSBvcGVyYW5k
OyBcDQo+ID4gPiA+ICsJCW9wLT5yZWcgPyBvcC0+aWR4IDogb3AtPnZhbHVlOyBcDQo+ID4gPiA+
ICsJfSkNCj4gPiA+IA0KPiA+ID4gSSB0aGluayB0aGlzIENNRFFfT1BFUkFORF9HRVRfSURYX1ZB
TFVFIHdvdWxkIGJlIGJldHRlciBleHByZXNzZWQNCj4gPiA+IGFzDQo+ID4gPiBhIChpbmxpbmU/
KQ0KPiA+ID4gZnVuY3Rpb24gaW5zdGVhZC4uLg0KPiA+ID4gDQo+ID4gDQo+ID4gWWVzLCBJIGNh
biBjaGFuZ2UgdGhlbSB0byBzdGF0aWMgaW5saW5lIGZ1bmN0aW9uIHRvIHBhc3MgdGhlaXIgdHlw
ZQ0KPiA+IGRpcmVjdGx5Lg0KPiA+IA0KPiA+ID4gc3RhdGljIGlubGluZSB1MTYgY21kcV9vcGVy
YW5kX2dldF9pZHhfdmFsdWUoc3RydWN0IGNtZHFfb3BlcmFuZA0KPiA+ID4gKm9wKQ0KPiA+ID4g
ew0KPiA+ID4gCXJldHVybiBvcC0+cmVnID8gb3AtPmlkeCA6IG9wLT52YWx1ZTsNCj4gPiA+IH0N
Cj4gPiA+IA0KPiA+ID4gYW5kIG1heWJlIHRoZSBzYW1lIGZvciB0aGUgb3RoZXIgZGVmaW5pdGlv
biB0b28uLg0KPiA+ID4gDQo+ID4gPiBzdGF0aWMgaW5saW5lIHUxNiBjbWRxX29wZXJhbmRfdHlw
ZShzdHJ1Y3QgY21kcV9vcGVyYW5kICpvcCkNCj4gPiA+IHsNCj4gPiA+IAlyZXR1cm4gb3AtPnJl
ZyA/IENNRFFfUkVHX1RZUEUgOiBDTURRX0lNTUVESUFURV9WQUxVRTsNCj4gPiA+IH0NCj4gPiA+
IA0KPiA+ID4gYnV0IGRlZmluaXRlbHkgdGhlIGZpcnN0IG9uZSBpcyB3aGF0IEkgZG9uJ3QgbGlr
ZSBtdWNoLCB0aGUNCj4gPiA+IHNlY29uZA0KPiA+ID4gb25lIGNhbiBwYXNzLg0KPiA+ID4gDQo+
ID4gDQo+ID4gWW91IG1lYW4gJyNkZWZpbmUgQ01EUV9PUEVSQU5EX0dFVF9JRFhfVkFMVUUoKScg
aXMgdGhlIGZpcnN0IG9uZSBvcg0KPiA+ICdzdGF0aWMgaW5saW5lIHUxNiBjbWRxX29wZXJhbmRf
Z2V0X2lkeF92YWx1ZSgpJyBpcyB0aGUgZmlyc3Qgb25lPw0KPiA+IA0KPiANCj4gSSdtIHNvcnJ5
LCB5b3VyIHJlcGx5IHNsaXBwZWQgdGhyb3VnaCBmb3Igc29tZSByZWFzb24gYW5kIEkndmUgcmVh
ZA0KPiBpdCBqdXN0IG5vdy4NCj4gDQo+IEkgbWVhbiBJIGRvbid0IGxpa2UgdGhlIG1hY3JvcyAo
I2RlZmluZQ0KPiBDTURRX09QRVJBTkRfR0VUX0lEWF9WQUxVRSguLikgYW5kDQo+IENNRFFfT1BF
UkFORF9UWVBFKC4uKSkgOi0pDQo+IA0KPiBQbGVhc2UgdXNlIHN0YXRpYyBpbmxpbmUgZnVuY3Rp
b25zIGFuZCByZXNlbmQ7IGlmIHlvdSBjYW4gZG8gdGhhdA0KPiB0aGlzIHdlZWssIEkNCj4gY2Fu
IHBpY2sgdGhlIGNvbW1pdCBiZWZvcmUgSSBzZW5kIHRoZSBQUi4NCj4gDQo+IFAuUy46IEFuZCB5
b3UncmUgcmlnaHQsIHJlLXJlYWRpbmcgbXkgb3duIHJlcGx5LCBpdCB3YXMgYSBiaXQNCj4gYW1i
aWd1b3VzLCBzbw0KPiBJJ20gYWdhaW4gc29ycnkgZm9yIHRoYXQsIHdpbGwgYmUgY2xlYXJlciBu
ZXh0IHRpbWUuDQo+IA0KDQpObyBwcm9ibGVtIQ0KU2luY2Ugb3RoZXIgcGF0Y2hlcyBpbiB0aGlz
IHNlcmllcyBhcmUgc3RpbGwgY29va2luZywgSSdsbCByZXNlbmQgdGhpcw0KcGF0Y2ggc2VwYXJh
dGVseS4gVGhhbmtzIQ0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gVGhhbmtzLA0KPiBB
bmdlbG8NCj4gDQo+ID4gUmVnYXJkcywNCj4gPiBKYXNvbi1KSC5MaW4NCj4gPiANCj4gPiA+IENo
ZWVycywNCj4gPiA+IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gPiA+ICsjZGVmaW5lIENNRFFfT1BFUkFO
RF9UWVBFKG9wZXJhbmQpIFwNCj4gPiA+ID4gKwkoKG9wZXJhbmQpLT5yZWcgPyBDTURRX1JFR19U
WVBFIDogQ01EUV9JTU1FRElBVEVfVkFMVUUpDQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgc3RydWN0
IGNtZHFfaW5zdHJ1Y3Rpb24gew0KPiA+ID4gPiAgICAJdW5pb24gew0KPiA+ID4gPiAgICAJCXUz
MiB2YWx1ZTsNCj4gPiA+ID4gQEAgLTQ2MSw2ICs0NzAsMzMgQEAgaW50IGNtZHFfcGt0X3BvbGxf
YWRkcihzdHJ1Y3QgY21kcV9wa3QNCj4gPiA+ID4gKnBrdCwNCj4gPiA+ID4gZG1hX2FkZHJfdCBh
ZGRyLCB1MzIgdmFsdWUsIHUzMiBtYXMNCj4gPiA+ID4gICAgfQ0KPiA+ID4gPiAgICBFWFBPUlRf
U1lNQk9MKGNtZHFfcGt0X3BvbGxfYWRkcik7DQo+ID4gPiA+ICAgIA0KPiA+ID4gPiAraW50IGNt
ZHFfcGt0X2xvZ2ljX2NvbW1hbmQoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNg0KPiA+ID4gPiBy
ZXN1bHRfcmVnX2lkeCwNCj4gPiA+ID4gKwkJCSAgIHN0cnVjdCBjbWRxX29wZXJhbmQgKmxlZnRf
b3BlcmFuZCwNCj4gPiA+ID4gKwkJCSAgIGVudW0gY21kcV9sb2dpY19vcCBzX29wLA0KPiA+ID4g
PiArCQkJICAgc3RydWN0IGNtZHFfb3BlcmFuZCAqcmlnaHRfb3BlcmFuZCkNCj4gPiA+ID4gK3sN
Cj4gPiA+ID4gKwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiA+
ID4gKwl1MzIgbGVmdF9pZHhfdmFsdWU7DQo+ID4gPiA+ICsJdTMyIHJpZ2h0X2lkeF92YWx1ZTsN
Cj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmICghbGVmdF9vcGVyYW5kIHx8ICFyaWdodF9vcGVyYW5k
IHx8IHNfb3AgPj0NCj4gPiA+ID4gQ01EUV9MT0dJQ19NQVgpDQo+ID4gPiA+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJbGVmdF9pZHhfdmFsdWUgPQ0KPiA+ID4gPiBD
TURRX09QRVJBTkRfR0VUX0lEWF9WQUxVRShsZWZ0X29wZXJhbmQpOw0KPiA+ID4gPiArCXJpZ2h0
X2lkeF92YWx1ZSA9DQo+ID4gPiA+IENNRFFfT1BFUkFORF9HRVRfSURYX1ZBTFVFKHJpZ2h0X29w
ZXJhbmQpOw0KPiA+ID4gPiArCWluc3Qub3AgPSBDTURRX0NPREVfTE9HSUM7DQo+ID4gPiA+ICsJ
aW5zdC5kc3RfdCA9IENNRFFfUkVHX1RZUEU7DQo+ID4gPiA+ICsJaW5zdC5zcmNfdCA9IENNRFFf
T1BFUkFORF9UWVBFKGxlZnRfb3BlcmFuZCk7DQo+ID4gPiA+ICsJaW5zdC5hcmdfY190ID0gQ01E
UV9PUEVSQU5EX1RZUEUocmlnaHRfb3BlcmFuZCk7DQo+ID4gPiA+ICsJaW5zdC5zb3AgPSBzX29w
Ow0KPiA+ID4gPiArCWluc3QucmVnX2RzdCA9IHJlc3VsdF9yZWdfaWR4Ow0KPiA+ID4gPiArCWlu
c3Quc3JjX3JlZyA9IGxlZnRfaWR4X3ZhbHVlOw0KPiA+ID4gPiArCWluc3QuYXJnX2MgPSByaWdo
dF9pZHhfdmFsdWU7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5k
X2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiA+ID4gK30NCj4gPiA+ID4gK0VYUE9SVF9TWU1CT0wo
Y21kcV9wa3RfbG9naWNfY29tbWFuZCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgaW50IGNtZHFf
cGt0X2Fzc2lnbihzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IHJlZ19pZHgsIHUzMg0KPiA+ID4g
PiB2YWx1ZSkNCj4gPiA+ID4gICAgew0KPiA+ID4gPiAgICAJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rp
b24gaW5zdCA9IHt9Ow0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEuaA0KPiA+ID4gPiBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
ay1jbWRxLmgNCj4gPiA+ID4gaW5kZXggZDRhOGUzNDUwNWU2Li41YmVlNmY3ZmM0MDAgMTAwNjQ0
DQo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
PiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+ID4g
PiBAQCAtMjUsNiArMjUsMzEgQEANCj4gPiA+ID4gICAgDQo+ID4gPiA+ICAgIHN0cnVjdCBjbWRx
X3BrdDsNCj4gPiA+ID4gICAgDQo+ID4gPiA+ICtlbnVtIGNtZHFfbG9naWNfb3Agew0KPiA+ID4g
PiArCUNNRFFfTE9HSUNfQVNTSUdOID0gMCwNCj4gPiA+ID4gKwlDTURRX0xPR0lDX0FERCA9IDEs
DQo+ID4gPiA+ICsJQ01EUV9MT0dJQ19TVUJUUkFDVCA9IDIsDQo+ID4gPiA+ICsJQ01EUV9MT0dJ
Q19NVUxUSVBMWSA9IDMsDQo+ID4gPiA+ICsJQ01EUV9MT0dJQ19YT1IgPSA4LA0KPiA+ID4gPiAr
CUNNRFFfTE9HSUNfTk9UID0gOSwNCj4gPiA+ID4gKwlDTURRX0xPR0lDX09SID0gMTAsDQo+ID4g
PiA+ICsJQ01EUV9MT0dJQ19BTkQgPSAxMSwNCj4gPiA+ID4gKwlDTURRX0xPR0lDX0xFRlRfU0hJ
RlQgPSAxMiwNCj4gPiA+ID4gKwlDTURRX0xPR0lDX1JJR0hUX1NISUZUID0gMTMsDQo+ID4gPiA+
ICsJQ01EUV9MT0dJQ19NQVgsDQo+ID4gPiA+ICt9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICtzdHJ1
Y3QgY21kcV9vcGVyYW5kIHsNCj4gPiA+ID4gKwkvKiByZWdpc3RlciB0eXBlICovDQo+ID4gPiA+
ICsJYm9vbCByZWc7DQo+ID4gPiA+ICsJdW5pb24gew0KPiA+ID4gPiArCQkvKiBpbmRleCAqLw0K
PiA+ID4gPiArCQl1MTYgaWR4Ow0KPiA+ID4gPiArCQkvKiB2YWx1ZSAqLw0KPiA+ID4gPiArCQl1
MTYgdmFsdWU7DQo+ID4gPiA+ICsJfTsNCj4gPiA+ID4gK307DQo+ID4gPiA+ICsNCj4gPiA+ID4g
ICAgc3RydWN0IGNtZHFfY2xpZW50X3JlZyB7DQo+ID4gPiA+ICAgIAl1OCBzdWJzeXM7DQo+ID4g
PiA+ICAgIAl1MTYgb2Zmc2V0Ow0KPiA+ID4gPiBAQCAtMjcyLDYgKzI5NywyMyBAQCBpbnQgY21k
cV9wa3RfcG9sbChzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgNCj4gPiA+ID4gc3Vic3lzLA0KPiA+
ID4gPiAgICBpbnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBz
dWJzeXMsDQo+ID4gPiA+ICAgIAkJICAgICAgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1h
c2spOw0KPiA+ID4gPiAgICANCj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogY21kcV9wa3RfbG9n
aWNfY29tbWFuZCgpIC0gQXBwZW5kIGxvZ2ljIGNvbW1hbmQgdG8gdGhlIENNRFENCj4gPiA+ID4g
cGFja2V0LCBhc2sgR0NFIHRvDQo+ID4gPiA+ICsgKgkJICAgICAgICAgIGV4ZWN1dGUgYW4gaW5z
dHJ1Y3Rpb24gdGhhdCBzdG9yZSB0aGUNCj4gPiA+ID4gcmVzdWx0DQo+ID4gPiA+IG9mIGxvZ2lj
IG9wZXJhdGlvbg0KPiA+ID4gPiArICoJCSAgICAgICAgICB3aXRoIGxlZnQgYW5kIHJpZ2h0IG9w
ZXJhbmQgaW50bw0KPiA+ID4gPiByZXN1bHRfcmVnX2lkeC4NCj4gPiA+ID4gKyAqIEBwa3Q6CQl0
aGUgQ01EUSBwYWNrZXQNCj4gPiA+ID4gKyAqIEByZXN1bHRfcmVnX2lkeDoJU1BSIGluZGV4IHRo
YXQgc3RvcmUgb3BlcmF0aW9uIHJlc3VsdA0KPiA+ID4gPiBvZiBsZWZ0X29wZXJhbmQgYW5kIHJp
Z2h0X29wZXJhbmQNCj4gPiA+ID4gKyAqIEBsZWZ0X29wZXJhbmQ6CWxlZnQgb3BlcmFuZA0KPiA+
ID4gPiArICogQHNfb3A6CQl0aGUgbG9naWMgb3BlcmF0b3IgZW51bQ0KPiA+ID4gPiArICogQHJp
Z2h0X29wZXJhbmQ6CXJpZ2h0IG9wZXJhbmQNCj4gPiA+ID4gKyAqDQo+ID4gPiA+ICsgKiBSZXR1
cm46IDAgZm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gPiA+
ID4gKyAqLw0KPiA+ID4gPiAraW50IGNtZHFfcGt0X2xvZ2ljX2NvbW1hbmQoc3RydWN0IGNtZHFf
cGt0ICpwa3QsIHUxNg0KPiA+ID4gPiByZXN1bHRfcmVnX2lkeCwNCj4gPiA+ID4gKwkJCSAgIHN0
cnVjdCBjbWRxX29wZXJhbmQgKmxlZnRfb3BlcmFuZCwNCj4gPiA+ID4gKwkJCSAgIGVudW0gY21k
cV9sb2dpY19vcCBzX29wLA0KPiA+ID4gPiArCQkJICAgc3RydWN0IGNtZHFfb3BlcmFuZCAqcmln
aHRfb3BlcmFuZCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gICAgLyoqDQo+ID4gPiA+ICAgICAqIGNt
ZHFfcGt0X2Fzc2lnbigpIC0gQXBwZW5kIGxvZ2ljIGFzc2lnbiBjb21tYW5kIHRvIHRoZQ0KPiA+
ID4gPiBDTURRDQo+ID4gPiA+IHBhY2tldCwgYXNrIEdDRQ0KPiA+ID4gPiAgICAgKgkJICAgICAg
IHRvIGV4ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBzZXQgYQ0KPiA+ID4gPiBjb25zdGFudCB2
YWx1ZSBpbnRvDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gDQo+IA0K

