Return-Path: <linux-kernel+bounces-213690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515989078C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F0C1C22D3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57E013D63D;
	Thu, 13 Jun 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uRqfMeiq";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fOjFnN85"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5905012FB15
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297594; cv=fail; b=KbgQXNYZZErDNAFuAX/CgELCfQpBJt3Oz+6N3DKEzprkRqDfQxbrxsaQa5AA3kfz6yRmfDG3nWMjjwE3/to5bUCnwY/qTouu/PebjOU3gQosQQOvwHL5UIzqLJkoRfuT1M9GUOBr6AZlMcO3LmN12BnfSur3hSVEHBb6nMWT/ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297594; c=relaxed/simple;
	bh=2MGo7ATiWI8oPcpllI9evMQSSl9XCThUJVizbRRvl0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QPiJWn+dZMLZEbw65apOm1oSy7EWaTNW/8k54ZUzj767RIBXjNoN6DW8AhK4pnaTnO+e+L4+P9jLS0T9Xy9x8jUnYflKJe1glWxUudCbUcUpWa32Lb8VSr4MDOUhQt7iEo4c1TWhc5OpWi3g6tSTIy2H6LPBRMx3dMbJL2YqE4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uRqfMeiq; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fOjFnN85; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 66f3fc3e29a511efa54bbfbb386b949c-20240614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2MGo7ATiWI8oPcpllI9evMQSSl9XCThUJVizbRRvl0k=;
	b=uRqfMeiqwOWNL+2VG2i6m0p/3VyUI1+MS8CZEvE5zzfqkRaAJY8tfvCHDqkqiUz6xYCIDiwDk7dHa/ByOnw21yefbmtdcJMUv8lXz+ZOLYwETOfqBvFtELq7U3Nn+pBBkMRA2rhSDMO/CJOmh7zUiKySnXvrr+v17eU9+uYG/BA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:83e7e17d-02bf-4cb1-8688-3deeaa416f3d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:ed090e85-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 66f3fc3e29a511efa54bbfbb386b949c-20240614
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1638428188; Fri, 14 Jun 2024 00:53:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Jun 2024 00:53:03 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 14 Jun 2024 00:53:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qw0yp4tuhNwtNw+bpNYep6Nh4dJrIM6aFoZYQzv5UbmaTTTd3N4QUADOe4VSdD98G7RctoK78vNe9tNFzJlkcuYukldAlfEAECYTXVmiQ58JtLmWt2OflMkhTGX3agTf8a2DCF5hzqaeXdDJwuGQRA7Jx5yo80TyBdUDtWhOonq/SKoDusv24HlSW7XPtv8MbZboVOECHeGZ2qzhbsdMdrj0JTuYvFxdM8XOdddMD1aTcYPSG60cfu/RDBKFSQReVKLNICWZP4REhZZkUNkOPyC+MyxReCVVsmBffOxi6sM4uEZQra5l90l/nLb9mujaG13WvxtsoLdVG/tnrPefeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MGo7ATiWI8oPcpllI9evMQSSl9XCThUJVizbRRvl0k=;
 b=df9npfYiPKLwZUgsl1wMfgyjQNpVwCv4pOEXUjp6A2nv7ltAijquQ0ccL69mI+bWa4cetoeTScMXas2T9oJtcGOw5SajDKjobTH5sOyq1CifMx1zII8ro1eNFHEbDz4HIPKvZgtFnjhox62MylUzbMP5MA2iXMvfv/LB/Ub9tLSgWH/tAwTKAHAOmli1x7pGxKBuS0bjSXYXe4JcHgRwA9bCMGRXkoAirOpzVxxE8FnpOpSMMfMsl0YY/RASMiKiWuX6cb8iw4ZUeKbKRk/sd9qWU9V7YHpQfOYeaFmW65++DMEDQLkyHj3W6xvSBqUIlVfMSAooFgUq2B60hHTjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MGo7ATiWI8oPcpllI9evMQSSl9XCThUJVizbRRvl0k=;
 b=fOjFnN85GYmdrfxz7vDcpxncjJAhGs9DoMn4woiqS1xlPz5w0Yxu4s3JQFjrw8pIZ8mQt0ChVxioowACOnIsWQvTJ6XTekX+KWkQ/VWVqhg/WxFcdn5r/2kthIpVBhoP7o6h+SIcEc4MK1rtYKOkZVdEqvupxm4AY3MdwHV2TYQ=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB7166.apcprd03.prod.outlook.com (2603:1096:101:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 16:53:01 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 16:53:00 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?=
	<Singo.Chang@mediatek.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
Thread-Topic: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
Thread-Index: AQHavaNGmeIQnKWVzkKgT+U+XkKGsbHFzHUAgAAcj4A=
Date: Thu, 13 Jun 2024 16:53:00 +0000
Message-ID: <44f6308379a8b6c834df6ff0604c652bf1f7a4b7.camel@mediatek.com>
References: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
	 <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
In-Reply-To: <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB7166:EE_
x-ms-office365-filtering-correlation-id: eab22437-8310-4033-99a4-08dc8bc94900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|366011|376009|1800799019|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?ZWh1M2V4dXZITXZqalN6aGhWQzcxQVF6VmpEZXVKdkNrdFA3TGdOQlkzQ25p?=
 =?utf-8?B?N2IzMkFUS29FaG9kamh4K1dOc3JOWDdyWXZZZFBqWmJKT0g2d3pDOW82NHhC?=
 =?utf-8?B?NlUwOGtCcUtOaERwWEtzcFl5Zk5vVGhNVGYxR25ST1cwRElENlczVDZKQmoz?=
 =?utf-8?B?VTUwVHNQek9FRk95aXMzcmtveHBDZ2FiZjMxYWxlNUk0V2tMc3dOL1NkT2tw?=
 =?utf-8?B?RWlLTXFSZHBmQmJjTy9iWS9lZlJRYVloaTF4TlVZaFlGV1VDb3F3U1RTLzdM?=
 =?utf-8?B?djBOSDBsZFNFNitRem1TMnNjMGFETU9aYkQwdnJXbUhGa1Nhc3JCQ2FDRzJv?=
 =?utf-8?B?TW9aWWs0bW5qRjVqTzlDbHU0Y2NDanRyRDlaYk9qTVdEaVUreEJMMnlZS2gw?=
 =?utf-8?B?eU5SWVVUc2x3cHBRYkJGTFpLWUp6SFIvdGwzYmIzVGdzalBtSnBROVNxcG82?=
 =?utf-8?B?MXI4VEIvNVQ4dHVnaE1hNGNqaDdZbUNlTms3blA2Z3ZCMHZDTFhJUTVaMWts?=
 =?utf-8?B?OG5TQ2dzb2wyY2lldC90cjJvalBuSitXeEZZand6S2FadVNhVkNhTi9oTFI5?=
 =?utf-8?B?M2RlTGt6R2t0ZGVsS2RBdWxuR3pDVGpzOXRhdVlCT0hzL245OElKUGpOVklO?=
 =?utf-8?B?L0tsZDl6WU1MOElHeE9lNGFxUE53eDRpY05SMStKL05XYzZ4TkFiZDVVSEtu?=
 =?utf-8?B?Z1NsV2hsdFk5YmVaRnI5MDZOMUlKOHJTbnBpK3BCcUJ2NFBNMEtFQ2lySDVy?=
 =?utf-8?B?c2FKbXNQc2pKbDFxc0YxazREU2dpQXFYR2wwaEVQNTljZmRzOEFQeU9Od25m?=
 =?utf-8?B?aDduQWtKWStybTdNVENOQm1sZlZnb1ZRMHNBWjdVNXNwSnNnRFdJblRvcGhh?=
 =?utf-8?B?NzZvdmVHWU1Yc3hRRDg1MXpXbFQ3WUF1Y1l2SEpBeXluWkx6Nk9DTzAwMWIw?=
 =?utf-8?B?RzUvWTlpeUpLeHcxK0tLUmczZVI0aGxBSGQ1bmNyTmtGalhTVUZHYTV4allB?=
 =?utf-8?B?alR0VFZvNjNBb09rTXZuMSt0NmxxN3FUTFR3MGJJWEhaMWI2cHZ3MlhCTy9I?=
 =?utf-8?B?TXUrM3krSWhQUHVYd2FuN3FoQXpzN2txMWtXeXNOdjdsSnl2SnJvNWV4dVVx?=
 =?utf-8?B?Z0pWVVRmWmlDV0ttL3VKU0kyQzNiQ05WSjRRTDlkT0VlSXRWcmsrc0Y2WEll?=
 =?utf-8?B?WVNPTVMxSXRNSTFiRnNBWkc1S0xpN2dRYWtTY2Uwam5UdjlBRXlEZVlHRExP?=
 =?utf-8?B?bWplSFNmcXdBb25GNFpoNmxpYkRKRWVCTEpOSis4Rk03bFZsS3J0NEtoRldE?=
 =?utf-8?B?Nm9KcEFyYWNYOWlHWi8rZmwrUi9aUjNMeFZlR0ptb0s4T3lGdzdEa2s1RTRa?=
 =?utf-8?B?REVGUDdwVllONEV5VnhvVkpjUWVNZStMS0RxMGNlMXN5OHVzVG5meFV3RTUr?=
 =?utf-8?B?cXBmK3dOaWk5K0FuTUx5L21CM0lMM2gvNEt3V3NHTlpLTG9Ea3hmT2o4R0ps?=
 =?utf-8?B?N0FBVG1DVTFkSHJlVkV1Nm13dFpNUXRKWFJPaXZ0THVOeVJDdUlrZVM1S1N4?=
 =?utf-8?B?bzBQbHBFWTdoWXpyMlN2ZW9DWVVRNVZWYm5RVFo2S2xWb0I4Zjltd01hSisx?=
 =?utf-8?B?NWE3QzdkclRQSmhwY1hqK1NVY1RVUnhtMUVqdk1wOTFQUjFhU2Zlb0FJQW9w?=
 =?utf-8?B?YVpUUzU3aUZzeWJWaEgvaU1RWUg2RjNGc2R4VzNOak96dTBGTVpqTDZDcFA1?=
 =?utf-8?B?WGZwa3F2bU1HRlNFSTEyTW9ZL0k4cXZvdWxiRjVlVlNsL0l4MGJrdDY3WjRU?=
 =?utf-8?Q?7UpKNwTsTgYEzB1/6x7U0Z9v+1bR93CcmWIEs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(366011)(376009)(1800799019)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T004UlUxb25MMXdwYWxXQ2w5a2pzU1R4MG96YWFtS2ZYTnBVWTBVM3lrRnVE?=
 =?utf-8?B?VTdod0pXekRWL0t5TzYveEpkTWdYOTJydzNMOUR2LzdHcW5SR0dSYzNpUHJq?=
 =?utf-8?B?Y0RLMmo0bFpHbnNJUUE2UC8xV2tyYkdPUmpOd0VkRGo1dDRmdExrM01HNHNV?=
 =?utf-8?B?SFFzTEpXVFNyYlVvdEJucUYyVVNjTktWNXZVSC94VDd5QWljclF5MHVCaXlQ?=
 =?utf-8?B?bncvcEthRHNLZWt2d3pjenhrNnZMNGN1RVF1QjRyYVNQUGh5anlXcEpqV2hq?=
 =?utf-8?B?K1M0VUloWXFFMTJwbks2QWFoRThYblJ3azRNZnRsWWVEQUZWRk0vR1JKY3g1?=
 =?utf-8?B?STZsTmozWlc0eFdpL3UvZ2NZbDgwaWVra1R4NjNxWEJySWtoSEVvdnRUSVN5?=
 =?utf-8?B?VGZubC9BclcxZGo5VGpqbmZKU3lycllkL2VydTMzYnVBN09ldmIvYndWT05a?=
 =?utf-8?B?UzZST0Z0cWhsMncwRlpmUnNmZXNSWFBNVksyNFBEdDN1RUh2L29aN1dEWFdu?=
 =?utf-8?B?VUs4VmRKcktYVktJR2ZUSXJtM2NaemtuUzNRSkZOa1JUTmkyVndIMVZEYVNs?=
 =?utf-8?B?RDdsWWNzc0txKy9aOHBOSnRoQk5nWUIzRzRwZk5ONHptbXQxMjdaOUlFV2hR?=
 =?utf-8?B?cjlUQU1XcUp1Nkp6dmVPY2t6T1Y4emtrZWlXL210YnZmUkFHRkEwbjNScUl2?=
 =?utf-8?B?aHJkRU5IOGNkUlg1VjVTT1lJWUhieDRXZG13MkpYMWo5eEs5Q2Vnc3V1blB2?=
 =?utf-8?B?b2QyVEFXa1VEUk9GRjNTcDVqdkNTZmNVdXJwbFBsenVvd2h3RVp1dUp6VWZT?=
 =?utf-8?B?ODBxTHg1c2JqZmsrdndkTzJTRTdYdk04TTFlSWxxOW1jczQ2VWJEOHRyOFBZ?=
 =?utf-8?B?eDk0dys1WmFPbkJmVVp6MjhyWm40NHorWng1b01vZ2VsMGlVMG4vdDJhbW5M?=
 =?utf-8?B?Z3hEa2RrWTlkRHREa2JGdkNMUkRDVlUzanJUVS85QnQxQndaREpMY2EwTTZq?=
 =?utf-8?B?NWU4SmQvc2l2WWxERVJZYWN2RGRwbkkyWnd2QXZQQTBlbWR6Y21WUjdjV2VL?=
 =?utf-8?B?ZVhORjdsb29QZFI3eVV4cXp1eHdsVXlxTW1OME5ya2lCNXBWOWFlNnVWb2h4?=
 =?utf-8?B?RklTU1UyVnpnVURPT2I4YTlKcjFSU0xmdXB1cm12OHlpWWpiaGRlejU5cCto?=
 =?utf-8?B?UFFWdXg2b1VscmplV3BDaVRkRmJwc1F1Mk1QeWhTWlZZZEdncGszdzhEVXNx?=
 =?utf-8?B?QWQyVklUaXY4ZHRoWEZZaE9WWG1NRFRjdDNLdXQyTDlTQmlUYnVweG9PTm1a?=
 =?utf-8?B?eGxRWjdua2c3Y0MwY29TM2Z2Wm1KZTR0WXlIT1k4UTRSVSs1KzQzMDdlM0tK?=
 =?utf-8?B?N0dWUW5iL1poWE5GMTl1cjFhRGhKTEFTampXNWF5K2tCZ1c2cEprNHV2UlVv?=
 =?utf-8?B?UlNzdjNUTDB0L3c2SzZiblVVOG9iUWJJSkRrd1FIU3F6S0pxTU5yc1VBL0Mx?=
 =?utf-8?B?RzNGV1V3MzNaKzdWSXVhcXdUa0dIRHVWdEZxMU0xUFJmVVVINkVzYnBUelNB?=
 =?utf-8?B?UkZXNWhXRzFQSVhzYXRNV29uWFVtN1ViakFHVjVkczg3KytCS1doNjFOQnp3?=
 =?utf-8?B?QzFSSlhJeHJtLzN2NzR3TnMwQ3FjSVRSNG4rTWFZUGx4UU9NdWtlVnljZ2xt?=
 =?utf-8?B?YjdROVk0aXhJN2t4eXFKQ0pBbGxrT2kwbk1LRXZBdnVtSGFITXU0RnRGc0Q4?=
 =?utf-8?B?YWdSWGE1Rkc3QUtNUDB0MlJPeGtvRkxHSGZMY0N0MFkyaVlhRUo1TytXY2o4?=
 =?utf-8?B?ZFRwRDYzNEVPYWY3aGkvQWovN0FzaENBcGsvL1MxTlZnR0NVbHlXSDM5ZENy?=
 =?utf-8?B?ZGFEMTJqWkprRHZibGtjbTlhZzhTRkY2NUE5dFFIc3A4eUZPbnh2TFpsOGxv?=
 =?utf-8?B?cFBSRkRGRHROb2lRT3ZxN1Voa1ZFU2pjOEt1RnlkODRrSjlUMW1IbmhFQmts?=
 =?utf-8?B?OWlXM3phenlNTnpBa0lFRlpQTjNLcnZBWjZjZnFHSDJiQkJCUUs1S0hBR0xH?=
 =?utf-8?B?ekhKalc1aHJ6MDJTYlBiN3B0UlRYZXlkRGVENVVReHZUR3BiU1owMXhkU2dp?=
 =?utf-8?B?RHdUSUdmaFpoOXV2TTdOczNaaW56UDNla0FadUlnczBlWjh3RGFabERraWNT?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21E833A8D085BA498CF3A415E7D7EF9C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eab22437-8310-4033-99a4-08dc8bc94900
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 16:53:00.8712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43ccuSi4JsPeWzDGG3vvGs8kIKO8+MBC6UbnOhcFmPcFQbRbpVdt6KSgjzE/32e2Aw0uNmJTRPFQmWb4kTZbW4Ae6SgQGnDNrXQ+SC+pJE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7166

SGkgQW5nZWxvLA0KDQpPbiBUaHUsIDIwMjQtMDYtMTMgYXQgMTc6MTAgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAxMy8wNi8yNCAxNzowNiwgSmFzb24tSkgu
TGluIGhhIHNjcml0dG86DQo+ID4gQWRkIHVucmVnaXN0ZXIgbWFpbGJveCBjb250cm9sbGVyIGlu
IGNtZHFfcmVtb3ZlIHRvIGZpeCBjbWRxIHVuYmluZA0KPiA+IFdBUk5fT04gbWVzc2FnZSBmcm9t
IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBpbiBjbWRxX21ib3hfc2h1dGRvd24oKS4NCj4gPiANCj4g
PiBGaXhlczogNjIzYTYxNDNhODQ1ICgibWFpbGJveDogbWVkaWF0ZWs6IEFkZCBNZWRpYXRlayBD
TURRIGRyaXZlciIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5s
aW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gSGVsbG8sDQo+IA0KPiBJIHRoaW5rIHlvdSBmb3Jnb3Qg
YWJvdXQuLi4NCj4gDQo+IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzZmY2Q0OGIxNGU4
NjVjMjVlNmRiNzU1OWZlNmI5NDY1MzdiZmEwY2UuY2FtZWxAbWVkaWF0ZWsuY29tLw0KPiANCg0K
SSdsbCBzZW5kIHRoaXMgc2VyaWVzIG5leHQgd2VlayBhZnRlciB0ZXN0aW5nIGl0Lg0KDQoNCj4g
Li4uYXMgdGhhdCB3b3VsZCBhbHNvIHJlc29sdmUgdGhpcyBvbmUgd2l0aG91dCBhbnkgaGFja3Mu
DQoNCkkgdGhvdWdodCBpdCB3YXMgYW5vdGhlciBwcm9ibGVtLCBzbyBJIHNlbnQgdGhpcyBwYXRj
aC4NCg0KQWZ0ZXIgbG9va2luZyB0byB0aGUga2VybmVsZG9jIG9mIGRldm1fbWJveF9jb250cm9s
bGVyX3VucmVnaXN0ZXIoKSwgSQ0KZm91bmQgdGhhdCBpdCdzIG5vdCBuZWNlc3NhcnkgdG8gY2Fs
bCB0aGlzIGFueXdoZXJlLg0KDQpJJ2xsIGRyb3AgdGhpcyBwYXRjaC4gVGhhbmtzIGZvciB0aGUg
cmV2aWV3Lg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gDQo+IENoZWVycywNCj4gQW5n
ZWxvDQo+IA0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
YyB8IDIgKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPiANCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IGIv
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IGluZGV4IDRhYTM5NGU5MTEw
OS4uMTM5OWUxOGEzOWE0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5j
DQo+ID4gQEAgLTM3MSw2ICszNzEsOCBAQCBzdGF0aWMgdm9pZCBjbWRxX3JlbW92ZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IGNtZHEg
KmNtZHEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiAgIA0KPiA+ICsJZGV2bV9t
Ym94X2NvbnRyb2xsZXJfdW5yZWdpc3RlcigmcGRldi0+ZGV2LCAmY21kcS0+bWJveCk7DQo+ID4g
Kw0KPiA+ICAgCWlmIChjbWRxLT5wZGF0YS0+c3dfZGRyX2VuKQ0KPiA+ICAgCQljbWRxX3N3X2Rk
cl9lbmFibGUoY21kcSwgZmFsc2UpOw0KPiA+ICAgDQo+IA0KPiANCg==

