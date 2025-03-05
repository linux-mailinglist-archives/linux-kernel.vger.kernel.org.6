Return-Path: <linux-kernel+bounces-546239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A4A4F83B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 899C67A63FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810081F584A;
	Wed,  5 Mar 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQozZsIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD41F4720;
	Wed,  5 Mar 2025 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160920; cv=none; b=PFzT2qjnReD1+7aofhOQDmAQzn/RCqgC7IZlbbczaU9EjzEkM14dJNKmX99lRCkCqq7Awe+TGqjzYbXqe6+ydhaaiS/KsFXy6hHvJXSNgq/SFe0/0kw714AeSCNXg+Y22X/u5XExp1SMhhA4SkmHvmZ4o0zVVs0RZewqJsL/KKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160920; c=relaxed/simple;
	bh=iMKL2RDKqBp74VZ9hJ67+/eIzp2gYTd+j5zRy1uEIJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9FB5xteDLfNcXwovRi+FWJ6tdF5ZtDJfpkcfd6P4f2W56oMsoIKZJmDJcOklT8zOTPj4NBHOLSzeqLcaXPniAozfJ/LIljcPCpyIsp0QEd7LQmUvw8UO7Azq8E/zvVyLzPldhMjHl8W+fhjdbP8cvuK7ZwrE+vINC1Y3RvoHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQozZsIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5A3C4CEE9;
	Wed,  5 Mar 2025 07:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741160919;
	bh=iMKL2RDKqBp74VZ9hJ67+/eIzp2gYTd+j5zRy1uEIJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQozZsInQZsrWppQoOS1vWx4amcLJK/aODWNwsV/3ufjxrAzc0IQzpdCNM2DnNrGA
	 JIvnJ/RgrR9CilOBajvcp68S5JTYOffKOj8k04FyF2m91W/ZUMGwVq7Pq9evdJGwuu
	 8qhvWjTbq8jINUBsDL1/bzGYP8FYhO8NY0d8l4WYT0/9c4XbvN50YAzf8mEZndTufx
	 r3lMlDyGkjNGelVf+UoQtEcqkQDrI9AQ3JlVe7kuE/PvbJlaSfdR611LiPRfsBjQoW
	 crw/IPrkNpfX3wy+5ZywlXoDzwDU7NSDad3RNFH3pqzAyU7fER3dlrv68aH76WbLDH
	 o1SaBMDuAINng==
Date: Wed, 5 Mar 2025 08:48:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: dt-bindings: Specify ordering for properties
 within groups
Message-ID: <20250305-defiant-serious-newt-b7c5ea@krzk-bin>
References: <09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org>

On Tue, Mar 04, 2025 at 07:54:42AM +0100, Dragan Simic wrote:
> When it comes to ordering the individual properties inside each property
> group, applying alphanumerical ordering can result in more logical and more
> usable lists of properties, just like it's already the case with the
> alphanumerical ordering of the nodes without unit addresses.
> 
> Let's have this clearly specified in the DTS coding style.  Also expand the
> provided example a bit, to actually show the alphanumerical ordering.
> 
> Applying strict alphabetical ordering can result in property lists that are
> far from optimal from the usability standpoint.  For the provided example,
> which stems from a real-world DT, [1][2][3] applying the strict alphabetical
> ordering produces this undesirable result:
> 
>   vdd-0v9-supply = <&board_vreg1>;
>   vdd-12v-supply = <&board_vreg3>;
>   vdd-1v8-supply = <&board_vreg4>;
>   vdd-3v3-supply = <&board_vreg2>;

Depending on interpretation (of which StackOverflow or Google answer you
read), that is actual alphanumerical order. What you want to achieve is
"natural order", so to remove ambiguity just use commonly used natural
order.

> 
> Obviously, having the properties sorted by their associated voltages in the
> ascending order, which the alphanumerical ordering produces, is more logical,
> more usable and more consistent.
> 
> [1] https://lore.kernel.org/linux-rockchip/b39cfd7490d8194f053bf3971f13a43472d1769e.1740941097.git.dsimic@manjaro.org/
> [2] https://lore.kernel.org/linux-rockchip/174104113599.8946.16805724674396090918.b4-ty@sntech.de/
> [3] https://lore.kernel.org/linux-rockchip/757afa87255212dfa5abf4c0e31deb08@manjaro.org/
> 
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/devicetree/bindings/dts-coding-style.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
> index 8a68331075a0..079d079f1ad9 100644
> --- a/Documentation/devicetree/bindings/dts-coding-style.rst
> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
> @@ -133,6 +133,10 @@ The above-described ordering follows this approach:
>  3. Status is the last information to annotate that device node is or is not
>     finished (board resources are needed).
>  
> +The above-described ordering specifies the preferred ordering of property
> +groups, while the individual properties inside each group shall be ordered

...shall use natural order by the property name.

Best regards,
Krzysztof


