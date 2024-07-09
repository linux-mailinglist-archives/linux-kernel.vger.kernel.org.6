Return-Path: <linux-kernel+bounces-246005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE3C92BC92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615722821E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2B1922D8;
	Tue,  9 Jul 2024 14:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="E0L17sH4";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="pWLOAX2f"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC773257D;
	Tue,  9 Jul 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720534427; cv=fail; b=VQzsYor0honA+7MXu4r+2KmS649qMPo6xjmpix+SEaEJEnlzCjH1mJX4LufyMiu8Xi4Xg8Irn86MbT9UuLxhJfghmIzewYnwbaTiOJDWTeFEHMvyw0WNYU81QFonPIT9/ojt3qMrWv0bvfvGa8fpIuv8KRNtBwxPhn14JMcyFaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720534427; c=relaxed/simple;
	bh=bJO3uY78H8PRIIA3Z1twVxtEURGZnsF4Xo4nfyB0mBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XODv2gJmpuRnAUok4Qp+8m4K30elCz7yWPe+fHJGRlc0Nrs/VR0sjzRUyBjgTGZuh+n1DNax3LtT92eak8q/4+AuGebiTsV3TUQTfjfH7L8GvjaVxKlkAxo6ZOBbVGue5rGM5LP04uNgqNyOaO6t38Xvi6nPEIhRWHdnyfXuGtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=E0L17sH4; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=pWLOAX2f; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720534426; x=1752070426;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bJO3uY78H8PRIIA3Z1twVxtEURGZnsF4Xo4nfyB0mBg=;
  b=E0L17sH455siBxlTgUKQ56e4EKWM1WT0OjxCfsCeRe2Re5+3gHqJMYbf
   EWBcjePUfQZPHVan5OjxRDN1LCLaHSBYpR9zpy12PTGqdQdvrsHl8zaye
   87WmaqfxNPiQkOjTIkCGDNxK7sUnDZuDo/cPwwMwLp0RIj7ZKZcQTfeGy
   mJ/j+lvfsG5qwLqlkdZbIcyp8C3rvny6C+tyMysi1vHYvgElCJ/W0dUg5
   NxtgCAU3V7Oo0IzpApHv9TpxTNF1irVgrg2kY8SKnWKJcBNZuThIDnVy+
   RnSbBzJXN3haUEhEoUOT0/Jx9fHHeUKR2Rkbwuw3m/TpLlKKjhhzuik1b
   Q==;
X-CSE-ConnectionGUID: XrZ0bJ3MRFGI5V8HTMw9kA==
X-CSE-MsgGUID: 9SyWE42RSiWuPYI4aSxGuQ==
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; 
   d="scan'208";a="29653047"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2024 07:13:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jul 2024 07:13:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jul 2024 07:13:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMZaUpOAI8q0+DUHfsV1KPhAGTERKSa67Xp93vDd/D87ne2nMd/q1Fy7GQSXEImwF2tGFOA3Zvn7+6bfPb1dxrIKe3q338BVHvW6pG2p4Fwk9YoDuU/U0AAFKy3CAlKhcuXiQ08mlG3MtM2S88ywzv/LEkqvICP37DBUy7mU4r3q7KyXZ4DA62vM9fa/vvBHUv3yCo6l2w1x1BT7oIXpWIT+J+QCWDccwryPNyCZdRyoO/wuyDUhLzNR7ts8Urk51pvkyxlvWbrr/ntCOMtMv1qY/+Z6H4782/3AyNLFHWtGJ46L/+TpLXh8N46cEOlynHFgkm/4SHwmgQjcR1oi0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJO3uY78H8PRIIA3Z1twVxtEURGZnsF4Xo4nfyB0mBg=;
 b=K43RsETOY1+XjYY7ewdi7czXbMVWBSxz8prALD7X2TWqaUeD8qZZ4zAtUwfG0MW/lkDx9RoiF7Kl8+nJc00vZohB3BgVd7u/56PrQHY7cR42J6DjrvOyems8z0vY5GFVoo0AiSRps7PFmHiQ0YztX7DDTU8BVQbLfkBzbn74lGy2odMP+bRyJqPCoEEdHhUpE1flTgC1FesWA0/3eOYEfNtcRIbDOeGdtZlbRYDdWL/ToOzxM2OT5WEgPlw829Ed9q4GRJQdOtdmJ6+TBxKDL3U3gH5ZFZDR+ddWg+a/1ST3O6qUDcshCItgB9cOplfuvWfuXod9NoD5E6dXF8f4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJO3uY78H8PRIIA3Z1twVxtEURGZnsF4Xo4nfyB0mBg=;
 b=pWLOAX2f1wdMOEuetuvmyH7HJg+njCRerU0BSfcfPRhi3DgTc9I4vNz1ZCRPzB0uwxjoGWgM0No+aSJPiGnDiCYoe3FZNJf/+GXR5gIKeSarJ88+5Uw1oGh78o2Vx1jqFkXYyZm8gFHi/TJUzk1R4jTl0j84VAExI18mXciP0Shq0LhFNIfTvA3aud/Qv/ZKRxKPnblvnLABaf332dRLPJyZo6ZtamQATpmTMI3luqJPvKQtYHQVerRRJUgP3n9y9UP8L5jYHJ29ktWlkl5is6hq/Y/7Whq+YCleWIPX5n8Sv/tBkVu2lFSruthV7+zCNROsP+rWZym/wYNm3nOD4Q==
Received: from DM6PR11MB3450.namprd11.prod.outlook.com (2603:10b6:5:5e::11) by
 CH3PR11MB7322.namprd11.prod.outlook.com (2603:10b6:610:14a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 14:13:26 +0000
Received: from DM6PR11MB3450.namprd11.prod.outlook.com
 ([fe80::a925:8ea5:fab4:a56]) by DM6PR11MB3450.namprd11.prod.outlook.com
 ([fe80::a925:8ea5:fab4:a56%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 14:13:26 +0000
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
Thread-Index: AQHa0go4Jdk8LCoPa0irjnUWbMvEuw==
Date: Tue, 9 Jul 2024 14:13:25 +0000
Message-ID: <1387aa1d-fba4-4873-a107-aa33e773c9af@microchip.com>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102814.196063-1-varshini.rajendran@microchip.com>
 <20240703-dentist-wired-bdb063522ef7@spud>
 <a41274c3-fd32-4eba-8240-bf95e41f63d9@microchip.com>
 <82ca4f3d-fa78-4617-823e-69f16a2c3319@microchip.com>
In-Reply-To: <82ca4f3d-fa78-4617-823e-69f16a2c3319@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3450:EE_|CH3PR11MB7322:EE_
x-ms-office365-filtering-correlation-id: 7871073e-94b3-47aa-d9c7-08dca0214c9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGlRNlFvRnh2bWw0cWIxWDVWTUpzZDBoVkkvZzZDdExYTlcwZXpISGZlOHo5?=
 =?utf-8?B?dXMwSjN5MndnSmlhZWh5VWxVMmxuakliNUE2M1llMVAzemp3R05WQVFLazdl?=
 =?utf-8?B?dnpEbmVnUStKTyt3elJsQzZQY25ZWFdoRXJRSVllNVBiV0NaR1RSTmZJNUQy?=
 =?utf-8?B?VXpTdHRjajNGN1lHZ28zMVB2bSt3aDFLa1N6RG9UaWlURldDSjZIT2k5c2Vs?=
 =?utf-8?B?a3VWWERjUnNqOFd3K2haY2RuanZqbTBUcUh1S2FtV0JsSWpZODRiVWpyQWYz?=
 =?utf-8?B?MWIxR3F4ejRoU1N1Z2hUZnE1dm5EUkNzRmRCMCtETjBxQ2kvbTltR0hUNmVt?=
 =?utf-8?B?eWZrWlprcCtlU0RBZnFKcWRYWGFUS1crUjVydXhMdmdvdnMzdXg3dUpxU2NX?=
 =?utf-8?B?MHFrQ1RoSUFFSEk3MHBRY00ySlRjbk9zN2x3VGlkNXM1Kzg5Qy8ycGpFSXpG?=
 =?utf-8?B?WmwzeXJ1b2w5ZUZRbm9vYyt0WnV5WnhFMzRJdXFlcTBsUndlazVVS1ZUSkM2?=
 =?utf-8?B?TFNrSnZkOGl2MzNDMUJDc3M3VXQwZi9tekhYSTc0MFBsMUd6cmlFZ3BmYzN5?=
 =?utf-8?B?c0tBL0JiVkF3VEM1ZTdQRi9CZ1cxZHZCZytmVjVXRGNSQ21keUM2N2ZDZXdq?=
 =?utf-8?B?MStmTGxwTmFhcEpvSlM4Y1V1UVJmaFJIRUxZbnFCY1BWZkg2em1QNWpiczds?=
 =?utf-8?B?RXJCaytGWEtranNObS9wbm1BRHJ3YmViSjdaMUN1SWQzSDI1ZXdpWis3VVM0?=
 =?utf-8?B?RmtVSG9yU0REYmdVZFR6N2l6RUZPUkRWMTFZeWt2aWdsa000TGE4Nk5YT25y?=
 =?utf-8?B?WHBoeWZwejh0NGx2M3o3bjlBTitMQUdoWHRUK0VtMWtuektqRXlIcGNmblgr?=
 =?utf-8?B?Wk1qS25NblcrWDhmOXdMa3hNTXpScVdMcUx3UXZvbTRWcG9teXpqazZ3RUJq?=
 =?utf-8?B?eFZWRUdsVk0xSkF3VnhGYkFPSnVSRTJlUHlBY2RDYVN4OTNyNEQwT2xUVno0?=
 =?utf-8?B?OEhPTVFRREtjZ2tqNlZ5RlZDd1dSRHVIeVNGUUNyMEtCalNFSXJCUEg2MmJG?=
 =?utf-8?B?eGZJZVRITzZvUzRRdEhqeFRjeVRxS1M0SFMrUHlBaFd5bXYrU1VXc2lYdE1I?=
 =?utf-8?B?dmI1UVAyWVlkc0NSRjBPZTl1Z09zajdSVHBZZVJTQU5EMHRSOVVZbGtrN0pm?=
 =?utf-8?B?UHBRMmNVSFVzYjZ1blpBM056SkdIdnJaUEpxd0pIa3RYZDY0SWdxNEk2Q29W?=
 =?utf-8?B?dkc3NVZMaEh4UWhmV3M2eEtieVJaZy9WMVBLVTEwV095WjljbUJVVjJYNGdl?=
 =?utf-8?B?eXZmbGdLOFdvWnNZQmFjZkoxODhTbHhFUXk0emhOR3d4QnI5TlkzWGNNcURq?=
 =?utf-8?B?K3QzK05Ha2grL0RZUUVUZUtXTlY5aUdud3F0OG1BLzRLMmJ3ZGVHYzNNU2VT?=
 =?utf-8?B?OS9wVlJ2ZWZ2ak1JTDcxWVJTV0JyK0h4ditKbk5IK2poeFErdFhydVpBRUxL?=
 =?utf-8?B?M2JmSjRzTWJRMEwweFg4dS9ocVBqQjhWSXA2YWNQUEE5N1BHR3R5N3VMSjVD?=
 =?utf-8?B?MExyN3Jmem1DSWtBT094d0JtOGJGTWN0QzU4a0tScUpBTHQvM040NmZVSDhN?=
 =?utf-8?B?ZFhHNHgrT2F1aHAxOXBuZVdPd1VnZUwvQ1orbHlyek50amJiSkdFSlk5ZVMy?=
 =?utf-8?B?cFEwYXBrR1FSWllLWFZ2SXJCdmQ0RTdpUG96cTdnVW5ZbVFuNU9zR0RhV0ZZ?=
 =?utf-8?B?Ykpha3AxTWpER3B3bDBnWUgrVFFFZ20wTlpXZFVhYlc5R245MkhwUTE0Mk5j?=
 =?utf-8?B?cWhrelpoT0NUSDNuSUhjYWhhc3QvamZNRFlkQXA5VG5JcktQMW1xQXJPL3hG?=
 =?utf-8?B?SmYvTXBOa2tOK2I3ZHUxdjI3WW9FTXFDK2xEVGtESXlNa0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3450.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmFISkVyY2xIbXpxME9pWHI3Vk5uMXlyemFKOVMrRXlvVW1LMmVwMFFWZVls?=
 =?utf-8?B?TVFnUGRsVFFvWi9ubGpNN0JLY0F5RG8veUp0VEltWVVyeFBacFAxODBNN2Zs?=
 =?utf-8?B?aWYzTEwwTEI2MHZzejJYV05kVUszZFk3OTZZdFQrVEdLb2htZUFZTnF1Smc5?=
 =?utf-8?B?d3d3YmljRUg0dFZ0Vm9oVm1nSStwRWNaSGFrYUs3aDREdEJkWEhxTGVkMTV1?=
 =?utf-8?B?eTNyWHkxVjBEVlRPa1RQMEZFMEhENXJwUlBsNzFRU0F0bnZFK3dNdTN6Ujk0?=
 =?utf-8?B?SnI1RXkzOEMrZVNndS95eFRuTW9sQ2E0R1QyamlWc1EweFgrYmpnR295d1Ba?=
 =?utf-8?B?WWx6TzhwdGxCeXdnZzRXamRjTFM2UlNCUDE1Smp4ZkpzUXFtRG80V25QenhM?=
 =?utf-8?B?ZUpxVU44RXc2SkhGU3RvYVRidlJLaFVxUFE4Z0xYSXJub2VzYU1QRjByQVFK?=
 =?utf-8?B?dWF3OHErUmVsa2JoQTJ3UUlFNzltMHVaWG8zMkthdzROQlpiVlE2K3lyQ2Ro?=
 =?utf-8?B?Ui9SeGM4QzJyQnhKb1dETjJmSlQ1NTVGUzRtRGVZdW5PZEoveWpDcHluQmFx?=
 =?utf-8?B?Ykpid0FwSVlWK1VaOGUvSks2K2xDc2NlaXdwRHNyZnQ5eGxWSGp3Sk85U1ZW?=
 =?utf-8?B?cHJnd0htcmFJcVZ5c0RBS3dDUUxJWWd4VlljYytwc3EwazBPREdGVkdFeXZq?=
 =?utf-8?B?V3o4cWlnKzRYOWFHKzBUekVUUkdDTHlXWG1KVmJBS3dkdHZ2NUxWUVYxNmpk?=
 =?utf-8?B?ZWtXb1Y3WXVqdldMbC9UcnBHT3ppVlkzR29HK0twRmdrbzhvc0JmS1ZzYkh3?=
 =?utf-8?B?Q0hIK2R0R0hjZWE0elZoTks5dzd6MHVDWWoySnR2NmpOM2xJWGkzTVo3akNY?=
 =?utf-8?B?OVRuQ3RTazNaK1IwUEYyODhOZ3hYQVlUMndaTUNqOGQ2Znplak5HL1dvZ05v?=
 =?utf-8?B?THdBOFVOb1RiZkZFaWloK3ozaVVUWEh3NnNGR2YvNENJcHVKYWNHWi8vVTNq?=
 =?utf-8?B?Z0ZHOHJGNHJhc3NUdjhRRXZHNHN3RkNrRkptbDlEME1UVXZiaWtHM3AwL0x3?=
 =?utf-8?B?TUhtWWZyYUdocWZORnJHbzJrSGIxSHZWcElpK1FrNTdKUEtYNlNjVVJtT0xx?=
 =?utf-8?B?M0tTcmhpakx6cy9BdXlVRUtROS9pYTVENnJFTWc0ay9jQ05QY1dqQXJOZFBW?=
 =?utf-8?B?MmRxUm1pTlNCdWlRVUN4VlJiMmxlMDJyeURveVBOeXkrWUxwYkFRYUFFME84?=
 =?utf-8?B?ZGhVRlpaNHZ4bjFBL0pyQndZaWJ3L1l3dUNJVXNLMjk3OTBzb1dYYktNclVi?=
 =?utf-8?B?WjVtRnFvQ0tDblY1ZU02U2dJRGJNbU8wMUpYYXpXdEprcnUrVGJpVTJoRGs3?=
 =?utf-8?B?RWI4U2lkVWdpdnZKeVY3VXIzR09MYzdWdzE0eTJ2dkF6SWVBUVJsMktSeXBS?=
 =?utf-8?B?RHdIc0pEZytmMHZ3RElsWjNsNlFRVG40aG00QkZXVDlIajB0UXI4UEZDTEVM?=
 =?utf-8?B?cjZBVWNPeG1HZmoxR1NWeFRVNVVyTXphRjJzS2xFVmtXM0RCV21jU3BocmFn?=
 =?utf-8?B?N3JOcXlYSGJqaVhYb0I1Rkx3U3RZN0J6bW9WTFJvNkVIRUUyWDY0ZTlma1Ex?=
 =?utf-8?B?WkwwOTY3a1B3bGlUWGp4VGliQUhjSDk1SnM3R2xUSjhCc042V2RHYldUVU0y?=
 =?utf-8?B?UG5MRGxnV3hpN3Z6akpBQ1poWlBFQVZnVWFBWkRtaHdqWFplWkFXczlaOHFl?=
 =?utf-8?B?QkY4ajZOT1Q1V0RTYlFiSUMrTmIxd0ZmSWt5bzRETXJnMlFmMEFHS01VeEx1?=
 =?utf-8?B?c1FJT3RvWFlkbjltak5paXZiSWtpRTUrMmVjdEk0NUVJU1FCSy96blpQNHBN?=
 =?utf-8?B?SXNBbEhLQ0EvL3dyMmUxaEU1TWpqV1VtdVF5UVJwK0pUVjRWK0lOR2RkK1JT?=
 =?utf-8?B?MHlhakxPemprMWwzTDdxeXN1cDl4b0tQNHEzbWlGRlZwRE9sVFFBU1hIbkhH?=
 =?utf-8?B?MGdJbDk5TmVTRUlGc0d0NHpXbnNMb3lpMmFsL1dMVjdRYnlwU3F1bUZSRzVB?=
 =?utf-8?B?M2MxNlVGMnMrVmRKcmpjazhvTHZyb2Jjc0tZVkxjV0JQcldySDFhNDEzTllq?=
 =?utf-8?B?SWtYamVyTWdJRFFXMHU5RkdYWStEUEVEZzYwcXdXbU1lakpuRWxnZGJNcTdN?=
 =?utf-8?B?VUU5VU5RWUpWS2FQWjdkSmVqNVNmb09jREZ1MWRtc0lDbUl4N096aGRkRi96?=
 =?utf-8?B?RHVTWjBzMG1tR0d1c2ZDV2hzbE1BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3A504909344F745B1C6B782856821DD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3450.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7871073e-94b3-47aa-d9c7-08dca0214c9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:13:25.9332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5B7iEVvStunWzXzT+oo+2L/FpWD7xXhidH4zJeq9KVvgIH/A6P/z3BGFFvJh+RwD5oCE+F54J1oGwbTdLbj0RXYiOn2059OsAfwuq9cWKIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7322

T24gMDkvMDcvMjAyNCBhdCAxNjowNiwgTmljb2xhcy5GZXJyZUBtaWNyb2NoaXAuY29tIHdyb3Rl
Og0KPiBPbiAwOS8wNy8yMDI0IGF0IDA4OjEzLCBWYXJzaGluaSBSYWplbmRyYW4gLSBJNjcwNzAg
d3JvdGU6DQoNClsuLl0NCg0KPiBJIHRoaW5rIHRoYXQgd2UgY2FuIGNvbnZpbmNlIE1hcmMvVGhv
bWFzIHRoYXQgaXQncyB0aGUgYmVzdCBvcHRpb24gYXMgaXQNCj4gcHJldmVudHMgaW50cm9kdWNp
bmcgYW5vdGhlciBub24tc3RhbmRhcmQgcHJvcGVydHkgdG8gdGhlIERULCBicmVhayB0aGUNCj4g
QUJJIChhbmQgd2FzIHVzZWQgaGFwcGlseSBmb3IgeWVhcnMpLg0KDQpzL2JyZWFrIHRoZS9kb2Vz
IG5vdCBicmVhayB0aGUvDQoNCj4gQmVzdCByZWdhcmRzLA0KPiAgICAgTmljb2xhcw0KKHNvcnJ5
IGZvciB0aGUgbm9pc2UpDQoNClsuLl0NCg0K

