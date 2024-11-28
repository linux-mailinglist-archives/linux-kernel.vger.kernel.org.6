Return-Path: <linux-kernel+bounces-424217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D56E49DB1B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9569D282536
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62F85628;
	Thu, 28 Nov 2024 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n4N9iyfl";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CAmgpa86"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E7B83CC7;
	Thu, 28 Nov 2024 03:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732763336; cv=fail; b=oJnd0ka0nxjfOwvQB0TV4GVxFC4a8IaGv9XQN/Cy/EVorh48iTHcEcMtmMrmOpKfQeO1UQdUkLE2q43VyuqjnGaILvkPpIm0xKs7KSU64z/FOkQsI+jywbHvPUqxXOfNNATh0A2jzZ9NSP9wl53BrJrYrpobCwuLMnI3Ku/jseI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732763336; c=relaxed/simple;
	bh=+H+emhJEqS4wxxdsWf1ms2jUyayZ9YlHDVmPO585euA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LY1AKeXvQvT5pqtioAjt9Pyl6LOTNX8EgePOjGQtfE1Xq6NXr46KtPTnybwRjJelrXw2bmye0U/CTl/hpotzZ8NLNXkOoBESpvMjsxcywFu9lnW5ODYFyYyFidLEL40uvXdae0o8pxQJL4I+BoIeNNnACTTVHKGxqx7wPf+qpQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n4N9iyfl; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CAmgpa86; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 13a52f48ad3611efbd192953cf12861f-20241128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+H+emhJEqS4wxxdsWf1ms2jUyayZ9YlHDVmPO585euA=;
	b=n4N9iyflJAnirwEvWYe9AuNxiHLjO2HG26sTPEHY0O4KM/9GXlTsmQ93f5E+ce4onVtdsEFzBibbi2LItXmaUJGe0fIpH0WScK6HIH+bTHFKG+H9+rzR4BJ4lD9rVjGDvJ0Ww8kpCQpfO6rlZuWvnWFxCn13hhGwnOI9dVUN7ZA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:7ab09404-cbaf-4cba-8288-512916c075c1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:a25683b9-596a-4e31-81f2-cae532fa1b81,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 13a52f48ad3611efbd192953cf12861f-20241128
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1555423102; Thu, 28 Nov 2024 11:08:44 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Nov 2024 11:08:42 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Nov 2024 11:08:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV0gLBz8JfwyzTxLa/I6HPAMWNTuCDURGiLFAX2c6BzJ1SiYNpJr1AWFpS1dt56pdom0YfH1XZ4UcMzfRD8EzZQ8jOiQTbsfqbeUXRllwDS0mNgapGtKAiB6gdvNq8glam5ra58tLOLuwSa10nOw8SMGzgZ1zsEzKwloI6CwfvujcFqam4j+4GRYjtaSRBmK5h0dAy1mT6pYIL4ZWYayKdNMNpZMUapwrl/2sTyFrZCWtLIidahgacguALidLxtFPsn5KDcsNBDyB1d/XY8emIfO2JYmmtDafTbNpAavoOx48EtU1+PjP/HCC52oUDNFeFVCBRYBsNKADQIxmiEY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H+emhJEqS4wxxdsWf1ms2jUyayZ9YlHDVmPO585euA=;
 b=kpEf3GepqwEZjsgdWue4XuRnVe+iQqqMgKmRs4XquchxThrDwpNIUsUbtR0FxCQeDsXUOh75Hy9NAgDXUtYAxgAbfqJeNlgktnDAGu/cgl746MI6Q6qeehYLsd32s19OMIWcjNcKA9H7Gxx8HHkYk3WBTaCkwYvyyiGEem9wDzYyfO3GsRLL5YHuRTly3lUw7igCxuMPg0Mqhxb4rbceI4CzK60j0Q1e2URS4G3EGLEKIPbQ7HfHf+deLmrW/g4arxP7OzTeGcImB3r5/bi1tW9rpuFfDBOGGeeduYtINH6kCiQi0Z7gu4V6QJ6/c/VW+e9QsQ28AHem/BImifixuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H+emhJEqS4wxxdsWf1ms2jUyayZ9YlHDVmPO585euA=;
 b=CAmgpa86NjKv3oC/BIgyoOkC+4xxFZzFN8yyvM/d23qTTMBfNUTzgD4PveTC+T6pwtbqAn1E8130P0DXDBuOLU8+2njM+Cl4J57jLBHDNM7KYXTCywuc6ZB2Uyf1DB8py04bf56UioU1KcHHTW8vQo4xt0wnFWtRuj+rcaoGmJ4=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7200.apcprd03.prod.outlook.com (2603:1096:820:db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 03:08:36 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8182.018; Thu, 28 Nov 2024
 03:08:35 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "kernel@collabora.com" <kernel@collabora.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 6/6] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Topic: [PATCH v1 6/6] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Index: AQHbO0o2kTOzG2fD30avrRutQMN1rbLC6GCAgAVWuwCAAKrhAIAAaa0AgAFqXYCAABvBgIAABmoAgAA9fYCAAPFcAA==
Date: Thu, 28 Nov 2024 03:08:35 +0000
Message-ID: <84e688fed290a112b3a95767c5ee1f0e5677ac06.camel@mediatek.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
	 <20241120124420.133914-7-angelogioacchino.delregno@collabora.com>
	 <1b966a136f02b5586749a9c3d0bcec6c75224e49.camel@mediatek.com>
	 <33acccd3-e543-493e-a61c-282d894ef2b1@collabora.com>
	 <fd48c582e99d6c07be4b66919fb6c309379ad752.camel@mediatek.com>
	 <f1d16db0-a7e1-4cfd-85c6-8beef4385701@collabora.com>
	 <a8ca9d1314f12dbb95ac4e4b9e8929adab35eaba.camel@mediatek.com>
	 <8e70d921-1420-4a57-a994-dc28abda25b7@collabora.com>
	 <c46751894d01194d89da6c164b47a59cd1e86bb6.camel@mediatek.com>
	 <23563d73-7de1-4316-9dd8-25ae6d66a8de@collabora.com>
