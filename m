Return-Path: <linux-kernel+bounces-181334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBF88C7AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 18:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3911F214D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 16:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA28464;
	Thu, 16 May 2024 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPH86tQY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE64691;
	Thu, 16 May 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715877880; cv=none; b=kpNO2AGurfaenW0l68GX0k5F/YvG3QDcmf3zMKtv2Xn07oFvPaIRmFmvRfTkM9lk6yhAMNcPqeJmxXmdcD7PvS9q/umca6Cspb2ag+Q7BYSepdhmxHjcec7a2u+DML3VUMFzVnXPrTTof65/yM4zc0TF6yqofaDAs/mWhTewujM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715877880; c=relaxed/simple;
	bh=/pARYUQYKZlIEe+lzeqOG3LjBCS679vNc/Y1OvbTZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=galfxBa2lPWxKz+mcXCn6d6yGCco/HBVGh76HdDkh9fVmnJ3EnIYzzgksKsMXQlKo0EtcqoSDNh4mb61QIhwEhW42mGrm3yM0m6x0S/61oHt3Z0kQF6kWcHEk6Afa52DHeUO2zURhWAyxPeeZnYvsCD6slne5jcPa/DW3obU4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPH86tQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5094DC113CC;
	Thu, 16 May 2024 16:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715877879;
	bh=/pARYUQYKZlIEe+lzeqOG3LjBCS679vNc/Y1OvbTZeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPH86tQYR6xXHGbAjJqR5uFfFZTKQCJPJ32JBPja3MJMnB2dKCMki+wLHY0DF0vnQ
	 rwO4ZjbmlvF6QRogqX4kDQJUA6UhGcVQqczKA/B6JKy4hNCzEOID7QjpjcGcy816Yx
	 ti+naaJPelDWy/LS3j+sGSblb/icnQ0KAaCumAV1l7VysLRMjAVLDbEuicrD1au1u9
	 W0DQ7eX3nMUJAEcpis4GvuJDz2HaftE//nlLkeuiNXyMFTOyhDsy7l+v2z+O6COkPQ
	 5ZGh2TUgKULkbOOUNmHBxuQuyYf34L6kT7u10mBHZklRVntKihYCIxIW7wNQg2oDYP
	 nl1cf3+WSdPjw==
Date: Thu, 16 May 2024 17:44:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	s-vadapalli@ti.com, rogerq@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: ti: Update maintainers list
Message-ID: <20240516-google-uneasy-26689ba09e54@spud>
References: <20240516054932.27597-1-r-gunasekaran@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CDKkeplkW31DdT+L"
Content-Disposition: inline
In-Reply-To: <20240516054932.27597-1-r-gunasekaran@ti.com>


--CDKkeplkW31DdT+L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 11:19:32AM +0530, Ravi Gunasekaran wrote:
> Update the list with the current maintainers of TI's CPSW ethernet
> peripheral.
>=20
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--CDKkeplkW31DdT+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkY38wAKCRB4tDGHoIJi
0vduAQCjBpJW7uMQmDVo0mRFQD44wXWB75Qp1QJORAxJ4zgyKQEAmxUqrGnfSt8D
tIm5YY7WALxWFizNcrKITgEthlrlUAA=
=Wyp2
-----END PGP SIGNATURE-----

--CDKkeplkW31DdT+L--

