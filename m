Return-Path: <linux-kernel+bounces-357437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005BA997130
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B4C1C21321
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1F1EF932;
	Wed,  9 Oct 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb2JD2dF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45601EF922
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728490278; cv=none; b=iEKg6Hs3kNJ7DQ0UIdkmgTrs0wtZ0iCdrZgi4ogy6wJKWboInyOvCYcEaZQ7S6vtLJ42Jh05n8nZ7wXlCGaIFng6Dg4gbeBnpMtqcWHYGZ3JwIHp4uOih8qVy4dLFQVONfDK9MAtiKAEG8XIym34SEDH2yAn1bCg9OdSxzikBFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728490278; c=relaxed/simple;
	bh=DgZkGxM4V3QJBwzuea84dsfDXbPfU0i0I8BDA/DOkjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayzl6A1VeW2eUhaoyc3AVAdl4UC7EgmWZywAGbx2BdVg6I8CMeK8wR53CH8ukYsCGzwj2/FdADT4x/0hkba4odhLDMNK7iuQHSVtwn6opXxp5XM4/r05biCBBiEP+Vax6Xj1wDqobTsT3ew7ZuCWtzZmwcBL1y9uhBCe2v4XS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb2JD2dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E025BC4CEC3;
	Wed,  9 Oct 2024 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728490278;
	bh=DgZkGxM4V3QJBwzuea84dsfDXbPfU0i0I8BDA/DOkjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gb2JD2dFr90K3c0k51hyWuGiJrnRzyVHLboQVKPw7ZLC1+Ire5DEoKFC/jQMuCes6
	 QW0aycxZpzejhemK7LCa+ib4243lZvGeEWTeAh7CvKuv+Cd2N1llX4ufGLOgin4mgS
	 I+yq40rLmD1fhzVimVNuWUz/AHs9gDMyinGhi2cLZePmBBkKtKj/OfNFGB7iR/Erlv
	 90HERsJ0wXgHrnw7220iW1QzavBfSVSTrtaDtu9idFbVB9LNKEbFgbu0ZcUUargApQ
	 9OUIDEv96gBr0n84G7vlfeB0MpQCZ3oS/rtkQsvDxlnsun8EeTd17G4o4op/mVqEcD
	 18oTsxgM5ByEA==
Date: Wed, 9 Oct 2024 17:11:13 +0100
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: bd96801: Add ERRB IRQ
Message-ID: <20241009161113.GA661995@google.com>
References: <cover.1727931468.git.mazziesaccount@gmail.com>
 <dda4464443fba81f79d5f8d73947dbd63083cff2.1727931468.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dda4464443fba81f79d5f8d73947dbd63083cff2.1727931468.git.mazziesaccount@gmail.com>

On Thu, 03 Oct 2024, Matti Vaittinen wrote:

> The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
> handling can in many cases be omitted because it is used to inform fatal
> IRQs, which usually kill the power from the SOC.
> 
> There may however be use-cases where the SOC has a 'back-up' emergency
> power source which allows some very short time of operation to try to
> gracefully shut down sensitive hardware. Furthermore, it is possible the
> processor controlling the PMIC is not powered by the PMIC. In such cases
> handling the ERRB IRQs may be beneficial.
> 
> Add support for ERRB IRQs.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> Revision history:
> New series (only ERRB addition)
> v2:
> 	- Suffle local variables in probe()
> 	- Unify and improve the error prints when adding regmap IRQ chip for
> 	  INTB or ERRB fails.
> v1:
> 	- use devm allocation for regulator_res
> 	- use goto skip_errb instead of an if (errb)
> 	- constify immutable structs
> 
> Old series (All BD96801 functionality + irqdomain and regmap changes)
> v2 => v3:
> 	- No changes
> v1 => v2:
> 	- New patch
> ---
>  drivers/mfd/rohm-bd96801.c | 275 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 241 insertions(+), 34 deletions(-)

Are the 2 patches tied together or can they be taken separately?

-- 
Lee Jones [李琼斯]

