Return-Path: <linux-kernel+bounces-242219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4584692851F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F093128408F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190A146018;
	Fri,  5 Jul 2024 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iKipGa7H";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jBFSKG8C"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07013665A;
	Fri,  5 Jul 2024 09:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720171891; cv=fail; b=KU1ii7aE3yfCTLRJAJNCOJSxp8ch+fs0JgrT5TIsOn/qDZdblzVNDHbv1Klyooz+iuDFNDabdIXxBZWc8NK9lhJNlaD+wcT9ssAOTLY1XED5JuDSzd2c6QS04WXvYdkuLZ01hLoWincnGNtcmfEHgu37MsB1GZvi2KuQzBPFi2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720171891; c=relaxed/simple;
	bh=D/2vX2MDHZ1pK1uzw41syPwuK2UV5I5gj1DHV+hhS9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GB+GiZ+1jE4brC+RZwK+JaXnxzEW/YEfQN3CSpcXCOtzmZm30k6LToIk9zEZ9TAJyuC38fjQRhIDowf/V4023zpbJwNuqHWp258HPPrczMNR/DNNHafATsCOh6gFkyL3F9osNC69uwcpu4S8BwV+Tqupiz8bCDgyOf6RG9m+lKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=fail smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iKipGa7H; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jBFSKG8C; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720171890; x=1751707890;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D/2vX2MDHZ1pK1uzw41syPwuK2UV5I5gj1DHV+hhS9A=;
  b=iKipGa7HnCsxOza4O1gtkjjtMPmFzj6T4O5ZZ8wYeL3R8RTVDKAr554H
   qYPz5ypqrbMEusr0HM48LlTprjCGdxgxUIokts84p8YNNAi5gRNNDUh2P
   pveY5LHEjEEzfGtUiDUphfsdzkdZpJi5zIswCFePXNZhCO5JDD/dRVaSQ
   hp8ogVo+DSrBmzdczQyFsI9JarHweWg2/9/9JzRbQdzxBKahisG6ljT1G
   7elSFzWqx61MViKJGi651zvn8pmM+Zr32A5tSkdQDI2Zej1CyDiBXDlDL
   qfsLKm5k3MxNGN9L6x3IUsSlbdmINAuC7FFSzWueSDAOwcgDppYNQz+Rn
   w==;
X-CSE-ConnectionGUID: 8wTma1BsS9u2jInv3TaflA==
X-CSE-MsgGUID: X7PbDoavTy2E5TB1cT48Xw==
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="29521453"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jul 2024 02:31:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jul 2024 02:31:19 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 5 Jul 2024 02:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFaRu7En1gyHbl83ZOaS/aZecDMN9Pr9UEhlef/BIrAiqb8L9AxVTTfz9LopggMkd75aQiBm/fupuMLlh088VwO/pes00wdnZVTBkmP5QAMovR4O8h8RfqhmJO1skvDK9qVc+Cgnq0idy1oe+DX+B0shnlNEqqVQv1irJz7ZRrlBIcoQ3GIagnVZNaThoU+To79f56Pp3merCHDybN1zIEvq6L9DzL3D0Th96doSnwn+tUltR2S/GArkNzyNRXRoiLm5VhsUnFdcduF8/zkk60cNtDI4jSP+1seig4RV+EHWsH9SKehnUDI523PgKfcnd9ci45wnfbuB1vszXMPVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/2vX2MDHZ1pK1uzw41syPwuK2UV5I5gj1DHV+hhS9A=;
 b=NSWLMABAJx+ANyhMNfZWrEjuvBxjbKNDRDew1xpGccc30eK6RG0jokrrjjtmUrSL4HEl/mWqDdBPDPz+sTp6IARPtVhOIko8i9GHMkbGnOcfaOucddETw2E28Na4g5ng+mYc5ikNpHAqnpbTtzCJMtlVoszAd66LmRxG6GoZw7olm+gLQpG7LBoBSm803UEwmZHw29jKuFSpkXLe8eb3pPvNOWcQo5ow+R87vBOR13wjUmaRs2TkFDWmLd1Y4DeSVodHIA7oHpxhh/2vNPK6c8m7w3Wh7QQh2Rg/Xjnj5/mwkgXz5LOSCJwlSxgidrVBLMcE+JyrLc7ChCEEwgNp6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/2vX2MDHZ1pK1uzw41syPwuK2UV5I5gj1DHV+hhS9A=;
 b=jBFSKG8CnpOtkcSdyqryph/s43yldre0j27YPRMtRbv6EPRwybarbsSRE66uEFiYt07bDnjJspiM63ADS31zScfnx8UzFtrRv1+R4bxT4CdW/cs+GScOHPsaise5+ZOoUMq9ioiYjbgmiwT+Gi09jLHTedaDg0fzuIk4zdz9mEL3wtiLuusGl4Yt5jmqJ6T3pUyG0Kv9UQW8cyJVyoVwqSqg//6uPF59kHsGsMi3o6yJKpf45T1ezHeglOtZv9mBguEXwlNBAO3q6k20G+ojlNs9NiTrATaVVuAzOZzVCs7pomYnL4qutx3j8VYrFDktm4LIqreAi8bSYjY3Qi3XIw==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 09:31:17 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%5]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 09:31:16 +0000
