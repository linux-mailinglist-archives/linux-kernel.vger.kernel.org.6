Return-Path: <linux-kernel+bounces-213435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FA090754E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA7A4282143
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C658145B2B;
	Thu, 13 Jun 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhIpNOlH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82114430A;
	Thu, 13 Jun 2024 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289505; cv=none; b=f/SZPuqirTNL3Pd5gN4uqKcNG0RtjZSYgKkkgDH7fVRJvxiCG3IY4/TgmXlXsWyylK6ekIOJffaWYb7FOgzmVLptsiB7FtEk/B8V7segrTRUK4PiQloSnmkM4whQ4Ub+GBw2kAsVq+i8wat5u6CQrCaBgBEZ/o/1LeTifM1nB3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289505; c=relaxed/simple;
	bh=YCyWvXs7ccGLcK7Bb9cOb1o2iNUCARltormWAwDzO3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF51sxMdKsbUOza700Fwten3cMYQJMEmBWQ/L8A5uWkV2Jous1dBJ6EZ2kIqQFDTqyNfCpsevEZN4Ia42BVjLXy4h7Kv9RdREqeNI7agTNc62BOfad1H1IrMrAOymFI6h/ubmdq3CJyC2O+pTuaX6MhVOp1vFyjxMFkUNuvipwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhIpNOlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A1EC2BBFC;
	Thu, 13 Jun 2024 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289505;
	bh=YCyWvXs7ccGLcK7Bb9cOb1o2iNUCARltormWAwDzO3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhIpNOlH9gZP1QbHOCGOF9z/cnp5aJn36mwQjFK35+/iMus4YgxB5rfIpCA1Lvuns
	 AhUK7l9X7/H/vOA3JlpZaouOcMctQkQvPOru4uZWRw+fag9SASVkiY/gZ3kKQHnWJ0
	 ZOIiKBrowT7808QpX+UUbNM/70PZp/wrehvmr85awAOdFi/I/YGVCfxaC8fU1CA/K/
	 pEoM+88rwjxYGJIBC3tVrFLoVPYZCFaHNw+DR4t0xU5RGZcXG78csLg1mNze9cf2Xj
	 W2r5y933KUwlM7fb/dAyRv7Eyh5jH5Auzfv+x/uoSZm426Hpthec5tTS/AAp8RUKKR
	 YYV69gFd5WkdQ==
Date: Thu, 13 Jun 2024 08:38:23 -0600
From: Rob Herring <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	broonie@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] dt-bindings: mfd: twl: Fix example
Message-ID: <20240613143823.GA1612105-robh@kernel.org>
References: <20240612134039.1089839-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612134039.1089839-1-andreas@kemnade.info>

On Wed, Jun 12, 2024 at 03:40:39PM +0200, Andreas Kemnade wrote:
> Fix example to also conform to rules specified in the separate
> not-included gpadc binding.
> 
> Fixes: 62e4f3396197 ("dt-bindings: regulator: twl-regulator: convert to yaml")

Reported-by: Rob Herring (Arm) <robh@kernel.org>

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/mfd/ti,twl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> index 2cbdd238f48f..e94b0fd7af0f 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
> @@ -225,6 +225,7 @@ examples:
>          gpadc {
>            compatible = "ti,twl6030-gpadc";
>            interrupts = <6>;
> +          #io-channel-cells = <1>;
>          };
>  
>          rtc {
> -- 
> 2.39.2
> 

