Return-Path: <linux-kernel+bounces-210767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCB7904876
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 03:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57331F23283
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A214436;
	Wed, 12 Jun 2024 01:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UzUxypmL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Y8LmM02B"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7750EAC2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718156128; cv=fail; b=MRCRfmxC9mAk80qHCTA4mySgeqJIA0sy/fYBBZP+3MCEK5IGQ4UMUXJcxdpusNpEG4LZ2NpeyJPW3A1F9RUdrAIbzNDnWp+09UbAIqt4CVNHJREH5Adjukdze2h/wRFt9Mos2K2DBVZVzpGHm13nRBZbsqFWZegl4SwpxL7V1nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718156128; c=relaxed/simple;
	bh=bHvPRjsMFJnzIGKBjxJIjTSD/v75zSpoE0p6O6yj2QI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ih4LN267eqG7o/bUgT9tzCwbeUon33fmJYQWgHSVP4Ag9uTfggTXYWm43mvAi66q1dO1RuyEVdtCKv7nt4anDpDjPy8hvKJnNE6QsI5FJWWB4lHPXpiCO9qc2Eqqqm0ty/WFCUicAaQCau5lVjIeaO3p7SKhNe+drMaGUHXcPSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UzUxypmL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Y8LmM02B; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 06ae77a4285c11efa22eafcdcd04c131-20240612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bHvPRjsMFJnzIGKBjxJIjTSD/v75zSpoE0p6O6yj2QI=;
	b=UzUxypmLLqljfQ9IasegBeIxy7FDVKlq7fe7W+eocY9K9QWlpPhLST3yt10bi5m2fotjPLPpNxNVo4hPZIur3TKkF25gEr+QmkHOSgHQvgDT5Bcjmnuhx2mpCxVgr5QQELypBAoIdztoqPUauO7vw6B133hYqUdE3pEaB0v5BaQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:8657d583-0a4a-432a-930b-4ddab2b2eef5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:1eab7644-4544-4d06-b2b2-d7e12813c598,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 06ae77a4285c11efa22eafcdcd04c131-20240612
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 51324446; Wed, 12 Jun 2024 09:35:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 12 Jun 2024 09:35:17 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 12 Jun 2024 09:35:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx/DjsthHFKnHihfzVKijRfTW/PXzG6mnGl5cnRqYdf7+NAdszW2VHHkjL9GuRd/s+V11JRS8FErECdZitlJvqBBtCXvqRchRjU/pW/1h+UeC+GTFYMWR752/R1JidA/wopJli3MwJwJCLJ26ow02V3lleBKqiNVK8CbTv8sIii2nFrMGart5YNwSO1Hu3cesNKYdcH8KcDz+JS02lgmG3Nw73OcgjpvAs+eJVRZOzMDaPzX42woWphUi43KvFld2xiEdwBmeMNLCz2+oaygUWjKE42TPfQjpdcqqqsMx5nEIxeh0GOePOrXkr2elki3EXWGKJFZPDI/lNpmHTi7YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHvPRjsMFJnzIGKBjxJIjTSD/v75zSpoE0p6O6yj2QI=;
 b=Y9noUN2zAjmEnTm+QuR9OmuzzrMH+gCsp9ugJQ43mO+gez327dvybZxv3yah7q/SQmOzjF5REYPXYewIyQqGzJl4B5/YFPHrBCbsAipiFHfNJv48zpqjxwAA+c6A1raLWoI63CgZQXKW2AMRCclox1WaSUFDSc/2riBxUwwstIXQeQZu1Cdng8yBN2cqaDSZDonMkRhvUXIvQFQbM5Zac4zJ7ynH/dY9kMK0oGT3AXSDhhQq4GlRzwqGvIXgoeGUCDsWq6IUB4dtC1gKs87+C2w5nL6BdQ63gY1A9bKb1w1HHz1DT2OMxzdciRuVZRfL8lnpSgV1NcT+vAWuvwgawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHvPRjsMFJnzIGKBjxJIjTSD/v75zSpoE0p6O6yj2QI=;
 b=Y8LmM02BKp6NA1E4o8hi40rGgC0pwPB6vqrdC8hhIO0M2QgqZ9wBz7Y0pB7yJ2rIWMo7hELBiu7zeiZK/MQWucOxTDxn2ZRDtpvgM3BwNloEbNH9FwW5vnQxrEmWKJu5O0fEAMRi0LQo8doHoR3kDghndRADCZNH5o194IkkVUU=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by SEYPR03MB8149.apcprd03.prod.outlook.com (2603:1096:101:174::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16; Wed, 12 Jun
 2024 01:35:15 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%5]) with mapi id 15.20.7677.014; Wed, 12 Jun 2024
 01:35:15 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"sean@poorly.run" <sean@poorly.run>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v8 15/16] drm/mediatek: Support CRC in OVL
