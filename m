Return-Path: <linux-kernel+bounces-178751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A0D8C5728
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE0D1F2247D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C314F120;
	Tue, 14 May 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AIz0sgAD"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A56414A601
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715693082; cv=none; b=hklnWv5+/Q6g+Qrhd/5bZzO8FbHtnF3LXRmGc25zjfvcYzFf1esbbti4mZBp/DLNy+GYKL1ciTZVjCXMM9idSIPqGWRJtBT+Lv+fe/ysv1KqNFnhxNKrmXXKyuK/pCpOSzNogUaDdBmKCg8/Bq/Vbc5PYtggDrUqyLzbMB/yNZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715693082; c=relaxed/simple;
	bh=UPnxxmgq098D2bvfn/9U61yvl7r9k7+veKByO8yxv7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWTrPrLcgaOcywCwjA6A2CheO/42SmAILPThdRE9UTPSBV1ECIXujvUe9ZDx4CMgD7qA6DyrAi7GP8bDxA7ufcNvuDBQQG7SqdYjnfIPjavHNHh3mO1IOBxeZLOfSYg6im/oShAmJN9BB2rZ3liIifGaDsWKc14b+uTEzOfYClg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AIz0sgAD; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1598B20008;
	Tue, 14 May 2024 13:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715693078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPmbOf+cV2TY5fzoxjAfYPDEJeui1lKONXKpY2Rs3z8=;
	b=AIz0sgADrQdNgNKuBuINGz6x07fq3e6RrHdrg/Vt8Zk+RBbubwBBGED2oGTOZvVdW3XYpm
	PjLPF4DOvISXC4PZHARVdNlOnPDFYsfbp9ulb66oepBs450rK63lqlv8sdtDJM2fyhHoA5
	aWKv3pL+58XSYaDOYiZ+VnmlVn4bOhAhzpVI9iHDe/gSrzSBkKG03TwB2tanPYClHdc8Ml
	q32GWDxLVGpxyv3MLjUk0DxluXdCpX9d0YBZ7qrdroFtJOF1FCPzokjGtb/qS+PpMV+uu7
	zEywU+9RyFgDmt5XhQi6xLy/RTskQAb9d1EIe8faA4TnU+f+M/M4WnlwKZYfUQ==
Message-ID: <2f39a26c-fd93-460c-876d-f1103b275b85@bootlin.com>
Date: Tue, 14 May 2024 15:24:37 +0200
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
Do you have any comments for this series ?

Best Regards,

Thomas

-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


