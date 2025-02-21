Return-Path: <linux-kernel+bounces-525360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7609AA3EF02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23963B0BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879B1201031;
	Fri, 21 Feb 2025 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pA12SeK2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53872AE89;
	Fri, 21 Feb 2025 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127653; cv=none; b=CWbDsxPFAIr0NjLWQnBKPIdq1oW5EzfHlVXvUxWtfeAnWdNpfBSi+ztG5hgJe19TJ53jDSppuuZOrzpEM723vFpE9A9wuGjoUsutKS6EWotHvV74KpR+zH6wdXwf6FwWZkiW1/zEYZ57cSPoY/j3HeDhVaqE1qdzqRh5z7GvAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127653; c=relaxed/simple;
	bh=Q6R2QTZZ/LkeT1rRcRWPfG6wHMIMkwW77Qivvtr9ez0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQyu8YVeRimcqdrRiA37mu6tLcZCpva+MkDfNno7SVlTZhMLKbE2VWmnlG431R5OmcrnawFwouECNyLgJRL2oI6PQAGoPgto9ZOZ4P+S8zjq4uu2/xXciNo/nrJv0WQI2achxscGqcdYVHeu1nA67RAEwHYkxDMh5yMWC4OiSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pA12SeK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71E2C4CED6;
	Fri, 21 Feb 2025 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127652;
	bh=Q6R2QTZZ/LkeT1rRcRWPfG6wHMIMkwW77Qivvtr9ez0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pA12SeK2hrTEOvLyIhrLLK9l2gkUQBiT8i71oXg2cu7FpAaY/yXaRZizSm0TQ2E1D
	 gjDhb/QEHRm3++GXXJsRJ3uDQM73BgeY63OILk8dp5+M8eaUOdTz/0DTp9o+DBwQxV
	 Otg6m0ep7sKY1qqGdONPqeTNWwP4izNkYSJkj7udeX07ycI4b7nXenGUkHUKr05nJL
	 aEP1+nqETTI0ll5nH281D8Y7QpwL0wnWqx8Dulrs7sXigOpZyHcYp9oT2PFm4nshIy
	 D6kjw3gOmBDm92Iv7EoRB3k0W8H6z8fUicOm9n/5BCJr47klYjY1N5i7XE7Zw/0WuK
	 AD4tapFr9m9Lw==
Date: Fri, 21 Feb 2025 09:47:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, salee@marvell.com, gakula@marvell.com
Subject: Re: [PATCH v2 4/4] arm64: dts: marvell: cp11x: Add reset controller
 node
Message-ID: <20250221-majestic-opal-ermine-cfe5a3@krzk-bin>
References: <20250220232527.882888-1-dingwei@marvell.com>
 <20250220232527.882888-5-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220232527.882888-5-dingwei@marvell.com>

On Thu, Feb 20, 2025 at 03:25:27PM -0800, Wilson Ding wrote:
> Add the reset controller node as a sub-node to the system controller
> node.
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 161beec0b6b0..4cd900c02b3b 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -273,6 +273,12 @@ CP11X_LABEL(gpio2): gpio@140 {
>  					 <&CP11X_LABEL(clk) 1 17>;
>  				status = "disabled";
>  			};
> +
> +			CP11X_LABEL(unit_swrst): reset-controller@268 {

Test your patches before posting. You have here warnings - see W=1.

Best regards,
Krzysztof


