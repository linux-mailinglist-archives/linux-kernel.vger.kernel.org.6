Return-Path: <linux-kernel+bounces-432525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9AE9E4C7C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 03:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31D528359F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 02:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945E17B4EC;
	Thu,  5 Dec 2024 02:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HBTWDD4m";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="px4M1mzq"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EB61891AB;
	Thu,  5 Dec 2024 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366943; cv=fail; b=W6JzZqPBfhAId9MriCJkUtFbk2v+KT9Ulmy+khMLLs3zrBgp5JOKvJs8kemW2SBWb2s7etfH290a4yX3A1lRabsol2BGW5N5aHHAgAvx40dKSEZCpCrHHP6atpTMMt2lLnhNBKQW+3+5WK1Yj+l07qwcxknSVBoIpFYxPAXF5ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366943; c=relaxed/simple;
	bh=jbo++GG8bOSgpfgUa80gAmSPuMcFddkb90rjPEMJw3w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tUO77mgbRaz20mdTih7fHvZScs93qzSh5KbRPI3Gev/FCj70niSea5mxnCbzxPYHCOGt2YhFEXmnnXvZjo/S62++2lm3CKO0lrWOY9KszUUcPH8s8BDv/nP6U6QFBSnjypElF1uemQPBuRP9qwvlg3KxKghspd6Ik3SqdILySL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HBTWDD4m; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=px4M1mzq; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 77bcd5eeb2b311ef99858b75a2457dd9-20241205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=jbo++GG8bOSgpfgUa80gAmSPuMcFddkb90rjPEMJw3w=;
	b=HBTWDD4m8hV1t0tT7XyPCH6eNRzDmU3WCkbDf2wbU3NjVQyZEQ0V3ckz7MLacB71ZuMORsubgvwCBlduNua9J9WoEFwmzgP85Gn6b4giIp8h9QyOqxopn79pPELLe7WH8GtmeQnDqIXQ8DU6HrcW2BaakRATHXv4kAPXYY60o2k=;
