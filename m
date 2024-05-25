Return-Path: <linux-kernel+bounces-189349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F23D8CEEE1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F9D81F21766
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D244C8B;
	Sat, 25 May 2024 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBZou4/4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C025601;
	Sat, 25 May 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716639950; cv=none; b=DmHhK5ZQTMpkckk3Bq7jCkzhbmiNLPwyXAcpdnLzIDayQffb2IG9nWEC3bbIuO2cLgdaRwHKdp5o8DySD20TZVnRltZnvhh97B/vkNRSzJDyrHzxenBFrNfdTIdZXBhey5q4ofXN2vccZEFqApWt9+GHhRVIBPeQ6S1hMTzOjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716639950; c=relaxed/simple;
	bh=uuutn1siWRfLN8VrmLQsvkar1/xh4in+lXCkVh75NNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8S78Bfkexd8zBcod05S2XIJR5O+YZZz/SRcPX0LydaTub9mjCQXCTzdt8KGRcZeJK5Zl1j5dcNfVmlGU8QSwKuuo1TgxP5Pj9T3Ph0cgqFbR/NI2jP8UNq4XF0/eaqG3s2RM4OoQMkQcTpFkXYVWvJnxPMoapYc6XsbvSwfCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBZou4/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AFEC2BD11;
	Sat, 25 May 2024 12:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716639949;
	bh=uuutn1siWRfLN8VrmLQsvkar1/xh4in+lXCkVh75NNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBZou4/4P5uSEv7MlskTVJ8tOAnh1CurHxktslMywg/aVBTxLd0yHQnlopmMJOQZP
	 9zMUwcSPMfzhxw6XXGAdYuT3N+3jKIkfkckiDqEYN08hCCdm+3Z1z80IA4ejMcy4Mn
	 nFwy8nVkYRGJRhILFK4300UaJXoaOJnYYHRr+guvJKWFp1FSgP3coKXGkcM8ozRczF
	 KqJCWak29MjcrIDHjWsLkrXhlN8xwmMXWKDi17wVEp2Mz/uRFlp5i7nyU5GuAW0A4A
	 JQq2N9wY49GWimQQsKpgs5zVK7pwCryLU3ixytCWpc4w0NMJUntuT5C09cEfyBSG6J
	 h14wh0R4pNsKw==
Date: Sat, 25 May 2024 13:25:45 +0100
From: Conor Dooley <conor@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Henry Bell <dmoo_dv@protonmail.com>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RISC-V: add Star64 board devicetree
Message-ID: <20240525-shirt-scratch-6708b2a4f63b@spud>
References: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com>
 <1b55aad1-1442-41a5-acc6-16baab90c021@web.de>
 <caCBlFpvjmhO9G1A1_2qHImmuoGai2NoPYonB5RCVftq4zIrSxlP8Msh9z_FX9GwQXzfSrB40dRxy1zfxZesOJENeebWQsERa03sDvArzec=@protonmail.com>
 <20240525-dumpster-bootlace-10123081a6f2@spud>
 <b52685a3-127a-4367-b11a-54ab88467dcf@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6WI4GTcOugy2KI8b"
Content-Disposition: inline
In-Reply-To: <b52685a3-127a-4367-b11a-54ab88467dcf@web.de>


--6WI4GTcOugy2KI8b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 02:11:05PM +0200, Markus Elfring wrote:
> >>> Would you like to add an imperative wording for an improved change de=
scription?
> >>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/Documentation/process/submitting-patches.rst?h=3Dv6.9#n94
> =E2=80=A6
> >> I'm happy to change it, but was going off the format used in Conor's  =
Milkv Mars commit
> >> https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit=
/?id=3D04a228aadb84d894721b13197649ca741f3018bc
> >
> > Don't worry about Markus, most maintainers (myself included) ignore his
> > comments on patches. The commit message here is fine.
>=20
> Would such a response mean also that you are occasionally ignoring requir=
ements
> from a referenced Linux development guideline?

I do ignore it from time to time, yes. Being a stickler to the
guidelines wastes everybody's time (just like this discussion).
That said, the tense used in this patch is perfectly in-line with the
guideline you reference. "Add Star64 board devicetree" is in the
imperative and the commit message body contains additional information
about the board's configuration.

Thanks,
Conor.

--6WI4GTcOugy2KI8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlHYyQAKCRB4tDGHoIJi
0oTUAP94LrOxy2p8XfaXuefNL2Vk1HswZhmUTF28/ERnU2emAQD+I1g497DfVS6G
WaJk05M15ZqUswocaw+gXzJOKt7XjAs=
=LQw1
-----END PGP SIGNATURE-----

--6WI4GTcOugy2KI8b--

