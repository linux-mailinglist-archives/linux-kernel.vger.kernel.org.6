Return-Path: <linux-kernel+bounces-574007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6224A6DF82
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA72167DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8716D2638B8;
	Mon, 24 Mar 2025 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="inZ+K/0E"
Received: from out.smtpout.orange.fr (out-68.smtpout.orange.fr [193.252.22.68])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDE525E81C
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833424; cv=none; b=XdTDohq9JGwr39hjyVcvlCqWpv6BlN0QyZR+1xyiT7ZjWPYvzWGi0GB/YnB2we8hKSBKvfSd1X+3HguS9bm1OnLYcNZfuNrHnTg0J091DCg6mhiGcMkgjXYpWIX+5ZHyFVWTveVFLwKjY/oKEX1W4Qkk/nGkpreQPrPOFDpN3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833424; c=relaxed/simple;
	bh=LOD+Kltnr1sw9R1SfnDVreU+aIDtLjFDKXoY+tkm9Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oc2U3WRFNkkJy4+Muu3pOHKdbqswNiDsgZFdLzIi5/fBkvM9xdYA5YXdM25RQ5qnWrK+b7XfyknZUxuic8WbBpdlE3b5/WS5XxJh8itTySvD/8mAmXOEKsRfNZZ9Wyt4FMXfhY5haMcY/7pJLp3YBCo+ME1kUeds6oaY0uzbWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=inZ+K/0E; arc=none smtp.client-ip=193.252.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id wkaBtZDD8cvxXwkaFtVg8z; Mon, 24 Mar 2025 17:23:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1742833414;
	bh=P9nD5PsBLzgHZd2DYjYHZ+C8TI1hL0ZPCCvHPL1SFBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=inZ+K/0EgTl/soIXsWxEWQb6xdeBc/Rx5cqjYRIjKiweIln1j7GhCIAOlLVAEiJee
	 PUhFCb7py0OhvcDzXafVXIZPpWvSHdN5p/sD0e6oKJbTYo22HXnonZr2PacIYvdEBp
	 VfQ41VxsX1xLT2ko2TJ4x1lt+j0S5NuyBUUA7Pua8LzN+x4nkFGBvJiNU6Et1xrXYB
	 USm0ZcLJ9so+g0k949Zb/sgT0WBSpGBhXgQarJdd8L1takI4dBRSuvyHKPwqqdWW0v
	 WOgdyB5J+GZy5ef+Vyigyc4/eUySAkhk99I3KQymFSxkdWILUPG9VDePy98WL+cXcL
	 5UuNStq0YyJKQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 24 Mar 2025 17:23:34 +0100
X-ME-IP: 124.33.176.97
Message-ID: <7e114fdb-0340-4a3c-956f-b26c9373041d@wanadoo.fr>
Date: Tue, 25 Mar 2025 01:23:22 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/5] bits: Fixed-type GENMASK_U*() and BIT_U*()
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
 Jani Nikula <jani.nikula@intel.com>
References: <20250322-fixed-type-genmasks-v7-0-da380ff1c5b9@wanadoo.fr>
 <Z-FsJPA1aq7KyTlm@thinkpad>
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
In-Reply-To: <Z-FsJPA1aq7KyTlm@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/03/2025 at 23:28, Yury Norov wrote:
> On Sat, Mar 22, 2025 at 06:23:11PM +0900, Vincent Mailhol via B4 Relay wrote:
>> Introduce some fixed width variant of the GENMASK() and the BIT()
>> macros in bits.h. Note that the main goal is not to get the correct
>> type, but rather to enforce more checks at compile time. For example:
> 
> You say this, and then typecast both BIT and GENMASK. This may confuse
> readers. Maybe add few words about promotion rules in C standard, or
> just drop this note entirely? Doesn't require new submission, of
> course.

I do not want to into this level of details in the cover letter, so I
will remove. Instead, I can add below paragraph to the "bits: introduce
fixed-type GENMASK_U*()" patch:

  The result is casted to the corresponding fixed width type. For
  example, GENMASK_U8() returns an u8. Note that because of the C
  promotion rules, GENMASK_U8() and GENMASK_U16() will immediately be
  promoted to int if used in an expression. Regardless, the main goal is
  not to get the correct type, but rather to enforce more checks at
  compile time.

I staged this change in the v8 together with the other nitpicks from
Andy. If you want that v8, let me know, it is ready. If you are happy
enough with the v7 (and if it doesn't receive more comments), then go
with it!


Yours sincerely,
Vincent Mailhol


