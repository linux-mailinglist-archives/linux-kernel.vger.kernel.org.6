Return-Path: <linux-kernel+bounces-192670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9708D2075
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2092B21F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A526171083;
	Tue, 28 May 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="giZtTrta";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ExgkvgOa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8541A13AD3E;
	Tue, 28 May 2024 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910441; cv=fail; b=aKpDMTBiAx1JxmvR7JMMHCf6aZBJg4lQkJ3nYBLtaKKRd2JletcVGysE7WNvx3oRi2FxRE7yeXFWVWisNS3ivXLbxdnZ3KZ7/Zq0hzcbgluz1Xp7RJS9aNs+fMgQ5hQlVai1sU/BSCEwXnYTw7OdbywLXXyqFULB6WHed9hIVAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910441; c=relaxed/simple;
	bh=M4sn0YXQCzlEN9QXccP5Nbie8F77zGfzPTLtIhH3CaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cX34AGuNq3BrTuVg6yIZ7sK7QijGzvQKmxQE6u3ffX65r1y2bB53zvByyAhdK+J1awyNEdJa8guWPmWUSzEklwQbKPgwZlK1K07wSBqKm2OUV7JViH2YngOdZCqC6G8szyWOGFVwaTC2oTaFe6bjU+Qgjsl/EZyQL6h4FYSve3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=giZtTrta; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ExgkvgOa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b1677a981d0711ef8c37dd7afa272265-20240528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=M4sn0YXQCzlEN9QXccP5Nbie8F77zGfzPTLtIhH3CaI=;
	b=giZtTrtaW5WDNRh9yVtZ9AYC0SzGERcIwNBswLMpM7NxF4W7mEmh/FB8eHckSyEUsxQo0VGoLWX789PvFDgBWnedcIWiDHg8CEcEcVv/Y+F2uOFSKip5B0Mv0UNuc/uRlnpS6jPRmbYS1Z9zXLjMoC/FHmsqGY0fTKWyOrTT3IA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:de55e8e5-bd2c-40a0-afb2-dc7bbf9dd4c1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:8ae85293-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b1677a981d0711ef8c37dd7afa272265-20240528
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 942714577; Tue, 28 May 2024 23:33:55 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 May 2024 08:33:53 -0700
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 May 2024 23:33:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NoCph/EKglH1P0oA3c6ZiP+Y5JNJ/cXfg6vxO3rLHCFEUstp8HP7iPyK0iSu39dMdbExUUVc/pTLTEF7Y5SjsbbVitn4F6hg5kthKKEtUxb00Uc7hWrH9de3JsAuej6C8cqjUbdQ5I6bgWVDfVvO2KQT8eh4QQy+DOe9tTyZFnCpt8KUPxze2iySD10f6FSyr2cJ0QeNzF065WQN85EmzLgG32TE0wn8QgaOxWQMB+N/haPijI64ui6MnXk170h/hLUJ81oq0hnEXYyrEJY53Mo0S+SpjK4BXiQX8uc5K8DCyhX4glO0tvfas1ACa4fm5GPNi4aRzNsFk4y7yX4Paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4sn0YXQCzlEN9QXccP5Nbie8F77zGfzPTLtIhH3CaI=;
 b=MgDFRvjO4v+gWqd4LuVbtXRDRvma14eW8FiQabTOsDfKMfYAZ+CTsZR5xpPpURbX4MO8EsHg9ZHAjzEqW5fA8kj/vwM4nZ6IbF9m9g9GXuHlWWcXXzsVgWbgLcscs/QuuOPykm/QmkWoevkTIYDeSvfD/BOq8ci1zqTWL3NrM8F/9+1bqYbFTmtk2mURQlx4jvpU2vQweWmbX3Wm6FT+3ImYiFIeINZDKmK2BGzAJFwbvbbfDBLDy+mWWONpKwlEKUQ6Ngb27lf/HsyfGp7dv4WZLG/jcHHaQYEJEbieq6Wa9bBislBswrJOyJIqlsXl2sFBylflMnwtEWlrn4vPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4sn0YXQCzlEN9QXccP5Nbie8F77zGfzPTLtIhH3CaI=;
 b=ExgkvgOaUA5ANWAoKHWt1fG3hbvmbfz9IHDnPcTrEFRxsllxxLwvvEcjQWT7VmQ4cq7v28e5E1K4K7gwj7hwHpdKm10DWoAOCcAdLxySmlRtW6Vl//2T9Wpvro9MagWulnD7y9dDjbfiYPFGWGBES8MZ+xe+0LclwOLYkrh9pT0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SG2PR03MB6455.apcprd03.prod.outlook.com (2603:1096:4:1c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 28 May
 2024 15:33:51 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 15:33:51 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
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
Thread-Index: AQHasK2NaNWXpu8mjkmDUJJrlMmih7Gsx4aA
Date: Tue, 28 May 2024 15:33:51 +0000
Message-ID: <193af9d026431f4c56819643cb696fd9798098dd.camel@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
	 <20240526144443.14345-7-jason-jh.lin@mediatek.com>
	 <647a8dff6299c8e43249cbd50c73de7a29fa0d77.camel@mediatek.com>
