Return-Path: <linux-kernel+bounces-438677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B569EA440
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F2D1646E8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3A85D477;
	Tue, 10 Dec 2024 01:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="IB65uBjI"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEED4282ED;
	Tue, 10 Dec 2024 01:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733793851; cv=none; b=eL43P21r5QsU77SL20RdNJkZbAUvu/dU8bHMcy93nr2sXP8Dd6cgu6QF04XIe/3pHp3adUjJWJfAYQG93g6dRrnIJIN0P1KLz8Ep7yOmE7GYDuSkax+VXSPKewienOjY7FvNKkp59ozZI7yl4TVdnAx7hRut6SwA9AKyiUBK2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733793851; c=relaxed/simple;
	bh=91dfVHO4aw7lINM/DBrBSiY/HH1o3ES6BOSHTsMtd3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=HJYoy8JUBMFqOLUA6sTxQ6ken7zQRMVx+nNB0CS6FevHJsEeWb+nBdAQ7+u1YwylYIgTS3IisMk3urM4LfxlAEWYpxHfi0GlUPLNxyB9LHtV8g86maAAPKFDoeitwQnSuUaIvNb6YYX8Q5/mM5ignTkx5Ir6byEMhb14NZHHrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=IB65uBjI reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=C8RlaUKPf21j08ezs3E/JiewGDRmoycUNvyVAbMCuu4=; b=I
	B65uBjIN/o9jnLcLVy9aDh0cETx7W7zgLzGRscrTG+jlcb4jFsfyjLf3PqD9CN4p
	c8Cohfw5QxZpEjGm5bcpU0gQEJogIly8esXHE3v8Gj0LF0BopoLg7BFIa0EAuQjx
	SlE4CjXkBLURxmNP3gBgb9QDZ+EsZT2njssXRAJ8v4=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Tue, 10 Dec 2024 09:21:36 +0800
 (CST)
Date: Tue, 10 Dec 2024 09:21:36 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	"Daniel Semkowicz" <dse@thaumatec.com>, 
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
In-Reply-To: <ay5hbnqqjhopaqof6z7j2rzm2bc6xa2vbzan2ak3if6wzmyip2@kqh7gtrajnm2>
References: <20241203165450.1501219-1-heiko@sntech.de>
 <20241209150619.33998-1-dse@thaumatec.com>
 <D67AV178CEBD.3QA9VD4ZPRNQ1@cknow.org> <2203458.KiezcSG77Q@diego>
 <4e015ea9.960.193ae0c236a.Coremail.andyshrk@163.com>
 <ay5hbnqqjhopaqof6z7j2rzm2bc6xa2vbzan2ak3if6wzmyip2@kqh7gtrajnm2>
