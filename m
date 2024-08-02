Return-Path: <linux-kernel+bounces-272649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A41C945F5C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F008F1F234D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABF5200105;
	Fri,  2 Aug 2024 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nY4ltoMf";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K7mde7IZ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D057920012E;
	Fri,  2 Aug 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608761; cv=fail; b=f8+ehliaagBGPvNV5qvLlGETl8weTRSRAOstkOtHAawUhQsxfcr01LDQjFbun6DG96U9+V9sJrAMm29Dhx60Qk2oi4E+3RaWB8bv7wf1yKB1bLfXrbHR3JQthzHMclQaDPIPNPrRfkc9j46Av6NWtUVsBMHu4yv6HOxOFSyNJq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608761; c=relaxed/simple;
	bh=s6F/P/QOf+I7WkxU93K+k/5sjG3qqYylMcomNNcfUmg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DMU9eh8pAXkwCvpeFpciOrIlB0qVp5w/jdeU88xfIbDuNOLFhT4P7IRrUL1rli4aA1WI5nb1OOk/au5RFDmLCHL2t3wwSPkk0dt1rt6jguvL39eBRL0uVzrpVwbF/oLQHkBz3RfuzL47bNchZ+myBTanddHXhJAyhPNt04eEDNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nY4ltoMf; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K7mde7IZ; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722608759; x=1754144759;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s6F/P/QOf+I7WkxU93K+k/5sjG3qqYylMcomNNcfUmg=;
  b=nY4ltoMfW5//bEk+5MrWiMNKHH7GSdnxWa242bHuLMzdKX1bn+5gYSM2
   yAZBhxW8AsWtCgg7dSuih7VMYZxOnLK47kIFqv/bTNhSYr7wDMfxCLwZ9
   y61Ij3b98bwAkY6kZ/0z+WmaU7FcGv+EvUzBuMI8xSKVftn17pPl+2X7n
   oTglRXyiHpFlFN8gbarlWW/kLd3a7NKnu5RHh9lW7f+g6mzZgpI4SsQFU
   TlI2M1UZN8KcGMWBuDwiaKfaD3NIw5lv5DPv6sQ2HMTPiCMJj0Mue591s
   sG+ER0JjGFnIQoNlCOnWn9rDIRUabnzIPwCVolR05i8KK2Y9p96gduxym
   A==;
X-CSE-ConnectionGUID: wWIIp7XkTp2dCNGLj+TJuA==
X-CSE-MsgGUID: 7lzjTAiRRN6X7YkRbu3zSw==
X-IronPort-AV: E=Sophos;i="6.09,258,1716274800"; 
   d="scan'208";a="30688205"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 07:25:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 07:25:21 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 07:25:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3nBEOvTwkepbIfyJGnznD9nWcQ7ye0aPO4ppxp3SEoIA0aC2B3AQE9H9PFXcxtQD3slZIasqJFpgWqjA7yeSTbj2Xo2pYUMTTESrPMz4yxgmpqZ2y03bh7+s9df6zLao5ks8Qcdnvhq5sy9N6VpuFsqyGjX5UT8QwDM4KzSFitEYJZQntERLMTSwXV1r4DAABqbas3LJ2Czk3Wzy4oqYVjDYK2Nf/EsVIUzb6FVlknqLECYK6EphewRAZRad+ZTyzZxnRCnzZXtAPjZDTsrERaPfadNr0tsIwIWa1tCVBWozTfKeS/IpLOCz+BjEsy9pEb/sXfDC0Q3N2OWt2pFkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6F/P/QOf+I7WkxU93K+k/5sjG3qqYylMcomNNcfUmg=;
 b=qamLsjAak6FDdcP2e+a/boLzEXGhJbGKERX34tU3iQtm/6f7mAswbFbGWdnbTsc/N1EVPvJ2D9dcWiWfGV6cw0M1NVivDSelRngwmNGuAIXtn8DtfrY3vvU2Fr5jCa+d5SsHYQwo59mJEGEya24fcHSmHXBrDaxQhqfSbQKD9FnV4SmdtjsHolixeJpFc3NvcD4LFrsGopA4085YEszcZ++eraEMVzJGwVAVGufCFN2luv2Bw3JD1fsBJoCi6hKf3nKGS5JrbypYrERte7geRh9gPkr+Cx500B4XM2bAhdvjByP4N23y6sU46yUm/neMprlCDFaXi1UwV9PsoTE/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6F/P/QOf+I7WkxU93K+k/5sjG3qqYylMcomNNcfUmg=;
 b=K7mde7IZ082CFMZq9uodgvKKaJlePZCKc3FqGjQ4E4mQRzcIwQaL39nEK1OBrWNE2V/jnFOOXe79e3kjPW6yn3lJ8RB1GfD/S5OhVN5JjYTMQSRfU8qOBp/JI4OuYZALYnShC9ilNR2f8Vg1Cd30qWGCOFY8yGWsHD9ga5yQQIEJbJspPx8/JViLcqonxvA+G8QU0jTGyBm4PmrHJwJHnHwieIh1EgJ+RYsB8pFJbtVk+H9NFW1IaV1UZ+4ZJi962gsbSGbUUOcO5nyMdteOSDa24JUqqT7ISpjoF5aL4i1yIvT2sHWO4XswGzUW6owwvUWMwBgpzdasJ2H/dAyAVQ==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 14:25:15 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%3]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 14:25:15 +0000
