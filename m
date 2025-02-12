Return-Path: <linux-kernel+bounces-510401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B5AA31C42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BEA33A820F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2F1D95B4;
	Wed, 12 Feb 2025 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aHPgbXnI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VdFLlhp+"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4AA1D9688;
	Wed, 12 Feb 2025 02:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328445; cv=fail; b=SMRELlRBly1etgVbVknckmKGXxjcVW6whq4seP2LFNrqRGCJ8CQkuqNPLRZzCy8ZiRw/aLYgGj2cyX95YcqmvQZ/n0iXlboZXdxZzKUcnH/9rf9rTyBfdopYzRngkTKYN5VXwiflp971beIYEB26B0HXgefH1FpRmvngZ7AzrmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328445; c=relaxed/simple;
	bh=1S9kivCfAqAKzC7dWBg2Pb1RVfWFC6ERUe3gVNeUvRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Prvhf1Ued8PBjusuC9zhi4m+djRrzqZTRjAN4Eww1WImhttslQHEw75BUWiBtpvpeAAOdEx2+LaSadz+y/DeN2wH/0JBNI8pzTPZY1O/KhXeCtIu/iToSZkUQ4lRWQhEkIa+NwLwe8bE5w5XqqcxznFAhpp3XAY5Ld4qE9nGdbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aHPgbXnI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VdFLlhp+; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ac1b3b6ee8eb11efb8f9918b5fc74e19-20250212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1S9kivCfAqAKzC7dWBg2Pb1RVfWFC6ERUe3gVNeUvRs=;
	b=aHPgbXnIuyODQGHTIYb7C9cJlyOuNrsD/zFT5Uf4F/eAEbzgRcI4MZgY0Cv06CC+Yi9/iZFL+2x0utGuqqpC1KIHGbCOGXjiVreQgt4HWAssolpDvQkf55YySUqGKzbUMMOdET88TNhgkhRmHbW3I2htsY3NAKkuWk9gyZaISPk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:a1c01a62-9a94-4b86-b6ca-341040014bc6,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:630a3b8f-637d-4112-88e4-c7792fee6ae2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: ac1b3b6ee8eb11efb8f9918b5fc74e19-20250212
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <crystal.guo@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 114976824; Wed, 12 Feb 2025 10:47:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 12 Feb 2025 10:47:16 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 12 Feb 2025 10:47:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lG7zhsqlE2nRt3R5F7600x6jhAtp/AA23XBilekWHS0kTTkZNLrD1pFbXaLe3s0bgc0dy02LFGvrHtczvfjMnwQrOYI+cFjntWdS5G1YX1of0cZCKCodAYDAPhsN4d4cvj+xnsd4eYK6Mr8a2QQvfayVhNXFO8PR1aKeWWunXRY5tVwlbHimI57cFOFJgji/yOhtCo/t7lC3tyBrcqc0ufp4+6uduO0eY6VAQpEbBWLZAVkqlPwHQkH5kiiPMpoOoYjh4JP0z2/UpL/tYuc/N2JPrMh4xhnf/BCg3hDxsasMfBz0wDmm3iwVzX5nrLwMplyxm4UwyzXPZDb7nwJq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1S9kivCfAqAKzC7dWBg2Pb1RVfWFC6ERUe3gVNeUvRs=;
 b=VHQSznLt6kmBIbhknWkyGRFwfRpeZjDT1o7msNhgzwwRa3xMlP1i+3Ub/DRgiKzeGqeySyU/rtKXNXpKMKpuFbYPr2Qr3AtIW550c06r3bOTWilFNafUHYfr5x3i4RZiCtH5zXgPGJcuuNG8HTE3Y2trbRfolGThaVhU0mvG0FM1xUbL+NbeAS5CwtldTKujDdL/wZc8LV15PIgLGketCQ/MYpOsyiGr62u47BJz+bs8ya1yspVi7080ImyOR2X5640ODMPRUs0RS6BMZKIa1Yqq5Jf0Sgrp22XoI1z8BV9tE+v2aCogr06U22blSw2iCHceATi5ZWURGMV07jlUvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1S9kivCfAqAKzC7dWBg2Pb1RVfWFC6ERUe3gVNeUvRs=;
 b=VdFLlhp++DsAQ2TPslRsIe1duAJK2nHlTKKijvS9b2QQCbA285n+DFzVMXpovRJGYwaK6z7MCn+wkyEKhqgzCkslx4SUopl6tGo44Bss4EcTbENZujiTcTa2zYbP22Kq7heUDsZS6qaXk0nvg/XGSVRHaNVuHo6cv4HCUWaNnkE=
