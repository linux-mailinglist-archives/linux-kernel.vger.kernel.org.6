Return-Path: <linux-kernel+bounces-439332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA429EADD1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705F2287FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475BF190685;
	Tue, 10 Dec 2024 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="tCjew8Fl"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB023DEB5;
	Tue, 10 Dec 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825930; cv=none; b=bQ9P00Q6vTqXYdY4yOKA0HH6LZ/A6y2i+SemXAq82OIizSoy/+GSRX8poLmzcDUUAD8wvboer+lNInhIEBpk1d8f5W04XGngRcLLpBMZ6s0XkQ5ILx5CqRQWBBYVsNKHHuUDdtgEFYSSO1cEOF1wUvZeGNlMmJ7mHkuFkJlkHMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825930; c=relaxed/simple;
	bh=Nj05O/ueN/PMCm5p4N1zDixMdHIiDU9Yqel2bHGFdQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WBRnNJADJO05k9h23wUr7gD84H17DV+xChSbhcnZF3pDSvYxPwRz1OnmGCbpdp5uVxKVkITwP7nO45/Uq0fU/xzG0OWazimzu6iUKT+GAxw0haNuQ44jqIDSjDQIRI8CZcB2LZLFlphm3nys753JfRNvKil7zgQCTbSBsQ9JTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=tCjew8Fl; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1733825925; bh=znw9RaPDGdZv374XX1ZIqQi1J1m6y/QWq9gDvavyvQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=tCjew8FlvciVZ73tkgrEjFvkxLIG2ETPTuX2yUH6sOfN9PSvC/Tj9w/ZjDjk7QETX
	 eFXJZTRjtazxAW6uSvCx1t6pspw3r7pCn2C9ufb13O6B8PagnPxSEm081u5WfaRxbr
	 InakM2F118yzlooG9tYTT1g/rsaFukzUYyXlHNmY=
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: document `bindgen` 0.71.0 regression
Date: Tue, 10 Dec 2024 11:18:44 +0100
Message-ID: <AE7176FF-D196-4199-AA8C-B16FBC31B417@kloenk.dev>
In-Reply-To: <20241209212544.1977065-1-ojeda@kernel.org>
References: <20241209212544.1977065-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 9 Dec 2024, at 22:25, Miguel Ojeda wrote:

> `bindgen` 0.71.0 regressed [1] on the "`--version` requires header"
> issue which appared in 0.69.0 first [2] and was fixed in 0.69.1. It has=

> been fixed again in 0.71.1 [3].
>
> Thus document it so that, when we upgrade the minimum past 0.69.0 in th=
e
> future, we do not forget that we cannot remove the workaround until we
> arrive at 0.71.1 at least.
>
> Link: https://github.com/rust-lang/rust-bindgen/issues/3039 [1]
> Link: https://github.com/rust-lang/rust-bindgen/issues/2677 [2]
> Link: https://github.com/rust-lang/rust-bindgen/blob/main/CHANGELOG.md#=
v0711-2024-12-09 [3]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  init/Kconfig                 | 6 ++++--
>  scripts/rust_is_available.sh | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/init/Kconfig b/init/Kconfig
> index a20e6efd3f0f..e8d2b5128f87 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1989,8 +1989,10 @@ config BINDGEN_VERSION_TEXT
>  	string
>  	depends on RUST
>  	# The dummy parameter `workaround-for-0.69.0` is required to support =
0.69.0
> -	# (https://github.com/rust-lang/rust-bindgen/pull/2678). It can be re=
moved when
> -	# the minimum version is upgraded past that (0.69.1 already fixed the=
 issue).
> +	# (https://github.com/rust-lang/rust-bindgen/pull/2678) and 0.71.0
> +	# (https://github.com/rust-lang/rust-bindgen/pull/3040). It can be re=
moved
> +	# when the minimum version is upgraded past the latter (0.69.1 and 0.=
71.1
> +	# both fixed the issue).
>  	default "$(shell,$(BINDGEN) --version workaround-for-0.69.0 2>/dev/nu=
ll)"
>
>  #
> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.s=
h
> index 93c0ef7fb3fb..d2323de0692c 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -123,8 +123,10 @@ fi
>  # Non-stable and distributions' versions may have a version suffix, e.=
g. `-dev`.
>  #
>  # The dummy parameter `workaround-for-0.69.0` is required to support 0=
=2E69.0
> -# (https://github.com/rust-lang/rust-bindgen/pull/2678). It can be rem=
oved when
> -# the minimum version is upgraded past that (0.69.1 already fixed the =
issue).
> +# (https://github.com/rust-lang/rust-bindgen/pull/2678) and 0.71.0
> +# (https://github.com/rust-lang/rust-bindgen/pull/3040). It can be rem=
oved when
> +# the minimum version is upgraded past the latter (0.69.1 and 0.71.1 b=
oth fixed
> +# the issue).
>  rust_bindings_generator_output=3D$( \
>  	LC_ALL=3DC "$BINDGEN" --version workaround-for-0.69.0 2>/dev/null
>  ) || rust_bindings_generator_code=3D$?
>
> base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
> -- =

> 2.47.1

