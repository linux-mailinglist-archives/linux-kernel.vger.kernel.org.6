Return-Path: <linux-kernel+bounces-298401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FFC95C6C1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE21A1F27527
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04813C9CD;
	Fri, 23 Aug 2024 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkc8W+Dl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2FF3BBE9;
	Fri, 23 Aug 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398900; cv=none; b=eFXNYzGa7xbEIGu/MucyyjrNwI+YAG+TOEABqBwAYFLZHjI5z/cOSrf3CPjXns2R77on8OlVhOa6uPH0yNI5x32Lc7KOVbWFpueHBikXXQqHc2XiXS73cXgmaCovua8WV3gadIMfQw9gHkPTLFyonjxYQdVkTWATkh6Be9iXdeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398900; c=relaxed/simple;
	bh=uSuMIYE5J9JwrbpXy6YKRYp03TqzpYwFYHzWTNl0mLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxhhYB0gA1TojVmyOPoNt894Bl+RCSd9phNJyK7uKUnDNNodAXOU98+RpoOAgavNioGwHXG3VHzGSmcoY+Ptgwu/5Obq2T1z/I3bDC5SoCUM+f+s9CddFbygvIs4M82hNVgplFjgjKH72q+LdkFSqMAOz1TFNnPdtdfC2aj/EK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkc8W+Dl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E86C4AF09;
	Fri, 23 Aug 2024 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724398900;
	bh=uSuMIYE5J9JwrbpXy6YKRYp03TqzpYwFYHzWTNl0mLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fkc8W+Dl51nl/cScRCLABnW7Vd9Wdiber3O/GpmcKf9jUk+yDM42Vk8bPs/On9c6G
	 nOLZqiLT8QIh7xZ9wb6hM9Wg+BURbQfu58NNqcKFDh8HJXQxEIszHhUDn1GfuwbXsR
	 asdz35Nynbxy/4vIB+jwtA9R+3mI4okI9owIGD7TgUIZcmCymLfZq6/nwyW+NgHLnU
	 BNx3uHxjWSd7D0Lvz4zahiJilkVaZhl1YK2lmjFKXaGUZ16ZFUpC5aPDR8fraB/JUF
	 0PDwcrv7ABYj8VYntYRr2tEdx8PtM2JQYsOQBMsb0V4zSYwoSZUexDIVnNZG6TGjYF
	 1s6oSlQ+FeMqA==
Date: Fri, 23 Aug 2024 09:41:32 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Robert Nelson <robertcnelson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Jared McArthur <j-mcarthur@ti.com>, Jason Kridner <jkridner@beagleboard.org>, 
	Deepak Khatri <lorforlinux@beagleboard.org>, Drew Fustini <drew@beagleboard.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: ti: Add BeagleY-AI
Message-ID: <fe33a2tns5thgxwlyeqk7kh5lve6vqlfmkwiosh6mew3ohjcsl@rdiwvnqgoaw6>
References: <20240822170440.265055-1-robertcnelson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822170440.265055-1-robertcnelson@gmail.com>

On Thu, Aug 22, 2024 at 12:04:39PM -0500, Robert Nelson wrote:
> This board is based on ti,j722s family using the am67a variation.
> 
> https://beagley-ai.org/
> https://openbeagle.org/beagley-ai/beagley-ai
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

> CC: Nishanth Menon <nm@ti.com>
> CC: Vignesh Raghavendra <vigneshr@ti.com>
> CC: Tero Kristo <kristo@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Andrew Davis <afd@ti.com>
> CC: Jared McArthur <j-mcarthur@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Deepak Khatri <lorforlinux@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> CC: linux-arm-kernel@lists.infradead.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
commit msg. There is no single need to store automated output of
get_maintainers.pl in the git log. It can be easily re-created at any
given time, thus its presence in the git history is redundant and
obfuscates the log.

If you need it for your own patch management purposes, keep it under the
--- separator.


Best regards,
Krzysztof


