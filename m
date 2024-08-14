Return-Path: <linux-kernel+bounces-286513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23650951BED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70961F258CE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A7C1B142C;
	Wed, 14 Aug 2024 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fu7Iqk88";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wHPVdCWE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E58A1D52D;
	Wed, 14 Aug 2024 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642394; cv=fail; b=LnrQLlzUQsfINm0R3Va4Stb+lEewEoAKot5zVacdH1aXK4pvmF97/mwbO9Lw/c6J4BcHzxu+EYg1NggkAZnk/OWm4cCkx4OW8d1DueAFAs0xXmsrH0AQxySJbQZxoOsvMCDH+VMuw9ENwGXoMX5coiu+UU+55jBy9/eSVX+AhqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642394; c=relaxed/simple;
	bh=ozI+aqdvDr8IpJLCuiXK5arKg76B+JBulgdTdlBSToM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXyqdNZHVgci0RgF9yjmTWHqEnUwx1A+d6aqv6xxhiDFii9kHM5lrH8G88mWu0XvydQO2Mfk0tjbjXgrD2yoXorCEIvsNaiL9gTBg/qLHutuRnrRUJQjVUuF2HSGlGeyQmCW7XLRwQt4bt4tHs4bwbHnCTYrOxJ1QzxfsVIycXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fu7Iqk88; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wHPVdCWE; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723642392; x=1755178392;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ozI+aqdvDr8IpJLCuiXK5arKg76B+JBulgdTdlBSToM=;
  b=Fu7Iqk888GO2mbeZ0pgbyk7xLfqbYf7DOjRmQuIp9mFvK5oCBjW5gjlG
   b4K7sjI9v4TyznpYAoSgOJb/BQAOXO856uyx8hJV0eyo9IHz/rcDn20BR
   1WdihIAr6lzrj0ShA5xyNEroniY6Q2wcu/FMTJk+EpLQTmWysStNMu0ZG
   BtqiZX2eFUF3HHM3REAJ9lOMQXqir6rQj6x4k1vm9b3/GVXggOFzKKHEI
   XRCckOJKgzgFMnsj9kv/o/OCKv94sdKirbx3J4u5LnIUXRe9f+n4TTkqJ
   hVvi9DtcNmUskwEGpyqNjWcz1M7vuG7pOOcEbPBz00xB1lNgjjYcoA7DH
   g==;
X-CSE-ConnectionGUID: H4VqE4fHQmO3Iugi/tnn3w==
X-CSE-MsgGUID: 9PBS2w/VQ9uZ26H1gq+sjw==
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="197907525"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Aug 2024 06:33:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Aug 2024 06:32:57 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Aug 2024 06:32:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p1RsfC9ttdQ/he+nrhH/wL5HjIDzwrlDnb1z6BcPNo2H/+/MzarVHMwQeRqmKqn9KvuA3i8QK8lSlNvF0OK82sqEoDj5BoojowyC4O1qD9lecEwHlIJBEhjPjL6lIk0ejds3kjt4026fh187enQiF384CQYqfSeR1mdIOf0ILSfKAi4Le6SV6AU2XoAFg5YpQMjKd+cAiXOmwzmQAledZyDoYRwfmBLjRxvmFd2YpnTu0fvo9++PwRST2KaVpcF18o7bxFwnZR4TfTGT15e8NNq0tF7jt5pF/rhghzeeq2jUpGTNMkgNy7KMDq8mpKT7GP1ZpymYcIgnyFebs+TkTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozI+aqdvDr8IpJLCuiXK5arKg76B+JBulgdTdlBSToM=;
 b=VnOvjfWifVCvPwEMHHdMrPo/FEE5CyfxegZ0FyVQ6zgLxfeDg3yFtlxlT0H43FO38J5EsnF71WQhFoM8u/xRFO2BxDUd+/9WvceNOS0dMyXCeyLztoWoSchVo4L/tCpQTIvSZEyYZk7AZRGWSFMPFom5T7fQ7MPVI8Qzv6BEIxUbT/ZuYfUqHVT5Fj9434aLKexkJ/a5iAAqzY7uiA2UX89xX4ZXmTEX7xO/axPUhC6qOO3Ei0HGLKhZm+BpP/vs8NS38cuptI+OlG5vUOtEuiY++3EPEnj5mB/kbjN18ZbSSnOQc/fKHQIc+225CaJjZXG9JxsifUlTI1paup+l2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozI+aqdvDr8IpJLCuiXK5arKg76B+JBulgdTdlBSToM=;
 b=wHPVdCWEeSZ+1558Zuv01vN+ijpZHlAAyIZVd+sLE8yNYb64eDxS2XDZ9vZNVOqi2Rosn4+dhugAfK7I0/P/S00+svVGUO4qvOrABPrJVmel4xnSbkHhf0E9WLBiGqVz1CVvzOxz/tloYsbaCHVs4QkVCKmfTbASjaer/12MUP3YyAQ/TJkLPHQNfDGtJHAIN7Xm/y1q7mBlB/NiLc4mLRVSLSs9XufOlYYGgfAEZcSNHuecrVoGm35Sgewb6HTHk821FHarh/twa0VSQBgHVfPIHc1kQKQ18JTr717mLmDaGP5uK4oPiCJSo2Rzg/NEFGGdE9SK74C3lkSdbR2K5Q==
