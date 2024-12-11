Return-Path: <linux-kernel+bounces-440722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E569EC34F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 04:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5F828343E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 03:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9020CCFA;
	Wed, 11 Dec 2024 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UAQUHsQt";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="h0Q53fvn"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC3F9E6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733887692; cv=fail; b=KujoZH9wWblfHhNCTBtLTngodLu8Tckis/c652v+VCah0S8PkjCb8qV0cj+1Xez0N6PJrEK/0zfF0ynCSQQscEWgBRTwYbmUNC+qKyXekjkV3rFwihT3qLwQbit6DFOCYuG4PGxIwIO9BosZ4tWyizz7OgfkMloMvCc55HEuBio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733887692; c=relaxed/simple;
	bh=jOICbz06MOb1nH0++sEG8whGXMWd/cl20XL4oP1odgQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pbPMfb9yh4CxDjkKcu3KM5kRy9HpLUS7+sAFP2Mb1SmvtmAi213sC/Vh1mMOq6+ewSPncSmX6joryF1F3bRZC06PZ/y5plPHk9xDOFziemShRFKUS1tEPe/icMigV7LB0lnxmCDApDQf0T5lWK5bPW8INSZgqcWGqKwRlRYzkmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UAQUHsQt; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=h0Q53fvn; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: eea6050cb76f11ef99858b75a2457dd9-20241211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jOICbz06MOb1nH0++sEG8whGXMWd/cl20XL4oP1odgQ=;
	b=UAQUHsQtkOdtQ+300BLtocABGgLNlSRoet3SP5Ep3gik6ksXfVC1LsfaVMQFcszvalUK+WAla7VTfs+TmW9aYZLMEx+SVw3M9nX2f9nG7SOuEGBHD43gMgkPJbSJtBKquPeobnyGsKO6tX3vfxg0NwbCrKcgh0sQ6FJr+eA7O8Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:233f5873-120d-4ff8-819c-40fe0381f548,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:20702dc1-1c82-4420-82d9-d6eb228f5c4a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT
