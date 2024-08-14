Return-Path: <linux-kernel+bounces-285947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D229514B4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D64282363
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F1A139D13;
	Wed, 14 Aug 2024 06:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sNsG8VAv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Qb6pY9zS"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ADE139CE3
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617170; cv=fail; b=FmYjI/qc6dgc2ZEdAeHl/jFKjQrC3rrdsAW9P6moGeJUFfnsRgF9uDsYdP5oiBJpQ5iGLsSOZvfW2a10JnPEcqI3jAYXUeHqWLossQyYogdw/TFtMf2SvboYdQcG0QjOwrNkvzUWSym+ARvqZj9/zs8rdmUKv+OVdpepg8ExQOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617170; c=relaxed/simple;
	bh=9J03XuS3PmSj3EI1xbe3Vbrp7lQxHqJZ/eOQ1L4gztY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UBxDHzIjFaI5sG6zutdgDI2DKw7HekJwbbcrh7cQ7jsZ6EKJreO612eG9m4ym7ZOsFwjjUkJ8FLQUhSDDPnl346/OSfHcFl0qBIYB9cIdDHS4m6zKdtaUYvafqjqISAss6iZ73uqQ8ZQqtP317mPf4KgWnSdsxgNRT2bwWeQg5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sNsG8VAv; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Qb6pY9zS; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fe3409f45a0611ef9a4e6796c666300c-20240814
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=9J03XuS3PmSj3EI1xbe3Vbrp7lQxHqJZ/eOQ1L4gztY=;
	b=sNsG8VAvSqmOiF9mTHvzkfQ8NOjIoqntBazoXFsnjePsmzQ25s5CRg9K+E3glemdOz03NtfMDR3QF4Enx2qVzC832OVWCZc9Noz70Or4+WfM09DvNOW+4LbvcDUvtsdlbFGx1MmDSlbm9Jw9IHF6b+Fv7JptieEKYH55x9UfkFw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:8ab73857-b7bf-4022-aa66-48dcc31b187b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:137d8ffe-77bb-433c-b174-ffb8012693b0,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe3409f45a0611ef9a4e6796c666300c-20240814
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <william-tw.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2103447468; Wed, 14 Aug 2024 14:32:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Aug 2024 14:32:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Aug 2024 14:32:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wX4LaQRuoAdjtr0kg5RCy56XNiNJMVnId/2T4y0dHuibSgCKuNG5VDI75iECmLOBOqZpQCWGZr61Cu9pJH59Rv5KjWPe252s3iFh0Qs0WXurbUiGTSy4MFcY1mn9NJgJp3h/I2SAyPoFlnd12TEn9RftYlcEZaQX6mOlPyNQ2QcVXsfali04/2ST01Jwjd7dhC65yORD5t+IlPQ0N4eyZlTiyX75DxdK9TjHs6ssTz4HQ0k2g9RMg4rGBVkBWQsph3gD5vRSgRAya5/sh7vFU4shlivlUTPY0nN12ZNPw0qOdLVZEEQsI467hc5Ugmg6i1VZkMqgbdAuEjs9IEVy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9J03XuS3PmSj3EI1xbe3Vbrp7lQxHqJZ/eOQ1L4gztY=;
 b=pZnLwkjP+Pr1gRFXQLek4eSuviSSIMWW6tW5uV3TILV7yMy8QxLpcP48Z3EjJLSyDYEL3BhayZUB12oLprRnhIxa+ZaELJmw8+rEBHDMCQ4LbCYdgSIYjns3H47ex2Wnb1ItpIwbzOzSLAyGzq9YZdnUle0i1gl1b+bNPA02exNbPuy9i2N9YXATP6+wYSSdWg0IDzz3ChvuJfqXl1AExVKYnOHdemjL+xRkLPpBxBbHLgV3l95jpdqDcVYbpZIrF3WmTsGLn8RStgI4Wni8bNYJsqvUUDAocv/j9iWJbfhUnCITkGQsifU90DeUZ5I/qtxOwhdUkqFf1YZQLjm1NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9J03XuS3PmSj3EI1xbe3Vbrp7lQxHqJZ/eOQ1L4gztY=;
 b=Qb6pY9zSPxPCpmvTLtHJ0MZN4gKCS4onC4rxqLiQT0Wm3TXhp1xGRaRrZo63c0B/aYUUPwooPNOPNWgJJOpZu1Z0rzmwdiAolx67p8J92b9GnhdOLMzntjW+FcGR0nc2ZzWwI75NNV9sgU4KxO/Tmd/t1VcpQJFEbzmzGLZPS/Y=
