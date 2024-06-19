Return-Path: <linux-kernel+bounces-220857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2C990E83C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756AB1F2264C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0782889;
	Wed, 19 Jun 2024 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMOv/kFF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961D80026;
	Wed, 19 Jun 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718792559; cv=none; b=Lmpvjf/Q7NfTAGYdYE37Sle1VmM7OycYhs5rbQcZ2aqCTkhO0jqNYnclUGgCkLbW8p/Ghran+wjgTr0pxRsXkX6uJi90wMpHw2ReXSvAPUpe9GCTAKFEiTKa+WVhgo5ZJSuTFj9tgkuuwVdmBylAYVdWm/HEBhku/WXj3vlpsOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718792559; c=relaxed/simple;
	bh=GkT3s/gwdbG/kwTeTbglwxWahQeec8onFjax4/+NU7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Km1TfSnrT1SmJGEEXSm87eVcgJ3MECyKtUt0AK2AYF+LbQuRKqMQeJ2eVNEUr7IyTInz5BP9MPqEhcQdrCkdvQ7vzhuH44rpgGEVR0BRUCKUi1eOZDpYRK53+xVioiW1YJgrB+iTl5+POQerExAAQoY5HAPT4TvWmo59fiJ78Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMOv/kFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D621EC2BBFC;
	Wed, 19 Jun 2024 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718792558;
	bh=GkT3s/gwdbG/kwTeTbglwxWahQeec8onFjax4/+NU7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMOv/kFFX2Q5ThN/f7Cqi6FE3x/0Vt8xHN5dia7vFy0Zrht/2WjOKhTBmOwKT0+D9
	 Gy+xPpcNwGuUTiTnGiuOeoDbDgtOtOtKB1GtlYUMJeb7ed8kDmVDpQT8w/dJ5O5ak+
	 ZY/71wx9o49QUaYc7Lwv0E/OifW5Af1iTktjDYlt76pxqNNra047N+55tdnJoOJ9MY
	 P8t+WeKZPH7138dvPKW3xoyEgWE67X573cOWFDO4IWUKgoc1aylVpkvqJgjoyy1ztB
	 mfiZc95DnW+9gmaDKl5qoIm8IvxMvyGDEm82NNU8x4uxdyOMhyo5lloaWT7ksYCAIJ
	 xEISIpD4atpRg==
Date: Wed, 19 Jun 2024 11:22:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	linux-sound@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC: cs35l56: Accept values greater than 0 as IRQ
 numbers
Message-ID: <941d2b8a-18b5-43ad-9aec-6785f841dfaa@sirena.org.uk>
References: <20240617135338.82006-1-simont@opensource.cirrus.com>
 <fe9dd613-8909-4c7d-a7d7-9094b75fe8fb@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n72fWc0xzJrExxCe"
Content-Disposition: inline
In-Reply-To: <fe9dd613-8909-4c7d-a7d7-9094b75fe8fb@opensource.cirrus.com>
X-Cookie: Don't I know you?


--n72fWc0xzJrExxCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 10:44:47AM +0100, Richard Fitzgerald wrote:

> Mark, I don't understand what your objection is.
> What is it you want us to do to get this bugfix accepted?

Have patience.

--n72fWc0xzJrExxCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZysWcACgkQJNaLcl1U
h9Dqegf/am6/c0XEVSlqtQ/cQZymlNPQfDPmGNchcXeO/m+u17TuexuuRaXkGuHP
loJ1uNc0Z0Ehe2CLdHuLBF4CjFK7nXtRwMA4hUM1/2minfPuLBHvnxYRQS1BoJFP
VWcZhXxC9kIAUzmf77IoC02URSyoUkXzKlbL+lSOYIh9oszSM8jzuGe4NLf0Fk3o
M63wFoJqKtl54qCwRIt08sxSfXRr93JFBphubMZrxVXK+Euh8CFLw2xl5C7UqbEf
PAExxT6h0whHm8ou1FhPEFvkZum05X5OUN8uKN/ZqpUclswC8Y1uRHuufT/P7Vfn
PTdF1Dwk9xIuHPLxCMqsFS6PXxaooA==
=VmCz
-----END PGP SIGNATURE-----

--n72fWc0xzJrExxCe--

