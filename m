Return-Path: <linux-kernel+bounces-514563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A54A35891
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A167A7A3AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4D3221D99;
	Fri, 14 Feb 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjDJMVPm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C173221D87;
	Fri, 14 Feb 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739520742; cv=none; b=MutvfNZ7mNC0Bv6HNX5RRM61npmmF15lOnHYK/slDzerYxXNtydlrhxnlvm0jcJ5WFFoq0W+nCeSMK6HLRa4+s4xyX4Hfzi+/Vl4BMBdYIkG+vVoTnfUK6NygmGAwnsDQ12pQ/eTOt9+B/Rnx80hwvG+DT0DsaQA/IdwdyFY5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739520742; c=relaxed/simple;
	bh=BFuIYIhdWv+oib3oeVpmwSBMF68TB7x1nKJsh5h41no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl76oCDSYtvXMpTj84bK/2FoBSw4wuFpPYdKtkr1q4SaprJxKxkNlmA9ZO/gSALdomXQ8sKfH0KtFysfOz4CmvxyYS0iO2J/Ge+K+vMfc96Ko15cMLxLysy7/Ojdvc6qY1UmbTGwfKJdAs9h9lJfVw4iK6r+eng93uqo96KVKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sjDJMVPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35855C4CED1;
	Fri, 14 Feb 2025 08:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739520741;
	bh=BFuIYIhdWv+oib3oeVpmwSBMF68TB7x1nKJsh5h41no=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sjDJMVPmIFSSXfqhSnAU05CyQWeBQxeb5+aTPVpgC44aqfr5Pb7FkkpLaHIAYegiI
	 WRYXuOYPJZR2a1m0fF1ebE1VHjsaEy53j802tlxPYc/8i3IuQVkdwS95/0pwr7Eujj
	 OLe5VQkt+22ytXrR9KTAyv61Mcv+QXsFFy2d2vFq8lvcrgheHyybmJZ6fl35B4mPz+
	 KOgZGxbx4wVU/KYEhBFrH7u+mXw0K6Y1M7+BNuCPaQPnSxwm/zeseTnFAJ/GABid5n
	 VgkD7qPKhRm9agLM1Ns9ZGFgYyOn6O0BOSH/+JG2oYAZqKCeGc0Y/MlqPX5BQDUb88
	 nlYzu/y1zCwKQ==
Date: Fri, 14 Feb 2025 09:12:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 3/8] dt-bindings: arm: Add Rainier compatibility
Message-ID: <20250214-dynamic-gainful-monkey-fbc0fd@krzk-bin>
References: <20250213180309.485528-1-vincenzo.frascino@arm.com>
 <20250213180309.485528-4-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213180309.485528-4-vincenzo.frascino@arm.com>

On Thu, Feb 13, 2025 at 06:03:04PM +0000, Vincenzo Frascino wrote:
> The Arm Morello System Development Platform uses Rainier CPUs.
> 
> Add compatibility to Rainier.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


