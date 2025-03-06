Return-Path: <linux-kernel+bounces-549436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A8A5528F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775851763B3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266D25D218;
	Thu,  6 Mar 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Z6FfQSYH"
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308725A335
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281049; cv=none; b=aNXPst4sWKXNexzk/lspS8s+popULX5MUHAv2WA8qnuD7p2OmJQcszLaAUFwN30Bz8wSQ42UqXGvpbrIXF6v8C59KqtCdNycpxFROlguNqkruXWV8PYzZ7FO74m4PGzkAMBH9PsSaLFGhSpZ4lyQNn2VdCzn6CZYRMs2bv04Pyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281049; c=relaxed/simple;
	bh=5wWPGO67RY+SIsT3NY+jMeWXjQPlfwzPt4k1PxkZo3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK9o9KKBBXrQheK/qtU8QDiq8s4zFBQiwXEoTJ+LhU8811PRAXvTJ/iGxeJRY0zYzfq0ZxnOMdERHvp/uLOEZDM8ThxsRF+U7NjPv0F3Qbjg0xaofQ8QTa18FGRXal5aO3+8uvpjuRdROQ2a/rSgin1bDwaEdT4dyyFGd4PUGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Z6FfQSYH; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id qEjstfRGtQBhYqEjytwcmv; Thu, 06 Mar 2025 18:10:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741281042;
	bh=AcXvdcwkshwhiYBYbISTdU+fXgHvnVIWLoGFLaK/LSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Z6FfQSYHH1Ol08L7ET9tSXK7Mo2lZdrbvwMt4TCu04RDpe1dOq/w+TOzlQRT7/MZa
	 bC5IUve/j4baW3dFxfr0gWJqCFLqGmfwkgN9roksYbWqz2h67lDcu9IZeO4xJuTRdG
	 uSybdgWW2hHmJT1j81A7IgRe4RwP9liz+KGUTrTDv73eDTpLwfUfGW8Q1Y7aFCFcRV
	 kU5a9EsxhrKDlTeS+NZHwHvqM9Rh+YoYUHo32P9bEO0T2URNiYraQF0lrRoFRq/Nay
	 CPSDCe4uJfBJbyCMtcEj+8oljeFN/nhj2uWepsE/uM+WDp9FC/wBiOsfbUUXLgzgGj
	 Wo4Pmh8fVkxSw==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 Mar 2025 18:10:42 +0100
X-ME-IP: 124.33.176.97
Message-ID: <f15eac8c-567c-4ae5-bf9b-bb3964c83846@wanadoo.fr>
Date: Fri, 7 Mar 2025 02:10:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] bits: split the definition of the asm and non-asm
 GENMASK()
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@aculab.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20250306-fixed-type-genmasks-v5-0-b443e9dcba63@wanadoo.fr>
 <20250306-fixed-type-genmasks-v5-1-b443e9dcba63@wanadoo.fr>
 <fao7tp2y66f7nuep4nl6kz5zenfpzswp3hwqiw325uitgu6u6u@7dipwr3vjui7>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <fao7tp2y66f7nuep4nl6kz5zenfpzswp3hwqiw325uitgu6u6u@7dipwr3vjui7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/03/2025 at 23:34, Lucas De Marchi wrote:
> On Thu, Mar 06, 2025 at 08:29:52PM +0900, Vincent Mailhol via B4 Relay
> wrote:

(...)

> it seems we now have 1 inconsistency that we comment why
> GENMASK_U128() is not available in asm, but we don't comment why
> GENMASK_INPUT_CHECK() is not available there. Maybe move this comment on
> top of GENMASK_INPUT_CHECK().

I will restore the comment in v6 and put it next to the asm definition,
c.f. my reply to Andy.

> Anyway,
> 
>     Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>

Is this only valid for the first patch or for the full series? If this
is for the full series, would you mind replying to the cover letter with
your review tag?

> thanks for picking up this series.

You are welcome!

> Lucas De Marchi

(...)

Yours sincerely,
Vincent Mailhol


