Return-Path: <linux-kernel+bounces-367604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2C9A0452
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920D31F28DB1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0DE1F81BA;
	Wed, 16 Oct 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="b1Nq938O"
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780CC1D88D1;
	Wed, 16 Oct 2024 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.39.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067569; cv=none; b=JSKA12+2akxaBc+K6c+UipHf2+uhhKp5hwxY9phVaDyFgUjB+PIriEB6KEmiBH8Y0T5R6DiK4JuOJbCNHPEUQ1Kge+czWqQ1QFRJl1Q83+Bsbq/hAjF93kg9n7Mx36rclfZftt7HaDTTZ8vU5M93OI9mXMji3KV4/dtzuPNEBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067569; c=relaxed/simple;
	bh=xlYrFjOfjJ9jiF7/lqgmRMyK93zvsz2UXLgJ+Q7bdVs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tteaKF9EpCa9dMD1ftSr6LoYIQkXlqZgr+vCndySweAk7HkLztgnwsduXzRJkRid32v4Q0Er8xn7SEaCVMJVYHXFLxTWQ33ibiS/bW7JRibQtlB9TPSzQnMDj9BoQ6mg+rGif5PN5OCCDsjny4wHMc4VZuRQ2Q6P0MPJVDlufVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com; spf=pass smtp.mailfrom=dh-electronics.com; dkim=pass (2048-bit key) header.d=dh-electronics.com header.i=@dh-electronics.com header.b=b1Nq938O; arc=none smtp.client-ip=188.68.39.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
	s=dhelectronicscom; t=1729067538;
	bh=xlYrFjOfjJ9jiF7/lqgmRMyK93zvsz2UXLgJ+Q7bdVs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=b1Nq938OxKwuJAMB2xIP3ev/Jn8U6LpFb42S5FUqg7g09C8dXcOuyHBP1Xl1gHy1K
	 Rxy75mpXfDJ4Jn1205KNcaBcKldbSkDBqqlBneM5QVEFOrViISTwM9Cjk+5JoBCWZ5
	 Z5RvvzesZDIY8bOO0IclGI5qJw+lqd0Qmd8mnkkQe5exprgFLm9LPJBWm5hooTIGS0
	 VIhwyDjS/izOjgDGoN7T1zBJZAy/0ymHxGmeArIG1Mt2DXB1c8RGvl68Qba5k6m3Ne
	 ot8h7iDSx7UXsLV7NxYjR0PfRtxhQ5DNQZLGL13o9hG6KmrAXsq1Zbd/0jHq26x9c2
	 F9OuWhYg+5UMg==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
CC: Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Rob Herring <robh@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, kernel
	<kernel@dh-electronics.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARM: dts: imx6qdl-dhcom-pdk2: Fill in missing panel
 power-supply
Thread-Topic: [PATCH] ARM: dts: imx6qdl-dhcom-pdk2: Fill in missing panel
 power-supply
