Return-Path: <linux-kernel+bounces-228582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9179161E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928C91F21568
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE5149015;
	Tue, 25 Jun 2024 09:06:53 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2096.outbound.protection.partner.outlook.cn [139.219.146.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2E8146587;
	Tue, 25 Jun 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306412; cv=fail; b=n6X66Wko33rkq8HfLvz7I7csXNjtiVU9sWq7Q3JdkDBhypQDWyWm0klhVR5/bfY7aYUVu+FjhoVgkUKxuzRcKe1kBrWjai6v7cUJrh8BUQ7swjwc0HYo1vRux+c+nxhwwmZ+0vBe5vB/9QSX3kN2yTog37uwIF5Rjr7DEFzZotM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306412; c=relaxed/simple;
	bh=2siEcTXuu/LyATTwbYVft7kTk6dB2s5EiiDTvCrywbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ne2asIX3xubWTYaIuRlhnrlSZfvvyOsmMVLXsUlMpeymfk8X7bxAB54z12kvoqBQyNKRg46OStjs8e28AEAXn8j/a0YYFOjCUF+oHL+SiBgyz2rLL64dlr+W+nvBs9Ow2P+SCbaoiRKiLb310ba3Z3rbyNZhZ/kaEdbHFoEkhV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpGJ3f0BV8IjCgetu/dHW65bTelI1CQPV3VM/IgvR1q9V7pdP6f2b2c/Yx+TcXsJH9bst5lVsbfPcJ+jWQ+GGQUUz9uZCPUFOYCEQKap4ydQkETxm0gQcM0SGVx9np+4Q1K6yBwEM+jykCeifMZJJrAzobJDOb9rpClr2Ar+WYHueG5UOMhj9aJQj1sfXloecO1CfEC63FslS/Jru42RT37ss7Fy1Zjovk2LAUl1vUrSLo6lr3xwmBjmOhtPukxn1xS1OXMVJavbQie+nURaJwEnrNiJVzPGU+sKsjF+/Jy808wi2Wy1W2vpdLFEk9+idI9a9k+rU1T93OLrgy8NAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2siEcTXuu/LyATTwbYVft7kTk6dB2s5EiiDTvCrywbA=;
 b=X8T9S6wEaidxsutnv2RfUgAzxNfcOp+BVs2hpbEVNvTrNn6nxrFnSm3eC/cXsuB0PtjH9rgSj+GiHJMAy9G5pamJs9Wn4EF3zx6yYFzXkKPLU9A8cj4rm5YEb4KJocupHqpg0O48WCGxObkKydVgzl/J0zUiaR7omfdUF+7W+V+iNfhINg3Z/Ly1AaK0bT3+SD1Q/GMXr9xEXJSDTylNxiQzrZrz7m3xVwwzf4xqlZdJjzcu9eQgvJbHTZ74X9irhkmFqq3nxwiht933o44U56nOierqo1DEPSrMgpPOXNBr/IUVrKQmetO4UZnU4DV/jOx0QfZZktgr3vTADr2hPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::6) by NTZPR01MB1116.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.33; Tue, 25 Jun
 2024 08:33:48 +0000
Received: from NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn
 ([fe80::47b8:45b2:ce25:9c34]) by
 NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn ([fe80::47b8:45b2:ce25:9c34%3])
 with mapi id 15.20.7698.025; Tue, 25 Jun 2024 08:33:48 +0000
From: Keith Zhao <keith.zhao@starfivetech.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, "rfoss@kernel.org"
	<rfoss@kernel.org>, "Laurent.pinchart@ideasonboard.com"
	<Laurent.pinchart@ideasonboard.com>, "jonas@kwiboo.se" <jonas@kwiboo.se>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
	<tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "hjc@rock-chips.com" <hjc@rock-chips.com>,
	"heiko@sntech.de" <heiko@sntech.de>, "andy.yan@rock-chips.com"
	<andy.yan@rock-chips.com>, Xingyu Wu <xingyu.wu@starfivetech.com>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, Jack Zhu
	<jack.zhu@starfivetech.com>, Shengyang Chen
	<shengyang.chen@starfivetech.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 10/10] drm/vs: add simple dsi encoder
Thread-Topic: [PATCH v4 10/10] drm/vs: add simple dsi encoder
Thread-Index: AQHaqyrGV+ye8sgVJ0qNRk+aFsF4qrGhz8MAgDNBWACAAPxNAIACIhZw
Date: Tue, 25 Jun 2024 08:33:48 +0000
Message-ID:
 <NTZPR01MB1050B4B8FA6F36267A1DBB01EED52@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
