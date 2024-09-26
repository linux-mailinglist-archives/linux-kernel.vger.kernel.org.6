Return-Path: <linux-kernel+bounces-339822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D78E986B00
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC0AE1C21409
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248617335E;
	Thu, 26 Sep 2024 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNdtdmRk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164FC1D5AAD;
	Thu, 26 Sep 2024 02:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727318330; cv=none; b=mPxUmtHY+Aewm8kTXvh5aYaaep7u2fMCzzkvNHupXzIIPfikAtnqFbcXUtur4CelNPVKukhRSJ0WZlKClAwUibhEJ8g46t5LDCBDYerTUR21uEAsw9F11HzzuPV1RY71Kjr0KHUhkOPnrR4y9ucOf0M+Fggo5Un4q0m9/Xt21BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727318330; c=relaxed/simple;
	bh=5YN/e4f7Ol+pHChfEu6Nb5WpsJGf0EbQqwIayzD5/KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3s4/vQfOuSedAw+75fvcSDb8AGL1dBaKXvKA0qa0984WNw8FoJWV0huCNCTbeXPfnLBkYrnsHdm3Dy2/9gU4bF131zO5kyNduIXSxxLlAA6bJ1Na9kKAWXE4Q9r5xlyF5KZVrNqoerwpw4fTad7r5odru8tTSG5gd4/KFwPA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNdtdmRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65743C4CEC3;
	Thu, 26 Sep 2024 02:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727318329;
	bh=5YN/e4f7Ol+pHChfEu6Nb5WpsJGf0EbQqwIayzD5/KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNdtdmRkrHq0e9akIbBTtxq9FsRk8UaByU7Vb/w9XEknlaK9yqFTJebB7mODYL7K9
	 /6yk2hJp+di1kZPHIdUKrFAWPrG5dV0e/2y70yI2e+rlNQUJSRxrFScmerdiVL8RbV
	 jA8xLBjeQFrnN17PTIqd1oAm6r8tHnSZ8Zol3kuHOSCt+ErfKmmwCdyrVSayOtCxnu
	 TvLaiFoUlbRoDoTZchcJfR1BtTcBcgu3u/mx366ip1qLtSBO3beuRQVzJakjQL6mh0
	 QB234ZTmvGYbj1hvImBnoedNqwwodAaWOL6UWmXCSfBfvD4vfwarBrVVVvNc0IIpxH
	 Dggu5feMqdA/A==
Date: Wed, 25 Sep 2024 21:38:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, prusovigor@gmail.com,
	devicetree@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>, kernel@salutedevices.com,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v3 5/6] ASoC: dt-bindings: Add NeoFidelity NTP8835
Message-ID: <172731832778.2420974.16007828304915406222.robh@kernel.org>
References: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
 <20240925-ntp-amps-8918-8835-v3-5-e2459a8191a6@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-5-e2459a8191a6@salutedevices.com>


On Wed, 25 Sep 2024 17:52:43 +0300, Igor Prusov wrote:
> Add dt-bindings for NeoFidelity NTP8835C/NTP8835C Amplifiers
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>  .../bindings/sound/neofidelity,ntp8835.yaml        | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


