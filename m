Return-Path: <linux-kernel+bounces-371770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBBA9A401E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36906B230BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E4E1D79B3;
	Fri, 18 Oct 2024 13:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnTlJzU2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1874433B5;
	Fri, 18 Oct 2024 13:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258647; cv=none; b=e8Y+BgaPhGDxDWtq5qBaD2xV8tkD3Ycyl1l6giprkCzpECx+PBIXYjVag7UBkEJKgan7VGzeTZqAD0KE+UerzrNMGVJcdgXkMZMmCaMqoqufarOS/IoJSdOqe/nIa46fIPZxU/UrBcO2GtMVgF9VKQTFbbvBG3woZkUsWxAkI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258647; c=relaxed/simple;
	bh=ULtqYgLIagmFvtNuPcNBTUlyEXuzpQb198/+we+a+7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL9MmCC1fy9C61mVvkvIoyAdRZIIy1B1wltMZ6kMb0xd2CuqyTk4bk1LNnh9o/DxpRUZJPd5Q5IoTmqINWk97V4Xj5cRPSQETrc4N8xHBmUABXD+HZQHGsxsC8idAiEirWkTt/otFBs5fRCAgNNOFoUPPegBtS5rqQQszPOXH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnTlJzU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9FFC4CEC6;
	Fri, 18 Oct 2024 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729258646;
	bh=ULtqYgLIagmFvtNuPcNBTUlyEXuzpQb198/+we+a+7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnTlJzU2yu/42Ov4xiyzDqMitBPnFb3mb3RnP2E08TXHZNYY9m/jshd3USob/w4bV
	 Tno2kBF4UWTYRQUBRPGk/0IETCvs5+lFs9Tbe1aATrc13S67PtL6S57jRV/TZoL5Z4
	 52PZQ9PJUnOYplVL4+ti67NooYHv4ff/lZ7HAAVdvP+pqDBUOGysHRgX+f8nW48H8X
	 c5NMi1ggBySUR0Jv5Ix8oOyVlh8I747Rj0utAsEgeS1h8NJ3BGF9DgjZjuAZqjhjtw
	 ObSGanZcKZbHHwOCa/a31Fjqn+QVmM6G4wY+nHXO/MJbHSi2PDQQu7PdoKDNDjp/75
	 +5A1nZxUigpvQ==
Date: Fri, 18 Oct 2024 08:37:25 -0500
From: Rob Herring <robh@kernel.org>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, dan.carpenter@linaro.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 3/5] dt-bindings: firmware: arm,scmi: Introduce more
 transport properties
Message-ID: <20241018133725.GA77066-robh@kernel.org>
References: <20241018080602.3952869-1-cristian.marussi@arm.com>
 <20241018080602.3952869-4-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018080602.3952869-4-cristian.marussi@arm.com>

On Fri, Oct 18, 2024 at 09:06:00AM +0100, Cristian Marussi wrote:
> Depending on specific hardware and firmware design choices, it may be
> possible for different platforms to end up having different requirements
> regarding the same transport characteristics.
> 
> Introduce max-msg-size and max-msg properties to describe such platform
> specific transport constraints, since they cannot be discovered otherwise.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring (Arm) <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Also, you missed Conor and that not the right address for Krzysztof. Use 
get_maintainers.pl or a tool that uses it (b4).

Also, no need to store maintainer addresses in the commit msg.

Rob

