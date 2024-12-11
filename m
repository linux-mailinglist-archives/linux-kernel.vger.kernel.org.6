Return-Path: <linux-kernel+bounces-441667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6099ED21D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B228144B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A51DDC11;
	Wed, 11 Dec 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJOvR9Oo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8819FA93;
	Wed, 11 Dec 2024 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934959; cv=none; b=ToQTvlKJzNZ9l73y9i4GwPfOpyYu5VZimx+itizChSTlMv4OEl3bqg5hpizko1tve1ZAbuuLRYfUGTwsdxvQXilnsl/Q0kiKPIft9+BUwfzKOz73CQSDUExycz8HW/XKzZ6kMJ7vGVdHUOd2mxvxWo/YXATXTZ/Eucbj7D8lx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934959; c=relaxed/simple;
	bh=wX4pAsllcMh3GaB9tysl6VWDG5D5WSQ6Tz3GDBXPVV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnX5NvncZCOcxE9f9KbOZ7MCrYKaFGocTxCJ3GhasqibNbiBazZw8Puap+trZVzJ9w0tZcnQPudhOB8IhJReffcUC00bEy445ZAoD1a1HucqRaforTLdMwSnTkZKvy7bFxBt7RxLClkko85UrOUTfQGyVZqAas0OScqNVm3BwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJOvR9Oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319E8C4CED2;
	Wed, 11 Dec 2024 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934959;
	bh=wX4pAsllcMh3GaB9tysl6VWDG5D5WSQ6Tz3GDBXPVV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJOvR9Oo8MYprBVSPVD1Kx7ZYvB0gJRfslCPAtpBbfOYZ8dXVci2d5REpsus5+6vU
	 TtGYAnl4ezvGU24qbQkQ+PWcpBMgSc66Eu8qVuQPCl86xR3WqQxnQ40wkZRU185/bc
	 dx+N6azNaVPpsPKPVovF8/d8NRaxUyHFgd5f63euNLPd1FgAQjmblQFTkJcpGqlku7
	 y4Oj5tek5PszLMkv28czTyVP220E1VqYul7CyjkWhNNofL3j91MuFp4LqE7pHuohZi
	 jc6yVtdNuxUMegfNvQywDOFqooRvj2o9cBUUluhdQtqmGOJa9GAHDLIjkWehS7MrYc
	 XRrB7t5JmBvqQ==
Date: Wed, 11 Dec 2024 10:35:57 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/2] regulator: dt-bindings: pf9453: add new PMIC PF9453
 support
Message-ID: <20241211163557.GA3256322-robh@kernel.org>
References: <20241206-pf9453-v1-0-1e4685114271@nxp.com>
 <20241206-pf9453-v1-1-1e4685114271@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206-pf9453-v1-1-1e4685114271@nxp.com>

On Fri, Dec 06, 2024 at 03:32:40PM -0500, Frank Li wrote:
> From: Joy Zou <joy.zou@nxp.com>
> 
> Support new bindings PMIC PF9453, which is totally difference with existed
> PCA9450, so create new file for it.

You say that, but it is all the same custom properties as 
nxp,pca9450-regulator.yaml. It's only differring numbers of LDO and 
BUCK regulators AFAICT. It should be one schema.

Rob

