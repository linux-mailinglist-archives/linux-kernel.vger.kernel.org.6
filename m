Return-Path: <linux-kernel+bounces-577270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09274A71AD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2EF16ED44
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5D1F419E;
	Wed, 26 Mar 2025 15:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U4/lSeD6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y68hG9kK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60911F4197
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 15:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743003428; cv=none; b=cGsJ6UwW5YkHVDJKQV/lnWciM9YhBKl/kQJ5ucTfvcRZYOzbELCkDFYfV1Qbh5oKa4FIFV9bGugL+WuxnQf9S/GfWfyAwJb801zH7QxUZkmKyuk6Ic6NnpDTzJXMi7hWjnlno2gE+Qn8Jr3Q7cd2CXlG/Ybw1qAHV4PPUjS/lcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743003428; c=relaxed/simple;
	bh=ZH/Qib1KROeOJAvECS53oTCCdB2Xyz1o3yyLgdvDp9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K84ZGpRFEhz5PSbW1X5ITqYtcAqHf0bcaiGk3MECgkmwgYgf4kaTqMw2D9JiQkKq90nZp3LX4NAONiL4FZVBHaP1NufvlaWVK7dZP76xhGoa/dKgXpYU+OVZCMwSguYLku9iC6oHQ7XP7eahAx+LKv30/NS7bf0YNhxFr+tFe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U4/lSeD6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y68hG9kK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 16:37:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743003424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DboYwCcNZGXRf6439BqA6sDYH2xWbE0J5kLD+XvfReE=;
	b=U4/lSeD6smV6aX6xEK55wCzPzYTc87kevaKD/XFlzbnkEohLUwT/U1S4k0OW2l7184qSNa
	i0n8W8V4UmWE1A3stOCg9q0JeK8/mVISLE027w0dBcmXbIJa0x/IdR3M1ajzpqtOVEDFrm
	PdhwnUFYOW5w8K663M1ZiwtGo8Q0qIfC7WtqLuZQQWK6JOebSsH+fZYufnPofR70KzkiMf
	BAQ9cjAFn7vWDcWiWwZLHOGrYrMr/bAtH93uiFVHxSfn8E6bPkyG5L3AhXhhWQiJnC302k
	3lVW5+sKMSBYHMglEuaLjID3Jcp0PQDp6d9D+ZH4z3V2Jncvbq2CiSVKCtouFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743003424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DboYwCcNZGXRf6439BqA6sDYH2xWbE0J5kLD+XvfReE=;
	b=y68hG9kKuGAA+uhJrcOy3pj1a9ywJANa4iyka0FgkB6XQnmh5L1o7DZetk6H/vQROwqi7G
	qAMdWkEARtxc91Bw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 18/21] futex: Rework SET_SLOTS
Message-ID: <20250326153703.n_PgVpun@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-19-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250312151634.2183278-19-bigeasy@linutronix.de>

On 2025-03-12 16:16:31 [+0100], To linux-kernel@vger.kernel.org wrote:

I am folding and testing and
=E2=80=A6
> +static bool futex_pivot_pending(struct mm_struct *mm)
> +{
> +	struct futex_private_hash *fph;
> +
> +	guard(rcu)();
> +
> +	if (!mm->futex_phash_new)
> +		return false;
> +
> +	fph =3D rcu_dereference(mm->futex_phash);
> +	return !rcuref_read(&fph->users);
> +}
=E2=80=A6
> +static int futex_hash_allocate(unsigned int hash_slots, bool custom)
=E2=80=A6
>  		/*
> -		 * Will set mm->futex_phash_new on failure;
> -		 * futex_get_private_hash() will try again.
> +		 * Only let prctl() wait / retry; don't unduly delay clone().
>  		 */
> -		__futex_pivot_hash(mm, fph);
> +again:
> +		wait_var_event(mm, futex_pivot_pending(mm));

This wait condition should be !futex_pivot_pending(). Otherwise it
blocks. We want to wait until the current futex_phash_new assignment is
gone and the ::users counter is >0.

This brings me to the wake condition of which we have two:
> @@ -207,6 +203,7 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
>  	}
>  	rcu_assign_pointer(mm->futex_phash, new);
>  	kvfree_rcu(fph, rcu);
> +	wake_up_var(mm);
>  	return true;
>  }
> =20
> @@ -262,7 +259,8 @@ void futex_private_hash_put(struct futex_private_hash=
 *fph)
>  	 * Ignore the result; the DEAD state is picked up
>  	 * when rcuref_get() starts failing via rcuref_is_dead().
>  	 */
> -	bool __maybe_unused ignore =3D rcuref_put(&fph->users);
> +	if (rcuref_put(&fph->users))
> +		wake_up_var(fph->mm);
>  }

The one in __futex_pivot_hash() makes sense because ::futex_phash_new is
NULL and the users counter is set to one.
The wake in futex_private_hash_put() doesn't make sense. At this point
we have ::futex_phash_new set and rcuref_read() returns 0. So we
schedule again after the wake.
Therefore we could remove the wake from futex_private_hash_put().
However, if there is no futex operation (unlikely) then we are stuck in
wait_var_event() forever. Therefore I would suggest to:

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 65523f3cfe32e..64c7be8df955c 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -210,7 +210,6 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 	}
 	rcu_assign_pointer(mm->futex_phash, new);
 	kvfree_rcu(fph, rcu);
-	wake_up_var(mm);
 	return true;
 }
=20
@@ -1522,10 +1521,10 @@ static bool futex_pivot_pending(struct mm_struct *m=
m)
 	guard(rcu)();
=20
 	if (!mm->futex_phash_new)
-		return false;
+		return true;
=20
 	fph =3D rcu_dereference(mm->futex_phash);
-	return !rcuref_read(&fph->users);
+	return rcuref_is_dead(&fph->users);
 }
=20
 static bool futex_hash_less(struct futex_private_hash *a,

-> Attempt to replace if there no replacement pending (futex_phash_new =3D=
=3D NULL).
-> If there is replacement (futex_phash_new !=3D NULL) then wait until the
   current private hash is DEAD. This happens once the last user is gone
   and gives the wakeup.

Sebastian

