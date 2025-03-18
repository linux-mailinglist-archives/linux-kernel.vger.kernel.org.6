Return-Path: <linux-kernel+bounces-566811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A8A67CD6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201B0885743
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034AE212FAA;
	Tue, 18 Mar 2025 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="W6byEx/K"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAD6225D7
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324976; cv=none; b=X/8SA4qj+SME1t39/f/WSPKa58Z2ezsj+y8CrtEFnR3qrWTkU9FJWjCmgV2Dmn/8OxqVKON+eyA6IobVm6vbz5bjJf9WDmmuTonrTqjp9sKwj4khKaDEO4SX7rTOiXpXjUtDzG4WnSOoYZxwzsAu/P9nvAbqI+5erhYLaJQPcEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324976; c=relaxed/simple;
	bh=XIESkg7dC6NrBAFNrNH1tCVvU0Vfo2TzLzKhJ9+meL4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=L5Ys8gVDW0ha5nnzRg0LavKhTkCZWb7Z/lNuZr9Wr+zErLcMMldLTGx6/XStbLFEWtStajaFQV6nsgoj5MojJLiOQW+hL3y3Q8XOTn1+Idhu5WMafQQ1YptOndPE/TEh9iRQRMUzLBaThjludsTF+ZP+XSv3XRIZW8VMxHjIF/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=W6byEx/K; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:d173:1064:5845:5ff4:a413] ([IPv6:2601:646:8002:d173:1064:5845:5ff4:a413])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 52IJ91oW1152383
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 18 Mar 2025 12:09:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 52IJ91oW1152383
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1742324947;
	bh=BgOSOtd+uEUBKY1LSksPhzhlRd8f2KcnPWdvWzj9hIQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=W6byEx/Kr9Np1Vmw/ra+GTdlApa8Gon4KKUsQuzWsq5vm0L66Je9kM5BmyfgzkMo7
	 qYJvKOlgustfnDitxSI2H/zGQImwDDys5ublbio2rv/TTrPbO6OUmTfCIGwlmWGb9c
	 X3nj60VpO1jzqNMl/1ABKV0g5DjChBeMrKy+Af5aT8uVDcPePT5xdpeiS52syxAzOW
	 q1A+XsIsQqPea6d7sjnN46NkKDhLp/OgL53QsHSxfJjpIdzK29rkmT7FQTfEqG2B4v
	 OEE2YNYVMki587vwwUFawTbcQToy+JSvE2fYs01Xv5EKEh0DreBjBwbz6THX8HfAUG
	 sKvX15/3mURYg==
Content-Type: multipart/mixed; boundary="------------c1ax41gZfRrcO2VCTJ2EyCpq"
Message-ID: <a05422be-8043-409e-817d-3dec9571dd15@zytor.com>
Date: Tue, 18 Mar 2025 12:08:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
From: "H. Peter Anvin" <hpa@zytor.com>
To: mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Ahmed S . Darwish" <darwi@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20250317223039.3741082-1-mingo@kernel.org>
 <20250317223039.3741082-5-mingo@kernel.org>
 <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com>
Content-Language: en-US
In-Reply-To: <5D7935C3-8CAE-4821-8E31-A43169B8CB83@zytor.com>

This is a multi-part message in MIME format.
--------------c1ax41gZfRrcO2VCTJ2EyCpq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/25 11:48, H. Peter Anvin wrote:
> 
> One more thing is that we ought to be able to make cpuid a const
> function, allowing the compiler to elide multiple calls. (Slight warning
> for feature-enabling MSRs changing CPUID), but that would require
> changing the API to returning a structure, since a pure or const
> structure can't return values by reference.
> 

So I experimented (test included) and found that gcc 14.2 does not seem 
to merge the cpuid calls in this code, whereas clang 19.1 does.

  	-hpa

--------------c1ax41gZfRrcO2VCTJ2EyCpq
Content-Type: text/x-csrc; charset=UTF-8; name="cpuid.c"
Content-Disposition: attachment; filename="cpuid.c"
Content-Transfer-Encoding: base64

