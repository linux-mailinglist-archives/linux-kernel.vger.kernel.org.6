Return-Path: <linux-kernel+bounces-558642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19918A5E8FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 874483B7FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 00:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD006FC5;
	Thu, 13 Mar 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jwfirBU4"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76912E3399;
	Thu, 13 Mar 2025 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741825485; cv=none; b=lSyLb5a0FYXbe+BN1mWdj76arkDU8+9LIGnizrj6g8XflCoudMMIBImkncf0YRwiB3GFW8lV2mrCngX/4a145oCy5dVt0X6e/NTg9D372e3iv4ZppyIAVFTH+8hpozZUJr8axOB8C+pXmSz51OA8xacvczOtwhwQY4dl6rhhTX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741825485; c=relaxed/simple;
	bh=g/P8osRS668Kyv4QSPGTHu7H22Ms7Y6GxAWyc02475Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=W1arwLWWqrCTsh3yHvWlGdGmxryeAvHbC5JuumZTMq+6DtXzjJXWKaDHPaM3lujNdDuXohVGdOaXJcWZVSkH47F3krqlHbXfSyGcLpgP/jlITz82r8jjCgRro9vsF3yMtj26bZ9yLObjh8jtUKO2M5NKJFj9JYDFa8CTTIb+ejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=jwfirBU4 reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=LUIRGjiYhkymirwUyamzHMkT7+5Pwd4TLQYbSIfYGWI=; b=j
	wfirBU4GfIJ6MqCBg3yhHr1WoFm0jK4ShM5ATtANfyx47SSDyJeZXTbtN5uhiIXj
	/M6ZDO1Y2ZSUDw3nXJSPIRg83JGXVtxbOtNBUX0ZfVFOIUEZoxzNfwGYn4dpTsdc
	2Gdmb9j3M2uToA01+Rw2ElbZSZtj/X3ipKlqNGjqPY=
Received: from andyshrk$163.com ( [58.22.7.114] ) by
 ajax-webmail-wmsvr-40-123 (Coremail) ; Thu, 13 Mar 2025 08:23:43 +0800
 (CST)
Date: Thu, 13 Mar 2025 08:23:43 +0800 (CST)
From: "Andy Yan" <andyshrk@163.com>
To: "Piotr Oniszczuk" <piotr.oniszczuk@gmail.com>
Cc: heiko@sntech.de, neil.armstrong@linaro.org,
	sebastian.reichel@collabora.com, lumag@kernel.org,
	devicetree@vger.kernel.org, hjc@rock-chips.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
	yubing.zhang@rock-chips.com, dri-devel@lists.freedesktop.org,
	"Andy Yan" <andy.yan@rock-chips.com>, krzk+dt@kernel.org,
	robh@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re:Re: [PATCH v2 2/7] drm/bridge: synopsys: Add DW DPTX Controller
 support library
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2025 www.mailtech.cn 163com
In-Reply-To: <61E9B36C-8568-4C0E-A9A7-07FF612912AA@gmail.com>
References: <20250312104214.525242-1-andyshrk@163.com>
 <20250312104214.525242-3-andyshrk@163.com>
 <61E9B36C-8568-4C0E-A9A7-07FF612912AA@gmail.com>
