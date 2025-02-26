Return-Path: <linux-kernel+bounces-534711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FA2A46A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82AE7A1FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA88236458;
	Wed, 26 Feb 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfkdwJ70"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74830236436
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595901; cv=none; b=Mvc4BDdO0bIDS/cQvyu92JCEu8v6FE+Y3Sro+aWf0gzVzcTJb9Tq61b7Yadm8sp/s023yvQIgSmBr03kcwzNN4PRyPuVPnqq5h07f1eMw1Te4yFmeiFTHAw5zgnlNh2Ds9lHIFEcUb7sEoCyAzCaByY04RATUhifCimZG54zXbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595901; c=relaxed/simple;
	bh=i9V5i01ISjZzM9o0gfYhbxTpiZYx9ptnyYVljTR827U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXfxo8fa3iA/AncmqqcRGbczWzGPto1wQGWfX9RkYvRPrS3ox3nZ/XUz+pg4ROxCw3ZtWJ1dtrJdmEpjKRaNd8mb1q0ndBMWaAkdkHXqqTrh7GNzzMeg6sm6WgTeLRM5fIMs6niHJr3qF59mAAxt3ktnKpAW/YYQaWw3TibnIjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfkdwJ70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B71C4CED6;
	Wed, 26 Feb 2025 18:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595901;
	bh=i9V5i01ISjZzM9o0gfYhbxTpiZYx9ptnyYVljTR827U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OfkdwJ70LNJ8WCf5Prlvbs/alQfb2NMdvh3aZjNTiCKkKMyABZQ808husfqChbdOW
	 YKtCWdvVRhv39xVwz48HoWxJg8S4W2hG//ZpAatw4aKWU7S4ZLwGwg7t3XS7wQYMlB
	 mGtWCBh/ZLuPglvBbuQ03JPRxvvlOCi5L81bnPhp2IMyyZHQLsjB3nMNjLEejMC16Y
	 2TxYlfIPAD+/tH4pJLAp0+6KljAb6blWAD7YWZ0IS4INEGSFKpvqr7RuyB4JnpX0Pj
	 YGW7SGzjEBIugRxr7RYvdzBN0mE2eqRJ1C9t06yeds63V6id2sFRMYR6bRNt1InivT
	 yJKjw229dijpQ==
Date: Wed, 26 Feb 2025 08:51:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add trace point to track sched_ext core events
Message-ID: <Z79ivCISjmFlkecF@slm.duckdns.org>
References: <20250226143327.231685-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226143327.231685-1-changwoo@igalia.com>

Hello,

On Wed, Feb 26, 2025 at 11:33:27PM +0900, Changwoo Min wrote:
> Add tracing support, which may be useful for debugging sched_ext schedulers
> that trigger a certain event.
> 
> Signed-off-by: Changwoo Min <changwoo@igalia.com>
> ---
>  include/trace/events/sched_ext.h | 21 +++++++++++++++++++++
>  kernel/sched/ext.c               |  4 ++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/include/trace/events/sched_ext.h b/include/trace/events/sched_ext.h
> index fe19da7315a9..88527b9316de 100644
> --- a/include/trace/events/sched_ext.h
> +++ b/include/trace/events/sched_ext.h
> @@ -26,6 +26,27 @@ TRACE_EVENT(sched_ext_dump,
>  	)
>  );
>  
> +TRACE_EVENT(sched_ext_add_event,
> +	    TP_PROTO(const char *name, int offset, __u64 added),
> +	    TP_ARGS(name, offset, added),

Can we do sched_ext_event with @delta? Otherwise, looks fine to me.

Thanks.

-- 
tejun

