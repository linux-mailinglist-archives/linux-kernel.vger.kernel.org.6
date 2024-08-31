Return-Path: <linux-kernel+bounces-310039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268D29673DA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBCE1F21DEE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F8917C7C6;
	Sat, 31 Aug 2024 23:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r5z6sIdr"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFB2C9A
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725145363; cv=none; b=GpQTtR+Uf8jSUJeuUCBVfaDHp/RylCq9n4ZQiOwo+TiJ+AbI7ltynDE74ta8KOqOAGaHBeDEealIDVorOxU3SHpsoqFi5R3+8zjppSMVBJrHk6pHFSeUZmwEZgIq1sqVaaJq/TxT6HsZ65HT10LGbmjjX8zLPFxUIMLaqzJj0Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725145363; c=relaxed/simple;
	bh=RrmzNeTlNKy5o5IoRkNymgvlLLr/a1VvwxHRQVM7HNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1ICvJoVyA1lzGsBa/DJga8L3egl4N5HRAGTbj30iv4NlQZNa4ihGfgFS1cIz4+fFCv15msZWRL3Wm0ntndysT8jr7aOZYMQmk53SEaV4HzDyFEbVN3f3QP+qo2LQkEybd2N00lrYmm473I/ni9Ru98xlpLntBhRJ4AUQz3ofbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r5z6sIdr; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8795e8da-981a-4876-99fe-8a4edb2185bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725145358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xmF6CpyWOJR8fNg1TS1jQi/Ic9PEVUp4NkLcl3FR9NI=;
	b=r5z6sIdryoTxvDIe9eBC+Fi9A016Lf0v2j1TEKTDfEAlFWEjXn16EiPaPHEdjTuqhFytRc
	/0WSWnsHxqmag6ClYcrCgG3OxSVyLeeGvtH5qlvIWwMxsmAWgkgjzVdtzjuaYupRvWx/Fm
	r5uqOWhf2dNGrkTWY89Hjun1Mpj9AHQ=
Date: Sat, 31 Aug 2024 16:02:32 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ARC: update the help message for
 CONFIG_ARC_BUILTIN_DTB_NAME
To: Masahiro Yamada <masahiroy@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
 linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20240831101045.1381258-1-masahiroy@kernel.org>
 <CAK7LNATtOzj175_Y0qQz338FRG1GYCrsorA=jWG+Go1Wjn9rnw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <CAK7LNATtOzj175_Y0qQz338FRG1GYCrsorA=jWG+Go1Wjn9rnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/31/24 03:13, Masahiro Yamada wrote:
> On Sat, Aug 31, 2024 at 7:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>> Commit abe11ddea1d7 ("ARC: [plat-arcfpga]: Enabling DeviceTree for
>> Angel4 board") changed the default built-in DTB from "skeleton" to
>> "angel4".
>>
>> Commit fd1557923b2e ("ARC: [plat_arcfpga]->[plat_sim]") changed it
>> from "angel4" to "nsim_70".
>
> A typo.
>
>  ... to "nsim_700".
>
>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Vineet Gupta <vgupta@kernel.org>

Thx,
-Vineet

>> ---
>>
>>  arch/arc/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>> index fd0b0a0d4686..d01e69a29b69 100644
>> --- a/arch/arc/Kconfig
>> +++ b/arch/arc/Kconfig
>> @@ -553,7 +553,7 @@ config ARC_BUILTIN_DTB_NAME
>>         string "Built in DTB"
>>         help
>>           Set the name of the DTB to embed in the vmlinux binary
>> -         Leaving it blank selects the minimal "skeleton" dtb
>> +         Leaving it blank selects the "nsim_700" dtb.
>>
>>  endmenu         # "ARC Architecture Configuration"
>>
>> --
>> 2.43.0
>>
>


