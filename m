Return-Path: <linux-kernel+bounces-215989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CC9099A7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 20:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B131C21437
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF460DEA;
	Sat, 15 Jun 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5f/HCDh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B924437;
	Sat, 15 Jun 2024 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718477550; cv=none; b=OEk8rDEP4l91sZ6ZGusZwvqNtqjFEmFppSYN17ncxu8hYGpwNrbiMVN4VPFYXEFxdxXZoXQp1Ix4JIgqiCg2+JKE2yx39xsYXaPBzIvXLzqNf0kx7yLJA7w+yWrBCBpLNTsoII3b/g7xtGUXY9cAB7vFgvh0eLoV+6v+hbNF9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718477550; c=relaxed/simple;
	bh=Ah8NsRUCcVGsrSOWkwB5ILKjgnr51ZMV2LB5dcDSdOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SI9a+amCuAmsrggSN16PfgozbUng/X5QCd05Lsrd7egRujCzjXw5Vf86/1YqU6BRVGrTJZWdpflShPCyEMjCfFiyq0l2dsPMSeUN3ir7v+EhdQm3F1UNMFmxWviU6wHP6GTAAg9Oak0Tc4BhpKKiB/AeZZkqKDO0H59IjnjmhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5f/HCDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8F0C4AF62;
	Sat, 15 Jun 2024 18:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718477549;
	bh=Ah8NsRUCcVGsrSOWkwB5ILKjgnr51ZMV2LB5dcDSdOc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D5f/HCDhAPOkm50+MAqD0tuRJ6uuUM6DfL6k8fv5wCRfsMH1Twde0PxCTyWGR8X6I
	 yyo9gt8cEdDcRHnvjNjl5TXiQ9Z87as6mUCGUWw2GR6HTMZ1GmMAmRpql2RFAZSOkI
	 nCZM9mUvhEZ8M7+hTT60E5loymg7WCW3vm1hTQWNrZAdDRyh/+0uEDglzHfHWuJGIp
	 fxSsancCBHuYePADYlIN4DllSxlFdVJdIeKP2Hwokppzj+CPGPl373sAsz3vBI89+H
	 xQwBrUkbLSnB4QugBzQPKvLdQo4DXxuB1QKxGpCYKLZOsR9wRL/a8hX/gVilYMYIjn
	 DV78BklsBp9Bg==
From: Vinod Koul <vkoul@kernel.org>
To: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, 
 Shengyang Chen <shengyang.chen@starfivetech.com>
Cc: kishon@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 p.zabel@pengutronix.de, minda.chen@starfivetech.com, 
 changhuang.liang@starfivetech.com, rogerq@kernel.org, 
 geert+renesas@glider.be, keith.zhao@starfivetech.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
References: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
Subject: Re: [PATCH v5 0/2] Add JH7110 MIPI DPHY TX support
Message-Id: <171847754477.716119.1989436906241299329.b4-ty@kernel.org>
Date: Sun, 16 Jun 2024 00:22:24 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 18 Apr 2024 11:50:18 +0800, Shengyang Chen wrote:
> This patchset adds mipi dphy tx support for the StarFive JH7110 SoC.
> It is used to transfer DSI data. The series has been tested on
> the VisionFive 2 board.
> 
> 
> change since v4:
> - Rebased on tag v6.9-rc4.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: phy: Add starfive,jh7110-dphy-tx
      commit: e4a8e87250fc2c1ed2aec5d1e8521dc7d799ea77
[2/2] phy: starfive: Add mipi dphy tx support
      commit: d3ab7955330843699cdcc413edd7993923e6c016

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


