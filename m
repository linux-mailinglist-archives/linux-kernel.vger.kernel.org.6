Return-Path: <linux-kernel+bounces-390432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A77789B79CB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99E61C21311
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F8719ADB0;
	Thu, 31 Oct 2024 11:37:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF610139D;
	Thu, 31 Oct 2024 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730374622; cv=none; b=R0pLa2z2ha4Qte6ms0VxBXQgk5KgJKyHwVLGe5todbnNSX67EX07T4q6pFERNJykpVqkYEM3CWJpPseuqPQXuGKG9G8sXsmLEt3XLN3KZp3uvK7uevKjP8AMXHgCHNvKVLcz/Ysrp41ijpoEmkNahV2E6NLiDErqfcMM7WlmWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730374622; c=relaxed/simple;
	bh=M+BdbzfIgqQ7peFmhkfFL9WnqYMdvqlY8WR1XO/LIso=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KB1zgv6ZTdoHrOPlO6QZgA/T3AfAcnnJJVDb0fiGHExVJRfol03jATDLIBQU8LQMe9XsCgkDe5BB86Ftv+Cd6oq28Aa/6hTlFHfJDAchXr0GMIr8napYG956MiNp4d15/1ym7bKxvdxrBQG6KVukS0ultM6B+nye1HGfjbHzyG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D78D11063;
	Thu, 31 Oct 2024 04:37:27 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 276883F73B;
	Thu, 31 Oct 2024 04:36:54 -0700 (PDT)
Date: Thu, 31 Oct 2024 11:36:51 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette
 <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar
 <vireshk@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Yangtao Li
 <tiny.windzz@gmail.com>, Parthiban <parthiban@linumiz.com>,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] dt-bindings: phy: sun50i-a64: add a100
 compatible
Message-ID: <20241031113651.4ab4f8c7@donnerap.manchester.arm.com>
In-Reply-To: <20241031070232.1793078-4-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
	<20241031070232.1793078-4-masterr3c0rd@epochal.quest>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 04:02:16 -0300
Cody Eksal <masterr3c0rd@epochal.quest> wrote:

> The USB PHY found in the A100 is similar to that found in the D1. Add a
> compatible for the A100.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Careful with that: you made quite some changes compared to v1, which Rob
ACKed, so I wouldn't carry over his tag here.

Cheers,
Andre

> ---
> Changes in V2:
>  - Update binding to allow using the D1 as a compatible.
> 
>  .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml     | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> index f557feca9763..21209126ed00 100644
> --- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
> @@ -15,9 +15,13 @@ properties:
>      const: 1
>  
>    compatible:
> -    enum:
> -      - allwinner,sun20i-d1-usb-phy
> -      - allwinner,sun50i-a64-usb-phy
> +    oneOf:
> +      - enum:
> +          - allwinner,sun20i-d1-usb-phy
> +          - allwinner,sun50i-a64-usb-phy
> +      - items:
> +          - const: allwinner,sun50i-a100-usb-phy
> +          - const: allwinner,sun20i-d1-usb-phy
>  
>    reg:
>      items:


