Return-Path: <linux-kernel+bounces-225704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47425913414
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA54D283F53
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8016EC10;
	Sat, 22 Jun 2024 13:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAleG/5A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09F514D6F9;
	Sat, 22 Jun 2024 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719061512; cv=none; b=awq6v/LU8IEgRqpMOr7r2dMUnO+NH/8rA4fXaGr8XuF9d6bPa/yOMta9/g7jEjtpToUffhoZe3z4qwDA0/rLDDwv53o3keaOMIp8QPbzZyy2XoS/AHpCBoMqPUf08M+FJP+IIWFZ5lKgITL+1B/tlvc6u4yywlZNlWAdwr1graY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719061512; c=relaxed/simple;
	bh=8pC44r9Oj1dhrw5UE75tXX29ELdK1m8cQNkcWGEG6R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s++sDH9w/M8+kBsEe3G01btrAnNJlfRnOQNuY5vFCVr6Y98T5Osqwu6RF0slHZ/549yWyGdpeb5VYMePBGl/Kl7VxjD5Dn5lNKOk6vFHBIg0yZpWaSU5FxWFuaxJb8BbbixLqECDzbXzezOfrnjgKS2kAHBb2/il+fwY8mOyA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAleG/5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A45C3277B;
	Sat, 22 Jun 2024 13:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719061512;
	bh=8pC44r9Oj1dhrw5UE75tXX29ELdK1m8cQNkcWGEG6R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAleG/5Acfo1bhnjlfm8PNQXxHcfwPSE0D4d742XuC1jCrt/9miUA+z2/pMtSsG/E
	 KipNZaAgEyzzpmkQLtyzFymbQ7Ui4rMOjijk/+MH8nuslc8XEvKfU6VfFUVRzoyvRH
	 6mg9UL2bQfneheUeprchOqJFgwfjwrhZdWM8bVOxKKGxVZFVTAgyj7n1GkzxU0/Qx7
	 8/JxEhySiNK8hstGEhwWjOrr43xKmj++Ddv2Sr5w89mMwkEslH96EUGZU2h6KRjLC4
	 XwSDhvs955rq3ekRC2IF9+E1AnyDtnntymPDaTfVFOpKTDcXngBZIWhVdBBFF8iHKI
	 vshdVZSq4BC8Q==
Date: Sat, 22 Jun 2024 14:05:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: add ti,pcm5424 to pcm512x
Message-ID: <92bb82cf-47c3-4216-9a54-466ad7de43ce@sirena.org.uk>
References: <20240622124603.2606770-1-christianshewitt@gmail.com>
 <20240622124603.2606770-2-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qd5lMr36o2A9Y9hn"
Content-Disposition: inline
In-Reply-To: <20240622124603.2606770-2-christianshewitt@gmail.com>
X-Cookie: No stopping or standing.


--qd5lMr36o2A9Y9hn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2024 at 12:46:02PM +0000, Christian Hewitt wrote:
> Add ti,pcm5424 to the list of pcm512x compatible chips
>=20
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/pcm512x.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Ideally this would also be converted to YAML but for such a trivial
addition I don't think this should be a blocker.

--qd5lMr36o2A9Y9hn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZ2zAIACgkQJNaLcl1U
h9BEqgf+O3MTXzJeES2cciAQyyKWA0LbO6xd++EtqKFeu+JSeIyP3Js+ZxUJrCDS
wQEiJs9qsB0m2AsaG2UI5rfVRfwakK9QG2VyIwTrNA1j/B4XFaKlv8WJO78wac6M
bgq+W9roe7jLIgjUNylPySe6uresKIJD0XacIkexmVC1Lod5Twku9HXf8KqIBaRg
0dTbK+QNjXJDJS69rWAc3acULRaYBnJ52B8xkW1ixXUBqnP8V2aMpcQ7Clm7ZI/N
fJTFptfQ1P2xVKYW73UkkVOE8gFHsgw7l56GyHPMlooWZ9xtzNvvT3B3LfuAtoMD
kasjjkyVU+b9LOuyt114z7zRBLbTzA==
=o1cf
-----END PGP SIGNATURE-----

--qd5lMr36o2A9Y9hn--

