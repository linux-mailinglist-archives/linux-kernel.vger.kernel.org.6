Return-Path: <linux-kernel+bounces-416489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E3D9D45CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 03:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04039284687
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7EA13A879;
	Thu, 21 Nov 2024 02:40:23 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2123.outbound.protection.partner.outlook.cn [139.219.17.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574B023099A;
	Thu, 21 Nov 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732156822; cv=fail; b=lL9EP80lreJZA5+4Qn9rwCm4ODP+UuRSHhp4YvP9/YbEWmgBLYHaLyvYWJuxKQzDUJTnXqSDk3wpYzlU/a6UV2bh0G0wjEaV7JtjITx026AXrw6vh8E3WPP+WC1kEbWhC17tWbhSAJbvdnR9mn9MC6pg9wxgIh/Hp8R/onI8wOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732156822; c=relaxed/simple;
	bh=D4u+F325OomK/+/k9NQLx5vAm3ceQdtsNx02idpvp9g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uif2rU0f0EpqgY5jiRumHgjTfovNBsx/xPBpLjc7c7aMJ2s8rwOn/GqVXHv5XzvymDVe03HhCCa4aiBlKzQu1xRZzAxkxfm5JyNdYCvdNmeRI7FECEyFvBpU1PpCYivcXxKHoxIRWx0RpRJWOG/ax/ZPRLhQsNv5p/VEx1zPluo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx+wsOhcZ0iCyJGmF8NHxyyajecRkoGHtJ8myptXRys+u92qFBgNpuKMNmsdsZ/qrWBlh0SHvjqCKtopvBOGP+7K/TDO+vumykmPekw4wA0o3JDfg8WKHmGD9Dsd5lhgTlcmxjM9I2Vk7igYWTICxg31f0+rdwepAqoQQ9+yr80gJ92Ejd+bb434n0jO36PWmjOG3WKLUobkgvWYTMHI9WTjvnO9fuGGH5zYi3Ryb4uNNo4uCEt2xP1Dfy+sNkslnaBRpJ50oS89Hl9lfi6uuQ3tmioL/DXuX2TCUXW+reEQYGN5sevjxD3Uc7b6cLL3TDy4UHOdccZLaTr34/K5Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4u+F325OomK/+/k9NQLx5vAm3ceQdtsNx02idpvp9g=;
 b=Cgia+YaTOREWBsTYnYGWq+hF4JTrekc7uCHtHiollPVk+gszTNWTK5EgkSA3thaMg3SutnMsxqQ5va+G27MOCnqfKbsbdB19PIzXgr3XWt1Ep4Ao7CZhNsjFOAcDb33dUIofnR/ymf8S0ibo8QnQXxmRmn6D9gCkJT1LG6ZKrsHw7giTQYsoVv0VwWJF5AwSjsXAztvEu3FxTTbnql6oBWIkEbUWQxxldubhJLn9QFBKivPqSw8p5h516fCwQ5twkZHjkRryXHE0zfAQK2iW2S4SlgMIrhsJ17/4Fv6a6xVaStQSrqDPcGpP6wAaSVXqAF+PrJmx6BTa/4xkJaYh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::6) by NTZPR01MB1034.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Thu, 21 Nov
 2024 02:06:20 +0000
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 ([fe80::512d:38d7:ed9f:dfbe]) by
 NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn ([fe80::512d:38d7:ed9f:dfbe%4])
 with mapi id 15.20.8158.023; Thu, 21 Nov 2024 02:06:20 +0000
From: Keith Zhao <keith.zhao@starfivetech.com>
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org"
	<rfoss@kernel.org>, "Laurent.pinchart@ideasonboard.com"
	<Laurent.pinchart@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "maarten.lankhorst@linux.intel.com"
	<maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
	<mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
	"airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"hjc@rock-chips.com" <hjc@rock-chips.com>, "heiko@sntech.de"
	<heiko@sntech.de>, "andy.yan@rock-chips.com" <andy.yan@rock-chips.com>,
	William Qiu <william.qiu@starfivetech.com>, Xingyu Wu
	<xingyu.wu@starfivetech.com>, "kernel@esmil.dk" <kernel@esmil.dk>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, Changhuang Liang
	<changhuang.liang@starfivetech.com>, Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
