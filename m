Return-Path: <linux-kernel+bounces-277487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B44394A207
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F561F22505
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDB21C9DD1;
	Wed,  7 Aug 2024 07:52:25 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173C1B86DC;
	Wed,  7 Aug 2024 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017144; cv=none; b=kDn3LJCF75RozRBr4nvgJgxju5+Dp0ztiwfdLEp9DY8jXh4pfOad7vzRb+/jBL1nMzPQNPyc447TedVYlZnmRGvw3C+Npnezwyst7IRpwFA9CSCO2WEcJxPkbHk3T1lxK18Z4W8aaAtvMiVH+1mTJYW+DdPWHXMk76cs2A6Guxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017144; c=relaxed/simple;
	bh=P029QhQ2IpIBwTacFgAJzLKzDEjmjM1NRKAZUDdvcVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gb2wD9i32bgu3Vy91XdpmeOUrih6R8Jkdf1YFak7qIL6IIfenFSR5E9iE705+geTf2UHIpdmBcqFLJZ8rpt9hjt3YruKtjZ3fjlO8gPij45gzYvlLjgdzf5MjcmW2BPivRcAcS3tZfacynmo9E5od2XnGN+8LBbXwwPV5eBN5v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4f51c1f9372so507493e0c.2;
        Wed, 07 Aug 2024 00:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723017142; x=1723621942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W3xrNS8iZyZhkOmyAcGNIqP3+/HlN9P6GP8Q91kZLyY=;
        b=BmeX/GTk61n0nSolPXdWoWQXPtrZ4s14CB143uadFrsX3WD9g8+A12TqE/mhdddQ6a
         jbLF/4TkiF7MgV1D6dj0gmZyggCBOTcKcSOJqA8vuzbwYrqjb8Yg2xiKfuTmKT7NH1gX
         XoQ+r+80VL7dC2Ure1GSIK0B0aDkNXj8G1nI9PZYj5FjcmXpif13xEszuNItvMFl8yBc
         MXHN3K9wnNVJ+5NocMbb1ykKFp9ss8OaWUZ1oilOcOT4GgGRyJJG34ehWUL6YhQE3ptZ
         ZD/Pxbuf3xnrtH6T5dgofUf6OR/fHfFIX0fcQ2DlXJotIVWp5RlWsw8xW/nd86eWMsyi
         /eqw==
X-Forwarded-Encrypted: i=1; AJvYcCUo+bbl1d300F4OccSnk8T3fPdPf9BYBkIfu+LUeHn+wR5zLAjpTFU++8xqcOFbqAadYsZ77U8neVbCTngda7T7IAj7H6i8LtckD0RzJOXVwnrRQf5wZBBysvw6BXECnPLRL33n6CUwUrd42TU=
X-Gm-Message-State: AOJu0YwN7y7TkHvt8HzJNBi9zZi6RdeojVN3aKA7yGLL4QEJyqdpqLPD
	btEdSJX9ykW9fymsaQmbXEaqmipEBYcjx/vC5FFWkbMFST4znkG9
X-Google-Smtp-Source: AGHT+IE33uVgVa+VXy9gIqtrgXxspqlIEekyIkajG8XB5P3gG8JKv9KHLMssfYHzag8pRj248sYXPw==
X-Received: by 2002:a05:6122:1699:b0:4f6:b610:61bf with SMTP id 71dfb90a1353d-4f89ff88eafmr19464410e0c.8.1723017141625;
        Wed, 07 Aug 2024 00:52:21 -0700 (PDT)
Received: from skuld-framework.localnet ([32.221.37.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e0798sm36500385a.44.2024.08.07.00.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 00:52:21 -0700 (PDT)
From: Neal Gompa <neal@gompa.dev>
To: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 Zehui Xu <zehuixu@whu.edu.cn>
Cc: boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 zehuixu@whu.edu.cn
Subject:
 Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
Date: Wed, 07 Aug 2024 03:52:20 -0400
Message-ID: <3695674.9o76ZdvQCi@skuld-framework>
In-Reply-To: <20240731134346.10630-1-zehuixu@whu.edu.cn>
References: <20240731134346.10630-1-zehuixu@whu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Wednesday, July 31, 2024 9:43:46=E2=80=AFAM EDT Zehui Xu wrote:
> GCC 14 recently added -fmin-function-alignment option and the
> root Makefile uses it to replace -falign-functions when available.
> However, this flag can cause issues when passed to the Rust
> Makefile and affect the bindgen process. Bindgen relies on
> libclang to parse C code, and currently does not support the
> -fmin-function-alignment flag, leading to compilation failures
> when GCC 14 is used.
>=20
> This patch addresses the issue by adding -fmin-function-alignment
> to the bindgen_skip_c_flags in rust/Makefile. This prevents the
> flag from causing compilation issues.
>=20
> Link:
> https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pavlu@su=
se
> .com/ Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>
> ---
> Since -falign-functions does not affect bindgen output, we do not
> need logic to add it back to the flags. Thanks to the community's
> help, especially Miguel Ojeda. Hope this patch is free of problems
> and can be submitted smoothly : )
>=20
> v1:
> * https://lore.kernel.org/all/20240730222053.37066-1-zehuixu@whu.edu.cn/
>=20
> v2:
> * Added -falign-functions to bindgen_extra_c_flags when skipping
>   -fmin-function-alignment to maintain function alignment settings in GCC=
 14
> * Used reasonable length and moved email content out of the commit message
> * Used "Link" tag instead of "Reference:" and removed empty lines between
> tags * Specified the base commit
> * https://lore.kernel.org/all/20240731034112.6060-1-zehuixu@whu.edu.cn/
>=20
> v3:
> * Removed logic from patch v2 which adds -falign-functions
>=20
>  rust/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/rust/Makefile b/rust/Makefile
> index 1f10f92737f2..0c8736cce64f 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -227,7 +227,7 @@ bindgen_skip_c_flags :=3D -mno-fp-ret-in-387
> -mpreferred-stack-boundary=3D% \ -fno-reorder-blocks
> -fno-allow-store-data-races -fasan-shadow-offset=3D% \
> -fzero-call-used-regs=3D% -fno-stack-clash-protection \
>  	-fno-inline-functions-called-once -fsanitize=3Dbounds-strict \
> -	-fstrict-flex-arrays=3D% \
> +	-fstrict-flex-arrays=3D% -fmin-function-alignment=3D% \
>  	--param=3D% --param asan-%
>=20
>  # Derived from `scripts/Makefile.clang`.
>=20
> base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b

Looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>

=2D-=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!