In-Reply-To: <23563d73-7de1-4316-9dd8-25ae6d66a8de@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7200:EE_
x-ms-office365-filtering-correlation-id: 34bdcdc6-e0b6-4c7b-07f4-08dd0f59f27f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SW1KbXU3bVpGQUdvd2pLVTA1SDE4SGtpZjNXeGpMSzJ0SFFmUXFUSjRJS2RY?=
 =?utf-8?B?NVdmV0ZIQkZ3SFNCVUpERHh1T2FZYzdZKzJYTEZSeE1DVWR5MThrZ1A4aHYr?=
 =?utf-8?B?dStMRjRsNFpmbGxlR0JSSXdxN2NURmJNM0VoTXBZTG03cVB1RnlVVFJBWTNz?=
 =?utf-8?B?Y3ZBRXh2MXJveldKQXdNUE1XOXZyMmtwcUVhYlVMUmd0WUg0UUZHTWh4WjU3?=
 =?utf-8?B?dzRlNCtvbTBjUzFMVEJ1b0RoNE51SUVCUXMyRE9DdHlvcmp0SGpQSWFVRWdm?=
 =?utf-8?B?dHdlcWJUclU5dENzVll5WjhDZUlxbmFRMXBmUHBBMytNOG9UaWN4cGIvbTM1?=
 =?utf-8?B?VjZmMW04OC9GOTZkaGdIcDlOVkEvQzgrRFFSZ1lpNUJpbEZQVE45VHEwQzFz?=
 =?utf-8?B?OUlJdFRXNktoK0JRWmFRc2VIZDdaYm9WaHlZb2hkeVBXWURIa29XSzNNZ3FB?=
 =?utf-8?B?eUtLN29rV3hEVjNuY205d05weGxHeHFydU1vN0ZCUVRnMjhVam1ZcS96Ty9X?=
 =?utf-8?B?RFIxZmNiMUVXLzFraHJrZEt5U3VFeGdpTFJ3M3hYeDMrTWFUdU0zWjZlTTZx?=
 =?utf-8?B?YWwxVXdyWW1kU1Z5WTVtbTd4Q3VwODdIV2pZZkl6NEhVSU9VQU1tOVRlSjF6?=
 =?utf-8?B?NUx2YVNSQjh4NEszZzhoeEhIZkhXemxEbGdxd0ZkL0VIMXlBQ1ZCOFUrN3cy?=
 =?utf-8?B?VkNLaFpFVnZweVBWUTVseWhvUkhuME5tOG15WDVqTDJOVlB5M2R2V0pVSjFo?=
 =?utf-8?B?NnNCMlJLdWxzejlBNFRGNUg5N2VDZUtWYnJTNFg0UXlhOTFRTjEzbmxheXVa?=
 =?utf-8?B?eHFPK1RGRVd6akpYdThOdElYTXYwbC91UzJualVpY1dqeDM0RXFITlBYYWtG?=
 =?utf-8?B?M1pnSUVPNHAxdFdhY0xxSVM4TUsrb29FQTA1Tlh2cm1mYmMxQm44SElKM2NZ?=
 =?utf-8?B?MENRZjBKODJMc3dLZjcrcThQS3VFTS9hVkVrTEZaOG1tQjBJbDcvKy9JWUFM?=
 =?utf-8?B?NE5kb2xGRGpRZTBTMzYwT0ZWSi9RRVgzbEc4cmNDMFcyLzJ4dzdSL0tvTDJl?=
 =?utf-8?B?VjBscU9zSlozYVNuOUFpZUQ2MGVabHFXZ2c2aG1FNmx0RFhLRHRSNm55RlhQ?=
 =?utf-8?B?bG9KODkxQ1loeDBiUzNnb3NOTE1LMTc2ZDR2OW9uYkU0OFJoMmFMT0Q2QURy?=
 =?utf-8?B?WXpSblo4RndFeVdNMUxkbTBUOWdVOHFrK2NIRWdvcnBxN0wzamh6WkYvQ3py?=
 =?utf-8?B?NVJKRzE1OFJ6dEZORkpFazdDTGZ1aGxQUHZ1RWtzU2E3eUhySnZtUTVsVjNw?=
 =?utf-8?B?SlhHMW15UlRIeHlPV28xMmtsZHpuMUloNEMrREZDdytrd2NWS2JzSGxQektU?=
 =?utf-8?B?Ky9jdFR2aGtoUnkzcXkza296VjFEdjVDUFVpZVQraDFOcHoxUVFpVzlQcmph?=
 =?utf-8?B?dUxQRzcvai80T1JEVk5EazZvQ0szTUE2MllGZXpsc2F4T28zcFF4eCswMk9U?=
 =?utf-8?B?bDVETDhocTk4OHZtck9JZk1ySWxiUUVTTzBFTDVoSGpjUGxzRlhPajZNUjkz?=
 =?utf-8?B?WDA3dlhNbDJyVkdUc3ZRRWhEY1c0dThtY3oyYkJLcFJjc3g2VllIV0V6dUxL?=
 =?utf-8?B?VjJ2ZHA0VnNoYzdkWGNXOUJGZ2xLaXdPTGdIRFJ0U3BMYlA1TFFyL3JmYVdk?=
 =?utf-8?B?N3lPMGcwczRQTXk4MHdQQWtGb25KckpMakxyN2FQS3IyMmdOckVBKy9Mc1p5?=
 =?utf-8?B?UzUxdmQ4QmZjUjU3SjlBQjdueExnaWY4UU13aTZ4R0c0ODBKblN6ajAvVFRm?=
 =?utf-8?B?cm9DYlJDVzFxakp4enVBKzh6OE5hM2pSUkVHU3dDUnZ3d1k4amozaGZDSmJj?=
 =?utf-8?B?ZzFuQ09hQW1DVy9Pc2sxSCtLOWtaQVBtbmtYNXd2SGNhS1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVdCc2d5YVRsdzRMcDhGdmRPUmVTOCtvYVhMZlI5WmFCT0ZMdU9PaWw4cGZM?=
 =?utf-8?B?MnF3TG96ZTU5VWFXZlZLTE00dkRWRW10SlVtMEFCVDNwc0tRVGJtenBNNmJr?=
 =?utf-8?B?VzE5UGpiQURQcXVxUnJjRmFYalFrYy9ySGt5Qm9DOXp2RU00T2JCaHZLaVZX?=
 =?utf-8?B?MWdDdG1uVlJwUG1TdHNHK201Z2ZGVzVQdFdJcU9hS0hxOXVXRzYxeDAxS1JK?=
 =?utf-8?B?QU4zVzIzVjQ3OENLTW00a2N1U3lpNysvSFAydWlCNzhXUVV6MCtrMlFGWHMy?=
 =?utf-8?B?WGRSeUg4WlNqcVhFN0h1QmF6d1FJZ2dPZGZVdm1SdlVSYmVnODZFcHBjR2J6?=
 =?utf-8?B?MTJWaVphb1BDdDVhWFpOK1MyNXhBazJpeWlTT1RmUzl0K3hmWTNTSHp1SmdL?=
 =?utf-8?B?SU53WFNscEdKS3VJbEJneFNmbTlEOGNUaXQ3dFVOYXlrWVovQzFJR0xHdXVl?=
 =?utf-8?B?U0tCUUxtUWZxWWhqb2hLcjduM3ZTSWtFYUI1d1daSVdSdnJZSlRNSEpHajRt?=
 =?utf-8?B?TUZOTS9RRUVubXFvTzZucldBcms2cm1FdHpqWm9ybit0dnBTMnl0eURlU3ow?=
 =?utf-8?B?bzZCMDN0cEtPd0dLK1ZhemdJeEp2SzNTK2l3UlRMbUtxaWwrTm83ZHRXNUZp?=
 =?utf-8?B?RmtoSXdUUkxGckpXbzlyWWp6Tk1EVWx6YmFOYkx4YzhqYjV6WTVCWnh0R2xa?=
 =?utf-8?B?czZLeWlRNmw1cVBQWXpmSzA3MGQwd29NZXVUdmRDOFcrLzgzOXp0NEZId2tT?=
 =?utf-8?B?OTI2dTM5UWdTUnFZcE5JOVBHMklNWGdTYmRQVlYvZTJFZHVqeXltWEZRZC9t?=
 =?utf-8?B?cklvaDdpZTR6N0NRZllsSm1uclhiUGY5Umxuem1acm56ZFhMV1hHMStsalg5?=
 =?utf-8?B?UTdXVEVocmpOZ0NXQXJXQ0JYVTJRVlJTZ0wzMGIzejNYTTV3a2d5eFRacmxv?=
 =?utf-8?B?dW5TMjdDejlKank5SFAySUZZYWtCS1pTc2VYYzhDblBuZGpNSWw5U2dWSWlB?=
 =?utf-8?B?dzVETXpzd21rVlJSbkhqVzZXbVBSWlh1a1k3QW9FZUc0Z0dZdkU0a1lRa3dE?=
 =?utf-8?B?WnVYb01QcGl1cElOQ0ZDKzdxT1gyNTIxTEhEQjFsUTNLMWlic3NuYzEyeEZU?=
 =?utf-8?B?T1hpZklDemx1Z2ErVW55ZS8rczVXdU9IL1dwRVdSMFIxK0tFd0pXNmxRZ1Vn?=
 =?utf-8?B?RW9Cb2pZTXpYRWtrMTk5YkY2ZFdtWnoyQXc2Rm9ubVRhSHlyY09ScEt3aWZI?=
 =?utf-8?B?UzhtQ2haSmRhS05PZ3FZSHBLVkhlR0NSTDNjVjE0Ukg1b2twQ1FUcm03QUpt?=
 =?utf-8?B?VWJ3dmZ4elZjV01zODZyWWs1d05lWTlqYi9NK2Rkdlk3UElKbExrdjhEdjFL?=
 =?utf-8?B?MkVidTA0WXlqcFIxVWw5NzVmMTh1bDNGVDNvV1BWQW40K25icDNIVXR5bTV4?=
 =?utf-8?B?b3AvUkx0SlV5WWlHK0FFS3FZajBHQmd5bXZESmtkOGhMMExyVk13MGxGNjBG?=
 =?utf-8?B?WDRsRGtKV0dOcU1hcE1DanVIY1hFOTZrNThYNlYvcktTNGdIMkhBZ1dQY3pO?=
 =?utf-8?B?b09EMGMxSmZVQllNYklIbTh6VEFnN0hoNEV4a0h5M3FJd1hLY3NGbGhUdE1V?=
 =?utf-8?B?d0tpTFBqRkZMY1k1ZEwrUEExMWd2bUkrZTBsbm1hTVJ5TW4rNGJiazhzNU1Q?=
 =?utf-8?B?bUt1OVJPT01IajFPV2w4bGIzdUFPMC9NbHlQcEMvSHk2Q0Z1WW1IdFVaQitD?=
 =?utf-8?B?RXhUOUpKcDlIbldDQzQvREsyaXNvdGN2QUNyVUc5dnZPYWdmZWIwRjY0QWV0?=
 =?utf-8?B?eXlYVVdsQ3dTRnlPMGNEbnc5eHNhaEpsSHlVbEcxTzhMeW1jQkdQOWJWQUxB?=
 =?utf-8?B?cUFBUFNDOHFSNlhFemloYXJ1eXRwbEZ1RXVIbHVuTjJmTXlSQWRSQW9SQWRv?=
 =?utf-8?B?c2xIOXplaVVSSXplVGxuR0FaS2dRL00vaXNOMEhKUXhMTU1ydktzZ2hJeU5G?=
 =?utf-8?B?R0g2S0tLOStqamNzR0x2ekpTMHR1NEdGUGMrRSt2LzAxYS9tQjVIakIyRXJi?=
 =?utf-8?B?aHdjdGpjOUhDV21iaUx6MWdFTjR6R0F0VEs5MjZTNysxL0N2aFFzdDNRMStl?=
 =?utf-8?B?eSsxRVhjVHB5RVc3TytaQUxTRDRFbWo2b2YyMHRXdG90UG1rRHUxWFNieHFL?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80BFC62EAABABF46861383A837FADE4E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bdcdc6-e0b6-4c7b-07f4-08dd0f59f27f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2024 03:08:35.0983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ognwIVvYQvHKuwSgG3sk8Q7FGGGacw1G8U9U1dlIhbJNacbehFkB2xiyHmSlFN1r7oz/TRqR9fDvjADGclxogg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7200
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.906400-8.000000
X-TMASE-MatchedRID: HLMPCFyIyBMNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCopoEWlZvizRmlaAItiONP35bNUY+JJjyFwpnAAvAwazxxE
	lGvP0lfjcjxfCJ/GHhhgY0ztehnm8D7+f/jfUYxK4jAucHcCqnRZO94uK1VSBKQU/vx3G/tFYLm
	JBTCeWS9/nCRCiwBYcO2RzUwv/GzdJ+HTEll5bHf28T9BUNXkhkos2tunL8DQs7eP5cPCWQ/4ZA
	Usty2ENDdtqlAQ6fUZoBua9UxitOnsRVu35DItMF6z9HGHKwNuSeMExjuIoEjg89vVcMJkhZfpd
	LFb2h+N9ix0TOFVSi7zzS1wmGiDmbqSoMCXyNc9H+PTjR9EWkm2siTY6Sb7GT7S4ZU4XTxD23ei
	pp00x0Q/EORUPdwthbINZznOfBoZL5MYokMFn1KoS9tQ2r9eNKx5ICGp/WtHDBRspsd0EVp/p67
	42jA2BtpeoLvx7Pywa/3L93pcpraLCTO1UKypv7spMO3HwKCD54F/2i/DwjXPBWZjlMys2HSkv+
	ZeqzYYVwDpMKlO5SvJPvVrIVFxiX5sgyCY2UIRU/2M0RAfTiq3iVpZ0luwMAOrNpiFyN5CEXLfI
	vVLr+JM3EUFaCCdDbovDue8/KO9hjejNb4SeB2Oho7buv7d9YarbRDQlpidHmP314UTbW2E5t75
	OP8zJF6VEy4BTWvHzN9NrZK7UuP9GLKYqqS4ongIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi4Hwn1p
	ZzW/9XKaQsz6vtVJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.906400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9A0A9C38161F603869A2A998BA68A4ACB770A8093D1404BCA51C048FC9371FF72000:8