Thread-Topic: [PATCH v5 3/9] drm: bridge: inno-hdmi: add inno bridge driver.
Thread-Index: AQHbOxRIKgffTjzmOU62HBjB5Tje/bLAQnIAgAC1jsA=
Date: Thu, 21 Nov 2024 02:06:20 +0000
Message-ID:
 <NTZPR01MB10504FAE3695BF54DADB7B54EE22A@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
References: <20241120061848.196754-1-keith.zhao@starfivetech.com>
 <20241120061848.196754-4-keith.zhao@starfivetech.com>
 <oabm3ahd6vyeirjbbmp74w3tldqkcy3de7u6avio3ohfzfns2t@vfcvn3rl23xm>
In-Reply-To: <oabm3ahd6vyeirjbbmp74w3tldqkcy3de7u6avio3ohfzfns2t@vfcvn3rl23xm>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1050:EE_|NTZPR01MB1034:EE_
x-ms-office365-filtering-correlation-id: 8b2566f8-14b7-46c9-070a-08dd09d11792
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|41320700013|7416014|38070700018;
x-microsoft-antispam-message-info:
 LFUcj2L8ochAVc9sULL29XMycLE7a4/gzvEs9drs+Rbs9OwLu+hBU60s/AAVo5U2KBPevYhkCiDEoJbP6/K/hwrb87+TrjykFMu3xkG3qIdCNZcpOrbhHmDr407MpaSk+d5Ly8DaeJkzAodGTECWdEdcKkLIgaNlBw6P4jR6SXM2f3QbiB+spzBnJ+hwPsMXpNORjB9bkuKYSB9kfUXxZLNHjKMJ+2xlyYlr423CzyRESfKwagDvuX9/LpaSj8CGM8wrZaSgHPytQpG3i9YW1DTk2HTnQJzlGhIQpb+ZiUuTQMlQ9TvxQLpL7OM7XTTc9p/01A8EVkeAxshRa9azWFzY4NaORsafUHDMGruCOnvasvqP3jN6nwi6RL2McbbeuxZeMO8KHDp4v0iy7pUyZb12g/obnJvCxAbI3HGVKwNipFpmLU+eZFi7t6I9uvKAf3YcrzoNYfJ1mGuB99eyXSH7PqCOOoC2TmO+f0GlCcxR2Gbh1s9VpPwKkOSiPqP2GB2SFXmFr/Pi5nrIKbpL8L0bM8pdXxZ1osmWBbTe+B3+3eRP1Ps0pFP7kWEbRNJw5UTYsv357QFpR5eYc87mwGSuyFJryKiBIEPm0yTIlaL+hFIp3QzZ+gjYoRYHnDSl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWlzK3JKOVpGTTlMQXpIVm5TWmdsdDdaaFUwNzM3WWNoSms4aUV4QmR0Y0c5?=
 =?utf-8?B?OURuMHNZUGYvbVBVNjlVYldSTDBML3UyaE5NNVdIcEdiN0E0Z093UW0yeVpS?=
 =?utf-8?B?TitoMXNpc0lUYk9PUDQzdUJoYUNzQ1JjVThNTjVHOGgybWlwWFMyVjRyVjFP?=
 =?utf-8?B?dEJqeFF4MHMxQzNaZ0MzZzJEb3pRalFMM2oxTlhBN2RLblppYjJ1M1NoQU9h?=
 =?utf-8?B?MllCck5KalBxYytocWsxTG1BY1puUGtYQktrVVN0L2EwSnliNnRtYklGMTVr?=
 =?utf-8?B?U0J6ZGdTR2ZJT2FubzQyRlVBbEZ1b1I3aHJEQlBqaGlwU1dpYXplTTUzT041?=
 =?utf-8?B?cjRtdEpvUU1oWU5URnJJcGIxN04rcGxjNEZITWpKazJVVllvaTZCanl3N3FX?=
 =?utf-8?B?MGtpZGVIeEZ4VUdRRVZEZ2RrYjZ0VTdncnFCQWRHY1VxRDBsUmorVzhoaGJ1?=
 =?utf-8?B?SCtZR3RxNmlhQjhBM1ZrNVdGaDNxQTNTd3JJSFJEMkF4RzFpQlF6SWRrNUhh?=
 =?utf-8?B?bGhuaGFnU3p5ajFWTWtrWkt6aC9EaXRMZ3A2SFdaNEZ1TWllOUUwMEs3QWdR?=
 =?utf-8?B?RTYzVDlJMXYrZW1WRUlsT0ZGQlk4U2xnNWVqOEVTRE5Yb0RPdTVKK1dzWm9R?=
 =?utf-8?B?T21qdmZPNDFmMUZsZXptMEhYR1hSSDNxQzZ6VURyZGx5TXpseDUrM1YzRFJ3?=
 =?utf-8?B?R0YzVzA3R0pDZnVMeHJOUWh5WnltMU5hU3hXYlk3elp6bEV4TFhMaEpYQm1E?=
 =?utf-8?B?MEdJTGNFYS9UVHN0NFdUYi9HS1h5RDBEN2hMSVhBTXZRdXRSRFlqci90djJh?=
 =?utf-8?B?ZStSMWhKTER4QmVRU0h2b1BpR2lHa1FUMldCU3lUbDdHV0RDOUd4Z2RBbWEy?=
 =?utf-8?B?Mlp5MHFpSUIvWmg1UkF0M2xqbzR4dGFoamVjUVE4SEpxM1NjaU44alh3UTVu?=
 =?utf-8?B?S1hiNHVYRUZvWWoxaTlNUGhpZGtKZStJK0JheG5xMU5hYTdaeWl0ODczSThi?=
 =?utf-8?B?WFdWelp6eUVuMUNoc2tQby91bkIvMHlWZXVWV2VPLzFiaGxzZ2RIb01jdys2?=
 =?utf-8?B?RTk4d1JNck8rak9UNFhCSUhPZHY4NGNGdUJWSjdKdUFRdCtDRTZBcEdwei9O?=
 =?utf-8?B?NlNkV1loTnFtYzVQMHVyc2U4RmVLaDVkcEpFMjlsT25OajJ0dzVwZ1JXVU1F?=
 =?utf-8?B?aDJicG5qd2p6NDk1cVZrSmpOK0NrdmFIV2E3dUFtN2EwNGxoemRGVFRxK3Zu?=
 =?utf-8?B?MHZlR2pwbUtnRWQ1MDhNekxVaFB4VjdFaWJ1UlBYN2FnU2lSakg5VjdHUGE4?=
 =?utf-8?B?MmdVRnRmY0ZQOG5ieUl0TEcxMTFKTnlSeXd3YzFXdWxCb2hHSDF6WUpFMlBO?=
 =?utf-8?B?b3V2Y2NzeEZIckt4K1IrWmtDR3lwZC9EZ3QwdWpzT1RtY2E4SWtCcy9QQzZJ?=
 =?utf-8?B?REdlNGg1MmNVMG5PUEkwcmQreHEwQ0tKaElSWFBYeFBpazh3bm5LVVk1NkY0?=
 =?utf-8?B?K3IvNVU0NTZJeGsram84RDQyTlRRemQ3UDRwV1UzdFdJWUZvc2lTTFZzemdQ?=
 =?utf-8?B?ejdONUJ0N0EvQlJvQTQwSG5WMC9wSStyWXI1MGR1Z1dwRXZ2ZFdma1Q5WnE5?=
 =?utf-8?B?NzJJQi9UYkRLUmRYRDI3Vk9VMVZhWkNHbFJYRFFpc0ZERTN1TVFjN3EwVDN5?=
 =?utf-8?B?RlRwYmRML01oK3NPQURVSmhyMitoaHM1SWZ5RHhpbldDUCtTT0IreVB6SXhP?=
 =?utf-8?B?OGs5cmo4ZHRGeFZoR0hBUzgrb05FMjg4akNBT3hxNGlPMU5USU9jZmZTbjhs?=
 =?utf-8?B?MnZRSi9JMmZOQTZzMmszbmtvK3VGRDJXQi9BOFJDbTlpcWZkUnJUaDBNV0tt?=
 =?utf-8?B?NjFhS2xORmVpQ1lLZGlOM2J4S1FrdzR3alB4L2xpLzVYYWdOQmZ6MHhCWTc0?=
 =?utf-8?B?VCtDZVVGSVErSFJUMkpTdy9OelZmL0xRZUhIQnlMTmdtdkk5aVN5Mm83eDF1?=
 =?utf-8?B?K1BmSDlURjdUVzhNUmZYQm85VjUrODFCZE1PWEtxQmQyZmdRcU5WengrNFls?=
 =?utf-8?B?cU53eFVSWnRUenlJSG9uemQzelNodmtBTlR0amswc0JWaXVuS1R5bHFMeGlo?=
 =?utf-8?B?ejhQZjNsVVlFc0xSTVNValIrc0RaVkV1WkJsTTZTUllBSXdyRzhVUkplMllp?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2566f8-14b7-46c9-070a-08dd09d11792
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2024 02:06:20.4504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jnjeDY4/gJZAxzwlj1YQeFkXLKyTGlfzm0aSv3s7KC5PcXA9/I/Fbj58avTaPmLp8MLZ8tFx2Iw7LXXxitkzi9A+D7Upr/YZb3ii1cdR+NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1034

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHUua2xlaW5lLWtvZW5pZ0BiYXlsaWJyZS5jb20+DQo+IFNlbnQ6IDIwMjTlubQxMeaciDIw
5pelIDIyOjU2DQo+IFRvOiBLZWl0aCBaaGFvIDxrZWl0aC56aGFvQHN0YXJmaXZldGVjaC5jb20+
DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZzsNCj4gYW5kcnplai5oYWpkYUBpbnRlbC5jb207IG5laWwuYXJtc3Ryb25nQGxp
bmFyby5vcmc7IHJmb3NzQGtlcm5lbC5vcmc7DQo+IExhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJv
YXJkLmNvbTsgamVybmVqLnNrcmFiZWNAZ21haWwuY29tOw0KPiBtYWFydGVuLmxhbmtob3JzdEBs
aW51eC5pbnRlbC5jb207IG1yaXBhcmRAa2VybmVsLm9yZzsNCj4gdHppbW1lcm1hbm5Ac3VzZS5k
ZTsgYWlybGllZEBnbWFpbC5jb207IHNpbW9uYUBmZndsbC5jaDsNCj4gcm9iaEBrZXJuZWwub3Jn
OyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGhqY0Byb2NrLWNo
aXBzLmNvbTsgaGVpa29Ac250ZWNoLmRlOyBhbmR5LnlhbkByb2NrLWNoaXBzLmNvbTsgV2lsbGlh
bSBRaXUNCj4gPHdpbGxpYW0ucWl1QHN0YXJmaXZldGVjaC5jb20+OyBYaW5neXUgV3UgPHhpbmd5
dS53dUBzdGFyZml2ZXRlY2guY29tPjsNCj4ga2VybmVsQGVzbWlsLmRrOyBwYXVsLndhbG1zbGV5
QHNpZml2ZS5jb207IHBhbG1lckBkYWJiZWx0LmNvbTsNCj4gYW91QGVlY3MuYmVya2VsZXkuZWR1
OyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBDaGFuZ2h1YW5nIExpYW5nDQo+IDxjaGFuZ2h1YW5n
LmxpYW5nQHN0YXJmaXZldGVjaC5jb20+OyBKYWNrIFpodSA8amFjay56aHVAc3RhcmZpdmV0ZWNo
LmNvbT47DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NSAzLzldIGRybTogYnJpZGdlOiBpbm5vLWhkbWk6IGFkZCBpbm5vIGJyaWRnZSBkcml2
ZXIuDQo+IA0KPiBIZWxsbywNCj4gDQo+IE9uIFdlZCwgTm92IDIwLCAyMDI0IGF0IDAyOjE4OjQy
UE0gKzA4MDAsIGtlaXRoIHpoYW8gd3JvdGU6DQo+ID4gK3N0cnVjdCBwbGF0Zm9ybV9kcml2ZXIg
aW5ub19oZG1pX2RyaXZlciA9IHsNCj4gPiArCS5wcm9iZSAgPSBpbm5vX2hkbWlfcm9ja2NoaXBf
cHJvYmUsDQo+ID4gKwkucmVtb3ZlX25ldyA9IGlubm9faGRtaV9yb2NrY2hpcF9yZW1vdmUsDQo+
IA0KPiBQbGVhc2UgdXNlIC5yZW1vdmUgaW5zdGVhZCBvZiAucmVtb3ZlX25ldy4NCj4gDQpUaGFu
ayB5b3UgZm9yIHRoZSBjbGFyaWZpY2F0aW9uIHJlZ2FyZGluZyAucmVtb3ZlX25ldy4gDQpJIHVu
ZGVyc3RhbmQgdGhhdCBpdCdzIGEgcmVsaWMgYW5kIHRoYXQgbmV3IGRyaXZlcnMgc2hvdWxkIGlt
cGxlbWVudCAucmVtb3ZlKCkuDQoNCkkgaGF2ZSBhIHF1ZXN0aW9uLiBPbmUgb2YgdGhlIGNoYW5n
ZXMgaW4gdGhpcyBwYXRjaCBpcyB0byByZW5hbWUgc29tZSBmdW5jdGlvbiBpbnRlcmZhY2VzLiAN
ClRoZSBvcmlnaW5hbCBjb2RlIGlzIGxpa2UgdGhpcy4gDQoNCnN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgaW5ub19oZG1pX2RyaXZlciA9IHsNCgkucHJvYmUgID0gaW5ub19oZG1pX3Byb2JlLA0KCS5y
ZW1vdmVfbmV3ID0gaW5ub19oZG1pX3JlbW92ZSwNCgkuZHJpdmVyID0gew0KCQkubmFtZSA9ICJp
bm5vaGRtaS1yb2NrY2hpcCIsDQoJCS5vZl9tYXRjaF90YWJsZSA9IGlubm9faGRtaV9kdF9pZHMs
DQoJfSwNCn07DQoNClJlbmFtZSBpbm5vX2hkbWlfcHJvYmUgYW5kIGlubm9faGRtaV9yZW1vdmUN
CnN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgaW5ub19oZG1pX2RyaXZlciA9IHsNCgkucHJvYmUgID0g
aW5ub19oZG1pX3JvY2tjaGlwX3Byb2JlLA0KCS5yZW1vdmVfbmV3ID0gaW5ub19oZG1pX3JvY2tj
aGlwX3JlbW92ZSwNCgkuZHJpdmVyID0gew0KCQkubmFtZSA9ICJpbm5vaGRtaS1yb2NrY2hpcCIs
DQoJCS5vZl9tYXRjaF90YWJsZSA9IGlubm9faGRtaV9kdF9pZHMsDQoJfSwNCn07DQpCYXNlZCBv
biB0aGUgcHJpbmNpcGxlIG9mIG1haW50YWluaW5nIGNvbnNpc3RlbmN5LCANCmRvZXMgaXQocmVt
b3ZlX25ldykgbmVlZCB0byBiZSBjaGFuZ2VkPw0KDQpUaGFua3MNCg0KPiBCZXN0IHJlZ2FyZHMN
Cj4gVXdlDQo=

