Return-Path: <linux-kernel+bounces-213072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349B1906AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB0C1F2371C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B70142E7A;
	Thu, 13 Jun 2024 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="FWVLNwpR"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12712143747
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718276698; cv=none; b=ubm5UFZytAFGpui+DSsPOXE6eriWKIj6f7csS0yjhpadb7fxagfnSEWIEJq70iWNuXxblD7CL8v+z/MronPhQ1W+8Eb4EsTXURR8UTrBLhmci3rfSmLaMKWEXEdhDLdIVlXvoqh4p12BjkWAa3nxQK+bJj+zWYa3DnCLGYEz4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718276698; c=relaxed/simple;
	bh=QSVxZIE5HRdX2PZ65tmi5cZl1eXGEGpB1NH67xGpsZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEs+Cm/cCpQZG7RyR8cqL9YW3RLibfNcl7k9lc52Y3bo0Rc8t4EKwBriWubwefT7KguqEm89lqEEbnHg20ZyOP0laanZwEJvSr1BqSiduc5CC4OiU6sPnMAqXz3wERpp4YXK8vVYZAXGO7fGIxjDCZCg/bk6qEWnfj2NpL5dONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=FWVLNwpR; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 6CDE91C009C; Thu, 13 Jun 2024 13:04:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718276694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPFN6Dd+Rb4MFGhC14cx0oFBxuxBrErNFRFfqvuYr6Y=;
	b=FWVLNwpRYJz6JPKdKp05j+vw9IFSV46i5t7cDqge8Gm+jo/bHVQwN/+/HpTq6oWpkMc9Bl
	3zVPTNBd/i7setkhVqPdBZW4+lHKlX4E25W9tfN4+8N4dTj9CGumwDQNL1sg25+dJxDM79
	WY0qpEnvpew5YRwCke7bmyoDqKKvrbQ=
Date: Thu, 13 Jun 2024 13:04:53 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Wang <00107082@163.com>, regressions@lists.linux.dev
Cc: sivanich@hpe.com, kevin.tian@intel.com, baolu.lu@linux.intel.co,
	jroedel@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
Message-ID: <ZmrSVax+fzXNKyiq@duo.ucw.cz>
References: <20240530114907.4836-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zPE+q47d1Rs+wmMB"
Content-Disposition: inline
In-Reply-To: <20240530114907.4836-1-00107082@163.com>


--zPE+q47d1Rs+wmMB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> My system fails to resurrect after `systemctl suspend` with 6.10-rc1,
> when pressing power button, the machine "sounds" starting(fans roaring),
> but my keyboard/mouse/monitor is not powered, and I have nothing to
> do but powering cycle the system.
>=20
> I run a bisect session, and narrows it down to following commit:
>=20
> 	commit d74169ceb0d2e32438946a2f1f9fc8c803304bd6
> 	Author: Dimitri Sivanich <sivanich@hpe.com>
> 	Date:   Wed Apr 24 15:16:29 2024 +0800
>=20
> 	    iommu/vt-d: Allocate DMAR fault interrupts locally
> 	   =20
> 	    The Intel IOMMU code currently tries to allocate all DMAR fault inte=
rrupt
> 	    vectors on the boot cpu.  On large systems with high DMAR counts this
> 	    results in vector exhaustion, and most of the vectors are not initia=
lly
> 	    allocated socket local.
> 	   =20
> 	    Instead, have a cpu on each node do the vector allocation for the DM=
ARs on
> 	    that node.  The boot cpu still does the allocation for its node duri=
ng its
> 	    boot sequence.
> 	   =20
> 	    Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> 	    Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 	    Link: https://lore.kernel.org/r/Zfydpp2Hm+as16TY@hpe.com
> 	    Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 	    Signed-off-by: Joerg Roedel <jroedel@suse.de>
> =20
> And I have confirmed that reverting this commit can fix my problem.

Bisected regression. Should we simply revert the patch?

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--zPE+q47d1Rs+wmMB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmrSVQAKCRAw5/Bqldv6
8ki+AJ9/bBY1k8ENQVWi+6+PKUSm2tkMyQCgoBbM80fLpif/6CObXI7quPCcmd0=
=i6Pf
-----END PGP SIGNATURE-----

--zPE+q47d1Rs+wmMB--

