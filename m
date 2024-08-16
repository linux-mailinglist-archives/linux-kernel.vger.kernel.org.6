Return-Path: <linux-kernel+bounces-289997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246B3954E44
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD03F288E92
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20A91BF309;
	Fri, 16 Aug 2024 15:53:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0821BD515;
	Fri, 16 Aug 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723823634; cv=none; b=axlJMsk5mXr04JfqJwDQjtm0TqJkgMdNDDjnIq9amDnL3suexc/ad7ubFlm0rnvDLoGGnE/10ZrJ9S9lj24DCnGrkrTxi7HYcoeIAk2xoM9Z9USyzLWB9Aev2+xxLuZmx9j4H4KqVPUes6tPkbfyIssLsXaCexvNA1YVHMEjVEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723823634; c=relaxed/simple;
	bh=hAdc/t7s0vMmTi+Fau5ORL2MY0EIZFBqwo9bYh+1SL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9sq36t5MLgsqnItS+yytGyKI9OVzZKKdO82oDDeFwlnRxEaqd9lVMDBnaL0bb7AuYpoT/rc8Mq7fG45SipUdx7gDcc3yBt6I1mAsyvBgNYqOcETHTrBq85w3XAvCQeRI6kVqq0qKhiEOglPygDkxVmHJCu3ttlGdMQuazDclLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353FF13D5;
	Fri, 16 Aug 2024 08:54:18 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBC043F58B;
	Fri, 16 Aug 2024 08:53:50 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:53:41 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Simplify with scoped for each OF
 child loop
Message-ID: <Zr92BSv7qmm5pKcI@pluto>
References: <20240816151407.155034-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816151407.155034-1-krzysztof.kozlowski@linaro.org>

On Fri, Aug 16, 2024 at 05:14:07PM +0200, Krzysztof Kozlowski wrote:
> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 

LGTM.
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

