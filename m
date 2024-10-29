Return-Path: <linux-kernel+bounces-386173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2B9B4006
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4AC2834DB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9654E188A3B;
	Tue, 29 Oct 2024 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="WO/nQmSl"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB608172A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167094; cv=none; b=MRavxluUWq/R5jWF4L/s7SEUMkqZkeo3jBav+eAGyM9UtQPMdVxL6RfwZmY773LwYUOXEmowb6OwXcNShYMTppaRQT98zZSg4rXhjud3Jw8FpZ+E11fpX+pHxwuatumbB9JN9f/caL0dZpv5j/y9yYYxJwYPeKlfEf0uT/+Gc5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167094; c=relaxed/simple;
	bh=Mgbkhyg9SzRwO328g2sh8WEP0WZ2JpVb/UKnB5toi5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=EJFYYSRzQsUbp6YkhEaDsre+Zx2mqMNRxOGWz6lby3SQZaEUXts64GfXA0k9rhVPJpxpCwvSBjiWGOTtctdPumTO0G1ZdL4VGEMkQA48NzRY0TCYWLaT1biO5dgJW5985/q6U0gMDuN0qVQVI336IRzgVeDmEfLuEXJzLNvMPLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=WO/nQmSl reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=RnxTHzDdk8US5iJPkSYszsHCdC7XWQuzUMfU45N1Fgo=; b=W
	O/nQmSlz6xXHvDCXVH4ta3teWIECLq8aJB3BjMdplaRQ2cS1cqAH6UOLEK/qr8Qy
	pQlSDafCrbglLN9jSlX2dHoLOC91xE93X0LgPB3usWNnd2ivFKka+GCnpz/BS59H
	wXkgMIhbzoLOXtTVEwB0pLT5JTBMytjOJOi/cHsqT4=
