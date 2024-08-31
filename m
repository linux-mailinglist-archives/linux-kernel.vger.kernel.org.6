Return-Path: <linux-kernel+bounces-309848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3928796710B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04B12840E9
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 11:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF917C224;
	Sat, 31 Aug 2024 11:09:04 +0000 (UTC)
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2101.outbound.protection.outlook.com [40.107.222.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F74174EE4;
	Sat, 31 Aug 2024 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725102543; cv=fail; b=APjIm22rvCu8fyAmHldwAZV80VnC9lswD2kM380SY7UAOsFlDrlW0YYta7oERJmgaf1tJCq1IocEiLWXZv541LLN4N/x64S2xt1t3kFPE/BeJTUrkreebp6MOzNIzWzARHtaI36rWMI32kXaYcQH89L3zAcsmDLd2h4ah+9XjS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725102543; c=relaxed/simple;
	bh=kK9dyAJ49gYAiYd6nUtlG3QL0iQxirHfcRO4B1c1+ns=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DZWRrnCRuNHIqQvkby4US3cYpiMai5pQZHh6Ed/z/9QPJKR+l4/5+hHW7dqy/sFHPjUH2NDykMSHdknp+etIa2sQR6WemEVALFep9RS84b1HAEoBrP+WXUKGJ20ibiYfKDnlseY42OxK0Weu8EeC0mMEHatPR4ThJyHitQL2PIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi3VhqmuJtIrh9USkLlW+mOyNhOBoLQKkibxr7O6WY5hpZG5e7xmjD1o/AW0+dSpz3JaFvtgsnl61Ij4u5RwQQBEPv3hOQwyuyuwlr1sqz++AH/9bBvmMZIZk3wShuJiO+t3ww+MeBvCHOdzsulh1rzl8DNUXgXBoRs2ja4Gb7Zb1bNc1Z83vhzTr/t/Z5yPypJaDxCHeo3SDaex0N27rub63iJ4rwdH/FkjeSORWthrh1rR1G6iW2AJVZ3kU1dmEFsrMFVY0ols72b+QlVg4ZQFa8sbf5mesCjf48UAbO0+yaBUNBZtlO0aP347hlo9JONrdtn+ukR7TTmeRA2yUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoN+BLvRP/bTbiXdM8huGUIKPjulN1zEav4QN1asfbc=;
 b=GQFEbDJXYHnqoRgyafn0vOxOxp2y7jXzgvastsOxgOa3PZb9JBOwcmRb5vL4WCPgtBXsxp/Eb7OPF26OHVg9J0D5Hqp0kwpRcwPIhhAc3hrbwadBlKyyNRKnEZBFARjxZoSeU8rzo9jT7PT7hq1aHGv/68nUqfokry500+luNsScdY0q7/adeYy1BWpLjriVOi/K4q4fdigDuOpa9nMCIJC6Aa8jtiVNzib/U7n0vXV+wWF/gIm3nZBeOhZl0oqwv3yaa+kwZqmfmp0xFHsGldnrECMEvHREaV5g4H3FWnkgG6IeaAdbr46Z5ZVahypDmlC367pMYqBpoSAcQ9w1sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by PN2P287MB1765.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.21; Sat, 31 Aug
 2024 11:08:59 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.019; Sat, 31 Aug 2024
 11:08:59 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: shawnguo@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	festevam@gmail.com
Cc: Tarang Raval <tarang.raval@siliconsignals.io>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Parthiban Nallathambi <parthiban@linumiz.com>,
	Josua Mayer <josua@solid-run.com>,
	Yannic Moog <y.moog@phytec.de>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] Add support for Variscite Symphony board and VAR-SOM-MX8MP SoM 
