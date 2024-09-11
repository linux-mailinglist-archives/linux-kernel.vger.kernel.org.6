Return-Path: <linux-kernel+bounces-324954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3578297531F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC76B286EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9171885B8;
	Wed, 11 Sep 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8WDeDsh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82D187FE9
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059689; cv=none; b=JiAs5PlsNkXCPS1IsrTAS67qe0ffecLaQNdBpePz0YREZXAAJQqTXPYYWx/kGPYQqz5/QX8GdPY5F91+El+ibMfftE9OSuU03JDhnTytf77WmhdWgM3gS+Tqd8IjwshSDd15UamuLWvBkwpU28Xsi1EWAsQTXrezwDhZ0jSxuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059689; c=relaxed/simple;
	bh=Y2dTRAXOnfot8iHJJvSaM3F37Qy2pbY1sDPyxAqM9RY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPqqc9kinBohKkF1MQ4VLBloV9qLKH/thghHyxUV0jl9+T9IrITsK55WomtkiEquhf6eSDJVOAEZCkU3mqzWryY1rY5GokMrveuwEOYWv8yqsYhleipVu1TPVi7CkM7VmrwSqW6Ct/rAAKRtUCHy36CHfhQ9dOI1YaOXJtxGSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8WDeDsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3103C4CEC5;
	Wed, 11 Sep 2024 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726059689;
	bh=Y2dTRAXOnfot8iHJJvSaM3F37Qy2pbY1sDPyxAqM9RY=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=X8WDeDshi7SHKKZ95fOu+lJ38GoslX25gjfFEY5itnaP7sKz24prOK7aLufuIoFot
	 n6zZrFxvIcE1HWkey3pikGTaGe56TCHOaDZf3PcfjVCO+RyPiS7msVmKcnyswa8ehq
	 cg58I1IaOLVH50FCPOBC6siboh/dtSDzMwcCeb8qi1YhE8/5F23O6eug2deO0YaFDk
	 bR2vYNSossRsT24n+LdE/nujAHQTT36SurP5+wgPEP2BRwbX75G3B6r0WT44E2kZLf
	 kjThaOTyUCmJdKA4Sw4iuUQXn9QO+bU2xEVEO/PDN7O0h+dev8cAZf9ELYH1YVXYQP
	 EfJ/4PH1OYPag==
Date: Wed, 11 Sep 2024 15:01:26 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Maira Canal <mairacanal@riseup.net>, rodrigosiqueiramelo@gmail.com, 
	melissa.srw@gmail.com, hamohammed.sa@gmail.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	sean@poorly.run, thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org, 
	seanpaul@google.com
Subject: Re: [PATCH] MAINTAINERS: Add myself as VKMS Maintainer
Message-ID: <20240911-functional-finch-of-competition-ad54e9@houat>
References: <20240910-vkms-maintainer-v1-1-e7a6c7a4ae71@bootlin.com>
 <68da3932-10ab-4001-a978-f0f54034a64d@riseup.net>
 <ZuGJyfhkQe93jKlz@louis-chauvet-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="zvk72urfd5k2etgy"
Content-Disposition: inline
In-Reply-To: <ZuGJyfhkQe93jKlz@louis-chauvet-laptop>


--zvk72urfd5k2etgy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 02:15:05PM GMT, Louis Chauvet wrote:
> Le 10/09/24 - 15:57, Maira Canal a =E9crit :
> > On 9/10/24 12:10, Louis Chauvet wrote:
> > > I've been actively working on VKMS to provide new features and
> > > participated in reviews and testing. To help Ma=ECra with her work, a=
dd
> > > myself as co-maintainer of VKMS.
> > >=20
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> >=20
> > Acked-by: Ma=EDra Canal <mairacanal@riseup.net>
> >=20
> > Please, check the procedures to apply for commit rights in drm-misc and
> > apply it. This way you will be able to commit your patches.
>=20
> Thanks for your support!
>=20
> I just checked the rules to become a commiter, and it requires at least 1=
0=20
> non-trivial patches, so I can't apply right now.

As far as I'm concerned, being a maintainer of a driver in drm-misc
gives you automatically that right :)

Maxime

--zvk72urfd5k2etgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZuGUnQAKCRAnX84Zoj2+
dqaKAYDkNQFuPF/ydzBRCY5L/EaV+kwp+EI2wR4ildCdpamijvnSnPFzyNu5sj/2
jrqXtacBgOqomm/El1eiSCam/4mfn5d3JfOTbRXYETFSYLFUbdYLKbGJn6HNsvgn
LKApumJbAw==
=KTgg
-----END PGP SIGNATURE-----

--zvk72urfd5k2etgy--

