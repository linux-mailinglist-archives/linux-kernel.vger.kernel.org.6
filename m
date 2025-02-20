Return-Path: <linux-kernel+bounces-524469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84BFA3E37C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 19:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2172F188CAC5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF0021507D;
	Thu, 20 Feb 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbkhjCY+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67D215066;
	Thu, 20 Feb 2025 18:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075007; cv=none; b=ap8scWUqJEEvqFfIPazOb8f2h5ajX9lvwO1hOwsNuGVTAAuzOE1KtOmMQTd9zL4czdPTBLCxxfWMOoShRuYH/gBHiuAE8taZ+DYn7UZl+H1SwH+fDPIb99xDHIB7JZyCw7B0JNoUIbSzwhp4+3gdB6aMJPHTzCnP9ywYOUYfntg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075007; c=relaxed/simple;
	bh=Y7MaMfD9DEqfEQuEhCmvFOzAfwIYc7wHGUXF/wMwcLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/gIjGvX764n/68rCngRcdh8MQ54bYuZFvnRvGCsUaDx/ISSCt+klULYrmuCEEndWt3aGvP5EpxLTw6VsLvL4dAFC1NnN66jEXYaqJlaMilvZRK1hV2qNWsYuIxn/8xzXEC7vzM8x8ewFBJxuh7bcvkFWsT8c6jdQvWLlHsnREU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbkhjCY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE364C4CED1;
	Thu, 20 Feb 2025 18:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075007;
	bh=Y7MaMfD9DEqfEQuEhCmvFOzAfwIYc7wHGUXF/wMwcLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SbkhjCY+Mc+k1rpe591Ru7OuVHxSEOmm7ZWLxr6z0eR8+v5fu1ecN/E4ACaJYw/D+
	 rUbMSWPcl0MdHexu5uH7ULwD1ujdQT2t/5WP8/4Hz2v290/gL4vQEjRLqyFY/GPogu
	 nYrPmDOAo1N4CdMWYbO7CEXAkfonjmZVEwLeiCe/8AbG6gakTr+1ymHLlIYTUpPikJ
	 KReViCnQfAAoTpNcHXYarKYemFsW5fAu8qkPF9ZapburQ4WE/5I+4MXaZkCfVbjZVl
	 FeD1ayCHJi6aXsKnqPOgOOyrWuoFjWpOzsLI++74/U1irZO3Y3YwlXcGb72mSFiU4i
	 Pv/u2S1YJDGKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBB380CEE2;
	Thu, 20 Feb 2025 18:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add 2 HWIDs for MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174007503776.1411319.11609386550305618639.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 18:10:37 +0000
References: <20250220020129.2400730-1-jiande.lu@mediatek.com>
In-Reply-To: <20250220020129.2400730-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Feb 2025 10:01:28 +0800 you wrote:
> Add below HWIDs for MediaTek MT7922 USB Bluetooth chip.
> VID 0x0489, PID 0xe152
> VID 0x0489, PID 0xe153
> 
> Patch has been tested successfully and controller is recognized
> device pair successfully.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add 2 HWIDs for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/5118199eaca2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



