Return-Path: <linux-kernel+bounces-310731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6E96807F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E3C283E2A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 07:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A31714D3;
	Mon,  2 Sep 2024 07:23:51 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2104.outbound.protection.outlook.com [40.107.239.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15C14F104;
	Mon,  2 Sep 2024 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725261831; cv=fail; b=I5OU3Dik633Qx0mgbFVXLS5j+HZB5fwwdVfEqCiuFnYy0At52KyAnczexb1Sw1M7dfJTZMfSpS1nnV61zBtsPYRV1W6MnfHooAL+MgnwVx6nnXT47NiP6CeqEmCQbVksSXeUqvDi2K402NyFBVb2Tz7HeZe7dkJwdfjfCjRI5ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725261831; c=relaxed/simple;
	bh=glzvNZd3IQfaegdzmb8MpTERJyJLJv2Eg/Iri+sm53g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U8ld23/vtgMP5KOmXjU3gdP3Cyowx7pgZmDkXf5UV5nOg3butYQ9NxOtiEwTY8zXLlr6myEqudeQqNdSfO97GrsV0D0iciAbjES4MQ6CsL7BCuoocPtHyXmTp/WogeRezEvXaue0Dz9h1gTHPLYPbkqb1rDwnW9hjPJ25+xqwxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.239.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZAD7W4GHh3vFW/L4CLVuTmFu5g5uISBJHLFA1dT3oJ/66a1ISNqQKgD4X9jRocq8ouqLmKnuysDkyHbdgGL6/XmD8Zk6JonF06uOjAqTMO7rpch26/mKA8Ht8ua5i6oF52Wnv2bB3J30se8GOxrQc6QOWbeA1f/N3YxCTaXiqjti0FaTjXN3CQUo+6IFY36bnKZE6CynZnPzAnsobeWOF7dV4Xzx7/TsPXB/5IeKph/LQbBCDg8QXNO+Usrsx96kxJbighA7aJDh3YjAFKs2kLUP5xigAE1713Hk8wnKMVkQc4M7D7r6MnHHDl9KhPeNcMoIOGhmzEtSRI0VciqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glzvNZd3IQfaegdzmb8MpTERJyJLJv2Eg/Iri+sm53g=;
 b=UXDmJJz0X0OO8jEauORA1sdUfMjLo5OI+T7yki8oO+OQp3uRdEjhK4dgMgeXWCXOLhBuGgvZpvbmu0jpQfYcvkJZIwNFFtkz792hlZr8D83zfJU46GhW49SnFMvw5bRaM6pzULGf6INN57BVgZdGZ49OhzlB4wdjuZt5/j+MVv9khQ97C5I0vilMswyxcrNTG5xRfTL7B0iGUnmux8tVXjtnbZT9DhZWbdeBB3Zw0Ssi1+8T7MmdfFVYZyFOn7qoDHoeZnAvz8HKkOp5Z69AxDaoz4En+LuNyobEDVDXW8yJYZRmp1/wCm/gBrdax6aIVNepDF1D/YRGZwchPDUVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:199::7)
 by MAYP287MB3867.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Mon, 2 Sep
 2024 07:23:45 +0000
