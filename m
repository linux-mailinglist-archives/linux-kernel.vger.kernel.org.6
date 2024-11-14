Return-Path: <linux-kernel+bounces-409861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D59C929E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E676281D00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9101AB511;
	Thu, 14 Nov 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOrCiny+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47D21AA786
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 19:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731613622; cv=none; b=EFKgL7tU6E+GhTQYi4zjnMJWne1QQbpi8YCo0lWcG8zLGrfDzRkVUf5JVljPtJ9RIeF/PENrJlWDBx/rnPo4wDZUJ9O/Ghn2+j1mQGGt0Re0CAfBAzqstRaA2pwT3ndzYv1AQXkpIjWGsd5hp0x8ZiVoRkMe/ftaqwJKIrS46og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731613622; c=relaxed/simple;
	bh=Gjzox5SW0ZBFMCoYYELBBxTIQIhByOTrD2ZJcxcGlOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tz7IpEspexpAN22zQm3SnGkdtnn9BlR2K1lcJ7u9rgveCk32H04JwkYnhCcb0U2IRapo+d7e84MkiRnTDV7ITjnv79SqgTq0LrwFbHYo/X1ZHAtNmvr0R5t5jMUqSUuAqj0Y3rcZ9g0bkjzvfPgfy6Bo/l3Vp09X9YP0A8FJ56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOrCiny+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA76CC4CECD;
	Thu, 14 Nov 2024 19:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731613622;
	bh=Gjzox5SW0ZBFMCoYYELBBxTIQIhByOTrD2ZJcxcGlOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOrCiny+S5/iDqvnzEts3OjdvmummSirSW4WebBrubi6/8clwxpwxZUEKm9+0Odce
	 yC2inWKyb0shenbQh/pSZSR64L24xkxvnq+yx+I3ZUq3kqpoaAmXA6m7qEefzXmDsu
	 scu/gVSyUhExHh4YqMQ+6pDqd0EZ6vZ+Nurvm7eyfLIKXMjS1Tty0YUvsMCepe9ywS
	 5UXZjhON41gipFxjuU3Rnrk2gtPAfmR+y6k8kupOeDLl1J+uWZcDHv1dpAVKwmvxoC
	 wX4uheIik4vDKNsBJwqQ7mLVBGSmDGSbSNYwuiYrORA1K1Jk6o+dRt1iSJSpapQ4IJ
	 GShANoTzos9XA==
Date: Thu, 14 Nov 2024 19:46:58 +0000
From: Conor Dooley <conor@kernel.org>
To: CL Wang <cl634@andestech.com>
Cc: alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-kernel@vger.kernel.org,
	tim609@andestech.com
Subject: Re: [PATCH V4 RESEND 2/3] dt-bindings: rtc: Add support for
 ATCRTC100 RTC
Message-ID: <20241114-slam-observer-61f978d2063f@spud>
References: <20241114140023.3534980-1-cl634@andestech.com>
 <20241114140023.3534980-3-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6i0rY8wHQ7vTr45b"
Content-Disposition: inline
In-Reply-To: <20241114140023.3534980-3-cl634@andestech.com>


--6i0rY8wHQ7vTr45b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 10:00:22PM +0800, CL Wang wrote:
> Document Device Tree bindings for the Andes ATCRTC100 Real-Time Clock.
>=20
> Signed-off-by: CL Wang <cl634@andestech.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--6i0rY8wHQ7vTr45b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzZTsgAKCRB4tDGHoIJi
0qR4AP9phbB0JhUoS2WDrZPBv/XLAkYfDbswhw1xknXnzvg30wD+PsfMc0zVohKl
/33av5aZPpL0Mf51WSl425idQqjBMgU=
=uI+O
-----END PGP SIGNATURE-----

--6i0rY8wHQ7vTr45b--

