Return-Path: <linux-kernel+bounces-444651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A03A9F0A50
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3767E1697A9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5702D1CC8A7;
	Fri, 13 Dec 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBumTtSt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9D1C3C0C;
	Fri, 13 Dec 2024 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734087704; cv=none; b=aYkWsYNPULk+cHnN8uZPQD8uasETMuXmFkUZDySEaV0Mutf2dMVEpFEjr1ocT1yyLQowATSbvcH6VlHAcKsOHtxR1gb+8BuIYdoFOEqYOTUOsSeLzb+bV9DvnP5zYaZw1mV8nFBfj07at+e6vMmUZNxIk+pnsqks1N9wGr7e6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734087704; c=relaxed/simple;
	bh=IofNVG0zU7gHx4tYBw2xXCHROFDyOsBnsepuoYN+7qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjaxTK5fdT366W/c3N0xxtRcwRpHyTShsOYGrRntO49Zut6L0knRdGFmw/yG1whQXJa7XTAViXel2jYda+DMH4XH8XQ4ofphSQ4sJVT2B/IoQBtVBYlxti13fhn1X1PCH7b7K2CYBr2IlzpQwufUhdSEDLPpR9SXVPpDntBjB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBumTtSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F664C4CED0;
	Fri, 13 Dec 2024 11:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734087704;
	bh=IofNVG0zU7gHx4tYBw2xXCHROFDyOsBnsepuoYN+7qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBumTtStQXkF4wRu3+RXFGUINUB0TNoEPN9DVsTfSHCP9eQlB/thu6o+5igdfJQNW
	 ZgA2uixVeyZfjlDS5kKiU8R1s2cyXm+1RpSJP/lTUVTyUkfvDCXAi6fbWIfWqCBfVC
	 6fIaDRC5AAergpps4d3GrWKSDLfh2YzRNp/Uh4c587usk3sDQGp+iGkRKiumGqxngO
	 bHzF3tE+wZ3xpH8Vj9GAWe0le8UbGA/R0C1AtbTIi5ZyT5tBTzlcCOc8LMb6QYwr8l
	 nmcICjYMtkyKpU84roFAnHWlltAgO8H69ro81Z+tfnMuW6Sf4lk3tJ8BvF+V5ym8mf
	 y24c9R5YPMi7w==
Date: Fri, 13 Dec 2024 12:01:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH 1/2] dt-bindings: clock: add ID for eMMC for EN7581
Message-ID: <bzdhbuxr6zyln2ecxnamfzlblcigdfe7r4vvwcggf35kgyozk6@it2sm6fpypa5>
References: <20241211112253.27905-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241211112253.27905-1-ansuelsmth@gmail.com>

On Wed, Dec 11, 2024 at 12:22:37PM +0100, Christian Marangi wrote:
> Add ID for eMMC for EN7581. This is to control clock selection of eMMC
> between 200MHz and 150MHz.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  include/dt-bindings/clock/en7523-clk.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/clock/en7523-clk.h b/include/dt-bindings/clock/en7523-clk.h
> index 717d23a5e5ae..78d16068228a 100644
> --- a/include/dt-bindings/clock/en7523-clk.h
> +++ b/include/dt-bindings/clock/en7523-clk.h
> @@ -11,7 +11,8 @@
>  #define EN7523_CLK_NPU		5
>  #define EN7523_CLK_CRYPTO	6
>  #define EN7523_CLK_PCIE		7
> +#define EN7581_CLK_EMMC		8
>  
> -#define EN7523_NUM_CLOCKS	8
> +#define EN7523_NUM_CLOCKS	9

This cannot change.

If this changes, then it is not a binding and first drop it in separate
patch.

Best regards,
Krzysztof


