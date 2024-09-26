Return-Path: <linux-kernel+bounces-340795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF179877F8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40346286E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 16:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9A115B552;
	Thu, 26 Sep 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORb3UPhS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0D13A24D;
	Thu, 26 Sep 2024 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727369848; cv=none; b=nWKu5AiMFWCFfMlBGgacn8Ir+v1fn7Y4uGYu6FqDnl3zLxV12oKyJ7PLNli2xw5URf0cLMcOhrL90RQ2F7HW5W50qAmvNlA8LPPMNFuY+ooBL5CCzoiPptY0PtoUN0K/aKfzxtjcshcO5dosTigHa+cb5S1lqGnbURVC7HGsx6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727369848; c=relaxed/simple;
	bh=4fxs8NFpD3AWmeQlTcIxMrYZLvtu7wE0b6VfF3mHwR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5hPbkV0SkrauVgt61zIre1fst6yzHPVnAXGuDsg5mq7bGwmwUE3KmeElLf1kMA9R7PvbC5/9wvsYNQhXYdIywQUIR17MyEiKdVCxXcDVc9hojzo1g0+Th2VFJ+3xksgL2KfpGydnwtqrpjhYtyMXdiuJrMHP72VsW/aZc5Wg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORb3UPhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A255C4CEC5;
	Thu, 26 Sep 2024 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727369847;
	bh=4fxs8NFpD3AWmeQlTcIxMrYZLvtu7wE0b6VfF3mHwR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORb3UPhSxx3cc5HLrF6knwmVlvhuX9IGcUxS70mnclC3cqHwxWdLPUNa4ItY9SwYN
	 V7SaikqGKP5ZJgbxjVkxS6uuAxsynSWbXF4CqMef0/hQPsze+Lg5Rzb7I870+toqcJ
	 BiD5fuo+xMBo/ZFmPRHRLSLMO5SbKNa3Ncq0nRET3ty9R6P5tGjTPSUMT6tClQU+Dh
	 hkn16ahGiEl845QrmSq8pCMtCce6A3JKANjAkYze5UcmOvcJuDDEwUQGFSourl+9Mm
	 3dWiN1bHVeFk86AFNjV3nkS6Bg+EVbhPr3abhHHWkPonzqAPAbHLsHFuc76wYs18WL
	 s9TjVpIAeCPJw==
Date: Thu, 26 Sep 2024 17:57:24 +0100
From: Conor Dooley <conor@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: fsl,mu-msi: Drop
 "interrupt-controller" property
Message-ID: <20240926-glorious-spongy-29007d254703@spud>
References: <20240925173438.1906339-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7jj447Zq6p9po9oO"
Content-Disposition: inline
In-Reply-To: <20240925173438.1906339-1-robh@kernel.org>


--7jj447Zq6p9po9oO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 12:34:38PM -0500, Rob Herring (Arm) wrote:
> The Freescale MU-MSI is an MSI provider, not an interrupt provider, so
> drop the "interrupt-controller" property. This fixes dtc "interrupt_provi=
der"
> warning.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> If this is not correct, then #interrupt-cells needs to be added.

Seems it is correct, per Frank.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--7jj447Zq6p9po9oO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZvWSdAAKCRB4tDGHoIJi
0iFQAQDfVqdXimRSvdjiD0b2TLlQWPDybzi8qU1cNrVQZ06n6wD8CvCJmt3yptQe
6kKQrrDDKKAmKStmMLz00bazUo3W9gY=
=R14F
-----END PGP SIGNATURE-----

--7jj447Zq6p9po9oO--

