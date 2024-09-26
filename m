Return-Path: <linux-kernel+bounces-340233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC31987043
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC4831F2817A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D224A1AED37;
	Thu, 26 Sep 2024 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PB0Wn0by";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DnyDqSbm"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD531AE87C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343042; cv=fail; b=m41wiAGF+K+vJ8KYS6betfmdbxzPJYgiyFKoOZDYxvCCRzT1776J9Nf4aN6DksGuZXv3tJDE9uKTpSBougNrj6rOxZaZRfX9e8nFAFvRjss5x753IUbHx27OpnA96aWW8GK+kO8myCOVoLTYPpLvHkIdZOsygxPyfUvbgv+CFU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343042; c=relaxed/simple;
	bh=0b7Hp3b2LMtTe+ZHJF1egm6j7MrC3HBMd9ed88FAg80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JGUSG4WfZKcqgth+yHcQauGPPGEjTbCdk0WotGY2fbaQJW2eB8LL7/ZPT3bsGuWEqFAKme7XwTEQApSRCQ9XRdUYv0t3Hreu6WfskuXqcGAnxHLAdGoIkzznf38RjBkiuTBIf/xYjuHdyuLhBouEzN2JOee4AzeJZu12EHs/NJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PB0Wn0by; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DnyDqSbm; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f9caa0f87be911ef8b96093e013ec31c-20240926
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0b7Hp3b2LMtTe+ZHJF1egm6j7MrC3HBMd9ed88FAg80=;
	b=PB0Wn0byOzFK/VP2TD+Ke3DC/Tq+XV9DOuMAa8iafddZcRwVICK6urGY11grNrprB6AlfBWsJvhpFEVoPhZ6dBukOaWC8P6tZrKNFd8wuuddJVZJIos1RjSlNg+b1DQAO3rvvPu63dikZKwoHLwuLzYl7sieREMqJZt4K+skw1o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:ef8d4f1d-740f-495b-a487-29befe365bdd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:dfb8cdd0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: f9caa0f87be911ef8b96093e013ec31c-20240926
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 793125718; Thu, 26 Sep 2024 17:30:32 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 26 Sep 2024 17:30:30 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 26 Sep 2024 17:30:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXE7to3+vFp9GqhtflwW2BLm1FZRRX9nvwlVl2KNyI9ExpqUfY82GEWH5JH+SoHR3p5s5kUjy0LLcFzM+gnB5mF4j5I4QjwNvbRcN4u2uy79smbbQH/T4okgqc0Hc13dtVa1uCtxdUOIH0GULGe2WR8uv/3FU5tyb09qtIu6PqSsfKzwHZ8TNDo/2y6U2NtMftURjawRVFypFpQjofUpMOdwTtMbTJrul/7ldGBY6wcKfT3dUusemq78sXKFxzG5WwDtEFMSQELfKm0myeG1ZMlGItd4dPPosGUN5Bg09kVzn3pJX8nCE6tvPBO0A/DGzXp/CwhvqfGPJ2jLrtkH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b7Hp3b2LMtTe+ZHJF1egm6j7MrC3HBMd9ed88FAg80=;
 b=Y/8mZ3Z3j+5X4WlIN0FJBnGvnpQjAmnmx+P+sVJhAqdd1SYnWkBbPV6/Pnjj+niav7xh8smlE2vAWSPtb8Jcq4CM+UVXIXikNXuN5y1phSORsLaRfmEZtrOopeZ9hKJLiv+TZxK23F5Y6q4qL1ajG0NUtaPgCRDRcqBX+kotKxXVKnSDz4we5J3a5OTqcoMFboFvNZpAOwccnPzbEy/0/d/xkcmeP9EiNp1T+MEWscXtt+cPu0usQa4nBmjGqFljvaSVOC0sXPMgeGib+CD9oCOgqwFtPETX0VGTUs2dw6jZGG3HNdi2B7pn5u4vnUJ/uECiHr14Uodno1EhfDapSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b7Hp3b2LMtTe+ZHJF1egm6j7MrC3HBMd9ed88FAg80=;
 b=DnyDqSbmHyj9+e8P/4QvlssFBdTzERu9vuIDm5T1XF1juVVfz9pM9S3adOVbhvaTaYE4+98I0CYnIn2/qaDyMJ3W9iKZutSt1bcRE5Wow8qwPN9rBk1PdNvCcBGekJvNstSVxq4m32ztLtUWJYiWusyWg22HYdk/Wx9ma3pq4zU=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by OSQPR03MB8457.apcprd03.prod.outlook.com (2603:1096:604:274::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 09:30:27 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 09:30:27 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/2] drm/mediatek: ovl: Add blend_modes to driver data
