Return-Path: <linux-kernel+bounces-193067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CED8D2675
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6CF1F220DF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59517A931;
	Tue, 28 May 2024 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tqk/JnQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219EC4C627;
	Tue, 28 May 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929232; cv=none; b=OicbDwzO+LMVscqo644GgWyfl+P17ASIJrT9qpgJCPTVtuboT6Rx91yyAg4V2z1rNbfId8YBdJgd/jQuawQy5yA/qd8IEwLT7KvK8T/aMVQ0YaEl88Nz0VJM4Zab/gHiBEO9G5UsKBb/nx+CgJ0j3M2An4UnFfntjiCmObt2HCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929232; c=relaxed/simple;
	bh=+FHTxvrxb/K2pN9sj74X9J/5rkzbc2QPqTsan5+1vp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlaCB3aZ8SRNU9IRhidE1pzPg6osphiU06GXni7AoSghF7Znt1UzS8RlMAZlwSNISSor01X9P3bWT3SH/AhCTmMWbNC0RD9lx7puhq5K3yTZF/ujIn9opqqHF3DvpNiN2hLl5x5o3+YuDaHLxCAcRaWqHRjx1419JRkonkNF6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tqk/JnQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888D6C32781;
	Tue, 28 May 2024 20:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716929231;
	bh=+FHTxvrxb/K2pN9sj74X9J/5rkzbc2QPqTsan5+1vp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tqk/JnQm3S9KA6oETP4bgWp5MAdRKA/WS+Fk+PpGsZcsjifWyBp9m3m3dj/pXjPFd
	 mVqSmhBD15HV+qLIzDv4YoXRutQqMArltwqc4ydqCY+UL2tsO9rjHW0gdBBD/PcUZD
	 +VStgsLdCJSc5K3adbJOUkdT2d1kHn+3AIVtqG2dWaLJc2rMreDV6Pjz6VeTvVJi1l
	 5rdp8+rJVNCpAOdgy3nShQ5WL2NODaqnCTJLUdZX+tL7phQDr/5ZtyQODgr2VXCv1+
	 KuWZhhbu+RAvb31hz/nS1OeqHCnKKEgLtYnC0u1Y1pFcD1Q3VjIU6OkeyK7Yp9ir8c
	 3as/DFKv7nPpg==
Date: Tue, 28 May 2024 15:47:10 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Ryan Walklin <ryan@testtoast.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-sunxi@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: arm: sunxi: Fix incorrect '-' usage
Message-ID: <171692919272.1968303.16565844333250152320.robh@kernel.org>
References: <20240503154402.967632-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503154402.967632-1-robh@kernel.org>


On Fri, 03 May 2024 10:44:02 -0500, Rob Herring (Arm) wrote:
> Commit 6bc6bf8a940a ("dt-bindings: arm: sunxi: document Anbernic RG35XX
> handheld gaming device variants") mistakenly added '-' on each line
> which created empty (i.e. description only) schemas matching anything.
> This causes validation to fail on all the root node compatibles as
> there are multiple oneOf clauses passing.
> 
> Fixes: 6bc6bf8a940a ("dt-bindings: arm: sunxi: document Anbernic RG35XX handheld gaming device variants")
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

No one has picked this up yet, so I have. Applied, thanks!


