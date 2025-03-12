Return-Path: <linux-kernel+bounces-558297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33784A5E40C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C507A6414
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 19:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A808B1E5B9B;
	Wed, 12 Mar 2025 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b="FkClq/1y"
Received: from gimli.kloenk.de (gimli.kloenk.de [49.12.72.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450DE136A;
	Wed, 12 Mar 2025 19:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.72.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741806095; cv=none; b=now+2fCpwsn7JQrH9Gqbythd0VbmLn6sTwop0GXGbOeytLdgJrNcoRta1HMlUrH2BBSiSq5SXhh/fAo8LB/esxzYH8RMDsUa8zpupq0MzJPgKjlwlk+NVvFp+/ws3hOhasiIVlT3xG5pUzK0uLdWUw1CPwts908RlxcH/bYTVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741806095; c=relaxed/simple;
	bh=30l8lq6eB9bod7X4i2Uw5D8EdUusPueNQDtwVh6sMb0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sNS5/w2QlupbpDVFpdxpO2JI2L55P7BsO8bXVXvok6H4iXCGxZ1x95OFiMwt3NeYUlUiD3MnnPjz3v4ounjuoWXGzC9D2Ftb2q63pFWvkFdMjDb7vhC8MB5edS0MfVXJRDA3y2NUsy/A6Iz7ec6VJl3ZKnrEHHgVUbyKnzDDy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev; spf=pass smtp.mailfrom=kloenk.dev; dkim=pass (1024-bit key) header.d=kloenk.dev header.i=@kloenk.dev header.b=FkClq/1y; arc=none smtp.client-ip=49.12.72.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kloenk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kloenk.dev
From: Fiona Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
	t=1741806089; bh=rXufB16FegYHHVIU9HEQZe4NiqIgHNl/BsLSg1Fm43c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=FkClq/1yk9t2WbMNSqwkhFJoOiXU9mgx6zYppJnXzvxUE8rMaExLYOyQ10FqHw3v5
	 XpSFDajn9WAy30j6nN1dy40KHGWGUCP4cV9zSK8IdnM8C2MDdO3LLU/SlvepwbvSyH
	 OpRCx8FBsLlCOv+W6h2/sEBF5i51HsLRBw3rDtks=
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
Subject: Re: [PATCH v2 2/7] scripts: generate_rust_analyzer.py: use double
 quotes
In-Reply-To: <20250311-rust-analyzer-host-v2-2-30220e116511@gmail.com> (Tamir
	Duberstein's message of "Tue, 11 Mar 2025 21:17:23 -0400")
References: <20250311-rust-analyzer-host-v2-0-30220e116511@gmail.com>
	<20250311-rust-analyzer-host-v2-2-30220e116511@gmail.com>
Date: Wed, 12 Mar 2025 20:01:28 +0100
Message-ID: <m2seniysxj.fsf@kloenk.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> Replace inconsistent use of single quotes with double quotes.
>
> This change was made by a code formatting tool.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Fiona Behrens <me@kloenk.dev>

> ---
>  scripts/generate_rust_analyzer.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/generate_rust_analyzer.py b/scripts/generate_rust_analyzer.py
> index 15a690ae2edb..5913934ecb5a 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -154,8 +154,8 @@ def generate_crates(srctree, objtree, sysroot_src, external_src, cfgs):
>  
>  def main():
>      parser = argparse.ArgumentParser()
> -    parser.add_argument('--verbose', '-v', action='store_true')
> -    parser.add_argument('--cfgs', action='append', default=[])
> +    parser.add_argument("--verbose", "-v", action="store_true")
> +    parser.add_argument("--cfgs", action="append", default=[])
>      parser.add_argument("srctree", type=pathlib.Path)
>      parser.add_argument("objtree", type=pathlib.Path)
>      parser.add_argument("sysroot", type=pathlib.Path)