Received: from huanglei814$163.com ( [111.48.58.10] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Tue, 29 Oct 2024 09:57:51 +0800
 (CST)
Date: Tue, 29 Oct 2024 09:57:51 +0800 (CST)
From: huanglei  <huanglei814@163.com>
To: "Will Deacon" <will@kernel.org>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: Re:Re:Re: [PATCH] arm64/Kconfig: introduce GENERIC_ISA_DMA
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <26ed8fbb.1809.192d5ef13e5.Coremail.huanglei814@163.com>
References: <20241025011641.4858-1-huanglei814@163.com>
 <20241028150544.GA2445@willie-the-truck>
 <26ed8fbb.1809.192d5ef13e5.Coremail.huanglei814@163.com>
X-NTES-SC: AL_Qu2YAv2duEgs5yKRbOkfm0cTguY+X8W4uv0h2IVSPJ5+jCnr6A8xUXBMM3bR2dCOEA2RrheYWxxjz/ZzRpRxWJIZl2Em6cGsLGHMIofV+9aZzQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7f60ff1f.1d51.192d5fe6248.Coremail.huanglei814@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgDXHyMfQSBnoqMZAA--.60957W
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbiLBSG9mcfmUrE3QAGs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

ICAgVGhlcmUgd2FzIGEgc2xpZ2h0IHdvcmQgc3BlbGxpbmcgZXJyb3IgaW4gdGhlIHByZXZpb3Vz
IHJlcGx5o6wgTm93IGNvcnJlY3QgaXQuCgogRXZlbiBpZiBNQVhfRE1BX0NIQU5ORUxTIGlzIG5v
dCBkZWZpbmVkLCBhcyBsb25nIGFzIEdFTkVSSUNfSVNBX0RNQSBpcyBlbmFibGVko6wgcmVxdWVz
dF9kbWEvZnJlZV9kbWEgIGZ1bmN0aW9uIHdpbGwgYWxzbyBiZSBleHBvcnRlZCwgYW5kIG90aGVy
IG1vZHVsZXMgdXNpbmcgdGhlc2UgdHdvIGludGVyZmFjZXMgd2lsbCBub3QgZW5jb3VudGVyIGxp
bmsgZXJyb3JzLgpJIGRvbid0IGtub3cgd2h5IG90aGVycyBoYXZlbid0IG5vdGljZWQsIGJ1dCBJ
IGRpc2NvdmVyZWQgaXQgd2hlbiBkZWJ1Z2dpbmcgcGNpZSBwYXJhbGxlbCBwb3J0IGRyaXZlcnMu
ICBBbmQgdGhlIGFybS9LY29uZmlnICBoYXMgYmVlbiBhcm91bmQgZm9yIGEgbG9uZyB0aW1lLgoK
QmVzdCByZWdhcmRzIQoKPkF0IDIwMjQtMTAtMjggMjI6MDU6NDUsICJXaWxsIERlYWNvbiIgPHdp
bGxAa2VybmVsLm9yZz4gd3JvdGU6Cj4+T24gRnJpLCBPY3QgMjUsIDIwMjQgYXQgMDk6MTY6NDFB
TSArMDgwMCwgaHVhbmdsZWk4MTQgd3JvdGU6Cj4+PiBGcm9tOiBodWFuZ2xlaSA8aHVhbmdsZWlA
a3lsaW5vcy5jbj4KPj4+IAo+Pj4gRW5hYmxlIEdFTkVSSUNfSVNBX0RNQSBmZWF0dXJlIG9uIGFy
bTY0IHBsYXRmb3JtLAo+Pj4gdGh1cywgcmVxdWVzdF9kbWEgYW5kIGZyZWVfZG1hIGludGVyZmFj
ZSBjYW4gYmUgZXhwb3J0Lgo+Pj4gYW5kIGRyaXZlciBtb2R1bGVzIGNhbiB1c2UgdGhlIHRoaXMg
aW50ZXJmYWNlcyBvbiBhcm02NAo+Pj4gcGxhdGZvcm0uCj4+PiAKPj4+IEN1cnJlbnRseSwgbWFu
eSBwY2llIHBhcmFsbGVsIHBvcnQgZHJpdmVycyBzdGlsbCB1c2UgdGhlc2UKPj4+IGludGVyZmFj
ZXMgd2hlbiBwb3J0ZWQgdG8gYXJtNjQgcGxhdGZvcm0uCj4+Cj4+V2h5IGhhcyBpdCB0YWtlbiBz
byBsb25nIGZvciBhbnlib2R5IHRvIG5vdGljZT8KPj4KPj4+IFNpZ25lZC1vZmYtYnk6IGh1YW5n
bGVpIDxodWFuZ2xlaUBreWxpbm9zLmNuPgo+Pj4gLS0tCj4+PiAgYXJjaC9hcm02NC9LY29uZmln
IHwgMyArKysKPj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4+PiAKPj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L0tjb25maWcgYi9hcmNoL2FybTY0L0tjb25maWcKPj4+IGlu
ZGV4IGZkOWRmNmRjYzU5My4uOTg2ZWIyNTFmNjhmIDEwMDY0NAo+Pj4gLS0tIGEvYXJjaC9hcm02
NC9LY29uZmlnCj4+PiArKysgYi9hcmNoL2FybTY0L0tjb25maWcKPj4+IEBAIC0zNjcsNiArMzY3
LDkgQEAgY29uZmlnIEdFTkVSSUNfQ1NVTQo+Pj4gIGNvbmZpZyBHRU5FUklDX0NBTElCUkFURV9E
RUxBWQo+Pj4gIAlkZWZfYm9vbCB5Cj4+PiAgCj4+PiArY29uZmlnIEdFTkVSSUNfSVNBX0RNQQo+
Pj4gKwlkZWZfYm9vbCB5Cj4+PiArCj4+Cj4+RG9lcyB0aGlzIGFjdHVhbGx5IGRvIGFueXRoaW5n
IHdpdGhvdXQgTUFYX0RNQV9DSEFOTkVMUyBkZWZpbmVkPwo+Pgo+PldpbGwK

