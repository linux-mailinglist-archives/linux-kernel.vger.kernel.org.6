Return-Path: <linux-kernel+bounces-403409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF89C354C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E033B1F21B73
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8B7154445;
	Sun, 10 Nov 2024 23:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="kdqScvdb"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5821369AA;
	Sun, 10 Nov 2024 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731282354; cv=none; b=fI222/1y3LzibETNnEjiediHdxeVToXPhSlGIOBO4+jMMUh2Csj2dknVaR6+0GLKR2UyzXJ0bOP6nQIk9tnJ0zUz30dCXFoRwi2QUwaUsunzTRzwdt76fraZbHnYnkTfeSYC0DHlMljjz0vAHLDDiuA+sphebNcGpXQS/eRk61M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731282354; c=relaxed/simple;
	bh=CtE/2TzXKxCOgx8TvJHqD35OsC00+oFw8Pd4MfmWF1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sN6+KtX17n0BVott1VN9+MvRueGAijTF21ZNGTTfPQT/0vhpUFKD2BUiJ7FB2/mKWBhaV5xW7TGrhfdfgqrI1cPfawWo8K76eckD2mQqzRyCSdFof0wVnpH8whP6EY2miqvDJ6FdxjDPYhIrxBkbf4ypDiN9BQ2IVntQhZLjcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=kdqScvdb; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731282344;
	bh=CtE/2TzXKxCOgx8TvJHqD35OsC00+oFw8Pd4MfmWF1k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kdqScvdbKNWzvUQOtZ8y4IJkVrDptpwzjGzuyO7c9xz2ZQyZ28TCXeX2HpyB5RBnL
	 k8Wr8bmUr7L14Ja/d9pqNNdIxeREt3khie9BtL0bWpuLgJFWd6o6+qyp8QfEj9FwLe
	 pjBrFrarmMdB6AtvTqU0pCkTBFMkjCJNQ8/WCPzFhyIfdW+hcYUz8vrhDwD7h/hmkR
	 17NNxq+S/o7+PGdqZr3IqzQdcFJY3D4yIuUwpe3oxsv2qDvjGjlhWwvqcxLwNJ1mwX
	 f52aRicZTaKScCqoFq3RBSHfSJpq8wLTg6aXx+gpXDPVGZNVljIFVPlHyphQdMQgAV
	 UyBWi8r99lOuA==
Received: from [192.168.68.112] (ppp118-210-186-64.adl-adc-lon-bras34.tpg.internode.on.net [118.210.186.64])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DE0216490A;
	Mon, 11 Nov 2024 07:45:42 +0800 (AWST)
