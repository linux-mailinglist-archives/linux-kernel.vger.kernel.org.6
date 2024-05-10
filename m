Return-Path: <linux-kernel+bounces-175252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666498C1D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5876283FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 03:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86791494CA;
	Fri, 10 May 2024 03:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N6dfV1SW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hyePdJA8"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77398149E06
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312108; cv=fail; b=XW0UjxQJp1DuJEtqzPX2TENuRXINPk0gygZVZEqrPnrL7vCFN5TlNT3HLcC8fzXhg+Vs7dDpCtu031FSzeEaRGEdw0Z76m4MtsvdSs1xSo8+PQPCkh4VXdZlin97hiwMgHk5QdcCWB9Zt91RlTUo8U7uyW7gsQVtKZ0DD67ecr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312108; c=relaxed/simple;
	bh=/tG3pI9qDLfqcipXIvxzetLF5Z5GyY2HpIIm7Shstpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j4Dn/7/uW/H0T9aBfoA8C3DG743/EWUfG+5g2ggqJpBxW7Nmu2ACeS4FhagGza1/PWJVKpj8Z1T2+aug5rEBP5XCyjv1J70SD8UQDYvfe8HHqEFLkBu+aPzhpAteRFTXfe3rOvcXLlNMlJ+PI7cMQwHVnZXeq2je5nUQCGbtyi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N6dfV1SW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=hyePdJA8; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 454fe77e0e7e11efb92737409a0e9459-20240510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/tG3pI9qDLfqcipXIvxzetLF5Z5GyY2HpIIm7Shstpw=;
	b=N6dfV1SWIdn4YXj73FHIrrXRiDgjrb1IMdNvKniJ/jqJiogJBFayYimpDM3BDFS8KI2JWM5VOKsmZrz0WSsdEG7qu8Jv+YhMGVuFLEdOw2qbfJdWaacv+9LG2vtnxfF82gZ1k9P1qmxhql+KADq3XXsNui+IZ6UEb2R+h9dDP/o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4c4c0a95-95e6-42ce-80cb-42eb272d9fa8,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:da15eafb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 454fe77e0e7e11efb92737409a0e9459-20240510
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1530082226; Fri, 10 May 2024 11:34:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 May 2024 11:34:55 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 May 2024 11:34:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjkbCWeI/UeZQCe0Kmz6rC/VTapwmEptYHhop0J6yT0H9C1gaLvU2MAyp0YikEmzVuLFuyTMYmgJ/sNJqUanqGKA9XrHS0XaFDC7XkLt9KxnvudYf/KXZ4XxwnEcctTWFKHR5BlsFKTymDBrUt/IGUcAGyIKMj+yE5cuzlxauKbciwdNM83zdqYvYUcWDtjNwvpge+egmazGMXX27K7b8AfVBHzobI+8ucdkNx8XV/gCb/6e7xV07meLhq72o3WzErW2AViR9UKdpi6jbMh+Jn6192pD8Nh2yK5JXMSEGsS704txqm4QDWNWW1Hbxms2qsV6QJ68vDeVokRVJqeEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tG3pI9qDLfqcipXIvxzetLF5Z5GyY2HpIIm7Shstpw=;
 b=OutlEmX+fgxUQmt2Djhmtm1yk8MFxmtJbYxU3RCqzMq8wy9JUVryi4/iB67UWDlyQoRI8brdi0XKPZPGKJ342ZKS7yvqU2LcoG5c3xXqckobDuIz0ce1pdv9mX5meLwYBiy81Yf7rqNF1EsglFwXK0DIetaUANSPajFsSUBOpllpP9Tk4ovDORmbflTb5He+UP5/D8T29+2De0cRGEmg7QPBzYEmOBo2KydI7w0GpzPXa2jJRNQhUTEUF+f3V52JiHDfQfi4KjdNKcD0E0fZZLEEfZYqdIj4fnOXaLXQ/did676eMeXewKf29RFLoYGiwGZU2yjFxRBLdDp/6nCLtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tG3pI9qDLfqcipXIvxzetLF5Z5GyY2HpIIm7Shstpw=;
 b=hyePdJA8GBJ4/0zuHRHFeFal6nIkN3le/FtFxd4OqrDuzpn7wJMS7MccVsDy3C0FQmTe1i9kkzqfpHdF2I8fDECBN6RZ+VFr7teXakODU45JIss3XAm4qekrNq3ZuMiuQk00hTLZmpitK1HsZfkos4qTJXD3lBLk+F4RbK32ESc=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB8223.apcprd03.prod.outlook.com (2603:1096:405:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Fri, 10 May
 2024 03:34:53 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%7]) with mapi id 15.20.7587.011; Fri, 10 May 2024
 03:34:53 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "krzk@kernel.org"
	<krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "amergnat@baylibre.com"
	<amergnat@baylibre.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: Fix sleeping function called from
 invalid context
