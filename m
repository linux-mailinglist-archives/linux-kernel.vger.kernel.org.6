Return-Path: <linux-kernel+bounces-325442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EB69759B4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 19:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626E0B2214C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964191B2ECC;
	Wed, 11 Sep 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUHz9zY+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F168F58AC4;
	Wed, 11 Sep 2024 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726077071; cv=none; b=qIIGYdVA26jDASnOh4V4AHBdea1NDxryeXBmNQ5O6FD8KhVlZNI/dXHortBN3q8/mGLvgyuFnE4JWvEbtmaNxHRRqG25GwLYx88+nuEZJWdpaLlUpJkaZmZe4dcSh7F/ii8aKJ3L1kii3nbIMGo2omokrgi7W9YTBq4ntnP6wfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726077071; c=relaxed/simple;
	bh=jxwQBUysz9Q7EEFtsFJfF5a7IMsu+1/MGz8NQqPXSOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnLAIVlPawTNp+BaEIERTbF9ZasFqWx773ifMoE4Br/XyNS90DdKM4PRI2Ty+O1ZyljjylQY+eOdiDNFjzIS9kPZCXfleZqmb11sQITWFNNKmcOm2mzXi42bjxVMJETFTgQA4AVBrzcJsP/cv5WboYoDYABZu5hhX3qFPLSPkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUHz9zY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD0DC4CEC0;
	Wed, 11 Sep 2024 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726077069;
	bh=jxwQBUysz9Q7EEFtsFJfF5a7IMsu+1/MGz8NQqPXSOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUHz9zY+4qPgtzUUz0U7VgO0sisWqpCSEAahkonml7txztZbBzy8VlwBsQLyE448J
	 yIjerS+zg94wxVCftG8fLu2EqbJ/8zrKzfT1CLR4hRGx5v9Mt4sq2PqjFG0ga0cEQK
	 wRbDa12yfcmlLvDNdrtzroOZxXX/1WxnuEZqe10WLNo5I3dKSa/HObbmVkOF7tARxz
	 Hk7/B1RoOmIlRRUM5TkZuDzLW9/hdY6mnzjSxH9UsKlpx8YPqoKu62dM2QFHV50bPz
	 n4P+9dJZeh7rkSOq6i4vlVKw32z88C73jZ0I8OvA6rOeYMlncdJbkiTzwlMrFcfLRi
	 povx8ZQXMe9rQ==
Date: Wed, 11 Sep 2024 18:51:04 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: krzk+dt@kernel.org, jassisinghbrar@gmail.com, robh@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	houlong.wei@mediatek.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org
Subject: Re: [PATCH] dt-bindings: mailbox: mediatek,gce-mailbox: Stop
 requiring clock-names
Message-ID: <20240911-unhappy-wifi-b0a851e261bb@spud>
References: <20240911104327.123602-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CQ/b7f5ZIzQi4s9H"
Content-Disposition: inline
In-Reply-To: <20240911104327.123602-1-angelogioacchino.delregno@collabora.com>


--CQ/b7f5ZIzQi4s9H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 12:43:27PM +0200, AngeloGioacchino Del Regno wrote:
> There is no reason to make specifying the clock-names property
> mandatory, as the Global Command Engine HW needs only one clock.

Have you checked to make sure that there are no users that do the lookup
by name?

>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../bindings/mailbox/mediatek,gce-mailbox.yaml        | 11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailb=
ox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.ya=
ml
> index cef9d7601398..ff5d010fbcf0 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -56,17 +56,6 @@ required:
>    - interrupts
>    - clocks
> =20
> -allOf:
> -  - if:
> -      not:
> -        properties:
> -          compatible:
> -            contains:
> -              const: mediatek,mt8195-gce
> -    then:
> -      required:
> -        - clock-names
> -
>  additionalProperties: false
> =20
>  examples:
> --=20
> 2.46.0
>=20

--CQ/b7f5ZIzQi4s9H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZuHYiAAKCRB4tDGHoIJi
0o+EAQCcEWUQzcLMz35NefAQk+aaUMBucsLaFZzMYFLYJnfNaQD/fVKxxCnZ0KKi
9m9LyaCWre8Vms/jz6ku4DYaJ9vRYA4=
=8WFK
-----END PGP SIGNATURE-----

--CQ/b7f5ZIzQi4s9H--

