Return-Path: <linux-kernel+bounces-404911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD39C4A73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48DFB31DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 23:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4781C1F25;
	Mon, 11 Nov 2024 23:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRt/ZtkI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDCA1A2C04;
	Mon, 11 Nov 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369169; cv=none; b=igSAs207iI8qynsMmnmVx/ENDMVMQC0M5fqiLKSQvo1XLZ8nvQHKWMKm8R73xSsaWq91F2IcjLDGjMPWpiwMZjbpOY7x2xntrlRflK4hYZs+qHUXTp2lmHJomo6n9hk41C+XfRWuXGSf820sbwy3WFVg5+est+OarEcdVgaz1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369169; c=relaxed/simple;
	bh=umxN0ACvG3ZC59nfOPsgtgdIF5Zx1AZFD1djdLZI77I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbPcSxk5+HwgvMsqQZdEiSP0I9a7EbfbIJTeEHUZlvEvILQPL+gjc+fu/QrYJYkZ4w/FZYrMIPNeB60gr0RPFIGE4POom+oWHOxeBWaSA+yfN+k+3axyfX553PgzinhTRgVImYVoCvnAx/BAEB6KPV9ExJEEOdj/ct29sr/hC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRt/ZtkI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A089C4CECF;
	Mon, 11 Nov 2024 23:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731369168;
	bh=umxN0ACvG3ZC59nfOPsgtgdIF5Zx1AZFD1djdLZI77I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rRt/ZtkI06cCA0SDjlWMvkc8SknPkcvR2frvqsNs/3kcEJgKU4A59X9slyzafTZmq
	 C8dISUT7gpjHEAM2ukXVAtsj1TRv89deE65v+jwdFKjrCgieHXZ8NSikirDlZLpt5B
	 cPgMio+imNoPpk60Yi+fPILQw7ai4ZdsZUKfjAEk/Vk2mB9mlrAAKMt7W+iGWwJaLo
	 g0qxEKJJh1AvSt09h74Ww6cX+tskzkmTGp811/FMhgzPlIpRNZ9w3t5Y2Rs3nIlnKL
	 c9g2saNEpF3KfBpKDXGglTPjWBbADmy5t5p2z00psa2p27dPTuc9xG0GzdKQj0u3mI
	 KCwsXFOPU0SEA==
Date: Mon, 11 Nov 2024 15:52:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools: ynl: two patches to ease building with
 rpmbuild
Message-ID: <20241111155246.17aa0199@kernel.org>
In-Reply-To: <cover.1730976866.git.jstancek@redhat.com>
References: <cover.1730976866.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 14:04:43 +0100 Jan Stancek wrote:
> I'm looking to build and package ynl for Fedora and Centos Stream users.

Great to hear!

> Default rpmbuild has couple hardening options enabled by default [1][2],
> which currently prevent ynl from building.

Could you rebase on:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/
and resend? I see some fuzz:

Applying: tools: ynl: add script dir to sys.path
Using index info to reconstruct a base tree...
M	tools/net/ynl/cli.py
M	tools/net/ynl/ynl-gen-c.py
Falling back to patching base and 3-way merge...
Auto-merging tools/net/ynl/ynl-gen-c.py
Auto-merging tools/net/ynl/cli.py
Applying: tools: ynl: extend CFLAGS to keep options from environment


With that fixed feel free to add to the patches:

Acked-by: Jakub Kicinski <kuba@kernel.org>


One thing I keep thinking about, maybe you already read this, is to
add  some sort of spec search path and install the specs under /usr.
So the user can simply say --family X on the CLI without specifying 
the fs full path to the YAML file. Would you be willing to send a patch
for this?

