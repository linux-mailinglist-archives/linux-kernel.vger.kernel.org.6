Return-Path: <linux-kernel+bounces-532595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C64BA44FA8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4263A7A830A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EF2135AC;
	Tue, 25 Feb 2025 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kf0/bEQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F5205AD5;
	Tue, 25 Feb 2025 22:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521987; cv=none; b=rbbATnz5qU6HoKcTJYxXz4xeZKhSg0dQ48S64pXALMEWo01wlZwG5RUK8tCGmQGSI7HvvSqiYpyXBuKBWbfIaHUVv9zjfnQnGsE2s4lkEt2ft1EANfmxQ6nMh5Ls7gcvdLHwmMKI65tQidOTVZoXIZ/nQtBf0KcgAw2D3BvTCHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521987; c=relaxed/simple;
	bh=TANQYzB1886UmeQzDlCLoNcgrnAbMsw3OoBhnNvk5Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWKcjH9OQdhg23ePerV4HFbmbwdxZrdVUl4FsHyphv5NtDw1eNTH1/tkhKEHcv1BLm8T47r0tlgTYkNndWJScSlfCO1Guq8HioE3oLwiw82iRK2rxpDru9+hn3r6pIv5ZeJMTGqtkaogZkHJBplySZ5+1c0SVWqU03YQHgbwLbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kf0/bEQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC107C4CEDD;
	Tue, 25 Feb 2025 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740521987;
	bh=TANQYzB1886UmeQzDlCLoNcgrnAbMsw3OoBhnNvk5Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kf0/bEQaQ6BGV+A+AeZtXG4YymD2WNfmbKdZUWclPm3e3xoWIvV698ZUYCovA8Oc1
	 eSWj3QSkpoalrS2Bnv1vPs2+JiUSzcNQWFZWGE+sWIGvo21I6QVv/iF9eALh/F86iN
	 LKI4W3GnW25TPzSkxkkVbGx1SnI0eGHe319/Fl0LknY/AjOT4h+qRwNVTRiNJxB7mw
	 s3rP7cRsXW/Zdi16NHSFNudQHY3aMPU9TCiUQi6LZtbyUE6SJXxsmGVvPX88/LJ7ik
	 uq9EFHC4jfhm2nSjmqaqPAOodRwVErNMMFwId/IOEmCywM4IP/cztGH3YMn9XwTBdx
	 pUkDjka9gWtoA==
Date: Tue, 25 Feb 2025 16:19:45 -0600
From: Rob Herring <robh@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-sound@vger.kernel.org,
	Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] ASoC: dt-bindings: xlnx,spdif: Convert to
 json-schema
Message-ID: <20250225221945.GB3224894-robh@kernel.org>
References: <20250225190746.541587-1-vincenzo.frascino@arm.com>
 <20250225190746.541587-4-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225190746.541587-4-vincenzo.frascino@arm.com>

On Tue, Feb 25, 2025 at 07:07:45PM +0000, Vincenzo Frascino wrote:
> Convert the Xilinx SPDIF 2.0 device tree binding documentation to
> json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../devicetree/bindings/sound/xlnx,spdif.txt  | 28 -------
>  .../devicetree/bindings/sound/xlnx,spdif.yaml | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt b/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
> deleted file mode 100644
> index 15c2d64d247c..000000000000
> --- a/Documentation/devicetree/bindings/sound/xlnx,spdif.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -Device-Tree bindings for Xilinx SPDIF IP
> -
> -The IP supports playback and capture of SPDIF audio
> -
> -Required properties:
> - - compatible: "xlnx,spdif-2.0"
> - - clock-names: List of input clocks.
> -   Required elements: "s_axi_aclk", "aud_clk_i"
> - - clocks: Input clock specifier. Refer to common clock bindings.
> - - reg: Base address and address length of the IP core instance.
> - - interrupts-parent: Phandle for interrupt controller.
> - - interrupts: List of Interrupt numbers.
> - - xlnx,spdif-mode: 0 :- receiver mode
> -		    1 :- transmitter mode
> - - xlnx,aud_clk_i: input audio clock value.
> -
> -Example:
> -	spdif_0: spdif@80010000 {
> -		clock-names = "aud_clk_i", "s_axi_aclk";
> -		clocks = <&misc_clk_0>, <&clk 71>;
> -		compatible = "xlnx,spdif-2.0";
> -		interrupt-names = "spdif_interrupt";
> -		interrupt-parent = <&gic>;
> -		interrupts = <0 91 4>;
> -		reg = <0x0 0x80010000 0x0 0x10000>;
> -		xlnx,spdif-mode = <1>;
> -		xlnx,aud_clk_i = <49152913>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> new file mode 100644
> index 000000000000..ea07c0b0d003
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,spdif.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,spdif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx SPDIF IP
> +
> +description:
> +  The IP supports playback and capture of SPDIF audio.
> +
> +maintainers:
> +  - Vincenzo Frascino <vincenzo.frascino@arm.com>
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,spdif-2.0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: spdif_interrupt

This was in the example, but otherwise wasn't documented before. And the 
Linux driver doesn't need it. So let's drop 'interrupt-names' because it 
is pointless here. 'spdif' is redundant because this the the spdif 
block. 'interrupt' is redundant because it's only interrupts in this 
list.

Don't forget the example.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

