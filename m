Return-Path: <linux-kernel+bounces-221445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E390F3AF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFCB1C221FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E149D2135B;
	Wed, 19 Jun 2024 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jqIdmRIG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ES36HFRP"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69A1D54A
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718813174; cv=fail; b=lqOJBlo+CnMve7wMUlcEDBtUFUtAw5Ox9of5NbfCtx5NGGcC+I8capzGahpbJsKfdSt3s5igkt8pRagxaHuqvRsSAIOQTZEQ4g/RtzBGhhVMIJCeVLa2kWCis5rUh+LB3fdOin0fTjIXVbODhsAs+bp3uRx3u/yi/ZlDoF2yvsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718813174; c=relaxed/simple;
	bh=zVwtChdiAP5oxAPt6zeLNhVjP9ImrPrfqZE4e6AK0Yc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l2hHJ6cTzniISTRBkKlLR7L/n1boAfMHzlXCdjxj9xDVLNWlIXguZ2DYwkHaivjv7r4KpnPDbC0hCl5hI1llHj5/kcXKWmC87k10QYIYHhfSul7NtoFJkuuoQE3FULpumxcI7hfgwdGNQO8kQ0Seja8sVuB3d4eKYikP5hB9kUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jqIdmRIG; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ES36HFRP; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d67330b62e5511ef99dc3f8fac2c3230-20240620
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zVwtChdiAP5oxAPt6zeLNhVjP9ImrPrfqZE4e6AK0Yc=;
	b=jqIdmRIGQYdhHry02DffzP2AQ0p67fKxeiLNlvsVpWgDqy15pA+tvw3baEOE6JAO85XLsfqM50QGaP8/BTOKrRS2htHe09JrUjGPWWT02j2SjK7SMXXDJl/1UAbbUmzbOZwMwD4pH3bNzvcSmvnMxPG6F0kRS5PXaELnF49/t4Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.39,REQID:8ceea0a0-8825-491e-8249-0d9d7cf0e153,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:393d96e,CLOUDID:af8b4985-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT
