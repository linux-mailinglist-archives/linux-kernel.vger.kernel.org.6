Return-Path: <linux-kernel+bounces-240733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53C9271DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B070C1C21D61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 08:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB271A4F06;
	Thu,  4 Jul 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YE8P5NHK";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Wu73Lax/"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107A91A3BC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082180; cv=fail; b=mxhB+bUT7bM3YFPd5dZuvFdmktXYldhSXqh8LQy0isfrL7K5z2evAvhnKi5R+llMlOpelw97d/stnrZAr/975pyYcO3ue8ddJPjAAS5Nz2Vkvzk0WAxHPb28PfdC7mtVG21HeHEXnd8ZhnhdQr1BnoSI9TPMtTfcPxP+ntTC1ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082180; c=relaxed/simple;
	bh=nUyfTBaLReMwp0R/1v0S3vMcjOd5kslYl9GkDQz8cVY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OnZY8HOtxmzY0pdE1h3mbaXSnvaIfe9091pevK/YLKfOboBFdZdNPyJ7/Lgwhu+eLjE0kRVW0WZ5BbGSKfrYo+ue7hIck6hrq2gB+AFgfBU9ZVtALkGK1QgKjqL7dppyyF2DqzFg5YboxHVMO1pzz/RaGkaNtDUW3c08bQk/vwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YE8P5NHK; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Wu73Lax/; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720082179; x=1751618179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nUyfTBaLReMwp0R/1v0S3vMcjOd5kslYl9GkDQz8cVY=;
  b=YE8P5NHK3ItJ9dzjbRvpiU5LfXjLXeaawegPij1K7ejbum1evTqbk9ge
   zWwFSd9BZFQBHT57x9BUNTr5PGgoWgM/PdJxrUE8IvYyElk9W+kwnBUJ8
   uJ569D7m3RAmxEniTfYRcQ485g2dVwZgpWmP1/W+Va+urVbWlfze9N/8M
   yqYnxqd3B8ahCMS6D+n93fGqY+gnGnawx44qdIsJYScx9AFitaXKmcgP1
   G6LOF2ZJXEX5Gk0T8IA3z+BI9oKFAd41BJcrFr/fmy/Q5PlC02ZuTQRiI
   NvnBFHHA+euVgLZwHcHYgO6xPtihQzja7X+yF3qFpmjobMO4Ol3Bv99p+
   Q==;
X-CSE-ConnectionGUID: fVr+LTFSQsWhp9TszwuyKg==
X-CSE-MsgGUID: n8PAUGQaQfCXIpUXOrIIsg==
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="259727067"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2024 01:36:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jul 2024 01:35:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jul 2024 01:35:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFA4OI+yFi+ZJhFbg4BY7Q763IWS97yQKFiGNV+Gp+eIm+ExTmbq8O+mYGf5oGssB+h+uATFFwWrJIL7x+cVyjUcFO+bRu/12299AJx/14eiRgb5xIjgh5LVTuW4UrMznYJGJHVNUxH0DgjhBw1y9feono1vvrDRZMet5FpspjrC30s87M/N7Ez4btNWajvieFgJzOu1/IokCo4yqynp2MCYmULS/0gzUNDReTWRAZGJciOffdtwItqBiHwBM03X2q0GtfPL9tXQUPteRKLTQXyghT9A9aMEuV8/fM3+vslfBHwnEWrHw1D+/Zv5J+FyV9m8kH22Mzw6xFqsiZWNNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUyfTBaLReMwp0R/1v0S3vMcjOd5kslYl9GkDQz8cVY=;
 b=CQwtwn0S7o6nG6jpRMFqDnKD9V82wkwBIrwtXTEYbeZUQgT05t4PT8frz2XLFsef5aoZHctBO21/jN7eWHANEFLzlQ4wg3D50qzZxrkmmLa5eprWK/Cff6BXVYrqhAy9prBSmTAr4E/FnInIRy3x50PwOPG4PCNSYcpkQqXPWtMq4T4yk6JHI1cY4nrkLYNlQaLrv5+G2/3ws55jG0b/otv8V590DOUqsqN5pOsUelm0/KPDgQ07GrmIYLmvXTKkuDNRksCQIMY4Vnh0jbXBD039BzI6BpG/IqVLXcMDTzRXD8OHGGNGfvN6zbXlkNjYuuhdDteMgQFGcVutXs8fGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUyfTBaLReMwp0R/1v0S3vMcjOd5kslYl9GkDQz8cVY=;
 b=Wu73Lax/ZqhAmjGPPlyjJIZeU4yHKVBeJT76eGcNvq5aRFAH9Tx7LfEiFHP9hg81b1ckc/o1VLchRezAj4xFGS8QC9Nzn3CqSqiHCmtCBtxOrkbNVZjWj8PKsSwLnSOCocccMNb3G9oGhUaMgSHdugaCq5z18osZ4Ftqza4waS9+f1L+RvdIkzwLRjnzRRZN+LdYfNuTJJT0WQDj2wOs2AQrXoCOfQQpkqIzmQN6GFV+5K/gYmJ9yFgvxrsyEVo8SBRjfM48Ya6+99y6y8c46krAPFGKLEY6FPfmcUX8bKG4I8eomj+rGQVNmtypbmIrJbeXJRHT1J642qNQOplxww==
