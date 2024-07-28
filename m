Return-Path: <linux-kernel+bounces-264539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1889E93E4B0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 889291F21708
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC891374FF;
	Sun, 28 Jul 2024 11:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="cfI+ZzDr"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D6C1A269
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 11:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722164470; cv=none; b=mAzJRPvvmOGWvLyQQjR2YME6+sFK0v2Bwx+mDriC4ARLanj+VCjavLoF5aHhHTsu4vXHHulNXAC0WlX7oQugIoUyqKRhFf5LZnFQbSv8BxYfi0Mpg3OyEn/phLMcuEfjLDrHLn/P/7kbkLDQSwdbG956qH0uvaV/CWp7lRdGSvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722164470; c=relaxed/simple;
	bh=dirLK5k1HkpMZ5zGrZ7l0jdQX2uduij58/0xP7Up9jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ru3lR8qu7F5pntEyEPhSUo5kNm29R8HkDoo+S/eWu9ew/ckD27h8KKXdLpgdtN8D3N62JtX7ghDXDrO+9W2CLNdQSKPmtnBNSxG8SfbAbM15X4Mvn0qjy9KZqG3T0bQDEXsex9RDGIJLKTzZHrSVWTvai/QSdzJfr9dxoPEQ+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=cfI+ZzDr; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id DBC604346D;
	Sun, 28 Jul 2024 11:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1722164458; bh=dirLK5k1HkpMZ5zGrZ7l0jdQX2uduij58/0xP7Up9jo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cfI+ZzDrLd9LDK5lRERLgVrJe3PzqqymMWyMIzlJxA9+cPJU1tsRs9G9Cw+8Helnc
	 UdaAr5qQ2Gfl9AKvis7ZNVk/xSnFiKHPLHNtUfUBiyNJfA2y9ieF4gtyDhia+EenNL
	 GxrZini9wluGWLOFOz7dJ3aoci1c/9JakMYBgKaOxeryl8iNv3LhC5c5bjIvra30xF
	 EOjPR8/Mxsu/vthT02nUbRrxFOI/EE+7FoHqx55y9SKrdTOSA6sUz9rZ4B+FBAdvtT
	 /x/l80FeFpzuv6GK5dnl+71jSXS/PkAq/alChPaMB4UdLJdV8t/qNAhx8tab2BuES7
	 eeNYelBOsoH0Q==
Message-ID: <3cd6bf37-f335-470b-9b3f-25628067e0f1@marcan.st>
Date: Sun, 28 Jul 2024 20:00:55 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers/perf: apple_m1: add known PMU events
To: Marc Zyngier <maz@kernel.org>, Yangyu Chen <cyy@cyyself.name>
Cc: linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Janne Grunau <j@jannau.net>,
 Asahi Lina <lina@asahilina.net>, asahi@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <tencent_D6474BDCDD18AA90A0C656BE704136ED2807@qq.com>
 <86bk3yjqkn.wl-maz@kernel.org>
 <tencent_B732B857317E21CB8D887CBF8228DAA78E08@qq.com>
 <86a5jijign.wl-maz@kernel.org>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <86a5jijign.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/06/19 1:58, Marc Zyngier wrote:
> On Tue, 18 Jun 2024 16:56:48 +0100,
> Yangyu Chen <cyy@cyyself.name> wrote:
>>
>>
>>
>>> On Jun 18, 2024, at 22:03, Marc Zyngier <maz@kernel.org> wrote:
>>>
>>> On Tue, 18 Jun 2024 14:49:48 +0100,
>>> Yangyu Chen <cyy@cyyself.name> wrote:
>>>>
>>>> This patch adds known PMU events that can be found on /usr/share/kpep in
>>>> macOS. The m1_pmu_events and m1_pmu_event_affinity are generated from
>>>> the script [1], which consumes the plist file from Apple. And then added
>>>> these events to m1_pmu_perf_map and m1_pmu_event_attrs with Apple's
>>>> documentation [2].
>>>>
>>>> Link: https://github.com/cyyself/m1-pmu-gen [1]
>>>> Link: https://developer.apple.com/download/apple-silicon-cpu-optimization-guide/ [2]
>>>
>>> This needs registration, and is thus impossible to freely visit.
>>>
>>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>>
>>> What is the licence applicable to the original source file? Does it
>>> explicitly allow redistribution in any form?
>>>
>>
>> Oh. It's my fault. Sorry for the trouble caused.
> 
> No trouble on my side. I'm just painfully aware that this is a legal
> landmine, and that what is perfectly allowed in one country may be a
> punishable offence in another. And since I'm not a lawyer, I want to
> see crystal clear things in writing.
> 
>>
>>>
>>> Other than the licensing concern, why should we bloat the kernel with
>>> more of this stuff when everything is moving towards a bunch of JSON
>>> files (tools/perf/pmu-events/arch/arm64).
>>>
>>
>> Thanks for this hint. So, the thing to do might be to provide a
>> generator that consumes Apple files and then generates a kernel
>> patch for Linux perf tools to use rather than provide such details
>> directly in the source code as you said from [1].
>>
>> Link: https://lore.kernel.org/lkml/87czn18zev.wl-maz@kernel.org/ [1]
> 
> Even better: teach the perf tool to directly consume the plist file,
> but don't distribute the file or its content. People owning such a
> machine can fish the file from the machine itself (or the installer
> can extract it from the OS image as if it was firmware data).

Maz,

That would be a waste of time. Facts about hardware are not
copyrightable. I see absolutely nothing objectionable in this patch. It
doesn't matter where the information was sourced as long as it was
legitimately available to the person (which it was, as long as they were
running macOS on one of these machines).

Let's look at the license for the ARMv8-A ARM:

> Proprietary Notice
> This document is protected by copyright and other related rights and the practice or implementation of the information contained
> in this document may be protected by one or more patents or pending patent applications. No part of this document may be
> reproduced in any form by any means without the express prior written permission of Arm. No license, express or implied, by
> estoppel or otherwise to any intellectual property rights is granted by this document unless specifically stated.

There is absolutely nothing in there granting a license to use the
information in the document and things like register names in Linux or
any other OS. And yet we can do that, because those things aren't
copyrightable. It would defeat the entire point of the documentation if
you could not use it, even though there is in fact no explicit copyright
grant to allow you to use it. It is not needed.

The same exact logic applies here. The macOS license does not grant us
the right to reproduce portions of macOS, but that is completely
irrelevant because the portion "reproduced" in the form of this patch is
not, at all, copyrightable. If it were we would have much bigger issues
and all kinds of code in Linux would be a copyvio. The fact that there
was some automation involved in generating the patch contents is
entirely irrelevant, as long as the output does not keep a copyright
interest from the author of the input.

I also have an actual lawyer's opinion that register names are not
copyrightable, which further corroborates this interpretation.

As far as I'm concerned this can be merged as is.

Acked-by: Hector Martin <marcan@marcan.st>

- Hector

