Return-Path: <linux-kernel+bounces-405751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C96F9C57BA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3E29B32CEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D5023099B;
	Tue, 12 Nov 2024 11:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c7Eb+fqL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EaRVfYwZ"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8412C23099F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 11:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410739; cv=fail; b=YN4aotnJacMPZ950KLp+6MKynAyIZiPA5Fk7HJkTUaadTLu2y2cNSPdL8EQ4hV9Ag/7KLZ7NWz9iRnzpCMPJLR3er6Xx1IMvMzPJ9J/LCd2Vo49p5VycgrIX3NXwUUFTprAfrQZA+AJQ9p8lZoDeXqXoTm+y+r43e/7XT8AQMjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410739; c=relaxed/simple;
	bh=BVDjffzhPl4VLnBmIoi6kQZZnn7fiHVBqCSJxjNcoPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DwUrS1t6U4YIRUyEGLLFpASCEwVrS2Yer8L9wze6LR0G51yASzH+RfEQ8HRXwKv3cfRHd6NuADXAEv4pCY+xV/vW5OjTlYxsESqXboOnOjrXrXm2ybahYEhU8tkFMo/oM+VBE7XOnLU3V8/s8JNZxsZM3EAUblIB8ziXFi4Y/C4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=c7Eb+fqL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=EaRVfYwZ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d3bf11eaa0e811efbd192953cf12861f-20241112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BVDjffzhPl4VLnBmIoi6kQZZnn7fiHVBqCSJxjNcoPA=;
	b=c7Eb+fqLWbNcNtScVMhSZdTy9ZjYsLQL0Jqvfj7hITpG8fNiJ0t4etf2T5nbExAKa26S/RucpxxzZdaj6GAeBT13OwHWwx6X6qX/QKycS+68aiMb8+XUIHW/zHY6S4vY2LAPClx1CfsorX1Lc0JeglChwc6Df99ja7T1jmPwN+U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:9d416f04-0264-4a3c-a332-65b7605cd87c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:3c4cecca-91e6-4060-9516-6ba489b4e2dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d3bf11eaa0e811efbd192953cf12861f-20241112
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <skylake.huang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 952186673; Tue, 12 Nov 2024 19:25:31 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 12 Nov 2024 19:25:29 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 12 Nov 2024 19:25:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLd6QEbChTDqxzZC2wukrSrOZYqHvOvJB68oX5owwpmS3AzFrhCBeZdMd6RQYdJFlLVMuPODTrt5DtacI1zpgE9KAY37vn735YFsbNvVR52HCc28nPiMNd2JHM0frKVwE+9wmI/vTsf95ZC8c4/PT5NJqX805pnxc+rt3ABCWuI1VD0azJ30YOiZ4nE1WtzdnJVGpqTEa8Am1S+UYo7tBwKvWqQtdpvNPo63veFopJggh6zm9uRJa3lnZ+w9VNF/vDLJoNrQfFW2QWV3cUx4IqjHisKt5+F5FJSWuNPLxOVt1UuBhIuMZo6djn0B3APLvP5+cTV052ZUPigB8bRmjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVDjffzhPl4VLnBmIoi6kQZZnn7fiHVBqCSJxjNcoPA=;
 b=WYmMUGKKZmVSqWW1wD5kt4MSykbjaThXwt7n6e7py4GXzIegfUnClMbomOZn8BPEhXD3OFWGT0XPZYfg67BIMEUkYn6Vy9EHzBYvbj/3ZWAkH/EM3Vpxd2oWKkny9atTRSD6ePvczh6Wxz+R1hb/U61TvfuwZKxYpa2oi33ZsVM6uf96tiOcYgOQXtSoZroDJG9H5tWVyqcuUp2bKbI4YEnitxKpVcpdm/SFGEqUrIiTsqPwjUrN22KuI/bOG2hs11GcHG3XRlLGea7Y5UH4YUdyCvHpjvP/MexZczJK8UOrPO+S2NVSRemgEz0fAqp10XK6D6Vby8bYqD/+gOjWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVDjffzhPl4VLnBmIoi6kQZZnn7fiHVBqCSJxjNcoPA=;
 b=EaRVfYwZPLPp6bt2zf4s14tcJyDtLkm+z/cVBnqd0VP/5L8O7ae6SdKg9z22ppaW2SzG678VmEVz09EJBo6/RBAtr+GQYbCygqzS1nsvR3/CQuFJgT2dmQWXyMQ2hTXOiqxqtNgtnCBKb1XerLVvjd8FXpeZheJyVfBF2SJqxyg=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by TYSPR03MB8720.apcprd03.prod.outlook.com (2603:1096:405:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Tue, 12 Nov
 2024 11:25:26 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::f3:c11:8422:7ce3%4]) with mapi id 15.20.8137.022; Tue, 12 Nov 2024
 11:25:25 +0000
