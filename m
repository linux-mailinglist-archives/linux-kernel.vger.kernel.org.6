Return-Path: <linux-kernel+bounces-262647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4DC93C9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551CB28188F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE413D530;
	Thu, 25 Jul 2024 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eJGYm9Ul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327E58222
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721941056; cv=none; b=gHPF5BydGIdnm9gjFfToLNQPGBePiXZWoeqMqHgmIOTOBEo9CuOcGbHKYwyu8l0OFAn7kvD2E70h82lCAI+Wf/NZ5OemVEyCte31rChmUjZRvDlMYHEt3a/8n8d+5SvcbNllOjdcAL4ITtS3FB/oP/xRvhM1fu1CrgQMdmF0NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721941056; c=relaxed/simple;
	bh=oCqhEoatUysZDV/Xta9kzXHM7WqwlbgbiMyOQAmmJTA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QeLqb6CD2QDuVaHcldBXvgREkc354Uh3FhdhLvqNexrvcAiOI29bkAvJWlD3NvcdtWSmGRqEcowC7vMBaqpAotfWyRY5yaytkCzQJ9RyRirrHLIrvNQHPOjLEha4fth1Tf33Me6Ryc9SOpxCxe6ddUeCRYgtwmUeAJczHA15MRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eJGYm9Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15844C116B1;
	Thu, 25 Jul 2024 20:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1721941056;
	bh=oCqhEoatUysZDV/Xta9kzXHM7WqwlbgbiMyOQAmmJTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJGYm9UlJWWZAZFoD/+uPjYqYg6XvNsn+34YIEDe6CENWWgfLnkjdO/q4HYFE0EoM
	 ZRzgBKueYEqHiZGddPFCuASZuko19HADEtmFXp6ZF1IbF6vrdSruecODl1mgwOJlcb
	 UfJSYdQQjABNIciAEqSKuScooRF6tOMDGLIuUWjM=
Date: Thu, 25 Jul 2024 13:57:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: mohitpawar@mitaoe.ac.in
Cc: pmladek@suse.com, yoann.congal@smile.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Fixed: Kernel: user_c: fixed whitespace &
 intendation errors
Message-Id: <20240725135735.7ff3013146eab9a25be6bf92@linux-foundation.org>
In-Reply-To: <20240713174137.125978-1-mohitpawar@mitaoe.ac.in>
References: <20240713174137.125978-1-mohitpawar@mitaoe.ac.in>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jul 2024 23:11:37 +0530 mohitpawar@mitaoe.ac.in wrote:

> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -6,7 +6,7 @@
>   *
>   * We have a per-user structure to keep track of how many
>   * processes, files etc the user has claimed, in order to be
> - * able to have per-user limits for system resources. 
> + * able to have per-user limits for system resources.
>   */
>  
>  #include <linux/init.h>
> @@ -249,7 +249,7 @@ static int __init uid_cache_init(void)
>  	uid_cachep = kmem_cache_create("uid_cache", sizeof(struct user_struct),
>  			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
>  
> -	for(n = 0; n < UIDHASH_SZ; ++n)
> +	for (n = 0; n < UIDHASH_SZ; ++n)
>  		INIT_HLIST_HEAD(uidhash_table + n);
>  
>  	if (user_epoll_alloc(&root_user))

I think this is too minor, sorry.  We could merge a million patches
like this.


