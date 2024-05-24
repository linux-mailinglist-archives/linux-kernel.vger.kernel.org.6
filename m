Return-Path: <linux-kernel+bounces-188346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44ACE8CE0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46421F21F51
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 05:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E003C128830;
	Fri, 24 May 2024 05:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="p8LNt4TS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="pmAUXhT2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0AA128392;
	Fri, 24 May 2024 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530299; cv=fail; b=fJyDlsS7HLaJok33LOM56KODJTnVMi5quKFttcZIL9Ld8sZrk6s9Fcdq0TMUE/g6wvSc0AVfcE331JkXh304uAZuMjwrkATdGAK+/7yyAIY8OcBVIqM87n8sgAZOWZHbVSbgHh+WMv4FvBXn6K4TvgneUB92iTi2+jTBuBlN7zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530299; c=relaxed/simple;
	bh=pNUXz0ZAxVppYY9katwCJj42i3DjN3hX/VCDLqizGEI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K1e0FE0qjv2my+mAnvjFhWUUPrTm7M9PNuCn4j6jj0zquUzpWfzXEKDMGtZyOX/3F33Wu/u3jxMaEMhklFZCfWXq/EEOLmHexbH3XEj3Xed5PX7lamukbaaX5zTcCM1gP91DEnTQrW2T9mtzVfoXrijFH2BxEW4li91YjwwEc8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=p8LNt4TS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=pmAUXhT2; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9a3da946199211ef8c37dd7afa272265-20240524
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=pNUXz0ZAxVppYY9katwCJj42i3DjN3hX/VCDLqizGEI=;
	b=p8LNt4TScgGJBMqHyMgFow78vyHtOtkpU2Po6dRvvuDSsuEINAMsAMh9Pd8xRnYAoYIJUzEnlRgN2rCeRwuTavtyCcCIiM7elX+jKb12NIXtG65gnE4phPkFCQ0k3gIUEZ963Cjb7MPU/yf2sH1QWkQvOAJIGtWeWG1hYN44twA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:cab26510-0405-416e-8fc6-96e5ad0b5a59,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:3d1ac287-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9a3da946199211ef8c37dd7afa272265-20240524
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 23634874; Fri, 24 May 2024 13:58:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 24 May 2024 13:58:10 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 24 May 2024 13:58:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Smp/MBkxbPhVHHTCfq8/VwSfa0i+hdB1qsJZYSM+HuHLu28PsYJDJK3pgIKm+jgTWeGgNgIhtrtXfM6Q76vsG2i05NGJWLV3KcqYguTEcIuYKRQxs6TF9tnvHGbbWVRi0NvXR9DbffHUCmzHjghqcJy8m+8fbene9LPZGiUrQaYzT4YSbh6JRori37TCxBx2uAK7niIPqkpNUi18766GJIaHJGBBrZmaH12devBw2dlMBO2roE0rcHNoFszjXBTKDxNmOPPVMb8LXAvlVEK3Ssp6BKw37NO1OE29/KBN1Tj/WORO+0nJUF8ydhyOBjph0hNWfjo9Cr/y+flA/J0GJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNUXz0ZAxVppYY9katwCJj42i3DjN3hX/VCDLqizGEI=;
 b=SUW0XZ5TSoddaPUODbxzcFmiAshPwliW+iAkXZjvyEzdVKtZL4SyBq+e52G4Ud1vpNDrl74eNqBbZsTTXZzxP6IUo3lNkok57/w5ZlbmhvE7bN6gJ6JzCBhOJ40XDeUiprXQ58ixid/D2Iws2j5O/qEOQ5gAEaB0GaPy2JZTsouWn+92An5JMm3VUlBkuAyHfAITrcJpnyk9MrGQ5BIDgsylDoVHXKvBuCHGYjaAK2ioeTJ4TlG63w/yNb+ROHVPqx+prHdyV+YproblfgIbBqYRnteZPiIcfh3e2+46cqUABGQfq+awf040+SnEFuMXULDG7v4t8zAJcVvn0Y89LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNUXz0ZAxVppYY9katwCJj42i3DjN3hX/VCDLqizGEI=;
 b=pmAUXhT2DFvK3P4xJbM5rgB6166/L74QNKXEe8bB5wYrNiWWU7PlXrGwdgFhiONyliUoCPQiSUMYccCpZRmH/Ytebbs6jExtrrws5psifuM+nLgWI+XBcVdqOZlWOTzRf9sr4giQpDURe6SVsRqP2NNOrouWDyom1ijE8iJibCg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB7421.apcprd03.prod.outlook.com (2603:1096:990:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.17; Fri, 24 May
 2024 05:58:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 05:58:08 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "amergnat@baylibre.com" <amergnat@baylibre.com>,
	"robh@kernel.org" <robh@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 03/15] dt-bindings: display: mediatek: color: add
 compatible for MT8365 SoC
