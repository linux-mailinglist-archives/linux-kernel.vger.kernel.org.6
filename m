Return-Path: <linux-kernel+bounces-342538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F56989013
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5702D1C20B84
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 15:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF218210FF;
	Sat, 28 Sep 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pA3l3w5Y";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="KyET7kwp"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827714A96
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727537528; cv=fail; b=ZCdyKprHkUXLqHzyyM+C4M3hquGSD4EWJVpr5qPGuzLBjLyxXqRlKFgdmnqJk9CEebPCVx0SBgkCFnJaMNBpgVyHSPQqKFIdCHLR4Pvt2iczy+QlHDlO9lKU8yVDW4YgZUnNQFblTERNjZdp9RvngOFbyJva+KsSKmPFT1Zogi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727537528; c=relaxed/simple;
	bh=tCXdgGgtItsUQIHtQ8QynQrmGFxqIVopUI00lanXBNc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5yTF7lvbr0bPfVd9jsHEsG49ISdylbHq3D0zPQRsld+AI7VLOQZ84s+hQd5LPUXzU3C34e+jEfPqooAot76WMXsIotsK/XjM0qSvHADXMoTxWvnvpTYYCB8tJJKlYIEWT555rtsccl5NL7JwPfkZOiSJG4m2usNaIyfmt5heBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pA3l3w5Y; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=KyET7kwp; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cd1b09147dae11ef8b96093e013ec31c-20240928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tCXdgGgtItsUQIHtQ8QynQrmGFxqIVopUI00lanXBNc=;
	b=pA3l3w5YLajPgI6xRWd6bDTEipEAs/rHq9BzSiibC/dvixitOacK3XOAyhk/JyLHM3sGZUEwryHRlQtA+ajQxA7W5ljvYD7qv2b/gHie/CnN7HYIsUCbF78emn4vImuakPM5qy/YVkwgKy/ZFL4HNx27KPON/kmkQafqAfOHzCI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:36ba252f-a22b-44fa-996a-a883c31c0de9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:21ebe8d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cd1b09147dae11ef8b96093e013ec31c-20240928
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1442430027; Sat, 28 Sep 2024 23:31:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 28 Sep 2024 23:31:57 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 28 Sep 2024 23:31:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3ewAFGSxkJxPWd26/sWLUHoL8mpdcShBHEzCv+9fIQ/qXcmXcaMFZ5tj9nlPWyYkJqjJ9ebOPIiaCzLtQ92nriYxchOAAdbf1U117ogp/FDHi1BX3QCCCEsv7s3U0685Ss6UhnKpg9wtd9vfV1+5sB3WZEw5apYf1fTXDXhYiUubv070vqme9pkjaQBXDufdocI7yKc7QDuEe1GLPVKu8Alq1zkgNTQNYz0yv3HRD6XWzm4VSp99q2oVrFk7Oq7AF0k6nn83EtLl3YQTsUkFhHfqZqyqaEZmDQCEZgmRconTwt79fnUdOW23R9OpFCVDeuox6PmDuAikX2Uq/EO0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCXdgGgtItsUQIHtQ8QynQrmGFxqIVopUI00lanXBNc=;
 b=nSc4XyBByHM5fK4Dl5KEGWFimkmJk8hjcMsKBxK+eLsIRMvACSKBXwXUqQ5nOgcRoiuTRhsGrGXzZOa/rk3eLHDSfpivaG/ib7s/Z/UD5CvUr6DFpfocTc2ul0qCQej3heUUHwyxP80JFS/yN/c+4EBrPeln7e3LPpa7lPEK3Tn71idJLnPbmcpq63PW5709kQ6pBUwKnYjAiI5XyU1kETzOsDhMd5a2YA95whlDkEr66geZQlEqC6ddKXejKnoSazBhBxJ8j3WYT6Z1YLFZz2URiVucGe5FuYQLgrjr+3Wv8MB2tfRTYBrdccgBVF0m7QXnEBUDztf4ocmIAP9atQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCXdgGgtItsUQIHtQ8QynQrmGFxqIVopUI00lanXBNc=;
 b=KyET7kwpg00FbyF93+bu05cHjLWpE+cFsRHtNq2ZRyZmMD3rmxIgMnQ70TFil7eW2q0J7EH77Ok70c5DZZIWrpUXQRRBbYB8Z00jERoiiexK1m5KQ4Sa7/OBqZubXc67TH5dgH7TxRlYVo0DNg5EqSsh/ZIN9XcMpxEJL1g5DNg=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB8211.apcprd03.prod.outlook.com (2603:1096:990:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.24; Sat, 28 Sep
 2024 15:31:54 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7939.022; Sat, 28 Sep 2024
 15:31:51 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
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
Subject: Re: [PATCH v7 0/3] Fix degradation problem of alpha blending series
Thread-Topic: [PATCH v7 0/3] Fix degradation problem of alpha blending series
Thread-Index: AQHbD/4HmjIGcl49hUaM3bGQ6hezwLJtLVeAgAApvwA=
Date: Sat, 28 Sep 2024 15:31:51 +0000
Message-ID: <167af196a5dec4a0d9a808756166b72e34e4b273.camel@mediatek.com>
References: <20240926102238.24303-1-jason-jh.lin@mediatek.com>
	 <adf21ae5-6820-44ea-8cc9-7a42b345114b@gmail.com>
In-Reply-To: <adf21ae5-6820-44ea-8cc9-7a42b345114b@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB8211:EE_
x-ms-office365-filtering-correlation-id: 6d64a293-4317-4193-305c-08dcdfd2acb3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?c043RkhkQ01lbEluMzRlejgxT2NLVXJmY2FVZGZ0a2VCdit5S0lSUTk0cGFS?=
 =?utf-8?B?TXpaQ2VlOXd6V3JjN2RNMnhGODJmVExGcUhHVUVua00vWExwWlJWSjJiY2N1?=
 =?utf-8?B?KzJsNkRlOUNKdk1RVm9oTUc3QlBFT0F6aHcxRm5nQmtjOUZ5YUVZdXE2YzJQ?=
 =?utf-8?B?WTBaYnNONklOSU5CTGxtTlpPWXcvZXQvZDIxWGs5dG1SVWtjMjF6dWRlbmFN?=
 =?utf-8?B?Vkk3Z0p6bk5EYlZ2THVrMXlsUFRJdC8rUHZpaFEzVXdLU3ltbXJ3aUVVTDZZ?=
 =?utf-8?B?YmxOMXhqU3oxVCt1cGduVHpYTlVRbktwVmN0VVVoRlUra3MwbjF1Um5BaHo5?=
 =?utf-8?B?WW5YNEJ0R0ZmZlQ4M0F6cWp4V3dIK3NaUTlHYis3YTE0eGNkb3lLc0FPUU8z?=
 =?utf-8?B?MkJKczN3YllZWW05QVo0MkVNSUN1WjFXcUZTeENFWEJIZXFSb1BmTWNnaDNz?=
 =?utf-8?B?TEJsRnh4cU1IalNCWjlRam1qSzk5elVaTXUyVTlQa3ZIK2RsZUtjTUdwOXZU?=
 =?utf-8?B?c3FscHRlWGxNeEVuR0VPdWNNd0FhTEtmUjRlTFFQSE05UUpDSFVqWXE0ajNE?=
 =?utf-8?B?MnlBdERZcmF6OE9BTUkrbHVJdk14dUVQYnFMdTRHenFES3FIaGVyTlBzcTNm?=
 =?utf-8?B?Q09QUTlRYkUxSm4wTyt0aklQVXhiSk9JVnZNWmxmcHMyQ2JFZzdzZTlVdmhh?=
 =?utf-8?B?NGFqTnA1eGttWXdGd2Q1a2YyOFdzRG9JOVhmWiszc1NlZEYzdW83WThrcnRG?=
 =?utf-8?B?aFNtTko0QzBOMlJCNGZpY1NRYUlnQWNzc004cEFXQlUwMzZnb1M0Q0lmMGVk?=
 =?utf-8?B?K3lmMERSbU5SVTZUUisrbTQxMWV0TFJ0M3VOcFJ4RTRkd0RQbWdDTjlORjY3?=
 =?utf-8?B?YmQzREpjdjNzdnl0N2Y4Y3JFTTI0LzNxaDlGeXNMc211WElSZHZDQkNRa2pp?=
 =?utf-8?B?V0hDTHozMUhOK3hoOWZFbkFVbTNmZ3FSQ2pwZkNJdEVKZFdoQ2JscmpPYWRC?=
 =?utf-8?B?RDB4aWkwT2ZtdXM0T214YXVlRmxSRnZsbmdEZ2hlTHliQ0NmRHBzbTN2UEht?=
 =?utf-8?B?NWVMNGN4OHNXMmRISUFKM0FwSVExREJuLzlTNlo1RXBUOTFIOVZDbW16dVhG?=
 =?utf-8?B?VUVraTNidVFxVWdFZTc3a000bjFML1ZZaDJnTXVRQ0EwVUw4RVYrUnpFbmNC?=
 =?utf-8?B?NmhWL1lmdU5IcGRkbDRDWXhRYTJnQ084R2IydmVselZSdng3S1BXdFdyZTUr?=
 =?utf-8?B?aGdiaWtQc3JvZVdRendDNUJNUFozRC8xK1U2eG5adVZrSjNLbmc0VWM3MDIw?=
 =?utf-8?B?UVlkKzl5bDhtMlArSlhlYTZDWnZHaEJDQmhXcVFHcldHZzkwSmFic0RLbzRo?=
 =?utf-8?B?WjRxNXJRQXZyUUFHT1FaNFJoYWRZUGxEenUyZmgyZm0zZExTRkJjcEl5ZVZG?=
 =?utf-8?B?elh5WEZ2MTF6R0JHRUFhbEFqdWpSajQzUG1KZWRRUXdGemwzaSt2aFdqcmxp?=
 =?utf-8?B?K01aTG9uWFBYUlZuQllIVmdlczg2ZXAxR1dkOTJoQzNTc3ZiTm8rMkpHVklH?=
 =?utf-8?B?TUFEQ09YbGMybVZvOFBNbmlZczBCRGNGbUt1RXFFdUtQazBzaEVKVDIrdisw?=
 =?utf-8?B?VzBKMTl2bW42MTVTb1dpOTZlTmpyTGxMY2Nzc2lKTDJoVHV0RTVYQkU2bllm?=
 =?utf-8?B?NGNVTGNLREUwRGZBSjRROUtzeGdzMms0WWpWMDlmbHVVVk1xRlNWbUFIZ3JV?=
 =?utf-8?B?b25HUUlqSHJUTTdXTDFVaWhSMjR1RFB0TVZSQjhsV1VGcHZWejRnbUVxRXo3?=
 =?utf-8?B?M0dmMENRNXRrZUdHWGxsZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amFpT3Q1TDVjelRnQkY5cjRadTZsdFZvZ042dUZNdENTNUZEaDlZT21tSEN1?=
 =?utf-8?B?d2ZrNnllYzhyQ0RUbGxmbzNmc2wwdE4raDltR1AwVjN0SDErcHlWd213OEF2?=
 =?utf-8?B?RGszV2YwckZuRGkxdlV6ZVNkM2lrWVFQSXVxZUZqR1FhUG15SGhPa1plOWNC?=
 =?utf-8?B?RTZqVnd4Vk1Ia01qeFFwUGxGVHltcUd6a05lSUU5NGZtTGhDL0NMSmMvbWFG?=
 =?utf-8?B?NXQ1RVkxOEIxS2YvS3JiMzRwR1BhNFpXaitmbCt5YlZCOWRIdXIyUWVqQ2dq?=
 =?utf-8?B?V3RnbVZvSmtxb1RGUGdDNG94aUJuZVluMm42ZEduVUdxZmEvazhLaU9tVnl5?=
 =?utf-8?B?MEFmRERXR2FqMUhNV3dSZVcrUUpoSmxKdlRoeGhWbi8rc05xMy9qZ3d6YXpx?=
 =?utf-8?B?NFhpRnVycFNibnZSU3lrUUh6dlZzcVZSdHB2RWFHZlFBK0tKZVQzc2ZYd1J1?=
 =?utf-8?B?c0p4dHpKUDYrS2dUd2hnN3c0cTd0MnNqU3J1YjBja050dTB2K0Zkc2J6RnZt?=
 =?utf-8?B?R0tTV2VjU2xNNEZ2VHIyVll4aFVVR1ZkWHp1MGJCTnVlNlliMy8waWpIRTZv?=
 =?utf-8?B?eHM5aHc5eWczeDBxNjUyUVJSbFJncVRaalFnUEZDVlZEQ3hPNHovVFJKUGdU?=
 =?utf-8?B?R09TdUdvTjFSMnIrU2ZlNkRCUncvMk9ZS0t5bTBnNWIzRDJQVExBMkZRcUhx?=
 =?utf-8?B?NEtVclhoMGwyV3lDZ2lURlFzT0QyY0RySG9VTVBPdTVFWFBZcDVJb0kwSEY3?=
 =?utf-8?B?aVJVT2hERkp1NjRVU1I0eEx3bHZ5T3NjNUpKcjFCNHZ2dnVXWStLaFhTRGtP?=
 =?utf-8?B?NWpiV1pHYkVqZnJmWGpIT04wRWMvQmYvUU1SWFF4bU9iM3lNVnJnRVhJQVdt?=
 =?utf-8?B?UUhTMU5VWWQyT0tOQ3VDTlRoQlpBdkVIMXpSTVp0SHRkTGNQdjJmMFZFMkNh?=
 =?utf-8?B?MHZ2RVBSQ1I1MXJObFNrNjdjdHcyWmxkMkFTVzVyTVRiUk1DNDVqa1J6enJT?=
 =?utf-8?B?OFA0L1F1T3pNTGlsZ1JuSzVaczhQZldaMlBzMjBENC9FYk5tMXpXWkUrR2dk?=
 =?utf-8?B?RGZoZUVqQmErZ1pMWGFieW5xeEtZTGwwMEhOTGo5SDRRdkYrMjdLKzZEMXBD?=
 =?utf-8?B?Wis4YWxmKzdWLzlQTjl4WGsvbjlHWlFJZXFGVlBvNlJ2WHJod3dzVUFZQy9G?=
 =?utf-8?B?Y2l4RWxSQnFVTU11TWZTbVIwTXR0TFpkMzcyZ3VxZVNMVUpvTG9tZkQ1UlBl?=
 =?utf-8?B?VlhNMGY5Z1B4WnJHcFlpZ2VXOXJUd0VvdW9EWHFoQmhVT3M3VllnZk41ZjVK?=
 =?utf-8?B?UjQwYm5lcHVNLy9jcCtuVldsK3kzRHZaWlF0MXFMb3F3MUlkY2hJTFMwWGsr?=
 =?utf-8?B?ZnFKZWhCWkcweERMc3d3Z2xxWVZzNkw0ckxUeHhpeXFTT2RpK3laWDgxZXZr?=
 =?utf-8?B?RHFHL3hXeGtHcGtubVE5WUJxeitGdEVvVW50RFdKa1hnV0U4L1ROZUhHc0Fw?=
 =?utf-8?B?RGZSSVlpV044OEE1TGJqb0Ira3FKZlBiSWc4czlJY3FTUllXVzVDMldWZzBX?=
 =?utf-8?B?WWliVE5PZTByN1BMbU95cjVKVFJFNi83ajdOOThxd2tQK3V2SHFEeWQ4Zjkw?=
 =?utf-8?B?WHhPenQ2UFhaNFpXYmYzTGw5UFptWm1BeUkzQnk5M1dzdTZ1NDVmU2VhOGZ5?=
 =?utf-8?B?aCtUaWI3dis1c1crTnQrMzEyN3BJbysrTk5VVjBtc0JyZjNiQ2VVYVUyOUc4?=
 =?utf-8?B?S1pTNW8zcG9aUTlOOWh6bTRFUUVVTnI1a1JZSU93UVFud0l1dUU5SDNYT0wz?=
 =?utf-8?B?VXFYSnplVUkvUCsyTEpPSmJzY2JrWXNvNGIzeEllYmY4NG9sSzVlN1gzWXNM?=
 =?utf-8?B?b01NY3VkSVc1azVxMkdOckhYOGppbXpSUEsyNjVqR0J0eWhENitKYVZxREww?=
 =?utf-8?B?QlU0ZzRRcWhKV1lwOWRvNVdXYlNwYmIxNHkxdkhSWVhxT3R5cWhhaW1rU0VU?=
 =?utf-8?B?N012di9adWczLzVjM1BUWW10bDhxdVJJMHdab01aYWZqa0Q1eWp4d05PQ0hi?=
 =?utf-8?B?c1A2NnF1WEhzdzl2TnhMQ3JpNmJFb3c3NGxNSE9jc0VMNGMxNFMrWUFvaDhh?=
 =?utf-8?B?M3FqMnQ4Q0phZXpJQ24waWxFOXhBWXhlNUV6ejhCeFlIOGd4NEV2L2VNeVdn?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A30DC1192CE5944A08F90DA65E85806@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d64a293-4317-4193-305c-08dcdfd2acb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2024 15:31:51.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z+B2ScisC8z/9svLuRpzvnUfrwL+XxyX6lqD4QtptoW2a9zTOXxAc07npYbpobu+C7G8dT5SSs0EHKlhe/XjnpDsmeNTm96mnIcWqTOWGE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8211

SGkgQWxwZXIsDQoNCk9uIFNhdCwgMjAyNC0wOS0yOCBhdCAxNjowMiArMDMwMCwgQWxwZXIgTmVi
aSBZYXNhayB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBIaSwNCj4gDQo+IE9uIDIwMjQtMDktMjYg
MTM6MjIgKzAzOjAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gU29tZSBTb0NzIG5vdCBzdXBw
b3J0IHByZS1tdWx0aXBsaWVkIHBpeGVsIGZvcm1hdHMgYW5kIGV4dGVuZGluZw0KPiA+IGNvbmZp
Z3VyYXRpb24gb2YgT1ZMIHByZS1tdWx0aXBsaWVkIGNvbG9yIGZvcm1hdHMsIHN1Y2ggYXMgTVQ4
MTczLg0KPiA+IA0KPiA+IEZpeCB0aGUgU29DIGRlZ3JhZGF0aW9uIHByb2JsZW0gYnkgdGhpcyBz
cmVpZXMuDQo+ID4gDQo+ID4gLS0tDQo+ID4gDQo+ID4gQ2hhbmdlIGluIHY3Og0KPiA+IDEuIEFk
ZCB0aGUgcmVtb3ZlIGNvbG9yIGZvcm1hdCBjb21tZW50IHBhdGNoIGZvciBPVkwNCj4gPiAyLiBG
aXggd2FybmluZzogJ2NvbnN0JyB0eXBlIHF1YWxpZmllciBvbiByZXR1cm4gdHlwZSBoYXMgbm8g
ZWZmZWN0DQo+ID4gDQo+ID4gWy4uLl0NCj4gDQo+IEkgZ2V0IHdhcm5pbmdzIGFuZCAiKkVSUk9S
KiBmYWlsZWQgdG8gY3JlYXRlIHByb3BlcnR5OiBibGVuZF9tb2RlIiBhDQo+IGZldyANCj4gdGlt
ZXMgdW50aWwgbWVkaWF0ZWstZHJtIGluaXRpYWxpemVzLiBJdCBoYXBwZW5zIG9uIE1UODE3MyBh
bmQNCj4gTVQ4MTgzLCBidXQgDQo+IG5vdCBvbiBNVDgxODYuIENvbG9ycyBhcmUgY29ycmVjdCwg
dGhvdWdoLiAoSSdtIHRlbXB0ZWQgdG8gYWRkDQo+IFRlc3RlZC1ieS4pDQo+IA0KDQpNVDgxODYg
aXMgdXNpbmcgTVQ4MTkyJ3MgY29tcGF0aWJsZSBuYW1lLCBzbyBpdHMgYmxlbmRfbW9kZXMgc3Vw
cG90cw0KcHJlLW11bHRpcGxpZWQuDQoNCj4gLS0tLS0tODwtLS0tLS0NCj4gDQo+IEZyb20gTVQ4
MTczOg0KPiANCj4gWyAgKzAuMDE3MjAxXSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0t
LS0tLS0NCj4gWyAgKzAuMDA5MjUwXSBXQVJOSU5HOiBDUFU6IDMgUElEOiAzNyBhdA0KPiBkcml2
ZXJzL2dwdS9kcm0vZHJtX2JsZW5kLmM6NTg2DQo+IGRybV9wbGFuZV9jcmVhdGVfYmxlbmRfbW9k
ZV9wcm9wZXJ0eSsweGYwLzB4MTEwIFtkcm1dDQo+IFsgICswLjAyMjUzM10gTW9kdWxlcyBsaW5r
ZWQgaW46IFsuLi5dDQo+IFsgICswLjE1ODE2Nl0gQ1BVOiAzIFVJRDogMCBQSUQ6IDM3IENvbW06
IGt3b3JrZXIvdTE2OjEgVGFpbnRlZDoNCj4gRyAgICAgICAgVyAgICAgICAgICA2LjExLjAtbmV4
dC0yMDI0MDkyNy1kZWItMDAwMDYtZ2U1MTRhMGY4OWRkOSAjDQo+IFsgICswLjAyMzU0Ml0gVGFp
bnRlZDogW1ddPVdBUk4NCj4gWyAgKzAuMDA1OTM2XSBIYXJkd2FyZSBuYW1lOiBHb29nbGUgSGFu
YSAoRFQpDQo+IFsgICswLjAwODM3OV0gV29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBkZWZlcnJl
ZF9wcm9iZV93b3JrX2Z1bmMNCj4gWyAgKzAuMDExNjk0XSBwc3RhdGU6IDgwMDAwMDA1IChOemN2
IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUw0KPiBCVFlQRT0tLSkNCj4gWyAgKzAuMDEz
OTU5XSBwYyA6IGRybV9wbGFuZV9jcmVhdGVfYmxlbmRfbW9kZV9wcm9wZXJ0eSsweGYwLzB4MTEw
DQo+IFtkcm1dDQo+IFsgICswLjAxMzExMV0gbHIgOiBtdGtfcGxhbmVfaW5pdCsweGY0LzB4MTk4
IFttZWRpYXRla19kcm1dDQo+IFsgICswLjAxMDgyOV0gc3AgOiBmZmZmODAwMDgxZDUzOGMwDQo+
IFsgICswLjAwNjYzNF0geDI5OiBmZmZmODAwMDgxZDUzOGMwIHgyODogZmZmZjAwMDBjNDMxZTA4
MCB4Mjc6DQo+IGZmZmYwMDAwYzE5Nzg3YTgNCj4gWyAgKzAuMDE0MzE0XSB4MjY6IDAwMDAwMDAw
MDAwMDA1NDggeDI1OiAwMDAwMDAwMDAwMDAwMDA2IHgyNDoNCj4gZmZmZjAwMDBjNDMxZjAwMA0K
PiBbICArMC4wMTQzMTddIHgyMzogMDAwMDAwMDAwMDAwMDAzNSB4MjI6IDAwMDAwMDAwMDAwMDAw
MDYgeDIxOg0KPiBmZmZmMDAwMGMwY2ExMDU4DQo+IFsgICswLjAxNDMxM10geDIwOiAwMDAwMDAw
MDAwMDAwMDA2IHgxOTogMDAwMDAwMDAwMDAwMDAwMCB4MTg6DQo+IGZmZmZmZmZmZmZmZmZmZmYN
Cj4gWyAgKzAuMDE0MzE0XSB4MTc6IDZmNzI3MDIwNjU3NDYxNjUgeDE2OiA3MjYzMjA2Zjc0MjA2
NDY1IHgxNToNCj4gZmZmZjAwMDBjNDE0ZTYyNg0KPiBbICArMC4wMTQzMTZdIHgxNDogMDAwMDAw
MDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAwMjggeDEyOg0KPiAwMTAxMDEwMTAxMDEwMTAx
DQo+IFsgICswLjAxNDMxM10geDExOiA3ZjdmN2Y3ZjdmN2Y3ZjdmIHgxMDogZmVmZWZlZmY3MjZl
NmY3OSB4OSA6DQo+IGZmZmY4MDAwNzllNjg5ZGMNCj4gWyAgKzAuMDE0MzE2XSB4OCA6IGZmZmYw
MDAwYzU4NzU1NTQgeDcgOiAwMDAwMDAwMGVlZWVlZWVlIHg2IDoNCj4gMDAwMDAwMDBjMGMwYzBj
MA0KPiBbICArMC4wMTQzMTRdIHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4NCA6IGZmZmYwMDAwYzBj
YTExOTAgeDMgOg0KPiBmZmZmMDAwMGMwY2ExMTkwDQo+IFsgICswLjAxNDMxM10geDIgOiAwMDAw
MDAwMDAwMDBmZmZmIHgxIDogMDAwMDAwMDAwMDAwMDAwNiB4MCA6DQo+IGZmZmYwMDAwYzBjYTEw
NTgNCj4gWyAgKzAuMDE0MzE0XSBDYWxsIHRyYWNlOg0KPiBbICArMC4wMDQ4OTFdICBkcm1fcGxh
bmVfY3JlYXRlX2JsZW5kX21vZGVfcHJvcGVydHkrMHhmMC8weDExMCBbZHJtXQ0KPiBbICArMC4w
MTI0MTVdICBtdGtfcGxhbmVfaW5pdCsweGY0LzB4MTk4IFttZWRpYXRla19kcm1dDQo+IFsgICsw
LjAxMDEzMl0gIG10a19jcnRjX2NyZWF0ZSsweDM0Yy8weDg1OCBbbWVkaWF0ZWtfZHJtXQ0KPiBb
ICArMC4wMTA0NzldICBtdGtfZHJtX2JpbmQrMHg0YjQvMHg2MDAgW21lZGlhdGVrX2RybV0NCj4g
WyAgKzAuMDA5OTU2XSAgdHJ5X3RvX2JyaW5nX3VwX2FnZ3JlZ2F0ZV9kZXZpY2UrMHgyMWMvMHgy
ZTgNCj4gWyAgKzAuMDEwODI1XSAgX19jb21wb25lbnRfYWRkKzB4YzAvMHgxYzANCj4gWyAgKzAu
MDA3Njg1XSAgY29tcG9uZW50X2FkZCsweDFjLzB4MzgNCj4gWyAgKzAuMDA3MTYzXSAgbXRrX2Rp
c3BfcmRtYV9wcm9iZSsweDE0OC8weDIzMCBbbWVkaWF0ZWtfZHJtXQ0KPiBbICArMC4wMTExNzVd
ICBwbGF0Zm9ybV9wcm9iZSsweDcwLzB4ZTgNCj4gWyAgKzAuMDA3MzM4XSAgcmVhbGx5X3Byb2Jl
KzB4YzgvMHgzYTANCj4gWyAgKzAuMDA3MTYxXSAgX19kcml2ZXJfcHJvYmVfZGV2aWNlKzB4ODQv
MHgxNjANCj4gWyAgKzAuMDA4NzMwXSAgZHJpdmVyX3Byb2JlX2RldmljZSsweDQ0LzB4MTMwDQo+
IFsgICswLjAwODM3OV0gIF9fZGV2aWNlX2F0dGFjaF9kcml2ZXIrMHhjNC8weDE3MA0KPiBbICAr
MC4wMDg5MDVdICBidXNfZm9yX2VhY2hfZHJ2KzB4OTAvMHgxMDANCj4gWyAgKzAuMDA3ODU1XSAg
X19kZXZpY2VfYXR0YWNoKzB4YTgvMHgxYzgNCj4gWyAgKzAuMDA3Njg1XSAgZGV2aWNlX2luaXRp
YWxfcHJvYmUrMHgxYy8weDMwDQo+IFsgICswLjAwODM4MF0gIGJ1c19wcm9iZV9kZXZpY2UrMHhi
MC8weGMwDQo+IFsgICswLjAwNzY4M10gIGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYysweGJjLzB4
MTIwDQo+IFsgICswLjAwOTI1M10gIHByb2Nlc3Nfb25lX3dvcmsrMHgxNzgvMHgzZDANCj4gWyAg
KzAuMDA4MDMzXSAgd29ya2VyX3RocmVhZCsweDIwMC8weDNmMA0KPiBbICArMC4wMDc1MTFdICBr
dGhyZWFkKzB4ZTgvMHhmOA0KPiBbICArMC4wMDYxMTVdICByZXRfZnJvbV9mb3JrKzB4MTAvMHgy
MA0KPiBbICArMC4wMDcxNjRdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0K
PiBbICArMC4wMDkyNzhdIFtkcm06bXRrX3BsYW5lX2luaXQgW21lZGlhdGVrX2RybV1dICpFUlJP
UiogZmFpbGVkIHRvDQo+IGNyZWF0ZSBwcm9wZXJ0eTogYmxlbmRfbW9kZQ0KPiANCj4gRnJvbSBN
VDgxODM6DQo+IA0KPiBbICAgMTMuOTM2OTg5XSAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0t
LS0tLS0tLS0NCj4gWyAgIDEzLjk0NjIyNF0gV0FSTklORzogQ1BVOiA1IFBJRDogNjAgYXQNCj4g
ZHJpdmVycy9ncHUvZHJtL2RybV9ibGVuZC5jOjU4Ng0KPiBkcm1fcGxhbmVfY3JlYXRlX2JsZW5k
X21vZGVfcHJvcGVydHkrMHhmMC8weDExMCBbZHJtXQ0KPiBbICAgMTMuOTY4NzE0XSBNb2R1bGVz
IGxpbmtlZCBpbjogWy4uLl0NCj4gWyAgIDE0LjExNjgxNF0gQ1BVOiA1IFVJRDogMCBQSUQ6IDYw
IENvbW06IGt3b3JrZXIvdTM0OjIgVGFpbnRlZDoNCj4gRyAgICAgICAgVyAgICAgICAgICA2LjEx
LjAtbmV4dC0yMDI0MDkyNy1kZWItMDAwMDYtZ2U1MTRhMGY4OWRkOSAjMQ0KPiBbICAgMTQuMTQw
MzIzXSBUYWludGVkOiBbV109V0FSTg0KPiBbICAgMTQuMTQ2MjQ4XSBIYXJkd2FyZSBuYW1lOiBH
b29nbGUgY296bW8gYm9hcmQgKERUKQ0KPiBbICAgMTQuMTU1ODMwXSBXb3JrcXVldWU6IGV2ZW50
c191bmJvdW5kIGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYw0KPiBbICAgMTQuMTY3NTA1XSBwc3Rh
dGU6IDgwMDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gLURJVCAtU1NCUw0KPiBCVFlQ
RT0tLSkNCj4gWyAgIDE0LjE4MTQ0MF0gcGMgOiBkcm1fcGxhbmVfY3JlYXRlX2JsZW5kX21vZGVf
cHJvcGVydHkrMHhmMC8weDExMA0KPiBbZHJtXQ0KPiBbICAgMTQuMTk0NTI5XSBsciA6IG10a19w
bGFuZV9pbml0KzB4ZjQvMHgxODggW21lZGlhdGVrX2RybV0NCj4gWyAgIDE0LjIwNTMzOF0gc3Ag
OiBmZmZmODAwMDgwNGEzODYwDQo+IFsgICAxNC4yMTE5NjBdIHgyOTogZmZmZjgwMDA4MDRhMzg2
MCB4Mjg6IGZmZmY3MTU0NDUyODgwODAgeDI3Og0KPiBmZmZmNzE1NDQxN2ZhNzQ4DQo+IFsgICAx
NC4yMjYyNDddIHgyNjogMDAwMDAwMDAwMDAwMDU0OCB4MjU6IDAwMDAwMDAwMDAwMDAwMDYgeDI0
Og0KPiBmZmZmNzE1NDQ1MjhhMDAwDQo+IFsgICAxNC4yNDA1MzZdIHgyMzogMDAwMDAwMDAwMDAw
MDAzNSB4MjI6IDAwMDAwMDAwMDAwMDAwMDYgeDIxOg0KPiBmZmZmNzE1NDQ1YTQ5YWU4DQo+IFsg
ICAxNC4yNTQ4MjJdIHgyMDogMDAwMDAwMDAwMDAwMDAwNiB4MTk6IDAwMDAwMDAwMDAwMDAwMDAg
eDE4Og0KPiBmZmZmZmZmZmZmZmZmZmZmDQo+IFsgICAxNC4yNjkxMTBdIHgxNzogNmY3MjcwMjA2
NTc0NjE2NSB4MTY6IGZmZmZkNmZhY2NlYWU4YzAgeDE1Og0KPiBmZmZmNzE1NDcwNDIxZDQ2DQo+
IFsgICAxNC4yODMzOThdIHgxNDogMDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMDAw
MjggeDEyOg0KPiAwMTAxMDEwMTAxMDEwMTAxDQo+IFsgICAxNC4yOTc2ODZdIHgxMTogN2Y3Zjdm
N2Y3ZjdmN2Y3ZiB4MTA6IGZlZmVmZWZmNzI2ZTZmNzkgeDkgOg0KPiBmZmZmZDZmYTkyZDE3OWRj
DQo+IFsgICAxNC4zMTE5NzNdIHg4IDogZmZmZjcxNTQ0NTE1NmFkNCB4NyA6IDAwMDAwMDAwZWVl
ZWVlZWUgeDYgOg0KPiAwMDAwMDAwMGMwYzBjMGMwDQo+IFsgICAxNC4zMjYyNjFdIHg1IDogMDAw
MDAwMDAwMDAwMDAwMCB4NCA6IGZmZmY3MTU0NDVhNDljMjAgeDMgOg0KPiBmZmZmNzE1NDQ1YTQ5
YzIwDQo+IFsgICAxNC4zNDA1NDldIHgyIDogMDAwMDAwMDAwMDAwZmZmZiB4MSA6IDAwMDAwMDAw
MDAwMDAwMDYgeDAgOg0KPiBmZmZmNzE1NDQ1YTQ5YWU4DQo+IFsgICAxNC4zNTQ4MzddIENhbGwg
dHJhY2U6DQo+IFsgICAxNC4zNTk3MThdICBkcm1fcGxhbmVfY3JlYXRlX2JsZW5kX21vZGVfcHJv
cGVydHkrMHhmMC8weDExMCBbZHJtXQ0KPiBbICAgMTQuMzcyMTExXSAgbXRrX3BsYW5lX2luaXQr
MHhmNC8weDE4OCBbbWVkaWF0ZWtfZHJtXQ0KPiBbICAgMTQuMzgyMjI0XSAgbXRrX2NydGNfY3Jl
YXRlKzB4MzRjLzB4ODU4IFttZWRpYXRla19kcm1dDQo+IFsgICAxNC4zOTI2ODVdICBtdGtfZHJt
X2JpbmQrMHg1MWMvMHg2MDAgW21lZGlhdGVrX2RybV0NCj4gWyAgIDE0LjQwMjYyMl0gIHRyeV90
b19icmluZ191cF9hZ2dyZWdhdGVfZGV2aWNlKzB4MjFjLzB4MmU4DQo+IFsgICAxNC40MTM0MjVd
ICBfX2NvbXBvbmVudF9hZGQrMHhjMC8weDFjMA0KPiBbICAgMTQuNDIxMDk0XSAgY29tcG9uZW50
X2FkZCsweDFjLzB4MzgNCj4gWyAgIDE0LjQyODI0MV0gIG10a19kc2lfaG9zdF9hdHRhY2grMHg4
MC8weGUwIFttZWRpYXRla19kcm1dDQo+IFsgICAxNC40MzkwNDldICBkZXZtX21pcGlfZHNpX2F0
dGFjaCsweDNjLzB4YTANCj4gWyAgIDE0LjQ0NzQxM10gIGFueDc2MjVfbGlua19icmlkZ2UrMHhm
Yy8weDFjOCBbYW54NzYyNV0NCj4gWyAgIDE0LjQ1NzUyMl0gIGRwX2F1eF9lcF9wcm9iZSsweDU0
LzB4MTEwIFtkcm1fZHBfYXV4X2J1c10NCj4gWyAgIDE0LjQ2ODE1MF0gIHJlYWxseV9wcm9iZSsw
eGM4LzB4M2EwDQo+IFsgICAxNC40NzUyOTZdICBfX2RyaXZlcl9wcm9iZV9kZXZpY2UrMHg4NC8w
eDE2MA0KPiBbICAgMTQuNDg0MDA5XSAgZHJpdmVyX3Byb2JlX2RldmljZSsweDQ0LzB4MTMwDQo+
IFsgICAxNC40OTIzNzRdICBfX2RldmljZV9hdHRhY2hfZHJpdmVyKzB4YzQvMHgxNzANCj4gWyAg
IDE0LjUwMTI2MV0gIGJ1c19mb3JfZWFjaF9kcnYrMHg5MC8weDEwMA0KPiBbICAgMTQuNTA5MTAz
XSAgX19kZXZpY2VfYXR0YWNoKzB4YTgvMHgxYzgNCj4gWyAgIDE0LjUxNjc3Ml0gIGRldmljZV9p
bml0aWFsX3Byb2JlKzB4MWMvMHgzMA0KPiBbICAgMTQuNTI1MTM3XSAgYnVzX3Byb2JlX2Rldmlj
ZSsweGIwLzB4YzANCj4gWyAgIDE0LjUzMjgwNV0gIGRlZmVycmVkX3Byb2JlX3dvcmtfZnVuYysw
eGJjLzB4MTIwDQo+IFsgICAxNC41NDIwNDBdICBwcm9jZXNzX29uZV93b3JrKzB4MTc4LzB4M2Qw
DQo+IFsgICAxNC41NTAwNTldICB3b3JrZXJfdGhyZWFkKzB4MjAwLzB4M2YwDQo+IFsgICAxNC41
NTc1NTNdICBrdGhyZWFkKzB4ZTgvMHhmOA0KPiBbICAgMTQuNTYzNjU2XSAgcmV0X2Zyb21fZm9y
aysweDEwLzB4MjANCj4gWyAgIDE0LjU3MDgwM10gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAw
MDAwMCBdLS0tDQo+IFsgICAxNC41ODAwNTJdIFtkcm06bXRrX3BsYW5lX2luaXQgW21lZGlhdGVr
X2RybV1dICpFUlJPUiogZmFpbGVkIHRvDQo+IGNyZWF0ZSBwcm9wZXJ0eTogYmxlbmRfbW9kZQ0K
DQpUYWtlIGEgZ2xpbXBzZSBvZiBkcm1fcGxhbmVfY3JlYXRlX2JsZW5kX21vZGVfcHJvcGVydHko
KSwgaXQgY2FuIHNpbXBseQ0KZmluZCB0aGUgcmVhc29uIGhlcmU6DQovKioNCiAqIGRybV9wbGFu
ZV9jcmVhdGVfYmxlbmRfbW9kZV9wcm9wZXJ0eSAtIGNyZWF0ZSBhIG5ldyBibGVuZCBtb2RlDQpw
cm9wZXJ0eQ0KICogQHBsYW5lOiBkcm0gcGxhbmUNCiAqIEBzdXBwb3J0ZWRfbW9kZXM6IGJpdG1h
c2sgb2Ygc3VwcG9ydGVkIG1vZGVzLCBtdXN0IGluY2x1ZGUNCiAqICAgICAgICAgICBCSVQoRFJN
X01PREVfQkxFTkRfUFJFTVVMVEkpLiBDdXJyZW50IERSTSBhc3N1bXB0aW9uIGlzDQogKiAgICAg
ICAgICAgdGhhdCBhbHBoYSBpcyBwcmVtdWx0aXBsaWVkLCBhbmQgb2xkIHVzZXJzcGFjZSBjYW4g
YnJlYWsNCmlmDQogKiAgICAgICAgICAgdGhlIHByb3BlcnR5IGRlZmF1bHRzIHRvIGFueXRoaW5n
IGVsc2UuDQogLi4uDQogKiBSRVRVUk5TOg0KICogWmVybyBmb3Igc3VjY2VzcyBvciAtZXJybm8N
CiAqLw0KDQppbnQgZHJtX3BsYW5lX2NyZWF0ZV9ibGVuZF9tb2RlX3Byb3BlcnR5KHN0cnVjdCBk
cm1fcGxhbmUgKnBsYW5lLA0KICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IHN1cHBv
cnRlZF9tb2RlcykNCnsNCiAgICB1bnNpZ25lZCBpbnQgdmFsaWRfbW9kZV9tYXNrID0gQklUKERS
TV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpIHwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgQklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSAgIHwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQklUKERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFKTsNCi4uLg0KDQog
ICAgaWYgKFdBUk5fT04oKHN1cHBvcnRlZF9tb2RlcyAmIH52YWxpZF9tb2RlX21hc2spIHx8DQog
ICAgICAgICgoc3VwcG9ydGVkX21vZGVzICYgQklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSkg
PT0gMCkpKQ0KICAgICAgICByZXR1cm4gLUVJTlZBTDsNCi4uLg0KfQ0KDQpTbyBJIHRoaW5rIGlm
IHRoZSBTb0NzIGRvbid0IHN1cHBvcnQgcHJlLW11bHRpcGxpZWQgY29sb3IgZm9ybWF0cywgdGhl
bg0KanVzdCBub3QgY3JlYXRlIHRoZSBibGVuZF9tb2RlIHByb3BlcnR5IGFuZCB1c2UgdGhlIGNv
dmVyYWdlIG1vZGUgY29sb3INCmZvcm1hdCBhcyBkZWZhdWx0IHNldHRpbmdzIGZvciBPVkwuDQoN
CkknbGwgc2VuZCB2OCBmb3IgdGhpcy4NCg0KVGhhbmtzIGZvciB0aGUgdmVyaWZpY2F0aW9uIG9u
IE1UODE3MywgTVQ4MTgzIGFuZCBNVDgxODYuDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg==