X-NTES-SC: AL_Qu2YAfuSvE4i4CaZYekZnEobh+Y5UcK2s/ki2YFXN5k0tCTI0SYQW29KGUD2y86DDiKsoAirUQVL5MpFRpJHY4609LG24bETf9Rb4QXd0iNV
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <33e2c5db.1300.193ae284b6d.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgD3f7ehl1dnU_46AA--.45701W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gixXmdXkkuwGQACs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIERtaXRyeSwKCuWcqCAyMDI0LTEyLTEwIDA5OjAxOjM477yMIkRtaXRyeSBCYXJ5c2hrb3Yi
IDxkbWl0cnkuYmFyeXNoa292QGxpbmFyby5vcmc+IOWGmemBk++8mgo+T24gVHVlLCBEZWMgMTAs
IDIwMjQgYXQgMDg6NTA6NTFBTSArMDgwMCwgQW5keSBZYW4gd3JvdGU6Cj4+IAo+PiAKPj4gSGks
Cj4+IAo+PiBBdCAyMDI0LTEyLTEwIDA3OjEyOjI2LCAiSGVpa28gU3TDvGJuZXIiIDxoZWlrb0Bz
bnRlY2guZGU+IHdyb3RlOgo+PiA+QW0gTW9udGFnLCA5LiBEZXplbWJlciAyMDI0LCAxNzoxMTow
MyBDRVQgc2NocmllYiBEaWVkZXJpayBkZSBIYWFzOgo+PiA+PiBIaSwKPj4gPj4gCj4+ID4+IE9u
IE1vbiBEZWMgOSwgMjAyNCBhdCA0OjA2IFBNIENFVCwgRGFuaWVsIFNlbWtvd2ljeiB3cm90ZToK
Pj4gPj4gPiBPbiAwMy4xMi4yNCAyMTo1NCwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6Cj4+ID4+ID4g
PiBUaGlzIHNlcmllcyBhZGRzIGEgYnJpZGdlIGFuZCBnbHVlIGRyaXZlciBmb3IgdGhlIERTSTIg
Y29udHJvbGxlciBmb3VuZAo+PiA+PiA+ID4gaW4gdGhlIHJrMzU4OCBzb2MgZnJvbSBSb2NrY2hp
cCwgdGhhdCBpcyBiYXNlZCBvbiBhIFN5bm9wc2lzIElQIGJsb2NrLgo+PiA+PiA+ID4gCj4+ID4+
ID4KPj4gPj4gPiBJIGRpZCBtb3JlIHRlc3RzIHdpdGggZGlmZmVyZW50IExWRFMgZGlzcGxheXMu
IEkgdGVzdGVkIGZvbGxvd2luZwo+PiA+PiA+IGNvbmZpZ3VyYXRpb25zIHdpdGggRFNJL0xWRFMg
YnJpZGdlOgo+PiA+PiA+IC0gMTAyNHg2MDBANjAuMDEKPj4gPj4gPiAtIDEwMjR4NzY4QDYwLjAy
Cj4+ID4+ID4gLSAxMjgweDgwMEA2MC4wNwo+PiA+PiA+IC0gMTM2Nng3NjhANjAuMDYKPj4gPj4g
Pgo+PiA+PiA+IEFsbCBvZiB0aGVtIHdvcmtlZCB3aXRob3V0IGlzc3VlcywgZXhjZXB0IDEzNjZ4
NzY4Lgo+PiA+PiA+IFdpdGggdGhpcyByZXNvbHV0aW9uLCB2aWRlbyBpcyBibHVycnksIGFuZCBv
ZmZzZXQgaW5jb3JyZWN0bHkKPj4gPj4gPiB0byB0aGUgbGVmdC4gVGhlcmUgYXJlIGFsc28gcmVw
ZWF0aW5nIGVycm9ycyBvbiB0aGUgY29uc29sZToKPj4gPj4gPgo+PiA+PiA+ICAgcm9ja2NoaXAt
ZHJtIGRpc3BsYXktc3Vic3lzdGVtOiBbZHJtXSAqRVJST1IqIFBPU1RfQlVGX0VNUFRZIGlycSBl
cnIgYXQgdnAzCj4+ID4+ID4KPj4gPj4gPiBJbiBjb3JyZWN0IG9wZXJhdGlvbiB3aXRoIG90aGVy
IHJlc29sdXRpb25zLCB0aGVyZSBpcyBubyBlcnJvci4KPj4gPj4gPiBJIGFtIG5vdCBzdXJlIGlm
IHRoaXMgaXMgYSBwcm9ibGVtIGluIHlvdXIgc2VyaWVzIG9yIHJhdGhlciBpbiBWT1AyCj4+ID4+
ID4gZHJpdmVyLgo+PiA+Cj4+ID5UaGlzIHJlYWxseSBzb3VuZHMgbGlrZSBzb21ldGhpbmcgaXMg
d3Jvbmcgb24gdGhlIHZvcCBzaWRlLgo+PiA+VGhlIGludGVycnVwdCBpcyBwYXJ0IG9mIHRoZSB2
b3AsIHRoZSBkaXZpc2FibGUgYnkgNCB0aGluZ3MgbGlrZWx5IHRvby4KPj4gCj4+IFRoaXMgaXMg
YSBoYXJkd2FyZSBsaW1pdGF0aW9uIG9uIHZvcCBzaWRlOgo+PiBUaGUgaG9yaXpvbnRhbCByZXNv
bHV0aW9uIG11c3QgYmUgNCBwaXhlbCBhbGlnbmVkLgo+Cj5UaGVuIG1vZGVfdmFsaWQoKSBhbmQg
YXRvbWljX2NoZWNrKCkgbXVzdCByZWplY3QgbW9kZXMgdGhhdCBkb24ndCBmaXQuCgpXZSByb3Vu
ZCBkb3duIHRvIDQgcGl4ZWwgYWxpZ25lZCBpbiBtb2RlX2ZpeHVwIGluIG91ciBic3Aga2VybmVs
LCAKYmVjYXVzZSBzb21ldGltZXMsIHNvbWUgYm9hcmRzIGRvIGluZGVlZCBjaG9vc2UgYSBzY3Jl
ZW4gdGhhdCBpcyBub3QgNCBwaXhlbCBhbGlnbmVkCj4KPj4gCj4+IAo+PiAKPgo+LS0gCj5XaXRo
IGJlc3Qgd2lzaGVzCj5EbWl0cnkK

