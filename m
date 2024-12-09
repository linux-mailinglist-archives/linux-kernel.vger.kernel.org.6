Return-Path: <linux-kernel+bounces-437529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5E9E9474
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C22162370
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32465224898;
	Mon,  9 Dec 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="boDnxdIy"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E20223703;
	Mon,  9 Dec 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747881; cv=none; b=pLq9ikgBH2VRI7u8Igf6piJZhLF2iqagw3g2FTo5pz/dNULtEs29JR9KLQXnIT2VoKYh2Gi1T41y1BQiyqBQOcakU9yvZjupjRDyFA4ZHxLpJf/fVvZXOlUQTAKC5r5fyFlKPcQk5zjMrm2nGWHOsn/jizoi4cbwA62GwLT6+Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747881; c=relaxed/simple;
	bh=q54hqglvs3EEjlWUnywKhs/WmG6gqbTT96DE4HuistY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Nl73mW0ZSpGpH1AdBnnjyvzvEYCuxLk7yxe4OQlpL0YnVtYJjHl9ujWa3UzH2usvj0Lz17cqe9YfbQTraYBkyyjnTi6nV6MiMPt+EIe8MTbLy29s4s82FTRFmVHGCvH7OJTaqZzNGbVvyKK8X29xCo+yLq6/oIypMq7WWZbEjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=boDnxdIy reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=oaL4vuqyJPqCzrebAYqJ4BkKXX75wUQalceWFIYVX60=; b=b
	oDnxdIyak6k6oTFpXzAmrmXKbA2F8nEQZWEJlImrUoivFyfnGozddxf8Us5jd9J4
	pQm1mG6ASENox8K5fWqasZSYnDWUqq+KhoZNvvyolOPvwfrVbBgyLJl93HktG3Jf
	fzadG2fD5OL7CbsvrHmUbNmQ8ZYIP7kzGTstiDeA98=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-102 (Coremail) ; Mon, 9 Dec 2024 20:37:16 +0800 (CST)
Date: Mon, 9 Dec 2024 20:37:16 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com, krzk+dt@kernel.org, s.hauer@pengutronix.de, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, derek.foreman@collabora.com, 
	detlev.casanova@collabora.com
Subject: Re:[PATCH] arm64: dts: rockchip: Enable HDMI display for rk3588
 Cool Pi GenBook
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20241209122943.2781431-3-andyshrk@163.com>
References: <20241209122943.2781431-1-andyshrk@163.com>
 <20241209122943.2781431-3-andyshrk@163.com>
