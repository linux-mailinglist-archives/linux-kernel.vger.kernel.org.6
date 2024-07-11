Return-Path: <linux-kernel+bounces-249375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9654892EACC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2E391C21B99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9952A167D98;
	Thu, 11 Jul 2024 14:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxZ3BMHM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC190158DA8;
	Thu, 11 Jul 2024 14:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708435; cv=none; b=PRB1+WifjEnV/H5sTH5D7MDlpNNGdHjzpauw1aJCQOwuFMdxUVK8SO22EUMmMVqLbEq/+j8wu6tMkDKzn19AkYX64XrMsDaUS0X4H+y8cQw8rpWmR/On4ziuwcyzqUFkl2jCgugxcpvBBACxvG7Vt7/m4u3PrO07aUOtVBJe/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708435; c=relaxed/simple;
	bh=8Ra/Y5v1rARhsoO0bv3pLK/R77pCMZPwXiKQi7lwrjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL3pA6NJ93IBPBIaf7Ky3Uqi8y3OvMFtsCExQ9P62cpVY2e3bwPUY5ATqLo0oLQVur9lO34POSbTh1cNUSZy0MEmm4KxBA81C/Vn/dgaqizJydpoMryFYlghVU9EtWigi4FhCzw0FgEZIOYKfuIvj+Rvf2QQyNC03ufKKIyWCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxZ3BMHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4905DC116B1;
	Thu, 11 Jul 2024 14:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720708434;
	bh=8Ra/Y5v1rARhsoO0bv3pLK/R77pCMZPwXiKQi7lwrjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UxZ3BMHMyepZ+ddcEaKgcLqR1EZmLwyWSCqPB5hqtTpUc3461IMdtlKSTgu2+k2uz
	 /Na3s8WmdfKEJWLyBa1arhyxo0VLwPI057Xlp/L/9jM+yLSjWExI6WlXdYIqfspgQ3
	 M68mAsYjmgl7KmVpwDohQz3om/46KeHqeMb5olh2yKNutnMZg7bUYGjmp0e9wtYUpO
	 k4v34sOkKaY+TrZIGFd6b8cHevmfR/QkOYnAb7SUMGnNThsDvupZpbrS+LH/BMA1Ue
	 Ep57zigKRYcMhtnE/yNCrGHc6pBhpQYyWKk4MLt0Hsa9G0JGSnlymYdjFkzN4FFz9t
	 tT7nMcVPYSsrA==
Date: Thu, 11 Jul 2024 08:33:53 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: trivial-devices: document the Sierra
 Wireless mangOH Green SPI IoT interface
Message-ID: <172070843090.2279442.10031624513067815201.robh@kernel.org>
References: <20240710-topic-mdm9615-mangoh-iotport-spi-bindings-v1-1-3efe20cfea8a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710-topic-mdm9615-mangoh-iotport-spi-bindings-v1-1-3efe20cfea8a@linaro.org>


On Wed, 10 Jul 2024 19:02:52 +0200, Neil Armstrong wrote:
> Document the Sierra Wireless mangOH Green SPI IoT interface as a trivial
> device.
> 
> This fixes the following check:
> qcom-mdm9615-wp8548-mangoh-green.dtb: /soc/gsbi@16200000/spi@16280000/spi@0: failed to match any schema with compatible: ['swir,mangoh-iotport-spi']
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!


