Return-Path: <linux-kernel+bounces-570575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086C8A6B21B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCBF78A729D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C6288D2;
	Fri, 21 Mar 2025 00:16:12 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B438200CB;
	Fri, 21 Mar 2025 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516171; cv=none; b=qS4/eK3DaDywAf2noIMdeaa+8bfmlptCJNgyQ8BxvEQIZbc/JCgmZUoyraG6rTZft+dr4O6VeY6O1A7WGeSDP8zuz+Etu0C59ZhgIYPI+U1Btx+HelF+17+3GrSzMU3fg7BXdhfsAWM0JzIFGBv92UM+lCQCxCIeuT5IESM1p14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516171; c=relaxed/simple;
	bh=PXjSv9YqNQ/73RABrmcz46z10w18/4V0fxlzYlBOcgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST+PAM3kN6kpGc/DWcjgb4I5o3tTjXp2qER20etpBwhGVECFBc3oC4jftws9Z/a3wy9t9J+MI24DWE6GCeYA6G31KGq2w8mRvYfVSbECqAFPzP0HmGWI9Z7eO9VAl8fHepAFL9nUrVVFqVsM2oEn/paxygEXCqamjkrm/TxLCCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.18.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 6ED493431C2;
	Fri, 21 Mar 2025 00:16:09 +0000 (UTC)
Date: Fri, 21 Mar 2025 00:16:05 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] clk: spacemit: add K1 reset support
Message-ID: <20250321001605-GYA10514@gentoo>
References: <20250320194449.510569-1-elder@riscstar.com>
 <20250320232128-GYA10498@gentoo>
 <fe26de4f-5593-4f34-a752-5fb051972c31@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe26de4f-5593-4f34-a752-5fb051972c31@riscstar.com>

Hi Alex:

On 19:05 Thu 20 Mar     , Alex Elder wrote:
> On 3/20/25 6:21 PM, Yixun Lan wrote:
> > Hi Alex:
> > 
> > Thanks for sending this patch series
> > 
> > Can you also CC spacemit mailing list: spacemit@lists.linux.dev
> > it should be handled automaticlly in next 6.15-rc1 version as the
> > MAINTAINERS file updated
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?id=4a0c4e723c94
> 
> Sorry about that.  I will copy it on my next version.
> 
> Are you asking me to RESEND this series with that addition?
> 
A resend would be great, so people subscrited to that list will
receive the emails.. in this case, I will wait to add more comments.

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

