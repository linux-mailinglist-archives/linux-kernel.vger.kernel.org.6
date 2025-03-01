Return-Path: <linux-kernel+bounces-539924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B3FA4AAE9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EE43B7B84
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62681DED51;
	Sat,  1 Mar 2025 12:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="S2wcqCYj"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087ED1CAA99;
	Sat,  1 Mar 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740831947; cv=none; b=HFh/1ZFDEmrx9e6SRt785tvBlk+7mX7z3u4gRosTqWFh74T1MRp+2CiW6vRfwLlcgcSOht92gNnrS27CdjnSGylBxAi9gGLgh6DYZniHWltGFvBxAIm8wavXQGtOOMK5IzQWuMHz/IBDAGFqhnWCcy4e/i0m175mhQL5nlFE+Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740831947; c=relaxed/simple;
	bh=uk/TVbQmEdhrRriBBk8oaPcQkjOcMSzkB2nVTddFJcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Jbcp6VPTaTewjz3q3UOmfIudu1mPt0VnxOMFXvRw9yS4awusJX53/UwXY7xnBCVfwkcj7NdFzYggxYvFmuMgaBRK4WdCX47MpkYm5vYHuiO6qxyLnyKZtzxzfzR4pco4q5PM1AKYhzmgzsVUvrxvmkVWSiBL7/vb5flt1unc8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=S2wcqCYj reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=OoaYmHX0XxMb3ZGRzqhrOqA+8ik0zFy9oaiXUktOM0A=; b=S
	2wcqCYjrorMjz0J+aoOHGkQMzk1/HZoe378Dg6qq2Bvi3+iWO4pVzMiKlm51zlXM
	NHUpBgtTGvLaityI1KHr6V/hyQNAdurRMt+4Bx9dU4aTL/rde6dix2eCHPFk5te1
	ctQ9plpH2Zi2crBPTys9FKRwmlJtjWsvcS+UNB2Vl8=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Sat, 1 Mar 2025 20:24:34 +0800 (CST)
Date: Sat, 1 Mar 2025 20:24:34 +0800 (CST)
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
In-Reply-To: <AC3DE87B-64B1-4C34-8E1B-3900E2C53AA3@gmail.com>
References: <20250223113036.74252-1-andyshrk@163.com>
 <AC3DE87B-64B1-4C34-8E1B-3900E2C53AA3@gmail.com>
