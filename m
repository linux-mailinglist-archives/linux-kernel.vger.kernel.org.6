Return-Path: <linux-kernel+bounces-290374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE6195530C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971EE1F253EA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353514430B;
	Fri, 16 Aug 2024 22:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH/cg8XL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9111127E37;
	Fri, 16 Aug 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845857; cv=none; b=T93BwjuYnqel+fH45/O3leLFe02EkkWaFWR0QBbYplcES3t/YLCLymtdM+v9485LjSLEaZeOezpr4MUACCk13Ldn7D4AQlzL4z8b4SVt2K/OjQEiw5I2Amh4/5W4IXNvDA4io6EYF2xtARB9U7e/7bSsMQ6W+JOTJmgQLR2hbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845857; c=relaxed/simple;
	bh=r4GtqUj6kBdjANlbyOr+H1EYTQ7FL4x488m+b6yI/2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGnrDMSyrOrGCsKWlpBZsb58vb15E2gOdlO/xu816OXHLxCkIjPjNnEROTkX1jJ5vYPPoBiNB4wEOwHKRH6SLxGxOvwcKQrgYtWvCWe2bbPhMekK5s8Je+Tm3cTvq++E0891es+gx1rbg5N9MLhZZGiDQLS3h3uq7Epsxab/SDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH/cg8XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0562BC32782;
	Fri, 16 Aug 2024 22:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723845856;
	bh=r4GtqUj6kBdjANlbyOr+H1EYTQ7FL4x488m+b6yI/2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iH/cg8XLoPBi0umTni6czQKlR9x3Xk0F8Jz4FXvs/N8SMu4nX1eTe3HcU+JF5rpyP
	 EIAFIl0ChvwuAwhMIKnFTKaen/XxSrbZwmTN/jhNw+r3leeFaXDdFIn6BHeq6/VWEy
	 HZAep2fek+GYfcQ+KSoRHQGg18HniLBTQmtPey9SbSvaOzTd2zny/2H0vR+O4y6PAA
	 UaC+oLLHZAsXAlRFgQVzDpdjxmMVqana3FZXlwS0ZG6DakO7etVYHdO4wmr8XVtkFA
	 xh8SYL1OzGDomZ/RzCMAU/ezkifh2r/rFVKLNujrLUAWdQSl3UrV+GSUmM8oMCLwCR
	 z3hRYd/ZnFuCQ==
Date: Fri, 16 Aug 2024 23:04:11 +0100
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt to
 yaml
Message-ID: <eb247611-f034-48af-9ee2-d9e68bc30d85@sirena.org.uk>
References: <20240814181727.4030958-1-Frank.Li@nxp.com>
 <20240816215555.GA2302157-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fJWPX8QIRrCKJsjj"
Content-Disposition: inline
In-Reply-To: <20240816215555.GA2302157-robh@kernel.org>
X-Cookie: Are we running light with overbyte?


--fJWPX8QIRrCKJsjj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 16, 2024 at 03:55:55PM -0600, Rob Herring wrote:
> On Wed, Aug 14, 2024 at 02:17:26PM -0400, Frank Li wrote:

> >  delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
> >  create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml

> I'm on the fence whether to move this...

I don't really have feelings either way, I'm perfectly happy to move it.

--fJWPX8QIRrCKJsjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAma/zNoACgkQJNaLcl1U
h9AObwf+LcMBNpccR4GUSCMZRhOCTwpyv1F05eZmjnJ7PIobeRGh1RPwSu9gkEhc
8t4obp7grz/n8UJwdWv54u9IeU0j7HoFyGUrWOKqUSeOj4Ak2UPQdL1Z7awjUsyY
8yASx7OJEbDXOPfOkhhWpNdEwL6jr4n0jZTKY7Lqe8bbyR4BN6+ju05HTdAWQcJm
oVux/WS1QZHMiJO/ZepQ8V8T+o8G+C7weCVrCRoi4Q1OM9GtbhfxTFAiDKCHJ9zh
PAcx0Zwjbv9H44ldy9DctMB88ivHreS4qutbZryszKPh1mUxK33/Mnn5fmUaOgis
AHdZyoRmo3MJJXuIvoMVOXVx+lLfpA==
=roy+
-----END PGP SIGNATURE-----

--fJWPX8QIRrCKJsjj--

