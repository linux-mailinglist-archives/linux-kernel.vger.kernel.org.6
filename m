Return-Path: <linux-kernel+bounces-553749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED392A58E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959AC3AD836
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FB8224227;
	Mon, 10 Mar 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVlHawv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EE622258E;
	Mon, 10 Mar 2025 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596120; cv=none; b=cMuQ1TbSVaJ56kWXWO5bv+IIuhQSEKz6mtMrCi3KZw33vUJUktV1mIbwKRrXziFgcpBJ68b/Tqz2b1g7xH3/0bhwU/BWiasU1ltQsCE56AKkMXDvBBQAve2omiCsulQn5J68vK9iTeVrcSyD1b0vEJ8SiArPEanoRWZLCNKvDaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596120; c=relaxed/simple;
	bh=y3S6SNX1bIkkcqETVLF4H6S4GWT5MMs5/amGx8MbgMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx8Bdvm2kUv8r09zaVeuJp+aTMm/rWzkk/Ju0Zrz+ay59256NDa5CfkUJiATkqwHSIPA4vH/ybVwz8i6HuRl6ENLSC5vl2Y5wj+P3ZQ3U6A7CyCPMMkJOjwu317VAhgm7pL5ZiECNY0g1xv1jYyjuLJcDgqZh5PMtnqqigX4DnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVlHawv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB76C4CEE5;
	Mon, 10 Mar 2025 08:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741596119;
	bh=y3S6SNX1bIkkcqETVLF4H6S4GWT5MMs5/amGx8MbgMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVlHawv4//2JgGbt5yJn0BMe1syAYveqAp4r2LP9YjB+JpalFAK3SUgvsk/wWFfgK
	 DJJRFNuuPP/AuFrv1J1gQQe124zvu69UmXsXd2nNwuov5zKNrjNvzN9dNk1u128Nuz
	 NmAIHEX9/nUyykC71rWPErbsk2e7xlS/sfhAQ8SjI5rZ4lEFcOVgUpw4Zz1I8lRAKj
	 +z064ri/lWdXFIyTrLWEuuyOg4yIvbCCz5vcL5ULT9HLaQNlNWi/ENLHwoSoMqzCBA
	 1Y975omzCZ4DZCHcDr/W26GgmpQzh48txs2Q9nov1adbQsY02SWfVNH4TA6BhBoi8M
	 JB/mYmWRxZYFA==
Date: Mon, 10 Mar 2025 09:41:56 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alex Elder <elder@kernel.org>, Stanislav Jakubek <stano.jakubek@gmail.com>, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 3/9] dt-bindings: clock: brcm,kona-ccu: Add BCM21664
 bus clocks
Message-ID: <20250310-wonderful-nimble-axolotl-6fefdb@krzk-bin>
References: <20250308-kona-bus-clock-v3-0-d6fb5bfc3b67@gmail.com>
 <20250308-kona-bus-clock-v3-3-d6fb5bfc3b67@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250308-kona-bus-clock-v3-3-d6fb5bfc3b67@gmail.com>

On Sat, Mar 08, 2025 at 08:50:41AM +0100, Artur Weber wrote:
> Add bus clocks for hub_timer, sdio, bsc, uart and usb_otg_ahb to the
> allowed clock output names for BCM21664 CCUs and add the relevant
> clock IDs to the clock/bcm21664.h dt-bindings header.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


