Return-Path: <linux-kernel+bounces-534393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F49A4668E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2701648BF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F6A21CA04;
	Wed, 26 Feb 2025 16:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu4APmzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237811A238B;
	Wed, 26 Feb 2025 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586188; cv=none; b=T/ecwh9xxenfR+Txx6CP176Wbq3kVK+ZJ5mhhUfylDGI8JjYC8IuEWyAXSZsBCMiRpwTnAZqF2Mky6BEBMStRfE9cEL/hI47F0tecp4ZDEwXqKjzZ8Px1j5rDpBtMHQobdsMJSBn4Wi0+RTJpUFAzgOokyHt77N9t00cGgsy9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586188; c=relaxed/simple;
	bh=4fr3AKLLBzkmgQNjqldIIllTzp1wJuSK/spkoGmZf2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYEInpxprVlC2ng9QwcHvUwXP0pGN5zau3Sqf6+kEw4WFGiomBZOPgAfCvcqmmKzLYlwymV4COxUPLwypd5gZW0YkYhEr26DDqXLUKDdTRWbaylfsqFD9TUz+y3s1cNsnQjvj2TdGBBKNaQZL/EfJbPacvJ1UUA5C8G6XGBq1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu4APmzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611D8C4CED6;
	Wed, 26 Feb 2025 16:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740586187;
	bh=4fr3AKLLBzkmgQNjqldIIllTzp1wJuSK/spkoGmZf2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cu4APmzBKKuG1yJTJ3Kjzvu1b/XV9Lgfb2iRpXh+ViZ4QaRYwFT8bgukcpTgTPW3w
	 t3Y9upodYRnbs1cyShcUhMo9PNaG3kTcymlYNiHJwVFAvSJSL6nf6uc6TtcDYPtb7q
	 RrQXfvcN47tfVix7Qb2POo5LbdEl+ZfzdbSOWe1F2z3GWn5fZPijM6KcNy7L4dOdBP
	 U4qMNBM8OuRRRqdxt0dz/Kx90tw0f4mVnL3iUYGIrA2IB72LjLsAnkHqVvX/oiInjV
	 jAlPo7gHP9ppOJx2UZN61dD7zL9u6Mc3VYHe2fVS9/MsFVHdRIsmY4KgKcOQrt8rEa
	 rB4CQG+OZLQaw==
Date: Wed, 26 Feb 2025 10:09:45 -0600
From: Rob Herring <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, saravanak@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <20250226160945.GA2505223-robh@kernel.org>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226094456.2351571-1-peng.fan@oss.nxp.com>

On Wed, Feb 26, 2025 at 05:44:56PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add compatible string for the protocols by adding new nodes
> The current nodename pattern is "protocol@[0-9a-f]+$", the new node
> name will be "scmi-[a-z\-]+$".
> With compatible string and new nodename, cpufreq and devfreq could be
> separated into two nodes. And fwdevlink could correctly link suppliers
> and consumers.
> With compatible string, and driver updated.
> - Differnet vendor drivers with same SCMI protocol ID could be built in
>   without concerning vendor A's driver got probed when using vendor B's
>   SoC
> - NXP scmi pinctrl and ARM scmi pinctrl could be both built in, without
>   concerning arm scmi platform takes nxp scmi pinctrl node as supplier.

How are you going to handle DTs which aren't updated and still don't 
have compatible strings? Seems like that would be messy if not 
impossible.

> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> RFC:
>  This may sounds like that adding compatible to resovle linux driver issue.
>  Yes indeed. current scmi framework limitation makes it not work well with
>  fwdevlink, wrong suppliers maybe linked to consumers.
>  I have tried various's method to not introduce compatible, but rejected by
>  fwdevlink maintainer or scmi maintainer
>  There was a long discussion in [1][2][3].
>  [1] https://lore.kernel.org/arm-scmi/20240729070325.2065286-1-peng.fan@oss.nxp.com/
>  [2] https://lore.kernel.org/arm-scmi/20241225-scmi-fwdevlink-v1-0-e9a3a5341362@nxp.com/T/#mdd17c4b9b11af9fae0d5b6ec2e13756c2c6f977d
>  [3] https://lore.kernel.org/arm-scmi/20250120-scmi-fwdevlink-v2-0-3af2fa37dbac@nxp.com/
> 
>  The binding changes are posted out to see whether DT maintainer's view on
>  whether introduce compatible string is welcomed or not.
>  I not include driver changes, because this is just to see whether people
>  are happy with this or not.
> 
> Quote Sudeep's reply"
> I am not blocking you. What I mentioned is I don't agree that DT can be used
> to resolve this issue, but I don't have time or alternate solution ATM. So
> if you propose DT based solution and the maintainers agree for the proposed
> bindings I will take a look and help you to make that work. But I will raise
> any objections I may have if the proposal has issues mainly around the
> compatibility and ease of maintenance.
> "

This all looks to me like SCMI has failed to provide common interfaces.

I'm indifferent. If everyone involved thinks adding compatibles will 
solve whatever the issues are, then it's going to be fine with me 
(other than the issue above). It doesn't seem like you have that, so I 
don't know that I'd keep going down this path.

Rob

