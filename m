Return-Path: <linux-kernel+bounces-410894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DAC9CF0B4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49646B34C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B514D1D5AC8;
	Fri, 15 Nov 2024 15:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="hiY5zNZb"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45351D515A;
	Fri, 15 Nov 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684512; cv=fail; b=nv+DQaCzUftLRl48cgFhGn0AsC0ESYVevRAu9zqIpP/R1iuwpedsioXwSY9bstrEPRd9oCWq/eLFgplBXu1CW0KQeg3bYg7jw0yG3uK0qt9oICOZ9UntzMVBUplefNWI8aDaGnRSXCrviUWFDC2Qey+IODr10SgKNzQjLpMoqMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684512; c=relaxed/simple;
	bh=X3rnyax1zC9Bfo1grJwzq+6nuyuj0SrU987k5oFoEjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sVSvfciqHQxkEuCmFcinpOVWvkOgxB9mmTWW0BEDonyAenzJTjeUqEx9Sd41mp9vQM45CbxRvjm8R9WuDgvuh4k6rHWoqJlHGSIifrT3klYypSgbkVP6IZ0Pf+mMMy+Or+yuNRoemVtruaSq5IyjoWj+7jtKn7sp0vrrjAugkRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=hiY5zNZb; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFEpvmW003841;
	Fri, 15 Nov 2024 14:58:09 GMT
Received: from pnzpr01cu001.outbound.protection.outlook.com (mail-centralindiaazlp17011024.outbound.protection.outlook.com [40.93.132.24])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42uwr1sv90-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 14:58:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yWyff4h0HS4KogOkCUcCK+6QLVqUpN9WaWlET4AuXRhD2Rb3liKpg2f6qQf1iGpH4d3g7LEjtr+sAPFmp51FzJWxwcqLHO30HPDHctUKknnsvH9DaEfECEk7pUm75N2htrixTjFWYgW7TevAOdf4t0+/jT+bD9iDlv+0AOMrqzrVB3MssoMm6BbHozt1ZKYdZ2odKbVrnOmfiviZex7SsQNRF5+KzXwDyMuQBx3ZxWis8Yfr1TsP7sJWOK4yeZ+ufYnq/yNfxKvlT9vQF/tH4mIOtiwDnkAJT36KC9UxBL4OuvRXcm+73Y8ZUu2o480SN8SYVAoSnzxQ4WZ8jtRZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3rnyax1zC9Bfo1grJwzq+6nuyuj0SrU987k5oFoEjE=;
 b=yT6k6IVnT7UcaFHlHLNjUx07q2dmlV+RRD1D69X2flN5JQ950AhFuwIoZ2t9zjuM0dmWvaQ7xSWjy192I1MJ22GBV6bfxBudOKeKU9NIRKw+vIl3wQxpCEW3Tci+wj7XmUZwMMq8IrDRht66HpymohhjkCWphcZKoHzxmQE75tqDW+BY8gF6BnP1jJYszmks/AVCR9yUf3IwwNQcAx3iVITz10H48BYM8vBh6TfDWDkSq5NMG24uMr2J3JHj72p27mCKZJz4fW0vJM5vsw8KKuO2ddEva5z5REZR/DsMJn17w9Ukx5pcxA9Fx7DouaD4hyfdT7+rGEdBDywKUwenww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3rnyax1zC9Bfo1grJwzq+6nuyuj0SrU987k5oFoEjE=;
 b=hiY5zNZbsepLLHqA4qj95BcaJujvCRjTLer2TPZY/ZJv9s2iV1gXBiSfk5OeiWR+5UIvIyZmGEeOGOgLHJPpSXR+fLAd9j4V2IiCrsDRZ7YuDnFHUqDFZ9yAUeMEGHSU2GdyrEiz4Q4fZbfv0g1FbmojXKGN4cRGaGjocjSL6XQ=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN3PR01MB9551.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:58:02 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%3]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:58:02 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn <matthew.redfearn@blaize.com>,
        Neil Jones
	<neil.jones@blaize.com>,
        Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "soc@lists.linux.dev"
	<soc@lists.linux.dev>
