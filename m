Return-Path: <linux-kernel+bounces-396764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ED09BD1AD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 17:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E09C1F2520D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89B317837F;
	Tue,  5 Nov 2024 16:04:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA401741D1;
	Tue,  5 Nov 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822659; cv=none; b=pqnD2LvFVoI1x4OJQOV+H9dOfpAjRldrMR0QuGOOrquaXx+mQY0ZficLQjMYwd0yEor9MM8f6A+fhKm2t0O7rIKitYE/RWYSU0PbOtRonMomPFWCAbQvgVk83vf0JCIDvn5jUNWOTyNZFAmLfSgSUL5WoveHKlgKveaZxheR3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822659; c=relaxed/simple;
	bh=nkpLc2+tgh8TLyuv3Bxv9vtQzb9Lvj5rJGmLawi36ts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TqCI6dhkHvQ1n41W4RfYE9rwjYTPQCTje7UR8xXR+EC4UUZkaXHmnEb/HuW2YMUMO59LPMDx/yVd5seKgZyeiDNoiE5yDUBvn4O2/85SITtx28UL6WUOkUrc2kmZDR2QKRrp2pLnYCrOa3lUeRvqemRQ0653vx0Zz+uiJmFKydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C4CC4CECF;
	Tue,  5 Nov 2024 16:04:17 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 41F205FB0F;
	Wed,  6 Nov 2024 00:04:15 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20241104190455.272527-1-robh@kernel.org>
References: <20241104190455.272527-1-robh@kernel.org>
Subject: Re: [PATCH] clk: sunxi-ng: Use of_property_present() for
 non-boolean properties
Message-Id: <173082265523.1488411.1920561535591784588.b4-ty@csie.org>
Date: Wed, 06 Nov 2024 00:04:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 04 Nov 2024 13:04:55 -0600, Rob Herring (Arm) wrote:
> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.
> 
> 

Applied to clk-for-6.13 in git@github.com:linux-sunxi/linux-sunxi.git, thanks!

[1/1] clk: sunxi-ng: Use of_property_present() for non-boolean properties
      commit: 1054861bc258fb5798b7132453593cc3eb0639ba

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