From: =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
	<SkyLake.Huang@mediatek.com>
To: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"mmkurbanov@salutedevices.com" <mmkurbanov@salutedevices.com>,
	"kernel@sberdevices.ru" <kernel@sberdevices.ru>, "d-gole@ti.com"
	<d-gole@ti.com>, "dev@kicherer.org" <dev@kicherer.org>, "gch981213@gmail.com"
	<gch981213@gmail.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "richard@nod.at"
	<richard@nod.at>
Subject: Re: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
Thread-Topic: [PATCH v2] mtd: spinand: add support for FORESEE F35SQA002G
Thread-Index: AQHbNOrToR8/CnEAIk6bN9gkcdT1vrKzd0YDgAAKBIA=
Date: Tue, 12 Nov 2024 11:25:25 +0000
Message-ID: <12f4d28f3efb7fe319ec919df92145c4ad24da01.camel@mediatek.com>
References: <20241108163455.885-1-SkyLake.Huang@mediatek.com>
	 <20241108163455.885-4-SkyLake.Huang@mediatek.com>
	 <dbdb45ed1135e73b4eebd76e6f61b96d48aaedc6.camel@mediatek.com>
	 <87ikssu3qq.fsf@bootlin.com>
In-Reply-To: <87ikssu3qq.fsf@bootlin.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|TYSPR03MB8720:EE_
x-ms-office365-filtering-correlation-id: 14e78eff-9561-4004-cd59-08dd030cb418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWhmYUV2WDdVZStMTEh4U0U3NGNiT0ZiZUhTaFU3WDUyUGIwMncyUWpzaUIy?=
 =?utf-8?B?QzNsMmhhdDZycmtRTWVQb1VEamhEclYwelBsSzR1WFViRUhoL1kyWURqNDFh?=
 =?utf-8?B?cExPbjN1bE9xUDNnZlFmN1IwZTM1MUxZYlRLOUM0c2IvMHZrbVlZNGlTVmhG?=
 =?utf-8?B?cWI4M0NQNEJ2R2VZYUlpNlcyOFVlQXRtc1VMeEZrb01Md2oxNzVqMFZhb3pR?=
 =?utf-8?B?eS9DbVBMR05GUWxIbE9aTEVHUjVLTDBmYjI3WDB4ZHpYOGN2WXZYcDJiR3U0?=
 =?utf-8?B?TFNkTHVkc1dvbzhEeFBSUVNJRUxPTnh4RWNoNDRhVEhNS3NvQjlCV3B4L0lE?=
 =?utf-8?B?bjBadkZLVDdqeDgvOXRuSWUzOGZPZXhXNktxbi9HcnV1SElHTFc2SXJTVnky?=
 =?utf-8?B?NXZ6a0cxcnVkOG9pcDBObENEbjhaVnVWQU5rNUZCaWp6VU9sV1g0eHRkc0NX?=
 =?utf-8?B?ZEVxd01xZ3VmNWNuRVpZTTNxeXJFaDdLYitOaENNTTkzRDViSTNKd0tNTXN1?=
 =?utf-8?B?TnNrb2ZReFpsL1A4MGNObjlDRDM2VjB2MkcvMlR1dCtTUzlXUU1wOHM0MFE5?=
 =?utf-8?B?dVVmcGpsWklCd2RlcTc1R3AvemdwZnM4M0d1bHhIVTV2VWh2QkRWRjNvZjZU?=
 =?utf-8?B?MVprVjYyNytvL05zRC92NnMvdUV6dFpKTG1aZGJISkFNOGpLcHJNeHZKbXpJ?=
 =?utf-8?B?SWNGZk4relJPeGlaL2pBQzJLWW96SS9Gc3MxSjNtS2RWcm9FcWRoVXAwYWx4?=
 =?utf-8?B?THFPMjdyQTZENVlwN01WRnlpRG96KzIzL1FtKzYxOFJSRnl3TytEQ3huNm5u?=
 =?utf-8?B?RFB2Uy9qcXkrTU1EcHU5YXNxNHpVSnY0NmwyTU5JTGtlZytIa0F4bmg2QUo3?=
 =?utf-8?B?UEl5eCtqejlZNklOUjNiMk9ZRXJUQjF1eENWUk1kUE1TTjVUUmZsOFVXT3d5?=
 =?utf-8?B?Q01jR1M0ZTJaYS9rcGZZUHp1R2dHMm1OZloxRUs2QmprZ3dod2dIRE1RcmJ0?=
 =?utf-8?B?RjMyUitFaHowQWNEZVViRGJySjlvMUNvbnJpRytuMzhvNUtYYS9nUkNUTVJF?=
 =?utf-8?B?VDhPVVVvUFVHUzVwMGlpWDc0V2hGbWhYa3p2ZXN1TEh6NFl2cjBhY1ZqY1Q2?=
 =?utf-8?B?UHZKU29pallqd2crbDF3ZG5zb0o4aVZlSGI2dFZHbktHZ2t1S2MxZC90NktT?=
 =?utf-8?B?OWVoRzhjeERrTkszKzNXOXZ5RmpaTU50YUNjN1NvdmQxR3Z6bUN4eFpNVnox?=
 =?utf-8?B?ajZtNE0vM3RNcUtUNnNVU0VuSXRVVHJPU1ZSL21lL2ZuY3phVHFmc25XZ3hs?=
 =?utf-8?B?QWgyaGpjTTl0dmhiYklnWEhYNlJNMlI4UkdjZzF0eG5INU9yN0t6MEtpYXlD?=
 =?utf-8?B?UFIvRHRDZ0U4QWpGZ3hhN2ZlNWR4YWMzL1Z0UllqQmczdlY4YVAvRk1FeGJS?=
 =?utf-8?B?bngyYnVyZHU3RXlrc0JXUjJ2cmxCSlNNSmFzOXVJY1Rsb2l2VUQzTmU4M0Fk?=
 =?utf-8?B?UjhkeVg1RmF5SVFlTHlFS2VRTGNnRm1kZjhtM29aMWt5cHlEZDZWam5BcEN4?=
 =?utf-8?B?NTJmUmc5WmlPdWdwQmcyY25NQVFLZ1pZbnY4L0QwQm1mU0lVZnJsOE95OGQ5?=
 =?utf-8?B?TzBSVUZhK2lyWFNFUVZzY1BHOVNxUzdWa0FSSEpQeFJGY2NMUHArQmpZSUx2?=
 =?utf-8?B?QUhWaTQ1eVczb2lJZC9JRVltK1lYWlVJVlByK3FLVkN2Y1BpWlJZSUg1blYr?=
 =?utf-8?B?bjRPSk1lREh1UnBPbTgzaTVma2o5QVVGU0FnbERCeUFkUXFkMGxUbk0xdDFD?=
 =?utf-8?Q?FqPuvHYtvmwDfhxgjnvhdaw5An/YWftdN08E0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUs5YU5kRnE0RENMMVBudkJPMGpjMGFtZjllcFlRNDdTY1JtcEdQZGxFTGRy?=
 =?utf-8?B?bVRBVlZGQ1BZNDlxWTRvSFFTQ0FjaXU2MjJhTU92RkptS01oSXBvMlJZSjFz?=
 =?utf-8?B?Zi9YdVFiRVNMYTRaOUdNT081bjFTUE1xeU54ZVZnODFqbjdVRkZmSXc2MmpR?=
 =?utf-8?B?Rm1vQlZhTU5iNTJBWStJN3JsYXY2TkJKNEQxT0Fjd3o5Wnl0WkdGaklQSzIr?=
 =?utf-8?B?R3p2VEVKbDUxV1FDQkd5dlpoeTIwZEZGdDFrUlJ4TTJpRit6MWRGclViN2pV?=
 =?utf-8?B?b1RxL3p2V2RUZ3lCVTFid3ZUOExiMmlIQ0RadkhqSzlTcUpzUXhlN1dkd0VM?=
 =?utf-8?B?VTYzWmNIWXhCY0xDbytraHFZajd2TzNUR1pCdFhjYXo2bWJjU25ucWowZ2Qv?=
 =?utf-8?B?R3VvV08zd0hXR3ZLc21ZOXR0NmpKK1d3TWNkS0pJSUdRblZKRy8rRHp5dExa?=
 =?utf-8?B?Ynl3US9jRVhrbVlyb21Dc2V2bEpFQ0p3RnVQUk8vSi9CSDkwdVJHNlJOWklh?=
 =?utf-8?B?MmRwRTc2ekt3Y0RHbkd6emNERFNOYlhMcXdnU2JOYVRldFNkdm9KVDVQVHpa?=
 =?utf-8?B?RTI3bGNYUHA3ZnNjSG1xbmc4TURNTWJNb2h3RW5ZM3kxS2tXNHViemtNWmlG?=
 =?utf-8?B?SXFzdE82Wml0MTcyZWYySTVoYmtmZDFPaXZtdjd0R3NLZDdnSDNOVGZWL2sv?=
 =?utf-8?B?T3pRM3dXUjB3ME5XM2o2dkY5MGNURkExWWRWc3RCcElTVXRzc1J4UDRVS2gx?=
 =?utf-8?B?aVNpaDU1SlVoNXVxeWpxYnlEWk92UlFhdGxPTG4vWUJ1NU5BVVFZVUhkaVNM?=
 =?utf-8?B?TGZNUEZsNHJkOW9FME9MZXhUa3M4YVhDKzlqb0wvc2lVazFMZFBWYnp5S3Nw?=
 =?utf-8?B?WDZOTEtEUG50S2RYcjl5RVl5VnBzTjdkZE9OL0RWb3dJRGJMcVVPN3FBQWxU?=
 =?utf-8?B?NS92cGVmTjhtaHRlWHVKbDFJdkZhY1lqM3I1TnFJZHhid2N0Um9QcUdqMnRp?=
 =?utf-8?B?VENHMDFBTDVaTlNtTkE0Q0ZYWVJoeUE0aGRlbkhIODUyMFdSbGxWVjJOaVdJ?=
 =?utf-8?B?QW5JTm9MQWI3WHo2dFd4NmNHRng1NE9ZeVhHcHhQZWNKeHA1UTJVbmFlMm1F?=
 =?utf-8?B?Vm00YjlvSGxNbjNJU3RSb2J6NDdZRjhQbmErR1ZHQzVIaEplZHRWeHkyRkhB?=
 =?utf-8?B?QXVSYmZ4ZG51YXFIWnhibi9hT01seDkweTFxQytvN2djTEtwa1dYSDRzNzFF?=
 =?utf-8?B?M2FORTVQMzZFY25wV2JZdVM3eGQ4SFJ3RzFIYWdMRmdRV256bXRJVk1KUFZR?=
 =?utf-8?B?MldrNmhDenJoMytSYnA4V1VFOUJwUTA0d2pTeFBEdkRIaW4zbGpXT3hXVmt6?=
 =?utf-8?B?NkZPNjlsaEErWkRmVFl0VVNEZS9xS3RnYjdBWTZkU29HeS9sY0FYWHN1amJs?=
 =?utf-8?B?Vkl5UFNRQlhkMzVnMnVSd3hxUDM4L1JxZXdRZTFQbjROcS9vdTMvcDRCenI3?=
 =?utf-8?B?QXNZOFFjcy9lSUVzYlJWdWJ0ajY2SEttYTN3UUZrWG5wWkJoTWVXVUxiQWJj?=
 =?utf-8?B?TmtDK3ppaG8rbXlrdUhra0FzQVpia0M1ZkJnRUxncFAwa1VoMFVxT0lUUzBy?=
 =?utf-8?B?N1hVMWxIWkV3L2NyelcwdjQ3dlJ1Nk9Ublo4bE5DbWpNODNrc3pZWlZqOWo4?=
 =?utf-8?B?RU50RzZnd0ZIQTFDL2hsU2VXQU55cTBmZm1QZFc4VUFmcWNVRXBMc2llZmd2?=
 =?utf-8?B?RUgzK1ZEakFtMCtIQVVkVldUT1NORXBEQVhLRW5wS2hNOGhySGFodnBBZU9m?=
 =?utf-8?B?dE1rU28yalZZZjBkYkFPQzhyTTFSZVhWTHlqUGRrMnR0aHdhRWRocTIrOXJY?=
 =?utf-8?B?MzdzT0xVdFk4U0l2NXREd053QkhsZy9WN0pOUnJtOXFJUkJ3TTNhT1Zwdjds?=
 =?utf-8?B?bE9wVjdZN0xOMHlPVCsybGJNNk5OZ28zZlpGNFJySVZqeDlqV0p2K3Y0a2JB?=
 =?utf-8?B?NXZOQTV3TEhDMGxrc1VqNFMzc2NGM0thWUNlemhzQ3hZL1Z6RGJVL0NHaVht?=
 =?utf-8?B?WENkenNJazFKc3VzMUI4bWZaL2ROVmovWHpOWUl4ZG83QVhCRzg5ejROSkNv?=
 =?utf-8?B?TEQ1SVI3NytCZGNXRUdENmtuT0tZTjRUOEdjTnlmcktvd2x5VngwWWpwT2Uy?=
 =?utf-8?B?bmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E320EC09AB0DAA419853AAEDA02AF56D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e78eff-9561-4004-cd59-08dd030cb418
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 11:25:25.2436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JPSdnOIEIWqiJ+YyKlgjRUHRVMiKvozczMXnfD5GvPqdn/4kxxLJc7lj99QP+mbrcDLdJy06l/HpUvtG2QB8p0hhYpnDUKxdICsezy1iC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8720
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--24.475200-8.000000
X-TMASE-MatchedRID: F3kdXSFZYkfUL3YCMmnG4kPRjHu3N1uxjLOy13Cgb4/n0eNPmPPe5KWz
	WoIRiV9DM/Se/q/gEyf5MiS7M8c1eGmXMi7Ntyo2uyM3OnG9pAojRLEQhrITC5722hDqHosTVKk
	hiFZhhSi0Q5Hr4pHpzlzzIJrqcl2Q9dXaIcOJDZ9s2Ep7d2KnNofsPVs/8Vw61Xm4Y+RpCT7GEf
	otTZgUJUCIchOOYQWLFBA6NYhLHMVF/TNFimjSuMOvQCMFyZ9GnaU0BOrP3M93vUA6/Pi03OYI8
	JecFTbdTHwQOgaoTg3fBam7GiZi1TB9eXnpC3lIG5mg0pzqmX5imi8LvNfmr6vM+zzl/BSTxT88
	QdzCbkOknQ5gytPTKXqkkufWGK1ketI/1G0ZlihbuDP8ZuCmXkCrr/LkAQ46qPm/sjj9KBi8+Dp
	SyxUU/7zo4VU16GhHlxnSJwunsOpC/bXMk2XQLIMbH85DUZXyseWplitmp0j6C0ePs7A07QKmAR
	N5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--24.475200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	03C9C0218E2C5AA411CBD67D41D30ADD112A8C5B8143D14831B3DF729E3092F82000:8