In-Reply-To: <647a8dff6299c8e43249cbd50c73de7a29fa0d77.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SG2PR03MB6455:EE_
x-ms-office365-filtering-correlation-id: fe455775-b6bc-43b5-9c5d-08dc7f2b93a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?WklyTFBIME9sM3lRRnByVnByQm5FRnRGQ0FrNURveXJYS3NxZ01OcVljdHZj?=
 =?utf-8?B?d3FhZVR1QmF6TW05dlIxT1JaL1ZKNTFYVTJScG80aW44UUhIS2pFb1dUcGgw?=
 =?utf-8?B?YTZrU1JacGRGNmFaelVzTFBOTjdXRTNnQTZrVEc0SjVaRVpNYVBIQm9BNnZU?=
 =?utf-8?B?U0tpN3RXUCtPRHArbkpEM3JwemI3WkVjUUVzRG9YVnRWMjlaTmdOQ2pFM0d2?=
 =?utf-8?B?ZDNyV0l3Zjh2SEo3VVhxakZsS1Z6WGxEL3ZiRVFEdys4Z2E2TnBsYVN3V2VU?=
 =?utf-8?B?MGxnYVNqZkw5TlE2WXR6OWJTalE1b3ZWOGk2Qm9mZXRESjIxQzFQeE9DZVU4?=
 =?utf-8?B?WUdmMGhxRWY1KzlqejBQb2R3d1JCN0ErSkJpVVFDTTA0RkZNYXZlcUhPNEhu?=
 =?utf-8?B?Zi9qaW5hMVZkcTJLVnh4azFiZWdySjJ0c3ByWlY4SG1TM0syT0VzbmdQOFIr?=
 =?utf-8?B?STc5Vk9MM3RXQkRMUk5UZjd3cC9GVnRCR01vOGlaSzhaTGtFSjFqclZrbWtT?=
 =?utf-8?B?ZDhGVUlMa2FOMUMwQW1NYmZIVmZlMWJCcWdSUEUvYmdOM2lXbGN4TjdrOG1z?=
 =?utf-8?B?Qzh3NlYwTVdrQ0lZWGE1VUJ6cldwT2lPaTVsRHlMSStpbVBaZWRCRnd3U213?=
 =?utf-8?B?NmtRVXBxZW9JcGtjRm4xQnp1TnNBN0dJaU5leFNkUjRBekI3NTBDbVl5K3BO?=
 =?utf-8?B?eTZCNzRlU2tkZFhwZGc4ajcrL3NiVFBJS3pTQTNYSnpJaVZlMGZxd3FKcS9L?=
 =?utf-8?B?MXVjQ1lpd3dxcE5KNzVqb3RTeEpXdUVISTR1WmNQZVBaQTZUWmVIYnQ5VHNO?=
 =?utf-8?B?NEQzWUhrUGl6cy9mRUlRajFjOFMvR1NiUC8xNyttclNXRVJpdmo3Um1XMWZv?=
 =?utf-8?B?eXF6RXloU3dEN1BUeThxQWtPMHJ6YVAza1B1ZmVaOGlwbkN5STdxaDZvN3lK?=
 =?utf-8?B?QW4ybDB0NVJRM2d6bzRJRXlnaDdWUjQxOXJxUWhQVXZodDNsZy83c0U1K3pQ?=
 =?utf-8?B?RlpDcGp1Mk9OdFh1SmtyTEtLb004VGZ6cHVTMitsMVdsb2VaQnBub01lUmdn?=
 =?utf-8?B?Y3VDM1FFVHhCVmU0eTMwd3J0NXNHQStBUHRYQmlnVnRRNkd6QmZkd0p0L1Rs?=
 =?utf-8?B?WjNzdkx2WlpxRk1oVkc1M3hoR1VuVWpULzhiMXVLSUNra2dnVHBUVHpqaTJY?=
 =?utf-8?B?TGdHeU1TeXZpUDgyelZ1Wi9VMkNQTGlMQzZUSVZORWRQMHNXS1QxWlVhK0RL?=
 =?utf-8?B?eWx6L3IwZzhpSlRVZWdLWERFS0YwREpON09hQnhmV0JGSU16VllDOFNnOG9n?=
 =?utf-8?B?L25aWTFCREt0RCtZOGdXSFZ4aHczeG9xQVgwMkRUM0c5NGROM3ZnNm1EWWY1?=
 =?utf-8?B?ZGFjbXg2c3lpU0UyY2MwU0hCcWt4ekRZT0lBWmZtM0pHWDNqaFJobmJ6RHhp?=
 =?utf-8?B?aUk1dk9aY3ZPT0drMzZtN1g2KytoWE9yZ3ZhS0JzMldPMHlZakNDdmw2cS9C?=
 =?utf-8?B?N21wY1B5dzBBV0lidjFKcVUxa2Zlc3JQRXlsbmpHS0Y5T09Hb2dxQWlzN2Zn?=
 =?utf-8?B?dDF5aUF2bjRLcHpTZVFNVUFnL2R0clhTSWpsd2Nkd2xIOTQ0MW9hUlJqZld1?=
 =?utf-8?B?MVo3NFRBME1BUDJXMUxrbFEyZXpXWWtBcXR2dGlQUkJmZFlsSmdYa09jOWVx?=
 =?utf-8?B?aEhLam5zRWtVajZQZVFxOFNWUjQ0VjdrUjJmNnVZNldZb1kzVzVSd3d2OUJz?=
 =?utf-8?B?U2NjcEZEK0szSEV6dDBIUStWOXNzdjlhSkhJdGg0amVMWnhFR2loTXBPTlU5?=
 =?utf-8?B?bTh1dW44V3BNSEhxMFg4dz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFlJM05vZG0xb2kxb1NDbzAyRDdSbmp5MnRpQmhRbUd2WnNtcEdFRjFramph?=
 =?utf-8?B?Z3Qza2trNjZrbFVYdmJiaUk3TXB2WlJyOWI2Mll5MTJmWGtHcnZEUXpRMjdE?=
 =?utf-8?B?THY5dFpqck1GNFh1ZWJJSVBJdVZKeWtIeG9DaG4vSEQ4T00yd1B6K0UzN2Nt?=
 =?utf-8?B?K2dnMEVscWVBUnk3V1dzK0NuYnAwVzlSSnQxcE9pdi9vNzRwOGg2WWQ3NEhh?=
 =?utf-8?B?U1VCRkJ4YXZlTklLUWUyQ3RqK0xlNlJEVlpEWDlkNXlrWjUwZS83VVJXN3FQ?=
 =?utf-8?B?MytncFRSUmJSUjlxNHlsaXQxd0tZdXhFT2doMkJGZ1NOWlZLRllFRkFrcHhy?=
 =?utf-8?B?L1g4bkVYa0hSTFN0MndDZWIwZ3c1dnNubk85OE5RaUFDdHlmQnJKMkFuQkpa?=
 =?utf-8?B?NHlHd2l1SEN1ZFJxWjhoclZIenBOcC9sTmJrME5JTkprWWpNZ2VIZEZyU1VG?=
 =?utf-8?B?NW5KczQ0VGZWaUJOUUh4UlJqUTNxYkhwZWdrbnlqblRUSUFOcHVaWm15M01t?=
 =?utf-8?B?V01XZTIvdjc3dkFEVGFtdGZEd0VGY1o4WkJ1YmhTR1dEUENIc05EcFVVKzJS?=
 =?utf-8?B?dndjMTBsVnQxZndJNHpmelRBMkpnOS9uQXduZm1zUlpZQXdjeXdZWklkWnJo?=
 =?utf-8?B?N1R5ZEtXMW83WVFZUVVHS1h0OVVtWEQvRW16eXNhUWhaM1ZsNlNsMVpLNm1S?=
 =?utf-8?B?THhOUERmaWtiNEFzMDZyNFg5cEpodXFQVTR5aWl6aVlKNkhpaVJaMHhYd2tx?=
 =?utf-8?B?a1kzLy9HS2hNdXhJKzJqdjR3V1IybStvMDQwTzVocFZZTWJYMnZSWktISnli?=
 =?utf-8?B?TkExRUNtYTBwTGtzMXdKWXh3NVlpRE9kMVV0cFdQT0xyNElmVDEzbWhoZFl0?=
 =?utf-8?B?aHN2a1V1bCs2SUh0dWdwbG02cTNZRVltT3p4N2VabFNWQVJZUVRGcDhIeGdV?=
 =?utf-8?B?dGhrUnRHQ2J6dUU1TzNlbVZETkJrOTY1RnZ2ZjFJZ3lBVGxjYld4NC9SMUtm?=
 =?utf-8?B?UDFPM0ZNK3p1R3BvSlBvZkVhbTRjVW1OMXRDSXd5TFhyVG5CckFKZVBxeXAy?=
 =?utf-8?B?YnlacjlndGYyZTduek5wZW9uODFDMGJCMTVtOTBza3YycFJucVE5eENVRUZm?=
 =?utf-8?B?M1BKOVdKWnZDczNQL2VzaDZCdWxhTjZZWEtWWFd6UXdXL1BnR3RVL2piNFR2?=
 =?utf-8?B?bkVYeEpISWJIa3R5citKcE1Da0M2cVEzM3hLUzhTK3B5bGpSeUJYUkpEUUJ0?=
 =?utf-8?B?NGtMRUEySWxFV1JnNGxDNzhoQ2dWTyszaTdENnFUVGh2Uk5STndiQmRoeEFJ?=
 =?utf-8?B?NGxFYi9HTXFqQ1dqcHZycUZCSFpueUhuWHVEN05zaUdwVVdObXAzdnZabitH?=
 =?utf-8?B?b3pZRExKelk0V3o1emZiWDc2ZEZZQndiVmE4ZGRVMFVRMmRIa3ViUHVXSFI2?=
 =?utf-8?B?dVBpeTBTRTNlbWk1empJRENMR0o1MVFMdmhMbS8zQVcvR3QwdVVwMmtvaHFK?=
 =?utf-8?B?RXpRQU92TU1aendmbEw1d2VsQ1RHSjlvbVhFL3l1SnFneFZtOEdxb1dkdXFG?=
 =?utf-8?B?KzlJOW9KcEtIZmdia0Y0Rzk4NnZIOGJGSFppNWlNd2o0d1d5NlVvR2NGenAw?=
 =?utf-8?B?Nkpsem4vTHRxVEZla0NmY1l5eHh6RCs0RzFuVU8ybkhBd3RmM0NzTTFDMkNF?=
 =?utf-8?B?SEdhSG5LSzA1WEdKc3hxU1FEVGo3OEphMkRSc0ZGL2wzOWlIWFFGRWNUWVk0?=
 =?utf-8?B?d1ZaZ2FWeGMza1pUWnl1bkhqM25RVVllcmJPV3ZhZCt0VzJpbzQ2U1ZqMFF4?=
 =?utf-8?B?SFFSWHhnV3c5clB5MXpOUTUvRGlrR1JyRXVqaXFUeDVYNWcwcC9oK2Z0LzZo?=
 =?utf-8?B?bjF6T3NnRlN4VG54QVA3REhPNkxNUmxzbVpEeXlhNWxSU2I1bjd3ekt2Vkp6?=
 =?utf-8?B?WlQybVcvdnVjdFpZNE0rSWpYcWZ1QkxrdS9qUnVlYXN0cmNhemhueGljSXdv?=
 =?utf-8?B?bGFjaTVTOXlHUlRJcVc4aW41RTNDQVNMbU9WZnU5bUw5Y1hvT2VwTzZlU3pB?=
 =?utf-8?B?U2l3b0FuZkpEWC9yT1JzNWpHeEJkck1wZGNBbXExOEc3RWVBR0VqaVh1NU53?=
 =?utf-8?B?NWtYRHhGcEorK3NkQkhCUWNCZUJlZU00YkpGdEd6NUZWYm1VQ1FZMm9TZE1P?=
 =?utf-8?B?MUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF4C31C23425354594F6D856AC827C1C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe455775-b6bc-43b5-9c5d-08dc7f2b93a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 15:33:51.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Paz4QBm5Ct16XHu9yXibvnrJYXQAS0C5+hX0w0eukuVvS1/SiUaDcQGoQM4AdFHh1lP68qBPexvb7Eby8FUcQo9fiDaihVC22xIy3MB65RM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6455

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyNC0wNS0yOCBhdCAwMzoxNyArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4gDQo+IE9uIFN1biwgMjAyNC0wNS0yNiBhdCAy
Mjo0NCArMDgwMCwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZp
ZGVvIHBhdGggZmVhdHVyZSwgR0NFIGhhdmUgdG8gcmVhZC93cml0ZQ0KPiA+IHJlZ2lzdGdlcnMN
Cj4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ugd2lsbCBlbmFibGUgdGhlIHNlY3VyZSBhY2Nl
c3MgcGVybWlzc2lvbg0KPiA+IHRvIHRoZQ0KPiA+IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhl
IHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gPiANCj4gPiBBZGQgQ01EUSBzZWN1cmUgbWFpbGJv
eCBkcml2ZXIgdG8gbWFrZSBDTURRIGNsaWVudCB1c2VyIGlzIGFibGUgdG8NCj4gPiBzZW5kaW5n
IHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29ybGQuIFNvIHRoYXQgR0NFIGNhbg0K
PiA+IGV4ZWN1dGUNCj4gPiBhbGwgaW5zdHJ1Y3Rpb25zIHRvIGNvbmZpZ3VyZSBIVyBpbiB0aGUg
c2VjdXJlIHdvcmxkLg0KPiA+IA0KPiA+IFRPRE86DQo+ID4gMS4gU3F1YXNoIGNtZHFfc2VjX3Rh
c2tfZXhlY193b3JrKCkgaW50byBjbWRxX3NlY19tYm94X3NlbmRfZGF0YSgpLg0KPiA+IDIuIENh
bGwgaW50byBURUUgdG8gcXVlcnkgY29va2llIGluc3RlYWQgb2YgdXNpbmcgc2hhcmVkIG1lbW9y
eSBpbg0KPiA+ICAgIGNtZHFfc2VjX2dldF9jb29raWUoKS4NCj4gPiAzLiBSZWdpc3RlciBzaGFy
ZWQgbWVtb3J5IGFzIGNvbW1hbmQgYnVmZmVyIGluc3RlYWQgb2YgY29weWluZw0KPiA+IG5vcm1h
bA0KPiA+ICAgIGNvbW1hbmQgYnVmZmVyIHRvIElXQyBzaGFyZWQgbWVtb3J5Lg0KPiA+IDQuIFVz
ZSBTT0ZUREVQIHRvIG1ha2UgY21kcV9zZWNfcHJvYmUgbGF0ZXIgdGhhbiBPUFRFRSBsb2FkZWQg
YW5kDQo+ID4gdGhlbg0KPiA+ICAgIG1vdmUgY21kcV9zZWNfc2Vzc2lvbl9pbml0IGludG8gY21k
cV9zZWNfcHJvYmUoKS4NCj4gPiA1LiBSZW1vdmUgdGltZW91dCBkZXRlY3Rpb24gaW4gY21kcV9z
ZWNfc2Vzc2lvbl9zZW5kKCkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGlu
IDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENo
aWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiANCj4gW3NuaXBd
DQo+IA0KPiA+ICsvKioNCj4gPiArICogc3RydWN0IHJlYWRiYWNrX2VuZ2luZSAtIHJlYWRiYWNr
IGVuZ2luZSBwYXJhbWV0ZXJzLg0KPiA+ICsgKiBAZW5naW5lOiBIVyBlbmdpbmUgZmxhZyBmb3Ig
cmVhZGJhY2suDQo+ID4gKyAqIEBzdGFydDogc3RhcnQgYWRkcmVzcyBwYSBvZiByZWFkYmFjayBi
dWZmZXIuDQo+ID4gKyAqIEBjb3VudDogdTMyIHNpemUgY291bnQgb2YgcmVhZGJhY2sgYnVmZmVy
Lg0KPiA+ICsgKiBAcGFyYW06IG90aGVyIHBhcmFtZXRlcnMgbmVlZCBpbiBzZWN1cmUgd29ybGQu
DQo+ID4gKyAqLw0KPiA+ICtzdHJ1Y3QgcmVhZGJhY2tfZW5naW5lIHsNCj4gPiArCXUzMiBlbmdp
bmU7DQo+ID4gKwl1MzIgc3RhcnQ7DQo+ID4gKwl1MzIgY291bnQ7DQo+ID4gKwl1MzIgcGFyYW07
DQo+ID4gK307DQo+IA0KPiBVc2VsZXNzLCBzbyBkcm9wIGl0Lg0KPiANCk9LLCBJJ2xsIGRyb3Ag
dGhpcy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+IFJlZ2FyZHMsDQo+IENLDQo=

