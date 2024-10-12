Return-Path: <linux-kernel+bounces-362568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA699B67E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0001F225E7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B719308A;
	Sat, 12 Oct 2024 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNuw7kMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCF21B969;
	Sat, 12 Oct 2024 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755443; cv=none; b=ludUMbenGDKYwKnVuw6jB6POP34dbMvnWwqlFstlY8cWzCcpddTH4ezn6wJqF+hvc95QWee0SteNzYKc8EFfB74tvhSjctVMdR1xG6z9KOra5oIPaX8az4IVk+oO9IPzxjlzO+jaKFvWydM4eWbIrdPXmPvRII3SbQJAiOTqxC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755443; c=relaxed/simple;
	bh=IrGrdRYv8ot8a1VdA94PIoD/MYZEgPGcLz0JZgh4aWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=un8BYtB8nxFvb0dhktQeHhyBlS3MkwBSuS7hMo3FMWPfnaSSJfm+QMsMWorzricQCI31rGu2WCZb98+B2zaupuhGXR2t+wnNeloPErJzQC2h5Ev1OidxZpsLIEmTAhZ3o0Y754WTyPnFBPfUrw9huh6BTiRYfI6Gv4zCvS4dgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNuw7kMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7971C4CEC6;
	Sat, 12 Oct 2024 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728755442;
	bh=IrGrdRYv8ot8a1VdA94PIoD/MYZEgPGcLz0JZgh4aWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cNuw7kMF5i+IXjEudpdcQl84hpakGHv9yFK0fFIbT4mnDELCrgfcb0zFsdj9GP+PO
	 B94zZ7Uqi3NPpcyttfo309rKRKnv/2NQh9A0WSGJFgeRx4E9JUSulP1mtZ+87P2vGs
	 G2u5vlkv+t9rw+NByEdzqdYZLULTID1USBSLWp2KbIIENdcd2Jb8qk4Dp6pVu/YSl9
	 7S0NbL6qOgxbK2bGktUAPSapgDCYPo2cqgDyFyorCUuyiGIEEVdtNOXXRn13ivTxtm
	 so5k+o4drBBcIUoWTNa/uAqxV5EoWS0vyipDG8VAZDjY2y+R/+ONDt376RPBjmofN2
	 UfaEgzHHaXO0Q==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Andrew Kreimer <algonell@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <20241010091355.8271-1-algonell@gmail.com>
References: <20241010091355.8271-1-algonell@gmail.com>
Subject: Re: [PATCH] phy: sun4i-usb: Fix a typo
Message-Id: <172875543924.55946.332622987727413836.b4-ty@kernel.org>
Date: Sat, 12 Oct 2024 23:20:39 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 10 Oct 2024 12:13:55 +0300, Andrew Kreimer wrote:
> Fix a typo in comments: wether -> whether.
> 
> 

Applied, thanks!

[1/1] phy: sun4i-usb: Fix a typo
      commit: 11dad94b50263bbe87d015041c77be61c8c44161

Best regards,
-- 
~Vinod



