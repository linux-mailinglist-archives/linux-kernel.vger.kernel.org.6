Return-Path: <linux-kernel+bounces-223004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D4910B96
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EEC72874A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEB01B14EF;
	Thu, 20 Jun 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoHSjzSq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7713BB50;
	Thu, 20 Jun 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900026; cv=none; b=s3bqIYXJwb1EvO4rjnZgL/NisjQpMDQE39ECOgvnmAJDtt8ceEmAXMQzqT/lgJntHCtjI/2BwXSLZghzYATPqYX8kwnVJ9Z+tcWTnVomAl2LoeN18FnhjUpNppx0KiBUgEV0/oieUmpXwADkCl87Jfxvwe2yLaryYf7Q69YhtHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900026; c=relaxed/simple;
	bh=OXkO016wMCWKZEPrcn0q2ULLa+4o64CIGf2MO9OVFKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMv6NHMQx9MoWGAORnGb2cys+N/olKq2Jv0F8xLHR4kmfMmlK/d7WiM3mbTpOW3M8B+rtkagvyYkTjdUVRU7JnQXcc/+HxJQ1Hz7Qlt9uW9TVvcI8xmF5NJlyp6AWGpup6gevuilmsZQs08pebz+FTUIP3bn5ZmEnvqkhCOupoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XoHSjzSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B720C2BD10;
	Thu, 20 Jun 2024 16:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900025;
	bh=OXkO016wMCWKZEPrcn0q2ULLa+4o64CIGf2MO9OVFKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XoHSjzSql0shKa7qinh7FZBL6kqMBbKqpV7iVzU3iYf/4nW1TrYdn6DClw+vb2/y0
	 ANBUK3llKqB1s8XCrMyTPcqZcG2QtGoJO61K7yUI5VcnY7eVLR6RgDLB63TvYR+CGw
	 cRTFqCFy2kOsOVYYo+XOc6+faZdHbh+f4fGiqZQUNfXckDpQkChTAXvx1rMisor+bw
	 UjZWtnZ88cKGci/4YWzY8WVdZkIavmLqcb4z+hsmoWeiZT7CwMo2rGgB4Y8RbYxtvs
	 35BIC3qV9re6yk+MQEvPoUZkDT+2neTmV2bLLOulqbQEBsRzFGbN0t5TcX773amSFs
	 2q2Omrro/quIA==
Date: Thu, 20 Jun 2024 17:13:41 +0100
From: Mark Brown <broonie@kernel.org>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "rppt@kernel.org" <rppt@kernel.org>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"jbeulich@suse.com" <jbeulich@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the memblock tree with the origin
 tree
Message-ID: <db13f2b7-88da-42db-85ed-d78cdd5f6c62@sirena.org.uk>
References: <ZnRQv-EVf2LQ1Cjv@sirena.org.uk>
 <eb58b1b2f84444acde3f9e25219fa40c73c499f8.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IrRq9jtI5uaLbfFM"
Content-Disposition: inline
In-Reply-To: <eb58b1b2f84444acde3f9e25219fa40c73c499f8.camel@amazon.com>
X-Cookie: You're already carrying the sphere!


--IrRq9jtI5uaLbfFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 04:07:45PM +0000, Gowans, James wrote:
> On Thu, 2024-06-20 at 16:54 +0100, Mark Brown wrote:

> > + 	if (WARN_ONCE(nid =3D=3D MAX_NUMNODES, "Usage of MAX_NUMNODES is dep=
recated. Use NUMA_NO_NODE instead\n"))
> > + 		nid =3D NUMA_NO_NODE;
> > +=20
> >  -	/*
> >  -	 * Detect any accidental use of these APIs after slab is ready, as at
> >  -	 * this moment memblock may be deinitialized already and its
> >  -	 * internal data may be destroyed (after execution of memblock_free_=
all)
> >  -	 */

> This looks like you're deleting the check from the
> memblock_alloc_range()? The intention of
> commit 94ff46de4a738 ("memblock: Move late alloc warning down to phys all=
oc")
> was to *add* this check here.

Huh, git showed the add/add conflict weirdly then (it looked like an
add/remove) and I wasn't paying enough attention.  Sorry about that.

> Do you have a link where I can see the final repo?
> I'm not seeing it here:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
mm/memblock.c

The merge is still running, it'll appear whenever -next is released
today.

--IrRq9jtI5uaLbfFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ0VTQACgkQJNaLcl1U
h9Dovgf/SE8QVlTpey7KF/FSzIq0nyQ6+ye8Ujco5s/1tJxqps43leBVgsihFXJW
NhwocVg7L54xin6QBQU4kJiJ7kwA1gW1fS53KA4TpkK30liC1dkDUC0LFuFgwjqc
RhVuG1oVbcg+u9Nz4XQO4PN0JI+6dXJUSp/oxB8tt9OkVHY0rLsaeH/uT14ghlmc
5dmv6Y0o3o7ebNBMtSXB17L3xrJGcY/HZNPllmHj276kSDxWne1CH7IfyR6AHhMG
fnpyVOYDCnZh9BvYk5uTCkyCuALMMkK7NftEQqekgIRq7j9eW+GutwFu233w3ztc
IBfmIbyQ/4mMrq9v7GDPx+CufMPRXA==
=ls+v
-----END PGP SIGNATURE-----

--IrRq9jtI5uaLbfFM--

