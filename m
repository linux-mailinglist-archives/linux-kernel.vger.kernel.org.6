Return-Path: <linux-kernel+bounces-376636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F999AB442
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6701C22DC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7F01BC9F5;
	Tue, 22 Oct 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mheeIFrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270A1BC07E;
	Tue, 22 Oct 2024 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729615310; cv=none; b=AhIbLsmPAeKOkp9q4/Gn/2iHjU8oCPe9p1szCqsVMyAk4qgSRm/GjxjhFlAauCX/v2RBIZecsVwqRkDDF0L7l7xAfBBxfuPk2hSHxZnqRoR2YpY9aQ5msEdahbTOPqrXItBzxjViROQddlAbm2GMjnB3GA7dJyD90oCuHb3/DcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729615310; c=relaxed/simple;
	bh=EoHMsRQGMuLx+P7zRHzX1qTnz0At3UXNDcHYzQo11LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neFPiey8kwCizCvRet/2eNG6ta9rGvZwFiGKpSdHVMtPrNVNA6pItPHEJw8N3aaLbjgfeScABPxRVf8V7H9xJ+NxTAbiFLMR0VTTJZBn0VphmZli9kvvuoseljj62FRY9RMqvViNLfqKPAV9X4x98yBizQL0wXunN/pnEJb95YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mheeIFrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA7C4CEC3;
	Tue, 22 Oct 2024 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729615310;
	bh=EoHMsRQGMuLx+P7zRHzX1qTnz0At3UXNDcHYzQo11LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mheeIFrWDVR6zmPu0VxTdfTU066+am26va4z7qSRWIwYCxL1Ju1pY+feu1JqItBri
	 OQjuVtqZKV0JnHWd14mLckTWO9g6x5LupHnBFWIfBSOMMKtVEp+OBKCiRVz0Ahx/tu
	 ku4+UawUcLC12gH6Qs28lUYrc0kra27LFEYX2Fwv42mqos4hZvJyiUvTE+txNrMDlH
	 /7NWRvRkWjk7/CEoyTRuyRQUjYKUvheJF+Khb+krEKvhFAsrRCkeS7/N9P+FznIJR7
	 Rzk6zGvnhXjIAuh+xWsOLWcIiOMhI2wFEBU+kJcyGX5DqrVT2jKcmz1DUBHUzOA5Q7
	 DQA0nT7UXk+zQ==
Date: Tue, 22 Oct 2024 17:41:45 +0100
From: Conor Dooley <conor@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: Henry Bell <dmoo_dv@protonmail.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: starfive: Update ethernet phy0 delay
 parameter values for Star64
Message-ID: <20241022-amusement-overreach-c5d1d7fd797b@spud>
References: <20241022061004.62812-1-e@freeshell.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5v1eMG7g4H4NB0I9"
Content-Disposition: inline
In-Reply-To: <20241022061004.62812-1-e@freeshell.de>


--5v1eMG7g4H4NB0I9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2024 at 11:09:51PM -0700, E Shattow wrote:
> Improve function of Star64 bottom network port phy0 with updated delay values.
> Initial upstream patches supporting Star64 use the same vendor board support
> package parameters known to result in an unreliable bottom network port.

Should I add:
Fixes: 2606bf583b962 ("riscv: dts: starfive: add Star64 board devicetree")
CC: stable@vger.kernel.org
?

"unreliable" sounds to me like something that is worthy of going to
fixes/stable

--5v1eMG7g4H4NB0I9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfVyQAKCRB4tDGHoIJi
0mXyAP4hE8X6wR9mN1YBx29ScBPlWDTvKS+zXqMNQTvwHnCExgEAmFDWhu4p3Ljj
9iV7Tk8QmQBu2ixOzU6EvXethK5Y3A4=
=ZbHC
-----END PGP SIGNATURE-----

--5v1eMG7g4H4NB0I9--

