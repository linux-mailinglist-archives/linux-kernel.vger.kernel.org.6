Return-Path: <linux-kernel+bounces-548075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B378DA53F89
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 02:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAD6D16FAA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB5A54723;
	Thu,  6 Mar 2025 01:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="h8YMtUap"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D510528E3F;
	Thu,  6 Mar 2025 01:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741222822; cv=none; b=IB9oKA1BRESZzT7V7EGJ4hUchHTAkF0zu1+o/V0cpxmzv/f0I1SvCGmfZoinSB2QgKNNJDrZNuKO+lgXn2sFQgQHTbgfD7uFu4jtIcIo9w3q3Quk5J31GNjC27dHLVZiQW8afy7oE54P5wVHsXpxgbiJC7wZ/cgEOb2TBMaZCjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741222822; c=relaxed/simple;
	bh=c5JuR3E2F/2Ntx+ArgglektIJJZC/Y0atJH8Fy4DVwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=BJ8kK6c8+TL08PRCiDw7rebJbg5ehIdVTHdjIdFj2JeowOEIfMkBIbZq1YUw0P7XCIhg/BzOiorKcs/Nc0qdeTgjf9RxjCm7C+KxIm/7bn02g2CqGBDFa9HzCqilaCf2crVJN4Std2w6dBEB2PI1IoKis6IC7cAHP6N8HvMdePk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=h8YMtUap reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=PMDmUXSIdq2f/nNiLc3wTT/iCwj2VpHuoogdeFCSGXI=; b=h
	8YMtUapnYGyIdc6KXijq7eDjxK5Fzb6FN58zHAcyKJi9X6I7AfreyRhAF6tyk2XN
	dXyyAMfZIC3Jw8RC6K7iymB6vBLMGv+B0oCvojWZtKtZzwSwUnvwWVdIdBebFjdw
	8KqLAuQ2JmcKMtbcjuhvln2pg6VEAXA3OcGCEHKrA0=
