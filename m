Return-Path: <linux-kernel+bounces-348841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A1A98EC7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F6C5B236CD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 09:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D21147C96;
	Thu,  3 Oct 2024 09:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlm3Hz35"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4E12C552;
	Thu,  3 Oct 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727949047; cv=none; b=AdJND5Cpv8YNnHrqqw2Y+EnkFmxKtYZmshqLDqDVvjQBUH+LkKwxY0aobkpsqNM5IB1JmvFFpWyTxeQAdIqmPcwVI8EgDv4/Y0kXpAsXHJkAMwUw5nKoSTXg3DHQ09L6/Aa5FFur3S8jwKUgxGjrOuztm+/5UgAYxPoKo/tBdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727949047; c=relaxed/simple;
	bh=zSVrEao+mC/gMTpIMXMitTzd4vFPiF4/j+ASsIq3kwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5sPkULXrGCnTiQcAmWqlHho7t5uBw9xyfcYr0h+SHKGL+RyWdV3pvQxx/oKjZ7NK8UA8gKqBzq1+LkRhRte27b8HNvtc5OcFgqfVx7+q9pG/SeC6bogjqywcuJjFaxzwPrxteHeHW7jJNErdurkh+HzW9jZBFzVwEkv+EyMOpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlm3Hz35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6BCC4CEC5;
	Thu,  3 Oct 2024 09:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727949047;
	bh=zSVrEao+mC/gMTpIMXMitTzd4vFPiF4/j+ASsIq3kwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qlm3Hz35qVqYuWhtznYirYWTQysbWrWNoa6N4jj+CV7pDm2powcbeQ56s2k5vyUes
	 lGqtCX45x7Ll7zPVhIUfZqyx6O0Mtt8GAkwDOUcC99uhq+ARG7RmVam71KpM6ROO36
	 3HoRlWWoIOycbgO+hUAttPjeC0Vwp0Q+J4WerhAChAvqDJwpIf0imCJSRsJnla02Hg
	 Zu/nROaDuTalBFPtzu0+HDdCTka+dr61NtGaF2ZiOy4gQ4mXuJmJWiy72Oa/qCjuCs
	 DVKtYqD7u046bN7pVwvFqoGlYt88UOhZDFCiOY2YtOtHktQNXUcjOZWapqUTDbebpY
	 poRbMyGjy+l9g==
Date: Thu, 3 Oct 2024 11:50:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Andy Chiu <andybnac@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v1 3/5] dt-bindings: riscv: d requires f
Message-ID: <s5dqss4gom4ii7bprqwnh34lxrs5uksjuvi5kzumecocl7ct57@4jc2pxbndlfx>
References: <20241002-defeat-pavestone-73d712895f0b@spud>
 <20241002-deliverer-recite-2c5a05f50721@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002-deliverer-recite-2c5a05f50721@spud>

On Wed, Oct 02, 2024 at 05:10:56PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Per the specifications, the d extension for double-precision floating
> point operations depends on the f extension for single-precious floating
> point. Add that requirement to the bindings. This differs from the
> Linux implementation, where single-precious only is not supported.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

FWIW

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


