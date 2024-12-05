Return-Path: <linux-kernel+bounces-432854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420EE9E5112
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0E7D284550
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 09:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECD91D5CE5;
	Thu,  5 Dec 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOYsJf7s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD01D5AD1;
	Thu,  5 Dec 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390327; cv=none; b=mCmfX7VnL6nd7n4ZozIVNiB7AiOOCy5RayGT6nM5hmqHy+d64osmFXgTpXCIS8enfnc9GhFIJE4nL1KNr97d3HzhoaXsM6pgg8rvWjDFocX3YOUytTGfqRybWRmXeJ78AmvFcC4jTT44YGLxU3OMzfMdznfzepgYZS6PPA8Mmzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390327; c=relaxed/simple;
	bh=+s1lMDPZAoy49Qw505h2P4rtnHu1KlnTJKbTfD230s0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbCgZ7sFpW2kUD3jhpNZXtvzbHBUVyDiRPSQTQmyKxYgyFMDscLwJ2U7Ir8onhkqce/a1po43sHNKp/FGTjs5MkhpLm8B7qA2Pl3EHiAjO6iSRIX7doHmmCT//+RpJVfr0nYTjAq1Koys2vTAOkMZmRIqrFKPDG1ZT/2MW7YvLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOYsJf7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC22C4CEE2;
	Thu,  5 Dec 2024 09:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733390327;
	bh=+s1lMDPZAoy49Qw505h2P4rtnHu1KlnTJKbTfD230s0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOYsJf7sbJzZViMw2eQkRhK4wi3nJSfb8Hv5IzUFa/TsVdbniHqjbYelJxDyhJde0
	 WJ75Y2QJuMXtzOtWJjN97+An86zydcKz8eaDElF4qGc5A2zZB/QTvf9ddtzI9SmwNK
	 +ucNrnjwoWyVp6GQWjJz6LPx8ExIO+JOE8p0nk2SvI93qhe36PP21EiTGK43FXj/kz
	 wNR9xBZpnCqztN71gKQacBI9FEIp4+XPnWviOb+2bWiLBNyod9Vuo8oNCLuqC2gkeN
	 MfvrkZ/B1c/C0JdaTHL44HVWw4fx++yHO1eI60PKhc91zHBw8TzMyWTovGgdtDofD2
	 zltrdMLCgZsBQ==
Date: Thu, 5 Dec 2024 10:18:43 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: niravkumar.l.rabara@intel.com
Cc: devicetree@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Message-ID: <hvgf5nmnlsngrkdrwp4jrxdsn4tk5n3dh5twbxbacn2g7cyttz@sdhzeiz3646x>
References: <20241205053350.434370-1-niravkumar.l.rabara@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205053350.434370-1-niravkumar.l.rabara@intel.com>

On Thu, Dec 05, 2024 at 01:33:50PM +0800, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Convert cadence-nand-controller.txt to yaml format.
> Update cadence-nand-controller.txt to cdns,hp-nfc.yaml in MAINTAINER file.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
> 
> Changes in v4:
> - Fixed the identation for examples as per review comment in v3.
> 

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


