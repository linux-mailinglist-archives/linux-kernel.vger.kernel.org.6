Return-Path: <linux-kernel+bounces-196739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB1E8D60C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812D71F2426F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6573157493;
	Fri, 31 May 2024 11:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CqO1PTOt";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0r3msg0H"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5758173C;
	Fri, 31 May 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155374; cv=fail; b=lmtUdWYRyG9yc9des50fvOaG/qojNimV8nWqAC/WD+x29hgU1/BGcOwujTF4s0M4MKQb503UenlK9mU0Xxt7R/WDVlsdd0UNDvDkAbkJ9oelZELWjUuLpI/xNBR2llWT65mxec6aAaQ9BO1J9+evDkVshq9vP0GuOUkwt2/Z9KQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155374; c=relaxed/simple;
	bh=FuKaTxRN7xuFykPf1lBirsAngbwIUwSzpCUtrhXk9eg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVKP1yoDNWTo9EP95VvhcXV20aTte4I6s2tzqnttmF4JnmQn4P30ITkU73xAIfgPmkx8B3Fqidb5KSUF1x7U0ehWPJ7kSIl5ZlZ312FJzJhqkXilyoSQJf5BSF3zzgDwhUqtahu73EWb3VgDO1+hPUG/yfWCDfO8TUpzDFHHHHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CqO1PTOt; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0r3msg0H; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717155371; x=1748691371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FuKaTxRN7xuFykPf1lBirsAngbwIUwSzpCUtrhXk9eg=;
  b=CqO1PTOtG7+5euy2wVq2EAI9OELHvRxDf5Eh9dryzuOIModcOCIoiPlF
   BTb2foGVIYtVoUvWrXp8Kt7YZFCZATPttLc9WvN8P5KOiYK/K6QUqWDIT
   6U3W/tq4gBlgRMF5QWAjMVHJjv4jNaxEZgcALd1RhMWgMmN5xPQIFLweA
   q6c9BYD206MMqznkkb+WDmu4yL/wIi57WAZGjVOKOuibstCIdx99vUdYv
   HKpSLV2hbGPT9wEtIUIlqfPjkDHL/DGjGvFugC/W3q2JM7iXnwjGMu6B0
   KEaXDUGLkEAbJ7z5KIgYJu+19qNrjvYwdsH6/zm7s25KjlfQ07pjBvNyK
   w==;
X-CSE-ConnectionGUID: 6pgX+NWmTCesRulOcGOu4Q==
X-CSE-MsgGUID: dDPqDq8FRDym8SFb6yBERQ==
X-IronPort-AV: E=Sophos;i="6.08,204,1712646000"; 
   d="scan'208";a="26804736"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2024 04:36:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 31 May 2024 04:35:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 31 May 2024 04:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bM4X/PfvSHjLwZ1r2qNnXaL/GH3+C1YZbUdZGGYC2iPPwSsRLugqeLWbxUQ2BRK2ur9/gl9VOtSyBGnNB2MN2j+ZZdG85IYyq1mtVi+GyMycpAHdF2j7mArNtwdfdE3pjrWdJGigz6EOEH/S34mAyKiZVuq+PkeElnNwdMljCYICg9sK4QjZwRTRUqhBMsT2qGiEnOMPFG0HzI4wILGr4+R3/5lmuPXDZzpjlC7aN9aGB5FceD6C2UISgwLs5hxBFJz0cjYjCvZxZ548jHmfHpw6QuokGIrxlLiuKuiX7SjcgyLskkGEvKWQHQhB7s35WSv9nt//J1qDlYFsNBJk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuKaTxRN7xuFykPf1lBirsAngbwIUwSzpCUtrhXk9eg=;
 b=TXkj/vBU62D3rD6ry0edXfdTZn2tfna4TjqTXYXl3On8eOvqbDbAdgseBlhGZKUiZkIzn1nfQMdvtoop53fFnxdbF54CrPJcHNOhcj3E/zW33yB0X7hWD0Rw7CwGKVC8DAlqZLkpk7trDn4kWzmLVZngcsOt2cHodmXfWPTbfK/ls2Yu7xJ48mOx+937ShZUbn61gZYdDAwZDOwS33VScGtCcDXi/QNIWq5YxsHV2oVSTig7ABP6cQeZs/YakedO8NNj9VV813zE905L9+0uh9hJzSMqNfC5o1YwIL3i9NZnvbkuUcxi/bDDlDnCmrJpA2q+9RO7xf3a5cJtqFU5Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuKaTxRN7xuFykPf1lBirsAngbwIUwSzpCUtrhXk9eg=;
 b=0r3msg0HvrJpJs9ibsUHDp1AFSoatnr4SIeKzSVREqn1z0qzlMINa7eLYvTupTht3pbBQHVtIu4snWZsu+MVmtBiJUckbEgdTYuVK3b1i78bUWeiEDHQ5xn7mJgCNDCHxTNLtK19ILPasqmH8c7935XuYKw5USFMyCT9ytVU4zZGgK0NDSTrKehluizBoqH9LY1aFymgGTeuS0MpoD94kz7Au+Q9r7vMaEKkgWN04MCWCEkRipV+CaGge+nJyMu4PkbcxCKx6Z9E0wXF0HMy2WytAXR6HyXQEn1b3rhPKjsGszUIhw4/r1w6No2gZ/4j+Yp9L+xkCuj0xyLp5KA8BQ==
