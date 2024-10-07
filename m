Return-Path: <linux-kernel+bounces-353740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9D79931FA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B90A1F24AB9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4A1D6DBE;
	Mon,  7 Oct 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx525gKB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983A1DAC92
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316138; cv=none; b=DKN+N+QZd3hQ3WNv8hshpfDeE1R/M/eoPyrtpFxug3To2RW/f2QZm6F3uKweItvMusSawh8L/hgsM76wcdtCIjrMD43wE5pstS79GFRYNeBF19Pl7eywsq1gIDUBNb9B9k0iXo/iHwIva2A5aHU4CmHZMWqkYT1wsr1mhJdZdS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316138; c=relaxed/simple;
	bh=AmnZGoC6d9JOz7Nbe+RZvuUjltSac8yKHkvPAr+paMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PVk6JSc7m3pP9k4yBM4HKZ0RRzgMRhMsox5hw8qj4YIpOtaA66oVgpT8K3sd6Wa+PZHhIzrw+bKoU1tDNRDtzVeoUNcHxvLic6WKqWDrI2TOhTQPNtKc2c0AYq2efz+vNs1LpGzfLyzpgNfYfPTFVPYQ/jpoYqBugNJi11Kz/Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx525gKB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806ABC4CECF;
	Mon,  7 Oct 2024 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316138;
	bh=AmnZGoC6d9JOz7Nbe+RZvuUjltSac8yKHkvPAr+paMM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dx525gKB/36rAxVVOUKDXn7PHyEgnKQMOOUP6Yqc965PrhHfL+nzYX8n8c7V/7/14
	 qPphRKBLhYt0feXqHz1SinDI0oGjZy/A+ua6oGpNIfOhKwlTDb/zn3/JsbD4M6GYC0
	 wk/vnweQW8aiq0IRs1qYlnRK17h3mYlJbocXiqp78xpuPxDxHWSY1S8pU10kVOrIlY
	 GFW5+RXGiOORnfsnRsfM+KSulrqzgl5DZKpkwNGmMp+TN9+TJMM7iJHczYyizPurSQ
	 2Adsy2R5+HSQf5YHmWp26fASq9gOf7yCw7jvXUfwsQdzhHb2q9/Am0yosLSCcDWc+o
	 B0ZVzSph/zW1g==
From: Vinod Koul <vkoul@kernel.org>
To: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org, 
 Dragan Simic <dsimic@manjaro.org>
Cc: kishon@kernel.org, heiko@sntech.de, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1725524802.git.dsimic@manjaro.org>
References: <cover.1725524802.git.dsimic@manjaro.org>
Subject: Re: [PATCH v3 0/3] Improve error handling in Rockchip Inno USB 2.0
 PHY driver
Message-Id: <172831613615.134526.763385674253589863.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 21:18:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 05 Sep 2024 10:28:21 +0200, Dragan Simic wrote:
> This is a small series that improves error handling in the probe path
> of the Rockchip Innosilicon USB 2.0 PHY driver, by returning the actual
> error code in one place and by using dev_err_probe() properly in multiple
> places.  It also performs a bunch of small, rather trivial code cleanups,
> to make the code neater and a bit easier to read.
> 
> Changes in v3:
>   - Collected Reviewed-by tags from Heiko for patches 1/3 and 2/3
>   - Brought back one empty line as a separator of dissimilar operations
>     in patch 1/3, as suggested by Heiko [2]
>   - Dropped one backward conversion of dev_err_probe() to dev_err() in
>     patch 3/3, as suggested by Heiko, [3] and adjusted the summary and
>     description of patch 3/3 accordingly
> 
> [...]

Applied, thanks!

[1/3] phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
      commit: 449d2a523a0c3ca8f4c993b8e37795c2aa174da6
[2/3] phy: phy-rockchip-inno-usb2: Handle failed extcon allocation better
      commit: 595ad7a336bf21f9d111a033820cd95d70343bd1
[3/3] phy: phy-rockchip-inno-usb2: Use dev_err_probe() in the probe path
      commit: 40452520850683f6771094ca218ff206d1fcb022

Best regards,
-- 
~Vinod



