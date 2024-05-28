Return-Path: <linux-kernel+bounces-192678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352288D2092
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B161F22FD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753A17109C;
	Tue, 28 May 2024 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0rIxd7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56421171640;
	Tue, 28 May 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910744; cv=none; b=BUxBSux0510kOgAwiei5MX6a7Va13kOpDfUQW/cBCbc6nB4VEGdX0tyet/XnYaUyC7Bf0JyI8Tw+rtJmOmL0/vZHQNUuoJvpGOQZ2sEMnPzas5xAsSS9KZXtwSAB4QASnUtxORlel5VX7m0CDWo/KRx9HX3ng/pNRQA9xSJfaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910744; c=relaxed/simple;
	bh=DF1SyvC/MZMzA6HY8m/jHm28CfGPXLZdj+xqP2V8MhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2ovdDdV7n48E/WTkVOnr+PXNCdtLTyhNI28VvNwGH/sD+z9Js6QhdMZVFCm/jf8xf91dT88Q9+8y2kBLbykRIEbQx0Enb3XOWakAgF269vFEOQgjnY6CXm2bq4H5oKiYjcriDqbWpJX85awSLWhcquB1UoWwJX7VCasqWTzRzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0rIxd7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F513C3277B;
	Tue, 28 May 2024 15:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716910743;
	bh=DF1SyvC/MZMzA6HY8m/jHm28CfGPXLZdj+xqP2V8MhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p0rIxd7Ni2RUqwiZxBjZHBC6a/p6roA0uztJkxME3SO2+xeZahPudti/lmQoJONDl
	 glm7CsdcgYtnZJ++caMLymIee/7GM67D70B1D/W+s9YCXW52gsKWMMGezcqvlHFo6w
	 upnqC3Lwtta8VSiaesHF/+/dmVkOFPa4+SZyt5LyM/qqQmQIZJiA3g0Jf9zU3tiAx9
	 fd+pHUxDCWfO9/zoc/XUV1btddeoPmdZtE4vhUnSzt7LKxSWr7zcVEpWcRGU4MIiET
	 zUaa9aOlKoa6CpBh6lLlWRRSIsrfZPvtNZ9HPRvp+b4WkIM406RfZf9fYsGDevGCIv
	 yQDRUB7C+nStQ==
Date: Tue, 28 May 2024 16:38:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100
 boards
Message-ID: <20240528-likeness-outrank-203235db1b62@spud>
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
 <87wmo2nmee.fsf@linux-m68k.org>
 <CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
 <87zfsy102h.fsf@igel.home>
 <20240528-outpost-subduing-2e84f77427a4@spud>
 <87ttii54n7.fsf@igel.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SU71k9OfCAjrB0pw"
Content-Disposition: inline
In-Reply-To: <87ttii54n7.fsf@igel.home>


--SU71k9OfCAjrB0pw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 05:37:32PM +0200, Andreas Schwab wrote:
> On Mai 28 2024, Conor Dooley wrote:
>=20
> > Looking at things to apply post -rc1, are you still looking into this
> > issue?
>=20
> I don't know what to look for.

Fortunately for you, it is Emil I was asking :) I thought I'd addressed
the mail to him.

--SU71k9OfCAjrB0pw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlX6kwAKCRB4tDGHoIJi
0u/DAQCB8pdGfzhDav26IupTirOHbUvJR+udBVopIhQ5HFVtlgD+LIvTWn/Sjj2l
71AxmORSmHlaRUwuyH4N8MtPEvg1IAU=
=7l+D
-----END PGP SIGNATURE-----

--SU71k9OfCAjrB0pw--

