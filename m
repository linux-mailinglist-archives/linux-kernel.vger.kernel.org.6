Return-Path: <linux-kernel+bounces-177659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4A88C42A8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96A3A1F22326
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EB815358C;
	Mon, 13 May 2024 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Mid47Jlc";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iTm9G/zU"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029C514EC7A;
	Mon, 13 May 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608652; cv=fail; b=c6rrdQsgrEAnz5chuGtCoX/VfW2ZPTXn4uuNsmRoybGTJIOUpxPp9UsXAU35PZar9FJqgfb/3bdFkRvIm+hZQMuH1Qt6zsrNd8Di9K6WpdHJo5V1lvnY1OS8h9qifs5To5eKJoQLXrWPH3LecyJ+p8cyhmP6BOcAcNEjMrjTzW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608652; c=relaxed/simple;
	bh=ECqk6w73+q6e4wMCCPJor8mVmE/27KI6z9lgmatb39o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sc+g+vNh8fnfX1n5SvssDsumJeckPblRVC7T2bVp3v2yYPuPgC2el7Pvu+TK0NRc950vio1zprD/vX3CTZzV1DNKTlGcXtfE3bkEvznBudikKhCQImvMAdtcNeARYjnpawhnhc9iPItEoIHJwRlAgoLdyQmhZtZNeGXIj4LgG3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Mid47Jlc; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iTm9G/zU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b8fa7b1c113011efb92737409a0e9459-20240513
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ECqk6w73+q6e4wMCCPJor8mVmE/27KI6z9lgmatb39o=;
	b=Mid47Jlc+dOhBtgm1DvyWB3aEmuhjq0zFBIHsVMBsw6Eab/aRubbOyhVjBRDV/3vdGcER+8RK73OokajPpqusQIHPFYE+YiYsqYcLT3K/5K4G9WnazPBly5fm1uPT6aTQNO9MpBA3Wo2Qi6YGT5zUvTBRQ6MNkODZwoyebir2m0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:70bc1a38-1184-41b7-a806-70a9fcc44d82,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:caf24b87-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b8fa7b1c113011efb92737409a0e9459-20240513
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 161046016; Mon, 13 May 2024 21:57:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 13 May 2024 21:57:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 13 May 2024 21:57:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i57Mxnwzd+igoGLMp1dhYP5M608ledQQkCPZV9LvKayuzsvGtqgj6XAx2RDRG2+t265T5MWCvr7ZYnttSZ+3qohxm/06s2wmnwXua3vfXTssC853RXV0RQVX9X8mwXXhBrpSgRph0vz38YvN642xd6nfKaK+9eRifnUYcmdXLYGZ/MF9y8zBubJpVDVlCwe946mEzHg8ncYgqF3WQClN+kKl5KLelvzDsY4zlUNyy86Q9Jpwus9Mi6rx+DBUxHVmb/YRH6av9mmr4nL91rGMGnfvw/+7iMHVWR8VPqWswZkg9KJa7QufJvI+mE5HEFOMnc5VMy3VSfSXR6J5qzv4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECqk6w73+q6e4wMCCPJor8mVmE/27KI6z9lgmatb39o=;
 b=NbWNWf/CNdcNJ4F1pNxuLJBwefgJSG3EqkE/ME/4HUI6hP4e3ffxiRNEWmhhWkQ40RUvCApz/9HbWm6rZO/zCFEvXyFSLEBIoddI1dsAIA/GRsrAxiyf+IBkFkTwav20uz23eW/z+gbIRxLC01wtl47ziD0nVeiF0Qq0Yl64sLiC30RF49gtiAgL3O3F6Pel1PPUctMQk28DjY+aZj3HZ7rvKVMTQlpBJsDvrbNLAigjD+4CfclYAvQzp83VvkcqR60PatDb776RF5j44IkrGj9oIU00w2TWV6K5DwcvaCb8W7UkOiJmjZPxPhkV/SU12NK/AUxgTAk2jDRthiFp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECqk6w73+q6e4wMCCPJor8mVmE/27KI6z9lgmatb39o=;
 b=iTm9G/zU4S+UX5RfOEg6XBUKLtads0MCF67COwQOvm0zoav9ANW2vDDydBv5/vS4DiHddp9nVj/DHWj7BPYLgg4ALTYySzlLTuUaRI3aB6+d2/dRSpWzGpYogwAlY1cUXoj0KbdndIQX1ZjVDMBtwEFSwNe+FZ7MujK3JGsj33Y=
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com (2603:1096:400:70::13)
 by KL1PR03MB7694.apcprd03.prod.outlook.com (2603:1096:820:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.24; Mon, 13 May
 2024 13:57:17 +0000
Received: from TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3]) by TYZPR03MB5760.apcprd03.prod.outlook.com
 ([fe80::10a4:6aaa:bf25:96f3%5]) with mapi id 15.20.7587.021; Mon, 13 May 2024
 13:57:16 +0000
