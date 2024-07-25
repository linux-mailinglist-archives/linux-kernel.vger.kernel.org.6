Return-Path: <linux-kernel+bounces-262310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25C693C3ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200381C21755
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E7619D06C;
	Thu, 25 Jul 2024 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="ciJhflOI"
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573319CD03;
	Thu, 25 Jul 2024 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917124; cv=none; b=LtKo0oXEooCoQIKsNZ9ii9vksCcRUnFUx5UpoHzbF7oN0iPInHkJCvDd895pmX23FiqfB0jE+/StGyX+uGgrB4MyC8in4EyAo1BbT0G0wmieVppqM+3H7mTmz4SsDNW1OI1l4oIjypGJbOIe+hp3Ut+LS/GvgEg+auVm8xJcJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917124; c=relaxed/simple;
	bh=tuSX/unVuxmJMrbQnnbLtHNpnc+B7rpxT3sHE2xxegs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5qxXDY4it3IYZqGxtLa2ywWRnYXZeUlXUbgato+BNZWlsGoNIno2nJyZQDkzoX4ccaCMljIW8NBaCBMvQ4bOAKH9FE6h7Q2ZzcUUzC1BVQuQltnANDVa3Oj+mCZboRonzhNXSzTCsBq/iVNrp+XtKvg0WDP9ErfYRc2QvCio4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=ciJhflOI; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WVCfc40T9z2FF;
	Thu, 25 Jul 2024 16:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721917112;
	bh=LGvBAeI7d3TP5tpuWK69jj0d9WRNKvh+Tnvf3Z/TFyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciJhflOItcdduxPcIY8GWhg/oNRV/IgsM1uSU6Y1pi/BRMhCXDsCwsWmdiolXRiFy
	 qYMsoYb41f08J5YM6N7mHNkERVfFO+VB6ZZO+6GOynzmHGFKrLBO5s1W1BXFzjr5s/
	 wI8zHv3gRba3R93DzxQWwuBTD5Fb7Z3oyWswOWvQ=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WVCfb30tVz4tp;
	Thu, 25 Jul 2024 16:18:31 +0200 (CEST)
Date: Thu, 25 Jul 2024 16:18:29 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect
 restriction
Message-ID: <20240725.wahChei0Hoo4@digikod.net>
References: <cover.1721269836.git.fahimitahera@gmail.com>
 <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 10:15:19PM -0600, Tahera Fahimi wrote:
> The patch introduces a new "scoped" attribute to the
> landlock_ruleset_attr that can specify "LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET"
> to scope abstract unix sockets from connecting to a process outside of
> the same landlock domain.
> 
> This patch implement two hooks, "unix_stream_connect" and "unix_may_send" to
> enforce this restriction.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> 
> -------

> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 03b470f5a85a..799a50f11d79 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> @@ -97,8 +97,9 @@ static void build_check_abi(void)
>  	 */
>  	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
>  	ruleset_size += sizeof(ruleset_attr.handled_access_net);
> +	ruleset_size += sizeof(ruleset_attr.scoped);
>  	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
> -	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);
> +	BUILD_BUG_ON(sizeof(ruleset_attr) != 24);
>  
>  	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
>  	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
> @@ -149,7 +150,7 @@ static const struct file_operations ruleset_fops = {
>  	.write = fop_dummy_write,
>  };
>  
> -#define LANDLOCK_ABI_VERSION 5
> +#define LANDLOCK_ABI_VERSION 6
>  
>  /**
>   * sys_landlock_create_ruleset - Create a new ruleset
> @@ -170,7 +171,7 @@ static const struct file_operations ruleset_fops = {
>   * Possible returned errors are:
>   *
>   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
> - * - %EINVAL: unknown @flags, or unknown access, or too small @size;
> + * - %EINVAL: unknown @flags, or unknown access, or uknown scope, or too small @size;

You'll need to rebase on top of my next branch to take into account
recent Günther's changes.

>   * - %E2BIG or %EFAULT: @attr or @size inconsistencies;
>   * - %ENOMSG: empty &landlock_ruleset_attr.handled_access_fs.
>   */

