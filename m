Return-Path: <linux-kernel+bounces-183986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31708CA102
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB26A1C2108D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 17:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB091137C29;
	Mon, 20 May 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEIvrcx2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCDDDDA;
	Mon, 20 May 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716224648; cv=none; b=IoLU4AhIp1LtpfsxBFZougM6nnotfnPcx4QcYW0hY97DcmBhwnpepKdMU2eByCCGQzoOZFbrB9P5XqF1OvGezaT9srVM1iBcS63tyeYtEhFJd/A7dkV8Zm42CloeRFwvvMYpER14jP7qPBfU3jf9OIicE+h1u26bRFRJsZmin+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716224648; c=relaxed/simple;
	bh=ZFXgfExUtf/f5Ry4XgdFT2EMynkxeS6qR3EITMrGELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AziwQj1NG2gNCY7UjJuSOVsEEm2DfMscnN1Gir2/Ha6y4H2V5UDruVthi8nXW4AGseeP2LvT7tGmxUFfVkPx2ufZW6efLbhbFslkfpPwX+6OwF+/QbhIsVr1O7ZcbdTcvUroXfZm/H7V91uR74iwTz0QvVVwTK4b/HQHFNzhKfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEIvrcx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1AB3C2BD10;
	Mon, 20 May 2024 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716224647;
	bh=ZFXgfExUtf/f5Ry4XgdFT2EMynkxeS6qR3EITMrGELE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEIvrcx207xgxV2y1hG3ztZuvZjDqsZTx5ifIItvSP8mUYjICLLrqDrCBB45xh8JU
	 auUK3vZQ3EFXsQaTvmfrViL4T8T/x074JVuQ5DWLSZ9hy+pcGX5SDUTMfhnX0pg9KJ
	 uKR3X0RVIGhicPAcPn//OK4oWLAYrX5UPOIMkfd+B2RajpXFi8aoV3GGOi0Uvnqr55
	 zwjxDcv/RAxyNvnh6z6Ckrf+7lv5vW8DuACEyg68fYCeH/9Ij4FFP//YJ6s50Kb8m0
	 RL+eML/005Dzz83+6ubr55fEzLWc+PWY79DzfK/crRv/z9P0bB7wZE0iyFCYzSa2Xk
	 sUmhovd1H7ueQ==
Date: Mon, 20 May 2024 18:04:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-riscv@lists.infradead.org,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: cpus: add ref to
 interrupt-controller
Message-ID: <20240520-verbally-vibes-47604636b8db@spud>
References: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
 <20240519175906.138410-3-kanakshilledar111@protonmail.com>
 <171614715439.2941344.11264816105918092609.robh@kernel.org>
 <CAGLn_=tLdJU1F-i9YV5aCZQbS0L7y7Wu+_k6Dn=6HwH5JmZoMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n8jWxXrQpCGvcZN3"
Content-Disposition: inline
In-Reply-To: <CAGLn_=tLdJU1F-i9YV5aCZQbS0L7y7Wu+_k6Dn=6HwH5JmZoMQ@mail.gmail.com>


--n8jWxXrQpCGvcZN3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 03:09:44PM +0530, Kanak Shilledar wrote:
> On Mon, May 20, 2024 at 1:02=E2=80=AFAM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
> >
> >
> > On Sun, 19 May 2024 23:29:06 +0530, Kanak Shilledar wrote:
> > > removed the redundant properties for interrupt-controller
> > > and provide reference to the riscv,cpu-intc.yaml which defines
> > > the interrupt-controller. making the properties for riscv
> > > interrupt-controller at a central place.
> > >
> > > Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
> > > ---
> > >  .../devicetree/bindings/riscv/cpus.yaml       | 22 +----------------=
--
> > >  1 file changed, 1 insertion(+), 21 deletions(-)
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/riscv/cpus.yaml: properties:interrupt-controller: 'oneOf' conditional fail=
ed, one must be fixed:
> >         Additional properties are not allowed ('$ref' was unexpected)
> >         'type' is a required property
> >                 hint: DT nodes ("object" type in schemas) can only use =
a subset of json-schema keywords
> >         from schema $id: http://devicetree.org/meta-schemas/interrupts.=
yaml#
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2024=
0519175906.138410-3-kanakshilledar111@protonmail.com
>=20
> I have fixed the above warning.
>=20
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
>=20
> Can you please clarify this part? Is my base commit ID incorrect?

The bot says this in case the error is caused by it having applied
patches on top of 6.9-rc1, but in this case I doubt there's any impact.
By "this patch" it means that having the information in the cover
doesn't help, but info about missing deps should go under the --- line
etc.

| base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
| prerequisite-patch-id: 158157d32a32e765834a0cb4fc6335f9009d9962
| prerequisite-patch-id: 4007c7386e66f93b67a2631dddca08cadcee708b

That said, why do you have two prerequisite patches? This applies on top
of 6.9-rc3 without any issues (other than trailing whitespace warnings).

Also, you forgot the v3 tag on this patchset, which confuses tooling:
	shazam https://lore.kernel.org/linux-riscv/20240519175906.138410-1-kanaksh=
illedar111@protonmail.com/T/#t
	Grabbing thread from lore.kernel.org/all/20240519175906.138410-1-kanakshil=
ledar111@protonmail.com/t.mbox.gz
	Checking for newer revisions
	Grabbing search results from lore.kernel.org
--->	  Added from v2: 1 patches
	Analyzing 10 messages in the thread
--->	Will use the latest revision: v2
	You can pick other revisions using the -vN flag
	Checking attestation on all messages, may take a moment...
	Retrieving CI status, may take a moment...
	Some CI checks failed, see patchwork for more info:
	  https://patchwork.kernel.org/project/linux-riscv/list/?series=3D854147
	---
	  =E2=9C=93 [=E2=97=8F PATCH v2] dt-bindings: interrupt-controller: riscv,=
cpu-intc: convert to dtschema
	    + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
	  ---
	  =E2=9C=93 Signed: DKIM/gmail.com
	---
	Total patches: 1
	---
	Applying: dt-bindings: interrupt-controller: riscv,cpu-intc: convert to dt=
schema

Thanks,
Conor.

--n8jWxXrQpCGvcZN3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkuCggAKCRB4tDGHoIJi
0i0rAP9iTXoJLL92685zxN6JyS52MGmR2C23GQGodmPrRrAhaAD/c77LyzMo1OfW
9umhDvm7Q/Bk5V6Iu23CQkfBsSRZHAM=
=pXxW
-----END PGP SIGNATURE-----

--n8jWxXrQpCGvcZN3--

