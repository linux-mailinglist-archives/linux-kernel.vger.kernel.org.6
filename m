Return-Path: <linux-kernel+bounces-298383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 040F995C689
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4973AB21115
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCBE13B586;
	Fri, 23 Aug 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R09VkZp6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="jPNftDXO"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ABC26AC1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398251; cv=fail; b=O2udoyqrh+hZc7IV4bH/nSR8pwyZXjeis3fWn0LgFV9pGNgDyTtXsRSedPed7VoMAZ8753xg5RECOQFg+bnVVx0uLObVJkuPHnK8VCarZ5Qd2OCUXGDW6AXJm3a5Mw/7Kc5wFeZGRlDTNw9eMSjUUEndyYjj3p+unDVSbIoY/vI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398251; c=relaxed/simple;
	bh=pu9iAVrV/C9qpHLoZJcYNcWLIIGAhRlYpSG5KssIpBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bFaEYlHxbueXEFUSfEcPiNrSk2F0hutTU2hnsT91AniEHbxDR4jb4al03Um6LIaMD4y5+pD/r7QwicCiji97FiEojJZBm0bG1s36RYosWyZ8tI8Gj+JzHNLTb086JKBOmrMazc5EeS6kKxIXqT29kHmnU82bsOGv07mZ4gokBnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R09VkZp6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=jPNftDXO; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 99508450612111ef8b96093e013ec31c-20240823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pu9iAVrV/C9qpHLoZJcYNcWLIIGAhRlYpSG5KssIpBU=;
	b=R09VkZp693Savn/ryRupLH1GoLZVTPcuSqDO45jx9raZ3BHHgB1BUidBUKJUH8JWIZJPGbBLg0gAzXv16CNCha3sTwrjGe/SnLQzlUOSxzvID4jvjxKoGMNpIgOTgb5v9vW4d1n9ZNElL9FH/pbWaSTw63Um0dQ7qEwUKyodqDU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:fba8775f-6847-4931-9c66-14b0d009b2bd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:768bd0be-d7af-4351-93aa-42531abf0c7b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 99508450612111ef8b96093e013ec31c-20240823
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1430902929; Fri, 23 Aug 2024 15:30:40 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 23 Aug 2024 15:30:40 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 23 Aug 2024 15:30:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WC7edAmoaSsBveRLTDMmf2dYtQHTTPoyc/xWKyCYHAYAWnj1RPCttHwo2dWEV01JE2B/aop5/Fa31soGDesAJd+PV4/fEWna6regnEduDlCO7VKQMgVqAzgrUxqYIn7wfJ1j5LAF4BFfLznaKsBAMZv9WzvQJj8lBVz8lBscESkz4zIsGHyXpFWuKkdmtZ+G/Vny3M3QXbrMhpCmGa4SFmpyWtjQqRwtie1ft0f8c6cnnagK5C8/d2UIcZlaKxNJwmRw7rULts5zDpAaLUPAxs+2Cgb4M8VWyTQ1P85HUuqN0sOywGb1Hc3dQ+F8LgmT7LefQLLrQkkn1GQtrRH0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pu9iAVrV/C9qpHLoZJcYNcWLIIGAhRlYpSG5KssIpBU=;
 b=c1FQNSIqatxzK4VQVG7t6kD537WZaMtM4I4W6TpGva3yDbr8TDjutA5kLx5GpdnBEo0T7VvBExES9yDLu4ICJYhNFQucqQZ1gte98SonSXUgep4H1HrzlxKqKOE1kqylvvJC9F0h+kwaZf+OSJNJXrPQSRyW76lreysYt2gfpGT1zAFtVMaknUgUmKmBjXExO7ny23PkhRs62XSMqof96xRfm4uWzAGdgNWCf0QuibAxC7j4B4IK4JbhcyWJ0A5sEJXD+OyIAivZM6cu/QvqNDDeljlEaQHauzycaUmwrdOYJ2SGTg1qNNC5qcbdxa3P1hYjp0W1+7o32KKYmCOzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu9iAVrV/C9qpHLoZJcYNcWLIIGAhRlYpSG5KssIpBU=;
 b=jPNftDXO24PCa9wzAB4FNczamUZ4sCWs7+Wf6tQ8WGY7lqvJRG3XYZI2cI1psYyXmX/55zW+FxtB0fttUm/afm0/AeD0xyd7OxFJvmKD2p5lAgfyiuVy3N9DNB5R6rvqB8KRb1owjzd9RYFktK933GudEuO4thbaOPEwmoTdhLs=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB7262.apcprd03.prod.outlook.com (2603:1096:4:1be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.22; Fri, 23 Aug
 2024 07:30:37 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.7875.023; Fri, 23 Aug 2024
 07:30:37 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	=?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= <Shuijing.Li@mediatek.com>
Subject: Re: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Topic: [PATCH v3 2/3] Subject: [PATCH] drm/mediatek/dp: Add HDCP2.x
 feature for DisplayPort
Thread-Index: AQHauZvjSsoBOfJjC0GAI+NtmELueLI06XgA
Date: Fri, 23 Aug 2024 07:30:36 +0000
Message-ID: <088b8e5aa04c24059301a3f14a1214aa3a8865df.camel@mediatek.com>
References: <20240608120219.21817-1-mac.shen@mediatek.com>
	 <20240608120219.21817-3-mac.shen@mediatek.com>
In-Reply-To: <20240608120219.21817-3-mac.shen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB7262:EE_
x-ms-office365-filtering-correlation-id: 287669c1-8cb2-44e6-e925-08dcc3457b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ck9uYlFYWGZDNXhIOW5wcnpZU0d6dGNPRjBrUjkzZ1YvUEpqT0hFWUVtVmlw?=
 =?utf-8?B?WmhHeFhkaXhNZ3RvbnQ3TG1iSG8zMnRJMGptU0pIUzBiU3lUL21WRmpCZ2dH?=
 =?utf-8?B?U0tZMHJVQTFsK0FEaE0xRWN6T1BBN1grYTdZZ1RPMlBsazZaQ3ZuVDQ4bUZD?=
 =?utf-8?B?dlpvUGJVQzNaOXZvTGZ2azFmbkxFM09weXBFMVBQODlIUjlzNmhxOU9nN2Ir?=
 =?utf-8?B?MFAra3VZZzkyRGJVYm56RGt1dGhKNkY3ODE4UUtvUWhlY2RuaFhXeldpRXlM?=
 =?utf-8?B?UFE5cVRmbWlPL0RCUzdMeDROUXZhVzdwamZKaEthOGhtRGJPL2h0elZoVis2?=
 =?utf-8?B?azN6bmlRNXV6aTh6eEhRMGdXSUZuODd5YTRwbk9zT2kxeEVDK3g4ai85dnRW?=
 =?utf-8?B?U3F5NFIrLzFuUTk3Tm1oWmg4S1pCTFpsdFVJdU05NTFPcmhVeEFHTm02N0JU?=
 =?utf-8?B?ZVVRMVF4SjlrQmljVE5XVkF1SGRSUTFZZG9WVVkza3pzcFYxbU4zOFpUOWN5?=
 =?utf-8?B?TFYvS1l3dHExd2JFd1cvbVMwek5CV3UzR2NDZmZyZjNPeUZvNXY4cDJROTRU?=
 =?utf-8?B?QU01Z2FqcjRCTGcxR0ZaOGN1YkxjY3hvaE1UcmhOTWdaT0grREhuVHFGNzZu?=
 =?utf-8?B?T1lLem94aHJiSmlDdTMvNEhTY3gwTjEyblladHF0NHQ4bGlTL2JNQjd0WmtX?=
 =?utf-8?B?U1BsMDRBbzdENWZOeGliM3ViTE1IcEJTMXAxTnYxU3A2b1JaUm4yd2l1U3lK?=
 =?utf-8?B?L2tVdVc5elcwNzVJcEFzcVhBTG1uZzV6NE5UZ3BURWNlaUZMOEtGVGhkSDJu?=
 =?utf-8?B?UWVhN3MwU0Q5b1hsWlhVa2xiVmxZY3czdElnV1JTRDVHblF3SmFNNW5FSGlu?=
 =?utf-8?B?NFlVa203a0pPVERmZU9TMUVzS3N2c21BY2Y2bmh3U055NHgrK0ZsVjBXLzFm?=
 =?utf-8?B?K1ltYW02ZjVCUURMQUE3em1KdEtPYlo5NHpVV0dVWFNHUGc3WUtmRi81a3hU?=
 =?utf-8?B?b01QRkVsQjl3WHcyeW9KeEpTY1lqaWlNb1VhL3IrQ09MMGtmSjR5aXkxRXFF?=
 =?utf-8?B?WVhEYjZ5MmpaSVdoZUlNNGo2bVYzYXE0c3FsVFBITjMrRnU5MzNOL3oxYnA3?=
 =?utf-8?B?S2ZoR0JlaS9yTmE2VEM1QmZXYTZLRlY4ZmNoZE1xQjBXREZoK3Z4dUZ6WXRY?=
 =?utf-8?B?dEJleDJZajlHemtvdm9zb2laRHhJeHl5bFNDbEJKZHFHckpJSXczWERjTDE4?=
 =?utf-8?B?QkR2Y3dUZHF5MExDRnI3eWwwM3Q5eHlncmZzUFZCditvaXF3cHF3cmlBRFIv?=
 =?utf-8?B?UmVUVGU4Q3R1NnhFUHlWWnVjM0s0RElYVmJZK2gyejVyU215YmhkREJUWW1K?=
 =?utf-8?B?TThwNmRMKzZaT1RDdGRabVlBWTBDaDduWWlTRjl6VElmWlZQTGxFUWZLS1lp?=
 =?utf-8?B?cU1jeENHOWxSUGJzdFdwbElpVmZ6N0hmM3JNRjEybndiY3FYemZMcVdQbitS?=
 =?utf-8?B?OHBtbEZPRk5yeXhsMW9URzVtaFVhdGs2bGlhL3kyMmRiUmN6MHFIdVdtaVlE?=
 =?utf-8?B?WW8zdTBJOGxBNlg1MDZyWTMyTzZSRmhpK0lxU2JPeDN0NGhEeGY4cFYzY2E3?=
 =?utf-8?B?VVgyeVlHMks2dzAybjJQcXBhTmRobGN2Tkx1SWYrOFBSN0p2NndVRmtBVTRm?=
 =?utf-8?B?QjBWZFhqNzNpaG1SU0wrblRpaFkvVENtYXAvSHRlU3dodlRwbUhndEtDSzd6?=
 =?utf-8?B?ak1zSXVlZzZXYjQzUUN5VGdUZVVBd2daSjZlTFJBZDhOemNZa3dMRmV5azJR?=
 =?utf-8?Q?DPGn7txwC+LA7r16ijg8Wahim7gKg56Peehfc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmRjcWsxZnBRUzBueDlRVWtQam9IeFpIc3VxbGwwUDEyTThzSTV4RVU3L3hp?=
 =?utf-8?B?ZjduZjVwN0NsRSt3a0tGdG14QytsTDFQQnRRUVRxRGpFUWhzeVJNK1RpQjlT?=
 =?utf-8?B?bkJiM29QejRuR2Mram1zME9ucVFNcVJycWZMcjRJOElKNTJIZFdtWm16V1dl?=
 =?utf-8?B?bnl1RDMyUEVIbmxPMkhQWU02SHVxVXRUU0tOZ2paZVY4dzJNRWVBYmpzVHVl?=
 =?utf-8?B?VkhoK3kxbm1KM056dnpiaVAxR3YzUTQ2YVNwRVNsODFlSUVmbmdJSnZmdkh1?=
 =?utf-8?B?aHhUS3loRjBkZ01FUkg1UkZ5K0RWTC96V1NsUnlKNkI2UVRWUmljTHJDZmNr?=
 =?utf-8?B?T1JqODU2ZTFWdGYxSVhTa3g5Tmo0R2Q2U1dnWUZHNDB4bGFSM0VJWGZFRGRu?=
 =?utf-8?B?YjB0ZEJ6dUtvb011ZkJoSnd1WTI5UnVjbWtRQVplellwMjNBV3lMYmQyNTFk?=
 =?utf-8?B?K1VFbmlqdGp0SjZNNXNvWnRXUjBnMzNwcjBsNmlqOGkxZEQ5c0w2R3hlTTF4?=
 =?utf-8?B?MDlHdW1aQVZpSi9GMGVoZFJlL2ZoUDdmVENKbEtmT1NWQjFwWDJhTUZRVUF5?=
 =?utf-8?B?YmhyQ2ZESDB0OUZtZkhpWi8yRU5jSHBWTmlxb1grYy8yVmhhUXZxNE81Y2Nh?=
 =?utf-8?B?cENFWlhTV3N6MXAxV2U0S3cxM3M2cG82YXNrQWNTbXQ1c0t5V0J6a2JldDRC?=
 =?utf-8?B?RVpvb2Q2V3BldEpPWUhQTHZxQzRCQ2hTbVJKYVZpRmNNVnRVbW9EOVJ3WGZD?=
 =?utf-8?B?MVBRMWRlUyszM3JyVXFBR08wdTN1QnlQYXBrSVc3T25zZnUxUGpDY05SUnBY?=
 =?utf-8?B?YTY4UmpWb0hibDVXOFJLNmFrUzVOTS9qaFQ4M1V3ZldjZTgxSFNUekZBYnpK?=
 =?utf-8?B?eDk5YXMwT0QyRWpTYlpvNE13dzlzemJnQ2h5RXNQaWRGRS9MUUlwWE8ySys1?=
 =?utf-8?B?SllaNlZxTlExL2xLWHZJL2lXem1iV3N3d0YwMllSME9sL0lLZS9sVkZvZVR2?=
 =?utf-8?B?SnZ5SjNGY1UzOGpMelRaYXMybWhIM01JVVNneVcxREVoSHBwTHk1RXBTYlRu?=
 =?utf-8?B?T1MyTktvMmtKMnhwM3V6VkNyWXNEaFNmZ0EzVkFvUkFPaVExS3gvV0gvMmhK?=
 =?utf-8?B?WXplTXllMGRsdFBzTElpczdDRmpCak9qOWpUeUxaUmptOVJrcnB2cjd1MXZj?=
 =?utf-8?B?bXNRVW1ER201Rm5NdWcrQ2M1L2J0amloTWdPZGFkczBIZ01lY1A4Skw0Qi9T?=
 =?utf-8?B?VTZhdFQ4cVBiRlgrdk9ZK2dPZjVYWG9RSkpYalg1U3RKeHlGUCtETGJydkNP?=
 =?utf-8?B?T3lFbHZJekI5NTlvY1lneWZ0Y3Z2MnFuc0p6dmRuYy9QbURSUzJrMVhjLy9a?=
 =?utf-8?B?aGs4VHdkaFpNTmdwdDZJQnV6VS95TTZGRnNBRitFbGJUSnJXdVdybWNoTExQ?=
 =?utf-8?B?MFdIL0EwUmVLNVNtRU9lYXk0QnpZOGpZRGRJV1ZPWk5jcVZnUDI5L200V0tD?=
 =?utf-8?B?NUdkVDcwWllBc2xIUWJoMXlRT0lHaWwzaHY5UFUwZmdCeVBEajdIbnhLUE1y?=
 =?utf-8?B?TlpjZExUZGk5K25VbDlNeVFCQlptQW1GZkFISjUwUlpmRDJOcXk3WWxEYnpR?=
 =?utf-8?B?REJSWkZWM096VlY2SEY4Rlk5VGtiUzAwQW0zTHdCS1ljMFRNWTdZRGZ5RHEz?=
 =?utf-8?B?V25qcTdSZzhMSTMxK2xhZnh1RUFiaWgycWhsZ0N4dkZ2U2x5em5UQkFRSzh4?=
 =?utf-8?B?S3pGSkVaK0ZmQXRzU0lzaXpPZ3lqWG5pbEJHQkM1UGVPOFdjbFRpYzFlVHRV?=
 =?utf-8?B?S3h3aTVyWWUvVWNaS3ZUeGRGbUROVjN2SDRjTUpJU3A1QkJkRk4yWHh1T04z?=
 =?utf-8?B?d3FpMHd5c0VXbXJZZ2F4ZUZZVS9nK2pQZmR6dmJCZW5lTENZLzNldlMzclVk?=
 =?utf-8?B?YksyNGRMVFZMUWR5SGl5bFJpcFM1dUtQcUlXOGFwOGdESXFJOXNQRlp5ekZN?=
 =?utf-8?B?K2ZXT1lWUnBxZUFhUkpjU0x3YUF3Q3J5dzQ4MEZnUmZ4VDZMZFREV3NpYTIr?=
 =?utf-8?B?TkQ5d3p0ZUhxS1lMNEN1b0tMY1Y0RGNQTDkrUlJwdGFXZUlOSnJPTXVEK1hE?=
 =?utf-8?Q?QTTdn9Ei7zaVjheJODrqLdsfL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82F714A3BDD35E439B996F084A67B0EC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 287669c1-8cb2-44e6-e925-08dcc3457b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2024 07:30:37.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v5iUWYQQumFHMYKcUUAGCYYrQ1S6pMdGuGo6ofD66Gsxj1ivP36lRiw9iNmr6EnW9uoj/oocv6uoOKmRP6OMmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB7262

SGksIE1hYzoNCg0KT24gU2F0LCAyMDI0LTA2LTA4IGF0IDIwOjAxICswODAwLCBtYWMuc2hlbiB3
cm90ZToNCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSByZWZpbmUgdGhlIGZ1bmN0aW9uIHRvIGdldCBz
eXN0ZW0gdGltZQ0KPiAtIHJlZmluZSB0aGUgZmxvdyB0byBkbyBIRENQIHdpdGggY29udGVudCB0
eXBlIGFuZA0KPiAgIHByb3RlY3Rpb24gdmFsdWUgd2hpY2ggc2V0IGJ5IHVzZXIgc3BhY2UNCj4g
LSByZWZpbmUgdGhlIGZsb3cgdG8gdXBkYXRlIGNvbnRlbnQgcHJvdGVjdGlvbg0KPiAtIHJlZmlu
ZSB0aGUgZmxvdyB0byBkbyBIRENQMi54IGF1dGhlbnRpY2F0aW9uDQo+IHBlciBzdWdnZXN0aW9u
IGZyb20gdGhlIHByZXZpb3VzIHRocmVhZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRla19fOyEh
Q1RSTktBOXdNZzBBUmJ3IW1kNnhVaVlOODhEMlltRVRzOEZRZ2FFeE0yekg4UzFTbUFFVTlHUmNo
d3BOc1hPeURGdWwzemlWS2hScENKYWo4UmNuLWd2TS04MDFydW5qd0EkIA0KPiAvcGF0Y2gvMjAy
NDAyMDUwNTUwNTUuMjUzNDAtMy1tYWMuc2hlbkBtZWRpYXRlay5jb20vDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBtYWMuc2hlbiA8bWFjLnNoZW5AbWVkaWF0ZWsuY29tPg0KPiAtLS0NCg0KW3NuaXBd
DQoNCj4gK3N0YXRpYyBpbnQgZHBfdHhfaGRjcDJ4X3JlYWRfYWtlX3NlbmRfaHByaW1lKHN0cnVj
dCBtdGtfaGRjcF9pbmZvICpoZGNwX2luZm8pDQo+ICt7DQo+ICsJc3RydWN0IG10a19kcCAqbXRr
X2RwID0gY29udGFpbmVyX29mKGhkY3BfaW5mbywgc3RydWN0IG10a19kcCwgaGRjcF9pbmZvKTsN
Cj4gKwlrdGltZV90IG1zZ19lbmQ7DQo+ICsJYm9vbCBtc2dfZXhwaXJlZDsNCj4gKwl1OCByeF9z
dGF0dXMgPSAwOw0KPiArCWludCB0aW1lb3V0Ow0KPiArCXNzaXplX3QgcmV0Ow0KPiArDQo+ICsJ
ZGV2X2RiZyhtdGtfZHAtPmRldiwgIltIRENQMi5YXSBIRENQXzJfMl9BS0VfU0VORF9IUFJJTUVc
biIpOw0KPiArDQo+ICsJdGltZW91dCA9IGhkY3BfaW5mby0+aGRjcDJfaW5mby5zdG9yZWRfa20g
Pw0KPiArCQlIRENQXzJfMl9IUFJJTUVfUEFJUkVEX1RJTUVPVVRfTVMgOiBIRENQXzJfMl9IUFJJ
TUVfTk9fUEFJUkVEX1RJTUVPVVRfTVM7DQo+ICsNCj4gKwlkcF90eF9oZGNwMnhfd2FpdF9mb3Jf
Y3BfaXJxKGhkY3BfaW5mbywgdGltZW91dCk7DQo+ICsJaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmNw
X2lycV9jYWNoZWQgPSBhdG9taWNfcmVhZCgmaGRjcF9pbmZvLT5oZGNwMl9pbmZvLmNwX2lycSk7
DQoNCmNwX2lycV9jYWNoZWQgaXMgdXBkYXRlZCBhbHdheXMgYWZ0ZXIgZHBfdHhfaGRjcDJ4X3dh
aXRfZm9yX2NwX2lycSgpLA0KYW5kICBjcF9pcnFfY2FjaGVkIGlzIG9ubHkgdXNlZCBpbiBkcF90
eF9oZGNwMnhfd2FpdF9mb3JfY3BfaXJxKCksDQpzbyBtb3ZlIHRoaXMgdXBkYXRlIGludG8gZHBf
dHhfaGRjcDJ4X3dhaXRfZm9yX2NwX2lycSgpLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICsJ
cmV0ID0gZHJtX2RwX2RwY2RfcmVhZCgmbXRrX2RwLT5hdXgsIERQX0hEQ1BfMl8yX1JFR19SWFNU
QVRVU19PRkZTRVQsICZyeF9zdGF0dXMsDQo+ICsJCQkgICAgICAgSERDUF8yXzJfRFBfUlhTVEFU
VVNfTEVOKTsNCj4gKwlpZiAocmV0ICE9IEhEQ1BfMl8yX0RQX1JYU1RBVFVTX0xFTikNCj4gKwkJ
cmV0dXJuIHJldCA+PSAwID8gLUVJTyA6IHJldDsNCj4gKw0KPiArCWlmICghSERDUF8yXzJfRFBf
UlhTVEFUVVNfSF9QUklNRShyeF9zdGF0dXMpKQ0KPiArCQlyZXR1cm4gLUVBR0FJTjsNCj4gKw0K
PiArCW1zZ19lbmQgPSBrdGltZV9hZGRfbXMoa3RpbWVfZ2V0X3JhdygpLCBIRENQXzJfMl9EUF9I
UFJJTUVfUkVBRF9USU1FT1VUX01TKTsNCj4gKw0KPiArCXJldCA9IGRybV9kcF9kcGNkX3JlYWQo
Jm10a19kcC0+YXV4LCBEUF9IRENQXzJfMl9BS0VfU0VORF9IUFJJTUVfT0ZGU0VULA0KPiArCQkJ
ICAgICAgIGhkY3BfaW5mby0+aGRjcDJfaW5mby5oZGNwX3J4LnNlbmRfaHByaW1lLmhfcHJpbWUs
DQo+ICsJCUhEQ1BfMl8yX0hfUFJJTUVfTEVOKTsNCj4gKwlpZiAocmV0IDwgMCkNCj4gKwkJcmV0
dXJuIHJldDsNCj4gKw0KPiArCW1zZ19leHBpcmVkID0ga3RpbWVfYWZ0ZXIoa3RpbWVfZ2V0X3Jh
dygpLCBtc2dfZW5kKTsNCj4gKwlpZiAobXNnX2V4cGlyZWQpDQo+ICsJCWRldl9kYmcobXRrX2Rw
LT5kZXYsICJbSERDUDIuWF0gVGltZW91dCB0byByZWFkIEFLRSBocHJpbWVcbiIpOw0KPiArDQo+
ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCg==