Thread-Topic: [PATCH v8 15/16] drm/mediatek: Support CRC in OVL
Thread-Index: AQHat/PHdknEuVE2R0mLZa88oDMI7bHDYaMA
Date: Wed, 12 Jun 2024 01:35:15 +0000
Message-ID: <a470806f72747044c29097f33978faa545b9936d.camel@mediatek.com>
References: <20240606092635.27981-1-shawn.sung@mediatek.com>
	 <20240606092635.27981-16-shawn.sung@mediatek.com>
In-Reply-To: <20240606092635.27981-16-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|SEYPR03MB8149:EE_
x-ms-office365-filtering-correlation-id: 3d10efd6-b120-494d-9fcc-08dc8a7fe8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|7416006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: =?utf-8?B?S3FBdDFTaUJGa2JZQVBsNWtPeEp2Z3YzZGt2OE1ibGlLV2NkS2ZQWERpSGdw?=
 =?utf-8?B?U3E4dDVwTFZWeGh0V2tGZFMyUnZhdW9ER0l6VzB4R2ZqanAyenNGQS9wSHJi?=
 =?utf-8?B?NHpGcmpNd3hyL21tVXhJbTliZHBkN252cU5oQ1RIUUR4VGFuZ3RGKzhPRDlq?=
 =?utf-8?B?c0hjTTZnTlMrMTYwNlNLQVViUmlYMkRITStlcmUwcFU2MHo5S2hwTjhTdy9G?=
 =?utf-8?B?dE44QTZDMS85VWFIVytVVmhNZUllNUs2TFZYdUxkTDhKK0ZrdnRpWkVSbUJs?=
 =?utf-8?B?aW1jcVRVbmFSbnlraW9DWXZDYjlVczNmdjFFU0JZMHNkM3VKMVlRUXFGSWpp?=
 =?utf-8?B?ckNoR0VtYXcvcHlyMnFjcjdSSUNBYzRFc0cwbjBqN0xhekpkeldCaFV4YmRw?=
 =?utf-8?B?a3ZQYk1vdlVzM0xrODFndVVxZWNMVE5VTll0b3ZEWGQwSXNMc045WWdSVDZY?=
 =?utf-8?B?SkdxdTJ3bDVWMDZRVVI4MFUzYjk1OG1PNkExU0ErenFRY29QdUlaQUdUTzhl?=
 =?utf-8?B?ZDQ3NGlWMjMvbVErc1QxajYxUkkxemFPSWJwd3BWYW9uV0FFMXlXZEZaTjk4?=
 =?utf-8?B?eUhCazd6UmxjTjdpTFRzYkY3b0M2Z1EwSXFsajQ2ZjJYMU5reHMxSXhTNE9u?=
 =?utf-8?B?Z1NxSDUvNHpTZWE4UzBJZWFYRGhLL0pOUlRUVkZqUHBuSDZleFFCQ3kwaVpo?=
 =?utf-8?B?K1M0Mi80eEwrdEtJOTFGMjV6bVdSZDdZWStKa3lweGxWR1RsSUo0eEZXVEI5?=
 =?utf-8?B?eFUxRnlCSmdQYkM1c2ZWbWNMRzhvR3gwY0xGZEh4NnJNYzRQSFYvdktLSC9p?=
 =?utf-8?B?ckE0YVpPbUNPN0JpME11Q2l2MW1vM1RFSlNVZHIrN0JWQWE0ZGRKQkdqaUNH?=
 =?utf-8?B?TlBGeWptVXZZQmpMdjk1ZlhDYTlrRzdlZmpESk0xQk8xOTEwSWs4Y2haRjdS?=
 =?utf-8?B?SG1hSE5BN1FXR20xR3E5Z0xHRXZhRFVNVy9VeS93K2tEYnVEQzhqMzBnWmFB?=
 =?utf-8?B?cXNhblZxd1h1K1NObkR6QWNhc2NJZjR2ODgyUkYrZTBldnduV25LS0ZhN0pl?=
 =?utf-8?B?VGpYdktvVFFIb1ZYNU04WE01enQ4eFcrZW83eG0xQVVPWlY1T1lraHRlUnJm?=
 =?utf-8?B?MTJJaVlweTVBQmMrYVNHUE1zYWxaTjkrVThnOTY2ZC9XSzdlVFIzb2NpQVJD?=
 =?utf-8?B?S3cxb0xRdFg1SDVRaG0wUDlEcmhUZWNKeVdxNnBhMExTWGgzdnpYemZLU3Nw?=
 =?utf-8?B?bCt0ZTg3YUgzY25Fa2prdXBFZUVzS05Tbkx2QitEYWtJSXlhVDRBQyt3MVVw?=
 =?utf-8?B?LzB5MHZNa25xL3RBSWthYkx0ZzFiT2RscHVtKzVxOEdidTlOMENQdkUycW9N?=
 =?utf-8?B?bTJyUWNpTVVpUTFoSGNvdks4QlJkVnZ5cHBGeGxmbG55QTdUNHg1RjRNdzVM?=
 =?utf-8?B?OUV3VnBXYkZKZVNRV3dGdEpvb1Y2WkttOU1nbThPOVpvaGR2QlNuSHUvTzAr?=
 =?utf-8?B?aG8vT29iUDlieFdGc3lETnI2MGpnWjhpbVY1YUUvUCtKUC80UlplVFZyM3NI?=
 =?utf-8?B?VFJsSEtnRk1FQTR0U2ZsTThUTjJ6OWNQb1A1K20wNFB6WTk3aG9NNG4vZFdz?=
 =?utf-8?B?b0ErdFlFVktHMWZtd3VBVTFSNTM5MzBuSjBsVEJ5WDlKazh4YlVMRkNtVVo4?=
 =?utf-8?B?K2hPckdQNE1vL0p0OW4rM3I0WXMrRm16bllIVzJJS3NHdE5xYjVMemNNcVhJ?=
 =?utf-8?B?UmI3N29Uc0M1aW1lVnowZG9UaGJMaGFNUHdnbDE4YVhTVTM1ZjkyYVFZR1M3?=
 =?utf-8?Q?2OM2d0LzSWzxUVLqxS+LCm4k40dBf8bgXMhCE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dU9JL25pMWhucFl5M1NweEEyWlp0YXBwVmEzN3ZPQkx3ait0dlhwYXU0VE1h?=
 =?utf-8?B?SkxRdjlkVGhtUnlZVUJ6T2ZMTDROMzhoaDRPdzNJRzNBVE1DeGxSVUFlZWJQ?=
 =?utf-8?B?cEZaU2JBcWtZc0YvbE9MR25aMm5VTnJ5cXN3ODBIeWc0bkw5bXYzdHZtTDAw?=
 =?utf-8?B?WEZ6NUdobzZSRndlYVBSam9KN3lYUStqNUJGV0VCd2s0ZENRcnJORFdTUjVN?=
 =?utf-8?B?T2x2ODd5bmFpQWlxTGtsQ1FRcmwya0svblhlT0tQSGNQcnN1b1pUdnZBenlU?=
 =?utf-8?B?SFkrWXp3TFI2eGM1S0hUMW96ZDRiK2hyUndkWHQrTjZjQjBic3B0T0E5a1dU?=
 =?utf-8?B?bllrVTNtL3cxWWZPeE5acVE2RGoyNTE3bU0rUzg2dkpvUFZuWHluNVBOZGxx?=
 =?utf-8?B?Vm5JVlJTYXZUd2FGd2RSdERSbUZGYTlqZDE0SGsxUWZkeGhJUVEvOFd6SzNY?=
 =?utf-8?B?ak40TGFQb1lROVYzbnRZVVFISFoyRm5uSzdXK1ErcjFTWDRpUjlCTWJhTkp3?=
 =?utf-8?B?Ni9vRklTRTVyMmJNRUlWcTZTVVh0d2x1TTUxRDAwVUtWdVBuTW5FRTNvTk85?=
 =?utf-8?B?bTY3dnRlYXJPYnFXQnRhaXdpalNGNHVIbU1ualI1K3lPc2VNcUMrTFdTQXNM?=
 =?utf-8?B?N0xUYTBKVHZKenJ1OUk1MUduR1Qrbml0SHUvZUJHcUo2S2xDVitYVFZ1eC9y?=
 =?utf-8?B?T04vRWdVdC8vVkZYbWdSV0ZJKytQMDZxSlV6UExLZnRnNjZ3R05OaDI5SitO?=
 =?utf-8?B?bDF2eXE4NlA0dm00QS9rN3dGeWxDN1hTMUlrWUNLUmovUUtzSzNwK0gyZVpk?=
 =?utf-8?B?UVQ2TEoyc2ZRNVpxanMvaUxOMUlWRGNXYURJL3oxMHJ1SDI1enMwODdrRmo1?=
 =?utf-8?B?WlJJdDgyL0x5UkxiaVp3RGJSZ2lCNU04dkQ4eXJocnVoSHlhMXVHYzQzY1pF?=
 =?utf-8?B?cHNia3NwR0tRK3J6WTZqcUZSZ0cxeTBXUmFRb2JkemNvWURUL2ZJUGx2RHJq?=
 =?utf-8?B?L2lQVjNEL3BDeGdmY01RRHlEZ1R2c3F0UVZrZnNVOFBBcmFQTU9yZ2UrNzh4?=
 =?utf-8?B?ZGlQanFyc0VhWUxLYmhrWUs2MHR6ejJyRkVBZUd3dFJtbm4zems4UisxYlEr?=
 =?utf-8?B?eEpHLzQ4dXNvdjM5d3pXR1RCSkVsUlRMSmkxK1BNeFQxOG1SU1lzZy96MUdO?=
 =?utf-8?B?WHVkMWNwTkx3cXNOK3JxU3RDeXphR25lVmpyem15UkxFcHc2bENQa0tvOE9z?=
 =?utf-8?B?RXNMUEYyOStEcENNY3U4N3Z1UG0vSzI1TUEwNXFWUU45VGV6UnhvbkpqZzVq?=
 =?utf-8?B?TTJkN3VTY1MyV1Y5TXlJUUJ1aFhQTVBwS3BmZnc5NkNkOEdpci8wbnhyZGVh?=
 =?utf-8?B?QVV1cFhNYnhrR2JkUDR6eEF4ckN0MmtqMkdMdEROK2VRdEgwMHBEVW1pZHE0?=
 =?utf-8?B?WVBFYWhKWlBLMGlZOGpsc3F2YmhyRFQ2NjhHejlHdzZNSmdSRmxlU0x6TWsz?=
 =?utf-8?B?UXNwVmtENVZPMVNyd0FyOUtKR0tGbUI3TVIvR3hjTng2cDdscHVTSVp5ODUv?=
 =?utf-8?B?MFp0ai8vOUZkckhwcVVGc3FKeEFUTXh0QWZ3eWVWUW5xMXlEWGgzMVc1VGJM?=
 =?utf-8?B?empRN2tVKyt4OGdneklBSFJPNlBGMHZvak41RmpXdURFUHBsMDVWM1B0eHJS?=
 =?utf-8?B?dkZ2dXoxSUZtYVRoQjQ3QS9LaUNNNjF3NE9GTTJ1dmlwektxSVdFNml5Wjdi?=
 =?utf-8?B?REs2NHpMeVI1YlVJNzd4RFJGRGhOcFF0U29pazFhaDlGcjBFQndaZGVUWkdt?=
 =?utf-8?B?S0x1cVRzVEl6a25vY3NYOEFUVUhMQlUrcXhtSVl2aGNyNDVoVmIxT3J6OWVD?=
 =?utf-8?B?Zk1OSnZVQVBQRjFzcGxVTVVmeTJlcHJGM2NmWmhLSjFYSDlOM1lxaURod2dy?=
 =?utf-8?B?YUNHTzY1ZHErWjJtazlzSERPVUhzQlBzelZ4eGNZbExEOHBKbVRnbXpQOHBB?=
 =?utf-8?B?QS82bWprZGdabWlmdnE0amVidTFDNUl3NDlxVFdRczJSS0VhNDBleE9sRWpj?=
 =?utf-8?B?bnJuVWJ1aW9QcSt4ajc1SExlNExpS1g3T1psK1RtN2FzWG55YVhIcGdJWHBh?=
 =?utf-8?Q?KTg/ShovmeKjeK8LHbRwXunat?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D52EF002D6C9664E881A100FFCEFC7F7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d10efd6-b120-494d-9fcc-08dc8a7fe8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2024 01:35:15.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eeO+HsGuyG76BXLNjgxZnkIa3NIpTEbQaYsHHaXLaKo2fwF5OgYWizwfC59MLbi5j1naK68ON/KoMO9nC7D7vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8149

