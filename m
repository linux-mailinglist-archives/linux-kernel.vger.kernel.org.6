Return-Path: <linux-kernel+bounces-304362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B55961EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC08C1F21971
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1551552FA;
	Wed, 28 Aug 2024 05:57:34 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB8154420;
	Wed, 28 Aug 2024 05:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724824654; cv=none; b=deubKZYbM5sMUn2+6oRNvhhuwk9o4GBs2k71cjgBM76EmVuW0VE78EFL3cdCfQySjpXl4cv3lK9A5SXlSgxvGS+Bd/T5E8CYXXhbqsDgfGx+dTONQqg/spfD5sN4oRFCELoP3cGeO7KxJxRmqvZ6mA1voe9abPDSzCt/zL3Kds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724824654; c=relaxed/simple;
	bh=TrDdfEPWF1+msD0Z6Whcuo36mLTRfza4O0jFzJpliMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYy4Po66ZPMIRNiBoi1Of96tuWNq2MJ+KlioPFJIL638AokhXMON+BxchjiBJxGxg0DDZDcgPyZW9A30by/Fhq8QpHYuizegQEFDiPF4wIKAsLPZUZ3sSsid7XgwZf7FeymWH8GdjG3EYRBjId19Dfci342gTfgXEKzxvbyZ6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D645AC4AF0F;
	Wed, 28 Aug 2024 05:57:32 +0000 (UTC)
Date: Wed, 28 Aug 2024 07:57:30 +0200
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Aurelien Jarno <aurelien@aurel32.net>, Dongjin Kim <tobetter@gmail.com>, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: rockchip: Correct vendor for
 Hardkernel ODROID-M1
Message-ID: <eaqsbzsfvfn2cufeax6x2jdwfhejwz2pxxhbcgbt5s3kryy5gg@hi7b74trm5hx>
References: <20240827211825.1419820-1-jonas@kwiboo.se>
 <20240827211825.1419820-2-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827211825.1419820-2-jonas@kwiboo.se>

On Tue, Aug 27, 2024 at 09:18:15PM +0000, Jonas Karlman wrote:
> The vendor prefix for Hardkernel ODROID-M1 is incorrectly listed as
> rockchip. Use the proper hardkernel vendor prefix for this board, while
> at it also drop the redundant soc prefix.
> 
> Fixes: 19cc53eb2ce6 ("dt-bindings: rockchip: Add Hardkernel ODROID-M1 board")
> Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Would be nice to hear there are no users instead of relying on me to
check it.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


