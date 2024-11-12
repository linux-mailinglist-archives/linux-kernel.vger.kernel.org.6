Return-Path: <linux-kernel+bounces-406088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D72699C5D00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BEBCB34A05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BE1F4FA2;
	Tue, 12 Nov 2024 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WANlS/uo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348B1632E9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422830; cv=none; b=GYfTVdr6tkauEkPtoHa78nT5aC6+AkCoH29YlxQ1/pbl7t2e2Cl3EdyOgq1ODFixkYeFTVWYvfTDXcyIMq+J7y4nX2oddbaQY9RCPqOTWq9tHWjjPc9+njHjqedwX4pdkTA3g1cyeLgWisUq1CcZSi60iz25kqY9pKsRQ22wonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422830; c=relaxed/simple;
	bh=/2PcdRQy1jS/HrvHexNSmnKWzlOWJOinlTdlp2XiWOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FgtNB274FGzvP/UlSznCvpM6fmuaB53aCdGhq2fespZwqL8lgm6/v31RYe0iykzvtH9rMFGF+O2tyC9GnQOMphku1H8CfVLvH0fVmE4o9NzA3e1yLeJmLO2Ib6G04Pq/XdIQo+7PHjLXzmIhVOH4YAC3S0XN7KQ3gLPPIfS727s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WANlS/uo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4878DC4CECD;
	Tue, 12 Nov 2024 14:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731422830;
	bh=/2PcdRQy1jS/HrvHexNSmnKWzlOWJOinlTdlp2XiWOE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WANlS/uoFhHehcA6mVz302WozSG69nOM899f983Irx1MaaAKq6bBD58OW8bQdD/Ia
	 wYF2V85ArnbsNrEZmT3CdjJsXskN5MM3KKBR/sD/RrG7i5AHlMnCsS//KuiGL3wYZn
	 UznzIpm81IblMQ3h+KFqhALX2ruhbcFVwQhutps94At8b81UM73w22wgiWqnb+TD6w
	 /QXLJTpDjWcJ3TmXW6Rquja340F702FEj0ekvSNkqQ70WStxoi6lwbbhL2xGoTaKSR
	 A3+Lkhg6o/zzNQdGsH2aiiUuK9aLKlohy+6WPnc9LpwOgZPB4AMXPaT4ZGpamNf1J4
	 k1E1ZEb3pyb+A==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: linux@ew.tq-group.com, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
References: <cover.1731325758.git.matthias.schiffer@ew.tq-group.com>
Subject: Re: [PATCH v7 0/5] mfd: tqmx86: new hardware and GPIO/I2C IRQ
 improvements/additions
Message-Id: <173142282903.1053879.14195219124550733607.b4-ty@kernel.org>
Date: Tue, 12 Nov 2024 14:47:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Mon, 11 Nov 2024 15:10:27 +0100, Matthias Schiffer wrote:
> Patch 1 adds support for 3 new TQMx86 COMs. GPIO support on SMARC
> modules is currently limited (not all GPIOs can be controlled, pins use
> incorrect default directions, IRQ configuration is handled incorrectly),
> however this is a preexisting issue also effecting the TQMxE39S and
> TQMxE40S, not only the new TQMxE41S. This will be addressed by a future
> patch series involving both the TQMx86 MFD and GPIO drivers.
> 
> [...]

Applied, thanks!

[1/5] mfd: tqmx86: add board definitions for TQMx120UC, TQMx130UC and TQMxE41S
      commit: 97f0db59525f7e82113404ea4bf79c435ad53365
[2/5] mfd: tqmx86: improve gpio_irq module parameter description
      commit: aaac6067d7749bba6401fe3d76fc554de8338f36
[3/5] mfd: tqmx86: refactor GPIO IRQ setup
      commit: b58bbbd7c599eab4861cc68a13440f5ad4679dba
[4/5] mfd: tqmx86: make IRQ setup errors non-fatal
      commit: 1f86faeb8b4bfeaa001a6c24141cdfc98093e9db
[5/5] mfd: tqmx86: add I2C IRQ support
      commit: 0d3f073975ad28bd16034ed81b8e525e808cbe37

--
Lee Jones [李琼斯]


