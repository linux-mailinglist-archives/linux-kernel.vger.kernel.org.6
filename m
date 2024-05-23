Return-Path: <linux-kernel+bounces-187080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA8B8CCCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5931F2202D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CBE13C9D5;
	Thu, 23 May 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On9yjaCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D7213B2BB;
	Thu, 23 May 2024 07:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716448709; cv=none; b=rKDYi1a4pXDyxFmVgawU2enbQTP0rqgp82g6Xf6MYgOgs3ivigepSRJchSF+/GFPpfUolSFpyj3CgYW+l/dfvYBX4wMUHaqPIIkbvCxyumHARF90qde2D7KUgMpcWR82C9llGLXrzOeakaIQzwmajU5xr9huEftWW3IvYGDipRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716448709; c=relaxed/simple;
	bh=a5f59jxiYNclmlAtyb3Rr4cIcADY3snw4fj2h5kgFk4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=N6wWR/rFZWC8EHqrvNTdRoboCNsOBLkXaQf/m5YqdhdWab3tO7NfCDZcypkOuX/9dlB3V3D0j9oy+4SyExXRtxPoRV5aLR0+mCSzLZWBBb4W9KbwY3MsKylfdQ0q5QIko0ehdIp9LxvNQz9xoFvLo90SZfU0diuMgEJeRN9Bdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On9yjaCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED37C32782;
	Thu, 23 May 2024 07:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716448708;
	bh=a5f59jxiYNclmlAtyb3Rr4cIcADY3snw4fj2h5kgFk4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=On9yjaCpeoBICu/pSwwOT7OOA6SqlOCdNAn0UmCSoO0dlU+GVxSD8Ka3FjS4azzpH
	 H7qHRfqLZa1ljTHypLaYRjT7+fjDaO+yeRgzMFcZTGQIRinlLUSX3Kn9G8THqkCsmN
	 vaRYD1uXSML48OSncOGb3gJBGxd+8D014+1XdQJIbKVUQ72pP+I4iW0SPtuiS/ERXu
	 sfRBL1YpTBZSwEAEjrfRK/X3ffO1bInqXaOYMwPoWv5M6eprnfaab5jtGTIT0nZdGH
	 aLlOtKjrMCWzA9WDjOYc/GPIciaCeQNHoN9CO3yDWZhHNFKr+06D/VqCjJHsSt8Mtq
	 cwfordAhzwU9A==
From: Kalle Valo <kvalo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: michael.nemanov@ti.com,  Johannes Berg <johannes.berg@intel.com>,  Breno
 Leitao <leitao@debian.org>,  Justin Stitt <justinstitt@google.com>,  Kees
 Cook <keescook@chromium.org>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Sabeeh Khan <sabeeh-khan@ti.com>
Subject: Re: [PATCH 13/17] Add conf.h
References: <20240521171841.884576-1-michael.nemanov@ti.com>
	<20240521171841.884576-14-michael.nemanov@ti.com>
	<9ba9d156-ce38-47ba-b0fb-63e6174c3094@kernel.org>
	<87r0dtattp.fsf@kernel.org>
	<735594c5-5f50-49b0-b84c-e41efbb834b0@kernel.org>
Date: Thu, 23 May 2024 10:18:24 +0300
In-Reply-To: <735594c5-5f50-49b0-b84c-e41efbb834b0@kernel.org> (Krzysztof
	Kozlowski's message of "Thu, 23 May 2024 09:13:14 +0200")
Message-ID: <87ikz5atdr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 23/05/2024 09:08, Kalle Valo wrote:
>
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 21/05/2024 19:18, michael.nemanov@ti.com wrote:
>>>> From: Michael Nemanov <Michael.Nemanov@ti.com>
>>>>
>>>> Various HW / FW / Driver controls unique for the CC33xx that
>>>> can be set by OEMs.
>>>>
>>>> Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
>>>> ---
>>>>  drivers/net/wireless/ti/cc33xx/conf.h | 1246 +++++++++++++++++++++++++
>>>
>>> So you are adding one file by another? This does not help review.
>>>
>>> Add logical chunks, e.g. users of header after the header. Or all
>>> headers together. Or some features incrementally, like basic working
>>> driver and then feature foo and bar.
>> 
>> For new wireless drivers my recommendation has been to submit for review
>> one file per patch but the final driver to be commited would be just one
>> patch:
>> 
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#new_driver
>
> Understood.

Michael, it would be good to explain that in the cover letter so that
people don't get confused about these multiple patches. Maybe even
include the link?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