Subject: [PATCH v5 3/6] arm64: Add Blaize BLZP1600 SoC family
Thread-Topic: [PATCH v5 3/6] arm64: Add Blaize BLZP1600 SoC family
Thread-Index: AQHbN27Evgg49PMD5kicExpDvUXl9Q==
Date: Fri, 15 Nov 2024 14:58:02 +0000
Message-ID:
 <20241115-blaize-blzp1600_init_board_support-v5-3-c09094e63dc5@blaize.com>
References:
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
In-Reply-To:
 <20241115-blaize-blzp1600_init_board_support-v5-0-c09094e63dc5@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN3PR01MB9551:EE_
x-ms-office365-filtering-correlation-id: b9511a94-feff-4895-dc40-08dd0585e776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ri9mM3hQakYzNytleTRrV3lOMmhUa2R0cktHWWlDUDIzRG0rL0NwWWcyN1Jh?=
 =?utf-8?B?U09TMnk0c3NDTkdqWWdHT2w2d0ZnSERFaCtEZnk3YVlBK1JMVy9uNVVuRTRy?=
 =?utf-8?B?a1hxOTExSzZoUkhnODNkWi9WSTN5R1EyN0QrZ05QZHdhdFBwbnNLVGtJZFZp?=
 =?utf-8?B?cmdRb1doaXVDL21mQ2dpUlBPVER2MzY4bFJRYUthdUdWbDF0aHVySTYxVlJu?=
 =?utf-8?B?Y1BSRDc1b0RzKzh5a2V1a0V4RWRZcTBRVXFtWUJ6ajJyZ0tmZ1czdmhJcFhM?=
 =?utf-8?B?SXVHT050aVF6WmZPNndpOFQ4a0lXZ2lTN1kwWUZhYURhNWEwNENYRjU0enMz?=
 =?utf-8?B?b1ZldU1xNkZhSTNaRmREZUQyOVFrM1U3dE9CbXJhZ0k1d0FSTGtIVVp0d1NT?=
 =?utf-8?B?Y2FYdHNYaWx6dlhDWEVLWjBTdjV0NU0rcmxoNUNzcmcwcVdXeXcvcHJGbDdh?=
 =?utf-8?B?MlNETkR3VjFQendseU5acEYyQXpBVWcvL2pKNG9pc0ppMjdBV0ZBOVRZcGk3?=
 =?utf-8?B?UTByUno3L2UyOWNTemV4V0YzM1VVbUE1a25iTzRSNytGMThPVG5mYmpHMmhZ?=
 =?utf-8?B?SEtkSHBLcDdQRHRWYnZhRXhyWlRIZXFrSjBsZ2ptcG5ZVlFtWDR4U0EzQklJ?=
 =?utf-8?B?blRHZU0vR3p6NzY3S0VVYm9zRTNuQVZhdnhCQVJvZ2Y2Zk9sRlI5VUd3S01u?=
 =?utf-8?B?VVROazVQNm45bkR6eHNPV0Rzc1BFcnRQM3pjT0IzUnh0RkM0MnFIRHRZU0FB?=
 =?utf-8?B?eEVWQjJpbEFWMVQvNWtWWG15akZGZDd0SGtvSUpWaTViUVZkV2FMYXdGQysw?=
 =?utf-8?B?VjNjSW00V2lJazJOWWVTRk44UEtzYmV2SE9CaURJdEJ2eDNhc0J5UVhBL1ZT?=
 =?utf-8?B?eXU0OHA4dWQ3VFVTWTV6QTZuTnJaTE1SbnZoWTFjR0MvZ0FiVS94VC81SGJZ?=
 =?utf-8?B?dVVzZUw0VHBTb1BkbElVblB4Z3d5MHJmZnFYU05EcFpaVFlMZ09Nam1Kc25V?=
 =?utf-8?B?TU5meWRsa1BuMkp0SGI4THNNZm05N1ZJMndDTkpLZmNCYlVJdVlBUFpEV2Vn?=
 =?utf-8?B?RW9LRVk3UklCdTJBM2RjdGlHTnB1WlNVbThmUm42WGVvOGhjdXJkQmJxRWdm?=
 =?utf-8?B?NXd6K015Z2NlS1IxdnR5aHdPcTlnNVJWYVdibFVaODZKczZMYkpIajVQY1lY?=
 =?utf-8?B?Z0Z3OUszZlo2OEw5Tk5DR1g3THlxeGcwOG5pU0pBOFdHb29rRnFmMGNodVBZ?=
 =?utf-8?B?SmIxWWc3dEF3UldoWWFHTFhPb3ZzTFlkMzNHdEpOM3JRNkcyYjU0QngrbFlR?=
 =?utf-8?B?Nzg1SHFRemZUMFhqOUQwczBaV1NicVYvTE9HR2cvL0Zzb00xL1dvcXdabDNa?=
 =?utf-8?B?WGMybGJtSFpsUTdnQWM2TFl1c1o4S203M3hremZINEpFbUt4eU0rdXZ0K3hj?=
 =?utf-8?B?SVFBSTJCTHluRVgxOEg3cUM1bUc0aHVtUDMvZ1BHUlVXbDFvR0V1cVpoYzZN?=
 =?utf-8?B?anM4bU5Tc0RkMHdQaG0wMVA2aktiNHRpakdFUmYzWmFEME9KWnEyOFV4U0JQ?=
 =?utf-8?B?S3pTZGY0cmorYktjRzdtNmEyYTBtQy9UQldjbm1hbXpYWW1KdG1xUE9nWHRz?=
 =?utf-8?B?bGFmdi9GSnNrdWVBdFFXU0l1bVQ3SVhzMjNqa0lpa0VGTXFyMVBHT0U4YWNL?=
 =?utf-8?B?UnpxRjFyWGo3aUZib0t5d3FjY3dwekFySVUrSSt3WGZ2ak0vOGNRMUtnYkZM?=
 =?utf-8?B?bERHRXBHeUcvSENLc2k0UW12UFFWOGhMeXIycndkTGUzWmpCUy9iVDFqTjBt?=
 =?utf-8?B?L29oeXJOTHZMRmJoL2g0STNWTkhMTy9NVTBVZHJhaEhFaUVFQjYzTlVycmFR?=
 =?utf-8?Q?hRiq+tHxuQvJt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEZ5b3hOZW95VXVaOVlSblB3d05ITFdKWlZrTkszbWtVTTh4ZU0rU0p0NXVW?=
 =?utf-8?B?bVpuVGU1eXVxaVE2M2Qxblk3TW1IejI2dVkxTjMycXc1UU9WR1ArMVNNQWx0?=
 =?utf-8?B?cUhaNFhNSVRoUCtKMldtVzVvU2lSRXY5OW1VbWNMaS84c1ZtdFZGU2huTlpL?=
 =?utf-8?B?UGk3Wk55WHU4VlVseVB4VXZTY0Evb1luMUN3NzZ1TGZZOXJLVTdoRDFteEho?=
 =?utf-8?B?ZUl5bGJ0RHd2eHNFdFZaMVlpVHhqdVJHeUpGdXRMbEVCd0ZBNi9WQ1Q0clIy?=
 =?utf-8?B?QkxoSVFEeVBMMEJFL0NvSEhjSmcwc1loWFhLLzJLUlNSZU11VjQxVVVhR1oy?=
 =?utf-8?B?TjNHS3BtaDNPMXNoVVNxeXE4cHZqVDNMUjJ1THZSYXhyNEZSbkJ3TUFzclZO?=
 =?utf-8?B?a2pVLzkwanN5K1lxNGI4K1JzK1NGa2NBOThBbW51OEZuSDlmRTQ0MlROVXRB?=
 =?utf-8?B?dlMxb2FvTnFlcUw1RHNzaXpkaFVHZnNnWHBwd2ViUmczU1VUWVR1Q0pLOFNx?=
 =?utf-8?B?R2ppYm9qZ2VvUVpLNXRkZDY1clpFaHRpNkM0akR4S3c4ZWFPSUxsU29TS3Ni?=
 =?utf-8?B?S3NqbjM0Wk1zUmdCWWxiYlI4R3A3VWh0N05iaDEvT3FEMnpIZkYrdzJ5UHg5?=
 =?utf-8?B?ZHV3dmxOUUI4SGlpRFZPNDJzcDRZU1pnZnlsYjdOZGlZTXZzWUwwaS9xSzRV?=
 =?utf-8?B?UVJWNTU0OCtWdFVyNGh2U2hzZ3hReS9aVGRhYkx2MVFPT1hqRUpvVkRCRmhZ?=
 =?utf-8?B?TEZkZDg5V0xHbUlyOUhRd1BQNzlXOGFKOUVUSFpzQkRNSWJiSWNuelhmam94?=
 =?utf-8?B?OGFTZGRwZHhPY1dESG1yczBHcmY5eUcwd1RiMTc4SWZaSHJVMEtvZXNJYmhr?=
 =?utf-8?B?WUhFOTFRQTZ6Z1JpKzZUalBWcU1oc1FEVWlmTW5kWDd3M3ZjMXBMZm1jaDRI?=
 =?utf-8?B?U09rWUpxck5qNXBveEdMWU9xOS9qcnBlaG5HL0JWNlVHb25sOHFMNThFbkpq?=
 =?utf-8?B?d1pQS0d5amIyOVpGK2llR3dXY0lYeERTS1UyTnFPd2QvMjJ5SkVqOFZ2VG5p?=
 =?utf-8?B?aTBhbGI3Q29YcW0zT1pUaTduZTlMRmJvbkttdFBod2ZWcWt2RXFEK1IwR1Mz?=
 =?utf-8?B?cWZ2dlpRdnA3a0JTTWdrSFRsRmFaSFFSZmdLMmlHK1Z2S2JGSG91RFVIcURh?=
 =?utf-8?B?NVd1dDJEMGtXd29WSWFib3pYTHdnZks1OFBrYXFRZGd6UWlvOTRCaWVtZ2xF?=
 =?utf-8?B?dkloUzEvVnN0YXk1RzdYMUpTWHY3dmhlMzRPdG5oa2g5S3VnclRyZEI2SWpI?=
 =?utf-8?B?UG5kUmJlQ1pDQXZlVEhNY2cvL0hIUmI2bmZEQmUyVlpKcTlSWldKMXVZVjM5?=
 =?utf-8?B?QkpYeFdYNU9ySVlmNXVYWkpwNG9IRGwwSXZzSGptRWVmK3pSZzlCaWQvbHhU?=
 =?utf-8?B?em00dC9EQUplQlBNUDM0eTl1MktsbVRYZk5zRCtXeCtJQ0R2cnBsencyR3Np?=
 =?utf-8?B?cUd0bURLT010c1V1LzgxVjhtcVo2M01qS1R4bWJGZ2t4LzE5OVJ6SnM1L25V?=
 =?utf-8?B?NnhvWjY5UWsvbHgzVDRya3BheFBoQ3puNmNiUnJJT1VhMWhHcmZsTzRGUlZB?=
 =?utf-8?B?NmVxODJNcWxhQXQxTlZMeGYzLy81dEhwRDlBMU40bVdhV3A1cmhtMjdmMjB1?=
 =?utf-8?B?UlVxcnJwY0o2cGszdVM5WFJRc25mcFVLY3ZqcGsrNXcvTCtDcFU2V0k1MGYz?=
 =?utf-8?B?R1FiMzFBNGUxWHdHRndZbll5N0FwRDVVZ1hUcmdXTTdnRlp0NnY5SEFETWoz?=
 =?utf-8?B?OEU3Zks3UnNPQW1Oclp5b1k3dHZrdlY1blptclZJT0tmMHBRUVNpNmtBa3Uw?=
 =?utf-8?B?UWptT3B5THNuai9wMHRZZEo0WklNL2pHcmJPYkJGcU1iaEgzdjZoOXBSTTVm?=
 =?utf-8?B?VlJtM3BTZ3l4ZzRSNDhsK1dCM01Gdk5kcE9VNkZZSmJlcmcxTmNMWGNaR21y?=
 =?utf-8?B?ZkdtZXExSnJXQlZaYW1oeTVacXpBSnlGcXZhMXptOU42L3BFWGVtN0dkRnJE?=
 =?utf-8?B?Qm52RWVxSVo0Umw3OURoU01VZFBPTlovcXlwek9RWGtzMkNqUFBIenhETGRD?=
 =?utf-8?B?MDNXNWRXaTR5clBjejFjYmFEUEpQNHJhUWVUMm9VTFFoL0U1NUpjRUxKUURr?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3284ACB0CBB50049A9B568C770EA2940@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b9511a94-feff-4895-dc40-08dd0585e776
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 14:58:02.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NvkbXAqg2EvU12xONwWnfcgrIMesJ79M5LUpDyV5pu3MWdvwNQGUaaGe1k0R2FFQa+TZ2a9VhJF8bwPNuqb7elPvmVxCRXKqISwHjaSBZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9551
X-Proofpoint-ORIG-GUID: TEakQP6a2clR2oJS5l1c4LHFq5PaXtzI
X-Proofpoint-GUID: TEakQP6a2clR2oJS5l1c4LHFq5PaXtzI
X-Authority-Analysis: v=2.4 cv=YMvNygGx c=1 sm=1 tr=0 ts=67376180 cx=c_pps a=RRW9qgVLUv3Tpt3ACdNssw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=q48U0sNtksoaHmRLNCsA:9 a=QEXdDO2ut3YA:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

