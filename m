Return-Path: <linux-kernel+bounces-291090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D8B955D23
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99ADE1F2122A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73813774A;
	Sun, 18 Aug 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhhBAgai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A127412B8B;
	Sun, 18 Aug 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723994433; cv=none; b=eMYDfpBgDFUqhz+9uHUJpacJcwm3ykYjo1Ft7IgnBTmQce10+10Bxyc8S5uRcXBKKGbaM8hKdjl1GpG0Wm+7wudDh2MzE2LOsgavh1clsw6nmRbXE9fh3XWLugDG4l216CLYtj91i1QpmeYRbQf6K6SnWlgPY/aQHASbD/6qNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723994433; c=relaxed/simple;
	bh=SYQPmG1E8m02rnWoijZ+S3KGw8a8k2/aSB76BCn6A5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsXJO+sHlUHvAApd7DNwUVWOdmw0/AESAPzB5JqtTmhlVjRRIYzS+DPnJAf64vrAhXqUiXZIVuGDfllWQV15aAkaHkRfG1xeYs52OB4WzBXIeNAVVPIRr/OTntZiSPk5J/AglhtfPrPaevFC3C1jbMZkgzXD0nZHNE592oaUtw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhhBAgai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89C4C32786;
	Sun, 18 Aug 2024 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723994433;
	bh=SYQPmG1E8m02rnWoijZ+S3KGw8a8k2/aSB76BCn6A5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhhBAgain3MYzsELAc0HysEUBM2dUI9XIwNOMpfU5LjoYeUOhUoo/lwXXWd6VR0X9
	 j0or6K8fnnxOkW4zZ++DK1eXofeOGbQ9pq+5TotWAQm8qNlqAGq0+4y4Y9nAKPyOa/
	 /alF4T95ZdbICXnwC07Ulnnneiv3VvSMhhFpQg6cT/gotFvLj3pqypzw/r1TzR6UhI
	 68M5eJvTXYcS8M9GC5nlMUp6NvfosxYqTihz4XJr9Nl2rYnOKx5b9Q7x3UdcU66ZAi
	 eX0TlRDTbCuej4WsxiWDRE7JK8cPz3boloQ9sA1DTDMRZqn7HXoAFQ8Q1l+DR+f4hb
	 buPw+RUScjwKw==
Date: Sun, 18 Aug 2024 09:20:30 -0600
From: Rob Herring <robh@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: tglx@linutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: Add support
 for ASPEED AST27XX INTC
Message-ID: <20240818152030.GA101410-robh@kernel.org>
References: <20240814114106.2809876-1-kevin_chen@aspeedtech.com>
 <20240814114106.2809876-3-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814114106.2809876-3-kevin_chen@aspeedtech.com>

On Wed, Aug 14, 2024 at 07:41:05PM +0800, Kevin Chen wrote:
> The ASPEED AST27XX interrupt controller(INTC) contain second level and
> third level interrupt controller. The third level INTC combines 32 interrupt
> sources into 1 interrupt into parent interrupt controller. The second
> level INTC doing hand shake with third level INTC.

Missing Signed-off-by. checkpatch.pl also reports trailing whitespace.

