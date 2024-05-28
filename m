Return-Path: <linux-kernel+bounces-192624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E808D1FDE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A31A1C2301F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC47B17107A;
	Tue, 28 May 2024 15:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ellcgQIX";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="DYHZNyFO"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55BD17084D;
	Tue, 28 May 2024 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909024; cv=fail; b=pCjBhS6yEMzNOsS8EzlE9WOn37i47LIUWu8ortg75010Fo/Qs/MUk1LnB+Avq6RT/l/wW7D53w1feV9QqgYuaTTsQjA5SUL3jbl+82BVyItZ68Gmed1n/EQ6aPyQBwXEfkZ6Ug4x/iW3zPMwzV1s+z2J02iUvXUrzhk7t+lWtKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909024; c=relaxed/simple;
	bh=h7V+ae/aJTiThIel69v+q7koUJ83cbaQXbsmk8ktY8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S8bgN6Cn+81efpAZqsGMV0c2QFrTia1QhhlZl24OVIYCqLOw9CQH9wlXiWuQS1CuW/uevQ6SM2I2YFQXdiaPWcKAm2Ln1GTS5OJysj7uQWHOzGvx3e1HW3L7hUWrhrZ//KQzExNEcyqZUgOOmXP+WviRIxdbO5q0+4N9giYBi4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ellcgQIX; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=DYHZNyFO; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 63694bf81d0411ef8c37dd7afa272265-20240528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=h7V+ae/aJTiThIel69v+q7koUJ83cbaQXbsmk8ktY8E=;
	b=ellcgQIXh/PvOYyeaEIQSzCHSY1ViK5FhfQdZ/w2Srj4KAeusbJ2zpocklVYa1FXLCcNIbbvbHwVD7QFuR2mu5rG1FBoPgExKLUY7rVFPX45EcGRVFvoEKhiRN0uA/FIt+sTyEgD+OF2KtN5KWytK6OhUaus4kn0KkIgZsdGMYg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:64b62656-ce15-4173-a050-f4e32087efd5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:d4e46b84-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 63694bf81d0411ef8c37dd7afa272265-20240528
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1210104709; Tue, 28 May 2024 23:10:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 28 May 2024 23:10:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 28 May 2024 23:10:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH/OGaX6LvEYLH1CohAXhLduEYKRDIXQaJIck+idTk1lLU5IAgilVICZbgUqwNCBBhtP8URN96nXKJdAI+LrHDJK2yrFyh7RULoFStv2fk4AMgc9a4IUfAGGgniuEmTrLa15TiaqA1wvGe8OZND9ud6bUxi4zhC1oEOUsSVlOFgLY7yiMr4jUe6FF9DUTejnitzdL0QW5Kc31F9GiAWfA4A1gBdIqmw8moAe+iOQ7U1JC4yAIqLXrTNDna3iFOtHnxhF8ZqauFUw12xaC9pC4BFOEnghm338H6KlKkqWYjO1OngIvbmJzRFO+8roSTHRTJAvp6rtUx6YPNEXmboMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7V+ae/aJTiThIel69v+q7koUJ83cbaQXbsmk8ktY8E=;
 b=mMufmWnsMRoucazsroM3U9Dqb4E8MZQT8iRePqM64XkgQ+AG+yB5PzI6X+wtqKmOFM3ASP+kBEXFLjyJ3Ebo1SuLOOYfO9hfZ339Azq1OejGt8b830+gHNriaZHgP9sWGPEzUfg1Rm0ZlkHSwJjPzAcH5DucuX73fnNTcEJEgThiU/cdIpHlajwvoE9putZVMUMKbInDlzw60+EIzo8aZcHxjAPvMnKhOriL2mdoUTroiBVdRZCgvqYzEqYrXsV9q0WiqXaC7bqctfDybYOY2Iyu+KuINqmQiJz0AJb9w+eLGm4QVz5yPWa3ZE1cvJb7grrLVldOeVqaHVYUP3zzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7V+ae/aJTiThIel69v+q7koUJ83cbaQXbsmk8ktY8E=;
 b=DYHZNyFO93dxNpDmAGTxz0kSdxxgslk+EDoddxYv16Mw+NWJf0hK280mc+4QJ4PRo0ySe5d1RpBGP3DM+L6rA4OWhL2rh0VRK4GdciVrn1irt5oOha+boUPQQfxs7OOUJxMC/xLZK2XyqrzNJJYwod9FQAm/WwbgWTdtNJ5nqec=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB7723.apcprd03.prod.outlook.com (2603:1096:400:426::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.16; Tue, 28 May
 2024 15:10:11 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7633.001; Tue, 28 May 2024
 15:10:11 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH RESEND,v6 2/8] dt-bindings: mailbox: Add property for CMDQ
 secure driver
