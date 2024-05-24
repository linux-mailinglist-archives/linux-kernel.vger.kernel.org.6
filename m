Return-Path: <linux-kernel+bounces-188992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863FF8CE969
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32BC1C21496
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17EE3BBF4;
	Fri, 24 May 2024 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YseXi/5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6AB3D994;
	Fri, 24 May 2024 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716574805; cv=none; b=JEdaJWPaOygZMxav7tzATghmqf41bK/jGpmtwDuKXBG6/bzJmgxzCvk+Iko9A24QnAcEjunx7h4XkYH8ioJTvQj704SKNV4TuHOLsOmSth2b47cPbt74nqQL2+4GIFPw2oj68rpq9djZ4wixYFQMGJBqovFkO0vBsWJdTgqJ8z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716574805; c=relaxed/simple;
	bh=+8Fbxlx5eo/oIR6yTo80tZtLDDGQUpDOc4GEdoiNLys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sj9GQySfJx0GbIyAchNgQF7N0Tcep/zXf/DyafIFQ9PPyDfT1BJ/i1hWcUPs7fWEhoWWdHlc6yKhBpCeLnI5hH0KyHDb8KTNi7+W1voey9tURV4hzZCufKPkx78pPPiELwFXCjJQ3+EyObO0osjQA43+d+YNhApcVpQ7XKCZSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YseXi/5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13E7C2BBFC;
	Fri, 24 May 2024 18:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716574804;
	bh=+8Fbxlx5eo/oIR6yTo80tZtLDDGQUpDOc4GEdoiNLys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YseXi/5h2BMoThQr36j8Sb1Zo9jVbI43GB4WuAYe+GZ1F6tIpcKa95PSSl1ckFHub
	 EPSwqSZV+4kazDQtmalMcKzBTHJ067ZGR2tU7+w3zRizrVb5jqind3yJ/LGz+r3x8r
	 CTSDG/SQoQprTgjvkjxoebwN+bGMjHn2fVCipOvGH2/a5nqkLbgrqVQ6w+l9nErGXH
	 aHRsGhwx9GdEXJYUTihb2qY1LLYKp/hPHxbRzlsMWm/SQwDB5pKMcMCgsR4TnmcNkA
	 MM/yYOpAnYogBJuJnGztg8+LCh6tJNVO7O9aqVNFU5gbMjaLcGBRxjELoH+TNFtcUc
	 LrIOscbZ2nGBg==
Date: Fri, 24 May 2024 19:20:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: aspeed: add IBM SBP1 board
Message-ID: <20240524-engraving-scrimmage-4b7e470fe5db@spud>
References: <20240524105929.557129-1-naresh.solanki@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ikdhEzjYvs4Y3VNX"
Content-Disposition: inline
In-Reply-To: <20240524105929.557129-1-naresh.solanki@9elements.com>


--ikdhEzjYvs4Y3VNX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 04:29:23PM +0530, Naresh Solanki wrote:
> Document the new compatibles used on IBM SBP1.
>=20
> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--ikdhEzjYvs4Y3VNX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDaUAAKCRB4tDGHoIJi
0ke8AP9eoKw/VC5gTmKmKg2tNZmY6NF7Daql17nntRTwULugFQD+MOhoqb2A5sgU
zkv569pLnAS+0M+eL6heZfvgEmS8eww=
=UaWu
-----END PGP SIGNATURE-----

--ikdhEzjYvs4Y3VNX--

