Return-Path: <linux-kernel+bounces-195375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6691D8D4BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2153228206A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3E917F508;
	Thu, 30 May 2024 12:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="X/mOYUJ9"
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D6013211A;
	Thu, 30 May 2024 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717072569; cv=none; b=r9TKcR4EHMdoAVyKDYoTHTQUXcWhaxtvFOhSnLhB7PKdHgsJQxx2d/nEvjFmccIHGL7/vt/nVUh43qEJFdRBfkFZMFUcTsSSVJ7DHSefd6Cxz7M3TyvozB7bUnTO9jKFNG5vCf/f+SAH1DVrj10d7JHaqCyYXufA41cTBXqzDjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717072569; c=relaxed/simple;
	bh=5Ji0Kp2+hJnYpSpWuVr2zcyBsx/hGA6s+ah+weCe7Z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G7Y0T9FlLNgCqEneSX2vFahQuz1P7TxEqxv6hFE8M+59Vu2xTSPxMwwGG/XXnlXWUOL7psNofNPRGfZR+Futf8HLkf+8RckActO24eu05tDoZqPHoqEFzMuCBNGPpXMk4++CPRr/TO2piA+5RVcWjEiwx+uJ3bJOoQOpFt9MVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=X/mOYUJ9; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:aa0b:0:640:ea1a:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id 3010B616B3;
	Thu, 30 May 2024 15:29:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id qTRBQoRaw8c0-sarTMXQo;
	Thu, 30 May 2024 15:29:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1717072194; bh=5Ji0Kp2+hJnYpSpWuVr2zcyBsx/hGA6s+ah+weCe7Z4=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=X/mOYUJ9i9hwX4dRZ6UQiUXVcp/vCS5joINqe0wnb29TYj71Be8TcWWHMtlv16gfe
	 wws66E6vQ/D/6g6dIso194cfdcVvDdkSx6nw89hwvHH9s7+RThDd7LozLkZbc+PTn8
	 F52byYvqsGJtJpaofOiV8qdSYTd+jPelxaHUnzn8=
Authentication-Results: mail-nwsmtp-smtp-production-main-17.iva.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <137165ef56fe36ad6417adeebbd8ec89e72ea226.camel@maquefel.me>
Subject: Re: [PATCH RESEND v2 0/4] DONOTMERGE: ep93xx-clk from ep93xx device
 tree conversion
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Linus Walleij
 <linus.walleij@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>,  Rob Herring <robh@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>
Date: Thu, 30 May 2024 15:29:53 +0300
In-Reply-To: <96df565e5821b5dc2b777cba21964d3c0c221983.camel@maquefel.me>
References: <20240408-ep93xx-clk-v2-0-adcd68c13753@maquefel.me>
	 <96df565e5821b5dc2b777cba21964d3c0c221983.camel@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGVsbG8gU3RlcGhlbiEKCk9uIEZyaSwgMjAyNC0wNS0xNyBhdCAxMDozOSArMDMwMCwgTmlraXRh
