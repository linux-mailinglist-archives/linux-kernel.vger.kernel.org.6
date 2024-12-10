Return-Path: <linux-kernel+bounces-438653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532359EA3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C2A2851A1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFD13C0C;
	Tue, 10 Dec 2024 00:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="H4dZEI47"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0720326;
	Tue, 10 Dec 2024 00:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733792006; cv=none; b=g5uW46XTr7orOlBkHdPiB8tT9uqU5PjJHdmNxz8JVzTpStN7HcJvzwMsRJ1hf6vYGXStnfStaxu8jn8qf8seuZAwUqT+mu0+bxsPJ9pL0Rzw6LfuthrRQkLmgeI+hhbwugJGZS6udpQD0JbqSEtUhL+gH39ahyvz991l0gy55g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733792006; c=relaxed/simple;
	bh=mq7QxHqpmP8050zkcHctxYMYPkqICTjonbkVU/Kk+wM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=MwLKNsK01+gTrANvt2DjpdDrFjVgZOthp20eNw+y1aCQw+Q2Iy6Di1SCNQYavHQi1MWVzmhqbY9QXSmSaItdZz4/SXewsbfv3hCikvAeybADMeavzsVD7uAaA03/gyv0n3SLzWOnCIR9JK0T09UOSCbVbfpXiBNV/8SDh8hH5Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=H4dZEI47 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=FhW3RxWuSa2qtZWnSfHCog3V8YUyYEUWMbSHUEDeJ6Y=; b=H
	4dZEI47ysOkjq2nt2vaVeH59o2igH7ym38HY80DnZ+V4Gzm0/3n4KSbUVTVOSsEz
	4QUoO+0/MtDdhh9xjY6g8CXb8BHECm3+l7pXUrU1amejdQe6oqpYNMts7amWtABu
	VabSbjvfTfU2NOMwuZTekoLsz8h24rxTfSR5gIeExI=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Tue, 10 Dec 2024 08:50:51 +0800
 (CST)
Date: Tue, 10 Dec 2024 08:50:51 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "Daniel Semkowicz" <dse@thaumatec.com>, 
	"Diederik de Haas" <didi.debian@cknow.org>, andy.yan@rock-chips.com, 
	Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, 
	jonas@kwiboo.se, krzk+dt@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	neil.armstrong@linaro.org, quentin.schulz@cherry.de, 
	rfoss@kernel.org, robh@kernel.org, tzimmermann@suse.de
Subject: Re:Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <2203458.KiezcSG77Q@diego>
References: <20241203165450.1501219-1-heiko@sntech.de>
 <20241209150619.33998-1-dse@thaumatec.com>
 <D67AV178CEBD.3QA9VD4ZPRNQ1@cknow.org> <2203458.KiezcSG77Q@diego>
