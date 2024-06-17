Return-Path: <linux-kernel+bounces-217170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9652490AC66
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224B91F252F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C331940B3;
	Mon, 17 Jun 2024 10:58:03 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2097.outbound.protection.outlook.com [40.107.255.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817E65025E;
	Mon, 17 Jun 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621883; cv=fail; b=jPu95TjBETmfQ+QiYicz7AwLG5QoDG5oo6h4MqucWDZztjKakAu0vD6ZL6w6/YXR36gXW3u6Z3z9/kGSJ/xjhNLFp7l0s5p/TnSUEiQFnW1bocNeILoN5U4TyB5/EY9/IpDS8VGlYxP7nINeMshakQdiso4Nl5CyHzn0esBlEeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621883; c=relaxed/simple;
	bh=Ldju3zWUjKJIF8hfU1WmFwYsmessGQgTNVE4FpjVv8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UMKC2p1IWPpfMCp5hK75g5dt80oQw4hUj3yegTlhC4H7lfrS9pS+RjCzhg4o/t4WcnxXq9jzRQDze0Cp5QR/EInqC/Nd3JrBdCnCfluZwtxyGFgTNPIduNK2hVP/zZ7gNzJJxsCTXsrzvNFaApSBKhk9UwfrWEgoHZ1LZIWaUQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.255.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epbAqutzuWemJEtJ8qPn/MiIa3mkq1BxPvjVhI2uwbM4irC2mAr1doyEz1pmJ/3MkrST8K94jl1HrC542f4ghtl7ByQI69948QoQ5/M5tRurBwSZaorBvqZLhG6+BF34AwyVKKU4F6j2z3q6RrlvVfKpAAFRc1VCo6xPtMr936bv1443IiXboMS7QmN0fvOktrel/h8R9HdmzBXE/gpZZPDZP8V6PTdPRCO4JSjVQJb3DHP/jR7t/DQJ6mKHklL+4fypQt55nk6l2J32quztZaOQbFcntaZxlRLbjEA9dhoWRWzVl+WtmRdNU2pgwiM/q0YmSh05j2au3L1Fk3MOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ldju3zWUjKJIF8hfU1WmFwYsmessGQgTNVE4FpjVv8A=;
 b=gB1dRYFVweMW6GPzkopaU+a+9s+ZspyeZiQ0ZjtiwMZGpQ6RcI1/feTO7G14Z9fn6b76Hi72ZGVuYi8fBMMEc8Xij7Nrk2So3Jgf5x9RT5Bcwr0y5bdyBM3ucJ3P64o2d93azEdF5h0ItcIOu5c3Ew+no4TTDa4G0C6zEYZSFlgw7CpNQEoootOLfBPq5PjawXAdEboqAmbK6Fr8Ib9GwYPMy2B51dbd3Hr0jXCGDv41LeOpm1cLS9lJ2xv9gQe3V7MtITVuewvBa7TURiiroi9MByk7EODcEYvgDAnAtM/1Cf/mTazfaQoMaoY0nAi3z1R/OwhSrrLpUkn9mQuCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB8182.apcprd03.prod.outlook.com (2603:1096:101:192::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 10:57:57 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 10:57:56 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Alexey Charkov <alchark@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>
CC: Nick Xie <nick@khadas.com>, "efectn@protonmail.com"
	<efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
Thread-Topic: [PATCH v2 4/5] arm64: dts: rockchip: Add AP6275P wireless
 support to Khadas Edge 2
Thread-Index: AQHawIWUKwv4UGj980e571PV7A8XzbHLtPgAgAAQ92E=
Date: Mon, 17 Jun 2024 10:57:56 +0000
Message-ID:
 <TYZPR03MB70012C66B789B09195FCD92580CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-5-jacobe.zang@wesion.com>
 <feeb8dcd-661f-415e-be08-afe175d0102e@gmail.com>
In-Reply-To: <feeb8dcd-661f-415e-be08-afe175d0102e@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB8182:EE_
x-ms-office365-filtering-correlation-id: b7c216ad-792a-4bd3-a41d-08dc8ebc5864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ZtEZRl0iGBSZJjMQKWcL3xGQ0j5LGq+9Y2zeq8yNUrYr/m4liNV8gOBuHU?=
 =?iso-8859-1?Q?9gEDQKgI9nNwtOs5OvX+nizzu8iQK7xNYQBeL5sOOg3Y8X114bSpN4prVI?=
 =?iso-8859-1?Q?7ibCU3Q1GDuj3guJ1mzN9l8Y7U6K04m9knHZEkio3wOvgwb4u/NxnBUjve?=
 =?iso-8859-1?Q?C/x1YJ6GMfmXtmFKUiv3EWbGpMEg71Dup50ZmlzHiO1Uhvk3iIq0GZkyGO?=
 =?iso-8859-1?Q?bDbjgRNau5BGFgfFav2sHOWb9qMS4Zg+lFl/Ed1bAPDTJUsM8OFNX4EJsD?=
 =?iso-8859-1?Q?MrbXXVPzgII9m1f5cJ4ZC5y5fJPzoZQ5cn279Du/I7LXdeTVPtSsq/9nPL?=
 =?iso-8859-1?Q?q4OKR8m0ve3Ql1RIkjGlAAhuIbZXJaIYqdGf4j8KZ0mc0V1CfNeZtcLhqB?=
 =?iso-8859-1?Q?1zKZnEYbzZ7+6ZlZP92BlyEduf4QTYDiM6JCHvWeNnJhJdc+uH0qSp2rOo?=
 =?iso-8859-1?Q?G5lXwSBvXE4mJV2oWXCz0fHxxWhVMlEi6M0nXXKCxxhkuCGMpEh0j0CgvH?=
 =?iso-8859-1?Q?PfLZgM5Z6fonY/hXXFV982UlwaoZaYGzalJ0ddJZC9jLuxPiedX671H7Nu?=
 =?iso-8859-1?Q?WnDyFoIqlz8XW2WBLJKmqLUcObmRq5PLhHQe66cFkVxcLqNpbDS0vtOtFm?=
 =?iso-8859-1?Q?f87G4zRYbW8mQqgimV5/nuIdtmW89TZSbwsui8PeVLH3Cow/r9P/dR110j?=
 =?iso-8859-1?Q?sm9ZwhcRxlqPPlAYx2UgLjsvejoN8HzHQexm7dCgQBWJKxXYGZIPR3hMza?=
 =?iso-8859-1?Q?p/dKJeBKDzTog9ou2y8Ues8FfbfqtJ1tYD2SVw8T5085TsLbw9wUzXNmgN?=
 =?iso-8859-1?Q?a9bf7NJCrgpmSgEzpW668ygFGBss7xr1HYq4VyneQ9j31nDKOz+mhBP/Bi?=
 =?iso-8859-1?Q?6oO7h/23Ae/nf0FzpiF+yI5scQ6f415oojjDswEkNrPmFGp+g5sE3k7d8F?=
 =?iso-8859-1?Q?hon/yQYpuJS20E3hTpJ898/FcMqN2ZZEX2EQMcwcFjSN0PQMWQPH+ng+ic?=
 =?iso-8859-1?Q?u3YA1cQhPsiZXOhpkh/yy36psAveNUj7hE/BXsFVI1cPX/JflHL0/cy0yU?=
 =?iso-8859-1?Q?lqVL4POtWqIiMer9Jc5LNEtNaTmd2xpnULYk7qlKt33KXZTa2nBZ0ywREK?=
 =?iso-8859-1?Q?CL3VTUYgGdJD6ZkODpGYR1NmveIVVWzf+SoO+9IuDLBOWc4IYflNWUPGdy?=
 =?iso-8859-1?Q?Rjmqs6af7mpN3R841d2QLyov0Jhsdm/27zcjSVs382s9hBdNNdz6Ov2FWh?=
 =?iso-8859-1?Q?Yz9YgcFCXVrP2TWs/6JwED92FlAWMm3aOo2/SvUfbUVbXACDSAXSOi6068?=
 =?iso-8859-1?Q?quaMnE7UnbJtahVaMD+oxpLQ97FRTEv9NHAS6t+9vZ7z4GfSRqg62TFxuL?=
 =?iso-8859-1?Q?r2dyu/jQ7VtRhk1OU4ChujXFB7OWRxo4ZYc+zNG2bJa2mDuunkV1A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?RVhU6ZxVafPZbBCubZdWtx7JmdLxjOfv7XZcleHg2bc1EVNzsPlqoAT6YC?=
 =?iso-8859-1?Q?MLqCwiiKeR2h2A+WK2kxykHRitkSlLOgzhv9RlpVI76aHdmxgb5aKndGb2?=
 =?iso-8859-1?Q?rbYwsGSNk2TRj6JhsIjqNb4CTTlxJ9A1TYKBCcWI1mEhi+4fzNzeb/sRCy?=
 =?iso-8859-1?Q?f7ok+F8yrcXCFS+yTXNs+H4ABubwRGoBhSKHpp8j8pVAFzDE9by/ggiJkw?=
 =?iso-8859-1?Q?BRQnyQhS+MLFnbq5AUrsae4O9I3UYqRv9V3xOCuGcE0FVbVxfRrJ0IlWwo?=
 =?iso-8859-1?Q?cd3sFUKy0lHC5exSfMp1h+rBOJWBBImPqQXmpuLSYWbngJeTzYzVpTyWla?=
 =?iso-8859-1?Q?bUk/QMnQqDmRUNnoVqjbeVmjCp3UhzFZF/vU1neDWvuPvLWh2Qg3g929Ch?=
 =?iso-8859-1?Q?yxgH4dgfzoG2+z+7oUKlu00aJ1g+JYo+4o11s+tWxZ2JAUt54L0UP+05aa?=
 =?iso-8859-1?Q?6zOmZEH7DxC2QEFVUb4rIzXPDap1WlErNpCOlaBxzO3JFIji0GcR3LZ6bD?=
 =?iso-8859-1?Q?soQ3WLp9+RygamnI7aQbzKmy/CBYJPNxm4S7vdAIUT1lsrsoeaj9OKyhly?=
 =?iso-8859-1?Q?Ke5HlSQTW19Pdpe+WtSJSKz3JZsOXE4bPGy9AV3j8NQHj3Jd/YnP1wFs9k?=
 =?iso-8859-1?Q?m05Xe2tL/SondJnbVaXl8WQ5SgF9ab1EWwqQQ4AIjOy2hKd1ojO1COKDrT?=
 =?iso-8859-1?Q?pByW7Rg62H8ZAyR8ILzgt670OaoQ/W+IbRdb4b/Ojly+e84+JFUJRXf+O4?=
 =?iso-8859-1?Q?jKYKe8IxvQcTxyvC2Hfwtlt4FLRzPmoFgGB+zglHggKSFDz7n08GUyzcP2?=
 =?iso-8859-1?Q?RSBbfhIXeZg7G7LYs5b56+Q1OuOaleDxs7OCIoLn8kwLbgn6GO/BnCtttq?=
 =?iso-8859-1?Q?650YRnRJm+vW88+TNei2emiULutd6UYKbT5wrek+mBAs9YFm75GxAMFuyG?=
 =?iso-8859-1?Q?Dd0GgUedlNEOB7LQhkIBT1YKH4+1p7+Fa9NGuXxmp+dPb+HJX55mHmkUuf?=
 =?iso-8859-1?Q?T2Fm0Z8SVVt1UvAtb1sYd4H/3cAHX0gYzFCPZtgmyJuf2jTuCplR7TvPdt?=
 =?iso-8859-1?Q?Fr+6MOanYHtosQiQGz2h45QIGuCWAdh8kiiyTmRwvkPxS0qcQsCQTYzh2N?=
 =?iso-8859-1?Q?uAQ/KReHcj7yZGx0gY512HdTqSz1JghYcVeRoJVDqs12nOD5204ZSsA3bE?=
 =?iso-8859-1?Q?JtBwwt7OVbPL5Hcoby3W5PQb1/4XZsEPHcF7N9g14seQ/ymHQgu9QW9eWz?=
 =?iso-8859-1?Q?1yIDBwbS4yNTlvJb6tc8oxBnm+FNKioJvD92PzHIe4t7GJyru+k6NF6EZD?=
 =?iso-8859-1?Q?kNf/0pNZwVaOqkL0nnSSnQdYWMadz0Amy3K9qtOo9VzgtFtgwXbOCJjl4G?=
 =?iso-8859-1?Q?QOZRT0GXP42O+rxosYAPmdWtXIdwLl3uK2fW4TofWhHfXzbTwRg7y3Qdvp?=
 =?iso-8859-1?Q?bl/ZnHe+Wc54cV2ZobGf2D+OE7K5aJLS5Ab7ZpJIKr5oM6zc3rGPH4fdRD?=
 =?iso-8859-1?Q?OY5QfCcrjhHsl+ne0ZB4M4us4OVVK6ETNkQpnRiYlf3qY4aQcJGQKBr/QZ?=
 =?iso-8859-1?Q?EkY8l1YxCZWV6kBCQXowGq5sw9qSzmrvVbJN4kxUExLWQzz8Ozyb74HA9X?=
 =?iso-8859-1?Q?nNrjJdh8effBqWpznlk8bjntBWyC+dvdGB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wesion.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7001.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c216ad-792a-4bd3-a41d-08dc8ebc5864
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 10:57:56.7512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOqyZDLKpD6XSEpHTFIy3f5KWhPOkw1ug0d6GoxsmjAr/ugjj7ZkxnteHyUVVFHSF931eD84TSiHlaxLMbLyJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8182

>I'm also wondering why would adding a DT node for a PCI device be needed=
=0A=
>in the first place, given that PCI supports device discovery?=0A=
=0A=
In fact, I learn that PCIe bus devices do not need compatible to probe just=
 now... Before sending this patch, I committed the code that added "pci14e4=
,449d" to vendor-prefix.yaml and net/wireless/brcm,brcm4329-fmac.yaml. Now =
I know the reason why my addition was rejected. By the way, except for the =
compatible binding, is there any other binding that I should remove??=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=0A=

