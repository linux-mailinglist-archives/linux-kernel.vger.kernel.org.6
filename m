Return-Path: <linux-kernel+bounces-256466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4027F934EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476141C20F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5102A14037F;
	Thu, 18 Jul 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UwK20PqL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZiLFbxEd"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6735D80BFC
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311992; cv=fail; b=kSS7btkX40w9cQ5urmSt9ifnonIRZJNA4LrJooGeMSJryDWkIKZWnp2/q/xy+4m00higB1p9p2A6UDjVbZH3UpqoMkX9Tucg1E1eEKIn+r9AVw2LJWFrYlZbRGL6PxRrNEpjN2g5YPNYr00TJlhXVKYItkeSNpGteLZzUAn1R3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311992; c=relaxed/simple;
	bh=803KQ75gzLCR1oD5oDSrczNZkSZWLQOeUt9neSDUi7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pGo4X60t0V4oF7gGnyUQBC3AYORZMfTvp2fak2FgVH6BDf2ucC8VFrTYQUH5OsBj84GlH3/q262Ttwty3WZj3/OijvbMhK6iroglvvq0GotLyAYCk5P4wNKIAmvEQFd2ZZx81VI2haVlhARJ89Onvyz/qKlWGoVwZy2RJjlud9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UwK20PqL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ZiLFbxEd; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d7909b3e450f11efb5b96b43b535fdb4-20240718
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=803KQ75gzLCR1oD5oDSrczNZkSZWLQOeUt9neSDUi7w=;
	b=UwK20PqLkKejOgncRijQHH1js3T5X/wOPmnQPDuVgc83emDaSV5D+1CT5orfXOAEZ+GZzZBqLYgM8RXdcLk0AveRfS5oKQEPjKs2rKyT0vWh34ZE9Fl7OOdx2TenHSLapQSTg7OiSuZni59YDXUXuuohZRv/U0P8S5X4HZT722s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:4090c6af-b7c3-47c1-907f-04df8d9de89a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:76cd80d5-0d68-4615-a20f-01d7bd41f0bb,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d7909b3e450f11efb5b96b43b535fdb4-20240718
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1573059815; Thu, 18 Jul 2024 22:13:01 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 Jul 2024 22:13:01 +0800
Received: from SINPR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 Jul 2024 22:13:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nT/tyeSUFDB88i7KO67qclS2/cvE4w4xn5doAwSgkklCughzii0+G4zvEdlpqpvQr30Luchw7JQlSkpf+EUgG/5KZhP+ubx+emxCV3kwerINMI1lFQnl5Zv9wrM6qU2bjqR85ZuFSujprB4+ARbQdR9eyFM6fDhm7GiZP3G7es/L3l6bGiy+m3+YmKV90e6g2xX21Zy2k2ITepJrPnxdCBxzEBhbzJ/np+rP1HH5jw9zS0rLr6GrsVFIKQruivzttSQ/wyKhRej46UGGnZ0gVUMNV/j5sqIj9aJzDWYP2TsLkYE7MDQ6n0c7uBS5YP8uLLOi07PlSjTAln8BYHed3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=803KQ75gzLCR1oD5oDSrczNZkSZWLQOeUt9neSDUi7w=;
 b=rkfVrQ2q5iF2UwStTiKBj6oDNXKC3cfkVHwXfAlck87I7EHG3PZJebPJrJLLAJkaFJ2hqRRfLXWz+7/xBaWxleU+efyyCCxD2KbCvqGLNBkxAeNjcNvHiHt0S4sfEoXXTN5TSelZ7Jp0LBGdfd5MboFy5A3KeqmNQwzBgWM90iy+ZPwwb+8hU27p8rinvUyU4S3lgDIVhZdsSqYOaJTHwgWNpqBPxr4Tp+HzPSyz+wPBe3hyfSdsWF3BHkQwtL464ZjuDPeAERFo0/KAwbRx3tuBaGdJJxpmzCvmPTHv1II7JmK9ut9nuRxIEdPxnv7vFN02+meak606NFb+hUbXjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=803KQ75gzLCR1oD5oDSrczNZkSZWLQOeUt9neSDUi7w=;
 b=ZiLFbxEdJ01KbzQAgdb9Usb8FZqwTIdOinG9a7WYwztF3n61NKZd7laWMMuDdjtENNYrowm/cFdYsKhTaokfM4Ex4CfhAju9oFv7//iOu6lUu6MeZo8kilWOFe8fdP0j1dweNhwBWkjNALVTTjJlmVlYVv8yc79DGlULSUeMCgc=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEYPR03MB6698.apcprd03.prod.outlook.com (2603:1096:101:6b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 14:12:59 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::c6cc:cbf7:59cf:62b6%5]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 14:12:58 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	=?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jaswinder.singh@linaro.org"
	<jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2] mailbox: mtk-cmdq: Move
 devm_mbox_controller_register() after devm_pm_runtime_enable()
