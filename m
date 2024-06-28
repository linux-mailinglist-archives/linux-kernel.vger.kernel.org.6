Return-Path: <linux-kernel+bounces-234440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B7C91C6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33BF5B25893
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E7A770FE;
	Fri, 28 Jun 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIufw0gN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E936F2EA;
	Fri, 28 Jun 2024 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603272; cv=none; b=J0oGAvOGWd+cjSx0bG02v2DbC7t74lVul8jGFfG8x7ja8ahQ+q9ePAASA8E2MXAl0yEdFAuqxqMlXeroCEKS5Tnhec6l8f3sbUgM29Oez2exPUwOSGvI0kNqOT5jL56tz96C5kA4x8g0jc20c89I4nqQF7lAOUWWBNtBo0AcmkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603272; c=relaxed/simple;
	bh=C7EWKeZ/Itf/nMkSN+WrPJfljzpdLEJL6x6j14lwBmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlGIChWUO6WT0JSNMafPtHioW6j6Oc59eSHsRuyknTNx7wXEAzD2GJKCwp0ea2cszZ98xZrKsLYuK5jALLsCggJR1LoC8q8elHWvPTdQl9xxrKa2QDNd/q0C4l5K0BxL9GzAry6m7fnSqEV3PAlkJFYD9Z/AFWz1nZxW2A3Vu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIufw0gN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33053C116B1;
	Fri, 28 Jun 2024 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603271;
	bh=C7EWKeZ/Itf/nMkSN+WrPJfljzpdLEJL6x6j14lwBmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lIufw0gNnTCeWAgM9QbJEGKuwG4gx/hPPI3q5+nTY0lzC1KW7jXK0D58SOO3LiqSY
	 M4Fgy0glUlArpTSRuEu41x5i4SHVXIjR6TwzTs/sYi4cGQu7Ybklxod8BxrLQEP3xx
	 cLiMxA/np1RbuJPa4CK9EyEm6JKITQ/DbgIwORtHJIhoRzAsSxEcjTIFtGQBm93Ut0
	 TF/PWX3UfkgaHkhdhjdT2Bi30aACis316tco7JGu8yr8ZMkdkO2FwjYXy9rMggPqVG
	 BzBKWnai0x3+yWKXT1HDnMctjFvW+hongVAXqdTzzz1N2k1MztxHGVn7nygmUfOCVP
	 S2lu/baDT+rtw==
Date: Fri, 28 Jun 2024 13:34:29 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzk+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev,
	krzk@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: interrupt-controller: convert
 fsl,ls-scfg-msi to yaml
Message-ID: <171960326528.87484.2982631771011170699.robh@kernel.org>
References: <20240627144207.4003708-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627144207.4003708-1-Frank.Li@nxp.com>


On Thu, 27 Jun 2024 10:42:07 -0400, Frank Li wrote:
> Convert device tree binding fsl,ls-scfg-msi to yaml format.
> 
> Additional changes:
> - Include gic.h and use predefined macro in example.
> - Remove label in example.
> - Change node name to interrupt-controller in example.
> - Fix error in example.
> - ls1046a allow 4 irqs, other platform only 1 irq.
> - Add $ref: msi-controller.yaml
> - Add #msi-cells.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - sort compatible string
> - add ref to msi-controller.yaml
> - add msi-cells
> - add interrupts description
> - remove msi-controller, which already in msi-controller.yaml
> ---
>  .../interrupt-controller/fsl,ls-msi.yaml      | 79 +++++++++++++++++++
>  .../interrupt-controller/fsl,ls-scfg-msi.txt  | 30 -------
>  2 files changed, 79 insertions(+), 30 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-msi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-scfg-msi.txt
> 

Applied, thanks!


