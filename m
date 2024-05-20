Return-Path: <linux-kernel+bounces-184091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1200A8CA279
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14A9281F5B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7811384B3;
	Mon, 20 May 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAiKxWSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E531CA81;
	Mon, 20 May 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716231766; cv=none; b=ogj4Z04DvZEi6W+UOoqfVnNSR8oDoPuhl19o15ccjl/c6HCk8n9MW+6ToHsZlcHZFlV2qIxC0gZWaaHinTPo84FmphkR2tr9QQdNBOAN3Z2iTeKLmvbzRdZR/EYUFlQF/NM2m281KagXnsiUJcnFI2MYo3gNWjZCU/JmSCymswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716231766; c=relaxed/simple;
	bh=dkXTesGMU6jZNIordQLu62eFnIDpxh9YbpGxrA3wPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iG6AF8SBcWvYjOKjWcrDm6WojDX8io7dFqplLdhW+mpf0PDVv0GpwjXujq1Y1RuPhZmDByUVHk+T6Spt/Om+dbzac6/L0Ldcno6zaiOadJLXNV6bc2MJHz8vTxYqG1pnhr6e1nHJUjgS5AzVUA87Zo9AC46b3cbRATWoyNOnqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAiKxWSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4173C2BD10;
	Mon, 20 May 2024 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716231765;
	bh=dkXTesGMU6jZNIordQLu62eFnIDpxh9YbpGxrA3wPHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAiKxWSjaXKR4mqQ6nLwgo9Xh3p5iz/KCWxCXJWMtUnnVtR59AyjBBSRAdcb8xzum
	 uy4bil57SaeFr1eYLHFjWp3Gtb/CF792chYvi1v97c3YGl27IeLNcWLQgix11MPs1z
	 8fXekqVVQJ1zWcZd8z5pmIGKVI1rCCwUMnc5V0ZeXtkwIWNQjBrxlkcvtqir8+haO+
	 ws/P2Ctgc/8chsKq5lCiLJ/qqtPs8DlNzmGkYK1sE7GqY/TQ7hZWb/Gcp/jBaWQhyq
	 X2f1kGXnqgqjZxfhjM9OYwRReGsKbX2gNg5Z+XUlEk1bPJT4Ug9tq6qSXM9TRrShvR
	 OD3aTAHoWsu3w==
Date: Mon, 20 May 2024 14:02:44 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: linux-arm-kernel@lists.infradead.org, jian.hu@amlogic.com,
	kernel@sberdevices.ru, linux-amlogic@lists.infradead.org,
	khilman@baylibre.com, devicetree@vger.kernel.org,
	neil.armstrong@linaro.org, sboyd@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, mturquette@baylibre.com,
	linux-kernel@vger.kernel.org, rockosov@gmail.com,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/7] dt-bindings: clock: meson: a1: pll: introduce new
 syspll bindings
Message-ID: <171623176256.1307290.6324910189601723683.robh@kernel.org>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
 <20240515185103.20256-3-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515185103.20256-3-ddrokosov@salutedevices.com>


On Wed, 15 May 2024 21:47:25 +0300, Dmitry Rokosov wrote:
> The 'syspll' PLL is a general-purpose PLL designed specifically for the
> CPU clock. It is capable of producing output frequencies within the
> range of 768MHz to 1536MHz.
> 
> The 'syspll_in' source clock is an optional parent connection from the
> peripherals clock controller.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml   | 9 +++++++--
>  include/dt-bindings/clock/amlogic,a1-pll-clkc.h          | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


