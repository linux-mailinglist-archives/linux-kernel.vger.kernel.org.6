Return-Path: <linux-kernel+bounces-379072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC779AD945
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF462818CE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 01:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E4137930;
	Thu, 24 Oct 2024 01:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="eoU4LIyl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FX823VER"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBE139578;
	Thu, 24 Oct 2024 01:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733374; cv=fail; b=HOoN6Yjliwue8tmdkXIsa840tCoLNS1M8EuVqmlh7aHuNoM9o0ZFhQnKnVl8PK3GP+AJWKr8Llrux7VTPcepYSA5b/R8MGZxT9ni33Cpexnhg4spCNxQfFtJERDHv34gpqcjjqRxfgCqTDma0iOQIP2lgQGfvuOve5fjdNdbHSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733374; c=relaxed/simple;
	bh=gBfX2uU0GnVRhSmmoKNpjat7ktEfZYh3kOlHh5kbmd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=II2Ua35bLW2FqhnWJusd7oqJ9XB+10cqjjhTGQTkB2TcjuCx1fMflNtJTAno+2nej2HGzmxreK0cd0yMY3sCZC1vC2lgODycVZL2p8ptaV3HDwGgWbZ60Cj+ftCbJ7nv9v0r0GVnEiZfWF9unqDA7CCA6QZGjdNULq3KVxRC0Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=eoU4LIyl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=FX823VER; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 67b8269e91a711efbd192953cf12861f-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gBfX2uU0GnVRhSmmoKNpjat7ktEfZYh3kOlHh5kbmd4=;
	b=eoU4LIyld9KTGMG6mNV2PS5N8knnXoldJHG8GJ0X2xk1+It38kZxMI262YVR9KFHsuteUtOVW8BBRQI5a2c7Y/potC2W8v9ei8BiD696bl3J5rvLFABI801s81H6hQk8mRk8D88bg8EatBLNxQp9ORrxnq7G1Va4ZZD5dQdbgXY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:f7383f23-68cf-448e-a63a-369125744bf4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d5adc4cc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 67b8269e91a711efbd192953cf12861f-20241024
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 864785187; Thu, 24 Oct 2024 09:29:25 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 23 Oct 2024 18:29:24 -0700
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 09:29:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TnnhAGm8HyRo7J3sg+EryTNOtaBfUx3+RI3q+SYIAbHKpSM/o9wksrsRsjq81NSZXtmafZwIiwxcDAJeOHn4gjKfhCXBclco+4p22Zhm9zU22/EYC1RfzXK+2azvnp/p58YCCTSVUKVsEvg1pEax5zKm2WTx2P6r0Nr7TWMe/0sT2x0AGPGLlRlgngz/gO4m1SFsoQ7IciIebbvBgdUAHFA63/W0OCU204TKRM8W3a9QEHMGIADVZK64j33Vzu7uliia5hdmAY9gOfwQNpcBhZbW0fMjrjFJK+J7LHkHlmgM/FtHKhsyl9Xz1oYMwyREHNYgKBfp8vtYTpJEuIozZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBfX2uU0GnVRhSmmoKNpjat7ktEfZYh3kOlHh5kbmd4=;
 b=hzJoQvJ5ww4haK6O0c42iE9Eu58ewNfn+yMgjgDDQf4fNVmL3qYI3yUCHnjomMO96OkkLErXiWB4YM3vYsTtabNJMkOkL5HW6HudTu8Pg4MNqpc6Adv62LaPLAXDGYc/J2K90Sbfa8m508CpZno1IPvzhQ4mec1nd0sgpNSpzMZUxlBmAhHMDmQXHFh3iI4c8TjuQsZUqzngZycOQLyZZ364sbB/cybfcCEyiImYWiu0Eyek3ewwhlz8s1DiI+BWL01HED606u4yr2Jaz+VOQDZ/bm1spqTmnflzKvbYAxHs5bdqTLuDc7kncC6E2GBeflZJB4mD2+HKxyub5Vc5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBfX2uU0GnVRhSmmoKNpjat7ktEfZYh3kOlHh5kbmd4=;
 b=FX823VER/ELVOG6IAa/lfgfUIk5KtISwcnD1/gD8SRor8jcI7PI7YqkoX/k9jkZ4LF/UT/UIkhWVQb5VZScHFUN35CntwLeKF5C7Fmy3ZG36tdorc6VUErcGT8GpDubNlAcH+HOCxpx0oXuk3PfPS04VR0adBDT/vJdg8FnjEok=
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com (2603:1096:990:3d::5)
 by JH0PR03MB7655.apcprd03.prod.outlook.com (2603:1096:990:d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Thu, 24 Oct
 2024 01:29:22 +0000
Received: from JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f]) by JH0PR03MB7983.apcprd03.prod.outlook.com
 ([fe80::68cc:b424:7a97:b11f%3]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 01:29:22 +0000
From: =?utf-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] reset: mediatek: Add reset control driver for SMI
Thread-Topic: [PATCH 4/4] reset: mediatek: Add reset control driver for SMI
Thread-Index: AQHa86RTub+VHV22FUC5mgoUVvVF7rIxaTmAgGQX3oA=
Date: Thu, 24 Oct 2024 01:29:22 +0000
Message-ID: <2ef870eb2f654667723f7f2d38e7532a7d3cfc84.camel@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
	 <20240821082845.11792-5-friday.yang@mediatek.com>
	 <ce9a7ea1-67bc-42b8-836d-11932dcf3790@kernel.org>
