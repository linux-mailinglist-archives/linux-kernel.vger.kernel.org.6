Return-Path: <linux-kernel+bounces-417688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F7B9D57F4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8BF5282BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 02:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387AF42AB0;
	Fri, 22 Nov 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m6neks1U";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kXAIiHbO"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3BA3C0C;
	Fri, 22 Nov 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240982; cv=fail; b=GSGf+yio7JhfF33UcM+NNUF2Nbc+BArBxHEj/Vej8p9GYLSID5xFR13BikX/sD73fgwkwsnlJrYKke+OS1Bx+LKx2ExkV1Q0ZguIbrjPIXMnX50IshGuQmLIOE89rSznnj42Uqgs64viILmCaX8R2tesXhM0UM9j7eBncygOT00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240982; c=relaxed/simple;
	bh=0kT3OGQ5hZXznsbPL860XY6C9dqtzCaROQaovs2/8a8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eLTvj66q9tSvCuIUWMxFZ6HqpmrgvbF/Cjldf6eONef/dhQ5/9HqW1+dBWFFjDSBsYb5F+qm4D7U3ZbsYB4c0KunyI5pHR3jUlH0VDDpg7MTHDNxytUOb7vsIyqX+nVJGEc4kNXidOHpDl9ajqSIY3DTvtFj/ppWjFfVgIIkwko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m6neks1U; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kXAIiHbO; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: de37c4dea87511ef99858b75a2457dd9-20241122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=0kT3OGQ5hZXznsbPL860XY6C9dqtzCaROQaovs2/8a8=;
	b=m6neks1Uw72YgGfcwnMRHDI3GpFZbm9axPZc6UIJXzUl5bPbqp02SIq65w85eCajf7tcgOSXvZf5AvfCA1xgW25W2ZaF9iTK5643nVdjEiLSpU99k/fvY05t9dmngIWGE+uvyEoUcnFEpMczRHay93wBOZpMP9/Nf0rsX80zOw4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:858538b3-477e-4f1c-bf5b-9d48932e84a0,IP:0,U
	RL:0,TC:0,Content:-32768,EDM:0,RT:0,SF:-32768,FILE:0,BULK:-32768,RULE:Rele
	ase_Ham,ACTION:release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:83899ca0-f395-4dfc-8188-ce2682df7fd8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:nil,EDM:-3,IP:nil
	,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: de37c4dea87511ef99858b75a2457dd9-20241122
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2008356008; Fri, 22 Nov 2024 10:02:46 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Nov 2024 10:02:45 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Nov 2024 10:02:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBMu1i6dUdRqOr+fIx/7cFGzI4rgMAidGh8EtMzefDKVONYv8wl4+raVg0zPLawnn2BlPFbHYgX7G24GvnA3OXeU5SN8zejBJ/Xa8LaKeITWheVrdVS0C4emDpVMjrB91rnFWKL1cs+rwNw4lrybGDrKBKap+hFN/9005RBNl+sV1tBXk6g0pGGXYFd9A+U1FptORbFqvixBRab3WgrSr1dsPTqwK4yhBikowu/kQRWRNKunjt5ADQF2OBlhGGUu9+t8EFzsAvuva5pT9fkQCXTsiKmba5qjIw+pEqfHD12UR4yTgIA5KIxmvrc6x1nAi9/gI7V2VfDwpor4ey4C3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kT3OGQ5hZXznsbPL860XY6C9dqtzCaROQaovs2/8a8=;
 b=ywhmjjRrJUerD+EsJMZqtDVv5iTsDpgB7JJ25bC1YpADVa4bE2uoFXUvEUim3n98U421FpSYaYbktVQ7FtvDrLXlkSzdj3tyj+8iI9yPr9+T/y2lAmYn20EdpVzKqY6y5avWZEok3oWDRIwVUvX6RyTjJO6Ze+NFCZmz1IPqWv85DmPsdx/wOTxFcq1S+ctYQMJ2GavD4KeRQ+K2CRoBXoal9N7qAL/LA72/KQfpJNsIYZ48rJOw4bq+9rDIbuADcpfEOlRlhUEDUy2Zm59dneeZZyC/ghEgEH6nWRpDXbcuxhM6CC0PCPQLsN67SwLHc5SYhn3yXToQuO1RN+q4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kT3OGQ5hZXznsbPL860XY6C9dqtzCaROQaovs2/8a8=;
 b=kXAIiHbOwhzINQXQZabpbsWY/MywCXiGtv+woPHxvq7l7Ukuc5QqI61sch551pqdQpZaYPYB38cAVanvritcFg1LV+yKBIJ3rEdl787e8Y/hqAjNbECU2UnrGMEoGdja6fSKh5uBKXEihW+KEX+4QtaI4mVm8Y3qOg/3v2GOmtk=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7998.apcprd03.prod.outlook.com (2603:1096:101:17b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Fri, 22 Nov
 2024 02:02:42 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8158.017; Fri, 22 Nov 2024
 02:02:42 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"kernel@collabora.com" <kernel@collabora.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 2/6] drm/mediatek: mtk_dpi: Add support for Pattern
 Generator in debugfs