X-NTES-SC: AL_Qu2fA/SZukwp5SOcYOlSyjNW+7xfHKv6+qRChMQvQtsqqTHr9T0KcVtuP1XR3//fv0njXmWodzM39rfUa5fI
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <381bbdeb.342.1958ce2b7f8.Coremail.andyshrk@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eygvCgCnT4CPJdJnmyl9AA--.21746W
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqAgPXmfSHTa4sgABsk
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFBpb3RyLArlnKggMjAyNS0wMy0xMiAyMjoyMzoxNe+8jCJQaW90ciBPbmlzemN6dWsiIDxw
aW90ci5vbmlzemN6dWtAZ21haWwuY29tPiDlhpnpgZPvvJoKPgo+Cj4+IFdpYWRvbW/Fm8SHIG5h
cGlzYW5hIHByemV6IEFuZHkgWWFuIDxhbmR5c2hya0AxNjMuY29tPiB3IGRuaXUgMTIgbWFyIDIw
MjUsIG8gZ29kei4gMTE6NDI6Cj4+IAo+PiBGcm9tOiBBbmR5IFlhbiA8YW5keS55YW5Acm9jay1j
aGlwcy5jb20+Cj4+IAo+PiBUaGUgRFcgRFAgVFggQ29udHJvbGxlciBpcyBjb21wbGlhbnQgd2l0
aCB0aGUgRGlzcGxheVBvcnQgU3BlY2lmaWNhdGlvbgo+PiBWZXJzaW9uIDEuNCB3aXRoIHRoZSBm
b2xsb3dpbmcgZmVhdHVyZXM6Cj4+IAo+PiAqIERpc3BsYXlQb3J0IDEuNGEKPj4gKiBNYWluIExp
bms6IDEvMi80IGxhbmVzCj4+ICogTWFpbiBMaW5rIFN1cHBvcnQgMS42MkdicHMsIDIuN0dicHMs
IDUuNEdicHMgYW5kIDguMUdicHMKPj4gKiBBVVggY2hhbm5lbCAxTWJwcwo+PiAqIFNpbmdsZSBT
dHJlYW0gVHJhbnNwb3J0KFNTVCkKPj4gKiBNdWx0aXN0cmVhbSBUcmFuc3BvcnQgKE1TVCkKPj4g
KiBUeXBlLUMgc3VwcG9ydCAoYWx0ZXJuYXRlIG1vZGUpCj4+ICogSERDUCAyLjIsIEhEQ1AgMS4z
Cj4+ICogU3VwcG9ydHMgdXAgdG8gOC8xMCBiaXRzIHBlciBjb2xvciBjb21wb25lbnQKPj4gKiBT
dXBwb3J0cyBSQkcsIFlDYkNyNDo0OjQsIFlDYkNyNDoyOjIsIFlDYkNyNDoyOjAKPj4gKiBQaXhl
bCBjbG9jayB1cCB0byA1OTRNSHoKPj4gKiBJMlMsIFNQRElGIGF1ZGlvIGludGVyZmFjZQo+PiAK
Pj4gQWRkIGxpYnJhcnkgd2l0aCBjb21tb24gaGVscGVycyB0byBtYWtlIGl0IGNhbiBiZSBzaGFy
ZWQgd2l0aAo+PiBvdGhlciBTb0MuCj4+IAo+PiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFlhbiA8YW5k
eS55YW5Acm9jay1jaGlwcy5jb20+Cj4+IAo+PiAtLS0KPj4gCj4+IENoYW5nZXMgaW4gdjI6Cj4+
IC0gRml4IGNvbXBpbGUgZXJyb3Igd2hlbiBidWlsZCBhcyBtb2R1bGUKPj4gLSBBZGQgcGh5IGlu
aXQKPj4gLSBPbmx5IHVzZSBvbmUgZHdfZHBfbGlua190cmFpbl9zZXQKPj4gLSBpbmxpbmUgZHdf
ZHBfcGh5X3VwZGF0ZV92c19lbXBoCj4+IC0gVXNlIGRwX3NkcAo+PiAtIENoZWNrIHJldHVybiB2
YWx1ZSBvZiBkcm1fbW9kZXNldF9sb2NrCj4+IC0gTWVyZ2UgY29kZSBpbiBhdG9taWNfcHJlX2Vu
YWJsZS9tb2RlX2ZpeHVwIHRvIGF0b21pY19jaGVjawo+PiAtIFJldHVybiBOVUxMIGlmIGNhbid0
IGZpbmQgYSBzdXBwb3J0ZWQgb3V0cHV0IGZvcm1hdAo+PiAtIEZpeCBtYXhfbGlua19yYXRlIGZy
b20gcGxhdF9kYXRhCj4+IAo+Cj5BbmR5LAo+Cj5KdXN0IHNtYWxsIFE6IGRvIHYyIG5lZWRzIHNv
bWV0aGluZyBleHRyYSB0byBnZXQgaXQgd29ya2luZyAocGFydGljdWxhciBrZXJuZWwgdmVyIG9y
IGV4dHJhIGRlcGVuZGVuY3kgcGF0Y2hlcyk/Cj5JIGp1c3QgcmVwbGFjZWQgdjEgdG8gdjIgYW5k
IGRwIHN0b3BwZWQgdG8gd29yayBmb3IgbWUuCgpUaGlzIHNlcmllcyBzdGlsbCAgYmFzZWQgb24g
TGludXggNi4xNCByYzQuCgpEaWQgeW91IGFwcGx5IHRoZSB0aHJlZSBkZXBlbmRlbmN5IHBhdGNo
IG1lbnRpb25lZCBpbiBteSBjb3ZlciBsZXR0ZXI/CgoKPgo+ZS5nLiBvbiByb2NrNWEgaeKAmW0g
Z2V0dGluZzoKPgo+cm9vdEBteXRoLWZyb250ZW5kLWZhZmM1M2I1OTFhNjp+ICMgZG1lc2cgfCBn
cmVwIGRybQo+WyAgICA5LjI0NTI4NF0gcGFudGhvciBmYjAwMDAwMC5ncHU6IFtkcm1dIGNsb2Nr
IHJhdGUgPSAxOTgwMDAwMDAKPlsgICAgOS4yNDk0NjRdIHBhbnRob3IgZmIwMDAwMDAuZ3B1OiBb
ZHJtXSBtYWxpLWc2MTAgaWQgMHhhODY3IG1ham9yIDB4MCBtaW5vciAweDAgc3RhdHVzIDB4NQo+
WyAgICA5LjI0OTQ3Ml0gcGFudGhvciBmYjAwMDAwMC5ncHU6IFtkcm1dIEZlYXR1cmVzOiBMMjow
eDcxMjAzMDYgVGlsZXI6MHg4MDkgTWVtOjB4MzAxIE1NVToweDI4MzAgQVM6MHhmZgo+WyAgICA5
LjI0OTQ3NF0gcGFudGhvciBmYjAwMDAwMC5ncHU6IFtkcm1dIHNoYWRlcl9wcmVzZW50PTB4NTAw
MDUgbDJfcHJlc2VudD0weDEgdGlsZXJfcHJlc2VudD0weDEKPlsgICAgOS4yNTc5NzldIHBhbnRo
b3IgZmIwMDAwMDAuZ3B1OiBbZHJtXSBGaXJtd2FyZSBwcm90ZWN0ZWQgbW9kZSBlbnRyeSBub3Qg
YmUgc3VwcG9ydGVkLCBpZ25vcmluZwo+WyAgICA5LjI1ODAzMF0gcGFudGhvciBmYjAwMDAwMC5n
cHU6IFtkcm1dIEZpcm13YXJlIGdpdCBzaGE6IDgxNGI0N2I1NTExNTkwNjdiNjdhMzdjNGU5YWRk
YTQ1OGFkOWQ4NTIKPlsgICAgOS4yNTg2MDRdIHBhbnRob3IgZmIwMDAwMDAuZ3B1OiBbZHJtXSBD
U0YgRlcgdXNpbmcgaW50ZXJmYWNlIHYxLjEuMCwgRmVhdHVyZXMgMHgwIEluc3RydW1lbnRhdGlv
biBmZWF0dXJlcyAweDcxCj5bICAgIDkuMjU5NjcxXSBbZHJtXSBJbml0aWFsaXplZCBwYW50aG9y
IDEuMy4wIGZvciBmYjAwMDAwMC5ncHUgb24gbWlub3IgMAo+WyAgICA5LjMyNDM1M10gcm9ja2No
aXAtZHJtIGRpc3BsYXktc3Vic3lzdGVtOiBib3VuZCBmZGQ5MDAwMC52b3AgKG9wcyB2b3AyX2Nv
bXBvbmVudF9vcHMpCj5bICAgIDkuMzI0NjE3XSByb2NrY2hpcC1kcm0gZGlzcGxheS1zdWJzeXN0
ZW06IGJvdW5kIGZkZTUwMDAwLmRwIChvcHMgZHdfZHBfcm9ja2NoaXBfY29tcG9uZW50X29wcykK
PlsgICAgOS4zMjUyMDJdIHJvY2tjaGlwLWRybSBkaXNwbGF5LXN1YnN5c3RlbTogYm91bmQgZmRl
ODAwMDAuaGRtaSAob3BzIGR3X2hkbWlfcXBfcm9ja2NoaXBfb3BzKQo+WyAgICA5LjMyNTUwNl0g
W2RybV0gSW5pdGlhbGl6ZWQgcm9ja2NoaXAgMS4wLjAgZm9yIGRpc3BsYXktc3Vic3lzdGVtIG9u
IG1pbm9yIDEKPlsgICAgOS4zMjU1MzFdIHJvY2tjaGlwLWRybSBkaXNwbGF5LXN1YnN5c3RlbTog
W2RybV0gQ2Fubm90IGZpbmQgYW55IGNydGMgb3Igc2l6ZXMKPlsgICAgOS4zMjU1OTRdIHJvY2tj
aGlwLWRybSBkaXNwbGF5LXN1YnN5c3RlbTogW2RybV0gQ2Fubm90IGZpbmQgYW55IGNydGMgb3Ig
c2l6ZXMgIAo+Cj5kcCBzdGF0dXMgaXMgIm5vdCBjb25uZWN0ZWQiCj4KPnJlcGxhY2luZyBvbmx5
IHRoaXMgcGF0Y2ggYmFjayB0byB2MSBicmluZ3MgZHAgYmFjayB0byB3b3JrLgo+Cj4K

