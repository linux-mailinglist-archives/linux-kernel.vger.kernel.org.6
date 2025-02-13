Return-Path: <linux-kernel+bounces-513109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F246A3418D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC07A4D74
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DBD2222D4;
	Thu, 13 Feb 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="KFfPd+Yh"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1B2222BC
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455985; cv=pass; b=sUHo6RcchPgGpe5mW1FVI49O2/n4ocwoXAiOCVwB8xMl6Hmen6Ztfe8f9Tnh/Wgt1OyLFbq8c4zPhc73wwGn0nv5FC+dcFBaRyYFVnqFfxRpeIRUQ+7XFcQysqe/+TSwQ16k2a8lcGr4v4NRVREcKXTzvoFSbSuWnVn2Ttk7Q1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455985; c=relaxed/simple;
	bh=hKrV+aMIT+qu3FXNIS4n4EGj+5QDCkbTfzE3p7r1ZHw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ASYfR6TwzTwFufRF5KJjp/nGanXSKyjvOUxUhMFCln5iCOxUWKX7XUL8AFCrj9levX7ewMdRwI7Q8C6OzL54tYMVSOiBGcH8fTYNl9Hx7x6DKHFKvyv8ElDifL40FFz+oHSWwU8Ust7KOektN+3Lo1ax66q1CU8q4YMhGPxADh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=KFfPd+Yh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
ARC-Seal: i=1; a=rsa-sha256; t=1739455973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A4/k8Kc95K05s8Lir9RWavqF2gsPpctAHAuiizBdxsFC+57yq1aWjqzhbSEL21eO+O1SkQwKredjO5gegRItaZL3CEctSo4hkNpApf1pWAD1aSYjHD8rEW1NITtYvQCNAyoG0p9nE/tRM7RQHxvHLD7kGUnPGGDwyC6F1m/gHvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739455973; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hKrV+aMIT+qu3FXNIS4n4EGj+5QDCkbTfzE3p7r1ZHw=; 
	b=f46mJmmbWufwl2kWIjpXeEhCLFZ0YELBee29a9E0xxBvZKXYJvKXEytALSxX4fyuJeYe3u8DJ1yPUWOxHpyk5NP8/458k2HSM+WdOZmSyYiVp3L1RRkRAYvq5T7Kb6DxSBjCQcdIcHclKdJOkWfqnGmHR57Y7NIwLbyLvJSkobc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739455973;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=hKrV+aMIT+qu3FXNIS4n4EGj+5QDCkbTfzE3p7r1ZHw=;
	b=KFfPd+YhDtKA5z2PZwJ4wZtTwU4dC5SF5iTC50HvCN4E3EZg/Jx2mRnWP8nW9sCt
	2CpR6RAmZixRUzUNU10rVFiczVyOgjv9Ox+WldMV71dml8sQGLGOAq/x8DIsjH+yS5H
	uSkPQdncXDKs6ST8kI7F3RdvjrfnbKJFR6QK+7Xcc/WCnsCAcPLdAbYOap0q812nlIY
	1+5+bUzpTMhqSkVaKLNCgM2QuO2BaBQ/CZAh6SLPifYmkZXOupwUSwsoOZaqz2sHPyq
	mxF1BpZi8c9TI5BPDrxmeU4dS4Q4FM0tXsi0y0kULrK6tbAjHvvmj5QybEaxu/gQ00D
	Q3nIPKzd4Q==
Received: by mx.zohomail.com with SMTPS id 1739455971954542.0288903467681;
	Thu, 13 Feb 2025 06:12:51 -0800 (PST)
Message-ID: <632b7f807d51d8d6f2eef075e60b756e1e0c78f4.camel@icenowy.me>
Subject: Re: [PATCH 2/2] nvme-pci: skip CMB blocks incompatible with PCI P2P
 DMA
From: Icenowy Zheng <uwu@icenowy.me>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 22:12:45 +0800
In-Reply-To: <20250213055825.GD19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me>
	 <20250212170444.16138-3-uwu@icenowy.me> <20250213055825.GD19370@lst.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

5ZyoIDIwMjUtMDItMTPmmJ/mnJ/lm5vnmoQgMDY6NTggKzAxMDDvvIxDaHJpc3RvcGggSGVsbHdp
Z+WGmemBk++8mgo+IE9uIFRodSwgRmViIDEzLCAyMDI1IGF0IDAxOjA0OjQ0QU0gKzA4MDAsIElj
ZW5vd3kgWmhlbmcgd3JvdGU6Cj4gPiArwqDCoMKgwqDCoMKgwqAvKgo+ID4gK8KgwqDCoMKgwqDC
oMKgICogQ29udHJvbGxlcnMgbWF5IHN1cHBvcnQgYSBDTUIgc2l6ZSBsYXJnZXIgdGhhbiB0aGVp
cgo+ID4gQkFSLAo+ID4gK8KgwqDCoMKgwqDCoMKgICogZm9yIGV4YW1wbGUsIGR1ZSB0byBiZWlu
ZyBiZWhpbmQgYSBicmlkZ2UuIFJlZHVjZSB0aGUKPiA+IENNQiB0bwo+ID4gK8KgwqDCoMKgwqDC
oMKgICogdGhlIHJlcG9ydGVkIHNpemUgb2YgdGhlIEJBUgo+ID4gK8KgwqDCoMKgwqDCoMKgICov
Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoc2l6ZSA+IGJhcl9zaXplIC0gb2Zmc2V0KQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNpemUgPSBiYXJfc2l6ZSAtIG9mZnNldDsKPiAK
PiBOaXQ6IHVzZSB1cCB0aGUgZnVsbCA4MCBjaGFyYWN0ZXJzIGZvciB0aGUgY29tbWVudCwgYW5k
IG1heWJlIHN3aXRjaAo+IHRoZSBhYm92ZSBleHByZXNzaW9uIHRvIHVzZSB0aGUgbWluKCkgaGVs
cGVyLgoKSSBhbSBvbmx5IG1vdmluZyBhcm91bmQgZXhpc3RpbmcgY29kZSBoZXJlLgoKTWF5YmUg
SSBzaG91bGQgcmVmYWN0b3IgdGhlIGNvZGUgaGVyZSBhbmQgdGhlbiBtb3ZlIGl0PwoKPiAKPiA+
ICvCoMKgwqDCoMKgwqDCoGlmICghSVNfQUxJR05FRChzaXplLCBtZW1yZW1hcF9jb21wYXRfYWxp
Z24oKSkgfHwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoCAhSVNfQUxJR05FRChwY2lfcmVzb3Vy
Y2Vfc3RhcnQocGRldiwgYmFyKSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgbWVtcmVtYXBfY29tcGF0X2FsaWduKCkpKQo+IAo+IFRoZXNlIGNvbXBh
dCBuYW1lcyBsb29rZWQgb2RkIHRvIG1lLCBidXQgaXQgbG9va3MgbGlrZSB0aGV5IGFyZQo+IGlu
ZGVlZAo+IHRoZSBwcm9wZXIgaW50ZXJmYWNlIGhlcmUuwqAgU28gbW9kdWxvIHRoZSBsaXR0bGUg
c3R5bGUgdGhpbmdzIGFib3ZlCj4gdGhpcyBsb29rcyBnb29kLCB0aGFua3MgYSBsb3QhCj4gCgo=