X-CID-CACHE: Type:Local,Time:202412051042+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7da6fc58-b08e-444a-9d9f-ff4515203bcf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:c16b743b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 77bcd5eeb2b311ef99858b75a2457dd9-20241205
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 543248627; Thu, 05 Dec 2024 10:48:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 5 Dec 2024 10:48:53 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 5 Dec 2024 10:48:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9gjmuv3bg97sTKZmA8nuyauaRdYPMDSxjJ03Rk2+nj3KrNaxOJUDpCU+zcDyzDAE/7X/7iavbVGpH5OI+yKycIC8UYgP3DyKif/8VszKOXC+RfSlOX1+3XG7Hsoi/xUwh1DpzfGDsYlA2/BWAxMyl+dLPJzRdPJUuTKJW6fnUAcpx+LYXwLxJuojwKQa1g8+RbUb1/a84skEnwBD1swZDHLkSHOied5a0gg0+13BCsBIYZCJrwhLhFmC7NBYBGUYFb+TZfOymz+cgLEsBH447EMTNcWXWPVJbkAQAUsVlqUY7zj4Nje375CrBL5osFUYJxY1JbYSXXpI0zJrnNVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbo++GG8bOSgpfgUa80gAmSPuMcFddkb90rjPEMJw3w=;
 b=u6umb9vGnE72gzKWwMRt+L3wEVDNk1eQwMqlfb2Iy5sRrmk+IVVF0+EdHFFQgJ3kvVVuU6gxL0WpQIF5qlEkuz+hiUKpo+1Wa5pgb5Ac+Ni7DLJSio2sRR/62UO07Ux/fiI0V9hnAz0uTfYmnw9mNoA4Lj52rjH/LhwLZzJ8PAY+FXgWUy6xbWDGEEHgqhQ8amAIE+yS+rni2abj7ifTpvtbmPFVVwDOvvheN2Ul4TcRr4XFVts9mhQ+XEwwi3nQfrPIe0IJurb3dE4nD2/03iCVg4ZZ23r0JWX2lLwC43J3Ckhs2r5k3H+kw0U3r3HlNkrKVNYPXQjm55+TIWwIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbo++GG8bOSgpfgUa80gAmSPuMcFddkb90rjPEMJw3w=;
 b=px4M1mzqY4i43WqS+3QJKczQGZtU0bzeth60RNw7T4bkBA7QQjEQaRAvYjWiM1CQhFNcnB/eftpVKGztJWmSxdlqOJEBer+GxW85c81pLNvHPVDvhdZr/ioNYijF41K2DMS8c6je3oQMh0DaX2Apdpo+plg7o05YHrFNRsQ8714=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7910.apcprd03.prod.outlook.com (2603:1096:400:481::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 02:48:51 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8207.014; Thu, 5 Dec 2024
 02:48:51 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Topic: [PATCH v1 7/7] drm/mediatek: Introduce HDMI/DDC v2 for
 MT8195/MT8188
Thread-Index: AQHbO0pF3Zp6UXdpSEmkHbI6wNkmT7LSoNaAgAOetwCAAMhiAIAAAekA
Date: Thu, 5 Dec 2024 02:48:51 +0000
Message-ID: <8c34c5a6cc2217ffc1a2d9881f20708e8427ffe6.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-8-angelogioacchino.delregno@collabora.com>
	 <559ac08df6614e47c3e8d9d8160b35c9e683c503.camel@mediatek.com>
	 <716b8630-66ef-4497-8cba-d5d20da2382a@collabora.com>
	 <6bba26909f2fe0686c2584536f7a080451f768a1.camel@mediatek.com>
In-Reply-To: <6bba26909f2fe0686c2584536f7a080451f768a1.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7910:EE_
x-ms-office365-filtering-correlation-id: aec5ab57-77cd-48c3-5ad8-08dd14d759a5
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bkQrdXJUbTRuSk55VldmR0lhUDJnVU1ETDdzWnZlUGUwcDFzTkJNcGFCREtw?=
 =?utf-8?B?S3NsM3dHQXQ0SjRSY1NzU1g2SVV4RUFndjNDaE9zQ21Pd0hWK2RNd1BjamdY?=
 =?utf-8?B?aWNiZDcweTVmRUhiMDk0d3NVcWRYeFRxeGhLa3QwS3pqOTYvZjFWc1doS3F0?=
 =?utf-8?B?R3hEaG05RzFEbGtFYTVCajVvNlcyWHJ4SW9kanBNUWdkamxWbXR3elFxdXRW?=
 =?utf-8?B?WURCaTBicWVTV1BNK0ZWODY1UkVHVE9LYlZOOWxoZnBJUVVNNnpVck4yMUto?=
 =?utf-8?B?K2drWmlldFdNV2JwSjJsZWE2ZGpnN0JqaVhPMEU5bW0xbWVpazcvQ1NTWXhh?=
 =?utf-8?B?cWZ5Zm51NkFrbjRqZDVUUFFKSjBqTDFTd2VmYktmYld4cVZjL2tNNkU1T1Mv?=
 =?utf-8?B?dzBFbG1waHQwR2pkcXhNU1owQ2F5bWdYbWdXYnhLTHM5TlBtVExkUUZFYjZT?=
 =?utf-8?B?S2ZmQnBkMmRKYml0OW9GdjAxaXJlbWxVN01PS3h4aDhhemh5MkpXYVUyZ0NK?=
 =?utf-8?B?Wkx1ZmlQQzVjeXJqYWlzNnJMRHp5UHhGdi8vaFZEUEtCQTNnSHFMRStjbFh5?=
 =?utf-8?B?eVJMemF6d0JZNXNuTDJtcEtvZTYwbWxqTTRaUlpwL3VuaHZRSDFmZ0VydWdX?=
 =?utf-8?B?eThVSm9wdE9sWFhzRzJxalpyZkdBT2IvclJRQnVjZjhXdmtGT3Q4NXRjNGJk?=
 =?utf-8?B?UDNqV3doM3oyK0lad05GNmFpZmVRTTVXZEVxdDV0MEhwRnZLSWc4ZDNCZXJQ?=
 =?utf-8?B?WlVRNEtlSHJzTGZ0ajY4ZjBvd2Y2N2hCWDc0TE1PdFZGeVF4dTQ1YUs1R2dY?=
 =?utf-8?B?SzZhc2RQREhsdEpwMmhwTzBMNzgrbzJuVXRTSUF2ZVBtakFCVHdRN1JpQzNq?=
 =?utf-8?B?UjRMUHhSZlJpOHpoMm5acExuaHVlT2s2bUpwZmFQVFJQQ1ozTDlqOE1UbGtU?=
 =?utf-8?B?YlhtaXlCVHhSYmpWWnBNZXJCMUhUNnlaSDRBdVR5Ky9tVXZMc0RXcVBDYnNv?=
 =?utf-8?B?WnA2dHpXQ1hSczIrVDBLOGwwZHMxWXo0WnRCc1ZpdzFpNTNpOExmd0xyUmcv?=
 =?utf-8?B?czBoWWdvUFFjdmRyS0tBL0p1cVZzUVVXc0xqOXZsbzRpc1VqK3ZRMXJkUXlN?=
 =?utf-8?B?bENaaURDUW4zam9INGZYYjdGR2czWklCWWJFVmtuNWZlT0lxS0pBcjBKR1dP?=
 =?utf-8?B?a2N5S092U1RGQUVMTUVYdXBKVllvU0Erb1lGSkRwUmo1bVFRME5yVWZ2Mm9Q?=
 =?utf-8?B?VDdtczhpaitVSTVibmp5eEQzMUxTeUR5Y0F5SXpvWVJHckFwb2pRSXNkQ1FV?=
 =?utf-8?B?ZTc5bzhRNnZEcjU2U2lMZlloNitwS08wbVVTQytPR1NlYW5pWEpZc2I5N3h0?=
 =?utf-8?B?bWFYRGxiMm1tVUI5OGE3SExoNnJLckRCcTF2UEtsbTdBdkRwMWl1Vk5pRDhp?=
 =?utf-8?B?WWJnSytDZUgyWXVIN2hFbUlqNGhkREc5TUZaR1VHMTFtNFM4aUMrdmk4SHM3?=
 =?utf-8?B?RmQrWWlWQU9KNVhZZjQ4eG1udTc3ZUgxOVNnVVZnOVZWNXpRNDVjRi9wa0hO?=
 =?utf-8?B?MHVpSUFSbkpUQm9pTkpQdFhuRVVHdGlJeTNiRU5sL1pWSmRpOXZRNmlIVmZa?=
 =?utf-8?B?Z1BwUndWODVlWG0yMGY5UDh5S0VyL0hqTFVKSm5XcUdjYmMzS0hrOFFqWmlQ?=
 =?utf-8?B?QnV1VmYzRG82bnlWOXlzaVNubDFNZXk1bWZWTGJDeU5pNmp0c01qNWFWRW5N?=
 =?utf-8?B?aDlUOVA2QWFVZEI2MjZLYXBMd256TlZEY3EzY0plSEppWENrblErWmJaMUFv?=
 =?utf-8?B?KzRkTE9CNnI5cmdXdDJRenNRUHRTQnRTdjZoL3J6MmJjWUZSSGc4bFkwT2t3?=
 =?utf-8?B?TWdUZVJ6akdCb1BHVnNPNmpYZzVrSmJON2t4cDBxMnhYckE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHovZjhjYlJ4R0piRElqckhQU0Q3alRzYUJ1WXh4Nk1YUUc2d1R2T3p0Yitk?=
 =?utf-8?B?RlZBaitBTEFSaVZ3akc1UEd5TzQ3YkczRitmNU1XZDB3VDFaQ3h4a2llNmt6?=
 =?utf-8?B?em10MVhxTWs0d0EzWkNRbnk0VVlLR1p1blRXYkxWZWJqNWFMdUg3bVlMNVhL?=
 =?utf-8?B?VTRoQ1ZldUFZZnJxQ01URkhQSVVueXFYVUI4aUkvSFJjRExsaEsrRndkUkVO?=
 =?utf-8?B?d1YvYXBXejlTcEw2cEc1TkY4MHAyV1lSSVRRVTcrQmtOcm5KZXptY1BqQ1kv?=
 =?utf-8?B?dVMzSTMrWFRTSjlscWQwU0lFSEE2Y0dEYlorSGhydWZBblBteXZTTXEwbW9V?=
 =?utf-8?B?ZlpHNlAzK05tejhnUnhYOFU2NU9ZMlJUUU9xVGttWi9EdVo5VjBOZFNnTk84?=
 =?utf-8?B?ZUJ6SUZMWkdZN1RrOWJWS1RCQVhMVyszMEdQTERNT3lvY2NOVS93dFo3YndM?=
 =?utf-8?B?ZnJmRHYxcHg1NS9talY4QU50SHUvQzVyM2x0NTY1Y25zS1Z0Y2Z2TDhiMnp4?=
 =?utf-8?B?amRyRlkva0pMeG5hZmp3Zm4vaVJybEluNWRnT3lxN0lOMmhtYXJlZ3hYT2tv?=
 =?utf-8?B?KzdyRk1COTZzZWdyT010T3NzQjlkYkE1NDlNcllRMFdyelhHZDhweTZNaE9j?=
 =?utf-8?B?SGo0QTNaM3kzMjc3dDRKcU5pc1BVSE1sbWI4WndkNUNqZU94eDFuZzA5NXZw?=
 =?utf-8?B?NkpiRlhUSFh1R0F6aTN1c1hYcFJlUVp4ZGhRRWJpQWhVR0lHT0NJa0cxTy8x?=
 =?utf-8?B?Si9TWG5MZi9NMEluZkxNVnVjQ3dGR0JuV1BRRU5wWmZBRElteXB1TlA1RStM?=
 =?utf-8?B?TDlTVDVqUWg1TFpKOXVNOU5wQnhHc21DcUxBbStTeWtMQ3BrU3RKTld6Nlgx?=
 =?utf-8?B?VzRsUDMxRHplOFhDUVV2K3dCZUtNSDlRZ081NktMbjY1ZkhwaGVsVkxsL0Mr?=
 =?utf-8?B?cmdITzBzN1FETC92N0JXUlUrRTNCQ0Nuem5veXB3NFU3b0R6cm5GQXZnanla?=
 =?utf-8?B?a3IvdVdxSm1LbEt0V2plSlJia1hHZW1qdCtBMVdHdEJFVDBQRHFWMmpxVkpO?=
 =?utf-8?B?bkZBa09pd0doM0dWazJrelRpd2ZxMExKTU9LaEhMYUswc2ZQR2ZHanNCZ0da?=
 =?utf-8?B?RDFxZ0pTZXduSGpSajh5b0puSkxpcWN4SmoyT2J1cVYrZHVoYjlHeTQxOEho?=
 =?utf-8?B?akR0UFJ2N3d3bUFpeXltQW55aDJMSmhsdVk1L1lWRTR2VTZhVDZUOXgyZFR2?=
 =?utf-8?B?eU5IbVdteFRlQ1U4WnBCcGR2MXFxUDhGYXY0OHZybURpVVdpYlZMdXVqc29B?=
 =?utf-8?B?WURlRXNFRmwrMjRkbmxWZmlGVnp2RXpWRXlZSmxSaXJrTzZraDRGbEd6UFdW?=
 =?utf-8?B?b0ZmT0ZuRHMzYWE3UkZUQlRaM0JhWkM5SlphZzBSS09FQ3BwaTFaU3pyWG5C?=
 =?utf-8?B?ajgvSW9wUlhiMUVIbFh6c2F2QmhUaVB2eUNNVU8vTWZsY2pLa01GR0JpY2FH?=
 =?utf-8?B?QzZGOGlXNkhud2RSZXlYVjF2TEttajNMbDBMdWJ0VVNReGdGYWFBRFExaUJs?=
 =?utf-8?B?SDZpZ2hwRFVpdXVlS2tCU05BTHo5eVdKRVU1YWlQL2FtcUkyQ3dSeHNSVlps?=
 =?utf-8?B?U0d2dzVmckZITlN3enRVcDFzSkV2RnFCd3dRTzhsSjlkUy85ZkZsbGdoUHoz?=
 =?utf-8?B?ZzNyTS9yRE1ubnNicnJONXNjOFBXWGIydEFuT2cyVHFoYmttbzFGVU91Qkp0?=
 =?utf-8?B?RVMzZEU3UFIzbno0MVRBMFdpcStVenhNN3IyVWs0cm5pWlE1MFEzRjU5dW4x?=
 =?utf-8?B?WEc3cUg3YXVXU0xVSWNvcWhQdXVYNnM2bXgweUJsU3ZrcGRJMVhzVVlTb29J?=
 =?utf-8?B?YTllRXdPWHZJaHFCdUozKzMzWDg2SnJRc0NhdVM5RUFnTG9JWVphVnJvdEds?=
 =?utf-8?B?Vm9uTWxZWmFtTDBTRTdhbXlLWjFENHRRSlhvcXJSQWNUQXpCUUl6U2pIK0l5?=
 =?utf-8?B?akZtN2tia082N0xKY2d2dDRGMFgwV3pzV3VQc0RkTDBzMTZnVzQyUW9PM2xV?=
 =?utf-8?B?dnhvTnl1OXpjdFFEOTMyaWNQK1RaVGdxR0dkQzhiekQyOFVjd0NBU0czQVVJ?=
 =?utf-8?Q?f3ty5hjIbr+qVyQ5dCRq5jWhl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC64AB9793559A45AF279B92D3CCB86D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec5ab57-77cd-48c3-5ad8-08dd14d759a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2024 02:48:51.0756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPM5wvJwmJHJZ31Zcj5sdNbY4Kdo0/QO1MfoUGDws9QJLLur1jHuVAmaRuax6pSzxq5Jjhyk/BB/911llUFefQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7910

T24gVGh1LCAyMDI0LTEyLTA1IGF0IDEwOjQyICswODAwLCBDSyBIdSB3cm90ZToNCj4gT24gV2Vk
LCAyMDI0LTEyLTA0IGF0IDE1OjQ0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3
cm90ZToNCj4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiA+IA0KPiA+IA0KPiA+IElsIDAyLzEyLzI0IDA4OjI3LCBDSyBIdSAo6IOh
5L+K5YWJKSBoYSBzY3JpdHRvOg0KPiA+ID4gSGksIEFuZ2VsbzoNCj4gPiA+IA0KPiA+ID4gT24g
V2VkLCAyMDI0LTExLTIwIGF0IDEzOjQ1ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byB3cm90ZToNCj4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiBBZGQgc3VwcG9y
dCBmb3IgdGhlIG5ld2VyIEhETUktVFggKEVuY29kZXIpIHYyIGFuZCBEREMgdjIgSVBzDQo+ID4g
PiA+IGZvdW5kIGluIE1lZGlhVGVrJ3MgTVQ4MTk1LCBNVDgxODggU29DIGFuZCB0aGVpciB2YXJp
YW50cywgYW5kDQo+ID4gPiA+IGluY2x1ZGluZyBzdXBwb3J0IGZvciBkaXNwbGF5IG1vZGVzIHVw
IHRvIDRrNjAgYW5kIGZvciBIRE1JDQo+ID4gPiA+IEF1ZGlvLCBhcyBwZXIgdGhlIEhETUkgMi4w
IHNwZWMuDQo+ID4gPiA+IA0KPiA+ID4gPiBIRENQIGFuZCBDRUMgZnVuY3Rpb25hbGl0aWVzIGFy
ZSBhbHNvIHN1cHBvcnRlZCBieSB0aGlzIGhhcmR3YXJlLA0KPiA+ID4gPiBidXQgYXJlIG5vdCBp
bmNsdWRlZCBpbiB0aGlzIGNvbW1pdC4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9hY2NoaW5vLmRlbHJlZ25vQGNv
bGxhYm9yYS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBbc25pcF0NCj4gPiA+IA0K
PiA+ID4gPiArc3RhdGljIGludCBtdGtfaGRtaV92Ml9lbmFibGUoc3RydWN0IG10a19oZG1pICpo
ZG1pKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgICAgIGludCByZXQ7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICByZXQgPSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGhkbWktPmRldik7
DQo+ID4gPiANCj4gPiA+IFdoeSB0dXJuIG9uIHBvd2VyIHdoZW4gYXR0YWNoPw0KPiA+ID4gU2hv
dWxkIGhvdC1wbHVnIGRldGVjdGlvbiBiZSBhbHdheXMgb24gc28gcG93ZXIgb24gd2hlbiBhdHRh
Y2g/DQo+ID4gPiBJZiBzbywgbWF5YmUgd2UgbmVlZCB0byB1c2UgQ0VDIHRvIGRldGVjdCBob3Qt
cGx1ZyBiZWNhdXNlIENFQyBoYXMgbG93ZXIgcG93ZXIgYW5kIEhETUkgcG93ZXIgd291bGQgbm90
IGJlIGFsd2F5cyBvbi4NCj4gPiA+IEFzIHlvdSBkZXNjcmliZSBwcmV2aW91c2x5LCBDRUMganVz
dCBuZWVkIHNvbWUgaGFjayB0byBzdXBwb3J0IGJvdGggSERNSSBUeCBhbmQgSERNSSBSeC4NCj4g
PiA+IFNvIHRoZXJlIGlzIGEgc29mdHdhcmUgc29sdXRpb24gdG8gdXNlIENFQyB0byBkZXRlY3Qg
aG90LXBsdWcgaW4gYSBsb3dlciBwb3dlciBtb2RlLg0KPiA+ID4gQW5kIHYxIHVzZSBDRUMgdG8g
ZGV0ZWN0IGhvdC1wbHVnLCBzbyBpdCdzIHdvcnRoIHRvIG1ha2UgdjEgYW5kIHYyIGhhcyB0aGUg
c2FtZSBiZWhhdmlvci4NCj4gPiA+IA0KPiA+IA0KPiA+IEFzIEkgc2FpZCwgd2UgY2FuJ3QgdXNl
IENFQyB0byBkZXRlY3QgaG90cGx1ZywgYmVjYXVzZSB0aGUgc2FtZSBDRUMgY29udHJvbGxlcg0K
PiA+IGNhbiBiZSB1c2VkIGZvciBib3RoIEhETUkgVFggYW5kIFJYIGF0IHRoZSBzYW1lIHRpbWUu
DQo+ID4gDQo+ID4gSWYgeW91IHVzZSBDRUMgdG8gZGV0ZWN0IGNhYmxlIGF0dGFjaCBhbmQgeW91
IGhhdmUgYm90aCBIRE1JIFJYIGFuZCBIRE1JIFRYIGRyaXZlcnMNCj4gPiBwcm9iZWQgYW5kIHJl
YWR5LCBpZiB5b3UgYXR0YWNoIHRoZSBjYWJsZSB0byBIRE1JIFJYIHBvcnQsIEhETUkgVFggd2ls
bCB0cnkgdG8gZ2V0DQo+ID4gZW5hYmxlZCBhbmQgd2lsbCBlcnJvciBvdXQuDQo+ID4gU2FtZSBo
YXBwZW5zIGlmIHlvdSBhdHRhY2ggYSBjYWJsZSB0byBIRE1JIFRYOiBIRE1JIFJYIHdpbGwgdHJ5
IHRvIGdldCBlbmFibGVkIGFuZA0KPiA+IHdpbGwgZXJyb3Igb3V0Lg0KPiA+IA0KPiA+IFRoZSBv
bmx5IHdheSB0byB1c2UgQ0VDIGZvciBob3RwbHVnIGRldGVjdGlvbiBpcyB0byBkZXRlY3QgdHdp
Y2U6IENFQyBmb3IgSERNSQ0KPiA+IFRYL1JYIGNvbnRyb2xsZXJzIHdha2V1cCwgdGhlbiByZXNl
dCBib3RoLCB3YWl0IGZvciBhdXRvZGV0ZWN0IGluIGJvdGggY29udHJvbGxlcnMsDQo+ID4gc3Vw
cHJlc3MgZXJyb3JzLCBhbmQgc3RhcnQgc2lnbmFsIHRyYW5zbWl0IG9yIHJlY2VpdmUuDQo+ID4g
DQo+ID4gV2hpbGUgaXQgaXMgdGVjaG5pY2FsbHkgcG9zc2libGUgdG8gZG8gc28sIGl0J3MgdmVy
eSBjb21wbGljYXRlZCBhbmQgaGFja3kuDQo+ID4gDQo+ID4gUGxlYXNlIGtlZXAgaW4gbWluZCB0
aGF0IG9uIHRoZSBuZXcgU29DcyAoODE4OC84MTk1KSB0aGUgQ0VDIGJsb2NrIGlzIGRpZmZlcmVu
dA0KPiA+IGZyb20gdGhlIG9uZSBpbiB0aGUgb2xkIFNvQ3MgKDY3OTUsIDgxNzMsIGV0YykgYW5k
IHJlcXVpcmVzIGFuIGVudGlyZWx5IG5ldyBkcml2ZXINCj4gPiB0byBnZXQgaXQgd29ya2luZy4N
Cj4gPiANCj4gPiBVc2luZyBDRUMgZm9yIGhvdHBsdWcgZGV0ZWN0aW9uIHdvdWxkIG1lYW4gdGhh
dCB3ZSBuZWVkIDMgZnVsbCBkcml2ZXJzOg0KPiA+IDEuIEhETUkgVFgNCj4gPiAyLiBIRE1JIFJY
DQo+ID4gMy4gQ0VDDQo+ID4gDQo+ID4gVGhpcyBpcyBiZWNhdXNlIHRoZSBDRUMgaXMgc2hhcmVk
LCBzbyB3ZSBuZWVkIHRvIGhhdmUgYWxsIHRocmVlIHRvIHByb3Blcmx5IHRlc3QNCj4gPiB0aGUg
ZnVuY3Rpb25hbGl0eSAtIGFuZCB0aGlzIGlzIG5vdCBwb3NzaWJsZSB0byBkbyBhbGwgYXQgb25j
ZS4NCj4gPiANCj4gPiBUbyBzYXZlIHNvbWUgcG93ZXIgKG5vdCBtdWNoLCB0aG91Z2ghKSwgd2Ug
Y2FuIGV2ZW50dWFsbHkgZ28gZm9yIHlvdXIgcHJvcG9zZWQNCj4gPiBDRUMgZGV0ZWN0aW9uICpp
biB0aGUgZnV0dXJlKiwgYnV0IHJlYWxseSBub3QgcmlnaHQgbm93IC0gYW5kIHdlIGNhbiBkbyB0
aGF0IG9ubHkNCj4gPiBhZnRlciB1cHN0cmVhbWluZyBib3RoIEhETUkgVFggYW5kIEhETUkgUlgg
ZHJpdmVycy4NCj4gPiANCj4gPiBUaGUgcGxhbiAodGltZS9lZmZvcnQgcGVtaXR0aW5nISkgd291
bGQgbG9vayBsaWtlIHRoaXM6DQo+ID4gDQo+ID4gU2VyaWVzIDEgLSBVcHN0cmVhbSBIRE1JdjIg
VFggKEhQRCB0aHJvdWdoIEhETUl2MiBUWCBjb250cm9sbGVyKSAtIGRyaXZlcnMvZ3B1L2RybQ0K
PiA+IFNlcmllcyAyIC0gVXBzdHJlYW0gSERNSXYyIFJYIChIUEQgdGhyb3VnaCBIRE1JdjIgUlgg
Y29udHJvbGxlcikgLSBkcml2ZXJzL21lZGlhDQo+ID4gU2VyaWVzIDMgLSBVcHN0cmVhbSBDRUMg
ZHJpdmVyIChObyBIUEQgaW4gQ0VDKSAgICAgICAgICAgICAgICAgICAtIGRyaXZlcnMvbWVkaWEN
Cj4gPiBTZXJpZXMgNCAtIEltcGxlbWVudCBIUEQgaW4gQ0VDIGFuZCB1c2UgaXQgaW4gSERNSXYy
IFRYIGFuZCBIRE1JdjIgUlggLSBtZWRpYSxkcm0NCj4gPiANCj4gPiBZb3UgY2FuIHNlZSBob3cg
Y29tcGxpY2F0ZWQgdGhpcyBpcyAtIGFuZCBJJ20gc3VyZSB0aGF0IHlvdSB1bmRlcnN0YW5kIHdo
eSB0aGF0DQo+ID4gY2Fubm90IGJlIGRvbmUgYWxsIGF0IG9uY2UuDQo+ID4gDQo+ID4gQWRkaW5n
IHVwIHNvbWU6IHRoZSBIRE1JIGRyaXZlciBpcyB1c2VkIG9ubHkgb24gSW9UIGJvYXJkcyBmb3Ig
bm93LCB3aGljaCB0eXBpY2FsbHkNCj4gPiBydW4gb2ZmIEFDIGFuZCBub3QgYmF0dGVyeSAtIHNv
IHRoZSAoYWdhaW4pIHZlcnkgbGl0dGxlIHBvd2VyIGNvbnN1bXB0aW9uIHJhaXNlIGlzDQo+ID4g
bm90IGNyaXRpY2FsIGZvciBub3cuDQo+IA0KPiBJZiB5b3UgcGxhbiB0byB1cHN0cmVhbSBIRE1J
IFJYIGRyaXZlciByZWNlbnRseSwgaXQncyBPSyBub3QgdXNpbmcgQ0VDIHRvIGRldGVjdCBob3Qt
cGx1Zy4NCj4gQnV0IGZvciBhbnkgYmVoYXZpb3Igd2hpY2ggaXMgZGlmZmVyZW50IHdpdGggdjEg
YW5kIGl0J3MgcmVsYXRlZCB0byBDRUMsIGFkZCBjb21tZW50IGFib3V0IENFQy4NCg0KSW4gaGVy
ZSwgZGVzY3JpYmUgbW9yZSBhYm91dCB0aGUgcG93ZXIuDQpDaHJvbWVib29rIG1heSBuZWVkIEhE
TUkgVFggZHJpdmVyIGFuZCBpdHMgcG93ZXIgaXMgZnJvbSBiYXR0ZXJ5Lg0KTWF5YmUgR29vZ2xl
ciB3b3VsZCBiZSBpbnRlcmVzdGVkIGluIGxvdyBwb3dlciBiZWhhdmlvci4NCg0KUmVnYXJkcywN
CkNLDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiA+IA0KPiA+IENoZWVycywNCj4gPiBB
bmdlbG8NCj4gPiANCj4gPiA+IFJlZ2FyZHMsDQo+ID4gPiBDSw0KPiA+ID4gDQo+ID4gPiANCj4g
PiA+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJy
KGhkbWktPmRldiwgIkNhbm5vdCByZXN1bWUgSERNSVxuIik7DQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0KPiA+ID4gPiAr
ICAgICAgIG10a19oZG1pX3YyX2Nsa19lbmFibGUoaGRtaSk7DQo+ID4gPiA+ICsgICAgICAgbXRr
X2hkbWlfaHdfcmVzZXQoaGRtaSk7DQo+ID4gPiA+ICsgICAgICAgbXRrX2hkbWlfc2V0X3N3X2hw
ZChoZG1pLCB0cnVlKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgICAgIHJldHVybiAwOw0KPiA+
ID4gPiArfQ0KPiA+ID4gPiArDQoNCg==