From: <Andrei.Simion@microchip.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<Nicolas.Ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Mihai.Sain@microchip.com>
Subject: Re: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Topic: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Index: AQHa5LhEn97L1tgXxECJyG0oBvR81bIT7XGAgAAYs4A=
Date: Fri, 2 Aug 2024 14:25:15 +0000
Message-ID: <f318439f-b520-4b86-99a7-eb9a2e47525f@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
 <20240802084433.20958-2-andrei.simion@microchip.com>
 <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
In-Reply-To: <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|SA2PR11MB5129:EE_
x-ms-office365-filtering-correlation-id: 28441385-fea9-4bd6-289d-08dcb2feed86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VGdqcWExQzZEaUt4SmFPREptdXNWSkpNK2dxTURsaTJ3aXNOdVV3VE5qMUJU?=
 =?utf-8?B?bHpHMnB4alU3SnpzUTZEWXJ4WHZBRHpnSmEybzhsd0VUK3g2SnlqVE8zdC8v?=
 =?utf-8?B?LzVOMEc1RUR5NHV6VGc3bDZoallFME85V3RxK3hOWit3N2pET0lUNjNQZVcx?=
 =?utf-8?B?a3BxVmZlTE11QW1MSmhmQUZXanhlT2RHR2pyajQyTFZyNTVSeVpTbkpya1NS?=
 =?utf-8?B?QkkrWkQ1eTM2eFp2OVFlQTJSQU5HbGdkSWdDcUcrbnBIdFZrUWxpYXpIVTZu?=
 =?utf-8?B?ajZka25IOTZZUVl2dDRXc2ZHMDFDU200QmdYbHIrT21qMmxZNGZxQzdycXJH?=
 =?utf-8?B?K285bXdrWmtwUW52TnZ5SnB0WEFjRzN0c0R1dm81VW5NbkF1Q09CRnJEeU5T?=
 =?utf-8?B?Nm8zZ05tcjJWeFI1Y24rbHh6OXhOVzQ3QmUvMHBnV0J1NUlUajEwaXk5RkQ1?=
 =?utf-8?B?UlAvMm9vcUxqRW1FUk5NWTU5ZnRLak9YUGZjNnk4aUExdGRUUmI4VmRRMUpn?=
 =?utf-8?B?V29SNzlqaldZV00zL0Zxc1N4MHI4bU01WXpxZHlwbGZxdEE0MndQL3lxSWhz?=
 =?utf-8?B?dStCbS8xVlJkZ1ZMVmJGZVRhaE9vUCtpRU5NRnQ0RVJJZ0xoSXJVUG9raG1v?=
 =?utf-8?B?Y1VpSkdvWS9ERkpMK2FlVjY4RzV3Q1JqYnRMTDZtVE5WTGNHaHJFWGRUQUpV?=
 =?utf-8?B?L2VheElmaHlDclNDQWtOSS9UTUh4aGw1b2VjWExzTWJTdXpibkFKbXZLaEdn?=
 =?utf-8?B?MTltTVRaUno1NU1qWWF4M2h0TXRZWmEwSkN4NkZTSFpwYmRETWw5bDZ1ZWRK?=
 =?utf-8?B?K2FlSlF5OWJRazNlcnZYbnB1QmNhZ093L3gxTExhSEFNcW8vblEzTUpmTXA4?=
 =?utf-8?B?QTY3S3l0SWR5cUNRK0ZsYVpBMnVFWmdJWFhidklWbzIvTjhUbjIweDZnVmlC?=
 =?utf-8?B?M28xZzAxTjZueHNVdG5JallnRGlQSG41Zi8vTDNRc2k1SVd1dytKZ09tNUV1?=
 =?utf-8?B?T0RKM2dGMTRubWdaOXZQdHNqZlpmT2lmLzcvNUJDQkRRa1BhaFFMaGtOTmFS?=
 =?utf-8?B?czQzejhBRmRVMnAyOE14cnpGOUt5U1kybTIrb3BLb3RHQ0hKQVFjZ0FyaVFn?=
 =?utf-8?B?TmlOVlRFSnYxSTlvZHNIOXZkSms1TTc5ZkpPYy9kL3JqWjdjRVAyeUFLRmNl?=
 =?utf-8?B?dXFCc2dHeFpuZVlBbTM1SDRYOXh2M2d2VVhteEJOdnJVVWNUcXRYZnNWbk9C?=
 =?utf-8?B?OFAzV3VkZElyQ0JkbHhwTktnZ0tadjcyT1JCWThNdXpKSVBBc0grVllseHlQ?=
 =?utf-8?B?VXQ3TURFczluQTlGTmtDdXFkSVdScWNSd3M4cG1ETEVENlUrSHhwa0FHcE0z?=
 =?utf-8?B?Q2ZaS2VTR0N2WVpEeFN5clA2eUtmVnNvVW9rQS9wazZ0c0t6VGh3amtHMm8r?=
 =?utf-8?B?bmNvc3M3dElVZUhhWi93K1FNazBSMVZ3U1o3bkg0VFRDZ01QejRWcXVmeVVs?=
 =?utf-8?B?cWk5bisvUU55TUp2dEl4QWlVQXlWWnBMTU1sYkVYYm05RmVDMjN6c1lsRi94?=
 =?utf-8?B?dWxTRi9kek5HaFpGZ1VxM0JvR1lWUFJ2K3hldHNiUXFZSVpscUxEVUVTQmNC?=
 =?utf-8?B?N0hQNTdpaC9GRzBxbmVhTHhPd3FjWHJXc2h4ZXlJWVB5dDYxSld5emdiU0E1?=
 =?utf-8?B?YjBDdzRWV29nYTFvMXB6TE1rTUxtVkNNVkRNUFd4ZCtJZGM1dEJBUitwck5j?=
 =?utf-8?B?ZjUzWjRiQXhYK0gwSm9kNjFCcVZVUlpveElXR1NPWDZkd0JJblFROXhTOHZs?=
 =?utf-8?Q?moTj5+GyOnAOo5KwCSBkJlKfyODVe3fYscDbo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU9ienBZOUlIWTN2VEpQTlh6YUl2U0NKZVpQZHY0SzY5dVB2b2tFMEF1cGNv?=
 =?utf-8?B?bGliWENLdUYvRmh3V3NUSStETlJMTWpFU0g2ZWNSdFM2MzI3dW1ZUGx4enNU?=
 =?utf-8?B?RDdCWXBmSEppOWd3b3plMWR1ZUptQmd3ZGt5cjB0cnN6RU5mZE1tbFlHRTFq?=
 =?utf-8?B?Wk5rK0ppaDNrRUMrM0JhNCtNeDlpSlV6MWx0dzlFRzFmamhEM3BzWFZxVFF0?=
 =?utf-8?B?TnpuMjlRdmtCQW5Nc05PRTRLNFlmWnpZLy9jZ3Vuc0l0YlpnaDRjajV3WUFl?=
 =?utf-8?B?VjhVUE9uS09pd0VWQnFkQ0ZrODczMlB5OFBZcXdhZEpZWWFsT2ZUa1BiUW9U?=
 =?utf-8?B?M1BwME1GWVNGNXlSWUMrQWthM0tMcDV4bUZRbFVwazFQNXNLQkFzWjAxQ1BS?=
 =?utf-8?B?WVdiUzZteHNBTys1a3J4bWVrekdLbXVQc0NZbTZmL00vTHJoTjVnaXQzTFF1?=
 =?utf-8?B?S1VZbDZTRDdZZlk3ZGxia0dKdXExaGUwKzdBTFM0R0UydXV0ZGpqam13cTJO?=
 =?utf-8?B?aEdKMDZMTGdXSXEvMjFMY2lDK3JGazZSQTZsM0o2WU9heENoUWcrZEh0SkYw?=
 =?utf-8?B?ZFVPU3I2NUczOXJqT2dyY1ZNZmhlMjZjVzB0S2I1TTRaMEszNmMxVFV5N0tt?=
 =?utf-8?B?SnBtbEZURmpFQUVPd1AzOXdVaVlzM1JMaUxLRFRrRTd6NUlKZXlYWnpwUjFG?=
 =?utf-8?B?ZFd4Q3BTWFQ5WjlqS2Zaa2NpQ3RSTzc0VGI2Y2dZa2FHaFpKQXI0bnV6amg0?=
 =?utf-8?B?alNWRk96cnFMYnpVeHBIVmliYkdZZ0RoZStBb21wK2hsdFZTNEVBaDYxcGQ4?=
 =?utf-8?B?MGpMQkVDQVpWa2lSaUltWFRiT2VsR2lYWjN1b2dnK24yZW1SZ2x1TEJVSkJM?=
 =?utf-8?B?dlp1VENQRE90Sm1aUEVlRnNZWWp5SzBrYkFxNDc3MGpKREJER25GZG4yS0Vk?=
 =?utf-8?B?RDlHUkxoWjlJKzh3RVhHanpZT0ZqNWdRcmZsMXFjeENTZVB0ZDRTSDA2SXFk?=
 =?utf-8?B?ZWdGaDQxaGxmSjNRclhKZ1A0OUJvWWp3eWZOSW83bEZPM3BhMHlKWi96cWl2?=
 =?utf-8?B?SE5CeHprWW1jVE5FY1hOcDZKSTE2NUVUamtIZWVxOWppMTFtZ0xZWGpLVzZz?=
 =?utf-8?B?d3pmeHRTa21GeGVsSkFXamVLYUNPNCthb3pwRU1oOUhzNmNtMjBpak5jZWo4?=
 =?utf-8?B?YWw4N1MwYktoTXdubW1ybitiMkpJYjYwMEpYb2Q0YmxBVmhjUlBrVytoQW51?=
 =?utf-8?B?UFRRbW50UUNWNEJEM01yZXU0ZjZyamxmVzJQYVY1MWhHQWNlYjJQUWI2d1NT?=
 =?utf-8?B?MGt4M242dDVNV0NwZ0xtUnlubytuZVUzTEFaNzVpdFU5LzVRbjhyM0RCRjFr?=
 =?utf-8?B?MFlYUi9DOHBTQVg5TW5EaGFXTTdEV2M3Y3hreXpLOUdFNlNncndEcGxJbzFz?=
 =?utf-8?B?alA5ekFrL0hLZlNmZU5HR0hsc0hjUmFRL2pPdnJoMTBXMkIzeWlVRWUwSDc2?=
 =?utf-8?B?UjRyZVF1dUthSm9TV284NG5RK0Ziell3YklZMFYvMnh6NitSVkk5K1VOSDhZ?=
 =?utf-8?B?OWREazJLSWd2cG1OY3prWlRYdTNEcDVHR1dWNkNiekd6VHowdEV1TUZLZE93?=
 =?utf-8?B?VSthdk9Qc01nc2ZkUmtBRm4yaTdONGJxd3plcE42NjlKVlNDem8zWGpYbk04?=
 =?utf-8?B?STZGcXBrS2EwNHIvZURPMmdkT2lrUlh1VXNCUDRvM3NsT0FFbWQ0WlNEV1Fq?=
 =?utf-8?B?YzBmMmV1ZTRwYTI1QSs4M044QnZ6QVF0YjRqRWZuR3V0Z3pwak10MEUxSlBU?=
 =?utf-8?B?WUZCaXNzWVpjQWhOdkFTWC82b01hcG1XcXZLS3QrVXF6bDlUcmU5ZVZITU9V?=
 =?utf-8?B?c1BwZ3Y4V2Y5SzRLWW00T2o0K1VpVk5ycXpiOGl6UHl0QzNDVEg0eXFQQ0Jz?=
 =?utf-8?B?K0dHM3BsK1cwZGNNVWR3dWFGSVFlenZpSUpwN2hXaTFRR3JwSGw0VVhJdXBE?=
 =?utf-8?B?MEUyVVNUUExmZTJ0ekcwUkNYaXZHVkFyMkRyeENzMjZKMVpUYVJNc21Rd2Fn?=
 =?utf-8?B?cHQ4bGZoS21NNFFHcE1LSmxsR20zeGpPRDgvWE83aDFCTW5qcUVKS0hzRk0w?=
 =?utf-8?B?WEVkbHpTK0YxWmZKRmdjd2Q4NkFjK1JnTUVTbkNpVjFraXRNN1p5M0JQbVl5?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <299AB80327F5F54391FC4DCFF8B09210@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28441385-fea9-4bd6-289d-08dcb2feed86
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 14:25:15.5846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n48yD8elzj7fHBVkGbpraHqiD8VVK9Sdajlz+Ma6Nfdml0FYt8zPVwFRpFhV8hxjxrTw4uEMNEAleh+qse2Cys5QVkBgZdOgztcjhhDGGVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129