Thread-Topic: [PATCH v6 1/2] drm/mediatek: ovl: Add blend_modes to driver data
Thread-Index: AQHbD+8+Ip/rK9oj2kWAG+BZKZsksbJpzZEA
Date: Thu, 26 Sep 2024 09:30:27 +0000
Message-ID: <a3da0d24e6749b054f8a65656ec40d4aa0b9f2dc.camel@mediatek.com>
References: <20240926083526.24629-1-jason-jh.lin@mediatek.com>
	 <20240926083526.24629-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20240926083526.24629-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|OSQPR03MB8457:EE_
x-ms-office365-filtering-correlation-id: 4c1def8f-9452-4067-7eff-08dcde0ddb3b
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TmdPUGN2VE4xc2NheFE0bDllaEVQdmp2a0tPRFczQ1djVEE4dzFnYktMSkxW?=
 =?utf-8?B?RUdtL0lpMkdiVnY4eDBmYllDYkNwbkdEUjEzYUFQYzNNVHpqK0pFSmJ1MU1N?=
 =?utf-8?B?N2djVjVWRzRGTVF3MWd4OVYwYXJ1M2ZZUGNqSU9WeUtrSGpmR25lYU56bjBx?=
 =?utf-8?B?aGtzOW5XaEJLcHNHY09KcUM5TFNpS2FMRkhQd0tZNWRPbG10TmdoQmtUSGh5?=
 =?utf-8?B?bk11cVloUXFHVmhwTWVaVHp1UCtsaThVODJoUlRqV3d4NC9yWit4QnVQbnJM?=
 =?utf-8?B?bXNSZXo4LzdtbnMySk1ad2E2aVJaUVFjbU1qVEh0STdiMUtMbmFvcExkK2tK?=
 =?utf-8?B?Q3hPQWxwVDRPUXRwQ2VlSzg1dlVBYkY3VVg4RGkydGlSQTFYRnRXalQ4WkFn?=
 =?utf-8?B?Q1RrblA3d2JkWmlrZXZOOGlscWJPYjRNRnV0MWE2Q0xCMnVDNWM1Nk5iN2N1?=
 =?utf-8?B?dGFGRXdRRVdYSHRyZnUrNDJRQ3ZRMjdIN3FMWkxFVlJiZDZxd0VSZnkrWnVo?=
 =?utf-8?B?dlVlSDlpQ01xTXpoSG4rNW94R1MwYW9tSUpRMWtZVzBuckYxbS96RDNmUmZV?=
 =?utf-8?B?QWsveHZaMG44cWdCSUprdFVaQVlLaUVVSUUzQWEwbEhYM2hDNlhPdmVweXgx?=
 =?utf-8?B?MERZSUxyaC96M0loTjdYY0tZTTNhUys2VGU1MzVlbFh6NXArdjR3aFpFS3FK?=
 =?utf-8?B?SXdrM2llOG92R2ZPN2QzUTlNT1ZBS3JCSWYvTnhGWGtSYUhXaUlyRklqS1R3?=
 =?utf-8?B?cDFYTzVZNnFJL2JGcjZJN0RHOTJ0TjhhSXhEZGV0REc1Z1BTNElIeEphSllJ?=
 =?utf-8?B?VUxjNnZINXNSTGR4T1ljMmw2MG5naTAvQXJVNndCLzFDKzVhYkp6OEtvVVdM?=
 =?utf-8?B?OGx3bXFRbE1JdDFtaEY4ZDFtMGlIamZDUzc1c3RWQ2YxeUVGeVNoa0tvcDhF?=
 =?utf-8?B?akQ2UHA1Q1B1RVVRbEhPakpzK1BpZGRrOFl5S09XM3liZFV6Q05uY2dhdmJS?=
 =?utf-8?B?clhwc3NyYlVqSHdIZDBjQjJxMkxDNUExR1BreUFRUmp0U1BJU1VERmd0Nisv?=
 =?utf-8?B?RTgvYUl5TFlzZzVDT25FMEpCajZnMUduMmczRVp5OEFnKzBNa2tZZWc1VlJn?=
 =?utf-8?B?WkY0VFhOek5RQ0FRb3pERUd1aVpzVzVqbXZwK1RKNWRVbmd6eDhsODluKzRa?=
 =?utf-8?B?MTlXZjNUUndzRFBnbm5lempZdkQwMHlEeUJtNFJZbHBEWkh1STY0K0NncnND?=
 =?utf-8?B?Y2Y0b2l2TGQ2L3Jja29lbUU1Yzl6d29BNEFWU011VENBcVk5VTFVZGRFcTl1?=
 =?utf-8?B?K0NobU1KeGVWb2htNHhjM1JxTmRVSjdvNFMvL0MycFUwbndlRm1LUUJyTC9V?=
 =?utf-8?B?RlZZNFBaL0o0OUVMRnlVRzBzTnI3Sys2NzBhRUhWTWR4czRNRGs1cWR0NDhw?=
 =?utf-8?B?TytEUnJNTXB5VUZFWGg4TlQ1NWVtRDVMdE1qdFhhK05ReHZNWkZyNnpTWmww?=
 =?utf-8?B?dVRaQ0JhTjN0N0gvdXNKcU84YlJZWWgweUs1ZHZMY05JVzZHU2JpUXdZTEQz?=
 =?utf-8?B?V2tiS3dnRnJFNFVjNnlQZXFPamZ6S3hWZzRPZmtKVzRScjVzbkJQRmVrWUUw?=
 =?utf-8?B?TmhydUNSYzZpMDdPR0lMVDZDang0Ty9BWllUeXBVNmZzNWwrT0p5ajBHcHk4?=
 =?utf-8?B?ZUNBSkRaTWNVNFI0MmE4NVN6N21aRnFiTGdhQ21zRFEzUFFFY2FVbnY3cEJH?=
 =?utf-8?B?SlBjWVBVOFVQdlVyeEtXdVhGeEEwd1hlc0MrK0o4cEtQa3poVDNla2dCZ1NO?=
 =?utf-8?B?WWd0TjgxdGlLVnVzQVM5Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0tMZTZwa2lZb2ZCVk9RZHd0Qko5Z3VkNm00U1g2M1p4WXJQaXNPcXo0cFJ3?=
 =?utf-8?B?Ykx1ODQ4TXE5cHNMc3NaU2dkeHpXOEIxM1g2OFpTUTFteUMzS1pyZzdESXlZ?=
 =?utf-8?B?M0d6bWNwOFZjSGlielFDeE9rKzdIcERWOUprWDdpNVg1cm1QbitwMnZxV3N6?=
 =?utf-8?B?QVhRc1o4RkF0SzB4WXRjcUhTajNBNldjUEVwWmo2ZFNJQnFESjR0MS9ZRlB4?=
 =?utf-8?B?RXNlQTRQS1NvSmdiRit1WGQxNDFHSzVOSU9vdHRQRVJIaFlGK2dTdXhhNlR1?=
 =?utf-8?B?bzJkSUZ6U29VQ0tkYzhLMkdRWWhpd0FwYlJ5bSthTUtOSjZEWkk1K0pQZlFU?=
 =?utf-8?B?ay9iVUt3eitSRmMzUkNZWEhuTEhMV2ptOUVxd00xYWZldS96UkttbkZwb200?=
 =?utf-8?B?bFRENFVrRGNyOTNRWW1LV3Y3Q2xacjBrNlAzWHhKckk3bnYvWTJjUWwyNWNS?=
 =?utf-8?B?M1l5OVJaQWczd0R2UEhqdEFadENCME5DbTRwaDlNODRPTmNMZVQydWx6VFVU?=
 =?utf-8?B?bVZuUmg0YVlsY3ZYL2hEWVg3WUJDTHRjZnJXQ3BHK1VtYW1QUkdKbXVUN2Ez?=
 =?utf-8?B?UnZTbmRtYTVQS0NIZkhEVk9lbnEyYXdaSnF1ZTF2WWZ4MGlTQ0drOER0QkJQ?=
 =?utf-8?B?b0pMYm1YVUluZG1KRHkxeVlEeUFpejlFRHpMei9pYmljZVV5Rnp1QUh6MlY2?=
 =?utf-8?B?ZTlSUnRHVHpDN0hzc1c2Qm1uVWxuSGZXbFdBQzZjT3R2UGZ0TnlSUUdrYTdU?=
 =?utf-8?B?bGN2WkpqYnEwZEdQbnByZ0V6MVVKVjdTQmFCVGgvMDg0MFk3TXFFSDZlUXpu?=
 =?utf-8?B?a3lkMDdHQVk5R2wvMXg4TVVwTk4zRCtIN1VyTUxlc1hqMGVNejRSZzdPNU1z?=
 =?utf-8?B?NUN1L2I0TktuQm1BSzltd3JHR3hyK1U1VmZIa3dwT3hzNEtXSVphb1U0MFZl?=
 =?utf-8?B?MTJ4ZDdTM0tXdUV6VEYxNmJYeHQ4YkljdGFxb0tVUUN5dlg2TXQ3ZGRNc0hk?=
 =?utf-8?B?NGV0VHJCaEFUY0I2NUVJRmRQVjJqcU8xL0RKYUY3YUhTQUVHUFJRSS81SkxJ?=
 =?utf-8?B?Q0hNaXhkRTJ1KzRsSzZUMFphTmROL29aaGhUM2ptbGV2RXI5S3MzZ1FSbDVn?=
 =?utf-8?B?RUxCMkNHZmJoWmgzR1l2MTFYcWlFamt5UjJCS1VwMXNLWTF1c3JNWVlEdUdS?=
 =?utf-8?B?WVpLR1BreG52L3k3a21nWG1mVHNZNk00WncyOTVuOUg1WUF1c1UySkpNckN6?=
 =?utf-8?B?cWJWdHl2ck5nYzNkc09KcFFnWEcya2ErczRId1lNaFl0Rm4zV1ZCeHd4NTEz?=
 =?utf-8?B?eC9tNWpDVEZFRTVSUGdvYWl0eDByM2xnR1RoSFlaNmRyRk1aUDNiK21obDVT?=
 =?utf-8?B?YjlYQU40L2tSdVlEU0dyL0lUanoyME5QbG5lamV5SUk5akF5RGVhZmNYUDZ3?=
 =?utf-8?B?ellFV3U2MUNBUDgvaFFOYnhObzRUci9iRDc1eDZ2d2NmVXhuNnBEcjQ2cEV5?=
 =?utf-8?B?OWRpQVc4VXJjMi9yaSszVnFJcnFiaCtzdnozaGdYYnJpS0hSTjY1WTM1cUFn?=
 =?utf-8?B?RThFR2pFaFZ0U2w3SE1ySXM1NTREOU5tWmc2ZGxValZwbkFmUTVoR29NUEcv?=
 =?utf-8?B?MWpvTU9icnVYcStwanpZUGhZUkVoL0RzK0JjSk8rK1NTUmRHMEZnKzlHVHdZ?=
 =?utf-8?B?Vmhqa3ZSRXUvZ21iMThTUlV2Q0dzUGxoWnhpVXBTTlh0b3RmZ295MU9LdGFp?=
 =?utf-8?B?UzZ5UmNPUDJieGpnc3FmcTY4Z3RyWGwzOXkzMGRPWHV4YmI0ZUN5ZklReUVF?=
 =?utf-8?B?QjJmejFhUW1DREdVS2tsZXZ6eWFEYjJ2OC9sZW1XNWo4eEo4TytEaXJCVE5B?=
 =?utf-8?B?ODNzSENJOU9ZN0E3dE1mMDFJMDFKc0Q4TWFjRVQrUUpHdGEraWNIYm1wcFV5?=
 =?utf-8?B?N0ZoaDN1TWhCdWE2VG8ySTNhT3o3dmJPNUduT0x6T1BJSXc1eWFLWGxXVlNK?=
 =?utf-8?B?Q2tEdXdhNzlVeTcwUXllcUxOa1A2U2RrNDBVQzR0bU5KZ0FMT3RBMjd2NzF6?=
 =?utf-8?B?c0xER3MydGRIY3Z1WHNDK0NXL2FzZFVicUo1elkrRnNMZTRKa2g0cUVydWlK?=
 =?utf-8?Q?rSu+gB9LflC7+usEAPZojzf8o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FABF364940752A418FA5BDB08AC87CDE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1def8f-9452-4067-7eff-08dcde0ddb3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2024 09:30:27.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yFc6Gzss2BkZ044M70kiQEE6ajrMYPc4BTMJMp9HvmWDzpaYFvELC3M+IlfJ3xB5elzGfAkTENxfY86yeQnDVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8457

