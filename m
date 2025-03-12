Return-Path: <linux-kernel+bounces-558298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EF4A5E40D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 406AE3A2E99
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB376205ADB;
	Wed, 12 Mar 2025 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="mH1Hvzg5"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D00136A;
	Wed, 12 Mar 2025 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806135; cv=none; b=iUHekO4nJZz2n7ghplze4e811i9tPliShdFVToB7ON2RsxJPBG7VMiFIV+uQfBC198FmT3XJ5Wl9lTymAyn/2P69Jvj6ScBMMc6eTlIZgrb5ocNrQ+UpofbDLd9v9/c7CLk7SoXKUmRvq7ddfE/8ZQXElkGh8gm4eQ6Ww1VhGbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806135; c=relaxed/simple;
	bh=KW6iKJ7xNhx+CJQLQSYGA8zO0QnahR4/cFe5+W3k4PM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tAgEjwSETKhAg+8ZO/lDVM+JcRmDU9dw4uVymBXS9aILPKL8v+CVPc5huYQkWiue0lCXM8tZm8BPWT4tJdnAE7eiQnSXM/87jpzvUPlOvEZSPclchWw9FZb3TSZTeui0pkUY9IBKf3EZ3vmO+BtssbNc2eyUYASOvPwge8ljwwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=mH1Hvzg5; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741806131; bh=pcLic5GLSWXOPc5J6CdJ7jU9KVJV/KKijiJAWVQGXjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mH1Hvzg5mdtYuCJtHCyqBZzRalNazZ1eddi75SQk9fYbrI907Wy0w1KowTfCGr9LU
	 /LX5aWopUtwuMorDsd6WojwZ/zvWdhuBCwmAvshVRRoarfMiupYtaJ47Q6gamz9mVR
	 JWoqXIq7tXW505/4jmaVZsxwZzLwBVuB5L6q22z0=
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
Subject: Re: [PATCH v2 3/7] scripts: generate_rust_analyzer.py: add trailing
 comma
In-Reply-To: <20250311-rust-analyzer-host-v2-3-30220e116511@gmail.com> (Tamir
	Duberstein's message of "Tue, 11 Mar 2025 21:17:24 -0400")
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
	<20250311-rust-analyzer-host-v2-3-30220e116511@gmail.com>
Date: Wed, 12 Mar 2025 20:02:10 +0100
Message-ID: <m2msdqyswd.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Add missing trailing comma on multi-line function call as suggested by
> PEP-8:
>
>> The pattern is to put each value (etc.) on a line by itself, always
>> adding a trailing comma, and add the close parenthesis/bracket/brace
>> on the next line.
>
> This change was made by a code formatting tool.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index 5913934ecb5a..7e78b926e61f 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -165,7 +165,7 @@ def main():
>  
>      logging.basicConfig(
>          format="[%(asctime)s] [%(levelname)s] %(message)s",
> -        level=logging.INFO if args.verbose else logging.WARNING
> +        level=logging.INFO if args.verbose else logging.WARNING,
>      )
>  
>      # Making sure that the `sysroot` and `sysroot_src` belong to the same toolchain.

