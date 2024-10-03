Return-Path: <linux-kernel+bounces-348849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C6A98EC8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884ECB2346A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1AE1487D5;
	Thu,  3 Oct 2024 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkZZ4uVg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F193823C3;
	Thu,  3 Oct 2024 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949181; cv=none; b=joXKFUCwkYlJfhv6UEh2+q/+QjZvvr6yt6C+eYmwO58WyviK90uEK0yhhL970RkvMTXem4RcKYv4b/2Uiw6etUCSskaDVlD6RVpVOQUIqAAAwzuYzlKg2nDybK70+g+zVrk9Yd91psHE/PX0T3Dsti+bhbXeO+a9yni8dcJQTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949181; c=relaxed/simple;
	bh=r60vZJZ6L6N7kj/zd/wI6zNB6uYbLdjKz0S6lEoaP5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4614Otkom9JJPTQ0VSYRsgRg37apZza09tmAFXifQDjJ26Sgj8PKJc1J9YSmjG1pvA6JUq5SxhYbeezl2i7BflcJjrin0ZE8EhTCHA+Pm8oLxdZK1RTiud6KsHSkz4D+3d1DaC+FjJCGccqs0fxAc9IR1FUZp4Fwnq5P1oT34E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkZZ4uVg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A0EC4CEC5;
	Thu,  3 Oct 2024 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727949180;
	bh=r60vZJZ6L6N7kj/zd/wI6zNB6uYbLdjKz0S6lEoaP5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bkZZ4uVgWjc0N+61OfaOJSF5I8pztDIEd+CDcaXuqdEAnpBqaVh6K7Mw4Z5zJSnwS
	 Gr42seg4MFQin24dekGDSosnp4J3fztfBTlCxLMdtZ7MPcBlrEKJN+SquLS0jC9ChI
	 /FbvltcJ/V1wwdZevbZzFDqHJ0uF6suMGGD8gky030TGu0S3P4gBkPba8m791MKZil
	 BkLmD73tyZUOhWgFUkioXaEwb/MuTJJbEuXAI+b2cgg6fURIxveDRLPrl649ydxPES
	 jpy741S3hqtLWiE/0nnHg3FJTn6gxf7zzqpPi0Gn1/aw7n30g6djUiyP2yXn1PhbSG
	 tjpra4c3WbczQ==
Date: Thu, 3 Oct 2024 11:52:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 5/5] dt-bindings: riscv: document vector crypto
 requirements
Message-ID: <kduc5r2nisteqax3zbxkja6qevdi2pdu6nk4sqabkap7nxtmok@sxq7yhptrvqc>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-sincerity-urgent-acdb0e8d8a66@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002-sincerity-urgent-acdb0e8d8a66@spud>

On Wed, Oct 02, 2024 at 05:10:58PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Section 35.2. Extensions Overview of [1] says:
> | The Zvknhb and Zvbc Vector Crypto Extensions --and accordingly the composite extensions Zvkn and
> | Zvks-- (sic) require a Zve64x base, or application ("V") base Vector Extension.
> | All of the other Vector Crypto Extensions can be built on any embedded (Zve*) or application ("V") base
> | Vector Extension
> 
> Apply these rules in the binding, so that invalid combinations can be
> avoided.
> 
> Link: https://github.com/riscv/riscv-isa-manual/releases/tag/riscv-isa-release-698e64a-2024-09-09 [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../devicetree/bindings/riscv/extensions.yaml | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


