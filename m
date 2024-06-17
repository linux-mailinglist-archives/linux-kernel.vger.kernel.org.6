Return-Path: <linux-kernel+bounces-217070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 649F890AA38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2A11F23B04
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442F195386;
	Mon, 17 Jun 2024 09:41:40 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2098.outbound.protection.outlook.com [40.107.215.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62F194082;
	Mon, 17 Jun 2024 09:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617299; cv=fail; b=rLMjCazvk3h1uBQAprNK8PdzI/CTAs66A4tfcULH2QvghPsWQ7sMyeNZ07Gf1/PLAjSrMgLMK3UXN8/YfxGBrb6Zn5vxUfZ34xlwszKKstTuIfab/MJ7IwQ7x6foo1Hr0cmpCnvm8aG73H/BibAK8HZPg4H1D6R7krFN8iyRBBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617299; c=relaxed/simple;
	bh=YQdxxFoZlj/UK1ogh0ofh/iwMRxgHrbfktyh+wsmvy0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BOLIHIpLkEA74X5wmI8yUPCHPRafPl+JD3zGAa3wMKzkDGmHw3p00BOqeGWFItzMySferTxheXrRwzK+0QRDVAabc8q8tcV2aQKZ8VNhFiSUdMF90leoR5cwWmRMJHYfdWZ9uVuTYZZMaZlSSvB+btrv3oz08It+sQAm2VplY/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDQBCuJ+TGDGYH23RuC9HyBxmIqJqi0dKQsCyuyAazUdnRQ7/yQmb8s8Xp6gjtPSD9doiB2uUJ4cdOf6F5rkip2egFYDuCTL6LhHk1hQQjg5221rJ5OcvWbu4wVmuTytZt1lG/phFzzKDlStmX2wGhii++B+tmgOLcyjqU5muT/si/qvhcUbt/jpt9I6tq11iw2UZFnyVuaFyIndg2sf015QRVuy5fYv/35qpiVCRrnyHPZPa72sP9kXTBXU74BFkX+rWl6NamZXTmz5ZVWQAnZAbbGBCe6sDHlTbDf6h1w2I7uZDwXmabfOCgc6RoBVt34tdO3glUeYLNucDvk1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQdxxFoZlj/UK1ogh0ofh/iwMRxgHrbfktyh+wsmvy0=;
 b=hOBP77F0w0TbiSnK+48wjKPg7OC6Rwz4eHhhGv2mh3OoI9nI1Xi1iTp7uxp25JsyTUBM3MN4Y0Q48gebdcOKYVsKOfHn0tufAqy98oI/LQRSgu+5HQVwYuiZCjWkhCNy7Ch1Ftf1jRjup8ruPBALQZ0W1vrKV8OFr+jNDKhFBhP3bgztUDznWUF5pHvdRFNJ3nicPG9mtJ69oqujJT5F4N5u576S727rqnUZ8MJ74aFEFPV7hwrrUOy5zebknrtDGj8GyKEgbBd5cmaHp8okg91+cyy3HbzaB12d8jMf0OyokLxOQCDcvESiyIx98qzR9Uiz5GFXYgqpeZSRjRc3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEZPR03MB7514.apcprd03.prod.outlook.com (2603:1096:101:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 09:41:31 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 09:41:31 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Alexey Charkov <alchark@gmail.com>, =?iso-8859-1?Q?Heiko_St=FCbner?=
	<heiko@sntech.de>, "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Nick Xie <nick@khadas.com>, "efectn@protonmail.com"
	<efectn@protonmail.com>, "jagan@edgeble.ai" <jagan@edgeble.ai>,
	"dsimic@manjaro.org" <dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64: dts: rockchip: Add cpufreq support to
 Khadas Edge2
Thread-Topic: [PATCH v2 5/5] arm64: dts: rockchip: Add cpufreq support to
 Khadas Edge2
Thread-Index: AQHawIWVd2AAwjVADkm4GJAzosDyrrHLoOmAgAAKBwCAAAiXdg==
Date: Mon, 17 Jun 2024 09:41:31 +0000
Message-ID:
 <TYZPR03MB7001FD32763647CF27804EF280CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-6-jacobe.zang@wesion.com> <5475817.tWeucmBOSa@diego>
 <8ae179e6-3aee-415b-9dc4-298e162fbcad@gmail.com>
In-Reply-To: <8ae179e6-3aee-415b-9dc4-298e162fbcad@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEZPR03MB7514:EE_
x-ms-office365-filtering-correlation-id: 4e4c2baa-3a7c-4852-6751-08dc8eb1ab36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?328b7A76RfqEvybeSsaQyWkE46r/+h6Mzd7nuRw+UZSBNkk49bfNhbMNxY?=
 =?iso-8859-1?Q?isaFI/UsaHnFIM9pS7EhuR+px6CdVpQmCk9kziJ5YDb6WQS6zrGW575Sw+?=
 =?iso-8859-1?Q?LkkE3pE+i6A7OYb1XSvxiPSJRsbRuQnheYNPmMWpMRvieuOtXvzaHKni3I?=
 =?iso-8859-1?Q?ly38bfxlmRUrKY/4k+vLDY8H3UtFTeDiwXJx/pzPNza8HdLA/Qn0NoCgMO?=
 =?iso-8859-1?Q?oJFeVnG1UL90koxITfgPcz78CkWqLeidyXzA9n/BPW4vguFj1OfQFbJ6u8?=
 =?iso-8859-1?Q?zJavr6jAV1p3T3GZTsRZu+7pVkLfrAXYH3sA4Lkx6joJTUJElv3T52UoTS?=
 =?iso-8859-1?Q?6G8UScQVC/dJ2ELpH7mPO3rfQRrKEF1TY/uTETK+Uw0zl2CaAKFLvoTvPd?=
 =?iso-8859-1?Q?emBgk9lJl31MkMN0LWv9K+YpC/vM+TT1OTksy+INuCEslYuumAwv8BeCX/?=
 =?iso-8859-1?Q?PFCCvMvi3CfuoW1QmQfLItkGXCOAU3cWrVZvPyPs77a8F4Azbz8qQM3dE8?=
 =?iso-8859-1?Q?fAjPByx4zDCaMkrdjhClXW9Rsk+JenlznI8E+3eEiQZv6aey4buYyjockF?=
 =?iso-8859-1?Q?OmQh4L52UMOf1rLGB5CshNgUgza0Tqs1ioAlFColhm3ZPse1QwNOqSCXUC?=
 =?iso-8859-1?Q?KAorkXvj2M+GONtxxk7LnBixJKlphgtIN69gviro86bwBxvHlQNxDQQtvH?=
 =?iso-8859-1?Q?6U7NbBIHnOFsqJ06T04qOp93BbfEvG9J9Kqzfng1GhUmi1q+YtYJ0B8wWY?=
 =?iso-8859-1?Q?JSvdX2dEOmjUrHYevBW9Ffay5asSSwhwY8bIN8B9P1HtwwIQIkM4ZdIwZC?=
 =?iso-8859-1?Q?3zS4Dztw8UeG+1HySWkbh/j3NuEIZcGAzpkoaKFg705MP7qTX2OjUozTdC?=
 =?iso-8859-1?Q?DZwqbmBU1h5ECZDFRBxnaTTc8f8xYfuL/Pgb/jVLprFmXTnj5iso2DVaHv?=
 =?iso-8859-1?Q?LMwJIdZhFS310WTVMvTCe3Zqd3n00wbW7GH45UiwbZJPShqe0uGcdZ/iky?=
 =?iso-8859-1?Q?tkMqsFTwyDVlYRGig1w0+iGwGkh1aTUZul7O62a0SR2VeGDZt0YbqyCWhB?=
 =?iso-8859-1?Q?NCqJNVTs7CnJx9iYVqJ0cCKJVNB0vgzI3N5tQwNlFkff8VJIiAwkc508Kj?=
 =?iso-8859-1?Q?zx1mPR1+5VRxzhasF+V7UJmUKH2NUDLi+quGmycVUqSDqjrlZMtkuwVJjP?=
 =?iso-8859-1?Q?ogkKsTJ64ifnQ2E1sgXgLcUInFlBPmbj/M//Ts14jnDBN2KPm43Ky5Mo2n?=
 =?iso-8859-1?Q?rZthvdNJoVJvNvutFe1nCvHHucfYFhVBbaOFc8E+/c/9aHLeOddeLjGQQc?=
 =?iso-8859-1?Q?98FLM3NlnI9Sy8Sn27JczC8I/3iMJVfRBLhdxgkHvHkVuPzVMcFAu4wNLx?=
 =?iso-8859-1?Q?LHUjxoenqDNAfo8sp10KFzAIkQeOH3FBxGTs5bhts/krrT9JyEXx4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ujbejTVZDImlVo+B16JvSNVnHc+pwK+csBCRXIQVz32Vblnrn9pinl7YZR?=
 =?iso-8859-1?Q?JoM6w4cDa6VXxQaY7IoZCHy+vQouQdEBb1u0I+k2vf44CqYYavkHmUiqTC?=
 =?iso-8859-1?Q?AcPNbM5/MI3sX4CsC1Srz1KWjDbT5gtwZmQnWkugTxewvdw0etLHMSs54u?=
 =?iso-8859-1?Q?goU48bxV+kWTSwHW212KEJj1vkpUaTlX8TEkQ8DiVznvKNmvvxBEymTQBu?=
 =?iso-8859-1?Q?FRgrt5BXkD4XxomGHMmQhF2DbLjVG2IYLSQmsVikeNMDxk0G7ekQdh9Rn5?=
 =?iso-8859-1?Q?rBBY8pXNIXhc4jqoC0ikOcW3smxX2RXO5Ni1+PxvCA389Jhw3HTvO9lkFh?=
 =?iso-8859-1?Q?BtJBhV0C6B7HFRoCJCAo6VF7nMF6SjJfvldQo4GbRJjS6GjE/kuwhr8ty+?=
 =?iso-8859-1?Q?wMpIka3KE4Bk0wwARMtFdzjCkc6Fi7FSRHFZEY7B23YgqrzcQDK8cEqsr3?=
 =?iso-8859-1?Q?E3cIS+TMB/AVMBcY1d9dirjHgfZB/4W1yXQ1YEeoFxBn90+auheJfx6g2I?=
 =?iso-8859-1?Q?nB7CaFWe+voYVFmlO2lYJQkc40UGIWrP7uVZsuikZuomOgyUYh39+Mbqx0?=
 =?iso-8859-1?Q?Z7Sihc7n7b/tP/xjX9uV6XpO+89nfTDklLH5lSR0WSgZxC44H0N4+rMi/a?=
 =?iso-8859-1?Q?KFojk+rCH5nGuO+k/i1CIjjP1zjWvYfu6yLct4EFz8FGpseF8uI7UFtlol?=
 =?iso-8859-1?Q?Rv/QaVGK5WtceoOPG7YkpAxx+RJNOclBrD/yaoDCSRxcUL/qh+Z8xv43zt?=
 =?iso-8859-1?Q?QESX0VjW0xw3n9Uh9F+L3ITAD5wyE6O8jVXtfXRvEXh6dqf78thlF20eEk?=
 =?iso-8859-1?Q?NEAJ0VjZggEKXbbBnJce8aAFlwUv2HF5tk8lfC7PbsxJY+321b2KEGCqEN?=
 =?iso-8859-1?Q?Qmi/2FOJddst6fTpTU+6yzF00s/v+eV7s3nr1O89JoccTs/4OdQRdXskkV?=
 =?iso-8859-1?Q?CTHxsId6CCyro2WMyFeHVh0E62TutB/B/EgiZYKNzFZhsIxjYL45U7Wacq?=
 =?iso-8859-1?Q?d8K9z6lu5BZkDi0Aho39PAwME0QIwOjFW3ztBg0D0VDJFg+ci10Gd7+bnf?=
 =?iso-8859-1?Q?NTUFjFrX0vwRHOQoygM36oLeJygbTM/eKyMF0B6mPBUAoK/7kZYnawokGE?=
 =?iso-8859-1?Q?fgvBx7+xK+Kj+J1IE5thDmuKqNcGzHAxVlKBJiSXeCP2VKMthQ+h0ONgcw?=
 =?iso-8859-1?Q?bWLuD1lkaHw+Ce52pXx/LWjv6FGG+el85X3Mh54mCN0553IKyjy5i2fnV0?=
 =?iso-8859-1?Q?KSIrXqWxsF4v/pr9sZhyIp6h0/qyTsMwyJCZy8bRfeKgguQ7oX3od6EGJN?=
 =?iso-8859-1?Q?pCLojCH5qrzk4ogQdU+hHyOXK0K5F4F7puqrw0m7MuRu+gtOzLaDkdcMB3?=
 =?iso-8859-1?Q?f9hzSuJPGSLnk9KJaWmBITFyzt2lGiFlCj2eA9jnao16nEm6JyHshS32de?=
 =?iso-8859-1?Q?t0AvJfzHOIHMbwgGsKNHjWeLJ3b8WGcx30I4a/DsUdeHF/fvXoYYjR9K0U?=
 =?iso-8859-1?Q?JW4TiU2E+6ojOxZ4QxwRFxEDkk1Vo3tDF9ZnUGwhkmxwC5L245aOoUhGcX?=
 =?iso-8859-1?Q?g6nAWnuG375MKU9Evj7pm1JQrrrvvVzojzCE0OOHXYOM2M6gSBI52a3+NK?=
 =?iso-8859-1?Q?mOBO34i3ImzOQScloUGJAZg0Q0uR9B5stn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4c2baa-3a7c-4852-6751-08dc8eb1ab36
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 09:41:31.2290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZ5RgBYa8/ulhjSDVlQmR9ps/vFIw/zAOPFKTIUXsL/+02LYhYReCpuOD1twLCvKD/eoZOUMXs/Nl6uiSPKvWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7514

Thanks Heiko and Alexey, I will delete this patch in next version.=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

