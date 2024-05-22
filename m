Return-Path: <linux-kernel+bounces-185568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3088CB6D6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 02:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628551F262E5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83253291E;
	Wed, 22 May 2024 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b="DX62oxei"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B05515C0;
	Wed, 22 May 2024 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716338926; cv=pass; b=jgzncA0S05WP714EIOm5wSDN+LWpP4r0WhTMgeokpe56pADk5y2AA7JUCTcBWlAXiqyYj2edbmtuCKKUxXlRA4DvXBIWI1x4Ye04gHd53vRqhlOcDRsRNKVtEoLpqelnRF52e8b0a2iCokJ+4GzXs11P3qktYdtSzQL1EnKwDfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716338926; c=relaxed/simple;
	bh=7dVJE5o5Y50vlv+ZlyLWEjCQ1Rjrwu1Ejbl9Boq49kw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=brE2P6Ms/0Md2Jf+G8mNAK1rf992fE6BsM/esuMi2lxCi1ZAKF3eTnUfaqtsYvtFniVjchYLfhLC0QP6UzssgpaHwTJsUcbm9abcIoNtBStjy20RSLzB+T963QClRke690tG2P/INN5sui1ZcZkMAxfI5zo+4GY0U9FrbzdmTkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me; spf=pass smtp.mailfrom=icenowy.me; dkim=pass (2048-bit key) header.d=icenowy.me header.i=uwu@icenowy.me header.b=DX62oxei; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=icenowy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icenowy.me
Delivered-To: gamiee@pine64.org
ARC-Seal: i=1; a=rsa-sha256; t=1716338895; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bjyhdEApydfOQZNKvtqtyxJzL+QP7Rbq3gVLTnkjZsM+I0BJp4WZrjZaagpQUjPAlbw15zIbDxInNylo4O1nvg+t7HdFvYgXVq90ZU1R/clT3YlfTBGrT/cq5egpwWLEGxybx0tdBY4mSHFyhIQWvAsB8WrE4q7hDZr+M0ZZtZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1716338895; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7dVJE5o5Y50vlv+ZlyLWEjCQ1Rjrwu1Ejbl9Boq49kw=; 
	b=gFmEqBcNnxnkNzEL5yP0XgFQSdoWHl5hujNTQ4HKecgU5qpPQKhRNhNVMbSXA0oz+1/K+xImy4pifMhkjTDDMAR7Hd6hjBQsOQoDsDACFLqbUxJrhs4v80C3XTgmx5vRq34tRvVunQmv4q7XECzRa3JjR64uqz48bw9yX0IhUOU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=icenowy.me;
	spf=pass  smtp.mailfrom=uwu@icenowy.me;
	dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1716338895;
	s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=7dVJE5o5Y50vlv+ZlyLWEjCQ1Rjrwu1Ejbl9Boq49kw=;
	b=DX62oxeiLF9kjeNh/2hiVWLvOVvXjq0I78eDC+v9gEeQ6R463XInmJ2wjYL4UxM0
	23Ojqlz4DPB6w8FSUNf/gaRpiJG+0+YcYNfBwzZtqEzGcniAcHygEeJHzuGH9RiIbdc
	f1s8I7p4uB4T4H3IKO3bKReSh1XCEVl0V98YKfPCCtBFViuM+N+Tk0JBTu0QPlvVkMZ
	4QQSHlom50+TDhmIAG+nKXy7URXoXr9d8dvcTeKJqbFjLI+INkTWQRBH+5DM2pjP6j1
	s4eZDCT5atO4twcNJcNOqvdn9B/bYi4bN3qBawaVp+vvlBVtNd/F+nd/Npd/02lQQnC
	tfJF5x4+7Q==
Received: by mx.zohomail.com with SMTPS id 1716338894658976.2921534766582;
	Tue, 21 May 2024 17:48:14 -0700 (PDT)