From: <Andrei.Simion@microchip.com>
To: <krzk@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] ARM: dts: microchip: at91-sama5d34ek: Align the
 eeprom nodename
Thread-Topic: [PATCH 3/7] ARM: dts: microchip: at91-sama5d34ek: Align the
 eeprom nodename
Thread-Index: AQHaziT9JyvyOC1W6UqyHnLZ+S4EcLHnsQeAgAAu2QA=
Date: Fri, 5 Jul 2024 09:31:16 +0000
Message-ID: <aecc9240-8a19-47bf-b42a-e74690d8315f@microchip.com>
References: <20240704151411.69558-1-andrei.simion@microchip.com>
 <20240704151411.69558-4-andrei.simion@microchip.com>
 <c4b23da5-10fc-476e-8acc-8ba0815f5def@kernel.org>
In-Reply-To: <c4b23da5-10fc-476e-8acc-8ba0815f5def@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|SA1PR11MB6808:EE_
x-ms-office365-filtering-correlation-id: 1ace5c52-055b-4a17-8bfa-08dc9cd53878
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?a1JOU1QrVFh6VUVaSk1reXpIaDl1SjRoK1pvdmozYVcvUWFFYmltQUhZTlBt?=
 =?utf-8?B?UkM5QVV3Rk80ZitYWWtwSE5veGNvempyclB3ejNuMmt3V0JoQThWcVhVd01y?=
 =?utf-8?B?MVpFOS85YVdhOXBVTG5JTGw5OHYranF6MTlIN2Y2d3N4NEszSzVNWkxtbnVl?=
 =?utf-8?B?QkVrd1RKQ2dSeVltVW1zNnRtdVkyS1liUVZoQXJNbU1DR0Z5djhjcEJRbmU3?=
 =?utf-8?B?WnMxbkVBcUh4KytsMWlUQmh2SnNXRGU3SDQ1UG1ibzhyTkFHSGZ6NS84dVVq?=
 =?utf-8?B?WU53U2hjT2RnNUhiaXhRS2d6RElQOEZJRmRzck9XdEl4VUI1UWNCV0tzMUhU?=
 =?utf-8?B?MWJaY2ZQVGNJdWhYcUcwdzVkbmRnUkF0bUtFK2N2WVFzNzNGdmJLZlg5aUN5?=
 =?utf-8?B?RzA4RTFCZ2xEVDN1cXpjWFpIVDZaSVgrV3pVMXlvUmVWMXFPWmJaK201VDlm?=
 =?utf-8?B?UG9rRnU0dHFSWkx2L0FqK3Ywd1dEdmJPeTBna3NabW9NTUtjMURJemJlbkJ1?=
 =?utf-8?B?V2hXMlY5Y21xSkdXbnBOclM0dXJYU1p3TEloU3YvTWNLQUh4em5Nc3NObXZh?=
 =?utf-8?B?ampYRWtWUjJFZFF2Z2Y2U0hsaXd4ZzA4M2hsN3B2UjJ3WEM5a3VDcHZTRE03?=
 =?utf-8?B?R0JRblF6VzQ4RTVQMnQ2Tkx0eUEwWU14d0RPNmpnNEYreEMvTUUweTF3dHZu?=
 =?utf-8?B?VDlvN0ZjVHhKU1h1MVhTL1pqQmNLN3VrWEF1RXRZV29KRHRsSmluMEsvTFVL?=
 =?utf-8?B?NUR2cHJsdU5VQS8zbGFJT3lEai84QW94OC8wVGVLelNNbmExS0FnVHd6NUVB?=
 =?utf-8?B?bzJQZ3NsOTRNS0RKc3ZwV2Fmek9hUU1XeVM0dUlXTWFFOGREdkI5S2xPSjdE?=
 =?utf-8?B?Unp1VXlSbUtaWkloR25jVWt4RVpjaUVFb1FnUUtudHdXUnF1cG1YR29rN1Zs?=
 =?utf-8?B?RnEzNmF2cVF1TExzdFhwSXNyME0vbDlwMHJLOGRkQ1VQcjl2UUZIU1grNkVS?=
 =?utf-8?B?aTNKV3FUSW1qK0ErT1RSMnJFdW1TbHNTVk5IcS9PdWdXUFk3YTVPRXdKaHNG?=
 =?utf-8?B?MitJK2xOanJvd3RoTFhqREh6V3FncEF2aU9WZ1hrSWNrL1VPNDVXNXpXZnZr?=
 =?utf-8?B?WjJ1UVIzcm9rLzVlL1psZE12MTN3WEFab2EybTN2Tm5YOEMzZXZ0MFU3M0hw?=
 =?utf-8?B?bjJXSDlCMGdsaXVtM2hheEdXNkR4THN5UVZ3Z1RzdVMvcjlEZzlhWUNUNHVj?=
 =?utf-8?B?OXczaENMNXQ5d04wZDZDSWl1aTh4d3BjaG9VVG9OV050QkNEOGtBNGd2WUNR?=
 =?utf-8?B?Z3YrUTFlQzBRTzB3VFJaVjBjNGpQM0tkbmlxMEQ2cVd3M2p5THpqZGJMUW1P?=
 =?utf-8?B?RmRyRlNDSk9NUUtYbnFPcUozQ3JqbVVvdW5GVjFIaktkTnpHTTlPV3p5K0My?=
 =?utf-8?B?ajBKWlNSSDNEZ3JrcDJScCtvMlNHeHhBbmVrZW91c1V0RmFiakJoRnJNT2cy?=
 =?utf-8?B?WHZoTWIwQ09yRmFReGMyUk9hdE9LeTQ3enkwUXpnYTBncEc0Wnl6Y0cyWGt0?=
 =?utf-8?B?bkZpakwwVHhFZXJ0ZGJHNEJsSGI3VnVuSnE1Qm9saHpuTGJpbWRtMkFoSlpl?=
 =?utf-8?B?b280b0FDVkZ5dlNlWjBzZmhMcWo2azBxRzlWTTNxY1d2UVF2NGZxczdJRWhw?=
 =?utf-8?B?a0Q5UHZwSnQzSC9PcW5nb3JUMFlJbUFxeHdGQnFNWFlqOVhsUUl4OFZzZzZO?=
 =?utf-8?B?ZjZWZHhIalVaendyOUd2cklmMXZjM0NkUUpRVGloYVRXZ2RPMmR1YTM0VnlQ?=
 =?utf-8?B?dVQ0ZkJhWXllb0RQNC94QWU4d1hwQVZKMnVCcDVxYjhVSDNZUFNzQmxHem5Q?=
 =?utf-8?B?V1p2cFVRU1VFOFJqWVJETGZhQU0wU3ZVdE90QU1iVENsNFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHZnQVVFQmxpejhScDFIMmJZRFEydjl3OVh3ZXZLaGhRbFpabEo5Y1kzWFhO?=
 =?utf-8?B?YjRONng1ZXZ0NndQc1BjQUZvWDZZeGRyQXBSMm1rMlArMnhyT1d6UVlmZkRj?=
 =?utf-8?B?NW5qL3JnV1pBMTdzL1B0dFR3SmhQMmsvcHZuOWxJNXJsZUdGeHhCTzRUZ21U?=
 =?utf-8?B?MG9ib2MwdGFBUjRteW1iWjBFTGw5aVg5Vks0UVdCSTVwWG83WnVhL1ZleGNB?=
 =?utf-8?B?WDJYZDd4UkpQd1NaUHg4MlZkQ09iOGhMdzQ2NXFocXNObFY0Y1dRRFpoZ05K?=
 =?utf-8?B?Y1IrMTdoZ3gvTFRMUHE4QTI4Zzd5RzVtcDNsWTRTQWhud1UwajhjYnorVW96?=
 =?utf-8?B?dU5zZlhqWWk2WkkwcjBVT3BWV2dTOU5HSFE1bzdIMVIrdkxQN2FqakZEeFBT?=
 =?utf-8?B?R1E0NTJMM25LNUFQN0Y0S3JiWkNxQW45OUUzOGNsSlFBejdOSHJpL2VYdDA2?=
 =?utf-8?B?WWQxLy9oTnA2QVpoTEJnbzJGcGxBckRUdlFSQ2dYaVJ6VkpQNGxtV1RxSThG?=
 =?utf-8?B?OXg3M0VORnovR0MzbXRtWnB2dC8vMFJkc1J5VVI5OVFwNnZGN3BFSFc3Ly9I?=
 =?utf-8?B?WUs1L2wydU1KSHFvazNKMXh6ckE4b3M1ajZIb0dhZnZzS2wwYXZnNzBFSHB3?=
 =?utf-8?B?MmZQOUhDY2lrZTMzVU1TZ3Y5dVZvVWtjMUxWbXZMbGh4L01TL09sRFVzMGEr?=
 =?utf-8?B?TlR1dkt0dXkwZzVERkRDblR2RzQ0TG13RGUraHpZbVg5bWpHOFJPSkFSTWZQ?=
 =?utf-8?B?d0JmWDBBL0hEZzN4eVg1WHI5ZjlUWGdhTmtHa3EyNTBRQ1YwRUVmbEYxUk1G?=
 =?utf-8?B?eGpDYXNDRkZleDRPQVlPWjZXbnk2TXRqTytrYnVHLzZOaTBTYkZXVDFaU09i?=
 =?utf-8?B?RzVSNXVsbExKVUMvY1NUVmJTcGJTaGZWenJEZDRENDBES0s2UjlHK3J6bXN5?=
 =?utf-8?B?dVJVTVBwQzAxMFRwbXRLdlFkYnhJTjI4SnZ1N1Blam9ibkk4eHpoMWRCb0Z0?=
 =?utf-8?B?QXVwWUxTUDJ2RVdlbEpqNjVqV2hmdEJuWUh4bG90M21OZ2tReTlPU0kwd2Zz?=
 =?utf-8?B?elhCZkpjSVRMQlJaMEVNMWxsTmtYNldSOTRKeXMyWUFNcFQyWGJIeDB3Uk5B?=
 =?utf-8?B?UjMrT2ovMFdESEZyZ3pYN0cyR1ZEajkrS0Z2cGUwbXRIZjJNaUJieUIrV2Rj?=
 =?utf-8?B?cjlKV2dndmVtOGhqVUFFTnNlSnNZc0V4V0d2ZVRLLzBuZ21zOGVzdjY4aFp2?=
 =?utf-8?B?N0VWSnBJYkZYVzdGSVViZXJCQzFtRTZZN0tqRDlRVythSXd3ZjIwNmZWR2pa?=
 =?utf-8?B?RnNMZGxOZ3pNSDF5SjhNZG9GRGNVZXFWNzhkSGw0OXJCVHg2SWRWbm9SOUJ2?=
 =?utf-8?B?SGkzcGJBS254dEh2ZlU3aFo5UHFBT1ZTdkZVWTFRSGxaNmlNT3dQUnBTV0NH?=
 =?utf-8?B?U0NDMFFBY3ZSSVdsTnp6Z1pzeXA2RUczcVFYZVVCTFlOR3hXanJObHR1UU5J?=
 =?utf-8?B?RU9XNlJuRUprSDdORk5Gd1VmbjBPRVBnRUs3MEVBZWRRN3NHRE5SQU44cjgv?=
 =?utf-8?B?bjNGcEcrY01LS08xUlBWa1krMUs3ZWNFaXA2UzU4NVZ5OVd5SXJZenRvWUVw?=
 =?utf-8?B?Ulc5V20xVnVlM0M0U3BKemdKYk1BYnNZdlZJWC9uREtqWnNOcUJtQXM1dm40?=
 =?utf-8?B?cmxSZncwV3JqL1Nwa0l0bmxjcUs1Z2l2S3dQbzFCaGpJdmxGUVRrbTFDYXFy?=
 =?utf-8?B?QjFFN2NUMmVJdDZSSkRFNzVqMWN4L0U5cDM2OTF6bnE4Z1Bpb25Hbyt1Qk9m?=
 =?utf-8?B?bnVnTDFYeFphZldsTVBhSzh4WkpVWk5YTlJCRk1kNlNyb0hWdUVlU3hscWlz?=
 =?utf-8?B?dm9TVmR2ZG9nd3dtWXNqT0c5T0FUL2RaSTlaM2JvWHdXdFkxZ21YYkxDczRH?=
 =?utf-8?B?dEN3UHg3emY4UWtvTXMrOXpIdlhhN0xLckR6UUZjOU5zaGV6VzVhTEpPQStn?=
 =?utf-8?B?amV1WmpacU01Y3E4RFRldjRvMlBJU0hvNHhkRUhxMzhHblFEUGlTRHBWYllF?=
 =?utf-8?B?YStpc0FLTjlpRDVxZzhWNUFaSUhCVEpFQ202bHE3MytLNHh1bW9TLzZGb21x?=
 =?utf-8?B?TlpMNVpqV2NWenZSS21aVmM3SnlJVkpxSFRJZHkwVE5XSjFNbnk3STFBdVRr?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D73C10B8086EA4DB4FFEA8F9FE95EB5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ace5c52-055b-4a17-8bfa-08dc9cd53878
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 09:31:16.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRKHtkyYADHmIl1PjofCcHtllLJc75rOFDCbtzVlv1fbAXzk5dov30MhrEPBjvVgtwLl3xpPtRzn8/m9/NqV9J3iz95oad7uMDkXl0UZ5M0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808

