Return-Path: <linux-kernel+bounces-345561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D7E98B781
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957841C2261A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E34D1A00C5;
	Tue,  1 Oct 2024 08:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="luN82/vv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="uIxuO0oE"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3F1A00D4
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772454; cv=fail; b=P1g3DBf4W9jvwyR5PnTMfUmTeufwljAW4846Im4GKDTNcF6gBOw5JibtYGeu1jJwYxHQd+arNR3cB6oK9oxpU/c6Uefo4K4af7rtaY3vxQ91E1t3GxR7+A83EJShdAS1yO17DmMan509wY1uNupbsVPlfLWefrojlydbLM/oUi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772454; c=relaxed/simple;
	bh=bGP9RCk3u6GjOxYuC1b9AAZv3qDCCldp5uQGmlDwGW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cwUmvcTfLCN8JCUoOgNfd4kZk+SWjP6sWNm86khprz/m3Tf7+yWhePGW51xKiDZEuNHdYiPaPCSkQUfT6nvYtYlRMFVfSNKPlXQNkdovCuxtvBRemk+PFQcF2cakvTZZBATZ2pfGe5z384l/UzRm6/+15yapp+BKzYCMQyhM/PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=luN82/vv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=uIxuO0oE; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c475c1267fd111efb66947d174671e26-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=bGP9RCk3u6GjOxYuC1b9AAZv3qDCCldp5uQGmlDwGW8=;
	b=luN82/vvettAnSVy7gFpmgnQ3EFPAm0yQexbNPJ8JP55NUdruaBSPAK9L7NBzhMJp+VsXDNw9rnyxcZstGX5rIb58c9qer8sHDsIhf3vxp5OCJE34rO/CPwsbc5/kH/EWjZJ1dh7faNAkwmKubKBiYZgpUsS7yikjlJFSCRvQmQ=;
X-CID-CACHE: Type:Local,Time:202410011647+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:c31e4c3a-9a72-4ac0-bbb6-d437dfd6ef38,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:50ebd79e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c475c1267fd111efb66947d174671e26-20241001
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1875688384; Tue, 01 Oct 2024 16:47:19 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 16:47:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Oct 2024 16:47:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJAx4aRYknLeToF+zej5zYodeyRIiiygjoNe0UACCCtY2PWfCFBcvZuELgHrm1fCMgaL5Bxol87l5wWF5RL/qe6z0TXNdPcYcKXIR9QYyJGlPfDn9Ujnlge9EI/DyxG9Q8Is+2ReFLehxzghVx9dNGBOyk7Jv0k6XAm1G5cDiyB1RXIgC7QnTL5XNkvDNu+XQHPwbaZxpIAhZQ0N9EXxpwIX0Q9RTTMEiDP89v/XtPmxEJ38N7CQUcMHgLGiyl0xq98ZXCyFyDtqeKX086F001ZqhpKpN9qTC0t8KVZQ0DK1/61OjNguypTO31ZLaVu6RCab2ZUom3pkdzPKIWC4UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGP9RCk3u6GjOxYuC1b9AAZv3qDCCldp5uQGmlDwGW8=;
 b=eHca+XrmLX9l4K3Es3Rf23jzuun9oPTu4wD7hMvV/zCShRQdYx0tSqTBrLMCOWYjgDY28tL6TOAlqpxIfOM3K3SUB8VRT+3PrCi+2nH5NgAEqLYzOlaF/Ef934u5c5tf+mb0dWfoegXYJxQXfeY5fLH3b+rXF/o77SXVZXSsqiUfaODKMvwKjulRXkm+cVG5w206lI4AtM6TN0JFmzEzf3HfU5kQojgGzKw6sgBxrrmhJkSUisymXudseOOIro8YkBc0PP8IVLSiAlb3T4s7cRzlsgrOxDQzxyPpsIEIwjogGFyZ3Qje+SyOnc3SlZn/OviGx5g13WVLX1XHo+EFNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGP9RCk3u6GjOxYuC1b9AAZv3qDCCldp5uQGmlDwGW8=;
 b=uIxuO0oEt8h154okkjmUK/dnXiea6pcysic/g5Y6WadUJBoucrD1al5JEp4eo77r1mwOXQ4Q70EJ7wIIUNn3wiPfbWNmixQ4o8v5wzGcbkmYTAor6b04DlkfnhQgl3lTahZAxFAxsYePTY2w/66uXanygYAPqTZZQcZECxyI4yA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6710.apcprd03.prod.outlook.com (2603:1096:4:1ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Tue, 1 Oct
 2024 08:47:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 08:47:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 2/3] drm/mediatek: ovl: Add blend_modes to driver data
