Return-Path: <linux-kernel+bounces-216810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6CC90A708
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E18FB2CED9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564C918C320;
	Mon, 17 Jun 2024 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I7N2dQef";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gYUSOkyV"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727E17E44B;
	Mon, 17 Jun 2024 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608712; cv=fail; b=g7lDIPSH+8N/adh9KRZ3iK4soF5wK0S7iVqXnfksyd49dxg1y1+zTRQWWh2p7/PJRfBpnNMLAR8I2T2dWBAlQyTRCcwQO/2velLxho5stTem5XntoO3mLrbe+KV+EBnIoTPF7qp+73k7a1ujdRukcUzl/tnpGy/Je0WzOQe6rX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608712; c=relaxed/simple;
	bh=E1lYYd6sfgIUbSy2hbbsavrmhNz+166M7tHc2UaR7mo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKkMvYWXBOV8eYhY4v4NzMVXB0zCIp0VqCRQMQyRHUZZbVUrl3OMUeURjVZjhbDtsC7BKU1Wz7TLrf8Kt9ZqFFJ0G4TZ9EDotXkqaLCLkcmvUbku1T5CxGSjgFbvtrmbakT4YJlBp2oTn7NObywqbzrAcgI+zxBVBEpsokD6lH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=I7N2dQef; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gYUSOkyV; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c8bdd4902c7911efa22eafcdcd04c131-20240617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=E1lYYd6sfgIUbSy2hbbsavrmhNz+166M7tHc2UaR7mo=;
	b=I7N2dQefgi29mM/+R8RoGKIvFhAZKu58g7reFuEuN/iMnfiTdDvogIs1AgYGovdng/sZpDzu8zj3odnSK8lx3CtQOoIDBzVW6pVHiQW6WDDzI8XRvOdCSr5PBejoU4WPOggpIrN+6FlMQ6/9dLUuVruKFANqzJWNdnxe5qqi9LE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:2c73be3e-bd8c-4fb1-b42c-27385655d8c6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:eaf6ac88-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c8bdd4902c7911efa22eafcdcd04c131-20240617
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1357825900; Mon, 17 Jun 2024 15:18:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 17 Jun 2024 15:18:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 17 Jun 2024 15:18:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6Y7dm7N+ZgIedegDkfIhU9Adx/TAbzdh31YcTQf+6A1qZQIs36aO7THrph+UE269y/lkqK52cabinL5lCBw+qxQh/GyYzzUzgfM4S7hK6PbLqU55/H2uVt/fqLXsPR/OkbcZqQaKbkXqKnLMuJ28jA5F2495IlxRExXDz6+47BKy598cHqliWM0LY8c86Yn8e9eczhcqA6pv/9COdUn/26h3N/gdCAYz3pZ9RUwcBLMT/zFAVg/xi7xbz3K9M1pVMxfZTsdVhiTiuaHtlXaX1d7E7QS4sfTZ3CZrK3NC8ppAwwZKGUI40ceJwqUepNDYydR2Lyo9bC0nbx8VaqOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E1lYYd6sfgIUbSy2hbbsavrmhNz+166M7tHc2UaR7mo=;
 b=GRbyT/OG+MRmj+pR6NcyrB1rbGN303uV9hSmKlc5AMQtkGKguZL5pVQTfNs8SNE5n0BiJYCp1NkynlYNN1gExEtZ4ysAR3orSnaxS1jYHN1PBWZmdU1cTVlKlH5SV/2NNa6fZ3a8j89ScE1AAL1EGnXD58vKgAfOC6GQpU8XqKU9xiI+7sEtwiDHFq6cV08Z0VswOoh7Np2Bn9oUM17dlyM0gxyeE5saL2Knlpkw4F270lo7a6BtYAP2WKdY26jrhK+HUVvNq7aozpVEAbBSV5grYxOVl4oyLRu+LbjhGWbJBvZy8RaGLDk60WP392cArVHEBoDqNpGdbNX762ZDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1lYYd6sfgIUbSy2hbbsavrmhNz+166M7tHc2UaR7mo=;
 b=gYUSOkyVfuiU9XYhSy2fWl/xrf980neJtuk3I92f501SwI/XLOFQkfBmKe8JQyB2saD5f1cdHmMzDai+p/tGWeYcQuujkUNLeZn+d9YpTZSxuFPlDDPnhZG8skh5Uw2MWVp1CIdAhQKJa8UEzw1vxbDNIUuuN9s1RKjvSeypxDw=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by SEZPR03MB7245.apcprd03.prod.outlook.com (2603:1096:101:a8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:18:21 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::9fa0:ee98:d5ed:beba%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 07:18:21 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH RESEND, v6 6/8] mailbox: mediatek: Add CMDQ secure mailbox
 driver
