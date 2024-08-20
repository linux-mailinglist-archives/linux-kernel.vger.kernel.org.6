Return-Path: <linux-kernel+bounces-293320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D639D957E0A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 071F61C22ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003116BE33;
	Tue, 20 Aug 2024 06:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=zytor.com header.i=@zytor.com header.b="D/6Y8OiT"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EEA2A1B2;
	Tue, 20 Aug 2024 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135183; cv=none; b=Def0CwwfjonbI0fYWnTR+vTSJ162hFcqpRNR6QIuuRGoSQ3rRX7y3+tWIyHyYbD5kELuNDsDaHT/Ukz75RA9ue+s5eB+MsLaEDAk58ZpWMUpklNz75ReKFOr9zsFPLI4HEYI4P/aP8gGxn+H/iFC5GU1JlGbmBClD8jxK6HB6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135183; c=relaxed/simple;
	bh=EZqc+00fgRRrEC4Xf7joFqSZzq2p9IEziTklnKWVHQU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ezzobHz57/lRMfjCLaQNSoL8nNlOZ03/XJw/fmh5CuK83nrpknlqwgg6TPlqAkyVu3ARgoBFiMO7ytfvupIPc4FUAmzQN7TqluhrCTf88uxRNxzN+aGGeI6cj+khq/OmM63bkUThhNf7xuVdMaP8/dJJBpUBAVHEnjv+quTwefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=D/6Y8OiT; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 47K6PI6O1345101
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 19 Aug 2024 23:25:18 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 47K6PI6O1345101
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024081601; t=1724135119;
	bh=0XPUli4E+h8MfiBpjbCNlGzGqEZNzuKAKWqIuKRJBpg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=D/6Y8OiTNzjIp70nymc7pWQduoyXtY2bHPbNJeqx8lvge9gWjETD+Mwu/DuE42R8g
	 d5nFb4civvTUK8rLi/4pj9m8MzKy15KeqtfSDJv1lw3Mw4xBLQQu+fqHl6z1GL6jpt
	 5JmSJTnwfEL/IB1cl9n8h7kILxXE25p4Z4ERPSHBfDGeKHUZ0ZgIRqvDJH4PVWbpPW
	 1c8N8v99xolCQfBmoBmPnEgocHzVV4dKxFm2y6myIpIGsBQP0vgy7TANSSQT1Gcyr9
	 tNuCPnuTjoSHDesMmEGpnFSqGGiWJjiMl16po9QDiU7waq90RUPlfnZmfAAbMEcn7V
	 UC2tEeG/wsleQ==
Message-ID: <23b9e88b-9d3b-4c34-a243-232ca2f53527@zytor.com>
Date: Mon, 19 Aug 2024 23:25:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] x86/cpufeatures: Automatically generate required
 and disabled feature masks
From: Xin Li <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com, nik.borisov@suse.com
References: <20240628174544.3118826-1-xin@zytor.com>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240628174544.3118826-1-xin@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/2024 10:45 AM, Xin Li (Intel) wrote:
> The x86 build process first generates required and disabled feature
> masks based on current build config, and then uses these generated
> masks to compile the source code. When a CPU feature is not enabled
> in a build config, e.g., when CONFIG_X86_FRED=n, its feature disable
> flag, i.e., DISABLE_FRED, needs to be properly defined and added to
> a specific disabled CPU features mask in <asm/disabled-features.h>,
> as the following patch does:
> https://lore.kernel.org/all/20231205105030.8698-8-xin3.li@intel.com/.
> As a result, the FRED feature bit is surely cleared in the generated
> kernel binary when CONFIG_X86_FRED=n.
> 
> Recently there is another case to repeat the same exercise for the
> AMD SEV-SNP CPU feature:
> https://lore.kernel.org/all/20240126041126.1927228-2-michael.roth@amd.com/.
> https://lore.kernel.org/all/20240126041126.1927228-23-michael.roth@amd.com/.
> 
> It was one thing when there were four of CPU feature masks, but with
> over 20 it is going to cause mistakes, e.g.,
> https://lore.kernel.org/lkml/aaed79d5-d683-d1bc-7ba1-b33c8d6db618@suse.com/.
> 
> We want to eliminate the stupidly repeated exercise to manually assign
> features to CPU feature words through introducing an AWK script to
> automatically generate a header with required and disabled CPU feature
> masks based on current build config, and this patch set does that.
> 
> Link to v3:
> https://lore.kernel.org/lkml/20240622171435.3725548-1-xin@zytor.com/
> 
> Changes since v3:
> * Add a few high-level comments to the AWK script (Nikolay Borisov).
> * Use '1U' instead of '1' in feature mask shifting (Andrew Cooper).
> * Checking NCAPINTS isn't necessary anymore.  It was needed when these
>    macros had to be manually updated, but now if cpufeatures.h changes
>    this header will be regenerated (Brian Gerst).
> * Enforce CPU feature mask values to be unsigned.
> 
> Changes since v2:
> * Remove AWK code that generates extra debugging comments (Brian Gerst).
> * Move SSE_MASK to verify_cpu.S, the only place it is used (Brian Gerst).
> * Add a patch to generate macros {REQUIRED|DISABLED}_MASK_BIT_SET in the
>    new AWK script (Brian Gerst).
> 
> Changes since v1:
> * Keep the X86_{REQUIRED,DISABLED}_FEATURE_ prefixes solely in
>    arch/x86/Kconfig.cpufeatures (Borislav Petkov).
> * Explain how config option names X86_{REQUIRED,DISABLED}_FEATURE_<name>
>    are formed (Borislav Petkov).
> * Remove code generating unused macros {REQUIRED,DISABLED}_FEATURE(x)
>    to tell if a CPU feature, e.g., X86_FEATURE_FRED, is a required or
>    disabled feature for this particular compile-time configuration.
> 

A gentle ping...