Received: from andyshrk$163.com ( [103.29.142.67] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Thu, 6 Mar 2025 08:59:13 +0800 (CST)
Date: Thu, 6 Mar 2025 08:59:13 +0800 (CST)
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
In-Reply-To: <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
References: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
 <75189787-28E1-4FC2-8E10-4960B3877A6F@gmail.com>
X-NTES-SC: AL_Qu2fA/6ZvU8u5SefbOkfmkcVgOw9UcO5v/Qk3oZXOJF8jDDp2ycwUUJSDXLaweO0FQ+OmgmGXTtC9/R7f4VTVaQNWrfgx5ouyclyVgmtq3rycg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <28b0d3fc.bb3.19568f6b5f8.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgC3FURh88hnLg13AA--.6915W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkBkIXmfI596+CwACs+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFBpb3RyLAoK5ZyoIDIwMjUtMDMtMDUgMjE6NTY6MTLvvIwiUGlvdHIgT25pc3pjenVrIiA8
cGlvdHIub25pc3pjenVrQGdtYWlsLmNvbT4g5YaZ6YGT77yaCj4KPgo+PiBXaWFkb21vxZvEhyBu
YXBpc2FuYSBwcnpleiBBbmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4gdyBkbml1IDUgbWFyIDIw
MjUsIG8gZ29kei4gMDM6MzA6Cj4+IAo+Pj4gCj4+IAo+PiBJIG9ubHkgc2VlIHRoZSBIRE1JIGNv
bm5lY3RvciBmcm9tIHlvdXIgZHJpL3N0YXRlIDsgc28gaXQgYXBwZWFycyB0aGUgRFAgZHJpdmVy
IGhhc24ndCBiZWVuIHN1Y2Nlc3NmdWxseQo+PiBpbml0aWFsaXplZO+8iEkgdGhpbmsga2VybmVs
IGRtZXNnIGNhbiB0ZWxsIHRoYXTvvIkuIAo+PiBIYXZlIHlvdSBlbmFibGVkIENPTkZJR19ST0NL
Q0hJUF9EV19EUCA/IFRoaXMgaXMgbmVlZGVkLgo+PiAKPgo+Cj5BbmR5LAo+Cj5EbyB5b3UgbWVh
biBDT05GSUdfUk9DS0NISVBfRFdfRFAgb3IgQ09ORklHX0RSTV9EV19EUCA/Cj4KPklmIENPTkZJ
R19EUk1fRFdfRFAgLSB0aGVuIHllcyAtIGkgaGF2ZSBpdDogaHR0cHM6Ly9naXRodWIuY29tL3dh
cnBtZS9taW5pbXl0aDIvYmxvYi8yZTI2Nzg0MmIxMDMzYmJjNGMyYzVkODBjMTc1NmExNDJlMzQ3
Y2M1L3NjcmlwdC9rZXJuZWwvbGludXgtNi4xNC9maWxlcy9saW51eC02LjE0LWFybTY0LWFybXY4
LmNvbmZpZyNMNTAyNAo+Cj5LZXJuZWwgZG1lc2c6IGh0dHBzOi8vdGVybWJpbi5jb20vdWl1cAoK
CkJvdGggb2YgdGhlIHR3byBjb25maWcgb3B0aW9ucyBzaG91bGQgYmUgZW5hYmxlZC4KYW5keUBQ
cm80ODA6fi9Xb3JrU3BhY2UvbGludXgtbmV4dCQgcmcgRFdfRFAgLmNvbmZpZwo0MDQ0OkNPTkZJ
R19ST0NLQ0hJUF9EV19EUD15CjQyMTg6Q09ORklHX0RSTV9EV19EUD15CgpBbmQgaWYgZHcgZHAg
ZHJpdmVyIGJvb3RzIHN1Y2Nlc3MsIHlvdSB3aWxsIHNlZSBkbWVzZyBsaWtlIGJlbGxvdzoKCiBb
ICAgIDEuMDU4NjM0XSBhcm0tc21tdS12MyBmYzkwMDAwMC5pb21tdTogbXNpX2RvbWFpbiBhYnNl
bnQgLSBmYWxsaW5nIGJhY2sgdG8gd2lyZWQgaXJxcwpbICAgIDEuMDYyNDU4XSByb2NrY2hpcC12
b3AyIGZkZDkwMDAwLnZvcDogQWRkaW5nIHRvIGlvbW11IGdyb3VwIDAKWyAgICAxLjA2NzkwOF0g
cm9ja2NoaXAtZHJtIGRpc3BsYXktc3Vic3lzdGVtOiBib3VuZCBmZGQ5MDAwMC52b3AgKG9wcyB2
b3AyX2NvbXBvbmVudF9vcHMpClsgICAgMS4wNjg5ODFdIHJvY2tjaGlwLWRybSBkaXNwbGF5LXN1
YnN5c3RlbTogYm91bmQgZmRlNjAwMDAuZHAgKG9wcyBkd19kcF9yb2NrY2hpcF9jb21wb25lbnRf
b3BzKQpbICAgIDEuMDcwMTMzXSBkd2hkbWlxcC1yb2NrY2hpcCBmZGU4MDAwMC5oZG1pOiByZWdp
c3RlcmVkIERlc2lnbldhcmUgSERNSSBRUCBJMkMgYnVzIGRyaXZlcgpbICAgIDEuMDcwODU5XSBy
b2NrY2hpcC1kcm0gZGlzcGxheS1zdWJzeXN0ZW06IGJvdW5kIGZkZTgwMDAwLmhkbWkgKG9wcyBk
d19oZG1pX3FwX3JvY2tjaGlwX29wcykKWyAgICAxLjA3MjEwM10gW2RybV0gSW5pdGlhbGl6ZWQg
cm9ja2NoaXAgMS4wLjAgZm9yIGRpc3BsYXktc3Vic3lzdGVtIG9uIG1pbm9yIDAKWyAgICAxLjA4
MDE5MV0gbG9vcDogbW9kdWxlIGxvYWRlZAoKQnV0IEkganVzdCBzZWUgaGRtaSAgZHJpdmVyIGJv
b3RzIGZyb20geW91ciBkbWVzZy4KCj4KPgo+Cg==