X-NTES-SC: AL_Qu2YAfuSvkAu5yOeZOkZnEobh+Y5UcK2s/ki2YFXN5k0tCTI0SYQW29KGUD2y86DDiKsoAirUQVL5MpFRpJHY460ozr25CzPaQGPdj10sTtO
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4e015ea9.960.193ae0c236a.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgAXlJxrkFdn5vA6AA--.43974W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMwmxXmdXikRb2gADsp
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSwKCkF0IDIwMjQtMTItMTAgMDc6MTI6MjYsICJIZWlrbyBTdMO8Ym5lciIgPGhlaWtvQHNu
dGVjaC5kZT4gd3JvdGU6Cj5BbSBNb250YWcsIDkuIERlemVtYmVyIDIwMjQsIDE3OjExOjAzIENF
VCBzY2hyaWViIERpZWRlcmlrIGRlIEhhYXM6Cj4+IEhpLAo+PiAKPj4gT24gTW9uIERlYyA5LCAy
MDI0IGF0IDQ6MDYgUE0gQ0VULCBEYW5pZWwgU2Vta293aWN6IHdyb3RlOgo+PiA+IE9uIDAzLjEy
LjI0IDIxOjU0LCBIZWlrbyBTdHVlYm5lciB3cm90ZToKPj4gPiA+IFRoaXMgc2VyaWVzIGFkZHMg
YSBicmlkZ2UgYW5kIGdsdWUgZHJpdmVyIGZvciB0aGUgRFNJMiBjb250cm9sbGVyIGZvdW5kCj4+
ID4gPiBpbiB0aGUgcmszNTg4IHNvYyBmcm9tIFJvY2tjaGlwLCB0aGF0IGlzIGJhc2VkIG9uIGEg
U3lub3BzaXMgSVAgYmxvY2suCj4+ID4gPiAKPj4gPgo+PiA+IEkgZGlkIG1vcmUgdGVzdHMgd2l0
aCBkaWZmZXJlbnQgTFZEUyBkaXNwbGF5cy4gSSB0ZXN0ZWQgZm9sbG93aW5nCj4+ID4gY29uZmln
dXJhdGlvbnMgd2l0aCBEU0kvTFZEUyBicmlkZ2U6Cj4+ID4gLSAxMDI0eDYwMEA2MC4wMQo+PiA+
IC0gMTAyNHg3NjhANjAuMDIKPj4gPiAtIDEyODB4ODAwQDYwLjA3Cj4+ID4gLSAxMzY2eDc2OEA2
MC4wNgo+PiA+Cj4+ID4gQWxsIG9mIHRoZW0gd29ya2VkIHdpdGhvdXQgaXNzdWVzLCBleGNlcHQg
MTM2Nng3NjguCj4+ID4gV2l0aCB0aGlzIHJlc29sdXRpb24sIHZpZGVvIGlzIGJsdXJyeSwgYW5k
IG9mZnNldCBpbmNvcnJlY3RseQo+PiA+IHRvIHRoZSBsZWZ0LiBUaGVyZSBhcmUgYWxzbyByZXBl
YXRpbmcgZXJyb3JzIG9uIHRoZSBjb25zb2xlOgo+PiA+Cj4+ID4gICByb2NrY2hpcC1kcm0gZGlz
cGxheS1zdWJzeXN0ZW06IFtkcm1dICpFUlJPUiogUE9TVF9CVUZfRU1QVFkgaXJxIGVyciBhdCB2
cDMKPj4gPgo+PiA+IEluIGNvcnJlY3Qgb3BlcmF0aW9uIHdpdGggb3RoZXIgcmVzb2x1dGlvbnMs
IHRoZXJlIGlzIG5vIGVycm9yLgo+PiA+IEkgYW0gbm90IHN1cmUgaWYgdGhpcyBpcyBhIHByb2Js
ZW0gaW4geW91ciBzZXJpZXMgb3IgcmF0aGVyIGluIFZPUDIKPj4gPiBkcml2ZXIuCj4KPlRoaXMg
cmVhbGx5IHNvdW5kcyBsaWtlIHNvbWV0aGluZyBpcyB3cm9uZyBvbiB0aGUgdm9wIHNpZGUuCj5U
aGUgaW50ZXJydXB0IGlzIHBhcnQgb2YgdGhlIHZvcCwgdGhlIGRpdmlzYWJsZSBieSA0IHRoaW5n
cyBsaWtlbHkgdG9vLgoKVGhpcyBpcyBhIGhhcmR3YXJlIGxpbWl0YXRpb24gb24gdm9wIHNpZGU6
ClRoZSBob3Jpem9udGFsIHJlc29sdXRpb24gbXVzdCBiZSA0IHBpeGVsIGFsaWduZWQuCgoKCj4K
Pgo+SGVpa28KPgo+Cj4+IAo+PiBPbiBteSBQaW5lVGFiMiBJIGdvdCBzaW1pbGFyIG1lc3NhZ2Vz
IGFib3V0IDIgd2Vla3MgYWdvOgo+PiByb2NrY2hpcC1kcm0gZGlzcGxheS1zdWJzeXN0ZW06IFtk
cm1dICpFUlJPUiogUE9TVF9CVUZfRU1QVFkgaXJxIGVyciBhdCB2cDEKPj4gCj4+IFByZWNlZGlu
ZyB0aG9zZSwgSSBnb3Qgc2V2ZXJhbCBwYW5mcm9zdCByZWxhdGVkIGVycm9yczoKPj4gCj4+IHBh
bmZyb3N0IGZkZTYwMDAwLmdwdTogZ2V0IGNsb2NrIGZhaWxlZCAtNTE3Cj4+IHBhbmZyb3N0IGZk
ZTYwMDAwLmdwdTogY2xrIGluaXQgZmFpbGVkIC01MTcKPj4gcGxhdGZvcm0gZmRlNjAwMDAuZ3B1
OiBkZWZlcnJlZCBwcm9iZSBwZW5kaW5nOiAocmVhc29uIHVua25vd24pCj4+IHBsYXRmb3JtIGNw
dWZyZXEtZHQ6IGRlZmVycmVkIHByb2JlIHBlbmRpbmc6IChyZWFzb24gdW5rbm93bikKPj4gdmRk
X2dwdV9ucHU6IGRpc2FibGluZwo+PiAKPj4gQnV0IGNhbiBhbHNvIGJlIHRoYXQgdGhlIFBpbmVU
YWIyIChsaWtlbHkpIG5lZWRzIHJlZ3VsYXRvci1hbHdheXMtb24KPj4gYW5kIHJlZ3VsYXRvci1i
b290LW9uIGluIGl0cyB2ZGRfZ3B1X25wdSBub2RlLgo+PiAKPj4gPiBJIHRyaWVkIHRvIHRyYWNr
IGRvd24gdGhlIHByb2JsZW0sIGFuZCBpdCBzZWVtcyB0byBiZSBhIGdlbmVyaWMgaXNzdWUKPj4g
PiB3aGVuIGhvcml6b250YWwgbGluZSB3aWR0aCBpcyBub3QgZGl2aXNpYmxlIGJ5IDQuCj4+ID4g
TG93ZXJpbmcgbGluZSB3aWR0aCB0byAxMzY0cHggZml4ZXMgdGhlIGlzc3VlLCBidXQgb2YgY291
cnNlIEkgaGF2ZSB0d28KPj4gPiB2ZXJ0aWNhbCBsaW5lcyBvZiBibGFjayBwaXhlbHMgb24gdGhl
IHJpZ2h0Lgo+PiA+IEkgYWxzbyBtYWRlIHNvbWUgdGVzdHMgd2l0aCA3MjB4MTI4MCBEU0kgZGlz
cGxheS4gTG93ZXJpbmcgaG9yaXpvbnRhbAo+PiA+IGxpbmUgdG8gNzE4cHggc2hvd3MgdGhlIHNh
bWUgcHJvYmxlbS4gV2l0aCA3MjBweCBhbmQgNzE2cHggaXQgd29ya3MKPj4gPiBjb3JyZWN0bHku
Cj4+IAo+PiBJIGhhdmVuJ3QgbG9vayBmdXJ0aGVyIGludG8gaXQsIGJ1dCB0aGUgUFQyIGhhcyBh
IDEyODB4ODAwIHJlc29sdXRpb24uCj4+IAo+PiBIVEgsCj4+ICAgRGllZGVyaWsKPj4gCj4KPgo+
Cg==

