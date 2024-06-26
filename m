Return-Path: <linux-kernel+bounces-230145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECE091790E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C722837F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3D514F102;
	Wed, 26 Jun 2024 06:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="wI+R+oMZ"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9ED10F4;
	Wed, 26 Jun 2024 06:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719383718; cv=none; b=OTYYRvZeIjIXG/us0xbXKknZBj+dk63leWy+hfuADSDYVHZLnOghU+wYH0fPPdki3WhNR0Di8IJ/wsQvUS7jMGssYgNrUdBQwQFhJzRa4/evYHqA9e0aL1Fb49Q2d9So+Ulhpxf1zVGNgsXZv/6pLJfWoHxgLtTYycYP5MyO/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719383718; c=relaxed/simple;
	bh=oVQnVRh7Hjiwa/vBY5JjF7UZQPoxdlWHcd07dzJeauI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5D8c1orOiI73JOjidBJz4qILSE/xySOKwpm+/hnj/28NTQul3V+EekMGmX3SdMlArHU2Rg4ZYB3J3d6tnr/yGhWvwj+ZhhxSZ0UZkqa54SBQe0Ceob6TKf6xh6oVhrIVDmpk3WgK0EddRPimklzFQg+gPmNrhW/mNUZW6xfC4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=wI+R+oMZ; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id B10951F9C6;
	Wed, 26 Jun 2024 08:35:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1719383711;
	bh=2bQvCiVU8Eu/kfnaC/zVKXhsgqWeoaoM4SwjWSgpRlY=; h=From:To:Subject;
	b=wI+R+oMZbaQ2HQEE7C3NEbJV77Iy3dTo7H2IzjOPP42xAROivTiqagm81U7tuplAv
	 N318AavglIRqFLh0WcBSoMmLSU8Fd24jAMHEnV4B/P5dzKgJ/0Ghq24NOQIT9jhKUA
	 Z+x+MuedE/mimQ6ZxwTmCskLr4ilybpd2gu9n0CKrld/sBpwp+P6mupfcLu/wRTXhz
	 GE5l2W2dfY9wAIe4N/kMLeOeJ4XQzRctsr45RQmVt4O0s3Vh5lDmm5oDoCgMLcn+ms
	 cA1xLbsR7/k4Y2sRbhw4bv2+VolrDzVPTgI9cbBTazni79iwDeFVwSyN2Xb+0eIaTN
	 1VnnmmCEngnEw==
Date: Wed, 26 Jun 2024 08:35:06 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Eggers <ceggers@arri.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: eeprom: at25: add  fujitsu,mb85rs256
 compatible
Message-ID: <20240626063506.GA4324@francesco-nb>
References: <20240612092934.12282-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612092934.12282-1-francesco@dolcini.it>

Hello Rob,

On Wed, Jun 12, 2024 at 11:29:34AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The fujitsu,mb85rs256 is a 256 Kbit SPI memory FRAM in the same family
> as the two existing fujitsu,mb85rs* compatibles and at25 compatible.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
> No changes in the driver is required for this to be used, a device tree
> file using it will come in a later step. Sending to minimize work
> slowdown because of TI DT maintainer requirements on DT bindings, see
> https://lore.kernel.org/all/469be7c2-6865-40d4-bd06-15dc3a08b3e3@kernel.org/
> for more details.
> ---
>  Documentation/devicetree/bindings/eeprom/at25.yaml | 1 +

Are you going to pick this patch? From what I can see in the past
it was either you or gregkh to apply patches to this file, however
gregkh is not in cc: here.

Francesco


