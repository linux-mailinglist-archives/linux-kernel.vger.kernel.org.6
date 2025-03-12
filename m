Return-Path: <linux-kernel+bounces-558308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1CA5E429
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF25189E13D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BAF257ACA;
	Wed, 12 Mar 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="JjcHXgAs"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA631E5B71;
	Wed, 12 Mar 2025 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806641; cv=none; b=WPYGhjoJ0hsaiUB+TQgjzeN8+5IEueoZPofGQ+V2OgNT30+xGCSsnwnl24p51MD4+HU0UGkN9PdNPMnrCgcQuplwrXuc46nRYyN3MCd+UWGYPcVH3aVymu3nFc2CgpUHnbSgHNoxyg5oobw6hCBsp5aGttTiQlVCm8kOPOojtq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806641; c=relaxed/simple;
	bh=cgz5IX7ed0DoG9H5f0utfDXpJpyil9n5ltI04DxyhYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tak9o6JhPLAsdgXpHyvRwkeL9jRhXmbkHHb0XwXHIDILyQDU2tnTULSi3oQw+hQgAR4EJ2wYJGIF4wYhuS4I+hlBbMNvHhPTa07hF9lLIKzxpcMujQZpJzBK+zAJFwBbgfzhSUXbO3Ss3ToDe0a5NYyvB576ewLIQkn+1ulI0jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=JjcHXgAs; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741806037; bh=kw9gU0TN7H6ODehbFr1G1DOlc7O7YIx4un9PjAtfgFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=JjcHXgAssXzEQsToknvoQvcASXiUCr1l1jWfYjjq5HFC3BXLb2fBdUaaY0pPOsSiC
	 +2jSPmKmphe4WW+OE8oH1Vy8YZZQNc6tANaytwJubDILtsED0VI1sQw8aHfFvTMFkJ
	 DFiA5q/Quxfg4uZCgVBWMk/+Ze7XA1Ay1jjWqs60=
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
Subject: Re: [PATCH v2 1/7] scripts: generate_rust_analyzer.py: add missing
 whitespace
In-Reply-To: <20250311-rust-analyzer-host-v2-1-30220e116511@gmail.com> (Tamir
	Duberstein's message of "Tue, 11 Mar 2025 21:17:22 -0400")
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
	<20250311-rust-analyzer-host-v2-1-30220e116511@gmail.com>
Date: Wed, 12 Mar 2025 20:00:36 +0100
Message-ID: <m2y0xaysyz.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Add a space before the `/` operator for consistency with surrounding
> code and code formatting tools. Add a second newline between top-level
> items in accordance with PEP 8[1]:
>
>> Surround top-level function and class definitions with two blank
> lines.
>
> This change was made by a code formatting tool.
>
> Link: https://peps.python.org/pep-0008/ [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index adae71544cbd..15a690ae2edb 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -103,7 +103,7 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>      ):
>          append_crate(
>              display_name,
> -            srctree / "rust"/ display_name / "lib.rs",
> +            srctree / "rust" / display_name / "lib.rs",
>              deps,
>              cfg=cfg,
>          )
> @@ -178,5 +178,6 @@ def main():
>  
>      json.dump(rust_project, sys.stdout, sort_keys=True, indent=4)
>  
> +
>  if __name__ == "__main__":
>      main()

