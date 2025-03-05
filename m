Return-Path: <linux-kernel+bounces-545995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C085A4F4F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 03:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7557D188F3B3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD34155A21;
	Wed,  5 Mar 2025 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="JXixPnoS"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484AF45C18;
	Wed,  5 Mar 2025 02:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143361; cv=none; b=hhTLrUx/iFOZfnUFtEhXSByAr2oZdxJQexUs09FfEuE7+DJJ2JTefyYUTpIq3Ic25Sdex/Ps6sBmlFEQ88s+YHy0Aan67W+PaL6QkeAfbiKdnbOgogh+SJAlkWTortotoVD195h5Vre7N7BXVc1EcxDTCz3eQc1+R9kiD2+tddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143361; c=relaxed/simple;
	bh=qB1Fg5+dAjxOGDDpHSRhLIwRL7ORPyK20ZoH95iVSr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Ejh/zmZRzWy0FKHSEOou0KrI1Co2M+85uMXsq2Bk0/uk3PPzQdK/H+5wNjaWT6ycAvRO0q2BwBcECNQh1TeWToln2Fj3sagvG53IXPskff5Z3lvNR9yS/8pIO+afgTdHaKuUEM+1SvOjSz8/SfLuEmLcFK/tKFrk6QSfqg+4yMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=JXixPnoS reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=1mEvevodehkZr1dVVYVlAIIA3BdOF7abSyN55uGLtjQ=; b=J
	XixPnoSCQtJeUQKXjg/C2pD/lBfXpPyyxF42XyE3bar3H0hHv//PtjCVfTuO2xR3
	5Ka40W9E2gI2LkswQugdFOmbdetS0+fq/sMtyVEM5i8gAk6i0bfa0phouRqfQvDu
	LISesrATrsLHweVqVUku+hrFAFBxT6JQFqtAgpMQLY=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-118 (Coremail) ; Wed, 5 Mar 2025 10:55:17 +0800 (CST)
Date: Wed, 5 Mar 2025 10:55:17 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: "Sebastian Reichel" <sebastian.reichel@collabora.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	detlev.casanova@collabora.com, linux-rockchip@lists.infradead.org,
	"Andy Yan" <andy.yan@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v3 0/3] Add display subsystem dt node on rk3576
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <2627393.Mh6RI2rZIc@diego>
References: <20241231095728.253943-1-andyshrk@163.com>
 <173564980410.21979.2947276365464229762.robh@kernel.org>
 <lfmhqurnpjmfy6pfjxd5aczxujislv2p5bsurcbl7capyt7zv3@hy2twvjj53uz>
 <2627393.Mh6RI2rZIc@diego>
