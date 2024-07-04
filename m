Return-Path: <linux-kernel+bounces-241433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42721927B62
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C801F23FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2961B3736;
	Thu,  4 Jul 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5RzLPrq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D4F1AE859;
	Thu,  4 Jul 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720111444; cv=none; b=t/vB19nI7NAqeHdoac3VLb/vzrHCukdn7al47rvg0eFveW9MNkvxRiN07JJrnt9V5sQ42io7aCnTR4qxQ6Ptbd7kN9X4YKVimJcu1S4xMXMqdJRUEUCVGNVUeh5iOAhTNL6sPrU6PnESHdym1XqXQal6HDmkkLMwh0sH9p4FVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720111444; c=relaxed/simple;
	bh=hLebRaAM36NHuqbUZi6dU7R+OUVeX5KaSf0xNzbyg6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzJ/zMWDI9F4N6OcrVDCDdMl/O20uQlGGyFq0tsU6xnSeG74EN3m2dnu+ccE7cL7FUEdfK41kOjswbBJI86efjHXJoLBA7pFcMLyVapGlMa1BvXPsGbuX/9yKcg0QyV/SCPIy0KBdW+J4BTkPNEA06ggCWdTM9tAWf0KGy5/CVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5RzLPrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB9DC3277B;
	Thu,  4 Jul 2024 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720111444;
	bh=hLebRaAM36NHuqbUZi6dU7R+OUVeX5KaSf0xNzbyg6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F5RzLPrqO2U+dzI9F3fWtgHf6lPKonEtman3EV29DVll0B2d8sA04N3akCP5KlsSa
	 duUR87C8W3RFefmVKx+UrFslYxTfoivs5Wx8DIYQC6LZEYMTz69kW5W5s0qpsr+BbS
	 oVyP6otxODUUMkJ4BwL2HNeWh4j3bZwGcWY5GyC5Dpu19WrUCBnUcvbZu694xEsmGJ
	 u7bObgwgZcCIHgLhejvF6MjtZXAvNw3HTHOrTEzHq/GFLNOAdbMqtRGxB9FnDhCuuS
	 H4mD/zxL85WQKf68n/fWAZgczj8giZIeIdn3xguL0YITi637nw6tTJ8VrfdIRwIQsR
	 R2jcpebMXhETg==
Date: Thu, 4 Jul 2024 17:43:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org,
	linus.walleij@linaro.org, dianders@google.com, hsinyi@google.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan
 ekth6a12nay
Message-ID: <20240704-garage-thrill-6834f7ef079d@spud>
References: <20240704085555.11204-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240704085555.11204-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0gW4uFFvq9OjeSPs"
Content-Disposition: inline
In-Reply-To: <20240704085555.11204-2-lvzhaoxiong@huaqin.corp-partner.google.com>


--0gW4uFFvq9OjeSPs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2024 at 04:55:54PM +0800, Zhaoxiong Lv wrote:
> The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that they have different
> post_power_delay_ms.
>=20
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--0gW4uFFvq9OjeSPs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZobRTwAKCRB4tDGHoIJi
0rbAAP4sgBrY4rADyU1gV0eK2FbqhUeamyhGPsRhlmomx6rdmQD+NhzqQZ9nkf2g
4TV+3Fr6wPfefh81lEQwAm7FjMGf7w8=
=cB44
-----END PGP SIGNATURE-----

--0gW4uFFvq9OjeSPs--