T24gVHVlLCAyMDI0LTExLTEyIGF0IDExOjQ4ICswMTAwLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IEhpIFNreSwNCj4gDQo+IE9uIDEyLzExLzIwMjQgYXQgMTA6MDg6MzEg
R01ULCBTa3lMYWtlIEh1YW5nICjpu4PllZ/mvqQpIDwNCj4gU2t5TGFrZS5IdWFuZ0BtZWRpYXRl
ay5jb20+IHdyb3RlOg0KPiANCj4gPiBIaSBNaXF1ZWwvTWFydGluLA0KPiA+IEFib3V0IHRoaXMg
ZHJpdmVyLCBpbmNsdWRpbmcgRjM1U1FBMDAxRy9GMzVTUUEwMDJHIHBhcnRzLCBJJ20NCj4gPiBj
b25jZXJuZWQNCj4gPiB0aGF0IHRoZSBkcml2ZXIgd2lsbCBhbHdheXMgdXNlIDMySCBmb3IgdXBk
YXRlX2NhY2hlIG9wZXJhdGlvbnMsDQo+ID4gd2hpY2gNCj4gPiBtZWFucyBpdCdzIG5vdCBjb21w
aXRhYmxlIHdpdGggdGhvc2UgU1BJIGNvbnRyb2xsZXIgd2hvIGNhbid0DQo+ID4gdHJhbnNtaXQN
Cj4gPiAyMDQ4IGJ5dGVzIChtb3N0IHNtYWxsLWRlbnNpdHkgU1BJLU5BTkQncyBwYWdlIHNpemUg
bm93YWRheXMpIGF0DQo+ID4gb25lDQo+ID4gdGltZS4NCj4gPiANCj4gPiBUaGUgZm9sbG93aW5n
IGNvbnRyb2xsZXIncyBkcml2ZXIgc2VlbXMgdGhhdCB0aGV5IGNhbid0IHRyYW5zbWl0DQo+ID4g
MjA0OA0KPiA+IGJ5dGVzIGluIG9uZSB0cmFuc21pc3Npb246DQo+ID4gLSBzcGktYW1kLmM6IDY0
IGJ5dGVzIChBTURfU1BJX01BWF9EQVRBKQ0KPiA+IC0gc3BpLWFtbG9naWMtc3BpZmMtYTEuYzog
NTEyIGJ5dGVzIChTUElGQ19BMV9CVUZGRVJfU0laRSkNCj4gPiAtIHNwaS1mc2wtcXNwaS5jOiAx
S0INCj4gPiAtIHNwaS1oaXNpLXNmYy12M3h4LmM6IDY0KjYgYnl0ZXMNCj4gPiAtIHNwaS1pbnRl
bC5jOiA2NCBieXRlcyAoSU5URUxfU1BJX0ZJRk9fU1opDQo+ID4gLSBzcGktbWljcm9jaGlwLWNv
cmUtcXNwaS5jOiAyNTYgYnl0ZXNjIChNQVhfREFUQV9DTURfTEVOKQ0KPiA+IC0gc3BpLW54cC1m
c3BpLmM6IFRYOjFLQiwgUlg6IDUxMkIgaW4gRklGTyBtb2RlDQo+ID4gLSBzcGktd3BjbS1maXUu
YzogNEINCj4gDQo+IEkgYmVsaWV2ZSBtb3N0IG9mIHRoZXNlIGRyaXZlcnMgYXJlIHN0aWxsIGFi
bGUgdG8gc2VuZCBvbmUgcGFnZSBvZg0KPiBkYXRhDQo+IHdpdGhvdXQgdG9nZ2xpbmcgdGhlIENT
ICh3aGljaCBpcyB3aGF0IGFjdHVhbGx5IG1hdHRlcnMsIEkgYmVsaWV2ZSkuDQo+IElmDQo+IHRo
ZXkgd2VyZSBicm9rZW4sIHRoZXkgd291bGQgYmUgYnJva2VuIHdpdGggYWxsIHNwaSBtZW1vcnkg
ZGV2aWNlcywNCj4gbm90DQo+IG9ubHkgRm9yZXNlZSdzLg0KPiANCkhpIE1pcXVlbCwNCkkgdGhp
bmsgaXQncyBub3QgYWJvdXQgdG9nZ2xpbmcgdGhlIENTPw0KDQpJZiBhIFNQSSBjb250cm9sbGVy
IHRyaWVzIHRvIGV4ZWN1dGUgd3JpdGUgcGFnZSBhbmQgaXQncyBjYXBhYmxlIHRvDQpzZW5kIG9u
bHkgMUtCIGluIG9uZSB0cmFuc21pc3Npb24sIGl0IHNob3VsZCB0cmFuc21pdCBkYXRhIGluIHR3
bw0Kc3RlcHM6IDFzdCAzNEggKHJhbmRvbSBwcm9ncmFtIGxvYWQgeDQpIGFuZCAybmQgMzRILiBI
b3dldmVyLCB3aGVuDQpGMzVTUUEwMDJHIGV4ZWN1dGVzIDJuZCAzNEggY29tbWFuZCwgaXQgbmVl
ZHMgdG8gZXhlY3V0ZSAzMkggZmlyc3QsIGFuZA0KaXQgd2lsbCBjbGVhciBkYXRhIHRyYW5zbWl0
dGVkIGJ5IDFzdCAzNEggaW4gTkFORCBmbGFzaCdzIGNhY2hlLiBUaGlzDQp3aWxsIGNhdXNlIGRh
dGEgY29ycnVwdGlvbi4gT3RoZXIgU1BJLU5BTkRzIGRvZXNuJ3QgbmVlZCB0byBleGVjdXRlIDMy
SA0KYmVmb3JlIDM0SC4NCg0KPiA+IEkgZ3Vlc3Mgd2UgbmVlZCB0byBhZGQgc29tZSBjaGVjayB0
byBtYWtlIHN1cmUgdGhhdCBGMzVTUUEgc2VyaWVzDQo+ID4gd29yaw0KPiA+IG9ubHkgd2l0aCB0
aG9zZSBTUEkgY29udHJvbGxlcnMgd2hvIGNhbiB0cmFuc21pdCBtb3JlIHRoYW4gMjA0OA0KPiA+
IGJ5dGVzKE5BTkQgcGFnZSBzaXplKSBhdCBvbmUgdGltZT8NCj4gDQo+IFRoZXJlIGlzIGFscmVh
ZHkgYSBzdXBwb3J0c19vcCgpIGhvb2sgZm9yIHRoYXQsIEkgYmVsaWV2ZSB3ZSBhcmUNCj4gZmlu
ZS4gSWYgaG93ZXZlciB5b3UgZXhwZXJpZW5jZSBlcnJvcnMsIHBsZWFzZSByZXBvcnQgdGhlbSBh
bmQgd2UnbGwNCj4gbG9vayBmb3IgYSBzb2x1dGlvbi4NCj4gDQo+IFRoYW5rcywNCj4gTWlxdcOo
bA0KDQpXZSBjYW4gYmxvY2sgMzJIIHVwZGF0ZV9jYWNoZSBvcGNvZGUgaW4gc3VwcG9ydHNfb3Ao
KSBob29rIGZvciB0aG9zZQ0KbGlnaHQgU1BJIGNvbnRyb2xsZXJzKHRyYW5zbWl0dGlvbiBjYXAu
IDwgMjA0OCBCeXRlcyk/IE5vdCBzdXJlIGlmDQp0aGVyZSdzIGEgYmV0dGVyIHNvbHV0aW9uLg0K
DQpJbmRlZWQsIG1vc3QgU1BJIGNvbnRyb2xsZXJzIHN1cHBvcnQgRE1BIHRyYW5zbWlzc2lvbig+
MjA0OCBCeXRlcykgbm93LA0KaW5jbHVkaW5nIG91ciBNVEsgZmlsb2dpYyBwbGF0Zm9ybS4gSWYg
dGhpcyBkb2Vzbid0IGJvdGhlciBvdGhlciBGSUZPLQ0Kb25seSBTUEkgY29udHJvbGxlcnMsIEkn
bGwgdGFrZSBpdC4NCg0KQlJzLA0KU2t5DQo=

