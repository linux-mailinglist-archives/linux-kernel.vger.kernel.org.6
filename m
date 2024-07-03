Return-Path: <linux-kernel+bounces-239931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74659266F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E899F1C21860
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C3185084;
	Wed,  3 Jul 2024 17:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="T17HPMPY"
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE418309B;
	Wed,  3 Jul 2024 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720027261; cv=none; b=jDWEdfv7pypxUIKtwQVPFfR4vwpXRdM9slAlCs68CP2TAPQ7+PdrrTs0N/sFd6TvWMQ68aVR98ZHmF5UetqDP3cbIS3L/O3BjorZvn13tmlK1xHsJgt3AEOa8HW23pRPX6fvyV0CVyvUPcnrOqVa7t1xs7nbTntI6Kxsjc/o5fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720027261; c=relaxed/simple;
	bh=PMZ8fXfFqcesgh4os0cEpNSLQicO4IEGRrW58SumQa8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=AIHPBGQL0C17+3I0FdhB+SvNxvOE0LpV2b85c3m9fESPTrmPopj7hjF/w909ELCxKbfuq8kAGaWcs+aQnoeQ9IdEQz000H9HfFoQb/C2w4Z36O1DmO08B6/qyheshNUfoyvnMcLNqpVfxrxTLjYF3VR2WSVNpJLxp7Hr6ESifTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=T17HPMPY; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720027243; x=1720286443;
	bh=ndDGJ5uXrO4sGpkfcf5wznWFZi4Q7sy1VDuTcL5Kfro=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T17HPMPYGDYS9yM7ZcV0UBuiTcwJVUuq7V6Juxt/NEvEJQW29YcPTdfs+oKQ6jt+2
	 1zA7jrKPpg2Ig+P+YyRMIkexstlNFnXJ/5D95ENZhLQQOr17yKj33RTbpK2N4aTt6F
	 q9PUCdp04UKuCcwbLurE0Q3ym1JaRlSqTAInXDaCrqHWEZzKiG63A8UIuJVlkBm9au
	 DH7DhmvuNHbfoeZ2yCNAtuyJrEgVyLffU/4P0XDhypEm8npkFxri336xC8hV0M3B0i
	 78Ex0hFUm8+MMEhg1CwECLvGSOFDNrd4aW+pfPqDzIpU9sT7wCKK3jctuaIRXIalza
	 q3ZKg9uiD+pBg==
Date: Wed, 03 Jul 2024 17:20:37 +0000
To: Miguel Ojeda <ojeda@kernel.org>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, patches@lists.linux.dev, Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 06/13] rust: start supporting several compiler versions
Message-ID: <87ed8a8ka3.fsf@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: cb700748314eafeccfd6719d4fa10cbf2e19f93c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miguel Ojeda <ojeda@kernel.org> writes:

[...]

> diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
> index 117018946b57..67cb900124cc 100755
> --- a/scripts/rust_is_available.sh
> +++ b/scripts/rust_is_available.sh
> @@ -117,14 +117,6 @@ if [ "$rust_compiler_cversion" -lt "$rust_compiler_m=
in_cversion" ]; then
>  =09echo >&2 "***"
>  =09exit 1
>  fi
> -if [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
> -=09echo >&2 "***"
> -=09echo >&2 "*** Rust compiler '$RUSTC' is too new. This may or may not =
work."
> -=09echo >&2 "***   Your version:     $rust_compiler_version"
> -=09echo >&2 "***   Expected version: $rust_compiler_min_version"
> -=09echo >&2 "***"
> -=09warning=3D1
> -fi

This does not set a max version. Will older versions of the kernel
always compile with newer releases of `rustc`?

Best regards,
Andreas


