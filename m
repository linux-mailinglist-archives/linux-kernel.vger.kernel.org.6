Return-Path: <linux-kernel+bounces-401524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB379C1BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F5F1C24898
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75CE1E47D9;
	Fri,  8 Nov 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b="EQ1h+vx/"
Received: from mx07-0063e101.pphosted.com (mx07-0063e101.pphosted.com [205.220.184.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2526D1E2603;
	Fri,  8 Nov 2024 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.184.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731063511; cv=fail; b=B5W+LaNkTwfQG+SvmgxBPSrbv/Clcu4YRSPkmEGMYi7lXBsTR2S2IQefEe05BPIxEbcmK+sVSrHUi358eHd3Fux+1lbTT591dFywlOsFvfKyEY6MP4mKv+OUkn9VPpz/sraFzTxpgEdY600zmkQ4J4dL+URtI5Om4RFJ4exrZTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731063511; c=relaxed/simple;
	bh=ZnmAffcXzLecd00PLrbel1YWS5qGzL5Yins7GQsoPM8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLbdKjZ5iYgQ61fNZHrJp0SD+UqvNuWVJctilxzTOh0B9pqL+wRJ6ECknjZWbNWtL0QvCtUiCyk3eMjbKuqRNaMdIx36K8p1LXnCrh4edAZgVv5nzPNW6dQn5RYnXbVe7yu9WW6Wton9w74/aqjjWxnPHzc65iycGvQSPkNhlhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com; spf=pass smtp.mailfrom=blaize.com; dkim=pass (1024-bit key) header.d=BLAIZE.COM header.i=@BLAIZE.COM header.b=EQ1h+vx/; arc=fail smtp.client-ip=205.220.184.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=blaize.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blaize.com
Received: from pps.filterd (m0247495.ppops.net [127.0.0.1])
	by mx08-0063e101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8AGexE021628;
	Fri, 8 Nov 2024 10:32:05 GMT
Received: from ma0pr01cu009.outbound.protection.outlook.com (mail-southindiaazlp17010006.outbound.protection.outlook.com [40.93.131.6])
	by mx08-0063e101.pphosted.com (PPS) with ESMTPS id 42s6f5r8jr-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Nov 2024 10:32:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlJ8tuUoX4dcAXPq5+xPA1EIaDHTg6E/eacqlGdjtOqYDWrC4j4Fzb5bEs+7tpmy3O4B9FhvxYyv4CHdGpWT/jhcqldzGALnNPR1erN0llZCIBMGXSnpL27gJzX8KVKc1bIhZIBZs55URdnLTrEw0+9Uh+ryheS476uch9gt+AEzyMy5gr0XwNn69vP+fp1XFhVFD+2n3vhBWv9sajkLw6PXkaEnwsmftByrGw3Zo0IowqTO8e40HNYAWzVadB89xYb2WKOIOfwGdjcpYMZ+OfnMUQD0zkbynY9JQfk2BrpnKxkUz4hDhweltIduJLDY92/X+cyYSgh5yu73r0dS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9YIfWXRWHbSItuV7hkensXEQ9Xm6bHySqXZCMJOx7M=;
 b=CBOVoCdlZDEV5/PuT1VnKu31Oxg4bB24Onz4QJ2W7CCcY4TlSHnCw0X2fi7E+jz6+28apOnZ+CSURgGBXumvYvcoeGXuxPG7iRVzIkr8i1zR50ViuR2htPa+uK3EZpL+h/EjIJAlrSHr+3+bWhppzZo/Wkm1bxchJIWkyqJQEO8prGMs2vyl0axMHRUk3/AP7YyLXjaUrqFf0r3pVwaadtcA1M1qDgu7N9ht6wtFsnJA04eGfpDVdrkmXswypcp8U8Tf2igBjT71pRZ3VbKfhll2nmt5JQjB+7gKnOMwfwApIxg31onS8RJnqi8jBUc6bGZ86dxs2Djw/gIQQrTX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=blaize.com; dmarc=pass action=none header.from=blaize.com;
 dkim=pass header.d=blaize.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=BLAIZE.COM;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9YIfWXRWHbSItuV7hkensXEQ9Xm6bHySqXZCMJOx7M=;
 b=EQ1h+vx/IpD/tdF/bsU0DUXF7Ec6wxII7PZf3TUB0SU+6ZTFNN9Peuk5+2NC1DhKmb7zTiKdWjplVyrHUOFcFwwBNzyKiyu9xzoRT9rhtVHjB/oJwvtlAeAd4Q7qqttTeHX6TbNGT5rJctd4O03Sbi53/IycIhsjpjq7dn3I6Yw=
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12a::5)
 by PN0PR01MB7813.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 10:31:58 +0000
Received: from MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655]) by MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::309a:12cf:74a4:5655%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 10:31:58 +0000
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
Subject: [PATCH v4 4/6] arm64: Add initial support for Blaize BLZP1600 CB2
Thread-Topic: [PATCH v4 4/6] arm64: Add initial support for Blaize BLZP1600
 CB2
