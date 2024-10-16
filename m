Return-Path: <linux-kernel+bounces-368740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BAD9A1453
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99D21C218A0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 20:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632ED219CB0;
	Wed, 16 Oct 2024 20:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RC9J/JVb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD68D219C98
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111368; cv=none; b=ZB8vi/F86fSi1SfwWR9ZHg0xCfyU1Bjnu0om+2vgaZyUEC8vrkVD6QAhzCO0QRhliaFMvkAMECWClgOEkzq09WBpRHS77Rha1OWU8k3cUZf8eG5ra8mbczbNU2y0T5mcGoEXDRohG77DUUwl+GaGsSHd2ZSbtMYLmh+T8VL4WRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111368; c=relaxed/simple;
	bh=wYoqaLyf2yFxuf8G4HAc0JLSb+7+gi7D7JkVfCno62o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DO7QkLbe81tSPXZN22Mr9puPo8hhQrmpObxWTOlP6rsnwkkcAWDDW00wR2rne6fyKk0Xbw82CF+GEYgs0t+c6GtjO6JLj8zfDComl5vog/YZpajlGGtMM1+iYqdbTwriCA9doH2d+65aSf3DEtwIK2tWfKtMkzoly+VYRwR+a8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RC9J/JVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FBBC4CECF;
	Wed, 16 Oct 2024 20:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111368;
	bh=wYoqaLyf2yFxuf8G4HAc0JLSb+7+gi7D7JkVfCno62o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RC9J/JVbMwJL1BNvgkvO2eBDGSEyWLAk/mwoUYZdj3KyoYjtjnKW/MlZ3Y/ip/Rzs
	 BRPOleFFBGCjK/YCQoa+KTqOzAsWLhufgZnvLHUzcC9yZoHmdwIK4m8m/QpCryqGhH
	 B6WMDCQu09joPia9gng2tLxIsfElylDKlvl0OnKpiMp5NhjEFr2ytT+e+dz04ovoRL
	 W8e6XDpwmOIJXdf3Nsc4/yM0+Tw/O/fpvSowdTmxuEI8BFmiF92RQCcyhqO0rwg6Ch
	 zmg6sT3Xl6OWbZdtKTeJy06/vGDPzNgGzc6FMyJkSv31OngHgiGYvLw8cGU7mDkdc6
	 I8Fh4AvuSPrOw==
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable sc7280 clock controllers
Date: Wed, 16 Oct 2024 15:42:32 -0500
Message-ID: <172911112244.3304.14052270850094793900.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240913-qcm6490-clock-configs-v1-1-1586c72ee641@quicinc.com>
References: <20240913-qcm6490-clock-configs-v1-1-1586c72ee641@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 13 Sep 2024 23:32:41 +0530, Taniya Das wrote:
> Enable the SC7280 video, camera and audio clock controllers to enable
> the video, camera and audio functionalities on Qualcomm RB3gen2.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable sc7280 clock controllers
      commit: 9c957ebbcdd131a890cf163875d4493414f84eca

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