From: =?utf-8?B?TElBTktVTiBZQU5HICjmnajov57lnaQp?= <Liankun.Yang@mediatek.com>
To: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	=?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "jani.nikula@linux.intel.com"
	<jani.nikula@linux.intel.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add PHY-dp bindings
Thread-Topic: [PATCH v2 0/2] Add PHY-dp bindings
Thread-Index: AQHaosoiqml2qoxl+0yZBwYM/X+6e7GQVIsAgATgzIA=
Date: Mon, 13 May 2024 13:57:16 +0000
Message-ID: <733903014e17a244b123c1b4ea773a9c642e2c51.camel@mediatek.com>
References: <20240510110523.12524-1-liankun.yang@mediatek.com>
	 <87frupj49h.fsf@intel.com>
In-Reply-To: <87frupj49h.fsf@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5760:EE_|KL1PR03MB7694:EE_
x-ms-office365-filtering-correlation-id: 2ce9f9de-b5b5-4590-3d1f-08dc7354997b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?TzlEWFpOVDhKMnphMEdEc2lLN29XR21UMGJWcFI3blVRYk5oTy9YTlk3V2V4?=
 =?utf-8?B?NHY5dTNjZGRqU3lTUGhjVm5hL2psSm1QcVBhdXI4VG53MGJaMzJTS3FUWnRG?=
 =?utf-8?B?L1FRN2lFRElNVHMrRFM3SUloUHk0MGh6Q1R5N0dWRllCRWVBNktvRm5DZUxj?=
 =?utf-8?B?d2VNb2I0VStFTFdkS3pHeGIwQzhsTnBUYXV0a3AzSnhxWm1MSy8rRGRua3Js?=
 =?utf-8?B?VDJzR1lkajBEQzZPTXA0d3RqRlVvdFlvSEFJeGdPcVl5UDdnSmtyUmp4d29T?=
 =?utf-8?B?SWJvcHZIYlcyUmJrbkN0eHFUbkhzUkMyREsyUTdPT2tJMGF5OVh3TVJkOGly?=
 =?utf-8?B?Z3pjT3I3VVlqV21HaHlpWkgwRzYrLzNrSG1RSHNYWVNEOHpDQVNGS1JuaTQ1?=
 =?utf-8?B?Rll1SWwzTXJpY21UbDJ6R1RzTkZoQU9BYklJMWpUaXp6NzU4V1hZMEpZOGd6?=
 =?utf-8?B?Y010aFg1dnVJVkZPZ2ZKSGs2TVUxVGRib0xwNFBiQjB0VzB3VWFrVkR5ZDNL?=
 =?utf-8?B?ZDFFNUlzT2lHTDZmWEhVUldsWEROMWQ4WUpzdkZuQVlZRVU2TCtsTWpnb2lY?=
 =?utf-8?B?OHVLSnFXeExkU3VIU05QMnJvS1pndUY5RmdyV3FSUnNxYlpKNU9GRFdzczRy?=
 =?utf-8?B?NnJCR0wrT25BbDVMNmYwa3ZyZllUS3ExbGsvcFIwYlNKMHpRZVVEZ2VFUUk5?=
 =?utf-8?B?Z1lueU4wRHUyVDRwSmFVL2xucWlBRTdsbDZIZEdHV3FWWEpGTEJucGNRWWZz?=
 =?utf-8?B?VUxiQUY5S1EzaXFVb2lwL2cxTW8wdEFPRmxrSVNMMGJWc2h3eXFTaDdXenpY?=
 =?utf-8?B?R2t1cjNqMjQvbmMxeWkxa21zcGNQTEZhVENIc2ozeVBxRGF4NEU0TFJaeVVH?=
 =?utf-8?B?WHh5VmlTYlpSTXlkellLVXNUcWdCY1h0UHRTK2VKMnRDK1V3ZmhoZi9UbzRv?=
 =?utf-8?B?ZlV3dmRrMTJucFNTUC9BVHZEcXpQMUkxU3JZYTU0Q0Q1Z05YanUwNllJaksz?=
 =?utf-8?B?ZUtJeFpUd1BmUmFZTU15RDFGK2gyVUY1dTRGTyttbkJZeEI3dHpxWE9OMzdr?=
 =?utf-8?B?SWFEZUVRTTNvTi9mWmtGMHY5YjJSU3IyTkVqaktxdlZXVDAzM0pMZFNHVUpB?=
 =?utf-8?B?ZTZyWUxkVldFd2Qycjk3VVpjbmdhQldwWWh3U2Fna2NGbTVxam9pZUNaWGV1?=
 =?utf-8?B?aWR4RlJPU3FkN0x3MURhSmlnc2JZWVRnZk9LZ3RCQlgzR1pzM0l2Yi9mb0hi?=
 =?utf-8?B?N0Y5UWtzUUVxTmlsdEJvTUEyT1BsMVZWcUNVVVdTVFVraU9BVmo5VExYRUhv?=
 =?utf-8?B?bWkzOU9Cclpmd25na0M0VXQyRzZnR0hUVEorT2NuT1RLME1WRnM4NEE3SkRX?=
 =?utf-8?B?VU5YTjNZNXVpS3lmSzhlbU1idjg2S1liQ0NzYXI0YW40SExmU253cytwZW9v?=
 =?utf-8?B?Tnc2UHQ5dWp2U3JQWHMyUTdZdW1mOWtSNGw1cWRmMFB0R0JnRnJJcjNuMVp5?=
 =?utf-8?B?NG1XZ3NkUmpFbExkb1hFQ0VQeWVERWFJVndHc1lxSHRYRXpteTd4UWhsVHhK?=
 =?utf-8?B?Um5WeStWY3hjcEIvN0tZL1E4SWpubTBYQWJ1MVNUekFlaTMwNzR6UHZIUG8w?=
 =?utf-8?B?dTdpY3BOVVJXcFE0S2lTYUR6ZTV4VVpNcXFUMFNKU0wxZ2xLMFRYTi8rUWpE?=
 =?utf-8?B?enlhc3J3WGRjMmhLRnBTTGE5TXJHRFhlSkI0ejZVdGhPZkRIVFk5bHczeXRS?=
 =?utf-8?B?czh4dVNQRVB3amZOYkNQdXYwQ3ppMjBOUXJ0R3d0ZkNlM1NTcnJkL3RKSW5X?=
 =?utf-8?Q?SupC/82IyQmCYqr5VJpcTAjyDoytrcj/Vp33w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5760.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlpVckZhYzVVN2JUbDFsZWhDSmlGR1N4UzRHMHFhMm5aNGJIQ0lEVU5xRkNI?=
 =?utf-8?B?TURFNitib2lrMlJkUktQT1hncDBDOXdldHJYZTlwQS9pWkR3dUhTR29lLzJW?=
 =?utf-8?B?UW5LOUtTTmQxVHRueWdTdThIamcvQVRsV294M3hobmp6blI3TC9RWGovc3VQ?=
 =?utf-8?B?U0d2THk5UEtuS0JqYWJJUjNSMjRWaHI2U2FrdHlQYndDN3ROVU9vZWQ3ckwz?=
 =?utf-8?B?SXBoeGt5RG9EYVJobWVmUjhydTVabEFUUU9VeGRjMlhtSHM5N0R6UE8xbzA0?=
 =?utf-8?B?TzE0dVFxRDNhVUQyZkhzTGdPWFZLWHVpOGg0VmQyRmh2RG5mYjBlTmtJTnRi?=
 =?utf-8?B?OFpYNmo3cVZHN2hRSDdyb2k4eUNyMVVTTlBNOFNSdlpUQ2sxMHFBQ2cxaEY3?=
 =?utf-8?B?RkoxSzJCVXJ1K1VjVFBDU3p4L2JJeER3MXVCdXcyZFJ2eTV6WHBGRVJSNjRB?=
 =?utf-8?B?NFJFWnY0c2tVa2tXQzFGV01KeFZEZEJPekZwanc0Qk44dmR3dWNTNXFxd0pw?=
 =?utf-8?B?cUd2MVhUeHpmRkcvN1Y5Vkd1eENXMEpvNk4rQmpFbHgxNVdRZWsrdlpta1ZJ?=
 =?utf-8?B?dlhoWDNhT09nOUxVMDA1cy9FNFNZNHBRWGxOa1FaejdtTTNNT3E2cWY5WEts?=
 =?utf-8?B?K2szRFZvcnJyeE9GMlF1SWFmcFUyUlRJOUllcnpCNGdzdEZCS0JubitxZjhX?=
 =?utf-8?B?SldGcWxMQ1FJdEhaOFptOTBSMjhrVGlHMG9DZXVNdHB2MjdlV3d2S3pqaFRs?=
 =?utf-8?B?UDAwOXNZdHFKU3lXQ2dlNzlmeFZDNTN4T0ZuT0E2NER5azhOUm1Hb3lIMHMx?=
 =?utf-8?B?THJsU0svNy9GNktZYjdnSzZSVktCcUJNb1VVYW1WZjVzTGdEZldaMDR2SXV3?=
 =?utf-8?B?M3phU0oxMWZINm85c3p4b2JSd1dpYW5DZlhZcXpsSmh3VHBUeUJFZUlZNmFF?=
 =?utf-8?B?S092K2xQSGZtZGgrLzc2TmErOE5qRVJMTU1YT0llT0JqTTlpM2liRWx6a0NX?=
 =?utf-8?B?NTV3bkI5QW9oWTVzNnp4V3NXbEZ2Q0ZBV21UdThxdm91UEhDK2owT24yMDVZ?=
 =?utf-8?B?SVN6MDJXUUhRcFhXczc0cTJTM0tweGdxZG03clIxK05CWmRHbzZEazlkYWtH?=
 =?utf-8?B?TVl6TnhsMmh0YWhHZXhBenR6VlNSejlHdm5tYzVxQklOUE1oU3dNWC9aOElZ?=
 =?utf-8?B?dVhCclM0L3JrL0I1Z1lPcE0xQUFTc1psU0hPZmExR2VycFlQVjVlUTRjOUxz?=
 =?utf-8?B?Vk5NVmE0RzNua0ljWVEzNnhvOEFrSWgzellLUXM3NmlOcTFvVkxKZC91R29w?=
 =?utf-8?B?SmZ6M3V2eVh0QzdnQWZ6MzZDczFLSFZ0RmhGZEpIdytKa0E3SHM4WHEyempu?=
 =?utf-8?B?UXNpLzEvalE0TUt3Zjk5SjRRQmVKeDFST0ZxRElnNitURitGbVVKMWo4VzlX?=
 =?utf-8?B?TmFNVUg5Y0c5MEUxeG92T24raFE4ZVlBMHdUTW9YbUJ6SXFwUkVuRW4rblBw?=
 =?utf-8?B?QmFhWXl0Sys1ampXa2taOGhyZEtPaWJDclhidGtNeFB3YjVzaXpPWlRIS0FK?=
 =?utf-8?B?dzZJaThVdDIxMHhSa1dDa0loT0cvN0IwT1pnVVAxYU5zT1MvdGs1TEtHY2Fh?=
 =?utf-8?B?YW1qZ1d1ZWlaT3dqYkhveCthTThSeXpMU3V2Q1Z0VWxFQ0tGakQzR2hrNVVq?=
 =?utf-8?B?a2JVRms4aVpsVWFqSHZJSFp6QUpLcUdLYWoxajVBYnFPTFphclZSdk1wcE5V?=
 =?utf-8?B?S0RGcFBvNzdFMy9WenJJTmJoS2VKQzMvZWRwNjZaQjJLR24rZHNORjRJN3Uy?=
 =?utf-8?B?WHBKZjE1Y2FiRGVnTXZKQXVvYVd4RXdIekxMOC9pbEhjSDRGbTAweWQyaVpI?=
 =?utf-8?B?ZXVXQTVzY0NDUDh0ZWU0OWlKaUN3L1FkY3ZLNGFCUHpNa1U3OW5lSWVWQU9o?=
 =?utf-8?B?KzAyeDFZS0pZbDZJUFZoOUZnSkh4Y0duOEFOWHFBbS9lSng0R0FjRUxEclMz?=
 =?utf-8?B?VW0yaHZsUVVldnB5aXRkQ3JXU29WdXpjcHFiYk80Y3ZPbFVDbWVEcndwZWhV?=
 =?utf-8?B?VGVSLzN3eDFPeE1KSmIzM2JsZzRCeUZJT21hQzVGNGRZV3F4VUxFaEo2dWp1?=
 =?utf-8?B?NngyZzFxWWNKbGZwTENwLy9vKzg4bHVkT2dGRHFoV2VreGVNUXFBNjNWM2N5?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <544A0E376E69C241A7C4F5834109B162@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5760.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce9f9de-b5b5-4590-3d1f-08dc7354997b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 13:57:16.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuKOPxstLfBPkk+fovHeL7q5hjnzW/g4vHaWMvC1yrdb7/N2gEDto/qGNklIZw6AOXjzPlL/QKCbPnn2KWUrkGjltib8RBMEpI9YoH+9NZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7694
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.698800-8.000000
X-TMASE-MatchedRID: u8usGLXufdjUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCifZYRtbOr2t4bl1FkKDELe7nrAU9KQxUUdmDSBYfnJR2Pd
	mZeuCYyAhwOPGMImCWoOouLcqSmHWgGgbIWz4XUxQiFNNqFvt1Z6KYa03LCO231GU/N5W5BAwrA
	JnuG4aIS0hw0Iv7WVP/3Hwi0zbYrU6SNANGjU5lJ4CIKY/Hg3AwWulRtvvYxTWRN8STJpl3PoLR
	4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.698800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E21DE6FA4E6A8CB06B9C5D6BD489F2510F7EAFB291E4EB0ADF14DEC29F2BF36F2000:8