Received: from MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13)
 by DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.26; Thu, 4 Jul 2024 08:35:50 +0000
Received: from MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7]) by MN2PR11MB4711.namprd11.prod.outlook.com
 ([fe80::592e:a53b:e0b4:5da7%5]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 08:35:50 +0000
From: <Varshini.Rajendran@microchip.com>
To: <alexandre.belloni@bootlin.com>
CC: <linux@armlinux.org.uk>, <Nicolas.Ferre@microchip.com>,
	<claudiu.beznea@tuxon.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 05/27] ARM: at91: pm: add sam9x7 SoC init config
Thread-Topic: [PATCH v5 05/27] ARM: at91: pm: add sam9x7 SoC init config
Thread-Index: AQHazTOXd7sb1Z1OD0OHynwkrYDurLHk1J+AgAFrUYA=
Date: Thu, 4 Jul 2024 08:35:50 +0000
Message-ID: <09bfa09f-9a98-4d09-bc3b-0abb41304d3b@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102702.195564-1-varshini.rajendran@microchip.com>
 <20240703105527c859341b@mail.local>
In-Reply-To: <20240703105527c859341b@mail.local>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4711:EE_|DS0PR11MB7904:EE_
x-ms-office365-filtering-correlation-id: 819b6f27-89a5-4476-2ff5-08dc9c044f44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cVdsY1lhdVltVzhzdkYvaWk0L1dhbEZXRUp5c3B3NWFpK2dUUVhYSHVidUxz?=
 =?utf-8?B?NWt3NlRJQWFRb0lGTWRlbytaVi92NDVSK25WUERrWmNWZU9tNHVnNnVBUU9T?=
 =?utf-8?B?U0lZeDFBTXV1T0N6a29iWEdnUlgyZWZNWTVYK2JjRzFKM0xPSVJ6TGtVNlJh?=
 =?utf-8?B?TytnT3V0VDYyOWY0RkJvdlBZS0xxaXhveERDcHEvTWp6OWN6ekFhRWZPa1JX?=
 =?utf-8?B?V2JJL283WDJpclZEaUpHNS9jcWlFRGpOYVZyMFRQVVM2S2IrSzJwbU96cW9E?=
 =?utf-8?B?bTdyVjQ3L09DTmVoSUIrcUxaUWRtaDZ2dEsyY3JyaVNQMUY0emNWZ05QTkJk?=
 =?utf-8?B?RktCbkxsWVJyT1hZcWlTWExORWMzM2k3Z2JqRTNvellzNElTSnR3WTJzRVpW?=
 =?utf-8?B?YVVudWxrbzBTNTRVbFFxVDNKYnhPTCtMdlc0bmdLd2RpenpEaHR4WWNOQy91?=
 =?utf-8?B?K3VxU3N0VERJTmNPYnUzSUlhOGlVT0duZ0Y1a3FHL2kvaFVhZmxoQmlUeXlX?=
 =?utf-8?B?Ynlva2greUNtMERVb1pqSjF3SkZvczY4ZkJYRVJFaXpJZ3dpNUdzU1N4MG1Z?=
 =?utf-8?B?ZmV0bEg0T0VEZ2oxcWEzOG9YZG5LRzFZVjR6bzdSbzY1WXAwZFJWTG9wOXJw?=
 =?utf-8?B?U29IMytkYlE1US9KYlZXeFJRVEVOdkd6OEE3cnluRTRsUXFYQnNScm84VEFW?=
 =?utf-8?B?bGtSc0NnbjJJMDUrZUppSHBpaGVjb1pjcUxOVDl1TFF5SUlhSUhBY0Y5d2lW?=
 =?utf-8?B?dXkxcHRqNkRhWUV0WjVFbzJJdGlOWUZLYVllZzMxSXhvV1ZoZ2FWUm5BZ2Fw?=
 =?utf-8?B?K1daU0FuZkpvSlJKdFlEM3VJQWdHS1dGVWRSMHRxcklwRWhPOWFuS05iZ0xp?=
 =?utf-8?B?VytXbkhMdTVPS1ZJOGZFK25zTzVwd2N6cWI1a0V1K2Y2OW13blJUYUEyWXhO?=
 =?utf-8?B?emllNVIvbVdnODRIV1BNeXpnVk9KUGlZdjhZN2ZMelNKeit5aUVoQ1huWFpo?=
 =?utf-8?B?Z1d1enlyRm5sTFZTamZwSUE4T2tMR1BsMFBqZW93dVhuUE03NlFOeXdVc1Zs?=
 =?utf-8?B?QjROTzl0UVlFSGw0SVJmZXVWdmNFU2EyUlExaTh5aW52SGxUa0x2T0JJczRy?=
 =?utf-8?B?aDJQV1JRRmpsQ1JSOThpcG4wV1Fuajc3RHVnZDV0RUEvS1FqdEFScnRSc3dY?=
 =?utf-8?B?VEJRYmNUMXk1WFNybC9UK3ZZVWFIeE5ycFBZT2kramJzZG5tMGxuSHlWek5I?=
 =?utf-8?B?NktRb05SNDBhQVZiQXk5aGh1dHpsaHpFOTFFSjQyVW1QQk9ZbGk2QUVzMXBM?=
 =?utf-8?B?K0tJT3dUR0I1WXFWN2ZORFpCVDlWSS8yejVPTTk4dU1HelQ0Q1BCTnR2TER2?=
 =?utf-8?B?NlhvOHZ5bytObi8zcTdFQzVqVXZIYjF5TmwyS3M2Y0hMamNMSlJXNzdVYWtm?=
 =?utf-8?B?eERrRWtCclhnZWgvUW5XYXgvY0N1WlBjZDVlaVh6UW1YbEc0MHRDZ3YwOVlp?=
 =?utf-8?B?T09qNWtmY0oxdWt1V3JMcTR5c0QvRFFFbmtxN2hLL0Z4YjcyWXh2WUlZYWFT?=
 =?utf-8?B?d1pnalFETTUzVHgzaFhzSTdsU1F1bW1FbGpWK0F0UmRyUWF6Z09qb3pzQUEx?=
 =?utf-8?B?c2dlWkZlakpsVnRMLy90ejdDM3dZVXFPNFBZVUs1bnUvZmRXWkk2S1ZWNS9Y?=
 =?utf-8?B?R3JMN3lCcDhiS0xvOU0yQ1ZHYjVOMmRaT0hPUTFhK1JVVTg5RHNTdVo4Wjcr?=
 =?utf-8?B?NHBXZWc5UmxtUmtoNHFUaUl3WTNWNEJ6Y00wTVdSQWNFMmZzWmpFQzIxZ29n?=
 =?utf-8?B?aGFxWXRvaWJtNHJnWEhCZz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4711.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0lqODlvQmgrYWhRMFB1SWt4VW1NMUgxNTZjWFMzeFJrQTA5VStCaDZlMWRR?=
 =?utf-8?B?eEo5V05IMmpDT2l1ejhTWVRWNTU3T3psVXhoaG13QnBPOTNTOStCMUJBaVJJ?=
 =?utf-8?B?b0RtbXNKN0xzSGQ2NGt2SE40c0JmdzR3K1JKVC8xVFJGMW5vTVBTc2NuTzhV?=
 =?utf-8?B?STc4Q3FZQUFRS00vMXhFMWljMW04Q1VINmpJb3NlUUUwTzlGdWhmeUd6WEZV?=
 =?utf-8?B?Nzg3VytuSUxncm93Zzh2TG5qaG5nWVY1YU8rU0tIYXhDVXBkZTNZd3haZndM?=
 =?utf-8?B?WUFCNFFZWG4zekorbGZacjZWWmdabzhMLzNLbVBVcENBZ1MxM2Z6aFUwRmhW?=
 =?utf-8?B?b3hSWXA4T3RJeFhHKzNLWE9MN2JKT21BazJ1d005ZzJDVjFBUktqbGhZK25B?=
 =?utf-8?B?ZDFBNDNJTlNIT1g1TURjUUtnRUtZSldYTzM3NWRCeFpSS3gxRURVdGdmcElI?=
 =?utf-8?B?dUtXb0hyRHE3eGRzbHBBUXNjUWVCM2ZTNUVWWEljRmtXR3J5MkxoMUF0akw3?=
 =?utf-8?B?VTJBVjljMmNyaElYQlB5UHlPblcvWFhaYi9xclhWeG53NTlnRVlsWHFyeDBy?=
 =?utf-8?B?cDNmSEcxdkMxMHpyK3ZwaGFnRlFRUStFYXZQLzI4VEM1bVM0MjJ3TW1NZlFm?=
 =?utf-8?B?V0pWanFhVnVST3FjK0dveHRIUm16UFA3cTBUR2pTTnBUZldLUFFldjFuQXM2?=
 =?utf-8?B?cU5zQ01IRDlrTEZiR1BPamNSUHRJbmIxUHQyWTdOUVgxZitmNWIzTEVnblVl?=
 =?utf-8?B?cVMvTllIbFBDNHJ1cHcrL1dVYjdyU0lrbTBacjBOd2dJK1VUN2FwYk5EcjYw?=
 =?utf-8?B?SXZ2eUVLdGRUZFJQRXcwZ1Q3bUcvcytaYlVBTWYvTWFyWkR5azM4b3Y4eUlx?=
 =?utf-8?B?NzNXTytyUC9wUFljb3pEZ25OU2JGTDZqVGUyQkM2Sk5iMzUrU1VzTHlZVWJz?=
 =?utf-8?B?MUcxOWYrd1lFWWtZR0Q1OWxUc2ZuQkp1RWFTMEFCZE8xQTlVOTdrUG45eVht?=
 =?utf-8?B?SWtnYVBGV2JLZWVlWTR5ZDFSRXFTdU4rZTRRa2hPbFBzUFdWWEhrQlBGcWdM?=
 =?utf-8?B?a09pai93RllINGlvakIvUGtLTXRIU09BY3BuZGh2VE1lenpCMzdOdXdqWEJL?=
 =?utf-8?B?TEVYVlJSc3RlZU5iSHViWS96SGkxK3RWQU13dlUxanBJbm1DQ0xQbGRrL1du?=
 =?utf-8?B?UTJkYUF6dTFwVzVLNWZUMDFUL0pVL1k1a3VOY04xT2l3T1AwTkoraTlWaUFU?=
 =?utf-8?B?cG1Qd0FSemc5c0g1Zyt5UktJdWpmdlZGMHdpb1FzbVRqYmxpQ2xKcmxOclFy?=
 =?utf-8?B?RmhnMHVaaWRwM01rMXprOHJFZk1sMFVUbm8zY3hRUlRvSVAyZlRoYlY4L2JO?=
 =?utf-8?B?V25kVEUySWNXcElsVmV3TkpXdE1XRkJWRlEwYkcxc0tpZ0JaSzlEVkRpOHZ6?=
 =?utf-8?B?b0xWeVd0cGtQVy9RVjlmZFdhSEZpbDFGTHkyTnhOa0FDU2VwUUF3VUNBcDh6?=
 =?utf-8?B?M244cEFxOFFrTVU0ZmdhODJJbjdISnRMb1NOc0tTUStuYTJpWVkrMkZlbEdr?=
 =?utf-8?B?Y3NvM0doVm1QZTlZOUNZajd5bjkwYWw5dzluU3MyR2JKdkhoOUVPcDdKUEZY?=
 =?utf-8?B?eWt5ODFnMEQ4amlxbkVzZmdWVkxvN2pkTHRBZnQ3a295Y1R2Z0ZhM3VTY1k5?=
 =?utf-8?B?ZTIxVUVydlZkaDl0d3RCcThFdjlvampPcEUrNWczcEpOa2dQMEx1S0svb0ls?=
 =?utf-8?B?QnYvZndDMjJTMktlaW5CSzIzRGx6c2xuWDhnY0IxNklJRjhFdlFxejVkNVR6?=
 =?utf-8?B?aGpTK3VjWThGeFdPVmdudmdHS014bUdhY0dUc1c5ZmNscDVhenJPeVBxU3J0?=
 =?utf-8?B?SDcweUpLeUd0UUVCSm9OR2FaMlIrbXJWRW9iSjBWeW9uTnNoRFQzdlpHOWgy?=
 =?utf-8?B?Y2xsa3B1SDREb1hpS1RoMGcxQjhNQ2tCbHppZEl1K2tkOXJ5MXpLRjVudDBz?=
 =?utf-8?B?dFZoWlA3bHJTd01LT0RmSWEzd2pWMTRRM29KRmVTaHlZcHVvSkVQaU5ldDVo?=
 =?utf-8?B?N3Iyd04vWVFlYk1hQU5PYWhwUTZFYjBEUVpaZGFXQjFEaFNzdDkraTRRZkJq?=
 =?utf-8?B?eUZsV1FkZjZJWWtlTngyVytwNExHY21IZXRQUmg1YXFxSWhtUktLcmRiNHVN?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0C9DA31F6B8B849A60363A432C2F81F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4711.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819b6f27-89a5-4476-2ff5-08dc9c044f44
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 08:35:50.2978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpKddelsW9gwBdBMthNSs+18UTOjFtM3xFCmcpOlyHvUzuOPt3rr2usU/vVb+UhBPAHjp+awOEcJs9MApPAMWPty16W9MtpzQWrsfVKTsAJVOTFWb8PwXwMTjx9KkfW4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7904