SGksIFNoYXduOg0KDQpPbiBUaHUsIDIwMjQtMDYtMDYgYXQgMTc6MjYgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29tPg0KPiANCj4gV2UgY2hvb3NlIE9WTCBhcyB0aGUgQ1JDIGdlbmVyYXRvciBmcm9tIG90aGVy
IGhhcmR3YXJlDQo+IGNvbXBvbmVudHMgdGhhdCBhcmUgYWxzbyBjYXBhYmxlIG9mIGNhbGN1bGF0
aW5nIENSQ3MsDQo+IHNpbmNlIGl0cyBmcmFtZSBkb25lIGV2ZW50IHRyaWdnZXJzIHZibGFua3Ms
IGl0IGNhbiBiZQ0KPiB1c2VkIGFzIGEgc2lnbmFsIHRvIGtub3cgd2hlbiBpcyBzYWZlIHRvIHJl
dHJpZXZlIENSQyBvZg0KPiB0aGUgZnJhbWUuDQo+IA0KPiBQbGVhc2Ugbm90ZSB0aGF0IHBvc2l0
aW9uIG9mIHRoZSBoYXJkd2FyZSBjb21wb25lbnQNCj4gdGhhdCBpcyBjaG9zZW4gYXMgQ1JDIGdl
bmVyYXRvciBpbiB0aGUgZGlzcGxheSBwYXRoIGlzDQo+IHNpZ25pZmljYW50LiBGb3IgZXhhbXBs
ZSwgd2hpbGUgT1ZMIGlzIHRoZSBmaXJzdCBtb2R1bGUNCj4gaW4gVkRPU1lTMCwgaXRzIENSQyB3
b24ndCBiZSBhZmZlY3RlZCBieSB0aGUgbW9kdWxlcw0KPiBhZnRlciBpdCwgd2hpY2ggbWVhbnMg
ZWZmZWN0cyBhcHBsaWVkIGJ5IFBRLCBHYW1tYSwNCj4gRGl0aGVyIG9yIGFueSBvdGhlciBjb21w
b25lbnRzIGFmdGVyIE9WTCB3b24ndCBiZQ0KPiBjYWxjdWxhdGVkIGluIENSQyBnZW5lcmF0aW9u
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRp
YXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiAgDQo+ICB2b2lkIG10a19vdmxfc3RvcChz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+IEBAIC00ODksNiArNTc5LDgzIEBAIHZvaWQgbXRrX292bF9s
YXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCSAg
ICAoc3RhdGUtPmJhc2UuZmIgJiYgIXN0YXRlLT5iYXNlLmZiLT5mb3JtYXQtPmhhc19hbHBoYSkp
DQo+ICAJCWlnbm9yZV9waXhlbF9hbHBoYSA9IE9WTF9DT05TVF9CTEVORDsNCj4gIA0KPiArCS8q
DQo+ICsJICogT1ZMIG9ubHkgc3VwcG9ydHMgOCBiaXRzIGRhdGEgaW4gQ1JDIGNhbGN1bGF0aW9u
LCB0cmFuc2Zvcm0gMTAtYml0DQo+ICsJICogUkdCIHRvIDgtYml0IFJHQiBieSBsZXZlcmFnaW5n
IHRoZSBhYmlsaXR5IG9mIHRoZSBZMlIgKFlVVi10by1SR0IpDQo+ICsJICogaGFyZHdhcmUgdG8g
bXVsdGlwbHkgY29lZmZpY2llbnRzLCBhbHRob3VnaCB0aGVyZSBpcyBub3RoaW5nIHRvIGRvDQo+
ICsJICogd2l0aCB0aGUgWVVWIGZvcm1hdC4NCj4gKwkgKi8NCj4gKwlpZiAob3ZsLT5kYXRhLT5z
dXBwb3J0c19jbHJmbXRfZXh0KSB7DQo+ICsJCXUzMiB5MnJfY29lZiA9IDAsIHkycl9vZmZzZXQg
PSAwLCByMnJfY29lZiA9IDAsIGNzY19lbiA9IDA7DQo+ICsNCj4gKwkJaWYgKGlzXzEwYml0X3Jn
YihmbXQpKSB7DQo+ICsJCQljb24gfD0gT1ZMX0NPTl9NVFhfQVVUT19ESVMgfCBPVkxfQ09OX01U
WF9FTiB8IE9WTF9DT05fTVRYX1BST0dSQU1NQUJMRTsNCj4gKw0KPiArCQkJLyoNCj4gKwkJCSAq
IFkyUiBjb2VmZmljaWVudCBzZXR0aW5nDQo+ICsJCQkgKiBiaXQgMTMgaXMgMl4xLCBiaXQgMTIg
aXMgMl4wLCBiaXQgMTEgaXMgMl4tMSwNCj4gKwkJCSAqIGJpdCAxMCBpcyAyXi0yID0gMC4yNQ0K
PiArCQkJICovDQo+ICsJCQl5MnJfY29lZiA9IEJJVCgxMCk7DQo+ICsNCj4gKwkJCS8qIC0xIGlu
IDEwYml0ICovDQo+ICsJCQl5MnJfb2Zmc2V0ID0gR0VOTUFTSygxMCwgMCkgLSAxOw0KDQpJIGRv
bid0IGtub3cgd2h5IGRvIHRoaXM/IElmIGFuIGlucHV0IHZhbHVlIGlzIDB4MTAwLCB0aGVuDQoN
CjB4MTAwIHJpZ2h0IHNoaXQgMiBiaXQgYmVjb21lIDB4NDAuDQoweDQwIC0gMSA9IDB4M2YuDQow
eDNmIGxlZnQgc2hpZnQgMiBiaXQgYmVjb21lIDB4ZmMuDQoNClNvIGlucHV0IDB4MTAwIGFuZCBv
dXRwdXQgMHhmYy4gV2h5Pw0KDQo+ICsNCj4gKwkJCS8qDQo+ICsJCQkgKiBSMlIgY29lZmZpY2ll
bnQgc2V0dGluZw0KPiArCQkJICogYml0IDE5IGlzIDJeMSwgYml0IDE4IGlzIDJeMCwgYml0IDE3
IGlzIDJeLTEsDQo+ICsJCQkgKiBiaXQgMjAgaXMgMl4yID0gNA0KPiArCQkJICovDQo+ICsJCQly
MnJfY29lZiA9IEJJVCgyMCk7DQo+ICsNCj4gKwkJCS8qIENTQ19FTiBpcyBmb3IgUjJSICovDQo+
ICsJCQljc2NfZW4gPSBPVkxfQ0xSRk1UX0VYVDFfQ1NDX0VOKGlkeCk7DQo+ICsNCj4gKwkJCS8q
DQo+ICsJCQkgKiAxLiBZVVYgaW5wdXQgZGF0YSAtIDEgYW5kIHNoaWZ0IHJpZ2h0IGZvciAyIGJp
dHMgdG8gcmVtb3ZlIGl0DQo+ICsJCQkgKiBbUiddICAgWzAuMjUgICAgMCAgICAwXSAgIFtZIGlu
IC0gMV0NCj4gKwkJCSAqIFtHJ10gPSBbICAgMCAwLjI1ICAgIDBdICogW1UgaW4gLSAxXQ0KPiAr
CQkJICogW0InXSAgIFsgICAwICAgIDAgMC4yNV0gICBbViBpbiAtIDFdDQo+ICsJCQkgKg0KPiAr
CQkJICogMi4gc2hpZnQgbGVmdCBmb3IgMiBiaXQgbGV0dGluZyB0aGUgbGFzdCAyIGJpdHMgYmVj
b21lIDANCg0KWW91IHRydW5jYXRlIHRoZSBsYXN0IHR3byBiaXQsIHNvIHNvbWUgcXVhbGl0eSBs
b3N0LiBJIHRoaW5rIHRoZQ0KcXVhbGl0eSBpcyBtYWluIGZ1bmN0aW9uIGFuZCBDUkMgaXMganVz
dCBmb3IgZGVidWcuIFNvIGl0J3MgYmV0dGVyIHRoYXQNCmluIG5vcm1hbCBjYXNlIHdlIGtlZXAg
cXVhbGl0eSBhbmQgb25seSBmb3IgZGVidWcgdG8gbG9zdCB0aGUgcXVhbGl0eS4NCiANCkkgaGF2
ZSBhbm90aGVyIHF1ZXN0aW9uLiBZb3UganVzdCB0cnVuY2F0ZSB0aGUgbGFzdCB0d28gYml0IGJ1
dCBpdCBpcw0Kc3RpbGwgMTAgYml0IHZhbHVlLCBzbyBDUkMgY291bGQgY2FsY3VsYXRlIHRoaXMg
MTAgYml0IHZhbHVlPyBJIGRvbid0DQprbm93IHdoeSB5b3Ugc2F5IENSQyBqdXN0IGZvciA4IGJp
dD8NCiANClJlZ2FyZHMsDQpDSw0KDQo+ICsJCQkgKiBbUiBvdXRdICAgWyA0ICAwICAwXSAgIFtS
J10NCj4gKwkJCSAqIFtHIG91dF0gPSBbIDAgIDQgIDBdICogW0cnXQ0KPiArCQkJICogW0Igb3V0
XSAgIFsgMCAgMCAgNF0gICBbQiddDQo+ICsJCQkgKi8NCj4gKwkJfQ0KPiArDQo+ICsJCW10a19k
ZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgeTJyX2NvZWYsDQo+ICsJCQkJICAgJm92bC0+Y21kcV9y
ZWcsIG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1kyUl9QQVJBX1IwKGlkeCksDQo+ICsJCQkJICAg
T1ZMX1kyUl9QQVJBX0NfQ0ZfUk1ZKTsNCj4gKwkJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0
LCAoeTJyX2NvZWYgPDwgMTYpLA0KPiArCQkJCSAgICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3Ms
IERJU1BfUkVHX09WTF9ZMlJfUEFSQV9HMChpZHgpLA0KPiArCQkJCSAgIE9WTF9ZMlJfUEFSQV9D
X0NGX0dNVSk7DQo+ICsJCW10a19kZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgeTJyX2NvZWYsDQo+
ICsJCQkJICAgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1kyUl9QQVJB
X0IxKGlkeCksDQo+ICsJCQkJICAgT1ZMX1kyUl9QQVJBX0NfQ0ZfQk1WKTsNCj4gKw0KPiArCQlt
dGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIHkycl9vZmZzZXQsDQo+ICsJCQkJICAgJm92bC0+
Y21kcV9yZWcsIG92bC0+cmVncywgRElTUF9SRUdfT1ZMX1kyUl9QQVJBX1lVVl9BXzAoaWR4KSwN
Cj4gKwkJCQkgICBPVkxfWTJSX1BBUkFfQ19DRl9ZQSk7DQo+ICsJCW10a19kZHBfd3JpdGVfbWFz
ayhjbWRxX3BrdCwgKHkycl9vZmZzZXQgPDwgMTYpLA0KPiArCQkJCSAgICZvdmwtPmNtZHFfcmVn
LCBvdmwtPnJlZ3MsIERJU1BfUkVHX09WTF9ZMlJfUEFSQV9ZVVZfQV8wKGlkeCksDQo+ICsJCQkJ
ICAgT1ZMX1kyUl9QQVJBX0NfQ0ZfVUEpOw0KPiArCQltdGtfZGRwX3dyaXRlX21hc2soY21kcV9w
a3QsIHkycl9vZmZzZXQsDQo+ICsJCQkJICAgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywgRElT
UF9SRUdfT1ZMX1kyUl9QQVJBX1lVVl9BXzEoaWR4KSwNCj4gKwkJCQkgICBPVkxfWTJSX1BBUkFf
Q19DRl9WQSk7DQo+ICsNCj4gKwkJbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCByMnJf
Y29lZiwNCj4gKwkJCQkgICAgICAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLCBESVNQX1JFR19P
VkxfUjJSX1IwKGlkeCkpOw0KPiArCQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIHIy
cl9jb2VmLA0KPiArCQkJCSAgICAgICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsIERJU1BfUkVH
X09WTF9SMlJfRzEoaWR4KSk7DQo+ICsJCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwg
cjJyX2NvZWYsDQo+ICsJCQkJICAgICAgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywgRElTUF9S
RUdfT1ZMX1IyUl9CMihpZHgpKTsNCj4gKw0KPiArCQltdGtfZGRwX3dyaXRlX21hc2soY21kcV9w
a3QsIGNzY19lbiwNCj4gKwkJCQkgICAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLCBESVNQX1JF
R19PVkxfQ0xSRk1UX0VYVDEsDQo+ICsJCQkJICAgT1ZMX0NMUkZNVF9FWFQxX0NTQ19FTihpZHgp
KTsNCj4gKwl9DQo+ICsNCj4gIAlpZiAocGVuZGluZy0+cm90YXRpb24gJiBEUk1fTU9ERV9SRUZM
RUNUX1kpIHsNCj4gIAkJY29uIHw9IE9WTF9DT05fVklSVF9GTElQOw0KPiAgCQlhZGRyICs9IChw
ZW5kaW5nLT5oZWlnaHQgLSAxKSAqIHBlbmRpbmctPnBpdGNoOw0KPiANCg==