X-NTES-SC: AL_Qu2fAvSYvkAs4imaYekfmkcVgOw9UcO5v/Qk3oZXOJF8jCHpyAceeXBTHlbv/PCDBDqXkAiHVDdI89xeb5lhU4kMvpw71wI8xCMUqheypabd2w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7b8767fc.3607.19551aa5f74.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:aygvCgA3X+eD_MJna0JzAA--.55803W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hoDXmfC+twJKAABs2
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFBpb3RyLAoK5ZyoIDIwMjUtMDMtMDEgMDQ6MzA6MzPvvIwiUGlvdHIgT25pc3pjenVrIiA8
cGlvdHIub25pc3pjenVrQGdtYWlsLmNvbT4g5YaZ6YGT77yaCj4KPgo+PiBXaWFkb21vxZvEhyBu
YXBpc2FuYSBwcnpleiBBbmR5IFlhbiA8YW5keXNocmtAMTYzLmNvbT4gdyBkbml1IDIzIGx1dCAy
MDI1LCBvIGdvZHouIDEyOjMwOgo+PiAKPj4gRnJvbTogQW5keSBZYW4gPGFuZHkueWFuQHJvY2st
Y2hpcHMuY29tPgo+PiAKPj4gCj4+IFRoZXJlIGFyZSB0d28gRFcgRFBUWCBiYXNlZCBEaXNwbGF5
UG9ydCBDb250cm9sbGVyIG9uIHJrMzU4OCB3aGljaAo+PiBhcmUgY29tcGxpYW50IHdpdGggdGhl
IERpc3BsYXlQb3J0IFNwZWNpZmljYXRpb24gVmVyc2lvbiAxLjQgd2l0aAo+PiB0aGUgZm9sbG93
aW5nIGZlYXR1cmVzOgo+PiAKPj4gKiBEaXNwbGF5UG9ydCAxLjRhCj4+ICogTWFpbiBMaW5rOiAx
LzIvNCBsYW5lcwo+PiAqIE1haW4gTGluayBTdXBwb3J0IDEuNjJHYnBzLCAyLjdHYnBzLCA1LjRH
YnBzIGFuZCA4LjFHYnBzCj4+ICogQVVYIGNoYW5uZWwgMU1icHMKPj4gKiBTaW5nbGUgU3RyZWFt
IFRyYW5zcG9ydChTU1QpCj4+ICogTXVsdGlzdHJlYW0gVHJhbnNwb3J0IChNU1QpCj4+ICrvga5U
eXBlLUMgc3VwcG9ydCAoYWx0ZXJuYXRlIG1vZGUpCj4+ICogSERDUCAyLjIsIEhEQ1AgMS4zCj4+
ICogU3VwcG9ydHMgdXAgdG8gOC8xMCBiaXRzIHBlciBjb2xvciBjb21wb25lbnQKPj4gKiBTdXBw
b3J0cyBSQkcsIFlDYkNyNDo0OjQsIFlDYkNyNDoyOjIsIFlDYkNyNDoyOjAKPj4gKiBQaXhlbCBj
bG9jayB1cCB0byA1OTRNSHoKPj4gKiBJMlMsIFNQRElGIGF1ZGlvIGludGVyZmFjZQo+PiAKPj4g
VGhlIGN1cnJlbnQgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIHNlcmllcyBvbmx5IHN1cHBvcnRzIGJh
c2ljIGRpc3BsYXkgb3V0cHV0cy4KPj4gSSBjb25kdWN0ZWQgdGVzdHMgaW4gMTA4MHAgYW5kIDRL
QDYwIFlDYkNyNDoyOjAgbW9kZXM7IHRoZSBBTFQvVHlwZS1DIG1vZGUKPj4gaGFzbid0IGJlZW4g
dGVzdGVkIHlldCwgYnV0IEkgc3VzcGVjdCBpdCB3aWxsIGxpa2VseSB3b3JrLiBIRENQIGFuZCBh
dWRpbwo+PiBmZWF0dXJlcyByZW1haW4gdW5pbXBsZW1lbnRlZC4gRm9yIFJLMzU4OCwgaXQncyBv
bmx5IHN1cHBvcnQgU1NULCB3aGlsZSBpbgo+PiB0aGUgdXBjb21pbmcgUkszNTc2LCBpdCBjYW4g
c3VwcG9ydCBNU1Qgb3V0cHV0Lgo+PiAKPgo+QW5keSwKPgo+SXMgdGlzIHNlcmllcyBlbm91Z2gg
dG8gZ2V0IHVzYmMxL2RwMSB3b3JraW5nIGFzIHZpZGVvIG91dHB1dCA/Cj4oYXNzdW1pbmcgaSB3
aWxsIGFkZCBuZWNlc3NhcnkgY29kZSBpbiBkdCkgCj4KPnJvY2s1LWl0eCBoYXMgc2Vjb25kIGhk
bWkgcG9ydCB1c2luZyB1c2JjMS9kcDEgbGFuZXMgMiwzIHRvIHJhNjIwIGRwLT5oZG1pIGNvbnZl
cnRlcgo+Cj5pcyBpdCB3b3J0aCB0byBwbGF5IHdpdGggdGhpcyBvciBpdCBpcyB0b28gZWFybHk/
CgpJIHRoaW5rIHlvdSBjb3VsZCBnaXZlIGl0IGEgdHJ5IGlmIGl0IHVzaW5nIHRoZSBTdGFuZGFy
ZCBEUO+8iG5vbi1BTFQgbW9kZe+8iSBwb3J0IGZvciBvdXRwdXQuIApTaW5jZSBJIGRvbid0IGN1
cnJlbnRseSBoYXZlIGEgZGV2ZWxvcG1lbnQgYm9hcmQgd2l0aCBEUDEgb3V0cHV0IGF2YWlsYWJs
ZSwgSSBoYXZlbid0IGJlZW4KYWJsZSB0byB0ZXN0IGl0IHlldC4gQXMgZm9yIHRoZSBUeXBlLUMg
QWx0ZXJuYXRlIE1vZGUgb3V0cHV0LCBzb21lIHBhdGNoZXMgYXJlIHN0aWxsIHJlcXVpcmVkIApJ
J2xsICBzZW5kIGl0IHdpdGggVjIgdG9tb3Jyb3cgb3IgbmV4dCB3ZWVrLgpGZWVsIGZyZWUgdG8g
bGV0IG1lIGtub3cgaWYgSWYgeW91IGVuY291bnRlciBhbnkgaXNzdWVz44CCCgoKPiAK