T24gV2VkLCAyMDI0LTExLTI3IGF0IDEzOjQ0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyNy8xMS8yNCAxMDowNCwgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBPbiBXZWQsIDIwMjQtMTEtMjcgYXQgMDk6NDEgKzAxMDAs
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+IA0KPiA+ID4g
DQo+ID4gPiBJbCAyNy8xMS8yNCAwODowMiwgQ0sgSHUgKOiDoeS/iuWFiSkgaGEgc2NyaXR0bzoN
Cj4gPiA+ID4gT24gVHVlLCAyMDI0LTExLTI2IGF0IDEwOjI1ICswMTAwLCBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubyB3cm90ZToNCj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBk
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJp
ZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0K
PiA+ID4gPiA+IElsIDI2LzExLzI0IDA0OjA3LCBDSyBIdSAo6IOh5L+K5YWJKSBoYSBzY3JpdHRv
Og0KPiA+ID4gPiA+ID4gT24gTW9uLCAyMDI0LTExLTI1IGF0IDE3OjU1ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gRXh0ZXJuYWwgZW1haWwg
OiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJbCAyMi8xMS8yNCAwODoyMywgQ0sgSHUg
KOiDoeS/iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiA+ID4gPiA+ID4gPiBIaSwgQW5nZWxvOg0KPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IE9uIFdlZCwgMjAyNC0xMS0yMCBhdCAxMzo0
NCArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6DQo+ID4gPiA+ID4gPiA+
ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
ID4gPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgRFBJIGJsb2NrIGZvdW5kIGluIHRoZSBNVDgxOTUg
YW5kIE1UODE4OCBTb0NzLg0KPiA+ID4gPiA+ID4gPiA+ID4gSW5zaWRlIG9mIHRoZSBTb0MsIHRo
aXMgYmxvY2sgaXMgZGlyZWN0bHkgY29ubmVjdGVkIHRvIHRoZSBIRE1JIElQLg0KPiA+ID4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IEluIE1UODE3MywgRFBJMCBpcyBkaXJlY3RseSBjb25u
ZWN0ZWQgdG8gSERNSS4NCj4gPiA+ID4gPiA+ID4gPiBUaGUgZmlyc3QgdmVyc2lvbiBvZiB0aGlz
IGRyaXZlciBpcyBqdXN0IGZvciBNVDgxNzMgRFBJMC4NCj4gPiA+ID4gPiA+ID4gPiBEb2VzIE1U
ODE3MyBEUEkwIG5lZWQgdGhpcyBtb2RpZmljYXRpb24/DQo+ID4gPiA+ID4gPiA+ID4gT3IgdGhp
cyBtb2RpZmljYXRpb24gaXMganVzdCBmb3IgTVQ4MTg4IGFuZCBNVDgxOTUsIHRoZW4gdGhlIGRl
c2NyaXB0aW9uIHNob3VsZCBiZSBtb3JlIHRoYW4gJ2RpcmVjdGx5IGNvbm5lY3RlZCcuDQo+ID4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBUaGlzIGlzIG9ubHkg
Zm9yIE1UODE4OCBhbmQgTVQ4MTk1LCBhbmQgTVQ4MTczIGRvZXMgKm5vdCogbmVlZCBhbnkgbW9k
aWZpY2F0aW9uLg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gUGxlYXNlLCB3aGF0IHdv
dWxkIHlvdSBsaWtlIHRvIHNlZSBpbiB0aGUgZGVzY3JpcHRpb24gb2YgdGhpcyBjb21taXQ/DQo+
ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggZG9lcyBmb3VyIGpvYnMuDQo+ID4g
PiA+ID4gPiANCj4gPiA+ID4gPiA+IDEuIEVuYWJsZS9kaXNhYmxlIHR2ZF9jbGsgZm9yIE1UODE5
NS9NVDgxODggRFBJLg0KPiA+ID4gPiA+ID4gMi4gRG8gbm90IHNldCBwaXhlbCBjbG9jayBmb3Ig
TVQ4MTk1L01UODE4OCBEUEkuDQo+ID4gPiA+ID4gPiAzLiBOZXcgRFBJX0lOUFVUX1hYWCBhbmQg
RFBJX09VVFBVVF9YWFggY29udHJvbCBmb3IgTVQ4MTk1L01UODE4OCBEUEkuDQo+ID4gPiA+ID4g
PiA0LiBEbyBub3QgcG93ZXIgb24vb2ZmIGZvciBNVDgxOTUvTVQ4MTg4IERQSS4NCj4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gTWF5YmUgeW91IHNob3VsZCBicmVhayBpbnRvIDQgcGF0Y2hlcyBh
bmQgZWFjaCBvbmUgaGFzIGRpZmZlcmVudCByZWFzb24uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
WWVhaCBJIHRob3VnaHQgYWJvdXQgdGhhdCBhcyB3ZWxsLCBidXQgdGhlcmUncyBhIGZ1bmRhbWVu
dGFsIGlzc3VlIHdpdGggc3BsaXR0aW5nDQo+ID4gPiA+ID4gdGhlIHRoaW5nIGluIG11bHRpcGxl
IHBhdGNoZXMuLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGb3IgZW5hYmxpbmcgdGhlIHR2ZF9j
bGsgaW4gYSBzZXBhcmF0ZSBwYXRjaCwgdGhlcmUncyBubyBwcm9ibGVtIC0gaG93ZXZlciwgZm9y
IHRoZQ0KPiA+ID4gPiA+IG90aGVycy4uLi4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAxLiBXZSBu
ZWVkIHRvIGludHJvZHVjZSBzdXBwb3J0IGZvciBNVDgxOTUvODggRFBJLUhETUksIG9yIHRoZSBv
dGhlciBwYXRjaGVzIHdvdWxkDQo+ID4gPiA+ID4gICAgICAgbm90IG1ha2Ugc2Vuc2UgKG5vciBh
cHBseSwgYW55d2F5KTsgdGhlbg0KPiA+ID4gPiA+IDIuIFdlIHN0b3Agc2V0dGluZyBwaXhlbCBj
bG9jayB3aXRoIGFub3RoZXIgcGF0Y2g7IHRoZW4NCj4gPiA+ID4gPiAzLiB3ZSBkb24ndCBwb3dl
ciBvbi9vZmYsIGV0YyBldGMNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGUgcHJvYmxlbSB3aXRo
IGRvaW5nIGl0IGxpa2Ugc28gaXMgdGhhdCB0aGUgcGF0Y2ggIzEgdGhhdCBJIGRlc2NyaWJlZCB3
b3VsZCBiZQ0KPiA+ID4gPiA+IGludHJvZHVjaW5nICpmYXVsdHkgY29kZSosIGJlY2F1c2UgdGhl
IHN1cHBvcnQgZm9yIHRoYXQgcmVhbGx5IGRlcGVuZHMgb24gYWxsIG9mDQo+ID4gPiA+ID4gdGhl
IG90aGVycyBiZWluZyBwcmVzZW50IChvdGhlcndpc2UgdGhlIGJsb2NrIHdvbid0IHdvcmsgY29y
cmVjdGx5KS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBTby4uLiBpZiB5b3Ugd2FudCwgSSBjYW4g
ZWFzaWx5IHNwbGl0IG91dCB0aGUgdHZkX2NsayBlbmFibGUvZGlzYWJsZSwgYnV0IHNwbGl0dGlu
Zw0KPiA+ID4gPiA+IHRoZSByZXN0IHdvdWxkbid0IGJlIGNsZWFuLg0KPiA+ID4gPiA+IA0KPiA+
ID4gPiA+IEJlc2lkZXMsIGtlZXAgaW4gbWluZCB0aGF0Li4uIGFjdHVhbGx5Li4uIGZvciBhbnl0
aGluZyBlbHNlIHRoYXQgaXMgbm90IE1UODE5NS84OA0KPiA+ID4gPiA+IERQSTAgKHNvLCBmb3Ig
b3RoZXIgU29DcycgRFBJIGFuZCBmb3IgOTUvODggRFBJTlRGKSB0aGUgdHZkX2NsayBpcyBhbHJl
YWR5IGdldHRpbmcNCj4gPiA+ID4gPiBlbmFibGVkIGJ5IGl0cyBjaGlsZC4uIHNvLCBmb3IgdGhv
c2Ugb25lcywgYSBjYWxsIHRvIGVuYWJsZSB0dmRfY2xrIGRvZXMgZXhhY3RseQ0KPiA+ID4gPiA+
IG5vdGhpbmcgYXBhcnQgZnJvbSBpbmNyZW1lbnRpbmcgKGVuYWJsZSkgb3IgZGVjcmVtZW50aW5n
IChkaXNhYmxlKSB0aGUgcmVmY291bnQgZm9yDQo+ID4gPiA+ID4gdGhpcyBjbG9jayBieSAxLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoaXMgbWVhbnMgdGhhdCB0aGUgZW5hYmxlbWVudC9kaXNh
YmxlbWVudCBvZiB0dmRfY2xrIGlzIGFjdHVhbGx5IGltcG9ydGFudCBvbmx5DQo+ID4gPiA+ID4g
Zm9yIHRoZSBNVDgxOTUvODggRFBJIGFuZCBoYXMgbGl0ZXJhbGx5IG5vIGVmZmVjdCBvbiBhbnl0
aGluZyBlbHNlIHRoYXQgaXMNCj4gPiA+ID4gPiBjdXJyZW50bHkgc3VwcG9ydGVkIGJ5IHRoZSBt
dGtfZHBpIGRyaXZlciBhbnl3YXkuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU3RpbGwgLSBpZiB5
b3Ugd2FudCBtZSB0byBzcGxpdCBvdXQgdGhlIHR2ZF9jbGsgZW4vZGlzIHBhdGNoLCBqdXN0IGNv
bmZpcm0gYW5kIEkNCj4gPiA+ID4gPiB3aWxsIHNwbGl0IHRoYXQgb25lIG91dC4uLg0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBGb3IgIzEgYW5kICMyLCBJJ3ZlIG5vdCBy
ZXZpZXdlZCB0aGUgSERNSSBkcml2ZXIuIElzIHRoZSBjbG9jayBjb250cm9sIGluZmx1ZW5jZWQg
YnkgbmV3IEhETUkgZHJpdmVyLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEl0IGtpbmRhIGlzIC0g
dGhlIEhETUktVFggYmxvY2sgZ2V0cyBpdHMgY2xvY2sgZnJvbSB0aGUgSERNSSBQSFkncyBjbG9j
ayBnZW4sDQo+ID4gPiA+ID4gYnV0IGV2ZW50dWFsbHkgaXQgaXMgdGhlIEhETUkgZHJpdmVyIHRo
YXQgdGVsbHMgdG8gdGhlIFBIWSBkcml2ZXIgd2hhdCBjbG9jayBpdA0KPiA+ID4gPiA+IGFjdHVh
bGx5IHdhbnRzLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEZvciAjMSwgY2xrX3ByZXBhcmVfZW5h
YmxlKCkgaXMgdW5nYXRpbmcgdGhlIGNsb2NrIHRoYXQgd291bGQgb3RoZXJ3aXNlIGdhdGUgdGhl
DQo+ID4gPiA+ID4gUEhZJ3MgUExMIG91dHB1dCB0byB0aGUgSERNSSBibG9jay4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IElmIGl0IGlzIHNvZnR3YXJlIHJlYXNvbiwgbWF5YmUgd2UgY2FuIG1v
ZGlmeSB0aGUgbmV3IEhETUkgZHJpdmVyIGFuZCBtYWtlIERQSSBkcml2ZXIgY29uc2lzdGVudCB3
aXRoIE1UODE3My4NCj4gPiA+ID4gPiA+IElmIGl0IGlzIGhhcmR3YXJlIHJlYXNvbi4ganVzdCBk
ZXNjcmliZSB0aGUgaGFyZHdhcmUgcmVhc29uLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFscmln
aHQgLSB0aGUgaGFyZHdhcmUgcmVhc29uIGlzIHRoYXQgdGhlIEhETUlQSFkgZ2VuZXJhdGVzIHRo
ZSBjbG9jayBmb3IgdGhlIEhETUkNCj4gPiA+ID4gPiBUWCBibG9jaywgYW5kIHRoYXQgZW5hYmxp
bmcgdGhlIGNsb2NrIGFzc2lnbmVkIHRvIHR2ZF9jbGsgaXMgbmVjZXNzYXJ5IHRvIHVuZ2F0ZQ0K
PiA+ID4gPiA+IHRoZSBQSFkncyBja2dlbiBvdXRwdXQgdG8gdGhlIEhETUktVFggKGFuZCBJIHRo
aW5rIC0gYnV0IG5vdCBzdXJlIGFzIEkgaGF2ZW4ndA0KPiA+ID4gPiA+IGFuYWx5emVkIHRoYXQg
eWV0IC0gdGhhdCBIRE1JLVJYIHNob3VsZCBoYXZlIHRoZSBzYW1lIGdhdGluZyB0ZWNobmlxdWUs
IGJ1dCB0aGF0J3MNCj4gPiA+ID4gPiBkZWZpbml0ZWx5IG91dCBvZiBzY29wZSBmb3IgdGhpcyBz
dWJtaXNzaW9uKS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgdHZkX2NsayBpcyB0aGUgY2xv
Y2sgc291cmNlIG9mIERQSSwgSERNSSwgYW5kIEhETUktUEhZLCBzbyB0aGVzZSBoYXJkd2FyZSBj
b3VsZCB3b3JrIGluIHRoZSBzYW1lIGZyZXF1ZW5jeS4NCj4gPiA+ID4gVGhhdCBtZWFucyBkcml2
ZXJzIG9mIERQSSwgSERNSSwgYW5kIEhETUktUEhZIGFyZSBlcXVhbCB0byBjb250cm9sIHR2ZF9j
bGsuDQo+ID4gPiA+IEluIE1UODE3My4gc29mdHdhcmUgY2hvb3NlIERQSSBkcml2ZXIgdG8gY29u
dHJvbCB0dmRfY2xrLg0KPiA+ID4gPiBJbiBNVDgxOTUsIHNvZnR3YXJlIGNob29zZSBIRE1JLVBI
WSBkcml2ZXIgdG8gY29udHJvbCB0dmRfY2xrLg0KPiA+ID4gDQo+ID4gPiBZZXMsIGJ1dCBpbiBN
VDgxOTUgdGhlIHR2ZCBpcyBnYXRlZCBieSBhIGNsb2NrIHRoYXQgaXMgY29udHJvbGxlciBieSB0
aGUgSERNSQ0KPiA+ID4gZHJpdmVyIG9ubHksIGFuZCBub3QgYnkgdGhlIFBIWSAtIHNvLCBQSFkg
c2V0cyB0aGUgZnJlcXVlbmN5LCBtdGtfaGRtaV92MiB1bmdhdGVzDQo+ID4gPiB0aGF0IHRvIHRo
ZSBIRE1JVFggYmxvY2sgKHdpdGggY2xrX3ByZXBhcmVfZW5hYmxlKHR2ZF9jbGspKS4NCj4gPiA+
IA0KPiA+ID4gPiANCj4gPiA+ID4gSSB3b3VsZCBsaWtlIHRvIGhhdmUgdGhlIHNhbWUgY29udHJv
bCBmbG93Lg0KPiA+ID4gPiBJZiAiSERNSS1QSFkgZHJpdmVyIHRvIGNvbnRyb2wgdHZkX2NsayIg
aXMgYmV0dGVyLCB3ZSBjb3VsZCB0ZW1wb3JhcmlseSBsZXQgTVQ4MTk1IGhhcyBkaWZmZXJlbnQg
ZmxvdyB3aXRoIE1UODE3My4NCj4gPiA+ID4gU28sIGlzICJIRE1JLVBIWSBkcml2ZXIgdG8gY29u
dHJvbCB0dmRfY2xrIiBiZXR0ZXI/DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJJ20gbm90IHN1
cmUgSSB1bmRlcnN0YW5kIHRoaXMgbGFzdCBwYXJ0LCBjYW4geW91IHBsZWFzZSByZXBocmFzZT8N
Cj4gPiANCj4gPiBJIHdvdWxkIGxpa2UgTVQ4MTczIGFuZCBNVDgxOTUgaGFzIHRoZSBzYW1lIGNv
bnRyb2wgZmxvdywgc28ga2VlcCBEUEkgZHJpdmVyIHRvIGNvbnRyb2wgdHZkX2NsayBpbiBNVDgx
OTUuDQo+ID4gSWYgaXQncyBiZXR0ZXIgdG8gY29udHJvbCB0dmRfY2xrIGJ5IEhETUktUEhZIGRy
aXZlciwgYm90aCBNVDgxNzMgYW5kIE1UODE5NSBjb250cm9sIHR2ZF9jbGsgYnkgSERNSS1QSFkg
ZHJpdmVyLg0KPiA+IEJ1dCB3ZSBhcmUgbm90IGFibGUgdG8gdGVzdCBNVDgxNzMuIFNvIE1UODE3
MyBrZWVwIGNvbnRyb2wgdHZkX2NsayBieSBEUEkgZHJpdmVyLg0KPiA+IFNvIGNvbnRyb2wgdHZk
X2NsayBieSBIRE1JLVBIWSBkcml2ZXIgaXMgYmV0dGVyPw0KPiA+IA0KPiANCj4gT2guIE9rYXkg
bm93IEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLg0KPiANCj4gVW5mb3J0dW5hdGVseSwgd2Ug
Y2Fubm90IGNvbnRyb2wgdGhlIHR2ZC0+aGRtaSBnYXRlIGZyb20gdGhlIFBIWSBkcml2ZXIuLi4g
dGhpcyBpcw0KPiBiZWNhdXNlIHdlIGRvIHJlYWxseSByZWx5IG9uIGEgc3BlY2lmaWMgdW5nYXRl
IHNlcXVlbmNlLCBhbmQgdGhlIERQSSBkcml2ZXIgcmVhbGx5DQo+IGRvZXMgbmVlZCB0byBjb250
cm9sIHRoZSBnYXRpbmcgb2YgdGhhdCBDRyBvbiBpdHMgb3duOiB3aGVuIHdlIHdhbnQgdG8gYnJp
bmcgdXAgdGhlDQo+IERQSStIRE1JLCB3ZSBuZWVkIHRvOg0KPiAgIC0gU3RhcnQgd2l0aCAqZ2F0
ZWQqIGNsb2Nrcywgc28gSFcgaXMgT0ZGOw0KPiAgIC0gQ2FsbCBtdGtfZHBpX2JyaWRnZV9lbmFi
bGUoKSAoZG9uZSBieSBkcm0gZnJhbWV3b3JrKTsNCj4gICAgIC0gVGhlcmUsIHdlIG5vdyAqdW5n
YXRlKiB0aGUgY2xvY2tzDQo+ICAgICAtIERQSSBIVyBpcyBPTiAtPiB3ZSByZXNldCBhbmQgd3Jp
dGUgY29uZmlnIHRvIERQSSByZWdpc3RlcnMNCj4gICAgICAgd2l0aCBmdW5jdGlvbiBtdGtfZHBp
X3NldF9kaXNwbGF5X21vZGUoKQ0KPiAgICAgLSBXZSBlbmFibGUgdGhlIERQSSBvdXRwdXQgKHNl
dCBFTiBpbiBEUElfRU4gcmVnaXN0ZXIpDQo+IA0KPiBJZiB3ZSBtb3ZlIHRoZSBDRyB0byBIRE1J
IFBIWSwgdGhlbiB3ZSBoYXZlIHRvIHBoeV9jb25maWd1cmUoKSBhbmQgcGh5X2VuYWJsZSgpDQo+
IGluc2lkZSBvZiB0aGUgRFBJIGRyaXZlciwgd2hpY2ggaXMgYWxzbyBub3QgcmVhbGx5IHBvc3Np
YmxlIGFuZCBjYW4gb25seSBiZSBkb25lDQo+IGluIHRoZSBIRE1JIGRyaXZlciAtIGFuZCB0aGF0
J3MgYmVjYXVzZSB0aGUgSERNSSBkcml2ZXIgcmVhZHMgRURJRCBmcm9tIEREQywNCj4gd2hpY2gg
Z2l2ZXMgdXMgdGhlIHdhbnRlZCBwaXhlbCBjbG9jaywgYW5kIGZlZWRzIGl0IHRvIHRoZSBQSFku
DQo+IA0KPiBJbiBzaG9ydCwgdGhlcmUncyBubyB3YXkgYXJvdW5kIHRoYXQsIHRoZSBnYXRpbmcg
Y2Fubm90IGJlIG1vdmVkIG91dCBvZiBEUEkgZHJpdmVyLg0KPiANCj4gPiA+IA0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBGb3IgIzQsIEkgZG9uJ3Qga25vdyB3aHkgRFBJ
IGRvIG5vdCBjb250cm9sIHBvd2VyIGJ5IGl0cyBzZWxmPw0KPiA+ID4gPiA+ID4gRXZlbiB0aG91
Z2ggb3RoZXIgZHJpdmVyIG1heSBjb250cm9sIHRoZSBzYW1lIHBvd2VyLCBwb3dlciBtYW5hZ2Vy
IGhhcyByZWZlcmVuY2UgY291bnQsDQo+ID4gPiA+ID4gPiBzbyBlYWNoIGRyaXZlciBjb3VsZCBj
b250cm9sIHRoZSBzYW1lIHBvd2VyIGJ5IGl0cyBzZWxmLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ICM0IGlzIHRoZXJlIGJvdGggZm9yIGEgU1cgYW5kIGZvciBhIEhXIHJlYXNvbi4NCj4gPiA+ID4g
PiANCj4gPiA+ID4gPiBUaGUgSFcgcmVhc29uIGlzIHRoYXQgdGhlIERQSSBzaGFsbCBiZSBwb3dl
cmVkIG9uIGluIGEgc3BlY2lmaWMgc2VxdWVuY2UgaW4gcmVnYXJkDQo+ID4gPiA+ID4gdG8gSERN
SS1UWCwgZHVlIHRvIHRoZSBzZXR1cCB0aGF0IGlzIHJlcXVpcmVkIGJ5IGJvdGggKGFuZCB1bmdh
dGluZyBjbG9ja3MgYmVmb3JlDQo+ID4gPiA+ID4gZnVsbCBjb25maWd1cmF0aW9uIGhhcHBlbnMg
d291bGQgbG9jayB1cCB0aGUgaHcgYmxvY2spLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IFRoZSBT
VyByZWFzb24gaXMgdGhhdCBtdGtfY3J0Yy5jIGNhbGxzIG10a19jcnRjX2RkcF9od19pbml0KCkt
Pm10a19kZHBfY29tcF9zdGFydCgpDQo+ID4gPiA+ID4gaW4gaXRzIC5hdG9taWNfZW5hYmxlKCkg
Y2FsbGJhY2ssIHdoaWNoIGhhcHBlbnMgaW4gdGhlIHdyb25nIHNlcXVlbmNlIGluIHJlZ2FyZCB0
bw0KPiA+ID4gPiA+IEhETUkgYmVjYXVzZSBvZiB0aGUgIm5hdHVyYWwiIGNvbXBvbmVudHMgb3Jk
ZXIgaW4gdGhlIERSTSBmcmFtZXdvcmsgKGZvciBNVDgxOTUvODghDQo+ID4gPiA+ID4gYmVjYXVz
ZSBmb3IgdGhlIG90aGVycyBpdCBlaXRoZXIgaXMgdGhlIGludmVyc2Ugb3IgaXQgZG9lcyBub3Qg
bWF0dGVyIC0gc28gZm9yDQo+ID4gPiA+ID4gcGVyZm9ybWFuY2UgaXQncyBva2F5IGZvciBpdCB0
byBiZSBsaWtlIHRoYXQgYm90aCBvbiBvbGRlciBTb0NzIGFuZCBvbiBEUElOVEYgZm9yDQo+ID4g
PiA+ID4gOTUvODgpIGFuZCB0aGlzIG1lYW5zIHRoYXQgd2UgKm11c3Qgbm90KiBjYWxsIGRwaV9w
b3dlcl9vbigpIGF0IHRoYXQgdGltZSBidXQNCj4gPiA+ID4gPiB3ZSBtdXN0IHJhdGhlciBmb2xs
b3cgdGhlIGF0b21pY19lbmFibGUoKS9icmlkZ2VfZW5hYmxlKCkgb3JkZXIgaW1wb3NlZCBieSBE
Uk0NCj4gPiA+ID4gPiAqYWxzbyogZm9yIHRoZSBjbG9jayBlbi9kaXMgY2FsbHMgaW4gRFBJLg0K
PiA+ID4gPiANCj4gPiA+ID4gSXQgbG9va3MgbGlrZSB0aGUgIzQgY291bGQgYmUgYSBzZXBhcmF0
ZSBwYXRjaC4NCj4gPiA+ID4gVGhlIGNvbW1pdCBtZXNzYWdlIGlzIHdoYXQgeW91IGRlc2NyaWJl
IGhlcmUuDQo+ID4gPiA+IEFuZA0KPiA+ID4gPiANCj4gPiA+ID4gaWYgKCFkcGktPmNvbmYtPnN1
cHBvcnRfaGRtaV9wb3dlcl9zZXF1ZW5jZSkNCj4gPiA+ID4gICAgICAgIG10a19kcGlfcG93ZXJf
b24oKTsNCj4gPiA+ID4gDQo+ID4gPiANCj4gPiA+IFRoaXMgbWVhbnMgdGhhdCBJJ2QgaGF2ZSB0
byBpbnRyb2R1Y2UgdGhlICJoZG1pIHBvd2VyIHNlcXVlbmNlIiBiZWZvcmUgYWN0dWFsbHkNCj4g
PiA+IGludHJvZHVjaW5nIHRoZSByZWFsIHN1cHBvcnQgZm9yIE1UODE5NSBIRE1JLi4uLg0KPiA+
ID4gSSBob25lc3RseSBkb24ndCBsaWtlIHRoYXQgInRvbyBtdWNoIiwgYnV0IGl0J3MgZmluZSwg
SSBkb24ndCBoYXZlICp0b28gc3Ryb25nKg0KPiA+ID4gb3BpbmlvbnMgYWJvdXQgdGhhdCwgc28g
SSB3aWxsIHNlcGFyYXRlICM0IGFzIHlvdSBzdWdnZXN0ZWQgZm9yIHYyLg0KPiA+IA0KPiA+IFRo
aXMgRFBJIHNlcmllcyBtb2RpZmljYXRpb24gaXMgYWxsIGFib3V0IEhETUkuDQo+ID4gTWF5YmUg
bWVyZ2UgdGhpcyBzZXJpZXMgd2l0aCBIRE1JIHNlcmllcyBhbmQgbGV0IHRoZSBIRE1JIHBhcnQg
aW4gZnJvbnQgb2YgRFBJIHBhcnQgYW5kIGl0J3MgbW9yZSByZWFzb25hYmxlLg0KPiA+IA0KPiAN
Cj4gSSBoYXZlIHNlbnQgdGhlIHR3byBzZXBhcmF0ZWx5IG9ubHkgYmVjYXVzZSBJIHRob3VnaHQg
aXQnZCBiZSBlYXNpZXIgZm9yIHlvdSB0bw0KPiByZXZpZXcgdGhlbSAuLiB3ZWxsLCBzZXBhcmF0
ZWx5Lg0KPiBCdXQgLi4geWVzLCB0aGlzIHNlcmllcyBpcyA5OSUgYWJvdXQgSERNSSAtIHRoZSBv
bmx5IHRoaW5nIHRoYXQncyBub3QgcmVsYXRlZCB0bw0KPiBIRE1JIGlzIHBhdGNoIFszLzZdIHdo
aWNoIGlzIGp1c3QgYSBjbGVhbnVwLi4uDQo+IA0KPiBTbyBpZiB5b3Ugd2FudCBJIGNhbiBtZXJn
ZSB0aGUgdHdvIHNlcmllcyBpbnRvIG9uZSwgdGhhdCdzIG5vdCBhIHByb2JsZW0gYXQgYWxsOw0K
PiBpbiB0aGF0IGNhc2UsIGRvIHlvdSB3YW50IG1lIHRvIGtlZXAgdGhlIHBhdGNoZXMgYXMgdGhl
eSBhcmUsIG9yIGRvIHlvdSB3YW50IG1lDQo+IHRvIHN0aWxsIHNwbGl0ICM0IGF3YXkgZnJvbSB0
aGlzIHBhdGNoPw0KDQpJIHRoaW5rIGVhY2ggcGFydCB3b3VsZCB1c2UgYSBkaWZmZXJlbnQgY29u
ZmlnIHZhcmlhYmxlIHRvIHNob3cgd2hpY2ggY29kZSBpcyByZWxhdGVkIHRvIHdoaWNoIHBhcnQu
DQpTbyAjNCBjb3VsZCBrZWVwIGluIHRoaXMgcGF0Y2guDQpUaGUgY29tbWl0IG1lc3NhZ2Ugc2hv
dWxkIGRlc2NyaWJlIGFsbCB0aGVzZSBwYXJ0cy4NCg0KSWYgYnJlYWtkb3duLCBpdCB3b3VsZCBi
ZToNCg0KUGF0Y2ggMTogQWRkIGNvbmZpZyB2YXJpYWJsZSAxDQpQYXRjaCAyOiBBZGQgY29uZmln
IHZhcmlhYmxlIDINCi4uLg0KUGF0Y2ggbjogQWRkIHN1cHBvcnQgZm9yIE1UODE5NSBEUEkgc3Vw
cG9ydCAoYWRkIE1UODE5NSBjb25maWcgdGFibGUpDQoNCkJvdGggY29tYmluZSBpbnRvIG9uZSBw
YXRjaCBvciBicmVha2Rvd24gdG8gbXVsdGlwbGUgcGF0Y2ggaXMgT0sgZm9yIG1lLg0KDQpSZWdh
cmRzLA0KQ0sNCg0KPiANCj4gPiBSZWdhcmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiANCj4gPiA+
IENoZWVycywNCj4gPiA+IEFuZ2Vsbw0KPiA+ID4gDQo+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+
IENLDQo+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENoZWVycywNCj4gPiA+ID4gPiBB
bmdlbG8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gUmVnYXJkcywNCj4g
PiA+ID4gPiA+IENLDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiA+ID4gQ2hlZXJzLA0KPiA+ID4gPiA+ID4gPiBBbmdlbG8NCj4gPiA+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gPiA+ID4gUmVnYXJkcywNCj4gPiA+ID4gPiA+ID4gPiBDSw0KPiA+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiANCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gDQo+IA0K

