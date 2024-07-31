Return-Path: <linux-kernel+bounces-269640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB07F943534
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F74F1F236A9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5AF3C482;
	Wed, 31 Jul 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="scmbO/qr"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CBF1799F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448593; cv=none; b=N06CRzqa3O/UU0PRv+3KyBjNHKuxBZLKg2sN/MQskbuHHG6n7Z23OezvHuEFj4xXi5s6hOuDIbaM75tWiQFV8qKQYPVHsbUsP4lls/d7zmuY+OPYOjlHTJ1yRWCN+qiNi7em9kQXcuds0BpXSbtOr1h1A66OjkC5J6nWxGKBFLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448593; c=relaxed/simple;
	bh=Bu6NPwNRttpdyJB79QqVFX0snxQqftr9rOsfsZADxQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3HOcXDGHHiqOgr1ot2A5c47DawrH4ga1x7gVZA8/qtiDvexTqd6yy/nVJj84R4lQMC7g9TkaL6OvXiSaC1Z6KNRbOel9zB7ii43k55sd7AoX46re0rdCkVJXPEALr20Sv9K40OzhrMVyBnP0WgdTWrrfU7a7M8S5G35Z48e/Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=scmbO/qr; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id EA09942597;
	Wed, 31 Jul 2024 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1722448580; bh=Bu6NPwNRttpdyJB79QqVFX0snxQqftr9rOsfsZADxQo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=scmbO/qrDkSvoYCDTlWWczjHBBjV5FAqLnJvQd9945johNBtkrc5YBPYsUpqeHOWX
	 Pz4eECJ2q3xNMTeohmJb+33KIcT/WNupknu+7sypf0Gn3D5MWwhqsHwE8AHMxzkZ3C
	 a5pCzV22tKBQvobvSX3LQdJg9BAvXgcahJy/P6/vNmJwnaGk3H7dafp15ip8VnGBxc
	 7sYmIztmVrKDNmnXXqd4zWMmYfOf5ReqHoOnFttTWZ7ocXrtHgElXeaeY45iNjBB86
	 Q35q13nzmJtqlhtF+XWw/3stH1F69o9k2/0Iy7m+1TatodIGl8AqhCQiUab/jlhLre
	 o3JP1R6IUs7tA==
Message-ID: <c844c984-68fe-4571-bc4c-6058c0f15f26@marcan.st>
Date: Thu, 1 Aug 2024 02:56:18 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers/perf: apple_m1: add known PMU events
To: Yangyu Chen <cyy@cyyself.name>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>,
 asahi@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <tencent_D6474BDCDD18AA90A0C656BE704136ED2807@qq.com>
 <86bk3yjqkn.wl-maz@kernel.org>
 <tencent_B732B857317E21CB8D887CBF8228DAA78E08@qq.com>
 <86a5jijign.wl-maz@kernel.org>
 <3cd6bf37-f335-470b-9b3f-25628067e0f1@marcan.st>
 <tencent_4EB8343AF079090E68933A46E362C740850A@qq.com>
