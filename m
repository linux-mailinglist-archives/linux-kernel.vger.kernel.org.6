Return-Path: <linux-kernel+bounces-569721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD8DA6A693
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC90485445
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 12:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512C242065;
	Thu, 20 Mar 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="heI/BSbk"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75590179BC;
	Thu, 20 Mar 2025 12:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475442; cv=none; b=mlYhCvV8zcsKIWA8d5k4DC3kzL98bdbNbJ/9IezHSHkbHRztfDI13w4OLGugsVmzJ3PIZScsl2SCAe8Zzj8ACjEuWFF+w1N08W7o4GgKoSDgcVIJQo45KpukwcfZWw3WM5/N+DaHmgS/Pj2GvzNt7JlJUnQgXufhXH/uRQn7c7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475442; c=relaxed/simple;
	bh=PzL1hNUP4we1Y+VXPMp5QAgKUT95/IJsjvsaRpU6fWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=jn2p8jfVD2YE5EaQ6A95twZD8GVubHGlR7KwkSUt6nzH5dntTRFQlbVxdOWV/qc/C6ty72r4S4lmEkexLYndKqJSmL9bBuTFJTxsUf9YilGtqTIfUT4TIcXblrVY1mhHCvgwIc0G2xFY9B23CZ+S1hHyNJwUoilExACJrXtdalI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=heI/BSbk reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=PV8J72Kd8Fa075AwZSVmGmHrrt420GzFAmi5jXfZWH8=; b=h
	eI/BSbkrIuvldqB/lJQ4JMIvoWt78fgs408Zt+CycsmWKKbQs72ZSUGJ7Jrdg9L5
	WDSEMbMwJyILyF9yVZrTgdlgY2L8Ze3ByK9i1lXduCuKB3MRu9qN4sloc5rFWZuM
	gc3Tp7gmfwUnITcmJDHw2oCd+7gD7x+AzvzoImVOFA=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Thu, 20 Mar 2025 20:56:04 +0800
 (CST)
Date: Thu, 20 Mar 2025 20:56:04 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: dsimic@manjaro.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, krzk+dt@kernel.org,
	"Andy Yan" <andy.yan@rock-chips.com>
Subject: Re:Re:Re: [PATCH] arm64: dts: rockchip: aliase sdhci as mmc0 for
 rk3566 box demo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <19b62068.1082.193ed25f901.Coremail.andyshrk@163.com>
References: <20241221104920.4193034-1-andyshrk@163.com>
 <24438615.ouqheUzb2q@diego>
 <19b62068.1082.193ed25f901.Coremail.andyshrk@163.com>
