Return-Path: <linux-kernel+bounces-216747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAD390A5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFE261F23830
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB12E186288;
	Mon, 17 Jun 2024 06:35:00 +0000 (UTC)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C6879D3;
	Mon, 17 Jun 2024 06:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718606100; cv=fail; b=cbogDgStuMvuoSoZhXTg5NEU/GXKw8cwftUk1ZHu7IsWiEuh9JMwUplpzRqors3BxgwpRodvCfOBMFimhofAwO7UNVV23/YI/z6OyL5zTAY0NsnM2PduFqAb81tLISFsgws4GtZErEz36oK6iAUkPTCjL34z+ZWNlDp4TLkg+SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718606100; c=relaxed/simple;
	bh=l/iy4sKiVmJcm4jUXg/Z93jldfWpwrZWYWVYSjZr/5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j4tJG26ggtOOifziuWkA8hDJcyU1CA0dImOgFy1khKs3CA9QGclbazvJBH240UEe8BaBMqsBQjR6CFZGFUQ0M98eytzQp3kzTSa3oai72+aDSttRSWRe0n6NM+FPJNU0psv9sfHM7/4Z+cIZCDBbjN8hvLwsKocFJhOSc6pZc+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com; spf=pass smtp.mailfrom=wesion.com; arc=fail smtp.client-ip=40.107.117.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wesion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wesion.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTevLGDPy0CyzrK9DlJfFbMNvhbeoyLj/Omsg9D9vIToBPykynp3PuParG+YSemR/zpltEXS9EMsTNuqrCXo8c6PHWJaepHv1iAMpNW9bacF7ua6gQbKoZGEbIeNsR8HlZnW8reYc7iJlY1nPkurpOoKievAaATbfgc4zW4yDUOtA8l2Nd5OvOQJ3qJiCJgYmLteTahRSypANgrq9G2EBDx/kDdeY4msYbEiipZxgNXC1FvQLicIVKXwTswPNeQgxa5ExLpLjN+mDsuPYFA1xix30mtC01o3eZbfB7J/ZPkSD90O0m8kvN6NiiBuOTsIxLQ2Jxyja41j0Fu7rG3IcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/iy4sKiVmJcm4jUXg/Z93jldfWpwrZWYWVYSjZr/5g=;
 b=er/2t1/6BjIYYY3dIAKw56+WSys18c+X77hyq0U0dd/S2Qxh1FShhVsUwbFbkm9V/OHQo1y91KAPCwcG/3on6HVBLcY6i3izoxiv+nMaqnXKYCwzVuFYDclweOA4YQo1uCoMNWFLCfKwtYfK+fDkZOEtEjU27rfH7dPSdeJnlxim3j2l2Tc1jmI0G3dpWD1bv4w0505xXyexd2Yp/w523/NvxdLlNZK87mVwJRiIAe3f9OpLtwsWtARHf4RLVl4AyIpr+B57fG6/w623T5M2T9Y27G1m5+HoiH/QvSfMGA8CzeFYhPwJjq+NFU2aV9rX6auNGGVvQ0IDDZqyLsOjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wesion.com; dmarc=pass action=none header.from=wesion.com;
 dkim=pass header.d=wesion.com; arc=none
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com (2603:1096:400:26a::14)
 by SEYPR03MB7728.apcprd03.prod.outlook.com (2603:1096:101:14a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 06:34:56 +0000
Received: from TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0]) by TYZPR03MB7001.apcprd03.prod.outlook.com
 ([fe80::78dd:5e68:1a9c:36c0%6]) with mapi id 15.20.7677.029; Mon, 17 Jun 2024
 06:34:56 +0000
From: Jacobe Zang <jacobe.zang@wesion.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
CC: Nick Xie <nick@khadas.com>, "heiko.stuebner@cherry.de"
	<heiko.stuebner@cherry.de>, "neil.armstrong@linaro.org"
	<neil.armstrong@linaro.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>, "sre@kernel.org" <sre@kernel.org>,
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
	"andre.przywara@arm.com" <andre.przywara@arm.com>,
	"michael.riesch@wolfvision.net" <michael.riesch@wolfvision.net>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dt-bindings: vendor-prefixes: Add a pci14e4 entry
Thread-Topic: [PATCH v1] dt-bindings: vendor-prefixes: Add a pci14e4 entry
Thread-Index: AQHawF8bLtcXxiYbeUuuY9ZE+kWzTLHLfOmAgAACEAg=
Date: Mon, 17 Jun 2024 06:34:56 +0000
Message-ID:
 <TYZPR03MB70014225C6CADAC09F89741580CD2@TYZPR03MB7001.apcprd03.prod.outlook.com>
