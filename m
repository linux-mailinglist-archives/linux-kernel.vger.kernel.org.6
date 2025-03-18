Return-Path: <linux-kernel+bounces-566093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851DA6731B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB1E8808DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C860220C023;
	Tue, 18 Mar 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f339Wbiv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE920C00F;
	Tue, 18 Mar 2025 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298504; cv=none; b=Me32JozfkS1K3YyU19Ng/5zEg6+gW8Rsjx8WaGFHT1Etcj7Gd6QH8TBzkKh7M1B3VonRYsnZIvnSzLFzCF3df+DPVl12kwQtzuPhUaMx0ZzWYTUYlz9QmGTMJWvt0KVIA2uNPgFvWrrulz1X/kL5qFx9RcHSA6Wg71Mljo0kDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298504; c=relaxed/simple;
	bh=zpBIrT5lH650prElGXurisdp8T6cYPeD/QRL5valmUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FW+9mA42tHSPkpuMSct6rweVFu38rYl9WOwsmmQo7gmEBEEYgjnZOX6wLZc0Zc080oFJotDQ+De+93QL7QSGFn9R1le713elo6SzusqBMQ2xXfovFfmOtwwstzirWvvRHeTQosn2GNuurMtZLzzwrWss0/uhUVG+9wx9A0BHc+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f339Wbiv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9464C4CEEE;
	Tue, 18 Mar 2025 11:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742298504;
	bh=zpBIrT5lH650prElGXurisdp8T6cYPeD/QRL5valmUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=f339WbivjPeHdpmrEJ1q7hbDJ5qLeFXVjCRAe0saXyP0K1Oh2deb3fSPf4P06+VGp
	 Lw0A9WyunHb8p49ts/mqmfJPlEVdxsprozOpjq3IYJgLcS2DvwqeNGOswC1HGjrMdC
	 WwK+LyqSKNzH9CfoDGnLoqyhTP1XNTwNhIGFR/VvAStTNfr7aA3RSyvrtBqioR4fA4
	 EE0SHf2YF50uKFUoOyyNJy64iuwqQrTOIUihHhP4YK6E91ju69npzSLnTHGBNCRxdl
	 eyXg+lnYYt+H9b7VMkPvCKCzqU+9skLiXm5cAWGWtq/plFLKqtDGYh2AgH2x8y4OnG
	 fA5G2lJ6wIVYQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Fiona
 Behrens" <me@kloenk.dev>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/22] rust: pin-init: fix documentation links
In-Reply-To: <20250308110339.2997091-12-benno.lossin@proton.me> (Benno
	Lossin's message of "Sat, 08 Mar 2025 11:04:48 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<oLSvlIyp3xKD43zS-KRwVyzHmXwx74BdiRtl_9SBMZtpOu6JG5VvDh1fVTOT6cRO-OMJOvq5BJPVBcCScVmrwg==@protonmail.internalid>
	<20250308110339.2997091-12-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 12:38:52 +0100
Message-ID: <877c4mlgab.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Before switching to compile the `pin-init` crate directly, change
> any links that would be invalid to links that are valid both before and
> after the switch.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



