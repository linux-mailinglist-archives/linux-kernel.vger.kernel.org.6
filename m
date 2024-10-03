Return-Path: <linux-kernel+bounces-348846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8A98EC85
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D48D328386E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E1B1494CA;
	Thu,  3 Oct 2024 09:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM5qPXgT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7B2147C96;
	Thu,  3 Oct 2024 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949129; cv=none; b=Zu093w/iylHPmJu05P1T70KA25RKaTMS5h/uBWOEVRZvFqh7BbmVuqTvD4p1VjQ47GtDvEY9fkoBwH6Tq8nmEnbjbR8ico6how0vaT6RNbMjIsICmuSGUj7HxSJny/G5B7xuYZWlqo6lPznt+TpoGylNA9SyG9doTGemlUoHusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949129; c=relaxed/simple;
	bh=Iz1TA1Le/+JlH07KTEOpcQbnyFnWRNy0QhWePMeK3n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGhqFV+66odbJf2CkFqzwTC6337FAsa/xw/xkKFEMcr2bEyNDf0FZAH9KuV3KObhm58Dtz2/gaeLRcu3F/igvBGBnj3JNkY1brJkJ4X2c7n7bRKJCAYRbXcoFunbSgWO9SKqufHNWzjjbsHMFt90jubMkQC96YmGzSytle6scYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM5qPXgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B27FC4CEC7;
	Thu,  3 Oct 2024 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727949129;
	bh=Iz1TA1Le/+JlH07KTEOpcQbnyFnWRNy0QhWePMeK3n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pM5qPXgTL8AZUGDjCGhacmGm0Vt4qzgDO8nCyiRH8PxuLsT3QYCW3F7tdGbWXhbJr
	 b6nn0nl1HswMetkOJzkE9WHQu6w23fwYNTi2+Kjj/c/aJ4Ov5nT7J7RPNrjU36mnO9
	 N9Xgy2jVyig7rXhQZVsVZXEDVDWwUUslLGFIdGTjys9vrsJnTcCL2yZG6wbKRDN3Wz
	 LReNAOyFfdBfGF1XomiVa72BW5L6rEf7r8nIaLN7MmW0G0+8qR0FF2d31JdiCd6B4J
	 NRhUopgh1BX8bnejafoQ+RxXM02mMairPb8JO98PPqEmD6PuHlbW3U78EdIsdmmRua
	 Znt17JzXrPqxA==
Date: Thu, 3 Oct 2024 11:52:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 4/5] dt-bindings: riscv: add vector sub-extension
 dependencies
Message-ID: <7e5adthgwuqqpwvjbq7cs4gbtl6xv2fkdsf2zmmqvrpgvmbae6@gjsxa37bw6i6>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-eagle-fresh-4b2e259e45ee@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002-eagle-fresh-4b2e259e45ee@spud>

On Wed, Oct 02, 2024 at 05:10:57PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Section 33.18.2. Zve*: Vector Extensions for Embedded Processors
> in [1] says:
> | The Zve32f and Zve64x extensions depend on the Zve32x extension. The Zve64f extension depends
> | on the Zve32f and Zve64x extensions. The Zve64d extension depends on the Zve64f extension
> 
> | The Zve32x extension depends on the Zicsr extension. The Zve32f and Zve64f extensions depend
> | upon the F extension
> 
> | The Zve64d extension depends upon the D extension
> 
> Apply these rules to the bindings to help prevent invalid combinations.
> 
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-698e64a-2024-09-09 [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