SGksIEphc29uOg0KDQpPbiBUaHUsIDIwMjQtMDktMjYgYXQgMTY6MzUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gT1ZMX0NPTl9DTFJGTVRfTUFOIGlzIGEgY29uZmlndXJhdGlvbiBmb3Ig
ZXh0ZW5kaW5nIGNvbG9yIGZvcm1hdA0KPiBzZXR0aW5ncyBvZiBESVNQX1JFR19PVkxfQ09OKG4p
Lg0KPiBJdCB3aWxsIGNoYW5nZSBzb21lIG9mIHRoZSBvcmlnaW5hbCBjb2xvciBmb3JtYXQgc2V0
dGluZ3MuDQo+IA0KPiBUYWtlIHRoZSBzZXR0aW5ncyBvZiAoMyA8PCAxMikgZm9yIGV4YW1wbGUu
DQo+IC0gSWYgT1ZMX0NPTl9DTFJGTVRfTUFOID0gMCBtZWFucyBPVkxfQ09OX0NMUkZNVF9SR0JB
ODg4OC4NCj4gLSBJZiBPVkxfQ09OX0NMUkZNVF9NQU4gPSAxIG1lYW5zIE9WTF9DT05fQ0xSRk1U
X1BBUkdCODg4OC4NCj4gDQo+IFNpbmNlIHByZXZpb3VzIFNvQ3MgZGlkIG5vdCBzdXBwb3J0IE9W
TF9DT05fQ0xSRk1UX01BTiwgdGhpcyBtZWFucw0KPiB0aGF0IHRoZSBTb0MgZG9lcyBub3Qgc3Vw
cG9ydCB0aGUgcHJlbXVsdGlwbGllZCBjb2xvciBmb3JtYXQuDQo+IEl0IHdpbGwgYnJlYWsgdGhl
IG9yaWdpbmFsIGNvbG9yIGZvcm1hdCBzZXR0aW5nIG9mIE1UODE3My4NCj4gDQo+IFRoZXJlZm9y
ZSwgdGhlIGJsZW5kX21vZGVzIGlzIGFkZGVkIHRvIHRoZSBkcml2ZXIgZGF0YSBhbmQgdGhlbg0K
PiBtdGtfb3ZsX2ZtdF9jb252ZXJ0KCkgd2lsbCBjaGVjayB0aGUgYmxlbmRfbW9kZXMgdG8gc2Vl
IGlmDQo+IHByZW11bHRpcGxpZWQgc3VwcG9ydGVkIGluIGN1cnJlbnQgcGxhdGZvcm0uDQo+IElm
IGl0IGlzIG5vdCBzdXBwb3J0ZWQsIHVzZSBjb3ZlcmFnZSBtb2RlIHRvIHNldCBpdCB0byB0aGUg
c3VwcG9ydGVkDQo+IGNvbG9yIGZvcm1hdHMgdG8gc29sdmUgdGhlIGRlZ3JhZGF0aW9uIHByb2Js
ZW0uDQo+IA0KPiBGaXhlczogYTNmN2Y3ZWY0YmZlICgiZHJtL21lZGlhdGVrOiBTdXBwb3J0ICJQ
cmUtbXVsdGlwbGllZCIgYmxlbmRpbmcgaW4gT1ZMIikNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24t
SkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBUZXN0ZWQtYnk6IEFscGVyIE5l
YmkgWWFzYWsgPGFscGVybmViaXlhc2FrQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEFuZ2Vs
b0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9y
YS5jb20+DQoNClRoaXMgdmVyc2lvbiBoYXMgZGlmZmVyZW5jZSBvdmVyIDUwJSB3aXRoIHByZXZp
b3VzIHZlcnNpb24uDQpJdCdzIGJldHRlciB0byBkcm9wIHRoZXNlIHRlc3RlZC1ieSBhbmQgcmV2
aWV3ZWQtYnkgdGFnLg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jIHwgNDEgKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDM0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IDg5YjQzOWRjZjNhNi4uMGNmN2I4MGY2
MTJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
LmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IEBA
IC0xNDYsNiArMTQ2LDcgQEAgc3RydWN0IG10a19kaXNwX292bF9kYXRhIHsNCj4gIAlib29sIGZt
dF9yZ2I1NjVfaXNfMDsNCj4gIAlib29sIHNtaV9pZF9lbjsNCj4gIAlib29sIHN1cHBvcnRzX2Fm
YmM7DQo+ICsJY29uc3QgdTMyIGJsZW5kX21vZGVzOw0KPiAgCWNvbnN0IHUzMiAqZm9ybWF0czsN
Cj4gIAlzaXplX3QgbnVtX2Zvcm1hdHM7DQo+ICAJYm9vbCBzdXBwb3J0c19jbHJmbXRfZXh0Ow0K
PiBAQCAtMzg2LDE0ICszODcsMjMgQEAgdm9pZCBtdGtfb3ZsX2xheWVyX29mZihzdHJ1Y3QgZGV2
aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCSAgICAgIERJU1BfUkVHX09WTF9SRE1B
X0NUUkwoaWR4KSk7DQo+ICB9DQo+ICANCj4gLXN0YXRpYyB1bnNpZ25lZCBpbnQgb3ZsX2ZtdF9j
b252ZXJ0KHN0cnVjdCBtdGtfZGlzcF9vdmwgKm92bCwgdW5zaWduZWQgaW50IGZtdCwNCj4gLQkJ
CQkgICAgdW5zaWduZWQgaW50IGJsZW5kX21vZGUpDQo+ICtzdGF0aWMgdW5zaWduZWQgaW50IG10
a19vdmxfZm10X2NvbnZlcnQoc3RydWN0IG10a19kaXNwX292bCAqb3ZsLA0KPiArCQkJCQlzdHJ1
Y3QgbXRrX3BsYW5lX3N0YXRlICpzdGF0ZSkNCj4gIHsNCj4gLQkvKiBUaGUgcmV0dXJuIHZhbHVl
IGluIHN3aXRjaCAiTUVNX01PREVfSU5QVVRfRk9STUFUX1hYWCINCj4gLQkgKiBpcyBkZWZpbmVk
IGluIG1lZGlhdGVrIEhXIGRhdGEgc2hlZXQuDQo+IC0JICogVGhlIGFscGhhYmV0IG9yZGVyIGlu
IFhYWCBpcyBubyByZWxhdGlvbiB0byBkYXRhDQo+IC0JICogYXJyYW5nZW1lbnQgaW4gbWVtb3J5
Lg0KDQpJIGRvbid0IGtub3cgd2h5IHlvdSBkcm9wIHRoZXNlIGNvbW1lbnQuDQpXaXRob3V0IHRo
aXMgbW9kaWZpY2F0aW9uLA0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNv
bT4NCg0KPiArCXVuc2lnbmVkIGludCBmbXQgPSBzdGF0ZS0+cGVuZGluZy5mb3JtYXQ7DQo+ICsJ
dW5zaWduZWQgaW50IGJsZW5kX21vZGUgPSBzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlOw0K
PiArDQo+ICsJLyoNCj4gKwkgKiBGb3IgdGhlIHBsYXRmb3JtcyB3aGVyZSBPVkxfQ09OX0NMUkZN
VF9NQU4gaXMgZGVmaW5lZCBpbiB0aGUgaGFyZHdhcmUgZGF0YSBzaGVldA0KPiArCSAqIGFuZCBz
dXBwb3J0cyBwcmVtdWx0aXBsaWVkIGNvbG9yIGZvcm1hdHMsIHN1Y2ggYXMgT1ZMX0NPTl9DTFJG
TVRfUEFSR0I4ODg4Lg0KPiArCSAqDQo+ICsJICogQ2hlY2sgYmxlbmRfbW9kZXMgaW4gdGhlIGRy
aXZlciBkYXRhIHRvIHNlZSBpZiBwcmVtdWx0aXBsaWVkIG1vZGUgaXMgc3VwcG9ydGVkLg0KPiAr
CSAqIElmIG5vdCwgdXNlIGNvdmVyYWdlIG1vZGUgaW5zdGVhZCB0byBzZXQgaXQgdG8gdGhlIHN1
cHBvcnRlZCBjb2xvciBmb3JtYXRzLg0KPiAgCSAqLw0KPiArCWlmICghKG92bC0+ZGF0YS0+Ymxl
bmRfbW9kZXMgJiBCSVQoRFJNX01PREVfQkxFTkRfUFJFTVVMVEkpKSAmJg0KPiArCSAgICBibGVu
ZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKQ0KPiArCQlibGVuZF9tb2RlID0gRFJN
X01PREVfQkxFTkRfQ09WRVJBR0U7DQo+ICsNCj4gIAlzd2l0Y2ggKGZtdCkgew0KPiAgCWRlZmF1
bHQ6DQo+ICAJY2FzZSBEUk1fRk9STUFUX1JHQjU2NToNCj4gQEAgLTQ3MSw3ICs0ODEsNyBAQCB2
b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50
IGlkeCwNCj4gIAkJcmV0dXJuOw0KPiAgCX0NCj4gIA0KPiAtCWNvbiA9IG92bF9mbXRfY29udmVy
dChvdmwsIGZtdCwgYmxlbmRfbW9kZSk7DQo+ICsJY29uID0gbXRrX292bF9mbXRfY29udmVydChv
dmwsIHN0YXRlKTsNCj4gIAlpZiAoc3RhdGUtPmJhc2UuZmIpIHsNCj4gIAkJY29uIHw9IE9WTF9D
T05fQUVOOw0KPiAgCQljb24gfD0gc3RhdGUtPmJhc2UuYWxwaGEgJiBPVkxfQ09OX0FMUEhBOw0K
PiBAQCAtNjI2LDYgKzYzNiw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2Rh
dGEgbXQyNzAxX292bF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuZ21jX2JpdHMgPSA4LA0KPiAgCS5s
YXllcl9uciA9IDQsDQo+ICAJLmZtdF9yZ2I1NjVfaXNfMCA9IGZhbHNlLA0KPiArCS5ibGVuZF9t
b2RlcyA9IEJJVChEUk1fTU9ERV9CTEVORF9DT1ZFUkFHRSkgfA0KPiArCQkgICAgICAgQklUKERS
TV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpLA0KPiAgCS5mb3JtYXRzID0gbXQ4MTczX2Zvcm1hdHMs
DQo+ICAJLm51bV9mb3JtYXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+ICB9Ow0K
PiBAQCAtNjM1LDYgKzY0Nyw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2Rh
dGEgbXQ4MTczX292bF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuZ21jX2JpdHMgPSA4LA0KPiAgCS5s
YXllcl9uciA9IDQsDQo+ICAJLmZtdF9yZ2I1NjVfaXNfMCA9IHRydWUsDQo+ICsJLmJsZW5kX21v
ZGVzID0gQklUKERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFKSB8DQo+ICsJCSAgICAgICBCSVQoRFJN
X01PREVfQkxFTkRfUElYRUxfTk9ORSksDQo+ICAJLmZvcm1hdHMgPSBtdDgxNzNfZm9ybWF0cywN
Cj4gIAkubnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10ODE3M19mb3JtYXRzKSwNCj4gIH07DQo+
IEBAIC02NDQsNiArNjU4LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0
YSBtdDgxODNfb3ZsX2RyaXZlcl9kYXRhID0gew0KPiAgCS5nbWNfYml0cyA9IDEwLA0KPiAgCS5s
YXllcl9uciA9IDQsDQo+ICAJLmZtdF9yZ2I1NjVfaXNfMCA9IHRydWUsDQo+ICsJLmJsZW5kX21v
ZGVzID0gQklUKERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFKSB8DQo+ICsJCSAgICAgICBCSVQoRFJN
X01PREVfQkxFTkRfUElYRUxfTk9ORSksDQo+ICAJLmZvcm1hdHMgPSBtdDgxNzNfZm9ybWF0cywN
Cj4gIAkubnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10ODE3M19mb3JtYXRzKSwNCj4gIH07DQo+
IEBAIC02NTMsNiArNjY5LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0
YSBtdDgxODNfb3ZsXzJsX2RyaXZlcl9kYXRhID0gew0KPiAgCS5nbWNfYml0cyA9IDEwLA0KPiAg
CS5sYXllcl9uciA9IDIsDQo+ICAJLmZtdF9yZ2I1NjVfaXNfMCA9IHRydWUsDQo+ICsJLmJsZW5k
X21vZGVzID0gQklUKERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFKSB8DQo+ICsJCSAgICAgICBCSVQo
RFJNX01PREVfQkxFTkRfUElYRUxfTk9ORSksDQo+ICAJLmZvcm1hdHMgPSBtdDgxNzNfZm9ybWF0
cywNCj4gIAkubnVtX2Zvcm1hdHMgPSBBUlJBWV9TSVpFKG10ODE3M19mb3JtYXRzKSwNCj4gIH07
DQo+IEBAIC02NjMsNiArNjgxLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxf
ZGF0YSBtdDgxOTJfb3ZsX2RyaXZlcl9kYXRhID0gew0KPiAgCS5sYXllcl9uciA9IDQsDQo+ICAJ
LmZtdF9yZ2I1NjVfaXNfMCA9IHRydWUsDQo+ICAJLnNtaV9pZF9lbiA9IHRydWUsDQo+ICsJLmJs
ZW5kX21vZGVzID0gQklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSB8DQo+ICsJCSAgICAgICBC
SVQoRFJNX01PREVfQkxFTkRfQ09WRVJBR0UpIHwNCj4gKwkJICAgICAgIEJJVChEUk1fTU9ERV9C
TEVORF9QSVhFTF9OT05FKSwNCj4gIAkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiAgCS5u
dW1fZm9ybWF0cyA9IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0KPiAgfTsNCj4gQEAgLTY3
Myw2ICs2OTQsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE5
Ml9vdmxfMmxfZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmxheWVyX25yID0gMiwNCj4gIAkuZm10X3Jn
YjU2NV9pc18wID0gdHJ1ZSwNCj4gIAkuc21pX2lkX2VuID0gdHJ1ZSwNCj4gKwkuYmxlbmRfbW9k
ZXMgPSBCSVQoRFJNX01PREVfQkxFTkRfUFJFTVVMVEkpIHwNCj4gKwkJICAgICAgIEJJVChEUk1f
TU9ERV9CTEVORF9DT1ZFUkFHRSkgfA0KPiArCQkgICAgICAgQklUKERSTV9NT0RFX0JMRU5EX1BJ
WEVMX05PTkUpLA0KPiAgCS5mb3JtYXRzID0gbXQ4MTczX2Zvcm1hdHMsDQo+ICAJLm51bV9mb3Jt
YXRzID0gQVJSQVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+ICB9Ow0KPiBAQCAtNjg0LDYgKzcw
OCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTk1X292bF9k
cml2ZXJfZGF0YSA9IHsNCj4gIAkuZm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gIAkuc21pX2lk
X2VuID0gdHJ1ZSwNCj4gIAkuc3VwcG9ydHNfYWZiYyA9IHRydWUsDQo+ICsJLmJsZW5kX21vZGVz
ID0gQklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSB8DQo+ICsJCSAgICAgICBCSVQoRFJNX01P
REVfQkxFTkRfQ09WRVJBR0UpIHwNCj4gKwkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9QSVhF
TF9OT05FKSwNCj4gIAkuZm9ybWF0cyA9IG10ODE5NV9mb3JtYXRzLA0KPiAgCS5udW1fZm9ybWF0
cyA9IEFSUkFZX1NJWkUobXQ4MTk1X2Zvcm1hdHMpLA0KPiAgCS5zdXBwb3J0c19jbHJmbXRfZXh0
ID0gdHJ1ZSwNCg==

