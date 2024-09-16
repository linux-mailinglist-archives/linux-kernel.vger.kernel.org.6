Return-Path: <linux-kernel+bounces-330448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332D979EAB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7711C227E5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 09:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC16314A0A3;
	Mon, 16 Sep 2024 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ILGixXNO"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099C38DC7;
	Mon, 16 Sep 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479987; cv=none; b=u47kg5KknLYzUHIM461UmM/2Nm6+4VL9JOHptLtAUk4II6xOAu8EdnKYb7JiwtFQlgvvya/fvIDGudNqHTJ5853a6tXJTSyRx5i9n4P7FEBjC7b2XjKVpOlN54ab7URQZfaxLWt88D+UlEa3HrmAy/HViSBlGw94DK8PHCtcGTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479987; c=relaxed/simple;
	bh=N0hSmsJ9SspBVIxg9LCiOaQ+R0TFE+D+mdPXzQN+nJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=rLd0kaQTsG7eIzPOq86Y1sa/81PtHFxCyq4s0X/QqSvJCZgu8iZ19W9slipNmLIk44KYBIvAyKUVpCRTV8tMRAxN0QBtAU2KDMBszJ67O9mpV9HADaKz8sDRt3SjEYjpJUzdrd8wgY3Zmt1YaBBBeVSBr7M0vcodoD8PjsKIZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=ILGixXNO reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=4yrTVGgIy8ST+hf/b9VptZkzz6CVN2HRxPnjWXf8szk=; b=I
	LGixXNOnXrB2EpN6VeQmeGc0D2LktLGIlPpcho0GRaVdesWzd6jOd6TJC3EY1k1r
	Hbj3Gmk/ghkkY6VZXktwzY91FAVp512FsrLDeYg6xaytOTmdLUKwpPL+88U3C3nb
	FROqoIDnuIj17la+odVaWE860fVCaPdtJHLEdQORjI=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-132 (Coremail) ; Mon, 16 Sep 2024 17:44:37 +0800
 (CST)
Date: Mon, 16 Sep 2024 17:44:37 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Andrew Kreimer" <algonell@gmail.com>
Cc: "Sandy Huang" <hjc@rock-chips.com>, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	"Andy Yan" <andy.yan@rock-chips.com>, 
	"Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, 
	"Maxime Ripard" <mripard@kernel.org>, 
	"Thomas Zimmermann" <tzimmermann@suse.de>, 
	"David Airlie" <airlied@gmail.com>, 
	"Simona Vetter" <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, 
	"Matthew Wilcox" <willy@infradead.org>
Subject: Re:[PATCH] drm/rockchip: Fix a typo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240915123943.105118-1-algonell@gmail.com>
References: <20240915123943.105118-1-algonell@gmail.com>
X-NTES-SC: AL_Qu2ZBPictkAs4SmebOkXn0kXhec2W8Czvvgg34JRP5k0myXQ+AYEbXByEX7m/uioBASPvxeqVAdHxud8X7RnUJjQG8iUxgAelyfrXp/vh0iD
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3516596d.2131.191fa38475a.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDn7_QG_udmDhYPAA--.10499W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqRdcXmVOC6kEnAACsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

Ckhp77yMCgpBdCAyMDI0LTA5LTE1IDIwOjM5OjQzLCAiQW5kcmV3IEtyZWltZXIiIDxhbGdvbmVs
bEBnbWFpbC5jb20+IHdyb3RlOgo+Rml4IGEgdHlwbyBpbiBjb21tZW50cy4KPgo+UmVwb3J0ZWQt
Ynk6IE1hdHRoZXcgV2lsY294IDx3aWxseUBpbmZyYWRlYWQub3JnPgo+U2lnbmVkLW9mZi1ieTog
QW5kcmV3IEtyZWltZXIgPGFsZ29uZWxsQGdtYWlsLmNvbT4KCkFja2VkLWJ5OiAgQW5keSBZYW48
YW5keXNocmtAMTYzLmNvbT4KClRoYW5rcy4KCgo+LS0tCj4gZHJpdmVycy9ncHUvZHJtL3JvY2tj
aGlwL2Nkbi1kcC1yZWcuaCB8IDIgKy0KPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9j
ZG4tZHAtcmVnLmggYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvY2RuLWRwLXJlZy5oCj5pbmRl
eCA0NDEyNDhiN2E3OWUuLmM3NzgwYWUzMjcyYSAxMDA2NDQKPi0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9yb2NrY2hpcC9jZG4tZHAtcmVnLmgKPisrKyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9j
ZG4tZHAtcmVnLmgKPkBAIC03Nyw3ICs3Nyw3IEBACj4gI2RlZmluZSBTT1VSQ0VfUElGX1BLVF9B
TExPQ19XUl9FTgkweDMwODMwCj4gI2RlZmluZSBTT1VSQ0VfUElGX1NXX1JFU0VUCQkweDMwODM0
Cj4gCj4tLyogYmVsbG93IHJlZ2lzdGVycyBuZWVkIGFjY2VzcyBieSBtYWlsYm94ICovCj4rLyog
YmVsb3cgcmVnaXN0ZXJzIG5lZWQgYWNjZXNzIGJ5IG1haWxib3ggKi8KPiAvKiBzb3VyY2UgY2Fy
IGFkZHIgKi8KPiAjZGVmaW5lIFNPVVJDRV9IRFRYX0NBUgkJCTB4MDkwMAo+ICNkZWZpbmUgU09V
UkNFX0RQVFhfQ0FSCQkJMHgwOTA0Cj4tLSAKPjIuMzkuNQo=

