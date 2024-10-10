Return-Path: <linux-kernel+bounces-358699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADE998290
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8201C26849
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A41BDA89;
	Thu, 10 Oct 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LP5l36P1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E071BD504;
	Thu, 10 Oct 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553235; cv=none; b=if/ibwkN8+5mhnw7dceuhxCD7h4OsvQ5v5avGfZK2fFCirF4r4oqnMp7YjmbkfuWHsgl1PomWFMHbCMswljw8T5bt+bwdAC67zlm8R8cBfm3nfPAtjKVCF1npx+hvLI5onrNrX/kQ9YiGQNwaXccylCBiNxd7dtiErgKT5tTfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553235; c=relaxed/simple;
	bh=KgSF+pidPWnxaKx+7T0ciJ7TQJIzSF3VZ4HNyn80ccw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d2fZuM11Vf6bZEOzomk/7GtDaaPw937D48E6Wcd81vw7UAC2FZOUpmGcULyUP+RJ7Kz/4qdMzSRONOBFq3v1KPdNl2G38kByxPx7j64A8wr/481rA89enXEc/SD8Yxkld6nyVUvLB+eLlk+7iGbNACXWBl/Yxn16SYvT6CMMRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LP5l36P1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C89C4CEC6;
	Thu, 10 Oct 2024 09:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553234;
	bh=KgSF+pidPWnxaKx+7T0ciJ7TQJIzSF3VZ4HNyn80ccw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LP5l36P1OVbQeFdynhbQWx2HQKn1q2YzFtK2s4GRRtar5QuW8q98PRX+ENSO2NbtL
	 ZzYajWZzaiZSRqwuL/o4DAAo8fWu7O58Y+AD4F07iTZtbqmTHVs71o0YNY6R2K13Yx
	 WuKNnnx8tlyL0CxI8ad++/rIoHXIrXOwwHi3rXRAjgM45mLguJA2EnyDbjERVg+lLL
	 UfG+CPzn+8nQZ+LuL51HfwX28if3f9gbK7l37qcqQibF62ltnWn5boYxtCUjzOmMC4
	 STftMtp+iiD15eNP2Ox8nawS6ilP0MkQm2e6FsBPMUVU+HzOgdsWhckl2f/JQ9A7Lm
	 FwNQItyh0MjSg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: improve grammar in commentary
In-Reply-To: <20241009162358.27735-1-tamird@gmail.com> (Tamir Duberstein's
	message of "Wed, 09 Oct 2024 12:23:58 -0400")
References: <kX17aeHUp5umwe5GCvm343i1wHKu96HLE6jtd3snAIynN1YBqXUkgIGJ-w9DqSTSw57ULD4FhE3NpZQwi7Q0rg==@protonmail.internalid>
	<20241009162358.27735-1-tamird@gmail.com>
Date: Thu, 10 Oct 2024 11:33:07 +0200
Message-ID: <878quwmhf0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> added an errant "the" where one was not needed; remove it.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>



