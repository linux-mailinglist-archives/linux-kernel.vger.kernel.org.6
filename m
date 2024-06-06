Return-Path: <linux-kernel+bounces-203618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 482278FDE24
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A326FB23783
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 05:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558C9381C2;
	Thu,  6 Jun 2024 05:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H3JUtqaL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OsL3T+tD"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98092260C;
	Thu,  6 Jun 2024 05:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651805; cv=fail; b=kburWvUiUThAdfCnapPELbnhf0Rfj8hKT7YzRNi88+4Vql/fkYk8DtzxwZrJZxtzVFUUNaNfmpDO4EV37hQPbHVd0OamvywZLJRra8uTyukKzYZmFMlRfS2soUA3mc4oP06vgMXtKAtuZKCxH7HIyl3xwin5y0j0sl2OQWB3kuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651805; c=relaxed/simple;
	bh=b2Gp2o+7lpyYfuNo/DFrbZnGhWkqL/W7yneIy7W9LU4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mUUaVmJK6T0MHlAG6ki5wCs9waicr3rdWYsDU/QHwRz+1+mohvjJAVYFLa3pVgsrfqIoKVx3TgyxuY0rALkfKY9tcf9U56fzz2QgBIUjSq+Rj8pHhT1H0gOx1xkDiTaqZkv3hMVFrFj1dTXJLa1WDT8DydKIXhikW1QPsIYArTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=H3JUtqaL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=OsL3T+tD; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cfa5093423c511efbace61486a71fe2b-20240606
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=b2Gp2o+7lpyYfuNo/DFrbZnGhWkqL/W7yneIy7W9LU4=;
	b=H3JUtqaLuGdgzwhB6z9oxPknv19nq9Tj+6dED284Pg6WNFfiKbzWy7z8dNu7EMscIic5/mCu5WeOSpgdqczYNGFTHreN8RIQs7V09ADWiP6FtxmwK0lU17WD2ynLq2CcbI+ldgYLH9TOrk9KOJVfGQeyF7biwOA31hI8JI0AP7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:b42da070-f1e9-48e7-b30e-ef4aac870235,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:e2b3ad93-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cfa5093423c511efbace61486a71fe2b-20240606
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 289263804; Thu, 06 Jun 2024 13:29:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 6 Jun 2024 13:29:54 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 6 Jun 2024 13:29:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gyj5+gKc9PMzNmbm8AQLmXWZpluGIJUhRDGVkHtr+95xtmz+i+e//XEZ2RxIQu8sjehzXrJ1ntU7YP+42A7WSBmgHLqBD1dWyrqRCOmnO/D1LCPS4qaqIcE0XlBfdwiKIzKIn6VUTQBVX/swmv6VxIG05R8EYLukqionsE2FUQLviySZ4+9lmVdyVxlKrEeJ54Bh9dlf0E0Z6kxcPW7g4Z26y9NfiOW0wgZRk6um2L7lvqC9Cw6UZvPjOrckH4i4GHBS4/9XYWqKbT/lg4cIA+OGcnYs8uXc8Y8Tq3ufyqG+3eDr4Y5f0MA7SqFGTdJVB359w6rcTq06rcGGqht31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2Gp2o+7lpyYfuNo/DFrbZnGhWkqL/W7yneIy7W9LU4=;
 b=bYqByRqzUf/875BPEG7D6EDBQBIClyDfX5SqzrPqZhAKpxGiDH6oe5IrrR1bGxrrPaLS3hJCr9D3RmNceYdgfowooEsvK5CC1F2MBzV6ZB8XBu8MjvMFCraFqekVuTnzx4DR+eXnuZIsLeRK6XKkeBYZvtOfLaS5wf8GKBykJ3uIlUiH6lzVNW2bTTxRLqGqRHwFUVLTSfSGuEZ67zhofbq9pRbnfki7KMyRMgUTbOf8HqTS1NQv2WgIJO9K7TuU6XfTJ8bSkg2Ry73/Sn1/mrmF0FzzSAn7sIEyPt8fU59zrBo9ymVe6a3jYVEPaNCTgr+xzyZIVa3DId/2o5Z7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2Gp2o+7lpyYfuNo/DFrbZnGhWkqL/W7yneIy7W9LU4=;
 b=OsL3T+tDqr+73NT8w7hhiEaFr+smWVFvORaaGCwRyQ1U10LaHl53mrl/+yBeyoXalTZT/kqnKU/jh5Hk5Y/xahAgAwl0VT4CwbHRduervA2GXCuJ/oioX6mUJsEd++t/fY97Qf1KdQZm2lw473/DVWiUBi4/MorB/WMedtuLavk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7641.apcprd03.prod.outlook.com (2603:1096:400:414::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.15; Thu, 6 Jun
 2024 05:29:52 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.7656.012; Thu, 6 Jun 2024
 05:29:52 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"wenst@chromium.org" <wenst@chromium.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"robh@kernel.org" <robh@kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?=
	<Yu-chang.Lee@mediatek.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "amergnat@baylibre.com"
	<amergnat@baylibre.com>
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Topic: [PATCH v5 2/3] dt-bindings: arm: mediatek: mmsys: Add OF graph
 support for board path
Thread-Index: AQHaq1SdB3VktOcCqkqfEslqsj0mTLG4e18AgAChMYCAATHigA==
Date: Thu, 6 Jun 2024 05:29:52 +0000
Message-ID: <0f20214ab3a86f68669ad1392398b16228e699ee.camel@mediatek.com>
References: <20240521075717.50330-1-angelogioacchino.delregno@collabora.com>
	 <20240521075717.50330-3-angelogioacchino.delregno@collabora.com>
	 <e7845300fa822413f6308cb6297222cde89c39e0.camel@mediatek.com>
	 <0e0fe86c-92da-43f5-89d7-8084274a908a@collabora.com>
In-Reply-To: <0e0fe86c-92da-43f5-89d7-8084274a908a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7641:EE_
x-ms-office365-filtering-correlation-id: 8d072f13-0eaf-42bc-3120-08dc85e9b132
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?Z2lneXF1UTQ2Rzc2MTBDb3IvRDMvNktvU2NqOWZXRUlNR1NGRzA3QzZmRWEw?=
 =?utf-8?B?OUg5N3ByMnVCd200eHA0WTZrR1ZOcEpaS2hyRDkrMzVUb1J6STZLZmp5akZ2?=
 =?utf-8?B?Yms2ZGRzYmhGSHJBdGZlY0w4blNUYW1TanpZdDdBNzdJblVycXVHb1E2T2Va?=
 =?utf-8?B?TDBEck5GZWpkSExPSG5aNWVneDd0Q0d2eDlBbTdNdGtndFBNcW4zMENIMGFi?=
 =?utf-8?B?MEFTbUZGR0doVkttZm5SQURPR0graEJIMlJGbyt5ZWRBV1VCeExlMUhUcEdl?=
 =?utf-8?B?bVNETFYxY0txTTZjQjJuRlM5WGJ3cE1UUzZCMndVQkRBeW1DMlRRWDdpYmZT?=
 =?utf-8?B?OTdFa1U0eXFjOS82UXh6QlRhbEJGMjhBc2NyMVVyYUNhRmhTZXRXSFhGK1lY?=
 =?utf-8?B?ZXpsdFovdUJxQ05HR042V1c4cGt2blljRlhWQlhBbGN3ZFNIb3A2SXoySFNn?=
 =?utf-8?B?V1lSUm1haUp3Ym4wOXlXcmh2cHZ2RklNd2FtN0RxZnVERVBOZnNHcXVYaUo2?=
 =?utf-8?B?SXFuWFNuNS9UaEFaMWMyTkYySDRxc2Z1OUozaTlCcUFNU0gvM0ZnL01jZXY2?=
 =?utf-8?B?Sm8zU0FjMFJadWR0c0VkYldpSk4wNW1lQXl5UXlCZ2o4ZW1yTXVsb2F6Z1FJ?=
 =?utf-8?B?a2RKWmVZUkFiaytEbGFjV3hLYTBYb2pBWVZSTkdiODlTVDhCTGNmRkh3empC?=
 =?utf-8?B?K1BZcXRac2xxc1MvVUN4S2RGT2lpQmUrMUZ2OGxzKzBCb0xwZkUrSEVrVURJ?=
 =?utf-8?B?ZGRmMU1HVU9aT045ZnhSU1JndGNnRGRFamoxMUlSRWlHSVRHU3NPMk5IQyto?=
 =?utf-8?B?R3dod3MxSEZNcUtpbVV1dkVBaHIySDlhTXg0MkJ0L01obWxaR0IyZmU4MWZj?=
 =?utf-8?B?SVlMOHVVVklEZHpzZVdJL1g1VkhRaVBNNjJHc3p4SEFHeTJvampUbnNkb2Nr?=
 =?utf-8?B?SmVMV09SenN4T0UwK1pNRGZyZ2laMnc5YkNwcXVPTWpZVkV1aDlEeW9yTlZB?=
 =?utf-8?B?ZWkyeE8ycHp1UTNpcGVseVpQUW95QW1QZmdWRXd4YWQ3RjRVVitGMm80TkNy?=
 =?utf-8?B?K0piODkvbXZ4WDNRZ1FJVm1RQTZmSk12aVdCYlZPRWgxSFhFTjVEWHVQUDEy?=
 =?utf-8?B?N1pMcnlXL05qZjVrdkJ2L2Z4dXplbHBuQlA3M3ZjZnk2RzgyZ01KMHJlcXpw?=
 =?utf-8?B?MytvNEc2VlNUVldEYnNJckFYcDVlcnVGMVNUcnErT2NQMzBxMHc4YUtYWGRo?=
 =?utf-8?B?QTdDcXhaQ0VlM3FTRFpjOGxBUUdWYzhUc1ZCQXUrSFZORklMeWI0RVJpWGZM?=
 =?utf-8?B?blNSVzUxeGhZbzAxcWMrWUZnNWNGZVlSOWZ3K2NOSFhqM1czSExmWUZuRkx1?=
 =?utf-8?B?QjN3YjBDL2FYYnVaRTludnZKcmZiRDNnazVYSUxFN0VkNDB1THk5cGZQRXhS?=
 =?utf-8?B?Yy85Q3VyYnRJOGgxeHV6a2thZEJ0UFNyWU9JazVZMnBiZGpQUU00Q0xCOHU1?=
 =?utf-8?B?UzFFb2xsYUliemZ0OSt2S0dJdjlmOW5mUEFnVVArc3E2c0FBRFRDVG1sSGJo?=
 =?utf-8?B?cUt5UUUwalR3MXR6TCtlV21FQVFoWmV0bFU4cGxWR2FpcjlxMFB3b1FMSWhq?=
 =?utf-8?B?YUR6cVR6clQwV045b3BFWFFpKzJBdU1vN1ZhMlV2RTQzbDloS2RzcEdrbDU2?=
 =?utf-8?B?WWpQSUVpbE1SQ0o3RXdEclZzcEFsUUwrVWU3a3U3NDV1blI5SWhwUTZjWE9N?=
 =?utf-8?B?K05kTjRaQ1FIWUZpaVRFRDFwT2U2UlVNdXNMdm11MmN3c1ZKWlozbUN5MjBs?=
 =?utf-8?Q?wTpheXOqtvetCGSvwz+o8cESxmCw/OTfIFtNw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHlkc0lXS2NVcldlNkkvdDIwOGJ0VHZoSEVFbGdZS3g5R0FpWTZBbUNkbWJu?=
 =?utf-8?B?VW1oWURuQzg5REM0QkdzTVFVM3p0RkhYNEhnYTFWSTdJc2pJVytCTEszT1ZE?=
 =?utf-8?B?d0psMkpsNktpdzZPMUovdGcwV3JJb09yUWVZdmRQME8rTzRsN1FmQTN3WHl5?=
 =?utf-8?B?VFdldlpEbWpjejlmV3F1d0VweHA4RnNGRHcxQ3JLMjRGTDd4ZUk5MWJyTUla?=
 =?utf-8?B?SnVGc1d5cHNKY29oNi9TajU3SU4xbXNJcDA1YWlrK0hCZk43VG84bUJaZGdq?=
 =?utf-8?B?UFEyYTA2OTdrRWQ4STBlMzN1NmdwbmZ3b3d3SGwzZUo2QVhZcmhhSnQyc1hm?=
 =?utf-8?B?ekZFN1c3d1hiMXpEeDBBVDBsM1NGWm93NGxFZjRqOU5yQlB1WC9GcG9sU0dz?=
 =?utf-8?B?WG9UY3FCZVNnNzN1QVBjVEtKV1hFWkg5S3dQYXlOUDVkeWI1RW81dFRTZ0ds?=
 =?utf-8?B?OEdiNlAzdU51VWR6WmdUWUJWVWdaMnc4MlVObXgvZDU4ejN4Smg3SC9NT01H?=
 =?utf-8?B?eFF3cWw4Y1NTWmhxcXdldWlETDRsTEdObzhUSVdIMU1ZSmRJTis3RUI4TkZD?=
 =?utf-8?B?N2NiOTdwcUVvNFlkL3orYmRNKzRTaTkxdDRMYVJqRW15MWlZeFh5aytMaHM3?=
 =?utf-8?B?Qi9QZUZFTE5LUkpTKzNGWjk5ZjczcDBheFlYeFZjb29KWk5LYWdoUmVlc0lu?=
 =?utf-8?B?amxZZGdGZDVVTXRCM2ZpWUZUTksrRHRuejkrZ05mb0pZYnlqQzBXaVZTVytw?=
 =?utf-8?B?c1ZSOEM4RSt1SHpadGpYK3ZDYkVxdlJRUkgrdzBRQk5Ed0FvNG1JdTZNTVd5?=
 =?utf-8?B?ak9oQkFiVHFMYnNXL0FvVzkvVTZjWmxMQnhwQkYrcktsM3BLRkJiKzRBS3FV?=
 =?utf-8?B?MWhEdjZjZXdUcHNTTWpOUlp1Yk1Scmk5MEhnazFOc29iYWpZVmJGcUZKcE5L?=
 =?utf-8?B?eXNVYTIwaUs3cytVWHZVcyswbjBhNmFwKzE5a1Fyai85amZoWm1wVmpxb2NL?=
 =?utf-8?B?eGpwV3JKL3VzSjRMV3hMYWIrZW1Ja2dSUzAvS0Q3R3kvZHlCemdTRldPRHc3?=
 =?utf-8?B?R1YrOE1qMkI3Qlg4NnRsZFdvcTZQcGp1RTdVS2JFS3dVNUhWUGFhblkzam1N?=
 =?utf-8?B?S093MnZuTkViRElKcS9FNzZxeEhiM3RoNTZEWEgxYnd6MkV2UVFrQS9rbDNm?=
 =?utf-8?B?QjZ0QzNvL0NOeDVwSUxPMmNkeVo1MXo0bW5xcmlJWXRHa1BXTUhOUVRVQmNT?=
 =?utf-8?B?TkFhMVh5MTB3aURXbVpGNmRoR2grTFEwWjV5Z1dZd292ejh2Z3RHa2lKNWpG?=
 =?utf-8?B?eVZ3Tmhsc251bjZ6YWxMY2lDb1gyNWUxeGF1MzZyK2xKYzFpYWhXNkFpcHFI?=
 =?utf-8?B?UlB0TXdULzVxSXJSeFVxbEdOcytDVC83UVRSRVpxVnN1dW9UY0VkZEtoLzBZ?=
 =?utf-8?B?SUlnRy9CVnJZYlowQy9GSkNORGVWUEM4eER1ZUlPYmFOUC9OaWxNajEwNitP?=
 =?utf-8?B?SUg4ZVh3ODZpZlQrMGdablNobFhjN3puMDZYMHpZV21rTlhnaE9QQVBtL0Zj?=
 =?utf-8?B?b085MkpaeE5MaDFTSmt5WCt6OEhSZ3VmK2NwYjRBMGlvM1pQTktVR3BjUHVK?=
 =?utf-8?B?bzJscjVIRnZpckpwRmhlcjViZlB3NmFiZFQxb01yVERoNTZ1ckpxenU1YXBv?=
 =?utf-8?B?RllvSmx3NFZSbFpLb2RuUXh4MlZnc2lPcG1WRFlySk5HemNVdnNyQnhqWGJq?=
 =?utf-8?B?SDBIaWt1L1ppa3BJakttMk9DamJ3eE5IQWtwM1dlRjZzZFhuOVh4UnRjYVF4?=
 =?utf-8?B?RnJSbVR1elZJNnlwNVdqeHJSTXk0dVg0eFFNRE9kWXpiZ2plTDJ1RkVnVzVY?=
 =?utf-8?B?b2t1S1lFS2dUcHRPUDdCN2ZQdTBFdTFzY0FBYTUyYmtnVE9JSFpQM2tJdHRR?=
 =?utf-8?B?cjVTeGpvT214ei9nc29CRE9SUW5PYlFneGg0enJWT1ljVVlPR0hKR1pGaEg2?=
 =?utf-8?B?ckFUWHNwaGlmTWgvcXhJZGZ2V2drVGZMSmRnam1xekZDL08xNFhpVmpxMW14?=
 =?utf-8?B?QUVkVC92R0R2bWNEL1lJRzA2NEg5Y1lja2JVUGRONmlHU1krVTArU3pzakla?=
 =?utf-8?Q?wKJ12A8pwZw82/mp/uJGzxKb9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F249130176CA794C88734B893BE66746@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d072f13-0eaf-42bc-3120-08dc85e9b132
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 05:29:52.5978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6QRJBnOucTclqfv84duURkJ/ph4j9WaU1tphoy1NNgoMi793ci/cqjxz4/jVsbqSck9On3AHnzmOREJxJ441gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7641
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--19.002900-8.000000
X-TMASE-MatchedRID: byfwvk+IcRkNtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDznddP8
	W0t/rMaUuF0hjaCRm7eXlSuRSjjgAQOHW1v+xYUcGVyS87Wb4lxMkOX0UoduuQKzHKFHzLsJdE7
	ABQfxM9dCUOgjALyv3yRL8EgGNPeiRG8VGwrx1sv0hv/rD7WVZECrr/LkAQ46s6LcaSYUJwN7+u
	SQIU88H2SnjsQQWTFXal6tZYd1uk4byi21ijN4Z9jko+KiQPUGFspPdEyOR1rHkH7uosEn7CBd/
	ELbc/UwSjUOQ9+7Q0bwvqxNs7rkX0DAEmiOG36Bi1u/Wt2ORDod4tMZ5TvMM7IEaJTsOlgOP84L
	fIrZUU2fHoYNv/tRVWLP47+knfp2SSNF8PKk19vr/EBmiNuXt30tCKdnhB58pTwPRvSoXL2y5/t
	FZu9S3Ku6xVHLhqfxIAcCikR3vq+UGQR2O3WmR3TJF5yPSPbScjYetlC8E6wWtSja+sJf2YQnUn
	zsubv7
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.002900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	596811BDD6584F7642AA205A4662DB0288E03EF237B3644CDF3DA8459B6B4AC52000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTA2LTA1IGF0IDEzOjE1ICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDUvMDYvMjQgMDM6MzgsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBUdWUs
IDIwMjQtMDUtMjEgYXQgMDk6NTcgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdy
b3RlOg0KPiA+ID4gRG9jdW1lbnQgT0YgZ3JhcGggb24gTU1TWVMvVkRPU1lTOiB0aGlzIHN1cHBv
cnRzIHVwIHRvIHRocmVlIEREUCBwYXRocw0KPiA+ID4gcGVyIEhXIGluc3RhbmNlIChzbyBwb3Rl
bnRpYWxseSB1cCB0byBzaXggZGlzcGxheXMgZm9yIG11bHRpLXZkbyBTb0NzKS4NCj4gPiA+IA0K
PiA+ID4gVGhlIE1NU1lTIG9yIFZET1NZUyBpcyBhbHdheXMgdGhlIGZpcnN0IGNvbXBvbmVudCBp
biB0aGUgRERQIHBpcGVsaW5lLA0KPiA+ID4gc28gaXQgb25seSBzdXBwb3J0cyBhbiBvdXRwdXQg
cG9ydCB3aXRoIG11bHRpcGxlIGVuZHBvaW50cyAtIHdoZXJlIGVhY2gNCj4gPiA+IGVuZHBvaW50
IGRlZmluZXMgdGhlIHN0YXJ0aW5nIHBvaW50IGZvciBvbmUgb2YgdGhlIChjdXJyZW50bHkgdGhy
ZWUpDQo+ID4gPiBwb3NzaWJsZSBoYXJkd2FyZSBwYXRocy4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3
ZWQtYnk6IFJvYiBIZXJyaW5nIChBcm0pIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gPiBSZXZpZXdl
ZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gPiA+IFRl
c3RlZC1ieTogQWxleGFuZHJlIE1lcmduYXQgPGFtZXJnbmF0QGJheWxpYnJlLmNvbT4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2No
aW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgLi4uL2JpbmRp
bmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55YW1sIHwgMjggKysrKysrKysrKysrKysr
KysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiA+ID4gDQo+
ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9t
ZWRpYXRlay9tZWRpYXRlayxtbXN5cy55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2FybS9tZWRpYXRlay9tZWRpYXRlayxtbXN5cy55YW1sDQo+ID4gPiBpbmRleCBiM2M2
ODg4YzE0NTcuLjBlZjY3Y2E0MTIyYiAxMDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbW1zeXMueWFtbA0KPiA+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tZWRpYXRlay9t
ZWRpYXRlayxtbXN5cy55YW1sDQo+ID4gPiBAQCAtOTMsNiArOTMsMzQgQEAgcHJvcGVydGllczoN
Cj4gPiA+ICAgICAnI3Jlc2V0LWNlbGxzJzoNCj4gPiA+ICAgICAgIGNvbnN0OiAxDQo+ID4gPiAg
IA0KPiA+ID4gKyAgcG9ydDoNCj4gPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvZ3JhcGgueWFtbCMv
cHJvcGVydGllcy9wb3J0DQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ID4gKyAgICAgIE91
dHB1dCBwb3J0IG5vZGUuIFRoaXMgcG9ydCBjb25uZWN0cyB0aGUgTU1TWVMvVkRPU1lTIG91dHB1
dCB0bw0KPiA+ID4gKyAgICAgIHRoZSBmaXJzdCBjb21wb25lbnQgb2Ygb25lIGRpc3BsYXkgcGlw
ZWxpbmUsIGZvciBleGFtcGxlIG9uZSBvZg0KPiA+ID4gKyAgICAgIHRoZSBhdmFpbGFibGUgT1ZM
IG9yIFJETUEgYmxvY2tzLg0KPiA+ID4gKyAgICAgIFNvbWUgTWVkaWFUZWsgU29DcyBzdXBwb3J0
IG11bHRpcGxlIGRpc3BsYXkgb3V0cHV0cyBwZXIgTU1TWVMuDQo+ID4gDQo+ID4gVGhpcyBwYXRj
aCBsb29rcyBnb29kIHRvIG1lLiBKdXN0IHdhbnQgdG8gc2hhcmUgYW5vdGhlciBpbmZvcm1hdGlv
biBmb3IgeW91Lg0KPiA+IEhlcmUgaXMgYW4gZXhhbXBsZSB0aGF0IG1tc3lzL3Zkb3N5cyBjb3Vs
ZCBwb2ludCB0byB0aGUgZGlzcGxheSBpbnRlcmZhY2Ugbm9kZS4NCj4gPiANCj4gPiB2ZG9zeXMw
OiBzeXNjb25AMWMwMWEwMDAgew0KPiA+ICAgICAgICAgICAgbW1zeXMtZGlzcGxheS1pbnRlcmZh
Y2UgPSA8JmRzaTA+LCA8JmRzaTE+LCA8JmRwX2ludGYwPjsNCj4gPiB9Ow0KPiA+ICAgDQo+ID4g
dmRvc3lzMTogc3lzY29uQDFjMTAwMDAwIHsNCj4gPiAgICAgICAgICAgIG1tc3lzLWRpc3BsYXkt
aW50ZXJmYWNlID0gPCZkcF9pbnRmMT47DQo+ID4gfTsNCj4gPiANCj4gPiBUaGVyZSBpcyBubyBj
b25mbGljdCB0aGF0IG1tc3lzL3Zkb3N5cyBwb2ludCB0byBmaXJzdCBjb21wb25lbnQgb2Ygb25l
IGRpc3BsYXkgcGlwZWxpbmUgb3IgcG9pbnQgdG8gZGlzcGxheSBpbnRlcmZhY2UuDQo+ID4gQm90
aCBjb3VsZCBjby1leGlzdC4NCj4gPiANCj4gDQo+IEhleSBDSywNCj4gDQo+IHllcywgdGhpcyBj
b3VsZCBiZSBhbiBhbHRlcm5hdGl2ZSB0byB0aGUgT0YgZ3JhcGhzLCBhbmQgSSdtIHN1cmUgdGhh
dCBpdCdkIHdvcmssDQo+IGV2ZW4gdGhvdWdoIHRoaXMga2luZCBvZiBzb2x1dGlvbiB3b3VsZCBz
dGlsbCByZXF1aXJlIHBhcnRpYWwgaGFyZGNvZGluZyBvZiB0aGUNCj4gZGlzcGxheSBwYXRocyB1
cCB1bnRpbCBtbXN5cy1kaXNwbGF5LWludGVyZmFjZSAoc28sIHVwIHVudGlsIERTSTAsIG9yIERT
STEsIGV0YykuDQo+IA0KPiBUaGUgcHJvYmxlbSB3aXRoIGEgc29sdXRpb24gbGlrZSB0aGlzIGlz
IHRoYXQsIHdlbGwsIGV2ZW4gdGhvdWdoIGl0IHdvdWxkIHdvcmssDQo+IGV2ZW4gaWYgd2UgaWdu
b3JlIHRoZSBzdWJvcHRpbWFsIHBhcnRpYWwgaGFyZGNvZGluZywgT0YgZ3JhcGhzIGFyZSBzb21l
dGhpbmcNCj4gZ2VuZXJpYywgd2hpbGUgdGhlIG1tc3lzLWRpc3BsYXktaW50ZXJmYWNlIHdvdWxk
IGJlIGEgTWVkaWFUZWsgc3BlY2lmaWMvY3VzdG9tDQo+IHByb3BlcnR5Lg0KPiANCj4gSW4gdGhl
IGVuZCwgcmV1c2luZyBnZW5lcmljIGtlcm5lbCBhcGlzL2ludGVyZmFjZXMvZXRjIGlzIGFsd2F5
cyBwcmVmZXJyZWQNCj4gY29tcGFyZWQgdG8gY3VzdG9tIHNvbHV0aW9ucywgZXNwZWNpYWxseSBp
biB0aGlzIGNhc2UsIGluIHdoaWNoIHRoZSBnZW5lcmljDQo+IHN0dWZmIGlzIG9uLXBhciAob3Ig
YWN0dWFsbHksIGRlcGVuZGluZyBwdXJlbHkgb24gcGVyc29uYWwgb3BpbmlvbnMsIHN1cGVyaW9y
KS4NCj4gDQo+IEFzIGZvciB0aGUgdHdvIHRvIGNvLWV4aXN0LCBJJ20gbm90IHN1cmUgdGhhdCB0
aGlzIGlzIGFjdHVhbGx5IG5lZWRlZCwgYXMgdGhlDQo+IE9GIGdyYXBocyBhcmUgYWxyZWFkeSAo
YXQgdGhlIGVuZCBvZiB0aGUgZ3JhcGgpIHBvaW50aW5nIHRvIHRoZSBkaXNwbGF5IGludGVyZmFj
ZS4NCj4gDQo+IEluIGFueSBjYXNlLCBqdXN0IGFzIGEgcmVtaW5kZXI6IGlmIHRoZXJlIHdpbGwg
YmUgYW55IG5lZWQgdG8gYWRkIGFueSBjdXN0b20NCj4gTWVkaWFUZWsgc3BlY2lmaWMgcHJvcGVy
dGllcyBsYXRlciwgaXQncyBvayBhbmQgd2UgY2FuIGRvIHRoYXQgYXQgYW55IHRpbWUuDQoNClRo
ZSBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBpcyB1c2luZyBPRiBncmFwaHMgdG8gcG9pbnQgZGlzcGxh
eSBpbnRlcmZhY2UgYW5kIHVzZSBNZWRpYVRlayBzcGVjaWZpYyBwcm9wZXJ0eSB0byBmaXJzdCBj
b21wb25lbnQ6DQoNCnZkb3N5czA6IHN5c2NvbkAxYzAxYTAwMCB7DQogICAgICAgICAgcG9ydHMg
ew0KICAgICAgICAgICAgICAgICAgIHBvcnRAMCB7DQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGVuZHBvaW50IHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVt
b3RlLWVuZHBvaW50ID0gPCZkc2kwX2VuZHBvaW50PjsNCiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfTsNCiAgICAgICAgICAgICAgICAgICB9Ow0KIA0KICAgICAgICAgICAgICAgICAgIHBv
cnRAMSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgIGVuZHBvaW50IHsNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkc2kxX2Vu
ZHBvaW50PjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCiAgICAgICAgICAgICAg
ICAgICB9Ow0KIA0KICAgICAgICAgICAgICAgICAgIHBvcnRAMiB7DQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVuZHBvaW50IHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkcF9pbnRmMF9lbmRwb2ludD47DQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIH07DQogICAgICAgICAgICAgICAgICAgfTsNCiAgICAgICAgICB9
Ow0KIA0KICAgICAgICAgIGRpc3BsYXktZmlyc3QtY29tcG9uZW50ID0gPCZvdmwwPjsNCn07DQoN
CkFuZCBJIGFncmVlIHRvIGl0J3MgYmV0dGVyIHRvIGtlZXAgb25seSBPRiBncmFwaHMgcHJvcGVy
dHksIHNvIGl0IHdvdWxkIGJlDQoNCnZkb3N5czA6IHN5c2NvbkAxYzAxYTAwMCB7DQogICAgICAg
ICAgcG9ydHMgew0KICAgICAgICAgICAgICAgICAgIHBvcnRAMCB7DQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVuZHBvaW50IHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmVtb3RlLWVuZHBvaW50ID0gPCZkc2kwX2VuZHBvaW50PjsNCiAgICAgICAgICAgICAg
ICAgIA0KICAgICAgICAgICB9Ow0KICAgICAgICAgICAgICAgICAgIH07DQogDQogICAgICAgICAg
ICAgICAgICAgcG9ydEAxIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW5kcG9pbnQg
ew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZW1vdGUtZW5kcG9pbnQg
PSA8JmRzaTFfZW5kcG9pbnQ+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgIH07DQog
ICAgICAgICAgICAgICAgICAgfTsNCiANCiAgICAgICAgICAgICAgICAgICBwb3J0QDIgew0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBlbmRwb2ludCB7DQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJlbW90ZS1lbmRwb2ludCA9IDwmZHBfaW50ZjBfZW5kcG9pbnQ+
Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo7DQogICAgICAgICAgICAgICAgICAg
fTsNCiAgICAgICAgICB9Ow0KfTsNCg0KTWF5YmUgd2UgY291bGQgdXNlIE9GIGdyYXBocyBmb3Ig
Ym90aCBmaXJzdCBjb21wb25lbnQgYW5kIGRpc3BsYXkgaW50ZXJmYWNlIGFuZCBkcm9wIHVzaW5n
IE1lZGlhVGVrIHNwZWNpZmljIHByb3BlcnR5Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiANCj4gQ2hl
ZXJzIQ0KPiBBbmdlbG8NCj4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0KPiA+ID4gKyAg
ICBwcm9wZXJ0aWVzOg0KPiA+ID4gKyAgICAgIGVuZHBvaW50QDA6DQo+ID4gPiArICAgICAgICAk
cmVmOiAvc2NoZW1hcy9ncmFwaC55YW1sIy9wcm9wZXJ0aWVzL2VuZHBvaW50DQo+ID4gPiArICAg
ICAgICBkZXNjcmlwdGlvbjogT3V0cHV0IHRvIHRoZSBwcmltYXJ5IGRpc3BsYXkgcGlwZWxpbmUN
Cj4gPiA+ICsNCj4gPiA+ICsgICAgICBlbmRwb2ludEAxOg0KPiA+ID4gKyAgICAgICAgJHJlZjog
L3NjaGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9lbmRwb2ludA0KPiA+ID4gKyAgICAgICAg
ZGVzY3JpcHRpb246IE91dHB1dCB0byB0aGUgc2Vjb25kYXJ5IGRpc3BsYXkgcGlwZWxpbmUNCj4g
PiA+ICsNCj4gPiA+ICsgICAgICBlbmRwb2ludEAyOg0KPiA+ID4gKyAgICAgICAgJHJlZjogL3Nj
aGVtYXMvZ3JhcGgueWFtbCMvcHJvcGVydGllcy9lbmRwb2ludA0KPiA+ID4gKyAgICAgICAgZGVz
Y3JpcHRpb246IE91dHB1dCB0byB0aGUgdGVydGlhcnkgZGlzcGxheSBwaXBlbGluZQ0KPiA+ID4g
Kw0KPiA+ID4gKyAgICBhbnlPZjoNCj4gPiA+ICsgICAgICAtIHJlcXVpcmVkOg0KPiA+ID4gKyAg
ICAgICAgICAtIGVuZHBvaW50QDANCj4gPiA+ICsgICAgICAtIHJlcXVpcmVkOg0KPiA+ID4gKyAg
ICAgICAgICAtIGVuZHBvaW50QDENCj4gPiA+ICsgICAgICAtIHJlcXVpcmVkOg0KPiA+ID4gKyAg
ICAgICAgICAtIGVuZHBvaW50QDINCj4gPiA+ICsNCj4gPiA+ICAgcmVxdWlyZWQ6DQo+ID4gPiAg
ICAgLSBjb21wYXRpYmxlDQo+ID4gPiAgICAgLSByZWcNCj4gDQo+IA0K

