Return-Path: <linux-kernel+bounces-525258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E857BA3ED2E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F69317FF91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 07:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C81FF1AB;
	Fri, 21 Feb 2025 07:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KbW4eVyJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="D3DgDpn6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545512AE86;
	Fri, 21 Feb 2025 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740122327; cv=fail; b=IMBrMUb8/DPKKTmK8iAouE+lE35bAeLM56a78k7e2iKcUgwR+yXfUdCNbGgW65iD82n1J2/bn4Q6ovid9EFSQkhkWqaldjVyOO4EcWIGjsv+SQO6i22cxkqRXnZAVxPoXws0xrAFHTG2pdi0n8q6Vt3tidx5O7xU4rl1Lr+iBac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740122327; c=relaxed/simple;
	bh=MsjfyZGVrzHT0auF23yNKkH3xd03CptLmoxQvdpIaHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k34QzKPDJOkva87aUbTvjiorimIhJCF6ejcWfRPvFv59QlsHzJcrA9xq3KOXIHHtmZpdXhiAsIeXv8TEQx9Ei999uuV6CuhEuvsTM11lnwNZsxzVMzcQxSUWyehI9FgPm/hb0dnKLMZoiSF3PTuAUuzBdCBpafjerL8o0BBUenY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KbW4eVyJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=D3DgDpn6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 10b19d4af02411ef8eb9c36241bbb6fb-20250221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MsjfyZGVrzHT0auF23yNKkH3xd03CptLmoxQvdpIaHE=;
	b=KbW4eVyJ1A7AEPm2j20/Lhbwp7WkJBgIKsnokS5Hpnayom+CSBL/jrLVybjfbfDxHPgrPPQBKuOCaHXlko7z0+6ggjAUpBm7yu14R4VE5Oe4oj2OZfedZY3GJfqD1A0cqxTJuoMrhZeIoo2yPvb6gmJ1i/duicsbd9D+y4VpD6A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:4489d8af-440b-457a-b6b1-eb229bab7f5b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:53aa29dc-d480-4873-806f-0f365159227b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 10b19d4af02411ef8eb9c36241bbb6fb-20250221
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 831970087; Fri, 21 Feb 2025 15:18:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 21 Feb 2025 15:18:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 21 Feb 2025 15:18:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bii5aJprlH7KD/3Aw2fJgtpEPTVm1LnRNZlrQ1fZcDVYVpQlvvkTziTrgH2ZbcrTq9Jb7XbCHNSqZBnBkg/e696YtSGRYjDN5ByYPYfyaWMwVGmgbbGmUsFNw/mJt8W/MFRBywM5SAv9h/QPSo3fZL0xDn1cLtzS13t3dK9hSQu68VniWvWqLDwFnYTPwdfnU3PwDQHr8TgtSJDvI9hZBGVmuRJ606kN4FYWAPkFIgHz1xUWgX42HkHDWySTKV/7DRphhj/7oT25Q/23awe5sNTyKIXO1D42cbHUGL3tNx6r9+LK98flYmL6GjbdFYzeWYjkXEiljujFBarB4amd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsjfyZGVrzHT0auF23yNKkH3xd03CptLmoxQvdpIaHE=;
 b=W/rRoV/2nQS612oyPO+8/I1nqjip+mQGoY5Zc/iQvBFgZ+hNfavSa1vkroC3XPxixcUoCHAWkHO+1z3MbIle2TrIYwI//oF4LnzDyylue3Yr9xu0PBSWR8nNyDGPOkB7SzI3EuHd4zzWSkcM/cabXatFJkaiI4dh3NdFStvKKwcYes5bquyQlJJu/G5QZuQi+ln7B9XYSVfD6sJQWmUy1gPhS5h83I70QI8U7adP6xo1oR16ktQymaHWfsK09zwP8ea7OlsGcUgDfZKbd2g5vY0p30fp49IibaVr/8ZNz8y9S1FQ3Z4h0uELcZkp3fA0MS27YPioRQEpJ7XDe/AcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsjfyZGVrzHT0auF23yNKkH3xd03CptLmoxQvdpIaHE=;
 b=D3DgDpn6VciL8rTdJVRgAd8l6vTlwIs5XOSFZuSmRqaQ2kRzagyH0KNZfjtYjUqeUZnBDYIu2Pm20GgR/tm9WbbpBlsU9ScPpfi7Esbu4rxyn9bzD/pSQjGAvEWduNyJZgjSI3tvmHSxQzlEs9pWn5aFUdfoktl+RtVrkely47g=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB7755.apcprd03.prod.outlook.com (2603:1096:101:132::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 07:18:32 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 07:18:31 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
	=?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
	<Chris-qj.Chen@mediatek.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, Alexandre Mergnat <amergnat@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"macpaul@gmail.com" <macpaul@gmail.com>,
	=?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, =?utf-8?B?U2VuIENodSAo5YKo5qOuKQ==?=
	<Sen.Chu@mediatek.com>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error for
 audio-codec
Thread-Topic: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error
 for audio-codec
Thread-Index: AQHbgTCAU9jXVAXo60G/+cGvIMG4kLNNy+IAgAOTW4A=
Date: Fri, 21 Feb 2025 07:18:31 +0000
Message-ID: <7f9ddfe089a13dd70ae99cf292d00d689ae2f2fb.camel@mediatek.com>
References: <20250217113736.1867808-1-macpaul.lin@mediatek.com>
	 <173992516365.2065360.13568840928707086513.robh@kernel.org>
In-Reply-To: <173992516365.2065360.13568840928707086513.robh@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB7755:EE_
x-ms-office365-filtering-correlation-id: 055af775-78ed-482a-7b22-08dd5247f25c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aWI1Um5RZXRpWlR3NW9jTFAyMlR1T0JEb05NM3pZNW9qeUpYUUxRUWFmK1Z3?=
 =?utf-8?B?b0d0ZjRiZHVBOVF4MHZBNU5zc0IzSjRQSDhIK3pEaGVzQ0R2V2RuN0Qxd1Nv?=
 =?utf-8?B?U3l5dWt4RTMxbklWK3BiU1FSR2dnU00vSVAxUGN0OExkWi9nVEc3MlprWVFQ?=
 =?utf-8?B?eVg3ZG1KS2JpbkRHWG14ZzUvMWxpUlJvcVZ0YktvdjdPSTRhK1ZrajFEVy9I?=
 =?utf-8?B?MlRnaEl3RTBJMDBSK0d5Qm5nN0FmeFAxMFgzQ084SnViZGZpVlBDbzRYM0RM?=
 =?utf-8?B?NWZFZDM4aXBEZ2NLQ0hUZU10cmgxSFRDQ1V6V2o5dFViUitiUWZwdVlXUVY3?=
 =?utf-8?B?Lys4L2REVVdjRnRsMXpZQnVhRWIzL1RBbHZvanA5NVVPUUt2VThCSm16YXRv?=
 =?utf-8?B?Q2RsaS91MmZuWmY4ekZJck5pbkdhVWxObjZsRWJMUWs0R2Z0SXdKdmZiZzM4?=
 =?utf-8?B?MG9SMlpXaEo4T1l1eVBiVUdmSllVY3A1aVVkT0pTODcxNjdVSDY1Z0Jhd1Q2?=
 =?utf-8?B?eVhPdkw3K0xFeXNzejQ5aXZ3aHFiYkV1UmVNSS9aeURzMWMycVY0cEtuMVNS?=
 =?utf-8?B?dVRDRDFSaUJkUzJhcVJMMmo2QUtDU2MrTDA4dUJtb3VyNkVLKzg4ZVVKQ1J2?=
 =?utf-8?B?QkJKYmdFRGJpcXBFazU2KzhsL1pvd3FieHUzM1pDUGt1NHMxZDlLUThJM0FH?=
 =?utf-8?B?anR0RmxqMXpoRk0wenhnWTFkRmlNZ1djbEpqSWdDZDZuZFdDaFd2ZXdFejZ0?=
 =?utf-8?B?dEVDR1hlM0pGMjNpRURuUEY2c1ZQbmIxMXZPQU0weS9nUTl2SVVlMzVlWTVM?=
 =?utf-8?B?ZFdubFFNVlhEcGhRYkE0MlN2TnE2S3A0YXJ3WkhrY1ZZU2tUWWNBRGlKQmll?=
 =?utf-8?B?WHhRdll4cUhxemp0b2d2b2FLcHNGV0xkL1lhWEtla24rOVBONmFmRm1GcWw2?=
 =?utf-8?B?QzR3ZFJEN2t5VC9uN2kwK2UzUkRmdngzZHJ2TW9oc0p0ZUR1Rm5sL29wS1Z0?=
 =?utf-8?B?QnFoZERKNmpzVFlsejB1cWRKRzZoMmY0SmE3ZHk4Ykdzc2tReEM2ZlpSbzhy?=
 =?utf-8?B?SExBZUF3ZVpUT1p4Mi8vREgwcHZlN2tDUDk0NFJLTzdFazNXUVZoeENYQmlZ?=
 =?utf-8?B?QkJZZUovY2ltWStuckExTW94NlNIeUdpN2JsU3FIOWcxUnlWKysvSFhCc0lH?=
 =?utf-8?B?ZHFpN09HYzlmbmxGbkFRSFBza2lWTld0V3BlaTF0WXJ6UDdka2VuM3czZU44?=
 =?utf-8?B?QXpPVDUzL1BVcEFWZ2tkSnE5QWtxcmRsL0htM2hVMjk2N2Z6Yk45dkdZU3hB?=
 =?utf-8?B?ZTNVRmRtQlZSMXVzRWwwZnpCSnQydFFEMEFmOEtKQTJuaGRVS2tRQloweWZ5?=
 =?utf-8?B?MHdJeFVhNCtzUW9sY0c4WUpHME54UmRzWGhQTWpOM1NrMXhmank4ZVl4Zkhz?=
 =?utf-8?B?aGFvSTk4Y2xvVEE4Ui9SQTdmSlJob0s0V2FVbktrak9nSmJaa0xRSUFRdWEv?=
 =?utf-8?B?ZWg0NWk4Z0VSd1grcWVkak90N3lwa1VZYi9XYTJPL1pQa2c1enF0dFpOVlUz?=
 =?utf-8?B?VEwwaVpBZE83YjdKaUxKeUNzYUVDaGtpcktVcVNSMzBHSnJlUWxhT2RITkgr?=
 =?utf-8?B?OWNkYnhNbGxYTC8xS0I1SUdHN25hMk1qNzU3OEd5RC90Q0s5bTJkbFIxQmJE?=
 =?utf-8?B?cmdlTmFBbW5LbkFSRnRmWFBocUFDcERLR0thTTBLUGs1RXR2dFhYeXFXOWNI?=
 =?utf-8?B?dmVWbVZtY1NKLzBBdGNReWt3ejUvZGVvWlE1MGhMMDB1MXA2SHNZQ0dOeFVm?=
 =?utf-8?B?U2RqcEpKN1NLUE1KOEpsRGE1QU1Nc3FVRksrd1FoTVplNWIrSk5LS3FVL0tN?=
 =?utf-8?B?UWM1WC9TeGdjTmVCNEFZQ2dEcUh6TEFJYXpRMWkzKzdvU2tDbDJUUjRpN2VE?=
 =?utf-8?Q?J/EggNBRnYB4OP+zyikEiJpQUsRJW1YB?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7810.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjNlS2Jncnh0TGZrVlNsSjIvYTQ1VXNqcW9IdzY1bGF1V3Y1eFpDKzlzUWhn?=
 =?utf-8?B?cDBzaEV3dzNUeHpoaVQ3czRLbGtXM0QyRFdOUGlFUEhqdERIWk5NTHdCUGxk?=
 =?utf-8?B?eUxCSlU5RE1nd0xKY0pCRFFwVE1JaW9od01wb3M1TmdBQ2s2bzNkOTROMjdy?=
 =?utf-8?B?S1kxbUJzbHFaeTdEUnFMMmZqbXptZ1FTelBVNzBZUFI2Tkk1cEVDbW44K0Jx?=
 =?utf-8?B?TUJwSXJMWDhycTkzaGhTSGIxME5ZQ0lNVEdSY243bjFrNzdTcHdlY1FHRC9m?=
 =?utf-8?B?YVFHWFJiOTFmUVRqRmg2L2RiL1BHS2FDTWhrVjEzdjY0SDIrNXVWdTgyNW1V?=
 =?utf-8?B?SEVnZGw4b3o5Q2JkY2N3bDFkMzlRc3Uya1h0Rm44dkk0b3VsUEdXVkdiMmRD?=
 =?utf-8?B?amlselNtNWxsclk5dVdzSlhOb0JLNDlEV3kvcUFZTTdEV05CTXZLS3hXSEQ3?=
 =?utf-8?B?eVl4MVdVc1lrb0hKSUZYN2k3eXBKNERyNlB4T3JQT002Q2tGVmFCWDNXS1Mw?=
 =?utf-8?B?T01JTllQRENBc0IwaXRzNHdaUEo0T3ZYMCt0QXh4QXdCaXBKbG43blZ3WXZH?=
 =?utf-8?B?ZCtGRVBmWEVrNXY3VERucFBVOGNFaHFBcDc2R09Yd2lodlQvWDNNenpUbjIv?=
 =?utf-8?B?VHBrQ3c3ZDcvNVNUdDdqTDdvTG05WUFxRkJFekpqUkRaQ2NKSVRxeHJYNG0z?=
 =?utf-8?B?d0J5cGorT2Q1RXhVRXpsd1FjOFN0TGtjbmFsRUtzM1hEcU5DcDVUODV0ZXl1?=
 =?utf-8?B?VkVReWJzUDdseDhFcFZCUDY4YzNWam1vcmJ5Mm1PTW1yV1Y4eEpSTm1vbENB?=
 =?utf-8?B?RzBlbTN3R29iRUFta01mMG10WDh2aVVSQ2x3T0k2QjZ1RkdiV1JocUQ5U3RW?=
 =?utf-8?B?MStGVjBCbjR1WjBwRk1MUW9GVE9UYmlGamJXZk14ck4wMmZQU01GOHFJYnNE?=
 =?utf-8?B?ellzK0tjblJ3eDdnKzFqWVErWU9HTXd3d1Vvck9nM1l2Ri81MEl5WUlLbW5i?=
 =?utf-8?B?N3lBTmdkbC9JUXgvdHVUTUhhcXVtdlJWUkJNYU5ZcGVBdXhuMTBUVWllUVVW?=
 =?utf-8?B?ZFFlcUxkdFdQVHRGZ1BjRHRCbm1hYkJXTWpFampzME1QUGttbFczb1ZyOTQy?=
 =?utf-8?B?VlRWdEhmalFSUkdJTVB2VnFFV0dFR205T0xudndsc0xxYjRtMnhqZktKM0ZG?=
 =?utf-8?B?VlJyYmk4M0laWFNDcDVwU3kxZWF6V2JpNmRRMXh3OUN6T0ptaUF4Z2VrNVVq?=
 =?utf-8?B?S01LMlRhY29QU0pSR0diaGRub1JqWVRRejRVTDBXanlLZ21DQWxWQUpZN2ts?=
 =?utf-8?B?ZE1ZUWl5YUFGbHhnYTJOblNzT1NmVVdEaERTZFZlclZZd0crNCtQYjE5emNW?=
 =?utf-8?B?cHA2dXRvaWJNdXFXVXI4VUdQTFJlQXhpZXJCdWljaWV6OEVBMTF0SHp6Uktm?=
 =?utf-8?B?NUNvRU95NVlubUovYzJxQkFYTTN1T0IxeVVGQTdONFE3UTJGWUNpTUlVdnFj?=
 =?utf-8?B?TldFMjNYd3gvNmdJUkdhbU5CaHZhbXhteTdiZzk2cG53dXlPaXBUK1lhQzMz?=
 =?utf-8?B?TU8xZkpBamtIUFVLTEFWUUJnME1QLzBZcFBHZG50SkRtSlRWZG9ya0pSQVQv?=
 =?utf-8?B?emZldXpaTnozNmxLK3IxWkdrOU9WWWJYMGk1ZDJHaGpwT2tJdUhETXA5TkZr?=
 =?utf-8?B?aytkTmEvdzVnOFNMVzM2SEpueHB1bVdMUEg0SXFkQWVxQ3Y0ZXlDRDliQkZL?=
 =?utf-8?B?aitxR3BmcnRUWFVNU25yQVRORXJpUmxPU2xtSjFzYkxVVVpJbk10andqcWEr?=
 =?utf-8?B?TjhEdk1pRkdOdktqckpCbHpnRndTc0h1czNwTW4xZFprL3hTenk5dDZDTnN5?=
 =?utf-8?B?ZXpWZFZnaTNtdW1oMGQ2RlZGNmt5c25DelJFZFN0dkdCaGluc1puL2wxL0RZ?=
 =?utf-8?B?cjJUMU8yeGx4bGNiTXRYbXh3VVN5cVY3Q3M0M2xRRTRZNkUvaXhpTUM0Z2dh?=
 =?utf-8?B?Y2oyVVZHKzc0emdVTEN6MEZQSmZUU2s2SGJjVnh6bFBSR1BUZDg5RzY4dW5o?=
 =?utf-8?B?aUFGM3dONTN6Y242WUprS0QwU01sTk9FcnhqUGVKRWpmY0V3WndoUVRlbTJB?=
 =?utf-8?B?Q3lnNHNDUE1VV2swemdxbEN4a08waExQT1YybU1pd2luVUFmNFFVTzE0QXR4?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1C92C4B09DCDC48BD329B9B40287FBB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055af775-78ed-482a-7b22-08dd5247f25c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 07:18:31.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I4zgdDTqfFNNXNnpj5SftsU+V6eR4XE49ywHwAfkQal4jVwJHl7xI+gJe2v5aKYA+jBUinf4OG3iOXiWm9KfV9Iput6fLOuYnmkR80oYkLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7755

T24gVHVlLCAyMDI1LTAyLTE4IGF0IDE4OjQyIC0wNjAwLCBSb2IgSGVycmluZyAoQXJtKSB3cm90
ZToNCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gT24gTW9uLCAxNyBGZWIgMjAyNSAxOTozNzozNiArMDgw
MCwgTWFjcGF1bCBMaW4gd3JvdGU6DQo+ID4gVGhpcyBjaGFuZ2UgZml4ZXMgdGhlc2UgZHRic19j
aGVjayBlcnJvcnMgZm9yIGF1ZGlvLWNvZGVjOg0KPiA+IDEuIHBtaWM6ICdtdDYzNTljb2RlYycg
ZG9lcyBub3QgbWF0Y2ggYW55IG9mIHRoZSByZWdleGVzOiAncGluY3RybC0NCj4gPiBbMC05XSsn
DQo+ID4gwqAtIFJlcGxhY2UgZGV2aWNlIG5vZGUgbmFtZSB0byBnZW5lcmljICdhdWRpby1jb2Rl
YycNCj4gPiAyLiBwbWljOiByZWd1bGF0b3JzOiAnY29tcGF0aWJsZScgaXMgYSByZXF1aXJlZCBw
cm9wZXJ0eQ0KPiA+IMKgLSBBZGQgJ21lZGlhdGVrLG10NjM1OS1jb2RlYycgdG8gY29tcGF0aWJs
ZS4NCj4gPiANCg0KW3NuaXBdDQoNCg0KPiBNeSBib3QgZm91bmQgbmV3IERUQiB3YXJuaW5ncyBv
biB0aGUgLmR0cyBmaWxlcyBhZGRlZCBvciBjaGFuZ2VkIGluDQo+IHRoaXMNCj4gc2VyaWVzLg0K
DQpEZWFyIEFuZ2VsbywNCg0KUGxlYXNlIGhlbHAgdG8gcmV2aWV3IGFuZCBwaWNrLXVwIHRoaXMg
cGF0Y2ggdG8gZml4IGR0YnMgY2hlY2sgZXJyb3INCmZvciAnbXQ2MzU5cnRjJy4NCg0KW1BBVENI
IHYzXSBhcm02NDogZHRzOiBtZWRpYXRlazogbXQ2MzU5OiBmaXggZHRic19jaGVjayBlcnJvciBm
b3IgUlRDDQphbmQgcmVndWxhdG9ycw0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUw
MjE0MDg0OTU0LjExODE0MzUtMS1tYWNwYXVsLmxpbkBtZWRpYXRlay5jb20vDQoNClRoYW5rcyEN
Cg0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS1jaGVycnktdG9tYXRvLXIy
LmR0YjogcG1pYzoNCj4gJyNzb3VuZC1kYWktY2VsbHMnLCAnbXQ2MzU5cnRjJyBkbyBub3QgbWF0
Y2ggYW55IG9mIHRoZSByZWdleGVzOg0KPiAncGluY3RybC1bMC05XSsnDQo+IMKgwqDCoMKgwqDC
oMKgIGZyb20gc2NoZW1hICRpZDogDQoNCkJlc3QgcmVnYXJkcywNCk1hY3BhdWwgTGluDQo=

