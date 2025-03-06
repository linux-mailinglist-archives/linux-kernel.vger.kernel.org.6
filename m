Return-Path: <linux-kernel+bounces-548483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFEFA54572
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E6D188F768
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203E2080C4;
	Thu,  6 Mar 2025 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="MJmLdj8l"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159B719D880;
	Thu,  6 Mar 2025 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251288; cv=none; b=AGlUE9e3hELCNat910PQdQ1uFaTScs3O9oq2/RZtgoTRkE5vONGu+G/ETdI34UxEkm+SM0aFw6WLk/sEvTVJDv7zeuZu7XAtbZ0cmsEo6IGzPxgffViRsvMXY+fIMlBsIYXjU6Scyh8kxL+Jwy9eXOgWNZakRy3UerXW5ACCsEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251288; c=relaxed/simple;
	bh=yE52WJ2vimlh/juoZ6MbwG17+CtDV9JuhivlROiXjXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=G/ZsmaHQ8VbrskJKg34YwQS/2V126XTca7UqnC7EbsWeE23Cbz8TeFQqG4YH40uwsmn5RJsw4Ziw1uo8i6C2oqylNJixSsOB2ba6tVFhp7BIjbsDjwA+uDshTJybIIgWnxrN9PYIHvh9jsDRsW+G17Y3/RLA0x8Wn3ezQM4Y7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=MJmLdj8l reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=otJkz+uTPErAYIjjRZpM17wntC5OwTC49cEJBc+LIdk=; b=M
	JmLdj8lP9dWjkBDyETZhE6ieWhs61qK8O3Vf1iAqnvG2H7x1qnM/8L5C7niwY2LJ
	57Hs5dfY7HekbJMbCyLkHm/bbFdM2klID/CVwnxZYJF0d6K3ogTkXU8FrM4phDz0
	ptt5YwYCCoA6Wn4pMzoeOGpWlMfp2VgEVZbvS3KHro=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Thu, 6 Mar 2025 16:53:21 +0800 (CST)
Date: Thu, 6 Mar 2025 16:53:21 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Piotr Oniszczuk" <piotr.oniszczuk@gmail.com>
Cc: heiko@sntech.de, neil.armstrong@linaro.org,
	sebastian.reichel@collabora.com, devicetree@vger.kernel.org,
	hjc@rock-chips.com, mripard@kernel.org, linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org, yubing.zhang@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	"Andy Yan" <andy.yan@rock-chips.com>, krzk+dt@kernel.org,
	robh@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re:Re: [PATCH 0/6] Add support for RK3588 DisplayPort Controller
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <44213B17-FE14-4FB8-8319-1E31BBF6EAA0@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
 <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
 <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
 <44213B17-FE14-4FB8-8319-1E31BBF6EAA0@gmail.com>
X-NTES-SC: AL_Qu2fA/6evkor5yKaYOkfmkcVgOw9UcO5v/Qk3oZXOJF8jDDp2ycwUUJSDXLaweO0FQ+OmgmGXTtC9/R7f4VTVaQNArHD3vYUsFK+gDGjSdXBUQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <74c154b6.8c50.1956aa8c8d2.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgD3__eBYslnVcN3AA--.8557W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAsIXmfJWZrlfwABs7
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoK5ZyoIDIwMjUtMDMtMDYgMTY6NDI6MDDvvIwiUGlvdHIgT25pc3pjenVrIiA8cGlvdHIu
b25pc3pjenVrQGdtYWlsLmNvbT4g5YaZ6YGT77yaCj4KPgo+PiBXaWFkb21vxZvEhyBuYXBpc2Fu
YSBwcnpleiBBbmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4gdyBkbml1IDYgbWFyIDIwMjUsIG8g
Z29kei4gMDE6NTk6Cj4+IAo+PiAKPj4gCj4+IAo+PiBCb3RoIG9mIHRoZSB0d28gY29uZmlnIG9w
dGlvbnMgc2hvdWxkIGJlIGVuYWJsZWQuCj4+IGFuZHlAUHJvNDgwOn4vV29ya1NwYWNlL2xpbnV4
LW5leHQkIHJnIERXX0RQIC5jb25maWcKPj4gNDA0NDpDT05GSUdfUk9DS0NISVBfRFdfRFA9eQo+
Cj5oZXJlIGnigJltIGEgYml0IGxvc3TigKYuCj5ncmVwaW5nIG9uIGZ1bGwga2VybmVsIHNvdXJj
ZXMgKHdpdGggYXBwbGllZCBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGlu
dXgtcm9ja2NoaXAvbGlzdC8/c2VyaWVzPTkzNjc4NCkgZ2l2ZXMgbWUgbm8gc2luZ2xlIGFwcGVh
cmFuY2Ugb2YgUk9DS0NISVBfRFdfRFDigKYKPkRvIGkgbWlzcyBzb21ldGhpbmc/CgpzZWUgUEFU
Q0ggMy82OiAgIAoKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvS2NvbmZp
ZyBiL2RyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9LY29uZmlnCmluZGV4IDI2YzQ0MTBiMjQwNy4u
Yzg2MzhiYWY5NjQxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvS2NvbmZp
ZworKysgYi9kcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvS2NvbmZpZwpAQCAtOCw2ICs4LDcgQEAg
Y29uZmlnIERSTV9ST0NLQ0hJUAogCXNlbGVjdCBEUk1fUEFORUwKIAlzZWxlY3QgVklERU9NT0RF
X0hFTFBFUlMKIAlzZWxlY3QgRFJNX0FOQUxPR0lYX0RQIGlmIFJPQ0tDSElQX0FOQUxPR0lYX0RQ
CisJc2VsZWN0IERSTV9EV19EUCBpZiBST0NLQ0hJUF9EV19EUAogCXNlbGVjdCBEUk1fRFdfSERN
SSBpZiBST0NLQ0hJUF9EV19IRE1JCiAJc2VsZWN0IERSTV9EV19IRE1JX1FQIGlmIFJPQ0tDSElQ
X0RXX0hETUlfUVAKIAlzZWxlY3QgRFJNX0RXX01JUElfRFNJIGlmIFJPQ0tDSElQX0RXX01JUElf
RFNJCkBAIC01OCw2ICs1OSwxMiBAQCBjb25maWcgUk9DS0NISVBfQ0ROX0RQCiAJICBSSzMzOTkg
YmFzZWQgU29DLCB5b3Ugc2hvdWxkIHNlbGVjdCB0aGlzCiAJICBvcHRpb24uCiAKK2NvbmZpZyBS
T0NLQ0hJUF9EV19EUAorCWJvb2wgIlJvY2tjaGlwIHNwZWNpZmljIGV4dGVuc2lvbnMgZm9yIFN5
bm9wc3lzIERXIERQIgorCWhlbHAKKwkgIENob29zZSB0aGlzIG9wdGlvbiBmb3IgU3lub3BzeXMg
RGVzaWduV2FyZSBDb3JlcyBEaXNwbGF5UG9ydAorCSAgdHJhbnNtaXQgY29udHJvbGxlciBzdXBw
b3J0IG9uIFJvY2tjaGlwIFNvQy4KCiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1yb2Nr
Y2hpcC8wNDdFRUNGQy03RTU1LTQ0RUMtODk2Ri0xM0ZFMDQzMzNFNERAZ21haWwuY29tL1QvI20x
NzhhMzI1ZWEwZWJjNjQxODdhYWU0NzRkNzdjM2Y3YTllMGJjOTNkCj4K

