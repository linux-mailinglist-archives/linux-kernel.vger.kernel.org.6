Return-Path: <linux-kernel+bounces-181803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D887F8C8194
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 160951C21199
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 07:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEFD17C72;
	Fri, 17 May 2024 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="dtmJoL0N"
Received: from forward500c.mail.yandex.net (forward500c.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915B7175BF;
	Fri, 17 May 2024 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931662; cv=none; b=SCHjlgRTd5o/iXVY7FgIJx0DNIPVc5UAlppaQ1D/r4BhY5ETErWzfUn/QqRYB0NeD6+IZd6wDh32aAgelFLJQDETErHyq8PNQl6vO5qNRPqQ+5SwUyiJquBDqYQfGHLIhKGW1cUDYsXETd6C0UxkyxFOCgnoJ7/zDA7GNAtVh6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931662; c=relaxed/simple;
	bh=J97GZRaSqLPWbPf3+YaWORGJ0+sSFLi/U4nH7DMccVc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fakw1S2ePA6/0tdZDgZ9ROsCcDT0OnrGn/TE9fqUvXyM5qsms/lX1E5UHyf7meUoMjmHutcX63ccGaiLdjl3AQ0Ks6MbtxyxDLXxTvf/W4jq7ebnXxgOX+IWyWGkr7CF0uk62VtdGWrk68XGKXVnAnPQMjv34oxOqDJp2f8LgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=dtmJoL0N; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:f220:0:640:b85:0])
	by forward500c.mail.yandex.net (Yandex) with ESMTPS id 6142060B37;
	Fri, 17 May 2024 10:39:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Kd93B89oEuQ0-PILK6Det;
	Fri, 17 May 2024 10:39:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1715931561; bh=J97GZRaSqLPWbPf3+YaWORGJ0+sSFLi/U4nH7DMccVc=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=dtmJoL0NgdGVNE6UEfieFdmPOp47XOUlKja8M2BM2N7iLZCzCvGy53f9eJ4Fe+QGG
	 mmTII9p01rktX9DXZ+fknVs2i3NdzI+XhNXAGs7jRu5pABUweSh4Gh+Sp9n44xBA/m
	 Xlf+dQFU67wE+iBFQUVoH0Nyg14hmtfLG5Mezp2E=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.sas.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <96df565e5821b5dc2b777cba21964d3c0c221983.camel@maquefel.me>
Subject: Re: [PATCH RESEND v2 0/4] DONOTMERGE: ep93xx-clk from ep93xx device
 tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij
 <linus.walleij@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Michael Turquette
 <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Alexander Sverdlin <alexander.sverdlin@gmail.com>
