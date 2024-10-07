Return-Path: <linux-kernel+bounces-353743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D268993200
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2629D283609
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3131DB548;
	Mon,  7 Oct 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj5L/uuv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB71DA2F6;
	Mon,  7 Oct 2024 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728316148; cv=none; b=U+6YurUpbSwk6eul3CHNmp1s6mnQKwnaagCH6aKHdQvbLl+rX/8mLJpSLOxAWGapZqCUmvIElQVF3d/WJCSfZ27hhwkaqkHsmgOtiUOjD5KnRYmvY+B2mpC9uw9dKQbD7A4Jk0+pr8MKeVKPNObQjvQbqGZLWBRc/P4gXh/GKEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728316148; c=relaxed/simple;
	bh=S3COoiZdIFf6D1j3gJ1awjWFFgi6Ggt/jCMljKFYw7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dzVaoD82ixiMgvzdkDH0dUqVJ2NP5p3TuHanAEd5ASpJGy0TTBW8iPcrj8UCNjI6RaCZhGs3/YUm2B5Vb5Ez7svd5w9K5jep4IpJsvOQlfkIUIv058K8Euy8NtwRRt+7LJt3WeNXdQ1GmElQkxMye77m7p9H642Z2kjIkr1uUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj5L/uuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5A1C4CEC6;
	Mon,  7 Oct 2024 15:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728316148;
	bh=S3COoiZdIFf6D1j3gJ1awjWFFgi6Ggt/jCMljKFYw7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qj5L/uuv3ULO/yuK/wZwH96zW+kuYsPsSlE2Y6I14/VBBpGnmNuIK7EYQIYiN3729
	 tCFAPhyAU+F/mFguZO/OqX5ywRHu6TKrJ+r3MAhluXSmdR2b+W7ufcZ1LHgIV5jTi7
	 anmS0YfWvg7YzipzbwN9uW1YQOw12HIbr4vx/cICJDq3aizL9MEeb10B2mXnuRVZ6l
	 3a5P/qs60kHgwuEj0xDllF3PB3HqgGO0+l4Qs4t/94yWQRP8tKqZ47CUqrA17IcR7d
	 YRAZOVhEsLhtTCs7B4V29TcslDKQKvNJyInpBZ5QBe9SadJRk+6nCcFO+mWX7Ws1nS
	 9GsU0C4BkRbbQ==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, sjakhade@cadence.com, yamonkar@cadence.com, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 conor.dooley@microchip.com, nm@ti.com, srk@ti.com
In-Reply-To: <20240930095145.3004053-1-s-vadapalli@ti.com>
References: <20240930095145.3004053-1-s-vadapalli@ti.com>
Subject: Re: [PATCH v2] dt-bindings: phy: cadence-sierra: Allow PHY types
 QSGMII and SGMII
Message-Id: <172831614467.134526.16993157211985653714.b4-ty@kernel.org>
Date: Mon, 07 Oct 2024 21:19:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 30 Sep 2024 15:21:45 +0530, Siddharth Vadapalli wrote:
> The Sierra SERDES can be configured for QSGMII and SGMII protocols. Hence,
> update the bindings to treat "PHY_TYPE_QSGMII" and "PHY_TYPE_SGMII" as
> valid values for the "cdns,phy-type" property.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: cadence-sierra: Allow PHY types QSGMII and SGMII
      commit: bbcc9e2bde693ec3fc6aab650abaf748eb9f38f9

Best regards,
-- 
~Vinod



