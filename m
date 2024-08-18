Return-Path: <linux-kernel+bounces-291086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80529955D11
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B2DB1F21516
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593B86250;
	Sun, 18 Aug 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbpFPujB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0210C442C;
	Sun, 18 Aug 2024 15:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723993390; cv=none; b=pONqj+bPwV5ARUGxCUb4bnK1jl4mZVed0a12k6nZa5fQDK1roU1nFOK8mVNDmusLy3P5k7nWJiL79GpWa0GcrLHAACy9keG+awHkrD067mxppyQ1MLG05nTpxFWbKub8efcevH+rss4nYNNGg/uWXmhI76numHvMviFMk2/kIFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723993390; c=relaxed/simple;
	bh=fymQ+AfE+POXXIXTH/Xy9tDDBWMHmuncO9FH5mCi22I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U22oEx80TZpPChIV0hOrWZZOwb/dbsKCGazh4CcLaYLjOklSiCYqIi4OK6eWv/oimdIri5dpRafTEoBw4yOl+4aHwFHo47iexIA9WSpOmqQwpS5LwWA1fk5u1CsRwvDtg0FjuLg55x29p6O4T9sf9+0ROhinM1vk3ovJgpncyog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbpFPujB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B43DC32786;
	Sun, 18 Aug 2024 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723993389;
	bh=fymQ+AfE+POXXIXTH/Xy9tDDBWMHmuncO9FH5mCi22I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbpFPujBYTOg5y30HZI9UWfb9QMlXH2/Xq44pbPMJQ4yKCgB7FU9l0JUmPHE+CYrH
	 hfn4/NrtDJr7H1LDLIzN+dsloux6O5FcDOJzrQWXx7O2XEdXgD6AMeN/WqhTYBXEiI
	 F35bzTB5/HiV7KLaIyEIBCgMjxVpE/ikP5l4MqWVyAOqJAymJN1jGrO+iB3bvlonXs
	 34m7N1rxdYy0Q4MA703CW9tKUwkvDYeozKvWxWcjh9ugXPprq4FHg0CdzuA5vIq+Hj
	 XM26kNhUn7QitnbMCJCDspWMXJbsNdETjMNlz7Y4zxQfJym5k/yzT3YG4wh9/QnEyp
	 +nLRd8alr363w==
Date: Sun, 18 Aug 2024 09:03:08 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: arm: fsl: correct spelling of TQ-Systems
Message-ID: <172399338685.80423.3714497561976722592.robh@kernel.org>
References: <20240813071242.71928-1-Max.Merchel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813071242.71928-1-Max.Merchel@ew.tq-group.com>


On Tue, 13 Aug 2024 09:12:42 +0200, Max Merchel wrote:
> TQ-Systems is written with a hyphen. The incorrect spelling with spaces
> is therefore corrected.
> 
> While at it, comments are added to TQMa6ULLx.
> 
> Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