Thread-Topic: [PATCH RESEND, v6 6/8] mailbox: mediatek: Add CMDQ secure
 mailbox driver
Thread-Index: AQHar3t3cpLUl9xLck+PMVeju4DUbbHLrhgA
Date: Mon, 17 Jun 2024 07:18:21 +0000
Message-ID: <ed98af2c1fcf878a83dff4b9667db57c3412d708.camel@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
	 <20240526144443.14345-7-jason-jh.lin@mediatek.com>
In-Reply-To: <20240526144443.14345-7-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|SEZPR03MB7245:EE_
x-ms-office365-filtering-correlation-id: 5de1da79-4799-4c00-53a5-08dc8e9dab34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?Vjc2UkV3VFVnZzMyRFJjem1kdDRoa1NxN3duWlRhU2cvS2h4Sjg4ZTYwMkw1?=
 =?utf-8?B?OHN0RzE4T0FBcDlLeGZYQkxFOVhIb05XZHB6T1Zsc1pVMUE0MzRPREV0cXJa?=
 =?utf-8?B?dWNGVnUrNklGS0NpSlBGRzAyUWxCSU1hY1dyaHg5TjI3S05NSjBxR1M1czZY?=
 =?utf-8?B?SHdJTUNrRVpMUDVYYkx1K2RsM2ZzRElwa25jVnk0RnhEb2FEa0RkckVZa2xY?=
 =?utf-8?B?ZnJrUm91aHZTUFFHQkVoTTJxS0hIMC9KeFlXV3NHVm5iWkpxYXA5cUhVOXMw?=
 =?utf-8?B?NEk1OTNMY1BDSFRzclF2V3FMbWt3MkkvNGMrbDJTK0xiQiszUU10dElJc2s1?=
 =?utf-8?B?NHM5SjhlaFhnZ3pSb3BqUGh1N0owOTdQM3EvNXZOQk81OXB3S1Y3ZHBwWTJH?=
 =?utf-8?B?OFRDbklBTHZFY1ZIOHJXL2NLLzdrVzgremtjeTBEOFRpQmt6eXg3aGdlWjRM?=
 =?utf-8?B?RGIrUXpyYWcvbkNWK1RCOGpWYVNkQVM5MTFKRFNNUFFsaERaOWY5Vk5yUmxK?=
 =?utf-8?B?eWhvQnJTWHBDbHpIZ1o2RkIzR3FhZFJqQ280MjA4Mkh0RTBtbXR2ZHB0SG5l?=
 =?utf-8?B?czYvVTlORzhiRHRJdUVVbXQ3WERYaW5ETFBVYm9nZjE1cmwrQ3dtZHBzZDBx?=
 =?utf-8?B?VUpPbm1sVVJlZEpMYm4xNCtUUlpBOFVMaDA5bkJOd3VZV1ZBTXRmRFV3M3Ro?=
 =?utf-8?B?cmxlQkVlZnBZK1l6eDFYTmtXSmhqR0dWK29nbWtybmtFTkdCRWREQ3pDb3J4?=
 =?utf-8?B?Z1VQSHR3Vy9HSXVJRlBKNGFvbEI3NUd6YW4zQTl5ek1QRXBHcktzWUVlKzdC?=
 =?utf-8?B?dGQrMDFPQnZ5Yng1YlVvcTFYdlZUbm5pZVpXbzVqUEdGZ1FEcGRmK0xoOGNk?=
 =?utf-8?B?NjdadFNXRUNKMTY5WE55YnZObzJXeDRHMlBTUDhlc2FoZ1N5dkxDVmhkTlNt?=
 =?utf-8?B?UmNXS0NhaVloSkx6akVPVjFhYmJPZXlNMUlLbGJQSUxhejBwdjh3NGlab21h?=
 =?utf-8?B?OGkveUUzdldOS0xtYWM4cy9qWVZXYmxRNTRZMmFQR25PY3JJN3ptT0ZuSjlY?=
 =?utf-8?B?SHVMZGRuVXNPYndFYTBlV1QyekR4eVJBV01pZGRpZlFPRjhsNThXTk5LTExZ?=
 =?utf-8?B?cmE1SW12Y05MMzBmNU5rcit0a1ZNb3FnWkRzSWd4TWVoOW14amhPcnJDTito?=
 =?utf-8?B?UW1YRm4vRm1iYU9PVWRzNlBlSnhxeVIrS2c2KzJwaDJLQklGVW94TmJMY2Ri?=
 =?utf-8?B?ODg5eVZTVkVWdURIRGM0Yzh0amdnU2pFanFQVHQzQUJFQXNzNi94b1Z2cUor?=
 =?utf-8?B?azR3MmNod0dYN0duYms1RHcyOHBUSWw5ZXQ0eHYzaWxZVythK2NDcVBuRVpT?=
 =?utf-8?B?SCtmOTV6b1BPNVkva1ZuelhrWi9aUndScHMrMFpNR3hFaHBMVGFuTHh4U1Uy?=
 =?utf-8?B?NnhJQWVwdWxlc0p2aWpxVyttaXNvcUwrRnRDcjV1WVE4Z05WbkhIbWFack12?=
 =?utf-8?B?SktNbm5FMlhzejZyTUw1bHprZTYxRU9oeDQzS3JOK0ZXRkdhNDh3QTdOOVJr?=
 =?utf-8?B?MWl4cHorUmhrN3NVclU0ejVYdjc1U1JIQUczMjEycDRJamVzeUFCSTN1NGhB?=
 =?utf-8?B?VVVBS0FweUl3d2pRRTdYd3NEWWZ5SE9OckdOZXl3cGFvZmlnMGcvaCtrdWNQ?=
 =?utf-8?B?R0VBbWFQaWJldi9ZQUt6V2pZbk01VGZBRHBDRkRvRjdOYkpwbDdRTmpjOGNh?=
 =?utf-8?Q?HsVtctIO0VgXaTW6/WCwl+QlVSU+mOqoM2FppuF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnV3aW1FMlduQ3hrMlBHQWVGbjhQNktiRmhCVy9YNEpkK2hPMklHYlhLdXlS?=
 =?utf-8?B?Y3RLdXYxaWRyNC9pS0Z3aXRGejdHZ2NsM0JyajluQ29FMDlzLzhWSTdEUWdY?=
 =?utf-8?B?Ulg2ZUNLcVhkRjk1UkNkcE9nb2NzQUJKRk9wL2tYOUNSZlk1OXJ2Z2YrQ3Q3?=
 =?utf-8?B?bmFCdGZJRTFEcUh3cDdaWE1aeGl2eTllWW1HbG5SNC83dy8vNVhDQmYvNGdO?=
 =?utf-8?B?ZU9QRlJTOVFQWERIUjhXam93dWIrM1c0alRmUW0rN0l6clROMkxRcCtQd01O?=
 =?utf-8?B?QmJCcEkvSGlZbXVDZGFGYmFYVnRTeUFGUFlFVHRqTk5yNEluaEtxYzdvV2dw?=
 =?utf-8?B?SzZ5WWRmQy9rQXdoQVdTM2pudnA0WGlwN09tUFlJS2hlczVic3RXYWtSenpt?=
 =?utf-8?B?bFBoVGlRdWtrajk2OHExUEZNazhJSHVyaEtyaWpvOUsrSUxNblFsU3JSZyt1?=
 =?utf-8?B?ZVM1M0h0TjlVbFIrMGthTmpXN2x2SG1jQWZPN0h6a3N0Z0V4WkhsY1ZnckhT?=
 =?utf-8?B?V0ZxN3Nia09iYkN6VEVZMXFpZURYeGNhRXJsdS9ScmwrTjhjM2I4b3hoaG5h?=
 =?utf-8?B?Q0lPR1VxTk5nZHBJM1I2MnFVMDFMWHFNTzBSbjV2cUhGSjRJdE9nQ2R1amJ4?=
 =?utf-8?B?Yi9xWkpLTlIvOXpQVlpWdnJCcWttTEJ2b3ozYzFxOU1kcFpja2tRNjVlWDVU?=
 =?utf-8?B?SVNDQjhsbi9sMXpNdTdXODI5a0FYVDFrUzFhMXNydndGNUROaks5MGtLTnBZ?=
 =?utf-8?B?Q2QzazZqajNoeU8vVFQyZi9KakRvS2RZMUJVZllGV21wOHkyUnpId3dCYWJI?=
 =?utf-8?B?akdpL3Y0enNScUlHZ0NJbXladnZzT0lpU2Q4Ti9uMzYvaFVpZCtETWRWN29T?=
 =?utf-8?B?SCtEQUFrekh5L0cxQ3ZmbGhwcmtXeXhtV0JmT1pNdkdQbWJiUmtjOTE4UXN4?=
 =?utf-8?B?eFU2ajZxOEVhczBFekpvNWhLRlRmTDNsK2dEY0p6dGN0bkZNcm5udmhGYnZ6?=
 =?utf-8?B?NGN1akNPK1pDQVNhVDFmWDJjTXk0OWFqZlhWUEFHSXBTM1VFYUpRajNqWE9Z?=
 =?utf-8?B?cEwxVjhxNGljS1JGR2FBNUZZQTJ1ZEVHUGlsa3c4U2x3bHdUSXZwVzFKMXN3?=
 =?utf-8?B?SDd3SlRKQWdiMEgrKzU2aFpxbnhibitUUEZHckUzTDZCWGthOFBWVWZISG1O?=
 =?utf-8?B?NXNadjhTVWFCejRXdGdiZ3RYTTBoSlVxZFV0V2xZNXJoZnVBYjhrSWY1MzhX?=
 =?utf-8?B?SnJ2NzRQc29DQnNJWUhWS2svMVd2UytqanBhVEloRmh4WHFMM3BCdFM2enA3?=
 =?utf-8?B?eFk5a1VUblUyS0FRR3ZFQ0JLMjFpYlM4TjJrZFQyQTNYTmdiVFNWM0ZCWWZW?=
 =?utf-8?B?ZGpraENvb2U0b2NmaDRYVStDNUJOQkN2UWdHYmpvUm5kMWVKRVBJVlRpU0w3?=
 =?utf-8?B?eDFKSjI1dFU2aFErL3FEeTFneFBKc3Y1bTJQZzFtVDBxQjZWRllRS25FMXJo?=
 =?utf-8?B?amFZZkJoY2c3b0FIVjRMT2hwN0NFYWMzTGVldEtQVFo2N3lRMWplODlXMnVn?=
 =?utf-8?B?N1VUNC9KbmhFTXZLam42Rm8vNDRzdVNwUWZBZzREVzhLL0NrNGRsZ1dHQ25Z?=
 =?utf-8?B?OStoeGNYNGI5VFBFTTFSK2x1VVAxeFZVZWxQTXNWZGdFN09ENE1aUkFwTFVx?=
 =?utf-8?B?SnRMbXkyZW1pM2xKOXp6eEpMVHdiWHYxT2ltMGZOcUFuWVBBb3Bta3JnVmdO?=
 =?utf-8?B?ZlFLOGRBaGZUZjFpMDQxYnk4V05uL0V5NndvT2tLQ2p3ZDM1UzZIREk0TjdW?=
 =?utf-8?B?VU94MTNQVjNYcEVjWFg5amJBWklWUVdkOVFlbUs5TGlWRjhCbWRsaVFXUCtm?=
 =?utf-8?B?dFdWWlZZUWlEVURBL1RISmZJeVd0b3RvczlYTkRaaG1xS1d3WVZOY2lRWVdn?=
 =?utf-8?B?WC9PeWpzQXhhTm9TYm13RjZKSlk1Si9UL0dtU0RtVVk5dnZsaXQ4STJlSDdS?=
 =?utf-8?B?VXVTSWZWVkQ4MVQ5ZUREWmVlTlJoMnBFSUVaeS9YRitjU1N5azhxc1V3OElq?=
 =?utf-8?B?OU9VUS96Zm11TGQ3dmdYREhLSzF2Snk1RTU3N3NrOGJ2bW9waGF2SkZ3a3oy?=
 =?utf-8?Q?sJDVn/92fl5oGnF5V0JzooOgk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40235A2040B9D8408D401CD2E9604370@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de1da79-4799-4c00-53a5-08dc8e9dab34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 07:18:21.3002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJzdbbzLPI2ba2yCLXZ1+GRDM163f35cEk5Qcd7YhqSVECEmzXhWmWXRW0W4AkDaya3t0mYrI6pjszxw2K3EhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7245

