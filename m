Return-Path: <linux-kernel+bounces-243246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B404A92937C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 14:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F3E1C21457
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CB07D401;
	Sat,  6 Jul 2024 12:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgQ3AoNq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9ED17FE;
	Sat,  6 Jul 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720268037; cv=none; b=ZoN/H6b06dHsZ9xMymGbnOqS5eCyhAog+DGRb2YTj/CZUtx90zntdVNxhmMCeaLSOG9CXvi2I+lgyFnBWhlyhYD0Tr7O9+wYIK6ilGVOhlEnvZUIfQ2HFI29eolfA7s1RKjJCCt3YOeX0grnJP7FQ8DynOpvJeboc5aBrQMAQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720268037; c=relaxed/simple;
	bh=+atnM+sTNzc3s7SG9E8Qur1BUOFc6hJDcQTnxk3hqk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMrWSlGPIDincTE0S4bjyTZKvNgdkJdvvW2Q2EKWYhxlszvDIqYzGLfl1BgC09QqSG+rK3SRjFFMcIe0OA70Kjx3E9TbfJz6jwc++f3zoJScCceV4A7imIhR459SbPFJoyDLKzDj8bvL97R9uSFeoZn4upCDBDj2sCZv3FD8ODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgQ3AoNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 603EFC2BD10;
	Sat,  6 Jul 2024 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720268037;
	bh=+atnM+sTNzc3s7SG9E8Qur1BUOFc6hJDcQTnxk3hqk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fgQ3AoNqQ90COdJy8KxvdqruB7NIdqqEgrOdTs8UqpHMkXjCuwiubSvVv1PlF3AN+
	 +If/folhBSCQTCh9kzcNAdL9A05MBH1FkKYniqO7BPkjOL2oFIpw9+NO7J0qUZialu
	 9NUWb0Wpifp8D0cpQiI/GSXsVjYgDUQyGvtjrRuZkNaLG6zZpLjWaesTsmPAT1b3x1
	 wYNT8OHgvBXz7kPdedkdWfkzI9WSekNCG78o1LrDtdNJnq4H4cJef5uUE1DVaykHl4
	 2gVA3ZjLmOKtVP6myKUZnxCgVmuCgkybuf/Impjqui0tUm/oA3o7A2h2Mb6yQBbw8B
	 RchMswYc+W+yA==
Date: Sat, 6 Jul 2024 13:13:53 +0100
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] udp: Remove duplicate included header file
 trace/events/udp.h
Message-ID: <20240706121353.GC1481495@kernel.org>
References: <20240706071132.274352-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706071132.274352-2-thorsten.blum@toblux.com>

On Sat, Jul 06, 2024 at 09:11:33AM +0200, Thorsten Blum wrote:
> Remove duplicate included header file trace/events/udp.h and the
> following warning reported by make includecheck:
> 
>   trace/events/udp.h is included more than once
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Thanks, I see that trace/events/udp.h is also included on line 36.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ipv6/udp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index c81a07ac0463..bfd7fff1bc0c 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -46,7 +46,6 @@
>  #include <net/tcp_states.h>
>  #include <net/ip6_checksum.h>
>  #include <net/ip6_tunnel.h>
> -#include <trace/events/udp.h>
>  #include <net/xfrm.h>
>  #include <net/inet_hashtables.h>
>  #include <net/inet6_hashtables.h>
> -- 
> 2.45.2
> 
> 