Date: Fri, 17 May 2024 10:39:21 +0300
In-Reply-To: <20240408-ep93xx-clk-v2-0-adcd68c13753@maquefel.me>
References: <20240408-ep93xx-clk-v2-0-adcd68c13753@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gU3RlcGhlbiEKCkEgZ2VudGxlIHJlbWFpbmRlciwgY2FuIGkgaG9wZSB5b3UnbGwgbG9v
ayBpbnRvIG15IGNoYW5nZXMgZm9yIHYyID8KCk9uIE1vbiwgMjAyNC0wNS0wNiBhdCAxMjo0OSAr
MDMwMCwgTmlraXRhIFNodWJpbiB2aWEgQjQgUmVsYXkgd3JvdGU6Cj4gVGhlIGdvYWwgaXMgdG8g
cmVjaWV2ZSBBQ0tzLgo+IAo+IFRoaXMgaXMgYSBmcmFjdGlvbiBvZiB2OSAiZXA5M3h4IGRldmlj
ZSB0cmVlIGNvbnZlcnNpb24iIHNlcmllczoKPiAKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyNDAzMjYtZXA5M3h4LXY5LTAtMTU2ZTJhZTVkZmM4QG1hcXVlZmVsLm1lLwo+IAo+IFRo
ZSBjbGsgZHJpdmVyIGZvciBlcDkzeHggd2FzIGNvbnZlcnRlZCB0byBBVVggZGV2aWNlLCBhcyBz
dWdnZXN0ZWQKPiBvcmlnaW5hbGx5IGJ5IFN0ZXBoZW4gQm95ZC4KPiAKPiBTaWduZWQtb2ZmLWJ5
OiBOaWtpdGEgU2h1YmluIDxuaWtpdGEuc2h1YmluQG1hcXVlZmVsLm1lPgo+IC0tLQo+IENoYW5n
ZXMgaW4gdjI6Cj4gLSBzb2M6IEFkZCBTb0MgZHJpdmVyIGZvciBDaXJydXMgZXA5M3h4Ogo+IMKg
IC0gYWRkZWQgX19pbml0IGZvciBlcDkzeHhfYWRldl9hbGxvYygpLAo+IGVwOTN4eF9jb250cm9s
bGVyX3JlZ2lzdGVyKCkKPiDCoCAtIGFkZGVkIHN0YXRpYywgX19pbml0Y29uc3QgZm9yIHBpbmN0
cmxfbmFtZXNbXQo+IMKgIC0gY2xrIHJldmlzaW9uIGZvciBTUEkgaXMgbm93IHJlc29sdmVkIGhl
cmUgdGhyb3VnaCBkaWZmZXJlbnRseQo+IG5hbWVkCj4gwqDCoMKgIGNsayBkZXZpY2UKPiDCoCAt
IG1vcmUgdmVyYm9zZSBLY29uZmlnIGRlc2NyaXB0aW9uCj4gCj4gwqAgTk9URTogIm9mIiBpbmNs
dWRlcyBhcmUgcmVxdWlyZWQgdW5mb3J0dW5hdGVseS4KPiAKPiAtIGNsazogZXA5M3h4OiBhZGQg
RFQgc3VwcG9ydCBmb3IgQ2lycnVzIEVQOTN4eDoKPiDCoCAtIGRyb3BwZWQgaW5jbHVkZXMKPiDC
oCAtIGRyb3BwZWQgZXA5M3h4X3NvY190YWJsZVtdCj4gwqAgLSBhZGQgZGlmZmVyZW50IG5hbWVk
IGNsayBhbmQgZHJvcHBlZCBpbnZvbHZlZCBpbmNsdWRlcwo+IMKgIC0gbW92ZWQgcGxsJ3MgYW5k
IGZjbGssIGhjbGssIHBjbGsgaW5pdCB0byBzZXBhcmF0ZSBmdW5jdGlvbgo+IMKgIC0gZml4ZWQg
ZXA5M3h4X2Nsa19pZHNbXSBleHBsaWNpdCBsaW5lcwo+IAo+IMKgIE5PVEU6IGNsa19od19yZWdp
c3Rlcl9kaXYoKSBpcyBjbGstZXA5eHggaW50ZXJuYWwgZnVuY3Rpb24gd2hpY2gKPiB1c2VzCj4g
wqAgZGV2bS4KPiAKPiAtLS0KPiBOaWtpdGEgU2h1YmluICg0KToKPiDCoMKgwqDCoMKgIEFSTTog
ZXA5M3h4OiBhZGQgcmVnbWFwIGF1eF9kZXYKPiDCoMKgwqDCoMKgIGNsazogZXA5M3h4OiBhZGQg
RFQgc3VwcG9ydCBmb3IgQ2lycnVzIEVQOTN4eAo+IMKgwqDCoMKgwqAgZHQtYmluZGluZ3M6IHNv
YzogQWRkIENpcnJ1cyBFUDkzeHgKPiDCoMKgwqDCoMKgIHNvYzogQWRkIFNvQyBkcml2ZXIgZm9y
IENpcnJ1cyBlcDkzeHgKPiAKPiDCoC4uLi9iaW5kaW5ncy9hcm0vY2lycnVzL2NpcnJ1cyxlcDkz
MDEueWFtbMKgwqDCoMKgwqDCoMKgwqAgfMKgIDM4ICsKPiDCoC4uLi9iaW5kaW5ncy9zb2MvY2ly
cnVzL2NpcnJ1cyxlcDkzMDEtc3lzY29uLnlhbWzCoCB8wqAgOTQgKysrCj4gwqBkcml2ZXJzL2Ns
ay9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgwqAgOCArCj4gwqBkcml2ZXJzL2Nsay9NYWtlZmlsZcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCAxICsKPiDCoGRyaXZlcnMvY2xrL2Nsay1lcDkzeHguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA4MzQKPiArKysrKysrKysrKysrKysrKysr
KysKPiDCoGRyaXZlcnMvc29jL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiDCoGRyaXZlcnMvc29j
L01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgIDEgKwo+IMKgZHJpdmVycy9zb2MvY2lycnVzL0tjb25maWfCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDE3ICsKPiDC
oGRyaXZlcnMvc29jL2NpcnJ1cy9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArCj4gwqBkcml2ZXJzL3NvYy9jaXJydXMvc29jLWVw
OTN4eC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAyNTIgKysrKysr
Kwo+IMKgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9jaXJydXMsZXA5MzAxLXN5c2Nvbi5owqDC
oCB8wqAgNDYgKysKPiDCoGluY2x1ZGUvbGludXgvc29jL2NpcnJ1cy9lcDkzeHguaMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI2ICsKPiDCoDEyIGZpbGVzIGNoYW5nZWQs
IDEzMjAgaW5zZXJ0aW9ucygrKQo+IC0tLQo+IGJhc2UtY29tbWl0OiBmZWM1MGRiNzAzM2VhNDc4
NzczYjE1OWUwZTJlZmIxMzUyNzBlM2I3Cj4gY2hhbmdlLWlkOiAyMDI0MDQwOC1lcDkzeHgtY2xr
LTY1N2ExMzU3ZGU2Nwo+IAo+IEJlc3QgcmVnYXJkcywKCg==


