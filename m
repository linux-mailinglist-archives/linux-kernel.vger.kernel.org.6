Return-Path: <linux-kernel+bounces-257983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B3A9381B9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 16:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87862281B93
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 14:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1259D13B59F;
	Sat, 20 Jul 2024 14:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nxb6BZot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D85328DB;
	Sat, 20 Jul 2024 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721486232; cv=none; b=lxkykiWex/U2o6DD3s2ZhOzI5iyUoTehHFtJzJRK24sM4bhEQOj+Ucv4l/2ruy7MEMx7ThirMgn8Uy2xDUc3sUmYnR8QeXBrG32NWb4V4h1hnkiXGi+24Iqfyan5caxk+VfwyqDlCWlKtVDEaLTJAmxcv5tm/prau3AWaPkcwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721486232; c=relaxed/simple;
	bh=5sIkcmDX5LYVDTGFJMDu6mH7R+pN9/g/83qb26ctnf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng+JuFwyaWUAkLkOpHQ2BbZqecqR6lBNDQ6+NI+rMw2gw0gqWHtqb4A8r7vNJxKQEdLCP6j7ehGT0CBugfEga6ILXqElNHW2URbsscwPEzM8B5VHrjJepuaF67bsHxYLXQyDKXG0RtzGRAipEonMa5qUI7cgx2Su1XXn3MG/zE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nxb6BZot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A615EC2BD10;
	Sat, 20 Jul 2024 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721486231;
	bh=5sIkcmDX5LYVDTGFJMDu6mH7R+pN9/g/83qb26ctnf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nxb6BZotZJtLGvYqZFlOzeR9UgGEfVrs4fW3okuLrZOEjTrM1HtragxnivFlUMgLy
	 yU99qb9QXrh8F9zPFWKO8mTZE1a3GUL4CdC2PK0h6wnZIZuJdIGd+Nxzb1WuVQgOiW
	 WSzzRzPMjgJDBymGSq1SWOoOmzlcVsBcrhv9fujicxj5EOk6ufBExWoLsJXbVFVOHy
	 xY2gcQbOJ2Wmk3jOL7aqoTtaG5x2JlZz54+8ooXdBroeQRlPEGMvz6xTT/OpeKiDX0
	 RKBuAeZ2ymJRpL3EJIhTmEsWS6wdg5g0XTXajuNrgoNYoU23OzCxEgLyrYSRk7UTva
	 SHvQe+aQFBACg==
Date: Sat, 20 Jul 2024 08:37:08 -0600
From: Rob Herring <robh@kernel.org>
To: Harry Austen <hpausten@protonmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/7] dt-bindings: clock: xilinx: add description of user
 monitor interrupt
Message-ID: <20240720143708.GA239850-robh@kernel.org>
References: <20240720120048.36758-1-hpausten@protonmail.com>
 <20240720120048.36758-5-hpausten@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720120048.36758-5-hpausten@protonmail.com>

On Sat, Jul 20, 2024 at 12:01:48PM +0000, Harry Austen wrote:
> This Xilinx clocking wizard IP core outputs this interrupt signal to
> indicate when one of the four optional user clock inputs is either
> stopped, overruns, underruns or glitches.
> 
> This functionality was only added from version 6.0 onwards, so restrict
> it to particular compatible strings.
> 
> Signed-off-by: Harry Austen <hpausten@protonmail.com>
> ---
>  .../bindings/clock/xlnx,clocking-wizard.yaml  | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> index 9d5324dc1027a..4609bb56b06b5 100644
> --- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> +++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> @@ -62,17 +62,37 @@ required:
>    - xlnx,speed-grade
>    - xlnx,nr-outputs
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - xlnx,clocking-wizard-v6.0
> +            - xlnx,versal-clk-wizard
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: user clock monitor interrupt
> +
> +        interrupt-names:
> +          items:
> +            - const: monitor

Properties need to be defined at the top-level (outside the if/then 
schema), then restricted here.

> +
>  additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
>      clock-controller@b0000000  {
> -        compatible = "xlnx,clocking-wizard";
> +        compatible = "xlnx,clocking-wizard-v6.0";
>          reg = <0xb0000000 0x10000>;
>          #clock-cells = <1>;
>          xlnx,speed-grade = <1>;
>          xlnx,nr-outputs = <6>;
>          clock-names = "clk_in1", "s_axi_aclk";
>          clocks = <&clkc 15>, <&clkc 15>;
> +        interrupts-extended = <&intc 52 IRQ_TYPE_EDGE_RISING>;
> +        interrupt-names = "monitor";
>      };
>  ...
> -- 
> 2.45.2
> 
> 

