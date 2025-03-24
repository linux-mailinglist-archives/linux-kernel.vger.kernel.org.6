Return-Path: <linux-kernel+bounces-574052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C976BA6E006
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC9916C698
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A32263C90;
	Mon, 24 Mar 2025 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="plw1bbqE"
Received: from out.smtpout.orange.fr (out-70.smtpout.orange.fr [193.252.22.70])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC7125F96B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834458; cv=none; b=kOALYOTiB8J84D0BvdymJileS43GIvS+nFXlRvElotkTjm2m9zmkSJ2qhchkQoktxJSssNrmXyVQkvIsOCBAOgevFUHKbScqfg108g3xZHESLc7vzJRup4v9O/VVYDIopGR245yoJZ6pLpB61i5S6tHSNzMxyzhW5vhTdSUsD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834458; c=relaxed/simple;
	bh=97EUThDR2UybhnFKxS5EDbv/vBzfjXZFng3bm+j/nF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TBuyJ041o7YdftyqJc8FJYVpELkP9dRi+JZtKI/iK6fRg/6+Mc3ycBzy9PPQXjMQAZPl4IJDTybSbxLc1xq1l1lmg8iZ9UYsAA8NlRQ3rRZmTEARFQOd95hRcKazQgz0DoyFRePhcAedYXl58pzA0y3/TCPev9ua9f/VA6kOqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=plw1bbqE; arc=none smtp.client-ip=193.252.22.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id wkphtqyvuqGhjwkpntp5DD; Mon, 24 Mar 2025 17:39:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742834382;
	bh=fWDg5sAJRa5yGnJsUjCGug0MakuT+w++shbZerB1ON4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=plw1bbqE0z5rfrjQQw+4DOFlYoe4aXV3HOaYnSLm4RqTOwzMgwQKESyqhPy7pOEzI
	 RzgjMUqxC8ZfAHGz5LF9ADf/97gKqsFaQHLOpeDQdBoj4wEjt64flQbW5nouKULz4h
	 93zAhY4igdCOqZ4ALMnPyRm7wTEm2NxGiFBIckIwP30Sw8w6NISDz4h2kjuJfSikGp
	 jxqoEh4a/Cd8GSM30qRtkSdvYka3Cbow7j8N4sYl43NVW1kqgfg5H+HN8Fna2ogrA1
	 KA7ghA72CgLM2GpLM8NRIsgQ88QLvJBI8rk4/9xmMj4RW6KI9x4skpd9321SXaLNBp
	 ozWdbaJ0vBkRQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Mar 2025 17:39:42 +0100
X-ME-IP: 124.33.176.97
Message-ID: <1f9ea3e3-e348-46d7-9b15-8c017762b12f@wanadoo.fr>
Date: Tue, 25 Mar 2025 01:39:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bits: Split asm and non-asm GENMASK*() and unify
 definitions
To: Yury Norov <yury.norov@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Andi Shyti <andi.shyti@linux.intel.com>,
 David Laight <David.Laight@aculab.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20250322-consolidate-genmask-v1-0-54bfd36c5643@wanadoo.fr>
 <Z-GEFcciqCwxL88W@thinkpad>
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
In-Reply-To: <Z-GEFcciqCwxL88W@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/03/2025 at 01:11, Yury Norov wrote:
> + Anshuman Khandual, Catalin Marinas, linux-arm-kernel@lists.infradead.org
> 
> This series moves GENMASK_U128 out of uapi. ARM is the only proposed
> user. Add ARM people for visibility.

Actually, not yet. Here, I am decoupling GENMASK_U128() from
__GENMASK_U128(), but I did not touch the uapi.

After this series, __GENMASK_U128() is not used anymore in the kernel,
but I am not brave enough to remove it myself because there is always a
risk that some userland code somewhere is relying on it…

(...)

Yours sincerely,
Vincent Mailhol


