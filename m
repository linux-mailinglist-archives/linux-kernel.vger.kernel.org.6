Return-Path: <linux-kernel+bounces-553983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618E1A59185
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87EE13ACB61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B144225791;
	Mon, 10 Mar 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C6RUN3rV";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TXlg2y2H"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2CA226D0F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603519; cv=fail; b=OkCL8t4qXNQKYt7hN8aFCBMHqaJv2P9TKURZHeG/cBV7ZlEj1WEbU7gh7eQLA7hsZUuO2+6JFrydflJYP3JcOfVRpVV8TCWThfkZVQUFItnsPfxjQJtHZf7Bfc4l/dQIdjUaDrHweJJeEcUkhTkAad+m37zlH8753IZeENhOV9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603519; c=relaxed/simple;
	bh=vntSu+tPwyI64hOb+0HonFhsrIe9qCoTFPcOcuThVjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNOpS/nJT+89MVFSNHw/Ki30fR6fAMB872cEHNz20PYPY9aq4E7+HOfeJPrhrCGy/TQQ4Bi+Ld1gMNbjG9r67b6OYa4PPWptXUQWUhnHrv5GmXaJGESnaST4lThOxpO6SICHQqYXaE5jXzmU9wW8Rhn/zVLxkxNzKShRvjDold8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=C6RUN3rV; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=TXlg2y2H; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bb765e8efd9c11efaae1fd9735fae912-20250310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=vntSu+tPwyI64hOb+0HonFhsrIe9qCoTFPcOcuThVjA=;
	b=C6RUN3rVr8NdeaZbM59/6mjf03g+ztL4mnYnstkP5dh+8TT0PA4Wtlc0VsowJ9hmVrh67j4ebb9xf2Xp0d/YvPFZtNHeSqg83o/CQhv/XRlXB4l+vooY+GG1oqqswnZZpTDUzLY+QAimWjbgb0ycehTx3BNBb+jLXoqbXwv/wPc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:a5b43673-9804-4727-88f6-440e09d65305,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:23943fce-23b9-4c94-add0-e827a7999e28,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bb765e8efd9c11efaae1fd9735fae912-20250310
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1183581352; Mon, 10 Mar 2025 18:45:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 10 Mar 2025 18:45:06 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Mon, 10 Mar 2025 18:45:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgF1QCvq/ODmYMTUMnMTqIw5x89L4uXEeqH6r4NwEPrF7bYD/IjV9IpBbUldKiUji7jm8wllVwFGSfIHUmfuCDAxdk/whXlBQeUTNfmESWbfVCYxzR2ym2wJcWYpf3RGQDyupvdddC1+U7wzYw/GbLEMzcKOWMYfLpLQmeDb0mgIMEIfJxCW3FAPC1dNsxcvLz+GLTvoS3gRs6YWrZdy/5J7MTePDohbj7lYRfhKsdhdSVoGTpY//O5BXw1U6WqwclOzif6JWsWnQXeq0TKec+WeqeoPRD4P7IFnCKwVHQjlUDVHErY+n0SibdyH19OF+CfsrQPB9nYqMmYh+PguuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vntSu+tPwyI64hOb+0HonFhsrIe9qCoTFPcOcuThVjA=;
 b=tO3WzsCGAx4i473Nl2wg/+oeERnIvXJaoHnCJLEwM28WPJBzrr4auxYTaUIEFPUYxFzeEXgzbSEc6cg53Idn9+9CuXRhTiEzgf8rUR0QTHl1ejI+j0svuLgnCzs+JPMpvYzj2QHN9tBfjuaNyjKCnnRNpgcn/I5nvKhFMIxoFMCSJCWunMO97c6hY2iw4wkqpE0fMfCpy5V+ty52hnMmLT/SKZJZsnUyo669nuGzm6By1Mdda25YeybZmttCnTyq49IrmmilwZpRF0OvUmhfDuHiNLGU6Ypkn16tNrVyG0+ZCFPEMDCbiRtL+CND8UceCZDTdExOTLUMides+aIP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vntSu+tPwyI64hOb+0HonFhsrIe9qCoTFPcOcuThVjA=;
 b=TXlg2y2HxO/KSNyaewyzhVYbQ7jkzIpLgwMVmuYHbFRUdMSWtNt1HxjEbw8UeUD6Rzg46ZTWwRYEnXQMORe3xaCl9XArd3aa9ZzgsBveNVeruyq37Zy8C2gJ1jxKrVaYwbRuyxykHlVkA4XwN9D1Ksmo6O0j8aGPsx03N8Zr05o=
