Return-Path: <linux-kernel+bounces-345574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A098B7A5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF52B251E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20319ABC4;
	Tue,  1 Oct 2024 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OPI5Erbn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Sq1sHn9k"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20C5589B
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727772930; cv=fail; b=CX9qi97PotZ2tVtO3eABZXVLipY+D8I+wEuON3XbZjHbCdPc7JHmU+mcJMBLivGEEChMqdBgeUiSaCTWKH31fPzrwh8OWheQfbpIzKEgJarIAwlTmiiHShgVNTCUgBxm0qlWNDkY1toCWGZHCSX24TyaZxfEA1bc8L+GFUNrF3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727772930; c=relaxed/simple;
	bh=tSKg6pI9GTektjVD2chKQLK3Y4iDJx4Mi+keq1PQCE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbNniV8oH50rDMenYN/aP9Z0BSEp1UGsekisd9J6RQB9NdkPsKOJnc4ysag5iMm09r4P3vxSdBkUS5uO2117tsDjlMVOxaryCFGq1Yw5OkVLugxXfMOuVl9aAUS1+cqzwBDR9NoDY60/QhX82P7WTN2s42bQCwbrOWhuaKVk/Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OPI5Erbn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Sq1sHn9k; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e3cf8dbc7fd211ef8b96093e013ec31c-20241001
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tSKg6pI9GTektjVD2chKQLK3Y4iDJx4Mi+keq1PQCE0=;
	b=OPI5Erbnf8RV5QkNnDMrqpHC/tlyMW5hahacmACHan7g89iKGNG6AyyLHSjYNpfmYLDuV4FylAJJVBQefenxSYzgIHJTzf07TEYWMqsq7XBbDTp30HYbxXTaSu+30Rw6q1/5ecAHXyk592Ewy5PHNcn16V2KGyTMMOnH8OM6rV8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:a03dc1af-78b2-4683-ae65-942af9dfc051,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6dc6a47,CLOUDID:190cd89e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: e3cf8dbc7fd211ef8b96093e013ec31c-20241001
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1249777926; Tue, 01 Oct 2024 16:55:21 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Oct 2024 16:55:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Oct 2024 16:55:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP9S7pRGeYAYEYHCyExiq5VaUKNEyeodA3Q6huIBcN0syiPG9hquywc+fhWPkAAW8tGqgLKt5HY3BZa1OCHEUwNnX3BIy2948b0byPlReqOSWUExdlCyS+7ImftfZCONNMDjTLuQx8hsIvncjtRfYtQ40LVgiVIDvLNNTusY6x+ay/r14047j9jWUx568WNfWxxcveyQ5f9wXjRxvFD8K4ulq+wgodev3Soxlya5f55a8SEFhlNnEdWT5DKfETGx/3yDYaP6uCTO+22VU24+RaYxuUqVJzF4X24w5TdOKUddb+NmJAs5jlQkoNuo1GIXzffNE0adaQsHShiADnuoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSKg6pI9GTektjVD2chKQLK3Y4iDJx4Mi+keq1PQCE0=;
 b=fCfQgH0mJlJUzU1u1Mx66gUtmFUlzH8LWOFKy/HlKVfQ9h5rja7j/uZlnZ5LdI+VGZJVjuKiV0P1TgRbCyPc6m+JWp2mGes6sDHS3FCFSqXcnPt23L22dSuyHE61rT64LWviTKhHCFf7SCA25aVHhBPDMJNH54ec2bs+I+FBRrBBbeTa6N3kIfGnCt1kS87BYKQHM1a8nUNhY1zPTUFYEzQtgh5DI3PQF58LkanjbhxMaQ3NHRHiHn/nzpj6gzHF+AtY1+L2IHff8HwcK0vd8wEF9WlZHsB0MVtuMlfIRnh4S5koZ20Q6zHX6qh6czuTTKBDC22EQycP9WPk2ZgWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSKg6pI9GTektjVD2chKQLK3Y4iDJx4Mi+keq1PQCE0=;
 b=Sq1sHn9kojKu+xyxgBQuBStQYsiS/LqwP7AUMd9il26ku8caEaEWj4upC/KhqQjgyVvYYlgkQ+6Py37XJqBYiIgdXDE8zVvtF2mgBXFg3ym6m6N337Vid+XDOi1l6ne8tPAmfl1Kc2WwyEu3DW+dwfBcOYU1g6tPETny4H9OC40=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7762.apcprd03.prod.outlook.com (2603:1096:400:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Tue, 1 Oct
 2024 08:55:16 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%6]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 08:55:16 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"djkurtz@chromium.org" <djkurtz@chromium.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"me@adamthiede.com" <me@adamthiede.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "littlecvr@chromium.org" <littlecvr@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: =?utf-8?B?WVQgU2hlbiAo5rKI5bKz6ZyGKQ==?= <Yt.Shen@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
