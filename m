Return-Path: <linux-kernel+bounces-430784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE989E358C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38564284F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B1E194C77;
	Wed,  4 Dec 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTBfmq30"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B394194A65;
	Wed,  4 Dec 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733301372; cv=none; b=svm7OReZkimjmvBqgt86GZHxOvQUIxHCSbNNYQ2muYlBhnHN60i8ChNBLbYJaC/Vr4LtmoPQhqu/zLpKHLvadM/1+zhpnX5gXBK3VepjI7GwirFpuMGIEhEU2ngb/pKVjzK/OcA/6F9UJ7afEPthLAU4gG/vthUqu8FW4OQTJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733301372; c=relaxed/simple;
	bh=JWq/BGvkJk1GK8sFxZgwWJnaeKD4x2uHKRtWIOrvvJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFjDdPrHIcVmLmkuzPVY583jq0AMuMAWRYKdpMzsHRqfuJSpBnpmPeJyxyOM5EhhgkC7BHMrMbfPCtbe4YiMmRoRGh3hovBut5YB73XStRM/4c5PeLPW5UG3c0WUEKrzHxDZyRbLVEcWBe8S975ZsRz1Ll073xtLQ8q8Sqc6Adc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTBfmq30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E188C4CED1;
	Wed,  4 Dec 2024 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733301371;
	bh=JWq/BGvkJk1GK8sFxZgwWJnaeKD4x2uHKRtWIOrvvJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sTBfmq30FV+yv6D6qxx5+g49rCUcXNB+muo4iirc0b60cx2+yK6Ct7MFtF5qgpN9W
	 p5UH6vKUhwvs5XhLF0eHazQ29WG69FP5lk5viku+3wEyrR34A03I4o6U5SuAlJez+Q
	 maTf63n61b+Jq6J7VC9LXNeIdRTZcDf1r9eY3DjPN9nHhs89UTIQ7GuF3u/b6qv7ES
	 u5aB95NtHEAYXH48ZzLuEszqC9nax+AbRgj13xTHH3EOuTD/U8xSidRHWeGImT4ZzZ
	 JenzgCuaut10ssMm9qSGeKH9qvTzkaAJIegGe3PQrp2pG4oDd/CaSheehbquu02sel
	 CrUXij4gWaRnw==
Date: Wed, 4 Dec 2024 09:36:08 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: soc: ti: ti,j721e-system-controller:
 Add PCIe ctrl property
Message-ID: <kno3z5nszu4437kvon5nxmxv6qzhjagdjti2guljowmmvkbskr@6falbmmpidki>
References: <20241203173113.90009-1-afd@ti.com>
 <20241203173113.90009-3-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203173113.90009-3-afd@ti.com>

On Tue, Dec 03, 2024 at 11:31:12AM -0600, Andrew Davis wrote:
> Add a pattern property for pcie-ctrl which can be part of this controller.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../bindings/soc/ti/ti,j721e-system-controller.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> index 9ba9cb100ab30..ead0679b30e3f 100644
> --- a/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/ti/ti,j721e-system-controller.yaml
> @@ -74,6 +74,12 @@ patternProperties:
>      description:
>        This is the ICSSG control region.
>  
> +  "^pcie-ctrl@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/mfd/syscon.yaml#
> +    description:
> +      This is the PCIe control region.

This device (parent) is a syscon already. There is no sub-block
representation, because what would be next? Third child with a node per
each register?

Best regards,
Krzysztof


