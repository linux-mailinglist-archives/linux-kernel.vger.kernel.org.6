Return-Path: <linux-kernel+bounces-288712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2F953DE4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04DE1287B51
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 23:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1A5155747;
	Thu, 15 Aug 2024 23:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="dt3XvO5R"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8394370;
	Thu, 15 Aug 2024 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723764446; cv=none; b=T0SttavuBukT+JnHM+nZyE2xKI5rnkgQjyPDFKjC1WqD/feDIXnYZQKlxmBFMnd14JBkWHZTrfsmILP0ogTfr0H2KGKyWOoZ7bJBXmyvG0tJBwwT1/5vbv/n7S6SHyIFo/Jx4RjLyJq4a5Jb5odjzA220IaV7W0rAc16KUuyglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723764446; c=relaxed/simple;
	bh=EF+E2COe7oVZ7sfROU6GBcGSKhd8Vrlw1lRrqsceISg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFy9zqpXiHgTxmUbb1rdKD2R0yX9xSxC8GXVf3co47T9QzvJCB7RLsnvtoS862paAjdB7Czu7LJcHvhr8ZhDYHAg0wuHkrlVZzg8fmdS/ysGG0yrANnM9xGE4anZhF+cwa5spSDtNpFDalWqRNpq+R321j0Uj+CSREmv+nSp1D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=dt3XvO5R; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id 95DF940050C0; Thu, 15 Aug 2024 23:26:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su 95DF940050C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1723764419;
	bh=EF+E2COe7oVZ7sfROU6GBcGSKhd8Vrlw1lRrqsceISg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dt3XvO5RfVnqkqhh+l0tfY0fUI/o+7eX8kWAjV9bpxo4Im7E6rTloBzEbHSttwElE
	 EqPaiP79ssAGpQsm5743Or+QqnCrTSoLsi2IaD+YdxbpRXQGLJJAo8K1PrsSAKH/Z9
	 E3avrkpFXn1bNBY3TwkhCplQAK4bqjlyZvrnMQ6qp+30wtXX5nNiLWUQlqrfUS13tD
	 Hl7PUHF46fdXrJC9ZDQV/AyMIjXA3Z+KBOXiG+0s748c3RRN93Gy8z48qPOTwtYStH
	 mBTVbbmrm8DnC6KsC2aYrM8f38XMp9tHY5sfUsaFnyMF7khkyZDEU/Dh8BTRv5KZDp
	 B31MOt8KJydgA==
Date: Thu, 15 Aug 2024 23:26:59 +0000
From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
To: Heiko Stuebner <heiko@sntech.de>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, robh@kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 0/3] Add DTS for NanoPi R2S Plus
Message-ID: <20240815232659.GC25959@ветеран.su>
References: <20240814170048.23816-1-jin@mediatomb.cc>
 <172375308156.820196.16689328819690192699.b4-ty@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172375308156.820196.16689328819690192699.b4-ty@sntech.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Thu, Aug 15, 2024 at 10:18:45PM +0200, Heiko Stuebner wrote:
> On Wed, 14 Aug 2024 17:00:45 +0000, Sergey Bostandzhyan wrote:
> > 
> > here is version 3 of the NanoPi R2S Plus patchset.
> > 
> > * a commit which adds mmc-hs200-1_8v in order to improve eMMC performance has
> >   been included
> > * the licence header has been updated to the newer version, anw now includes
> >   optional MIT licensing
> > 
> > [...]
> 
> Applied, thanks!

Awesome, thank you for the guidance and for staying with me on this! :)

Kind regards,
Sergey


