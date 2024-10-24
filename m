Return-Path: <linux-kernel+bounces-380178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA54E9AE9D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32BE1C24946
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5171EB9EA;
	Thu, 24 Oct 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2dc+NEY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2168A18A957;
	Thu, 24 Oct 2024 15:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782478; cv=none; b=l5WqTz5tc6EtPrVAt8rCjyeqKDP7w9KELFjmyA2Hlirjv/QsJe8lq38jx0eqc5wBZs4WnpJdW9owPXVdXFiYiXzgtwZc7E44ZWW0mrZ0J1/Fc4hjLaEsXW7Ie9k3M1nCHxz/0BG0x5k7q1dpGK5rD9yTpbbipUmJyMp+AWzpSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782478; c=relaxed/simple;
	bh=G/5iQPqYa/lDZoknc7Hbx360J3DWwXAFD/scyK1iRjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jYY119JyuYS020qKyRXwIq2UgVYzw2EySriBb9JOzU8FfyAd2DnLasf1L4eVrf0FTBocOwZLT1LFT/EMMwwwfJH6HgdRd5WRc4eSpIqoaN1Q3l2Zps406cl9Rjl6XB4WeUyml7tBQA0PB2zHCjOqFdN3qS1jZ3c4lXI5CDhPSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2dc+NEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42EDC4CEE5;
	Thu, 24 Oct 2024 15:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729782478;
	bh=G/5iQPqYa/lDZoknc7Hbx360J3DWwXAFD/scyK1iRjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d2dc+NEY8TbmlJwRn3drLG99OfJ33RUQh3pzdyCQVzheHiEaetaZCbfd+x+9ELG+Y
	 5IhCl2SoGDNzYEP5epNZzUPSb5R+p7e7SXL5TfXdU3NIBiwj+tXZ6ndalSg+LIAk5s
	 Byh1w86QBM03wNm8nfrV/bHQ/3ZGzSihsviTGHHcG/lewo5oY2wyoo/NonqHISWF2e
	 vaM9pSaYN3v3nP+vOEvMVelqev+smXf1NgSjvu1/50BOt26R1NI7/RC7/bFwJSjhqO
	 umvSpcyy1y7Juwjce96U6JKuJcxCHXhXoZcipEfroz5r28ILSJ/UuVX+LUcAuZFy+P
	 xnsLsdTZt46cw==
Date: Thu, 24 Oct 2024 10:07:57 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: quic_sibis@quicinc.com, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	peng.fan@oss.nxp.com, devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, arm-scmi@vger.kernel.org,
	etienne.carriere@st.com, dan.carpenter@linaro.org,
	michal.simek@amd.com, sudeep.holla@arm.com, f.fainelli@gmail.com,
	james.quinlan@broadcom.com, quic_nkela@quicinc.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/5] dt-bindings: firmware: arm,scmi: Introduce more
 transport properties
Message-ID: <172978247557.479027.5212897770192282629.robh@kernel.org>
References: <20241021170726.2564329-1-cristian.marussi@arm.com>
 <20241021170726.2564329-4-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021170726.2564329-4-cristian.marussi@arm.com>


On Mon, 21 Oct 2024 18:07:24 +0100, Cristian Marussi wrote:
> Depending on specific hardware and firmware design choices, it may be
> possible for different platforms to end up having different requirements
> regarding the same transport characteristics.
> 
> Introduce max-msg-size and max-msg properties to describe such platform
> specific transport constraints, since they cannot be discovered otherwise.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
> v1 --> v2
> - added vendor prefix
> - dropped warnings about resonable minimum max-msg-size
> - clarified the intended usage of max-msg
> - fixed Cc to include all maintainers and using correct e-mails
> ---
>  .../devicetree/bindings/firmware/arm,scmi.yaml    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


