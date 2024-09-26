Return-Path: <linux-kernel+bounces-340796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFA49877FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E393286C51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313F15B0FA;
	Thu, 26 Sep 2024 16:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E18dPxWR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBFC13A24D;
	Thu, 26 Sep 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369932; cv=none; b=DQRJm/gORYzegr9dTlTTrYqleXpUSyKqWprMPkhktwiQ3Vm6byC6y1dXVGSq63homaNXWBgHGZbi2fZzf11LlnLEqXmj+oxBAzSPqbC6JWQxbUJEPhpUe7zZ1+rizY1DqteDgJ9QFgZ3Vj4ILpnoK8PdZuaqwM2l/Lr+hyZW8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369932; c=relaxed/simple;
	bh=WjrrpfRlzHwA2/o8EwWOQ0D0+skYwrSDG5khDdTfqZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgEv2OXyLc16bZzAzRNBPisNNia6LRtFR4KpgrOA9InWtncCUIGCs3h5o2gI9xr2uwEK7h4tE1Z9nh6Q3d4WNgd7Kgq4epOo7p83eUsuha8PzDE2lmtEfuHUG18fZkI3mp14GEcOkrN3+CqLIvQ99X+IxL2KMMryzoPeWk/6550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E18dPxWR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD69C4CEC5;
	Thu, 26 Sep 2024 16:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727369932;
	bh=WjrrpfRlzHwA2/o8EwWOQ0D0+skYwrSDG5khDdTfqZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E18dPxWRHyXnrNlbCGdintq6DVFxKwlPRuSSkQ21cQBCMokx9Q5C15zNu4EW/Gbs9
	 uMeFjL0t2AaedwskIr2ePSnwyY6dlIFQ+hN0AP/PAcdte/VR39P8whMeyiMWNSXaKk
	 seHyBptnC/aI3v9wufuNWFirNh1C08TeYTpn0E3i3KGJhdDBBmm40yICuQIFM5FK7x
	 5YjZ4q1zvybUl7dKNBKiR73oEgQUsKZH0Fh6UUOX8p/7rIVbOQDUTN5Rc9PiLRicA/
	 lUF2kxZ5GwHw3d3DYn/rhJUT16p3FOeIs0kZ4LLegGoTr52QX9j984RF8dddoT+vyP
	 aCLezXLN8aSBw==
Date: Thu, 26 Sep 2024 17:58:47 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lokesh Vutla <lokeshvutla@ti.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: ti,sci-inta: Add
 missing "#interrupt-cells" to example
Message-ID: <20240926-schilling-dividing-a84b379c601d@spud>
References: <20240925173432.1906168-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TwqPqcXiLo7Hkphr"
Content-Disposition: inline
In-Reply-To: <20240925173432.1906168-1-robh@kernel.org>


--TwqPqcXiLo7Hkphr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:34:31PM -0500, Rob Herring (Arm) wrote:
> Enabling dtc interrupt_provider check reveals the example is missing
> the "#interrupt-cells" property as it is a dependency of
> "interrupt-controller".
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--TwqPqcXiLo7Hkphr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWSxwAKCRB4tDGHoIJi
0otHAQCYu0Pv+khJOqtbBa4wmAOpTuD1kWnfrcdj3GpieayxFAD/YgQcdzimky0d
pwa6+6Yh/3Is//bAbV0pdBrIuw1syQg=
=TN6k
-----END PGP SIGNATURE-----

--TwqPqcXiLo7Hkphr--

