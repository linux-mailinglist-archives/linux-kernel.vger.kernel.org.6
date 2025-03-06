Return-Path: <linux-kernel+bounces-549501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D616A5534C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5976E189497F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D51225D1F8;
	Thu,  6 Mar 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Xg4Ro2cR"
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1911255252;
	Thu,  6 Mar 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741282995; cv=fail; b=AkfXzKQk54ylSgpfZgrDn7nKHh6g6zn5eSRjEzBg7xvMDCn20hbmT+lnmZrGID7WagbubcoungFn8cTCsiuShEddddyhNHNW6f4/3hUU+P7KFPgh5dL1tCRpqs7NxZSfTIYlnOseJFmAxzghsttnrlOJMtlOVgYtKLr/ycNzaUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741282995; c=relaxed/simple;
	bh=13yRi73qxXxLNPKVeqbNiVLUJJss/Jpb0xXsM/Vv10k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m0U+KbrJmt7xSK3vqq9l2tUGBUwlxdXCVmkWjTydukOd4nczB/jzEIl0/iiD1BV+3muCaUPzFiA1vF8naqzhvbbsZPSURTY5Cya/sWmPtxooZSmUqFfKgE1XkkoKGmnUJNRonlm2rK3/kW/XUwXSvVnPXBnj/qbCgH4ozsEShFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Xg4Ro2cR; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Gos01032336;
	Thu, 6 Mar 2025 09:42:59 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 457fka03p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 09:42:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XwkIAS6GgfrTo3FowH7Fq06uwIiw4t3ZO/8hQh3WikNErk3LDYLdUWuevDiXmYQq2tzCO6BYKbuX3Qu36RhRwz8ioE/qCBqQnWc3ihWShhOTSioZjIV3SJzbrEtkE/HBrB3MtJP91o3Vc4NDQIyW304/aIPyJKDP2FzbEkEhwqeCzHszZ+2gE7UbJ/OOj42Ou9IBoYVWpvmGnBZTcw0RAhs4HLvqb5CAGAYra1fjYO9MsRCxQXUTyluhbevLzCzlQJt2fLZ9aktzhVkbxmtOuSV8lMNjJHJzEepjeVMOXAKR+Pu/6f/ojqKCbZmJqI+S9tnc6Q2uRG7mVAxFpePKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13yRi73qxXxLNPKVeqbNiVLUJJss/Jpb0xXsM/Vv10k=;
 b=U+NQp8McpU7diGaH6659EoDJeZYakoUy0Jg+w3kEomZlFLVjNFD+3cM/Pq78EKVCc9TKQkGB6KxOiDqCE/oMkCm09r21W2WwFOYKx627qje8bKpUwvIjrz2rF2vUjoop2o1BAD35sfWRFdv7OnX2KYImITYJffQC590Rn30dNP49RGIuNCEqhoH5xGL4em9zpc+Vlr6eqoTdIyd9/SvwQBJRs7iCqqhqJE6ia3aog4VuF35us9m9a8dvU2xT5ayPTj0aZ1pA/5sR/ohdgvr4BWJZTmNaPALvcXSz1bTStXdWhbbKqK7b2d65EXa7aQfW019lJlWww648+g5gq3CgKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13yRi73qxXxLNPKVeqbNiVLUJJss/Jpb0xXsM/Vv10k=;
 b=Xg4Ro2cRJpRO1BTb2qIqNPuMnNQJkXJ2g+1p2pztk40cIW7jS8KkeTkO4WYFFPaJ5a1K6ESmCCkndnAbKzktWrjh0fNcapqlgM4v8/gqcTIM/VRRa5L+s2DoUQ9oeTyrZaSxjU+nHS7dAU35BPDAPWEw/wdQOsJIN9s6/PAD7Vw=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by PH0PR18MB4815.namprd18.prod.outlook.com (2603:10b6:510:cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 17:42:56 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 17:42:56 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>
CC: "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com"
	<sebastian.hesselbarth@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>,
        Sanghoon Lee <salee@marvell.com>,
        Geethasowjanya
 Akula <gakula@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add
 reset controller node
Thread-Topic: [EXTERNAL] Re: [PATCH v3 3/3] arm64: dts: marvell: cp11x: Add
 reset controller node
Thread-Index: AQHbjTjDlmveOHdHsUCietifim8dULNluHAAgACo4UA=
Date: Thu, 6 Mar 2025 17:42:56 +0000
Message-ID:
 <BY3PR18MB4673BD07048F8AF7EA55282CA7CA2@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-4-dingwei@marvell.com>
 <d085c34a-fdbf-4950-a2e3-b3d25a1c0145@kernel.org>
 <BY3PR18MB46730C150D4CB9619B3B05FBA7CC2@BY3PR18MB4673.namprd18.prod.outlook.com>
 <050ae833-10b5-4d80-9856-8bc2f434a74f@kernel.org>
 <BY3PR18MB46739700B533630D65C60808A7C82@BY3PR18MB4673.namprd18.prod.outlook.com>
 <87b9e9c3-87db-4ebe-96b0-4f04705ef6f8@kernel.org>
 <BY3PR18MB4673B4CEB60D3D21AB17B01DA7C82@BY3PR18MB4673.namprd18.prod.outlook.com>
 <03b14353-5d47-48de-99fd-9cc48bad5651@kernel.org>
In-Reply-To: <03b14353-5d47-48de-99fd-9cc48bad5651@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|PH0PR18MB4815:EE_
x-ms-office365-filtering-correlation-id: d616a160-0e8e-4c91-566d-08dd5cd6546f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dHlWQWlrUFdsOUlOaTZ3MmxScFdPZ05pdVF0STM2SGlQL3d2dlIwNE9oRzkz?=
 =?utf-8?B?VWFRY1RpZnZNNENWNlBESFFUdUwxWjNRdDBuMDJLVWpsQTBDMkFtK21XK3dK?=
 =?utf-8?B?bTNtTTE2UXZvUzB1VnhiWHhkMW5yY0xtTERBSlNSSUhvRUhtV3BERDJjVmdv?=
 =?utf-8?B?S0ZrMitzOEJ0RGdmVDJ2NjVuTUhPUkxnRGxJWGtkY2dwc01SRnZHZE41MFVR?=
 =?utf-8?B?WXhMOU0xdW5mallvdTlXZTMyc29HRXpEc0ZBSG5SYmM2T2F4SnRneEVtUFpJ?=
 =?utf-8?B?amlkcHVocGdxYldFaU1CV3EwaU1sSW81UFMrWUkwaWc4azFuYVB1WHZHWkNC?=
 =?utf-8?B?N0dZVVVaNUZoNkpBVzE5TVY1SUVDRDZPcVRKaFRzclc2Z0VkcTJiRTlWY0sw?=
 =?utf-8?B?aEZWeVE2dXQ1WndDSUFaK01MQ3VRSTBJZ0NNQk1DVm50ZGxiU2ZyNUVmNmVS?=
 =?utf-8?B?MVNkdmdna1NzOCtpZnBDcFNCWXE0Z1Q3ZEVpK3lWd0ppV3YyQTVIZUlGZTl2?=
 =?utf-8?B?K0xVM1d5RkwzY2J2aElndXhmYVFVZHlFQVBBMFladW52RFNDK0k4QUZWdUY0?=
 =?utf-8?B?WUxEejhJSm1WcWMrUVpxSlVmOFVXZi9VemdtLzdEaEI5Z1pkVEREYnVGakNv?=
 =?utf-8?B?NW00WUE0NUFZZnVkem9mQXJWWDZIV2lqL3RLVnQyN2J2azZoZ1NOU2hNK3pQ?=
 =?utf-8?B?RHJ4M3NldTNCNHVvRzZ0eUVtVTVKUlkyNmJWYmRwSzFDZlpteDhGdTlvYjUr?=
 =?utf-8?B?ODRjVmwyVWdIQWJxQ1hKWnJ6bUd6V1EvbW90aFJra0NzMTN1RXRRQWM2VmY2?=
 =?utf-8?B?UjdqMlhJRy9nWlMyMHYyRmNkNXU2aHVQTFJFVjlLVHJqS1Z3eUdXYXFxcHlP?=
 =?utf-8?B?TEprK3Niamp2RmZIMFltUE94WEpSdEdndTIzR3pMRk16ckt2SFE1NTkvTWhz?=
 =?utf-8?B?NGVwOWVlZjZ6U01YZXdUS0UxS0xUOTl5QjJVdEdUQ01Tam8wWUVkMnZiendl?=
 =?utf-8?B?d2dVbm1XL0dFdjcwS3B6MlIyemR4cUgzc0s4WUEzZzFldWN3R2RJZDRNYzNG?=
 =?utf-8?B?M09ZTmFRcUZkeDFONnFaVVA3TFFMZy9nZFpEeE5FcXIxMDVIUkcyOHlpMzBz?=
 =?utf-8?B?dmcxZmYwK1dyR0NhM09pQ2NUNHQ5eTV5U2tPSFFVVTZLeVFVS1BZZkJWRnRj?=
 =?utf-8?B?Uk8reUZRVGtHclcyRmR4UENOT21SSUVGVnZBRmxhWHJkVTU1dTFHNDFEMy9w?=
 =?utf-8?B?Wnd5TThaQmVEWDkybzBhOGhDL2xBR3N6d1VEU2FzZzNLRjNCdE5aeHdFd0VY?=
 =?utf-8?B?dFBuM0JSNlNsWjI0ZmhRd296cElGSnpCTkdrOHZZb1NFcE5ML1NscjNrZENl?=
 =?utf-8?B?b3hPL1JvUmdEQlVtak1RNkRMQTFSNHh5cWdKbjc1Y1YvaUlXSTRkbmEvWkNh?=
 =?utf-8?B?RFZRMVhMVHFWaURneVJYNDRhTkp4WWFPSWtWaEhrMHhlSUxpcGpQdzdpaisr?=
 =?utf-8?B?QThGOXowOXhsSWxiQTBucEszYWorVldkVXdGNVVKSzViZUlSK1JORjc1ODJS?=
 =?utf-8?B?eE5nNEY4K0hha0ZqYmxXSmRBSVorY2hYdjFJUEplc0V0QXdZVXNBTXc4SGtQ?=
 =?utf-8?B?Q1h6VFZaSnpaczVicTJDUnJLbzBxUTBPQWV1ZjZRWTZMUTF5aUVFcUJCb2lH?=
 =?utf-8?B?cFNybU4xTktTVWZTQkdLRU1mWmtZQmxGV2dlTnRvSFBSb1VLMGtnZ3d0ejJF?=
 =?utf-8?B?TmRyNjkxYUczS3cxeGxZUE4zVVkreVBoc3B0bU1mbkxyY2tpSmdoaythOHJG?=
 =?utf-8?B?djJIRTY0ZHVRNTlLR2JVTGNIUVNNMkhtdHJrcGJmV29nL25lL0dPQkx4c0pE?=
 =?utf-8?B?ckFHRjltQjg4Szk5M1pTSGhMc0p3V0thek9aaU1FV2FhajFRZ0NEYVhtMUNz?=
 =?utf-8?Q?lj4JcWwYwbzE+GhQEF6Sdc5dsvreWS+F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clRGYjk2L2tUNDFTNnY5Sy9zUGFTV2NwbnB5Sm8wOTFpVkhHNGxMcGxpVTgz?=
 =?utf-8?B?RDFFWHkrMnRYS1pJQXhkNVVGak9WalROQjBVUnhIZCszMkJSWnRRbS9oRit4?=
 =?utf-8?B?YTFHVENjRzBKYmtudWdEeUhlZUNCRXZ4RUFnd3l4ZXVDbkV6RHhIWTJkQXVQ?=
 =?utf-8?B?cmxGRFE2MjhKSkFnaTJob1JQV3FtRHFUZml6K1lDUTJrZjdtM2czZXJUL1lY?=
 =?utf-8?B?OUhFRjhOcmNyOVhoUkVnaFpNY0ZkYUZQMkNZNzFMYVU4U1lDS2hZZG0xbzds?=
 =?utf-8?B?bU5WWkhoTzFXbjJKNGtSeHJGRFBrMjUxb1pnQUs3cHRad3ZhMFFtTmtQSDZR?=
 =?utf-8?B?QVd1OU5jZ2duQlU1QlRrbDF4dytkeFRpM3NrM0licjRZQjNCbzdHSGNmSHlx?=
 =?utf-8?B?M29RR0w0OUY1L3MxekhTV2tQZTM5RFJkdWdQcDcreUNuMDVsVzRMeTIvQVhF?=
 =?utf-8?B?MXdSMjVrdFpRZDhSOFNPajl6TXh4WExMWlAwR2lsS0tJclFWeVJ1VXRaWmYv?=
 =?utf-8?B?alhtNWNQMWttM0o2ZlpMR25rRitXR0Y5QlFpSUxUaGFOWHhaSHpKOFdZZEk1?=
 =?utf-8?B?QlBQUDV1cDlJcDFMMGVVd2ljT20zcTR4a2tSRVNZOUdTVTV3dndhQk5tNEln?=
 =?utf-8?B?Qlc4bFBhdElmc1BwL0lXZVB0WVdtZktyLytsUGozRlRQaEpKTXpLQmdqSFZ4?=
 =?utf-8?B?WTU0dXpmUjU2NFBqb0NkUkYydUZXTDFVZC81VitXTUVrVEE3R1VJQ1RlT1Bv?=
 =?utf-8?B?eEdxY1RvKzU0c1c3SHBzY3Q2V1p5SEY1WW82ZEd5eFJqN2MyTTM0RHBOV2h1?=
 =?utf-8?B?VzdRM0l4Nk9qckp4VFlOSG9QaFFFMG4xN2xscXN5ZjdSdFNNZGQ2c3Aya3Zy?=
 =?utf-8?B?M1NKTzR0N3NDTE0yWDZra3BLUjQxTVMzRkZ4U0NHMitNOE9zTXNYanJOTllS?=
 =?utf-8?B?ZWo1TitOSzFrSDh2RldhTkVvUkwvVXhjQjU5U3lqY3lBWVd4RjNMamFSSjRB?=
 =?utf-8?B?aGFQZXRqZkRwRkpiVnYwcTRRbUdwWWRYaEtQMU94NUtpcVF6SXdjYTZWMnpj?=
 =?utf-8?B?YWZEcm1HdEVYa3YvK3orSWUwSUU2VkhtNEZxMVNLRTA1WUtJMUpoVXlyeFM4?=
 =?utf-8?B?czM3aE95dDhseWFKR3lYZnlXMVBRYnhUczAvZ3ZqUVZaUFh4QlBtZnluUWcr?=
 =?utf-8?B?WTRNWGxab3dJVnNMYWpxR3ZacU9XL3Eyd3ZsL0YxbnBwNlFRZDFUNEg1N3hT?=
 =?utf-8?B?bVNSOU1FWC8xcVV0TThWUHFPLzZya2llK3Z5YkNRamhEUUE0RUplc1VXYmg5?=
 =?utf-8?B?VFZIRlZZR1RDb1JJbFhxTEovU1NiNlUyem1maU8xMlgrQkU3aDh3U3lwVzFK?=
 =?utf-8?B?c2YxNHdGZGdyNzZxb0lMNlQ4bTBObmF6d3B0ZkNORXE1U3pxc0tkWnJMSjNs?=
 =?utf-8?B?QnZlKzh2U2c2NDRSdFMxemF1ZFRrcDlrN3JSQjdEcUxLQndsMVc4RHhZNFJi?=
 =?utf-8?B?T0VVRUE3QXIrNFhoMWY3Z2Z2Z1FqZTV6ZVlxNVdKK095YUNnZmhQcUxIamt6?=
 =?utf-8?B?S3ZqOVByK2VQeTB3UzZySjVncW91YThpK2taWGdZYWEyNW5qaW50U0k3dTQz?=
 =?utf-8?B?VUVkTFBkUW1iNjRBd3lNNFc4NTFoYkJ5L1BRaEZ4WmpBN09DY2ZZdy80OWVt?=
 =?utf-8?B?ZThCNjZvMWhrdEQyMVdEWUNaUDhaUEpZUitBNlNGQWZ3N3BIdkpSc0pXVXFp?=
 =?utf-8?B?NXgva0dRRGdxU0lHY3VZNk5pOHQ1Znh0WUNOZktrVGRhVFRtenI3NWpBMnd0?=
 =?utf-8?B?ZGsxMUorS25HSlBvQlVoTW1lemoxVERJd0l4Y0lkSWN3QXFwelpMa0NZOEtm?=
 =?utf-8?B?RHkxaVZkZ29pOHhUdlAya3JCbzI1QnppdnRieElyR3IrOUducDlCMXFKdno3?=
 =?utf-8?B?WHo3Z2ZpU1ltN0FkL1lHRXV4Vmk4OVRXaXpYNVhLbTg3VDNKL080ZDdTaFA1?=
 =?utf-8?B?NjdDOEE5bnhZb3E1MC9pK3E1WXJ0OGhoQk9XeHJxRzhuVHJWQStYYWpkU2hG?=
 =?utf-8?B?bDV2endwZitNSzdVTVNnMkNNekZpZ2VibkljcEdEdGFxTEIwTTJ5bTdYc1kz?=
 =?utf-8?Q?+eEsgHjl8UO8kg6yI/t9ResLX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d616a160-0e8e-4c91-566d-08dd5cd6546f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 17:42:56.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7NB6TeY2yjgrtT0w51+FiWaWfGx5/MAogHgcNNriHFKAhavvqRI1Bl9pOKldeOJhILGAwUlL4BBhS7ZEKnVDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4815
X-Authority-Analysis: v=2.4 cv=dfZ63WXe c=1 sm=1 tr=0 ts=67c9dea2 cx=c_pps a=ur2hu7Zt/Tb0cWAHmjvzJg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=K2Ikim_x1ZJM1iTTlz4A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: wO8qW5q_vQc17tfT8yk41nnd1Xv3r5az
X-Proofpoint-GUID: wO8qW5q_vQc17tfT8yk41nnd1Xv3r5az
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_03,2024-11-22_01

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIE1hcmNoIDUsIDIwMjUg
MTE6MjkgUE0NCj4gVG86IFdpbHNvbiBEaW5nIDxkaW5nd2VpQG1hcnZlbGwuY29tPjsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gcm9iaEBrZXJuZWwub3JnDQo+
IENjOiBhbmRyZXdAbHVubi5jaDsgZ3JlZ29yeS5jbGVtZW50QGJvb3RsaW4uY29tOw0KPiBzZWJh
c3RpYW4uaGVzc2VsYmFydGhAZ21haWwuY29tOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0
QGtlcm5lbC5vcmc7DQo+IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IFNhbmdob29uIExlZSA8c2Fs
ZWVAbWFydmVsbC5jb20+Ow0KPiBHZWV0aGFzb3dqYW55YSBBa3VsYSA8Z2FrdWxhQG1hcnZlbGwu
Y29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBbUEFUQ0ggdjMgMy8zXSBhcm02NDogZHRz
OiBtYXJ2ZWxsOiBjcDExeDogQWRkIHJlc2V0DQo+IGNvbnRyb2xsZXIgbm9kZQ0KPiANCj4gT24g
MDQvMDMvMjAyNSAyMDowOCwgV2lsc29uIERpbmcgd3JvdGU6DQo+ID4NCj4gPiBJIGRpZCBjb25z
aWRlciBzaHJpbmtpbmcgdGhlIHN5c2NvbidzIHJlZ2lzdGVyIGFkZHJlc3MgcmFuZ2UgdG8gbWFr
ZQ0KPiA+IHRoZSByZXNldC1jb250cm9sbGVyIG5vZGUgdG8gYmUgaW5kZXBlbmRlbnQgZnJvbSB0
aGUgc3lzY29uIG5vZGUuDQo+ID4gSG93ZXZlciwgSSBmb3VuZCB0aGUgc3lzY29uIG5vZGUgaXMg
YWxzbyByZWZlcnJlZCBieSBzb21lIGRldmljZXMgZm9yDQo+ID4gbWlzY2VsbGFuZW91cyBjb25m
aWd1cmF0aW9ucyAuIFRoZSByZXNldCBjb25maWd1cmF0aW9uIHJlZ2lzdGVyDQo+ID4gaGFwcGVu
cyB0byBiZSBsb2NhdGVkIGluIGJldHdlZW4gdGhlc2UgcmVnaXN0ZXJzIGFuZCBjbG9jay9HUElP
DQo+ID4gcmVnaXN0ZXJzLg0KPiA+DQo+ID4+IGRyb3Agb2Zmc2V0IGluIHlvdXIgcGF0Y2ggb3Ig
dW5pZnkgZXZlcnl0aGluZyBpbnRvICdyZWcnLg0KPiA+Pg0KPiA+DQo+ID4gVGhpcyBpcyBleGFj
dGx5IHdoYXQgSSBwcm9wb3NlZCBpbiB2MyBwYXRjaC4gRG8gSSBtaXN1bmRlcnN0YW5kIHlvdT8N
Cj4gPg0KPiA+IENQMTFYX0xBQkVMKHN3cnN0KTogcmVzZXQtY29udHJvbGxlckAyNjggew0KPiA+
IAljb21wYXRpYmxlID0gIm1hcnZlbGwsYXJtYWRhOGstcmVzZXQiOw0KPiA+IAlyZWcgPSA8MHgy
NjggMHg0PjsNCj4gPiAJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+IH07DQo+IA0KPiBJIGRvbid0
IHNlZSB0aGUgb3RoZXIgZGV2aWNlIGJlaW5nIGZpeGVkIGhlcmUuIEhvdyBkaWQgeW91IHVuaWZ5
IHRoZW0/DQoNClRoaXMgcGF0Y2ggc2VyaWVzIGlzIGFib3V0IHRoZSBwcm9wb3NhbCBvZiBBcm1h
ZGE4SydzIHJlc2V0IGNvbnRyb2xsZXINCmR0LWJpbmRpbmcuIFRoZSBkdC1iaW5kaW5ncyBpc3N1
ZXMgb2YgY2xvY2svR1BJTyBjb250cm9sbGVycyBoYXZlIGJlZW4NCnRoZXJlIGZvciB5ZWFycy4g
SGF2aW5nIHRvIHNheSwgaXQgaXMgbm90IGp1c3QgYSBzaW1wbGUgcGF0Y2ggdG8gZml4IGl0LiBJ
dA0Kd2lsbCByZXF1aXJlIHRvIGNvbnZlcnQgdGhlIGR0LWJpbmRpbmcgZG9jdW1lbnQgaW50byBq
c29uIHNjaGVtYXMgYXMNCndlbGwgYXMgYWRhcHQgdGhlc2UgZHQgY2hhbmdlcyBpbiB0aGUgZHJp
dmVycy4gU28gSSB3b3VsZCBzdWdnZXN0IHRvDQpmaXhpbmcgaXQgaW4gbGF0ZXIgcGF0Y2hlcy4g
SG93IGRvIHlvdSB0aGluayBhYm91dCBpdD8NCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5
c3p0b2YNCg==

