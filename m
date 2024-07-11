Return-Path: <linux-kernel+bounces-249844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC392F0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC0E1C227D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFDD19EECC;
	Thu, 11 Jul 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPZeZvQt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6742836A;
	Thu, 11 Jul 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731907; cv=none; b=aEdxj5wCyOjiFuvSU8LI8N1hFwfajtM+Cd+6PLWq6OSvyecNQDx3huzsZs+lwrigMqpBTiYj6T0Fwa8BHQCrjuryYtYNUwMhvsTdYRK38W2ds0fYxouQCGTAuNWfshRrUpz73UdwHfAjMboWASgHDwpe8JbYndtjUMiZjZc0xZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731907; c=relaxed/simple;
	bh=3jqK9z5obIbcs9Jg0tepPrZ7iJhDnV/5fTFHtqahsiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FE65U4mYGK0OsnISTJUTzsCA1am30NBvhZmURJ6FKEbOkuskJNp6chT+HKLoIwmI0/rSwJpCA26xqSK5GNp5f2RQI+edPPsLLGRbiHMYK1rwuyk0i8khKEQZoE8qJSbggRdAPk/klOvblHg2nbxH975t+njQfR3SC1UrrQBYbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPZeZvQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09008C116B1;
	Thu, 11 Jul 2024 21:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720731907;
	bh=3jqK9z5obIbcs9Jg0tepPrZ7iJhDnV/5fTFHtqahsiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPZeZvQtaPIV9G7RVDKYew/BcAyEXZtDiCl+23TNOJmmTCCdiYDv7r6TueyXI5r0b
	 lWT7IL2elhrNFHwd/yicBTbnqC3WhggWCG5gn9gmVZ/Vhe5mWcKo1WgA7IXgr1guyp
	 XMeLnas0cCqlW+WYBAP4WniquiRAaMcNHdP7i9v1O3YzvP34ukCAUze4jk1E/ivXyB
	 jFyig1Ah2Xxo1DREs0S1/fp/2Or9BVNeVouCVCcGIrnAaw3rNspSESkLn0q4LUU2n/
	 xF5gggMiwYsugXK+f9EF8F1p6IIyRddRSZE7QyHkzWcZzOSHPusHFnvYfRSJFkz5vS
	 ZzQq7urgkx/Hg==
Date: Thu, 11 Jul 2024 15:05:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: devicetree@vger.kernel.org, cristian.marussi@arm.com,
	Peng Fan <peng.fan@nxp.com>, sudeep.holla@arm.com,
	conor+dt@kernel.org, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Message-ID: <172073190412.3008130.10566834515724904100.robh@kernel.org>
References: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709140957.3171255-1-peng.fan@oss.nxp.com>


On Tue, 09 Jul 2024 22:09:56 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> System Controller Management Interface(SCMI) firmwares might have
> different designs by SCMI firmware developers. So the maximum receive
> channel timeout value might also varies in the various designs.
> 
> So introduce property mbox-rx-timeout-ms to let each platform could
> set its own timeout value in device tree.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  Add minimum: 1, because 0 is invalid. maximum is not set,
>  because it is platform specific and unknown.
> V2:
>  Drop defaults, update description.
> 
>  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