Thread-Topic: [PATCH v2] mailbox: mtk-cmdq: Move
 devm_mbox_controller_register() after devm_pm_runtime_enable()
Thread-Index: AQHa2O4P+UqPHmPxU06DeYgigbAf5rH8Q02AgABEBIA=
Date: Thu, 18 Jul 2024 14:12:58 +0000
Message-ID: <64f73196293dd86ce2f838b4d76616bcda14bd0e.camel@mediatek.com>
References: <20240718-mtk-cmdq-fixup-v2-1-f6bb3c052a60@mediatek.com>
	 <8fbe44af-8da3-4554-ac2b-5db58003449e@collabora.com>
In-Reply-To: <8fbe44af-8da3-4554-ac2b-5db58003449e@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEYPR03MB6698:EE_
x-ms-office365-filtering-correlation-id: ce118ca7-ab7b-4483-7e81-08dca733ba16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WmZ2TFFldGw1LytUQnY1ZXByeGUrY3NRTFZsdkM1ODk0Z2p0andoRXc3OEJK?=
 =?utf-8?B?RG5MK2M0dWM5WDZ1U24rVTEzMmNyd2luSDVlVUF5SDl3MVJTclRNSmVKVkl1?=
 =?utf-8?B?VFNIT3JDeWR5UUNidC9McnVDTkhKUHVqMlZVL2p6cXo4dGpzb2lycGlZNm4v?=
 =?utf-8?B?R2VxcVY2SUt1dHExMk5EMlVNU0ozdDNReTFLQU5walFYaXkydGY4Wlc5OUNP?=
 =?utf-8?B?eUVMRnJMV1N2TFBsOEY5bUJWRTU0WEZFYVArZEsrdHk3TXFCUG1JN1ViNzlT?=
 =?utf-8?B?RTJXYkwvUlcyKzRaSyt0Z2Z2VFU5SjhCcXNNUnlZS1hNZEFvaENLNXptSmQ2?=
 =?utf-8?B?M0UzQXZtYnpscjMvb1BoRnZlUzdhVno2S3hXVXE3S0RqNkdKbkZ4c2RFd21K?=
 =?utf-8?B?TjVlYkpqK0s0ZDE0ZWxteFN1VHQzN21MZUJBem1UdHFJbHNuQzJ2azQvTldr?=
 =?utf-8?B?SzBmQjUwVktFcFk5U09RWkxqaGo2cEhNcHlhSUdsd2JjWm1lQlRJUUwyUVhu?=
 =?utf-8?B?dEVneGpWYk13NXd2MVIzNk1uZWFBRDZEUzE1a3hHU08xci9vbHlTSnB6M2ov?=
 =?utf-8?B?d3h2VEdGbmpGRW9TVnJ3dGxDWTZXNGdRVXdOQjd2d2FKcC9Td1ZwazFaZk93?=
 =?utf-8?B?Q2dkdC83czUrOUk4WExnSkFlbjNNZ0Z3YnVDU0lQTTh2SWNKOG9IZEpURTN1?=
 =?utf-8?B?Ky9pWkN6RDRtZFlsZkFGNi81MERqZE1XM09UVG1sbG9yU1lvN2Nscnk2NVdj?=
 =?utf-8?B?NzJqVTlwcktwWHZLeEFON3BaYzRXdEJkYUVBbytXcDA4QXBPQU42Q3VQWjNr?=
 =?utf-8?B?c0FVZnIzK1NGZzNQak5mb3NnL3dKdWl2ZjNSUmFmbzdCbCsxRGtpcDZERXQr?=
 =?utf-8?B?WXFoNDgyUC9yK1hyQWNTUnNERUtBQlFxN0xnZFZXZnUreG5oeEVQd29jeFNq?=
 =?utf-8?B?NFZNZlJzdGpveVRtTXpLWUhta29UTWVRQnk1Z1NtejNvZE5HSlJzelpSSi9u?=
 =?utf-8?B?RmlhQkJGMUlNNk9IWGQ2SU5SdlFVNnpaVnFkQlVnR1pXcksvMWQ4OWVKaUMx?=
 =?utf-8?B?RWdnYnNhbjltSUxBOUlUNFF6ZUNmRlNlUGtXVVh2STI1RTA4N1BaeWQxR3Jh?=
 =?utf-8?B?RnJHSnQxbHJVclhvVzIyUFN2bi9id3hKNGoxK3NoWWswa1hCSmZrT0pYUnZP?=
 =?utf-8?B?c3JmLzVsLzlQb3QzdDRHc2tndUFWWmN4emIrVnI4VWpRbEtOWjVkTitBbEwx?=
 =?utf-8?B?M0NFNlNHRHJTWmlISlduODZCUDZ1eHduVy9aaXZLVUFUMnRvVit2eEVGMWF6?=
 =?utf-8?B?USszRGJiWTRnK2NPTVV5LzkxcC9JTVlyTWVTTzNtWU5ic0NpSHB0b1FobTdQ?=
 =?utf-8?B?blc3bHdDS2t0Q1lmK0hUYlk5MWdFa1dtWHlSSjJ1QjZQRFdpSmlaZVNOb1ls?=
 =?utf-8?B?bGlNcGhIZUxLS2JEeW53RThmT3FXUURvMHl3anIrbFVoSFBpU0p4N1hrWE8v?=
 =?utf-8?B?eksyR2VSdjRnenFVNkQrbDl6ajV4eGpldmVzUXJMZE9iRFVHSHo3cXd1dWwr?=
 =?utf-8?B?cVVadjJFeUlJdzRPdHhyNVFKTHh1MEo1WUV5SlNBWHc3Vm4wTXE3dDF4eHNT?=
 =?utf-8?B?VWp2QUt4WWVUZzlpbEw3QjFIcmdnQ2JsZDRWUVMybWVrcDRrd29XTWg4UnBL?=
 =?utf-8?B?cFk5VUduVnFKalZWUERJN3I5SXVOSlE1Z3BRQnZBTzBwK3NueDQzWUdkL05o?=
 =?utf-8?B?U2dlSVgrVWsrV28wVk1mdWtBd1pPcGdGck90OWZPVDQ4TTN6UTJjWWZqMGpQ?=
 =?utf-8?B?Q2ZHMExHcmFPRHJMNWVuVjRFOGNHNGxMNEQ4dngxUXhBR0RmL1JSZDZWMGVs?=
 =?utf-8?B?SWVWQ1pvVTFRRGhuYmJGNGhDdnpyL3JqL21JVStNeTNsSGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmNHSVYzaEFJY0M4SjFwdE00UU5xQVRmM1E4cDFVS1BtVXlwTVl1dTZXNExm?=
 =?utf-8?B?eGdJN1BlRzBnWE52WEZXdG9rcTZlRWIra2dwd1Q4Mm5LdkRVOHF4QmpnMHFW?=
 =?utf-8?B?dDROeFlWS3RxYkkrbzhQZVhxcXJHZC85UjJLdUJFcmJ4TS9aWXR5WWsvYW5M?=
 =?utf-8?B?V1dMWnhjVXZUU2tVRnY1SzQ2aVM3MWRTekpBbWk5a2pDWkJwSGxqNU1UT1RU?=
 =?utf-8?B?QkhpeS9iTElQQVhCVUZaTU9YenFBTHp2SUMrWXlqMVhZRjNaQmVCWHBKZHZW?=
 =?utf-8?B?ei9GdEI5REFXeVhCalBMUytNWkdReGVxMGVCZ3JBemtIRCtER3V0V0hmNWJQ?=
 =?utf-8?B?eWp1SHF3aUo1QVAzUWR5WkJNV3d5MjRxYktsVDJVUmh6UmlMK0JYME1VV3Fo?=
 =?utf-8?B?b3FSQk1tUUJNbFhyTU5zMTlMN3BpQnRFYWhsU3g3OU1LUUZ6dzBNU0ZJWC9y?=
 =?utf-8?B?VzhId0IxN2w1S1BCaFpJRStZN1RVVmF5Y3RFN1pYbU5aZHpkNTF6QkNtUFhE?=
 =?utf-8?B?cDNTeFZXNU5naWdtb1FPZmZHZ1AxamM5UHZLV3Z5TmQvbzluV3dKL29hM0U1?=
 =?utf-8?B?Tm1EZlE5SFN3L3MzWmxyWTQ3UFRCd0Mwblc5YWVxWndRRUlaL1ppeFNDNTBQ?=
 =?utf-8?B?VEMvYTcvUXZqeTcyOTlRUmhnY2tZWUxLYmM3VlJkcTRTbzh1SlZNWjAxekhD?=
 =?utf-8?B?YlhFVUQwUmcyNU1yeWxVQU1seWRibXhvdGg2VElkMVJ5aU5Wd3ZaWStPT3hG?=
 =?utf-8?B?N1J4emkrVy9LbUlzNmszR0pCZUFGaVlJMjQvdk1TaUYyZWlhdFhtWDlGUEYy?=
 =?utf-8?B?a1FoODNEWENUc0F0SkJBSDY0d2tEVzRpUkozNkFuYnd3T3llaFJDRFZvR0s5?=
 =?utf-8?B?YjNoa2NLZzU3MTR6YVFtSW9pMm1lVHlCWkdEbXFFRloxaEZrQmlrZDJ4cXFB?=
 =?utf-8?B?MVZ3L21mZy9SRFVVUWZNU2o5emRkeUl6aXBuWUxxTkJLajVlcks5czhENkhI?=
 =?utf-8?B?SW5VdGl3dWNaY1E1bXJWNzN6cDc5aEhrbEcvZFc1alpQRU02ZkJEdUw3RldM?=
 =?utf-8?B?UjFMRERLc2lxTk0vKzJHZTNkRVVPTUxaOG9LVUNGK2gyaUlXTGdMRnEzWURo?=
 =?utf-8?B?cTNLMXN4MjY4Uk1YcGFkTFpvRW1kWlBMNTQxSk5pK00wd3RzTmY3SVJ2TVM0?=
 =?utf-8?B?dnQrMXhZUnpUaUFnYVZLWFpCTVMyUjVlK1U3NmhWWXduSlRaU2xSNGhDbHRW?=
 =?utf-8?B?eExLTW5Oa1k5K1FNNDlxMlJaNUhWZ0ZUNEY5L29JeVlEeExKU0ZkZ3g3Vkxp?=
 =?utf-8?B?RGUzWWFhK1NZWmZ1MEtuSHVjOVhubEp6OHk5YlFWSXV6ODE5MGM1V04xMm9q?=
 =?utf-8?B?alB3L28wL3VwTVJBWlI2SVlQdGRwZ1lKYU15U2Fra0swLzJ6bDIreFVSWGFp?=
 =?utf-8?B?UWFQUk50MFlsNWM5MXpPbE5UQ1Vyd2NyVlNCdGJScG1tV3JQakR6RTFFVE9E?=
 =?utf-8?B?emtMNFVjYU5FcmFFcDhERGVjbGpyR2EvelpXSVRoREVWWmI3SUROWkdwNk1h?=
 =?utf-8?B?ZHZTLzRuU25JUHJpQXRiTU1ISVFwSGQzNVdyUmk5ektDTjF0dW5WNWI0d2ln?=
 =?utf-8?B?NEZKd0M5TFdwQXJaakwvN0JrdzRVNWgzajFZK3lwUmM3eTRjdy9rMWlSTkRT?=
 =?utf-8?B?eFNBaC83S3pCdkFGTzZYNitEa0ZpWjlqck54RjYyZGVrTk5MdEN1UWRLSWdl?=
 =?utf-8?B?RS9FVnFudit0UWhGMHJadlI1YjJzTWdDRmxRdjhoSmIxcjl4OG1PNmp5NVd2?=
 =?utf-8?B?Slc3ZFdjd1VNQjFrZVpPSzA4NTZNTmgwK1pLQ0FrcjZDZW05Q1ZGaXhRODlY?=
 =?utf-8?B?a3M2Q2FzcVk0dUg5VndvQ09HaGZlMXptejRYSVhCZnpmWWloUzNxV3VUZVZJ?=
 =?utf-8?B?QkVaNTRkcDFMd1oySTdKU0dVUEZqS2xOZmRpdkpVSzBuNWxPNWthZVNoN2M0?=
 =?utf-8?B?V0x4UVMrL3kyZHF2SmhPNEwvaVlCb1NiZGR1ZkdISEo1bkxpQ0hHVjRadkVR?=
 =?utf-8?B?Nm5WcjVwNXJSQmdoNE5jNExiVXRGSndxZFRzS1oyWUdBd2RubDVGVXBPbHl2?=
 =?utf-8?B?aU5KWVZhcFpRdnhUREZ3cnBxUGZpZ3ovQmpLK0RzWWVuUG5NMGRzVFdEMDVv?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4D4A6B7B9190B48BF8AAA17818DD1DA@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce118ca7-ab7b-4483-7e81-08dca733ba16
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 14:12:58.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98NZFgKxfe0nHsfDajqSZm1ZVGKcxMWfH7FllMfnHE3mg4dqp1CeGOyz4W+Z+XkuHAA2M+APRY676525z+BkgUzuxlKDs57GHMGtK4AgpG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6698

