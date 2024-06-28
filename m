Return-Path: <linux-kernel+bounces-234579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32CD91C838
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219D5B248D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4497FBAE;
	Fri, 28 Jun 2024 21:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjnwbZfh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0C6F067;
	Fri, 28 Jun 2024 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719610717; cv=none; b=cY1R4XvUwyYfO3tRtNT3QyPf8stGikCdd6fpDRiEYU9+pq1wJfrm4E7LY0Ehm6aIf8dGi7jYAnt4NgEnalaraip89npn/bM3NGG2avTwfGDW1PcOjS5Bj1PBHZhj4Rjdbj4sywrcxeGm1Lq+3luTb7DwmprZDToLWfRH7zYe7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719610717; c=relaxed/simple;
	bh=AOwn24f9gkDkK37rblqUmYB4U2oYHqkM3LVGaTsfpOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz7ZeI7xu65Ox8Cs8P5T4ipqBs9S2IUbUoXBzbEsiHy1p6+8o5U1zpOqVsVWC8dtpvADtZSmz5Z2vHoKeOlolx7tiBapceySvgwUKGo28SeNYNyf381BkbhauJzKuWyRRYVZTcJ8b7lH+1CFEOQD81Qf4yZuNcUX+M5qsg5xO7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjnwbZfh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202C8C116B1;
	Fri, 28 Jun 2024 21:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719610716;
	bh=AOwn24f9gkDkK37rblqUmYB4U2oYHqkM3LVGaTsfpOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NjnwbZfh2uhmLqZhVVD20fQc6jACCKYps4kjNqEfCA5EKuzVinFqxx4ATFZgDjncK
	 cIJ+NrNQC7sEIAshRzWZuopWgBhPHteCao6yNfIcE1HQU90sIox5Rvr5u/R640JYX3
	 U1s4UhCwxRTC2xLr5hx0JfL4TUF/P+t4KEY1HatqHojutcgDBz5JPSbBYk1OJIsCsH
	 irx+3TmfxECyCACz5F1Ws5MHUNK4SdrGcTzkDNRs+bqBOAzCNFEcK4YYcTPvcsF+/Q
	 am2Szw/7cJkptEX+I7r0QwKAUR6LnlEeP2jUz/7PD6OmtvAyFv4TeuHILatNrKTVD2
	 NpQ0L005+p4Rg==
Date: Fri, 28 Jun 2024 15:38:33 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: am654-serdes-ctrl: Add
 simple-mfd to compatible items
Message-ID: <20240628213833.GA250523-robh@kernel.org>
References: <20240625164528.183107-1-afd@ti.com>
 <6ebc89dc-fbb3-4073-8b1b-cd413907ebf8@ti.com>
 <7fbb62b3-cc71-4fa8-a0c4-fca558292c75@siemens.com>
 <c3f4a289-03b1-48a5-a3dd-7cb7ca594055@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f4a289-03b1-48a5-a3dd-7cb7ca594055@ti.com>

On Tue, Jun 25, 2024 at 05:23:22PM -0500, Andrew Davis wrote:
> On 6/25/24 2:46 PM, Jan Kiszka wrote:
> > On 25.06.24 18:49, Andrew Davis wrote:
> > > On 6/25/24 11:45 AM, Andrew Davis wrote:
> > > > This node contains a child which is only probed if simple-mfd is in the
> > > > compatible list. Add this here.
> > > > 
> > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > ---
> > > 
> > > This patch depends on https://www.spinics.net/lists/kernel/msg5253666.html
> > > 
> > 
> > But is that patch already scheduled for 6.10 as well?
> 
> I don't think so.. But only [patch 2/2] from this series needs applied
> back to 6.10 to fix the issue. This one [Patch 1/2] just removes a dts warning.

Both or none should be applied...

Rob

