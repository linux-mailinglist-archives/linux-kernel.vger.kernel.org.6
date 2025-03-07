Return-Path: <linux-kernel+bounces-550666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D2A5629B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B296F171465
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA51B4240;
	Fri,  7 Mar 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWJRy/cT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B0215382E;
	Fri,  7 Mar 2025 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336468; cv=none; b=RfJhFpjufLr+1QbSG5hXXOR1XXra393tKrgtE2QVIVGyiMajZ1m+u+C5dxQkqc/612RCYn+D++3Hud+zwMlvLufE0f7tY+kKtoGz8vqzzy9XN6dXqqVeXaLiPpOja4DNvHbza1CViK/Xjsrmmt5D+JzhcAktDl97FJ94MSJp15w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336468; c=relaxed/simple;
	bh=eFJNtO+gPLfeMVIMbA8EOsQEQtMeWOxWdDojxK6sC4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPvi8PQAavZ8KFqIOrx3i1z59m0a8OGEs5SH7vQV/acbH6AL+NbJIz1b+XLovFYz+RogbfI+Dac41OwnA6Lzl4uLWlZOj0tHZwzxDxNLe3yaZuaSv+VhptQbsLP0FNtz/6F6WfBBbw+kMqQO+1is0KtFVIvW9gCTMDLAKEYpqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWJRy/cT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B6BC4CED1;
	Fri,  7 Mar 2025 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741336467;
	bh=eFJNtO+gPLfeMVIMbA8EOsQEQtMeWOxWdDojxK6sC4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWJRy/cTBnY4eQjRSnNxKHgwOvZvf7FPvMe4vxvX5RazqS7VAMis0zbS6nMGp5q6x
	 oJwiPXy1OuRdMHTScBusB2utPearjfmaTeBfnHOaEAGxPf4HsSw/NWe1OjhiHhh+NS
	 OqQAGKEUkR+bc1PrKsjpgETvq3tXx3Q4t1hmP5CScZea0/JDgJApcJMQ3CZT44WhAz
	 UaUQ54AjYKb23nwx3cFdHUnTIkL35Un4xUw9Fzn5459939eeHc/3umq/D31n9n24A7
	 Zy+FHo2fOCRGeUBfYfi6eOPAND/OSmd19pOfVMFYxSIsrQEvDsRNFzbzQ1QF6uhXOp
	 K9QkjEhrp5yjg==
Date: Fri, 7 Mar 2025 09:34:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de, 
	Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, jic23@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, bpellegrino@arka.org
Subject: Re: [PATCH v5 1/6] dt-bindings: iio: filter: Add lpf/hpf freq margins
Message-ID: <20250307-handsome-merry-alpaca-17da9f@krzk-bin>
References: <20250306183314.150253-1-sam.winchenbach@framepointer.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306183314.150253-1-sam.winchenbach@framepointer.org>

On Thu, Mar 06, 2025 at 01:33:09PM -0500, Sam Winchenbach wrote:
> Adds two properties to add a margin when automatically finding the
> corner frequencies.
> 
> Signed-off-by: Sam Winchenbach <sam.winchenbach@framepointer.org>
> ---
>  .../bindings/iio/filter/adi,admv8818.yaml     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> index b77e855bd594..3f9c61547a78 100644
> --- a/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> +++ b/Documentation/devicetree/bindings/iio/filter/adi,admv8818.yaml
> @@ -44,6 +44,27 @@ properties:
>    '#clock-cells':
>      const: 0
>  
> +

Unnecessary blank line

> +  adi,lpf-margin-hz:
> +    description:
> +      Sets the minimum distance (in Hz) between the fundamental
> +      frequency of `rf_in` and the corner frequency of the low-pass, output
> +      filter when operatred in 'auto' mode. The selected low-pass corner
> +      frequency will be greater than, or equal to, `rf_in` + `lpf-margin-hz`. If
> +      not setting is found that satisfies this relationship the filter will be
> +      put into 'bypass'.
> +    default: 0

hz are 32-bit, not 64-bit, so I think you need:

  default: [0, 0]
  minItems: 2
  maxItems: 2

Best regards,
Krzysztof


