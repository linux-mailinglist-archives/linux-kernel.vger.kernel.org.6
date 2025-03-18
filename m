Return-Path: <linux-kernel+bounces-566073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11EA672CE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4749189DE9A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D920B1FD;
	Tue, 18 Mar 2025 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek4uqRWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FFF1FCF47;
	Tue, 18 Mar 2025 11:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297744; cv=none; b=tUcBU4LcOeg5DHHxTVwPTTSTdgvs1u1kcNWfutUfTAVtR+9CgJI3VKW1L9MeVCbslpwlvEwqRg1PLHIyjMTrUwXUXUOla6N/rfCk7FFygn6l0JcgV7+wRtopIbsE5sH8vn6IRBT0rQR8HTAA5DceFXNLZGjygcBMOuIFbsqVY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297744; c=relaxed/simple;
	bh=xTvaV7861qose7rV8ILOMVV+gKbgSpHjdUOLPhFRjmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YiINgGGi7aznOOxxbww3ZqSf0GtyJ+xTxTN9ire/gOWE/BPqPGdmsc0TQlmwQh046yDK08cmg3ZIKv0XAWmMGEdLHgX10wYbOmQP2r21zHNZPA/lT6iqZ3kalz4kW0Ge5edX4vRXFAXO+w3JBfthCjl+ZVNKY6QLcsFQgE2ZORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek4uqRWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4005C4CEDD;
	Tue, 18 Mar 2025 11:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742297744;
	bh=xTvaV7861qose7rV8ILOMVV+gKbgSpHjdUOLPhFRjmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ek4uqRWj+JqDiu/kFIPPtB4rUOzeASkYl2c7Ohy5h+eruoCUFKtX/FbzC3UinF1BK
	 dN6Cb29ju8+tQc9LI5hlkr8UgV5lqeUKQA0Sife/xDSMBe1IPP6ox0XfjDYRBIOdyi
	 eqMFatldtRwxI8WAT4YHhUewL6fWz3kFKDJfzw17HBwg/ZKGMx7yQ1givcg8yajR2u
	 Ewa65bzmlEsbB7TrlrhDyOj66DhbwIrA02Nz8yKHC+On+J9wxlIf3+Ti3GlQJDihA/
	 je1UgAZjmiofirLLheVcWrwjZi+GXKylfqV3xNpZimfqWu3AVhfWaezMNycd2MQymA
	 4DRyAIVIokblA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,  "Fiona
 Behrens" <me@kloenk.dev>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/22] rust: pin-init: move proc-macro documentation
 into pin-init crate
In-Reply-To: <20250308110339.2997091-5-benno.lossin@proton.me> (Benno Lossin's
	message of "Sat, 08 Mar 2025 11:04:10 +0000")
References: <20250308110339.2997091-1-benno.lossin@proton.me>
	<MV3Dd6cjj9PCMrZhszmwYsMgAsXCTrIAa3Fr6rSkDd33d_Db4Myl-3TTnbpfp6pQXoG-3q3mXam8wY614QYYcQ==@protonmail.internalid>
	<20250308110339.2997091-5-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 12:33:38 +0100
Message-ID: <87iko6lgj1.fsf@kernel.org>
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
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



