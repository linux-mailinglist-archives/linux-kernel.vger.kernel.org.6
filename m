Return-Path: <linux-kernel+bounces-233023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9930591B12D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DA23281875
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557C1A0707;
	Thu, 27 Jun 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDDo9rTY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2D19DFBF;
	Thu, 27 Jun 2024 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522460; cv=none; b=U4VsWppva7yROeJ0FZau/HyG0/iiZcmEUm2/BL87c7ZiD6sBgQVBYe3uWupbjFABQk6p8VDjvUJDgVbDn4QI4NlLUR6dQSqAqPqdT+mHmnnYuJUTdVI/AtfYHPTOk38PKbLErOxEi50gdGcd+zGmA7WrDJpTMZB1+Fq6uv78KJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522460; c=relaxed/simple;
	bh=LQWyrY4Sbgn6mPEsHhvn5smDwk3zH3B0uAIOU5fwQOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMlSuae1J0yf4o1Qp8F4Ibti9nudxfAbSBq/TNZ8aDPqVZDCCbd0xyWI9m9sckDKJuJpCsvXd5r5FxegcP0BiIbQEqWsfWLuYZnjN4A4CBNnZj9oyF+TQBe8EwOb4LvpfCJ/KivUBv0s8+P9cQPp0EfaSw+pr91fLRslH3FwEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDDo9rTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D1DC2BBFC;
	Thu, 27 Jun 2024 21:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719522459;
	bh=LQWyrY4Sbgn6mPEsHhvn5smDwk3zH3B0uAIOU5fwQOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDDo9rTY/Mz4M5OCzNNkAwpcF5vuh/i9bPkYiOTClrGgfoidJv+noEulJsS8F/oq+
	 sABto+l7W+W6bFgYeD1j+MauWFUkyaUner2iF0S3e2xeIsLIs4ktndwfhUIwg2KV9T
	 WJV3qd4ZcrUCkHxox+MN1ahgIwJ0RelWPeGWIGgQ/uOzjoBCzSi+AD8ylO7gwhJpQm
	 3fPSX6Opp6kpTjpxwdNhEgbqg3RxYJ+JRFBSuSCsIUmTlMk2Kmnub8y4NNlC67uZZf
	 4SciUgBazmTPtLpjeFzATEBxNKVC81vC9/AW4gHJw9tHoKvsh4xa66NMiitCsMSrVI
	 KaZbKZ8JB0Brg==
Date: Thu, 27 Jun 2024 15:07:38 -0600
From: Rob Herring <robh@kernel.org>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, tali.perry1@gmail.com,
	joel@jms.id.au, venture@google.com, yuenn@google.com,
	benjaminfair@google.com, openbmc@lists.ozlabs.org,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v25 1/3] dt-bindings: reset: npcm: add clock properties
Message-ID: <20240627210738.GB501440-robh@kernel.org>
References: <20240618185819.2155595-1-tmaimon77@gmail.com>
 <20240618185819.2155595-2-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618185819.2155595-2-tmaimon77@gmail.com>

On Tue, Jun 18, 2024 at 09:58:17PM +0300, Tomer Maimon wrote:
> This commit adds a 25MHz reference clock and clock-cell properties to
> the NPCM reset document. The addition is necessitated by the integration
> of the NPCM8xx clock auxiliary bus device into the NPCM reset driver.
> 
> The inclusion of the NPCM8xx clock properties in the reset document is
> crucial as the reset block also serves as a clock provider for the
> NPCM8xx clock. This enhancement is intended to facilitate the use of the
> NPCM8xx clock driver.

Still not really much of an explanation of why an ABI break is okay. 
Reasons are generally no one has the h/w yet, or the platform support is 
incomplete and really doesn't work without DT updates.

> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/reset/nuvoton,npcm750-reset.yaml  | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

It's ultimately the platform's maintainers problem to care, so:

Reviewed-by: Rob Herring <robh@kernel.org>

