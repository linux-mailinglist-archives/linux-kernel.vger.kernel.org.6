Return-Path: <linux-kernel+bounces-313176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C645696A175
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3311EB2660C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C135184538;
	Tue,  3 Sep 2024 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eH/0t4OP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF3817D377;
	Tue,  3 Sep 2024 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375585; cv=none; b=ogjUSkShX/eGPIrORDLj7q8pr0svM+tlPD9XoxO6mew5D2vw/XWgIfgrL5s2jASxzZGdyHd6mp0/uN87rJAKCZuoK5yaZ/MQnPdmrunpE6hAQtMt+Y7cQI8EzSGzJMQznpf1yH/MB1DoCtalZnxqEMDYnrt/rgtNZZGJG5wK7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375585; c=relaxed/simple;
	bh=y0N35nBfJ/THUgvtJXQMUmozSu8LBTvwkQivhfsaVGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnOoMbJMPdmbRBSIvhwYa0s0GksWLbrONoA5WONssQvGM799p3oS00dShfZYJbdymSeVyVZrXgBQ6aYRxaY0D+1Tp/rgl8w3uFwakT3YCsnmqTLoB1kxPvY5Y9jWxhJg9eyFAhyyNGdy8D7ciM09JhAHWeUmj2VrKnytblX/8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eH/0t4OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0C5C4CEC6;
	Tue,  3 Sep 2024 14:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725375584;
	bh=y0N35nBfJ/THUgvtJXQMUmozSu8LBTvwkQivhfsaVGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eH/0t4OPEf7XTPyNlFsI5qDz/CARORolMtQ542tvolIsIJsLZDsCuIaO6+8YYIxKQ
	 PLJhW1SkZdQdojRs6QjlemFV0kLuCIYxilaObwzWXUY5gicDSrMfAiHR0wpLuJXqRH
	 o9XJ8OWRrhtC1GQkeF3ImiWmw/4KsFfBD0S5YcUz2pA0vNqq96JwI7t5c5Dq0SWLYR
	 ek8rGb/K6HJ0CVx6GdFKW5vS5O5TtWJnZOxWY9W23PgCFmbxeRF3E/PXKZDAZ/zqRG
	 caLGIYd2oJG9nGFq4qdjKai4/IJImEEgUnG+ez76hTfxT6BMgH3LRf5XwpUMZy4L+p
	 aSSaXlUo6ztyw==
Date: Tue, 3 Sep 2024 09:59:43 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	cyril.jean@microchip.com, valentina.fernandezalanis@microchip.com,
	nitin.deshpande@microchip.com,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1] dt-bindings: add IP versioning document for Microchip
 FPGAs
Message-ID: <20240903145943.GA1002295-robh@kernel.org>
References: <20240830-culinary-cautious-2c2c19902dcb@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830-culinary-cautious-2c2c19902dcb@spud>

On Fri, Aug 30, 2024 at 05:00:40PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> This is a pretty rough document I conjured up in 5 minutes, to document
> my expectations for compatible strings for both our FPGA IP blocks and
> reference designs that we ship, a la the one that exists for SiFive IPs.
> There's been some internal conversations lately about this naming etc,
> so good to have something written down.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> cc: cyril.jean@microchip.com
> CC: valentina.fernandezalanis@microchip.com
> CC: nitin.deshpande@microchip.com
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  .../bindings/microchip/ip-versioning.txt      | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/microchip/ip-versioning.txt
> 
> diff --git a/Documentation/devicetree/bindings/microchip/ip-versioning.txt b/Documentation/devicetree/bindings/microchip/ip-versioning.txt
> new file mode 100644
> index 000000000000..4a4e0e74c4e6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/microchip/ip-versioning.txt
> @@ -0,0 +1,34 @@
> +Devicetree compatible string versioning for Microchip FPGA IP blocks and reference designs
> +
> +This document describes the versioning guidelines for compatible strings
> +used on Microchip FPGA IP blocks and reference designs.
> +
> +IP block-specific compatible strings are in the form:
> +"microchip,<ip-block-name>-rtl-v<major version number>"
> +or optionally:
> +"microchip,<ip-block-name>-rtl-v<major version number>.<minor version number>"
> +
> +<ip-block-name> should be the name of the IP in Libero's IP catalog.
> +In most cases a major version should be sufficient, as breaking changes are
> +intended to be accompanied by a version update, but if not, the optional minor
> +version should be used,

Please cover where do version numbers come from?

Rob

