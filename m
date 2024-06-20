Return-Path: <linux-kernel+bounces-222975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B497910AFF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B952A1F21A93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DEC1B1422;
	Thu, 20 Jun 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy3osjYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE921B0109;
	Thu, 20 Jun 2024 16:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899460; cv=none; b=iZHRvxrT/XpcAcWZm193b8t2tHY9ozD+LAHgKa8vRkgSO8Blr2RVkwmNfr6n/bBCD8WJWwCcfPY6AvQKyHKlNTm7rNvzpdoDaUZNO+OtqUjZLb/qsMBmGa1OCJLyOdHEFaeEpBRE2973g7GjOpftUqt0b1Lqbwb8LSCM4MljW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899460; c=relaxed/simple;
	bh=74NqYGGd8KI2bPBP3+dGSQ19ivy6M2TEhoWU0GlnEqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0a9NIop+8UABlRY+/XAxLcuPa0wouXrIW9MIFQAL0XxI7Snvza57ihcuaaVmVh09adUD1VeDN0v8ZJ9luKYlPxRMD2ZhplXyeXI7lmcGRu9MfKKIXU0hFF2frRVl8AZWKHV0MB0o568h6f973ikLsU0i8z1t8SwnLnkZ3bIKbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy3osjYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75606C2BD10;
	Thu, 20 Jun 2024 16:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718899459;
	bh=74NqYGGd8KI2bPBP3+dGSQ19ivy6M2TEhoWU0GlnEqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xy3osjYtMtOv4n09wrrbA58sHtdDM5j3mppgOlwztKVRvcZbLJ8V+c2QRGV5gFIQK
	 WsL653mUf8ApZamFXXs8y99CwtwjAQ66Ol/fWzbXnCbAHtmhovKiJRn/XoalzylSxW
	 HXoXyFFyPyRQg4/iEwfaSgTPDSLPgvHIvws/b9wd6fVPdc2qCk8MWXECCVcqMlUd4h
	 s8k+5afIc9MoZwaYkDuYpbchseBbQcMdHx4fylQ1OSJry4ieXEThPuVQmvA//Of0yQ
	 qvlWsf25O5wm6CRPrNFry++sfoW6+mGxpBQv/ZjNMthpBIhFIt1q/fwgTfpH2UB/b+
	 6XzMT2PN1emBw==
Date: Thu, 20 Jun 2024 17:04:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.co, dianders@google.com,
	hsinyi@google.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: display: panel-simple-dsi: add
 Starry-er88577 DSI panel bindings
Message-ID: <20240620-purgatory-used-9cf35fbc10c2@spud>
References: <20240620115245.31540-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240620115245.31540-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zWqryNqb5LRpYLSv"
Content-Disposition: inline
In-Reply-To: <20240620115245.31540-2-lvzhaoxiong@huaqin.corp-partner.google.com>


--zWqryNqb5LRpYLSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 07:52:44PM +0800, Zhaoxiong Lv wrote:
> This add the bindings for the 1280x800 TFT LCD Starry-er88577 DSI panel
> to panel-simple-dsi.
>=20
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--zWqryNqb5LRpYLSv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnRS/wAKCRB4tDGHoIJi
0qliAQDqRjWAXDaYu4eZpMN2pRQts2JnHENHQFIjDChsjCLm1QEA4sxFd8eJwhRV
ZQR4YvYWx2E6sQz8c+CSLYkRt05INAU=
=Xqyj
-----END PGP SIGNATURE-----

--zWqryNqb5LRpYLSv--

