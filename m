Return-Path: <linux-kernel+bounces-534264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3164A464F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677C6422802
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAD122D7A6;
	Wed, 26 Feb 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CirGU35G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898022DFB4;
	Wed, 26 Feb 2025 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583752; cv=none; b=WT/3PeSzuABKJTgUHMfs16ycj4y7vujlqk6U+Y8lmUYuIagLZimJuC4b95OzsRhtrQIoznEP11zx6rq8Pf+hEinMcqnERMFoaiDI8MH/qkT5v1qoWv4la73JMqaTPZtt/l3LzDIgAGyFafUTsNWH4AZzIjK6ozHSIRg0WtfoB9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583752; c=relaxed/simple;
	bh=sKRVeYhyukm96bknDTD2EmlHYAe8l6aWTLbHIvrVzXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9gvUukw/wZqFGYif49rW0g2HgKvISnPi+pb6HL5FTkONG6NNYP0NNHWynH1KX0zUHUwpHQUkYDBcimIqLnu9L3FJHXS3uBv/6tuXZBTnHlTx3BBRifhMeXtuIwECgLzoZyWGnBVe2sRjpp5Ey5UIAfDvAxAXdK01/tPugQqys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CirGU35G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4E2C4CEE4;
	Wed, 26 Feb 2025 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740583752;
	bh=sKRVeYhyukm96bknDTD2EmlHYAe8l6aWTLbHIvrVzXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CirGU35GPeHlxtFxKVWIE3cm0UoYzCuquO3h/VDCvPTp+BHhGC8GVW3Pgox2M42uc
	 pJ/XDGdkxEYY/xbjHsQxYn5WLK22RIpxH2+qFUYBfpJnkAj9HnFowM02iZs2oMXUPi
	 Becd8q3gjyMj8cOkzkSRnNMMIpAWedAvG8KBV0/K2Lf64Lh+TLEE3tr+knjcYFkIEb
	 nV0kR2ir+IKcpDBcw4WzDZdqFg6O6Adoa74d1Ul7U77SZ0GgB3NsZWYsLVPb5n9PXy
	 4Tt89qPuxThM6u2Aqk61Sn+WSqu9ErO+3MDEQ39+kL5kNalF2YYKuh88MqJvwBh9GX
	 ZQGfDH6zN4bNw==
Date: Wed, 26 Feb 2025 09:29:10 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] docs: process: maintainer-soc-clean-dts: linux-next
 is decisive
Message-ID: <20250226152910.GA2447540-robh@kernel.org>
References: <20250225184822.213296-1-krzysztof.kozlowski@linaro.org>
 <20250225184822.213296-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225184822.213296-2-krzysztof.kozlowski@linaro.org>

On Tue, Feb 25, 2025 at 07:48:22PM +0100, Krzysztof Kozlowski wrote:
> Devicetree bindings patches go usually via driver subsystem tree, so
> obviously testing only SoC branches would result in new dtbs_check
> warnings.  Mention that linux-next branch is decisice for zero-warnings
> rule.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/process/maintainer-soc-clean-dts.rst | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/maintainer-soc-clean-dts.rst b/Documentation/process/maintainer-soc-clean-dts.rst
> index 1b32430d0cfc..5423fb7d6047 100644
> --- a/Documentation/process/maintainer-soc-clean-dts.rst
> +++ b/Documentation/process/maintainer-soc-clean-dts.rst
> @@ -17,8 +17,9 @@ Strict DTS DT Schema and dtc Compliance
>  No changes to the SoC platform Devicetree sources (DTS files) should introduce
>  new ``make dtbs_check W=1`` warnings.  Warnings in a new board DTS, which are
>  results of issues in an included DTSI file, are considered existing, not new
> -warnings.  The platform maintainers have automation in place which should point
> -out any new warnings.
> +warnings.  For series split between different trees (DT bindings go via driver
> +subsystem tree), warnings on linux-next are decisive.  The platform maintainers
> +have automation in place which should point out any new warnings.

I see a lot of warnings due to dependencies (both bindings and other dts 
changes) not be applied yet (or applied but not in linux-next). I've 
been filtering those out, but maybe they're useful? Some are things like 
missing labels, so dtc fails. I think that gets run enough a failure 
report on it isn't too useful.

Rob

