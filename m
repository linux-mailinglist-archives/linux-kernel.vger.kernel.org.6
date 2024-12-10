Return-Path: <linux-kernel+bounces-439550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC09EB0E1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC7B16338A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94121A2632;
	Tue, 10 Dec 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGSDNjeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235031A08A8;
	Tue, 10 Dec 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834023; cv=none; b=bgK6DS3AyEttHgDJnShtf25GoK2j+W3k4LthEyYqsPBhuTLqmbkwe7lkVEWCMqMpk3YDJ1FqazYJoNGqkg8nVJkHmHXzKTZlkPn4or3Ll9019mFQbf0pj2x7UGjc7cAaCdkyRZ9lgnaosBJD0cMlVGVow6OdA/BN7w2kZeOTEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834023; c=relaxed/simple;
	bh=rIwU7Xexky01EHWp4VIkrifVyY4Q5MPQE5gig+JRHK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGvswLJdRbAgnXgi/mKvH4Yif6w7ebSiKVPq0tUUpUuYMtUW5d2Z+FKIxugaxogesz/H3LWQ7zja0VqpgPo6WTbAHakBEUz8ZIJZTe7MFXenStL6nUfk/Wbv/HBtq0rIZfW2eyZqQ1K+zHX2gfgaRBVndBGPpaC4qE20b5kK7Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGSDNjeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DE9C4CED6;
	Tue, 10 Dec 2024 12:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733834022;
	bh=rIwU7Xexky01EHWp4VIkrifVyY4Q5MPQE5gig+JRHK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGSDNjeNqa5SaKnmBBzkqPJP/zINrW33eg7/39hXTjK9w/YR7cxb35XgQnTPKEsnf
	 cUIAeQx0W2GCCe3hzplTjiGyLfu8FSORky0MwlTvtwV3C4ptmW4WMG20pxWd1VMs9j
	 RuJwplVOKG1tW9rYhrl3e0ZB3K9OuCrNlJiruP5VQ6zhVj/HfRmGQ5GqwOOuahch0D
	 SSkaSjwSFXqsmAa20FMCJqw8LD0He3QaT2VDDNu1lobrLQ9/GFSxSsy3RGVhmuRWr6
	 BBwvaCJAOuqTkgsaOgtQWET9DuoWjJ+Xy00a2ftInopP3b0QS5AFrkVBnYpShE0uiT
	 XOS6L7VpLKK4A==
Date: Tue, 10 Dec 2024 12:33:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Subject: Re: arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <4fb5acc6-350e-4f7b-8512-4e1799cb2a37@sirena.org.uk>
References: <202412082005.OBJ0BbWs-lkp@intel.com>
 <Z1cOs2sGff1_TtQZ@arm.com>
 <c8379d04-420b-4039-99ce-5a462d820685@sirena.org.uk>
 <Z1gh809HUGRZI258@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JcZFkG1T/beSswj9"
Content-Disposition: inline
In-Reply-To: <Z1gh809HUGRZI258@arm.com>
X-Cookie: Leave no stone unturned.


--JcZFkG1T/beSswj9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2024 at 11:11:47AM +0000, Catalin Marinas wrote:
> On Mon, Dec 09, 2024 at 04:11:00PM +0000, Mark Brown wrote:

> > The value we get from the
> > sysreg is a pointer so it makes the uses of the value clearer if we keep
> > it as a pointer in C code, it seems to be defeating the point of doing
> > static analysis to discard the pointerness to make it happier.

> We have other cases where we treat a reg as u64 and convert it to
> pointer as needed. While not a sysreg, the pt_regs::sp is u64 and we end
> up treating it as a pointer eventually for writing the signal stack.
> Another case is user_insn_read(). It's bit of bikeshedding around the
> primary use in this function, do we need more conversions one way or the
> other? In general I'd consider a sysreg read to be u64, especially as
> the architecture has a habit of adding bits around the actual address
> occasionally.

The sysreg read is a u64, but we then interpret it as a pointer and do
pointer things with it for the remainder of the function until we need
to store it back in the register (which is where the warning comes from,
for some reason there's a cast in write_sysreg_s()).

> Anyway, I'd like to silence sparse on this. The u64 (non-pointer) has
> some precedence in the arm64 code but, if you want, I'm happy to keep it
> as a pointer (and maybe just rename it to shadow_stack or something that
> does not imply a sysreg). I think for the actual warning, we can
> probably fix it with a __force to silence sparse on conversion to u64.

Apparently the rune for this with sparse is to cast the value to an
unsigned long (type safety for the win!).  I wrote a patch last night,
should be done testing by now.  Given sparse we should probably have
that cast in write_sysreg_s() be to unsigned long.

--JcZFkG1T/beSswj9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdYNSIACgkQJNaLcl1U
h9AWrAf/Q6HCpuaqGw1+HNp4qT2q1hdxI3KR+pnMfxrlQFJ7cvvoKcfVAkLQwjsN
RA/fV11q3RL/6p890FgaO1IhXbyfnuRgNSUJTOnUMOCPWWoxk9QVJ1qOK+FiapYo
M82Vfm0LfM7tvCIPR0xA3VfP6cQGpR5pDlKL/qefktfg7t3FauiJrcT6HPRwktTo
LU7bIGz+D+ariTXR/gKzZuI4kmTdwql6f5Boy26BN2YloUwMQaH3a1lhW3+/o8mt
DVkQ1NQrhGrNaPBcU3gliPqfFb5pM21zCoAS954yfXca26Dyh5qpp360B/pgijzv
NizKjsy2pbQ9WEVxGBCSFl6yP4B5ug==
=nSaN
-----END PGP SIGNATURE-----

--JcZFkG1T/beSswj9--