Received: from CH0PR11MB5284.namprd11.prod.outlook.com (2603:10b6:610:bf::8)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Wed, 14 Aug
 2024 13:32:54 +0000
Received: from CH0PR11MB5284.namprd11.prod.outlook.com
 ([fe80::abf1:f70c:ef88:a2a6]) by CH0PR11MB5284.namprd11.prod.outlook.com
 ([fe80::abf1:f70c:ef88:a2a6%4]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 13:32:54 +0000
From: <Andrei.Simion@microchip.com>
To: <krzk@kernel.org>, <claudiu.beznea@tuxon.dev>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<peda@axentia.se>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Cristian.Birsan@microchip.com>
Subject: Re: [PATCH 1/5] ARM: dts: microchip: Clean up spacing and indentation
Thread-Topic: [PATCH 1/5] ARM: dts: microchip: Clean up spacing and
 indentation
Thread-Index: AQHa7kWFNuwNC7bEvEeRwM7Smte3h7ImvNOAgAADlIA=
Date: Wed, 14 Aug 2024 13:32:54 +0000
Message-ID: <5e37e263-ee00-41bd-a650-1c1374e24d66@microchip.com>
References: <20240814122633.198562-1-andrei.simion@microchip.com>
 <20240814122633.198562-2-andrei.simion@microchip.com>
 <3294e2d3-5142-4d7f-89d3-35528f26066e@kernel.org>
In-Reply-To: <3294e2d3-5142-4d7f-89d3-35528f26066e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5284:EE_|PH7PR11MB7124:EE_
x-ms-office365-filtering-correlation-id: 3f8377cb-7a78-4fa9-f032-08dcbc6599fb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5284.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2hrNW16RzFjY0tKaWZoZlFObjdIdGZ4Rk1sNEV0TU83YllMNjFWR290U3E0?=
 =?utf-8?B?c1dMdmVENTRHTzI5Nkw3RWJCWGRlRWcrZ2N0S0hSbDRtNlJ5NnlIUXBrNWZl?=
 =?utf-8?B?RktNa0tNdVdhbTFqa3QwWGRmSVBEdVhrbFVCYThIdHpJeTQrVlorcEYvYmxW?=
 =?utf-8?B?NThSVmNVU0xCcEpFWjM2QUhKa21LZzlvYlBjSkdCZXBVQ1gyOWg5eDREUHJr?=
 =?utf-8?B?bnREaVhPbE5CMVpoN2pocWVlRmJhV0g5emZoUSszNllsZG40aktrUTJ2SVZn?=
 =?utf-8?B?bGF0WDgramZOdDhlOFZXNm1mbVF5ZU53dW1oQi9aVWY3OXhjd296SUJWTnJM?=
 =?utf-8?B?Ujh4cFkrRkROQldPeWxqRzZPUzVicHkrQUtudjRNajVsTlFxbzFTdGpQdTRo?=
 =?utf-8?B?MVJ4MGlpeEN5bi9RbnRTeVNyZ1VScGpXczBFVS9ZZFpDK3NDNUhsR2doNWhH?=
 =?utf-8?B?SnFNWnVlNkdlVS8yMVRSYmFTN0pQR3dtZjJsSHJyVmFpVXVQWjdGQW1wZFlm?=
 =?utf-8?B?bmo1ZjRrd1cyeXREMDlhM3l0V05ISnRkRk8vVWZ5c1pqVTBpa3hUWHVGeFhs?=
 =?utf-8?B?dlJDWWhtWVVMVno2YnM5UzV1ak5HN2NsRjBpZDJtMlJvYzIzenQ0Q1FDQzNK?=
 =?utf-8?B?em90cWl6Q3BITmgzTWJtb3hKeVplRE5yejZHUHlJMlJ4bUJHbzBGbk9oZWtF?=
 =?utf-8?B?MFNPQ2lnYjhia1JqNTREYjlwbUM0UWV2K3loSWszTlBwZFBIUWUzWCs0Tmxw?=
 =?utf-8?B?a3A5MDJzY0RiZFdhdjlsTWFmWUxJNUNkWG5qNVNMRXg4b21MbWE4N3RWOFho?=
 =?utf-8?B?aUIvMUlGT2svTVZqa0swY1U5NnVwQTBvMndLaGhZdU16Vk1lRFhNbmgrSlZ5?=
 =?utf-8?B?cm1nczdxdDM1N05mdkVqeThEZWsxS3JzTVlZVkoyUkpMbG1wVkJrVmZTNUN1?=
 =?utf-8?B?K052cHdwdFFhN0tHZlIvL3J5Rlh5SzI1ekVsS1JKbGIvdENRMHl0QlFWTTlM?=
 =?utf-8?B?TDNhQ1pMYUpoejJIVllmMGpneVBITDVEVGtkbC9mbm1xZmNReUM3NnFNWTBK?=
 =?utf-8?B?M0FGNHJyKzRoSERUelg3MGlrdVlWWlRJdlZ1akpUZ2tDZ1pLdGJNRCtmM1dH?=
 =?utf-8?B?eDZlbnZLZmNCbG4xaTR3L2oxWmxiVEczdWIvZ2IrYnVXVDJONk9GNVdTR2ZV?=
 =?utf-8?B?TEVRWUxlYk83TWphcUh6WlNVS1d5R3lPNmtyTklKcWhoU09SblNYQnhUd25a?=
 =?utf-8?B?S3lWV1lmTkVLeWNaS0tXWHlYYkdsWUFlRDMvbkpBZnVFZVR0ZGk3b1pDbGo0?=
 =?utf-8?B?NHR1amZzTVE0RGVKYnFTN0sxaDJtQWdvdzdsQVY4dFVzMVoxMVI3NHpUcTRq?=
 =?utf-8?B?ZXhCc285cHp3dGd2MDRxQjJ2Yk1QajRlaFNDNWxrdUlnMlBTRTBlMitDSDJK?=
 =?utf-8?B?eW1kN1VYRWpHZ09kcUNvT0JPcXBZQlRYYlkvOGMxQmxPd0hzRjlnWXJ2STZk?=
 =?utf-8?B?RGxYQVFGUytZSklSSmZHalNiVTlpWFBPak9iWnZOc0lFc3dMNnFSakJvdUV5?=
 =?utf-8?B?TDRqVWpNTEVsVVBVWHFSLy9JZ3ViM2ZybVNreENQRmZnS2NYbmdaQXdMODJk?=
 =?utf-8?B?VWE2Yk1WREhrRkNRMmJnRDBjSTVNVndETXRleXZ6ZGdCMVpROTg0eFpBUkI5?=
 =?utf-8?B?ekpLajNEQU9LTmlzZGVzNjN5TUhla0dOanlRclBqdGkzbzVPMXRka3BtUE8v?=
 =?utf-8?B?MDJsZktwSWR4NEVtMXE0dEkzUHpQbk1XV0liUHd4TGdOTCsvS0V2aDMyZDNk?=
 =?utf-8?Q?qW0A5OGYy3IKSRCZkfCvd3ZRtI567iAvuaLiE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWZPUk9XOUpYQWpkbHhKYlQwSkk3dHE3dVpPUW55YjdoaXJXbzFubVlRdE9m?=
 =?utf-8?B?VzJlQ1YzUmt0WXNGVFdUQmxGY1hpVjRtN0pEd1VmaW1oaWlOSExzZ1VSRk50?=
 =?utf-8?B?aGE2ajNPNXZrc2I3UGlJVzlnMzk0eFlmZ3dPRFJNam8xQ2hWaXVRYzhWTlNY?=
 =?utf-8?B?dTZ1dkNiVXM1bnAvSnFtTGdzNjYwS3o0K2lOUS9oNjJ3K2Z0eUcrNEIvcXlN?=
 =?utf-8?B?RStKM3hMcVNpbjZrOWJiNmUrK1hpK3BiUGFaSk5GN2hOanN1NU01Q0Rzb245?=
 =?utf-8?B?T1h4VzE4VDl1M00wR3hjdStuMnV6R3pvVFhvRXVFTG45SitJSERaQ0hDQklK?=
 =?utf-8?B?S0h3elVOaVRweXFrSkVHS0V2NytPM3haaTNtN3lEbEhTRG42STlLeUJ5NWty?=
 =?utf-8?B?N0VNVTNNcit4c2dLWDEvRjBFTGZOUVZWSjNXQmgreFlINnNJb1pVN0hoYW1t?=
 =?utf-8?B?UUJ1VWNNZ05Nbnp5T1U1RlVrOGdVYlNFa2pPcGtDN2R0KzdlTzdrQURrbGtI?=
 =?utf-8?B?dG9YRVROZEtZSnZOWXMwQzlKa2ZJNXNCSDFNbEs2WGZzNUUvdTFYeUlZZGFr?=
 =?utf-8?B?Z0NFVUYrYTlFZnBOc0h4Ym9mai83SDNLamhsTzZIL0ZCYTNsZTMrZWZZYmpq?=
 =?utf-8?B?d2VYSXNWVXBIU3M2VTZOcG51ejdoS2lVek1ZY29EbGhPak9nSjBoRnpOeHJr?=
 =?utf-8?B?dTFUZ0tlNFFFQ2s4MC9yeVRuRjIwa1B2Ym9xcVlPTld3aVFJRFVKNGsyRjNE?=
 =?utf-8?B?VFVMMXZwcWw4YmJXMGJCNUU5R0I4eVVRbEIyUUZVeDJYaEJhRHVockZmYkxr?=
 =?utf-8?B?bDJNbTIxQzdGa2pTbCt4bk1YNzFONS9LaWVBSjRTZVloSmlqNnlDM3lXY0h4?=
 =?utf-8?B?amFobURHNGJNQnhZNWF0WVVBbk83Vzhhcm90ejNWUW5JSHh2S2JGcXFsZkYy?=
 =?utf-8?B?d3dYQWxGR0lOTmR5cGlkTVgyMDg1aG9EL25IZm5VTjJ2ZTgvZHY3N0dHeUV4?=
 =?utf-8?B?d0dBNnZmbjhEYWYzNGRQMnlMUUw5Z2RheXdVeVlndU9wbFc4NXp6SHZKeWlV?=
 =?utf-8?B?VlhOU3JIMENIM05lOWVSR3JiMWV5a1lvRkI2Ym1GQ1ZIblVTNXJ3Vy8zUlVl?=
 =?utf-8?B?dCtiaGVQWCttTXRwUVdvN0ZSMlB4ejNhenZvTStLSnZHdmhtUE5lTEFTTWJ6?=
 =?utf-8?B?bnJHalA1SXVzTFlSYy9JcUptL2EyWFJ3RSsxcHJxL1U2SmlIUFd6eTdWdnE0?=
 =?utf-8?B?Q2MvcGJwckhrL09SYXo2cG1GMXBZYzBoSWd6T1gxVWtrRFZ3STlQTzJGVnlF?=
 =?utf-8?B?MDZuTnlTTjBNTERDc3BwVnFQMHlTVWh5cExvR3M5ek10cmZ6aXk1QUNGM3JU?=
 =?utf-8?B?Vy9WVGhNdWxybE1WelRlZ0dqK1NtY0kwdHJZSFp0cjJ6aGRGOUZRa25wRDMv?=
 =?utf-8?B?bWxHSWpCVFhKSHArODlRTjBFTk1QenVHZ0MyWW5BdEs1a080N0VmVGxXN3NO?=
 =?utf-8?B?bGhtMzJ6NUpYaVY4UitSRDlrRkNibUxCeFB1M3ZpT2hGWlZ0N3Z0ZWM1UE00?=
 =?utf-8?B?RnVBQm5Bek1ocCt5Qng1OUd5UXNWcTBZelB2aUw4MWFVaDV3d3p3ZGlwVGFw?=
 =?utf-8?B?TitjdHcyWHl0WTZGaUd6UnNkbVVEUHJ0MmdwU2xINDA1S1JJa1VvNG9HTWtx?=
 =?utf-8?B?SUNKNlZXMVZ0c0ppenZBbDFKQWpPTk9tcUc3c3dSbTlieEoybWY5RGUyaUt5?=
 =?utf-8?B?aC9RZ1oxcHlhOUx6d1k3Y0o5MGZqQ3p3NnZKaS91UG9Jc1RpOTh5OEtPckZJ?=
 =?utf-8?B?TjNkaCtMeDkvWnlBdm45QWNnN1Q1RnFXR2M2UnIybVRWS0FkQm1NcmxacUFY?=
 =?utf-8?B?WXBvb2oybGZBTnk5djhHNEtsWWhPUkpLZzdNNkhHWXY1UlB4MjRWNnRxYitq?=
 =?utf-8?B?S2hBSTY4dkFmZHRwUEN5cnFXajRmQytzNzZ4cVFkcGo4WlFKbDBRTHo5dEpj?=
 =?utf-8?B?blBlWXMrWk0zYWovc0Z0ZUExZVQyU0J2UmlOZXhDa3BHWVNhQndBVGt0cDlH?=
 =?utf-8?B?L3dtZ3k1b1hYNXVEMmo3RWp4ays0cEVWbHlsRGVtNXBJU25OQzdPZklCcU55?=
 =?utf-8?B?TWI2UXRNaUhpSyt1S1dhcmZjQnBTMUlZNmlCWjQwblZGVVVmbTJxUkFGYVFU?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D58B0FB8BDB3804BB1472D27AF1ED5AB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5284.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8377cb-7a78-4fa9-f032-08dcbc6599fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 13:32:54.0681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: heCqEuEz4scq8HXMrhnIiRsVCsMcCuBLt3nTr3nXurlPj6Tj5Jj0K5FM/B3LMq/9oJwYAbQ12ZJU3elld7OdxJ6Ly60jbfCsiqQTD7XfkPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124

T24gMTQuMDguMjAyNCAxNjoyMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxNC8wOC8yMDI0IDE0OjI2LCBB
bmRyZWkgU2ltaW9uIHdyb3RlOg0KPj4gQ2hlY2twYXRjaC5wbCByZXBvcnRzIHNvbWUgRVJST1JT
IHJlbGF0ZWQNCj4+IHRvIGNvZGluZyBzdHlsZSAoc3BhY2luZyBhbmQgaW5kZW50YXRpb24pLg0K
Pj4gU28gY2xlYW4gdXAgOiBjaGVja3BhdGNoLnBsIC0tZml4LWlucGxhY2UNCj4gDQo+IFBsZWFz
ZSB3cmFwIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZyB0byBMaW51eCBjb2Rpbmcgc3R5bGUgLyBz
dWJtaXNzaW9uDQo+IHByb2Nlc3MgKG5laXRoZXIgdG9vIGVhcmx5IG5vciBvdmVyIHRoZSBsaW1p
dCk6DQo+IGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjQtcmMxL3NvdXJjZS9E
b2N1bWVudGF0aW9uL3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLnJzdCNMNTk3DQo+IA0KDQpj
aGVja3BhdGNoLnBsIGhhcyBubyBsb3dlciBsaW1pdCBmb3IgdGhlIG51bWJlciBvZiBjaGFyYWN0
ZXJzLg0KSWYgeW91IHdhbnQgNzUgY29scy4gT0sgZm9yIG1lLg0KDQoNCj4gUGxlYXNlIGJlIHNw
ZWNpZmljIHdoYXQgYXJlIHlvdSBjaGFuZ2luZy4NCj4gDQoNCkl0IHdhcyBhIGJpZ2dlci9ibG9h
dGVkIHBhdGNoIGFuZCBJIHNwbGl0IGl0IGludG8gc21hbGxlciANCm9uZXMgYmFzZWQgb24gd2hh
dCBBUk0vTWljcm9jaGlwIChBVDkxKSBNYWludGFpbmVyIHNhaWQuDQoNCj4gDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogQW5kcmVpIFNpbWlvbiA8YW5kcmVpLnNpbWlvbkBtaWNyb2NoaXAuY29tPg0K
Pj4gLS0tDQo+PiBTcGxpdCB0aGUgYmxvYXRlZCBwYXRjaCBpbnRvIHNtYWxsIHBhdGNoZXMgb24g
dG9waWNzDQo+PiBiYXNlZCBvbiBjb21tZW50czoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LWFybS1rZXJuZWwvODlmNTE2MTUtMGRlZS00YWIwLWFiNzItZTNjMDU3ZmVlMWU3QHR1
eG9uLmRldi8NCj4+IC0tLQ0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLWNv
c2lub19tZWdhMjU2MC5kdHMgIHwgMiArLQ0KPj4gIGFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hp
cC9hdDkxLXNhbWE1ZDI3X3NvbTFfZWsuZHRzIHwgOCArKysrLS0tLQ0KPj4gIGFyY2gvYXJtL2Jv
b3QvZHRzL21pY3JvY2hpcC9hdDkxLXNhbWE1ZDJfaWNwLmR0cyAgICAgIHwgOCArKysrLS0tLQ0K
Pj4gIGFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxc2FtOTI2M2VrLmR0cyAgICAgICAg
IHwgMiArLQ0KPj4gIDQgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9h
dDkxLWNvc2lub19tZWdhMjU2MC5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvYXQ5
MS1jb3Npbm9fbWVnYTI1NjAuZHRzDQo+PiBpbmRleCAwNGNiN2JlZTkzN2QuLjEyNzlkZmIzODMw
MCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLWNvc2lu
b19tZWdhMjU2MC5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkx
LWNvc2lub19tZWdhMjU2MC5kdHMNCj4+IEBAIC03LDcgKzcsNyBAQA0KPj4gICAqICAgICAgICAg
ICAgICAgICAgIEhDRSBFbmdpbmVlcmluZw0KPj4gICAqDQo+PiAgICogRGVyaXZlZCBmcm9tIGF0
OTFzYW05ZzM1ZWsuZHRzIGJ5Og0KPj4gLSAqICAgQ29weXJpZ2h0IChDKSAyMDEyIEF0bWVsLA0K
Pj4gKyAqICAgQ29weXJpZ2h0IChDKSAyMDEyIEF0bWVsLA0KPiANCj4gTm90IHN1cmUgd2hhdCB5
b3UgYXJlIGZpeGluZyBoZXJlLCBidXQgdW5uZWNlc3NhcnkgdGFiIHdhcyBoZXJlIGJlZm9yZQ0K
PiBhbmQgc3RpbGwgZXhpc3RzLi4uDQo+IA0KDQpXQVJOSU5HOiBwbGVhc2UsIG5vIHNwYWNlIGJl
Zm9yZSB0YWJzDQojMTA6IEZJTEU6IGFyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxLWNv
c2lub19tZWdhMjU2MC5kdHM6MTA6DQorICogXklDb3B5cmlnaHQgKEMpIDIwMTIgQXRtZWwsJA0K
DQphZnRlciB0aGlzIHBhdGNoIDogdGhpcyB3YXJuaW5nIGRpc2FwcGVhcnMuDQoNCj4+ICAgKiAg
ICAgIDIwMTIgTmljb2xhcyBGZXJyZSA8bmljb2xhcy5mZXJyZUBhdG1lbC5jb20+DQo+PiAgICov
DQo+Pg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkJSLA0KQW5kcmVp
IFNpbWlvbg0KDQo=