Message-ID: <d4196567fc62a24922794b02adad1b6c47750760.camel@codeconstruct.com.au>
Subject: Re: [PATCH] arm: dts: aspeed: Blueridge and Rainer: Add VRM
 presence GPIOs
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, linux-aspeed@lists.ozlabs.org
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 11 Nov 2024 10:15:40 +1030
In-Reply-To: <20241108145822.1365072-1-eajames@linux.ibm.com>
References: <20241108145822.1365072-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gRnJpLCAyMDI0LTExLTA4IGF0IDA4OjU4IC0wNjAwLCBFZGRpZSBKYW1lcyB3cm90ZToKPiBB
ZGQgR1BJTyBsaW5lIG5hbWVzIHRvIHRoZSBHUElPIGV4cGFuZGVyIHRvIGRlc2NyaWJlIERDTSBh
bmQKPiBWUk0gcHJlc2VuY2UgZGV0ZWN0aW9uIGxpbmVzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEVk
ZGllIEphbWVzIDxlYWphbWVzQGxpbnV4LmlibS5jb20+Cj4gLS0tCj4gwqBhcmNoL2FybS9ib290
L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1pYm0tYmx1ZXJpZGdlLmR0cyB8IDQgKystLQo+IMKgYXJj
aC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5pZXIuZHRzwqDCoCB8IDQg
KystLQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWli
bS1ibHVlcmlkZ2UuZHRzCj4gYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQvYXNwZWVkLWJtYy1p
Ym0tYmx1ZXJpZGdlLmR0cwo+IGluZGV4IDVmOWE0NmMyYWJiOC4uZDUwNGFlODRkYjg5IDEwMDY0
NAo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWlibS1ibHVlcmlk
Z2UuZHRzCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLWJs
dWVyaWRnZS5kdHMKPiBAQCAtMTIzMiw4ICsxMjMyLDggQEAgbGVkLWNvbnRyb2xsZXJANjAgewo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgI2dwaW8tY2VsbHMgPSA8Mj47Cj4gwqAK
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW8tbGluZS1uYW1lcyA9Cj4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiIiwgIiIsICIiLCAi
IiwgIiIsICIiLCAiIiwgIiIsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAiIiwgIiIsICIiLCAiIiwgIiIsICIiLCAicG93ZXItY29uZmlnLWZ1bGwtCj4g
bG9hZCIsICIiOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIiIsICIiLCAiIiwgIiIsICIiLCAiIiwgIlAxMF9EQ00wX1BSRVMiLAo+ICJQMTBfRENNMV9Q
UkVTIiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCIi
LCAiIiwgIiIsICIiLCAiUFJFU0VOVF9WUk1fRENNMF9OIiwKPiAiUFJFU0VOVF9WUk1fRENNMV9O
IiwgInBvd2VyLWNvbmZpZy1mdWxsLWxvYWQiLCAiIjsKPiDCoMKgwqDCoMKgwqDCoMKgfTsKClRo
aXMgZW5kcyB1cCBnZW5lcmF0aW5nIGNoZWNrcGF0Y2ggd2FybmluZ3MgYWJvdXQgbG9uZyBsaW5l
cyB3aGVuIEkKYXBwbHkgaXQuCgpJIGRpZCBhIHF1aWNrLCBpbmNvbXBsZXRlIGFuZCByYW5kb20g
c3VydmV5IG9mIHNvbWUgb3RoZXIgZGV2aWNldHJlZXMsCmFuZCBwZXJoYXBzIGV4cGxvZGluZyBv
dXQgbGlrZSBpbiBbMV0gbWlnaHQgaGVscC4KClsxXTogaHR0cHM6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2NvbW1pdC8/aWQ9ZDg1
YjJhZDM1YTJhYgoKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBsZWQtY29udHJvbGxlckA2MSB7Cj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC9hc3BlZWQtYm1jLWlibS1yYWlu
aWVyLmR0cwo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5p
ZXIuZHRzCj4gaW5kZXggYTRhZWMzMDEwNDU2Li5lZWZjNjlkMGQwMzIgMTAwNjQ0Cj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5pZXIuZHRzCj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVkL2FzcGVlZC1ibWMtaWJtLXJhaW5pZXIuZHRzCj4g
QEAgLTEyODAsOCArMTI4MCw4IEBAIHBjYV9wcmVzMzogcGNhOTU1MkA2MCB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjZ3Bpby1jZWxscyA9IDwyPjsKPiDCoAo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3Bpby1saW5lLW5hbWVzID0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCIiLCAiIiwgIiIsICIiLCAiIiwgIiIs
ICIiLCAiIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCIiLCAiIiwgIiIsICIiLCAiIiwgIiIsICJwb3dlci1jb25maWctZnVsbC0KPiBsb2FkIiwgIiI7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAiIiwgIiIs
ICIiLCAiIiwgIiIsICIiLCAiUDEwX0RDTTBfUFJFUyIsCj4gIlAxMF9EQ00xX1BSRVMiLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIiIsICIiLCAiIiwg
IiIsICJQUkVTRU5UX1ZSTV9EQ00wX04iLAo+ICJQUkVTRU5UX1ZSTV9EQ00xX04iLCAicG93ZXIt
Y29uZmlnLWZ1bGwtbG9hZCIsICIiOwoKU2ltaWxhcmx5IGhlcmUuCgpBbmRyZXcK


