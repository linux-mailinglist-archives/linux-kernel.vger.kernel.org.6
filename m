Return-Path: <linux-kernel+bounces-401525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDE9C1BBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5402F1C23EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80681E1A14;
	Fri,  8 Nov 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="Av7IHhyk"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252CE1E2833;
	Fri,  8 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063511; cv=fail; b=OY/9yC4mvzgBr5UpozmZCg6Fm0FwjtDItdUa73HRuSX5EnGEQCZYzAaylpbAJ91JSBnHlMQ55FteMqVwaWPRLxgDVtHk4PGiTC4cAeWBowIlRbCrJqPOKQClEYGDjIF++87xGx1ZMO1czvV0zU9nssp4NYLpLiww5ART/We0nVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063511; c=relaxed/simple;
	bh=ntci4IHg8PeA1ox0i+tBXe8Lyk1AZKs84Pb1YRzD8G0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HyZnBROewH4NT4Iy03xGNg7cTEL7qPza5V3uKZSWBINEGMBZijyuWDBNFulFrOcU1W5ejb1/IN0kaWiIOtI+sC8OZ7UZ32os3cY54gWYdSd0QUMALFc0Ps9Ftby0fj7/7bMAQzF4Qc4RMEgBuF69OqRRQFtW0mwJWfPmGFDrgic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=Av7IHhyk; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AGexD021628;
	Fri, 8 Nov 2024 10:32:04 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010006.outbound.protection.outlook.com [40.93.131.6])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42s6f5r8jr-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:32:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZT9duB3iYz4HLFWTA9jH7MiUfMR7xkKFFvxUDXpAu30JaLhLXnm87N2sz59w1Gf3X9/qUncBavzC7TLHqgpyXaQRcxKRCGgzzLWajuo8BaAwA/8we1FG4hyrT5KjAXw8t55d4/zs/JeqBt37IEbawXsXLALbBSTpa1tVKoBfTqoRxIx1morRbQrYpbhKqO0qIbhG2uSdimsLJo9Dfy+rOxRcFDCyV8rM97I9fOksN9VFPSyQxrN1YwPSd1tOQcBWD3q4OMrWUGHzI5jRs0NM/x47g7JtRuvGBZSHMiBRBQMuAodZ0I/tsPfxQuwJw8a0yV+K8uueI6ex8/YdC91iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDI6AJGaZvShuQAMDqcnHLOvrBip7lAwRxy/RlrRZM8=;
 b=BMhAWmx6I7VA8bUoFKo5WS/LETSg2ti8U+Brz2iH2N8XA7LuxMcCuiwrHRdkV3na8H+Tashc9ybBJrooP/3hYjgFsIY13f6VOtmwhtGrFcbRHgXwMiNbfJPdwmloo1Y5ZxmsItAtv8vUxORfjdCRmuFbImxXDth3Ft1VR7m9pC36VOW/UPAx5D4lxq2EGDD1OjRoBf0bo96iDXj4K0jmNxqSRIZoV737YJzTo/uAWYE5rrMCitCnqqVRoile4oKjva7QT1L4z82gbu0ItuHgGM0PkZR7tJFfIBhpIDWU9eMnlbHXQe0pa/zZmVKpMQLP+T5mc8LFjl2Pj31VxtHnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDI6AJGaZvShuQAMDqcnHLOvrBip7lAwRxy/RlrRZM8=;
 b=Av7IHhykpkVx0xzLiIlLZwK4RIzNUlne1dgxNsj5KPP4Mth4IioI4Si/nA6kA1umUhm6AdV5MleNUP2rGDwNIRRb4/8xlNdWRR+peKwofs+V1rskkw2hdbS2BaKi27TkczDkHynkA8mOvAUyillMqhvZJjd084NPC+Gf2xLipbE=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7813.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:31:57 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:31:57 +0000
