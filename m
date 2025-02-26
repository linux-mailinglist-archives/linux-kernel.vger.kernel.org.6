Return-Path: <linux-kernel+bounces-532799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E4A4525B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 02:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE31819C07CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A43F17B506;
	Wed, 26 Feb 2025 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTpTTGjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690D67DA66
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740534324; cv=none; b=Cefb+qp+fOdFZ2F8xr6RWvec7VEe4z8PGuzZqXtdQks5erD+PqUEzJ0Dh0EWF4ZdTcwPMW7eFeLDw6SaqCPH3uw8Ftxl+W9FCq3ZtaG5SSsHaNSM0WJHe6k4orKAJtkRe/0gCBRaKx5nvOTjO0aU4SA9QLMZCL8qDZgwveqIIN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740534324; c=relaxed/simple;
	bh=ngX5hmUBid2B/leasE/ldqcaQuKWY4R/b6bE5lXGa9g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K9TLj6FobBQkDVLR08ZPIXsTEh/HpOo3ooDpUcBeWQ7n33azySDGaPjTsg/GRsZslmVwuo+2NoAsK9Op+doRZBDz48GOnxzA/ZOxUA6+GHquuYIkIW8Yk/y/lZfFcqBlHd5BkuxXVzSKJRZGIq1ULtF3KvmceFJJjyQjtDngu+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTpTTGjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850BBC4CEDD;
	Wed, 26 Feb 2025 01:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740534323;
	bh=ngX5hmUBid2B/leasE/ldqcaQuKWY4R/b6bE5lXGa9g=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rTpTTGjYdx2MUuAKzqQZmH2+d0v8Kbdea04pfGIjqYXLovNpjxmSR8xlnwTElkR5M
	 NxR1SjvxFJzLlqpXpEee9cB2M4LI+3e4m5pVxmKeKNB/CWu0/XIZ61PxW22rhvaAzy
	 Av/PjMEKjuEYbM0ThtE04yKXMjEzQyHbLIf0v6W4g6Cs1kog/ZtaFj1rLDqcP8EU/h
	 dnimeoOuJT1aNQXi9P7NyRvSTvPNtoa0B9y1m3D9cx37DRICtbTZg6f6nk4YCzcex/
	 oWWrwdX6iZ0hW63LtdVPVKhtT87sCsrrHmciWynV4qCI00HKk7TMCuAWdDECl+yYTV
	 Ba4STfOufVZNQ==
Message-ID: <6f097ce3-5a0b-4d58-bd48-6b2ed135747f@kernel.org>
Date: Wed, 26 Feb 2025 09:45:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: add ftruncate command in f2fs_io
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250226002707.358601-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250226002707.358601-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 08:27, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> add ftruncate command to do file truncate.

Need to update manual of f2fs_io as well?

Thanks,

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  tools/f2fs_io/f2fs_io.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index fa01f8f..08056a9 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -1887,6 +1887,31 @@ static void do_get_advise(int argc, char **argv, const struct cmd_desc *cmd)
>  	printf("\n");
>  }
>  
> +#define ftruncate_desc "ftruncate a file"
> +#define ftruncate_help					\
> +"f2fs_io ftruncate [length] [file_path]\n\n"	\
> +"Do ftruncate a file in file_path with the length\n"	\
> +
> +static void do_ftruncate(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	int fd, ret;
> +	off_t length;
> +
> +	if (argc != 3) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	length = atoll(argv[1]);
> +	fd = xopen(argv[2], O_WRONLY, 0);
> +
> +	ret = ftruncate(fd, length);
> +	if (ret < 0)
> +		die_errno("ftruncate failed");
> +	exit(0);
> +}
> +
>  #define CMD_HIDDEN 	0x0001
>  #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
>  #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
> @@ -1932,6 +1957,7 @@ const struct cmd_desc cmd_list[] = {
>  	CMD(removexattr),
>  	CMD(lseek),
>  	CMD(get_advise),
> +	CMD(ftruncate),
>  	{ NULL, NULL, NULL, NULL, 0 }
>  };
>  


