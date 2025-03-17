Return-Path: <linux-kernel+bounces-563334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7079A63E74
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B56E16BD80
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1B3214A96;
	Mon, 17 Mar 2025 04:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FAcc/tdm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E0207E14
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186353; cv=none; b=SJQF34xOoipI1oD5lI/hXknBJaewhzz+Bl0EzHJEw3OKdOtTY6JEMdSghhcKtV7ZVSYlEzKgfyZmSZGz3UHXKPZiG9wkuUi+rh338Y9e1Rl6GL5LjTjgyvwUR5lZvETjTpRkeIkWn00QuKIe5eL2jFWv1enohIF11W9gXZl9jjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186353; c=relaxed/simple;
	bh=X/hB3dDHXbcrNbtaYJScnpxWS2rNl5slU9SI8lD+zEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIF8rUbgbAJDHP+n8dn7PKflcDOIKtzWIZ612u2qXHWEbf2RNzp6pWDoGTQogFRdA/r5I+kfW2VlI2dw3pwbHsdikveCyW1NU/sci6F4mImwCbPAFFB6P5dEtHHddGu4Jxnh+irwz7anjnKlQdHyjZ4EkgjnTxdFBR1AgCWJeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FAcc/tdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7757C4CEEC;
	Mon, 17 Mar 2025 04:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742186353;
	bh=X/hB3dDHXbcrNbtaYJScnpxWS2rNl5slU9SI8lD+zEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FAcc/tdm0aoOdSP+6prD25kdhc5Nqrl5Ybym4JRNBPgbKFiFxaj5WwlXrb11gU9L3
	 RR7hNupvfqPCIcIOrIXue8rrSJ+SBKvImVOJ1ZnuVesxQSYu2E6IqoiyVvvirxwOPQ
	 PykqdseZr4WMJAaN1owZpuIXYW3ZALvXWxHoMFtU=
Date: Mon, 17 Mar 2025 05:37:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL] w1: drivers for v6.15
Message-ID: <2025031742-gonad-progeny-6d59@gregkh>
References: <20250316145719.19935-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316145719.19935-1-krzysztof.kozlowski@linaro.org>

On Sun, Mar 16, 2025 at 03:57:18PM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.15

Pulled and pushed out, thanks.

greg k-h