Received: from KL1PR03MB5891.apcprd03.prod.outlook.com (2603:1096:820:81::9)
 by TYZPR03MB7675.apcprd03.prod.outlook.com (2603:1096:400:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:45:03 +0000
Received: from KL1PR03MB5891.apcprd03.prod.outlook.com
 ([fe80::bfe9:aed1:6369:dc10]) by KL1PR03MB5891.apcprd03.prod.outlook.com
 ([fe80::bfe9:aed1:6369:dc10%3]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 10:45:03 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?WHVlcWkgWmhhbmcgKOW8oOmbqueQpik=?= <Xueqi.Zhang@mediatek.com>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH] memory: mtk-smi: Add ostd setting for mt8192
Thread-Topic: [PATCH] memory: mtk-smi: Add ostd setting for mt8192
Thread-Index: AQHbjyQeH3fV+MsNqUKANLZqC/ugAbNsNKsA
Date: Mon, 10 Mar 2025 10:45:03 +0000
Message-ID: <ba7863b39d259c469b58f53285d1bb0f2c48a0b0.camel@mediatek.com>
References: <20250307054515.23455-1-xueqi.zhang@mediatek.com>
In-Reply-To: <20250307054515.23455-1-xueqi.zhang@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5891:EE_|TYZPR03MB7675:EE_
x-ms-office365-filtering-correlation-id: 9c4f97f9-efbf-46ff-ac76-08dd5fc09d58
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S2xBbGhObDFNRk9qTFpPWGNQV3crRmc5QlQzSW9SMzBaTW1nUVFqZlV4bEdU?=
 =?utf-8?B?OWM2a3Z6UFpOZkIzbXQ4Ni9FOXFKS1AzbnI1L1FQWlF4NlltSTRPZGpCK0RQ?=
 =?utf-8?B?SG5ucDdDWkxYcHVrYk0wTW0vOFM2aDBSZ1VmYVJpcXQ5NTFoVG42RVhsNlF3?=
 =?utf-8?B?MFFDd0VleWR1VWNzY0hSUWZYcDJ5cHE5d2VqdytISFFjSlRETU1teCt3b0R5?=
 =?utf-8?B?RVVkVWd5ODE3MFNjTm5jekJvMXFQR0Q1Y29QaGUyWE1tUVQxZmp6UVN3Zmpx?=
 =?utf-8?B?bWlmdVFISVV1UWF3Q1N5eXJNbFFNKzlwUEo0ekloQnJkS21vcmxmdWtwM20z?=
 =?utf-8?B?RkljeEZTUUROdWRSZzRjckkraC9KN1BqZG5nemxTd05heEhMQXFmUm44eFBM?=
 =?utf-8?B?LzJmdEd3Z2daUWxFWVdDNFZuZTFueS9CWmlac2tLZS8wZks5cCt1OGV5Zmxj?=
 =?utf-8?B?VHE3QzdPNmhSRXgwL2ZDYXlNMGMzOWo3UFlDMXhEcFZ4YkVKa0NWdjZidU9y?=
 =?utf-8?B?T3VmZm04TE9oK3JDMnU2MDFrcmV1dlFGblJIczYzS1FyRnhDUXdSdytuUysv?=
 =?utf-8?B?Mit4bnE4WG5neExqYjM5WU1FZ0hDUTZ5Z2YxY0VIWEhnMjE3NjFNa0JaeUhZ?=
 =?utf-8?B?ZktrdEZjQnRneUd1ZEcrS0VlUmd0MC90QnRRcVpKdDNNcUtNeGhTSVk4Q0lm?=
 =?utf-8?B?MkVTaC9nUXN2aTJxZmloQ3IzNjg1dTFlcWt3STltNnF6RnZmdWdsM0drS3JP?=
 =?utf-8?B?cmsrMEZBdEhoTTI1dWczTDg1UFB2eXdNKzFLUVVIS1RXTUd2N09DVUVFTnRn?=
 =?utf-8?B?ZmRxQXY3a3N4dThPbnY3eWFEaENlNmdxUk5qL0lkeEdZb0tJNERrMFBpSUx2?=
 =?utf-8?B?VkJEWHBZUCtRUmVCTWVkSGRXMDJhaUZHeDJjY0pCTkFZWE9zeDRFeWh0QmNC?=
 =?utf-8?B?SCtwQjVXYUhRWHdEbUtlWUdsdEwyRkZ0ZGp0SURlbGwxQ3B2VkNqWG5RZTZ5?=
 =?utf-8?B?VTl6OHRMMkpsV0paYm5CNEdyaTJIWjQyMGowU0IwWW9QdXVVM0tPWkVZR0JJ?=
 =?utf-8?B?eW90VVBqc0V6MkZNaFJHM1dHRVhpL29FZVUrRWpmZzFLQTNYbDI3ZWkxSWp4?=
 =?utf-8?B?MU4vS0htSGRFRnNVczR4NHE2MzZwbHYrZjBFdDA0VVpvNkxSSGZ1ZnhtK2Mr?=
 =?utf-8?B?MXphTG02NHhoQ1FNRDluVlJLZ1RTQWxGOGM2VmpySHpjM3IvOVhFZkR1RVds?=
 =?utf-8?B?cG9mMDVVWFk0SDZYUFA0bngzdnVWOXZSVEgzeWphcFRXZHlxQVptN29OdzBO?=
 =?utf-8?B?QkdsdFBqZ3E2VDBoK3libmY3L3pRUExvVGZmVjhDUnVlYjJNZCtsMDN5YmFE?=
 =?utf-8?B?OEhYNk1FUUM0ay84aUdpVUNPL3cwR0Y5OCtNVjI3TG1OUlFVSFB0ODd1Ry8r?=
 =?utf-8?B?MElySEZ4aHhFMlB4bmRqWVl3NDlKRGdTQlVjWThTclRwRGoyL0pqZnh5aDNj?=
 =?utf-8?B?cmJOSTF4ZDBmRWJlV1lIVW9mZFFRTkpTTGw4T0RwaWNyVjFnb1Z1SFhMSW16?=
 =?utf-8?B?UWNhZ1QwMkJ0TGdhdDR1K052eGNBcnpadnV3T3pKQ2dSOGdib1gra2lMUWVm?=
 =?utf-8?B?dDBKR3JmbHZBNnI0aGF2a2VvclJMSWRHMWFLZXpFTkZPeVBocmdTaEVibWps?=
 =?utf-8?B?ZkFySkVpVW9yWUdvcE1Va0RKMnVvYk8xYUV0T2VBQnZWZGNvOVV0VEI0bXFu?=
 =?utf-8?B?cXc4V1BjNm9QRDByWFlMY3cybHlRMUNGTTRwd3ZPSFZySWxHQWRrWG81R2ow?=
 =?utf-8?B?TEtmS3c0UTZxSUtkdVNFYXVsU0VHM1ZSZEJSYVVuNk03cmRWaWJ6NnNMWE5v?=
 =?utf-8?B?ZG9JcDU1ZWt4OHpHV2xkMnVKSHU0ODdxSHlNamExb2loMUQvSEVKU1cxc0cv?=
 =?utf-8?Q?hEpB9WOcE93pO5hB+CBkvqkDM4rZojNM?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5891.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2RTdm0zUkVtQzdiVDlDU3NCRmhKYmlSdEljQW00QVo0bFBmOXcvOUhGaElX?=
 =?utf-8?B?ZUtDNkNDRFhUaUpNbHBIaFFiZ2JkL3ZmMVZOQ0RENWlPdUhjbERJYm1mNEph?=
 =?utf-8?B?TllhWTVWbHlWaS9TUXhEalJNM3FTT2Rqelp5aGlNOWs1NkZVR3FHakdBeTdO?=
 =?utf-8?B?N1dVa0JCWm9TQTc3bEdtcm81Q0grMWRWNkNsc3Z5cDhSTmUxdURSWDhQTktp?=
 =?utf-8?B?RjF4WVNoVGRuMzc2YXNSL0RnTjY5MWJjZHE2RThERk5XT1Qxa3hYQ0JUb012?=
 =?utf-8?B?UnR5citCazlxdkNkdzdEdjVCVnVsZFI4dVdqSk1PK3ZZOVh2RktUdndZblZZ?=
 =?utf-8?B?S3JmVmdHdm5wc2tUS0VqNWM0NnZ1OUJocUpDc3ZOWElHQjJwd29CWExSOWFN?=
 =?utf-8?B?T1l6cTVjYmtrRC9NajNZWGtGTDBOTGZhaXJMSTNwT3M0eWQ2eWxiUldMempa?=
 =?utf-8?B?dW51VEYvc0krTnlQNXhWcURUVTdQMHNZazQ3TG5FYVVNZnhTM3gyVGZwL2Jk?=
 =?utf-8?B?U01JcDZnUnZISzFLK0YwMHdNY2RLRytEVGhJS3NsT1R3aVhoTFpvS0l5Qldv?=
 =?utf-8?B?dnh5Skk3cVBEQ2JQd1ZGSGdTVTFJZTgyQmZXejNEaC9nMHZPaUxvUkN0NElm?=
 =?utf-8?B?V09na1NxM3hiZW5WM0MyOFphVlV2a21mb241V0dDYlBKelU3SmV6VnN2NERE?=
 =?utf-8?B?NzJtWGd5TStnTVo1TUtsMER6UEg5dy9pK1I4TmNham8xZ3dUZkt1SExUNkx1?=
 =?utf-8?B?eDBCcWoyY0M3Y3cyTWVrZ0FodHdVK3V4VDU2NnFlaFpqaXZiK3UyK3pkQlJj?=
 =?utf-8?B?QnF0OHRVcU5TQTAyS1A0dGNtdThkUzVTQU9XMmRVRERHY2U5dkVhWDgzUW54?=
 =?utf-8?B?S2dpbDZGNEtPbXdobVhoL2Y5Y2dtRmV3c3RzREwxcWpmZGwwL09iRFJwQWlr?=
 =?utf-8?B?eHRMYkM3bTcvZzYwWHlxc3BqbHJZTXZ0UWdnUEJuMVNQRDFpTCsrV1llUUF4?=
 =?utf-8?B?ZzQvb3NtTzhUdDVYcWNQSytZN2RaVWc2MERVN3BpRExKOXh5d2l4eEEzMk90?=
 =?utf-8?B?d2NnTU9ndU1EUlE2d0NwdXZtMVUvWkg3akpiN3RQaWN4Q3FxMTBZWEJrS3I0?=
 =?utf-8?B?TVdMNnJyK0EwWkJIZFpzQlkwcDZWS0c3MjdwTFZsV0JRa2hCUyt2ZmZJTVg4?=
 =?utf-8?B?MmhybnBxR0tmTnRxemdtVCtBL0llNjMyOVJHY1pyTnJCZnA2RllHRFlCNDRs?=
 =?utf-8?B?VUNWcTUxUnlENmdZZjNFSGl1SnpmV2VRSThjcjhadVhraFlacnFyY0M5TXJR?=
 =?utf-8?B?Y0FkQUlYajdLTFAvY3d4YlNYQWhtUEJWVWljQ0xmMTk0UHRRN201VGg3UkMz?=
 =?utf-8?B?OFE3SGhlVmIybWtyNVlvNTJscURLby9BZE1NSzBmenRSc1NlejhuZzNkTTBJ?=
 =?utf-8?B?bEpLWnJCS1grWTdTZFZjNkJQY1E3SWZycmRnUG8rcG9tRnhCQjJNekVVUFBQ?=
 =?utf-8?B?bmNDL3p3Qytyb2IybEpETU43YkNtNUtNazBrZmx4bEFLb3BvK3E2N0tzVEZD?=
 =?utf-8?B?SnFyRmhCeXRzMnBmd0p5UEh4OFUwRzVmcHBNYkZsc09MM1M4dGFsdDRjYlIr?=
 =?utf-8?B?WDV2N0xWNlRjUUJuMTlYUUhLV3NxTlJOZkI1ZXFiS2ZpS1o0ZWE1NFI1VUJj?=
 =?utf-8?B?VEpKVlJaVG1kT1JHQVFySjZWMjNqcVRyeWtaYk94SjRNOGtnd012dDlxOXR6?=
 =?utf-8?B?NTBqL2tqejdHRis5emduTEV0NDdQU0JEWWxJdTBnUWV1Y2VwNVFEd1U3czFC?=
 =?utf-8?B?aG52TGZlUjJxcE1oQ2JwcjI3S2l5MUt0Mkk5QnpHVDFyWjZrSTFGVGMzL1V6?=
 =?utf-8?B?Y0ZZNHVsTkhEQjBEOXY2WnNPR1BLOENQRDJIcEdrL1orODdsVEZ0MGYvL3BS?=
 =?utf-8?B?THJvVFM5eVEzY1JHNmhob2FsVENpRU9SemhzVHJDM0ZkeFFlSGRmYmJPQWph?=
 =?utf-8?B?cFRNdnBGLzZJWEVoSmx2TzRDQzhoKzRZV1Iwc0NxWmpnUnhLMEJ1ZUtKQXkr?=
 =?utf-8?B?NFFqeDlTRGtHbkFrMS83ZFliTlpqek1uK3JzYkFQQzRhUk93RWJsNUJubjd6?=
 =?utf-8?Q?/05QBg7osimhBRcJhnKLrDYKS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39FF783F775F3440B1CAAEBC8455C0F3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5891.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4f97f9-efbf-46ff-ac76-08dd5fc09d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 10:45:03.4436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ofe15DLuEp2vZWs/Qa5JUKwf/X9mRs/AG+avqCHioXdpgNfQEhRIdg/hSblMgmGElvYWEIktwo4bSN+f3n0Apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7675
X-MTK: N

T24gRnJpLCAyMDI1LTAzLTA3IGF0IDEzOjQ1ICswODAwLCBYdWVxaSBaaGFuZyB3cm90ZToNCj4g
QWRkIGluaXRpYWwgb3N0ZCBzZXR0aW5nIGZvciBtdDgxOTIuIEFsbCB0aGUgc2V0dGluZ3MgY29t
ZSBmcm9tIERFLg0KPiBUaGVzZSBzZXR0aW5ncyBoZWxwIGFkanVzdCBNdWx0aW1lZGlhIEhXJ3Mg
YmFuZHdpZHRoIGxpbWl0cyB0bw0KPiBhY2hpZXZlDQo+IGEgYmFsYW5jZWQgYmFuZHdpZHRoIHJl
cXVpcmVtZW50Lg0KPiBXaXRob3V0IHRoaXMsIHRoZSBWRU5DIEhXIHdvcmsgYWJub3JtYWwgd2hp
bGUgc3RyZXNzIHRlc3RpbmcuDQo+IA0KPiBGaXhlczogMDJjMDJkZGNlNDI3ICgibWVtb3J5OiBt
dGstc21pOiBBZGQgbXQ4MTkyIHN1cHBvcnQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBYdWVxaSBaaGFu
ZyA8eHVlcWkuemhhbmdAbWVkaWF0ZWsuY29tPg0KDQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9u
Zy53dUBtZWRpYXRlay5jb20+DQoNClRoYW5rcy4NCg==

