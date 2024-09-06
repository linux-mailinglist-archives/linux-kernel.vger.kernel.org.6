Return-Path: <linux-kernel+bounces-318588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D837596F033
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9221F29BE0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350561AB6DF;
	Fri,  6 Sep 2024 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="N6FGj/mA"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AC5C603
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616306; cv=none; b=jfRP96lmjdDmQQgdf9fy4rwh8t4kgth7oJ7MGlP9OrhLTAKP5CNWbrZ5kNQ1VVNjYr7yP1xIjiK9RK74c52FVoC/ZxiI64FF0W1DM+Zu1whO24atQ/J/4lyQj9ub1noy8eODNw3DLqfQpCEJhsp21PjolnZVVIa0RUnRbWDausU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616306; c=relaxed/simple;
	bh=aLo9Tf8u3tLcIHlIYPowqddmI3Gnvd1IdxIRkmv7BnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=RECWVz2gdz+VpyO2cYZjCfH0PKwEUOvlrZQn1haxAIDQUt0NaKe4L+muTmQWsqw26oi1vp06ErNkdlzIPqyZ5ej/aqC84YhuvbS1k3fqGLtaSA8fdDWmrxCyus1+mX8HSjMj5tTo09p63apSQ8wwhzm+mFvnNiXa5CmIx8FupFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=N6FGj/mA reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=yXeAZMqnPEUw1nGJDqQeQa/1NXUi1sfFmoPDpYDmFng=; b=N
	6FGj/mAXCrJKUfSF27rqnnZGudV4uz315L8d7iECTQF8BTkxxqogAN+6mOCJanti
	yAps4Kw4THUbfjD3VGnt18q4PbxavzuQJKB6OYePKzRZrFCRu2iccQX2P0eZwdhz
	Ya8l6CiRf3QVvWcuyP527ghR0ZMQjqLLjiiVSgluW4=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Fri, 6 Sep 2024 17:50:20 +0800 (CST)
Date: Fri, 6 Sep 2024 17:50:20 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Diederik de Haas" <didi.debian@cknow.org>
Cc: "Min-Hua Chen" <minhuadotchen@gmail.com>, "Sandy Huang" <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	"Andy Yan" <andy.yan@rock-chips.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"David Airlie" <airlied@gmail.com>, 
	"Daniel Vetter" <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <D3Z3FN6GARPI.197HD3V38X81T@cknow.org>
References: <20240905223852.188355-1-minhuadotchen@gmail.com>
 <6f07603.7f9.191c4c887b1.Coremail.andyshrk@163.com>
 <D3Z3FN6GARPI.197HD3V38X81T@cknow.org>
X-NTES-SC: AL_Qu2ZB/qauUop5iCYZukZnEobh+Y5UcK2s/ki2YFXN5k0mCTU0SYHcVtZP2PS1cyiLhihlDywfDNM9slef49ob7A0xWS+vmLZ6I6POgSZgSD1
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <e4ca4ac.a3fb.191c6bde766.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3P7tc0NpmWd4jAA--.24907W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0gtSXmWX0Naz1wADsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIae+8jApBdCAyMDI0LTA5LTA2IDE3OjI4OjMzLCAiRGllZGVyaWsgZGUgSGFhcyIgPGRpZGku
ZGViaWFuQGNrbm93Lm9yZz4gd3JvdGU6Cj5PbiBGcmkgU2VwIDYsIDIwMjQgYXQgMjo0MiBBTSBD
RVNULCBBbmR5IFlhbiB3cm90ZToKPj4gQXQgMjAyNC0wOS0wNiAwNjozODo1MCwgIk1pbi1IdWEg
Q2hlbiIgPG1pbmh1YWRvdGNoZW5AZ21haWwuY29tPiB3cm90ZToKPj4gPkluY2x1ZGUgcm9ja2No
aXBfZHJtX2Rydi5oIHRvIGZpeCB0aGUgZm9sbG93IHNwYXJzZSB3YXJuaW5nOgo+PiA+Cj4+ID5k
cml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfdm9wMl9yZWcuYzo1MDI6MjQ6IHNwYXJz
ZToKPj4gPndhcm5pbmc6IHN5bWJvbCAndm9wMl9wbGF0Zm9ybV9kcml2ZXInIHdhcyBub3QgZGVj
bGFyZWQuCj4+ID5TaG91bGQgaXQgYmUgc3RhdGljPwo+PiA+Cj4+ID5ObyBmdW5jdGlvbmFsIGNo
YW5nZSBpbnRlbmRlZC4KPj4gPgo+PiA+U2lnbmVkLW9mZi1ieTogTWluLUh1YSBDaGVuIDxtaW5o
dWFkb3RjaGVuQGdtYWlsLmNvbT4KPj4gPi0tLQo+PiA+IGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hp
cC9yb2NrY2hpcF92b3AyX3JlZy5jIHwgMSArCj4+ID4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspCj4+ID4KPj4gPmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9j
a2NoaXBfdm9wMl9yZWcuYyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF92b3Ay
X3JlZy5jCj4+ID5pbmRleCAxOGVmYjNmZTFjMDAuLmM2NzhkMWIwZmQ3YyAxMDA2NDQKPj4gPi0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF92b3AyX3JlZy5jCj4+ID4rKysg
Yi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvcm9ja2NoaXBfdm9wMl9yZWcuYwo+PiA+QEAgLTE0
LDYgKzE0LDcgQEAKPj4gPiAjaW5jbHVkZSA8ZHJtL2RybV9wcmludC5oPgo+PiA+IAo+PiA+ICNp
bmNsdWRlICJyb2NrY2hpcF9kcm1fdm9wMi5oIgo+PiA+KyNpbmNsdWRlICJyb2NrY2hpcF9kcm1f
ZHJ2LmgiCj4+ID4gCj4+Cj4+IFdlIGFscmVhZHkgaGF2ZSBhIHBhdGNoWzBdIGluY2x1ZGUgcm9j
a2NoaXBfZHJtX2Rydi5oIGluIHJvY2tjaGlwX2RybV92b3AyLmgKPj4KPj4gWzBdaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXJvY2tjaGlwL3BhdGNoLzIwMjQwOTA0
MTIwMjM4LjM4NTY3ODItMy1hbmR5c2hya0AxNjMuY29tLyAKPgo+TWF5YmUgSSdtIG1pc3Npbmcg
c29tZXRoaW5nLCBidXQgdGhpcyBwYXRjaCBzZWVtcyB0byBmaXggYW4gYWxyZWFkeQo+ZXhpc3Rp
bmcgYnVnICh3aGljaCBzaG91bGQgaGF2ZSBhIEZpeGVzIHRhZz8pLCB3aGljaCBBbmR5IGFsc28g
Zml4ZWQKCj53aGlsZSBpbXBsZW1lbnRpbmcgYSBkaWZmZXJlbnQgKGFuZCB1bnJlbGF0ZWQpIGZl
YXR1cmU/CgoKSW4gZmFjdCwgSSBkb24ndCBrbm93IGhvdyB0byByZXByb2R1Y2UgdGhpcyBjb21w
aWxhdGlvbiBpc3N1ZS4KV2hpbGUgaW1wbGVtZW50aW5nIG15IGZlYXR1cmUsIEkgaGFwcGVuZWQg
dG8gZmluZCB0aGF0IEkgbmVlZCB0byBpbmNsdWRlIHJvY2tjaGlwX2RybV9kcnYuaCBpbiByb2Nr
Y2hpcF9kcm1fdm9wMi5oCgoKCj4KPkNoZWVycywKPiAgRGllZGVyaWsK

