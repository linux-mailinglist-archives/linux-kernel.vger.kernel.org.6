Return-Path: <linux-kernel+bounces-197190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A188D673A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1111C25C75
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B692172777;
	Fri, 31 May 2024 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eVhFnIzZ"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177A171E43
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174142; cv=none; b=pR9n2ILAoWwT58s1hRWLYA7EB8IyUpC8CrJWy6i8qsnOY09U8nb4npqsdcsL5xsTlhkijbahbcM7cUdzprzSNrDcGXzjp2XYrbl+ughlq/5sUH5sqeyPoQCEBowqFG8YCUBneRmlvuHSmvslGkHmgfyPDi+AFO6YEhRcXohDzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174142; c=relaxed/simple;
	bh=Nm2i92xCQ67hmust2UuNX1G5OUmaFGTIU0aMJ1K4VeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPhkOvP1BDWA4GyPsmCX2OFroUlUjBWP93slLYRClN0Z7HjIBOxbL/qv6seQLcjLAiAthqqM4eCV0RTNz5kjgyT51pdZ80GQBISbOOaBpGLihIBd3qdZ87/lYwPpANc2TXd9EEvnkflDhNG4i4zkujzAU2K9Rzoqhpw23scPo8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eVhFnIzZ; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 28E6CC0004;
	Fri, 31 May 2024 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717174132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/yv4AtesztMvKs3Dy53Bfb+WU3NfhkM1gOgzOFjdC8=;
	b=eVhFnIzZA5uZr4P0MdG5r9nKiFIhTwGlMX4q07Vog/BqFN091gujcv5FRN1W/k7IxXRrzD
	NWceODQ4gDJql5tUanC459FNm/4gtlkHnWc+GXt5SsQQSgrDcUob2AeTLH5w230x3S/Irg
	b004+S2UD5MCIjrvTOYxkYvRghqO2fjWPz8Dk7nUw+f4LwSWPniMu49ebqmf1CiOp9chrb
	wI1/NCdIsu2aQIXcar/+hgtFXzfVsVFg7erMmPsmiSsb2O5UecOw9K6Kbyep7xp9dq36+I
	X2N1wC0YOE1viVDBVRCZmZhNzdioQ7UC3t6izv8nfcx3e5TcGdgUv3vS4dcarQ==
Message-ID: <13f4bbb5-272c-4f3a-9c75-90a8b3898cad@bootlin.com>
Date: Fri, 31 May 2024 18:48:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Add suspend and resume support for
 phy-cadence-torrent and phy-j721e-wiz
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
 thomas.petazzoni@bootlin.com, u-kumar1@ti.com
References: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240412-j7200-phy-s2r-v1-0-f15815833974@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.richard@bootlin.com

On 4/16/24 14:52, Thomas Richard wrote:
> The patches of this series were originally in the series "Add suspend to
> ram support for PCIe on J7200" [1].
> They were moved in a separate series as requested by the PHY maintainer.
> This series adds suspend and resume support for the phy-cadence-torrent and
> phy-j721e-wiz drivers.
> 
> Compared to the PCIe series v4 [1], these PHY patches were rebased on Linux
> v6.9-rc1.
> The only change is for the patch "phy: cadence-torrent: extract calls to
> clk_get from cdns_torrent_clk". Now the cadence-torrent driver supports
> dual reference clock, so the patch was updated consequently.
> 
> [1] https://lore.kernel.org/all/20240102-j7200-pcie-s2r-v4-0-6f1f53390c85@bootlin.com/

Hello,

Gentle ping.
No merge conflict with 6.10-rc1.

Best Regards,

Thomas

-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


