Return-Path: <linux-kernel+bounces-349910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAAF98FD2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2F81C21EDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D522281ACA;
	Fri,  4 Oct 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YHYSo2GN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CID6I0Uq"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF21FAA;
	Fri,  4 Oct 2024 06:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728021830; cv=fail; b=hoTdtttQqU9oUn7mDrO9C/cQbEbdbeufoZcCoJWH6dDah8xToN7+8Rq6vtqrwvBvC1ogHFBB4+0ObLaPdDBHRkNrYJsZFspq3ZJ/DFAsKnoR9ymtd2+CHebHh/Lx+W+lLQsbkZkGMGslk8kp88hyVfKlvYT49b8rZB0fK3OQcSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728021830; c=relaxed/simple;
	bh=AKz771j4n7j0ckGS4AYaW0P1bEZfEYoKbJBlhluKip0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uEMEWa/3H/3owcr958zF6/biKP9WBVMPMBwKiffwYnzZnQKimeZnjtSUZejD1Y8XprPmG+QAbvQanveSoOJH1fMigg1pVhsbckgDdZvYyIt9GiMYe/0RW8vseq219wOL8RLUXSf7SBxWKRdlALIRy5F5k4vrwhawacTVLLAWaso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YHYSo2GN; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CID6I0Uq; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 67f68a60821611efb66947d174671e26-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AKz771j4n7j0ckGS4AYaW0P1bEZfEYoKbJBlhluKip0=;
	b=YHYSo2GNM5f6ECVtBEpG+UoHwblmqgZewpLQ1EfxDGB3trokIkxqTbFwX0+lfLvS57OUyENB+N2BADK5o2qFt/X/S/carsx5VgjABnYeUXK0FRNW5q3a9yAFtTMPCeXXu5Kqb6wRKPOXlVLfkhPlIy9FRPYKmtwfpGE2lQrn7H0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:eb174d25-8001-4795-b83d-d64ac1fe66b9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:e586ba64-444a-4b47-a99a-591ade3b04b2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 67f68a60821611efb66947d174671e26-20241004
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 259786509; Fri, 04 Oct 2024 14:03:41 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 3 Oct 2024 23:03:40 -0700
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Oct 2024 14:03:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWL4F6ELZmGteUXPONd7FjZKIkZdraCI3xzI0onTIvvd9+16j0/FlfJxLqR9YlPq8fjrXzrr1jfiWUE3Ndew+bFNjtqIrnfNRPDJiFWFAp6Vgq7Rom8q2Z7NVLhfuFgaR8tE6/Df0z/c0/HjX+ZhmkQBfn7vAyMwoaHYQaEGLudtA5qxL4OROttyKu9k29IsRvqJXexDod7wsZStiIR0gE084I+LbuI7mHNmfSYMgGYqvHxhZS1sPD6DbWpoZ6dW5FuvaRx7cY5PRBDGSnNydEJU5tI6r1bNt5QhzThzDThB99/NGKJUbCiPYLNg8HIaNcsfDJeWkGtdLEEWqxlBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKz771j4n7j0ckGS4AYaW0P1bEZfEYoKbJBlhluKip0=;
 b=UU3xOSBUz3hMtZL0WiEKH6q6Purt3JtpERVkQ90Ka2I+9V6vjxugYy5tKEHEI7rsBozAJUai0sNZStDtZea3HwYJCU/RZQ9HGM2tDFdVbqYKig2/pP6nTBcZsi25q7lBxuslzUdwGmY59Z4m/Zj7/VyM7S8I1WoEWEiDrNPmPEYe1FHHtDdEc0POrQkkThsLV9LpcZDOLN30iewQZRHFZl2N5KFyVFSc3CxkPcwIRuv6mY0KeTY2t8WdNfOwwMbKqvhPvtt4a37STDMuSa/Jci+Gn1IfMEsvqmt03sIgdIDEb2MprXJ8kpfEhTab7dxNPqo90ZjcjRmkBKLnlHz/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKz771j4n7j0ckGS4AYaW0P1bEZfEYoKbJBlhluKip0=;
 b=CID6I0Uq7hEiSunNgo/riT7Gxho12qzngFMPiygsSxzogOISb0Z2vVR3yYX0v4xlxlYw8uz7c6Br4ZLLtYYJaJZA06ot6IDEupG3qxdMFuXmkoiAxmX2XV+iP3fgb2jLiDSbZ/wNWMRv75fE+JHE2BL9urlYpUzhriP97+Vn3Ng=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TY0PR03MB6583.apcprd03.prod.outlook.com (2603:1096:400:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 06:03:35 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 06:03:35 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"sui.jingfeng@linux.dev" <sui.jingfeng@linux.dev>, "wenst@chromium.org"
	<wenst@chromium.org>, Sjoerd Simons <sjoerd@collabora.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	=?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
	"michael@walle.cc" <michael@walle.cc>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WXUtY2hhbmcgTGVlICjmnY7nprnnkosp?= <Yu-chang.Lee@mediatek.com>,
	"mwalle@kernel.org" <mwalle@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
Subject: Re: [PATCH v10 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Topic: [PATCH v10 3/3] drm/mediatek: Implement OF graphs support for
 display paths
Thread-Index: AQHbA292H5spe39bB06Ujog96ornebJxzKIAgAAX5YCABFrkAA==
Date: Fri, 4 Oct 2024 06:03:35 +0000
Message-ID: <58ee09aeb5a224dbc8faee236ed1a77ce3fbd011.camel@mediatek.com>
References: <20240910105054.125005-1-angelogioacchino.delregno@collabora.com>
	 <01020191db8f22cd-0f5d733b-420e-453c-8607-a3e9f70f32d6-000000@eu-west-1.amazonses.com>
	 <e3953947f5cf05e8e6a2ec3448cf0c08a8c39c1c.camel@mediatek.com>
	 <56c4e87c-6774-4542-8ae7-dab89750081c@collabora.com>
In-Reply-To: <56c4e87c-6774-4542-8ae7-dab89750081c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TY0PR03MB6583:EE_
x-ms-office365-filtering-correlation-id: 8f74ace7-7496-4966-6ad3-08dce43a487e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M0dydmc1Wi9ZK0x3MzJhOTFJRk1zMHR1Z3FWRkxOSTRDR205QndKaCt4ZUNr?=
 =?utf-8?B?dFJEem0vZWQ1Mit1c1lpcW1WY3cycFgrUExhcEJlR1UzVmtwT0RQRFZDSHFx?=
 =?utf-8?B?WklVcjNxejFQVytQYVF1ejB2UE04S3JheS82RnBTcU11VWk3YnAvZ0dLb2pt?=
 =?utf-8?B?aHNiNXVVUUg5d3pZbVNlUlZJWDZQOStjck5reFJWRUV6RmVPN0t3ci9HMzZI?=
 =?utf-8?B?ellIdmRQalEvKzFCRFF6ZWR5dklOQTB3K2Q2eVdNT3ArRGdJL3A4NVM4OFdz?=
 =?utf-8?B?cVRQd3Y1WGpMVnFpZklNM04wVDFJQitqRnh6aGsxSS92WW1Da2RRcWpjVUlv?=
 =?utf-8?B?cUhCZ1h5d3o1RGdtWFd5RVFPaFVWc0w3eVA0STJ4VVk3QlhOcUhHRk1ZS2hj?=
 =?utf-8?B?T1NjRE9MeC9YKzFpL0pvbHozeFRVd09nclRqUXJNWG1McVc4Wm9rTU1FV1pL?=
 =?utf-8?B?ejFwNjV1c0M5RE9ZV3Z1UVVEZ1liTW9GMDMzcU44WE5HcmZrTUd3SXdIaU1K?=
 =?utf-8?B?TGpGTzZuQ3h4dzdKay84RDZtY1JHS241SmFVa2c5NEZ6SGUwLzFSL1VDYmdw?=
 =?utf-8?B?QkpuNko2ZTFCRmc5VmVTSkhMNHVZTGhPY2habnB6RTZJNWh5NXJ4TnR3amdD?=
 =?utf-8?B?K2RGRG5UdG1PNW9KeEV2bEhwZzBpcncwbDJYTmlieHp6NFlxZ2xvcEUrZ2ph?=
 =?utf-8?B?RUdwVTh3dVFaUlJvNmRDWVdnS1JERldZNDN2d0c2dktHdkVyVGJTMVVZNXQ0?=
 =?utf-8?B?VDNKd3I3WXdHQm1CbU1vSnJwUzN5dHkyR3N0ZTZUSlpYWFozOEhlTTlBV0Y4?=
 =?utf-8?B?OExyZ3FKZWtOTDA4NkNra0xhT1ZNWXZxQ2V0WUNnZm1TZm96ekNzZXp5TGY4?=
 =?utf-8?B?U0tjcGVNVWpMNVl2aElLdlhnSC9ZbEhiYzNyUTY5NVRwT0o2UzQzL3d5bEhV?=
 =?utf-8?B?Y2pTUTVieTgwN05OYlBlVFBTdjlndURuR3oxdDk0a2ZWZGhaL2F4SittZzdY?=
 =?utf-8?B?V2I3VlpubzdmWWkvMFVCdlFjcVZORHowN0xQTWdwRCswQ0wyMFdJS3NzUHBC?=
 =?utf-8?B?cFdDcExDOHNsL0lnQk9zUGlmSTJjc2o0SGZWdkU1VUllVGpjcDNXREJQTllW?=
 =?utf-8?B?OTU1S3VQVXFjMERmVG11cnBGOHo5NGIrY2lrcHRqSUpUTVh5R04rWVNFak55?=
 =?utf-8?B?azhEYVQrTkR6R0RQNTdHS3RLWXhRMWhadDhyZTRGU3R5SVliVE5xWWR5NEUr?=
 =?utf-8?B?Z0xLYlU1cEYyNmp3aWFwd3hsUzNybW05UjZRamwyNVhLMGM4SVRQYk81L2o3?=
 =?utf-8?B?TS9GRmJUQkkxY2FLZWdBbUppK1UwTEtPNlJtT0lFWGVqNTgzcHEwWU10NUZF?=
 =?utf-8?B?NlJka2N0cm1kRXV5QisvclFCZit1ZE9laXBjSUtSZzArRllUcld2ZTNib0gy?=
 =?utf-8?B?NDdJTnQwYjg0VGxjMitCUWJ1UnNCRWZUS2hnbzNBNlVjZ0g3RTVnclZ1c2wy?=
 =?utf-8?B?WU8vZm45TUFvWEJKSVVrV1pYVXE2SHJPMVpqbkh6QzFCa2RlbjhwV0NqcEIr?=
 =?utf-8?B?TnhSQy9mLzhwT3ZHQUsvNmM5QXFrV1hIY0FLQWZ0TzAvaFY0ejJsM1htbmRY?=
 =?utf-8?B?TnVvY0FyN0Z1RnVwbVhJTHFPelpwTmduNTJ5VC9QWVZhZTMvSEk5eERlY2Zt?=
 =?utf-8?B?MXhDYmVnbmZ5clc4Y1lZYTEzaUZxR3J3V3FkLyt4Zjl1dTA0YkkwWjlFVHNK?=
 =?utf-8?B?Z3hBcE84ZHBGTE1kS2E4SG9LM2Vmc2xRVmllbGNqcldneUliem5oOVhLOVFm?=
 =?utf-8?B?MDdtYU4rei9MQnFBUUxxQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEYyMXU2NnZRNEM5eXhNbHlXckY5MS9kd1pRNDYyNGhTK1AzWmlSNDRydFJm?=
 =?utf-8?B?dzVBVXVabnJmMWVyNmhyS2hIZGVlQ0pFdnB5ZEMvT2JSc3FNZUo3dHZYUFNN?=
 =?utf-8?B?QkxHcDlaUzQrMDJhQXYxQXdkb3pldnQ1aFRXWlJxaEpnRXRBSktuWUdJbDZS?=
 =?utf-8?B?U0FUS1hCY2VyZE9uYUoyQi9idG9sQjBkdmVyQmhJeTRoZS9KR21wYVNBQkVF?=
 =?utf-8?B?NldUSXppU2xrYkZvdkV2TDVJMG5kT2NvTjVRanoyazBGVVg2L2QyN0cySjM4?=
 =?utf-8?B?SEVUemF5SC8yL203UCtKc2Jqd1BVUlk3MHFWRk15R0phU3RXSVNtd09ROTVn?=
 =?utf-8?B?TXFvZm41YjBRZDFBOVczRTRmQ0wvUmNSVUFlSlVFdFErTjZFY3daYmlaU1FL?=
 =?utf-8?B?eCs3TUZSVmljU3c0NWhIeEdINmdNZHd1bmFqQnlzMGdiWlMxenZvRjlkZk82?=
 =?utf-8?B?emtWMXVLWndzZDF0cWpFZ25CTmlleTV2NnRoMjhzOW9Qa3FtUG4xQkFRdW9k?=
 =?utf-8?B?T21LOFQ3bVdCM3VhRlVVaXowWXRmb1RyOFNtZUJ6cHZIS3l2WGszeWRuTTMv?=
 =?utf-8?B?d1VST2xZZE5aWEhYV1ZHbmR1WkduYW5JLzNlTGJLTDVJTmdUYkNRQUhHSjNk?=
 =?utf-8?B?UklVZDNhYS9ROStTQTNHaHBudEtGd2dvMmtDVDZwU2VyYThnRGdKa0dDbUVj?=
 =?utf-8?B?TFJGZTJZeEtQaExXWWpyZk9PUHZ1Q3JZYlhNSnR4clFVaU9QS2FJeEpMdUpO?=
 =?utf-8?B?dnQwQ0lodUNydWFRV3lUSjQzd0l3Nlg3TEkrbkZxV2lNUU9wcVdxR3lhZE1p?=
 =?utf-8?B?QTJuRHRQK01sV3ZUR213blhmYml5b3ZaRkN0MmFYR2hscGpCeXJud3NDdUZG?=
 =?utf-8?B?R3doQVRQSlgzSGYzdkxBa1BUNmZRd0JXMjlsRk01WmxxbVpVWnVIUlJab2lH?=
 =?utf-8?B?TnIxNVAxYW9hSlRNQzBRUFo1MTFFakhPV0c2M0lRRTBVQndtWURWZ1h4YWxh?=
 =?utf-8?B?TXFoQVpjWUVqS043MThQUzU4aEozTEFuNUY0c0hzYi9ZN1VGQXBzbG1pSDc1?=
 =?utf-8?B?b0wxZVlrSTRiSVkvS3kxZ1MzTVVhNUpCN0J0cFhNWmxxcm1NNVJrTk5MMVpI?=
 =?utf-8?B?NDg5M1czeGwwTS9mdjNPSUJTU3JseVNNWUp2VGdJbHVXN2RRV1IyRTU5ZkpK?=
 =?utf-8?B?djhHVXB4SGx6akEvalJ2VC81cThaNnNjZ3pqY2dKbURGV0ljYXFGeWRZTUph?=
 =?utf-8?B?NGw0eDgvRVM0MFhoMlg4bjVDSzE2aldUdTJDUGp2OWNCSlBkL0UxeWNnbWVy?=
 =?utf-8?B?aGF3NTRaQmRRRERCT01NNThwSTFNYVMreGpPczFwNThYeTJJZ2lSeVFLTUJN?=
 =?utf-8?B?d0xFcVFvYmxuVXZVR3pJNmc3MGM0YWN3L01VOTZUZjFFNUt6NVZqV0h6dXA4?=
 =?utf-8?B?am9GOEZRdVQ1Sm1UU3ZWdlcrM1dQZlg1WVVCb3dKK0paeXkxOTBlbHNBbUNK?=
 =?utf-8?B?RnJjeG9iMExFUHh1UzFxakR3ZjFYWC9sVHYzbUZKajN0VVRJcTFXWjJ3VjVV?=
 =?utf-8?B?dy83UDVReHlZWGw0eHZpQ2R5SklCWkovbmpVRFlLSDl6VFZFWWFlS3JCaHkz?=
 =?utf-8?B?YVRkTWVqaTdSMURvQm5MbnNkM0c2WlBpcHN5WnM1ZHQrOUovMzlHNG1uMGx3?=
 =?utf-8?B?L0xFZGZ1cjZNRWtyUzJTUkh1ZVFzUGVrbllIL1dYY21JQ2hJT2xwZmdXaVg3?=
 =?utf-8?B?ZlAyT0ZXelhBUWdyUm81V1FqZ2RrSHowUUdhelp0VXl3ZFRabXd2Q2tJSCt3?=
 =?utf-8?B?cmQwU2xHTWRYYjVKR3lKRjJoeTljbGFZSmUvbElYbjNxekViV3Q1NUNxaHFJ?=
 =?utf-8?B?SHpQQVUwRGZlNktkdjFJVlRRaVh6T0xQZDBITVNjWUtmYktHUHYxNGgwZjRp?=
 =?utf-8?B?RmkzK2NPU1Z1enZLOTJaaFlEaEVDeTExYlRlaHlraEd4Sy9oQ1ZDT0N0ODNH?=
 =?utf-8?B?M1h3S2lGdkp4eEpFZ01WR2RaQlRpWVZxYU1TK2Jyb2dCQXlCZHE3LzV5UUw0?=
 =?utf-8?B?TVBDSVdYb2VUWmk4M1dwUEpHRnBqeFFTdFhTL2UwREpGRmt3R0lYUlBPbWZC?=
 =?utf-8?Q?Gg32PixIPwKTpZ1UJCRC9F/O2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6F954FD3306B34FAF7B4D6566A5AAB6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f74ace7-7496-4966-6ad3-08dce43a487e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2024 06:03:35.4761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcuJbfR63ecQLt/VN3gNbHVWY5RqYeAEwmvR4FofU6e8J+uEaYxUlCyQekyXnLqFNn7zTR2C07Iq+tMl1tg4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6583

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDI0LTEwLTAxIGF0IDEzOjMzICswMjAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDEvMTAvMjQgMTI6MDcsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBUdWUs
IDIwMjQtMDktMTAgYXQgMTA6NTEgKzAwMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIHdy
b3RlOg0KPiA+ID4gSXQgaXMgaW1wb3NzaWJsZSB0byBhZGQgZWFjaCBhbmQgZXZlcnkgcG9zc2li
bGUgRERQIHBhdGggY29tYmluYXRpb24NCj4gPiA+IGZvciBlYWNoIGFuZCBldmVyeSBwb3NzaWJs
ZSBjb21iaW5hdGlvbiBvZiBTb0MgYW5kIGJvYXJkOiByaWdodCBub3csDQo+ID4gPiB0aGlzIGRy
aXZlciBoYXJkY29kZXMgY29uZmlndXJhdGlvbiBmb3IgMTAgU29DcyBhbmQgdGhpcyBpcyBnb2lu
ZyB0bw0KPiA+ID4gZ3JvdyBsYXJnZXIgYW5kIGxhcmdlciwgYW5kIHdpdGggbmV3IGhhY2tzIGxp
a2UgdGhlIGludHJvZHVjdGlvbiBvZg0KPiA+ID4gbXRrX2RybV9yb3V0ZSB3aGljaCBpcyBhbnl3
YXkgbm90IGVub3VnaCBmb3IgYWxsIGZpbmFsIHJvdXRlcyBhcyB0aGUNCj4gPiA+IERTSSBjYW5u
b3QgYmUgY29ubmVjdGVkIHRvIE1FUkdFIGlmIGl0J3Mgbm90IGEgZHVhbC1EU0ksIG9yIGVuYWJs
aW5nDQo+ID4gPiBEU0MgcHJldmVudGl2ZWx5IGRvZXNuJ3Qgd29yayBpZiB0aGUgZGlzcGxheSBk
b2Vzbid0IHN1cHBvcnQgaXQsIG9yDQo+ID4gPiBvdGhlcnMuDQo+ID4gPiANCj4gPiA+IFNpbmNl
IHByYWN0aWNhbGx5IGFsbCBkaXNwbGF5IElQcyBpbiBNZWRpYVRlayBTb0NzIHN1cHBvcnQgYmVp
bmcNCj4gPiA+IGludGVyY29ubmVjdGVkIHdpdGggZGlmZmVyZW50IGluc3RhbmNlcyBvZiBvdGhl
ciwgb3IgdGhlIHNhbWUsIElQcw0KPiA+ID4gb3Igd2l0aCBkaWZmZXJlbnQgSVBzIGFuZCBpbiBk
aWZmZXJlbnQgY29tYmluYXRpb25zLCB0aGUgZmluYWwgRERQDQo+ID4gPiBwaXBlbGluZSBpcyBl
ZmZlY3RpdmVseSBhIGJvYXJkIHNwZWNpZmljIGNvbmZpZ3VyYXRpb24uDQo+ID4gPiANCj4gPiA+
IEltcGxlbWVudCBPRiBncmFwaHMgc3VwcG9ydCB0byB0aGUgbWVkaWF0ZWstZHJtIGRyaXZlcnMs
IGFsbG93aW5nIHRvDQo+ID4gPiBzdG9wIGhhcmRjb2RpbmcgdGhlIHBhdGhzLCBhbmQgcHJldmVu
dGluZyB0aGlzIGRyaXZlciB0byBnZXQgYSBodWdlDQo+ID4gPiBhbW91bnQgb2YgYXJyYXlzIGZv
ciBlYWNoIGJvYXJkIGFuZCBTb0MgY29tYmluYXRpb24sIGFsc28gcGF2aW5nIHRoZQ0KPiA+ID4g
d2F5IHRvIHNoYXJlIHRoZSBzYW1lIG10a19tbXN5c19kcml2ZXJfZGF0YSBiZXR3ZWVuIG11bHRp
cGxlIFNvQ3MsDQo+ID4gPiBtYWtpbmcgaXQgbW9yZSBzdHJhaWdodGZvcndhcmQgdG8gYWRkIHN1
cHBvcnQgZm9yIG5ldyBjaGlwcy4NCj4gPiA+IA0KPiA+ID4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRy
ZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+ID4gPiBUZXN0ZWQtYnk6IEFsZXhh
bmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+DQo+ID4gPiBBY2tlZC1ieTogU3Vp
IEppbmdmZW5nIDxzdWkuamluZ2ZlbmdAbGludXguZGV2Pg0KPiA+ID4gVGVzdGVkLWJ5OiBNaWNo
YWVsIFdhbGxlIDxtd2FsbGVAa2VybmVsLm9yZz4gIyBvbiBrb250cm9uLXNiYy1pMTIwMA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2Fj
Y2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gPiA+IC0tLQ0KPiA+IA0KPiA+IFtzbmlw
XQ0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gK2Jvb2wgbXRrX292bF9hZGFwdG9yX2lzX2NvbXBfcHJl
c2VudChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQo+ID4gPiArew0KPiA+ID4gKwllbnVtIG10
a19vdmxfYWRhcHRvcl9jb21wX3R5cGUgdHlwZTsNCj4gPiA+ICsJaW50IHJldDsNCj4gPiA+ICsN
Cj4gPiA+ICsJcmV0ID0gb3ZsX2FkYXB0b3Jfb2ZfZ2V0X2RkcF9jb21wX3R5cGUobm9kZSwgJnR5
cGUpOw0KPiA+ID4gKwlpZiAocmV0KQ0KPiA+ID4gKwkJcmV0dXJuIGZhbHNlOw0KPiA+ID4gKw0K
PiA+ID4gKwlpZiAodHlwZSA+PSBPVkxfQURBUFRPUl9UWVBFX05VTSkNCj4gPiA+ICsJCXJldHVy
biBmYWxzZTsNCj4gPiA+ICsNCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogRVRIRFIgYW5kIFBhZGRp
bmcgYXJlIHVzZWQgZXhjbHVzaXZlbHkgaW4gT1ZMIEFkYXB0b3I6IGlmIHRoaXMNCj4gPiA+ICsJ
ICogY29tcG9uZW50IGlzIG5vdCBvbmUgb2YgdGhvc2UsIGl0J3MgbGlrZWx5IG5vdCBhbiBPVkwg
QWRhcHRvciBwYXRoLg0KPiA+ID4gKwkgKi8NCj4gPiANCj4gPiBJIGRvbid0IGtub3cgeW91ciBs
b2dpYyBoZXJlLg0KPiA+IFRoZSBPVkwgQWRhcHRvciBwaXBlbGluZSBpczoNCj4gPiANCj4gPiBt
ZHBfcmRtYSAtPiBwYWRkaW5nIC0tLSsgICAgICArLS0tLS0tLSsNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgTWVyZ2UgLT4gfCAgICAgICB8DQo+ID4gbWRwX3JkbWEgLT4gcGFkZGluZyAtLS0r
ICAgICAgfCAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgfA0KPiA+IG1kcF9yZG1hIC0+IHBhZGRpbmcgLS0tKyAgICAgIHwgICAgICAgfA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBNZXJnZSAtPiB8ICAgICAgIHwNCj4gPiBtZHBfcmRtYSAtPiBw
YWRkaW5nIC0tLSsgICAgICB8ICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCBFVEhEUiB8DQo+ID4gbWRwX3JkbWEgLT4gcGFkZGluZyAtLS0rICAgICAgfCAgICAg
ICB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIE1lcmdlIC0+IHwgICAgICAgfA0KPiA+IG1k
cF9yZG1hIC0+IHBhZGRpbmcgLS0tKyAgICAgIHwgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgICAgIHwNCj4gPiBtZHBfcmRtYSAtPiBwYWRkaW5nIC0tLSsg
ICAgICB8ICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgTWVyZ2UgLT4gfCAgICAg
ICB8DQo+ID4gbWRwX3JkbWEgLT4gcGFkZGluZyAtLS0rICAgICAgKy0tLS0tLS0rDQo+ID4gDQo+
ID4gU28gbWRwX3JkbWEgYW5kIG1lcmdlIGlzIG5vdCBPVkwgQWRhcHRvcj8NCj4gPiANCj4gDQo+
IFllcywgYW5kIGluIGRldmljZSB0cmVlLCB5b3UgZXhwcmVzcyB0aGF0IGV4YWN0bHkgbGlrZSB5
b3UganVzdCBwaWN0dXJlZC4NCj4gDQo+IE9WTCBBZGFwdG9yIGlzIHRyZWF0ZWQgbGlrZSBhIHNv
ZnR3YXJlIGNvbXBvbmVudCBpbnRlcm5hbGx5LCBhbmQgbWFuYWdlcw0KPiBpdHMgb3duIG1lcmdl
IHBpcGVzIGV4YWN0bHkgbGlrZSBiZWZvcmUgdGhpcyBjb21taXQuDQo+IA0KPiBJbiBjYXNlIHRo
ZXJlIHdpbGwgYmUgYW55IG5lZWQgdG8gZXhwcmVzcyBPVkwgQWRhcHRvciBhcyBoYXJkd2FyZSBj
b21wb25lbnQsDQo+IGl0IHdpbGwgYmUgcG9zc2libGUgdG8gZG8gc28gd2l0aCBubyBtb2RpZmlj
YXRpb24gdG8gdGhlIGJpbmRpbmdzLg0KPiANCj4gPiANCj4gPiA+ICsJcmV0dXJuIHR5cGUgPT0g
T1ZMX0FEQVBUT1JfVFlQRV9FVEhEUiB8fCB0eXBlID09IE9WTF9BREFQVE9SX1RZUEVfUEFERElO
RzsNCj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiAgIA0KPiA+IA0KPiA+IFtzbmlwXQ0KPiA+IA0K
PiA+ID4gKw0KPiA+ID4gKy8qKg0KPiA+ID4gKyAqIG10a19kcm1fb2ZfZGRwX3BhdGhfYnVpbGRf
b25lIC0gQnVpbGQgYSBEaXNwbGF5IEhXIFBpcGVsaW5lIGZvciBhIENSVEMgUGF0aA0KPiA+ID4g
KyAqIEBkZXY6ICAgICAgICAgIFRoZSBtZWRpYXRlay1kcm0gZGV2aWNlDQo+ID4gPiArICogQGNw
YXRoOiAgICAgICAgQ1JUQyBQYXRoIHJlbGF0aXZlIHRvIGEgVkRPIG9yIE1NU1lTDQo+ID4gPiAr
ICogQG91dF9wYXRoOiAgICAgUG9pbnRlciB0byBhbiBhcnJheSB0aGF0IHdpbGwgY29udGFpbiB0
aGUgbmV3IHBpcGVsaW5lDQo+ID4gPiArICogQG91dF9wYXRoX2xlbjogTnVtYmVyIG9mIGVudHJp
ZXMgaW4gdGhlIHBpcGVsaW5lIGFycmF5DQo+ID4gPiArICoNCj4gPiA+ICsgKiBNZWRpYVRlayBT
b0NzIGNhbiB1c2UgZGlmZmVyZW50IEREUCBoYXJkd2FyZSBwaXBlbGluZXMgKG9yIHBhdGhzKSBk
ZXBlbmRpbmcNCj4gPiA+ICsgKiBvbiB0aGUgYm9hcmQtc3BlY2lmaWMgZGVzaXJlZCBkaXNwbGF5
IGNvbmZpZ3VyYXRpb247IHRoaXMgZnVuY3Rpb24gd2Fsa3MNCj4gPiA+ICsgKiB0aHJvdWdoIGFs
bCBvZiB0aGUgb3V0cHV0IGVuZHBvaW50cyBzdGFydGluZyBmcm9tIGEgVkRPIG9yIE1NU1lTIGhh
cmR3YXJlDQo+ID4gPiArICogaW5zdGFuY2UgYW5kIGJ1aWxkcyB0aGUgcmlnaHQgcGlwZWxpbmUg
YXMgc3BlY2lmaWVkIGluIGRldmljZSB0cmVlcy4NCj4gPiA+ICsgKg0KPiA+ID4gKyAqIFJldHVy
bjoNCj4gPiA+ICsgKiAqICUwICAgICAgIC0gRGlzcGxheSBIVyBQaXBlbGluZSBzdWNjZXNzZnVs
bHkgYnVpbHQgYW5kIHZhbGlkYXRlZA0KPiA+ID4gKyAqICogJS1FTk9FTlQgLSBEaXNwbGF5IHBp
cGVsaW5lIHdhcyBub3Qgc3BlY2lmaWVkIGluIGRldmljZSB0cmVlDQo+ID4gPiArICogKiAlLUVJ
TlZBTCAtIERpc3BsYXkgcGlwZWxpbmUgYnVpbHQgYnV0IHZhbGlkYXRpb24gZmFpbGVkDQo+ID4g
PiArICogKiAlLUVOT01FTSAtIEZhaWx1cmUgdG8gYWxsb2NhdGUgcGlwZWxpbmUgYXJyYXkgdG8g
cGFzcyB0byB0aGUgY2FsbGVyDQo+ID4gPiArICovDQo+ID4gPiArc3RhdGljIGludCBtdGtfZHJt
X29mX2RkcF9wYXRoX2J1aWxkX29uZShzdHJ1Y3QgZGV2aWNlICpkZXYsIGVudW0gbXRrX2NydGNf
cGF0aCBjcGF0aCwNCj4gPiA+ICsJCQkJCSBjb25zdCB1bnNpZ25lZCBpbnQgKipvdXRfcGF0aCwN
Cj4gPiA+ICsJCQkJCSB1bnNpZ25lZCBpbnQgKm91dF9wYXRoX2xlbikNCj4gPiA+ICt7DQo+ID4g
PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbmV4dCwgKnByZXYsICp2ZG8gPSBkZXYtPnBhcmVudC0+
b2Zfbm9kZTsNCj4gPiA+ICsJdW5zaWduZWQgaW50IHRlbXBfcGF0aFtERFBfQ09NUE9ORU5UX0RS
TV9JRF9NQVhdID0geyAwIH07DQo+ID4gPiArCXVuc2lnbmVkIGludCAqZmluYWxfZGRwX3BhdGg7
DQo+ID4gPiArCXVuc2lnbmVkIHNob3J0IGludCBpZHggPSAwOw0KPiA+ID4gKwlib29sIG92bF9h
ZGFwdG9yX2NvbXBfYWRkZWQgPSBmYWxzZTsNCj4gPiA+ICsJaW50IHJldDsNCj4gPiA+ICsNCj4g
PiA+ICsJLyogR2V0IHRoZSBmaXJzdCBlbnRyeSBmb3IgdGhlIHRlbXBfcGF0aCBhcnJheSAqLw0K
PiA+ID4gKwlyZXQgPSBtdGtfZHJtX29mX2dldF9kZHBfZXBfY2lkKHZkbywgMCwgY3BhdGgsICZu
ZXh0LCAmdGVtcF9wYXRoW2lkeF0pOw0KPiA+ID4gKwlpZiAocmV0KSB7DQo+ID4gPiArCQlpZiAo
bmV4dCAmJiB0ZW1wX3BhdGhbaWR4XSA9PSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUikg
ew0KPiA+IA0KPiA+IG1kcF9yZG1hIHdvdWxkIG5vdCBiZSBERFBfQ09NUE9ORU5UX0RSTV9PVkxf
QURBUFRPUi4NCj4gDQo+IFRoaXMgcGllY2Ugb2YgY29kZSBqdXN0IGF2b2lkcyBhZGRpbmcgT1ZM
X0FEQVBUT1IgbW9yZSB0aGFuIG9uY2UgdG8gdGhlIHBpcGVsaW5lLg0KPiANCj4gPiANCj4gPiA+
ICsJCQlkZXZfZGJnKGRldiwgIkFkZGluZyBPVkwgQWRhcHRvciBmb3IgJXBPRlxuIiwgbmV4dCk7
DQo+ID4gPiArCQkJb3ZsX2FkYXB0b3JfY29tcF9hZGRlZCA9IHRydWU7DQo+ID4gPiArCQl9IGVs
c2Ugew0KPiA+ID4gKwkJCWlmIChuZXh0KQ0KPiA+ID4gKwkJCQlkZXZfZXJyKGRldiwgIkludmFs
aWQgY29tcG9uZW50ICVwT0ZcbiIsIG5leHQpOw0KPiA+ID4gKwkJCWVsc2UNCj4gPiA+ICsJCQkJ
ZGV2X2VycihkZXYsICJDYW5ub3QgZmluZCBmaXJzdCBlbmRwb2ludCBmb3IgcGF0aCAlZFxuIiwg
Y3BhdGgpOw0KPiA+ID4gKw0KPiA+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gPiArCQl9DQo+ID4g
PiArCX0NCj4gPiA+ICsJaWR4Kys7DQo+ID4gPiArDQo+ID4gPiArCS8qDQo+ID4gPiArCSAqIFdh
bGsgdGhyb3VnaCBwb3J0IG91dHB1dHMgdW50aWwgd2UgcmVhY2ggdGhlIGxhc3QgdmFsaWQgbWVk
aWF0ZWstZHJtIGNvbXBvbmVudC4NCj4gPiA+ICsJICogVG8gYmUgdmFsaWQsIHRoaXMgbXVzdCBl
bmQgd2l0aCBhbiAiaW52YWxpZCIgY29tcG9uZW50IHRoYXQgaXMgYSBkaXNwbGF5IG5vZGUuDQo+
ID4gPiArCSAqLw0KPiA+ID4gKwlkbyB7DQo+ID4gPiArCQlwcmV2ID0gbmV4dDsNCj4gPiA+ICsJ
CXJldCA9IG10a19kcm1fb2ZfZ2V0X2RkcF9lcF9jaWQobmV4dCwgMSwgY3BhdGgsICZuZXh0LCAm
dGVtcF9wYXRoW2lkeF0pOw0KPiA+ID4gKwkJb2Zfbm9kZV9wdXQocHJldik7DQo+ID4gPiArCQlp
ZiAocmV0KSB7DQo+ID4gPiArCQkJb2Zfbm9kZV9wdXQobmV4dCk7DQo+ID4gPiArCQkJYnJlYWs7
DQo+ID4gPiArCQl9DQo+ID4gPiArDQo+ID4gPiArCQkvKg0KPiA+ID4gKwkJICogSWYgdGhpcyBp
cyBhbiBPVkwgYWRhcHRvciBleGNsdXNpdmUgY29tcG9uZW50IGFuZCBvbmUgb2YgdGhvc2UNCj4g
PiA+ICsJCSAqIHdhcyBhbHJlYWR5IGFkZGVkLCBkb24ndCBhZGQgYW5vdGhlciBpbnN0YW5jZSBv
ZiB0aGUgZ2VuZXJpYw0KPiA+ID4gKwkJICogRERQX0NPTVBPTkVOVF9PVkxfQURBUFRPUiwgYXMg
dGhpcyBpcyB1c2VkIG9ubHkgdG8gZGVjaWRlIHdoZXRoZXINCj4gPiA+ICsJCSAqIHRvIHByb2Jl
IHRoYXQgY29tcG9uZW50IG1hc3RlciBkcml2ZXIgb2Ygd2hpY2ggb25seSBvbmUgaW5zdGFuY2UN
Cj4gPiA+ICsJCSAqIGlzIG5lZWRlZCBhbmQgcG9zc2libGUuDQo+ID4gPiArCQkgKi8NCj4gPiA+
ICsJCWlmICh0ZW1wX3BhdGhbaWR4XSA9PSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUikg
ew0KPiA+IA0KPiA+IG1lcmdlIHdvdWxkIG5vdCBiZSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURB
UFRPUi4NCj4gPiBGaW5hbGx5LCB0aGUgcGF0aCB3b3VsZCBiZToNCj4gPiANCj4gPiBtZHBfcmRt
YSAtPiBvdmwgYWRhcHRvciAocGFkZGluZykgLT4gbWVyZ2UgLT4gKGV0aGRyIGlzIHNraXBwZWQg
aGVyZSkgLi4uDQo+ID4gDQo+IA0KPiBBZ2FpbiwgdGhlIHBhdGggaW4gdGhlIE9GIGdyYXBoIGlz
IGV4cHJlc3NlZCBleGFjdGx5IGxpa2UgeW91IHNhaWQuDQoNCkkga25vdyB0aGUgT0YgZ3JhcGgg
aXMgZXhwcmVzc2VkIGxpa2UgSSBzYWlkLg0KQnV0IEkgY2FyZSBhYm91dCB0aGUgcGF0aCBpbiBk
cml2ZXIgc2hvdWxkIGxpa2UgdGhpczoNCg0Kc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCBtdDgx
OTVfbXRrX2RkcF9leHRbXSA9IHsNCiAgICAgICAgRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBU
T1IsDQogICAgICAgIEREUF9DT01QT05FTlRfTUVSR0U1LA0KICAgICAgICBERFBfQ09NUE9ORU5U
X0RQX0lOVEYxLA0KfTsNCg0KSW4gT0YgZ3JhcGgsIHRoZSBmaXJzdCBjb21wb25lbnQgaXMgbWRw
X3JkbWEgYW5kIG10a19vdmxfYWRhcHRvcl9pc19jb21wX3ByZXNlbnQoKSB3b3VsZCByZXR1cm4g
ZmFsc2UgZm9yIG1kcF9yZG1hLg0KU28gSSB0aGluayB0aGlzIHdvdWxkIG1ha2UgbXRrX2RybV9v
Zl9kZHBfcGF0aF9idWlsZF9vbmUoKSByZXR1cm4gZXJyb3IgYW5kIHRoZSBwYXRoIGlzIG5vdCBj
cmVhdGVkLg0KSWYgSSdtIHdyb25nLCBwbGVhc2UgZXhwbGFpbiBob3cgdGhpcyBjb2RlIHdvdWxk
IHJlc3VsdCBpbiB0aGUgcGF0aCBsaWtlIG10ODE5NV9tdGtfZGRwX2V4dFtdLg0KDQpJZiB5b3Ug
ZG9lcyBub3QgdGVzdCB0aGlzIHdpdGggbXQ4MTk1IGV4dGVybmFsIGRpc3BsYXkgcGF0aCwgbWF5
YmUgd2UgY291bGQganVzdCBkcm9wIHRoZSBjb2RlIGFib3V0IE9WTCBhZGFwdG9yIHdpdGggYSBU
T0RPIGNvbW1lbnQuDQoNClJlZ2FyZHMsDQpDSw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8N
Cj4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0KPiA+ID4gKwkJCWlmICghb3ZsX2FkYXB0
b3JfY29tcF9hZGRlZCkNCj4gPiA+ICsJCQkJb3ZsX2FkYXB0b3JfY29tcF9hZGRlZCA9IHRydWU7
DQo+ID4gPiArCQkJZWxzZQ0KPiA+ID4gKwkJCQlpZHgtLTsNCj4gPiA+ICsJCX0NCj4gPiA+ICsJ
fSB3aGlsZSAoKytpZHggPCBERFBfQ09NUE9ORU5UX0RSTV9JRF9NQVgpOw0KPiA+ID4gKw0KPiA+
ID4gKwkvKg0KPiA+ID4gKwkgKiBUaGUgZGV2aWNlIGNvbXBvbmVudCBtaWdodCBub3QgYmUgZW5h
YmxlZDogaW4gdGhhdCBjYXNlLCBkb24ndA0KPiA+ID4gKwkgKiBjaGVjayB0aGUgbGFzdCBlbnRy
eSBhbmQganVzdCByZXBvcnQgdGhhdCB0aGUgZGV2aWNlIGlzIG1pc3NpbmcuDQo+ID4gPiArCSAq
Lw0KPiA+ID4gKwlpZiAocmV0ID09IC1FTk9ERVYpDQo+ID4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+
ID4gKw0KPiA+ID4gKwkvKiBJZiB0aGUgbGFzdCBlbnRyeSBpcyBub3QgYSBmaW5hbCBkaXNwbGF5
IG91dHB1dCwgdGhlIGNvbmZpZ3VyYXRpb24gaXMgd3JvbmcgKi8NCj4gPiA+ICsJc3dpdGNoICh0
ZW1wX3BhdGhbaWR4IC0gMV0pIHsNCj4gPiA+ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RQX0lOVEYw
Og0KPiA+ID4gKwljYXNlIEREUF9DT01QT05FTlRfRFBfSU5URjE6DQo+ID4gPiArCWNhc2UgRERQ
X0NPTVBPTkVOVF9EUEkwOg0KPiA+ID4gKwljYXNlIEREUF9DT01QT05FTlRfRFBJMToNCj4gPiA+
ICsJY2FzZSBERFBfQ09NUE9ORU5UX0RTSTA6DQo+ID4gPiArCWNhc2UgRERQX0NPTVBPTkVOVF9E
U0kxOg0KPiA+ID4gKwljYXNlIEREUF9DT01QT05FTlRfRFNJMjoNCj4gPiA+ICsJY2FzZSBERFBf
Q09NUE9ORU5UX0RTSTM6DQo+ID4gPiArCQlicmVhazsNCj4gPiA+ICsJZGVmYXVsdDoNCj4gPiA+
ICsJCWRldl9lcnIoZGV2LCAiSW52YWxpZCBkaXNwbGF5IGh3IHBpcGVsaW5lLiBMYXN0IGNvbXBv
bmVudDogJWQgKHJldD0lZClcbiIsDQo+ID4gPiArCQkJdGVtcF9wYXRoW2lkeCAtIDFdLCByZXQp
Ow0KPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArCX0NCj4gPiA+ICsNCj4gPiA+ICsJ
ZmluYWxfZGRwX3BhdGggPSBkZXZtX2ttZW1kdXAoZGV2LCB0ZW1wX3BhdGgsIGlkeCAqIHNpemVv
Zih0ZW1wX3BhdGhbMF0pLCBHRlBfS0VSTkVMKTsNCj4gPiA+ICsJaWYgKCFmaW5hbF9kZHBfcGF0
aCkNCj4gPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ID4gKw0KPiA+ID4gKwlkZXZfZGJnKGRl
diwgIkRpc3BsYXkgSFcgUGlwZWxpbmUgYnVpbHQgd2l0aCAlZCBjb21wb25lbnRzLlxuIiwgaWR4
KTsNCj4gPiA+ICsNCj4gPiA+ICsJLyogUGlwZWxpbmUgYnVpbHQhICovDQo+ID4gPiArCSpvdXRf
cGF0aCA9IGZpbmFsX2RkcF9wYXRoOw0KPiA+ID4gKwkqb3V0X3BhdGhfbGVuID0gaWR4Ow0KPiA+
ID4gKw0KPiA+ID4gKwlyZXR1cm4gMDsNCj4gPiA+ICt9DQo+ID4gPiArDQo+IA0KPiANCj4gDQo=