SGkgQWxleGFuZHJlLA0KDQpPbiAwMy8wNy8yNCA0OjI1IHBtLCBBbGV4YW5kcmUgQmVsbG9uaSB3
cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwMy8w
Ny8yMDI0IDE1OjU3OjAyKzA1MzAsIFZhcnNoaW5pIFJhamVuZHJhbiB3cm90ZToNCj4+IEFkZCBT
b0MgaW5pdCBjb25maWcgZm9yIHNhbTl4NyBmYW1pbHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
VmFyc2hpbmkgUmFqZW5kcmFuIDx2YXJzaGluaS5yYWplbmRyYW5AbWljcm9jaGlwLmNvbT4NCj4+
IC0tLQ0KPj4gQ2hhbmdlcyBpbiB2NToNCj4+IC0gUmVtb3ZlZCB1bm5lY2Vzc2FyeSBoZWFkZXIg
ZmlsZS4NCj4+IC0gQWRkZWQgYSBzcGFjZSBpbiB0aGUgcmV0dXJuIHR5cGUgZm9yIGNsYXJpdHku
DQo+PiAtLS0NCj4+ICAgYXJjaC9hcm0vbWFjaC1hdDkxL01ha2VmaWxlIHwgIDEgKw0KPj4gICBh
cmNoL2FybS9tYWNoLWF0OTEvc2FtOXg3LmMgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspDQo+PiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLWF0OTEvc2FtOXg3LmMNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1hdDkxL01ha2VmaWxlIGIvYXJjaC9hcm0vbWFjaC1hdDkx
L01ha2VmaWxlDQo+PiBpbmRleCA3OTRiZDEyYWIwYTguLjdkOGE3YmM0NGU2NSAxMDA2NDQNCj4+
IC0tLSBhL2FyY2gvYXJtL21hY2gtYXQ5MS9NYWtlZmlsZQ0KPj4gKysrIGIvYXJjaC9hcm0vbWFj
aC1hdDkxL01ha2VmaWxlDQo+PiBAQCAtNyw2ICs3LDcgQEANCj4+ICAgb2JqLSQoQ09ORklHX1NP
Q19BVDkxUk05MjAwKSArPSBhdDkxcm05MjAwLm8NCj4+ICAgb2JqLSQoQ09ORklHX1NPQ19BVDkx
U0FNOSkgICArPSBhdDkxc2FtOS5vDQo+PiAgIG9iai0kKENPTkZJR19TT0NfU0FNOVg2MCkgICAg
Kz0gc2FtOXg2MC5vDQo+PiArb2JqLSQoQ09ORklHX1NPQ19TQU05WDcpICAgICArPSBzYW05eDcu
bw0KPj4gICBvYmotJChDT05GSUdfU09DX1NBTUE1KSAgICAgICAgICAgICAgKz0gc2FtYTUubyBz
YW1fc2VjdXJlLm8NCj4+ICAgb2JqLSQoQ09ORklHX1NPQ19TQU1BNykgICAgICAgICAgICAgICs9
IHNhbWE3Lm8NCj4+ICAgb2JqLSQoQ09ORklHX1NPQ19TQU1WNykgICAgICAgICAgICAgICs9IHNh
bXY3Lm8NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWF0OTEvc2FtOXg3LmMgYi9hcmNo
L2FybS9tYWNoLWF0OTEvc2FtOXg3LmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRl
eCAwMDAwMDAwMDAwMDAuLmUxZmYzMGI1YjA5Yg0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIv
YXJjaC9hcm0vbWFjaC1hdDkxL3NhbTl4Ny5jDQo+PiBAQCAtMCwwICsxLDMzIEBADQo+PiArLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+PiArLyoNCj4+ICsgKiBTZXR1cCBj
b2RlIGZvciBTQU05WDcuDQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgTWljcm9j
aGlwIFRlY2hub2xvZ3kgSW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyAqDQo+PiArICog
QXV0aG9yOiBWYXJzaGluaSBSYWplbmRyYW4gPHZhcnNoaW5pLnJhamVuZHJhbkBtaWNyb2NoaXAu
Y29tPg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPj4gKyNpbmNs
dWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPj4gKw0KPj4gKyNpbmNsdWRlIDxhc20vbWFjaC9h
cmNoLmg+DQo+PiArDQo+PiArI2luY2x1ZGUgImdlbmVyaWMuaCINCj4+ICsNCj4+ICtzdGF0aWMg
dm9pZCBfX2luaXQgc2FtOXg3X2luaXQodm9pZCkNCj4+ICt7DQo+PiArICAgICBvZl9wbGF0Zm9y
bV9kZWZhdWx0X3BvcHVsYXRlKE5VTEwsIE5VTEwsIE5VTEwpOw0KPiANCj4gQ2FuIHlvdSBjaGVj
ayB3aGV0aGVyIHRoaXMgY2FsbCBpcyBhY3R1YWxseSBuZWVkZWQgdG8gYm9vdCB0aGUgcGxhdGZv
cm0/DQo+IA0KVGhvdWdoIHRoZSBzeXN0ZW0gYm9vdHMsIEkgY2FuIHNlZSBtYW55IGZhaWx1cmVz
IGluIGNydWNpYWwgZGV2aWNlcyANCmdldHRpbmcgcHJvYmVkLg0KDQo+PiArDQo+PiArICAgICBz
YW05eDdfcG1faW5pdCgpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgY29uc3QgY2hhciAqIGNv
bnN0IHNhbTl4N19kdF9ib2FyZF9jb21wYXRbXSBfX2luaXRjb25zdCA9IHsNCj4+ICsgICAgICJt
aWNyb2NoaXAsc2FtOXg3IiwNCj4+ICsgICAgIE5VTEwNCj4+ICt9Ow0KPj4gKw0KPj4gK0RUX01B
Q0hJTkVfU1RBUlQoc2FtOXg3X2R0LCAiTWljcm9jaGlwIFNBTTlYNyIpDQo+PiArICAgICAvKiBN
YWludGFpbmVyOiBNaWNyb2NoaXAgKi8NCj4+ICsgICAgIC5pbml0X21hY2hpbmUgICA9IHNhbTl4
N19pbml0LA0KPj4gKyAgICAgLmR0X2NvbXBhdCAgICAgID0gc2FtOXg3X2R0X2JvYXJkX2NvbXBh
dCwNCj4+ICtNQUNISU5FX0VORA0KPj4gLS0NCj4+IDIuMjUuMQ0KPj4NCj4gDQo+IC0tDQo+IEFs
ZXhhbmRyZSBCZWxsb25pLCBjby1vd25lciBhbmQgQ09PLCBCb290bGluDQo+IEVtYmVkZGVkIExp
bnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KDQotLSAN
ClRoYW5rcyBhbmQgUmVnYXJkcywNClZhcnNoaW5pIFJhamVuZHJhbi4NCg0K