Received: from TYZPR03MB5406.apcprd03.prod.outlook.com (2603:1096:400:39::8)
 by TYZPR03MB7554.apcprd03.prod.outlook.com (2603:1096:400:3ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 06:32:33 +0000
Received: from TYZPR03MB5406.apcprd03.prod.outlook.com
 ([fe80::6cf2:e8c5:936a:bc2b]) by TYZPR03MB5406.apcprd03.prod.outlook.com
 ([fe80::6cf2:e8c5:936a:bc2b%6]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 06:32:33 +0000
From: =?utf-8?B?V2lsbGlhbS10dyBMaW4gKOael+m8juW0tCk=?=
	<William-tw.Lin@mediatek.com>
To: "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "wenst@chromium.org" <wenst@chromium.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "nfraprado@collabora.com"
	<nfraprado@collabora.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvmem: mtk-efuse: Only register socinfo device if
 needed cells are there
Thread-Topic: [PATCH v2] nvmem: mtk-efuse: Only register socinfo device if
 needed cells are there
Thread-Index: AQHa2b4klJKym4TtIUer2PT69X6q4rIVsSGAgALzAgCADc/cAA==
Date: Wed, 14 Aug 2024 06:32:33 +0000
Message-ID: <e6dec500c2e7532a65c12c7e8919e5b7f202ed14.camel@mediatek.com>
References: <20240708-mtk-socinfo-no-data-probe-err-v2-1-7ae252acbcc2@collabora.com>
	 <a1914f2b-93f2-4de4-9c4b-2e1f6b39cf3a@collabora.com>
	 <05dd24ec-d084-4708-a241-b4714391118a@notapiano>
	 <e1e1b618-b505-482a-b556-99c6d42fd581@collabora.com>
	 <f52d33ec-a003-48f8-b74d-080b9b29eb67@notapiano>
	 <d7391797-5c23-4ef9-b448-980ebe5a1d67@collabora.com>
In-Reply-To: <d7391797-5c23-4ef9-b448-980ebe5a1d67@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5406:EE_|TYZPR03MB7554:EE_
x-ms-office365-filtering-correlation-id: 2ab967da-2c7c-403e-39c9-08dcbc2ae11f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 8XnmwXHDpTlV5VWKH2qXpfzRlvwKY06gkfT9CJJ774FWf+xzUPhNG+TKZCePNNh6Jrslyqb1o88CAGbedDivQcMvukTTDyMhGKqVflwg2LRy9w8OACG6TokVkG03CtWwl36/bdWiReqpuuKfi0R5d7iC523bPWzeOzkg1orMRGsYCJxZZSHPSStjuJFAHgaA873gQJdQEFDe5MXfjOdyBUAwaLHuT1WWVd/EdrCM3B0aDIX/3Quojpks6wT6kIJeNS8SzYQljuWSvjBLUcm+pkY2IPa+q0Stk/Qhbg8eebbxADHeCbPKQQjtoAirxH8W6cNU/SarHZ6cPZlFPhgt35Zwp4d5w/LPxOH+PAjWtf4oz8DQXt0+G1BLRtVGkIHHp1p8wJDmiyuLMXn2s1U5TUDwu7F+EdwUXyI0CTUF4jGn8A+SPNM3VSzPT50321gLyoyCXMYS5/6H9FJ1VMEcskIc0iE/OeUZZQvNBZTSEubq887l0JsOitGdjy1zqSpuryKT1yh8KmMuSKKHSQBFwMk1Hvt9dmf3BxX1kVG3ayHGGNSMA9/HupflVm+pI6agwUJoknnMjGml0AABiWy/JgOL73m6cKm+Dz02431kkkLb3MdDRNkT6H5yqJsUc99ZAdzSb0DStgMaFM/+G4BCRrV4MrVknZ/eRzKDwioaYzcmfhTa4ALdDTvIprh4WiIs95YprUtTJCAua6JZwLKJvFiiRsms2T3GALSQmluWE+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5406.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Smh6dGRFR0pCcktES0VQSGN1c2ltRDRzamlBKzVEdWhrNkROamtPcCtsdkht?=
 =?utf-8?B?ekdzRHFFcGpLK2JPWC9JNVYrTFUxNzc5cnh0bkxqVkJSalpFbE5MTXNyUHhK?=
 =?utf-8?B?bUVtWWNRN29RZTJmSGtUd0RkNmxOOFZpdjc0K2R6cTluVHZJeGphWWJOb2pZ?=
 =?utf-8?B?aTNCL3I2Y2pVKzQ3aFJCS1hUdlRESThBNmw0bUhMWTZUSHk4aWFoZXBDUWlk?=
 =?utf-8?B?eXJjSFZsWkdWbXBTMWE2MDZveW1OeVppWmhKTEZqOEE5ajhvVHJka05zVDQy?=
 =?utf-8?B?eUhEc3VFbnNxcEJaTld4S2Q5MlZhcVhxZGcxYS8xbTZYQnVKQ0d1WGRnNGVX?=
 =?utf-8?B?Z0JWcERSb1lIcS9mWXJWb0Q0TE0vTG4xelpEdmNmVTl4R09DVERnMEwyRnZV?=
 =?utf-8?B?OU9ZTzJkQXBpVmdKLzRVSEJ6aVdhUy8zSEpKVXJqZkNkUFQ4eXZWcjkrTGRX?=
 =?utf-8?B?RVA1TUx1MVMydDc5SWNtVWwzNWlKNUZuZ05lMDZZZHk2bUxCSkkxV3FSL3pQ?=
 =?utf-8?B?cGpxU2YvRVpscXNtbStOeWgweXk0RGg0bVBhWnA5WCtNck5UVUw3dzhISkJo?=
 =?utf-8?B?Um9LSitQYm1qUVp2SThCcWtWMEVJTFZPSTlWcVpKYU5RNUxlQ3M2UDlweUdj?=
 =?utf-8?B?bXFndTdzNi85am9jenExazhHVkIvQ1NhVXBBbjNhSnYveDhaNlJpWE9hRVdI?=
 =?utf-8?B?NVVKS1lUSTkwNllHTnZPNE43OXVpYWkzblgrOEN3TkRVU0h0UCtJSDI5dDl4?=
 =?utf-8?B?ZFRwSUQrRzRhcGtGdTZPeURyT0pqUXg5aFFFRGt2TmJNSUlkMDFjczBoR1Ez?=
 =?utf-8?B?SkNRSlBTaTFtMUlWOFNQdnJnaGo3NTFMeS9Na0FOY2dVS21sU05DVHNrbkxa?=
 =?utf-8?B?OWVGamJyUVMwN0pyeklVZzlLM0FVY1hWZy9xbUU4amx1K0tuUVpRT3FkWEYv?=
 =?utf-8?B?MUZyTlR5YmxwL1lubHZTNjNFaDZwQlN2R2MyWUJ0MGVna2xleEQrMHdLSVFF?=
 =?utf-8?B?bzZWeng0c0FQM2pCU3VqVTN0V0hkYTRjemlqYVNHMHY3NGpHWmIxdlIzTE1O?=
 =?utf-8?B?RzAweG1FWkJFNktBKzJ5Z09WUzR4cVRMYWdjV2hqeFBHOVdVRm0vTHU4UUtM?=
 =?utf-8?B?OEpqMWo1V3JKNzhrbDRGcTFHWXU4NzZhd0FRUUJzWXNBRThIdStZYmpjRnMr?=
 =?utf-8?B?YUx0bjVxRTJUeFMxcFVzVzA3aHgvTWFobHN6RGM4ZHc3WWlzcDhMKzdSYitX?=
 =?utf-8?B?TUFNaU9qRmZSR2tJSit2USs2UjZSWStYZFBqTHMwZm5kNWIxbGxxU1ZxY2R4?=
 =?utf-8?B?QUl6a09Scjl5RUVtc3lZbEJUdkVIOE1XWVpYQUFQS1pPd2pCZDhxaW45L3Uw?=
 =?utf-8?B?YXJMOGpUbDRsU1hOZytjQS9zTXZKck1hb2prRTlNdkdUeEFhc1hvU1FCVmtR?=
 =?utf-8?B?dXlXcU1uTCtUMW1kYXdPbjg0RmZmaDV2RFY5WU5TeUFJQVNlME5pZE5UQTVK?=
 =?utf-8?B?YWFuMXh2dGJPNXZ4clBWcStDc2ZDVXJjUDNla2hMbnlMOEFtSmFPa01oYlQr?=
 =?utf-8?B?elBKbGNxVHVaZU5WRTN4TnM1Z0NQTWw5MFJFQUpNZmYzd2JiQS81dk5GcG16?=
 =?utf-8?B?K3FhZk9hV0IrVDVNL3RKUUh1NkdxTmYvYU40L3krdHVzOWN1WHh4VVpNSWRH?=
 =?utf-8?B?REpLS0FCQUpQTDZwOHhDZU9QM2pBVmN4eGhYVVNxb0E0N3VMcTBhTVlUOWFa?=
 =?utf-8?B?OVhBUVdoUHoxVTJsM1FCaUR3Y3FRSU9nZVpXSTdpTjRLdWZHMnZPNEtjOVNY?=
 =?utf-8?B?VHZzZERqVVpJVWpNelZ6WmZZVDZoUGEzZjdTSmx5WFBjN1pYQjdCQlJES3cr?=
 =?utf-8?B?cDBrSVl6MFJCNjAxK29EQ3dPbXVPcDByU0Z3TnU5RkdsZ0tiQS9CbWN5emVl?=
 =?utf-8?B?NEtDeDNFcVFLL2ptZTEzY1VvTThUR0RLR0x5b3RNTGJwUWtoMnRpV3I1cmhL?=
 =?utf-8?B?LzhKakZVYW1BM2VzaXJ5STlkWm5QVXF5TU9ubXRiVE1GclFCTGJVMmdIRUZp?=
 =?utf-8?B?WGZibkNNYyt3V0gzclpMeFBPR2QxQXhCZUtCT0xwUERpV205UCtNS0JRUkVk?=
 =?utf-8?B?UEJWZ3hJbFZ5d0ZZWVkwajN0c2EwRXpNRlBmMzJZRVc2MXVGeS85Q3JVSEhs?=
 =?utf-8?Q?eL7egytVO0/Q/9ERKx67o6w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C9114FFE8A61C41B4201A86678E0717@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5406.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ab967da-2c7c-403e-39c9-08dcbc2ae11f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 06:32:33.1232
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BRZs22wO+MCMC9qEIr9nKl49mVutIGqyAOyZnVmlDWRdjl7MjuWaze83kSZlt7Y/kOvuuw6qg13zfxNNwR5wiPDMcqf7U8ijzj3bH/kbN5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7554
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.678600-8.000000
X-TMASE-MatchedRID: H6qdQuiXxKDUL3YCMmnG4vGG8F2k2BBVI4bJHZSdxcuyrCkM9r1bWskU
	hKWc+gwPp2+PpVTz2PH89WDKQGB2LjpJymJclwFF/az81CtIKD754F/2i/DwjX5h6y4KCSJcOUy
	eBugoF8W5Jg5Q9LPvWh583oSmrpYB3huBcHFqgEsOSj4RiINDEUKzuF0egUUDhWj6N1oby6qArq
	oIZrVn19MRlVkvzHB/ZUyvhMHh3+gwdNeS5WKnLFz+axQLnAVBBcCEAZkHsGdaW2Ktn+I8/nRe3
	lTFL+5aehkG6/iLKmeJ3QMdDPugJX0+EdZM0kUdZg1i2wTmScPjgP3VWIBQDnRBu8vg+6OQiO9f
	zG806wvc545voDTKh1Z9jyoJra0PxxrNQPO8BGZNI82n17+7UzoSfZud5+Gg3XgCp7wTMXzImJU
	ezF9c+PhgNohh9OGeToepswMGFMMh6m4nn3Yfy8DORqgKKiYqt+hhn8Iy6GWbKItl61J/yfmS+a
	Pr0Ve8SXhbxZVQ5H/3FLeZXNZS4GTjfUfrkn0A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.678600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E884AA0CEF7592D361CDB8DF88F07F4ABC0EE32F3ACBC160AB0D56EA38C2CA742000:8

T24gTW9uLCAyMDI0LTA4LTA1IGF0IDEzOjM3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDMvMDgvMjQgMTY6MzQsIE7DrWNvbGFzIEYuIFIuIEEuIFByYWRv
IGhhIHNjcml0dG86DQo+ID4gT24gRnJpLCBKdWwgMTksIDIwMjQgYXQgMTE6Mjk6MDNBTSArMDIw
MCwgQW5nZWxvR2lvYWNjaGlubyBEZWwNCj4gPiBSZWdubyB3cm90ZToNCj4gPiA+IElsIDE5LzA3
LzI0IDAwOjA3LCBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyBoYSBzY3JpdHRvOg0KPiA+ID4gPiBP
biBXZWQsIEp1bCAxMCwgMjAyNCBhdCAxMTozMToxMUFNICswMjAwLCBBbmdlbG9HaW9hY2NoaW5v
IERlbA0KPiA+ID4gPiBSZWdubyB3cm90ZToNCj4gPiA+ID4gPiBJbCAwOC8wNy8yNCAyMTo0Mywg
TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gaGEgc2NyaXR0bzoNCj4gPiA+ID4gPiA+IE5vdCBldmVy
eSBlZnVzZSByZWdpb24gaGFzIGNlbGxzIHN0b3JpbmcgU29DIGluZm9ybWF0aW9uLg0KPiA+ID4g
PiA+ID4gT25seSByZWdpc3Rlcg0KPiA+ID4gPiA+ID4gYW4gc29jaW5mbyBkZXZpY2UgaWYgdGhl
IHJlcXVpcmVkIGNlbGxzIGFyZSBwcmVzZW50Lg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBU
aGlzIHByZXZlbnRzIHRoZSBwb2ludGxlc3MgcHJvY2VzcyBvZiBjcmVhdGluZyBhbiBzb2NpbmZv
DQo+ID4gPiA+ID4gPiBkZXZpY2UsDQo+ID4gPiA+ID4gPiBwcm9iaW5nIGl0IHdpdGggdGhlIHNv
Y2luZm8gZHJpdmVyIG9ubHkgdG8gdWx0aW1hdGVseSBlcnJvcg0KPiA+ID4gPiA+ID4gb3V0IGxp
a2Ugc28NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gICAgICBtdGstc29jaW5mbyBtdGstc29j
aW5mby4wLmF1dG86IGVycm9yIC1FTk9FTlQ6IEZhaWxlZA0KPiA+ID4gPiA+ID4gdG8gZ2V0IHNv
Y2luZm8gZGF0YQ0KPiA+ID4gPiA+ID4gICAgICBtdGstc29jaW5mbyBtdGstc29jaW5mby4wLmF1
dG86IHByb2JlIHdpdGggZHJpdmVyIG10ay0NCj4gPiA+ID4gPiA+IHNvY2luZm8gZmFpbGVkIHdp
dGggZXJyb3IgLTINCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhpcyBpc3N1ZSBpcyBvYnNl
cnZlZCBvbiB0aGUgbXQ4MTgzLWt1a3VpLWphY3V6emktanVuaXBlci0NCj4gPiA+ID4gPiA+IHNr
dTE2DQo+ID4gPiA+ID4gPiBwbGF0Zm9ybSwgd2hpY2ggaGFzIHR3byBlZnVzZSByZWdpb25zLCBi
dXQgb25seSBvbmUgb2YgdGhlbQ0KPiA+ID4gPiA+ID4gY29udGFpbnMgdGhlDQo+ID4gPiA+ID4g
PiBTb0MgZGF0YS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgdGhpbmsg
dGhhdCB3ZSBzaG91bGQgcmF0aGVyIHJlbW92ZSBvciBkaXNhYmxlIHRoZSBmaXJzdA0KPiA+ID4g
PiA+IGVGdXNlIHJlZ2lvbiwgYXMNCj4gPiA+ID4gPiBldmVuIHRob3VnaCB0aGF0IGlzIGVuYWJs
ZWQ6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICAgLSBUaGlzIGlzIHRoZSBvbmx5IFNvQyBoYXZp
bmcgdHdvIHJlZ2lvbnMNCj4gPiA+ID4gPiAgICAgIC0gSSdtIG5vdCBldmVuIHN1cmUgdGhhdCB0
aGUgcmVnaW9uIGF0IDB4ODAwMDAwMCBpcw0KPiA+ID4gPiA+IHJlYWxseSBlZnVzZQ0KPiA+ID4g
PiA+ICAgICAgLSBOb3QgZXZlbiByZWZlcmVuY2VkIGluIGRhdGFzaGVldHMuLi4uDQo+ID4gPiA+
ID4gICAgLSBJdCdzIHVudXNlZCwgYXMgaW4sIGl0J3Mgbm90IGV4cG9zaW5nIGFueSBpbmZvcm1h
dGlvbg0KPiA+ID4gPiA+IGFuZCBubyBkZWNsYXJlZCBjZWxscw0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IERvbid0IG1pc3VuZGVyc3RhbmQgbWUsIHRoaXMgaXMgbm90IGFuIGludmFsaWQgY2hhbmdl
LCBidXQgSQ0KPiA+ID4gPiA+IHJhdGhlciBwcmVmZXINCj4gPiA+ID4gPiB0byByZXNvbHZlIHRo
aXMgYnkgZGlzYWJsaW5nIHRoYXQgKGVmZmVjdGl2ZWx5IHVudXNlZCEpIG5vZGUsDQo+ID4gPiA+
ID4gYXZvaWRpbmcgdG8NCj4gPiA+ID4gPiBhZGQgbW9yZSBsaW5lcyB0byB0aGlzIGRyaXZlciB0
aGF0IHdvdWxkIGJlIHVzZWxlc3MgYWZ0ZXINCj4gPiA+ID4gPiBmaXhpbmcgdGhhdCBzbWFsbA0K
PiA+ID4gPiA+IHNpbmdsZSB0aGluZy4NCj4gPiA+ID4gDQo+ID4gPiA+IEknbSBub3QgY29uZmlk
ZW50IHRoYXQgd2UgY2FuIHNheSB0aGF0IHRoYXQgZWZ1c2UgaXMgbm90DQo+ID4gPiA+IGV4cG9z
aW5nIGFueQ0KPiA+ID4gPiBpbmZvcm1hdGlvbi4gSW5kZWVkIHRoZXJlIGFyZSBubyBjZWxscyBz
byBpdCdzIG5vdCB1c2VkIGJ5IGFueQ0KPiA+ID4gPiBvdGhlciBkcml2ZXIsIGJ1dA0KPiA+ID4g
PiB0aGUgZWZ1c2UgY29udGVudHMgYXJlIHN0aWxsIGV4cG9zZWQgdG8gdXNlcnNwYWNlIGlmDQo+
ID4gPiA+IENPTkZJR19OVk1FTV9TWVNGUyBpcw0KPiA+ID4gPiBlbmFibGVkLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gSSBkdW1wZWQgaXQgb24gb25lIG9mIHRoZSBtdDgxODMta3VrdWktamFjdXp6aS1q
dW5pcGVyLXNrdTE2DQo+ID4gPiA+IHVuaXRzOg0KPiA+ID4gPiANCj4gPiA+ID4gICAgICQgbHMg
LWwgL3N5cy9idXMvbnZtZW0vZGV2aWNlcy8NCj4gPiA+ID4gICAgIHRvdGFsIDANCj4gPiA+ID4g
ICAgIGxyd3hyd3hyd3ggICAgMSByb290ICAgICByb290ICAgICAgICAgICAgIDAgSnVsIDE4IDIx
OjQzDQo+ID4gPiA+IG1tdGQwIC0+DQo+ID4gPiA+IC4uLy4uLy4uL2RldmljZXMvcGxhdGZvcm0v
c29jLzExMDEwMDAwLnNwaS9zcGlfbWFzdGVyL3NwaTEvc3BpMQ0KPiA+ID4gPiAuMC9tdGQvbXRk
MC9tdGQwDQo+ID4gPiA+ICAgICBscnd4cnd4cnd4ICAgIDEgcm9vdCAgICAgcm9vdCAgICAgICAg
ICAgICAwIEp1bCAxOCAyMTo0Mw0KPiA+ID4gPiBudm1lbTAgLT4gLi4vLi4vLi4vZGV2aWNlcy9w
bGF0Zm9ybS9zb2MvODAwMDAwMC5lZnVzZS9udm1lbTANCj4gPiA+ID4gICAgIGxyd3hyd3hyd3gg
ICAgMSByb290ICAgICByb290ICAgICAgICAgICAgIDAgSnVsIDE4IDIxOjQzDQo+ID4gPiA+IG52
bWVtMSAtPiAuLi8uLi8uLi9kZXZpY2VzL3BsYXRmb3JtL3NvYy8xMWYxMDAwMC5lZnVzZS9udm1l
bTENCj4gPiA+ID4gICAgICQgaGV4ZHVtcCAtQyAvc3lzL2J1cy9udm1lbS9kZXZpY2VzL252bWVt
MC9udm1lbQ0KPiA+ID4gPiAgICAgMDAwMDAwMDAgIDg4IDA3IDAwIDAwIDAwIDhhIDAwIDAwICAw
MCBjYSAwMCAwMCAwMCAwMCAwMA0KPiA+ID4gPiAwMCAgfC4uLi4uLi4uLi4uLi4uLi58DQo+ID4g
PiA+ICAgICAwMDAwMDAxMA0KPiA+ID4gPiANCj4gPiA+ID4gSSBwb3dlciBjeWNsZWQgdGhlIHVu
aXQgYW5kIHJhbiB0aGlzIGFnYWluIGFuZCBpdCBzdGlsbCBzaG93ZWQNCj4gPiA+ID4gdGhlIHNh
bWUNCj4gPiA+ID4gY29udGVudHMuIEkgYWxzbyByYW4gdGhlIHNhbWUgb24gYSBkaWZmZXJlbnQg
dW5pdCBvZiB0aGUgc2FtZQ0KPiA+ID4gPiBtb2RlbCBhbmQgaXQNCj4gPiA+ID4gc2hvd2VkIHRo
ZSBzYW1lIGNvbnRlbnRzLiBPZiBjb3Vyc2UgdGhpcyBkb2Vzbid0IHByb3ZlDQo+ID4gPiA+IGFu
eXRoaW5nLCBidXQgZ2l2ZW4gdGhhdA0KPiA+ID4gPiB0aGUgY29udGVudHMgc2VlbSB0byBiZSBj
b25zdGFudCBhY3Jvc3MgcmVib290cyBhbmQgZXZlbg0KPiA+ID4gPiBkaWZmZXJlbnQgdW5pdHMs
IGl0DQo+ID4gPiA+IGRvZXMgbG9vayBsaWtlIGl0IGNvdWxkIGJlIGFuIGVmdXNlIHRvIG1lLiA6
KQ0KPiA+ID4gPiANCj4gPiA+ID4gQXMgdG8gd2hldGhlciB0aGUgY29udGVudHMgYXJlIHVzZWZ1
bCBhdCBhbGwsIG9yIGlmIHRoZXJlIGFyZQ0KPiA+ID4gPiB1c2Vyc3BhY2UgYXBwbGljYXRpb25z
IG1ha2luZyB1c2Ugb2YgaXQgSSBoYXZlIG5vIGNsdWUuIEJ1dCBpZg0KPiA+ID4gPiBpbiBkb3Vi
dCwNCj4gPiA+ID4gc2hvdWxkbid0IHdlIGtlZXAgaXQgYXJvdW5kPw0KPiA+ID4gDQo+ID4gPiAo
QWRkZWQgV2lsbGlhbS10dyBMaW4gZnJvbSBNZWRpYVRlayB0byB0aGUgbG9vcCkNCj4gPiA+IA0K
PiA+ID4gSSdsbCBzYXkgeWVzIG9ubHkgaWYgTWVkaWFUZWsgKHBsZWFzZSEpIHNheXMgdGhhdCB0
aGlzIHJlZ2lvbiBoYXMNCj4gPiA+IHVzZWZ1bA0KPiA+ID4gaW5mb3JtYXRpb24sIGFuZCBvbmx5
IGlmIE1lZGlhVGVrIGFjdHVhbGx5IHRlbGxzIHVzIHdoYXQgdGhvc2UNCj4gPiA+IGZ1c2VzIGFy
ZS4NClRoaXMgbm9kZSBjb250YWlucyBzb21lIFNvQy1yZWxhdGVkIGluZm9ybWF0aW9uLiBIb3dl
dmVyLCB0aGlzIGlzDQp1bnJlbGF0ZWQgdG8gdGhlIG10ay1zb2NuaW5mbyBkcml2ZXIuDQo+ID4g
PiANCj4gPiA+IFRoZSByZWFzb24gaXMgdGhhdCBzb21ldGltZXMgd2hlbiBTb0NzIGhhdmUgbXVs
dGlwbGUgZWZ1c2UNCj4gPiA+IHJlZ2lvbnMsIG9uZSBjb250YWlucw0KPiA+ID4gdW5jYWxpYnJh
dGVkIGRhdGEgZm9yIGZhY3RvcnkgY2FsaWJyYXRpb24gKGV0YyBldGMpLCBvbmUgY29udGFpbnMN
Cj4gPiA+IGRhdGEgdGhhdCBkZXJpdmVzDQo+ID4gPiBmcm9tIHRoZSB1bmNhbGlicmF0ZWQgcmVn
aW9ucyBhbmQgdGhhdCBpcyBzdXBwb3NlZCB0byBiZSB1c2VkIGJ5DQo+ID4gPiB0aGUgT1MuDQo+
ID4gPiANCj4gPiA+IElmIHdlIGdvdCB0aGUgdW5jYWxpYnJhdGVkIGRhdGEgdGhhdCBpcyAqbm90
KiBmb3IgT1MgdXNhZ2UgaW4gdGhlDQo+ID4gPiBNVDgxODMgRFQsIHRoZW4NCj4gPiA+IHdlIGNh
biBhcyB3ZWxsIGp1c3QgcmVtb3ZlIGl0Lg0KPiA+ID4gDQo+ID4gPiBCZXNpZGVzLCBJIGhhdmUg
bm8gY29uY2VybiBhYm91dCBhbnkgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIHVzaW5nDQo+ID4gPiB0
aGF0Lg0KPiA+IA0KPiA+IE5vIHJlcGx5LCBzbyBJJ3ZlIHNlbnQgdjMuDQo+ID4gDQo+IA0KPiBS
ZXNvbHZlZCB3aXRoIGRldmljZXRyZWUgY2hhbmdlLiBQbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2gu
DQo+IA0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0KPiANCg==

