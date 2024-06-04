Return-Path: <linux-kernel+bounces-200749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C758FB477
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B988282408
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85A171CC;
	Tue,  4 Jun 2024 13:51:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E1D524;
	Tue,  4 Jun 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509111; cv=none; b=ZKNW+MZYTX4AO6hVLE/kM3/jJW04awwQdMGpNDPspaGvTED/oMpRrdhHM/5viEObTcgwzYTTOsawe4L1Pd/y+9wbuD02YYQoLPnqbccGkQPZHXU2gZwy8pYEb59ZsY/WyIHK4EXpYHrTlTDKWKEVeFZmMJ/ZXqS50vZCYOsEzP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509111; c=relaxed/simple;
	bh=NGNZStY9z34gKXgirOBwNG2wP449Jje7ZVoODUEKi5o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SD+OTbjvtJrNyNsqpGEd0NStsSCLCjB8zMnvHg1SZc7g3lgzZuBDUicMgjRlA4o4rL4g7bQWJ5znQH5iN6CTo4BJlfHC+PCMqX3VskNYcXrHJoI271UgBChRL65khW1kB2jhzplu3uIsTeMx/13fr/10slEmB7bkXv4rin0+Ndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA932C32786;
	Tue,  4 Jun 2024 13:51:50 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id E2BB25FC52;
	Tue,  4 Jun 2024 21:51:48 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: sboyd@kernel.org, emilio@elopez.com.ar, mturquette@baylibre.com, 
 linux@treblig.org
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240509230516.86023-1-linux@treblig.org>
References: <20240509230516.86023-1-linux@treblig.org>
Subject: Re: [PATCH v2] clk: sunxi: Remove unused struct 'gates_data'
Message-Id: <171750910892.791538.4542936800198127206.b4-ty@csie.org>
Date: Tue, 04 Jun 2024 21:51:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 10 May 2024 00:05:16 +0100, linux@treblig.org wrote:
> 'gates_data' (and it's associated define) are unused since
> commit ee38b2698ae2 ("clk: sunxi: Add a simple gates driver").
> Remove them.
> 
> 

Applied to sunxi/clk-for-6.11 in sunxi/linux.git, thanks!

[1/1] clk: sunxi: Remove unused struct 'gates_data'
      https://git.kernel.org/sunxi/linux/c/95fd34a8595c

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


