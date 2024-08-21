Return-Path: <linux-kernel+bounces-294781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC56959279
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 03:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23E821F24ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4E1509AB;
	Wed, 21 Aug 2024 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IOqml6g5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Hfr4cZje"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBB8120C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205269; cv=fail; b=N/GrGsLfJ1r6i62YuKJ56XO1A/DNZfz/5covtKeHQVwzHCcIyKI/q7h5ym4WBMQOjxxOLAG8YFiG2fPHLd/qNwocY+/+cUzdV9xs/qJPSrvUZUUiaJN3yJp3Pxv/SXHchc/9PwwYXhik9EvLbWaEX9CIxRgh7L52xKagSw5Sn5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205269; c=relaxed/simple;
	bh=VaSx+3MkQRK18itQNpDm2KKhHLb1JyXHxZRjkMvb8fQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=np3YyzwnUztpPs1SScL+zrlic2zGCrR8iuc6uXwrlC9UwRsUDDqoXuxldC2cfc7pSXsGy8nGxSrXDNy6ecAOPppkrWxXdGe1cH2kgiUNZ74ldo5Tl0hN2SxHD6sRi+aV9PhZzb/L41BFt4+jk515iGUjR4x8JbAYc28UIcebDlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IOqml6g5; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Hfr4cZje; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 467683fa5f6011ef8593d301e5c8a9c0-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VaSx+3MkQRK18itQNpDm2KKhHLb1JyXHxZRjkMvb8fQ=;
	b=IOqml6g5ueeWXAwlEIy7ZHfYtVJO9MzwS18ckBXTulLTnFPjQkqJXGpKs+iENbILcPqam2gQJYue4pmglElNIeLJijIm7k0Md41iDrPWoA1l5gCJ8FDZW/SSLpQMSFT4Gy6cqRH29Fn0k8mEEHZDsajLoslm5cF8cAqYN6J7TjI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:160f5f01-5254-42d1-b832-bf8dfc55b490,IP:0,U
	RL:0,TC:0,Content:1,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:6dc6a47,CLOUDID:e04bebce-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4|-5,EDM:-3,IP:ni
	l,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 467683fa5f6011ef8593d301e5c8a9c0-20240821
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 266578228; Wed, 21 Aug 2024 09:54:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 09:54:16 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 09:54:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIRcSwxnwyY88M/6Zy4v4X9EO0mzpBtRwxIRcdM+L29TqirnlNaLlZElnWCm9jgNuCU+rG9yViUoKhfgGwfvO1wDJDixu59GdYP4GCLYOj3QEn2FaWQp+CurpUQIHdChGyqFXwa2SeSWZ/u41El4ZzT1AFWabq/QaTqIkgh8uQMq56Hky2njdOq9YQTGJZ/nJBi3J0frjYn4gzuDFM/LM7Bbe992QN9U6VvEkwcbG6lqJYS+jVVnmRomB1gje3GnxX2E3ZlM4NT7sEG8UKsGuOE/a7mEpbhqUQfBGcGe5uEUNzEvUJ59OiqVIs7M7gHptXhOcKa9WYmuc4s83vrU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaSx+3MkQRK18itQNpDm2KKhHLb1JyXHxZRjkMvb8fQ=;
 b=GStd24vO3xFIBKmrMLWMLdWTq+PzMWGr9MwKUxnJW7Fh+Xs3QTgVntSFyhoVL1ydCM1ndQoNc7zg2GTIyBwTnUFQcCaHXELG8rIefrhBpWNLKD3tiu1luvdOSo/IeLnBW+2QKfwAufbWBcx87DaX/yexCEvG4GbL97gEXwG3/DQt63betmYsD49GFsmMvpznFaWmTr/NxO52Mc2PXCfnrizIwubgI6SWEFskVjtY8yjpJRC/vH9ZRTM90XgQxfS7ms5g56Zdkyk2yJSzKegHKD/Xx8S7AIXq0RP6LWvIQkRP2mRd3Xccqg76uMHgi9qyF71iyuDc3n1KoH1L7WCbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaSx+3MkQRK18itQNpDm2KKhHLb1JyXHxZRjkMvb8fQ=;
 b=Hfr4cZjebpzD7QL5KImzVlo/Rfhfsr3z9jn+jbtpRpvoXPwRmKOUeOj1AYQXdFgyXG5MgDsy7vD7rrpf0bC8+ILvja8B52rkxWprpD6jW6Ovrti8FSHDrCKhdL346O9lmmB0ID0bH9JK33KWODuNk/U+em7o+4KWINELE4bO3Jg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6692.apcprd03.prod.outlook.com (2603:1096:101:7f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Wed, 21 Aug
 2024 01:54:13 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 01:54:13 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drm: mediatek: Drop unnecessary check for property
 presence
Thread-Topic: [PATCH] drm: mediatek: Drop unnecessary check for property
 presence
Thread-Index: AQHa44ZcdW1BSkZug06AXSDYtJYczLIxEv6A
Date: Wed, 21 Aug 2024 01:54:13 +0000
Message-ID: <f138b86dd8a19951a577687edada04ce3831c401.camel@mediatek.com>
References: <20240731201407.1838385-1-robh@kernel.org>
In-Reply-To: <20240731201407.1838385-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6692:EE_
x-ms-office365-filtering-correlation-id: 25891242-1b95-46ba-5ba4-08dcc184287c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z2dTdHRqa1phVUtjOC9aNFg5SllVV1F5TjMzYVhEekdCQ3dIcS9uem8xclpE?=
 =?utf-8?B?SkZ4RUVkeWMxYXZTRXY0aHRJSStvRllkeEVJSWRNQXVJdjExa0gxVDZiQ1lj?=
 =?utf-8?B?N29pMjFDTG16dURZalQvd2l0U0FuVDlIajVkOTRLMDFuMzhNTkkyaUd3QkNa?=
 =?utf-8?B?K3J2cVlNWEZwTmdTMEJtelc2V0RJdzIvRU0xaWQwU2oyV2NIRFgzTUJoaWhH?=
 =?utf-8?B?WHkzcEo5OSs0cG15Q1R2OTl4TmwwTWx4cSs5cWFkcmd5dTF2dUcra2Fib2k5?=
 =?utf-8?B?cktZMTZqUElUQXJ3UVlSNnJ4WERFaldLaTdOclBvT3pmdXFOdmhGS3c5dlhu?=
 =?utf-8?B?RmxWU1ZDYlBqajVSeDJqcXlPdWJ1bTkzUTdMLy9jVU5ZV0MyU3dDQ1M1bHo4?=
 =?utf-8?B?UHU0bEF0NGx4ZnFqclEyMHoyZnJYalJkOVJKa3Q1V0w0K0xhMGMxTlNzbitO?=
 =?utf-8?B?Qy9ZQUxzWEsyZkcyZ21UTkJRcVlGTjhLcU1tUGZXbmVkejlwNnk4VXNNOEh3?=
 =?utf-8?B?SWVBV0FsSTJ0aXpiVFovWEx2c2dTZC9IY1M4QjBRWlQreUFjcFIzZHZqbEk1?=
 =?utf-8?B?M1ZiSWdycGVrazV5U2lyM2dma1lWcUR5Tm9lWS9yaEcyM2FLRk80Qm1UNXdK?=
 =?utf-8?B?SSt2clhISmV6akhiNytvZnljbGxyK2tibSs2UEtDaFdQdjJGQ2FVRXJtNkRw?=
 =?utf-8?B?RjZuUU5obmE4L290QTljSE9EeHB4dWRaVy91UUFUaHhndlU3RWpBRnFQalVj?=
 =?utf-8?B?VjdyVnRlQmZiejFaTzltK3pPblIyRVY0THJOZTl3TzNkamNyN0o3MkR1Ymw0?=
 =?utf-8?B?SmhHQmxDOG1melU3eUhBWjNHZVBPWVlnZjI3REEvb0dmVDUxMmxBNFJIOEd6?=
 =?utf-8?B?SUZlY3RTeUFIWURtaDVlcUsyNUxsOXVqcU95czBEYVZTNDdLWnF0dDhxejgy?=
 =?utf-8?B?Uk5KMkpGczE3MTZheVZ4SjJRMERmUUJQYkVJMkVYaElzK1JEK2F6MjQ3Q1Uw?=
 =?utf-8?B?elRBRDFVNWdJMklVNWVoOGd0RGF0eXd0VTJId0M3aFdrd2gyTGp0YUxDT3hr?=
 =?utf-8?B?eGtEOUNSV1laTGZZMXBhamR5T2JLTDhMNjJTREVSZWpvbFljQS9KOG1kVm9I?=
 =?utf-8?B?ay9YeFRVVVFtSWFyNXpiMzUwM21QcHBUUzdQUXRHdHpiNjlLQjV6VWMzNlVS?=
 =?utf-8?B?L3hiRmhQbjd1c0RwZXNhMFNRd3ZDWXQ2RWw4TEhWYWc4V1hDV3RBOVZaN0ww?=
 =?utf-8?B?R0JuUStoMDRGVjFKczhpTkNxNU9pY0IwSUhUbFpiZUo2WXJ3QnlrV0FmYk5a?=
 =?utf-8?B?eDJscmpKOVhoaWV2c2FEenRCRXpSSi9yUklxeTRDKy9WbXdLM3BGZW0zQU5Q?=
 =?utf-8?B?TGZpcGxqa29BbVErYU0wWUo4TjR4b21iTTIzSUszaktBTmEwTkN3aUVqdkc4?=
 =?utf-8?B?RHU0eFllQ3AvZ1lLY3gzTFRUK0NYS2hmTXprSFFSOXF6WTBuYXZIUkZsYnFp?=
 =?utf-8?B?ckRxVzZoL0ZDcFArOEdzNGtGdHR0bGlldHJNRDdaeDhlcmlCL3grZ1RZQVZL?=
 =?utf-8?B?c0wyUSt0cFpJT09BZmZ6T1B6OW1DODF2UURGcllyc0tWMG1oZWNCZElxSkZN?=
 =?utf-8?B?YzNtUzRHaHRkcHFFcDhEbFlGS0hHZldManRXZ0F2Z0ttNURUaW11RlErUFlo?=
 =?utf-8?B?Z21Mc01Fc3VHd1k2WEJWbTR4ZHZ2bXFIaUJ0Sllkd2FhdzU5RlJ6eDkwVUJj?=
 =?utf-8?B?eGN1K2Z6bnpNcTh4aUVrNkdwczFjOVMrak5ZUlVvWDRaZXNFTUt4QjR0RElv?=
 =?utf-8?B?dkVPejlSS0wyaTFIZksvQ0JnQUhreGRVYkhPWXQvRlo1Z1BtL2JoOVJ1aFRh?=
 =?utf-8?B?eG9ESmxBWkpCdVdtZnB6d01Rb3poa29UNmgyS0JsSUpNK0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVRGWlJ3WXhRWGZyc0dac05ZVDhoUGZZWFdzQjNkTTQ2b05tZmp6YSt4aE9k?=
 =?utf-8?B?ejJqZDJwNzBnZy9pZTRWOHJIdjBNcjZPd3A0TkFIa215RENRVFpDM3lYd1dW?=
 =?utf-8?B?dDEzRmdXdWFiZWYvZzVBTEYrY3c0Z3c3R3ZOdEhFRlllQWs4MHNzdWw0NWd6?=
 =?utf-8?B?UDBiRkJRUThSMTVtUWNSSnNZZHFNV3V1OXY4UTdYQk5iT25HbGlZa2FqRExR?=
 =?utf-8?B?VEV2WXFvQnJtT1NMS2Q0VkRHNy9hNzhrR2VPYkV3VjNrbk1xQWZ6NDJKRVQ0?=
 =?utf-8?B?a0pmejkrNFk2V0E2VnpwMlRyZWRNREFqK0dZTnBSbXl3cFQzZWxaWDVDNG1C?=
 =?utf-8?B?VUZuVFY0RVl1R2l0Y0l5cVBKeUJVUG9oelNRY0tNV1o5ZGVCVGtDeHRwZ0s2?=
 =?utf-8?B?WktuaGd3eVJjQ3p6QTlGdFlnNlJwdkFCVjErL2xEWVdKeW5nNW4xRU5CZlVi?=
 =?utf-8?B?UU1qUGJrNnl2YXJCWUJYTTRNTStXRW9CM1NtS2N6MWgxSmVFTDMrbVlycnBk?=
 =?utf-8?B?dUtJQnpheDRnTGlzS3MxUEYrazZsSVZVUWFTa1RBT25rZWkzajlMclJJYVZu?=
 =?utf-8?B?UnNWMU81YlBWUGdzVm9MRWJDaTV0Z3NQdzhDZ001TzZCUE9HZzN6eFplVFls?=
 =?utf-8?B?T3E2V3pFV010aHgwcVJTRnVWWGZrdmp3d1lkSHpFcitDRjFBTU84UnZ1SExs?=
 =?utf-8?B?cElyaDZXS1RNOHB0aG4ycXcyVk0vTitXUld1TzJYK2lDZjh2T2Z3VXRMdXYz?=
 =?utf-8?B?cTBsVDgycng2OXNpcUN1VkdHRDhUQ3BjSldKSHpQMHZZeTRiWkNGNHp6TlBk?=
 =?utf-8?B?eHdYNituNmhQd2xrdElDODlEVDJxcTJLeG9uenBhY3duM2ZRREFhUno5SE1F?=
 =?utf-8?B?MnhyaEplUldaYllKOUF4ZDBPeUh0cHlLL1BFSVBwOGdTYUcvbElkNW9OR0RH?=
 =?utf-8?B?ckFnZmxrVXJkL2w1aWR1NVpJNStqYUtwM0NrR2EwUkxkMG9rNUVpaUJUYlJ2?=
 =?utf-8?B?SW8xTUU1WEpDZ0Q1UE94ZStmSUNoNXM3Z1Q1SmRqMG1FeVhkMXRsSW8yL01G?=
 =?utf-8?B?VlRpaEwwa1RtRlJ6NVExckhHRWlydStxZHZucjVYMDdpeG50dWY4YzI1Ykxj?=
 =?utf-8?B?VVlyMW1POXVuYjJBSTJ1NEd6bE9vQS9leEUvVzJqc0wveXgreXlvNmhMZUQx?=
 =?utf-8?B?dmorNnI2dFU2Zmt3cTM3R0xIdThjbHNwTmRRNHJUSFBSN0VyVVF4N3RRUzI1?=
 =?utf-8?B?Ry9aQkNhQTV1bktyK3ovMlV0N3ZoVytaN0NBbEpvV2tyczh0Yk9hT0Q3Sjhv?=
 =?utf-8?B?RVprY2EyTGJzd21UU0lnVEw2MisyakNxc0dUQThtcG40RDVqZ0JEaUtVYktL?=
 =?utf-8?B?NSt1M0RTSmI1enJWNU1ld3BUQzN1MzBSakhWaXlZWW40bUJIVFFrd1lCeEk3?=
 =?utf-8?B?cGcrVVQzVlVXTkVrd0ZINEVSUFhUMm82VTN2WUFQc0IzMWJQN0RHT2N1TGJ1?=
 =?utf-8?B?NGdOYWpkUEk5eTdKb2pHQThUdHZQOHRxb2JSaGEzYUUvL3QraWdGQUc0dERO?=
 =?utf-8?B?bWRmTlpsZDNKUEVHdmVCMDNXcFdENitYNHN1ZzNvRXJCZEVmdVQ1ODJtOHo2?=
 =?utf-8?B?TGJRK0V4YnduRUsydUh0SWk4c21NWUwzZGl5eHprNFdOWGM2b0Zlby9ndUJ5?=
 =?utf-8?B?UmR3Qk9oeExWOVZML2VMbmRiNDRISGhVMG5WdGxTRnVjTlZub293S2xLdSt1?=
 =?utf-8?B?bXlTOXpwcjBMWFNPUTFyS1JSKzhSUTE1R0s3VHpEekVRMTBXNU5ybWtVOHlz?=
 =?utf-8?B?RlZRV1Y2dU1rUkt3MWFjRG1obFFYVUhlSVpOU1VqSWxla1gzQm9qbm9xSU94?=
 =?utf-8?B?UFAvNnQ4R3dVUFlDWG5VajJMMlVWVHplUTYvajJGVGYrNXBzVWtoZWhEQUt6?=
 =?utf-8?B?MEJWZ0hrZ1RqWHFoeDNLazRUdnV2aUJ0emdaS3djTFkyTEFtT0EyejI5L2d5?=
 =?utf-8?B?YkJObzJtd2UyYVVYb1AxZWZ2MkZYaGpRSGV3R1ZzSzhRc2pxb255ODExV1py?=
 =?utf-8?B?d1FiRVE5RTlCdTlJOWdGUGVrRjBUZ1dDSk45anFLc1AwYlYxNWNyNHRrcTRZ?=
 =?utf-8?Q?Bpa48wFqfCPZ9YOb17KWl9Ria?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75B1AEFC758C89469D1D87BFD2BF8BEA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25891242-1b95-46ba-5ba4-08dcc184287c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 01:54:13.8241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DwwPHc0eEY+8msbZFascMSEvV1DUNHglGCgln65LJ1Qwhc5JYBmCnR8fV0CjL5pkpDdDl+1QEg3Zr/vrK8LTaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6692
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.392500-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/sOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0rYsa0mvjzncCmtc/OzWlGj2hiplvBb6/sxXH/dlhvLvyoWOA6kYlc5H+l
	ndt9+6eHHIiXypGH+EAAohXD9NpAiAM0/G7XUdePil2r2x2PwtQrefVId6fzVFLXUWU5hGiFGrI
	LfHhGdpHG20Tv/CjUCgAYZl0IbohhC/bXMk2XQLIMbH85DUZXyseWplitmp0j6C0ePs7A07fyjt
	izU0rhjFWmRHdZOrTTEU2LNI8qBzdUYIeOQd9cUir7UXA9RIys=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.392500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	627A995D8C6313C773A4ADB9B8FE40C6046EDD06F6A3B512E7FFED8DCB2081442000:8

SGksIFJvYjoNCg0KT24gV2VkLCAyMDI0LTA3LTMxIGF0IDE0OjEzIC0wNjAwLCBSb2IgSGVycmlu
ZyAoQXJtKSB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsIHlvdSBoYXZlIHZlcmlmaWVkIHRo
ZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBvZl9wcm9wZXJ0eV9yZWFkX3UzMigpIHJldHVy
bnMgLUVJTlZBTCBpZiBhIHByb3BlcnR5IGlzIG5vdCBwcmVzZW50LCBzbw0KPiB0aGUgcHJlY2Vl
ZGluZyBjaGVjayBmb3IgcHJlc2VuY2Ugd2l0aCBvZl9maW5kX3Byb3BlcnR5KCkgY2FuIGJlDQo+
IGRyb3BwZWQuIFJlYWxseSwgd2hhdCB0aGUgZXJybm8gaXMgc2hvdWxkbid0IG1hdHRlci4gRWl0
aGVyIHRoZSBwcm9wZXJ0eQ0KPiBjYW4gYmUgcmVhZCBhbmQgdXNlZCBvciBpdCBjYW4ndCBhbmQg
aXMgaWdub3JlZC4NCj4gDQo+IFRoaXMgaXMgcGFydCBvZiBhIGxhcmdlciBlZmZvcnQgdG8gcmVt
b3ZlIGNhbGxlcnMgb2Ygb2ZfZmluZF9wcm9wZXJ0eSgpDQo+IGFuZCBzaW1pbGFyIGZ1bmN0aW9u
cy4gb2ZfZmluZF9wcm9wZXJ0eSgpIGxlYWtzIHRoZSBEVCBzdHJ1Y3QgcHJvcGVydHkNCj4gYW5k
IGRhdGEgcG9pbnRlcnMgd2hpY2ggaXMgYSBwcm9ibGVtIGZvciBkeW5hbWljYWxseSBhbGxvY2F0
ZWQgbm9kZXMNCj4gd2hpY2ggbWF5IGJlIGZyZWVkLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNr
Lmh1QG1lZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJpbmcgKEFy
bSkgPHJvYmhAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfcmRtYS5jIHwgMTMgKysrKystLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUg
aW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX3JkbWEuYw0KPiBpbmRleCA2MzRiYmJhNWQ0M2YuLjA3MjQzZjM3MjI2MCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0K
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+IEBAIC0z
NDEsMTQgKzM0MSwxMSBAQCBzdGF0aWMgaW50IG10a19kaXNwX3JkbWFfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJZGV2X2RiZyhkZXYsICJnZXQgbWVkaWF0ZWssZ2Nl
LWNsaWVudC1yZWcgZmFpbCFcbiIpOw0KPiAgI2VuZGlmDQo+ICANCj4gLQlpZiAob2ZfZmluZF9w
cm9wZXJ0eShkZXYtPm9mX25vZGUsICJtZWRpYXRlayxyZG1hLWZpZm8tc2l6ZSIsICZyZXQpKSB7
DQo+IC0JCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwNCj4gLQkJCQkJ
ICAgIm1lZGlhdGVrLHJkbWEtZmlmby1zaXplIiwNCj4gLQkJCQkJICAgJnByaXYtPmZpZm9fc2l6
ZSk7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIHJldCwN
Cj4gLQkJCQkJICAgICAiRmFpbGVkIHRvIGdldCByZG1hIGZpZm8gc2l6ZVxuIik7DQo+IC0JfQ0K
PiArCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwNCj4gKwkJCQkgICAi
bWVkaWF0ZWsscmRtYS1maWZvLXNpemUiLA0KPiArCQkJCSAgICZwcml2LT5maWZvX3NpemUpOw0K
PiArCWlmIChyZXQgJiYgKHJldCAhPSAtRUlOVkFMKSkNCj4gKwkJcmV0dXJuIGRldl9lcnJfcHJv
YmUoZGV2LCByZXQsICJGYWlsZWQgdG8gZ2V0IHJkbWEgZmlmbyBzaXplXG4iKTsNCj4gIA0KPiAg
CS8qIERpc2FibGUgYW5kIGNsZWFyIHBlbmRpbmcgaW50ZXJydXB0cyAqLw0KPiAgCXdyaXRlbCgw
eDAsIHByaXYtPnJlZ3MgKyBESVNQX1JFR19SRE1BX0lOVF9FTkFCTEUpOw0KPiAtLSANCj4gMi40
My4wDQo=