Thread-Index: AQHbH1mGW4E1W1WjTE+GjdY2AKXI37KJDCgA
Date: Wed, 16 Oct 2024 08:32:17 +0000
Message-ID: <ba06badd3e524f7f8951802d8ebb999a@dh-electronics.com>
References: <20241015232509.101206-1-marex@denx.de>
In-Reply-To: <20241015232509.101206-1-marex@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgMTYsIDIwMjQgMToyNSBBTQ0KPiBBZGQgbWlzc2luZyBwYW5lbCBwb3dlci1zdXBwbHkgcHJv
cGVydHkgdG8gRFQgdG8gZml4IHRoZSBmb2xsb3dpbmcgd2FybmluZy4NCj4gVGhlIHBvd2VyIHN1
cHBseSBvbiB0aGlzIGRldmljZSBpcyB2ZXJ5IHNpbXBsZSBjaGFpbiBvZiByZWd1bGF0b3JzIGZy
b20gdGhlDQo+IG1haW4gMjRWIGlucHV0LCBkZXNjcmliZSB0aG9zZS4NCj4gDQo+ICINCj4gYXJj
aC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2cS1kaGNvbS1wZGsyLmR0YjogcGFuZWw6ICdwb3dl
ci1zdXBwbHknIGlzIGEgcmVxdWlyZWQNCj4gcHJvcGVydHkNCj4gIg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IC0tLQ0KPiBDYzogQ2hyaXN0b3Bo
IE5pZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tPg0KPiBDYzogQ29u
b3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPg0KPiBDYzogRmFiaW8gRXN0ZXZhbSA8ZmVz
dGV2YW1AZ21haWwuY29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJu
ZWwub3JnPg0KPiBDYzogUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0gPGtlcm5lbEBwZW5ndXRyb25p
eC5kZT4NCj4gQ2M6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+IENjOiBTYXNjaGEg
SGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3Vv
QGtlcm5lbC5vcmc+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogaW14
QGxpc3RzLmxpbnV4LmRldg0KPiBDYzoga2VybmVsQGRoLWVsZWN0cm9uaWNzLmNvbQ0KPiBDYzog
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgLi4uL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1k
aGNvbS1wZGsyLmR0c2kgIHwgMjAgKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDIwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9ueHAvaW14L2lteDZxZGwtZGhjb20tcGRrMi5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMv
bnhwL2lteC9pbXg2cWRsLWRoY29tLXBkazIuZHRzaQ0KPiBpbmRleCA3NzNmZGNmY2QwMDE1Li5k
N2MyYjMwYWVjZmQxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lt
eDZxZGwtZGhjb20tcGRrMi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgv
aW14NnFkbC1kaGNvbS1wZGsyLmR0c2kNCj4gQEAgLTE0Myw2ICsxNDMsNyBAQCBsZWQtOCB7DQo+
ICAgICAgICAgcGFuZWwgew0KPiAgICAgICAgICAgICAgICAgYmFja2xpZ2h0ID0gPCZkaXNwbGF5
X2JsPjsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZWR0LGV0bTA3MDBnMGVkaDYi
Ow0KPiArICAgICAgICAgICAgICAgcG93ZXItc3VwcGx5ID0gPCZyZWdfcGFuZWxfM3YzPjsNCj4g
DQo+ICAgICAgICAgICAgICAgICBwb3J0IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbGNk
X3BhbmVsX2luOiBlbmRwb2ludCB7DQo+IEBAIC0xNTEsNiArMTUyLDI1IEBAIGxjZF9wYW5lbF9p
bjogZW5kcG9pbnQgew0KPiAgICAgICAgICAgICAgICAgfTsNCj4gICAgICAgICB9Ow0KPiANCj4g
KyAgICAgICAvKiBGaWx0ZXJlZCBzdXBwbHkgdm9sdGFnZSAqLw0KPiArICAgICAgIHJlZ19wZGsy
XzI0djogcmVndWxhdG9yLXBkazItMjR2IHsNCj4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAicmVndWxhdG9yLWZpeGVkIjsNCj4gKyAgICAgICAgICAgICAgIHJlZ3VsYXRvci1hbHdheXMt
b247DQo+ICsgICAgICAgICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwyNDAwMDAw
MD47DQo+ICsgICAgICAgICAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyNDAwMDAw
MD47DQo+ICsgICAgICAgICAgICAgICByZWd1bGF0b3ItbmFtZSA9ICIyNFZfUERLMiI7DQo+ICsg
ICAgICAgfTsNCj4gKw0KPiArICAgICAgIC8qIDU2MC0yMDAgVTEgKi8NCj4gKyAgICAgICByZWdf
cGFuZWxfM3YzOiByZWd1bGF0b3ItcGFuZWwtM3YzIHsNCj4gKyAgICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gKyAgICAgICAgICAgICAgIHJlZ3VsYXRvci1h
bHdheXMtb247DQo+ICsgICAgICAgICAgICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwz
MzAwMDAwPjsNCj4gKyAgICAgICAgICAgICAgIHJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMz
MDAwMDA+Ow0KPiArICAgICAgICAgICAgICAgcmVndWxhdG9yLW5hbWUgPSAiM1YzX1BBTkVMIjsN
Cj4gKyAgICAgICAgICAgICAgIHZpbi1zdXBwbHkgPSA8JnJlZ19wZGsyXzI0dj47DQo+ICsgICAg
ICAgfTsNCj4gKw0KPiAgICAgICAgIHNvdW5kIHsNCj4gICAgICAgICAgICAgICAgIGF1ZGlvLWNv
ZGVjID0gPCZzZ3RsNTAwMD47DQo+ICAgICAgICAgICAgICAgICBhdWRpby1yb3V0aW5nID0NCg0K
UmV2aWV3ZWQtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0
cm9uaWNzLmNvbT4NCg==

