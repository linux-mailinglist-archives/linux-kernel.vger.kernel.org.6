Return-Path: <linux-kernel+bounces-227605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4AF91540C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDC06281164
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E1A19DFA0;
	Mon, 24 Jun 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ir84Tycb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F531D53C;
	Mon, 24 Jun 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247024; cv=none; b=GoqKPKLp4ihKbO2vgOYZQe/e2Sf/RF8lUSLMI+DdjDou2hFtUXCcuEnvMKPXmtql5M5WEsCO6u9tNPHRgOIBawZrw72GDoAXszarFWNYGpixsqOM+4EE96W9Lwz59oE6taikyE0VvKXMnO+L2c/IlUD73CQL6ZphKgL4+E9FZxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247024; c=relaxed/simple;
	bh=8vaRXZjqin2JDTOMmrFuxGajy9VxH/lsI1KpjXW2Q/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXdh2fk6FpVO5bTfAI4mbPplFHYF1U5qujFexAAZXvvxo3mVjHt7piF9XWXlNXlnDllvr4E9zdGXmi5AcykNHK5J11CtymtIGbyxqbcRkUPaOAyF76GhomrJGPNF+703H+9S536wHh0D/6FA/MM57P606e9ynfqK09qT1SzbN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ir84Tycb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86FAC2BBFC;
	Mon, 24 Jun 2024 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247024;
	bh=8vaRXZjqin2JDTOMmrFuxGajy9VxH/lsI1KpjXW2Q/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ir84Tycbp3vKwaBQ9sVg0Io1tyqL4+98Ga3A8NmgEC4j8U/grDSE+vkAdJIywidxy
	 lV053/uYb5MFJX6/V7iCt19JLOTPykVlURuq8ydLgUSX8ZuXiKTlnGJXOt1XmfhPLj
	 sRsAUcC+rYxFuYhyLszaV1TK4d4O7+3V1ZoA/e/z03M23gO3L8DqWkHuLDSDC9BZPp
	 RJ0noehGGMxT+sh889j4Sxfu9mnv40CC30GTiaFxSa1jCBBim0srR9QKRO1T6ud0ys
	 jQ5C5uLYOAkt6Rq6GSwbSrZw1jWS93/kcl66Lo5b0owFRKQq79fXZ+R7pfhR9y8HmQ
	 Pk2IcseYZllUQ==
Date: Mon, 24 Jun 2024 10:37:02 -0600
From: Rob Herring <robh@kernel.org>
To: Etienne Carriere <etienne.carriere@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, Pascal Paillet <p.paillet@st.com>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] dt-bindings: mfd: dual licensing for st,stpmic1
 bindings
Message-ID: <20240624163702.GA4048689-robh@kernel.org>
References: <20240617092016.2958046-1-etienne.carriere@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617092016.2958046-1-etienne.carriere@foss.st.com>

On Mon, Jun 17, 2024 at 11:20:16AM +0200, Etienne Carriere wrote:
> Change include/dt-bindings/mfd/st,stpmic1.h license model from GPLv2.0
> only to dual GPLv2.0 or BSD-2-Clause. I have every legitimacy to request
> this change on behalf of STMicroelectronics. This change clarifies that
> this DT binding header file can be shared with software components as
> bootloaders and OSes that are not published under GPLv2 terms.
> 
> In CC are all the contributors to this header file.
> 
> Cc: Pascal Paillet <p.paillet@st.com>
> Cc: Lee Jones <lee@kernel.org>

My copy comes from b4, and looks like it fixes old addresses. Neat.

> Cc: Rob Herring <robh@kernel.org>

The file only shows contributions from Pascal, so you don't need any 
acks for license change. For the change itself:

Acked-by: Rob Herring (Arm) <robh@kernel.org>

