Return-Path: <linux-kernel+bounces-570971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18C1A6B72C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1B11895EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA71A1EEA39;
	Fri, 21 Mar 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzyEt7GT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD981EFFB0;
	Fri, 21 Mar 2025 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549073; cv=none; b=pNYdBmnWTUO7xJ9cCQxJqRHafd/h8jO9NFzTR8Yw/piGHS371lBDlyxSJnS11zfRdCtsDVN7SZvDgZxFX1UbUZC6GAhUD/S0rr4m50wwIGEA20VxMOQg8DUv+QoTdhR2tIDbaoTbSY+D0elEdQvhXZ5hBodgddtHhIJ7SK15LqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549073; c=relaxed/simple;
	bh=hcZepsJVZIicztpwdbpb4ekmKnIA5d/Q/tXIMTCkFdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjcVrQGToHnXmzHxOSb7TN8hCm3fQtJLbD6DQOdf08zbj2+FKAq5mQ2Lp7LpvEruc88u80ImGQ+4nZicbn3KKyg3/6Ly9U4xDGYpl7fcGInB7+u7dKUWwU7mjA9GidYda5Ydk8Gc1zSnxJqiUX7gpQL3qnnuehxCD13scb2fUAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzyEt7GT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A2AC4CEE3;
	Fri, 21 Mar 2025 09:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742549072;
	bh=hcZepsJVZIicztpwdbpb4ekmKnIA5d/Q/tXIMTCkFdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BzyEt7GTILQJAkhWXHU8IU07sJd+NniOTGiLjoHl0apnZSeAaff053qYCwPdt/t84
	 i1QwbEf4+kDs5hhZuMG9TuQDLN0FvUMWVmKBnj9xT+G13tBIaLMD7cFZRNqCPB3jff
	 DG8w48ozZ3EnWfYye5Kd9AMPvKFG5Izwsdy5y1qQjq6H/Nxj7cpwhxYixnxePVZApz
	 roonnDJCbyD2XtluC1+IXF2RzabqVKele4koP+IDtQC2CcVy2xWFGCI2pLwHXfrhXe
	 ehsjaO/Mu9Zw/BOWiTJAp2eTQq+MFtWH3lzsI+qo8L1GOEmBmtI5wUiddZRbomgdUl
	 MoDkiWrW41eHw==
Message-ID: <eb0a67a7-8253-4f57-87d7-bb74e45aecaa@kernel.org>
Date: Fri, 21 Mar 2025 10:24:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs: dt-bindings: Specify ordering for properties
 within groups
To: Dragan Simic <dsimic@manjaro.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <6468619098f94d8acb00de0431c414c5fcfbbdbf.1742532899.git.dsimic@manjaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <6468619098f94d8acb00de0431c414c5fcfbbdbf.1742532899.git.dsimic@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2025 05:57, Dragan Simic wrote:
> Ordering of the individual properties inside each property group benefits
> from applying natural sort order [1] by the property names, because it
> results in more logical and more usable property lists, similarly to what's
> already the case with the alpha-numerical ordering of the nodes without
> unit addresses.
> 
> Let's have this clearly specified in the DTS coding style, and let's expand
> the provided node example a bit, to actually show the results of applying
> natural sort order.
> 
> Applying strict alpha-numerical ordering can result in property lists that
> are suboptimal from the usability standpoint.  For the provided example,
> which stems from a real-world DT, [2][3][4] applying strict alpha-numerical
> ordering produces the following undesirable result:
> 
>   vdd-0v9-supply = <&board_vreg1>;
>   vdd-12v-supply = <&board_vreg3>;
>   vdd-1v8-supply = <&board_vreg4>;
>   vdd-3v3-supply = <&board_vreg2>;
> 
> Having the properties sorted in natural order by their associated voltages
> is more logical, more usable, and a bit more consistent.
> 
> [1] https://en.wikipedia.org/wiki/Natural_sort_order
> [2] https://lore.kernel.org/linux-rockchip/b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org/
> [3] https://lore.kernel.org/linux-rockchip/174104113599.8946.16805724674396090918.b4-ty@sntech.de/
> [4] https://lore.kernel.org/linux-rockchip/757afa87255212dfa5abf4c0e31deb08@manjaro.org/
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