Thread-Topic: [PATCH v2] mailbox: mtk-cmdq: Fix sleeping function called from
 invalid context
Thread-Index: AQHaoS1YqvN5CWMkskCg/TbzahyW87GNzGkAgAIHRIA=
Date: Fri, 10 May 2024 03:34:52 +0000
Message-ID: <6fcd48b14e865c25e6db7559fe6b946537bfa0ce.camel@mediatek.com>
References: <20240508095143.12023-1-jason-jh.lin@mediatek.com>
	 <74767f1d-639a-4477-a38b-e5f15bf575df@kernel.org>
In-Reply-To: <74767f1d-639a-4477-a38b-e5f15bf575df@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB8223:EE_
x-ms-office365-filtering-correlation-id: 0fb011d0-ae54-48a1-d6fe-08dc70a2277c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?czl3YWdtOHo2dFlJT3hOT2RsZ2lwUlM1QXhMemljQkkzTmIxRW55TlJwc0xw?=
 =?utf-8?B?WVlRcWkzWGxLYXZocU1GVW4zRy9wREQrMStEM3RKZ3ZaVHEzYWMvSlc4S1Fi?=
 =?utf-8?B?MUp2TEJjanFDOS9RQVkyRG5FSmtiY29zRkhOemFsY2VZKzNacVM4YmNQWUxT?=
 =?utf-8?B?N2p6Zll3SEZHTG9WckIvMzhSODJVcXB1blNLRVpMY0ZwNmxJNlBaTzNTV2RJ?=
 =?utf-8?B?c1k3czBzbGNsR3hkWWM4NDB4K1N6L3BxNzdzMVR6UHpINmZPcmF5YmtSY0FT?=
 =?utf-8?B?ZVJUWVY0S0l1N2lRakx6L0d4NW94bmhqU1pLUnBydWpmWktRQ252UC9oVXFH?=
 =?utf-8?B?K3JydkF2TDBSSDBTb3N2cHFoSWZyNEh2UXBBaFppTExKUjlLZmpUVUc4UDNO?=
 =?utf-8?B?eURXMERHSVh6MVh3OFR2Q2dhdy9zNW0xc285cjFIcEdlaSszVmxJdjRFSXBF?=
 =?utf-8?B?eUUyQk5wWWdCc3NBQllWc2dWTk16VE1NNzkwODFvRGdHVFRyenorbnovR0tS?=
 =?utf-8?B?VUZteEVtVEhzUGVEK0VxMS9TM3FkSGJxVzkzeUVQdmJ0dGVVa2o5Q3MvM01D?=
 =?utf-8?B?d1ZwQ29qVmRlTmZab1hHelVpRWZGYUIzVmxvVlhHY0pPSzNtTWYyVnhPTUtr?=
 =?utf-8?B?UnJsRTBBNi9nNjRuTHp5ZGtVL2w2ZmUxdWM5OVdWOWVVaThkMHNEOTFTNzY0?=
 =?utf-8?B?cDIrTDNma3E4ajNmRXAxRlQrOEpiZUZOc21zNGlleG9oNGNEQ2g1S2J3bDh4?=
 =?utf-8?B?ck5qT2pIUGJzUUFpTEQra25LbkJydTFTU05UV2szWXdZMzlGRkd3VzBDQk56?=
 =?utf-8?B?WW1CTVVYaUsrUmptWm9GcHFEbk9MWjYzY1A4cy9CYXU3WTdNUEt4VGFGN29o?=
 =?utf-8?B?YW9hZmtWQkRLVFdCVkRRL21sM283VzVlZVVLZ0xUMC9PN01pWXZCdFlub0Jy?=
 =?utf-8?B?My9nWE9rWE1WemswRHhmVERxa0NrVmdtOVZTdVp0Qzg1cldlRXQwZi8vTnRP?=
 =?utf-8?B?aHJDbWw4SFB1NUNUM3YxZjQrWGd2eVlvRVM4ZTk3ZVdVNENUQ08xM3Z3ZnVF?=
 =?utf-8?B?djFiZ2RIbFI0ZEpBbEhkVlRpL1dWVmJKSGZzdWo2citHeTFKTHEwYjl4SGR5?=
 =?utf-8?B?QkYxeUJKMkNZa0xKVVg4ajhPdHNsbEF6OFh0WEdxbHc3YXdnQlg2TEpodGEz?=
 =?utf-8?B?TnZ3WW1MV3hnWjFsRmUveXdTZWs2NENRTVVUZGgzMU1pbHRyK2REeFc0clVV?=
 =?utf-8?B?amVBSElsRGNiM0w5QkN3VUlySEJ6bmN5bFhJS1FUQm55MkU3bEpEWWhPb25G?=
 =?utf-8?B?MmhLZEpkVFBoTitIaDJnNnQ0RG5nQ2p6d0JqZnIySWIxOWlpS0xSN0c0aW5O?=
 =?utf-8?B?R3M2T00wOEg3dDdrbmYyVU9SMlB0NVJ0WXpaWFJjcUhFdlRyeVBMUjJhOVBO?=
 =?utf-8?B?eGdndlVBUTBaUisyYWI1RzVqMHMxM0dQKzVNay9KTWxqbGVnTDd4bVI2R1BK?=
 =?utf-8?B?MVJPMENEeWw1L1VrdVExd0lIckhyditUUkJaWmtITWNUVmM1L2ZaTnJUN0d0?=
 =?utf-8?B?cDVzT25JYlQ5cVNCYkdldGw4T3JaTVJYcERQZ1JRK0hPc1g3ZFJEMjNXQVRp?=
 =?utf-8?B?QnMxR2ZBWDlyZlc0YjNCVVM5cnZubHlKV29CWjJHSTM0OVBnekFrbGJ0elVR?=
 =?utf-8?B?YnpMdmlVS3h2ZmNuejJFWGtqMW42R1dVQmpLYk80aHBOY1hGZzNpMGMySEpy?=
 =?utf-8?B?dmpDWUx1MVAxQVBsZGV2UEFTeXBJK0ZGbFMwZm5wellabVk1ckd1MGFndVdO?=
 =?utf-8?B?L25wZy9pM1kvTUpZbXhsQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVVpRHdaZ1JSSzYzU0JzUkcwVU9pYW5hMXRjUjRHZzhJQWZHbUJ5dlBLeXgx?=
 =?utf-8?B?Szdibk9aVkZMbldtMWpXQmlPOFVTWUdSQlpCMy9hM084UExnS3RpOFJqR3Vq?=
 =?utf-8?B?K25vRGtIMUNYM0I2WlU2S0t0ZFlLZnBNOXI4QmFYRVMrcUxQUk5PRGJ6eGFX?=
 =?utf-8?B?WkJRSUdsTkNxMklTeHN2Wk9sc0JKcTFtTThFUnRJY3NSNTlpQlZJMmIrbi9O?=
 =?utf-8?B?R0R4dkxneUI1SlBvOGcwa2UzMitWNFRxdzF1Nnd4eHBMaTgxYzRoY21Gb3VQ?=
 =?utf-8?B?VnlaTUJCZkNlNGxTTnliejRubGp1U2V3NnNHSHRSV25naFQvN0ltNVB0QnB6?=
 =?utf-8?B?NGY1eGZNMEpsNmI5RVhGakFVRTJpM3Zoc2EwVkZOSGlFRWJ6bkNORmE2YlQy?=
 =?utf-8?B?djdKSmFENVFBMXVNVWdNb3JWT0pQclltWDIxaC9qdUdrdDlrNVMxT0JWeDFp?=
 =?utf-8?B?R0dhOTExTmNiR3hGVDBBWDVPZ2RDdDhCS2w2NWVqdm1RSjZtVzIydGlWa2th?=
 =?utf-8?B?b2tJUGZ3Z1F5Sm1QeXhzRDArcjNBbXU2TEdydm8zMmc5NVlydHVBMisyR0t0?=
 =?utf-8?B?SHFSUTNRNENLbTFqaFlYZkdCL1g5QSt2R2gzNTY4K2Q4enkyOGw1akdrci9X?=
 =?utf-8?B?c1FRMmgrL0xidm1wdEJ1SmpzOStMZkx5azd0TUVvdSs2NXFnN1dkenRNVDNh?=
 =?utf-8?B?UHBRNEpRaVJyNXBRWmpxVlZvY0RlZ1ovMnJhNkJ5cEUzT0lUTXJKTTk4R2t2?=
 =?utf-8?B?a1FYQWJrY3diQjdJdFNyNDlhNVZLMlpHRk9BMkd1RGZkOWRoSkFHbGJhdTh0?=
 =?utf-8?B?NFdBeFE4c0dja0Zoa2FhWDVVU0svOFZHRlErYkg5ZUE5SkY3NzdKakozL2d6?=
 =?utf-8?B?RWcyZFRWdjFTbEFuRjVCL1ZvQXJGdmRvZ0xnT1VJOXI1dXcrT2U4SmQ4WDU2?=
 =?utf-8?B?SUdKaGRNc3pXdlMzNzQwMEMzeXJvVXIrWGdoWVY5aFduTEpzVHJaYnpFcU5v?=
 =?utf-8?B?RDczMmZwS3luZVR5UGRpNEJNbVVTY3IvWmN2ak1zRGtQTlQzTkQ1OWd3aVR6?=
 =?utf-8?B?bC9RN052akJBQitpUjNndWJ5Z1lnM2lBM2tVMW5IazBaQVJyV3UvR3RNMVFL?=
 =?utf-8?B?aG5aeGJrZ0NpODRHMnVmTjlsWmhmTlN3R0V6UFdaY2Z4NjZCU2R0Q1lwYThH?=
 =?utf-8?B?WnR0eitvd0hRZjEwZVhXaXNmM2EreVJBclZHQ3hSLzFselpuWDczTnFBM2Vk?=
 =?utf-8?B?L0R6dVoxNUtBZVYydVcvb24vNkY1VzI0NzU1Kzh5cUFkVko2VVVYYmdYMEU1?=
 =?utf-8?B?T0szR1VLaW5ST2RLR1BlTmZ0dVk0VHZPYTVsYUV2SWZmNUMzbTZsTC9SaFE4?=
 =?utf-8?B?cG5nYWpCK0YvZUNFQkhNeC9pWCtRY0loYlFnQXNqY3hxYjJRSGVPbGFVaUJn?=
 =?utf-8?B?eC8zVGFsT2lJaTA3dGZZR0FlYlJ0L0V2QzY4elYrMmdUWTZFbWNSTCtPRjQw?=
 =?utf-8?B?TmplU1lmcWZCTCtkNmdFUEx3azFsSEVKLzBFZU1haHVFb3BKczVGQnc5YTJP?=
 =?utf-8?B?cHB1aU9BQjlLcEE0ZkwwcFhYQk5CTTB4Nyt5RTcxL2tydk5heDBNRFdSNU4x?=
 =?utf-8?B?aDZHWFFvanR5ZFZqWk94Skl5bVovdnpaU0p1bU5QN3p4K0thZVNDR2dKdTAw?=
 =?utf-8?B?cmN4dHVSTnNMazF5b0dVeXFRNGREcVNSdVdveWZQdFFDVXVkMUdvSkR2eW8w?=
 =?utf-8?B?WkhIdVc5eUNVeTNGMUNNNS92TWdRNU12YVlFNkF5VDZhS1dGSG5DZXYzRHNT?=
 =?utf-8?B?WmU2Z1R1OXJtRHcvREZmU29ValVoK3lEYWxjU0lZVWl3ZXE0c29CTmRaUjli?=
 =?utf-8?B?Ymt5RjR0bU4vL25VZEJWVE85enQwT0xKWWJVTW5JYlJwdVY3d0IrWUdXYitS?=
 =?utf-8?B?dmJTSHhIYks4dDFNTXVBTUVKOEFtZ1BCOGdwYWdqVnhmTHJXbUpPbzhaZVhB?=
 =?utf-8?B?dXZoV2h5bzQ0cy9naS9BeW1jd3FNZXpiVTZXcUI5YjBDc2tGV3p0ZjBVcXNv?=
 =?utf-8?B?RTBla0dhZnFtTnRmWVg2d3g4K2QyVWh6TWtYczJocjZ2T1pOakpsNGlhalI0?=
 =?utf-8?B?dnVmb2JXeGo2YTh6NFdlOG13M09EV1JYUUw0WnZ5WldCN3Z3eTlsK2JJL2Vr?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38D1981D3279A14DB1BB5382B18684B4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb011d0-ae54-48a1-d6fe-08dc70a2277c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 03:34:52.8890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJl0ITJo2DyJQTzlVd+5HS/Opch6ND3R0CggRpUAa/ZCUocEuhWwRY4NMqXwNsAx/yvRou4r/2lso3PCixzHl4iQOu1SjlSldhz5Qlfchx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8223
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--28.376700-8.000000
X-TMASE-MatchedRID: EMyCvCfVN1GnykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2mlaAItiONP0rHkgIan9a0bUV4VfJ6SB0ItZ
	HZNyOYjENU8NIZiEsYktn4wFxsjyPqn+UwR+WxF6PmEs8Jfdl0+dIlGzDlIXi8pw+dn1doyV576
	my5IxjurhXxBYOPUpPkqBOLBp0ogdOgDDV7TiL3XV7tdtvoibanF8rflXuiRWxQoohBwiTQp9ZI
	gQn42BdgvWwJkUpSqKfzZFQV/pb/3pQj8976c7ISEQN/D/3cG5x9T7TIgq5habuBeSz8VQ6oPPm
	GyJpwt8uxnUqX2q8MvDbMnrBQfp8oXYTq/8UnCFc/msUC5wFQRv1UCk/2TUE1VNlojpO42iXNag
	pKKGTE8HJp4X9qDzr8WNFhoH0nAPS5WmHt3l/xg5KPhGIg0MRwx0jRRxcQfOZHfpKN1YMZcxFQx
	p3PhHygsUtzIjIFblHHcnuUG2vMGe90Z2gWyxangIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi4Hwn1
	pZzW/9XKaQsz6vtVJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--28.376700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	3522FDBCB7996DACD5877967BB9E388B96C2F88575DE42109D9F82BD610502E12000:8

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpPbiBXZWQsIDIwMjQt
MDUtMDggYXQgMjI6MzYgKzAyMDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+ICAJIA0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiAgT24gMDgvMDUvMjAyNCAxMTo1MSwgSmFzb24tSkguTGluIHdyb3RlOg0KPiA+IFdo
ZW4gd2UgcnVuIGtlcm5lbCB3aXRoIGxvY2tkZWJ1ZyBvcHRpb24sIHdlIHdpbGwgZ2V0IHRoZSBC
VUcNCj4gYmVsb3c6DQo+ID4gWyAgMTA2LjY5MjEyNF0gQlVHOiBzbGVlcGluZyBmdW5jdGlvbiBj
YWxsZWQgZnJvbSBpbnZhbGlkIGNvbnRleHQNCj4gYXQgZHJpdmVycy9iYXNlL3Bvd2VyL3J1bnRp
bWUuYzoxMTY0DQo+ID4gWyAgMTA2LjY5MjE5MF0gaW5fYXRvbWljKCk6IDEsIGlycXNfZGlzYWJs
ZWQoKTogMTI4LCBub25fYmxvY2s6IDAsDQo+IHBpZDogMzYxNiwgbmFtZToga3dvcmtlci91MTc6
Mw0KPiANCj4gVHJpbSBsb2dzIGZyb20gaXJyZWxldmFudCBjb250ZXh0LiB0aW1lc3RhbXBzIGFy
ZSB1c2VsZXNzIGhpcy4NCj4gUmVnaXN0ZXJzDQo+IGFzIHdlbGwuIEFkZHJlc3NlcyBvZiBzdGFj
a3RyYWNlIGFzIHdlbGwgYW5kIGJldHRlciBqdXN0IGRlY29kZSBpdC4NCj4gDQoNCk9LLCBJJ2xs
IHJlbW92ZSB0aGUgdXNlbGVzcyB0aW1lc3RhbXBzIGFuZCByZWdpc3RlcnMuDQoNCj4gDQo+ID4g
WyAgMTA2LjY5MjIyNl0gcHJlZW1wdF9jb3VudDogMSwgZXhwZWN0ZWQ6IDANCj4gPiBbICAxMDYu
NjkyMjU0XSBSQ1UgbmVzdCBkZXB0aDogMCwgZXhwZWN0ZWQ6IDANCj4gPiBbICAxMDYuNjkyMjgy
XSBJTkZPOiBsb2NrZGVwIGlzIHR1cm5lZCBvZmYuDQo+ID4gWyAgMTA2LjY5MjMwNl0gaXJxIGV2
ZW50IHN0YW1wOiAwDQo+ID4gWyAgMTA2LjY5MjMzMV0gaGFyZGlycXMgbGFzdCAgZW5hYmxlZCBh
dCAoMCk6IFs8MDAwMDAwMDAwMDAwMDAwMD5dDQo+IDB4MA0KPiA+IFsgIDEwNi42OTIzNzZdIGhh
cmRpcnFzIGxhc3QgZGlzYWJsZWQgYXQgKDApOiBbPGZmZmZmZmVlMTVkMzdmYTA+XQ0KPiBjb3B5
X3Byb2Nlc3MrMHhjOTAvMHgyYWMwDQo+ID4gWyAgMTA2LjY5MjQyOV0gc29mdGlycXMgbGFzdCAg
ZW5hYmxlZCBhdCAoMCk6IFs8ZmZmZmZmZWUxNWQzN2ZjND5dDQo+IGNvcHlfcHJvY2VzcysweGNi
NC8weDJhYzANCj4gPiBbICAxMDYuNjkyNDczXSBzb2Z0aXJxcyBsYXN0IGRpc2FibGVkIGF0ICgw
KTogWzwwMDAwMDAwMDAwMDAwMDAwPl0NCj4gMHgwDQo+ID4gWyAgMTA2LjY5MjUxM10gQ1BVOiAx
IFBJRDogMzYxNiBDb21tOiBrd29ya2VyL3UxNzozIE5vdCB0YWludGVkDQo+IDYuMS44Ny1sb2Nr
ZGVwLTE0MTMzLWcyNmU5MzNhY2E3ODUgIzENCj4gNjgzOTk0MmUxY2YzNDkxNGIwYTM2NjEzNzg0
M2RkMjM2NmY1MmFhOQ0KPiA+IFsgIDEwNi42OTI1NTZdIEhhcmR3YXJlIG5hbWU6IEdvb2dsZSBD
aXJpIHNrdTAvdW5wcm92aXNpb25lZCBib2FyZA0KPiAoRFQpDQo+ID4gWyAgMTA2LjY5MjU4Nl0g
V29ya3F1ZXVlOiBpbWdzeXNfcnVubmVyIGltZ3N5c19ydW5uZXJfZnVuYw0KPiA+IFsgIDEwNi42
OTI2MzhdIENhbGwgdHJhY2U6DQo+ID4gWyAgMTA2LjY5MjY2Ml0gIGR1bXBfYmFja3RyYWNlKzB4
MTAwLzB4MTIwDQo+ID4gWyAgMTA2LjY5MjcwMl0gIHNob3dfc3RhY2srMHgyMC8weDJjDQo+ID4g
WyAgMTA2LjY5MjczN10gIGR1bXBfc3RhY2tfbHZsKzB4ODQvMHhiNA0KPiA+IFsgIDEwNi42OTI3
NzVdICBkdW1wX3N0YWNrKzB4MTgvMHg0OA0KPiA+IFsgIDEwNi42OTI4MDldICBfX21pZ2h0X3Jl
c2NoZWQrMHgzNTQvMHg0YzANCj4gPiBbICAxMDYuNjkyODQ3XSAgX19taWdodF9zbGVlcCsweDk4
LzB4ZTQNCj4gPiBbICAxMDYuNjkyODgzXSAgX19wbV9ydW50aW1lX3Jlc3VtZSsweDcwLzB4MTI0
DQo+ID4gWyAgMTA2LjY5MjkyMV0gIGNtZHFfbWJveF9zZW5kX2RhdGErMHhlNC8weGIxYw0KPiA+
IFsgIDEwNi42OTI5NjRdICBtc2dfc3VibWl0KzB4MTk0LzB4MmRjDQo+ID4gWyAgMTA2LjY5MzAw
M10gIG1ib3hfc2VuZF9tZXNzYWdlKzB4MTkwLzB4MzMwDQo+ID4gWyAgMTA2LjY5MzA0M10gIGlt
Z3N5c19jbWRxX3NlbmR0YXNrKzB4MTYxOC8weDIyMjQNCj4gPiBbICAxMDYuNjkzMDgyXSAgaW1n
c3lzX3J1bm5lcl9mdW5jKzB4YWMvMHgxMWMNCj4gPiBbICAxMDYuNjkzMTE4XSAgcHJvY2Vzc19v
bmVfd29yaysweDYzOC8weGY4NA0KPiA+IFsgIDEwNi42OTMxNThdICB3b3JrZXJfdGhyZWFkKzB4
ODA4LzB4Y2QwDQo+ID4gWyAgMTA2LjY5MzE5Nl0gIGt0aHJlYWQrMHgyNGMvMHgzMjQNCj4gPiBb
ICAxMDYuNjkzMjMxXSAgcmV0X2Zyb21fZm9yaysweDEwLzB4MjANCj4gPiANCj4gPiBXZSBmb3Vu
ZCB0aGF0IHRoZXJlIGlzIGEgc3Bpbl9sb2NrX2lycXNhdmUgcHJvdGVjdGlvbiBpbg0KPiBtc2df
c3VibWl0KCkNCj4gPiBvZiBtYWlsYm94LmMgYW5kIGl0IGlzIGluIHRoZSBhdG9taWMgY29udGV4
dC4NCj4gPiBTbyB3aGVuIGNtZHEgZHJpdmVyIGNhbGxzIHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBp
bg0KPiBjbWRxX21ib3hfc2VuZF9kYXRhKCksDQo+ID4gaXQgd2lsbCBnZXQgdGhpcyBCVUcgcmVw
b3J0Lg0KPiA+IA0KPiA+IDEuIENoYW5nZSBwbV9ydW50aW1lX2dldF9zeW5jKCkgdG8gcG1fcnVu
dGltZV9nZXQoKSB0byBhdm9pZCB1c2luZw0KPiBzbGVlcA0KPiA+ICAgIGluIGF0b21pYyBjb250
ZXh0Lg0KPiA+IDIuIE1vdmUgY2xrX2J1bGtfZW5hYmxlKCkgb3V0c2lkZSBjbWRxX3J1bnRpbWVf
cmVzdW1lKCkgdG8gZW5zdXJlDQo+IEdDRQ0KPiA+ICAgIGNsb2NrcyBhcmUgZW5hYmxlZCBiZWZv
cmUgY29uZmlndXJpbmcgR0NFIHJlZ2lzdGVyLg0KPiA+IDMuIEFkZCB1c2VkX2NvdW50IHRvIGF2
b2lkIGNtZHFfcnVudGltZV9zdXNwZW5kKCkgYmVpbmcgY2FsbGVkDQo+IGJlZm9yZQ0KPiA+ICAg
IGNhbGxpbmcgY21kcV9ydW50aW1lX3Jlc3VtZSgpLg0KPiA+IA0KPiA+IEZpeGVzOiA4YWZlODE2
YjBjOTkgKCJtYWlsYm94OiBtdGstY21kcS1tYWlsYm94OiBJbXBsZW1lbnQgUnVudGltZQ0KPiBQ
TSB3aXRoIGF1dG9zdXNwZW5kIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGph
c29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmMgfCAyNCArKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gYi9kcml2
ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gaW5kZXggMDMzYWZmMTFmODdjLi5i
NTBmNDJlNjlhYWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4g
PiBAQCAtODIsNiArODIsNyBAQCBzdHJ1Y3QgY21kcSB7DQo+ID4gIGNvbnN0IHN0cnVjdCBnY2Vf
cGxhdCpwZGF0YTsNCj4gPiAgc3RydWN0IGNtZHFfdGhyZWFkKnRocmVhZDsNCj4gPiAgc3RydWN0
IGNsa19idWxrX2RhdGFjbG9ja3NbQ01EUV9HQ0VfTlVNX01BWF07DQo+ID4gK2F0b21pY190dXNl
ZF9jb3VudDsNCj4gPiAgYm9vbHN1c3BlbmRlZDsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gQEAgLTMx
NywxNCArMzE4LDIxIEBAIHN0YXRpYyBpbnQgY21kcV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2
aWNlDQo+ICpkZXYpDQo+ID4gIHsNCj4gPiAgc3RydWN0IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gPiAgDQo+ID4gLXJldHVybiBjbGtfYnVsa19lbmFibGUoY21kcS0+cGRh
dGEtPmdjZV9udW0sIGNtZHEtPmNsb2Nrcyk7DQo+ID4gK2F0b21pY19pbmMoJmNtZHEtPnVzZWRf
Y291bnQpOw0KPiANCj4gRG8gbm90IGltcGxlbWVudCBvd24gcnVudGltZSBQTSBjb3VudGVyLi4u
DQo+IA0KPiA+ICtyZXR1cm4gMDsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIGludCBjbWRx
X3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiAgc3RydWN0
IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gPiAgDQo+ID4gK2lmIChhdG9t
aWNfcmVhZCgmY21kcS0+dXNlZF9jb3VudCkgPT0gMCkgew0KPiA+ICtkZXZfd2FybihkZXYsICIl
cyB3aGVuIHVzZWRfY291bnQgaXMgMCEiLCBfX2Z1bmNfXyk7DQo+ID4gK3JldHVybiAtRUlOVkFM
Ow0KPiA+ICt9DQo+ID4gKw0KPiA+ICBjbGtfYnVsa19kaXNhYmxlKGNtZHEtPnBkYXRhLT5nY2Vf
bnVtLCBjbWRxLT5jbG9ja3MpOw0KPiA+ICthdG9taWNfZGVjKCZjbWRxLT51c2VkX2NvdW50KTsN
Cj4gPiAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gQEAgLTM5Miw5ICs0MDAsOCBAQCBz
dGF0aWMgaW50IGNtZHFfbWJveF9zZW5kX2RhdGEoc3RydWN0IG1ib3hfY2hhbg0KPiAqY2hhbiwg
dm9pZCAqZGF0YSkNCj4gPiAgLyogQ2xpZW50IHNob3VsZCBub3QgZmx1c2ggbmV3IHRhc2tzIGlm
IHN1c3BlbmRlZC4gKi8NCj4gPiAgV0FSTl9PTihjbWRxLT5zdXNwZW5kZWQpOw0KPiA+ICANCj4g
PiAtcmV0ID0gcG1fcnVudGltZV9nZXRfc3luYyhjbWRxLT5tYm94LmRldik7DQo+ID4gLWlmIChy
ZXQgPCAwKQ0KPiA+IC1yZXR1cm4gcmV0Ow0KPiA+ICtXQVJOX09OKHBtX3J1bnRpbWVfZ2V0KGNt
ZHEtPm1ib3guZGV2KSA8IDApOw0KPiA+ICtXQVJOX09OKGNsa19idWxrX2VuYWJsZShjbWRxLT5w
ZGF0YS0+Z2NlX251bSwgY21kcS0+Y2xvY2tzKSk7DQo+IA0KPiBUaGF0J3MgYSBuby4uLiBGaXJz
dCwgeW91IHJlbW92ZSBlcnJvciBoYW5kbGluZy4gU2Vjb25kLCB5b3UgYWRkIFdBUk4NCj4gYW5k
IGNvZGUgc2hvdWxkIG5vdCBoYXZlIFdBUk5zIGZvciBlcnJvciBoYW5kbGluZy4NCg0KSXQgc2hv
dWxkIG5vdCB1c2UgV0FSTnMgaW5zdGVhZCBvZiBlcnJvciByZXR1cm4uIEknbGwgcmV2ZXJ0IHRo
aXMuDQoNCj4gDQo+IEFsbCB0aGlzIGxvb2tzIGxpa2UgdGVycmlibGUgaGFja3kgd29ya2Fyb3Vu
ZCBqdXN0IHRvIG1ha2Ugd2FybmluZyBnbw0KPiBhd2F5LCB3aXRob3V0IGFjdHVhbGx5IGFkZHJl
c3NpbmcgcmVhbCBwcm9ibGVtLg0KPiANCg0KSSB0aGluayBBbmdlbG8ncyBpZGVhIGlzIGZhciBi
ZXR0ZXIsIHNvIEknbGwgdHJ5IHRvIGltcGxlbWVudCB0aGUgUE0NCmZ1bmN0aW9uIGhvb2sgdG8g
YWNoaWV2ZSB0aGlzLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gQmVzdCByZWdhcmRz
LA0KPiBLcnp5c3p0b2YNCj4gDQo+IA0K

