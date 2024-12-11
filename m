Return-Path: <linux-kernel+bounces-440988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FE9EC780
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DDEA281508
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A6B1DC99A;
	Wed, 11 Dec 2024 08:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm8GQBRy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A331BD4E4;
	Wed, 11 Dec 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906516; cv=none; b=b4jqviexZpSifzOa6wO8ZWHndF8XbdDk2hv03sej+AayjD+csb9H5y1FvFFqHYQAbfwB5FvPLUph/12sRKSxyHkskBTkk/bXIetGPdMd/YwU2nZHQC6xXBJkRlj+H1yOOoRXwlm4Um26trc8Ns5K20/40idaGh36J8ijPVKkPDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906516; c=relaxed/simple;
	bh=11k4EF5OtV96AkBGLTd+hH0qKo61NlPe3GiJ6SKgOkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XyGMluO+xu4uB2eIZWwgBTvOIgWn6PBcYDf4LsbPLmH3QwHXFNdMOB0XEf5URR/qiUHoVKDoQffEAcMdtHJjUzhWJqlYeyi8k/W/Tbq5s0ikx+8eNtYx84+Lzr4gzZ9b3YSimURK/uwfL1ScD2faVN+jRY6sxblRc0yfD8Rn17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm8GQBRy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40FFAC4CEE1;
	Wed, 11 Dec 2024 08:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733906516;
	bh=11k4EF5OtV96AkBGLTd+hH0qKo61NlPe3GiJ6SKgOkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pm8GQBRyxvJBdkrJvB5xqnkaQDK3pQH87o2d08mKRohKRhHeZREIXkL0k4nqUt2cm
	 hPk5xQc3DdC83EUlt0uuVyRLixOlSM/eq/88PsXvN7dVJqm/xljHvKMIBC1C/gFBHQ
	 P8aJVl5g1ko3s6+ndoUJmGaN+L+ce0g8sKQS3+1C6YhCPXYds31oE4aUehqq1aqt3U
	 rq15OYEnt6oohrzKUah8SL1L/YUO6y2qYlI1J5WAyK9LQzlpbzO/tP8WJBI/FgEn3F
	 ndJ1ytAS7pYHzrUy+wcnCubZp+bJEiXgPYiWJqv5+94lJqn7J9A9Qwoszdch4dNaPq
	 LIrJbvVowJqtg==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so955746466b.3;
        Wed, 11 Dec 2024 00:41:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrmH5PyNGAUJ9E7Q1hffraD3d4d1cVxZE1h/2x3P2P/oSDQe747wKKxtq5wGKfYjTP3TdVXMN2M44lL7KMbA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBCv8+90s21HZREtXLDY5yqNAWHl6R1OCent4yI9Pa94RjyyM
	MELYxmp4s1g8YYzf1L9a0US7+o6AHTRCvhE/2XB8yyh/Fcs78xn3WeZKr0Ri1NrCU0UlXH7TjiX
	+VpoV9OtYIgJDDlQdmIK7bmoruLg=
X-Google-Smtp-Source: AGHT+IGBqIIVL8M8gd1swf2r/NXYFCJNyY0lS3KZFrZ3efUdXDZaZlzPpq5HkoxLe8d8jwzVBsIy563EXgXKfOfsJeo=
X-Received: by 2002:a05:6402:2105:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d43316510amr4128041a12.32.1733906514580; Wed, 11 Dec 2024
 00:41:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210001802.228725-1-fujita.tomonori@gmail.com> <20241210001802.228725-5-fujita.tomonori@gmail.com>
In-Reply-To: <20241210001802.228725-5-fujita.tomonori@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 11 Dec 2024 16:41:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7BxE7xeA982Pr4PFxgfNpgXs6H4OZ2LydmYAtYjvYNaw@mail.gmail.com>
Message-ID: <CAAhV-H7BxE7xeA982Pr4PFxgfNpgXs6H4OZ2LydmYAtYjvYNaw@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] loongarch/bug: Add ARCH_WARN_ASM macro for
 BUG/WARN asm code sharing with Rust
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	x86@kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, peterz@infradead.org, hpa@zytor.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	catalin.marinas@arm.com, will@kernel.org, kernel@xen0n.name, 
	tangyouling@loongson.cn, hejinyang@loongson.cn, yangtiezhu@loongson.cn, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, FUJITA,

On Tue, Dec 10, 2024 at 8:19=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add new ARCH_WARN_ASM macro for BUG/WARN assembly code sharing with
> Rust to avoid the duplication.
>
> No functional changes.
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  arch/loongarch/include/asm/bug.h | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/as=
m/bug.h
> index 08388876ade4..2343c4226595 100644
> --- a/arch/loongarch/include/asm/bug.h
> +++ b/arch/loongarch/include/asm/bug.h
> @@ -21,14 +21,21 @@
>  #ifndef CONFIG_GENERIC_BUG
>  #define __BUG_ENTRY(flags)
>  #else
> -#define __BUG_ENTRY(flags)                                     \
> +
> +#define __BUG_ENTRY_START                                      \
>                 .pushsection __bug_table, "aw";                 \
>                 .align 2;                                       \
>         10000:  .long 10001f - .;                               \
> -               _BUGVERBOSE_LOCATION(__FILE__, __LINE__)        \
> -               .short flags;                                   \
> +
> +#define __BUG_ENTRY_END                                                \
>                 .popsection;                                    \
>         10001:
> +
> +#define __BUG_ENTRY(flags)                                     \
> +               __BUG_ENTRY_START                       \
> +               _BUGVERBOSE_LOCATION(__FILE__, __LINE__)        \
> +               .short flags;                                   \
> +               __BUG_ENTRY_END
>  #endif
>
>  #define ASM_BUG_FLAGS(flags)                                   \
> @@ -55,6 +62,24 @@ do {                                                  =
       \
>         unreachable();                                          \
>  } while (0)
>
> +#ifdef CONFIG_DEBUG_BUGVERBOSE
> +#define __BUG_LOCATION_STRING(file, line)              \
> +               ".long " file "- .;"                    \
> +               ".short " line ";"
> +#else
> +#define __BUG_LOCATION_STRING(_file, _line)
> +#endif
Can we use file and line instead of _file and _line, which is the same
as the CONFIG_DEBUG_BUGVERBOSE case?

> +
> +#define __BUG_ENTRY_STRING(file, line, flags)          \
> +               __stringify(__BUG_ENTRY_START)          \
> +               __BUG_LOCATION_STRING(file, line)       \
> +               ".short " flags ";"                     \
> +               __stringify(__BUG_ENTRY_END)
> +
> +#define ARCH_WARN_ASM(file, line, flags, size)         \
> +       __BUG_ENTRY_STRING(file, line, flags)           \
> +       __stringify(break BRK_BUG) ";"
> +
Can we use the same indentation in this file?

Huacai

>  #define HAVE_ARCH_BUG
>
>  #include <asm-generic/bug.h>
> --
> 2.43.0
>

