Return-Path: <linux-kernel+bounces-514261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7965FA354C2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 03:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A433AD4F3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 02:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F10013B58D;
	Fri, 14 Feb 2025 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tbfzIsfV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="prAnaCSe"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443142AE97;
	Fri, 14 Feb 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739500539; cv=fail; b=X6tnP/rhwFTRlBiayK06TTN+1RSquCAWKQpPKdXMFAl7skzgd9mLiSyvmsKnMkDo9HvZj1KxFh2JwVDRxd2F/pVB7umpnLgW9qEmbp2j1iIwFcs9fcz3HJhW8CVXu1V9VcQTyOTUzQK49amakCr4CsPZaYeLu6e47vPlWSNJGk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739500539; c=relaxed/simple;
	bh=PS4q643Vb88Int1oMy0oWKfeDhyVLug3IzjW+oXuoHg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WOYFWUUhqBNfC75a4+c35cY8QaMKOycoy/+PRAE7sNIV1wiJWyTUsPQEEUs9sBVt65zPdLTNtsLI3WdPtS68rXrtJwhXzwjzD6RkanxvrvQR9f/nfDNFAcwe50MXHKR+s5Dy1E+0Ew+adJK1/cOFfCjhMg2fsEgKcjZJoBguIpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=tbfzIsfV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=prAnaCSe; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5c5aa352ea7c11efb8f9918b5fc74e19-20250214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PS4q643Vb88Int1oMy0oWKfeDhyVLug3IzjW+oXuoHg=;
	b=tbfzIsfVuWd5YYKwKO5PAgcaVbhxjVWyjpuXFn4N8p8LcsNbkaOwOHDHpGulM5cJ6q+DKNIaCe8+bXKMNqMAZCZyaaqHmvoEbzdmN9vSL76uJkuMRVnM50/CjvetIBIeHh2PvUybbJ4crIZEpHnD5lZZDylIlcZ2pHTh1a1+D3k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:6cb06819-fbe8-4901-9c5b-c3db532ece42,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:cb748c27-6332-4494-ac76-ecdca2a41930,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5c5aa352ea7c11efb8f9918b5fc74e19-20250214
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1316668477; Fri, 14 Feb 2025 10:35:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Feb 2025 10:35:30 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Feb 2025 10:35:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOX/KGqLRSJMXNSC5Oogk62BTyfdBlVYtgdgg7IvA+yU0XoFQdTlryQVNUXnFEYxN+nzD4w4bc9Q1vfZncGm+lxn3XJhpiP6JX5/wPlaFQuAj6jBcADQF+VM6Dm3S0lFmdRWk/mVAsWY3ILkB1lFGya05YFvpSoMczX4OE9UbcSWb4cf9qajqQpLE/+He+l5qZuFAIOzNG1644uj4xx8tVljVyO6N/3GMZxmORZCZHtn22HTCNtWQIlSNcCqq5Ad6GfzitXSGElAcovo+191N9PkiZPrsOi4q1xj9cfMKSyCFn7fwMYK1JSZZ2Iv875NKejjbvfvCBnw78Fiduv6IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PS4q643Vb88Int1oMy0oWKfeDhyVLug3IzjW+oXuoHg=;
 b=X1+uBajdmvjPcMFgcsJ9zJm6xmutk9QkNslnZr2GhmSBjkQ829V8nHHjDesL2wriO2DwBcmKMMRYWe58nEiyTf7NNxF4ANxL/EvkYzNmwuishUfiJpnyZ14nVQcDF/inzV62GcOr/7ppO5kMW6YOB7b33+6wFLOo6AiasswikjmeNH/qxWCwy9ZcRnQegVI+YUk2+NKntrJ5QxXQVViv9St0itNS4eTL8hMOFPWTDdin/NEGqzowNZkXTFh1F+MG45iA2Gu946pf836e50XfKwuzMRPmRM1av+H7chJojl7llFHxWhjlNSMQe6PRhfLM7NMOgDaSAmfcFtQBzsjYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PS4q643Vb88Int1oMy0oWKfeDhyVLug3IzjW+oXuoHg=;
 b=prAnaCSezGg7SRfWd9N423v1CH6ep+Sc2/RpLxkwWOk7YlWmyW0icAW+rcv/5l1Ol34qT7AdJJ7VZOmK+5VPLUhWN3Er5NDmhYG/Jl/xGDNgPu+M5tWrL7N6p2C8n7rMNVohF1aEUQb26mqhu0TIZdFg8AC3Qldhy2oKGpQJcSw=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB8661.apcprd03.prod.outlook.com (2603:1096:101:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 02:35:28 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 02:35:28 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "jie.qiu@mediatek.com"
	<jie.qiu@mediatek.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "mripard@kernel.org"
	<mripard@kernel.org>, =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?=
	<jitao.shi@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "kernel@collabora.com" <kernel@collabora.com>,
	"dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?TGV3aXMgTGlhbyAo5buW5p+P6YieKQ==?= <Lewis.Liao@mediatek.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?VG9tbXlZTCBDaGVuICjpmbPlvaXoia8p?=
	<TommyYL.Chen@mediatek.com>, =?utf-8?B?SXZlcyBDaGVuamggKOmZs+S/iuW8mCk=?=
	<Ives.Chenjh@mediatek.com>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?=
	<Jason-JH.Lin@mediatek.com>, "junzhi.zhao@mediatek.com"
	<junzhi.zhao@mediatek.com>
Subject: Re: [PATCH v6 10/42] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Topic: [PATCH v6 10/42] drm/mediatek: Add support for MT8195 Digital
 Parallel Interface
Thread-Index: AQHbfHkbsnmUA2wCtESDfM3glXcR3LNGGUSA
Date: Fri, 14 Feb 2025 02:35:28 +0000
Message-ID: <dc4d2c1efcb556e84e6f429a62464a6a3a6ab70d.camel@mediatek.com>
References: <20250211113409.1517534-1-angelogioacchino.delregno@collabora.com>
	 <20250211113409.1517534-11-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250211113409.1517534-11-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB8661:EE_
x-ms-office365-filtering-correlation-id: e8d725ba-20e3-40a6-537c-08dd4ca03e56
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Qk9kTjdDM09HTDd0K25MaCs1ZmZ3YzZ2RjZLSXhST1ZPc3N3cHVVMUV1Z3du?=
 =?utf-8?B?R2Q5aThsMmVqTFNLL2JqaDYvNTY0K1RTS3I1aXBrQmN2MjNzK2x3ZEp4ZThH?=
 =?utf-8?B?d0FsTzNFUzRqeHBBdU1nYTBLdjFDYVIyM2F5VTQyTGlFbGY2eGdndHEvMTFT?=
 =?utf-8?B?bTBLVy81TTdQVG9sMXdjTHJaUTUyUVpVaWdqYmhkUjdXcUxnZnExSEpnZWhW?=
 =?utf-8?B?K2dDQ1BqVUg4ZVBwUlErblU1ZVczcTd3U2lTanAvQzV2c3FJa0JDcDhqYWxs?=
 =?utf-8?B?SkxLSTBHMVpMOFBWYVp3ZDVZbUk0bEVOMElRQ2VvcUlxS2FHN0IxSWRFUGtk?=
 =?utf-8?B?eGI4RmlBUFhtbzM0RFh0M3F3NkVDRzBtWWlxRTNCTElnVjlNSmE5ZkQxaXdw?=
 =?utf-8?B?UUVnVHd0S3V0YXYxZkJ5VXdsZUltakVSVk5OcHlKNlJQQWpLQU9ENThoc0Ft?=
 =?utf-8?B?WW15eTJqK3pmOVZvQnJFMldLOVo4Q0JpWE5SRnRJRzVkbVIrWW9GSGpPVTll?=
 =?utf-8?B?aXU5ZEEzSDlpTGxxSE1IUDZpdk9JVFZXVTRiMlk1a1cxVEdJUndqQkpNTkNn?=
 =?utf-8?B?TEVSNGoxN3FFMVNmN2JsZStqYXNCOThKdlVpVklRV3NuWWV2bXNydzZiNitB?=
 =?utf-8?B?VW5NbjRpTDVUTGpKNW15STcyWlJTeHJvVFN3eDJNNkc4ZHd6cW1QR01Ba1I2?=
 =?utf-8?B?VjFQekkyUUFaUE1GcWdHWTMwUFhtazR6M2dYbXRqU2Y4bGxhbE1qbXp0VlRV?=
 =?utf-8?B?RFBrVGdUVWNxYkh6WDVZci9jTmVwV2FzSUpLeXZkN2NzaW1oaDBJUUlWUWh0?=
 =?utf-8?B?RGNXQnFjZjdDWU5rYkcxMUVzUlp3M1MrU0JzRDhaVEpYOE9VVEdVMEpDQTRO?=
 =?utf-8?B?ZERIQlluRXl6Y3h0cUdKcTZoN0dXdlNhZGYvWkJwNS9HWWhINW9hdE55Y3RP?=
 =?utf-8?B?NGVycWlWWnNYTnJvci94cXpsbWNyS1pyb0l1ck5DTURNMmkyL1pOSmhlSU1u?=
 =?utf-8?B?aVpoVzArMDZWb2ZzaDdDdHFCUVdvaTVGMUx3a0xuZWZ3bE1RZzVLOVl2Zy8w?=
 =?utf-8?B?aTI0UmxiK2hkMkwvelA1SStWWEJrNlM1WmIvZGlsYnFLaXc5Zi8vSGxQblBs?=
 =?utf-8?B?WXpzM2JCNFJObzNCU2hxSXI0T3phemxaT2dmdVp2QXp5VGZIOG1OMTZRcWF0?=
 =?utf-8?B?QWhaZnZVdXZhSlJ0Wld3Vmp0VnNuS1hHcDc1RmcvLy9qOEN2T1VPU0V0cnd3?=
 =?utf-8?B?NFJMeExQM2dpbXY1Y015bEZLYldadWtqb2I4UFo1NytyVjFPeURRRDdOcFI0?=
 =?utf-8?B?ZE9uVVlQNit5bmE4SDd5TGtMaVhIV2NVUGdsbHgxUFRLQndidGIrdWZVLzNI?=
 =?utf-8?B?OWg1b3VHRkhGYWdOZUQ5UlRoQ3BqemhzdmMxRHU2Qzh5QnhaWWFkUzhHQy9n?=
 =?utf-8?B?N2c5c3dIMWRsSVVJTnNyc0Q1a0pMMG8vYXU4Z3VIbG1rU29aTW1sUWxYcnoy?=
 =?utf-8?B?L1VMMnJVTXFjWTVGc2kwS2Ixa0RkU1RwaWFhRGxXQ1EzM0RJWVRiOElvQlBD?=
 =?utf-8?B?Wi9PNFFWbWlocEtITm1Pc1JiSEZobEFwK2l6OTgxSDJ2Y3VGck8xT281Wndh?=
 =?utf-8?B?M3JVLzR0VDJMWTJUR0NGQWFYdGU5WlN1ZWV1Y1NtM2N5YVZ0V1pQeUsxY2p3?=
 =?utf-8?B?VDdidVRQSElKRHNBdzFmVUhaVEtrUGpHZmgvQjh1L0FUbEtnYit1OHdjSGFK?=
 =?utf-8?B?ZFlEclZyeExNTm5wSlh0ZFpBdWQyQ1VicHN5RmNRcHVVcStmQVg2QllQNXdT?=
 =?utf-8?B?NytuN01nOUE3ZFdBZXI3bEQyYU5WNnUrUDdFSVNJT1pjQWlMeTVjSkZVMkFt?=
 =?utf-8?B?ZFZNMmlkb2RNOFI2VVlBSXc3T3FGeDJzbUpNT2dqSGtsR1QwRHhLV29hdnRs?=
 =?utf-8?Q?3yZ/qBcgiPS/A5yIX3hAvvlWtVJSM586?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3BVejlxbElCcEg4Z1g4T0Rad2k4Ymdua0NGUzRyTTNWeFM5OEd6ZERGUmhI?=
 =?utf-8?B?dFFzSWNRTGJKWFJOKzRuWUhjWTk4QjhMNGpBY2lLUk1tWGh6QkNKZVhzRkxP?=
 =?utf-8?B?cE9IN0tyVEMvWVJQMU1EZyt0a080N2cwc1FKOFBROEQzMDRQNEkyVkxVU3ow?=
 =?utf-8?B?QXY5a1lKUklPOFRNanVER1VFU09FMnduTEh5djFmeEZrcFhWSmRaSkhqZG9K?=
 =?utf-8?B?MXNWSElJcm1DbjV2ZGhqT3F6ZExWZWNDYm95SERZVXhBVUROdW44ZUR0RlJZ?=
 =?utf-8?B?UCtnaS9xdEtaWis1N1ZjR1ByQUR1MWNzcWRNSjFRSXBTUDgrdWZPaXlPdnBI?=
 =?utf-8?B?Vis4SGxLVndOU09aTWFtajBwNkx0YXl3OGN5ZFZ2UVExd3A0UWVFYVNnWXVK?=
 =?utf-8?B?cUR3cWFIQytvK3lLV2R0TzhVUlRQajdDTFlNbWtPbGFPc3ZsdEdQYkpjNHhp?=
 =?utf-8?B?S2Iwb00vRGhHclluTGtCdjhqcnljUzkrYnBCYU44enNpVjFZUHZOV0pwMUNs?=
 =?utf-8?B?cDBGSUVtRUpIS1MxVit5K3lSOUljS1J4QTJQNjQ4TkVMbnd2dTYvSG4vWEhZ?=
 =?utf-8?B?NG10dkt6U2tuUUJRV25HOVNBbG5BeUxYamVVcWRYcjZZUkhZWnlFTGRzWU8w?=
 =?utf-8?B?OXFXVFpNYi91OENxcjQrWW9Xc08rRmszZDBnZkh5NHZSa0lRak1XbTBCZ0p1?=
 =?utf-8?B?UmYydWdTY20yeVVLKzJ6dWxncHU1a2VYc05neUNmRVh1WnFicmlIL0R5d0ts?=
 =?utf-8?B?dERjcVNpS0YwVDNvdHRUWEw5U1ppSEt2Zk5zdTlISzQvUU1zV0tmQ1UxUEpW?=
 =?utf-8?B?UkNWNnR2MUNQVkdDWUY4ZWFGd1cwUjVEemFKaEYrVXFMMlNKUE5oQ0VvNCs2?=
 =?utf-8?B?VDZacDdUNnIvdWZoQmZDbFhZeEwzK0dWTW9pVmErTUQ5UUl6L2FXZGdhaUhJ?=
 =?utf-8?B?SDFLT0F4cDFoYmZvSUZQUW5sM05zbGdPbzNJL3hSTUZiWEt6dVlIZ3FhK25w?=
 =?utf-8?B?MzNETUtFTnpFVUEvOWhEV0kyb2hUWGRxQkVoMzZES3JCMU5ZanBtY0xDUUYz?=
 =?utf-8?B?RXBBZ0d4SzRselBXaWNXNXBRenVzQTErcWpmSWFwbVpqa1hFOHo4bDRIVFVk?=
 =?utf-8?B?QkRaQkcvVTlSbCtLSWUrZHBFRUFiOCt2ZGV3eDE2WWdyL3dPWW1WV1ZnR3F6?=
 =?utf-8?B?QldpSmFlRjUvSmpCSTl0amZDdnZ0Y3N0b1J0ek52UGF4MUVNSXlpZFZZTmxV?=
 =?utf-8?B?WmVBb3ZhYTU4cXltQkl1bU1DVVFOek5RYWpaVk10R08zM05xcXYwMHpSNnll?=
 =?utf-8?B?ai8raEJRK3htbWNDaHVUOFF3UEJDSmhmYkxhRGRBcTROSEhnYkFlTUhjOW1C?=
 =?utf-8?B?TU41bmFSTWluN3IyVCtOYVcwOG9wKytMVTlrVUozQkRNSTFDamFzeU4xK1JT?=
 =?utf-8?B?Q1FEQ1k0L2M1bDBaKzlWa0UxbzRJLzdMZS91VjE1MTk5VVowWUlPSzF0bDdZ?=
 =?utf-8?B?cTVRK1BJRFdWcDFnUVRqRXF4b0c0NGtmRzAwSHhmSGYwT2xmV1lGeEJYR0I3?=
 =?utf-8?B?dUMvb25SNVliME5RSUhJSGZFSVVYTEJ2VWo2bW5YSW10S1ZuZDRSbXd1VXVQ?=
 =?utf-8?B?RmdxaFdNN2lEdXRzYXBBUDlTdDFaSDEyTU5ZVHUxOG9Qb0FHSUxpZ3ZpcHgv?=
 =?utf-8?B?WGY4OFpxYnMwUFB0clFtYnJnYTQwbGRFTlNXc3UrTHN4ZDhIVExwRTlnc2lI?=
 =?utf-8?B?ZFRLeXprVjZFZVIxMXU4QVZyQWhnT3RlckFueG5LVDV3cGV0eURvRzlYckdL?=
 =?utf-8?B?OTBVMDFsMm13RXF2NnJLN2pjckNzeS9MbTB1cHBYMDlmd0RoaEFYR05tRmJC?=
 =?utf-8?B?aFYwdUZ1Mk1iNGNobHlPalNRcDNTc2pBcG54V3BiWFVTNGNaWElUMzNqZ2dP?=
 =?utf-8?B?aW0rZVB5TFVvVFJYSXdwaWFrQkdzNE8wNG9QMHVOYWVFSjBrR3JNUDJJY3Fu?=
 =?utf-8?B?Kzh1NW96eng2YksvTm9iazg4RjcrTm1kT21heDY4VHNFOEJkVTE5aEFETjFk?=
 =?utf-8?B?Rkh0a3cyRysyY1VRRFEvcXZGV2dxK0d0V3BmM1dBNUtWZVFSR0hwaENuQ2p3?=
 =?utf-8?Q?tZ4hdD7VRgZXanQUcy5+IPjo/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1EEC12AD4113E24E9E268C14201E89A8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d725ba-20e3-40a6-537c-08dd4ca03e56
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 02:35:28.0451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/HY/RwtTpxOM4qxjkV/ssTExTaWPWmurVEb+DWLn4P3imogntVFFmAXkuoTMyfm/FGs0+ry6/tcu5J1VkWtNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8661

T24gVHVlLCAyMDI1LTAyLTExIGF0IDEyOjMzICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3IgdGhlIERQSSBibG9jayBm
b3VuZCBpbiB0aGUgTVQ4MTk1IGFuZCBNVDgxODggU29Dcy4NCj4gSW5zaWRlIG9mIHRoZSBTb0Ms
IHRoaXMgYmxvY2sgaXMgZGlyZWN0bHkgY29ubmVjdGVkIHRvIHRoZSBIRE1JIElQLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hp
bm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwaS5jICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpX3JlZ3MuaCB8ICA2ICsrKysrKw0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMgIHwgIDIgKysNCj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rw
aS5jDQo+IGluZGV4IDY3NTA0ZWI4NzRkMi4uZTRiNTJmZmM0NDE0IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gQEAgLTEwNDksNiArMTA0OSw4IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2RwaV9mYWN0b3IgZHBpX2ZhY3Rvcl9tdDgxOTVfZHBfaW50ZltdID0gew0K
PiAgICAgICAgIHsgNzAwMDAgLSAxLCA0IH0sIHsgMjAwMDAwIC0gMSwgMiB9LCB7IFUzMl9NQVgs
IDEgfQ0KPiAgfTsNCj4gDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlfZmFjdG9yIGRw
aV9mYWN0b3JfbXQ4MTk1X2RwaSA9IHsgVTMyX01BWCwgMSB9Ow0KPiArDQo+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxNzNfY29uZiA9IHsNCj4gICAgICAgICAuZHBpX2Zh
Y3RvciA9IGRwaV9mYWN0b3JfbXQ4MTczLA0KPiAgICAgICAgIC5udW1fZHBpX2ZhY3RvciA9IEFS
UkFZX1NJWkUoZHBpX2ZhY3Rvcl9tdDgxNzMpLA0KPiBAQCAtMTE0MSw2ICsxMTQzLDI3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwaV9jb25mIG10ODE5Ml9jb25mID0gew0KPiAgICAgICAg
IC5jc2NfZW5hYmxlX2JpdCA9IENTQ19FTkFCTEUsDQo+ICB9Ow0KPiANCj4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2RwaV9jb25mIG10ODE5NV9jb25mID0gew0KPiArICAgICAgIC5kcGlfZmFj
dG9yID0gJmRwaV9mYWN0b3JfbXQ4MTk1X2RwaSwNCg0KbXQ4MTk1IGRwaSB3b3VsZCBub3QgdXNl
IGRwaV9mYWN0b3IsIHNvIGxldCBpdCBiZSBOVUxMIGFuZCBkcm9wIGRwaV9mYWN0b3JfbXQ4MTk1
X2RwaS4NCkFmdGVyIHRoaXMsDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsu
Y29tPg0KDQo+ICsgICAgICAgLm51bV9kcGlfZmFjdG9yID0gMSwNCj4gKyAgICAgICAubWF4X2Ns
b2NrX2toeiA9IDU5NDAwMCwNCj4gKyAgICAgICAub3V0cHV0X2ZtdHMgPSBtdDgxODNfb3V0cHV0
X2ZtdHMsDQo+ICsgICAgICAgLm51bV9vdXRwdXRfZm10cyA9IEFSUkFZX1NJWkUobXQ4MTgzX291
dHB1dF9mbXRzKSwNCj4gKyAgICAgICAucGl4ZWxzX3Blcl9pdGVyID0gMSwNCj4gKyAgICAgICAu
aXNfY2tfZGVfcG9sID0gdHJ1ZSwNCj4gKyAgICAgICAuc3dhcF9pbnB1dF9zdXBwb3J0ID0gdHJ1
ZSwNCj4gKyAgICAgICAuc3VwcG9ydF9kaXJlY3RfcGluID0gdHJ1ZSwNCj4gKyAgICAgICAuZGlt
ZW5zaW9uX21hc2sgPSBIUFdfTUFTSywNCj4gKyAgICAgICAuaHZzaXplX21hc2sgPSBIU0laRV9N
QVNLLA0KPiArICAgICAgIC5jaGFubmVsX3N3YXBfc2hpZnQgPSBDSF9TV0FQLA0KPiArICAgICAg
IC55dXY0MjJfZW5fYml0ID0gWVVWNDIyX0VOLA0KPiArICAgICAgIC5jc2NfZW5hYmxlX2JpdCA9
IENTQ19FTkFCTEUsDQo+ICsgICAgICAgLmlucHV0XzJwX2VuX2JpdCA9IERQSV9JTlBVVF8yUF9F
TiwNCj4gKyAgICAgICAuY2xvY2tlZF9ieV9oZG1pID0gdHJ1ZSwNCj4gKyAgICAgICAuaW5wdXRf
MnBpeGVsID0gdHJ1ZSwNCj4gKyAgICAgICAub3V0cHV0XzFwaXhlbCA9IHRydWUsDQo+ICt9Ow0K
PiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxOTVfZHBpbnRmX2Nv
bmYgPSB7DQo+ICAgICAgICAgLmRwaV9mYWN0b3IgPSBkcGlfZmFjdG9yX210ODE5NV9kcF9pbnRm
LA0KPiAgICAgICAgIC5udW1fZHBpX2ZhY3RvciA9IEFSUkFZX1NJWkUoZHBpX2ZhY3Rvcl9tdDgx
OTVfZHBfaW50ZiksDQo+IEBAIC0xMjQ1LDYgKzEyNjgsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG9mX2RldmljZV9pZCBtdGtfZHBpX29mX2lkc1tdID0gew0KPiAgICAgICAgIHsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTg4LWRwLWludGYiLCAuZGF0YSA9ICZtdDgxOTVfZHBpbnRmX2Nv
bmYgfSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1kcGkiLCAu
ZGF0YSA9ICZtdDgxOTJfY29uZiB9LA0KPiAgICAgICAgIHsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTk1LWRwLWludGYiLCAuZGF0YSA9ICZtdDgxOTVfZHBpbnRmX2NvbmYgfSwNCj4gKyAg
ICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1kcGkiLCAuZGF0YSA9ICZtdDgx
OTVfY29uZiB9LA0KPiAgICAgICAgIHsgLyogc2VudGluZWwgKi8gfSwNCj4gIH07DQo+ICBNT0RV
TEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfZHBpX29mX2lkcyk7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaV9yZWdzLmggYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwaV9yZWdzLmgNCj4gaW5kZXggYTBiMWQxOGJiYmY3Li4zYzI0ZDllOWYyNDEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpX3JlZ3MuaA0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaV9yZWdzLmgNCj4gQEAgLTQw
LDYgKzQwLDEyIEBADQo+ICAjZGVmaW5lIEZBS0VfREVfTEVWRU4gICAgICAgICAgICAgICAgICBC
SVQoMjEpDQo+ICAjZGVmaW5lIEZBS0VfREVfUk9ERCAgICAgICAgICAgICAgICAgICBCSVQoMjIp
DQo+ICAjZGVmaW5lIEZBS0VfREVfUkVWRU4gICAgICAgICAgICAgICAgICBCSVQoMjMpDQo+ICsN
Cj4gKy8qIERQSV9DT046IERQSSBpbnN0YW5jZXMgKi8NCj4gKyNkZWZpbmUgRFBJX09VVFBVVF8x
VDFQX0VOICAgICAgICAgICAgIEJJVCgyNCkNCj4gKyNkZWZpbmUgRFBJX0lOUFVUXzJQX0VOICAg
ICAgICAgICAgICAgICAgICAgICAgQklUKDI1KQ0KPiArDQo+ICsvKiBEUElfQ09OOiBEUElOVEYg
aW5zdGFuY2VzICovDQo+ICAjZGVmaW5lIERQSU5URl9ZVVY0MjJfRU4gICAgICAgICAgICAgICBC
SVQoMjQpDQo+ICAjZGVmaW5lIERQSU5URl9DU0NfRU5BQkxFICAgICAgICAgICAgICBCSVQoMjYp
DQo+ICAjZGVmaW5lIERQSU5URl9JTlBVVF8yUF9FTiAgICAgICAgICAgICBCSVQoMjkpDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+IGluZGV4IGYyMmFkMjg4MjY5Ny4u
NzcyYzNkMGY1ZDE0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9kcnYuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYu
Yw0KPiBAQCAtODEwLDYgKzgxMCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IG10a19kZHBfY29tcF9kdF9pZHNbXSA9IHsNCj4gICAgICAgICAgIC5kYXRhID0gKHZvaWQgKilN
VEtfRFBJIH0sDQo+ICAgICAgICAgeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtZHAt
aW50ZiIsDQo+ICAgICAgICAgICAuZGF0YSA9ICh2b2lkICopTVRLX0RQX0lOVEYgfSwNCj4gKyAg
ICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1kcGkiLA0KPiArICAgICAgICAg
LmRhdGEgPSAodm9pZCAqKU1US19EUEkgfSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10MjcwMS1kc2kiLA0KPiAgICAgICAgICAgLmRhdGEgPSAodm9pZCAqKU1US19EU0kg
fSwNCj4gICAgICAgICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1kc2kiLA0KPiAt
LQ0KPiAyLjQ4LjENCj4gDQoNCg==

