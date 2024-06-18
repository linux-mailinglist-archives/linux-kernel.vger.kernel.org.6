Return-Path: <linux-kernel+bounces-219921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE98590DA5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20954B24498
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EC913AD12;
	Tue, 18 Jun 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="azUDLXsK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YtzI9XL4"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C98E39AEC
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718730048; cv=fail; b=IR/EtArUkpzLruTAueii6VFWeXJkqyRjOYouA+E0osmcOea7X1uO485TchCpkj3BwVPIpQ93ELzkJBdz3bF5+TouMKpFWrxL3N7pIjhl3OWWwpXp2JFmEw/9Zu7jet6Kt9ppEhItbI7KtGBOHvYh+UOd/O7f4tH9E2B9GaYG0Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718730048; c=relaxed/simple;
	bh=WlPFq9TQ6aUZ3ZbWfFd7G2ALTK2TlxFWdSgDHGvdrEQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j9+NDhXkcDCZFQG4jnbvCgdRXr4ugXV0dtmmRJhgKfA7RLVGxW5dugETg73w1f67eDwKhfqvU58/bn8K5Nn2a0emz8bI8mcMiZEUHT7vh+LtuU8yW9Kq8zfPibm7f88OaLi72D+KsOgXo40PAi6VgOM5IIwjsdJs8JvOIYa0WUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=azUDLXsK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=YtzI9XL4; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 45b769f02d9411efa54bbfbb386b949c-20240619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WlPFq9TQ6aUZ3ZbWfFd7G2ALTK2TlxFWdSgDHGvdrEQ=;
	b=azUDLXsKmCboPLSVFyhCS9TurHnCK172ouRelDUM3vSVZX2Q+6WY5PLH733r9FhxdPhLc+NEqQD4z58VSrzP+G4OJl+wtP2Q0HnEBE+sYstsd/VyZlYg+DjT6QLd/Y3l/icJmZj+u9le+OlSOvLUsPNYoyAtTYfm7oR7PEsCE2k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:0f397f4e-03f1-4510-8486-f72331ce9768,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:8a36bb44-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 45b769f02d9411efa54bbfbb386b949c-20240619
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1193250078; Wed, 19 Jun 2024 01:00:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 19 Jun 2024 01:00:29 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 19 Jun 2024 01:00:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX+eVOMPWjUlpq/lBU3F6wIpKZVxvv8T01kLGzlz/H1GQA0yrE6bN/h6944TA/vJYDy1HAQOyV9WJ2roJDDVN+u1StB38nlC3LsGW1O60t3AKo91F/TRuF0Ygh0z4/03VPbJxOrv1WdBYWlsdWDgiuBhTZCPJpNYheXuFsJXC+ivVjCugqgvJcLNWjNOCnf1w5GaX2sLecxlIzuS2gLTlNzzILSqhMptQs92P3C8zVbBgYw8iKYtud+3NsmXhVmX+LysHTSsNu3/+1GB03SHRVnX/MoOoGnEtKDL1E0eKABQJaaWp52vUXZT1fKVDDHWHd16VHZxqhAA8Q8sMYcCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlPFq9TQ6aUZ3ZbWfFd7G2ALTK2TlxFWdSgDHGvdrEQ=;
 b=Fv3eXRcnqGm8mc+Fjut68inJy83v4po8aOsscORU7IoHOfocQgUT4ldbn4bCQQcwec5VaxRriAH8qc7+hWSHBn6cgEClYYiWBdPzhlcl8gGyhXZfVinGAVx8zonkH+a/hxYTnroHePbMhljJhnem1gCyvAde+JAryybC+062lBlqFnOUrxM1iS8A6SNz0Mo2MGJsdGCCoB+Lio/0GQjdE9OBPIL44AoDhY8DktaQdmPqegxdoTXQhI8FOsp5Et3LYMRNKEH6mhGttontb2mTyXj7gGSu9C4LcgWsZYvyJyw4BpxSxcRtNNWseJb7RCSD6cKRcDXucE7lwAIoL2z5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlPFq9TQ6aUZ3ZbWfFd7G2ALTK2TlxFWdSgDHGvdrEQ=;
 b=YtzI9XL4ugvW1BGW0Icy4I7kVPiy/u6cs/HBYfaS2Bikv5QQ8c+4uzTqzjvgqkrNP139Svg3U4sr4PZCnPAd/D12xGSaLrIp5clDLdPMfKfeFQkE9g/LCEg28QIxKSbuILalttZEAuinTJQ1bcUl2H0tsS5Wxnbe8ZLmFoPZEo8=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB8350.apcprd03.prod.outlook.com (2603:1096:990:4c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 17:00:26 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 17:00:25 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Topic: [PATCH v9 16/21] drm/mediatek: Support "Pre-multiplied" blending
 in OVL
Thread-Index: AQHavgV49wT8mhUKY0S2pyEBe18TarHGvx2AgAcG3QA=
Date: Tue, 18 Jun 2024 17:00:25 +0000
Message-ID: <ca5f0f155d9dec0b6c853128d9fd753042a5d25e.camel@mediatek.com>
References: <20240614024620.19011-1-shawn.sung@mediatek.com>
	 <20240614024620.19011-17-shawn.sung@mediatek.com>
	 <a966988a520adc5aee5ee70657efd778d011ded0.camel@mediatek.com>
In-Reply-To: <a966988a520adc5aee5ee70657efd778d011ded0.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB8350:EE_
x-ms-office365-filtering-correlation-id: ff882caa-32fa-4534-d9ab-08dc8fb825d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?RGNNWFJnalJkc1c3b05uWW5lcE1RUm9ibzkrZDh4bVc3bGs1Tjhvekl5aWVN?=
 =?utf-8?B?aWdVSFZuNDdieVc2dkNDcC9HenV0bUxEc0luTktaR09ya0QzVm9mODQrZVBV?=
 =?utf-8?B?MWltaUdSTlNJRDhwaEUvZXVVN3BxZFRWTDJRRTR4OEY4WEt0MFVKYmJKaGNq?=
 =?utf-8?B?bkliVkJXOFJHdGN0VzdHOHA0SFJVVGEySktQOGFxSTRIYVRzQWVSd1BXZ1Zm?=
 =?utf-8?B?ZitLVHQ4alM2aWNVN3Breko5bzlSc2NML05GSjdxRHVGQSsvSHhTQlpXN09o?=
 =?utf-8?B?V1BhTUZJSFdibG94TG1KYXdNOXV5RzJXRnppSDBsZ2tvczdJVFhON3dIQjhL?=
 =?utf-8?B?bmgyWENYaXFRK3c5ZjE1cnNRNXgrUDEyTkdabnU2WFNiSkFwT0Zwc3dqWnBx?=
 =?utf-8?B?SGNxSkFveWVhUnlDV1lhemNYeHY5SDZrZlBiNXhndXVNUkZBT0gwcTdIWlZp?=
 =?utf-8?B?SHJBN3EvNFFwWGNSR3VMWHFZblB0Wlk1UkRKWGgzS1VyVkQ2a3FCaEo4T21E?=
 =?utf-8?B?NVFPS2Y4YWhEaStydlhhbm9ibGN2SCtOd0pLM3d4RHArdjkzUCs5c09iVzE2?=
 =?utf-8?B?NmlLOXg5KzdycTRTL2FsWGFybXNQbTkra0Q3N0labXBKOXFXeENvMUdMUVZr?=
 =?utf-8?B?TVJJNVVHZWFNTXRLSXpQNmZnMmdYd25zdXZaSGg3TnRxbGJ4WVJQRy9la2lt?=
 =?utf-8?B?RmJvRzk0YVNGak4wcHcrS0FJeEJma0YvRExpS2VKNjZnakVLQTVWclRFZXc2?=
 =?utf-8?B?cGZkSllqMnBYd2NGaE1sTzBVbzYzWmZuVHJMaUpWbGFRY0dSWUhhdHJkUndh?=
 =?utf-8?B?c1NvVDRsTVZ6NlFHZ1VHL2E1dWhwOHZKOFcxcXpBazZIbVVoekZRdFdoMDRi?=
 =?utf-8?B?dWVTaDdobXVsRnJ3OGFHazZBS1ovaUhRWU9NNm5HSkZiTDYwUWJWZURFQkha?=
 =?utf-8?B?eWJtVzNlaExkR2U5Qk4vYXZIVkVGWXNzckVSaEs1cW5qQlRhTXJCOXQ1TnZs?=
 =?utf-8?B?T0VJcGNlS2k0b2NHMDk4dmg0R1NFd20rUU9BQkcyRWdSTmdQdU43ZjVUdWxz?=
 =?utf-8?B?K2RvZFk3Njd5RkdPdlBieGR4NG13VTcrZENLcGM3aUFSbXpjc1JLTEI1K1JW?=
 =?utf-8?B?YkQyOHpGMFZzK0dqK0h5NGwya002TkpweUVSK1VqdytaTlVmQW9CSjkrSk9U?=
 =?utf-8?B?dDNET3cvMlNnb21nZTdmTnNka05MZzZQUVRXWHZhSzA4UXpua20waTg0bjM3?=
 =?utf-8?B?cGYrTXQ2SldTejNDZGM4SlNpQmswNW9CWnV1bnZnb0k3VGN0N3FFalREOGRq?=
 =?utf-8?B?UTlXRHZydkJqd0J2NnlMSC9qclBCWWYreVlLWlhrR0VCU2xnZDFEY2F1bURX?=
 =?utf-8?B?YVpTejVGcC8zcW1jWWFPd2NyZGdlK0cwc3VSUTJrVUszdGJoV2VvOXlKYmFE?=
 =?utf-8?B?ZWhhRnY4ZVIwV0oyZXdoamliSHRxU2hONzBndElqY2YrZjBEMWVpalNwOFZB?=
 =?utf-8?B?MFo5MWNPdWZpeU8reFFWc0JBc3IzZ0FWZ2NnRmNWRlBQendLSXVVV0c5bkpw?=
 =?utf-8?B?cDRYSzYrQkpsc3hHMGhtakplbG9WZGpxUXdoMTI2NFZQSFFyc0hidHhQcTA5?=
 =?utf-8?B?T09pY2R1L2MzKzZrdFBjNmpOVjA2MUlydFdDOGtXK3VOZG05Q003bnd3YS9E?=
 =?utf-8?B?dThhZHZYMWV5NW83RXRtSDNqbkJ1YnBYWDB2UEdTUThVUW04aGI0TE1wY05I?=
 =?utf-8?Q?mS1W1PwUIwfFqPcuCqqt7mElGirsDVoa16rWTiW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjNGRFdWc1lIazQ0eWlGOGw3bnplUWZKVkpsUnM2eVlPOWs0UEVBaytwWStJ?=
 =?utf-8?B?Mm1md1FxT0l2NWRpNStlSm9iemQ2QWJld1QrQ29SblRTYmVkMVVydzVxREZ1?=
 =?utf-8?B?K2NISnZDT1RsOVVPdFlUNDVQOGRyY0ZPajJXaVFyVC8wUy9IVW1yczZZSThD?=
 =?utf-8?B?bURibk9CR2kxSkZ0QjNTTWI0VnBxZ2hlN2xkNUttOHdveFJmYjB6N1J2ekRt?=
 =?utf-8?B?dzF0TUxXeHRhdHFGOXlzRTRqREFRMmlCYlFyTHVpZUxjK1lheVk4ZDJBV3lU?=
 =?utf-8?B?Y0dpRVVMbzNZTFhER1l6ZXp1VFBoRTM0SC90UXdnYlVrZkxkM3VrWjhXbmpu?=
 =?utf-8?B?UC9Ub0hMOUFDT0JCWlNZNFQxYSs0ZGg4bjQwc1g0YjJrMGF5aHhhQkFtUHZm?=
 =?utf-8?B?MUFQZk1pWlpEbE5lVnp2dXZQRmFUWHpkU2l1WDBsc3huTDBWT2lvZEdPUis3?=
 =?utf-8?B?MTdBWloxRmo1OXZXdHlPWnVCNGhCb0JLK29HVWJtOVdvOWtOTGF1L2VabktQ?=
 =?utf-8?B?dGVoQjJkanc0ZkhrSVpwemJ5V3dtOE1XZWN5c1RGMDlNWktCbkplVVJiWUtw?=
 =?utf-8?B?SlZPanpEcTFtTlRON21CaW9BZDBGZGxQMC8rNCtENG84VWhuU1FMVW1EdEVn?=
 =?utf-8?B?SlpUbVc4RmlCcGxSaWZnTE5zODVLeEZ4eDMrVjJlS0FMblNHRnhFcXhIQ05R?=
 =?utf-8?B?c1BlbHIyY3kxbk5LSDErZEZYZ1F3Z2hKakFmVHk5M0RWaGZKcXUwbXVTUFFT?=
 =?utf-8?B?c0JOTnA1ZHJKSU5nOFVVNnc1VkJVMDVUR0RrL3I1RlZtUjh0YVdVcEdVOXB0?=
 =?utf-8?B?RVdXRkpQRVhZNDdMeHdIdkZOREcrUnBaZjN0M1hDR3Q5SXgzM1JYRU1qcG1Y?=
 =?utf-8?B?U3gzczBLeDQ5L1BZVzRLVC9VeUQ4eEs1MlBFamEvRTZLMno2UGhVMnNaWUFR?=
 =?utf-8?B?KzkzVHg4a3JYcFMzVENCNmNFL0UyS015dWpIbGNsWFJBdEhUaWNnQ0lDTGJa?=
 =?utf-8?B?ejVHeDA2d25MK3BYTGNnY3ltK3JsSlBMdndiMk52ZWxUakY4VE5DMHVTcW81?=
 =?utf-8?B?bWlNc05EK3ArTFIvT211SGVldllSUUtndlZkcm9IbmZYVnU0QlMvQ3J2ZHE3?=
 =?utf-8?B?V2x1V0ZUV1kwTG42WkpQNklTOGFNZld5QklZT240TSt6Mm12MU96c2FwUzM2?=
 =?utf-8?B?THlFM2k3TWt1WmJrYXdxbzVHbkJwZytkNEc0emNaZkYxbTRkQUlrd2xCaVpq?=
 =?utf-8?B?MERZem95YnZwdDNseXUvRmovcnNIRzArTjYvTnFrcWFzSUNwQ3FaNXd3SGZa?=
 =?utf-8?B?akpXVk1TUFA0RS9ma3dweFBXY2syTWR3cEdEWk9sZmh0dCt5RkhJK1NHNUlp?=
 =?utf-8?B?Q3FrTkpOKzlYUnVvV2xQSWNnNGZvMlpiamRzQkdoYmcxT1NzM2MyWGdySWNX?=
 =?utf-8?B?SXNnNDVySUVSdWp3Y2pnR01kOVdZZEwwN0V5SVU0eERBUGdYamgwYWVaYmZ6?=
 =?utf-8?B?YVJXZ1RYTFRiNkZRUTVoeUV0OENVYXozWDNWNGtZWjc3YzFxNGwvQkFVRUxp?=
 =?utf-8?B?K0pTUWh4UzlZVjBnN1lGcU1tNi8vcHlTbGVodXA4bmlWd2dTZkljVmZsc2Jj?=
 =?utf-8?B?MjFjUWdHblJBRlJ2NjlsclhkL0R1Q3FGWHRyN2NCR2RzSm1KTGxRY3RnekNm?=
 =?utf-8?B?M0RnU24vdnlhMkwvQUpLRUNFRlk0RStsOHZDQTMvUkpVQXFnMktiVVR6UlAy?=
 =?utf-8?B?T2JqRDZpWXV5VnN2eVhIQU9ZZmdJYkJXYk4vZXE0dWxLK0IzbEJFbnBaM2RM?=
 =?utf-8?B?U2xXQWNLVzZaa0RTVlNmcW9KSndLcFFEYTdwWHFPZmFkejAwazBKL3lDUm5h?=
 =?utf-8?B?ZjB5R1E3aDFMWlRmVjM3S1dUbktYb05lSUF4b2RndlJ0cnI1Y1FXazdPMWhP?=
 =?utf-8?B?ZlJaaHEvUndKWHZtYytocFdIOVJ1cTdVOHA0MFUrZ2RzSi8vWWRXQnc3YXhN?=
 =?utf-8?B?azFRL0JBTG9TWXIvNVVLempEcSt1SnZzcTRkd2gwNlQ5eVN6R2FIL0NJNTF2?=
 =?utf-8?B?YVN3WXgrMDdrUDVBakZuc3V5bG81MkkzZ2dlNzVVdVJoTFoxNE04WVVzVnVh?=
 =?utf-8?B?c1Mwc0lyakZyRFROZ0JxSHNiSUZrQWgyVDIwKzE1QTZqVUtCd0szTmRSSzcv?=
 =?utf-8?B?ZWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EA3C86E870CC34F8E3653ECEAB1D70A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff882caa-32fa-4534-d9ab-08dc8fb825d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 17:00:25.0964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQTvqDC3dAEOf3aoyIIfFFQWn/X/AI2701rtGHJy/cIQiQfECWiRloN1vdAH7jGDWXQGb+W6VaK2aSi3TUyhCywGnoEPshru5BXFlvjbX8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8350
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.093100-8.000000
X-TMASE-MatchedRID: +f/wAVSGjugOwH4pD14DsPHkpkyUphL9kd8i2lgND8uSO6So6QGgyglh
	29MaPxbmbn6ubG5O3zA3XHGafJ6zuADNPxu11HXjnbUZkYTzXIb03H/AL/kEgGjliw+xvItddd3
	vE6bWkcFgA13cmle3WeuDOejQNY/3Mz9foSi5lHDLtNJZxvPj1u4Z3yke5WgSa0TOsL14A2k8nT
	lRES2M5SbmscCgl1B7waMMbgfResKbGHSBj+j5WbE3FpMbg63Stq2ioQywfV23jFNo+npqn18eE
	9qcFQToSsZXvnJhb0O0dpwqyqI7YWBndBLpnOXPwVaayvK71l9LxPtqS8Bm55soi2XrUn/J+ZL5
	o+vRV7yhMIDkR/KfwI2j49Ftap9EkGUtrowrXLg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.093100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	56E376245DBB7CB71C4E496E8B2BECCA6801FEECEDFB11C06206772E012751D62000:8

SGkgQ0ssDQoNCk9uIEZyaSwgMjAyNC0wNi0xNCBhdCAwNTo0MiArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IE9uIEZyaSwgMjAyNC0wNi0xNCBhdCAxMDo0NiArMDgwMCwgU2hhd24g
U3VuZyB3cm90ZToNCj4gPiBGcm9tOiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiANCj4gPiBTdXBwb3J0ICJQcmUtbXVsdGlwbGllZCIgYWxwaGEgYmxlbmRp
bmcgbW9kZSBvbiBpbiBPVkwuDQo+ID4gQmVmb3JlIHRoaXMgcGF0Y2gsIG9ubHkgdGhlICJjb3Zl
cmFnZSIgbW9kZSBpcyBzdXBwb3J0ZWQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpYW8g
Q2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyB8IDQyICsrKysrKysrKysrKysrKysr
KysrLQ0KPiA+IC0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM0IGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+ID4gaW5kZXggNjU2NzgwNmNmNGUyLi40N2QwYjAzOWE2MTYgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gQEAgLTUyLDgg
KzUyLDEyIEBADQo+ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgoMSA8PCBHTUNfVEhS
RVNIT0xEX0JJVFMpIC8gNCkNCj4gPiAgI2RlZmluZSBHTUNfVEhSRVNIT0xEX0xPVwkoKDEgPDwg
R01DX1RIUkVTSE9MRF9CSVRTKSAvIDgpDQo+ID4gIA0KPiA+ICsjZGVmaW5lIE9WTF9DT05fQ0xS
Rk1UX01BTglCSVQoMjMpDQo+ID4gICNkZWZpbmUgT1ZMX0NPTl9CWVRFX1NXQVAJQklUKDI0KQ0K
PiA+IC0jZGVmaW5lIE9WTF9DT05fTVRYX1lVVl9UT19SR0IJKDYgPDwgMTYpDQo+ID4gKw0KPiA+
ICsvKiBPVkxfQ09OX1JHQl9TV0FQIHdvcmtzIG9ubHkgaWYgT1ZMX0NPTl9DTFJGTVRfTUFOIGlz
IGVuYWJsZWQgKi8NCj4gPiArI2RlZmluZSBPVkxfQ09OX1JHQl9TV0FQCUJJVCgyNSkNCj4gPiAr
DQo+ID4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdCCSgxIDw8IDEyKQ0KPiA+ICAjZGVmaW5l
IE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4CSgyIDw8IDEyKQ0KPiA+ICAjZGVmaW5lIE9WTF9DT05f
Q0xSRk1UX1JHQkE4ODg4CSgzIDw8IDEyKQ0KPiA+IEBAIC02MSw2ICs2NSwxMSBAQA0KPiA+ICAj
ZGVmaW5lIE9WTF9DT05fQ0xSRk1UX0JHUkE4ODg4CShPVkxfQ09OX0NMUkZNVF9BUkdCODg4OCB8
DQo+ID4gT1ZMX0NPTl9CWVRFX1NXQVApDQo+ID4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfVVlW
WQkoNCA8PCAxMikNCj4gPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9ZVVlWCSg1IDw8IDEyKQ0K
PiA+ICsjZGVmaW5lIE9WTF9DT05fTVRYX1lVVl9UT19SR0IJKDYgPDwgMTYpDQo+ID4gKyNkZWZp
bmUgT1ZMX0NPTl9DTFJGTVRfUEFSR0I4ODg4ICgoMyA8PCAxMikgfCBPVkxfQ09OX0NMUkZNVF9N
QU4pDQo+IA0KPiAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCAoT1ZMX0NPTl9DTFJG
TVRfUkdCQTg4ODggfA0KPiBPVkxfQ09OX0NMUkZNVF9NQU4pDQo+IA0KPiBCdXQgSSdtIGNvbmZ1
c2VkIHdpdGggdGhlIG5hbWluZy4NCj4gDQoNCldlIGZvdW5kIHRoYXQgb3JpZ2luYWwgbmFtaW5n
IGlzIG5vdCBjb3JyZWN0LCBzbyB3ZSBmaXggaXQgd2l0aCB0aGUNCnBhdGNoOg0KDQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyNDA2
MTYtbWVkaWF0ZWstZHJtLW5leHQtdjEtMTEtN2U4ZjljZjc4NWQ4QG1lZGlhdGVrLmNvbS8NCg0K
UEFSR0I4ODg4IGlzIG5vdCBBUkdCODg4OCArIE1BTi4NCg0KSWYgRElTUF9SRUdfT1ZMX0NPTiBv
cGVuIHRoZSBNQU4gYml0LCBzb21lIG9yaWdpbmFsIGNvbG9yIGZvcm1hdA0Kc2V0dGluZ3Mgd2ls
bCBiZSBjaGFuZ2VkLCBmb3IgZXhhbXBsZToNCg0KV2hlbiBNQU4gPSAwOg0KUkdCNTY1ID0gMDAw
MCBpbiBiaXRbMTU6MTJdDQpSR0I4ODggPSAwMDAxIGluIGJpdFsxNToxMl0NCkFSR0I4ODg4ID0g
MDAxMCBpbiBiaXRbMTU6MTJdDQpSR0JBODg4OCA9IDAwMTEgaW4gYml0WzE1OjEyXQ0KVVlWWSA9
IDAxMDAgaW4gYml0WzE1OjEyXQ0KWVVZViA9IDAxMDEgaW4gYml0WzE1OjEyXQ0KDQpXaGVuIE1B
TiA9IDE6DQpSR0I4ODggPSAwMDAwIGluIGJpdFsxNToxMl0NClJHQjU2NSA9IDAwMDEgaW4gYml0
WzE1OjEyXQ0KQkdSQQ0KODg4OCA9IDAwMTAgaW4gYml0WzE1OjEyXQ0KUEFSR0I4ODg4ID0gMDAx
MSBpbiBiaXRbMTU6MTJdQkdSQTQ0NDQgPSAwMTAwDQppbiBiaXRbMTU6MTJdDQpCR1JBNTU1MSA9
IDAxMDEgaW4gYml0WzE1OjEyXQ0KWVVZViA9IDEwMDAgaW4gYml0WzE1OjEyXQ0KVVlWWQ0KPSAx
MDAxIGluIGJpdFsxNToxMl0NCllWWVUgPSAxMDEwIGluIGJpdFsxNToxMl0NClZZVVkgPSAxMDEx
IGluIGJpdFsxNToxMl0NCg0KPiANCj4gPiArI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQUJHUjg4
ODggKE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCB8DQo+ID4gT1ZMX0NPTl9SR0JfU1dBUCkNCj4g
DQo+ICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUEFCR1I4ODg4IChPVkxfQ09OX0NMUkZNVF9BQkdS
ODg4OCB8DQo+IE9WTF9DT05fQ0xSRk1UX01BTikNCj4gDQo+ID4gKyNkZWZpbmUgT1ZMX0NPTl9D
TFJGTVRfUEJHUkE4ODg4IChPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODggfA0KPiA+IE9WTF9DT05f
QllURV9TV0FQKQ0KPiANCj4gI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQkdSQTg4ODggKE9WTF9D
T05fQ0xSRk1UX0JHUkE4ODg4IHwNCj4gT1ZMX0NPTl9DTFJGTVRfTUFOKQ0KPiANCj4gPiArI2Rl
ZmluZSBPVkxfQ09OX0NMUkZNVF9QUkdCQTg4ODggKE9WTF9DT05fQ0xSRk1UX1BBQkdSODg4OCB8
DQo+ID4gT1ZMX0NPTl9CWVRFX1NXQVApDQo+ID4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdC
NTY1KG92bCkJKChvdmwpLT5kYXRhLT5mbXRfcmdiNTY1X2lzXzAgPw0KPiA+IFwNCj4gPiAgCQkJ
CQkwIDogT1ZMX0NPTl9DTFJGTVRfUkdCKQ0KPiA+ICAjZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JH
Qjg4OChvdmwpCSgob3ZsKS0+ZGF0YS0+Zm10X3JnYjU2NV9pc18wID8NCj4gPiBcDQo+ID4gQEAg
LTc0LDYgKzgzLDggQEANCj4gPiAgI2RlZmluZQlPVkxfQ09OX1ZJUlRfRkxJUAlCSVQoOSkNCj4g
PiAgI2RlZmluZQlPVkxfQ09OX0hPUlpfRkxJUAlCSVQoMTApDQo+ID4gIA0KPiA+ICsjZGVmaW5l
IE9WTF9DT0xPUl9BTFBIQQkJR0VOTUFTSygzMSwgMjQpDQo+ID4gKw0KPiA+ICBzdGF0aWMgaW5s
aW5lIGJvb2wgaXNfMTBiaXRfcmdiKHUzMiBmbXQpDQo+ID4gIHsNCj4gPiAgCXN3aXRjaCAoZm10
KSB7DQo+ID4gQEAgLTI5OCw3ICszMDksMTMgQEAgdm9pZCBtdGtfb3ZsX2NvbmZpZyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IHcsDQo+ID4gIAlpZiAodyAhPSAwICYmIGgg
IT0gMCkNCj4gPiAgCQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIGggPDwgMTYgfCB3
LCAmb3ZsLQ0KPiA+ID5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiA+ICAJCQkJICAgICAgRElTUF9S
RUdfT1ZMX1JPSV9TSVpFKTsNCj4gPiAtCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwg
MHgwLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLCANCj4gPiBESVNQX1JFR19PVkxfUk9JX0JH
Q0xSKTsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogVGhlIGJhY2tncm91bmQgY29sb3IgbXVz
dCBiZSBvcGFxdWUgYmxhY2sgKEFSR0IpLA0KPiA+ICsJICogb3RoZXJ3aXNlIHRoZSBhbHBoYSBi
bGVuZGluZyB3aWxsIGhhdmUgbm8gZWZmZWN0DQo+ID4gKwkgKi8NCj4gPiArCW10a19kZHBfd3Jp
dGVfcmVsYXhlZChjbWRxX3BrdCwgT1ZMX0NPTE9SX0FMUEhBLCAmb3ZsLQ0KPiA+ID5jbWRxX3Jl
ZywNCj4gPiArCQkJICAgICAgb3ZsLT5yZWdzLCBESVNQX1JFR19PVkxfUk9JX0JHQ0xSKTsNCj4g
DQo+IFRoZSBjb3ZlcmFnZSBtb2RlIGZvcm11bGEgaXM6DQo+IGRzdC5SR0IgPSBzcmMuUkdCICog
c3JjLkEgKyBkc3QuUkdCICogKDEgLSBzcmMuQSkNCj4gDQo+IFRoZSBwcmUtbXVsdGlwbGllZCBt
b2RlIGZvcm11bGEgaXM6DQo+IGRzdC5SR0IgPSBzcmMuUkdCICsgZHN0LlJHQiAqICgxIC0gc3Jj
LkEpDQo+IA0KPiBCb3RoIGZvcm11bGEgaGFzIG5vIGRlc3RpbmF0aW9uIGFscGhhIChJIHRoaW5r
IGJhY2tncm91bmQgY29sb3IgaXMNCj4gbGFzdCBkZXN0aW5hdGlvbiksDQo+IHdoeSBjb3ZlcmFn
ZSBtb2RlIHdvcmsgZmluZSBidXQgcHJlLW11bHRpcGxpZWQgbW9kZSBoYXMgc29tZXRoaW5nDQo+
IHdyb25nPw0KPiANCg0KYWxwaGEgb2YgY292ZXJhZ2UgbW9kZSBmb3JtdWxhIGlzOg0KZHN0LmEg
PSBkc3QuYSB4ICgweGZmIC0gc3JjLmEgeCBTQ0EvMHhmZikvMHhmZiArIHNyYy5hIHggU0NBLzB4
ZmY7DQoNCmFscGhhIG9mIHByZS1tdWx0aXBsaWVkIG1vZGUgaXM6DQpkc3QuYSA9IHJvdW5kKCB7
e2RzdC5hIHggWzB4ZmYgLSByb3VuZCgoc3JjLmEgeCBTQ0EpLzB4ZmYpXX0gLyAweGZmfSArDQpy
b3VuZCgoc3JjLmEgeCBTQ0EpLzB4ZmYpICk7DQoNCiogU0NBIGlzIGNvbnN0YW50IGFscGhhDQoN
CklmIFNDQSA9IDB4ZmYsIHRoZW4gdGhlIGZvcm11bGEgd2lsbCBiZToNCmRzdC5hID0gZHN0LmEg
eCAoMHhmZiAtIHNyYy5hKSArIHNyYy5hDQoNCklmIGRzdC5hIGlzIDAsIHRoZW4gZHN0LmEgd2ls
bCBiZSBzcmMuYQ0KSWYgZHN0LmEgaXMgMHhmZiwgdGhlbiBkc3QuYSB3aWxsIGJlIDB4ZmYNCg0K
DQpSZWdhcmRzLA0KSmFzb24tSkggTGluDQoNCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+ID4gIA0K
PiA+ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHgxLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5y
ZWdzLA0KPiA+IERJU1BfUkVHX09WTF9SU1QpOw0KPiA+ICAJbXRrX2RkcF93cml0ZShjbWRxX3Br
dCwgMHgwLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiA+IERJU1BfUkVHX09WTF9SU1Qp
Ow0KPiA+IEBAIC0zNzQsNyArMzkxLDggQEAgdm9pZCBtdGtfb3ZsX2xheWVyX29mZihzdHJ1Y3Qg
ZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAgCQkgICAgICBESVNQX1JF
R19PVkxfUkRNQV9DVFJMKGlkeCkpOw0KPiA+ICB9DQo+ID4gIA0KPiA+IC1zdGF0aWMgdW5zaWdu
ZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+ID4gdW5z
aWduZWQgaW50IGZtdCkNCj4gPiArc3RhdGljIHVuc2lnbmVkIGludCBvdmxfZm10X2NvbnZlcnQo
c3RydWN0IG10a19kaXNwX292bCAqb3ZsLA0KPiA+IHVuc2lnbmVkIGludCBmbXQsDQo+ID4gKwkJ
CQkgICAgdW5zaWduZWQgaW50IGJsZW5kX21vZGUpDQo+ID4gIHsNCj4gPiAgCS8qIFRoZSByZXR1
cm4gdmFsdWUgaW4gc3dpdGNoICJNRU1fTU9ERV9JTlBVVF9GT1JNQVRfWFhYIg0KPiA+ICAJICog
aXMgZGVmaW5lZCBpbiBtZWRpYXRlayBIVyBkYXRhIHNoZWV0Lg0KPiA+IEBAIC0zOTUsMjIgKzQx
MywzMCBAQCBzdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QNCj4gPiBt
dGtfZGlzcF9vdmwgKm92bCwgdW5zaWduZWQgaW50IGZtdCkNCj4gPiAgCWNhc2UgRFJNX0ZPUk1B
VF9SR0JBODg4ODoNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JYMTAxMDEwMjoNCj4gPiAgCWNh
c2UgRFJNX0ZPUk1BVF9SR0JBMTAxMDEwMjoNCj4gPiAtCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRf
UkdCQTg4ODg7DQo+ID4gKwkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09W
RVJBR0UgPw0KPiA+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCA6DQo+ID4gKwkJ
ICAgICAgIE9WTF9DT05fQ0xSRk1UX1BSR0JBODg4ODsNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9C
R1JYODg4ODoNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBODg4ODoNCj4gPiAgCWNhc2UgRFJN
X0ZPUk1BVF9CR1JYMTAxMDEwMjoNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBMTAxMDEwMjoN
Cj4gPiAtCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfQkdSQTg4ODg7DQo+ID4gKwkJcmV0dXJuIGJs
ZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiA+ICsJCSAgICAgICBPVkxf
Q09OX0NMUkZNVF9CR1JBODg4OCA6DQo+ID4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BCR1JB
ODg4ODsNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9YUkdCODg4ODoNCj4gPiAgCWNhc2UgRFJNX0ZP
Uk1BVF9BUkdCODg4ODoNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMDoNCj4gPiAg
CWNhc2UgRFJNX0ZPUk1BVF9BUkdCMjEwMTAxMDoNCj4gPiAtCQlyZXR1cm4gT1ZMX0NPTl9DTFJG
TVRfQVJHQjg4ODg7DQo+ID4gKwkJcmV0dXJuIGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRf
Q09WRVJBR0UgPw0KPiA+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9BUkdCODg4OCA6DQo+ID4g
KwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4ODsNCj4gPiAgCWNhc2UgRFJNX0ZPUk1B
VF9YQkdSODg4ODoNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9BQkdSODg4ODoNCj4gPiAgCWNhc2Ug
RFJNX0ZPUk1BVF9YQkdSMjEwMTAxMDoNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9BQkdSMjEwMTAx
MDoNCj4gPiAtCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfQUJHUjg4ODg7DQo+ID4gKwkJcmV0dXJu
IGJsZW5kX21vZGUgPT0gRFJNX01PREVfQkxFTkRfQ09WRVJBR0UgPw0KPiA+ICsJCSAgICAgICBP
VkxfQ09OX0NMUkZNVF9BQkdSODg4OCA6DQo+ID4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BB
QkdSODg4ODsNCj4gPiAgCWNhc2UgRFJNX0ZPUk1BVF9VWVZZOg0KPiA+ICAJCXJldHVybiBPVkxf
Q09OX0NMUkZNVF9VWVZZIHwgT1ZMX0NPTl9NVFhfWVVWX1RPX1JHQjsNCj4gPiAgCWNhc2UgRFJN
X0ZPUk1BVF9ZVVlWOg0KPiA+IEBAIC00NTAsNyArNDc2LDcgQEAgdm9pZCBtdGtfb3ZsX2xheWVy
X2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAg
CQlyZXR1cm47DQo+ID4gIAl9DQo+ID4gIA0KPiA+IC0JY29uID0gb3ZsX2ZtdF9jb252ZXJ0KG92
bCwgZm10KTsNCj4gPiArCWNvbiA9IG92bF9mbXRfY29udmVydChvdmwsIGZtdCwgYmxlbmRfbW9k
ZSk7DQo+ID4gIAlpZiAoc3RhdGUtPmJhc2UuZmIpIHsNCj4gPiAgCQljb24gfD0gT1ZMX0NPTl9B
RU47DQo+ID4gIAkJY29uIHw9IHN0YXRlLT5iYXNlLmFscGhhICYgT1ZMX0NPTl9BTFBIQTsNCg==

