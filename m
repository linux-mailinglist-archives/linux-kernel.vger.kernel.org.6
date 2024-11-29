Return-Path: <linux-kernel+bounces-425199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0939DBEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0035BB216E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD49714F9F3;
	Fri, 29 Nov 2024 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="haPwx5Ck";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="bXZRpMWX"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021A1EA65;
	Fri, 29 Nov 2024 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848678; cv=fail; b=USRVoxyVicz8LwzxFux+eT/pKJHCEDSXuB6zCeRgP2KZWMSmHBBoTuA7ROcCx7B4TQdVlOKvn92M3piU4A6NIhG6oLsRALHC2MUWkQk+iUVUW7cQ1WvtAdZUmfZaDwNY0OVDy1sdLeZA5uWtS9uHU+pc51iXyCAWeNslj+bB/ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848678; c=relaxed/simple;
	bh=tTlLurmHrnVj5oU+r/m7u+29CW6QhqVNt/xZOMoqqW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=go5RcDXUnaWSOooKajE1gHxjTDJFRynwNMtRNANcvoO2qE+mFGZ5dcmXgtVlqxfiAIIBhDxSGzD5QlNDlhvr7dsc5u7Nf5SlsV9kcfa7x+PTpMl6gMbs3iPMCx29OEa41wvv4Ult2jsY/+vWTRCqTFjAVDQ43uR4m2WhGDNF42k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=haPwx5Ck; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=bXZRpMWX; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c9181d42adfc11efbd192953cf12861f-20241129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tTlLurmHrnVj5oU+r/m7u+29CW6QhqVNt/xZOMoqqW0=;
	b=haPwx5CkXg2igN8tLIz/Kp0PvD53yidXmKAYHhlYH5us6O8pl6gDJWfLRft2gFzf48mCAm/WKSdjiJ9NnsSF9sNskOVdc53O/+iMmketfBrKfJBlm+18Q5Wdps903xHP4Cu4oTc3ZvtpmUxFUczqFimNUMDJJzRUmU99VDWOUMY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:5ec18209-0625-4e32-85e8-a57cd700cf8e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:47dcad23-634f-4016-85ba-2d63e55c9400,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c9181d42adfc11efbd192953cf12861f-20241129
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 584316901; Fri, 29 Nov 2024 10:51:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 29 Nov 2024 10:51:07 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 29 Nov 2024 10:51:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF88knfKCtw4cePNdUISHavsRTgLanMTRTV2eHL6GV+cGmmHO1mJfw3fAogqZDSdCnoe66YmE2HXAzKYLZHPha7ISIuSTF1po1MGrtv0Y24j733Ie4jR21LM9x5gUGRKSlk8c32+y513U/TVYvLjB4qZ2on+QbfVjMCBu4b56v89Xn13qo2sbhUg8NZeiO+9XzR1V4XAddwdqg1fwgK649eVSwyyU08QM1i2ytY9NBebWaccUQ3gPIgdoXaE1raQd0pYG5JNBPfQmOVRkXclQuVaIOb81Xcs4G44JAO+FQa4FN0CNuK1pr9kqs+4fNFnDH6MTHMdV2jPHbp2C1WyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTlLurmHrnVj5oU+r/m7u+29CW6QhqVNt/xZOMoqqW0=;
 b=YjaHm/qGYigKWo3DmiT5sPI8zCIX//7/R1PI+ZQpDwFHsj8h0w4h2y3laEXJbVXLsHprdQ6PmqPuIiblLqdo+0bzVeNMhtGipUCOsHe8mpaihp0EGVRH/YeKLy0VXJ77ZFTQ/FJT3uPcsFzZ0IV//4O4N8RbPxEBhWYiZCJIUBLdDG0TxENQRRVPafvMsi3L3/JxTiU7lHhJSTKbB4DvmfPB+8Ba4h0jC6Va8SQeOcbFTs8Jfhry/Uu/+QeqpC9V9/zCgrXrIJLBFRMLJfn/IEE3UkHMf9cCUngGjUteUxjbMvIcEW3TMLqNirUCNt9LkIGFCh33f+4D7h1uEkXDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTlLurmHrnVj5oU+r/m7u+29CW6QhqVNt/xZOMoqqW0=;
 b=bXZRpMWXnS1cQlmpEeED3fPM9wU3eVQLq5C9hVUzYIEW4DVcO8paam1DhYW2rJ0ygm033sZpk9o7sCJNFoSMN2Her6lC6T3+pt27d8EAEFL/jGGwrmNHmHpdb3F1kdv+QkGwxPHI0t7wQSbpNeXjpNgcBC1L9lN15R4yts9kh5o=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB7848.apcprd03.prod.outlook.com (2603:1096:400:459::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Fri, 29 Nov
 2024 02:51:05 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%3]) with mapi id 15.20.8182.018; Fri, 29 Nov 2024
 02:51:05 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "kernel@collabora.com" <kernel@collabora.com>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>, "mripard@kernel.org"
	<mripard@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v1 2/7] dt-bindings: display: mediatek: Add binding for
 MT8195 HDMI-TX v2
