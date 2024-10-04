Return-Path: <linux-kernel+bounces-349930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4125398FD7B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 08:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08B1F28102F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 06:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADB282499;
	Fri,  4 Oct 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DiKthRHU"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F341D5AA7
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 06:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728024392; cv=none; b=hHTCWEdtHwX+/7uiqneXLjPSfAJXn1iesc/XG8um+tuRHCbO/ZLbfRcT61yBAKAd9cdjBKkJgyB/faZOhwAMPG16tvQBrBtrb7I+o5EsjLMDTE5883SHHUiedAuRYAyYCV+lVfT5JUYeP8FL9flIu/iEsrwhRKI1TF50NzyN+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728024392; c=relaxed/simple;
	bh=hG8JH9QC7IUabcnlZPtpcrZLfaI9QVGNzqfHD0bUMLk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Pk5JnqFm7xBf+XEvP0q4Rm4QY5eKriBtHLavZtoqWmG1QbwCi4Rfdgyb9nLA7a21xe2JMwRucwrEhknNz9+G8lp1+8K92xq2Wuy3/uablJhzmqt7CHWtDbFoxL+jXWH2+TGhgkjqt7srXktDNDePcHtJvD9wkhrniSj25pMcDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DiKthRHU; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728024380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sSHMcRc/7oJcjlVYuOOAXPpQW88U0Cjkb5Oc0Zij2G0=;
	b=DiKthRHUZMmjw2bDMF2Obg/a47KqCGb17kjC5LcHKDr+8PDDrZKiSwKhvXzH1GGmeARFTl
	1BbdW6LTiyr9HsZJ9/XwsVvd68HCHyIi/9sdAovCpo6w1R/NUc2btpV4hC6vQo6RYY7PUh
	PHTWqN9aLcVWYqvP3rjMtEtc9mJGXB5L8vxdziiBRAwDcjyS5FwvaIOGTrNAZaYylkXicI
	ZWpqtg0nBpU+c6BUKE8RZyrK0B6jMqqO3qJd2uq9row26EEiq+agpp0EJKFOpSLLOeMkqw
	fP0vFCdbWM0IV68H9aw8Hw2j+N0gwBIzKkU5xTUkktwhTjYN/iTKA2tl8p7WsA==
Date: Fri, 04 Oct 2024 08:46:19 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org
Cc: vkoul@kernel.org, kishon@kernel.org, heiko@sntech.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Improve error handling in Rockchip Inno USB 2.0
 PHY driver
In-Reply-To: <cover.1725524802.git.dsimic@manjaro.org>
References: <cover.1725524802.git.dsimic@manjaro.org>
Message-ID: <71569a2773d88d13ca1cf4aa41b56496@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-09-05 10:28, Dragan Simic wrote:
> This is a small series that improves error handling in the probe path
> of the Rockchip Innosilicon USB 2.0 PHY driver, by returning the actual
> error code in one place and by using dev_err_probe() properly in 
> multiple
> places.  It also performs a bunch of small, rather trivial code 
> cleanups,
> to make the code neater and a bit easier to read.

Just a brief reminder about this patch series...  Please let me know
if something more is needed for these patches to be merged.

> Changes in v3:
>   - Collected Reviewed-by tags from Heiko for patches 1/3 and 2/3
>   - Brought back one empty line as a separator of dissimilar operations
>     in patch 1/3, as suggested by Heiko [2]
>   - Dropped one backward conversion of dev_err_probe() to dev_err() in
>     patch 3/3, as suggested by Heiko, [3] and adjusted the summary and
>     description of patch 3/3 accordingly
> 
> Changes in v2:
>   - Expanded into a small series, after a suggestion from Heiko [1] to
>     use dev_err_probe(), because it all happens in the probe path
> 
> Link to v2:
> https://lore.kernel.org/linux-phy/cover.1724225528.git.dsimic@manjaro.org/T/#u
> Link to v1:
> https://lore.kernel.org/linux-phy/5fa7796d71e2f46344e972bc98a54539f55b6109.1723551599.git.dsimic@manjaro.org/T/#u
> 
> [1] https://lore.kernel.org/linux-phy/4927264.xgNZFEDtJV@diego/
> [2] https://lore.kernel.org/linux-phy/5307900.6fTUFtlzNn@diego/
> [3] https://lore.kernel.org/linux-phy/6073817.31tnzDBltd@diego/
> 
> Dragan Simic (3):
>   phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
>   phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
>   phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path
> 
>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 56 +++++++------------
>  1 file changed, 21 insertions(+), 35 deletions(-)