X-CID-BAS: 1,FCT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: eea6050cb76f11ef99858b75a2457dd9-20241211
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 508432949; Wed, 11 Dec 2024 11:28:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 11 Dec 2024 11:28:02 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 11 Dec 2024 11:28:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UXo/PAh5mmiJjYZuN3ddmls0hM/8yL/nkVlht0k+KzqhZ4TCJ6vv20lK+tMAjWYRmKS7T8XAX4Pv8Qn3LclNpLfWQXQG7JmdkonBXJKTrJt6jxj+ZvP+WhRzHWbqSSC0fMKL/aVlCTGcDtnoZtA1Wz+ZZZnyle6ZYOxBAD1/DSFMKoLpli1ROq7qrRQROCmkgsgYzNgUd2XFwYTgQ9HCfFhZVgWC2DxB5s4B4eaMlw3O8NjcxKF3tKb/6yOe1rCL17NIocvy6uz6dDGfjdlRjAdbCoB3x+MMqYEE6XTOmumutqhnRI5XnTcthUJ0anN0k6SnxPys5iIE9bIWqKnQmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOICbz06MOb1nH0++sEG8whGXMWd/cl20XL4oP1odgQ=;
 b=eCTFtqiKRB7A3rYqORmATqOAtrlPcXfV4FGPgPGcUg99qZXqgVHm+JFJuxgWCFav1QLaIR7HtnzWUCXA/P1gKajzBv9V3+/dhl07uoeCqzsssKgZKR26sRnA8n6Aowz6hHlEXVKNR8Zndl3xofgsZdYo2Vb8BBOMbLjMcFe+XcE/IzXRU4Nr0O8OcKWPXuYSa1/3rZRFIv7XnEpvNRF6GnUFN+nxUAcLQgGhDGGvHE+Bm5UiVgaROzkkc7FS4KnfPCtZCbuUcMXdH7HtCikuDdZ04nwnv81/zOkFZZpCXlivp1okw0DnOGP+k15F2p+DBf7TiBSbBn/1Iqtj/nzH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOICbz06MOb1nH0++sEG8whGXMWd/cl20XL4oP1odgQ=;
 b=h0Q53fvn7g9JbXyCTthHpC+S3OOlJnfWXTqocY6L/DfL1jB+lFBTorPYtN2+V2GxgTI8LyKQqu84AqE+dR8riAyM5pXIlBleP2xX2q/eCexVi0XKHXrOgBVNdYVW1PyVK5p96V2zKFEs1CxYU12QQLoQqWgo7KXTry8Ug3VCC8E=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7130.apcprd03.prod.outlook.com (2603:1096:400:339::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 03:27:59 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 03:27:59 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Topic: [PATCH v3] drm/mediatek: Move mtk_crtc_finish_page_flip() to
 ddp_cmdq_cb()
Thread-Index: AQHbSrOSMX/h8FhNZ0G9HcKPB5KZzbLfCXIAgAFafwA=
Date: Wed, 11 Dec 2024 03:27:59 +0000
Message-ID: <c3935ca3e990f6f608326cef1dd495d5913c227d.camel@mediatek.com>
References: <20241210032820.10958-1-jason-jh.lin@mediatek.com>
	 <1e953fb5a4e4965ba509a1bb45e7c8336102ff29.camel@mediatek.com>
In-Reply-To: <1e953fb5a4e4965ba509a1bb45e7c8336102ff29.camel@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7130:EE_
x-ms-office365-filtering-correlation-id: 49964c61-e737-4b8e-686a-08dd1993cfa3
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dUZpMWdPUllaRDBVbnR5MzdUQjlRSFFxaDVuRmlUYVZHSXU4eEZnOFJDTEc5?=
 =?utf-8?B?WlY5Wml6S2hZTFZTVVdueHJQTGhuWnRvYkJzblRwem1neTg4TEtpMW4xcVlm?=
 =?utf-8?B?cFhZMEVWR2pxRVgzMHVxUkNlUi9GblhkU0hPUjV0M2N5M2VhR3YwY3EzVnk5?=
 =?utf-8?B?WURsdzJUVDdRa3pNMU1tUHQ0TFo1WGNjZmVZTUIxdWw0UjNnM1ZKUUxJSmdo?=
 =?utf-8?B?YkhUZzdxdDh6U0FkZWlJWHM3a3VkVWJIVStvVFpQUkdyTkFZeXNmU0FNdm40?=
 =?utf-8?B?Uzdqc2Q2NE5ndUJ0VW04ekhjWkhadHFQU3NWaHNQQ2JFNEt1ZkJPSFlYN0tn?=
 =?utf-8?B?R3hvR0tGZEwvRjFTazFkWWdicmNRMFRIT2VZVlZUSjlDUEJMaGkyc0dPWDJF?=
 =?utf-8?B?ZkkzMEZ3bjZSaTFZbVlieThwc2h4ZUpzVHM5QVN0TFROMysrTnNkSXQxN2Jk?=
 =?utf-8?B?WTMzNGF4WFIyVnE3U3U1U0FaSGpwMjdCbWRIUE1abEZBSE9FZngxMWYxeG9I?=
 =?utf-8?B?RVpyWVhkSmVONVY4S2hUcmlTOG8zVDFpMExuOXNJU0NRR21sVFJlRS9Vckgx?=
 =?utf-8?B?QURVSnhONlVhQ3crTWEwRGtSUnJZNTdPNk1ndWRWU1hZaG9IdnQ1ejZxSjdy?=
 =?utf-8?B?YU5Ea2ZRZUwyV3dIQTZWdGN5dHJOZXozUG5PUlJGa3dUVFhabjNWMldkdFRB?=
 =?utf-8?B?UnM4QUNvTXMvdjVSV0IyR3BYUmYwYVN6eTZoZmNNVlNIVktZMnZlUGVtaGJL?=
 =?utf-8?B?bmF5Q1I0aHRKbFF1NXlybWZ6L2JXaXJCYmxES0k5VEwxR1MzcmFaclJ3RHFt?=
 =?utf-8?B?d0UzMkxYMzEwUGtZQTdzQWhJUDJIRXJsL0M1ZngwSHNLT1VkVXJmaDBneStN?=
 =?utf-8?B?MklLY0FxcEFNMTNZNmdIS2xCTGxXdGd6R001MWlNN0RrcmU3Q2pUNE1mTjFp?=
 =?utf-8?B?TTZna2pFeXBXcEVXYllDQzZoaDBiZ2JDZzlWQ0RvSWpZbE1oblNTTUg4Q0pL?=
 =?utf-8?B?bXIwRVhNVGdlZXhxa3hDL2hUdVovc1l3SXVVcWUyZTdGZWN6bEE1SGZ3M1E2?=
 =?utf-8?B?S2Zuc1FXWGExeFFwaUhOZGpsOUN6ZUNpRHdlekZEbFdtUXVEZU4veTUvVzhw?=
 =?utf-8?B?M25FSm9YR1dtNUl6VG5xbWUvcGh0dDNYYVBEK3p3UUF5VFlqNDRZZmRDYmtV?=
 =?utf-8?B?TDFmbEFHRG96dkFwdDVEOHRuay9JTDR2SXpzUFQvZDB5eDFJb3NBRDBoUmg5?=
 =?utf-8?B?Z3RFN09oa2dhUlZUZDIxYzV2Qmh4dTBBWEpaZXptS0lhazJQaWhhM0x5bUJr?=
 =?utf-8?B?NUErZS9DaVRFYUNqbmNjY1lLSkZ4YU5uZndnRC9jOU9NMlRFbTNReXRLemxk?=
 =?utf-8?B?SlRxdWF1Q1IzWUtRcEorNmQ3OUVNRUFtNXhMU1M4MWJXb293dkNwSUliRE5L?=
 =?utf-8?B?WmVrOFFoc0FmWmJ0d2d6L2dEUG1SS3ozN3NkVDhxS2toMVQvcVVyT0VHZTM5?=
 =?utf-8?B?aG9HRnRZbU1PV2NlSVphZnY2ZGJlM21lTWcxY1lJOE1ac0Q5SnAxU1lEWlp2?=
 =?utf-8?B?Y0JXYjhzc0hpNlltRk5wNEU1dmhRWHFtcVc5QUV4OVQxL01NcnVRQ1FPaUg3?=
 =?utf-8?B?ZjJSa05XZWNLVTk0MGRMV1J6VSs3NTIwYmlNSVNXd093dkpqcU5QM1FZTTNQ?=
 =?utf-8?B?OURFT2ZUdEJHS0FVODl6STVST3pscUx3NjIyZkNEN1BkSU9IRlluOFk5TWZ2?=
 =?utf-8?B?UnYzSlRER05hdUpTVmp5TmlLZ3A0TTJwcmFEMzc5UVc1bWxnNk9vTUJRc3pP?=
 =?utf-8?B?YlBWb3A4S0lSTjFncTQyVklKUCtGbFVydVcvVFQ4bUU1bHA0bFpReXVRclV2?=
 =?utf-8?B?ZjNGdnpDaHdwMW5jc0VGWjFLNldacU05RUdXeVYrbVkrZHlZMGpudkIxbnFC?=
 =?utf-8?Q?xrg2B4jIBdWbwpm3SRgnWqDHXaxrZx4M?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXB6L0FMWEVraDdRQ2dzZ01BRDJmT3BjcmdiM3RkemsySlNzTDg5cE1TelNx?=
 =?utf-8?B?QlQyQzRyaTdnNDBCRFJFVmxVWnQvNFRzUmdvT2xFQzN4eS9tV3cvVzZNNjdt?=
 =?utf-8?B?RlJWVWJ3Y1BXcjNWaGIwaHBDTDM5VUh3aGlsRWpRakxJemNwVkNZaUVROVdG?=
 =?utf-8?B?Z2Q0SVMrOXlrYTUxbm94cm1tbzdmL2xPdTNxOFFKODlERkE5enJvY2U0Tjg5?=
 =?utf-8?B?L2NERjZIMExWTGpDMTFIcklWa3dhT2FhODVRM1p3U0hwU2NZTmFLNUNGcHpP?=
 =?utf-8?B?WUQ0anN6dS9wbW5OMDdEZ3pSNVlvd1U1QTlDRElCRHNOQmV2WlNQV3dheHlR?=
 =?utf-8?B?Z2E0cWpuZXp3cTZGMFNBYmhpemQ1ZDhaZTVEb3l2TVhQS0J2ODlYNERuek54?=
 =?utf-8?B?ZjRwejdBRFc2cFl2Z29NajFOVXB5RXhpa2d1WVh6YWt4T3NiOHdEN0MrbUYx?=
 =?utf-8?B?TjBLRkVFMVpHdmM1SkdVT1U4NVAxOUkrc21lT1VIemI3b2kzUVk1U2ZvM2Ro?=
 =?utf-8?B?eGFPeXFXSE1rTC9Da3crVDZ4ZW9kdjRobTJMVG9DdWdZOVZ0aytYOHVqQXdw?=
 =?utf-8?B?L3NsVmRra081S0M3T1U2YmZEb2ZNS0ZrUzQ2NW5heDFVM3JYRmh4alh3eHlk?=
 =?utf-8?B?TXN2Tk5VRGM2WlhsaHBzK25yM0FUWmkxYkVNMmp1QmYyNGJmQ1Jnc21IN3Jq?=
 =?utf-8?B?QWN4dEFuc2hNMkNrR1JOUkc3YnQvSGd1ZlFzWlFSZWxLNE5kbkNMVThtbEpk?=
 =?utf-8?B?VTg1SHV6S3hjdm5VaHRnemFhSjdiS3hWQkE5RWRMYTBZOVZMZkpLalgxQi9a?=
 =?utf-8?B?R1locHlzZ05rRFNSaCtJdHdpWnNWYmh2Z2FrMS81bEYvTjdiYll3ZU0xbjJa?=
 =?utf-8?B?eXh0dWNheUs1RXpzQ3FXMnl2SDRpaEVNa2Y1MVZ5NWp6RzN3WC9EU1h2MUsx?=
 =?utf-8?B?NVhjWit2NFBaZVJ1MTFISk42dDkyK0ZpSUJFY1NJV0g2U25TRTlTOVdGZXZu?=
 =?utf-8?B?UFhPQVMzV2VmQUw3aWNVQUZxdExyemZzMFMvU1NpZFJjQjQ3cnQvOFZKVHB3?=
 =?utf-8?B?Uk1qVzBTWTBRaG5hUUtCTkUzUXVkVFRiY3A4ME9MVUNPL0RVVHBqL0dhdlho?=
 =?utf-8?B?QmdyRThYNzRoM1I2amE5ejJ1Vkl6Nmt0N2lBa3EvOXJQOE05YzY3T3hlc0N2?=
 =?utf-8?B?ZU5NVnhqdlJsRU9YViszVWtOSWJScXlXaXJ6bDlnVThqVHY5aWdUZHcxb1RL?=
 =?utf-8?B?NFpnV3pIbWZkTDBJakhqa0w4TkJGUHJ3TXQzM1BLZDFyTU0zUHArVlJEMXBh?=
 =?utf-8?B?ZXRoTG56UllRZEJoU25ySlNNK1ZpMlNJYUFYVXFVZnVoVmFicHB3QWtvSFFU?=
 =?utf-8?B?NmREWTRON2JiNnFUdjRTRXJxbXM1MDZwZmJQa2xLaU5lbFFoVSt4SFlhQ0Iw?=
 =?utf-8?B?RmIrRHZ6U1k4NGJoelVnK21LZmxoL2Mzanh4NnVuazJzZzFKczQvTTVNYWE4?=
 =?utf-8?B?Nmo3WFRsdk1xTDJ1MmFxMXJoaFZmR2dIMFZWUStJQWZuWGVKUFJiemFOM1ZV?=
 =?utf-8?B?akVhRUhySjlVbkY0Y3BUbXA0ZnhmOXU2ZjVMMkEwUU0vY2F1WTg2MmxOUTEx?=
 =?utf-8?B?aFZIVUhTbWpYU1BhOWNyRU5FNWg3NHcrYlBFRTBMT1pPdnh4a25GWllyZmZP?=
 =?utf-8?B?NTYxQ1E2MS9lYlpUOTkzb3FhTW1IVlV0clNDbXVZSmZ0aVE3enV1am5tT0sz?=
 =?utf-8?B?cU8zbnVIb3VUeVU3ak4vY2U2TUhFc1VGanQ2dzZFYU4vK0tNVHRBRVkreEJB?=
 =?utf-8?B?cDJyUUtWcCs1bmpZVTNoREpRTDIxL085Ym1SYStOMHlMdk5pZDhwZGQzNGhS?=
 =?utf-8?B?d0JaZ0xvbkpjUDlBK01IOFVwNkZPNVY3QTV1UVhZU0pMWFhhODA0OTJMTjRW?=
 =?utf-8?B?YU1uNEo1UW9uVkFnRnF6Mk91MFU2S3JKZ3VTYXFhVkREcXE0WmFyOTJNTElo?=
 =?utf-8?B?K1BmRlF3T1FobGRHZTFLRVBGc0lkOGNtMkowZzlsSnYxQmZJWGErV1lZNmJn?=
 =?utf-8?B?bkUycm5XaHpkRHdpdmlIQnYreFhlZ3pwcFFsVWNLQUowTUF6Ri9oSjgvODh0?=
 =?utf-8?B?ZlJZTVdWYnZTaHR2R21xZ0xydzF0YzNpUzdRb2hWS2t3Zm9KbUppcm5xc3ZC?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE34B87E8488DF44A08D50B91C74DE61@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49964c61-e737-4b8e-686a-08dd1993cfa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 03:27:59.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7l6H2fnAIxZviH4ldwujB+RXcE+jmQRylzeHtNkn17XsOKtFneiuCH6k18HJNMVAvm28/j916FBFkmV7k2+foyoM4ojswukFuSHlgmE0eD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7130
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.263700-8.000000
X-TMASE-MatchedRID: VPleTT1nwdToSitJVour/V2036HHwFm/fjJOgArMOCYKogmGusPLb2Kw
	kjltjFojTfufaZ5cJRYWmbpoBwQPQqNu8YiLlIJQbc297PAGtWYZKp0SZ4P+ddvpj5+dNlQvrOr
	dUH2aAHcL+V4XdnE1+T2/Sdyn5NKFMhlqVy7dFP/J5W6OZe5hhf+UEb65dgmQW+jwVKpqvlIB1a
	3m44L+EuLzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7bkV4e2xSge4/Zm9dqy8cjIhT5
	5tWmgyUhFSA0OvxMFdaQeUtHsW5SDZFEgw6u+Np
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.263700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	684BABD3DCCD2DAE63EA80A3A2E873D66A04DB20F3068877403AD27456B33AA82000:8

SGkgQ0ssDQoNCltzbmlwXQ0KDQo+ID4gQEAgLTEwOSw5ICsxMDksMTQgQEAgc3RhdGljIHZvaWQg
bXRrX2NydGNfZmluaXNoX3BhZ2VfZmxpcChzdHJ1Y3QNCj4gPiBtdGtfY3J0YyAqbXRrX2NydGMp
DQo+ID4gIHN0YXRpYyB2b2lkIG10a19kcm1fZmluaXNoX3BhZ2VfZmxpcChzdHJ1Y3QgbXRrX2Ny
dGMgKm10a19jcnRjKQ0KPiA+ICB7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICsJ
c3RydWN0IGRybV9jcnRjICpjcnRjID0gJm10a19jcnRjLT5iYXNlOw0KPiA+ICsJc3RydWN0IG10
a19kcm1fcHJpdmF0ZSAqcHJpdiA9IGNydGMtPmRldi0+ZGV2X3ByaXZhdGU7DQo+ID4gIA0KPiA+
ICAJZHJtX2NydGNfaGFuZGxlX3ZibGFuaygmbXRrX2NydGMtPmJhc2UpOw0KPiA+ICANCj4gPiAr
CWlmICghcHJpdi0+ZGF0YS0+c2hhZG93X3JlZ2lzdGVyKQ0KPiA+ICsJCXJldHVybjsNCj4gPiAr
DQo+IA0KPiBJIGZvcmdldCBvbmUgY2FzZS4NCj4gRm9yIHRoZSBDUFUgY2FzZSAoU29DIGhhcyBu
byBzaGFkb3cgcmVnaXN0ZXIgYW5kIENPTkZJR19NVEtfQ01EUSBpcw0KPiBub3QgZW5hYmxlKSwN
Cj4gdGhpcyBkcml2ZXIgc2hvdWxkIHN0aWxsIHdvcmsuDQo+IENQVSBjYXNlIGlzIG5vdCBhIHVz
dWFsIGNhc2UsIGJ1dCBpdCBjb3VsZCBiZSB1c2VkIGluIHNvbWUNCj4gdmVyaWZpY2F0aW9uIGNh
c2UuDQo+IFNvIHRoZSBjb25kaXRpb24gbWF5IGJlDQo+IA0KPiAjaWYgSVNfUkVBQ0hBQkxFKENP
TkZJR19NVEtfQ01EUSkNCj4gCWlmIChtdGtfY3J0Yy0+Y21kcV9jbGllbnQuY2hhbikNCj4gCQly
ZXR1cm47DQo+ICNlbmRpZg0KPiANCg0KT0ssIEknbGwgY2hhbmdlIHRoZSBjb25kaXRpb24gbGlr
ZSB0aGlzLg0KDQo+ID4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmbXRrX2NydGMtPmNvbmZpZ19sb2Nr
LCBmbGFncyk7DQo+ID4gIAlpZiAoIW10a19jcnRjLT5jb25maWdfdXBkYXRpbmcgJiYgbXRrX2Ny
dGMtDQo+ID4gPnBlbmRpbmdfbmVlZHNfdmJsYW5rKSB7DQo+ID4gIAkJbXRrX2NydGNfZmluaXNo
X3BhZ2VfZmxpcChtdGtfY3J0Yyk7DQoNCltzbmlwXQ0KDQo+ID4gQEAgLTU4NCw2ICs1OTIsMTAg
QEAgc3RhdGljIHZvaWQgbXRrX2NydGNfdXBkYXRlX2NvbmZpZyhzdHJ1Y3QNCj4gPiBtdGtfY3J0
YyAqbXRrX2NydGMsIGJvb2wgbmVlZHNfdmJsYW5rKQ0KPiA+ICAJCW10a19tdXRleF9hY3F1aXJl
KG10a19jcnRjLT5tdXRleCk7DQo+ID4gIAkJbXRrX2NydGNfZGRwX2NvbmZpZyhjcnRjLCBOVUxM
KTsNCj4gPiAgCQltdGtfbXV0ZXhfcmVsZWFzZShtdGtfY3J0Yy0+bXV0ZXgpOw0KPiA+ICsNCj4g
PiArCQlzcGluX2xvY2tfaXJxc2F2ZSgmbXRrX2NydGMtPmNvbmZpZ19sb2NrLCBmbGFncyk7DQo+
ID4gKwkJbXRrX2NydGMtPmNvbmZpZ191cGRhdGluZyA9IGZhbHNlOw0KPiA+ICsJCXNwaW5fdW5s
b2NrX2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3MpOw0KPiA+ICAJfQ0K
PiA+ICAjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gPiAgCWlmIChtdGtfY3J0
Yy0+Y21kcV9jbGllbnQuY2hhbikgew0KPiA+IEBAIC02MDYsMTMgKzYxOCwxNCBAQCBzdGF0aWMg
dm9pZCBtdGtfY3J0Y191cGRhdGVfY29uZmlnKHN0cnVjdA0KPiA+IG10a19jcnRjICptdGtfY3J0
YywgYm9vbCBuZWVkc192YmxhbmspDQo+ID4gIAkJICovDQo+ID4gIAkJbXRrX2NydGMtPmNtZHFf
dmJsYW5rX2NudCA9IDM7DQo+ID4gIA0KPiA+ICsJCXNwaW5fbG9ja19pcnFzYXZlKCZtdGtfY3J0
Yy0+Y29uZmlnX2xvY2ssIGZsYWdzKTsNCj4gPiArCQltdGtfY3J0Yy0+Y29uZmlnX3VwZGF0aW5n
ID0gZmFsc2U7DQo+ID4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmbXRrX2NydGMtPmNvbmZp
Z19sb2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICAJCW1ib3hfc2VuZF9tZXNzYWdlKG10a19jcnRj
LT5jbWRxX2NsaWVudC5jaGFuLA0KPiA+IGNtZHFfaGFuZGxlKTsNCj4gPiAgCQltYm94X2NsaWVu
dF90eGRvbmUobXRrX2NydGMtPmNtZHFfY2xpZW50LmNoYW4sIDApOw0KPiA+ICAJfQ0KPiA+ICAj
ZW5kaWYNCj4gPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZtdGtfY3J0Yy0+Y29uZmlnX2xvY2ssIGZs
YWdzKTsNCj4gPiAtCW10a19jcnRjLT5jb25maWdfdXBkYXRpbmcgPSBmYWxzZTsNCj4gPiAtCXNw
aW5fdW5sb2NrX2lycXJlc3RvcmUoJm10a19jcnRjLT5jb25maWdfbG9jaywgZmxhZ3MpOw0KPiAN
Cj4gRm9yIHRoZSBDUFUgY2FzZSAoU29DIGhhcyBubyBzaGFkb3cgcmVnaXN0ZXIgYW5kIENPTkZJ
R19NVEtfQ01EUSBpcw0KPiBub3QgZW5hYmxlKSwNCj4gVGhpcyBjb2RlIGlzIG5lY2Vzc2FyeS4N
Cj4gTWF5YmUga2VlcCB0aGVzZSBjb2RlIG9yIHNvbWUgbW9kaWZpY2F0aW9uIGZvciBDUFUgY2Fz
ZS4NCj4gDQoNCk9LLCBJJ2xsIGtlZXAgdGhlIG9yaWdpbmFsIGZsb3cgYW5kIG9ubHkgbW9kaWZ5
IGZvcg0KSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkgY2FzZS4NCg0KUmVnYXJkcywNCkph
c29uLUpILmxpbg0KDQo+IFJlZ2FyZHMsDQo+IENLDQo=

