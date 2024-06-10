Return-Path: <linux-kernel+bounces-208495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4243A9025CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838C6B26A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD6F13D8BF;
	Mon, 10 Jun 2024 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFi6707w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2712FF86
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718033861; cv=none; b=QQLs41+WqyvEKWHS113BdklEHM0EUu47KGhMZaNDydJAL11qYoqoU5yBroqHCqHNzEihVHyf0yH/14GxbxALxiUa/VsqhUYxb763vCwWte2auhGhd1wsS7fcnPvtxv8KLZEoK9z82ZPfEZMKv09NzLYTJWlUIVzxGuduQJIrIa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718033861; c=relaxed/simple;
	bh=DS3uBb7Unwhd1jiU6S/xkwKPy764hQ4TYvNxIj8Dvus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCgbWxp1Wqqw5MOxCMZ4Ip+2MI7ykoNqT0U7cSJjmADkHfh1OJGo0qQy1Yag7t0HmRF3s1U2qWweSbDV1ZH56+0FJr/huNr7ksdE2umDLCrUKV9wWE+SuZDgVMSWbg57b0unpVCfiyRPU20FRzx66crZA61gplL/N1ekxdkyfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFi6707w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93ECAC32786;
	Mon, 10 Jun 2024 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718033860;
	bh=DS3uBb7Unwhd1jiU6S/xkwKPy764hQ4TYvNxIj8Dvus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UFi6707wcUbSi/lMOM/1R/3w4Tp0Nhzr1BaLI7BOl+P6JZYyX8C7QoxmYJ39wbldC
	 3+t/MxWxvdx5yYbREMJzMAz2RUBROKuMAKKhu+9tsa6hQTZygr5lZl+Gbe9JMbRhCU
	 YB7IOee4GcNJLYCcQCAgKyWnN9H6McvJxFQpRMBgJ7Xce4wHeUePpOWzztdmRe7I8L
	 Oza/7bj9F+jkKZmJnmnPacw9cnpk/ZpLAmRx8bczk1ZHZ2bhZFnov3XvHGiOxIS3n/
	 Zyvc6IHupMLlQXSKMjbpU6tbdtehqHfbkVrsnydpkhOc1qzbrCI1VAT6lA6ZkzAhHL
	 eZBImHbP6TUuQ==
Date: Mon, 10 Jun 2024 16:37:34 +0100
From: Mark Brown <broonie@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel@salutedevices.com
Subject: Re: [PATCH 0/1] pwm-regulator with voltage table problem
Message-ID: <Zmcdvm7XbtU1JlQr@finisterre.sirena.org.uk>
References: <20240610120025.405062-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3aWJOhdwdUY4seBS"
Content-Disposition: inline
In-Reply-To: <20240610120025.405062-1-gnstark@salutedevices.com>
X-Cookie: Your love life will be... interesting.


--3aWJOhdwdUY4seBS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2024 at 03:00:24PM +0300, George Stark wrote:

> The situation: bootloader sets mean cpu power and mean cpu clock.
> but that cpu power is not found in the voltage table (value is between table items)
> due to different versions of bootloader and kernel and the regulator core sets
> the minimal power but cpu clock stays the same. CPU hangs somewhere during boot.

Why not just add this OPP to the table the kernel knows about?  Clearly
it's something the vendor set and presumably thinks the device can
actually operate at.  As far as I can tell you're only having problems
here because you've got a software defined regulator but haven't given
the software information about this configuration so it's got no idea
what's going on when bootstrapping.

> The core problem as I see it is if regulator is bound to CPU (or some other
> complex consumer) it can't be changed except by the consumer at any stage. So
> the regulator driver (core part) should wait for the own consumer to init
> it properly but regulator can't be in unknown state after probing.

If the regulator is configured outside the constraints configured for it
in the binding then the core will bring the regulator within those
constraints, some systems with regulator configurations fixed in
silicon rely on this for correct performance.  Regulators with
unreadable hardware are very much an edge case when it comes to this,
what works for one system will be broken for another one so we just have
to pick a behaviour that will hopefully work more often than it breaks.
We can't rely on consumers setting a voltage since consumers are only
expected to set a voltage if they are actively managing it at runtime,
other consumers should rely on system configuration.

--3aWJOhdwdUY4seBS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZnHb0ACgkQJNaLcl1U
h9BW6Qf/WIuMS8uIx2ZHM7+DDfzW8oMEPSZhAn+6hAHbZBFtXbaN9EV+/5XBs3Nf
8FxLWoXL3BAnNBWyjJ+9czOV1j9HN9tkafoxo18nQszEKymJ2YpDqV5bQr+02UpE
9RZkGX2nQneh4K8sM7wQkYCfSZL5GsrgnW8qDtOkDNyhjyZ08qZ9OhmHzmeg2EZl
FbzerDL3ScuXNIrGoTOz2F+VecOae2hA/rQ3/MyK5Ia0GGRA4wdQi66FmzUxY4QQ
WknYteXBroHzq1eBn08gdug5PdrLjBCN+m0VBUlI+bjAarEpehVH6/PTt3nJRypP
pKryb9HMCkXp8RfNmfqMcR1GigqWBQ==
=zXqV
-----END PGP SIGNATURE-----

--3aWJOhdwdUY4seBS--