From: Niko Pasaloukos <nikolaos.pasaloukos@blaize.com>
To: James Cowgill <james.cowgill@blaize.com>,
        Matt Redfearn
	<matthew.redfearn@blaize.com>,
        Neil Jones <neil.jones@blaize.com>,
        Niko
 Pasaloukos <nikolaos.pasaloukos@blaize.com>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "rafal@milecki.pl"
	<rafal@milecki.pl>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "nm@ti.com" <nm@ti.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "johan+linaro@kernel.org" <johan+linaro@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 3/6] arm64: Add Blaize BLZP1600 SoC family
Thread-Topic: [PATCH v4 3/6] arm64: Add Blaize BLZP1600 SoC family
Thread-Index: AQHbMclv1BLWIvAcDUWa72Fo0F0oCg==
Date: Fri, 8 Nov 2024 10:31:56 +0000
Message-ID: <20241108103120.9955-4-nikolaos.pasaloukos@blaize.com>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB7813:EE_
x-ms-office365-filtering-correlation-id: 1e2cb696-3fef-4ea9-5c47-08dcffe09289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dyKzvHX597rzQ6GEgU5B1IBVHZBznJUQQmzxbE+QfDIvJ749tUPqIFyDUk?=
 =?iso-8859-1?Q?Nc6FtY/D6E7SjXP6eUQ5PBEj17atF/TNsHhMYXDkR+CRT2UiGdDzCa9C5C?=
 =?iso-8859-1?Q?zQg1ZzbeFlrJEe2BXydSLTrCtjNZPO0TGbpqg4/gxKg7PmkAnyLnLPJxgZ?=
 =?iso-8859-1?Q?bvs+yADhZjZP7HUwfn+WyPKXOfXotd6i3jO326FHsCWMTzEYhKNoAo/sHw?=
 =?iso-8859-1?Q?+Ssqa2ptybZYNcGMFbdVma9YH+wTDYPmhuxrjlj/T0Ledv7kV4aMV2GMLK?=
 =?iso-8859-1?Q?gnAosSss4jUxX6wEHENg8RXyKWlUIU1DmSVOW4vnJGq+7+YKh8EljVL6gT?=
 =?iso-8859-1?Q?7j0okUHtaKLPp0rWaipNPUDrxjwvtTue8MkcsB0vfOgdU8D9Q6Gwl3Ka4F?=
 =?iso-8859-1?Q?r4RN1uR5bFav7NJ8Cveoy9mE0Vn01h5/BrDOHY6dtj9B0ZhBEMw3A4alZz?=
 =?iso-8859-1?Q?Sgqg7aeugdBBnE9ZkBlSa24wg36V93maNEaR14cuLx4s6JP5joSF+0+S2Q?=
 =?iso-8859-1?Q?TKFFlNn0hxis13h6OwrbZaqOJmGkJCcbhaoyXh6+SiYy+bPaTtaF5MXRCf?=
 =?iso-8859-1?Q?oMhu9uSHeiZOoIRuA0J9TR3yXflDHJtYTZ0URWhdefw8NCoOKJvcNYW4w2?=
 =?iso-8859-1?Q?WO6twiebOkGsptTOnp9Vb6w5aElN4vdYTG7k+Uxu9beCmFj1zT4c1CI3j1?=
 =?iso-8859-1?Q?Xx20LNna49g34/1Nq9fudhRKLQKhUCTAhkLD7SH6jGUc2t64Dn5OLBuRFz?=
 =?iso-8859-1?Q?U8R8ssU4TrBywY2r11EU4tpdpTbv9fBDNs7qlCvYTmbRnHjlQsg1A+ebc+?=
 =?iso-8859-1?Q?4aZ1LJlJbUPUxG89SgZMCWR17QQ3TyWJgO+5feuPFmvT1+BzCbPB1kxIm5?=
 =?iso-8859-1?Q?dadjfInyi7JLLHrAiQCW3nM78bCMvlbSe1wnDovJyk53Rlzhfm+H4pScYn?=
 =?iso-8859-1?Q?BijYlx0Xds8BR5udL9jt/Ee/4HnOMmtAp//XmqeyGOREOlEfaIEEGlDEB+?=
 =?iso-8859-1?Q?pLow5UVa+UQ9N+JK91bSpRp+qAG/Uv/zqUPaHl0b+3RXj4KRHCKmaNO8mA?=
 =?iso-8859-1?Q?wDDP8RI1rAkg+aTr4Nrh/LASfxsLuqTL1+8+hNUFdf4c7Wfr0zlQEoskKx?=
 =?iso-8859-1?Q?O4RR1ZpfCiPK9C2dHWe9ju7nfsj9zj/MEN5ADJAI+kYVavGcEAJpDhibgj?=
 =?iso-8859-1?Q?DiPXqreJjQvenTVzZo1EqO17o7pbb3dG/qMxvbRIAQgf55H1fENZmevXF3?=
 =?iso-8859-1?Q?I8ULUpAnOEIqm64ZQsmoo35rLGRHc9eCZHpnTKWPNdmoUWSP3uu9hgwGoW?=
 =?iso-8859-1?Q?axDxVO3uRKNCyvbiTEsO43qTICNx+MomhG4HNXpVsoRM6jrEEMqJMShsy1?=
 =?iso-8859-1?Q?hPvJLajUoewbGFQzf/NDj4iUJiLPpSyznxitzGbogr+6vO1xnI2Tj7KKpd?=
 =?iso-8859-1?Q?UTjQdYLhLeov3DPv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?410afn7VU2LJRS00MuIMz6HFnl7NQiCN1K1Mb6xqH3EWV3o7uB1bKs6tkb?=
 =?iso-8859-1?Q?2jSzt/fXk8f54GJ4x/GzMK4wZT+SnxARNB48UZjl0Se+5SC/ljKUNehOee?=
 =?iso-8859-1?Q?vJZk2bYDMPOzldzZ3gQeymOOxh2z/mSOcMhIgrQ5v41RgSI+73brikZjPa?=
 =?iso-8859-1?Q?rJLLWTFhe6N+ua7mhaOEOmH8XYxvouy1ApU/JPW1NgrS/HIvBQ2YuRoK/k?=
 =?iso-8859-1?Q?cKpRsprWt16V6P5GEjhEipiOff8MUZwwpWWcc9jhWHgZ+tsr+Rjqq8i6Ar?=
 =?iso-8859-1?Q?5u0m3seXN82Nd+q4p4mV3cIU6o7tUxS8ZF6UmfYcJw3hABUofuRzT/LRgR?=
 =?iso-8859-1?Q?8ytndxBGv/0OYEa7o53NC6mMf2z8GGmfFU+IqIY8OA937oGzlRIdtX51/l?=
 =?iso-8859-1?Q?Uq3jBSkpD4iHW1NZKdYoeGVIyFVPPqdFy4BuRIbPwbF6ZoRTO0f3cGH7qw?=
 =?iso-8859-1?Q?qULgPALlI6TwPSVXHsQJch6zcakaBgojWGOqrv/sYSTmGv7SDSVKlcBgpV?=
 =?iso-8859-1?Q?qGl3CG5bRPKjcyh9tVl0wMxpSZxDfodiY6N49u/TJioytI59tYGD7WXOFr?=
 =?iso-8859-1?Q?P7bKru3R2rT0ol8zzlnlUhd4FQUh1zr10Gl9gZHK0blK8Y/SiKx4c/N8z5?=
 =?iso-8859-1?Q?utLupr7NmCaRT3EWQNoQVsSkLbI3Fc+aszzPA1pcm+/+mLm6MhGaB2A1uA?=
 =?iso-8859-1?Q?SWbRwnhMMV9o0YfCgJQ+u6sskf7o6JVKOpAtHH4uh6UGNguohh+2elN/8S?=
 =?iso-8859-1?Q?8by+oNANOyqXe5L8XMuCYOt1I/9VFUm/G9iwXrqqVi5bZQXU+po4y00eGv?=
 =?iso-8859-1?Q?fHsBkoWi6G5vJIbcM5pm+g93ALVLPrkk50uVaS/dIriJvQ8U2mrXrcNrHC?=
 =?iso-8859-1?Q?H1U7tuSoIg8zOpekE349dzpN156O3CKEc6ucgkRnnEsxolwN63A9mYiwDj?=
 =?iso-8859-1?Q?0am3S9oxTMHzap0zDwbkH5cIMgvcgNICjL2r6iN+BNFTeFkdGH1RZR9t/z?=
 =?iso-8859-1?Q?wraebATdoVIfMqWURsqNaoeXYte9odWmQNbXNzZHFq7188ijBRA1J+AZWn?=
 =?iso-8859-1?Q?IBq26s6LZrxBrzvhAoGh326kVf0FtfqJ2Dub9iGzbKiQgJAVEYOl5rFUww?=
 =?iso-8859-1?Q?Qyqt8ObxD8Zgg39ODsswkEih2S2CsIiZhvyVQlABWW5RUONcvc3fhLrGPQ?=
 =?iso-8859-1?Q?ePuF4LxtvItNjS4DjC+5IgiPyFhCiJJU6qjg7l9OMc5hywPaYXFlpeKDlo?=
 =?iso-8859-1?Q?WoW3VQVx9LXp6aYBPqXo4dRoLT9cFK6byYtW+I181ZlMu9wJUYo9DqzVIb?=
 =?iso-8859-1?Q?uan7rWLGfgglg+SK3/kIBCLooG8Sb4R1fruX4pybMJyA1nV2jHSMxKqjG+?=
 =?iso-8859-1?Q?iB5kjtsvLDUbloMEncPKFDY2KjPd47LBNPDHiCYte6g8VZBjCFH9md/rqi?=
 =?iso-8859-1?Q?3971bzZnKB01JTnpmfLWCsL8+HsZSiHosrt5zGxpduONkvYQ5EPXHeQ/3J?=
 =?iso-8859-1?Q?RNqqlpCOumVxI1hXnxtzT6FKpIh+va2iPxvAyxMfDtn6b5OMtY4ZBBRmWk?=
 =?iso-8859-1?Q?TX2mOfG/i+ahAkSznJ3WouGcKEJtYWZxhsnnOPYfTDtFkcYg5susNa9v8m?=
 =?iso-8859-1?Q?ISQkaBasEz4M2OksZTngfUABntsA5//DiMUfwZeN2ssTgPTxD8DwGS0Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: blaize.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2cb696-3fef-4ea9-5c47-08dcffe09289
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:31:56.9543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qaDU0IKHlBfDK8XOTSjKotyU8w7F/nFcpE2irDlCCBxDzACenIIOdscJuQ7vdeNxQswLv+fmkQdQK6CCXAqw5BzLFsNnfwuEOO1KFeNk4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7813
X-Proofpoint-GUID: lfEevlgA6A3A1kkKoGIGAi6Yb0Jfyvyx
X-Authority-Analysis: v=2.4 cv=BqvPwpX5 c=1 sm=1 tr=0 ts=672de8a3 cx=c_pps a=TXs1g+7sIME2BPo3OSn30g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=q48U0sNtksoaHmRLNCsA:9 a=wPNLvfGTeEIA:10 a=G1c27RQYZcVoSmQCoXce:22 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-ORIG-GUID: lfEevlgA6A3A1kkKoGIGAi6Yb0Jfyvyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

Add ARCH_BLAIZE_BLZP1600 SoC family to the arm64 architecture.

Resolves: PESW-2604
Checkpatch: ignore

Reviewed-by: James Cowgill <james.cowgill@blaize.com>
Reviewed-by: Matt Redfearn <matt.redfearn@blaize.com>
Reviewed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/Kconfig.platforms | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 24335565bad5..c2a523637b23 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -94,6 +94,11 @@ config ARCH_BITMAIN
 	help
 	  This enables support for the Bitmain SoC Family.
=20
+config ARCH_BLAIZE_BLZP1600
+	bool "Blaize BLZP1600 SoC Platforms"
+	help
+	  This enables support for the Blaize BLZP1600 SoC family
+
 config ARCH_EXYNOS
 	bool "Samsung Exynos SoC family"
 	select COMMON_CLK_SAMSUNG
--=20
2.43.0


