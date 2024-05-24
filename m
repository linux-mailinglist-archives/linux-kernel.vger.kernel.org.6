Return-Path: <linux-kernel+bounces-189029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6D98CEA0D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 20:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889A2281AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 18:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1740856;
	Fri, 24 May 2024 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MiCPxA/j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A4A3EA64;
	Fri, 24 May 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716576535; cv=none; b=KJRfRcq6K+ZovyLz2zvvPtObM8oLUXI0kgsafDVyP0pHQpkxUxnVSQ2Q9LORwFoEnRK2Ep+pCN6Ka3nniDBdt9BZMK6eN4u0ru4/o01o3nsuD9yAOOFRJWEfXVI+WwaSJ6nFMPKefiAVseSHJJZf+ehuIEc9hd83MC6e4X8kcQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716576535; c=relaxed/simple;
	bh=lxlHJz99dUTH8Xnb2vIc4jSSd44hxz+bjwK14/n/B1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abvmO8Dn1MOktEauusN19xontklZYctHcYKuZZmcFPUTPChWl84WpTJfmeKkp7/4TFMqw+VU0ifqdDVNU8H1T7D23HsoNMk5JvZzp+DhXJH1IRDcZEanFZ1fUrDScN+uIoHsTSrJ+aC/Jx0K2vfLPKxbBCbvc0kYXMYCl+Gib2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MiCPxA/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6895C2BBFC;
	Fri, 24 May 2024 18:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716576535;
	bh=lxlHJz99dUTH8Xnb2vIc4jSSd44hxz+bjwK14/n/B1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MiCPxA/jaqMSdF2seJjpN3APs3t+lYldU7C6Ka7n3vnknegreiHSYZ8TN9aahwg0U
	 jKUI/sLVpOKWn4qWdwy+aK1WVcyQYuP5zQPIzCaCIqtGoEYXCCRRAMlK+mIwCXqKcB
	 AbS4KTbE+qbWtjTwzJKfp+hwlf3nzlTJyB+l+hdjUUOwbYmgPO9k8SbdHieojeGJq+
	 xcRHebML5264Sl17328jBIlEoY4vw3BZXHt7y9OahDYDK2YvJXlFiNdaYBqmS36S2e
	 o6bI+h4iRL/oUBxb/jXvG0P1qsjXhW4L88AZ7AhdEdWnbfGVdkmK74Nrxga2Ieg0QK
	 F2rDaj350GIoA==
Date: Fri, 24 May 2024 19:48:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Henry Bell <dmoo_dv@protonmail.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Zhu <michael.zhu@starfivetech.com>,
	Drew Fustini <drew@beagleboard.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2 v2] RISC-V: add Star64 board devicetree
Message-ID: <20240524-omen-smell-6c9349065883@spud>
References: <sQqtfYJc5p5nCV1CUpJC_eti56gLvmhqfMv4DY-aojB0sCARXzXRBveErmAN0spUDzvux3m5LdcmU-i4BfNDCCckVQfHLpH1QakaXdpnXuo=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hEGI675YtjtWgj45"
Content-Disposition: inline
In-Reply-To: <sQqtfYJc5p5nCV1CUpJC_eti56gLvmhqfMv4DY-aojB0sCARXzXRBveErmAN0spUDzvux3m5LdcmU-i4BfNDCCckVQfHLpH1QakaXdpnXuo=@protonmail.com>


--hEGI675YtjtWgj45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 09:55:37PM +0000, Henry Bell wrote:
> Add star64,pine64 to JH7110 compatability
>=20
> Signed-off-by: Henry Bell <dmoo_dv@protonmail.com>

$subject here is wrong, it should match other commits to
Documentation/devicetree/bindings/riscv/starfive.yaml.
If there's nothing else to fix with the patchset, I'll fix it up on
application.

--hEGI675YtjtWgj45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlDhEgAKCRB4tDGHoIJi
0l5NAQDbIQqdzUUrUSi0rQv2qOz2BMeroa8DhKOu1+kLveovJgD+M7xaaBjO7VR8
PYjjPm1SMAZJ0Qqx11M8B1xXKdCrbAA=
=VYeb
-----END PGP SIGNATURE-----

--hEGI675YtjtWgj45--

