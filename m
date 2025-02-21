Return-Path: <linux-kernel+bounces-526589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7E4A400AC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B801A7A3AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593F325333B;
	Fri, 21 Feb 2025 20:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9MXwa7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4942AE74;
	Fri, 21 Feb 2025 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169245; cv=none; b=urbciqL5iTBK8YxVSL4RfSyvBIyC76uIjmDqi5EdiYFO/74eR9oNs2ntOTZ+zwj3P/JszeYAn0NbtKrKsByNFNgcOc0GpZloKBf7/sgh3rfBmoYaxke4/0jz3hTiCQlsobTbvuVDqX1h+tdHEQBjiCD1S4DVXiEepYNvuy/OUZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169245; c=relaxed/simple;
	bh=fbOHtpk/uuqRCAGB9uJvFdOTgJYlTLoDQqtrDMq4XCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai2nierI5/5wWGsjVglRfGVtAPnRsYAEo81USapROtSjSVhe+gBo38XSaarYy7meIxsIutQNCdXGwBo7WeVdvISHsZbLal2BD+LpGwUd7g6WgUoh7p1PrbIuoLQNaNI8y642r/zJCTs7aMY9eAubSKf3XgHDXtVPELm1fhxQhAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9MXwa7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E356FC4CED6;
	Fri, 21 Feb 2025 20:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740169244;
	bh=fbOHtpk/uuqRCAGB9uJvFdOTgJYlTLoDQqtrDMq4XCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9MXwa7W8szpEUwdQhiiM0lIWCWNI9Qj7X9AHVg2FZEBzWUBMlV7McEtV4u91ZW5h
	 5wQiFJwjWxNBFbFdEqD7iJCmUNXSx9rPdUTPDBFLAOUaaT1jTF/bLXzObgbiy1K4yg
	 uxNAr8VCdoz6qC5eUiTGjPrzvXGm5PIVgbXZgBAp8e+Akw16vOM7gAlkIPSBbGQHzv
	 P3AQbOM3DuimqIZHnkEhV7bly2Mjqk0VM5hhuxJKrxp7+X3VbHbdidW9M6tJ5nmcJb
	 lX4rNuLifzAI4eAEarEZfuKKxDN/f7c1hf7wM4PqvMArsl7KY5hSipYOTrZBH/1XCV
	 Jm8PQdekvu1aA==
Date: Fri, 21 Feb 2025 14:20:41 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	Michael Turquette <mturquette@baylibre.com>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Stanislav Jakubek <stano.jakubek@gmail.com>,
	Scott Branden <sbranden@broadcom.com>,
	Alex Elder <elder@kernel.org>, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>
Subject: Re: [PATCH RFC 1/5] dt-bindings: clock: brcm,kona-ccu: Add BCM21664
 bus clocks
Message-ID: <174016924068.13604.5835442277763303023.robh@kernel.org>
References: <20250216-kona-bus-clock-v1-0-e8779d77a6f2@gmail.com>
 <20250216-kona-bus-clock-v1-1-e8779d77a6f2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250216-kona-bus-clock-v1-1-e8779d77a6f2@gmail.com>


On Sun, 16 Feb 2025 17:12:36 +0100, Artur Weber wrote:
> Add bus clocks for hub_timer, sdio, bsc, uart and usb_otg_ahb to the
> allowed clock output names for BCM21664 CCUs.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
>  .../devicetree/bindings/clock/brcm,kona-ccu.yaml       | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