Thread-Topic: [PATCH v1 2/6] drm/mediatek: mtk_dpi: Add support for Pattern
 Generator in debugfs
Thread-Index: AQHbO0oAJXNAlyNm3Uevj4OC+laiqrLCjqWA
Date: Fri, 22 Nov 2024 02:02:42 +0000
Message-ID: <a19bb68fc2c7492cd39ba9939abe678273ce6a81.camel@mediatek.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
	 <20241120124420.133914-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124420.133914-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7998:EE_
x-ms-office365-filtering-correlation-id: 3c8b5167-1888-4cfc-4d58-08dd0a99bfd8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?R3V0UnZwTGpqalh3NnBTY2NSQjFvaERtdmlZVlBKeXc4RFFUdGRpZ2grQU9F?=
 =?utf-8?B?STdkejMzZ0dIMVpDSkRzL3VQaUNia2tRRDVJRUplOFJBUW1UeWExUmdwR2RR?=
 =?utf-8?B?Z3VUaFB6QnpVdG1QRXVkYkViajRRaG1SdzVDZkZjRWJJV0VOMEYrUFEwdVRz?=
 =?utf-8?B?TWhLVm1XSzZJVG9uTTVPM1RsOFRlRHZVNHpabzdtMTNlVW01TEo1b0RrZkpn?=
 =?utf-8?B?eUtGcFZxMkNkaTNSZ0I5Q09DdzI1VWFVNVBaK21Ta2srZjAwYmdUY3VFOWRy?=
 =?utf-8?B?SXVJWnlLL1NBbmNkVEtUbVlrQmdiVk85Z2J0YUdPK3ZLQUgyNXZ3U0cvWkRT?=
 =?utf-8?B?YjdiN1NlNXFzOHVLZnoyaGd5aVZyejBPRjdHUTJQU3BqWTcwQTEwemROeDFP?=
 =?utf-8?B?cFdVYjczOXB0Mm1qQ2hXeDFZdXdJL2tuRVdvbWpNdlJlMC9jVmRFRUtnQjhW?=
 =?utf-8?B?SVo0ZCtKOWF5emljUld1bDZYNVFlOUxuaDZYNGFjT0M2MG9UMVB6NjFDd3Ux?=
 =?utf-8?B?ZkIvcmwzOW0wdGVGenFDUnk3ZWFtdWJTaXA1emJTSlB3S3BBUHMrN3IzQzRQ?=
 =?utf-8?B?SmVuVHlLdGJQVjZPaGlTQmtsT3FHU2E0Qnh0dHpST2l4ODNvYVlmZkRYOSt5?=
 =?utf-8?B?Z3lkRElDZzFXV3FFWStxN0hWRFR3RDh4aTZhOWtDaEtxKzlWT1UyS001SkVV?=
 =?utf-8?B?NEJPZWdiUE5Da3FVUUNPMTVzdVQ5bXJic1VadHNwVkpmYThaM2VuYi9FS0lz?=
 =?utf-8?B?ZlkrUE5GZHJmT0xpcGpVR0xtRU1IQVpmL1cxb2NQWjFJZDhMbTk3dDdDdzVJ?=
 =?utf-8?B?ZEN6Zmw1QlVGejkwdVc4eStoVjcrK25hWVVEQWVrNGVtZGMxK3d3TnNoYXdQ?=
 =?utf-8?B?bVpvVjBNditzZ0k1ZEZmbjFRanF6TVZFYlRjdEorQzNNWkczeEtuTExqSzhz?=
 =?utf-8?B?OEVSa2d2RmZZamZxcmZ0cFBPTS8rYkVWeFRSeko0NzFkNlhhekJycGpTRVN6?=
 =?utf-8?B?ZzBsVHEzSFljYVBjcFVMT0g1cUpVQXUxVVlpZWxBMTh5U2lUYkVEKzlJRmNK?=
 =?utf-8?B?MUZpNElpWmtUVjZIYzduaXN4OGlROVA1S1BrbEJxQ0hodldqZGMvMWxmOUpV?=
 =?utf-8?B?eUNGYjQrc1dMYXRDaFNZcEs3Y0UzdHBycGlVSDE1dlpXOG9sTUY3MjhkZ2xj?=
 =?utf-8?B?UDlyTThuTUYvSzE1dTFrb2xJZE56UlRTa3ZwcnNQTkhlZUx4S1RVc1MzM0s0?=
 =?utf-8?B?Njl4L2o5d3lrdGxyNi9BNnJhdGhaOVhjK3IvOWUwdFNDTmVCbUpVRGRiVkpZ?=
 =?utf-8?B?bHNIOE1uc09oVkd3MzFuRy9OUEdLQklzaTJPTlQwRnBFdTE0SkdRTFE0c2Fj?=
 =?utf-8?B?WUJKSmlsakxnZ2MyN2RNUWYyQ2IzaE05emVPSGM0VEREWDdXYUFzcmRhd3Ja?=
 =?utf-8?B?eGlBZXBrSFNxb3dqem9UZmVDKzl3UjZiM1grK2djTkhyQzV5RE4xbk5CUlJP?=
 =?utf-8?B?NUVQRlJWeFE5ZDREZ0pheXY5ODl6SWlZSG5KWC9yemhNcTJzdTF3L0t6SE1r?=
 =?utf-8?B?YVBxM0dKck5tNU5rN1A5RTJZSDE4SGdxaSswd0ZuZHdzNm5KRzBhM2hCbXFL?=
 =?utf-8?B?QWhZdGlKTW1aM2tiV2dLU1JIRFNGVExkWFBlcHNIbmZHWENBaW5YS1UyWkFn?=
 =?utf-8?B?blk1TkEveDltODZCWkZ4WnpVTWVZWjl0WFhRbmxaUXRKc0ZkTHltVm5JSzhy?=
 =?utf-8?B?ME9wNG1uYWNla3FLM3NyQldwSEV1d2ZmOUdmd2NESk1nNnBmeHhGS3BoSFhQ?=
 =?utf-8?B?RWQzM055UzlKa2JzRlJGT0JSYXNTM1JpRXVxQy8rQlhxVzZhVVhNV0NxeHp1?=
 =?utf-8?B?YmIvWENFSlFabURLbTdWdm55QmljUkFIZnh0YmlubU9RRlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2NIN1BmZk9rcklWRDc5dnJKbEZySlhta2R3S2FoMXhTaFhQNm5Lb05YbGY1?=
 =?utf-8?B?end2SUVrckVGZXZwVXZiWEVyYno3MUNKcW9icDhjOEczT0EyMnRHUUxHQXlx?=
 =?utf-8?B?VUF6THgyMDBNNkdwUmEvTzQxNStPdDRGNzQ5YVVwMjZ4bmczdjJkelNucDhO?=
 =?utf-8?B?ZVR5czNrbWx2NXkxVVdvWXdINHI4UmlKa1ZWMlVqNWVhTUpBMDczM0tMclZH?=
 =?utf-8?B?aHAzc0RFT21BN2tzQXdPZ0FFekRxZFc0RWRpa3RadG1wTzFUdllRTDB1RmNp?=
 =?utf-8?B?S1p6MzhpaXJVc0JNYUpWY1lNT3N6TzVicE85NVJRZWIvS2hULzVDTjJlTmQv?=
 =?utf-8?B?S2FkZFlidXRPck92N3lRelVmU0hNYTA3Z0FId0ZNUG9HSUQ0NzQwWlcxYzBC?=
 =?utf-8?B?ampRcFJDUEtsNjVoV0MyNGpIVlFNWGdGWWllWUdYRXk5TUVkT3lwVEd3Z2pO?=
 =?utf-8?B?d3laNU9EZ1pSaG5FNUYzOFA0VStreGo4N1RsM0w5b3RNQ21TVHA2Q2Z5Wndl?=
 =?utf-8?B?NTZFN3VXQ0hFd3dMemNtYUF6UW8rUGdsemRrS2p0Y2pKbFlQbXdNQXN6U2U1?=
 =?utf-8?B?TEI0Y000d2ZYNWxiRFUrc0NHN243WTJXOW5HQUR1NG9zeFluRk1uSERqMWdU?=
 =?utf-8?B?RlpReVlJK2FIN0psTjJTMG9MR3hxTXoya1g1L3l5UERzanpNT09vNStQWHpi?=
 =?utf-8?B?OVhxNHJxdXBtQkpxVTY1dlVoZGxqaFpCNCtBbWZPU2hRTWVyL0tqNHY5TjVy?=
 =?utf-8?B?TkpBcTdPYXFWZmlYNkg5eW9wSVQvOGxJK01zVmdEZHNSdkhqZ0dCU0tQTXFG?=
 =?utf-8?B?U0ZzazhwQ3Z5cW1uUzJuTWlSUGRZZldrR3ZUREFYUzNteFZ0blBDMXg1ZE9i?=
 =?utf-8?B?WVRTK0xVODJFNkRQQmhPeDNNcDA0UHl0bTlscXpRR2JhMG1FS1RVZzJNMVlN?=
 =?utf-8?B?bVl4OUptNnJiVVZFWXUwK2FpYXlzMll3T2VkOVliOEhGSHloRXdLY25LRTAx?=
 =?utf-8?B?MHAyUUh2MTc0MkYvUXRLTVh6TlZUQVNIYlF4VUh3Tzl5YStnaWVWUEplc2FR?=
 =?utf-8?B?eWV0dUxQNG9SK2p6NmNMcHFTRU9CbHo2ejVuY2pNdkJxeHJ6bG03eUpJakgx?=
 =?utf-8?B?b09VM1FHWkh6eGFDWHNBQ0UyUktaUk9mN3Q4b3l6bGkxSTlHQ0paL3Ivbzlx?=
 =?utf-8?B?NEtzQ0IyZjlycURPVUJuTFRzRlJ5REExUVFLTDhQUVRqNG1lRFNDZkZUa21i?=
 =?utf-8?B?RkVKKzZmdUx6SlZLMUNFVDhpdE1zZW1zQUFYb1c5NjZPMXFlWmZuUS8zRk1E?=
 =?utf-8?B?UUU4aHRRanBmcFVPbU1LdkF0cERMRVovYmM0REgraGNtR2JLTEw2K3g1bm90?=
 =?utf-8?B?OFV1NWprMFdTNU9EY0g0ejFhd1hHcFg5cXcvZXl1ZW5POG1MSUxpVGNHUnFE?=
 =?utf-8?B?OHFKVEw1TjZPR3pWNGhnTnVtVHY2RGNJT09aVkczOFRHZkFnbTlOd1RUSE93?=
 =?utf-8?B?Z3dqT1Z1R2JVOEg5K0ZEL01nenhYNGNPK2pEQkVrS2tFajlocm1sSGRFL0o1?=
 =?utf-8?B?N3J6RHY5RFIwRzlDbHdmU2creExXakRRcVhtNE1pMGpyYjMwS2ZUT1pmaHQw?=
 =?utf-8?B?aDJZMWVaVFVJdXd4MUhSWEJXVzNIbnVjL1NSTXpvSllKSUVod0J5ajNEMEZN?=
 =?utf-8?B?ZG9TY1puQUx5R1BIajBka3pnejV5ZGx6dkQyZ0picHJGN0g0TGY3SjlkL2Fz?=
 =?utf-8?B?bi8rQlNPTFNTWktmMW1vUzFoYm9qbGNmT2xROXpWeitMempVeFFscnMxWGFN?=
 =?utf-8?B?Z21ZOWhLTk1vVzVMS0htNjBHTHlLTm1OclNIZ1lEVXRFVnNEenk0Z25XMEpZ?=
 =?utf-8?B?OFI5MGhrQjVwQ0ZnQVlkMVRxN0pGNFFScVZjZC85RVNqcnBXS29GeUJNYThO?=
 =?utf-8?B?ek9XS3JzSHUrMkM0LzlOUGZCMDFCNkVLK3VQb2NIeVVOUTU0Z1pwUlNZRkxC?=
 =?utf-8?B?SnlTOEd4RXpacGc1K00vWUIrQVYvSFk3QnlYT3M3cnJ0ZUxnUzVkbkVNL24z?=
 =?utf-8?B?L1hJWk95T2ZRdUxjR2RhK1laY29wOWdTU2w3V1g5a1h4YzVkR2VoV3FYNExB?=
 =?utf-8?Q?T2cm1WXUqAahlyovX2bUcZZ/U?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62D2DAE6DF4A88449FF739C108E2FDD8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8b5167-1888-4cfc-4d58-08dd0a99bfd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 02:02:42.0786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OT2EtGcnFphzV1K3q4+5ip/3LOpaL1xiZbmMMtOxsRuJIz4KVjG4jX+rAk+F5vxc7wMbqYgAMIz0Ca05CbC/JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7998

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ0ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBUaGlzIElQIGluY2x1ZGVz
IGEgUGF0dGVybiBHZW5lcmF0b3Igd2hpY2ggaXMgdXNlZnVsIGZvciBkZWJ1Z2dpbmcNCj4gYW5k
IHRlc3RpbmcgcHVycG9zZXM6IGFkZCB0aGUgcmVsZXZhbnQgcmVnaXN0ZXIgYW5kIGJpdHMgdG8g
dGhlDQo+IG10a19kcGlfcmVncy5oIGhlYWRlciwgYW5kIGltcGxlbWVudCBzdXBwb3J0IGZvciBp
dCBpbiBtdGtfZHBpLg0KPiANCj4gQWRkaW5nIHRoaXMgcmVxdWlyZWQgdG8gaW50cm9kdWNlIGEg
LmRlYnVnZnNfaW5pdCgpIGNhbGxiYWNrIGZvcg0KPiB0aGUgRFBJIGJyaWRnZSwgd2hpY2ggY3Jl
YXRlcyBhICJkcGlfdGVzdF9wYXR0ZXJuIiBmaWxlIGluIHRoZQ0KPiBkaXJlY3Rvcnkgb2YgdGhl
IGFwcHJvcHJpYXRlIGNvbm5lY3Rvci4NCj4gDQo+IFRoZSBwYXR0ZXJuIGdlbmVyYXRvciBjYW4g
Z2VuZXJhdGUgdmFyaW91cyBpbnRlcm5hbCBwYXR0ZXJucyBhbmQNCj4gdGhpcyBzdWJtaXNzaW9u
IGluY2x1ZGVzIHN1cHBvcnQgZm9yOg0KPiAgLSAyNTYgb3IgMTAyNCBzaGFkZXMgb2YgZ3JheSBp
biBhIFZlcnRpY2FsIG9yIEhvcml6b250YWwgUGF0dGVybg0KPiAgLSBWZXJ0aWNhbCBDb2xvciBC
YXJzDQo+ICAtIEZyYW1lIGJvcmRlcg0KPiAgLSBEb3QgTW9pcmUNCj4gDQo+IFRoaXMgZ2VuZXJh
dG9yIGFsc28gc3VwcG9ydHMgZmlsbGluZyB0aGUgZW50aXJlIHNjcmVlbiB3aXRoIG9uZQ0KPiBj
dXN0b20gY29sb3IsIGJ1dCBzdXBwb3J0IGZvciB0aGF0IGlzIG5vdCBpbmNsdWRlZCBpbiB0aGlz
IGNvbW1pdC4NCj4gDQo+IEVuYWJsaW5nIGFuZCBkaXNhYmxpbmcgdGhpcyBnZW5lcmF0b3IgY2Fu
IGJlIGRvbmUgYnkgc2VuZGluZyBhDQo+IHN0cmluZyB0byB0aGUgZHBpX3Rlc3RfcGF0dGVybiBk
ZWJ1Z2ZzIGZpbGU7IHRoZSBwYXR0ZXJuIGlzDQo+IGV4cGVjdGVkIHRvIGJlIGZvcm1hdHRlZCBh
cyBmb2xsb3dzOg0KPiANCj4gICAgICAgICAgPGVuYWJsZSAoMSkgb3IgZGlzYWJsZSAoMCk+IDxw
YXR0ZXJuIG51bWJlcj4NCj4gDQo+IHdoZXJlIHRoZSBwYXR0ZXJuIG51bWJlciBjYW4gYmUgYSBu
dW1iZXIgZnJvbSAwIHRvIDcsIGV4Y2x1ZGluZyA1Lg0KPiANCj4gT2YgY291cnNlIDUgaXMgZXhj
bHVkZWQgYmVjYXVzZSB0aGF0IGFjdGl2YXRlcyBjdXN0b20gY29sb3IgZmlsbA0KPiB3aGljaCwg
YWdhaW4sIGlzIG5vdCBzdXBwb3J0ZWQgaW4gdGhpcyBjb21taXQuDQoNClJldmlld2VkLWJ5OiBD
SyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICB8
IDEwNyArKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpX3JlZ3MuaCB8ICAgNCArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDExMSBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gaW5kZXggMjBhOWQ1
ODlmZDc1Li5jNzE0MzE4NGU1ZGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHBpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
Yw0KPiBAQCAtNiw2ICs2LDcgQEANCj4gDQo+ICAjaW5jbHVkZSA8bGludXgvY2xrLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQo+ICsjaW5jbHVkZSA8bGludXgvZGVidWdmcy5o
Pg0KPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2tl
cm5lbC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21lZGlhLWJ1cy1mb3JtYXQuaD4NCj4gQEAgLTE2
Niw2ICsxNjcsMTggQEAgc3RhdGljIHZvaWQgbXRrX2RwaV9tYXNrKHN0cnVjdCBtdGtfZHBpICpk
cGksIHUzMiBvZmZzZXQsIHUzMiB2YWwsIHUzMiBtYXNrKQ0KPiAgICAgICAgIHdyaXRlbCh0bXAs
IGRwaS0+cmVncyArIG9mZnNldCk7DQo+ICB9DQo+IA0KPiArc3RhdGljIHZvaWQgbXRrX2RwaV90
ZXN0X3BhdHRlcm5fZW4oc3RydWN0IG10a19kcGkgKmRwaSwgdTggdHlwZSwgYm9vbCBlbmFibGUp
DQo+ICt7DQo+ICsgICAgICAgdTMyIHZhbDsNCj4gKw0KPiArICAgICAgIGlmIChlbmFibGUpDQo+
ICsgICAgICAgICAgICAgICB2YWwgPSBGSUVMRF9QUkVQKERQSV9QQVRfU0VMLCB0eXBlKSB8IERQ
SV9QQVRfRU47DQo+ICsgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgdmFsID0gMDsNCj4g
Kw0KPiArICAgICAgIG10a19kcGlfbWFzayhkcGksIERQSV9QQVRURVJOMCwgdmFsLCBEUElfUEFU
X1NFTCB8IERQSV9QQVRfRU4pOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgdm9pZCBtdGtfZHBpX3N3
X3Jlc2V0KHN0cnVjdCBtdGtfZHBpICpkcGksIGJvb2wgcmVzZXQpDQo+ICB7DQo+ICAgICAgICAg
bXRrX2RwaV9tYXNrKGRwaSwgRFBJX1JFVCwgcmVzZXQgPyBSU1QgOiAwLCBSU1QpOw0KPiBAQCAt
NzY3LDYgKzc4MCw5OSBAQCBtdGtfZHBpX2JyaWRnZV9tb2RlX3ZhbGlkKHN0cnVjdCBkcm1fYnJp
ZGdlICpicmlkZ2UsDQo+ICAgICAgICAgcmV0dXJuIE1PREVfT0s7DQo+ICB9DQo+IA0KPiArc3Rh
dGljIGludCBtdGtfZHBpX2RlYnVnX3RwX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICph
cmcpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG10a19kcGkgKmRwaSA9IG0tPnByaXZhdGU7DQo+
ICsgICAgICAgYm9vbCBlbjsNCj4gKyAgICAgICB1MzIgdmFsOw0KPiArDQo+ICsgICAgICAgaWYg
KCFkcGkpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gKw0KPiArICAgICAg
IHZhbCA9IHJlYWRsKGRwaS0+cmVncyArIERQSV9QQVRURVJOMCk7DQo+ICsgICAgICAgZW4gPSB2
YWwgJiBEUElfUEFUX0VOOw0KPiArICAgICAgIHZhbCA9IEZJRUxEX0dFVChEUElfUEFUX1NFTCwg
dmFsKTsNCj4gKw0KPiArICAgICAgIHNlcV9wcmludGYobSwgIkRQSSBUZXN0IFBhdHRlcm46ICVz
XG4iLCBlbiA/ICJFbmFibGVkIiA6ICJEaXNhYmxlZCIpOw0KPiArDQo+ICsgICAgICAgaWYgKGVu
KSB7DQo+ICsgICAgICAgICAgICAgICBzZXFfcHJpbnRmKG0sICJJbnRlcm5hbCBwYXR0ZXJuICVk
OiAiLCB2YWwpOw0KPiArICAgICAgICAgICAgICAgc3dpdGNoICh2YWwpIHsNCj4gKyAgICAgICAg
ICAgICAgIGNhc2UgMDoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2VxX3B1dHMobSwgIjI1
NiBWZXJ0aWNhbCBHcmF5XG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+
ICsgICAgICAgICAgICAgICBjYXNlIDE6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNlcV9w
dXRzKG0sICIxMDI0IFZlcnRpY2FsIEdyYXlcbiIpOw0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBicmVhazsNCj4gKyAgICAgICAgICAgICAgIGNhc2UgMjoNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgc2VxX3B1dHMobSwgIjI1NiBIb3Jpem9udGFsIEdyYXlcbiIpOw0KPiArICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgICAgICAgIGNhc2UgMzoNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgc2VxX3B1dHMobSwgIjEwMjQgSG9yaXpvbnRhbCBHcmF5XG4iKTsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgICBjYXNl
IDQ6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNlcV9wdXRzKG0sICJWZXJ0aWNhbCBDb2xv
ciBiYXJzXG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAg
ICAgICAgICBjYXNlIDY6DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHNlcV9wdXRzKG0sICJG
cmFtZSBib3JkZXJcbiIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gKyAg
ICAgICAgICAgICAgIGNhc2UgNzoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2VxX3B1dHMo
bSwgIkRvdCBtb2lyZVxuIik7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiAr
ICAgICAgICAgICAgICAgZGVmYXVsdDoNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2VxX3B1
dHMobSwgIkludmFsaWQgc2VsZWN0aW9uXG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAg
cmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBzc2l6ZV90IG10a19kcGlfZGVidWdfdHBf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICp1YnVmLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBsZW4sIGxvZmZfdCAqb2Zm
cCkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3Qgc2VxX2ZpbGUgKm0gPSBmaWxlLT5wcml2YXRlX2Rh
dGE7DQo+ICsgICAgICAgdTMyIGVuLCB0eXBlOw0KPiArICAgICAgIGNoYXIgYnVmWzZdOw0KPiAr
DQo+ICsgICAgICAgaWYgKCFtIHx8ICFtLT5wcml2YXRlIHx8ICpvZmZwIHx8IGxlbiA+IHNpemVv
ZihidWYpIC0gMSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsg
ICAgICAgbWVtc2V0KGJ1ZiwgMCwgc2l6ZW9mKGJ1ZikpOw0KPiArICAgICAgIGlmIChjb3B5X2Zy
b21fdXNlcihidWYsIHVidWYsIGxlbikpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVM
VDsNCj4gKw0KPiArICAgICAgIGlmIChzc2NhbmYoYnVmLCAiJXUgJXUiLCAmZW4sICZ0eXBlKSAh
PSAyKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKyAgICAgICBp
ZiAoZW4gPCAwIHx8IGVuID4gMSB8fCB0eXBlIDwgMCB8fCB0eXBlID4gNykNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsgICAgICAgbXRrX2RwaV90ZXN0X3BhdHRl
cm5fZW4oKHN0cnVjdCBtdGtfZHBpICopbS0+cHJpdmF0ZSwgdHlwZSwgZW4pOw0KPiArICAgICAg
IHJldHVybiBsZW47DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbnQgbXRrX2RwaV9kZWJ1Z190cF9v
cGVuKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0cnVjdCBmaWxlICpmaWxlKQ0KPiArew0KPiArICAg
ICAgIHJldHVybiBzaW5nbGVfb3BlbihmaWxlLCBtdGtfZHBpX2RlYnVnX3RwX3Nob3csIGlub2Rl
LT5pX3ByaXZhdGUpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3Bl
cmF0aW9ucyBtdGtfZHBpX2RlYnVnX3RwX2ZvcHMgPSB7DQo+ICsgICAgICAgLm93bmVyID0gVEhJ
U19NT0RVTEUsDQo+ICsgICAgICAgLm9wZW4gPSBtdGtfZHBpX2RlYnVnX3RwX29wZW4sDQo+ICsg
ICAgICAgLnJlYWQgPSBzZXFfcmVhZCwNCj4gKyAgICAgICAud3JpdGUgPSBtdGtfZHBpX2RlYnVn
X3RwX3dyaXRlLA0KPiArICAgICAgIC5sbHNlZWsgPSBzZXFfbHNlZWssDQo+ICsgICAgICAgLnJl
bGVhc2UgPSBzaW5nbGVfcmVsZWFzZSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyB2b2lkIG10a19k
cGlfZGVidWdmc19pbml0KHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsIHN0cnVjdCBkZW50cnkg
KnJvb3QpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IG10a19kcGkgKmRwaSA9IGJyaWRnZV90b19k
cGkoYnJpZGdlKTsNCj4gKw0KPiArICAgICAgIGRlYnVnZnNfY3JlYXRlX2ZpbGUoImRwaV90ZXN0
X3BhdHRlcm4iLCAwNjQwLCByb290LCBkcGksICZtdGtfZHBpX2RlYnVnX3RwX2ZvcHMpOw0KPiAr
fQ0KPiArDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgbXRrX2RwaV9i
cmlkZ2VfZnVuY3MgPSB7DQo+ICAgICAgICAgLmF0dGFjaCA9IG10a19kcGlfYnJpZGdlX2F0dGFj
aCwNCj4gICAgICAgICAubW9kZV9zZXQgPSBtdGtfZHBpX2JyaWRnZV9tb2RlX3NldCwNCj4gQEAg
LTc3OSw2ICs4ODUsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9icmlkZ2VfZnVuY3MgbXRr
X2RwaV9icmlkZ2VfZnVuY3MgPSB7DQo+ICAgICAgICAgLmF0b21pY19kdXBsaWNhdGVfc3RhdGUg
PSBkcm1fYXRvbWljX2hlbHBlcl9icmlkZ2VfZHVwbGljYXRlX3N0YXRlLA0KPiAgICAgICAgIC5h
dG9taWNfZGVzdHJveV9zdGF0ZSA9IGRybV9hdG9taWNfaGVscGVyX2JyaWRnZV9kZXN0cm95X3N0
YXRlLA0KPiAgICAgICAgIC5hdG9taWNfcmVzZXQgPSBkcm1fYXRvbWljX2hlbHBlcl9icmlkZ2Vf
cmVzZXQsDQo+ICsgICAgICAgLmRlYnVnZnNfaW5pdCA9IG10a19kcGlfZGVidWdmc19pbml0LA0K
PiAgfTsNCj4gDQo+ICB2b2lkIG10a19kcGlfc3RhcnQoc3RydWN0IGRldmljZSAqZGV2KQ0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGlfcmVncy5oIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGlfcmVncy5oDQo+IGluZGV4IDYyYmQ0OTMxYjM0
NC4uYTBiMWQxOGJiYmY3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwaV9yZWdzLmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGlf
cmVncy5oDQo+IEBAIC0yMzUsNCArMjM1LDggQEANCj4gICNkZWZpbmUgTUFUUklYX1NFTF9SR0Jf
VE9fSlBFRyAgICAgICAgIDANCj4gICNkZWZpbmUgTUFUUklYX1NFTF9SR0JfVE9fQlQ2MDEgICAg
ICAgICAgICAgICAgMg0KPiANCj4gKyNkZWZpbmUgRFBJX1BBVFRFUk4wICAgICAgICAgICAweGYw
MA0KPiArI2RlZmluZSBEUElfUEFUX0VOICAgICAgICAgICAgICAgICAgICAgQklUKDApDQo+ICsj
ZGVmaW5lIERQSV9QQVRfU0VMICAgICAgICAgICAgICAgICAgICBHRU5NQVNLKDYsIDQpDQo+ICsN
Cj4gICNlbmRpZiAvKiBfX01US19EUElfUkVHU19IICovDQo+IC0tDQo+IDIuNDcuMA0KPiANCg==

