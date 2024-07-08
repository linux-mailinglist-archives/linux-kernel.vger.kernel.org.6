Return-Path: <linux-kernel+bounces-244590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF792A692
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BC01F20D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569914A60C;
	Mon,  8 Jul 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXKPs7e/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFBEC7;
	Mon,  8 Jul 2024 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454293; cv=none; b=TRPfEDoV4ekG4HwnSzHKR2tEa36jwFI8MmUzU8gEHxMT2dfnMaHlW55WQ8DaF1bs6kDsM2OuY0zGI0+z8gHktPWr9vGBA7EwGEGAAuNbO/eGwygg/PJegPLD0ep+9VJY+uB2D1qHlyNYdjyYMXjavPQXcWdHJd4hDSU1IuvZfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454293; c=relaxed/simple;
	bh=xSaR3tUfBE0adZxfHqVKb4wZRGy6SCoW+fLmRQnyfMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRs32ffO6B3L46HlHhjKBhUGbJG/S0QvJ7SgC1AYG+PHGUh/mkY2cbJiZIQzqCgUcx0lwzcCLDG03FvH8XwG4MUZyPZxg9SC+2Leky8K8Y/EiDs7L9FQ4bpJdUQ97aU1m/E7YMaz1wRhFjTVkJLLs2VGd4fX4Tg0LNA5koM/6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXKPs7e/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38120C4AF0C;
	Mon,  8 Jul 2024 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454292;
	bh=xSaR3tUfBE0adZxfHqVKb4wZRGy6SCoW+fLmRQnyfMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXKPs7e/nGGic3PxnMVNlZoJE0f1f24bExhQ0xbKQQONjPRCZ3IksTD31QeAFO7gj
	 zf6n7n8Jriy6S+8TbOE8e6bOJaxotBRIvMB6t1cxp8gLuGOwlqz2Y7DsLE5vlkdgiR
	 4AFpRqfaw7cTAzMGU+1Eqxl4t69ORM9EzCMGbmkRE645doKMWxeD16DCKVS+E5PxIc
	 r9TBxqXb1/X+rQcOI/T/KVOt2KBP16XzXI3GgA1aEnJ08xv/bCHxvcwxFFng0UY8Yz
	 vYY9HDgVv3JkOnWvUI3yTkPx7qxQzHY20Abwijcn2BbgmYkK9CnXOsrMRyGn84dR2/
	 fBD2T+LRXM3Xg==
Date: Mon, 8 Jul 2024 09:58:10 -0600
From: Rob Herring <robh@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: tglx@linutronix.de, krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dharma.b@microchip.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 15/27] dt-bindings: interrupt-controller: Document the
 property microchip,nr-irqs
Message-ID: <20240708155810.GA3245742-robh@kernel.org>
References: <20240703102011.193343-1-varshini.rajendran@microchip.com>
 <20240703102814.196063-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703102814.196063-1-varshini.rajendran@microchip.com>

On Wed, Jul 03, 2024 at 03:58:14PM +0530, Varshini Rajendran wrote:
> Add the description and conditions to the device tree documentation
> for the property microchip,nr-irqs.

Why?

Of *all* the other interrupt controller bindings, do you see a property 
for number of interrupts? No (well, maybe a few slipped in). You 
shouldn't need one either.

Rob