X-NTES-SC: AL_Qu2fA/2fvEsq4SGaZekfmkcVgOw9UcO5v/Qk3oZXOJF8jDDp2ycwUUJSDXLaweO0FQ+OmgmGXTtC9/R7f4VTVaQNmOegLoECOzW/XnS1PDhO3g==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <c9c0a4a.3247.195643a9a86.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:digvCgAXVpgVvcdnp0R2AA--.5758W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkBMHXmfHucNUCgABsf
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhlbGxvLAoK5ZyoIDIwMjUtMDMtMDUgMDU6MTY6NDnvvIwiSGVpa28gU3TDvGJuZXIiIDxoZWlr
b0BzbnRlY2guZGU+IOWGmemBk++8mgo+QW0gRGllbnN0YWcsIDQuIE3DpHJ6IDIwMjUsIDE1OjQ3
OjI4IE1FWiBzY2hyaWViIFNlYmFzdGlhbiBSZWljaGVsOgo+PiBIZWxsbywKPj4gCj4+IE9uIFR1
ZSwgRGVjIDMxLCAyMDI0IGF0IDA2OjU3OjIxQU0gLTA2MDAsIFJvYiBIZXJyaW5nIChBcm0pIHdy
b3RlOgo+PiA+IE9uIFR1ZSwgMzEgRGVjIDIwMjQgMTc6NTc6MTcgKzA4MDAsIEFuZHkgWWFuIHdy
b3RlOgo+PiA+ID4gQXMgdGhlIFZPUFswXSBhbmQgSERNSVsxXSBkcml2ZXIgaGF2ZSBhbHJlYWR5
IGJlZW4gc3VibWl0dGVkIGZvciByZXZpZXcuCj4+ID4gPiBUaGlzIHNlcmllcyBlbmFibGUgaGRt
aSBkaXNwbGF5IG9uIHNpZ2U1IGJvYXJkLgo+PiA+ID4gCj4+ID4gPiBbMF0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtcm9ja2NoaXAvMjAyNDEyMzEwOTA4MDIuMjUxNzg3LTEtYW5keXNo
cmtAMTYzLmNvbS9ULyN0Cj4+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
cm9ja2NoaXAvMjAyNDEyMzEwOTQ0MjUuMjUzMzk4LTEtYW5keXNocmtAMTYzLmNvbS9ULyN0Cj4+
ID4gPiAKPj4gPiA+IENoYW5nZXMgaW4gdjM6Cj4+ID4gPiAtIFNwbGl0IGZyb20gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtcm9ja2NoaXAvMzMzMDU4Ni5hZU5KRllFTDU4QGRpZWdvL1Qv
I3QKPj4gPiA+IAo+PiA+ID4gQW5keSBZYW4gKDMpOgo+PiA+ID4gICBhcm02NDogZHRzOiByb2Nr
Y2hpcDogQWRkIHZvcCBmb3IgcmszNTc2Cj4+ID4gPiAgIGFybTY0OiBkdHM6IHJvY2tjaGlwOiBB
ZGQgaGRtaSBmb3IgcmszNTc2Cj4+ID4gPiAgIGFybTY0OiBkdHM6IHJvY2tjaGlwOiBFbmFibGUg
aGRtaSBkaXNwbGF5IG9uIHNpZ2U1Cj4+ID4gPiAKPj4gPiA+ICAuLi4vYm9vdC9kdHMvcm9ja2No
aXAvcmszNTc2LWFybXNvbS1zaWdlNS5kdHMgfCAgNDcgKysrKysrKwo+PiA+ID4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvcm9ja2NoaXAvcmszNTc2LmR0c2kgICAgICB8IDEyNiArKysrKysrKysrKysr
KysrKysKPj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE3MyBpbnNlcnRpb25zKCspCj4+ID4KPj4g
PiBbLi4uXSAoYSBidW5jaCBvZiB3YXJuaW5ncyBkdWUgdG8gZGVwZW5kZW5jeSBwYXRjaCBzZXJp
ZXMgbm90IHlldAo+PiA+IGJlaW5nIGluIGxpbnV4LW5leHQpCj4+IAo+PiBJIHRoaW5rIGFsbCBk
ZXBlbmRlbmNpZXMgaGF2ZSBsYW5kZWQgbm93LiBCdXQgaXQgbWlnaHQgYmUgc2Vuc2libGUKPj4g
dG8gZG8gYSBxdWljayByZXNlbmQgY29uc2lkZXJpbmcgaG93IG9sZCB0aGlzIGlzLgo+PiAKPj4g
V291bGQgYmUgbmljZSB0byBoYXZlIGluaXRpYWwgUkszNTc2IEhETUkgc3VwcG9ydCBpbiA2LjE1
IDopCj4KPm5vdyB3ZSBjYW4gOi0pCj4KPlRoZSB1cGRhdGUgd2FzIG5vdCB0aGF0IGRpZmZpY3Vs
dCwgc28gZGlkIGl0IG15c2VsZiB3aGVuIGFwcGx5aW5nLgoKVGhhbmtzIGZvciB5b3UgYWxsLCBt
YW55IHRoYW5rcy4KSSBhbHNvIHNlbnQgb3V0IGEgcGF0Y2ggZm9yIGVhbmJsZSBoZG1pIG9uIHJr
MzU3NiBldmIxLgoKCj4KPgo+SGVpa28KPgo+Cg==