References: <20240521105817.3301-1-keith.zhao@starfivetech.com>
 <20240521105817.3301-11-keith.zhao@starfivetech.com>
 <cej2d72e6bacbjabyjecoqhjlhz4sxx4bgn2w43rgl3cfyyuwt@jq5kq4egj2wo>
 <NTZPR01MB1050AA3ABA20F736B1756E04EECB2@NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn>
 <b7cgvgh3uphpa3byf3bdl5i4fr64zzuagxg5txuwx7woy56dkt@uhclfjtzejfc>
In-Reply-To: <b7cgvgh3uphpa3byf3bdl5i4fr64zzuagxg5txuwx7woy56dkt@uhclfjtzejfc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB1050:EE_|NTZPR01MB1116:EE_
x-ms-office365-filtering-correlation-id: 867f7cdc-d923-461e-e27f-08dc94f18900
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230037|7416011|41320700010|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 5T4n7RCck1m3Sw4CtPHe2pW50/FuaBVyHDDKp5erfvTWJ81lgFB1g7BTxx/VFiydw1gmJpZ/7ragIXBdQ6/KUPrYaTgD8ag88iS0N0mCdCcmQ6cswyAiSeS05L18AEYupBuIPpNiR4vRrUSyJmj5PbQRjvOxVgCtLKf3OzpuJN2JupgWN1hIocZHJNqRx43iP/ffq4Eor0hE9GfIJN4qsRzPduJJfHHPuvtOzqMn/KyC4Uy1ID5rR485rR5GLxrpiWErebmiVUa4xssNzt7j1/4aCn0xQQW39TQsAXfXyi443y2MzQnh21tHjBSCKBhFBUM+ENUnHdIxawOvHLTqnpICmJsLvmDbgeALNswXzUaxtNjG0ccN4dlupuoP+qDPFtnEY1AI9oobXge0v2jhYu4CLwwU2kLpakEI99D5AqcNMininel91A5OFchfqoTQKO40cthHjB3Hepi6yK111MOm3BgzDA1EZcjmmx7YYMZR70HSIsXmNlaiV4BZiAXX3MUnYfeci3Uj5NTH4xskqam+NeUX9CFLFjArBtDh+8v55SmAQMYjTK+1o0hHfttprmu7XQtimXC1dJ2Ohum1sZC9X09rBL4UQYLzsT8l3ns8Fn/CQ7/PwJOeDZuvMZs0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1050.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230037)(7416011)(41320700010)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 0a5W1oEJty/HaX08v8s2B4QzVom+EA6DmYZQKmAgF2wfcQqBhytkuSTLzCfsO2dTtPAr2Jdtl1xnd5Na6phJu/lajraVXB0qxR08/G/Pz7ynvXf88AHd/WIRib7wj0HB7q7Vv4RMgIo9n71BH1gbXAW4Z5JJG8cU+jVmMS1UfDr0gnhfyN/uWvyQpOyBFJA/cqETpBMXjLbJ5/OFyd4n5errf5rYPaVChIUJzrMej2Cf9cUsfo4rN58Cx1mZKJvF9FGdMXM4JRsKDqp+bOzHAxRO20M3YEfRp4DXAwyt+K90htKxvpgnkuNUyvUYVFNeVp7BnRwi68l5WywcNHgKYdrW3yeM+ntnO1UAKIEo99Bm5fKXESrO09UmC7dg+zCqm6ioRnIXmp3mYZoroZvBZ0fA5f0GbCkLwe1yYyeUU4Y=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 867f7cdc-d923-461e-e27f-08dc94f18900
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 08:33:48.6239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifcFQOJMElYN/Vh9umwfijm1J7oOR58L+kuoimcEeDeJZnPshbIF/LuKhIBJXymGJ3oDLBHHtKcnpfRhNZKvpSP9pP1bSPaiCwrpjKKx9HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1116

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRG1pdHJ5IEJhcnlzaGtv
diA8ZG1pdHJ5LmJhcnlzaGtvdkBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI0xOo21MIyNMjVIDU6
MTENCj4gVG86IEtlaXRoIFpoYW8gPGtlaXRoLnpoYW9Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gQ2M6
IGFuZHJ6ZWouaGFqZGFAaW50ZWwuY29tOyBuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnOyByZm9z
c0BrZXJuZWwub3JnOw0KPiBMYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb207IGpvbmFz
QGt3aWJvby5zZTsNCj4gamVybmVqLnNrcmFiZWNAZ21haWwuY29tOyBtYWFydGVuLmxhbmtob3Jz
dEBsaW51eC5pbnRlbC5jb207DQo+IG1yaXBhcmRAa2VybmVsLm9yZzsgdHppbW1lcm1hbm5Ac3Vz
ZS5kZTsgYWlybGllZEBnbWFpbC5jb207DQo+IGRhbmllbEBmZndsbC5jaDsgcm9iaEBrZXJuZWwu
b3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IGhqY0Byb2Nr
LWNoaXBzLmNvbTsgaGVpa29Ac250ZWNoLmRlOyBhbmR5LnlhbkByb2NrLWNoaXBzLmNvbTsgWGlu
Z3l1IFd1DQo+IDx4aW5neXUud3VAc3RhcmZpdmV0ZWNoLmNvbT47IHAuemFiZWxAcGVuZ3V0cm9u
aXguZGU7IEphY2sgWmh1DQo+IDxqYWNrLnpodUBzdGFyZml2ZXRlY2guY29tPjsgU2hlbmd5YW5n
IENoZW4NCj4gPHNoZW5neWFuZy5jaGVuQHN0YXJmaXZldGVjaC5jb20+OyBkcmktZGV2ZWxAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTAvMTBdIGRybS92czogYWRkIHNpbXBs
ZSBkc2kgZW5jb2Rlcg0KPiANCj4gT24gU3VuLCBKdW4gMjMsIDIwMjQgYXQgMDc6MTc6MDlBTSBH
TVQsIEtlaXRoIFpoYW8gd3JvdGU6DQo+ID4gSGkgRG1pdHJ5Og0KPiA+DQo+ID4gPiBPbiBUdWUs
IE1heSAyMSwgMjAyNCBhdCAwNjo1ODoxN1BNICswODAwLCBrZWl0aCB3cm90ZToNCj4gDQo+ID4g
PiA+ICsJCQkJCQkJCSAgInN0YXJmaXZlLHN5c2NvbiIsDQo+ID4gPiA+ICsJCQkJCQkJCSAgMiwg
YXJncyk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlpZiAoSVNfRVJSKHNpbXBsZS0+ZHNzX3JlZ21h
cCkpIHsNCj4gPiA+ID4gKwkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBQVFJfRVJSKHNpbXBs
ZS0+ZHNzX3JlZ21hcCksDQo+ID4gPiA+ICsJCQkJICAgICAiZ2V0dGluZyB0aGUgcmVnbWFwIGZh
aWxlZFxuIik7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICsJc2ltcGxlLT5vZmZz
ZXQgPSBhcmdzWzBdOw0KPiA+ID4gPiArCXNpbXBsZS0+bWFzayA9IGFyZ3NbMV07DQo+ID4gPg0K
PiA+ID4gSXMgdGhlIHZhbHVlIHRoYXQgeW91J3ZlIHJlYWQgcGxhdGZvcm0gZGVwZW5kZW50IG9y
IHVzZSBjYXNlIGRlcGVuZGVudD8NCj4gPiA+IFdoYXQgaXMgdGhlIGFjdHVhbCB2YWx1ZSBiZWlu
ZyB3cml0dGVuPyBXaHkgYXJlIHlvdSB1c2luZyBzeXNjb24gZm9yIGl0Pw0KPiA+DQo+ID4gVGhl
IHN5c2NvbiBpcyB1c2VkIHRvIHNlbGVjdCBjcnRjcyBiaW5kZWQgd2l0aCBlbmNvZGVyLCBJZiB0
aGlzDQo+ID4gZW5jb2RlciBiaW5kcyB0byBjcnRjMCAsIHNldCB0aGUgc3lzY29uIHJlZyBiaXQw
ID0gMSBJZiB0aGlzIGVuY29kZXINCj4gPiBiaW5kcyB0byBjcnRjMSAsIHNldCB0aGUgc3lzY29u
IHJlZyBiaXQxID0gMSAoMHgyKSBNYXliZSBJIGNhbiBkbyB0aGlzDQo+ID4gYnkgdGhlIHBvc3Np
YmxlX2NydGMgaW5zdGVhZCBvZiB1c2luZyBhcmdzIGZyb20gZHRzDQo+IA0KPiBJZiB0aGlzIGlz
IGEgY29uc3RhbnQgYmV0d2VlbiB5b3VyIHBsYXRmb3JtcywgaXQgc2hvdWxkIG5vdCBiZSBhIHBh
cnQgb2YgRFQuDQo+IA0KPiA+DQo+ID4NCj4gPiA+DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZXR1
cm4gMDsNCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiArc3RhdGljIHZvaWQgdnNfZW5j
b2Rlcl9hdG9taWNfZW5hYmxlKHN0cnVjdCBkcm1fZW5jb2RlciAqZW5jb2RlciwNCj4gPiA+ID4g
K3N0cnVjdCBkcm1fYXRvbWljX3N0YXRlICpzdGF0ZSkgew0KPiA+ID4gPiArCXN0cnVjdCB2c19z
aW1wbGVfZW5jb2RlciAqc2ltcGxlID0gdG9fc2ltcGxlX2VuY29kZXIoZW5jb2Rlcik7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwlyZWdtYXBfdXBkYXRlX2JpdHMoc2ltcGxlLT5kc3NfcmVnbWFwLCBz
aW1wbGUtPm9mZnNldCwNCj4gPiA+ID4gK3NpbXBsZS0+bWFzaywNCj4gPiA+ID4gK3NpbXBsZS0+
bWFzayk7DQo+ID4gPg0KPiA+ID4NCj4gPiA+IEEgcHVyaXN0IGluIG1lIHdvdWxkIGFzayB0byBo
YXZlIHNlcGFyYXRlIG1hc2sgYW5kIHZhbHVlIHRvIHdyaXRlLg0KPiA+IFVuZGVyc3RhbmQgLCB3
aWxsIGF2b2lkIHRoaXMgYWN0aW9uDQo+ID4gPg0KPiA+ID4gPiArfQ0KPiA+ID4NCj4gPiA+IElz
IGl0IG5lY2Vzc2FyeSB0byBjbGVhciB0aG9zZSBiaXRzIHdoZW4gc3RvcHBpbmcgdGhlIHN0cmVh
bT8NCj4gPiBObyBuZWVkIHRvIGRvIHRoaXMgLCBpZiBjbGVhciB0aG9zZSBiaXRzICwgdGhlIGVu
Y29kZXIgd2lsbCBwb2ludCB0byBhDQo+ID4gdW5rbm93biBjcnRjDQo+IA0KPiB3aGF0IGFyZSB0
aGUgY29uc2VxdWVuY2VzPyBJcyBpdCBkZXNpcmFibGUgb3Igbm90Pw0KVGhlcmUgYXJlIHR3byBj
cnRjcy4NCkVhY2ggZGlzcGxheSB0ZXJtaW5hbCBlbmNvZGVyIGNhbiBjb21iaW5lIGFueSBjcnRj
LCBkZXBlbmRpbmcgb24gdGhlIHZhbHVlIG9mIHBvc3NpYmxlIGNydGMuDQpXaGVuIHRoZSBiaXQg
aXMgMCwgaXQgbWVhbnMgdGhhdCB0aGUgZW5jb2RlciBtYXRjaGVzIGNydGMwLg0KV2hlbiB0aGUg
Yml0IGlzIDEsIGl0IG1lYW5zIHRoYXQgdGhlIGVuY29kZXIgbWF0Y2hlcyBjcnRjMS4NClRoZSBw
b3NzaWJsZSBjcnRjIG9mIHRoaXMgZW5jb2RlciBpcyAyICwgdGhlIHJlZyBiaXQgaXMgMS4gICAg
DQpXaGVuIHRoZSB2aWRlbyBzdHJlYW0gaXMgc3RvcHBlZCwgaWYgdGhlIGJpdCBpcyBjbGVhcmVk
LCB0aGUgcmVzdWx0IGlzIHRoYXQgdGhlIGVuY29kZXIgaGFyZHdhcmUgcG9pbnRzIHRvIGNydGMw
LCANCmFuZCB0aGUgZW5jb2RlciBwb2ludHMgdG8gY3J0YzEgYmFzZWQgb24gdGhlIGRybSBmcmFt
ZXdvcmsoYmVjYXVzZSB0aGUgcG9zc2libGUgY3J0YyBubyBjaGFuZ2UpLg0KDQo+IA0KPiAtLQ0K
PiBXaXRoIGJlc3Qgd2lzaGVzDQo+IERtaXRyeQ0K

