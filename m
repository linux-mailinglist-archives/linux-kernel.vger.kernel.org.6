Return-Path: <linux-kernel+bounces-192727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F238D2154
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2F21F22732
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F62E172BAD;
	Tue, 28 May 2024 16:10:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01732C60;
	Tue, 28 May 2024 16:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716912655; cv=none; b=hUBNTOrO5jWvPYeruVPBHD+oVJuMoeGjQ/8fsfktsEHX6HxCRkI/rpIzyzZCCrr5gPAg0oIiV6NpCgrG89r2fHHhSKHbrFiMjGnMJynlUvMwh6CrFMhENEkX2sl3Pgy4jmBIVssIqD4kF8s2UTfneWuNG3nbyC2v9XWzK9h1MEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716912655; c=relaxed/simple;
	bh=9ICTCtnlLHOenJgaZARgOySRluQf/meTuCnfjhLEFn8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s1pgTPzRriQVR6QLR8HcOfnDBgiKLJmG/ihqdygUEvEUDzBT77XWRG6WY5Gw5mv2Fypqoy0wbFbmgOL03dgVRv0PR1OYJfF3ivo5BlrylhNmKftKiQj/wUpHEdihKGZmWOK62GFQ1wpktLmH19lnBfnlpFTBKbO99QjLuYVxczc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BF7C3277B;
	Tue, 28 May 2024 16:10:54 +0000 (UTC)
Received: from wens.tw (localhost [127.0.0.1])
	by wens.tw (Postfix) with ESMTP id 604715FA42;
	Wed, 29 May 2024 00:10:52 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, uwu@icenowy.me, 
 andre.przywara@arm.com, didi.debian@cknow.org
In-Reply-To: <cover.1716768092.git.dsimic@manjaro.org>
References: <cover.1716768092.git.dsimic@manjaro.org>
Subject: Re: [PATCH v2 0/2] Correct the model names and descriptions for
 Pine64 boards
Message-Id: <171691265237.683236.11362059742528552634.b4-ty@csie.org>
Date: Wed, 29 May 2024 00:10:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 27 May 2024 02:08:16 +0200, Dragan Simic wrote:
> This series corrects and, in a couple of cases, additionally simplifies
> a bit the model names and the descriptions of a few Pine64 boards and
> devices based on Allwinner SoCs, according to their official names used
> in the Pine64 wiki and on the official Pine64 website. [1][2][3]
> 
> These corrections ensure consistency between the officially used Pine64
> board names and the names and descriptions in the source code.  These
> changes complete the correction of the model names and descriptions of
> the Pine64 boards and devices, which was started earlier with the Pine64
> boards and devices based on Rockchip SoCs. [4][5]
> 
> [...]

Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!

[1/2] dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
      https://git.kernel.org/sunxi/linux/c/e1410c817ac4
[2/2] arm64: dts: allwinner: Correct the model names for Pine64 boards
      https://git.kernel.org/sunxi/linux/c/a72cf19bf50c

Best regards,
-- 
Chen-Yu Tsai <wens@csie.org>