X-CID-BAS: 1,FCT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d67330b62e5511ef99dc3f8fac2c3230-20240620
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 413110847; Thu, 20 Jun 2024 00:06:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 20 Jun 2024 00:06:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 20 Jun 2024 00:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmvC+2IxhaJN1ZrOEM6Ub8+NKa+PwsQt7oC8alXG+FUNmio6gp+3Wcy7JgLIUvJOPX7a74sBg5RVZogqAFBV1cxGiJKC6yuB3v20pnPccfDQkXVUzU0MAEYKf+HCq2BiOjSvkBdwzbBErIffBSM7IiO5MBM9HFMJT65IkzoLqXuIWwdTwnZyqiIISs94fEx9I2y435iuPe52pUuGPNnmqFe/CdT9IsmG6rWESIvKVS+zmcyKH2Ulz4I5lKyIUQmdUtVsqvD9sWIQlBw9a7I+xklYv4J1eOacCuLqLUvLnphRQYQiSqEfLmXuBi2iHdlQnCTkzDMCn8rm8xoCwd94lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVwtChdiAP5oxAPt6zeLNhVjP9ImrPrfqZE4e6AK0Yc=;
 b=IVqIvClkSbEF4l/xr4oJlHklFsWxt1JNQ0VPuQYzRK4/yM6K0EwFN5fLmNfLbhyI7BZgaymzSwVwgoBms37Vxj1BIRsb6Jc1iq3Mr/LR7332Z7LmWkPjVtz/Rzg7uLRNsFwWTe0I75/ttRcHfsqVDBqSnA2kiNrKm51avjgxhYFm+UE47Wr1YKMaJ5NmoCe4kiYqRXLmnwfb6AZFAjoFnqDZbNFIoLzLVQsCT6CknFwK57FyaMtKXF4SVpuR+2oRIgwRB84QLjCAOMpeAnL76O+n3OQp3pP4KFz+Yj+6iBlaigPsARdopR6gjaIl1IvgzzID5Hkt6/A7bpDUIVvMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVwtChdiAP5oxAPt6zeLNhVjP9ImrPrfqZE4e6AK0Yc=;
 b=ES36HFRPOAFCxfthDQf+JNKgfGknQREiV6dq/GAlon9UYbTFD0vIfsXw6GnF53iIUabaGFTIj8v/40tLtxcU5CJoVMO6se7awyPiet4ko5W/Y3SX/9k5K9Ew90iYhoiUdLy/ldwJukx6TBJFaMTC5S3rmYenzzYDgEQaJlXXGeI=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB8167.apcprd03.prod.outlook.com (2603:1096:400:453::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 16:06:03 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 16:06:02 +0000
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
Thread-Index: AQHavaNGmeIQnKWVzkKgT+U+XkKGsbHFzHUAgAAcj4CABvrcAIAAi42AgAHadgA=
Date: Wed, 19 Jun 2024 16:06:02 +0000
Message-ID: <1bfddfa4c7afed4af6a461780304e1f0e37d8471.camel@mediatek.com>
References: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
	 <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
	 <44f6308379a8b6c834df6ff0604c652bf1f7a4b7.camel@mediatek.com>
	 <47f1c2c79ad03094ebf411e13516cca47054c962.camel@mediatek.com>
	 <a681e496-4979-4f4a-9f79-9636d9496fa3@collabora.com>
In-Reply-To: <a681e496-4979-4f4a-9f79-9636d9496fa3@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB8167:EE_
x-ms-office365-filtering-correlation-id: 10a29e5a-095f-4a99-1cf9-08dc9079b7d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?UnRyNGlkK1UxM3R1UXNXd05pMm5aWmIxWTNNUEM5Uld4SlJhdjNOOWQvZC9J?=
 =?utf-8?B?bllVbFJyL1JETG5XSWhNb0gwUHArTE95YXg3WDRHRUVicWJxaDN2MlNaSW1B?=
 =?utf-8?B?WEMxSUJEYVZPd2pibzk4N0pDNXk1MkZyMDFuWmZPYkx2N3NZRFNCUWFBVXM3?=
 =?utf-8?B?NHpxQ0hHbjVwU3p3VGVpakhjRFNsbjNMZlFvQXdhVExPRm84NDl4elI5NVF3?=
 =?utf-8?B?bmdZOEpzV0xlc1VzcXA3aGNOdEpQRXQ1MDVpZDAxT3Q1M2Z6aVJ5WlNsUDR5?=
 =?utf-8?B?ekIwZGNBSVBBbkR6RTlSb2UzY1JXZStPTVdiRGVqZlZ5VnllQVZ0eWZ4d3Ux?=
 =?utf-8?B?V3RDMWZDUkd1a0RPQS91UHJMSjhVNnZMRmV3TExHajdmSWJQOXNINWZ5Rkdt?=
 =?utf-8?B?T2FqTG5CbTgzU2tZeUwvRjJLdXBodWRSckRwd0c3b2ljVm50WFZVenVTdWhC?=
 =?utf-8?B?Z2FmQ0VkZXF3VjhabjhLRUY0bVJyTnZzOGp0K1F4UXV6NENkanNjWTZCNmw5?=
 =?utf-8?B?a1l0ejBtVzZWdUNmWG9VQzNaNTBIbStvbjdaY2xKUDRtMHYvcWFQWnZ4WXJT?=
 =?utf-8?B?MTNCWkpTYU40MHpmWjhFTVhHM1d0eUxVWVdNamJlWHZPRFo0a2xsZGlMc2Ri?=
 =?utf-8?B?L0ZPdHAvMnlrZ2hvTys5K0pXWUM5MzZGbmd1QUFZMTdPYllIblAvcXRnclBt?=
 =?utf-8?B?Qk9GMlZPUHF4Tmc3VlVzWmx4NnVOMTdBUDZTcG9zSWcvMTNCRHlLRnlKcjlz?=
 =?utf-8?B?RVZBNnl5TVlUdVFHUzQydXdtQjhQQTZEeHNlcXRuZzdwRVVUSExIUm1WVC9Y?=
 =?utf-8?B?cE9UbU5DcUdhNG1aamhSRGlwdkpacUxXelRsdm1ndStyR1BaSnRYQkxXVUho?=
 =?utf-8?B?ZWNDOGU3T29HeE4veEE5TnVoVFZxWUprbThqSmlYa1l5QkpCZlJCRkYyNkJ1?=
 =?utf-8?B?OUIyWXlzSkxzMC9nQWRVQnFQb096ZnI5VVBLUnFrODE3NkQzZGVoWHpBOTE1?=
 =?utf-8?B?S21RaW5LWER2QmFlYzFPdmpHL3VQSVJJVkxYYWxXQjgyU1Z1YXNtVDVacFRa?=
 =?utf-8?B?cU00QTEzMUdoa0t3V0VoOG9vbkU2UkdiN2kxa2hpUngzUXhKOHBXKzVDcVJy?=
 =?utf-8?B?MHQwelM1eEdldmVKZzFZWUVreEluMDdOOStaVTVDbCtPWnpJY0tXOTRXWUN4?=
 =?utf-8?B?Z0pqMTZkdXhVVUJsMlBkRjJTUWsvLzdacHg5dDBuSWdGSHc2Vzd1Mlg0clVZ?=
 =?utf-8?B?MXFhWk05REdhNGF6WW9uZWNPK05kcjUwYUx2R2VLRjIwMUpsaDV5azh3V0c0?=
 =?utf-8?B?MDFtWVFXM2RPdzVzeG9KQm8xdURHMStONDBMK2VNVm1KZmlFVGM4b3lUK1lD?=
 =?utf-8?B?M0VlRWR1ck12UHVBWEJMcGM1SnB5RTR6QXZNYnNCRVY3cmdTYkRwRGE3enJq?=
 =?utf-8?B?YUJzbC9PQTJ5RGZ4OVVic3k3UHBQNDFUK3I2V2hsRXhvRGJJKzJqWmpBU3Vu?=
 =?utf-8?B?LzFMUTJRZ1VwaGt6NE0zRVpIS1ZXdEpGcWVnb0RBZWJiUXJEYnh6RWx5TEVC?=
 =?utf-8?B?ZUppSzQ0U2dvSHYzV2NSY2NyUzZFWFVzMWdzMzYyU2p1ZEtDaEJZbCtnYmd6?=
 =?utf-8?B?czdVWWNId3lXY2VWd1gxNU9BaFNsZ3ZvcThwbDR3N2ZlbDU1NmpQeVlqYk9V?=
 =?utf-8?B?dGZXb1RvUEJmZm9nRVhKbmhFd0NybG9TcU9tb2s3STVqclBnSWllekVGdjVt?=
 =?utf-8?B?UDZJNW5LNzRQSjFOTWtLUWMwTjNNQzRQUDJNeGtXdVpBQzVnQ1RXSFNLOTJy?=
 =?utf-8?Q?DZQGycJZTOETRO/CYnNI/WW2b+oAQKd64d3uE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3NjZk92VDdPSGNDUlh1YmRWUTBaSmp5MXI5TTZqNVdQaHVZUmMrYmtCQUVT?=
 =?utf-8?B?YUd3dXducm84VkZVRXFvTWEzUjBOOUNZVVpHTEZxY2tLeW01SytWM2lqeGpS?=
 =?utf-8?B?M3dJRjdDeDBaUytObDY5OVVuSHNZT0dJc3IvVWhKRDV4STFKemFjOU9vUmxY?=
 =?utf-8?B?eWhqUFRDUnlrNVRBeUpnN2pSMWx3N2xDMFF5K2tUWnBlRHBmZDNHZWVhSStt?=
 =?utf-8?B?VjU3ZzNCYTNZUmdqNHZEaU9YSUsvQnpGeXJiQlFiUjVFcm9KZy9YRDBhZ0Rm?=
 =?utf-8?B?bmx1ODYwbE5PaWdYTjRiazN3ME51akFUbUkvM1FEZXVHZjhQMjNYTVlkU0hB?=
 =?utf-8?B?RUF0K01KSHlrMlh6ODhZK1dadVcxRWJJMjAyM2o1NDcvaEd0QmRYSUhlQWQ1?=
 =?utf-8?B?YUFHSmduK0RQK2hYZmpZL0h1Q2NmMGdMRnlSTHJvL0ZNQ2srUlY3NUkwMnky?=
 =?utf-8?B?MDdNbWxUbjZVVnRTNFhDZVp2ZFpFbXhuY3pVV2hId0w0VUowVTRQN09xR1lz?=
 =?utf-8?B?UDVxaFNtK2hnb1hnazJFMU4yUkpOYUdNWUUvbWlMUUJhaWxDMWlIU3hZWWw0?=
 =?utf-8?B?ZThxaGlwMkFJTUhNbXlmSTR1SUMrMlFjbFUyYU5TOEk0YXVDaks0TmZSVXlx?=
 =?utf-8?B?Q3pFZ0ZVQ0hZb3B3dGl0TWtxaVVmSkNaWThXUEFSRlhvWW1GYzlrN205Q29L?=
 =?utf-8?B?K0FyTmVVb0FsdFNMMjJ4SVoxOWt2akNhcFk3MnVTSEhrWTI3NHZsYVd2VExy?=
 =?utf-8?B?UFh6dXJjcTVPeStMM2QxbHVCKzdLNE9TVWhYQlNOS2tlU3grY3U1Qi84Q2Nj?=
 =?utf-8?B?NE4zbzd4cXg3bGVVeEFmNFhYa2EvZTN3a08wZVBxbXhjdzkwQ3VWNkJsSXJR?=
 =?utf-8?B?RW5pRXBldVRicG1tR1VUd0hEVHVyb2JBV2M5bU1QekZJcnhhSzNlU3VzL0F3?=
 =?utf-8?B?cXlnYjJydzc3REVOSXc4SURGSUQzQVBrRDNCK1JOT2NQMWZ5ZlVKUC9odXB4?=
 =?utf-8?B?aEJha1R6dm1MLzV6NHY0eGppNmdKdmY3dDFBdDlqRllmNHBYYzRhMi80cm5R?=
 =?utf-8?B?cFJLY2IzVldDYnAvN3pXNGhKdFNjS1B0UnRlcVpnOVY3NC9GM0pUa3UyN0lI?=
 =?utf-8?B?WWs1OHlQMis3NUQxb0VHdW1UbDdNeWRqSlFUMWNXWVZSUys4eHJJUmhIbFoz?=
 =?utf-8?B?TTlvZ0ZCTjQzd00rNTR3SWwwWlY2b3YzOWl0cThCUHkvUVJSVFZ1amg0RFlT?=
 =?utf-8?B?RGZmbHl0aVV6d2Jab2VFRWdNUHdoQk8vQksvVGl2eko1Um1sUVlLcHBpSFFz?=
 =?utf-8?B?UnVjejdvL0lyampNWlZkeGNGQmd6NkxDS0p0c3Y3dnl5VVZlN09XSWpGOEEw?=
 =?utf-8?B?TS9EbUFrOGdUSFAwL3dVWGxlaG1XbXFHT3dsaEsrTWZDTEpsUDRJbVhodTNC?=
 =?utf-8?B?TWdSaWZIK1dYQmQrc1R2TGZqbys2ZmVYbWtOUE9VbkJ0N0dnb0tzUUFzNFpV?=
 =?utf-8?B?NS9SQXgxS3Q2WHBGOEswUGx3WDZXVTFTWUg5V0V0RjdOU2Q5MnJ2SnFxVzRx?=
 =?utf-8?B?aG9yeWhON0s3eXlnSkZrdjdWRC9FQVYxQ2RUalNRUlFUeXlMbjFZN3BkWFVI?=
 =?utf-8?B?ekd1Njc1STFqNHh1anhPb0VRblgwV203OFBVRlFPVTFHUERmcmlVUHFxMFly?=
 =?utf-8?B?MDg1OEhUWWo5ZWMybTJVSk92UDJwcmpLLzdFOHU0dFVNbFhiZ2lTbDZ0MVRY?=
 =?utf-8?B?TG5vaU5UM0ltcTd4V3VPMVE2VGQ0bklHdlJ5ekdHM3NRaGRlNEQ1NkRUVjQ4?=
 =?utf-8?B?MDJrL1VLcHlNT0U4a2o1S2JqeGxUT1lxWmFsUWM1KzlIK3UyZXpVbHRXWWxo?=
 =?utf-8?B?NDB2elFNckFZZ3ZSbDFSNlJKR1ZVeTdWM1hMb2NpQTJ3SWxUWmNDNzNjc3No?=
 =?utf-8?B?b21SYW9uVjQyZW5YemJHMFJNd1JLK0dKcmJ3Uk9SbnhwM1VqMjZCckZKV2Jj?=
 =?utf-8?B?dTEwa2V3SHZwMTdjUVhoZUlnTkRiWXVEeE4wNUp0a3ZSZkp5a2grWkY4SjVh?=
 =?utf-8?B?dTh1aXM3N25xZWJnT3c1eXdnUWg5VnppYmpkYkh1KzUrMGp1K0dQOTB3QkRo?=
 =?utf-8?B?RnhTcTZTQWdkUFgvMmI1bnN0c2paZVJua3lTZ1doNUNqQjlrY2VwSGR4YzdI?=
 =?utf-8?B?cXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD6DCB177F9BCC42AEC41C0BE482444D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a29e5a-095f-4a99-1cf9-08dc9079b7d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 16:06:02.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +hNj0tkeO6BgsjEQduxARUoErQV8u8lClcc2rQXH5nW4+U47O4wL3x5MLZIesy/IiA8WTpDdJld2Acaz5yQfUTiBpSNCQnmnKFyRUhQKJHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8167
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.540200-8.000000
X-TMASE-MatchedRID: u7Yf2n7Ca/2i6/VcDv9f0F2036HHwFm/fjJOgArMOCY0QmmUihPzrEO+
	JmetT/Kbxzt+23iFuE7dTE2YCDGxni2W7Y+Npd9RI18rKo/JG6+3dp6DuD+6wAzvg1/q1MH2eHH
	oUbc1uqZ0a1sjtoECuNlYmtBNW3IbNsajeS/qEBKL+98BLtDce+j86Ng8AayKJLfQYoCQHFZFHk
	YRmOFTHQq6OA5z5SE9vOoAZk/87mDRYRMEFHXEyysuu3Z2yY5+DCe/LOiZlC0dXtyyzrIOt7+xg
	266CxvavWU6qZJaEINUFwdbPogKxUI69L22RjXLngIgpj8eDcDBa6VG2+9jFBrZLyuS+0VxF70J
	Bot7Y8+OhzOa6g8KrZRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.540200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DFE6BCB3DB564CDB26E064E4A436F964EF3B7566ECFE5904AF0D05A29027105B2000:8

SGkgQW5nZWxvLA0KDQpbc25pcF0NCg0KPiA+IEkgZm91bmQgdGhhdCB0aGUgc2VyaWVzIG9mICJN
b3ZlIHBtX3J1bmltdGVfZ2V0IGFuZCBwdXQgdG8NCj4gPiBtYm94X2NoYW5fb3BzIEFQSSIgY2Fu
IG5vdCBmaXggdGhpcyB1bmJpbmQgY3Jhc2ggaXNzdWUuDQo+ID4gDQo+ID4gSXQgc2VlbXMgdGhl
eSBhcmUgMiBkaWZmZXJlbnQgaXNzdWVzLg0KPiA+IA0KPiA+IFNvIEkgdGhpbmsgY2FsbGluZyBk
ZXZtX21ib3hfY29udHJvbGxlcl91bnJlZ2lzdGVyKCkgaW4NCj4gPiBjbWRxX3JlbW92ZSgpDQo+
ID4gY2FuIGVuc3VyZSB0aGUgQ01EUSBkZXZpY2UgaXMgbm90IHJlbW92ZWQgYW5kIGJlIHBhaXJl
ZCB0bw0KPiA+IGNtZHFfcHJvYmUoKS4NCj4gPiANCj4gDQo+IENhbiB5b3UgcGxlYXNlIHBhc3Rl
IHRoZSBzdGFjayB0cmFjZSBvZiB0aGF0IHdhcm5pbmcgdGhhdCB5b3UncmUNCj4gc2VlaW5nIHdo
ZW4NCj4gY2FsbGluZyBjbWRxX3JlbW92ZSgpPw0KPiANCkkgYWRkZWQgZHVtcF9zdGFjaygpIHRv
IHRoZSBmaXJzdCBsaW5lIG9mIGNtZHFfcmVtb3ZlKCkgYW5kIHJlcHJvZHVjZWQNCnRoZSBjcmFz
aCBpc3N1ZS4NCg0KSGVyZSBpcyB0aGUgbG9nOg0KWyAgMTkxLjA1ODY1MV0gQ1BVOiA0IFBJRDog
NDQwOCBDb21tOiBiYXNoIE5vdCB0YWludGVkIDYuNi4zMi0wMjk3MC1nNTIxMmU1ZTk1OWRiLWRp
cnR5ICMxIGJhNWVjODQwOWUwMWIwMDVlNTM3Nzg3ZWRjZjQ1MTVmMThiYTZhZDdbICAxOTEuMDcw
MjEzXSBIYXJkd2FyZSBuYW1lOiBHb29nbGUgUmF1cnUgYm9hcmQgKERUKQ0KWyAgMTkxLjA3NDk5
N10gQ2FsbCB0cmFjZToNClsgIDE5MS4wNzc0MzVdICBkdW1wX2JhY2t0cmFjZSsweGU4LzB4MTEw
DQpbICAxOTEuMDgxMTg0XSAgc2hvd19zdGFjaysweDFjLzB4NDANClsgIDE5MS4wODQ0OTRdICBk
dW1wX3N0YWNrX2x2bCsweDgwLzB4YTgNClsgIDE5MS4wODgxNTVdICBkdW1wX3N0YWNrKzB4MTQv
MHgyOA0KWyAgMTkxLjA5MTQ2Nl0gIGNtZHFfcmVtb3ZlKzB4MWMvMHg2MA0KWyAgMTkxLjA5NDg2
N10gIHBsYXRmb3JtX3JlbW92ZSsweDNjLzB4NzgNClsgIDE5MS4wOTg2MTZdICBkZXZpY2VfcmVt
b3ZlKzB4NGMvMHg3OA0KWyAgMTkxLjEwMjE4OF0gIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRl
cm5hbCsweGM0LzB4MTQwDQpbICAxOTEuMTA3MzIwXSAgZGV2aWNlX2RyaXZlcl9kZXRhY2grMHgx
Yy8weDMwDQpbICAxOTEuMTExNDk4XSAgdW5iaW5kX3N0b3JlKzB4NzQvMHhjMA0KWyAgMTkxLjEx
NDk4MF0gIGRydl9hdHRyX3N0b3JlKzB4MjgvMHg0MA0KWyAgMTkxLjExODYzNV0gIHN5c2ZzX2tm
X3dyaXRlKzB4NDAvMHg1OA0KWyAgMTkxLjEyMjI5M10gIGtlcm5mc19mb3Bfd3JpdGVfaXRlcisw
eGYwLzB4MTkwDQpbICAxOTEuMTI2NjQ0XSAgdmZzX3dyaXRlKzB4MjM0LzB4MzIwDQpbICAxOTEu
MTMwMDQ2XSAga3N5c193cml0ZSsweDdjLzB4ZjANClsgIDE5MS4xMzMzNTddICBfX2FybTY0X3N5
c193cml0ZSsweDIwLzB4MzANClsgIDE5MS4xMzcyNzddICBpbnZva2Vfc3lzY2FsbCsweDcwLzB4
ZjgNClsgIDE5MS4xNDA5MzldICBlbDBfc3ZjX2NvbW1vbisweDhjLzB4ZjANClsgIDE5MS4xNDQ1
OThdICBkb19lbDBfc3ZjKzB4MjQvMHgzOA0KWyAgMTkxLjE0NzkxMV0gIGVsMF9zdmMrMHgzNC8w
eDk4DQpbICAxOTEuMTUwOTY0XSAgZWwwdF82NF9zeW5jX2hhbmRsZXIrMHg0MC8weGU4DQpbICAx
OTEuMTU1MTQ0XSAgZWwwdF82NF9zeW5jKzB4MTgwLzB4MTg4DQpbICAxOTEuMTU4OTc1XSAtLS0t
LS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NClsgIDE5MS4xNjM1ODRdIFdBUk5JTkc6
IENQVTogNCBQSUQ6IDQ0MDggYXQgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLQ0KbWFpbGJveC5j
OjUzNCBjbWRxX21ib3hfc2h1dGRvd24rMHgxOTAvMHgxYjANClsgIDE5MS4xNzM1ODNdIE1vZHVs
ZXMgbGlua2VkIGluOiBkbV9pbnRlZ3JpdHkgYXN5bmNfeG9yIHhvciB4b3JfbmVvbg0KYXN5bmNf
dHggbHo0IGx6NF9jb21wcmVzcyB6c3RkIHpzdGRfY29tcHJlc3MgenJhbSB6c21hbGxvYyB1aW5w
dXQNCnJmY29tbSB2ZXRoIGZ1c2UgdXZjdmlkZW8gdmlkZW9idWYyX3ZtYWxsb2MgdXZjIG1lZGlh
dGVrX2NwdWZyZXFfaHcNCm10a19qcGVnIHZpZGVvYnVmMl9kbWFfY29udGlnIHZpZGVvYnVmMl9t
ZW1vcHMgbXRrX2pwZWdfZW5jX2h3DQptdGtfanBlZ19kZWNfaHcgdjRsMl9tZW0ybWVtIHZpZGVv
YnVmMl92NGwyIHZpZGVvYnVmMl9jb21tb24NCmlwNnRhYmxlX25hdCB4dF9NQVNRVUVSQURFIHh0
X2Nncm91cCA4MDIxcSBtdDc5MjFlIG10NzkyMV9jb21tb24NCm10NzkyeF9saWIgbXQ3Nl9jb25u
YWNfbGliIG10NzYgbWFjODAyMTEgYXg4ODc5NmIgaWlvX3RyaWdfc3lzZnMNCmFsZ2lmX2hhc2gg
YWxnaWZfc2tjaXBoZXIgY3Jvc19lY19saWdodF9wcm94IGNyb3NfZWNfc2Vuc29ycyBhZl9hbGcN
CmNyb3NfZWNfc2Vuc29yc19jb3JlIGNmZzgwMjExIGluZHVzdHJpYWxpb190cmlnZ2VyZWRfYnVm
ZmVyIGtmaWZvX2J1Zg0KYXNpeCBwaHlsaW5rIGNyb3NfZWNfc2Vuc29yaHViIHVzYm5ldCBtaWkg
YnR1c2IgYnRtdGsgYnRiY20gYnRpbnRlbA0KYnRydGwgYmx1ZXRvb3RoIGVjZGhfZ2VuZXJpYyBl
Y2Mgam95ZGV2DQpbICAxOTEuMjM0ODkwXSBDUFU6IDQgUElEOiA0NDA4IENvbW06IGJhc2ggTm90
IHRhaW50ZWQgNi42LjMyLTAyOTcwLQ0KZzUyMTJlNWU5NTlkYi1kaXJ0eSAjMSBiYTVlYzg0MDll
MDFiMDA1ZTUzNzc4N2VkY2Y0NTE1ZjE4YmE2YWQ3DQpbICAxOTEuMjQ2NDQyXSBIYXJkd2FyZSBu
YW1lOiBHb29nbGUgUmF1cnUgYm9hcmQgKERUKQ0KWyAgMTkxLjI1MTIyNV0gcHN0YXRlOiAyMzQw
MDAwOSAobnpDdiBkYWlmICtQQU4gLVVBTyArVENPICtESVQgLVNTQlMNCkJUWVBFPS0tKQ0KWyAg
MTkxLjI1ODE3OF0gcGMgOiBjbWRxX21ib3hfc2h1dGRvd24rMHgxOTAvMHgxYjANClsgIDE5MS4y
NjI3MDddIGxyIDogY21kcV9tYm94X3NodXRkb3duKzB4NGMvMHgxYjANClsgIDE5MS4yNjcxNDhd
IHNwIDogZmZmZmZmYzA4NmY3M2E3MA0KWyAgMTkxLjI3MDQ1Nl0geDI5OiBmZmZmZmZjMDg2Zjcz
YTkwIHgyODogZmZmZmZmODBmOTI4MmU4MCB4Mjc6DQowMDAwMDAwMDAwMDAwMDAwDQpbICAxOTEu
Mjc3NTg2XSB4MjY6IDAwMDAwMDAwMDAwMDAwMDAgeDI1OiAwMDAwMDAwMDAwMDAwMDAwIHgyNDoN
CjAwMDAwMDAwMDAwMDAwMDANClsgIDE5MS4yODQ3MTZdIHgyMzogZmZmZmZmODA4MDg5YzgwMCB4
MjI6IGZmZmZmZmQ2NDI2ZDExYzcgeDIxOg0KMDAwMDAwMDAwMDAwMDAwMA0KWyAgMTkxLjI5MTg0
NV0geDIwOiBmZmZmZmY4MDgwODljODgwIHgxOTogZmZmZmZmODA4MDJkNzQ4MCB4MTg6DQowMDAw
MDAwMDAwMDAwMWI3DQpbICAxOTEuMjk4OTc1XSB4MTc6IDAwMDAwMDAwMDAwMDAwMGUgeDE2OiAw
MDAwMDAwMDAwMDAwMWI3IHgxNToNCjAwMDAwMDAwMDAwMDAwMDQNClsgIDE5MS4zMDYxMDRdIHgx
NDogZmZmZmZmZmZmZmZmZmZmZSB4MTM6IDAwMDAwMDAwMDAwODA4MDAgeDEyOg0KMDAwMDAwMDAw
MDAwMDAwMQ0KWyAgMTkxLjMxMzIzNF0geDExOiAwMDAwMDAwMGZmZmZmZmYzIHgxMDogZGVhZDAw
MDAwMDAwMDEyMiB4OSA6DQowMDAwMDAwMTAwMDAwMDAwDQpbICAxOTEuMzIwMzYzXSB4OCA6IDAw
MDAwMDAxMDAwMDAwMDAgeDcgOiA3ZjdmN2Y3ZjdmN2Y3ZjdmIHg2IDoNCmZlZmVmZWZlZmVmZWZl
ZmYNClsgIDE5MS4zMjc0OTNdIHg1IDogMDAwMDAwMDAwMDAwMDAwOCB4NCA6IGZmZmZmZmQ2NDI2
ODc4NGQgeDMgOg0KZmZmZmZmODA4M2ZhMDljMA0KWyAgMTkxLjMzNDYyMV0geDIgOiBmZmZmZmZk
NjQyNmQxMWM3IHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6DQowMDAwMDAwMGZmZmZmZmYzDQpb
ICAxOTEuMzQxNzQ5XSBDYWxsIHRyYWNlOg0KWyAgMTkxLjM0NDE4OV0gIGNtZHFfbWJveF9zaHV0
ZG93bisweDE5MC8weDFiMA0KWyAgMTkxLjM0ODM3MF0gIG1ib3hfZnJlZV9jaGFubmVsKzB4NDAv
MHhhOA0KWyAgMTkxLjM1MjI5MF0gIG1ib3hfY29udHJvbGxlcl91bnJlZ2lzdGVyKzB4OGMvMHhl
MA0KWyAgMTkxLjM1Njk5MV0gIF9fZGV2bV9tYm94X2NvbnRyb2xsZXJfdW5yZWdpc3RlcisweDE4
LzB4MjgNClsgIDE5MS4zNjIzMDBdICByZWxlYXNlX25vZGVzKzB4NWMvMHg5MA0KWyAgMTkxLjM2
NTg3NV0gIGRldnJlc19yZWxlYXNlX2FsbCsweDhjLzB4ZDgNClsgIDE5MS4zNjk4ODNdICBkZXZp
Y2VfdW5iaW5kX2NsZWFudXArMHgxYy8weDcwDQpbICAxOTEuMzc0MTQ2XSAgZGV2aWNlX3JlbGVh
c2VfZHJpdmVyX2ludGVybmFsKzB4ZTQvMHgxNDANClsgIDE5MS4zNzkyNzddICBkZXZpY2VfZHJp
dmVyX2RldGFjaCsweDFjLzB4MzANClsgIDE5MS4zODM0NTRdICB1bmJpbmRfc3RvcmUrMHg3NC8w
eGMwDQpbICAxOTEuMzg2OTM3XSAgZHJ2X2F0dHJfc3RvcmUrMHgyOC8weDQwDQpbICAxOTEuMzkw
NTkzXSAgc3lzZnNfa2Zfd3JpdGUrMHg0MC8weDU4DQpbICAxOTEuMzk0MjQ5XSAga2VybmZzX2Zv
cF93cml0ZV9pdGVyKzB4ZjAvMHgxOTANClsgIDE5MS4zOTg1OTldICB2ZnNfd3JpdGUrMHgyMzQv
MHgzMjANClsgIDE5MS40MDE5OTldICBrc3lzX3dyaXRlKzB4N2MvMHhmMA0KWyAgMTkxLjQwNTMx
MV0gIF9fYXJtNjRfc3lzX3dyaXRlKzB4MjAvMHgzMA0KWyAgMTkxLjQwOTIzMV0gIGludm9rZV9z
eXNjYWxsKzB4NzAvMHhmOA0KWyAgMTkxLjQxMjg5Ml0gIGVsMF9zdmNfY29tbW9uKzB4OGMvMHhm
MA0KWyAgMTkxLjQxNjU1Ml0gIGRvX2VsMF9zdmMrMHgyNC8weDM4DQpbICAxOTEuNDE5ODY1XSAg
ZWwwX3N2YysweDM0LzB4OTgNClsgIDE5MS40MjI5MTZdICBlbDB0XzY0X3N5bmNfaGFuZGxlcisw
eDQwLzB4ZTgNClsgIDE5MS40MjcwOTddICBlbDB0XzY0X3N5bmMrMHgxODAvMHgxODgNClsgIDE5
MS40MzA3NTFdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KDQpSZWdhcmRz
LA0KSmFzb24tSkggTGluDQoNCj4gSSdtIG5vdCBjb252aW5jZWQgdGhhdCB0aGlzIGlzIHRoZSBi
ZXN0IHNvbHV0aW9uIC0gaXQgbWlnaHQgYmUsIGJ1dCBJDQo+IGhhdmUNCj4gYSBodW5jaCB0aGF0
IHRoZXJlIG1pZ2h0IGJlIGEgYmV0dGVyIHdheSB0byBhZGRyZXNzIHRoaXMgaXNzdWUuDQo+IA0K
PiBUaGFua3MhDQo+IEFuZ2Vsbw0K

