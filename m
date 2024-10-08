Return-Path: <linux-kernel+bounces-354459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0FB993DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70B4285FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8987E55897;
	Tue,  8 Oct 2024 03:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fZqEo6V9";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="spwKsSWa"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E51DFD1
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728359794; cv=fail; b=WXzD9HtRT4c6/9nV77ty8SAbICO+8g/X40BblPDsdKoyHeGNGm69QpVvbbniBLgQk40t3CdHKuMON+axFnTEa7RPtnnJJwdHclWzgKg3Uj9ffWCmUfdhNqcdmfUsKsw+pERelXo8XdZyAhX6eS2TJGhrWLWHqYYqFCMvGc7WQOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728359794; c=relaxed/simple;
	bh=N+xxCjeFXv+vXKNx2ws5dXjO2a6+DpCHy5FYCczPtqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M3Dks++TODR9AFcbUtQVJonbziYOoXVyMr/NZYyNcEzn2ucl9hV1k/kL52IOhujgWoPJtRcZ5aVtWTmveWVHoztVdhtVVAr5087uCZsQyvdi5B/HnnCq7iNnnbDkrl+Khn3MhuG4HGFFat5Dmr4AKXttEYuK6ZPkx/KFxEY6fRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fZqEo6V9; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=spwKsSWa; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4a85a32e852911ef88ecadb115cee93b-20241008
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=N+xxCjeFXv+vXKNx2ws5dXjO2a6+DpCHy5FYCczPtqo=;
	b=fZqEo6V94ZqVtMRmyDrYaX3US4GE0gbz5oFXXX0uu/EnjStjFpPH92uT+civXQ8HW5JVMzE9RYpBqTevNZhmfAJiuPcaHXHNs+pDp7Mc8jS8CwIFe1Z28c2DZZ/SpPYfammq6QXK/w0/jD+Nl8mm4coLG9UX3LylGe+4UVKviFE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5ca3a4dd-7fb7-4d3d-9343-e832e1a308f9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:17aae940-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 4a85a32e852911ef88ecadb115cee93b-20241008
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 552529202; Tue, 08 Oct 2024 11:56:26 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 8 Oct 2024 11:56:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 8 Oct 2024 11:56:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXneSgaPmgAxnSxHheZXw5z42Idw8EB+tMBofcR5gpTbHp5B/u86N1oJdmk10B2WU5TuJPspgjdSNCBqxy6KRCEhKGqZnDQOEMDSxHWByKR9GC1pa8JblTDhMJYMX/9zc4koiehk+5s6RmyxvRiXu4t+WFahNj45bfGi1t0N/6zahMH7KozFto0SryVA268w4sL+MTYd/6JuYh7RMiPL0f0jne5OlzP8UWToG9e3z4uMfvUai4F8MiL91YUM3br+I5+O51z6QRnCa7OeUF0ll/jCpl1gSuUpq+8EvBdHpBNFwp2ryZo2Doz75yjbM5cH2tnv9MGz3NX/gHZX4ffy/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+xxCjeFXv+vXKNx2ws5dXjO2a6+DpCHy5FYCczPtqo=;
 b=SZxZanGeLXTsFZut4WVQzCWyiXi1nav98XAT+Yya4rKqHqlYXHHgN+qMX6a0S8+4npoekUmtbIsRv2Ex14IW+Ph8V8YSspD+jOat9gM5VmPMXWWa3CAB8OZgcslFjN80FE+PfD6/beDt3lIBc2fVARkGqRU4r9DRi9zZaC036fLfiSvKAOrugj5qJbLhnS6jCEHSjC6Ec78Pd1M4NaN7UKtV/awpxVVP6VJi/jSqhZCph4F9tNFgeYZ1tEC/kSwL0MRw+FqjZF/QeWVx43tNImjvmj/VKZ0qyrhrIHxW3tjwuwYvN17l0/xrVhkClvItq4SW0OSzYVGqdiqaxrljqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+xxCjeFXv+vXKNx2ws5dXjO2a6+DpCHy5FYCczPtqo=;
 b=spwKsSWacCU1TJW8siMpBHcr6Puyj5s+3PPuCE3P4UIcMMzDwR/xVjezoOSG+5cHF8pa66Zr2+/unGY8u8JLiDCnwHli0eUI7XSOI0sv8TpOdgZKBvIzpataTH2APnCgP7TXIW6MrlFa7S0CfMP9D1jvf1vYEZJU65jRW67pVRg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7882.apcprd03.prod.outlook.com (2603:1096:400:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 8 Oct
 2024 03:56:22 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::9ce6:1e85:c4a7:2a54%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 03:56:22 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"me@adamthiede.com" <me@adamthiede.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "yassine.oudjana@gmail.com"
	<yassine.oudjana@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/5] drm/mediatek: ovl: Refine ignore_pixel_alpha
 comment and placement
Thread-Topic: [PATCH v9 2/5] drm/mediatek: ovl: Refine ignore_pixel_alpha
 comment and placement
Thread-Index: AQHbGIbpZMmE34QgKkWg1d1skz/42rJ8OwSA
Date: Tue, 8 Oct 2024 03:56:22 +0000
Message-ID: <0540f783d0c011b8f8ba3fa1f173616ff2e26d91.camel@mediatek.com>
References: <20241007070101.23263-1-jason-jh.lin@mediatek.com>
	 <20241007070101.23263-3-jason-jh.lin@mediatek.com>
In-Reply-To: <20241007070101.23263-3-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7882:EE_
x-ms-office365-filtering-correlation-id: 6452421b-20b2-47bb-b0b8-08dce74d2c41
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NE5YY1pMelNxQW9ybEtJMFdKQW5wY2UwR1JlS1BvMy91NGxyaEMvdVFUemxz?=
 =?utf-8?B?UU9ybkZXRVFHTTZxcXpaSDFVWjcrL3lEU3Z1LzJhbklXMmJZL0tyZ2h0aVNu?=
 =?utf-8?B?R0lpSVhvUFh6ejRCNVJRYWcxRWN3WDFTUGZ4eXBRQmVCbyt2ZGdqaFlzb0Ja?=
 =?utf-8?B?ckdCeVBkQlJycnRxTVY0VzdramlHWHJtaUdhYktrNFhCWllqSEUvTFNyL1dX?=
 =?utf-8?B?ckZJNy92eWhDdTVSZTRuejlDeHZkaHNIcCtYdVF6Vm5mcFlvV0N1aTJTR1hI?=
 =?utf-8?B?V3lHM3lveVROWWoxSkNqamtXb3FKeEU1TXZNM2gzQ3hqejgzZE9ZZzhNQ2h2?=
 =?utf-8?B?NkdPeGhWb2VGUTNPbUVBRUt2bVVVV0FzY2FwUDQ3UXVBalVhNUlNR0trbGVV?=
 =?utf-8?B?Q3hoUDdtbzhHQ3dxZ0FmUFNSZVVjTDMzZzBnMTBCcFVlcWtab00wQ20vUnJx?=
 =?utf-8?B?Rk9JS1JMZGdqdW9qcnVQc2t0OGZxaTJyMGxpWHpxVkJudlRvN2dvbDZaWGNZ?=
 =?utf-8?B?cHdJTDA2YTBHYmc2V0dqeTNYNllmVWRETlFJTC85cTBSeXNxTUIvZUV0cGlm?=
 =?utf-8?B?K2JiMFI2YklhUWFZTy9STzJTdVd1cnJ6WWJzZzlpYTl4b2N4SlBuT0FhMTVB?=
 =?utf-8?B?cnkzQk5FcGdubDR0SlIyT3B3UHFTOW52Z1d4eVk4ck14Mnpnc2c1Vy9HbnR5?=
 =?utf-8?B?dmRFNTYrK3V2SXdxV2s2alZWTTRvU1h3WnZCc3dQRThMR1cxYlB3MGlnTy9k?=
 =?utf-8?B?eXFSYXcxY3lEYXVJWmNKY3Y0U2F6dlBXcFpGNnRRZGhiZnJLRXJldy96TVJY?=
 =?utf-8?B?NmVyVHBGanI2UVRpdVRGajBGU1QwSlRyYllucWg5WVlBSnl3TFlZR3JxWDhP?=
 =?utf-8?B?THdJNllQbldTQjZ1cFBldXFuUGY3bDlwNDIyV3hicHJCeHhzRTIrZlJGMDlu?=
 =?utf-8?B?cG1WSWN1UERNSHlSNndGVldjQ0E2dlBmNndYN0JDTWt4REx6aGVRbDJUdGNn?=
 =?utf-8?B?emozcWhlMmwyTG9DRTYyTVh1enQrV01wNnAvV1BKTG9UUWl3Vy9VUStnNjhu?=
 =?utf-8?B?SFJsZm4yY2VSaDhtc2FTYjlNOEhsZWRUZ1U1VS9wM0V3NlpOUkFqNHdLQVJO?=
 =?utf-8?B?bEY3dmZFT2JoMm80ZVdWVFNCNXRvYmlqZk9uRFVCS3dlYndLc1JCR3FKcHdw?=
 =?utf-8?B?b2lFMWhoUy9rVjJnbmdjMDR6YVFsLzFhR2gzdGUrRUlGTTN3cVlBY05IZ1B0?=
 =?utf-8?B?NnNuOHZ1M29kT2RRbGlyYklMd2d2UUdKRjlhNEFGQVJvNWo0STZYNnF5Zmc0?=
 =?utf-8?B?UzBHUjM4endHclM1amtlOEIvRmZzNnFoVUtKZWhCQ3plUXBFRVlJdTBhRVJ4?=
 =?utf-8?B?Uk40b0ZoWFBVeXJNN2FGVURpckNrTHdQTG5XWmlzZ2NGZDM3TDhqZ3VFMHQr?=
 =?utf-8?B?T3U3VmVkVmJsdStyaE5pYmtTdXE5WHRlZkQ4NHFRMDFqNGkrdWRZTy9ZODhH?=
 =?utf-8?B?cDVUUFVIZzJ1NkJmRVZvbEFWSVJ1dENOVkk3ZTJnRmZ3S2dvOFl4WWZtWHY3?=
 =?utf-8?B?Rm9jZUFRcVh5TVJZQ0NBN2hVMi9DSXJpSEdPU1JsNFg0WmxQZ1YvZUhwaTdQ?=
 =?utf-8?B?NFlXai9QemNaaFJ1azNmc05Fc0Z1QVQ2bUNoSWN4WG1ILzZZMm1jWEp4eHVx?=
 =?utf-8?B?djNNM3k3OEg4RVdUZXNMRmVDQnpSdFI4OUZlNmFmMDUvcHVkMHNWRHB5Tmsv?=
 =?utf-8?B?L0xHZFB2RmpKZmwwMC9PanZURUhsZVI1Q09sOGdJUFlaeUhNWEIzNTA2RC9Y?=
 =?utf-8?B?Y2g4YVJ4SzQrUDVNajhiQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWhjUHduYzNqK1d2b2JPMTliMDZ0OHBURXhXNHBPa052QjRuQjJRWDVqdkxh?=
 =?utf-8?B?b0pheVJPWldPc1JldCtUMnY1aHBsSXY2NzNobm5iekIvaTg4b1A4QnpDSGNo?=
 =?utf-8?B?UCs0Qk42QlFZaUttTlkzMTh5aDQ5Zk1EMUJrUXVUM1NaaHh4YXVqQkRSZi9s?=
 =?utf-8?B?M05LTG5vUkQyMEh0MkxnWWVtWXoyTE5ha1llMkt6bWZKblBLVGRyY1ZsWW8r?=
 =?utf-8?B?d2tJb09uUEV2bHBUSzlyYlA2bVlDU282a0lCaFh2QWpEbzJuU3FyczZmMXpy?=
 =?utf-8?B?NVpkWnptRWoxZERHU2NvY3V4TmZYWEQwZEgydnFScW4xMmVKV2g3djFSSVIx?=
 =?utf-8?B?cHRES3REcTg2VUVKdjh1VXFpdEZjdkV3d3VrdENHTWV0L2QxVjQ4OTl6SzhG?=
 =?utf-8?B?bU1mbjV6ZXpURDNvL1Z2L3E2UVRUeHUyYUVPWFAzWW9TbnhuMmVQWVNHL0g3?=
 =?utf-8?B?dkU0cGpaR1U4bWxCcjVUWFJLTzdGUzRmVEtYYm9RZndna0MyV25sMmhKb1Jh?=
 =?utf-8?B?VTF4UDRsb1UzZEdGSHkvWmFxN2FGN3RmUEtwTVltbjNzcDNvSnRtYXg0M1RG?=
 =?utf-8?B?eFRGVktVeEtjUWxyb0lRSlFLMHJGeHZBTjFYdm5sYmFiRjE2dzVibkpPMkV2?=
 =?utf-8?B?MDUvb3BJTk0vaFErYTkxT3NCSENQazhEOTRMbSsrZ0FaYVhqTnVuSGYvVWVC?=
 =?utf-8?B?OGViOXpncjJ4SVR5MTBJT2tjRVhiR1RkVzVqZW9ER25TMVk2NzJFVnRVVE9u?=
 =?utf-8?B?THNuOUFIdGZ4ODR5Tk1Nb3FqNDE0WERZUmNzMk0yazlDWmYxMzRjU0ZyZVYr?=
 =?utf-8?B?bXEvc0lxUmkyc085Z3cxTUpxWDRlUGtsRTdGeDZNWWE1RFhqeEdCdjNKdDhE?=
 =?utf-8?B?dkhCWXMvcWJTYWN1cWxSQjd2ZnY1bWh3bkc0Zm1ETmRBNjM1K21BN25idGhz?=
 =?utf-8?B?T1ljMldyQnR5ZWZ5Tk82MVIzMXBFcFNxSXMwZlpIQ2x2UnZJQzdIbmxmQ2pK?=
 =?utf-8?B?anROSlJSRXBDYWxZWlhVSVlPZVpzSkw1dXhrNGZGd3lldy9rM0FkRlBpM3R4?=
 =?utf-8?B?SUYzUnlqMjYyL2hDUGJ0T0N1Qk4wSE9UM1drKzRvNlBkK3l6clBOS3BpYlhh?=
 =?utf-8?B?SUx1UkFaNzh3cmU4VkxsWFN3ZkVIY2c0dUxyWlh2b1ZTcXRyMG5id2lQc0tR?=
 =?utf-8?B?ZjZBcjY5dHY5RzIrd011cVR3cjNwM3pDeUJ6R3pjY2dlbkpBcitFc2tIQ2ds?=
 =?utf-8?B?cDlTR3F5aVk5RHQxR1JrNmxxRGh1Z3RiTjNZUUM2MWJXUkFiRVBjQy9VekVs?=
 =?utf-8?B?cFFyZWVMS1JiNE9Vb2lEdStid20wRXhPaGZvcE44c0NXSFJISy9rME5uMVNR?=
 =?utf-8?B?anZZdjV0Yk53L3ZwWTNzWldEMHB2bUN5ZHBZRHduNGF0emU4eEVDTkNaUDdL?=
 =?utf-8?B?YmNUNVhzNENpMGlyMjZ0emJmREY4SmczUytmNzYyWW9jRUdtM0swSzVxL29K?=
 =?utf-8?B?dmJtYzR0V3FyQ3FMbkJ3WnEybHYvK1dzZnQ1V0RVMDhHMzk2UEM4L2lvM1dZ?=
 =?utf-8?B?UlpackNuSXNnS2ZwdFREczV3S1BpZFB0Rmo3RUIrZnN3eFY2MXhnQzc2UVhM?=
 =?utf-8?B?ekwyd01oSGZKWFBxYmovT1FzRit4eEUxcTlQelRaK1RMa1NMdTBaMG5tRGZX?=
 =?utf-8?B?cStUM2FjU2VvaWd6ZG9OTy9vT2FtZWE4eWc3dnJlcTVJdXFZQmM3TG1KSFJw?=
 =?utf-8?B?ZFFGcUZjbE9Xd3FiQWlKem12bWF2U1VWK2tsOFF5V2lUeFQ2NGNmOVN1VEtE?=
 =?utf-8?B?UkhiWmVhUVl6L21TUVZpU1ovRjdNWWhPV3BDcCs4dGhuV2lEbVd3V3NrY0cy?=
 =?utf-8?B?VWtDL0NuQnNUQVlZcVZuY25TSEhvTnErMlNYSmQ5WG9yU1hmZTZHQUkvWUZo?=
 =?utf-8?B?M1VnQmdrQ3BNMDBiZ1hteWVTNFhDY1p2MGxvZklHTFd0RTRIVVdsd1lGd3h1?=
 =?utf-8?B?a0M2bkZuVWlDellRcngxbWpTem1rcFhVSUtLSU5qNW8zQUdMQ0lEbGswS1Zl?=
 =?utf-8?B?d293RzNNN292RnhGa3BKaElVb2lnd0drUlhyc0pnZXR6WmlpUG00cVMxMFI2?=
 =?utf-8?Q?3YoRpgvFkVqu+yc0rnZj3i+cC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7BC290877A1E5F42AD92CDABE1DEBCF7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6452421b-20b2-47bb-b0b8-08dce74d2c41
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 03:56:22.0463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5bDzgTxjQIiNo22Mh/GXmRxLgQxprLuzE8Ccy/kMwTVBZoznkdgzI+5zNuS2Gpd0c19ERwmmBIYJFF9w6t97g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7882