Received: from BN7PR11MB2723.namprd11.prod.outlook.com (2603:10b6:406:b9::25)
 by BL3PR11MB6388.namprd11.prod.outlook.com (2603:10b6:208:3b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 11:35:41 +0000
Received: from BN7PR11MB2723.namprd11.prod.outlook.com
 ([fe80::66b9:8eb7:46c3:f39d]) by BN7PR11MB2723.namprd11.prod.outlook.com
 ([fe80::66b9:8eb7:46c3:f39d%5]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 11:35:41 +0000
From: <Conor.Dooley@microchip.com>
To: <inochiama@outlook.com>, <jszhang@kernel.org>, <guoren@kernel.org>,
	<wefu@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>
CC: <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: dts: thead: th1520: Add PMU event node
Thread-Topic: [PATCH] riscv: dts: thead: th1520: Add PMU event node
Thread-Index: AQHasoMxOn7F+1z5WE2E9wBfYns/L7GxOD2A
Date: Fri, 31 May 2024 11:35:41 +0000
Message-ID: <400f0bd3-3033-47e4-a5c1-1e164e5850f6@microchip.com>
References: <IA1PR20MB4953BA3638A0839FCB0EF86BBBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953BA3638A0839FCB0EF86BBBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR11MB2723:EE_|BL3PR11MB6388:EE_
x-ms-office365-filtering-correlation-id: 50cf5310-910d-43bd-756f-08dc8165cd0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?Umx2STB1SUJUMmgyV0VDU1lvWGpLQkcya0hXcWRCVWpZVmo1Njdpclo1N0xY?=
 =?utf-8?B?ckpwSU5vdzRKSXlER05VenZJbFBPL2xlZGpvRXgrU3IvbmNRY0NXS3J4VlJD?=
 =?utf-8?B?bllZdWxKbmJ1eU5ocXZjbmVjS2xLT0dkak43ZnlaR0luUnVBQTNrN1gveTIy?=
 =?utf-8?B?ZFJkb3d6eGljZEU3Tk9DUzlNS1Z6TVVkcjFuU3pIN29jdFlMRW9tM3hvNEJG?=
 =?utf-8?B?MCs1MU55TkdEZHQvaFNwaXNvTGFCd29LL3VXV2Q1VVRkTEp4MnlZbEhoa29m?=
 =?utf-8?B?aEdGaC84RHN5WWFNRUdCVVYxaVBTbTMwbGhXUmJVejMzWnFXS0Z4M205R1VY?=
 =?utf-8?B?STRycFcybGllYWo1T2dXREtKQ2JGTWpPdnZXN0R6RjE1dDZicVRPN2kwaGZv?=
 =?utf-8?B?RWI0eE5kd2h1MnNQaWNKS296ZkNqT3RuVHJsdnF6L0Nkd3RnKzhvdXk0amNr?=
 =?utf-8?B?dXpDYlRKd2gvdlRWb2cxRHAvcE9yTHZTYWVCM2xJY2kyZm5qcFJIbUF1WHo1?=
 =?utf-8?B?ZlgwYytwd0NoQkRhV2FudlFoOWFENk1DWUQ4Vkg5YUFBYXFVL0JSOVNmZUZl?=
 =?utf-8?B?d3RIV3FlcFhmaU5aNVRUS3BPV2o5cnA4dTBDNVQvMCtxM0FidXh1R250N1pG?=
 =?utf-8?B?VU9TRk1EUGxwVzR3L2JaZHpNcEg3SnoxU3pDRXgrMnNPMkMyOU9lL1pXOU4z?=
 =?utf-8?B?Ym9RWnZHOTZrSTJrWVdXSlREWnNhRUJ4TkdSNWRNYlhFUXJYV21ka3RYaGlC?=
 =?utf-8?B?MDdIekdBOEQ2VWlYZDFCMFpheWcyeXFWR0R2VWtmQXNpcENRNVBFZjVTNGtr?=
 =?utf-8?B?QSs5TkhHanNrRmZyY1YxajdkOXJXZGZENHFLVm9jWm50a2IxNHNRQWZDeUdM?=
 =?utf-8?B?MGtXa3JUUHB3dGdKQzJKeFl2cE5TdE9hNWZJRmVhWkRxR3hFeGtLSysxVmpt?=
 =?utf-8?B?K1p6SFByTXJsMDJsQ1lJdzkwbU1vMnVpY0d6ajc1RFptRk5XOS9IK2RwT0hl?=
 =?utf-8?B?emdYUEtTaXA1cDZNUUZyS09JWngvUFNhZ1JndXJJenZ5QTdWNk1uRTJKV1Fi?=
 =?utf-8?B?YTdJc1FnMjhYaWtHby8rOU9lVGFXdi80YWdWRkFvdUJRMnpxSEhEamVpWXFw?=
 =?utf-8?B?UzEyN3ZNckpsU00ySi9vQW90WHNLdzhWSXdocUl3eTQ0alZXKzI2TWx5aklr?=
 =?utf-8?B?VTJwWit4UlpaenlJb2VlcjhnS1FYQTREZlRES2pzVzFzZHF1VGphYmpXbWMx?=
 =?utf-8?B?V2NvOU04aEJpZlpvTFpYbkVGdTA5OXRoOEl0UzIvYnJLbk00VkY3aC81WTM4?=
 =?utf-8?B?c1NOczJvSGpHS2pJaExCSkE1NG9wV1lLd2tib2daM3E1cVJPRDdZb1lReXJl?=
 =?utf-8?B?aHhHTUhZNWxYdnB4Sk00YkIwWk9kWFUzUE5JaEJsVU1qSzhIV3hzWnc5M2VM?=
 =?utf-8?B?QndaaGtNSVFNZDVZbU1tTXhBSjdOb3FwN0l1VVlXanZPN1lmcXU2ejlpZlJK?=
 =?utf-8?B?UFVLRTEyYk1NRnM2UFQwcEJtdXN6bnY1Q1R1LytYOHM5STgyaHo1a1I5QzNr?=
 =?utf-8?B?bEYxL0VDN0c4MUNHbU96TUdORDlUKzJKcmFYUThUNXdYQ1ZqOSt1MlIzQWVH?=
 =?utf-8?B?OHhmVkNVWWRxYjZNcVNuQStlQUZ2MVRLZ2lDVFdiZHErR0w3Um5lRkpjeXFQ?=
 =?utf-8?B?Y0t3R2JOaXNpclByM2VRQ3N2UEh3QVg5dDJXeGQwYmRFaDFnakFSamtqY3Fv?=
 =?utf-8?Q?wzM1I4WDLcP/uM6b40=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2723.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTRjRFhyUXNpM0plbk56M3l3U3pjUEZ5TFlIZ3hiSjdTOVJsbXRoRnpvM0RR?=
 =?utf-8?B?TFE0REk3ZndWa25IK2xacUI0bEpiTSs5MWhJVi9UZVNRNzNqVjl5RjU5bmtO?=
 =?utf-8?B?bXJHVjdlWHhKN0lRVHpvUEVKalFwMjU3Sk13bytnQnBtUmE5Ync2NlBOVFJl?=
 =?utf-8?B?ay8wZ2RFV0FWU1lrK1kyYWdzdmJrMFRPRm15VXhMVC8xcDdNa1B3YXQ2TE5x?=
 =?utf-8?B?aFB3NFk1dlIrMjZNdms4anJ5TXBwYWMrOEFLMmttZTg4OUNTN2tlRmM5T1JW?=
 =?utf-8?B?TGU0bUd4VUNyK3RpS3hNVUxCd2hoSlpYZ2ErYTBzVWd3SWhtOTFzUmMyMHBP?=
 =?utf-8?B?ZWNTWlFMaVg3NXVRSFZ0VlIxMTVHeHh1dDNld3FQVkZvVEN2UHJxVWs1VVR4?=
 =?utf-8?B?MGZHL2szUWRGdVE5aXlpdjk0UjVhTTRLWE8wNFdBM1pkd0N1cUZjQ3FTSDZh?=
 =?utf-8?B?cnFUWUN0S2FSME05b2NHTXZ0LzIyOTRGalZicE9aTWVvOVBxUVJjdERpcE16?=
 =?utf-8?B?NkUzc1JSODJtZ1h3UUQwSXU3b3JEYzJyYlpNN0hQV3JwN2pzbWNyNzk0N1Jo?=
 =?utf-8?B?b0YyMmpYYVRwa1poMU9ReTYyanBuTzhNeWVWRzc0UmwySHhzd3U4MWhKNmpM?=
 =?utf-8?B?WTFpNzdiUXFQVEF2L1R4ZjA5WjhQSGpHLzNVZ201YndRdWJDMCsxM1dhM1hH?=
 =?utf-8?B?cDlnaDFHYlJKZHZsUDhQSUZ3alhBYmFtU1RkTG9SbTR0MWJkODBneHNUdkU0?=
 =?utf-8?B?bE9zYjlYS3ZQNUp3RHhWRnBFaXprbndWb3BDQ0NuMXRWVkRPR0UyU1liaERj?=
 =?utf-8?B?S2toYzhsMG82VnNUUXIyYlpSWFVrdkVTTlhQVnJ6STFDVEVHRkZ4cDgrQUJv?=
 =?utf-8?B?TzZLT2t6MmYvc2xsNWwvQVdEdHN4SWh3NzlEckhsWnRRT1pDSkZYQ05lQ3V2?=
 =?utf-8?B?VGt4L2JGbE9GQW1oeHcweHZOZlBRWHBzYU9jZEdYbnBnM290SE9TSHVBQStJ?=
 =?utf-8?B?cytMc1diY3JYc3l4SkFMY2NWM2xVTmg5cWlBcmhxd1d5MUFjSGhLODg3VzVo?=
 =?utf-8?B?RHkwQ3hrdStCRGg1dmRIbTFzbWx4Wlp6REw4YXFmV2RvV1UzeDY5MWFoMzNZ?=
 =?utf-8?B?S2Z6dTErNXNxN2dkWmdSVHdXWFVoTjVGSitaOGRwV2lscmZXdVZsN1c3d2Fm?=
 =?utf-8?B?S3grWkR1V0RxQXMvMWZyNHZoSW9Wd0I5YkFwVnhqM0tSSGpGTlBleHhVTCtk?=
 =?utf-8?B?eG5nY1hyQ24rRmJDRDR0M2VsM3ROTjF5ZGFDUHZtTmdTRDdnZE03Z3MrakY1?=
 =?utf-8?B?a3ZISE1zM0NlMXBoMHl1UG1RQ2xqK01Tc3dTNWNYWXlyV2pHaFZTSm1zaFor?=
 =?utf-8?B?bVdKdTJleVFzWDlSNVpCSEt6QncydmE1SkVybGx6V2s1am1pRGw2VjlNZXV2?=
 =?utf-8?B?MjhvZTc3UjJkNUduYlBsNUZVZXlmWDRlMFg3blc1dUFvcjh6MVZ5dklvM0pH?=
 =?utf-8?B?cWVwdWdnSVJxMXJ3UG1VOExOZzgzQUxhRE1UTFVWamFzRitxeUMwdXJwenYz?=
 =?utf-8?B?MmIyL0F5QXREZzJ0T0VTczFLaHFGaitzSkk1RDNLMmVocWFGZ0hOcEhrWnBM?=
 =?utf-8?B?Rm9OTXBNbEhEZXIyNUV0SDB1dFRIeC9HTWNNZ1pQRmcwUEhmMEhHeUIxdVB0?=
 =?utf-8?B?cW1iRzRoQWZpMkZXekZVclVDZWJMZmJLclJHYURFR0swaUtWREhXRmQrZG40?=
 =?utf-8?B?SDl4TURyTUZVd3pnWVZ3NnFSSDhOVUJvSFE3a1lwK3R2WS9UaGV3K1NpV3hH?=
 =?utf-8?B?a3dpR01Oak1ZZkZiQys0MW1JY1NLOTdkYk5WVXlHbDBubjRmcUl3Qi9qcU9H?=
 =?utf-8?B?Z3dXWmhEekFIWjZMWjFHWmI1QTlzNXdYRU0wem9PYnplOHlOci9BQVhVNGhR?=
 =?utf-8?B?SEQ5c0s0R0wyQUtKWDgzMlY1cjhaWTBaeHQ0M0hlVTZvSktRTDZFajJKTTY3?=
 =?utf-8?B?U2xwOXhCVlJBOVdWMDRHdnZrK2RSTFRSdjBWU1FJYUZjUThQNW9yOEM2SkNv?=
 =?utf-8?B?bThSUUVNelRRbFR4M2ZxdGpHZUs0UFhnVEhNVENkSmNQL2I1THBUc1lPLzgw?=
 =?utf-8?Q?AqsFtc2KAe2JFWFvs77IKxnpg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BED6E1CA7688640B6D09031E9C9E639@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2723.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cf5310-910d-43bd-756f-08dc8165cd0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 11:35:41.1418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IrHFB1R5Mm0ojrdd4Dx3hOCHazLo3DqNi5LX1VwnKGCNbBQPU5eoM+bTkQxrgUOf2CVl+QM43Oi4EyKxML5E2m211zqwhl+N91/1SXpI7bs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6388

T24gMzAvMDUvMjAyNCAxMjoxOCwgSW5vY2hpIEFtYW90byB3cm90ZToNCj4gVC1IRUFEIHRoMTUy
MCB1c2VzIHN0YW5kYXJkIEM5MTAgY2hpcCBhbmQgaXRzIHBtdSBpcyBhbHJlYWR5IHN1cHBvcnRl
ZA0KPiBieSBPcGVuU0JJLg0KPiANCj4gQWRkIHRoZSBwbXUgZXZlbnQgZGVzY3JpcHRpb24gZm9y
IFQtSEVBRCB0aDE1MjAgU29DLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSW5vY2hpIEFtYW90byA8
aW5vY2hpYW1hQG91dGxvb2suY29tPg0KPiBMaW5rOiBodHRwczovL3d3dy54cnZtLmNvbS9wcm9k
dWN0L3h1YW50aWUvNDI0MDIxNzM4MTMyNDAwMTI4MD9zcG09eHJ2bS4yNzE0MDU2OC4wLjAuN2Y5
NzliMjlueklhMW0NCg0KQXBwbGllZCwgdGhhbmtzLg0KDQoNCg==