Message-ID: <057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Correct the descriptions
 for Pine64 boards
From: Icenowy Zheng <uwu@icenowy.me>
To: Dragan Simic <dsimic@manjaro.org>, linux-sunxi@lists.linux.dev
Cc: wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, didi.debian@cknow.org, Marek Kraus
	 <gamiee@pine64.org>
Date: Wed, 22 May 2024 08:48:09 +0800
In-Reply-To: <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
References: 
	<d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
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
X-ZohoMail-Owner: <057b4a5504656bb7455ead39768d9e7167fb724b.camel@icenowy.me>+zmo_0_uwu@icenowy.me

5ZyoIDIwMjQtMDQtMjPmmJ/mnJ/kuoznmoQgMDM6MDAgKzAyMDDvvIxEcmFnYW4gU2ltaWPlhpnp
gZPvvJoKPiBDb3JyZWN0IHRoZSBkZXNjcmlwdGlvbnMgb2YgYSBmZXcgUGluZTY0IGJvYXJkcyBh
bmQgZGV2aWNlcywKPiBhY2NvcmRpbmcKPiB0byB0aGVpciBvZmZpY2lhbCBuYW1lcyB1c2VkIG9u
IHRoZSBQaW5lNjQgd2lraS7CoCBUaGlzIGVuc3VyZXMKPiBjb25zaXN0ZW5jeQo+IGJldHdlZW4g
dGhlIG9mZmljaWFsbHkgdXNlZCBuYW1lcyBhbmQgdGhlIG5hbWVzIGluIHRoZSBzb3VyY2UgY29k
ZS4KPiAKPiBDYzogTWFyZWsgS3JhdXMgPGdhbWllZUBwaW5lNjQub3JnPgo+IFNpZ25lZC1vZmYt
Ynk6IERyYWdhbiBTaW1pYyA8ZHNpbWljQG1hbmphcm8ub3JnPgo+IC0tLQo+IAo+IE5vdGVzOgo+
IMKgwqDCoCBUaGlzIGNvbXBsZXRlcyB0aGUgY29ycmVjdGlvbiBvZiB0aGUgZGVzY3JpcHRpb25z
IG9mIHRoZSBQaW5lNjQKPiBib2FyZHMKPiDCoMKgwqAgYW5kIGRldmljZXMsIHdoaWNoIHdhcyBz
dGFydGVkIHdpdGggdGhlIFBpbmU2NCBib2FyZHMgYW5kIGRldmljZXMKPiBiYXNlZAo+IMKgwqDC
oCBvbiBSb2NrY2hpcCBTb0NzLiBbMV0KPiDCoMKgwqAgCj4gwqDCoMKgIFsxXQo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LXJvY2tjaGlwL2VjMTI0ZGFiMmIxYTg3NzZhYTM5MTc3ZWNj
ZTM0YmFiY2EzYTUwZTIuMTcxMzgzMjc5MC5naXQuZHNpbWljQG1hbmphcm8ub3JnLwo+IAo+IMKg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9zdW54aS55YW1sIHwgMTIgKysr
KysrLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9u
cygtKQo+IAo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL3N1bnhpLnlhbWwKPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
c3VueGkueWFtbAo+IGluZGV4IDA5ZDgzNWRiNmRiNS4uYjY2ODczYWUyZDcxIDEwMDY0NAo+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vc3VueGkueWFtbAo+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vc3VueGkueWFtbAo+IEBA
IC03MDksMTcgKzcwOSwxNyBAQCBwcm9wZXJ0aWVzOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0g
Y29uc3Q6IHNvY2hpcCxzMwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IGFsbHdpbm5l
cixzdW44aS12Mwo+IMKgCj4gLcKgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogUGluZTY0IFBpbmVI
NjQgbW9kZWwgQQo+ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IFBpbmU2NCBINjQgTW9kZWwg
QQo+IMKgwqDCoMKgwqDCoMKgwqAgaXRlbXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25z
dDogcGluZTY0LHBpbmUtaDY0Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogYWxsd2lu
bmVyLHN1bjUwaS1oNgo+IMKgCj4gLcKgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogUGluZTY0IFBp
bmVINjQgbW9kZWwgQgo+ICvCoMKgwqDCoMKgIC0gZGVzY3JpcHRpb246IFBpbmU2NCBINjQgTW9k
ZWwgQgoKU29ycnkgZm9yIHJlcGx5aW5nIHNvIGxhdGUsIGJ1dCBJIGRvbid0IHRoaW5rIHRoZXJl
IGlzIGEgUGluZTY0IEg2NApib2FyZC4gVGhlIFBpbmU2NCB3aWtpIGNhbGxzIGl0IFBpbmUgSDY0
LiBbMV0KClsxXSBodHRwczovL3dpa2kucGluZTY0Lm9yZy93aWtpL1BJTkVfSDY0Cgo+IMKgwqDC
oMKgwqDCoMKgwqAgaXRlbXM6Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogcGluZTY0
LHBpbmUtaDY0LW1vZGVsLWIKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBhbGx3aW5u
ZXIsc3VuNTBpLWg2Cj4gwqAKPiAtwqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBQaW5lNjQgTFRT
Cj4gK8KgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogUGluZTY0IEE2NCBMVFMKPiDCoMKgwqDCoMKg
wqDCoMKgIGl0ZW1zOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IHBpbmU2NCxwaW5l
NjQtbHRzCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBjb25zdDogYWxsd2lubmVyLHN1bjUwaS1y
MTgKPiBAQCAtNzQ4LDE3ICs3NDgsMTcgQEAgcHJvcGVydGllczoKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAtIGNvbnN0OiBwaW5lNjQscGluZXBob25lCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLSBj
b25zdDogYWxsd2lubmVyLHN1bjUwaS1hNjQKPiDCoAo+IC3CoMKgwqDCoMKgIC0gZGVzY3JpcHRp
b246IFBpbmU2NCBQaW5lVGFiLCBEZXZlbG9wbWVudCBTYW1wbGUKPiArwqDCoMKgwqDCoCAtIGRl
c2NyaXB0aW9uOiBQaW5lNjQgUGluZVRhYiBEZXZlbG9wZXIgU2FtcGxlCj4gwqDCoMKgwqDCoMKg
wqDCoCBpdGVtczoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBwaW5lNjQscGluZXRh
Ygo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IGFsbHdpbm5lcixzdW41MGktYTY0Cj4g
wqAKPiAtwqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBQaW5lNjQgUGluZVRhYiwgRWFybHkgQWRv
cHRlcidzIGJhdGNoIChhbmQKPiBtYXliZSBsYXRlciBvbmVzKQo+ICvCoMKgwqDCoMKgIC0gZGVz
Y3JpcHRpb246IFBpbmU2NCBQaW5lVGFiIEVhcmx5IEFkb3B0ZXIKPiDCoMKgwqDCoMKgwqDCoMKg
IGl0ZW1zOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IHBpbmU2NCxwaW5ldGFiLWVh
cmx5LWFkb3B0ZXIKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBhbGx3aW5uZXIsc3Vu
NTBpLWE2NAo+IMKgCj4gLcKgwqDCoMKgwqAgLSBkZXNjcmlwdGlvbjogUGluZTY0IFNvUGluZSBC
YXNlYm9hcmQKPiArwqDCoMKgwqDCoCAtIGRlc2NyaXB0aW9uOiBQaW5lNjQgU09QaW5lCj4gwqDC
oMKgwqDCoMKgwqDCoCBpdGVtczoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAtIGNvbnN0OiBwaW5l
NjQsc29waW5lLWJhc2Vib2FyZAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC0gY29uc3Q6IHBpbmU2
NCxzb3BpbmUKPiAKCg==