QWRkIEFSQ0hfQkxBSVpFIFNvQyBmYW1pbHkgdG8gdGhlIGFybTY0IGFyY2hpdGVjdHVyZSB0bw0K
c3VwcG9ydCB0aGUgQkxaUDE2MDAgU3lzdGVtLU9uLU1vZHVsZSBhbmQgdGhlIENhcnJpZXItQm9h
cmQtMg0KZGV2ZWxvcG1lbnQgYm9hcmQuDQoNClJldmlld2VkLWJ5OiBNYXR0IFJlZGZlYXJuIDxt
YXR0LnJlZGZlYXJuQGJsYWl6ZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBOaWtvbGFvcyBQYXNhbG91
a29zIDxuaWtvbGFvcy5wYXNhbG91a29zQGJsYWl6ZS5jb20+DQotLS0NCiBhcmNoL2FybTY0L0tj
b25maWcucGxhdGZvcm1zIHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMgYi9hcmNoL2Fy
bTY0L0tjb25maWcucGxhdGZvcm1zDQppbmRleCA2YzZkMTE1MzZiNDJlYzZlODc4ZGI4ZDM1NWMx
Nzk5NGMyNTAwZDdiLi4wOGRkNWIzYjJkNzM4MWEwMWJkNWM0MzQ3YzI5MjAyZWRmZjM0OTVmIDEw
MDY0NA0KLS0tIGEvYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3Jtcw0KKysrIGIvYXJjaC9hcm02
NC9LY29uZmlnLnBsYXRmb3Jtcw0KQEAgLTEwMSw2ICsxMDEsMTEgQEAgY29uZmlnIEFSQ0hfQklU
TUFJTg0KIAloZWxwDQogCSAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBCaXRtYWluIFNv
QyBGYW1pbHkuDQogDQorY29uZmlnIEFSQ0hfQkxBSVpFDQorCWJvb2wgIkJsYWl6ZSBTb0MgUGxh
dGZvcm1zIg0KKwloZWxwDQorCSAgVGhpcyBlbmFibGVzIHN1cHBvcnQgZm9yIHRoZSBCbGFpemUg
U29DIGZhbWlseQ0KKw0KIGNvbmZpZyBBUkNIX0VYWU5PUw0KIAlib29sICJTYW1zdW5nIEV4eW5v
cyBTb0MgZmFtaWx5Ig0KIAlzZWxlY3QgQ09NTU9OX0NMS19TQU1TVU5HDQoNCi0tIA0KMi40My4w
DQoNCg==

