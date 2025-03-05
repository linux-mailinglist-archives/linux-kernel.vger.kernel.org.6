Return-Path: <linux-kernel+bounces-546878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF43A5000C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F14169B38
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FB724CECE;
	Wed,  5 Mar 2025 13:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4oMgOyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CB24C67B;
	Wed,  5 Mar 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180139; cv=none; b=TBMmEp3WZm/qVv3mFUQIhdQomrFQ9Uwo+eEFMBaBAGDX+wECYrf9SnPnk0v094bK9StyuOKCxyM3HOM2s0YXhc3PKa8XIIF+dj5zuMuhqYZJnpLNe6RpZzTRhBN4j6Mc2wN9ItJoQD3aZ/ZHXvM9T/2dEEITaSgcjOgJeuzRDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180139; c=relaxed/simple;
	bh=WLUcOL2otVG0jpZubI0x3HUAD3y8b+c/gIMs1Fn5RFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R9+C7igt/ygILma0SVNePtktrLjvGag4K2SPV7lVhGh00jtigOo6VPWvzv+iCVl3WRgkTRk5acRMK9hth1Q3wQ5qYWXIc9nN7pYl+7HNaaqzWdtzy6JKIjlGvRHtvTO+ftFUEIOm0Hw94y/7M7JXmQTbFrP4YL6+XYBIxu6ONRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4oMgOyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C6DC4CEE2;
	Wed,  5 Mar 2025 13:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180138;
	bh=WLUcOL2otVG0jpZubI0x3HUAD3y8b+c/gIMs1Fn5RFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c4oMgOyQ4dauphIHEFXYtkqgw9Xz8NQXu2kQclk9p1eHdvV9YmENQoqQkza62fmvE
	 SLttvnkXc5to369c/hnyL964ePWMENbQl6NATO+4+wPqAiSW88Q25qkjByFw7QF028
	 tmsheu8W103zgcjk+qRCY8jBfx3QVLTXjCJTuFP2vM65gY/Hb0R6JzFPQOkTD+fC1g
	 APFl47/r4cRJzacP91a8oRcyihRL6/VGPzoUH+Hc0vSVl8KB8YVjyr9RCqRLU4uUIC
	 TowOUjjGIqiZKrkGxXnWBOIVXoSnos3Q6Xy1pKK9KCCGmhyohISfH5hSK/yQE42oJZ
	 Rr9W8cigR6BlA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 20/22] rust: pin-init: add miscellaneous files from the
 user-space version
In-Reply-To: <20250304225245.2033120-21-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:56:10 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<5Q1xnRAO-CFSBw_RfcJwj_wKB2rd2Qcc2qFiWmrWjueSmkBd3T-BuqlHSyrMrGIu2loBNIJUTRmvwBk2hfoneA==@protonmail.internalid>
	<20250304225245.2033120-21-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 14:04:04 +0100
Message-ID: <87y0xjaat7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Add readme and contribution guidelines of the user-space version of
> pin-init.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

While we don't _need_ to carry this, I don't mind. I think it is
different than the dead code in an earlier patch.

But really, if you are already going to sync changes with automated
tools, it should be simple enough to have a list of file that are
excluded from user space to kernel syncs.


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