Content-Language: en-US
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <tencent_4EB8343AF079090E68933A46E362C740850A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/07/28 21:19, Yangyu Chen wrote:
> 
> 
>> On Jul 28, 2024, at 19:00, Hector Martin <marcan@marcan.st> wrote:
>>
>>
>> On 2024/06/19 1:58, Marc Zyngier wrote:
>>> On Tue, 18 Jun 2024 16:56:48 +0100,
>>> Yangyu Chen <cyy@cyyself.name> wrote:
>>>>
>>>>
>>>>
>>>>> On Jun 18, 2024, at 22:03, Marc Zyngier <maz@kernel.org> wrote:
>>>>>
>>>>> On Tue, 18 Jun 2024 14:49:48 +0100,
>>>>> Yangyu Chen <cyy@cyyself.name> wrote:
>>>>>>
>>>>>> This patch adds known PMU events that can be found on /usr/share/kpep in
>>>>>> macOS. The m1_pmu_events and m1_pmu_event_affinity are generated from
>>>>>> the script [1], which consumes the plist file from Apple. And then added
>>>>>> these events to m1_pmu_perf_map and m1_pmu_event_attrs with Apple's
>>>>>> documentation [2].
>>>>>>
>>>>>> Link: https://github.com/cyyself/m1-pmu-gen [1]
>>>>>> Link: https://developer.apple.com/download/apple-silicon-cpu-optimization-guide/ [2]
>>>>>
>>>>> This needs registration, and is thus impossible to freely visit.
>>>>>
>>>>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>>>>
>>>>> What is the licence applicable to the original source file? Does it
>>>>> explicitly allow redistribution in any form?
>>>>>
>>>>
>>>> Oh. It's my fault. Sorry for the trouble caused.
>>>
>>> No trouble on my side. I'm just painfully aware that this is a legal
>>> landmine, and that what is perfectly allowed in one country may be a
>>> punishable offence in another. And since I'm not a lawyer, I want to
>>> see crystal clear things in writing.
>>>
>>>>
>>>>>
>>>>> Other than the licensing concern, why should we bloat the kernel with
>>>>> more of this stuff when everything is moving towards a bunch of JSON
>>>>> files (tools/perf/pmu-events/arch/arm64).
>>>>>
>>>>
>>>> Thanks for this hint. So, the thing to do might be to provide a
>>>> generator that consumes Apple files and then generates a kernel
>>>> patch for Linux perf tools to use rather than provide such details
>>>> directly in the source code as you said from [1].
>>>>
>>>> Link: https://lore.kernel.org/lkml/87czn18zev.wl-maz@kernel.org/ [1]
>>>
>>> Even better: teach the perf tool to directly consume the plist file,
>>> but don't distribute the file or its content. People owning such a
>>> machine can fish the file from the machine itself (or the installer
>>> can extract it from the OS image as if it was firmware data).
>>
>> Maz,
>>
>> That would be a waste of time. Facts about hardware are not
>> copyrightable. I see absolutely nothing objectionable in this patch. It
>> doesn't matter where the information was sourced as long as it was
>> legitimately available to the person (which it was, as long as they were
>> running macOS on one of these machines).
>>
>> Let's look at the license for the ARMv8-A ARM:
>>
>>> Proprietary Notice
>>> This document is protected by copyright and other related rights and the practice or implementation of the information contained
>>> in this document may be protected by one or more patents or pending patent applications. No part of this document may be
>>> reproduced in any form by any means without the express prior written permission of Arm. No license, express or implied, by
>>> estoppel or otherwise to any intellectual property rights is granted by this document unless specifically stated.
>>
>> There is absolutely nothing in there granting a license to use the
>> information in the document and things like register names in Linux or
>> any other OS. And yet we can do that, because those things aren't
>> copyrightable. It would defeat the entire point of the documentation if
>> you could not use it, even though there is in fact no explicit copyright
>> grant to allow you to use it. It is not needed.
>>
>> The same exact logic applies here. The macOS license does not grant us
>> the right to reproduce portions of macOS, but that is completely
>> irrelevant because the portion "reproduced" in the form of this patch is
>> not, at all, copyrightable. If it were we would have much bigger issues
>> and all kinds of code in Linux would be a copyvio. The fact that there
>> was some automation involved in generating the patch contents is
>> entirely irrelevant, as long as the output does not keep a copyright
>> interest from the author of the input.
>>
>> I also have an actual lawyer's opinion that register names are not
>> copyrightable, which further corroborates this interpretation.
>>
>> As far as I'm concerned this can be merged as is.
> 
> Even if there are no copyright concerns, as you said from [1], I
> think I should remove the lines in m1_pmu_event_attrs and then patch
> userspace Linux-perf tools with the definitions in the JSON file.

Sure, that's fine. I would say go ahead and move the definitions to
JSON, then just submit that.

> Since I haven't received any other advice on copyright concerns, I
> am still waiting for other suggestions before submitting the patch
> revision.
> 
> Thanks,
> Yangyu Chen
> 
> [1] https://lore.kernel.org/lkml/dbf17fa6-1af6-467b-8b3d-dca8476dc785@marcan.st/



- Hector

