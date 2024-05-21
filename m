Return-Path: <linux-kernel+bounces-185328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE4F8CB38E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 20:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EBAB203FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F66148FE4;
	Tue, 21 May 2024 18:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ejanc6JP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02262B9A7;
	Tue, 21 May 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716316568; cv=none; b=TOvybiy49800XEzMq5afb3uzffLsrwBUheimc7QHCeuRNIxjLIsq11ARe5msSiDm5u5XHXa16vZtxGgkmyvtxgeR1ucmkDxMU/BlS9RNnjonymB7Q9l90Do1Qwn9gAbp1piy459mSb7RDd5SD0aKYXJyEtBekIkS8hNgriXmiE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716316568; c=relaxed/simple;
	bh=4hyalmglveh7L1D1/x9Ob92uVOpeAf5YomfggyvRmfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFAQ4cWePKbRpP1xDV7kTQQ8RiEfxYUZnOckb5Iz+jXuwIN6By4JG1TWAw9sALaHCd+XLdz34iM50fB1CNpP/JqnhuqqYItkGVPecpHZnwdpPle089ZgVe5dHf8eE1nnVRCKyFfULZpwV1keD6W3+iBhsY1hHFvBuWOPfFpz1Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ejanc6JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C721BC32786;
	Tue, 21 May 2024 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716316568;
	bh=4hyalmglveh7L1D1/x9Ob92uVOpeAf5YomfggyvRmfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ejanc6JPEHRsS+eAg6JSIGEzVxzsffCfU7OEHhcAWBoGWK+aC2axEsHuES0yf90dm
	 UNQroh6hiwvQ8LI1btw8dfG10PSRS9rsn0X75t4klca4l1YpJvRfAFLIZHXs0NAHQh
	 U/e8EYWqvXieSLQ21cax4+XsoKLqnLeg5hE1x9yUfL3Zak293ZvoDpLgT5hnly+sA5
	 wPkBCOx5R/GqjoPnxfESy8pelI6YHBUZYJ3ra1dFLRbHoS6QnZW8sQOv614dx+2Iju
	 NiuM6GztYZkt36N5bGeBOienyI/LpDAr4WixkGLnkJGVfUpB7ZQcz6tM8Hg86LITIl
	 wFXryO7qS3IJw==
Date: Tue, 21 May 2024 19:36:03 +0100
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
Message-ID: <20240521-stadium-cargo-178d91444e58@spud>
References: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
 <20240519175906.138410-3-kanakshilledar111@protonmail.com>
 <171614715439.2941344.11264816105918092609.robh@kernel.org>
 <CAGLn_=tLdJU1F-i9YV5aCZQbS0L7y7Wu+_k6Dn=6HwH5JmZoMQ@mail.gmail.com>
 <20240520-verbally-vibes-47604636b8db@spud>
 <CAGLn_=vsFSrEi9uaZosZ6hOK5WKyOhBWvhWmz1GXz8vp9M9M9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GvZvOdIgLJuEP4Dr"
Content-Disposition: inline
In-Reply-To: <CAGLn_=vsFSrEi9uaZosZ6hOK5WKyOhBWvhWmz1GXz8vp9M9M9w@mail.gmail.com>


--GvZvOdIgLJuEP4Dr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 07:26:54PM +0530, Kanak Shilledar wrote:
> Thanks for the clarification.
> On Mon, May 20, 2024 at 10:34=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Mon, May 20, 2024 at 03:09:44PM +0530, Kanak Shilledar wrote:
> > > On Mon, May 20, 2024 at 1:02=E2=80=AFAM Rob Herring (Arm) <robh@kerne=
l.org> wrote:
>=20
> > By "this patch" it means that having the information in the cover
> > doesn't help, but info about missing deps should go under the --- line
> > etc.
>=20
> I am still unable to get this part. I don't see there is any dependency
> other than the two patches dependent on each other. In my cover letter
> I have mentioned that the two patches are dependent on each other.

That's fine, then you didn't do anything wrong in that regard.
Sometimes however, other series have a dependency on other series, which
is what that text was talking about.

> > | base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
> > | prerequisite-patch-id: 158157d32a32e765834a0cb4fc6335f9009d9962
> > | prerequisite-patch-id: 4007c7386e66f93b67a2631dddca08cadcee708b
> >
> > That said, why do you have two prerequisite patches? This applies on top
> > of 6.9-rc3 without any issues (other than trailing whitespace warnings).
>=20
> For generation the patches I am using the command:
> `git format-patch -2 -o outgoing/ --cover-letter --base=3Dauto`
> It is automatically adding those two preqrequisite-patch-ids
> automatically along with the base-commit id.
> Is it due to the fact that I am having 2 older patches which I have
> rolled out already? Shall I remove those
> prerequisite patch id from the coverletter to solve this issue?

If they're not related to what you're working on, then yes.
--base=3Dauto probably picked the last tagged commit, but the applier of
these patches doesn't need to care about the other (unrelated) patches in
your tree so having them is just a potential source of confusion.

--GvZvOdIgLJuEP4Dr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkzpkwAKCRB4tDGHoIJi
0mlbAQCk/kNx55m+Fk3uAJhLQ/EQNRKAhy5x8ukXe3t9xpM6ZgD/WDTehH9El/RG
w5Rdi7l/zyrvHD8YzWONrzK6DRfxVAs=
=UIvs
-----END PGP SIGNATURE-----

--GvZvOdIgLJuEP4Dr--