Thread-Topic: [PATCH RESEND,v6 2/8] dt-bindings: mailbox: Add property for
 CMDQ secure driver
Thread-Index: AQHar3tWR1mdbw1vHkCqbT1wS+K7DrGrWdoAgAFgqgCAAAXsAIAAAtuA
Date: Tue, 28 May 2024 15:10:11 +0000
Message-ID: <9c39bbb1b1363887aa55cfe4118683ee97f9f875.camel@mediatek.com>
References: <20240526144443.14345-1-jason-jh.lin@mediatek.com>
	 <20240526144443.14345-3-jason-jh.lin@mediatek.com>
	 <20240527-bullion-slapping-d35fcddb56d5@spud>
	 <3541454c6f60b8a16f4930dd91173ed24c9b5fd5.camel@mediatek.com>
	 <20240528-herbicide-starving-3d162906914e@spud>
In-Reply-To: <20240528-herbicide-starving-3d162906914e@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB7723:EE_
x-ms-office365-filtering-correlation-id: b3eb33e0-81b4-46aa-3afc-08dc7f2844ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?c3RHM0VJdmprenFQM3RUcCtIL0prRW5nSlN2OEFoWnpGdnJDZHBaMDAyTm1H?=
 =?utf-8?B?MHVrNit1Szh1d0I3MmpQOXlpN0xoRnpOMmY1M0xQekYrVzdPNWpPYlYzVjFJ?=
 =?utf-8?B?ZmlDalkxVnNCM2ZRQndJR1VRSDVZa2IrRXpYcTMzblV2eW84M1RvRmZmTmYr?=
 =?utf-8?B?ejhvUUFrMGlxWlNTTUVOZXFWS2ZQTmE1dFg0ZWp6UFhOTzFHcG1kWS9mQUNi?=
 =?utf-8?B?ZGYvcG9BU2I2ZXRZWUxBSWsrU0trbUdRM1Y3V3Fva3RVTzl6U3FheWJlL3Bs?=
 =?utf-8?B?c3VLTE5TVU1hem1ldUhhaXpQNGltQTRaRXRRTE9QLzRRa3pldzQya09ZdWor?=
 =?utf-8?B?endjKzlPVzdMRlFIaXBpanVJcFcrUHNoRVFLSjVIS1dObHBuZGZxWUNxZlpO?=
 =?utf-8?B?U0lJOFFTSlMwYXF6UmV6Tm0wNFRxTXB0RWk1QjZuMGJrT1U4c2liZk12Q2Fl?=
 =?utf-8?B?aEtHTGNIeklSb3ZRcnU3YW5EclkyRHpGYXMzaTc1U0dQUFVPWTRmdHE1UEVa?=
 =?utf-8?B?aUE2cUMvaERoZFJkdmpUOS9RSHBIaHRjNkYwa0V3N1F0TDhUZFYvTzR5V2p4?=
 =?utf-8?B?VGdLZ0NobnN1bG42TlEyYmMranNwSHlsZElHKzU1bFZEQzNWUlN4M0VmL0dj?=
 =?utf-8?B?Mk9PWi83OXBEdlBNcVNjVlBwTmp0YzlBY1NxOXZyTjBHV2tpVFI4bFB0cEpR?=
 =?utf-8?B?eVF2cVdkaU5RbUd3cTFaRHNlR0NFaDJ2MjZiWC9aVzVDVVVDd3JXMVhMdHZm?=
 =?utf-8?B?VDUwWHlDdjZya3dKcWtTamdqMWRiZ0F4ZCtGOWswUWF1ZHFVc2xrNitobUhy?=
 =?utf-8?B?RWNZZHVDbk9HVWFmVU1IZ0FDVnJhMDB3MVI2TEdML29uVXY3ayt3bnZFc1BD?=
 =?utf-8?B?R3JQSk01eEFjSlFwUCtFbHJwYnhJeUozRWVKQVhwL1Frb0YzcjVhU0dXbExB?=
 =?utf-8?B?dGNYNlZ4eXNxdXlrY2JGbm9Ga1N3aEhEMzZvNGw3TzNvZlVDNHRhSWpTZm10?=
 =?utf-8?B?Vnc5Q29seWRGejlWMjVKb2RmNTZTQW5pbHRvVkpHZXFab0Ztd3pCNnpBM3lC?=
 =?utf-8?B?ZzUwbW5zaXVkOU1aV0xtOFZFdmZNVHR0WXVUZVUxL0orTXM2aTYzR0ZRZnR5?=
 =?utf-8?B?T0RlcFQvMFBGRnlSV3dDOFRLcnhTOFVGUytmMWM4ZGlwVGlsdnlFdzB3NTNO?=
 =?utf-8?B?UnlUN0F4WUhYcGZzV1hxaWo2Z2xlMy9Qdk56aVljWmlycHFuVmlFWUdNZVQy?=
 =?utf-8?B?TjNHOWdnUHMwSHhBWmJwbEtwZ3JrazlLU1YrVUYxcEJ4R0FIWGo4UjJ0MmRB?=
 =?utf-8?B?OHpROHhkMVJOQXBCM0lPMVcrSUZVYlNXa2V0bHZGd3hmM1FBS3hrd01FOFdn?=
 =?utf-8?B?YVB4blBRaGZMdlpMWXgrYm9XS0JvMktjQUNtaUtqdzlXRUhyWkFybXB5b2JS?=
 =?utf-8?B?Y1pwWHRpaHIvdWYyaXZZYUE5U0FZakRZeDZTVW04Um51VjJGNWd0L2I4YnBF?=
 =?utf-8?B?YWs4Tzh2czlVY25zSHpIRGdJQ2lFNUhYa0NPTlFuY2hXOWlMMEovUVhMdDlN?=
 =?utf-8?B?MWNJbk1paGJPczMrUDYwb2pubjRGRW9LVnp4TE9vRUZ6TXkzVVIwOU03cUpa?=
 =?utf-8?B?NXdpM0VRelp4Q1hLUFljRzlqMGlGa1UrQytaMzZWSStGVnRUQ3JyaFpkUWgv?=
 =?utf-8?B?dTF2ZzY4eWEvY3hTQXR4UTZpdk9SaC90S0dlUldIRFFuZHFQM2NndHJKd2Rs?=
 =?utf-8?B?Q1ZabWZ1dHFOOGduRkNaK1R3ZzVsTUh2RmxNNWhHMTZpNitoVDVnWlQvWjUz?=
 =?utf-8?B?SHd6eGllU2VOUnc0WjNKQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NnJ5anVKeFBEdDgyNkdWMGRIaFB6VFhXeEo4b2lmMkVGRDJXSnA1ZUdxZlNY?=
 =?utf-8?B?bFVab040TDY4WFl1a2hnekY2SkwzbHpMLzJIN0lubktFM2hseC9aQzJyczMv?=
 =?utf-8?B?ejRCajFOelVrZWcwdlpOVDlMWVREUzE1VWFreDZwb0lJc1AvRjdHTXV0a1R4?=
 =?utf-8?B?YUlwL2hHMDZYcEI2VEVpL0ZBYmJqYmd5eC9SZ1JMSEZBZTB4UlNXVjlaTnFU?=
 =?utf-8?B?RWV2OHhBS2Y2VmRkeHN6b1pGaStDRXBHTkF4ZE1pRjZLdkJhT2pwTkw1eCtj?=
 =?utf-8?B?aUhRNFVSMWlqYU5tajUyTkJnclRjMFZRckdlc3R2N1VxZENUbHdvZ1RrdWdw?=
 =?utf-8?B?QXNIb2wyS3FZczJaN2pidGNtYml5UEMzcm9hNlpHM2JhbXp5N1lSTExVcnVi?=
 =?utf-8?B?dFBVNWhUTE5JOGdQeldESnZYN1VDZnFRZkVQQmlDQWU0cDZCby8rKzN2ZW5M?=
 =?utf-8?B?c0RxMHdHTUpjMDRGSk05SitMc0ljQ0pYUkdRN1ZaVnFHUnhHTHVDR1pLdjRz?=
 =?utf-8?B?VXg4NVdLaUg4SW9uZTVuUjVuMG5zSEY5eU1ZRDVXNjBtTTdUWjdqUEJhTHRU?=
 =?utf-8?B?bXlnVGNjQWJlUmRBNmhYZ0ZicUtod1lxWTN6VGpMU29kODhkTjZxNnVDSURH?=
 =?utf-8?B?YnVxME9sZnFvY0RmcDZVUDZseU5YbjArbDJxRU1nVEtYaWhVclZwKzVCdXd2?=
 =?utf-8?B?ZHJhUmNCZEJRYTFlRGRSOVFIbUVMOTVrTXpXazlSakZHVk1QM1lXZUJaNnYv?=
 =?utf-8?B?bCtGWUV3dDRHR0F5SDR4bm9xdFBEeGRPaVcwRVBXSmhNeTFZL0pWUDdKUmVR?=
 =?utf-8?B?c2pENjRuMllhNGs1c2tpblVLMEQxQnBnQzBOdExGcTUxaDllZllFWmx6WWxG?=
 =?utf-8?B?c0hkdWNLTm5xRStaQzM0YVRjWmYwZGg2TDR4QWlHSXVTTGRhdkFlZ0xEa2tE?=
 =?utf-8?B?TzcvV3hVOHd4M1RyandJV25FUHptcGE4ZFR0elZFVUhxYlBBZjJWMzViMzlR?=
 =?utf-8?B?RWJEZzcyaUN2bm40L3JlUXlqUFhCbDJtb2tNM1FjenJmdXVoazZNdGRQWTdp?=
 =?utf-8?B?b0loQ05lWU42ZUI0Yk5uK1QrUTByam5TdGc5RWNNd1Bpa3JQaXlYTFN4OUhs?=
 =?utf-8?B?UnJrblYvZHBpQTV0bU9zVmhaOHlteUpiQnpsQUVFbE01Y2FpYmhhaG1QK2do?=
 =?utf-8?B?dmVYYW5naFA0bEhYcm9WejA1SU9BZkttbnN2RnVYelVmSEVuOG9JbUR6VWFU?=
 =?utf-8?B?T0h3V1JFYTEzeWlQV2pBZDJWdkRnQU5DL2N0cUo3N09VN2Q0cm1UUXA5dUpM?=
 =?utf-8?B?cktaZzB3bnZxakdEekpLMW12Rk5FS0I1QnM0QUtnVFlESkhFdXhkYkwvbjVZ?=
 =?utf-8?B?elR5YjYvQnBCamVjcXp5WHV1aDJ3SDBLT0o1QmNEajNheFczdTkwdU9uUUhO?=
 =?utf-8?B?ZldpVmZXZUZZeE5VcDRZUGwvQXdHcERodmt6Q3J5U2RZSTMvR0lwNkV4UFRr?=
 =?utf-8?B?TG4zQm5WcWZ0cmRyQXhwb1JOSTIzMUhPY1VReDQ1TUp5UU9GZXdOWFZaLzRZ?=
 =?utf-8?B?UlViMVRwb3A1eEdHVkdPa1R6YmRGS0FrcXBzc005ankveDVvTTBhQmRrdWl4?=
 =?utf-8?B?elo5L1ArcmU5dEZTdmdsSXZqdjhDRzVwUGo0dkJ6UnVXSFZhMU1xaXo2czE5?=
 =?utf-8?B?OXNoZG13RG94Q1AydXpGdGFNTXlpZTZhOGJWdm0zdXhUYjlucU9sbCtMenU2?=
 =?utf-8?B?Y3BMZlZIcDVFbGZjT2JRVmdzRzB5L0lsNzZTdTFtWjJqeWRiSXk5TWtwcmZy?=
 =?utf-8?B?dW8xV2V0WFordm9QTXc1RitkdGlzT3NYZjU4MXYrZVFyWVBTMXZZZHkycEo5?=
 =?utf-8?B?NFdhaDRvUUZZSXhBdFllaW9wL1lNVEdrS0w1YkljSXpzd0hJUHdZVDlpaEdz?=
 =?utf-8?B?MDUrQnJoODc5bTBwNlQ5Zll2OGdMUndicWk1QlBUSXAxeWFrTGpqWjRrTkFi?=
 =?utf-8?B?QklHdGh3MUxlUGJ2VUszTDRXSWtlUjZDcjVzMnlXeWhOYzh5QkVFcitmWjFq?=
 =?utf-8?B?aE5pL3hXT0s2L3JwTTV6SzJjT0g4ZjE5TG9wdjI2V2RCSXgyS215WnFNczNv?=
 =?utf-8?B?bVhiUTM5QmF5MXRuMit4NE5xOEI5cm1ITWNXN21MRjNvakZVZzIrbFJkU21w?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <92B40D1C05465042B32E3B6B26F29017@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eb33e0-81b4-46aa-3afc-08dc7f2844ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 15:10:11.2322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5ZXoXVNv/l+lzeUBpcNLppc6kOFB4KMWnI3Fa+3pdSH5Gs4pzQeuZzhhxylcrgE045EHqyfNA0lurVPgDqy2NEDaIDQTAtoXvUO5CteQ8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7723

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDE1OjU5ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFR1ZSwgTWF5IDI4LCAyMDI0IGF0IDAyOjM4OjQ2UE0gKzAwMDAsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBIaSBDb25vciwNCj4gPiANCj4gPiBPbiBNb24sIDIwMjQt
MDUtMjcgYXQgMTg6MzYgKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4gPiA+IE9uIFN1biwg
TWF5IDI2LCAyMDI0IGF0IDEwOjQ0OjM3UE0gKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4g
PiA+ID4gMS4gQWRkIG1ib3hlcyBwcm9wZXJ0eSB0byBkZWZpbmUgYSBHQ0UgbG9vcHBpbmcgdGhy
ZWFkIGFzIGENCj4gPiA+ID4gc2VjdXJlDQo+ID4gPiA+IElSUQ0KPiA+ID4gPiBoYW5kbGVyLg0K
PiA+ID4gPiBUaGUgQ01EUSBzZWN1cmUgZHJpdmVyIHJlcXVlc3RzIGEgbWJveCBjaGFubmVsIGFu
ZCBzZW5kcyBhDQo+ID4gPiA+IGxvb3BpbmcNCj4gPiA+ID4gY29tbWFuZCB0byB0aGUgR0NFIHRo
cmVhZC4gVGhlIGxvb3BpbmcgY29tbWFuZCB3aWxsIHdhaXQgZm9yIGENCj4gPiA+ID4gc2VjdXJl
DQo+ID4gPiA+IHBhY2tldCBkb25lIGV2ZW50IHNpZ25hbCBmcm9tIHNlY3VyZSB3b3JsZCBhbmQg
dGhlbiBqdW1wIGJhY2sNCj4gPiA+ID4gdG8NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IGZpcnN0IGlu
c3R1Y3Rpb24uIEVhY2ggdGltZSBpdCB3YWl0cyBmb3IgYW4gZXZlbnQsIGl0IG5vdGlmaWVzDQo+
ID4gPiA+IHRoZQ0KPiA+ID4gPiBDTURRIGRyaXZlciB0byBwZXJmb3JtIHRoZSBzYW1lIGFjdGlv
biBhcyB0aGUgSVJRIGhhbmRsZXIuDQo+ID4gPiA+IA0KPiA+ID4gPiAyLiBBZGQgZ2NlLWV2ZW50
cyBwcm9wZXJ0eSBmcm9tIGdjZS1wcm9wcy55YW1sIHRvIGRlZmluZSBhDQo+ID4gPiA+IHNlY3Vy
ZSBwYWNrZXQgZG9uZSBzaWduYWwgaW4gc2VjdXJlIHdvcmxkLg0KPiA+ID4gPiBUaGVyZSBhcmUg
MTAyNCBldmVudHMgSURzIGZvciBHQ0UgdG8gdXNlIHRvIGV4ZWN1dGUNCj4gPiA+ID4gaW5zdHJ1
Y3Rpb25zIGluDQo+ID4gPiA+IHRoZSBzcGVjaWZpYyBldmVudCBoYXBwZW5lZC4gVGhlc2UgZXZl
bnRzIGNvdWxkIGJlIHNpZ25hbGVkIGJ5DQo+ID4gPiA+IEhXDQo+ID4gPiA+IG9yIFNXDQo+ID4g
PiA+IGFuZCB0aGVpciB2YWx1ZSB3b3VsZCBiZSBkaWZmZXJlbnQgaW4gZGlmZmVyZW50IFNvQyBi
ZWNhdXNlIG9mDQo+ID4gPiA+IEhXDQo+ID4gPiA+IGV2ZW50DQo+ID4gPiA+IElEcyBkaXN0cmli
dXRpb24gcmFuZ2UgZnJvbSAwIHRvIDEwMjMuDQo+ID4gPiA+IElmIHdlIHNldCBhIHN0YXRpYyBl
dmVudCBJRDogODU1IGZvciBtdDgxODgsIGl0IG1pZ2h0IGJlDQo+ID4gPiA+IGNvbmZsaWN0DQo+
ID4gPiA+IHRoZQ0KPiA+ID4gPiBldmVudCBJRCBvcmlnaW5hbCBzZXQgaW4gbXQ4MTk1Lg0KPiA+
ID4gDQo+ID4gPiBUd28gZGlmZmVyZW50IFNvQ3MsIHR3byBkaWZmZXJlbnQgY29tcGF0aWJsZXMs
IG5vIHByb2JsZW0uDQo+ID4gPiBJJ20gYWxtb3N0IGNlcnRhaW4geW91IHByZXZpb3VzbHkgdG9s
ZCBtZSB0aGF0IHRoZSBmaXJtd2FyZQ0KPiA+ID4gY2hhbmdpbmcNCj4gPiA+IGNvdWxkIHJlc3Vs
dCBpbiBhIGRpZmZlcmVudCBldmVudCBJRCwgYnV0IEkgc2VlIG5vIG1lbnRpb24gb2YNCj4gPiA+
IHRoYXQNCj4gPiA+IGhlcmUuDQo+ID4gDQo+ID4gWWVzLCBpdCBjb3VsZCBiZSwgYnV0IHdlIGRv
bid0IHVzZSBpdCB0aGF0IHdheS4NCj4gPiANCj4gPiA+IFRoZSBjb21taXQgbWVzc2FnZXMgbWFr
ZXMgaXQgc2VlbSBsaWtlIHRoaXMgY2FuIGJlIGRldGVybWluZWQgYnkNCj4gPiA+IHRoZQ0KPiA+
ID4gY29tcGF0aWJsZSwgc28gZWl0aGVyIGdpdmUgbWUgYSBjb21taXQgbWVzc2FnZSB0aGF0IGV4
cGxhaW5zIHdoeQ0KPiA+ID4gdGhlDQo+ID4gPiBjb21wYXRpYmxlIGlzIG5vdCBzdWZmaWNpZW50
IG9yIGRyb3AgdGhlIHBhdGNoLg0KPiA+ID4gDQo+ID4gDQo+ID4gWWVzLCB0aGlzIGNhbiBiZSBk
ZXRlcm1pbmVkIGJ5IGNvbXBhdGlibGUgaW4gQ01EUSBtYWlsYm94IGRyaXZlciwNCj4gPiBzbyBJ
IHRoaW5rIGl0J3MgcG9zc2libGUgdG8gcHV0IHRoaXMgaW4gdGhlIENNRFEgbWFpbGJveCBkcml2
ZXINCj4gPiBkYXRhDQo+ID4gYW5kIGNvbmZpZ3VyZSBieSBkaWZmZXJlbnQgU29DLg0KPiA+IA0K
PiA+IFRoZSBwcm9ibGVtIGlzIHRoZXNlIGV2ZW50cyBhcmUgZGVmaW5lZCBpbiBpbmNsdWRlL2R0
LQ0KPiA+IGJpbmRpbmdzL21haWxib3gvbWVkaWF0ZWssbXQ4MTg4LWdjZS5oIGFuZCBpbmNsdWRl
L2R0LQ0KPiA+IGJpbmRpbmdzL2djZS9tdDgxOTUtZ2NlLmguDQo+ID4gSSBjYW4gb25seSB1c2Ug
dGhlbSBpbiB0aGVpciBtdDgxODguZHRzIG9yIG10ODE5NS5kdHMuDQo+ID4gDQo+ID4gSWYgSSB3
YW50IHRvIHVzZSB0aGUgc2FtZSBldmVudCBkZWZpbmUgaW4gMiBkaWZmZXJlbnQgaGVhZGVycyBp
bg0KPiA+IHRoZQ0KPiA+IHNhbWUgQ01EUSBtYWlsYm94IGRyaXZlciwgSSB0aGluayBJIGp1c3Qg
Y2FuIHBhcnNlIHRoZWlyIGR0cyB0byBnZXQNCj4gPiB0aGUNCj4gPiBjb3JyZXNwb25kaW5nIG9u
ZS4NCj4gPiBEbyB5b3Uga25vdyBob3cgdG8gZ2VuZXJhbGx5IGRlYWwgd2l0aCB0aGlzIHByb2Js
ZW0/DQo+ID4gT3IgSSBjYW4ganVzdCB1c2UgdGhlIG51bWJlciBvZiBldmVudCBJRCBpbiBkcml2
ZXIgZGF0YSB3aXRob3V0IHRoZQ0KPiA+IGV2ZW50IGRlZmluZSBpbiBkdC1iaW5kaW5ncyBoZWFk
ZXIuDQo+IA0KPiBJIGRvbid0IHRoaW5rIEkgcmVhbGx5IHVuZGVyc3RhbmQgdGhlIHByb2JsZW0u
IFlvdSBnZXQgdGhlDQo+IGNoYW5uZWxpZC9ldmVudCBkYXRhIGZyb20gdGhlIG1hdGNoIGRhdGEs
IHJpZ2h0PyBJcyB0aGUgcHJvYmxlbSB0aGF0DQo+IGJvdGggZmlsZXMgZGVmaW5lIHRoZSBzYW1l
ICJ3b3JkIiB0byBtZWFuIGRpZmZlcmVudCBudW1iZXJzPyANCg0KWWVzLCBJIG1lYW4gdGhlIHNh
bWUgImV2ZW50IGRlZmluZSIgd2l0aCBkaWZmZXJlbnQgZXZlbnQgSUQgbnVtYmVycyBpbg0KZGlm
ZmVyZW50IFNvQyBoZWFkZXJzLg0KDQo+IEluIHRoYXQNCj4gY2FzZSwganVzdCBkZWZpbmUgdGhl
IG51bWJlcnMgbG9jYWxseSBpbiB0aGUgZHJpdmVyLCB5b3UgZG9uJ3QgbmVlZA0KPiB0bw0KPiBp
bmNsdWRlIGEgYmluZGluZyBoZWFkZXIgd2hlbiB0aGVyZSdzIG5vIGRhdGEgc2hhcmluZyBiZXR3
ZWVuIGR0cyBhbmQNCj4ga2VybmVsLg0KDQpPSywgSSdsbCBkbyB0aGF0IGFuZCBkcm9wIHRoaXMg
cGF0Y2guDQpUaGFua3N+DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0K

