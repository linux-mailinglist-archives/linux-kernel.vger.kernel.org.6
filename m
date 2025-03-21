Return-Path: <linux-kernel+bounces-571347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F13EDA6BC07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D4F4619E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F1C17741;
	Fri, 21 Mar 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHx0i/iA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE9D35973;
	Fri, 21 Mar 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565078; cv=none; b=pKrJ6fFS+FBi496QcU6qSefV+0mWrq7R0EBlWm9tyceekuke4gPWGynjcng7LU69qjSOkdmyn46tfRAGZcdl4FoJWwLJEKp12MrqfVzSg6PEtcgKnGm8PZOwCgyB+JbTqrv8obaIEnq7VMIXV8VuNQ9UBOTmocw/QhI+xgXd4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565078; c=relaxed/simple;
	bh=ysMxJsf9Ik3h89sBTuQZmnzOORsafcbS3tgHBK7kCmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ3MLjL80n/9cFTMf7S9V75QtFY7X8Bc22O9unbfGbLPNUEgfH5Inq2fsuNH2MKrsNAj1pRkkv/E0+ebAnmgSCZmZUMU54JbnYrxN8DeM0W5ThEyj1Vc5Mgk/98AN9c0sSg8pdCCIATw+12DzUesaMNUH4VgoH8DXkmNSoS4Dig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHx0i/iA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983A5C4CEE3;
	Fri, 21 Mar 2025 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742565077;
	bh=ysMxJsf9Ik3h89sBTuQZmnzOORsafcbS3tgHBK7kCmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHx0i/iA3v7wSc+lKNmO66r1jNN0H1pcQRZR1EZuEimoHbBlwIuAr8NhNwfxE+3Ks
	 Ab8dHmQ0ymVcWfirydNn2WetPn6FEsHCKBw7q8iiYMOQDRODpFeURyq+PBxOea3s3A
	 e3KPF4DSirYvOVXRTfx3+QhJDsEYngHVxjPpjaFMvqWQ0KvXexmEkF1I5TnTTZveaj
	 LrZ3YYjUYZlZIS4V5q4P7NP4XoIAVrOdP+04/f30MtnQXB/KzkdGIEBfb7GjvVty1X
	 HLbDol/mauUtRszz0AGFf9dhT/rIdRlXK+sKs46i8RmlX6LeZhebGRFA6brEmmV1Sz
	 cu7jUcVQ3X2vw==
Date: Fri, 21 Mar 2025 08:51:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: krzk+dt@kernel.org, heiko@sntech.de, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v4] docs: dt-bindings: Specify ordering for properties
 within groups
Message-ID: <174256507574.3191205.4985643573799163920.robh@kernel.org>
References: <6468619098f94d8acb00de0431c414c5fcfbbdbf.1742532899.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6468619098f94d8acb00de0431c414c5fcfbbdbf.1742532899.git.dsimic@manjaro.org>


On Fri, 21 Mar 2025 05:57:09 +0100, Dragan Simic wrote:
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
> 
> Notes:
>     Changes in v4:
>       - Compacted both the introduced additions to the DTS conding style
>         and the patch description, as suggested by Krzysztof [7]
>       - Reformatted the patch description to obey the 75-column-width
>         rule, and adjusted the editor configuration accordingly, to avoid
>         such issues in the future, as suggested by Krzysztof [7]
> 
>     Changes in v3:
>       - Rewrote the part of the changes that describes natural sort order
>         and its relation to "standard" alpha-numerical ordering, to make
>         it more understandable, as suggested by Krzysztof [6]
>       - Slightly expanded the patch description, to clarify the additional
>         goal of explaining the natural sort order briefly
> 
>     Changes in v2:
>       - Changed the additions to the coding style to specify natural sort
>         order, which avoids amibguity, as suggested by Krzysztof [5]
>       - Adjusted and expanded the patch description appropriately, together
>         with including one more reference for the natural sort order
> 
>     Link to v1: https://lore.kernel.org/linux-kernel/09d6f2fc111b3d6e58987336944f93ec36b65118.1741071107.git.dsimic@manjaro.org/T/#u
>     Link to v2: https://lore.kernel.org/linux-kernel/47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org/T/#u
>     Link to v3: https://lore.kernel.org/linux-kernel/7276139ea1f4a5f4db48c77f536a3638492e6c2f.1741321984.git.dsimic@manjaro.org/T/#u
> 
>     [5] https://lore.kernel.org/linux-kernel/20250305-defiant-serious-newt-b7c5ea@krzk-bin/
>     [6] https://lore.kernel.org/linux-kernel/20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin/
>     [7] https://lore.kernel.org/linux-kernel/20250307-logical-nimble-okapi-3ba081@krzk-bin/
> 
>  Documentation/devicetree/bindings/dts-coding-style.rst | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Applied, thanks!


