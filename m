Return-Path: <linux-kernel+bounces-547293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA58A50592
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675B73AAC3C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14A91A317E;
	Wed,  5 Mar 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQVBuKCV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602B19DF41;
	Wed,  5 Mar 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193130; cv=none; b=meTzbuXXBKSdU1YLWrdQxdm8eWNviSx2EdyiaKWjGLTvT9rLJfOKEf2n0YY7omueTsmy8zWZ58lMqrfmYywBO2IINWHV1Egflz6HsmhYcWZXW6BOgDr2bjeh+ABjw244YOMgnTNeFNKNizW4Sbff3tXf/GkaQwpyyxn+DL33R5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193130; c=relaxed/simple;
	bh=a79LJ8dE3ma4v7t2qwXAq36pAAKFq9q6whg86nhPw/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APaaNvExaTT0iMQifnetyG85JQMHOKEQQaKiASO3hmAxkWoPMssKAb1SN5yKdhtZ/fQV8O2dgMxrL85VmsT5hjSyDTWBZ7Ram91hr6JXx7CNzW9v7keB49kcHdm2oQtz/YVywfHooZoFAbARQ+wPuRXZlRwbe40u5QmPA5Qf8tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQVBuKCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44266C4CED1;
	Wed,  5 Mar 2025 16:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741193129;
	bh=a79LJ8dE3ma4v7t2qwXAq36pAAKFq9q6whg86nhPw/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VQVBuKCV3aenPt1tOXmQ8qWVFYaHkJ3HO+Tv4aSzhqwQ2CLIvzl/w5v/mJ3fv73+X
	 EV/4lTWIhT5Z0gYRUVi65s6Ni+L8DyqvMDV5WHixHA8DRnIDG82zF3Yyr9NY20wC1s
	 5dOXksUekCGosTTxfMFj1FWe7/s1WruHXX4nZlfeM8YkDO5YAbewuoyJPgUyu0NU+z
	 W9YkTHtg8XDc3nLqRh3nhis1D7MztwMYjZvXpdE6FevkXfSBVHccLcITShxGlIDzU2
	 kY3o27C7vmY+smfUTrBq6DaLpDC6CHEpwHF0St59viSNMnwhz5ADLanZC1hGfTGQjq
	 hWrM+puQjHidQ==
Date: Wed, 5 Mar 2025 10:45:27 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-sunxi@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 05/15] dt-bindings: irq: sun7i-nmi: document the
 Allwinner A523 NMI controller
Message-ID: <174119312747.2117747.1409262151131178032.robh@kernel.org>
References: <20250304222309.29385-1-andre.przywara@arm.com>
 <20250304222309.29385-6-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304222309.29385-6-andre.przywara@arm.com>


On Tue, 04 Mar 2025 22:22:59 +0000, Andre Przywara wrote:
> The Allwinner A523 SoC contains an NMI controller very close to the one
> used in the recent Allwinner SoCs, but it adds another bit that needs to
> be toggled to actually deliver the IRQs. Sigh.
> 
> Add the A523 specific name to the list of allowed compatible strings.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


