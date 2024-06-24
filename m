Return-Path: <linux-kernel+bounces-227921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0976791581A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0A2A285A76
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AD01A08A4;
	Mon, 24 Jun 2024 20:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqZu5+jW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C719F464;
	Mon, 24 Jun 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261460; cv=none; b=SPxDFvGvp+EGrjjui4MgV04q/tUoRj4ijNjcG4fW1ZdO79vboSJ4ylTRnVS4YMwuDyqIRdGMfV4sLBRkgRlsXX3Tc3QGhs4vNHLS9jugwBmPoMCIue3zVDz+bCrYz/BfltQE+dqKAxTxZHCl8+oDKZPyB6ug29V2hLRSqtoB/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261460; c=relaxed/simple;
	bh=4d7T6+euO4Jf5/pqXj2ahpf0LXQbq2D9+js6pa3Ys5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh8cTL3+Yc/Dtvlyz36AMzfb6s9iI213OS1ZKoWgo7wr9tiBV5K06jyaSsaMkdwunoGFjtrImCCMvnknH80l3TZnwiu3FbDp+mMjsPH7reRcVYNrg8EIZZGXYqV5/MBodYWQ0ao56RUGH1/oKS5+xJ8cGKt5+8T1z0ao9zHbXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqZu5+jW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA9CC2BBFC;
	Mon, 24 Jun 2024 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719261460;
	bh=4d7T6+euO4Jf5/pqXj2ahpf0LXQbq2D9+js6pa3Ys5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aqZu5+jW4cutRb0RA+kDjk+v1FjtPQfv8BnJyck7sIlRjJlpIGfiTGW4vT1vg+N3m
	 AB5AODAuQjpbwXjz/XaR8itvH4tMwQ2rJNsNfQ9emk5uo2XLFPbexM9omwJPAomDKe
	 0qNkVVYShRIffBaEDGY0/6h39oRXFM3GBd7ONVNklQpOATjBLrs8dX8Jcw9seuLps9
	 p15KCZ2deG4sA/9qxfuPgNPaH5PCZMI+0tOH/Dca5LQuC5D4DTJQzGKMNKAtosQe5x
	 +BMlkmfT9+2iAzWc6wrxMD8bhzTtfyjpnxmLn3SaCXtuYnLujc1LO2nfr6LRu5dYcF
	 nU8ay5ICL3hXQ==
Date: Mon, 24 Jun 2024 14:37:38 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: mfd: Explain lack of child dependency in
 simple-mfd
Message-ID: <171926144609.373838.11321058105570847753.robh@kernel.org>
References: <20240623134600.115098-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240623134600.115098-1-krzysztof.kozlowski@linaro.org>


On Sun, 23 Jun 2024 15:46:00 +0200, Krzysztof Kozlowski wrote:
> Common mistake of usage of 'simple-mfd' compatible is a dependency of
> children on resources acquired and managed by the parent, e.g. clocks.
> Extend the simple-mfd documentation to cover this case.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v2:
> 1. Rephrase the paragraph, as discussed with Lee.
> 2. Add Rb tag.
> ---
>  Documentation/devicetree/bindings/mfd/mfd.txt | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


