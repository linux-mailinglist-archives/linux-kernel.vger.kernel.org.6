Return-Path: <linux-kernel+bounces-198064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE3A8D72F7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 03:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF6282275
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 01:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39EF1C06;
	Sun,  2 Jun 2024 01:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppQxBBd6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D963C;
	Sun,  2 Jun 2024 01:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717290417; cv=none; b=qxMoz6apnBH3APy57QNWUsOHRq66daQkk9X/qu1R1zLdeaZPNLVEJl3/vvscgwXOBwW9HQH+8OYdPsJ3aokLnNb+1TloC1SSbHAqr7/rPZI+Nao3uxFZK5/VZiHcpqohWHBA3EollHjldJjfR0t74rz+Tctx24qY/rBFVkoBrQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717290417; c=relaxed/simple;
	bh=pVZMQ1qOarTNrGsQmJUFaKtYr9izKNvW84lNlhxrxws=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dSVXZvXF/nWbcTwSlDA/3wSEnRmJikwcfhpaJvIpOem3MnSP4YgcXZKQfUMaXYR5U3m3hyatkTpE8IBAnC5dOPeEP6m153SIX+L9INeQgnlxxWUfYomBRBeaIUoNFxXe8qYrNzGysAvGRdrDw/2SQrZM9JFabHEwzvZtw2APgT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppQxBBd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3E2C116B1;
	Sun,  2 Jun 2024 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717290416;
	bh=pVZMQ1qOarTNrGsQmJUFaKtYr9izKNvW84lNlhxrxws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ppQxBBd6OsTM45Cq2t9Qozeg2HMeHihgIhP8QUPDZ5M1yOlBwCAUfXNC+OqOcuWzZ
	 1nEU2xJyPYvpXVt/OjbgT7LrE18V0nzyWcJQO6oeijHgRM04kE6kOFlyEUSzB4qAwC
	 05SL8Z60SO5MmiBWMah/aUHdtpirCPMo8pYPhVr9gqtAfI71sXt1twfELq0K6C6/a4
	 b/gbaYO3FBItjZ2fiSukXJLmXW8KrOjFQDeFKabmvVGE7AoqENPJpvBVlyqMpoIcF1
	 pM8rcl4gZpRXUF7yf9hChSZJ9U14b+ZxQElQwuvVanAvol40H0m6uHSM1AOyiFd5RX
	 PAkN7U1X39lhA==
Date: Sun, 2 Jun 2024 10:06:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] fprobe: add missing MODULE_DESCRIPTION() macro
Message-Id: <20240602100653.b73ac42fd9a010cece98ec01@kernel.org>
In-Reply-To: <20240601-md-samples-fprobe-v1-1-5d256a956612@quicinc.com>
References: <20240601-md-samples-fprobe-v1-1-5d256a956612@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Jun 2024 17:25:22 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/fprobe/fprobe_example.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 

Thanks for adding this. Looks good to me.

Let me pick it to probes/for-next.


> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  samples/fprobe/fprobe_example.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
> index 64e715e7ed11..0a50b05add96 100644
> --- a/samples/fprobe/fprobe_example.c
> +++ b/samples/fprobe/fprobe_example.c
> @@ -150,4 +150,5 @@ static void __exit fprobe_exit(void)
>  
>  module_init(fprobe_init)
>  module_exit(fprobe_exit)
> +MODULE_DESCRIPTION("sample kernel module showing the use of fprobe");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> change-id: 20240601-md-samples-fprobe-b2b92d8be350
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

