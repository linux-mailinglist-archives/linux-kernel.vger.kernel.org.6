Return-Path: <linux-kernel+bounces-574694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443CDA6E899
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98E86171BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2394C1A3154;
	Tue, 25 Mar 2025 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsBhj5qt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB464A18;
	Tue, 25 Mar 2025 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872555; cv=none; b=HR90H7YfyHs0SAhFnCTyudEp/K8ts4uZG7gLiwjJTtzaiGh/oZXKbDCeNmJMsT4tPBZAMP/S66jmv2Qyi3QmEasrZOX7tjln0aXTkA1JQudp9El3BNBk/wqccDY521puxRV93AfccFS5ezE/W9zy/vxGSYl7qCTN2P7vkA2bhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872555; c=relaxed/simple;
	bh=UYq/txzFsantq3b8jqRCM+xNHMpOjKTAuT0gaOcj0c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BiJyZBcFmf8Ca0XeGqZr+uZMsznzFDQTcCtk4pqpgDA5lu5oPYkW6TbhTyZmPIwskZNM7OCPqpyHsbMIP/VwwCsHx2/f5Q5wMycea+LWobzDf8bF+jXePLZqM/ZgZT+1iT2y74EbBq2U/2RbT6ME2IQv9ZLjpvowKQMsD9aANqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsBhj5qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8CB5C4CEDD;
	Tue, 25 Mar 2025 03:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872555;
	bh=UYq/txzFsantq3b8jqRCM+xNHMpOjKTAuT0gaOcj0c4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsBhj5qt96M2t1g9jh/NSydn1oi1h400Cn423+7PBNgR7xISxsA41xv3O3CbYT/kP
	 EkO0l9s0IF3tTVr/C3GUb0fUnZvR2dCoiLZgnXkUr/eWmw9R7XtXDY0lZ/Q47zR8yq
	 x5L+INEIcaQHTIaPB1EEh0e/nFnv9dwuB4lAkeJh1al4K2Wu1ijuWhYCjYp/SIMrNO
	 t/QuKUY6AR3XuBbIfyzZeFxfWthGw5Dc2vyCCgH9PCBO23aX6STSobbrCn/0kCVbUD
	 lO3LxVcN8CFlPPpFMFKHvIO7DlzC+dw/lffrspfZxLK3ZmVWP0+TAk1MEN7MQvqLQh
	 OlXvqsLxg+YOw==
Date: Mon, 24 Mar 2025 22:15:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Dongjin Kim <tobetter@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: smsc,usb3503: Correct indentation and
 style in DTS example
Message-ID: <174287255341.1622293.3591463539769381439.robh@kernel.org>
References: <20250324125142.81910-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125142.81910-1-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:51:42 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/usb/smsc,usb3503.yaml | 84 +++++++++----------
>  1 file changed, 42 insertions(+), 42 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