Thread-Topic: [PATCH v3 13/14] drm/mediatek: Support DRM plane alpha in OVL
Thread-Index: AQHawmdvEtB+SJ4FzkOQjB5OmCWkarJxPRmAgAD9XAA=
Date: Tue, 1 Oct 2024 08:55:16 +0000
Message-ID: <49df03e8b982cc5ee97e09ef9545c1d138c32178.camel@mediatek.com>
References: <20240620-igt-v3-0-a9d62d2e2c7e@mediatek.com>
	 <20240620-igt-v3-13-a9d62d2e2c7e@mediatek.com>
	 <1a3af354-bd15-4219-960e-089b6a6e673c@adamthiede.com>
In-Reply-To: <1a3af354-bd15-4219-960e-089b6a6e673c@adamthiede.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7762:EE_
x-ms-office365-filtering-correlation-id: 06a19425-01f7-4b51-a44f-08dce1f6c54c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info: =?utf-8?B?YStXRGY1T0R1a1plbGR1eWdpd09oVWtSVDFBTThMZU53dHNsZ3BURkU4YzZh?=
 =?utf-8?B?OFN1enZhTlZucEx2bkhZVDZMZ1l3eGJmQWFvT0VseHRnWDcrWVdPTTZQbGRP?=
 =?utf-8?B?OGVhL2xaRDhlQzIrc2h2dXYvQTRraVJZV054ZnpqeDRINjlSTDlRVmdGVGo5?=
 =?utf-8?B?SVBnZkt0UVdGWGVndW1OSXNtajRxeWFBQjA5Tkd2ZDV6dUZveFFqbXNqZ1k3?=
 =?utf-8?B?L2tHdk51ZzhoZ3QwLzVudjhZQndPdWtuZjVXbG53dXk5ZzFUc3laNDh2b1Fx?=
 =?utf-8?B?VG5wMXJlVWs0aHpyTUc4REMyY1FwbDNGOTE0RTY4R1N0aGR0dGdJcUErdjY4?=
 =?utf-8?B?S05OUS95NmhmMGdHVmJCNnMwT0lEQWRIM0NhR2ttYjRIaG9wbzljejZ0Z0Q1?=
 =?utf-8?B?eGRCRG02WVlNSmdKNVpOdTI1TWFqT09QTXZHalovY2U0Zk40blFmSDMySXpU?=
 =?utf-8?B?Y0Vsc083VFNDTGMyRkVzOTQ4bjVXZFhQa05ycitCdEFySzk3WFVyVjhJemhy?=
 =?utf-8?B?WFZ2QWN1TzA5SFNRUmJrblQxamNzN0l5dHAxc3lzVEZxMGc0eVZBWlVoTDdC?=
 =?utf-8?B?MXp3TFJiaTcwaysrdmUrWStZVUMzYld5RXZnbnk2ODYzMWtZVEozZmIvZm4r?=
 =?utf-8?B?NkxaSVpMaUN3RW9ja0dtcFh4VksyK21pbnFaOVZ6N0ZXMERQSFM1Qi9zWHA2?=
 =?utf-8?B?dFZLdjRPMHpzTHdwOEI2VlRMTStCNThZQy9xVGYxbk05TTZzZlRxbllrdXQ3?=
 =?utf-8?B?eVZuTlVJSHh2UUh0UVlQcDg5TXVSa0RjbUFFRWM4NFExbGh4MHoyaUU2K3dW?=
 =?utf-8?B?a2NaNWJvR2NOYmFNRDRWeVJycFJvQUVJRGFmVnR6L0ROcVEyVFRDS2l6UTA0?=
 =?utf-8?B?Z2p6SSt3YVJldUVqWk1TN0JIOTV2bldqRGg5dGdSTmljMVhjZnErR3ZXd3o3?=
 =?utf-8?B?Y1NLSzNPUmpxZWMwVElVSWhpUWdmTEljUUNvRTJ4dGRUQjdLU240S1Eram5T?=
 =?utf-8?B?RmFPSHpnV0pMaWV0RGszMWpQL2hoQjRWckNjanl1SkN5VjJhdlkrb202MDBN?=
 =?utf-8?B?eHkrcy9oYUJhbkduSlpKYXlyZzFxUjBHTWZYSlJpdk80RVhva2NOWmJzcUZR?=
 =?utf-8?B?NGtBMDllT29FaGRPTURxVnVSdlc5RzFRbWVaUmpXWGtYT1R2YTZzUXIrKzZs?=
 =?utf-8?B?aXdiOWxBazF3VUwyOVkxUmtianFKUEthVTg2S3YwNlBqRnoxUXFnRnh5VlVO?=
 =?utf-8?B?Qm0vamppZlRDY3Q0VkYzdzlOTkFkelZoWldGSGl3d3E3bm8wb080ODRDVkVZ?=
 =?utf-8?B?bEMvZndXMmJBMUduMHVtdVB1MndrMURZR3dtN2t1QkR1ZlNhSlkxWVhHQmhw?=
 =?utf-8?B?L2k0QW42WkRIQlVFUE9JWkRaSkRpVUVPVkVEcVhQb3JWWEticmRFRXptYW9J?=
 =?utf-8?B?Q0NZNm9lemVsQWNxQ3Mra0ErSzNlODB2N0tzNnJWMFN1dFU0aDBaMXluT24v?=
 =?utf-8?B?Nmd5My9HaTF6dldiMG5YTlZzTFUvZE1WQWIraWpUMTB0QWJ4czFTbjFPQ0My?=
 =?utf-8?B?cDlQaUtldmtZUlNxTysxMXdGRGVJaFVnSFBvV2M2UFNEMHZmaFEyWGVTQTV0?=
 =?utf-8?B?OEZBc0VGNEQ1d0hXQm14YlpudVFlaXN1aDhhUGxxK2hBbERGaGpiaGdzend4?=
 =?utf-8?B?Q1ZZNzJReGFDeUdVMTloSTZ1K2NxUHAyZ0hwQ29WUzZ5NkNUK1NBSE1sMWlq?=
 =?utf-8?B?TW00R1lrWGJsUE9XRC8yTG9oQW82UjNSSzVtR1BBUG1BWGtaSUo2VTc2WTBC?=
 =?utf-8?Q?JfEOYp1cecsNK3/iFzLhhcrV/WqpVXBfEhuTM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2RpSHBKbkNoNTlYQThhbkNyRFphdnFPRldaMjZhR0VpTnBmMmgxbkZKM0RQ?=
 =?utf-8?B?b3pxaVVBVDcyeE9HaXFtdHlhNzBHZ1FpZHFIYTJIbmdvblRISlVqTVdubUtv?=
 =?utf-8?B?Q0pLZ29JOGtJQzdwS21kdU81K3VOS1hYeHRNUC9udWpkc0x6TVp6RzNnb2Ny?=
 =?utf-8?B?VkRuRG52ckNTV0ZZbUNsbHZwSE1nRFU0ZkNDRFpycHNUeFFqS0FocDVuV3d6?=
 =?utf-8?B?MTdOTnhvMW1TamNpM1gyTDFzVDBYd3RHTnA5aVYvTW5nbU5HL09iYjgvYkxU?=
 =?utf-8?B?d3JtUGNKdGxLR0R5NUQ0YmlIS0U0U2o2d3g4cnlHSGFUNzBFdm45eXRtck12?=
 =?utf-8?B?VUd2a1A0VjJ5amh6SkZOVFFhNXU5WnZvYjBPSS9WbzFKaXJzU1N2UGRjd2th?=
 =?utf-8?B?MTNlKzRwdG9KdEZScjJRZkswdnVDcjB5cnR3K1F5c3A2MEk4VjU4c0ZDMEF2?=
 =?utf-8?B?c2ZiVlBnNXczcDhvOE05QlhveEFLOTZCc1ZialZHQWcyTCtoTEJXRnlhelVF?=
 =?utf-8?B?LzZpd0haTXcvOGJLL0J2KzF4Vm02N0pOcmc5MWZaMkdiTHpnaXEzWmM1RDRk?=
 =?utf-8?B?N2Zid1dZRG5kUEJERHBxSWprc2xLUUNxREMzL2hwYVBoOXJ0dVR2TUV1bFQw?=
 =?utf-8?B?RysrcVBRS2c1TnVLenRVNEVCSUFlR05OQy96b0lWUEU0MngyNHpBS0VuOGJD?=
 =?utf-8?B?REYzQlkxWFFGazR1dHZieElUWEFRSi90YkNJeUxVQWNQWW9MVDBJZXpvN1Vu?=
 =?utf-8?B?NXVCY1JnaHlndGZiOUJxNlFNY2hqU2lzTXlVNU5Od1lhb2ZEdU9hNVFLNzFG?=
 =?utf-8?B?SGZrR0t0VjFtbXlYQjVjRHlGQ0JPVzRYWnBUeXJBWE5jajBQaWRFUkJ0d3RK?=
 =?utf-8?B?bnV3bXdZenVxdkE5VTBjV056OE43NFJoNWJudmFSMGNIMDN5Z2I0WEcvQWxK?=
 =?utf-8?B?SjBUeGJnZmpwVWRXbGpaV0xHVk9jbW1ueERYTnpFNGFyVGxXR1lpWVZQRUZ2?=
 =?utf-8?B?aWFFem9lMU5MZjFmUnhpbWRnZG5xRTNMSVJmM0tYVjNQNDcyT2VVUFIxMDJB?=
 =?utf-8?B?SGprVFkvclgyY2duWWxiZ2VlMDdXK05NOVovdmNNUkVXd2RIcXpaM2R5a05v?=
 =?utf-8?B?NE5rWDdjZXZhYmtNeFZuSHlOMnZMV3Z4QkJsTzFIQWNKTlRhM3kzWXZDRTNu?=
 =?utf-8?B?dk5lSkZremRVVWdaY3FTRmRKaWFKbWVWUXNHQXRJZE5XdTg3LzRlN3lmaWJ0?=
 =?utf-8?B?K1gvb0xqZExjdzF1aFY1YjJOZitwcjFwL1hhQS9GNzhzaXJhVk15REpsTktq?=
 =?utf-8?B?ZkE5UTlpbUJFcVJHSWs2YzFsMkRiTmFNU2FMQ1p5a29aOER0ckdlWVR3b2p6?=
 =?utf-8?B?b1JrUHFTQndLczFyWlM3Z0pIQ1VERmVyQ0pseGdMUlJVa013MjgrQkFVd24z?=
 =?utf-8?B?NlZCdXpmdm50cU1KV044cVdEeHNkL0pvUTdld1pheU8yUzl4NlhtcTdBNk4r?=
 =?utf-8?B?Rld3elJKQzZzdStYTHI0a0E3NmVXQzg1eklVRXJXNkFGWHFWWHlwZkdkd0ta?=
 =?utf-8?B?ZEEzNVlrWmhGSlhMOXRkNERTbUJIT0IrbmNlUEJydEo3NTNxZmhhN3RxU05Q?=
 =?utf-8?B?andaN29FcjB5UjNOdDR3Zi9DdWw2Z2R1amRsR2NIQUphQklOYWZWSXl3Q3du?=
 =?utf-8?B?YVF6aHMyZjZNQTBzNENKa0Z2ZEFNdjhpQ1RHVEp1SE9KQ2hFYno4Y1k3Tjh3?=
 =?utf-8?B?OVNpSExYS3ZQdzF0dXRxYUpGRDEzam95c0NSMTROZGlDaFoyVE5DV1o5eWNW?=
 =?utf-8?B?MSt3amN6SDV3SVFwSitUQ3pHZUk1cUw0cUhLaWRBRmthNS9XSUM1Z3RYNzNW?=
 =?utf-8?B?cmd4VDc1WDFOTTlaVjBEZmN4UkdYVDFtVVF3MVRMWUtTdU1WaHBsaEdVL1U0?=
 =?utf-8?B?TWJQbmtRT0VPTThsMGkxZmhidEo4aHlqbDJpdFBScFZ6c3VGZ0RoSkhGbUZO?=
 =?utf-8?B?L0FMWG1BVmw4QUpRRHMvdXlHQ2craGpCdmtyMU44OUdSNkoyYzYvWnFIRy9E?=
 =?utf-8?B?K0V3dm05elFWalA0N0JTUCs3MkhlaGU2Y0JNNWcwd0VSeTdMUlI1MzhteHpL?=
 =?utf-8?Q?P2REuJq+yHG0Xxu863HuEvMRb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DED484C8A841E74D805FD8902B9FD9E4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a19425-01f7-4b51-a44f-08dce1f6c54c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 08:55:16.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0pU6VE+7uvZnOcc4k+hqm575CTDGas4UjirLzrh1rZoeoybaXx/1CAdHYDOxwBkGYAOlTbg1GbNkct4jvoTVSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7762

