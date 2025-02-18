Return-Path: <linux-kernel+bounces-519875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F49AA3A306
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10937188C0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54C026F462;
	Tue, 18 Feb 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muT7cUu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4D14A4E7;
	Tue, 18 Feb 2025 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739896788; cv=none; b=avPbfdS+T1tLhlxJwOXR4KrqAk1L5o5Ul/EOH5rhNoLK+ndI1woixPs/MKLELyQS6r6SffRRUab6S7vaFEf22khR1yBbE4Zw2GV2icsA3GM1Fafb5OH4P0HDouTf3bd74aVrY4rXY8pIHWumD4YIvP2YTVosivmA4h+lpNN0AHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739896788; c=relaxed/simple;
	bh=cg5/3BAZlORtrYfBYZr2jWQTm4leoG/KUOjUf75pbPE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Od61gLUGW3nX4p10t1Ac/vZFZGpcR8/VQ064mRzwTRGplkjfEXPVmnmgtvAJglNriNcnvWkWPNTALxhg3g++wQg32vpUXDVpGq3WtKpjCrxzlPTWmLYgOEFe+6fXK1SpXBLSu2NXcsJcLMMSRQUcufhtgKSsMwIyjxRB+g0uRoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muT7cUu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BEAC4CEE8;
	Tue, 18 Feb 2025 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739896787;
	bh=cg5/3BAZlORtrYfBYZr2jWQTm4leoG/KUOjUf75pbPE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=muT7cUu4Y3bH+7Rnpp4hsnHBjw92sI2MrtoQ2d4KHHUVkwDOsGAyLp0pppEateRFv
	 wck4ymenYKZmNHNePExiOjkS4ef8Bqn9ectzgk6OFjiG1KvNQVMc3J0L+QmLd5UKuB
	 VZ6f4sXbzXPIDf/9pxC9rVpHoUEeyfaPv2gK9rbrl4a17NY7Kpym2o2cq+IAvNvAEL
	 s1O8/hbpt+0QPvJtfg+UPgZbZSlt1hgXv20LS67/jt2RtFRdrI68s78aGHidLO/khw
	 a+Hch3l3kw102V11dNBXlS8ZjLUAioR/Yv6UjCQx0cOGCr9izdgUcQDKDAFATIGLu/
	 bLJKv42F4CDgA==
Message-ID: <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Miguel Ojeda
	 <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds	
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Tue, 18 Feb 2025 18:39:44 +0200
In-Reply-To: <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-18 at 18:35 +0200, Jarkko Sakkinen wrote:
> On Tue, 2025-02-18 at 08:08 -0800, Christoph Hellwig wrote:
> > On Sun, Feb 09, 2025 at 09:56:35PM +0100, Miguel Ojeda wrote:
> > > Hi all,
> > >=20
> > > Given the discussions in the last days, I decided to publish this
> > > page
> > > with what our understanding is:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 https://rust-for-linux.com/rust-kernel-policy
> > >=20
> > > I hope it helps to clarify things. I intend to keep it updated as
> > > needed.
> >=20
> > I don't think having a web page in any form is useful.=C2=A0 If you wan=
t
> > it
> > to be valid it has to be in the kernel tree and widely agreed on.
>=20
> I'd emphasize here that MUST be in the kernel tree. Otherwise, it by
> the
> process can be safely ignored without a second thought.
>=20
> Doing random pointless annoucements is LF thing, not korg thing ;-)

... underlining that it would be also welcome take. But like that
the policy plain sucks tbh.

BR, Jarkko

