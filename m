Return-Path: <linux-kernel+bounces-358647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 520749981F1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735C61C27081
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA3A1C330A;
	Thu, 10 Oct 2024 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDkqk5j2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796771C32F3;
	Thu, 10 Oct 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551892; cv=none; b=MXfsvEau8fXsyCx3/RbWedwkYgKtZn7zz+TYywa0BIcYG8ISUpu7L+E+Lyp/031jEhs0Vj13gAesZLvNcsaKIopX81/0B152sg2jSenQgveuXGxLQ92i8uBQ6qvBUqmdXZXxvSwZLAWrbiyzfaFNoSKmkf+J2Suvtk0f50Xe3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551892; c=relaxed/simple;
	bh=dG34C9+HlVxQrZbeI0Ryd90SxrGhRkvSwJrP139CH6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcZKdneLx3oPBbDelIxSNF9YNTdCmh7arSRSUTbWFvpHwLTy17mF3RuMeaBP5VmaaH/S8tOQbWo6GdZAAU45/YI1OQ61T51B1iJ6b8ABbcnt/RxhsTh2srMdiDUuXpWt6PL+UJ+P05JjDkmU4Rheq5epG10vERKMxhFsMlN6G0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDkqk5j2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05863C4CECC;
	Thu, 10 Oct 2024 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728551892;
	bh=dG34C9+HlVxQrZbeI0Ryd90SxrGhRkvSwJrP139CH6I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NDkqk5j2iBsHO/4SWy/84tis49/vnqc1x/Kfvd7r0t2Gy3EsNH0nRkJgd7PV2uMXi
	 3sb5snmmspd9IV3bakRlBSNj8a14jqzvFQxbV2G0zC5n9di8tcuNv1emd3rHiX6l7b
	 75UVsTWPDBTbvyJ0XC7ZzVc5WV3dxZTnRPMoirEuzz9EGhX+2rF9bAKANIkdtlYS66
	 +/8atADPcl8PScg0RXuuYpIs8QNzgcZP9fv8Neuq1QsLKLv7gHLCeJi0Uzv8ojhbRJ
	 wN+kbsEchSjbT2+bqbG0p/eM3AeJn6Fes7wvQ77vveqwxpObTV858maRZo4/qJH6BO
	 tz2n8KdAOHW3Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: <rust-for-linux@vger.kernel.org>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Dirk Behme" <dirk.behme@de.bosch.com>,  "Fiona Behrens" <me@kloenk.dev>,
  "Filipe Xavier" <felipe_life@live.com>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: remove unnecessary header includes
In-Reply-To: <20241009162553.27845-2-tamird@gmail.com> (Tamir Duberstein's
	message of "Wed, 09 Oct 2024 12:25:30 -0400")
References: <CANiq72=M+rgJGLOBeSYygQzJZa9XnVvaWgi3DKUyT1Z_Rq=1Kw@mail.gmail.com>
	<R67HJa3VV1ltfgE5pSET7n6iLM7Hgp6oy8k-0iFVv2ADxSEse5RvUrTmd9y2y-w1OexU1nO_5kaF5nOiA8DQ0w==@protonmail.internalid>
	<20241009162553.27845-2-tamird@gmail.com>
Date: Thu, 10 Oct 2024 11:17:53 +0200
Message-ID: <87jzegmi4e.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Tamir Duberstein" <tamird@gmail.com> writes:

> Commit e26fa546042a ("rust: kbuild: auto generate helper exports")
> removed the need for these by automatically generating the exports; it
> removed the explicit uses of `EXPORT_SYMBOL_GPL` but didn't remove the
> `#include <linux/export.h>`s.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>



