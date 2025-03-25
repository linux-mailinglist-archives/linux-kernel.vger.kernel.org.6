Return-Path: <linux-kernel+bounces-575810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6BA7076C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 17:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E02ED1887299
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351325F7A7;
	Tue, 25 Mar 2025 16:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="bXsHHn5G"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570018024;
	Tue, 25 Mar 2025 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921617; cv=none; b=Lk7JXQ11VblGMP4Ha2+4oJfvV8n/x4N0ypCoVlLOsXFrJSqWVVsXqgg3zsYRhhW5v5R17wE50NMFBorgSE6rL6JZAaACEm5myDVo28ev/5B+ozmhzZouljvIKqNhUos2hH4pUQAMBxOUaPWFn8WHx5HG61N0+yydN+WEiPunOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921617; c=relaxed/simple;
	bh=hMu3F5A7E/FLhFE8qjTp9Dh+g3WdfFy2lRyHYPslvNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M3m3s8ZuwmjDszMAkfSpxJHoPI2YUhQdNbQLenYB/Q+jpaXANzJ3MSjZaXpzjdI6PEv7C6XRFiv9gQMcCwrxYEAaSzb65h9DJZIozl0gaGZiXuXBxdfgPtY0h8czQvHazHEZWFk/2p3IKVi26vFedMFTXtjMt6Tbw/8uQoilDNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=bXsHHn5G; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1742921613; bh=Q+vkSXKuCmtJtcgUm7TN9k3tjPef1FkD3IqpkOhHcFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bXsHHn5GrXq8/Mea6U7PvoW4lbMK+P/2JmaIJy7vR03420umLU1XUZLk+5yok/N2n
	 iE6kOomwvHRdxl4BDfjDspUlla1BfJ2aHR196MW8Ukmnqu3UrzRf/Oo4JWZKJwZCtJ
	 rAkuRvTfZ7UAExg1xLV0nZ6kCoSiccXjXDrfzXpY=
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin
 <benno.lossin@proton.me>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Alice Ryhl <aliceryhl@google.com>,  Trevor Gross <tmgross@umich.edu>,
  Danilo Krummrich <dakr@kernel.org>,  Boris-Chengbiao Zhou
 <bobo1239@web.de>,  Kees Cook <kees@kernel.org>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,  Lukas
 Wirth <lukas.wirth@ferrous-systems.com>
Subject: Re: [PATCH v4 10/11] scripts: generate_rust_analyzer.py: define
 scripts
In-Reply-To: <20250322-rust-analyzer-host-v4-10-1f51f9c907eb@gmail.com> (Tamir
	Duberstein's message of "Sat, 22 Mar 2025 09:23:45 -0400")
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
	<20250322-rust-analyzer-host-v4-10-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 17:53:32 +0100
Message-ID: <m27c4d9hmb.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Generate rust-project.json entries for scripts written in Rust. This is
> possible now that we have a definition for `std` built for the host.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index ccb15aa66929..957b413fe0b6 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -209,6 +209,19 @@ def generate_crates(
>      uapi = append_crate_with_generated("uapi", [core])
>      kernel = append_crate_with_generated("kernel", [core, macros, build_error, bindings, pin_init, uapi])
>  
> +    scripts = srctree / "scripts"
> +    with open(scripts / "Makefile") as f:
> +        makefile = f.read()
> +    for path in scripts.glob("*.rs"):
> +        name = path.name.replace(".rs", "")
> +        if f"{name}-rust" not in makefile:
> +            continue
> +        _script = append_crate(
> +            name,
> +            path,
> +            [host_std],
> +        )
> +
>      def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
>          try:
>              with open(build_file) as f:

