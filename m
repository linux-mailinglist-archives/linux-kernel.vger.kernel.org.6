Return-Path: <linux-kernel+bounces-446875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704839F2A73
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD57D167FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FE01CEEBE;
	Mon, 16 Dec 2024 06:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gV1EKacK"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22B1CCB4A;
	Mon, 16 Dec 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734331805; cv=none; b=hRZMC+zGDMhlgWqeGVkYjBEk8cSfFirHVJUO6Q2CVifIUQ/0vcsnQ0FYgdrA7HtihwBaN+LAlzZrMlA8sE897kXpZBcAQiWwXgopbxKT+ew/sVxv1O56oznaEJffzNNCT70PTJ6AHiL0qTsldFIpp40el3paoC3InfDgESx1bEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734331805; c=relaxed/simple;
	bh=a2hUENATx1Zz00hmqH4gKGQREVNz0gxQ6fHfdBZ4PR8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tEv+EPKfvX7D2wBXDLRa61F1Oh4g3pVJL5XV+YtZl5U/AMUJJXdo4ysi4ZFuUcRfWzUz9IF3Gr49X/MdljdtS1vEzwbJISVOPp47/fG2PiwURbHKBo3y7mPMtf3ib1bfAHpID80XG2puQQdCNnp4M11zyOs08Uag3XyF6OyC9w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=gV1EKacK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1734331795;
	bh=2HPKhcRbqyaOza/IUfE/625LBbCTstUK4lYvqNB3GKQ=;
	h=Date:From:To:Cc:Subject:From;
	b=gV1EKacKgL6gt8UlK+gH1sofVZEi36UrE5S2o/Owogiq5Ylgq5QlI6sYi/0U/qPpo
	 BhWTUug8nT8Pzfp415aLvSaiJsKGFkPfLpMisRjsV84e1WOUakpQtc9tzzaIF07iVA
	 8drHXsyC3Sj+CYs96SBL+ThvFSVlPKxrorqorGFxfYxoBrkh+LlXXfO+kyJL704jkL
	 ENHY9zwVKf35+nDJhEt/tAbYl/8o7YjDlgmvRI+cbqokhwGAIV19HX4FyTVA6HYCT7
	 azjS8CVRKuG7Edabcy5flffprkvoNkbCjvnNMjWCHHG8Bl4zid0USqFfP0Erm9Rocn
	 WbAOLT69FG36A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YBVtW31GQz4wj1;
	Mon, 16 Dec 2024 17:49:55 +1100 (AEDT)
Date: Mon, 16 Dec 2024 17:49:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the security tree
Message-ID: <20241216174959.723936b0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uo2e6_08KmGgkhoP/6v/.z.";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Uo2e6_08KmGgkhoP/6v/.z.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  8cd7488492ef ("binder: initialize lsm_context structure")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Uo2e6_08KmGgkhoP/6v/.z.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmdfzZcACgkQAVBC80lX
0GzjOwf/UqWA4P5NEhbrZ7w7l/vULsZJt2nNYXV2EaL1e5FOH4HnJoGokZCFVdgk
QiTbCE3H8yFaW+xlb/Y3k31dGGL7kpPhb9PPdHSouwuUVfyL2eeWa8IKnmwbjamH
WTlM/YE35DcM4PPMEV9IU03i7tUGFvC8DGBWsIjAfTAjAx3pynWRJkgCyPmL76wm
5g9fZCK64CBSbXtsgJJj+623NZTqA6HjCfR3ykUhmxkJ0+FG+tfZHIgIuS5MpDZw
tezOEtfqx4GF5wWEYjW8oTXInl5i8tFc7xSy5Sl2mpVCM4ftf5YL1hBwfR6Y/EGc
C2ISSmJywNy6zJQaEJeAhDKzzZZV+g==
=2qpJ
-----END PGP SIGNATURE-----

--Sig_/Uo2e6_08KmGgkhoP/6v/.z.--

