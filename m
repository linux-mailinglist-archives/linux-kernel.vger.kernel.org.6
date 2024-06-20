Return-Path: <linux-kernel+bounces-223260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A619991104F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FB7288520
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2215A1B47D8;
	Thu, 20 Jun 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zhm5YAcC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F81B47DD;
	Thu, 20 Jun 2024 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906448; cv=none; b=p/8hn4S+TKjUciqUeRIN9p25Gwnwjto37vjvhuvopzsbyJujVn+Q+Gcp13A+2FgDfIzxIDXMqbUjBYSEMh163DhFWVP2ilowunXCwiOV9D6oF8GBRinn7SRen8cc68RAYMqr1Hmz772vcL6xA193hNjKqGXeUqAQrhGGPAhq+5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906448; c=relaxed/simple;
	bh=PHYYON9gAknurp08floUx+bMSi338hS5wI3klPwTlAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5bmuRN1FtpY3QjXKgu9Q+GQJcpWGsj4jgm0ZHofElkUhICkX1fGLyWhEIqck2g9tJDEEWWtgyW6NbcBFh/gBE12QDKrojQV6O0aahIm5OVCeAHoPddYbXcIFx9d2vwRxO+iwl6GMhmlJLN+LsCfI8xE0S5RjO/FOiRycuCX7BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zhm5YAcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89987C32786;
	Thu, 20 Jun 2024 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906447;
	bh=PHYYON9gAknurp08floUx+bMSi338hS5wI3klPwTlAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zhm5YAcCfiBgYmlpEgjuhIYl9lGqBJuY2+1oKcQdpRyDsmKZ1UT2orQxjvSu3L8hd
	 QFb1r2naCoXFRC23vMU6m3gRyuNqicGYewgzcOe9rUp/wyGBEq+v7xa2h/TMHWjRYY
	 y/QOMtRiwccFqSecC8oXSZUXL7AEgai8TCdtbD+moHu+UvfhzlNR6l+xY7c6Xtck9z
	 +eaJC2SXc2reJ2eeHjo0JAiLPuXiyxrO8lrEkT7sA3JFwz0tvnPO5t4tBW2dmbeZtq
	 MZxS5fFKbnMScfvqH1+4TejOvsuiKSJcbVlkPL+e4fc3x5s3GLzk+jE5NrkJUKcYtK
	 ooPxqjWcEPXxw==
Date: Thu, 20 Jun 2024 19:00:43 +0100
From: Mark Brown <broonie@kernel.org>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"jbeulich@suse.com" <jbeulich@suse.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rppt@kernel.org" <rppt@kernel.org>
Subject: Re: linux-next: manual merge of the memblock tree with the origin
 tree
Message-ID: <44ce3730-8e4d-42f9-8b17-104805e46f93@sirena.org.uk>
References: <ZnRQv-EVf2LQ1Cjv@sirena.org.uk>
 <eb58b1b2f84444acde3f9e25219fa40c73c499f8.camel@amazon.com>
 <db13f2b7-88da-42db-85ed-d78cdd5f6c62@sirena.org.uk>
 <e6f1bf73d13060635520c70df269c0b390352f37.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7RuoxHi0ILyCpckh"
Content-Disposition: inline
In-Reply-To: <e6f1bf73d13060635520c70df269c0b390352f37.camel@amazon.com>
X-Cookie: You're already carrying the sphere!


--7RuoxHi0ILyCpckh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2024 at 05:59:05PM +0000, Gowans, James wrote:

> Correct me if I'm wrong, but it looks like the if statement only got
> deleted and not moved, so this would need to be re-worked.

Yes, the merge in -next is wrong.

--7RuoxHi0ILyCpckh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ0bkoACgkQJNaLcl1U
h9CHIAf+P8G/kd0zpizwvBlm7xE99G5YTPZAmGkFtnu57NT8IORCxKuk9g4K621y
yoTfbHxdXnJ98FsnMO3MN1Oa9BN/DGUp1DB0tpmEIyB0ppdwYS7Xg0n0TSxX5adj
P/B02/dmqN/RBSUxtiRky+a7gXktyim0Am+rtZzLhLcL8WhBr8evL+l/pnrQqGcN
e2sh/3+wGA087pDMOQJXfKqxWqSvNbVuBttj4pVfFsygtyK8DImJ36kOJOPnldbX
UNikl2UCXX1QEwG7KUIuLel69BpZOlacvrcHtfTBWambI4aBiBAR1Yq+9k5O+BZd
FgDIsJSQ3885TOkjyP0CjNfoWp67EQ==
=LETL
-----END PGP SIGNATURE-----

--7RuoxHi0ILyCpckh--

