Return-Path: <linux-kernel+bounces-438702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5B9EA48F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75A41888AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C182D98;
	Tue, 10 Dec 2024 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="avKxJ0Lr"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2785341C64;
	Tue, 10 Dec 2024 01:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733795762; cv=none; b=B81xfb+/B7ve2fjiSlzc898zQuG6H/JNv0fT/NRhfN6DA8wmB1eMgsZwlyk/NZdYUL2QynVpLHVeO40OE2wqm8w05N7lEd1X0wOJmaf4QKoqGyVWorBRy+mn/gJy+GkfxKPY6b1mMHyvH5GRsPYyaNQeTAklUf4RqYa3nZPoDNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733795762; c=relaxed/simple;
	bh=yN+LpULRymn1niqf9Es2pBV403+9Nd0xdYB19TFh3hU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NKLrJIDyeqmV0yK58epTBDxmyUZL4Y7RL68mq7e16iAl9j5L9a+xV91OP10CPk+0dqzcALMduuU7gXHe3A3+zZmfW5DfYkvJ36LTOlrV54VF+wFuB9bE4woGeuWIGogcG/jiQX0D88KngdGng2cnBLwzsc0OeZeJ5MLjbLkmdco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=avKxJ0Lr reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=xL6MsP46vvQFs6eVSs10fx/xv5QaR2/3vg24LgFgNKw=; b=a
	vKxJ0Lrgm87rmRIZUIkJyudNC0XSCRGW3AX9+hHt+gNSE7qShfOfvKcOcif/UMjJ
	dGBdga67npsDuSmnzlBIrLNeN0Jz3CMh0mUYBM0a+bU/sCb+P8BxJEhv3IDpdNkh
	6ozLQuMwLlkAbLPhBckiOTUKekmo6INE5eSlc98PEM=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Tue, 10 Dec 2024 09:54:09 +0800
 (CST)
Date: Tue, 10 Dec 2024 09:54:09 +0800 (CST)
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
Subject: Re:Re: Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2
 controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAA8EJprLA09NP0KAztc5eoAMkGcrom84jg_pcbNcwN0FAaSLrw@mail.gmail.com>
References: <20241203165450.1501219-1-heiko@sntech.de>
 <20241209150619.33998-1-dse@thaumatec.com>
 <D67AV178CEBD.3QA9VD4ZPRNQ1@cknow.org> <2203458.KiezcSG77Q@diego>
 <4e015ea9.960.193ae0c236a.Coremail.andyshrk@163.com>
 <ay5hbnqqjhopaqof6z7j2rzm2bc6xa2vbzan2ak3if6wzmyip2@kqh7gtrajnm2>
 <33e2c5db.1300.193ae284b6d.Coremail.andyshrk@163.com>
 <CAA8EJprLA09NP0KAztc5eoAMkGcrom84jg_pcbNcwN0FAaSLrw@mail.gmail.com>
