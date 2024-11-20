Return-Path: <linux-kernel+bounces-415359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C65869D34F5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE9BB23638
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 08:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3664158858;
	Wed, 20 Nov 2024 08:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mx03TH2p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pxmjKT1u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67195336D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089797; cv=none; b=KDzFwbQAw571uqqLLj5kJgDDpakdBcgD0aoPfN/W1FATSp589RQeYnYhdxhaRWAxAN7ZTQpxYYsD52fkk3o98i0u9pWSw9kC9z0omPmHomSvjYzRoHH0J50wiJ46U7e+i0++8poSSSA4uQLBeQG9N6tqDugWfOnVKV7tjZo2u7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089797; c=relaxed/simple;
	bh=KSvWr9z+Nm9JK7b+fiplFIq1q7ymuf3TXnxJImZNBjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3DXus5PGcJ6j2O/9ywsSA/dyRpQg23D1SfytCUy7kOMgaPr8JnftM5HdwfDFPtovj9AweGbEmrclc8tz0dMY4QdCC7UASQuVi/QVcT+iY9YOikG2kJTbSyUDDWV+Fcfyz+xB0Onf44iFDGUIIcq3UtNke+4pa03YVXS7TZN3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mx03TH2p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pxmjKT1u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Nov 2024 09:03:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732089794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfV1WAQ9tmFqKF8zPT+eY9DsFIJS+PHexLAxTxwIsrE=;
	b=Mx03TH2p320xy+t/qTvrlo4RP8VFO45m2CeHMwiBajsSg5zMkY+4EaICsE5pY9wZbdmyjZ
	BrdJdUAIfR/p2xL3nUKUuHqNqXJ6FC+MpfM9DZ9xIQzGIfi1nkZsmYBkSloYeAjlrYccCR
	DzDbzeVu7A9nr78xhiUTmKGwCavtN/dvT82VEs3JXNP2Ok2zd/ht8JZvzh1xdOEN+r0e5F
	JxGrZRYUUy6r75x/gDHzAUPvQQm3LTnXvdKfqdoywdqBwpbEg8tZHCG7kAzLof630SaZ4+
	WybMyFq4bSd1hPesQDL1jvrCAe3mub+47fP8kF/TCKnPhouJZu6aSyOJnU0U8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732089794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kfV1WAQ9tmFqKF8zPT+eY9DsFIJS+PHexLAxTxwIsrE=;
	b=pxmjKT1un/fROvuJFiu3qBCmO9iUQ9pmgJASjRbrW2OVLlQLVpnJM90lWo+tM+pZTHJ+2G
	O+bdX2eLE/U0wlBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
	christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] powerpc: Large user copy aware of full:rt:lazy
 preemption
Message-ID: <20241120080312.uHw4eJcQ@linutronix.de>
References: <20241116192306.88217-1-sshegde@linux.ibm.com>
 <20241116192306.88217-3-sshegde@linux.ibm.com>
 <874j43hqy8.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <874j43hqy8.fsf@oracle.com>

On 2024-11-19 13:08:31 [-0800], Ankur Arora wrote:
> 
> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> 
> > Large user copy_to/from (more than 16 bytes) uses vmx instructions to
> > speed things up. Once the copy is done, it makes sense to try schedule
> > as soon as possible for preemptible kernels. So do this for
> > preempt=full/lazy and rt kernel.
> 
> Note that this check will also fire for PREEMPT_DYNAMIC && preempt=none.
> So when power supports PREEMPT_DYNAMIC this will need to change
> to preempt_model_*() based checks.
> 
> > Not checking for lazy bit here, since it could lead to unnecessary
> > context switches.
> 
> Maybe:
> Not checking for lazy bit here, since we only want to schedule when
> a context switch is imminently required.

Isn't his behaviour here exactly what preempt_enable() would do?
If the LAZY bit is set, it is delayed until return to userland or an
explicit schedule() because it is done. If this LAZY bit turned into an
actual scheduling request then it is acted upon.

Sebastian