SGkgQW5nZWxvLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXdzLg0KDQpbc25pcF0NCj4gPiAtLS0N
Cj4gPiAgIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAxNCArKysrKysrKy0t
LS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KPiA+IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IGluZGV4
IGYxZGZjZTllMjdmNS4uMDAyMDAzYzM5NzBhIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gPiArKysgYi9kcml2ZXJzL21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5jDQo+ID4gQEAgLTM3MCw2ICszNzAsOCBAQCBzdGF0aWMgdm9pZCBjbWRxX3Jl
bW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+ID4gICB7DQo+ID4gICAJ
c3RydWN0IGNtZHEgKmNtZHEgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiAgIA0K
PiA+ICsJZGV2bV9tYm94X2NvbnRyb2xsZXJfdW5yZWdpc3RlcigmcGRldi0+ZGV2LCAmY21kcS0+
bWJveCk7DQo+IA0KPiAuLi5pZiB5b3UgbW92ZWQgZGV2bV9tYm94X2NvbnRyb2xsZXJfcmVnaXN0
ZXIoKSBhZnRlcg0KPiBkZXZtX3BtX3J1bnRpbWVfZW5hYmxlKCksDQo+IHRoaXMgbWVhbnMgdGhh
dCB0aGUgdGVhcmRvd24gc2VxdWVuY2Ugd2lsbCBkaXNhYmxlIHBtIHJ1bnRpbWUgYWZ0ZXINCj4g
dW5yZWdpc3RlcmluZw0KPiB0aGUgbWJveCBjb250cm9sbGVyLCBzbyB3aHkgZG8geW91IG5lZWQg
dG8gY2FsbA0KPiBkZXZtX21ib3hfY29udHJvbGxlcl91bnJlZ2lzdGVyKCkNCj4gbWFudWFsbHkg
aGVyZT8NCj4gDQoNClNpbmNlIHRoaXMgaXMgdGhlIGZpcnN0IHRpbWUgSSB1c2UgYjQgLS1tYW51
bC1yZXJlbGwgdG8gdGhlIHYxIHBhdGgsIEkNCmZvcmdvdCB0byByZW1vdmUgdGhlIGNoYW5nZSBp
biB2MS4NCg0KSSdsbCByZW1vdmUgdGhpcyBhbmQgc2VuZCB2MyBzb29uLg0KDQpSZWdhcmRzLA0K
SmFzb24tSkguTGluDQoNCg0KPiBDaGVlcnMsDQo+IEFuZ2Vsbw0K