References: <20240617023517.3104427-1-jacobe.zang@wesion.com>
 <b859c506-9910-43a6-923c-2a9ee26c4f19@kernel.org>
In-Reply-To: <b859c506-9910-43a6-923c-2a9ee26c4f19@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wesion.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7001:EE_|SEYPR03MB7728:EE_
x-ms-office365-filtering-correlation-id: 2e82d5e9-b376-477a-72f4-08dc8e979a77
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?L1kxd0p6b1c3TVY4NzFjYkpGMXUrVFZrYzByZUFyVzNtZ3JVdFBURHZw?=
 =?iso-2022-jp?B?WEJZbFRweGRaM2JwUVZtVi8rK0FWM1owemZuc2NONkFqUkU1WHRjQ3Fy?=
 =?iso-2022-jp?B?dCs3Q0JxTjQvZEFSSVhLOEsxR0ZWQ29oME9JTDNla0R5NDdDWjFlS0lU?=
 =?iso-2022-jp?B?WkZhOGk5THZqS3JaYmZvcU82blNSTW0vWGtUUS9PT08vUGp5NDNwdzU0?=
 =?iso-2022-jp?B?eG5aM2lhazdLNW1VaWJUNnhOM0QxVlhQek0xOUh6RXVWeXZWQVYrT3FN?=
 =?iso-2022-jp?B?ZXFJbytNcjZaWGZnYytZRnFYeFVLK0NWS1dwMWRkWi8zdFdCeWNWTHhR?=
 =?iso-2022-jp?B?Q0krbUJIU2piUytnVDdBMEFEcG5ibDNQdVNxVDV6cDBaMnk3aC9SK2E2?=
 =?iso-2022-jp?B?RzNTbXJwZ0ovbkJzN01IZWZkMDlUQVVCenZSOFk2cVB6aFVwM3VVUktl?=
 =?iso-2022-jp?B?TWd2UzFnMVhrd0VaY3J6WVJzWCtqbkdicGZKVGc0TjNkSjFFZXU3QlFr?=
 =?iso-2022-jp?B?K2htRHBHeS9pUEQrNjhVa1pUQkVjMG90TmJuK1lvRlVPaU1mNXJpUmJB?=
 =?iso-2022-jp?B?Zkh1bUw4cjJJSkh3UjBHYXY3R2RVTFAyMmZ6b2dQd1Z1cmhlRkszbE1Z?=
 =?iso-2022-jp?B?RlN4L3YwcmhiZ3NpdjZIaXZYZnlPTFpMTnpnTXYzMzYzNlliQ3BGTDl5?=
 =?iso-2022-jp?B?dTI0QVRqaHBFTUU4c0tIYzdsRzU3YlRDUDZMblk1L0lVRVY1RGFhd29t?=
 =?iso-2022-jp?B?a0FJK2N5L0pBK3NaNE5YQXVWYWlpby82WXJCRTlSMEVYa2Ixb1JRNlVU?=
 =?iso-2022-jp?B?aTA2dVFKQnIyYXIwL3hma0Y5WlRtWkxvdVZoeFk0NE12QzVFc3hlQkFL?=
 =?iso-2022-jp?B?NTRHMmI2bmVvWmxXakZXN0RCT0x6ZFhDV01lWmVvVzVrUEs2YnJoMklE?=
 =?iso-2022-jp?B?KzVsV1BKcjRueElJaUZ2L1F3ZjhpNGtLNmcrZUdJV3RBVElqZzdhdjdm?=
 =?iso-2022-jp?B?eVlIa3FWM1UyV2d2aWdWN1MybW1iZkJSZWp5ZzBNODlNUEVoY3dRMGZW?=
 =?iso-2022-jp?B?WHV4UGpRaXFyNE9xdTFla1NMeElxTnVpQ29nN0FTK0tnR09EVFk1VExE?=
 =?iso-2022-jp?B?N3dtZkpDRzZmUEFEY1BleXFLUll3eFpkSGpGMnJPZVdhdEZDYkREZ0hW?=
 =?iso-2022-jp?B?aUYwR281bFNLR2k2SUZwMFh0UCtXbHVuNzhyY09JalFqc2FlUlZhQzlw?=
 =?iso-2022-jp?B?bjZCVDhqQmZ4QVQ0cXp3N1ovcmNqLzMrdlVUbXNxeUFnOVdabXczVTIw?=
 =?iso-2022-jp?B?NlBlZlpuZ2g3U3RSU0o3d05XNG16aC81TDFya2F5TVFFbk4zZUMzZ2Nl?=
 =?iso-2022-jp?B?bE9JV3o4cVVhOWwyeS9mbnJHaURmdC8rK0U5VGtpbnRkS1BzVEFtQ2wv?=
 =?iso-2022-jp?B?SnBDQmU1a1dUYzM1eGoxekozTGo2Qm95VXNxYWZac2FoV3Fpd3ppRlo0?=
 =?iso-2022-jp?B?Mks0MWZoOWw2ZkY0SkhKTU9Zc05GUjZtSEVpVEdoNVNyUzNkZ2w0ZXBx?=
 =?iso-2022-jp?B?RUYzVHFsSGtUc294UVYrc3QzeitocnA5MnhIMEhPMmlELytqbUw4TzFQ?=
 =?iso-2022-jp?B?UC92dGpkTE42Q2JVb1RQdVZydHZTbWFObWZJVWpKWUFIMk1zM004c25T?=
 =?iso-2022-jp?B?Rm5XZlBicG1udGVxV1ljQUdKWmNBK0hjcUVOM0xVSjcyT3BOZmtRaGMv?=
 =?iso-2022-jp?B?OFE3WllxSlJZK3YwY3QxQ1lXQ0ttaUIxckRKb29OakdqMEUwOTZMWWVN?=
 =?iso-2022-jp?B?VlRGeTIzZE9TMjl3byt2MXBmQ1F6YVRnbit1M0NGeWxYdjNlZ05TWDY1?=
 =?iso-2022-jp?B?RUErSDFsK2RML3lsQWhCejZIZ1hxam5PVGRRc1hvcnRqSnUwVU8xS0pn?=
 =?iso-2022-jp?B?M3ZsM2hxOHI5T2dMYzJvWUxTWXVPRDNBU1FGaUF3M1BSU1dDaVFYZVRl?=
 =?iso-2022-jp?B?RT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7001.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?WU1qQnlIK1ZrbWFIbXEyQ3hkRDFZZXBNVzBLQ21RL0FyMFRlZXROcmJl?=
 =?iso-2022-jp?B?aEhxNnYzeEtOcEVhU3FkOG00QzhDN3dIT3hlWk9lUklDOHBSa200VDI2?=
 =?iso-2022-jp?B?cnhkTWgzQ0cycVhXaGZLbHN4a1J1UUk1aHNEeUJVWnFETm1nTlNScG0y?=
 =?iso-2022-jp?B?R0swcm4zayt6UXkwSnFCODc2akczZ1paeGlINjcxMHBQUHBLcjNlQ0Ev?=
 =?iso-2022-jp?B?Vi9aVnc1WENsaUZndVRKZFhOalBnUFhjYWptM1Q0dHJ0aTN0MURZZFBv?=
 =?iso-2022-jp?B?MzB6OHlVNjQxdE1BVUJacDdJT0hMZ1VRZWsxVmsrVU5NSlh4Vm4vZE15?=
 =?iso-2022-jp?B?Q1NWMXlVV0ZsSzU2NG5jTHY0cDRyRnNmZEoxam92bk4vYmVUc09ZQ1pE?=
 =?iso-2022-jp?B?UVhSMXkyWm43blBGeGtreDZoNlpaSlFjSWd3ZnpGV0J6UVlNYTFvdkU5?=
 =?iso-2022-jp?B?SnViMlNnUUNyWWRGM0dyOFM2dzJhVEh1QmxQeXlOeDRkM0RwdUxoS1lW?=
 =?iso-2022-jp?B?QU9KYWNTV21mNEN0aUY2REx2a3ErYnlReFhqT0xITDRoaERuRzdFZnpO?=
 =?iso-2022-jp?B?RnNTM09ZTmIvVE9KN0M4eW1jYUNzcHJ3WmVGM2d6ZzVVaDlObnhtZldz?=
 =?iso-2022-jp?B?NTRTU0NHbElPcE1qZVl0MU5YSjJPN1QybjJCVUhQL2N2TFIvTmhFNDdY?=
 =?iso-2022-jp?B?OFlPcVliYUFqQ2FheGwvN1JDVm1MdUl2YW1xL1RKcml0S3F6S3ZLWWFW?=
 =?iso-2022-jp?B?WUtkcFdaRHVoa2UxMHdSYk9FYjZGQ1UrMnFpUVFPMkJweWdMZllWU3Mw?=
 =?iso-2022-jp?B?QUFJT1JrNFdXcDBlOFBzVDNFSjFzZlovSkI2V21rem5vVTAxR3RveHZs?=
 =?iso-2022-jp?B?VTk0ZHQyU2JhcktibW1Hb2dMZFJ3KzJHS0Q0NE8wdUI1NlpUZVJITUds?=
 =?iso-2022-jp?B?V0RBaGdxUTRZcThVbU1xcnA3dVYvSUplcG9rVHlVV1lLRVNJWDA0cy9Y?=
 =?iso-2022-jp?B?R09BNnQ5UHlrZG52NDVlUGtBTlNkb3htTkJvMG5pZktZY09HWjVpTUJO?=
 =?iso-2022-jp?B?eU5MejlBMjU3b0dNVEk1THNvb0dPeFhKTU1UVEVoK01ZQ0ZDNlhzWEli?=
 =?iso-2022-jp?B?V1VlM2xFWTNRK0UzRGFRbHRnN2p0QWdDeWxiU3ZXNjRmVGEveUE5ditk?=
 =?iso-2022-jp?B?TEdjUmJ5cUFFTnkvR0xjQ0xUdkJNVnd6ZFV5TXJieGJza2VPcFVSYXB0?=
 =?iso-2022-jp?B?d083MHJCek9nc1ZKR2tFa3FpT1dCeHpkZ0FTbHJHVVZXMCtOU20xK1U4?=
 =?iso-2022-jp?B?ZDg1SnROdEFQcVRNa0lXUzFydmZpZSt3Q1I3bHVLcU01VlQvWUJ4aEVm?=
 =?iso-2022-jp?B?Zkk2c09GOW5iNWNqaGVYMDJmSkZYaWIyTHVaQnhkOEZqZERSb1hXNlJM?=
 =?iso-2022-jp?B?LzBZZWxZa2NiRUlFZkM4N1VpeTcwTXYvOWtqMFNNRVp4RzNzUjkrWWJB?=
 =?iso-2022-jp?B?WE0vRGlpOC9reUhEbVl0OEduOGEvZUtYV01jWlpEUStFS1ZJU2dvZFZF?=
 =?iso-2022-jp?B?Qm9OcUZMa05tVjNDeWRVTTN2dWtjNCsyWHZ3c25GMVlnTnNHQmErcWJq?=
 =?iso-2022-jp?B?RFZwclBLZDdYMUtocUxIRktxQjBFbFF2K3JtSFBzamVzQXBueTBHYWJt?=
 =?iso-2022-jp?B?aFdxQjY5czFEWTYrV3hNREhLQk8wSy8wY0IwMXhtaUs5QlFNdGd3OWd0?=
 =?iso-2022-jp?B?aldNR3NOVytrUm0zUFhFb2Q4RlBwN3ZiempiREhnZ1Z2VWxnT3Z2MEhH?=
 =?iso-2022-jp?B?bWt6dFJMZVZzWEd5V1lwVk1JZXQ4Wkg4bjA3Mm05WEtHeHNOMlBWbXR6?=
 =?iso-2022-jp?B?ZUJma0RHSGhjSEtKdGpLL0JyNUkvM0t3c0N0TCtGMGpWdlM2cHhTTmpt?=
 =?iso-2022-jp?B?Vnc3RjN2MFNydVMrdXRjSkg2VXJ4YmZMMXFxcWNSV1RUVWFsdS8zKzlv?=
 =?iso-2022-jp?B?V0ZrQ1RSdEFDUklSUVZxaS9Ja1U0SGc0UXlxT0h3N0s3eTVNbWFWRlZK?=
 =?iso-2022-jp?B?aGpSeEVteEhuR01qc3pTWTR2L1FTRWJxaUt3RTk3UU5NVXBiSnZiTUZU?=
 =?iso-2022-jp?B?VFppVzRwTUt4TmYydlhmQlFMeHFkZE1ob3FodnJWZGFFc1BhVTFHUHNw?=
 =?iso-2022-jp?B?aVpkd0xMT2R6TUVLVjZzdndyNWRIWGVkdjEzaWFETURKeDhXd2ZFUzVw?=
 =?iso-2022-jp?B?OFZyYkI3dXhXWFYrbmd0UmN1c2JRUWlsamFSYUpzTXY2NG9NcmFiMTZP?=
 =?iso-2022-jp?B?d1FCZQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e82d5e9-b376-477a-72f4-08dc8e979a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 06:34:56.2103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2dc3bd76-7ac2-4780-a5b7-6c6cc6b5af9b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXLimhI3hZVPwu5YOGyQRW+N/dkr6QcFyeJ7mm9GB9/oacOTS/8zR61UtJ7ibCNtuhnH0hWPeqo65myeSFwiJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7728

> We do not document PCI or USB prefixes.=0A=
All right. So such documents only record content based on specific corporat=
ion=1B$B!)=1B(B=0A=
=0A=
---=0A=
Best Regards=0A=
Jacobe=

