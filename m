Return-Path: <linux-kernel+bounces-195307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89358D4ADF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 13:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99A41C21872
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3531761B8;
	Thu, 30 May 2024 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMb4nAQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04D174EC3
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717068505; cv=none; b=bJlfXmkUAoCmjPYq0gypa/EDd0oVMJkLDnAjI3ksBiPfE7W/lRwRm/edhtypXr5FUgoO9L+gbaBttO1q3SLQCBeHtJ2+8Ao6qDujZ3BqJDuAI0lF5PEK4L0StXWkRKWTd9V/BrKUZNI/cvq7BFbvmOSmiVj8FnLo+8yNcWrFX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717068505; c=relaxed/simple;
	bh=C3aQb6JPSLA0vR1HV26cZ06UOE6cfzVSl7Yfa+8f+ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=R4q/xwKAyttgM5h146L4EPfxzTMc2Ewb8wlYVoRnmHEUSa/+BIJQrsmEViEv3Usp8Zsru+CTUOqU//LLkNwAXF+d67y0sjZqBIT/niCT+moxytZW3WxdgQykTkIMohB8nPKnZkd6ZdhbHXvc4WkssRt+uGba54essy981Lpxegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMb4nAQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AE7C2BBFC;
	Thu, 30 May 2024 11:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717068504;
	bh=C3aQb6JPSLA0vR1HV26cZ06UOE6cfzVSl7Yfa+8f+ZQ=;
	h=Date:From:To:Cc:Subject:From;
	b=FMb4nAQj1Ufa25zkruDyLNSQ0l+m2byYFkzJ583noIcFl0JUQ+jOXiaDoN+st2++R
	 TbuqOxeTZBcdn6OMrt7xfpngoFRl/szGx/17NRVxlCXgbpSZpRG9cVNSX4SHEBCTRo
	 B9WHrhE400CcTyXlc5/IhwDHStLofV0RL0f+wzKSd+3IHpVAfj+Ek1oSa6BI8ykvYZ
	 uCpcqUiYoXRCeiV5BdTs0/RnmJhvJgvP1PwOnqzjz1bELt/PKHrV/5LKX0wC1ukSPC
	 gMuqXwm21Ttpb42qFKGT5woBWDAuHxyf5YjfhkVN5CMmiI45yG/I8YN94ZCoyPoZyQ
	 xQUaLuaX1kAWA==
Date: Thu, 30 May 2024 12:28:20 +0100
From: Mark Brown <broonie@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Build breakage for imx_v6_v7_defconfig
Message-ID: <54798f68-48f7-4c65-9cba-47c0bf175143@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C3IpPR90RR6OWV7K"
Content-Disposition: inline
X-Cookie: To err is human, to moo bovine.


--C3IpPR90RR6OWV7K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

Your patch "rcu-tasks: Remove open-coded one-byte cmpxchg() emulation"
in -next (which I can't see on any list though I can see some similar
bug reports about it?) breaks the build on arm imx_v6_v7_defconfig:

arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `rcu_trc_cmpxchg_need_qs':
update.c:(.text+0x318): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `rcu_read_unlock_trace_special':
update.c:(.text+0x3ec): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_read_check_handler':
update.c:(.text+0x480): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o: in function `trc_inspect_reader':
update.c:(.text+0x1568): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: update.c:(.text+0x1598): undefined reference to `__bad_cmpxchg'
arm-linux-gnueabihf-ld: kernel/rcu/update.o:update.c:(.text+0x1d10): more undefined references to `__bad_cmpxchg' follow

Other configs I test, including bcm2835_defconfig (armv6),
multi_v5_defconfig and multi_v7_defconfig build fine for 32 bit arm.

Thanks,
Mark

Thanks,
Mark

--C3IpPR90RR6OWV7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZYYtQACgkQJNaLcl1U
h9DXQwf/ULYHMIdv1g/t9PwaL5yBgCdt7FSz/57YNJSpjMT94+KaOnGNOxT7rSHZ
Y0b4g+MG+3c9Ys4779UQqmIDTBcTa51JkFnie0muPgrZ1hIAvwSLfFZcr2ULDcEk
0Xv0yHP5wAYkeH+si1soAH0t8gOWIucSy0RL2yxRSRXnhkC2DpFHxQ9EdbKcBjlQ
TvTuY/emUaCBOEG+JEG/XGlKId9Dib1fiD1+Tsdygr9knAFChHxQyjpIXlXzgZpa
Yj1adO0XxP7KDN9d6r+FAkh/Ln3x1NeA7Fsb/uKVIbBjWYxOq2TDoW2FKaKpCNWm
Dz/LJdw+Suvd8yNq8tqnFhYHlqePoQ==
=bADg
-----END PGP SIGNATURE-----

--C3IpPR90RR6OWV7K--

