Return-Path: <linux-kernel+bounces-318000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF2B96E6EA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 02:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DADCB22EBF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 00:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05C1401B;
	Fri,  6 Sep 2024 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="klXiBzH2"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E61799F
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725583447; cv=none; b=h2FVLHkSW8UrftfvjUXpf4Hm/0sPHnc8FCRiMkJxMkAI1qnKxiN4cObt7NE4cmcpg0qhRQ0OfmZoq7h02YmsPNTmzb12nYY3V9C5qQ+mX38VjByFwq1jMoA2BGeWfh9Ko01SJqpTY3g20Da5xDDlowBt3aKSMxgStQWjCxuVlME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725583447; c=relaxed/simple;
	bh=kIU4sGjKhoV+S1nzEruC46kE8h+2ylG2PkyDLE1Qu5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=dX/vBGKEAa9dFAuEsBUYTmy2vUNjhMvdxQL6TL6TCX4XQGRAeBMK/OglhUXYTKUSaksUYNZAksf7cCS2xRPu9fqy5x9dUQzjWKuXW6qEizXCwYiyJJsccgFnk0c1EfIx9dLjLzwE+v4A60WSghN/ZnJG84KYsN3tX7hjzqMsbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=klXiBzH2 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=sWKETyqbCy/oU45Avlbw42IlnMoezBn1N7HKMujWHB8=; b=k
	lXiBzH2S1mGIO5ZZxNawojacfCxB5NSZKiQRJg0curicGTespE6vt/mZWQ0lXU96
	lO8nKFpOcQjdXbMm7+BR8ZNLn1ruRCo3VKrW9Zd88I1Ui2yy0s4hI0QC6C7PJlpZ
	TsbcQKL5VH3xWf8KdpSZq58ccRzDRJQr+aZigBpE0I=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Fri, 6 Sep 2024 08:42:41 +0800 (CST)
Date: Fri, 6 Sep 2024 08:42:41 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Min-Hua Chen" <minhuadotchen@gmail.com>
Cc: "Sandy Huang" <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	"Andy Yan" <andy.yan@rock-chips.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"David Airlie" <airlied@gmail.com>, 
	"Daniel Vetter" <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH] drm/rockchip: include rockchip_drm_drv.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240905223852.188355-1-minhuadotchen@gmail.com>
References: <20240905223852.188355-1-minhuadotchen@gmail.com>
X-NTES-SC: AL_Qu2ZB/mTvEst5ymeYOkZnEobh+Y5UcK2s/ki2YFXN5k0mCTU0SYHcVtZP2PS1cyiLhihlDywfDNM9slef49ob7AfQ5yEURwOay+wzTF7eCuj
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <6f07603.7f9.191c4c887b1.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H70CUNpmYjNOAA--.33708W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiMxJSXmXAnqv04QACsq
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpICBNaW4gSHVh77yMCiAgIFRoYW5rcyBmb3IgeW91ciB3b3JrCgpBdCAyMDI0LTA5LTA2IDA2
OjM4OjUwLCAiTWluLUh1YSBDaGVuIiA8bWluaHVhZG90Y2hlbkBnbWFpbC5jb20+IHdyb3RlOgo+
SW5jbHVkZSByb2NrY2hpcF9kcm1fZHJ2LmggdG8gZml4IHRoZSBmb2xsb3cgc3BhcnNlIHdhcm5p
bmc6Cj4KPmRyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF92b3AyX3JlZy5jOjUwMjoy
NDogc3BhcnNlOgo+d2FybmluZzogc3ltYm9sICd2b3AyX3BsYXRmb3JtX2RyaXZlcicgd2FzIG5v
dCBkZWNsYXJlZC4KPlNob3VsZCBpdCBiZSBzdGF0aWM/Cj4KPk5vIGZ1bmN0aW9uYWwgY2hhbmdl
IGludGVuZGVkLgo+Cj5TaWduZWQtb2ZmLWJ5OiBNaW4tSHVhIENoZW4gPG1pbmh1YWRvdGNoZW5A
Z21haWwuY29tPgo+LS0tCj4gZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX3ZvcDJf
cmVnLmMgfCAxICsKPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+ZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF92b3AyX3JlZy5jIGIvZHJpdmVy
cy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX3ZvcDJfcmVnLmMKPmluZGV4IDE4ZWZiM2ZlMWMw
MC4uYzY3OGQxYjBmZDdjIDEwMDY0NAo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3Jv
Y2tjaGlwX3ZvcDJfcmVnLmMKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hp
cF92b3AyX3JlZy5jCj5AQCAtMTQsNiArMTQsNyBAQAo+ICNpbmNsdWRlIDxkcm0vZHJtX3ByaW50
Lmg+Cj4gCj4gI2luY2x1ZGUgInJvY2tjaGlwX2RybV92b3AyLmgiCj4rI2luY2x1ZGUgInJvY2tj
aGlwX2RybV9kcnYuaCIKPiAKCldlIGFscmVhZHkgaGF2ZSBhIHBhdGNoWzBdIGluY2x1ZGUgcm9j
a2NoaXBfZHJtX2Rydi5oIGluIHJvY2tjaGlwX2RybV92b3AyLmgKClswXWh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1yb2NrY2hpcC9wYXRjaC8yMDI0MDkwNDEyMDIz
OC4zODU2NzgyLTMtYW5keXNocmtAMTYzLmNvbS8gCgo+IHN0YXRpYyBjb25zdCB1aW50MzJfdCBm
b3JtYXRzX2NsdXN0ZXJbXSA9IHsKPiAJRFJNX0ZPUk1BVF9YUkdCMjEwMTAxMCwKPi0tIAo+Mi40
My4wCj4KPgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
PkxpbnV4LXJvY2tjaGlwIG1haWxpbmcgbGlzdAo+TGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFk
ZWFkLm9yZwo+aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1yb2NrY2hpcAo=

