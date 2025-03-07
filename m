Return-Path: <linux-kernel+bounces-550761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B7AA563C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480FE3B2718
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41D20AF8E;
	Fri,  7 Mar 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACQHOJD9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352020551E;
	Fri,  7 Mar 2025 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741339740; cv=none; b=oH3H2DJc/j/2suJHJ6bLZXnPz25Eg4rS284w4PjgKR512fE1ztwGondEXYDP4RZwq0+8ZfcySyONiGp8FyPL7yUgJXQRhcN+pUsfB93nADAG4kstptliUVc5irZDydHRYUhQczgjWtcPSUAzWdAXOl1RYcuhaMqqHE/S716eyfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741339740; c=relaxed/simple;
	bh=tuDzms1c08aaCrllft0fOlV2NkLbo4xq5O/5uzKY6M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUAwcGfDV7zZSz9Zr41lmgTwbrFd2a4MGH3dr/OtaGwCx9Ot88kHOU+DdsUIK5PSC0cgo14KaDlGRrMMk+YLIuVj9Q2Z5kiPfCgPUVJEziUzwghafi3iqOg7G2IVvGNAhrdZg/0Po1QJEeq8Q1od/lXlZR0b48nOxaV2uRpkNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACQHOJD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33507C4CED1;
	Fri,  7 Mar 2025 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741339739;
	bh=tuDzms1c08aaCrllft0fOlV2NkLbo4xq5O/5uzKY6M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACQHOJD9bN90viiTY9SufDegsBVusbO9zg8+V4AbLjviH78OHUVfsLvp8K9GPBbtR
	 X9EjZTNZ30m2yAs0d8MClY9Vwdhq76D5BkM9txjQnTn5t2fxOYczYWH378TeTav+RH
	 Gpe0x3WC2UOjzHZE1/6GeAIbNALbnFwViDAfe7wH230U6xvyqqA54VnLDKGTutL1R8
	 44DDSfn0L5kWvpREV1Ac/FYmlGryipRmhVD3RznfMxQ0NqkeD74ZiV3Or3l5+Sy4CC
	 45FgsOcudPTxx/Y7i+U6JWmJawVzAyoGLFa8UsLHao0Rk4zcEznlIpoAitko6C0QIc
	 ikuAKLkXKoZhw==
Date: Fri, 7 Mar 2025 10:28:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: dt-bindings: Specify ordering for properties
 within groups
Message-ID: <20250307-logical-nimble-okapi-3ba081@krzk-bin>
References: <7276139ea1f4a5f4db48c77f536a3638492e6c2f.1741321984.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7276139ea1f4a5f4db48c77f536a3638492e6c2f.1741321984.git.dsimic@manjaro.org>

On Fri, Mar 07, 2025 at 05:33:37AM +0100, Dragan Simic wrote:
> When it comes to ordering of the individual properties inside each property
> group, applying natural sort order to multi-digit numbers [1] found inside
> the property names can result in more logical and more usable property lists,
> similarly to what's already the case with the alpha-numerical ordering of
> the nodes without unit addresses.
> 
> Let's have this clearly specified in the DTS coding style, together with
> a brief description of the natural sort order for those readers who aren't
> familiar with it already.  Also expand the provided node example a bit, to
> actually show the results of applying natural sort order.
> 
> Applying strict alpha-numerical ordering can result in property lists that
> are suboptimal from the usability standpoint.  For the provided example,
> which stems from a real-world DT, [2][3][4] applying strict alpha-numerical
> ordering produces the following undesirable result:

BTW, your entire commit msg still has incorrect wrapping. Please use
standard editors which understand Git commit msg style (which I believe
is equal to Linux submitting patches).

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
>     
>     [5] https://lore.kernel.org/linux-kernel/20250305-defiant-serious-newt-b7c5ea@krzk-bin/
>     [6] https://lore.kernel.org/linux-kernel/20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin/
> 
>  .../devicetree/bindings/dts-coding-style.rst       | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst b/Documentation/devicetree/bindings/dts-coding-style.rst
> index 8a68331075a0..7d183c1ade74 100644
> --- a/Documentation/devicetree/bindings/dts-coding-style.rst
> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
> @@ -133,6 +133,15 @@ The above-described ordering follows this approach:
>  3. Status is the last information to annotate that device node is or is not
>     finished (board resources are needed).
>  
> +The above-described ordering specifies the preferred ordering of property
> +groups, while the individual properties inside each group shall use natural
> +sort order by the property name.

I guess you sent it after my today's reply. Full stop, done. Such
trivial thing as sorting should have one line. Three lines is already
longish, but fine, especially that it can be one line.

"Properties within each of above groups should use natural sort order."

> +
> +The natural sort order differs from alpha-numerical ordering only by treating
> +any single- and multi-digit numbers found inside the property names atomically,
> +and by taking their actual numerical values and comparing those values between
> +themselves to determine the order of property names.

8 lines is 8 times too long.

Best regards,
Krzysztof