SGksIEphc29uOg0KDQpPbiBTdW4sIDIwMjQtMDUtMjYgYXQgMjI6NDQgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0Ug
aGF2ZSB0byByZWFkL3dyaXRlIHJlZ2lzdGdlcnMNCj4gaW4gdGhlIHNlY3VyZSB3b3JsZC4gR0NF
IHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzIHBlcm1pc3Npb24gdG8gdGhlDQo+IEhXIHdo
byB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gDQo+IEFkZCBD
TURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIgaXMgYWJs
ZSB0bw0KPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29ybGQuIFNv
IHRoYXQgR0NFIGNhbiBleGVjdXRlDQo+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29uZmlndXJlIEhX
IGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBUT0RPOg0KPiAxLiBTcXVhc2ggY21kcV9zZWNf
dGFza19leGVjX3dvcmsoKSBpbnRvIGNtZHFfc2VjX21ib3hfc2VuZF9kYXRhKCkuDQo+IDIuIENh
bGwgaW50byBURUUgdG8gcXVlcnkgY29va2llIGluc3RlYWQgb2YgdXNpbmcgc2hhcmVkIG1lbW9y
eSBpbg0KPiAgICBjbWRxX3NlY19nZXRfY29va2llKCkuDQo+IDMuIFJlZ2lzdGVyIHNoYXJlZCBt
ZW1vcnkgYXMgY29tbWFuZCBidWZmZXIgaW5zdGVhZCBvZiBjb3B5aW5nIG5vcm1hbA0KPiAgICBj
b21tYW5kIGJ1ZmZlciB0byBJV0Mgc2hhcmVkIG1lbW9yeS4NCj4gNC4gVXNlIFNPRlRERVAgdG8g
bWFrZSBjbWRxX3NlY19wcm9iZSBsYXRlciB0aGFuIE9QVEVFIGxvYWRlZCBhbmQgdGhlbg0KPiAg
ICBtb3ZlIGNtZHFfc2VjX3Nlc3Npb25faW5pdCBpbnRvIGNtZHFfc2VjX3Byb2JlKCkuDQo+IDUu
IFJlbW92ZSB0aW1lb3V0IGRldGVjdGlvbiBpbiBjbWRxX3NlY19zZXNzaW9uX3NlbmQoKS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArc3RhdGljIGludCBjbWRxX3NlY19pcnFfbm90
aWZ5X3N0YXJ0KHN0cnVjdCBjbWRxX3NlYyAqY21kcSkNCj4gK3sNCj4gKwlpbnQgZXJyOw0KPiAr
CWRtYV9hZGRyX3QgZG1hX2FkZHI7DQo+ICsJdTY0ICppbnN0ID0gTlVMTDsNCj4gKw0KPiArCWlm
IChjbWRxLT5ub3RpZnlfcnVuKQ0KPiArCQlyZXR1cm4gMDsNCj4gKw0KPiArCWNtZHEtPm5vdGlm
eV9jbHQuZGV2ID0gY21kcS0+cGRhdGEtPm1ib3gtPmRldjsNCj4gKwljbWRxLT5ub3RpZnlfY2x0
LnJ4X2NhbGxiYWNrID0gY21kcV9zZWNfaXJxX25vdGlmeV9jYWxsYmFjazsNCj4gKwljbWRxLT5u
b3RpZnlfY2x0LnR4X2Jsb2NrID0gZmFsc2U7DQo+ICsJY21kcS0+bm90aWZ5X2NsdC5rbm93c190
eGRvbmUgPSB0cnVlOw0KPiArCWNtZHEtPm5vdGlmeV9jaGFuID0gbWJveF9yZXF1ZXN0X2NoYW5u
ZWwoJmNtZHEtPm5vdGlmeV9jbHQsIDApOw0KDQpXaGVuIHBsYXlpbmcgc2VjdXJlIHZpZGVvLCB2
aWRlbyBkZWNvZGVyIGRyaXZlciB3b3VsZCBoYXZlIGludGVycnVwdCBib3RoIGluIG5vcm1hbCB3
b3JsZCBhbmQgc2VjdXJlIHdvcmxkIFsxXS4NCkkgZ3Vlc3MgY21kcSBkcml2ZXIgY291bGQgYWxz
byBoYXZlIGJvdGggaW50ZXJydXB0IGluIG5vcm1hbCB3b3JsZCBhbmQgc2VjdXJlIHdvcmxkLg0K
SWYgc28sIGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBjcmVhdGUgYSBjaGFubmVsIHRvIHdhaXQgU1cg
dG9rZW4uDQoNClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
bWVkaWF0ZWsvcGF0Y2gvMjAyNDA1MTYxMjIxMDIuMTYzNzktMjAteXVuZmVpLmRvbmdAbWVkaWF0
ZWsuY29tLw0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArCWlmIChJU19FUlIoY21kcS0+bm90aWZ5X2No
YW4pKSB7DQo+ICsJCWRldl9lcnIoJmNtZHEtPmRldiwgImZhaWxlZCB0byByZXF1ZXN0IGNoYW5u
ZWxcbiIpOw0KPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gKwl9DQo+ICsNCj4gKwljbWRxLT5jbHRf
cGt0LnZhX2Jhc2UgPSBremFsbG9jKFBBR0VfU0laRSwgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFj
bWRxLT5jbHRfcGt0LnZhX2Jhc2UpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJY21k
cS0+Y2x0X3BrdC5idWZfc2l6ZSA9IFBBR0VfU0laRTsNCj4gKw0KPiArCWRtYV9hZGRyID0gZG1h
X21hcF9zaW5nbGUoY21kcS0+cGRhdGEtPm1ib3gtPmRldiwgY21kcS0+Y2x0X3BrdC52YV9iYXNl
LA0KPiArCQkJCSAgY21kcS0+Y2x0X3BrdC5idWZfc2l6ZSwgRE1BX1RPX0RFVklDRSk7DQo+ICsJ
aWYgKGRtYV9tYXBwaW5nX2Vycm9yKGNtZHEtPnBkYXRhLT5tYm94LT5kZXYsIGRtYV9hZGRyKSkg
ew0KPiArCQlkZXZfZXJyKGNtZHEtPnBkYXRhLT5tYm94LT5kZXYsICJkbWEgbWFwIGZhaWxlZCwg
c2l6ZT0lbHVcbiIsIFBBR0VfU0laRSk7DQo+ICsJCWtmcmVlKGNtZHEtPmNsdF9wa3QudmFfYmFz
ZSk7DQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArCX0NCj4gKwljbWRxLT5jbHRfcGt0LnBhX2Jh
c2UgPSBkbWFfYWRkcjsNCj4gKw0KPiArCUlOSVRfV09SSygmY21kcS0+aXJxX25vdGlmeV93b3Jr
LCBjbWRxX3NlY19pcnFfbm90aWZ5X3dvcmspOw0KPiArDQo+ICsJLyogZ2VuZXJhdGUgaXJxIG5v
dGlmeSBsb29wIGNvbW1hbmQgKi8NCj4gKwlpbnN0ID0gKHU2NCAqKWNtZHEtPmNsdF9wa3QudmFf
YmFzZTsNCj4gKwkqaW5zdCA9IENNRFFfV0ZFX0NNRChjbWRxLT5wZGF0YS0+Y21kcV9ldmVudCk7
DQo+ICsJaW5zdCsrOw0KPiArCSppbnN0ID0gQ01EUV9FT0NfQ01EOw0KPiArCWluc3QrKzsNCj4g
KwkqaW5zdCA9IENNRFFfSlVNUF9DTUQoY21kcS0+Y2x0X3BrdC5wYV9iYXNlLCBjbWRxLT5wZGF0
YS0+c2hpZnQpOw0KPiArCWluc3QrKzsNCj4gKwljbWRxLT5jbHRfcGt0LmNtZF9idWZfc2l6ZSAr
PSBDTURRX0lOU1RfU0laRSAqIDM7DQo+ICsJY21kcS0+Y2x0X3BrdC5sb29wID0gdHJ1ZTsNCj4g
Kw0KPiArCWRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKGNtZHEtPnBkYXRhLT5tYm94LT5kZXYs
DQo+ICsJCQkJICAgY21kcS0+Y2x0X3BrdC5wYV9iYXNlLA0KPiArCQkJCSAgIGNtZHEtPmNsdF9w
a3QuY21kX2J1Zl9zaXplLA0KPiArCQkJCSAgIERNQV9UT19ERVZJQ0UpOw0KPiArCWVyciA9IG1i
b3hfc2VuZF9tZXNzYWdlKGNtZHEtPm5vdGlmeV9jaGFuLCAmY21kcS0+Y2x0X3BrdCk7DQo+ICsJ
bWJveF9jbGllbnRfdHhkb25lKGNtZHEtPm5vdGlmeV9jaGFuLCAwKTsNCj4gKwlpZiAoZXJyIDwg
MCkgew0KPiArCQlkZXZfZXJyKCZjbWRxLT5kZXYsICIlcyBmYWlsZWQ6JWQiLCBfX2Z1bmNfXywg
ZXJyKTsNCj4gKwkJZG1hX3VubWFwX3NpbmdsZShjbWRxLT5wZGF0YS0+bWJveC0+ZGV2LCBjbWRx
LT5jbHRfcGt0LnBhX2Jhc2UsDQo+ICsJCQkJIGNtZHEtPmNsdF9wa3QuYnVmX3NpemUsIERNQV9U
T19ERVZJQ0UpOw0KPiArCQlrZnJlZShjbWRxLT5jbHRfcGt0LnZhX2Jhc2UpOw0KPiArCQltYm94
X2ZyZWVfY2hhbm5lbChjbWRxLT5ub3RpZnlfY2hhbik7DQo+ICsNCj4gKwkJcmV0dXJuIGVycjsN
Cj4gKwl9DQo+ICsNCj4gKwljbWRxLT5ub3RpZnlfcnVuID0gdHJ1ZTsNCj4gKwlkZXZfZGJnKCZj
bWRxLT5kZXYsICIlcyBzdWNjZXNzISIsIF9fZnVuY19fKTsNCj4gKw0KPiArCXJldHVybiAwOw0K
PiArfQ0KPiArDQo=