Date: Sat, 31 Aug 2024 16:37:38 +0530
Message-Id: <20240831110743.14280-1-tarang.raval@siliconsignals.io>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::18) To PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:199::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3P287MB1829:EE_|PN2P287MB1765:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe54af3-0c0b-4c22-5b9d-08dcc9ad4ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WolT4y9knVfPuwPDdrTi9xSFsVGZc1xhJ/7XEEFzVLTWi/JRkELgQbpYK1Qr?=
 =?us-ascii?Q?2SjSjvOANBBHbnTRwvEKlvAzWMldlyrUKFOvDu8msQRLoCvNQvZ8gSU6RPrF?=
 =?us-ascii?Q?BmNdT5jbySjipWXzCSnUxBYBBPc5xww0XeVdMWJ/Yy44x6lWk630immX8rXT?=
 =?us-ascii?Q?gSCqFt4mnW0XoUQsyIhg5P+Fkalou2onqXKwtd2tQ3WiPyteALFoiWi3RJY6?=
 =?us-ascii?Q?/pIHm1XhXpkMxL5wZUaNeMNyZzDjxtk3aCZSxeSpcfrA5SnUkkmTbVrktt5K?=
 =?us-ascii?Q?K5s/fO39vXAhiB3jCQ1NlNFrvfOJhme5r/UOiiIeoCaFcIxj/y+Qjt3Fuhhw?=
 =?us-ascii?Q?Y0/AVbYDI7L4bs4AoSoUC+JHUFZq9EDmIcSb/FpcclCGW0f5eXaMOqKaN0kI?=
 =?us-ascii?Q?VCeaShtd6/soWnDTaozRpETM2LmaodQWmNQGVlIG7jkHP6JZHUC9s+zExrXP?=
 =?us-ascii?Q?aBGHn8YffpvuFZX7akJxcz1orfVIHzgTnN8Yh97Wn5nJMAXMhpYxH6f2NyC+?=
 =?us-ascii?Q?JVvQOcd8bqlvbAsHFyrQ8G/pTNzIFPVhpYmY7IdSMMUeZsoH5J3x4pUJCrtH?=
 =?us-ascii?Q?iyWbn+hXmeoFcrQt6CTw5DfSBF1N7Uy4IdCDlWT4Dhu7umkC+b3GwSeS19vv?=
 =?us-ascii?Q?s9y4FF8MxiN32CJpxn5/gwFh7H47NkP+igGB9o0AOSJSg/5v9FeZscSoJbIO?=
 =?us-ascii?Q?CD1bjsRhUF+vfh8dTpt4UDNLoRRiC4bfrGh4tKMs/1svIsQTbVCer5Lw08WR?=
 =?us-ascii?Q?lbtCK11O2UEt4XCt35876b98qjnny7zfHzkB3CsinceSaCwC8wAcvRQApdK3?=
 =?us-ascii?Q?Ul3fMXHx9l7RtELyVduEQptb1W10usxA2p8hIzTbj8yUfr8/NGw77R0Q4nQN?=
 =?us-ascii?Q?Wrg3U5ZaSoLawwyHSy5h01c3MXBGc3u/FS2rLJRZDY9s8Snketz27NV1W6gs?=
 =?us-ascii?Q?fPU+fJ/Lsc9KoFc1BvQpG2uhH7Oo6VshNyeNsW49OVGe2FhI3ftbl7PKRNrN?=
 =?us-ascii?Q?UBK/Ajizic+3VN3VHb2KA4ABWBPmUJphSbnykXglqy2Krxy+xn9tNeF9bP4n?=
 =?us-ascii?Q?MUWo7ec3lf7h5ZYoIJajD6pdSHFjTNGBFf0Z0u2OIP5S7T3HentDunHT2IE0?=
 =?us-ascii?Q?ulpOCNMf+SPhWz2Fb35yuQBWJ9n1TAYgd0iobfsR4SCiBH6osBvMTz1guixr?=
 =?us-ascii?Q?aeK68MdtpF1d1CRmwsfSC7I2BjyFwbCNF1gStxtUEKEmvNCtvOUvjFww6qo+?=
 =?us-ascii?Q?Ri3Ge2jkP2BIAXs77aEqPnludSHjNcQIWvMLqhc9WwR20Y2LHK8I5MCnSLW4?=
 =?us-ascii?Q?+U16YqrvJj1nm3YEAQgq8DINA3AP4CzYFwM8KOfGDJ6CQuz7eBM9CMGCODAk?=
 =?us-ascii?Q?v6kgrVNkWyRowbcEt6HMfQ1lp93zn6CVEM54SXYWlKggMo56ew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vOtL3uPxhrAFmT+H/bBKp5WhC2Q6RxRb/rOUag6ldCRSAYqGw0oYtqqpBt/R?=
 =?us-ascii?Q?Jfm27TsM+EcUXbyNrGRJevM1QkEXXsRgAIE+iONQ/dj+T7FkaeyIkkzdkoeW?=
 =?us-ascii?Q?IBct9zpaVVh1nMYGqVt0Hx/cLJ9JjXjc5QYNn525218/q2WVQaincV+C884B?=
 =?us-ascii?Q?h58M2eZG0puiOS6KNAwRhBOC37nRRlaqfT9YZUI5P+ZZREIfr6YGWpsjkRGC?=
 =?us-ascii?Q?+rZoUmozUtID7msjAt9XnwL0FVeeNuxvGe+fjLJnVBxTl1hZ2MWrLwCm5LQ6?=
 =?us-ascii?Q?i2aOVcd5FIoGP+RxLeI0ZCOAHdmDgkfA6gvDgwsPzR/gZE6t2gnQHjds4CpG?=
 =?us-ascii?Q?VSLTZzvdqxSoOD3dy2ly49qqiDX3caR0rBfhNbKVqe9hJq9lykJimuUmooAm?=
 =?us-ascii?Q?iSNcceljmx8Ze+8gXUY2wL2+ODNNYh5KdeTF9SQSXxIADJ/6oidZ1Ac1sB2V?=
 =?us-ascii?Q?tEvp4z0EYfxBLMZ3uzko4byCQ/6L7+58tZHg4O00lZhmzp8rzI087wMEwx7F?=
 =?us-ascii?Q?CXWD/MPduqFVMbQWJ+uRkcSWFGtptle2WGAY+ClQZLXBsjtWaiH8yzX+54Dr?=
 =?us-ascii?Q?SbNdNEVsl1WncUgy338OtFSPwT1eOkaDLBj9V0mhonPLHpZoRc+ysG1Soofi?=
 =?us-ascii?Q?fQ82YBDiqRTkeYI1Hat7OVRY7iGAkQ11MHoTeNpXo54/rJ6wyah9NlAjrw90?=
 =?us-ascii?Q?st9NbnkGWtTsOUp8xSFLxgg78m3XRUrwVAtg7D/aHS2XunKm/BjZ6r0Ot3Fo?=
 =?us-ascii?Q?oYsKUAsfnMTpNFyOyxgBM1aXx0DzxxYTA+X9ixS5y+91nLY8JmF03lFOety2?=
 =?us-ascii?Q?HKH0pO4doiqSuf+WowqYXNSzjP6t/IHvGujKC23NUWv+xn7Rpm/TLYxwBQA/?=
 =?us-ascii?Q?I0OoF55byR2I73+0s4AeKsgrxIhIJAN5fMluH5cwF4zGi6XhvA2zHbhko00Y?=
 =?us-ascii?Q?Da4JpCQ5WQ/F9ifms5CcwHiF1oT6RyX5Vh+eIH4dDw2qLmWqt8H96EthnEgK?=
 =?us-ascii?Q?UmHPpD2lCiG4Zh3HofBeLVRskkJzF7HEgUbpCaU4Fo0By7hpfxpFyzfl6G2C?=
 =?us-ascii?Q?Lex0bAOH5yq/LGUeR5A/lacb5peRu/RmpIUAtEDOFZr1s3LP437xYyLD4+4d?=
 =?us-ascii?Q?kyXyOA0OXmREHqHNTTLkvpAdyt8SbO7ItlT7whBpB0g/TS44uV7h7mwpYAyO?=
 =?us-ascii?Q?3ylRRfRCwfcDu08mA2Gnhegu6edTHiML8/MFdASWrIsZ9Qe4bK2bgrgfner9?=
 =?us-ascii?Q?hgUXiv2xiiEfm2JpkVyRGMVWqN/47C/igyM32u8mmViC2uBRgS1Tmkxl5A8y?=
 =?us-ascii?Q?WwUK/F8nMCPwA5+lrcMG828uANGkqfKhdy04fgAIPj7BZvwSFYOXbP26dssP?=
 =?us-ascii?Q?4iYIdh18/U7PxP/X6kgyNYmqxZI9u/+MgykhsXnv6WGiICV/G5/Y5ezPS+1H?=
 =?us-ascii?Q?mvNaf5SotjAH0x8Bn5W5NZ8NZXwiyRJLMNS4OCPuRSyx4izPdA6jD0g17yvq?=
 =?us-ascii?Q?NZeh61ARYv1dR5l9gcGgydHTtv2jKPIyGG7JuzqH980qnGKr3pk5TURI0ltw?=
 =?us-ascii?Q?C3FIMSyQUevCcOS1YB9BhMcIoSm5lm6EvD37T+ewMe0l0DKDLBhuxSyItXw2?=
 =?us-ascii?Q?sYGR+87yJ1ZoQsuLM/PF2mE=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe54af3-0c0b-4c22-5b9d-08dcc9ad4ff0
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2024 11:08:58.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCzrfapM/lgBHJ3WoDDoOMFwlXrTiXX8U1mzvQ1WiWUazzaQWmMV1+tdWKtyU4/C5+orjJhV2f1HKBa1k4fViYiedK2ZyIZOkxbkpbCmR1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1765

Add initial support for Variscite Symphony evaluation kit with
VAR-SOM-MX8MP System on Module.

Tarang Raval (2):
  arm64: dts: imx8mp-var-som-symphony: Add Variscite Symphony board and
    VAR-SOM-MX8MP SoM
  dt-bindings: arm: fsl: Add Variscite Symphony board and VAR-SOM-MX8MP
    SoM

 .../devicetree/bindings/arm/fsl.yaml          |   7 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8mp-var-som-symphony.dts |  11 +
 .../boot/dts/freescale/imx8mp-var-som.dtsi    | 361 ++++++++++++++++++
 4 files changed, 380 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som-symphony.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-var-som.dtsi

-- 
2.34.1


