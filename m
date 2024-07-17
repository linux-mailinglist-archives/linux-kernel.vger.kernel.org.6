Return-Path: <linux-kernel+bounces-254709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFECE9336A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 764C9284404
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 06:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB3125AC;
	Wed, 17 Jul 2024 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BMe1Q8ZP";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Era01nIX"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16B311712
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721196372; cv=fail; b=IfcrExz8oLfLji+B1Y5gx2acdbZSdT6xfjjBcQ+PPVckoZky/vfU1k8TgTe8hu0PAMRayCcpU1nGfCLJZQ/rbBEsUH6/wGufQw52Pe73LUnzsqSG4TyWKJ1wmEkYKsW5LFRNlCItSImOP9S/Gq6+9owkWGpbesTESgy6Kb6PaH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721196372; c=relaxed/simple;
	bh=26DAAH8oq7H7Fn9zVByt3HQ/aVnhxokBjn4s6EBcID8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=snYc0pIFv2+QhD7/vs2lmuCfayUcjv0IMyfbiHVZhtNi1eSGWf90R6+HZr85/zka6v6NtnRcnctFqL4PpZ3n300uod25Wl7KwAGnDfdmoOVGDpF0GYtOMK3dBwhnklqQ6rHNYMbUWgOrnM2AKJHi5mvkuVp/ueQLtOboJrwF1xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BMe1Q8ZP; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Era01nIX; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9df824a4440211ef87684b57767b52b1-20240717
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=26DAAH8oq7H7Fn9zVByt3HQ/aVnhxokBjn4s6EBcID8=;
	b=BMe1Q8ZP9WWIGpxCzRt8RyCaElt2lqv5SskIgq+3sir7eHfj4Ed/Xl4m7rODqkK3BQxCmGKt7MchWEyDR/gvBcVbTidvoLEppdlR+GKqO9dPSB9CYOU6gGWGOV861uKqArwMgh3Fz5UylpP6bsL/I3BJOobtSMxowuNevIMlJRg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:29352191-8884-4274-a175-b50dcd066675,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:ba016545-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9df824a4440211ef87684b57767b52b1-20240717
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 92772001; Wed, 17 Jul 2024 14:05:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Jul 2024 14:05:51 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Jul 2024 14:05:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REhAOktVgzZjGpF6I69k782eOL8BCThfzcea/3gidFBVuAg8Jl/eNmL6GO8mgKjG8OW1bmvw1aXGxXk0ZgwCMPkBIjOzEnL1uiNg2He5e3ZHotuPC1ks5HCA+XQYefJxBjDnOUtS9LkCu3UMkjiQzXz0EXCr4eKIQNKezGi1/iBccpmuk+JzFbMn/JVyHqKZ2UaZnVbFnc5X4EzWpEIDLizFDastenYb6NeKp4fL10qClsvun0K3+8Xh3eP8Uw6um1qOJypKiGZsFjXf/UxSGRHWDF7fwkFscr3Oc/CrmuEzTN4wFZMBO9DaL+Qo1LVB9tGgZnX5x6CkJ5wskx7IfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26DAAH8oq7H7Fn9zVByt3HQ/aVnhxokBjn4s6EBcID8=;
 b=YZrbIAUZI+RzbbPFSDOIH85+ygeFb845DtQqFEkzrr7s8V7s/EcYST6jKXWj7p4NKp4+Usrde3A0zzmmvbGRCXUwz8uW0ph2zoSYLbZWeldhhQ+PrwsahETgqi4TI9smptCM1y7n2FnuQ4OxofCBphXvCORzbfdo7H0xph58+ITO11xc8B3Ni/+Aj4458TfqDxoNb67uF7OExn1koUCAPUy5+4MVQvB6pfeMMnKkDpySHkqfWQecHvrH2OVaaqQ24EtPa8lnRCN8mwTeafRHQGtpxeR8Rok7WOVPbc7cFaKkmn/mjPqBlXpfPfbeWVX1ZmifjoWkXX8exwW+KlFomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26DAAH8oq7H7Fn9zVByt3HQ/aVnhxokBjn4s6EBcID8=;
 b=Era01nIXp2KuYqQXUfWdxV42HWg9EkJTauRwt5HvgSimHnChYKmFMeHBK1rqKF9WZ8Umk9CA/VkGnEbjXhXcPON0GImU0XBPt1X+PhddncA50hLppFS4wI+LZaeCSnu5/rBFytnuQRFyzHNDqI4E0N4qH0yaOHLqNuusv6jX76c=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8100.apcprd03.prod.outlook.com (2603:1096:990:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 06:05:49 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 06:05:49 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>
Subject: Re: [PATCH v4 4/5] drm/mediatek: Support "Pre-multiplied" blending in
 Mixer
Thread-Topic: [PATCH v4 4/5] drm/mediatek: Support "Pre-multiplied" blending
 in Mixer
Thread-Index: AQHa2Am6qPAC07KkSEyHU+8BkQQ5L7H6bqkA
Date: Wed, 17 Jul 2024 06:05:49 +0000
Message-ID: <821bba3487d4433db05d8ed6817075b63ba4243f.camel@mediatek.com>
References: <20240717-alpha-blending-v4-0-4b1c806c0749@mediatek.com>
	 <20240717-alpha-blending-v4-4-4b1c806c0749@mediatek.com>
In-Reply-To: <20240717-alpha-blending-v4-4-4b1c806c0749@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8100:EE_
x-ms-office365-filtering-correlation-id: db8a7fec-9f9b-4c31-2e1a-08dca6268196
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QTAxbm9yQ0ozL1VFRUZvMlJoNFgvZGx0N0ZLK1lOVVJLNlArc0JBWnM1eDJL?=
 =?utf-8?B?MjBOOTJsazRyVVZoc0Jzc1VPTWM4em1td25CNG5GdlVDOGRlOTZqRTRyRDEv?=
 =?utf-8?B?UjZXcHZCNjJDZ1FvMU5sT1BzZGtyUkNpTzllVjRCQkxnQlhHQkVvRDc0bThj?=
 =?utf-8?B?bmZFZzY5MldVZXdkYlRCekZWWXZyUnRrVDlYSmxRZ3lFY2VRVGhUcU4xcEFH?=
 =?utf-8?B?S3Ixb1owcTAzWlVCS1BjYVpRRTVUSC9sK0FyQUtqbEFBTXdBQjJoMTVuWU1M?=
 =?utf-8?B?ZDNOQVgwdUZhSHRwVWYvQklHeHRCZExrUzBLQlNUM290eVdoZzloMXgzU1BS?=
 =?utf-8?B?eE5qYThVcXdDa0Z1TGg5YzJ5b3pKSTNYYndJclAxZWVHUnpld08rUGc0YVps?=
 =?utf-8?B?NmRuaFU4YmVodk9EclVFU1BLK0dQeThBaXZ5U2VuU1BDNGNTZE9WbExhd0Nq?=
 =?utf-8?B?R0p4ZDJMallncWxaUFFlN3dQZGlGYUdvQVpvKzN4S1JIVHErZ1VZQTFOUzdT?=
 =?utf-8?B?aXlkWlZ4bVpnU2MzVi9MK2pMVHlUYUg1dnZmd1cybThiNTErS0p1SklmVFAv?=
 =?utf-8?B?VzUxYmJVWCtzMlg3OE9JL0RBcE53OVY0TXd0ZnVtZEhOc0J3YkF5M2x0SWd2?=
 =?utf-8?B?OVpkZkxBVm0rV1Q1V1hDSEh1ZmMyZ3JVeDh2cnRpMFpHZUFIWjRDWXV6T2ZD?=
 =?utf-8?B?cGJJbSthL3QrcG9iTndVdnNHV3QvdnlNSVpMcWc2L0w2OGVqVThGdmlZZVJF?=
 =?utf-8?B?UndKalYwUnZXbm5DZDNiOHNEUTdDbWtTVHNZYm9zUzFDMC9RWFdnT01TdGZE?=
 =?utf-8?B?eXhiUEVqeEtiVmsvck1WSllpaHZzV09qcHdHRThQaEs4cEVxSzFiRG1nUURV?=
 =?utf-8?B?dmpTN1NaV242MENHTDUzL2tCUE9QVktFOWtHdDM5NVV4bzUvZ1hFdDltRmt2?=
 =?utf-8?B?QUZmSVplNllxczJ2S0ZEVmUrYndYeXp5T2prQi9sbVJzbVZGcnVsY21WSHhk?=
 =?utf-8?B?QXBWQTdsVnl0S0xDb2V6cXpQREZjeVByMUs1UEowR0Y4OTNnSCtNaFhUc3Vi?=
 =?utf-8?B?em1naStYKzdoTHd3SEVCVW5JRjZ5UjhLbENobFJ5U2owZHFMMUExWU90U0dH?=
 =?utf-8?B?UEs2enRud2x4QmJaYzVJWHVpMVZxOEljQzlGMWhHMHh4Q1VpK1JHdTNlMWU2?=
 =?utf-8?B?dHFVa3c2N1ZrdkJFMWRvbUdGV1pzY0VMckZ6L2l0K01qMnM1NGlBaXpkR2Z4?=
 =?utf-8?B?ZW1xS1NvaVR0L2R3Z2xNVmNjOU5mZG5JUjdaQStZTmFUbVZaYVE2WmptQVBr?=
 =?utf-8?B?SVRjb2VsRmJMS2xzK1NUeElrcG9DL3hHbWs5QlNUQ2VKZkJKOVBxYmNFWWUx?=
 =?utf-8?B?eVJXbkFxMUhpUTVGakdvRGwwaC9NR3FMWm80YnhpQTFlRjdKM3hGZjF2bGN3?=
 =?utf-8?B?R1o3ZWlMUThmWmVVQzloS2N6ek9iMHZtdE9xNGZaUGZBMXY2bUhnQ2t5U1gx?=
 =?utf-8?B?MEhqMUlZVFhwMXBtaGMzS21QTlVzR21xdW4zcnFzcGR1ZWF1ZlpySlM3bUVu?=
 =?utf-8?B?SXZqV3VmVVY0Q09oZTZGODlIMHRwSW9CTVNaMHBtYWRrNUhFbDAzdTB2Wmcv?=
 =?utf-8?B?bFpOckZmamF3SWNQaTFTajVobXlmUkJwc3ByRFRvVCtmVEd6dkFCbWUxM3Zz?=
 =?utf-8?B?NUhmb3ZMdEQwS3M0VEExY2NPemVKQ21RcElveWgwWjZzRllPQStOS0NycTc2?=
 =?utf-8?B?ZDRYS0x5QTQyMzR1eGNOV3V0dXhBTUlIVjhXOEtnNGdEdi9TQlppQzZaalVV?=
 =?utf-8?B?eFZ0R2JzMDRRRDBvNzUyU0N3QndROVcwaHAxN2JuQkVKMFJPM05CcEU3SzZE?=
 =?utf-8?B?OXFVT1RSTGJqSFJDM1YxeGRJOENRUFcvTWJQV0I1M3lOOUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ektZQS85U3REVkIyVWVMR3FiWENtRTNwaGV4S0V1WUJEMDZZRVh6NVdqRUFm?=
 =?utf-8?B?dUNFdkNJejV2aHg4Y2M2eWtKUDFENEJXQmhxQTIwVVZURVhlUC9vWTIrQXM5?=
 =?utf-8?B?OTlWSDJJQVduRXl4RmFwYzVGK3pPY0t6MnZiQWQ2cm1QVVV3YVZsRFBhSFNt?=
 =?utf-8?B?ZVI2WEFQQWpkTGlSbTYzZGsrL2kzZEU5S2VXd3NFZk9MaHBUSmlPN2RKMkJD?=
 =?utf-8?B?dHowQWZjZ3UrZ0t6SWlxcDlFRytYNUw3VUtyV3p5OWo0dkZFZXRHUFZBWWJq?=
 =?utf-8?B?SmhvTlhjclZodDF2YUMyUkJpT3V3bTRXZW5BMnBudmtuejE4d3RQRWxISDRx?=
 =?utf-8?B?eG11QnFSbWhHMFZOektKbEpUOEZURVYxOG84VG41MGtTZjRPclJYVFpEenJU?=
 =?utf-8?B?UlFFL2lCc2o3eDhKeVFhS0RkcXFGUm1rbzV2TFA3Vmp5WTFNREx1ckJCb2Vk?=
 =?utf-8?B?TUI1Q0g5WXRvbVFnSFZtbjRKdU4wZU1FS1pEYndWZlE0QWwrb3NKNklnWTRW?=
 =?utf-8?B?ZnExSDA2VmN4YUFsREF2bmlVWDg1V2ZhdGhuUHVTcW5KQ2xLc0JYc3AwbVlt?=
 =?utf-8?B?dmQ3b2JSTlVZSnRnMjdoMWRuRUdMdkQxSnFDUjFidUdOenNVSWFQUG9wWkVn?=
 =?utf-8?B?Zllqb0RTTlY2cm5OZ3d3bmVrZ0xOSHFhQk9PVlA0R3FldVluSzFBRy9nWGdq?=
 =?utf-8?B?TDVKTkVTaS9PNDRWOUwxZTBra1gxYmRkU1llY2NqclBzaG9HQjZLK2wwckor?=
 =?utf-8?B?RHo3dzhzU3ZicDloQzQ1dVZ2aVNXS1dsd010QktiYW4vbm1HMzNqRFlJdzAw?=
 =?utf-8?B?ZGV3RnlTZVpwM01HdjZXRDJiYmtQRkRpTk1CNU5DenFmbUpzKzEwaFNkeFNC?=
 =?utf-8?B?K3BscWVhQ0k2RmU3UVhuU05YYlRsWnp3b1ZnZERhbFZHR2FtNVdERjNXaTVy?=
 =?utf-8?B?K3Z2S3BRZ1puTytjTEdSUjM3cmxjc242SHhwam0vM0RkckZ2dXNjQUpKeGpt?=
 =?utf-8?B?cndodjc4KzdHazVhMC9EdzY5MXFkckFTUHpQL1dkbFpKOGtIeGdxTnVPWHVk?=
 =?utf-8?B?d1N4Q2VPVGV6OUFweTNtZEVHMG5oMDdvOVZKcUhwY0tvNjZ0VHE0UzNMdWtO?=
 =?utf-8?B?MXpWenVDTVpYbXoyQnhpdGNOZFBTR08wdEc1d2R5RFRWK0R0UWk1bjJkVzZK?=
 =?utf-8?B?ZWgvL09qenViakVBbS9iZHkyMDRYRzhWZ3FGSC82cldFTnNnWjhvbmNxNEkv?=
 =?utf-8?B?OVlvd3F1S0JnZDkrU1NvUWdUbHFMQTVhM2xlbGQ3bkVWSWp4QU1acTBBcC9M?=
 =?utf-8?B?dzBpS1hiZWY4YVd4eTdPWXhKUDQ5ckpjdnZpejEvd1lHUlhLQlRpenB4WVdJ?=
 =?utf-8?B?RzlQYjRyYi83YzRySnJvSXgvMTYvRlhBdlhxd2N5OVh6RVU0NjRGTnVURDNm?=
 =?utf-8?B?SVZnRXRzdGF4bXdORGZTNXB0ampPOWtGYTBlZ01FckdHeU9BQ1dKZHRIa1Uz?=
 =?utf-8?B?UFpSa3JXMm9SVmlaQlNOMW9aZ0RhdmNzc1BXR1I1ZlR3WGVHelN4bWpsaHRO?=
 =?utf-8?B?YzA0c2g5a1FGS085ZDRPSDM4SVdENFhVNG8zTUZwNjlHNUljUEFOS1BSOWdu?=
 =?utf-8?B?Z2NLYW5Kd2wrekNIeUZSelU0dy81TUNvVm94c0JUZ2t2eGpnRVFXaDY4eTR5?=
 =?utf-8?B?VnpnaWpZUnFMQ24waXFieDlXbFV3QTRSc2VmRDE5K0tRZXZ2NHAwQjR5aFBm?=
 =?utf-8?B?cW5ZVWM2cHRNUHpLemZqSFB4OFRxSDJoa2d0NTk1T3lsSzFkdWdEMW1EbmJr?=
 =?utf-8?B?cVJ5SU9CMkt5SDJQSzQ1bi9ub2Y4ckg0bmZ6R3B4dE9ZVXQ2aGVPcXVMOG9R?=
 =?utf-8?B?Q0NpYS8zdlFZOTlWVUtzWkJKaWZhU3ZkODkrU2tneTlzeVVCV1hXamlhUmFV?=
 =?utf-8?B?T05EcFRWY2VYOGVFaFc4M0VCT3g5V2N2TThjZnBZSDdhQW5vL1g5MnNORSsv?=
 =?utf-8?B?eThMSFh1ZkppQk0xbzlZTXVuTjNWTDExbG44d2hFVnZBWEVUQkh6bUlSVXBL?=
 =?utf-8?B?THpnbjV6TDFZSVJtTDVkTmVlTnkyWlE4TnU2ajM2WWY3bFRsT3A0Uk0zNkpL?=
 =?utf-8?Q?O942NHem+GZDlU8SwxUqmf3lc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D5177F1A134314CB260A7F15A3ED688@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db8a7fec-9f9b-4c31-2e1a-08dca6268196
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 06:05:49.2727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TY5NYMn6Ki8X5nyFQAnQi8S00hqehpNLrFOo2qjQEbeUUjDhEP1DMhAGTXlNl2ekS4Bm071ZZZ80GodcVtS5Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8100

SGksIFNoYXduOg0KDQpPbiBXZWQsIDIwMjQtMDctMTcgYXQgMTM6MjQgKzA4MDAsIEhzaWFvIENo
aWVuIFN1bmcgdmlhIEI0IFJlbGF5IHdyb3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQ
bGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwgeW91IGhh
dmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gIEZyb206IEhzaWFvIENo
aWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gU3VwcG9ydCAiUHJlLW11
bHRpcGxpZWQiIGFscGhhIGJsZW5kaW5nIG1vZGUgaW4gTWl4ZXIuDQo+IEJlZm9yZSB0aGlzIHBh
dGNoLCBvbmx5IHRoZSBjb3ZlcmFnZSBtb2RlIGlzIHN1cHBvcnRlZC4NCj4gDQo+IFRvIHJlcGxh
Y2UgdGhlIGRlZmF1bHQgc2V0dGluZyB0aGF0IGlzIHNldCBpbiBtdGtfZXRoZHJfY29uZmlnKCks
DQo+IHdlIGNoYW5nZSBtdGtfZGRwX3dyaXRlX21hc2soKSB0byBtdGtfZGRwX3dyaXRlKCksIGFu
ZCB0aGlzIGNoYW5nZSB3aWxsDQo+IGFsc28gcmVzZXQgdGhlIE5PTl9QUkVNVUxUSV9TT1VSQ0Ug
Yml0IHRoYXQgd2FzIGFzc2lnbmVkIGluDQo+IG10a19ldGhkcl9jb25maWcoKS4gVGhlcmVmb3Jl
LCB3ZSBtdXN0IHN0aWxsIHNldCBOT05fUFJFTVVMVElfU09VUkNFIGJpdA0KPiBpZiB0aGUgYmxl
bmQgbW9kZSBpcyBub3QgRFJNX01PREVfQkxFTkRfUFJFTVVMVEkuDQoNClJldmlld2VkLWJ5OiBD
SyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5nZWxvR2lv
YWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8c2hhd24uc3VuZ0BtZWRpYXRl
ay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jIHwg
OSArKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19l
dGhkci5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19ldGhkci5jDQo+IGluZGV4IDgw
Y2NkYWQzNzQxYi4uZDFkOWNmOGIxMGUxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2V0aGRyLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19ldGhkci5jDQo+IEBAIC0zNiw2ICszNiw3IEBADQo+ICAjZGVmaW5lIE1JWF9TUkNfTDBfRU5C
SVQoMCkNCj4gICNkZWZpbmUgTUlYX0xfU1JDX0NPTihuKSgweDI4ICsgMHgxOCAqIChuKSkNCj4g
ICNkZWZpbmUgTk9OX1BSRU1VTFRJX1NPVVJDRSgyIDw8IDEyKQ0KPiArI2RlZmluZSBQUkVNVUxU
SV9TT1VSQ0UoMyA8PCAxMikNCj4gICNkZWZpbmUgTUlYX0xfU1JDX1NJWkUobikoMHgzMCArIDB4
MTggKiAobikpDQo+ICAjZGVmaW5lIE1JWF9MX1NSQ19PRkZTRVQobikoMHgzNCArIDB4MTggKiAo
bikpDQo+ICAjZGVmaW5lIE1JWF9GVU5DX0RDTTAweDEyMA0KPiBAQCAtMTc2LDYgKzE3NywxMSBA
QCB2b2lkIG10a19ldGhkcl9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25l
ZCBpbnQgaWR4LA0KPiAgYWxwaGFfY29uIHw9IHN0YXRlLT5iYXNlLmFscGhhICYgTUlYRVJfQUxQ
SEE7DQo+ICB9DQo+ICANCj4gK2lmIChzdGF0ZS0+YmFzZS5waXhlbF9ibGVuZF9tb2RlID09IERS
TV9NT0RFX0JMRU5EX1BSRU1VTFRJKQ0KPiArYWxwaGFfY29uIHw9IFBSRU1VTFRJX1NPVVJDRTsN
Cj4gK2Vsc2UNCj4gK2FscGhhX2NvbiB8PSBOT05fUFJFTVVMVElfU09VUkNFOw0KPiArDQo+ICBp
ZiAoKHN0YXRlLT5iYXNlLmZiICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEp
IHx8DQo+ICAgICAgc3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVO
RF9QSVhFTF9OT05FKSB7DQo+ICAvKg0KPiBAQCAtMTkzLDggKzE5OSw3IEBAIHZvaWQgbXRrX2V0
aGRyX2xheWVyX2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGludCBpZHgsDQo+
ICBtdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBwZW5kaW5nLT5oZWlnaHQgPDwgMTYgfCBhbGlnbl93
aWR0aCwgJm1peGVyLT5jbWRxX2Jhc2UsDQo+ICAgICAgICBtaXhlci0+cmVncywgTUlYX0xfU1JD
X1NJWkUoaWR4KSk7DQo+ICBtdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBvZmZzZXQsICZtaXhlci0+
Y21kcV9iYXNlLCBtaXhlci0+cmVncywgTUlYX0xfU1JDX09GRlNFVChpZHgpKTsNCj4gLW10a19k
ZHBfd3JpdGVfbWFzayhjbWRxX3BrdCwgYWxwaGFfY29uLCAmbWl4ZXItPmNtZHFfYmFzZSwgbWl4
ZXItPnJlZ3MsIE1JWF9MX1NSQ19DT04oaWR4KSwNCj4gLSAgIDB4MWZmKTsNCj4gK210a19kZHBf
d3JpdGUoY21kcV9wa3QsIGFscGhhX2NvbiwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLT5yZWdz
LCBNSVhfTF9TUkNfQ09OKGlkeCkpOw0KPiAgbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0LCBC
SVQoaWR4KSwgJm1peGVyLT5jbWRxX2Jhc2UsIG1peGVyLT5yZWdzLCBNSVhfU1JDX0NPTiwNCj4g
ICAgIEJJVChpZHgpKTsNCj4gIH0NCj4gDQo+IC0tIA0KPiAyLjQzLjANCj4gDQo+IA0K