T24gMDUuMDcuMjAyNCAwOTo0MywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNC8wNy8yMDI0IDE3OjE0LCBB
bmRyZWkgU2ltaW9uIHdyb3RlOg0KPj4gQWxpZ24gdGhlIGVlcHJvbSBub2RlbmFtZSBhY2NvcmRp
bmcgdG8gZGV2aWNlIHRyZWUgc3BlY2lmaWNhdGlvbg0KPj4gYW5kIGF0MjQueWFtbC4NCj4+DQo+
PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWkgU2ltaW9uIDxhbmRyZWkuc2ltaW9uQG1pY3JvY2hpcC5j
b20+DQo+IA0KPiBTcXVhc2guDQo+IA0KDQpJIHdpbGwgc3F1YXNoLg0KDQo+PiAtLS0NCj4+ICBh
cmNoL2FybS9ib290L2R0cy9taWNyb2NoaXAvc2FtYTVkMzRlay5kdHMgfCAyICstDQo+PiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9zYW1hNWQzNGVrLmR0cyBiL2FyY2gv
YXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9zYW1hNWQzNGVrLmR0cw0KPj4gaW5kZXggYmZmZDYxMzk3
Y2I1Li4xODk0M2I4NzNmZmYgMTAwNjQ0DQo+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9taWNy
b2NoaXAvc2FtYTVkMzRlay5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hp
cC9zYW1hNWQzNGVrLmR0cw0KPj4gQEAgLTM2LDcgKzM2LDcgQEAgaTJjMDogaTJjQGYwMDE0MDAw
IHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICBpMmMxOiBpMmNAZjAwMTgwMDAgew0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPj4NCj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDI0YzI1NkA1MCB7DQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlZXByb21ANTAgew0KPiANCj4gV2hhdCBhYm91dCBvdGhlciBuYW1lcz8g
V2h5IG5vdCBmaXhpbmcgZXZlcnl0aGluZyBhdCBvbmNlPw0KPiANCg0KVGhlcmUgYXJlIDE0OSBk
dHMrZHRzaSBmaWxlcy4gSSB3b3VsZCBsaWtlIHRvIGZpeCB0aGVtIHN0ZXAgYnkgc3RlcC4gKGxv
dHMgdG8gY2hlY2spDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCj4gDQoNCkJlc3Qg
cmVnYXJkcywNCkFuZHJlaSBTaW1pb24NCg0K

