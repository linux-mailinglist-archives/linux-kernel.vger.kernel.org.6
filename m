Return-Path: <linux-kernel+bounces-517898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B6A38725
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DAC63B47C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361052253A4;
	Mon, 17 Feb 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ihS6qqtz"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C6224AE4;
	Mon, 17 Feb 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804282; cv=none; b=rJiLFY8n23BjYDSObeCD2PBarfXB7nX/WEs9Y8quYZH19pE4eOU8IgtgukVMkGC1ldeP+sJp8OWc12SECgOAJJjPxWavTXz+CTm9/p/VZNHIA5XqQFhperVwO09sBgtfYtCOhWDPmV6f8Z1VlQ960tT+pOPvw9R/CE1zBwdQy78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804282; c=relaxed/simple;
	bh=oFREPRNZa45E3UdEZrVYc6OmAJuZkoV5lwsXCtv0TpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1QtQCp580xlWflcPC/ZzUFUCunoUEH71jAVv8iPRKMGjyNnCqG0YMxj5CgXnYleIZs/Pi+NmsAIH1K/Jz3EQj7lwLDvbulvcZ6jmJtd2YJ3pCdKA4FnIL87bC7vGfbnz9qV8zCU8yMUwKoRCAz7j49PWAK17fk+YWrFlEvRDbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ihS6qqtz; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 9F86D1F956;
	Mon, 17 Feb 2025 15:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739804271;
	bh=/J0M76EHLwXF8izY2or6AGdmLcAi2R2p1SP1NPe54No=; h=From:To:Subject;
	b=ihS6qqtzYLa/4UrM8vEANaKhv1K7W1vu7YaxW8dYNBgTwm2rKEoIclP+vhsPulaic
	 kRnr2LMnwa2np2SKRJ9s+YxpxV2uexOEOv2XZr7KNXYPwH8S0auBu6tK8bbvKo4TtH
	 AFLHOixqW3ZR7DDS8fNw0IbqJoHUkEZEalN9U7P+jCCrSrJ1dht4ol0S0LeYlwkY9r
	 lg3Ug4pPzMvuDMcmkkHHlTxIkBx60RRWJIXirXPiIF06ypLffwE6Zx8l7powv5rVTu
	 wtVwouWalc1KBJWXJygaaIgcoX/U+sec1UjJktIzd5wERFd7NGfXsFYUm2GihJI5wH
	 zsN9rwUu82//Q==
Date: Mon, 17 Feb 2025 15:57:46 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jai.luthra@linux.dev,
	francesco.dolcini@toradex.com, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: ti: k3-am62-verdin-dahlia: add Microphone
 Jack to sound card
Message-ID: <20250217145746.GA55060@francesco-nb>
References: <20250217144643.178222-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144643.178222-1-eichest@gmail.com>

On Mon, Feb 17, 2025 at 03:46:04PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The simple-audio-card's microphone widget currently connects to the
> headphone jack. Routing the microphone input to the microphone jack
> allows for independent operation of the microphone and headphones.
> 
> This resolves the following boot-time kernel log message, which
> indicated a conflict when the microphone and headphone functions were
> not separated:
>   debugfs: File 'Headphone Jack' in directory 'dapm' already present!
> 
> Fixes: f5bf894c865b ("arm64: dts: ti: verdin-am62: dahlia: add sound card")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Cc:stable@vger.kernel.org
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

