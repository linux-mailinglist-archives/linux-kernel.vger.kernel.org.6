Return-Path: <linux-kernel+bounces-184104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701928CA2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2936E281451
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A121384A9;
	Mon, 20 May 2024 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHXdF8FM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D508134CC;
	Mon, 20 May 2024 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716232700; cv=none; b=nVMINjI+PXxExIWbz/GnVl/KWNi0JakbXZfH/iyWSQPbOwPYDDa8imSMU0U5fCiJiWRJoIXQ1ACupI4TPMC1tkOUmWvRFFrBrqG/2XGjZVC+1SnSwp4MkrrhkUxVuu2ASEU8n1k6LKuii475XJuIXR3XpFTzYMTKhOAiaR5AI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716232700; c=relaxed/simple;
	bh=NsdyDPhe9XNdTyGY6aXb+OutlJY67HHrwCd3VMvCSek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQk37JSw+S7bXXpwCsnIcCLmmMGhCyX9I8b/BkGuWhi/H27irbzXekTCwmT5IWKYhFaldHxi0D0uIJXLw10sMNb/qzjOFGcicue0jsbuSAUZ/JypEhq0WqpBYGTtpvhomwCaBCMTEixrL3c/E4yxjtPeSAaWV/PeJ6BkJoRK9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHXdF8FM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0ACC2BD10;
	Mon, 20 May 2024 19:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716232700;
	bh=NsdyDPhe9XNdTyGY6aXb+OutlJY67HHrwCd3VMvCSek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHXdF8FMdVp7iBwZ9pPPBsDFyWzuWCSmStBF1zA2hnOFX16Qz1BLebp8ffvNRgpYv
	 CWvl0izIHD6g3m7biIYQ9L3mUKcnWT9I6Du0rFCL207sOjdaO3NRUMKenZkQvlHHA2
	 EpeV1duBfapg3dN0zNNDuKmAV0ZMvhjcG+bcPQJQ6iufIuZWdLfW5wKuWU9vvEkhpG
	 aRJkUu9wZRsIgEPKP9UMBNysC7md7qCTFsymg+MPZ2jsAz5d4DwwImWNxZ/2SpWBKU
	 1PbXJdu0/y9HGbsHc3ehjyoG85oY8wc2yLaE2PLTuwZvgzF4pZocg0OYwgkCSRuLka
	 lXj522wiktF9w==
Date: Mon, 20 May 2024 14:18:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: linux-arm-kernel@lists.infradead.org,
	martin.blumenstingl@googlemail.com, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	jian.hu@amlogic.com, rockosov@gmail.com, devicetree@vger.kernel.org,
	linux-amlogic@lists.infradead.org, sboyd@kernel.org,
	robh+dt@kernel.org, neil.armstrong@linaro.org, jbrunet@baylibre.com,
	khilman@baylibre.com, kernel@sberdevices.ru,
	mturquette@baylibre.com
Subject: Re: [PATCH v3 4/7] dt-bindings: clock: meson: a1: peripherals:
 support sys_pll input
Message-ID: <171623269646.1341930.17315530317168492239.robh@kernel.org>
References: <20240515185103.20256-1-ddrokosov@salutedevices.com>
 <20240515185103.20256-5-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515185103.20256-5-ddrokosov@salutedevices.com>


On Wed, 15 May 2024 21:47:27 +0300, Dmitry Rokosov wrote:
> The 'sys_pll' input is an optional clock that can be used to generate
> 'sys_pll_div16', which serves as one of the sources for the GEN clock.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../bindings/clock/amlogic,a1-peripherals-clkc.yaml      | 9 +++++++--
>  include/dt-bindings/clock/amlogic,a1-peripherals-clkc.h  | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