I2luY2x1ZGUgPGludHR5cGVzLmg+CiNpbmNsdWRlIDxzdGRpby5oPgoKdHlwZWRlZiB1aW50
MzJfdCB1MzI7CgpzdHJ1Y3QgY3B1aWQgewoJdTMyIGVieDsKCXUzMiBlZHg7Cgl1MzIgZWN4
OwoJdTMyIGVheDsKfTsKCnN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVfXygoY29uc3QpKSBz
dHJ1Y3QgY3B1aWQKY3B1aWQodTMyIGxlYWYsIHUzMiBzdWJsZWFmKQp7CglzdHJ1Y3QgY3B1
aWQgcnY7Cglhc20oImNwdWlkIgoJICAgIDogIj1hIiAocnYuZWF4KSwgIj1jIiAocnYuZWN4
KSwgIj1kIiAocnYuZWR4KSwgIj1iIiAocnYuZWJ4KQoJICAgIDogImEiIChsZWFmKSwgImMi
IChzdWJsZWFmKSk7CglyZXR1cm4gcnY7Cn0KCnN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVf
XygoY29uc3QpKSB1MzIKY3B1aWRfZWF4KHUzMiBsZWFmLCB1MzIgc3VibGVhZikKewoJc3Ry
dWN0IGNwdWlkIHJ2ID0gY3B1aWQobGVhZiwgc3VibGVhZik7CglyZXR1cm4gcnYuZWF4Owp9
CnN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVfXygoY29uc3QpKSB1MzIKY3B1aWRfZWN4KHUz
MiBsZWFmLCB1MzIgc3VibGVhZikKewoJc3RydWN0IGNwdWlkIHJ2ID0gY3B1aWQobGVhZiwg
c3VibGVhZik7CglyZXR1cm4gcnYuZWN4Owp9CnN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVf
XygoY29uc3QpKSB1MzIKY3B1aWRfZWR4KHUzMiBsZWFmLCB1MzIgc3VibGVhZikKewoJc3Ry
dWN0IGNwdWlkIHJ2ID0gY3B1aWQobGVhZiwgc3VibGVhZik7CglyZXR1cm4gcnYuZWR4Owp9
CnN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVfXygoY29uc3QpKSB1MzIKY3B1aWRfZWJ4KHUz
MiBsZWFmLCB1MzIgc3VibGVhZikKewoJc3RydWN0IGNwdWlkIHJ2ID0gY3B1aWQobGVhZiwg
c3VibGVhZik7CglyZXR1cm4gcnYuZWJ4Owp9Cgp1MzIgZWF4KHUzMiBsZWFmLCB1MzIgc3Vi
bGVhZikKewoJcmV0dXJuIGNwdWlkX2VheChsZWFmLCBzdWJsZWFmKTsKfQoKc3RydWN0IGNw
dWlkIF9jcHVpZCh1MzIgbGVhZiwgdTMyIHN1YmxlYWYpCnsKCXJldHVybiBjcHVpZChsZWFm
LCBzdWJsZWFmKTsKfQoKaW50IHRlc3RfY3B1aWQodm9pZCkKewoJaW50IGZvdW5kID0gMDsK
Cglmb3VuZCArPSAhIShjcHVpZF9lZHgoMSwgMCkgJiAoMSA8PCAyNikpOyAvKiBTU0UyICov
Cglmb3VuZCArPSAhIShjcHVpZF9lY3goMSwgMCkgJiAoMSA8PCAwKSk7ICAvKiBTU0UzICov
Cglmb3VuZCArPSAhIShjcHVpZCgxLCAwKS5lY3ggJiAoMSA8PCA5KSk7ICAvKiBTU1NFMyAq
LwoKCXJldHVybiBmb3VuZDsKfQo=

--------------c1ax41gZfRrcO2VCTJ2EyCpq--

