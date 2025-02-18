Return-Path: <linux-kernel+bounces-520034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C45A3A4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6E4188F90B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD828271260;
	Tue, 18 Feb 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exbMg7XM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D68246348;
	Tue, 18 Feb 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739902128; cv=none; b=rHMRMhCrLaLR7kPGquQbMHi0Q/8rWNwVduBu8ZtFn9aGTR9oRisqQiHTXGCxt1WWY1eJ336ZeAN9tVn35FYW0QTeMCWGmrBRsRk4BkgXhAyPnZ+bsWoXF/mpkC3as7FWfDTC03a2mdEFM5iQgV/eQ9xbYcynLItVttgk4G8JFJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739902128; c=relaxed/simple;
	bh=M+JfDyfsr3YKCI2KbP3j5FqpmygIU3DBUnuYdP4Nc0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CIwZy7zfjxkjWOmpHrTzh3t+eOxvqOk2HXZypJclKfXLU9A5i2HcIRz3g7Oc3GToDc+U5KD2IrHMyHIV1Hc+M/gIDUXhS8k4JdjX6+Ns4NwePaByIrA585/Tv052OgJkczyKVK3EhQpIP4YUmlDkfXpMJP+J7argWGoaopOlkW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exbMg7XM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED46EC4CEE2;
	Tue, 18 Feb 2025 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739902127;
	bh=M+JfDyfsr3YKCI2KbP3j5FqpmygIU3DBUnuYdP4Nc0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=exbMg7XM/th/ryaKiBbydkaTeLd5QO7JfKaZOffe4kCdJ8BkZUAgZLXP1eIjCm59v
	 T/I+xP/nHiYYNzy0+UwUawQHunhXv2yvdGu3g3zocqQjDvHIP0w+0xylN1UG8vb29f
	 Dui72ou/pPz9xFOYZCIgMTVz50e/1KUtLPF1wQB+5aKSPYMpsH6ZVPdTp4XW2TOx7F
	 4krq1Q/85TV+oLrZYVcuUvzKq5ClB0EBmxNM7uGlv2OHaZPbrgcer2/miRprKfXVZc
	 kQ0JOYbyL9CZ5p1YncEEsCWDiN7Z/kHZ8sPH1YvceeD+J3rzsvOgBByMTYpGB9onQg
	 lwjkDNYUtSMfw==
Message-ID: <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Miguel Ojeda
	 <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds	
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Tue, 18 Feb 2025 20:08:42 +0200
In-Reply-To: <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
		 <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
	 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 18:39 +0200, Jarkko Sakkinen wrote:
> On Tue, 2025-02-18 at 18:35 +0200, Jarkko Sakkinen wrote:
> > On Tue, 2025-02-18 at 08:08 -0800, Christoph Hellwig wrote:
> > > On Sun, Feb 09, 2025 at 09:56:35PM +0100, Miguel Ojeda wrote:
> > > > Hi all,
> > > >=20
> > > > Given the discussions in the last days, I decided to publish
> > > > this
> > > > page
> > > > with what our understanding is:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0 https://rust-for-linux.com/rust-kernel-policy
> > > >=20
> > > > I hope it helps to clarify things. I intend to keep it updated
> > > > as
> > > > needed.
> > >=20
> > > I don't think having a web page in any form is useful.=C2=A0 If you
> > > want
> > > it
> > > to be valid it has to be in the kernel tree and widely agreed on.
> >=20
> > I'd emphasize here that MUST be in the kernel tree. Otherwise, it
> > by
> > the
> > process can be safely ignored without a second thought.
> >=20
> > Doing random pointless annoucements is LF thing, not korg thing ;-)
>=20
> ... underlining that it would be also welcome take. But like that
> the policy plain sucks tbh.

One take: Documentation/SubmittingRustPatches with things to take into
consideration when submitting Rust patches.

"policy" is something is more appropriate word of choice to something
like how to behave (e.g. CoC).

Here some pratical recipes on how to deal with Rust patches would bring
the maximum amount of value.

E.g. here's one observation from DMA patches: there was no test payload.
AFAIK that alone should lead into an automatic and non-opionated NAK. I
know this because I thought "I'll help instead of debating and at least
test the patches" only to realize that there is total zero callers.

Neither I could find a document which would explain to me why this is
fine.

BR, Jarkko

