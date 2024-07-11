Return-Path: <linux-kernel+bounces-249580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFB592ED86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C232DB21FFE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B1116E868;
	Thu, 11 Jul 2024 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSYuYYzq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E316DEA4;
	Thu, 11 Jul 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717877; cv=none; b=iQLSXTWPpS297AjctSeOuAI5o8y80oiezd5mVVzw9NlLlAw8OhrY7t9DZDF/p8d/54yrTdFhjur1VhVebA1Xco9R/TduFe3haQUcdkTHLk8mTAjjvX9bcYYE+IJqzaSA1BQ8WPDmMGiox8laTNkd3zSiOYiK1qoIgYgrnR0srZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717877; c=relaxed/simple;
	bh=eAcO3eyyhWyjZax3zOfbzNEnJg7IUGfjgGt7eDDcIIk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QR5ye9Jhr+KXXwKkGxy8/x/nejzpWDb3uZXuhu+EmyrhG+Q1BPNT60zGmKqmWa0SUmEQ0igQza8xOSeY671Z7X/+Zcd6mOwWEZVMjpIuenOjUPo44gtnOvVA5dRsNhQD3pNyApkl1tCvIaUmqHC2X2+VHGXofVKZPwaI8CBBr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSYuYYzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B207C116B1;
	Thu, 11 Jul 2024 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720717877;
	bh=eAcO3eyyhWyjZax3zOfbzNEnJg7IUGfjgGt7eDDcIIk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gSYuYYzqdYZlo2iyfVbFW86Upg6xaE5dq83UgTNu29rmr/bzYylRvHGFJNZa1sAQl
	 kRsyQ4SFsn4Bxm+5LdPfg8DPgln5avJYqHAYhHF5bQKmtiZDtOENDYhU7D3Kh0LMQX
	 S4kYu/Js4ZhNsUrM3MPYKQddEj0+pxdd1Yl4wEHFsAnc6EZumnz0BCrsFxQXvNPYUi
	 +LjJZCiXGGvYp7tT/nSVxcW5g2MVTLFgKSMtmcf0ar19N9TYZKsE6K/SpnxnvnSCA/
	 OiAw0fx3W0n6e8s5rD5ga/tK8lWW8dEm0FmyqYpDgTmJ+Jq4RZtSmCkPe2L9SotEnx
	 M2151CKYIk4ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F623C433E9;
	Thu, 11 Jul 2024 17:11:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] net: pse-pd: pd692x0: Fix spelling mistake "availables"
 -> "available"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172071787725.2867.7176768478740166491.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 17:11:17 +0000
References: <20240709105222.168306-1-colin.i.king@gmail.com>
In-Reply-To: <20240709105222.168306-1-colin.i.king@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jul 2024 11:52:22 +0100 you wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/net/pse-pd/pd692x0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] net: pse-pd: pd692x0: Fix spelling mistake "availables" -> "available"
    https://git.kernel.org/netdev/net-next/c/a6a9fcb10836

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



