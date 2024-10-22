Return-Path: <linux-kernel+bounces-375484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C569A968D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D52A283FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE8813A868;
	Tue, 22 Oct 2024 03:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="t7VKXwb3";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="G/4zaYFy"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1218450E2
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566650; cv=fail; b=AdoowDYRS+VEvM+igCSiRPsTXefxpkIGEWVnpnKmUpwym0St+34CNxuDXFKXk9SQQ7S1n9CFG8eG+bgZpNBgSj94/zsnwtDkzXYMOIj/do0acDs1SlJ4R00AJeqn/4XVmK0z8BTlV0rfu0TzC9ru0puRnWLoC23nCFLh0QF3c7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566650; c=relaxed/simple;
	bh=YtYNn/SMFpmRmfYn9aFM6Uu/kn86GT12U2kbQkb+gfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KEWdjQwG4u3WKQamv5qGsUfQjmZppfFYIjMIV/2MzXyGoocv5GO6jvt3D7n3VySF/I/NSVZxdtPZUO8aUjWgZbQ+a9imOhy5ul41HVaFe5ril+IhB39JzH4bVhtAGaTDB1tTLW+GqukRbpTmX+jRpbZJiqpr3Odi2U0+oHJ8wDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=t7VKXwb3; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=G/4zaYFy; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 37fbd4d0902311efbd192953cf12861f-20241022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=YtYNn/SMFpmRmfYn9aFM6Uu/kn86GT12U2kbQkb+gfI=;
	b=t7VKXwb3qrKrWNci3H+qj+blLX6UpOCy3nS9pLvrCBiFQWWqrWKmUjgVkLaHUMEIdYuZnfBfFNdn0DFTU9ZwnDTvO/+qqaM5ri5K+e2B2No1LnQMNleOA/IbtRauqHIvwuuBZ5ZFllqyNSspmViRkJ+nAhOb5lD9fH3P4k7bTfo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:464a6a83-f0af-40c8-b820-ec3fb82adb5f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:43b26f25-9cd9-4037-af6e-f4241b90f84d,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 37fbd4d0902311efbd192953cf12861f-20241022
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <liju-clr.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1304433249; Tue, 22 Oct 2024 11:10:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 22 Oct 2024 11:10:38 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 22 Oct 2024 11:10:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ddTX9YlU6+l/ny5gCBsoQ3HpcCbXtxLIMA0PLaK9ja5aRHpobb80dBdc/h59t4/fKVqA5KWYVguMCDl3//mpnCGUq2nDe06lvM4nkuBdF6gqo6SeIuIrapAJSJYAT+2E3aGO3lCIZQvXMq/uBaF74DAh8XU14bFOc7UG0PDFQARDn+ugJMmP8KaHszE5bQFJYe1mBcVW0Si4OKkd6I1kLhMic7W17BdBze76HRkktHEC2nf40ZNvTtFW3dxdFVVNZJI85QwDot9MwQxFwU4+DbEexcVcCD+hpsxqN26HC8b2yD5H6+KxFxPLx047xTnMNgXNOlzx6LRhYxxSnnZtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtYNn/SMFpmRmfYn9aFM6Uu/kn86GT12U2kbQkb+gfI=;
 b=LwH4wTOW1qKnUEnBQjwmrKPNjelxR++Rcb+T2UjkxQhHfa7dgtCsDGsAbeMSO55lV8FBocz4qen+L7bIHlXGLq5cTd4sSp45cH7OD90NEB0tV9+WPCfSTKfHJyARiFFEh6QcOjjgAbLk8/L8JOvNZiFDSxNtGBZJwdXkczaQJz9Q6NX2okUbCDnwczFiRtC0/DXo5wZLCJCNaCIl24TkdPULZE0Iz//1p+To0YTjYY5MWhTf7n/SJNQ31Ek1WkISB1XP6QqX9+NAXtlsBW1d4o6N38G227f1wkoWsv8/sswMbJl6zYckw+iBmW1iCRhOkBacf3mjCqA0ux5/kY5nLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtYNn/SMFpmRmfYn9aFM6Uu/kn86GT12U2kbQkb+gfI=;
 b=G/4zaYFyYyVQditJp1ODiVAbg1/INFWkecfoXKvlpfduBQuwffv3Gc96zmWfkRNVeji0P8WJiWikLDDS2ZDpLBn9L7F3pTdKy9FZ/PluHR9t7K3RaV6+9WN/5g5KwKNDiRBqbE5f+3JAyHPvOlt1xzOcQTMaHPnA0BCGix1Vzqc=
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com (2603:1096:101:19a::11)
 by SEYPR03MB8744.apcprd03.prod.outlook.com (2603:1096:101:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 03:10:36 +0000
Received: from SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac]) by SEZPR03MB8273.apcprd03.prod.outlook.com
 ([fe80::f7ac:70cb:3cb4:acac%7]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 03:10:36 +0000
From: =?utf-8?B?TGlqdS1jbHIgQ2hlbiAo6Zmz6bqX5aaCKQ==?=
	<Liju-clr.Chen@mediatek.com>
To: "hdanton@sina.com" <hdanton@sina.com>
CC: =?utf-8?B?WmUteXUgV2FuZyAo546L5r6k5a6HKQ==?= <Ze-yu.Wang@mediatek.com>,
	"will@kernel.org" <will@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	=?utf-8?B?WWluZ3NoaXVhbiBQYW4gKOa9mOepjui7kik=?=
	<Yingshiuan.Pan@mediatek.com>
Subject: Re: [PATCH v12 05/24] virt: geniezone: Add vm support
Thread-Topic: [PATCH v12 05/24] virt: geniezone: Add vm support
Thread-Index: AQHa4loNGrJm9VnvXka5HcmpuyIq1LISPI4AgIBeqoA=
Date: Tue, 22 Oct 2024 03:10:36 +0000
Message-ID: <42e9b46219d8840f1f834092e58d54e8160fb414.camel@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
	 <20240801105032.2533-1-hdanton@sina.com>
In-Reply-To: <20240801105032.2533-1-hdanton@sina.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB8273:EE_|SEYPR03MB8744:EE_
x-ms-office365-filtering-correlation-id: be9cf497-f74d-4822-cbf4-08dcf24719b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZnNXLzY1WktzdmM3NHRKWXY0TlZ6ZktEQ0paVEFnNXRGSW8yalpXQTh1eVAy?=
 =?utf-8?B?cmNMSHB0ZXZFZzgwM05JK2Q1UzVmbkNYZ3NaUUh4clA3ajljdkdrQ2ZkR0tu?=
 =?utf-8?B?NGNNZ1dWcTZHaldxNHdydlBYTFVDQTUzR3kyUkdlVkRURmpLL0NVSTFLSlJx?=
 =?utf-8?B?NEpCajRDUllZM2FiZVZaNmtOd0s4RU0rbStVbmpIRmxxc0JGYzVMWGsxTnBN?=
 =?utf-8?B?VUdEcjZULyt3RmNBVEt6SWRRMy9Ta2Ezb29qaHdQZzRvcU5QTGorWUtCc28z?=
 =?utf-8?B?T1BtS3gwUHFkMDdBc1VMWTBRTUFPRVlpWmVlSS9yKzVISGhJck9DK2FHK1NE?=
 =?utf-8?B?cXdyd1dlMXl2OUNvQTZySUNzYzNmV0lKaVFwaThodXR3Wm9HZWd2U3pHdDVI?=
 =?utf-8?B?cFkwYjN0Z1dzbzJ5UDBoU2VKZ3E5OVhBbzFBbUh1QitESFRZZXpYL2hPOTJJ?=
 =?utf-8?B?SWl3U1hZVVUyc3hiN1I0MTdLdHJuMjd6NVN3WkdRditERDg1bjM4Q3g1cVZW?=
 =?utf-8?B?bU90aEtVYS9OMzBCQjJLb2tPZ1c5OVR2YU1IMEc2R0VQQXVGVFlMRCtKRVd2?=
 =?utf-8?B?TTVxeFNRZFBLZUJScTVId21zQ2FWRHQ4Z2FiK0pmUFJ4TTFuQmhtRkJVa3ls?=
 =?utf-8?B?U0lKaDZxcFo1TW1uVkRjTzYrNFJSVmNrc2h0QlpKTVltL2ErZkIwWENXQXZJ?=
 =?utf-8?B?THBuYitPNFo1U1BiKytJWEtIVmplUjMzN1B3VHhiaXNKazI4Y1ZqQ2lFb2tZ?=
 =?utf-8?B?T1BFOEUvMHI1TDN4SkZXNlJ1amZORGdSanBvbjNWWGJ3bU1XRFQwdWNNdGhV?=
 =?utf-8?B?aGNVOFllZ2J1d1BuNzhQc05VOGZxOWdGQVg0Z2JvWTNjMGlMYjI3UTdVSXFk?=
 =?utf-8?B?dm16NEUrSDZEMVdsSUxLTy9PVkhESnZpTjZDTUtHK2YxVTBoNkM5NEcvTjRm?=
 =?utf-8?B?aCsrQUxLQ2N6YlV5U0NUTXVxd0s4b1oyS1VOblpReU1PRTZyckJFUGxoa3d5?=
 =?utf-8?B?RTArQzd6VU9KNUZHNG9HY0VMaytFaUpKT2c0Qnp4UjU4RWtiVUxxVDlrWVNw?=
 =?utf-8?B?MlZWdTkwdVBKS3UrNDdPWUh6QTFiUitkWDNlQ0E4Y2Y1V21TaGkxVzRoRFlk?=
 =?utf-8?B?TG44K3RTbTAyaWNHMUNheWwvaTBiNlo1Y2lpcTUyclRUYzNCdFA5V21oL2k4?=
 =?utf-8?B?VTJwVE1NUjNZbk9hZXpaQ3BlNmg5cVB5NzlYcEFBU2haRWhxOWVnVzMyV3pY?=
 =?utf-8?B?NENWUnJiK0h5c3VIY0tLK1ZVYS9DQnFYeW14VWY2WHRkeFVsWnhkRzhmblVY?=
 =?utf-8?B?b0Q4R0w2Q2hBcVlhUHdpWXpzQldMdWJhdGtKQ1RtN0ZSSGlqc3BJMmJIS3VD?=
 =?utf-8?B?N1o5V2NUenFIWng1OXJQRFZ4RXNLZzVpVDNPaEJJbGtDejZpNnFCTVM1S0xG?=
 =?utf-8?B?am12bFhSay9ZSkFmZ0xHYlAwSjhpZXVacW9YREhjS0luc01MdGI0MUZyMzJL?=
 =?utf-8?B?R2wzZDJzN2w5SUVOSVFEYWRpa2JhajdYT1NzVUVnSmJTN1lIWEZ0bFFCR3ZN?=
 =?utf-8?B?T3ozZ0hDc0cyY0lrUkplVFFmL1FDaUdQaDJlUUdRTFBjTGluU2RKQjNPUEpi?=
 =?utf-8?B?SDZJVUs5ODc3dGNxbHJkUlM3OHpBMFpUemFTY0I3aVVTeGFQdnFoWmNhOGgy?=
 =?utf-8?B?ODRIU1hjcVJWNDc1bDBLUUFLeklzK1Vtd1FMN1M0QkJJVDFaU01EQ2dyUHNH?=
 =?utf-8?B?Q0MyRldXVklNREUyQWEyV3R5QjhVWXFiTlZuTUpsNkpmUUxFLzBlRE5ZbGhh?=
 =?utf-8?Q?Z9BJYvQeGMg/Rro566SJB8b1ryB109/JSR/+4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB8273.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajRVOXcySG8rY2lYVmc1Z2hvOGRabTVqYzkyREcxTjB3dHhLWWljMzBnRUw5?=
 =?utf-8?B?RTRGWUFVY0VUQ2MvVFMxU01PY0F4Z0E5TnlDMmkySXZoTk93OEViWEJ4cFlp?=
 =?utf-8?B?a3k0RFoxeVdwSmRNS1lDTWlSL1hwWmpmU0pKTWdvT2pYcUJtcUV4Q2JGbGcy?=
 =?utf-8?B?MUlvVGxwUmhwejJXb0FJR1puT1MvVmkzcE5JRkJHOU42MUxCVW5ZT3hNWlJO?=
 =?utf-8?B?Ni94MkZBSHQ5VE9WZVFkbS82enpsT2pTRzduQTV3Z2hOWTk0bEpRYzV5cE9L?=
 =?utf-8?B?ak1qb3lOK2pFN3pzMCtJcms2a0xrdFl4UlJyeEQ5dC85K2NaQnQxdWpqVE52?=
 =?utf-8?B?Q2JQcU1DK2VUeWVaM0JtcnNOVDRVWjY2NWM5L1lNSWVVZ0gzRDdScUhaZ1k3?=
 =?utf-8?B?QnRvaUQ3dGpvV3hoRllXT3dmUTNJWDJ5WDAwSUp0eVdrSWU3alF0dTB1Z3Fr?=
 =?utf-8?B?algzN1o3VE9NL2hlQkd3U0pMa0YwMUxCK29TbnB2b3NSYjNnTVZQMmthWDhm?=
 =?utf-8?B?MUJaT0NEWFBPajFqY3orNFJtKzYrUGxiTWZyckxMTWJIMnBCUUVJbXdzYXBJ?=
 =?utf-8?B?OVY5U3ZPazBMTUtycW1pL1B4RE1oQWs4amJlL0l0UXAzcC9DeE41Q3Z2SU9H?=
 =?utf-8?B?RGo2ZlJqZUlhbit4dm5DeW9qM3VQSk9haHpYeXZzR21EQndlQWcrZzVQbXdp?=
 =?utf-8?B?eTFWTW9lWGU5TVZ5eFVCV1E3UXZLa2tXWk9qTC9HaG02RGdaSUdTVXljVk9m?=
 =?utf-8?B?N052M1YxWDYzNkhQWkFDN2VCeEpROGdMcGJieEU5T1RzL2thOWgxZWdPbUxp?=
 =?utf-8?B?VmlJNEtrS0c3NUJrTXN6elp5WVB6ajU2VURHajBQWlN3WmJzckFCRE02d1E2?=
 =?utf-8?B?b3BnR0dKdVE5MmZZa0F4S1hKNDE0anZIUTljOXJpdzVvN2h4Y1ZPMU05ZGRo?=
 =?utf-8?B?NlJPOHVkZU10cG9Ud0pVTHVIMkNPd2dvd3YzbjJrTGxZdWlYd1U3RVpDV0hH?=
 =?utf-8?B?UENPcHIrRmpUWnN1bWRkdVNGNjdvQStBZmpYVWIxVWUyeGlMQndEK1VtRkpB?=
 =?utf-8?B?ZnZWbS8xVWFRL2w5L2xiTGp0SGFwcXAzbW1HVy9oYTQ5Z3luQUZMZi9zVkZM?=
 =?utf-8?B?TzdIbFR5V0MxcnRzK0tKWTRHdldsemtXVlNYRENWdFo2VkFwRW8xSHVqZDR6?=
 =?utf-8?B?YW0vM1FUNFdPTW5nZ1hFTHFQQXFoSXVMV0orN3pncFRybUhQOUJMMGJZeE9D?=
 =?utf-8?B?dUxZdXJrMTgrZnMzRlVXOE1aQkRiUmRhclY0UXRzVUNBbHorbTYzRUxJRXlJ?=
 =?utf-8?B?MVdFdDhtc01Vb3hsSDBpNExXMzU2M2x0a29mVzBQVmxIR21hb1RhK0EwZU93?=
 =?utf-8?B?ZUg1b0tqK0NTa09mRU5hSFVGNms3M25GdFNyRUx5RFN1cFVORU5XeFpmeTZs?=
 =?utf-8?B?b1FDNktVL1pCbnM3d0ZDaWJTNHNmam1sS2lwME0rakpaSS9keHZESEllVjlv?=
 =?utf-8?B?TzF0dDNPT3FieGl1NTV4VHlJTE9Qb01hTlAyVFZ1SFNXTEU1WGpTWkFSL0VE?=
 =?utf-8?B?SmlMOVlTMGt4SjhvTlVTNnNFZW9ZM3ViSkRvSDJkUnVXelk4SjRGS0hQSWxS?=
 =?utf-8?B?QisxWkp6ZndVWm1GcGRLQm1JeXYzcnROVEN2ME1ZRTZvbzdNMVJvV29IeTNs?=
 =?utf-8?B?OUR5cTU3TDhDZEhxY1BVMHFzNTlOcVBjMXBZU0o0enJHc1VWQm5EMnJIVlFF?=
 =?utf-8?B?NHhRU1BSY3dzdFI1K2ViQ1Z1allIR3B4MFFIa0tXZHlid0JNQkZUeS93eVVn?=
 =?utf-8?B?SS84Qjg1WHc2bmdQT2hqU3BpM2ZDN3VZYlMxYUUwMC84L3c5WWxlbDJFVk1Y?=
 =?utf-8?B?VEs0ckVoYTJjalF6WHZSRzExempVQ1dCLzVYdE1rRzNNYzZsTUIwVHU5Vy9m?=
 =?utf-8?B?UDlYaVZ1S0VOOS9rVnNzRm10b3kzYlpuWEwwMlNTVDVsOXR2RXpzaHV2OGVh?=
 =?utf-8?B?TTBHM2RUcFIvSUNVL2paaVM3SzE1ZlloeFEzTGNwaTVhUFprY2R5dlZJV2Vp?=
 =?utf-8?B?UGlBdmgyTldpMEpaMEt5VzFjb3kxcHFsM2IwYW10eTV4aTcwemE4WG1oM05H?=
 =?utf-8?B?ZFhJTGpVaUs3bjZYcU4yWDd6WUNKUGlEbUZmbk1DTllYMDhYRjVuSTJYeDU5?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B98D548BE4CE0D45BE4262BFC244D774@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB8273.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9cf497-f74d-4822-cbf4-08dcf24719b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 03:10:36.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6mlxLhJn1hjMjUQW100dtk6uF4QXLKnfjVMCWenJrdxadbxT/oLYY0is9xRZixZltBiLiTrm7N4UwoQA04LIIfSFZX79OT3cm5YhyM4MnoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8744
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.962400-8.000000
X-TMASE-MatchedRID: ge9e+QLSeazUL3YCMmnG4ia1MaKuob8PCJpCCsn6HCHBnyal/eRn3gzR
	CsGHURLuwpcJm2NYlPAF6GY0Fb6yCpGpaLcbZyfwdrnuu4cCcfF+Mk6ACsw4Jj6DYdLKc78CTx9
	jhIf/nmzT01A2vEikVmB15W8F6q39znpxIN8T92ccsSroYI5AVjGZtPrBBPZrMxVjmK1sOgNE1U
	KEKJPuReLzNWBegCW2PZex/kxUIHWNo+PRbWqfRMprJP8FBOIaA/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.962400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4FA544808A3367FB959A3C714D718EE8A077AE4F18D3D9F3F9186B06E41B8FAC2000:8

T24gVGh1LCAyMDI0LTA4LTAxIGF0IDE4OjUwICswODAwLCBIaWxsZiBEYW50b24gd3JvdGU6DQo+
ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiAgT24gVHVlLCAzMCBKdWwgMjAyNCAxNjoyNDoxNyArMDgwMCBMaWp1LWNs
ciBDaGVuIDwNCj4gbGlqdS1jbHIuY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtzdGF0
aWMgdm9pZCBnenZtX2Rlc3Ryb3lfdm0oc3RydWN0IGd6dm0gKmd6dm0pDQo+ID4gK3sNCj4gPiAr
CXByX2RlYnVnKCJWTS0ldSBpcyBnb2luZyB0byBiZSBkZXN0cm95ZWRcbiIsIGd6dm0tPnZtX2lk
KTsNCj4gPiArDQo+ID4gKwltdXRleF9sb2NrKCZnenZtLT5sb2NrKTsNCj4gPiArDQo+ID4gKwln
enZtX2FyY2hfZGVzdHJveV92bShnenZtLT52bV9pZCk7DQo+ID4gKw0KPiA+ICsJbXV0ZXhfbG9j
aygmZ3p2bV9saXN0X2xvY2spOw0KPiA+ICsJbGlzdF9kZWwoJmd6dm0tPnZtX2xpc3QpOw0KPiA+
ICsJbXV0ZXhfdW5sb2NrKCZnenZtX2xpc3RfbG9jayk7DQo+ID4gKw0KPiA+ICsJbXV0ZXhfdW5s
b2NrKCZnenZtLT5sb2NrKTsNCj4gPiArDQo+ID4gKwlrZnJlZShnenZtKTsNCj4gPiArfQ0KPiAN
Cj4gLi4uDQo+ID4gKw0KPiA+ICt2b2lkIGd6dm1fZGVzdHJveV9hbGxfdm1zKHZvaWQpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBnenZtICpnenZtLCAqdG1wOw0KPiA+ICsNCj4gPiArCW11dGV4X2xv
Y2soJmd6dm1fbGlzdF9sb2NrKTsNCj4gPiArCWlmIChsaXN0X2VtcHR5KCZnenZtX2xpc3QpKQ0K
PiA+ICsJCWdvdG8gb3V0Ow0KPiA+ICsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShn
enZtLCB0bXAsICZnenZtX2xpc3QsIHZtX2xpc3QpDQo+ID4gKwkJZ3p2bV9kZXN0cm95X3ZtKGd6
dm0pOw0KPiA+ICsNCj4gDQo+IFlvdSBhZGQgYSBma2luZyBkZWFkbG9jayBieSBpbnZva2luZyBn
enZtX2Rlc3Ryb3lfdm0oKSB3aXRoDQo+IGd6dm1fbGlzdF9sb2NrIGhlbGQuDQo+IA0KDQpIaSBI
aWxsZiwNClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIGFuZCBmaW5kaW5nIHRoZSBidWcuDQpJdCB3
aWxsIGJlIGZpeGVkIGluIG5leHQgdmVyc2lvbi4NCg0KPiA+ICtvdXQ6DQo+ID4gKwltdXRleF91
bmxvY2soJmd6dm1fbGlzdF9sb2NrKTsNCj4gPiArfQ0KDQpCUg0KTGlqdQ0K

