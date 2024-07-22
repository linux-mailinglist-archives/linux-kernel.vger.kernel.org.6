Return-Path: <linux-kernel+bounces-259193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6D939270
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550571C21588
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B467B16EB4E;
	Mon, 22 Jul 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnTA9Xy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F52907;
	Mon, 22 Jul 2024 16:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665324; cv=none; b=dn3Vq49r/f+LzFY4/P1VCB1zlLeU6VPVbBa9Pv1zfEHrEdZczokpSfNkq8tOZ8knmmuQHfmu1Oflkdrge73aBJgX4HxKPJq0pRT+KlDS51tk7G40/r7hADifTyNyWYfNCU6tu1IQhBNfK8O6SzTueN2VS3I0Bzew0YIa2ayNtDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665324; c=relaxed/simple;
	bh=1Ui12/JEdTNrgZsebMx278fp38w9xdj3GygdGgTyCcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9nMFWjMypEQhhqSPw1g8+TR3rR/I8FCXdI7KtqAzePLP70DpVfyEx3AaeSyUdAFZ2f4GgX+pfSV7mHT0gAK6OQ+nyQfvqvhAYCKzY/QqbF8YgVGEPUMTbsMD6myH8twwHMi0+cygGizNCtFOdAtFBt4RwpTwHY3rwyYEbPdkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnTA9Xy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE01EC116B1;
	Mon, 22 Jul 2024 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721665323;
	bh=1Ui12/JEdTNrgZsebMx278fp38w9xdj3GygdGgTyCcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnTA9Xy0VJkI+k7ewj4rBrofbGDLfxK6Qwy7NLwHKOsEjGrcAtz0DHn3eOsWdJGD5
	 eCmRdH2nVAPJ53TZmTnfep0mDoRlkZmEDqZimyF++b2RQDCQ1TABg6GVmGx9JmMEm/
	 GniEBVINnZBMBKQ0FYvxmTJoAH9fvKNfYfrlWOQ4xTPK9YO9OXi3oToTxP42/Krl1S
	 G27OJ8L7JFbXkg//SzgJGU+ll40h7nkg5ETWIA/OGwrp4hq7ziNsEfgRjyjSXzTRvT
	 espWPhiWzNxk9CjbthwcFhEpUKAH7X5IB1FRr84QPBdkcSKeEYaYmJWtLtidJ4Swat
	 PxT0arU/eCvjA==
Date: Mon, 22 Jul 2024 17:21:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Potin Lai <potin.lai.pt@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Williams <patrick@stwcx.xyz>,
	Potin Lai <potin.lai@quantatw.com>,
	Cosmo Chou <cosmo.chou@quantatw.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta Catalina board
Message-ID: <20240722-backing-scrooge-cec9336b8acf@spud>
References: <20240722145857.2131100-1-potin.lai.pt@gmail.com>
 <20240722145857.2131100-2-potin.lai.pt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+jW2CHhkgUeiYRk1"
Content-Disposition: inline
In-Reply-To: <20240722145857.2131100-2-potin.lai.pt@gmail.com>


--+jW2CHhkgUeiYRk1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:58:56PM +0800, Potin Lai wrote:
> Document the new compatibles used on Meta Catalina.
>=20
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--+jW2CHhkgUeiYRk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZp6HJgAKCRB4tDGHoIJi
0mxeAP46GmhT1+vRHAhLF5mPJH7wnCs0YQ/3g20ecPmPbVLivQD/X7bg129rbJ/F
Qo3WLzdf1V43M2PlyO+DUd3hbl4xewg=
=fx9l
-----END PGP SIGNATURE-----

--+jW2CHhkgUeiYRk1--

