Return-Path: <linux-kernel+bounces-537887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63884A4921E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 911643B70F2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008CC1C7B62;
	Fri, 28 Feb 2025 07:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cM42Wz0T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8041C68A6;
	Fri, 28 Feb 2025 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727448; cv=none; b=hJOl52QeWA5U1UY+9/0ZjIFnWq8YuT6dHxxqUqtcuBsZXsFHV8gWz0ry4tFSt89zxY7MOJ1SyJR8a9dFWaniCwX5cAbfm/grGXEMvN3nouUYoCWMeZi/+48c40Uxfgaz+bh9gfjxt1JQp6+B4dygHg+bjHIOWACrWAMb8hby/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727448; c=relaxed/simple;
	bh=hiaw9mQvo3JNGczetxHm5CU3JKRJwSl1WWGYscMRTzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZZOt9EFvczLCXrfv9GNKbI0/Q0ThdXCsWVRtyIkHfp/9ShX7nEu+GXz5IP601p0ejMscph+bV6L9oWAsGRrek68tOOO8A9wW7Z5x67kBHMIKrI6gUTVV2DxhDLQnBUeebp4VPLtCXqMeOnoPMjzVuwGpjdbfjAI52Y41IHR+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cM42Wz0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D68C4CED6;
	Fri, 28 Feb 2025 07:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740727447;
	bh=hiaw9mQvo3JNGczetxHm5CU3JKRJwSl1WWGYscMRTzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cM42Wz0Tyx+szs3B5xpHrdNi6e8mNeh2nqCIey8mMx580YQnqexgntoucF2Hftb7g
	 3Ebcd8kAblSXeQB3WC5qT/OCWfVXorBcDUizNNnRGE+mA4vTzYsNLDhqb6ggE3Y4aS
	 jk5AP/o30b57ud3c3yWppFxW7GkUIu0o6N81OVgHuZUBrpTTmRwqjmsG69JA3ZtNUw
	 8RkBuyzRFXZx6NRCqdQ5gslLcFCO8rnXqB+Bw1OK/rI/YA2TF4KmqaaRHZ6HEzvJvK
	 NIju6ddXrEUkxSWuV6mJr7zvq2KYNfPZVaUXtGxK2GinTR0k5HwDv3ZJ0EBC1Q1mkq
	 CVF/xxPxH2ijg==
Date: Fri, 28 Feb 2025 08:24:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v3 6/6] arm64: dts: cix: add initial CIX P1(SKY1) dts
 support
Message-ID: <20250228-rebel-honored-donkey-f30e1f@krzk-bin>
References: <20250227120619.1741431-1-peter.chen@cixtech.com>
 <20250227120619.1741431-7-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227120619.1741431-7-peter.chen@cixtech.com>

On Thu, Feb 27, 2025 at 08:06:19PM +0800, Peter Chen wrote:
> CIX SKY1 SoC is high performance Armv9 SoC designed by Cixtech,
> and Orion O6 is open source motherboard launched by Radxa.
> See below for detail:
> https://docs.radxa.com/en/orion/o6/getting-started/introduction
> 
> In this commit, it only adds limited components for running initramfs
> at Orion O6.
> 
> Acked-by: Fugang Duan <fugang.duan@cixtech.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> ---
> Changes for v3:
> - Fix two dts coding sytle issues 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


