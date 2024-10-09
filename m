Return-Path: <linux-kernel+bounces-356579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD2B99639E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F1BB280C9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F152518E033;
	Wed,  9 Oct 2024 08:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N7ukSLba";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LJd9un5E"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287617C21C;
	Wed,  9 Oct 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728463443; cv=fail; b=bvB4nMkxNUuQxbfMI6QmWtGL1/dF4gORsaM8EOYjcVa84psp82unIVVluebKpxMu4Sm0OfsQVTfTN5I2dtUCecUlV9QhB4c+F6b11cpQsAngh3ldrB71Dg/GtQRFxNC//mwlcS4ItkzxVTN4Wn073sw6qW8+3lctKA5PEBlhKh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728463443; c=relaxed/simple;
	bh=VkkCSIoKPFyRgrL18EzrDufn9ugno/3iEhtIsJr3Cyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WooUYh8cy/tcc7uDO7jR2+Lyd3PsEsnvwuOTJdXC+EoUXZv3HSgHf0BSaifLJszY1uImmqlornBzpLhvybBHppgyPRpNnWRL1zHjy9gauDr/rtZIY72/BHwTHcXZ1tV1ap8fhcCOHszBmbDwGlEoud818XKcs2w8ohlUm0BT8DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N7ukSLba; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LJd9un5E; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9f1d89d2861a11ef88ecadb115cee93b-20241009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VkkCSIoKPFyRgrL18EzrDufn9ugno/3iEhtIsJr3Cyc=;
	b=N7ukSLbaTI32GzRSjKlkwTXn/xotGOcoHehBJ0QSuPMpM9pWqWNConKVTFAwdy07wPoFpda6kDAbLpmdKLNfAWm+iK121/U8mXauD6o0CGt/UfPU+vToTSa2LpTgSkIcRnfPfwCFFspYiFoMrwrL8J7JnaBw4WR9o2gaQJ4aRAY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6a1c5cd5-6bee-48e9-8732-6ed19d0fc259,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:3665fe40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 9f1d89d2861a11ef88ecadb115cee93b-20241009
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1913826437; Wed, 09 Oct 2024 16:43:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 9 Oct 2024 16:43:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 9 Oct 2024 16:43:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQWcvHkMGq7CD1/4FyJtHqReuHHD27/lF8sJnOLOTaoCQuLu83BHZOMiMzR5wtK+n9D+733G4ABFT74mdQRiLWMD/UMOX6SzPFwp/YLekgPE16TUnDeArOeh08SenPOWFZOw4b7iLvVZCqARuC05y+KaBJKqDB2KWOZ78/HxHpRH9LAAw4ZIgkN7PzjaB6HbBCt59iz57wcUtumefE6od1I0SgJx6xZTwli0ltesMCoCdwPFWtm/ovESCHBdbBAlKFXz01+BOyLJLOX68Uvo2B6vDSCNh+Z3+I4f9/Uqlyft0ST7Zel7jDkm9rOl0MU5F9Y8Q6UsxBPlIqPyDlgYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkkCSIoKPFyRgrL18EzrDufn9ugno/3iEhtIsJr3Cyc=;
 b=TUO6y/+9XGxlYQxdBJqPAYU5anNrcjJ9DjDYd3VpIJOFmNRhOQDkQTvs49yJqYsYsq9tVcwaYDgfA0cuz04BX12WygkXXqZA/bMEu3fMSgzrj055iY3hcQNxDj31O0gY5eyF1CIEQeBtFp//W2wY5PZ2H93AVrvUYq96ICVEKibVLsAQDvFEiS56q9nNvlHI99DWn/uKX7pLSP+GNXdAAu+kzxnEgJzuq2qB49h07DVz/mZx5eBAMwRHhN0sheI80+zB149vFidUCWBx3lFk6P8/Vu1KY+ZN/Dh1heCE/OSG/u4mk+Kt+E7fZHCO4P2jheQMj8Yp7RkLAA52Bxlk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkkCSIoKPFyRgrL18EzrDufn9ugno/3iEhtIsJr3Cyc=;
 b=LJd9un5E8ygxOPHHTYy8+uXieuR7dSaqmjEsGp83xhDDWYpB7hj+q01XTLtuEG/3OEPzLMB9fIIovBzWOZMXXn+OMipJ+vUZnZuaNXq+xC37lVl9PNjlFkQpp096kkwxwhBW9j1nnClOyh0lOes5UmJDNskB5GZjteJXzuEXxwA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7797.apcprd03.prod.outlook.com (2603:1096:820:f7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 08:43:52 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 08:43:51 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"sui.jingfeng@linux.dev" <sui.jingfeng@linux.dev>, "wenst@chromium.org"
	<wenst@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"michael@walle.cc" <michael@walle.cc>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
	"mwalle@kernel.org" <mwalle@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
Subject: Re: [PATCH v11 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Topic: [PATCH v11 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Index: AQHbGJvj29sreDXMGEakTX36fvej8LJ8ebCAgAAGIACAAZ2xAA==
Date: Wed, 9 Oct 2024 08:43:51 +0000
Message-ID: <13aad68b2473b5848fd9172e75501d51dc8c8d91.camel@mediatek.com>
References: <20241007093114.35332-1-angelogioacchino.delregno@collabora.com>
	 <20241007093114.35332-4-angelogioacchino.delregno@collabora.com>
	 <a7fd78a9fb858552e48339bc4bf3d3423d428f3b.camel@mediatek.com>
	 <6415a3a1-f00d-428e-b607-ae27ac63c11a@collabora.com>
In-Reply-To: <6415a3a1-f00d-428e-b607-ae27ac63c11a@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7797:EE_
x-ms-office365-filtering-correlation-id: 9e7ea1f0-d90e-4ef5-aba1-08dce83e800a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YktMT1dINFZONTlsblV2K0pVS3dueUdrUGZnaVdhU3lDSzdQZXlpaGx3TDNY?=
 =?utf-8?B?RzRCdzRrQnZpRlp1WDY1cDJBN0t0Wmt0YlJreldGL3RrRm5LZXowaXh4Z0tk?=
 =?utf-8?B?Szk0L3lOZWMrazFZS0s4bElWV2p4aUszeUN4THZHQ1pxZm9hVDhXbm1jblhS?=
 =?utf-8?B?bC91ODRNcGpRTWJYaEJjUTlOdVBndkxqakNXMWdwN1NtMkdqNy9zemhMd0xo?=
 =?utf-8?B?MnlQM20xTmlrTFNMVXlDcFE2NTJ4TStJZlg4WjNicFliYVczWEVWN01RTitC?=
 =?utf-8?B?RC9ra0hBYWZpZWpFaS9BMnI2djNWOFIybzFLYktReXpzQ3ExNVB3aFNTNUl3?=
 =?utf-8?B?bTFyZWVNYVVTUXZuY2s4ZTMzMjJyMlhIL1lIZXdqN3J6N291NzBoM0hVbUN1?=
 =?utf-8?B?dzNvNUw2Y3NJSmt2cEVsZENzWG1iRElmS09NU2hpR2x3SDlvTkNxTTN3SFNV?=
 =?utf-8?B?b0NHU0J6ZENpVWJPc05lNGpsYnhqdlRqYVRBL1Rta3N6aFpheWN1azdJNVAr?=
 =?utf-8?B?NnhGM3F0ZHJBUDBkNTAyTjRiQlRyT2FQVEVEamZqZ2dWZXJiemUybU16aWt1?=
 =?utf-8?B?djJqcXVpMlR5YmV6MVJMVk9sU0JUWThFREdyUXk0dUVRV1VOUDNQSGorL2R6?=
 =?utf-8?B?bjZJWi8wNWxyeSsyaHNPSkg3eVVDUEd5cTkranJ5cmx3ak5PaWVKa1plTXpQ?=
 =?utf-8?B?eVNGMS9MQ1EzLzFKTWJmK24reUZNcmhKRWZDeEJtVXJFYWxsMy9DUmVwaExZ?=
 =?utf-8?B?dnpXVmdoRHpDTXRvUGpIMDc3NytQeFlRSzBXekdueUVlL0d4THFHekZNU3NZ?=
 =?utf-8?B?dUhNZUwyRFZkdE1YV0x2M0ovOUE0N0xTa0kyQ25HSWxzMjA0Qjk0b0xKbFBM?=
 =?utf-8?B?c05Wa0FwTFZiTFFIWXljMWM1SXRvZEwrSTR4SE16NW9HZXVLaG9KRjd5VTVs?=
 =?utf-8?B?NzEzYmNoMGxmd2J2c1FYYVp3THJUb0pQVkVpZXRITEhHRjJpbUJBMkpxU2lB?=
 =?utf-8?B?VEJFeHJxSDZTc2k2WlE2dUFTQklsYnBrSDFPWTZCZVRhbTNXclpRWjAzMlk1?=
 =?utf-8?B?eDFXdS9HcGpTZDlZV2RZZmtOU1Y3ai9JTGRVNjVKbXV5Rjc4UkJNR1BDOWxi?=
 =?utf-8?B?ZnlldVBuT3M3N0s0eThVTDVpK3RRKy9Ua01MVDA1ZG5nUDhjMXhlRmFIczk5?=
 =?utf-8?B?ZEdCMXhlK2tpL0NZcEoralNLcGZiQ2xISE9mekRwY2tDSlRVUmtPaVZGVFNu?=
 =?utf-8?B?S1FFcVBsY0l4blJSWUV2bUsyN05qNUltWHAzc0pqZVNZZ2lsTnlCdVk2cVhx?=
 =?utf-8?B?Yk00L0NLRmVrd1J4WHZ6eGtJWmRRaUZKWit3L2hDS2tnYVlYOS8xYmlYT211?=
 =?utf-8?B?c3JsN3lMUGdHV1RwdHVEREhQR1VTMTBXYXlYZ3E2OXFYVXF0OURLZ010Tktk?=
 =?utf-8?B?WUNNMHFkRTRJNUluV09PR21XQ3hFL3V2YWx6cXMyWUdoNlFhbnFybm9veVFi?=
 =?utf-8?B?angvNC9paUdiNEE0L0E2VHNqUWFQZlpxbThSd0QvekFvaCtubUhjVFVpUEtu?=
 =?utf-8?B?dHh2T0U4MXFiaGRJWHBPZ0ZaRmZBYkQ4aTZjQ253UVZtcDhTT1dnemNmWlZy?=
 =?utf-8?B?OXBOaGk4emVhWUhZZnJ0WFZTakdWSDVmRTk1UWJ5Sm5CVDhXZFNPK1NYZ2RQ?=
 =?utf-8?B?QzhTWUw1R3RXRkxRVFMxRXlhc1ptb0dpT29sbFgvaXhpV05hMjkyUUx0c204?=
 =?utf-8?B?UE9lbUEwWkRGeW1OVFRaVk9GMjNRSFRqcXdscldjY1lVWlhMTkVtaVdCV01m?=
 =?utf-8?B?VGExdUpqdnFQcEZNMzJkdz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnF2TVZoOTZIbjRKTk94eENvNjFEc1NNbEZFeDRSMER1S1Rza0JnaDdRRko2?=
 =?utf-8?B?MUVjV0ZPbXZSUTFyTW1EcjJKVFEzN0Z3VWliamlsTXNjOTBMcTVxUEpTQkp5?=
 =?utf-8?B?Z2NTUmRMZEJ5QkhuYWFqVDVGUzJ0bDFIUUhmekwydmdhV2k3Wnd3U0t6L0dO?=
 =?utf-8?B?TDBXRVFoZmt3S0U5cHhxWldQSFV0UFdxVkxKb1ZhMDB3MFlRai9PQmRMU2ZY?=
 =?utf-8?B?b2R5Mi9VTHNzbldLQ1lvQWYwN1N2aFFFbENMWmxmRnpEODRBTDBjeldqSjJB?=
 =?utf-8?B?amFHblF0bFMrN0lNQ2RZQmdxQkR2enhweEZUanloYnBOenRIYWs1MjFqNmJn?=
 =?utf-8?B?NE5MYlY2S0F6a3lLWDB6czRUdDRXNVQ0Y1ZrV0NGTXk4UkQzRVdmRjFDUmY4?=
 =?utf-8?B?VXlpMTI3VVM3Q0tteXJEOHFvNjJPSzJYczZnVFdhREVYWkJHS3pqdmwvRFgr?=
 =?utf-8?B?dEZZMVE2clpWWFFhcnBQdEl4d0VRdHdBM2tZTTF6VXlaZ2t5TlZFZHpROVF5?=
 =?utf-8?B?bVpRMk5IQXFoV2FSNit3aHZsa3JML2dMdGJaM202YmlmRGxJRWxsbE5jTklp?=
 =?utf-8?B?WVZZUWlHa3NkWXVVbnFTWHFad3RxcGNoeHFxeEd0VXVhRHFpNHhlTWNtcUFq?=
 =?utf-8?B?MUd0eHFLQzhuZjFiN2tySkloanNreGthZ0h1RDhjNGttSHVRTGZGWmkxNjVJ?=
 =?utf-8?B?MkhLZ2FxTTdSL1NJK1ZnMDFJUm9zaVlUTjlBbEUrRHY0VVozaEJKeGdYaS9I?=
 =?utf-8?B?Q0FKSHhJbFBlYkFLaUYrb00yMEI2S3o1RG9EMlZ6QTF4ZlRCWUFxR2xYRnhi?=
 =?utf-8?B?b3ZWMWE4THpsV3U5d2tRaEIxdnQ4UTNHcEJ5NjNFS1l6K0d2MC82VDNTTElp?=
 =?utf-8?B?cEN2NUhFdHlrenpFZUdTK2IwTHBkaWdFSWRtL2xuQXZPbHUyaW0wQitPbVV4?=
 =?utf-8?B?OXhOY0FtRngrVzNkRXJrbmtMVTU1bVp3REUzZ3pOMGppLzhhbXZRYTV1L3lQ?=
 =?utf-8?B?ZkxRSTlmWG5NdjU3d3g2ZW5RVFVqNkxtcCtsdmRRd2VETUZkUTIzSXBrNmE2?=
 =?utf-8?B?Y1QwektSNXVjWTVyVkU2NGU1Q2ZkMVdTT2RRSjYxUHM4clIweElINUlDbWl1?=
 =?utf-8?B?UExCckFSaVN6ZTdRRE03ZmtHWGx2cnJMdmJ6c1JUZFlyajFRU0M5MWgvQXk3?=
 =?utf-8?B?YVVhN2ZLemM5RC8vc0dLV0pwWEZNcldHMlpnN3l5R0dzOHJXa3QwWjlBZitK?=
 =?utf-8?B?UVZpbjRUT3hHeGhxQVRuVnpaYXZTcm41eXJZSEloTUJLV0V6UnJsRHhrMVdm?=
 =?utf-8?B?UmVERC8rSTh4Y0lLeE5rUEpnaGZUMndVcmViRmU0SHE0NHZ4UUxweGJVVmM0?=
 =?utf-8?B?MjFWUXdJd3c4eDJZb3VBdVJJeGtWM0VzL2RXdE15dWY2Mk9scnoyUWI0UkVI?=
 =?utf-8?B?aWtGYmFaUTcrRVdGcDZZcWtOeENWblNMZkpUeXUwQVNpN1djRzQ3UC9xc1A5?=
 =?utf-8?B?eldsRDhqSTlvZkcrMFUwNnBNaHREUVpET0JMQy8xaHg3c2lBS25kbEJyS2dm?=
 =?utf-8?B?YXE2amhmdjVXUWVYWlVUQTNQbjltTURtc1IzeVdMYmFzQndTeG1PMGtkVWZj?=
 =?utf-8?B?SG5LY0MvQVA4OXQ0OXd4TStmdy9QKzBIQ29OdXZmZnUvMjdtN3Y2VnI0TE9l?=
 =?utf-8?B?ZnNja3grYU56R2M4VlNNcldqNG14SUcyeE1hTGtaRVM4dUdmQ2JaamtMaUtz?=
 =?utf-8?B?RFlicy9ieUUrSTQ4TnRhSnh0c1lOdWJJQ21Fb2F6YUtlZkQxbWI4aGVsblRr?=
 =?utf-8?B?TlNQM2pOWkNEZVJxS1Z5dDV6eTVCcFRmRXJIazdSMmVibFJiVVZtZU8ydzl0?=
 =?utf-8?B?QTZDTTZqNm5HSmk1QVd4T3BBYmxnRVBxTCtBSkY1Y2xZakVWM2o1dS9McjN4?=
 =?utf-8?B?aVdYTnczM2JZdFVhNVVhMmhYOHpnZkhTR0wyenFLb0c0ZkYrNFZuNy9yUWJJ?=
 =?utf-8?B?MjhvanpaRjczTG80Q001OUwyazZyMkF5OFFTSHBCNUJHck1laG9Ud01KUGRa?=
 =?utf-8?B?aG40dGh0aEJFQ2tFWlpyMXBoZ1pOSmkrOGpUWHJDQWdjMTZPRStFNXk0ckxX?=
 =?utf-8?Q?Cci1KqkSZBpabPR0GFSnB1un6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C31252BAB6A7E478614D1C971A251EE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7ea1f0-d90e-4ef5-aba1-08dce83e800a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 08:43:51.3270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSyCOEGri+E9TgSRqP1q6gxxEAVZKegRevAP0veirJAtSDKn7vxYoYNMPTeZME+DKX/8gATaF2SSkKqK7Jz4Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7797

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDI0LTEwLTA4IGF0IDEwOjAzICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDgvMTAvMjQgMDk6NDEsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBNb24s
IDIwMjQtMTAtMDcgYXQgMTE6MzEgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdy
b3RlOg0KPiA+ID4gSXQgaXMgaW1wb3NzaWJsZSB0byBhZGQgZWFjaCBhbmQgZXZlcnkgcG9zc2li
bGUgRERQIHBhdGggY29tYmluYXRpb24NCj4gPiA+IGZvciBlYWNoIGFuZCBldmVyeSBwb3NzaWJs
ZSBjb21iaW5hdGlvbiBvZiBTb0MgYW5kIGJvYXJkOiByaWdodCBub3csDQo+ID4gPiB0aGlzIGRy
aXZlciBoYXJkY29kZXMgY29uZmlndXJhdGlvbiBmb3IgMTAgU29DcyBhbmQgdGhpcyBpcyBnb2lu
ZyB0bw0KPiA+ID4gZ3JvdyBsYXJnZXIgYW5kIGxhcmdlciwgYW5kIHdpdGggbmV3IGhhY2tzIGxp
a2UgdGhlIGludHJvZHVjdGlvbiBvZg0KPiA+ID4gbXRrX2RybV9yb3V0ZSB3aGljaCBpcyBhbnl3
YXkgbm90IGVub3VnaCBmb3IgYWxsIGZpbmFsIHJvdXRlcyBhcyB0aGUNCj4gPiA+IERTSSBjYW5u
b3QgYmUgY29ubmVjdGVkIHRvIE1FUkdFIGlmIGl0J3Mgbm90IGEgZHVhbC1EU0ksIG9yIGVuYWJs
aW5nDQo+ID4gPiBEU0MgcHJldmVudGl2ZWx5IGRvZXNuJ3Qgd29yayBpZiB0aGUgZGlzcGxheSBk
b2Vzbid0IHN1cHBvcnQgaXQsIG9yDQo+ID4gPiBvdGhlcnMuDQo+ID4gPiANCj4gPiA+IFNpbmNl
IHByYWN0aWNhbGx5IGFsbCBkaXNwbGF5IElQcyBpbiBNZWRpYVRlayBTb0NzIHN1cHBvcnQgYmVp
bmcNCj4gPiA+IGludGVyY29ubmVjdGVkIHdpdGggZGlmZmVyZW50IGluc3RhbmNlcyBvZiBvdGhl
ciwgb3IgdGhlIHNhbWUsIElQcw0KPiA+ID4gb3Igd2l0aCBkaWZmZXJlbnQgSVBzIGFuZCBpbiBk
aWZmZXJlbnQgY29tYmluYXRpb25zLCB0aGUgZmluYWwgRERQDQo+ID4gPiBwaXBlbGluZSBpcyBl
ZmZlY3RpdmVseSBhIGJvYXJkIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24uDQo+ID4gPiANCj4gPiA+
IEltcGxlbWVudCBPRiBncmFwaHMgc3VwcG9ydCB0byB0aGUgbWVkaWF0ZWstZHJtIGRyaXZlcnMs
IGFsbG93aW5nIHRvDQo+ID4gPiBzdG9wIGhhcmRjb2RpbmcgdGhlIHBhdGhzLCBhbmQgcHJldmVu
dGluZyB0aGlzIGRyaXZlciB0byBnZXQgYSBodWdlDQo+ID4gPiBhbW91bnQgb2YgYXJyYXlzIGZv
ciBlYWNoIGJvYXJkIGFuZCBTb0MgY29tYmluYXRpb24sIGFsc28gcGF2aW5nIHRoZQ0KPiA+ID4g
d2F5IHRvIHNoYXJlIHRoZSBzYW1lIG10a19tbXN5c19kcml2ZXJfZGF0YSBiZXR3ZWVuIG11bHRp
cGxlIFNvQ3MsDQo+ID4gPiBtYWtpbmcgaXQgbW9yZSBzdHJhaWdodGZvcndhcmQgdG8gYWRkIHN1
cHBvcnQgZm9yIG5ldyBjaGlwcy4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRy
ZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+ID4gPiBUZXN0ZWQtYnk6IEFsZXhh
bmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+ID4gPiBBY2tlZC1ieTogU3Vp
IEppbmdmZW5nIDxzdWkuamluZ2ZlbmdAbGludXguZGV2Pg0KPiA+ID4gVGVzdGVkLWJ5OiBNaWNo
YWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4gIyBvbiBrb250cm9uLXNiYy1pMTIwMA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2Fj
Y2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+IC0tLQ0KPiA+IA0KPiA+IFtzbmlw
XQ0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gK2Jvb2wgbXRrX292bF9hZGFwdG9yX2lzX2NvbXBfcHJl
c2VudChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQo+ID4gPiArew0KPiA+ID4gKwllbnVtIG10
a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgdHlwZTsNCj4gPiA+ICsJaW50IHJldDsNCj4gPiA+ICsN
Cj4gPiA+ICsJcmV0ID0gb3ZsX2FkYXB0b3Jfb2ZfZ2V0X2RkcF9jb21wX3R5cGUobm9kZSwgJnR5
cGUpOw0KPiA+ID4gKwlpZiAocmV0KQ0KPiA+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ID4gKw0K
PiA+ID4gKwlpZiAodHlwZSA+PSBPVkxfQURBUFRPUl9UWVBFX05VTSkNCj4gPiA+ICsJCXJldHVy
biBmYWxzZTsNCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogSW4gdGhlIGNvbnRleHQg
b2YgbWVkaWF0ZWstZHJtLCBFVEhEUiwgTURQX1JETUEgYW5kIFBhZGRpbmcgYXJlDQo+ID4gPiAr
CSAqIHVzZWQgZXhjbHVzaXZlbHkgYnkgT1ZMIEFkYXB0b3I6IGlmIHRoaXMgY29tcG9uZW50IGlz
IG5vdCBvbmUgb2YNCj4gPiA+ICsJICogdGhvc2UsIGl0J3MgbGlrZWx5IG5vdCBhbiBPVkwgQWRh
cHRvciBwYXRoLg0KPiA+ID4gKwkgKi8NCj4gPiA+ICsJcmV0dXJuIHR5cGUgPT0gT1ZMX0FEQVBU
T1JfVFlQRV9FVEhEUiB8fA0KPiA+ID4gKwkgICAgICAgdHlwZSA9PSBPVkxfQURBUFRPUl9UWVBF
X01EUF9SRE1BIHx8DQo+ID4gPiArCSAgICAgICB0eXBlID09IE9WTF9BREFQVE9SX1RZUEVfUEFE
RElORzsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gDQo+ID4gW3NuaXBdDQo+ID4gDQo+ID4gPiAr
DQo+ID4gPiArc3RhdGljIGludCBtdGtfZHJtX29mX2dldF9kZHBfZXBfY2lkKHN0cnVjdCBkZXZp
Y2Vfbm9kZSAqbm9kZSwNCj4gPiA+ICsJCQkJICAgICBpbnQgb3V0cHV0X3BvcnQsIGVudW0gbXRr
X2NydGNfcGF0aCBjcnRjX3BhdGgsDQo+ID4gPiArCQkJCSAgICAgc3RydWN0IGRldmljZV9ub2Rl
ICoqbmV4dCwgdW5zaWduZWQgaW50ICpjaWQpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgZGV2
aWNlX25vZGUgKmVwX2Rldl9ub2RlLCAqZXBfb3V0Ow0KPiA+ID4gKwllbnVtIG10a19kZHBfY29t
cF90eXBlIGNvbXBfdHlwZTsNCj4gPiA+ICsJaW50IHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJZXBf
b3V0ID0gb2ZfZ3JhcGhfZ2V0X2VuZHBvaW50X2J5X3JlZ3Mobm9kZSwgb3V0cHV0X3BvcnQsIGNy
dGNfcGF0aCk7DQo+ID4gPiArCWlmICghZXBfb3V0KQ0KPiA+ID4gKwkJcmV0dXJuIC1FTk9FTlQ7
DQo+ID4gPiArDQo+ID4gPiArCWVwX2Rldl9ub2RlID0gb2ZfZ3JhcGhfZ2V0X3JlbW90ZV9wb3J0
X3BhcmVudChlcF9vdXQpOw0KPiA+ID4gKwlvZl9ub2RlX3B1dChlcF9vdXQpOw0KPiA+ID4gKwlp
ZiAoIWVwX2Rldl9ub2RlKQ0KPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4g
PiArCS8qDQo+ID4gPiArCSAqIFBhc3MgdGhlIG5leHQgbm9kZSBwb2ludGVyIHJlZ2FyZGxlc3Mg
b2YgZmFpbHVyZXMgaW4gdGhlIGxhdGVyIGNvZGUNCj4gPiA+ICsJICogc28gdGhhdCBpZiB0aGlz
IGZ1bmN0aW9uIGlzIGNhbGxlZCBpbiBhIGxvb3AgaXQgd2lsbCB3YWxrIHRocm91Z2ggYWxsDQo+
ID4gPiArCSAqIG9mIHRoZSBzdWJzZXF1ZW50IGVuZHBvaW50cyBhbnl3YXkuDQo+ID4gPiArCSAq
Lw0KPiA+ID4gKwkqbmV4dCA9IGVwX2Rldl9ub2RlOw0KPiA+ID4gKw0KPiA+ID4gKwlpZiAoIW9m
X2RldmljZV9pc19hdmFpbGFibGUoZXBfZGV2X25vZGUpKQ0KPiA+ID4gKwkJcmV0dXJuIC1FTk9E
RVY7DQo+ID4gPiArDQo+ID4gPiArCXJldCA9IG10a19kcm1fb2ZfZ2V0X2RkcF9jb21wX3R5cGUo
ZXBfZGV2X25vZGUsICZjb21wX3R5cGUpOw0KPiA+ID4gKwlpZiAocmV0KSB7DQo+ID4gPiArCQlp
ZiAobXRrX292bF9hZGFwdG9yX2lzX2NvbXBfcHJlc2VudChlcF9kZXZfbm9kZSkpIHsNCj4gPiA+
ICsJCQkqY2lkID0gKHVuc2lnbmVkIGludClERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUjsN
Cj4gPiA+ICsJCQlyZXR1cm4gMDsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJCXJldHVybiByZXQ7DQo+
ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJcmV0ID0gbXRrX2RkcF9jb21wX2dldF9pZChlcF9k
ZXZfbm9kZSwgY29tcF90eXBlKTsNCj4gPiA+ICsJaWYgKHJldCA8IDApDQo+ID4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwkvKiBBbGwgb2shIFBhc3MgdGhlIENvbXBvbmVudCBJ
RCB0byB0aGUgY2FsbGVyLiAqLw0KPiA+ID4gKwkqY2lkID0gKHVuc2lnbmVkIGludClyZXQ7DQo+
ID4gPiArDQo+ID4gPiArCXJldHVybiAwOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICsvKioN
Cj4gPiA+ICsgKiBtdGtfZHJtX29mX2RkcF9wYXRoX2J1aWxkX29uZSAtIEJ1aWxkIGEgRGlzcGxh
eSBIVyBQaXBlbGluZSBmb3IgYSBDUlRDIFBhdGgNCj4gPiA+ICsgKiBAZGV2OiAgICAgICAgICBU
aGUgbWVkaWF0ZWstZHJtIGRldmljZQ0KPiA+ID4gKyAqIEBjcGF0aDogICAgICAgIENSVEMgUGF0
aCByZWxhdGl2ZSB0byBhIFZETyBvciBNTVNZUw0KPiA+ID4gKyAqIEBvdXRfcGF0aDogICAgIFBv
aW50ZXIgdG8gYW4gYXJyYXkgdGhhdCB3aWxsIGNvbnRhaW4gdGhlIG5ldyBwaXBlbGluZQ0KPiA+
ID4gKyAqIEBvdXRfcGF0aF9sZW46IE51bWJlciBvZiBlbnRyaWVzIGluIHRoZSBwaXBlbGluZSBh
cnJheQ0KPiA+ID4gKyAqDQo+ID4gPiArICogTWVkaWFUZWsgU29DcyBjYW4gdXNlIGRpZmZlcmVu
dCBERFAgaGFyZHdhcmUgcGlwZWxpbmVzIChvciBwYXRocykgZGVwZW5kaW5nDQo+ID4gPiArICog
b24gdGhlIGJvYXJkLXNwZWNpZmljIGRlc2lyZWQgZGlzcGxheSBjb25maWd1cmF0aW9uOyB0aGlz
IGZ1bmN0aW9uIHdhbGtzDQo+ID4gPiArICogdGhyb3VnaCBhbGwgb2YgdGhlIG91dHB1dCBlbmRw
b2ludHMgc3RhcnRpbmcgZnJvbSBhIFZETyBvciBNTVNZUyBoYXJkd2FyZQ0KPiA+ID4gKyAqIGlu
c3RhbmNlIGFuZCBidWlsZHMgdGhlIHJpZ2h0IHBpcGVsaW5lIGFzIHNwZWNpZmllZCBpbiBkZXZp
Y2UgdHJlZXMuDQo+ID4gPiArICoNCj4gPiA+ICsgKiBSZXR1cm46DQo+ID4gPiArICogKiAlMCAg
ICAgICAtIERpc3BsYXkgSFcgUGlwZWxpbmUgc3VjY2Vzc2Z1bGx5IGJ1aWx0IGFuZCB2YWxpZGF0
ZWQNCj4gPiA+ICsgKiAqICUtRU5PRU5UIC0gRGlzcGxheSBwaXBlbGluZSB3YXMgbm90IHNwZWNp
ZmllZCBpbiBkZXZpY2UgdHJlZQ0KPiA+ID4gKyAqICogJS1FSU5WQUwgLSBEaXNwbGF5IHBpcGVs
aW5lIGJ1aWx0IGJ1dCB2YWxpZGF0aW9uIGZhaWxlZA0KPiA+ID4gKyAqICogJS1FTk9NRU0gLSBG
YWlsdXJlIHRvIGFsbG9jYXRlIHBpcGVsaW5lIGFycmF5IHRvIHBhc3MgdG8gdGhlIGNhbGxlcg0K
PiA+ID4gKyAqLw0KPiA+ID4gK3N0YXRpYyBpbnQgbXRrX2RybV9vZl9kZHBfcGF0aF9idWlsZF9v
bmUoc3RydWN0IGRldmljZSAqZGV2LCBlbnVtIG10a19jcnRjX3BhdGggY3BhdGgsDQo+ID4gPiAr
CQkJCQkgY29uc3QgdW5zaWduZWQgaW50ICoqb3V0X3BhdGgsDQo+ID4gPiArCQkJCQkgdW5zaWdu
ZWQgaW50ICpvdXRfcGF0aF9sZW4pDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3QgZGV2aWNlX25v
ZGUgKm5leHQsICpwcmV2LCAqdmRvID0gZGV2LT5wYXJlbnQtPm9mX25vZGU7DQo+ID4gPiArCXVu
c2lnbmVkIGludCB0ZW1wX3BhdGhbRERQX0NPTVBPTkVOVF9EUk1fSURfTUFYXSA9IHsgMCB9Ow0K
PiA+ID4gKwl1bnNpZ25lZCBpbnQgKmZpbmFsX2RkcF9wYXRoOw0KPiA+ID4gKwl1bnNpZ25lZCBz
aG9ydCBpbnQgaWR4ID0gMDsNCj4gPiA+ICsJYm9vbCBvdmxfYWRhcHRvcl9jb21wX2FkZGVkID0g
ZmFsc2U7DQo+ID4gPiArCWludCByZXQ7DQo+ID4gPiArDQo+ID4gPiArCS8qIEdldCB0aGUgZmly
c3QgZW50cnkgZm9yIHRoZSB0ZW1wX3BhdGggYXJyYXkgKi8NCj4gPiA+ICsJcmV0ID0gbXRrX2Ry
bV9vZl9nZXRfZGRwX2VwX2NpZCh2ZG8sIDAsIGNwYXRoLCAmbmV4dCwgJnRlbXBfcGF0aFtpZHhd
KTsNCj4gPiA+ICsJaWYgKHJldCkgew0KPiA+ID4gKwkJaWYgKG5leHQgJiYgdGVtcF9wYXRoW2lk
eF0gPT0gRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IpIHsNCj4gPiA+ICsJCQlkZXZfZGJn
KGRldiwgIkFkZGluZyBPVkwgQWRhcHRvciBmb3IgJXBPRlxuIiwgbmV4dCk7DQo+ID4gPiArCQkJ
b3ZsX2FkYXB0b3JfY29tcF9hZGRlZCA9IHRydWU7DQo+ID4gPiArCQl9IGVsc2Ugew0KPiA+ID4g
KwkJCWlmIChuZXh0KQ0KPiA+ID4gKwkJCQlkZXZfZXJyKGRldiwgIkludmFsaWQgY29tcG9uZW50
ICVwT0ZcbiIsIG5leHQpOw0KPiA+ID4gKwkJCWVsc2UNCj4gPiA+ICsJCQkJZGV2X2VycihkZXYs
ICJDYW5ub3QgZmluZCBmaXJzdCBlbmRwb2ludCBmb3IgcGF0aCAlZFxuIiwgY3BhdGgpOw0KPiA+
ID4gKw0KPiA+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gPiArCQl9DQo+ID4gPiArCX0NCj4gPiA+
ICsJaWR4Kys7DQo+ID4gPiArDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIFdhbGsgdGhyb3VnaCBw
b3J0IG91dHB1dHMgdW50aWwgd2UgcmVhY2ggdGhlIGxhc3QgdmFsaWQgbWVkaWF0ZWstZHJtIGNv
bXBvbmVudC4NCj4gPiA+ICsJICogVG8gYmUgdmFsaWQsIHRoaXMgbXVzdCBlbmQgd2l0aCBhbiAi
aW52YWxpZCIgY29tcG9uZW50IHRoYXQgaXMgYSBkaXNwbGF5IG5vZGUuDQo+ID4gPiArCSAqLw0K
PiA+ID4gKwlkbyB7DQo+ID4gPiArCQlwcmV2ID0gbmV4dDsNCj4gPiA+ICsJCXJldCA9IG10a19k
cm1fb2ZfZ2V0X2RkcF9lcF9jaWQobmV4dCwgMSwgY3BhdGgsICZuZXh0LCAmdGVtcF9wYXRoW2lk
eF0pOw0KPiA+ID4gKwkJb2Zfbm9kZV9wdXQocHJldik7DQo+ID4gPiArCQlpZiAocmV0KSB7DQo+
ID4gPiArCQkJb2Zfbm9kZV9wdXQobmV4dCk7DQo+ID4gPiArCQkJYnJlYWs7DQo+ID4gPiArCQl9
DQo+ID4gPiArDQo+ID4gPiArCQkvKg0KPiA+ID4gKwkJICogSWYgdGhpcyBpcyBhbiBPVkwgYWRh
cHRvciBleGNsdXNpdmUgY29tcG9uZW50IGFuZCBvbmUgb2YgdGhvc2UNCj4gPiA+ICsJCSAqIHdh
cyBhbHJlYWR5IGFkZGVkLCBkb24ndCBhZGQgYW5vdGhlciBpbnN0YW5jZSBvZiB0aGUgZ2VuZXJp
Yw0KPiA+ID4gKwkJICogRERQX0NPTVBPTkVOVF9PVkxfQURBUFRPUiwgYXMgdGhpcyBpcyB1c2Vk
IG9ubHkgdG8gZGVjaWRlIHdoZXRoZXINCj4gPiA+ICsJCSAqIHRvIHByb2JlIHRoYXQgY29tcG9u
ZW50IG1hc3RlciBkcml2ZXIgb2Ygd2hpY2ggb25seSBvbmUgaW5zdGFuY2UNCj4gPiA+ICsJCSAq
IGlzIG5lZWRlZCBhbmQgcG9zc2libGUuDQo+ID4gPiArCQkgKi8NCj4gPiA+ICsJCWlmICh0ZW1w
X3BhdGhbaWR4XSA9PSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUikgew0KPiA+ID4gKwkJ
CWlmICghb3ZsX2FkYXB0b3JfY29tcF9hZGRlZCkNCj4gPiA+ICsJCQkJb3ZsX2FkYXB0b3JfY29t
cF9hZGRlZCA9IHRydWU7DQo+ID4gPiArCQkJZWxzZQ0KPiA+ID4gKwkJCQlpZHgtLTsNCj4gPiA+
ICsJCX0NCj4gPiA+ICsJfSB3aGlsZSAoKytpZHggPCBERFBfQ09NUE9ORU5UX0RSTV9JRF9NQVgp
Ow0KPiA+IA0KPiA+IEZvciB0aGUgbXQ4MTk1IGV4dGVybmFsIGRpc3BsYXkgcGF0aCwgdGhlIE9G
IGdyYXBoIGlzDQo+ID4gDQo+ID4gbWRwX3JkbWEgKDAgfiA3KSAtPiBwYWRkaW5nICgwIH4gNykg
LT4gbWVyZ2UgKDEgfiA0KSAtPiBldGhkciAtPiBtZXJnZTUNCj4gPiANCj4gPiBhbmQgdGhpcyBm
dW5jdGlvbiB3b3VsZCBnZW5lcmF0ZSB0aGUgcGF0aCBhcw0KPiA+IA0KPiA+IG92bF9hZGFwdG9y
IC0+IG1lcmdlICgxIH4gNCkgLT4gbWVyZ2UgNQ0KPiA+IA0KPiA+IFRoaXMgaXMgbm90IHdoYXQg
SSBleHBlY3QuDQo+ID4gSXMgYW55IHRoaW5nIHdyb25nIHdpdGggbWU/DQo+ID4gDQo+IA0KPiBJ
IG1lYW4gbm8gb2ZmZW5zZSwgcmVhbGx5LCBidXQgeW91ciByZXBseSBoZXJlIGlzIGEgY29udHJh
ZGljdGlvbi4uLg0KPiANCj4gSW4gWzFdLCB5b3UgZXhwbGFpbmVkIHdoYXQgdGhlIHBhdGggZm9y
IHRoZSBleHRlcm5hbCBkaXNwbGF5IHNob3VsZCBsb29rIGxpa2UNCj4gYW5kIHNhaWQgdGhhdCB0
aGUgZ3JhcGggaW4gRFQgc2hvdWxkIGdlbmVyYXRlIGEgcGF0aCB3aGljaCwgaW4gdGhlIGRyaXZl
ciwgc2hhbGwNCj4gbG9vayBsaWtlIHRoZSBjdXJyZW50IG10ODE5NV9tdGtfZGRwX2V4dFtdIGhh
cmRjb2RlZCBhcnJheS4NCj4gDQo+IEluIFsyXSwgeW91IHJlcGVhdGVkIHRoYXQgeW91ICJqdXN0
IHdhbnQgdGhlIHBhdGggdG8gYmUgbGlrZSBtdDgxOTVfbXRrX2RkcF9leHRbXSIuDQo+IA0KPiBO
b3cgeW91J3JlIHNheWluZyB0aGF0IHRoaXMgaXMgbm90IHdoYXQgeW91IGV4cGVjdC4NCj4gSSBk
b24ndCB1bmRlcnN0YW5kIHlvdXIgaW50ZW50aW9uLg0KDQpJbiBbMV0gJiBbMl0sIEkgd2FudCB0
aGUgcGF0aCB0byBiZSBsaWtlIG10ODE5NV9tdGtfZGRwX2V4dFtdLiBJIGRvbid0IGtub3cgd2hl
cmUgaXMgdGhlIGNvbnRyYWRpY3Rpb24/DQptdDgxOTVfbXRrX2RkcF9leHRbXSBpczoNCg0Kb3Zs
X2FkYXB0b3IgLT4gbWVyZ2U1DQoNCmJ1dCB0aGlzIHBhdGNoIGdlbmVyYXRlIHRoZSBwYXRoIGFz
DQoNCm92bF9hZGFwdG9yIC0+IG1lcmdlICgxIH4gNCkgLT4gbWVyZ2U1DQoNCml0J3Mgbm90IHRo
ZSBzYW1lIGFuZCB0aGlzIG1heSBjYXVzZSBzb21ldGhpbmcgd3JvbmcuDQpJJ20gc29ycnkgbXkg
ZXhwcmVzc2lvbiBtYWtlIHlvdSBjb25mdXNlZC4NClNvIHdoYXQgSSB3YW50IGlzIHRvIGdlbmVy
YXRlIHRoZSBwYXRoIGFzDQoNCm92bF9hZGFwdG9yIC0+IG1lcmdlNQ0KDQpSZWdhcmRzLA0KQ0sN
Cg0KPiANCj4gWzFdOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzU4ZWUwOWFlYjVh
MjI0ZGJjOGZhZWUyMzZlZDFhNzdjZTNmYmQwMTEuY2FtZWxAbWVkaWF0ZWsuY29tLw0KPiANCj4g
WzJdOiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzA0ZjE1MDZiMjNiNDFjNzc1ZTA3
MzViNWIzMTg5YjQxMTg1MDA3MTUuY2FtZWxAbWVkaWF0ZWsuY29tLw0KPiANCj4gUmVnYXJkcywN
Cj4gQW5nZWxvDQo+IA0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gKwkvKg0KPiA+ID4gKwkgKiBUaGUg
ZGV2aWNlIGNvbXBvbmVudCBtaWdodCBub3QgYmUgZW5hYmxlZDogaW4gdGhhdCBjYXNlLCBkb24n
dA0KPiA+ID4gKwkgKiBjaGVjayB0aGUgbGFzdCBlbnRyeSBhbmQganVzdCByZXBvcnQgdGhhdCB0
aGUgZGV2aWNlIGlzIG1pc3NpbmcuDQo+ID4gPiArCSAqLw0KPiA+ID4gKwlpZiAocmV0ID09IC1F
Tk9ERVYpDQo+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKwkvKiBJZiB0aGUg
bGFzdCBlbnRyeSBpcyBub3QgYSBmaW5hbCBkaXNwbGF5IG91dHB1dCwgdGhlIGNvbmZpZ3VyYXRp
b24gaXMgd3JvbmcgKi8NCj4gPiA+ICsJc3dpdGNoICh0ZW1wX3BhdGhbaWR4IC0gMV0pIHsNCj4g
PiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RQX0lOVEYwOg0KPiA+ID4gKwljYXNlIEREUF9DT01Q
T05FTlRfRFBfSU5URjE6DQo+ID4gPiArCWNhc2UgRERQX0NPTVBPTkVOVF9EUEkwOg0KPiA+ID4g
KwljYXNlIEREUF9DT01QT05FTlRfRFBJMToNCj4gPiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RT
STA6DQo+ID4gPiArCWNhc2UgRERQX0NPTVBPTkVOVF9EU0kxOg0KPiA+ID4gKwljYXNlIEREUF9D
T01QT05FTlRfRFNJMjoNCj4gPiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RTSTM6DQo+ID4gPiAr
CQlicmVhazsNCj4gPiA+ICsJZGVmYXVsdDoNCj4gPiA+ICsJCWRldl9lcnIoZGV2LCAiSW52YWxp
ZCBkaXNwbGF5IGh3IHBpcGVsaW5lLiBMYXN0IGNvbXBvbmVudDogJWQgKHJldD0lZClcbiIsDQo+
ID4gPiArCQkJdGVtcF9wYXRoW2lkeCAtIDFdLCByZXQpOw0KPiA+ID4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJZmluYWxfZGRwX3BhdGggPSBkZXZtX2tt
ZW1kdXAoZGV2LCB0ZW1wX3BhdGgsIGlkeCAqIHNpemVvZih0ZW1wX3BhdGhbMF0pLCBHRlBfS0VS
TkVMKTsNCj4gPiA+ICsJaWYgKCFmaW5hbF9kZHBfcGF0aCkNCj4gPiA+ICsJCXJldHVybiAtRU5P
TUVNOw0KPiA+ID4gKw0KPiA+ID4gKwlkZXZfZGJnKGRldiwgIkRpc3BsYXkgSFcgUGlwZWxpbmUg
YnVpbHQgd2l0aCAlZCBjb21wb25lbnRzLlxuIiwgaWR4KTsNCj4gPiA+ICsNCj4gPiA+ICsJLyog
UGlwZWxpbmUgYnVpbHQhICovDQo+ID4gPiArCSpvdXRfcGF0aCA9IGZpbmFsX2RkcF9wYXRoOw0K
PiA+ID4gKwkqb3V0X3BhdGhfbGVuID0gaWR4Ow0KPiA+ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsN
Cj4gPiA+ICt9DQo+ID4gPiArDQo+IA0KPiANCg==

