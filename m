Return-Path: <linux-kernel+bounces-304401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A77961F9B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C529F1C239A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B8715B109;
	Wed, 28 Aug 2024 06:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0nXfAhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34D15AAC1;
	Wed, 28 Aug 2024 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826002; cv=none; b=IjDQJ5XrUD5Pm0Lx031N5xSzKXJ+FDqh3CFzLD0attt4kwNYmFiCyTVcI+6l2pmyvXJ6Q0xKCARwt23rDR8i4pkvzqvVMAtc27tutKZz8gBKmy6CPZwGK8d+bJ0RMmEsUYAtulOdz1O7JO5JONeh/0pTkVYp4Tq59fhsrix80qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826002; c=relaxed/simple;
	bh=JoalFGSFGSu1GSco+rtXIZaJJz9h6+f4TZHM40w9RtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqT/W7emwZ9s31G5gBuFDA37D0+lNy6X73pN/EnbYZo51/X8hXEEPTtUuFCK50V0WnfszAyhj0FLweB4Mb/8Wck9/HeVQuQDze0rQmKG3+SgXLBAQPqgyNEty+ni0TSTcaDkQI55pN8H94fQ5+gDrnZspWfffu9PW01cYr0huKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0nXfAhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4815C4FEAD;
	Wed, 28 Aug 2024 06:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724826001;
	bh=JoalFGSFGSu1GSco+rtXIZaJJz9h6+f4TZHM40w9RtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0nXfAhvYefB74UVvYcuXVW3TBoW5z1D7YZCcJcwh7et65wMa63NSh6Fa2MeTABdP
	 GqzTgM074kO0d/JzycdT8VIwM87sH4eXfOXLJDxA4zdzBFJWeg+1eNke6VTsUStH3u
	 xewp0RBWT6IK1hh0tJo4QTwcPLaLH2bJIREo2nLGeGR66ZYqaXBM+ftAPhMxHSj0ue
	 Oz8OaZkuvitWERQVrBDvRwKL7Py4/xJXP0V1Im+ZYtiSrNt3aUzkWZBBLDFZPWm1BZ
	 MHlGZkcRgnuh9UkfvvUsEPo9wDumis/ch5MKzUyU74SvsBHm3HoF4GE3onz7yRQD2A
	 o8HLW7tlWdHig==
Date: Wed, 28 Aug 2024 08:19:57 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lijuan Gao <quic_lijuang@quicinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: arm: qcom: document QCS615 and the
 reference board
Message-ID: <4aazgmrrikor5qpcmhth65d6jnsfnd4nqpy3ghxdtrscium262@sugmxgq2zfii>
References: <20240828-add_initial_support_for_qcs615-v1-0-5599869ea10f@quicinc.com>
 <20240828-add_initial_support_for_qcs615-v1-2-5599869ea10f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828-add_initial_support_for_qcs615-v1-2-5599869ea10f@quicinc.com>

On Wed, Aug 28, 2024 at 10:02:12AM +0800, Lijuan Gao wrote:
> Document the QCS615 SoC and its reference board QCS615 RIDE.
> 
> Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


