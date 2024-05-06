Return-Path: <linux-kernel+bounces-170500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 078BE8BD81F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3883E1C21E74
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F115CD7C;
	Mon,  6 May 2024 23:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="YgYAxv60"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89367140E38
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037485; cv=none; b=iFaTGxOMOUf9tMb5gQrRctgofo+leQYKSBqMgL+XqxC2mWNpyaBxez59eayFv4wNt1D/caqM9lDSHh4CiTrra4/HRhq9BNUzwafHUeqVf6/fdyofxGrKYDyP3Am+u1DHhhkuZtn+YsMfT3dSqbbSPtaik2CqU1n3HPLeSOfx9V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037485; c=relaxed/simple;
	bh=mGW9+K91pwJSeBCqfEmqJmTNvzjWv33S8x3z8z3Hc1k=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=AWOgjpYdge2bmi3Rd9MMx+I+usJKboGvqdt+gOJa6IOwmeBJrGTE47k37Vz4mMMzSpvw3sIDvtbSUzPkF4CvWEYOjrTqD1aeoKhdcTFFJcgUCeWHg4u7fdSEH/lNRbcwgIZnjNbfpp5NmDh4sDY08718AJy0CshZ7BBBUMz6whI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=YgYAxv60; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 89DCF240028
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:17:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1715037474; bh=mGW9+K91pwJSeBCqfEmqJmTNvzjWv33S8x3z8z3Hc1k=;
	h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:
	 Cc:Subject:Message-ID:From;
	b=YgYAxv60it9j+0wJBKZIO2LFltJQLwcKuK6wYdG02viEcNv5AhwxQggZWxkPVVUD4
	 omrUOrInOKGM6OlsJmrg0qKAMC+RxqiYef/NeLU2ikM0WmDdnVH045OA0lsmeeobTK
	 VGrYPyBOWiLMEMpXBhpMeXBI6NxPdmIpt5F1zolqiI4JX8yoQG5aDT2OEEehtzHx0/
	 acnt47zdOtrdLDmGKp64bNY9xgJBCiHUpJUwTsL0tOssYaxOSptLFAqeyDMW4FcSrz
	 zSHDcXuGNSUuwsKP5a8hf21GqnhvojZlm+9PJJEjU//4wTAntSW0rHPWZib5EEw92U
	 +Y6WM/porbKgQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VYHPs1tCcz9rxB;
	Tue,  7 May 2024 01:17:53 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 06 May 2024 23:17:53 +0000
From: Yueh-Shun Li <shamrocklee@posteo.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Hu Haowen <src.res.211@gmail.com>,
 Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] coding-style: recommend split headers instead of
 kernel.h
In-Reply-To: <7a0f057c-1544-49e2-9bbe-a46eb33dc8ac@infradead.org>
References: <107b6b5e-ca14-4b2b-ba2e-38ecd74c0ad3@infradead.org>
 <20240108201851.191604-1-shamrocklee@posteo.net>
 <20240108202217.191839-1-shamrocklee@posteo.net>
 <7a0f057c-1544-49e2-9bbe-a46eb33dc8ac@infradead.org>
Message-ID: <f20b378af31b080a01bfdef0e15b01d8@posteo.net>

On 2024-01-28 14:26, Randy Dunlap wrote:
> On 1/8/24 12:22, Yueh-Shun Li wrote:
> > In section "18) Don't re-invent the kernel macros" in "Linux kernel
> > coding style":
> >
> > Recommend reusing macros from headers inside include/linux, instead of
> > the obsolete include/linux/kernel.h
> >
> > Change wording
> >
> > - "The header file contains macros" -> "the header files provide macros"
> >   Some macros are intended to use inside the header file only, or are
> >   considered the implementation detail of other facilities. Developers
> >   are expected to determine if a macro is meant to be used outside the
> >   header file.
> >
> > Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Thanks.
> 

Thank you for acknowledging.

Anything I could help to push it forward?

> > ---
> >  Documentation/process/coding-style.rst | 24 +++++++++++++-----------
> >  1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 6db37a46d305..2a5c4f4c568c 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -1048,27 +1048,29 @@ readable alternative if the call-sites have naked true/false constants.
> >  Otherwise limited use of bool in structures and arguments can improve
> >  readability.
> >
> > +
> >  18) Don't re-invent the kernel macros
> >  -------------------------------------
> >
> > -The header file include/linux/kernel.h contains a number of macros that
> > -you should use, rather than explicitly coding some variant of them yourself.
> > +The header files in the ``include/linux`` directory provide a number of macros
> > +that you should use, rather than explicitly coding some variant of them
> > +yourself.
> > +
> >  For example, if you need to calculate the length of an array, take advantage
> > -of the macro
> > +of the macro ``ARRAY_SIZE()`` from ``include/linux/array_size.h`` by
> >
> >  .. code-block:: c
> >
> > -	#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> > +	#include <linux/array_size.h>
> > +	ARRAY_SIZE(x) // The size of array x
> >
> >  Similarly, if you need to calculate the size of some structure member, use
> > +``sizeof_field()`` from ``include/linux/stddef.h``.
> >
> > -.. code-block:: c
> > -
> > -	#define sizeof_field(t, f) (sizeof(((t*)0)->f))
> > -
> > -There are also min() and max() macros that do strict type checking if you
> > -need them.  Feel free to peruse that header file to see what else is already
> > -defined that you shouldn't reproduce in your code.
> > +There are also ``min()`` and ``max()`` macros in ``include/linux/minmax.h``
> > +that do strict type checking if you need them. Feel free to search across and
> > +peruse the header files to see what else is already defined that you shouldn't
> > +reproduce in your code.
> >
> >
> >  19) Editor modelines and other cruft

Best regards,

Yueh-Shun