X-NTES-SC: AL_Qu2YAfufuEAo4CWcYukZnEobh+Y5UcK2s/ki2YFXN5k0tCTI0SYQW29KGUD2y86DDiKsoAirUQVL5MpFRpJHY45Pr/VWJbfCvfnScnDgjI4d
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5818dffa.ba85.193ab6c868c.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:ZigvCgDXj7585FZnANI6AA--.45284W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hGwXmdW4xo5UwACsN
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ClNvcnJ5LCBwbGVhc2UgaWdub3JlIHRoaXMgcGF0Y2guCgpBdCAyMDI0LTEyLTA5IDIwOjI5OjEy
LCAiQW5keSBZYW4iIDxhbmR5c2hya0AxNjMuY29tPiB3cm90ZToKPkVuYWJsZSBoZG1pIGRpc3Bs
YXkgb3V0cHV0IG9uIENvb2wgUGkgR2VuQm9vay4KPgo+U2lnbmVkLW9mZi1ieTogQW5keSBZYW4g
PGFuZHlzaHJrQDE2My5jb20+Cj5MaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQx
MDI4MTIzNTAzLjM4NDg2Ni00LWFuZHlzaHJrQDE2My5jb20KPlNpZ25lZC1vZmYtYnk6IEhlaWtv
IFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+Cj4tLS0KPiAuLi4vcm9ja2NoaXAvcmszNTg4LWNv
b2xwaS1jbTUtZ2VuYm9vay5kdHMgICAgfCA0OSArKysrKysrKysrKysrKysrKysrCj4gMSBmaWxl
IGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKykKPgo+ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvcm9ja2NoaXAvcmszNTg4LWNvb2xwaS1jbTUtZ2VuYm9vay5kdHMgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL3JvY2tjaGlwL3JrMzU4OC1jb29scGktY201LWdlbmJvb2suZHRzCj5pbmRleCA2
NDE4Mjg2ZWZlNDBkLi45ZWMyMzc0YzZjZGZhIDEwMDY0NAo+LS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9yb2NrY2hpcC9yazM1ODgtY29vbHBpLWNtNS1nZW5ib29rLmR0cwo+KysrIGIvYXJjaC9h
cm02NC9ib290L2R0cy9yb2NrY2hpcC9yazM1ODgtY29vbHBpLWNtNS1nZW5ib29rLmR0cwo+QEAg
LTcsNiArNyw3IEBACj4gL2R0cy12MS87Cj4gCj4gI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2xlZHMv
Y29tbW9uLmg+Cj4rI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3NvYy9yb2NrY2hpcCx2b3AyLmg+Cj4g
I2luY2x1ZGUgInJrMzU4OC1jb29scGktY201LmR0c2kiCj4gCj4gLyB7Cj5AQCAtMzUsNiArMzYs
MTcgQEAgY2hhcmdlcjogZGMtY2hhcmdlciB7Cj4gCQlncGlvcyA9IDwmZ3BpbzEgUktfUEMwIEdQ
SU9fQUNUSVZFX0xPVz47Cj4gCX07Cj4gCj4rCWhkbWktY29uIHsKPisJCWNvbXBhdGlibGUgPSAi
aGRtaS1jb25uZWN0b3IiOwo+KwkJdHlwZSA9ICJhIjsKPisKPisJCXBvcnQgewo+KwkJCWhkbWlf
Y29uX2luOiBlbmRwb2ludCB7Cj4rCQkJCXJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaTBfb3V0X2Nv
bj47Cj4rCQkJfTsKPisJCX07Cj4rCX07Cj4rCj4gCWxlZHM6IGxlZHMgewo+IAkJY29tcGF0aWJs
ZSA9ICJncGlvLWxlZHMiOwo+IAo+QEAgLTEzNiw2ICsxNDgsMjggQEAgdmNjNXYwX3VzYl9ob3N0
MDogdmNjNXYwX3VzYjMwX2hvc3Q6IHZjYzV2MC11c2ItaG9zdC1yZWd1bGF0b3Igewo+IAl9Owo+
IH07Cj4gCj4rLyogSERNSSBDRUMgaXMgbm90IHVzZWQgKi8KPismaGRtaTAgewo+KwlwaW5jdHJs
LTAgPSA8JmhkbWltMF90eDBfaHBkICZoZG1pbTBfdHgwX3NjbCAmaGRtaW0wX3R4MF9zZGE+Owo+
KwlzdGF0dXMgPSAib2theSI7Cj4rfTsKPisKPismaGRtaTBfaW4gewo+KwloZG1pMF9pbl92cDA6
IGVuZHBvaW50IHsKPisJCXJlbW90ZS1lbmRwb2ludCA9IDwmdnAwX291dF9oZG1pMD47Cj4rCX07
Cj4rfTsKPisKPismaGRtaTBfb3V0IHsKPisJaGRtaTBfb3V0X2NvbjogZW5kcG9pbnQgewo+KwkJ
cmVtb3RlLWVuZHBvaW50ID0gPCZoZG1pX2Nvbl9pbj47Cj4rCX07Cj4rfTsKPisKPismaGRwdHhw
aHlfaGRtaTAgewo+KwlzdGF0dXMgPSAib2theSI7Cj4rfTsKPisKPiAmaTJjNCB7Cj4gCXN0YXR1
cyA9ICJva2F5IjsKPiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPkBAIC0zNDcsMyArMzgx
LDE4IEBAICZ1c2JfaG9zdDFfeGhjaSB7Cj4gCWRyX21vZGUgPSAiaG9zdCI7Cj4gCXN0YXR1cyA9
ICJva2F5IjsKPiB9Owo+Kwo+KyZ2b3Agewo+KwlzdGF0dXMgPSAib2theSI7Cj4rfTsKPisKPism
dm9wX21tdSB7Cj4rCXN0YXR1cyA9ICJva2F5IjsKPit9Owo+Kwo+KyZ2cDAgewo+Kwl2cDBfb3V0
X2hkbWkwOiBlbmRwb2ludEBST0NLQ0hJUF9WT1AyX0VQX0hETUkwIHsKPisJCXJlZyA9IDxST0NL
Q0hJUF9WT1AyX0VQX0hETUkwPjsKPisJCXJlbW90ZS1lbmRwb2ludCA9IDwmaGRtaTBfaW5fdnAw
PjsKPisJfTsKPit9Owo+LS0gCj4yLjM0LjEK

