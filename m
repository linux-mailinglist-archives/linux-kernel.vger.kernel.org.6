Return-Path: <linux-kernel+bounces-306216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03164963B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399C21F21D31
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB97415AAB6;
	Thu, 29 Aug 2024 06:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3GMyppe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ED01547E4;
	Thu, 29 Aug 2024 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912605; cv=none; b=G5rlp9nRW11jTa8MZKXNqNwJLooBWonWWgU/thKhOQAjKemi3sC73JJ66W9H1gqobf3bRcsiaDvl8aNVW8L1xHsVjuKnQb5JBmUAcGWpeNtZT0ZcaQtnX21CQlozwSObQD5mS5kBtHwu9wcGVsSJcuI1qExS8FfLRNTHpMLKhvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912605; c=relaxed/simple;
	bh=U5KWoMkfnuFk72Vmblbci9PFkDZZdASH00vXuyhhx+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5yeiX/vvLGMwE4SN3xY69qS5sFApS31L75Rjwx8vtwZi+b9WVqDG73UVBiuigSH3iZKeoiMS7nTlmiHfLT9NOLpPwtgl+48Gup/k5GHaoc21DFWcfxgpHX8B492dC9CA4/4Ciqlwh0wzqVI7KrFShfgb4h+XkJvZgIB5n8lbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3GMyppe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5967C4CEC7;
	Thu, 29 Aug 2024 06:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724912604;
	bh=U5KWoMkfnuFk72Vmblbci9PFkDZZdASH00vXuyhhx+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3GMyppe/R593iDYjabEa4aNOCtnmhepV9P603aZsfJ0Azjxi6Sos3hFQDL3nAmFP
	 MJ2aNojvaU6gztWrnBQkDScW8ALTlb48m0KQmG2tj/RSpUc9R+JrPl+e7FK1W6kDg2
	 3jAHDce3MOi/VqWrjdw8iPuYR+WCKHGg5QFCSYS/vdJxwXk8LSuaw75iYLGe1pm8ky
	 aJEKij1HVhKYQV0aXcYN2BiF+Alf5IrHGgB7K3/C1o+Bv1dmGVlJPAuHAl+fh4gBIQ
	 hGU/yG5PYs0KrrRw9u9JpP6h2M8jIMKfmAFgODetS3fUBPC4Oq6n/jewzZIZ7xw6kZ
	 EgM0tkHXLN6PA==
Date: Thu, 29 Aug 2024 08:23:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 0/3] Add support for AST2700 clk driver
Message-ID: <t224vq3mnwwddpmpyi4ajpsippwcj3rc53li6bkccr4s5tf5y7@fjhthwzqhgqy>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>

On Wed, Aug 28, 2024 at 02:27:37PM +0800, Ryan Chen wrote:
> This patch series is add clk driver for AST2700.
> 
> AST2700 is the 8th generation of Integrated Remote Management Processor
> introduced by ASPEED Technology Inc. Which is Board Management controller
> (BMC) SoC family. AST2700 have two SoC connected, one is SoC0, another
> is SoC1, it has it's own scu, this driver inlcude SCU0 and SCU1 driver.
> 
> v2:
> -yaml: drop 64bits address example.
> -yaml: add discription about soc0 and soc1
> -dt-bindings: remove (), *_NUMS, reserved.
> -dt-bindings: remove dulipated define number
> -clk-ast2700: drop WARN_ON, weird comment.

As LKP pointed out, this fails on certain static tests. It is expected
that new drvier will pass the open/free static analysis tools we use in
the kernel.

Please run standard kernel tools for static analysis, like coccinelle,
smatch and sparse, and fix reported warnings. Also please check for
warnings when building with W=1. Most of these commands (checks or W=1
build) can build specific targets, like some directory, to narrow the
scope to only your code. The code here looks like it needs a fix. Feel
free to get in touch if the warning is not clear.

Best regards,
Krzysztof


