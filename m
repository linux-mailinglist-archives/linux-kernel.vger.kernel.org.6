Return-Path: <linux-kernel+bounces-514610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A916A3593E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD82F16E49C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC37227BAE;
	Fri, 14 Feb 2025 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ertDIWL3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7143207E13;
	Fri, 14 Feb 2025 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522756; cv=none; b=fhOLt49CbQuyDUIf0DpZ9GHc7c84wFpm2wTHm/I0v+kCMblKT5SP/u328hsdS9x+3rN+2ff+Y5pX0NAwvyUlqnGLYe6RyRhFti31bHB4b6/HjoPOev+mxu156hqWE1xShT6NucEDcXWG09bI6Ht+qCWr8cECs7MB4PcEvBcMSXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522756; c=relaxed/simple;
	bh=fjB8HqmqVH8rp5Jz5lXC7wUNsIKwFQMVWWlI1UO4+4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFMPId243ffEgfin4F6Z+Dqt64rrhzL5SWvRv7irS7pqNhJRJ3qh73QnESjhfR8Me9/iH0upEHHpdtErBTUeS8udVWalTPDZawjv4WilSbqzCrQ4G8IvH0PoIlw8I7kbVmuAlBaB+2xvdLlbnyWgI0ZpNQD5GeZP7b+bpI7h2B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ertDIWL3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE00C4CED1;
	Fri, 14 Feb 2025 08:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739522756;
	bh=fjB8HqmqVH8rp5Jz5lXC7wUNsIKwFQMVWWlI1UO4+4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ertDIWL3KPj20gHOsk85e8SE4PyO6D68ljhLxDCK2scAfJ437BBe5bLIOTjmfh0/8
	 GbB5P3cMu3Fnj3USxCWsvTLsgem8rNzpUYGaxuXf2+dONmQlvbiBggwBfKXQe5rXke
	 M4ckpk+oBXkmqKB2mYf52rzrgKExzDq8t5IVt/nucSCSFZhDwgmn6PVkWVchbzG75e
	 eYBjPUv1FOQ98ah5s6cYIFeY58Ybnw7ftBbroHclC2kN6RKPrnA0TD0RGneA6QCvDX
	 a0StWKYfCtUyfp+UpTiaG6YJHSuE58TB/+6aUgYzPl0vxVvCrqEesddeD0iAPEv4JR
	 fxWtBD4/aujEA==
Date: Fri, 14 Feb 2025 09:45:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wilson Ding <dingwei@marvell.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, andrew@lunn.ch, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, salee@marvell.com, gakula@marvell.com
Subject: Re: [PATCH 3/4] [PATCH 3/4] dt-bindings: cp110: Document the reset
 controller
Message-ID: <20250214-pony-from-small-town-b48816@krzk-bin>
References: <20250214065833.530276-1-dingwei@marvell.com>
 <20250214065833.530276-5-dingwei@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250214065833.530276-5-dingwei@marvell.com>

On Thu, Feb 13, 2025 at 10:58:32PM -0800, Wilson Ding wrote:
> Add new compatible to be used for CP110's reset controller, and document
> the supported reset lines.
> 
> Signed-off-by: Wilson Ding <dingwei@marvell.com>
> ---

Subject: only one prefix

>  .../arm/marvell/cp110-system-controller.txt   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> index 9d5d70c98058..a5cc1360969c 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> @@ -190,6 +190,38 @@ CP110_LABEL(syscon0): system-controller@440000 {
>  
>  };
>  
> +Reset:
> +------
> +
> +The Device Tree node representing this System Controller 0 provides a
> +number of reset lines:
> +

No new bindings in TXT. Only DT schema.

Best regards,
Krzysztof