Thread-Index: AQHbMclwfRt3f4mfrUa2QPPbgzG5og==
Date: Fri, 8 Nov 2024 10:31:57 +0000
Message-ID: <20241108103120.9955-5-nikolaos.pasaloukos@blaize.com>
References: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
In-Reply-To: <20241108103120.9955-1-nikolaos.pasaloukos@blaize.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MA0PR01MB10184:EE_|PN0PR01MB7813:EE_
x-ms-office365-filtering-correlation-id: d268f0a5-69ee-4ed0-a738-08dcffe092ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?j9pNQc/TnFmQ4aQ68wC7m8gkkKS6UZQI9Fz7rFrEISqCFYj+EiBv9n8pJJ?=
 =?iso-8859-1?Q?nQS5eSOS/bzcwd3v86SSdKS/x9ceryoY+3bMT6ILzCGKG1n4XFF7rch0Uz?=
 =?iso-8859-1?Q?1Xcc7/KhIXsjfCVAsni5zyAa83ANNqQ5hK7nNmiyQzSizNw7WDVBCAA49e?=
 =?iso-8859-1?Q?wfcMflh9yu5ri3JbRTk3SxVvoc+ZM8pqhxVYAOUrqs/OPDeJfwCv7SZJUT?=
 =?iso-8859-1?Q?+JvxzGHBg171PHD6DeJnR+IEg4ebMelHP0mx6bYdBcztS3vbb8yKwvIOp/?=
 =?iso-8859-1?Q?G8qkYPI4UvtRxeKFtAMHlkPAgW9cNM6KesbDa1K/QDaegqnPdXbZUSgOGF?=
 =?iso-8859-1?Q?D9RWTeE7V2aN94XounfgWDuM0Jb6ULrvys0KPXqa72kIdE1YgTL3/Hz11g?=
 =?iso-8859-1?Q?0vaMZDSFYhhz9rAo70kYUD/zXZID273XAmkAnBbrxY1Wtt7UiS+rD0vsAw?=
 =?iso-8859-1?Q?SkLbPOmtmCkX6NwHYiC8dnKUtyAQ4wn9PYQbC1iuNg0FyH81tf4yXFGvB0?=
 =?iso-8859-1?Q?bdkatlsaWqk7a5hcR5Ms5+HwgdMtRRYYzY90eUxwU0zPbQJDyrHOA9niOj?=
 =?iso-8859-1?Q?LOlA6R9rN6QIORhVA0S4geHbo96P/3tXYBpczr0e0ZjAA0/bcLGDjhFvwe?=
 =?iso-8859-1?Q?2RbMERZo7/aSyQ34w9769665oLZ7BbMy7oKDQ2B3wXGSzsHqS5oYntvKx/?=
 =?iso-8859-1?Q?quOCYErLJBgwmCzy+K+l7GrsP5UaX5Xx1YEqtASW4yZMlEr7kdenrx//4X?=
 =?iso-8859-1?Q?PFYk9p0r3Ong5/Sal/WlfwDwebN9FEXti/xORNPgC3CwUii55JjL2AbEYw?=
 =?iso-8859-1?Q?2Nqptl69+6neR4WKyCxoCO6fE2SbP55BWROSS8ZPwqTVBhCiZLavaOUENZ?=
 =?iso-8859-1?Q?6S6SS9zJdE4ZoPaWpBReDUnmEWveh+yhhjZ9qIJdMPbxptz0o+wyCkn/op?=
 =?iso-8859-1?Q?VlILsZc00ZypOtquJn9kV2w+HjieCw/Flnr+r/8NBbBJBKcpHnAZiVLxpq?=
 =?iso-8859-1?Q?B3kuIMty79YRTgfbBb3b0ttDaH455CUDBfVBthpHkTLyHhUFjYweiqmRl+?=
 =?iso-8859-1?Q?HZs9i/S1wbOxP8EfnKxA9TfLHNdd2IkRiVbiPW2LcuxGTU4174a604sxHV?=
 =?iso-8859-1?Q?ZLXMKVRQOFgc0ZWDOhmDCp5X9Fl6t/apI4cWVlxo6IrAsBKy0D754vtsEg?=
 =?iso-8859-1?Q?3nvfP7zuwmYk+9GiDhiZa83H4zzE35+YOZB5X0UEtvBYT18lnWoexmwNz2?=
 =?iso-8859-1?Q?pFkKGUzHJkyTlOJWiFS4qIpWR88dSCeF29JrmEaxZtjewsebPLb3CT1rqP?=
 =?iso-8859-1?Q?RoPqwz6n0RWWB8AAidnBn9vdUg9ga1MRZokDlcAWo406b1XmeaR4DHQf7Y?=
 =?iso-8859-1?Q?lbf86zp2av6+q4JxVYGAkVJ6Z0t0Q6QGKy41bvISaqQspAEaMLuK0dYKBK?=
 =?iso-8859-1?Q?z9AK/FElN0vSL8KT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0PR01MB10184.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xfZi8JKb9fAMfCcbV8SudhYPDyR1YrHwHFDayL3D6IAY7q1SXbwXzIgXHL?=
 =?iso-8859-1?Q?0ZE/VI4gMl6ZSRxU8kSnSVh+jdaa6Qvx069A3jnUNsAm58aGtJnEOfrK8W?=
 =?iso-8859-1?Q?tcy1tH+filIWGcl+HM1owUEHNRrUHw5Ht/UzO91WCG3bQ0Ak6mO7zss5QM?=
 =?iso-8859-1?Q?XYER8qaBBm4GQkH4pfXSScXH7Qo/WgV5croEbhFUMpYmRtQTUR/jwvuz1o?=
 =?iso-8859-1?Q?DGTpFgM4ip11xXiaL/BQa++Dn1s0MZOIRc0FXX53DSGligyALqyfVNk45j?=
 =?iso-8859-1?Q?E/RFjdc1x6fg6iNw2AI7IQO+hQCg1SMAbRAIV5Hct0gWX0WIeh+vhZRBVo?=
 =?iso-8859-1?Q?XFb7jyf7z/ZV8XODJwKhZf08BQnB/sbigDah4x8G2JzlsohMOzWWioTwaC?=
 =?iso-8859-1?Q?xM4lJ5PfoDGhY/vxspaTqMnRBGbBTxloFq8grbO1q3dXErvT1JfV0Owhao?=
 =?iso-8859-1?Q?ceLuNb82Uc0AYzyL015EQOBp4m5TaleJUS61wDTGtH3melNaDC6azl3rII?=
 =?iso-8859-1?Q?k+9E6urb21iPHON7XSXK0DWjkUWonJPz7TtJCwUEhHZAnQzWTfCtMy90Y8?=
 =?iso-8859-1?Q?tKg0m9s9orghCrSXkVp5CKCSN2JUZqaP9A5JmGJlfmNDorigdvWC6vEdBg?=
 =?iso-8859-1?Q?bY8UHgSqx5uk4E39X0GEV70tGAeSC5fbHh1qIstmno61Nd8gZlg3EDPxmt?=
 =?iso-8859-1?Q?OMHskZPmcRVoMTLLNPWzEfLJNpe0g5ShBCQRemnEjLW3smpHvGhLNKs/3H?=
 =?iso-8859-1?Q?4Wd2Qvpbq721vUXDN0X5LA8p/t4IfoSo9EBySwI+To2gBabB/nI58RJQVS?=
 =?iso-8859-1?Q?ykJ9wiURC/rp59ieGaw6NB5jeoHMUSChfIkYR5iISuLBLw7A5ht/eYFSGR?=
 =?iso-8859-1?Q?7+HapMGBzYWx+RkAVwVd8g2uSzsx/n9ZUJ5kL5MCdgtDxJQYo7E39pdb8I?=
 =?iso-8859-1?Q?rrQFbASWPmt8USBxdxX5RW8xbfDVs+olbKEHz1G/4yo80awiXAqVJDmtLh?=
 =?iso-8859-1?Q?3NDO/z8zH+dA86iYTGWJ8xSwdLLIeaO73Uf130FTraliQGyd2zHw0EK+5S?=
 =?iso-8859-1?Q?kYYmkL8hs88pK9oEqIF/fgk+wDo7Pw4PJfD/vVlgVpHvXFi93ZV5mc2cpB?=
 =?iso-8859-1?Q?GOn7I8AN4hhpmiEt8V2ABcoZZfkQLcNZNHoh8NZtHPIOO6kh4w1MoAIPFv?=
 =?iso-8859-1?Q?2rLBjiFsJIwK3S7z4nI5+GiBSMWCwSYpf7dG+iWsdrh9Tsz8OejOKK34wc?=
 =?iso-8859-1?Q?13F9M+eetP1+mQtegMfGWTDOPYCiFhGYuvUd+rrIhsOXJAcCzEHiwI5x7c?=
 =?iso-8859-1?Q?EZlRJLyEXcsUCaz1xubL/mrgnlFcBa/TwcBEE40BvwjQBe7bAGtqk4FjIJ?=
 =?iso-8859-1?Q?ClaY/YObVc4Mr19Y3nib1Bmq5Jqq9wi4qg5f5BfELuh8OtqUU5XwQDHfCx?=
 =?iso-8859-1?Q?4tUDKvI4fTEXVGnHpxSx5iVIQwNaqZhLMy4Dwm72Me4MvknBi2BBoRCNS8?=
 =?iso-8859-1?Q?i5QXUFuaY/4pfz1EhLUNGiybOFb7UrfMWJa07DioswJUdFTPlK5zOrSaOt?=
 =?iso-8859-1?Q?v45+sFnq7XZWyNyWDH4cZUtpgmYY6ndXoCC7qMB3dxseJHL2jh6JFDihP9?=
 =?iso-8859-1?Q?dihFkUmOXlkAPHq4Qr8UsXWOIsB6k6YgRNVF25+PAzPmbrGlSBMy+MCg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d268f0a5-69ee-4ed0-a738-08dcffe092ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 10:31:57.7900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d1c3c89-8615-4064-88a7-bb1a8537c779
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L79JQtTyc0g14hlVY7YoChAdBLj7XYyCwkaEEV276YBZ4ZnwFNnuktnY3DCl8vM+3UFINTDoh7E0B6zQKxpsknVtGFSR/Xom3QHhiJ7KKgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7813
X-Proofpoint-GUID: DdnAAmfqmETuJgR67Lg3i_N07miy2-So
X-Authority-Analysis: v=2.4 cv=BqvPwpX5 c=1 sm=1 tr=0 ts=672de8a4 cx=c_pps a=TXs1g+7sIME2BPo3OSn30g==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=VlfZXiiP6vEA:10 a=4MthsM0t3ikA:10
 a=-5LYVjoNHPMA:10 a=SrsycIMJAAAA:8 a=pUg8Dph67f-7xG774KMA:9 a=wPNLvfGTeEIA:10 a=RVmHIydaz68A:10 a=zapPnUM7SFj2ezx6rUw-:22