Thread-Topic: [PATCH v8 2/3] drm/mediatek: ovl: Add blend_modes to driver data
Thread-Index: AQHbEcHHzfhlfvJoTkWl/M2Skob5fLJxmYAA
Date: Tue, 1 Oct 2024 08:47:13 +0000
Message-ID: <e2538ec7153ecb382b3096f12bfa52df8dfb3eba.camel@mediatek.com>
References: <20240928161546.9285-1-jason-jh.lin@mediatek.com>
	 <20240928161546.9285-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20240928161546.9285-3-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6710:EE_
x-ms-office365-filtering-correlation-id: 486e6d82-6e1f-42ae-4b05-08dce1f5a527
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?citsZkw2SmFDQTBTQVRuNHVybDhnUnIzYXNncEZiRjRmcm1lVGpzdUsxQUZX?=
 =?utf-8?B?M0szOGtjUHBjZ1ByN2ZmQ3IrTU8zR2gxVUVORGRaam5MbXJvcjhTcXIwcEpI?=
 =?utf-8?B?blhqVWtkMlJ6NUN6T2ZKaVNUb0dPYUxCQmpxeC9xTjRRZU9mYmR6ZEdlWWMv?=
 =?utf-8?B?YlZqWGlIS0sxSGV0YVA5Mkc3KzZnb3p3RDRUNWM3WEFtV0g3SlVkWUt2aFdM?=
 =?utf-8?B?V2N5Zys4alZ2UXNEY1BqQ09rNWpyUUp5S09ockpoT0pzZERFakFZK0FDdXVR?=
 =?utf-8?B?VWswV0d0SjNLSkxORlJNRFdFRm5GdXhsTHBHUGdNSUdoYUNtbloyZUl4L1VB?=
 =?utf-8?B?YXpIQzlId3RUWCtjcTBraXVodHgzTERDRWFJd3lFSUszTEsydTRDS1NOZHJW?=
 =?utf-8?B?WTdMc1UzT3VRazBOakZtemlBaGR6TUlndlFsVndpejBkNUtzUEh1UjFMQ3FS?=
 =?utf-8?B?M29oU2lwZDRwcVZFQjNodUR0clJJMU5mQzJ4S0IrU2hUMTRMeUtPcWM2Q1k1?=
 =?utf-8?B?VmlzZjM2a0ZCc0lmaGREK0hObDdEVksrZTdFNGc4cnQ3S3h2QzE0aWZkUGky?=
 =?utf-8?B?VTF1YzRxcmt2Vmp2a2JCckhNaWN0b1Y3MGpEbWZXQW15bGZ4L0RtaTFsTlJL?=
 =?utf-8?B?TTkrUUpGNkdadnNha2tuR3VyRG5GSFNIbnlpVVRYaGp5dWVtTnZaSG93NFcy?=
 =?utf-8?B?bTVLZXk2am9vUTdmOEgzRHdWY0Ywem5KdDVKakZOVHdjUmdLeVl5c1ZGVUl5?=
 =?utf-8?B?bWhucmI5NVN1NjFONGFHMmV4NllRdjFwOEdkWkZQTHJtQUtuTm9XTTk3dFdM?=
 =?utf-8?B?c2hxZ2duMU5PRnB5OFBaVmlKMitVanczNFVnNlFsZXJJeFMrMytqanhNa3Fm?=
 =?utf-8?B?MWtqMmNPTlZ4dklza2RsV2RZcXljSHBFcFJUZnYyU0xkR3FPNE5oTUM3ZFFQ?=
 =?utf-8?B?VzRzREROZFQ4bytXWjlrcUMwN0pnQVNYVXZscGg4bDVkVU5rejlzckN5cU1J?=
 =?utf-8?B?YjBkcVpqU0V4WU5QK2lFQ2dtazlYY2t3SlJhUU5ZbGNJNzI1T2paZ2JtMlNK?=
 =?utf-8?B?OXRLMTltbGJtM0hKaUxyazBGVktpVytYaEN4UDN1MnBCSmgxbW1iNEJiNDkx?=
 =?utf-8?B?UHVGc056VWRkUEY5dFNkbU9sYUJmeG54TndoN1hDSVZTbzhJbE1UNUpEaUha?=
 =?utf-8?B?QUI4dENnZDR4NmRNS2twK3NpN0h3ckNMSzI2eExRVUJvbGE3ZUY0OEtDQTZt?=
 =?utf-8?B?UWFLSXovQzVwZmRzblFmaTRLZEFIMmRNMnBKYkYrTXRrSGgxYVpZTVpPZlNO?=
 =?utf-8?B?bVdUTjVCZG1tZnVtalM3S3IrRXYvTXQ4UkU0QVZaRnZ1T0o5c0RBVGJzdFVP?=
 =?utf-8?B?UnlwMEdPNmJBTmluTEZ2OU5DdXpuMm1qSDRVMjRHdTVQV1Q1b2lDTHFPbnMv?=
 =?utf-8?B?bGthRFluMDdYaGx3MWdqSEdYVStKdDZWNy82U1BZaHJ2UFEvRkYvaWJhVXZG?=
 =?utf-8?B?V2pOUm4vR2g0WXErdU9xampvcWVQRGdRNWtmcFFzbWlaeGRwcWJsUVU0MlY0?=
 =?utf-8?B?OXNDWmtzSnVLZE1EOWczYTBUWjF1aEJpOVdQZjlGUEFlcTRkTTFuQmE4bnRi?=
 =?utf-8?B?SHRvbldyZWp6aUx5cTJKeGREeDluL21rd0xxU0xIRmxuRUc0SVJpSERWNGtO?=
 =?utf-8?B?Tlg2akhsUlBTb0pwVFhZTVk1YURHTms4NTBwcC9lNmpEU01FOGVWSUIxQUts?=
 =?utf-8?B?bmdIa25lTmdnTE5mOUhiMWZmQVRjWko1SWgvR2srOXAyVHcrd0ZkZ2tqU3ND?=
 =?utf-8?B?eVpybUFpbEhnMnNzalFxQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzVCZmpRbDFiUm4rN0tjUEFJdVU3ZnJnV2J4NnV3YWhIS3RYdkdWOERidWtm?=
 =?utf-8?B?U0RFOW1QTTY0bThlSHhCTlhNYVU1WkdYQkFvZE1pbGNRZHBHLzUvS0VENmZS?=
 =?utf-8?B?YU5VVFZLRVRoU2xlN3YydldRR0U0WVQxSmhnclIzSHdiMWZFTi9QVnJkODEw?=
 =?utf-8?B?NlVtUlF3WmRpSlAvZ01Bc1dRNVh3eXMrVTdaR01LbjBNOGtwZVV3TUxWNmZ1?=
 =?utf-8?B?cU9rZHphQ0JCelZFQmZOL3dyMDBCUnAyU0t5bWpXbmJvcVdtVGx2SmxBZDli?=
 =?utf-8?B?MzhKNzZWOGp3Y2VuSmM1NllRbzJDUkYrc3RvY0VPM1ZxR0QzNkNNT2xPaFdS?=
 =?utf-8?B?SWFUSUlqZVlwVThOTnoyNHI3NnhCSGttK3Z4Z0QxeU9pN0tXS09xSHlhaGFh?=
 =?utf-8?B?OTdjRDF0cWlOeWJIb2lpOGluNjFJWGtQY0dwVjI1Z3p3bkdyZmVWdXFjKzFn?=
 =?utf-8?B?VGFDSU44dmhMSGxmSHNNaWVwRWg2QXI5cDF1N1AwWUw4R2xwSlVWUUZBdjgx?=
 =?utf-8?B?T0c1bUFJZ3JlNHlkcUcxdFhJWUovLzJkYUtvRUtRY01RZGIvYUFEZ1AzS2lE?=
 =?utf-8?B?aXl4YTRmanM4dmFnS1hmaWhmSFlicU9SYXk1RFdHZDdTa0RxdXRqblh3Mjl5?=
 =?utf-8?B?Ukoyd20zeWhHeHE3eE9rd1czS1F5Lzd0Q2I2ZUQvZDZrdVdCQ01yV2g4TmZP?=
 =?utf-8?B?K1BlaStpamtKeTFJSUdFbFViZ3BYYi9FdEVqQm5xY1QvZXlWMzJzZmFjQzBG?=
 =?utf-8?B?YklJNWlkbHEzT0hQdkRXU3c0UEdDYnBUNUdqVy8wbzZMT3BTbUptMVpFME9w?=
 =?utf-8?B?eHBMcUR1QnJ0Wm44SzljV2JKVGpsVm8vS0ZOYnVLL29hZ3F1UERoT2trQ3pl?=
 =?utf-8?B?TVhqRXRieEtkWVFRM2ZOd2doSDNxWUZzUmlzZjdwbHNyNW95MmNxUTNXazF5?=
 =?utf-8?B?Q2JXTUpubXRiQmIzUFhQeERBaHRXSlljYi9TR2piNFZjMGdWYUN2NmZuZzIw?=
 =?utf-8?B?dDNTTHMvYlJVRUtpZDlqbXRaNExqL2xrVVdicTI2VkR0dDMrSVlSQ0JOVlZV?=
 =?utf-8?B?d2dmMVpjbE9jeW5ITWZjNzhLQjBHcW4zR1J0NTJ6d3FMaVFnekNabU5NTEgv?=
 =?utf-8?B?bGpqei9uWWZZSXZrc2JXS3gycVhRcHZxSlUyOEdDdjAyOHZhakYwUGhZZU5z?=
 =?utf-8?B?OGdvVmQ4M1dlaEt2dGpGK1FVUkR3UWFNNGNXNjZiSUE3TVZialpJLzkzSW9q?=
 =?utf-8?B?YlgrcTNZdWZxYXNXOGMwMm1xM1F5czA0MmVCN2dBOFpqNW9aWURaOWhNSjBQ?=
 =?utf-8?B?eDhoTVFxclpGdEt2R04rTTBLdW5Yc3ZTQlhmVXlsbHFTazVpNTJDd1BEU25K?=
 =?utf-8?B?dDhZMTRrYlRmbFF6U2IvekF0UEs4TTg3UGs1WENFNTRDOXZST0c3SngrY0dM?=
 =?utf-8?B?cjdtTUNjMm5hMG5VYzduY0wyOHdodkFoVkI2K29LTUlZc2loSm9iYjMzOU13?=
 =?utf-8?B?VlpPeGxVd0RqQ2FOcFB1VExXKzMvdWVuZUJyVXZlTTBOcFh0dEdkdUpmcXhS?=
 =?utf-8?B?VVNXNkU4d1p3aC8rbWRrbzVFcWVpMWlzV3V1amF4WXNTMGpLZXh4NFBnMllP?=
 =?utf-8?B?TUljNlM0MlZjY3NWeHkwblREaTc2WkNpaktZV28weXFIRGRFK3AzdTk5MGVZ?=
 =?utf-8?B?bGltcG9YcHN2SzYweXlVaExxRFZQWG1zdytWMnJpTW1LclhUTUZpeDB2NHd6?=
 =?utf-8?B?REhmYTlwcXFFNWIvSSs3dmtLblNTWVVKUWtTOElzeWVhNkhWMUVsV0FkaEVm?=
 =?utf-8?B?clFZZVdxYVpMdk5aS3pzTnBLTXZ1R1VBVDhnRkF6bHExbTJpT0o5MEJ4cDJ6?=
 =?utf-8?B?MTJzUUd1OG1TMlV0MDE0blFqQm5abzRVY2U3Mlh5TkhtSWMrSHRZVkNaU0Jw?=
 =?utf-8?B?OEtQQzNLVGRCY3JnaTQwODFpOXUyQ0JpVFBKVmZ0cnB4azBoZStkM1ltUUgw?=
 =?utf-8?B?clZrTzJJQnZNUm9tZ2J5ZEE2dEF4a2loeGUwNGhQVC84cUk5NGc5d25pSmNj?=
 =?utf-8?B?OUZjQVVsVlI1elhSdWZsMTB0Z3UxeXNZTE00Wm9SWGE0aFVZem1Hb293elg0?=
 =?utf-8?Q?JQV/25p06PaV/zl5ufY22jtvR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <57DAC30F01B43D4F9E02BFC99E6E9DE1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e6d82-6e1f-42ae-4b05-08dce1f5a527
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 08:47:13.3674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ptqbW8gxq9ZQhNRIAD0djPSKOAy9iiinSsJRTznMmjZQjhEgDcv+5is8T/bLuIbXFyreRBdPR2ES6i9G/gOV1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6710
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.041100-8.000000
X-TMASE-MatchedRID: VfovoVrt/oYOwH4pD14DsPHkpkyUphL91KoSW5Ji1XuPaLJ/Ca3STwA0
	TKIn6AX5uyk/HuTVlgpGKo6edwW+zD1LciJB3541SHCU59h5KrFQCOsAlaxN77uqk4cq52pzvC9
	QV1k8eAgPeKO+OnDfh7pVHZLpk9ho6li7wmYeB3lDiyuN5FvFNkyQ5fRSh265FLXUWU5hGiFk7/
	Hmih62oKa4Tywc0f7RIpdLXGaTzIlXSN89RTJnt98tWTI1R8epU+A7YkpDJ1hCannV/b7f2YEpJ
	Rcbelqd93LsYxp0JcCRk6XtYogiatLvsKjhs0ldVnRXm1iHN1bEQdG7H66TyH4gKq42LRYkaTYi
	sFNSAnwN9roh5au7FBXTF8ScpzFqLVF2xO8ojuJ+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.041100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	280C0F55DEE007823D83B69DAADB1C9B98F96E84BEE40F8D9A64E949E3FFC4C02000:8

