Return-Path: <linux-kernel+bounces-421890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DC99D917B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4212216A76D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E8156F5D;
	Tue, 26 Nov 2024 05:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mKIGtwBw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Owp0V1wa"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9887E76D;
	Tue, 26 Nov 2024 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732599953; cv=fail; b=YaHB8JB/KvQs72Bl4pEbrc/DjhJpMxF/4MYXs4e5PM0NcAnBu2ZgON8TAddZCB/qD3MCS5t13bWo4gFGApsTXa1o5EW94M58jAM/zrSvNJf83dxl3eRn/x/kAnGKICFMKHUdczEJ7EZLuAUiviANy0KfXtGb56pWJR28bTbE4Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732599953; c=relaxed/simple;
	bh=GRoDlarksefar5jN/4V6Q/pKWh6UdBgHlS5Jsh3t9vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KmaBDEvOzXT1DjxrDjJwPqi4Y2oo4fbnO8sx0a2r9HcGlEBRk3nZnmq1cFEh5+r7a9EFdJVfGqPYb3jd+T0dDtH2Gyhb8RxMn9BglY9gtnS21rQuwKUcz8dUZ6bpPYAH7IFlHFSoCHtpLpoc2iqwnYixvo8zUOdJDSJ31jG2Oqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mKIGtwBw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Owp0V1wa; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: adeb03f8abb911efbd192953cf12861f-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GRoDlarksefar5jN/4V6Q/pKWh6UdBgHlS5Jsh3t9vI=;
	b=mKIGtwBwIFizsjtBhQ+P5b+7mPPh0z5bYiEovV7frQQPetlfHdIa9T/+HWolgECZcvwlKSvdvHfG+2ZSZFQJltutUXkUhHscxGDxR14ewjfo6iBNeykGBX/ljqyI4V6PYohhDN2l8JfiyI5Fbz24vdqMHe7iEpJOcYpq9TBkB+w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:0417379a-39b4-4a44-9bf7-ada89b0c3e76,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:d7148223-634f-4016-85ba-2d63e55c9400,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: adeb03f8abb911efbd192953cf12861f-20241126
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 916234454; Tue, 26 Nov 2024 13:45:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 13:45:42 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 13:45:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WyS8V+wlvJ/UHg6P4DkkMFoqF9DTvkRh7QKVc4/zVoUAbmtCti3cwJPCzsgxqOQGLLpKkclNzytSXTl1iWZBHqOYOf2rXmxeJROAgYsF8qoMRZbRSZ3npeDKWbWO3ynYpmqtvIafn++gleC7vvIx/SMfV0h0TFezAYUNX7gOnlhwMwH9sRBDRxRvyVKQ67ZLE1nBfdvjOR831PgZphR7dm/XdoxKpZTLROP+JI7Gem3WzO7FuPzCw1ZNu/4aV6ZQhV6p/ccFqlGKykLkhSJ2iUplVV1mgIo0Rn9Rr4HMFKLviORX6NIGNKf7HAOiOLrHwRL3pkQEqj2viskMHMp0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRoDlarksefar5jN/4V6Q/pKWh6UdBgHlS5Jsh3t9vI=;
 b=XNMbDA0jpImgrw9B/ITdjbE4j++A8shVhGXM2JmeYaSI7W+Ov/qi5b10crFBGTWx+AS38ICjI51Br7UjLINdpzW0ZxrJb688dzyP1EE1OCsM4O4VagdaY1zKZBAdKlyPcavsOhk2+Moyqopczlz/H0OU86iseYWwbQXMaYUEWWb5KbEf2+H4Rjk7OsrCloWMILv91+YP9fSbK6HOArBE+p0NLYO9SNT22W0D5FTk+BBQYlpqLy0IPuPhUDziz3op1uqsOR/BlBWavsGZt8MbapqTahlSVRDsHxWbFYieYt29PbRz4dcmxeMuyIuW0br/v9//y/7uhcO43emljp+Eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRoDlarksefar5jN/4V6Q/pKWh6UdBgHlS5Jsh3t9vI=;
 b=Owp0V1waluIpdUelP0wEmiEZBVRwgIcLD4z5SNSg9jfh87XRgtRlOhUlpIs64utZtnGVRPHJD5Vsby6TA1qJTQUmgmVflOTZWHnuzVw9QpyMCnqPfxfjybZ0/IkB58wzV6a+VfPnd672W9+TYHexMRXv/jOFu+Dx3uIuekkWpKg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8602.apcprd03.prod.outlook.com (2603:1096:990:91::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 05:45:39 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 05:45:37 +0000
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
Subject: Re: [PATCH v1 5/6] drm/mediatek: mtk_dpi: Add checks for
 reg_h_fre_con existence
Thread-Topic: [PATCH v1 5/6] drm/mediatek: mtk_dpi: Add checks for
 reg_h_fre_con existence
Thread-Index: AQHbO0oK/HjljofgE0OU1gp4Pu5A17LJFkKA
Date: Tue, 26 Nov 2024 05:45:37 +0000
Message-ID: <7566e9629d834c07b75324a4925d45c9d0f71958.camel@mediatek.com>
References: <20241120124420.133914-1-angelogioacchino.delregno@collabora.com>
	 <20241120124420.133914-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20241120124420.133914-6-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8602:EE_
x-ms-office365-filtering-correlation-id: 288c9135-c106-4984-4f09-08dd0ddd8e19
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ckZrMXdGaDhOVm1ROFUrZ2dpdDE4YlJpV3ExMFBaK3V1bEhFTU9LOCs3WnZG?=
 =?utf-8?B?ZjF6QWxCZFJic2xkdjMvVWFoVlM0ejB0VnByT2dtMmpPWHRnVGZSZU1tMWV6?=
 =?utf-8?B?TU4vbzdubW8zUlVQb0l4TS9MK05Xc0EybVpiTUhId0NnaVNWMmZEWVU1aXFI?=
 =?utf-8?B?YjFxQmVkNTVObWsvRXhBWHUrbmo0N2JZYVdQdjRmQ1NWd2dvbHdOYW8vSDN4?=
 =?utf-8?B?ZEZoMHRFV3p0QXlYWk13VDBYVkxSc3V0bmZydmhPdloxYllmTk8rTXZOUFd4?=
 =?utf-8?B?VUFZZTRGWVZNUDRkN24xcVZPNzJrRExjZU9aaTdaRUF0SnYrbUNUOVRpU2Nl?=
 =?utf-8?B?eHN6bForWm02WWZySzZRL1h4ZjJLWXYyR0wyV2VrOVB5OU9QSTNQaVdlbFI3?=
 =?utf-8?B?OGRWSVR2NFZoOUdaWjdOYUVqVlJJeHVGSklJY2hKa3dFSTJ5bTdPS0k0cjI0?=
 =?utf-8?B?MytSWFdKcUtXSkhXcUhBQi91cnpBRlFUSFIzWE9icEd6RGU0NUZmT0pib0o2?=
 =?utf-8?B?YmN6QXprMzV1SXVkNlFyeVVybzhPa2h3bC9CT1Z4VWlkRTdSK3hlV0t2SXF6?=
 =?utf-8?B?bEMzSUtFNmxxbW1RdTJ2UVFzSURCdzIyM0lPenZmMVRGczRtWUlQU3FGWUVK?=
 =?utf-8?B?WGk3WVpJeUVFTEMramppTVNxYUYzdkNXaGF4UzFlY0ZxclZ5TS9FR2xHU2ZN?=
 =?utf-8?B?aXl0bkZSOWN6ZWF1eHorU0J5emdib0UxRU5URWVpa3pDMERidXRBS2NUTnZW?=
 =?utf-8?B?TDFrRXkyNm1yTDF2eXVQUnpKdWFZWnExY2h0VE5PcFkvZ2xONXRWT3JiQzF0?=
 =?utf-8?B?VlQzdGlJWGpKbnVzUjg3dG5zTTRlTGI0OVVla1VtQjdtK2toYzlZZ0E1VUo4?=
 =?utf-8?B?aFo2ZitTcHBXU2t4bW9HcHl1TVFsUTlEaG83NEJtdDdUalhZZEZZRE1HcXZr?=
 =?utf-8?B?MjlJbkl6bjBoTDdhd1k5cG1MLzN3eTVKVTc3WE45Y1UzRmdNNkRnNVdkZHRK?=
 =?utf-8?B?RXVxQUw5QTZqbVNZdUNFWVRJRkszczdhTzJoelZkNWJablpOOEZpTU9mVjYw?=
 =?utf-8?B?bnNvb3hqZXJnbXNFeGh3cFZESmxsZTBZblFwVnFQN21La1VOdmZIUEJJZHNR?=
 =?utf-8?B?TW5nUnd4azZDU3gxbTdBazREQjBLdVh4VXZ4enEwenV6VTlDRXhSUTQ4d3dG?=
 =?utf-8?B?cGVwSEtCb0dvVXIvVmhmanBJWXBER2hVS1d5Z00zcG5YUzZrMmFTV3VMUWp4?=
 =?utf-8?B?T1dRT0l1UThlbkZucjkwTFNtaHVDNVhGUUNDWldRSml6V0hoNmkvYWYyb0Ry?=
 =?utf-8?B?NXNad3F3dTBLZzRyeWJzMFM2cm51eGZDdzRzSFMxSmp3MG9pNFQvdnF5eEgz?=
 =?utf-8?B?TGcxeFJtTDV3VkxLTFFQOFlsMG9lTUZ5eG1pUzc1V0ljSkI3cVA0NVp6SVVi?=
 =?utf-8?B?SXY4QXNGOXl3dFB0d3BaN2VFSVp0VkluR1NjNTZRUXMxVDZEY2NBYnIyaFpO?=
 =?utf-8?B?SHR0SWxnbFhXU1VtNld5RjJ6cWtMSkthdmZ5T2g1SEpJbzR1OGNRa0k3THRX?=
 =?utf-8?B?eEF0L3hIclpjdGlzTE5PeHdKaDlPUGhBQ1ArTDdTUXNwekxudlllY2tjbEhh?=
 =?utf-8?B?cTFheFQ1NE10ZS9qMU45ekg3WmR4WEpZSUZhOURoQnkzalZTNXBNK09KYkhw?=
 =?utf-8?B?dmRIZ2g4SmxkT3VEZW8zMEFqUkxyNjd2ZUdqc2RVSnVRMHFrNUNnWTUzdnd4?=
 =?utf-8?B?V1pMYWsrUmhkUnFsek4xZVlpKy8rTVBUTFgzdU53cDZRMWpVemFpd1RQRGN1?=
 =?utf-8?B?cUF3eVp5NVU5cTQ3S09GNXdEL2J1R0daeGlBbVJucVdEODF4RTZ6aTBWNVRY?=
 =?utf-8?B?MDVtcXh2cDdlRE9qQ0hvTGpQVG1OQmdvR0JMaXJxNFRMb0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elg5cWpneHRleU9sTmhSdWtZdWhwd3gzVEd6ZXFaTEVQZFdZb3FWaUtISkls?=
 =?utf-8?B?dDZJR1dIejMxUEJZdERlZlJ6bGZDWEtITHJjVzlMMVVqcm5iMnFTQ0VtMXpX?=
 =?utf-8?B?d05jWEtIY3dseWRrc0RURVhKOFc0YkU0Z1FXSGJoeU80bm9XZER0K1JFL2g1?=
 =?utf-8?B?Tkx5cWllcHlVL3VtajhuaGdjdFpCblpJUFU2NFh4aVcrV1Uwcm1BNW04VXEx?=
 =?utf-8?B?TncrczJ5clNyWVByTk1GYm9yQzZ1WDQ1N2dqRHN2T2NwY2JqeEtkNjJGTVNa?=
 =?utf-8?B?cDB0NU9BYzlZQ0pMc2ZSTDlaZjFadEtKU2hMeFc5aHYvRG83ZnlzZlNyN1B1?=
 =?utf-8?B?WnV2anp3azV3dWJEVXUzbXdoaFZVMEM0WDhrbTdkZlhIdXRaa0lDbWQ5V2FZ?=
 =?utf-8?B?ckZqMThUejVpUVdqMUI0bmNZbG43akRaQjVNOGpodE1YeTF0M28xaU1ZcEFC?=
 =?utf-8?B?VDhGc2NXcTlYOHp3VGRxbW1wMzhWYXd5bjJoSmJtWWpZUlZ6UkgrT1QvM0pR?=
 =?utf-8?B?OC9GYzdSenFxUWVvZnZqa0JpMFp0U2JINnQ2WS9LQkNZR2FpM3FCcWhPMDhI?=
 =?utf-8?B?UHlGdTA4U0YrS2Vkc0FJb2tPWE1jelVUWWRUOWNUSzl1cHoyUm5oeGhGRHJs?=
 =?utf-8?B?T2ZkN2w4TFU2NlRmRGJtWUFoM3NmamRvOG1qSUE1ck5wdGJKVkR0U2tKaTFt?=
 =?utf-8?B?eWRvc3oxMlkxTDJNYkFHUGw2T1haV0tJQVBIK1ZkQVZJa1J5a2dCeE5QV3dz?=
 =?utf-8?B?QVovblhQSmNDL2tEeGRnSlBUZ3BSRDVQVjhHM2tYZG05UmF0RTV4OGVxVnFk?=
 =?utf-8?B?blUrRFR0VWZpajBTblRpZUNiaEk3WE01bVllYy80MTh0b0p6T21CbjR2bkFJ?=
 =?utf-8?B?aE1SWC9xUlFGTlFpcW0rTU5aRGhtTEExZTdOeGNLT2pzdnZHdTlFaitXMEJr?=
 =?utf-8?B?N2Q4ajhKN0tIZGhjWFlVUk8wR3RmeXFhd05acTlFd0lJU29UOUJ0R3ZmTWor?=
 =?utf-8?B?ekRKN21jT0V5V25VenAxeFBoYmFBMUIxMUdBUnFKd1NRQms5OHpaTmswek52?=
 =?utf-8?B?QllsbzQzMUVsZlByOGVMek9SenNJYld6MWtKSjlhcXQ3RnI0dzk0bjQzT3lL?=
 =?utf-8?B?bDRCUkJWVmlpbGRZYitYVDM5R0tnNUQ1OEpIS05sQi9Ga2RWNUtTYjJKV1Qx?=
 =?utf-8?B?U250a24zZFlyMVFaVTNOS1hFbStXeFJldTBaZER1b3hDZGFwWVE4b25yNnJM?=
 =?utf-8?B?bVgveUxPRUIrT1c2QktoU3ZWUFd3M0NBc3pwYkwwMFNUUGhQVnhJT04vUEdR?=
 =?utf-8?B?bStqdDhUNGNxa0VCamZFQ1d2Y2VoR0g2QkVhcis3cEhkckYzR3Q4bW81a1lu?=
 =?utf-8?B?V1B5RWJEa2ZpOVVVQ242cWdTdGY4T1NyZDRhbG9QeFoyNTZhcE9NZEF3Rk9h?=
 =?utf-8?B?eDNLc3lJUmlxYzNtazJKeWZYK2dNRGhQZGMrSGpPVjhJbnBxUzhEY3J3dkww?=
 =?utf-8?B?YUxRMTUzRDFEUXZRTFF2RElNUDBSTG1GL3hnQVo0bXJKMW9zeWNqVVFhL2Er?=
 =?utf-8?B?TkpkcW1IZy9Md1RmTFlzb3N6Q1BsQm1KeUtyMDZtVjdnZXNzNXRmUHRTdjlz?=
 =?utf-8?B?MnZxbVNGaEZOUG50enJ6VWhnQTF5QlRNZlA4eitrbkhNS2VKNUo3WldWQjJQ?=
 =?utf-8?B?KzQxZWlybHNBVTluRFpDbHQ2azhCZ3dZK2tjL1pwRWM1THV6K2NxOUZKS0Y4?=
 =?utf-8?B?YzRkVjJpR1Z1VTJscEZZbUtGMTFXU3dLTzBDZ1o5L2plbzA4S1VuaUVaL1Rp?=
 =?utf-8?B?alZvWlVTbkJOdmlPM29TNVA4b29vYy9CUXBJTHY5bWpOVVVVQzlNTnFVQmRu?=
 =?utf-8?B?UDAwS0RBUkJSdzljc2FDMmNOTGFpRXhiQnIxbnNFdzZ4dW0zY0cwTFBzU0pG?=
 =?utf-8?B?OTZTRXNWd0RrUkMzeHNmR01ycnhsNjRSR2ZaMG9oU2h4NjhoTk5kb3c5MCtx?=
 =?utf-8?B?bU05RUFCLzgxd0Z2dFBSRTROZjFjQzJldlZtRDNaaUM2ODVGYkZyMHRmR1ZV?=
 =?utf-8?B?TGd1ZmdWR1cyempEMmQ2TE9pZVpYdVJpMzZ2dm5sVTB5M1A2TmdPa3JZUUc0?=
 =?utf-8?Q?SY2ZoqbR8Bp3sYnb0c60NR5aW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D8EA860EAEA9F4FA74E795FA7191BD5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 288c9135-c106-4984-4f09-08dd0ddd8e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 05:45:37.9022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtWIRyqxAOwnKw7C4MlqQFRZcAOaoOAladtLWizP/2NXtT03TJ5gLAyNYFx9o+trtQegJu5s5eDrCU7E2rP1dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8602
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.679300-8.000000
X-TMASE-MatchedRID: zGP2F0O7j/sNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCrfUboIp1QbVBfVY7O+c8KYHgh3sKJBzP0dmDSBYfnJR39l
	SYY/1iRtDdoDFICLaZusvuz7LvPblJS12kaJxXhED2WXLXdz+Ae3+iQEtoSj42viB/Jr4D1Tt8r
	FozbGqQE/vIztt9VZYkZOl7WKIImrS77Co4bNJXQ9ejiC/BQPd+gD2vYtOFhgqtq5d3cxkNQ18G
	AoWAE2v1KMIwLkId6FXglNXAYkwvfqvA+MpPY1cgYoPwQxIIcE=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.679300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	B4B20F178623B82FC9F780F053C3C9A2C792BE3C06F301D6C88D4ECE4A8B149F2000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ0ICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZp
ZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbiBwcmVwYXJhdGlvbiBm
b3IgYWRkaW5nIHN1cHBvcnQgZm9yIG5ld2VyIERQSSBpbnN0YW5jZXMgd2hpY2gNCj4gZG8gc3Vw
cG9ydCBkaXJlY3QtcGluIGJ1dCBkbyBub3QgaGF2ZSBhbnkgSF9GUkVfQ09OIHJlZ2lzdGVyLA0K
PiBsaWtlIHRoZSBvbmUgZm91bmQgaW4gTVQ4MTk1IGFuZCBNVDgxODgsIGFkZCBhIGJyYW5jaCB0
byBjaGVjaw0KPiBpZiB0aGUgcmVnX2hfZnJlX2NvbiB2YXJpYWJsZSB3YXMgZGVjbGFyZWQgaW4g
dGhlIG10a19kcGlfY29uZg0KPiBzdHJ1Y3R1cmUgZm9yIHRoZSBwcm9iZWQgU29DIERQSSB2ZXJz
aW9uLg0KPiANCj4gQXMgYSBub3RlLCB0aGlzIGlzIHVzZWZ1bCBzcGVjaWZpY2FsbHkgb25seSBm
b3IgY2FzZXMgaW4gd2hpY2gNCj4gdGhlIHN1cHBvcnRfZGlyZWN0X3BpbiB2YXJpYWJsZSBpcyB0
cnVlLCBzbyBtdDgxOTUtZHBpbnRmIGlzDQo+IG5vdCBhZmZlY3RlZCBieSBhbnkgaXNzdWUuDQoN
ClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8YW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHBpLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHBpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+IGluZGV4
IDM3OGI0OWI2YmRmYi4uNzk5MjNkMWJmYmM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RwaS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHBpLmMNCj4gQEAgLTQzMCwxMiArNDMwLDEzIEBAIHN0YXRpYyB2b2lkIG10a19kcGlfY29u
ZmlnX3N3YXBfaW5wdXQoc3RydWN0IG10a19kcGkgKmRwaSwgYm9vbCBlbmFibGUpDQo+IA0KPiAg
c3RhdGljIHZvaWQgbXRrX2RwaV9jb25maWdfMm5faF9mcmUoc3RydWN0IG10a19kcGkgKmRwaSkN
Cj4gIHsNCj4gLSAgICAgICBtdGtfZHBpX21hc2soZHBpLCBkcGktPmNvbmYtPnJlZ19oX2ZyZV9j
b24sIEhfRlJFXzJOLCBIX0ZSRV8yTik7DQo+ICsgICAgICAgaWYgKGRwaS0+Y29uZi0+cmVnX2hf
ZnJlX2NvbikNCj4gKyAgICAgICAgICAgICAgIG10a19kcGlfbWFzayhkcGksIGRwaS0+Y29uZi0+
cmVnX2hfZnJlX2NvbiwgSF9GUkVfMk4sIEhfRlJFXzJOKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMg
dm9pZCBtdGtfZHBpX2NvbmZpZ19kaXNhYmxlX2VkZ2Uoc3RydWN0IG10a19kcGkgKmRwaSkNCj4g
IHsNCj4gLSAgICAgICBpZiAoZHBpLT5jb25mLT5lZGdlX3NlbF9lbikNCj4gKyAgICAgICBpZiAo
ZHBpLT5jb25mLT5lZGdlX3NlbF9lbiAmJiBkcGktPmNvbmYtPnJlZ19oX2ZyZV9jb24pDQo+ICAg
ICAgICAgICAgICAgICBtdGtfZHBpX21hc2soZHBpLCBkcGktPmNvbmYtPnJlZ19oX2ZyZV9jb24s
IDAsIEVER0VfU0VMX0VOKTsNCj4gIH0NCj4gDQo+IC0tDQo+IDIuNDcuMA0KPiANCg==

