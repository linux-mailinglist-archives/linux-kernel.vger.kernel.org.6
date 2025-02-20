Return-Path: <linux-kernel+bounces-523161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EEFA3D2ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9573517A72C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A22A1EA7D7;
	Thu, 20 Feb 2025 08:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNClqGGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35A1A724C;
	Thu, 20 Feb 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039377; cv=none; b=MMm0yc2YH5tsicfZo383nojiLuUc+n5LX7Wta+xUxnrA/YUCRBPi409OJD9XQGT9uKheFONivBmIEr/px0UvXt8DHgSz+tR57bIafHEcCIugxUi59ddlM2uG3Q7xOK+V2HQ1KVGHBpc4c8eTOgam5oEvpzCqM2oCjhGMKpntP6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039377; c=relaxed/simple;
	bh=GP7AxklUBzLsozEKv5c2EG9BorLrkNxDxENqdr/H41c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5P3EymYDnIb2yoNbva0HpV8VaWzZqfZOAlKx6N0NV+7fYvBhbnYDMRIJk1ScDtUOYnSr6js4LfZts7i/MGE2VSjcN6RCHRtUnmC816AUWVyZgNy9gJQ0g+wMD4aBsYc6uZqXz9nFXjBn3jBp3o10u2viNuhu/OxYGo3fh5iJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNClqGGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F146C4CED1;
	Thu, 20 Feb 2025 08:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740039375;
	bh=GP7AxklUBzLsozEKv5c2EG9BorLrkNxDxENqdr/H41c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VNClqGGwvKMeIWrCNypiUBzq9erBADPiFjBLJ07Tl/YDS5M6fBFm2bJZ07d5jO7iU
	 l7nml0ZpQ1hBQn8sYmYvUAdjkL+qjfsUMhwYxh9kXcU+J2dZlyX+wdIiRQ2/r7xBH2
	 G5ejIVluU476DUVQCOP4NAi7XrkcNgrPmZDenIOjQkqgWuow34JSQhsae2k+DsyuhO
	 HKe5/irf9f08wH/8lQYOFDQuhZE7jYGX8v60n0iVmU/Oq9Pr88oYKd+toVdiGpJg1u
	 BCcpWmwKuRxcUnyJiDfKoFJdnqPLL8g7nRBsIQ2K9mKrQ50MDISqmr0QeVSYLESPQZ
	 2M3Uo0mv/cLQA==
Message-ID: <4e1abc9c1ab07aeecc157a366c0b5eb91a177f2a.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Jason Gunthorpe	 <jgg@nvidia.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>,  Christoph Hellwig	 <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>,
 David Airlie	 <airlied@gmail.com>, linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Date: Thu, 20 Feb 2025 10:16:10 +0200
In-Reply-To: <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
		 <Z7SwcnUzjZYfuJ4-@infradead.org>
		 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
		 <202502191026.8B6FD47A1@keescook>
		 <20250219140821.27fa1e8a@gandalf.local.home>
		 <202502191117.8E1BCD4615@keescook> <20250219202751.GA42073@nvidia.com>
		 <20250219154610.30dc6223@gandalf.local.home>
		 <97841173-1de8-4221-8bf3-3470a5ac98a7@acm.org>
	 <89f2547edcaaba53d9965cab9133d809607330ac.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-20 at 10:13 +0200, Jarkko Sakkinen wrote:
> On Wed, 2025-02-19 at 12:52 -0800, Bart Van Assche wrote:
> > On 2/19/25 12:46 PM, Steven Rostedt wrote:
> > > I do feel that new drivers written in Rust would help with the
> > > vulnerabilities that new drivers usually add to the kernel.
> >=20
> > For driver developers it is easier to learn C than to learn Rust.
> > I'm
> > not sure that all driver developers, especially the "drive by"
> > developers, have the skills to learn Rust.
>=20
> IMHO, Rust is not that difficult to learn but it is difficult to
> run.
>=20
> One point of difficulty for me still is the QA part, not really the
> code. QuickStart discusses on how to install all the shenanigans
> with distribution package managers.
>=20
> The reality of actual kernel development is that you almost never
> compile/run host-to-host, rendering that part of the documentation
> in the battlefield next to useless.
>=20
> Instead it should have instructions for BuildRoot, Yocto and
> perhaps NixOS (via podman). It should really explain this instead
> of dnf/apt-get etc.

If I got a Rust patch for review cycle, I would not have any idea
what to do with it. And I'm talking about writing a single line of
code but how to put that patch into a QA cycle (personally using
BR for this, which is somewhat popular choice among kernel
maintainers).

So I would put "NAK because cannot test this".

BR, Jarkko

