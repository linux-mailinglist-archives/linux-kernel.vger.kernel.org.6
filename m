Return-Path: <linux-kernel+bounces-413315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F789D1737
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AEB4B2470F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E801C1F24;
	Mon, 18 Nov 2024 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jK941Ie9"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5D1BD9FB;
	Mon, 18 Nov 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731951081; cv=none; b=PG0ORnqxu4Gq1q1N7UPsST4sjKlXZ9xRAsXSle2ECvWCUHCvoYpuh5KiZcCl/3XHcl9j6d8xdOT0nolg1ebkAy9vhd4iomprUDcmn29OnOz0ApTGghgipOjR+HQPWtWlaaoLB80Lmgqfw3vnEWNxI5HOcQ42mfCF99xAWtGExSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731951081; c=relaxed/simple;
	bh=85G7UTP1K7kTdCA3yQ/1SDqQWbdyEWfjArDXx9ZLIV8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ZyDCs9VkSyROJ7D4+5vOLimMcDHUTKwvXYk9BN2wuNwfCWcLmqwJDNyxKnx9yDSOJ91CfIwRzJKH6HR1D7nJMn3yP5rmpyV035NboGwLU/zwcdSSKqbv9JJNKoG8LgQaTEyUCHgz/FqjGgwlC7rLl+Uc2cstjdJq/osBwS8hRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jK941Ie9; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731951054; x=1732555854; i=markus.elfring@web.de;
	bh=85G7UTP1K7kTdCA3yQ/1SDqQWbdyEWfjArDXx9ZLIV8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jK941Ie9o6x/SsaTl/5prNUj9JwcJLVEDXq5713J9G5ltJ5vM+PAUXoKqG4ocHqE
	 4gJ7RVvsQUlSIzwuNnD0DPMKQiqUvxmvxH4Jrv7Tz19dHI5pv28j5aKgbXLwfHl6z
	 NqILQXIEQ5Vd86dF3WJ6AyzblON1Wb0xxln8l2bBAh5n/f9YcfXzh+LIKaG+hjlNI
	 y5iHbzqJFOhrHVKingNNhybIYYhoPzBwmExyDCV657WJvPRMkgRSQEzH1FM4Rx0QD
	 R+fnB9xsmpTZ3gKV9ltSMSMcLr6pgPwEBKT9N8ktsYgWL1rcIhHw6rnHM1vA6bB9z
	 1b2wdNziSkKFftNC+g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1tds1x1aXX-00pkdw; Mon, 18
 Nov 2024 18:30:54 +0100
Message-ID: <a9f86b63-6645-49e8-88d5-a5dbab2aaccd@web.de>
Date: Mon, 18 Nov 2024 18:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: guanjing@cmss.chinamobile.com, Barret Rhoden <brho@google.com>,
 David Vernet <void@manifault.com>, Hao Luo <haoluo@google.com>,
 Josh Don <joshdon@google.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20241116230258.140098-1-guanjing@cmss.chinamobile.com>
Subject: Re: [PATCH] sched_ext: fix application of sizeof to pointer
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241116230258.140098-1-guanjing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SOfWYe3CAgBGvO68l+vi7ssFmFkfpSaq8XAdHA8ij8GYalRdzOL
 /N0S/AwfIFJ1Nz72W9p5QI4zDurA+9L4eteICqkQCaFvh6rmL/BNH0WjSm1R5lra44tbS80
 QnESlVP3kWoHT66Y3RBinX/KrPwwlx/ro72Uobt7a4//rvPYrI7Wtc7t8ARELVydRwXHoio
 zhtXAd9JLj3AxACpnHFkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p0neG0qW/e4=;refRek5BDM8epMyGJ82SMKH+npA
 SuBnTkzVod+jINn4rAjEkvzsi7KMcGndy1CDpU/66ZHUmrTNaej0NNURlq1xMKxc6+oPD4YMX
 k5Cwd1SsYhDaNW6AsL0si+R7TBrdCs/PauXya7Z6hVJHU4Fzdjbsi960VoNC0ZrAQlnjxrPjR
 m8AcBhmflLOwIycEZETbsaauXxof04/W2uOGUq2dgdttDyLVcHmwIMWnZ0cYMI8JCka95ktL1
 JWKI+L1DKNlmLcLgwDFxQGe1I/udkNZWKm4IkMvGXKKgSSsfszEqvIa07MBUV/Gts56NF5vC3
 mbBu3PwieoIn5McORUltRdFHfFT2rWzcsapGU+IQiAqbntT/0W8/AKzyn4uAG1Xd870IIpLm9
 wkD3sh0pQQEBog0F2qZTCuGvoUsvL5/2x2K7CzJubJhJI9mt0gHAbv9AvgD82JcM6rlQ19Iux
 PInB6x/Me2pXE4Nh+oaytJmpC1Al7ue+/mzxwdmQwjbylVigghkh/d6kkYCX6OGNacfVGM0Zz
 fD56UoKKn4QWG7FSxH8Ginj5+Yh/w9toxRN1f9pEeeHHfjRH9VjYnap2vULHq3mDM81TlhbZG
 fkwvKCv3C56+s8ix25MvMaicy1f4cknrhb9062mLgtrc5sEvkaBAgpb6ebo4V+4DCYx9tVs/b
 UQI/BB6SZcD0kpHzJ3qUYNmjoOT3xopeUC7+LhFo7HaKicAo0/2RYnWcCXpmXTNyFDXk4I6pB
 WGr5CwtkgzXXhm7X5ptZcZeGwcwJa/nbmT1cNpkygsg/RCB4WDxQIVAuGLmHdALQ1uVsiHAE3
 7vS47532ruRLFOTfk3wyrzkOBbNNZD2jFtVuf6uoxf1mo+Yp7wdU8rWQu+0tlzwZtpAYvsOtq
 5IgOylDbnaR7kUgTU6pvykQpaholTNgKpLos9UdBi7M1otZixTi0dmV3Q

> sizeof when applied to a pointer typed expression gives the size of
> the pointer.
>
> The proper fix in this particular case is to code sizeof(cpu_set_t)
> instead of sizeof(cpuset).
=E2=80=A6

I suggest to reconsider this view once more.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.12#n941

Would the specification =E2=80=9Csizeof(*cpuset)=E2=80=9D be more appropri=
ate here?

Regards,
Markus

