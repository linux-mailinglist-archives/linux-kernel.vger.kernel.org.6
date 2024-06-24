Return-Path: <linux-kernel+bounces-227597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724FB9153DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49D61C20873
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01B19DF7C;
	Mon, 24 Jun 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeHWz0jJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49D11B964;
	Mon, 24 Jun 2024 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246756; cv=none; b=UMoSsFAsVi1N4PcFk9ftwlDa3oJUwe7xKdnjka5XSd4X5r47Wz5TDoNP2dIKJHXqnO+V9sESB4bBmIjL8O4oFmVOzPIQ+YQtbPlp9EERnrstJ4U1gCrAYZ2RyDAhonewvyIYIX3kiDNwCz9wpNRGNyL4hdYT3IbFRW6AoFB0Qdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246756; c=relaxed/simple;
	bh=Zs+yCXN5WcSvobPFe4rm+ty55pAOM4OvdQ9RT2GCmqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUkLa3wQ1vcW/kLO57RqOh8IkqLRznAk1Ua1KqmsS63G9Gm+prax7UGv/b0+SqrpXUxfrepfestxEMIARVDhkgWShfVa20B06uc8Z1o1A49qTZv0qYApv6/ZxbeU3+g29JireQzb0MhsMO+9CIO46q0DjzrltQuIG1tJmZ9TZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeHWz0jJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304C7C2BBFC;
	Mon, 24 Jun 2024 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246756;
	bh=Zs+yCXN5WcSvobPFe4rm+ty55pAOM4OvdQ9RT2GCmqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QeHWz0jJDNjYdXWC93Nn9kNwj+fGOseVk6zL4/tcHaESQhf+Ro0tVDTUv4afRAouv
	 ZXdz4lh1NkdIu7lUF5fd7kQ7Lj8SoNWCJUbkpDDZktCUXebFzix4kgasaBn4xpIP6c
	 Gn7VJG65KEiufKuhovn1nvPO5j96E9FYIXZu62/0lAN9MAADO3jv3IEqi4V7lp1jao
	 dfTaWdXAZMuVI7ZXS2zlpCugx4qW/k8MAtRDCGXMEKfzIpD/zZn26JIlEjh4KjlQDE
	 50J2JO/bBMhxJwlixCq0BcBEjdqDdeanWVovihEUhgH/Kge6QLU+tO7uiir2AAVUq+
	 xyYI10VqgI/LQ==
Date: Mon, 24 Jun 2024 17:32:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v2 1/1] riscv: dts: starfive: add PCIe dts configuration
 for JH7110
Message-ID: <20240624-abdominal-friction-7de13b1e2c72@spud>
References: <20240621082231.92896-1-minda.chen@starfivetech.com>
 <20240621082231.92896-2-minda.chen@starfivetech.com>
 <20240622-festivity-salon-bbad348a12c8@spud>
 <SHXPR01MB0863A47890F95A45559FD82DE6D42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wBQen4bwb2gJxhYV"
Content-Disposition: inline
In-Reply-To: <SHXPR01MB0863A47890F95A45559FD82DE6D42@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>


--wBQen4bwb2gJxhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 01:18:07AM +0000, Minda Chen wrote:
>=20
>=20
> >=20
> > On Fri, Jun 21, 2024 at 04:22:31PM +0800, Minda Chen wrote:
> > > Add PCIe dts configuraion for JH7110 SoC platform.
> >=20
> > I think the commit message should mention that the star64 doesn't have =
a pci
> > port exposed. If nothing else crops up, I'll edit it myself if that's o=
kay?
> >=20
> > Thanks,
> > Conor.
> >=20
> Okay. Thanks.=20

I've queued this Emil, scream if you're not okay with it please...

--wBQen4bwb2gJxhYV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnmfoAAKCRB4tDGHoIJi
0kDrAP9TQtHYnHFLdB9xD3m+he22q7sWAYb+Wz/hbJFoFZy/cAEAuTcNQMsmvwv8
sNM6GY5H+5O1O5tVU3RsPu9VCxUTIAY=
=H/lq
-----END PGP SIGNATURE-----

--wBQen4bwb2gJxhYV--

