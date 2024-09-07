Return-Path: <linux-kernel+bounces-319712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA534970116
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5EA1C21CEE
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C2F14F9E2;
	Sat,  7 Sep 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="FLye3heJ"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10C1D29E
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725699496; cv=none; b=YoitmNWg8WdNU0j4asX8mYeWHU1U/u16MQ3qBuvSV+DSQzy9HRvcbKZQguIdb1mItjqyetnkBtmlualgR+stuu4dZGjJ010K2wg7uhOKSPZ46IbAl9krZXA+oxEUTgUNLEvjRmnUjc0ytXLR5+6BILze5I2v0VrJ0Llf9BvKCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725699496; c=relaxed/simple;
	bh=46NYXTwDHRf9aaJrE4ccZd5cf823lvPti8uby9O7490=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gsSZu2HbVS6udjInOuG49U/E1LhR789YVfcZdtGt8Hs3pgilcb4NBCqW3Ye5mkiDRSKvhwD1A26CMb4RrmaABdgHLwdpptb5y0QfA7J7j9+zKCMkfeDdnZacqvGp9ICPGOerobAb7zpdJwCYmn3nk+z3W7D9gXNaz/r+UuN6qgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=FLye3heJ reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ta9LbWPktVaFbzSJMRfIFs5G3l89ulAedhc3mStWRsc=; b=F
	Lye3heJZvJ9pF9N5iPY3VQv6ol0Y1pW3FWsAGUoaNG0ktElrRh15ppu8CHH4iaEc
	520wKhG/4Fj934kZnaLLa3DhtaLLU3CC2HyzQQqHotFjQ1DlEaywMCfr8kUraLpO
	ENs+vR2bBKvBWU00+QRstsr5eu6ZgVJRX/zhyB+HWg=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-129 (Coremail) ; Sat, 7 Sep 2024 16:56:08 +0800 (CST)
Date: Sat, 7 Sep 2024 16:56:08 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Diederik de Haas" <didi.debian@cknow.org>
Cc: "Min-Hua Chen" <minhuadotchen@gmail.com>, airlied@gmail.com, 
	andy.yan@rock-chips.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, heiko@sntech.de, hjc@rock-chips.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de
Subject: Re:Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <D3ZX6LZNLOYC.30CT6AX32VI2T@cknow.org>
References: <D3Z5JMTKPQIS.2M5O5DY0S4U9G@cknow.org>
 <20240907030259.1243487-1-minhuadotchen@gmail.com>
 <D3ZX6LZNLOYC.30CT6AX32VI2T@cknow.org>
