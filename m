Return-Path: <linux-kernel+bounces-199318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D418D8577
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F46A1F22EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E812FF71;
	Mon,  3 Jun 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkYkmz2G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555512FB09;
	Mon,  3 Jun 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426325; cv=none; b=l70FSMbn2XEYX8vJfArk9JbesAVWtKGjScUIWiA7D/1zMCdbGdOAE5x/UxexHZHY2+30LFRaQM5xJrK+JLfyY1V6K8L7kb7f/6BpR1xNvssA8ENmrCZj72b/wmWDuI9+Yg/2Q0FCdO8Sxy7FmVLAxxtHXzJbhEGLIGllzcNZusc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426325; c=relaxed/simple;
	bh=mhH61b2GUcMaPuimjybrsTq1Ou2q7uk9/KoQVRqHTT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqrymDraQBiWAIXDGx5QBsnk54YlKAN8LzLO+8Qk6G1cGyMK5kvZJvHhjioGXZE5myCYsNz3/UY1fkEJ/f84qY0tKfWVOdSYIlDIYu5JhK3HeOguTXrvUQvQNYJq4IXFuqYfAFOxWMyPL7p+mMweCWwvlZWiI/1S8xTlR2qxGQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkYkmz2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69460C32781;
	Mon,  3 Jun 2024 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717426324;
	bh=mhH61b2GUcMaPuimjybrsTq1Ou2q7uk9/KoQVRqHTT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkYkmz2GHRngm4bSMAzP+8az4li4SpEY/u36P9GB3VgoM/yvWp5eogAmtJS5ZsyQE
	 SvNdybErwGz4ryu7T6AneyrJ3j4nzTYxIx/8Hvrh6IbeOpNWUnk7g3Cq8eGBd8wuVA
	 YVM6+5k6qXcbWVVXAZ7G4WS+SEUcjwhcRkmaZA6xhXArL6ThjDA044WFRkA5VNTqkt
	 1QXlxAIPMu3xBRmuu4hC69YqYbP1x+/MR7vEwInYPSWzplB7AoTB3YxyqJkfkBIryf
	 eeah3RN0Z9NkDdhanM4vNcz7Z/ZUIYz0xJE1KtG0MR+eViippP5QBZF3PYJD4VIQ5Y
	 K2tmcDQ+LhHNQ==
Date: Mon, 3 Jun 2024 09:52:01 -0500
From: Rob Herring <robh@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
	git@xilinx.com, Conor Dooley <conor+dt@kernel.org>,
	Kalyani Akula <kalyani.akula@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] dt-bindings: nvmem: Use soc-nvmem node name instead of
 nvmem
Message-ID: <20240603145201.GA414800-robh@kernel.org>
References: <42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com>

On Mon, May 27, 2024 at 10:53:50AM +0200, Michal Simek wrote:
> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
> why also update example to have it described correctly everywhere.
> 
> Fixes: a0cfd5e99782 ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> index 917c40d5c382..1cbe44ab23b1 100644
> --- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
> @@ -28,7 +28,7 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> -    nvmem {
> +    soc-nvmem {

This doesn't seem like an improvement. Is there another nvmem node at 
this level? I would fix the binding instead if not.

>          compatible = "xlnx,zynqmp-nvmem-fw";
>          nvmem-layout {
>              compatible = "fixed-layout";
> -- 
> 2.40.1
> 