PiBPbiBGcmksIEF1ZyAwMiwgMjAyNCBhdCAxMTo0NDoyOEFNICswMzAwLCBBbmRyZWkgU2ltaW9u
IHdyb3RlOg0KPj4gQmFzZWQgb24gdGhlIGRhdGFzaGVldCBbMV0gKEJsb2NrIERpYWdyYW0pIFBW
SU5bMS00XSBhbmQgTFZJTg0KPj4gcmVwcmVzZW50IHRoZSBpbnB1dCB2b2x0YWdlIHN1cHBseSBm
b3IgZWFjaCBCVUNLcyByZXNwZWN0aXZlIExET3MuDQo+PiBVcGRhdGUgdGhlIGRyaXZlciB0byBh
bGlnbiB3aXRoIHRoZSBkYXRhc2hlZXQgWzFdLg0KPj4NCj4+IFsxXTogaHR0cHM6Ly93dzEubWlj
cm9jaGlwLmNvbS9kb3dubG9hZHMvZW4vRGV2aWNlRG9jL01DUDE2NTAyLUhpZ2gtUGVyZm9ybWFu
Y2UtUE1JQy1mb3ItU0FNQTVEWC1TQU05WDYtTVBVcy1EYXRhLVNoZWV0LURTMjAwMDYyNzVBLnBk
Zg0KPiBJJ2QgZXhwZWN0IHRvIHNlZSBhIG1hdGNoaW5nIHVwZGF0ZSB0byB0aGUgYmluZGluZ3Mu
DQoNCkluIHJlZ3VsYXRvci55YW1sIGV4aXN0cyAuKi1zdXBwbHkgWzFdIHdoaWNoIHByYWN0aWNh
bGx5IGFsbG93cyBldmVyeQ0KY2hhciBzZXF1ZW5jZSBiZWZvcmUgLXN1cHBseS4gSW4gdGhlIGJp
bmRpbmcgbWljcm9jaGlwLG1jcDE2NTAyLnlhbWwgWzJdDQplYWNoIG5vZGUgdW5kZXIgdGhlIHJl
Z3VsYXRvcnMgaW5jbHVkZXMgYWxsIHRoZSBydWxlcy9kb2N1bWVudGF0aW9uDQpmcm9tIHJlZ3Vs
YXRvci55YW1sICwgc28gSSBzdXBwb3NlZCB0aGF0IGl0IGlzIHVubmVjZXNzYXJ5IHRvIGFkZA0K
aW4gdGhlIGJpbmRpbmcgb2YgdGhvc2UgbmV3IHByb3BlcnR5Lg0KDQpXaGF0IGlzIHlvdXIgb3Bp
bmlvbj8gTGV0IG1lIGtub3cgYW55IHRob3VnaHRzLg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29t
L3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9yZWd1bGF0b3IvcmVndWxhdG9yLnlhbWwjTDI0NA0KWzJdIGh0dHBzOi8vZ2l0aHViLmNv
bS90b3J2YWxkcy9saW51eC9ibG9iL21hc3Rlci9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcmVndWxhdG9yL21pY3JvY2hpcCUyQ21jcDE2NTAyLnlhbWwjTDM5DQoNCkJlc3QgUmVn
YXJkcywgDQpBbmRyZWkgU2ltaW9uDQoNCg0K

