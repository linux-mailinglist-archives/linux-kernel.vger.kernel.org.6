Return-Path: <linux-kernel+bounces-213665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED44907880
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF911C239BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774B149C79;
	Thu, 13 Jun 2024 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kncp641X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0261369B0;
	Thu, 13 Jun 2024 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296966; cv=none; b=r96Bmg1QrWH+Zm60bI5NHivV3p5QawgMoUa4KXsWl0INhMdV3D6WOte9zM2YCyqHNEfCgwQ/u2JJXn67tez+JhYaWbybF+xN65QFm/hgf4zmMXfdn9sY9PBsiOHdKjY2k46EnqJ6x+gg3EWGgH5zvJayZR6FMwAW0Y9Inc4pH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296966; c=relaxed/simple;
	bh=k6RZFuL5RbQMXBfC1QGbjlIe42D9eii5Ww819cD7sCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZkiwHwpjkQxfCP3ZCVo169M1G08W7ohH5o9sWfjMJQCMLKgg4DzRNhnFAIWiGaZ13jeZLRQk340ym7YtVEM4fMKPU3Bl3SzD2JRa3LqeSGz4JrtNSYvLMqflNvIUljoeiQ3IEQ3tKFSrXuospUeSSd8VoKR3juG6+dJjjkTNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kncp641X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BE0C2BBFC;
	Thu, 13 Jun 2024 16:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718296965;
	bh=k6RZFuL5RbQMXBfC1QGbjlIe42D9eii5Ww819cD7sCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kncp641X+UbghLKCtc6JUOvH5mOgzmtoEz/z4YK0RdIZ59bV2tVcBnppQgJB7g00v
	 i4Qt+uGMjBwLFzx7fAkeb157E4AROuJI7qDYEjm5YCRB/qqM7NM4gFCBJj7BA5VnjP
	 E2tFErP3LenNAcCr5q0F7sW641LObjwlB617yjTOuM1nNokJcs4HhsJBamqM7EyxKY
	 WcfEHR3bIWoFqAOg7nDg4s9M4b11HZ77dTcXzFF+1gE4aY2onT15YV/Rcp8P6tQ4yo
	 KjN8x5hP+GNpgpY9YCN2taV1QCRnSLox7fcvKDApOMcG8tvy+4Lz6u0t59RFrYeUCY
	 czqPkuBZpIaWg==
Date: Thu, 13 Jun 2024 10:42:44 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>, Viacheslav <adeep@lexina.in>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/4] dt-bindings: arm: amlogic:
 amlogic,meson-gx-ao-secure: add secure-monitor property
Message-ID: <20240613164244.GA1999034-robh@kernel.org>
References: <20240610084032.3096614-1-adeep@lexina.in>
 <20240610084032.3096614-4-adeep@lexina.in>
 <20240610-dropout-compress-6d6a9b749524@spud>
 <4866f6d4-2e3c-40c7-a8cb-ba4e422ffef6@lexina.in>
 <20240611-undying-earthy-00236ac251aa@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611-undying-earthy-00236ac251aa@spud>

On Tue, Jun 11, 2024 at 07:07:28PM +0100, Conor Dooley wrote:
> On Tue, Jun 11, 2024 at 01:25:11PM +0300, Viacheslav wrote:
> > Hi!
> > 
> > 10/06/2024 19.08, Conor Dooley wrote:
> > > On Mon, Jun 10, 2024 at 11:39:49AM +0300, Viacheslav Bocharov wrote:
> > > > Add secure-monitor property to schema for meson-gx-socinfo-sm driver.
> > > 
> > > "bindings are for hardware, not drivers". Why purpose does the "secure
> > > monitor" serve that the secure firmware needs a reference to it?
> > 
> > This driver is an extension to the meson-gx-socinfo driver: it supplements
> > information obtained from the register with information from the
> > SM_GET_CHIP_ID secure monitor call. Due to the specifics of the module
> > loading order, we cannot do away with meson-gx-socinfo, as it is used for
> > platform identification in some drivers. Therefore, the extended information
> > is formatted as a separate driver, which is loaded after the secure-monitor
> > driver.
> 
> Please stop talking about drivers, this is a binding which is about
> hardware. Please provide, in your next version, a commit message that
> justifies adding this property without talking about driver probing
> order etc, and instead focuses on what service the "secure monitor"
> provides etc.

To put it another way, how many secure monitors does 1 system have? 

What do you do if the property is not present? You didn't make it 
required which is good because that would be an ABI break.

You only need a link in DT if there are different possible providers or 
some per consumer information to describe (e.g. an interrupt number or 
clock ID). You don't have the latter and likely there is only 1 possible 
provider. 

Rob


