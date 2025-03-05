Return-Path: <linux-kernel+bounces-546879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F901A50012
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF103189B944
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1317124E005;
	Wed,  5 Mar 2025 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIp/SkCo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B3D24DFEB;
	Wed,  5 Mar 2025 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180142; cv=none; b=j/smOP05E+dWKJUsc2nBRO+CxR0aNd2BoGdVoOhYSdHd6YP/Nd4BOiy6QYLeo5LPk4xl5J+gscyZh9T4gTvjLLfOychHiqQjzPp2MQCc+C4k51XtNV//wsc3WAwhQOtmb0bdPNHEoHDt5mIJWBlct12CPE67sC58V+YkB5RzLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180142; c=relaxed/simple;
	bh=HjU1sSce6fMzUn7C96CXYSAD//S86GBnqh+EwbM9pes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JDvL68leI6ix901YfzPeqm0f0DiBALizgNaBX6RjCp+mFq75SqIwP/1ZNXpoEhGoUDXQ79WgOlv5U4ciVK2cMTGrt1S6utKiu473SR2t7rnDcj9iDOr6XbOkgTc3IqHeEQYxk2Z+6/l/Jb2DuH+4ZbYIv+SAHOF/czTDdVgeLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIp/SkCo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8334AC4CEE2;
	Wed,  5 Mar 2025 13:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180142;
	bh=HjU1sSce6fMzUn7C96CXYSAD//S86GBnqh+EwbM9pes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OIp/SkCo+jcOBRkAOML5l020puhRAbFcKho8/MK4zIPeFEc234ctwTBRQcxforb68
	 IwrD6PcDGi4VFWQ/x4rt50s3siTzn9F8iStpZeI32hxtn1PkOoTjVoGlA088SRHMCB
	 eKOq02SRmtkz12lU9PiaVp4iYTRsVTMMm0C5vyayusyTo4o2OvOAAfrM/NILNU4lYD
	 q6GJ8amXb5yPTvKKzF59TaAyC8PoSvG3QcBM395/VGmSa1/zHaOMK33XFFv/iNQadJ
	 SpHnvCfGN7KwjEXPZcymtdyC624cQnFGgZH6qF0wNGhSCVnWCqcCuzPQtaBkBthVQY
	 c4gPEsCYiuIZA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 21/22] rust: pin-init: re-enable doctests
In-Reply-To: <20250304225245.2033120-22-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:56:18 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<QuoW3tq604_qBo8XsLYFsvAWFaYajkZyXeQnMBUcdULeMxx9dkrKz8H78Ks-ulbflVXZJBChfZ53e4a4UoFrhA==@protonmail.internalid>
	<20250304225245.2033120-22-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 14:05:28 +0100
Message-ID: <87senraaqv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> The pin-init crate is now compiled in a standalone fashion, so revert
> the earlier commit that disabled the doctests in pin-init in order to
> avoid build errors while transitioning the crate into a standalone
> version.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

I really would prefer if I could run those tests with kernel
infrastructure.

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



