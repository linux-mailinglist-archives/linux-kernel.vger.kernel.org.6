Return-Path: <linux-kernel+bounces-273961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10FE947029
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9992803FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC46D13A265;
	Sun,  4 Aug 2024 17:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXT2oydY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C6139D13
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793908; cv=none; b=TAD2D5voFZnmKHtDPkD2uDQGOYMs2cG3M9FKy7r1pp3DBw3lOssBbdsaH8zQ3SjNqWB6WgnFKhMtG/jpqFWe2H6Vm3hRHqZv5LBzZpyX3tyliGJMGHEySq7JNv8BPwPmcu73edBMM9s8TiY51NPVxrWWR4Nk8azli81CBdf2VWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793908; c=relaxed/simple;
	bh=VedGGHkCfVOcHhXI8Ri7pGj1eHQ0z/dLrioP/zCd6AM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=abUA+y1ez6zY25IZgM0iqmUcOnZIm3gLs0TbNJOOBTx/ENLHhHmVyyWfG6K79RvFjZHgi4/B/O2j6w/DLRlwihKDH1RMNHmnvpmQE7MWCdRyTv+RPcS+CSy6xIqgo5U8LisO8zmvvepJbVTEH3wyvjyr8XSIDj7GhsCGd6Axea0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXT2oydY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3414CC4AF0B;
	Sun,  4 Aug 2024 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722793907;
	bh=VedGGHkCfVOcHhXI8Ri7pGj1eHQ0z/dLrioP/zCd6AM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VXT2oydY5hHVbDoqUqN0AxxVCRva+16Us6M/FGWKLsSBSpw+X/u3oK/46j0Li4yRL
	 WftKYXI5CSQo9BHGkRd59oxa/TY16lRmuFtkNaqJwSFSxSh7MBUea9/erSWOW+zhzr
	 wBa3n54Q0vneLki+qXwv1OHYM5PrdWF46WgxYZTTEQD9WH3rDoevUaqa5PpbKnR8ZP
	 Irx8Wrt3nFloX693DQFIRKixr1lcMiPayy2Nj3iTLRk5Bc4ezhnu8L5Icmd88rpbs8
	 +GXTiYfbUkfxNrE+yNG5XYcbTxMQ6EcTutcWGiu00XljPswZ+of0kyzyB84XjH2duy
	 S9nn2PoQ18P8Q==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, thomas.richard@bootlin.com, rogerq@kernel.org, 
 theo.lebrun@bootlin.com, c-vankar@ti.com, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240710031626.2003110-1-nichen@iscas.ac.cn>
References: <20240710031626.2003110-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] phy: ti: phy-j721e-wiz: convert comma to semicolon
Message-Id: <172279390484.406109.8757122625415415901.b4-ty@kernel.org>
Date: Sun, 04 Aug 2024 23:21:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 10 Jul 2024 11:16:26 +0800, Chen Ni wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied, thanks!

[1/1] phy: ti: phy-j721e-wiz: convert comma to semicolon
      commit: 0f20e326e723075f98456bacf8de475421f68be6

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