X-Proofpoint-ORIG-GUID: DdnAAmfqmETuJgR67Lg3i_N07miy2-So
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Reason: orgsafe

Adds support for the Blaize CB2 development board based on
BLZP1600 SoC. This consists of a Carrier-Board-2 and a SoM.

The blaize-blzp1600.dtsi is the common part for the SoC,
blaize-blzp1600-som.dtsi is the common part for the SoM and
blaize-blzp1600-cb2.dts is the board specific file.

Checkpatch: ignore
Resolves: PESW-2604

Co-developed-by: James Cowgill <james.cowgill@blaize.com>
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Co-developed-by: Matt Redfearn <matt.redfearn@blaize.com>
Signed-off-by: Matt Redfearn <matt.redfearn@blaize.com>
Co-developed-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Neil Jones <neil.jones@blaize.com>
Signed-off-by: Nikolaos Pasaloukos <nikolaos.pasaloukos@blaize.com>
---
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/blaize/Makefile           |   2 +
 .../boot/dts/blaize/blaize-blzp1600-cb2.dts   |  84 +++++++
 .../boot/dts/blaize/blaize-blzp1600-som.dtsi  |  23 ++
 .../boot/dts/blaize/blaize-blzp1600.dtsi      | 205 ++++++++++++++++++
 5 files changed, 315 insertions(+)
 create mode 100644 arch/arm64/boot/dts/blaize/Makefile
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
 create mode 100644 arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 30dd6347a929..601b6381ea0c 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y +=3D apm
 subdir-y +=3D apple
 subdir-y +=3D arm
 subdir-y +=3D bitmain
