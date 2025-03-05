Return-Path: <linux-kernel+bounces-545977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01FA4F4BF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DEB27A6CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC4B189B9D;
	Wed,  5 Mar 2025 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="oTDXhF0a"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4915DBA3;
	Wed,  5 Mar 2025 02:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741141950; cv=none; b=dDIWXl+vmKnjROzAfMBgOREc2mVXnuyNwUtXph4Mfi0oeODCobCb3p55mAyGKRzp6rftZK+PoDY+NxG+S81Ja8lDbHrtVfH9IUHwFIfi+Ox/WV7A6y92x3Y3fU1M25lU8n1UHhubQeOg1Z6W0+479VWkajCMdNmB7rI9HUjjYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741141950; c=relaxed/simple;
	bh=VFHlaOkps4gELsNG93bMey9hkOJsRA3mqrGKinS7NNw=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=Uzpo4LuSLPDKDfOftsRCA9qDNwdb/IlFm33/aIPIk9HtWkIIzenyC3XFYylSU7LgwDc8DoHvXK+1o+ZTuRK4PrI5tvbxvzsdKKFdC07phWzjSs6dZ8Fdf+7qVhKnky6LaeelUmERkwERDQ6AhrixPi1/+mgBa0Fb3D/5L0jLitY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=oTDXhF0a reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=UOhnFF01l7HOjYg5x6uMcW+B9fbrcWjnbUnMIBSb6g4=; b=o
	TDXhF0ao8rGr8j8jqZSvZyPwCn4bRtMbMUqolB3b0d33NLVtg8Do+zE4hoqyKSPc
	zOJuUqn0UDL/56pNMjEk7XWHy1TvHLbfex2UCxGVCdwMmtrpxuop+RhsFVrPw0Fo
	ipgMP4wcY2oyQyyBZFmm/QVjGPIMLLCZxeuxv5CPHg=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Wed, 5 Mar 2025 10:30:55 +0800 (CST)
Date: Wed, 5 Mar 2025 10:30:55 +0800 (CST)
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
X-NTES-SC: AL_Qu2fA/2fvkAu4yiaZukfmkcVgOw9UcO5v/Qk3oZXOJF8jDDp2ycwUUJSDXLaweO0FQ+OmgmGXTtC9/R7f4VTVaQNuZe6Rui3nVzOCdmFQHxStA==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <25401bfa.291d.19564244e54.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgD3Xw5ft8dn2jd2AA--.4215W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAMHXmfHsp5IAwACsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFBpb3RyLAoK5ZyoIDIwMjUtMDMtMDQgMjE6MTI6NTDvvIwiUGlvdHIgT25pc3pjenVrIiA8
cGlvdHIub25pc3pjenVrQGdtYWlsLmNvbT4g5YaZ6YGT77yaCj4KPgo+PiBXaWFkb21vxZvEhyBu
YXBpc2FuYSBwcnpleiBBbmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4gdyBkbml1IDEgbWFyIDIw
MjUsIG8gZ29kei4gMTM6MjQ6Cj4+IAo+PiAKPj4gSGkgUGlvdHIsCj4+IAo+Pj4gCj4+PiBpcyBp
dCB3b3J0aCB0byBwbGF5IHdpdGggdGhpcyBvciBpdCBpcyB0b28gZWFybHk/Cj4+IAo+PiBJIHRo
aW5rIHlvdSBjb3VsZCBnaXZlIGl0IGEgdHJ5IGlmIGl0IHVzaW5nIHRoZSBTdGFuZGFyZCBEUO+8
iG5vbi1BTFQgbW9kZe+8iSBwb3J0IGZvciBvdXRwdXQuIAo+PiBTaW5jZSBJIGRvbid0IGN1cnJl
bnRseSBoYXZlIGEgZGV2ZWxvcG1lbnQgYm9hcmQgd2l0aCBEUDEgb3V0cHV0IGF2YWlsYWJsZSwg
SSBoYXZlbid0IGJlZW4KPj4gYWJsZSB0byB0ZXN0IGl0IHlldC4gQXMgZm9yIHRoZSBUeXBlLUMg
QWx0ZXJuYXRlIE1vZGUgb3V0cHV0LCBzb21lIHBhdGNoZXMgYXJlIHN0aWxsIHJlcXVpcmVkIAo+
PiBJJ2xsICBzZW5kIGl0IHdpdGggVjIgdG9tb3Jyb3cgb3IgbmV4dCB3ZWVrLgo+PiBGZWVsIGZy
ZWUgdG8gbGV0IG1lIGtub3cgaWYgSWYgeW91IGVuY291bnRlciBhbnkgaXNzdWVz44CCCj4+IAo+
Cj5BbmR5LAo+SSBhZGRlZCBkcDEgZW5hYmxlbWVudCBpbiByb2NrNSBpdHggbGlrZSB0aGlzOiBo
dHRwczovL2dpc3QuZ2l0aHViLmNvbS93YXJwbWUvYmRkZjc1OTEyMTkzZjU3NzI0YzQ5MjE2ZDVk
ODVkNGEKPlVuZm9ydHVuYXRlbHkgaXQgbm90IHdvcmtzLgo+Rm9yIC9zeXMva2VybmVsL2RlYnVn
L2RyaS8wL3N0YXRlIC0gcGxzIHNlZSBhYm92ZSBsaW5r4oCmCj5J4oCZbSBub3Qgc3VyZTogZG8g
aSBtaXNzZWQgc29tZXRoaW5nIGluIGR0IG9yIHJhdGhlciBpc3N1ZSBpc3N1ZSAgaXMgaW4gZHAg
Y29kZS4uLgoKSSBvbmx5IHNlZSB0aGUgSERNSSBjb25uZWN0b3IgZnJvbSB5b3VyIGRyaS9zdGF0
ZSA7IHNvIGl0IGFwcGVhcnMgdGhlIERQIGRyaXZlciBoYXNuJ3QgYmVlbiBzdWNjZXNzZnVsbHkK
aW5pdGlhbGl6ZWTvvIhJIHRoaW5rIGtlcm5lbCBkbWVzZyBjYW4gdGVsbCB0aGF077yJLiAKSGF2
ZSB5b3UgZW5hYmxlZCBDT05GSUdfUk9DS0NISVBfRFdfRFAgPyBUaGlzIGlzIG5lZWRlZC4KCgo+
Cj5GWUk6IHNjaGVtYXRpYzogaHR0cHM6Ly9kbC5yYWR4YS5jb20vcm9jazUvNWl0eC92MTExMC9y
YWR4YV9yb2NrXzVpdHhfdjExMTBfc2NoZW1hdGljLnBkZgo+Cj4KPgo=

