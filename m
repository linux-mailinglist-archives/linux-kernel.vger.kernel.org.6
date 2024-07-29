Return-Path: <linux-kernel+bounces-266061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8615593FA3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF852832F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEA615531B;
	Mon, 29 Jul 2024 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt06v8is"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D663D64;
	Mon, 29 Jul 2024 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269095; cv=none; b=uI1m2RgZo6niKrkQxftpIX05ffeJwgnhrLasRHp6kz1alArGWy0LABzOSth9KQYAUCL8HyTBbgfCjGOz6g02+j2xArbEAAaqkrodWXf6pijC1yDSShKpnhSJdU1eeeOrKgjmtWls3LKNDjZvRJhJwkfaeQziAuwCI93RfqG3YLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269095; c=relaxed/simple;
	bh=sv2Hf4oIYSW1XdAkPXfHr+OK1HAvniKo45Lc28OavXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZaZZKkTjLf9NEh6lmk2H4N5wwOQt4Yn9mve/weI0xSqc9/Plsr2C1h901CEHopQFSfAqRrBMK5rd0lb+Rci+vRL6nfQcJjf+Tkp2M+YwsROZ2u4aH62SpPF6Yz7kUGmWHOvUm+/yo22FrL1YEPU4N1Na519I/mlcw2p6cydB34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt06v8is; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3BBC32786;
	Mon, 29 Jul 2024 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722269094;
	bh=sv2Hf4oIYSW1XdAkPXfHr+OK1HAvniKo45Lc28OavXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qt06v8isNeqE+yhoJ6leZxQkIHrMOCMzwZKDLvB8L/IG+4FQyISp+ZRKE2KUt530d
	 sIGPgTIn5SYPKCr6VY/zHOOG1VZu9YjXF5CAPqcfg4VOL+N70kENkLsBiatX+jmYl+
	 OQ3nAghpHYuXJwq3LfM0elRdtnmVD6pey+ucotBtcnuxn2YmSQ8ZXrL31OBX1ICPk6
	 6bDc0jAEEERf5iLIx0HMO5z6ZluEjT9R4l6VE4IB4wRUb9CumVZ34dlz0NlBsrTqMh
	 YxBVVlwW8BFcZJ8BRRhL/uymETznFvGEtI3+dVj3R9tGjg8SnVAyF9JSBezhl6FIiH
	 3oKnpiwIcpynQ==
Date: Mon, 29 Jul 2024 10:04:53 -0600
From: Rob Herring <robh@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2] dt-bindings: mfd: syscon: Add
 ti,j784s4-acspcie-proxy-ctrl compatible
Message-ID: <20240729160453.GA805559-robh@kernel.org>
References: <20240729064012.1915674-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729064012.1915674-1-s-vadapalli@ti.com>

On Mon, Jul 29, 2024 at 12:10:12PM +0530, Siddharth Vadapalli wrote:
> The ACSPCIE_PROXY_CTRL registers within the CTRL_MMR space of TI's J784S4
> SoC are used to drive the reference clock to the PCIe Endpoint device via
> the PAD IO Buffers. Add the compatible for allowing the PCIe driver to
> obtain the regmap for the ACSPCIE_CTRL register within the System
> Controller device-tree node in order to enable the PAD IO Buffers.
> 
> The Technical Reference Manual for J784S4 SoC with details of the
> ASCPCIE_CTRL registers is available at:
> https://www.ti.com/lit/zip/spruj52
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Hello,
> 
> This patch is based on linux-next tagged next-20240729.
> v1: https://lore.kernel.org/r/20240715120936.1150314-2-s-vadapalli@ti.com/
> Changes since v1:
> - Rebased patch on next-20240729.
> - Separated this patch from the series.
> - Collected Acked-by tag from:
>   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>   https://lore.kernel.org/r/04d94188-5e30-4cab-b534-e97c0b2a61f3@kernel.org/
> 
> NOTE: Though it was mentioned on 25th July 2024 that this patch was applied:
> https://lore.kernel.org/r/172190301400.925833.12525656543896105526.b4-ty@kernel.org/
> since I did not find the commit in the MFD tree and the Linux-Next tree,
> I am reposting this patch.

That's because it was in the middle of the merge window and only fixes 
get published during that time. That's now over, so it should get 
published soon. However, maintainers get busy on other work or take 
vacation, so it could be delayed.

Unless a maintainer updates their tree with other later patches and your 
patch is not there, no reason to worry and resend.

Rob

