Return-Path: <linux-kernel+bounces-270765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFFB9444F3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9C3281970
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E05516F29A;
	Thu,  1 Aug 2024 06:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tM/+asj5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E6716EC19;
	Thu,  1 Aug 2024 06:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495320; cv=none; b=doOTyB1E45B5KhZ3ZPa897EocxjEVCe3F52bDXHQm1VVyoVVAkLqXyF9LbkTUv/1Gj+alsXgB0JxF2ZNKFz+K9TosWfA8vr0IlosH9mXuR8zdAJdrxIAtXv01mMWJ+vnzfgBzyCRKmRpdUQgkWvljRQZbqFxXJWRSLJi3CoGcsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495320; c=relaxed/simple;
	bh=4C6VDEfz65u+c8AGnTvZyieOGwvSu376DqNaJtC/1aE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=adsEu1uCXBGJi65JAyWGoMLpeVrezCJXKZcxRDSfH0xrCRzn+7KH8cRxo3t75tKb95titS2Fae6bHVixG3mUYBB1RB6SQ5jRJi33Qpb3RtT6o1ctcVBU1kU35CTmnK8tTTdXtwUwAIyynTCPhZgH0JO+0CUe0IzXW+IQJOJ5P90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tM/+asj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7CAC4AF09;
	Thu,  1 Aug 2024 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722495320;
	bh=4C6VDEfz65u+c8AGnTvZyieOGwvSu376DqNaJtC/1aE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tM/+asj5ZpWv7EUwOHLSEZ/N2STm4RMTBD+MeUAwcCp7IdUQA+KCuwYg5OBRziNjK
	 cUIxWYiW00TwcoivhBDkgTRrz5fTG49Gj+RpI5s2G8FJD7wOGqAEx15BKQhXUBNLA7
	 NpRV5QjX1wGVJVWBGYTcK844hELu2cahIqXWSLxqC7OsVBf7byFay6C5iWgGvsjOxQ
	 LYNqXlVI6FBWW0VOvOXgnYebWj8OlY2TORgv2Mvboka3YYUAG1/ivPcNRmDu2xb27w
	 yK5h3yT6pLtKUorvfMcBoSqk/DEHE8hJqLM88IPSeoIZzJYiHkghn2utYiMo87XqDS
	 TSB40XzNML5gA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <cover.1720723132.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720723132.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/3] phy: cadence: Sierra: Constify some structs
Message-Id: <172249531801.256913.2609944254797993813.b4-ty@kernel.org>
Date: Thu, 01 Aug 2024 12:25:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 11 Jul 2024 21:34:51 +0200, Christophe JAILLET wrote:
> This series is just about constification of some structs.
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   60489	   4342	     16	  64847	   fd4f	drivers/phy/cadence/phy-cadence-sierra.o
> 
> [...]

Applied, thanks!

[1/3] phy: cadence: Sierra: Constify struct cdns_reg_pairs
      commit: 29f33f0b442c092d7180b511d8bef871f3be9fed
[2/3] phy: cadence: Sierra: Constify struct cdns_sierra_vals
      commit: da41bac5c89720f9fb8289a03e30ec0b3cb1cc9c
[3/3] phy: cadence: Sierra: Constify a u32[]
      commit: f75999c525a1d7d6c4425a6a225cabae40ab1721

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


