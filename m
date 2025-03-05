Return-Path: <linux-kernel+bounces-546630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C2A4FD10
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340E016F7D3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0E6230999;
	Wed,  5 Mar 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+W0SDdm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0643820D508;
	Wed,  5 Mar 2025 11:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172581; cv=none; b=j66qhNe5BBr+j0TUGfqeyITvx81SA9DOeKRSoLkSwU+yJyVhOw6wt4VIdNP65191BxYx1rrtQZLjbtbLp1cARlpFTSciw8cs2Y32ZkUR9Q9yZeFHH5w7M+JI/mlny6mUD2dQHAhDn7CA0ARYOzdt99+qpc/mi374hgjUr+jyZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172581; c=relaxed/simple;
	bh=rGJv2pMYOWgOkuJv/QdJlZWmnY/QX+rPMnbrawdSm8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3WJC2N47eZ9EGRJ5f1UOzsOpasNz3mdfvteu9sqwox/oFb1quEtB9csFxPXyQurjYQPmO6IJ1D+prlQ3GK8DXGhPlaPj/DJ+kLB/GDDGdJnIdiP3vHDnm8fnwvd5zcxQddukStceb43WgzWI60S3EyPA2AtlNVuAY9ZhgM4LqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+W0SDdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB79AC4CEE2;
	Wed,  5 Mar 2025 11:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741172580;
	bh=rGJv2pMYOWgOkuJv/QdJlZWmnY/QX+rPMnbrawdSm8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t+W0SDdmuFH/fy2F4X2vmwmZmw8TLa3gGMQdlozWhJ39ZicCwr2e5witl5Yy8K15K
	 5UiUXkCqUnSOEwLX3PSQDNZQf/CmNcaRBdbzXx7JJEiS9XvG+I7jsVvP7VlCDuGRmf
	 GPuh4/D7ReBU7J3IMKMShLnjNTEuYSlQ/+ZMK8cVexYeYTY8alHVZNDdie1Tshpw26
	 BF1NfocQFIMrRMbyg8JARr3JMNx9aODQKuZ1F8VGCekQi4AYKb3WmA9weTqsNxJ+pd
	 /5Bjo0ilP70Z8CrlyYL8fP5uqV86aFNuVFFYrTvuMHl2zCZ/lyZFdh7Oig7RJBp1wS
	 cIozVZQZkwNgA==
Date: Wed, 5 Mar 2025 12:02:56 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [tip: perf/core] perf/x86: Annotate struct bts_buffer with
 __counted_by()
Message-ID: <Z8gvYIYXMHRC-btB@gmail.com>
References: <20250304183056.78920-2-thorsten.blum@linux.dev>
 <174111554764.14745.14213573362217486017.tip-bot2@tip-bot2>
 <Z8gW1rihV0aIp8Oo@gmail.com>
 <04A79410-77DA-40F9-8904-44DC2DE1E810@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04A79410-77DA-40F9-8904-44DC2DE1E810@linux.dev>


* Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 5. Mar 2025, at 10:18, Ingo Molnar wrote:
> > Actually, on a second thought:
> > 
> >> - buf = kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), GFP_KERNEL, node);
> >> + buf = kzalloc_node(struct_size(buf, buf, nbuf), GFP_KERNEL, node);
> > 
> > Firstly, in what world is 'buf, buf' more readable? One is a member of 
> > a structure, the other is the name of the structure - and they match, 
> > which shows that this function's naming conventions are a mess.
> > 
> > Which should be fixed first ...
> 
> Yes, I noticed this too, but since buf->buf[] is used all over the place
> (also in other functions), I didn't rename it in this patch.
> 
> We could just keep offsetof(struct bts_buffer, buf[nbuf]), or use
> struct_size_t(struct bts_buffer, buf, nbuf) and still benefit from
> additional compile-time checks, or rename the local variable to struct
> bts_buffer *bts and use struct_size(bts, buf, nbuf), for example. Any
> preferences or other ideas?

To clean up this code before changing it, so that the changes become 
obvious to review.

Please also split out the annotation for instrumentation, it's separate 
from any struct_size() changes, right?

> > I'm also not sure the code is correct ...
> 
> Which part of it?

The size calculation. On a second reading I *think* it's correct, but 
it's unnecessarily confusing due to the buf<->buf aliasing.

So in a cleaned up version of the code:

  - If we name 'struct bts_buffer' objects 'bb'
  - and bb:buf[] is the var-array
  - and we rename 'nbuf' to 'nr_buf' (the number of bb:buf[] elements)

then the code right now does:

        bb = kzalloc_node(offsetof(struct bts_buffer, bb[nr_buf]), GFP_KERNEL, node);

... which looks correct.

Thanks,

	Ingo