Thread-Topic: [PATCH v1 2/7] dt-bindings: display: mediatek: Add binding for
 MT8195 HDMI-TX v2
Thread-Index: AQHbO0o5ukncxVfT6kWYuLGFTOD1aLLMP5kAgABLZYCAARF9AA==
Date: Fri, 29 Nov 2024 02:51:05 +0000
Message-ID: <4b1eb13d027717abaaaf4ee7aa927239ba314572.camel@mediatek.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
	 <20241120124512.134278-3-angelogioacchino.delregno@collabora.com>
	 <721896498fe9a5ba5a942fe837deb90d461b5090.camel@mediatek.com>
	 <3d5f7106-6425-420c-abac-39feed11c95c@collabora.com>
In-Reply-To: <3d5f7106-6425-420c-abac-39feed11c95c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB7848:EE_
x-ms-office365-filtering-correlation-id: 88a0d8fd-1b44-42a1-3e81-08dd1020ab29
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UHpINERIVTd6dzh5WDFIYmhDN2o4eC91ZUs2amhtRXpxTWc0NEFVdzExZUNK?=
 =?utf-8?B?WTR6VDQrcXJQM3V0K3Q2R0JTRTViRk9qYjZXeS92MnJuOE05NytQbjNYQkNi?=
 =?utf-8?B?ektkS2pERjJFRjRLNEJvV2MrZGxzL1Y2ak5LUm95NGhsQ3lPZEtZL0VtV1g1?=
 =?utf-8?B?YnpMZFR3RVR4VXZpYnplWWQvSFVRN2lFWFlQdHBERDU1bWk4d2V0ZkVtUWN0?=
 =?utf-8?B?ZWRjM2ExWmRNUExtRHVhL21OdTc3SDcyemllN1N0cXZqOTE1Rmhib3NCVlFF?=
 =?utf-8?B?aDg5U1dXT2R5OFU2bUtJb0Y2QWhqekgyTi9LRUQzSlFoZE44U1BDM0VrZWdQ?=
 =?utf-8?B?enI5dEhrTWtVV2lwb2FUMGF0aWcyWTRFYkw2M2JXSUZmRkZkMkc0OW9weitM?=
 =?utf-8?B?N3JyKzV1eDdCbXVhUHZrMFNPRlp6Q1lUVTlZQXJ2SG5SV2Vzc3QwOUgvdG9S?=
 =?utf-8?B?a3JvWlpWdWNLYWI1YmJBUzBCVEdVVHpQS05HZnFnQkpnajJyblBtejF5OFp1?=
 =?utf-8?B?dnp4YUpENE9Dc0ZHdnJiVGdSUjVWRkMzQ0U1dGp1OFQ5WDgremlSaDI0Mit3?=
 =?utf-8?B?YVZ4VXRhWVpZQlhjNUFsTDBTYUpJOFFVbkgwOFhabGFXMFY2UzllcFRZeFRV?=
 =?utf-8?B?bVdQZ0ZJZTVyUFljWDNWVC9HaDU2TDhRdVhIOW04dnZLV0h3VGhZN1dLVUJz?=
 =?utf-8?B?akU2N3krVWFVaHViTFhMWjRMVzIxRytjb0JxQU1OK2Fmc0VEbnN6ODBhMTFp?=
 =?utf-8?B?dGJPRzJ2SzRXTGVOVDgweFJYRGprOHY5Y3JIZnFnczZPYWxxa25uWGc2YlZt?=
 =?utf-8?B?OXRmUWg1MjVzVEpQcmVvWW5Edmt5VnMzTDkwU2V4ODJLNzM1b2F6RlNraDV1?=
 =?utf-8?B?TnFEMnFuTDJBOFZvV3huT2xXRnkvSjRmTGVZQ3hUdnRmTldBVUk2UTZ2bFZl?=
 =?utf-8?B?ZE5JTHA0YkVoaXV5WnVPR2l6MG5rUDNCbDhzOUNNOCs4Ym1BNGt2TEMxWSt1?=
 =?utf-8?B?MFNPaU1yQzRxdUJqaFMzYmJkY01tTU9wajV5OUl3YkI2ZWNJRjcwYVJBODBl?=
 =?utf-8?B?Ukx0Q3d0c05vTWhQQW9JSW5Ccmsvd1ErZXBVYk1Hd256NUhNU2tvdDhqV01z?=
 =?utf-8?B?MXpqdCtSY1VPc1VGcE5MbTlGZFVaMEdnY2ZWU0tRRjdrLzFtVDFCZ3VFUWIz?=
 =?utf-8?B?R2pJNWgzdGdiQ1pFVDAvaVpQOUh4a2Qvc2Q2bUMzMDl2cGJJZEJVelU0QmFE?=
 =?utf-8?B?Vld2S3p3eUdlVW54L0wyU21kK1JVMVFyTkN0ditaK255dWk2UXpjQUhQY003?=
 =?utf-8?B?R3VpdFhKTWtCOEo1RVlPRzZlT1FMTkREVXRPK3Bzb0V3R1dNZHlaVnRCU2U0?=
 =?utf-8?B?QjlQa3RHUjk4OGREaXU3RXdIZ1pjWGdpKyt2N1dVZ1BhWVB5MFk1QVdicTB4?=
 =?utf-8?B?U001LytOZFdGc0pRS1BlSmo0L1lZTGpiYlRNbU9sdHgxcG93VytmNHdmWkxU?=
 =?utf-8?B?YUpJRTlmUm1PZzhKWitKcjZ2NVY3YkJkZURISktaQ0FNUy94K3NEQ3cyZ2g1?=
 =?utf-8?B?SEVDVWZiUUs4VG0vV2U2RE5sTU9tWFNoSTZ1R0hKcWJXOTNaemZoZnB5eDl3?=
 =?utf-8?B?K2VVMXBuTlVuMVNsTmd0OVVMZkwzRk00VG1lYjhUVFFVTkV4d05yOWI3cnBR?=
 =?utf-8?B?YlNHV3cyZVorbjFwSUNqNHpVNHRHV0w3TnM4RmNZM0R6Y3d2TGdOTDJMS2dh?=
 =?utf-8?B?NnZ0T0hMMGZvTEJoVFI2NVdBQTBuUG5kanJFZTdBbTVhY1hyS0xWcHd5eEVi?=
 =?utf-8?Q?bm2OTtOGw3H3xvDYglop2sqSpng/hDwC6b3L4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmVtZFIxVjJCU2FvajJCVk16UDArQ2tQY0ttUWFjbE54QWRzd3RVOVlNY1hY?=
 =?utf-8?B?RTRMU3FXTnJjK3FGNnQ4a2ppbHIzTHRBblo4QkxxMWlhd1llczZ1blRScVN4?=
 =?utf-8?B?a3k2RjkxVVlwN1VxdHVMMElwNnNXVldtVnoycWNMTjkrSWFIL2ZlMnpmbzZi?=
 =?utf-8?B?S0JpUVN0MGpabmVOUGFpK3QzSFpmaFBXWEZVZDl4WFg2Uk1RVlJQakIzNjln?=
 =?utf-8?B?ZE5SdHZvQnhQUkhhK2x0VGhLZ08yNUZDNm4wTnAvNWNYSVZrenYyeFZ2ZTBD?=
 =?utf-8?B?a3VTZFNyeWFNSXlUVDJRYW80bWM2UXo3dm5kV3A5ajdLR0VkRnMrODNRbTFU?=
 =?utf-8?B?dWRTTVlNd0ZiS3NEZDYyT2tTZlBZTUpqN0htallTQnovMWZOQnRyRnNRQ0tw?=
 =?utf-8?B?dW9PUTVZZXlWWTcwSXJlaWdON05COXpHZStzRW9wZitXZzRadkpDU0RQWUxY?=
 =?utf-8?B?Tkt4bVo3b25ZZDNDRWxZRkxZUk9BYkxiNHMyYmFMeUpwMTdiUDRyckRnT0tY?=
 =?utf-8?B?eTRPRHN1by9TNTlnUFR3OVdrcVFLUmZuNXlSVmVIL1JpZVQ4VTBMOURUQ3Fo?=
 =?utf-8?B?d0pvN1Y3VkNvM3pRTE5LQlluakhZRy80YjNRcnVzai9oQU9HTytmWkNlZWY4?=
 =?utf-8?B?YlBBbGxVdXBvZTl4MmN6d1YyeTdhdGxKWHZHMG5Rb2NqN2REMEVUemFTcFBP?=
 =?utf-8?B?WG9zWkF5Tk9Oc0xlWnF2UWs1VXIxUkt0QTVjTkczTzBmQlNMQjhxWFVzc054?=
 =?utf-8?B?ZGJHTnIrRXV1WjRETnkxb2VmNUoxQWlqRnIwajl4VmxQeEFHaU81WWhiSUVZ?=
 =?utf-8?B?bUVobXpHSHQ4bXZvV1F2QWgrRGFsVURKcEM1dnRFZmNwV0cxcEJiL0NMcGVU?=
 =?utf-8?B?TmFkbjFLRFo2NXJNenFPc0R1M2w5dUJaUzJ5QnpsS3BLays1dVg4UXNFbENq?=
 =?utf-8?B?UlY4MXAxSjZLSnhVaEpzbXZzMEpjcEdSZXVUZ21LM3paUjlsUmN4dXhDMGZE?=
 =?utf-8?B?OGQ4WWQ1WktaZlpLMEhTQkhzdnJ0b042K2loYTFIb1RBNWFxZFA5OEluWWNE?=
 =?utf-8?B?Tzg0dHJjdk45NDR1SE9SRzRuNzQvT2thdHJZODlaY2lyR1MzaEJYMHh2SDVM?=
 =?utf-8?B?cDZrc3Jta2xwb1Jyd3l0MXBKSjNpQjZtWkR3S2ZZdHl1OWRCaEhhTmRFaDdp?=
 =?utf-8?B?MkIvK0htdko3YkVzQWlEa1ZENHhaeTczN0Rub0tkcENnempTTWYvRFloNGlI?=
 =?utf-8?B?RHgxNkR1WkgydFBNTEpYSTlWZ2U2SS9WTFNleXd2RzU3MEZ5UlhReTZoaEF4?=
 =?utf-8?B?emxzOVJlaTNlSTZhaEpzeGh0MUlYZWhaeE9HV0lyUnJRSjBPT1o4Y0ZhUndJ?=
 =?utf-8?B?YW16bmVsbWlHQmxVbi9qdzJJODNqc3pGMjZrTUhBbHJqWkVHWDFERTRHTzFv?=
 =?utf-8?B?UGVpOUlYaEEwUWJTTVNjUW1uVm5XRWhkMmR5SG1zMjA0MFZlWmVqN05kTmpM?=
 =?utf-8?B?cHhTQjBQT2ZaUFlOQXZxclJySElkSXQwOFRCbkFlV1J1R0JiTUpLRUVKNDlI?=
 =?utf-8?B?elIzS3ZMaEZLUU1jektJZWI1c00wRzBPckk2T1BzNUNEdCthbDVBbFRac0Q0?=
 =?utf-8?B?eTA5OEsyN1phYVNBWXQ4cVBkUXRrVm5QUGYvZ043b2QrejNkVkcwRXFtT2Q1?=
 =?utf-8?B?M2ZIRXBaOVV4RnBTUUNPQ2dBSXpTK0owdGs1Ujd0SmFXdG9yK09XdDlaNTVk?=
 =?utf-8?B?MHdTS1lIYXU3WVcrWitvTGprc0RaaXgzZUc1c2U5SmdwckJ1bHhma3hRdlow?=
 =?utf-8?B?eFUxNG91a3p4U2lHK3d5VWE3ZWRoKzVDRGZML0VwNkV6M0JiWmhsNlZwLzFr?=
 =?utf-8?B?YTRiOTRrcWdDeTdDT1hyZnllTGNTTTlQRU5lVDNYYnVLMWVUaWlaRWt2Nnh0?=
 =?utf-8?B?L0JKazBoNGdxekpqYkNVcmtWT0FIZWUwRXkwL0JnKytFWmJiaXFTY2lQVDhu?=
 =?utf-8?B?Qmp3WFdpbktlR2lHQTRtbmtENjdNb2E5NFNEUjhDb3hweHN2Q0kvYktQUCtR?=
 =?utf-8?B?SHJZNk10TytRZy9jNlRERHg4NmxQcW51djdGRDRpWWpXTXU1akcxMkZnamFj?=
 =?utf-8?B?Q0tIcnVKZWw4Z0ZjL1ZsZ1NpY2V0TXg4UG9rSXpidkQyaWNVNVRvSHN2RGVh?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4786D65C3D66574EB8D9968AB30B133D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a0d8fd-1b44-42a1-3e81-08dd1020ab29
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 02:51:05.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VF3+aS5p1QX/BNS44euYV9FL+iiduC/VLpROSF1K58oKj2KO0ZVs3fqlysyjVnFDuHqYjIMm1Ps77tNjNk1TjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7848
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--29.091500-8.000000
X-TMASE-MatchedRID: TmlY9+XBoTkNtKv7cnNXnSa1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCopoEWlZvizRmlaAItiONP0xmbT6wQT2a4iUfQ1FpaXV1W2
	OsTtJOvxqAxli99b1G19Ye/5WNhGLB9u/r9MFnssD2WXLXdz+AVo1rFkFFs1aArMcoUfMuwkGk2
	pTPAu+98L1MXSgRnEMEQOIcCJ9jA2InHjrjZy8lpU7Bltw5qVL+w4HAoP6qDTczkKO5k4APtzDh
	HEbpyKJEq7uMu5mDq39FZmWv7invm2ovFX+0df9YD9XTRdaMO1jyKkkvAcyof7spkgIRsSyBDJc
	r14LqZSGT+IZqmifF1oXqqYm7WabNgyelB4Yx0JwUSK4/EeOxdF9F+XaXgXeJas75KBkIebqYfM
	0tIgPqWHFkQL4i7pmhPkprRfVzp23d2S847QRa1VN8laWo90M9ISHwCrIdS8gcyGevtftJ6PFjJ
	EFr+olFUew0Fl/1pFZZmMIUsIQGkY41YX/o/8KSnQ4MjwaO9cqtq5d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--29.091500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	5A60B0F8A67B7EF68D238F4FFA892E4B70B7C6D86386C592BC08B973DFD9C5B02000:8