T24gRnJpLCAyMDI0LTA1LTEwIGF0IDE0OjI3ICswMzAwLCBKYW5pIE5pa3VsYSB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBGcmksIDEwIE1heSAyMDI0LCBMaWFua3VuIFlhbmcgPGxpYW5rdW4u
eWFuZ0BtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IFVwZGF0ZSB3cml0ZSBEUCBwaHlkIHJlZ2lz
dGVyIGFuZCBhZGQgcGh5LWRwIGJpbmRpbmdzLg0KPiA+DQo+ID4gTGlhbmt1biBZYW5nICgyKToN
Cj4gPiAgIEFkZCB3cml0ZSBEUCBwaHlkIHJlZ2lzdGVyIGZyb20gcGFyc2UgZHRzDQo+ID4gICBB
ZGQgZHAgUEhZIGR0LWJpbmRpbmdzDQo+IA0KPiBQbGVhc2UgdXNlIHRoZSBwcm9wZXIgc3ViamVj
dCBwcmVmaXggZm9yIHRoZSBkcml2ZXIuIGdpdCBsb2cgc3VnZ2VzdHMNCj4gInBoeTogcGh5LW10
ay1kcDoiLg0KPiANCj4gVGhhbmtzLA0KPiBKYW5pLg0KPiANCj4gDQo+ID4NCj4gPiAgLi4uL2Rp
c3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWsucGh5LWRwLnlhbWwgICAgIHwgNDUNCj4gKysrKysrKysr
KysrKysrKysrKw0KPiA+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWRwLmMgICAgICAg
ICAgICAgfCAzNyArKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNl
cnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlay5waHktDQo+IGRwLnlhbWwN
Cj4gDQo+IC0tIA0KPiBKYW5pIE5pa3VsYSwgSW50ZWwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNv
bW1lbnRzLg0KSSB3aWxsIGFjdGl2ZWx5IHN0dWR5IGFuZCBjb3JyZWN0IGluIHRoZSBuZXh0IHZl
cnNpb24uDQoNCkJlc3QgUmVnYXJkcywNCkxpYW5rdW4gWWFuZw0K

