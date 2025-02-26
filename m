Return-Path: <linux-kernel+bounces-533324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77217A45868
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1347A286B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3DF224253;
	Wed, 26 Feb 2025 08:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkYkbob3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB511E1DEF;
	Wed, 26 Feb 2025 08:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558742; cv=none; b=aLMzofvqUYsOrDdd4GAk4k2J5B7fPuEO2rDS39D67e+P71cDz4VazLTMjPRTmDg7gmtPP1cs2nfRm0GfttuEyTtfkFPs2fmgKhiqDvfPUD0M9XYWQi4woi47xOmJpWReMv9AZLOsnfGvdtiWd9ueKV7uUbFHPClQDGfdkOC6jbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558742; c=relaxed/simple;
	bh=pCY5MJcHID/t2Pb6RIB298aS9Enq1BhXl+cqd9OOkmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aop1d9Da433DGAodKNHDupEwU/eyM09BHt2fSFboOEpYvzU1S4h68Nb3tCBtc/9A4m+OBmf0Wo9h15EcYD4we/Ne7kOxfQgv4BPwYbmqjQ8Ny/iVxjN2xtpnxHMU/EwIWgAiUpuzoCKjRij0J0RB7lNMmKoyBLWp1hD1gzAUY30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkYkbob3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5E8C4CED6;
	Wed, 26 Feb 2025 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740558741;
	bh=pCY5MJcHID/t2Pb6RIB298aS9Enq1BhXl+cqd9OOkmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WkYkbob3F/FEh42Rx8pbhLsqPxB9WOaFobE/EZjopEvktMV32lK3zQohLNTQSZcTt
	 0OeayTHGLe4FurZoLIdV4SVa3zXNM8J6OLEvEHp3bbwozERqQUTFCFL7dtqsbI8nMT
	 713eIKNYQ3nnXqP55Dac+TorJINYr83Z+WEqa4b+l9CHVToDRtNgvXGQtt1w9bg69E
	 1Ezzu+aC4FSlJThngdeT4GGupXNlOb7grliknak2jIBrSeTjGMR6T76D19k/sYGjm9
	 /eAmCMtM3WUFuGJfvuXmDpEvLew3EijXa2xCespHGV+XTzX265tK+qJ4SqOFS8mcR8
	 PcaXURSBZ1www==
Date: Wed, 26 Feb 2025 09:32:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
Cc: tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, vz@mleia.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
Message-ID: <20250226-khaki-wildebeest-of-action-ddec48@krzk-bin>
References: <20250226010956.50566-1-leo.fthirata@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226010956.50566-1-leo.fthirata@gmail.com>

On Tue, Feb 25, 2025 at 10:09:40PM -0300, Leonardo Felipe Takao Hirata wrote:
> +properties:
> +  compatible:
> +    enum:
> +      - nxp,lpc3220-mic
> +      - nxp,lpc3220-sic
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  interrupts:
> +    items:
> +      - description:
> +          IRQ number.
> +      - description: |
> +          IRQ type. Can be one of:

That's not correct. Previously you said you have here two interrupts -
SIC1 and SIC2. Now you say you have one intrerrupt "IRQ Number" and
second interrupt "IRQ type". This makes little sense - your interrupt is
not "IRQ type". Unless it is an interrupt signaling that other interrupt
has type?

Look at other bindings what are the interrupts.

> +
> +              IRQ_TYPE_EDGE_RISING = Low-to-high edge triggered,
> +              IRQ_TYPE_EDGE_FALLING = High-to-low edge triggered,
> +              IRQ_TYPE_LEVEL_HIGH = Active high level-sensitive,
> +              IRQ_TYPE_LEVEL_LOW = Active low level-sensitive.

None of these are relevant here.

Best regards,
Krzysztof


