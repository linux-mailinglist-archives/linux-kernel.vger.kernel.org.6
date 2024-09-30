Return-Path: <linux-kernel+bounces-344375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEE798A8D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2EB1F2119D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37B19307D;
	Mon, 30 Sep 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH2+3vV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58438193075
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727710835; cv=none; b=bF/vhxGtm93qwYOq4Mhm2ZIIxzrZzo0jraRVfvVGxgEbEYK/NgMp6jeHL+y+Chz9wpaYB7CG51Ijo6YXsn1c12ruVOxonE8gQA4lrg2z2uWml9UY4i1l2TbsGcPrXf79nPdKJwP6quJCCpYFGbX13Nb2codfcalr9ADKT+XRk7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727710835; c=relaxed/simple;
	bh=CsAZloyyy9Diqcaz5hciYg4n522iRNjKtjP6TEATdYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=chHt4Np4cunnQLFY6XXNL7iItRosnWMTYYQINq4xQwasI+IdCxzzAjnYqAmn0L9jmTCt1vZJQoGHwsqoniyIvdcUI8TtVEXKK82RunI5e/d/O4aBRx5IZ9uVvjmujmMB6NCD9GkrttdaqkuFfegDnuEf4gSMyI8hRF7CKsPsLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH2+3vV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5B6C4CEC7;
	Mon, 30 Sep 2024 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727710834;
	bh=CsAZloyyy9Diqcaz5hciYg4n522iRNjKtjP6TEATdYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vH2+3vV76zOB566tm/vDTqc8VdBxbjm3EqjhcONhhIQk5wQHA1qYwIjS6qHoYgdYs
	 zUcGjzK3N6xf2mOyCP8vbNuUWA6WMhOAYrmgNQ+ckXaS5lDxcZMPU9HBEUXyzllN4i
	 iFHFniCkZsBjQxEp/IxioqqnL8ZxApB7qcfDSg4nEXPlzPTlTlDeeLQ4Xj6JVeqCJr
	 6Fq1lHoMnzMr+ZFN+LKlLj5PYNLsj6qeaW1wMMJ8HAzDJkkKS+izxGz+nol6v1k5UY
	 r8fQFVqOkWK5BoFSOldcigjxrvUWAjEAMmOc5UtLCdtcx2qbi1sqMLwBNNdh704lL1
	 S79SQlJ1NiYFQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, nicolas.ferre@microchip.com, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, 
 Shen Lichuan <shenlichuan@vivo.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 opensource.kernel@vivo.com
In-Reply-To: <20240905092718.95011-1-shenlichuan@vivo.com>
References: <20240905092718.95011-1-shenlichuan@vivo.com>
Subject: Re: (subset) [PATCH v1] mfd: Convert comma to semicolon
Message-Id: <172771083307.566857.14861740699351229601.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 16:40:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 05 Sep 2024 17:27:18 +0800, Shen Lichuan wrote:
> Replace a comma between expression statements by a semicolon.
> 
> 

Applied, thanks!

[1/1] mfd: Convert comma to semicolon
      commit: a261888ccbc29d009c66b06ee02a5e4e0573415d

--
Lee Jones [李琼斯]


