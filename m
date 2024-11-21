Return-Path: <linux-kernel+bounces-417004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB109D4D7E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70119283BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185891D86EC;
	Thu, 21 Nov 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tawtPhkv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC11B0F0C;
	Thu, 21 Nov 2024 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194635; cv=none; b=PX508F+/zRYbafGn7JD/1DTInpKGVZse7QuydI5rzLrNfk2B9Mkf6Ga8Mq40cDaX8ptIgTwz8j82JTJ4GCHiEq1AHZ9O4I33WTfq4kN3hIGPYo7T4pJFMz7Q9FqK5GEG7qdxa50c8ZRYeUumUJ2Y5gg3jqPBs9xGwbb6VMYn0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194635; c=relaxed/simple;
	bh=Q7e/7v/wkwzf+9WRZWI76lfTqRghf/xxHp0zdkSzu+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XI0oecw3erl2OyolY62F1AJg3dw1VXTWVfxNZzGRVr393sjX6xaVDChDPblQyfjjcFkUnu5M/sqneVeaokQGHROE4xQTZykW55OngSri5uCu0xeH1WJ4WGCCQTp6wlvkGXXhPcvcNEA+0+1sXql2aSKTBPoeQVPUs/AFTqArn8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tawtPhkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6858EC4CECC;
	Thu, 21 Nov 2024 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732194635;
	bh=Q7e/7v/wkwzf+9WRZWI76lfTqRghf/xxHp0zdkSzu+U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tawtPhkvVrm2LcvaCKjV6g8MeO3JOG8jZncu/ZDZzulDw2HSdMKZKba1yGDemoVGW
	 yy7dPrP1XkRDf8bQeeL2H+6WF2GuVm5fIeP+Sozos2GuqCmQwWElP/Lrju6B7VzNRR
	 Wa1SyJs4R+2xqYpRp1vnPVK6W9SK1MAqTtG9Z0gfjLC47waW+H1bYFeJLipl6c2rF+
	 KwiJpurVykxwY+teUkL7EwnD8Nzx9WOrt4q1X7DZVmYqn7Bc9QuoSsmOqPiqEFP13D
	 FB35V1EzOVOj0hSQ4m3kDYl44vKVzJzzqOTMzgmyv/TzpOF+ofy/EQ8e4uPB8mdfzh
	 J9y0cBm244jkw==
Message-ID: <1c755fb4-964a-4c7b-819f-f5cf54baddfb@kernel.org>
Date: Thu, 21 Nov 2024 15:10:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
To: MD Danish Anwar <danishanwar@ti.com>, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, ssantosh@kernel.org, nm@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, srk@ti.com
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-2-danishanwar@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241113110955.3876045-2-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/11/2024 13:09, MD Danish Anwar wrote:
> The ICSSG module has 7 clocks for each instance.
> 
> These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
> ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
> These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.
> 
> Add these clocks to the dt binding of ICSSG.
> 
> Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


