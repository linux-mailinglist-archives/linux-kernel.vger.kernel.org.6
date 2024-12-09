Return-Path: <linux-kernel+bounces-436921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D459E8CA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431AF280FA8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E78215068;
	Mon,  9 Dec 2024 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRf4GsO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C75588B;
	Mon,  9 Dec 2024 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730763; cv=none; b=Qi7G4d9QNQM16XPELkAxeZR+154io/Du/zz3zflgZ0QOJd60JHvhI5gdF+l16HP9pJJcjf6ph4qmPWknem+2FUUenqI3D48hSC9xpT4N5ZtFaNvfXlgFq/8vWq7/Ia8bwx1CQr+VX35SG9WdKMT7Y37IE44IVItWTf29RfdgkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730763; c=relaxed/simple;
	bh=0tWTqSGiVFT/dCYy3N2L/Vl/4DImI7o+Xf6R8HXwG6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuMxmm59PPpBnIy+LndP9p8uUf8HGZ/xGR0OaxVNI0L1f4gR5z8bHkVlDqJ7imK0ZuTE3OzxRCJPJujU5wdeDdZhLBUH8kYT2ZPzb2Gxqz4lG5CnYJDwf/kR4XG4VwAH9zzCRdhn/SwMkOQJqm7cca8FJ3HT2swLF7WvyXsEju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRf4GsO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED8C4CED1;
	Mon,  9 Dec 2024 07:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733730763;
	bh=0tWTqSGiVFT/dCYy3N2L/Vl/4DImI7o+Xf6R8HXwG6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRf4GsO3FmNZENMToWx+Dh39CrsnyNS9g3a/82qSHB5ZHN3uOS1bonmqjMDr8m5l7
	 6ivYS8zmfgXF+FToCBnyiOWv/e5fINjEkRjDEZtZVn2KIfAjXYf20UktDRy9dOfOyQ
	 6CVm7pKXnWE3pJkpdTpr2zTd+z/FHmtz6kbv0b96g3dloLDZSDU1Z31S11ayu617Qa
	 yXLDPPt/0J0wg8xYZuXWpqw9+eBSyFRNvPUFgj+KXqzLbZuT4n4eYWws7dGDiKQ99x
	 mN1B3usa0iO0yVuRx9IXGVPNeS6HEYFFZs7L69mWxtG68ef8a71qJjWYC3ZLYFraGc
	 EXjxIiGiBhE4Q==
Date: Mon, 9 Dec 2024 08:52:39 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, alim.akhtar@samsung.com, linux-kernel@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
	peter.griffin@linaro.org
Subject: Re: [PATCH v3 1/3] dt-bindings: mailbox: add bindings for
 samsung,exynos
Message-ID: <2lkowhldq5i4otniijfw7cb3jm6ttatwji3npw5w7c5fyevnn5@ynojupmdyqy4>
References: <20241205174137.190545-1-tudor.ambarus@linaro.org>
 <20241205174137.190545-2-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205174137.190545-2-tudor.ambarus@linaro.org>

On Thu, Dec 05, 2024 at 05:41:35PM +0000, Tudor Ambarus wrote:
> Add bindings for the Samsung Exynos Mailbox Controller.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  .../bindings/mailbox/samsung,exynos.yaml      | 70 +++++++++++++++++++

Filename based on compatible, so:
google,gs101-acpm-mbox

but then entire binding seems for different device, so you most likely
miss here actual Exynos devices.

>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/samsung,exynos.yaml

Best regards,
Krzysztof