X-NTES-SC: AL_Qu2ZB/qStkst7iSQbOkZnEobh+Y5UcK2s/ki2YFXN5k0mCTU0SYHcVtZP2PS1cyiLhihlDywfDNM9slef49ob7BbQjG2KYVvHK7P3Hvr9aVJ
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175266d5.2a89.191cbb2a62e.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3_6IoFdxm2CU0AA--.26427W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQhTXmVOCt+zYAACsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSDvvIwKQXQgMjAyNC0wOS0wNyAxNjo0NzoxOCwgIkRpZWRlcmlrIGRlIEhhYXMiIDxkaWRp
LmRlYmlhbkBja25vdy5vcmc+IHdyb3RlOgo+T24gU2F0IFNlcCA3LCAyMDI0IGF0IDU6MDIgQU0g
Q0VTVCwgTWluLUh1YSBDaGVuIHdyb3RlOgo+PiA+RldJVzogSSBkaWRuJ3Qgc2VlIGl0IGVpdGhl
ciwgYnV0IEkgYXNzdW1lZCBJIHdhcyBtaXNzaW5nIHRoZSByaWdodAo+PiA+Y29udGV4dCAoaS5l
LiBwYXRjaGVzKSBuZWVkZWQgdG8gdHJpZ2dlciB0aGF0IHdhcm5pbmcuCj4+Cj4+IEkgdHJpZ2dl
cmVkIHRoZSB3YXJuaW5nIGJ5IHRoZSBmb2xsb3dpbmcgc3RlcDoKPj4KPj4gaW5zdGFsbCAnc3Bh
cnNlJyBmaXJzdAo+Pgo+PiBBUkNIPWFybTY0IExMVk09MSBtYWtlIEM9MSBDRj0nLWZkaWFnbm9z
dGljLXByZWZpeCAtRF9fQ0hFQ0tfRU5ESUFOX18nIG1ycHJvcGVyIGRlZmNvbmZpZyBhbGwgLWo4
Cj4KPlRoaXMsIGVzcGVjaWFsbHkgdGhlICdMTFZNJyBwYXJ0LCAgaXMgaW1wb3J0YW50IGNvbnRl
eHQgaW5mb3JtYXRpb24KPmFuZCBzaG91bGQgYmUgcGFydCBvZiB0aGUgY29tbWl0IG1lc3NhZ2Uu
Cj4KPkkgaGFkIG9ubHkganVzdCBzdGFydGVkIHdoZW4gSSBzYXcgYSBudW1iZXIgb2Ygc3BhcnNl
IHdhcm5pbmdzOgo+Cj4gIERUQyAgICAgYXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1
ODgtZWRnZWJsZS1uZXU2YS1pby5kdGIKPiAgT1ZMICAgICBhcmNoL2FybTY0L2Jvb3QvZHRzL3Rp
L2szLWo3MjFlLWV2bS5kdGIKPiAgT1ZMICAgICBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWo3
MjFzMi1ldm0uZHRiCj4gIE9WTCAgICAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY1NC1p
ZGsuZHRiCj4gIERUQyAgICAgYXJjaC9hcm02NC9ib290L2R0cy9xY29tL3NjNzE4MC10cm9nZG9y
LWxhem9yLXIzLWtiLmR0Ygo+ICBEVEMgICAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAv
cmszNTg4LWVkZ2VibGUtbmV1NmEtd2lmaS5kdGJvCj4gIERUQyAgICAgYXJjaC9hcm02NC9ib290
L2R0cy9xY29tL3NjNzE4MC10cm9nZG9yLWxhem9yLXIzLWx0ZS5kdGIKPiAgRFRDICAgICBhcmNo
L2FybTY0L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1lZGdlYmxlLW5ldTZiLWlvLmR0Ygo+ICBE
VEMgICAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTg4LWV2YjEtdjEwLmR0Ygo+
ICBEVEMgICAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvcWNvbS9zYzcxODAtdHJvZ2Rvci1sYXpvci1y
OS5kdGIKPi4uL2luaXQvbWFpbi5jOjE5MjoxMjogc3BhcnNlOiB3YXJuaW5nOiBzeW1ib2wgJ2Vu
dnBfaW5pdCcgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8KPi4uL2luaXQv
bWFpbi5jOjI5MDoxNjogc3BhcnNlOiB3YXJuaW5nOiBjYXN0IHRvIHJlc3RyaWN0ZWQgX19sZTMy
Cj4uLi9pbml0L21haW4uYzoyOTE6MTY6IHNwYXJzZTogd2FybmluZzogY2FzdCB0byByZXN0cmlj
dGVkIF9fbGUzMgo+ICBDSEVDSyAgIC4uL2luaXQvZG9fbW91bnRzLmMKCj4KCgpJIGNhbiBzZWUg
c2FtZSB3YXJuaW5nc++8jCBhIGxvdHMgb2bjgIIKQW5kIGFsc28gc2VlIHRoZSB3YXJuaW5nIGlu
IHZvcDLvvJoKZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlwL3JvY2tjaGlwX3ZvcDJfcmVnLmM6NTAy
OjI0OiBzcGFyc2U6IHdhcm5pbmc6IHN5bWJvbCAndm9wMl9wbGF0Zm9ybV9kcml2ZXInIHdhcyBu
b3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/CgoKTWluIEh1Ye+8jElmIHlvdSBhcmUg
YWdyZWXvvIxJIHdpbGwgc3BsaXQgaXQgZnJvbSBteSBwYXRjaO+8jCBhbmQgYWRkIGEgRml4IHRh
ZyDvvIxhbmQgYWxzbyBhZGQgYSBTb0Igb2YgeW9177yMIFRoZW4gcmVzZW5kIGluIE15IFYzIHNl
cmllc++8jHRoaXMKd2lsbCBtYWtlIG15IHBhdGNoIHNlcmllcyBlYXNpZXLjgIIKID5BbmQgc2V2
ZXJhbCBmb2xsb3dlZCwgaW5jbHVkaW5nIGluIGMtY29kZSBmaWxlcy4gU28gSSBzdG9wcGVkIHRo
ZSBidWlsZAo+YW5kIGFzc3VtZSB5b3UndmUgaWRlbnRpZmllZCBhIG9yIHNldmVyYWwgYWN0dWFs
IGlzc3Vlcy4KPgo+SSd2ZSBzZWVuIHNldmVyYWwgY29tbWl0cyB3aGVyZSBjaGFuZ2VzIHdlcmUg
bWFkZSBiZWNhdXNlIExMVk0gZmxhZ2dlZAo+cG90ZW50aWFsbHkgcHJvYmxlbWF0aWMgY29kZSwg
d2hlcmUgR0NDIGRpZCBub3QsIHNvIGl0J3MgcXVpdGUgcG9zc2libGUKPnlvdSdyZSBvbiB0byBz
b21ldGhpbmcgaGVyZS4KPgo+QnV0IGl0IHdvdWxkIGJlIGhlbHBmdWwgaWYgdGhlIGNvbW1pdCBt
ZXNzYWdlIHNhaWQgd2hhdCBjb2RlIHdhcwo+cG90ZW50aWFsbHkgcHJvYmxlbWF0aWMgYW5kIHdo
eS4gQW5kIHRoZW4gdGhlIHByb3BlciBmaXggZm9yIHRoYXQgY291bGQKPmluZGVlZCBiZSB0byBp
bmNsdWRlIGByb2NrY2hpcF9kcm1fZHJ2LmhgLgo+Cj5DaGVlcnMsCj4gIERpZWRlcmlrCg==