X-NTES-SC: AL_Qu2fAPicukst4iSeYukfmkcVgOw9UcO5v/Qk3oZXOJF8jDjp4xEhV2B6MH/20uOCARCyuyGufh9t7txYW6d3eJ0gDSag/xFgLgGfyqB2/Sa6kw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2ae3fb1a.ad30.195b3a0087e.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bygvCgD3vzFkENxnDwKCAA--.42918W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAcWXmfcCF-htQABsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgSGVpa2/vvIwKCkF0IDIwMjQtMTItMjIgMTQ6NTU6MDksICJBbmR5IFlhbiIgPGFuZHlzaHJr
QDE2My5jb20+IHdyb3RlOgo+Cj5IaSBIZWlrb++8jAo+QXQgMjAyNC0xMi0yMSAyMDo1NTowMiwg
IkhlaWtvIFN0w7xibmVyIiA8aGVpa29Ac250ZWNoLmRlPiB3cm90ZToKPj5IaSBBbmR5LAo+Pgo+
PkFtIFNhbXN0YWcsIDIxLiBEZXplbWJlciAyMDI0LCAxMTo0OTowNyBDRVQgc2NocmllYiBBbmR5
IFlhbjoKPj4+IEZyb206IEFuZHkgWWFuIDxhbmR5LnlhbkByb2NrLWNoaXBzLmNvbT4KPj4+IAo+
Pj4gRm9sbG93IG1vc3Qgb3RoZXJzIHJrMzU2eCBiYXNlZCBib2FyZHMsIGFuZCB1LWJvb3Qgb25s
eSB1c2UgbW1jMC8xCj4+PiBhcyBtbWMgYm9vdCB0YXJnZXRzLCBzbyBhbGlhc2Ugc2RoY2kgYXMg
bW1jMC4KPj4+IAo+Pj4gU2lnbmVkLW9mZi1ieTogQW5keSBZYW4gPGFuZHkueWFuQHJvY2stY2hp
cHMuY29tPgo+Pj4gLS0tCj4+PiAKPj4+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3Jr
MzU2Ni1ib3gtZGVtby5kdHMgfCA2ICsrKy0tLQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4+PiAKPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU2Ni1ib3gtZGVtby5kdHMgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL3JvY2tjaGlwL3JrMzU2Ni1ib3gtZGVtby5kdHMKPj4+IGluZGV4IDQxYjRjZDVhNDIyMC4u
N2QwZWVkZjFiZDBkIDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hp
cC9yazM1NjYtYm94LWRlbW8uZHRzCj4+PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JvY2tj
aGlwL3JrMzU2Ni1ib3gtZGVtby5kdHMKPj4+IEBAIC0xOSw5ICsxOSw5IEBAIC8gewo+Pj4gIAo+
Pj4gIAlhbGlhc2VzIHsKPj4+ICAJCWV0aGVybmV0MCA9ICZnbWFjMTsKPj4+IC0JCW1tYzAgPSAm
c2RtbWMwOwo+Pj4gLQkJbW1jMSA9ICZzZG1tYzE7Cj4+PiAtCQltbWMyID0gJnNkaGNpOwo+Pj4g
KwkJbW1jMCA9ICZzZGhjaTsKPj4+ICsJCW1tYzEgPSAmc2RtbWMwOwo+Pj4gKwkJbW1jMiA9ICZz
ZG1tYzE7Cj4+Cj4+c29ycnksIGJ1dCB0aGF0IHdvbid0IGJlIHBvc3NpYmxlIDotKCAuCj4+Cj4+
VGhlIG9yaWdpbmFsIGFsaWFzZXMgZm9yIHRoZSBtbWMgb3JkZXIgd2VyZSBhZGRlZCBvdmVyIDIg
eWVhcnMgYWdvCj4+KG5vdmVtYmVyIDIwMjIpIGFuZCBiZWNhbWUgcGFydCBvZiB0aGUgQUJJIHRo
ZW4uCj4KPlllcywgIHRoZSBwYXRjaCBmb3IgdGhpcyBib2FyZCB3YXMgc3VibWl0dGVkIGJ5IG1l
Lgo+VGhpcyBpcyBhIHR2IGJveCAgZXZhbHVhdGlvbiBkZW1vIGJvYXJkIHRoYXQgd2UgdXNlIGlu
dGVybmFsbHnvvIxhbmQgaXQgaXMgbm90IHNvbGQgdG8gdGhlIHB1YmxpYy4KPkkgc3VibWl0dGVk
IGl0IHRvIHRoZSBtYWlubGluZSBiZWNhdXNlIGl0IGlzIHNtYWxsLCBjb21wYWN0IGFuZCBzdHJl
YW1saW5lZCwgaXQgZWFzeSBmb3IgbWUKPnRvIHVzZSBpdCAgdGVzdCB0aGUgbWFpbmxpbmUgdm9w
MiBkcml2ZXIuIAo+SSB0aGluayBpIGFtIGN1cnJlbnRseSB0aGUgb25seSB1c2VyIHdobyB3aWxs
IHVzZSB0aGlzIGJvYXJkIHJ1biB0aGUgbWFpbmxpbmUga2VybmVsLgo+SSdtIG5vdCBzdXJlIGlm
IHdlIGNhbiBsZXQgaXQgZ28uCgoKU28gZmFyLCBubyBvbmUgaGFzIGNvbWUgZm9yd2FyZCB0byBj
bGFpbSB0aGF0IHRoZXkgYXJlIHVzaW5nIHRoaXMgYm9hcmQuCkFjdHVhbGx5LCBhcyBJIG1lbnRp
b25lZCBiZWZvcmUsIGN1cnJlbnRseSwgaXQgaXMgb25seSBtZSB3aG8gaXMgdXNpbmcgdGhpcwpi
b2FyZCB0byBkbyBzb21lIERSTS1yZWxhdGVkIHRlc3RzLiBDb3VsZCB5b3UgY29uc2lkZXIgbWVy
Z2luZyBpdD8gCklmIGxhdGVyIG9uIHNvbWVvbmUgcmVhbGx5IGNvbWVzIGZvcndhcmQgYW5kIGNs
YWltcyB0aGF0IHRoaXMgbW9kaWZpY2F0aW9uCmhhcyBhZmZlY3RlZCBpdCwgd2UgY2FuIHN0aWxs
IHJldmVydCB0aGlzIHBhdGNoLgoKPgo+Cj4+Cj4+SW1hZ2luZSBzb21lb25lIHVzaW5nIHRoYXQg
Ym9hcmQgd2l0aCBhIHJvb3Rmcz0vZGV2L21tY2JsazJwMSBwYXJ0Cj4+aW4gdGhlIGNvbW1hbmRs
aW5lIHRvIG1vdW50IHRoZSBvbGQgc2RoY2ktcGFydDEgYXMgcm9vdGZzLCBidXQgbm93Cj4+eW91
IHJlb3JkZXIgdGhlIGNvbnRyb2xsZXJzLCBzbyBzbyB0aGF0IGNvbW1hbmRsaW5lIHdvdWxkIHRy
eSB0byBhY2Nlc3MKPj5zZG1tYzEsIHNvIHRoZWlyIHN5c3RlbSB3b24ndCBib290IGFueW1vcmUg
YWZ0ZXIganVzdCBhIHNpbXBsZSBrZXJuZWwKPj51cGRhdGUuCj4+Cj4+QnJlYWtpbmcgcGVvcGxl
J3Mgc2V0dXAgaXMgb25lIG9mIHRob3NlIGJpZyBuby1nby1zIGluIHRoZSBrZXJuZWwsIHNvCj4+
c2FkbHkgeW91J2xsIG5lZWQgdG8gbGl2ZSB3aXRoIHRoZSBleGlzdGluZyBvcmRlci4KPj4KPj4K
Pj5IZWlrbwo+Pgo+Pgo=

