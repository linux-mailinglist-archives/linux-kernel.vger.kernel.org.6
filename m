Return-Path: <linux-kernel+bounces-437985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A819E9B4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107E3281CA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E5139597;
	Mon,  9 Dec 2024 16:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Apb4EXAv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982C0233139;
	Mon,  9 Dec 2024 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733760665; cv=none; b=rHSolL8cWtAD0L1fh89qgyGw0/xD6t1yTuTPxQ/w7CEhHDka09Z35aTF7yT3j8f6NvVyD9MVGmwyPugfExEnFjEoF++5hnJvxXkFTSyOerFotgrYNuf5Bz69rtRMOhsKn7NQVxHwCgj1NyNhFIQDYN90zws7BVOopDVnneMHV3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733760665; c=relaxed/simple;
	bh=OofoqX2bMhLixVwLOiukdGYDyU/vw2PSTyGG8oXvjug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzinQai82k88cLCftk5MEUhykcqZtd50xGOmDiDpSZVVnBi3NwBmVDLquNyydTNJ5Effthd95Nj1DJUPX9+YpXc1vV9zIgtFohdNG9+dKGDYkuS5/gRVjd78z6yEYMQiMWi7C/V9lchMeDWzsBD4Vxy53BLNRDoqAj1tGCZUahM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Apb4EXAv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E07A6C4CED1;
	Mon,  9 Dec 2024 16:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733760665;
	bh=OofoqX2bMhLixVwLOiukdGYDyU/vw2PSTyGG8oXvjug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Apb4EXAvqMmk3pUo0CS1aFYbqPOcO0OJJ1j875M1QVIiEjFehEgBW3A2yT3lg5S48
	 ZPfuIKDKtTE0iotef5lkOAGiWwWMgpT33IWmPpPniH8T2zYNOeSV8fjLYYV+F7Io7o
	 GhklNW1lePjkeQC3gZzFaaH9XJzy9a0urd09vJ9N9Lu7lxh0RsRLzIh2gIS3F/aBJW
	 4iIu8/LlZ4Q1wqdH1I55N8R80JAwIKil5AlkQ/NYTG6+DCaPGWXxzNvj1mVhwMbGGM
	 S1MIwuI2OL/VcxQRVyULis32gZhBbe5kxPelwqFVCYUdFZ0agzza4vIc+LWmYygzGc
	 fxh47a9x8H6og==
Date: Mon, 9 Dec 2024 16:11:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Subject: Re: arch/arm64/kernel/signal.c:1046:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <c8379d04-420b-4039-99ce-5a462d820685@sirena.org.uk>
References: <202412082005.OBJ0BbWs-lkp@intel.com>
 <Z1cOs2sGff1_TtQZ@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g2CdCmewVkJ+cNjG"
Content-Disposition: inline
In-Reply-To: <Z1cOs2sGff1_TtQZ@arm.com>
X-Cookie: Lensmen eat Jedi for breakfast.


--g2CdCmewVkJ+cNjG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2024 at 03:37:23PM +0000, Catalin Marinas wrote:
> On Mon, Dec 09, 2024 at 12:47:33PM +0800, kernel test robot wrote:

> > eaf62ce1563b85 Mark Brown      2024-10-01  1014       unsigned long __u=
ser *gcspr_el0;
>=20
> I think we should keep this as u64 since it's a sysreg.

Do you mean pointer to u64 or plain u64?  The value we get from the
sysreg is a pointer so it makes the uses of the value clearer if we keep
it as a pointer in C code, it seems to be defeating the point of doing
static analysis to discard the pointerness to make it happier.

> > eaf62ce1563b85 Mark Brown      2024-10-01  1050  	put_user_gcs(0, (__us=
er void*)gcspr_el0, &ret);

> We need a cast here if we are to go with u64 gcspr_el0 (it wasn't needed
> before, not sure why it was cast to void *).

It'll have been cast to void * to add the __user at some point before
the __user annotation got added to the variable declaration.

> > eaf62ce1563b85 Mark Brown      2024-10-01  1051  	if (ret !=3D 0)
> > eaf62ce1563b85 Mark Brown      2024-10-01  1052  		return -EFAULT;
> > eaf62ce1563b85 Mark Brown      2024-10-01  1053 =20
> > eaf62ce1563b85 Mark Brown      2024-10-01  1054  	write_sysreg_s(gcspr_=
el0 + 1, SYS_GCSPR_EL0);

> And this would be +8 I guess.

The variable is a pointer so we're doing pointer arithmetic here not
working directly with the value, unless we change the value to be purely
a u64 with no pointer in which case we would need the case above.  The
whole shambles with u64 vs unsigned long and pointer vs absolute numbers
in all the code that deals with userspace is really unhelpful :(

--g2CdCmewVkJ+cNjG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmdXFpQACgkQJNaLcl1U
h9A9ggf8CAksCQdCH/QB6vjJvUmLJsPDj8HF/l5Ib8VTrPXnvOTv+txQ3YEdOvRV
lXk1sIbxaq1hE5OSXdcD+N6peFOzCg+L4LFF3Yf/9thYYkmEhLn/wU//0mUdAORO
Ju1K/aPt4wgdES7GotOD1WNcE4GdRtIUvBXuK/Map+5w7RibrNhsN9zJVlkUU0g8
+aHGXmP89CyoBEMiodIHwdJLNIYcRrAYiW1xm5tjS+CY+vSZguvUg2ZFVTEP6LAw
SxGqUAO9ubtK1HlSTwgEKv9lRAC9gh1fcw6kc11QguICLiaE4Peac/vNdj8L6wh5
AHPrChrIEKtwfVEsWreV8SBDcfevCw==
=TRp4
-----END PGP SIGNATURE-----

--g2CdCmewVkJ+cNjG--

