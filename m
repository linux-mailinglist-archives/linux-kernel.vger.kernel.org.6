Return-Path: <linux-kernel+bounces-535758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F445A476CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3ED3AC83B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C222333D;
	Thu, 27 Feb 2025 07:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDmlBXMU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEF38DF9;
	Thu, 27 Feb 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642493; cv=none; b=gJggRz4HkKIiN2Ifs+tAW3fwqYPwB88e1yexwLmaA7x4i3fNRo0tTfHTi2VWWhQIi5ClljfqJWU84ynSvPrhAyxlBA3IE+YjAw9A42MiCvdu0KJwO3N1tdU6RE0HeF9G/l0xNOxfKLOOBnwzryXPTw+yClKTtManZekUkpAgPlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642493; c=relaxed/simple;
	bh=3hYVLitfg1qAcrjHx6qDFufWzXOiu0Ripju1RMLtR4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWtXfJQoW54XPC899hh2NfbzKkQHT3av5Yi5MG6wKRQewodgf+LfA6yUx8l5TB98/wM2bH3fNBmFx4GdvQzMXoeGGQUiIJwgoxWBkxPZJCC4rj8mfYP+OyzCVfBzF0k6I46ExvUg9qqLP2K/lJ6T3WH+sdms59gy+ZGqfKnjeVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDmlBXMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AA4C4CEDD;
	Thu, 27 Feb 2025 07:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740642492;
	bh=3hYVLitfg1qAcrjHx6qDFufWzXOiu0Ripju1RMLtR4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDmlBXMUlUCBgfDT40Vh9WUJ2lpVkLiPbhKDT/LtOLeZsCQ2XRCIAKEvHcvqUytPV
	 N0jrvy2OxtNVi6YaHfPtoGHN9rrAQyb1e54yTqA+uaMpfkz5HRROeMgWL1d4ygAvF0
	 un7MgXCKiTB1Zw8DH9n+5V5pKtVvAvi0rEkbN4m5wkBhZae2XGVf49nltcvdkidCJq
	 dICFV8ItGfly8F5j9wzrEQ22cej24JZfD3XEKNdv8fXVatvDXOqT4DX6oPJuXLF4v0
	 9GTGrTK2hZYIslM4q0imGxmLiBm2b1Yy438eE6ECD6MyoUujnWW7/pa+PVLUr4qU+Z
	 6JLhnE495nZQQ==
Date: Thu, 27 Feb 2025 08:48:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>, Stephen Boyd <sboyd@kernel.org>, 
	Shengjiu Wang <shengjiu.wang@nxp.com>, Adam Ford <aford173@gmail.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, linux-clk@vger.kernel.org, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: clock: imx8mp: add axi clock
Message-ID: <20250227-ubiquitous-hopeful-beluga-effd3a@krzk-bin>
References: <20250226164513.33822-1-laurentiumihalcea111@gmail.com>
 <20250226164513.33822-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226164513.33822-2-laurentiumihalcea111@gmail.com>

On Wed, Feb 26, 2025 at 11:45:10AM -0500, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Some components of AUDIOMIX (i.e: DSP, OCRAM_A) are clocked by
> AUDIO_AXI_CLK_ROOT. Since the AUDIOMIX block control manages the clock
> gates for those components, include their root clock in the list of clocks
> consumed by the IP.
> 
> Fixes: 95a0aa7bb10e ("dt-bindings: clock: imx8mp: Add audiomix block control")
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx8mp-audiomix.yaml     | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