Thread-Topic: [PATCH v4 03/15] dt-bindings: display: mediatek: color: add
 compatible for MT8365 SoC
Thread-Index: AQHarQ/Ak3hlQtJJ/UWtBg3sgApZPLGl5JOA
Date: Fri, 24 May 2024 05:58:08 +0000
Message-ID: <6bc8a1334dab5cfcfd7a0a8b4ac126c997f9be43.camel@mediatek.com>
References: <20231023-display-support-v4-0-ed82eb168fb1@baylibre.com>
	 <20231023-display-support-v4-3-ed82eb168fb1@baylibre.com>
In-Reply-To: <20231023-display-support-v4-3-ed82eb168fb1@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB7421:EE_
x-ms-office365-filtering-correlation-id: b78fea24-1a06-4b96-af89-08dc7bb67c63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|921011|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZGx6WnE5dWhPZW1xMnpLMm82aG5IYmJ1MEpVZWsyOUoreUY3T0cvWEtzUGNY?=
 =?utf-8?B?bGo5cml6TlVJYlI0V0pRUWh0Q2drOUY2US9Cc0c3NkRzZmhUaVV4cEpkcVo2?=
 =?utf-8?B?SVBhVm1wNW4yOHhyYzFZZlZOTjRJMGpZdE0rWEk5WlZnQ09NSDNRL2JQMjJW?=
 =?utf-8?B?UWwzUmFQWmc0NDJwbms0bnEyMGlERk1TbTcxWHJoVzE4ZmFOQllPSnNuYVgy?=
 =?utf-8?B?eVBLamRkZGtiNlFFOGhreW41cWZGNTQ0YUw0d0Z4UFhWWVp5T2ZuNFEwaytX?=
 =?utf-8?B?cEhqMG1wMTNPMXRhR1c1M0FBbUp1dGJwbjFxeFVJeUE0OGhOSkFNUjB6YXN1?=
 =?utf-8?B?K1hIbmFkRXdxaHRMZko4ZURteWhreUw0T1JraGQ0M2pHekYrUzZOMWc1eUF1?=
 =?utf-8?B?eHFIUGtWNjhTbSt0b0VQWVFLT21iQXRNMmNpSzN4cFBvUnFkcEpoYzh5REtM?=
 =?utf-8?B?VmZoUXRyWkl4dmxnVVhDNzA0TzJUb2pPajNtSmt4YnRCWEFxSklDSG0zbVBx?=
 =?utf-8?B?RFFPR3ptZFFPcnk4aE9PdGxLMUFLUjYveWF4Yyt5eXVWWEtuTDVXbVRQQUJD?=
 =?utf-8?B?VE5KajVVNFRQZXhwS1Bvci9GTWMzbzZxWktFeHRMZ1FvWUNBTmR5ZlY4K21J?=
 =?utf-8?B?aEprYXU0OUV6SGtxRklJOXM1NHF5VnZEM0RTMFlZa3VXUWdManN1ZUtWcU45?=
 =?utf-8?B?RHNQNEI5SVBiK0k4ZUhkMEx0RzhIU1Eya3EyV2x2T2ozc1MwUHlWRWdSUTVF?=
 =?utf-8?B?RFJPSnd1REFzMCttUUR0L2x3TzFDT1YyQ2lsRTN0dXBwVWU4ejg1NFFZU0xk?=
 =?utf-8?B?R1RXWTNGR3hQTkZUWkw2WXNzY0I1ZnltV1JSbXpwSkhHUFNWYldtSk45Z0ND?=
 =?utf-8?B?V2t3MGhOU1N5TEFvYVU0aTJPZjFHMEdEUXdRcjBaNnZNYTBYVmlVUEFuUjVT?=
 =?utf-8?B?eExTVSt2Mk4yZU5tM3Z1aHFPWXYrTVM5VDFFeVhjYW5IbE1NT2dhMzJlZGl4?=
 =?utf-8?B?ZFk1MTRGbDQ3WUxKM0RKSm9Hd2g3bXVodXJSZVhpdE9QaUljanJERnBXQUtJ?=
 =?utf-8?B?NHhIRzZaYytzMkVlMWUwU3hOUkg0d1VBeXZaOGhiVFB1Tm9Tbi9WTncyQUI2?=
 =?utf-8?B?N2ZkOVVUZzFibko5TVU2bDE1OG1LVGNTamRtcHovT0dNVkE5SmthVndRajhp?=
 =?utf-8?B?djN3R0E1aUZhMUxJOWw3MzZvWlBCdXZnL3hEbE5XWDczWlFUU0FEblppQ01I?=
 =?utf-8?B?SkFMcnErMndpejJsNnRlWG5XN3JDdFZzUWVTMHR6RG1Wc1NvMVFYV2poczRR?=
 =?utf-8?B?eDVPWU83VFVpQnV3THE3RXZYdjJLZHZLcjgveUNJL0dDM2RhdGlWZWpxQmpE?=
 =?utf-8?B?SVBXZmk1ckg2K0VoZkZoN25oUVVraXMydGhDQWN0NWduMXBPNEROckswUUNG?=
 =?utf-8?B?amd1ell3M2pBZk5UMVRxaDFKRDU4b3RubU5BR2s1OUJUK0lsYnpvb0VYWDVJ?=
 =?utf-8?B?REdSVWNld2wwenNtRUZob3MvM2Y4WmNPcVVjNmZ4T0QzU244dUdQVUI3RUZQ?=
 =?utf-8?B?bzhJUmlvcTNSOEFuOHduWnczVFdtYVNpVVBqbmYza3dPZ0V3ZGRTQTQrSXpi?=
 =?utf-8?B?eklJLzcya0Z5S2pKaEtycHQrK1I1MFd2S1ZTSENGMk5nS2FBYmtlRkhCczgx?=
 =?utf-8?B?NG1UTWhZVWJPdGFHV3NhRkF0Y3RrTDNQckN2dE9ITDZqOHZGSGJBYmFRT2ZF?=
 =?utf-8?B?YUJVV1F4TW1EamxJTjhmTHBIakIxNUdUNEprTHhQYVFXYUhJR3R1NkMxZXBa?=
 =?utf-8?Q?OWrPCRtczKVw6ZWhVkFDq3VJZ41BozaL1Jl1M=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHEraWdUQnpYMlJzdEJuMmpvWXBLS2lvNXlZeFIwWDk1V2YrZFVQQjI0WXZ1?=
 =?utf-8?B?UFhOeHdhUGErb3M2R3k0czJuaHdWek8yQ3I0NUtiVmcwQ1llVDFZOUkyUkxl?=
 =?utf-8?B?WXZJOTF1L2g1V0dUWThiRVpBRUdQUjg3WVUwZFlXL1RMUk9sZ3h6N0wvc0dr?=
 =?utf-8?B?SzI3K1JwT2lUbDVqZk9pcWY4Z0tsVXdTYjF4MVFWVmRMVGFjMk5yRVFPbGRw?=
 =?utf-8?B?SmlIQ0IvS2plQWVoU0VWV3NKWkh3eHZCd2FhOFRyaU56TFhzSDJCYjZsUHRQ?=
 =?utf-8?B?aXU0MFlEOWYrWkM3MDMyZS9KMDJyNithMVZ1SzVlbmk1NnpENTlEMEZ1bkJO?=
 =?utf-8?B?SnFIVTJqYmROT1crZGliRzh2eldPeXBCclhJK2J3UjJzZDRwYzRhY0xjSFpk?=
 =?utf-8?B?NUo0N2hINnZLWkhnc1FGYTV4NlJ6UDNVOGt4TldjOTJGOXlCdExJTzhadnFV?=
 =?utf-8?B?YXNIRE54T0NBVjMvRWwwUEdpZmY3QWVzVk00dTJ0ZWx2U1BDbEFPOWpCK0M4?=
 =?utf-8?B?UWh6UFhJOU01OEc0S0ZZWjNLZTIzRlBieHBsT3E5NHp2MXgzRlVoVHdDaXNj?=
 =?utf-8?B?QVU5bWdNTXZISVhXcjMyWWd4bmFjL3ZjMllHREQ4RUJJN2RNc3JXdXV5c0c0?=
 =?utf-8?B?bGdZNFE0Rm1vTlJnVnVWbHVGZnV1cmdVNmpwdElDRWJhU05hek83VHVUU3hp?=
 =?utf-8?B?eSs5dE81REhiaGlJWXFqUm8vckdTc2dUSTdxeVB4ZndPNXE3MGFjMGduQjN1?=
 =?utf-8?B?WlNEY3g2OHpmbWh2Qm9JRlRlb3NwZnJBUjBTejJvTXZrcFZCcHo4NlUxTGJY?=
 =?utf-8?B?T09zZkhUNS9zeFBIU1RNUzMwZnJQUGdwWGM2eDlFWTJoRlRlZ0NkUm5HRllG?=
 =?utf-8?B?RG16Qk11QStBZWtkY2ZCUHVOaE9hT21CaWZweFpsRXk5RlRkcGlwWld0cVBK?=
 =?utf-8?B?d0pXYWo3K2MyNWpQQVd4WTlYbTQ1ZTZjY2hGR1JCV3pHbmZ5dnN5TE4vdnhx?=
 =?utf-8?B?dnVvUEFXWHVUK0tVSTltcXZHK3EreGNOaCtvVjVDL2hBYUNnT245M095SFln?=
 =?utf-8?B?cC9LRXQ0LzVVbzA5M3RNYVB5M1VGRGNrOXFERWtyVWdDaFJzK2VxdTRzKzBD?=
 =?utf-8?B?S3l1V1hFclV5MHZQQ09QTUkxTkJ4TFBVNU5veURTVC9rVEdta1UyL2NoWXJL?=
 =?utf-8?B?bXdGRnhMbjZZYng4a3hKTlZqOFRuY1FoeDMvcWtYUVdFY0E3Y0I3MzVHQkts?=
 =?utf-8?B?Y3BvbkNiUit4OElreXk4U3R6TG96QkZUMCtybGRxNUpMNFVITC9nLzhHdFFq?=
 =?utf-8?B?OWUzdTE1L251bGZWV214UVA1TUNSZHlkQjRwckVkczBINTBvY3dvbnJicGpR?=
 =?utf-8?B?OHlGazlsK2NFTFdXbkxmY3R4NkFNVjRTYkRMQXRVUCtkVEpEMEgrenZhaEM1?=
 =?utf-8?B?SndKdVhoSHhTeVFHUUlCTzJDdXI0VXB4T0hqbkd6VW1HTmppTXczRDRxZG9Q?=
 =?utf-8?B?SHVFV2ZueTZwMVhkUk1yZDEwTmJZMlZwcStBeGFHd1pIQVhVRnN6Y1Z1UW9i?=
 =?utf-8?B?YkpQMkI1b0FKamx5T2h5WGF5SktOMURqbytadFpBMVBmdE5qRGM4eVFyVURW?=
 =?utf-8?B?ajQ5cXBTQXgycTVDeWJlb2tRWlZWVDloWE5GSjF2NVUxZnZqZ1JsRUx4dFRE?=
 =?utf-8?B?Q0tDUEprNkpqUDFUa29JZmJXSWh3RzhRekxNR0M3bVNhVkNDdCs1Z3hpRUlT?=
 =?utf-8?B?YkZHNjBqU1BnSVE0VFVWYjg3aXdtTjdqc040SDVBOGtOU2NqbllFZFhJQ3N4?=
 =?utf-8?B?cHZrQ1RYTmxUVXR5VU9OY3BEcjF5VVdDTkdqWE5pdzVvMlhIWE5HKzViZDRq?=
 =?utf-8?B?eG1FOU9tUVh2YkRnMW9rNHRaT1VXWmlwWmljRjlRRXN3U2pWR0REVGJHdXZn?=
 =?utf-8?B?RkZEL3dZMzJzNHhSY0JWaDlGa0pyT21hZ2kxdW1CbHMzaFMzdlJ1SklDRlor?=
 =?utf-8?B?c0VtNmRvQ3BNazQxdmp0T2x0cGRmT2l3YnphcmZxWVpma0V4Y2pEd3phQnV1?=
 =?utf-8?B?S2xvR01UZTNiVko1RTA0YzRoVzlrRkN4a29kalBndVJkbDNhcXhPRllnRUxB?=
 =?utf-8?Q?CrFi0Rmhpdh7yVuVEtuS3+vEN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D312B7E0C1FAB449E8928A82771E854@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b78fea24-1a06-4b96-af89-08dc7bb67c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 05:58:08.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: huS94tqwvOKqLHbJocqx3jNGkb3Tm4BtzWfSav8w0ulIn8CP1QsCeXOA36mo+ewv+gjLlcl86SNjVoxUqwECFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7421

SGksIEFsZXhhbmRyZToNCg0KT24gVGh1LCAyMDI0LTA1LTIzIGF0IDE0OjQ5ICswMjAwLCBBbGV4
YW5kcmUgTWVyZ25hdCB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlm
aWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBEb2N1bWVudCB0aGUgZGlzcGxheSBD
b2xvciBvbiBNVDgzNjUsIHdoaWNoIGlzIGNvbXBhdGlibGUNCj4gd2l0aCB0aGF0IG9mIHRoZSBN
VDgxNzMuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0K
PiBBY2tlZC1ieTogUm9iIEhlcnJpbmcgKEFybSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxh
bWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssY29sb3IueWFtbCB8IDEgKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssY29s
b3IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlh
dGVrL21lZGlhdGVrLGNvbG9yLnlhbWwNCj4gaW5kZXggNjFkMDQwYTEwYzA4Li42MTYwNDM5Y2U0
ZDcgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNw
bGF5L21lZGlhdGVrL21lZGlhdGVrLGNvbG9yLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssY29sb3IueWFtbA0K
PiBAQCAtNDAsNiArNDAsNyBAQCBwcm9wZXJ0aWVzOg0KPiAgICAgICAgICAgICAgICAtIG1lZGlh
dGVrLG10ODE4OC1kaXNwLWNvbG9yDQo+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTky
LWRpc3AtY29sb3INCj4gICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtZGlzcC1jb2xv
cg0KPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODM2NS1kaXNwLWNvbG9yDQo+ICAgICAg
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTczLWRpc3AtY29sb3INCj4gICAgcmVnOg0KPiAg
ICAgIG1heEl0ZW1zOiAxDQo+IA0KPiAtLSANCj4gMi4yNS4xDQo+IA0KPiANCg==