In-Reply-To: <ce9a7ea1-67bc-42b8-836d-11932dcf3790@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7983:EE_|JH0PR03MB7655:EE_
x-ms-office365-filtering-correlation-id: 1e38e9c8-7576-4ea1-c7bc-08dcf3cb4a19
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?REtLQWpJWGxyclQ2bHhTWFJsanNxc2lNUVVjS0RTdmVhTXg1Wmh4ZjhITjRr?=
 =?utf-8?B?OWlCd09kL09EcUZONmlsZzJWUFBPWTkzWjBaR3B3S3R6cnlMRkJsV2s4NU5O?=
 =?utf-8?B?S2tSNHFVb1J1QW1hd0lLcmZDcGRONVEwa3hOczhSRzl6cXRuWjcxSXZNcHEw?=
 =?utf-8?B?NDlFOEQxZ3RYQ0dnWWEyTnlZUUJtcDdWOHpEcUtncCtmS0N0YW8yclpHOXo4?=
 =?utf-8?B?aFZIaklNOFNSY2hmS2x5Q0Yxd3JzS0xOeGxwSlpwdW9HbklySGpqRmtKM3B6?=
 =?utf-8?B?NlpUSkdicmdtdzBkdzloU1JUcWg0QWhPb1dEL1hvdDIxbXA4c0NhZk96OUNM?=
 =?utf-8?B?ajdRem14MlZBMGR3MVREaHhzVk1VL29rci96RWxIbUxETlhZVDhtdEhkRlBy?=
 =?utf-8?B?TkxZQmZ0TmhZaEhWaWJodlUyTEVoMHRYd2lON1l1NGx1bWlmZ2d6ZGtHZzJK?=
 =?utf-8?B?RzdrcGwwVUVhSHV2Z1BWYXVJOWxMb1NXYnRhd2VZcWtTVTE0UTdpVjRwYVZr?=
 =?utf-8?B?MDdyQmRza3NscTF6SFMraCtvZUtwemU4UUJYNDJCVUVSSTZ0NnlDc3VpRnh5?=
 =?utf-8?B?VjhjRE45ZGdDOG84TmNyYkdIS29PaUtRTFpWdFJRVlhyK2hvcHZjVFlLam5W?=
 =?utf-8?B?ZnNlY3hsV1FVaEVkZjdJa2E3WEVMOFAya2dVUjNaRVh4bEZmcEVxaHFEakls?=
 =?utf-8?B?UUk2Tlc2bmUyTGNvQXRzZEt1RzZHTVR1UG1rQ0g4RmJ5T2EzTVJ5bUtLL1R2?=
 =?utf-8?B?NlVua2tESTZHQ1pxUzR1Ky9zUTk0NXdjWUxJcS92YjQ2OHArZDJQdlRrTzYx?=
 =?utf-8?B?bGhtbkNlUFIvbmxtUEc3bjBSWG1UWm1sbEJqeFlzWWxPZjNPRllaRGVvOFRH?=
 =?utf-8?B?dklpeFA5WkttVUdsZCsrN1pxSEpMMENCRStkYnFzYjZBZlZUTFFERVY2S2ZE?=
 =?utf-8?B?ek83Q3lZWG93Vm1jTk54T204Uld0QXVTL2xYb1V0bzkzQnN3Qm5Qa3o3ZXF4?=
 =?utf-8?B?a2VOMG9NQm9yNlhJOGhMWVNKL0owNnF0TTlIbHpCMC9TVUxiWEMrRjVzQXRX?=
 =?utf-8?B?NnhiUUs5M0JSaU5CamZWTGJGNkFUSlp2L2N6Rm5kRWdkaEUreFgyaTJ0NGtN?=
 =?utf-8?B?Ulp2TSt2YmM3eVJ1ZGNhMy93RERyYXN1UnJwUExjazd1UURGMFkzM1pMb2V6?=
 =?utf-8?B?RWpvdGxLUkVXZTIxZUZLLzFZaFhZTmpDQ0c2Vm9aU3pKRHAreHpWSmdDemVa?=
 =?utf-8?B?VW5hbGczTFFhQzN2b3Nka0MxakFBRGF6a015bkxTWDJVUWp3dEhndkUvZDRL?=
 =?utf-8?B?SWJWMEsraHdKOW1VcS9QL2QzUU0ybFg3cy9neGlsSmdieUE5ZnhJR1JkaCta?=
 =?utf-8?B?SmNTazNRWi9lbTZjM01nS3Y0Um1iRUlESnpBUFhzb0lpTWZoUGtQV09DUVM1?=
 =?utf-8?B?N0VXRjJUTW03dCtWQ2JmYThoSWJ2bm1jR2pwdFdYOWJoUEdNbzJCaDE0UGxS?=
 =?utf-8?B?UTVNT2QvWUpGWWRPT1dob1FRM0ZmMGFyUUZUcGc5SzV1Qnk0elJkMDhYTnBn?=
 =?utf-8?B?V3pJWUtjazNoWFRyeDR4M1JpeTBhSVR1NWdCV3RnaG9yR2d1czZ5TU16ckY2?=
 =?utf-8?B?ekNzNkpGNVZCUEFpL2JPR2F5OEgzendRc21KbUd1Y0kzc0l4bXJTdTRXVWRr?=
 =?utf-8?B?NjBNY2hnWlJHbitrcklPRlE0VS9KWGw2NUtBRXIyWWdtNk5oZFJML0xqcTJq?=
 =?utf-8?B?N2tVZ3AyMGtsTzdMcGF3MWVoeVgvWU1INXdLVVJJUWFJSE9WT0p6WGZWb0l4?=
 =?utf-8?Q?8amBARQjk6Jjtfh/mucS2dnk/qedZjXxPGjp0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7983.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djR2UkErcHNQZUZMSzRVbDdkZmkvRC9KM3dybDQwUXVvd2dENFk0eXhqSlk4?=
 =?utf-8?B?amdrRzM5UDZTR2IrYjZCcmlNem9yRnF2ampkQXl4V2xLQmozSXNaZUc4cS9I?=
 =?utf-8?B?eGFUbEFRb05GYmJNSTRjNEFwUXpreDFBS0JjTXU4UGtzS3FBMTlFUUFMemdO?=
 =?utf-8?B?c081RFJZeVRYMFA5YnZMaTdpU2hlWmdzV0JTV3E2aFAyQTk2UEpIVGtpWDZN?=
 =?utf-8?B?TEhTcUZSNGxFZXo4NmFtaXpZWXZFRWlOTmQ0U0pzeUF4TXllMUtTSXdzYkJj?=
 =?utf-8?B?L3ljb1ZxQkEwMDJ5a291T0RLazBCVkVhTTEzREtSekpMWUVST21Wdi92MHps?=
 =?utf-8?B?NnBya1Y5MVZFRk5UZHcrMFNtdWxKYUhFenJORWh2VGQrR2JzeVhickdQZllN?=
 =?utf-8?B?RHZjU2JBN2ZINnhtZVN3OGJDQlZscm9kck5CU0VGTlp3amljZ0J4ajhEN3h5?=
 =?utf-8?B?UHJJM1FGdFg1OGQyNGFuSE50Um8rcnk0RWNxU1hEcHZMbU9xUE81TXBHQ1A5?=
 =?utf-8?B?V2FOYzQzYUZFNjNqZWs5QXV2QzJXSkJicGdYZ2k1L0xQWUJaZ0xWM2FRWWcx?=
 =?utf-8?B?eEsyZlhabGd4ZjQwbS9OWThSU09nTlJ4d0ZzTHA0ZDIxd0t4Y0hFNFRYY0Jm?=
 =?utf-8?B?UkZQL3VPUGlkWVE3S2tJNC9ocG5mSEVWQ3RZdmM2VEV4MkNaMm1MSlYrVHpG?=
 =?utf-8?B?WjFkakRNVGJEbFFubTlBajh6OXBOa3JveW0zcDZJVmkrZFpmSWthaWx5Rzc0?=
 =?utf-8?B?Q3JiY29KQ2FkYlpKVEhVamo4NlB1Vjl5M1Z2Mm1ycERTRWJqTjZWY09mMGNO?=
 =?utf-8?B?azA5cGsrQ0pGMS9hTjFYL2VLYTV3Nk5MWWp3L2F2M1NqWnpwYzZVWmFtcnoz?=
 =?utf-8?B?NUtidFB0dmZ2b3k4b2NaZHhGRTRORVBqYnBINGwrSGdUVlVUeTA3aG9LcEx1?=
 =?utf-8?B?WEpQYi9VQ3ZLVHVTNlFyZkpLZVgzMGxwTFN3K3FldE9kRzl6SVNtS1VXYTdT?=
 =?utf-8?B?b21HUGlaK0lKRkI2MkhCU1RMbG9jSHN1dHRiUGlDVnhLbGxkUjJLcFVsa3hC?=
 =?utf-8?B?UWloM1ZVcDRBa284TExKbG9WbXo1cmNIejlhdTQ3QStRL2NlYUZvNVNsVXF1?=
 =?utf-8?B?Y2VTKy9TUkUzRGwrNWhUZ3VLckpmK1ZWZ0xKSTdWVURkN3RJU2pJSFdMaHZI?=
 =?utf-8?B?clc1U0dpaTd6QkkwN3owek5UL3pEVWMxZ3RWUldCblk3Uk9CdVVrejd5VW92?=
 =?utf-8?B?RXNCNWtzWnNmdlpoVXJBVFcxRGF4dldGTlBNQTgxTDZwZm9wOWVEWGpIK2R1?=
 =?utf-8?B?V0VJWDJaMkZVWHBoZVNPQzk2YjBFSDJmanhZMExicHdZbWlZd2xOWFIzMzZ6?=
 =?utf-8?B?YU4zNW1scXk4WHlvRHlLWlhuNTBGdzV4YWNsaTFyRmRCSjVHMWljajd5NGZG?=
 =?utf-8?B?YVF2amtuTmFXSTk5akhCMDV0THE5ckw3eUN6S045NFduZ1UxbUxweVl6Q1dF?=
 =?utf-8?B?YTNCWVdJd014VmUyN0xrcSt6a0lCV0p6M2FPNVdpeHdibUZaWHl0VktiYVI4?=
 =?utf-8?B?R1luNXFYdGF2cnE3UHRIb2xYdFBNRGl1THJEK3lGYXdMY0NubmJKYVZydU5C?=
 =?utf-8?B?a0VCamlTYTFWcFJveXovNTUyTkZ5UW1YSlByd21ORFg4WjRpTXM5Lzlka25I?=
 =?utf-8?B?NW5pT0MxUkU0RnNlZksrTzlKLzBVd2wzeUthSjF3UDdDbmk1RllLa2liZ0xn?=
 =?utf-8?B?M1VqWk0zdXRsNHlhdjlwcjRwcW5YVVJxV0lCTW45dTI5SWwxa3hzdlJOU0hT?=
 =?utf-8?B?WmxwUUh1cDRZdldwMXN5Z044R3NWUTlxQjJ4eWFpTXRDL0syMlZuakZxbzF5?=
 =?utf-8?B?ZlFDV0Y0cGRBVWNLYTZTTld1MzQxVDJna1Y0OFRpZENYamlHMzlMbjJwNTN5?=
 =?utf-8?B?TjhlWmpxbElldE01K2ExMTd2aXZYNmozTjJTM0pSYkZ0cVpmajZEem1JRVM2?=
 =?utf-8?B?Ym1FLzluS1dRZWI0dXRjckNZQ09nOEN1WlN3S29vWGgxSjJtYUdqOE1qa2xZ?=
 =?utf-8?B?Tk51Rml4MDczZ1lHNWRkNU5xcVIwM0NsZnZObWtTVW04RnZzSTZjd3laRk0w?=
 =?utf-8?B?NDBsc2VZMVpFc3FMcTEzU1VTc1NtZmZ4TFZOak9KZ05GeHdraUQ4K1VhMlBI?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B583971967D32448D10A2DCAE147E72@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7983.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e38e9c8-7576-4ea1-c7bc-08dcf3cb4a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 01:29:22.6343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LeDA1os8GOt0qEPf1Nxpc6WkpcP53dHfQ/jJ64MEEKT5ixVpeuoYlLZfccow9gPw9RoUU11x2kAhvozfHztWLxE4AFwjvxedqRt0PNf1dg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7655