SGksIEphc29uOg0KDQpXb3VsZCB5b3UgY2xhcmlmeSB0aGlzIHByb2JsZW0/DQoNClJlZ2FyZHMs
DQpDSw0KDQpPbiBNb24sIDIwMjQtMDktMzAgYXQgMTI6NDggLTA1MDAsIEFkYW0gVGhpZWRlIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIE9uIDYvMTkvMjQgMTE6MzgsIEhzaWFvIENoaWVuIFN1bmcgdmlh
IEI0IFJlbGF5IHdyb3RlOg0KPiA+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdA
bWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFNldCB0aGUgcGxhbmUgYWxwaGEgYWNjb3JkaW5nIHRv
IERSTSBwbGFuZSBwcm9wZXJ0eS4NCj4gPiANCj4gPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1
QG1lZGlhdGVrLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVn
bm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiBGaXhlczog
MTE5ZjUxNzM2MjhhICgiZHJtL21lZGlhdGVrOiBBZGQgRFJNIERyaXZlciBmb3IgTWVkaWF0ZWsg
U29DIE1UODE3My4iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXdu
LnN1bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bC5jIHwgNiArKysrLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+IGluZGV4IDk0M2RiNGYxYmQ2Yi4uNGIzNzBiYzA3NDZk
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+
IEBAIC00NTgsOCArNDU4LDEwIEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRl
dmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gICBjb24g
PSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0KPiA+IC1pZiAoc3RhdGUtPmJhc2UuZmIgJiYg
c3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiA+IC1jb24gfD0gT1ZMX0NPTl9B
RU4gfCBPVkxfQ09OX0FMUEhBOw0KPiA+ICtpZiAoc3RhdGUtPmJhc2UuZmIpIHsNCj4gPiArY29u
IHw9IE9WTF9DT05fQUVOOw0KPiA+ICtjb24gfD0gc3RhdGUtPmJhc2UuYWxwaGEgJiBPVkxfQ09O
X0FMUEhBOw0KPiA+ICt9DQo+ID4gICANCj4gPiAgIC8qIENPTlNUX0JMRCBtdXN0IGJlIGVuYWJs
ZWQgZm9yIFhSR0IgZm9ybWF0cyBhbHRob3VnaCB0aGUgYWxwaGEgY2hhbm5lbA0KPiA+ICAgICog
Y2FuIGJlIGlnbm9yZWQsIG9yIE9WTCB3aWxsIHN0aWxsIHJlYWQgdGhlIHZhbHVlIGZyb20gbWVt
b3J5Lg0KPiA+IA0KPiBIZWxsbywgSSBiZWxpZXZlIHRoYXQgdGhpcyBjb21taXQgaGFzIGNhdXNl
ZCBhIHByb2JsZW0gZm9yIG15IExlbm92byANCj4gQzMzMCBDaHJvbWVib29rIHJ1bm5pbmcgcG9z
dG1hcmtldE9TLg0KPiANCj4gV2l0aCBrZXJuZWwgNi4xMSB0aGlzIGRldmljZSBkaWRuJ3Qgc2hv
dyBhbnkgdGV4dCBvbiB0aGUgdHR5IG9yIHNwbGFzaCANCj4gc2NyZWVuIGR1cmluZyBib290aW5n
LCBidXQgZ3JhcGhpY2FsIGVudmlyb25tZW50cyAod2F5bGFuZCwgeG9yZykgZG8gDQo+IGFwcGVh
ci4gV2l0aCBhIGZldyBiaXNlY3RzIEkgZm91bmQgaXQgdG8gYmUgdGhpcyBjb21taXQuIFdpdGgg
aXQgDQo+IHJldmVydGVkIEknbSBhYmxlIHRvIGdldCB0ZXh0IG9uIHRoZSB0dHkgYWdhaW4uDQo+
IA0KPiBUaGUga2VybmVsIGNvbmZpZyBpcyBoZXJlOiANCj4gaHR0cHM6Ly9naXRsYWIuY29tL2Fk
YW10aGllZGUvcG1hcG9ydHMvLS90cmVlL210ODE3My02MTEvZGV2aWNlL2NvbW11bml0eS9saW51
eC1wb3N0bWFya2V0b3MtbWVkaWF0ZWstbXQ4MTczLw0KPiBUbyBiZSBwZXJmZWN0bHkgY2xlYXIs
IHRoaXMgZGV2aWNlIGlzIG5vdCBydW5uaW5nIENocm9tZSBPUy4NCj4gDQo+IEknbSBzdGlsbCBy
YXRoZXIgbmV3IGF0IHRoaXMgc28gaXQncyBhbHNvIGxpa2VseSBJIGdvdCBzb21ldGhpbmcgd3Jv
bmcgDQo+IG9yIGhhdmUgYSBiYWQgY29uZmlndXJhdGlvbiBvcHRpb24uIElmIHRoZXJlIGlzIGFu
eSBtb3JlIGluZm9ybWF0aW9uIEkgDQo+IGNhbiBwcm92aWRlIHBsZWFzZSBsZXQgbWUga25vdy4g
VGhhbmsgeW91Lg0KPiANCj4gLSBBZGFtIFRoaWVkZQ0K

