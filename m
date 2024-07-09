Return-Path: <linux-kernel+bounces-245997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7592BC7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CDAB257FD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ABE18E779;
	Tue,  9 Jul 2024 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VkwKikmT";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6xBVVkyZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46E7257D;
	Tue,  9 Jul 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534041; cv=fail; b=FioPNiEqai8JIWy0eKlpv/QK6//x0/ZzdiekdWD/h/H89ak/9gex9+u1GBcc+p5eKxA6w3pitGJxN08zFdj4M9pEsiC33PwIdtuJ2Sfxx65xQClo5FG1hg8VpSa659c5uHnfsDwq1bCBldZPZYUag2imU+X0ESiWPmUb72JMhHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534041; c=relaxed/simple;
	bh=CMzbOqJK30vHjztBsGeE5yALG/Ha5K9tp2Kz1qNWCCg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KpwTuTQijMRL2aKi52b9YO9RwwJzCPkcREOiGcSa8VKZ5Bq3J6VA7yfhN6Q5zd5SAw5qCYsBlyZzbL25+FYw6w4HqMnoRDw1PFPqqc7IKbJ+dI5XdEXoWunXujhGL3125BXOzKAPqXjPKfWqplyPmLxd1K7Z9qgMEex6H5+aBAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VkwKikmT; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6xBVVkyZ; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720534039; x=1752070039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CMzbOqJK30vHjztBsGeE5yALG/Ha5K9tp2Kz1qNWCCg=;
  b=VkwKikmTnxqCH0ukkCLY1k4nIsyxxLqyewv0kYjqHrcIcaAB8vYl+m0l
   +hMKB8Jhm6JFGV2qrbFuEiyAab68DZsN2YBvcCcsDHJ8c8ZjeOto/w86D
   52OJgfnH3zhvCVkkgV26ndj9xHnnabrK4CgkdVQYMr3e/xFZtLiTDTRmm
   hoKUiq/SFF6H/nmgZZTMChQFzKRDw0zRjSmaCTIsoRjncpUddsnqFCitz
   3Ckgx6ManhjvdwuOMjAvABVCRuqj/L41ScI0rIpBiDsDU/C1bgcaUH5XI
   lABYu5Ow+wt5erR4LsvNCo3vp1A0VDcZOypYjSY6VE72cTdetlUp3XnRI
   A==;
X-CSE-ConnectionGUID: 04keLyDCRiK4hLzz8K3m/A==
X-CSE-MsgGUID: pdjZdK/0Qd6bsZkyIykfvA==
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="29014151"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2024 07:07:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jul 2024 07:06:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jul 2024 07:06:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0sbHq1ioT34o/+3ohCzl90dHEqKKeU1QrQt4qFtpjwOqwIGFLDbDO5gApdVmNDkvu1XFBn4RLNeT3euhF+AuV5bVOISGmtWDSyA/T+CE+HyJajZOd6ssAItuBWVyKwg2N6HhiW7uayp8a0gzpD11VjfGJ9+4Q2oBroR0G/iKBXYZWKy88RDDiA7jxr0FM92P5xeyRW+a+AJCv8x2doDpgz4Y1aCC/N3JN0t3oN5ZeASmwWT8TZh0MsMzgGBM8ob3Zr9yw3X3aXFy1XNk+azQ3jWRlWVYgTo5UKHWmMsiM5Vw0llhJvkRxs59DLrlcVqQ7lEbI2ajgWZm9W9z61x1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CMzbOqJK30vHjztBsGeE5yALG/Ha5K9tp2Kz1qNWCCg=;
 b=JUQJuyL8WHeA1y2UkGh58lFRtWZqNDbgd/Fda7xkKRrebfEIoIzxxPhjN8DO6vgP+V0/ehP4u2dC9xkVyPCuCIH9pan+rkQiZWAJxdNavfaEUXdTayXZALuvMTeDb7vXEX0emH7p696YYK0cw9lsJl1tjlkSBK215/wc16vblRsJ8gufXliN+ADHcT6k2O2Gxn1ASHfSwETeGl2oeRRTjxXtjeRl0UDI6fLaV3kspztQA81Q0aYVPUgQeBz+YnwYzc33VUsNNyocMkfsQkH8I9LOeGf9Ck6dbD1Iun8j4pSbYO1JFSCOdZClWyPmukaQNVTVUPwGtlcOIcuq3e1jlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMzbOqJK30vHjztBsGeE5yALG/Ha5K9tp2Kz1qNWCCg=;
 b=6xBVVkyZpA4ta5gQ37eGO8Bo0nAE8cnr9CvCxTpOODxXIJlDm5Fhqnsl2nRk4qIlq6fYGURGlJjZ3q8IuFArQQBko3LU3I7AfAQpzWFR+DzOPcF7nXRI2kV3JEDqypC2EA1hrBSBsBUUDFN9h/2/8GHWfXUrHNMUFCEgj1KQ6EJxQcGTgXJqR+2XdGQiZyc6mVDOVdgpDfAUPGVI7VFmqdDtM+kgm67B8jXkxpBvIzOvFqWSB3ZS2GXOsBrEQdW2vPTYihd8SfPP5vZNf76r2TFE+q29159FMY/CYuDlbn3MzbsYu2dTtTYN7wz37DGjkVKBTdbzhzzWSE4RJQS/tw==
