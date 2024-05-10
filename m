Return-Path: <linux-kernel+bounces-176167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D046E8C2B0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 22:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE61F23887
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33CB4DA13;
	Fri, 10 May 2024 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS+oDt/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9704D9EA;
	Fri, 10 May 2024 20:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715372284; cv=none; b=m0ZZf0JozR8XhFVS6NJLAiZ0ANvqoeihnHF1FxBUbaN5NkUN/HByM5K6tzuerkJGhpK0Yg0RBCGpnSldoWWvGnXfyC8wOPcY/XeVnyK7AJm5h7xVJ1GiEyh7AkNdLnAK49yjWpoe63+zuFKso1RXfJOP2LwYvf9v0G2kTEtGdxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715372284; c=relaxed/simple;
	bh=KPf7sNe64S2Z/jANXPMUCv5hsHsruu3JjDnjvZm92fE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Nx+D9oMaJR5KZ4BAvvxbfSqlvoSzKAnfgrnAag+/Xlnwd2BgI6WdvmPmDWvSD8rXQMOLonMd5YN76MC437d4sXK8ys3hRxW9D/jGmIdn6KGv7qUt+bFbeT8hQmaP0W+LNmSoHHx4lpIOJ/YNt9Tld5y97qcxsUYC/r/LTuIUH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS+oDt/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D81C113CC;
	Fri, 10 May 2024 20:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715372283;
	bh=KPf7sNe64S2Z/jANXPMUCv5hsHsruu3JjDnjvZm92fE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KS+oDt/uWR3AkeaUBEz+7UO3hY9/HqG2NO/aCpQsTEORpcRsbY67un7BLUjizfbxs
	 oGQDkiL8fDDO7msiqWFlaOgdV+tIHiY/hLqIv8UdRe1Yi9uItRWulaGbBoBvUY+HfR
	 QCJ9VCLZmu1OAQSOPSjWf93b96U8PLqMhJTm+sSyA/+RKwuwOKaESUSMRB+K/AQt61
	 HFeq8dk/7vpOtEvhudt+LZuVqtkSuygKTYoCzUHwGonkv6XHanOCjGAa4+zutRhrmP
	 LlADgnRJANp89REzsz6nSTRMNBcn8kVj3PGIwWeDTzzJOLGfFeDs4W5CCJ+Bp116bz
	 N0x1PRCrDBquQ==
Message-ID: <c25dd5216b66948e6842326db67a8e83.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240509230516.86023-1-linux@treblig.org>
References: <20240509230516.86023-1-linux@treblig.org>
Subject: Re: [PATCH v2] clk: sunxi: Remove unused struct 'gates_data'
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, Dr. David Alan Gilbert <linux@treblig.org>
To: emilio@elopez.com.ar, linux@treblig.org, mturquette@baylibre.com, wens@csie.org
Date: Fri, 10 May 2024 13:18:01 -0700
User-Agent: alot/0.10

Quoting linux@treblig.org (2024-05-09 16:05:16)
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>=20
> 'gates_data' (and it's associated define) are unused since
> commit ee38b2698ae2 ("clk: sunxi: Add a simple gates driver").
> Remove them.
>=20
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