IFNodWJpbiB3cm90ZToKPiBIZWxsbyBTdGVwaGVuIQo+IAo+IEEgZ2VudGxlIHJlbWFpbmRlciwg
Y2FuIGkgaG9wZSB5b3UnbGwgbG9vayBpbnRvIG15IGNoYW5nZXMgZm9yIHYyID8KCkNvdWxkIHlv
dSBwbGVhc2UgbG9vayBpbnRvwqAiY2xrOiBlcDkzeHg6IGFkZCBEVCBzdXBwb3J0IGZvciBDaXJy
dXMKRVA5M3h4IiA/CgpJdCdzIHRoZSBvbmx5IG9uZSB0aGF0IGhhcyBsZWZ0IG5vdCByZXZpZXdl
ZC4KCj4gCj4gT24gTW9uLCAyMDI0LTA1LTA2IGF0IDEyOjQ5ICswMzAwLCBOaWtpdGEgU2h1Ymlu
IHZpYSBCNCBSZWxheSB3cm90ZToKPiA+IFRoZSBnb2FsIGlzIHRvIHJlY2lldmUgQUNLcy4KPiA+
IAo+ID4gVGhpcyBpcyBhIGZyYWN0aW9uIG9mIHY5ICJlcDkzeHggZGV2aWNlIHRyZWUgY29udmVy
c2lvbiIgc2VyaWVzOgo+ID4gCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDAz
MjYtZXA5M3h4LXY5LTAtMTU2ZTJhZTVkZmM4QG1hcXVlZmVsLm1lLwo+ID4gCj4gPiBUaGUgY2xr
IGRyaXZlciBmb3IgZXA5M3h4IHdhcyBjb252ZXJ0ZWQgdG8gQVVYIGRldmljZSwgYXMgc3VnZ2Vz
dGVkCj4gPiBvcmlnaW5hbGx5IGJ5IFN0ZXBoZW4gQm95ZC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1i
eTogTmlraXRhIFNodWJpbiA8bmlraXRhLnNodWJpbkBtYXF1ZWZlbC5tZT4KPiA+IC0tLQo+ID4g
Q2hhbmdlcyBpbiB2MjoKPiA+IC0gc29jOiBBZGQgU29DIGRyaXZlciBmb3IgQ2lycnVzIGVwOTN4
eDoKPiA+IMKgIC0gYWRkZWQgX19pbml0IGZvciBlcDkzeHhfYWRldl9hbGxvYygpLAo+ID4gZXA5
M3h4X2NvbnRyb2xsZXJfcmVnaXN0ZXIoKQo+ID4gwqAgLSBhZGRlZCBzdGF0aWMsIF9faW5pdGNv
bnN0IGZvciBwaW5jdHJsX25hbWVzW10KPiA+IMKgIC0gY2xrIHJldmlzaW9uIGZvciBTUEkgaXMg
bm93IHJlc29sdmVkIGhlcmUgdGhyb3VnaCBkaWZmZXJlbnRseQo+ID4gbmFtZWQKPiA+IMKgwqDC
oCBjbGsgZGV2aWNlCj4gPiDCoCAtIG1vcmUgdmVyYm9zZSBLY29uZmlnIGRlc2NyaXB0aW9uCj4g
PiAKPiA+IMKgIE5PVEU6ICJvZiIgaW5jbHVkZXMgYXJlIHJlcXVpcmVkIHVuZm9ydHVuYXRlbHku
Cj4gPiAKPiA+IC0gY2xrOiBlcDkzeHg6IGFkZCBEVCBzdXBwb3J0IGZvciBDaXJydXMgRVA5M3h4
Ogo+ID4gwqAgLSBkcm9wcGVkIGluY2x1ZGVzCj4gPiDCoCAtIGRyb3BwZWQgZXA5M3h4X3NvY190
YWJsZVtdCj4gPiDCoCAtIGFkZCBkaWZmZXJlbnQgbmFtZWQgY2xrIGFuZCBkcm9wcGVkIGludm9s
dmVkIGluY2x1ZGVzCj4gPiDCoCAtIG1vdmVkIHBsbCdzIGFuZCBmY2xrLCBoY2xrLCBwY2xrIGlu
aXQgdG8gc2VwYXJhdGUgZnVuY3Rpb24KPiA+IMKgIC0gZml4ZWQgZXA5M3h4X2Nsa19pZHNbXSBl
eHBsaWNpdCBsaW5lcwo+ID4gCj4gPiDCoCBOT1RFOiBjbGtfaHdfcmVnaXN0ZXJfZGl2KCkgaXMg
Y2xrLWVwOXh4IGludGVybmFsIGZ1bmN0aW9uIHdoaWNoCj4gPiB1c2VzCj4gPiDCoCBkZXZtLgo+
ID4gCj4gPiAtLS0KPiA+IE5pa2l0YSBTaHViaW4gKDQpOgo+ID4gwqDCoMKgwqDCoCBBUk06IGVw
OTN4eDogYWRkIHJlZ21hcCBhdXhfZGV2Cj4gPiDCoMKgwqDCoMKgIGNsazogZXA5M3h4OiBhZGQg
RFQgc3VwcG9ydCBmb3IgQ2lycnVzIEVQOTN4eAo+ID4gwqDCoMKgwqDCoCBkdC1iaW5kaW5nczog
c29jOiBBZGQgQ2lycnVzIEVQOTN4eAo+ID4gwqDCoMKgwqDCoCBzb2M6IEFkZCBTb0MgZHJpdmVy
IGZvciBDaXJydXMgZXA5M3h4Cj4gPiAKPiA+IMKgLi4uL2JpbmRpbmdzL2FybS9jaXJydXMvY2ly
cnVzLGVwOTMwMS55YW1swqDCoMKgwqDCoMKgwqDCoCB8wqAgMzggKwo+ID4gwqAuLi4vYmluZGlu
Z3Mvc29jL2NpcnJ1cy9jaXJydXMsZXA5MzAxLXN5c2Nvbi55YW1swqAgfMKgIDk0ICsrKwo+ID4g
wqBkcml2ZXJzL2Nsay9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgOCArCj4gPiDCoGRyaXZlcnMvY2xrL01h
a2VmaWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDEgKwo+ID4gwqBkcml2ZXJzL2Nsay9jbGstZXA5M3h4LmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgODM0Cj4gPiAr
KysrKysrKysrKysrKysrKysrKysKPiA+IMKgZHJpdmVycy9zb2MvS2NvbmZpZ8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKg
IDEgKwo+ID4gwqBkcml2ZXJzL3NvYy9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsKPiA+IMKgZHJpdmVy
cy9zb2MvY2lycnVzL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgfMKgIDE3ICsKPiA+IMKgZHJpdmVycy9zb2MvY2lycnVzL01ha2VmaWxlwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICsKPiA+
IMKgZHJpdmVycy9zb2MvY2lycnVzL3NvYy1lcDkzeHguY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMjUyICsrKysrKysKPiA+IMKgaW5jbHVkZS9kdC1iaW5kaW5ncy9j
bG9jay9jaXJydXMsZXA5MzAxLXN5c2Nvbi5owqDCoCB8wqAgNDYgKysKPiA+IMKgaW5jbHVkZS9s
aW51eC9zb2MvY2lycnVzL2VwOTN4eC5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMjYgKwo+ID4gwqAxMiBmaWxlcyBjaGFuZ2VkLCAxMzIwIGluc2VydGlvbnMoKykKPiA+
IC0tLQo+ID4gYmFzZS1jb21taXQ6IGZlYzUwZGI3MDMzZWE0Nzg3NzNiMTU5ZTBlMmVmYjEzNTI3
MGUzYjcKPiA+IGNoYW5nZS1pZDogMjAyNDA0MDgtZXA5M3h4LWNsay02NTdhMTM1N2RlNjcKPiA+
IAo+ID4gQmVzdCByZWdhcmRzLAo+IAoK