Received: from DM6PR11MB3450.namprd11.prod.outlook.com (2603:10b6:5:5e::11) by
 MN0PR11MB6280.namprd11.prod.outlook.com (2603:10b6:208:3c0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 14:06:29 +0000
Received: from DM6PR11MB3450.namprd11.prod.outlook.com
 ([fe80::a925:8ea5:fab4:a56]) by DM6PR11MB3450.namprd11.prod.outlook.com
 ([fe80::a925:8ea5:fab4:a56%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:06:29 +0000
From: <Nicolas.Ferre@microchip.com>
To: <Varshini.Rajendran@microchip.com>, <conor@kernel.org>, <maz@kernel.org>
CC: <tglx@linutronix.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Dharma.B@microchip.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Thread-Topic: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Thread-Index: AQHa0glAJdk8LCoPa0irjnUWbMvEuw==
Date: Tue, 9 Jul 2024 14:06:29 +0000
Message-ID: <82ca4f3d-fa78-4617-823e-69f16a2c3319@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102814.196063-1-varshini.rajendran@microchip.com>
 <20240703-dentist-wired-bdb063522ef7@spud>
 <a41274c3-fd32-4eba-8240-bf95e41f63d9@microchip.com>
In-Reply-To: <a41274c3-fd32-4eba-8240-bf95e41f63d9@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3450:EE_|MN0PR11MB6280:EE_
x-ms-office365-filtering-correlation-id: b152f8fb-9a87-432e-ede8-08dca0205456
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WGwrUk9WMEFCWXYxeHl3aWlDd0hBYVpvYk5YUTlyTkdEd1VYRXNhUHJ4WFJh?=
 =?utf-8?B?VHVEeDlSbmJhaWVYQm9HTERPc01qRTNBcVhVRzVldC9ldytsRHRqTkozZzND?=
 =?utf-8?B?YWNhcW85NGhsbjNhc1E2TDFRZWhHaU1rdHllTW1NUnl2ak8zT3YyUDZxcFdi?=
 =?utf-8?B?dWlzTy9BN0c5QzZPUXFhT2xGMXY4KzRlSllFUkl2a2JMOUVZd3ZiRWRFNW43?=
 =?utf-8?B?dHg4WFRYakNyVFlmbnJjeVY2QlhkWEhyMG8rNWFCcmdlMDJKUWNRVENNNklF?=
 =?utf-8?B?cWNKTFM1SmtnUGlGMnZKd3VMTmRieVJJMU12cDg3QUp3aldoYStReE53OUta?=
 =?utf-8?B?WjlrdTJ3K1Z3TXc3K1REd01aTkErbW9mdHhFSUgwR2VHWDhoNVZtQ2xaeXor?=
 =?utf-8?B?aktQallUUFROOXp6SGN5dE1LN0ovTnpSS0Y0M3dRc0hDZlNxeFZORURpUWlw?=
 =?utf-8?B?NUo2UFM1M2JWSWI5SjM5bDRPTHhHd2JzVmZic01xdS9zd0owYjdIdVQ2Y1BY?=
 =?utf-8?B?RS9idUlKMHE5TEhBMDBDK2hDbzZrTzJzaElmdEJXdmkvenJyYXc4QkcrUVoz?=
 =?utf-8?B?NkRGaGhGS3Q3Q0JPVTNmZHd1UWtqRmViV0FhT1JSY01kQjE5Y3BZc3BsbzQy?=
 =?utf-8?B?blRLSFcyK2haQ25jT2NHM0pJaW03M1JFck5nTFlzQzJWU01Iak9IL3F5d1JG?=
 =?utf-8?B?NzREbDRlZ3lPM3BWNkpiSDFHK2VTelVtRjAvMTR1d2pXMFZLNU85TDkxdVhv?=
 =?utf-8?B?Y2lzM29IcVN4OE9PZEVlMU9nSkxBMHMzeCtXcW4yR1d5ZE16Z2U3RHp3YTB6?=
 =?utf-8?B?TUJ2dE0rZUpZVFRXWFpiUEt0TUNpK05XVG5uekRRODVFdTl2Ung4TktiV1lq?=
 =?utf-8?B?N3ltdERBTEM2TUxUb20rZDFBZHlQanlQUUt2cWEwNituOXhKdHBSSkwrUFpD?=
 =?utf-8?B?UitvdDlQY3VsN1E1anpPenczL25uSjQvYmlMMWd4TGhVTnYrbERnd0w2cDBQ?=
 =?utf-8?B?Yi90c0FXMWFydk5kYktJcEFuUmlTYjNneS85VzVyZmpJbDZoazBuRTExeXg5?=
 =?utf-8?B?RTJydEI5eVJOY29TYmExcnJJRHRrUFdzMnZjaGkwWlNuWjdDQnN5c0tFWk9U?=
 =?utf-8?B?dTd4VFNvbVBjUGdWdjZ2QUJlcDVqUE9xZjdxbUdQNTQvbVZjZTdBK3dEWXBp?=
 =?utf-8?B?cURrY3ZTb250QlJtZCswNE81NW16SWZ6ZjJzeDBuK3pEK1l3bUxtRWNxVVhB?=
 =?utf-8?B?QVBlZkRET3I4ZE1sbWQ3ME5wcWIvL1dmMTVKNnRDMFR4c0ZuRmxkdGswMHJE?=
 =?utf-8?B?Y01pRDNIODBQellHQ3hnQVhINFdrbHNxN0VDazVvNURvdHZKMG4xRTZGbE1Y?=
 =?utf-8?B?LzlXbXQwbnhCUlV1cms2dkdSWk5OWFFWeFd5WGRSMnZ3MVRINGhUWW9WdHZX?=
 =?utf-8?B?N3cxTCtwQi9jWjZ4bURkTTR3LytpV3FOd0Jybkc2bStIenB2Q2tNTU1WdTVT?=
 =?utf-8?B?YjhIRFRaWTZKUXgzbEJORW5NWDBuKzR0dHdzczBIWlZKVWRPcm51UUl4MUdY?=
 =?utf-8?B?dEVmbzVTeVRlZldvNGRUM1hJbzJXNVZidndWeGVRaU1lWFJqNUp4VXhrV3RI?=
 =?utf-8?B?VUEwWkYwTzRsK012NFNKd2VSakxjQlV3NG9XdVg4Nk9aMDhMZDMvMC9YUXBG?=
 =?utf-8?B?VjhjWGY1dzFYQStYZlNXbUNTNXVVaEUvUGs5R0FFcjF5ZWJBYnkvUW04Mzho?=
 =?utf-8?B?TGVlZmdCcTZ2L0MvU0hKRG9QS3l6VVE3OFNDRGpQNTNHZGRwR2duczFTYW1C?=
 =?utf-8?Q?6bcmArFmZnz5hXV2V9QQmWZcjE58w1noVCDgc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFRFQUJwcHVJbURZVE9ZTTFUK1paZ2hEa1ZtVldlRkpuWEhoS2ZwMkdza0l0?=
 =?utf-8?B?WlE5WVVtNEZka2g5TFF5Z3JPR3NZTUVuNTRjcWpsenBIMjNQS25NM2ZsZjd3?=
 =?utf-8?B?V2xYeUc3cUNwMjBCV1R5djlyNDY4VGI1NDFJMUxUbUh5VmM0cEdQZVFaZVJz?=
 =?utf-8?B?Ykxoek1vaWhaRWUvKzBUakFMc1J4NTh2QlIrVEsxVmZJTVg5MXFWZzBnT29P?=
 =?utf-8?B?MzhRYmdiV1p6RXFsSERjTEovcWhEcFBhYTAvbTlsbHZrZFBkUVFiZk9ybmh0?=
 =?utf-8?B?VXh5NTlBT2l3d2VaQVFyV1lYUDJOeFczNkVOTTlndjFuUzZoZ1pMaklDT0Qv?=
 =?utf-8?B?dWlkM2JhSm1VdS9tTTBNazQzZG01eklUdWRac2lJSEY4SmJVdHc1aUc5Z0hO?=
 =?utf-8?B?OFpCVkRuNXh6ZUtiSVdvSjJrVVlWOVlQYTI2VVNPdUdycFIrNm9qZ0RGQzRv?=
 =?utf-8?B?MU8rQ0tmdGlXV2ZKazh3MkFQQllQck9IS3hTMFQyOC9nZ0VtaytJZXBBazlD?=
 =?utf-8?B?bHNhOEF0aVE1TnRqQ1RWbjAzL0ZoZHM1QmdJM0Q5L1l2VGNKMHNoTENOc3ZT?=
 =?utf-8?B?b0NyR2RMcmhpTEpmYWh1WDJMVmoxSVAzUW5WN09PaW5LNHhPaG9XOE9SSURu?=
 =?utf-8?B?ajdmdC9UcE1JaFAzRnE2cnZJWG9DUjhEQW92ZytFdStqeHdtNG5JSEFPM09r?=
 =?utf-8?B?RmRnYmdPWFg4N1BNb2NVMGN3VVJUOGI4U3NwMGVKOFloNjRJNWxCaVBoWGZw?=
 =?utf-8?B?Rk1kQm5uQmxWZE1kNnVad0UwUnNSWXUvS0ZKZkRqQWQ5NGp6cWpiM0NTaTNo?=
 =?utf-8?B?K2ZHaHBRZzVWV1BxcjV1WUZiNkVZdm5rc2oyaklQdGJnMWZGYzJJMEVBQkJV?=
 =?utf-8?B?cnVldFkxcHo4REVrS1IyUytmcGFIYzRlRE5vSlhxUGd6ZzRMbGtpalNSMVlk?=
 =?utf-8?B?N0tHN2l4UmUyQitId3ZrREJLa3B1b2VaelgyNFRJQlhJcG1oNUZla1FLbElU?=
 =?utf-8?B?VEk3dDIvS3NteDZiZWk2aDBNbTBwNWJNY1NwNmt3TGVrSmpTR0pXTjVNOTlL?=
 =?utf-8?B?NzU1NjArREFmV3hrZmJmSENjejVUYjROUi9UY1BVVks0K3g5Vm9FRFZqVGJo?=
 =?utf-8?B?VExEbjQ5UzNkcktYZmtNb01Ra0N6c0xOMWxFY0FGZHNXV0NrNlowSkxpa0FL?=
 =?utf-8?B?YjZQckRQdDl4U2RWWkVTVEZJMDYvS0pyOHJ4a2Y1UDc0czRHVWc2akpLdlZO?=
 =?utf-8?B?ZzZUWlpzMUU5QkM0c1JQeVdmb0xOdTY2bisyMzZEY2RxYUxIQ2FXZlhxSzRr?=
 =?utf-8?B?YWtXUnp3R2VObFhiYzZRQ3hIQkEwL2JOZUVxY1BRUUxxN3ZMYTZteDVNamNr?=
 =?utf-8?B?TWlLRCtoZDY0eTlUQ2JsaGNLUnFYajFkVE91T2VSTlN3K3VvYnpqYVVhOGVr?=
 =?utf-8?B?RDlpbkxUV1VVYXNCazN0WUp1UmZRalBKdTNtME5MaUhHNnkwLzNCOG4xa0RG?=
 =?utf-8?B?UDFXSkdzbm5EWGNzL243dWRYdVFvSmRlck5PYUhNUXc5WllLbzQ3WlUydndF?=
 =?utf-8?B?MnZFQTNVbHJRa3VldGZWSGNLT1BYRTBlYitqWSs3djBwbkZPQmpKa0cxbTk3?=
 =?utf-8?B?UjBHUXU0VDdxcERkR3p6emdodGxTZnhBVnJJb0U0UU9ueEc4NjExcDVScDE0?=
 =?utf-8?B?NzJ2V2JIeU95anRsTi94TDgzMlZVY3pWTTdIRFRvRkV2TnFXOTNQSldMbm1n?=
 =?utf-8?B?YXJjQ2hteEpBYkdqU0wxUHAzMkFSUlNTSjNvMmoySkkyWll3Y090M203clBC?=
 =?utf-8?B?RE1PdmVqaE9FRDU1ZEdLbjh1Z24wMXlFZ2dEcWxhN1Y0VzkxMjhXeHB4ZE5Q?=
 =?utf-8?B?L2V6dXR5d1ZiMS9QSmNvRWY4dWxZYUhqeGk5OERsZEdCdDNFazdPaDBLRU5J?=
 =?utf-8?B?RU1UNzRKNFlXeWVrY1hWNUNmOHViMzhPdFgyOXhndG1MY2xNY04zMy9KanF0?=
 =?utf-8?B?UlQzWDl6Uml5SENPMm10UHVkZ2NWL0JvVUhKcXJJaDN3TjhjZUVWR0VEWDEz?=
 =?utf-8?B?RVpxZ0R5aE0wa2hjRnk5Rm51RDBpdnoyVllCMUJtMDlreWdIRjFNZjhuQ1hh?=
 =?utf-8?B?MUdMSmxCQTFBWmVRT0dKWDRkRXhxWmJzYk9TRnlTZUdKaVVHNlJ5QStKdXoy?=
 =?utf-8?B?enJmY2dYWURtYXpiaGVvc3NlTDhIZWs1RnJTYlJkdE1qWm9CcTlZL1hCMGpF?=
 =?utf-8?B?UVlvK2JHMGFqK2VaMEVGbkJ3MTB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1E4E3243EE1B4409516481F9568BDBC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b152f8fb-9a87-432e-ede8-08dca0205456
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:06:29.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzotVNvdT9P6/HVEEVEc7lSbz7uU3AwROglbrMJIKqSsSILYgubglOhOWhlp0uyo1KDjB+5uZShQBLp2x7A3XmplMsjVDekimu20n9kbBAY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6280

T24gMDkvMDcvMjAyNCBhdCAwODoxMywgVmFyc2hpbmkgUmFqZW5kcmFuIC0gSTY3MDcwIHdyb3Rl
Og0KPiBPbiAwMy8wNy8yNCA5OjExIHBtLCBDb25vciBEb29sZXkgd3JvdGU6DQo+PiBPbiBXZWQs
IEp1bCAwMywgMjAyNCBhdCAwMzo1ODoxNFBNICswNTMwLCBWYXJzaGluaSBSYWplbmRyYW4gd3Jv
dGU6DQo+Pj4gQWRkIHRoZSBkZXNjcmlwdGlvbiBhbmQgY29uZGl0aW9ucyB0byB0aGUgZGV2aWNl
IHRyZWUgZG9jdW1lbnRhdGlvbg0KPj4+IGZvciB0aGUgcHJvcGVydHkgbWljcm9jaGlwLG5yLWly
cXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBWYXJzaGluaSBSYWplbmRyYW48dmFyc2hpbmku
cmFqZW5kcmFuQG1pY3JvY2hpcC5jb20+DQo+PiBUaGlzIG5lZWRzIHRvIGJlIHBhcnQgb2YgcGF0
Y2ggMTQuDQo+Pg0KPj4+IC0tLQ0KPj4+ICAgIC4uLi9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9hdG1lbCxhaWMueWFtbCAgICAgfCAxMiArKysrKysrKysrKysNCj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMu
eWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9hdG1lbCxhaWMueWFtbA0KPj4+IGluZGV4IDljNWFmOWRiY2I2ZS4uMDZlNWY5MmU3ZDUz
IDEwMDY0NA0KPj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbA0KPj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbA0K
Pj4+IEBAIC01NCw2ICs1NCwxMCBAQCBwcm9wZXJ0aWVzOg0KPj4+ICAgICAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzItYXJyYXkNCj4+PiAgICAgICAgZGVz
Y3JpcHRpb246IHUzMiBhcnJheSBvZiBleHRlcm5hbCBpcnFzLg0KPj4+ICAgIA0KPj4+ICsgIG1p
Y3JvY2hpcCxuci1pcnFzOg0KPj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVm
aW5pdGlvbnMvdWludDMyLWFycmF5DQo+Pj4gKyAgICBkZXNjcmlwdGlvbjogdTMyIGFycmF5IG9m
IG5yX2lycXMuDQo+PiBUaGlzIG1ha2VzIG5vIHNlbnNlLCBkaWQgeW91IGp1c3QgY29weSBmcm9t
IGFib3ZlPyBXaHkgd291bGQgdGhlIG51bWJlcg0KPj4gb2YgaXJxcyBiZSBhbiBhcnJheT8gV2h5
IGNhbid0IHlvdSBkZXRlcm1pbmUgdGhpcyBmcm9tIHRoZSBjb21wYXRibGU/DQo+Pg0KPiBTb3Jy
eSBmb3IgdGhlIGJhZCBkZXNjcmlwdGlvbi4gSSB3aWxsIGNvcnJlY3QgaXQgaW4gdGhlIG5leHQg
dmVyc2lvbi4NCj4gDQo+IEZvciB0aGUgc2Vjb25kIHBhcnQgb2YgdGhlIHF1ZXN0aW9uLCB0aGlz
IGNoYW5nZSB3YXMgZG9uZSBhcyBhIHN0ZXAgdG8NCj4gcmVzb2x2ZSBoYXZpbmcgYSBuZXcgY29t
cGF0aWJsZSB3aGlsZSBoYXZpbmcgcHJhY3RpY2FsbHkgdGhlIHNhbWUgSVANCj4gcG9pbnRlZCBv
dXQgaW4gdGhlIHYzIG9mIHRoZSBzZXJpZXMgWzFdLiBJdCBpcyBraW5kIG9mIGxvb3BpbmcgYmFj
ayB0bw0KPiB0aGUgaW5pdGlhbCBpZGVhIG5vdy4gRXZlbiBpZiB0aGlzIGlzIGFkZGVkIGFzIGEg
ZHJpdmVyIGRhdGEsIGl0DQo+IG92ZXJyaWRlcyB0aGUgZXhwZWN0YXRpb24gZnJvbSB0aGUgY29t
bWVudCBpbiBbMV0uIFBsZWFzZSBzdWdnZXN0LiBJDQoNCkluIHlvdXIgdjMgcGF0Y2gsIGluZGVl
ZCB5b3Ugd2VyZSBleHRyYWN0aW5nIHRoZSBudW1iZXIgb2YgSVJRcyBmcm9tIHRoZSANCmNvbXBh
dGliaWxpdHkgc3RyaW5nIChha2EsIGZyb20gZGV2aWNlIHRyZWUuLi4pLiBJdCdzIG15IHByZWZl
cnJlZCANCnNvbHV0aW9uIGFzIHdlbGwuDQoNClNvLCBjb21lIGJhY2sgdG8gdjMgWzFdIGFuZCBh
ZGRyZXNzIHdoYXQgQ29ub3Igc2FpZCBpbiB2NCAiLi4uaGF2aW5nIA0Kc3BlY2lmaWMgJHNvY19h
aWM1X29mX2luaXQoKSBmdW5jdGlvbnMgZm9yIGVhY2ggU29DIHNlZW1zIHNpbGx5IHdoZW4gDQp1
c3VhbGx5IG9ubHkgdGhlIG51bWJlciBvZiBpbnRlcnJ1cHRzIGNoYW5nZXMuIFRoZSBudW1iZXIg
b2YgSVJRcyBjb3VsZCANCmJlIGluIHRoZSBtYXRjaCBkYXRhIGFuZCB5b3UgY291bGQgdXNlIGFp
YzVfb2ZfaW5pdCBpbiB5b3VyIA0KSVJRQ0hJUF9ERUNMQVJFIGRpcmVjdGx5Ig0KDQpJIHRoaW5r
IHRoYXQgd2UgY2FuIGNvbnZpbmNlIE1hcmMvVGhvbWFzIHRoYXQgaXQncyB0aGUgYmVzdCBvcHRp
b24gYXMgaXQgDQpwcmV2ZW50cyBpbnRyb2R1Y2luZyBhbm90aGVyIG5vbi1zdGFuZGFyZCBwcm9w
ZXJ0eSB0byB0aGUgRFQsIGJyZWFrIHRoZSANCkFCSSAoYW5kIHdhcyB1c2VkIGhhcHBpbHkgZm9y
IHllYXJzKS4NCg0KQmVzdCByZWdhcmRzLA0KICAgTmljb2xhcw0KDQpbMV0NCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xrbWwvODdlZTFlM2MzNjU2ODZiYzYwZTkyYmEzOTcyZGMxYTVAa2VybmVs
Lm9yZy8NCg0KDQo+IGFsc28gcmVhZCBSb2IncyBjb25jZXJucyBvbiBoYXZpbmcgYSBkZXZpY2Ug
dHJlZSBwcm9wZXJ0eSBmb3IgbnVtYmVyIG9mDQo+IGlycXMuDQo+IA0KPiBbMV0NCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC84N2VlMWUzYzM2NTY4NmJjNjBlOTJiYTM5NzJkYzFhNUBr
ZXJuZWwub3JnLw0KPiANCj4+IFRoYW5rcywNCj4+IENvbm9yLg0KPj4NCj4+PiArDQo+Pj4gICAg
YWxsT2Y6DQo+Pj4gICAgICAtICRyZWY6IC9zY2hlbWFzL2ludGVycnVwdC1jb250cm9sbGVyLnlh
bWwjDQo+Pj4gICAgICAtIGlmOg0KPj4+IEBAIC03MSw2ICs3NSwxNCBAQCBhbGxPZjoNCj4+PiAg
ICAgICAgICAgIGF0bWVsLGV4dGVybmFsLWlycXM6DQo+Pj4gICAgICAgICAgICAgIG1pbkl0ZW1z
OiAxDQo+Pj4gICAgICAgICAgICAgIG1heEl0ZW1zOiAxDQo+Pj4gKyAgLSBpZjoNCj4+PiArICAg
ICAgcHJvcGVydGllczoNCj4+PiArICAgICAgICBjb21wYXRpYmxlOg0KPj4+ICsgICAgICAgICAg
Y29udGFpbnM6DQo+Pj4gKyAgICAgICAgICAgIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg3LWFpYw0K
Pj4+ICsgICAgdGhlbjoNCj4+PiArICAgICAgcmVxdWlyZWQ6DQo+Pj4gKyAgICAgICAgLSBtaWNy
b2NoaXAsbnItaXJxcw0KPj4+ICAgIA0KPj4+ICAgIHJlcXVpcmVkOg0KPj4+ICAgICAgLSBjb21w
YXRpYmxlDQo+Pj4gLS0gDQo+Pj4gMi4yNS4xDQo+Pj4NCj4gDQoNCg==