+subdir-y +=3D blaize
 subdir-y +=3D broadcom
 subdir-y +=3D cavium
 subdir-y +=3D exynos
diff --git a/arch/arm64/boot/dts/blaize/Makefile b/arch/arm64/boot/dts/blai=
ze/Makefile
new file mode 100644
index 000000000000..9118d7fb600f
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0+
+dtb-$(CONFIG_ARCH_BLAIZE_BLZP1600) +=3D blaize-blzp1600-cb2.dtb
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts b/arch/arm6=
4/boot/dts/blaize/blaize-blzp1600-cb2.dts
new file mode 100644
index 000000000000..5416f7e84ac0
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-cb2.dts
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Blaize, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "blaize-blzp1600-som.dtsi"
+#include <dt-bindings/net/ti-dp83867.h>
+
+/ {
+	model =3D "Blaize BLZP1600 SoM1600P CB2 Development Board";
+
+	compatible =3D "blaize,blzp1600-cb2", "blaize,blzp1600";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:115200";
+	};
+};
+
+&i2c0 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c1 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&i2c3 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+
+	gpio_expander: gpio@74 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x74>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "RSP_PIN_7",	/* GPIO_0 */
+				  "RSP_PIN_11",	/* GPIO_1 */
+				  "RSP_PIN_13",	/* GPIO_2 */
+				  "RSP_PIN_15",	/* GPIO_3 */
+				  "RSP_PIN_27",	/* GPIO_4 */
+				  "RSP_PIN_29",	/* GPIO_5 */
+				  "RSP_PIN_31",	/* GPIO_6 */
+				  "RSP_PIN_33",	/* GPIO_7 */
+				  "RSP_PIN_37",	/* GPIO_8 */
+				  "RSP_PIN_16",	/* GPIO_9 */
+				  "RSP_PIN_18",	/* GPIO_10 */
+				  "RSP_PIN_22",	/* GPIO_11 */
+				  "RSP_PIN_28",	/* GPIO_12 */
+				  "RSP_PIN_32",	/* GPIO_13 */
+				  "RSP_PIN_36",	/* GPIO_14 */
+				  "TP31";	/* GPIO_15 */
+	};
+
+	gpio_expander_m2: gpio@75 {
+		compatible =3D "ti,tca9539";
+		reg =3D <0x75>;
+		gpio-controller;
+		#gpio-cells =3D <2>;
+		gpio-line-names =3D "M2_W_DIS1_N",	/* GPIO_0 */
+				  "M2_W_DIS2_N",	/* GPIO_1 */
+				  "M2_UART_WAKE_N",	/* GPIO_2 */
+				  "M2_COEX3",		/* GPIO_3 */
+				  "M2_COEX_RXD",	/* GPIO_4 */
+				  "M2_COEX_TXD",	/* GPIO_5 */
+				  "M2_VENDOR_PIN40",	/* GPIO_6 */
+				  "M2_VENDOR_PIN42",	/* GPIO_7 */
+				  "M2_VENDOR_PIN38",	/* GPIO_8 */
+				  "M2_SDIO_RST_N",	/* GPIO_9 */
+				  "M2_SDIO_WAKE_N",	/* GPIO_10 */
+				  "M2_PETN1",		/* GPIO_11 */
+				  "M2_PERP1",		/* GPIO_12 */
+				  "M2_PERN1",		/* GPIO_13 */
+				  "UIM_SWP",		/* GPIO_14 */
+				  "UART1_TO_RSP";	/* GPIO_15 */
+	};
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi b/arch/arm=
64/boot/dts/blaize/blaize-blzp1600-som.dtsi
new file mode 100644
index 000000000000..d54707c17163
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600-som.dtsi
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Blaize, Inc. All rights reserved.
+ */
+
+#include "blaize-blzp1600.dtsi"
+
+/ {
+	memory@0 {
+		device_type =3D "memory";
+		reg =3D <0x0 0x00000000 0xffffffff>;
+	};
+};
+
+/* i2c4 bus is available only on the SoM, not on the board */
+&i2c4 {
+	clock-frequency =3D <100000>;
+	status =3D "okay";
+};
+
+&uart0 {
+	status =3D "okay";
+};
diff --git a/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi b/arch/arm64/b=
oot/dts/blaize/blaize-blzp1600.dtsi
new file mode 100644
index 000000000000..6d524d0dba62
--- /dev/null
+++ b/arch/arm64/boot/dts/blaize/blaize-blzp1600.dtsi
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024 Blaize, Inc. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	interrupt-parent =3D <&gic>;
+	#address-cells =3D <2>;
+	#size-cells =3D <1>;
+
+	cpus {
+		#address-cells =3D <2>;
+		#size-cells =3D <0>;
+
+		cpu0: cpu@0 {
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x0>;
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			compatible =3D "arm,cortex-a53";
+			reg =3D <0x0 0x1>;
+			device_type =3D "cpu";
+			enable-method =3D "psci";
+			next-level-cache =3D <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible =3D "cache";
+			cache-level =3D <2>;
+			cache-unified;
+		};
+	};
+
+	firmware {
+		scmi {
+			compatible =3D "arm,scmi-smc";
+			arm,smc-id =3D <0x82002000>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			shmem =3D <&scmi0_shm>;
+
+			scmi_clk: protocol@14 {
+				reg =3D <0x14>;
+				#clock-cells =3D <1>;
+			};
+
+			scmi_rst: protocol@16 {
+				reg =3D <0x16>;
+				#reset-cells =3D <1>;
+			};
+		};
+	};
+
+	pmu {
+		compatible =3D "arm,cortex-a53-pmu";
+		interrupts =3D <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity =3D <&cpu0>, <&cpu1>;
+	};
+
+	psci {
+		compatible =3D "arm,psci-1.0", "arm,psci-0.2";
+		method =3D "smc";
+	};
+
+	reserved-memory {
+		#address-cells =3D <2>;
+		#size-cells =3D <1>;
+		ranges;
+
+		/* SCMI reserved buffer space on DDR space */
+		scmi0_shm: scmi-shmem@800 {
+			compatible =3D "arm,scmi-shmem";
+			reg =3D <0x0 0x800 0x80>;
+		};
+	};
+
+	timer {
+		compatible =3D "arm,armv8-timer";
+		interrupts =3D /* Physical Secure PPI */
+			     <GIC_PPI 13 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Physical Non-Secure PPI */
+			     <GIC_PPI 14 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Hypervisor PPI */
+			     <GIC_PPI 10 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>,
+			     /* Virtual PPI */
+			     <GIC_PPI 11 (GIC_CPU_MASK_RAW(0x3) |
+					  IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc@200000000 {
+		compatible =3D "simple-bus";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		ranges =3D <0x0 0x2 0x0 0x850000>;
+
+		gic: interrupt-controller@410000 {
+			compatible =3D "arm,gic-400";
+			reg =3D <0x410000 0x20000>,
+			      <0x420000 0x20000>,
+			      <0x440000 0x20000>,
+			      <0x460000 0x20000>;
+			#interrupt-cells =3D <3>;
+			#address-cells =3D <0>;
+			interrupt-controller;
+			interrupts =3D <GIC_PPI 9 (GIC_CPU_MASK_RAW(0x3) |
+						 IRQ_TYPE_LEVEL_LOW)>;
+		};
+
+		uart0: serial@4d0000 {
+			compatible =3D "ns16550a";
+			reg =3D <0x4d0000 0x1000>;
+			clocks =3D <&scmi_clk 59>;
+			resets =3D <&scmi_rst 59>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		uart1: serial@4e0000 {
+			compatible =3D "ns16550a";
+			reg =3D <0x4e0000 0x1000>;
+			clocks =3D <&scmi_clk 60>;
+			resets =3D <&scmi_rst 60>;
+			reg-shift =3D <2>;
+			interrupts =3D <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			status =3D "disabled";
+		};
+
+		i2c0: i2c@4f0000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x4f0000 0x1000>;
+			interrupts =3D <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 54>;
+			resets =3D <&scmi_rst 54>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c1: i2c@500000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x500000 0x1000>;
+			interrupts =3D <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 55>;
+			resets =3D <&scmi_rst 55>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c2: i2c@510000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x510000 0x1000>;
+			interrupts =3D <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 56>;
+			resets =3D <&scmi_rst 56>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c3: i2c@520000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x520000 0x1000>;
+			interrupts =3D <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 57>;
+			resets =3D <&scmi_rst 57>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		i2c4: i2c@530000 {
+			compatible =3D "snps,designware-i2c";
+			reg =3D <0x530000 0x1000>;
+			interrupts =3D <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 58>;
+			resets =3D <&scmi_rst 58>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			status =3D "disabled";
+		};
+
+		arm_cc712: crypto@550000 {
+			compatible =3D "arm,cryptocell-712-ree";
+			reg =3D <0x550000 0x1000>;
+			interrupts =3D <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+			clocks =3D <&scmi_clk 7>;
+		};
+	};
+};
--=20
2.43.0


