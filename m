Return-Path: <linux-kernel+bounces-386164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E133A9B3FED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9D71C21EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C57680C02;
	Tue, 29 Oct 2024 01:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="HEdXs86z"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0449A38385
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730166102; cv=none; b=Y//KNIRpCQ3aSzJi1KwV0R6e/NOHVMmGmrc/hWnh5oVe4doO5XXQRzOOhC0ZWf7kk053u0rxNhxcnHStvEto7LIENKk8IncSbdoARRR69mS0Ar5Ad+Drn+efkBKECz/5wsN4lFQQ/MyYEsMPR8pic7SUl1hldFoWDPk4MRGkHG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730166102; c=relaxed/simple;
	bh=iwv3lrNEiBfplVrUYpxy6EF1KmIplolyImTr8ZDkzZk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=iqmiaRle8lvEKDMVMtbUcEA+DFQr1F2xzF4C1PAaL+Z2iMhYH+bwyzDY1/Wh7cRdWM0BI/pLVMhfbod1yckbC0VlZjjxEFOtw//fiopdh241cyrXCoFi/7vj3Zw2/U0OGEAnHf7HEl1NF5FSvpSguwKkK3i0tpKCChIeoc6Z/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=HEdXs86z reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2Vz+MeuTf+UwEcWPoU/k4NxqWMXkbetMObceN4ZkTMo=; b=H
	EdXs86zizvlWzeNr80qP94i4Zx27fwSuBCzqqU01CMJXLEpEhty3zw9opZdog1Ql
	iUw72btB2KCtE6PFVrC1WZl/q0Pwgylaqou/AUop8UBS1S7ByH/bt7KLuTDaCJg2
	O/PcR/9kDEPaSum24SyNHQU7ToOCs50Wr8EzJM3X9E=
Received: from huanglei814$163.com ( [111.48.58.10] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Tue, 29 Oct 2024 09:41:08 +0800
 (CST)
Date: Tue, 29 Oct 2024 09:41:08 +0800 (CST)
From: huanglei  <huanglei814@163.com>
To: "Will Deacon" <will@kernel.org>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: Re:Re: [PATCH] arm64/Kconfig: introduce GENERIC_ISA_DMA
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20241028150544.GA2445@willie-the-truck>
References: <20241025011641.4858-1-huanglei814@163.com>
 <20241028150544.GA2445@willie-the-truck>
X-NTES-SC: AL_Qu2YAv2duUgt7iGRZekfm0cTguY+X8W4uv0h2IVSPJ5+jCnr6A8xUXBMM3bR2dCOEA2RrheYWxxjz/ZzRpRxWJIZvffIL7e7tfTH7+SGJGUMNQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <26ed8fbb.1809.192d5ef13e5.Coremail.huanglei814@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iCgvCgDnD740PSBnPJwZAA--.61000W
X-CM-SenderInfo: xkxd0wxohlmiqu6rljoofrz/1tbiLBSG9mcfmUrE3QAEs+
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CiAgICBFdmVuIGlmIE1BWF9TTUFfQ0FOTkVMUyBpcyBub3QgZGVmaW5lZCwgYXMgbG9uZyBhcyBH
RU5FVElDLVNJQV9ETUEgaXMgZW5hYmxlZKOsIHJlcXVlc3Rfcm1hL2ZyZWVfcm1hICBmdW5jdGlv
biB3aWxsIGFsc28gYmUgZXhwb3J0ZWQsIGFuZCBvdGhlciBtb2R1bGVzIHVzaW5nIHRoZXNlIHR3
byBpbnRlcmZhY2VzIHdpbGwgbm90IGVuY291bnRlciBsaW5rIGVycm9ycy4KCiAgICBJIGRvbid0
IGtub3cgd2h5IG90aGVycyBoYXZlbid0IG5vdGljZWQsIGJ1dCBJIGRpc2NvdmVyZWQgaXQgd2hl
biBkZWJ1Z2dpbmcgcGNpZSBwYXJhbGxlbCBwb3J0IGRyaXZlcnMuICBBbmQgdGhlIGFybS9LY29u
ZmlnICBoYXMgYmVlbiBhcm91bmQgZm9yIGEgbG9uZyB0aW1lLgoKCkJlc3QgcmVnYXJkcyEKCkF0
IDIwMjQtMTAtMjggMjI6MDU6NDUsICJXaWxsIERlYWNvbiIgPHdpbGxAa2VybmVsLm9yZz4gd3Jv
dGU6Cj5PbiBGcmksIE9jdCAyNSwgMjAyNCBhdCAwOToxNjo0MUFNICswODAwLCBodWFuZ2xlaTgx
NCB3cm90ZToKPj4gRnJvbTogaHVhbmdsZWkgPGh1YW5nbGVpQGt5bGlub3MuY24+Cj4+IAo+PiBF
bmFibGUgR0VORVJJQ19JU0FfRE1BIGZlYXR1cmUgb24gYXJtNjQgcGxhdGZvcm0sCj4+IHRodXMs
IHJlcXVlc3RfZG1hIGFuZCBmcmVlX2RtYSBpbnRlcmZhY2UgY2FuIGJlIGV4cG9ydC4KPj4gYW5k
IGRyaXZlciBtb2R1bGVzIGNhbiB1c2UgdGhlIHRoaXMgaW50ZXJmYWNlcyBvbiBhcm02NAo+PiBw
bGF0Zm9ybS4KPj4gCj4+IEN1cnJlbnRseSwgbWFueSBwY2llIHBhcmFsbGVsIHBvcnQgZHJpdmVy
cyBzdGlsbCB1c2UgdGhlc2UKPj4gaW50ZXJmYWNlcyB3aGVuIHBvcnRlZCB0byBhcm02NCBwbGF0
Zm9ybS4KPgo+V2h5IGhhcyBpdCB0YWtlbiBzbyBsb25nIGZvciBhbnlib2R5IHRvIG5vdGljZT8K
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBodWFuZ2xlaSA8aHVhbmdsZWlAa3lsaW5vcy5jbj4KPj4gLS0t
Cj4+ICBhcmNoL2FybTY0L0tjb25maWcgfCAzICsrKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKQo+PiAKPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvS2NvbmZpZyBiL2FyY2gv
YXJtNjQvS2NvbmZpZwo+PiBpbmRleCBmZDlkZjZkY2M1OTMuLjk4NmViMjUxZjY4ZiAxMDA2NDQK
Pj4gLS0tIGEvYXJjaC9hcm02NC9LY29uZmlnCj4+ICsrKyBiL2FyY2gvYXJtNjQvS2NvbmZpZwo+
PiBAQCAtMzY3LDYgKzM2Nyw5IEBAIGNvbmZpZyBHRU5FUklDX0NTVU0KPj4gIGNvbmZpZyBHRU5F
UklDX0NBTElCUkFURV9ERUxBWQo+PiAgCWRlZl9ib29sIHkKPj4gIAo+PiArY29uZmlnIEdFTkVS
SUNfSVNBX0RNQQo+PiArCWRlZl9ib29sIHkKPj4gKwo+Cj5Eb2VzIHRoaXMgYWN0dWFsbHkgZG8g
YW55dGhpbmcgd2l0aG91dCBNQVhfRE1BX0NIQU5ORUxTIGRlZmluZWQ/Cj4KPldpbGwK

