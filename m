Return-Path: <linux-kernel+bounces-340247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEE2987072
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6529B2861A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ECF1AB51C;
	Thu, 26 Sep 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzn+Owgk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F681AAE2A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727343691; cv=none; b=YO5StEbnMV1i5WYptdMs4OjzisfWYRjJKSCNt1mrLs1uNHeQEdbY2McHtPTxLZCLzfqboF5RKAoD37c8BFcRAXkdeMIuhMNIAe+KGZrxen47toHy5QEKgXP9WSmn0i/Fh1ds8eNLiVvNfNz3LM9D8NNAflKLZcylLRxEIebYqaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727343691; c=relaxed/simple;
	bh=NexbOchWgdh+LSe9fnsgkVYr+KrgwCO2J/3iumnJqx4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=KjLAQU1ek6eZHbezTbTlnv+v10vwK/P1+1S+wPtlf51f1K4on0v6RbN1q0QD8P2wQvthGAE0BihFnDHMkJ9Rrd6GaIc1LPzv5yF8ZOfGTPSZBDDAnm0ndyk9GkN1w5/bElVQWiyPeWoRnGewx4Y2ej7wIt4GODW4F5ZF30edYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzn+Owgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81488C4CEC5;
	Thu, 26 Sep 2024 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727343690;
	bh=NexbOchWgdh+LSe9fnsgkVYr+KrgwCO2J/3iumnJqx4=;
	h=Date:From:To:cc:Subject:From;
	b=kzn+Owgkm0zdA4k6hhE0iUV/MKsVgEMAIyruryWGxWGXX+Sv3klmujkS7vigwkS7N
	 4NytFSMwDoq5JfSyHh+1I8bb/Ibs5LFmUTP82BzN0EswjdfMXtb9C7ok0RbLLcStho
	 skWkEjZhVRGO9ZOjmMm/Dg4NLPNS+47zU8xsTwZd60cgSfl3uIXKcCtFkcDPMSmVU7
	 6u8BP8ONyx2lDrZcz29r1LriZ34mKR8+2isKnhRQZtyURE6r79AUk1RKXjYPzWu8iW
	 S4lofDze1/lIxY0lqCakacJNEHykG11O4s+iY505P3UPqo70/hVeK8WPUM9XEpUmzq
	 0PJ2awfQNbPMg==
Date: Thu, 26 Sep 2024 11:41:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
Subject: [GIT PULL] HID fix
Message-ID: <nycvar.YFH.7.76.2409261135400.31206@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024092601

to receive

=====
- revert of Device Tree binding for Goodix SPI HID driver (while keeping 
  ACPI still available), as it conflicted with already existing binding 
  and the original submitter didn't respond in time with a fix. We will be
  looking into ways how to reintroduce it properly (we have to agree on 
  a way how to handle cases where vendor uses the very same product ID for 
  I2C and SPI parts, leading to this kind conflict). But before that is 
  settled, let's revert the to unbreak everybody else (Krzysztof 
  Kozlowski)
=====

Thanks.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      HID: hid-goodix: drop unsupported and undocumented DT part
      dt-bindings: input: Revert "dt-bindings: input: Goodix SPI HID Touchscreen"

 .../devicetree/bindings/input/goodix,gt7986u.yaml  | 71 ----------------------
 drivers/hid/hid-goodix-spi.c                       |  9 ---
 2 files changed, 80 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/goodix,gt7986u.yaml

-- 
Jiri Kosina
SUSE Labs


