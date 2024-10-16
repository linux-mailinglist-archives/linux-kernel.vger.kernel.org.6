Return-Path: <linux-kernel+bounces-368506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6189A1098
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1B41C218F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A72101B7;
	Wed, 16 Oct 2024 17:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bejmBuPz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46620C487;
	Wed, 16 Oct 2024 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099662; cv=none; b=DlPwp8ezIxckTvXxLeLnN7ugwkOm1IhLOteowSC3KrIEAg3A13+a89a5oKUNfJ8zbHi0SxwteXfT7W93Vy8F7xfedP87+tsE4JJNXl43P8k2qNvW5dJlu13t5tu8wzGC+RctiHW+nhJIA46UFyX5VtjoCGaiF72ISS6kITEWUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099662; c=relaxed/simple;
	bh=272Q2s1xa44MaO0n8oTBTXmRy6jsjZZweNSs8qCpZvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zue6zRCyynt2PkPW+jyr9txVbl+GpKc+8kl2M3u4KOfBUmuj42AXBg/ivCH0xAVWmIq3neN19r1WCfpyQAG71OhPstg7GQsaqHmpFuhsFMbebAyKjkCv497xhGEMOFm3JY7rK/Q6c/46ia4hPJNq3E6bicR03Em/SilvnuULZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bejmBuPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AF4C4CEC5;
	Wed, 16 Oct 2024 17:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729099661;
	bh=272Q2s1xa44MaO0n8oTBTXmRy6jsjZZweNSs8qCpZvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bejmBuPzVsy4XgbhsU5iXKhZ/oFvXw9OV647k+dksp2e5R82EObDVVzlwt+ePy6ex
	 x8ka188rIEmvUzA60c63yetG7cF/RynGSaWLgVJUFT84Q2MJuWOI8aqcVpjWo4jYrB
	 hnJ7Xfl7QuRX2/Xg9RwHLObGBhPlTpx68EN7GdyJldt+9DFjhBavMfrnnuNX2PIi47
	 ywKx7J6Xnb8XjnOOCBch2OlNf149br0VT8pViAOsQzL3DyXFtNJqtFo4/t2coT85Az
	 GE+aPP6VRn9kRR0zl/MaAsqiTY/2H17ZAxgE2NA7CO6xFcVJp92YtiSIJHxo0cJ4BI
	 2VTpnaoQ6+H9A==
Date: Wed, 16 Oct 2024 12:27:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: joel@jms.id.au, conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, tglx@linutronix.de
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
Message-ID: <172909966003.2068484.893211890028147027.robh@kernel.org>
References: <20241016022410.1154574-1-kevin_chen@aspeedtech.com>
 <20241016022410.1154574-2-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016022410.1154574-2-kevin_chen@aspeedtech.com>


On Wed, 16 Oct 2024 10:24:09 +0800, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) contains second level and
> third level interrupt controller.
> 
> INTC0:
> The second level INTC, which used to assert GIC if interrupt in INTC1 asserted.
> 
> INTC1_x:
> The third level INTC, which used to assert INTC0 if interrupt in modules
> of INTC asserted.
> 
> The relationship is like the following:
>   +-----+   +-------+     +---------+---module0
>   | GIC |---| INTC0 |--+--| INTC1_0 |---module1
>   |     |   |       |  |  |         |---...
>   +-----+   +-------+  |  +---------+---module31
>                        |
>                        |   +---------+---module0
>                        +---| INTC1_1 |---module1
>                        |   |         |---...
>                        |   +---------+---module31
>                       ...
>                        |   +---------+---module0
>                        +---| INTC1_5 |---module1
>                            |         |---...
>                            +---------+---module31
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  .../aspeed,ast2700-intc.yaml                  | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2700-intc.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