Received: from SI2PR03MB5468.apcprd03.prod.outlook.com (2603:1096:4:104::5) by
 KL1PR03MB7850.apcprd03.prod.outlook.com (2603:1096:820:f0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.16; Wed, 12 Feb 2025 02:47:13 +0000
Received: from SI2PR03MB5468.apcprd03.prod.outlook.com
 ([fe80::28b5:41ba:aefd:a96f]) by SI2PR03MB5468.apcprd03.prod.outlook.com
 ([fe80::28b5:41ba:aefd:a96f%7]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 02:47:12 +0000
From: =?utf-8?B?Q3J5c3RhbCBHdW8gKOmDreaZtik=?= <Crystal.Guo@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzk@kernel.org" <krzk@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 2/2] dt-bindings: memory-controllers: Add mediatek
 common-dramc dt-bindings
Thread-Topic: [PATCH 2/2] dt-bindings: memory-controllers: Add mediatek
 common-dramc dt-bindings
Thread-Index: AQHbTHR51IFImiRpQE6zUN4tmCVA0LLicIEAgF//bwCAADHSgIAAtioA
Date: Wed, 12 Feb 2025 02:47:12 +0000
Message-ID: <fee74515c24281773f46980ac184948f893955c3.camel@mediatek.com>
References: <20241212090029.13692-1-crystal.guo@mediatek.com>
	 <20241212090029.13692-3-crystal.guo@mediatek.com>
	 <c978937a-e589-4e9a-ba37-265dbfc1b252@kernel.org>
	 <8746bc17ef28da632e9ca765d2c3ce6bdc56c6f4.camel@mediatek.com>
	 <d81c46ca-45de-4c69-a786-9c74bd06333c@kernel.org>
In-Reply-To: <d81c46ca-45de-4c69-a786-9c74bd06333c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5468:EE_|KL1PR03MB7850:EE_
x-ms-office365-filtering-correlation-id: 14de9512-622b-47b8-4f44-08dd4b0f8d9f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Z0JrWE9ZNEVaWmZnS0lGMFp3Skt3ZE83aW5aeDBiM2JKNVRrdzMzOFJYSnBo?=
 =?utf-8?B?Umc1ckd2bE1JeXJLSlZIdlg2a3BaS0VZU1BScmQrTndLWDFiajJ5clRKc1FJ?=
 =?utf-8?B?cTQ1WGtiSXBudUdRSW1QaVhrc1ZDZVZTdEg0UERheFUrUTZ1RkI1N202M3BQ?=
 =?utf-8?B?emFEbnljMnRENjZudGxVNHpwWE5WRlZtTjV4a1UzLzJFVDB0OEt4d1c3cGlw?=
 =?utf-8?B?cHkzWU54TTZiTGJWWExLWVU4bnFiOE8rUklSdVoycWsrRG5OVHZYWXVDZytm?=
 =?utf-8?B?RE41RVBLLzhURk5NSlZnOXErcFp3Z3ZuWWhDbDFwNXpWSUVkbmcxbURBNTkx?=
 =?utf-8?B?eisxRi8wWjdMeUtCZVRwR09HM0pEUzZoM3IySDFFUzhaSXRvbGRZemlkc0Ir?=
 =?utf-8?B?RUYrWG9LdjVtdnUxb1lubHJybThwQ3JxaTdXaFZPTXFXNHA5WkVjNG5PT1JW?=
 =?utf-8?B?bnRFYXczQnFLMkFrZmY1K2M2bkc2SUdzM2hoVU1HMXljdHRSZWl2ZUhMSGlS?=
 =?utf-8?B?S3FtYWQ5UW1xYkFsNjdBdnAvem9WMkRvcmV4VUFCTmFHemdoYWxwWnBhZkVV?=
 =?utf-8?B?VVphbUFOelgwVzA1NndLT3BKYzE3U0lQMTdNSG1QUXlMRFBjOGdSY1BFZkEr?=
 =?utf-8?B?NkZiN29MK0NDY1FZT0N4VUdhVEVURjU2QlljTnQ3MmM0WjFWVUgvZC9BN2NZ?=
 =?utf-8?B?dW1qZGZyQXowNVZseDFtVS93dmg5akxuOXZZbnFFRkxpVXFYajdyVyt2MS8y?=
 =?utf-8?B?MkRyc1Jsb3pSUFJjaXNBNWQzdTZ2VmMxYXBZUDZRTElkWHF0dWVJbDJwYVNp?=
 =?utf-8?B?NkZXNXZ2MFl2SWd3TnVtWXFKU1pwWk10U3k4S2RDazN6N2dueURldVhhZ051?=
 =?utf-8?B?anBBOXRHZGI3ZmpoU1VyQ2RZOEh3dVN4Tk5QOUhCVXZ1MEs4aWZYYi80RG1k?=
 =?utf-8?B?eE1XSU8wTUdmeFRyNitzT3pBcitwWlkrbS9UTXY2NE9LWEoyUXRHR1NUWHhL?=
 =?utf-8?B?Q2ZCVjFwdW9RNXpvUHA0akRUWm9pVW5obXcrNlF2eUZqT3ZiRk1lRWR5MExN?=
 =?utf-8?B?SlJOalRER2NmSWM5UitQSXNrYjBMYW11TWQ4cXZwYWMyalYzNHBSNWNiTXl0?=
 =?utf-8?B?emhKZkpBL3V3Q055UHVTNktSMmZwT1dlc1FFd2VPTGNHZGg0TEpmMWZrejBs?=
 =?utf-8?B?dXg4TkJPVk0zRWxwNGtJR3hlT09JTExmS3dUUnpBZGJGRlFBYWR3Z3ZQckNU?=
 =?utf-8?B?T0RYelJaWFdra2NlelhxSCtVSUI1UldINEpKbW1VQVBTV3VMaHE0eWllcjFH?=
 =?utf-8?B?aVlhTW9YdmRVcEQ4RlJ5aGg5ZmlwZXBiNmJjazNTa3pOWkE3T0ttdTVPM3A0?=
 =?utf-8?B?Mk93bkh4OERMVkQxR3hIME13NWJ1MTlCbHhGOXBvWkVRVGtHeUhKQVpHUi9s?=
 =?utf-8?B?Vy9uZzZIYldTVnRLcnl2Ty9ZM1NEMTF3NWp2Njhxam01eWJIdnA3ZUs3cE0x?=
 =?utf-8?B?Sk1UMlBnMXVsc202a0pvZ2FSUWNqZ2NDK2lWRHd0Qktad1BjT2xWNlZONjlI?=
 =?utf-8?B?NlV5MGtTdWQ0UG1abXVaNWQ2Z2FhS1NDV1p0M21hcnNVNVl1ME9Rdk51OHZL?=
 =?utf-8?B?UFZuSFp2ei9hRjBlSHVKVGJybWYxUVJYS0R6bEM3NWhURWVEbDZjQjVWclJT?=
 =?utf-8?B?T09QUkg4YTU3Sjg0WGJ1VlVReitLMWxTa0lLcnAxTE1sei9jcFhrbG11WVQ2?=
 =?utf-8?B?a0U4dWF5S0JhVGZvQzVZcmV5aEFDRkFGUmNmYTJ6T29rU2FLL2VvSWxPVVNj?=
 =?utf-8?B?MnFtbmprSGluckhiaGNrQk9BYXFMaG9lcm5SRDNEczVWRkI1enZ3MHhRNkRx?=
 =?utf-8?B?OU5pV0JsZStDMkdMTTRZNy9GcThqdGlnS0hDeE1oSnNvV2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWtpRHEvTzkwZzdKd04wRmRjSzhUQzdicXB4WWU3SXVKbWhKR1FoZEUrdmpO?=
 =?utf-8?B?Y1g4S09rcmh5eHNVbm0xWE0xTEw3NVNyMjMrZGgvdmErZHVkZEtocnYzbVRN?=
 =?utf-8?B?MkdsRXhiMUtkNnRmYXkrRzk5enc2NTFSYkd0YTk0d2lVUjdtLzFvbndXemhh?=
 =?utf-8?B?RGZmMSs4ZThtQXVQVE1xMUJMemFKSVoyWSs0L2R2dUQwajc2RmxHT2dPZVc1?=
 =?utf-8?B?WTVqeFFudnZqd2pOSE1sNHlyNTZiaHFKMkxtVnVIeERGRkg2cjB1eW03bGJB?=
 =?utf-8?B?cjJDKzN2RHpOVVlNU3pzZENPU2xPS2xMdHMzcnJYeGp6MXNhbDEwSmw4Rmll?=
 =?utf-8?B?ZktTZDFkUUJtMU1Ya0RQRWszTHVzdUxiZmV2UWxDUUdRZUx2TW5vTHEybFZm?=
 =?utf-8?B?aU5rZnhNM0dXc1FFMWt1ZkhkcllGUWRSUVBVSW9yQ2YwbUlTbjVtakpBTFZG?=
 =?utf-8?B?VG1NaXRkZ2oxZkRTdGtNLzVTK0J0M2lUSjcyaWt6djh6OXl1NTFQYWNQd0RG?=
 =?utf-8?B?ZWFsYXJUVUR2N3c4VUNweTVFcHp4a0RiNTNmY01qc2hhWlZFaU5Bd2JLek9P?=
 =?utf-8?B?RWxtOG5FdHRneFdlTkFSZGs3WjIrbXVsaml3RGZSNlVhR1o3M0JvSkVWYmJI?=
 =?utf-8?B?MzVXaldiQnM1Sm9lbmF5WnpPRkQxV1EyTXJ0YmxNSU90cjNnTVlSSmFvcGla?=
 =?utf-8?B?QnRPbGhLdFRHUUdPUFN3Q3dONVN0bGJjc0lLRitXQ1Ztc1FFRDFSMGV0UXN2?=
 =?utf-8?B?UGYwSVNubVRSZDNVYTMwRDlNMFVhMDRvdDNTblVSTGpTL1RZOW1NNmdjV0FX?=
 =?utf-8?B?UHpJQ2xBUUdYdGROUkc5Z083bjZCN3VlOXIxa0thdnlVS2x2UjNBOVJldVZP?=
 =?utf-8?B?blFtSkdUVURlRmQ2UXdyell0emdjUlgxR3JDb2F4UzVETnBtWWQybDlSU1Nq?=
 =?utf-8?B?MUppMWo4ZFEvUkh4QlAyeDhsSTRCUFNNVjkrZTNMM3pOejJOQitEd0VlbzQv?=
 =?utf-8?B?enlZRXhTbHR4MStmQklXOTZDTkRBOEJFeHh6clFNdU8zS09vVTl4SnNRWno4?=
 =?utf-8?B?Uy9wTXVNR2NiNVdaMzdWeW9sL2pqbDYzTFlMdndBcnFNakI2RXBtSEZFUmx0?=
 =?utf-8?B?Z21Pd2V3a3NNekRQbmNyYytFNkZLcnNPVTFJRlZKWWVFdGUzV2ZIdWx0MjR0?=
 =?utf-8?B?MmFCV0tDS0FHeUVQZ3o5ZDdYaFEyeGgyRzBxS1dScncrQnh5bEY5SEQzTjBj?=
 =?utf-8?B?eHZ1QWo2cWFYd1JMMmhKY0dyMzFLYUgwTDlBU0JLU09IZ0greDdCNHFDQmNW?=
 =?utf-8?B?eGJuTnZCNVZRWmxld0ZXK3dIb1YreFZ0S3FlQ3AxSkpjMkt3NjREK3VrQjhH?=
 =?utf-8?B?SUZhdHZuaHVFWmEwY0huVHZsbTBMaXZQL3ZUZzRmSzRKRU1KTU5tWEZnOTNW?=
 =?utf-8?B?TWlYSG1nZ2pJZkYwUXllRU9rRVRLL2hMcFdkT3p5Vm50TFNRSGE0M0hWZDBP?=
 =?utf-8?B?MnNwRzdyclBFVEF6dmt6bDdNNkVzSytmbk84aXZmZjhBUDdhZkEzRkpmNHcz?=
 =?utf-8?B?dDRkWWhrbTg5K0xNU0lpMk1rMzZ6aDdHYUxxclB3T2JrSkZLamc5MkthNWFB?=
 =?utf-8?B?U2xpa0c2OEZzWW1CR2hZZGs5aER6ai9ibXRvYmd4eEVKVkx2TlFyRzNJSHlX?=
 =?utf-8?B?aGNoMGVjempXTzUrNUtaR1NPTkZ3UmNjZmt0NUNvaUl1ZFNURFFYUlVkV0Ir?=
 =?utf-8?B?NmRGTzRkM2dta3ZMb2tTNE12WDJWT0J6Q2JUNHFqek44LzU5UzZNbW5rU0dY?=
 =?utf-8?B?WmVUMmdlR0svbkFNak03QTN3R2RpSVdteVE3d2o2bTRXcDNRRkN1Qk5pUE9I?=
 =?utf-8?B?NWtvd0VRMVJpeTY5UXlNMFExSFBGSFRkTWFpQlFmaUZ5RFZUdFZaVVJyYm1Q?=
 =?utf-8?B?emdwY0xoZXRIaTc5cUtJbTJhVGJqejRmK2NpU2hqR0xHNlFwM21wMkFwQ0dI?=
 =?utf-8?B?Z3RQU3Z4UDExZzJuM25ZOGpwemFhSUF0bllIZWdaeW1oQkMzQ2tnRFJlbEkz?=
 =?utf-8?B?RDR0Uzc3ME9helpXRlBlNlhoZW9PbjNoZXNDN2VPakpOT0hGaVhhMktJVTFx?=
 =?utf-8?B?UW04K3YzZEkzU3dEMHh0WTFLREFkSnp4akUrSUVqcWZkNExLL2VFdlVERkJE?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <35F42446C324FF429EBAF55012A86656@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14de9512-622b-47b8-4f44-08dd4b0f8d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 02:47:12.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rK9ysIkdnXcI70QA1hXujvXyrBjog8w4zUiJwt9uj163LM8/Z8MrDIOcXiEYYSudc8NHPaDZOwdUY90U4yLCJmYFbx+CmO99PRovKBX//g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7850

T24gVHVlLCAyMDI1LTAyLTExIGF0IDE2OjU1ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IE9uIDExLzAyLzIwMjUgMTM6NTYsIENyeXN0YWwgR3VvICjp
g63mmbYpIHdyb3RlOg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3Rh
bC5ndW9AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIC4uLi9tZWRpYXRlayxj
b21tb24tZHJhbWMueWFtbCAgICAgICAgICAgICAgICB8IDEyOQ0KPiA+ID4gPiArKysrKysrKysr
KysrKysrKysNCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZW1vcnktDQo+ID4gPiA+IGNvbnRyb2xsZXJzL21lZGlhdGVrLGNvbW1vbi1kcmFtYy55YW1s
DQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21lbW9yeS0NCj4gPiA+ID4gY29udHJvbGxlcnMvbWVkaWF0ZWssY29tbW9uLWRy
YW1jLnlhbWwNCj4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWVt
b3J5LQ0KPiA+ID4gPiBjb250cm9sbGVycy9tZWRpYXRlayxjb21tb24tZHJhbWMueWFtbA0KPiA+
ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmM5
ZTYwOGM3ZjE4Mw0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktDQo+ID4gPiA+IGNvbnRyb2xsZXJzL21l
ZGlhdGVrLGNvbW1vbi1kcmFtYy55YW1sDQo+ID4gPiA+IEBAIC0wLDAgKzEsMTI5IEBADQo+ID4g
PiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xh
dXNlDQo+ID4gPiA+ICsjIENvcHlyaWdodCAoYykgMjAyNCBNZWRpYVRlayBJbmMuDQo+ID4gPiA+
ICslWUFNTCAxLjINCj4gPiA+ID4gKy0tLQ0KPiA+ID4gPiArJGlkOg0KPiA+ID4gPiANCmh0dHBz
Oi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tZW1v
cnktY29udHJvbGxlcnMvbWVkaWF0ZWssY29tbW9uLWRyYW1jLnlhbWwqX187SXchIUNUUk5LQTl3
TWcwQVJidyFtenRZZk4zbjZfSUF4NzhTNDRQRk9ldFFTNTEtaDZvYm0ySEhyakVWUkktSEpZeXpK
MlZXYmJpazJybjNweWJzc1VCT1Q0Z3A1R0Q1LU1nayQNCj4gPiA+ID4gKyRzY2hlbWE6DQo+ID4g
PiA+IA0KaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9t
ZXRhLXNjaGVtYXMvY29yZS55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYnchbXp0WWZOM242X0lB
eDc4UzQ0UEZPZXRRUzUxLWg2b2JtMkhIcmpFVlJJLUhKWXl6SjJWV2JiaWsycm4zcHlic3NVQk9U
NGdwNUFHRTVFY2kkDQo+ID4gPiA+ICsNCj4gPiA+ID4gK3RpdGxlOiBNZWRpYVRlayBDb21tb24g
RFJBTUMgKERSQU0gQ29udHJvbGxlcikNCj4gPiA+IA0KPiA+ID4gQ29tbW9uPyBJcyB0aGlzIGEg
cmVhbCB0aGluZz8gUGxlYXNlIGRlc2NyaWJlIHRoZSBoYXJkd2FyZS4NCj4gPiA+IA0KPiA+IA0K
PiA+IFNvcnJ5LCBteSBvcmlnaW5hbCBkZXNjcmlwdGlvbiB3YXMgbm90IGFjY3VyYXRlLiBJdCBo
YXMgYmVlbg0KPiA+IGNoYW5nZWQNCj4gPiB0bzoNCj4gPiANCj4gPiBUaXRsZTogTWVkaWFUZWsg
RFJBTSBDb250cm9sbGVyIChEUkFNQykNCj4gPiANCj4gPiA+ID4gKw0KPiA+ID4gPiArbWFpbnRh
aW5lcnM6DQo+ID4gPiA+ICsgIC0gQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNv
bT4NCj4gPiA+ID4gKw0KPiA+ID4gPiArZGVzY3JpcHRpb246IHwNCj4gPiA+IA0KPiA+ID4gRG8g
bm90IG5lZWQgJ3wnIHVubGVzcyB5b3UgbmVlZCB0byBwcmVzZXJ2ZSBmb3JtYXR0aW5nLg0KPiA+
ID4gDQo+ID4gDQo+ID4gT2theSwgcmVtb3ZlIGl0IGluIHYyLg0KPiA+IA0KPiA+ID4gPiArICBU
aGUgRFJBTSBjb250cm9sbGVyIG9mIE1lZGlhVGVrIFNvQyBwcm92aWRlcyBhbiBpbnRlcmZhY2Ug
dG8NCj4gPiA+ID4gKyAgZ2V0IHRoZSBjdXJyZW50IGRhdGEgcmF0ZSBvZiBEUkFNLg0KPiA+ID4g
DQo+ID4gPiBTbyBub3QgY29tbW9uIGhlcmU/DQo+ID4gDQo+ID4gU29ycnksIG15IG9yaWdpbmFs
IHRpdGxlIGRlc2NyaXB0aW9uIHdhcyBub3QgYWNjdXJhdGUuDQo+ID4gDQo+ID4gPiANCj4gPiA+
ID4gKw0KPiA+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ID4gKyAgY29tcGF0aWJsZToNCj4gPiA+
ID4gKyAgICBjb25zdDogbWVkaWF0ZWssY29tbW9uLWRyYW1jDQo+ID4gPiANCj4gPiA+IFRoaXMg
aGFzIHRvIGJlIFNvQy4NCj4gPiA+IA0KPiA+IA0KPiA+IENoYW5nZSB0byAibWVkaWF0ZWssbXQ4
MTk2LWRyYW1jIg0KPiA+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICsgIHJlZzoNCj4gPiA+ID4gKyAg
ICBtaW5JdGVtczogOQ0KPiA+ID4gDQo+ID4gPiBXaHkgdGhpcyBpcyBmbGV4aWJsZT8NCj4gPiA+
IA0KPiA+IA0KPiA+IFRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiB3YXMgaW5jb3JyZWN0IGFu
ZCBoYXMgYmVlbiBjb3JyZWN0ZWQgaW4NCj4gPiB2Mg0KPiANCj4gDQo+IFlvdSByZXBsaWVkIHRv
IHR3byBtb250aHMgb2xkIHJldmlldy4gSSBkb24ndCBoYXZlIHRoZSBjb250ZXh0IGFuZCBJDQo+
IGRvDQo+IG5vdCBoYXZlIHRoZXNlIGVtYWlscyBpbiBteSBpbmJveCwgdGhlcmVmb3JlIGlmIHlv
dSBoYXZlIGFueQ0KPiBxdWVzdGlvbnMgSQ0KPiBjYW5ub3QgYW5zd2VyLg0KPiANCj4gUGxlYXNl
IGltcGxlbWVudCBlbnRpcmUgZmVlZGJhY2sgb3IgZGlzY3VzcyB3aXRoaW4gcmVhc29uYWJsZSBh
bW91bnQNCj4gb2YNCj4gdGltZS4gSWYgc29tZXRoaW5nIGlzIHVucmVzb2x2ZWQsIHBsZWFzZSBt
ZW50aW9uIGl0IGluIHRoZSBjaGFuZ2Vsb2cNCj4gb2YNCj4gZnV0dXJlIHZlcnNpb25zLg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KT2theSwgZ290IGl0LCB0aGFua3MuDQoN
CkJlc3QgcmVnYXJkcywNCkNyeXN0YWwNCg==

