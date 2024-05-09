Return-Path: <linux-kernel+bounces-174171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CC8C0B32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60556B20E7B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF2F1494BD;
	Thu,  9 May 2024 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5uTbjO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CEE1A2C2A;
	Thu,  9 May 2024 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715233873; cv=none; b=UVWsx7zP5PFfdVclzEv6o+E4QaaslF7b4KspheZhbH20lv6TBK6oxZP5YSWIlLiuQ8jEfae3NyY44l1QXMj55ScxwWPAaiIJ0L+pHZMgtL4jtFeEPAeuWvjkVtAzYFqdaZr8AeXy9WcVR8qoVZZr5swE4txpgXxO1ks7hjfnLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715233873; c=relaxed/simple;
	bh=JrahC9u3iZ2EEYCRi1f+9st8RuDxEJwQs/PRe7O4KYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko4mnI9o1RR0VrEtFIrUnIt0CpWhA0i3dqBn6A5627NKmUJoB1CVFSiRd6854m6lPYJaJpufn9GL+J+29/pBMRdAzafG5R1LC9FeHRxLLCly0YAbdS8WqmsclXdUJ9fu6SrXoovzr5CnwFBNbtxhWCyLJ4XQa0XhG/1FE6uxUTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5uTbjO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86399C116B1;
	Thu,  9 May 2024 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715233873;
	bh=JrahC9u3iZ2EEYCRi1f+9st8RuDxEJwQs/PRe7O4KYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M5uTbjO7YOZrR6uyg9Ln6X3dHgEXn5rzLsp44/fz/cE0Da+km5F8Sb+XR3IbzwjSP
	 GvUEHkNWvlg0RTFy5SVFO+220c2Xs69+7rjaie0iu6gJFz3qD1A08of+OeHt7THvEo
	 ZvFeAterHuHXDbZrFXpmEy6MQsTbkouyKQz6LMG2teauAQwGhbYSdmOcNcjb7BVaVp
	 OIfX5jnu3mhxQ53HUGjQFbZPRVNd0RbrxDTjBiin/Vo5glWlUPLR/yS6ijzjDUkKlu
	 c/xlhNJQXBv2iLaEd4WkpfDX3n5qYqXCdf7jwjwp2Tdh+olMQZHMsi273EBKgm0eC5
	 Maf7OUf7KR42Q==
Message-ID: <81241dde-da0a-4817-90f4-37741d652600@kernel.org>
Date: Thu, 9 May 2024 07:51:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] soc: imx: secvio: Add secvio support
To: Vabhav Sharma <vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Franck LENORMAND <franck.lenormand@nxp.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Varun Sethi <V.Sethi@nxp.com>, Silvano Di Ninno <silvano.dininno@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, frank.li@nxp.com,
 daniel.baluta@nxp.com, Iuliana Prodan <iuliana.prodan@nxp.com>,
 Horia Geanta <horia.geanta@nxp.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2024 02:45, Vabhav Sharma wrote:
> The tampers are security feature available on i.MX products and
> managed by SNVS block.The tamper goal is to detect the variation
> of hardware or physical parameters, which can indicate an attack.
> 
> The SNVS, which provides secure non-volatile storage, allows to
> detect some hardware attacks against the SoC.They are connected
> to the security-violation ports, which send an alert when an
> out-of-range value is detected.
> 
> This detection is done by:
> -Analog tampers: measure analogic values
> 	- External clock frequency.
> 	- Temperature.
> 	- Voltage.
> 
> - Digital tampers:
> 	- External tamper
> 	- Other detectors:
> 		- Secure real-time counter rollover tamper.
> 		- Monotonic counter rollover tamper.
> 		- Power supply glitch tamper.
> 
> The on-chip sensors for voltage, temperature, and clock frequency
> indicate if tamper scenarios may be present. These sensors generate an
> out-of-range signal that causes a security violation to clear the
> authentication and storage keys and to block access to sensitive
> information.
> 
> Add linux module secvio driver to handle security violation interrupt.
> 
> The "imx-secvio-sc" module is designed to report security violations
> and tamper triggering to the user.
> 
> The functionalities of the module are accessible via the "debugfs"
> kernel.The folder containing the interface files for the module is
> "<kernel_debugfs>/secvio/".
> 
> Get status
> Reading from the "info" file will return the status of security:
> - Fuse related to security tampers.
> - SNVS readable registers.
> - DGO registers.
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
> Vabhav Sharma (4):
>       dt-bindings: firmware: secvio: Add device tree bindings
>       firmware: imx: Add SC APIs required for secvio module
>       soc: imx: secvio: Add support for SNVS secvio and tamper via SCFW
>       arm64: dts: imx8q: Add node for Security Violation

Please version your patches correctly and provide changelog.

I wrote about b4 already, which solves this as well.

What changed here?

Best regards,
Krzysztof


