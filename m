Return-Path: <linux-kernel+bounces-525527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E9A3F0E6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321E1189B16C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02AC20550C;
	Fri, 21 Feb 2025 09:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxErVFXq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565582054E9;
	Fri, 21 Feb 2025 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131056; cv=none; b=je1Ri2xaKC06VRHkCY9TxaMeWdknT9BKaTBPG3dy+E/4kRSn5RMAgLe5i8UGpqAHboNwFlBhNdvuvui4YHWjsEBaZva+T1HyyDLOeYyPU2ugVMSi7Fvr+ysUwbqb02eVqXurH6m5zYPkReOIxX1QxcAhZ3jGNBFiHbSZzedULcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131056; c=relaxed/simple;
	bh=oGc08unFJjdspqNPw0ls9wEq6ey6P+fkD8tthUluMQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGP+aDSpXmJ0ZCI2KCAze6jDCEA4pedeCRInb2/MOPHQTRKw+5JZZqMPT6SnPJkW2zFymcUVZDaJEk98M+iVr1OxdyhOM/2PhP3m1jxtQb1Vts76/lyBEfHiBNTeg3ETu8BcSOz83591lNmuLVNFa+gwzgxgzjBzwCnd9sK/dJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxErVFXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D194C4CED6;
	Fri, 21 Feb 2025 09:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740131055;
	bh=oGc08unFJjdspqNPw0ls9wEq6ey6P+fkD8tthUluMQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RxErVFXqII+ugR/34j5LlavZu6TDo0qG4vxbyVUD/RTVc8Cv4v6rgzAx6aT8x0XWP
	 oNPbiAJnYWoEl0173U2EMZG4+DZjUUeDl6jKfKA+IVQhK4WjemXmXTsdb7sle+xEqN
	 jiCfCFlAikceK/A2qDcyASm8tktM/9SVe9G36pX5ZbTorKX2UfTafhOWPgNQVMVZ2o
	 DNww8ujp+j6n91i2jrf49QBh6PPn8t4U76h2IHrmqpjOPWC6fmsjmUHBckWW4VV2I3
	 IVm7vDuV/bt/cD2Q67Y/6CgNO+EkTgjN2AVryTcQjs/2P02PqqdLoLfiZktXEEwuU8
	 ulH+s+Aj+IDfw==
Date: Fri, 21 Feb 2025 10:44:12 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: frank.li@nxp.com, miquel.raynal@bootlin.com, 
	alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v3 1/4] dt-bindings: i3c: silvaco: Add npcm845 compatible
 string
Message-ID: <20250221-nippy-spotted-finch-fa0a5b@krzk-bin>
References: <20250221063528.1810007-1-yschu@nuvoton.com>
 <20250221063528.1810007-2-yschu@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221063528.1810007-2-yschu@nuvoton.com>

On Fri, Feb 21, 2025 at 02:35:25PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
> 
> Nuvoton npcm845 SoC uses the same Silvico IP but an older version.
> Need to add a new compatible string to distinguish between different
> hardware versions.
> 
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


