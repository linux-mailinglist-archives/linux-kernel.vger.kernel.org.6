Return-Path: <linux-kernel+bounces-311996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A330B9690B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 02:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8AF81C2274D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51F14685;
	Tue,  3 Sep 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kB30RQpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF68A32
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725323947; cv=none; b=KsPr3rH3HqB039zgzkTIqQUdLPJDCbZpLjWssW2VZDm76NT2piri4/rXeNVNiJPmciihECp4TUB6akeNBUxB2V6yrtn4rTvplpFuRzd2s9SAKVThGuJOS/lOrG9NHapxTscQpLmjo6YZXqjZBUD7dajQHdg4R8UxyieWNrcQJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725323947; c=relaxed/simple;
	bh=L0a0nrjGAFgoQWttgMG49s3T6rw3a9pOaJoC5sfVnOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=psspDvkgtL6eOFzPwlZd27Bg6HJyiwyWNHGKOe94vWIFdDK33XfjM6hrtwLry0XRBH5OD87tZruTonrW5L/o7P7TFWSbJBbIt4L9GuEqVbr5m1mg6OzODkWVGsfnnUFWyIgZsoy9SRQYVjj56ximQssgzEdqim/ckZuZELZteZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kB30RQpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB947C4CEC2;
	Tue,  3 Sep 2024 00:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725323947;
	bh=L0a0nrjGAFgoQWttgMG49s3T6rw3a9pOaJoC5sfVnOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kB30RQpjJJ19yruyvnmWtT/O2VXXBi3Nng1XCVtgXGz+lJRvTD1O87NM3qRqgjPHr
	 hPLrBbdTTQrvV9tikCjUca4sGKbXdg7s14tKm4Qldr1nQ4fs87NOmBsob4L+KiH/j2
	 /X3IfcN/vkITL+IJGFVzN4ZdAjG/UjBJOJYJv0pHkk7bHgq8EN2VhO7f/Upu4OzBTf
	 w6Yj92PWRN+6FYNdesM/craW4Ubp89dV6WzN55LqsLKSgxKwzyF2XI7L7bBeyspRzk
	 /plHTGjTM2/ynDghMCmqElcI3oVLzgzJN06ThVyTJqFNbVA+A/nMLNaj4RFQDzY5lD
	 TiNZ63kkRZVCQ==
Message-ID: <e72b55f5-2e12-43b1-8f9e-ddd7c9db8246@kernel.org>
Date: Mon, 2 Sep 2024 17:39:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARC: update the help message for
 CONFIG_ARC_BUILTIN_DTB_NAME
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>, linux-snps-arc@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240831101045.1381258-1-masahiroy@kernel.org>
 <CAK7LNATtOzj175_Y0qQz338FRG1GYCrsorA=jWG+Go1Wjn9rnw@mail.gmail.com>
 <8795e8da-981a-4876-99fe-8a4edb2185bf@linux.dev>
 <CAK7LNAQfpge7Hg8+yq3uyWD26D=kMcB3pKuoN+BGLfrOFFNgLA@mail.gmail.com>
From: Vineet Gupta <vgupta@kernel.org>
Content-Language: en-US
In-Reply-To: <CAK7LNAQfpge7Hg8+yq3uyWD26D=kMcB3pKuoN+BGLfrOFFNgLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 8/31/24 23:50, Masahiro Yamada wrote:
> On Sun, Sep 1, 2024 at 8:02 AM Vineet Gupta <vineet.gupta@linux.dev> wrote:
>>
>>
>> On 8/31/24 03:13, Masahiro Yamada wrote:
>>> On Sat, Aug 31, 2024 at 7:10 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>> Commit abe11ddea1d7 ("ARC: [plat-arcfpga]: Enabling DeviceTree for
>>>> Angel4 board") changed the default built-in DTB from "skeleton" to
>>>> "angel4".
>>>>
>>>> Commit fd1557923b2e ("ARC: [plat_arcfpga]->[plat_sim]") changed it
>>>> from "angel4" to "nsim_70".
>>> A typo.
>>>
>>>  ... to "nsim_700".
>>>
>>>
>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> Acked-by: Vineet Gupta <vgupta@kernel.org>
>
> Will you pick it up, or shall I do it?

I don't have anything major in my queue, so please take it.

Thx,
-Vineet

