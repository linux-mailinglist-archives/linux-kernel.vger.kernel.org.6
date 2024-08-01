Return-Path: <linux-kernel+bounces-270764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179E89444F1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD6BF1F26790
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856416EBFA;
	Thu,  1 Aug 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2Vrx0hw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC64158A2C;
	Thu,  1 Aug 2024 06:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495318; cv=none; b=a9wwbNaUJ/FuXSqfivGuqw1ELsOknRVUVUziNOXPztQxxJ1KwEyDnM9ZXb/d0yyz1TKgNG6wy+WYscnhSa7ApVWSb4SS0NaTwcNlJkpqpVEzJ1LIJJcNYDMD4ms77OgO3pd2fujKxGIVQHK3yIWslthnh2v4brgID4D84ww+5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495318; c=relaxed/simple;
	bh=PW1fmd0yFchGP2DLz+NRdDx4udpU1rOUDGXgTeYD+z4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PZ4qu0fqsiEAH6wP/mIVDC+ffymCq5r/O44wg8LVxMCfEkXR20jf04pusd23dFikQO/B7sI22TZQA8Xe62amOOqkUS1F9CqAqUspfikdGE3zz5zjN475i9gAgJpYBFJEk8f1J6TPs8X6HDpEsYPc8x1+H2jw3sKte5SZe6e6JcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2Vrx0hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18BB9C4AF09;
	Thu,  1 Aug 2024 06:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722495317;
	bh=PW1fmd0yFchGP2DLz+NRdDx4udpU1rOUDGXgTeYD+z4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L2Vrx0hwjGVTr98Q0F30tc8oNm21dncEGnWTPPgHsCqAbFZla1BicwBQ8kwJVKZxI
	 sbJGX4u/cHAV1VfQD/wX+NQnFPDHUxThaPfjQ5MKYUKTnqGjg8WdwzCdILe7BxHYuu
	 byDL/3WzwtgE23YyHfB01rciFu55jK0gldxsIYcGJ75iie+osIVq9kjLu91oyyLU1u
	 Zxl7Gcp7Gur+byCkuRZOICmwABbo7i0V4G+xrPrS1frcEFCTfWNZ6hgw9zwd+lJHL7
	 VARmVlYucs3wYhXblgfWNybH5skS9W/dioG9xmd2UKYzTPCQvdG/2+RZ5kLQ5gvTe+
	 CvXCmm4Vl9dDA==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
References: <cover.1720718240.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 0/4] phy: cadence-torrent: Constify struct
 cdns_reg_pairs
Message-Id: <172249531567.256913.10505517208895735918.b4-ty@kernel.org>
Date: Thu, 01 Aug 2024 12:25:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 11 Jul 2024 19:31:05 +0200, Christophe JAILLET wrote:
> This series is just abour constification of some structs.
> 
> It turns about 15 ko of data in ro section:
> 
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   78154	  20222	     16	  98392	  18058	drivers/phy/cadence/phy-cadence-torrent.o
> 
> [...]

Applied, thanks!

[1/4] phy: cadence-torrent: Constify struct cdns_reg_pairs
      commit: ad3654812f2cf937679128f18a146d25db9d3a0e
[2/4] phy: cadence-torrent: Constify struct cdns_torrent_vals_entry
      commit: 1d7eb113f1f0d368afbadf56ffef91d615b1cf41
[3/4] phy: cadence-torrent: Constify struct cdns_torrent_vals
      commit: 86946f25cb23b71d3ebdc3dd5bbb8ec5155c03ce
[4/4] phy: cadence-torrent: Constify a u32[]
      commit: ceb6e0435075ad8b44c78a12dbdc3ec1fb4ec301

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