SGksIEphc29uOg0KDQpPbiBTdW4sIDIwMjQtMDktMjkgYXQgMDA6MTUgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gT1ZMX0NPTl9DTFJGTVRfTUFOIGlzIGEgY29uZmlndXJhdGlvbiBmb3Ig
ZXh0ZW5kaW5nIGNvbG9yIGZvcm1hdA0KPiBzZXR0aW5ncyBvZiBESVNQX1JFR19PVkxfQ09OKG4p
Lg0KPiBJdCB3aWxsIGNoYW5nZSBzb21lIG9mIHRoZSBvcmlnaW5hbCBjb2xvciBmb3JtYXQgc2V0
dGluZ3MuDQo+IA0KPiBUYWtlIHRoZSBzZXR0aW5ncyBvZiAoMyA8PCAxMikgZm9yIGV4YW1wbGUu
DQo+IC0gSWYgT1ZMX0NPTl9DTFJGTVRfTUFOID0gMCBtZWFucyBPVkxfQ09OX0NMUkZNVF9SR0JB
ODg4OC4NCj4gLSBJZiBPVkxfQ09OX0NMUkZNVF9NQU4gPSAxIG1lYW5zIE9WTF9DT05fQ0xSRk1U
X1BBUkdCODg4OC4NCj4gDQo+IFNpbmNlIHByZXZpb3VzIFNvQ3MgZGlkIG5vdCBzdXBwb3J0IE9W
TF9DT05fQ0xSRk1UX01BTiwgdGhpcyBtZWFucw0KPiB0aGF0IHRoZSBTb0MgZG9lcyBub3Qgc3Vw
cG9ydCB0aGUgcHJlbXVsdGlwbGllZCBjb2xvciBmb3JtYXQuDQo+IEl0IHdpbGwgYnJlYWsgdGhl
IG9yaWdpbmFsIGNvbG9yIGZvcm1hdCBzZXR0aW5nIG9mIE1UODE3My4NCj4gDQo+IFRoZXJlZm9y
ZSwgdGhlIGJsZW5kX21vZGVzIGlzIGFkZGVkIHRvIHRoZSBkcml2ZXIgZGF0YSBhbmQgdGhlbg0K
PiBtdGtfb3ZsX2ZtdF9jb252ZXJ0KCkgd2lsbCBjaGVjayB0aGUgYmxlbmRfbW9kZXMgdG8gc2Vl
IGlmDQo+IHByZW11bHRpcGxpZWQgc3VwcG9ydGVkIGluIGN1cnJlbnQgcGxhdGZvcm0uDQo+IElm
IGl0IGlzIG5vdCBzdXBwb3J0ZWQsIHVzZSBjb3ZlcmFnZSBtb2RlIHRvIHNldCBpdCB0byB0aGUg
c3VwcG9ydGVkDQo+IGNvbG9yIGZvcm1hdHMgdG8gc29sdmUgdGhlIGRlZ3JhZGF0aW9uIHByb2Js
ZW0uDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBG
aXhlczogYTNmN2Y3ZWY0YmZlICgiZHJtL21lZGlhdGVrOiBTdXBwb3J0ICJQcmUtbXVsdGlwbGll
ZCIgYmxlbmRpbmcgaW4gT1ZMIikNCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNv
bi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBE
ZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgfCAzNCArKysrKysr
KysrKysrKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3Zs
LmMNCj4gaW5kZXggNGE0YmMyN2E2N2YwLi40YmZlZDhhNGMxNGYgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTE0Niw2ICsxNDYsNyBAQCBzdHJ1
Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgew0KPiAgCWJvb2wgZm10X3JnYjU2NV9pc18wOw0KPiAgCWJv
b2wgc21pX2lkX2VuOw0KPiAgCWJvb2wgc3VwcG9ydHNfYWZiYzsNCj4gKwljb25zdCB1MzIgYmxl
bmRfbW9kZXM7DQo+ICAJY29uc3QgdTMyICpmb3JtYXRzOw0KPiAgCXNpemVfdCBudW1fZm9ybWF0
czsNCj4gIAlib29sIHN1cHBvcnRzX2NscmZtdF9leHQ7DQo+IEBAIC0zODYsOSArMzg3LDI3IEBA
IHZvaWQgbXRrX292bF9sYXllcl9vZmYoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQg
aWR4LA0KPiAgCQkgICAgICBESVNQX1JFR19PVkxfUkRNQV9DVFJMKGlkeCkpOw0KPiAgfQ0KPiAg
DQo+IC1zdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bf
b3ZsICpvdmwsIHVuc2lnbmVkIGludCBmbXQsDQo+IC0JCQkJICAgIHVuc2lnbmVkIGludCBibGVu
ZF9tb2RlKQ0KPiArc3RhdGljIHVuc2lnbmVkIGludCBtdGtfb3ZsX2ZtdF9jb252ZXJ0KHN0cnVj
dCBtdGtfZGlzcF9vdmwgKm92bCwNCj4gKwkJCQkJc3RydWN0IG10a19wbGFuZV9zdGF0ZSAqc3Rh
dGUpDQo+ICB7DQo+ICsJdW5zaWduZWQgaW50IGZtdCA9IHN0YXRlLT5wZW5kaW5nLmZvcm1hdDsN
Cj4gKwl1bnNpZ25lZCBpbnQgYmxlbmRfbW9kZSA9IERSTV9NT0RFX0JMRU5EX0NPVkVSQUdFOw0K
PiArDQo+ICsJLyoNCj4gKwkgKiBGb3IgdGhlIHBsYXRmb3JtcyB3aGVyZSBPVkxfQ09OX0NMUkZN
VF9NQU4gaXMgZGVmaW5lZCBpbiB0aGUgaGFyZHdhcmUgZGF0YSBzaGVldA0KPiArCSAqIGFuZCBz
dXBwb3J0cyBwcmVtdWx0aXBsaWVkIGNvbG9yIGZvcm1hdHMsIHN1Y2ggYXMgT1ZMX0NPTl9DTFJG
TVRfUEFSR0I4ODg4Lg0KPiArCSAqDQo+ICsJICogQ2hlY2sgYmxlbmRfbW9kZXMgaW4gdGhlIGRy
aXZlciBkYXRhIHRvIHNlZSBpZiBwcmVtdWx0aXBsaWVkIG1vZGUgaXMgc3VwcG9ydGVkLg0KPiAr
CSAqIElmIG5vdCwgdXNlIGNvdmVyYWdlIG1vZGUgaW5zdGVhZCB0byBzZXQgaXQgdG8gdGhlIHN1
cHBvcnRlZCBjb2xvciBmb3JtYXRzLg0KPiArCSAqDQo+ICsJICogQ3VycmVudCBEUk0gYXNzdW1w
dGlvbiBpcyB0aGF0IGFscGhhIGlzIGRlZmF1bHQgcHJlbXVsdGlwbGllZCwgc28gdGhlIGJpdG1h
c2sgb2YNCj4gKwkgKiBibGVuZF9tb2RlcyBtdXN0IGluY2x1ZGUgQklUKERSTV9NT0RFX0JMRU5E
X1BSRU1VTFRJKS4gT3RoZXJ3aXNlLCBtdGtfcGxhbmVfaW5pdCgpDQo+ICsJICogd2lsbCBnZXQg
YW4gZXJyb3IgcmV0dXJuIGZyb20gZHJtX3BsYW5lX2NyZWF0ZV9ibGVuZF9tb2RlX3Byb3BlcnR5
KCkgYW5kDQo+ICsJICogc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZSBzaG91bGQgbm90IGJl
IHVzZWQuDQo+ICsJICovDQo+ICsJaWYgKG92bC0+ZGF0YS0+YmxlbmRfbW9kZXMgJiBCSVQoRFJN
X01PREVfQkxFTkRfUFJFTVVMVEkpKQ0KPiArCQlibGVuZF9tb2RlID0gc3RhdGUtPmJhc2UucGl4
ZWxfYmxlbmRfbW9kZTsNCj4gKw0KPiAgCXN3aXRjaCAoZm10KSB7DQo+ICAJZGVmYXVsdDoNCj4g
IAljYXNlIERSTV9GT1JNQVRfUkdCNTY1Og0KPiBAQCAtNDY2LDcgKzQ4NSw3IEBAIHZvaWQgbXRr
X292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0K
PiAgCQlyZXR1cm47DQo+ICAJfQ0KPiAgDQo+IC0JY29uID0gb3ZsX2ZtdF9jb252ZXJ0KG92bCwg
Zm10LCBibGVuZF9tb2RlKTsNCj4gKwljb24gPSBtdGtfb3ZsX2ZtdF9jb252ZXJ0KG92bCwgc3Rh
dGUpOw0KPiAgCWlmIChzdGF0ZS0+YmFzZS5mYikgew0KPiAgCQljb24gfD0gT1ZMX0NPTl9BRU47
DQo+ICAJCWNvbiB8PSBzdGF0ZS0+YmFzZS5hbHBoYSAmIE9WTF9DT05fQUxQSEE7DQo+IEBAIC02
NTgsNiArNjc3LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YSBtdDgx
OTJfb3ZsX2RyaXZlcl9kYXRhID0gew0KPiAgCS5sYXllcl9uciA9IDQsDQo+ICAJLmZtdF9yZ2I1
NjVfaXNfMCA9IHRydWUsDQo+ICAJLnNtaV9pZF9lbiA9IHRydWUsDQo+ICsJLmJsZW5kX21vZGVz
ID0gQklUKERSTV9NT0RFX0JMRU5EX1BSRU1VTFRJKSB8DQo+ICsJCSAgICAgICBCSVQoRFJNX01P
REVfQkxFTkRfQ09WRVJBR0UpIHwNCj4gKwkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9QSVhF
TF9OT05FKSwNCj4gIAkuZm9ybWF0cyA9IG10ODE3M19mb3JtYXRzLA0KPiAgCS5udW1fZm9ybWF0
cyA9IEFSUkFZX1NJWkUobXQ4MTczX2Zvcm1hdHMpLA0KPiAgfTsNCj4gQEAgLTY2OCw2ICs2OTAs
OSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kaXNwX292bF9kYXRhIG10ODE5Ml9vdmxfMmxf
ZHJpdmVyX2RhdGEgPSB7DQo+ICAJLmxheWVyX25yID0gMiwNCj4gIAkuZm10X3JnYjU2NV9pc18w
ID0gdHJ1ZSwNCj4gIAkuc21pX2lkX2VuID0gdHJ1ZSwNCj4gKwkuYmxlbmRfbW9kZXMgPSBCSVQo
RFJNX01PREVfQkxFTkRfUFJFTVVMVEkpIHwNCj4gKwkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVO
RF9DT1ZFUkFHRSkgfA0KPiArCQkgICAgICAgQklUKERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUp
LA0KPiAgCS5mb3JtYXRzID0gbXQ4MTczX2Zvcm1hdHMsDQo+ICAJLm51bV9mb3JtYXRzID0gQVJS
QVlfU0laRShtdDgxNzNfZm9ybWF0cyksDQo+ICB9Ow0KPiBAQCAtNjc5LDYgKzcwNCw5IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsX2RhdGEgbXQ4MTk1X292bF9kcml2ZXJfZGF0
YSA9IHsNCj4gIAkuZm10X3JnYjU2NV9pc18wID0gdHJ1ZSwNCj4gIAkuc21pX2lkX2VuID0gdHJ1
ZSwNCj4gIAkuc3VwcG9ydHNfYWZiYyA9IHRydWUsDQo+ICsJLmJsZW5kX21vZGVzID0gQklUKERS
TV9NT0RFX0JMRU5EX1BSRU1VTFRJKSB8DQo+ICsJCSAgICAgICBCSVQoRFJNX01PREVfQkxFTkRf
Q09WRVJBR0UpIHwNCj4gKwkJICAgICAgIEJJVChEUk1fTU9ERV9CTEVORF9QSVhFTF9OT05FKSwN
Cj4gIAkuZm9ybWF0cyA9IG10ODE5NV9mb3JtYXRzLA0KPiAgCS5udW1fZm9ybWF0cyA9IEFSUkFZ
X1NJWkUobXQ4MTk1X2Zvcm1hdHMpLA0KPiAgCS5zdXBwb3J0c19jbHJmbXRfZXh0ID0gdHJ1ZSwN
Cg==

