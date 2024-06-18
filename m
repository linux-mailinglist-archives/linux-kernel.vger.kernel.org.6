Return-Path: <linux-kernel+bounces-218561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918C290C1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217CF2821CD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB7C19939D;
	Tue, 18 Jun 2024 02:34:50 +0000 (UTC)
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2127.outbound.protection.outlook.com [40.107.215.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6C41D531;
	Tue, 18 Jun 2024 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718678089; cv=fail; b=RosYuFdXEgMfktdNMxOwURkBhEI2Ngs29GyzRUoqE8ysmkHJHymtjmdubhCYtX2cxXGQtfRIz5CTJSXx/reuBQgm3SyXsaUFgE2Skbjwztc2KwAxwSxzhYPu3AOdhZD9RI2KYudndRNhLRRFr0ExuvJrPHonstOSFq9FxG5eaDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718678089; c=relaxed/simple;
	bh=WAvRAmDauAmNHrs57o1zKsGenN7DzXUHHpYEgMHyX7w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RGi1Evz4NtdFGGdITOcVmYLwaUM9XDVInfCBTQVsrQwRZDTG8AQOq+vzq9FXhRx0etiKNsLRJUhyh1+ffdqRfhlbSwl8RBIn6ZEU31xIrvyG5k2tXrIqIJYYb+TNkw4/XeKi27ju6ttYfDLx+NxqM4FUAIhHV5FZtmEid21a7AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.215.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRQOb4lqE0qNy4mocBa4h3ndjySTb3PF6JIUZ8qN+Vgwvt9A0258LCFrNd9Dv09J/s3xyE0DjsRqv/Zc19bLfQzg0/7YCSl7rgvp8Vdz3wwYfw6jSQvluoIzpFdTnN3PyxNPyfe9EEXAU/5V2XNOKndiDEvlhn/xSlcGWV3SHdBOAQFbb6GZreLJJxyTIzCFgmAGU/Y9XMrMBk/+5WPmJPtkvjjN5Y2sELS5fmTedYbpXXUXKUOm2fuCwk0fWV9u3wuVrs8lQschA/xbYWVDc+JD0dw/aX2Ksy6PTtngXbJnM4Apn5iA6XGg5R24/Ov5/SmxwmZ0Dt11q552W9wc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAvRAmDauAmNHrs57o1zKsGenN7DzXUHHpYEgMHyX7w=;
 b=Iu+TywkbFnHUHx0lH6+w3M4hN1YzqoxExLoPgi2JCe5N7sBlOdyFVqjR4twPBLOnBjQVfnplpko0f3VxS79x3VUkBDNPrWHbuyeZIT/31X2SBrUCLGasuVyVz+L9WLqeqO/3z6uEgwXv2HgE86g63KYRP/oljwM5TbHWDJm+NjRMdStlOF2E7ypZThCcYqaojK+SqpFxST9DT3VdOiAWu0HwEf387yasFSW27MTWVDfywETduaa7RMrQlLtlQv1i5zfUtLPqJQmKuMxEODdo4NCrd9zkoHtsQdaokBxdUx04J8Y92JopP6NhSnu+7ORfh6oOyMkZn1urXypwParC+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by JH0PR03MB7509.apcprd03.prod.outlook.com (2603:1096:990:15::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 02:34:42 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Tue, 18 Jun 2024
 02:34:42 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Alexey Charkov <alchark@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "heiko@sntech.de" <heiko@sntech.de>, Nick Xie
	<nick@khadas.com>, "efectn@protonmail.com" <efectn@protonmail.com>,
	"jagan@edgeble.ai" <jagan@edgeble.ai>, "dsimic@manjaro.org"
	<dsimic@manjaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Thread-Topic: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Thread-Index:
 AQHawIWSGno1qGDO5k+YxfPMD0x/C7HLrc+AgAAGRQWAAArwAIAACnfWgADeKoCAACIxkw==
Date: Tue, 18 Jun 2024 02:34:42 +0000
Message-ID:
 <TYZPR03MB7001309EF52B5EEBA567D24080CE2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-3-jacobe.zang@wesion.com>
 <f147be11-fc35-44c2-88e8-7421fee47ace@letovo.ru>
 <TYZPR03MB70017A6280F060A6F4A1DD9880CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <a25472f5-3e88-408c-a033-5e338dce6340@gmail.com>
 <TYZPR03MB7001732D8E2F0921BA82B7BC80CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
 <hk7rrm3ljqmrgvdgf23ymhpzwcnq6otwezratoj5k5zt3d6pc2@vjmeh74xjkck>
In-Reply-To: <hk7rrm3ljqmrgvdgf23ymhpzwcnq6otwezratoj5k5zt3d6pc2@vjmeh74xjkck>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|JH0PR03MB7509:EE_
x-ms-office365-filtering-correlation-id: 379f7088-a3ea-4f00-3501-08dc8f3f3584
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ORpNjLt1kH5UCLCb2r10wOLHQVEMB3PdGi7csVja0PzGI5ZZL/hh6ehaGS?=
 =?iso-8859-1?Q?ace6tvx1h15gf1CImQeOQjjODIqC+bX5KoxgZPC2pX1FRKxlSuU/if33YD?=
 =?iso-8859-1?Q?OG5Pizc5kwO7trfKMMmMQOsTPjyWJTMWWvCociUT4B9TNOZLrYiNvCmucb?=
 =?iso-8859-1?Q?diTgoDsAI3rSUKyq7OSGbd3OTEJ3otlHXOHKmxdPyHMhqzlO8YjkMY5GIq?=
 =?iso-8859-1?Q?S1hlYaI08HWnjrIvE6E2FcjybXxsFsH8ZanorbQOSCIPkcOwRVkmxJZpDr?=
 =?iso-8859-1?Q?MW1FvVi9S42APktjzEIIulJ4TD6xoPUI+2QG9T0CSf57kSCFCiyGo7kVZZ?=
 =?iso-8859-1?Q?j8Gid6efteULhnaS23GD6S+cJxZYlp9tnlAd9E2eBLIOW1grm4NXuyT6ns?=
 =?iso-8859-1?Q?nYer5hNX15rqtRvPHv27IofmO2CupitbEgUIkmmZS7O+MtALifTdrY6QaX?=
 =?iso-8859-1?Q?hBQCZrQHy6n2IykK6saPFpNZMJMH54syka2atnklbslT5iR3v/BJU3+EKy?=
 =?iso-8859-1?Q?uUlJotcxC11BLCYR+zVsVttfaOp7GYCITQwdAHTiOx7maR++D9FicUtJjZ?=
 =?iso-8859-1?Q?w5EFC1U/82iiX58Qs9dpm7uqHsqe+5IcgJX8xlYxbwIhtUfGMDVAcyobw3?=
 =?iso-8859-1?Q?djHtQa1M4enqTIiG5Y2qxFVrW1HvXqUNKPbo7xflaUqhVT1GnNzSK4cAMq?=
 =?iso-8859-1?Q?PPlvMPAfgMn46WYlds/pRGKW55kTBVDS9vUtbkuuLqwHsTcX4D5f9bAD7N?=
 =?iso-8859-1?Q?aGTbGbPtwDlS6XE0EEetKNuPE7lPOpj8rFVmlJvPdRFYxKUAmJlCvj/Ote?=
 =?iso-8859-1?Q?thknflU9U31CHANdRm9RNR1KEq0DQsnspSQ6NjFB0UhZSxcgPbpVOhHC/V?=
 =?iso-8859-1?Q?ukMb/8DkLrLZOHWDXCscvYMgXprqY3JrZl3Hb9kqAA0rwqhiWnscrE/F6H?=
 =?iso-8859-1?Q?XwC/e2gF35QdPrXBJRQL4TsW9MunrZCoDdB4eP5qWwubM78wUxXFFHsxVq?=
 =?iso-8859-1?Q?i6M+dJD5y6gVxROdghHEHgCr41FedqT5H83egIsWD5c/RehHXrPfG3WIuG?=
 =?iso-8859-1?Q?dy0k4BcL+JrMJWoO+HS6bDqhDmJ9IvFa8njm4KUWltcHbGA/3QeQbZFxVv?=
 =?iso-8859-1?Q?4ABK5k3po6EpVT4F9N0IRmKfEgfkmFbXV7YE9Kh3vBA9Y52hn0pBM/wac5?=
 =?iso-8859-1?Q?XdB3AUGAR5JbvERgitDaiVCeBUQrDILJDU8yf/CeW+ZMzAWLUq5uTz6iGi?=
 =?iso-8859-1?Q?bG8PQ5/cnwQeROEzPrDuKzB3Ld91xb9s+qQyKl0RSzbWXYQjiwkoiXoawP?=
 =?iso-8859-1?Q?gqX7Y2ndc+TL6AMwiOmPJ6q1MuP1GHYZMddNf+IWUZQ/XS9kYYeL7bH3a7?=
 =?iso-8859-1?Q?9CS6w90fycgd716If7kuZS1B4xTmgFuKyga63FXVSZEwkGO9uDYK8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0Tb+YFoK4syLM5nKlXmXXJRM2qd24owKWbtoLE6DG0OwbyAQN8NiWGpe+m?=
 =?iso-8859-1?Q?jEstCjzbo72MR/nvtG3QAO+j6niXcB/q5kf3OCZt6o0qBl1jVUwPVl+YDi?=
 =?iso-8859-1?Q?jbR8IUznzfCZH+ivs6k3+0cgMWTW88xX6oTB+34f8ANykf3eX3PfHrDvm9?=
 =?iso-8859-1?Q?GeMObNmlIfOSburRi48dLiF1DEsgREZs/hKmsLkhi/TomuRwcHooxrWjAS?=
 =?iso-8859-1?Q?Eec90NiWTzQWxeRtrAbCbJkrY64qcsXCwi5enK3ddhKg+F++Aju7PA//1m?=
 =?iso-8859-1?Q?KaDQeNWpJXkR70muojb2xDQTWfzAvQX8kV3bwxW7dWvIUVDdJlQgNyakNE?=
 =?iso-8859-1?Q?rITA4Qi7k2yfyGrDdWASiIor7aCEFwKRr2fvF9ZOFBfUeE3jo564dWUIb7?=
 =?iso-8859-1?Q?TmBr5Gkbjb0vbQKUX+Ldu9wrIrhEEF8yDrZyCZ8AZfrGTJq5Fln0fPaAtS?=
 =?iso-8859-1?Q?uz8EthoOyAAja2P5npVlTzAhvY4QeunAxQsUjGz2ywVcMNnZFMzI+sL/Vq?=
 =?iso-8859-1?Q?gl5qJbKQ8MjXt7TGapz+l6PLdVQ5v343G/VlIQwKqj5VfG2Gikzwj1HGaV?=
 =?iso-8859-1?Q?DenViN02qT9S10+d5/AhfyHmK7zmHcO7h/qXq4pjepldX6olHElTT9egeU?=
 =?iso-8859-1?Q?asnExni3XcnxLEaKGYLxNEzB6xDcRahiX6WRNutrX0zxvvTfXdqsczBrXK?=
 =?iso-8859-1?Q?LaB1OQ0yi9m4iXzcwNUaMYOkZ6HEOJzS6hnxbb2clcDljFfsqZIvLkTALq?=
 =?iso-8859-1?Q?3ufFxLtDox3Zi9u+J7pOZAenq0jqxGCEsgI6Htg9Dy7tykpN7bVl2II+Uc?=
 =?iso-8859-1?Q?0c1B85NBydal4phaFuv/z7MbZafrmFsuOZ6XdBUuS1bbFqnmoNcT5WNopa?=
 =?iso-8859-1?Q?tVSKLFsoWAGbXeHnNmohqQ4N2t3AY7HzDZqfgLhGQepdswqY3UhCOSsAmD?=
 =?iso-8859-1?Q?xxVW6Y6Y227+S+6hyHg5tAKtJt9vY7PRQHH5Yh0u+tBmM9J1v7CH0k6wAT?=
 =?iso-8859-1?Q?XSafqZswE/WWclsI2SCWSvLRLBXit4ITx8pAcr+6QCTfqVDz3u3Gk1hAau?=
 =?iso-8859-1?Q?yA4sIbw9hQDRSbo/mu+idGGHRTLiigrYrCdieKkqp3tCE3QjjvTRkeRun+?=
 =?iso-8859-1?Q?Shw+p9Ru/U4PDqojM3zIHnVNxwVqK5PJIKzyo88T7HXDDq69J9fSUxPWGa?=
 =?iso-8859-1?Q?jxyc+y0pExkZvRWENHfHLnVo11pXJ7xCJMZY/8EI/X2jqvHGxyebtyTzug?=
 =?iso-8859-1?Q?cbMIU9dVwRTIHBx2cbVsTr3rAW/C0LfEm5QBMzgF+U8gz5iavtUJ/Jiuvm?=
 =?iso-8859-1?Q?vqO0te4xO1lElEYTwnNsOHYejFFqYIYme4M0a6Uiec31tKK4APm35hjAwZ?=
 =?iso-8859-1?Q?P96EeSf3DetDPudIA9tZLq5fjFg562ZYt/At6P989B7aORGDWF2ZIVSzM+?=
 =?iso-8859-1?Q?9rSOtYOkolodWtZ51Jm6Pxc9rr4By6f0zTmFEjxRsl3FBcUC0rZAslWR99?=
 =?iso-8859-1?Q?gw86zphwJKSFmV62Ds2Z1CN9FrCvjXT7PzS3EotctwSLrWJ09v2yC1FZsJ?=
 =?iso-8859-1?Q?0vO1Bk8sAALSrrethjzdOU31SVKx+kUnn666k6/sRqYMld0v9PJrE8Mbsj?=
 =?iso-8859-1?Q?Ymi8PFSubdeFQB2Co02x2Qvh+5pkn+pcYE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 379f7088-a3ea-4f00-3501-08dc8f3f3584
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 02:34:42.2905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 76Q4r1l+qVTAfm14emUPm7lxdvSRdo8dwOgMWBYTEaHsasT2zc9BxBjqJeMWY/A8/tlyp4o9syGrY84Q9fgnuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7509

Hi Sebastian,=0A=
=0A=
> Does it work with the RTC clock disabled? Otherwise this also needs=0A=
> the pwrseq work I mentioned in the WLAN patch.=0A=
=0A=
After I disabled the RTC clock, bluetooth stopped working. I also check the=
 Amlogic chip, some SOCs have the pwrseq defined in DT, maybe rk3588 need t=
o add it as well.=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

