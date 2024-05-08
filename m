Return-Path: <linux-kernel+bounces-173201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E038BFCEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 14:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23A328527A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5296C83A0D;
	Wed,  8 May 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFRmtvAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9662577624;
	Wed,  8 May 2024 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715170205; cv=none; b=hSN0OhBQ+TU5a5iPo5XEXdYGsn2MVvTYXNkXznK+OhwVQob4z66Y/lSDlMXlnrO7M9xlfL9aJnAHomDsW3LxtbuAs9V9jkJrjENqTIaasObFzOlvuwgm/XiJ1S3kC1cajye8oMdTTlHzeLRewMZyU5MD58Kt8qDNfv4PDeh5csg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715170205; c=relaxed/simple;
	bh=kwnYT2wo58prA+lZzMCkxAtLyxPi8IBUAGWJcnItH1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pht266QjXAz9+vayzLBWeuewZKEVRYGUJ6iKgTCzozt56/tHenlUuNQJnSfS4Sipy7IfObKGPG1G2urmhnu2GFuSBueaf8njOl+BEUPKQ3TiBiyQMV2BnJBqAlex5UJJkBeiva7IEfo7vKbDyYSzHYKhrB6WHBET2H7iNZfHWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFRmtvAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928BBC113CC;
	Wed,  8 May 2024 12:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715170205;
	bh=kwnYT2wo58prA+lZzMCkxAtLyxPi8IBUAGWJcnItH1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFRmtvAKS3X5wKKcVv+p06SnJ4YLBj5LYkRBjqxtlhg5qCI4c5zTIx4yHZa3KwR43
	 qItiBy7xurUJsLUbWJ/FGiAhl+CAYk4ii/62LKWbxjcBOS6heFlVqqUbChjN5YPzIO
	 rroOvedostUtAB2KE5VYbiXu3Jo8AK0pabcXURpMx7vid8aoF3Ttrz3oAf68P7+0Zo
	 gTwAt4sS5+QHJEmQsa69W8mVerVzADysIctXKfI9Rb4M3s/mscwyih95er3J2pkMLk
	 zSLZVic5BP3RdI59r6wTXoeMfVypsBa/Mg/UVBO41YnfHjNS91ELyB6zzIjciUNmEQ
	 73GJJjLug9paw==
Date: Wed, 8 May 2024 21:10:02 +0900
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Neha Malcom Francis <n-francis@ti.com>, conor+dt@kernel.org,
	krzk+dt@kernel.org, kristo@kernel.org, vigneshr@ti.com, nm@ti.com,
	lgirdwood@gmail.com, marten.lindahl@axis.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, u-kumar1@ti.com
Subject: Re: [PATCH 1/5] regulator: dt-bindings: Unify compatible
Message-ID: <ZjtrmqtB0GuLZRt5@finisterre.sirena.org.uk>
References: <20240507122158.3739291-1-n-francis@ti.com>
 <20240507122158.3739291-2-n-francis@ti.com>
 <20240507211112.GA1053164-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="caxhegAuDCKMrwiG"
Content-Disposition: inline
In-Reply-To: <20240507211112.GA1053164-robh@kernel.org>
X-Cookie: Accuracy, n.:


--caxhegAuDCKMrwiG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2024 at 04:11:12PM -0500, Rob Herring wrote:
> On Tue, May 07, 2024 at 05:51:54PM +0530, Neha Malcom Francis wrote:
> > TPS62870/1/2/3 devices have different output currents (6A/9A/12A/15A) of
> > the TPS6287x family. The I2C addresses are the same between them. There
> > is no need for different compatibles for each for these devices so drop
> > them and add a unified "ti,tps6287x" compatible.

> And s/w will never need to know what the max output current is?

Yes, this seems destructive of information for no gain - if anything it
makes things harder to use since you can't just use the part number and
instead have to know about the wildcard.

--caxhegAuDCKMrwiG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmY7a5kACgkQJNaLcl1U
h9Cz6gf+OZ5o3pv5ICQZyeSnJcTOwr3KdfmWlw/dEuNym7cLbv2G9BUWmV0TmaOG
BzJL1ke/igCjO+SY/aVQof+t5ACCrCXPwz9OTSzZTZkI4Rgy+l2RUM7vKFTQkOdL
kmV5ij8UgEjTqSjCRtFTwqZ5piCtdio89hzhTwK3iu/eg3vg6e0CSMgWI2XXntxP
sx5JddCdUwsoYsjWISeRFEu0jdo6lDU6HrDTgqVsQvDDAmdfmWSUzTHS5lmkaXGA
RPGzWKeezFvtDieR+Nx5PI6DxqpnJ/eoaxOOlDXAvRPyIDZfQNw9/JQCWWp3en39
G7o58kCzDspjePtw1zrcqLZw46snuw==
=6RHm
-----END PGP SIGNATURE-----

--caxhegAuDCKMrwiG--

