Return-Path: <linux-kernel+bounces-371034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 319A19A356C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91142837C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1B17CA04;
	Fri, 18 Oct 2024 06:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAGL2MuV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC220E30E;
	Fri, 18 Oct 2024 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233059; cv=none; b=ShK48NLbO9GHTCZSbCBJTKdYSex3fw0NMMWZhtjJ59ESmWLqrj/Cemkj83oSZcVu8G+DqqFxfETRV4T8rZFGLIfJdddhCbiyvV/8a35GxUAp76KzQ1wJe2hP3tNGZR0CYz91LFYo1aXIXgmX/I5vWh9gR1GBKN5kWJvKQ4Ozdl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233059; c=relaxed/simple;
	bh=DxBz2pZsmQ3FjwAkGPUZ0lXykxpqpRnMMo4p4Gg9vjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5MDM7wC7kIgjNkJbFlQ+cFZJausqmXtCBWtbinRvgsbpn2XkvYM/kGFJRCzsDLm63LOK/xpfwVf5aQoNIFnRHo8PkcYrt3RqOQVW9a4U4kcluCPz6oUFNJU9qBVaRFiiS7wzLS/VbVIMMougElCYdGPIRDUw4Ob3TN1RdrRItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAGL2MuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2FCC4CEC3;
	Fri, 18 Oct 2024 06:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729233058;
	bh=DxBz2pZsmQ3FjwAkGPUZ0lXykxpqpRnMMo4p4Gg9vjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAGL2MuVFM1vz0E1ilO7NgiL08nAPFuBID5WsyXJ1AdQeGYm70OCS/BgNsI8DDRg6
	 frUb3smQ9VLpvZlCRNqSniGfYmaqaMgaAQo26b/YdxJ+/emnfAZrTpRfGegi6E/Pzl
	 gZLq9m+HJNPtXW8EpJxyfzvRkggjA4BntSxBotIxxc6q3LjQzqCbeUkJZJqNdeirX7
	 04xIdrCM22B7LSh0iAwOxzrMblvBwy+AykyIpWWuXu2Sd5NVF49WJxIcEk2iPJ3CES
	 XO1WRDM3GQVomRWyU7zQPqXgCiT7hBfVvMFe4gS2u0MS4qtC5TOLbrl8Tcr++l6TAz
	 E4tCQPdQQp7Kw==
Date: Fri, 18 Oct 2024 08:30:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Umer Uddin <umer.uddin@mentallysanemainliners.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	igor.belwon@mentallysanemainliners.org
Subject: Re: [PATCH v2 4/4] arm64: dts: exynos: Add initial support for
 Samsung Galaxy S20 (x1slte)
Message-ID: <ncckonzlc7fjt6vhw543iqoua4qx7hjgexj6lxyaldzcvbtutx@luazzw3rmjcd>
References: <20241017164328.17077-1-umer.uddin@mentallysanemainliners.org>
 <20241017164328.17077-5-umer.uddin@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017164328.17077-5-umer.uddin@mentallysanemainliners.org>

On Thu, Oct 17, 2024 at 05:43:27PM +0100, Umer Uddin wrote:
> Add initial support for the Samsung Galaxy S20 (x1slte/SM-G980F)
> phone. It was launched in 2020, and it's based on the Exynos 990 SoC. It
> has only one configuration with 8GB of RAM and 128GB of UFS 3.0 storage.

8 GB RAM, so the memory map should not be the same (and should not be in
DTSI file).

> 
> This device tree adds support for the following:
> 
> - SimpleFB
> - 8GB RAM
> - Buttons

Best regards,
Krzysztof