X-NTES-SC: AL_Qu2YAfuSuk4v7yKYY+kZnEobh+Y5UcK2s/ki2YFXN5k0tCTI0SYQW29KGUD2y86DDiKsoAirUQVL5MpFRpJHY45g18x61WhC+0qmUPu3ua2x
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2d68155e.1e5b.193ae4616b9.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgD3v5JBn1dnOA47AA--.43222W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqR6xXmdXnM09jwACsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIERtaXRyeSwKCuWcqCAyMDI0LTEyLTEwIDA5OjQ1OjEx77yMIkRtaXRyeSBCYXJ5c2hrb3Yi
IDxkbWl0cnkuYmFyeXNoa292QGxpbmFyby5vcmc+IOWGmemBk++8mgo+T24gVHVlLCAxMCBEZWMg
MjAyNCBhdCAwMzoyMiwgQW5keSBZYW4gPGFuZHlzaHJrQDE2My5jb20+IHdyb3RlOgo+Pgo+Pgo+
PiBIaSBEbWl0cnksCj4+Cj4+IOWcqCAyMDI0LTEyLTEwIDA5OjAxOjM477yMIkRtaXRyeSBCYXJ5
c2hrb3YiIDxkbWl0cnkuYmFyeXNoa292QGxpbmFyby5vcmc+IOWGmemBk++8mgo+PiA+T24gVHVl
LCBEZWMgMTAsIDIwMjQgYXQgMDg6NTA6NTFBTSArMDgwMCwgQW5keSBZYW4gd3JvdGU6Cj4+ID4+
Cj4+ID4+Cj4+ID4+IEhpLAo+PiA+Pgo+PiA+PiBBdCAyMDI0LTEyLTEwIDA3OjEyOjI2LCAiSGVp
a28gU3TDvGJuZXIiIDxoZWlrb0BzbnRlY2guZGU+IHdyb3RlOgo+PiA+PiA+QW0gTW9udGFnLCA5
LiBEZXplbWJlciAyMDI0LCAxNzoxMTowMyBDRVQgc2NocmllYiBEaWVkZXJpayBkZSBIYWFzOgo+
PiA+PiA+PiBIaSwKPj4gPj4gPj4KPj4gPj4gPj4gT24gTW9uIERlYyA5LCAyMDI0IGF0IDQ6MDYg
UE0gQ0VULCBEYW5pZWwgU2Vta293aWN6IHdyb3RlOgo+PiA+PiA+PiA+IE9uIDAzLjEyLjI0IDIx
OjU0LCBIZWlrbyBTdHVlYm5lciB3cm90ZToKPj4gPj4gPj4gPiA+IFRoaXMgc2VyaWVzIGFkZHMg
YSBicmlkZ2UgYW5kIGdsdWUgZHJpdmVyIGZvciB0aGUgRFNJMiBjb250cm9sbGVyIGZvdW5kCj4+
ID4+ID4+ID4gPiBpbiB0aGUgcmszNTg4IHNvYyBmcm9tIFJvY2tjaGlwLCB0aGF0IGlzIGJhc2Vk
IG9uIGEgU3lub3BzaXMgSVAgYmxvY2suCj4+ID4+ID4+ID4gPgo+PiA+PiA+PiA+Cj4+ID4+ID4+
ID4gSSBkaWQgbW9yZSB0ZXN0cyB3aXRoIGRpZmZlcmVudCBMVkRTIGRpc3BsYXlzLiBJIHRlc3Rl
ZCBmb2xsb3dpbmcKPj4gPj4gPj4gPiBjb25maWd1cmF0aW9ucyB3aXRoIERTSS9MVkRTIGJyaWRn
ZToKPj4gPj4gPj4gPiAtIDEwMjR4NjAwQDYwLjAxCj4+ID4+ID4+ID4gLSAxMDI0eDc2OEA2MC4w
Mgo+PiA+PiA+PiA+IC0gMTI4MHg4MDBANjAuMDcKPj4gPj4gPj4gPiAtIDEzNjZ4NzY4QDYwLjA2
Cj4+ID4+ID4+ID4KPj4gPj4gPj4gPiBBbGwgb2YgdGhlbSB3b3JrZWQgd2l0aG91dCBpc3N1ZXMs
IGV4Y2VwdCAxMzY2eDc2OC4KPj4gPj4gPj4gPiBXaXRoIHRoaXMgcmVzb2x1dGlvbiwgdmlkZW8g
aXMgYmx1cnJ5LCBhbmQgb2Zmc2V0IGluY29ycmVjdGx5Cj4+ID4+ID4+ID4gdG8gdGhlIGxlZnQu
IFRoZXJlIGFyZSBhbHNvIHJlcGVhdGluZyBlcnJvcnMgb24gdGhlIGNvbnNvbGU6Cj4+ID4+ID4+
ID4KPj4gPj4gPj4gPiAgIHJvY2tjaGlwLWRybSBkaXNwbGF5LXN1YnN5c3RlbTogW2RybV0gKkVS
Uk9SKiBQT1NUX0JVRl9FTVBUWSBpcnEgZXJyIGF0IHZwMwo+PiA+PiA+PiA+Cj4+ID4+ID4+ID4g
SW4gY29ycmVjdCBvcGVyYXRpb24gd2l0aCBvdGhlciByZXNvbHV0aW9ucywgdGhlcmUgaXMgbm8g
ZXJyb3IuCj4+ID4+ID4+ID4gSSBhbSBub3Qgc3VyZSBpZiB0aGlzIGlzIGEgcHJvYmxlbSBpbiB5
b3VyIHNlcmllcyBvciByYXRoZXIgaW4gVk9QMgo+PiA+PiA+PiA+IGRyaXZlci4KPj4gPj4gPgo+
PiA+PiA+VGhpcyByZWFsbHkgc291bmRzIGxpa2Ugc29tZXRoaW5nIGlzIHdyb25nIG9uIHRoZSB2
b3Agc2lkZS4KPj4gPj4gPlRoZSBpbnRlcnJ1cHQgaXMgcGFydCBvZiB0aGUgdm9wLCB0aGUgZGl2
aXNhYmxlIGJ5IDQgdGhpbmdzIGxpa2VseSB0b28uCj4+ID4+Cj4+ID4+IFRoaXMgaXMgYSBoYXJk
d2FyZSBsaW1pdGF0aW9uIG9uIHZvcCBzaWRlOgo+PiA+PiBUaGUgaG9yaXpvbnRhbCByZXNvbHV0
aW9uIG11c3QgYmUgNCBwaXhlbCBhbGlnbmVkLgo+PiA+Cj4+ID5UaGVuIG1vZGVfdmFsaWQoKSBh
bmQgYXRvbWljX2NoZWNrKCkgbXVzdCByZWplY3QgbW9kZXMgdGhhdCBkb24ndCBmaXQuCj4+Cj4+
IFdlIHJvdW5kIGRvd24gdG8gNCBwaXhlbCBhbGlnbmVkIGluIG1vZGVfZml4dXAgaW4gb3VyIGJz
cCBrZXJuZWwsCj4KPldoYXQgaXMgbWVhbnQgYnkgdGhlICJic3Aga2VybmVsIiBoZXJlPyBJIGRv
bid0IHNlZSBpdCBiZWluZyBwcmVzZW50Cgpic3Aga2VybmVsIG1lYW5zIGRvd25zdHJlYW0gdmVu
ZG9yIGtlcm5lbC4KCj5pbiB0aGUgbWFpbmxpbmUga2VybmVsLiBTbywgaWYgdGhlIG1vZGUgaXMg
dW5zdXBwb3J0ZWQsIGl0IHNob3VsZCBiZQoKV2lsbCBpdCBiZSBhY2NlcHRhYmxlIHRvIGFkZCB0
aGlzIHJvdW5kIGRvd24gaW4gdGhlIG1haW5saW5lIG1vZGVfZml4dXA/Cgo+cmVqZWN0ZWQuCj4K
Pj4gYmVjYXVzZSBzb21ldGltZXMsIHNvbWUgYm9hcmRzIGRvIGluZGVlZCBjaG9vc2UgYSBzY3Jl
ZW4gdGhhdCBpcyBub3QgNCBwaXhlbCBhbGlnbmVkCj4+ID4KPj4gPj4KPj4gPj4KPj4gPj4KPj4g
Pgo+PiA+LS0KPj4gPldpdGggYmVzdCB3aXNoZXMKPj4gPkRtaXRyeQo+Cj4KPgo+LS0gCj5XaXRo
IGJlc3Qgd2lzaGVzCj5EbWl0cnkK

