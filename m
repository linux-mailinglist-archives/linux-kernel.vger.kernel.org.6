Return-Path: <linux-kernel+bounces-194942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BC88D44AB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 07:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BD6B23EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 05:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B04143C42;
	Thu, 30 May 2024 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uRn7mB89"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A12BD0F;
	Thu, 30 May 2024 05:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717045527; cv=none; b=HARMNBBN/pbQCETikeO2ASzpfNPJL2TQjxG9mVKpaennWS0BR5TzjN0V8Avaq10ZIHqFJh9bKTmzHeoaBuvQrhyvVOXcXpaAJKPt+hcEvtWKIXq07l+ziV1c1E0Ddswep0gG7z3UvJYQEwC4jLfkPKd5lEbPvlPXuNyKBvO0XcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717045527; c=relaxed/simple;
	bh=s9qXRDE3kVrAi41iJlR/Y5hBZergFEJWL5Qw7DmJZ7U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R7eFEQK5s6YRhRm4WvR8P/QSIarfVXT2BpCQzig9HLkB2mnkqtuCGGCpO5/fV2H/7QY785rR6TLdE6AHdDqNE6TLHRal84gCsjJO2j0CG3BbiXPmso7Iy10vvZ/b87eLg4eFI0PxQKFstrlrcTU0O7WQ09NyoFnMLKBpzpK3Fl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uRn7mB89; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717045523;
	bh=s9qXRDE3kVrAi41iJlR/Y5hBZergFEJWL5Qw7DmJZ7U=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=uRn7mB89I2VpD/4rjIY1xGx+r6xJfQejHjCuoOWO4c/11bqz6E8UDyH8oCtRy8De5
	 +u9cNLQ7jSV+UjaBF5LbzSSx+I2UuXiO45/rk1i4nxYrAs/gqIFg/M4o53AOfwxB2b
	 yDf/uArjFtwVZu7P+zFsjZAe0EDDiMTgcQkE0iSR5b4ONJLHZtl1zLUgXMw0omEXkM
	 GR5pSuxMjjNLp8Jv2xSuM1DXliLmW+YMlOiRnzhf8DQakzTI460aVtC5I6fpucz8n5
	 HD6H8SfxLy/V3nYvyAJrLlvprQyqPpy5l+03hLdEQlY0S6l2R1op6IFB+VCsgUD+C8
	 EIC1PfLBwUgfg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CC77A3782173;
	Thu, 30 May 2024 05:05:13 +0000 (UTC)
Message-ID: <20323e06-e2f6-4991-8b63-4471b6567932@collabora.com>
Date: Thu, 30 May 2024 10:04:43 +0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, Bill Wendling <morbo@google.com>,
 sunliming <sunliming@kylinos.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Nathan Chancellor <nathan@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 1/2] selftests/lib.mk: handle both LLVM=1 and CC=clang
 builds
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20240529020842.127275-1-jhubbard@nvidia.com>
 <20240529020842.127275-2-jhubbard@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240529020842.127275-2-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/24 7:08 AM, John Hubbard wrote:
> The kselftests may be built in a couple different ways:
>     make LLVM=1
>     make CC=clang
> 
> In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest
> of lib.mk, and any Makefiles that include lib.mk, can base decisions
> solely on whether or not LLVM is set.
> 
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/lib.mk | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 429535816dbd..2902787b89b2 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -1,5 +1,17 @@
>  # This mimics the top-level Makefile. We do it explicitly here so that this
>  # Makefile can operate with or without the kbuild infrastructure.
> +
> +# The kselftests may be built in a couple different ways:
> +#     make LLVM=1
> +#     make CC=clang
> +#
> +# In order to handle both cases, set LLVM=1 if CC=clang. That way,the rest of
> +# lib.mk, and any Makefiles that include lib.mk, can base decisions solely on
> +# whether or not LLVM is set.
> +ifeq ($(CC),clang)
> +    LLVM := 1
> +endif
> +
>  ifneq ($(LLVM),)
>  ifneq ($(filter %/,$(LLVM)),)
>  LLVM_PREFIX := $(LLVM)

-- 
BR,
Muhammad Usama Anjum