T24gVGh1LCAyMDI0LTExLTI4IGF0IDExOjMyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAyOC8xMS8yNCAwNzowMiwgQ0sgSHUgKOiDoeS/
iuWFiSkgaGEgc2NyaXR0bzoNCj4gPiBIaSwgQW5nZWxvOg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAy
NC0xMS0yMCBhdCAxMzo0NSArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gd3JvdGU6
DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbCB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBj
b250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IEFkZCBhIGJpbmRpbmcgZm9yIHRoZSBIRE1J
IFRYIHYyIEVuY29kZXIgZm91bmQgaW4gTWVkaWFUZWsgTVQ4MTk1DQo+ID4gPiBhbmQgTVQ4MTg4
IFNvQ3MuDQo+ID4gPiANCj4gPiA+IFRoaXMgZnVsbHkgc3VwcG9ydHMgdGhlIEhETUkgU3BlY2lm
aWNhdGlvbiAyLjBiLCBoZW5jZSBpdCBwcm92aWRlcw0KPiA+ID4gc3VwcG9ydCBmb3IgM0QtSERN
SSwgUG9sYXJpdHkgaW52ZXJzaW9uLCB1cCB0byAxNiBiaXRzIERlZXAgQ29sb3IsDQo+ID4gPiBj
b2xvciBzcGFjZXMgaW5jbHVkaW5nIFJHQjQ0NCwgWUNCQ1I0MjAvNDIyLzQ0NCAoSVRVNjAxL0lU
VTcwOSkgYW5kDQo+ID4gPiB4dllDQywgd2l0aCBvdXRwdXQgcmVzb2x1dGlvbnMgdXAgdG8gMzg0
MHgyMTYwcEA2MEh6Lg0KPiA+ID4gDQo+ID4gPiBNb3Jlb3ZlciwgaXQgYWxzbyBzdXBwb3J0cyBI
RENQIDEuNCBhbmQgMi4zLCBWYXJpYWJsZSBSZWZyZXNoIFJhdGUNCj4gPiA+IChWUlIpIGFuZCBD
b25zdW1lciBFbGVjdHJvbmljcyBDb250cm9sIChDRUMpLg0KPiA+ID4gDQo+ID4gPiBUaGlzIElQ
IGFsc28gaW5jbHVkZXMgc3VwcG9ydCBmb3IgSERNSSBBdWRpbywgaW5jbHVkaW5nIElFQzYwOTU4
DQo+ID4gPiBhbmQgSUVDNjE5MzcgU1BESUYsIDgtY2hhbm5lbCBQQ00sIERTRCwgYW5kIG90aGVy
IGxvc3NsZXNzIGF1ZGlvDQo+ID4gPiBhY2NvcmRpbmcgdG8gSERNSSAyLjAuDQo+ID4gPiANCj4g
PiA+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDxhbmdlbG9naW9h
Y2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICAgLi4uL21l
ZGlhdGVrL21lZGlhdGVrLG10ODE5NS1oZG1pLnlhbWwgICAgICAgIHwgMTUwICsrKysrKysrKysr
KysrKysrKw0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTUwIGluc2VydGlvbnMoKykNCj4gPiA+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9k
aXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG10ODE5NS1oZG1pLnlhbWwNCj4gPiA+IA0KPiA+ID4g
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21l
ZGlhdGVrL21lZGlhdGVrLG10ODE5NS1oZG1pLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgxOTUtaGRtaS55YW1sDQo+
ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4yNzNh
ODg3MTQ2MWUNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLG10ODE5NS1oZG1p
LnlhbWwNCj4gPiA+IEBAIC0wLDAgKzEsMTUwIEBADQo+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gPiArJVlBTUwgMS4y
DQo+ID4gPiArLS0tDQo+ID4gPiArJGlkOiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0
cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxtdDgx
OTUtaGRtaS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbHUwRF9DM1R3UTItMDJqV1lBQm5N
SVE4dkVvVXdQME80Z2JRbmRKblBVTXBkaTZ3WGRBSHJhOWl2Q2ZCN3pvZWxESTdxc1MyMFlkUmxt
UDRiRUtBQUJsZXRYRlgkDQo+ID4gPiArJHNjaGVtYTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFD
VFJOS0E5d01nMEFSYnchbHUwRF9DM1R3UTItMDJqV1lBQm5NSVE4dkVvVXdQME80Z2JRbmRKblBV
TXBkaTZ3WGRBSHJhOWl2Q2ZCN3pvZWxESTdxc1MyMFlkUmxtUDRiRUtBQUZsblktS1kkDQo+ID4g
PiArDQo+ID4gPiArdGl0bGU6IE1lZGlhVGVrIEhETUktVFggdjIgRW5jb2Rlcg0KPiA+ID4gKw0K
PiA+ID4gK21haW50YWluZXJzOg0KPiA+ID4gKyAgLSBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdu
byA8YW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gKyAgLSBD
SyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gKw0KPiA+ID4gK2Rlc2NyaXB0aW9uOiB8
DQo+ID4gPiArICBUaGUgTWVkaWFUZWsgSERNSS1UWCB2MiBlbmNvZGVyIGNhbiBnZW5lcmF0ZSBI
RE1JIGZvcm1hdCBkYXRhIGJhc2VkIG9uDQo+ID4gPiArICB0aGUgSERNSSBTcGVjaWZpY2F0aW9u
IDIuMGIuDQo+ID4gPiArDQo+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ICsgIGNvbXBhdGlibGU6
DQo+ID4gPiArICAgIGVudW06DQo+ID4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODgtaGRtaS10
eA0KPiA+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTk1LWhkbWktdHgNCj4gPiA+ICsNCj4gPiA+
ICsgIHJlZzoNCj4gPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiA+ICsNCj4gPiA+ICsgIGludGVy
cnVwdHM6DQo+ID4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiArDQo+ID4gPiArICBjbG9ja3M6
DQo+ID4gPiArICAgIGl0ZW1zOg0KPiA+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IEhETUkgQVBC
IGNsb2NrDQo+ID4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogSERDUCB0b3AgY2xvY2sNCj4gPiA+
ICsgICAgICAtIGRlc2NyaXB0aW9uOiBIRENQIHJlZmVyZW5jZSBjbG9jaw0KPiA+ID4gKyAgICAg
IC0gZGVzY3JpcHRpb246IFZQUCBIRE1JIFNwbGl0IGNsb2NrDQo+ID4gDQo+ID4gSSB3b3VsZCBs
aWtlIHRvIGtub3cgbW9yZSBhYm91dCBIRE1JIHYyLg0KPiA+IFdvdWxkIHlvdSBtYXAgZWFjaCB2
MiBjbG9jayB0byB2MSBjbG9jaz8NCj4gPiBJZiBvbmUgY2xvY2sgaGFzIG5vIG1hcHBpbmcsIGlz
IGl0IGEgbmV3IGZlYXR1cmUgdGhhdCB2MSBkb2VzIG5vdCBoYXM/DQo+ID4gDQo+IA0KPiBUaGUg
SERNSXYyIEhXIGJsb2NrIHNlZW1zIHRvIGJlIGFsbW9zdCBjb21wbGV0ZWx5IGRpZmZlcmVudCBm
cm9tIHRoZSB2MSwgYW5kDQo+IGl0IGlzIGFsc28gaW50ZXJjb25uZWN0ZWQgaW4gYSBkaWZmZXJl
bnQgd2F5IGNvbXBhcmVkIHRvIE1UODE3MyAodGhlIHBhdGggZ29lcw0KPiB0aHJvdWdoIFZQUDEs
IHdoaWxlIHRoZSB2MSBpcyBqdXN0IGRpcmVjdCB0byBEUEkvTU1TWVMpLg0KPiANCj4gVGhlIHYx
IGJsb2NrIGhhZCBzcGVjaWZpYyBjbG9ja3MgZm9yIHRoZSBhdWRpbyAoaTJzLCBJIGJlbGlldmUp
IGFuZCBmb3IgdGhlIFNQRElGLA0KPiBhbmQgSSBoYXZlIG5vIGlkZWEgaG93IHYxIGRvZXMgSERD
UCwgYnV0IEkgZG9uJ3Qgc2VlIGFueSBzcGVjaWZpYyBjbG9jayBmb3IgdGhhdC4NCj4gDQo+IFRo
ZSB2MiBibG9jayBpcyBjbG9ja2VkIGZyb20gdGhlIEhEQ1AgY2xvY2ssIHRoZSAoYXBiKSBidXMg
aGFzIGl0cyBvd24gY2xvY2ssIGFuZA0KPiB0aGUgdmlkZW8gb3V0IG5lZWRzIHRoZSB2cHAgc3Bs
aXQgY2xvY2suDQo+IA0KPiBJdCdzIGp1c3QgZGlmZmVyZW50LCBhbmQgd2UgY2FuJ3Qgc2hvdmUg
dGhlIHYyIGJpbmRpbmcgaW5zaWRlIG9mIHRoZSB2MSBvbmUsIGJ1dA0KPiBldmVuIGlmIHdlIGNv
dWxkLCBzaW5jZSB0aGUgdjIgYmxvY2sgaXMgKnRoYXQgbXVjaCogZGlmZmVyZW50IGZyb20gdjEs
IGl0J2QgYmUgYQ0KPiBtaXN0YWtlIHRvIGRvIHNvLg0KPiANCj4gU2luY2UgdGhlIGJpbmRpbmcg
ZGVzY3JpYmVzIGhhcmR3YXJlLCBhbmQgc2luY2UgdGhpcyB2MiBIVyBpcyAqdmVyeSogZGlmZmVy
ZW50DQo+IGZyb20gdjEsIGl0IG5lZWRzIGEgbmV3IGJpbmRpbmcgZG9jdW1lbnQsIHRoYXQgaXMg
dHJ1ZSBldmVuIGlmIHlvdSBmaW5kIGEgd2F5IHRvDQo+IGdldCB0aGUgY2xvY2tzIHRvIG1hdGNo
ICh3aGljaCBpcyBub3QgcG9zc2libGUsIGFueXdheSkuDQoNCnYyIGluZGVlZCBpcyB2ZXJ5IGRp
ZmZlcmVudCBmcm9tIHYxLCBzbyBpdCdzIG5vdCBuZWNlc3NhcnkgdG8gbWVyZ2UgYmluZGluZyBk
b2N1bWVudC4NCkkgd291bGQgbGlrZSB0byBoYXZlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhl
IGRpZmZlcmVuY2UgaW4gYmluZGluZyBkb2N1bWVudCwNCnNvIHRoYXQgd2UgY291bGQgY2xlYXJs
eSB1bmRlcnN0YW5kIHRoYXQgdjEgYW5kIHYyIGFyZSBzbyBkaWZmZXJlbnQuDQoNCkkgdGhpbmsg
cGl4ZWwgY2xvY2sgaXMgaW1wb3J0YW50IGZvciBIRE1JIGhhcmR3YXJlLCBidXQgSSBkbyBub3Qg
c2VlIGl0IGluIEhETUkgdjIuDQpJdCBpcyBiZXR0ZXIgaGFzIHNvbWUgZG9jdW1lbnRhdGlvbiBh
Ym91dCB3aHkgcGl4ZWwgY2xvY2sgZGlzYXBwZWFyIGluIEhETUkgdjIuDQoNCkkndmUgc29tZSAn
V0hZJyBhYm91dCB2Mi4NCldoeSBubyBhdWRpbyBjbG9jayBpbiB2Mj8NCkF1ZGlvIGNvbnRyb2wg
cGFydCBpcyBtb3ZlZCBvdXQgb2YgSERNSSBibG9jaz8NCg0KRm9yIEhEQ1AsIG1heWJlIHYxIGRy
aXZlciBoYXMgbm90IGltcGxlbWVudCBpdCBzbyBmb3JnZXQgdG8gYWRkIGl0IGluIGJpbmRpbmcg
ZG9jdW1lbnQuDQpTbyBqdXN0IHNraXAgdGhlIEhEQ1AuDQoNClRoZSBmb3VyIGNsb2NrIGluIHYy
IGRvZXMgbm90IGV4aXN0IGluIHYxLCBzbyB3aGF0IGlzIHRoZSBmdW5jdGlvbiBvZiBlYWNoIG9u
ZT8NCklmIHBvc3NpYmxlLCBhc2sgTWVkaWFUZWsgc3RhZmYgZm9yIG1vcmUgaW5mb3JtYXRpb24u
DQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCj4gPiBSZWdh
cmRzLA0KPiA+IENLDQo+ID4gDQo+ID4gPiArDQo+ID4gPiArICBjbG9jay1uYW1lczoNCj4gPiA+
ICsgICAgaXRlbXM6DQo+ID4gPiArICAgICAgLSBjb25zdDogYnVzDQo+ID4gPiArICAgICAgLSBj
b25zdDogaGRjcA0KPiA+ID4gKyAgICAgIC0gY29uc3Q6IGhkY3AyNG0NCj4gPiA+ICsgICAgICAt
IGNvbnN0OiBoZG1pLXNwbGl0DQo+ID4gPiArDQo+ID4gPiANCj4gPiA+IC0tDQo+ID4gPiAyLjQ3
LjANCj4gPiA+IA0KPiANCj4gDQo=

