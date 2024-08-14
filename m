Return-Path: <linux-kernel+bounces-286514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9D9951BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A2DEB241FB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37D41B1430;
	Wed, 14 Aug 2024 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKQKtCNm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D41D52D;
	Wed, 14 Aug 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723642439; cv=none; b=LAOKwz2ThrTX4hf8ztDWmo9zma5eBR7kBtDGzoOcFToBMXlU1FPLROpPFcYI4Lhkuo7E73bIT+6WySpHBIfG0YVgOT8K+kiPP1lPDA/8bGdpw2n1Yf9u9d62sNCCa94ahFQdc6YQLmTX3avxsO3aB/Gdm0WMyHYv1tyYP5W+YD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723642439; c=relaxed/simple;
	bh=5juxU2YKzXwhGtHHkMqjJHdVpaJe0GNBTkafUmGuu/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdlnP4bFR4H4SC/2oAPXkUt2m9b/SDGO3zpuOMhD0cyX1u2NyRE9gOIQhoVohPHM8C7gnD692oZhkhMnuBMQ/sUfRyGJPpQXmbHLhj1KusnBWZhcMl+BZsnZHnnYNoRhlvrluVmh9NLvnXUDJbJpj+TcJlbG8CLBA6Av7dlrLO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKQKtCNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E6FC4AF09;
	Wed, 14 Aug 2024 13:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723642438;
	bh=5juxU2YKzXwhGtHHkMqjJHdVpaJe0GNBTkafUmGuu/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKQKtCNmHmWQR/BbAijgeoeYd+lmNDixeVH81LMj5fJw7vf0/5M3rJ5Oty+9wAxgP
	 lEuYK10my2zB326zE/OXcEjjCICi9xLuYook3Q0P5EscET1o9G1s0YkzAo5JHKWK/m
	 AoQFWjGUaOSrhFvWXykkBAcyxXMlGx7kABt93yNqrld8PKwuS2NK4q/r5Z2xDSCAdL
	 7F6xmhhjKs1Zv1biMVeD8Orr75ENrzi0qNYZPIcwAT1J+USmI26cuGre0V7jlzS0ud
	 WdiKT7bfYf7k13gJT3QD7XgiIq2rCTcRhVLCB4nXdwNF5GAGy/Ze1TCMlKkoVTsXFf
	 JhZglLE7VusmQ==
Date: Wed, 14 Aug 2024 07:33:56 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: usb: microchip,usb2514: Fix reference
 USB device schema
Message-ID: <20240814133356.GA2292842-robh@kernel.org>
References: <20240814065833.36372-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814065833.36372-1-alexander.stein@ew.tq-group.com>

On Wed, Aug 14, 2024 at 08:58:32AM +0200, Alexander Stein wrote:
> An USB hub is not a HCD, but an USB device. Fix the referenced schema
> accordingly. Adjust example to keep it aligned to other schemas.
> 
> Fixes: bfbf2e4b77e27 ("dt-bindings: usb: Document the Microchip USB2514 hub")

checkpatch.pl complains the hash is 13 chars rather than 12.