SGksIEphc29uOg0KDQpPbiBNb24sIDIwMjQtMTAtMDcgYXQgMTU6MDAgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gUmVmaW5lIHRoZSBjb21tZW50IGZvciBpZ25vcmVfcGl4ZWxfYWxwaGEg
ZmxhZyBhbmQgbW92ZSBpdCB0bw0KPiBpZiAoc3RhdGUtPmZiKSBzdGF0ZW1lbnQgdG8gbWFrZSBp
dCBsZXNzIGNvbmRpdGlvbmFsLg0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVr
LmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5A
bWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmwuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3Bfb3ZsLmMNCj4gaW5kZXggODQ1M2E3MmY5ZTU5Li5kZGM4MjZjNDI2NTMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiArKysg
Yi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gQEAgLTQ4MSwxNiAr
NDgxLDE2IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1
bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkgKi8NCj4gIAkJaWYgKGJsZW5kX21vZGUgfHwgc3RhdGUt
PmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKQ0KPiAgCQkJY29uIHw9IE9WTF9DT05fQUVOOw0K
PiAtCX0NCj4gIA0KPiAtCS8qIENPTlNUX0JMRCBtdXN0IGJlIGVuYWJsZWQgZm9yIFhSR0IgZm9y
bWF0cyBhbHRob3VnaCB0aGUgYWxwaGEgY2hhbm5lbA0KPiAtCSAqIGNhbiBiZSBpZ25vcmVkLCBv
ciBPVkwgd2lsbCBzdGlsbCByZWFkIHRoZSB2YWx1ZSBmcm9tIG1lbW9yeS4NCj4gLQkgKiBGb3Ig
UkdCODg4IHJlbGF0ZWQgZm9ybWF0cywgd2hldGhlciBDT05TVF9CTEQgaXMgZW5hYmxlZCBvciBu
b3Qgd29uJ3QNCj4gLQkgKiBhZmZlY3QgdGhlIHJlc3VsdC4gVGhlcmVmb3JlIHdlIHVzZSAhaGFz
X2FscGhhIGFzIHRoZSBjb25kaXRpb24uDQo+IC0JICovDQo+IC0JaWYgKChzdGF0ZS0+YmFzZS5m
YiAmJiAhc3RhdGUtPmJhc2UuZmItPmZvcm1hdC0+aGFzX2FscGhhKSB8fA0KPiAtCSAgICBibGVu
ZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUpDQo+IC0JCWlnbm9yZV9waXhlbF9h
bHBoYSA9IE9WTF9DT05TVF9CTEVORDsNCj4gKwkJLyoNCj4gKwkJICogQWx0aG91Z2ggdGhlIGFs
cGhhIGNoYW5uZWwgY2FuIGJlIGlnbm9yZWQsIENPTlNUX0JMRCBtdXN0IGJlIGVuYWJsZWQNCj4g
KwkJICogZm9yIFhSR0IgZm9ybWF0LCBvdGhlcndpc2UgT1ZMIHdpbGwgc3RpbGwgcmVhZCB0aGUg
dmFsdWUgZnJvbSBtZW1vcnkuDQo+ICsJCSAqIEZvciBSR0I4ODggcmVsYXRlZCBmb3JtYXRzLCB3
aGV0aGVyIENPTlNUX0JMRCBpcyBlbmFibGVkIG9yIG5vdCB3b24ndA0KPiArCQkgKiBhZmZlY3Qg
dGhlIHJlc3VsdC4gVGhlcmVmb3JlIHdlIHVzZSAhaGFzX2FscGhhIGFzIHRoZSBjb25kaXRpb24u
DQo+ICsJCSAqLw0KPiArCQlpZiAoYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9QSVhFTF9O
T05FIHx8ICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpDQo+ICsJCQlpZ25vcmVf
cGl4ZWxfYWxwaGEgPSBPVkxfQ09OU1RfQkxFTkQ7DQo+ICsJfQ0KPiAgDQo+ICAJaWYgKHBlbmRp
bmctPnJvdGF0aW9uICYgRFJNX01PREVfUkVGTEVDVF9ZKSB7DQo+ICAJCWNvbiB8PSBPVkxfQ09O
X1ZJUlRfRkxJUDsNCg==