T24gV2VkLCAyMDI0LTA4LTIxIGF0IDEwOjU4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDIxLzA4LzIwMjQgMTA6MjYsIGZyaWRheS55YW5nIHdy
b3RlOg0KPiA+IEFkZCBhIHJlc2V0LWNvbnRyb2xsZXIgZHJpdmVyIGZvciBwZXJmb3JtaW5nIHJl
c2V0IG1hbmFnZW1lbnQgb2YNCj4gPiBTTUkgTEFSQnMgb24gTWVkaWFUZWsgcGxhdGZvcm0uIFRo
aXMgZHJpdmVyIHVzZXMgdGhlIHJlZ21hcA0KPiA+IGZyYW1ld29ya3MgdG8gYWN0dWFsbHkgaW1w
bGVtZW50IHRoZSB2YXJpb3VzIHJlc2V0IGZ1bmN0aW9ucw0KPiA+IG5lZWRlZCB3aGVuIFNNSSBM
QVJCcyBhcHBseSBjbGFtcCBvcGVyYXRpb25zLg0KPiANCj4gSG93IGRvZXMgdGhpcyBkZXBlbmQg
b24gbWVtb3J5IGNvbnRyb2xsZXIgcGF0Y2hlcz8gV2h5IGlzIHRoaXMNCj4gZ3JvdXBlZA0KPiBp
biBvbmUgcGF0Y2hzZXQ/DQo+IA0KDQpIb3cgYWJvdXQgY2hhbmdpbmcgaXQgbGlrZSB0aGlzLA0K
cGF0Y2hzZXQxOg0KKDEpU01JIHJlc2V0IGNvbnRyb2wgZHJpdmVyDQooMilTTUkgcmVzZXQgYmlu
ZGluZ3MNCnBhdGNoc2V0Mg0KKDEpU01JIGRyaXZlcg0KKDIpU01JIGJpbmRpbmdzDQoNCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBmcmlkYXkueWFuZyA8ZnJpZGF5LnlhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Jlc2V0L0tjb25maWcgICAgICAgICAgICAgIHwgICA5
ICsrDQo+ID4gIGRyaXZlcnMvcmVzZXQvTWFrZWZpbGUgICAgICAgICAgICAgfCAgIDEgKw0KPiA+
ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LW1lZGlhdGVrLXNtaS5jIHwgMTUyDQo+ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTYyIGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcmVzZXQvcmVzZXQtbWVkaWF0ZWst
c21pLmMNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9yZXNldC9LY29uZmlnIGIvZHJp
dmVycy9yZXNldC9LY29uZmlnDQo+ID4gaW5kZXggNjdiY2UzNDBhODdlLi5lOTg0YTVhMzMyZjEg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9LY29uZmlnDQo+ID4gKysrIGIvZHJpdmVy
cy9yZXNldC9LY29uZmlnDQo+ID4gQEAgLTE1NCw2ICsxNTQsMTUgQEAgY29uZmlnIFJFU0VUX01F
U09OX0FVRElPX0FSQg0KPiA+ICAgIFRoaXMgZW5hYmxlcyB0aGUgcmVzZXQgZHJpdmVyIGZvciBB
dWRpbyBNZW1vcnkgQXJiaXRlciBvZg0KPiA+ICAgIEFtbG9naWMncyBBMTEzIGJhc2VkIFNvQ3MN
Cj4gPiAgDQo+ID4gK2NvbmZpZyBSRVNFVF9NVEtfU01JDQo+ID4gK2Jvb2wgIk1lZGlhVGVrIFNN
SSBSZXNldCBEcml2ZXIiDQo+ID4gK2RlcGVuZHMgb24gTVRLX1NNSQ0KPiANCj4gY29tcGlsZSB0
ZXN0DQoNClRoYW5rcywgSSB3aWxsIGZpeCBpdCB0byAnZGVwZW5kcyBvbiBNVEtfU01JIHx8IENP
TVBJTEVfVEVTVCcNCg0KPiANCj4gPiAraGVscA0KPiA+ICsgIFRoaXMgb3B0aW9uIGVuYWJsZXMg
dGhlIHJlc2V0IGNvbnRyb2xsZXIgZHJpdmVyIGZvciBNZWRpYVRlaw0KPiBTTUkuDQo+ID4gKyAg
VGhpcyByZXNldCBkcml2ZXIgaXMgcmVzcG9uc2libGUgZm9yIG1hbmFnaW5nIHRoZSByZXNldCBz
aWduYWxzDQo+ID4gKyAgZm9yIFNNSSBsYXJicy4gU2F5IFkgaWYgeW91IHdhbnQgdG8gY29udHJv
bCByZXNldCBzaWduYWxzIGZvcg0KPiA+ICsgIE1lZGlhVGVrIFNNSSBsYXJicy4gT3RoZXJ3aXNl
LCBzYXkgTi4NCj4gPiArDQo+ID4gIGNvbmZpZyBSRVNFVF9OUENNDQo+ID4gIGJvb2wgIk5QQ00g
Qk1DIFJlc2V0IERyaXZlciIgaWYgQ09NUElMRV9URVNUDQo+ID4gIGRlZmF1bHQgQVJDSF9OUENN
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvTWFrZWZpbGUgYi9kcml2ZXJzL3Jlc2V0
L01ha2VmaWxlDQo+ID4gaW5kZXggMjdiMGJiZGZjYzA0Li4yNDE3Nzc0ODViNDAgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9yZXNldC9NYWtlZmlsZQ0KPiA+ICsrKyBiL2RyaXZlcnMvcmVzZXQv
TWFrZWZpbGUNCj4gPiBAQCAtMjIsNiArMjIsNyBAQCBvYmotJChDT05GSUdfUkVTRVRfTFBDMThY
WCkgKz0gcmVzZXQtbHBjMTh4eC5vDQo+ID4gIG9iai0kKENPTkZJR19SRVNFVF9NQ0hQX1NQQVJY
NSkgKz0gcmVzZXQtbWljcm9jaGlwLXNwYXJ4NS5vDQo+ID4gIG9iai0kKENPTkZJR19SRVNFVF9N
RVNPTikgKz0gcmVzZXQtbWVzb24ubw0KPiA+ICBvYmotJChDT05GSUdfUkVTRVRfTUVTT05fQVVE
SU9fQVJCKSArPSByZXNldC1tZXNvbi1hdWRpby1hcmIubw0KPiA+ICtvYmotJChDT05GSUdfUkVT
RVRfTVRLX1NNSSkgKz0gcmVzZXQtbWVkaWF0ZWstc21pLm8NCj4gPiAgb2JqLSQoQ09ORklHX1JF
U0VUX05QQ00pICs9IHJlc2V0LW5wY20ubw0KPiA+ICBvYmotJChDT05GSUdfUkVTRVRfTlVWT1RP
Tl9NQTM1RDEpICs9IHJlc2V0LW1hMzVkMS5vDQo+ID4gIG9iai0kKENPTkZJR19SRVNFVF9QSVNU
QUNISU8pICs9IHJlc2V0LXBpc3RhY2hpby5vDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVz
ZXQvcmVzZXQtbWVkaWF0ZWstc21pLmMNCj4gYi9kcml2ZXJzL3Jlc2V0L3Jlc2V0LW1lZGlhdGVr
LXNtaS5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LmVhZDc0N2U4MGFkNQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3Jlc2V0
L3Jlc2V0LW1lZGlhdGVrLXNtaS5jDQo+ID4gQEAgLTAsMCArMSwxNTIgQEANCj4gPiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogUmVzZXQgZHJp
dmVyIGZvciBNZWRpYVRlayBTTUkgbW9kdWxlDQo+ID4gKyAqDQo+ID4gKyAqIENvcHlyaWdodCAo
QykgMjAyNCBNZWRpYVRlayBJbmMuDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxp
bnV4L21mZC9zeXNjb24uaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2Rldmlj
ZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51
eC9yZXNldC1jb250cm9sbGVyLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
cmVzZXQvbXQ4MTg4LXJlc2V0cy5oPg0KPiA+ICsNCj4gPiArI2RlZmluZSB0b19tdGtfc21pX3Jl
c2V0X2RhdGEoX3JjZGV2KVwNCj4gPiArY29udGFpbmVyX29mKF9yY2Rldiwgc3RydWN0IG10a19z
bWlfcmVzZXRfZGF0YSwgcmNkZXYpDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbXRrX3NtaV9sYXJiX3Jl
c2V0IHsNCj4gPiArdW5zaWduZWQgaW50IG9mZnNldDsNCj4gPiArdW5zaWduZWQgaW50IHZhbHVl
Ow0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJf
cmVzZXQgcnN0X3NpZ25hbF9tdDgxODhbXSA9IHsNCj4gPiArW01UODE4OF9TTUlfUlNUX0xBUkIx
MF09IHsgMHhDLCBCSVQoMCkgfSwgLyogbGFyYjEwICovDQo+ID4gK1tNVDgxODhfU01JX1JTVF9M
QVJCMTFBXT0geyAweEMsIEJJVCgwKSB9LCAvKiBsYXJiMTFhICovDQo+ID4gK1tNVDgxODhfU01J
X1JTVF9MQVJCMTFDXT0geyAweEMsIEJJVCgwKSB9LCAvKiBsYXJiMTFjICovDQo+ID4gK1tNVDgx
ODhfU01JX1JTVF9MQVJCMTJdPSB7IDB4QywgQklUKDgpIH0sIC8qIGxhcmIxMiAqLw0KPiA+ICtb
TVQ4MTg4X1NNSV9SU1RfTEFSQjExQl09IHsgMHhDLCBCSVQoMCkgfSwgLyogbGFyYjExYiAqLw0K
PiA+ICtbTVQ4MTg4X1NNSV9SU1RfTEFSQjE1XT0geyAweEMsIEJJVCgwKSB9LCAvKiBsYXJiMTUg
Ki8NCj4gPiArW01UODE4OF9TTUlfUlNUX0xBUkIxNkJdPSB7IDB4QTAsIEJJVCg0KSB9LCAvKiBs
YXJiMTZiICovDQo+ID4gK1tNVDgxODhfU01JX1JTVF9MQVJCMTdCXT0geyAweEEwLCBCSVQoNCkg
fSwgLyogbGFyYjE3YiAqLw0KPiA+ICtbTVQ4MTg4X1NNSV9SU1RfTEFSQjE2QV09IHsgMHhBMCwg
QklUKDQpIH0sIC8qIGxhcmIxNmEgKi8NCj4gPiArW01UODE4OF9TTUlfUlNUX0xBUkIxN0FdPSB7
IDB4QTAsIEJJVCg0KSB9LCAvKiBsYXJiMTdhICovDQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdHJ1
Y3QgbXRrX3NtaV9sYXJiX3BsYXQgew0KPiA+ICtjb25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX3Jl
c2V0KnJlc2V0X3NpZ25hbDsNCj4gPiArY29uc3QgdW5zaWduZWQgaW50bGFyYl9yZXNldF9ucjsN
Cj4gPiArfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBtdGtfc21pX3Jlc2V0X2RhdGEgew0KPiA+ICtj
b25zdCBzdHJ1Y3QgbXRrX3NtaV9sYXJiX3BsYXQgKmxhcmJfcGxhdDsNCj4gPiArc3RydWN0IHJl
c2V0X2NvbnRyb2xsZXJfZGV2IHJjZGV2Ow0KPiA+ICtzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+
ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19zbWlfbGFyYl9wbGF0
IG10a19zbWlfbGFyYl9tdDgxODggPSB7DQo+ID4gKy5yZXNldF9zaWduYWwgPSByc3Rfc2lnbmFs
X210ODE4OCwNCj4gPiArLmxhcmJfcmVzZXRfbnIgPSBBUlJBWV9TSVpFKHJzdF9zaWduYWxfbXQ4
MTg4KSwNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3NtaV9sYXJiX3Jlc2V0
KHN0cnVjdCByZXNldF9jb250cm9sbGVyX2RldiAqcmNkZXYsDQo+IHVuc2lnbmVkIGxvbmcgaWQp
DQo+ID4gK3sNCj4gPiArc3RydWN0IG10a19zbWlfcmVzZXRfZGF0YSAqZGF0YSA9IHRvX210a19z
bWlfcmVzZXRfZGF0YShyY2Rldik7DQo+ID4gK2NvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfcGxh
dCAqbGFyYl9wbGF0ID0gZGF0YS0+bGFyYl9wbGF0Ow0KPiA+ICtjb25zdCBzdHJ1Y3QgbXRrX3Nt
aV9sYXJiX3Jlc2V0ICpsYXJiX3JzdCA9IGxhcmJfcGxhdC0NCj4gPnJlc2V0X3NpZ25hbCArIGlk
Ow0KPiA+ICtpbnQgcmV0Ow0KPiA+ICsNCj4gPiArcmV0ID0gcmVnbWFwX3NldF9iaXRzKGRhdGEt
PnJlZ21hcCwgbGFyYl9yc3QtPm9mZnNldCwgbGFyYl9yc3QtDQo+ID52YWx1ZSk7DQo+ID4gK2lm
IChyZXQpDQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK3JldCA9IHJlZ21hcF9jbGVhcl9iaXRzKGRh
dGEtPnJlZ21hcCwgbGFyYl9yc3QtPm9mZnNldCwgbGFyYl9yc3QtDQo+ID52YWx1ZSk7DQo+ID4g
Kw0KPiA+ICtyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19z
bWlfbGFyYl9yZXNldF9hc3NlcnQoc3RydWN0IHJlc2V0X2NvbnRyb2xsZXJfZGV2DQo+ICpyY2Rl
diwgdW5zaWduZWQgbG9uZyBpZCkNCj4gPiArew0KPiA+ICtzdHJ1Y3QgbXRrX3NtaV9yZXNldF9k
YXRhICpkYXRhID0gdG9fbXRrX3NtaV9yZXNldF9kYXRhKHJjZGV2KTsNCj4gPiArY29uc3Qgc3Ry
dWN0IG10a19zbWlfbGFyYl9wbGF0ICpsYXJiX3BsYXQgPSBkYXRhLT5sYXJiX3BsYXQ7DQo+ID4g
K2NvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfcmVzZXQgKmxhcmJfcnN0ID0gbGFyYl9wbGF0LQ0K
PiA+cmVzZXRfc2lnbmFsICsgaWQ7DQo+ID4gK2ludCByZXQ7DQo+ID4gKw0KPiA+ICtyZXQgPSBy
ZWdtYXBfc2V0X2JpdHMoZGF0YS0+cmVnbWFwLCBsYXJiX3JzdC0+b2Zmc2V0LCBsYXJiX3JzdC0N
Cj4gPnZhbHVlKTsNCj4gPiAraWYgKHJldCkNCj4gPiArZGV2X2VycihyY2Rldi0+ZGV2LCAiWyVz
XSBGYWlsZWQgdG8gc2h1dGRvd24gbGFyYiAlZFxuIiwgX19mdW5jX18sDQo+IHJldCk7DQo+ID4g
Kw0KPiA+ICtyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG10a19z
bWlfbGFyYl9yZXNldF9kZWFzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYNCj4gKnJj
ZGV2LCB1bnNpZ25lZCBsb25nIGlkKQ0KPiA+ICt7DQo+ID4gK3N0cnVjdCBtdGtfc21pX3Jlc2V0
X2RhdGEgKmRhdGEgPSB0b19tdGtfc21pX3Jlc2V0X2RhdGEocmNkZXYpOw0KPiA+ICtjb25zdCBz
dHJ1Y3QgbXRrX3NtaV9sYXJiX3BsYXQgKmxhcmJfcGxhdCA9IGRhdGEtPmxhcmJfcGxhdDsNCj4g
PiArY29uc3Qgc3RydWN0IG10a19zbWlfbGFyYl9yZXNldCAqbGFyYl9yc3QgPSBsYXJiX3BsYXQt
DQo+ID5yZXNldF9zaWduYWwgKyBpZDsNCj4gPiAraW50IHJldDsNCj4gPiArDQo+ID4gK3JldCA9
IHJlZ21hcF9jbGVhcl9iaXRzKGRhdGEtPnJlZ21hcCwgbGFyYl9yc3QtPm9mZnNldCwgbGFyYl9y
c3QtDQo+ID52YWx1ZSk7DQo+ID4gK2lmIChyZXQpDQo+ID4gK2Rldl9lcnIocmNkZXYtPmRldiwg
Ilslc10gRmFpbGVkIHRvIHJlb3BlbiBsYXJiICVkXG4iLCBfX2Z1bmNfXywNCj4gcmV0KTsNCj4g
PiArDQo+ID4gK3JldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgcmVzZXRfY29udHJvbF9vcHMgbXRrX3NtaV9yZXNldF9vcHMgPSB7DQo+ID4gKy5yZXNl
dD0gbXRrX3NtaV9sYXJiX3Jlc2V0LA0KPiA+ICsuYXNzZXJ0PSBtdGtfc21pX2xhcmJfcmVzZXRf
YXNzZXJ0LA0KPiA+ICsuZGVhc3NlcnQ9IG10a19zbWlfbGFyYl9yZXNldF9kZWFzc2VydCwNCj4g
PiArfTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbXRrX3NtaV9yZXNldF9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICt7DQo+ID4gK3N0cnVjdCBkZXZpY2UgKmRldiA9
ICZwZGV2LT5kZXY7DQo+ID4gK2NvbnN0IHN0cnVjdCBtdGtfc21pX2xhcmJfcGxhdCAqbGFyYl9w
bGF0ID0NCj4gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRldik7DQo+ID4gK3N0cnVjdCBkZXZp
Y2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGUsICpyZXNldF9ub2RlOw0KPiA+ICtzdHJ1Y3QgbXRr
X3NtaV9yZXNldF9kYXRhICpkYXRhOw0KPiA+ICtzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQo+ID4g
Kw0KPiA+ICtkYXRhID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpkYXRhKSwgR0ZQX0tFUk5F
TCk7DQo+ID4gK2lmICghZGF0YSkNCj4gPiArcmV0dXJuIC1FTk9NRU07DQo+ID4gKw0KPiA+ICty
ZXNldF9ub2RlID0gb2ZfcGFyc2VfcGhhbmRsZShucCwgIm1lZGlhdGVrLGxhcmItcnN0LXN5c2Nv
biIsIDApOw0KPiA+ICtpZiAoIXJlc2V0X25vZGUpDQo+IA0KPiBUaGlzIGxvb2tzIGp1c3Qgd3Jv
bmcuIFRoaXMgbG9va3MgbGlrZSBhIGNoaWxkIG9mIHdoYXRldmVyIHBoYW5kbGUNCj4gcG9pbnRz
IGhlcmUuDQo+IA0KPiBXaHkgZG8geW91IGNyZWF0ZSBNTUlPLXVzaW5nIG5vZGUgYXMgbm90IE1N
SU8/DQo+IA0KDQpUaGlzIGlzIHRoZSBkZWZpbml0aW9uIGZvciBpbWdzeXMxX2RpcF90b3AgYW5k
IGltZ3N5czFfZGlwX3RvcF9yc3QuDQpTTUkgcmVzZXQgY29udHJvbGxlciBkcml2ZXIgcGFyc2Ug
dGhlICdtZWRpYXRlayxsYXJiLXJzdC1zeXNjb24nDQp0byBnZXQgdGhlICdpbWdzeXMxX2RpcF90
b3AnIGRldmljZSBub2RlIGFuZCByZWdtYXAuDQpUaGVuIFNNSSBkcml2ZXIgY291bGQgcmVhZCBh
bmQgd3JpdGUgdGhlIHJlZ2lzdGVyIGJ5IHRoZSByZWdtYXANCnRvIGFwcGx5IHJlc2V0IG9wZXJh
dGlvbnMgaGVyZS4NCg0KCWltZ3N5czFfZGlwX3RvcDogY2xvY2stY29udHJvbGxlckAxNTExMDAw
MCB7DQoJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWltZ3N5czEtZGlwLXRvcCI7DQoJ
CXJlZyA9IDwwIDB4MTUxMTAwMDAgMCAweDEwMDA+Ow0KCQkjY2xvY2stY2VsbHMgPSA8MT47DQoJ
fTsNCg0KCWltZ3N5czFfZGlwX3RvcF9yc3Q6IHJlc2V0LWNvbnRyb2xsZXIwIHsNCgkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxzbWktcmVzZXQtbXQ4MTg4IjsNCgkJI3Jlc2V0LWNlbGxzID0gPDE+
Ow0KCQltZWRpYXRlayxsYXJiLXJzdC1zeXNjb24gPSA8JmltZ3N5czFfZGlwX3RvcD47DQoJfTsN
CgkNCglsYXJiMTA6IHNtaUAxNTEyMDAwMHsNCgkJcmVzZXRzID0gPCZpbWdzeXMxX2RpcF90b3Bf
cnN0IE1UODE4OF9TTUlfUlNUX0xBUkIxMD47DQoJCXJlc2V0LW5hbWVzID0gImxhcmJfcnN0IjsN
Cgl9Ow0KDQpJIGFtIG5vdCBzbyBzdXJlIHRoZSBtZWFuaW5nICJNTUlPLXVzaW5nIiBoZXJlLiAN
CkN1cmVlbnRseSBJIHVzZSByZWdtYXBfc2V0X2JpdHMgYW5kIHJlZ21hcF9jbGVhcl9iaXRzIHRv
IHVwZGF0ZSB0aGUNCmxhcmIgcmVzZXQgcmVnaXN0ZXIuIFRoZXNlIHJlZ2lzdGVycyBsb2NhdGUg
aW4gZWFjaCBzdWJzeXMgYW5kIGFyZSB1c2VkDQpieSByZXNwZWN0aXZlIGRyaXZlcnMuIFNvIFNN
SSBhZGQgJ2ltZ3N5czFfZGlwX3RvcF9yc3QnIG5vZGUgdG8gZ2V0IHRoZQ0KcmVnbWFwIHRvIGF2
b2lkIGFmZmVjdGluZyBzdWJzeXMgZHJpdmVyLg0KDQpGcm9tIG15IHBvaW50IG9mIHZpZXcsIHRo
ZXJlIGFyZSB0d28gbWV0aG9kczoNCigxKXVzZSBvZl9pb21hcCB0byBnZXQgTU1JTyByZWdpc3Rl
ciByZWdpb24sIGFuZCB1c2Ugd3JpdGVsL3JlYWRsIHRvDQp3aXJ0ZS9yZWFkIHJlZ2lzdGVyLg0K
KDIpdXNlIGRldmljZV9ub2RlX3JlZ21hcCB0byBnZXQgdGhlIHJlZ21hcCwgYW5kIHVzZSByZWdt
YXBfc2V0X2JpdHMNCmFuZCByZWdtYXBfY2xlYXJfYml0cyB0byBzZXQgcmVnaXN0ZXINCg0KQW5k
IHlvdSBwcmVmZXIgb3B0aW9uICgxKSwgaXMgdGhpcyBjb3JyZWN0Pw0KDQpXaGF0IGlzIG1vcmUs
IHlvdSBwcmVmZXIgdG8gcHV0IHRoZSBpbWdzeXMxX2RpcF90b3BfcnN0IG5vZGUgaW50byB0aGUN
CmltZ3N5czFfZGlwX3RvcCBub2RlIGFzIGEgY2hpbGQgbm9kZSwgbGlrZSB0aGlzPw0KDQoJaW1n
c3lzMV9kaXBfdG9wOiBjbG9jay1jb250cm9sbGVyQDE1MTEwMDAwIHsNCgkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDgxODgtaW1nc3lzMS1kaXAtdG9wIjsNCgkJcmVnID0gPDAgMHgxNTExMDAw
MCAwIDB4MTAwMD47DQoJCSNjbG9jay1jZWxscyA9IDwxPjsNCg0KCQlpbWdzeXMxX2RpcF90b3Bf
cnN0OiByZXNldC1jb250cm9sbGVyMCB7DQoJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLHNtaS1y
ZXNldC1tdDgxODgiOw0KCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KCQl9Ow0KCX07DQoNCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo=

