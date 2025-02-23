Return-Path: <linux-kernel+bounces-527709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E270A40E65
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB4CC18982AF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA7B205514;
	Sun, 23 Feb 2025 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkuTutRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FAF3D984;
	Sun, 23 Feb 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310732; cv=none; b=N5OrwCbUFmXwihxKj5KRZXVFrqtmhkonObMtxNqGzUJrPbXx8eIQfJJVN5USUuHYQOfyqF74bEso5B44f6Jli9UuXLFukOiIlulIVinegX4+I6bIo0DggySqTfswL1zRxrt/ih8wrxoQK548ZBapDOzfa07DBFpkkxfPzieqAbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310732; c=relaxed/simple;
	bh=gpP8cwsxtmk0q4mENMr1x0oK+YyGLi2s0eO2oYF6cAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9fkRIMLBzmcOWvLnXEh5IyLvD6nCYCZwum6ls9OPJ5e6/87TYI/qGaTWtz7ogOQD6yDcbeT5hvRhokzQpHIUyQfXXtVwC0goOEm13QIGpxzLfiqS12jGmf8DRvUZvYDXYFU/Fg8l9Ry+NC9RjumClxFZwxe5MQHbiRI8Mk0wHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkuTutRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F732C4CEDD;
	Sun, 23 Feb 2025 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740310732;
	bh=gpP8cwsxtmk0q4mENMr1x0oK+YyGLi2s0eO2oYF6cAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkuTutRcvdJjKsBA6foDYHl+srMDZFJvmRUz0fSuIButzOvDgBNbxqfdHa0T/TUgT
	 ehrZnYLCf8ElkxU6eXcEXWpmUCnNn7N4Z5vxCOdTVc47Msh6iCIPc++sVPPlfDbgZE
	 5OE0c+Id+YFMhA2nCUVV+SVu/mNQi5w7lICgmtTsZ+h291lZYRwaAw72Gmp6ewLD72
	 ddAMbCr+JYiv/fJqAoZJAh2n+409A6kmGu8ZE3vJW4p8fTC5etBJ8G5JvrGYfbGpOy
	 jLsBRNHYTzgfpgQJj52otUpo8kuyRn+cjdelSl1BoaNJLQhZ1s9PS1aFyfe5JgEzXT
	 AE0jfoJReP2tw==
Date: Sun, 23 Feb 2025 12:38:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: extcon: Document Maxim MAX14526 MUIC
Message-ID: <20250223-giga-moose-of-abundance-8e5b9f@krzk-bin>
References: <20250219083724.56945-1-clamor95@gmail.com>
 <20250219083724.56945-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250219083724.56945-2-clamor95@gmail.com>

On Wed, Feb 19, 2025 at 10:37:23AM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Maxim MAX14526 MicroUSB Integrated Circuit.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/extcon/maxim,max14526.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
> new file mode 100644
> index 000000000000..87cf7fd19ee9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/maxim,max14526.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/maxim,max14526.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX14526 MicroUSB Integrated Circuit (MUIC)
> +
> +maintainers:
> +  - Svyatoslav Ryhel <clamor95@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: maxim,max14526-muic

Is it something more than muic? Why different filename than compatible?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

This looks incomplete. Missing ports/connector.

Best regards,
Krzysztof


