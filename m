Return-Path: <linux-kernel+bounces-546435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F2EA4FAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F007A718B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E62054EE;
	Wed,  5 Mar 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1H/r7LL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0BF1FDE37;
	Wed,  5 Mar 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168384; cv=none; b=OPzMEqvAe69hx0TR4ji5eB1wBb2AQQkp0HGZvFSIw0G6n+LrXFFJT+rGeCtNyHeqd5mfhefBOvJ2rK1LZ6py9znzp9Y44Qo2Nkkduic5O4HlZ6UtmXXmlFJkhurvTz7Od2pb2yMChylmtkVoAyihuz9DRN3nFBb5/SVXz85s264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168384; c=relaxed/simple;
	bh=+elOXc1SBi+STkRDAH/vjJLO0WJhOrFsLCA5uwZhWCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rbWHVQe30syuqpptFW3BmslCNi0LVWhDYUet8z68+h5M5GBSgWLT0ui2bXpMTOjgfWNqWwWs8V+G4i+TVC2QZEA+DKde50gACk1uEHTiC89VfH72ZF1zMoekKBQYXvprkv84EMOy4RLiS4KqeEwZw+cq+OkUZYABoqYeVE5HH4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1H/r7LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C38C4CEE2;
	Wed,  5 Mar 2025 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741168383;
	bh=+elOXc1SBi+STkRDAH/vjJLO0WJhOrFsLCA5uwZhWCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b1H/r7LLzW1PoyfsaQG5cse2Mukc79Tn+/RE11BRRORPI/myFnP3gHXcqW0mnCMEX
	 22siTS2PARd2YP9bMgPIfT+IGTmPXIl5ywFaovmBgBmoyTTcgI5fgJZjIWB8O/lOqQ
	 SE6P21ow6kV93bUtPd4mWrLzhsbYZ3AeLJvTQsOCqAXo60N7LJenz60PLXrIozamaS
	 PpO9+o0EaO/sO8XQZ9pomH/bvpZFVZjti2954CB0LjPqa+sbOHgtbVM9Y6u1PVFLpS
	 /UWs7OxVlVcUDJwOvjALOsT3V7emDYWhwqrDW1grV8nVbaxg4osfw9KOdKqlUB9Ei1
	 YgfWhvN/l0Q4w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/22] rust: pin-init: move proc-macro documentation
 into pin-init crate
In-Reply-To: <20250304225245.2033120-5-benno.lossin@proton.me> (Benno Lossin's
	message of "Tue, 04 Mar 2025 22:53:36 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<PvTMOxu_O9hNZCnpZRlYj2yIiGONO7aZxT7F9mqfOwEMfFnE6ucILMz4aGehSJwWOKtsieqIrh__hd1b5T3z8w==@protonmail.internalid>
	<20250304225245.2033120-5-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 10:34:20 +0100
Message-ID: <878qpjg6sj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Move the documentation of proc-macros from pin-init-internal into
> pin-init. This is because documentation can only reference types from
> dependencies and pin-init-internal cannot have pin-init as a dependency,
> as that would be cyclic.

`pin_data` et. al. is now re-exported both in `kernel::prelude` and
`kernel::init`, but I guess that is fine?

When you say "can only reference types", do you mean via links in the text?


Best regards,
Andreas Hindborg