Received: from PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f]) by PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
 ([fe80::58ec:81a0:9454:689f%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 07:23:45 +0000
From: Tarang Raval <tarang.raval@siliconsignals.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Hugo Villeneuve
	<hvilleneuve@dimonoff.com>, Gregor Herburger
	<gregor.herburger@ew.tq-group.com>, Joao Paulo Goncalves
	<joao.goncalves@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>,
	Mathieu Othacehe <m.othacehe@gmail.com>, Alexander Stein
	<alexander.stein@ew.tq-group.com>, Josua Mayer <josua@solid-run.com>, Yannic
 Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: fsl: Add Variscite Symphony
 board and VAR-SOM-MX8MP SoM
Thread-Topic: [PATCH v2 2/2] dt-bindings: arm: fsl: Add Variscite Symphony
 board and VAR-SOM-MX8MP SoM
Thread-Index: AQHa/QVZO9DjaeeHeEm3sOrdEo17YLJEESYAgAAAm4eAAAORAIAAAMkX
Date: Mon, 2 Sep 2024 07:23:45 +0000
Message-ID:
 <PN3P287MB182944940AB38804B65D58888B922@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240902065606.8072-1-tarang.raval@siliconsignals.io>
 <20240902065606.8072-3-tarang.raval@siliconsignals.io>
 <f3f65c33-335f-4769-958c-9b75fa7083dd@kernel.org>
 <PN3P287MB18293C640A4A027E6292758C8B922@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
 <taacgew4rjjh6q53pog4jv2waamso7ytor5a2womrm3txowjo3@t3yimdusgc6g>
In-Reply-To: <taacgew4rjjh6q53pog4jv2waamso7ytor5a2womrm3txowjo3@t3yimdusgc6g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB1829:EE_|MAYP287MB3867:EE_
x-ms-office365-filtering-correlation-id: 50c83945-d39a-4ff2-b5f5-08dccb202e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ir/udBYsg0TDkMPGxyinSwkCUsi0Gk/UUlEJc/1DPJgZttChU5YBsb8vHG?=
 =?iso-8859-1?Q?JG6IZFaaaZb43BXHgNJpJHd4wI1vJw7cq9AF0ntO8IHsFKxDjAHYqwqi7f?=
 =?iso-8859-1?Q?OJRCfM5S7TqhPRnMNs3AQ2sVtlE4IgkeZGNNISFCt/sz05QFvHA7o82/hn?=
 =?iso-8859-1?Q?GQOPX/Sgx4qtDB54iksKzB+M/hzxwYaFeMqV6qiha1ND0COLCSViC+vjgK?=
 =?iso-8859-1?Q?x/XCva3sbsqHhjSS2KfQ4mUV1WmC4vyG5PWMZ/r+16mCmS+yMNuHsT3RHH?=
 =?iso-8859-1?Q?iYHcaHU8U9izKfs/Ny9AG6nb2cP6PnxZcXoGdThVYGN9WWQLq6HaauB5DL?=
 =?iso-8859-1?Q?HBuR1A6BnLdlL9dYSz9B8PUMbDcpKNGPTfrMgD2TdoUOnh0UKVjyU3Ja/P?=
 =?iso-8859-1?Q?bkg8HDNb6/YaUwjuDganrfW8HQJRZQQBcbT1PrJegis1jGtHjEmYe+8g3t?=
 =?iso-8859-1?Q?kxM1uwXodatDAVT52RUk7owje5+TI04+K87lX/LNwx3mt4eUtfc4w5ir0+?=
 =?iso-8859-1?Q?YflO47zSyzIYxtbuGqkQUJjzKsjuyFK5HbsJr0j2pv/kq+9XZxQBgINm9y?=
 =?iso-8859-1?Q?V0DUPhmlBbcWKGkdWVd2Ov2Wardby5v5TrZU8x7F8aJiAC9ogoc+hZTliZ?=
 =?iso-8859-1?Q?70DovSnjEAtfX94KPd32nltvgQSH51PxGfSyrCVJnJq9gHnyfWXszTKCdx?=
 =?iso-8859-1?Q?npGqwsDi1/68yqsflL6fuw/AcqoI2yvO+C00RODPKNM+VVdfuTrQ9nZsF+?=
 =?iso-8859-1?Q?8srsRRglFPGnLdk/vRPFnQWSk7kLipNkc21wLT4oBRcjL5iSTSnFB0z9OJ?=
 =?iso-8859-1?Q?ibWYqhK+SLeElPdKmTG2BPRZXS68xpvC37/JRpzeGoDGK4+0suCmJzU7D9?=
 =?iso-8859-1?Q?XZAQZzUBbTfhJQ0Jq7GvjuggMHBQfYrRPg7mzjp5ni7MLVK0TdmXJGHCC8?=
 =?iso-8859-1?Q?RvP7371v2WrCCG6XIPF8PnpHuJbnuIHry5Q3CvJYbgyYVaf+gAkrgTdpro?=
 =?iso-8859-1?Q?8WneLhyOTupW5iaYVAIqevTNeQEAU/tHH9aWqSymF/l17haSWMaQLC8adz?=
 =?iso-8859-1?Q?z0UfO16hWc1LE+TpvK1dRsqaoEuLO5BcMovz2HLnK3jm4cEcKZFknfy2L2?=
 =?iso-8859-1?Q?DITMjWEmi3WIAyyBnKw4U4D8ho1QytK9+bDTlYH89UKDwT3uhLxKJdv0Du?=
 =?iso-8859-1?Q?3knkzIYWL4dJOunBj3AEbm91oxcIJayOKIEZk3NRfmFH7KerfXd/qJxJoL?=
 =?iso-8859-1?Q?A2n3LN8v0/qtg1VlKZwSW7Ch/AbH9KOoUp9k3hRplSdTA5EiZGwZmbvvS7?=
 =?iso-8859-1?Q?nrXSczmFBo8VpWRLMi8M5UYKCS5UAVjNf6r8xq1YGsQA48YfFQ+jgNczcA?=
 =?iso-8859-1?Q?mm6zAAnNuxHaOGFjGd7A1pWhl+sxBa1LEexK4qUADVt8AASJLovqrZCM7v?=
 =?iso-8859-1?Q?V1FwY9E/BWNvlpr2lzaeOBtdyD8H5eISYiqSDA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB1829.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CcuYV5R3SaeL17xi7DJ2NhB7+a++5BVNNIF77/NU+SwIvQBUsaGaBru+TE?=
 =?iso-8859-1?Q?WR6XHYJVTZpc/nqP/qceKHPaI6A5Fg71tiz2bg/2gbFvqWIWfn72TcAZpO?=
 =?iso-8859-1?Q?Y4vXJ2eb5cZQ0sBS7j5UIrsDRBxzZYhs5HpmnMAnxpwACgIiVw6Q3jpNOA?=
 =?iso-8859-1?Q?XWd4vXsi6Og4Ss07U/h42MN6gCIaMEZuH34c1UdA+D81p2GsAgOJG/QOjX?=
 =?iso-8859-1?Q?f25yizH83tIBngxLl7zohmQrwnk+4GOzQLoZ79nflTRhr7KBvw1GWmMyUz?=
 =?iso-8859-1?Q?on8OoJrfSKKO/FEjNVfwTKN716QX47FQJW7xAM0Bv/Vkqj8ZvbF+VW33kQ?=
 =?iso-8859-1?Q?w4508/TeCsDqjiOhcMqYIQqSQYuvTLador+cCsOxBPL/qj9/hCa1QPFhW/?=
 =?iso-8859-1?Q?d/imlT4sjBSd3K+lL6mPb4bA7ZW34jnVhzaFOkVYGMY8HAwuuuvFw7FGg8?=
 =?iso-8859-1?Q?rUQCVwT81ft/sx+in7VZKFf0Z6rTMlWCWwonbPllWRtS4iFRiaUXtVhDJD?=
 =?iso-8859-1?Q?3iCPVlsYxUqoAgqFHCGkZQXGQv0iQGgIvx1NvwDNv1F+QeOVk2YKsJEAoG?=
 =?iso-8859-1?Q?5EPJqoqZn8P+SYpGZkkz2kgItfEv0GItQDUGCTDY2CDs2Ckw9w2Jh6ggza?=
 =?iso-8859-1?Q?hFhr5b33NbsynX1DFlLEKEzvaE/mLeU5Snab9ZAq9l7jrK5wLFhQVOt3VN?=
 =?iso-8859-1?Q?37Qosuv8Qkk0L2jyBHUs6jd49egBXy4/HD/dyugUIzyyuH5vwH5BbUVY4j?=
 =?iso-8859-1?Q?+pqJzGDn1truS9x2kbNJFTwIaLsbhp79o9CuNtGaWu/3bygrsB3njCH3As?=
 =?iso-8859-1?Q?LGmqt7D2HZ5fQGY/nTeZQmaEk3cb8CHBYRd+iyVycL4hQv+ZlmzGp1U6KS?=
 =?iso-8859-1?Q?mCu8qy/5+4VbrawWx48X9F3vp4bcv5rO3+M0x38ceqoWvLPNsZLIICvslH?=
 =?iso-8859-1?Q?rQHHaftsPH+JvFSyIWuEGkLkIyOdFCh7ShQvWOwMymdOpC18+OTSWzv9zH?=
 =?iso-8859-1?Q?1X5wRyt8JgLybpUIl9NbRvEgzH/4kXBmRWda0v/bzLp7u2GYvblJ2BnIXl?=
 =?iso-8859-1?Q?bdta68AYejAZGwkKd0BuY3vIeAhnYYWM6F3WzZ/4iyZ2tMKLW/WHhJk5gK?=
 =?iso-8859-1?Q?+bJHqqROZFrNZCUJDhvqdePQUUp2wBQoraumMrtS4JcvnzSANQOyZs+HbQ?=
 =?iso-8859-1?Q?X9Ov4ZOMgn2OkXilOwnPX5SIUIzxEwFy4tZ5PtwRXiCkwIsV0pF9NhSq3H?=
 =?iso-8859-1?Q?7MBTis9BmODj+iShAzbhlNHnVFMVDxszjq7TUm7Td8OsaaPM1EavFFDRtT?=
 =?iso-8859-1?Q?TP+jcW14e9px8AjhNKmKcfvgaPYaOe3mS+YBJcmqEX4J9Rom0EwIdpeSo2?=
 =?iso-8859-1?Q?EPDVM+SoyNl4c7QjXcwk7gQQKNL0bYFIg/GwH7JhRmDewNX7rok0dLNloR?=
 =?iso-8859-1?Q?RJtLcyqfmB2lnKTqVDjZdEthGdqH52D+KpnfaH7FCWNKpQTW1izTq9Nvms?=
 =?iso-8859-1?Q?PHGwtZgSsDlyeh6FIVsZc704ZiXV4CWSwJTLVyghq9owfqYjkDs2GQJhJc?=
 =?iso-8859-1?Q?KRRPnQtiwH/XkgAjYUV1F39OK8+tlNf5tBigqpH7dxfCnliW41h23zH6w5?=
 =?iso-8859-1?Q?pVlBaGkIuj4R7j4iEuIdHjXcqCf7rfYmEy8kO4TD3wlD69QKDPIV34DQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB1829.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c83945-d39a-4ff2-b5f5-08dccb202e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 07:23:45.7643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RcLI1YtawtlsetcdkjM7aXALDYTfsoG6WZ4l5NtAqqeffCYTE+29DRk99iioh6t/HnUR2b55Ykpt+mn358NhSplafEIaZJkByRFo258WxAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3867

Hi,=0A=
=0A=
>> as per your comment, I did update the board name to "variscite,var-som-m=
x8mp-symphony" instead of "variscite,var-som-mx8mp."=0A=
>=0A=
>??? No, there is no difference. You did not test your patches either.=0A=
=0A=
I did test my patches using "dt_binding_check" and "CHECK_DTBS," and there =
were no warnings or errors.=0A=
=0A=
>When I wrote "This is not correct", it means you should drop it.=0A=
>Incorrect compatibles should not be added.=0A=
=0A=
Sure I will Drop it.=0A=
=0A=
Best Regars.=0A=
Tarang=0A=

