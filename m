Return-Path: <linux-kernel+bounces-226308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C30913CCF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E8B1F22823
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 16:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0021183071;
	Sun, 23 Jun 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJ3BBpuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4F427453;
	Sun, 23 Jun 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161016; cv=none; b=jFMeTDv5WGapNxDA4IDoBregLVyMSiOjZmTERxxPCpCJ5MtIVc8K26SvDnmK7I9eJjC28E9EbgNQO96CBSc2Qh5cyDyrsPogyy4sqFRUSWJUM3OPxXry7iTcZiX86YrFWCnuoR4Vr2npV5z5Cb4w+ex6+7gT3vNskp+F2CHww6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161016; c=relaxed/simple;
	bh=ntGbqQqM/+qtXCnzfR8Q9obaGlgLQHB3JfTRiNnDXWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uY/CVDbjNrHrimECKDHRUFFHtx/OKS8LcjgzTLHnaCqZptMH7+pzKoXCgWZtQRrhYOZhBxJGNvKrixawhBGmwkWsBlcp/S7WBNki61mWvi5AddLDvJ+tmVAoM8KDaNkNJ1AKIVqHzA6MfUyhXUAC9UIlqywB6OkM3uzD0BJGB4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJ3BBpuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A3EC32781;
	Sun, 23 Jun 2024 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719161015;
	bh=ntGbqQqM/+qtXCnzfR8Q9obaGlgLQHB3JfTRiNnDXWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aJ3BBpuLN//E3rEkuNOzmwk+vfzm8WbSWgxlwzjQsFieO+BNIwOL5JQoF6NEzJyZm
	 VfgFcodnPOZhP7XqM8voCJGFt5NuE295vgMzs0RcfanB7DVcc17YvCSn6SoYzK5fdT
	 XBxov4KJlypAR11spLzipT63pe9l13UqNBwEY+K8fqipZD5U97mr9YoBb/UVKxNOvB
	 tq2OJhxCb1QsvexHxVfuu2HHfv883UBS1B4SG96rOE4vheBKVAj2xEScQYKL0uoR+c
	 UZfgo0a3ZI8os2jt9lCEogOOXEH1+sCQY2C5YVlEKTNTWGAdjVmB7XhTYG8ZSBkt7/
	 fXSNPzP+ALw2g==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cd26347d3so3691775a12.1;
        Sun, 23 Jun 2024 09:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6Ww7KKPOFNfVJbaDvoCG4RhIS22g2z4TeBBFYfCQKaWEN7tFZCr+fvpPuTpxV67ZFaJs/QQz6XJqkr2ZcAjWlgOsJeyfMW5b4BJi8aM0q6LLCn768EFltm6YTQOn4rJ5MdJwFBl4WXQ==
X-Gm-Message-State: AOJu0YzxmointwW8ZmnNxo/7Dh0xi87MUcVsOTOp/Mbhw25CvfUOGPye
	Jjh3F3pmF4hgQ1SANNCHfXVqSV0elFyOEX83h671lHbNh9WqZne2iqzp8/ad/VN7J9EeClAh5s7
	LVvM9X3U8B7YSIpC2yp5pfPeqkLs=
X-Google-Smtp-Source: AGHT+IHnTMEtgbHt3R0Y3l+fIKdz6ft1LcaDn9E2vGPhEdYX65CkmoUTe7bp8E7J1WPN2qsgoV9cGeGTGI8kmVSzLbE=
X-Received: by 2002:a50:d619:0:b0:57c:bd49:9969 with SMTP id
 4fb4d7f45d1cf-57d4bde2850mr1629042a12.39.1719161014181; Sun, 23 Jun 2024
 09:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619073140.48817-1-puranjay@kernel.org>
In-Reply-To: <20240619073140.48817-1-puranjay@kernel.org>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 24 Jun 2024 00:43:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRiHV0VmMd7uJHBDut5VeGbwXTr2c18wK-fH4_HZp_GUA@mail.gmail.com>
Message-ID: <CAJF2gTRiHV0VmMd7uJHBDut5VeGbwXTr2c18wK-fH4_HZp_GUA@mail.gmail.com>
Subject: Re: [PATCH] csky: stacktrace: fix usage of ftrace_graph_ret_addr()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-csky@vger.kernel.org, 
	linux-kernel@vger.kernel.org, puranjay12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 3:31=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> ftrace_graph_ret_addr() now returns the passed in return address when NUL=
L
> is passed for the 'idx' paramenter. This breaks the current usage in csky=
's
> walk_stackframe()
>
> Fix this by passing a valid integer pointer to ftrace_graph_ret_addr()
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
LGTM, Thx!

Reviewed-by: Guo Ren <guoren@kernel.org>

> ---
>  arch/csky/kernel/stacktrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/csky/kernel/stacktrace.c b/arch/csky/kernel/stacktrace.=
c
> index 27ecd63e321b..1d72f18064c2 100644
> --- a/arch/csky/kernel/stacktrace.c
> +++ b/arch/csky/kernel/stacktrace.c
> @@ -17,6 +17,7 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>                              bool (*fn)(unsigned long, void *), void *arg=
)
>  {
>         unsigned long fp, sp, pc;
> +       int graph_idx =3D 0;
>
>         if (regs) {
>                 fp =3D frame_pointer(regs);
> @@ -50,7 +51,7 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>                 frame =3D (struct stackframe *)fp;
>                 sp =3D fp;
>                 fp =3D frame->fp;
> -               pc =3D ftrace_graph_ret_addr(current, NULL, frame->ra,
> +               pc =3D ftrace_graph_ret_addr(current, &graph_idx, frame->=
ra,
>                                            (unsigned long *)(fp - 8));
>         }
>  }
> --
> 2.40.1
>


--=20
Best Regards
 Guo Ren

